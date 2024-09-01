return {
    -- Evaluate markdown code blocks
    "jubnzv/mdeval.nvim",
    event = "VeryLazy",
    keys = {
        { "<leader>cB", "<cmd>MdEval<cr>", desc = "Evaluate Code Block (mdeval)" }
    },
    cmd = "MdEval",
    opts = {
        require_confirmation = false,
        results_label = "*Evaluation Results:*",
        eval_options = {
            cpp = {
                command = { "clang++", "-std=c++20", "-o0" },
                language_code = "cpp",
                extension = "cpp",
                default_header = [[
                #include <iostream>
                #include <vector>
                using namespace std;
                ]]
            },
            python = {
                command = { "python3" },
                language_code = "python",
                extension = "py",
            }
        }
    }
}
