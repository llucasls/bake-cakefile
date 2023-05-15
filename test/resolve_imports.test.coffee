import { strict as assert } from "node:assert"
import test from "node:test"
import { describe } from "node:test"
import path from "path"

import { resolve, Resolver } from "../.dist/index.js"


describe("Test class made to resolve imports", ->
    code = """import { Controller } from './controller.js'
import Service from './service.js'
import "dotenv/config"
const variable = 123;
import { OtherModule } from './other.js'
"""
    test("return an array with matched lines", ->
        assert.deepEqual(
            Resolver.resolve_imports(code),
            ["import { Controller } from './controller.js'"
            "import Service from './service.js'"
            'import "dotenv/config"'
            "import { OtherModule } from './other.js'"]
        )
    )
)


describe("Test resolve_imports function", ->
    resolve_src = resolve("src", ".dist")
    resolve_test = resolve("test", ".spec")

    test("return path from compiled .coffee file", ->
        input = 'import lib from "./src/index.coffee"'
        output = 'import lib from "./.dist/index.js"'

        assert.equal(resolve_src(input), output)
    )

    test("return path from directory", ->
        input = 'import lib from "./src"'
        output = 'import lib from "./.dist/index.js"'

        assert.equal(resolve_src(input), output)
    )
)
