# Plop

A tool that uses AI to provide insights and summaries from git repositories.

## Installation

#### Using luarocks:

```bash
luarocks install plop
```

#### Installing development version:

```bash
luarocks install plop-scm-1.rockspec
```

## Usage

### Generate a summary of staged changes:

```bash
lua cli.lua --repository /path/to/repository
```

Set the required environment variables before running:

```bash
export PLOP_OPENAI_BASEURL="https://api.openai.com"
export PLOP_OPENAI_BEARERTOKEN="your-openai-api-key"
```

## Configuration

Plop can be configured via environment variables:

- `PLOP_OPENAI_BASEURL`: OpenAI API base URL
- `PLOP_OPENAI_BEARERTOKEN`: OpenAI API bearer token

## License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for details.