defmodule GithubReposWeb.UserReposView do
  use GithubReposWeb, :view

  alias GithubRepos.UserRepo

  def render("repos.json", %{repos: repos}) do
    %{repos: Enum.map(repos, &UserRepo.build(&1))}
  end
end
