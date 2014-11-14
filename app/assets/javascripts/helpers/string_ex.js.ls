class Apiv1.StringEx
  @keyify = (s) ->
    (s || "")
    |> ( .trim! ) 
    |> Apiv1.StringEx.wordify-comma
    |> Apiv1.StringEx.wordify-period
    |> Apiv1.StringEx.kill-useless-crap
    |> Apiv1.StringEx.unify-spaces
    |> Apiv1.StringEx.underscorify

  @wordify-comma = (s) ->
    s.split(/\s*,+\s*/).join " comma "
  @wordify-period = (s) ->
    s.split(/\s*\.+\s*/).join " period "
  @kill-useless-crap = (s) ->
    s.split("").filter ( is /[a-z0-9\s]/i )
    |> ( .join "" )
  @unify-spaces = (s) ->
    s.split(/\s+/).join " "
  @underscorify = (s) ->
    s.split(/[\s\-]/).join "_"
