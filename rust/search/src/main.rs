use std::env::home_dir;
use std::process::Command;
use std::path::Path;
use std::error::Error;
use sqlite::State;
use std::fs;
use std::env;

fn read_file(path: &Path) -> Result<Vec<String>, Box<dyn Error>> {
    let contents = fs::read_to_string(path)?;
    let mut desktop = contents
        .split("[Desktop");
        // .lines()
        // .filter(|x| (x.starts_with("Name") || x.starts_with("Exec") || x.starts_with("Icon")) && x.chars().collect::<Vec<_>>()[4] == '=' && !x.is_empty())
        // .collect::<Vec<_>>();
    desktop.next();

    let mut details = desktop
        .next()
        .unwrap_or("")
        .lines()
        .filter(|x| (x.starts_with("Name") || x.starts_with("Exec") || x.starts_with("Icon")) && x.chars().collect::<Vec<_>>()[4] == '=' && !x.is_empty())
        .collect::<Vec<_>>();

    details.sort();

    // println!("{:?}", );
    let mut result = details
        .iter()
        .map(|y| y[5..].to_string())
        .collect::<Vec<String>>();
    result.truncate(3);
    if result.len() == 3 {
        // println!("{:?}", result);
        Ok(result)
    } else {
        // println!("{:?}", details);
        Ok(vec!["a".to_string(), "a".to_string(), "a".to_string()])
    }
}

fn app_count(app: &str) -> i32 {
    let connection = sqlite::open(env::home_dir().unwrap_or("".into()).to_str().unwrap_or("").to_owned() + "/.config/eww/scripts/search.db").unwrap();
    let query = "SELECT * FROM apps WHERE appname = ?";
    let mut statement = connection.prepare(query).unwrap();
    statement.bind((1, app)).unwrap();
    while let Ok(State::Row) = statement.next() {
        println!("{:?}", statement.read::<String, _>("count").unwrap());
        return statement.read::<String, _>("count").unwrap().trim().parse::<i32>().unwrap_or(0) 
    }
    0
}

fn main() {
    // println!("{:?}", app_count("a"));
    let search:&str = &env::args().collect::<Vec<_>>()[1];

    let home_buf = home_dir().expect("asd");
    let home: &str = home_buf.to_str().expect("asd");

    let apps: String = "(box :class \"container\" :space-evenly false :orientation \"horizontal\" ".to_owned();

    let mut bins = fs::read_dir("/usr/share/applications/").expect("ono")
        .chain(fs::read_dir(home.to_owned()+"/.local/share/applications/").expect("adauyg"))
        // .chain(fs::read_dir(home.to_owned()+"/Desktop/").expect("adauyg"))
        .chain(fs::read_dir("/var/lib/flatpak/exports/share/applications/").expect("ouf"))
        .filter_map(|x| {
            Some(x.ok()?
            .path())
        })
        .map(|s| match read_file(&s) {
            Ok(c) => c,
            Err(e)=> vec!["aa".to_string(), "asd".to_string(), e.to_string()]
        })
        .filter(|y| 
            y[2].to_lowercase().starts_with(&search.to_lowercase()) ||
            y[0].split_whitespace().next().unwrap_or("").split("/").last().unwrap_or("").to_lowercase().starts_with(&search.to_lowercase())
            )
        .collect::<Vec<_>>();
    bins.sort_by(|a, b| app_count(&b[2]).cmp(&app_count(&a[2])));
    println!("{:?}", bins);
    bins.truncate(4);
    let firstapp:String = {
        if bins.is_empty() {
            bins = vec![
                vec![format!("chromium --new-window 'https://duckduckgo.com/?q={}'", &search.replace(' ', "+")), "search".to_owned(), "Search the Web".to_owned()],
                vec![format!("kitty -e fish -c '{}'", &search), "terminal".to_owned(), "Run as Command".to_owned()],
                vec![format!("kitty -e fish -c 'sudo pacman -S {}'", &search), "package".to_owned(), "Install Application".to_owned()],
            ];
            format!("chromium --new-window 'https://duckduckgo.com/?q={}'", &search.replace(' ', "+"))
        } else {
            format!("{} & python ~/.config/eww/scripts/db.py '{}'", bins[0][0].to_string(), bins[0][2].to_string())}
    };
    let apps = bins.into_iter().fold(apps, |acc,x| acc +
        &format!("\n\t(app-entry :app \"{}\" :icon \"{}\" :name \"{}\" :count \"{}\")",
        x[0],
        x[1],
        x[2].clone(),
        &app_count(&x[2]).to_string(),
        ))
        +")";
    println!("{}", apps);
    Command::new("eww").arg("update").arg("apps=".to_owned()+&apps).status().expect("bbbb");
    Command::new("eww").arg("update").arg("firstapp=".to_owned()+&firstapp+" & eww close search").status().expect("bbbb");
}
