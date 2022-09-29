tsv_dir=./tsv_dir/
feat_dir=./feat_dir/
lab_dir=./lab_dir/
km_path=./km/

nshard=1
rank=0
n_cluster=100

# First, use simple_kmeans to generate labels

# feature extraction (MFCC feature)
# python hubert/simple_kmeans/dump_mfcc_feature.py ${tsv_dir} genshin_train ${nshard} ${rank} ${feat_dir} --sample_rate 48000
# python hubert/simple_kmeans/dump_mfcc_feature.py ${tsv_dir} genshin_valid ${nshard} ${rank} ${feat_dir} --sample_rate 48000
# python hubert/simple_kmeans/dump_mfcc_feature.py ${tsv_dir} genshin_test ${nshard} ${rank} ${feat_dir} --sample_rate 48000
# feature extraction (HUBERT feature)
# python hubert/simple_kmeans/dump_hubert_feature.py ${tsv_dir} genshin_train ${ckpt_path} ${layer} ${nshard} ${rank} ${feat_dir}
# python hubert/simple_kmeans/dump_hubert_feature.py ${tsv_dir} genshin_valid ${ckpt_path} ${layer} ${nshard} ${rank} ${feat_dir}
# python hubert/simple_kmeans/dump_hubert_feature.py ${tsv_dir} genshin_test ${ckpt_path} ${layer} ${nshard} ${rank} ${feat_dir}

# k-means clustering
# python hubert/simple_kmeans/learn_kmeans.py ${feat_dir} genshin_train ${nshard} km_genshin_train.joblib.pkl ${n_cluster} --percent 0.1
# python hubert/simple_kmeans/learn_kmeans.py ${feat_dir} genshin_valid ${nshard} km_genshin_valid.joblib.pkl ${n_cluster} --percent 0.1
# python hubert/simple_kmeans/learn_kmeans.py ${feat_dir} genshin_test ${nshard} km_genshin_test.joblib.pkl ${n_cluster} --percent 0.1
# k-means application
python hubert/simple_kmeans/dump_km_label.py ${feat_dir} genshin_train km_genshin_train.joblib.pkl ${nshard} ${rank} ${lab_dir}
python hubert/simple_kmeans/dump_km_label.py ${feat_dir} genshin_valid km_genshin_valid.joblib.pkl ${nshard} ${rank} ${lab_dir}
python hubert/simple_kmeans/dump_km_label.py ${feat_dir} genshin_test km_genshin_test.joblib.pkl ${nshard} ${rank} ${lab_dir}

for rank in $(seq 0 $((nshard - 1))); do
  cat $lab_dir/${split}_${rank}_${nshard}.km
done > $lab_dir/${split}.km