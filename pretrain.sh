tsv_dir=./tsv_dir/
feat_dir=./feat_dir/

# Then, pretrain the hubert model
fairseq-hydra-train --config-dir "hubert/config/pretrain/" --config-name hubert_base_genshin
