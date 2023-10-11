Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909D6A5D
	for <linux-cxl@vger.kernel.org>; Wed, 11 Oct 2023 01:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LQrlN0Hj"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B327B0
	for <linux-cxl@vger.kernel.org>; Tue, 10 Oct 2023 18:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696986427; x=1728522427;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Kot9YVMoABqFGyyl7Ml5E9154dCOYQ2RSB5MlXwuoLs=;
  b=LQrlN0HjC8OqjsrRbaDnFqclO9VZ/S07T0kLywaVlWITIM/aWpEjsR0w
   igsBD8x5pr9V3p+nFz606o61ABNW8TDM4uOukdp1YD2koTkmUORyz1ncY
   aUH1xruFjnrPr7R40kGXGzL1sRN6Qp09h10cVD1G6E8AvNX8pxV5bHcXv
   ZOb/p8vpV4k3QcLfvCUH5bCkE1LlwOi7dLsoktv2kYFuTkwYN80bc5FcQ
   4gYw9SGx4zLwMiwLGr65cjNq8TWGCkfXxYP/xA6cO2c8Bjqre9DOii+oR
   mpMdmhQOPLjS+pOBdeGUBXZ9cBYH9PjZBINgbNGzhJPYHKas+DrVY3lkm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="388419709"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="388419709"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 18:07:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="823976658"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="823976658"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.35.251])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 18:07:06 -0700
Subject: [PATCH v10 21/22] cxl: Export sysfs attributes for memory device QoS
 class
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Tue, 10 Oct 2023 18:07:06 -0700
Message-ID: <169698642598.1991735.4883136743132463123.stgit@djiang5-mobl3>
In-Reply-To: <169698612949.1991735.1140524325982776941.stgit@djiang5-mobl3>
References: <169698612949.1991735.1140524325982776941.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Export qos_class sysfs attributes for the CXL memory device. The QoS clas
should show up as /sys/bus/cxl/devices/memX/ram/qos_class0 for the volatile
partition and /sys/bus/cxl/devices/memX/pmem/qos_class0 for the persistent
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
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v10:
- Export only qos_class0, the first entry. Additional qos_class entries can be
  exported later as needed. (Dan)
- Have the sysfs attrib return -ENOENT unless driver is attached. (Dan)
- Removed Jonathan's review tag due to code changes.
---
 Documentation/ABI/testing/sysfs-bus-cxl |   34 +++++++++++++++++++++++++++++++
 drivers/cxl/core/memdev.c               |   34 +++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 44ffbbb36654..dd613f5987b5 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -28,6 +28,23 @@ Description:
 		Payload in the CXL-2.0 specification.
 
 
+What:		/sys/bus/cxl/devices/memX/ram/qos_class0
+Date:		May, 2023
+KernelVersion:	v6.7
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
 
 
+What:		/sys/bus/cxl/devices/memX/pmem/qos_class0
+Date:		May, 2023
+KernelVersion:	v6.7
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
index 14b547c07f54..bfecc9da2561 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -88,6 +88,22 @@ static ssize_t ram_size_show(struct device *dev, struct device_attribute *attr,
 static struct device_attribute dev_attr_ram_size =
 	__ATTR(size, 0444, ram_size_show, NULL);
 
+static ssize_t ram_qos_class0_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+
+	if (!dev->driver)
+		return -ENOENT;
+
+	return sysfs_emit(buf, "%d\n", mds->ram_qos_class);
+}
+
+static struct device_attribute dev_attr_ram_qos_class0 =
+	__ATTR(qos_class0, 0444, ram_qos_class0_show, NULL);
+
 static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
 			      char *buf)
 {
@@ -101,6 +117,22 @@ static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
 static struct device_attribute dev_attr_pmem_size =
 	__ATTR(size, 0444, pmem_size_show, NULL);
 
+static ssize_t pmem_qos_class0_show(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+
+	if (!dev->driver)
+		return -ENOENT;
+
+	return sysfs_emit(buf, "%d\n", mds->pmem_qos_class);
+}
+
+static struct device_attribute dev_attr_pmem_qos_class0 =
+	__ATTR(qos_class0, 0444, pmem_qos_class0_show, NULL);
+
 static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
@@ -439,11 +471,13 @@ static struct attribute *cxl_memdev_attributes[] = {
 
 static struct attribute *cxl_memdev_pmem_attributes[] = {
 	&dev_attr_pmem_size.attr,
+	&dev_attr_pmem_qos_class0.attr,
 	NULL,
 };
 
 static struct attribute *cxl_memdev_ram_attributes[] = {
 	&dev_attr_ram_size.attr,
+	&dev_attr_ram_qos_class0.attr,
 	NULL,
 };
 


