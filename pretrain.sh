tsv_dir=./tsv_dir/
feat_dir=./feat_dir/

# First, use simple_kmeans to generate labels

# feature extraction (MFCC feature)
python hubert/simple_kmeans/dump_mfcc_feature.py ${tsv_dir} ${split} ${nshard} ${rank} ${feat_dir}
# feature extraction (HUBERT feature)
python hubert/simple_kmeans/dump_hubert_feature.py ${tsv_dir} ${split} ${ckpt_path} ${layer} ${nshard} ${rank} ${feat_dir}

# k-means clustering
python hubert/simple_kmeans/learn_kmeans.py ${feat_dir} ${split} ${nshard} ${km_path} ${n_cluster} --percent 0.1
# k-means application
python hubert/simple_kmeans/dump_km_label.py ${feat_dir} ${split} ${km_path} ${nshard} ${rank} ${lab_dir}

for rank in $(seq 0 $((nshard - 1))); do
  cat $lab_dir/${split}_${rank}_${nshard}.km
done > $lab_dir/${split}.km

# Then, pretrain the hubert model
fairseq-hydra-train --config-dir "hubert/config/pretrain/" --config-name hubert_base_librispeech