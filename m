Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA8E27381B
	for <linux-cxl@vger.kernel.org>; Thu, 14 Aug 2025 22:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755210199; cv=none; b=NfkeLBLk6xf5yYbd3qQZqCsERx76ZOCjETw2ky+GG2KuloEiQypH3+kWlJWTXez38TND/Lan9J0mQfSPUaOLqExUqEXkV5g4sN0IHF16gKFAb26n98In+xsECEW3295U/9LX5GLQbK3xyDWu98qL8liVIN5/2YJ94PC31dMldoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755210199; c=relaxed/simple;
	bh=WsCOWpAuzim1W8lb07gs73as1isMywkfJ85Iy5/VGzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r5gK2YIE63TSdLAl3BLTCGr6NeiXhTOAEZL5/V64UCXdpogZguBXu4yJAXdrocwlhogDJ/GeU5pmxbgJokBoNfGmfffFELygR8YV1aTAy6eBTbSz/+0gYcu2gPy4QyaF/S4rdDZYz8EH8nX67RjpD087B1+jkryN9M2IFnLkbF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98B65C4CEED;
	Thu, 14 Aug 2025 22:23:16 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	rrichter@amd.com
Subject: [PATCH v8 09/11] cxl/test: Setup target_map for cxl_test decoder initialization
Date: Thu, 14 Aug 2025 15:21:49 -0700
Message-ID: <20250814222151.3520500-10-dave.jiang@intel.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814222151.3520500-1-dave.jiang@intel.com>
References: <20250814222151.3520500-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_test uses mock functions for decoder enumation. Add initialization
of the cxld->target_map[] for cxl_test based decoders in the mock
functions.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/cxl.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 0ef2a8ec1fab..2d50193d10fe 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -818,15 +818,21 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
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

