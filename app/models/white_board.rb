class WhiteBoard < ApplicationRecord
  belongs_to :theme, optional: true
  attr_accessor :white_board

  WhiteBoard::Meta = Struct.new(:fx, :fy)

  def prepare
    return content if content.present?

    # @white_boardを組み立てる
    build_white_board

    @white_board.to_json
  end

  # 新しくノードを追加した時に、json情報を再構築する。
  def rebuild
    # @white_boardを組み立てる
    build_white_board

    # マインドマップ上の位置情報を、新しく組み立てたJSONにマージ
    old = JSON.parse content

    position_map = {}
    old['nodes'].each do |node|
      position_map[node['id']] = {
        fx: node['fx'],
        fy: node['fy']
      }
    end

    parent_map = {}

    @white_board[:nodes].each do |node|
      if position_map[node[:id]].present?
        node[:fx] = position_map[node[:id]][:fx]
        node[:fy] = position_map[node[:id]][:fy]
      else
        parent_pos = position_map[parent_map[node[:id]]]
        node[:fx] = parent_pos[:fx]
        node[:fy] = parent_pos[:fy] - 150
      end
    end
    @white_board.to_json
  end

  private

  def root_node_id_prefix
    'root_'
  end

  # ノードのID rootノード(Theme)の場合、prefixがつく
  def node_id(node)
    if node.is_a?(Theme)
      "#{root_node_id_prefix}#{node.id}"
    else
      node.id.to_s
    end
  end

  def default_position
    {
      fx: -10,
      fy: -300
    }
  end

  def node_position(idea, parent)
    @node_position_map[idea.depth] = [] if @node_position_map[idea.depth].blank?

    x_distance = 500
    y_distance = 200
    fx = nil
    fy = nil

    if idea.depth.zero?
      fy = -y_distance * 2
      fx = (idea.depth + 1) * x_distance
      fy += y_distance * idea.theme.ideas.select { |i| i.depth.zero? }.index(idea)
      idea.white_board_meta.fx = fx
      idea.white_board_meta.fy = fy
    else
      # binding.pry if idea.depth == 1
      fx = (idea.depth + 1) * x_distance
      fy = parent.white_board_meta.fy.to_i
      fy += y_distance while @node_position_map[idea.depth].include?(fy)
      @node_position_map[idea.depth] << fy
    end

    {
      fx: fx,
      fy: fy
    }
  end

  def build_white_board
    @white_board = {}
    # マインドマップのタイトル
    @white_board[:title] = theme.title
    # 各ノード情報を格納する。
    @white_board[:nodes] = []

    # root_node: テーマ（Theme）
    # id属性はDBのidカラムの値。ただしroot_nodeに関してはIdeaテーブルと
    # IDがかぶる可能性があるためprefixをつける。
    # fx, fyはマインドマップ上の位置。 fx: -10, fy: -300で代替真ん中くらいの位置となる
    @white_board[:nodes] << {
      id: "#{root_node_id_prefix}#{theme.id}",
      text: theme.title,
      is_root: true
    }.merge(default_position)

    @node_position_map = {}

    # 再帰で@white_boardを組み立てる
    _build_white_board(theme.ideas.arrange, theme)
  end

  # @white_boardを組み立てる
  def _build_white_board(ideas, parent)
    ideas.map do |idea, sub_ideas|
      position = node_position(idea, parent)
      idea.white_board_meta.fx = position[:fx]
      idea.white_board_meta.fy = position[:fy]

      @white_board[:nodes] << {
        id: idea.id.to_s,
        text: idea.title,
        is_root: false
      }.merge(position)

      _build_white_board(sub_ideas, idea)
    end
  end
end

# {
#   'title': 'learn anything - programming - programming languages - python',
#   'nodes': [{
#     'id': '1',
#     'text': 'aaabbb',
#     'fx': -13.916222252976013,
#     'fy': -659.1641376795345
#   },
#   'nodes': [{
#     'id': '4',
#     'text': 'cccddd',
#     'fx': -13.916222252976013,
#     'fy': -609.1641376795345
#   }
#   ],
#   'connections': [{
#     'source': '1',
#     'target': '4',
#     'curve': {
#       'x': 0,
#       'y': 0
#     }
#   }
#   ]
# }
