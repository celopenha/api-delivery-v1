package com.celodev.delivery.resources;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.celodev.delivery.model.entities.location.State;
import com.celodev.delivery.model.repositories.CityRepository;
import com.celodev.delivery.model.repositories.location.StateRepository;

@RestController
@RequestMapping("api/states")
public class StateResource {


  @Autowired
  StateRepository stateRepository;

  @Autowired
  CityRepository cityRepository;
  


  @GetMapping
  public ResponseEntity<List<State>> getStates() {

    return ResponseEntity.ok(stateRepository.findAll());
  }

  @PostMapping
  public ResponseEntity<State> createState(@RequestBody State state) {

    return ResponseEntity.ok(stateRepository.save(state));
  }
}
