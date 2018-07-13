module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)


-- model (what do we need to know)
type alias Model
  = { input: String
    , totalCalories: Int
    , errorMsg: String}

-- update (what can happen)
type Msg
    = AddCalorie
    | Clear
    | UserInput String


-- (where stuff happens )
update : Msg -> Model -> Model
update msg model =
    case msg of
        AddCalorie ->
            case String.toInt model.input of
               Ok value -> {model | totalCalories = model.totalCalories + value, errorMsg = ""}
               Err value -> {model | errorMsg = "Requires a Number"}


        Clear ->
          {model | totalCalories = 0, input = ""}

        UserInput input ->
          {model | input = input }



initModel : Model
initModel = {input = ""
            , totalCalories = 0
            , errorMsg = ""}



-- view


view : Model -> Html Msg
view model =
    div []
    [ Html.input [ onInput UserInput, value model.input][]
        , h3 []
            [ text ("Total Calories: " ++ (toString model.totalCalories )) ]
        , button
            [ type_ "button"
            , onClick AddCalorie
            ]
            [ text "Add" ]
        , button
            [ type_ "button"
            , onClick Clear
            ]
            [ text "Clear" ]
        , div [ ]
            [ text model.errorMsg ]
        ]


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = initModel
        , update = update
        , view = view
        }
