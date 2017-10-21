module App.API.Conversation.Encoders exposing (..)

import Json.Encode as Encode exposing (..)
import App.Models.Index exposing (..)


encodeInput : Input -> String -> Encode.Value
encodeInput input parentMessageID =
    let
        reply =
            encodeReply input parentMessageID
    in
        Encode.object
            [ ( "reply", reply )
            ]


encodeReply : Input -> String -> Encode.Value
encodeReply input parentMessageID =
    Encode.object
        [ ( "to", Encode.string parentMessageID )
        , ( "input", encodeInputValues input )
        ]


encodeInputValues : Input -> Encode.Value
encodeInputValues input =
    Encode.object (List.map encodeInputTuple input)


encodeInputTuple : InputTuple -> ( String, Value )
encodeInputTuple inputTuple =
    ( Tuple.first inputTuple, Encode.string (Tuple.second inputTuple) )
