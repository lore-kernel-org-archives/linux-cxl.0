Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA85B79DF
	for <linux-cxl@vger.kernel.org>; Fri, 26 Jan 2024 04:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706244927; cv=none; b=M+UHYBEFFVRe/ISd0frB2Kyv2DNH4eVYEwALNKsmxudX/VINEGXbxKKB5nmh2xbktRAtw76zgv0LmaSxPqEhlIUvdSp/BgUUeU83mvMu5jSB5UxdC4B9NbODPrkoRqqHdreSulkDD20arxZCviPy5ppsV5OLxh4U5aEc0iY4GJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706244927; c=relaxed/simple;
	bh=2LfPdGJq1fjJpfR3abyAWkqeDinIMTR6GKvN+/u7CQs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Nf34d5AaH4dQ+rSn9kSbQe2Ncgn6DiFLnuiVQ/zinYKplLWdPwhKCX+Kl/h+0laXMAK35or/jbgUVEHr0ZFiJEbp/KUfUSWl3mgZHQY5OStmHfIAUuF+PAxmEEXylB5xzzyVkfu8WnJ8K8XYr+x3VUswO8ZxJSCpqvzPIhCbQpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uy96Mf0I; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uy96Mf0I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706244926; x=1737780926;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2LfPdGJq1fjJpfR3abyAWkqeDinIMTR6GKvN+/u7CQs=;
  b=Uy96Mf0IcnggeUMts1gizj6G7ECSF20HyFB8Lwonq5fuMmgyeAJ/kHCD
   OZFpnqAPq0a83rA4T87U/hOzsjQ8GnjAFq+BJ754IIW4L79CTxbKKUwNU
   IhuK+NcvzuFtF8nvCG90P1DtzuG9OhoqphGC6PO3z4HcEVxCZZ1Nl9toX
   4u8s56chhsECFuxPaqukMi0Rn+DJ+2oaVlGYvfkj6Bw3WsME5Huk/t193
   LfeYYead5LfllOSUEAZguWMnlnubj29voE45PQweqfFw27lGBq5jyJVTT
   7W2NSUFWgcDoNoQTGxRw+VrKmJxMp1VuuaP3TOLS65QNXfr0NDvJTHMgi
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="9071201"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="9071201"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 20:55:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10964"; a="877283279"
X-IronPort-AV: E=Sophos;i="6.05,216,1701158400"; 
   d="scan'208";a="877283279"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.176.40])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2024 20:54:53 -0800
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org,
	Neha Agrawal <neha.agrawal@intel.com>
Subject: [PATCH] cxl/region: Allow out of order assembly of autodiscovered regions
Date: Thu, 25 Jan 2024 20:54:46 -0800
Message-Id: <20240126045446.1750854-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

Autodiscovered regions can fail to assemble if they are not discovered
in HPA decode order. The user will see failure messages like:

[] cxl region0: endpoint5: HPA order violation region1
[] cxl region0: endpoint5: failed to allocate region reference

The check that is causing the failure helps the CXL driver enforce
a CXL spec mandate that decoders be committed in HPA order. The
check is needless for autodiscovered regions since their decoders
are already programmed. Trying to enforce order in the assembly of
these regions is useless because they are assembled once all their
member endpoints arrive, and there is no guarantee on the order in
which endpoints are discovered during probe.

Keep the existing check, but for autodiscovered regions, allow the
out of order assembly after a sanity check that the lowered numbered
decoder has the lower HPA starting address.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Tested-by: Neha Agrawal <neha.agrawal@intel.com>
---

Changes since RFC:
- Declare auto_order_ok() as static (lkp)
- Add Tested-by tag (Neha)
Link to RFC: https://lore.kernel.org/linux-cxl/20240113050421.1622533-1-alison.schofield@intel.com/


 drivers/cxl/core/region.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 0f05692bfec3..f6a49fd01ae9 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -753,6 +753,37 @@ static struct cxl_decoder *cxl_region_find_decoder(struct cxl_port *port,
 	return to_cxl_decoder(dev);
 }
 
+static bool auto_order_ok(struct cxl_port *port, struct cxl_region *cxlr_a,
+			  struct cxl_region *cxlr_b)
+{
+	struct cxl_region_ref *cxl_rr;
+	struct cxl_decoder *cxld_a, *cxld_b;
+
+	/*
+	 * Allow the out of order assembly of auto-discovered regions as
+	 * long as correct decoder programming order can be verified.
+	 *
+	 * Per CXL Spec 3.1 8.2.4.20.12 Committing Decoder Programming,
+	 * software must commit decoders in HPA order. Therefore it is
+	 * sufficient to sanity check that the lowered number decoder
+	 * has the lower HPA starting address.
+	 */
+	if (!test_bit(CXL_REGION_F_AUTO, &cxlr_a->flags))
+		return false;
+
+	cxld_a = cxl_region_find_decoder(port, cxlr_a);
+	cxl_rr = cxl_rr_load(port, cxlr_b);
+	cxld_b = cxl_rr->decoder;
+
+	if (cxld_b->id > cxld_a->id) {
+		dev_dbg(&cxlr_a->dev,
+			"allow out of order region ref alloc\n");
+		return true;
+	}
+
+	return false;
+}
+
 static struct cxl_region_ref *alloc_region_ref(struct cxl_port *port,
 					       struct cxl_region *cxlr)
 {
@@ -767,7 +798,8 @@ static struct cxl_region_ref *alloc_region_ref(struct cxl_port *port,
 		if (!ip->res)
 			continue;
 
-		if (ip->res->start > p->res->start) {
+		if (ip->res->start > p->res->start &&
+		    (!auto_order_ok(port, cxlr, iter->region))) {
 			dev_dbg(&cxlr->dev,
 				"%s: HPA order violation %s:%pr vs %pr\n",
 				dev_name(&port->dev),

base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
-- 
2.37.3

