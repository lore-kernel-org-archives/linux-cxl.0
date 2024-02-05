Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805855B693
	for <linux-cxl@vger.kernel.org>; Mon,  5 Feb 2024 19:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707161546; cv=none; b=Prd9Of/0EnvIxCDfazFGOTSZ9hjGL8futZV70wsv+YFHLAXCJG2nsDL8U3QXDLLDUDyaZL2eoePt03moaDYoK/f7+OTSi4mqVU3K2WdH81gfyyHTydXsfVFwkv+bfdP34Rjgqe6tjzkCEdCQWtvxQg+Rqw5mhjL65yDRWgJleY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707161546; c=relaxed/simple;
	bh=k90h9OdK9rN3ExesD6sZ64ihUih2M1zI8/zjQWLIcf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R3QQTLFUxFL+0iP+ZpBiMXsde3x9gekt5bcynjKpV/7MXQPLCT+cE5+kX42HmGvVDAbSRAo5zz5VMpqbIGTkg8H8rC5xkGeyxYLK59ev0qUuyDCMyMCHkxmk3F6STj8CiW0SK9R5Z06iIITF3bFovx4h2hq6vCN+1/lb3Vbd6qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFEA1C433F1;
	Mon,  5 Feb 2024 19:32:25 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net
Subject: [PATCH v4 1/4] cxl: Change 'struct cxl_memdev_state' *_perf_list to single 'struct cxl_dpa_perf'
Date: Mon,  5 Feb 2024 12:30:31 -0700
Message-ID: <20240205193218.1657243-2-dave.jiang@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205193218.1657243-1-dave.jiang@intel.com>
References: <20240205193218.1657243-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to address the issue with being able to expose qos_class sysfs
attributes under 'ram' and 'pmem' sub-directories, the attributes must
be defined as static attributes rather than under driver->dev_groups.
To avoid implementing locking for accessing the 'struct cxl_dpa_perf`
lists, convert the list to a single 'struct cxl_dpa_perf' entry in
preparation to move the attributes to statically defined.

While theoretically a partition may have multiple qos_class via CDAT, this
has not been encountered with testing on available hardware. The code is
simplified for now to not support the complex case until a use case is
needed to support that.

Link: https://lore.kernel.org/linux-cxl/65b200ba228f_2d43c29468@dwillia2-mobl3.amr.corp.intel.com.notmuch/
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v4:
- Fix resetting of dpa_perf. (Wonjae)
- Change cxl_qos_match() to return bool. (Jonathan)
---
 drivers/cxl/core/cdat.c | 82 ++++++++++++-----------------------------
 drivers/cxl/core/mbox.c |  4 +-
 drivers/cxl/cxlmem.h    | 10 ++---
 drivers/cxl/mem.c       | 28 ++------------
 4 files changed, 34 insertions(+), 90 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index 6fe11546889f..d66acc917dac 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -210,19 +210,12 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
 	return 0;
 }
 
-static void add_perf_entry(struct device *dev, struct dsmas_entry *dent,
-			   struct list_head *list)
+static void update_perf_entry(struct device *dev, struct dsmas_entry *dent,
+			      struct cxl_dpa_perf *dpa_perf)
 {
-	struct cxl_dpa_perf *dpa_perf;
-
-	dpa_perf = kzalloc(sizeof(*dpa_perf), GFP_KERNEL);
-	if (!dpa_perf)
-		return;
-
 	dpa_perf->dpa_range = dent->dpa_range;
 	dpa_perf->coord = dent->coord;
 	dpa_perf->qos_class = dent->qos_class;
-	list_add_tail(&dpa_perf->list, list);
 	dev_dbg(dev,
 		"DSMAS: dpa: %#llx qos: %d read_bw: %d write_bw %d read_lat: %d write_lat: %d\n",
 		dent->dpa_range.start, dpa_perf->qos_class,
@@ -230,20 +223,6 @@ static void add_perf_entry(struct device *dev, struct dsmas_entry *dent,
 		dent->coord.read_latency, dent->coord.write_latency);
 }
 
-static void free_perf_ents(void *data)
-{
-	struct cxl_memdev_state *mds = data;
-	struct cxl_dpa_perf *dpa_perf, *n;
-	LIST_HEAD(discard);
-
-	list_splice_tail_init(&mds->ram_perf_list, &discard);
-	list_splice_tail_init(&mds->pmem_perf_list, &discard);
-	list_for_each_entry_safe(dpa_perf, n, &discard, list) {
-		list_del(&dpa_perf->list);
-		kfree(dpa_perf);
-	}
-}
-
 static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
 				     struct xarray *dsmas_xa)
 {
@@ -263,16 +242,14 @@ static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
 	xa_for_each(dsmas_xa, index, dent) {
 		if (resource_size(&cxlds->ram_res) &&
 		    range_contains(&ram_range, &dent->dpa_range))
-			add_perf_entry(dev, dent, &mds->ram_perf_list);
+			update_perf_entry(dev, dent, &mds->ram_perf);
 		else if (resource_size(&cxlds->pmem_res) &&
 			 range_contains(&pmem_range, &dent->dpa_range))
-			add_perf_entry(dev, dent, &mds->pmem_perf_list);
+			update_perf_entry(dev, dent, &mds->pmem_perf);
 		else
 			dev_dbg(dev, "no partition for dsmas dpa: %#llx\n",
 				dent->dpa_range.start);
 	}
-
-	devm_add_action_or_reset(&cxlds->cxlmd->dev, free_perf_ents, mds);
 }
 
 static int match_cxlrd_qos_class(struct device *dev, void *data)
@@ -293,24 +270,24 @@ static int match_cxlrd_qos_class(struct device *dev, void *data)
 	return 0;
 }
 
-static void cxl_qos_match(struct cxl_port *root_port,
-			  struct list_head *work_list,
-			  struct list_head *discard_list)
+static void reset_dpa_perf(struct cxl_dpa_perf *dpa_perf)
 {
-	struct cxl_dpa_perf *dpa_perf, *n;
+	*dpa_perf = (struct cxl_dpa_perf) {
+		.qos_class = CXL_QOS_CLASS_INVALID,
+	};
+}
 
-	list_for_each_entry_safe(dpa_perf, n, work_list, list) {
-		int rc;
+static bool cxl_qos_match(struct cxl_port *root_port,
+			  struct cxl_dpa_perf *dpa_perf)
+{
+	if (dpa_perf->qos_class == CXL_QOS_CLASS_INVALID)
+		return false;
 
-		if (dpa_perf->qos_class == CXL_QOS_CLASS_INVALID)
-			return;
+	if (!device_for_each_child(&root_port->dev, &dpa_perf->qos_class,
+				   match_cxlrd_qos_class))
+		return false;
 
-		rc = device_for_each_child(&root_port->dev,
-					   (void *)&dpa_perf->qos_class,
-					   match_cxlrd_qos_class);
-		if (!rc)
-			list_move_tail(&dpa_perf->list, discard_list);
-	}
+	return true;
 }
 
 static int match_cxlrd_hb(struct device *dev, void *data)
@@ -334,23 +311,10 @@ static int match_cxlrd_hb(struct device *dev, void *data)
 	return 0;
 }
 
-static void discard_dpa_perf(struct list_head *list)
-{
-	struct cxl_dpa_perf *dpa_perf, *n;
-
-	list_for_each_entry_safe(dpa_perf, n, list, list) {
-		list_del(&dpa_perf->list);
-		kfree(dpa_perf);
-	}
-}
-DEFINE_FREE(dpa_perf, struct list_head *, if (!list_empty(_T)) discard_dpa_perf(_T))
-
 static int cxl_qos_class_verify(struct cxl_memdev *cxlmd)
 {
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
-	LIST_HEAD(__discard);
-	struct list_head *discard __free(dpa_perf) = &__discard;
 	struct cxl_port *root_port;
 	int rc;
 
@@ -363,16 +327,18 @@ static int cxl_qos_class_verify(struct cxl_memdev *cxlmd)
 	root_port = &cxl_root->port;
 
 	/* Check that the QTG IDs are all sane between end device and root decoders */
-	cxl_qos_match(root_port, &mds->ram_perf_list, discard);
-	cxl_qos_match(root_port, &mds->pmem_perf_list, discard);
+	if (!cxl_qos_match(root_port, &mds->ram_perf))
+		reset_dpa_perf(&mds->ram_perf);
+	if (!cxl_qos_match(root_port, &mds->pmem_perf))
+		reset_dpa_perf(&mds->pmem_perf);
 
 	/* Check to make sure that the device's host bridge is under a root decoder */
 	rc = device_for_each_child(&root_port->dev,
 				   (void *)cxlmd->endpoint->host_bridge,
 				   match_cxlrd_hb);
 	if (!rc) {
-		list_splice_tail_init(&mds->ram_perf_list, discard);
-		list_splice_tail_init(&mds->pmem_perf_list, discard);
+		reset_dpa_perf(&mds->ram_perf);
+		reset_dpa_perf(&mds->pmem_perf);
 	}
 
 	return rc;
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 27166a411705..9adda4795eb7 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1391,8 +1391,8 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
 	mds->cxlds.reg_map.host = dev;
 	mds->cxlds.reg_map.resource = CXL_RESOURCE_NONE;
 	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
-	INIT_LIST_HEAD(&mds->ram_perf_list);
-	INIT_LIST_HEAD(&mds->pmem_perf_list);
+	mds->ram_perf.qos_class = CXL_QOS_CLASS_INVALID;
+	mds->pmem_perf.qos_class = CXL_QOS_CLASS_INVALID;
 
 	return mds;
 }
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 5303d6942b88..20fb3b35e89e 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -395,13 +395,11 @@ enum cxl_devtype {
 
 /**
  * struct cxl_dpa_perf - DPA performance property entry
- * @list - list entry
  * @dpa_range - range for DPA address
  * @coord - QoS performance data (i.e. latency, bandwidth)
  * @qos_class - QoS Class cookies
  */
 struct cxl_dpa_perf {
-	struct list_head list;
 	struct range dpa_range;
 	struct access_coordinate coord;
 	int qos_class;
@@ -471,8 +469,8 @@ struct cxl_dev_state {
  * @security: security driver state info
  * @fw: firmware upload / activation state
  * @mbox_send: @dev specific transport for transmitting mailbox commands
- * @ram_perf_list: performance data entries matched to RAM
- * @pmem_perf_list: performance data entries matched to PMEM
+ * @ram_perf: performance data entry matched to RAM partition
+ * @pmem_perf: performance data entry matched to PMEM partition
  *
  * See CXL 3.0 8.2.9.8.2 Capacity Configuration and Label Storage for
  * details on capacity parameters.
@@ -494,8 +492,8 @@ struct cxl_memdev_state {
 	u64 next_volatile_bytes;
 	u64 next_persistent_bytes;
 
-	struct list_head ram_perf_list;
-	struct list_head pmem_perf_list;
+	struct cxl_dpa_perf ram_perf;
+	struct cxl_dpa_perf pmem_perf;
 
 	struct cxl_event_state event;
 	struct cxl_poison_state poison;
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index c5c9d8e0d88d..547f5a145fc5 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -221,18 +221,8 @@ static ssize_t ram_qos_class_show(struct device *dev,
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
-	struct cxl_dpa_perf *dpa_perf;
 
-	if (!dev->driver)
-		return -ENOENT;
-
-	if (list_empty(&mds->ram_perf_list))
-		return -ENOENT;
-
-	dpa_perf = list_first_entry(&mds->ram_perf_list, struct cxl_dpa_perf,
-				    list);
-
-	return sysfs_emit(buf, "%d\n", dpa_perf->qos_class);
+	return sysfs_emit(buf, "%d\n", mds->ram_perf.qos_class);
 }
 
 static struct device_attribute dev_attr_ram_qos_class =
@@ -244,18 +234,8 @@ static ssize_t pmem_qos_class_show(struct device *dev,
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
-	struct cxl_dpa_perf *dpa_perf;
 
-	if (!dev->driver)
-		return -ENOENT;
-
-	if (list_empty(&mds->pmem_perf_list))
-		return -ENOENT;
-
-	dpa_perf = list_first_entry(&mds->pmem_perf_list, struct cxl_dpa_perf,
-				    list);
-
-	return sysfs_emit(buf, "%d\n", dpa_perf->qos_class);
+	return sysfs_emit(buf, "%d\n", mds->pmem_perf.qos_class);
 }
 
 static struct device_attribute dev_attr_pmem_qos_class =
@@ -273,11 +253,11 @@ static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
 			return 0;
 
 	if (a == &dev_attr_pmem_qos_class.attr)
-		if (list_empty(&mds->pmem_perf_list))
+		if (mds->pmem_perf.qos_class == CXL_QOS_CLASS_INVALID)
 			return 0;
 
 	if (a == &dev_attr_ram_qos_class.attr)
-		if (list_empty(&mds->ram_perf_list))
+		if (mds->ram_perf.qos_class == CXL_QOS_CLASS_INVALID)
 			return 0;
 
 	return a->mode;
-- 
2.43.0

