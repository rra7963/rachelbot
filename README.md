# RachelBot

**A self-hosted AI workspace for market research, trading automation, and multi-channel assistance.**

RachelBot brings conversational AI, live market data, strategy automation, risk controls, and portfolio tools into one extensible gateway. Use it from the built-in WebChat or connect it to services such as Telegram, Discord, Slack, WhatsApp, Teams, Matrix, Signal, and more.

> **Important:** RachelBot can connect to real trading venues. Start in dry-run mode, use dedicated low-balance accounts, and review every strategy and risk limit before enabling live execution. Nothing in this repository is financial advice.

## Why RachelBot?

- **One assistant, many interfaces** — WebChat plus 20+ messaging integrations.
- **Markets in one place** — prediction markets, perpetual futures, Solana DeFi, and EVM DeFi.
- **Research that can act** — market discovery, arbitrage analysis, whale tracking, copy-trading workflows, and configurable bots.
- **Risk-aware execution** — circuit breakers, daily loss limits, position sizing, stress testing, and a kill switch.
- **Private by default** — self-hosted services with local SQLite storage and optional semantic memory.
- **Extensible** — bundled skills, MCP support, REST/WebSocket APIs, and multiple LLM providers.

## Quick start

### Requirements

- Node.js 22 or newer
- npm
- An API key for at least one supported LLM provider

### Run from source

```bash
git clone https://github.com/rra7963/rachelbot.git
cd rachelbot
npm install
cp .env.example .env
```

Add your model API key to `.env`, then build and start RachelBot:

```bash
npm run build
npm start
```

Open WebChat at [http://localhost:18789/webchat](http://localhost:18789/webchat).

### Guided setup

```bash
npm run onboard
```

The setup wizard walks through model credentials, messaging channels, and gateway configuration.

## Command line

The published package and CLI currently retain the legacy `clodds` command for compatibility:

```bash
clodds onboard        # Interactive setup wizard
clodds start          # Start the gateway
clodds repl           # Open the interactive REPL
clodds doctor         # Run system diagnostics
clodds secure         # Apply security hardening
clodds locale set zh  # Change the interface language
clodds mcp            # Start the MCP server
clodds mcp install    # Configure Claude Desktop/Code
```

See the [User Guide](./docs/USER_GUIDE.md) for the complete command reference.

## RachelBot workspace

### WebChat

RachelBot includes a browser interface with:

- Chats, projects, artifacts, and code views
- Searchable, persistent conversation history
- Automatic extraction of artifacts and code blocks
- Live generation status and elapsed time
- Paginated history for long-running sessions
- Context compacting for extended conversations
- SQLite-backed session management

### AI and memory

RachelBot supports multiple model providers, including Claude, OpenAI-compatible models, Gemini, Groq, Together, Fireworks, AWS Bedrock, and Ollama. Its agent layer separates general assistance, trading, research, and alerts while sharing tools and memory.

Optional memory features include semantic search, embeddings, hybrid retrieval, user profiles, and persistent facts.

### Channels

Connect RachelBot to WebChat, Telegram, Discord, Slack, WhatsApp, Teams, Matrix, Signal, iMessage, LINE, Nostr, Twitch, and other supported channels. Channel adapters support real-time events, rich media, and offline queuing where available.

## Markets and automation

| Area | RachelBot capabilities |
| --- | --- |
| Prediction markets | Polymarket, Kalshi, Betfair, Smarkets, Drift, Manifold, Metaculus, PredictIt, Opinion.xyz, and Predict.fun |
| Perpetual futures | Binance, Bybit, Hyperliquid, MEXC, Drift, Percolator, and Lighter |
| Solana DeFi | Jupiter, Raydium, Orca, Meteora, Kamino, MarginFi, Solend, Pump.fun, and Bags.fm |
| EVM DeFi | Uniswap V3, 1inch, PancakeSwap, and additional protocols across Ethereum, Arbitrum, Optimism, Base, and Polygon |
| Market intelligence | Order books, candles, liquidity, depth, price feeds, whale monitoring, and external signal sources |
| Automation | Scheduled jobs, webhooks, DCA, configurable bots, backtesting, and strategy execution |

Supported venue features vary by integration and jurisdiction. Some integrations provide data only; trading requires separate venue credentials and account eligibility.

### Prediction markets

RachelBot can discover markets, inspect order books, monitor positions, and route supported orders. Specialized crypto-market workflows cover short-duration and daily BTC, ETH, SOL, and XRP markets where available.

### Futures and DeFi

Use chat commands or APIs to research and manage supported perpetual futures, Solana swaps, EVM swaps, lending workflows, and cross-chain transfers. Available leverage, order types, and KYC requirements are controlled by each venue.

### Strategy toolkit

The strategy layer includes building blocks for:

- Momentum and mean reversion
- Market making and expiry-aware execution
- Cross-platform and combinatorial arbitrage analysis
- Dollar-cost averaging and smart routing
- Whale tracking and copy-trading workflows
- Historical backtesting with stop-loss/take-profit validation

RachelBot defaults safety-sensitive workflows to non-live operation where supported. Always confirm the active mode before placing orders.

## Risk and security

RachelBot includes:

- Unified position and exposure checks
- Circuit breakers and configurable daily loss limits
- Kelly-based sizing, VaR/CVaR analysis, and stress testing
- Volatility-regime detection and a global kill switch
- Encrypted credential storage using AES-256-GCM
- Sandboxed command execution with approval controls
- Trade and decision audit logs
- Optional SHA-256 integrity hashes and on-chain anchoring

Recommended operating practices:

1. Begin with dry-run mode.
2. Use separate API keys with the minimum required permissions.
3. Disable withdrawals on exchange keys whenever possible.
4. Set conservative position and daily-loss limits.
5. Review logs and strategy behavior before increasing capital.

## Configuration

Create `.env` from the provided example and add only the integrations you use:

```bash
# Model provider
ANTHROPIC_API_KEY=sk-ant-...

# Optional messaging channels
TELEGRAM_BOT_TOKEN=...
DISCORD_BOT_TOKEN=...

# Optional market integrations
POLYMARKET_API_KEY=...
SOLANA_PRIVATE_KEY=...
```

Local application data is currently stored under `~/.clodds/` for compatibility with existing installations.

Never commit `.env`, private keys, seed phrases, or exchange credentials.

## Architecture

```text
WebChat and messaging channels
             │
             ▼
Gateway: HTTP · WebSocket · authentication · rate limiting
             │
             ▼
RachelBot agents: main · trading · research · alerts
             │
             ▼
Skills and tools: market data · analysis · automation · execution
             │
             ▼
Strategy and risk engine: sizing · limits · backtesting · audit ledger
             │
             ▼
Prediction markets · futures · Solana DeFi · EVM DeFi
             │
             ▼
SQLite · LanceDB · PostgreSQL
```

## MCP and extensions

RachelBot can expose bundled skills as MCP tools for compatible clients. It also supports lazy-loaded extensions so optional integrations do not prevent the core application from starting.

```bash
clodds mcp
clodds mcp install
```

## Development

```bash
npm run dev        # Start with hot reload
npm run typecheck  # Run TypeScript checks
npm test           # Run the test suite
npm run lint       # Run linting
npm run build      # Create a production build
```

### Docker

```bash
docker compose up --build
```

## Documentation

| Document | Description |
| --- | --- |
| [User Guide](./docs/USER_GUIDE.md) | Commands, chat usage, and workflows |
| [API Reference](./docs/API_REFERENCE.md) | HTTP/WebSocket endpoints and authentication |
| [Architecture](./docs/ARCHITECTURE.md) | Components, data flow, and extension points |
| [Deployment](./docs/DEPLOYMENT.md) | Environment variables and production setup |
| [Trading](./docs/TRADING.md) | Execution, bots, and risk controls |
| [Security](./docs/SECURITY_AUDIT.md) | Security hardening and audit checklist |
| [OpenAPI specification](./docs/openapi.yaml) | Machine-readable API definition |

## License

RachelBot is available under the [MIT License](./LICENSE).

---

<p align="center">
  <strong>RachelBot</strong><br>
  <sub>Research clearly. Automate carefully. Stay in control.</sub>
</p>
