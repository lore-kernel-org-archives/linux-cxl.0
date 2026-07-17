Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EF032B130
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jul 2026 21:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784324583; cv=none; b=dV5JQlOSAHg+6ZJeYXB9BGv0MvTrecF9xSp+bKroQP00cAPy8yHraastxThP0j6zvbtnFIYgT9tXLwxDBztQMzwXf14R7/n4E9cHqcFjSDOsxwICPccL2S6JFLSpjOA5ilQyGbCSmcBytzbfOY2/R0D06KqoT4LxNXracl47LPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784324583; c=relaxed/simple;
	bh=vaXazQEC+FcJ0bAcacfxCxOcYfPKyYqS4a/Wz6DLGzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HuUJf9vng4/3ni/YjLANVF4A8Srglp1n987L25wuVDDbDj23HMPCBEJAjPnHckiEHojQRKsYIwfb8MZfv3wfEfYa/x+JlJzepRPA4CvraEj3t30k40VZnFqkcsRbOUsYUOnxGwhvjRoqv0xTG+6kT7eWbFDU3/dMdj3n2Bwbh68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jliJameb; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jliJameb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784324582; x=1815860582;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vaXazQEC+FcJ0bAcacfxCxOcYfPKyYqS4a/Wz6DLGzk=;
  b=jliJamebxWIDGErUh56eV2CrW/uuYHJCET5KsVUEcCHAydnvWVjKnizC
   xPYYsnr4dG6t/IhOjrYcyTLzEQno27l5K3EWIPlc/9iIsFoucZ74uZEWm
   AJ0Uy7GB5yDUhFnnQzBVRlieFBI4eWFQWEPM44x4midIaI/AvfMiwYGcS
   eTYZDZhK1Vkkp7AP9Kh/VOtQdgb0DSC5kQfYvVaqJg3p2yK+XmryAVVA2
   AzmQytXWw8QbeI95fkOQ/2G0xbilt7434Z9vlbV8w70J84b2zc1T4JduY
   /TA2No5gpF/7K0JVaMheIYSm8VgVti+lNWn5EGFuc0ZqVrZt05woN3RAL
   g==;
X-CSE-ConnectionGUID: lDj0VCHDQYyRahLNSuBXdw==
X-CSE-MsgGUID: VT4R45ncSxuelO6WIyvj5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="84129153"
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="84129153"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 14:43:02 -0700
X-CSE-ConnectionGUID: pJ5B72OwRtSme53vrk79oQ==
X-CSE-MsgGUID: X3h8py/8R9ikBiL4dZyrFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="261161261"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.59])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 14:43:02 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v3 2/3] cxl/hdm: Make switch decoder target parsing endian-safe
Date: Fri, 17 Jul 2026 14:42:47 -0700
Message-ID: <c09d201db3b716a6a9c664ccb8ff7fd9dc67b562.1784322343.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1784322343.git.alison.schofield@intel.com>
References: <cover.1784322343.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch decoder target IDs are stored one per byte, starting with target
0 in the least significant byte. The current code accesses those bytes
in memory order, which only matches register order on little-endian
hosts.

On big-endian hosts, the target IDs are reversed and the decoder is
associated with the wrong downstream ports.

Extract each target ID from the register value with an explicit shift
and mask so the target mapping is independent of host endianness.

Fixes: d17d0540a0db ("cxl/core/hdm: Add CXL standard decoder enumeration to the core")
Reviewed-by: Richard Cheng <icheng@nvidia.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/hdm.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index d81df45d8005..4aaadb842d90 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -976,14 +976,11 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 {
 	struct cxl_endpoint_decoder *cxled = NULL;
 	u64 size, base, skip, dpa_size, lo, hi;
+	u64 target_list;
 	bool committed;
 	u32 remainder;
 	int i, rc;
 	u32 ctrl;
-	union {
-		u64 value;
-		unsigned char target_id[8];
-	} target_list;
 
 	if (should_emulate_decoders(info))
 		return cxl_setup_hdm_decoder_from_dvsec(port, cxld, dpa_base,
@@ -1119,9 +1116,9 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 
 		lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
 		hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
-		target_list.value = (hi << 32) + lo;
+		target_list = (hi << 32) + lo;
 		for (i = 0; i < cxld->interleave_ways; i++)
-			cxld->target_map[i] = target_list.target_id[i];
+			cxld->target_map[i] = (target_list >> (i * 8)) & 0xff;
 
 		return 0;
 	}
-- 
2.37.3

