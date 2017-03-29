module Views.Quotes exposing (quotes)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Helpers.Styles as Styles
import Model exposing (..)
import Dict


quotes : Model -> Html Msg
quotes model =
    div [ class "mw6 center" ]
        [ quoteNumber model
        , renderQuote model.currentQuote
        , showYesNo model
        ]


renderQuote : ( Int, Quote ) -> Html Msg
renderQuote ( _, { body } ) =
    div [ class "bg-light-gray pa4 br2" ] [ h2 [ class "blue" ] [ em [] [ text body ] ] ]


quoteNumber : Model -> Html Msg
quoteNumber model =
    let
        total =
            Dict.size model.quotes

        ( currentIndex, _ ) =
            model.currentQuote
    in
        p [] [ text (toString (currentIndex + 1) ++ " of " ++ toString total) ]


showYesNo : Model -> Html Msg
showYesNo model =
    div [ class "mt4 flex justify-between" ]
        [ button [ class (Styles.buttonBlue ++ " ma2"), onClick (UpdateAnswer Yes model.currentQuote) ] [ text "Yes, I feel like this" ]
        , button [ class (Styles.buttonClear ++ " ma2"), onClick (UpdateAnswer No model.currentQuote) ] [ text "No, not how I feel" ]
        ]
