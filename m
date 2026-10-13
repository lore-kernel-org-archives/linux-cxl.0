Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C50C472528
	for <linux-cxl@vger.kernel.org>; Tue, 13 Oct 2026 04:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791865569; cv=none; b=Q0PJ+shifKBrecwg97As1fUPx+slxb3UM8qdHRVTqna9GZ2UK76Nqy/2tmeMY9SfWuDzhwc5Ow8AdLaY05ZOeZKZ7V1kRufXDRbgAN/VbwHFkwLWk6SYAQLRuEEHcwVP7WAmGRRcbu9qyEG9fkFKN1hPykUb4CT+dJ6l+sKHJ5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791865569; c=relaxed/simple;
	bh=VApnTNUqBLVkSjt4Qtj81K54GtxuIB8SoBRq+fENc9M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pPkbJt1YCvTxEp5HOfMqou1fK5IhXYiImUe/bhuh0SN5TtJy0/p/HultLu98lXd52ye1f8k8m7omRENVBLMqWe7wlzRmG2r3rV2yvLNApTvcCr6HZiLi3+oYzhlgyvNlser8nV7SxzzUE7Xh1sucN9arvuLHQZzBIXvCiYqLkGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iCAC7A0B; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iCAC7A0B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791865568; x=1823401568;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VApnTNUqBLVkSjt4Qtj81K54GtxuIB8SoBRq+fENc9M=;
  b=iCAC7A0B8MI0CsJDJT5asciDuFDD6kkFQtcm3hBb8vBDL5nm8oxciGn2
   1paxko1erJgdWVw+qFGjyR7LxaM2+jLY/te+g/OsmeyhbxXDpbCMoTa//
   qz5+3Vornp4Gb4Gu762RYK6bQq7Ju+ZDtOzzd2/2Ax9vxdGVCmGpRKS0u
   te4yDgEnCWbOfyXhySHaMiBWTv0TFel+vmemG8sm+gGQVBno4E00lVea4
   K/1+H0ACPwBF3iM+qqZxieph/6qQh31li+nfXfw8j2hXgrGjqGNVCEz22
   meOifhJk/lFeHRjrool9yVPEFDdTDFAblYoHk0kCQRpH6eBL4CAQrt1ET
   g==;
X-CSE-ConnectionGUID: bu3W6fcXS6KlaRgadBoYVA==
X-CSE-MsgGUID: Ia1ToYv1R9evPz/ja0tx3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11933"; a="455467"
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="455467"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 21:26:08 -0700
X-CSE-ConnectionGUID: Evh9QVLlRsSVZeKhhH56lw==
X-CSE-MsgGUID: vTzY4jM/Q+KV3jakTEit8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,155,1787036400"; 
   d="scan'208";a="1391061"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.222.102])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2026 21:26:07 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v3 0/7] cxl/region: Refactor cxl_port_setup_targets()
Date: Mon, 12 Oct 2026 21:25:56 -0700
Message-ID: <cover.1791860305.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a somewhat fast turnaround, and I probably caught Jonathan
midway through looking at v2. My reason (excuse) is that it's a foundation
for another set, so trying to keep it fresh.


Changes in v3:
- Drop patch "cxl/region: Name the interleave locals in cxl_port_setup_targets()".
- Move the distance comment above cxl_port_peer_distance() (Jonathan)
- Name the out-params out_iw/out_ig.
- Minor reverse fir and alignment cleanups
- Reorder the cxl_port_calc_interleave() declarations
v2: https://lore.kernel.org/linux-cxl/cover.1791676454.git.alison.schofield@intel.com/

Changes in v2:
- New patch 3 adds 'switch' to cxl_port_setup_targets() name (DaveJ)
- Add 'switch' to cxl_port_add_target() name (DaveJ)
- Pass the switch decoder to cxl_switch_port_add_target (DaveJ)
- Minor commit message updates based on function renamings
v1: https://lore.kernel.org/linux-cxl/cover.1791575481.git.alison.schofield@intel.com/

Begin Cover Letter:
cxl_port_setup_targets() has grown to nearly 200 lines. It open codes each
step of adding an endpoint to a port's decoder: finding the distance
between peer positions, reading the parent interleave, calculating and
validating the port's interleave, setting up the decoder, and adding the
target.

This set is inspired by review feedback from Robert Richter on the series
that adds mixed-granularity region support [1]. That series needs to change
how this function calculates interleaves and Robert asked for that new code
to be moved into a helper. Rather than tidy only the new code, this set
splits up the whole function first.

Patch 1 prepares the code that moves. It is a suggestion Jonathan offered
on the mixed gran series.

Patch 2 renames the function to cxl_switch_port_setup_targets(), since it
configures switch decoder targets.

Patches 3-7 each move one step at a time into its own helper, which leaves
cxl_switch_port_setup_targets() at 56 lines.

The refactor patches make no functional changes and aim to be mechanical
and easy to review. I tried to avoid all 'while you're at it' changes
that would muddy the mechanical split.

That base commit is from cxl/next.

[1] https://lore.kernel.org/linux-cxl/cover.1788475206.git.alison.schofield@intel.com/

Alison Schofield (7):
  cxl: Add interleave encoding validity helpers
  cxl/region: Rename cxl_port_setup_targets() to
    cxl_switch_port_setup_targets()
  cxl/region: Factor out cxl_port_peer_distance()
  cxl/region: Factor out cxl_port_parent_interleave()
  cxl/region: Factor out cxl_port_calc_interleave()
  cxl/region: Factor out cxl_port_setup_decoder()
  cxl/region: Factor out cxl_switch_port_add_target()

 drivers/cxl/core/region.c | 230 ++++++++++++++++++++++++--------------
 drivers/cxl/cxl.h         |  21 ++++
 2 files changed, 164 insertions(+), 87 deletions(-)


base-commit: 91320b84095afcaf9e4f676eef5b05346d60eb79
-- 
2.37.3

