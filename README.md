# interfaces/*.idl auto-updater

This repo copies `*.idl` files from [reffy-reports](https://github.com/tidoust/reffy-reports)
into [interfaces/](https://github.com/web-platform-tests/wpt/tree/master/interfaces) in wpt.

## Running locally

You need Python 2 and pip:
```bash
sudo apt install python python-pip
```

Then install the dependencies:
```bash
pip install --user -r requirements.txt
```

The python scripts need `GH_TOKEN` environment variable set to a
[personal access token](https://github.com/settings/tokens/new) with the
"Access public repositories" (public_repo) scope enabled.

Then, run `bash update.sh`.
