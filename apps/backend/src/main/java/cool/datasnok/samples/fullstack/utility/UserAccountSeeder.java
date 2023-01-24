package cool.datasnok.samples.fullstack.utility;

import org.springframework.stereotype.Component;

import cool.datasnok.samples.fullstack.model.UserAccount;
import cool.datasnok.samples.fullstack.repository.UserAccountRepository;
import jakarta.annotation.PostConstruct;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
@RequiredArgsConstructor
public class UserAccountSeeder {
  private final UserAccountRepository userAccountRepository;

  private static final Long USER_ACCOUNT_ID = 1L;

  @PostConstruct
  void seedUsers() {
    if (this.userAccountRepository.existsById(USER_ACCOUNT_ID)) return;
    
    var encodedPassword = "admin"; // TODO: Encode password using BCrypt
    var savedUser = this.userAccountRepository.save(new UserAccount("admin", encodedPassword, "admin@invalid.tld"));

    log.info("Saved user account with ID: {}", savedUser.getId());
  }

}
