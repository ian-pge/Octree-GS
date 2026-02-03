#!/bin/bash

scene="custom_car"
exp_name="test_shiny_1"
gpu=0

# --- SHINY SURFACE OPTIMIZATION ---
ratio=1
resolution=1         # <--- MUST BE 1. '2' is too blurry for reflections.
appearance_dim=32    # Keeps lighting consistent.

# --- OCTREE SETTINGS ---
fork=2
base_layer=12
visible_threshold=0.9
dist2level="round"
update_ratio=0.2

progressive="True"
dist_ratio=0.999
levels=-1
init_level=-1
extra_ratio=0.25
extra_up=0.01

# Parse arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        -s|--scene) target_path="$2"; shift ;;
        --gpu) gpu="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

if [ ! -z "$target_path" ]; then
    echo "Setting up dataset from: $target_path"
    scene="$target_path"
fi

# Pass the new flags at the end
./train.sh -d ${scene} -l ${exp_name} --gpu ${gpu} -r ${resolution} --ratio ${ratio} --appearance_dim ${appearance_dim} \
   --fork ${fork} --visible_threshold ${visible_threshold} --base_layer ${base_layer} --dist2level ${dist2level} --update_ratio ${update_ratio} \
   --progressive ${progressive} --levels ${levels} --init_level ${init_level} --dist_ratio ${dist_ratio} \
   --extra_ratio ${extra_ratio} --extra_up ${extra_up} \
   --undistorted --use_feat_bank
