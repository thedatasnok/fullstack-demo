package cool.datasnok.samples.fullstack.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;

import cool.datasnok.samples.fullstack.model.UserAccount;

public interface UserAccountRepository extends JpaRepository<UserAccount, Long> {
  
  Optional<UserAccount> findByUsername(String username);

}
