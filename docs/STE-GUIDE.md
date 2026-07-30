# STE Writing Guide

This repo applies ASD-STE100 Simplified Technical English, Issue 9, in a pragmatic form.
The standard has 53 writing rules in 9 sections, plus a dictionary of approved words.
This guide lists the rules that this repo enforces. Apply them to every document you add.

## Words

- Use one term for one concept. Take the terms from `CONTEXT.md`.
- Software terms are Technical Names. They are permitted. Examples: repo, issue, label, frontmatter.
- Command names and code are not prose. The rules do not apply inside code blocks.
- Use "can" for capability. Use "must" for requirements. Do not use "should" or "may".
- Do not use vague verbs. Prefer: do, make, get, read, write, apply, remove, show.

## Sentences

- Use the active voice.
- Write instructions as commands: "Read the file." Not: "The file should be read."
- Keep instructions to a maximum of 20 words.
- Keep descriptive sentences to a maximum of 25 words.
- Give only one instruction per sentence. Connected actions can share a sentence.
- Use the present tense. Do not use the present perfect tense.
- Avoid the gerund ("-ing" noun forms) where a simpler form exists.
- Use articles ("the", "a") where the grammar asks for them.
- Do not make noun clusters of more than three nouns.

## Paragraphs and structure

- Keep paragraphs to a maximum of six sentences.
- Give each paragraph one topic. Put the topic in the first sentence.
- Use vertical lists for sequences and for sets of conditions.
- Put warnings and cautions before the instruction they protect.
- Start a safety instruction with a clear command.

## Checks before commit

1. Read each new sentence. Count the words if the sentence looks long.
2. Find passive constructions ("is done", "was created"). Rewrite them as active.
3. Find "should", "may", "might" in instructions. Replace them with "must", "can", or a command.
4. Compare each term against `CONTEXT.md`. Remove synonyms.
