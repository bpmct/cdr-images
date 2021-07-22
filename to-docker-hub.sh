if [ -z "$1" ]
  then
    echo "No argument supplied"
    exit
fi

rem_trailing_slash() {
    echo "$1" | sed 's/\/*$//g'
}

docker build $(rem_trailing_slash "$1")/ -t bencdr/$(rem_trailing_slash "$1") && docker push bencdr/$(rem_trailing_slash "$1")