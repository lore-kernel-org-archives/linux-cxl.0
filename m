Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979976FA2
	for <linux-cxl@vger.kernel.org>; Mon, 16 Oct 2023 06:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RFQBWgeA"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6920ED9
	for <linux-cxl@vger.kernel.org>; Sun, 15 Oct 2023 23:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697436152; x=1728972152;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=B/1uqTS5uD+3EtYoY9I1lJZjn0MBEKalY/Sp41IGY1k=;
  b=RFQBWgeA5ozUV2F/Gu8jJZDwuT7QZKA+9EMyBkoj0632csB42OTBjA7X
   FDa532sD43NghkWHqXMrQ1j3rP99KCAkhp6YLnQYYhsdgoX37mcj1ztvM
   DhFqZJowXRsR7BricWn+hLyYPsVpUGeH8mbMVb40tptS2wF9Ax1LOWpAN
   fBHFJTmxC91EXz9aKPlIm4UNJlM8YSctwzJGDt1uGBNFnE6RP2++h2YQu
   yrN55avAIfQiLWre5dFNj38oHO9sZAvTwc6SC/UzrQh0s1VS1cbKKWi/h
   Ji/Rrjm9Yd+CIlUxlECfPec1sjgYuai/Deoqwj7o2gfNN/AaRTR3sfP+X
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="365714348"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="365714348"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 23:02:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10863"; a="899361941"
X-IronPort-AV: E=Sophos;i="6.03,228,1694761200"; 
   d="scan'208";a="899361941"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.62.161])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2023 23:00:33 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v2 0/3] cxl/region: Autodiscovery position repair
Date: Sun, 15 Oct 2023 23:02:25 -0700
Message-Id: <cover.1697433770.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Alison Schofield <alison.schofield@intel.com>

Changes in v2:
- Use a 'skip', which is a number of siblings to skip over, rather than
  an 'index' when finding a child's position in a parent interleave.
- Tidy up commit messages for clarity and grammar. (DaveJ)
- Update this cover letter with added testing configs that led to the
  'skip' change in the calculation.


Begin original cover letter:

Some region configurations fail to assemble through the auto-discovered
region path. These are valid region configurations that can be assembled
correctly if presented as user defined regions.

The difference being that user defined regions arrive at the driver
with their targets in interleave order, whereas with autodiscovered
regions, the driver needs to assign each target in the interleave
set a correct position. And, in some cases, that fails.

cxl_region_sort_targets() uses the kernel sort() function to put the
targets in relative order. Once the relative ordering is complete,
positions are assigned based on each targets index in the sorted list.

That relative sort doesn't consider the offset of a port into its
parent port. In the failure case, a 2 + 2 config (2 host bridges each
with 2 endpoints), this causes the sort to put all targets of one port
ahead of another port, when they were expected to be interleaved.

While examining the problem and weighing the option of repairing the
existing sort algorithm with assigning positions another way, I chose
the latter. Each endpoint can be examined individually to discover its
position in the region interleave.

The presentation of this patchset was a challenge. While the changes
are essentially a replacement the resulting diff is horrible. (I did 
try multiple git diff algs). So, after a simple preparation patch,
its presented like this:

Patch 2:The new method, calc_interleave_pos(), is introduced and used
	in a dev_dbg() exercise on user defined regions.

Patch 3:Calc_interleave_pos() replaces the relative sort() in
	cxl_region_sort_targets() for auto-discoverd regions
	and the now obsolete sort helpers are removed.

The only function that seems useful for a side by side diff viewing
is cxl_region_sort_targets() and it is in Patch 3.

Tested with interleave at the Host Bridges, no switches:
1, 1+1, 1+1+1, 1+1+1+1, 2, 2+2, 2+2+2, 2+2+2+2, 4, 4+4

Tested with switches, 8 way interleave using 2 HB 2 Switches.
Tested against all regions created in CXL unit test runs.



Alison Schofield (3):
  cxl/region: Prepare the decoder match range helper for reuse
  cxl/region: Calculate a target position in a region interleave
  cxl/region: Use calc_interleave_pos() with autodiscovered regions

 drivers/cxl/core/region.c | 207 ++++++++++++++++++++------------------
 1 file changed, 108 insertions(+), 99 deletions(-)


base-commit: 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa
-- 
2.37.3

