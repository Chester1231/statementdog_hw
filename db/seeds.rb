# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# US stocks
Stock.create(ticker: "AAPL", market_type: "us", exchange_market: "NASDAQ", company_name: "AAPL Inc.", company_description: "AAPL company")
Stock.create(ticker: "TSLA", market_type: "us", exchange_market: "NASDAQ", company_name: "TSLA Inc.", company_description: "TSLA company")
Stock.create(ticker: "NVDA", market_type: "us", exchange_market: "NASDAQ", company_name: "NVIDIA Corporation", company_description: "NVDA company")
Stock.create(ticker: "GRBK", market_type: "us", exchange_market: "NYSE", company_name: "Green Brick Partners, Inc.", company_description: "GRBK company")
Stock.create(ticker: "CUBS", market_type: "us", exchange_market: "NYSE_Arca", company_name: "CUSTOMERS BANCOP INC", company_description: "CUBS company")
Stock.create(ticker: "GPAQ", market_type: "us", exchange_market: "NASDAQ", company_name: "GORDON POINTE ACQUISITION CORP", company_description: "GPAQ company", deleted_at: Time.new(2020, 7, 5, 6, 30))

# TW stocks
Stock.create(ticker: "2330", market_type: "tw", exchange_market: "TWSE", company_name: "台積電", company_description: "台積電 公司描述")
Stock.create(ticker: "2454", market_type: "tw", exchange_market: "TWSE", company_name: "聯發科", company_description: "聯發科 公司描述")
Stock.create(ticker: "2308", market_type: "tw", exchange_market: "TWSE", company_name: "台達電", company_description: "台達電 公司描述")
Stock.create(ticker: "2311", market_type: "tw", exchange_market: "TWSE", company_name: "日月光", company_description: "日月光 公司描述", deleted_at: Time.new(2018, 4, 30))
