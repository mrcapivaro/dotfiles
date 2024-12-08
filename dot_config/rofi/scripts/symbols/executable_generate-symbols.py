#!/usr/bin/env python

## Output a list of newline separated unicode characters and their names.

from unicodedata import category, name

UPPER_BOUND = 0x10FFFF
LOWER_BOUND = 0

# Unicode Character Categories List:
# https://www.compart.com/en/unicode/category
allowed_categories: list[str] = ["Ll", "Lu", "Sm", "So"]


def print_char(uchar: str) -> None:
    uchar_name: str = name(uchar)
    print(f"{uchar}\t{uchar_name}")


def main() -> None:
    for i in range(LOWER_BOUND, UPPER_BOUND):
        uchar: str = chr(i)
        uchar_category = category(uchar)
        if uchar_category in allowed_categories:
            uchar_name = name(uchar)
            if (uchar_category == "Ll" or uchar_category == "Lu") and (
                "GREEK" not in uchar_name or "LATIN" not in uchar_name
            ):
                continue
            print_char(uchar)


if __name__ == "__main__":
    main()
