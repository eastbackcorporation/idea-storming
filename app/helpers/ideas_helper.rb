# frozen_string_literal: true

module IdeasHelper
  def nested_ideas(ideas)
    ideas.map do |idea, sub_ideas|
      render('themes/ideas/idea', idea: idea, sub_ideas: nested_ideas(sub_ideas))
    end.join.html_safe
  end

  def first_idea?(idea)
    first_sibling_idea?(idea) || (idea.parent.blank? && first_sibling_idea?(idea))
  end

  def last_idea?(idea)
    return false if !last_sibling_idea?(idea) && leaf_idea?(idea)
    return true  if last_sibling_idea?(idea)
    return true  if leaf_idea?(idea)
    false
  end

  private

  def first_sibling_idea?(idea)
    if idea.parent.blank?
      theme_id = idea.theme.id
      idea.siblings.where(theme_id: theme_id).pluck(:id).min == idea.id
    else
      idea.sibling_ids.min == idea.id
    end
  end

  def last_sibling_idea?(idea)
    if idea.parent.blank?
      theme_id = idea.theme.id
      idea.siblings.where(theme_id: theme_id).pluck(:id).max == idea.id
    else
      idea.sibling_ids.max == idea.id
    end
  end

  def leaf_idea?(idea)
    idea.children.blank?
  end
end
