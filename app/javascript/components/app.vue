<template>
  <div id="mount-point">
    <mindmap
      :nodes="nodes"
      :connections="connections"
      :editable="true"/>
  </div>
</template>

<script>
import map from "data/map";

var theme = document.getElementById('app').getAttribute('theme');
var json = JSON.parse(theme)
console.log(json)
export default {
  data: function () {
    return { ...map };
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
