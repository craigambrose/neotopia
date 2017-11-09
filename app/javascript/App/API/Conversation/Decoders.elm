module App.API.Conversation.Decoders exposing (..)

import App.Models.Conversation exposing (..)
import App.Models.Data exposing (..)
import Json.Decode exposing (..)
import Json.Decode.Pipeline exposing (..)


decodeExchange : Decoder Exchange
decodeExchange =
    decode Exchange
        |> required "message" decodeMessage
        |> optional "data" decodeData emptyData


decodeData : Decoder Data
decodeData =
    decode Data
        |> optional "user" (map Just decodeUser) Nothing
        |> optional "token" (map Just string) Nothing


decodeUser : Decoder User
decodeUser =
    decode User
        |> required "id" string
        |> required "name" string
        |> required "logged_in" bool


decodeMessage : Decoder Message
decodeMessage =
    decode Message
        |> required "id" string
        |> optional "prompt" string ""
        |> optional "responder" decodeResponder { config = NoResponder }
        |> optional "url" (map Just string) Nothing


decodeResponder : Decoder Responder
decodeResponder =
    field "responder_type" string
        |> andThen decodeResponderType
        |> andThen
            (\responder_type ->
                decode Responder
                    |> hardcoded responder_type
            )


decodeResponderType : String -> Decoder ResponderConfig
decodeResponderType responder_type =
    case responder_type of
        "text" ->
            map TextResponder textDecoder

        "select_option" ->
            map SelectOptionResponder selectOptionDecoder

        "form" ->
            map FormResponder formDecoder

        "none" ->
            succeed NoResponder

        _ ->
            fail ("Unknown responder type" ++ responder_type)


textDecoder : Decoder TextConfig
textDecoder =
    succeed TextConfig


selectOptionDecoder : Decoder SelectOptionConfig
selectOptionDecoder =
    decode SelectOptionConfig
        |> required "options" (list string)


formDecoder : Decoder FormConfig
formDecoder =
    decode FormConfig
        |> required "fields" (list decodeFormField)
        |> required "buttons" (list decodeFormButton)


decodeFormField : Decoder FormField
decodeFormField =
    decode FormField
        |> required "name" string
        |> required "field_type" decodeFormFieldType


decodeFormFieldType : Decoder FormFieldType
decodeFormFieldType =
    string |> andThen mapFormFieldType


mapFormFieldType : String -> Decoder FormFieldType
mapFormFieldType type_name =
    case type_name of
        "email" ->
            succeed EmailField

        "password" ->
            succeed PasswordField

        _ ->
            fail ("Unknown form field type " ++ type_name)


decodeFormButton : Decoder FormButton
decodeFormButton =
    decode FormButton
        |> required "name" string
        |> required "button_type" decodeFormButtonType


decodeFormButtonType : Decoder FormButtonType
decodeFormButtonType =
    string |> andThen mapFormButtonType


mapFormButtonType : String -> Decoder FormButtonType
mapFormButtonType type_name =
    case type_name of
        "submit" ->
            succeed SubmitButton

        "cancel" ->
            succeed CancelButton

        _ ->
            fail ("Unknown form button type " ++ type_name)
