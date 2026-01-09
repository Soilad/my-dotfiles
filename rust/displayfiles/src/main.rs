use std::path::Path;
use std::fs;
use std::env;
use std::process::Command;

fn file_display(file: &Path) -> String {

    let content = {
      if file.is_file() {
        match fs::read_to_string(file) {
          Ok(text) => text.replace("\"", "'"),
          Err(_) => "CANT READ".to_string(),
      }
    } else {
      file.read_dir().expect("asdf").fold("".to_string(), |acc, x| format!("{}\n{}", acc, x.expect("asdf").path().to_str().expect("asd")))
    }
  };
    // let content = match fs::read_to_string(file){
    //                 Ok(text) => text.replace("\"", "'"),
    //                 Err(_) => "CANT READ".to_string(),
    //             };
    println!("{}",content);
    // println!("{}", file.to_str().expect("asds"));
    match file.extension().and_then(|a| a.to_str()) {
      Some(file_extension) =>
            match file_extension {
              "svg"|"png"|"jpg"|"jpeg"|"webp"|"tga"|"dds" => format!("(display-files :directory \"{0}\" (image :image-width 600 :path \"{0}\"))", file.to_str().unwrap_or("FILE NOT FOUND")),
              _ => format!("(display-files :directory \"{}\" (scroll :height 500 :vscroll true :class \"notes\" (label :text \"{}\")))", file.to_str().expect("asds"), content),
            },
          None => format!("(display-files :directory \"{}\" (scroll :height 500 :vscroll true :class \"notes\"(label :text \"{}\")))", file.to_str().expect("asds"), content)
    }
}

fn main() {
    let args:&str = &env::args().collect::<Vec<_>>()[1];
    let widgets = file_display(Path::new(args));
    println!("{}", widgets);
    Command::new("eww").arg("update").arg("display=".to_owned()+&widgets).status().expect("bbbb");
}
