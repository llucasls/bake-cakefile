fs = require("fs")
path = require("path")
cp = require("child_process")
coffee = require("coffeescript")
colorize = require("./colorize")


option("-c", "--compile [PATH]", "directory or file to compile")
option("-o", "--output [PATH]", "directory of file path for compiled code")
option("-p", "--path [PATH]", "file path")


colorize_test = (text) ->
    if process.stdout.isTTY
        return colorize(text)

    text


task("test", "run automated tests", ->
    coffee_bin = "node_modules/.bin/coffee"
    test_dir = "test/"
    spec_dir = ".spec/"
    for file in fs.readdirSync(spec_dir)
        file_path = path.join(spec_dir, file)
        fs.rmSync(file_path, force: yes, recursive: yes)

    cp.execFileSync(coffee_bin, ["-o", spec_dir, "-c", test_dir])

    if process.stdout.isTTY
        test_reporter = "spec"
    else
        test_reporter = "tap"
    try
        result = cp.execSync("node --test", encoding: "UTF-8")
    catch error
        result = error.stdout

    result = colorize_test(result).trim()

    console.log(result)
)
