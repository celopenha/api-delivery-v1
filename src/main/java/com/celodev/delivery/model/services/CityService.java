package com.celodev.delivery.model.services;

import java.util.List;
import com.celodev.delivery.dto.CityDTO;

public interface CityService {
  CityDTO save(CityDTO cityDTO) throws Exception;

  List<CityDTO> findAll(CityDTO cityDTO);
}
