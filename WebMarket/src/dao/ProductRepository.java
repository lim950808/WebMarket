package dao;

import java.util.ArrayList;

import dto.Product;
//싱글톤으로 생성
public class ProductRepository {
//자신타입의 private static 필드 선언 
private static ProductRepository instance = new ProductRepository();
//public 접근지정자를 가진 getInstance메소드 선언
public static ProductRepository getInstance() {
	return instance;
}
//필드
private ArrayList<Product> listOfProducts = new ArrayList<>();
//생성자 private
	public ProductRepository() {
		Product phone = new Product("P1234", "iPhone 6s", 800000);
		phone.setDescription("4.7-inch, 1334X750 Renina HD display, 8-megapixel iSight Camera");
		phone.setCategory("Smart Phone");
		phone.setManufacturer("Apple");
		phone.setUnitsInStock(1000);
		phone.setCondition("New");
		phone.setFilename("P1234.png");

		Product notebook = new Product("P1235", "LG PC 그램", 1500000);
		notebook.setDescription("13.3-inch, IPS LED display, 5rd Generation Intel Core processors");
		notebook.setCategory("Notebook");
		notebook.setManufacturer("LG");
		notebook.setUnitsInStock(1000);
		notebook.setCondition("Refurbished");
		notebook.setFilename("P1235.png");

		Product tablet = new Product("P1236", "Galaxy Tab S", 900000);
		tablet.setDescription("212.8*125.6*6.6mm,  Super AMOLED display, Octa-Core processor");
		tablet.setCategory("Tablet");
		tablet.setManufacturer("Samsung");
		tablet.setUnitsInStock(1000);
		tablet.setCondition("Old");
		tablet.setFilename("P1236.png");

		listOfProducts.add(phone);
		listOfProducts.add(notebook);
		listOfProducts.add(tablet);
	}
	
	//상품 리스트 출력 메소드
	public ArrayList<Product> getAllProducts() {
		return listOfProducts;
	}
	
	//상품 id로 상품 상세정보 얻기
	 public Product getProductById(String productId) {
		 Product productById = null;
	    for(int i=0;i<listOfProducts.size();i++) {
	    	 Product product = listOfProducts.get(i);
	    	 if(product !=null && product.getProductId()!=null && product.getProductId().equals(productId)) {
	    		 productById = product;
	    		 break;
			 }
		}
	return productById;
	}
	 
	 //상품등록
	 public void addProduct(Product product) {
		 listOfProducts.add(product);
	 }
}