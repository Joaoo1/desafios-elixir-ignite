defmodule GithubReposWeb.UsersController do
  use GithubReposWeb, :controller

  alias GithubRepos.User
  alias GithubReposWeb.FallbackController
  alias GithubReposWeb.Auth.Guardian
  alias GithubRepos.Users.Create, as: UserCreate

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- UserCreate.call(params),
         {:ok, token, _claims} <- Guardian.encode_and_sign(user, %{}, ttl: {1, :minute}) do
      conn
      |> put_status(:created)
      |> render("create.json", token: token, user: user)
    end
  end
end
