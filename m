Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0098D20323
	for <linux-cxl@vger.kernel.org>; Wed, 23 Oct 2024 01:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729647843; cv=none; b=NXQkhkxqHXGNJLjVVvyurv8/ho+eph2twAiDgxNYXi/UTRe1zGIrhPNMchCYmU0EgvSDWqZnKoqEXrJq1568Oq0B033vbRQjfa/JSAW32M8PRiHBx1MkFD8dnQCEb6a3RNDKw9213BqNqbxIzPUnXsnov6hlh8nHKYlvB9p68RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729647843; c=relaxed/simple;
	bh=dnQwbUB68OkA+2eKZ7BUN1fY2s+v4Sxk//VQ3Ml6v1I=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eu0/u1QNsow5NPAvWtYjxx/ecPk9fB3LhPHX7OEuOw6nGvAmgBwc1PJQcT3SAideP9DlBsL4R4mDffD95Jee/TKcPzbf0fbj85qTYICTQAwqRZvnzPFQOyo2/XOBeNq8SdQF8FGZV1PttGnuC9Apk0DcULeyEZ2OKvTWe+K5PCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R58uUQj+; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R58uUQj+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729647842; x=1761183842;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dnQwbUB68OkA+2eKZ7BUN1fY2s+v4Sxk//VQ3Ml6v1I=;
  b=R58uUQj+8ht4WNx9FpUx8cckINUGxnnD+XSxJ3tcj7h7aW1kyY5LW+CH
   iwAjZ3C793bFQschko/GKQGhy4P7iykZHDujAU6BgXcxa0Z/BVy8joiL7
   r+xsMlFxjsBklVrIyZyqQSXiYQmCpnDwa3vkFco3v73mtebaxQhRqSXfl
   T1C807gcfU5B3WtbSXLTCEzQOuoixBZQkkp8lpHMqfZ5vi9KEU+5S8mqX
   8sqSKzyNWOSF5M8oE6Bs6bpPKqnY47l8Co2i+x/hiUfLJQt51jH5WxfMH
   o2U1M78gTyVEildd5Ek/fR6JOp+tXxm6vs+Jf1n6YjbrM8jOCleSv0GOD
   g==;
X-CSE-ConnectionGUID: aL+blriDQiuJbmbM2vtYIA==
X-CSE-MsgGUID: D4/iOe9BSnytcGWQ0UWY4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="46675957"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="46675957"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 18:44:01 -0700
X-CSE-ConnectionGUID: 0gf9+tbsQgmb/GWw+EUyWw==
X-CSE-MsgGUID: F+6dFQgtRa2k5GKPgKSwUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,223,1725346800"; 
   d="scan'208";a="110844073"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.125.110.222])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2024 18:44:00 -0700
Subject: [PATCH v2 5/6] cxl/port: Prevent out-of-order decoder allocation
From: Dan Williams <dan.j.williams@intel.com>
To: ira.weiny@intel.com
Cc: Zijun Hu <quic_zijuhu@quicinc.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, dave.jiang@intel.com,
 linux-cxl@vger.kernel.org
Date: Tue, 22 Oct 2024 18:43:57 -0700
Message-ID: <172964783668.81806.14962699553881333486.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <172964779333.81806.8852577918216421011.stgit@dwillia2-xfh.jf.intel.com>
References: <172964779333.81806.8852577918216421011.stgit@dwillia2-xfh.jf.intel.com>
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

Reported-by: Zijun Hu <quic_zijuhu@quicinc.com>
Closes: http://lore.kernel.org/20240905-const_dfc_prepare-v4-0-4180e1d5a244@quicinc.com
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Vishal Verma <vishal.l.verma@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
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

