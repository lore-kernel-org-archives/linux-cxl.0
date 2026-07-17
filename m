Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E02832B130
	for <linux-cxl@vger.kernel.org>; Fri, 17 Jul 2026 21:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784324581; cv=none; b=Bqj84b8IQZfE9dbmIYE+AVexzJy+LM9HS0asy1DjvLxvxTpun4QIhpLu8bcKebAyVhDGEcWNNyhg7qY+2GWrOGMH5hoyFZkV3Ur1ZdPl2/Vzdk+c6G8OsTB8iJID+ywkD6mFaYPCS4Rg2VzejMxWDPFYPaCuMbTB9SSMjL9P9ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784324581; c=relaxed/simple;
	bh=lV3smshxi9pWPUBETyVqlLyFCCFzirsc1KBXJ+SBIxk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eH+PJ8IHEBa9rmmIdj27LtJq5jdcexuhghujRpd/QDUpiz2KSP8TL+hrmQ3V1Y3x2eKh287iphvsx0vZX8KDfwtpSPZqDEiEejMCwJn2IGsWgFOqgQHn1YnEU3AQuXIqWMvCYJIAgyv0Jl80enGEolUOZu4+cleli3ZuXlEXDsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kBd4yQEG; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kBd4yQEG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784324580; x=1815860580;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=lV3smshxi9pWPUBETyVqlLyFCCFzirsc1KBXJ+SBIxk=;
  b=kBd4yQEGFUNrwQnj/Z9ymrWOXTFZ4CIcDPem8iNhINJowU92pgwMxGwD
   rP3Wiu8zUeaBxwwlHuhCR6pujDO2S36/9v6F5Tl2EtDz9M8F13fym7QIc
   R6+G5aOryiJJjQ7GO/ors82cLs7mgHZ/xyT0zkfakZFGNoh/MWHWaUCaU
   6LIFUCt6aaWVnKPaxrLwZrdSNlBM1TPnflWZvFpSG3t1rEghnBfNROkWV
   VA14gehTxhY7LTVCW2zm0et7jpFgeT72lu+R44gEQgO2SzJ3nktUqOfVm
   EUF7zEghs5TMVJR4lYTY5440YPDqGCvn/h41cEyVCYWvmNUq6lS2eQ3lE
   Q==;
X-CSE-ConnectionGUID: FbBtNEBZTJKwZVSgO/aeFw==
X-CSE-MsgGUID: yvzlNY87QmSE6Z7y5+Qb3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11849"; a="84129138"
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="84129138"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 14:42:59 -0700
X-CSE-ConnectionGUID: 1ukMMWkgT4amkBm1VKAjcQ==
X-CSE-MsgGUID: PEdWZANzQP2a0dbqeRhBHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,170,1779174000"; 
   d="scan'208";a="261161249"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.59])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2026 14:42:59 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org,
	Srirangan Madhavan <smadhavan@nvidia.com>
Subject: [PATCH v3 0/3] Harden HDM decoder enumeration
Date: Fri, 17 Jul 2026 14:42:45 -0700
Message-ID: <cover.1784322343.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Changes in v3:
P1: Move zero-target reject to init_hdm_decoder() (RichardC)
P3: Reset commit_end via a devres action after decoder teardown (RichardC)

Changes in v2:
P1: Handle uncommitted decoders (Sashiko)
P1: Reject switch decoders with zero targets (Sashiko)
P1: Add in code comment clarifying target_count (Sashiko)
P1: Update commit log
P3: Reset commit_end on the failure path only (Sashiko)
P3: Update commit log
No changes in P2


Here are 3 Sashiko reported cleanups.
Only the first includes a link to the complaint, since the others did
not originally appear on Lore for me to add public links. 

Srirangan: I believe the first 2 of these also address pre-existing
issues Sashiko posted in reply to your reset series, Patch 02/11.


Alison Schofield (3):
  cxl/hdm: Reject switch decoder interleave ways that overflow targets
  cxl/hdm: Make switch decoder target parsing endian-safe
  cxl/hdm: Restore commit_end when decoder enumeration fails

 drivers/cxl/core/hdm.c | 65 ++++++++++++++++++++++++++++++++++++------
 drivers/cxl/cxl.h      |  2 ++
 2 files changed, 58 insertions(+), 9 deletions(-)


base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.37.3

