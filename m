Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320682FDC43;
	Wed,  3 Sep 2025 13:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756905039; cv=none; b=iHlC+fdpoJYJgzwVXrSSXWcqQru/44EnYSQ5Zop426EjRffBnT4JApOQ3UkDYScXABFY7nfxiUagUqJ+myyAkRmkGwpCsha8IOJzy/mNY7jT4cj7tpU8DV63zEusy/s1CgVROY1mGG+nZdTFECcoTpl0R8Jw2ueCij4M0ZHVwts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756905039; c=relaxed/simple;
	bh=nHX1WRBOQncfX88uycgall9DZu/Ouz7YqK7DwmLeBoM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oC8PhWogY4OwMH5hmFxfzJQA+LOk8L8s26iR9pRYHqh3MhmJP78G/7XAQvmbPMMiJP7YwDtzfd0329b7+8Y3XFRHiGxOilX13IlEsGXxg596zdRgKw1wbwk6JyKU2LpdU4v8WFPgzuj0XH6CTCAyNaw63omiNqnoV/K7Kj1I7R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hSog3uiY; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hSog3uiY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756905037; x=1788441037;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nHX1WRBOQncfX88uycgall9DZu/Ouz7YqK7DwmLeBoM=;
  b=hSog3uiYcV5QAzEQSiChDS/oohaiNGKqlGeUGsHegjHoTuQhn+sN5F3K
   FWMGMxEMfaw3WmO2ZUF2yTzUTDeItJOqW0jvfxVi2F94LvHT0uJnUnmb+
   JrW2I3pKoGUd+lnMtiGcpKOhDVnB1p0uwclBYXwM0yfjXjS5+bSgZg6K9
   opROnP6URbw6AjYAXOkUPPjUkUAetPGxJhjVVW4d4Ut6bHhfjVv7ngnKj
   P9/fDgQQ6dq9AHg4zLs3ke31dQgkPMPTHQd3gUnNTU5C3HFEE6u9bYo6e
   Okip7y9bSDjt6sbQg9D5jlg0SQqbLNt9yfGzjY4OL7Oxgk4FL0t1jtKhB
   Q==;
X-CSE-ConnectionGUID: lxsrDTYnRcabB0tt0lM0kA==
X-CSE-MsgGUID: PoxVpLbFSz+YTVxEb1GraA==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="59153177"
X-IronPort-AV: E=Sophos;i="6.18,235,1751266800"; 
   d="scan'208";a="59153177"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 06:10:36 -0700
X-CSE-ConnectionGUID: LY9ET8qESMWuL+dTWZmoDA==
X-CSE-MsgGUID: xjOlT3UQRRKHKcE+zguqTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,235,1751266800"; 
   d="scan'208";a="176866986"
Received: from fdefranc-mobl3.igk.intel.com ([10.237.142.159])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 06:10:32 -0700
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
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Robert Richter <rrichter@amd.com>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Subject: [PATCH v5] cxl: docs/driver-api/conventions resolve conflicts between CFMWS, Low memory Holes, Decoders
Date: Wed,  3 Sep 2025 15:10:10 +0200
Message-ID: <20250903131026.1462103-1-fabio.m.de.francesco@linux.intel.com>
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

Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
---

v4 -> v5: Fix grammar and syntactic errors (Dave)
	  Spell out CXL, OSPM, on first use (Dave)
	  Rewrite a few sentences for better clarity (Dave)
	  Talk about SPA vs HPA and SPA's relationship to CFMWS (Dave)
	  Adjust a table for htmldocs output (Bagas)
	  Use bullet list (Bagas)
	  Correct the CFMWS[1] HPA range to not overlap CFMWS[0] (Robert)
	  Correct the CFMWS[1] HPA range to the NIW*256MB rule (Robert)

v3 -> v4: Show and explain how CFMWS, Root Decoders, Intermediate
	  Switch and Endpoint Decoders match and attach Regions in
	  x86 platforms with Low Memory Holes (Dave, Gregory, Ira)
	  Remove a wrong argument about large interleaves (Jonathan)

v2 -> v3: Rework a few phrases for better clarity.
	  Fix grammar and syntactic errors (Randy, Alok).
	  Fix semantic errors ("size does not comply", Alok).
	  Fix technical errors ("decoder's total memory?", Alok).
	  
v1 -> v2: Rewrite "Summary of the Change" section, 3r paragraph.

 Documentation/driver-api/cxl/conventions.rst | 118 +++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/Documentation/driver-api/cxl/conventions.rst b/Documentation/driver-api/cxl/conventions.rst
index da347a81a237..f5ccb5c3b7b9 100644
--- a/Documentation/driver-api/cxl/conventions.rst
+++ b/Documentation/driver-api/cxl/conventions.rst
@@ -45,3 +45,121 @@ Detailed Description of the Change
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
+- Fabio M. De Francesco, Intel
+- Dan J. Williams, Intel
+- Mahesh Natu, Intel
+
+Summary of the Change
+---------------------
+
+According to the current Compute Express Link (CXL) Specifications (Revision
+3.2, Version 1.0), the CXL Fixed Memory Window Structure (CFMWS) describes zero
+or more Host Physical Address (HPA) windows associated with each CXL Host
+Bridge. Each window represents a contiguous HPA range that may be interleaved
+across one or more targets, including CXL Host Bridges.  Each window has a set
+of restrictions that govern its usage. It is the Operating System-directed
+configuration and Power Management (OSPM) responsibility to utilize each window
+for the specified use.
+
+Table 9-22 of the current CXL Specifications states that the Window Size field
+contains the total number of consecutive bytes of HPA this window describes.
+This value must be a multiple of the Number of Interleave Ways (NIW) * 256 MB.
+
+Platform Firmware (BIOS) might reserve physical addresses below 4 GB where a
+memory gap such as the Low Memory Hole for PCIe MMIO may exist. In such cases,
+the CFMWS Range Size may not adhere to the NIW * 256 MB rule.
+
+The HPA represents the actual physical memory address space that the CXL devices
+can decode and respond to, while the System Physical Address (SPA), a related
+but distinct concept, represents the system-visible address space that users can
+direct transaction to and so it excludes reserved regions.
+
+BIOS publishes CFMWS to communicate the active SPA ranges that, on platforms
+with LMH's, map to a strict subset of the HPA. The SPA range trims out the hole,
+resulting in lost capacity in the Endpoints with no SPA to map to that part of
+the HPA range that intersects the hole.
+
+E.g, an x86 platform with two CFMWS and an LMH starting at 2 GB::
+
+ +--------+------------+-------------------+------------------+-------------------+------+
+ | Window | CFMWS Base |    CFMWS Size     | HDM Decoder Base |  HDM Decoder Size | Ways |
+ +========+============+===================+==================+===================+======+
+ |   0    |   0 GB     |       2 GB        |      0 GB        |       3 GB        |  12  |
+ +--------+------------+-------------------+------------------+-------------------+------+
+ |   1    |   4 GB     | NIW*256MB Aligned |      4 GB        | NIW*256MB Aligned |  12  |
+ +--------+------------+-------------------+------------------+-------------------+------+
+
+HDM decoder base and HDM decoder size represent all the 12 Endpoint Decoders of
+a 12 ways region and all the intermediate Switch Decoders.  They are configured
+by the BIOS according to the NIW * 256MB rule, resulting in a HPA range size of
+3GB.
+
+The CFMWS Base and CFMWS Size are used to configure the Root Decoder HPA range
+base and size. CFMWS cannot intersect Memory Holes, then the CFMWS[0] size is
+smaller (2GB) than that of the Switch and Endpoint Decoders that make the
+hierarchy (3GB).
+
+On that platform, only the first 2GB will be potentially usable, but Linux,
+aiming to adhere to the current specifications, fails to construct Regions and
+to attach Endpoint and intermediate Switch Decoders to them. The several points
+of failure are due to the expectation that the Root Decoder HPA size, that is
+equal to the CFMWS from which it is configured, has to be greater or equal to
+the matching Switch and Endpoint HDM Decoders.
+
+In order to succeed with construction and attachment, Linux must construct a
+Region with Root Decoder HPA range size, and then attach to that all the
+intermediate Switch Decoders and Endpoint Decoders that belong to the hierarchy
+regardless of their range sizes.
+
+Benefits of the Change
+----------------------
+
+Without the change, the OSPM wouldn't match intermediate Switch and Endpoint
+Decoders with Root Decoders configured with CFMWS HPA sizes that don't align
+with the NIW * 256MB constraint, and so it leads to lost memdev capacity.
+
+This change allows the OSPM to construct Regions and attach intermediate Switch
+and Endpoint Decoders to them, so that the addressable part of the memory
+devices total capacity is made available to the users.
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
+The description of the Window Size field in table 9-22 needs to account for
+platforms with Low Memory Holes, where SPA ranges might be subsets of the
+endpoints HPA. Therefore, it has to be changed to the following:
+
+"The total number of consecutive bytes of HPA this window represents. This value
+shall be a multiple of NIW * 256 MB.
+
+On platforms that reserve physical addresses below 4 GB, such as the Low Memory
+Hole for PCIe MMIO on x86, an instance of CFMWS whose Base HPA range is 0 might
+have a size that doesn't align with the NIW * 256 MB constraint.
+
+Note that the matching intermediate Switch Decoders and the Endpoint Decoders
+HPA range sizes must still align to the above-mentioned rule, but the memory
+capacity that exceeds the CFMWS window size won't be accessible.".
-- 
2.50.1

