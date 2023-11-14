Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AE926AF7
	for <linux-cxl@vger.kernel.org>; Tue, 14 Nov 2023 23:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JU1WMmkz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832D1D1
	for <linux-cxl@vger.kernel.org>; Tue, 14 Nov 2023 15:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700003152; x=1731539152;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JYPcOidqYIYQrOg3zO+RQWFE4cFR8xl+fv7KXNGeazc=;
  b=JU1WMmkzPLRp93Jfay1Ql9D/8DuB63WL3+ykhij7jjqydB8ajWkv/DF1
   rqSTYnY7YgIeySZm/gP0IU++Uew6lAsQ2fOefdiJjvWCJNQg0yAhj7UIg
   ugtzJ7WPCUol94uUV2GlIqTiaz4BGSARLUMpXEOPU5FDzfctMMU1KY3Jo
   jzJF+kE848yFkRMcLkuRJOyoqAXDN4BhmyWTqemiuExR9hXaRnxT6D6BT
   cMJ8H7LM7YVVLaUB5orntj7bhVs46qDCb/mrC3zyLmSDFBmYwON1qUjl+
   kXp3seX+Rt17t9gH3OUDvh1kY79FwFJY8paYMRBk9VWVHB1mREyHm4VuY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="12308558"
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="12308558"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 15:05:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,303,1694761200"; 
   d="scan'208";a="12586022"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.87.32])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 15:05:52 -0800
Subject: [PATCH v12 17/18] cxl: Export sysfs attributes for memory device QoS
 class
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Tue, 14 Nov 2023 16:05:51 -0700
Message-ID: <170000315132.1974471.14379811243633423568.stgit@djiang5-mobl3>
In-Reply-To: <170000290509.1974471.16084327074615798619.stgit@djiang5-mobl3>
References: <170000290509.1974471.16084327074615798619.stgit@djiang5-mobl3>
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
v12:
- adjust to individual perf list
---
 Documentation/ABI/testing/sysfs-bus-cxl |   34 +++++++++++++++++++++++
 drivers/cxl/core/memdev.c               |   46 +++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

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
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index fc5c2b414793..4aed94c9f547 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -88,6 +88,28 @@ static ssize_t ram_size_show(struct device *dev, struct device_attribute *attr,
 static struct device_attribute dev_attr_ram_size =
 	__ATTR(size, 0444, ram_size_show, NULL);
 
+static ssize_t ram_qos_class_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	struct perf_prop_entry *perf;
+
+	if (!dev->driver)
+		return -ENOENT;
+
+	if (list_empty(&mds->ram_perf_list))
+		return -ENOENT;
+
+	perf = list_first_entry(&mds->ram_perf_list, struct perf_prop_entry, list);
+
+	return sysfs_emit(buf, "%d\n", perf->qos_class);
+}
+
+static struct device_attribute dev_attr_ram_qos_class =
+	__ATTR(qos_class, 0444, ram_qos_class_show, NULL);
+
 static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
 			      char *buf)
 {
@@ -101,6 +123,28 @@ static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
 static struct device_attribute dev_attr_pmem_size =
 	__ATTR(size, 0444, pmem_size_show, NULL);
 
+static ssize_t pmem_qos_class_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	struct perf_prop_entry *perf;
+
+	if (!dev->driver)
+		return -ENOENT;
+
+	if (list_empty(&mds->pmem_perf_list))
+		return -ENOENT;
+
+	perf = list_first_entry(&mds->pmem_perf_list, struct perf_prop_entry, list);
+
+	return sysfs_emit(buf, "%d\n", perf->qos_class);
+}
+
+static struct device_attribute dev_attr_pmem_qos_class =
+	__ATTR(qos_class, 0444, pmem_qos_class_show, NULL);
+
 static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
@@ -428,11 +472,13 @@ static struct attribute *cxl_memdev_attributes[] = {
 
 static struct attribute *cxl_memdev_pmem_attributes[] = {
 	&dev_attr_pmem_size.attr,
+	&dev_attr_pmem_qos_class.attr,
 	NULL,
 };
 
 static struct attribute *cxl_memdev_ram_attributes[] = {
 	&dev_attr_ram_size.attr,
+	&dev_attr_ram_qos_class.attr,
 	NULL,
 };
 


