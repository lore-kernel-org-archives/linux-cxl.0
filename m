Received: from esa12.hc1455-7.c3s2.iphmx.com (esa12.hc1455-7.c3s2.iphmx.com [139.138.37.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F90259C
	for <linux-cxl@vger.kernel.org>; Wed,  3 Apr 2024 02:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.37.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712110753; cv=none; b=U7VRW5KgQGoEJ5O3uiyxFOXCE85oK2h2H/0dEK+tVG1qdNh8N+q+FGLiiQui+ZRlTYVRURRF6h9TrcxLHyftREfUI/KNvDsevz+fZHLruvDtllw+09acuWSKTo5EiBy1cw42zHdunq+4QXw8JgaN1qYsTmWs7Hd8r/gSmoxHaEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712110753; c=relaxed/simple;
	bh=eEoLhna9nu0VjLvfYj2N8bjP/fncLWudqhkngxUBcNA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gM5fZhHXQRWiOXJr36/20iYqtFizDy17+exr/ssJicnYkK5on55TWXj+V1qKkJEVrPvIgIohccOsisdINnMSgrPUuuNeXbQGTt+kEWRtxiaVevCrEjOIczthA2ha+mL7tIyr35y5MVFwrB7Y7DQzOHSUZPx2KgbRIPMTeJxdOno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=FjxGcNxn; arc=none smtp.client-ip=139.138.37.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="FjxGcNxn"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1712110751; x=1743646751;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eEoLhna9nu0VjLvfYj2N8bjP/fncLWudqhkngxUBcNA=;
  b=FjxGcNxnZAbh/T3DQzq1xDR8cSuh5W8gOF0KEnYCGjsyWyJNaLKnlOx/
   71+1tzAtmFIXHV/xH5JiReEy1AfPpHAqWdi/L6nUFChUW4Ds3QigKfPC6
   C4YcJWEVm5v2Rz/9g6v831FUK6tAlRZk27e1uC9pnQ44HqUth//vtX6yy
   QQ7MtW2Cph7b6fVYHLUBNpZC1RR1Og9iR6xejST3bMpFtIEoeVMVxLiKm
   nFHinRWgjtLJXLvxp9mIP9dtbfn7eb5DnqGRcqRammIVjJsJof4AK3gfg
   sO1ZgabDR5h+vtvvi0WM+Eqtnxg20qH6pvv8bGQondMzAfuxLlp0pqz0F
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="133739319"
X-IronPort-AV: E=Sophos;i="6.07,176,1708354800"; 
   d="scan'208";a="133739319"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa12.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 11:19:03 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 06AF7EB4D5
	for <linux-cxl@vger.kernel.org>; Wed,  3 Apr 2024 11:19:01 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 28F44D60E2
	for <linux-cxl@vger.kernel.org>; Wed,  3 Apr 2024 11:19:00 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
	by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id AE50D2030C7D6
	for <linux-cxl@vger.kernel.org>; Wed,  3 Apr 2024 11:18:59 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.225.88])
	by edo.cn.fujitsu.com (Postfix) with ESMTP id 211531A0002;
	Wed,  3 Apr 2024 10:18:59 +0800 (CST)
From: Yao Xingtao <yaoxt.fnst@fujitsu.com>
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	jim.harris@samsung.com
Cc: linux-cxl@vger.kernel.org,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>
Subject: [PATCH v2 1/2] cxl/core/hdm: rename interleave_mask to ig_cap_mask
Date: Tue,  2 Apr 2024 22:17:46 -0400
Message-Id: <20240403021747.17260-2-yaoxt.fnst@fujitsu.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20240403021747.17260-1-yaoxt.fnst@fujitsu.com>
References: <20240403021747.17260-1-yaoxt.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28294.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28294.004
X-TMASE-Result: 10-2.346300-10.000000
X-TMASE-MatchedRID: XFIvYd9rGT3gban0zxjeDrnHu4BcYSmtwTlc9CcHMZerwqxtE531VICu
	qghmtWfX/ylbX2Ykg6ZP3yS7iZW45x8TzIzimOwPruuVAw9Gg4LEQdG7H66TyHEqm8QYBtMOLwE
	PUTuntWyRuJNrGBcpYpVQHfPvMd4LuunMk2i8ylqfCRi1HUuueDVJFia2R3BWe4EWnRLT4GLJ4w
	+dheT3+Y+hNN6wyKXJW4wbpXTb5DJKKve1kh3RY37qSWrndbmQn0bOriG5BVc=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0

Since interleave contains interleave ways and interleave granularity,
using ig_cap_mask is better to describe this capability.

Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
---
 drivers/cxl/core/hdm.c | 4 ++--
 drivers/cxl/cxlmem.h   | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 7d97790b893d..9bb6a256cc6f 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -76,9 +76,9 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
 	cxlhdm->target_count =
 		FIELD_GET(CXL_HDM_DECODER_TARGET_COUNT_MASK, hdm_cap);
 	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_11_8, hdm_cap))
-		cxlhdm->interleave_mask |= GENMASK(11, 8);
+		cxlhdm->ig_cap_mask |= GENMASK(11, 8);
 	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_14_12, hdm_cap))
-		cxlhdm->interleave_mask |= GENMASK(14, 12);
+		cxlhdm->ig_cap_mask |= GENMASK(14, 12);
 }
 
 static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 20fb3b35e89e..b53f7ae0fdd6 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -852,7 +852,7 @@ struct cxl_hdm {
 	struct cxl_component_regs regs;
 	unsigned int decoder_count;
 	unsigned int target_count;
-	unsigned int interleave_mask;
+	unsigned int ig_cap_mask;
 	struct cxl_port *port;
 };
 
-- 
2.37.3

