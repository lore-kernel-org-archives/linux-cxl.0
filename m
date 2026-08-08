Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FFF79DA
	for <linux-cxl@vger.kernel.org>; Sat,  8 Aug 2026 00:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786147561; cv=none; b=F1f2UhlAU8GRP1RCnew0+GLSszwezx1vcRw19czMIUeZlE3JmB89NGjB9kedoHFEA1JRoz2IlWFv+CdowFzcJClcvEqx9Wej1h+hs23yxKkt70FatvhEYQN35XQ5w7hvcTogRjJTo/+AnmXd9bdROKgO2S4xYFjwGV49M2XwdNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786147561; c=relaxed/simple;
	bh=RPqBx/DcHU11RYcObymhgvpUEUmZzGkuyzFNnzTJc2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y2sEWFl3jKA2SQO09L3PLxTedRZTM3kIV+gHQRbnx4JLrtEgsFC4BejBRnXLj5u3RvlyC0QEoKVsWczp2fx8Mi90PE0UI6oswZwSBlaimPCtQ9kLizp0tTXGnZ1ICgSUOmCruqM4coL1e8g1PK6zcbPc7Y0sxl0UMadqNa2Lz1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UT5TQktX; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UT5TQktX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786147560; x=1817683560;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RPqBx/DcHU11RYcObymhgvpUEUmZzGkuyzFNnzTJc2U=;
  b=UT5TQktX2DMzzQjxaax9crfN0jCipVQuNbN8Sz9WaM97a3GQ3lIBLDqj
   v5LVm3kAI9jdT4vpnzrmR1q+quz+FEftqTnNP7txkMmfKyhALKBjS9qE4
   eYMDl9KgWBsX8vrYHgZhRc2sGSF+UuYX1xvSw1+LFAkLLWqpHUednOMcF
   e7H58XKDcw/R3tte+8hSfhUAfHwZhnqX8HZUyy/G/Wsbjv1kkyfnkYi3F
   siT8KY+4aAF9ZgSfqWi2X/aoFF/q4gATERhJyRpaWgiPP1zCNHPFsREYu
   bwJ6+EuYO5FfAvfhW4yAfIdo9O5svF0D7ehhx8hT5u9XZmyucUBrpwBem
   w==;
X-CSE-ConnectionGUID: usRDLZ/BTOyzFKH1d0/lSw==
X-CSE-MsgGUID: CRLoABI8SgmT3of6uIXEvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11868"; a="90441188"
X-IronPort-AV: E=Sophos;i="6.25,211,1779174000"; 
   d="scan'208";a="90441188"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 17:06:00 -0700
X-CSE-ConnectionGUID: hXN3yp9sQwOLQnoGm+KW3Q==
X-CSE-MsgGUID: Hn6ZhBjnRjKj5HTgn0nz5A==
X-ExtLoop1: 1
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.80])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2026 17:05:58 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v5 2/4] cxl/hdm: Make switch decoder target parsing endian-safe
Date: Fri,  7 Aug 2026 17:05:49 -0700
Message-ID: <b0526825b3c3ffdb78837563e178d9aa27b6bbb8.1786143520.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1786143520.git.alison.schofield@intel.com>
References: <cover.1786143520.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Switch decoder target IDs are stored one per byte, starting with
target 0 in the least significant byte. The current code accesses
those bytes in memory order, which only matches register order on
little-endian hosts.

On big-endian hosts, the target IDs are reversed and the decoder is
associated with the wrong downstream ports.

Place the register values in a byte array in little-endian order and
index the target IDs from there, so the target mapping is independent
of host endianness.

Fixes: d17d0540a0db ("cxl/core/hdm: Add CXL standard decoder enumeration to the core")
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/hdm.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index c394b3d54d36..fc22d515b638 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
 #include <linux/seq_file.h>
+#include <linux/unaligned.h>
 #include <linux/device.h>
 #include <linux/delay.h>
 
@@ -975,15 +976,12 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			    u64 *dpa_base, struct cxl_endpoint_dvsec_info *info)
 {
 	struct cxl_endpoint_decoder *cxled = NULL;
+	u8 target_id[CXL_HDM_DECODER0_TL_TARGETS];
 	u64 size, base, skip, dpa_size, lo, hi;
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
@@ -1096,11 +1094,12 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			return -ENXIO;
 		}
 
-		lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
-		hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
-		target_list.value = (hi << 32) + lo;
+		put_unaligned_le32(readl(hdm + CXL_HDM_DECODER0_TL_LOW(which)),
+				   &target_id[0]);
+		put_unaligned_le32(readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which)),
+				   &target_id[4]);
 		for (i = 0; i < cxld->interleave_ways; i++)
-			cxld->target_map[i] = target_list.target_id[i];
+			cxld->target_map[i] = target_id[i];
 
 		return 0;
 	}
-- 
2.37.3

