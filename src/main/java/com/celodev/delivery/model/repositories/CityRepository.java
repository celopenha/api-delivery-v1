package com.celodev.delivery.model.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import com.celodev.delivery.model.entities.location.City;

public interface CityRepository extends JpaRepository<City, Long> {
  
}
