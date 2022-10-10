<%@ page import="java.util.*"%>
<%@ page import="main.resources.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
User auth = (User) request.getSession().getAttribute("auth");
if (auth != null) {
	request.setAttribute("auth", auth);
}

ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
List<Cart> cartProduct = null;
if(cart_list !=null) {
	ProductDao pDao = new ProductDao(DBCon.getConnection());
	cartProduct = pDao.getCartProducts(cart_list);
	double total = pDao.getTotalCartPrice(cart_list);
	request.setAttribute("cart_list", cart_list);
	request.setAttribute("total", total);
}
%>
<!DOCTYPE html>
<html>
<head>
<title>Cosul de cumparaturi</title>
<%@include file="includes/head.jsp"%>
<style type="text/css">
.table tbody td {
vartical-align: middle;
}
.btn-incre, .btn-decre {
box-shadow: none;
font-size:25px;
}
</style>
</head>
<body>
	<%@include file="includes/navbar.jsp"%>

	<div class="container">
		<div class="d-flex py-3">
			<h3>Cost total: ${ (total>0)?total:0 } RON</h3>
			<a class="mx-3 btn btn-primary" href="#">Verifica</a>
		</div>
		<table class="table table-light">
			<thead>
				<tr>
					<th scope="col">Denumire</th>
					<th scope="col">Categorie</th>
					<th scope="col">Pret</th>
					<th scope="col">Cumpara</th>
					<th scope="col">Anuleaza</th>
				</tr>
			</thead>
			<tbody>
			<%if(cart_list != null) {
				for(Cart c:cartProduct) {%>
					<tr>
					<td><%= c.getName() %></td>
					<td><%= c.getCategory() %></td>
					<td><%= c.getPrice() %> RON</td>
					<td>
						<form action="" method="post" class="form-inline">
							<input type="hidden" name="id" value="<%= c.getId() %>" class="form-input">
							<div class="form-group d-flex justify-content-between">
								<a class="btn btn-sm btn-decre" href="quantity-inc-dec"><i class="fas fa-minus-square"></i></a>
								<input type="text" name="quantity" class="form-control" value="1" readonly>
								<a class="btn btn-sm btn-incre" href="quantity-inc-dec"><i class="fas fa-plus-square"></i></a>
							</div>
						</form>
					</td>
					<td><a class="btn btn-sm btn-danger" href="">Sterge</a> </td>
				</tr>
				<%}
				}%>
			
				
			</tbody>
		</table>

	</div>

	<%@include file="includes/footer.jsp"%>
</body>
</html>