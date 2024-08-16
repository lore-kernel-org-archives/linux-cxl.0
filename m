Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3EC1BE85C;
	Fri, 16 Aug 2024 14:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723817309; cv=none; b=jQk/t4jJlPt3oXMb1oH2acU+6wGYGysuMuXMsyebWPbc1Hd1rjYmj90BPXmiP83jNp4F7cOmF44k6L8ykQ3QpITiARxsBDgU6l4pt/EPXvk1rf7JvLzc8rXFzQMfX1gOHehrOYY+jJeU9PVRTNL8XuA18ug3KKIU9cyruIsESf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723817309; c=relaxed/simple;
	bh=jaz45Cg2pqMvlzzf47/HowZPJBI3aqLOkcKiZz6RG0k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MuXiHyhQ3sbCA+OxdKUgExlQs0hpF9enpEHf9qvIvdsVeSVe0fcVYTQRXPzbgDn0rwxUPI4zeIugqcBQ1Aeu7SVR0rml7UVIfnQ5wTZ8pH6UTrQVgs9DVicB2cmj9Qj1UFPIxjT+iFxiorP4UzlPqEmUMmI7W3qQ36wMuhKP82Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jaJNFyas; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jaJNFyas"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723817308; x=1755353308;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=jaz45Cg2pqMvlzzf47/HowZPJBI3aqLOkcKiZz6RG0k=;
  b=jaJNFyasv3ZXDj1qeih6za6v30ahTe0LUjQBic/zv07aTWZLuc5QxVx5
   ojCdf+iXk9FoALZqsUKRxHo5Ms61ulD4gLTUma2PWL2aGiyeusAlJM/T2
   SFYEMqe9U0qMeqy/OFZFj4AWw7uoocrH4wIwVzjGfAuvLsYSnuXb/iCnE
   H6LXn04EzSFFtsbAN68Zm23OURBj9y9IGFucUGTqnGMU6JzEbUIL87i12
   Hi+Xa8JwwbCH+O/sBYsLYQUNIBttoFzTMixISfLS2V8rjm6D/BM6J1FDb
   GCtrvGr9dlA8C6ogBjr+qe4M9YBQ812CaDNjh0oTggUzsCHn+yJPQkbZe
   A==;
X-CSE-ConnectionGUID: nyeEnjtaRUy95nHu4uaVpg==
X-CSE-MsgGUID: Af0fhp6OQbCHRjEb4t+o8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="22260942"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="22260942"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:08:27 -0700
X-CSE-ConnectionGUID: 5RmTBmhqR+mgIfBlgqdd1g==
X-CSE-MsgGUID: QJPeDAL+Rgi7x70810/Mhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="59847830"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.125.111.52])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:08:27 -0700
From: ira.weiny@intel.com
Date: Fri, 16 Aug 2024 09:08:12 -0500
Subject: [PATCH RESEND v2 07/18] cxl/mem: Expose device dynamic capacity
 configuration
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-dcd-type2-upstream-v2-7-b4044aadf2bd@intel.com>
References: <20240816-dcd-type2-upstream-v2-0-b4044aadf2bd@intel.com>
In-Reply-To: <20240816-dcd-type2-upstream-v2-0-b4044aadf2bd@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Navneet Singh <navneet.singh@intel.com>, Fan Ni <fan.ni@samsung.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723817288; l=5256;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=nBWifJ1VLMZQWZNywKm9WXbBuw4hP48Bp6JqPV2qOa8=;
 b=qKaSn7tI+sNOohsg7Z/Zj88wYKmhinqyp+TDcECXuE1QKo0b5uhoZ/szCRelUX7agCli4txtO
 Hfk0dY1QqOsCFBTj+b2EmZKRwkv60K2k2hJpf6DyicU5s+zMIhI6dw8
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

From: Navneet Singh <navneet.singh@intel.com>

To properly configure CXL regions on Dynamic Capacity Devices (DCD),
user space will need to know the details of the DC Regions available on
a device.

Expose driver dynamic capacity configuration through sysfs
attributes.

Co-developed-by: Navneet Singh <navneet.singh@intel.com>
Signed-off-by: Navneet Singh <navneet.singh@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for v2:
[iweiny: Rebased on latest master/type2 work]
[iweiny: add documentation for sysfs entries]
[iweiny: s/dc_regions_count/region_count/]
[iweiny: s/dcY_size/regionY_size/]
[alison: change size format to %#llx]
[iweiny: change count format to %d]
[iweiny: Formatting updates]
[iweiny: Fix crash when device is not a mem device: found with cxl-test]
---
 Documentation/ABI/testing/sysfs-bus-cxl | 17 ++++++++
 drivers/cxl/core/memdev.c               | 77 +++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 2268ffcdb604..aa65dc5b4e13 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -37,6 +37,23 @@ Description:
 		identically named field in the Identify Memory Device Output
 		Payload in the CXL-2.0 specification.
 
+What:		/sys/bus/cxl/devices/memX/dc/region_count
+Date:		July, 2023
+KernelVersion:	v6.6
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) Number of Dynamic Capacity (DC) regions supported on the
+		device.  May be 0 if the device does not support Dynamic
+		Capacity.
+
+What:		/sys/bus/cxl/devices/memX/dc/regionY_size
+Date:		July, 2023
+KernelVersion:	v6.6
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) Size of the Dynamic Capacity (DC) region Y.  Only
+		available on devices which support DC and only for those
+		region indexes supported by the device.
 
 What:		/sys/bus/cxl/devices/memX/serial
 Date:		January, 2022
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 492486707fd0..397262e0ebd2 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -101,6 +101,20 @@ static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
 static struct device_attribute dev_attr_pmem_size =
 	__ATTR(size, 0444, pmem_size_show, NULL);
 
+static ssize_t region_count_show(struct device *dev, struct device_attribute *attr,
+				 char *buf)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+	int len = 0;
+
+	len = sysfs_emit(buf, "%d\n", mds->nr_dc_region);
+	return len;
+}
+
+struct device_attribute dev_attr_region_count =
+	__ATTR(region_count, 0444, region_count_show, NULL);
+
 static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
@@ -454,6 +468,62 @@ static struct attribute *cxl_memdev_security_attributes[] = {
 	NULL,
 };
 
+static ssize_t show_size_regionN(struct cxl_memdev *cxlmd, char *buf, int pos)
+{
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+
+	return sysfs_emit(buf, "%#llx\n", mds->dc_region[pos].decode_len);
+}
+
+#define REGION_SIZE_ATTR_RO(n)						\
+static ssize_t region##n##_size_show(struct device *dev,		\
+				     struct device_attribute *attr,	\
+				     char *buf)				\
+{									\
+	return show_size_regionN(to_cxl_memdev(dev), buf, (n));		\
+}									\
+static DEVICE_ATTR_RO(region##n##_size)
+REGION_SIZE_ATTR_RO(0);
+REGION_SIZE_ATTR_RO(1);
+REGION_SIZE_ATTR_RO(2);
+REGION_SIZE_ATTR_RO(3);
+REGION_SIZE_ATTR_RO(4);
+REGION_SIZE_ATTR_RO(5);
+REGION_SIZE_ATTR_RO(6);
+REGION_SIZE_ATTR_RO(7);
+
+static struct attribute *cxl_memdev_dc_attributes[] = {
+	&dev_attr_region0_size.attr,
+	&dev_attr_region1_size.attr,
+	&dev_attr_region2_size.attr,
+	&dev_attr_region3_size.attr,
+	&dev_attr_region4_size.attr,
+	&dev_attr_region5_size.attr,
+	&dev_attr_region6_size.attr,
+	&dev_attr_region7_size.attr,
+	&dev_attr_region_count.attr,
+	NULL,
+};
+
+static umode_t cxl_dc_visible(struct kobject *kobj, struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+
+	/* Not a memory device */
+	if (!mds)
+		return 0;
+
+	if (a == &dev_attr_region_count.attr)
+		return a->mode;
+
+	if (n < mds->nr_dc_region)
+		return a->mode;
+
+	return 0;
+}
+
 static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
 				  int n)
 {
@@ -482,11 +552,18 @@ static struct attribute_group cxl_memdev_security_attribute_group = {
 	.attrs = cxl_memdev_security_attributes,
 };
 
+static struct attribute_group cxl_memdev_dc_attribute_group = {
+	.name = "dc",
+	.attrs = cxl_memdev_dc_attributes,
+	.is_visible = cxl_dc_visible,
+};
+
 static const struct attribute_group *cxl_memdev_attribute_groups[] = {
 	&cxl_memdev_attribute_group,
 	&cxl_memdev_ram_attribute_group,
 	&cxl_memdev_pmem_attribute_group,
 	&cxl_memdev_security_attribute_group,
+	&cxl_memdev_dc_attribute_group,
 	NULL,
 };
 

-- 
2.45.2

