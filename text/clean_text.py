import itertools
import re

LANGUAGE_UNICODE_RANGE_MAP = {
    "ZH": [(0x4E00, 0x9FFF)],
    "JP": [(0x4E00, 0x9FFF), (0x3040, 0x309F), (0x30A0, 0x30FF), (0x31F0, 0x31FF)],
    "EN": [(0x0000, 0x007F)],
}

SYMBOLS_MAPPING = {
    "：": ",",
    "；": ",",
    "，": ",",
    "。": ".",
    "！": "!",
    "？": "?",
    "\n": ".",
    "·": ",",
    "、": ",",
    "...": "…",
    "“": "'",
    "”": "'",
    "‘": "'",
    "’": "'",
    "（": "'",
    "）": "'",
    "(": "'",
    ")": "'",
    "《": "'",
    "》": "'",
    "【": "'",
    "】": "'",
    # "[": "'",
    # "]": "'",
    "—": "-",
    "～": "-",
    "~": "-",
    "・": "-",
    "「": "'",
    "」": "'",
    ";": ",",
    ":": ",",
}

REPLACE_SYMBOL_REGEX = re.compile(
    "|".join(re.escape(p) for p in SYMBOLS_MAPPING.keys())
)
ALL_KNOWN_UTF8_RANGE = list(
    itertools.chain.from_iterable(LANGUAGE_UNICODE_RANGE_MAP.values())
)
REMOVE_UNKNOWN_SYMBOL_REGEX = re.compile(
    "[^"
    + "".join(
        f"{re.escape(chr(start))}-{re.escape(chr(end))}"
        for start, end in ALL_KNOWN_UTF8_RANGE
    )
    + "]"
)


def clean_text(text):
    # Clean the text
    text = text.strip()

    # Replace all chinese symbols with their english counterparts
    text = REPLACE_SYMBOL_REGEX.sub(lambda x: SYMBOLS_MAPPING[x.group()], text)
    text = REMOVE_UNKNOWN_SYMBOL_REGEX.sub("", text)

    return text

if __name__ == "__main__":
    from pathlib import Path
    from pypinyin import Style
    from pypinyin import pinyin
    from tqdm import tqdm
    import ipdb
    PROCESSED_ROOT = "/home/v-zhikangniu/data/fuyuyan/PROCESSED_IGNORE_NONE"

    for txt_path in tqdm(list(Path(PROCESSED_ROOT).rglob("**/*.txt"))):
        with open(txt_path, "r", encoding="utf-8") as f:
            text = f.read()
            clean = clean_text(text)
            print(f"clean: {clean} \n original: {text}")
            clean_text_path = txt_path.with_suffix(".clean_text")
            with open(clean_text_path, "w", encoding="utf-8") as f:
                f.write(clean)
            # pinyin_path = txt_path.with_suffix(".pinyin")
            # # ipdb.set_trace()
            # pinyin_text = [
            #     p[0]
            #     for p in pinyin(text, style=Style.TONE3)
            # ]
            # # pinyin_text = g2pw.lazy_pinyin(text, style=Style.TONE3)
            # pinyin_storage = " ".join(pinyin_text)

            # # ipdb.set_trace()
            # with open(pinyin_path, "w", encoding="utf-8") as f:
            #     f.write(pinyin_storage)
                
            # merged_pinyin_text = merge_pinyin_content(pinyin_text)
            # phoneme = " ".join(merged_pinyin_text)
            # phoneme_path = txt_path.with_suffix(".phoneme")
            # with open(phoneme_path, "w", encoding="utf-8") as f:
            #     f.write(phoneme)

            # print(f"og: {text} \n pinyin: {pinyin_text} \n phoneme: {phoneme}")
