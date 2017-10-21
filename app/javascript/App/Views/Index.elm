module App.Views.Index exposing (..)

import App.Views.Conversation exposing (conversation)
import App.Views.Errors exposing (errorView)
import App.Views.Header exposing (headersForData)
import App.Models.Index exposing (..)
import App.Messages exposing (..)
import Html exposing (Html, div, text)
import Material.Layout as Layout


-- import Html.Attributes exposing (class)


view : Model -> Html Msg
view model =
    Layout.render Mdl
        model.mdl
        [ Layout.fixedHeader
        , Layout.seamed
        ]
        { header = headersForData model.data
        , drawer = []
        , tabs = ( [], [] )
        , main = [ conversationOrError model ]
        }


conversationOrError : Model -> Html Msg
conversationOrError model =
    case model.error of
        Nothing ->
            conversation model

        Just errorString ->
            errorView errorString
