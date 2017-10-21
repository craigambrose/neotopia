module App.API.Conversation exposing (startConversation, sendInput)

import App.Messages exposing (..)
import App.Models.Index exposing (Input)
import Jwt
import Http
import App.Models.Conversation exposing (Message)
import App.API.Conversation.Decoders exposing (decodeExchange)
import App.API.Conversation.Encoders exposing (encodeInput)
import Json.Decode exposing (Decoder)


startConversation : Cmd Msg
startConversation =
    let
        url =
            "http://localhost:4000/api/chat"

        request =
            Http.get url decodeExchange
    in
        Http.send ReceiveMessage request


sendInput : Maybe String -> Message -> Input -> Cmd Msg
sendInput authToken message input =
    let
        url =
            "http://localhost:4000/api/chat"

        body =
            encodeInput input message.id |> Http.jsonBody

        request =
            post authToken url body decodeExchange
    in
        Http.send ReceiveMessage request


post : Maybe String -> String -> Http.Body -> Decoder a -> Http.Request a
post authToken url body decoder =
    case authToken of
        Nothing ->
            Http.post url body decoder

        Just authToken ->
            Jwt.post authToken url body decoder
