Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B8FA23EAB4
	for <linux-cxl@vger.kernel.org>; Tue, 24 Mar 2026 17:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774372288; cv=none; b=u/C5J4YPvz9oV2ENHZ/0wUYTA0m4u0XVOjBY5PTXARQ3MvDu/jySF46GhAifAxHLKgdQWMpzLRqp10FYv3TRGqIq8XNZ7nt/WvLVSd0q1Eo0hYFUsQty4OXiNmLo9rRtH1fTqEy9Zs5yMFQBSCw6JocvtfWwF9RTjJL+pTgaWKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774372288; c=relaxed/simple;
	bh=SyUSoP4E06PFNG5b+76ZABkrdVJyXC/ba3QtbQG1BQs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=Q6/2tXjwHP68WbqsCVwbBl7Z9a+a7vT2IbML2wvdHLflK2gCqcyTCKCWEE1QlwGE26BRXOgwF7/2ay0G2QjZZ7k1a1pBOkJAOA7ZZH3jhcQS+IK77RT26EAt2yEWw9QvMf/NDprpWdz6C5v75ETWVbqsFkNCIJpU1rlV3Hmwejc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h5IkIs12; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h5IkIs12"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774372287; x=1805908287;
  h=message-id:date:mime-version:to:cc:from:subject:
   content-transfer-encoding;
  bh=SyUSoP4E06PFNG5b+76ZABkrdVJyXC/ba3QtbQG1BQs=;
  b=h5IkIs12rGDtgX08uWbl41adwLmgz44utlm3gc2xUKyvWvVRqd6APZkM
   /jPY4VQtdKmRdUoPZ3NE4Jyj6xVQUdCcMVTV40A3kmyn7WGN5RdewAdCw
   /MvKjVenl1/ERnh+jy+3AsJE11LgQ8RsTqkKDXp5t9aLojgsWc1OCuze8
   LDexDKuKXMzsz5cK2SAQfopvbzDfWrdqDI1z6268eCa7H4+HViEyy6AjB
   15TcfFEGNhdGL+xZ3iO0ebk1OTJzJrZsPM3P7XpzC51BBA2uxfiUMSvWA
   Tm9A26A4cy+YC2PLFPLD/xs/8NT/iR8JNfE0ISNYepQUgm1KPhf4yTtHp
   A==;
X-CSE-ConnectionGUID: 2Q4KiiTOSYWF5IladLoCcA==
X-CSE-MsgGUID: ySgeCWypRO2GnSjZvEXuUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="75423851"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="75423851"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 10:11:26 -0700
X-CSE-ConnectionGUID: m5O0pQ4uTu+62bhU2sqPEQ==
X-CSE-MsgGUID: nRza3yHJQ/OPq72e/GNaDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="223621398"
Received: from jdoman-mobl3.amr.corp.intel.com (HELO [10.125.110.6]) ([10.125.110.6])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 10:11:25 -0700
Message-ID: <1b13cc4d-4103-4462-a0c1-590ad2d6725c@intel.com>
Date: Tue, 24 Mar 2026 10:11:24 -0700
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
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Alison Schofield <alison.schofield@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Keith Busch <kbusch@kernel.org>
From: Dave Jiang <dave.jiang@intel.com>
Subject: [GIT PULL] Compute Express Link (CXL) Fixes for 7.0-rc6
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Linus, please pull from:

git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-7.0-rc6

...to receive a small collection of CXL fixes. These all have appeared in -next
for a few days with no reported issues.

---

The following changes since commit 11439c4635edd669ae435eec308f4ab8a0804808:

  Linux 7.0-rc2 (2026-03-01 15:39:31 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git tags/cxl-fixes-7.0-rc6

for you to fetch changes up to be5c5280cf2b20e363dc8e2a424dd200a29b1c77:

  cxl: Adjust the startup priority of cxl_pmem to be higher than that of cxl_acpi (2026-03-19 15:12:40 -0700)

----------------------------------------------------------------
cxl fixes for v7.0-rc6

cxl: Adjust the startup priority of cxl_pmem to be higher than that of cxl_acpi
cxl/mbox: Use proper endpoint validity check upon sanitize
cxl/hdm: Avoid incorrect DVSEC fallback when HDM decoders are enabled
cxl/acpi: Fix CXL_ACPI and CXL_PMEM Kconfig tristate mismatch
cxl/region: Fix leakage in __construct_region()
cxl/port: Fix use after free of parent_port in cxl_detach_ep()

----------------------------------------------------------------
Alison Schofield (1):
      cxl/port: Fix use after free of parent_port in cxl_detach_ep()

Cui Chao (1):
      cxl: Adjust the startup priority of cxl_pmem to be higher than that of cxl_acpi

Davidlohr Bueso (2):
      cxl/region: Fix leakage in __construct_region()
      cxl/mbox: Use proper endpoint validity check upon sanitize

Keith Busch (1):
      cxl/acpi: Fix CXL_ACPI and CXL_PMEM Kconfig tristate mismatch

Smita Koralahalli (1):
      cxl/hdm: Avoid incorrect DVSEC fallback when HDM decoders are enabled

 drivers/cxl/Kconfig       |  1 +
 drivers/cxl/core/hdm.c    | 25 +++++++++----------------
 drivers/cxl/core/mbox.c   |  2 +-
 drivers/cxl/core/port.c   |  8 ++++++--
 drivers/cxl/core/region.c |  4 +++-
 drivers/cxl/pmem.c        |  2 +-
 6 files changed, 21 insertions(+), 21 deletions(-)
