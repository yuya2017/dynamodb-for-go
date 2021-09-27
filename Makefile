.PHONY: build
PROJECT_ROOT=$(shell git rev-parse --show-toplevel)

build:
	GOOS=linux GOARCH=amd64 go build -o apigateway-sample

start:
	sam local start-api

validate:
	sam validate --profile kinoshita

upload:
	sam package --profile kinoshita --region ap-northeast-1 --template-file template.yaml --s3-bucket lambda-apigatewqy-sample --output-template-file packaged.yaml

deploy:
	aws --profile kinoshita --region ap-northeast-1 cloudformation deploy --template-file $(PROJECT_ROOT)/packaged.yaml --stack-name apigateway-sample --capabilities CAPABILITY_IAM
