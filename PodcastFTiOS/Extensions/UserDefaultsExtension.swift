
import Foundation

extension UserDefaults {
    // take data to userdefaults
    static let downloadedEpisodesKey: String = "kDownloadedEpisodesKey"
    
    // call the data
    func downloadedEpisodes() -> [DownloadedEpisode] {
        guard let data = self.data(forKey: UserDefaults.downloadedEpisodesKey) else {
            return []
        }
        
        // turn data into object
        do {
            let episodes = try JSONDecoder().decode([DownloadedEpisode].self, from: data)
            return episodes
        }
        catch {
            return []
        }
    }
 
    // implement
    func downloadEpisode(_ episode: Episode) {
        let downloadedEpisode = DownloadedEpisode(episode: episode)
        
        // save download
        var episodes = self.downloadedEpisodes()
        episodes.insert(downloadedEpisode, at: 0)
        
        // change object to data
        do {
            let data = try JSONEncoder().encode(episodes)
            UserDefaults.standard.set(data, forKey: UserDefaults.downloadedEpisodesKey)
           
            // change UI
            NotificationCenter.default.post(name: .downloadAdded, object: nil)
            
            // if there's error do print
        } catch {
            print("Failed to encode: \(error)")
        }
    }
    
}
