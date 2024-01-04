Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5142D600
	for <linux-cxl@vger.kernel.org>; Thu,  4 Jan 2024 23:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SLp3Kay0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704412110; x=1735948110;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=R4PMFQKvONeN0b9X7GD6XJOMAlA1pLMhHxptCqmezyQ=;
  b=SLp3Kay0BTjJ9Eg11H1cWqqh24HbjAdblS13tmynCKuYPmxC4L3n4M25
   kCkkGGgQkeYbF1OBoRegUqK0ToDEpT1+N7yb73qQtsMZtOy77Qnb9rqW+
   mayF6DADXmZOHYILhynrNLw5Bt3a30KHC0YgAGl3RkwM26IWWrpu5vnMw
   Q+l60u/qt0s5tJ/9ZMJRtNaDDttDFkbDSD83FxTFCBHbESOxYlv91XO5f
   chmUfSPhTC0KESY3IuBIwk4hh5qw1k7jEWpcPZmQWLVU72eIgZ+C+YEi5
   S43OjleMUv2JYdwboSJ702MHU3cHeWUfk/hxbYXMJlj3pESCqu048iI55
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="382369878"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="382369878"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 15:48:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="871087850"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="871087850"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.121.50])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 15:48:29 -0800
Subject: [PATCH v3 2/3] cxl/region: Add sysfs attribute for locality
 attributes of CXL regions
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Thu, 04 Jan 2024 16:48:28 -0700
Message-ID: <170441210897.3574076.3084661576808646327.stgit@djiang5-mobl3>
In-Reply-To: <170441200977.3574076.13110207881243626581.stgit@djiang5-mobl3>
References: <170441200977.3574076.13110207881243626581.stgit@djiang5-mobl3>
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
v3:
- Make attribs not visible if no data (Jonathan)
- Check against coord.attrib (Jonathan)
- Fix documentation verbiage (Jonathan)
---
 Documentation/ABI/testing/sysfs-bus-cxl |   60 +++++++++++++++++++++++++++++++
 drivers/cxl/core/region.c               |   40 +++++++++++++++++++++
 2 files changed, 100 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index fff2581b8033..86d3dbe12129 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -552,3 +552,63 @@ Description:
 		attribute is only visible for devices supporting the
 		capability. The retrieved errors are logged as kernel
 		events when cxl_poison event tracing is enabled.
+
+
+What:		/sys/bus/cxl/devices/regionZ/read_bandwidth
+Date:		Jan, 2024
+KernelVersion:	v6.9
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) The aggregated read bandwidth of the region. The number is
+		the accumulated read bandwidth of all CXL memory devices that
+		contributes to the region in MB/s. Should be equivalent to
+		attributes in
+		/sys/devices/system/node/nodeX/accessY/initiators/read_bandwidth.
+		See Documentation/ABI/stable/sysfs-devices-node. The generic
+		target bandwidth that is part of the whole path calculation is
+		the best performance latency provided by the HMAT SSLBIS table.
+
+
+What:		/sys/bus/cxl/devices/regionZ/write_bandwidth
+Date:		Jan, 2024
+KernelVersion:	v6.9
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) The aggregated write bandwidth of the region. The number is
+		the accumulated write bandwidth of all CXL memory devices that
+		contributes to the region in MB/s. Should be equivalent to
+		attributes in
+		/sys/devices/system/node/nodeX/accessY/initiators/write_bandwidth.
+		See Documentation/ABI/stable/sysfs-devices-node. The generic
+		target bandwidth that is part of the whole path calculation is
+		the best performance latency provided by the HMAT SSLBIS table.
+
+
+What:		/sys/bus/cxl/devices/regionZ/read_latency
+Date:		Jan, 2024
+KernelVersion:	v6.9
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) The read latency of the region. The number is
+		the worst read latency of all CXL memory devices that
+		contributes to the region in nanoseconds. Should be
+		equivalent to attributes in
+		/sys/devices/system/node/nodeX/accessY/initiators/read_latency.
+		See Documentation/ABI/stable/sysfs-devices-node. The generic
+		target latency that is part of the whole path calculation is
+		the best performance latency provided by the HMAT SSLBIS table.
+
+
+What:		/sys/bus/cxl/devices/regionZ/write_latency
+Date:		Jan, 2024
+KernelVersion:	v6.9
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) The write latency of the region. The number is
+		the worst write latency of all CXL memory devices that
+		contributes to the region in nanoseconds. Should be
+		equivalent to attributes in
+		/sys/devices/system/node/nodeX/accessY/initiators/write_latency.
+		See Documentation/ABI/stable/sysfs-devices-node. The generic
+		target latency that is part of the whole path calculation is
+		the best performance latency provided by the HMAT SSLBIS table.
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 7f19b533c5ae..d28d24524d41 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -343,6 +343,25 @@ static ssize_t commit_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(commit);
 
+#define ACCESS_ATTR(attrib)					\
+static ssize_t attrib##_show(struct device *dev,		\
+			   struct device_attribute *attr,	\
+			   char *buf)				\
+{								\
+	struct cxl_region *cxlr = to_cxl_region(dev);		\
+								\
+	if (cxlr->coord.attrib == 0)				\
+		return -ENOENT;				\
+								\
+	return sysfs_emit(buf, "%u\n", cxlr->coord.attrib);	\
+}								\
+static DEVICE_ATTR_RO(attrib)
+
+ACCESS_ATTR(read_bandwidth);
+ACCESS_ATTR(read_latency);
+ACCESS_ATTR(write_bandwidth);
+ACCESS_ATTR(write_latency);
+
 static umode_t cxl_region_visible(struct kobject *kobj, struct attribute *a,
 				  int n)
 {
@@ -355,6 +374,23 @@ static umode_t cxl_region_visible(struct kobject *kobj, struct attribute *a,
 	 */
 	if (a == &dev_attr_uuid.attr && cxlr->mode != CXL_DECODER_PMEM)
 		return 0444;
+
+	if (a == &dev_attr_read_latency.attr &&
+	    cxlr->coord.read_latency == 0)
+		return 0;
+
+	if (a == &dev_attr_write_latency.attr &&
+	    cxlr->coord.write_latency == 0)
+		return 0;
+
+	if (a == &dev_attr_read_bandwidth.attr &&
+	    cxlr->coord.read_bandwidth == 0)
+		return 0;
+
+	if (a == &dev_attr_write_bandwidth.attr &&
+	    cxlr->coord.write_bandwidth == 0)
+		return 0;
+
 	return a->mode;
 }
 
@@ -654,6 +690,10 @@ static struct attribute *cxl_region_attrs[] = {
 	&dev_attr_resource.attr,
 	&dev_attr_size.attr,
 	&dev_attr_mode.attr,
+	&dev_attr_read_bandwidth.attr,
+	&dev_attr_write_bandwidth.attr,
+	&dev_attr_read_latency.attr,
+	&dev_attr_write_latency.attr,
 	NULL,
 };
 


