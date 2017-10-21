module App.Views.Forms exposing (formInputView)

import App.Models.Conversation exposing (..)
import App.Messages exposing (..)
import App.Models.Index exposing (..)
import Html exposing (Html, text, div)
import Html.Attributes exposing (class)
import Material
import Material.Textfield as Textfield
import Material.Button as Button
import Material.Options as Options


formInputView : FormConfig -> Input -> Material.Model -> List Int -> Html Msg
formInputView config input mdlModel responderIndex =
    div
        [ class "form" ]
        [ formFields mdlModel responderIndex config.fields input
        , formButtons mdlModel responderIndex config.buttons
        ]


formFields : Material.Model -> List Int -> List FormField -> Input -> Html Msg
formFields mdlModel baseIndex fieldsConfig input =
    let
        fieldsIndex =
            List.append baseIndex [ 0 ]

        fields =
            List.indexedMap (formFieldRow mdlModel input fieldsIndex) fieldsConfig
    in
        div [ class "form-fields" ] fields


formFieldRow : Material.Model -> Input -> List Int -> Int -> FormField -> Html Msg
formFieldRow mdlModel input baseIndex rowIndex fieldConfig =
    let
        index =
            List.append baseIndex [ rowIndex ]
    in
        div [ class "form-field-row" ] [ formField mdlModel input index fieldConfig ]


formField : Material.Model -> Input -> List Int -> FormField -> Html Msg
formField mdlModel input index fieldConfig =
    case fieldConfig.fieldType of
        EmailField ->
            emailField mdlModel input index fieldConfig

        PasswordField ->
            passwordField mdlModel input index fieldConfig


emailField : Material.Model -> Input -> List Int -> FormField -> Html Msg
emailField mdlModel input index fieldConfig =
    textField
        mdlModel
        input
        index
        [ Textfield.email ]
        fieldConfig


passwordField : Material.Model -> Input -> List Int -> FormField -> Html Msg
passwordField mdlModel input index fieldConfig =
    textField
        mdlModel
        input
        index
        [ Textfield.password ]
        fieldConfig


textField : Material.Model -> Input -> List Int -> List (Textfield.Property Msg) -> FormField -> Html Msg
textField mdlModel input index options fieldConfig =
    let
        defaultOptions =
            [ Textfield.label fieldConfig.name
            , Textfield.floatingLabel
            , Textfield.value (inputValue input fieldConfig.name)
            , Options.onInput (InputResponse fieldConfig.name)
            ]

        allOptions =
            List.append defaultOptions options
    in
        Textfield.render
            Mdl
            index
            mdlModel
            allOptions
            []


formButtons : Material.Model -> List Int -> List FormButton -> Html Msg
formButtons mdlModel baseIndex buttonsConfig =
    let
        buttonsIndex =
            List.append baseIndex [ 0 ]

        buttons =
            List.indexedMap (formButton mdlModel buttonsIndex) buttonsConfig
    in
        div [ class "form-buttons" ] buttons


formButton : Material.Model -> List Int -> Int -> FormButton -> Html Msg
formButton mdlModel baseIndex buttonIndex fieldConfig =
    let
        buildButton =
            genericFormButton
                mdlModel
                baseIndex
                buttonIndex
                fieldConfig
    in
        case fieldConfig.buttonType of
            SubmitButton ->
                buildButton
                    [ Button.raised
                    , Button.ripple
                    , Options.onClick (SubmitResponse Nothing)
                    ]

            CancelButton ->
                buildButton
                    [ Button.flat
                    , Options.onClick (SubmitResponse (Just "cancel"))
                    ]


genericFormButton : Material.Model -> List Int -> Int -> FormButton -> List (Button.Property Msg) -> Html Msg
genericFormButton mdlModel baseIndex buttonIndex fieldConfig options =
    let
        index =
            List.append baseIndex [ buttonIndex ]

        defaultOptions =
            [ Button.colored
            ]

        allOptions =
            List.append defaultOptions options
    in
        Button.render Mdl
            index
            mdlModel
            allOptions
            [ text fieldConfig.name ]
