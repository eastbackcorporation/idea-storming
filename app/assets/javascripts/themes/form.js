ThemeForm = function() {}

ThemeForm.prototype.render = function() {
  $('input#theme_tags').tagsinput({
    onTagExists: function(item, tag) {
      return;
    }
  });

  // set main theme image event
  $('.image-star').on('click', function(e){
    e.preventDefault();
    var selected_image_id = $(this).data('image-id');
    $.each($('.image-star'), function(idx, el){
      if($(el).data('image-id') !== selected_image_id) {
        $(el).children().removeClass('active');
      }
    });

    var icon = $(this).children().toggleClass('active');

    if (icon.hasClass('active')) {
      $('#theme_main_image_id').val($(this).data('image-id'));
    } else {
      $('#theme_main_image_id').val('');
    }
  });

  // delete image event
  $('.image-delete').on('click', function(e){
    e.preventDefault();
    var id = $(this).data('image-id');
    $("#image_" + id + "_destroy_checkbox").prop('checked', true);
    $('#image_' + id).hide();
  });
};

$(function(){
  var theme_form = new ThemeForm();
  theme_form.render();
});
