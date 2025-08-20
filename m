Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AD73218B3;
	Wed, 20 Aug 2025 15:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755702439; cv=none; b=E4vhPHJGMKeAtu1RDTyOry99kuBhbDyhk7nLUCH7WLHs2qLkYiEPOw1frU6EmxC+wrXejzD16tyvHsUjojVZDP0/TWfu6v+HaSIk82gyRXQJNue1Cb34F0RjSY3hTwpg1PYE0wmGLB1Ykt+tq3CrWxCz4QWRDVTuRbmgyxhNhSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755702439; c=relaxed/simple;
	bh=bsvWlLsiwAXSsALmAJFw7fx/DntpOaz1JMs8wm09NR8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OvI5603jA2EeLajX751JF3/zNzM8YgBeqyQp8zUP46ob0NtgziccYKwxUnLoMN2OBaiBmVq2BBxKPEsXq9jV/rFuFBc88Um+HnrAThnTqwNA16UUy6w9M+B5L3vkG8YUaVliS2nfQfLPyNZSxlqkmXdTulKJZrndKnjSLwir+t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mwq5EPkA; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mwq5EPkA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755702438; x=1787238438;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bsvWlLsiwAXSsALmAJFw7fx/DntpOaz1JMs8wm09NR8=;
  b=Mwq5EPkAVM5gkI3yzMWtxZbSpjw1Kp0QGMT1t7OTB11RkbRwUEi01Uiy
   p3ivJtCGr60W8UyiH3MyoImp86PFYsKcFo02JpygDCUdiRZRXJYwqqWLb
   u+Q5vpCaFhlMlYiy7iNPU3ZW0bVaHMObZH4IpYoa3eT++HGFD4fM0eEe3
   01vNEc7Nql0ByKAqthCDFhEv6iT8Fkbg0CcmnWaQldRhcSOkd787vYno9
   nmzoS79y16c/kURUvyqtCUAt4fKK+rWC9EknfLYO0L+2SuMmU4Uo62Qz/
   3ZpHhxLuwzXJhAqPb7GeQKWu7euaF93fk62sxX/HYClTOGO6+RuCY8ej/
   g==;
X-CSE-ConnectionGUID: 39PJyWMKRaGOLdRJ0s/RCA==
X-CSE-MsgGUID: 6DlBORC1SHqxHnnWsePsrw==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="57831205"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="57831205"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 08:07:08 -0700
X-CSE-ConnectionGUID: M6f+Za+pSPO2uduUbHWWGQ==
X-CSE-MsgGUID: vdLWVx1LQuWjfxWugvrf/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="172378774"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.intel.com) ([10.245.246.85])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2025 08:07:02 -0700
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
	ALOK TIWARI <alok.a.tiwari@oracle.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [PATCH v4] cxl: docs/driver-api/conventions resolve conflicts between CFMWS, LMH, Decoders
Date: Wed, 20 Aug 2025 17:06:39 +0200
Message-ID: <20250820150655.1170975-1-fabio.m.de.francesco@linux.intel.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add documentation on how to resolve conflicts between CXL Fixed Memory
Windows, Platform Low Memory Holes, intermediate Switch and Endpoint
Decoders.

Cc: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---

v3 -> v4: Show and explain how CFMWS, Root Decoders, Intermediate
	  Switch and Endpoint Decoders match and attach Regions in
	  x86 platforms with Low Memory Holes (Dave, Gregory, Ira)
	  Remove a wrong argument about large interleaves (Jonathan)

v2 -> v3: Rework a few phrases for better clarity.
	  Fix grammar and syntactic errors (Randy, Alok).
	  Fix semantic errors ("size does not comply", Alok).
	  Fix technical errors ("decoder's total memory?", Alok).
	  
v1 -> v2: Rewrite "Summary of the Change" section, 3r paragraph.

 Documentation/driver-api/cxl/conventions.rst | 111 +++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/Documentation/driver-api/cxl/conventions.rst b/Documentation/driver-api/cxl/conventions.rst
index da347a81a237..714240ed2e04 100644
--- a/Documentation/driver-api/cxl/conventions.rst
+++ b/Documentation/driver-api/cxl/conventions.rst
@@ -45,3 +45,114 @@ Detailed Description of the Change
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
+According to the current CXL Specifications (Revision 3.2, Version 1.0),
+the CXL Fixed Memory Window Structure (CFMWS) describes zero or more Host
+Physical Address (HPA) windows associated with each CXL Host Bridge. Each
+window represents a contiguous HPA range that may be interleaved across
+one or more targets, including CXL Host Bridges. Each window has a set of
+restrictions that govern its usage. It is the OSPM’s responsibility to
+utilize each window for the specified use.
+
+Table 9-22 states the Window Size field contains the total number of
+consecutive bytes of HPA this window represents. This value must be a
+multiple of the Number of Interleave Ways * 256 MB.
+
+Platform Firmware (BIOS) might reserve physical addresses below 4 GB,
+such as the Low Memory Hole for PCIe MMIO. In such cases, the CFMWS Range
+Size may not adhere to the NIW * 256 MB rule.
+
+On these systems, BIOS publishes CFMWS to communicate the active System
+Physical Address (SPA) ranges that map to a subset of the Host Physical
+Address (HPA) ranges. The SPA range trims out the hole, resulting in lost
+capacity in the endpoint with no SPA to map to the CXL HPA range that
+exceeds the matching CFMWS range.
+
+E.g, a real x86 platform with two CFMWS, 384 GB total memory, and LMH
+starting at 2 GB:
+
+Window | CFMWS Base | CFMWS Size | HDM Decoder Base | HDM Decoder Size | Ways | Granularity
+  0    |   0 GB     |     2 GB   |      0 GB        |       3 GB       |  12  |    256
+  1    |   4 GB     |   380 GB   |      0 GB        |     380 GB       |  12  |    256
+
+HDM decoder base and HDM decoder size represent all the 12 Endpoint
+Decoders of a 12 way region and all the intermediate Switch Decoders.
+They are configured by the BIOS according to the NIW * 256MB rule,
+resulting in a HPA range size of 3GB.
+
+The CFMWS Base and CFMWS Size are used to configure the Root Decoder HPA
+range base and size. CFMWS cannot intersect Memory Holes, then the CFMWS[0]
+size is smaller (2GB) than that of the Switch and Endpoint Decoders that
+make the hierarchy (3GB).
+
+On that platform, only the first 2GB will be potentially usable but,
+because of the current specs, Linux fails to make them available to the
+users. The driver expects that Root Decoder HPA size, which is equal to
+the CFMWS from which it is configured, to be greater or equal to the
+matching Switch and Endpoint HDM Decoders.
+
+The CXL driver fails to construct Regions and to attach Endpoint and
+intermediate Switch Decoders to those Regions after their construction.
+
+In order to succeed with Region construction and Decoders attachment,
+Linux must construct Regions with Root Decoders size, and then attach to
+them all the intermediate Switch and Endpoint Decoders that are part of the
+hierarchy, even though the Decoders HPA range sizes may be larger than
+those Regions whose sizes are trimmed by Low Memory Holes.
+
+Benefits of the Change
+----------------------
+
+Without this change, the OSPM wouldn't match Intermediate and Endpoint
+Decoders with Root Decoders configured with CFMWS HPA sizes that don't
+align with the NIW * 256MB constraint, leading to lost memdev capacity.
+This change allows the OSPM to construct Regions and attach Intermediate
+Switch and Endpoint Decoders to them, so that the addressable part of the
+memory devices total capacity is not lost.
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
+The description of the Window Size field in table 9-22 needs to account
+for platforms with Low Memory Holes, where SPA ranges might be subsets of
+the endpoints' HPA. Therefore, it has to be changed to the following:
+
+"The total number of consecutive bytes of HPA this window represents.
+This value shall be a multiple of NIW * 256 MB. On platforms that reserve
+physical addresses below 4 GB, such as the Low Memory Hole for PCIe MMIO
+on x86 or a requirement for greater than 8-way interleave CXL Regions
+starting at address 0, an instance of CFMWS whose Base HPA is 0 might have
+a window size that doesn't align with the NIW * 256 MB constraint. Note
+that the matching intermediate Switch and Endpoint Decoders' HPA range
+sizes must still align to the above-mentioned rule, but the memory capacity
+that exceeds the CFMWS window size will not be accessible."
-- 
2.50.1

