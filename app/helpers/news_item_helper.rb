module NewsItemHelper
  def news_item_heading
    case self.news_itemable_type
    when "Comment"
      "Comment"
    when "Project"
      "Status Update"
    end
  end
end