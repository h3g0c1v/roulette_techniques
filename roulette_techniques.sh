#!/bin/bash

# Técnicas
#   D’Alembert
#   Secuencia de Fibonacci
#   Paroli
#   Óscar Grind
#   Guetting
#   Labouchere

#Colores
green="\e[0;32m\033[1m"
end="\033[0m\e[0m"
red="\e[0;31m\033[1m"
blue="\e[0;34m\033[1m"
yellow="\e[0;33m\033[1m"
purple="\e[0;35m\033[1m"
turquoise="\e[0;36m\033[1m"
gray="\e[0;310m\033[1m"

function ctrl_c(){
    echo -e "\n${red}[+] Saliendo...${end}\n"
    tput cnorm;exit 1
}

# Ctrl+C
trap ctrl_c INT

function helpPanel(){
    echo -e "\n${yellow}[+]${end}${gray} Uso:${end}${purple}$0${end} ${gray}-m ${end}${green}money${end}${gray} -t${end}${blue} technique${end}\n"
    echo -e "\t${purple}-m${end}${gray} Dinero con el que se desea jugar${end}"
    echo -e "\t${purple}-t${end}${gray} Técnica a utilizar ${end}${purple}(${end}${yellow}dalembert${end}${gray} - ${end}${green}fibonacci${end}${gray} - ${end}${purple}paroli${end}${gray} - ${end}${blue}grind${end}${purple})${end}"
}

function dalembert(){

    echo -e "\n${yellow}[+] ${end}${gray}Dinero actual:${end}${yellow} $money€${end}"
    echo -ne "${yellow}[+] ${end}${gray}¿Cuánto dinero tienes pensado apostar? ->${end} " && read bet
    echo -ne "${yellow}[+] ${end}${gray}¿Cuánto querrás aumentar o disminuir la apuesta cuando ganes o pierdas? ->${end} " && read bid_up_down
    echo -ne "${yellow}[+] ${end}${gray}¿A qué deseas apostar continuamente (par/impar)? ->${end} " && read par_impar

#    echo -e "\n${yellow}[+] ${end}${gray}Vamos a jugar con una cantidad inicial de ${end}${yellow}$bet€${end}${gray} a ${end}${yellow}$par_impar${end}"

#    echo -e "\n${yellow}[+] ${end}${gray}En caso de que ganemos o perdamos, la apuesta se disminuirá o se aumentará ${end}${yellow}$bid_up_down€${end}${gray} respectivamente${end}"
    
    declare -i initial_bet
    initial_bet=bet

    declare -i numero_jugadas=0
    
    while true; do
        tput civis
        money=$(($money-$bet))

        random_number="$(($RANDOM % 37))" # Número random entre los 36 números de la ruleta

        if [ $money -gt 0 ] && [ $bet -gt 0 ]; then

            let numero_jugadas+=1

#            echo -e "${yellow}[+]${end}${gray} Invertimos ${end}${yellow}$bet${end}"
#            echo -e "${yellow}[+]${end}${gray} Tenemos${end} ${yellow}$money€${end}"
        
#            echo -e "\n${yellow}[+]${end}${gray} Ha salido el número ${end}${blue}$random_number${end}"
            
            if [ "$par_impar" == "par" ]; then

                if [ $(($random_number % 2)) -eq 0 ] && [ $(($random_number)) -ne 0 ]; then
                    
#                    echo -e "${yellow}[+] ${end}${green}Ha salido un número par ¡ganas!${end}"
#                    echo -e "${yellow}[+] ${end}${green}Como hemos ganado disminuimos la apuesta ${end}${yellow}$bid_up_down€${end}${green} menos${end}"

                    reward=$(($bet*2))
                    money=$(($money + $reward))
                    bet=$(($bet - $bid_up_down))

#                    echo -e "${yellow}[+] ${end}${gray}La apuesta se nos queda en ${end}${yellow}$bet€${end}"
                    tput cnorm
                else
                    
                    if [ $(($random_number % 2)) -ne 0 ] || [ $random_number -eq 0 ]; then
#                        if [ $random_number -ne 0 ]; then
                       
#                            echo -e "${red}[!] ${end}${red}Ha salido un número impar ¡pierdes!${end}"
#                        else
                        
#                            echo -e "${red}[!] ${end}${red}Ha salido el número 0 ¡pierdes!${end}"
#                        fi      

#                        echo -e "${red}[!] Como hemos perdido aumentamos la apuesta ${end}${yellow}$bid_up_down€${end}${red} más${end}"

                        bet=$(($bet + $bid_up_down))

#                        echo -e "${red}[+]${end}${gray} La apuesta se nos queda en ${end}${yellow}$bet€${end}"

         
                    fi
                fi
            elif [ "$par_impar" == "impar" ]; then

                if [ $(($random_number % 2)) -ne 0 ] && [ $(($random_number)) -ne 0 ]; then
                    
#                    echo -e "${yellow}[+] ${end}${green}Ha salido un número impar ¡ganas!${end}"
#                    echo -e "${yellow}[+] ${end}${green}Como hemos ganado disminuimos la apuesta ${end}${yellow}$bid_up_down€${end}${green} menos${end}"

                    reward=$(($bet*2))
                    money=$(($money + $reward))
                    bet=$(($bet - $bid_up_down))

#                    echo -e "${yellow}[+] ${end}${gray}La apuesta se nos queda en ${end}${yellow}$bet€${end}"
                    tput cnorm
                else
                    
                    if [ $(($random_number % 2)) -eq 0 ] || [ $random_number -eq 0 ]; then
#                        if [ $random_number -ne 0 ]; then
                       
#                            echo -e "${red}[!] ${end}${red}Ha salido un número par ¡pierdes!${end}"
#                        else
                        
#                            echo -e "${red}[!] ${end}${red}Ha salido el número 0 ¡pierdes!${end}"
#                        fi      

#                        echo -e "${red}[!] Como hemos perdido aumentamos la apuesta ${end}${yellow}$bid_up_down€${end}${red} más${end}"

                        bet=$(($bet + $bid_up_down))

#                        echo -e "${red}[+]${end}${gray} La apuesta se nos queda en ${end}${yellow}$bet€${end}"

         
                    fi
                fi
            fi
        else

            echo -e "\n${red}[!] Te has quedado sin dinero. ¡La casa siempre gana!"
            echo -e "\n${yellow}[+]${end} ${gray}Número de jugadas:${end} ${blue}$numero_jugadas${end}${gray}${end}"
            tput cnorm; exit 1
        fi

        if [ $bet -le 0 ]; then
            
#            echo -e "\n${red}[!]${end}${gray} Hemos bajado demasiado la apuesta${end}"
#            echo -e "${red}[!]${end}${gray} La apuesta se reiniciará al valor inicial${end}"

            bet=$initial_bet

#            echo -e "\n${yellow}[!]${end}${gray} La apuesta se ha reiniciado a ${end}${yellow}$bet€${end}"
        fi
    done
    tput cnorm

}

function fibonacci(){
    echo -e "\n${yellow}[+] ${end}${gray}Dinero actual:${end}${yellow} $money€${end}"
    echo -ne "${yellow}[+] ${end}${gray}¿A qué deseas apostar continuamente (par/impar)? ->${end} " && read par_impar

    declare -a sequence=(1)
    declare -i numero_jugadas=0

#    echo -e "\n${yellow}[+] ${end}${gray}Vamos a jugar con una cantidad inicial de ${end}${yellow}${sequence[-1]}€${end}${gray} a ${end}${yellow}$par_impar${end}"
    
    tput civis    
    while true; do

        money=$(($money-${sequence[-1]}))

        let numero_jugadas+=1
        random_number="$(($RANDOM % 37))"
        
        if [ $money -gt 0 ]; then

#                echo -e "${yellow}[+]${end}${gray} Invertimos ${end}${yellow}${sequence[-1]}€${end}"
#                echo -e "${yellow}[+]${end}${gray} Tenemos${end} ${yellow}$money€${end}"

#                echo -e "\n${yellow}[+] ${end}${gray}Ha salido el número ${end}${blue}$random_number${end}"

            if [ "$par_impar" == "par" ]; then
                if [ $(($random_number % 2)) -eq 0 ] && [ $(($random_number)) -ne 0 ]; then
                    
#                    echo -e "${yellow}[+] ${end}${green}Ha salido un número par ¡ganas!${end}"
#                    echo -e "${yellow}[+] ${end}${gray}Numero de jugada:${end}${blue} $numero_jugadas${end}"


                    reward=$((${sequence[-1]}* 2))
                    let money+=$reward

#                    echo -e "${yellow}[+]${end}${gray} Tenemos${end} ${yellow}$money€${end}"

                    if [ $numero_jugadas -eq 1 ]; then

                        declare -a sequence=(1)
#                        echo -e "${green}[+] ${end}${gray}Hemos ganado, pero era nuestra primera jugada, por lo que reiniciamos la secuencia${end}"
#                        echo -e "${green}[+] ${end}${gray}La secuencia se nos queda de la siguiente forma: ${end}${blue}[${sequence[@]}]${end}"
                    else
                        if [ ${#sequence[@]} -gt 2 ]; then

#                            echo -e "${green}[+] ${end}${gray}Como hemos ganado retrocedemos dos números atras en la secuencia${end}"
                            
                            unset sequence[-1]
                            unset sequence[-2]

                            sequence=(${sequence[@]})

#                            echo -e "${green}[+] ${end}${gray}La secuencia se nos queda de la siguiente forma: ${end}${blue}[${sequence[@]}]${end}"
                        else

#                            echo -e "${green}[+] ${end}${gray}Como hemos ganado retrocedemos dos números atras en la secuencia${end}"
#                            echo -e "${green}[+] ${end}${gray}Hemos retrocedido demasiado en nuestra secuencia${end}"

                            sequence=(1)
#                            echo -e "${green}[+] ${end}${gray}Reiniciamos la secuencia al principio: ${end}${blue}[${sequence[@]}]${end}"
                        fi                        
                    fi
                elif [ $(($random_number % 2)) -ne 0 ] || [ $random_number -eq 0 ]; then

#                    if [ $random_number -eq 0 ]; then
                    
#                        echo -e "${red}[!] ${end}${red}Ha salido el número 0 ¡pierdes!${end}"
#                    else
                    
#                        echo -e "${red}[!] Ha salido un número impar ¡pierdes!${end}"
#                    fi
#                    echo -e "${yellow}[+] ${end}${gray}Numero de jugada:${end}${blue} $numero_jugadas${end}"
                    
                    if [ ${#sequence[@]} -eq 1 ]; then
                        
#                        echo -e "${red}[!] ${end}${gray}Como hemos perdido apostamos la suma de los dos números anteriores de nuestra${end}"                
                        suma_dos_anteriores=($((${sequence[-1]} + 0)))
                        sequence+=($suma_dos_anteriores)
#                        echo -e "${red}[+] ${end}${gray}La secuencia se nos queda de la siguiente forma: ${end}${blue}[${sequence[@]}]${end}"
                    else

#                        echo -e "${red}[!] ${end}${gray}Como hemos perdido apostamos la suma de los dos números anteriores de nuestra${end}"                
                        suma_dos_anteriores=($((${sequence[-1]}+${sequence[-2]})))
                        sequence+=($suma_dos_anteriores)
#                        echo -e "${yellow}[+] ${end}${gray}La secuencia se nos queda de la siguiente forma: ${end}${blue}[${sequence[@]}]${end}"
                    fi
                fi
            elif [ "$par_impar" == "impar" ]; then
                if [ $(($random_number % 2)) -ne 0 ] && [ $(($random_number)) -ne 0 ]; then
                    
#                    echo -e "${yellow}[+] ${end}${green}Ha salido un número impar ¡ganas!${end}"
#                    echo -e "${yellow}[+] ${end}${gray}Numero de jugada:${end}${blue} $numero_jugadas${end}"


                    reward=$((${sequence[-1]}* 2))
                    let money+=$reward

#                    echo -e "${yellow}[+]${end}${gray} Tenemos${end} ${yellow}$money€${end}"

                    if [ $numero_jugadas -eq 1 ]; then

                        declare -a sequence=(1)
#                        echo -e "${green}[+] ${end}${gray}Hemos ganado, pero era nuestra primera jugada, por lo que reiniciamos la secuencia${end}"
#                        echo -e "${green}[+] ${end}${gray}La secuencia se nos queda de la siguiente forma: ${end}${blue}[${sequence[@]}]${end}"
                    else
                        if [ ${#sequence[@]} -gt 2 ]; then

#                            echo -e "${green}[+] ${end}${gray}Como hemos ganado retrocedemos dos números atras en la secuencia${end}"
                            
                            unset sequence[-1]
                            unset sequence[-2]

                            sequence=(${sequence[@]})

#                            echo -e "${green}[+] ${end}${gray}La secuencia se nos queda de la siguiente forma: ${end}${blue}[${sequence[@]}]${end}"
                        else

#                            echo -e "${green}[+] ${end}${gray}Como hemos ganado retrocedemos dos números atras en la secuencia${end}"
#                            echo -e "${green}[+] ${end}${gray}Hemos retrocedido demasiado en nuestra secuencia${end}"

                            sequence=(1)
#                            echo -e "${green}[+] ${end}${gray}Reiniciamos la secuencia al principio: ${end}${blue}[${sequence[@]}]${end}"
                        fi

                        
                    fi
                elif [ $(($random_number % 2)) -eq 0 ] || [ $random_number -eq 0 ]; then

#                    if [ $random_number -eq 0 ]; then

#                        echo -e "${red}[!] ${end}${red}Ha salido el número 0 ¡pierdes!${end}"
#                    else
                    
#                        echo -e "${red}[!] Ha salido un número par ¡pierdes!${end}"
#                    fi

#                    echo -e "${yellow}[+] ${end}${gray}Numero de jugada:${end}${blue} $numero_jugadas${end}"
                    
                    if [ ${#sequence[@]} -eq 1 ]; then
                        
#                        echo -e "${red}[!] ${end}${gray}Como hemos perdido apostamos la suma de los dos números anteriores de nuestra${end}"                
                        suma_dos_anteriores=($((${sequence[-1]} + 0)))
                        sequence+=($suma_dos_anteriores)
#                        echo -e "${red}[+] ${end}${gray}La secuencia se nos queda de la siguiente forma: ${end}${blue}[${sequence[@]}]${end}"
                    else

#                        echo -e "${red}[!] ${end}${gray}Como hemos perdido apostamos la suma de los dos números anteriores de nuestra${end}"                
                        suma_dos_anteriores=($((${sequence[-1]}+${sequence[-2]})))
                        sequence+=($suma_dos_anteriores)
#                        echo -e "${yellow}[+] ${end}${gray}La secuencia se nos queda de la siguiente forma: ${end}${blue}[${sequence[@]}]${end}"
                    fi
                fi
            fi
        else
            echo -e "\n${red}[!] Te has quedado sin dinero. ¡La casa siempre gana!"
            echo -e "\n${yellow}[+]${end}${gray} Han habido un total de ${end}${yellow}$(($numero_jugadas-1))${end} ${gray}jugadas${end}"
            tput cnorm; exit 1
        fi
    done
    tput cnorm
}

function paroli(){
    echo -e "\n${yellow}[+] ${end}${gray}Dinero actual:${end}${yellow} $money€${end}"
    echo -ne "${yellow}[+] ${end}${gray}¿Cuánto dinero tienes pensado apostar? ->${end} " && read initial_bet
    echo -ne "${yellow}[+] ${end}${gray}¿A qué deseas apostar continuamente (par/impar)? ->${end} " && read par_impar

#    echo -e "\n${yellow}[+] ${end}${gray}Vamos a jugar con una cantidad inicial de ${end}${yellow}$initial_bet€${end}${gray} a ${end}${yellow}$par_impar${end}"

    declare -i numero_jugadas=0
    declare -i racha_seguida=0
    declare -i initial_bet_backup=$initial_bet

    while true; do
    
        let numero_jugadas+=1

        money=$(($money-$initial_bet))
        random_number=$(($RANDOM % 37))

        if [ $money -gt 0 ]; then
            if [ "$par_impar" == "par" ]; then

#                echo -e "${yellow}[+]${end}${gray} Invertimos ${end}${yellow}$initial_bet€${end}"
#                echo -e "${yellow}[+]${end}${gray} Tenemos${end} ${yellow}$money€${end}"
            
#                echo -e "\n${yellow}[+]${end}${gray} Ha salido el número ${end}${blue}$random_number${end}"

                if [ $(($random_number % 2)) -eq 0 ] && [ $(($random_number)) -ne 0 ]; then

                    let racha_seguida+=1
#                    echo -e "${yellow}[+] ${end}${green}Ha salido un número par ¡ganas!${end}"
                    
                    reward=$(($initial_bet*2))
                    let money+=$reward

#                    echo -e "${yellow}[+] ${end}${gray}Tenemos ${end}${yellow}$money€${end}"

                    if [ $racha_seguida -eq 1 ]; then
                        
#                        echo -e "${yellow}[+]${end}${green} Tu racha es de 2 por lo que la apuesta se multiplica por 2${end}"
                        double_bet=$(($initial_bet * 2))
                        initial_bet=$double_bet
                    elif [ $racha_seguida -eq 2 ]; then
                        
#                        echo -e "${yellow}[+]${end}${green} Tu racha es de 3 por lo que la apuesta se multiplica por 4${end}"
                        quadruple_bet=$(($initial_bet * 2))
                        initial_bet=$quadruple_bet
                    fi
                elif [ $(($random_number % 2)) -ne 0 ] || [ $(($random_number)) -eq 0 ]; then

#                    if [ $random_number -ne 0 ]; then
                        
#                        echo -e "${red}[!] Ha salido un número impar ¡pierdes!${end}"
#                    else
#                        echo -e "${red}[!] Ha salido el número 0 ¡pierdes!${end}"
#                    fi
                    
#                    if [ $racha_seguida -gt 0 ]; then
#                        echo -e "${red}[!] Hemos perdido la racha por lo que volvemos a apostar: ${end}${yellow}$initial_bet_backup€${end}"
#                    fi                

                    racha_seguida=0
                    initial_bet=$initial_bet_backup

#                    echo -e "${yellow}[+] ${end}${gray}Tenemos ${end}${yellow}$money€${end}"
                fi

                if [ $racha_seguida -eq 3 ]; then
                    
                    racha_seguida=0
#                    echo -e "${yellow}[+] ${red}${green}Demasiadas rachas seguidas.${end}"
#                    echo -e "${yellow}[+] ${end}${gray}Volvemos a apostar: ${end}${yellow}$initial_bet_backup€${end}"
                    initial_bet=$initial_bet_backup
                fi
            elif [ "$par_impar" == "impar" ]; then

#                echo -e "${yellow}[+]${end}${gray} Invertimos ${end}${yellow}$initial_bet€${end}"
#                echo -e "${yellow}[+]${end}${gray} Tenemos${end} ${yellow}$money€${end}"
            
#                echo -e "\n${yellow}[+]${end}${gray} Ha salido el número ${end}${blue}$random_number${end}"

                if [ $(($random_number % 2)) -ne 0 ] && [ $(($random_number)) -ne 0 ]; then

                    let racha_seguida+=1
#                    echo -e "${yellow}[+] ${end}${green}Ha salido un número impar ¡ganas!${end}"
                    
                    reward=$(($initial_bet*2))
                    let money+=$reward

#                    echo -e "${yellow}[+] ${end}${gray}Tenemos ${end}${yellow}$money€${end}"

                    if [ $racha_seguida -eq 1 ]; then
                        
#                        echo -e "${yellow}[+]${end}${green} Tu racha es de 2 por lo que la apuesta se multiplica por 2${end}"
                        double_bet=$(($initial_bet * 2))
                        initial_bet=$double_bet
                    elif [ $racha_seguida -eq 2 ]; then
                        
#                        echo -e "${yellow}[+]${end}${green} Tu racha es de 3 por lo que la apuesta se multiplica por 4${end}"
                        quadruple_bet=$(($initial_bet * 2))
                        initial_bet=$quadruple_bet
                    fi
                elif [ $(($random_number % 2)) -eq 0 ] || [ $(($random_number)) -eq 0 ]; then
                    
#                    if [ $random_number -ne 0 ]; then
                        
#                        echo -e "${red}[!] Ha salido un número par ¡pierdes!${end}"
#                    else
#                        echo -e "${red}[!] Ha salido el número 0 ¡pierdes!${end}"
#                    fi
                    
#                    if [ $racha_seguida -gt 0 ]; then
#                        echo -e "${red}[!] Hemos perdido la racha por lo que volvemos a apostar: ${end}${yellow}$initial_bet_backup€${end}"
#                    fi                

                    racha_seguida=0
                    initial_bet=$initial_bet_backup

#                    echo -e "${yellow}[+] ${end}${gray}Tenemos ${end}${yellow}$money€${end}"
                fi

                if [ $racha_seguida -eq 3 ]; then
                    
                    racha_seguida=0
#                    echo -e "${yellow}[+] ${red}${green}Demasiadas rachas seguidas.${end}"
#                    echo -e "${yellow}[+] ${end}${gray}Volvemos a apostar: ${end}${yellow}$initial_bet_backup€${end}"
                    initial_bet=$initial_bet_backup
                fi
            fi
        else

            echo -e "\n${red}[!] Te has quedado sin dinero. ¡La casa siempre gana!"
            echo -e "\n${yellow}[+]${end}${gray} Han habido un total de ${end}${yellow}$(($numero_jugadas-1))${end} ${gray}jugadas${end}"
            tput cnorm; exit 1
        fi
    done
}

function grind(){
    echo -e "\n${yellow}[+] ${end}${gray}Dinero actual:${end}${yellow} $money€${end}"
    echo -ne "${yellow}[+] ${end}${gray}¿Cuánto dinero tienes pensado apostar? ->${end} " && read bet
    echo -ne "${yellow}[+] ${end}${gray}¿A qué deseas apostar continuamente (par/impar)? ->${end} " && read par_impar

#    echo -e "\n${yellow}[+] ${end}${gray}Vamos a jugar con una cantidad inicial de ${end}${yellow}$bet€${end}${gray} a ${end}${yellow}$par_impar${end}"

    declare -i numero_jugadas
    null=null

    initial_bet=$bet
    money_backup=$money
    
#    echo -e "\n${yellow}[+] ${end}${gray}El límite a reiniciar la serie está en ${end}${yellow}$money_backup€${end}"

    while true; do

        money=$(($money-$bet))
        random_number=$(($RANDOM % 37))

        if [ $money -gt 0 ]; then

            let numero_jugadas+=1
            if [ "$par_impar" == "par" ]; then
                
#                echo -e "${yellow}[+] ${end}${gray}Invertimos ${end}${yellow}$bet€${end}"
#                echo -e "${yellow}[+] ${end}${gray}Tenemos${end} ${yellow}$money€${end}"

#                echo -e "\n${yellow}[+] ${end}${gray}Ha salido el número ${end}${blue}$random_number${end}"

                if [ $(($random_number % 2)) -eq 0 ] && [ $random_number -ne 0 ]; then

#                    echo -e "${yellow}[+] ${end}${green}Ha salido un número par ¡ganas!${end}"

                    reward=$(($bet*2))
                    let money+=$reward

#                    echo -e "${yellow}[+] ${end}${gray}Tenemos ${end}${yellow}$money€${end}"
                    
                    if [ $money -ge $money_backup ]; then

                        bet=$initial_bet

#                        if [ $money -eq $money_backup ]; then
                            
#                            echo -e "${yellow}[+] ${end}${green}Hemos recuperado el dinero perdido, por lo que volvemos a empezar la serie"
#                            echo -e "${yellow}[+] ${end}${gray}El límite a reiniciar la serie está en ${end}${yellow}$money€${end}"
#                        else
                            
#                            echo -e "${yellow}[+] ${end}${green}Hemos obtenido beneficios, por lo que volvemos a empezar la serie"
#                            echo -e "${yellow}[+] ${end}${gray}El límite a reiniciar la serie está en ${end}${yellow}$money€${end}"
#                        fi

                        money_backup=$money
                    else

                        let bet+=$bet
                    fi
                elif [ $(($random_number % 2)) -ne 0 ] || [ $random_number -eq 0 ]; then

#                    if [ $random_number -ne 0 ]; then

#                       echo -e "${red}[!] Ha salido un número impar ¡pierdes!${end}"
#                    else
                      
#                       echo -e "${red}[!] Ha salido el número 0 ¡pierdes!${end}"
#                    fi
                    
#                    echo -e "${yellow}[+] ${end}${gray}Tenemos ${end}${yellow}$money€${end}"
                    null=null
                fi
            elif [ "$par_impar" == "impar" ]; then
                
#                echo -e "${yellow}[+] ${end}${gray}Invertimos ${end}${yellow}$bet€${end}"
#                echo -e "${yellow}[+] ${end}${gray}Tenemos${end} ${yellow}$money€${end}"

#                echo -e "\n${yellow}[+] ${end}${gray}Ha salido el número ${end}${blue}$random_number${end}"

                if [ $(($random_number % 2)) -ne 0 ] && [ $random_number -ne 0 ]; then

#                    echo -e "${yellow}[+] ${end}${green}Ha salido un número impar ¡ganas!${end}"

                    reward=$(($bet*2))
                    let money+=$reward

#                    echo -e "${yellow}[+] ${end}${gray}Tenemos ${end}${yellow}$money€${end}"
                    
                    if [ $money -ge $money_backup ]; then

                        bet=$initial_bet

#                        if [ $money -eq $money_backup ]; then
                            
#                            echo -e "${yellow}[+] ${end}${green}Hemos recuperado el dinero perdido, por lo que volvemos a empezar la serie"
#                            echo -e "${yellow}[+] ${end}${gray}El límite a reiniciar la serie está en ${end}${yellow}$money€${end}"
#                        else
                            
#                            echo -e "${yellow}[+] ${end}${green}Hemos obtenido beneficios, por lo que volvemos a empezar la serie"
#                            echo -e "${yellow}[+] ${end}${gray}El límite a reiniciar la serie está en ${end}${yellow}$money€${end}"
#                        fi

                        money_backup=$money
                    else

                        let bet+=$bet
                    fi
                elif [ $(($random_number % 2)) -eq 0 ] || [ $random_number -eq 0 ]; then

#                    if [ $random_number -ne 0 ]; then

#                       echo -e "${red}[!] Ha salido un número par ¡pierdes!${end}"
#                    else
                      
#                       echo -e "${red}[!] Ha salido el número 0 ¡pierdes!${end}"
#                    fi
                    
#                   echo -e "${yellow}[+] ${end}${gray}Tenemos ${end}${yellow}$money€${end}"
                    null=null
                fi
            fi
        else
            echo -e "\n${red}[!] Te has quedado sin dinero. ¡La casa siempre gana!"
            echo -e "\n${yellow}[+]${end}${gray} Han habido un total de ${end}${yellow}$(($numero_jugadas-1))${end} ${gray}jugadas${end}"
            tput cnorm; exit 1
        fi
    done
}

parameter_counter=0

while getopts "m:t:h" arg; do
    case $arg in
        m) money="$OPTARG";;
        t) technique="$OPTARG";;
        h) ;;
    esac
done

if [ $money ] && [ $technique ]; then

    if [ "$technique" == "dalembert" ] || [ "$technique" == "fibonacci" ] || [ "$technique" == "paroli" ] || [ "$technique" == "grind" ]; then
        if [ "$technique" == "dalembert" ]; then
          
            dalembert
        elif [ "$technique" == "fibonacci" ]; then
          
            fibonacci
        elif [ "$technique" == "paroli" ]; then
            
            paroli
        elif [ "$technique" == "grind" ]; then
            
            grind
        fi
    else
        echo -e "\n${red}[!] Introduce una técnica válida${end}"
        helpPanel
    fi
else
    helpPanel
fi