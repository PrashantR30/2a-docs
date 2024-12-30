FROM python:3-alpine3.14
ARG USER=1000
RUN adduser -h /usr/src/mkdocs -D -u $USER mkdocs \
&& apk add bash \
&& apk add git 

ENV PATH="${PATH}:/usr/src/mkdocs/.local/bin"

USER mkdocs
RUN mkdir -p /usr/src/mkdocs/build
WORKDIR /usr/src/mkdocs/build

RUN pip install --upgrade pip
RUN pip install pymdown-extensions \
&& pip install mkdocs \
&& pip install mkdocs-material \
&& pip install mkdocs-rtd-dropdown \
&& pip install mkdocs-git-revision-date-plugin \
&& pip install mkdocs-git-revision-date-localized-plugin \
&& pip install mkdocs-blog-plugin \
&& pip3 install mkdocs-blogging-plugin \
&& pip3 install mkdocs-macros-plugin \
&& pip install mike

# Switch to root temporarily to add the script
USER root
COPY deploy-and-serve.sh /usr/src/mkdocs/deploy-and-serve.sh
RUN chmod +x /usr/src/mkdocs/deploy-and-serve.sh

# Switch back to the mkdocs user
USER mkdocs

# Set the default entry point
ENTRYPOINT ["/usr/src/mkdocs/deploy-and-serve.sh"]
