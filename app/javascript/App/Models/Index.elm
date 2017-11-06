module App.Models.Index exposing (..)

import App.Models.Data exposing (Data, initialData)
import App.Models.Conversation exposing (Message)
import Time exposing (Time)
import Material
import List.Extra exposing (find)


type MessageStage
    = PrintingMessage
    | AwaitingResponse


type alias Animation =
    { elapsed : Time
    , charsPrinted : Int
    , complete : Bool
    , stage : MessageStage
    }


type alias Input =
    List InputTuple


type alias InputTuple =
    ( String, String )


type alias AnimatedMessage =
    { message : Message
    , animation : Animation
    , input : Input
    }


type alias AppConfig =
    { baseUrl : String
    , animate : Bool
    }


type alias Model =
    { animatedMessage : Maybe AnimatedMessage
    , error : Maybe String
    , mdl : Material.Model
    , data : Data
    , config : AppConfig
    }


initAnimation : Animation
initAnimation =
    { elapsed = 0.0
    , charsPrinted = 0
    , complete = False
    , stage = PrintingMessage
    }


initialModel : AppConfig -> Model
initialModel appConfig =
    { animatedMessage = Nothing
    , error = Nothing
    , mdl = Material.model
    , data = initialData
    , config = appConfig
    }


inputValue : Input -> String -> String
inputValue input key =
    let
        matchingTuple =
            find (\data -> (Tuple.first data) == key) input
    in
        case matchingTuple of
            Nothing ->
                ""

            Just ( _, value ) ->
                value
