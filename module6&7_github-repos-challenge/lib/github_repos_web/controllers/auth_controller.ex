defmodule GithubReposWeb.AuthController do
  use GithubReposWeb, :controller

  alias GithubReposWeb.FallbackController
  alias GithubReposWeb.Auth.Guardian

  action_fallback FallbackController

  def authenticate(conn, params) do
    with {:ok, token} <- Guardian.authenticate(params) do
      conn
      |> put_status(:ok)
      |> render("sign_in.json", token: token)
    end
  end
end
