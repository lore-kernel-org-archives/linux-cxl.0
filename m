Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010062.outbound.protection.outlook.com [52.101.46.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A36747DD6E
	for <linux-cxl@vger.kernel.org>; Sat, 28 Feb 2026 17:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300176; cv=fail; b=ZGkNiOzVvvQE3Q+28mVm8ifTOJweqjRlL2qJaXOLE5PQa140FRhQiReTv8wImLnECLJNPszKaqCPkJpA+y8dVNhYwOlMDvNR+bqcQmHWZldmn49V87sQmz5/BcH8fiWYR7c+reHpA8lgPvuhe8aBK3HCAeXhrrvsquA00MaDR/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300176; c=relaxed/simple;
	bh=SHPji2hzSOApmLocOVUkbqtSD0IrNT/8cxxrntvUoek=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rJGR2D7I7QTG7qOJ8VEJPOmAglosRwhvFaPPD4EaR2vHwMO5MWO3gl4RrJBvmX7H8/GXw8kXSicSE5FQC4CqpvLsMUnwaBXJHNBuznrf9C20KpzZjplgfxcVa3tR3nAnyXZdsNXgA3HLfWpTfkb8cnNC81CYuaMb7qFFdKStwSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wAezIciA; arc=fail smtp.client-ip=52.101.46.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wAezIciA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SDaa0Xbzf8y1C4VjXgxkRZ9kazYQSkFOhmN3qSxM7F6QatbVQKTExudzVnUPaSYYC35r8ICYW8Bir7eCbG/nEitskOAcuryyQ5sTCKToDOCPeuJsKPk4grRS6o8ZFMGbl92lbC4Cck6+3oT/GGZKpf11e+zw0/yS9TZiMOEfPK36I6S9SchtrmC31BsbFWTN9I7SVOVFF/g6orwFvntWNM7QTbMDsmmCYhBf9je+KOwOadDkBWFbNI7wGdv2tMN2wUw2aQ14Vobz2CkOav9MxukHYiGUH4cGQhsYXCI0u/QdaG2sNm1zDxC7NzBhEfKm4LqNn5EFeTmOJvQSKCKRWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fRH/xqtVkSg3vRWq2ksuGmz0RwYZl8Ejh9JhgmA8x4U=;
 b=EgM4huGwwZ4mTItX7NTyREx2nZl3uva6Md3H86mHW1UCnfKtKyV3dLCFcRPH74ye2tRFCIxKOQTCRTyTKD4sr7tHMuFWRNs6ux9+Mm8hKPPh39knBjQRgwtyjMTud9OJIxps6vtSzWsd1KI2GwDxlOX5uVRsdPRiqwI7vtjPGyJWe/lMnfhydAnSP9q1xuKxIc63AoY9kTMlCVMNMJgQUwqWJ4K5rdlRSlSfVJYcv1ZIqvBX7ZUvh+OXx99Z+uDYNookEqcrUZVRBpSa4k6K4/ut9i9BIusbWnWNSeteRWgk/I/P6jWYypdjxG8kCd90ElFEVfDqE/G8xaEhFicYPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fRH/xqtVkSg3vRWq2ksuGmz0RwYZl8Ejh9JhgmA8x4U=;
 b=wAezIciAO0R38B0uHdJRS9xGmQz4C5LNf8IYcrWR6/M0RXZuExQKKVLCuOd96wJLXocJu+bLZp8a6p3DrrXf1+WrWSuQzvER8Z7Cf/kOGGfCH+q4DELGKtyw+sfWiQ4+7guGtNWrjnrEyRSn2a0FLxjNQj1FdGIxT7fYNwIGtOY=
Received: from BYAPR02CA0023.namprd02.prod.outlook.com (2603:10b6:a02:ee::36)
 by MN0PR12MB6149.namprd12.prod.outlook.com (2603:10b6:208:3c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.16; Sat, 28 Feb
 2026 17:36:11 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a02:ee:cafe::2c) by BYAPR02CA0023.outlook.office365.com
 (2603:10b6:a02:ee::36) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Sat,
 28 Feb 2026 17:36:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Sat, 28 Feb 2026 17:36:11 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 28 Feb
 2026 11:36:11 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Sat, 28 Feb 2026 11:36:10 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v3 0/3] cxl region changes for Type2 support
Date: Sat, 28 Feb 2026 17:36:00 +0000
Message-ID: <20260228173603.1125109-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|MN0PR12MB6149:EE_
X-MS-Office365-Filtering-Correlation-Id: 58fdec5e-ae9c-47aa-d21f-08de76efdd43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	62sRUovjoTe6ufTRqxhEO1HY8PKkLYD4JFdQZC2xLqph7NeU+kPGmY4d3aWnzAAD1QDOscS7r09vCXn+EDA7ZXn56RRriSKlRhgJqB2vZlTp5NNOHega36ba38ZMAfY7CjoCbwl9DaotgziY6wRBQBUlRyiKrQXv1Inj5co1dmlTciKWQZruJXXlbMJxh8pRe72XcKLzLWLiPEAt25cC+Z+E12xTlgA8WHzx5oOeorl+s8VZpSuIDFWMDTyGAheA2vzSjKsoZ9LO58ynBcO4DVkojr5o+e9ug6dvVXM+/hW6dU7vJJEjwcDtAFaIIBJe3BjF+Vz51EgaZJw8shyXxcpzpnv5CVUhJEQt6SM/0jTFYmI+qjNBst8/AN+2kAQiOhBZgE+4FB7ZeGxkU030tTIuGXOfWentg5PwTYv2xL4D9QgAPYRSHnvsDEzsETYM6tj4fMTwSyQKx3YSVNHZ0J+D89x8HBIj8DJBHnikeOFl97E3uSUBykfDKqdWMONn5fsQLBX/196dzq9HFYGAximeaKMC3o4ltKZqE+lO/AJJG3kigs1okCl3eJ17/gDcyhV8aLw5sQoSEKdolfe+Xem7KBDkE6xxcXoIi2W1PZx5RmvhBEElQEVwzlhkonr8nVeEVSbYfuDfotGeEMhDFP2zySozLDGCPbT0DUtbk+tWCXe1W5wnFzBVNkRDxJAN8mYKUH3QzVtJF4RjboUlJwoMQmrR70qc+YxnE4GSRBzj49Wk3hzXYMeMOz13gLuEkvp1X3cI7ghBaX2vAu6CwFzdsmHUChMqWrlKKt/xu/hG7ZROLWBqD66h3UwOP1H7qNRINjKMZRTgVuix7kWwHA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	W72pOQHk5PVvZkwINNd0jIkgaL++1GzpStcPp164hmz3E4Uyjeo3CHUmriLTq87VzN9czSM3B4P0aKfxQ7UT7qnhTz5FLvZQ3gdZpRbIYx7LMb4sVXDEM4aCyrz8j9FpC7KsBkDxQYP5jEH0/vQTFx2jjS1E3tIzfRgG68Ayg2rTT3dSbqRid0ThyKT1SJk2knSuaR015eTOhBI1ppLUcpAtQzsR4Jp7EUHvhaBifaENcp/DTgk1oexSMe9W0medL2acJJMbLJcqjUaM2UIi2ifIOIzm1VcS3dj6zt4GLpHDDXWCZEA3o+FZghjIF4i1Hft78r0YqS3tau72OIXjdEwhYq1ugQKHEFwc9UxYy56SyT+jB4xxjM8C5O3SMshJT0hDWoLR9QeuEmORWLb1aRjVtvnGmcIr3U+NM3B/s7Pxw1/q1m5w/VfNM9igiBVe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 17:36:11.3952
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58fdec5e-ae9c-47aa-d21f-08de76efdd43
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6149

From: Alejandro Lucero <alucerop@amd.com>

In preparation for Type2 devices/drivers support, these next patches
adapt the cxl region code for required Type2 functionality preserving
current functionality.

v3 changes:
	- fix type conversion in patch 2 (Allison)
	-fix commit (Jonathan)

v2 changes:
	- fix commit in patches 2 and 3 (Dave)

Alejandro Lucero (3):
  cxl: Make region type based on endpoint type
  cxl/region: Factor out interleave ways setup
  cxl/region: Factor out interleave granularity setup

 drivers/cxl/core/region.c | 87 +++++++++++++++++++++++++--------------
 1 file changed, 56 insertions(+), 31 deletions(-)


base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
-- 
2.34.1

