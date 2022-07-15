defmodule GithubReposWeb.UsersView do
  use GithubReposWeb, :view

  alias GithubRepos.User

  def render("create.json", %{token: token, user: %User{} = user}) do
    %{
      message: "User created",
      token: token,
      user: user
    }
  end
end
