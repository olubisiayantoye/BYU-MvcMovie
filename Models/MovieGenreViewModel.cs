using Microsoft.AspNetCore.Mvc.Rendering;
using System.Collections.Generic;

namespace MvcMovie.Models;

public class MovieGenreViewModel
{
    public List<Movie> Movies { get; set; } = new List<Movie>();

    public SelectList Genres { get; set; } = default!;

    public string? MovieGenre { get; set; }
    public string? SearchString { get; set; }
    public int? SearchYear { get; set; }
}