Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB2833B6C5
	for <linux-cxl@vger.kernel.org>; Fri, 27 Feb 2026 18:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772215748; cv=none; b=ZNGSoQrHhCWnLvEGQEw7YGAO6nOkteXe6NWT6kFAD+3L4QLPC6mkMdoDssdwr6qW/+kVGnQNdHre+gNxXzm9ChSsc98r0N1ocJDjLKFJQNB10cGnr8SR/6O7Pwy6WJTfmPPsQjUvnenyzxkL/MqvL+suq33ayxE59t7Zo/BuNZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772215748; c=relaxed/simple;
	bh=r0NCiUJAqdRbSy/Hnt4/yAfn+frXH/l8cqyxkJmU590=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=LNHkB3iZzm50rVDO2OwHGE+KG8RO+mX+shv2VnAKfQ9+5RsXkk7cxWck4Z23n372iyLzDY6RN8P/5VqloKcHa+f7EbE6RBg4i9bWoMvft+dNJuGtDSnBs109fymTrlMw25ncayAKxKuyHeuSO3NsOXLhIRM9kpbWadOccqH0On8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ru56dJ3O; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ru56dJ3O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772215746; x=1803751746;
  h=message-id:date:mime-version:from:to:cc:subject:
   content-transfer-encoding;
  bh=r0NCiUJAqdRbSy/Hnt4/yAfn+frXH/l8cqyxkJmU590=;
  b=Ru56dJ3OvtOU7SruIsiLGv6blIayKmOJrnnXFOPDj06dZb7Yqv9i445p
   oYcjACsRTELgmUz2UN1xekDNvZaYM2Yg03w3SsOZgAalq80CyMmMdMofe
   J3iyKlQ3q+fNM8K0Q1ddr0u6INtkGNr6ORmj6E/AEzc8oosUz/EaEbadH
   j5JuIMfgIIyCMh0L/5bZVBNXmZQP79WzAx3kWBJPlPH62NWjfn/jMxeVM
   YWPoiLxhrdK2iEFBkubUBx8MNc3AsNa9o/ArQLtIrJP/IjobjQ6eGowpX
   XRiMUz5DcEfIYGuNi0zymv60O2u7C0jIYn5BZdfkaZeJqMR8QM2uPhE7y
   Q==;
X-CSE-ConnectionGUID: Bo/iO82ZR52SC/nRcZnnGw==
X-CSE-MsgGUID: PZtaI37vScGE0i7/mZfiHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="98770781"
X-IronPort-AV: E=Sophos;i="6.21,314,1763452800"; 
   d="scan'208";a="98770781"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 10:09:06 -0800
X-CSE-ConnectionGUID: MRju/VTjQXSjEoq1SeFk2A==
X-CSE-MsgGUID: MSSBBPg/RAmt73rczPLsHg==
X-ExtLoop1: 1
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.111.205]) ([10.125.111.205])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 10:09:05 -0800
Message-ID: <ec463b87-7b6b-4b4b-a993-ec8bea26d2d0@intel.com>
Date: Fri, 27 Feb 2026 11:09:03 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Dan Williams
 <dan.j.williams@intel.com>, Alison Schofield <alison.schofield@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Vishal Verma <vishal.l.verma@intel.com>
Subject: [GIT PULL] Compute Express Link (CXL) Fixes for 7.0-rc2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus, please pull from 

git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-7.0-rc2

...to receive a collection of CXL fixes, including couple fixes of bugs due to race conditions.

These all have appeared in -next for a few days with no reported issues.

---

The following changes since commit 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f:

  Linux 7.0-rc1 (2026-02-22 13:18:59 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-7.0-rc2

for you to fetch changes up to e46f25f5a81f6f1a9ab93bcda80d5dfaea9f4897:

  cxl/region: Test CXL_DECODER_F_NORMALIZED_ADDRESSING as a bitmask (2026-02-24 08:33:30 -0700)

----------------------------------------------------------------
cxl fixes for v7.0-rc2

- Fix incorrect usages of decoder flags.
cxl/region: Test CXL_DECODER_F_NORMALIZED_ADDRESSING as a bitmask
cxl: Test CXL_DECODER_F_LOCK as a bitmask

cxl/mbox: validate payload size before accessing contents in cxl_payload_from_user_allowed()

- Moving of devm_cxl_add_nvdimm_bridge() is required for the race fix.
cxl: Fix race of nvdimm_bus object when creating nvdimm objects
cxl: Move devm_cxl_add_nvdimm_bridge() to cxl_pmem.ko

- The port_to_host() is used to fix the race window without host lock.
cxl/port: Hold port host lock during dport adding.
cxl/port: Introduce port_to_host() helper

cxl/memdev: fix deadlock in cxl_memdev_autoremove() on attach failure

----------------------------------------------------------------
Alison Schofield (2):
      cxl: Test CXL_DECODER_F_LOCK as a bitmask
      cxl/region: Test CXL_DECODER_F_NORMALIZED_ADDRESSING as a bitmask

Dave Jiang (2):
      cxl: Move devm_cxl_add_nvdimm_bridge() to cxl_pmem.ko
      cxl: Fix race of nvdimm_bus object when creating nvdimm objects

Davidlohr Bueso (1):
      cxl/mbox: validate payload size before accessing contents in cxl_payload_from_user_allowed()

Gregory Price (1):
      cxl/memdev: fix deadlock in cxl_memdev_autoremove() on attach failure

Li Ming (2):
      cxl/port: Introduce port_to_host() helper
      cxl/port: Hold port host lock during dport adding.

 drivers/cxl/core/core.h   | 18 ++++++++++++++++
 drivers/cxl/core/hdm.c    |  2 +-
 drivers/cxl/core/mbox.c   | 11 ++++++++--
 drivers/cxl/core/memdev.c | 13 ++++++++----
 drivers/cxl/core/pmem.c   | 42 +++++++++++++++++++++++++++++---------
 drivers/cxl/core/port.c   | 52 ++++++++++++++++-------------------------------
 drivers/cxl/core/region.c |  4 ++--
 drivers/cxl/cxl.h         |  7 +++++++
 drivers/cxl/pmem.c        | 22 +++++++++++++++++++-
 9 files changed, 117 insertions(+), 54 deletions(-)
