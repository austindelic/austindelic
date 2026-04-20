#!/usr/bin/env bash
set -e

# Build base resume
typst compile resume.typ ../portfolio/public/resume.pdf
echo "Built: resume.pdf"

# Build all variants: resumes/{company}/{role}/resume.typ → resumes/{company}/{role}/resume.pdf
for dir in resumes/*/*; do
  if [ -f "$dir/resume.typ" ] && [ "$(basename "$dir")" != "_template" ]; then
    company=$(echo "$dir" | cut -d/ -f2)
    role=$(echo "$dir" | cut -d/ -f3)
    typst compile --root . "$dir/resume.typ" "$dir/resume.pdf"
    echo "Built: $company/$role/resume.pdf"
  fi
done
