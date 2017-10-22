module Main exposing (..)

import Html exposing (Html)
import App.Messages exposing (..)
import App.Models.Index exposing (..)
import App.Views.Index exposing (..)
import App.Update exposing (..)
import App.Subscriptions exposing (..)
import App.API.Conversation exposing (startConversation)


init : AppConfig -> ( Model, Cmd Msg )
init config =
    ( initialModel config
    , startConversation config.baseUrl
    )


main : Program AppConfig Model Msg
main =
    Html.programWithFlags
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
