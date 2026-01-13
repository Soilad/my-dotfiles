use std::process::{Command};

fn main() {
    let uhh = Command::new("nmcli").args(["device","wifi","list"]).output().expect("sdsda");
    let a = String::from_utf8_lossy(&uhh.stdout);
    let head :String = "(box :orientation \"vertical\"".to_owned();
    let wifilist = a.lines().into_iter().map(|x| x.split_whitespace().collect::<Vec<_>>()[1]).collect::<Vec<_>>().into_iter().filter(|x| ! x.contains(":")).filter(|x| *x != "--").skip(1);
    // println!("{:?}", wifilist.collect::<Vec<_>>());
    Command::new("eww").arg("update").arg("wifilist=".to_owned()+&wifilist.fold(head, |acc,x| acc +&format!("(button :class \"wifilist\" :onclick \"nmcli device wifi connect {0} & eww close wifi \" \"{0}\") ", x) )+")").status().expect("bbbb");
}
