Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E18032C92A
	for <linux-cxl@vger.kernel.org>; Fri, 14 Nov 2025 16:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763136615; cv=none; b=rnr0kMGqqCqcOk9vOgilHwjTTLThw9bWh58EBqTdkADGcjL/TXY2Rm2RpqMof3gQG/um4cwuynZ0WUkN7rjGVeiJjIfvPBGqUEYciOUETrZKlcdl3P8lGn0Dt4c1T2t3Z7vGesSROGSDxTtMe7NCViEqGou1F0zOAVvQDXKHgRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763136615; c=relaxed/simple;
	bh=6RcmXBgeAZuZPoaR+umH1iEjQUVYf+E8rswrOyPP9Pw=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=BLnxZVbHFwr5qAsGS4mwNW/mIID+TChwNFvUaK1fNHWwmnFTl211XoYy0oykOy5/J440rOLLX3tF8mkXrWbXhtxP7g2By36KKuTQqn8TRyyFDymoLfBkgpY/Rh/TyzzrJ4ULmTKEnl+R1s4XuYDHIVn2ziQbKqLv21NjLtd9px8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ahCjHjhp; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ahCjHjhp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763136613; x=1794672613;
  h=message-id:date:mime-version:from:to:cc:subject:
   content-transfer-encoding;
  bh=6RcmXBgeAZuZPoaR+umH1iEjQUVYf+E8rswrOyPP9Pw=;
  b=ahCjHjhpmwOlVwxi8V5l8o4bfocEya8whGHAbJIzkKdxEH5GL7YhkZL9
   wusVyxLFnwQGFpO0lDbWTDgih+K+QZubu1n1miIMyxFNmCS9MMQV6Yjmn
   CO+GMuyHKHATXKRxAHXG+/ykvVhZJCYVIqYZE9ELKnLatLW/Fa+/YEOCY
   RODxGTj44YdeaFgY+RHCIKnpvbvvWgZe/UzQNcGvPX/xZJ2CtnO2j3Q5L
   w7mUEf33zrqOC+wroFAwUkN+doX9ET57dE55a67+z6ADRv0HJPM54u4VP
   KsPTUigg0ADnq6EI//C0spdGeZGtCHiJ7HlHPT/PMfk9lQd4PZbOe/bvQ
   w==;
X-CSE-ConnectionGUID: P1cVnTSeQt6uBiHPAT1RVw==
X-CSE-MsgGUID: bLUxzyTdRRm4hJX+/454EQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11613"; a="87881885"
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; 
   d="scan'208";a="87881885"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 08:10:13 -0800
X-CSE-ConnectionGUID: f6C3l3Y/SUK/CUbvO+vyjA==
X-CSE-MsgGUID: p6pZFZK+SkaJavccevNVUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; 
   d="scan'208";a="194247221"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [10.125.108.188]) ([10.125.108.188])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 08:10:12 -0800
Message-ID: <b263ef64-1ae6-49ff-88af-a1f69c545837@intel.com>
Date: Fri, 14 Nov 2025 09:10:11 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Dan Williams
 <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>
Subject: [GIT PULL] Compute Express Link (CXL) Fixes for 6.18-rc6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus, please pull from
  
git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-6.18-rc6

...to receive a small collection of CXL and related fixes.

The fix on the check for Generic Initiator device handle is a change to ACPI
SRAT handling code. But Rafael has deferred [1] to me to maintain CXL related
drivers/acpi/numa code.

These have all appeared in -next for couple days with no reported issues.

[1]: https://lore.kernel.org/linux-acpi/CAJZ5v0grihVDor12BXU3-tAiQ5WH6rK+AZK8aTtaUa3cq1i0jA@mail.gmail.com/

---

The following changes since commit 211ddde0823f1442e4ad052a2f30f050145ccada:

  Linux 6.18-rc2 (2025-10-19 15:19:16 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-6.18-rc6

for you to fetch changes up to 214291cbaaceeb28debd773336642b1fca393ae0:

  acpi/hmat: Fix lockdep warning for hmem_register_resource() (2025-11-12 14:47:55 -0700)

----------------------------------------------------------------
cxl and related fixes for v6.18-rc6

- Fix incorrect device handle check for Generic Initiator
- Fix offset calculation for extended linear cache poison injection
- Fix lockdep warning for hmem_register_resource()

----------------------------------------------------------------
Dave Jiang (2):
      cxl: Adjust offset calculation for poison injection
      acpi/hmat: Fix lockdep warning for hmem_register_resource()

Shuai Xue (1):
      acpi,srat: Fix incorrect device handle check for Generic Initiator

 drivers/acpi/numa/hmat.c  | 46 +++++++++++++++++++++++++---------------------
 drivers/acpi/numa/srat.c  |  2 +-
 drivers/cxl/core/region.c |  2 ++
 3 files changed, 28 insertions(+), 22 deletions(-)
