package com.celodev.delivery.model.services.servicesImpl;

import java.util.List;
import java.util.Optional;
import javax.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.celodev.delivery.dto.CityDTO;
import com.celodev.delivery.model.entities.location.City;
import com.celodev.delivery.model.entities.location.State;
import com.celodev.delivery.model.repositories.CityRepository;
import com.celodev.delivery.model.repositories.location.StateRepository;
import com.celodev.delivery.model.services.CityService;


@Service
public class CityServiceImpl implements CityService {

  @Autowired CityRepository cityRepository;
  @Autowired StateRepository stateRepository;

  @Override
  @Transactional
  public CityDTO save(CityDTO cityDTO) throws Exception {

    State state = stateRepository.findById(cityDTO.getIdState()).get();
    City city = new City();

    city.setName(cityDTO.getName());
    city.setState(state);

    if(state.getId() != 0){
      cityRepository.save(city);
      return cityDTO;
    }else{
      throw new Exception("erro, não foi possível criar isso aqui");
    }

  }

  @Override
  public List<CityDTO> findAll(CityDTO cityDTO) {
    return null;
  }
}
