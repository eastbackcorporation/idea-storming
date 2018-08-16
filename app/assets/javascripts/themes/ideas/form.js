IdeaForm = function() {}

IdeaForm.prototype.render = function() {
  // アイディアの新規追加ポップアップフォーム
  $(".idea-add-new").off('click');
  $(".idea-add-new").on('click', function(){
    $('.idea-form').slideToggle(100);
  });

  $(".idea-add-close").off('click');
  $(".idea-add-close").on('click', function(){ $('.idea-form').slideToggle(100); });

  $(document).on('click', '.themes-ideas-idea-minus,.themes-ideas-idea-plus', function(){
    $('#overlay').show().spin("large", "white");
  });
};

$(function(){
  var idea_form = new IdeaForm();
  idea_form.render();
});
