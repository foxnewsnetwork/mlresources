class Tranny
  # Example for arrays
  # step serves as a default constructor, pop, and push
  @array-step = (xs, x) ->
    switch arguments.length
    # step :: []
    case 0
      []
    # step :: xs -> [xs, x]
    case 1
      [head, ...tail] = xs
      [tail, head]
    # step :: (xs, x) -> xs
    default
      xs[*] = x
      xs


  # step :: xs -> [xs, x]
  @reducing = (reduceable, reducer, init) ->
    (step) ->
      [maybe-rest, element] = step reduceable
      if maybe-rest
        step |> Tranny.reducing maybe-rest, reducer, reducer(init, element)
      else
        reducer init, element

  # step :: (xs, x) -> xs
  # step :: []
  @mapping = (mappable, mapper) ->
    (step) ->
      reducer = (mapped, element) -> step mapped, mapper element
      step |> Tranny.reducing mappable, reducer, step!

  # step :: (xs, x) -> xs
  # step :: []
  @filtering = (filterable, cutoff) ->
    (step) ->
      reducer = (filtered, element) ->
        if cutoff element
          step filtered, element
        else
          filtered
      step |> Tranny.reducing filterable, reducer, step!

  # Not implemented with reduce because laziness reasons
  @taking = (takeable, n) ->
    (step) ->
      return step! if n <= 0
      [rest, element] = step takeable
      step |> Tranny.taking rest, n-1 |> (taken) -> step taken, element
