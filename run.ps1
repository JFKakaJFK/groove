$app=$Args[0]
$tag=$app.ToLower()

docker build . -t "$tag" --build-arg app_name="$app"

docker run -it --name "$tag" -p 3000:3000 -p 8080:8080 -p 8025:8025 "$tag"

docker container rm $app