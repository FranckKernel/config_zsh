#!/usr/bin/env python3
import argparse
import pymupdf

parser = argparse.ArgumentParser(description="Print PDF outline up to a given depth.")
parser.add_argument("file_pos", nargs="?", help="Path to the PDF file")
parser.add_argument("level_pos", nargs="?", type=int, help="Maximum outline level to print")
parser.add_argument("--file", dest="file_opt", help="Path to the PDF file")
parser.add_argument("--level", dest="level_opt", type=int, help="Maximum outline level to print")
parser.add_argument("--pages", action="store_true", help="Also print page numbers")
args = parser.parse_args()

file_path = args.file_opt if args.file_opt is not None else args.file_pos
level = args.level_opt if args.level_opt is not None else args.level_pos

if file_path is None:
    parser.error("a PDF file is required (positional or --file)")
if level is None:
    level = 1

doc = pymupdf.open(file_path)
for lvl, title, page in doc.get_toc(simple=True):
    if lvl <= level:
        print(f"{title}\t{page}" if args.pages else title)
