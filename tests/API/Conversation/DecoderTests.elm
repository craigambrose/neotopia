module API.Conversation.DecoderTests exposing (..)

import Test exposing (..)
import Expect
import App.Models.Conversation exposing (..)
import App.API.Conversation.Decoders exposing (..)
import Json.Decode
import App.Models.Data exposing (..)


welcomeMessage : Message
welcomeMessage =
    { id = "foobar"
    , prompt = "Welcome to Neotopia, are you new here?"
    , responder =
        { config =
            SelectOptionResponder { options = [ "yes", "no" ] }
        }
    , url = Nothing
    }


all : Test
all =
    describe "Conversation API"
        [ describe "decodeResponder"
            [ test "handles valid data" <|
                \() ->
                    let
                        input =
                            """
                              {
                                "responder_type": "select_option",
                                "options": ["yes", "no"]
                              }
                            """

                        decodedOutput =
                            Json.Decode.decodeString
                                decodeResponder
                                input
                    in
                        Expect.equal decodedOutput
                            (Ok
                                { config =
                                    SelectOptionResponder { options = [ "yes", "no" ] }
                                }
                            )
            ]
        , describe "decodeMessage"
            [ test "handles valid data" <|
                \() ->
                    let
                        input =
                            """
                                {
                                    "id": "barfoo",
                                    "responder": {
                                        "responder_type": "select_option",
                                        "options": ["yes","no"]
                                    },
                                    "prompt": "Welcome to Neotopia, are you new here?"
                                }
                                """

                        decodedOutput =
                            Json.Decode.decodeString
                                decodeMessage
                                input
                    in
                        Expect.equal decodedOutput
                            (Ok
                                { id = "barfoo"
                                , prompt = "Welcome to Neotopia, are you new here?"
                                , responder =
                                    { config =
                                        SelectOptionResponder { options = [ "yes", "no" ] }
                                    }
                                , url = Nothing
                                }
                            )
            ]
        , describe "decodeExchange"
            [ test "handles valid data" <|
                \() ->
                    let
                        input =
                            """
                                {
                                    "message": {
                                        "id": "foobar",
                                        "responder": {
                                            "responder_type": "select_option",
                                            "options": ["yes","no"]
                                        },
                                        "prompt": "Welcome to Neotopia, are you new here?"
                                    }
                                }
                                """

                        decodedOutput =
                            Json.Decode.decodeString
                                decodeExchange
                                input
                    in
                        Expect.equal decodedOutput
                            (Ok
                                { message = welcomeMessage, data = emptyData }
                            )
            ]
        , describe "decodesExchange with data"
            [ test "decodes user" <|
                \() ->
                    let
                        input =
                            """
                                {
                                    "message": {
                                        "id": "foobar",
                                        "responder": {
                                            "responder_type": "select_option",
                                            "options": ["yes","no"]
                                        },
                                        "prompt": "Welcome to Neotopia, are you new here?"
                                    },
                                    "data": {
                                        "user": {
                                            "id": "6",
                                            "name": "bob",
                                            "signed_up": false
                                        },
                                        "token": "sometoken"
                                    }
                                }
                            """

                        decodedOutput =
                            Json.Decode.decodeString
                                decodeExchange
                                input
                    in
                        Expect.equal decodedOutput
                            (Ok
                                { message = welcomeMessage
                                , data =
                                    { user = Just { id = "6", name = "bob", signedUp = False }
                                    , token = Just "sometoken"
                                    }
                                }
                            )
            , test "decodes url redirect message" <|
                \() ->
                    let
                        input =
                            """
                                {
                                    "message": {
                                        "id": "foobar",
                                        "url": "http://www.example.com"
                                    },
                                    "data": {
                                    }
                                }
                            """

                        decodedOutput =
                            Json.Decode.decodeString
                                decodeExchange
                                input
                    in
                        Expect.equal decodedOutput
                            (Ok
                                { message =
                                    { id = "foobar"
                                    , prompt = ""
                                    , responder = { config = NoResponder }
                                    , url = Just "http://www.example.com"
                                    }
                                , data =
                                    { user = Nothing
                                    , token = Nothing
                                    }
                                }
                            )
            ]
        ]
