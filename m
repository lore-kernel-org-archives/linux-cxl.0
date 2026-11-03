Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793725638;
	b=Djt095kp1kK2R9HAySkdZyVK30AicxqF/Xn7DE0NztiPkzTPR01n28+/eAw34JEELApy
	 85/nN8bZQoGB+vTuIOX0hyI5toYPmUCOy8UqdaA8OWpL8NFwcGPHR9Dr23Katp5K7ZFSv
	 LtwapIbLaEitfOCUnmSDsqCu74gvTPki2hzJBzBRPAtmY+n0WVzQd3uKu4dp/zAoHQ2By
	 HOZitYlqfyZIZJrnDUTcZ4a1cgQ/CUnSfav8d1W9GaNh8fvypUqFO45eUEMWVhtJhdo0K
	 E+yrO6oNxs9SSofL0Tt/qcIONpOOJdIAYLIZTO9myE2/C3TTJfglXpTrnajMByC1b6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793725638;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=soUqgNMBMaNwCnv1Ygl295Wq1hGl/yZ2EMQ7+z2zSjw=;
	b=ADZUIo8+TMNrAu37EmuxJrPLBtGsLZABzJoa36eaAYukBtXSLYeXA/cBfcDUatqsFvTr
	 1mg7AjZMIK7Ob2q8R/30r4+3H7UFDGfAnlS2uDU9zs+TofjtIkgIp5HdaZvxM1zoQARQc
	 WVF1d+0dCMSjhKrvF0CpzLQ+w6MxhywTg5bbAt9mM9yVIGv1Gi9vR4i7u4zMPr3rbP+yn
	 l+rdavGGV34JZu+kR3PyWvxVaX2gNxhDU7CpZds2gikyrGoOZYTNLPjI6jCuFORyueIA5
	 iNKqF0gqaEp1vmJqcj1dzbs9/O9zkW1vuQopv5CW/Lwep+RxpvKQPktdA63szIhyNSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KWdW4Sr8;
	arc=none smtp.remote-ip=192.198.163.14
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D073E606A324
	for <linux-cxl@vger.kernel.org>; Tue,  3 Nov 2026 17:07:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D073E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=KWdW4Sr8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793725637; x=1825261637;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gKazfT0dHw+8AnR71DZ1wabM0Li0glKBP52UBxW5tHE=;
  b=KWdW4Sr86wHlGIMOIQpYozX6SPmmaPlqmXdNvEOMeBGbcGytPaq+3DZr
   hmkPcN6KkmTObETJqi4R2axki7OqRu+jaEa5IIQm7fUyvSw/tpyulSgXJ
   h+GD5NkOTUoobZ14pT8pIt6lZtBfKruykumbRizaErSzrlMeQ8ZOCr1Pz
   Va/TNLI+7F89atF8zROfc75kHP0PF7CMM+AC01JA8zng5dN3H7qxeeodU
   u88eZOgDMRBSLuEdCb+W4JBRxfQdUXetBWw4Vwh1cAkkKM6vO3axHY741
   956PjPqZrX864DAdCg1E7LpYIKqRgEGKUcetxU9kwZPr5SlLTcd4NH1+y
   g==;
X-CSE-ConnectionGUID: bnd9gQhrRz+EoMWf6A/Oyg==
X-CSE-MsgGUID: 7y85ITrITrOXV9FRCCjmNw==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2489313"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2489313"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 09:07:16 -0800
X-CSE-ConnectionGUID: zW9OcsoxSYa6VZbndW2a1g==
X-CSE-MsgGUID: /dwdc/FmQISeJZEBFAV52Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="6334151"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.109.242])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2026 09:07:16 -0800
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
Subject: [PATCH v4 1/2] cxl/region: Reject a repeat write of an endpoint decoder to targetN
Date: Tue,  3 Nov 2026 09:07:10 -0800
Message-ID: <e8235faea3d75dbfd45f197fe657c467b6259705.1793724885.git.alison.schofield@intel.com>
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

An existing check recognizes the repeated assignment but incorrectly allows
the attachment to proceed, damaging region state. Remove that check so the
repeated write is rejected without disturbing the existing attachment,
consistent with the documented targetN ABI.

Fixes: 9995576cef48 ("cxl/region: Move region-position validation to a helper")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

Note: cxl_region_perf_data_calculate() currently updates region performance
data before attachment validation completes. This is a pre-existing issue
that will be addressed separately.

Changes in v4:
- Drop the added useless check in cxl_region_attach() (Sashiko)
  The pre-existing occupied position check already returns -EBUSY.
v3: https://lore.kernel.org/linux-cxl/3e5af9d6d59f8df52b9d21bcf1c7e78f06918f80.1793653629.git.alison.schofield@intel.com/

Changes in v3:
- Reject repeat writes with -EBUSY, consistent with the documented ABI
- Rebase on 7.4-rc1
v2: https://lore.kernel.org/linux-cxl/920d80735a449f93a1f17a8bca4c25e4b302cb42.1792989098.git.alison.schofield@intel.com/

Changes in v2:
- Preserve the successful no-op behavior for repeated writes (Jonathan)
- Correct the Fixes tag
v1: https://lore.kernel.org/linux-cxl/94e9157aac2e99df1251d733769d539b914fdefc.1790829690.git.alison.schofield@intel.com/
---
 drivers/cxl/core/region.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index a048bd5c06cb..f42c6b6e3213 100644
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

base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.37.3

