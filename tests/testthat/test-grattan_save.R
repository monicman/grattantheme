library(ggplot2)

test_plot <- ggplot(mtcars, aes(x = wt, y = mpg, col = factor(cyl))) +
  geom_point() +
  theme_grattan() +
  grattan_colour_manual(n = 3) +
  grattan_y_continuous(limits = c(0, 40)) +
  labs(x = "Weight",
       title = "Smaller cars get better mileage",
       subtitle = "Miles-per-gallon by weight",
       caption = "Source: mtcars dataset")

test_plot_nolabs <- ggplot(mtcars, aes(x = wt, y = mpg, col = factor(cyl))) +
  geom_point() +
  theme_grattan() +
  grattan_colour_manual(n = 3) +
  grattan_y_continuous(limits = c(0, 40))

test_that("grattan_save() saves charts", {

  grattan_save(filename = "../figs/test/test_plot.png",
               object = test_plot,
               type = "all")

  expect_true(file.exists("../figs/test/test_plot/test_plot_fullslide_44.png"))
  expect_true(file.exists("../figs/test/test_plot/test_plot_fullslide_169.png"))
  expect_true(file.exists("../figs/test/test_plot/test_plot_fullslide.png"))
  expect_true(file.exists("../figs/test/test_plot/test_plot_fullpage.png"))
  expect_true(file.exists("../figs/test/test_plot/test_plot_normal_169.png"))
  expect_true(file.exists("../figs/test/test_plot/test_plot_normal.png"))
  expect_true(file.exists("../figs/test/test_plot/test_plot_tiny.png"))
  expect_true(file.exists("../figs/test/test_plot/test_plot_wholecolumn.png"))
  expect_true(file.exists("../figs/test/test_plot/test_plot.csv"))

  unlink("../figs", recursive = TRUE)
  unlink("../testthat/Rplots.pdf")
})

test_that("grattan_save() shows or hides messages about labels as appropriate", {

  expect_message(grattan_save(filename = "test_plot.png",
                              object = test_plot,
                              type = "normal"))

  expect_message(grattan_save(filename = "test_plot.png",
                              object = test_plot,
                              type = "fullslide"),
                 NA)

  expect_message(grattan_save(filename = "test_plot.png",
                              object = test_plot_nolabs,
                              type = "fullslide"))

  expect_message(grattan_save(filename = "test_plot.png",
                              object = test_plot_nolabs,
                              type = "fullslide",
                              warn_labs = FALSE),
                 NA)


  unlink("test_plot.png")

})

