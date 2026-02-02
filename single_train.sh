scene="custom_car"
exp_name="test_1"
gpu=-1
ratio=1
resolution=-1
appearance_dim=0

fork=2
base_layer=12
visible_threshold=0.9
dist2level="round"
update_ratio=0.2

progressive="True"
dist_ratio=0.999 #0.99
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
    mkdir -p data
    
    # Extract basename to use as scene name
    scene_name=$(basename "$target_path")
    
    # Remove existing link/dir if it needs refresh (optional, but good for idempotency if path changed)
    # Using -znf to force symlink update
    ln -sfn "$target_path" "data/$scene_name"
    
    scene="$scene_name"
    echo "Symlinked to data/$scene"
fi

./train.sh -d ${scene} -l ${exp_name} --gpu ${gpu} -r ${resolution} --ratio ${ratio} --appearance_dim ${appearance_dim} \
   --fork ${fork} --visible_threshold ${visible_threshold} --base_layer ${base_layer} --dist2level ${dist2level} --update_ratio ${update_ratio} \
   --progressive ${progressive} --levels ${levels} --init_level ${init_level} --dist_ratio ${dist_ratio} \
   --extra_ratio ${extra_ratio} --extra_up ${extra_up}

  
