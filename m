Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C26228DC4
	for <linux-cxl@vger.kernel.org>; Wed, 22 Apr 2026 23:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776898961; cv=none; b=YSAxE30nXSuJmUOif8CA0OxtY1QtmFUB89NWnPYyWJg93C7ycxoD/DaGq2EK1Pt4aIdDkquU7sPDCcscTBlMqxY1en/K6LTsTNvqa+m6SImr3tpXIbwr1bkz/WWbOyqph/HGrYMrkXIGYvRY4TigIjQ0bnKWJkigQnCkcawC1oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776898961; c=relaxed/simple;
	bh=8d41cPLzVHpkorE97GlsU7bagmpanIw5FMYu+yQ4LxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oS6rFvDztmh+ahCDGnXUBTLv1Luav6YpEhZJxl1wAlCfa7ZJJWRd84/kaJMzHs/PdxhS8ijE7FDqOXhw66XMVa7aRCk9+7n1HmoMpOcEyX8NZcMKWwLA1ulSHMsuXjwNH85LJFAJ/8UIt485zlefM4pw44+z+QLe0EphYjtoyrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A797C19425;
	Wed, 22 Apr 2026 23:02:40 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	djbw@kernel.org
Subject: [PATCH 1/7] cxl/test: Refactor mock_init_hdm_decoder() to prep for type2 decoder
Date: Wed, 22 Apr 2026 16:02:31 -0700
Message-ID: <20260422230237.2599333-2-dave.jiang@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422230237.2599333-1-dave.jiang@intel.com>
References: <20260422230237.2599333-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split mock_init_hdm_decoder() into different types of initialization.
Currently the code deals with default initialization, saved decoders,
and type3 auto region initialization. In the future, a type2 auto
initialization will also be added. This refactor will make it cleaner
to add additional init types.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/cxl.c | 184 ++++++++++++++++++++++-------------
 1 file changed, 115 insertions(+), 69 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index cd47fdd7ccb5..c26c37cef12c 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -1052,74 +1052,25 @@ static int first_decoder(struct device *dev, const void *data)
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
@@ -1130,10 +1081,40 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
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
+	return MOCK_DECODER_INIT_TYPE3_AUTO;
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
+static void mock_init_hdm_type3_cxled(struct cxl_endpoint_decoder *cxled,
+				      struct cxl_port *port,
+				      struct platform_device *pdev)
+{
+	struct acpi_cedt_cfmws *window = mock_cfmws[0];
+	struct cxl_decoder *cxld = &cxled->cxld;
+	struct cxl_switch_decoder *cxlsd;
+	struct cxl_dport *dport;
+	struct cxl_port *iter;
+	struct device *dev;
+	u64 base;
+	int i;
 
 	base = window->base_hpa;
 	if (extended_linear_cache)
@@ -1208,8 +1189,73 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
 		cxld_registry_update(cxld);
 		put_device(dev);
 	}
+}
 
-	return false;
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
+		if (!td)
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
+		mock_init_hdm_type3_cxled(cxled, port, pdev);
+		return false;
+	default:
+		return false;
+	}
 }
 
 static int mock_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
-- 
2.53.0

