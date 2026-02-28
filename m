Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013067.outbound.protection.outlook.com [40.107.201.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D07B2E92B3
	for <linux-cxl@vger.kernel.org>; Sat, 28 Feb 2026 17:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772299566; cv=fail; b=plSxl3AjqlVOWNbRcddg8lywbEZfWi+TG8pqYoRwWTCw4UqkxS9J3/RujSLmmUkuPMEj4nEVb+GA0sDGPwHdOKKZvKs88il7z//mZBAYTeuJRPxIvV84xklJRk5L7UiXJXqKMshNDEvJOjAbXq3wHtube+iTh633gQNeyKEg7kM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772299566; c=relaxed/simple;
	bh=J7LLNjgCIuB8G/t654JwbiMwZlDHh23QqAjiNFB0cYQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TMGX7jQXdofyS1kk7UlyL60EWWfM20pFHcz0c313x17RDbQ71dhddBQLZgUw42AalyjXdidK9i1NpQ62cMuonu7C8KaVH1FrXK+lviaJ/po2Gvwp3I6Zx6GvxXKNi1/tj1v3sFdR2UHXsTOjB9L6P4+985EMlaqzqWTxaJdbK9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kolOORXQ; arc=fail smtp.client-ip=40.107.201.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kolOORXQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m3m3628fUsFL/8jju8FnBQvPz9Y1SDc8HtYME1PC1r9g0gxC2oUqYHe7x+qVKBFdptla9h+iT9Ulx4WKgZ75Blwzmhm5cUfsd29TnYFJ9151HSILnszIvngHEK33DsbE3VPfuqMsA1MrGZSiGGnBzaCRUrF5O2hMRDEd7vtXvvNhACOS65/MaT5qsHuu0UDXOroaKU48dsdE39st5WiOFO49veNxIZP3eZ0LRQb8UhIozuJwL7/LvGqKymWR1S4a5A3M4Yj9zv+opT6Oi/1HbdQIfWlzbKkqR0v3akoPcHTJytPxhvClFf6N5RWaP0Nv8N29V9XtMR1JEL0HWdmLxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SHOdCZVIHMTNiz0GtcJl9jAG780LcxxCBFIE+4lwiBU=;
 b=ItzLI5XoKobBan5JY/aCQMMdJcdhW5bKufEN35l5S6D298r5Lm7Ej++5dW1JimapO/oOtWImI+itxva9XxISESEazsYOVzAmJO+uYlSjffJrKInHhXjIrSGOg+XOkJzTZjjJ/RstpDW37SoTpRSqw8FdZdBb5ZO2fpODJx6J8RMV3vvj6neFSG7a2Kobb6YvbT5Ktp1bcsXoVF16uIJRMA1r1CtNWhV2C69p42kOGjkfWHDZfXDxROHla9t6TWDyn54W2ioORbcIDH5L7aPKnaPQuHqeH6tnIsciF4RE2u6YU6LU/BSPjgU2FItcLEMfZRg46KNnnmNuRHa7dUaujw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SHOdCZVIHMTNiz0GtcJl9jAG780LcxxCBFIE+4lwiBU=;
 b=kolOORXQ7FAmRgomfTHcrZCios71ZuL0SSUdfI7gXvQuJvOrmCIBohIbe+UURubuEexzEznr4SzEP34rb4xzVKgsfXLo7GFTuh59DgLyyABSpzLFVxL8qo8QrxTUwssAJL7PuTe9OWALdpZaeoqaUTqpe9F6aDHW+0mVeoaTpF4=
Received: from DM6PR02CA0132.namprd02.prod.outlook.com (2603:10b6:5:1b4::34)
 by CY5PR12MB9056.namprd12.prod.outlook.com (2603:10b6:930:34::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.18; Sat, 28 Feb
 2026 17:26:02 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:5:1b4:cafe::fb) by DM6PR02CA0132.outlook.office365.com
 (2603:10b6:5:1b4::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.18 via Frontend Transport; Sat,
 28 Feb 2026 17:26:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Sat, 28 Feb 2026 17:26:01 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 28 Feb
 2026 11:26:01 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 28 Feb
 2026 11:26:00 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sat, 28 Feb 2026 11:26:00 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, <gourry@gourry.net>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v3 4/4] cxl/pci: Remove redundant cxl_pci_find_port() call
Date: Sat, 28 Feb 2026 17:25:49 +0000
Message-ID: <20260228172549.1121832-5-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260228172549.1121832-1-alejandro.lucero-palau@amd.com>
References: <20260228172549.1121832-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|CY5PR12MB9056:EE_
X-MS-Office365-Filtering-Correlation-Id: 3555c679-1f3e-43aa-1f87-08de76ee71be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	H+cTLlpnwZwdrwOkMFTibof2FQNTwtNKmFXzVm5W0N+cgwAEO6h13X85i/b/+jIZCRr6vk9M0fp8+ESto/CU0LLR1iEj/S4SJqEk4eR7aUMC3M3Ym1P/gtRR/aIJ8UNgCMsdq5auyme5aWAYhC5JLJocYoW0dNY5TAdBDesdkjbHmCpRXjIl2mxV6TZ2hTzFxt3YFpAduH/LBf7apfBKaIw5NCiDmYhHxhiKyxxeZ+t0PmbqQRSZxdQjxi2T8b4u2X/L7gDD90N7ZIJFPlfRdsRVwmdy/duDiqnMYtaJ4/yUOHE9SU35Eyri+ylSbH7dMOnQ0W3s7oeTQEc8WUXNW3vZoC0td1ob9aX0b3v3FAUTmTiHBfVwSpmPT52GevmVjCLxm6xPOW2v9mD82m1vANBZVRakPkotT5VgZK/O/o4DbinH1tCPEaX3LgqmP+lKExYLIrhkO3+5+NW/vgnFC0X5vuvlFN4Mx0/pQ5v0OpQEslqV5D1thokAidlffydDfll0XchRzdzbzMzYSyMzg9G7/g23irCw4rp3UEWM1AJkgbCy3aWJHA41k5a9fFDBjf8ecm2oz8gHR78kRJJy1+2eV8ZVKl28lZVueRPEJ1GO5U5EnoD6p6sttI0ogrK7cQzbNzLqYepcbfADOK/FTJeqoZ48X4A+rGbH44PtbiLONDpwdUU5x68SrtegZgZ5hnhNoa1zQVPf7S/o61zSv4vDTYR5u61W32Ghj+PHHtwHRWI51iCgIUaaGnPzq4wSiojV5NBCZw6KdyZRdhnlzduR/n1owkf5zBj/T/iwiDrFWAiLEQwVjSVBhqYzdxUEbCrXItc6kxxqmpCnOLuNNw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pD1Jtkmo54QaFj+67o2M5wddrYb1gcW4D+peaLFfv4xEaS0QEGfaLmi9svng3+DpdhWbYq7echfyjVDpMXpHxmTqDb+JTlrgYgX2/YNAuwUHLuswP35Nkxr9/4HtOeqBOZ/FfqfBzeV/IsX5nKrMu3s0mA7G+y4Gf627DA7xYYlaIYM5ULu0nbkaa18CTp7SZPGY3fD15Y9THxHqjFxcXjJYK8sPlqqvgWTTMlM0ljnMfC8PQXiNkhS27eiDsc0RpsW4WNNzcxCLGx8bmMy7YVmpvaBPsi13PFufX7O/gqSug0IV/pgW6YR2YVezcs2HMnsHHFCS5i1LvxtpfwnHJ0aA9D7d8nl9wHfb7oEfsXKXtyIUMPEnwOtt8cYEX0OyRAkrK/LBYuY2WWu97wxXCmNOgGGEp8C7YX3UbG8hZGou5geTj1nwQtGwDzaXeU1G
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 17:26:01.4906
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3555c679-1f3e-43aa-1f87-08de76ee71be
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB9056

From: Alejandro Lucero <alucerop@amd.com>

Remove the redundant port lookup from cxl_rcrb_get_comp_regs() and use the
dport parameter directly. The caller has already validated the port is
non-NULL before invoking this function.

Signed-off-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Alejandro Lucero <alucerop@amd.com>
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

