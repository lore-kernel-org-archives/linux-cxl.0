Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D2635E1D1
	for <linux-cxl@vger.kernel.org>; Mon, 13 Jul 2026 20:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783975466; cv=none; b=AaksYZV6XMK41a9fneTm9rfdCySk6jLnaJj0D5JTvvj/UDaLRnFSDbcebdBjburx62/FrWENPIg5C+qTC2gXn8xApAKQM0vPURS+GCWn9nbMe/o37zVl1nZcrRP96uejdMygsYP+dUO+19wQMXn9jBWs/LaFaVYvxAwyfByVwqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783975466; c=relaxed/simple;
	bh=PWnhfLZJKBVZtuQWZIIq72rb/bJUBfgwZKJpO31NraM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HC4IFHiL2tP44OwFXX56JJJ7Zfb+rALsApQkNncAeVwKMdyKBnDYPQVTClzu7P/+83eRIsdiAPSzGzwQ2EvLYef/z0Wr8KDJTxxwLosmBdvdCI6ZO19C2tRiDIcnfp3+UaF8n60avdl0sCfBeWmZKfhacces2iQs1a1V965eXNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UyrsKgJG; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UyrsKgJG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783975465; x=1815511465;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PWnhfLZJKBVZtuQWZIIq72rb/bJUBfgwZKJpO31NraM=;
  b=UyrsKgJGmCIvA0t2xJouwlmFrkkfpb1IXXgrxOuedoXkae2aQbYHgiej
   zlPSnqDFrUj7mqg8ETNCLw/zkjfIMwAqYcY7n9DNNGUqRmzygwi14TT31
   mbMwv+SmofR4Z8v4QNUYQTS+GLd1qG6er2aED2k6tIoeFyk5sxKmaMuO8
   DEble/EQ508+VnLQqsPyKTKlmPTnamSo0VHOQOdUnjAnIUo88IhWTcNnN
   ZFM6D4vIw92phqV8gHoeIiTwWsTUk2DjJWW2WjMIBCnZyTl2+pK/DfCBH
   Rv5DjU7YgPOl6NGSf8w3VB9jNUsl1nV0U4FUI568Zz1VsQiOcsW2St8gJ
   g==;
X-CSE-ConnectionGUID: FuugoEkOTV2qfzadOlXmlw==
X-CSE-MsgGUID: Y2zJ4MqkQdW7oqLsZvj1zw==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95742162"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="95742162"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 13:44:25 -0700
X-CSE-ConnectionGUID: 7tDMmMc2T92qX8+cqd+L0w==
X-CSE-MsgGUID: D87cOmyXT5+xgnITS+es5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; 
   d="scan'208";a="256285895"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.220.12])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2026 13:44:23 -0700
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
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH 2/3] cxl/hdm: Make switch decoder target parsing endian-safe
Date: Mon, 13 Jul 2026 13:44:12 -0700
Message-ID: <98c7b27637578158b15dce057455987b86de283d.1783974681.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1783974681.git.alison.schofield@intel.com>
References: <cover.1783974681.git.alison.schofield@intel.com>
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
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/hdm.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index d86a607d2a2c..75d17120233d 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -974,14 +974,11 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
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
@@ -1104,9 +1101,9 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 
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

