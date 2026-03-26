Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0238C38C430
	for <linux-cxl@vger.kernel.org>; Thu, 26 Mar 2026 21:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774559701; cv=none; b=Be5cG90lznZJJUT1n0/s/q66vwXgImZ04m7eMBltkOThj0VSsZYuqcwtDujk2Ht1KePosWfMf3Wdh0hhoc9W+CEyg1wVBRgJIsJIxwoXfrSLZicqlaIgELGCvDbgmlTZRbj6sNsVlAPsMAgAC6UhkqYSNMsRn7LEEQ2LEY/HC6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774559701; c=relaxed/simple;
	bh=J6xQsSEq5vj+7CfJxtLgbCodci3JmIG4a67cxHdS2tw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RXJ5AT3KKEOF8WYDHfH5QyeiTuY3iHUW1YP90CDQjrSu+clvekcF7VxkGD5qtZ7KDHMlGVlMDGoBkDRsb3yJZ8tcYUwzzTAZDz5Vcjd1XlxYXaJf1Ux1QyyDHn2Rp5InffSnOAgHbwS+NEbrAzcqOvm2KXBbvbiIa73mthC3RTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com; spf=pass smtp.mailfrom=candelatech.com; dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b=a5Md++/w; arc=none smtp.client-ip=148.163.129.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=candelatech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=candelatech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=candelatech.com header.i=@candelatech.com header.b="a5Md++/w"
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail.candelatech.com [208.74.158.173])
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id AF14560007D;
	Thu, 26 Mar 2026 21:14:56 +0000 (UTC)
Received: from pk3.candelatech.com (firewall.candelatech.com [50.251.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail3.candelatech.com (Postfix) with ESMTPSA id 0B29B13C2B1;
	Thu, 26 Mar 2026 14:14:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 0B29B13C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
	s=default; t=1774559694;
	bh=J6xQsSEq5vj+7CfJxtLgbCodci3JmIG4a67cxHdS2tw=;
	h=From:To:Cc:Subject:Date:From;
	b=a5Md++/wmSWvHL3DBNJ7HcmhNm4+zJ5y9mLf3ZiN7MNh3CaiqFDr2uuNWjIY/K2hR
	 b4JIdQdIR2WgNiN2R8YFzhAtcYDMcmEynGd5h58NeIVx0bu2FBMbXyTxh7D7hvfNVK
	 fdelm65KwO57aTCPUbLTBW4JNjO/YsOqhKs2REAg=
From: dylan.eskew@candelatech.com
To: dave@stgolabs.net,
	jonathan.cameron@huawei.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org,
	Dylan Eskew <dylan.eskew@candelatech.com>
Subject: [PATCH] cxl: Add CXL_PMEM as dependency for CXL_ACPI
Date: Thu, 26 Mar 2026 14:14:42 -0700
Message-ID: <20260326211441.83573-2-dylan.eskew@candelatech.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1774559697-xXc9I8bKzNZf
X-PPE-STACK: {"stack":"us5"}
X-MDID-O:
 us5;ut7;1774559697;xXc9I8bKzNZf;<dylan.eskew@candelatech.com>;12862f54078ff5ce47578406b6d80bf8
X-PPE-TRUSTED: V=1;DIR=OUT;

From: Dylan Eskew <dylan.eskew@candelatech.com>

Prevent a linking issue against CXL_PMEM when CXL_ACPI is configured in
Kconfig.

Signed-off-by: Dylan Eskew <dylan.eskew@candelatech.com>
---
 drivers/cxl/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 48b7314afdb8..baf1d17ec0fc 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -58,6 +58,7 @@ config CXL_ACPI
 	tristate "CXL ACPI: Platform Support"
 	depends on ACPI
 	depends on ACPI_NUMA
+	depends on CXL_PMEM
 	default CXL_BUS
 	select ACPI_TABLE_LIB
 	select ACPI_HMAT
-- 
2.52.0

