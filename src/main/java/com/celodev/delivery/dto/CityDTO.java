package com.celodev.delivery.dto;

import com.celodev.delivery.model.entities.location.City;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class CityDTO {
  public Long id;
  public Long idState;
  public String name;


  public CityDTO(City city){
    this.id = city.getId();
    this.name = city.getName();
  }
}
