module Components.LogoFooter exposing (logoFooter)

import Html exposing (..)
import Html.Attributes exposing (..)


logoFooter : Html msg
logoFooter =
    div [ class "mw5 center absolute left-0 right-0 center", style [ ( "bottom", "1.5rem" ) ] ]
        [ img [ src "/images/puk-logo-long.svg", class "w-100" ] [] ]
