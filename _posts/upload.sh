mv ./assets/ ../

cd ..
git add .
if [ $? -ne 0 ]
then
	mv ./assets/ ./_posts
fi

git ci
if [ $? -ne 0 ]
then
	mv ./assets/ ./_posts
fi

git push
mv ./assets/ ./_posts



