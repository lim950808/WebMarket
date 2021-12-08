package dto;

import java.util.Objects;

public class RecentProduct {
	private String productId;   //상품 아이디
	private String pname;       //상품명
	public RecentProduct() {}
	public RecentProduct(String productId, String pname) {
		this.productId = productId;
		this.pname = pname;
	}
	public String getProductId() {
		return productId;
	}
	public void setProductId(String productId) {
		this.productId = productId;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	
	@Override
	public int hashCode() {
		return Objects.hash(pname, productId);
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		RecentProduct other = (RecentProduct) obj;
		return Objects.equals(pname, other.pname) && Objects.equals(productId, other.productId);
	}
}