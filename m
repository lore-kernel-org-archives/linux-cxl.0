Received: from esa11.hc1455-7.c3s2.iphmx.com (esa11.hc1455-7.c3s2.iphmx.com [207.54.90.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F95C6F30D
	for <linux-cxl@vger.kernel.org>; Mon, 10 Jun 2024 08:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718007588; cv=none; b=XAcbWJKfvFwv2uXDUqUnLXAdWhVeJOkyNTBpdHiQaMg+BIj5ySwApqluwxSJ+0orHMDDRSRUr1yc2IrmZ/nlvjp9mIv+YNKsJjkaWuABBL+moSIjdO/4uveqDK/Gm1KwsPo1Y8+nS+XcRdh/KA+HJrOGknhOHJPLp4IKtRsXRug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718007588; c=relaxed/simple;
	bh=mjUNiY8LdEMYn+AERu6nPtBCgeIQYWbL1z6uM5C571A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WnzHLFkNycmo3kvxy0RWntPzkkc3IzlL543dFOKGrhXPwEV3soZJv//QWcFjUXvBrhry59H4cCETMFmX7NQRQLRBF4z/fFy0lIpPEfgcm889ldqc0D0y0bvkhBG45axIngoOQWqi0iD181iw2ln4eLuBSuWeeBNfTeA6R8DcUT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=nxPVZlyy; arc=none smtp.client-ip=207.54.90.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="nxPVZlyy"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1718007586; x=1749543586;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mjUNiY8LdEMYn+AERu6nPtBCgeIQYWbL1z6uM5C571A=;
  b=nxPVZlyyYu1vH1/bxIxyxJWG29+Qw+f2hOgdkfc86vTRQ50hHjmfMdyP
   VIjhRvnmo+Mwb9WFvTEH5BWMAy1GP+BYohUykKtGEgAVvDTj8U8C4mmzz
   jmhOL7KgXfcPGueg2GC0JErOcarXk5m3uWnVQItEYjBB8ssHhWjux/TqZ
   ftJzrOg43f32Fhl+ZD+cLz8ELbimEyhC+BkVZ4A9C/I6yhLtOW4xSYC0w
   ++FKgKGHzsIQ6i5bZIp5XMYOaqD3eq4z9Hnfua20BhhCAn4e1LFSpbST6
   koF0P0mlgJC8/F7mDtYzOYXHhTAtZobc3oRbQmgWAOs1ETq0u0O/DlkRl
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11098"; a="141985647"
X-IronPort-AV: E=Sophos;i="6.08,227,1712588400"; 
   d="scan'208";a="141985647"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa11.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 17:19:37 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 62F79D424E
	for <linux-cxl@vger.kernel.org>; Mon, 10 Jun 2024 17:19:35 +0900 (JST)
Received: from m3004.s.css.fujitsu.com (m3004.s.css.fujitsu.com [10.128.233.124])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id A3628D4C19
	for <linux-cxl@vger.kernel.org>; Mon, 10 Jun 2024 17:19:34 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3004.s.css.fujitsu.com (Postfix) with ESMTP id 64DAC200532D;
	Mon, 10 Jun 2024 17:19:34 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: kobayashi.da-06@jp.fujitsu.com,
	linux-cxl@vger.kernel.org
Cc: y-goto@fujitsu.com,
	mj@ucw.cz,
	dan.j.williams@intel.com,
	jonathan.cameron@huawei.com,
	"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Subject: [PATCH v9 0/2] cxl: Export cxl1.1 device link status to sysfs
Date: Mon, 10 Jun 2024 17:22:20 +0900
Message-ID: <20240610082222.22772-1-kobayashi.da-06@fujitsu.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00

Export cxl1.1 device link status register value to pci device sysfs.

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
- Map the pcie cap in for all the time the driver is bound to the device
- Add mapping the pcie cap in cxl_rcd_component_reg_phys()

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

Kobayashi,Daisuke (2):
  cxl/core/regs: Add rcd_regs initialization at __rcrb_to_component()
  cxl/pci: Add sysfs attribute for CXL 1.1 device link status

 drivers/cxl/core/core.h |  4 +++
 drivers/cxl/core/regs.c | 26 ++++++++++++++-
 drivers/cxl/cxl.h       |  9 +++++
 drivers/cxl/pci.c       | 73 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 111 insertions(+), 1 deletion(-)

-- 
2.44.0

