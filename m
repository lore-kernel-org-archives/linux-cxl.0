Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623CD21A459
	for <linux-cxl@vger.kernel.org>; Mon, 17 Nov 2025 14:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763390779; cv=none; b=um4KbM4O2pd5Bu6KYVPhqXDNtmpfpBSPFdKGw7dLcQMWkhUS+HVL+OC3r9dizeIyCJH5C8rkH/p2F7BsjMhJ+UnVxO+HMF883Bpl2Qf/DX2HC1XcO0P3k7UMHubXHst5yN58k++ZSmIgwtEdWXXMix4Hy5Yx+OHbg8SqtBtxTvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763390779; c=relaxed/simple;
	bh=wSIRoncgR7njtPSBMdDe1kOLKGj/Hp350DxCzEy3DKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a6VZvv8EEvc+ye7h7MTLAlDROgU2VkUP1qKU1Rt4ct+CvGHeU1R5eeCRemfsiRHz2nLDUa3liErH4svcYtoTrNWOZl/aDbayq5/9J7OBdKZd7WeAcJh5cEx2RDnDYoXeXKDuot8zxBr3yj5AS2h0lyWv1SfpWfCM+nYxqLf9+J4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A2CC19422;
	Mon, 17 Nov 2025 14:46:18 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH v2 1/3] cxl/test: Standardize CXL auto region size
Date: Mon, 17 Nov 2025 07:46:09 -0700
Message-ID: <20251117144611.903692-2-dave.jiang@intel.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251117144611.903692-1-dave.jiang@intel.com>
References: <20251117144611.903692-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create a global define for the size of the mock CXL auto region used
in cxl_test. Remove the declared size in mock_init_hdm_decoder()
function.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v2:
- Make auto region size a global that can be changed at init. (Fabio)
---
 tools/testing/cxl/test/cxl.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 2d135ca533d0..f0e734536081 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -26,6 +26,9 @@ static int interleave_arithmetic;
 #define NR_CXL_PORT_DECODERS 8
 #define NR_BRIDGES (NR_CXL_HOST_BRIDGES + NR_CXL_SINGLE_HOST + NR_CXL_RCH)
 
+#define MOCK_AUTO_REGION_SIZE_DEFAULT SZ_512M
+static int mock_auto_region_size = MOCK_AUTO_REGION_SIZE_DEFAULT;
+
 static struct platform_device *cxl_acpi;
 static struct platform_device *cxl_host_bridge[NR_CXL_HOST_BRIDGES];
 #define NR_MULTI_ROOT (NR_CXL_HOST_BRIDGES * NR_CXL_ROOT_PORTS)
@@ -738,7 +741,6 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
 	struct cxl_endpoint_decoder *cxled;
 	struct cxl_switch_decoder *cxlsd;
 	struct cxl_port *port, *iter;
-	const int size = SZ_512M;
 	struct cxl_memdev *cxlmd;
 	struct cxl_dport *dport;
 	struct device *dev;
@@ -783,7 +785,7 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
 	base = window->base_hpa;
 	cxld->hpa_range = (struct range) {
 		.start = base,
-		.end = base + size - 1,
+		.end = base + mock_auto_region_size - 1,
 	};
 
 	cxld->interleave_ways = 2;
@@ -792,7 +794,8 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
 	cxld->flags = CXL_DECODER_F_ENABLE;
 	cxled->state = CXL_DECODER_STATE_AUTO;
 	port->commit_end = cxld->id;
-	devm_cxl_dpa_reserve(cxled, 0, size / cxld->interleave_ways, 0);
+	devm_cxl_dpa_reserve(cxled, 0,
+			     mock_auto_region_size / cxld->interleave_ways, 0);
 	cxld->commit = mock_decoder_commit;
 	cxld->reset = mock_decoder_reset;
 
@@ -841,7 +844,7 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
 		cxld->interleave_granularity = 4096;
 		cxld->hpa_range = (struct range) {
 			.start = base,
-			.end = base + size - 1,
+			.end = base + mock_auto_region_size - 1,
 		};
 		put_device(dev);
 	}
-- 
2.51.1

