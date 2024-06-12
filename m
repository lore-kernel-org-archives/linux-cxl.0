Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com [207.54.90.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6D116C69B
	for <linux-cxl@vger.kernel.org>; Wed, 12 Jun 2024 07:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718179025; cv=none; b=fVWyL3y/H5y8PDsgyVKZ6+kvv5KARgwYyucg12XGgAahf+qPZrL4TDfxwKW/JlegLabisJ7eCkMxl+O/mR1srUtbKkDMvLmJL6bjliFYxfhKNC3yGP1WF8QTvYL4f7qm/OMp2s/zeYizAbDt6jCC71zNTFOHC2wlUS+mNcvEbNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718179025; c=relaxed/simple;
	bh=fm2a30S4BmivE/lknkmESE3oVS6av5gEEqxM1k5FVGo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L/cQhVdgjkElNKFBggGtuoDhE+jEiXlIGJDW4pgDTIqfqIh7n/m4fWxETnuZSwNUlk4OOpQdD9exvvYd7DhbIFdkxSR6BpzTSYKuDizLoVaHbNYfrZgn0aHlC+w9JjjdCP0dRJV81uU8zq1UmqNfECyKF4e2KjTEJ3GsrChCUEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=dBzvtpra; arc=none smtp.client-ip=207.54.90.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="dBzvtpra"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1718179023; x=1749715023;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fm2a30S4BmivE/lknkmESE3oVS6av5gEEqxM1k5FVGo=;
  b=dBzvtpra7nNkP+Yt/m7G6bYWt5l9v9M3Pd0dLj74RDYWnYhj4U2i9nJo
   cQFMQx8qn9FH6zvI8GZUxjFjmBou1NWOhOhOz4UUfI2h0Pyw5RSEeRNtf
   pGPbgz1vXysknvWJovXFsCNJ/eJd9jGAudaQXPn9ymbjyGJt5FNFYZLo+
   RWcl5B2xaXR7BfrmLnm5UcMeimSTc3oxUoZxEMmBnaNDG8phNriaxskzb
   tO3h7kE6U4+bs8vq6gZ5+yKBjvOV/COcxcm1FQJfvMidGDA/3pvqb6uiU
   ybuFbPJzqp3E739eaMl8ePoBrnrwMY8V1+EbWYZbGub6iBsutFc0SJM9T
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="162805501"
X-IronPort-AV: E=Sophos;i="6.08,232,1712588400"; 
   d="scan'208";a="162805501"
Received: from unknown (HELO oym-r3.gw.nic.fujitsu.com) ([210.162.30.91])
  by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 16:56:54 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
	by oym-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 09D14D64B4
	for <linux-cxl@vger.kernel.org>; Wed, 12 Jun 2024 16:56:51 +0900 (JST)
Received: from m3003.s.css.fujitsu.com (sqmail-3003.b.css.fujitsu.com [10.128.233.114])
	by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 53EFCBDCA5
	for <linux-cxl@vger.kernel.org>; Wed, 12 Jun 2024 16:56:50 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3003.s.css.fujitsu.com (Postfix) with ESMTP id 17151200537A;
	Wed, 12 Jun 2024 16:56:50 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: kobayashi.da-06@jp.fujitsu.com,
	linux-cxl@vger.kernel.org
Cc: y-goto@fujitsu.com,
	mj@ucw.cz,
	dan.j.williams@intel.com,
	jonathan.cameron@huawei.com,
	"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Subject: [PATCH v11 0/2] Export cxl1.1 device link status register value to pci device sysfs.
Date: Wed, 12 Jun 2024 16:59:37 +0900
Message-ID: <20240612075940.92500-1-kobayashi.da-06@fujitsu.com>
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

Kobayashi,Daisuke (2):
  cxl/core/regs: Add rcd_pcie_cap initialization
  cxl/pci: Add sysfs attribute for CXL 1.1 device link status

 drivers/cxl/core/core.h |  6 +++
 drivers/cxl/core/regs.c | 62 ++++++++++++++++++++++++++++++
 drivers/cxl/cxl.h       | 10 +++++
 drivers/cxl/pci.c       | 85 ++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 162 insertions(+), 1 deletion(-)

-- 
2.44.0

