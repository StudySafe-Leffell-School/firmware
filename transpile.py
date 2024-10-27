import os

env = DefaultEnvironment()

targetEnv = env.Dump().partition("'PIOENV': '")[2].partition("',")[0]

buildDir = env.subst("$PROJECT_SRC_DIR")
projectDir = os.path.split(buildDir)[0]
srcDir = os.path.join(projectDir, "src")

env.Execute(f"nim cpp -d:{targetEnv} --hints:off -w:off src/firmware")
