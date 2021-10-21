module ApplicationHelper
  def this_year
    Date.today.year
  end

  def github_url(author, repo)
    link_to author, "https://github.com/#{author}/#{repo}"
  end
end
