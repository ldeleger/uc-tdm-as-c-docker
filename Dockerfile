# Pull AlvisNLP image
FROM bibliome/alvisengine:2.0.0

WORKDIR /alvisnlp/psoft

# Get obo-utils
RUN git clone https://github.com/Bibliome/obo-utils.git

# Get Ab3P
RUN wget ftp://ftp.ncbi.nlm.nih.gov/pub/wilbur/Ab3P-v1.5.tar.gz && \
    tar xvzf Ab3P-v1.5.tar.gz && \
    rm Ab3P-v1.5.tar.gz && \
    cd Ab3P-v1.5 && \
    make

# Set the working directory to /as-c
WORKDIR /as-c

# Copy AS-C workflows
COPY plans /as-c/plans/

# Get resources from the OMTD uc-tdm-AS-C repository
WORKDIR /as-c    
RUN wget https://github.com/openminted/uc-tdm-AS-C/archive/master.zip && \
    unzip master.zip && \
    cp -R uc-tdm-AS-C-master/resources/ /as-c/ && \
    mv /as-c/resources/yatea.dtd /as-c/ && \
    unzip /as-c/resources/taxa+id_full.zip -d /as-c/resources/ && \
    unzip /as-c/resources/taxid_microorganisms.zip -d /as-c/resources/ && \
    mv resources/OntoBiotope-v53t.obo resources/OntoBiotope.obo && \
    rm -r uc-tdm-AS-C-master

# Preprocess resources
RUN plans/preprocess_ontobiotope.sh OntoBiotope


