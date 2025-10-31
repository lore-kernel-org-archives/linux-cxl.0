Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DAE283C9D
	for <linux-cxl@vger.kernel.org>; Fri, 31 Oct 2025 17:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761931947; cv=none; b=V1ZyJ0nRrihPM/xGrRWfVaLCICjkqsj0Cj94a1F0qOASW/ryYphnVnQlHcYO8JRc6NPwFrnnyBnqHnIpEJN/zJxXPp147VKnbR3pa4te9wjIDocJRREzjnN8IOHWCfaUx0+9EF8kG8ixH09Qd+hF0lJ8fUXDPU01EYQ0tw3X1YQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761931947; c=relaxed/simple;
	bh=wieY+ZLSDnXvMFCD5sXplJpQdA8Hs9poe2zusiiOFF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VWKhpPejdcJ7ZlYhODgvk9u4yu5vPEgzomCD4cwNkjKLvAY6mxjUM4xOeIRofv9FNp4yXyHwpkFg7YcjOGN93ezQFlj3cDiiPUlDxmGe4M1vmdKhXVYl8fWy367MggLQOlnHAcUxY9p6rAbZ8ocC01kzNM0SKSo8WqwYTYrGTds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18AEFC4AF14;
	Fri, 31 Oct 2025 17:32:27 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Subject: [PATCH 1/4] cxl/test: Standardize CXL auto region size
Date: Fri, 31 Oct 2025 10:32:21 -0700
Message-ID: <20251031173224.3537030-2-dave.jiang@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031173224.3537030-1-dave.jiang@intel.com>
References: <20251031173224.3537030-1-dave.jiang@intel.com>
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

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/cxl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 2d135ca533d0..d53b72bc034f 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -26,6 +26,8 @@ static int interleave_arithmetic;
 #define NR_CXL_PORT_DECODERS 8
 #define NR_BRIDGES (NR_CXL_HOST_BRIDGES + NR_CXL_SINGLE_HOST + NR_CXL_RCH)
 
+#define MOCK_AUTO_REGION_SIZE SZ_512M
+
 static struct platform_device *cxl_acpi;
 static struct platform_device *cxl_host_bridge[NR_CXL_HOST_BRIDGES];
 #define NR_MULTI_ROOT (NR_CXL_HOST_BRIDGES * NR_CXL_ROOT_PORTS)
@@ -738,7 +740,6 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
 	struct cxl_endpoint_decoder *cxled;
 	struct cxl_switch_decoder *cxlsd;
 	struct cxl_port *port, *iter;
-	const int size = SZ_512M;
 	struct cxl_memdev *cxlmd;
 	struct cxl_dport *dport;
 	struct device *dev;
@@ -783,7 +784,7 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
 	base = window->base_hpa;
 	cxld->hpa_range = (struct range) {
 		.start = base,
-		.end = base + size - 1,
+		.end = base + MOCK_AUTO_REGION_SIZE - 1,
 	};
 
 	cxld->interleave_ways = 2;
@@ -792,7 +793,8 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
 	cxld->flags = CXL_DECODER_F_ENABLE;
 	cxled->state = CXL_DECODER_STATE_AUTO;
 	port->commit_end = cxld->id;
-	devm_cxl_dpa_reserve(cxled, 0, size / cxld->interleave_ways, 0);
+	devm_cxl_dpa_reserve(cxled, 0,
+			     MOCK_AUTO_REGION_SIZE / cxld->interleave_ways, 0);
 	cxld->commit = mock_decoder_commit;
 	cxld->reset = mock_decoder_reset;
 
@@ -841,7 +843,7 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
 		cxld->interleave_granularity = 4096;
 		cxld->hpa_range = (struct range) {
 			.start = base,
-			.end = base + size - 1,
+			.end = base + MOCK_AUTO_REGION_SIZE - 1,
 		};
 		put_device(dev);
 	}
-- 
2.51.0

