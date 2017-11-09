module App.Views.Header exposing (headerContents, headersForData)

import App.Models.Data exposing (..)
import Material.Layout as Layout
import Material.Icon as Icon
import Html exposing (Html, text, span, a)
import Html.Attributes exposing (title)
import Material.Options as Options exposing (css, when)


headersForData : Data -> List (Html msg)
headersForData data =
    case data.user of
        Just user ->
            case user.loggedIn of
                True ->
                    [ headerContents user ]

                False ->
                    []

        Maybe.Nothing ->
            []


headerContents : User -> Html msg
headerContents user =
    Layout.row
        [ css "transition" "height 333ms ease-in-out 0s"
        ]
        [ Layout.title [] [ text "Neotopia" ]
        , Layout.spacer
        , Layout.navigation []
            [ Layout.link
                [ Options.attribute <| title user.name ]
                [ Icon.i "person" ]
            ]
        ]


dummyHeader : Html msg
dummyHeader =
    Layout.row
        [ css "transition" "height 333ms ease-in-out 0s"
        ]
        [ Layout.title [] [ text "Neotopia" ]
        , Layout.spacer
        , Layout.navigation []
            [ Layout.link
                [ Options.attribute <| title "username" ]
                [ Icon.i "person" ]
            ]
        ]



-- Layout.link []
--     [ Icon.view "menu"
--         [ Icon.size36
--         ]
--     ]
