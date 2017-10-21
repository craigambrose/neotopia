module App.Subscriptions exposing (..)

import App.Messages exposing (..)
import App.Models.Index exposing (..)
import AnimationFrame


subscriptions : Model -> Sub Msg
subscriptions model =
    case model.animatedMessage of
        Nothing ->
            Sub.none

        Just animatedMessage ->
            if not animatedMessage.animation.complete then
                AnimationFrame.diffs MessageAnimationTick
            else
                Sub.none
