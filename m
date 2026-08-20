Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210972222D0
	for <linux-cxl@vger.kernel.org>; Thu, 20 Aug 2026 23:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787268698; cv=none; b=leGUiJA5B48d4NrPHTfEaa97hxGuAo2gMIQ8Rvk6LIvEgxEY8/whUtd1CIF45WSfqTEI9t+E/ugcbY6DdvJFnY5nc+ULDMJ6mchDDYxwobrvT/5GUnk690nnyjG/VWIhD25ffIxid42FV35LmYJFvbkYRr6mX5APIWhg/Z3AYLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787268698; c=relaxed/simple;
	bh=8s4qQ4UtosRwAt/MopDG1vdgIDgNA2MOTik6Xi3M0Iw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BHhOccJuREb8aTt40KuLjD0XuYPiwyodPxUM1Y8vnS2Hb8c78v56//VcGDyw6oheNI6jS4ZW13pzLjZC5ILcgBatYawWTPbyFAuOCgHMcTr18jeea4VNqXP2b8ilaW746+lsL3m2Zlaq4nWvDYA6y1xSYQJNAgo2RvClxhilJPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ja+/uBxy; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ja+/uBxy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787268697; x=1818804697;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8s4qQ4UtosRwAt/MopDG1vdgIDgNA2MOTik6Xi3M0Iw=;
  b=ja+/uBxydwZHf/Daq8nooa5bVQsB2OioXKO/jLPOAw4TLmwlmnU0M1fJ
   jj0efLtbUTnkQ/UudrmQTVhIw2oZYa33S7wckXkrrMrNHHFuNhXk57Yro
   D0GrN0zpQzr8vNqq34EXKMe8m7joxUeUd0cztVT35WUNxIDBZL7A+VVAj
   rWfz68E+fZP7NM3IoZKEr1GRQOTN71tDWmDdUbomj9MQhlkIx6pV8QU7W
   4wqMafQu82jlh6LPt2RpfTCmYgf8EaMGEpTz6DjmOgVG/ZK4pTsqYbYnv
   87wras1DZM5MKWBAgGM/PVyAfA3G9ezTbRhmfOsOC3MrwLZA2OHKrayBw
   A==;
X-CSE-ConnectionGUID: OGO1vTXaTpO+YsN6ILvvxg==
X-CSE-MsgGUID: tbB5VJhUSta7c4WHWdqrZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="113355383"
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="113355383"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 16:31:36 -0700
X-CSE-ConnectionGUID: eHMTsuHxRBGBOtigqlrrmw==
X-CSE-MsgGUID: 21Iuc1ITTbWRRc2ratDznw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; 
   d="scan'208";a="296097803"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 16:31:36 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v4 6/6] Documentation/cxl: Describe mixed-granularity regions
Date: Thu, 20 Aug 2026 16:31:24 -0700
Message-ID: <3ad2df22dacea3cbd58a3ca2732003e120605277.1787255388.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1787255388.git.alison.schofield@intel.com>
References: <cover.1787255388.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mixed-granularity region support introduces interleave relationships
that are not obvious from the existing CXL documentation. This is
particularly true for the 3-, 6-, and 12-way configurations and for
understanding which configurations permitted by the CXL Specification
are supported by Linux.

Document the mixed-granularity model and Linux's coarse-to-fine
restriction. Include the relevant configurations from CXL 4.0 Section
9.13.1.1 and annotate their Linux support status.

This intentionally repeats information from the CXL Specification.
The specification remains authoritative, but showing the Linux support
policy alongside the legal configurations ensures readers do not
mistake an unsupported Linux setup for a configuration unsupported by
the CXL Specification.

Assisted-by: Claude:Opus-5
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 .../driver-api/cxl/linux/cxl-driver.rst       | 135 ++++++++++++++++++
 1 file changed, 135 insertions(+)

diff --git a/Documentation/driver-api/cxl/linux/cxl-driver.rst b/Documentation/driver-api/cxl/linux/cxl-driver.rst
index dd6dd17dc536..4e56c18294ef 100644
--- a/Documentation/driver-api/cxl/linux/cxl-driver.rst
+++ b/Documentation/driver-api/cxl/linux/cxl-driver.rst
@@ -602,6 +602,11 @@ derived from their upstream port connections. In `Cross-Link First` interleave
 configurations, the :code:`interleave_granularity` of a decoder is equal to
 :code:`parent_interleave_granularity * parent_interleave_ways`.
 
+When the region granularity is finer than the granularity of an interleaving
+root decoder, the relation inverts: the :code:`interleave_granularity` of a
+decoder is equal to :code:`parent_interleave_granularity / interleave_ways`.
+See `Mixed Granularity`_.
+
 At Endpoint
 ~~~~~~~~~~~
 `Endpoint Decoders` are programmed similar to Host Bridge and Switch decoders,
@@ -619,6 +624,136 @@ from HPA to DPA.  This is why they must be aware of the entire interleave set.
 Linux does not support unbalanced interleave configurations.  As a result, all
 endpoints in an interleave set must have the same ways and granularity.
 
+Mixed Granularity
+~~~~~~~~~~~~~~~~~
+Every decoder advances one target every multiple of its own granularity, and
+the decoders below it subdivide the span their parent assigns to a single
+target.  Linux supports two orderings of granularity down the hierarchy.
+
+The `Cross-Link First` example above shows the first ordering, where the region
+granularity equals the granularity of the root decoder and granularity coarsens
+toward the endpoints.  In the second ordering the region granularity is finer
+than the root decoder's and granularity refines toward the endpoints, reaching
+the region granularity at the innermost interleaving decoder.  A region using
+that ordering is a *mixed-granularity* region.  A mixed-granularity region
+requires an interleaving root decoder.
+
+Linux supports only monotonic granularity hierarchies, either coarsening or
+refining from the root toward the endpoints.  The CXL Specification does not
+require a monotonic ordering, see `Mod3 Interleave Configurations`_.
+
+For an 8-way mixed-granularity region below a 2-way interleaving root decoder
+at 4096, where each host bridge routes through two levels of switch, Linux
+programs::
+
+  Level             Ways    Granularity
+  -----             ----    -----------
+  Root                 2         4096
+  Host bridge          1         4096
+  Upper switch         2         2048
+  Lower switch         2         1024
+  Endpoint             8         1024
+
+Each decoder contributes to an endpoint's region position in proportion to its
+granularity::
+
+  position += target_position *
+              decoder_granularity / region_granularity
+
+The root above selects a host bridge every 4096 bytes, so it advances one
+target every four region positions, while the lower switch advances one target
+every position.  When the region granularity equals the root granularity, the
+root advances one target per region position and each level's weight is the
+number of ways below it.
+
+The ways and granularity of a mixed-granularity region must describe the same
+interleave span as the root decoder::
+
+  root_ways * root_granularity == region_ways * region_granularity
+
+A region that does not describe that span either leaves part of the range
+unclaimed or reaches beyond it, and Linux rejects it.  A same-granularity
+region below a power-of-two root decoder spans a multiple of the root's range
+rather than one target's share of it, and is not subject to this relationship.
+
+Mod3 Interleave Configurations
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+A 3-way, 6-way, or 12-way interleave, known as a Mod3 interleave, selects its
+target with a factor-of-three selection rather than from binary interleave
+selector bits alone.  CXL 4.0 Section 9.13.1.1 defines the 3-way selection as
+the address above the decoder granularity taken modulo 3.  A 6-way selection
+claims one binary HPA bit at the decoder granularity and takes the modulo 3 of
+the address above that bit, and a 12-way selection claims two.
+
+The factor-of-three selection is not an additional binary selector bit, so a
+Mod3 interleave distributes across the hierarchy as::
+
+  3  = 3
+  6  = 3 * 2
+  12 = 3 * 4
+
+The cross-host bridge selection carries the factor of three, and the remaining
+x2 or x4 is binary interleave selection below it.  A 6-way region at IGB across
+three host bridges is therefore::
+
+  Device-level region:   6-way @ IGB
+  Cross-host bridge:     3-way @ 2*IGB
+  Below the root:        2-way @ IGB
+
+where both levels describe the same interleave span::
+
+  3 * (2 * IGB) == 6 * IGB
+
+The CXL Specification defines the legal Mod3 compositions and is normative.
+CXL 4.0 Section 9.13.1.1, "Legal Interleaving Configurations: 12-way, 6-way,
+and 3-way", Tables 9-6, 9-7, and 9-8 list them for a 12-way, 6-way, and 3-way
+device-level interleave at IGB.  Those tables are summarized below, annotated
+with the subset Linux supports.
+
+CXL 4.0 Table 9-8, 3-way device-level interleave at IGB::
+
+  Row  Cross-host bridge  Host bridge    Switch         Linux
+  ---  -----------------  -----------    ------         -----
+   1   3-way @ IGB        none           none           supported
+
+CXL 4.0 Table 9-7, 6-way device-level interleave at IGB::
+
+  Row  Cross-host bridge  Host bridge    Switch         Linux
+  ---  -----------------  -----------    ------         -----
+   1   6-way @ IGB        none           none           supported
+   2   3-way @ 2*IGB      2-way @ IGB    none           supported
+   3   3-way @ 2*IGB      none           2-way @ IGB    supported
+
+CXL 4.0 Table 9-6, 12-way device-level interleave at IGB::
+
+  Row  Cross-host bridge  Host bridge    Switch         Linux
+  ---  -----------------  -----------    ------         -----
+   1   12-way @ IGB       none           none           supported
+   2   6-way @ 2*IGB      2-way @ IGB    none           supported
+   3   6-way @ 2*IGB      none           2-way @ IGB    supported
+   4   3-way @ 4*IGB      4-way @ IGB    none           supported
+   5   3-way @ 4*IGB      none           4-way @ IGB    supported
+   6   3-way @ 4*IGB      2-way @ IGB    2-way @ 2*IGB  unsupported
+   7   3-way @ 4*IGB      2-way @ 2*IGB  2-way @ IGB    supported
+
+Table 9-6 row 6 is legal per the CXL Specification and unsupported by Linux.
+Walking it from the root toward the endpoints, granularity goes::
+
+  4*IGB -> IGB -> 2*IGB
+
+which refines and then coarsens.  Row 7 interleaves the same 12 endpoints at
+the same granularity with those two levels exchanged::
+
+  4*IGB -> 2*IGB -> IGB
+
+which is monotonic.  Linux programs row 7 for a user region and assembles an
+auto region whose decoders are programmed that way.  An auto region matching
+row 6 is not assembled.
+
+Leaving row 6 unsupported does not prevent a 12-way device-level interleave.
+The specification defines six other legal compositions, all monotonic and
+supported by Linux.
+
 Example Configurations
 ======================
 .. toctree::
-- 
2.37.3

