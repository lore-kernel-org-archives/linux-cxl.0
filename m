Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F322B33C1B6
	for <linux-cxl@vger.kernel.org>; Thu,  3 Sep 2026 23:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788477847; cv=none; b=gqHIlaLivjpUt63yfi/IR8a+jM6qwfe16S6B3sz1ViKVW7a3sFE58vdPDxkI9LxVhxc8YIVBTmHFRnpFo5ebisY21kYHtt157ZL2o28+W/TCgxFFKtA9r9ViGSsQaFYjoQchJvLQ+QUHkKRt2IJxYiJpvardZnQwDgVHox3nBLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788477847; c=relaxed/simple;
	bh=LSuVZkvoff0xf0Em5kIVqyDvAY1/Fx+Y2RIzYKiKvxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OGXy3GtAx4Y4V+s8gXvXIEdvROvzLRpxvWf46tsZIT7hKEkdFPAzGPB06sxiF8MRPQR+CCz0zKmYQXqc8h2Xp4utb7JiHFPvmwf3yxH7G6x+8O9GVwCImU5LAfxfupUJPas0B6b7RfTblH6lrPs+8a9GuG+n9K807kGdHY13H0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mUf2FwIX; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mUf2FwIX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788477845; x=1820013845;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LSuVZkvoff0xf0Em5kIVqyDvAY1/Fx+Y2RIzYKiKvxw=;
  b=mUf2FwIX46A2e7zlWxsEP5j7dMLwCWyTmwKEpbyECoFvLFyiA8/Xk3N3
   7ugwsSFEBBBwslaQCr+pF65CU3JtfP+enN65uRGDToqxSnXa2Z8n6ofTv
   DeB4RnKgsghzFumY+smLKk8Q3UoXcgSEt/snGfKeel6nQrA0gkDjKspvb
   Jmm59hC6psHWljsDcGlw7I+Ejz5iD2VTNzdTbr5OvUBOYDzbbe4soTjPj
   R4IBtDq/Pw1mAFK3cPmzUywfYe48Q7Bgya4M6hKk1tS9koRTjVF/yMXfo
   BzWkUsKRJaDVo66Y7u7GcMJgwE+/DS1lwEEk2Vueq0Ou2ffxm5clPcRBw
   Q==;
X-CSE-ConnectionGUID: mw9GvkpKQt29LRpzsqeXkw==
X-CSE-MsgGUID: P9/8YlHZRYWgTkHoIAA5LQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="92847672"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="92847672"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 16:24:04 -0700
X-CSE-ConnectionGUID: deogyNQhQnCWYQhs3swFQA==
X-CSE-MsgGUID: FO25P02CROCdP5Nir3yAOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; 
   d="scan'208";a="268129474"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.10])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2026 16:24:04 -0700
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
Subject: [PATCH v5 1/7] Documentation/cxl: Describe mixed-granularity regions
Date: Thu,  3 Sep 2026 16:23:43 -0700
Message-ID: <5da4008cde30c04284f5780aadac49e91ae511c1.1788475206.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1788475206.git.alison.schofield@intel.com>
References: <cover.1788475206.git.alison.schofield@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Linux has required that a region's interleave granularity equal the
interleave granularity of its interleaving root decoder. A mixed-
granularity region lifts that restriction: the region granularity may be
finer than the root's, so the interleave refines from the root toward the
endpoints.

Mixed-granularity region support introduces interleave relationships that
are not obvious from the existing CXL documentation. This is particularly
true for the 3-, 6-, and 12-way configurations and for understanding which
configurations permitted by the CXL Specification are supported by Linux.

Document the mixed-granularity model and Linux's coarse-to-fine
restriction. Include the relevant configurations from CXL 4.0 Section
9.13.1.1 and annotate their Linux support status.

This intentionally repeats information from the CXL Specification. The
specification remains authoritative, but showing the Linux support policy
alongside the legal configurations ensures readers do not mistake an
unsupported Linux setup for a configuration unsupported by the CXL
Specification.

Assisted-by: Claude:Opus-5
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
---
 .../driver-api/cxl/linux/cxl-driver.rst       | 153 ++++++++++++++++++
 1 file changed, 153 insertions(+)

diff --git a/Documentation/driver-api/cxl/linux/cxl-driver.rst b/Documentation/driver-api/cxl/linux/cxl-driver.rst
index dd6dd17dc536..a61a20c8bb6d 100644
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
@@ -619,6 +624,154 @@ from HPA to DPA.  This is why they must be aware of the entire interleave set.
 Linux does not support unbalanced interleave configurations.  As a result, all
 endpoints in an interleave set must have the same ways and granularity.
 
+Mixed Granularity
+~~~~~~~~~~~~~~~~~
+Linux has required that a region's :code:`interleave_granularity` equal the
+:code:`interleave_granularity` of its interleaving root decoder.  A
+*mixed-granularity* region lifts that restriction: the region granularity may
+be finer than the root's, so the interleave refines from the root toward the
+endpoints.  The mix is between the root and the region, not granularity varying
+arbitrarily down the hierarchy.  Linux requires granularity to change
+monotonically, either coarsening or refining, across the decoders that route
+the request: the interleaving root, the host bridge, and any switches.  The
+endpoint decoder is not part of that walk, it carries the region ways and
+granularity so that it can translate, as `At Endpoint`_ describes above.  A
+mixed-granularity region requires an interleaving root decoder.
+
+Every decoder advances one target every multiple of its own granularity, and
+the decoders below it subdivide the address range their parent assigns to a
+single target.  The `Cross-Link First` example above shows the other ordering,
+where the region granularity equals the granularity of the root decoder and
+granularity coarsens toward the endpoints.  A mixed-granularity region refines
+instead, reaching the region granularity at the innermost interleaving decoder.
+
+Refining is not a preference.  Once the region granularity is finer than the
+root's, Linux gives each level below the root a single granularity, its
+parent's divided by its own ways, so the ordering follows from the region and
+root settings rather than being chosen.  The CXL Specification permits other
+orderings and does not require a monotonic one, see `Mod3 Interleave
+Configurations`_.  Reaching a fine granularity as early as possible remains
+available through `Cross-Link First`, which this does not change.
+
+For an 8-way mixed-granularity region at 1024 below a 2-way interleaving root
+decoder at 4096, where each host bridge interleaves across two root ports and
+each root port hosts a 2-way switch, Linux programs::
+
+  Level             Ways    Granularity
+  -----             ----    -----------
+  Root                 2         4096
+  Host bridge          2         2048
+  Switch               2         1024
+  Endpoint             8         1024
+
+A *region position* is the index of a region-granularity chunk within one full
+pass of the region interleave, and each endpoint of the region backs one
+position.  Each decoder contributes to an endpoint's region position in
+proportion to its granularity::
+
+  position += target_position *
+              decoder_granularity / region_granularity
+
+That multiplier is the *weight* of a level: how many region positions pass
+between successive advances of its target index.  The root above selects a host
+bridge every 4096 bytes, so it advances one target every four region positions,
+weight 4, while the switch advances one target every position, weight 1.
+
+The two orderings weight the levels in opposite directions.  Refining, a
+level's weight is the product of the ways of the interleaving levels below it,
+so the innermost interleaving level has weight 1.  Coarsening, as in
+`Cross-Link First`, it is the product of the ways of the levels above it, so
+the root has weight 1 and advances one target per region position.
+
+The ways and granularity of a mixed-granularity region must describe the same
+interleave *span* as the root decoder, the address range in which the
+interleave pattern completes one full pass::
+
+  root_ways * root_granularity == region_ways * region_granularity
+
+A region that does not describe that span either leaves part of the range
+unclaimed or reaches beyond it, and Linux rejects it.  A same-granularity
+region below a power-of-two root decoder is exempt: it may be wider than the
+root and repeat the root targets, so its span is a multiple of the root's.
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
+Table 9-6 row 6 is legal per the CXL Specification but is unsupported by Linux.
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

