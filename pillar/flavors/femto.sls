#!json

{
"pnda_flavor": {
    "name": "femto",
    "description": "This it the femto PNDA flavor, used for really tiny clusters",

    "states": {
        "gobblin": {
            "max_mappers": 5
        },
        "cdh.setup_hadoop": {
            "template_file": "cfg_femto.py"
        }
    }
}
}
