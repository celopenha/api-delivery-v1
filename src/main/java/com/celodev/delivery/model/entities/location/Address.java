package com.celodev.delivery.model.entities.location;

import java.util.List;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import com.celodev.delivery.model.entities.restaurant.Restaurant;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity(name = "tb_address")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Address {
  

  @Id
  @GeneratedValue(strategy = GenerationType.IDENTITY)
  private Integer postcode;
  private Integer number;
  private String street;


  @OneToMany(mappedBy = "address")
  private List<Restaurant> restaurants;

  @ManyToOne
  private Province province;
}
