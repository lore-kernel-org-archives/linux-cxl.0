Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB26A920
	for <linux-cxl@vger.kernel.org>; Tue, 15 Oct 2024 00:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728950809; cv=none; b=SJPK4x7E2ha8RJrYUVCJgro2Ses3fvPHl0yavg2zrSK0O4Z6yM+oWqo0vlm+Jq012NvEhEutTtCy2Tqz59uSmei6hkQqfaA2SOR6b7aYTXBZl0ohhr1E/HCXG9L/RWFXQUvHexynroT4LpL+nCE2eKm1oVHjd4VQ5zYV0UKXUIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728950809; c=relaxed/simple;
	bh=pPFUA4Pu5oXH6I8ccGwkiCg8aaiJuDpzY9ijNQ8ACAw=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=M5vT8J36MbMq6ZVyOt8SzW58v+t1IWMqdxTOnkqpcT1XmFggY62vgvbswXv0Pflw9CkwogKtJ1eIoZuzWnha3cJ03qvyzdsX2EqROG7gGIPepQl+8BiL660it4X0OHI6eVb4BPltarEjGKnDavmqMnRMv/OSIZOdumhubU/pJIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i+IN4DRB; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i+IN4DRB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728950807; x=1760486807;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pPFUA4Pu5oXH6I8ccGwkiCg8aaiJuDpzY9ijNQ8ACAw=;
  b=i+IN4DRB5KRAIahH2/AX6mWBsfq2aKOKa50VrIWJzHn/tBh0Ge9zBt6z
   vYYkBo3YFWj9jaxYJ+hz3yJ+33vqyXftjkLgo1mn2Oprf7INTm2QUax0i
   ses/VJxVamkPUjk42nnmW2q5fMF6BPy6y5fV2ZyGlJfdyGxG2O+ItgzEv
   3r2fBGrV6vU6pQQkoUPMMKcWmkVKp0li5ru7g7z0TiLqhpXKpCxk4kART
   oeO3xlHLVqimjYXEDXdz6Y5yn9mLODMlt0cRk+Pbt6kC+bpxqk0X3KupW
   2laxurROngmuX0j8gItmk/H3yrTAabTqASKot/7UuhXHOWYGP3H7MXLPB
   A==;
X-CSE-ConnectionGUID: P1hmq7qFSBe42Ds1B0azTA==
X-CSE-MsgGUID: 2+HZvi3hRDaXMsoNKSrNsg==
X-IronPort-AV: E=McAfee;i="6700,10204,11225"; a="32120244"
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="32120244"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 17:06:46 -0700
X-CSE-ConnectionGUID: Dl9gtFN4SMqxGmjq7SXgXg==
X-CSE-MsgGUID: qTIvHabAQvufc4q3ruAKjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,203,1725346800"; 
   d="scan'208";a="108465620"
Received: from cmdeoliv-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.108.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 17:06:46 -0700
Subject: [PATCH] cxl/port: Prevent out-of-order decoder allocation
From: Dan Williams <dan.j.williams@intel.com>
To: dave.jiang@intel.com, ira.weiny@intel.com
Cc: Zijun Hu <zijun_hu@icloud.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, linux-cxl@vger.kernel.org
Date: Mon, 14 Oct 2024 17:06:44 -0700
Message-ID: <172895072669.39002.9296583943188706348.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

With the recent change to allow out-of-order decoder de-commit it
highlights a need to strengthen the in-order decoder commit guarantees.
As it stands match_free_decoder() ensures that if 2 regions are racing
decoder allocations the one that wins the race will get the lower id
decoder, but that still leaves the race to *commit* the decoder.

Rather than have this complicated case of "reserved in-order, but may
still commit out-of-order", just arrange for the reservation order to
match the commit-order. In other words, prevent subsequent allocations
until the last reservation is committed.

This precludes overlapping region creation events and requires the
previous regionN to either move forward to the decoder commit stage or
drop its reservation before regionN+1 can move forward. That is,
provided that regionN and regionN+1 decode through the same switch port.

As a side effect this allows match_free_decoder() to drop its dependency
on needing write access to the device_find_child() @data parameter [1].

Reported-by: Zijun Hu <zijun_hu@icloud.com>
Closes: http://lore.kernel.org/20240905-const_dfc_prepare-v4-0-4180e1d5a244@quicinc.com [1]
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
This patch is incremental to "cxl: Initialization and shutdown fixes"

[2]: http://lore.kernel.org/172862483180.2150669.5564474284074502692.stgit@dwillia2-xfh.jf.intel.com

 drivers/cxl/core/region.c |   43 +++++++++++++++++++++++++++++++++----------
 1 file changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 3478d2058303..dff618c708dc 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -778,26 +778,50 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
 	return rc;
 }
 
+static int check_commit_order(struct device *dev, const void *data)
+{
+	struct cxl_decoder *cxld = to_cxl_decoder(dev);
+
+	/*
+	 * if port->commit_end is not the only free decoder, then out of
+	 * order shutdown has occurred, block further allocations until
+	 * that is resolved
+	 */
+	if (((cxld->flags & CXL_DECODER_F_ENABLE) == 0))
+		return -EBUSY;
+	return 0;
+}
+
 static int match_free_decoder(struct device *dev, void *data)
 {
+	struct cxl_port *port = to_cxl_port(dev->parent);
 	struct cxl_decoder *cxld;
-	int *id = data;
+	int rc;
 
 	if (!is_switch_decoder(dev))
 		return 0;
 
 	cxld = to_cxl_decoder(dev);
 
-	/* enforce ordered allocation */
-	if (cxld->id != *id)
+	if (cxld->id != port->commit_end + 1)
 		return 0;
 
-	if (!cxld->region)
-		return 1;
-
-	(*id)++;
+	if (cxld->region) {
+		dev_dbg(dev->parent,
+			"next decoder to commit (%s) is already reserved (%s)\n",
+			dev_name(dev), dev_name(&cxld->region->dev));
+		return 0;
+	}
 
-	return 0;
+	rc = device_for_each_child_reverse_from(dev->parent, dev, NULL,
+						check_commit_order);
+	if (rc) {
+		dev_dbg(dev->parent,
+			"unable to allocate %s due to out of order shutdown\n",
+			dev_name(dev));
+		return 0;
+	}
+	return 1;
 }
 
 static int match_auto_decoder(struct device *dev, void *data)
@@ -824,7 +848,6 @@ cxl_region_find_decoder(struct cxl_port *port,
 			struct cxl_region *cxlr)
 {
 	struct device *dev;
-	int id = 0;
 
 	if (port == cxled_to_port(cxled))
 		return &cxled->cxld;
@@ -833,7 +856,7 @@ cxl_region_find_decoder(struct cxl_port *port,
 		dev = device_find_child(&port->dev, &cxlr->params,
 					match_auto_decoder);
 	else
-		dev = device_find_child(&port->dev, &id, match_free_decoder);
+		dev = device_find_child(&port->dev, NULL, match_free_decoder);
 	if (!dev)
 		return NULL;
 	/*

