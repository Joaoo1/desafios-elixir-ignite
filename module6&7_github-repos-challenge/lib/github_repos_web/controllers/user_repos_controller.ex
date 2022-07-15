defmodule GithubReposWeb.UserReposController do
  use GithubReposWeb, :controller

  alias GithubReposWeb.FallbackController

  action_fallback FallbackController

  def list(conn, %{"username" => username}) do
    with {:ok, repos} <- GithubRepos.get_user_repos(username) do
      conn
      |> put_status(:ok)
      |> render("repos.json", repos: repos)
    end
  end
end
