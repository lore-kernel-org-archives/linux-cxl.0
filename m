Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38488635D
	for <linux-cxl@vger.kernel.org>; Sat, 25 Jul 2026 01:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784941741; cv=none; b=rfXmMmMH+GgIw90aOqsZi69iJEx7lib17K0FfxSY2E0JFcfGLiw6VObG5+x+BJVXEXHvoRpjrsg6cwmAtL7K847vj/9lLNh2nZqid18ZnwMkPo35udi0eZxks87X6ek0VvZW2D55bUii1QRPR932EQYX6ySx0rFOZT7S6hxE/jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784941741; c=relaxed/simple;
	bh=EDKrrDahOjOxvtv2wSUbuf+qMP5NLWIb4noM8FPwbxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EcKJZf7mNgpKXBvt2BIEFIv5EAKoTujIuk79bJe6Ggo0U35TJWtpH+9sm3BXQYwJsCGWTz6PuCqNDUQyYabh1fI8iMbhSWTjCnl0ZsVTTFgz2W9oh1roC+9gJGL2ba6Id+uElYB3w0vIwqNJ0DtI+zhLy/dWD7l2MqCDFA3oHm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UKJflRxJ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UKJflRxJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784941740; x=1816477740;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EDKrrDahOjOxvtv2wSUbuf+qMP5NLWIb4noM8FPwbxQ=;
  b=UKJflRxJYGfkFrzv2yegPXYSqESua9UOPhQtm9GyfthNCxxpX7Y9S1oS
   QDIPpOiZ4TlcOSL5+t4peA0p4o6/D6AM/mHwHyhBBOBEIbWVphXNz1n5K
   OqBWhwkiEPpNyXkLfBFntGggzpp91ukOaPW5cIRLsz025eMYI2yd3Ok+v
   0yDn1bLhATUuwzolTkyDOK2u9RUbBglKvi19BKUMeQhojE+mGPlVTBcJu
   Xlgi5cSPV546EHWNoeSZRohDgWH6cQeecZ+hwsfJkfbwBTgATGVRIw/gm
   1lTpRUilqhmIvbkSTLcHb46VX706HWr3oLO2oCSgWv75I7OoMQDLcPOXe
   A==;
X-CSE-ConnectionGUID: Cmw132qiQkSKijAKcmINQg==
X-CSE-MsgGUID: GeYZZ97URFSWT2es1tUxCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11855"; a="111154116"
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="111154116"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 18:08:59 -0700
X-CSE-ConnectionGUID: dIVpF6gfSU63+EsIZ7LOog==
X-CSE-MsgGUID: hbhC1OM0Rt6SGzkWKVgt8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="256205146"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.232])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 18:08:59 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v3 0/2] cxl: Allow passthrough decoders with >16K granularity
Date: Fri, 24 Jul 2026 18:08:53 -0700
Message-ID: <cover.1784940306.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v3:
- Program the real IG encoding for an encodable non-interleaving granularity
  instead of always writing EIG=0 (RichardC, Sashiko)
- Update Patch 1 commit msg text and this cover letter text per above change
Link to v2:
https://lore.kernel.org/linux-cxl/cover.1783795720.git.alison.schofield@intel.com/

Changes in v2:
- Rebased on Linux 7.2-rc1
- Only v1 feedback was from Sashiko and that was not an issue
Link to v1:
https://lore.kernel.org/linux-cxl/cover.1781136281.git.alison.schofield@intel.com/

Sashiko reported [1] that region setup rejects valid topologies
containing a passthrough decoder beneath a wide parent interleave. In
these configurations, a passthrough decoder can compute a granularity
above the 16K maximum encodable in the interleave granularity (IG)
field even though non-interleaving decoders do not consume that field.

The first patch avoids validating the interleave granularity of
non-interleaving decoders, encodes the IG field as a don't-care
only when the computed granularity is not encodable, and updates
the sysfs ABI documentation accordingly.

The second patch extends cxl-test with a topology that allows a CXL
unit test to cover this case.

A unit test update for this case is posted for review [2].

[1] https://lore.kernel.org/all/20260530002613.682E71F00893@smtp.kernel.org/
[2] https://lore.kernel.org/all/cover.1781136221.git.alison.schofield@intel.com/


Alison Schofield (2):
  cxl/region: Allow passthrough decoders with >16K granularity
  cxl/test: Add a 2-way 16K root decoder for passthrough testing

 Documentation/ABI/testing/sysfs-bus-cxl |  5 ++-
 drivers/cxl/core/hdm.c                  |  8 ++++-
 drivers/cxl/core/region.c               | 47 ++++++++++++++----------
 tools/testing/cxl/test/cxl.c            | 48 +++++++++++++++++++++++--
 4 files changed, 85 insertions(+), 23 deletions(-)


base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.37.3

