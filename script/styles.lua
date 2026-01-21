-- 编辑器样式设置脚本

--[[ 词法分析器配置键值说明（越靠前规则优先级越高）
Rule：规则字符串
MatchCase：匹配大小写
WholeWord：全词匹配
Regexp：正则表达式
Foreground：前景颜色
Background：背景颜色
Bold：粗体
Italic：斜体
Underline：下划线
]]
local lexers = { -- 词法分析器配置
    {Rule="\\[\\d{2}:\\d{2}:\\d{2}\\.\\d{3}\\]", Regexp=true, Foreground="#666678", Background="#eceff8"},
    {Rule="\\d*\\.\\d+([eE][-+]?\\d+)?", Regexp=true, Foreground="#2e7d32"},
    {Rule="[0-9a-fA-F]{2}(:[0-9a-fA-F]{2}){5}", Regexp=true, Foreground="#008c64", Bold=true},
    {Rule="\"\\S+?\"", Regexp=true, Foreground="#009688"},
    {Rule="0[xX][0-9a-fA-F]+", Regexp=true, Foreground="#cc31c9"},
    {Rule="\\b([0-9a-fA-F]{2}\\s)+([0-9a-fA-F]{2})", Regexp=true, Foreground="#ff9800"},
    {Rule="\\b[0-9a-fA-F]{4,}\\b", Regexp=true, Foreground="#3680af"},
    {Rule="\\d+", Regexp=true, Foreground="#3680af"},
    {Rule="info", Foreground="#fbbd01", Italic=true},
    {Rule="debug", Foreground="#01aeed", Underline=true},
    {Rule="error", Foreground="#ff0000", Bold=true},
}

-- 词法分析器初始化函数
local function lexers_init()
    note.clrlexer() -- 清除词法分析器
    for style, lexer in ipairs(lexers) do
        note.setlexer(style, lexer) -- 设置词法分析器
    end
end

lexers_init() -- 初始化词法分析器配置
