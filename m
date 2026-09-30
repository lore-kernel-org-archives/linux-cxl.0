Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D942F4FD29A
	for <linux-cxl@vger.kernel.org>; Wed, 30 Sep 2026 15:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781808; cv=none; b=liZ3JQronIhkMIE0vdpzgiviiPoPYBS/UgVIuYVq4evFaBqWP1VUemcEzQqM3rh7osur+7wYrrMW7+PvjSELlya2VY+FrxnVuttEfRSncbHK+A9XDgETiB8h/ZY/feWY0tZuYan2HOriF3w1jo/GwnC6n/SDWaDBYryMMh2LEZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781808; c=relaxed/simple;
	bh=m7MfjtG85nYkbpvb4mqdxR1rIaMmJLFJDtIdTrs5A1U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NK3oQFeLE7RXdS7jQLmB9jTWV89VNUUShDkDB+l9bKL8gDS/QmvqLzNU5WJi4NB4MEsyPF9mlQuo4D2XRCOe+ZHVbeUlw6v+BvEBiK9A7yyaAtwyL1oJqQbG1ym9e02AlIkOGNuuRUomxM0D+nKuyFBHuq/L3GT/96a4v0O36nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819211F00898;
	Wed, 30 Sep 2026 15:23:17 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	ming.li@zohomail.com,
	icheng@nvidia.com
Subject: [PATCH v3 2/3] cxl/core: Hold the dport host lock across dport lookup and use
Date: Wed, 30 Sep 2026 08:23:10 -0700
Message-ID: <20260930152311.4164036-3-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260930152311.4164036-1-dave.jiang@intel.com>
References: <20260930152311.4164036-1-dave.jiang@intel.com>
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

Fixes: 733b57f262b0 ("cxl/pci: Early setup RCH dport component registers from RCRB")
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Assisted-by: LLM
---
v2:
- Reword the cxl_port_dport_host() comment. (Jonathan)
- Drop the note on stale cxlsd->target[] pointers, fixed by patch 1. (Jonathan)

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
 drivers/cxl/core/core.h    |  6 +-----
 drivers/cxl/core/pci.c     |  8 +++++++-
 drivers/cxl/core/port.c    | 36 ++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/ras_rch.c | 12 +++++++++++-
 drivers/cxl/cxl.h          | 16 ++++++++++++++++
 drivers/cxl/mem.c          | 14 +++++++++-----
 drivers/cxl/pci.c          | 11 ++++++-----
 7 files changed, 86 insertions(+), 17 deletions(-)

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
index 9d807c1a002c..8a236e22bb3f 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -734,10 +734,16 @@ int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev)) {
 		struct cxl_dport *dport;
 		struct cxl_port *port __free(put_cxl_port) =
-			cxl_pci_find_port(pdev, &dport);
+			cxl_pci_find_port(pdev, NULL);
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
index 6ff3353865e3..336d7c0f5d98 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1428,6 +1428,10 @@ static struct cxl_port *__find_cxl_port_by_dport(struct cxl_find_port_ctx *ctx)
  *
  * Return a 'struct cxl_port' with an elevated reference if found. Use
  * __free(put_cxl_port) to release.
+ *
+ * The port reference does not pin @dport, which is a devm allocation of
+ * cxl_port_dport_host(). Pass NULL and use cxl_pci_find_dport() or
+ * cxl_mem_find_dport() under that device's lock instead.
  */
 static struct cxl_port *find_cxl_port_by_dport(struct device *dport_dev,
 					       struct cxl_dport **dport)
@@ -1943,6 +1947,38 @@ struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
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
index e0e01aa5eba6..827a2f64d892 100644
--- a/drivers/cxl/core/ras_rch.c
+++ b/drivers/cxl/core/ras_rch.c
@@ -118,10 +118,20 @@ void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
 	int severity;
 
 	struct cxl_port *port __free(put_cxl_port) =
-		cxl_pci_find_port(pdev, &dport);
+		cxl_pci_find_port(pdev, NULL);
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
index cab8ce39f465..f08de094f412 100644
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
@@ -747,6 +759,10 @@ DEFINE_FREE(put_cxl_dax_region, struct cxl_dax_region *, if (!IS_ERR_OR_NULL(_T)
 int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd);
 void cxl_bus_rescan(void);
 void cxl_bus_drain(void);
+struct cxl_dport *cxl_pci_find_dport(struct pci_dev *pdev,
+				     struct cxl_port *port);
+struct cxl_dport *cxl_mem_find_dport(struct cxl_memdev *cxlmd,
+				     struct cxl_port *port);
 struct cxl_port *cxl_pci_find_port(struct pci_dev *pdev,
 				   struct cxl_dport **dport);
 struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 798e5c369cfc..91137487ac1f 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -133,7 +133,7 @@ static int cxl_mem_probe(struct device *dev)
 		return rc;
 
 	struct cxl_port *parent_port __free(put_cxl_port) =
-		cxl_mem_find_port(cxlmd, &dport);
+		cxl_mem_find_port(cxlmd, NULL);
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
index c7c91e8dc51d..6e1d7ee94c19 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -706,22 +706,23 @@ static ssize_t rcd_pcie_cap_emit(struct device *dev, u16 offset, char *buf, size
 	struct device *root_dev;
 	struct cxl_dport *dport;
 	struct cxl_port *root __free(put_cxl_port) =
-		cxl_mem_find_port(cxlmd, &dport);
+		cxl_mem_find_port(cxlmd, NULL);
 
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

