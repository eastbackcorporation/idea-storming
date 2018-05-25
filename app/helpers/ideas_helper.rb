# frozen_string_literal: true

module IdeasHelper
  def nested_ideas(ideas)
    ideas.map do |idea, sub_ideas|
      render('themes/ideas/idea', idea: idea, sub_ideas: nested_ideas(sub_ideas))
    end.join.html_safe
  end
end
