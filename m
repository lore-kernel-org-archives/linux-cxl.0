Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531172C187
	for <linux-cxl@vger.kernel.org>; Wed,  7 May 2025 00:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746578596; cv=none; b=sVZv99g+LDhqNMwPa9bLMTg2T90Kj5H9MVJNQdaH8mFNTq6l4lxA1uWQlscZNOu6bw4YxYOjfdiVCgDF+Id9UQEp0AdBCh6rJnCRDlmsyGxq1JZW3GBo8VoOepmFKWJ0w5+wX9ls5Tan1ZV4vvgTPz1x0wH0kBcJw0S60nFUFJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746578596; c=relaxed/simple;
	bh=vlxrJD6Cy75okzsfuWoyr+HYpe0F/2MQjhCSKyIiWPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A/nA3js507dyMCrDvUD0tzChxVwyyabc1Q5cdX3vF1SNBA9MDgyOgJZEtgG0W9usoQCSIgQYQbag+W4UDiVuGJLVDXkuOXZnvAPvz3vPIZDat65fkBPEB2JdLM7CrIEjSd37P3MsJYbzjjWFN4F0pW81mXsaJIcuFNsPqZNM2TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EBAEC4CEE4;
	Wed,  7 May 2025 00:43:14 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	rrichter@amd.com,
	ming.li@zohomail.com
Subject: [PATCH v2 02/10] cxl: Saperate out CXL dport->id vs actual dport hardware id
Date: Tue,  6 May 2025 17:43:02 -0700
Message-ID: <20250507004310.3536991-3-dave.jiang@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507004310.3536991-1-dave.jiang@intel.com>
References: <20250507004310.3536991-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation to allow dport to be allocated without being active, make
dport->id to be Linux id that enumerates the dport objects per port.
Keep the hardware id under dport->port_num to maintain compatibility and
introduce a dport->id as the enumeration id.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v2:
- Rename port_id to port_num. (Dan)
- Use a dport allocator to deal with ida allocation. (Dan, Jonathan)
---
 drivers/cxl/core/cdat.c |  2 +-
 drivers/cxl/core/hdm.c  | 18 +++++-----
 drivers/cxl/core/port.c | 73 ++++++++++++++++++++++++++++++-----------
 drivers/cxl/cxl.h       | 12 ++++---
 4 files changed, 71 insertions(+), 34 deletions(-)

diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
index edb4f41eeacc..f637e3631d88 100644
--- a/drivers/cxl/core/cdat.c
+++ b/drivers/cxl/core/cdat.c
@@ -501,7 +501,7 @@ static int cdat_sslbis_handler(union acpi_subtable_headers *header, void *arg,
 
 		xa_for_each(&port->dports, index, dport) {
 			if (dsp_id == ACPI_CDAT_SSLBIS_ANY_PORT ||
-			    dsp_id == dport->port_id) {
+			    dsp_id == dport->port_num) {
 				cxl_access_coordinate_set(dport->coord,
 							  sslbis->data_type,
 							  val);
diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 70cae4ebf8a4..d7ad92e191ba 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -69,7 +69,7 @@ int devm_cxl_add_passthrough_decoder(struct cxl_port *port)
 
 	xa_for_each(&port->dports, index, dport)
 		break;
-	single_port_map[0] = dport->port_id;
+	single_port_map[0] = dport->port_num;
 
 	return add_hdm_decoder(port, &cxlsd->cxld, single_port_map);
 }
@@ -720,21 +720,21 @@ static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
 	struct cxl_dport **t = &cxlsd->target[0];
 	int ways = cxlsd->cxld.interleave_ways;
 
-	*tgt = FIELD_PREP(GENMASK(7, 0), t[0]->port_id);
+	*tgt = FIELD_PREP(GENMASK(7, 0), t[0]->port_num);
 	if (ways > 1)
-		*tgt |= FIELD_PREP(GENMASK(15, 8), t[1]->port_id);
+		*tgt |= FIELD_PREP(GENMASK(15, 8), t[1]->port_num);
 	if (ways > 2)
-		*tgt |= FIELD_PREP(GENMASK(23, 16), t[2]->port_id);
+		*tgt |= FIELD_PREP(GENMASK(23, 16), t[2]->port_num);
 	if (ways > 3)
-		*tgt |= FIELD_PREP(GENMASK(31, 24), t[3]->port_id);
+		*tgt |= FIELD_PREP(GENMASK(31, 24), t[3]->port_num);
 	if (ways > 4)
-		*tgt |= FIELD_PREP(GENMASK_ULL(39, 32), t[4]->port_id);
+		*tgt |= FIELD_PREP(GENMASK_ULL(39, 32), t[4]->port_num);
 	if (ways > 5)
-		*tgt |= FIELD_PREP(GENMASK_ULL(47, 40), t[5]->port_id);
+		*tgt |= FIELD_PREP(GENMASK_ULL(47, 40), t[5]->port_num);
 	if (ways > 6)
-		*tgt |= FIELD_PREP(GENMASK_ULL(55, 48), t[6]->port_id);
+		*tgt |= FIELD_PREP(GENMASK_ULL(55, 48), t[6]->port_num);
 	if (ways > 7)
-		*tgt |= FIELD_PREP(GENMASK_ULL(63, 56), t[7]->port_id);
+		*tgt |= FIELD_PREP(GENMASK_ULL(63, 56), t[7]->port_num);
 }
 
 /*
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 726bd4a7de27..e9c02e4d0d4c 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -159,7 +159,7 @@ static ssize_t emit_target_list(struct cxl_switch_decoder *cxlsd, char *buf)
 
 		if (i + 1 < cxld->interleave_ways)
 			next = cxlsd->target[i + 1];
-		rc = sysfs_emit_at(buf, offset, "%d%s", dport->port_id,
+		rc = sysfs_emit_at(buf, offset, "%d%s", dport->id,
 				   next ? "," : "");
 		if (rc < 0)
 			return rc;
@@ -739,6 +739,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
 		dev->parent = uport_dev;
 
 	ida_init(&port->decoder_ida);
+	ida_init(&port->dport_ida);
 	port->hdm_end = -1;
 	port->commit_end = -1;
 	xa_init(&port->dports);
@@ -1044,14 +1045,14 @@ void put_cxl_root(struct cxl_root *cxl_root)
 }
 EXPORT_SYMBOL_NS_GPL(put_cxl_root, "CXL");
 
-static struct cxl_dport *find_dport(struct cxl_port *port, int id)
+static struct cxl_dport *find_dport(struct cxl_port *port, int port_num)
 {
 	struct cxl_dport *dport;
 	unsigned long index;
 
 	device_lock_assert(&port->dev);
 	xa_for_each(&port->dports, index, dport)
-		if (dport->port_id == id)
+		if (dport->port_num == port_num)
 			return dport;
 	return NULL;
 }
@@ -1062,11 +1063,11 @@ static int add_dport(struct cxl_port *port, struct cxl_dport *dport)
 	int rc;
 
 	device_lock_assert(&port->dev);
-	dup = find_dport(port, dport->port_id);
+	dup = find_dport(port, dport->port_num);
 	if (dup) {
 		dev_err(&port->dev,
-			"unable to add dport%d-%s non-unique port id (%s)\n",
-			dport->port_id, dev_name(dport->dport_dev),
+			"unable to add dport%d-%s non-unique port num (%s)\n",
+			dport->port_num, dev_name(dport->dport_dev),
 			dev_name(dup->dport_dev));
 		return -EBUSY;
 	}
@@ -1114,13 +1115,43 @@ static void cxl_dport_unlink(void *data)
 	struct cxl_port *port = dport->port;
 	char link_name[CXL_TARGET_STRLEN];
 
-	sprintf(link_name, "dport%d", dport->port_id);
+	sprintf(link_name, "dport%d", dport->id);
 	sysfs_remove_link(&port->dev.kobj, link_name);
 }
 
+static void free_dport(void *data)
+{
+	struct cxl_dport *dport = data;
+	struct cxl_port *port = dport->port;
+
+	ida_free(&port->dport_ida, dport->id);
+	kfree(dport);
+}
+
+static struct cxl_dport *cxl_alloc_dport(struct cxl_port *port,
+					 struct device *dport_dev)
+{
+	int id;
+
+	struct cxl_dport *dport __free(kfree) =
+		kzalloc(sizeof(*dport), GFP_KERNEL);
+	if (!dport)
+		return NULL;
+
+	id = ida_alloc(&port->dport_ida, GFP_KERNEL);
+	if (id < 0)
+		return NULL;
+
+	dport->dport_dev = dport_dev;
+	dport->port = port;
+	dport->id = id;
+
+	return no_free_ptr(dport);
+}
+
 static struct cxl_dport *
 __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
-		     int port_id, resource_size_t component_reg_phys,
+		     int port_num, resource_size_t component_reg_phys,
 		     resource_size_t rcrb)
 {
 	char link_name[CXL_TARGET_STRLEN];
@@ -1139,17 +1170,19 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 		return ERR_PTR(-ENXIO);
 	}
 
-	if (snprintf(link_name, CXL_TARGET_STRLEN, "dport%d", port_id) >=
+	dport = cxl_alloc_dport(port, dport_dev);
+	if (!dport)
+		return ERR_PTR(-ENOMEM);
+
+	rc = devm_add_action_or_reset(&port->dev, free_dport, dport);
+	if (rc)
+		return ERR_PTR(rc);
+
+	if (snprintf(link_name, CXL_TARGET_STRLEN, "dport%d", dport->id) >=
 	    CXL_TARGET_STRLEN)
 		return ERR_PTR(-EINVAL);
 
-	dport = devm_kzalloc(host, sizeof(*dport), GFP_KERNEL);
-	if (!dport)
-		return ERR_PTR(-ENOMEM);
-
-	dport->dport_dev = dport_dev;
-	dport->port_id = port_id;
-	dport->port = port;
+	dport->port_num = port_num;
 
 	if (rcrb == CXL_RESOURCE_NONE) {
 		rc = cxl_dport_setup_regs(&port->dev, dport,
@@ -1211,7 +1244,7 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
  * devm_cxl_add_dport - append VH downstream port data to a cxl_port
  * @port: the cxl_port that references this dport
  * @dport_dev: firmware or PCI device representing the dport
- * @port_id: identifier for this dport in a decoder's target list
+ * @port_num: identifier for this dport in a decoder's target list
  * @component_reg_phys: optional location of CXL component registers
  *
  * Note that dports are appended to the devm release action's of the
@@ -1219,12 +1252,12 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
  * switch ports)
  */
 struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
-				     struct device *dport_dev, int port_id,
+				     struct device *dport_dev, int port_num,
 				     resource_size_t component_reg_phys)
 {
 	struct cxl_dport *dport;
 
-	dport = __devm_cxl_add_dport(port, dport_dev, port_id,
+	dport = __devm_cxl_add_dport(port, dport_dev, port_num,
 				     component_reg_phys, CXL_RESOURCE_NONE);
 	if (IS_ERR(dport)) {
 		dev_dbg(dport_dev, "failed to add dport to %s: %ld\n",
@@ -1455,7 +1488,7 @@ static void reap_dports(struct cxl_port *port)
 	xa_for_each(&port->dports, index, dport) {
 		devm_release_action(&port->dev, cxl_dport_unlink, dport);
 		devm_release_action(&port->dev, cxl_dport_remove, dport);
-		devm_kfree(&port->dev, dport);
+		devm_release_action(&port->dev, free_dport, dport);
 	}
 }
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index a9ab46eb0610..f4fe523aaf12 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -583,6 +583,7 @@ struct cxl_dax_region {
  * @regions: cxl_region_ref instances, regions mapped by this port
  * @parent_dport: dport that points to this port in the parent
  * @decoder_ida: allocator for decoder ids
+ * @dport_ida: allocator for dport ids
  * @reg_map: component and ras register mapping parameters
  * @nr_dports: number of entries in @dports
  * @hdm_end: track last allocated HDM decoder instance for allocation ordering
@@ -603,6 +604,7 @@ struct cxl_port {
 	struct xarray regions;
 	struct cxl_dport *parent_dport;
 	struct ida decoder_ida;
+	struct ida dport_ida;
 	struct cxl_register_map reg_map;
 	int nr_dports;
 	int hdm_end;
@@ -655,7 +657,8 @@ struct cxl_rcrb_info {
  * struct cxl_dport - CXL downstream port
  * @dport_dev: PCI bridge or firmware device representing the downstream link
  * @reg_map: component and ras register mapping parameters
- * @port_id: unique hardware identifier for dport in decoder target list
+ * @id: Linux id to enumerate dport instances per port
+ * @port_num: unique hardware identifier for dport in decoder target list
  * @rcrb: Data about the Root Complex Register Block layout
  * @rch: Indicate whether this dport was enumerated in RCH or VH mode
  * @port: reference to cxl_port that contains this downstream port
@@ -667,7 +670,8 @@ struct cxl_rcrb_info {
 struct cxl_dport {
 	struct device *dport_dev;
 	struct cxl_register_map reg_map;
-	int port_id;
+	int id;
+	int port_num;
 	struct cxl_rcrb_info rcrb;
 	bool rch;
 	struct cxl_port *port;
@@ -750,10 +754,10 @@ struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
 bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd);
 
 struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
-				     struct device *dport, int port_id,
+				     struct device *dport, int port_num,
 				     resource_size_t component_reg_phys);
 struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
-					 struct device *dport_dev, int port_id,
+					 struct device *dport_dev, int port_num,
 					 resource_size_t rcrb);
 
 #ifdef CONFIG_PCIEAER_CXL
-- 
2.49.0

