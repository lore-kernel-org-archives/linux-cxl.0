Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB0B5C5F9
	for <linux-cxl@vger.kernel.org>; Mon,  5 Feb 2024 19:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707161550; cv=none; b=KIoWQ/1a7SLuDJT88aAXigN0vNbPLW1YRvYFoeA1iB23eBQivASnp+NLkIfLOvn8Ut5t3VDDnqTkx2YRx5+reCjXH9uiDEiG3WjskxBITajX5vgB6dmDZ8a5BSgeq9WveI+WKJ0F6Ol+20UUrojiAVGLCzKfjH8VJSVDJAypHOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707161550; c=relaxed/simple;
	bh=RcgrGvNlCLbUb8kMVwKtHiwwP165MrexeGof8+NcfaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Oo0PqP/Xp6rtZoTSyouYt3+G83EeAzCm3OOEilFk1K9YDAC/saleseRpGJu34h31fa168+TeGcB2p7B1pglM5Katrr7AJsR/YwZmhihDRUHebljvniGfmFOmymMNPfi9T2qKxOMU3MbmTy3qTtivdseUbG1Jj7WxOdmqEk8Vg7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B72C433C7;
	Mon,  5 Feb 2024 19:32:29 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: [PATCH v4 3/4] cxl: Fix sysfs export of qos_class for memdev
Date: Mon,  5 Feb 2024 12:30:33 -0700
Message-ID: <20240205193218.1657243-4-dave.jiang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205193218.1657243-1-dave.jiang@intel.com>
References: <20240205193218.1657243-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current implementation exports only to
/sys/bus/cxl/devices/.../memN/qos_class. With both ram and pmem exposed,
the second registered sysfs attribute is rejected as duplicate. It's not
possible to create qos_class under the dev_groups via the driver due to
the ram and pmem sysfs sub-directories already created by the device sysfs
groups. Move the ram and pmem qos_class to the device sysfs groups and add
a call to sysfs_update() after the perf data are validated so the
qos_class can be visible. The end results should be
/sys/bus/cxl/devices/.../memN/ram/qos_class and
/sys/bus/cxl/devices/.../memN/pmem/qos_class.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v4:
- Replace open code with sysfs_update_groups() helper. (Jonathan)
---
 drivers/cxl/core/cdat.c   |  1 +
 drivers/cxl/core/memdev.c | 66 +++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |  2 ++
 drivers/cxl/mem.c         | 36 ---------------------
 4 files changed, 69 insertions(+), 36 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index ecbd209ca70a..f5bebc7e7ccf 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -382,6 +382,7 @@ void cxl_endpoint_parse_cdat(struct cxl_port *port)
 
 	cxl_memdev_set_qos_class(cxlds, dsmas_xa);
 	cxl_qos_class_verify(cxlmd);
+	cxl_memdev_update_attribute_groups(cxlmd);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_endpoint_parse_cdat, CXL);
 
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index dae8802ecdb0..c81f2cd4bcc6 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -447,13 +447,41 @@ static struct attribute *cxl_memdev_attributes[] = {
 	NULL,
 };
 
+static ssize_t pmem_qos_class_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+
+	return sysfs_emit(buf, "%d\n", mds->pmem_perf.qos_class);
+}
+
+static struct device_attribute dev_attr_pmem_qos_class =
+	__ATTR(qos_class, 0444, pmem_qos_class_show, NULL);
+
 static struct attribute *cxl_memdev_pmem_attributes[] = {
 	&dev_attr_pmem_size.attr,
+	&dev_attr_pmem_qos_class.attr,
 	NULL,
 };
 
+static ssize_t ram_qos_class_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+
+	return sysfs_emit(buf, "%d\n", mds->ram_perf.qos_class);
+}
+
+static struct device_attribute dev_attr_ram_qos_class =
+	__ATTR(qos_class, 0444, ram_qos_class_show, NULL);
+
 static struct attribute *cxl_memdev_ram_attributes[] = {
 	&dev_attr_ram_size.attr,
+	&dev_attr_ram_qos_class.attr,
 	NULL,
 };
 
@@ -477,14 +505,42 @@ static struct attribute_group cxl_memdev_attribute_group = {
 	.is_visible = cxl_memdev_visible,
 };
 
+static umode_t cxl_ram_visible(struct kobject *kobj, struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+
+	if (a == &dev_attr_ram_qos_class.attr)
+		if (mds->ram_perf.qos_class == CXL_QOS_CLASS_INVALID)
+			return 0;
+
+	return a->mode;
+}
+
 static struct attribute_group cxl_memdev_ram_attribute_group = {
 	.name = "ram",
 	.attrs = cxl_memdev_ram_attributes,
+	.is_visible = cxl_ram_visible,
 };
 
+static umode_t cxl_pmem_visible(struct kobject *kobj, struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+
+	if (a == &dev_attr_pmem_qos_class.attr)
+		if (mds->pmem_perf.qos_class == CXL_QOS_CLASS_INVALID)
+			return 0;
+
+	return a->mode;
+}
+
 static struct attribute_group cxl_memdev_pmem_attribute_group = {
 	.name = "pmem",
 	.attrs = cxl_memdev_pmem_attributes,
+	.is_visible = cxl_pmem_visible,
 };
 
 static umode_t cxl_memdev_security_visible(struct kobject *kobj,
@@ -519,6 +575,16 @@ static const struct attribute_group *cxl_memdev_attribute_groups[] = {
 	NULL,
 };
 
+void cxl_memdev_update_attribute_groups(struct cxl_memdev *cxlmd)
+{
+	int rc;
+
+	rc = sysfs_update_groups(&cxlmd->dev.kobj, cxl_memdev_attribute_groups);
+	if (rc)
+		dev_dbg(&cxlmd->dev, "Unable to update memdev attribute group.\n");
+}
+EXPORT_SYMBOL_NS_GPL(cxl_memdev_update_attribute_groups, CXL);
+
 static const struct device_type cxl_memdev_type = {
 	.name = "cxl_memdev",
 	.release = cxl_memdev_release,
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b6017c0c57b4..1f630b30d845 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -880,6 +880,8 @@ void cxl_switch_parse_cdat(struct cxl_port *port);
 int cxl_endpoint_get_perf_coordinates(struct cxl_port *port,
 				      struct access_coordinate *coord);
 
+void cxl_memdev_update_attribute_groups(struct cxl_memdev *cxlmd);
+
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
  * of these symbols in tools/testing/cxl/.
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 547f5a145fc5..0c79d9ce877c 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -215,32 +215,6 @@ static ssize_t trigger_poison_list_store(struct device *dev,
 }
 static DEVICE_ATTR_WO(trigger_poison_list);
 
-static ssize_t ram_qos_class_show(struct device *dev,
-				  struct device_attribute *attr, char *buf)
-{
-	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
-	struct cxl_dev_state *cxlds = cxlmd->cxlds;
-	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
-
-	return sysfs_emit(buf, "%d\n", mds->ram_perf.qos_class);
-}
-
-static struct device_attribute dev_attr_ram_qos_class =
-	__ATTR(qos_class, 0444, ram_qos_class_show, NULL);
-
-static ssize_t pmem_qos_class_show(struct device *dev,
-				   struct device_attribute *attr, char *buf)
-{
-	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
-	struct cxl_dev_state *cxlds = cxlmd->cxlds;
-	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
-
-	return sysfs_emit(buf, "%d\n", mds->pmem_perf.qos_class);
-}
-
-static struct device_attribute dev_attr_pmem_qos_class =
-	__ATTR(qos_class, 0444, pmem_qos_class_show, NULL);
-
 static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -252,21 +226,11 @@ static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
 			      mds->poison.enabled_cmds))
 			return 0;
 
-	if (a == &dev_attr_pmem_qos_class.attr)
-		if (mds->pmem_perf.qos_class == CXL_QOS_CLASS_INVALID)
-			return 0;
-
-	if (a == &dev_attr_ram_qos_class.attr)
-		if (mds->ram_perf.qos_class == CXL_QOS_CLASS_INVALID)
-			return 0;
-
 	return a->mode;
 }
 
 static struct attribute *cxl_mem_attrs[] = {
 	&dev_attr_trigger_poison_list.attr,
-	&dev_attr_ram_qos_class.attr,
-	&dev_attr_pmem_qos_class.attr,
 	NULL
 };
 
-- 
2.43.0

