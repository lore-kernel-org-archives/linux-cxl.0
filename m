Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9AD1F8AC5;
	Fri, 25 Apr 2025 17:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745602041; cv=none; b=Rw70kz4MUXPCsSJFpVLgbuQHo0dam+B4X1uvLUSYSvYjlwaLeVTz0sNIjeLx8acWm2N9udfPdT4PBb2ojQQH6QZlcS8zVJClp+Nb1BSFGYhr2iNheCQatvUotyN216XVWekX+KwpmxCtX+PN/1GB/TmDsx/6HV/Ekwokc4Hetl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745602041; c=relaxed/simple;
	bh=6wnXlFE6t60LU6w5EVWIxyPg2okC2HiL6f6C4Ybz4Pw=;
	h=Message-ID:Date:MIME-Version:Cc:From:Subject:To:Content-Type; b=guXiVHfN3a3GrbB49rWpHQUO5Qsw8wOVqehNNQX1gPyZFYvburp41Wm10/p5a74yF+WImgujk6XaMTwGKgOKULApRH95Du3RfA/AC/MXz69lQ26DukCBAu0lsJ+m2+3pntmhxr48qHRbrGjejKH4BGVrNbembreSqsQPXiho2HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hA+DNqwD; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hA+DNqwD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745602040; x=1777138040;
  h=message-id:date:mime-version:cc:from:subject:to:
   content-transfer-encoding;
  bh=6wnXlFE6t60LU6w5EVWIxyPg2okC2HiL6f6C4Ybz4Pw=;
  b=hA+DNqwDdJG+GMby17Bjzu/uzkIeZ7gcmqsYi4sFnAsBdpHL/VnrbSCA
   xiJRuhEsRVJOKyTYTNvBiZ4WrtoVynMnUEwmqyO4eL2VUe/Jb7pqHAx2J
   ktHybDys7DhlWI0IsjJcniIFgCejHwsmqMCRDzVCzaND0uxL3Wy1sH6Yx
   IBaIO/COpmQb1ViA26b/txHsLvfeu/y6cdXf7ZWBEQBcRLjBtD/NPldlK
   pqufoQTj+zzyKEezUaSAer76oCBGuWzkssgPg9/3FfSlvcuMlk0G/yPXq
   K46J1/B69Jy/lpqUPV2ZwpIDVLJlG8vEGldsmTySlmckFa2+OZi+0uUQQ
   A==;
X-CSE-ConnectionGUID: cWdlQ+SuQjuC8tHzTfXfJA==
X-CSE-MsgGUID: QcUML9XsQN6fZ+65BThLoA==
X-IronPort-AV: E=McAfee;i="6700,10204,11414"; a="47146044"
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="47146044"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 10:27:19 -0700
X-CSE-ConnectionGUID: Nfy5yUtaQA+unKlAjKNwfg==
X-CSE-MsgGUID: EORhXrtkR/uXXexz9GmQkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,238,1739865600"; 
   d="scan'208";a="133457958"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.108.211]) ([10.125.108.211])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2025 10:27:18 -0700
Message-ID: <025f2312-9588-4807-a8a1-cb265251fcd0@intel.com>
Date: Fri, 25 Apr 2025 10:27:16 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 linux-kernel <linux-kernel@vger.kernel.org>
From: Dave Jiang <dave.jiang@intel.com>
Subject: [GIT PULL] Compute Express Link (CXL) Fixes for 6.15-rc4
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus, please pull from

git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git cxl-fixes-6.15-rc4

...to receive a small set of CXL fixes.

The fixes address global persistent flush (GPF) changes and CXL Features
support changes that went in the 6.15 merge window. And also a fix to
an issue observed on CXL 1.1 platform during device enumeration.

These have all appeared in -next for a few days with no reported issues.

---
The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

  Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git cxl-fixes-6.15-rc4

for you to fetch changes up to 078d3ee7c162cd66d76171579c02d7890bd77daf:

  cxl/core/regs.c: Skip Memory Space Enable check for RCD and RCH Ports (2025-04-21 08:30:13 -0700)

----------------------------------------------------------------
cxl fixes for v6.15-rc4

- Series to fix using the wrong GPF DVSEC location
  - Fix caching of dport GPF DVSEC from the first endpoint
  - Ensure that the GPF phase timeout is only updated once by first endpoint
  - Drop is_port parameter for cxl_gpf_get_dvsec()

- Fix the devm_* call host device for CXL fwctl setup

- Set the out_len in Set Features failure case

- Fix RCD initialization by skipping unneeded mem_en check

----------------------------------------------------------------
Dave Jiang (1):
      cxl: Fix devm host device for CXL fwctl initialization

Li Ming (4):
      cxl/core: Fix caching dport GPF DVSEC issue
      cxl/pci: Update Port GPF timeout only when the first EP attaching
      cxl/pci: Drop the parameter is_port of cxl_gpf_get_dvsec()
      cxl/feature: Update out_len in set feature failure case

Smita Koralahalli (1):
      cxl/core/regs.c: Skip Memory Space Enable check for RCD and RCH Ports

 drivers/cxl/core/core.h      |  2 +-
 drivers/cxl/core/features.c  | 16 ++++++++--------
 drivers/cxl/core/pci.c       | 30 +++++++++++++++++-------------
 drivers/cxl/core/port.c      |  2 +-
 drivers/cxl/core/regs.c      |  4 ----
 drivers/cxl/cxl.h            |  6 +++---
 drivers/cxl/pci.c            |  2 +-
 drivers/cxl/pmem.c           |  2 +-
 include/cxl/features.h       |  5 +++--
 tools/testing/cxl/test/mem.c |  2 +-
 10 files changed, 36 insertions(+), 35 deletions(-)
