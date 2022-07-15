defmodule GithubRepos.Github.Client do
  use Tesla

  alias GithubRepos.Error

  plug(Tesla.Middleware.BaseUrl, "https://api.github.com/users/")
  plug(Tesla.Middleware.Headers, [{"User-Agent", "GithubRepos"}])
  plug(Tesla.Middleware.JSON)

  def get_user_repos(username) do
    "#{username}/repos"
    |> get()
    |> handle_get()
  end

  defp handle_get({:ok, %Tesla.Env{status: 200, body: body}}) do
    {:ok, body}
  end

  defp handle_get({:ok, %Tesla.Env{status: 404, body: _body}}) do
    {:error, Error.build(:bad_request, "Invalid username!")}
  end

  defp handle_get({:error, reason}) do
    {:error, Error.build(:bad_request, reason)}
  end
end
