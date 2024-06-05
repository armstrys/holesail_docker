From node:20-buster

RUN npm i holesail -g

ARG ${PORT}

CMD holesail --live ${PORT}
