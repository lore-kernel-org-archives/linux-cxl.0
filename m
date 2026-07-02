Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D23431E53
	for <linux-cxl@vger.kernel.org>; Thu,  2 Jul 2026 00:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782952256; cv=none; b=DSUU421O+tXe3t2UPJZWSpHmG0VPQ4LJ9P0hAgmSF4E/WQ8Optx7U0/LRUVR+jhPQh9TMcg5+4QJODVLoPltxPRvsKyD0BJJ/aNOEluaCEoK+bXMCVdfRtT7vtkKiMHfZgiqaPwciR6SdBtP7JTGBVHG/07HaZG3AOP6D5DYeQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782952256; c=relaxed/simple;
	bh=8UUuY5kyQOE0N2BmGcIgOOi3OQASv+A+Hy4Z0CG9pS8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E9m21db9La7s4Ul0+6/oshL0P7HCCshmsNFu/PDjJjUpGY1HBM2cgyB4YAkBw9wGakQ2+M1+FlF+QxsZLiOWbzD1YOilE2oxcvc+74ydrxl/WzKT4jVbkXFbhCB3NyKSMrPCXEW9ckHOWS/Fhe0JRqwzvEGt0WOKqAyCgJqO9g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FNm6NbgJ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FNm6NbgJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782952255; x=1814488255;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8UUuY5kyQOE0N2BmGcIgOOi3OQASv+A+Hy4Z0CG9pS8=;
  b=FNm6NbgJH0pyf5+t9VK0nZl5uiwnD0kIcVla06Qa+1e7zCC8+rvp6p1C
   YA6Egp+EVRnqM63+NK22g1O3NMYmG35cMi1ECu+TKN0Ffw/AV7iGKdlTv
   cAupuMWPwE6xTk0rNqeI9h9UzDoKwpaBybFP1Ws2uLF8nI6q1phdmdJVS
   F/HcT2N727Qlv+z1nCkTbxjydHdOO9cFuT38q6TDelD9ft7UldNjSPIUS
   Gg8e9t7HoDII398GBZOtZtWke63wgqqn3inz4kwdELwwNTHGC8LwABGMZ
   RjqDgeVzQGuA94OC3l/w7mE3MYG0sMR/X0RtJofwBAtJjRxesMEKIBJIK
   A==;
X-CSE-ConnectionGUID: Q7rNOeE3RnSLWdthJBPxsw==
X-CSE-MsgGUID: qWgj4Vp3TpmlZ1GLNElH6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11834"; a="83565770"
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="83565770"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 17:30:54 -0700
X-CSE-ConnectionGUID: ifdbPLttTYO0vPNulZqqDw==
X-CSE-MsgGUID: MDgJrDHcRPCe8bg8qnXTDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,142,1779174000"; 
   d="scan'208";a="275920051"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO localhost) ([10.124.221.139])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2026 17:30:53 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Dan Williams <djbw@kernel.org>,
	Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
Subject: [PATCH v2 0/3] cxl: Format the device serial number as unsigned
Date: Wed,  1 Jul 2026 17:30:43 -0700
Message-ID: <cover.1782948930.git.alison.schofield@intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series supersedes the previously posted standalone fix:
  cxl/pmem: Format nvdimm serial number as decimal

That patch addressed the immediate auto-unlock failure caused by the
kernel formatting the nvdimm security key description differently than
the decimal 'id' sysfs attribute used by ndctl.

Further review uncovered a second formatting issue affecting the same
serial number. The CXL device serial number is a u64 PCIe Device Serial
Number, yet several kernel interfaces format it with signed "%lld".
Devices whose vendor OUI sets bit 63 therefore appear with negative
decimal serial numbers.

Serials with bit 64 set are expected. The most significant byte of the
PCIe Device Serial Number contains the vendor OUI, so vendors such as
Montage naturally produce serial numbers with bit 63 set.

Rather than merge the decimal-format fix and immediately follow it with
another patch changing the same code to "%llu", fold both fixes into a
single series that consistently formats CXL serial numbers as unsigned
where appropriate and adds cxl_test coverage for the large serial case.


Alison Schofield (3):
  cxl/pmem: Format the nvdimm serial number as unsigned decimal
  cxl/core: Format the memdev serial number as unsigned in TP_printk
  cxl/test: Assign one mock memdev a full-width serial number

 Documentation/ABI/testing/sysfs-bus-nvdimm |  3 ++-
 drivers/cxl/core/pmem.c                    | 10 ++++++----
 drivers/cxl/core/trace.h                   | 10 +++++-----
 drivers/cxl/cxl.h                          |  3 ++-
 drivers/cxl/pmem.c                         |  2 +-
 tools/testing/cxl/test/mem.c               | 15 ++++++++++++++-
 6 files changed, 30 insertions(+), 13 deletions(-)


base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.37.3

