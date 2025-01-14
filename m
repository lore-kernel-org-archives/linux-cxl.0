Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D2C2361DF
	for <linux-cxl@vger.kernel.org>; Tue, 14 Jan 2025 13:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736860238; cv=none; b=rIan5PAUjEfiQv1VtAXpoRw8wNoAWaDFCV+wDHKJL1gwSytJVpxJonV0EEgUbNObjo0/RulN+mHVrypghYvxRkTvPu3AHHsaoxw/L6iKaRmSVSZWtyEkILHXXpSNZOCJWCnnUBOIFsmssBT8t9+INQAdETF4kxbNtn3+h7iuHsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736860238; c=relaxed/simple;
	bh=xp2SRJ4gfQp35EBijtyGs3oVKQBqlw15VaESiTbMrj4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=JdIkUzY35fVQBjgT3jhPhRWJH+EKMSVT49wYuIrpVyd+dLguNwlV2Fk/jbjos/g9U+1VHlhtqkvsQ1SaRqOpAesigc7g45dtXwlDGVFG7uNPgI37v0StbAJ8Q5/t3nL1r0N1+dmb1xRnoDhF/dhdoNK3DYBAMp8pRe8Bn+UYZiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DD4HBYJv; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DD4HBYJv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736860237; x=1768396237;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xp2SRJ4gfQp35EBijtyGs3oVKQBqlw15VaESiTbMrj4=;
  b=DD4HBYJvpal87s1oyfKdhd7FgOTS3KFOkAq9TSUv7pXlB109+yS3StEk
   J1f4kiYP+rOmsAf2T19KZ4fVc7gIKFZXOHzmUuUBhxNi8CSk+M22g+VBv
   CZp0W80av1G3OH73wlayGFPJG+WnmsDP37DrMg1g7Dg6wpuE+72zmyebp
   lyT68p5os2ObQiMvUScBJnuOixn0woPzX0rnBRzodz4ebkKyFIRBlTyrM
   SvEYIsPguLaZMfITDCF2/6FMnM1AAb7LtdImj12Dyuf1VjxC71isYN5zL
   Ui8rhxTdziS0ApKe4VGeaLG90sOPw51w6BlPfOgpyz3kWKBbdfz0FY9+R
   w==;
X-CSE-ConnectionGUID: G83kowY2T/65+FPmAZYzZg==
X-CSE-MsgGUID: Mi+/kGRaROu9Cd0YGW5I+A==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="54695923"
X-IronPort-AV: E=Sophos;i="6.12,314,1728975600"; 
   d="scan'208";a="54695923"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 05:10:36 -0800
X-CSE-ConnectionGUID: iAj2xT3yS4WWZnF6ao2/ag==
X-CSE-MsgGUID: WzdghFstRU6ppnlrnJbvng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="128050834"
Received: from unknown (HELO ixc04.bj.intel.com) ([10.238.153.130])
  by fmviesa002.fm.intel.com with ESMTP; 14 Jan 2025 05:10:34 -0800
From: Huaisheng Ye <huaisheng.ye@intel.com>
To: Jonathan.Cameron@huawei.com,
	dan.j.williams@intel.com,
	dave.jiang@intel.com,
	ming.li@zohomail.com
Cc: pei.p.jia@intel.com,
	linux-cxl@vger.kernel.org,
	Huaisheng Ye <huaisheng.ye@intel.com>
Subject: [PATCH v4 0/1] cxl/core/regs: Refactor out functions to count regblocks of given type
Date: Tue, 14 Jan 2025 21:10:40 +0800
Message-Id: <20250114131041.17512-1-huaisheng.ye@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In commit d717d7f3df18494baafd9595fb4bcb9c380d7389, cxl_count_regblock was
added for counting regblocks of a given RBI (Register Block Identifier).
It is workable, but the implementation can be improved.

1. In order to get the count of instances, cxl_count_regblock has to tentatively
repeat the call of cxl_find_regblock_instance by increasing index from 0. It
will not stop until an error value is returned. Actually, It needs to search for
Register Blocks in dvsec again every time by taking a start from the head. The
operations can be optimized.

2. cxl_count_regblock blocks the opportunity to get error codes from
cxl_find_regblock_instance. cxl_pci_probe has error code checking for almost
all function calls. This is a good behavior, but existing cxl_count_regblock
couldn't return error codes.

With this patch, only need to have minor modifications in
__cxl_find_regblock_instance, which can return the count of regblocks by given
RBI in just one call. It is more effective than before. Besides, the error code
could be obtained by the called function, here is cxl_pci_probe.

---

This patch is tested by ndctl cxl_test and physical CXL expander card
with v6.13-rc6.

1. Ndctl CXL test suite v80 could pass with this patch applied.
$ meson test -C build --suite cxl
ninja: Entering directory `/home/work/source/ndctl/build'
[1/48] Generating version.h with a custom command
 1/11 ndctl:cxl / cxl-topology.sh               OK               3.48s
 2/11 ndctl:cxl / cxl-region-sysfs.sh           OK               2.74s
 3/11 ndctl:cxl / cxl-labels.sh                 OK               1.75s
 4/11 ndctl:cxl / cxl-create-region.sh          OK               3.51s
 5/11 ndctl:cxl / cxl-xor-region.sh             OK               1.89s
 6/11 ndctl:cxl / cxl-events.sh                 OK               1.63s
 7/11 ndctl:cxl / cxl-sanitize.sh               OK               4.48s
 8/11 ndctl:cxl / cxl-destroy-region.sh         OK               1.90s
 9/11 ndctl:cxl / cxl-qos-class.sh              OK               2.65s
10/11 ndctl:cxl / cxl-poison.sh                 OK               2.86s
11/11 ndctl:cxl / cxl-security.sh               OK               0.91s

2. Test patch with Qemu x4 switch topology:

                       ACPI0017:00 [root0]
                           |
                         HB_0 [port1]
                        /             \
                     RP_0             RP_1
                      |                 |
                USP [port2]
            /    /    \    \
          DSP   DSP   DSP   DSP
           |     |     |     |
          mem1  mem0  mem2  mem3

Every card has 2 PMU RBs, here are the pmu_mem devices.

$ pwd
/sys/bus/cxl/devices
$ tree
[snip]
├── pmu_mem0.0 -> ../../../devices/pci0000:0c/0000:0c:00.0/0000:0d:00.0/0000:0e:01.0/0000:10:00.0/pmu_mem0.0
├── pmu_mem0.1 -> ../../../devices/pci0000:0c/0000:0c:00.0/0000:0d:00.0/0000:0e:01.0/0000:10:00.0/pmu_mem0.1
├── pmu_mem1.0 -> ../../../devices/pci0000:0c/0000:0c:00.0/0000:0d:00.0/0000:0e:00.0/0000:0f:00.0/pmu_mem1.0
├── pmu_mem1.1 -> ../../../devices/pci0000:0c/0000:0c:00.0/0000:0d:00.0/0000:0e:00.0/0000:0f:00.0/pmu_mem1.1
├── pmu_mem2.0 -> ../../../devices/pci0000:0c/0000:0c:00.0/0000:0d:00.0/0000:0e:02.0/0000:11:00.0/pmu_mem2.0
├── pmu_mem2.1 -> ../../../devices/pci0000:0c/0000:0c:00.0/0000:0d:00.0/0000:0e:02.0/0000:11:00.0/pmu_mem2.1
├── pmu_mem3.0 -> ../../../devices/pci0000:0c/0000:0c:00.0/0000:0d:00.0/0000:0e:03.0/0000:12:00.0/pmu_mem3.0
├── pmu_mem3.1 -> ../../../devices/pci0000:0c/0000:0c:00.0/0000:0d:00.0/0000:0e:03.0/0000:12:00.0/pmu_mem3.1

---

Changes
=======
v3 -> v4:
1. Simplify code comments of __cxl_find_regblock_instance() (Jonathan)
2. Move testing setup to cover letter (Jonathan)
3. Get Reviewed-by from Jonathan

 [v3] https://lore.kernel.org/all/20250113064345.6835-1-huaisheng.ye@intel.com/
=======
v2 -> v3:
1. Create static function __cxl_find_regblock_instance() for implementation of
   locating a register block or counting instances by type / index
   underneath. (Jonathan)
2. cxl_count_regblock() and cxl_find_regblock_instance() respectively call
   __cxl_find_regblock_instance for the purpose of counting instances and
   locating RB. (Jonathan)
3. Change parameter index's type to 'unsigned int' in cxl_find_regblock_instance (Jonathan)
4. Rebase patch to v6.13-rc6

=======
v1 -> v2:
1. Reserved cxl_count_regblock() for original function interface (Ming)
2. Reset 'map->resource' to 'CXL_RESOURCE_NONE' before returning the count of instances in
   cxl_find_regblock_instance() (Ming)
3. Append results of ndctl test suite and Qemu testing PMU devices to commit log (Ming)
4. Rebase patch to v6.13-rc5

Huaisheng Ye (1):
  cxl/core/regs: Refactor out functions to count regblocks of given type

 drivers/cxl/core/regs.c | 52 +++++++++++++++++++++++++----------------
 drivers/cxl/cxl.h       |  3 ++-
 drivers/cxl/pci.c       |  6 ++++-
 3 files changed, 39 insertions(+), 22 deletions(-)

-- 
2.39.3

