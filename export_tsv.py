from typing import List
import librosa
import glob
import tqdm
import os
import librosa
import wave


def write_tsv(out_path: str, root_path: str, files: List[str]):
    with open(out_path, 'w', encoding='utf-8') as f:
        f.write(root_path + '\n')
        for file in tqdm.tqdm(files):
            p = "/".join(file.split('/')[-3:])

            with wave.open(os.path.join(root_path, p), 'r') as audio_file:
                nsample = audio_file.getnframes()

            f.write(f'{p}\t{nsample}\n')

def main():
    chinese_files = list(glob.glob("datasets/genshin-20220915/chinese/wav/*.wav"))
    english_files = list(glob.glob("datasets/genshin-20220915/english/wav/*.wav"))
    japanese_files = list(glob.glob("datasets/genshin-20220915/japanese/wav/*.wav"))
    korean_files = list(glob.glob("datasets/genshin-20220915/korean/wav/*.wav"))

    write_tsv("tsv_dir/genshin.tsv", "datasets/genshin-20220915", chinese_files + english_files + japanese_files + korean_files)

if __name__ == "__main__":
    main()