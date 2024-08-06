Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACC0A35
	for <linux-cxl@vger.kernel.org>; Tue,  6 Aug 2024 04:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722919589; cv=none; b=bqeHhZdivlBnhVG1UsM6C5MItPHGWsq4brZALUD6WW7oEj6g+R45ThqHVGQumNd4KPVQmnw5wwXTFwil/3EI8H2xLiOYnsAkDXvqJ6l1n5uazwvCRchzFFpYoU8QnjCvEgWhbYQJRZMqvFWjoafIrtx+9FsVBOYnnsmEH0Yo+bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722919589; c=relaxed/simple;
	bh=Du61TcVfSZXRbwLaBLaRpgqhH49Z7t69PBOS37m4o5k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VfQRysHrWrkjVCDj/qJyiN7hxFj4UnXq7MuURDYFKCXmgiUI6wZxPRvEjeU5+dpswRlldDPnaB+WQlGeDCDQWRxxrdrhzdMvoHZfdexFbqrVo4LoOy8UVpseHMi8c/VZXum4TEZ48dGkt/dSL2/UCt25YfbUrjEDuucpmD4Mciw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cWTqw+x6; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cWTqw+x6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722919587; x=1754455587;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Du61TcVfSZXRbwLaBLaRpgqhH49Z7t69PBOS37m4o5k=;
  b=cWTqw+x66Q6MiWZIqnnqQu9GNPfmyTnVamXS2K1H97rfeqkLsROAnTP/
   /BobWJUyDPNzbJy+AjtiwheC2XZmStFLIBBdeWOivZaiXbCz3VrZxVTfN
   ZWMBK8xZ2FdkO5RpnfBqINNhQAuaZ6lQmpMMBobgQItSNduPwlJdtn4Wi
   dB+kQ1nM8cM2vybHrHqKgpNvRiG8XH/MxvaA5AOzvCgL6q2qafAebEVsV
   u6SNNHVzSLu3snmug7S7XCUz34jtLEM6614mJ4UsS3DOJwomPM2uYmQF7
   wzihq+/ni9/Jqg3RfriHj2OGdTQY5WwoZV0T+sIMKL4oUXvjylD/3AQJg
   A==;
X-CSE-ConnectionGUID: 9oQDrEpfTZmWpDdHS7hmPw==
X-CSE-MsgGUID: b7mmi6MWRZ62k7wTtKynww==
X-IronPort-AV: E=McAfee;i="6700,10204,11155"; a="12879304"
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="12879304"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 21:46:26 -0700
X-CSE-ConnectionGUID: 4NzoHd4dSt+vzdgdz/bzMg==
X-CSE-MsgGUID: 3kbF7Z1LR3CvIh1b7OhNmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,266,1716274800"; 
   d="scan'208";a="61010769"
Received: from s2600wttr.bj.intel.com ([10.240.192.138])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2024 21:46:24 -0700
From: Li Ming <ming4.li@intel.com>
To: linux-cxl@vger.kernel.org,
	rrichter@amd.com,
	terry.bowman@amd.com,
	dan.j.williams@intel.com
Cc: Li Ming <ming4.li@intel.com>
Subject: [PATCH 1/1] cxl/pci: Get AER capability address from RCRB only for RCH dport
Date: Tue,  6 Aug 2024 04:15:47 +0000
Message-Id: <20240806041547.1958787-1-ming4.li@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cxl_setup_parent_dport() needs to get RCH dport AER capability address
from RCRB to disable AER interrupt. The function does not check if dport
is RCH dport, it will get a wrong pci_host_bridge structure by dport_dev
in VH case because dport_dev points to a pci device(RP or switch DSP)
rather than a pci host bridge device.

Besides, cxl_setup_parent_dport() can exit simply if a RCH dport in the
RCH topology created by cxl-test, in the case, the RCH dport's dport_dev
is a platform device, and RCH dport with an available RCRB and AER
Capability is not supported yet.

Fixes: f05fd10d138d ("cxl/pci: Add RCH downstream port AER register discovery")
Signed-off-by: Li Ming <ming4.li@intel.com>
---
 drivers/cxl/core/pci.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index a663e7566c48..f8a3188f5b17 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -4,6 +4,7 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <linux/platform_device.h>
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
 #include <linux/aer.h>
@@ -834,11 +835,16 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
 void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
 {
 	struct device *dport_dev = dport->dport_dev;
-	struct pci_host_bridge *host_bridge;
 
-	host_bridge = to_pci_host_bridge(dport_dev);
-	if (host_bridge->native_aer)
-		dport->rcrb.aer_cap = cxl_rcrb_to_aer(dport_dev, dport->rcrb.base);
+	if (dev_is_platform(dport_dev))
+		return;
+
+	if (dport->rch) {
+		struct pci_host_bridge *host_bridge  = to_pci_host_bridge(dport_dev);
+
+		if (host_bridge->native_aer)
+			dport->rcrb.aer_cap = cxl_rcrb_to_aer(dport_dev, dport->rcrb.base);
+	}
 
 	dport->reg_map.host = host;
 	cxl_dport_map_regs(dport);
-- 
2.40.1

