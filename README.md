# uc-tdm-AS-C-docker

This component is the workflow for the OpenMinTeD AS-C use case.

## test-data
The test-data folder contains data to run the workflow. More specifically:
* corpus/ contains a text sample that can be used as input.
* output/ is where the output of the workflow will be created.

## Run in command-line

To run the workflow (from the folder containing the README):

```docker run -i --rm -v $PWD/test-data/:/as-c/data ldeleger/uc-tdm-as-c-docker alvisnlp -J "-Xmx30g" -alias input /as-c/data/corpus/test.xml -entity outdir /as-c/data/output plans/tag_pubmed.plan```

## OpenMinteD metadata

The OpenMinteD metadata are recorded in the following [XML file](as-c.metadata.xml)

## Re-build the docker image

```docker build . -t ldeleger/uc-tdm-as-c-docker -f Dockerfile```
