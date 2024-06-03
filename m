Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B509125D6
	for <linux-cxl@vger.kernel.org>; Mon,  3 Jun 2024 21:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717448421; cv=none; b=a/hIeRN+GoADmIIw0A64NsteslNZEtccaPcVG62MOK0vbwgyFZ5sJ9UW7WZO6+qOyI/mBkhYLCT4kKmWCiklqQhxxUfJQh8rcL9IyRjin8aJtFa1ZFZ7x/Aej4AjYN7pFN6EACbPjqqRrPTK7cX028debcfcP/HQ43FipV4JNmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717448421; c=relaxed/simple;
	bh=15Dz6M/c6vkV9iZoQxkmIEiLdlN+SSlarwrNOaIH7do=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Jk99TxhEEwG0ezUOq4h4JPky9lb2hVIxuueAbsD1aomx5VEePBo1PU/5jW3VxkALr4+kAfLKEQJqqfIw3N2kHXnkuraq/s0LJZfHtcetfcZY8Lj1820NR1Ej17hQMXgjA/W9jX0iMa9NLPTDZHG+5/4CdtgsX6Jd6MmRLUpIhxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lXhtGgeC; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lXhtGgeC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717448419; x=1748984419;
  h=message-id:date:mime-version:to:cc:from:subject:
   content-transfer-encoding;
  bh=15Dz6M/c6vkV9iZoQxkmIEiLdlN+SSlarwrNOaIH7do=;
  b=lXhtGgeC+hhq+4ZQFYgkSCl2jajxV6R9vYqw9I7JhOYWtBDilwjp1nWK
   wRbNHvBgHpkjrpOsGcK+pIAL9+xPaWEaoeAaOqTycPQ8vWz+c71NxQUW3
   r2rGVOcr/tfba7t15U2rGONBcsGZbKKn7vlWi8e0oUWsxyPRulfo57rQJ
   8k9nbgR9JvePE6CZUa5csCE72hOkz3koWMUqfegJ3nOr893Bxd/DtuM41
   aQ03uQWC6ylRONOHycE2J3Ga9vEGlgX3j5HMwihUnLkXm3/TWTgekISSy
   TrY/VNcbkNwe+LU0wgPd5rgnD+A+T7EyviOk8WgVYvWFDTtyEsgZo7MI/
   g==;
X-CSE-ConnectionGUID: 8Vyw1bYMSLSX2FETDA/AAA==
X-CSE-MsgGUID: BmSQIYXaRaupILjHPasXPg==
X-IronPort-AV: E=McAfee;i="6600,9927,11092"; a="24622514"
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="24622514"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 14:00:19 -0700
X-CSE-ConnectionGUID: drmeqMNDRBGFlT0XA1nliw==
X-CSE-MsgGUID: 4cvqsFDAS3mkFl7sPwYABQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,212,1712646000"; 
   d="scan'208";a="37112632"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.108.165]) ([10.125.108.165])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 14:00:18 -0700
Message-ID: <2d329d00-c5eb-47b2-8529-5cc177fd0770@intel.com>
Date: Mon, 3 Jun 2024 14:00:17 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ira Weiny <ira.weiny@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Subject: [GIT PULL] Compute Express Link (CXL) Fixes for 6.10-rc3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus, please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-6.10-rc3

...to receive couple fixes for the CXL subsystem.

A fix to add the missing linux/vmalloc.h header in cxl-test due to 6.10 changes
that no longer include the vmalloc.h header from the currently included headers
and prevent the cxl-test from compiling.

A fix to address 'memregion' leak in devm_cxl_add_region().

This has build success notification from kbuild-robot. It has been in the -next
for several days with no reported issues.

---

The following changes since commit 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0:

  Linux 6.10-rc1 (2024-05-26 15:20:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-6.10-rc3

for you to fetch changes up to 49ba7b515c4c0719b866d16f068e62d16a8a3dd1:

  cxl/region: Fix memregion leaks in devm_cxl_add_region() (2024-05-28 16:09:17 -0700)

----------------------------------------------------------------
cxl fixes for v6.10-rc3

- Compile fix for cxl-test from missing linux/vmalloc.h
- Fix for memregion leaks in devm_cxl_add_region()

----------------------------------------------------------------
Dave Jiang (1):
      cxl/test: Add missing vmalloc.h for tools/testing/cxl/test/mem.c

Li Zhijian (1):
      cxl/region: Fix memregion leaks in devm_cxl_add_region()

 drivers/cxl/core/region.c    | 18 +++++++++---------
 tools/testing/cxl/test/mem.c |  1 +
 2 files changed, 10 insertions(+), 9 deletions(-)
