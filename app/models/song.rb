class Song < ActiveRecord::Base
  validates :title, length: {minimum: 1}
  # validates :released, inclusion: {in: %w(true false)}
  validate :must_have_valid_release_year
  validates :artist_name, length: {minimum: 1}
  validate :cannot_repeat_song_by_same_artist


  def must_have_valid_release_year
    if released && release_year.nil?
      errors.add(:release_year, "must have release year")
    elsif released && release_year > Date.today.year
      errors.add(:release_year, "release year must be less than or equal to current year")
    end
  end

  def cannot_repeat_song_by_same_artist
    if Song.all.any? {|song| song.title == title && song.release_year == release_year}
      errors.add(:title, "cannot repeat a song by the same artist in the same year")
    end
  end
end
