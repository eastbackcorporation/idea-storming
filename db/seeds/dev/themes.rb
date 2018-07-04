# frozen_string_literal: true

100.times do |index|
  theme = Theme.new(
    title: "テスト #{index + 1}",
    description: "内容 #{index + 1}...............",
    category_id: Category.roots.sample.id,
    owner: User.where(is_admin: false).sample
  )
  rand(3).times do |r|
    theme.tags << Tag.find_or_initialize_by(name: "タグ #{r}")
  end
  theme.save!
end
