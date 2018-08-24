/*!
 * vue-mindmap v0.0.4
 * (c) 2018 Antério vieira
 * Released under the MIT License.
 */

/*
 * Return the HTML representation of a node.
 * The node is an object that has text, url, and category attributes
 * all of them optional.
 */
export default (node) => {
  if (node.is_root) {
    return `
      <div class="card border-primary">
        <div class="card-header">テーマ</div>
        <div class="card-body">
        <h4 id="node-${node.index}" class="card-title">${node.text || ''} </h4>
          <button class="btn btn-sm btn-primary addIdea" data-node-id=${node.id}>アイディアを投稿</button>
          <button
            type="button" class="btn btn-sm btn-success"
            data-toggle="tooltip" data-html="true"
            title="<p>テストユーザ<p><p>2018/8/20</p><img src=&quot;https://placeimg.com/100/100/animals&quot;>">
            <i class="fa fa-info-circle" aria-hidden="true"></i>
          </button>
        </div>
      </div>`
  } else {
    return `
      <div class="card">
        <div class="card-body">
        <h4 id="node-${node.index}" class="card-title">${node.text || ''} </h4>
          <button class="btn btn-sm btn-primary addIdea" data-node-id=${node.id}>派生アイディアを投稿</button>
          <button
            type="button" class="btn btn-sm btn-success"
            data-toggle="tooltip" data-html="true"
            title="<p>テストユーザ<p><p>2018/8/20</p><img src=&quot;https://placeimg.com/100/100/animals&quot;>">
            <i class="fa fa-info-circle" aria-hidden="true"></i>
          </button>
        </div>
      </div>`
  }
}
