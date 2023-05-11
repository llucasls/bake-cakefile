export compose = (fns...) ->
    (value) -> fns.reduceRight(((acc, fn) -> fn(acc)), value)


export resolve_imports = (code, filepath) ->
    lines = code.trim().split("\n")
    output_lines = []
    for line, index in lines
        if line.slice(0, 7) == "import "
            module_path = line.split(" from ")[1].slice(1, -1)
            if path.extname(module_path) == "" and module_path[0] == "."
                new_path = module_path + ".js"
                output_lines.push(line.replace(module_path, new_path))
            else
                output_lines.push(line)
        else
            output_lines.push(line)

    output_lines.join("\n")
