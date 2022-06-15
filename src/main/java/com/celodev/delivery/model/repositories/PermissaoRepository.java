package com.celodev.delivery.model.repositories;

import org.springframework.data.jpa.repository.JpaRepository;
import com.celodev.delivery.model.entities.Permissao;

public interface PermissaoRepository extends JpaRepository<Permissao, Long> {
  
}
