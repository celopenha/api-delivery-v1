package com.celodev.delivery.model.repositories.location;

import org.springframework.data.jpa.repository.JpaRepository;
import com.celodev.delivery.model.entities.location.State;

public interface StateRepository extends JpaRepository<State, Long> {
  
}
