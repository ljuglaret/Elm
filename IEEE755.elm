
format x = 
    let 
        signe =
            if x < 0
            then [1]
            else[0]
    in
        let 
            semi = signe ++ (exposantEnBinaire x) ++ (finalApresVirgule x)
            zeros = complete semi
        in semi ++ zeros

-- Pour plus de lisibilite : on regroupe par blocs de 4 

parBlocs : List Int -> List (List Int )
parBlocs l =
    if List.isEmpty l
    then []
    else
        (List.take 4 l) :: (parBlocs (List.drop 4 l))


-- Enfin, il reste a convertir les blocs binaires en hexadecimal

binVersHexa b =
    let 
        dec = partieEntiereBinVersDec b
    in
        if dec < 10
        then String.fromFloat (toFloat dec)
        else 
            if dec == 10
            then "A"
            else if dec == 11
            then "B"
            else if dec == 12
            then "C"
            else if dec == 13
            then "D"
            else if dec == 14
            then "E"
            else  "F"

blocsHexa : Float ->  String
blocsHexa x = String.concat(List.map (\bloc -> binVersHexa bloc) (parBlocs(format x )))




        
-- Nombre reel decimal vers Nombre reel binaire 
fct : Float -> Float -> (Float , (List Int,List Int ))
fct x y = 
    let 
        sommePartieEnt = sommeEnt (bvdEnt x) (bvdEnt y)
        sommePartieFloat = sommeFloat (bvdFloat2 x) (bvdFloat2 y)
        d = partieEntiereBinVersDec sommePartieEnt
        f =  partieFloattanteBinVersDec (List.reverse  sommePartieFloat)
    in ((toFloat d) + ( toFloat  f), (sommePartieEnt,List.reverse sommePartieFloat)) 

