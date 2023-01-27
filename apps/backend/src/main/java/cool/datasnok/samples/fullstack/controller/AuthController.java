package cool.datasnok.samples.fullstack.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import cool.datasnok.samples.fullstack.dto.SignInRequest;
import cool.datasnok.samples.fullstack.dto.SignInResponse;
import cool.datasnok.samples.fullstack.dto.UserProfile;
import cool.datasnok.samples.fullstack.repository.UserAccountRepository;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@RequestMapping("/v1/auth")
public class AuthController {
  private final UserAccountRepository userAccountRepository;
  private final PasswordEncoder passwordEncoder;

  @PostMapping("/sign-in")
  public ResponseEntity<SignInResponse> signIn(@RequestBody SignInRequest request) {
    var foundUser = this.userAccountRepository.findByUsername(request.username());

    if (foundUser.isEmpty()) return ResponseEntity.status(HttpStatus.NOT_FOUND).build();

    var passwordMatches = this.passwordEncoder.matches(request.password(), foundUser.get().getPassword());

    if (!passwordMatches) return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();
    
    return ResponseEntity.ok(new SignInResponse("this-is-not-a-valid-token"));
  }

  @GetMapping("/profile")
  public ResponseEntity<UserProfile> getProfile() {
    return ResponseEntity.status(HttpStatus.NOT_IMPLEMENTED).build();
  }

}
