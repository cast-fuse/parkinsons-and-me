module Components.LogoFooter exposing (logoFooter)

import Html exposing (..)
import Html.Attributes exposing (..)


logoFooter : Html msg
logoFooter =
    div [ class "mw5 w-50-ns mv3 ph3 center" ]
        [ img [ src "/images/puk-logo-long.svg", class "w-100" ] [] ]
