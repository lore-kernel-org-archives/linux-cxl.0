Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4362F397695;
	Thu, 10 Sep 2026 09:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789033153; cv=none; b=LQ/LuaoIMtMtWqt5cIoC2Pjz5NKs8uEsIDQL6DhdN7GkcDoV9gVILUwbtmedpfC7SAdJFlUjRYzlB/FwvfQl8FkgzqrGUalcn5ALbQ87lryarNrvleoCMqxjsq8Ouk1MpDJ8x8kJRnxYcvMEYJyD3v8nNnXSCAUGhPwaSwwCeKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789033153; c=relaxed/simple;
	bh=4IjxNCMSkE9NrLUOlPIVyyeUMQF88Cbi2YiXdSDkGi4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mghbnZT/XKPXN5Xqpa8CHeTQnzH85dKdIwh5w+I1Ip07G+K5JzHRzwhcsvrp+6EUTGKp5XoNK/8KWg/XeirzmZuw8uX0LkEhkQqGM/TsA0ctayDBMV7gFBHzO7QEj1tg0zZJjCDLvN5xloGV4zf8W3d9wvHjPKl5Vw1ZzbTd26E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hcdClrlg; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hcdClrlg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789033151; x=1820569151;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4IjxNCMSkE9NrLUOlPIVyyeUMQF88Cbi2YiXdSDkGi4=;
  b=hcdClrlgCE7/v9gRtA8kstWUvGBQonrMDg+w0s785rP0Bvg2cm7Oq3Go
   6pldV8zNOObuzoFY6T3KkaPaZIY/n9WWFGwlvV4Ee/kT25GqnP92o2IVl
   snWaFS8XaAXpyVd4nD3hQCbo7unQsETgyw0An289Db0IFJrI11BgrjAdO
   5fvvmZaLb48RSjdWt5IF6SI7MErEWbljfSpVltXjF4ysnQ1T74AW/bUY+
   D6Mj7TuAVBWDX4SJM9kBOlveFXAfY4u3e5lsefZoJEIpK17hXt3mOnEvO
   iuT5aQnnlJMfs5or+bN5uItQVHhabC8xf5BNjb88nfwTgoDgM1IBP7JvP
   w==;
X-CSE-ConnectionGUID: P3b5Vt9WRWyaFa3YzK2dKw==
X-CSE-MsgGUID: +4lUhvbCQIGFyWi5TYXphg==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="100832787"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="100832787"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 02:39:11 -0700
X-CSE-ConnectionGUID: vMX4C2njQPGDAJTGF9mrDw==
X-CSE-MsgGUID: v9HAY5zBSdKw9pCEDD/5aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="301478834"
Received: from junjie-desk-dev.bj.intel.com ([10.238.152.71])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2026 02:39:08 -0700
From: Junjie Cao <junjie.cao@intel.com>
To: Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	linux-cxl@vger.kernel.org
Cc: Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Richard Cheng <icheng@nvidia.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] cxl/regs: Reject register blocks in an unassigned BAR
Date: Thu, 10 Sep 2026 17:38:58 +0800
Message-ID: <20260910093858.535969-1-junjie.cao@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_decode_regblock() only checks that the Register Locator offset fits
pci_resource_len().  A BAR the PCI core could not place is reset to zero
start, end and flags while config space keeps the firmware value, so a
zero offset passes and the block is mapped at physical address 0.  On
x86 ioremap() of the reserved low megabyte succeeds, the component
register header does not match, and a switch port fails with "HDM
decoder capability not found", pointing at the HDM decoders rather than
at the BAR.

Reject a BAR with no length or still unassigned, next to the existing size
check.  Skip empty Register Locator entries first: they decode as BAR0
offset 0 and would trip the check, and nothing looks them up.

Seen with edk2-stable202602 (f6489621b8ae, reverted in stable202605),
which places 64-bit non-prefetchable BARs behind a bridge in the
prefetchable window.  Linux refuses to claim them and the switch
upstream and downstream port BAR0s find no room in the 32-bit window.
QEMU q35 with a CXL switch, Fedora 43 edk2-ovmf-20260213, before:

pci 0000:0d:00.0: BAR 0 [mem size 0x00010000 64bit]: can't assign; no space
cxl_port port2: HDM decoder capability not found

after:

pcieport 0000:0d:00.0: BAR0: not assigned (type: 1)
cxl_port port2: No component registers mapped
cxl_port port2: Failed to map HDM decoder capability

Link: https://github.com/tianocore/edk2/issues/13104
Signed-off-by: Junjie Cao <junjie.cao@intel.com>
---
 drivers/cxl/core/regs.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 20c2d9fbcfe7..41416fa2ce4a 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -277,6 +277,20 @@ static bool cxl_decode_regblock(struct pci_dev *pdev, u32 reg_lo, u32 reg_hi,
 	u64 offset = ((u64)reg_hi << 32) |
 		     (reg_lo & PCI_DVSEC_CXL_REG_LOCATOR_BLOCK_OFF_LOW);
 
+	if (reg_type == CXL_REGLOC_RBI_EMPTY)
+		return false;
+
+	/*
+	 * A BAR the PCI core could not place is reset to zero; decoding it
+	 * would map the block at physical address 0.
+	 */
+	if (!pci_resource_len(pdev, bar) ||
+	    (pci_resource_flags(pdev, bar) & IORESOURCE_UNSET)) {
+		dev_warn(&pdev->dev, "BAR%d: not assigned (type: %d)\n", bar,
+			 reg_type);
+		return false;
+	}
+
 	if (offset > pci_resource_len(pdev, bar)) {
 		dev_warn(&pdev->dev,
 			 "BAR%d: %pr: too small (offset: %pa, type: %d)\n", bar,
-- 
2.43.0

