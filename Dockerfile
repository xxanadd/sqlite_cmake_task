FROM rikorose/gcc-cmake:gcc-7
LABEL authors="xxanadd"
WORKDIR /app
COPY source /app/source
RUN mkdir /app/build
WORKDIR /app/build
CMD echo "Compiler: "; /usr/bin/cc --version; cmake ../source/; mkdir /app/build/logs; make > /app/build/logs/build.log 2>&1