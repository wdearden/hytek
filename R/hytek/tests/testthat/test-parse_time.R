context("test-parse_time.R")

test_that("parse_time_hytek works correctly", {
    times <- c("4:23.10#", "23.10", "3.1")
    
    expected_times <- hms::hms(c(263.1, 23.1, 3.1))
    
    expect_equal(parse_time_hytek(times), expected_times)
})

test_that("parse_time_hytek returns NA for invalid strings", {
    times <- c("4:23.10&")

    expect_equal(parse_time_hytek(times), hms::hms(NA))
})
