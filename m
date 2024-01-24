Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A4B13175B
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jan 2024 18:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706122129; cv=none; b=VPAPdd8F41GEBaiYoEMXtHGu/VsR4q6FVG4ufs76S6SG+0K+TOnJsjOQ9ikumlOfJfnaWsje51S/3tAxT/M79qMwO1qjePznxbK8WZ0rdumnEpNahEzENjOaW8DRPDNd5z+/8R+82RNSjj/wxoY83lIkDK1hC6fNHjGK2I3XVVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706122129; c=relaxed/simple;
	bh=PDDjcKV+eIKd2of5PJ12hfeKFK1DEy20nPWpvRUzpvU=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=TrvWK/D1rviBKx13XiOnpduGjxA82/pPLwccsZcOm55gV6J0yxB/OWOewyJrM2BgJgOaV6E2ejQdRIyWEuQ2qaJ3HE3IvbzqNqfgmKpTy0QlPXMQpGNblIPZRPTUpacZxHzBTRZZY0/kGVjF5RtD33ETrgeF//eqvFECtPkMA0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZOU6Uva5; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZOU6Uva5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706122127; x=1737658127;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=PDDjcKV+eIKd2of5PJ12hfeKFK1DEy20nPWpvRUzpvU=;
  b=ZOU6Uva5RFmXjCnuX20NRKGD8M3ks/DGZVaqk0Ta2cC/1Ejc91e/JNMn
   AXQUXPXYzOeUZiUPW2EUN7YaBL1NquvVyIqt1KLFMeTpzgHzSugvfSJ9z
   pg7PUQ2u1I04/iAwt5wx0lmOyTaQvM9jOXNbcAqgAt7gnicirWOLiRG7p
   xQE00u/Bn23kOkNtXBy9dxgEO7SgTPUpxSqDXiJFNPQOCyox5GQMlsHpt
   m1E06Zc+ThwLAN8sMDXYepv6HMgIvWK07jgchwoeWnsnYuFpQ1BCHkXvp
   8M64G8+99pAbWl0nZa5If7ZIvzw2CnCrj3yPB/GbUWiT7HvAbL+KeAozI
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10962"; a="839464"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="839464"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 10:48:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="1982170"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.209.164.29])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2024 10:48:38 -0800
Subject: [PATCH] cxl: Fix sysfs export of qos_class for memdev
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, jonathan.cameron@huawei.com, dave@stgolabs.net
Date: Wed, 24 Jan 2024 11:48:37 -0700
Message-ID: <170612211746.2737788.8759299841309402825.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

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

Fixes: 42834b17cf1f ("cxl: Export sysfs attributes for memory device QoS class")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/cdat.c   |   12 ++++++
 drivers/cxl/core/core.h   |    3 ++
 drivers/cxl/core/memdev.c |   86 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/mem.c         |   56 -----------------------------
 4 files changed, 101 insertions(+), 56 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 6fe11546889f..a47dc4102140 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -395,6 +395,7 @@ void cxl_endpoint_parse_cdat(struct cxl_port *port)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
 	struct xarray __dsmas_xa;
 	struct xarray *dsmas_xa __free(dsmas) = &__dsmas_xa;
 	int rc;
@@ -417,6 +418,17 @@ void cxl_endpoint_parse_cdat(struct cxl_port *port)
 
 	cxl_memdev_set_qos_class(cxlds, dsmas_xa);
 	cxl_qos_class_verify(cxlmd);
+	if (!list_empty(&mds->ram_perf_list)) {
+		rc = sysfs_update_group(&cxlmd->dev.kobj, get_cxl_memdev_ram_group());
+		if (rc)
+			dev_dbg(&cxlmd->dev, "Failed to update RAM QoS group\n");
+	}
+
+	if (!list_empty(&mds->pmem_perf_list)) {
+		rc = sysfs_update_group(&cxlmd->dev.kobj, get_cxl_memdev_pmem_group());
+		if (rc)
+			dev_dbg(&cxlmd->dev, "Failed to update PMEM QoS group\n");
+	}
 }
 EXPORT_SYMBOL_NS_GPL(cxl_endpoint_parse_cdat, CXL);
 
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 3b64fb1b9ed0..44958be2178a 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -90,4 +90,7 @@ enum cxl_poison_trace_type {
 
 long cxl_pci_get_latency(struct pci_dev *pdev);
 
+const struct attribute_group *get_cxl_memdev_ram_group(void);
+const struct attribute_group *get_cxl_memdev_pmem_group(void);
+
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index dae8802ecdb0..5743c6b2710c 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -447,13 +447,61 @@ static struct attribute *cxl_memdev_attributes[] = {
 	NULL,
 };
 
+static ssize_t pmem_qos_class_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	struct cxl_dpa_perf *dpa_perf;
+
+	if (!dev->driver)
+		return -ENOENT;
+
+	if (list_empty(&mds->pmem_perf_list))
+		return -ENOENT;
+
+	dpa_perf = list_first_entry(&mds->pmem_perf_list, struct cxl_dpa_perf,
+				    list);
+
+	return sysfs_emit(buf, "%d\n", dpa_perf->qos_class);
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
+	struct cxl_dpa_perf *dpa_perf;
+
+	if (!dev->driver)
+		return -ENOENT;
+
+	if (list_empty(&mds->ram_perf_list))
+		return -ENOENT;
+
+	dpa_perf = list_first_entry(&mds->ram_perf_list, struct cxl_dpa_perf,
+				    list);
+
+	return sysfs_emit(buf, "%d\n", dpa_perf->qos_class);
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
 
@@ -477,16 +525,54 @@ static struct attribute_group cxl_memdev_attribute_group = {
 	.is_visible = cxl_memdev_visible,
 };
 
+static umode_t cxl_ram_visible(struct kobject *kobj, struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+
+	if (a == &dev_attr_ram_qos_class.attr)
+		if (list_empty(&mds->ram_perf_list))
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
 
+const struct attribute_group *get_cxl_memdev_ram_group(void)
+{
+	return &cxl_memdev_ram_attribute_group;
+}
+
+static umode_t cxl_pmem_visible(struct kobject *kobj, struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+
+	if (a == &dev_attr_pmem_qos_class.attr)
+		if (list_empty(&mds->pmem_perf_list))
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
 
+const struct attribute_group *get_cxl_memdev_pmem_group(void)
+{
+	return &cxl_memdev_pmem_attribute_group;
+}
+
 static umode_t cxl_memdev_security_visible(struct kobject *kobj,
 					   struct attribute *a, int n)
 {
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index c5c9d8e0d88d..0c79d9ce877c 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -215,52 +215,6 @@ static ssize_t trigger_poison_list_store(struct device *dev,
 }
 static DEVICE_ATTR_WO(trigger_poison_list);
 
-static ssize_t ram_qos_class_show(struct device *dev,
-				  struct device_attribute *attr, char *buf)
-{
-	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
-	struct cxl_dev_state *cxlds = cxlmd->cxlds;
-	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
-	struct cxl_dpa_perf *dpa_perf;
-
-	if (!dev->driver)
-		return -ENOENT;
-
-	if (list_empty(&mds->ram_perf_list))
-		return -ENOENT;
-
-	dpa_perf = list_first_entry(&mds->ram_perf_list, struct cxl_dpa_perf,
-				    list);
-
-	return sysfs_emit(buf, "%d\n", dpa_perf->qos_class);
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
-	struct cxl_dpa_perf *dpa_perf;
-
-	if (!dev->driver)
-		return -ENOENT;
-
-	if (list_empty(&mds->pmem_perf_list))
-		return -ENOENT;
-
-	dpa_perf = list_first_entry(&mds->pmem_perf_list, struct cxl_dpa_perf,
-				    list);
-
-	return sysfs_emit(buf, "%d\n", dpa_perf->qos_class);
-}
-
-static struct device_attribute dev_attr_pmem_qos_class =
-	__ATTR(qos_class, 0444, pmem_qos_class_show, NULL);
-
 static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
 {
 	struct device *dev = kobj_to_dev(kobj);
@@ -272,21 +226,11 @@ static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
 			      mds->poison.enabled_cmds))
 			return 0;
 
-	if (a == &dev_attr_pmem_qos_class.attr)
-		if (list_empty(&mds->pmem_perf_list))
-			return 0;
-
-	if (a == &dev_attr_ram_qos_class.attr)
-		if (list_empty(&mds->ram_perf_list))
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
 


