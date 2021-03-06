module ProdutosHelper
  def sort_link(column, title = nil)
    title ||= column.titleize
    direction = column == sort_column && sort_direction == 'asc' ? 'desc' : 'asc'
    icon = sort_direction == 'asc' ? 'glyphicon glyphicon-chevron-up' : 'glyphicon glyphicon-chevron-down'
    icon = column == sort_column ? icon : ''
    link_to "#{title} <span class='#{icon}'></span>".html_safe, params.merge(column: column, direction: direction).permit(:column, :direction, :nome, :page, :per_page, :utf8)
  end

  def set_per_page_results(per_page)
    link_to "#{per_page}".html_safe, params.merge(per_page: per_page).permit(:column, :direction, :nome, :page, :per_page, :utf8)
  end
end
