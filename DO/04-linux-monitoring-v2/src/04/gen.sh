#!/bin/bash


logfile_gen(){
    dates=( "2026-03-24" "2026-03-25" "2026-03-26" "2026-03-27" "2026-03-28" )
    
    for (( l=0; l < 5; l++ )); do
        string_count=$( shuf -i 100-1000 -n 1)
        mapfile -t sorted_sec < <( shuf -i 1-86400 -n $string_count | sort -n )
        logfile="log_$((l + 1))_$(date -d "${dates[$l]}" "+%Y-%m-%d").log"
        for (( s=0; s < string_count; s++ )); do
            time=$(date -d "${dates[$l]} + ${sorted_sec[$s]} seconds" "+%d/%b/%Y:%H:%M:%S %z")
            size=$((RANDOM % 255))
            ip_gen
            code_gen
            url_gen
            agent_gen
            metod_gen
            echo "$ip - - [${time}] \"$metod $url HTTP/1.1\" $code \"-\" \"${agent}\"" >> $logfile
        done
    done
}


ip_gen(){
    ip=""$((RANDOM % 223))"."$((RANDOM % 255))"."$((RANDOM % 255))"."$((RANDOM % 255))""
}

metod_gen(){
    metods=("GET" "POST" "PUT" "PATCH" "DELETE")
    metod="${metods[$(( RANDOM % ${#metods[@]}))]}"
}

code_gen(){
    codes=("200" "201" "400" "401" "403" "404" "500" "501" "502" "503")
    code="${codes[$(( RANDOM % ${#codes[@]}))]}"
}

agent_gen(){
    agents=(
        "Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:47.0) Gecko/20100101 Firefox/47.0"
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36"
        "Opera/9.80 (Windows NT 6.0) Presto/2.12.388 Version/12.14"
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/16.5 Safari/605.1.15"
        "Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.1; Trident/5.0)"
        "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/114.0.0.0 Safari/537.36 Edg/114.0.1823.37"
        "Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"
        "curl/7.81.0"
        )
    agent="${agents[$(( RANDOM % ${#agents[@]}))]}"
}


url_gen(){
    urls=("/index.html"
    "/home"
    "/about"
    "/contacts"
    "/catalog"
    "/news"
    "/blog"
    "/faq"
    "/pricing"
    "/services"
    "/api/v1/login"
    "/api/v1/logout"
    "/api/v1/register"
    "/api/v1/user/profile"
    "/api/v1/get_data"
    "/api/v1/update_status"
    "/api/v2/auth/token"
    "/assets/css/main.css"
    "/assets/css/bootstrap.min.css"
    "/assets/js/app.min.js"
    "/assets/js/jquery.js"
    "/assets/images/logo.png"
    "/assets/images/banner.jpg"
    "/assets/images/favicon.ico"
    "/products?id=$((RANDOM % 1000))"
    "/category?name=electronics&page=$((RANDOM % 10))"
    "/search?q=linux+monitoring"
    "/post?v=$((RANDOM % 9999))"
    "/view?item_id=$((RANDOM % 500))"
    "/admin"
    "/admin/config"
    "/wp-admin"
    "/.env"
    "/config.php")

    url=${urls[$(( RANDOM % ${#urls[@]}))]}
}

