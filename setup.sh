# Course-Cache: A system to cache UCSC Engineering course pages
# Copyright (C) 2019 Michael Hardy
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Affero General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Affero General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

apt-get update
apt-get install -yq git maven supervisor openjdk-8-jdk
useradd -m -d /home/crawler crawler
cd /home/crawler
su -c "git clone https://github.com/michardy/course-cache-crawler.git" crawler
su -c "cd  course-cache-crawler; git pull" crawler
su -c "cd  course-cache-crawler; mvn package" crawler
ACTION=$(curl -s "http://metadata.google.internal/computeMetadata/v1/instance/attributes/crawl_action" -H "Metadata-Flavor: Google")

su -c "java -jar /home/crawler/course-cache-crawler/target/course-cache-crawler-1.0-SNAPSHOT-jar-with-dependencies.jar $ACTION" crawler
