Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2AAF8488
	for <linux-cxl@vger.kernel.org>; Tue, 11 Jun 2024 05:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.139.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718085006; cv=none; b=hhppo5sxv/KlogATLVU8I+brnbE3x0o64DfqfPYv4KX0ZiAWaHRcsK42mjsFA5sJtPdpYY2zVApZES07HquZ8W1AsOAL6cTUUeip83OxeVvKSjlhP9tTzVwMm1QtheKsJ2dAYEeZ8uiwNWGKZZOAXao9g6XTxXDjKEUxa6NPkKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718085006; c=relaxed/simple;
	bh=3JC4OmLq8jF5tC5Kse9n+Lox1W2ooTveO11tUg/y71E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=enAQIRwdlKWPs5fio0K2kyRSubFJKnxxHQfQPbLzR5WceCs242dedT0yQhySRSDuBn95H7QaH5RQ+PNsFitdVTlFXuMM1aiGlp/T/2yi8z9SbzB8Bl/LNRGE+xGUb+kky16yYAcx1jb4xSyonK59kyd4iY4R6jl08uOp469b0go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=aj/HWlcr; arc=none smtp.client-ip=68.232.139.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="aj/HWlcr"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1718085004; x=1749621004;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3JC4OmLq8jF5tC5Kse9n+Lox1W2ooTveO11tUg/y71E=;
  b=aj/HWlcr8/8B2b59t1Qf3pUzqY3tVOGeCq0b/5sFsm0vCCvPsj1yg33/
   6yHaIflwNTiJS5V0FWJ/NTLZJbB5augaqj4ksIEJSiSQMGOriv8ZSntfF
   JE9W4RbLIiosJPBYf3sfw1KnhTmwckfnlNS0+BQQYf014LBgEIfHwWu5u
   XD2Hs1y4s63Mb8QLtGAetEIhOzGRxeflMA/bXGpoKdksUOAhtaeRvi8fO
   EVc7KWKcPGF49+lBj72qEDo6MUJmaHBIQB+8UkeITMeifqIi42GvHxLKE
   5uXbp0MKqojGPVoP3llUkm6lLyufH8K2AkwWc+MNDZkOuBkOmrKjrWLJr
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11099"; a="161864822"
X-IronPort-AV: E=Sophos;i="6.08,229,1712588400"; 
   d="scan'208";a="161864822"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 14:50:00 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 70E40C68E1
	for <linux-cxl@vger.kernel.org>; Tue, 11 Jun 2024 14:49:58 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id A1201D506C
	for <linux-cxl@vger.kernel.org>; Tue, 11 Jun 2024 14:49:57 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3002.s.css.fujitsu.com (Postfix) with ESMTP id 76699203ED51;
	Tue, 11 Jun 2024 14:49:57 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: kobayashi.da-06@jp.fujitsu.com,
	linux-cxl@vger.kernel.org
Cc: y-goto@fujitsu.com,
	mj@ucw.cz,
	dan.j.williams@intel.com,
	jonathan.cameron@huawei.com,
	"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Subject: [PATCH v10 0/2] Export cxl1.1 device link status register value to pci device sysfs.
Date: Tue, 11 Jun 2024 14:52:52 +0900
Message-ID: <20240611055254.61203-1-kobayashi.da-06@fujitsu.com>
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
- Map the pcie cap in for all the time the driver is bound to the device
- Add mapping the pcie cap in cxl_rcd_component_reg_phys()

v9[9] -> v10:
- Change a utility function for getting PCIe capability
- Fix tab alignment issue, error handling, and apply suggestions from Jonathan

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


Kobayashi,Daisuke (2):
  cxl/core/regs: Add rcd_regs initialization at __rcrb_to_component()
  cxl/pci: Add sysfs attribute for CXL 1.1 device link status

 drivers/cxl/core/core.h |  5 +++
 drivers/cxl/core/regs.c | 27 +++++++++++-
 drivers/cxl/cxl.h       |  9 ++++
 drivers/cxl/pci.c       | 98 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 138 insertions(+), 1 deletion(-)

-- 
2.44.0

