defmodule WelcomeWorld.Repo do
  use Ecto.Repo,
    otp_app: :welcome_world,
    adapter: Ecto.Adapters.Postgres
end
