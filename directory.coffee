fs   = require("fs")
path = require("path")


is_dir = (input_path) -> fs.statSync(input_path).isDirectory()


tree = (dir, parent = ".", resolve_full_path = no) ->
    if resolve_full_path
        join = path.resolve
    else
        join = path.join

    full_path = join(parent, dir)
    if not is_dir(full_path)
        return [join(parent, dir)]

    result = []
    for file in fs.readdirSync(full_path)
        result.push(tree(file, full_path)...)

    result


get_dist_files = (src_dir, dist_dir, resolve_full_path = no) ->
    result = []
    for file in tree(src_dir, ".", resolve_full_path)
        result.push(file.replace(src_dir, dist_dir).replace(".coffee", ".js"))

    result


get_source = (file, src_dir, dist_dir) ->
    file.replace(dist_dir, src_dir).replace(".js", ".coffee")


exports.is_dir = is_dir
exports.tree = tree
exports.get_dist_files = get_dist_files
exports.get_source = get_source
