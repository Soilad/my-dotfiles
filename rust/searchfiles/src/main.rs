use std::cmp::min;
use std::process::{Command};
use std::ffi::OsStr;
use std::env;
use walkdir::WalkDir;


fn file_icon(file: Option<&OsStr>) -> &str {
    // println!("{:?}",file.rsplit_once("."));
    match file{
        Some(extension) => {
            match extension.to_str().unwrap_or("no extension") {
                "py" => "",
                "rs" => "",
                "lua" => "",
                "js" => "",
                "sh" => "",
                "md" => "",
                "json" => "",
                "toml" => "",
                "css"|"scss" => "",
                "html"|"xml" => "",
                "AppImage" => "",
                "blend"|"blend1" => "",
                "ttf"|"otf" => "",
                "txt"|"odt" => "",
                "doc"|"docx" => "",
                "ppt"|"pptx" => "",
                "zip"|"tar"|"gz"|"7z"|"rar" => "",
                "png"|"jpg"|"jpeg"|"webp"|"tga"|"dds" => "",
                "mp4"|"mov"|"mkv" => "",
                "ogg"|"mp3"|"wav"|"m4a" => "",
                "c"=>"",
                "svg"=>"󰜡",
                "cpp"=>"",
                _ => "",
            }
        },
        None => "",
    }
}

fn main() {
    let args:&str = &env::args().collect::<Vec<_>>()[1..].iter().fold(String::new(), |a, x| a.to_owned() + x + " " );
    let search = args.trim();

    // println!("{:?}", search);

    let mut c = 0;

    let mut files :String = " (scroll :height 600 :hscroll false :vscroll true \n\t(box :class \"container\" :orientation \"vertical\" ".to_owned();

    let walkfiles = WalkDir::new("/home/")
        .into_iter()
        .filter_map(|e| e.ok())
        // .filter(|x| !x.path().to_str().expect("asd").contains("/."))
        .filter(|y| y.file_name().to_ascii_lowercase().to_str().expect("asd").starts_with(&search.to_lowercase()))
        // .map(|x| x.into_os_string().into_string().unwrap())
        .collect::<Vec<_>>();
        // println!("{:?}", walkfiles);

    if !walkfiles.is_empty() {
        while c < min(50, walkfiles.len()) {
            files.push_str(&format!("\n\t(file-entry :file \"{}\" :icon \"{}\" :name \"{}\")",
                    walkfiles[c].path().to_str().unwrap_or("FILE LOCATION NOT FOUND"),
                    file_icon(walkfiles[c].path().extension()),
                    walkfiles[c].file_name().to_str().unwrap_or("FILENAME NOT FOUND")
                    ));
            c += 1;
        }
    }
    files.push_str("))");
    println!("{}\n)",files);
    Command::new("eww").arg("update").arg("files=".to_owned()+&String::from(files)).status().expect("bbbb");
    let _ = Command::new("diplayfiles").arg(walkfiles[0].path()).status();
}
