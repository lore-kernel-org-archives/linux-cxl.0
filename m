Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421833911AF
	for <linux-cxl@vger.kernel.org>; Fri,  9 Oct 2026 20:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791577482; cv=none; b=eLE55SzEb4r5kmEf8saz+7xOdkXlbK/ZBqKj+ENQwY4imMofB0WY2GO8+PIqFSE1BiLcvkfoCV4ugO0Lg9UpIlLx1j58sckMqY42luC6LqPBQAEA7P3oPYl1UJOy3UimYb44IwbSjJG4xAkwdyJtuQiAXSdhBbrS8PZ4fy7Db9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791577482; c=relaxed/simple;
	bh=EMK4UO2md8gLEAIE2MXi4ygg47yj3LuzoiR/C7LOYUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EYYYEicJakLWmTaLzEdjlWUYvIyvhzK/oo9pn+wtT0GN3Tcf/Xvv1SiHf4hrmhtKEY5RQtWQ45kA1zbdHcnD1weDO9C1juUE7JWfrsYkVbXzrJAVBssiekOSx04xRvWhP0YR4fPYYrkMx09eVZKOrCykg3T/W9ykhqyWclRGHVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XC3nuFGa; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XC3nuFGa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791577481; x=1823113481;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EMK4UO2md8gLEAIE2MXi4ygg47yj3LuzoiR/C7LOYUQ=;
  b=XC3nuFGao6pMmPnUikOD7R5r4xB+1M4KO9pUV+Lt0U8UmZiLD6y3ymXz
   aUdWNKEGwOus9zehQ5P3rlzEbUq99bH6/kU/3XUtOJ6wfLcK13Tvc8mPL
   lOptJ/xlyhdrWl4OngjmrguKjC2DR/BH2SYgVzzQnTTUt1njFoOdBKTOQ
   l6VQ0OYMWvTtfuTd47d1tPhu+XC1N1gECVlkMQccgtkXmMLWDYykjYPcm
   LoFg8K0LfLeo+myfkntQY7sDaLtcyMLXtHt5zEoJByr9ns7Yvt5ER5BKH
   0qt0F8FbrDCqlHSBv5dcx1NQx+Lo+poqQqfoWhNr5b+DEAQEY11CzmyoQ
   w==;
X-CSE-ConnectionGUID: tgLAlcbTRnCmKFJAKVGAlA==
X-CSE-MsgGUID: ZSA4eoc7RdOR1tF82WVBgw==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="376935"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="376935"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 13:24:38 -0700
X-CSE-ConnectionGUID: kgEa9hVKSAm4DExW/+MSYQ==
X-CSE-MsgGUID: 5x/gkRHdTlOGFrB9n/Ft/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="743013"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.202])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 13:24:37 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>,
	Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH 0/7] cxl/region: Refactor cxl_port_setup_targets()
Date: Fri,  9 Oct 2026 13:24:00 -0700
Message-ID: <cover.1791575481.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Patches 1 and 2 prepare the code that moves. Both patches are suggestions
that Jonathan offered on the mixed gran series, and Patch 2 is actually 
plucked from the mixed gran series where it sat as a prep patch.

Patches 3-7 each move one step at a time into its own helper, which leaves
cxl_port_setup_targets() at 58 lines.

The refactor patches make no functional changes and aim to be mechanical
and easy to review. I tried to avoided all 'while you're at it' changes
that would muddy the mechanical split.


That base commit is from cxl/next, as of this moment.

[1] https://lore.kernel.org/linux-cxl/cover.1788475206.git.alison.schofield@intel.com/


Alison Schofield (7):
  cxl: Add interleave encoding validity helpers
  cxl/region: Name the interleave locals in cxl_port_setup_targets()
  cxl/region: Factor out cxl_port_peer_distance()
  cxl/region: Factor out cxl_port_parent_interleave()
  cxl/region: Factor out cxl_port_calc_interleave()
  cxl/region: Factor out cxl_port_setup_decoder()
  cxl/region: Factor out cxl_port_add_target()

 drivers/cxl/core/region.c | 252 +++++++++++++++++++++++---------------
 drivers/cxl/cxl.h         |  21 ++++
 2 files changed, 176 insertions(+), 97 deletions(-)


base-commit: 71392a644e88c6bb921cdf12cb2b00adec070fe4
-- 
2.37.3

