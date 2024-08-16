Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20451C3796;
	Fri, 16 Aug 2024 14:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723817311; cv=none; b=ZoX/0GLwY72j2X26ID3jwinWyxcScpxUWdFjMGwkkNz8yt6ZM16aEADYiHHc46KrBFENaqX+sduve33oI4G4ZZ57g2KGjepFc9Q9Q4iNByVOInc1AnrIb8WOtYIHhEdaJ0QQcvRwmHCm6YbWZICoJGpAVQQc8eYqN/q995Brw2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723817311; c=relaxed/simple;
	bh=bUoJ9pa8OJ8hZs/f1jveA0XXJDHOi7Kwe11VYvDkNLY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WFAhiU3fb2gjA/+QN561MnvCLGXU+yc03efekXb3gRId4UkIP64bkg61ICrHnni/6nAY7KM5HBkWxx92lLNO+bvuXGgpwqljwXY6FZ6x/KKEgJdc44s4fjfcECMrTitl5bjTEJgZYJGSjotU6hjgYgh0B8ycqupVvw9Mem9jTAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hrx2u2SY; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hrx2u2SY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723817310; x=1755353310;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=bUoJ9pa8OJ8hZs/f1jveA0XXJDHOi7Kwe11VYvDkNLY=;
  b=Hrx2u2SY1Li8byLi8e6Zl9ML6X7fBA8DTlfXaV/Sk7h4Piap5gFUKrTd
   DogWdWWjtt64Bpb7UGjZ/9dLm5gvqCcGEHwBiXHcdQYUQ3O9KWJwPP2i8
   4B4mFrE2j9MNqFs/Kx3f3Ll+RBNLvsgXLyZY/pOKs1FuQxezE64cFSnR7
   dHa267HXAIztcC/ZmURav+jvViH5vGJ7G2aCA7hYZMgppOEoVXNv1ReMb
   O5paAKR3jghh5xPC4B9DgrcGDT4SJYiFBtKKAIdjsnDgie6qXLvEsAxHt
   41KNAhLXuXcjBDTBXbUy3uqdUVRfx4sDD0sLBhgpJy/6PqvUj43/mPeTk
   A==;
X-CSE-ConnectionGUID: E1Ko29mlQyCYe4y4VmmLhQ==
X-CSE-MsgGUID: EgoTHr/VShq4DBBGAv8lwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11166"; a="22085241"
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="22085241"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:08:29 -0700
X-CSE-ConnectionGUID: xoi8OM+mRMiLAWDVH/TlAA==
X-CSE-MsgGUID: 31NgMwp1QI2x5RirxRMlng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,151,1719903600"; 
   d="scan'208";a="64571556"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.125.111.52])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2024 07:08:28 -0700
From: Ira Weiny <ira.weiny@intel.com>
Date: Fri, 16 Aug 2024 09:08:13 -0500
Subject: [PATCH RESEND v2 08/18] cxl/region: Add Dynamic Capacity CXL
 region support
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240816-dcd-type2-upstream-v2-8-b4044aadf2bd@intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723817288; l=10852;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=bUoJ9pa8OJ8hZs/f1jveA0XXJDHOi7Kwe11VYvDkNLY=;
 b=KwuCGu/PlxuEPtlkH0W8K7euvdRez928BJJiptZez1y/adH8Dd1YdqarHabt1ZeI6icAb/Rbz
 NIFjAaTqS78As6WZzZGE+T9trIRc8h8ps/6vYTj3hz6M7vnucKTeeeD
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=

CXL devices optionally support dynamic capacity.  CXL Regions must be
configured correctly to access this capacity.  Similar to ram and pmem
partitions, DC Regions represent different partitions of the DPA space.

Interleaving is deferred due to the complexity of managing extents on
multiple devices at the same time.  However, there is nothing which
directly prevents interleave support at this time.  The check allows
for early rejection.

To maintain backwards compatibility with older software, CXL regions
need a default DAX device to hold the reference for the region until it
is deleted.

Add create_dc_region sysfs entry to create DC regions.  Share the logic
of devm_cxl_add_dax_region() and region_is_system_ram().  Special case
DC capable CXL regions to create a 0 sized seed DAX device until others
can be created on dynamic space later.

Flag dax_regions to indicate 0 capacity available until dax_region
extents are supported by the region.

Co-developed-by: Navneet Singh <navneet.singh@intel.com>
Signed-off-by: Navneet Singh <navneet.singh@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
changes for v2:
[iweiny: flag empty dax regions]
[iweiny: Split out anything not directly related to creating a DC CXL
	 region]
[iweiny: Separate out dev dax stuff]
[iweiny/navneet: create 0 sized DAX device by default]
[iweiny: use new DC region mode]
---
 Documentation/ABI/testing/sysfs-bus-cxl | 20 +++++-----
 drivers/cxl/core/core.h                 |  1 +
 drivers/cxl/core/port.c                 |  1 +
 drivers/cxl/core/region.c               | 71 ++++++++++++++++++++++++++++-----
 drivers/dax/bus.c                       |  8 ++++
 drivers/dax/bus.h                       |  1 +
 drivers/dax/cxl.c                       | 15 ++++++-
 7 files changed, 96 insertions(+), 21 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index aa65dc5b4e13..a0562938ecac 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -351,20 +351,20 @@ Description:
 		interleave_granularity).
 
 
-What:		/sys/bus/cxl/devices/decoderX.Y/create_{pmem,ram}_region
+What:		/sys/bus/cxl/devices/decoderX.Y/create_{pmem,ram,dc}_region
 Date:		May, 2022, January, 2023
-KernelVersion:	v6.0 (pmem), v6.3 (ram)
+KernelVersion:	v6.0 (pmem), v6.3 (ram), v6.6 (dc)
 Contact:	linux-cxl@vger.kernel.org
 Description:
 		(RW) Write a string in the form 'regionZ' to start the process
-		of defining a new persistent, or volatile memory region
-		(interleave-set) within the decode range bounded by root decoder
-		'decoderX.Y'. The value written must match the current value
-		returned from reading this attribute. An atomic compare exchange
-		operation is done on write to assign the requested id to a
-		region and allocate the region-id for the next creation attempt.
-		EBUSY is returned if the region name written does not match the
-		current cached value.
+		of defining a new persistent, volatile, or Dynamic Capacity
+		(DC) memory region (interleave-set) within the decode range
+		bounded by root decoder 'decoderX.Y'. The value written must
+		match the current value returned from reading this attribute.
+		An atomic compare exchange operation is done on write to assign
+		the requested id to a region and allocate the region-id for the
+		next creation attempt.  EBUSY is returned if the region name
+		written does not match the current cached value.
 
 
 What:		/sys/bus/cxl/devices/decoderX.Y/delete_region
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 45e7e044cf4a..cf3cf01cb95d 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -13,6 +13,7 @@ extern struct attribute_group cxl_base_attribute_group;
 #ifdef CONFIG_CXL_REGION
 extern struct device_attribute dev_attr_create_pmem_region;
 extern struct device_attribute dev_attr_create_ram_region;
+extern struct device_attribute dev_attr_create_dc_region;
 extern struct device_attribute dev_attr_delete_region;
 extern struct device_attribute dev_attr_region;
 extern const struct device_type cxl_pmem_region_type;
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index a5db710a63bc..608901bb7d91 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -314,6 +314,7 @@ static struct attribute *cxl_decoder_root_attrs[] = {
 	&dev_attr_target_list.attr,
 	SET_CXL_REGION_ATTR(create_pmem_region)
 	SET_CXL_REGION_ATTR(create_ram_region)
+	SET_CXL_REGION_ATTR(create_dc_region)
 	SET_CXL_REGION_ATTR(delete_region)
 	NULL,
 };
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 69af1354bc5b..fc8dee469244 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2271,6 +2271,7 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
 	switch (mode) {
 	case CXL_REGION_RAM:
 	case CXL_REGION_PMEM:
+	case CXL_REGION_DC:
 		break;
 	default:
 		dev_err(&cxlrd->cxlsd.cxld.dev, "unsupported mode %s\n",
@@ -2383,6 +2384,33 @@ static ssize_t create_ram_region_store(struct device *dev,
 }
 DEVICE_ATTR_RW(create_ram_region);
 
+static ssize_t create_dc_region_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	return __create_region_show(to_cxl_root_decoder(dev), buf);
+}
+
+static ssize_t create_dc_region_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t len)
+{
+	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev);
+	struct cxl_region *cxlr;
+	int rc, id;
+
+	rc = sscanf(buf, "region%d\n", &id);
+	if (rc != 1)
+		return -EINVAL;
+
+	cxlr = __create_region(cxlrd, id, CXL_REGION_DC,
+			       CXL_DECODER_HOSTONLYMEM);
+	if (IS_ERR(cxlr))
+		return PTR_ERR(cxlr);
+
+	return len;
+}
+DEVICE_ATTR_RW(create_dc_region);
+
 static ssize_t region_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
@@ -2834,7 +2862,7 @@ static void cxlr_dax_unregister(void *_cxlr_dax)
 	device_unregister(&cxlr_dax->dev);
 }
 
-static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
+static int __devm_cxl_add_dax_region(struct cxl_region *cxlr)
 {
 	struct cxl_dax_region *cxlr_dax;
 	struct device *dev;
@@ -2863,6 +2891,21 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
 	return rc;
 }
 
+static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
+{
+	return __devm_cxl_add_dax_region(cxlr);
+}
+
+static int devm_cxl_add_dc_dax_region(struct cxl_region *cxlr)
+{
+	if (cxlr->params.interleave_ways != 1) {
+		dev_err(&cxlr->dev, "Interleaving DC not supported\n");
+		return -EINVAL;
+	}
+
+	return __devm_cxl_add_dax_region(cxlr);
+}
+
 static int match_decoder_by_range(struct device *dev, void *data)
 {
 	struct range *r1, *r2 = data;
@@ -3203,6 +3246,19 @@ static int is_system_ram(struct resource *res, void *arg)
 	return 1;
 }
 
+/*
+ * The region can not be manged by CXL if any portion of
+ * it is already online as 'System RAM'
+ */
+static bool region_is_system_ram(struct cxl_region *cxlr,
+				 struct cxl_region_params *p)
+{
+	return (walk_iomem_res_desc(IORES_DESC_NONE,
+				    IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
+				    p->res->start, p->res->end, cxlr,
+				    is_system_ram) > 0);
+}
+
 static int cxl_region_probe(struct device *dev)
 {
 	struct cxl_region *cxlr = to_cxl_region(dev);
@@ -3242,14 +3298,7 @@ static int cxl_region_probe(struct device *dev)
 	case CXL_REGION_PMEM:
 		return devm_cxl_add_pmem_region(cxlr);
 	case CXL_REGION_RAM:
-		/*
-		 * The region can not be manged by CXL if any portion of
-		 * it is already online as 'System RAM'
-		 */
-		if (walk_iomem_res_desc(IORES_DESC_NONE,
-					IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
-					p->res->start, p->res->end, cxlr,
-					is_system_ram) > 0)
+		if (region_is_system_ram(cxlr, p))
 			return 0;
 
 		/*
@@ -3261,6 +3310,10 @@ static int cxl_region_probe(struct device *dev)
 
 		/* HDM-H routes to device-dax */
 		return devm_cxl_add_dax_region(cxlr);
+	case CXL_REGION_DC:
+		if (region_is_system_ram(cxlr, p))
+			return 0;
+		return devm_cxl_add_dc_dax_region(cxlr);
 	default:
 		dev_dbg(&cxlr->dev, "unsupported region mode: %s\n",
 			cxl_region_mode_name(cxlr->mode));
diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 0ee96e6fc426..b76e49813a39 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -169,6 +169,11 @@ static bool is_static(struct dax_region *dax_region)
 	return (dax_region->res.flags & IORESOURCE_DAX_STATIC) != 0;
 }
 
+static bool is_dynamic(struct dax_region *dax_region)
+{
+	return (dax_region->res.flags & IORESOURCE_DAX_DYNAMIC_CAP) != 0;
+}
+
 bool static_dev_dax(struct dev_dax *dev_dax)
 {
 	return is_static(dev_dax->region);
@@ -285,6 +290,9 @@ static unsigned long long dax_region_avail_size(struct dax_region *dax_region)
 
 	device_lock_assert(dax_region->dev);
 
+	if (is_dynamic(dax_region))
+		return 0;
+
 	for_each_dax_region_resource(dax_region, res)
 		size -= resource_size(res);
 	return size;
diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
index 1ccd23360124..74d8fe4a5532 100644
--- a/drivers/dax/bus.h
+++ b/drivers/dax/bus.h
@@ -13,6 +13,7 @@ struct dax_region;
 /* dax bus specific ioresource flags */
 #define IORESOURCE_DAX_STATIC BIT(0)
 #define IORESOURCE_DAX_KMEM BIT(1)
+#define IORESOURCE_DAX_DYNAMIC_CAP BIT(2)
 
 struct dax_region *alloc_dax_region(struct device *parent, int region_id,
 		struct range *range, int target_node, unsigned int align,
diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
index 8bc9d04034d6..147c8c69782b 100644
--- a/drivers/dax/cxl.c
+++ b/drivers/dax/cxl.c
@@ -13,19 +13,30 @@ static int cxl_dax_region_probe(struct device *dev)
 	struct cxl_region *cxlr = cxlr_dax->cxlr;
 	struct dax_region *dax_region;
 	struct dev_dax_data data;
+	resource_size_t dev_size;
+	unsigned long flags;
 
 	if (nid == NUMA_NO_NODE)
 		nid = memory_add_physaddr_to_nid(cxlr_dax->hpa_range.start);
 
+	dev_size = range_len(&cxlr_dax->hpa_range);
+
+	flags = IORESOURCE_DAX_KMEM;
+	if (cxlr->mode == CXL_REGION_DC) {
+		/* Add empty seed dax device */
+		dev_size = 0;
+		flags |= IORESOURCE_DAX_DYNAMIC_CAP;
+	}
+
 	dax_region = alloc_dax_region(dev, cxlr->id, &cxlr_dax->hpa_range, nid,
-				      PMD_SIZE, IORESOURCE_DAX_KMEM);
+				      PMD_SIZE, flags);
 	if (!dax_region)
 		return -ENOMEM;
 
 	data = (struct dev_dax_data) {
 		.dax_region = dax_region,
 		.id = -1,
-		.size = range_len(&cxlr_dax->hpa_range),
+		.size = dev_size,
 	};
 
 	return PTR_ERR_OR_ZERO(devm_create_dev_dax(&data));

-- 
2.45.2

