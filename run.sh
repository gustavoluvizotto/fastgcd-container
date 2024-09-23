#!/bin/bash

podman run --rm -v "$(pwd)"/output:/output --name fastgcd fastgcd-container_fastgcd output/input.moduli
