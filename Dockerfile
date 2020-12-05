FROM cayleygraph/cayley:v0.7.6 as cayley

# Any base image you want here
FROM alpine

# Copy the Cayley binary to the image
COPY --from=cayley /bin/cayley /bin/cayley
COPY cayley.json /etc/cayley.json
COPY --from=cayley /data/cayley.db /data/cayley.db

HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 CMD [ "cayley", "health" ]

# Run Cayley
ENTRYPOINT ["cayley", "http", "--host=:64210"]
