# Neovim

## Features

- Taking a lot of inspiration from [LazyVim](http://www.lazyvim.org) and
  [Fredrik Averpil](https://github.com/fredrikaverpil/dotfiles/tree/main/nvim-legacy),
  but with the tranquility of maintaining it myself.
- Per-language configs.
- Native LSP definitions (`vim.lsp.config` and `vim.lsp.enable`).
- Native vim folding, using LSP when applicable.
- Snacks.nvim for QoL improvements.
- One unified keymap file.
- And much, much more...

## Try it out! 🚀

> [!NOTE]
>
> I'm not maintaining my Neovim config for anyone besides myself. But I'm making
> it publicly available for others to draw inspiration from! 😊
>
> You will likely see a bunch of errors, as | Column1ools/plugins cannot be
> installed/compiled due to missing binaries.

> [!NOTE]
>
> Requires Neovim >= v0.12.0.

### Minimal installed tools needed

- tree-sitter-cli; `pacman -S tree-sitter-cli`.

*

## Design choices

I wanted to take a modular approach to my Neovim setup. This was made possible
thanks to the quite amazing [lazy.nvim](https://github.com/folke/lazy.nvim)
plugin manager.

### Main initialization

- In [init.lua](init.lua), the entire config is loaded in sequence.
- When loading all plugins, the `spec` (order of loading plugins) is defined in
  [lua/config/lazy.lua](lua/config/lazy.lua):
  1. Any plugin's config from the `plugins` folder.
  2. Plugin configs for a specific language from the `plugins/lang` folder.
  3. Plugin configs for "core" from the `plugins/core` folder.

### Order of plugins loading

You can inspect the order of loading here:
[lua/config/lazy.lua](lua/config/lazy.lua).

#### Generic plugin configs

Plugin configs that are not associated with a certain language or needs complex
setup are considered just to be a "plain" plugin. Their configs are defined in
the [lua/plugins](lua/plugins) folder root.

#### Per-language plugin configs

For a complete and nice experience when working in a certain language,
per-language configs are placed in [lua/plugins/lang](lua/plugins/lang).

Formatting, linting and LSP configs are specified in the per-language plugin
configs. This provides a complete picture of what is supported by browsing a
language config file. Removing a language lua file should remove everything that
is related to that language.

#### Core plugin configs

A "core" plugin config is just a term I came up with for representing a plugin
which defines the `config` as part of its spec, and takes in multiple merged
`opts` defined in several other lua files (such as the per-language configs).
These "core" plugin configs reside in
[lua/plugins/core](lua/plugins/core).

This enables the ability to specify e.g. LSP configs in multiple files, which
are then assembled and loaded in the "core" LSP plugin config.

The end goal is to modularize the entire setup, using these "core" plugin
configs.


# ⌨️ Keymaps

## General

| Key | Description | Mode |
| --- | --- | --- |
| <code>&lt;C-h&gt;</code> | Go to Left Window | **n** |
| <code>&lt;C-j&gt;</code> | Go to Lower Window | **n** |
| <code>&lt;C-k&gt;</code> | Go to Upper Window | **n** |
| <code>&lt;C-l&gt;</code> | Go to Right Window | **n** |
| <code>&lt;C-Up&gt;</code> | Increase Window Height | **n** |
| <code>&lt;C-Down&gt;</code> | Decrease Window Height | **n** |
| <code>&lt;C-Left&gt;</code> | Decrease Window Width | **n** |
| <code>&lt;C-Right&gt;</code> | Increase Window Width | **n** |
| <code>&lt;A-j&gt;</code> | Move Down | **n**, **i**, **v** |
| <code>&lt;A-k&gt;</code> | Move Up | **n**, **i**, **v** |
| <code>&lt;leader&gt;bb</code> | Switch to Other Buffer | **n** |
| <code>&lt;leader&gt;`</code> | Switch to Other Buffer | **n** |
| <code>&lt;leader&gt;bd</code> | Delete Buffer | **n** |
| <code>&lt;leader&gt;bo</code> | Delete Other Buffers | **n** |
| <code>&lt;leader&gt;bi</code> | Delete Invisible Buffers | **n** |
| <code>&lt;leader&gt;bD</code> | Delete Buffer and Window | **n** |
| <code>&lt;esc&gt;</code> | Escape and Clear hlsearch | **i**, **n**, **s** |
| <code>n</code> | Next Search Result | **n**, **x**, **o** |
| <code>N</code> | Prev Search Result | **n**, **x**, **o** |
| <code>&lt;leader&gt;l</code> | Lazy | **n** |
| <code>&lt;leader&gt;fn</code> | New File | **n** |
| <code>&lt;leader&gt;cd</code> | Line Diagnostics | **n** |
| <code>]d</code> | Next Diagnostic | **n** |
| <code>[d</code> | Prev Diagnostic | **n** |
| <code>]e</code> | Next Error | **n** |
| <code>[e</code> | Prev Error | **n** |
| <code>]w</code> | Next Warning | **n** |
| <code>[w</code> | Prev Warning | **n** |
| <code>&lt;leader&gt;uf</code> | Toggle Auto Format (Global) | **n** |
| <code>&lt;leader&gt;uh</code> | Toggle Inlay Hints | **n** |


## LSP

| Key | Description | Mode |
| --- | --- | --- |
| <code>&lt;leader&gt;cl</code> | Lsp Info | **n** |
| <code>gd</code> | Goto Definition | **n**, **n** |
| <code>gr</code> | References | **n**, **n** |
| <code>gI</code> | Goto Implementation | **n**, **n** |
| <code>gy</code> | Goto T[y]pe Definition | **n**, **n** |
| <code>gD</code> | Goto Declaration | **n** |
| <code>K</code> | Hover | **n** |
| <code>gK</code> | Signature Help | **n** |
| <code>&lt;c-k&gt;</code> | Signature Help | **i** |
| <code>&lt;leader&gt;ca</code> | Code Action | **n**, **x** |
| <code>&lt;leader&gt;cI</code> | Show incoming calls| **n** |
| <code>&lt;leader&gt;cO</code> | Show outgoing calls| **n** |
| <code>&lt;leader&gt;ct</code> | Class Hierarchy: Bases| **n** |
| <code>&lt;leader&gt;cT</code> | Class hierarcy: Derived| **n** |
| <code>&lt;leader&gt;ss</code> | LSP Symbols | **n** |
| <code>&lt;leader&gt;sS</code> | LSP Workspace Symbols | **n** |


## [arrow.nvim](https://github.com/otavioschwanck/arrow.nvim)

| Key | Description | Mode |
| --- | --- | --- |
| <code>;</code> | Arrow leader key | **n** |
| <code>m</code> | Arrow buffer leader key | **n** |


## [blink.indent](https://github.com/saghen/blink.indent)


| Key | Description | Mode |
| --- | --- | --- |
| <code>&lt;leader&gt;ug</code> | Toggle blink indent | **n** |

## [bufferline.nvim](https://github.com/akinsho/bufferline.nvim.git)

| Key | Description | Mode |
| --- | --- | --- |
| <code>&lt;leader&gt;bj</code> | Pick Buffer | **n** |
| <code>&lt;leader&gt;bp</code> | Toggle Pin | **n** |
| <code>&lt;leader&gt;bP</code> | Delete Non-Pinned Buffers | **n** |
| <code>&lt;leader&gt;bl</code> | Delete Buffers to the Left | **n** |
| <code>&lt;leader&gt;br</code> | Delete Buffers to the Right | **n** |
| <code>[b</code> | Prev Buffer | **n** |
| <code>[B</code> | Move buffer prev | **n** |
| <code>]b</code> | Next Buffer | **n** |
| <code>]B</code> | Move buffer next | **n** |
| <code>&lt;S-h&gt;</code> | Prev Buffer | **n** |
| <code>&lt;S-l&gt;</code> | Next Buffer | **n** |


## [conform.nvim](https://github.com/stevearc/conform.nvim.git)

| Key | Description | Mode |
| --- | --- | --- |
| <code>&lt;leader&gt;cF</code> | Format Injected Langs | **n**, **x** |


## TODO or research

### LSP


| Key | Description | Mode |
| --- | --- | --- |
| <code>&lt;leader&gt;cA</code> | Source Action | **n** |
| <code>&lt;leader&gt;cR</code> | Rename File | **n** |
| <code>&lt;leader&gt;cr</code> | Rename | **n** |
| <code>&lt;leader&gt;cc</code> | Run Codelens | **n**, **x** |
| <code>&lt;leader&gt;cC</code> | Refresh & Display Codelens | **n** |
| <code>]]</code> | Next Reference | **n** |
| <code>[[</code> | Prev Reference | **n** |
| <code>&lt;a-n&gt;</code> | Next Reference | **n** |
| <code>&lt;a-p&gt;</code> | Prev Reference | **n** |
| <code>gai</code> | C[a]lls Incoming | **n** |
| <code>gao</code> | C[a]lls Outgoing | **n** |
| <code>&lt;leader&gt;co</code> | Organize Imports | **n** |


### general


| Key | Description | Mode |
| --- | --- | --- |
| <code>&lt;leader&gt;-</code> | Split Window Below | **n** |
| <code>&lt;leader&gt;&vert;</code> | Split Window Right | **n** |
| <code>&lt;leader&gt;ui</code> | Inspect Pos | **n** |
| <code>&lt;leader&gt;uI</code> | Inspect Tree | **n** |
| <code>&lt;c-_&gt;</code> | which_key_ignore | **n**, **t** |
| <code>&lt;leader&gt;gL</code> | Git Log (cwd) | **n** |
| <code>&lt;leader&gt;gb</code> | Git Blame Line | **n** |
| <code>&lt;leader&gt;gf</code> | Git Current File History | **n** |
| <code>&lt;leader&gt;gl</code> | Git Log | **n** |
| <code>&lt;leader&gt;gB</code> | Git Browse (open) | **n**, **x** |
| <code>&lt;leader&gt;gY</code> | Git Browse (copy) | **n**, **x** |
| <code>&lt;leader&gt;us</code> | Toggle Spelling | **n** |
| <code>&lt;leader&gt;uw</code> | Toggle Wrap | **n** |
| <code>&lt;leader&gt;uL</code> | Toggle Relative Number | **n** |
| <code>&lt;leader&gt;ud</code> | Toggle Diagnostics | **n** |
| <code>&lt;leader&gt;ul</code> | Toggle Line Numbers | **n** |
| <code>&lt;leader&gt;uc</code> | Toggle Conceal Level | **n** |
| <code>&lt;leader&gt;uA</code> | Toggle Tabline | **n** |
| <code>&lt;leader&gt;uT</code> | Toggle Treesitter Highlight | **n** |
| <code>&lt;leader&gt;ub</code> | Toggle Dark Background | **n** |
| <code>&lt;leader&gt;uD</code> | Toggle Dimming | **n** |
| <code>&lt;leader&gt;ua</code> | Toggle Animations | **n** |
| <code>&lt;leader&gt;ug</code> | Toggle Indent Guides | **n** |
| <code>&lt;leader&gt;uS</code> | Toggle Smooth Scroll | **n** |
| <code>&lt;leader&gt;dpp</code> | Toggle Profiler | **n** |
| <code>&lt;leader&gt;dph</code> | Toggle Profiler Highlights | **n** |
| <code>&lt;leader&gt;uF</code> | Toggle Auto Format (Buffer) | **n** |
| <code>&lt;leader&gt;cf</code> | Format | **n**, **x** |
|<code>&lt;leader&gt;xl</code> | Location List | **n** |
| <code>&lt;leader&gt;xq</code> | Quickfix List | **n** |
| <code>[q</code> | Previous Quickfix | **n** |
| <code>]q</code> | Next Quickfix | **n** |
| <code>gco</code> | Add Comment Below | **n** |
| <code>gcO</code> | Add Comment Above | **n** |
| <code>&lt;leader&gt;K</code> | Keywordprg | **n** |
| <code>&lt;leader&gt;ur</code> | Redraw / Clear hlsearch / Diff Update | **n** |
| <code>&lt;leader&gt;&lt;tab&gt;o</code> | Close Other Tabs | **n** |
| <code>&lt;leader&gt;&lt;tab&gt;f</code> | First Tab | **n** |
| <code>&lt;leader&gt;&lt;tab&gt;&lt;tab&gt;</code> | New Tab | **n** |
| <code>&lt;leader&gt;&lt;tab&gt;]</code> | Next Tab | **n** |
| <code>&lt;leader&gt;&lt;tab&gt;d</code> | Close Tab | **n** |
| <code>&lt;leader&gt;&lt;tab&gt;[</code> | Previous Tab | **n** |
