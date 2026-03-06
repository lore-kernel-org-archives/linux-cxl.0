Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011069.outbound.protection.outlook.com [40.107.208.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE84436C59D
	for <linux-cxl@vger.kernel.org>; Fri,  6 Mar 2026 16:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772815683; cv=fail; b=nWGWjx4GgnGI7iaobWsAMyWQsaze3OWANjg3c4gWt3WJhK1pChre2xBR7tTq4m2hEEtkHV2xo+FqNUQjvakYrqyc+INob6OczkRdh9L8NeCo3raKXRoqnvlGRgdw86UybUESHGWgESKXn7XFuB2x1/JjBEEaLASPul9CCDByZ8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772815683; c=relaxed/simple;
	bh=SROxJWB3qctjEJ1VXsaO6SJK56l74af3jzhFM4ekAhQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NmdR6PGhgVpjBtsHVTqJQpzVC/DVQ8JVtNGwY2LanS3jgk8W1RrouUJcx+jExHqfdg0S5urk+nBNqQ5Yyw+S92tOYtZj7Z34RJWxIPQbNbD8PXqeFxCZmsYMj2+1o+0xyI6eoaQJ/pnf9Lj5VUyCKHnHThfq37/ZlTVR5yhFS4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BeAELRLe; arc=fail smtp.client-ip=40.107.208.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BeAELRLe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kMyWQnKUGf8hpjaVa5+IOpNhyjWDusb/PwHMckOeO47MNDHah8LA3pJRnY66hHnxVpXeUkuXW0xWOVd2WvQsCmvVIi7f6n8IMBLo+SiuRDHHLbMFmTxZpP0+RUfOoKM9a9msD2Lm1PvFpXoAStVo/EojWQsYejc0Pff6djOmUzOY7Aie+LD3lDRyJcc4rVQUwta9bQskiORcBvfGyJko/B+V5pC2l4lpd0EhEXsrUITTMlYbHf/FhN4IEmGP8IHlPh/cCfDaelAY07DctCGZ1lv85zGHV4fKf+hTqylud390wkqzIA0vSWoGPXA52Dkx11ZHRdRIPcVoq+KuB7srZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IgrZtYk+SknVNc2ts1z+5GG9UAL5FRS5cSSlVcAWDB4=;
 b=W3YkjJuY8DsLmbruPoyNJk4jFpU6l36tzIdwbJVev8vqu1zRW6tutyia70F9kOWhFaMtnC57k9zhqSWRo6rRi3hM16u8Avp8ebIkJkJHngH6KtPXjxuzcQnwKSswNFgFQ4xBFr5ekYi1gvzdZTkEaCbJ748qQNkUp1CCWXneElI4/tFp6IxViJ7NmUxvUHZXTev/nJq0BZtYDhfCDjLbcM3Pu7VAlfniRyPL2aw9lbpbUdWp6YeG0EqnufUg5dI6h6ye9rYmnMGKTUwXtX4HqA42cBDcW/yUHzHcYRdV/1SDP2Q3xRXRKP/yjgsH5Hq4RdocQ0HECpQoeTRfJrHtAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgrZtYk+SknVNc2ts1z+5GG9UAL5FRS5cSSlVcAWDB4=;
 b=BeAELRLe3gDTLIn/VM/H4b+Q70iChQGJGtlr1znK5a3JCQxNUlYywTMOwyy6HmmXKLf0yGODzsVoOEXSGG/pBpen45nMCTccHEW8WTRN/XJIcMQxcwKCjnwtrdGuPe5+2wJJcJMbHgJa/wyOo8G/EvdmxKzB7BOwD9WeTPXPuPE=
Received: from SN7PR04CA0231.namprd04.prod.outlook.com (2603:10b6:806:127::26)
 by CYXPR12MB9443.namprd12.prod.outlook.com (2603:10b6:930:db::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Fri, 6 Mar
 2026 16:47:54 +0000
Received: from SA2PEPF00001505.namprd04.prod.outlook.com
 (2603:10b6:806:127:cafe::b4) by SN7PR04CA0231.outlook.office365.com
 (2603:10b6:806:127::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via Frontend Transport; Fri,
 6 Mar 2026 16:47:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00001505.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 16:47:54 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 10:47:53 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 6 Mar
 2026 08:47:53 -0800
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Fri, 6 Mar 2026 10:47:52 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, <gourry@gourry.net>
CC: Alejandro Lucero <alucerop@amd.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>
Subject: [PATCH v4 4/4] cxl/pci: Remove redundant cxl_pci_find_port() call
Date: Fri, 6 Mar 2026 16:47:41 +0000
Message-ID: <20260306164741.3796372-5-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260306164741.3796372-1-alejandro.lucero-palau@amd.com>
References: <20260306164741.3796372-1-alejandro.lucero-palau@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001505:EE_|CYXPR12MB9443:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a4fe133-91e7-43fe-4bbe-08de7ba01cc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016;
X-Microsoft-Antispam-Message-Info:
	JcuLlsFV1mwpUXfmaJti5EcBmj+9muTwVwlllplNdYmYFbqBtLyaVLTLayyB6K9w1Dktj+QXpXwvzD4BQYwvE+4vboqjN4NPBTQmWlc74qHGny+EM7Y2xqQNKLi/r654XC13HbyCV+SWQ9iMc5sZy6pQbh9ID/oAUp03TfgcVgO+1lKNKRFiLBuaZaRPekGp9lytHHQQNERwcF2FS+EhY0ec4iR3wDo9DmRaUQ7A0qf5M5eC+cqk6jM/dGS7RKAHbI93HnamrGKsZwZi3iNqj28SiSJPYtD/ZyJmoTD0WHwKcroXDKunOmPLp0P4Q2x8Vqc0ACSmi/UjMWd7jaPFgs1IYMDM4xld0qQ9Z1Ir5ui3SaUGXpRJy4UjpA3Dd/YieqQ5Wz/19z4imwbQIUUeVzXHRSzUd2p7qJj9OsEdWSzsppVjoFd2GjiLEfgvH9kOF7/8WvJaHLdiiLhTv1K4pFFEhuY0sYhTYgmqHzSyAoLfBtGmq+bADdW4VxJnOyVmvHboQb4HkqUUPYGsg29FGUnV8/bLEiAPaQBw5WngL3UWc0Dgk2xW2bwnI74LomU/hAFlodC8QQvt3ksPDO0Ue+/g+/bVlh11KLhheZVSrHpknzRovenN46596jAXy/KAfcPL6lbb1FjrwynOkF5QYVoQ4+aC948Cz8K5Bq+jiHsMvkphgtQ+eeMAFc0+x/f5wXtrJQUC2EGnLlUF+FUZvUC+etOEiE1w4L1nDtVCKwPAapMvU3NTF2ZC/cix5qsOOOWu22SWGBT4eeSRMUXKbw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mMZFAJ8OxKC46a0N2hJ7dxFDhJF6zItYE6oIw7pEcVWCL2nLgNFC3UQo+l9MOHRax3dGBD2v/QiBDxdF7T9IFE8KsK/DNoGug1vNHcKSY/xECiKmfZcfGtLTJ0KvKJso5lUr7cUIsq/wfWnbSGYofR/P5Vi2LcyKKKY0TmXrfF8h/opM200epw/rqWrX8ODW2cAhfJjCU+ZHAL0qodhg5odIToF8O0iHmz88KZkhInfd17ZWWyYU06xKTNtvvXtzEVgA2tus/0r/R03u/LUR45wOkxIBoo505/fw8biVrAcUD0se3XJlLJ2tcpbATfphc8bE8gdigT4vqo2H+ILvrr5UAw8dXbnFtEvVXEuDu2EZt2UmqlRKx/iwtBA3dxplD0rpyPcFbdnpnr4GyLkGyGWs2Cv4DJ7aDAQESJXBvIxx39o/Fk3pY6rH1LOFkgto
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 16:47:54.0347
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a4fe133-91e7-43fe-4bbe-08de7ba01cc2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001505.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9443

From: Gregory Price <gourry@gourry.net>

Remove the redundant port lookup from cxl_rcrb_get_comp_regs() and use the
dport parameter directly. The caller has already validated the port is
non-NULL before invoking this function, and dport is given as a param.
This is simpler than getting dport in the callee and return the pointer
to the caller what would require more changes.

Signed-off-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Alejandro Lucero <alucerop@amd.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 drivers/cxl/core/pci.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index c32cc62c501d..d1f487b3d809 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -707,11 +707,6 @@ static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
 		.resource = CXL_RESOURCE_NONE,
 	};
 
-	struct cxl_port *port __free(put_cxl_port) =
-		cxl_pci_find_port(pdev, &dport);
-	if (!port)
-		return -EPROBE_DEFER;
-
 	component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
 	if (component_reg_phys == CXL_RESOURCE_NONE)
 		return -ENXIO;
-- 
2.34.1

