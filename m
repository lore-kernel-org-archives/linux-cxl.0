Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B473E49B
	for <linux-cxl@vger.kernel.org>; Thu,  1 Feb 2024 21:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706824060; cv=none; b=n4HNOw7ZiyvfOIzbcYqTHwpzMx/1xbnwWlOBMXBhfcUx6jzCeRHBQ0Ifv+XBMalyvortXzcxkqUp1TBx5yV2JyDZL+M1pcsU+HxBlP0StjUbO7e2cvw3ULGiBOoOIyh8NRbXOl9gFEcv1su0Daska+dPkrb+yvc2ChRl+uK6HN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706824060; c=relaxed/simple;
	bh=4Fh7Fvj8ZCVI9FY10J4+hJAzgk/eqlxjrU3vDiGlXQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=On4R6GiS4V3gRqFBzG33ugSY7jkGdwi82nnNXXzggyIh5USW+D8nEnPNFtxUdpZiZw6yMsgLxZw9jdV/M6h6SqwBOhGHpg2h13S+pyTugoFjk9PbEEvR1JRZ6Pez4QhPQyGdy5slVP8udgLnlgO2Xc7kF8xrKR7dOOHpKxjGF1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71FBCC433C7;
	Thu,  1 Feb 2024 21:47:39 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: [PATCH v3 2/3] cxl: Fix sysfs export of qos_class for memdev
Date: Thu,  1 Feb 2024 14:47:30 -0700
Message-ID: <20240201214731.1297389-2-dave.jiang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240201214731.1297389-1-dave.jiang@intel.com>
References: <20240201214731.1297389-1-dave.jiang@intel.com>
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
v3:
- Updated based on pervious patch changes
---
 drivers/cxl/core/cdat.c   |  1 +
 drivers/cxl/core/memdev.c | 71 +++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h         |  2 ++
 drivers/cxl/mem.c         | 36 --------------------
 4 files changed, 74 insertions(+), 36 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 55b82dfd794b..5c93bf9d5253 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -382,6 +382,7 @@ void cxl_endpoint_parse_cdat(struct cxl_port *port)
 
 	cxl_memdev_set_qos_class(cxlds, dsmas_xa);
 	cxl_qos_class_verify(cxlmd);
+	cxl_memdev_update_attribute_groups(cxlmd);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_endpoint_parse_cdat, CXL);
 
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index dae8802ecdb0..ed85096a33fb 100644
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
@@ -519,6 +575,21 @@ static const struct attribute_group *cxl_memdev_attribute_groups[] = {
 	NULL,
 };
 
+void cxl_memdev_update_attribute_groups(struct cxl_memdev *cxlmd)
+{
+	const struct attribute_group *grp = cxl_memdev_attribute_groups[0];
+
+	for (int i = 0; grp; i++) {
+		int rc = sysfs_update_group(&cxlmd->dev.kobj, grp);
+
+		if (rc)
+			dev_dbg(&cxlmd->dev,
+				"Unable to update memdev attribute group.\n");
+		grp = cxl_memdev_attribute_groups[i + 1];
+	}
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

