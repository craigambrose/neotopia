module App.API.Conversation exposing (startConversation, sendInput)

import App.Messages exposing (..)
import App.Models.Index exposing (Input)
import Jwt
import Http
import App.Models.Conversation exposing (Message)
import App.API.Conversation.Decoders exposing (decodeExchange)
import App.API.Conversation.Encoders exposing (encodeInput)
import Json.Decode exposing (Decoder)


apiHost : String
apiHost =
    "http://localhost:3000"


endpoint : String -> String
endpoint baseUrl =
    baseUrl ++ "/api/chat"


startConversation : String -> Cmd Msg
startConversation baseUrl =
    let
        request =
            Http.get (endpoint baseUrl) decodeExchange
    in
        Http.send ReceiveMessage request


sendInput : String -> Maybe String -> Message -> Input -> Cmd Msg
sendInput baseUrl authToken message input =
    let
        body =
            encodeInput input message.id |> Http.jsonBody

        request =
            post authToken (endpoint baseUrl) body decodeExchange
    in
        Http.send ReceiveMessage request


post : Maybe String -> String -> Http.Body -> Decoder a -> Http.Request a
post authToken url body decoder =
    case authToken of
        Nothing ->
            Http.post url body decoder

        Just authToken ->
            Jwt.post authToken url body decoder
