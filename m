Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E70035CB6F
	for <linux-cxl@vger.kernel.org>; Tue,  4 Aug 2026 23:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785885626; cv=none; b=lVkJ86ttXKgdVg2lLKjsBf61nQ1/JLXqZiCGXdoOS8OVc+vVrNWKtxbkqKYr2gX7rejXcn/DbpjpxqDcwd+l8p3KhBweO1dQzOBoC7DZ+ILrAQyY1e0MBPHN3FsWflPsXjnA6TYR/MewHH+vCzwgsFSTB0jKavcH+bsbWoKRhz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785885626; c=relaxed/simple;
	bh=7NOECYG9bWdng9N1/MNpbhNlezlwFDpDVVRSzGv45kc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P+wt8R6zTRl7xi0PmkS5udDOYyF8IANOW/ZeVmd3TJKmvQtz7Or+909nZRepV95l3ouNEZh3HSyB9B1yR/trjab85sSgtMfFbv1MZXg3omM8b9w/807hLDz/Z5YtRUrn1l5LDJKUVGr/FZfKmtxq7l8A0ol8qGcffNDotaHmNT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JOE0CtdW; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JOE0CtdW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785885624; x=1817421624;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7NOECYG9bWdng9N1/MNpbhNlezlwFDpDVVRSzGv45kc=;
  b=JOE0CtdW2x/Yvx57u5yAWOp5elh6NVz0FSb+SgWoAPp9nPIq5yqVJv9W
   fmJ35laf6dwaPW5PCTeI4qpdUavjQB61MEiGRdVDjIB1iK8WHNez9yOge
   NqZ+dup+4jnoDhIR5uaMXvOrPhecZ5pcN2JbGM0zhiaCQT6eznfPVAYRX
   UXdwQFAZuYkNK9H0sc2NCbBuFPt3If9ixG2bExf76n0LVw+sugcrqbyrJ
   8nvRnXsxyemPphxSxQb/DPee1uSZg2mKcqgeLPxWs7THUrTowjD2V+5Vw
   RXQocQ4wCjaq9J0b8pI5lE2d+j9VHejbFIxHdxPexQgQJuRhvSRfM4agh
   A==;
X-CSE-ConnectionGUID: oKrnebFXSkW6o57jWZQIcQ==
X-CSE-MsgGUID: K1r3gKCWSRGDjWGoK+UBmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="73986745"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="73986745"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 16:20:23 -0700
X-CSE-ConnectionGUID: NuTg0y5DQvaPoVkQJJNI8Q==
X-CSE-MsgGUID: Dh2VV6PUSASiNWDHVecQTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="261702661"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.94])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 16:20:23 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH] cxl/Documentation: Spell out globbed sysfs attribute names
Date: Tue,  4 Aug 2026 16:20:08 -0700
Message-ID: <20260804232014.2286549-1-alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Four entries in sysfs-bus-cxl use braced globs to document groups of
attributes. Where the glob factors out a common prefix, as in
cap_{pmem,ram,type2,type3}, no individual attribute name appears in
the file at all and none can be found by grep or get_abi.py search. In
every case the glob also keys get_abi.py validate on the glob string,
so duplicates against separately documented attributes go undetected.

Replace the globs with consecutive What: lines for each attribute.
These lines continue to share the existing metadata and description
and follow the format used in sysfs-driver-ufs and sysfs-bus-iio.

Also restore one missing blank line between entries.

Verify with:
  python3 tools/docs/get_abi.py -D Documentation/ABI/testing validate
  python3 tools/docs/get_abi.py search cap_pmem
  python3 tools/docs/get_abi.py search create_ram_region

validate reports no sysfs-bus-cxl warning, and both searches now return
the stanza where they returned nothing before.

Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---

This caught my eye when reading DavidLohr's Back-Invalidate series
that adds cap_bi to the cap_{pmem,ram,type2,type3} glob and then
references it. I couldn't find it, not w grep and not w 'get_abi.py
search'. None of the existing cap_* names can be found. This patch
is independent of that series and happy to spin this to include
cap_bi if needed.

This intentionally does not address `get_abi.py undefined`, which still
fails to match decoderX.Y attributes due to a bug in the ABI tooling.
That will be fixed separately in linux-doc.

 Documentation/ABI/testing/sysfs-bus-cxl | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 16a9b3d2e2c0..7352dbd70bc7 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -201,7 +201,8 @@ Description:
 		capability.
 
 
-What:		/sys/bus/cxl/devices/{port,endpoint}X/parent_dport
+What:		/sys/bus/cxl/devices/portX/parent_dport
+What:		/sys/bus/cxl/devices/endpointX/parent_dport
 Date:		January, 2023
 KernelVersion:	v6.3
 Contact:	linux-cxl@vger.kernel.org
@@ -258,7 +259,8 @@ Description:
 		instance id of a given decoder resource.
 
 
-What:		/sys/bus/cxl/devices/decoderX.Y/{start,size}
+What:		/sys/bus/cxl/devices/decoderX.Y/start
+What:		/sys/bus/cxl/devices/decoderX.Y/size
 Date:		June, 2021
 KernelVersion:	v5.14
 Contact:	linux-cxl@vger.kernel.org
@@ -297,7 +299,10 @@ Description:
 		Each entry in the list is a dport id.
 
 
-What:		/sys/bus/cxl/devices/decoderX.Y/cap_{pmem,ram,type2,type3}
+What:		/sys/bus/cxl/devices/decoderX.Y/cap_pmem
+What:		/sys/bus/cxl/devices/decoderX.Y/cap_ram
+What:		/sys/bus/cxl/devices/decoderX.Y/cap_type2
+What:		/sys/bus/cxl/devices/decoderX.Y/cap_type3
 Date:		June, 2021
 KernelVersion:	v5.14
 Contact:	linux-cxl@vger.kernel.org
@@ -410,7 +415,8 @@ Description:
 		interleave_granularity).
 
 
-What:		/sys/bus/cxl/devices/decoderX.Y/create_{pmem,ram}_region
+What:		/sys/bus/cxl/devices/decoderX.Y/create_pmem_region
+What:		/sys/bus/cxl/devices/decoderX.Y/create_ram_region
 Date:		May, 2022, January, 2023
 KernelVersion:	v6.0 (pmem), v6.3 (ram)
 Contact:	linux-cxl@vger.kernel.org
@@ -500,6 +506,7 @@ Description:
 		cache is present, the size indicates extended linear cache size
 		plus the CXL region size.
 
+
 What:		/sys/bus/cxl/devices/regionZ/extended_linear_cache_size
 Date:		October, 2025
 KernelVersion:	v6.19

-- 
2.37.3

