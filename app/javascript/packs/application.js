import "babel-polyfill"
import Vue from 'vue';
import MindMap from 'components/mind_map.vue'

Vue.config.productionTip = false

document.addEventListener('DOMContentLoaded', () => {
  if (document.getElementById('mindmap-mount-point')) {
    var vm = new Vue({
      el: '#mindmap-mount-point',
      render: h => h(MindMap)
    });

    $(document).on('change', '#mind_map_content', function(){
      console.log('mind_map_changed')
      vm.$children[0].refreshMindMap()
    });
  } else if (document.getElementById('whiteboard-mount-point')) {

  }
});
