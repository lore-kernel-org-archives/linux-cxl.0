Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E15027F006;
	Wed, 18 Jun 2025 16:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750263557; cv=none; b=sWAxqHWf1YES6aseNGWTFNCH9CT0xqFcVgdWEK7UeFc6A2Cs86iU1nBRlxz0/6cNXBdfMrKqWVXrTVxII90qx/CocWcFJ/kLqdXZb5lR9NhzpxtjbWiIswWb+mrBu//DawhXxAVg8c3Yh+zskdU1/8M8eu3toC3Am1VGzkkZPDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750263557; c=relaxed/simple;
	bh=ZGJ7FzcxtXNPS+3GyzZjQUw11U4AHJkVU+LJURhihCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pYuP9nxhwSjzYgeJBu+jJxRBomkuhbq+x8OHoP9tTEXCPtTVW5uXIAYrMweLcSv2xGgPcfVENUf8ktf4hqQSfmcMDhAKHrhLNC7KPWn4REgLNEK6hy/qEZc1etQ1m+JOgxwNsgKgeqgJzOZ1ICirJAiUqfZq34U1S3ZGBSlO43I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iwY0lY4j; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iwY0lY4j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750263555; x=1781799555;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZGJ7FzcxtXNPS+3GyzZjQUw11U4AHJkVU+LJURhihCg=;
  b=iwY0lY4jkJUBfxXW8W/aAClsvZoRznADGVTQaArgI2MG12dNRYrKU9hm
   MyNtGQOWpIP/zcLfJNL3qnhAhePO6M5EVt5O8sb1PjSBDru3u2MYO+F1f
   bg7ngaawnoYN8QptSq7kmqTRGDWZMgDS3Tw1mU2pS+Z2rwE4UxQLjeQDB
   qNvpE7kHoHk1lOQkCxFcN5w+xRw+D8vQGiN9uVaAasaAsO4kypEkKy0/8
   0dTcaqy/Ha5JLRyV485iD6zwpcNpj1M5YZOZOfBqgGGCDK4RmBmFKxI5T
   cTmhUGhmnxif2qWkkPYbEOsDv6KpcSb2S0lGC2ietfs8sPiRwuz5jgYJl
   Q==;
X-CSE-ConnectionGUID: nQgKNGEkQGWaFz0zNH7jBA==
X-CSE-MsgGUID: FnopioiGQjWR4FJ4enkhBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="62766176"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="62766176"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 09:19:14 -0700
X-CSE-ConnectionGUID: 3kYLNmZmRCiQp6vsDuUHIA==
X-CSE-MsgGUID: OQ5RvwddSziqTDfNlsRI2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="149730592"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.246.172])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 09:19:11 -0700
From: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
To: linux-cxl@vger.kernel.org
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [PATCH v2] cxl: docs/driver-api/conventions resolve conflicts btw CFMWS, LMH, ED
Date: Wed, 18 Jun 2025 18:16:08 +0200
Message-ID: <20250618161907.1008564-1-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add documentation on how to resolve conflicts between CXL Fixed Memory
Windows, Platform Memory Holes, and Endpoint Decoders.

Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---

v1 -> v2: Rewrite "Summary of the Change" section, 3r paragraph.

 Documentation/driver-api/cxl/conventions.rst | 85 ++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/Documentation/driver-api/cxl/conventions.rst b/Documentation/driver-api/cxl/conventions.rst
index da347a81a237..acf2523ae799 100644
--- a/Documentation/driver-api/cxl/conventions.rst
+++ b/Documentation/driver-api/cxl/conventions.rst
@@ -45,3 +45,88 @@ Detailed Description of the Change
 ----------------------------------
 
 <Propose spec language that corrects the conflict.>
+
+
+Resolve conflict between CFMWS, Plaftform Memory Holes, and Endpoint Decoders
+=============================================================================
+
+Document
+--------
+
+CXL Revision 3.2, Version 1.0
+
+License
+-------
+
+SPDX-License Identifier: CC-BY-4.0
+
+Creator/Contributors
+--------------------
+
+Fabio M. De Francesco, Intel
+Dan J. Williams, Intel
+Mahesh Natu, Intel
+
+Summary of the Change
+---------------------
+
+According to the current CXL Specifications (Revision 3.2, Version 1.0)
+the CXL Fixed Memory Window Structure (CFMWS) describes zero or more Host
+Physical Address (HPA) windows that are associated with each CXL Host
+Bridge. Each window represents a contiguous HPA range that may be
+interleaved across one or more targets, some of which are CXL Host Bridges.
+Associated with each window are a set of restrictions that govern its
+usage. It is the OSPM’s responsibility to utilize each window for the
+specified use.
+
+Table 9-22 states the Window Size field contains that the total number of
+consecutive bytes of HPA this window represents and this value shall be a
+multiple of Number of Interleave Ways * 256 MB.
+
+Platform Firmware (BIOS) might reserve part of physical addresses below
+4 GB (e.g., the Low Memory Hole that describes PCIe memory space for MMIO
+or a requirement for the greater than 8 way interleave CXL regions starting
+at address 0). In that case the Window Size value cannot be anymore
+constrained to the NIW * 256 MB above-mentioned rule.
+
+On those systems, BIOS publishes CFMWS which communicate the active System
+Physical Address (SPA) ranges that map to a subset of the Host Physical
+Address (HPA) ranges. The SPA range trims out the hole, and capacity in the
+endpoint is lost with no SPA to map to CXL HPA in that hole.
+
+The description of the Window Size field in table 9-22 needs to take that
+special case into account.
+
+Note that the Endpoint Decoders HPA range sizes have to comply with the
+alignment constraints and so a part of their memory capacity might not be
+accessible if their size exceeds the matching CFMWS range's.
+
+Benefits of the Change
+----------------------
+
+Without this change, the OSPM wouldn't match Endpoint Decoders with CFMWS
+whose Window Size don't comply with the alignment rules and so all their
+capacity would be lost. This change allows the OSPM to match Endpoint
+Decoders whose HPA range size exceeds the matching CFMWS and create
+regions that at least utilize part of the decoders total memory capacity.
+
+References
+----------
+
+Compute Express Link Specification Revision 3.2, Version 1.0
+<https://www.computeexpresslink.org/>
+
+Detailed Description of the Change
+----------------------------------
+
+The current description of a CFMWS Window Size (table 9-22) is replaced
+with:
+
+"The total number of consecutive bytes of HPA this window represents. This
+value shall be a multiple of NIW*256 MB. On platforms that reserve physical
+addresses below 4 GB for special use (e.g., the Low Memory Hole for PCIe
+MMIO on x86), an instance of CFMWS whose Base HPA is 0 might have a window
+size that doesn't align with the NIW*256 MB constraint; note that the
+matching Endpoint Decoders HPA range size must still align to the
+above-mentioned rule and so the memory capacity that might exceeds the
+CFMWS window size will not be accessible.".

base-commit: a021802c18c4c30dff3db9bd355cacb68521f1aa
-- 
2.49.0

