# replace PREINSTALL_ID with e.g. sed, in your build script
FROM company/app-install:PREINSTALL_ID

# copy configs for vendor/postinstall build, avoidable if vendor builds are pre-packaged
# NOTE: COPY fails here if using short form copy (COPY config/vendoring config/)
ONBUILD COPY config/vendoring/ config/vendoring/

# build vendor packages
ONBUILD RUN npm run vendoring

# Bundle app source
ONBUILD COPY . .

ENTRYPOINT ["npm", "run"]
