Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.19
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793650570;
	b=E5e+Agy1m1wBHYn686kpP8C6HAKFpbzzc1Cb6yaoj1vGym2V+6ZMVBMat6g84CmP54wT
	 P622mduwd+Yjk+jyXhULjQJ5a54mgGIpGx9cGV8T2vrYhLd/MctRCktOcMK0SwkY/bSVQ
	 mwHJ6w0t7v5WGVxlVjJvw0fCQIKewIh9xLMvxGR/j/R5L2gEiZq5n46FPjiUV8AtWRGpI
	 DUlRmR9zmHVgppl1NDtsutyysvf3wzyJVDAdhZAyf6YGfttm5pBgwK991gCQT0mM7kcph
	 Qm7EP2MtT4yIe8pN0xR4nF3VSOqBaO1cpey3Q6cs/DoyolJMffMjNUdM+8uQxKVaT/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793650570;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ztTjqeQs6bVCLNy+6AyI1WTQJ9tKkNkIeBdvuOj+cHw=;
	b=pWHz+GxfnLdwwlVCv0QKaZJ3XjnkwejsIHcucKxqHb4c71vhikZRjksCp/k80sTakuWh
	 IG0LTGcPq6mkcGmzz5k58XukYE9hg3Jbt2w8lRm2IwVAo4aoDwFBoRufkOr/rayIPB3Yv
	 ctRAUFnfxrwJCY9xa80FhVz5rrgtuAEeX9rRyrv56ztSYVlEP8waoYtgYd5zep76fR410
	 RdLtEanG7ICzXDD1pUgDP0V1X72zZ5Yv3mwXXpRJIIbyuAhntN5beAYVKDO9DWm1FZ/lg
	 spPzmKQQ19UJUhVDeQTrB5h9gY9lCSnnyd5vv+BsZ0SWAFeDAC3LLN5PtZVOxMqWqcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="hzqhR/8J";
	arc=none smtp.remote-ip=192.198.163.19
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CCA606A330
	for <linux-cxl@vger.kernel.org>; Mon,  2 Nov 2026 20:16:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1CCA606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hzqhR/8J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793650569; x=1825186569;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eQRy61cIwe0wwF+wbUonegbm4Mn53+TDE5IlkEy1Gk0=;
  b=hzqhR/8JlHuD8uLH7INMF6Iyl6WMHr9CpGU7fI8WsOU4PlfhOFDAkqGF
   7GzIpYATTzLOfY+lAINRoXVA6AATaLN80Q4rvi7OxMbILiumSugZcHiHu
   RS6kL40ukVxQc7P5/v2smHJQzf1JePpG1JzZan8IU8kDv5y4F9BskrOrl
   n3M1TY90+VxDrlGGjdNKRQUx8VBrfAzFR722qCeZve/6VvXJbW4b1sQvZ
   19JUOraf0ccvEQIJzRr2VkWlDd8U0BfBYu6s/+z+8/oSqAWxq0iaVB7l/
   IuPSC+m+D0ChO30R1h5fOYFqH7TxxwMsnJHONC0eDCL7jOXl88uFv0q+j
   A==;
X-CSE-ConnectionGUID: uEerSNcISzmcU8h45eeRmQ==
X-CSE-MsgGUID: GBTmaTcnS5W9V10I1IcAfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2463984"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2463984"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 12:16:08 -0800
X-CSE-ConnectionGUID: SCLFIxx8QlWuXPIlMcM67g==
X-CSE-MsgGUID: OoFaGujbRmmfuQQ+HevmGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="6215523"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.125.109.173])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 12:16:08 -0800
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
Subject: [PATCH v5 0/9] cxl/region: Refactor cxl_port_setup_targets()
Date: Mon,  2 Nov 2026 12:15:55 -0800
Message-ID: <cover.1793649898.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Changes in v5:
- Update patch 4 commit message w test result & benefit info (RichardC)
- Rebase on 7.4-rc1
v4: https://lore.kernel.org/all/cover.1792263750.git.alison.schofield@intel.com/

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


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.37.3

