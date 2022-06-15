package com.celodev.delivery.model.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import com.celodev.delivery.model.entities.restaurant.Restaurant;

public interface RestaurantRepository extends JpaRepository<Restaurant, Long> {
  
}
