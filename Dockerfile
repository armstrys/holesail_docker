From node:20-buster

RUN npm i -g hypertele # hyperdht server proxy
RUN npm i -g hyper-cmd-utils # keygen utils


ARG ${PORT}

#RUN hyper-cmd-util-keygen --gen_seed
#RUN OUTPUT=$(hyper-cmd-util-keygen --gen_seed)
#RUN SEED=$(echo "$OUTPUT" | awk -F': ' '{print $2}')


CMD sleep 3 && hypertele-server -l ${PORT} --seed cffcd21d41c517f44e99b2f02353985460b83d713ff862959e69df0b88de809b --private
