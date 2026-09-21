Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012049.outbound.protection.outlook.com [40.107.209.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA964EF13E;
	Mon, 21 Sep 2026 17:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790013363; cv=fail; b=mrg0yKk9gqCMXlX3lZa8t0uehBq5AjBHl2fjciRQl8BCRXRVXVZfUmzLqlZKqiTN+naUdP3F3VBXA9TJGEKB8j266aEOnVoHDB4xaA+82PRo0cTo7u1ywtBYNrOmuMnQoF7jJfpJiTRErmBurd8rlu8zWV6endvngnNY7hzF0Zk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790013363; c=relaxed/simple;
	bh=yL3lGG69ATZ65x06DPre0eXcrza5WqOIbDAAvGJ7+Y0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pkDKq4tiWQ9Em7Db556FYXQW5RRuY5qkUMXqqNHNkHYtSfeX0Ofxd/TnMbaAl9VrtsyzSVFJK/jlRLbnaYBANNF3B4ZHiagjjcnlLnwfad1Yv0T80cNVx35/Ob3MeV7dv0SLfK214yTVYStbEibMpzgPnquhmne/KQu8x0lZdDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Hd5xUrOa; arc=fail smtp.client-ip=40.107.209.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Hd5xUrOa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j8afx4XwBinZqLpeCSovitFS8s1j6YFFImigst7rJpwCvuIwgtFDVfO3AG+oCSu/EDeB9pD1WKyinXAbwZTO7k72uT2rmiC8jOVJLuGO05GcwMXbeDaTxn+J59itu4wYUqd7sIgC1e4yr694QIrz5bxlDDGVSXMu7AbTLyJ6q91b/AhrQGOD/oVQ6/4LabdPllfyGrZeIo4zOTshRJnUDFxA26tGpUqDuuQSGjEt46WEJtKBLXBSPeIFUB4lIOqGAHcyqiGFWQ96+P3aBZbBenw3tfuOZPO+0hOhOXuiFghkydRkRNqH+SKrFibHzWknn0V0YNgWITKQTx9Io2Ci5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PLXlopIxtb/CKNXI1V/YgWlpwBtz/BeXydXMEBnngQk=;
 b=IVoGQlG0ePyLyCDauQ4w6HtQrCZuMSoOz38xd3GpejyNuPBSkEJTLmfUFJAu1xc0kwfZvSBp0mUMc7ikhy81pO3pqZhokAO9yY7CfMEJASq7HfTIxVXiGhkbGKOebkHkzQ0blaD9PWOalE82jikN0Ic52kHU1D0e2+sVsc5YfM1tb2TML3iBcWuIO7xCoDVQqOYDl00H1liwKRQsupvVsXkOV3aZbgEJWaOxRcgtvbzV2IpakDXzJbWCBINFqO/6dGYI0UO3th4C8ipbBwo0DbHyJIuzJTMNo0EMDJHoL3BStTMPy0/5BztdYdstDxQxoeap98GugXsvvrS7wNLbmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PLXlopIxtb/CKNXI1V/YgWlpwBtz/BeXydXMEBnngQk=;
 b=Hd5xUrOaSg7C+Lt8Gas9EnBIYeIPithb9xbnTen6f8isYqu8mb8z5csK1NkkY0h7g1ln0ztB0IDHos7hYKREBfs0lvH3vMDzNqnr1Y3qB84d4PqQ4DzSy0Xho+Yr0GrEV4F8aGu5S9vgB9rFebBZ5Unrhg/CGxg98hFx31Xb7+k=
Received: from BL1PR13CA0411.namprd13.prod.outlook.com (2603:10b6:208:2c2::26)
 by IA1PR12MB8518.namprd12.prod.outlook.com (2603:10b6:208:447::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 17:55:53 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:208:2c2:cafe::19) by BL1PR13CA0411.outlook.office365.com
 (2603:10b6:208:2c2::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.8 via Frontend Transport; Mon, 21
 Sep 2026 17:55:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 17:55:51 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 12:55:51 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 12:55:50 -0500
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 21 Sep 2026 12:55:49 -0500
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <ecree.xilinx@gmail.com>, <icheng@nvidia.com>,
	<rafael@kernel.org>, Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v1 0/4] Type2 multipf support
Date: Mon, 21 Sep 2026 20:12:35 +0100
Message-ID: <20260921191239.4249-1-alucerop@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|IA1PR12MB8518:EE_
X-MS-Office365-Filtering-Correlation-Id: 4089b6f1-a737-429d-c6a0-08df18099331
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|23010399003|5023799004|6133799003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	BmjO7C5BUS+P7iQtsICPa7ypPLdYsrKufEP1GiVQNQqktBNL+mKTD6UgFgtbZEjF/SCn9T0wAG0JLqyOD/LoHiJT0376BwLBTK/CbBq4xOAEx+/ZlNpYbOacAD/uNU4PRt/VcEYSDJUXW3RDo02hi9TCi3Z5ce7ztvvYkf2LV/8M1HNcE1leeBwVnUNlx8cwxdzs69lF6HkhAyScfBPNwPFHasOgBpjA6c2FtzhtEoXDa5cTz+qT8823olApDV/OTr9WXEZTX8FCcisFfZ8zpMsMDyoOLR4m0JeWjz2bEmPbfBbDUVEgJuodNykDdqBqMmRti20Hb4nDLUUwvAuuvtF8qWIyMtE8/Rlbn33YymQ8g7HUIkpTW2fZMMaEGullXEAE4Mi/IDeMBZa2JUXHYLswZ4kvJ74+LVjU7JaVHZyn+0IyeyCrBepVoFDTs9H8hXaPw7nHz9uK1MQMgNR0jip97i6NHBvaqi5uWO7DZa6LYStQ6Q2mDkDjV8Ga7yPOiAM/7EWkEtjKEM9Ydd2CaGpfIukIctCt3y8MNqHbehLgIdb85aVHnvVOsaCxPv6nouH77FFKd6Ts/dA1pkIUrSCq7kfp/B/3FH4EhY/u37wSIpHi6M4MLNbS4MrA9m5aGr8LIIApvCUt0tJsxKC+s/jyIZhRb2tSO8ABN6C/+/GSpV66k4r52Z3Xi6woQFQmKO/WOdfYc3ZOJMJt8n3qoQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(23010399003)(5023799004)(6133799003)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bLFuqNy672KbEWy11ZNNUBPvnPHyAEJceZKt5ERcgGcYiIJUTUR3IOdyZ5S+gI0Z0KlT7FajgaQLeZOiQbOe8KAS34LzGClsfElnt4TUg2fNKNvbMF4xtwcJCE53IUDyPnVGNJV3cvMVXxroZZLl4y7JmM7RgcgHFqT98VhRyLWjrvA2NtwpG2+82Xtr2lMZXqqLHjQr2fIIV8u5AJXN/WK3igNpl+rctleRoy1q4hQe0AJTzIUcuxg/5K777Mu2tPJfKzJr4dZpyhuUzKtBAlqmevt1QBC37y8ng96TdaXpHj/KDAFAi+/3hRSWe74cVZDJ7v68BORxNXN+eMj+xfKuI4EXGM5cqnN77vlp6zJY2p7LgCTR3TAkH6DDn2Dovyquo+6dHyHFDlY0316S9xfa6UTNAwzQSoWvKM1KIrkN0No4kwFArPTqWIM3EVXI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 17:55:51.2764
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4089b6f1-a737-429d-c6a0-08df18099331
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8518

From: Alejandro Lucero <alucerop@amd.com>

A PCI device can present multiple Physical Functions(PFs) but the CXL
specs restrict to the first one, PF0, the discovery and management of
CXL capabilities accessed through a PF0 BAR. Other non-PF0 PFs need to
obtain the CXL.mem range to work with somehow.

This patchset adds support for getting the CXL HPA range other non-PF0s
can use based on what PF0 did initialize. This implies CXL for those PFs
can only be used if PF0 is bound and successfully initialised CXL. This
needs to cover the potential race between PFs probing where non-PF0s
will be deferred if the expected CXL is not ready yet. Moreover, those
PFs can not keep using such CXL memory if PF0 is unbound what can
happen in different scenarios.

This first version after the RFC uses device links as proposed by
Richard Cheng which simplifies the support avoiding specific handling of
CXL memdev siblings as the RFC did. Using device links needs a change to
this core kernel functionality for allowing suppliers without power
management initialised covered in patch 1. The second patch adds a new
field to cxl_attach_region struct for facilitating the device link using
the cxl region device where the Type2 memdev is attached to.

As stated with the RFC:

the final Type2 basic support was possible once Dan Williams and
I reached an agreement on how to solve the potential unwinding spenarios
linked to a cxl memdev object. The actions triggering this unwinding are:

 - User space unbinding the cxl mem device from the cxl mem driver.
 - User space removing cxl_acpi module.
 - User space unbinding Type2/accelerator pci device from its driver.
 - User space removing Type2/accelerator driver.

The last two trigger the unwinding from the Type2/accelerator driver
exit path, while the first two start the unwinding which in turn invoke
the Type2 driver release from its pci device.

In any case, the decission was to release the Type2 driver always
instead of a degraded functionality if CXL.mem is only part of the full
functionality. This needs to be extended to other non-PF0 PFs, so all
the scenarios listed above ending up releasing those other PFs as well
from their drivers.

I have tested this patchset  with real hardware advertising two PFs and
under all the scenarios listed, but stressing this requires another
framework, likely under qemu or adding a new cxl test set.

The base is vanilla 7.3-rc4.

Alejandro Lucero (4):
  driver core: Rely on supplier driver binding at link creation
  cxl/region: Add region reference in memdev attach
  cxl/memdev: Add support for multi PF devices
  sfc: add multipf support

 drivers/base/core.c                | 27 +++++++----
 drivers/cxl/core/memdev.c          | 66 ++++++++++++++++++++++++++
 drivers/cxl/core/region.c          |  1 +
 drivers/cxl/cxlmem.h               |  2 +
 drivers/net/ethernet/sfc/efx_cxl.c | 75 ++++++++++++++++++++++++++----
 include/cxl/cxl.h                  |  1 +
 6 files changed, 155 insertions(+), 17 deletions(-)


base-commit: 93f51579e7df248780214094418f205253383cc5
-- 
2.34.1

