package com.celodev.delivery.model.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import com.celodev.delivery.model.entities.delivery.Order;

public interface OrderRepository extends JpaRepository<Order, Long> {
  
  
}
