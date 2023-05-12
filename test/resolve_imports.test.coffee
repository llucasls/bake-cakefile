import { strict as assert } from "node:assert"
import test from "node:test"
import { describe } from "node:test"

import { resolve_imports, Resolver } from "../.dist/index.js"


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
