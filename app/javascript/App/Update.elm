module App.Update exposing (..)

import App.Models.Index exposing (..)
import App.Messages exposing (..)
import App.API.Conversation exposing (sendInput)
import Time exposing (Time, millisecond)
import String exposing (length)
import Material exposing (update)
import Http exposing (Error(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        MessageAnimationTick diff ->
            case model.animatedMessage of
                Just animatedMessage ->
                    let
                        animation =
                            animateMessage animatedMessage diff

                        newAnimatedMessage =
                            { animatedMessage | animation = animation }
                    in
                        ( { model | animatedMessage = Just newAnimatedMessage }, Cmd.none )

                Nothing ->
                    ( model, Cmd.none )

        ReceiveMessage (Ok exchange) ->
            let
                newAnimatedMessage =
                    { message = exchange.message, animation = initAnimation, input = [] }
            in
                ( { model | animatedMessage = Just newAnimatedMessage, data = exchange.data }, Cmd.none )

        ReceiveMessage (Err errorResponse) ->
            let
                errorString =
                    errorToEnglish errorResponse
            in
                ( { model | error = Just errorString }, Cmd.none )

        InputResponse key value ->
            case model.animatedMessage of
                Just animatedMessage ->
                    let
                        newAnimatedMessage =
                            { animatedMessage | input = updateStructuredInput animatedMessage.input key value }
                    in
                        ( { model | animatedMessage = Just newAnimatedMessage }, Cmd.none )

                Nothing ->
                    ( model, Cmd.none )

        SubmitResponse text ->
            case model.animatedMessage of
                Just animatedMessage ->
                    let
                        input =
                            bestInput text animatedMessage
                    in
                        ( model, sendInput model.config.baseUrl model.data.token animatedMessage.message input )

                Nothing ->
                    ( model, Cmd.none )

        Mdl msg_ ->
            Material.update Mdl msg_ model


bestInput : Maybe String -> AnimatedMessage -> Input
bestInput specifiedText animatedMessage =
    case specifiedText of
        Nothing ->
            animatedMessage.input

        Just validText ->
            [ ( "text", validText ) ]


animateMessage : AnimatedMessage -> Time -> Animation
animateMessage animatedMessage diff =
    let
        message =
            animatedMessage.message

        animation =
            animatedMessage.animation

        elapsed =
            animation.elapsed + diff

        charsPrinted =
            round (animation.elapsed * (1 * millisecond) * 0.05)

        newStage =
            if charsPrinted < length message.prompt then
                PrintingMessage
            else
                AwaitingResponse

        complete =
            animation.charsPrinted >= String.length message.prompt
    in
        { animation | elapsed = elapsed, charsPrinted = charsPrinted, stage = newStage, complete = complete }


errorToEnglish : Http.Error -> String
errorToEnglish error =
    case error of
        BadUrl url ->
            "I was expecting a valid URL, but I got the url: " ++ url

        Timeout ->
            "It took too long to get a response from the server!"

        NetworkError ->
            "Unable to make a connection. Is your network working?"

        BadStatus response ->
            responseToEnglish response

        BadPayload errorMessage response ->
            "I failed because of the following error: "
                ++ errorMessage
                ++ " and "
                ++ responseToEnglish response


responseToEnglish : Http.Response String -> String
responseToEnglish response =
    response.status.message ++ ": " ++ (toString response.body)


updateStructuredInput : Input -> String -> String -> Input
updateStructuredInput input key value =
    let
        filtered =
            List.filter (valuesWithoutKey key) input
    in
        List.append [ ( key, value ) ] filtered


valuesWithoutKey : String -> InputTuple -> Bool
valuesWithoutKey key tuple =
    (Tuple.first tuple) /= key
