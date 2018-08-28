import Vue from 'vue';
import MindMap from 'components/mind_map.vue'
import WhiteBoard from 'components/white_board.vue'

Vue.config.productionTip = false

document.addEventListener('DOMContentLoaded', () => {
  if (document.getElementById('mind-map-mount-point')) {
    // マインドマップ
    var vm = new Vue({
      el: '#mind-map-mount-point',
      render: h => h(MindMap)
    });

    $(document).on('change', '#mind_map_content', function(){
      console.log('mind_map_changed')
      vm.$children[0].refreshMindMap()
    });
  } else if (document.getElementById('white-board-mount-point')) {
    // ホワイトボード
    var vm = new Vue({
      el: '#white-board-mount-point',
      render: h => h(WhiteBoard)
    });

    $(document).on('change', '#white_board_content', function(){
      console.log('white_board_changed')
      vm.$children[0].refreshMindMap()
    });
  }
});
