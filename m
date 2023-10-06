Return-Path: <linux-cxl+bounces-3-linux-cxl=archiver.kernel.org@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13250E92FCF
	for <linux-cxl@archiver.kernel.org>; Fri,  6 Oct 2023 00:43:25 +0000 (UTC)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id CB8511C208D2
	for <linux-cxl@archiver.kernel.org>; Fri,  6 Oct 2023 00:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597911101;
	Fri,  6 Oct 2023 00:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="agTVVr92"
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CE77FF
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 00:43:18 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1713BDB
	for <linux-cxl@vger.kernel.org>; Thu,  5 Oct 2023 17:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696552997; x=1728088997;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GIJRhUNPJfgMbZk3ntdui+0nLQjujPQvLnYKZmsVcZg=;
  b=agTVVr92Nsre0SDCqHfuWZerzNDi1c5plmtq3R4tAgyaChekWbe7v8QT
   rYrrqhHqLUCvGo7lmNpPPv4fvjmoitNbVmltzxjAnFeQpWgeTEln8dZvL
   DsOC0dIcmcjSB66d53wRmg34JJRgLzMRtTo4Z7MyToP4Q2Fi9LYoBQbOe
   jOOwmjnCyMlYhqW39r7N1LliYjcxOBFkvTk4uCmzryWQu07jMS5xeHtPe
   o6sEWYMFB0l6+WowkXJ3SEF5P/vtONVWyeDNLDD/n89SmSyI4EBshO9Zn
   MwpvICGFCjqCgrbAqoRGE0nSZu4b2i3aPBxfpJNUXzRJwruI/G8eFc3UD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="363010974"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="363010974"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 17:43:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="925781555"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="925781555"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.219.124])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 17:43:15 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH 0/3] cxl/region: Autodiscovery position repair
Date: Thu,  5 Oct 2023 17:43:10 -0700
Message-Id: <cover.1696550786.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

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


To test this, I've been able to validate that a previously failing 2+2
autodiscovered config now works. Also, using the dev_dbg() selftest
hook in Patch 2, proved the new calculation against all regions created
during the execution of the CXL unit test suite.

For example:
# meson test -C build cxl-xor-region.sh
# dmesg | grep Interleave
[  177.223243] cxl_core:cxl_region_attach:1765: cxl decoder8.1: Interleave calc match Success test_pos:0 cxled->pos:0
[  177.788170] cxl_core:cxl_region_attach:1765: cxl decoder8.1: Interleave calc match Success test_pos:0 cxled->pos:0
[  177.790720] cxl_core:cxl_region_attach:1765: cxl decoder10.0: Interleave calc match Success test_pos:1 cxled->pos:1
[  178.711246] cxl_core:cxl_region_attach:1765: cxl decoder8.1: Interleave calc match Success test_pos:0 cxled->pos:0
[  178.714015] cxl_core:cxl_region_attach:1765: cxl decoder16.0: Interleave calc match Success test_pos:1 cxled->pos:1
[  178.716846] cxl_core:cxl_region_attach:1765: cxl decoder17.0: Interleave calc match Success test_pos:2 cxled->pos:2
[  178.719660] cxl_core:cxl_region_attach:1765: cxl decoder18.0: Interleave calc match Success test_pos:3 cxled->pos:3


Alison Schofield (3):
  cxl/region: Prepare the decoder match range helper for reuse
  cxl/region: Calculate a target position in a region interleave
  cxl/region: Use calc_interleave_pos() with autodiscovered regions

 drivers/cxl/core/region.c | 205 ++++++++++++++++++++------------------
 1 file changed, 106 insertions(+), 99 deletions(-)


base-commit: 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa
-- 
2.37.3


