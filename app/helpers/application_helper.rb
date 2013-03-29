module ApplicationHelper
  # returns the full title on a per-page basis
  def full_title(page_title)
    base_title = "TSP Project Spring 2013"
    if page_title.empty?
    base_title
    else
      "#{base_title} | #{page_title}"
    end
  end
end
