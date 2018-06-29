# frozen_string_literal: true

#
# 画面表示用のメッセージ(ActiveRecordのerrorsやflash）を表示するヘルパー
#
module MessageHelper
  def error_messages(errors)
    return nil if errors.blank?
    messages = errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    html = <<-HTML
    <div id="error_explanation" class='alert alert-danger'>
      <button type="button" class="close" data-dismiss="alert" aria-label="Close">
        <span aria-hidden="true">&times;</span>
      </button>
      <ul>#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end

  def flash_messages
    return nil if flash.blank?
    content = ''
    flash.each do |name, msg|
      klass_name = 'info' if name == 'notice'
      klass_name = 'danger' if %w[error alert].include?(name)
      klass_name = 'success' if %w[success].include?(name)
      klass_name = 'warning' if %w[warning].include?(name)
      content +=
        content_tag(:div, id: "flash_#{name}", class: "alert alert-#{klass_name}") do
          concat(content_tag(:button, type: 'button', class: 'close', 'data-dismiss': 'alert', 'aria-label': 'close') do
            content_tag(:span, 'aria-hidden': 'true') do
              '&times;'.html_safe
            end
          end)
          concat content_tag(:span, msg)
        end
    end
    content.html_safe
  end
end
