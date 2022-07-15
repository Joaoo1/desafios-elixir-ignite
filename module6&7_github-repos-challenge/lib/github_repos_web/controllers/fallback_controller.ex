defmodule GithubReposWeb.FallbackController do
  use GithubReposWeb, :controller

  alias GithubReposWeb.ErrorView
  alias GithubRepos.Error

  def call(conn, {:error, %Error{status: status, result: result}}) do
    conn
    |> put_status(status)
    |> put_view(ErrorView)
    |> render("error.json", result: result)
  end
end
