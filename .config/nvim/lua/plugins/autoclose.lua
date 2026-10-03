return {
	'm4xshen/autoclose.nvim',
    event = "InsertEnter",
    config = true,
    keys = {
       ["("] = { escape = false, close = true, pair = "()" },
       ["["] = { escape = false, close = true, pair = "[]" },
       ["{"] = { escape = false, close = true, pair = "{}" },
       ["<"] = { escape = false, close = true, pair = "<>" },

       [">"] = { escape = true, close = false, pair = "<>" },
       [")"] = { escape = true, close = false, pair = "()" },
       ["]"] = { escape = true, close = false, pair = "[]" },
       ["}"] = { escape = true, close = false, pair = "{}" },

       ['"'] = { escape = true, close = true, pair = '""' },
       ["'"] = { escape = true, close = true, pair = "''" },
       ["`"] = { escape = true, close = true, pair = "``" },
    },
}
