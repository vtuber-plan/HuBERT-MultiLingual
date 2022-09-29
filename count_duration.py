import os
import librosa
import glob
import tqdm
import wave

files = glob.glob("datasets/genshin-20220915/*/wav/*.wav")
files = list(files)
total_t = 0

for i, file in enumerate(tqdm.tqdm(files)):
    with wave.open(file, 'r') as audio_file:
        nsample = audio_file.getnframes() // audio_file.getframerate()
    total_t += nsample

print(total_t / 60 / 60)