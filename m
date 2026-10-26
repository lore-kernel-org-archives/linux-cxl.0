Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793031417;
	b=Ofs70/gg/coXk8b6oj/ypX8SxvoMRfTrlR+BW9O0z7pwVx4Gn9jSh/7wLWlSIxIRXwbA
	 uhYhVdayV3kLMrus/VfbRHiimkFDErycQgpqsdIq0MoXki0pGK1wuM6nTcyOKZVBhNURe
	 0YDGC6NEb5e1E9fB4FGbsVpQrIPDguLVnEeApgCY5VJb2tTpvsYbw9s98DCBMRVip/7at
	 M/fQKefaYomz6xQx3uERLIBEPx6NfGsOBT0Q9gToq8Ox1aogAoHH2U1OHDkePbiOOfdBI
	 VV45xfkKpVf+d2etLbHe/JidcMXQDM67jp2Knx0I7pV0+J1RfaGzanEQ/B/qEAzk6kQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793031417;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=arpjRbxdnmmxb/aan486N0H/jPdeO6nnzh8vWm2YbyQ=;
	b=Mv/vK0U6H88lHrP36emHmoRbLXOVvLAki0nV5H6q5SR2cZMcR5NgmoFgg/ieGjR8AS0D
	 s8jhHAYn/HOygKyQ2a0ni34IScGO7YVxNhPPdfSWYlTV99JqAT81VOkB7dJHBcbSIdrao
	 Xb8lbbcP6yZfPQiBt3vdax3DysOt+pV0ArGdiVwxsCV3/xNtA40KiWHKI1bba5ejmbRXf
	 RPd8atrh+fcOjeacdzz1n9xWYBrE8rly2l2y4ERE5KSapBkX5MI3VLJouGilx2D8XinNZ
	 I8GJyc1s2tqIPU35dLW+s9S1R/QDtWZZcUjhgKIDkpDielTgjYzEkjMzvvyxP1sxMcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HVYMMTfY;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5D2606A31A
	for <linux-cxl@vger.kernel.org>; Mon, 26 Oct 2026 16:16:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D5D2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=HVYMMTfY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793031416; x=1824567416;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UtBbY8D2koZwy0cAGZputCtYn1WcSNPO33gCintjFY8=;
  b=HVYMMTfYVMwsWlz82b7/PZ7A5lRb4PRjppumJAEQy7zrhYDYlxveSXir
   vUWiWp/o5q+WS5870CouwKLTsDytKWV1nlrsk7ODdaWV+Jkve0e4tO631
   iCf5003xktRyaz9X3ropFdZK1ROnUUnoquje3vq+FACXW08DCzWkFdRYx
   iHPg+dgojPJF9rzgLUsHxwbga9fAfYwl9hwkkuRIGcOC+vbq00I8su1Xg
   /kbKF5kf0VBZGH3KQDpR2tdk3DoQtB/Nd8eGGYE7+JSJDXSO6yvcgmcFF
   vHsPALViq3VnF+bSVeBAPLtg6WtiGJ2R5lg9OI/A5HbMgYVtplKs10o5w
   A==;
X-CSE-ConnectionGUID: S0R0+DE+QZ6tTWYWmZg7sA==
X-CSE-MsgGUID: e1720PzpRPyUNlUHx8dnEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1739125"
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="1739125"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 09:16:55 -0700
X-CSE-ConnectionGUID: N6lymEtiSgaYHhNnqU+tRg==
X-CSE-MsgGUID: TZzw6ggiQoWtNOjS16frtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,179,1787036400"; 
   d="scan'208";a="4214805"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.108.117])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2026 09:16:54 -0700
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
Subject: [PATCH v2 1/2] cxl/region: Make repeated targetN writes no-ops
Date: Mon, 26 Oct 2026 09:16:49 -0700
Message-ID: <920d80735a449f93a1f17a8bca4c25e4b302cb42.1792989098.git.alison.schofield@intel.com>
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

Move the check ahead of the attachment work, so a repeat write succeeds
as a no-op without modifying region state.

Fixes: 9995576cef48 ("cxl/region: Move region-position validation to a helper")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

Note: cxl_region_perf_data_calculate() currently updates region performance
data before attachment validation completes. This is a pre-existing issue
that will be addressed separately. This patch places the repeated-write
no-op check before that call, so the issue does not affect this fix.

Changes in v2:
- New Subject line. v1 as 'Reject a repeat write of an ...'
  v2 does not reject, it treats as no-op and protects region state
- Keep repeat write as a no-op instead of failing with -EBUSY (JonathanC)
- Check before the decoder's bandwidth is added to the region
- Correct the Fixes tag

v1: https://lore.kernel.org/linux-cxl/94e9157aac2e99df1251d733769d539b914fdefc.1790829690.git.alison.schofield@intel.com/
---
 drivers/cxl/core/region.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 27e63e6dab7c..c8dbd9b29899 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1762,9 +1762,6 @@ static int cxl_region_validate_position(struct cxl_region *cxlr,
 		return -ENXIO;
 	}
 
-	if (p->targets[pos] == cxled)
-		return 0;
-
 	if (p->targets[pos]) {
 		struct cxl_endpoint_decoder *cxled_target = p->targets[pos];
 		struct cxl_memdev *cxlmd_target = cxled_to_memdev(cxled_target);
@@ -2128,6 +2125,10 @@ static int cxl_region_attach(struct cxl_region *cxlr,
 		return -EINVAL;
 	}
 
+	/* Already at @pos: succeed before changing any region state */
+	if (pos >= 0 && pos < p->interleave_ways && p->targets[pos] == cxled)
+		return 0;
+
 	cxl_region_perf_data_calculate(cxlr, cxled);
 
 	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {

base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.37.3

