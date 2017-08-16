-ifdef(DEBUG).
-define(DBG(Str, Args), debug(Str, Args, ?MODULE)).

debug(String, Args, Module) ->
    io:format("DEBUG(~p)~p: " ++ String, [Module, self() | Args]).
-else.
-define(DBG(_Str, _Args),
        {ok}).
-endif.

