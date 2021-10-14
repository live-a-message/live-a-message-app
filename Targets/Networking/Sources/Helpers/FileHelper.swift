//
//  FileHelper.swift
//  Akee
//
//  Created by Fernando de Lucas da Silva Gomes on 13/10/21.
//  Copyright © 2021 Akee. All rights reserved.
//

import Foundation

class FileHelper {
  
  private var mainPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
  
  func saveFile(_ file: Data, as name: String, in directory: Directory) throws -> URL {
    guard let folder = try? getDirectory(for: directory) else {
      throw LocalFileError.CouldNotGetFolder
    }
    
    let fileURL: URL = folder.appendingPathComponent(name)
    
    do {
      try file.write(to: fileURL)
      return fileURL
    } catch {
      throw LocalFileError.CouldNotSaveFile
    }
  }

  private func getDirectory(for directory: Directory) throws -> URL {
    switch directory{
    case .ephemeral:
      return try FileManager.default.url(for: .itemReplacementDirectory, in: .userDomainMask, appropriateFor: mainPath, create: false)
    case .permanent:
      return mainPath
    }
  }
  
  enum Directory{
    case ephemeral, permanent
  }

  enum LocalFileError: Error{
    case CouldNotGetFolder, CouldNotSaveFile
  }
}
