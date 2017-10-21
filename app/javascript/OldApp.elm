module App exposing (..)

import App.Messages exposing (..)
import App.Models.Index exposing (..)
import App.Views.Index exposing (..)
import App.Update exposing (..)
import App.Subscriptions exposing (..)
import Html exposing (program)
import App.API.Conversation exposing (startConversation)


init : ( Model, Cmd Msg )
init =
    ( initialModel
    , startConversation
    )


main : Program Never Model Msg
main =
    program
        { view = view
        , init = init
        , update = update
        , subscriptions = subscriptions
        }
