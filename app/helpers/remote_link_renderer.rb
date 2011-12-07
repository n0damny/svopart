class RemoteLinkRenderer < WillPaginate::ViewHelpers::LinkRenderer

  def link(text, target, attributes = {})
    attributes["date-remote"] = true
    super
  end
end
