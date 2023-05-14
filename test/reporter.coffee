# https://nodejs.org/dist/latest-v18.x/docs/api/test.html#class-testsstream

test_event = ({ data, type }) ->
    space = "  ".repeat(data.nesting)
    newline = if data.nesting == 0 then "\n\n" else "\n"

    file = data.file or ""
    file_label = if file then "file: \x1b[2m#{file}\x1b[0m" else ""

    todo = if data.todo == "" then "todo" else data.todo
    todo = if not data.todo? then "" else todo

    if data.skip == ""
        skip = "\x1b[1;33m skip\x1b[00m"
    else if data.skip
        skip = "\x1b[1;33m \x1b[0;93m#{data.skip}\x1b[39m"
    else
        skip = ""

    if data.todo == ""
        todo = "\x1b[1;35m󰗎 todo\x1b[00m"
    else if data.todo
        todo = "\x1b[1;35m󰗎 \x1b[0;95m#{data.todo}\x1b[39m"
    else
        todo = ""

    pass = skip or todo or "\x1b[1;32m✔ pass\x1b[0m"

    fail = skip or todo or "\x1b[1;31m✖ fail\x1b[0m"

    message =
        "test:start": """#{newline}#{space}→ testing: #{data.name}
        """
        "test:pass": """\n#{space}#{pass}
        #{space}  #{file_label}
        """
        "test:fail": """\n#{space}#{fail}
        #{space}  #{file_label}
        """
        "test:plan": if data.nesting == 0 then "\n" else ""
        "test:diagnostic": "\n# #{data.message}"
        "test:coverage": ""

    message[type]


export default custom_reporter = (source) ->
    for await event from source
        yield test_event(event)
    return
