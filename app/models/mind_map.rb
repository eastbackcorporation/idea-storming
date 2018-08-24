# frozen_string_literal: true

# == Schema Information
#
# Table name: mind_maps
#
#  id           :bigint(8)        not null, primary key
#  theme_id     :bigint(8)        not null
#  content :json
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class MindMap < ApplicationRecord
  belongs_to :theme, optional: true
  attr_accessor :mind_map

  MindMap::Meta = Struct.new(:fx, :fy, :degrees)

  def prepare
    return content if content.present?

    # @mind_mapを組み立てる
    build_mind_map

    @mind_map.to_json
  end

  # 新しくノードを追加した時に、json情報を再構築する。
  def rebuild
    # @mind_mapを組み立てる
    build_mind_map

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
    @mind_map[:connections].each do |node|
      parent_map[node[:target]] = node[:source]
    end

    @mind_map[:nodes].each do |node|
      if position_map[node[:id]].present?
        node[:fx] = position_map[node[:id]][:fx]
        node[:fy] = position_map[node[:id]][:fy]
      else
        parent_pos = position_map[parent_map[node[:id]]]
        node[:fx] = parent_pos[:fx]
        node[:fy] = parent_pos[:fy] - 150
      end
    end
    @mind_map.to_json
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
      idea.mind_map_meta.fx = fx
      idea.mind_map_meta.fy = fy
    else
      # binding.pry if idea.depth == 1
      fx = (idea.depth + 1) * x_distance
      fy = parent.mind_map_meta.fy.to_i
      fy += y_distance while @node_position_map[idea.depth].include?(fy)
      @node_position_map[idea.depth] << fy
    end

    {
      fx: fx,
      fy: fy
    }
  end

  def build_mind_map
    @mind_map = {}
    # マインドマップのタイトル
    @mind_map[:title] = theme.title
    # 各ノード情報を格納する。
    @mind_map[:nodes] = []
    # ノード間のリンク情報を格納する。
    @mind_map[:connections] = []

    # root_node: テーマ（Theme）
    # id属性はDBのidカラムの値。ただしroot_nodeに関してはIdeaテーブルと
    # IDがかぶる可能性があるためprefixをつける。
    # fx, fyはマインドマップ上の位置。 fx: -10, fy: -300で代替真ん中くらいの位置となる
    @mind_map[:nodes] << {
      id: "#{root_node_id_prefix}#{theme.id}",
      text: theme.title,
      is_root: true
    }.merge(default_position)

    @node_position_map = {}

    # 再帰で@mind_mapを組み立てる
    _build_mind_map(theme.ideas.arrange, theme)
  end

  # @mind_mapを組み立てる
  def _build_mind_map(ideas, parent)
    ideas.map do |idea, sub_ideas|
      position = node_position(idea, parent)
      idea.mind_map_meta.fx = position[:fx]
      idea.mind_map_meta.fy = position[:fy]
      idea.mind_map_meta.degrees = position[:degrees]

      @mind_map[:nodes] << {
        id: idea.id.to_s,
        text: idea.title,
        is_root: false
      }.merge(position)

      # source: つながり元のノード
      # target: つながり先のノード
      # curve:  ノード間をつなぐ線のカーブの曲線具合
      @mind_map[:connections] << {
        source: node_id(parent),
        target: node_id(idea),
        curve: {
          x: 0,
          y: 0
        }
      }

      _build_mind_map(sub_ideas, idea)
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
