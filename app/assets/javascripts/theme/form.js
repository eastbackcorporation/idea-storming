ThemeForm = function() {}

ThemeForm.prototype.render = function() {
  $('input#theme_tags').tagsinput({
    onTagExists: function(item, tag) {
      return;
    }
  });
};

$(function(){
  var theme_form = new ThemeForm();
  theme_form.render();
});
