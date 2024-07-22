FROM rikorose/gcc-cmake:gcc-7
LABEL authors="xxanadd"
WORKDIR /app
COPY source /app/source
RUN mkdir /app/build
WORKDIR /app/build
CMD cmake -DCMAKE_C_COMPILER=gcc ../source/; make
