FROM rocker/rstudio:3.6.2

# Install system deps as root user
RUN apt-get update && apt-get install -qq -y --no-install-recommends \
  libxml2-dev libssl-dev libcurl4-openssl-dev libssh2-1-dev libpq-dev zlib1g-dev

# Change user to rstudio before restoring packages
USER rstudio
WORKDIR /home/rstudio

# Restore R packages
COPY src/renv.lock src/DESCRIPTION src/init.R ./
RUN Rscript init.R

# Change user back to root as a requirement for S6 
USER root
