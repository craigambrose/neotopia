module App.Models.Data exposing (..)


type alias User =
    { id : String
    , name : String
    , signedUp : Bool
    }


type alias Data =
    { user : Maybe User
    , token : Maybe String
    }


initialData : Data
initialData =
    { user = Nothing, token = Nothing }


emptyData : Data
emptyData =
    initialData
