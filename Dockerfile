FROM kbase/sdkbase2:python
MAINTAINER KBase Developer
# -----------------------------------------
# In this section, you can install any system dependencies required
# to run your App.  For instance, you could place an apt-get update or
# install line here, a git checkout to download code, or run any other
# installation scripts.

RUN apt-get update
RUN apt-get install -y wget openbabel

RUN mkdir -p /kb/module/work
RUN chmod -R a+rw /kb/module

# install MGLTools 1.5.6 (http://mgltools.scripps.edu/downloads)
RUN MGL_VERSION='1.5.6' && \
    cd /kb/module && \
    wget http://mgltools.scripps.edu/downloads/downloads/tars/releases/REL${MGL_VERSION}/mgltools_i86Linux2_${MGL_VERSION}.tar.gz && \
    tar -zxvf mgltools_i86Linux2_${MGL_VERSION}.tar.gz && \
    rm mgltools_i86Linux2_${MGL_VERSION}.tar.gz && \
    mv mgltools_i86Linux2_${MGL_VERSION} mgltools && \
    cd mgltools && \
    tar -xzvf MGLToolsPckgs.tar.gz

# -----------------------------------------

COPY ./ /kb/module
WORKDIR /kb/module

RUN make all

ENTRYPOINT [ "./scripts/entrypoint.sh" ]

CMD [ ]
