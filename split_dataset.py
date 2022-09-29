
import random

def main():
    random.seed(1234)
    with open("tsv_dir/genshin.tsv", "r", encoding='utf-8') as f:
        root = f.readline().rstrip()
        lines = f.readlines()
    
    random.shuffle(lines)

    train_split = int(len(lines) * 0.96)
    valid_split = int(len(lines) * 0.98)
    train_lines = lines[:train_split]
    valid_lines = lines[train_split:valid_split]
    test_lines = lines[valid_split:]

    with open("tsv_dir/genshin_train.tsv", "w", encoding='utf-8') as f:
        f.write(root + '\n')
        f.writelines(train_lines)
    
    with open("tsv_dir/genshin_valid.tsv", "w", encoding='utf-8') as f:
        f.write(root + '\n')
        f.writelines(valid_lines)
    
    with open("tsv_dir/genshin_test.tsv", "w", encoding='utf-8') as f:
        f.write(root + '\n')
        f.writelines(test_lines)

if __name__ == "__main__":
    main()