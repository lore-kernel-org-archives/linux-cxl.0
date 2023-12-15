Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C345313B124
	for <linux-cxl@vger.kernel.org>; Fri, 15 Dec 2023 23:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MPAwRoKP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702682167; x=1734218167;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JENTZPeCVTUyrzfz8NtGgBjzVAuC0yqW7jxOchOZ3Ak=;
  b=MPAwRoKP+7/Tr5snb/zIlRYFoBlUN78Fn32La+tuKGAbTIOxTgZu9Bq7
   4j+UWhKtkZVTOMnV1ydoV2FyV0LOG1r63I072JY/fuFvdp2CMz3/kTSXy
   f8GUB5Ngt7AzP5XPVbnAvOCCA2PrDFLAD/gcG3H7qISkLFjKrcYl4XUcB
   SwkdJL9PKfGErsm38epFCZp5F47DrzioTkoT4oA2aMITyb490sngysqe+
   Jgmm0Ve9lq9q+0pDDhR/0s7WZCGM3YwPqgZM4fqRbEfl2D3WYDxwBxdrH
   NOdhJTcafeR+x8i4NSag+6LJQbFch9vK2e8JmWNzqc4ko0kMtb1tPIKbo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="2192019"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="2192019"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 15:16:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="1022091032"
X-IronPort-AV: E=Sophos;i="6.04,280,1695711600"; 
   d="scan'208";a="1022091032"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.213.188.77])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 15:16:06 -0800
Subject: [PATCH v2 2/3] cxl/region: Add sysfs attribute for locality
 attributes of CXL regions
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, jonathan.cameron@huawei.com, dave@stgolabs.net,
 brice.goglin@gmail.com, nifan.cxl@gmail.com
Date: Fri, 15 Dec 2023 16:16:05 -0700
Message-ID: <170268216573.1381493.1848451783927736490.stgit@djiang5-mobl3>
In-Reply-To: <170268206638.1381493.3891165173978942658.stgit@djiang5-mobl3>
References: <170268206638.1381493.3891165173978942658.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Add read/write latencies and bandwidth sysfs attributes for the enabled CXL
region. The bandwidth is the aggregated bandwidth of all devices that
contribute to the CXL region. The latency is the worst latency of the
device amongst all the devices that contribute to the CXL region.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v2:
- Add units for documentation (Brice, Dan)
- Add explanation initiator/target relation. (Brice)
- Fix issue in commit log (Fan)
---
 Documentation/ABI/testing/sysfs-bus-cxl |   56 +++++++++++++++++++++++++++++++
 drivers/cxl/core/region.c               |   24 +++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index fff2581b8033..e859f466a6b5 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -552,3 +552,59 @@ Description:
 		attribute is only visible for devices supporting the
 		capability. The retrieved errors are logged as kernel
 		events when cxl_poison event tracing is enabled.
+
+
+What:		/sys/bus/cxl/devices/regionZ/read_bandwidth
+Date:		Apr, 2023
+KernelVersion:	v6.8
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) The aggregated read bandwidth of the region. The number is
+		the accumulated read bandwidth of all CXL memory devices that
+		contributes to the region in MB/s. Should be equivalent to
+		attributes in /sys/devices/system/node/nodeX/accessY/. See
+		Documentation/ABI/stable/sysfs-devices-node.
+		The host bus latency in the calculation is from proximity
+		domain 0 to the host bus proximity domain.
+
+
+What:		/sys/bus/cxl/devices/regionZ/write_bandwidth
+Date:		Apr, 2023
+KernelVersion:	v6.8
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) The aggregated write bandwidth of the region. The number is
+		the accumulated write bandwidth of all CXL memory devices that
+		contributes to the region in MB/s. Should be equivalent to
+		attributes in /sys/devices/system/node/nodeX/accessY/. See
+		Documentation/ABI/stable/sysfs-devices-node.
+		The host bus latency in the calculation is from proximity
+		domain 0 to the host bus proximity domain.
+
+
+What:		/sys/bus/cxl/devices/regionZ/read_latency
+Date:		Apr, 2023
+KernelVersion:	v6.8
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) The read latency of the region. The number is
+		the worst read latency of all CXL memory devices that
+		contributes to the region in nanoseconds. Should be
+		equivalent to attributes in /sys/devices/system/node/nodeX/accessY/.
+		See Documentation/ABI/stable/sysfs-devices-node.
+		The host bus latency in the calculation is from proximity
+		domain 0 to the host bus proximity domain.
+
+
+What:		/sys/bus/cxl/devices/regionZ/write_latency
+Date:		Apr, 2023
+KernelVersion:	v6.8
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) The write latency of the region. The number is
+		the worst write latency of all CXL memory devices that
+		contributes to the region in nanoseconds. Should be
+		equivalent to attributes in /sys/devices/system/node/nodeX/accessY/.
+		See Documentation/ABI/stable/sysfs-devices-node.
+		The host bus latency in the calculation is from proximity
+		domain 0 to the host bus proximity domain.
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index be7383e74ef5..d97fa5f32e86 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -645,6 +645,26 @@ static ssize_t size_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(size);
 
+#define ACCESS_ATTR(attrib)					\
+static ssize_t attrib##_show(struct device *dev,		\
+			   struct device_attribute *attr,	\
+			   char *buf)				\
+{								\
+	struct cxl_region *cxlr = to_cxl_region(dev);		\
+								\
+	if (cxlr->coord.write_bandwidth == 0)			\
+		return 0;					\
+								\
+	return sysfs_emit(buf, "%u\n",				\
+			  cxlr->coord.attrib);			\
+}								\
+static DEVICE_ATTR_RO(attrib)
+
+ACCESS_ATTR(read_bandwidth);
+ACCESS_ATTR(read_latency);
+ACCESS_ATTR(write_bandwidth);
+ACCESS_ATTR(write_latency);
+
 static struct attribute *cxl_region_attrs[] = {
 	&dev_attr_uuid.attr,
 	&dev_attr_commit.attr,
@@ -653,6 +673,10 @@ static struct attribute *cxl_region_attrs[] = {
 	&dev_attr_resource.attr,
 	&dev_attr_size.attr,
 	&dev_attr_mode.attr,
+	&dev_attr_read_bandwidth.attr,
+	&dev_attr_write_bandwidth.attr,
+	&dev_attr_read_latency.attr,
+	&dev_attr_write_latency.attr,
 	NULL,
 };
 


