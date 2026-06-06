Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFAA2773D8;
	Sat,  6 Jun 2026 07:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780732304; cv=pass; b=bCqkFkgp5sdZNe99fYCgH5JjWGaLGJqp999yu6/S4s5k5Zdieg7l1ubXTU5Zto7BOH/aHlF8cWVu/bnwo5mxPDwETdV8f1Fz3GMpOUWwd48pbsj7lvM1EHJYnhYgzDuxUtbjyuJN0Rg++2Jb99A9mqvihYaO3ZCcNohkVCx2mNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780732304; c=relaxed/simple;
	bh=G1lngwsewO3vMMBXZZYaCMdOW71S67BHaKXErodzQDc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lnrdmMfI789e7fENMAcsN6qUnyN7NtjOJ9FTZIbfgJnpUolD5ZjXUkz1wTAUKpT0K184cDZwzEbLSqOLZhqVuGIZOIVvFHl4vV4aJSby8yUYeIqakkqnMJP4dTa1+S48Blj2+z22HP8SLYnXmo/rf4F92SFvvojJDgQEUsVsWp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=AsE4Jvjp; arc=pass smtp.client-ip=136.143.188.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="AsE4Jvjp"
ARC-Seal: i=1; a=rsa-sha256; t=1780732295; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=FoptrEpcQzyaxWEXP8oarvJvtA+Y0GvhaNO6cB8AVEwHGimib1KEx4JiRmrPxZc7kcvwigac4+vanQ0o+lOSU9w0vIiOB2QC3OwQ+G81p91NyqwVMfM38Fwoe7Za1w5dSu/paEO+wDEcyBq6mDnh1t0zHEWfz8q31mcOXC3+k6s=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1780732295; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=G1hRAAGyADIRc0lbMGLuL9QRdmnTHeEIzT2xvosUQD0=; 
	b=ONQNqFoBxeM8KFj3vQd6WKjWeZwcdq+kXrCG3J9+mjtf7LtmISL2cNUXluUhpJP4rPnEZDNxhLdzm+VGuA1HnjvHg90Y10hkThov3Xl0Pcr1jmQZpS6lhQsNnOJFj+hxWWzAABIzAyclcxDLwcSGyfrkKwqp1/AeIZqYsMYrHys=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1780732295;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Feedback-ID:Reply-To;
	bh=G1hRAAGyADIRc0lbMGLuL9QRdmnTHeEIzT2xvosUQD0=;
	b=AsE4JvjpIoDkB7mdxgszhYe8Y8N6p6MW3IXB9obRb9Eu3zMg3sjde4pOoNeJkgib
	A4IFAGflr0Nr0RtDB+35E5BYw2gy9BsxnMeSN0BMRNKWSRG5oltEU3Nd4yiZOTBjDaG
	MOxJD8XDYvAMkSsWT6KQOr3SZU/O1cvxHWGPDUpA=
Received: by mx.zohomail.com with SMTPS id 1780732293967747.3688741012527;
	Sat, 6 Jun 2026 00:51:33 -0700 (PDT)
From: Li Ming <ming.li@zohomail.com>
Date: Sat, 06 Jun 2026 15:51:00 +0800
Subject: [PATCH 1/2] cxl/region: Fix out-of-bounds access in
 cxl_cancel_auto_attach()
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-fix_two_issues_introduced_by_cxl_cancel_auto_attach-v1-1-5d94ca06c4e4@zohomail.com>
References: <20260606-fix_two_issues_introduced_by_cxl_cancel_auto_attach-v1-0-5d94ca06c4e4@zohomail.com>
In-Reply-To: <20260606-fix_two_issues_introduced_by_cxl_cancel_auto_attach-v1-0-5d94ca06c4e4@zohomail.com>
To: Davidlohr Bueso <dave@stgolabs.net>, 
 Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
 Alison Schofield <alison.schofield@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Dan Williams <djbw@kernel.org>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Li Ming <ming.li@zohomail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780732288; l=2947;
 i=ming.li@zohomail.com; s=20260210; h=from:subject:message-id;
 bh=G1lngwsewO3vMMBXZZYaCMdOW71S67BHaKXErodzQDc=;
 b=7udZP37gyhtay6Gy/RTcIYkEd8vLn789/CT3jTovoTRO74nVsJ5NoGExGPhna5YglpfEIZC8T
 fzxJqt6D6b8DGpKykys5qX8ZNdSAqjO+SwcJIrE9rFZfNh33Dpz/qYt
X-Developer-Key: i=ming.li@zohomail.com; a=ed25519;
 pk=JfhrdHjyYJMXt47Hy8d/fsqZuhGPD4Z3whV5lTfVvhE=
Feedback-ID: zu08011227c98390a8f9a33c8a86bb94ba0000974dcc8edfa80fa3c64b0da1f9d3534ab40e2f0db4e5cee3b4:ZohoMail
X-Zoho-CM-AccountID: abd763e7b9fa23acf4f42a44f9876d2d993e05abdb9290f9ccb1008c977bf7f0
X-ZohoMailClient: External

In cxl_cancel_auto_attach(), it assumes cxled->pos is a valid index for
accessing p->targets[]. However, cxled->pos can be set to negative errno
in cxl_region_sort_targets() if cxl_calc_interleave_pos() fails. This
causes the driver to use a negative index to access p->targets[],
resulting in out-of-bounds access.

Fix it by walking p->targets[] instead of using cxled->pos directly.

Fixes: 87805c32e6ad ("cxl/region: Fix use-after-free from auto assembly failure")
Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/core/region.c | 40 +++++++++++++++++++---------------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index cc41c08c0c0c..c4335ebf19f7 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2011,8 +2011,9 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
 		cxled->pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range);
 		/*
 		 * Record that sorting failed, but still continue to calc
-		 * cxled->pos so that follow-on code paths can reliably
-		 * do p->targets[cxled->pos] to self-reference their entry.
+		 * cxled->pos so that cxl_calc_interleave_pos() emits its
+		 * dev_dbg() for every member. which is useful for auto
+		 * discovery debug.
 		 */
 		if (cxled->pos < 0)
 			rc = -ENXIO;
@@ -2202,18 +2203,30 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 	return 0;
 }
 
-static int cxl_region_by_target(struct device *dev, const void *data)
+static int cxl_region_remove_target(struct device *dev, void *data)
 {
-	const struct cxl_endpoint_decoder *cxled = data;
+	struct cxl_endpoint_decoder *cxled = data;
 	struct cxl_region_params *p;
 	struct cxl_region *cxlr;
+	int i;
 
 	if (!is_cxl_region(dev))
 		return 0;
 
 	cxlr = to_cxl_region(dev);
 	p = &cxlr->params;
-	return p->targets[cxled->pos] == cxled;
+	for (i = 0; i < p->interleave_ways; i++) {
+		if (p->targets[i] == cxled) {
+			p->nr_targets--;
+			cxled->state = CXL_DECODER_STATE_AUTO;
+			cxled->pos = -1;
+			p->targets[i] = NULL;
+
+			return 1;
+		}
+	}
+
+	return 0;
 }
 
 /*
@@ -2222,25 +2235,10 @@ static int cxl_region_by_target(struct device *dev, const void *data)
  */
 static void cxl_cancel_auto_attach(struct cxl_endpoint_decoder *cxled)
 {
-	struct cxl_region_params *p;
-	struct cxl_region *cxlr;
-	int pos = cxled->pos;
-
 	if (cxled->state != CXL_DECODER_STATE_AUTO_STAGED)
 		return;
 
-	struct device *dev __free(put_device) =
-		bus_find_device(&cxl_bus_type, NULL, cxled, cxl_region_by_target);
-	if (!dev)
-		return;
-
-	cxlr = to_cxl_region(dev);
-	p = &cxlr->params;
-
-	p->nr_targets--;
-	cxled->state = CXL_DECODER_STATE_AUTO;
-	cxled->pos = -1;
-	p->targets[pos] = NULL;
+	bus_for_each_dev(&cxl_bus_type, NULL, cxled, cxl_region_remove_target);
 }
 
 static struct cxl_region *

-- 
2.43.0

