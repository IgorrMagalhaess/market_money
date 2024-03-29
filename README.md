# Market Money API

Market Money API is a Rails API project developed to provide functionality for finding sustainable and local alternatives for lifestyle choices, particularly focusing on farmers markets and vendors. This API allows users to access information about markets, vendors, and market-vendor relationships.

## Setup

### Prerequisites
- Ruby (version >= 2.5.0)
- Rails (version >= 5.2.0)
- PostgreSQL

### Installation
1. Clone the repository:

    ```bash
    git clone <repository_url>
    ```

2. Install dependencies:

    ```bash
    bundle install
    ```

3. Set up the database:

    ```bash
    rails db:setup
    ```

## Usage
- Start the server:

    ```bash
    rails server
    ```

- Access the API endpoints via http://localhost:3000/api/v0/

## Endpoints

### ReSTful Endpoints

#### Market Endpoints
- `GET /api/v0/markets`: Retrieve all markets.
- `GET /api/v0/markets/:id`: Retrieve a specific market by ID.
- `GET /api/v0/markets/:id/vendors`: Retrieve all vendors for a specific market.

#### Vendor Endpoints
- `GET /api/v0/vendors/:id`: Retrieve a specific vendor by ID.
- `POST /api/v0/vendors`: Create a new vendor.
- `PATCH /api/v0/vendors/:id`: Update a specific vendor.
- `DELETE /api/v0/vendors/:id`: Delete a specific vendor.

#### MarketVendor Endpoints
- `POST /api/v0/market_vendors`: Create a market-vendor relationship.
- `DELETE /api/v0/market_vendors/:id`: Delete a market-vendor relationship.

### Non-ReSTful Endpoints

- `GET /api/v0/markets/search?query=<search_query>`: Retrieve markets within a city or state based on a search query.
- `GET /api/v0/atms/nearby?market_id=<market_id>`: Retrieve cash dispensers (ATMs) close to a market location.

## Testing
This project includes automated tests written with RSpec. To run the tests, execute the following command:

```bash
bundle exec rspec
```
## Error Responses

The API follows a standard error response format for 400-series error codes. For example:

```json
{
    "errors": [
        {
            "detail": "Couldn't find Market with 'id'=123123123123"
        }
    ]
}
```

## Contributing
Contributions are welcome! Feel free to open issues or pull requests.

## License
This project is licensed under the MIT License.

