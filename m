Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8F739184C
	for <linux-cxl@vger.kernel.org>; Tue, 21 Jul 2026 01:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784599191; cv=none; b=ltGpHJzjUhp+2ajiYodPWDJjHSC+bfhBXN4AeN31HzaNaTyYIBD3vzZfcMl0xR1u6xgOdI6/lYWuTs4CuN2jmrPE3ahK0+dD1k9Mao2KuHvIwuaEiWFsHuePk4FeHaBb5EJp/VFHjGLPFeiqILXXmIap6Q/Vdq7uTj04uYFKI5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784599191; c=relaxed/simple;
	bh=Gm0VgjnIe0+HxsS/wEPP82AI1vj1zITQFUEXg7BEobg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WJfeZqomv/DJt+HhyAes4Jo3MhMMj12JDySShELl1QUDbNzVyjMTuCELEy7vF2NLeg8DHumHtBBBXIbLpAccIiiwv+dCe/s/waWxX0B+rAD9rmYwuaPjXG7ERshLSIwdYueirC2Y8OZq2IRzNRSUV0xH6/uFPsuMMmYmoPHQ1FU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NhCa10YB; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NhCa10YB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784599191; x=1816135191;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gm0VgjnIe0+HxsS/wEPP82AI1vj1zITQFUEXg7BEobg=;
  b=NhCa10YBDLAqDHblJ2e9AUvLo6LDDXRtQEc0mJWu9Qj3KobRou7HElMD
   ljBwPf0scs6M6xTXFpyr0wbASu1xGQys1lMfyciAY/YO1TSwcbK6VNj0M
   ZZ/fKINmV4vCisd3gtG3RES+K5tWwssk27f9NJ29VV7juJ/89uKTgHqvX
   r7L11ivCOmWEyVB6Vdwq8hqFJikR+cHCbI8uqtA+gIAOCl61t6iW1uE6B
   uFJhMxxejoRYEECT1f2YZyzHuW0pniP2Pdnbj066coxgYwkAXk+Lk6yfb
   4MTKg6aHHYwV86pKxMOwwznj22ohUaDg6DPerCLLOPPZQUtuPX0Nl++R9
   A==;
X-CSE-ConnectionGUID: 6YqImIVNSmmqoDRdiK7dNA==
X-CSE-MsgGUID: +DGqOKk8SQ62dpJ3tInUuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="85209230"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="85209230"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 18:59:50 -0700
X-CSE-ConnectionGUID: +7usmfl7Qs2HgdAorhVgIg==
X-CSE-MsgGUID: KoVKsrH4Tj6jh8l2bq0mGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; 
   d="scan'208";a="261181256"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.174])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2026 18:59:49 -0700
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
Subject: [PATCH v4 3/4] cxl/hdm: Make switch decoder target parsing endian-safe
Date: Mon, 20 Jul 2026 18:59:39 -0700
Message-ID: <f98abc5edccc4fed9250d29df76ac677e3e51702.1784595445.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1784595445.git.alison.schofield@intel.com>
References: <cover.1784595445.git.alison.schofield@intel.com>
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

Extract each target ID from the register value with an explicit shift
and mask so the target mapping is independent of host endianness.

Fixes: d17d0540a0db ("cxl/core/hdm: Add CXL standard decoder enumeration to the core")
Reviewed-by: Richard Cheng <icheng@nvidia.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/hdm.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 1f995191baf5..077aface1a2a 100644
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
@@ -1122,9 +1119,9 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 
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

