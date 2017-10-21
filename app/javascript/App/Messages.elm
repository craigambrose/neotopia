module App.Messages exposing (..)

import Time exposing (Time)
import Material
import Http exposing (Error)
import App.Models.Conversation exposing (Exchange, Message)


type Msg
    = MessageAnimationTick Time
    | ReceiveMessage (Result Http.Error Exchange)
    | InputResponse String String
    | SubmitResponse (Maybe String)
    | Mdl (Material.Msg Msg)
