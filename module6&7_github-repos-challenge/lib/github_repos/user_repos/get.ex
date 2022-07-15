defmodule GithubRepos.UserRepos.Get do
  alias GithubRepos.Github.Client

  def by_username(username), do: Client.get_user_repos(username)
end
