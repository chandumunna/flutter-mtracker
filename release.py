import shutil
import subprocess

subprocess.run('flutter --version', shell=True, check=True)
subprocess.run('flutter clean', shell=True, check=True)
subprocess.run('flutter pub get', shell=True, check=True)
subprocess.run('flutter build web --release', shell=True, check=True)

git_dir=r"E:\PROJECT\WebApp\mtracker"

shutil.copytree(
    src=r"E:\PROJECT\Flutter\mtracker\build\web",
    dst=git_dir,
    dirs_exist_ok=True,
)

subprocess.run("git status", shell=True, cwd=git_dir, check=True)
subprocess.run("git add --all", shell=True, cwd=git_dir, check=True)
subprocess.run('git commit -m "new release from Sanjay R B"', shell=True, cwd=git_dir, check=True)
subprocess.run("git push", shell=True, cwd=git_dir, check=True)
