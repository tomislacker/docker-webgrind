FROM tutum/apache-php

RUN mkdir -p /app /cachegrind
VOLUME /cachegrind
RUN apt-get update
RUN apt-get install -qq \
        graphviz \
        unzip \
        wget

# Download webgrind
RUN wget -q --output-document=/tmp/webgrind.zip https://github.com/jokkedk/webgrind/archive/master.zip

# Install webgrind
RUN unzip /tmp/webgrind.zip -d /app
RUN mv /app/webgrind-master /app/webgrind

###
# Configure webgrind
###
# 1. Set the profilerDir to our volume mount
RUN sed -i 's/\(static\s\+$profilerDir\).*/\1 = "\/cachegrind";/g' /app/webgrind/config.php

# 2. Enable "Average Self Cost" table column
RUN sed -i "s/\/\/\('Average Self Cost'\)/\1/g" /app/webgrind/config.php

# 3. Enable "Average Inclusive Cost" table column
RUN sed -i "s/\/\/\('Average Inclusive Cost'\)/\1/g" /app/webgrind/config.php

# Ensure python is linked
RUN ln -sf /usr/bin/python3 /usr/bin/python || true
