-- 转换插件，日志查看窗口右键可将选中文件进行转换转义等操作

-- 正则提取数字 --
function Extract_Numbers(content)
    local start, iend = regex.search("\\d+", content)
    if start == nil then
        error("未匹配到数字", 2)
    end
    return content:sub(start, iend)
end

-- 时间戳转日期 --
local function timestamp2date(content)
    local value = Extract_Numbers(content)
    local times = tonumber(value)
    local date = os.date("%Y-%m-%d %H:%M:%S", times)
    return string.format("%s -> %s", value, date)
end

-- 十进制转十六进制 --
local function int2hex(content)
    local value  = Extract_Numbers(content)
    local number = tonumber(value)
    if number == 0 then return "0" end
    local hex = ""
    local hexChars = "0123456789ABCDEF"
    while number > 0 do
        local mod = number % 16
        hex = string.sub(hexChars, mod + 1, mod + 1) .. hex
        number = math.floor(number / 16)
    end
    return hex
end

-- 十六进制转字符串 --
local function hex2str(content)
    local ba = bytearray.fromhex(content)
    return ba:str()
end

-- 十六进制格式化 --
local function hex2format(content)
    local ba = bytearray.fromhex(content)
    return ba:hex(true, true, 16)
end

-- 手动注释 --
local function manual_annotation(content)
    return sys.msgbox("query", "手动注释", "请输入注释内容")
end

-- BASE64转HEX --
local function base642hex(content)
    local ba = bytearray.frombase64(content)
    return ba:hex(true, true, 16)
end

-- 初始化转换插件脚本 --
local function convert_init()
    convert.clean() -- 先清理插件
    convert.register(manual_annotation, "手动添加注释")
    convert.subitem("字符串格式转换")
    convert.register(timestamp2date, "时间戳转日期")
    convert.register(hex2str, "HEX转ASCII")
    convert.register(hex2format, "HEX提取并格式化")
    convert.register(int2hex, "INT转HEX")
    convert.register(base642hex, "BASE64转HEX")
    convert.subitem(nil) -- 退出子菜单
end

-- 转换插件子模块扫描加载 --
local function convert_scan()
    local command = string.format('dir /b /ad "%s"', package.spath)
    for dir in io.popen(command):lines() do
        local path = string.format("%s\\%s\\init.lua", package.spath, dir)
        local file = io.open(path, "r")
        if file then              -- 检查文件是否存在
            file:close()
            print("dofile", path) -- 打印加载路径
            dofile(path)          -- 执行文件，加载插件
        end
    end
end

convert_init()
convert_scan()
