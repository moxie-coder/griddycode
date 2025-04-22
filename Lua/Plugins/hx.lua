-- Haxe Reserved Keywords
local reserved_keywords = {
    "abstract", "break", "case", "cast", "catch", "class", "continue", "default", "do", "dynamic",
    "else", "enum", "extends", "extern", "false", "final", "for", "function", "if", "implements",
    "import", "in", "inline", "interface", "macro", "new", "null", "override", "package", "private",
    "public", "return", "static", "super", "switch", "this", "throw", "true", "try", "typedef",
    "untyped", "using", "var", "while"
}

for _, word in ipairs(reserved_keywords) do
    highlight(word, "reserved")
end

-- Haxe Operators
local operators = {
    "+", "-", "*", "/", "%", "++", "--",
    "=", "+=", "-=", "*=", "/=", "%=",
    "==", "!=", ">", "<", ">=", "<=",
    "&&", "||", "!", "&", "|", "^", "~", "<<", ">>",
    "=>", "->", "..."
}

for _, op in ipairs(operators) do
    highlight(op, "operator")
end

-- Special Characters
local specials = {
    "{", "}", "[", "]", "(", ")", ";", ",", ".", ":"
}

for _, char in ipairs(specials) do
    highlight(char, "binary")
end

-- Comments
add_comment("//", "", "comments", true)
add_comment("/*", "*/", "comments", false)

-- Strings and Characters
highlight_region("\"", "\"", "string")
-- highlight_region("'", "'", "string")

-- Autocomplete: Function detection
function detect_functions(content)
    local functionNames = {}

    for line in content:gmatch("[^\r\n]+") do
        -- Matches Haxe functions: function name(...) { or function name(...) return ...
        local func = line:match("function%s+([%w_]+)%s*%(")
        if func then
            table.insert(functionNames, func)
        end
    end

    return functionNames
end

-- Autocomplete: Variable detection
function detect_variables(content)
    local variable_names = {}

    for line in content:gmatch("[^\r\n]+") do
        -- Matches variable declarations like: var name = ..., final name: Type = ...
        local var = line:match("%s*var%s+([%w_]+)")
        if not var then
            var = line:match("%s*final%s+([%w_]+)")
        end
        if var then
            table.insert(variable_names, var)
        end
    end

    return variable_names
end
