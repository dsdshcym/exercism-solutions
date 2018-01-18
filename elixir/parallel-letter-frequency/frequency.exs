defmodule Frequency do
  alias Frequency.Pool
  alias Frequency.Worker

  @doc """
  Count letter frequency in parallel.

  Returns a map of characters to frequencies.

  The number of worker processes to use can be set with 'workers'.
  """
  @spec frequency([String.t()], pos_integer) :: map
  def frequency([], _workers), do: []

  def frequency(texts, workers) do
    {:ok, pool} = Pool.start_link(Worker, workers)

    pool
    |> Pool.run(texts)
  end

  defmodule Worker do
    def start_link() do
      spawn_link(fn -> loop() end)
    end

    def loop() do
      receive do
        {:run, text, caller} ->
          send(caller, {:worker_result, run(text)})

          loop()
      end
    end

    defp run(text) do
      text
      |> clean_text()
      |> count_letter()
    end

    defp clean_text(text) do
      text
      |> String.replace(~r/[^\pL]/u, "")
      |> String.downcase()
    end

    defp count_letter(text) do
      text
      |> String.graphemes()
      |> Enum.map(&%{&1 => 1})
      |> Enum.reduce(%{}, &merge_results/2)
    end

    defp merge_results(map1, map2) do
      Map.merge(map1, map2, fn _k, v1, v2 -> v1 + v2 end)
    end
  end

  defmodule Pool do
    defstruct workers: [], results: %{}, remaining_results_count: 0, caller: nil

    def start_link(worker_module, limit) do
      workers = Enum.map(1..limit, fn _ -> worker_module.start_link() end)
      pool = %Pool{workers: workers}

      {:ok, spawn_link(fn -> loop(pool) end)}
    end

    def run(pid, args) do
      send(pid, {:run, args, self()})

      receive do
        {:results, results} -> results
      after
        5000 -> {:error, :timeout}
      end
    end

    def loop(%Pool{remaining_results_count: 0, results: results, caller: caller})
        when not is_nil(caller),
        do: send(caller, {:results, results})

    def loop(pool) do
      receive do
        {:run, args, caller} ->
          args
          |> Stream.zip(Stream.cycle(pool.workers))
          |> Stream.map(fn {arg, worker} -> send(worker, {:run, arg, self()}) end)
          |> Stream.run()

          loop(%Pool{pool | results: %{}, remaining_results_count: length(args), caller: caller})

        {:worker_result, result} ->
          loop(%Pool{
            pool
            | results: merge_results(result, pool.results),
              remaining_results_count: pool.remaining_results_count - 1
          })
      end
    end

    defp merge_results(map1, map2) do
      Map.merge(map1, map2, fn _k, v1, v2 -> v1 + v2 end)
    end
  end
end
