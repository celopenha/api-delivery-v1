package com.celodev.delivery.model.services;

import java.util.List;
import com.celodev.delivery.model.entities.location.State;

public interface StateService {
  State create(State state);
  List<State> findAll();
}
