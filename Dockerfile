# Pull AlvisNLP image
FROM bibliome/alvisengine

# Get StanfordNER 2014-06-16*
WORKDIR /opt/alvisnlp/psoft
RUN wget https://nlp.stanford.edu/software/stanford-ner-2014-06-16.zip && \
    unzip stanford-ner-2014-06-16 && \
    mv stanford-ner-2014-06-16 stanford-ner && \
    rm stanford-ner-2014-06-16.zip

# Get Yatea
RUN cpan App::cpanminus
RUN cpanm Lingua::YaTeA

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
    mkdir resources && \
    cp uc-tdm-AS-C-master/resources/* /as-c/resources && \
    mv /as-c/resources/yatea.dtd /as-c/ && \
    unzip /as-c/resources/taxa+id_full.zip -d /as-c/resources/ && \
    unzip /as-c/resources/taxid_microorganisms.zip -d /as-c/resources/ && \
    rm -r uc-tdm-AS-C-master

# Preprocess resources
RUN plans/preprocess_ontobiotopes.sh OntoBiotope-v53j
RUN alvisnlp -verbose -entity ontofile OntoBiotope-Phenotype-v2.obo -entity outfile OntoBiotope-Phenotype-v2.tomap plans/phenotype_ontology_analyzer.plan
