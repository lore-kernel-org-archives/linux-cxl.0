Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C863D8121;
	Fri,  3 Apr 2026 20:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775249975; cv=none; b=E/mayogfYv9QqIFqFFFyFb+MP/QZKhWhyiAqAxNiHOveKWwlIqvaeWn6hbeyanns5QvUBCydoUtaVyrU34yayWA4/LVfD1P6zpc7hL0v1ctySvrgS7uKLf1N7AGNP/BKZSgpQfF4XFJLLgOowFC+BQnDjw5EeubCfQmRT/jg7jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775249975; c=relaxed/simple;
	bh=dL++QJsibk9lkPeG21ALcYl1JSt+anuRAuIZNBgU438=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GybJYRpBiISCN49og/jhNnOKef+FUqG9yfRtlrLo7/sZ2GIG74CapThZ1UoKP6eGyhMG4fo1c320uZNbymykpcxF/+JVhmTzLIuUOXfMsMBeZivzUYg2jtZ701zE6QnDABHu4NNA7lTbgKKlB1ccdQwFBaTCDfWp0Myfk09voGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BeKQmHqE; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BeKQmHqE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775249974; x=1806785974;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dL++QJsibk9lkPeG21ALcYl1JSt+anuRAuIZNBgU438=;
  b=BeKQmHqE9iPDrGicAZ7lKl4y2LeuUPR+ugusGCbdWx7rYR3/WG+E40AF
   5CEcr4e5hlhsi8P3TGj8Qoswh2yMe1bLNxc0RNJ2y5Y39CUE7eBYvarQu
   RJrAT+qbwczV+UfIS2MHD25etG+Md41L7PVGDMuVCWVIltVPylNt8OLwc
   uL3mit3uoBRA1BkxX62FkbCSW7c+Xn8JfvL6Ppk3bTSC1fiOmdoLXos0d
   3/F27Yaeit7eEwCt3TiWxzx5U8nYH4NNThcC74oC/xUfy2+/62M40l1Z/
   022PSc6y/qK2c/8dcAXeNVMv9/wVuOq4DckWz7IFeUOnK+C4F4FdlLxHt
   Q==;
X-CSE-ConnectionGUID: v18kfpa+RQqAmfFyycpzSw==
X-CSE-MsgGUID: Ry54W21wSFCyk48gwO4uLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="76281467"
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="76281467"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 13:59:34 -0700
X-CSE-ConnectionGUID: OjnSndqwS9223y79fjJ9GQ==
X-CSE-MsgGUID: wd2Lr3iYQtSGW0ReeeCdDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,158,1770624000"; 
   d="scan'208";a="265280475"
Received: from dwillia2-desk.jf.intel.com ([10.88.27.145])
  by orviesa001.jf.intel.com with ESMTP; 03 Apr 2026 13:59:33 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: dave.jiang@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alejandro.lucero-palau@amd.com
Subject: [RFC PATCH 0/4] cxl: Region attach for accelerators
Date: Fri,  3 Apr 2026 14:00:46 -0700
Message-ID: <20260403210050.1058650-1-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here is a collection of proposed fixups to get basic CXL accelerator
driver attachment operational. The primary goal here is communicate the
auto-assembled region parameters to an accelerator driver while also
following existing CXL subsystem lifetime rules.

It is RFC due to lack of testing, but passing basic smoke tests so far.

It applies on top of the latest state of the for-7.1/cxl-type2-support
branch in cxl.git [1].

https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-7.1/cxl-type2-support


Dan Williams (4):
  cxl/mem: Add support to cleanly continue after attach
  cxl/region: Move region lock error code to -EBUSY
  cxl/region: Block region delete for locked regions
  cxl/region: Introduce cxl_memdev_attach_region

 include/cxl/cxl.h         |  16 +++++
 drivers/cxl/core/region.c | 136 ++++++++++++++++++++++++++++++++++++--
 drivers/cxl/mem.c         |  14 +++-
 3 files changed, 161 insertions(+), 5 deletions(-)


base-commit: ccabeb15ced4c06eeff7e35d6a54e7835d3d160a
-- 
2.53.0

