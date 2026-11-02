Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793654383;
	b=rm3QYwjWrmqEVWJzmgh9hthYsnWd/jeSmK6UcCbKEs86F0lAvghMmml6oWHe09NrTTu9
	 x7DXbgVpIaVFQsQZ5GVbVInjcNLatlrkQXM9mSPK3AxXa4utGzhz2azauzPwTnGHVSCEn
	 gUic7h3XNZYTA3bPhu9fQDofZd2hwpsRfQ0ocVCcFLe6HlICl0bq3yMnerl1QQNCE0GAl
	 EiJEGjkqNSU3MyNq/Oll0S6PwhXppYakcX6iCdvXQcmeyAyPQL2Fyb/jO9wKQw6FCBtLQ
	 MJncSwuNoXeCPj5FTT00m/i+EBDbS6wFUE659e6ppVzmZBlzaLxDWy/qK6gMTd9bCsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793654383;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=QulupLz4ZjPKY3lr/PuFBSP6cKkVSxsyMSlXegfcKG8=;
	b=MAuMU2DgsG33hskgcst6dlJ1X7ltCA3Kr+iyZ9KqGUHGU+RAiW3cit9Zj2jRDa/K44Y+
	 GIlRFtfWsJb/3mVdoKoBqWAO9S6lDg/6MzGAnqn+deLYOOEGLVe2QWjDW863cnj0GxF28
	 oAvJowUS/xl0RlM4SlBXUWa3Axua5b3gTDuaV6/EHa8sIgIcLMysSuQfQjVS1S8Q7BTgm
	 5u6aCtDuXGzcGNwkupbmtcwt5MBmSKxEki2Oxq/Johrkb04P8UTBO64e5smY8j+MVOYQz
	 42PWNZKY+cGcpIb5V8xvOyU7UGujaAdmX6vydwkc4OckLfvOMaOmoMgspWNXwbdZtmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OaHCALJ0;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5512E606A326
	for <linux-cxl@vger.kernel.org>; Mon,  2 Nov 2026 21:19:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5512E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=OaHCALJ0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793654383; x=1825190383;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ob9F+id1/Z4V9R2SiZNgo2nI+Z+z+JHcTREoQcoZxDY=;
  b=OaHCALJ0iCwko7EwabWGrx/4aXDYz7Mgw+G6TmII4hlpe96stx7jRVuO
   TQcV4OzddFeJbC8Vd8jcJAbk1yCS/atzdnF0sbfi5WdRR1Cx4UfLwqAJb
   1nEvFbJjMU+hWASfgxvpGZolxJGh2MV9gFK68nE+sRmczyUXZohMiY/6u
   jfx2Eec/pJInHZ4G30hLOgcP/ZEIfe82ikOy2tf1wVwNdxs7L3i3knn1H
   fFFhzrVRQaGcQz+pI9cF5Ee/qYG/nXP+7+B2o0ZjlSrqSHDGGRHBKKjRp
   GFKZQ4TO75mfOsIVe99RzjrTL1h/SxBdOzzSZ1r11Np8gEWkf5a7Gdb50
   w==;
X-CSE-ConnectionGUID: qn5LpOlsS6m/glU2E1g0+w==
X-CSE-MsgGUID: MGH7WKwHQQGb4vHmzRpbnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2242574"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2242574"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 13:19:42 -0800
X-CSE-ConnectionGUID: i8jZtokqSmCDfg//Z+wXYw==
X-CSE-MsgGUID: v6KHUasiTT6qY/Cp/YZECQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="8062468"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.109.173])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 13:19:41 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v3 1/2] cxl/region: Reject a repeat write of an endpoint decoder to targetN
Date: Mon,  2 Nov 2026 13:19:36 -0800
Message-ID: <3e5af9d6d59f8df52b9d21bcf1c7e78f06918f80.1793653629.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Writing an endpoint decoder to a region targetN attribute that already
holds it returns -EBUSY, but leaves the partially populated region in an
inconsistent state. The targetN attribute still names the decoder, so the
failed write gives no indication that the region was damaged.

Filling the remaining target positions can then trigger a NULL pointer
dereference in cxl_region_setup_targets(). This can be reproduced through
sysfs:

    echo $decoder > /sys/bus/cxl/devices/region0/target0
    echo $decoder > /sys/bus/cxl/devices/region0/target0
    echo $other_decoder > /sys/bus/cxl/devices/region0/target1

An existing check recognizes when the decoder already occupies the
requested position, but does not prevent the attachment from proceeding
and modifying region state.

Move the check ahead of the attachment work, so a repeat write fails with
-EBUSY without modifying region state. The targetN ABI documents EBUSY for
an occupied position and makes no exception for writing the same decoder.

Fixes: 9995576cef48 ("cxl/region: Move region-position validation to a helper")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

Note: cxl_region_perf_data_calculate() currently updates region performance
data before attachment validation completes. This is a pre-existing issue
that will be addressed separately. This patch places the repeated-write
check before that call, so the issue does not affect this fix.

Changes in v3:
- Subject line back to v1's 'Reject a repeat write of an ...'
  v3 rejects again, but before any region state is modified
- Fail a repeat write with -EBUSY, as the original ABI documents
- Rebase on 7.4-rc1
v2: https://lore.kernel.org/linux-cxl/920d80735a449f93a1f17a8bca4c25e4b302cb42.1792989098.git.alison.schofield@intel.com/

Changes in v2:
- New Subject line. v1 as 'Reject a repeat write of an ...'
  v2 does not reject, it treats as no-op and protects region state
- Keep repeat write as a no-op instead of failing with -EBUSY (JonathanC)
- Check before the decoder's bandwidth is added to the region
- Correct the Fixes tag
v1: https://lore.kernel.org/linux-cxl/94e9157aac2e99df1251d733769d539b914fdefc.1790829690.git.alison.schofield@intel.com/
---
 drivers/cxl/core/region.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index a048bd5c06cb..90226327e03c 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1764,9 +1764,6 @@ static int cxl_region_validate_position(struct cxl_region *cxlr,
 		return -ENXIO;
 	}
 
-	if (p->targets[pos] == cxled)
-		return 0;
-
 	if (p->targets[pos]) {
 		struct cxl_endpoint_decoder *cxled_target = p->targets[pos];
 		struct cxl_memdev *cxlmd_target = cxled_to_memdev(cxled_target);
@@ -2130,6 +2127,14 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		return -EINVAL;
 	}
 
+	/* Already at @pos: fail before changing any region state */
+	if (pos >= 0 && pos < p->interleave_ways && p->targets[pos] == cxled) {
+		dev_dbg(&cxlr->dev, "position %d already assigned to %s:%s\n",
+			pos, dev_name(&cxlmd->dev),
+			dev_name(&cxled->cxld.dev));
+		return -EBUSY;
+	}
+
 	cxl_region_perf_data_calculate(cxlr, cxled);
 
 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.37.3

