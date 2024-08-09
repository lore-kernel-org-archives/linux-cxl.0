Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A3318F2F2
	for <linux-cxl@vger.kernel.org>; Fri,  9 Aug 2024 08:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723193908; cv=none; b=FF0+oaGae2cCIdK7fLznM+z/LX4/ZFyivzJ0KkyjvViYdG8dPfqoF79R01CTWKuWqQpKa12+j6xSGRZpD8KDu6QQXOqaHQJgqvB9yuG2hSXu0Nqxwqc0jEcRw4QL7SCjcodNSvemBu7k5tpgBQcUENanDTchjjnDx4zmkALcPVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723193908; c=relaxed/simple;
	bh=aaBjJhGZi5IEPHxQZlvkqNzzr/hnUolzpoaE2tqhXf0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HtgQSSZt1KCAywFKruDsHtlP4wiCOaiBRFsJGN6jVzt41xoNKP2tH+IMEDFRhc0CiKUpD+hIyhIDOM26Li9k+aRFOmQ0HvGb3wy96SL4qjI1zMJKx5dK/zpnaa2c17d6gjJHv68nxAu3SntXDqn5G0RchRjSf/LmP0Etu8ORoUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XXpT5X+8; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XXpT5X+8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723193907; x=1754729907;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aaBjJhGZi5IEPHxQZlvkqNzzr/hnUolzpoaE2tqhXf0=;
  b=XXpT5X+8K9GNDEPSdltTT0GJeosuSLgR4G7CUDuClAQAMnmK1dwHFvVr
   W19UMPhZ0G3ruqDCxp8KIZmTN1rqmIyvHmC+R499I7EAGMpzcuJ6rf6Qm
   HR5jpfOA05mX/3r7CYBiDFL+76/IkUEm2wE6SIjwBKXDOhBk4IxWlwN0V
   MKsH2p/XoEoi+wRuXxPznMrKSCMe/zNL4sd/3+ylmV/6/TWPTWnIwLS26
   y7r1xWIoPVBWrT4n5ja3eATJocVa55BwXa2Rd0ngQN7TbTbGchbtuUqiD
   75ufd9iw7DlTPc5yaN2W2/oA4E1pYdZqlMKJbfufHI+r1mRilhvKERyIN
   A==;
X-CSE-ConnectionGUID: PD1mGgqORBKuoGDvJFuh9Q==
X-CSE-MsgGUID: hTBLiaEcR7ywIxz6p/2hvA==
X-IronPort-AV: E=McAfee;i="6700,10204,11158"; a="32507236"
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="32507236"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 01:58:19 -0700
X-CSE-ConnectionGUID: RYhkaLcGQtmXUVERnYfi5Q==
X-CSE-MsgGUID: /KAh7UX8QBSlEWAlhfb7SQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,275,1716274800"; 
   d="scan'208";a="57164171"
Received: from s2600wttr.bj.intel.com ([10.240.192.138])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 01:58:16 -0700
From: Li Ming <ming4.li@intel.com>
To: linux-cxl@vger.kernel.org,
	rrichter@amd.com,
	terry.bowman@amd.com,
	dan.j.williams@intel.com,
	alison.schofield@intel.com,
	pengfei.xu@intel.com
Cc: Li Ming <ming4.li@intel.com>
Subject: [PATCH v2 1/2] cxl/pci: Get AER capability address from RCRB only for RCH dport
Date: Fri,  9 Aug 2024 08:27:49 +0000
Message-Id: <20240809082750.3015641-2-ming4.li@intel.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240809082750.3015641-1-ming4.li@intel.com>
References: <20240809082750.3015641-1-ming4.li@intel.com>
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

Fixes: f05fd10d138d ("cxl/pci: Add RCH downstream port AER register discovery")
Signed-off-by: Li Ming <ming4.li@intel.com>
---
 drivers/cxl/core/pci.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index a663e7566c48..51132a575b27 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -834,11 +834,13 @@ static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
 void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
 {
 	struct device *dport_dev = dport->dport_dev;
-	struct pci_host_bridge *host_bridge;
 
-	host_bridge = to_pci_host_bridge(dport_dev);
-	if (host_bridge->native_aer)
-		dport->rcrb.aer_cap = cxl_rcrb_to_aer(dport_dev, dport->rcrb.base);
+	if (dport->rch) {
+		struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport_dev);
+
+		if (host_bridge->native_aer)
+			dport->rcrb.aer_cap = cxl_rcrb_to_aer(dport_dev, dport->rcrb.base);
+	}
 
 	dport->reg_map.host = host;
 	cxl_dport_map_regs(dport);
-- 
2.40.1

