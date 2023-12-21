Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3CC177F09
	for <linux-cxl@vger.kernel.org>; Thu, 21 Dec 2023 22:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZIIb9dP1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703196258; x=1734732258;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5c6sTnKVoO803C9myrzfDiIOFg8uFAcchPa8xNU+AqY=;
  b=ZIIb9dP1FWmG+pE6oVC83EFE+rfqXeM6WUxt6k4MtMWygYUlOJCt2rnK
   tkkC93S7ytz6qCfOVzskf5iAmDUemuSNYsm64bcOXH36TpbpACMyfBAwm
   OmWRCh4FWMnPVzENVGlKPv2U0VF6TMd4ju/VaEf05lHYzs/drObZK7Key
   +ImZFH26pxZ/yzcsY3RyWGpm37zQtIoQgkYl+p8WR4YKWBnkm4R3tI7mz
   VE1syK4+tKtMIS3jsyyXPk8BWor+yI06u3SkOBskV/YHAOsS3tLRb0hav
   3lpBXJXb2c6YSLAkETu++p9PPCMYs+Xvq8Aa+0EWtseYuy3AoD/JebHys
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="398831662"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="398831662"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 14:04:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="895242875"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="895242875"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.31.86])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 14:04:17 -0800
Subject: [PATCH v15 18/19] cxl: Export sysfs attributes for memory device QoS
 class
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Thu, 21 Dec 2023 15:04:16 -0700
Message-ID: <170319625698.2212653.17544381274847420961.stgit@djiang5-mobl3>
In-Reply-To: <170319606771.2212653.5435838660860735129.stgit@djiang5-mobl3>
References: <170319606771.2212653.5435838660860735129.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Export qos_class sysfs attributes for the CXL memory device. The QoS clas
should show up as /sys/bus/cxl/devices/memX/ram/qos_class for the volatile
partition and /sys/bus/cxl/devices/memX/pmem/qos_class for the persistent
partition. The QTG ID is retrieved via _DSM after supplying the
calculated bandwidth and latency for the entire CXL path from device to
the CPU. This ID is used to match up to the root decoder QoS class to
determine which CFMWS the memory range of a hotplugged CXL mem device
should be assigned under.

While there may be multiple DSMAS exported by the device CDAT, the driver
will only expose the first QTG ID per partition in sysfs for now. In the
future when multiple QTG IDs are necessary, they can be exposed. [1]

[1]: https://lore.kernel.org/linux-cxl/167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local/T/#md2a47b1ead3e1ba08f50eab29a4af1aed1d215ab

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v15:
- Add back missing chunk dropped due to rebase.
---
 Documentation/ABI/testing/sysfs-bus-cxl |   34 ++++++++++++++++
 drivers/cxl/mem.c                       |   67 ++++++++++++++++++++++++++++---
 2 files changed, 95 insertions(+), 6 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index e76c3600607f..fff2581b8033 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -28,6 +28,23 @@ Description:
 		Payload in the CXL-2.0 specification.
 
 
+What:		/sys/bus/cxl/devices/memX/ram/qos_class
+Date:		May, 2023
+KernelVersion:	v6.8
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) For CXL host platforms that support "QoS Telemmetry"
+		this attribute conveys a comma delimited list of platform
+		specific cookies that identifies a QoS performance class
+		for the volatile partition of the CXL mem device. These
+		class-ids can be compared against a similar "qos_class"
+		published for a root decoder. While it is not required
+		that the endpoints map their local memory-class to a
+		matching platform class, mismatches are not recommended
+		and there are platform specific performance related
+		side-effects that may result. First class-id is displayed.
+
+
 What:		/sys/bus/cxl/devices/memX/pmem/size
 Date:		December, 2020
 KernelVersion:	v5.12
@@ -38,6 +55,23 @@ Description:
 		Payload in the CXL-2.0 specification.
 
 
+What:		/sys/bus/cxl/devices/memX/pmem/qos_class
+Date:		May, 2023
+KernelVersion:	v6.8
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) For CXL host platforms that support "QoS Telemmetry"
+		this attribute conveys a comma delimited list of platform
+		specific cookies that identifies a QoS performance class
+		for the persistent partition of the CXL mem device. These
+		class-ids can be compared against a similar "qos_class"
+		published for a root decoder. While it is not required
+		that the endpoints map their local memory-class to a
+		matching platform class, mismatches are not recommended
+		and there are platform specific performance related
+		side-effects that may result. First class-id is displayed.
+
+
 What:		/sys/bus/cxl/devices/memX/serial
 Date:		January, 2022
 KernelVersion:	v5.18
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index e087febf9af0..c5c9d8e0d88d 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -215,23 +215,78 @@ static ssize_t trigger_poison_list_store(struct device *dev,
 }
 static DEVICE_ATTR_WO(trigger_poison_list);
 
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
 static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
 {
-	if (a == &dev_attr_trigger_poison_list.attr) {
-		struct device *dev = kobj_to_dev(kobj);
-		struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
-		struct cxl_memdev_state *mds =
-			to_cxl_memdev_state(cxlmd->cxlds);
+	struct device *dev = kobj_to_dev(kobj);
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
 
+	if (a == &dev_attr_trigger_poison_list.attr)
 		if (!test_bit(CXL_POISON_ENABLED_LIST,
 			      mds->poison.enabled_cmds))
 			return 0;
-	}
+
+	if (a == &dev_attr_pmem_qos_class.attr)
+		if (list_empty(&mds->pmem_perf_list))
+			return 0;
+
+	if (a == &dev_attr_ram_qos_class.attr)
+		if (list_empty(&mds->ram_perf_list))
+			return 0;
+
 	return a->mode;
 }
 
 static struct attribute *cxl_mem_attrs[] = {
 	&dev_attr_trigger_poison_list.attr,
+	&dev_attr_ram_qos_class.attr,
+	&dev_attr_pmem_qos_class.attr,
 	NULL
 };
 


