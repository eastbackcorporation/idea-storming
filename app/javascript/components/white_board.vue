<template>
  <div id="white-board-mount-point">
    <white-board
      :nodes="nodes"
      :connections="connections"
      :editable="true"
      @update-event="updateIdeas"
      @add-node-event="openAddIdeaForm"
      ref="myMindmap"
    />
  </div>
</template>

<script>
import WhiteBoard from '../lib/white_board'
export default {
  components: {
    WhiteBoard
  },
  data: function () {
    var json = JSON.parse(document.getElementById('white_board_content').value)
    return {
      title: json['title'],
      nodes: json['nodes'],
      connections: []
    };
  },
  methods: {
    updateIdeas (nodesJson) {
      var json = JSON.parse(document.getElementById('white_board_content').value)
      json['nodes'] = nodesJson['nodes'];
      // hiddenで持っている保存用フィールドにjsonを入れて、Ajaxでフォームをサブミットする。
      document.getElementById('white_board_content').value = JSON.stringify(json);
      document.getElementById('save_white_board_form').submit();
    },
    openAddIdeaForm (id) {
      if (isNaN(id)) {
        // noop idが文字列の場合はテーマにアイディアを追加するパターン（例: root_123）
      } else {
        // idが数値の場合はアイディアにアイディアを追加するパターン（例: 123）
        document.getElementById('idea_id').value = id;
      }
      // 新規アイディア追加フォームを開く（Rails側で処理）
      Rails.fire(document.getElementById('add-idea-form'), 'submit')
    },
    refreshMindMap () {
      var json = JSON.parse(document.getElementById('white_board_content').value)
      console.log(this.nodes, json['nodes'], this.connections, json['connections'])
      this.nodes = json['nodes']
      this.connections = []
      // FIXME: 少し時間をおかないと画面が正しく更新されない
      var self = this
      setTimeout( function() {
          self.$refs.myMindmap.renderMap()
      }, 300 );

    }
  }
}
</script>

<style scoped>
</style>
