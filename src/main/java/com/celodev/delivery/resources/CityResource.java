package com.celodev.delivery.resources;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import com.celodev.delivery.dto.CityDTO;
import com.celodev.delivery.model.entities.location.City;
import com.celodev.delivery.model.services.CityService;



@RestController
@RequestMapping("api/cities")
public class CityResource {


  @Autowired CityService service;

  @PostMapping
  public ResponseEntity<CityDTO> create(@RequestBody CityDTO cityDTO) throws Exception{
    return ResponseEntity.ok(service.save(cityDTO));
  }

  @GetMapping
  public ResponseEntity<List<CityDTO>> getAll(@RequestBody CityDTO cityDTO){
    return ResponseEntity.ok(service.findAll(cityDTO));
  }
}
