FROM python:3.8.6
USER root

RUN apt-get update
RUN apt-get -y install locales && localedef -f UTF-8 -i ja_JP ja_JP.UTF-8
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:ja
ENV LC_ALL ja_JP.UTF-8
ENV TZ JST-9
ENV TERM xterm

RUN apt-get -y install apt-file

RUN apt-get -y install software-properties-common

RUN apt-add-repository "deb http://apt.llvm.org/buster/ llvm-toolchain-buster-10 main"
RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add -
RUN apt-get update
RUN apt-get -y install libllvm-10-ocaml-dev libllvm10 llvm-10 llvm-10-dev llvm-10-doc llvm-10-examples llvm-10-runtime
RUN ln -s -f /usr/bin/llvm-config-10 /usr/bin/llvm-config

RUN apt-get -y install gfortran

RUN cd /tmp \
    && wget http://www.netlib.org/lapack/lapack-3.8.0.tar.gz \
    && tar zxf lapack-3.8.0.tar.gz \
    && cd lapack-3.8.0/ \
    && cp make.inc.example make.inc \
    && make blaslib \
    && make lapacklib \
    && cp librefblas.a /usr/lib/libblas.a \
    && cp liblapack.a /usr/lib/liblapack.a \
    && cd / \
    && rm -rf /tmp/*

RUN apt-get install -y vim less
RUN pip install --upgrade pip
RUN pip install --upgrade setuptools
RUN pip install llvmlite
RUN pip install numpy
RUN pip install scipy
RUN pip install matplotlib
RUN pip install pandas
RUN pip install scikit-learn
RUN pip install numba
RUN pip install datashader
RUN pip install holoviews
RUN pip install umap-learn
RUN pip install pynndescent
RUN pip install cython
RUN pip install pyemma
RUN pip install ipython
