Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BDA0DF44
	for <linux-cxl@vger.kernel.org>; Thu,  6 Jun 2024 07:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.54.90.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717660001; cv=none; b=Z2rE/Z7pxRBffrb2V9eKify6rMBCFAvmxzd7UurXo3s+whVszKnQ/w0EVtCUsoPFkk8KavfvJE8E0h+9Z0nlTcHmKUKVW9ZoizYd2CsOQbhj0tBuFSSX9QxuZSt8e5MYmvoWdgqgDZe/prNory5A5rH6cEFa8y/eS4YRYN4y0OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717660001; c=relaxed/simple;
	bh=dsp/kdiXryVsOIueK4Ioz3ByoAZ0VBH1HwQ+fL3IwC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MPpmPn8aGPBPBYw+XlHVbnuoMv4YEiTR7FY7vF0MbjsCzABH9quWaPQFCjfn36HXOoZwbW7CWg8CJPGsQaQA5qq/G3koGkTMBt4V5xwu/SjSznJm9l7SztSpdnVvjooV1BbSDFnL8ZTE0I3ok3bwzYpWLLK242L0zfMWN2XTP+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=AsdBuM7t; arc=none smtp.client-ip=207.54.90.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="AsdBuM7t"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
  t=1717660000; x=1749196000;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dsp/kdiXryVsOIueK4Ioz3ByoAZ0VBH1HwQ+fL3IwC8=;
  b=AsdBuM7tpxiCtLq2MYK8FiOP05ROlZbO10dOd1EdL9f9j3l2MMguq7qP
   xXIxkBMegBhQVVZSgaDHvPF79xBuhV2qH+dtHU+CTRHh0LVWldhV4EnKv
   7MX1VaYZlnjaONnaLCJ06M/WGkCwsNfSezum/XxwrqQ3rOg0lp+jo4XTS
   GLpHRKJcCkhuy0e3/PGeixbNm78fcAjGqKx3VEmtXNApjDM9SUto2KvM2
   2pF7OOrZ6GXoA0pWoAEUWBrACYj7+Y60MLp6GUKx9adHNubEo4jcC+xGR
   BAqrmODQocL6TTj8NJRrJdAhqc3FbciR06qBLXxR+dSV4zNfGfdYfyUxk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11094"; a="162234553"
X-IronPort-AV: E=Sophos;i="6.08,218,1712588400"; 
   d="scan'208";a="162234553"
Received: from unknown (HELO yto-r3.gw.nic.fujitsu.com) ([218.44.52.219])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2024 16:45:28 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
	by yto-r3.gw.nic.fujitsu.com (Postfix) with ESMTP id 8EF3CE8521
	for <linux-cxl@vger.kernel.org>; Thu,  6 Jun 2024 16:45:25 +0900 (JST)
Received: from m3002.s.css.fujitsu.com (msm3.b.css.fujitsu.com [10.128.233.104])
	by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id DF74BD3F0E
	for <linux-cxl@vger.kernel.org>; Thu,  6 Jun 2024 16:45:24 +0900 (JST)
Received: from cxl-test.. (unknown [10.118.236.45])
	by m3002.s.css.fujitsu.com (Postfix) with ESMTP id B44A12020A51;
	Thu,  6 Jun 2024 16:45:24 +0900 (JST)
From: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
To: kobayashi.da-06@jp.fujitsu.com,
	linux-cxl@vger.kernel.org
Cc: y-goto@fujitsu.com,
	mj@ucw.cz,
	dan.j.williams@intel.com,
	jonathan.cameron@huawei.com,
	"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Subject: [PATCH v8 0/2] cxl: Export cxl1.1 device link status to sysfs
Date: Thu,  6 Jun 2024 16:48:12 +0900
Message-ID: <20240606074814.5633-1-kobayashi.da-06@fujitsu.com>
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

Kobayashi,Daisuke (2):
  cxl/core/regs: Add rcd_regs initialization at __rcrb_to_component()
  cxl/pci: Add sysfs attribute for CXL 1.1 device link status

 drivers/cxl/core/core.h |  4 ++
 drivers/cxl/core/regs.c | 13 ++++++
 drivers/cxl/cxl.h       |  1 +
 drivers/cxl/pci.c       | 91 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 109 insertions(+)

-- 
2.44.0

