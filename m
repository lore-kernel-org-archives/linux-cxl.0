Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793650573;
	b=mkT4JSRD0ICcxKOxpuVPngLsgrq/RVAaj3mWjl8u6stXOIR7gxea2mPowsr3Q7uuoebl
	 myb0C1poj32giRgLaEQWUd+ICpQsbQaUaiROyP3r2l5ms6duIfDqC87WiFUm4cNAHp9Ke
	 d6C3lWhEuzR1leARf5qEagRnQpFBIZjlGEtcy3TE2kwvzkekUJCqNY1Ip16nMav6UyZMR
	 xo4RQHdUg+U1xyI1rWQqSfSYybawhpWDk+31HVBSYFt34B+TZtXLIfWZClQvOfi772+Kj
	 tzZZSOTWarnXahjAGLWUu2f1kNQeH1tF4yrQgTESsO7aPCg6S8/3cwvTjWcKUx/ioLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793650573;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9HWrrHjtVcJeyMzGEyFQY/oPQ1Hf9Dq7FQWz4Xj/FWg=;
	b=pFxxxtWJuI5m3YjpENiKWO7aGOrcN+FGLmJBSMK6+n7/ktsxNk0EnHjza5bcdZoJlXCh
	 1K21mqDvAgbFnmOPWzw9zRNQRT0RSLCNdAwfMNwsCQVb9DnoIXX9CUNAIpTeqlk9Sn8MD
	 mVxuGKWzf1cLHHsFzWod1MCHa2R5JMcuEPfNOhYGmTJuhFh0/09SbtE4H1K2bSPh/G2Rm
	 mk4m/eViwNhXq5cGBqoBYnzihnlSQF4yuHKH9yVglKuv6gKLg3KeT0opvf5Cfquq2ghS/
	 iY3FpJHN6pt3e+Toc7+24hz0DYKdcNc2zwA/w12UEA4IwGaBc1z/FHCqHcLOir0PMUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GvaNlMXG;
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB63606A337
	for <linux-cxl@vger.kernel.org>; Mon,  2 Nov 2026 20:16:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEB63606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=GvaNlMXG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793650572; x=1825186572;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rAmTSIJBcs8ljia3oZoJBM7jpL2ytoMTmsfbdQzpQHI=;
  b=GvaNlMXG6er+zEHt2hwf94ATglOBFlD+wFdgOWNvKpDPSJwNeVLOnTle
   uHoayYUcSVu6WKRFzO6YqIo95nLa8hs9EleZ7xYIeakOLqA/EpHc5luyI
   LG4ILeh2eqe2i5C9xJbBq0PC71etnGaM0gryvSzYkyMOZMaMbIm3K0CxJ
   lDM/dnINTBGFA0mb+ZLUj0xJ3elUFF4joTH05Gl/4cm1x6Kw/Ddnlr9jY
   ooWhnkPvF8maXo192XsO+tnR5C0SkV3i5Bg4W1lavWBc7RLRXdXnfN6+M
   tqqgGEclkEUIi1uUMsgCQ9GRnEsgJpsFvpxhVZzO4M8YlsCx4IVyvXihr
   w==;
X-CSE-ConnectionGUID: 6919hlM2RO6C26xcX8KDJA==
X-CSE-MsgGUID: dchf+pDsRjKzycsTQdwD3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2464015"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2464015"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 12:16:12 -0800
X-CSE-ConnectionGUID: q7MjeuvTRqS+B+0hmY7/cQ==
X-CSE-MsgGUID: 7iwoy1aaRaqZGib+S9/6sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6215610"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.109.173])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 12:16:11 -0800
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
Subject: [PATCH v5 4/9] cxl/region: Calculate peer distance only for reused targets
Date: Mon,  2 Nov 2026 12:15:59 -0800
Message-ID: <e05b15fed21af3fb7ec2f663ee254df61c06d0e3.1793649898.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1793649898.git.alison.schofield@intel.com>
References: <cover.1793649898.git.alison.schofield@intel.com>
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

From: Richard Cheng <icheng@nvidia.com>

cxl_switch_port_setup_targets() calculates peer distance before
searching the existing targets. When the endpoint needs a new target,
the calculated distance is never used.

Move cxl_port_peer_distance() into the matching-target branch,
immediately before check_last_peer(). This avoids unnecessary ancestor
walks and per-port region lookups when adding distinct targets.

With cxl_test, the x8 region in cxl-region-sysfs.sh reduces calls to
cxl_port_peer_distance() from 10 to 4, and the x2 auto region from 2
to 1. A misordered-endpoint test confirms that peer validation still
rejects mismatched peers.

Signed-off-by: Richard Cheng <icheng@nvidia.com>
Tested-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 drivers/cxl/core/region.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 4ab5a1d025a9..8bfebe3e1025 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1485,10 +1485,10 @@ static int cxl_switch_port_setup_targets(struct cxl_switch_decoder *cxlsd,
 	}
 
 	if (cxl_rr->nr_targets_set) {
-		int distance = cxl_port_peer_distance(port, cxlr);
-
 		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
 			if (ep->dport == cxlsd->target[i]) {
+				int distance = cxl_port_peer_distance(port, cxlr);
+
 				rc = check_last_peer(cxled, ep, cxl_rr,
 						     distance);
 				if (rc)
-- 
2.37.3

