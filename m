Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991088BF8
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 00:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737591790; cv=none; b=cfZG9HsxvHXzNVarPoIeIze0B7Guvl4GD7aZy4pyc7WPC5Xbf+0PJpiF2lKg5jawa/5T2yRyLTvnzvMHn513eg4bVZsPUtYKF0bfEW1xISPs+ueCOR4xHAhJjH5+RXUU9Smmh+enmn7F3ebmimOsFY8064uYwXpsvf7d3HsRe8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737591790; c=relaxed/simple;
	bh=s9d2oIsdBwt/4de9RXl1DGAElPgmxW9LcjfUuRwvV8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nkwD7ciyAb6AUU2nZDWU4YZIcEKJCmYAdolyBFW7FkZyC4tJbimDqe9vDkx0ry6lUgEVvT5ntFAMah0SXFuXha0P3jUfcTEoIKMSzZidRTG3Go4Cq6e8UuAUQDkTLTvl79urS9rUle5KKY3fWiksQU8HEjXgSJ8m9ttYryqhIAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2B8DC4CED2;
	Thu, 23 Jan 2025 00:23:09 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: alison.schofield@intel.com
Subject: [NDCTL PATCH 2/5] cxl: Enumerate features 'devices'
Date: Wed, 22 Jan 2025 17:22:01 -0700
Message-ID: <20250123002304.2758417-3-dave.jiang@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250123002304.2758417-1-dave.jiang@intel.com>
References: <20250123002304.2758417-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support to libcxl to enumerate the 'features' device exported by the
kernel. 'features' is a new 'struct device' exported by the kernel CLX
subsystem in order to support CXL mailbox feature commands. libcxl will
walk the sysfs and pick up the featuresN devices. The char device via
the FWCTL subsystem registered by the features driver is used to send
feature commands via ioctl to the kernel driver. The discovery and
initialization will identify the char device.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 cxl/lib/libcxl.c   | 180 +++++++++++++++++++++++++++++++++++++++++++++
 cxl/lib/libcxl.sym |   2 +
 cxl/lib/private.h  |  13 ++++
 cxl/libcxl.h       |   9 +++
 4 files changed, 204 insertions(+)

diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index bab7343e8a4a..8bc0394543dc 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -46,11 +46,13 @@ struct cxl_ctx {
 	void *userdata;
 	int memdevs_init;
 	int buses_init;
+	int features_init;
 	unsigned long timeout;
 	struct udev *udev;
 	struct udev_queue *udev_queue;
 	struct list_head memdevs;
 	struct list_head buses;
+	struct list_head features;
 	struct kmod_ctx *kmod_ctx;
 	struct daxctl_ctx *daxctl_ctx;
 	void *private_data;
@@ -91,6 +93,23 @@ static void free_memdev(struct cxl_memdev *memdev, struct list_head *head)
 	free(memdev);
 }
 
+static void __free_features(struct cxl_features *feat)
+{
+	free(feat->dev_buf);
+	free(feat->dev_path);
+	free(feat->host_path);
+	free(feat->hostname);
+	free(feat);
+}
+
+static void free_features(struct cxl_features *feat, struct list_head *head)
+{
+	if (head)
+		list_del_from(head, &feat->list);
+	kmod_module_unref(feat->module);
+	__free_features(feat);
+}
+
 static void free_target(struct cxl_target *target, struct list_head *head)
 {
 	if (head)
@@ -289,6 +308,7 @@ CXL_EXPORT int cxl_new(struct cxl_ctx **ctx)
 	*ctx = c;
 	list_head_init(&c->memdevs);
 	list_head_init(&c->buses);
+	list_head_init(&c->features);
 	c->kmod_ctx = kmod_ctx;
 	c->daxctl_ctx = daxctl_ctx;
 	c->udev = udev;
@@ -329,6 +349,7 @@ CXL_EXPORT struct cxl_ctx *cxl_ref(struct cxl_ctx *ctx)
  */
 CXL_EXPORT void cxl_unref(struct cxl_ctx *ctx)
 {
+	struct cxl_features *feat, *_f;
 	struct cxl_memdev *memdev, *_d;
 	struct cxl_bus *bus, *_b;
 
@@ -344,6 +365,9 @@ CXL_EXPORT void cxl_unref(struct cxl_ctx *ctx)
 	list_for_each_safe(&ctx->buses, bus, _b, port.list)
 		free_bus(bus, &ctx->buses);
 
+	list_for_each_safe(&ctx->features, feat, _f, list)
+		free_features(feat, &ctx->features);
+
 	udev_queue_unref(ctx->udev_queue);
 	udev_unref(ctx->udev);
 	kmod_unref(ctx->kmod_ctx);
@@ -4694,3 +4718,159 @@ CXL_EXPORT struct cxl_cmd *cxl_cmd_new_set_alert_config(struct cxl_memdev *memde
 {
 	return cxl_cmd_new_generic(memdev, CXL_MEM_COMMAND_ID_SET_ALERT_CONFIG);
 }
+
+static const char fwctl_prefix[] = "fwctl";
+static int get_feature_chardev(const char *base, char *chardev_path)
+{
+	char *path = calloc(1, strlen(base) + 100);
+	struct dirent *entry;
+	DIR *dir;
+	int rc;
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
+	closedir(dir);
+
+	return 0;
+
+read_err:
+	closedir(dir);
+err:
+	free(path);
+	return rc;
+}
+
+static void *add_cxl_features(void *parent, int id, const char *cxlfeat_base)
+{
+	const char *devname = devpath_to_devname(cxlfeat_base);
+	char *path = calloc(1, strlen(cxlfeat_base) + 100);
+	struct cxl_features *feat, *feat_dupe;
+	char *host, *host_path, *hostname;
+	struct cxl_ctx *ctx = parent;
+	char buf[SYSFS_ATTR_SIZE];
+	struct stat st;
+	int rc;
+
+	if (!path)
+		return NULL;
+
+	dbg(ctx, "%s: base: \'%s\'\n", devname, cxlfeat_base);
+
+	feat = calloc(1, sizeof(*feat));
+	if (!feat)
+		goto err_dev;
+
+	feat->id = id;
+	feat->ctx = ctx;
+	sprintf(path, "/dev/cxl/%s", devname);
+
+	rc = get_feature_chardev(cxlfeat_base, path);
+	if (rc) {
+		/* No fwctl entry, no need to enumerate the "device" */
+		__free_features(feat);
+		free(path);
+		return NULL;
+	}
+
+	if (stat(path, &st) < 0)
+		goto err_read;
+
+	feat->major = major(st.st_rdev);
+	feat->minor = minor(st.st_rdev);
+
+	feat->dev_path = strdup(cxlfeat_base);
+	if (!feat->dev_path)
+		goto err_read;
+
+	feat->host_path = realpath(cxlfeat_base, NULL);
+	if (!feat->host_path)
+		goto err_read;
+	host = strrchr(feat->host_path, '/');
+	if (!host)
+		goto err_read;
+	host[0] = '\0';
+
+	feat->dev_buf = calloc(1, strlen(cxlfeat_base) + 50);
+	if (!feat->dev_buf)
+		goto err_read;
+	feat->buf_len = strlen(cxlfeat_base) + 50;
+
+	sprintf(path, "%s/features", cxlfeat_base);
+	if (sysfs_read_attr(ctx, path, buf) < 0)
+		goto err_read;
+	feat->features = atoi(buf);
+
+	/*
+	 * Extract host device name for the features "device". This is used for
+	 * matching up with an endpoint uport.
+	 */
+	host_path = strdup(feat->host_path);
+	if (!host_path)
+		goto err_read;
+
+	hostname = strdup(devpath_to_devname(host_path));
+	if (!hostname)
+		goto err_read;
+
+	free(host_path);
+	feat->hostname = hostname;
+
+	cxl_features_foreach(ctx, feat_dupe)
+		if (feat_dupe->id == feat->id) {
+			__free_features(feat);
+			free(path);
+			return feat_dupe;
+		}
+
+	list_add(&ctx->features, &feat->list);
+	free(path);
+	return feat;
+
+ err_read:
+	__free_features(feat);
+ err_dev:
+	free(path);
+	return NULL;
+}
+
+static void cxl_features_init(struct cxl_ctx *ctx)
+{
+	if (ctx->features_init)
+		return;
+
+	ctx->features_init = 1;
+
+	device_parse(ctx, "/sys/bus/cxl/devices", "features", ctx, add_cxl_features);
+}
+
+CXL_EXPORT struct cxl_features *cxl_features_get_first(struct cxl_ctx *ctx)
+{
+	cxl_features_init(ctx);
+
+	return list_top(&ctx->features, struct cxl_features, list);
+}
+
+CXL_EXPORT struct cxl_features *cxl_features_get_next(struct cxl_features *features)
+{
+	struct cxl_ctx *ctx = features->ctx;
+
+	return list_next(&ctx->features, features, list);
+}
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index 1fc33cc6e1a4..9b1708d8e86a 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -292,4 +292,6 @@ global:
 LIBCXL_9 {
 global:
 	cxl_bus_get_by_provider;
+	cxl_features_get_first;
+	cxl_features_get_next;
 } LIBECXL_8;
diff --git a/cxl/lib/private.h b/cxl/lib/private.h
index b6cd910e9335..34785af4e64f 100644
--- a/cxl/lib/private.h
+++ b/cxl/lib/private.h
@@ -34,6 +34,19 @@ enum cxl_fwl_loading {
 	CXL_FWL_LOADING_START,
 };
 
+struct cxl_features {
+	int id, major, minor;
+	struct cxl_ctx *ctx;
+	void *dev_buf;
+	size_t buf_len;
+	char *host_path;
+	char *dev_path;
+	char *hostname;
+	struct kmod_module *module;
+	struct list_node list;
+	int features;
+};
+
 struct cxl_endpoint;
 struct cxl_memdev {
 	int id, major, minor;
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index 3b309968a808..7e94eb8bce24 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -489,6 +489,15 @@ int cxl_cmd_alert_config_set_enable_alert_actions(struct cxl_cmd *cmd,
 						  int enable);
 struct cxl_cmd *cxl_cmd_new_set_alert_config(struct cxl_memdev *memdev);
 
+struct cxl_features;
+#define cxl_features_foreach(ctx, features) \
+        for (features = cxl_features_get_first(ctx); \
+             features != NULL; \
+             features = cxl_features_get_next(features))
+
+struct cxl_features *cxl_features_get_first(struct cxl_ctx *ctx);
+struct cxl_features *cxl_features_get_next(struct cxl_features *features);
+
 #ifdef __cplusplus
 } /* extern "C" */
 #endif
-- 
2.47.1

