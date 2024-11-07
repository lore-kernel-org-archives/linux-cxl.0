Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09DF218593;
	Thu,  7 Nov 2024 20:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731013141; cv=none; b=Q0YjqEiFmSKoeUq9rSxrLZm3QPAMdO2x5TgKy51oefeY+VqSBRvxJixCocXXCcwp3ccSflqmW0tvcKt4fx+Cv+d0QynXWw+5XIwH+7Xq0YMTwDTJnh6wip8+qlaTbINrVLbmzFJRYk+NyazUUKgPzhQOI7+SVLT7jNgO4TaLVgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731013141; c=relaxed/simple;
	bh=4xaMRMyWGYgrPuPjyvJaRxNXkkfAR0XYpHT99FiPWYY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CKst7x9xbCS3wRJAuYmIVqtvZ35YTYeAK5Hy0F5Tx7jxGLotEUiQ7ntJa97DJ/RLYOaMaAJL55UTLkuCjlwYmrg/cnEJmeSY3yzdCmE5mk6CG/xVKP0PV3fK9+6cFYng/MOu2/bRO72awoWZkd/ffTf/MpW2kMW8lwZXqVgNfxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E6B3g1p/; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E6B3g1p/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731013140; x=1762549140;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=4xaMRMyWGYgrPuPjyvJaRxNXkkfAR0XYpHT99FiPWYY=;
  b=E6B3g1p/P53G3XJ3KH8xlbga7QhylSTVV8HhymF61YxSBmB8m6dPHYd/
   i+ccbPtTZxBvDwX7Yvpsjk0W8tGkYswAZfQeTM20+6hy80eEXmS9a4/tb
   pJH6sV4j38FAOUdx9qUjKlgMsgB23cdOfEhL/LIibHZbb17i9FhuDmwJD
   cQSyXHMy25Ws2y9LMWD6jfZNjShFBrqZonHd+LDvbaVphKP5IS9l8Fe0H
   hJfZ57Dhf9FWXH2dbwEMQ/ipzo23+4aC7Nu3QwJVoYYN2JF/NzufWFS1e
   DZxP902UL56B2uFZVvUQZoawewfsYyg//RljFlBv3y2gaXyAaoj4kHIBR
   Q==;
X-CSE-ConnectionGUID: AWtYNaNgRLeKywSgG7LWNA==
X-CSE-MsgGUID: RnpfVBLtTpOTUOZeZnS/oQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41441021"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41441021"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 12:58:59 -0800
X-CSE-ConnectionGUID: tEz0Ox4DSce7OXNie48pBA==
X-CSE-MsgGUID: Vj4jzowTT66IXc5j4wCyPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,136,1728975600"; 
   d="scan'208";a="122746014"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.110.195])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2024 12:58:58 -0800
From: ira.weiny@intel.com
Date: Thu, 07 Nov 2024 14:58:31 -0600
Subject: [PATCH v7 13/27] cxl/mem: Expose DCD partition capabilities in
 sysfs
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241107-dcd-type2-upstream-v7-13-56a84e66bc36@intel.com>
References: <20241107-dcd-type2-upstream-v7-0-56a84e66bc36@intel.com>
In-Reply-To: <20241107-dcd-type2-upstream-v7-0-56a84e66bc36@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Fan Ni <fan.ni@samsung.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Navneet Singh <navneet.singh@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: Dan Williams <dan.j.williams@intel.com>, 
 Davidlohr Bueso <dave@stgolabs.net>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org, 
 nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15-dev-2a633
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731013104; l=8362;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=v70diWXu9mDxn9Gpd1u2NdGBAzSS3pHisSoxWHpPoyg=;
 b=NAZMJKOlMmzoz+T1ymwKNaa9Yj15cftaJg1fzOUORfBNEMXdiHwM2ancQC1L1pQgKQlBQGlqF
 5rSCv9QP0EgDCIeo++BCdh2SfGOw+37QlZLXmuFKok9ZfxEGWuHDGSw
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

From: Navneet Singh <navneet.singh@intel.com>

To properly configure CXL regions on Dynamic Capacity Devices (DCD),
user space will need to know the details of the DC partitions available.

Expose dynamic capacity capabilities through sysfs.

Signed-off-by: Navneet Singh <navneet.singh@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Co-developed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl |  45 ++++++++++++
 drivers/cxl/core/memdev.c               | 124 ++++++++++++++++++++++++++++++++
 2 files changed, 169 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 3f5627a1210a16aca7c18d17131a56491048a0c2..ff3ae83477f0876c0ee2d3955d27a11fa9d16d83 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -54,6 +54,51 @@ Description:
 		identically named field in the Identify Memory Device Output
 		Payload in the CXL-2.0 specification.
 
+What:		/sys/bus/cxl/devices/memX/dcY/size
+Date:		December, 2024
+KernelVersion:	v6.13
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) Dynamic Capacity (DC) region information.  Devices only
+		export dcY if DCD partition Y is supported.
+		dcY/size is the size of each of those partitions.
+
+What:		/sys/bus/cxl/devices/memX/dcY/read_only
+Date:		December, 2024
+KernelVersion:	v6.13
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) Dynamic Capacity (DC) region information.  Devices only
+		export dcY if DCD partition Y is supported.
+		dcY/read_only indicates true if the region is exported
+		read_only from the device.
+
+What:		/sys/bus/cxl/devices/memX/dcY/shareable
+Date:		December, 2024
+KernelVersion:	v6.13
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) Dynamic Capacity (DC) region information.  Devices only
+		export dcY if DCD partition Y is supported.
+		dcY/shareable indicates true if the region is exported
+		shareable from the device.
+
+What:		/sys/bus/cxl/devices/memX/dcY/qos_class
+Date:		December, 2024
+KernelVersion:	v6.13
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) Dynamic Capacity (DC) region information.  Devices only
+		export dcY if DCD partition Y is supported.  For CXL host
+		platforms that support "QoS Telemmetry" this attribute conveys
+		a comma delimited list of platform specific cookies that
+		identifies a QoS performance class for the persistent partition
+		of the CXL mem device. These class-ids can be compared against
+		a similar "qos_class" published for a root decoder. While it is
+		not required that the endpoints map their local memory-class to
+		a matching platform class, mismatches are not recommended as
+		there are platform specific performance related side-effects
+		that may result. First class-id is displayed.
 
 What:		/sys/bus/cxl/devices/memX/pmem/qos_class
 Date:		May, 2023
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 84fefb76dafabc22e6e1a12397381b3f18eea7c5..857a9dd88b20291116d20b9c0bbe9e7961f4491f 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -2,6 +2,7 @@
 /* Copyright(c) 2020 Intel Corporation. */
 
 #include <linux/io-64-nonatomic-lo-hi.h>
+#include <linux/string_choices.h>
 #include <linux/firmware.h>
 #include <linux/device.h>
 #include <linux/slab.h>
@@ -449,6 +450,121 @@ static struct attribute *cxl_memdev_security_attributes[] = {
 	NULL,
 };
 
+static ssize_t show_size_dcN(struct cxl_memdev *cxlmd, char *buf, int pos)
+{
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+
+	return sysfs_emit(buf, "%#llx\n", mds->dc_region[pos].decode_len);
+}
+
+static ssize_t show_read_only_dcN(struct cxl_memdev *cxlmd, char *buf, int pos)
+{
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+
+	return sysfs_emit(buf, "%s\n",
+			  str_true_false(mds->dc_region[pos].read_only));
+}
+
+static ssize_t show_shareable_dcN(struct cxl_memdev *cxlmd, char *buf, int pos)
+{
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+
+	return sysfs_emit(buf, "%s\n",
+			  str_true_false(mds->dc_region[pos].shareable));
+}
+
+static ssize_t show_qos_class_dcN(struct cxl_memdev *cxlmd, char *buf, int pos)
+{
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
+
+	return sysfs_emit(buf, "%d\n", mds->dc_perf[pos].qos_class);
+}
+
+#define CXL_MEMDEV_DC_ATTR_GROUP(n)						\
+static ssize_t dc##n##_size_show(struct device *dev,				\
+				 struct device_attribute *attr,			\
+				 char *buf)					\
+{										\
+	return show_size_dcN(to_cxl_memdev(dev), buf, (n));			\
+}										\
+struct device_attribute dc##n##_size = {					\
+	.attr	= { .name = "size", .mode = 0444 },				\
+	.show	= dc##n##_size_show,						\
+};										\
+static ssize_t dc##n##_read_only_show(struct device *dev,			\
+				      struct device_attribute *attr,		\
+				      char *buf)				\
+{										\
+	return show_read_only_dcN(to_cxl_memdev(dev), buf, (n));		\
+}										\
+struct device_attribute dc##n##_read_only = {					\
+	.attr	= { .name = "read_only", .mode = 0444 },			\
+	.show	= dc##n##_read_only_show,					\
+};										\
+static ssize_t dc##n##_shareable_show(struct device *dev,			\
+				     struct device_attribute *attr,		\
+				     char *buf)					\
+{										\
+	return show_shareable_dcN(to_cxl_memdev(dev), buf, (n));		\
+}										\
+struct device_attribute dc##n##_shareable = {					\
+	.attr	= { .name = "shareable", .mode = 0444 },			\
+	.show	= dc##n##_shareable_show,					\
+};										\
+static ssize_t dc##n##_qos_class_show(struct device *dev,			\
+				      struct device_attribute *attr,		\
+				      char *buf)				\
+{										\
+	return show_qos_class_dcN(to_cxl_memdev(dev), buf, (n));		\
+}										\
+struct device_attribute dc##n##_qos_class = {					\
+	.attr	= { .name = "qos_class", .mode = 0444 },			\
+	.show	= dc##n##_qos_class_show,					\
+};										\
+static struct attribute *cxl_memdev_dc##n##_attributes[] = {			\
+	&dc##n##_size.attr,							\
+	&dc##n##_read_only.attr,						\
+	&dc##n##_shareable.attr,						\
+	&dc##n##_qos_class.attr,						\
+	NULL									\
+};										\
+static umode_t cxl_memdev_dc##n##_attr_visible(struct kobject *kobj,		\
+					       struct attribute *a,		\
+					       int pos)				\
+{										\
+	struct device *dev = kobj_to_dev(kobj);					\
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);				\
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);	\
+										\
+	/* Not a memory device */						\
+	if (!mds)								\
+		return 0;							\
+	return a->mode;								\
+}										\
+static umode_t cxl_memdev_dc##n##_group_visible(struct kobject *kobj)		\
+{										\
+	struct device *dev = kobj_to_dev(kobj);					\
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);				\
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);	\
+										\
+	/* Not a memory device or partition not supported */			\
+	return mds && n < mds->nr_dc_region;					\
+}										\
+DEFINE_SYSFS_GROUP_VISIBLE(cxl_memdev_dc##n);					\
+static struct attribute_group cxl_memdev_dc##n##_group = {			\
+	.name = "dc"#n,								\
+	.attrs = cxl_memdev_dc##n##_attributes,					\
+	.is_visible = SYSFS_GROUP_VISIBLE(cxl_memdev_dc##n),			\
+}
+CXL_MEMDEV_DC_ATTR_GROUP(0);
+CXL_MEMDEV_DC_ATTR_GROUP(1);
+CXL_MEMDEV_DC_ATTR_GROUP(2);
+CXL_MEMDEV_DC_ATTR_GROUP(3);
+CXL_MEMDEV_DC_ATTR_GROUP(4);
+CXL_MEMDEV_DC_ATTR_GROUP(5);
+CXL_MEMDEV_DC_ATTR_GROUP(6);
+CXL_MEMDEV_DC_ATTR_GROUP(7);
+
 static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
 				  int n)
 {
@@ -525,6 +641,14 @@ static struct attribute_group cxl_memdev_security_attribute_group = {
 };
 
 static const struct attribute_group *cxl_memdev_attribute_groups[] = {
+	&cxl_memdev_dc0_group,
+	&cxl_memdev_dc1_group,
+	&cxl_memdev_dc2_group,
+	&cxl_memdev_dc3_group,
+	&cxl_memdev_dc4_group,
+	&cxl_memdev_dc5_group,
+	&cxl_memdev_dc6_group,
+	&cxl_memdev_dc7_group,
 	&cxl_memdev_attribute_group,
 	&cxl_memdev_ram_attribute_group,
 	&cxl_memdev_pmem_attribute_group,

-- 
2.47.0

