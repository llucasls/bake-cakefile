compose = require("./compose")


filter_tap_header = (text) -> text.split("\n").slice(1).join("\n")


colorize_skip = (text) -> text.replace(/^(\s*ok|\s*not ok)(.*) # SKIP$/gm,
    (match, ok, message) -> "\x1b[1;33m \x1b[00m#{message}")


colorize_todo = (text) -> text.replace(/^(\s*ok|\s*not ok)(.*) # TODO$/gm,
    (match, ok, message) -> "\x1b[1;35m󰗎 \x1b[00m#{message}")


colorize_ok = (text) -> text.replace(/^\s*ok/gm,
    (match) -> match.replace(/ok/g, "\x1b[1;32m✔ \x1b[00m"))


colorize_not_ok = (text) -> text.replace(/^\s*not ok/gm,
    (match) -> match.replace(/not ok/g, "\x1b[1;31m✖ \x1b[00m"))


colorize_results = (text) -> text.replace(/^# (\w+) 0$/gm,
    (match, word) -> "# #{word} \x1b[90m0\x1b[39m")


colorize_pass = (text) -> text.replace(/^(# pass) (\d+)$/gm,
    (match, prefix, number) -> "#{prefix} \x1b[32m#{number}\x1b[39m")


colorize_fail = (text) -> text.replace(/^(# fail) (\d+)$/gm,
    (match, prefix, number) -> "#{prefix} \x1b[31m#{number}\x1b[39m")


colorize_skipped = (text) -> text.replace(/^(# skipped) (\d+)$/gm,
    (match, prefix, number) -> "#{prefix} \x1b[33m#{number}\x1b[39m")


colorize_todo_res = (text) -> text.replace(/^(# todo) (\d+)$/gm,
    (match, prefix, number) -> "#{prefix} \x1b[35m#{number}\x1b[39m")


colorize_cancelled = (text) -> text.replace(/^(# cancelled) (\d+)$/gm,
    (match, prefix, number) -> "#{prefix} \x1b[31m#{number}\x1b[39m")


colorize = compose(
    colorize_cancelled,
    colorize_todo_res,
    colorize_skipped,
    colorize_fail,
    colorize_pass,
    colorize_results,
    colorize_not_ok,
    colorize_ok,
    colorize_todo,
    colorize_skip,
    filter_tap_header,
)


module.exports = (text) ->
    if process.stdout.isTTY
        colorize(text)
    else
        text
