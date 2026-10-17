Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC94234A3BF
	for <linux-cxl@vger.kernel.org>; Sat, 17 Oct 2026 19:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792264806; cv=none; b=EXE6qB95QRtMzoI/Oxlt8rsGY78+SmnRPydcLQL3DsYOgQgjz9gAtRopqyzWYdIYXyJeRLe2/lCHlCDOqP2k8WBpp5dAj+RhnSydWyvTcjEKpQMnZuZZY9UH1SusdI5HwVX5WsrYShpn1W3GkyYKOSPUrdz9U3eNThe9v+njlDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792264806; c=relaxed/simple;
	bh=e4CiKAiXUZ1tKAS275evTHdTCIz7fAeaISEuTqTrkUU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uQV8ZYJ2G5yFqZT/+TReeTxiqQ9y0cdNQ+lLXro0hn6s/xUE4PW3WCN0wZqX7qtBaQGO4vy5bi7TpmOhOp0v+Rj5mFll9PhY4Zl2zE2lK+wOTvDBHR9/nfyxznclm0KaZHSxfKuFpU9z84b7QZz3zHUMPqS6CTQv1AVWgc6Y3SE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QVNnNwCk; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QVNnNwCk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792264804; x=1823800804;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=e4CiKAiXUZ1tKAS275evTHdTCIz7fAeaISEuTqTrkUU=;
  b=QVNnNwCklT8bjWcdKKf/l8v7ORxS4OXIWo12jLSva4e/NO3LdJ2x+pHo
   Jmows1vrLth7ETqAUaD6fQMhwcdnB1Kx6/6AqfnJmlzAMvCziv7IP9NqO
   iwqx9jw2I3Hvta9sKlxdGSdef82YCHUKng5Qn1R3A3qVDjQAx94f4Zzn3
   cqF/dCcf28YRHRekp4o66jBy80x78zs2MbRQgHWFWVoxx4rJnmDOAw8I2
   1eGQVISSt27WahzGP9rm4X/I3+HcG6euWIitYhGbpXNzd434qkgvof0MH
   okEO5zdLf3OQD8rQL0yISKhFWbMrMoAf+DgqpcMReHPe49w3MVmwg2Elt
   Q==;
X-CSE-ConnectionGUID: 9MvZiIxsSH6YENiN5sNM5w==
X-CSE-MsgGUID: jCm08PuKRU2XQ2Z8ZcuDsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11938"; a="1034657"
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="1034657"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2026 12:20:04 -0700
X-CSE-ConnectionGUID: zzVH0sXgTgSK9K1jeiROcg==
X-CSE-MsgGUID: CcLYnzpBS0esmNRumll6mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,163,1787036400"; 
   d="scan'208";a="2282191"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.110.223])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2026 12:20:04 -0700
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
Subject: [PATCH v4 0/9] cxl/region: Refactor cxl_port_setup_targets()
Date: Sat, 17 Oct 2026 12:19:45 -0700
Message-ID: <cover.1792263750.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v4:
- Pass cxlsd to cxl_switch_port_setup_targets() (DaveJ)
- New Patch 4 from Richard, only calc peer distance on target reuse (RichardC)
- Add function comment to cxl_port_parent_interleave() (RichardC)
- New Patch 8 simplifies control flow (MingL, JonathanC)
- Remove claim in cover letter of a strictly mechanical refactor
- Drop LLM tags per latest guidance
v3: https://lore.kernel.org/linux-cxl/cover.1791860305.git.alison.schofield@intel.com/

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
configures switch decoder targets, and changes its parameter to accept a
switch decoder rather than a port, both DaveJ suggestions.

Patches 3-9 extract the individual steps into helpers and add two new patches:
RichardC's patch 4 avoids calculating peer distance when an endpoint adds a
new target, and patch 8, suggested by Ming and Jonathan, removes the goto paths
before the final helper is extracted.

The result reduces cxl_switch_port_setup_targets() to 53 lines.

That base commit is cxl/next as that seems closest to 7.4-rc1 where I expect
to rebase and resend.

[1] https://lore.kernel.org/linux-cxl/cover.1788475206.git.alison.schofield@intel.com/


Alison Schofield (8):
  cxl: Add interleave encoding validity helpers
  cxl/region: Rename cxl_port_setup_targets() to
    cxl_switch_port_setup_targets()
  cxl/region: Factor out cxl_port_peer_distance()
  cxl/region: Factor out cxl_port_parent_interleave()
  cxl/region: Factor out cxl_port_calc_interleave()
  cxl/region: Factor out cxl_port_setup_decoder()
  cxl/region: Simplify switch port target setup control flow
  cxl/region: Factor out cxl_switch_port_add_target()

Richard Cheng (1):
  cxl/region: Calculate peer distance only for reused targets

 drivers/cxl/core/region.c | 243 +++++++++++++++++++++++---------------
 drivers/cxl/cxl.h         |  21 ++++
 2 files changed, 172 insertions(+), 92 deletions(-)


base-commit: cf15f9f2361dd4002203716b7b878393c0eee4bf
-- 
2.37.3

