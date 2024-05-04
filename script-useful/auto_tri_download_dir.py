from pathlib import Path

dirs = {
    ".png": "Pictures",
    ".jpeg": "Pictures",
    ".jpg": "Pictures",
    ".gif": "Pictures",
    ".mp4": "Videos",
    ".mov": "Videos",
    ".mov": "Videos",
    ".zip": "Archives",
    ".pdf": "Doc",
    ".txt": "Doc",
    ".json": "Doc",
    ".gz": "Archives",
    "mp3": "Music"
}

tri_dir = Path.home() / "Downloads"
items = [f for f in tri_dir.iterdir() if f.is_file()]

for f in items:
    output_dir = tri_dir / dirs.get(f.suffix, "Other")
    output_dir.mkdir(exist_ok=True)
    f.rename(output_dir / f.name)
