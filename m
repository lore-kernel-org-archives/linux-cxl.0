Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145FD253F1D;
	Mon, 23 Jun 2025 15:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750692579; cv=none; b=k+1vg0t3IWRvq29c/LUmmy6rgEkuXDBPQauQJOIiSzlz+Lz7XIbaFpSQLNOLkwqlAbjMBBEfv+OmgceXgxb2p1zeHNaAxcERLd33kpFPQBvt9HNex5w+lr6xZmLi/tN9ZITxd1Bq4fRJqNJKVNv7GQtC6CJ/bMLMOjjqi1veF/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750692579; c=relaxed/simple;
	bh=6+hf/Qz2uBwrQFMHSJCvN2IMt+x8QWbV62BLR9ZVPt0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=r/RljHt8O3rulW925kZ0j0a9YyuMB3J7lRjUDpWKLbWgwEbpBGG2tmVXnhH/UWG2d6l4kgmMGiji9GoDoRw3CR+hVvisMoPSTQl/3HQAs4zwCiBE8NESELR5qGrYUyaPq8rdaE/LO/cUTd2EZwQ5Ak8dgLfEPvf1NmTnewgTo8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q5LX8asA; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q5LX8asA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750692578; x=1782228578;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6+hf/Qz2uBwrQFMHSJCvN2IMt+x8QWbV62BLR9ZVPt0=;
  b=Q5LX8asAHzxxzaRBSerDYluZiQknzgdnpgRFvsjIVYYivUB16gmlgdho
   uHVGBK8XvUZHK6MKueCAX9wPE8crcLlrCQzfNtdFrbCxQejUdEl5nKakz
   kyUEJ3XngPnMGmnAVoZFh0N2+vdFKQ6nh+0wNAGHwyB1w5UXF/w8JgRDG
   3kdbAzbkYNIsYv9cP3yzuEzviMUicIIuncOffOS76f+H7m10EaNlA7GVy
   Bsko2XEwiq+r5BWyLv2lQrbvoArgfNMQwRg+vWhnueP2r4J7kLOEbCxCe
   n6AFNdLp0/XqLGBAC1HuMcL9a71nAZibzxUg1hrgbHgYnUhl8dFp46HS/
   g==;
X-CSE-ConnectionGUID: U6GSo/jWTaS41JW9tjpJJg==
X-CSE-MsgGUID: 9882d5nwRBGwEpWRzof5gQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="64335934"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="64335934"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 08:29:36 -0700
X-CSE-ConnectionGUID: GOI4gb+GSOOAMYDikd9czg==
X-CSE-MsgGUID: EjKIWlIkT6WNYSxjmcAVkA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="157418228"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.246.11])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 08:29:32 -0700
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
Subject: [PATCH v3] cxl: docs/driver-api/conventions resolve conflicts btw CFMWS, LMH, ED
Date: Mon, 23 Jun 2025 17:29:02 +0200
Message-ID: <20250623152923.1048525-1-fabio.m.de.francesco@linux.intel.com>
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

v2 -> v3: Rework a few phrases for better clarity.
	  Fix grammar and syntactic errors (Randy, Alok).
	  Fix semantic errors ("size does not comply", Alok).
	  Fix technical errors ("decoder's total memory?", Alok).
	  
v1 -> v2: Rewrite "Summary of the Change" section, 3r paragraph.

 Documentation/driver-api/cxl/conventions.rst | 85 ++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/Documentation/driver-api/cxl/conventions.rst b/Documentation/driver-api/cxl/conventions.rst
index da347a81a237..d6c8f4cf2f5b 100644
--- a/Documentation/driver-api/cxl/conventions.rst
+++ b/Documentation/driver-api/cxl/conventions.rst
@@ -45,3 +45,88 @@ Detailed Description of the Change
 ----------------------------------
 
 <Propose spec language that corrects the conflict.>
+
+
+Resolve conflict between CFMWS, Platform Memory Holes, and Endpoint Decoders
+============================================================================
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
+Associated with each window is a set of restrictions that govern its usage.
+It is the OSPM’s responsibility to utilize each window for the specified
+use.
+
+Table 9-22 states the Window Size field contains the total number of
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
+whose Window Size don't fit the alignment constraints and so the memdev
+capacity would be lost. This change allows the OSPM to match Endpoint
+Decoders whose HPA range size exceeds the matching CFMWS and create
+regions that at least utilize a part of the memory devices total capacity.
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
+The current description of a CFMWS Window Size (Table 9-22) is replaced
+with:
+
+"The total number of consecutive bytes of HPA this window represents. This
+value shall be a multiple of NIW*256 MB. On platforms that reserve physical
+addresses below 4 GB for special use (e.g., the Low Memory Hole for PCIe
+MMIO on x86), an instance of CFMWS whose Base HPA is 0 might have a window
+size that doesn't align with the NIW*256 MB constraint; note that the
+matching Endpoint Decoders HPA range size must still align to the
+above-mentioned rule and so the memory capacity that might exceed the CFMWS
+window size will not be accessible.".

base-commit: a021802c18c4c30dff3db9bd355cacb68521f1aa
-- 
2.49.0

