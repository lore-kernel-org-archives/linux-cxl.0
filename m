Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29DD248F73
	for <linux-cxl@vger.kernel.org>; Wed, 15 Jul 2026 21:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784151963; cv=none; b=uiNdWqVDjC4mM9yuDOE10MhHGN84Zo2Y4Ahisq/GOuvOb83EIZeUED1BVPa57sIuGuxttqnUwl/Umr1flm4doiiOI3l7SACxd6KoDHNSBUrzv0bAZXwQ/VaIhSM//6cPL65kEs9q6yDhaeqYTcWTzJg6m6pKyu8Uh1Yto5ZDWbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784151963; c=relaxed/simple;
	bh=tC3IwgIm9gz1dPW2KH2y1LEcoQPmdXvkxz4cuIsIgD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XS5kUaQbpDWQ9HOSzQyvvvwa6TmIfpiGmEqTmS8xm1s5y0Fm5g/oZXoUzQdd1hYD9NvTD+m+8GGrGiDmwhmmHxWkKXLwoRXdJIPVJXeRvZ7poc1MzPzpxfQN2MMQgOb0k54bvg6Arxvn+budbgynmz0/L9y99adb5z/EquOjz8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lGh3klAC; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lGh3klAC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784151962; x=1815687962;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tC3IwgIm9gz1dPW2KH2y1LEcoQPmdXvkxz4cuIsIgD8=;
  b=lGh3klACbXbayjpP7F3DwGY80mc2sHX+ZGAoN1fm2l3w6MjKHx1Asnbv
   2qq+KBFuTcZBNjzkRw5Tmw2xRCi4AvJOq+mkvKB+hD05JK1RfP5GI2vGG
   oslwTIlu+PXGjs+OwRWwzlByL/jhE5roov3bS73oLkS+lbDi5c62iNyik
   4sAVv4zlggeKVEh2asXgdkdm0Y23JK2Bj5rQ19G7q3nhbfzSxLsvI1b6e
   ByHzDb/Ph/gImP8hZtqKDmdWBW9q5fknZvrFcFcm0K8VuWHK3JzRO0J/i
   wEU3JHisb13GUjMtM+RIpnpWE5WT1n7vIuFBFAZ9Sl8EsFH0waTPZ7Vw8
   Q==;
X-CSE-ConnectionGUID: P05oQL8wTaK5QFBt3TYu2A==
X-CSE-MsgGUID: 3uOrwZ+jQx2H4wV+mqFX6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11847"; a="88632845"
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="88632845"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 14:46:02 -0700
X-CSE-ConnectionGUID: RW6BeixURpipL53xiNlARg==
X-CSE-MsgGUID: YITbJ9hCSKqkT9qJCgHifQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,166,1779174000"; 
   d="scan'208";a="254549529"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.220.156])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2026 14:46:01 -0700
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
Subject: [PATCH v2 2/3] cxl/hdm: Make switch decoder target parsing endian-safe
Date: Wed, 15 Jul 2026 14:45:48 -0700
Message-ID: <5c7d0e84f2397764e7dac2e12ecb6cdaf47fcb0a.1784150131.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1784150131.git.alison.schofield@intel.com>
References: <cover.1784150131.git.alison.schofield@intel.com>
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
index 9f005f3193e2..51ab154a73fe 100644
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
@@ -1112,9 +1109,9 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 
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

