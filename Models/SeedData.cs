using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using MvcMovie.Data;
using System;
using System.Linq;

namespace MvcMovie.Models;

public static class SeedData
{
    public static void Initialize(IServiceProvider serviceProvider)
    {
        using (var context = new MvcMovieContext(
            serviceProvider.GetRequiredService<
                DbContextOptions<MvcMovieContext>>()))
        {
            // Look for any movies.
            if (context.Movie.Any())
            {
                return;   // DB has been seeded
            }
           context.Movie.AddRange(
                        new Movie
                        {
                        Title = "Digital Dreams",
                        ReleaseDate = DateTime.Parse("2019-05-17"),
                        Genre = "Sci-Fi",
                        Rating = "PG-13",
                        Price = 11.99M
                        },
                        new Movie
                        {
                        Title = "Midnight Chronicles",
                        ReleaseDate = DateTime.Parse("2021-08-22"),
                        Genre = "Mystery",
                        Rating = "R",
                        Price = 9.99M
                        },
                        new Movie
                        {
                        Title = "Crimson Horizon",
                        ReleaseDate = DateTime.Parse("2020-03-10"),
                        Genre = "Adventure",
                        Rating = "PG-13",
                        Price = 10.99M
                        },
                        new Movie
                        {
                        Title = "Silent Echoes",
                        ReleaseDate = DateTime.Parse("2018-11-05"),
                        Genre = "Thriller",
                        Rating = "R",
                        Price = 8.99M
                        },
                        new Movie
                        {
                        Title = "Northern Lights",
                        ReleaseDate = DateTime.Parse("2022-01-14"),
                        Genre = "Drama",
                        Rating = "PG",
                        Price = 12.99M
                        },
                        new Movie
                        {
                        Title = "Quantum Paradox",
                        ReleaseDate = DateTime.Parse("2023-06-30"),
                        Genre = "Sci-Fi",
                        Rating = "PG-13",
                        Price = 13.99M
                        },
                        new Movie
                        {
                        Title = "Whispering Pines",
                        ReleaseDate = DateTime.Parse("2017-09-18"),
                        Genre = "Horror",
                        Rating = "R",
                        Price = 7.99M
                        }
                        );
            context.SaveChanges();
        }
    }
}