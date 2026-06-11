Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60F7409121
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 15:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781191298; cv=none; b=fP4+EVDEDQestaImZu183JXgNnpHnJlRcNDpZTl2SOhqDOACje2pKPPlcT7FGFM7PfxvONG8LqiCiRTpsdSYbVxAEOPbcvzD18wAo8F3bZmVJ0VH85zDS00TQnN8/E3B1mmXPqr3L2TmN6qoSG7YEuaXkscPvv/TlW0rZVqnVsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781191298; c=relaxed/simple;
	bh=gxn2z0X0Tix0YkFR+mlvEipBj/aNDEoWxncp7eC5gj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LCdem21OnhLICGQjpemVK9b+JC0+uevvDX62G5gJM1S9DJA+fFZ7S+z0YFNuxTBwBDI6O4Jr/e8liYjZPE20JBabMemwIShNXbx8axrnhoKR1m4Jb/FAKQM5PIAi1Q+NAP2MPd0iPglNF7KiaochG8NXu36FntP2TmzwyZUhpq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81EB11F00899;
	Thu, 11 Jun 2026 15:21:36 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: djbw@kernel.org,
	dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com
Subject: [PATCH v4 5/6] cxl/test: Fixup hdm init for auto region to support type2
Date: Thu, 11 Jun 2026 08:21:23 -0700
Message-ID: <20260611152124.3656434-6-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260611152124.3656434-1-dave.jiang@intel.com>
References: <20260611152124.3656434-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support to setup initialization of decoders in order to support
type2 auto region.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
- rebased against v7.1-rc7
---
 tools/testing/cxl/test/cxl.c | 255 +++++++++++++++++++++++++----------
 1 file changed, 186 insertions(+), 69 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index de4124afa132..0310f2efd331 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -1077,74 +1077,26 @@ static int first_decoder(struct device *dev, const void *data)
 	return 0;
 }
 
-/*
- * Initialize a decoder during HDM enumeration.
- *
- * If a saved registry entry exists:
- *   - enabled decoders are restored from the saved programming
- *   - disabled decoders are initialized in a clean disabled state
- *
- * If no registry entry exists the decoder follows the normal mock
- * initialization path, including the special auto-region setup for
- * the first endpoints under host-bridge0.
- *
- * Returns true if decoder state was restored from the registry. In
- * that case the saved decode configuration (including target mapping)
- * has already been applied and the map_targets() is skipped.
- */
-static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
+enum cxld_init_type {
+	MOCK_DECODER_INIT_DEFAULT,
+	MOCK_DECODER_INIT_SAVED,
+	MOCK_DECODER_INIT_TYPE3_AUTO,
+	MOCK_DECODER_INIT_TYPE2_AUTO,
+};
+
+static enum cxld_init_type get_decoder_init_type(struct cxl_decoder *cxld,
+						 struct platform_device *pdev,
+						 bool hb0,
+						 struct cxl_test_decoder **td)
 {
-	struct acpi_cedt_cfmws *window = mock_cfmws[0];
-	struct platform_device *pdev = NULL;
-	struct cxl_endpoint_decoder *cxled;
-	struct cxl_switch_decoder *cxlsd;
-	struct cxl_port *port, *iter;
-	struct cxl_test_decoder *td;
-	struct cxl_memdev *cxlmd;
-	struct cxl_dport *dport;
-	struct device *dev;
-	bool hb0 = false;
-	u64 base;
-	int i;
+	struct cxl_test_decoder *found_td = cxld_registry_find(cxld);
 
-	if (is_endpoint_decoder(&cxld->dev)) {
-		cxled = to_cxl_endpoint_decoder(&cxld->dev);
-		cxlmd = cxled_to_memdev(cxled);
-		WARN_ON(!dev_is_platform(cxlmd->dev.parent));
-		pdev = to_platform_device(cxlmd->dev.parent);
-
-		/* check is endpoint is attach to host-bridge0 */
-		port = cxled_to_port(cxled);
-		do {
-			if (port->uport_dev == &cxl_host_bridge[0]->dev) {
-				hb0 = true;
-				break;
-			}
-			if (is_cxl_port(port->dev.parent))
-				port = to_cxl_port(port->dev.parent);
-			else
-				port = NULL;
-		} while (port);
-		port = cxled_to_port(cxled);
-	} else {
-		port = to_cxl_port(cxld->dev.parent);
+	if (found_td) {
+		*td = found_td;
+		return MOCK_DECODER_INIT_SAVED;
 	}
 
-	td = cxld_registry_find(cxld);
-	if (td) {
-		bool enabled;
-
-		if (is_switch_decoder(&cxld->dev))
-			enabled = td->cxlsd.cxld.flags & CXL_DECODER_F_ENABLE;
-		else
-			enabled = td->cxled.cxld.flags & CXL_DECODER_F_ENABLE;
-
-		if (enabled)
-			return !cxld_registry_restore(cxld, td);
-
-		init_disabled_mock_decoder(cxld);
-		return false;
-	}
+	*td = NULL;
 
 	/*
 	 * The first decoder on the first 2 devices on the first switch
@@ -1155,15 +1107,111 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
 	 * See 'cxl list -BMPu -m cxl_mem.0,cxl_mem.4'
 	 */
 	if (!is_endpoint_decoder(&cxld->dev) || !hb0 || pdev->id % 4 ||
-	    pdev->id > 4 || cxld->id > 0) {
-		default_mock_decoder(cxld);
-		return false;
-	}
+	    pdev->id > 4 || cxld->id > 0)
+		return MOCK_DECODER_INIT_DEFAULT;
+
+	return type2_test ? MOCK_DECODER_INIT_TYPE2_AUTO :
+			    MOCK_DECODER_INIT_TYPE3_AUTO;
+}
+
+static bool mock_decoder_handle_saved(struct cxl_decoder *cxld, struct cxl_test_decoder *td)
+{
+	bool enabled;
+
+	if (is_switch_decoder(&cxld->dev))
+		enabled = td->cxlsd.cxld.flags & CXL_DECODER_F_ENABLE;
+	else
+		enabled = td->cxled.cxld.flags & CXL_DECODER_F_ENABLE;
+
+	if (enabled)
+		return !cxld_registry_restore(cxld, td);
+
+	init_disabled_mock_decoder(cxld);
+	return false;
+}
+
+static void mock_init_hdm_type2_cxled(struct cxl_endpoint_decoder *cxled,
+				      struct cxl_port *port,
+				      struct platform_device *pdev)
+{
+	struct acpi_cedt_cfmws *window = mock_cfmws[0];
+	struct cxl_decoder *cxld = &cxled->cxld;
+	struct cxl_switch_decoder *cxlsd;
+	struct cxl_dport *dport;
+	struct cxl_port *root_port;
+	struct device *dev;
+	u64 base;
+
+	base = window->base_hpa;
+	cxld->hpa_range = (struct range) {
+		.start = base,
+		.end = base + mock_auto_region_size - 1,
+	};
+
+	cxld->interleave_ways = 1;
+	eig_to_granularity(window->granularity, &cxld->interleave_granularity);
+	cxld->target_type = CXL_DECODER_DEVMEM;
+	cxld->flags = CXL_DECODER_F_ENABLE;
+	cxled->state = CXL_DECODER_STATE_AUTO;
+	port->commit_end = cxld->id;
+	devm_cxl_dpa_reserve(cxled, 0,
+			     mock_auto_region_size / cxld->interleave_ways, 0);
+	cxld->commit = mock_decoder_commit;
+	cxld->reset = mock_decoder_reset;
+
+	WARN_ON_ONCE(!cxld_registry_new(cxld));
+	/*
+	 * Now that endpoint decoder is set up, walk up the hierarchy
+	 * and setup the root port decoder targeting @cxlmd.
+	 */
+	dport = port->parent_dport;
+	root_port = dport->port;
+	dev = device_find_child(&root_port->dev, NULL, first_decoder);
+	/*
+	 * Ancestor ports are guaranteed to be enumerated before
+	 * @port, and all ports have at least one decoder.
+	 */
+	if (WARN_ON(!dev))
+		return;
+
+	cxlsd = to_cxl_switch_decoder(dev);
+	cxlsd->target[0] = dport;
+	cxlsd->cxld.target_map[0] = dport->port_id;
+	cxld = &cxlsd->cxld;
+	cxld->target_type = CXL_DECODER_DEVMEM;
+	cxld->flags = CXL_DECODER_F_ENABLE;
+	root_port->commit_end = 0;
+	cxld->interleave_ways = 1;
+	cxld->interleave_granularity = 4096;
+	cxld->hpa_range = (struct range) {
+		.start = base,
+		.end = base + mock_auto_region_size - 1,
+	};
+	cxld->commit = mock_decoder_commit;
+	cxld->reset = mock_decoder_reset;
+
+	cxld_registry_update(cxld);
+	put_device(dev);
+}
+
+static void mock_init_hdm_type3_cxled(struct cxl_endpoint_decoder *cxled,
+				      struct cxl_port *port,
+				      struct platform_device *pdev,
+				      bool hb0)
+{
+	struct acpi_cedt_cfmws *window = mock_cfmws[0];
+	struct cxl_decoder *cxld = &cxled->cxld;
+	struct cxl_switch_decoder *cxlsd;
+	struct cxl_dport *dport;
+	struct cxl_port *iter;
+	struct device *dev;
+	u64 base;
+	int i;
 
 	/* Simulate missing cxl_mem.4 configuration */
 	if (hb0 && pdev->id == 4 && cxld->id == 0 && fail_autoassemble) {
 		default_mock_decoder(cxld);
-		return false;
+		return;
 	}
 
 	base = window->base_hpa;
@@ -1239,7 +1287,76 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
 		cxld_registry_update(cxld);
 		put_device(dev);
 	}
+}
 
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
+{
+	struct cxl_endpoint_decoder *cxled = NULL;
+	struct platform_device *pdev = NULL;
+	struct cxl_test_decoder *td;
+	struct cxl_memdev *cxlmd;
+	struct cxl_port *port;
+	bool hb0 = false;
+
+	if (is_endpoint_decoder(&cxld->dev)) {
+		cxled = to_cxl_endpoint_decoder(&cxld->dev);
+		cxlmd = cxled_to_memdev(cxled);
+		WARN_ON(!dev_is_platform(cxlmd->dev.parent));
+		pdev = to_platform_device(cxlmd->dev.parent);
+
+		/* check is endpoint is attach to host-bridge0 */
+		port = cxled_to_port(cxled);
+		do {
+			if (port->uport_dev == &cxl_host_bridge[0]->dev) {
+				hb0 = true;
+				break;
+			}
+			if (is_cxl_port(port->dev.parent))
+				port = to_cxl_port(port->dev.parent);
+			else
+				port = NULL;
+		} while (port);
+		port = cxled_to_port(cxled);
+	} else {
+		port = to_cxl_port(cxld->dev.parent);
+	}
+
+	switch (get_decoder_init_type(cxld, pdev, hb0, &td)) {
+	case MOCK_DECODER_INIT_SAVED:
+		if (WARN_ON(!td))
+			return false;
+		return mock_decoder_handle_saved(cxld, td);
+	case MOCK_DECODER_INIT_DEFAULT:
+		/*
+		 * The default path picks up all the decoders that are not
+		 * endpoint.
+		 */
+		default_mock_decoder(cxld);
+		return false;
+	case MOCK_DECODER_INIT_TYPE3_AUTO:
+		mock_init_hdm_type3_cxled(cxled, port, pdev, hb0);
+		return false;
+	case MOCK_DECODER_INIT_TYPE2_AUTO:
+		mock_init_hdm_type2_cxled(cxled, port, pdev);
+		return false;
+	default:
+		return false;
+	}
 	return false;
 }
 
-- 
2.54.0

