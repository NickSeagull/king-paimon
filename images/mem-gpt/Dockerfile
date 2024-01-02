FROM python:3.10
RUN apt-get update && apt-get install -y swig
RUN pip install 'pymemgpt[postgres]'

# RUN apt-get update && apt-get install -y wget
# RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh
# RUN bash ~/miniconda.sh -b -p $HOME/miniconda
# ENV PATH="/root/miniconda/bin:${PATH}"
# RUN conda install -c pytorch faiss-cpu

CMD [ "memgpt", "server", "--host=0.0.0.0" ]