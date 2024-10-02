Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8341FBA
	for <linux-cxl@vger.kernel.org>; Wed,  2 Oct 2024 01:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727831680; cv=none; b=BiIZCaA+Ri6R0pp5RvlTYJiBo5k0Hbz4yfctdTTF8S4Eb8hfHbtSDAPyVs2Gm3cWn4+or800HAC2IYM9OH8xJ+Grr7eiPwrr6NCzDnQFmNvxTWVvhNCyVvdO+lAwtBIM3VTKrgDxbYbB9X1bhg1FQ14GurQT03HIkCvn4dHjfDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727831680; c=relaxed/simple;
	bh=pgbt6+x1lCBSXowBRtuuzImQzvjd6+y9FdJ/XLXvxUA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HUrUKGNtfJbLpse4xDSEmEBwsCPullAPRSQYAKegh8fdccEWVEW9JnvT67z5QYlCfJ/8QwlFgaQ1RaWplEoLp/EFxSxMzbPew/l3+w1+gTymGvdF11xgOuqC4XZ/CExk7y6nO15ukyQjtESEgJvI7iomsFibv43FmzbA+FhiAu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=hOKgaLvk; arc=none smtp.client-ip=68.232.139.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="hOKgaLvk"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1727831678; x=1759367678;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pgbt6+x1lCBSXowBRtuuzImQzvjd6+y9FdJ/XLXvxUA=;
  b=hOKgaLvkiPM/YJX6QN/lYUwIVLF+RB+fnC0oH/v14JuI5vTBLR0+zX6H
   QgjftJ3jydCVzCfsAysX7iY27lVq2lnPJb270mCABjkMoUorB5EF37+9L
   n0qUWd/L5HnVVwnj93G5MYKch7XCqKfQeb4Swbv/eqn8vFvH0Tq1uzhY6
   HNLvafLoL2s0x9TIR/cWWVufAfgH7nx0Spmy/s5I7Xu25rA5/9912VLsz
   GtaxWJWEwhAc7skeMlWty/gHnyxqbewW4cGeiTWzceF4dna+xUapa4Ew0
   mv6vwqli4xVyINP/TDLBg7S+NuPl4fHfu9gu3k7Wf0nuspDsWeItZl9qh
   g==;
X-CSE-ConnectionGUID: sqXVHmaoSC6lpUn5IG6isg==
X-CSE-MsgGUID: PnOBbpdPTeOlv46WOeH5Zw==
X-IronPort-AV: E=McAfee;i="6700,10204,11212"; a="174647880"
X-IronPort-AV: E=Sophos;i="6.11,170,1725289200"; 
   d="scan'208";a="174647880"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2024 10:13:26 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 8C1CBC68E5
	for <linux-cxl@vger.kernel.org>; Wed,  2 Oct 2024 10:13:23 +0900 (JST)
Received: from m3004.s.css.fujitsu.com (m3004.s.css.fujitsu.com [10.128.233.124])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id C3D95D5076
	for <linux-cxl@vger.kernel.org>; Wed,  2 Oct 2024 10:13:22 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3004.s.css.fujitsu.com (Postfix) with ESMTP id A11E62005338;
	Wed,  2 Oct 2024 10:13:22 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: linux-cxl@vger.kernel.org,
	dan.j.williams@intel.com
Cc: mj@ucw.cz,
	"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Subject: [PATCH v18 0/2] Export cxl1.1 device link status register value to pci device sysfs.
Date: Wed,  2 Oct 2024 10:15:47 +0900
Message-ID: <20241002011549.408412-1-kobayashi.da-06@fujitsu.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00

CXL devices are extensions of PCIe. Therefore, from CXL2.0 onwards,
the link status can be output in the same way as traditional PCIe.
However, unlike devices from CXL2.0 onwards, CXL1.1 requires a
different method to obtain the link status from traditional PCIe.
This is because the link status of the CXL1.1 device is not mapped
in the configuration space (as per cxl3.0 specification 8.1).
Instead, the configuration space containing the link status is mapped
to the memory mapped register region (as per cxl3.0 specification 8.2,
Table 8-18). Therefore, the current lspci has a problem where it does
not display the link status of the CXL1.1 device. 
Solve these issues with sysfs attributes to export the status
registers hidden in the RCRB.

The procedure is as follows:
First, obtain the RCRB address within the cxl driver, then access 
the configuration space. Next, output the link status information from
the configuration space to sysfs. Ultimately, the expectation is that
this sysfs file will be consumed by PCI user tools to utilize link status
information.

Changes
v1[1] -> v2:
- Modified to perform rcrb access within the CXL driver.
- Added new attributes to the sysfs of the PCI device.
- Output the link status information to the sysfs of the PCI device.
- Retrieve information from sysfs as the source when displaying information in lspci.

v2[2] -> v3:
- Fix unnecessary initialization and wrong types (Bjohn).
- Create a helper function for getting a PCIe capability offset (Bjohn).
- Move platform-specific implementation to the lib directory in pciutils (Martin).

v3[3] -> v4:
- RCRB register values are read once and cached.
- Added a new attribute to the sysfs of the PCI device.
- Separate lspci implementation from this patch.

v4[4] -> v5:
- Use macros for bitwise operations
- Fix RCRB access to use cxl_memdev

v5[5] -> v6:
- Add and use masks for RCRB register values

v6[6] -> v7:
- Fix comments on white space inline

v7[7] -> v8:
- Change the cache value to offset
- Access memory map area in rcd_*_show() functions

v8[8] -> v9:
- Map the pcie cap in for all the time the driver is bound to the device.
- Add mapping the pcie cap in cxl_rcd_component_reg_phys().

v9[9] -> v10:
- Change a utility function for getting PCIe capability.
- Fix tab alignment issue, error handling, and apply suggestions from Jonathan.

v10[10] -> v11:
- Add functions to have one function do only one thing.
- Add a size parameter to utility function arguments and consolidated them into one.

v11[11] -> v12:
- Fix the error handling in cxl_pci_setup_regs().
- Fix and clean up some details.

v12[12] -> v13:
- Fix and clean up some details.

v13[13] -> v14:
- Fix and clean up some details.

v14[14] -> v15:
- Change dport lookup to be done only once.
- Fix the visibility of cxl_rcrb_to_linkcap().

v15[15] -> v16:
- Fix the port leak bug by introduce a new scope-based-free handler
- Improve the variable names.

v16[16] -> v17:
- Change used function for making struct cxl_port *port

v17[17] -> v18
- Rebase to the latest code.

[1]
https://lore.kernel.org/linux-cxl/20231220050738.178481-1-kobayashi.da-06@fujitsu.com/
[2]
https://lore.kernel.org/linux-cxl/20240227083313.87699-1-kobayashi.da-06@fujitsu.com/
[3]
https://lore.kernel.org/linux-cxl/20240312080559.14904-1-kobayashi.da-06@fujitsu.com/
[4]
https://lore.kernel.org/linux-cxl/20240409073528.13214-1-kobayashi.da-06@fujitsu.com/
[5]
https://lore.kernel.org/linux-cxl/20240412070715.16160-1-kobayashi.da-06@fujitsu.com/
[6]
https://lore.kernel.org/linux-cxl/20240424050102.26788-1-kobayashi.da-06@fujitsu.com/
[7]
https://lore.kernel.org/linux-cxl/20240510073710.98953-1-kobayashi.da-06@fujitsu.com/
[8]
https://lore.kernel.org/linux-cxl/20240606074814.5633-1-kobayashi.da-06@fujitsu.com/
[9]
https://lore.kernel.org/linux-cxl/20240610082222.22772-1-kobayashi.da-06@fujitsu.com/
[10]
https://lore.kernel.org/linux-cxl/20240611055254.61203-1-kobayashi.da-06@fujitsu.com/
[11]
https://lore.kernel.org/linux-cxl/20240612075940.92500-1-kobayashi.da-06@fujitsu.com/
[12]
https://lore.kernel.org/linux-cxl/20240614045611.58658-1-kobayashi.da-06@fujitsu.com/
[13]
https://lore.kernel.org/linux-cxl/20240617043702.62028-1-kobayashi.da-06@fujitsu.com/
[14]
https://lore.kernel.org/linux-cxl/20240618042941.96893-1-kobayashi.da-06@fujitsu.com/
[15]
https://lore.kernel.org/linux-cxl/20240716042540.89639-1-kobayashi.da-06@fujitsu.com/
[16]
https://lore.kernel.org/linux-cxl/20240815005510.220835-1-kobayashi.da-06@fujitsu.com/
[17]
https://lore.kernel.org/linux-cxl/20240903025915.270521-1-kobayashi.da-06@fujitsu.com/


Kobayashi,Daisuke (2):
  cxl/core/regs: Add rcd_pcie_cap initialization
  cxl/pci: Add sysfs attribute for CXL 1.1 device link status

 drivers/cxl/core/core.h |   5 ++
 drivers/cxl/core/regs.c |  56 ++++++++++++++++++++++
 drivers/cxl/cxl.h       |   9 ++++
 drivers/cxl/pci.c       | 103 +++++++++++++++++++++++++++++++++++++---
 4 files changed, 167 insertions(+), 6 deletions(-)

-- 
2.45.0

