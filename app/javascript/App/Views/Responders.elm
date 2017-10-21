module App.Views.Responders exposing (inputView)

import App.Messages exposing (..)
import App.Models.Index exposing (..)
import App.Views.Forms exposing (..)
import App.Models.Conversation exposing (..)
import Material.Textfield as Textfield
import Material.Options as Options
import Material.Button as Button
import Material
import Html exposing (Html, text, div)
import Html.Attributes exposing (class)
import Json.Decode
import Html.Events exposing (keyCode)


inputView : Responder -> Input -> Material.Model -> Html Msg
inputView responder input mdlModel =
    div [ class "input" ] [ inputViewControls responder input mdlModel ]


inputViewControls : Responder -> Input -> Material.Model -> Html Msg
inputViewControls responder input mdlModel =
    let
        responderIndex =
            [ 99 ]
    in
        case responder.config of
            TextResponder config ->
                textInputView config input mdlModel

            SelectOptionResponder config ->
                selectOptionInputView config mdlModel

            FormResponder config ->
                formInputView config input mdlModel responderIndex

            NoResponder ->
                text ""

            UnknownMachine ->
                div [ class "error" ] [ text "unknown responder" ]


textInputView : TextConfig -> Input -> Material.Model -> Html Msg
textInputView config input mdlModel =
    Textfield.render
        Mdl
        [ 0 ]
        mdlModel
        [ Options.on "keydown" (Json.Decode.andThen isEnter keyCode)
        , Options.onInput (InputResponse "text")
        , Textfield.value (inputValue input "text")
        ]
        []


selectOptionInputView : SelectOptionConfig -> Material.Model -> Html Msg
selectOptionInputView config mdlModel =
    let
        buttons =
            List.indexedMap (\index label -> inputOptionButton label index mdlModel) config.options
    in
        div [ class "button-group" ] buttons


inputOptionButton : String -> Int -> Material.Model -> Html Msg
inputOptionButton label index mdlModel =
    Button.render Mdl
        [ index ]
        mdlModel
        [ Button.raised
        , Button.colored
        , Button.ripple
        , Options.onClick (SubmitResponse (Just label))
        ]
        [ text label ]


isEnter : number -> Json.Decode.Decoder Msg
isEnter code =
    if code == 13 then
        Json.Decode.succeed (SubmitResponse Maybe.Nothing)
    else
        Json.Decode.fail "not Enter"
