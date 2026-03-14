Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E6814D719
	for <linux-cxl@vger.kernel.org>; Sat, 14 Mar 2026 06:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773469200; cv=none; b=olBF8tncugGTxAYFIesyJwcRe5UqBBejfWKEY419H3TKRXp9/R39q8tJpnDE8na3awkb2hhvQ00xgx1Jeixjiruu3phuiE3K/WqSrvf7FTr+kTg8Mr3uctE++fRz5jRVrR/31Z4vfpbuDqcew2AplzlvIeL4R9QFSTz12ZpVSdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773469200; c=relaxed/simple;
	bh=RbHVZ97Y/qPn2e9g+95trhwutPpiN9PlYfd5XgsuGIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qeKD/6pAxxnIaqFxQe29/9GnGgKOQMfzo+J7m0r7zvvhkqEvaQWHnhAxcGOEL32hR+V2PXreyEwI21OpY0xUYcOQpEK1bKkUYGP6mib74tGo5HSx06qN6d5FsKOI9E/9Ev+aFEIvAGTuHzw1aTsOVg/uyApe7OpY8xj1q9dXRgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LmltgFrX; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LmltgFrX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773469197; x=1805005197;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RbHVZ97Y/qPn2e9g+95trhwutPpiN9PlYfd5XgsuGIU=;
  b=LmltgFrXmDh1vn8ovPaFCziR6fk1V3vcT/KmmeZQEjLp0aEdOJnYjZmf
   A3oIfiej6QUHEAE9hbJAAOVmkwSS6rsFti9NC8ZDxo7r7xm21TMRodlm1
   IOFWjZOnTAOieAbxlSwKsIfcyctLkuDtEZzxzgqT07Dbsll0JeF0N8w3g
   umH/AZFsbBgsx2uCLM/e3CKMMrbkbXF8Ycq668exFlyCeKx0RxnyxqY0w
   f2VrHJXK6IXz6eHHbDWIaxmnZ6M857hWkYAeoFlqJXhb2MLf63iiGYnp/
   bIP5qePsqnt5um09Z+3EQyYY+FKRUIxUgnbEVFXfAsnLOJYQTYLJeQZsj
   g==;
X-CSE-ConnectionGUID: hA+qcHXARGWAOBraHtn4/w==
X-CSE-MsgGUID: pnMG11UpSLOilShr0WkpkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11728"; a="85925191"
X-IronPort-AV: E=Sophos;i="6.23,119,1770624000"; 
   d="scan'208";a="85925191"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 23:19:56 -0700
X-CSE-ConnectionGUID: NeNvabosQjuY8WC4bxJnLg==
X-CSE-MsgGUID: J6oLVgkjTpSAGAOBb64+8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,119,1770624000"; 
   d="scan'208";a="251885861"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.223.6])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2026 23:19:56 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH] tools/testing/cxl: Enable replay of user regions as auto regions
Date: Fri, 13 Mar 2026 23:19:50 -0700
Message-ID: <20260314061952.2221030-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cxl_test module currently hard-codes auto regions in the mock
topology, limiting coverage of the driver's region auto-assembly
logic.

Teach cxl_test to replay previously committed decoder programming
across a cxl_acpi unbind/bind cycle. Decoder programming is recorded
in a registry keyed by a stable port identity and decoder id. The
registry is updated on decoder commit and reset events and consulted
during enumeration to restore previously enabled decoders.

This allows regions created through the user interface to be replayed
during enumeration and treated as auto-discovered regions, enabling
testing of region auto-assembly using configurations created in the
cxl_test topology.

Example workflow:
  # cxl create-region ...
  # echo 1 > /sys/bus/platform/devices/cxl_acpi.0/decoder_reset_preserve_registry
  # echo cxl_acpi.0 > /sys/bus/platform/drivers/cxl_acpi/unbind
  # echo cxl_acpi.0 > /sys/bus/platform/drivers/cxl_acpi/bind
  # echo 0 > /sys/bus/platform/devices/cxl_acpi.0/decoder_reset_preserve_registry

The NDCTL CXL unit test, cxl-region-replay.sh, demonstrates the usage.

Co-developed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Co-developed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 tools/testing/cxl/test/cxl.c | 383 ++++++++++++++++++++++++++++++++++-
 1 file changed, 373 insertions(+), 10 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 81e2aef3627a..cd47fdd7ccb5 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -51,6 +51,31 @@ struct platform_device *cxl_mem_single[NR_MEM_SINGLE];
 static struct platform_device *cxl_rch[NR_CXL_RCH];
 static struct platform_device *cxl_rcd[NR_CXL_RCH];
 
+/*
+ * Decoder registry
+ *
+ * Record decoder programming so that the topology can be reconstructed
+ * after cxl_acpi unbind/bind. This allows a user-created region config
+ * to be replayed as if firmware had provided the region at enumeration
+ * time.
+ *
+ * Entries are keyed by a stable port identity (port->uport_dev) combined
+ * with the decoder id. Decoder state is saved at initialization and
+ * updated on commit and reset.
+ *
+ * On re-enumeration mock_init_hdm_decoder() consults this registry to
+ * restore enabled decoders. Disabled decoders are reinitialized to a
+ * clean default state rather than replaying stale programming.
+ */
+static DEFINE_XARRAY(decoder_registry);
+
+/*
+ * When set, decoder reset will not update the registry. This allows
+ * region destroy operations to reset live decoders without erasing
+ * the saved programming needed for replay after re-enumeration.
+ */
+static bool decoder_reset_preserve_registry;
+
 static inline bool is_multi_bridge(struct device *dev)
 {
 	int i;
@@ -704,6 +729,194 @@ static int map_targets(struct device *dev, void *data)
 	return 0;
 }
 
+/*
+ * Build a stable registry key from the decoder's upstream port identity
+ * and decoder id.
+ *
+ * Decoder objects and cxl_port objects are reallocated on each enumeration,
+ * so their addresses cannot be used directly as replay keys. However,
+ * port->uport_dev is stable for a given topology across cxl_acpi unbind/bind
+ * in cxl_test, so use that as the port identity and pack the local decoder
+ * id into the low bits.
+ *
+ * The key is formed as:
+ *     ((unsigned long)port->uport_dev << 4) | cxld->id
+ *
+ * The low bits hold the decoder id (which must fit in 4 bits) while
+ * the remaining bits identify the upstream port. This key is only used
+ * within cxl_test to locate saved decoder state during replay.
+ */
+static unsigned long cxld_registry_index(struct cxl_decoder *cxld)
+{
+	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
+
+	dev_WARN_ONCE(&port->dev, cxld->id >= 16,
+		      "decoder id:%d out of range\n", cxld->id);
+	return (((unsigned long)port->uport_dev) << 4) | cxld->id;
+}
+
+struct cxl_test_decoder {
+	union {
+		struct cxl_switch_decoder cxlsd;
+		struct cxl_endpoint_decoder cxled;
+	};
+	struct range dpa_range;
+};
+
+static struct cxl_test_decoder *cxld_registry_find(struct cxl_decoder *cxld)
+{
+	return xa_load(&decoder_registry, cxld_registry_index(cxld));
+}
+
+#define dbg_cxld(port, msg, cxld)                                                       \
+	do {                                                                            \
+		struct cxl_decoder *___d = (cxld);                                      \
+		dev_dbg((port)->uport_dev,                                              \
+			"decoder%d: %s range: %#llx-%#llx iw: %d ig: %d flags: %#lx\n", \
+			___d->id, msg, ___d->hpa_range.start,                           \
+			___d->hpa_range.end + 1, ___d->interleave_ways,                 \
+			___d->interleave_granularity, ___d->flags);                     \
+	} while (0)
+
+static int mock_decoder_commit(struct cxl_decoder *cxld);
+static void mock_decoder_reset(struct cxl_decoder *cxld);
+static void init_disabled_mock_decoder(struct cxl_decoder *cxld);
+
+static void cxld_copy(struct cxl_decoder *a, struct cxl_decoder *b)
+{
+	a->id = b->id;
+	a->hpa_range = b->hpa_range;
+	a->interleave_ways = b->interleave_ways;
+	a->interleave_granularity = b->interleave_granularity;
+	a->target_type = b->target_type;
+	a->flags = b->flags;
+	a->commit = mock_decoder_commit;
+	a->reset = mock_decoder_reset;
+}
+
+/*
+ * Restore decoder programming saved in the registry.
+ *
+ * Only decoders that were saved enabled are restored. Disabled decoders
+ * are left in their default inactive state so that stale programming is
+ * not resurrected after topology replay.
+ *
+ * For endpoint decoders this also restores the DPA reservation needed
+ * to reconstruct committed mappings.
+ */
+static int cxld_registry_restore(struct cxl_decoder *cxld,
+				 struct cxl_test_decoder *td)
+{
+	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
+	int rc;
+
+	if (is_switch_decoder(&cxld->dev)) {
+		struct cxl_switch_decoder *cxlsd =
+			to_cxl_switch_decoder(&cxld->dev);
+
+		if (!(td->cxlsd.cxld.flags & CXL_DECODER_F_ENABLE))
+			return 0;
+
+		dbg_cxld(port, "restore", &td->cxlsd.cxld);
+		cxld_copy(cxld, &td->cxlsd.cxld);
+		WARN_ON(cxlsd->nr_targets != td->cxlsd.nr_targets);
+
+		/* Restore saved target intent; live dport binding happens later */
+		for (int i = 0; i < cxlsd->nr_targets; i++) {
+			cxlsd->target[i] = NULL;
+			cxld->target_map[i] = td->cxlsd.cxld.target_map[i];
+		}
+
+		port->commit_end = cxld->id;
+
+	} else {
+		struct cxl_endpoint_decoder *cxled =
+			to_cxl_endpoint_decoder(&cxld->dev);
+
+		if (!(td->cxled.cxld.flags & CXL_DECODER_F_ENABLE))
+			return 0;
+
+		dbg_cxld(port, "restore", &td->cxled.cxld);
+		cxld_copy(cxld, &td->cxled.cxld);
+		cxled->state = td->cxled.state;
+		cxled->skip = td->cxled.skip;
+		if (range_len(&td->dpa_range)) {
+			rc = devm_cxl_dpa_reserve(cxled, td->dpa_range.start,
+						  range_len(&td->dpa_range),
+						  td->cxled.skip);
+			if (rc) {
+				init_disabled_mock_decoder(cxld);
+				return rc;
+			}
+		}
+		port->commit_end = cxld->id;
+	}
+
+	return 0;
+}
+
+static void __cxld_registry_save(struct cxl_test_decoder *td,
+				 struct cxl_decoder *cxld)
+{
+	if (is_switch_decoder(&cxld->dev)) {
+		struct cxl_switch_decoder *cxlsd =
+			to_cxl_switch_decoder(&cxld->dev);
+
+		cxld_copy(&td->cxlsd.cxld, cxld);
+		td->cxlsd.nr_targets = cxlsd->nr_targets;
+
+		/* Save target port_id as a stable identify for the dport */
+		for (int i = 0; i < cxlsd->nr_targets; i++) {
+			struct cxl_dport *dport;
+
+			if (!cxlsd->target[i])
+				continue;
+
+			dport = cxlsd->target[i];
+			td->cxlsd.cxld.target_map[i] = dport->port_id;
+		}
+	} else {
+		struct cxl_endpoint_decoder *cxled =
+			to_cxl_endpoint_decoder(&cxld->dev);
+
+		cxld_copy(&td->cxled.cxld, cxld);
+		td->cxled.state = cxled->state;
+		td->cxled.skip = cxled->skip;
+
+		if (!(cxld->flags & CXL_DECODER_F_ENABLE)) {
+			td->dpa_range.start = 0;
+			td->dpa_range.end = -1;
+		} else if (cxled->dpa_res) {
+			td->dpa_range.start = cxled->dpa_res->start;
+			td->dpa_range.end = cxled->dpa_res->end;
+		} else {
+			td->dpa_range.start = 0;
+			td->dpa_range.end = -1;
+		}
+	}
+}
+
+static void cxld_registry_save(struct cxl_test_decoder *td,
+			       struct cxl_decoder *cxld)
+{
+	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
+
+	dbg_cxld(port, "save", cxld);
+	__cxld_registry_save(td, cxld);
+}
+
+static void cxld_registry_update(struct cxl_decoder *cxld)
+{
+	struct cxl_test_decoder *td = cxld_registry_find(cxld);
+	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
+
+	if (WARN_ON_ONCE(!td))
+		return;
+
+	dbg_cxld(port, "update", cxld);
+	__cxld_registry_save(td, cxld);
+}
+
 static int mock_decoder_commit(struct cxl_decoder *cxld)
 {
 	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
@@ -723,6 +936,13 @@ static int mock_decoder_commit(struct cxl_decoder *cxld)
 
 	port->commit_end++;
 	cxld->flags |= CXL_DECODER_F_ENABLE;
+	if (is_endpoint_decoder(&cxld->dev)) {
+		struct cxl_endpoint_decoder *cxled =
+			to_cxl_endpoint_decoder(&cxld->dev);
+
+		cxled->state = CXL_DECODER_STATE_AUTO;
+	}
+	cxld_registry_update(cxld);
 
 	return 0;
 }
@@ -743,6 +963,65 @@ static void mock_decoder_reset(struct cxl_decoder *cxld)
 			"%s: out of order reset, expected decoder%d.%d\n",
 			dev_name(&cxld->dev), port->id, port->commit_end);
 	cxld->flags &= ~CXL_DECODER_F_ENABLE;
+
+	if (is_endpoint_decoder(&cxld->dev)) {
+		struct cxl_endpoint_decoder *cxled =
+			to_cxl_endpoint_decoder(&cxld->dev);
+
+		cxled->state = CXL_DECODER_STATE_MANUAL;
+		cxled->skip = 0;
+	}
+	if (decoder_reset_preserve_registry)
+		dev_dbg(port->uport_dev, "decoder%d: skip registry update\n",
+			cxld->id);
+	else
+		cxld_registry_update(cxld);
+}
+
+static struct cxl_test_decoder *cxld_registry_new(struct cxl_decoder *cxld)
+{
+	struct cxl_test_decoder *td __free(kfree) =
+		kzalloc(sizeof(*td), GFP_KERNEL);
+	unsigned long key = cxld_registry_index(cxld);
+
+	if (!td)
+		return NULL;
+
+	if (xa_insert(&decoder_registry, key, td, GFP_KERNEL)) {
+		WARN_ON(1);
+		return NULL;
+	}
+
+	cxld_registry_save(td, cxld);
+	return no_free_ptr(td);
+}
+
+static void init_disabled_mock_decoder(struct cxl_decoder *cxld)
+{
+	cxld->hpa_range.start = 0;
+	cxld->hpa_range.end = -1;
+	cxld->interleave_ways = 1;
+	cxld->interleave_granularity = 0;
+	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
+	cxld->flags = 0;
+	cxld->commit = mock_decoder_commit;
+	cxld->reset = mock_decoder_reset;
+
+	if (is_switch_decoder(&cxld->dev)) {
+		struct cxl_switch_decoder *cxlsd =
+			to_cxl_switch_decoder(&cxld->dev);
+
+		for (int i = 0; i < cxlsd->nr_targets; i++) {
+			cxlsd->target[i] = NULL;
+			cxld->target_map[i] = 0;
+		}
+	} else {
+		struct cxl_endpoint_decoder *cxled =
+			to_cxl_endpoint_decoder(&cxld->dev);
+
+		cxled->state = CXL_DECODER_STATE_MANUAL;
+		cxled->skip = 0;
+	}
 }
 
 static void default_mock_decoder(struct cxl_decoder *cxld)
@@ -757,6 +1036,8 @@ static void default_mock_decoder(struct cxl_decoder *cxld)
 	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
 	cxld->commit = mock_decoder_commit;
 	cxld->reset = mock_decoder_reset;
+
+	WARN_ON_ONCE(!cxld_registry_new(cxld));
 }
 
 static int first_decoder(struct device *dev, const void *data)
@@ -771,13 +1052,29 @@ static int first_decoder(struct device *dev, const void *data)
 	return 0;
 }
 
-static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
+/*
+ * Initialize a decoder during HDM enumeration.
+ *
+ * If a saved registry entry exists:
+ *   - enabled decoders are restored from the saved programming
+ *   - disabled decoders are initialized in a clean disabled state
+ *
+ * If no registry entry exists the decoder follows the normal mock
+ * initialization path, including the special auto-region setup for
+ * the first endpoints under host-bridge0.
+ *
+ * Returns true if decoder state was restored from the registry. In
+ * that case the saved decode configuration (including target mapping)
+ * has already been applied and the map_targets() is skipped.
+ */
+static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
 {
 	struct acpi_cedt_cfmws *window = mock_cfmws[0];
 	struct platform_device *pdev = NULL;
 	struct cxl_endpoint_decoder *cxled;
 	struct cxl_switch_decoder *cxlsd;
 	struct cxl_port *port, *iter;
+	struct cxl_test_decoder *td;
 	struct cxl_memdev *cxlmd;
 	struct cxl_dport *dport;
 	struct device *dev;
@@ -804,6 +1101,24 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
 				port = NULL;
 		} while (port);
 		port = cxled_to_port(cxled);
+	} else {
+		port = to_cxl_port(cxld->dev.parent);
+	}
+
+	td = cxld_registry_find(cxld);
+	if (td) {
+		bool enabled;
+
+		if (is_switch_decoder(&cxld->dev))
+			enabled = td->cxlsd.cxld.flags & CXL_DECODER_F_ENABLE;
+		else
+			enabled = td->cxled.cxld.flags & CXL_DECODER_F_ENABLE;
+
+		if (enabled)
+			return !cxld_registry_restore(cxld, td);
+
+		init_disabled_mock_decoder(cxld);
+		return false;
 	}
 
 	/*
@@ -814,9 +1129,10 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
 	 *
 	 * See 'cxl list -BMPu -m cxl_mem.0,cxl_mem.4'
 	 */
-	if (!hb0 || pdev->id % 4 || pdev->id > 4 || cxld->id > 0) {
+	if (!is_endpoint_decoder(&cxld->dev) || !hb0 || pdev->id % 4 ||
+	    pdev->id > 4 || cxld->id > 0) {
 		default_mock_decoder(cxld);
-		return;
+		return false;
 	}
 
 	base = window->base_hpa;
@@ -838,6 +1154,7 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
 	cxld->commit = mock_decoder_commit;
 	cxld->reset = mock_decoder_reset;
 
+	WARN_ON_ONCE(!cxld_registry_new(cxld));
 	/*
 	 * Now that endpoint decoder is set up, walk up the hierarchy
 	 * and setup the switch and root port decoders targeting @cxlmd.
@@ -859,14 +1176,14 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
 			/* put cxl_mem.4 second in the decode order */
 			if (pdev->id == 4) {
 				cxlsd->target[1] = dport;
-				cxld->target_map[1] = dport->port_id;
+				cxlsd->cxld.target_map[1] = dport->port_id;
 			} else {
 				cxlsd->target[0] = dport;
-				cxld->target_map[0] = dport->port_id;
+				cxlsd->cxld.target_map[0] = dport->port_id;
 			}
 		} else {
 			cxlsd->target[0] = dport;
-			cxld->target_map[0] = dport->port_id;
+			cxlsd->cxld.target_map[0] = dport->port_id;
 		}
 		cxld = &cxlsd->cxld;
 		cxld->target_type = CXL_DECODER_HOSTONLYMEM;
@@ -885,8 +1202,14 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
 			.start = base,
 			.end = base + mock_auto_region_size - 1,
 		};
+		cxld->commit = mock_decoder_commit;
+		cxld->reset = mock_decoder_reset;
+
+		cxld_registry_update(cxld);
 		put_device(dev);
 	}
+
+	return false;
 }
 
 static int mock_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
@@ -895,6 +1218,7 @@ static int mock_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 	struct cxl_port *port = cxlhdm->port;
 	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
 	int target_count, i;
+	bool restored;
 
 	if (is_cxl_endpoint(port))
 		target_count = 0;
@@ -934,10 +1258,8 @@ static int mock_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 		}
 
 		ctx.target_map = cxld->target_map;
-
-		mock_init_hdm_decoder(cxld);
-
-		if (target_count) {
+		restored = mock_init_hdm_decoder(cxld);
+		if (target_count && !restored) {
 			rc = device_for_each_child(port->uport_dev, &ctx,
 						   map_targets);
 			if (rc) {
@@ -1415,6 +1737,33 @@ static int cxl_mem_init(void)
 	return rc;
 }
 
+static ssize_t
+decoder_reset_preserve_registry_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", decoder_reset_preserve_registry);
+}
+
+static ssize_t
+decoder_reset_preserve_registry_store(struct device *dev,
+				      struct device_attribute *attr,
+				      const char *buf, size_t count)
+{
+	int rc;
+
+	rc = kstrtobool(buf, &decoder_reset_preserve_registry);
+	if (rc)
+		return rc;
+	return count;
+}
+
+static DEVICE_ATTR_RW(decoder_reset_preserve_registry);
+
+static struct attribute *cxl_acpi_attrs[] = {
+	&dev_attr_decoder_reset_preserve_registry.attr, NULL
+};
+ATTRIBUTE_GROUPS(cxl_acpi);
+
 static __init int cxl_test_init(void)
 {
 	int rc, i;
@@ -1545,6 +1894,7 @@ static __init int cxl_test_init(void)
 
 	mock_companion(&acpi0017_mock, &cxl_acpi->dev);
 	acpi0017_mock.dev.bus = &platform_bus_type;
+	cxl_acpi->dev.groups = cxl_acpi_groups;
 
 	rc = platform_device_add(cxl_acpi);
 	if (rc)
@@ -1589,6 +1939,17 @@ static __init int cxl_test_init(void)
 	return rc;
 }
 
+static void free_decoder_registry(void)
+{
+	unsigned long index;
+	void *entry;
+
+	xa_for_each(&decoder_registry, index, entry) {
+		xa_erase(&decoder_registry, index);
+		kfree(entry);
+	}
+}
+
 static __exit void cxl_test_exit(void)
 {
 	int i;
@@ -1614,6 +1975,8 @@ static __exit void cxl_test_exit(void)
 	depopulate_all_mock_resources();
 	gen_pool_destroy(cxl_mock_pool);
 	unregister_cxl_mock_ops(&cxl_mock_ops);
+	free_decoder_registry();
+	xa_destroy(&decoder_registry);
 }
 
 module_param(interleave_arithmetic, int, 0444);

base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
-- 
2.37.3

