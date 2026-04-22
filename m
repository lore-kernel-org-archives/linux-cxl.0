Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 047C42BFC60
	for <linux-cxl@vger.kernel.org>; Wed, 22 Apr 2026 23:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776898967; cv=none; b=qAI0lmJbvxM9ZYYakkB/jGY0V+tl0cgA1anhBXufDDA591wqfUg4DaZXhw426sTZI9YmZvCrSlAHNtRhsURmWs+VEEIPKXMIwVlr7PNDa9yZ8qSkFFAu65hGsOZWC8sOwp67SlJ3/HYU5p+vE9RV2AU2wlqyo6c2HXIPtC/C0mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776898967; c=relaxed/simple;
	bh=B4aP9XDLe8cN3BVVm4o5gPt5MlZtkCiDdb0A5xIAUvg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IvoKmpnNE5ScaA8jGBwg/Od3DjLpO778fIkaf8z1PipHHIhZWQzd6ObJTEnDj1J6DbPWWSWmXpHeyfD4WdoRy0PuVFU2x6hHoh/y0ZsWp9RxvgYoee9v1CGdObGKqQwZ9NyBSfPof7De3P723mm3aSGDcONo6o2M1/TUyDZa82c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6671C19425;
	Wed, 22 Apr 2026 23:02:46 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	djbw@kernel.org
Subject: [PATCH 5/7] cxl/test: Fixup hdm init for auto region to support type2
Date: Wed, 22 Apr 2026 16:02:35 -0700
Message-ID: <20260422230237.2599333-6-dave.jiang@intel.com>
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

Add support to setup initialization of decoders in order to support
type2 auto region.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/cxl.c | 71 +++++++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 59a265ad23e0..8e489d22ab5e 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -1079,6 +1079,7 @@ enum cxld_init_type {
 	MOCK_DECODER_INIT_DEFAULT,
 	MOCK_DECODER_INIT_SAVED,
 	MOCK_DECODER_INIT_TYPE3_AUTO,
+	MOCK_DECODER_INIT_TYPE2_AUTO,
 };
 
 static enum cxld_init_type get_decoder_init_type(struct cxl_decoder *cxld,
@@ -1107,7 +1108,8 @@ static enum cxld_init_type get_decoder_init_type(struct cxl_decoder *cxld,
 	    pdev->id > 4 || cxld->id > 0)
 		return MOCK_DECODER_INIT_DEFAULT;
 
-	return MOCK_DECODER_INIT_TYPE3_AUTO;
+	return type2_test ? MOCK_DECODER_INIT_TYPE2_AUTO :
+			    MOCK_DECODER_INIT_TYPE3_AUTO;
 }
 
 static bool mock_decoder_handle_saved(struct cxl_decoder *cxld, struct cxl_test_decoder *td)
@@ -1126,6 +1128,70 @@ static bool mock_decoder_handle_saved(struct cxl_decoder *cxld, struct cxl_test_
 	return false;
 }
 
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
 static void mock_init_hdm_type3_cxled(struct cxl_endpoint_decoder *cxled,
 				      struct cxl_port *port,
 				      struct platform_device *pdev)
@@ -1276,6 +1342,9 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
 	case MOCK_DECODER_INIT_TYPE3_AUTO:
 		mock_init_hdm_type3_cxled(cxled, port, pdev);
 		return false;
+	case MOCK_DECODER_INIT_TYPE2_AUTO:
+		mock_init_hdm_type2_cxled(cxled, port, pdev);
+		return false;
 	default:
 		return false;
 	}
-- 
2.53.0

