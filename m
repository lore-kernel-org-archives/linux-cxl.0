Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BECA819
	for <linux-cxl@vger.kernel.org>; Mon, 17 Jun 2024 04:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.138.36.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718599053; cv=none; b=sDWlWriA5fXWbrXRZ1qXk0nR7MP7eOVbG9DE2Mny1r/AGWA4c8PNjIwLQZa/7UGdbikvFDquT4viXi470uky0HQ6ITtIePqh5bMxtjtq/KXnFwzt/ba67Wqqp8GYzYTEud+MeaQZKY/UV3QIHPKWYGs4xofBnF3qQS3ws1u5Z+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718599053; c=relaxed/simple;
	bh=UE5FFzIWZhQ83Dyv/W4Kup1RU9Qqr3+YPLj2K3Mlr9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P4/G8kGRnQK+qPJzKwSITW0G5x/5xSM7yluz0WBknMRGRRYMBHPwvc/yHyscfdrZ9weg7ZxB9TqoSy94RpiBayIvvgTyZ4Hu3S/BAWYbl2M9AvbXxmCUYKSWHknztvcFQ0reKdSKZ1+U7yhAJRra+YMw8KRg4G4XiLSxU6UjKxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=V+npieBg; arc=none smtp.client-ip=139.138.36.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="V+npieBg"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1718599050; x=1750135050;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UE5FFzIWZhQ83Dyv/W4Kup1RU9Qqr3+YPLj2K3Mlr9k=;
  b=V+npieBgdp3OlVcYvGOrvnEm7hGlbVuGsSft6+12vZ9vjBy7lHHWAvg+
   p0V/kMD5hggfxHYKJEpUre+ne7shBxueswK+F3KnehZnZZj7Y6z9TTdoa
   SsOgg35zqFtu73CAFu2nFylXT0wnOX2ikwEPG/gbi0uty1Yuv/jyHz0pM
   2paf4MqCacx9ESzM7XzkPm7w7Jv+9KPMnff2pNL6ptMV0+rj+srS3mqWN
   x1fVONCcbYN5rsrizLt3A2f/uFCv+IReQ+QtRJLt7tjr1TorzIkkjyhn1
   XSa7RqKJzqLkmN7slQBMLkwGzRZ2eZxuLMAmsyk79odEEDypg0RrQFQJR
   w==;
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="151045147"
X-IronPort-AV: E=Sophos;i="6.08,244,1712588400"; 
   d="scan'208";a="151045147"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 13:34:14 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
	by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id 60EB5CC142
	for <linux-cxl@vger.kernel.org>; Mon, 17 Jun 2024 13:34:12 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
	by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 9D272D52F1
	for <linux-cxl@vger.kernel.org>; Mon, 17 Jun 2024 13:34:11 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3002.s.css.fujitsu.com (Postfix) with ESMTP id 5DD092020F93;
	Mon, 17 Jun 2024 13:34:11 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: kobayashi.da-06@jp.fujitsu.com,
	linux-cxl@vger.kernel.org
Cc: y-goto@fujitsu.com,
	mj@ucw.cz,
	dan.j.williams@intel.com,
	jonathan.cameron@huawei.com,
	"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Subject: [PATCH v13 0/2] Export cxl1.1 device link status register value to pci device sysfs.
Date: Mon, 17 Jun 2024 13:37:00 +0900
Message-ID: <20240617043702.62028-1-kobayashi.da-06@fujitsu.com>
X-Mailer: git-send-email 2.44.0
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


Kobayashi,Daisuke (2):
  cxl/core/regs: Add rcd_pcie_cap initialization
  cxl/pci: Add sysfs attribute for CXL 1.1 device link status

 drivers/cxl/core/core.h |  6 +++
 drivers/cxl/core/regs.c | 61 ++++++++++++++++++++++++++++
 drivers/cxl/cxl.h       |  9 +++++
 drivers/cxl/pci.c       | 89 ++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 163 insertions(+), 2 deletions(-)

-- 
2.44.0

