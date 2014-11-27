class Apiv1.TagParser
  _select-text = (tokens) ->
    tokens.filter (token) -> token.name is "text"
  _select-ids = (tokens) ->
    tokens.filter (token) -> token.name is "id"
  _select-proto-taxons = (tokens) ->
    Apiv1.TagParser.Parser.proto-taxons tokens
  @tokenify-taxon = (taxon) ->
    ["+", taxon.get("taxonName"), ":", taxon.get("id")].join ""
  @parse = (text) ->
    new Apiv1.TagParser text
  (@text) ->
  tagTokens: ->
    @text |> Apiv1.TagParser.Lexer.tokenize |> _select-proto-taxons |> ( .map Apiv1.TagParser.tokenify-taxon )
  justText: ->
    @text |> Apiv1.TagParser.Lexer.tokenize |> _select-text |> (tokens) -> _.pluck tokens, "content"
  tagIds: ->
    @text |> Apiv1.TagParser.Lexer.tokenize |> _select-ids |> (tokens) -> _.pluck tokens, "content"

class Apiv1.TagParser.Parser
  @proto-taxons = (tokens) ->
    @parse(tokens).proto-taxons
  @parse = (tokens) ->
    tokens.reduce @tokenReducer, new Apiv1.TagParser.Parser!

  @tokenReducer = (parser, token) ->
    switch token.name
    case "tag"
      parser.tagify token
    case "id"
      parser.idify token
    default
      "defaults to ignoring text"
    parser
  ->
    @state = "tag"
    @proto-taxons = []
    @latest-taxon = null

  tagify: (token) ->
    switch @state
    case "tag"
      @state = "id"
      @latest-token = Ember.ObjectProxy.create content: taxonName: token.content
    default
      throw new Error "expected a tag name but got #{token.name} - #{token.content} instead"
  idify: (token) ->
    switch @state
    case "id"
      @state = "tag"
      @latest-token.set "id", token.content
      @proto-taxons.pushObject @latest-token
    default
      throw new Error "expected a id, but got #{token.name} - #{token.content} instead"


class Apiv1.TagParser.Lexer
  @tokenize = (text) ->
    @lex(text).tokens

  @lex = (text) ->
    "#{text}\n".split("").reduce(@tokenReducer, new Apiv1.TagParser.Lexer!)

  @tokenReducer = (lexer, character) ->
    switch character
    case "+"
      lexer.plus-sign!
    case ":"
      lexer.colon!
    case " "
      lexer.space!
    case "\n"
      lexer.end-of-file!
    default
      lexer.character character
    lexer

  ->
    @state = "space"
    @tokens = []
    @latest-token = null

  end-of-file: ->
    @tokens.push @latest-token if @latest-token
    @latest-token = null
    @state = "finished"

  plus-sign: ->
    switch @state
    case "text"
      @state = "new-tag"
      @tokens.push @latest-token
      @latest-token = new Apiv1.TagParser.Token "tag"
    case "space"
      @state = "new-tag"
      @latest-token = new Apiv1.TagParser.Token "tag"
    case "finished"
      throw new Error "EOF already reached"
    default
      @latest-token.append "+"

  colon: ->
    switch @state
    case "new-tag"
      @state = "new-id"
      @tokens.push @latest-token
      @latest-token = new Apiv1.TagParser.Token "id"
    case "finished"
      throw new Error "EOF already reached"
    default
      @latest-token.append ":"

  space: ->
    switch @state
    case "new-id"
      @state = "space"
      @tokens.push @latest-token
      @latest-token = null
    case "space"
      "skip extra spaces"
    case "finished"
      throw new Error "EOF already reached"
    default
      @latest-token.append " "

  character: (char) ->
    switch @state
    case "space"
      @state = "text"
      @latest-token = new Apiv1.TagParser.Token "text"
      @latest-token.append char
    case "new-id", "new-tag", "text"
      @latest-token.append char
    case "finished"
      throw new Error "Unexpected #{char} after EOF reached"
    default
      throw new Error "Unexpected #{char} for current state: #{@state}"

class Apiv1.TagParser.Token
  @known-tokens = ["text", "tag", "id"]
  (@name) ->
    @content = ""
  append: (char) ->
    @content += char