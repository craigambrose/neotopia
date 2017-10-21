module App.Views.Conversation exposing (conversation)

import App.Models.Index exposing (..)
import App.Views.Responders exposing (inputView)
import App.Messages exposing (..)
import Html exposing (Html, text, div, p)
import Html.Attributes exposing (class)
import Material


conversation : Model -> Html Msg
conversation model =
    let
        parts =
            conversationParts model
    in
        div [ class "conversation" ]
            parts


conversationParts : Model -> List (Html Msg)
conversationParts model =
    case model.animatedMessage of
        Just animatedMessage ->
            messageParts animatedMessage model.mdl

        Nothing ->
            []


messageParts : AnimatedMessage -> Material.Model -> List (Html Msg)
messageParts animatedMessage mdlModel =
    if animatedMessage.animation.stage == PrintingMessage then
        [ messageView animatedMessage ]
    else
        [ messageView animatedMessage
        , inputView animatedMessage.message.responder animatedMessage.input mdlModel
        ]


messageView : AnimatedMessage -> Html msg
messageView animatedMessage =
    let
        prompt =
            animatedMessage.message.prompt

        charsPrinted =
            animatedMessage.animation.charsPrinted

        printableMessage =
            String.left charsPrinted prompt

        textContents =
            textParagraphs printableMessage
    in
        div [ class "message" ] textContents


textParagraphs : String -> List (Html msg)
textParagraphs textData =
    let
        parts =
            String.split "\n\n" textData
    in
        List.map textParagraph parts


textParagraph : String -> Html msg
textParagraph textData =
    p [] [ text textData ]
