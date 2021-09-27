.PHONY: build
PROJECT_ROOT=$(shell git rev-parse --show-toplevel)

build:
	sam build

start:
	sam local start-api

validate:
	sam validate -t template.yaml

upload:
	sam package --profile omeroid-stg --region ap-northeast-1 --template-file template.yaml --s3-bucket wac-internal-err-stg --output-template-file packaged.yaml

deploy:
	aws --profile omeroid-stg --region ap-northeast-1 cloudformation deploy --template-file $(PROJECT_ROOT)/tool/log-to-slack-lambda/packaged.yaml --stack-name internal-err --capabilities CAPABILITY_IAM
