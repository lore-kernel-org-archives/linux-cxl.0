Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E5E1F76CA
	for <linux-cxl@vger.kernel.org>; Tue,  4 Feb 2025 04:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738643077; cv=none; b=TGRmqQefIPpRurY2Rf38uLPSyukiBCkBliOWKdL1hFtqheA95ucKwsu5pn6UNy1OqbySDaLHz8M2fjYJOpYAB1TTVlmXnFkA5W/yogdV6ms5mdm79WcpKjgYpejkNtlyMoE3FpHPMag5PzOfN62JPEju0+kZRKb9R6QGxPUKqxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738643077; c=relaxed/simple;
	bh=pKOPD3ZS5/e+uewG99TJwHUaDxSJi+LjHe5SnUX4qIk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mqAaBB+z6/ds5X/sXVNI+9mge8GSlLzwfCtiWDAGNWjBliKkoWUAxW1LjgrDkSfGMa1bgwdWGFR91reJblVNvkjTMi1lflYE4gEWCS7B9C6q2oZe4vg7V9KrKSUFe9ANDKHD6AQhMDdzcedBKoc0EFRbKFp1B/KE7nuzEcCf3Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y9vsPa0Z; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y9vsPa0Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738643076; x=1770179076;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pKOPD3ZS5/e+uewG99TJwHUaDxSJi+LjHe5SnUX4qIk=;
  b=Y9vsPa0ZpHOLvJlyzBNnCWawWMzKtj1Yopc5nvRqGbaAy6Gy+AETuoP7
   ue4SlJ+Y72Z427npBGQG+47i4aXXVqtNDGzKLYZSDT1+YhKrdD5dn6FaM
   NDLHJ1GhHD5SLegm+bDWwl9LJu9Fxd0ILEqwAu9zBgn5+OqvZgO9jpU8r
   /GmM6b71GqHA9uPwyZ7mpBZ48yKFD8KaS+NekkNm4OFnEZJ6b0cWJZcEN
   IMt601D/nAyubLsUbM9lN14Swnk/oiBdhuGq6cpJfkYdr9cYODsjIW8n6
   EpmXcVtgqjILwJmpQhOD19A8n9AyvgCcmBBBFaZNjtKTWXNPLTs9B/JLB
   w==;
X-CSE-ConnectionGUID: qRXQVcGmRQOwdi7PCx1oMQ==
X-CSE-MsgGUID: ieHJCsLxRZOH9uc/iw8Kwg==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="56586424"
X-IronPort-AV: E=Sophos;i="6.13,257,1732608000"; 
   d="scan'208";a="56586424"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 20:24:36 -0800
X-CSE-ConnectionGUID: /GKH4HfDR0irmk6RcFUcMg==
X-CSE-MsgGUID: dljihc/mQPWPNHVmIjJtfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115645956"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.109.230])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 20:24:36 -0800
Subject: [PATCH v3 6/6] cxl: Cleanup partition size and perf helpers
From: Dan Williams <dan.j.williams@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>,
 Ira Weiny <ira.weiny@intel.com>, dave.jiang@intel.com,
 Jonathan.Cameron@huawei.com
Date: Mon, 03 Feb 2025 20:24:35 -0800
Message-ID: <173864307519.668823.10800104022426067621.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <173864304059.668823.3914867296781664103.stgit@dwillia2-xfh.jf.intel.com>
References: <173864304059.668823.3914867296781664103.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Now that the 'struct cxl_dpa_partition' array contains both size and
performance information, all paths that iterate over that information
can use a loop rather than hard-code 'ram' and 'pmem' lookups.

Remove, or reduce the scope of the temporary helpers that bridged the
pre-'struct cxl_dpa_partition' state of the code to the post-'struct
cxl_dpa_partition' state.

- to_{ram,pmem}_perf(): scope reduced to just sysfs_emit + is_visible()
  helpers

- to_{ram,pmem}_res(): fold into their only users cxl_{ram,pmem}_size()

- cxl_ram_size(): scope reduced to ram_size_show() (Note,
  cxl_pmem_size() also used to gate nvdimm registration)

In short, memdev sysfs ABI already made the promise that 0-sized
partitions will show for memdevs, but that can be avoided for future
partitions by using dynamic sysfs group visibility (new relative to when
the partition ABI first shipped upstream).

Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Alejandro Lucero <alucerop@amd.com>
Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/cdat.c   |   51 ++++++++++++++++++++++-------------------
 drivers/cxl/core/memdev.c |   23 ++++++++++++++++++
 drivers/cxl/cxlmem.h      |   56 ++++++---------------------------------------
 3 files changed, 57 insertions(+), 73 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index f96ae28022b0..bfba7f5019cf 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -306,9 +306,6 @@ static int match_cxlrd_qos_class(struct device *dev, void *data)
 
 static void reset_dpa_perf(struct cxl_dpa_perf *dpa_perf)
 {
-	if (!dpa_perf)
-		return;
-
 	*dpa_perf = (struct cxl_dpa_perf) {
 		.qos_class = CXL_QOS_CLASS_INVALID,
 	};
@@ -317,9 +314,6 @@ static void reset_dpa_perf(struct cxl_dpa_perf *dpa_perf)
 static bool cxl_qos_match(struct cxl_port *root_port,
 			  struct cxl_dpa_perf *dpa_perf)
 {
-	if (!dpa_perf)
-		return false;
-
 	if (dpa_perf->qos_class == CXL_QOS_CLASS_INVALID)
 		return false;
 
@@ -351,37 +345,46 @@ static int match_cxlrd_hb(struct device *dev, void *data)
 	return 0;
 }
 
-static int cxl_qos_class_verify(struct cxl_memdev *cxlmd)
+static void cxl_qos_class_verify(struct cxl_memdev *cxlmd)
 {
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
-	struct cxl_dpa_perf *ram_perf = to_ram_perf(cxlds),
-			    *pmem_perf = to_pmem_perf(cxlds);
 	struct cxl_port *root_port;
-	int rc;
 
 	struct cxl_root *cxl_root __free(put_cxl_root) =
 		find_cxl_root(cxlmd->endpoint);
 
+	/*
+	 * No need to reset_dpa_perf() here as find_cxl_root() is guaranteed to
+	 * succeed when called in the cxl_endpoint_port_probe() path.
+	 */
 	if (!cxl_root)
-		return -ENODEV;
+		return;
 
 	root_port = &cxl_root->port;
 
-	/* Check that the QTG IDs are all sane between end device and root decoders */
-	if (!cxl_qos_match(root_port, ram_perf))
-		reset_dpa_perf(ram_perf);
-	if (!cxl_qos_match(root_port, pmem_perf))
-		reset_dpa_perf(pmem_perf);
-
-	/* Check to make sure that the device's host bridge is under a root decoder */
-	rc = device_for_each_child(&root_port->dev,
-				   cxlmd->endpoint->host_bridge, match_cxlrd_hb);
-	if (!rc) {
-		reset_dpa_perf(ram_perf);
-		reset_dpa_perf(pmem_perf);
+	/*
+	 * Save userspace from needing to check if a qos class has any matches
+	 * by hiding qos class info if the memdev is not mapped by a root
+	 * decoder, or the partition class does not match any root decoder
+	 * class.
+	 */
+	if (!device_for_each_child(&root_port->dev,
+				   cxlmd->endpoint->host_bridge,
+				   match_cxlrd_hb)) {
+		for (int i = 0; i < cxlds->nr_partitions; i++) {
+			struct cxl_dpa_perf *perf = &cxlds->part[i].perf;
+
+			reset_dpa_perf(perf);
+		}
+		return;
 	}
 
-	return rc;
+	for (int i = 0; i < cxlds->nr_partitions; i++) {
+		struct cxl_dpa_perf *perf = &cxlds->part[i].perf;
+
+		if (!cxl_qos_match(root_port, perf))
+			reset_dpa_perf(perf);
+	}
 }
 
 static void discard_dsmas(struct xarray *xa)
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 615cbd861f66..63c6c681125d 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -75,6 +75,14 @@ static ssize_t label_storage_size_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(label_storage_size);
 
+static resource_size_t cxl_ram_size(struct cxl_dev_state *cxlds)
+{
+	/* Static RAM is only expected at partition 0. */
+	if (cxlds->part[0].mode != CXL_PARTMODE_RAM)
+		return 0;
+	return resource_size(&cxlds->part[0].res);
+}
+
 static ssize_t ram_size_show(struct device *dev, struct device_attribute *attr,
 			     char *buf)
 {
@@ -399,6 +407,14 @@ static struct attribute *cxl_memdev_attributes[] = {
 	NULL,
 };
 
+static struct cxl_dpa_perf *to_pmem_perf(struct cxl_dev_state *cxlds)
+{
+	for (int i = 0; i < cxlds->nr_partitions; i++)
+		if (cxlds->part[i].mode == CXL_PARTMODE_PMEM)
+			return &cxlds->part[i].perf;
+	return NULL;
+}
+
 static ssize_t pmem_qos_class_show(struct device *dev,
 				   struct device_attribute *attr, char *buf)
 {
@@ -417,6 +433,13 @@ static struct attribute *cxl_memdev_pmem_attributes[] = {
 	NULL,
 };
 
+static struct cxl_dpa_perf *to_ram_perf(struct cxl_dev_state *cxlds)
+{
+	if (cxlds->part[0].mode != CXL_PARTMODE_RAM)
+		return NULL;
+	return &cxlds->part[0].perf;
+}
+
 static ssize_t ram_qos_class_show(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index f218d43dec9f..36a091597066 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -470,58 +470,16 @@ struct cxl_dev_state {
 	struct cxl_mailbox cxl_mbox;
 };
 
-
-/* Static RAM is only expected at partition 0. */
-static inline const struct resource *to_ram_res(struct cxl_dev_state *cxlds)
-{
-	if (cxlds->part[0].mode != CXL_PARTMODE_RAM)
-		return NULL;
-	return &cxlds->part[0].res;
-}
-
-/*
- * Static PMEM may be at partition index 0 when there is no static RAM
- * capacity.
- */
-static inline const struct resource *to_pmem_res(struct cxl_dev_state *cxlds)
-{
-	for (int i = 0; i < cxlds->nr_partitions; i++)
-		if (cxlds->part[i].mode == CXL_PARTMODE_PMEM)
-			return &cxlds->part[i].res;
-	return NULL;
-}
-
-static inline struct cxl_dpa_perf *to_ram_perf(struct cxl_dev_state *cxlds)
-{
-	if (cxlds->part[0].mode != CXL_PARTMODE_RAM)
-		return NULL;
-	return &cxlds->part[0].perf;
-}
-
-static inline struct cxl_dpa_perf *to_pmem_perf(struct cxl_dev_state *cxlds)
+static inline resource_size_t cxl_pmem_size(struct cxl_dev_state *cxlds)
 {
+	/*
+	 * Static PMEM may be at partition index 0 when there is no static RAM
+	 * capacity.
+	 */
 	for (int i = 0; i < cxlds->nr_partitions; i++)
 		if (cxlds->part[i].mode == CXL_PARTMODE_PMEM)
-			return &cxlds->part[i].perf;
-	return NULL;
-}
-
-static inline resource_size_t cxl_ram_size(struct cxl_dev_state *cxlds)
-{
-	const struct resource *res = to_ram_res(cxlds);
-
-	if (!res)
-		return 0;
-	return resource_size(res);
-}
-
-static inline resource_size_t cxl_pmem_size(struct cxl_dev_state *cxlds)
-{
-	const struct resource *res = to_pmem_res(cxlds);
-
-	if (!res)
-		return 0;
-	return resource_size(res);
+			return resource_size(&cxlds->part[i].res);
+	return 0;
 }
 
 static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)

