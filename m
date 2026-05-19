Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E39C3E51FC
	for <linux-cxl@vger.kernel.org>; Tue, 19 May 2026 21:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779226668; cv=none; b=R8fDYi7t1P7EWpxQVngBM5GDdcTWhfmGc2tr2x1vyCrQvJ7cwR7g7qoEC7KBIIICQ7YN3q+JS407u9JxP5ZealNLzj3Hme19YgWnAy//bktjJx04jEWk4bu5iKKmqs2n7UpIha+QfVMRookG/mbFl3gDa0QISk6yXWAmjweDCos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779226668; c=relaxed/simple;
	bh=VgMBemJCp9riTyc5HbpGd9OCd1gXvyup5+sPSs1NXBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E8M61T7SSuAft0Vq3UZxxjBJXtl16FDuK1oKI31uq6aEmic+yEC6dZFYk8TxcuhSKH0DP+j5/gp3FTH+ulZgDbVtEVT6iSVHl1MyYiUgknv7WJfYcjWR/robG+MyhFpjULSXwLfDfq+Ap1Kgw3w+8ATGH5JJAtGcgY0s0XiZ7Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1E691F000E9;
	Tue, 19 May 2026 21:37:46 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: djbw@kernel.org,
	dave@stgolabs.net,
	jic23@kernel.org,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com
Subject: [PATCH v2 5/6] cxl/test: Fixup hdm init for auto region to support type2
Date: Tue, 19 May 2026 14:37:32 -0700
Message-ID: <20260519213734.69737-6-dave.jiang@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519213734.69737-1-dave.jiang@intel.com>
References: <20260519213734.69737-1-dave.jiang@intel.com>
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
 tools/testing/cxl/test/cxl.c | 73 +++++++++++++++++++++++++++++++++++-
 1 file changed, 72 insertions(+), 1 deletion(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 2a39b2575f06..042f057e42eb 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -1081,6 +1081,7 @@ enum cxld_init_type {
 	MOCK_DECODER_INIT_DEFAULT,
 	MOCK_DECODER_INIT_SAVED,
 	MOCK_DECODER_INIT_TYPE3_AUTO,
+	MOCK_DECODER_INIT_TYPE2_AUTO,
 };
 
 static enum cxld_init_type get_decoder_init_type(struct cxl_decoder *cxld,
@@ -1109,7 +1110,8 @@ static enum cxld_init_type get_decoder_init_type(struct cxl_decoder *cxld,
 	    pdev->id > 4 || cxld->id > 0)
 		return MOCK_DECODER_INIT_DEFAULT;
 
-	return MOCK_DECODER_INIT_TYPE3_AUTO;
+	return type2_test ? MOCK_DECODER_INIT_TYPE2_AUTO :
+			    MOCK_DECODER_INIT_TYPE3_AUTO;
 }
 
 static bool mock_decoder_handle_saved(struct cxl_decoder *cxld, struct cxl_test_decoder *td)
@@ -1128,6 +1130,70 @@ static bool mock_decoder_handle_saved(struct cxl_decoder *cxld, struct cxl_test_
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
 				      struct platform_device *pdev,
@@ -1285,6 +1351,11 @@ static bool mock_init_hdm_decoder(struct cxl_decoder *cxld)
 	case MOCK_DECODER_INIT_TYPE3_AUTO:
 		mock_init_hdm_type3_cxled(cxled, port, pdev, hb0);
 		return false;
+	case MOCK_DECODER_INIT_TYPE2_AUTO:
+		mock_init_hdm_type2_cxled(cxled, port, pdev);
+		return false;
+	default:
+		return false;
 	}
 	return false;
 }
-- 
2.54.0

