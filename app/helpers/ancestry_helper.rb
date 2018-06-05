# frozen_string_literal: true

module AncestryHelper
  # arranged as tree expects 3 arguments. The hash from has_ancestry.arrange() method,
  # options, and a render block
  def arranged_tree_as_list(hash, options = {}, &block)
    options = {
      list_type: :ul,
      ul_class: [],
      ul_class_top: [],
      ul_class_children: [],
      li_class: [],
      li_class_top: [],
      li_class_children: [],
      sort_by: []
    }.merge(options)

    options[:list_style] = ''
    output = ''

    # sort the hash key based on sort_by options array
    unless options[:sort_by].empty?
      hash = Hash[hash.sort_by { |k, _v| options[:sort_by].collect { |sort| k.send(sort) } } ]
    end

    current_depth = 0
    # and here... we... go...
    hash.each do |object, children|
      li_classes = options[:li_class]

      li_classes += if object.depth.zero?
                      options[:li_class_top]
                    else
                      options[:li_class_children]
                    end

      if !children.empty?
        output += content_tag(
          :li, capture(object, &block) + arranged_tree_as_list(children, options, &block).html_safe, class: li_classes
        )
      else
        output += content_tag(:li, capture(object, &block), class: li_classes).html_safe
        current_depth = object.depth
      end
    end

    unless output.blank?

      ul_classes = options[:ul_class]

      ul_classes += if current_depth.zero?
                      options[:ul_class_top]
                    else
                      options[:ul_class_children]
                    end

      output = content_tag(options[:list_type], output.html_safe, class: ul_classes)
    end
  
    output.html_safe
  end

  def ancestry_options(items, &block)
    return ancestry_options(items){ |i| "#{'-' * i.depth} #{i.name}" } unless block_given?

    result = []
    items.map do |item, sub_items|
      result << [yield(item), item.id]
      #this is a recursive call:
      result += ancestry_options(sub_items, &block)
    end
    result
  end
end
