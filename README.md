# Demo for SignedDistanceFunction.jl


```
.
├── Demo.mp4
├── README.md
├── SDF_API
├── client
└── painting-board
```

- SDF_API
  - backend application. It includes SignedDistanceFunction.jl
  - The endpoint is often `http://127.0.0.1:8000` automatically.
- client
  - Simple Client scripts in julia.
- painting-board
  - painting circle for debug data, request SDF_API to generate Signed Distance Function. It is Svelte.js apps.
  - API endpoint is set `http://127.0.0.1:8000`, but the endpoint may not be correct, so make sure you check the endpoint when you start the API.


## Usage

terminal1

`$ julia SDF_API/src/SDF_API.jl`

terminal2

`$ cd painting-board`  
`$ npm run dev:host`




