if [ -z "$1" ]
  then
    echo "No argument supplied"
    exit
fi

docker build $1/ -t bencdr/$1 && docker push bencdr/$1