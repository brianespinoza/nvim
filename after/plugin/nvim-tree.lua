-- explorer 
-- see below for keybindings
require("nvim-tree").setup { -- BEGIN_DEFAULT_OPTS

      on_attach = "default",
      hijack_cursor = false,
      auto_reload_on_write = true,
      disable_netrw = false,
      hijack_netrw = true,
      hijack_unnamed_buffer_when_opening = false,
      root_dirs = {},
      prefer_startup_root = false,
      sync_root_with_cwd = false,
      reload_on_bufenter = false,
      respect_buf_cwd = false,
      select_prompts = false,
      sort = {
        sorter = "name",
        folders_first = true,
        files_first = false,
      },
      view = {
        centralize_selection = false,
        cursorline = true,
        debounce_delay = 15,
        side = "right",
        preserve_window_proportions = false,
        number = false,
        relativenumber = false,
        signcolumn = "yes",
        width = 40,
        float = {
          enable = false,
          quit_on_focus_loss = true,
          open_win_config = {
            relative = "editor",
            border = "rounded",
            width = 30,
            height = 30,
            row = 1,
            col = 1,
          },
        },
      },
      renderer = {
        add_trailing = false,
        group_empty = false,
        full_name = false,
        root_folder_label = ":~:s?$?/..?",
        indent_width = 2,
        special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
        symlink_destination = true,
        highlight_git = false,
        highlight_diagnostics = false,
        highlight_opened_files = "none",
        highlight_modified = "none",
        highlight_bookmarks = "none",
        highlight_clipboard = "name",
        indent_markers = {
          enable = true,
          inline_arrows = true,
          icons = {
            corner = "└",
            edge = "│",
            item = "│",
            bottom = "─",
            none = " ",
          },
        },
        icons = {
          web_devicons = {
            file = {
              enable = true,
              color = true,
            },
            folder = {
              enable = true,
              color = true,
            },
          },
          git_placement = "before",
          modified_placement = "before",
          diagnostics_placement = "signcolumn",
          bookmarks_placement = "signcolumn",
          padding = " ",
          symlink_arrow = " ➛ ",
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
            modified = true,
            diagnostics = true,
            bookmarks = true,
          },
          glyphs = {
            default = "",
            symlink = "",
            bookmark = "󰆤",
            modified = "●",
            folder = {
              arrow_closed = "",
              arrow_open = "",
              default = "",
              open = "",
              empty = "",
              empty_open = "",
              symlink = "",
              symlink_open = "",
            },
            git = {
              unstaged = "✗",
              staged = "✓",
              unmerged = "",
              renamed = "➜",
              untracked = "★",
              deleted = "",
              ignored = "◌",
            },
          },
        },
      },
      hijack_directories = {
        enable = true,
        auto_open = true,
      },
      update_focused_file = {
        enable = false,
        update_root = false,
        ignore_list = {},
      },
      system_open = {
        cmd = "",
        args = {},
      },
      git = {
        enable = true,
        show_on_dirs = true,
        show_on_open_dirs = true,
        disable_for_dirs = {},
        timeout = 400,
        cygwin_support = false,
      },
      diagnostics = {
        enable = false,
        show_on_dirs = false,
        show_on_open_dirs = true,
        debounce_delay = 50,
        severity = {
          min = vim.diagnostic.severity.HINT,
          max = vim.diagnostic.severity.ERROR,
        },
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },
      modified = {
        enable = false,
        show_on_dirs = true,
        show_on_open_dirs = true,
      },
      filters = {
        git_ignored = true,
        dotfiles = false,
        git_clean = false,
        no_buffer = false,
        custom = {},
        exclude = {},
      },
      live_filter = {
        prefix = "[FILTER]: ",
        always_show_folders = true,
      },
      filesystem_watchers = {
        enable = true,
        debounce_delay = 50,
        ignore_dirs = {},
      },
      actions = {
        use_system_clipboard = true,
        change_dir = {
          enable = true,
          global = false,
          restrict_above_cwd = false,
        },
        expand_all = {
          max_folder_discovery = 300,
          exclude = {},
        },
        file_popup = {
          open_win_config = {
            col = 1,
            row = 1,
            relative = "cursor",
            border = "shadow",
            style = "minimal",
          },
        },
        open_file = {
          quit_on_open = false,
          eject = true,
          resize_window = true,
          window_picker = {
            enable = true,
            picker = "default",
            chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
            exclude = {
              filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
              buftype = { "nofile", "terminal", "help" },
            },
          },
        },
        remove_file = {
          close_window = true,
        },
      },
      trash = {
        cmd = "gio trash",
      },
      tab = {
        sync = {
          open = false,
          close = false,
          ignore = {},
        },
      },
      notify = {
        threshold = vim.log.levels.INFO,
        absolute_path = true,
      },
      help = {
        sort_by = "key",
      },
      ui = {
        confirm = {
          remove = true,
          trash = true,
          default_yes = false,
        },
      },
      experimental = {},
      log = {
        enable = false,
        truncate = false,
        types = {
          all = false,
          config = false,
          copy_paste = false,
          dev = false,
          diagnostics = false,
          git = false,
          profile = false,
          watcher = false,
        },
      },
    } -- END_DEFAULT_OPTS


-- Function to open the selected file from nvim-tree in a new tab and close nvim-tree
local function open_in_new_tab()
    local lib = require("nvim-tree.lib")
    local node = lib.get_node_at_cursor()
    if node then
        -- Close nvim-tree
        vim.cmd(":NvimTreeClose")

        -- Open the file in a new tab
        vim.cmd("tabnew " .. node.absolute_path)
    end
end

-- Set keymap for nvim-tree
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'NvimTree',
    callback = function()
        vim.keymap.set('n', 'T', open_in_new_tab, { silent = true, buffer = true })
    end,
})

-- `<C-]>`           CD                         |nvim-tree-api.tree.change_root_to_node()|
-- `<C-e>`           Open: In Place             |nvim-tree-api.node.open.replace_tree_buffer()|
-- `<C-k>`           Info                       |nvim-tree-api.node.show_info_popup()|
-- `<C-r>`           Rename: Omit Filename      |nvim-tree-api.fs.rename_sub()|
-- `<C-t>`           Open: New Tab              |nvim-tree-api.node.open.tab()|
-- `<C-v>`           Open: Vertical Split       |nvim-tree-api.node.open.vertical()|
-- `<C-x>`           Open: Horizontal Split     |nvim-tree-api.node.open.horizontal()|
-- `<BS>`            Close Directory            |nvim-tree-api.node.navigate.parent_close()|
-- `<CR>`            Open                       |nvim-tree-api.node.open.edit()|
-- `<Tab>`           Open Preview               |nvim-tree-api.node.open.preview()|
-- `>`               Next Sibling               |nvim-tree-api.node.navigate.sibling.next()|
-- `<`               Previous Sibling           |nvim-tree-api.node.navigate.sibling.prev()|
-- `.`               Run Command                |nvim-tree-api.node.run.cmd()|
-- `-`               Up                         |nvim-tree-api.tree.change_root_to_parent()|
-- `a`               Create                     |nvim-tree-api.fs.create()|
-- `bd`              Delete Bookmarked          |nvim-tree-api.marks.bulk.delete()|
-- `bt`              Trash Bookmarked           |nvim-tree-api.marks.bulk.trash()|
-- `bmv`             Move Bookmarked            |nvim-tree-api.marks.bulk.move()|
-- `B`               Toggle Filter: No Buffer   |nvim-tree-api.tree.toggle_no_buffer_filter()|
-- `c`               Copy                       |nvim-tree-api.fs.copy.node()|
-- `C`               Toggle Filter: Git Clean   |nvim-tree-api.tree.toggle_git_clean_filter()|
-- `[c`              Prev Git                   |nvim-tree-api.node.navigate.git.prev()|
-- `]c`              Next Git                   |nvim-tree-api.node.navigate.git.next()|
-- `d`               Delete                     |nvim-tree-api.fs.remove()|
-- `D`               Trash                      |nvim-tree-api.fs.trash()|
-- `E`               Expand All                 |nvim-tree-api.tree.expand_all()|
-- `e`               Rename: Basename           |nvim-tree-api.fs.rename_basename()|
-- `]e`              Next Diagnostic            |nvim-tree-api.node.navigate.diagnostics.next()|
-- `[e`              Prev Diagnostic            |nvim-tree-api.node.navigate.diagnostics.prev()|
-- `F`               Clean Filter               |nvim-tree-api.live_filter.clear()|
-- `f`               Filter                     |nvim-tree-api.live_filter.start()|
-- `g?`              Help                       |nvim-tree-api.tree.toggle_help()|
-- `gy`              Copy Absolute Path         |nvim-tree-api.fs.copy.absolute_path()|
-- `H`               Toggle Filter: Dotfiles    |nvim-tree-api.tree.toggle_hidden_filter()|
-- `I`               Toggle Filter: Git Ignore  |nvim-tree-api.tree.toggle_gitignore_filter()|
-- `J`               Last Sibling               |nvim-tree-api.node.navigate.sibling.last()|
-- `K`               First Sibling              |nvim-tree-api.node.navigate.sibling.first()|
-- `m`               Toggle Bookmark            |nvim-tree-api.marks.toggle()|
-- `o`               Open                       |nvim-tree-api.node.open.edit()|
-- `O`               Open: No Window Picker     |nvim-tree-api.node.open.no_window_picker()|
-- `p`               Paste                      |nvim-tree-api.fs.paste()|
-- `P`               Parent Directory           |nvim-tree-api.node.navigate.parent()|
-- `q`               Close                      |nvim-tree-api.tree.close()|
-- `r`               Rename                     |nvim-tree-api.fs.rename()|
-- `R`               Refresh                    |nvim-tree-api.tree.reload()|
-- `s`               Run System                 |nvim-tree-api.node.run.system()|
-- `S`               Search                     |nvim-tree-api.tree.search_node()|
-- `u`               Rename: Full Path          |nvim-tree-api.fs.rename_full()|
-- `U`               Toggle Filter: Hidden      |nvim-tree-api.tree.toggle_custom_filter()|
-- `W`               Collapse                   |nvim-tree-api.tree.collapse_all()|
-- `x`               Cut                        |nvim-tree-api.fs.cut()|
-- `y`               Copy Name                  |nvim-tree-api.fs.copy.filename()|
-- `Y`               Copy Relative Path         |nvim-tree-api.fs.copy.relative_path()|
-- `<2-LeftMouse>`   Open                       |nvim-tree-api.node.open.edit()|
-- `<2-RightMouse>`  CD                         |nvim-tree-api.tree.change_root_to_node()|
