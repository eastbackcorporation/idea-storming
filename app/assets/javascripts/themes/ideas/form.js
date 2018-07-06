IdeaForm = function() {}

IdeaForm.prototype.render = function() {
  $(".idea-add-new").off('click');
  $(".idea-add-new").on('click', function(){
    $('.idea-form').slideToggle(100);
  });

  $(".idea-add-close").off('click');
  $(".idea-add-close").on('click', function(){ $('.idea-form').slideToggle(100); });
};

$(function(){
  var idea_form = new IdeaForm();
  idea_form.render();
});
