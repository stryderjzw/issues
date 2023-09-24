defmodule Issues.Cli do
  @default_count 4

  @moduledoc """
  Handle the command line parsing and the dispatch to the various functions that end up generating a table
  of the last _n_ issues for a given GitHub project.
  """


  @doc """
  `argv` can be -h or --help, which returns :help.

  Otherwise it is a github username, project name, and (optionally) the number of entries to format.

  Return a tuple of `{user, project, count}`, or `:help` if the user asked for help.
  """
  def parse_args(argv) do
    OptionParser.parse(argv, switches: [help: :boolean],
                             aliases:  [h: :help],
                             banner: "Usage: issues [options] <username> <project>")
    |> elem(1)
    |> args_to_internal_representation()
  end

  def args_to_internal_representation([user, project, count]) do
    {user, project, String.to_integer(count)}
  end

  def args_to_internal_representation([user, project]) do
    {user, project, @default_count}
  end

  def args_to_internal_representation(_) do
    :help
  end
end
