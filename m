Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E730F176AB5
	for <linux-cxl@vger.kernel.org>; Fri,  7 Feb 2025 23:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738972043; cv=none; b=q63/yMVOMq9tNGoqtfnvfFw/DH/Pj16as0iUdUJXYScALkPo96e62hINhu4k51BCbio3Dl6zHLDmAw+NWWA8voAqk5QGdsl+VysgqgQbCHDIHWjDygqUF5VN5/09TyQXktVAkjQiyR2pgLHcmC/hnPvIHF7eHmZHHGem7X2tNsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738972043; c=relaxed/simple;
	bh=tFViK+KgAmQI3b662C7w78A0G4xr1wEsh2C/04CsDNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WTUZC58dF7Gs3G8kQOx8EckceunYSuayiZ09npSjJbtXAua2bEZbMzY4NDnBYLszxp7O1RKNk2EUGE7kxRVq9+W+H+QHqg7Dx7t/X+GR1Nu5Zpd/AYU0Uj2MaFmVVBJM8q6Ghq17jnMVDjNgxfWsgheHrqbkYZEemhazvvf92ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EFE8C4CED1;
	Fri,  7 Feb 2025 23:47:23 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: alison.schofield@intel.com
Subject: [NDCTL PATCH v3 2/3] cxl: Enumerate major/minor of FWCTL char device
Date: Fri,  7 Feb 2025 16:46:34 -0700
Message-ID: <20250207234718.2387622-3-dave.jiang@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207234718.2387622-1-dave.jiang@intel.com>
References: <20250207234718.2387622-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add major/minor discovery for the FWCTL character device that is associated
with supprting CXL Features under the cxl_memdev. Add libcxl API functions
to retrieve the major and minor of the FWCTL character device.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 cxl/lib/libcxl.c   | 74 ++++++++++++++++++++++++++++++++++++++++++++++
 cxl/lib/libcxl.sym |  2 ++
 cxl/lib/private.h  |  1 +
 cxl/libcxl.h       |  2 ++
 4 files changed, 79 insertions(+)

diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index bab7343e8a4a..566870acb30a 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -1253,6 +1253,66 @@ static int add_cxl_memdev_fwl(struct cxl_memdev *memdev,
 	return -ENOMEM;
 }
 
+static const char fwctl_prefix[] = "fwctl";
+static int get_feature_chardev(const char *base, char *chardev_path)
+{
+	char *path = calloc(1, strlen(base) + 100);
+	struct dirent *entry;
+	int rc = 0;
+	DIR *dir;
+
+	if (!path)
+		return -ENOMEM;
+
+	sprintf(path, "%s/fwctl/", base);
+	dir = opendir(path);
+	if (!dir) {
+		rc = -errno;
+		goto err;
+	}
+
+	while ((entry = readdir(dir)) != NULL)
+		if (strncmp(entry->d_name, fwctl_prefix, strlen(fwctl_prefix)) == 0)
+			break;
+
+	if (!entry) {
+		rc = -ENOENT;
+		goto read_err;
+	}
+
+	sprintf(chardev_path, "/dev/fwctl/%s", entry->d_name);
+
+read_err:
+	closedir(dir);
+err:
+	free(path);
+	return rc;
+}
+
+static int memdev_get_fwctl_chardev(struct cxl_memdev *memdev,
+				    const char *cxlmem_base)
+{
+	char *path = calloc(1, strlen(cxlmem_base) + 100);
+	struct stat st;
+	int rc;
+
+	rc = get_feature_chardev(cxlmem_base, path);
+	if (rc)
+		goto out;
+
+	if (stat(path, &st) < 0) {
+		rc = -errno;
+		goto out;
+	}
+
+	memdev->fwctl_major = major(st.st_rdev);
+	memdev->fwctl_minor = minor(st.st_rdev);
+
+out:
+	free(path);
+	return rc;
+}
+
 static void *add_cxl_memdev(void *parent, int id, const char *cxlmem_base)
 {
 	const char *devname = devpath_to_devname(cxlmem_base);
@@ -1279,6 +1339,10 @@ static void *add_cxl_memdev(void *parent, int id, const char *cxlmem_base)
 	memdev->major = major(st.st_rdev);
 	memdev->minor = minor(st.st_rdev);
 
+	/* If this fails, no Features support. */
+	if (memdev_get_fwctl_chardev(memdev, cxlmem_base))
+		dbg(ctx, "%s: no Features support.\n", devname);
+
 	sprintf(path, "%s/pmem/size", cxlmem_base);
 	if (sysfs_read_attr(ctx, path, buf) == 0)
 		memdev->pmem_size = strtoull(buf, NULL, 0);
@@ -1515,6 +1579,16 @@ CXL_EXPORT int cxl_memdev_get_minor(struct cxl_memdev *memdev)
 	return memdev->minor;
 }
 
+CXL_EXPORT int cxl_memdev_get_fwctl_major(struct cxl_memdev *memdev)
+{
+	return memdev->fwctl_major;
+}
+
+CXL_EXPORT int cxl_memdev_get_fwctl_minor(struct cxl_memdev *memdev)
+{
+	return memdev->fwctl_minor;
+}
+
 CXL_EXPORT unsigned long long cxl_memdev_get_pmem_size(struct cxl_memdev *memdev)
 {
 	return memdev->pmem_size;
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index 1fc33cc6e1a4..b2b51a72673c 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -292,4 +292,6 @@ global:
 LIBCXL_9 {
 global:
 	cxl_bus_get_by_provider;
+	cxl_memdev_get_fwctl_major;
+	cxl_memdev_get_fwctl_minor;
 } LIBECXL_8;
diff --git a/cxl/lib/private.h b/cxl/lib/private.h
index b6cd910e9335..676bf1573487 100644
--- a/cxl/lib/private.h
+++ b/cxl/lib/private.h
@@ -37,6 +37,7 @@ enum cxl_fwl_loading {
 struct cxl_endpoint;
 struct cxl_memdev {
 	int id, major, minor;
+	int fwctl_major, fwctl_minor;
 	int numa_node;
 	void *dev_buf;
 	size_t buf_len;
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index 3b309968a808..26aa906740af 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -69,6 +69,8 @@ const char *cxl_memdev_get_host(struct cxl_memdev *memdev);
 struct cxl_bus *cxl_memdev_get_bus(struct cxl_memdev *memdev);
 int cxl_memdev_get_major(struct cxl_memdev *memdev);
 int cxl_memdev_get_minor(struct cxl_memdev *memdev);
+int cxl_memdev_get_fwctl_major(struct cxl_memdev *memdev);
+int cxl_memdev_get_fwctl_minor(struct cxl_memdev *memdev);
 struct cxl_ctx *cxl_memdev_get_ctx(struct cxl_memdev *memdev);
 unsigned long long cxl_memdev_get_pmem_size(struct cxl_memdev *memdev);
 unsigned long long cxl_memdev_get_ram_size(struct cxl_memdev *memdev);
-- 
2.48.1

