package cool.datasnok.samples.fullstack.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import cool.datasnok.samples.fullstack.model.UserAccount;

public interface UserAccountRepository extends JpaRepository<UserAccount, Long> {
  
}
