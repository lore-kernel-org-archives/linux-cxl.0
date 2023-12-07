Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O0vC5p2z"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026B21712
	for <linux-cxl@vger.kernel.org>; Thu,  7 Dec 2023 15:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701991920; x=1733527920;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WRd6C+Vxp2KoTZfERbc11RFvKr3AbYsWGXaMkH1baIY=;
  b=O0vC5p2zeTXyixmZlyZkmOdnptKdmQZNkYhJk/DYnzieqK0svpYDKeWz
   9TKD0wIn8eHEth3Ry8lWqd1Y1mbbPlO7TwwHcmnrrkeB6PQVeIA9EPsdc
   PeRj8mzV9f/EvDty0bHruN+6qGcKnvl0x0vBC+SFQ54ZKeZHu/fxBTJtK
   fCp399x9H4TQNWMBHzNzCKKYD+EIW44EMSVSygtnkX7k/A27+0NTL0Tr/
   soB6iaNUFYBk3LIGPk70JPUeBcQrL9Nem9sOLBpUz3G/NsGylf78XjXF2
   uAaFl5AqMsgPAjl4kw1LjH8wxtuC0hLhYzPIjWDoOA5W21L1kaZB5o5Ir
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1431995"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="1431995"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 15:31:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="895326293"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="895326293"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.213.168.225])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 15:31:56 -0800
Subject: [PATCH 2/3] cxl/region: Add sysfs attribute for locality attributes
 of CXL regions
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, vishal.l.verma@intel.com,
 alison.schofield@intel.com, jonathan.cameron@huawei.com, dave@stgolabs.net
Date: Thu, 07 Dec 2023 16:31:56 -0700
Message-ID: <170199191618.3543815.17768111410214136858.stgit@djiang5-mobl3>
In-Reply-To: <170199184936.3543815.17537965163543815359.stgit@djiang5-mobl3>
References: <170199184936.3543815.17537965163543815359.stgit@djiang5-mobl3>
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
contributes to the CXL region. The latency is the worst latency of the
device amongst all the devices that contributes to the CXL region.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 Documentation/ABI/testing/sysfs-bus-cxl |   40 +++++++++++++++++++++++++++++++
 drivers/cxl/core/region.c               |   24 +++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index fff2581b8033..e96f172eb6a6 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -552,3 +552,43 @@ Description:
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
+		contributes to the region.
+
+
+What:		/sys/bus/cxl/devices/regionZ/write_bandwidth
+Date:		Apr, 2023
+KernelVersion:	v6.8
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) The aggregated write bandwidth of the region. The number is
+		the accumulated write bandwidth of all CXL memory devices that
+		contributes to the region.
+
+
+What:		/sys/bus/cxl/devices/regionZ/read_latency
+Date:		Apr, 2023
+KernelVersion:	v6.8
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) The read latency of the region. The number is
+		the worst read latency of all CXL memory devices that
+		contributes to the region.
+
+
+What:		/sys/bus/cxl/devices/regionZ/write_latency
+Date:		Apr, 2023
+KernelVersion:	v6.8
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		(RO) The write latency of the region. The number is
+		the worst write latency of all CXL memory devices that
+		contributes to the region.
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index d879f5702cf2..72c47f624d63 100644
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
+	if (!cxlr->coord)					\
+		return 0;					\
+								\
+	return sysfs_emit(buf, "%u\n",				\
+			  cxlr->coord->attrib);			\
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
 


