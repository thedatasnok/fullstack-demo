package cool.datasnok.samples.fullstack.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import cool.datasnok.samples.fullstack.dto.SignInRequest;
import cool.datasnok.samples.fullstack.dto.SignInResponse;
import cool.datasnok.samples.fullstack.dto.UserProfile;

@RestController
@RequestMapping("/v1/auth")
public class AuthController {
  
  @PostMapping("/sign-in")
  public ResponseEntity<SignInResponse> signIn(@RequestBody SignInRequest request) {
    return ResponseEntity.status(HttpStatus.NOT_IMPLEMENTED).build();
  }

  @GetMapping("/profile")
  public ResponseEntity<UserProfile> getProfile() {
    return ResponseEntity.status(HttpStatus.NOT_IMPLEMENTED).build();
  }

}
