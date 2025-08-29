Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEEE3431F7
	for <linux-cxl@vger.kernel.org>; Fri, 29 Aug 2025 18:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756491044; cv=none; b=bsyCHpBQxViSHv2ByRRwvZHFIlm2huO449MR8dbWth8t5jcd/kbuFSwCEZnuMo1AUTAYqyFzwYWhHsG6Q7/5CWnC3shMR4lDGxYT2kzWwT/yvpt84WBiKcDNAwtGiV0YBRm28du8iKiJMTdr469tN+DT5fJv4oSXUMNY+xqq36M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756491044; c=relaxed/simple;
	bh=E22IWB8K0VrQJBWiTGiAF6Jc5v6QlkLq+Dgp5kvAuq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kKYOHNsi5gBPlmIWk602LAIx/q/q+Gcd1/pTMlMz7xZTGwPkiGUUrpVlpAo8pdsx6X9Bd7i5gyjVo3C1MArX3mxvna3SpqNEsIkECZeiHrgn/ZyqgXpBlfwbNrI2r+Jo0ulPfUQ2X9dZHIau9tRRFz/Z3BM+ejCQGU5byDhnW1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927DEC4CEF0;
	Fri, 29 Aug 2025 18:10:43 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	rrichter@amd.com
Subject: [PATCH v9 09/10] cxl/test: Setup target_map for cxl_test decoder initialization
Date: Fri, 29 Aug 2025 11:09:27 -0700
Message-ID: <20250829180928.842707-10-dave.jiang@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250829180928.842707-1-dave.jiang@intel.com>
References: <20250829180928.842707-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_test uses mock functions for decoder enumaration. Add initialization
of the cxld->target_map[] for cxl_test based decoders in the mock
functions.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Tested-by: Robert Richter <rrichter@amd.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/cxl.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index e3b4dc265a3b..5d0040b7d7db 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -811,15 +811,21 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
 		 */
 		if (WARN_ON(!dev))
 			continue;
+
 		cxlsd = to_cxl_switch_decoder(dev);
 		if (i == 0) {
 			/* put cxl_mem.4 second in the decode order */
-			if (pdev->id == 4)
+			if (pdev->id == 4) {
 				cxlsd->target[1] = dport;
-			else
+				cxld->target_map[1] = dport->port_id;
+			} else {
 				cxlsd->target[0] = dport;
-		} else
+				cxld->target_map[0] = dport->port_id;
+			}
+		} else {
 			cxlsd->target[0] = dport;
+			cxld->target_map[0] = dport->port_id;
+		}
 		cxld = &cxlsd->cxld;
 		cxld->target_type = CXL_DECODER_HOSTONLYMEM;
 		cxld->flags = CXL_DECODER_F_ENABLE;
-- 
2.50.1

