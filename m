Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4082060EC4
	for <linux-cxl@vger.kernel.org>; Tue, 13 Aug 2024 11:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723547585; cv=none; b=ZTC4UVIkd0tsIbOMd0AhzGpi7ZUxCDkKwB+ZZDAsbRRt424ZnMCm41Emj3oFAUuFMwv+vOgVQHzYyAxY7EmYcuY2Uv/z6xoIZvqJ0BqZgGUjXggVj/72hTA682CSlSKoYa93Zi4vh0YqO1k8U2XLQIPOiHu3Wp4pukZES6gwqps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723547585; c=relaxed/simple;
	bh=EUQDh+TSR+fv0VAMud59G+hBzON2/Tw97ukHseyk07o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fRnzicq+7ztXejJvrcOF82ThrGV0yYRb5pjHH+Qyyo2vy3/UexfAiXbLIYXtwmIEBtIq6WDHtSUuloysTSVLhCOL7zn3xdcrbGALDbQDodC6hTkxufwYl+GUhb08vE4yezFNRhZci0/hocgHuh8NiR76xrv5U+v6of9zMm/bpWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R09m7yPv; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R09m7yPv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723547584; x=1755083584;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EUQDh+TSR+fv0VAMud59G+hBzON2/Tw97ukHseyk07o=;
  b=R09m7yPvI09ag6/921I0eB67aiB73MxWStwpTZf05ViBC7JpEFuY8k80
   gUF6PFYz4s4kkYsPxw4kWv8drGpVHzHgJKlF2PFWY/CCJDP7hENUfQ3qY
   g9LaVtCFJzKtUVsONJ3bCBAZNcwzrh9L72cqgDcpj1U/njQl0AY86risB
   TWPH14aWo6sk75Nn+mQJJZwNvlB5gERHPC2eYjkqQMsD1k8xdh0A/aQID
   QL35cTPqOSoFU/Ego4BxBIktJRS4amtSc2TNxsnxkENUv9cd+PRJtVvC9
   kwcLWiB0iHsgy5GJvA0bZpjoqxaMezHpDl2T47gw2gJiOMUzPFUVIEOmz
   A==;
X-CSE-ConnectionGUID: JeU17OczQ/68ZW1eTDJWLg==
X-CSE-MsgGUID: 4KXGqdbuQMuF3Z+eEp7I1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21262261"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="21262261"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 04:13:03 -0700
X-CSE-ConnectionGUID: DEKhz+3OQcqz9ujy11IwEg==
X-CSE-MsgGUID: T9MaBbDuTX6+IUWnyujCtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="58568736"
Received: from tower.bj.intel.com ([10.238.157.70])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 04:13:01 -0700
From: Yanfei Xu <yanfei.xu@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com,
	ming4.li@intel.com,
	yanfei.xu@intel.com
Subject: [v3 0/4] Fixes for hdm docoder initialization from DVSEC ranges
Date: Tue, 13 Aug 2024 19:05:28 +0800
Message-Id: <20240813110532.870869-1-yanfei.xu@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first and third patch are intended to fix potential issues regarding to
retrieve and record DVSEC ranges. The second and fourth are cleanup.

v2->v3:
- improved the commit message of patch1 to indicate potential impact of
  the change.  (Dan)
- Dropped un-appropriate "Fixes" tag. (Dan)
- Dropped the patch2 which is a code movement in original patchset.
- Separated the original patch3 into cleanup one and logic change one which
  are corresponding to patch2 and patch3 in current patchset. (Dan)

v2:https://lore.kernel.org/linux-cxl/20240809093442.646545-1-yanfei.xu@intel.com/T/#t

Yanfei Xu (4):
  cxl/pci: Fix to record only non-zero ranges
  cxl/pci: Remove duplicated implementation of waiting for
    memory_info_valid
  cxl/pci: Check Mem_info_valid bit for each applicable DVSEC
  cxl/pci: simplify the check of mem_enabled in cxl_hdm_decode_init()

 drivers/cxl/core/pci.c        | 74 +++++++++--------------------------
 drivers/cxl/cxl.h             |  2 +-
 drivers/cxl/port.c            |  2 +-
 tools/testing/cxl/test/mock.c |  4 +-
 4 files changed, 23 insertions(+), 59 deletions(-)

-- 
2.39.2

