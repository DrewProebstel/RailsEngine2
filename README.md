<h1> Rails Engine </h1>

<h3> Rails and Ruby Version </h3>
Rails 5.2.8
Ruby 2.7.4

<h3> Api Endpoints </h3>
<ul>
  <li> get all items                       GET http://localhost:3000/api/v1/items </li>
  <li> get one item                        GET http://localhost:3000/api/v1/items/:item_id </li>
  <li> create an item                      POST http://localhost:3000/api/v1/items/:item_id </li>
  <li> delete an item                      DELETE http://localhost:3000/api/v1/items/:item_id </li>
  <li> update an item                      PUT http://localhost:3000/api/v1/items/:item_id/merchant </li>
  <li> get an items merchant               GET http://localhost:3000/api/v1/items </li>
  <li> find all merchants by name          GET http://localhost:3000/api/v1/merchants/find_all?name={name} </li>
  <li> find one item by name               GET http://localhost:3000/api/v1/items/find?name={name} </li>
  <li> find one item by minimum price      GET http://localhost:3000/api/v1/items/find?min_price={price} </li>
  <li> find one item by maximum price      GET http://localhost:3000/api/v1/items/find?max_price={price} </li>
