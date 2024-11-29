Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FBC1A38C2;
	Fri, 29 Nov 2024 13:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732886935; cv=pass; b=p/PIgzhJ7UXacVGeb4SIzy4jAgSzexNrzkEj9uR+bZyij+c9ruNz8wDuWY1gzK0Etm4RRpCpWMkNqXN0B1JHuQc9LYs3/Zs6vPrbY7RlXMAXSYDh5hsO3JSpDpVYtA45yVy/rB/UUdu3S9MO6A2Ciojkc5Ihr7pTpFeu3RHCJuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732886935; c=relaxed/simple;
	bh=wy6gqQcFEFaVjfqLlyCe9evK3Ai+1LDLdq5P0+hNfXU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D/SHTuxNwr4H/gjjYknqE8SKulL5wvTEOHCmbtD8yfVayip37YoFCDKnFSawbFWRRq22dR7Sx6AlaOYLYC4o/Lo/5TLfziiTDF+z9+o0Ns4GGn89etYvt0EK2gqJxFv6gUgyQhEWAr/0tZS80cvC3nZOV37XsWa6jpjW6I3vjZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com; spf=pass smtp.mailfrom=zohomail.com; dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b=Ck2M9hJ9; arc=pass smtp.client-ip=136.143.188.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zohomail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zohomail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zohomail.com header.i=ming.li@zohomail.com header.b="Ck2M9hJ9"
ARC-Seal: i=1; a=rsa-sha256; t=1732886917; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=MV7waX7Feug8VctlviINNLAXbACXy9WLqylSe7mo2MO41rY65LyhTqv8mLynGUxn63NaNSMIAy5ML3tbJ+3Aoann6n2uALQ5H+cYPSKqwivF+N4kLvFIdZFL3GarYoeAJ3RII3KwxMZ4BrgvKT5CLJrH1wpK/aNcggW5u9Rsn2w=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1732886917; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=AlThrPchPL0Jpq0oUlqE/avwqc2LgQC4NFI+hCPhZao=; 
	b=KUA0EhADhIDpcGGSCrQQkyMHkHyeqqTh0HCVBaFcp5HaPUVVawkPI2MvGU4x2KxiEPrbcVj6ru5K5fZRvuKR2dlTR3FHNrYBdBFZu1NsRVAUkTcMQBF6j2VIjV5LmEMsRYwWIrgdKlYZMbrA9bE1fhvoxkd+X5O/CpGMPThRGPg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=zohomail.com;
	spf=pass  smtp.mailfrom=ming.li@zohomail.com;
	dmarc=pass header.from=<ming.li@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1732886917;
	s=zm2022; d=zohomail.com; i=ming.li@zohomail.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID:Reply-To;
	bh=AlThrPchPL0Jpq0oUlqE/avwqc2LgQC4NFI+hCPhZao=;
	b=Ck2M9hJ9ZWUnwOhay36K0/8r+Uan/CmG1TZyiQUekx84M95uOvLpJf0to+gkOsFy
	LndYRiKiZfJSkK6C1KYjYffuLll6o7XEwX8tTbHZs+TcGR/UdSYmzv58h80ZEzLQViO
	RCTHrcs1sAtn+BcfEBGk1qXYSLTUkXTNL0o8CK4A=
Received: by mx.zohomail.com with SMTPS id 1732886915948639.0421116615139;
	Fri, 29 Nov 2024 05:28:35 -0800 (PST)
From: Li Ming <ming.li@zohomail.com>
To: kobayashi.da-06@fujitsu.com,
	dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH 1/1] cxl/pci: Check dport->regs.rcd_pcie_cap availability before accessing
Date: Fri, 29 Nov 2024 21:28:25 +0800
Message-Id: <20241129132825.569237-1-ming.li@zohomail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: rr080112271204b56560940fc1fb4815dc00005b0ba9c547ac05fcf8edf5d86c3b5608c27b4fe2934730b37d:zu08011227f38e96589e94b8178385bb7700003290854c15527369e4d62d22afaa7dc5d268e6607a61167b15:rf0801122683064ef6b684090f8f9c5da900006d5da07f2b1217700b4ad7b2de7aaff1798b3b7563e8862b:ZohoMail
X-ZohoMailClient: External

RCD Upstream Port's PCI Express Capability is a component registers
block stored in RCD Upstream Port RCRB. CXL PCI driver helps to map it
during the RCD probing, but mapping failure is allowed for component
registers blocks in CXL PCI driver.

dport->regs.rcd_pcie_cap is used to store the virtual address of the RCD
Upstream Port's PCI Express Capability, add a dport->regs.rcd_pcie_cap
checking in rcd_pcie_cap_emit() just in case user accesses a invalid
address via RCD sysfs.

Fixes: c5eaec79fa43 ("cxl/pci: Add sysfs attribute for CXL 1.1 device link status")
Signed-off-by: Li Ming <ming.li@zohomail.com>
---
 drivers/cxl/pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index b2cb81f6d9e7..e53b1c95a248 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -836,6 +836,9 @@ static ssize_t rcd_pcie_cap_emit(struct device *dev, u16 offset, char *buf, size
 	if (!root_dev)
 		return -ENXIO;
 
+	if (!dport->regs.rcd_pcie_cap)
+		return -ENXIO;
+
 	guard(device)(root_dev);
 	if (!root_dev->driver)
 		return -ENXIO;
-- 
2.34.1

