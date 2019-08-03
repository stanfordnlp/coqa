# create worksheet
cl new sivareddy-coqa-0x6b8ed47d07364f3f8b78bc05b35505d5

# change worksheet
cl work sivareddy-coqa-0x6b8ed47d07364f3f8b78bc05b35505d5
cl wperm . public none

# copy data
cl add text "### data"
cl wadd sivareddy-coqa-data sivareddy-coqa-0x6b8ed47d07364f3f8b78bc05b35505d5
cl add text "### source code"
cl wadd 0x6b8ed47d07364f3f8b78bc05b35505d5 sivareddy-coqa-0x6b8ed47d07364f3f8b78bc05b35505d5

cl add text "### checks"
cl run :data :dataset :libraries :model :nn :train :utils :pred_model :run_arrow_pred.sh :run_eval.sh :run_bert_coqa_pred.py :evaluate-v1.0.py coqa-dev-v1.0.json:coqa-dev-data-sanity-check/coqa-dev-v1.0.no_future.json 'sh run_arrow_pred.sh coqa-dev-v1.0.json' --request-docker-image ginking/arrow-coqa:1.0 --request-gpus 1 --request-memory 39g -n no_future
cl run :data :dataset :libraries :model :nn :train :utils :pred_model :run_arrow_pred.sh :run_eval.sh :run_bert_coqa_pred.py :evaluate-v1.0.py coqa-dev-v1.0.json:coqa-dev-data-sanity-check/coqa-dev-v1.0.with_future.json 'sh run_arrow_pred.sh coqa-dev-v1.0.json' --request-docker-image ginking/arrow-coqa:1.0 --request-gpus 1 --request-memory 39g -n with_future
cl run :data :dataset :libraries :model :nn :train :utils :pred_model :run_arrow_pred.sh :run_eval.sh :run_bert_coqa_pred.py :evaluate-v1.0.py coqa-dev-v1.0.json:coqa.test.json 'sh run_arrow_pred.sh coqa-dev-v1.0.json' --request-docker-image ginking/arrow-coqa:1.0 --request-gpus 1 --request-memory 39g -n full_test

cl add text "### eval"
cl run dev.json:coqa-dev-data-sanity-check/coqa-dev-v1.0.only_current.json :evaluate-v1.0.py pred.json:no_future/pred_answer.json 'python evaluate-v1.0.py --data-file dev.json --pred-file pred.json' -n no_future_results
cl run dev.json:coqa-dev-data-sanity-check/coqa-dev-v1.0.only_current.json :evaluate-v1.0.py pred.json:with_future/pred_answer.json 'python evaluate-v1.0.py --data-file dev.json --pred-file pred.json' -n with_future_results
cl run dev.json:coqa.test.json :evaluate-v1.0.py pred.json:full_test/pred_answer.json 'python evaluate-v1.0.py --data-file dev.json --pred-file pred.json' -n full_test_results
