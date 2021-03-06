class Apiv1.ArrayEx
  # Assumes your array has been presorted
  @greater-weave = (greater-than, xxs, yys) -->
    return xxs unless yys? and yys.length > 0
    return yys unless xxs? and xxs.length > 0
    [x,...xs] = xxs
    [y,...ys] = yys
    if x `greater-than` y
      [y].concat @weave(greater-than, xxs, ys)
    else
      [x].concat @weave(greater-than, xs, yys)

  @lesser-weave = (lesser-than, xxs, yys) ->
    greater-than = (x,y) -> lesser-than y, x
    @greater-weave greater-than, xxs, yys

  # iterates through xs, wherever predicate returns true,
  # the first element of ys is substituted instead
  @replace-concat = (predicate, xxs, yys) -->
    return [] unless xxs? and xxs.length > 0
    return xxs unless yys? and yys.length > 0
    [x,...xs] = xxs
    [y,...ys] = yys
    if predicate x, y
      [y].concat Apiv1.ArrayEx.replace-concat(predicate, xs, ys)
    else
      [x].concat Apiv1.ArrayEx.replace-concat(predicate, xs, yys)

  # creates the cartesian product of xs and ys
  # that is, [x1, x2, x3] * [y1, y2, y3]
  # = [[x1, y1], [x1, y2], [x1, y3], [x2, y1]...]
  # note [] * [x1, x2...] = []
  @product = (xs, ys) ->
    return [] if xs.length is 0 or ys.length is 0
    [x,...xxs] = xs
    x-with-ys = ys.map (y) -> [x,y]
    x-with-ys.concat @product xxs, ys
