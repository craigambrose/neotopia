module App.Views.Errors exposing (errorView)

import App.Messages exposing (..)
import Html exposing (Html, text, div, p, h1)
import Html.Attributes exposing (class)


errorView : String -> Html Msg
errorView errorString =
    div [ class "error-container" ]
        [ errorHeading
        , errorMessage errorString
        ]


errorHeading : Html msg
errorHeading =
    h1 [] [ text "Well, this is embarrassing..." ]


errorMessage : String -> Html msg
errorMessage errorString =
    div [ class "error" ]
        [ text errorString
        ]
