done: foo.zip
	aws lambda create-function --function-name RundeckTestLambda --runtime nodejs8.10 --role arn:aws:iam::535370547254:role/s3uploadTest-dev-ap-southeast-2-lambdaRole --handler index.s3put --zip-file fileb://foo.zip && touch done || rm -f done

foo.zip: index.js
	zip -r foo.zip *.js 

update:
	aws lambda update-function-code --function-name RundeckTestLambda  --zip-file fileb://foo.zip | jq . && touch updated

invoke:
	aws lambda invoke --function-name RundeckTestLambda /dev/stdout | jq .

result:
	aws s3 cp s3://msz-test-inbox/date ./date && echo "-- result --" && cat ./date && echo "" && rm -f ./date

clean:
	 aws lambda delete-function --function-name RundeckTestLambda && aws s3 rm  s3://msz-test-inbox/date && rm -f foo.zip done update
