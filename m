Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E863161
	for <linux-cxl@vger.kernel.org>; Tue, 30 Apr 2024 00:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714437268; cv=none; b=meAVITrArZFUT8hbWcK0KbqeZG5vq3bZpVau1KCHq/zRTnV8vufx2fXiYYGVmK5F+rOPU2LrNRDhDhG0yCBxZ/Nrpkq8jFfuLOpvoHxSbR2mPTsZdY5YWXZ/hY9hR+OR/z3IEcd3a7UQLpNoz7nW1r/VkvPZGHyNrGbsIZ/x+JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714437268; c=relaxed/simple;
	bh=5IEEfQ9GP2N9fEohhlCWFHcMNsslAzHjK++VJsG4XXA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H58/6p3zR81oPYgEu0k1Sw9uvk71Yd8ORE14tmqFzJ9fKO2WsMDPj1As6TFOzRnb8U0baFfTAvflJEHXPGVELE0c7OBZ/Jl9emC5eR2gP5TzIo4TyhE+ytQAocMh2/TUdLwwkpxwIkOwzP0ZRW/P052NrGwUtIFwpk4AVrdoEtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xee1u35J; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xee1u35J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714437266; x=1745973266;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5IEEfQ9GP2N9fEohhlCWFHcMNsslAzHjK++VJsG4XXA=;
  b=Xee1u35JkZPHaxdtIZpqVAyCiy2nY+/Djs85JkhvYP0HG9e7gMfZwsF8
   KPLm3D4M3l5dshdbD1VzzsxM29+cYlfbpbl+VSOGnUR2sZZbedUBe5NSV
   qt0JWeYTITvbmzGcerRGTSWF3lxqZKFFgV1gRCZnnuj8/wRhJAQImehMx
   hXw38r7nPMjAly5dZKEQij0Bp0BXVVym33trL6mYDsmlIkddtmn7puj2U
   MZ8IfdASBRWk3gK322bWygcJS/DFqgFe05COiVghQIwzCx+G7gTm88MrD
   m6ahzGUD4Btkpo80C3iToCzaG/vs9VYMfOsMILj/HPYQCzV3C5Xag23cn
   Q==;
X-CSE-ConnectionGUID: Okqx/AKxSDCNKoW7/6ogTw==
X-CSE-MsgGUID: 1mZBruOiSwmgKV4nQEIxvg==
X-IronPort-AV: E=McAfee;i="6600,9927,11059"; a="10289547"
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="10289547"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 17:34:26 -0700
X-CSE-ConnectionGUID: OAAvwR0SSpiFucnpBz08kg==
X-CSE-MsgGUID: UabeYk7GQAqnzBq8MChZqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,241,1708416000"; 
   d="scan'208";a="57149080"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.192.110])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2024 17:34:25 -0700
From: alison.schofield@intel.com
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Shiyang Ruan <ruansy.fnst@fujitsu.com>
Subject: [PATCH v5 0/4] Add DPA->HPA translation to dram & general_media events
Date: Mon, 29 Apr 2024 17:34:20 -0700
Message-Id: <cover.1714435815.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alison Schofield <alison.schofield@intel.com>

Changes in v5:
- Add Shiyang Ruan's DPA mask fixup patch[1] (Dan)
  The DPA flags fixup is a required precursor patch to this set so I
  updated Ruan's patch based on the last review messages and added it
  here. That patch can be merged ahead of this set.
- Link to v4: https://lore.kernel.org/cover.1714102202.git.alison.schofield@intel.com/

[1] https://lore.kernel.org/20240417075053.3273543-2-ruansy.fnst@fujitsu.com/


Begin Cover Letter:
Add HPA translations to CXL events: cxl_dram and cxl_general_media

Patch 1: 
The DPA mask fix up patch must precede or be part of this set.
It fixes the issue where upper 32 bits of DPA are truncated.

Patches 2 & 3:
Before adding the new support, do some housekeeping and move related
helpers to the region driver because there is no looking up region
related info without CONFIG_CXL_REGION.

Patch 4:
The new functionality is introduced - cxl_dram & cxl_general_media
events. Lookup and log the DPA->HPA translation along with the
region name and region uuid.


Alison Schofield (4):
  cxl/trace: Correct DPA field masks for general_media & dram events
  cxl/region: Move cxl_dpa_to_region() work to the region driver
  cxl/region: Move cxl_trace_hpa() work to the region driver
  cxl/core: Add region info to cxl_general_media and cxl_dram events

 drivers/cxl/core/core.h   |  14 ++++
 drivers/cxl/core/mbox.c   |  36 ++++++++--
 drivers/cxl/core/memdev.c |  44 -------------
 drivers/cxl/core/region.c | 135 ++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/trace.c  |  91 -------------------------
 drivers/cxl/core/trace.h  |  50 ++++++++++----
 include/linux/cxl-event.h |  10 +++
 7 files changed, 226 insertions(+), 154 deletions(-)


base-commit: 4cece764965020c22cff7665b18a012006359095
-- 
2.37.3

