module Data.Quotes exposing (..)

import Model exposing (..)
import Dict exposing (..)


getQuote : Int -> Dict Int Quote -> ( Int, Quote )
getQuote quoteIndex quotes =
    quotes
        |> Dict.get quoteIndex
        |> Maybe.map (\q -> ( quoteIndex, q ))
        |> Maybe.withDefault ( 0, dummyQuote )


updateAnswer : YesNo -> ( Int, Quote ) -> Dict Int Quote -> Dict Int Quote
updateAnswer newAnswer ( quoteIndex, { body, answer } ) quotes =
    quotes
        |> Dict.update quoteIndex (Maybe.map (\q -> { q | answer = newAnswer }))


firstQuote : Quote
firstQuote =
    quoteList
        |> Dict.get 0
        |> Maybe.withDefault dummyQuote


quoteList : Dict Int Quote
quoteList =
    quotes
        |> List.indexedMap (\i x -> ( i, Quote x No ))
        |> Dict.fromList


quotes : List String
quotes =
    [ "Id' feel most comfortable if support staff came to see me at home"
    , "I'll just wait and see what information and support I'm offered"
    , "I want to say what I feel without anyone knowing who I cam, but know that someone will still be there listening and supporting me"
    ]


dummyQuote : Quote
dummyQuote =
    Quote "" No
