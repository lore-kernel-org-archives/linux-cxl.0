Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5FD3C0613
	for <linux-cxl@vger.kernel.org>; Thu,  1 Oct 2026 15:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869671; cv=none; b=MGKJc51xC7imHhXwSTeDSOoV0G0GATp45YPmwDaZE7zlU+aCStjNCnT2RbgbTVLBls2hDl0X/ukuTWqhlvra/bjDARkK5VuohvyX4pZnaOQVvz0vdph4UvRLGOptnZhCE30esxAB9hcKdGiLsPbC6GiI6Mr3LYfHTqgUjJ2L8qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869671; c=relaxed/simple;
	bh=AiTUIO1bqVATPdLDVx7XlcWYvKifNVOiTRQ4j8nYMfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i3poCs1SnKszTx62vkaAQkBqG6wv3U0rIXsoMkfqoWqxlmTbN9KOvkmwVjMkV1hyRAa64d8jUEMb6z5lCycLhebGPqlhzByQyanWd3l7lto0x+LZUyTN/55YMzv1zrupGXH427T6WCZcsLI5S0JR0DDEyayQYytiYwPUtb5vZhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D503B1F00898;
	Thu,  1 Oct 2026 15:47:48 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	ming.li@zohomail.com,
	icheng@nvidia.com
Subject: [PATCH v4 2/3] cxl/core: Hold the dport host lock across dport lookup and use
Date: Thu,  1 Oct 2026 08:47:43 -0700
Message-ID: <20261001154744.1095902-3-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261001154744.1095902-1-dave.jiang@intel.com>
References: <20261001154744.1095902-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Callers of cxl_pci_find_port() and cxl_mem_find_port() can be handed a
'struct cxl_dport' that is already freed, and all four dereference it
without the lock that would prevent that.

A dport is kzalloc()'d into a devres group on its host device, so it dies
when that host unbinds. The host is &port->dev for a switch port and
port->uport_dev for the root port.

Both helpers return the dport through an output parameter. The caller's
port reference pins struct cxl_port, not the dport allocation, and the
lookup itself is a bare xa_load() under no lock.

Add cxl_port_dport_host() to name the device that pins a dport, and
cxl_pci_find_dport() / cxl_mem_find_dport() to look one up with that
device's lock held and asserted. Convert the four callers to use them and
bail if the dport is gone. cxl_port_add_dport() already follows this rule.

cxl_mem_probe() chose its endpoint devm host from dport->rch, which meant
dereferencing the dport before taking any lock. Use cxl_port_dport_host():
rch dports only ever land on the root port, so it selects the same device
without needing the dport.

With every caller converted, the dport output parameter of
cxl_pci_find_port() and cxl_mem_find_port() is unused. Drop it.

Fixes: 733b57f262b0 ("cxl/pci: Early setup RCH dport component registers from RCRB")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Assisted-by: LLM
Reviewed-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
---
v4:
- Drop the now unused dport output parameter. (Sashiko, Alison)

Found by review, not from a failure report.

Untested: two of the four converted sites add a new lock acquisition, and
neither executed under test.

  cxl_pci_setup_regs()        new guard() sits behind is_cxl_restricted(),
                              which needs a PCI_EXP_TYPE_RC_END device
  cxl_handle_rdport_errors()  needs an RCH dport AER error; cxl_test has no
                              injection path

Only cxl_pci_setup_regs() introduces a lock order lockdep has not already
seen: device_lock(&pdev->dev) from probe, then the dport host lock.

cxl_handle_rdport_errors() nests its new host lock inside the
device_lock(&cxlmd->dev) that core/ras.c:274 and :298 hold, but
cxl_mem_probe() takes that same pair in that same order and ran clean under
PROVE_LOCKING, so the edge itself is covered. What is untested there is the
path, not the ordering.

Reaching either needs a cxl-type3 attached directly to a host bridge so
pci_pcie_type() is PCI_EXP_TYPE_RC_END, which run_qemu.sh does not generate.

Tested in QEMU with cxl_test, PROVE_LOCKING and KASAN on, 8 module
load/unload cycles with concurrent sysfs readers. No lockdep splat, no
device_lock_assert() firing, enumeration unchanged (15 memdev, 12 port,
192 decoder before and after).

cxl_mem_find_dport() ran for 15 memdevs on each of 9 loads, covering both
cxl_port_dport_host() branches. The rch branch is covered too: "cxl_mem
mem2: endpoint9 added to root3" shows the new selection picking the same
parent dport->rch did.
---
 drivers/cxl/core/core.h    |  6 +---
 drivers/cxl/core/pci.c     |  8 ++++-
 drivers/cxl/core/port.c    | 62 ++++++++++++++++++++++++++------------
 drivers/cxl/core/ras_rch.c | 12 +++++++-
 drivers/cxl/cxl.h          | 22 +++++++++++---
 drivers/cxl/mem.c          | 14 ++++++---
 drivers/cxl/pci.c          | 11 ++++---
 7 files changed, 95 insertions(+), 40 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 35eaf636adc9..0a39e500029a 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -178,11 +178,7 @@ static inline struct device *port_to_host(struct cxl_port *port)
 
 static inline struct device *dport_to_host(struct cxl_dport *dport)
 {
-	struct cxl_port *port = dport->port;
-
-	if (is_cxl_root(port))
-		return port->uport_dev;
-	return &port->dev;
+	return cxl_port_dport_host(dport->port);
 }
 #ifdef CONFIG_CXL_RAS
 void cxl_ras_init(void);
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 9d807c1a002c..55a571f86d47 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -734,10 +734,16 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev)) {
 		struct cxl_dport *dport;
 		struct cxl_port *port __free(put_cxl_port) =
-			cxl_pci_find_port(pdev, &dport);
+			cxl_pci_find_port(pdev);
 		if (!port)
 			return -EPROBE_DEFER;
 
+		guard(device)(cxl_port_dport_host(port));
+
+		dport = cxl_pci_find_dport(pdev, port);
+		if (!dport)
+			return -EPROBE_DEFER;
+
 		rc = cxl_rcrb_get_comp_regs(pdev, map, dport);
 		if (rc)
 			return rc;
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 6ff3353865e3..4cc29433216d 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1387,13 +1387,11 @@ static int cxl_add_ep(struct cxl_dport *dport, struct device *ep_dev)
 struct cxl_find_port_ctx {
 	const struct device *dport_dev;
 	const struct cxl_port *parent_port;
-	struct cxl_dport **dport;
 };
 
 static int match_port_by_dport(struct device *dev, const void *data)
 {
 	const struct cxl_find_port_ctx *ctx = data;
-	struct cxl_dport *dport;
 	struct cxl_port *port;
 
 	if (!is_cxl_port(dev))
@@ -1402,10 +1400,7 @@ static int match_port_by_dport(struct device *dev, const void *data)
 		return 0;
 
 	port = to_cxl_port(dev);
-	dport = cxl_find_dport_by_dev(port, ctx->dport_dev);
-	if (ctx->dport)
-		*ctx->dport = dport;
-	return dport != NULL;
+	return !!cxl_find_dport_by_dev(port, ctx->dport_dev);
 }
 
 static struct cxl_port *__find_cxl_port_by_dport(struct cxl_find_port_ctx *ctx)
@@ -1424,22 +1419,21 @@ static struct cxl_port *__find_cxl_port_by_dport(struct cxl_find_port_ctx *ctx)
 /**
  * find_cxl_port_by_dport - find a cxl_port by one of its targets
  * @dport_dev: device representing the dport target
- * @dport: optional output of the 'struct cxl_dport' companion of the @dport_dev
  *
  * Return a 'struct cxl_port' with an elevated reference if found. Use
  * __free(put_cxl_port) to release.
+ *
+ * The port reference does not pin the dport, which is a devm allocation of
+ * cxl_port_dport_host(). Use cxl_pci_find_dport() or cxl_mem_find_dport()
+ * under that device's lock to get it.
  */
-static struct cxl_port *find_cxl_port_by_dport(struct device *dport_dev,
-					       struct cxl_dport **dport)
+static struct cxl_port *find_cxl_port_by_dport(struct device *dport_dev)
 {
 	struct cxl_find_port_ctx ctx = {
 		.dport_dev = dport_dev,
-		.dport = dport,
 	};
-	struct cxl_port *port;
 
-	port = __find_cxl_port_by_dport(&ctx);
-	return port;
+	return __find_cxl_port_by_dport(&ctx);
 }
 
 /*
@@ -1929,20 +1923,50 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_enumerate_ports, "CXL");
 
-struct cxl_port *cxl_pci_find_port(struct pci_dev *pdev,
-				   struct cxl_dport **dport)
+struct cxl_port *cxl_pci_find_port(struct pci_dev *pdev)
 {
-	return find_cxl_port_by_dport(pdev->dev.parent, dport);
+	return find_cxl_port_by_dport(pdev->dev.parent);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_pci_find_port, "CXL");
 
-struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
-				   struct cxl_dport **dport)
+struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd)
 {
-	return find_cxl_port_by_dport(grandparent(&cxlmd->dev), dport);
+	return find_cxl_port_by_dport(grandparent(&cxlmd->dev));
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mem_find_port, "CXL");
 
+/**
+ * cxl_pci_find_dport - find the dport of @port that @pdev is below
+ * @pdev: PCI device below the dport
+ * @port: port to search, typically from cxl_pci_find_port()
+ *
+ * Context: Caller must hold the cxl_port_dport_host() lock of @port, and
+ *	    must not use the result after dropping it.
+ */
+struct cxl_dport *cxl_pci_find_dport(struct pci_dev *pdev,
+				     struct cxl_port *port)
+{
+	device_lock_assert(cxl_port_dport_host(port));
+	return cxl_find_dport_by_dev(port, pdev->dev.parent);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_pci_find_dport, "CXL");
+
+/**
+ * cxl_mem_find_dport - find the dport of @port that @cxlmd is below
+ * @cxlmd: memdev below the dport
+ * @port: port to search, typically from cxl_mem_find_port()
+ *
+ * Context: Caller must hold the cxl_port_dport_host() lock of @port, and
+ *	    must not use the result after dropping it.
+ */
+struct cxl_dport *cxl_mem_find_dport(struct cxl_memdev *cxlmd,
+				     struct cxl_port *port)
+{
+	device_lock_assert(cxl_port_dport_host(port));
+	return cxl_find_dport_by_dev(port, grandparent(&cxlmd->dev));
+}
+EXPORT_SYMBOL_NS_GPL(cxl_mem_find_dport, "CXL");
+
 static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
 				    struct cxl_port *port)
 {
diff --git a/drivers/cxl/core/ras_rch.c b/drivers/cxl/core/ras_rch.c
index e0e01aa5eba6..3c6aae26deed 100644
--- a/drivers/cxl/core/ras_rch.c
+++ b/drivers/cxl/core/ras_rch.c
@@ -118,10 +118,20 @@ void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
 	int severity;
 
 	struct cxl_port *port __free(put_cxl_port) =
-		cxl_pci_find_port(pdev, &dport);
+		cxl_pci_find_port(pdev);
 	if (!port)
 		return;
 
+	/*
+	 * The dport may have been freed since the lookup above, so take the
+	 * lock that pins it and find it again.
+	 */
+	guard(device)(cxl_port_dport_host(port));
+
+	dport = cxl_pci_find_dport(pdev, port);
+	if (!dport)
+		return;
+
 	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
 		return;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index cab8ce39f465..cd636d014872 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -701,6 +701,18 @@ static inline bool is_cxl_root(struct cxl_port *port)
 	return port->uport_dev == port->dev.parent;
 }
 
+/*
+ * Return the owner device of the devm allocations of @port's dports. They
+ * are freed when that device unbinds, so hold device_lock() on the returned
+ * device across any lookup and use of a 'struct cxl_dport'.
+ */
+static inline struct device *cxl_port_dport_host(struct cxl_port *port)
+{
+	if (is_cxl_root(port))
+		return port->uport_dev;
+	return &port->dev;
+}
+
 /* Address translation functions exported to cxl_translate test module only */
 int cxl_validate_translation_params(u8 eiw, u16 eig, int pos);
 u64 cxl_calculate_hpa_offset(u64 dpa_offset, int pos, u8 eiw, u16 eig);
@@ -747,10 +759,12 @@ DEFINE_FREE(put_cxl_dax_region, struct cxl_dax_region *, if (!IS_ERR_OR_NULL(_T)
 int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
 void cxl_bus_rescan(void);
 void cxl_bus_drain(void);
-struct cxl_port *cxl_pci_find_port(struct pci_dev *pdev,
-				   struct cxl_dport **dport);
-struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
-				   struct cxl_dport **dport);
+struct cxl_dport *cxl_pci_find_dport(struct pci_dev *pdev,
+				     struct cxl_port *port);
+struct cxl_dport *cxl_mem_find_dport(struct cxl_memdev *cxlmd,
+				     struct cxl_port *port);
+struct cxl_port *cxl_pci_find_port(struct pci_dev *pdev);
+struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd);
 bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd);
 
 struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 798e5c369cfc..165cb048b177 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -133,7 +133,7 @@ static int cxl_mem_probe(struct device *dev)
 		return rc;
 
 	struct cxl_port *parent_port __free(put_cxl_port) =
-		cxl_mem_find_port(cxlmd, &dport);
+		cxl_mem_find_port(cxlmd);
 	if (!parent_port) {
 		dev_err(dev, "CXL port topology not found\n");
 		return -ENXIO;
@@ -148,10 +148,7 @@ static int cxl_mem_probe(struct device *dev)
 		}
 	}
 
-	if (dport->rch)
-		endpoint_parent = parent_port->uport_dev;
-	else
-		endpoint_parent = &parent_port->dev;
+	endpoint_parent = cxl_port_dport_host(parent_port);
 
 	scoped_guard(device, endpoint_parent) {
 		if (!endpoint_parent->driver) {
@@ -160,6 +157,13 @@ static int cxl_mem_probe(struct device *dev)
 			return -ENXIO;
 		}
 
+		/* @dport is only valid while @endpoint_parent stays bound */
+		dport = cxl_mem_find_dport(cxlmd, parent_port);
+		if (!dport) {
+			dev_err(dev, "CXL topology dport not found\n");
+			return -ENXIO;
+		}
+
 		rc = devm_cxl_add_endpoint(endpoint_parent, cxlmd, dport);
 		if (rc)
 			return rc;
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index c7c91e8dc51d..913c7517420f 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -706,22 +706,23 @@ static ssize_t rcd_pcie_cap_emit(struct device *dev, u16 offset, char *buf, size
 	struct device *root_dev;
 	struct cxl_dport *dport;
 	struct cxl_port *root __free(put_cxl_port) =
-		cxl_mem_find_port(cxlmd, &dport);
+		cxl_mem_find_port(cxlmd);
 
 	if (!root)
 		return -ENXIO;
 
-	root_dev = root->uport_dev;
+	root_dev = cxl_port_dport_host(root);
 	if (!root_dev)
 		return -ENXIO;
 
-	if (!dport->regs.rcd_pcie_cap)
-		return -ENXIO;
-
 	guard(device)(root_dev);
 	if (!root_dev->driver)
 		return -ENXIO;
 
+	dport = cxl_mem_find_dport(cxlmd, root);
+	if (!dport || !dport->regs.rcd_pcie_cap)
+		return -ENXIO;
+
 	switch (width) {
 	case 2:
 		return sysfs_emit(buf, "%#x\n",
-- 
2.54.0

