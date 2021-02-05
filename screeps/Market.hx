package screeps;

import haxe.extern.EitherType;
import screeps.Utils.JsObject;

using screeps.Globals.MarketResource;

using screeps.Globals.ScreepsReturnCode;

using screeps.Globals.OrderConstant;

using screeps.Globals.ResourceConstant;

// No static is available

typedef Transaction = {
	var transactionId:String;
	var time:Int;
	var ?sender:{username:String};
	var ?recipient:{username:String};
	var resourceType:MarketResource;
	var amount:Int;
	var from:String;
	var to:String;
	var description:String;
	var ?order:TransactionOrder;
}

typedef Order = {
	var id:String;
	var created:Int;
	var ?active:Bool;
	var type:String;
	var resourceType:MarketResource;
	var ?roomName:String;
	var amount:Int;
	var remainingAmount:Int;
	var ?totalAmount:Int;
	var price:Int;
}

typedef TransactionOrder = {
	var id:String;
	var type:String;
	var price:Int;
}

typedef OrderFilter = {
	var ?id:String;
	var ?created:Int;
	var ?type:String;
	var ?resourceType:MarketResource;
	var ?roomName:String;
	var ?amount:Int;
	var ?remainingAmount:Int;
	var ?price:Int;
}

typedef PriceHistory = {
	var resourceType:MarketResource;
	var date:String;
	var transactions:Int;
	var volume:Int;
	var avgPrice:Int;
	var stddevPrice:Int;
}

typedef Transactions = Array<Transaction>;
typedef Orders = Array<Order>;
typedef OrderFunction = (o:Order) -> Bool;

/**
 * A global object representing the in-game market. You can use this object to track resource transactions to/from your
 * terminals, and your buy/sell orders. The object is accessible via the singleton Game.market property.
 */
extern class Market {
	/**
	 * Your current credits balance.
	 */
	var credits:Int;

	/**
	 * An array of the last 100 incoming transactions to your terminals
	 */
	var incomingTransactions:Transactions;

	/**
	 * An object with your active and inactive buy/sell orders on the market.
	 */
	var orders:JsObject<Order>;

	/**
	 * An array of the last 100 outgoing transactions from your terminals
	 */
	var outgoingTransactions:Transactions;

	/**
	 * Estimate the energy transaction cost of StructureTerminal.send and Market.deal methods. The formula:
	 *
	 * ```
	 * Math.ceil( amount * (Math.log(0.1*linearDistanceBetweenRooms + 0.9) + 0.1) )
	 * ```
	 *
	 * @param amount Amount of resources to be sent.
	 * @param roomName1 The name of the first room.
	 * @param roomName2 The name of the second room.
	 * @returns The amount of energy required to perform the transaction.
	 */
	public function calcTransactionCost(amount:Int, roomName1:String, roomName2:String):Int;

	/**
	 * Cancel a previously created order. The 5% fee is not returned.
	 * @param orderId The order ID as provided in Game.market.orders
	 * @returns Result Code: OK, ERR_INVALID_ARGS
	 */
	public function cancelOrder(orderId:String):ScreepsReturnCode;

	/**
	 * Change the price of an existing order. If `newPrice` is greater than old price, you will be charged `(newPrice-oldPrice)*remainingAmount*0.05` credits.
	 * @param orderId The order ID as provided in Game.market.orders
	 * @param newPrice The new order price.
	 * @returns Result Code: OK, ERR_NOT_OWNER, ERR_NOT_ENOUGH_RESOURCES, ERR_INVALID_ARGS
	 */
	public function changeOrderPrice(orderId:String, newPrice:Int):ScreepsReturnCode;

	/**
	 * Create a market order in your terminal. You will be charged `price*amount*0.05` credits when the order is placed.
	 *
	 * The maximum orders count is 300 per player. You can create an order at any time with any amount,
	 * it will be automatically activated and deactivated depending on the resource/credits availability.
	 *
	 * An order expires in 30 days after its creation, and the remaining market fee is returned.
	 */
	public function createOrder(params:{
		type:OrderConstant,
		resourceType:MarketResource,
		price:Int,
		totalAmount:Int,
		?roomName:String
	}):ScreepsReturnCode;

	/**
	 * Execute a trade deal from your Terminal to another player's Terminal using the specified buy/sell order.
	 *
	 * Your Terminal will be charged energy units of transfer cost regardless of the order resource type.
	 * You can use Game.market.calcTransactionCost method to estimate it.
	 *
	 * When multiple players try to execute the same deal, the one with the shortest distance takes precedence.
	 */
	public function deal(orderId:String, amount:Int, ?targetRoomName:String):ScreepsReturnCode;

	/**
	 * Add more capacity to an existing order. It will affect `remainingAmount` and `totalAmount` properties. You will be charged `price*addAmount*0.05` credits.
	 * Extending the order doesn't update its expiration time.
	 * @param orderId The order ID as provided in Game.market.orders
	 * @param addAmount How much capacity to add. Cannot be a negative value.
	 * @returns One of the following codes: `OK`, `ERR_NOT_ENOUGH_RESOURCES`, `ERR_INVALID_ARGS`
	 */
	public function extendOrder(orderId:String, addAmount:Int):ScreepsReturnCode;

	/**
	 * Get other players' orders currently active on the market.
	 * @param filter (optional) An object or function that will filter the resulting list using the lodash.filter method.
	 * @returns An array of objects containing order information.
	 */
	public function getAllOrders(?filter:EitherType<OrderFilter, OrderFunction>):Orders;

	/**
	 * Get daily price history of the specified resource on the market for the last 14 days.
	 * @param resource One of the RESOURCE_* constants. If undefined, returns history data for all resources. Optional
	 * @returns An array of objects with resource info.
	 */
	public function getHistory(?resource:ResourceConstant):Array<PriceHistory>;

	/**
	 * Retrieve info for specific market order.
	 * @param orderId The order ID.
	 * @returns An object with the order info. See `getAllOrders` for properties explanation.
	 */
	public function getOrderById(id:String):EitherType<Order, Void>;
}
