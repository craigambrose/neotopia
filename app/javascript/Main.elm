module Main exposing (..)

import Html exposing (Html)
import App.Messages exposing (..)
import App.Models.Index exposing (..)
import App.Views.Index exposing (..)
import App.Update exposing (..)
import App.Subscriptions exposing (..)
import App.API.Conversation exposing (startConversation)


init : ( Model, Cmd Msg )
init =
    ( initialModel
    , startConversation
    )


main : Program Never Model Msg
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
