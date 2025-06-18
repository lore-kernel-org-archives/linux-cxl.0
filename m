Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CC4F510;
	Wed, 18 Jun 2025 15:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750259844; cv=none; b=eRQgHVIvE+3OmE1oGwOrIUOj0Dsmqgbby2zmAIf+c6Jd2pwZqGxgudKxb87cWpM1f35nnssRqtz+zem8mGy6ntZLYei/Lzj5rnwW6ZpF2TIg+ox6V5pc0fUwemO8LqfX2OF8WmUSl3CfBqHrq9SgFGwhfB+clZ/p1Ol5n232EyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750259844; c=relaxed/simple;
	bh=qp3zEprFcsHoCCE1DWjUUaPL9Tr6VHgIcEyvV0o9FEA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sKo3bftrReJvKlCLcnstGnchrQLWohem1Vzdr58+GNonlyyJVLx3m+Jwd5GLwgcHRSDH2hA56ff6N0ldJU6sYae43SHHng7B7VfhKFdEtMdPL3m+QB6hymQJW5/W1DiQtivA8F9UQLG5aMO1yYNP9NQdVuu/OFkobcVsHyMrzLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=atwXuhJi; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="atwXuhJi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750259842; x=1781795842;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qp3zEprFcsHoCCE1DWjUUaPL9Tr6VHgIcEyvV0o9FEA=;
  b=atwXuhJi4uCNA1PSJwHpUy2oovF5EcCKv0eHm+MlDE+AGtIduQhXYXC+
   geJ0rXkncNalKx9NNppdgpJpfgivHOpEj589uh9/yOhOsXlF/pewvbeGX
   9R1mTbcMy4OYHQmXWqOmWsQqiCHfxq0WS44JEjZpK26YT3dB2qr3noyIX
   Sq3zYvza6Jtua+p2jeNCYhhPpL4/bD+jpvsmS7Fzy+pSpn4+tX/uPz+iQ
   dhHmnFQ+FDKw583xep7jJIuOVHfWA94gfb4aiGZDSj296OWR95l6Z7Qwf
   uLZVWmwcrOzN28ucc/i2Py6HGg+p81d3KG0O0DWbh6EDls59TjwRR3T1u
   w==;
X-CSE-ConnectionGUID: LsVM1kXxTcm3BtgzvvjHxg==
X-CSE-MsgGUID: 3pBxLW12TFmLIGwWCofoKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11468"; a="52626338"
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="52626338"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 08:17:21 -0700
X-CSE-ConnectionGUID: cqBX57m6QDSP4ZkR3jnKsQ==
X-CSE-MsgGUID: Vrp+9Il+T7atOs5gYA+r9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,246,1744095600"; 
   d="scan'208";a="149455804"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.246.172])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 08:17:16 -0700
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
Subject: [PATCH] cxl: docs/driver-api/conventions resolve conflicts btw CFMWS, LMH, ED
Date: Wed, 18 Jun 2025 17:17:05 +0200
Message-ID: <20250618151710.1001847-1-fabio.m.de.francesco@linux.intel.com>
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

