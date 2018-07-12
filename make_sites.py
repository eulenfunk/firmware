#!/usr/bin/python3

import jinja2
import yaml
import os

with open("sites.yml") as sites_file:
    sites = yaml.safe_load(sites_file)

    for root, dirs, files in os.walk("sites", topdown=False):
        for file in files:
            os.remove(os.path.join(root, file))
        for dir in dirs:
            os.rmdir(os.path.join(root, dir))


    for site in sites:
        out_dir = os.path.join("sites", site["site_code"])

        for root, dirs, files in os.walk("template"):
            rel_root = os.path.relpath(root, start="template")
    
            for dir in dirs:
                os.makedirs(os.path.join(out_dir, rel_root, dir), exist_ok=True)
    
            for file in files:
                with open(os.path.join(root, file)) as template_file:
                    template = jinja2.Template(template_file.read())
    
                    with open(os.path.join(out_dir, rel_root, file), "w") as output_file:
                        output_file.write(template.render(site))


with open("build.sh.j2") as template_file:
    template = jinja2.Template(template_file.read())

    with open("build.sh", "w") as output_file:
        output_file.write(template.render(sites=sites))

st = os.stat("build.sh")
os.chmod("build.sh", st.st_mode | 0o111)
