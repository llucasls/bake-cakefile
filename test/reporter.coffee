# https://nodejs.org/dist/latest-v18.x/docs/api/test.html#class-testsstream

test_event = ({ data, type }) ->
    ###
    if type == "test:fail"
        console.error data.details
        console.error data.name
        console.error data.details.duration_ms
        console.error data.details.error.failureType
        console.error Object.keys data.details.error
    if type == "test:pass"
        console.error data.details.duration_ms
    ###
    message =
        "test:start": """\nstart:
        name: #{data.name}
        nesting: #{data.nesting}
        file: #{data.file}
        \n"""
        "test:pass": """\npass:
        name: #{data.name}
        nesting: #{data.nesting}
        test_number: #{data.testNumber}
        file: #{data.file}
        \n"""
        "test:fail": """\nfail:
        name: #{data.name}
        nesting: #{data.nesting}
        test_number: #{data.testNumber}
        file: #{data.file}
        \n"""
        "test:plan": """\nplan:
        nesting: #{data.nesting}
        count: #{data.count}
        file: #{data.file}
        \n"""
        "test:diagnostic": """\ndiagnostic:
        nesting: #{data.nesting}
        message: #{data.message}
        file: #{data.file}
        \n"""
        "test:coverage": "coverage: #{Object.keys data}\n"

    message[type]


export default custom_reporter = (source) ->
    for await event from source
        yield test_event(event)
    return
