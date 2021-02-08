if [ -z "$1" ]
  then
    echo "No argument supplied"
    exit
fi

cd $1
docker build -t $1
docker push $1