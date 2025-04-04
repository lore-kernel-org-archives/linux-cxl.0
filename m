Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F7F19DF66
	for <linux-cxl@vger.kernel.org>; Fri,  4 Apr 2025 23:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743807654; cv=none; b=cod6DDhn/SOuR17zDE709BFigII7g73hCl4BTuLezGHhEnE9QaM/wrlFpjb5BwjI0NsDfphQvM2wC7sgmbCcxTstT4f3Wl8J05HusnUvpC3eLbtgr5pKlPmWXi52GCHEDgx9BgXtX5YO5NCAtqq1DXVMr30OJoNslCO9FbubeeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743807654; c=relaxed/simple;
	bh=SY/JztmW44NId5HAYhAay2/HTISDrXqEcbzC7TStz9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nb+IDHNRug/zSCM1wTY8T2LOrt21zB8bbJsMQKjsYAo3v6Iw7PhNeumaD7zRmUNidfL6+c0n5jMJYFQSK95eJes9+NmAbhj3bEi0eE+0BAvEP/ItbmbDIB0fH/7w4APiBUCa0hpi3CpeYC2nflcndHKLd3HfDKi33zTvwD2piSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28FF3C4CEDD;
	Fri,  4 Apr 2025 23:00:54 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	rrichter@amd.com,
	ming.li@zohomail.com
Subject: [PATCH 1/4] cxl: Saperate out CXL dport->id vs actual dport hardware id
Date: Fri,  4 Apr 2025 15:57:33 -0700
Message-ID: <20250404230049.3578835-2-dave.jiang@intel.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250404230049.3578835-1-dave.jiang@intel.com>
References: <20250404230049.3578835-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation to allow dport to be allocated without being active, make
dport->id to be Linux id that enumerates the dport objects per port.
Keep the hardware id under dport->port_id to maintain compatibility and
introduce a dport->id as the enumeration id.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/port.c | 40 +++++++++++++++++++++++++++++-----------
 drivers/cxl/cxl.h       |  4 ++++
 2 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 0fd6646c1a2e..e90e55bc11ac 100644
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
+static struct cxl_dport *find_dport(struct cxl_port *port, int port_id)
 {
 	struct cxl_dport *dport;
 	unsigned long index;
 
 	device_lock_assert(&port->dev);
 	xa_for_each(&port->dports, index, dport)
-		if (dport->port_id == id)
+		if (dport->port_id == port_id)
 			return dport;
 	return NULL;
 }
@@ -1105,6 +1106,7 @@ static void cxl_dport_remove(void *data)
 	struct cxl_port *port = dport->port;
 
 	xa_erase(&port->dports, (unsigned long) dport->dport_dev);
+	ida_free(&port->dport_ida, dport->id);
 	put_device(dport->dport_dev);
 }
 
@@ -1114,7 +1116,7 @@ static void cxl_dport_unlink(void *data)
 	struct cxl_port *port = dport->port;
 	char link_name[CXL_TARGET_STRLEN];
 
-	sprintf(link_name, "dport%d", dport->port_id);
+	sprintf(link_name, "dport%d", dport->id);
 	sysfs_remove_link(&port->dev.kobj, link_name);
 }
 
@@ -1126,7 +1128,7 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 	char link_name[CXL_TARGET_STRLEN];
 	struct cxl_dport *dport;
 	struct device *host;
-	int rc;
+	int id, rc;
 
 	if (is_cxl_root(port))
 		host = port->uport_dev;
@@ -1139,29 +1141,41 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 		return ERR_PTR(-ENXIO);
 	}
 
-	if (snprintf(link_name, CXL_TARGET_STRLEN, "dport%d", port_id) >=
-	    CXL_TARGET_STRLEN)
+	id = ida_alloc(&port->dport_ida, GFP_KERNEL);
+	if (id < 0)
+		return ERR_PTR(id);
+
+	if (snprintf(link_name, CXL_TARGET_STRLEN, "dport%d", id) >=
+	    CXL_TARGET_STRLEN) {
+		ida_free(&port->dport_ida, id);
 		return ERR_PTR(-EINVAL);
+	}
 
 	dport = devm_kzalloc(host, sizeof(*dport), GFP_KERNEL);
-	if (!dport)
+	if (!dport) {
+		ida_free(&port->dport_ida, id);
 		return ERR_PTR(-ENOMEM);
+	}
 
 	dport->dport_dev = dport_dev;
 	dport->port_id = port_id;
 	dport->port = port;
+	dport->id = id;
 
 	if (rcrb == CXL_RESOURCE_NONE) {
 		rc = cxl_dport_setup_regs(&port->dev, dport,
 					  component_reg_phys);
-		if (rc)
+		if (rc) {
+			ida_free(&port->dport_ida, id);
 			return ERR_PTR(rc);
+		}
 	} else {
 		dport->rcrb.base = rcrb;
 		component_reg_phys = __rcrb_to_component(dport_dev, &dport->rcrb,
 							 CXL_RCRB_DOWNSTREAM);
 		if (component_reg_phys == CXL_RESOURCE_NONE) {
 			dev_warn(dport_dev, "Invalid Component Registers in RCRB");
+			ida_free(&port->dport_ida, id);
 			return ERR_PTR(-ENXIO);
 		}
 
@@ -1170,8 +1184,10 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 		 * memdev
 		 */
 		rc = cxl_dport_setup_regs(NULL, dport, component_reg_phys);
-		if (rc)
+		if (rc) {
+			ida_free(&port->dport_ida, id);
 			return ERR_PTR(rc);
+		}
 
 		dport->rch = true;
 	}
@@ -1183,8 +1199,10 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 	cond_cxl_root_lock(port);
 	rc = add_dport(port, dport);
 	cond_cxl_root_unlock(port);
-	if (rc)
+	if (rc) {
+		ida_free(&port->dport_ida, id);
 		return ERR_PTR(rc);
+	}
 
 	get_device(dport_dev);
 	rc = devm_add_action_or_reset(host, cxl_dport_remove, dport);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index be8a7dc77719..c942fa40c869 100644
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
@@ -604,6 +605,7 @@ struct cxl_port {
 	struct xarray regions;
 	struct cxl_dport *parent_dport;
 	struct ida decoder_ida;
+	struct ida dport_ida;
 	struct cxl_register_map reg_map;
 	int nr_dports;
 	int hdm_end;
@@ -657,6 +659,7 @@ struct cxl_rcrb_info {
  * struct cxl_dport - CXL downstream port
  * @dport_dev: PCI bridge or firmware device representing the downstream link
  * @reg_map: component and ras register mapping parameters
+ * @id: Linux id to enumerate dport instances per port
  * @port_id: unique hardware identifier for dport in decoder target list
  * @rcrb: Data about the Root Complex Register Block layout
  * @rch: Indicate whether this dport was enumerated in RCH or VH mode
@@ -668,6 +671,7 @@ struct cxl_rcrb_info {
 struct cxl_dport {
 	struct device *dport_dev;
 	struct cxl_register_map reg_map;
+	int id;
 	int port_id;
 	struct cxl_rcrb_info rcrb;
 	bool rch;
-- 
2.49.0

