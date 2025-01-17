Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79571F667A
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jan 2025 06:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737094248; cv=none; b=sHLhRcWUVvMzOJEm4PpOJNptBH92IN3GVh3h6b8dr2mQmpMDp9eaBfGqaPxZHPmozyB82KuU1Wc0EBf8JdNcbfJNWXeGgrhL7WoSwnNrdUVkvv6OUa+9Ll/xH1ULyp2w6SMHe/iwzdMyanFf+ID0/7QxBqA+0dfIbAApCSrAqAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737094248; c=relaxed/simple;
	bh=/+HbGrhAMAtO32DPaRFtvPvHIHOUo3YkkMTmUJQXYPA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cqz885G99XVCv53DuXLMVX+K1a1NcPnST9pwQJldAiSt+Q1ScbD4FtYJuVOpluMWhZ3m+tNxR3KWqI9lpZ7hj/hrfmpiDfnp+P+xVfeBpfP4js9ToftVMaI5dDu6MsGtC1+IGtboBRG6kiDB2PMDrUps+R5lfK2v6T6M6Pge8eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XxUUvKxu; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XxUUvKxu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737094245; x=1768630245;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/+HbGrhAMAtO32DPaRFtvPvHIHOUo3YkkMTmUJQXYPA=;
  b=XxUUvKxu+SdiWnefF46gY3HPOW5OonVxFsxOswDZDuBDLaP4cpTaqZcs
   U0ryhOiEaTnf0Nc7+O0WjmnPkFezB3/7eJ9h3kPL+OiZTSd3UW0W4kN6R
   GrqNOkfZNWxQjMoGPhckowbZXw+lWVBTIA2+dTsfPj3lz9BA+nAGdlC6G
   RRuXYSv/FkCpiIMc2DOS9egyQYGXOEptuv5nBXIKIm8QMtaEYCoxZ5/Dl
   ZefUl65ybjkB7ZmA6zm5ZW69hnxI/ZGy1Wnjv/3HPA1PMQFw4Eptkx9Dx
   B79DuamYm024/wLEWejsc6dgK6CKn+Vf4SnX8JavKPaHcIONkEDH77LYf
   g==;
X-CSE-ConnectionGUID: HZajRvisRh6GPCOTH10MJg==
X-CSE-MsgGUID: Go/OGPgNR5u4L3GdyICrAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11317"; a="41193793"
X-IronPort-AV: E=Sophos;i="6.13,211,1732608000"; 
   d="scan'208";a="41193793"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 22:10:45 -0800
X-CSE-ConnectionGUID: k+b2rn5HRA+dI+qofuIucg==
X-CSE-MsgGUID: VGU10dL6QFG35N19cXiEjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="109789703"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.109.114])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 22:10:45 -0800
Subject: [PATCH 3/4] cxl: Introduce 'struct cxl_dpa_partition' and 'struct
 cxl_range_info'
From: Dan Williams <dan.j.williams@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>,
 Ira Weiny <ira.weiny@intel.com>, dave.jiang@intel.com
Date: Thu, 16 Jan 2025 22:10:44 -0800
Message-ID: <173709424415.753996.10761098712604763500.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <173709422664.753996.4091585899046900035.stgit@dwillia2-xfh.jf.intel.com>
References: <173709422664.753996.4091585899046900035.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The pending efforts to add CXL Accelerator (type-2) device [1], and
Dynamic Capacity (DCD) support [2], tripped on the
no-longer-fit-for-purpose design in the CXL subsystem for tracking
device-physical-address (DPA) metadata. Trip hazards include:

- CXL Memory Devices need to consider a PMEM partition, but Accelerator
  devices with CXL.mem likely do not in the common case.

- CXL Memory Devices enumerate DPA through Memory Device mailbox
  commands like Partition Info, Accelerators devices do not.

- CXL Memory Devices that support DCD support more than 2 partitions.
  Some of the driver algorithms are awkward to expand to > 2 partition
  cases.

- DPA performance data is a general capability that can be shared with
  accelerators, so tracking it in 'struct cxl_memdev_state' is no longer
  suitable.

- 'enum cxl_decoder_mode' is sometimes a partition id and sometimes a
  memory property, it should be phased in favor of a partition id and
  the memory property comes from the partition info.

Towards cleaning up those issues and allowing a smoother landing for the
aforementioned pending efforts, introduce a 'struct cxl_dpa_partition'
array to 'struct cxl_dev_state', and 'struct cxl_range_info' as a shared
way for Memory Devices and Accelerators to initialize the DPA information
in 'struct cxl_dev_state'.

For now, split a new cxl_dpa_setup() from cxl_mem_create_range_info() to
get the new data structure initialized, and cleanup some qos_class init.
Follow on patches will go further to use the new data structure to
cleanup algorithms that are better suited to loop over all possible
partitions.

cxl_dpa_setup() follows the locking expectations of mutating the device
DPA map, and is suitable for Accelerator drivers to use. Accelerators
likely only have one hardcoded 'ram' partition to convey to the
cxl_core.

Link: http://lore.kernel.org/20241230214445.27602-1-alejandro.lucero-palau@amd.com [1]
Link: http://lore.kernel.org/20241210-dcd-type2-upstream-v8-0-812852504400@intel.com [2]
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alejandro Lucero <alucerop@amd.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/cdat.c      |   15 ++-----
 drivers/cxl/core/hdm.c       |   69 ++++++++++++++++++++++++++++++++++
 drivers/cxl/core/mbox.c      |   86 ++++++++++++++++++------------------------
 drivers/cxl/cxlmem.h         |   79 +++++++++++++++++++++++++--------------
 drivers/cxl/pci.c            |    7 +++
 tools/testing/cxl/test/cxl.c |   15 ++-----
 tools/testing/cxl/test/mem.c |    7 +++
 7 files changed, 176 insertions(+), 102 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index b177a488e29b..5400a421ad30 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -261,25 +261,18 @@ static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
 	struct device *dev = cxlds->dev;
 	struct dsmas_entry *dent;
 	unsigned long index;
-	const struct resource *partition[] = {
-		to_ram_res(cxlds),
-		to_pmem_res(cxlds),
-	};
-	struct cxl_dpa_perf *perf[] = {
-		to_ram_perf(cxlds),
-		to_pmem_perf(cxlds),
-	};
 
 	xa_for_each(dsmas_xa, index, dent) {
-		for (int i = 0; i < ARRAY_SIZE(partition); i++) {
-			const struct resource *res = partition[i];
+		for (int i = 0; i < cxlds->nr_partitions; i++) {
+			struct resource *res = &cxlds->part[i].res;
 			struct range range = {
 				.start = res->start,
 				.end = res->end,
 			};
 
 			if (range_contains(&range, &dent->dpa_range))
-				update_perf_entry(dev, dent, perf[i]);
+				update_perf_entry(dev, dent,
+						  &cxlds->part[i].perf);
 			else
 				dev_dbg(dev,
 					"no partition for dsmas dpa: %pra\n",
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 7a85522294ad..7e1559b3ed88 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -342,6 +342,75 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 	return 0;
 }
 
+static int add_dpa_res(struct device *dev, struct resource *parent,
+		       struct resource *res, resource_size_t start,
+		       resource_size_t size, const char *type)
+{
+	int rc;
+
+	*res = (struct resource) {
+		.name = type,
+		.start = start,
+		.end =  start + size - 1,
+		.flags = IORESOURCE_MEM,
+	};
+	if (resource_size(res) == 0) {
+		dev_dbg(dev, "DPA(%s): no capacity\n", res->name);
+		return 0;
+	}
+	rc = request_resource(parent, res);
+	if (rc) {
+		dev_err(dev, "DPA(%s): failed to track %pr (%d)\n", res->name,
+			res, rc);
+		return rc;
+	}
+
+	dev_dbg(dev, "DPA(%s): %pr\n", res->name, res);
+
+	return 0;
+}
+
+/* if this fails the caller must destroy @cxlds, there is no recovery */
+int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info)
+{
+	struct device *dev = cxlds->dev;
+
+	guard(rwsem_write)(&cxl_dpa_rwsem);
+
+	if (cxlds->nr_partitions)
+		return -EBUSY;
+
+	if (!info->size || !info->nr_partitions) {
+		cxlds->dpa_res = DEFINE_RES_MEM(0, 0);
+		cxlds->nr_partitions = 0;
+		return 0;
+	}
+
+	cxlds->dpa_res = DEFINE_RES_MEM(0, info->size);
+
+	for (int i = 0; i < info->nr_partitions; i++) {
+		const char *desc;
+		int rc;
+
+		if (i == CXL_PARTITION_RAM)
+			desc = "ram";
+		else if (i == CXL_PARTITION_PMEM)
+			desc = "pmem";
+		else
+			desc = "";
+		cxlds->part[i].perf.qos_class = CXL_QOS_CLASS_INVALID;
+		rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->part[i].res,
+				 info->range[i].start,
+				 range_len(&info->range[i]), desc);
+		if (rc)
+			return rc;
+		cxlds->nr_partitions++;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cxl_dpa_setup);
+
 int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 				resource_size_t base, resource_size_t len,
 				resource_size_t skipped)
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 3502f1633ad2..7dca5c8c3494 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1241,57 +1241,36 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
 	return rc;
 }
 
-static int add_dpa_res(struct device *dev, struct resource *parent,
-		       struct resource *res, resource_size_t start,
-		       resource_size_t size, const char *type)
-{
-	int rc;
-
-	res->name = type;
-	res->start = start;
-	res->end = start + size - 1;
-	res->flags = IORESOURCE_MEM;
-	if (resource_size(res) == 0) {
-		dev_dbg(dev, "DPA(%s): no capacity\n", res->name);
-		return 0;
-	}
-	rc = request_resource(parent, res);
-	if (rc) {
-		dev_err(dev, "DPA(%s): failed to track %pr (%d)\n", res->name,
-			res, rc);
-		return rc;
-	}
-
-	dev_dbg(dev, "DPA(%s): %pr\n", res->name, res);
-
-	return 0;
-}
-
-int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
+int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info)
 {
 	struct cxl_dev_state *cxlds = &mds->cxlds;
-	struct resource *ram_res = to_ram_res(cxlds);
-	struct resource *pmem_res = to_pmem_res(cxlds);
 	struct device *dev = cxlds->dev;
 	int rc;
 
 	if (!cxlds->media_ready) {
-		cxlds->dpa_res = DEFINE_RES_MEM(0, 0);
-		*ram_res = DEFINE_RES_MEM(0, 0);
-		*pmem_res = DEFINE_RES_MEM(0, 0);
+		info->size = 0;
 		return 0;
 	}
 
-	cxlds->dpa_res = DEFINE_RES_MEM(0, mds->total_bytes);
+	info->size = mds->total_bytes;
 
 	if (mds->partition_align_bytes == 0) {
-		rc = add_dpa_res(dev, &cxlds->dpa_res, ram_res, 0,
-				 mds->volatile_only_bytes, "ram");
-		if (rc)
-			return rc;
-		return add_dpa_res(dev, &cxlds->dpa_res, pmem_res,
-				   mds->volatile_only_bytes,
-				   mds->persistent_only_bytes, "pmem");
+		info->range[CXL_PARTITION_RAM] = (struct range) {
+			.start = 0,
+			.end = mds->volatile_only_bytes - 1,
+		};
+		info->nr_partitions++;
+
+		if (!mds->persistent_only_bytes)
+			return 0;
+
+		info->range[CXL_PARTITION_PMEM] = (struct range) {
+			.start = mds->volatile_only_bytes,
+			.end = mds->volatile_only_bytes +
+			       mds->persistent_only_bytes - 1,
+		};
+		info->nr_partitions++;
+		return 0;
 	}
 
 	rc = cxl_mem_get_partition_info(mds);
@@ -1300,15 +1279,24 @@ int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
 		return rc;
 	}
 
-	rc = add_dpa_res(dev, &cxlds->dpa_res, ram_res, 0,
-			 mds->active_volatile_bytes, "ram");
-	if (rc)
-		return rc;
-	return add_dpa_res(dev, &cxlds->dpa_res, pmem_res,
-			   mds->active_volatile_bytes,
-			   mds->active_persistent_bytes, "pmem");
+	info->range[CXL_PARTITION_RAM] = (struct range) {
+		.start = 0,
+		.end = mds->active_volatile_bytes - 1,
+	};
+	info->nr_partitions++;
+
+	if (!mds->active_persistent_bytes)
+		return 0;
+
+	info->range[CXL_PARTITION_PMEM] = (struct range) {
+		.start = mds->active_volatile_bytes,
+		.end = mds->active_volatile_bytes + mds->active_persistent_bytes - 1,
+	};
+	info->nr_partitions++;
+
+	return 0;
 }
-EXPORT_SYMBOL_NS_GPL(cxl_mem_create_range_info, "CXL");
+EXPORT_SYMBOL_NS_GPL(cxl_mem_dpa_fetch, "CXL");
 
 int cxl_set_timestamp(struct cxl_memdev_state *mds)
 {
@@ -1452,8 +1440,6 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
 	mds->cxlds.reg_map.host = dev;
 	mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
 	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
-	to_ram_perf(&mds->cxlds)->qos_class = CXL_QOS_CLASS_INVALID;
-	to_pmem_perf(&mds->cxlds)->qos_class = CXL_QOS_CLASS_INVALID;
 
 	return mds;
 }
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 78e92e24d7b5..2e728d4b7327 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -97,6 +97,20 @@ int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
 			 resource_size_t base, resource_size_t len,
 			 resource_size_t skipped);
 
+/* Well known, spec defined partition indices */
+enum cxl_partition {
+	CXL_PARTITION_RAM,
+	CXL_PARTITION_PMEM,
+	CXL_PARTITION_MAX,
+};
+
+struct cxl_dpa_info {
+	u64 size;
+	struct range range[CXL_PARTITION_MAX];
+	int nr_partitions;
+};
+int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info);
+
 static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
 					 struct cxl_memdev *cxlmd)
 {
@@ -408,6 +422,16 @@ struct cxl_dpa_perf {
 	int qos_class;
 };
 
+/**
+ * struct cxl_dpa_partition - DPA partition descriptor
+ * @res: shortcut to the partition in the DPA resource tree (cxlds->dpa_res)
+ * @perf: performance attributes of the partition from CDAT
+ */
+struct cxl_dpa_partition {
+	struct resource res;
+	struct cxl_dpa_perf perf;
+};
+
 /**
  * struct cxl_dev_state - The driver device state
  *
@@ -423,8 +447,8 @@ struct cxl_dpa_perf {
  * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
  * @media_ready: Indicate whether the device media is usable
  * @dpa_res: Overall DPA resource tree for the device
- * @_pmem_res: Active Persistent memory capacity configuration
- * @_ram_res: Active Volatile memory capacity configuration
+ * @part: DPA partition array
+ * @nr_partitions: Number of DPA partitions
  * @serial: PCIe Device Serial Number
  * @type: Generic Memory Class device or Vendor Specific Memory device
  * @cxl_mbox: CXL mailbox context
@@ -438,21 +462,39 @@ struct cxl_dev_state {
 	bool rcd;
 	bool media_ready;
 	struct resource dpa_res;
-	struct resource _pmem_res;
-	struct resource _ram_res;
+	struct cxl_dpa_partition part[CXL_PARTITION_MAX];
+	unsigned int nr_partitions;
 	u64 serial;
 	enum cxl_devtype type;
 	struct cxl_mailbox cxl_mbox;
 };
 
-static inline struct resource *to_ram_res(struct cxl_dev_state *cxlds)
+static inline const struct resource *to_ram_res(struct cxl_dev_state *cxlds)
 {
-	return &cxlds->_ram_res;
+	if (cxlds->nr_partitions > 0)
+		return &cxlds->part[CXL_PARTITION_RAM].res;
+	return NULL;
 }
 
-static inline struct resource *to_pmem_res(struct cxl_dev_state *cxlds)
+static inline const struct resource *to_pmem_res(struct cxl_dev_state *cxlds)
 {
-	return &cxlds->_pmem_res;
+	if (cxlds->nr_partitions > 1)
+		return &cxlds->part[CXL_PARTITION_PMEM].res;
+	return NULL;
+}
+
+static inline struct cxl_dpa_perf *to_ram_perf(struct cxl_dev_state *cxlds)
+{
+	if (cxlds->nr_partitions > 0)
+		return &cxlds->part[CXL_PARTITION_RAM].perf;
+	return NULL;
+}
+
+static inline struct cxl_dpa_perf *to_pmem_perf(struct cxl_dev_state *cxlds)
+{
+	if (cxlds->nr_partitions > 1)
+		return &cxlds->part[CXL_PARTITION_PMEM].perf;
+	return NULL;
 }
 
 static inline resource_size_t cxl_ram_size(struct cxl_dev_state *cxlds)
@@ -499,8 +541,6 @@ static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
  * @active_persistent_bytes: sum of hard + soft persistent
  * @next_volatile_bytes: volatile capacity change pending device reset
  * @next_persistent_bytes: persistent capacity change pending device reset
- * @_ram_perf: performance data entry matched to RAM partition
- * @_pmem_perf: performance data entry matched to PMEM partition
  * @event: event log driver state
  * @poison: poison driver state info
  * @security: security driver state info
@@ -524,29 +564,12 @@ struct cxl_memdev_state {
 	u64 next_volatile_bytes;
 	u64 next_persistent_bytes;
 
-	struct cxl_dpa_perf _ram_perf;
-	struct cxl_dpa_perf _pmem_perf;
-
 	struct cxl_event_state event;
 	struct cxl_poison_state poison;
 	struct cxl_security_state security;
 	struct cxl_fw_state fw;
 };
 
-static inline struct cxl_dpa_perf *to_ram_perf(struct cxl_dev_state *cxlds)
-{
-	struct cxl_memdev_state *mds = container_of(cxlds, typeof(*mds), cxlds);
-
-	return &mds->_ram_perf;
-}
-
-static inline struct cxl_dpa_perf *to_pmem_perf(struct cxl_dev_state *cxlds)
-{
-	struct cxl_memdev_state *mds = container_of(cxlds, typeof(*mds), cxlds);
-
-	return &mds->_pmem_perf;
-}
-
 static inline struct cxl_memdev_state *
 to_cxl_memdev_state(struct cxl_dev_state *cxlds)
 {
@@ -860,7 +883,7 @@ int cxl_internal_send_cmd(struct cxl_mailbox *cxl_mbox,
 int cxl_dev_state_identify(struct cxl_memdev_state *mds);
 int cxl_await_media_ready(struct cxl_dev_state *cxlds);
 int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
-int cxl_mem_create_range_info(struct cxl_memdev_state *mds);
+int cxl_mem_dpa_fetch(struct cxl_memdev_state *mds, struct cxl_dpa_info *info);
 struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev);
 void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
 				unsigned long *cmds);
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 0241d1d7133a..47dbfe406236 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -900,6 +900,7 @@ __ATTRIBUTE_GROUPS(cxl_rcd);
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
+	struct cxl_dpa_info range_info = { 0 };
 	struct cxl_memdev_state *mds;
 	struct cxl_dev_state *cxlds;
 	struct cxl_register_map map;
@@ -989,7 +990,11 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
-	rc = cxl_mem_create_range_info(mds);
+	rc = cxl_mem_dpa_fetch(mds, &range_info);
+	if (rc)
+		return rc;
+
+	rc = cxl_dpa_setup(cxlds, &range_info);
 	if (rc)
 		return rc;
 
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 7f1c5061307b..ba3d48b37de3 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -1001,26 +1001,19 @@ static void mock_cxl_endpoint_parse_cdat(struct cxl_port *port)
 	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport_dev);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct access_coordinate ep_c[ACCESS_COORDINATE_MAX];
-	const struct resource *partition[] = {
-		to_ram_res(cxlds),
-		to_pmem_res(cxlds),
-	};
-	struct cxl_dpa_perf *perf[] = {
-		to_ram_perf(cxlds),
-		to_pmem_perf(cxlds),
-	};
 
 	if (!cxl_root)
 		return;
 
-	for (int i = 0; i < ARRAY_SIZE(partition); i++) {
-		const struct resource *res = partition[i];
+	for (int i = 0; i < cxlds->nr_partitions; i++) {
+		struct resource *res = &cxlds->part[i].res;
+		struct cxl_dpa_perf *perf = &cxlds->part[i].perf;
 		struct range range = {
 			.start = res->start,
 			.end = res->end,
 		};
 
-		dpa_perf_setup(port, &range, perf[i]);
+		dpa_perf_setup(port, &range, perf);
 	}
 
 	cxl_memdev_update_perf(cxlmd);
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 347c1e7b37bd..ed365e083c8f 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -1477,6 +1477,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	struct cxl_dev_state *cxlds;
 	struct cxl_mockmem_data *mdata;
 	struct cxl_mailbox *cxl_mbox;
+	struct cxl_dpa_info range_info = { 0 };
 	int rc;
 
 	mdata = devm_kzalloc(dev, sizeof(*mdata), GFP_KERNEL);
@@ -1537,7 +1538,11 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
-	rc = cxl_mem_create_range_info(mds);
+	rc = cxl_mem_dpa_fetch(mds, &range_info);
+	if (rc)
+		return rc;
+
+	rc = cxl_dpa_setup(cxlds, &range_info);
 	if (rc)
 		return rc;
 

