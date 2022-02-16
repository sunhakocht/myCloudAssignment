module ApplicationHelper
  def display_sub_categories(category)
    sub_categories = category.sub_categories
    return "" if sub_categories.empty?
    return sub_categories.map { |sc| sc.name }.join ", "
  end

  def display_categories(product)
    categories = product.categories
    return "" if categories.empty?
    return categories.map { |c| c.name }.join ", "
  end

end
