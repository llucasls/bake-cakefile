fs = require("fs")
path = require("path")
cp = require("child_process")
coffee = require("coffeescript")
main = "./#{require("./package").main}"

colorize = require("./colorize")
{ is_dir, tree, get_dist_files, get_source } = require("./directory")


COFFEE_BIN = "node_modules/.bin/coffee"
SRC_DIR    = "src/"
DIST_DIR   = ".dist/"
TEST_DIR   = "test/"
SPEC_DIR   = ".spec/"
CURDIR     = process.env.PWD
argv       = process.argv.slice(2)


option("-c", "--compile [PATH]", "directory or file to compile")
option("-o", "--output [PATH]", "directory of file path for compiled code")
option("-p", "--path [PATH]", "file path")


task("start", "run main file", ->
    await invoke("build_source")
    await import(main)
)


task("clean_source", "clean compiled source files", ->
    for file in fs.readdirSync(DIST_DIR)
        file_path = path.join(DIST_DIR, file)
        fs.rmSync(file_path, force: yes, recursive: yes)
)


task("clean_test", "clean compiled test files", ->
    for file in fs.readdirSync(SPEC_DIR)
        file_path = path.join(SPEC_DIR, file)
        fs.rmSync(file_path, force: yes, recursive: yes)
)


task("build_source", "compile source files", ->
    await invoke("clean_source")

    cp.execFileSync(COFFEE_BIN, ["-o", DIST_DIR, "-c", SRC_DIR])
)


task("build_test", "compile test files", ->
    await invoke("build_source")
    await invoke("clean_test")

    cp.execFileSync(COFFEE_BIN, ["-o", SPEC_DIR, "-c", TEST_DIR])
)


task("test", "run automated tests", ->
    await invoke("build_test")

    try
        result = cp.execSync("node --test", encoding: "UTF-8")
    catch error
        result = error.stdout

    result = colorize(result).trim()

    console.log(result)
)
