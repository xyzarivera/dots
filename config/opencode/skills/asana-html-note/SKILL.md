---
description: Use `html_notes` (not `notes`) for task descriptions and comments when using create_tasks, update_tasks, or create_task MCP tools
alwaysApply: false
---

# Asana `html_notes` (task descriptions)

Use `html_notes` (not `notes`) for formatted task descriptions via `create_tasks`, `update_tasks`, or `create_task_preview_v4`.

## Format

- Single root: `<body>...</body>` only.
- **Well-formed XML**: closed tags, quoted attributes, case-sensitive tag names.
- **`xmllint --noout` passing does not mean Asana accepts it** — unsupported tags still return `400` / `"XML is invalid"`.

## Allowed tags (tasks)

`body`, `strong`, `em`, `u`, `s`, `code`, `ol`, `ul`, `li`, `a`, `blockquote`, `pre`, `h1`, `h2`, `hr/`, `img`

## Forbidden / rejected

- **`<p>` and `<br>`** — not in the allow-list; they cause API rejection. Use block elements (`h1`, `h2`, lists) and raw text/newlines between blocks instead of paragraphs.
- **Attributes on any tag except `<a>`** — e.g. no `data-asana-gid` on `<a>` is fine; no `class`, `id`, or `style` anywhere.
- Tags outside the list above (`motion.div`, `span`, `motion.h1`, etc.).

## Nesting (Asana rejects invalid nesting)

- Do **not** put `h1`, `h2`, `blockquote`, or `pre` **inside** `li`.
- Do **not** put `ul`, `ol`, or `li` **inside** `h1`, `h2`, `blockquote`, or `pre`.
- Keep headings and lists as **siblings** under `body`, not wrappers around each other.

## Links (`<a>` only tag with attributes)

**External URLs** — `href` only on `<a>`; escape `&` in URLs as `&amp;`:

```html
<a href="https://github.com/search?q=org%3Aexample-org+foo&amp;type=code"
  >search</a
>
```

### Asana task links (preferred: dynamic)

When linking to other Asana tasks in `html_notes`, **prefer dynamic task links** unless the user
specifically asks for custom link text.

- **Do not** put bare task URLs in `html_notes` and expect rich links — the API does not
  auto-convert them (unlike pasting URLs in the Asana UI).
- **Do** use `<a>` with `data-asana-gid` and `data-asana-dynamic="true"` (or omit
  `data-asana-dynamic`; `true` is the default). Asana resolves the task title and rich preview.
- Include `href` with the full task URL (project path + `?focus=true` when known). Asana may
  normalize `href` on save; the rich link still works.
- Set `data-asana-type="task"`.
- Optional `data-asana-project` when linking in project context.
- No extra whitespace after `</a>` before punctuation (e.g. `</a>).` not `</a> ).`).

**Recommended (dynamic task link):**

```html
<a
  href="https://app.asana.com/1/{workspace_gid}/project/{project_gid}/task/{task_gid}?focus=true"
  data-asana-gid="{task_gid}"
  data-asana-type="task"
  data-asana-dynamic="true"
  >Example task title</a
>
```

The inner text can be the current task title; Asana may rewrite it when saving. Minimal form also
works:

```html
<a data-asana-gid="{task_gid}" data-asana-project="{project_gid}" />
```

**Custom link text** — only when the user explicitly wants a vanity label:

```html
<a
  data-asana-gid="{task_gid}"
  data-asana-dynamic="false"
  data-asana-project="{project_gid}"
  >Custom link text</a
>
```

If you lack access to the referenced object, you **must** supply `href` or the request fails.

## Minimal valid example

```html
<body>
  <strong>Meta:</strong>
  Short intro text without p tags.
  <h1>Section</h1>
  <ul>
    <li><strong>Item:</strong> detail with <code>inline code</code></li>
  </ul>
  <ol>
    <li>Step one</li>
  </ol>
</body>
```

## MCP workflow

1. Build XML using only allowed tags and nesting rules.
2. Validate with `xmllint --noout` on the fragment.
3. Call `update_tasks` / `create_tasks` with `html_notes` string (JSON-escape as needed).
4. On failure, check for `<p>`, disallowed attributes, bad nesting, or unescaped `&` in `href`.
5. To **read** formatted descriptions, call `get_task` with `opt_fields=html_notes` — the `notes`
   field is plain text only and strips markup/link structure.

**Reference:** [Asana Rich text](https://developers.asana.com/docs/rich-text)
