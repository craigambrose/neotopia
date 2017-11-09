module App.Models.Conversation exposing (..)

import App.Models.Data exposing (Data)


type alias Exchange =
    { message : Message
    , data : Data
    }


type alias Message =
    { id : String
    , prompt : String
    , responder : Responder
    , url : Maybe String
    }


type alias Responder =
    { config : ResponderConfig
    }


type ResponderConfig
    = TextResponder TextConfig
    | SelectOptionResponder SelectOptionConfig
    | FormResponder FormConfig
    | NoResponder
    | UnknownMachine


type alias TextConfig =
    {}


type alias FormConfig =
    { fields : List FormField
    , buttons : List FormButton
    }


type alias SelectOptionConfig =
    { options : List String
    }


type alias FormField =
    { name : String
    , fieldType : FormFieldType
    }


type FormFieldType
    = EmailField
    | PasswordField


type alias FormButton =
    { name : String
    , buttonType : FormButtonType
    }


type FormButtonType
    = SubmitButton
    | CancelButton
