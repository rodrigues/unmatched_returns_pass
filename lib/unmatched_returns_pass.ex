defmodule UnmatchedReturnsPass do
  def hello do
    # the line below fails unmatched_return:
    ## DateTime.utc_now()
    # lib/unmatched_returns_pass.ex:4:unmatched_return
    # The expression produces a value of type:
    #
    # %DateTime{
    #   :calendar => atom(),
    #   :day => pos_integer(),
    #   :hour => non_neg_integer(),
    #   :microsecond => {non_neg_integer(), non_neg_integer()},
    #   :minute => non_neg_integer(),
    #   :month => pos_integer(),
    #   :second => non_neg_integer(),
    #   :std_offset => integer(),
    #   :time_zone => binary(),
    #   :utc_offset => integer(),
    #   :year => integer(),
    #   :zone_abbr => binary()
    # }
    #
    # but this value is unmatched.


    # these calls also fail:
    ## utc_now()
    ## Application.ensure_loaded(:thingy)

    # but these pass without matching return
    # they can return `:ok`
    # but also other things
    foo()
    foo(41)
    foo(42)

    # these are very similar to foo but fail
    # because instead of `:ok` they might return `{:ok, xyz}`
    # and the other same things
    ## foo2()
    ## foo2(41)
    ## foo2(42)

    # these dynamic calls also pass without matching return
    lol().utc_now()
    bar().utc_now()
    me().foo()
    me().foo2()

    :ok
  end

  def lol do
    Application.get_env(:unmatched_returns_pass, :lol, DateTime)
  end

  def foo do
    if :random.uniform(42) > 21 do
      :ok
    else
      :error
    end
  end

  def foo(n) when n == 42, do: :ok
  def foo(_), do: :error

  def bar do
    DateTime
  end

  def utc_now do
    DateTime.utc_now()
  end

  def foo2 do
    if :random.uniform(42) > 21 do
      # the difference to foo: it returns an ok tuple
      {:ok, :yes}
    else
      :error
    end
  end

  def foo2(n) when n == 42, do: {:ok, n}
  def foo2(_), do: :error

  defp me, do: __MODULE__
end
