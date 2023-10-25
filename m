Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73EF2D631
	for <linux-cxl@vger.kernel.org>; Wed, 25 Oct 2023 20:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KQnedPXb"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B35B136
	for <linux-cxl@vger.kernel.org>; Wed, 25 Oct 2023 13:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698264147; x=1729800147;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wXp/yEh3OCDf9uVGfLqN7WY0Vq8ICtI8FB5FK+pUpbs=;
  b=KQnedPXbhrG2LwN93kdfxTOeqKsqNB3ZCG9sAxwYEWacQTeh5vGj9djW
   7kKV4CuyEuOUDLiU0LlVgRN9F6gL384H47IF7yrjP0GeTFG+QUPVCVvH3
   ONSwCjBfR2aSBwZ1H9G4OruYeTj0R/ZhQQzrUq/oBgE7+KbHh5NV2xpNk
   6GeTlWb02otatjwyVQo/LSHW5EaOdsiMVqS8xUziR6H87iB/7oxBv6MWE
   GLbwYnX1jkkr2Fnfzsu11ckQPe7KWSVvLGiFUDTBLzvtGScY6UV8HF5Gu
   tV/9yRumPCIxNvGqlkw81PORPfEok4tIuh+927vx5oY2ezH4u7SjkexdG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="473624358"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="473624358"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 13:01:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="902664731"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="902664731"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.181.198])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 12:59:12 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v4 0/3] cxl/region: Autodiscovery position repair
Date: Wed, 25 Oct 2023 13:01:31 -0700
Message-Id: <cover.1698263080.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

Changes in v4:
- Remove useless kernel doc comments on find_pos_and_ways() (Dan)
  That also resolves the missing prototype warning from 0-day.
- v3: https://lore.kernel.org/linux-cxl/cover.1698254338.git.alison.schofield@intel.com/

Changes in v3:
- Collapse the local position initialization into the iterative loop. (Jim)
- Match on exact resource range when looking up a switch decoder. (Jim, Dan)
- Update changelogs comments & remove extra fixes & reported-by tags (Dan)
- Add kernel doc to calc_interleave_pos() and find_pos_and_ways() (Dan)
- Add cxl_ prefix to calc_interleave_pos() and find_pos_and_ways()
- Expand in code comments at the dev_dbg test of cxl_calc_interleave_pos()
- Reword the dev_dbg message at test of cxl_calc_interleave_pos()
- Remove stray brace in Patch 1/3 (Jim)
- Init rc to -ENXIO, not -1 (Dan)
- Remove the skip logic (was index logic in v1)
  The skip logic was based on my misunderstanding of valid configs.
  Once I understood that that targets cannot repeat in a decoder list,
  ie a CFMWS of {0 1 0 1} allowing two hosts bridges to appear twice
  in a root decoder was garbage, the prior skip logic and related
  shenanigans were removed.
- v2: https://lore.kernel.org/linux-cxl/cover.1697433770.git.alison.schofield@intel.com/

Changes in v2:
- Use a 'skip', which is a number of siblings to skip over, rather than
  an 'index' when finding a child's position in a parent interleave.
- Tidy up commit messages for clarity and grammar. (DaveJ)
- Update this cover letter with added testing configs that led to the
  'skip' change in the calculation.
- v1: https://lore.kernel.org/linux-cxl/cover.1696550786.git.alison.schofield@intel.com/


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
are essentially a replacement, the resulting diff is horrible. (I did 
try multiple git diff algs). So after a small preparation patch (Patch 1),
it's presented like this:

Patch 2:The new method, cxl_calc_interleave_pos(), is introduced and used
	in a dev_dbg() exercise on user defined regions.

Patch 3:cxl_calc_interleave_pos() replaces the relative sort() in
	cxl_region_sort_targets() for auto-discoverd regions
	and the now obsolete sort helpers are removed.

The only function that seems useful for a side by side diff viewing
is cxl_region_sort_targets() and it is visible in Patch 3.

Testing passes on pre-production hardware with BIOS defined regions
that natively trigger this autodiscovery path of the region driver.
Testing passes a CXL unit test using the dev_dbg() calculation test
(see cxl_region_attach()) across an expanded set of region configs:
1, 1, 1+1, 1+1+1, 2, 2+2, 2+2+2, 2+2+2+2, 4, 4+4, where each number
represents the count of endpoints per host bridge.

Alison Schofield (3):
  cxl/region: Prepare the decoder match range helper for reuse
  cxl/region: Calculate a target position in a region interleave
  cxl/region: Use cxl_calc_interleave_pos() for auto-discovery

 drivers/cxl/core/region.c | 222 +++++++++++++++++++++-----------------
 1 file changed, 125 insertions(+), 97 deletions(-)


base-commit: 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa
-- 
2.37.3

