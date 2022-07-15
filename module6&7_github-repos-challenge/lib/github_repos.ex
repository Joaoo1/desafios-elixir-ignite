defmodule GithubRepos do
  alias GithubRepos.UserRepos.Get, as: UserReposGet

  defdelegate get_user_repos(username), to: UserReposGet, as: :by_username
end
