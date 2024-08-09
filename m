Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDC8EEA8
	for <linux-cxl@vger.kernel.org>; Fri,  9 Aug 2024 08:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723193905; cv=none; b=kB2FGPPEODP45lgMhkqXDZ/Gu+TwxfRx1bsUFuEegdlM5lWAXQ1DYT7Ggsk2ZjAnDxnbH0O3SFlmIlwYR0VwyEpKEG5wlvkqRp1d5kAoGJ1mIZ+innlfG2sb2ps2be/isR4z9AxeK6d+nQH6FlZMM6QZrfo5Ys291ZWGEioIaPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723193905; c=relaxed/simple;
	bh=Kl8O3TGyRG/kc8kUBcrQe3mdFvcO8gdXMCmnPVMnNWE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HxA5j1/GIVpOSDx8LLYKxNOxXLya9jT3lf/aqVg3+AC24ZUeT+Oi8AwMxUmGr6FisyesrbsoS9Lt106eiShV+Dc5SrwBg3aiOQ5fk3sOq5z20vf71wUGGbR37l2p6MvEH3GWFLbyBKMzJ0LPEUq/Me6OKtXh2EVztOUZbF4QOG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BBNIt5q2; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BBNIt5q2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723193904; x=1754729904;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Kl8O3TGyRG/kc8kUBcrQe3mdFvcO8gdXMCmnPVMnNWE=;
  b=BBNIt5q2e3m6DFepKGri9pYSr1VsdxZueilAV6M57H448GiG0lKU+Rdi
   4FFL/ixek/q7mR8VNcCWWvwv0nYO+R4t3LlC3Q38CZMCpT1EGynLcxUfT
   qnQcEQPfW7XeNCVp9vLprwVgb6frpISU+66rkFii11qBjZ7+0n7W4Vf6Y
   yv9jFYoXHHODWZy72BMWQ5UnEmL7AjQzuSpURJ/zShlW/XJI7FM/VT1dM
   87ljMzvjrRCBDGtOR+z+uEM7bbjmHt48t+yEI9Jk//E7TjDsJMjL5XlD7
   cyWhM2bpULsQJW4rlbBsw3ROCBoMmJdIGuHIAAVPx6ejk6wJHM7zrPVH0
   w==;
X-CSE-ConnectionGUID: sZaha5DVRVOqwmRr/AsKvA==
X-CSE-MsgGUID: 5w9CIrYxTZuF2Y/A6KggIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="32507226"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="32507226"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 01:58:17 -0700
X-CSE-ConnectionGUID: Z47k8+d1Ro6afR7RBq3KJw==
X-CSE-MsgGUID: etcU/sH3TE6VzyxCRBRIPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="57164168"
Received: from s2600wttr.bj.intel.com ([10.240.192.138])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 01:58:14 -0700
From: Li Ming <ming4.li@intel.com>
To: linux-cxl@vger.kernel.org,
	rrichter@amd.com,
	terry.bowman@amd.com,
	dan.j.williams@intel.com,
	alison.schofield@intel.com,
	pengfei.xu@intel.com
Cc: Li Ming <ming4.li@intel.com>
Subject: [PATCH v2 0/2] Fix get a wrong pci host bridge in cxl_setup_parent_dport()
Date: Fri,  9 Aug 2024 08:27:48 +0000
Message-Id: <20240809082750.3015641-1-ming4.li@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The cxl_test unit test environment on qemu always hit below call trace
with KASAN enabled:

 BUG: KASAN: slab-out-of-bounds in cxl_setup_parent_dport+0x480/0x530 [cxl_core]
 Read of size 1 at addr ff110000676014f8 by task (udev-worker)/676[   24.424403] CPU: 2 PID: 676 Comm: (udev-worker) Tainted: G           O     N 6.10.0-qemucxl #1
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20240214-2.el9 02/14/2024
 Call Trace:
  <TASK>
  dump_stack_lvl+0xea/0x150
  print_report+0xce/0x610
  ? kasan_complete_mode_report_info+0x40/0x200
  kasan_report+0xcc/0x110
  __asan_report_load1_noabort+0x18/0x20
  cxl_setup_parent_dport+0x480/0x530 [cxl_core]
  cxl_mem_probe+0x49b/0xaa0 [cxl_mem]

The root cause is that a wrong host bridge was gotten from
dport->dport_dev in cxl_setup_parent_dport(). In
cxl_setup_parent_dport(), it always calls
to_pci_host_bridge(dport->dport_dev) to get a pci_host_bridge structure.
There are two issues in the implementation:

* to_pci_host_bridge(dport->dport_dev) should be used only for RCH
  cases, dport->dport_dev points to a pci device rather than a pci host
  bridge in VH cases. The solution is checking if dport is in RCH mode
  then calling to_pci_host_bridge().
  (Patch 1)

* In cxl_test unit test environment, cxl_test will create a emulated CXL
  topology with emulated dports, the dport_dev of a emulated dport
  points to a platform device. to_pci_host_bridge(dport->dport_dev) also
  gets a wrong pci host bridge in the case. The solution is implementing
  a new wrap function called __wrap_cxl_setup_parent_dport() on cxl_test
  side, the function will filter all emulated dports, make sure only
  real dports can be handled by cxl_setup_parent_dport().
  (Patch 2)

v1 link: https://lore.kernel.org/linux-cxl/ZrHR+0w3bwM1Ik8h@xpf.sh.intel.com/T/#med6200e54ec12f09fdcc04571516adda261c9561

v2:
- Add call trace log into changelog
- Remove 'dev_is_platform(dport->dport_dev)' checking out of cxl driver
  scope. Check if dport is emulated in cxl_test.
  

Li Ming (2):
  cxl/pci: Get AER capability address from RCRB only for RCH dport
  cxl/test: Skip cxl_setup_parent_dport() for emulated dports

 drivers/cxl/core/pci.c        | 10 ++++++----
 tools/testing/cxl/Kbuild      |  1 +
 tools/testing/cxl/test/mock.c | 12 ++++++++++++
 3 files changed, 19 insertions(+), 4 deletions(-)

-- 
2.40.1

