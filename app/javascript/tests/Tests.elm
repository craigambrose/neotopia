module Tests exposing (..)

import Test exposing (..)
import API.Conversation.DecoderTests as DecoderTests


all : Test
all =
    describe "Neotopia"
        [ DecoderTests.all ]
