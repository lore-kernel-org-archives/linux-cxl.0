Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104A01E570E
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 20:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740081656; cv=fail; b=TfxsvnD4CbxfzgZ2AmZ9WjMVQ3mb3PyRiHcNe5s7CGE42EF5EAGpk6trAnbKN72I+FvaGElHcGvmoqYPO91SNvaAgs+O7/0x9kHnID31JHzLC5q3nGBXLLUh9X02SJSlKlj95Qr8XZkmgfvwpONoYzCqwKlZG5Fm5xngH1MOKk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740081656; c=relaxed/simple;
	bh=1SIbeoiK3F6OT9Qsl2isOb4hB+qmtCjhVTJLgwKEoIk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZA7twlY34GxjlaqUxIst5P96Eeim0e7QFXCdij+FW4cOCT+oss2COt1RA/xRYki235dRyhjfdxACU/+xNAYgK598wy1cgWjv9Fqc5/B9WQf+j35bDuCsOxHZ2+2E8IwyCEJ22h9EKoPBfdnP2CCVg5O8WeYLnWS6Mt8492zGGq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YLSFXkAb; arc=fail smtp.client-ip=40.107.94.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YLSFXkAb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UlhiX3HbPkKlkMrYxwjSB0HhtT4PP1GMTzuSAo6wW7kfryhfGgW3CuOoEzJEOLSxz4o5hdjapIaOUpPLAw3lqRH0i8AUU1bRFS9rBQQQehD3IK+bShXuWAoKzJ0PGlCBXDCw3JtOrbCNUc7BCWzbtLXkGh9lv4DIrL6ccQ44WWt1/w2PmCsS7pAKjxmch6R7HUw0+yVd+FgrMdDKVmZztqJEtcXJ4+E68L+MwCvmFN20kUtxC8ed/ZDSwBw2mhxEvaIYs7I2seZLHP3gcnrn9N5VQRGRvMI82NNd5giMt4PzkvFgOUVUfRCromFtrcgVPPBmdYJz6+W0uR7cH89DNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JrqCwE3RItUVk92GB7ltvUkPVGfC4NVJgd2oPVRuPIY=;
 b=LvyA6hRHEf9/9kLTiu3NhgzOSM60kCOsAPT78wyQNp4woclm0Tpz8UmRGHsSo2BDLGv9ID1Nvnc0ONqVuvJu+L7rKrBdtoX0YxnpJd7BAr0yX8gJf4v12hT472NRHDcOOjfNcCXp3/fT8zp2ekg6PliIlWdPaHCClqgblLVeMH8Pj6oW2wFv7vQs7mCeSmrmXrvFSvmjtwemPVl0Jireto0Ltlk7g+J8GX3cNTmSePwfiCu1MVk8jB+V5PNP2CaTpFFjZT2dPNfrZD9fxCdIDURLHaJCCE0RtCq71FQ4MyeJDNpbe00Rd50jEHEo9BdYs2NK+Co70RriI0SIgifzAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrqCwE3RItUVk92GB7ltvUkPVGfC4NVJgd2oPVRuPIY=;
 b=YLSFXkAbtvNLJa0WjHthmmyJmrXppC1R93GSfzU+47BU/cccYzQxxjQSQfYTxRuEESFSRFuBP7QsSEt0Oan5JHpIZjju2L+fxnkiB07ZEsHEp0VQ1AlIgKXOpxgBcwmU9WjR3ARYvRZ+CeExK/H8hJVn0F3TGF9oO3Jh6Wn99Vo=
Received: from CH0PR03CA0009.namprd03.prod.outlook.com (2603:10b6:610:b0::14)
 by BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 20:00:51 +0000
Received: from CH2PEPF00000140.namprd02.prod.outlook.com
 (2603:10b6:610:b0:cafe::58) by CH0PR03CA0009.outlook.office365.com
 (2603:10b6:610:b0::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Thu,
 20 Feb 2025 20:00:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000140.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 20:00:51 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 14:00:50 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Feb
 2025 14:00:50 -0600
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 20 Feb 2025 14:00:49 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [RFC 0/2] type2 cxl initialization
Date: Thu, 20 Feb 2025 20:00:39 +0000
Message-ID: <20250220200041.3891165-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000140:EE_|BL1PR12MB5849:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c2be9f3-b38f-462c-241c-08dd51e946b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PnKoZg2FjYhtPToDn1RU5Nuikv8fOpsOM/a4eyUS78WzHxe8+XpwvtFiHIsB?=
 =?us-ascii?Q?WkzJk5zVVhARMv6UySWDh8c9s/1WXkcD4uPnEsaDZDOVARAosO1jy6Y3hnx0?=
 =?us-ascii?Q?ov4dUQJJsR7SmgOOdautCRn70soPrOJarG6Yh15LJnyYUAReFAubwAcVWyi7?=
 =?us-ascii?Q?mSIEwn5XiP0RRjXpEpMaKOgokXCLqCSWIsu4b6uaPmIJ8n0mXNpu6lHB+Mab?=
 =?us-ascii?Q?sElZKzFvuaySWwcauSh6cDhX7YmiUqUpF3wXzDf6tFdsac2ZesT/qyuyi2WW?=
 =?us-ascii?Q?She55fBDVN2nXSWkeq83B/MozrIyTtbJTIfxQloIh4be8pqUK7CNBRIMmHcP?=
 =?us-ascii?Q?dbLOygIlgPkeb8zGADLvivAYxp7QIxTzitnmF5qjZ8Y7wZiTPSfgFEDJpKjR?=
 =?us-ascii?Q?8c+8ICwPvCCvHhdbVGKpJxCdNkRyUYrhXC84LXBzlRBYkuBOTJFZ9o7VgXrk?=
 =?us-ascii?Q?YThImSjjx4dnNhjqMunRu94Nxf6hUE5N5QUpnLSU5OIQAUNakplcyV2o8fsy?=
 =?us-ascii?Q?Yf8QvAnZ1Rc0I9geVHdMRLyz5ipEbWzJRlHTIyqrB0T17oaSFoaKqeKBbbxk?=
 =?us-ascii?Q?XgSqHFZYaWdum8aK55TqQ/+I6J/5Agjptxo1/UssMKaMaRCcMENQ3cMo8sZw?=
 =?us-ascii?Q?Q05ehhXbYlkWhaKb0hGozmLYHRi8oxVu93qqcTa10+HM40G8+/vYVmxD+ROJ?=
 =?us-ascii?Q?b/Z8zBukiK0PJ8mXyjGEUpAgRTp7ERqvQECLKWkI7O4rvxL1JVeXoyNBHzBa?=
 =?us-ascii?Q?/nb+z1ARmU2o1cgdZ3IVwr7N/jSAwXpE10qdvgDM7cUIbybuZRZrcPq0qNW2?=
 =?us-ascii?Q?vI+FKe1pRSNxgE/vqc7DvdSexWAqKPBIDtuzrSqwkl7Hk6w1ij/PKeGJm9Ml?=
 =?us-ascii?Q?qsFUI6Divuglkti4gHRehB4UEtmUw/Lsc4d/oOlRE+tkoYgSDy2MMMhaEjZT?=
 =?us-ascii?Q?PS7GsmZbR/CT7Y8dy7NicpmsCk+nmY9u5SZxSCLOnfi3Y0QnJpBCrvD82f1k?=
 =?us-ascii?Q?T0gcMCVcm9UDOuqe6p9G2sFhVutpa/vtMRII0SA8I4RZ7M+eOpgLz6KMq723?=
 =?us-ascii?Q?Z7qlxIB+O3QkeSEmsa7SXOkK7xlLRV/YGhupTU8FJ/WGWwOnijKyBV8erGla?=
 =?us-ascii?Q?Qt3X0+y6Fe9zmgqhTSfN9zP6T7YAGb0O+xozE6NOcNKAi4Es5Ceuumgmhdlh?=
 =?us-ascii?Q?dShfj4fQdOPLCRyOrucrqAyM0A9lqyplXnt/UzKe1wfUeNzyrDBorvW0xtt7?=
 =?us-ascii?Q?lRdHFPIcAtqgxmzuRin0LY2ZVH2ER5ke+FMgYGUyQDwSuaxAzG98K65LKKlj?=
 =?us-ascii?Q?fv69fQP4OfHdQ49++ZhOQQ5SKjpyhhvFFjqikCxlzG06/Aa3cKu9warHtWgK?=
 =?us-ascii?Q?rpTLRFLqNEs7scD0qrKdzFFFDhZoMaCI8crb4NpviiF4BSsOcRZfRRXw6XQN?=
 =?us-ascii?Q?mBzp25MyyWeVaNorxfmuiOGa5OiYlDB073iB+iVEjKwscuGStBV+T136F1A1?=
 =?us-ascii?Q?oxIhEs2ibIT4Efo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 20:00:51.1097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c2be9f3-b38f-462c-241c-08dd51e946b1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000140.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5849

From: Alejandro Lucero <alucerop@amd.com>

Avoiding to send the full type2 support patchset until there is an
agreement about how to do the cxl initialization from accel drivers.

Using the idea from fwctl for embedding cxl_dev_state in a private
accel driver struct and a macro helping for the allocation and
initialization of such struct.

The main problem is the amount of internal cxl structs which need to be
public for accel drivers which we tried to avoid since v1 of the type2
patchset history.

Alejandro Lucero (2):
  cxl: add type2 device basic support
  sfc: add cxl support

 drivers/cxl/core/mbox.c               |   3 +-
 drivers/cxl/core/memdev.c             |  25 +++
 drivers/cxl/core/pci.c                |   1 +
 drivers/cxl/core/regs.c               |   1 +
 drivers/cxl/cxl.h                     |  98 +----------
 drivers/cxl/cxlmem.h                  | 108 +------------
 drivers/cxl/cxlpci.h                  |  21 ---
 drivers/cxl/pci.c                     |  17 +-
 drivers/net/ethernet/sfc/Kconfig      |   6 +
 drivers/net/ethernet/sfc/Makefile     |   1 +
 drivers/net/ethernet/sfc/efx.c        |  15 +-
 drivers/net/ethernet/sfc/efx_cxl.c    |  53 ++++++
 drivers/net/ethernet/sfc/efx_cxl.h    |  40 +++++
 drivers/net/ethernet/sfc/net_driver.h |  10 ++
 include/cxl/cxl.h                     | 225 ++++++++++++++++++++++++++
 include/cxl/pci.h                     |  23 +++
 16 files changed, 417 insertions(+), 230 deletions(-)
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
 create mode 100644 include/cxl/cxl.h
 create mode 100644 include/cxl/pci.h


base-commit: d5d2106e2118c4e09fef131d9889f79559b95bfc
-- 
2.34.1

