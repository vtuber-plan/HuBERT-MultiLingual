ip_addr=localhost
output_dir=checkpoints
python -m torch.distributed.launch --use_env --nproc_per_node=4 --nnodes=4 --node_rank=0 --master_addr=${ip_addr} --master_port=29671 \
    $(which fairseq-hydra-train) --config-dir "hubert/config/pretrain/" --config-name hubert_base_genshin \
    checkpoint.save_dir=${output_dir}