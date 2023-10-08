-- Use protected call so we know where error is coming from
local status_ok, neoscroll = pcall(require, "neoscroll")
if not status_ok then
    vim.notify("neoscroll plugin was not found!")
    return
end

neoscroll.setup {
    mappings = {'<C-u>', -- scroll up
    '<C-d>', -- scroll down
    '<C-b>', -- page up
    '<C-f>', -- page down
    '<C-y>', -- half page up
    '<C-e>', -- half page down
    'zt', -- scroll to top
    'zz', -- scroll to center
    'zb' -- scroll to bottom
    },
    hide_cursor = true, -- hide cursor while scrolling
    stop_eof = true, -- stop at <EOF> when scrolling downwards
    use_local_scrolloff = false, -- use the local scope of scrolloff instead of the global scope
    respect_scrolloff = false, -- stop scrolling when the cursor reaches the scrolloff margin of the file
    cursor_scrolls_alone = true, -- the cursor will keep on scrolling even if the window cannot scroll further
    easing_function = nil, -- default easing function
    pre_hook = nil, -- function to run before the scrolling animation starts
    post_hook = nil -- function to run after the scrolling animation ends
}
