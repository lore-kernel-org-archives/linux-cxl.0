Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013043.outbound.protection.outlook.com [40.93.196.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF0130170F;
	Tue,  3 Feb 2026 17:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770140210; cv=fail; b=FkoDPnTh2egS+pntWj2eazc57HITvcFNBvWR3ytQE4l16O3r6Dq3zJnsoAfAnMjutihYHsC5+voNs/9GpGYYxg6uk9h0unkScZCCvddTWGonKE9UVrDjsfpj5zn091I8oFU0wtpVm7xaRdZhUvMHwC74oTY4g9XVQFmb2tawKqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770140210; c=relaxed/simple;
	bh=EXoq1pCZZcWxotObjEHKu5k7JWXYvLUaaXUaQ6hVjPU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Beu3vXnt9uw5/bojb2jcY7TTGnLPEUyCS7jTxbotmzaAkj/mtj1XZV0uguu52x2iwNId+cIIgZHCy3Q5b2KmMDA0R/jDmQKl/g2+RLnKlV5lNpntK8rASLGDm5s43+LhYMWZ1uJ+0o6/lOPIFWBjEByCie/xnAw4cWGwBcCFIqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fPtTByg3; arc=fail smtp.client-ip=40.93.196.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fPtTByg3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B9JONC1LxlrmKbxOrHTcXx5KFcUbghN9WtbWS9KILi52BWX8wkbE46KPxkqxpS5OU89H/xD8uNN5lvlBQWJuwAXPdVQFei/hOlnqOAULMu0WhtJ19dWJuEOwtAKSJNdPOOhlEHzuh+vjOMimQu94vkpBfbYPovzR9hpZF1IEpLK1yJ3EyCRBLCpeWdnGjz5Wd74UwWhfhKNafodLgWDYB7feX3MTCvbsyNGfGpCOCy9zxkZEoSSuQsiuFqEhRtj8Di+PJKlJw3izFi6P4f0qEH2iBYIAqmdvvN7C0B2XartHcDkJeHeeyrkprM9jyhEWUFjPqfWySq3yJq1K9kWXMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ukmOzyUhw/XsMnmsfpPf7iECdYA4K5dm1bO97Gk6Cw=;
 b=mPny4F6ZaY3Zkkps5CJPzI0aC28Jh7gjnUIadhQ3B7/GSNlg4SAxHL0Q54Rwl7CbonBU9aRiJzxMSowTEGIYVBKF2aQt8xJcPmARKx3d9wlnFHrCvI/oiM1G3mKP4iBfTDP6fuPQC9nqbXJ4nBwqdOswtvjTCi1O9vFpY5wDW8VOg3xZCOdhPEYlGcj6YwdovHk+lIVYA+U2njPnjzjWaYJMQCpcZjq10FtoggQaXDd4plVKHPW1aonumWyzy43Jiopp/L4jes4a/GXOYoJnE2vklkyYO5NBfezNDjnJIJH7lmJHtI+AuAwR2m0mLMF0d7CXIERjrKBZr6P0WmR1xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ukmOzyUhw/XsMnmsfpPf7iECdYA4K5dm1bO97Gk6Cw=;
 b=fPtTByg3kKZ4KQwicsoepSqvDaFovmM9ocveIgbvcJACN7K2pHRE05J8Hz1CWDoTLqSgPi6LK6vz76iiou4hbiiuMOgZqrB6SG4bx3ezClA1JC/+pNawfWxRQj6QUgCtt5ugUsQIHhd1S4AMh93UwFxUFf6iJzFooJ8m2DVvyOo=
Received: from CY8PR10CA0047.namprd10.prod.outlook.com (2603:10b6:930:4b::25)
 by DM4PR12MB7624.namprd12.prod.outlook.com (2603:10b6:8:107::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 17:36:44 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:930:4b:cafe::a0) by CY8PR10CA0047.outlook.office365.com
 (2603:10b6:930:4b::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 17:36:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 17:36:43 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 11:36:39 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Corbet <corbet@lwn.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>,
	<linux-doc@vger.kernel.org>
Subject: [PATCH v5 1/3] cxl, doc: Remove isonum.txt inclusion
Date: Tue, 3 Feb 2026 18:35:58 +0100
Message-ID: <20260203173604.1440334-1-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|DM4PR12MB7624:EE_
X-MS-Office365-Filtering-Correlation-Id: 03b775ff-e4cf-431e-2998-08de634acbf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Uzc2MHk2bkVNakl4cURoMlFMOHpyS3pFK0JEQysvUjlNVFkyUUlMT05VZGEw?=
 =?utf-8?B?dzVySDZwY0pHK005Zm1zMGJJN1R5ZGJ4MitRVzdJM2R4bGxBNkE2ZkdNTjBE?=
 =?utf-8?B?VXZQTEprNUU0bERvdHZQckNRUFFTeGtscWRyRnhUTkw3UWhiVXdkUVJUN2hB?=
 =?utf-8?B?bEVkN2dYZ3BQNzMxYTZrU2t6cU1zQzlwMk9ybG1iOXNrY0lRWlN4M3BUVzM2?=
 =?utf-8?B?KzY3VkxKdE1MbHBEdUw2UkNhNE8xbkgzMVlpTjVzck1sZTJkVEVwWTBXQXFL?=
 =?utf-8?B?N0hSSVI4WW9WbHhsUHE5ckJuUFQ5RzE4dU9vS1J2QVdZMTM0dENsVjhTa0Zs?=
 =?utf-8?B?RmxlS1lNVWNKdkwyY0tPRGc3c005UGJvMHdRMjNIS3Z6ck9MKzFpd2lOUTIr?=
 =?utf-8?B?Uk5PT21KSTliOWxuNktmQSthZU9HeFkyeUtMSzJadzdkR1RzcCtGZndXdUFa?=
 =?utf-8?B?QXMydVBtcVNtQmVKZzdReDFYb0xVTys5eXpQaFlFdzkvWEl5Wm0yNFlJd2tX?=
 =?utf-8?B?THRRVjFmdDhKVTRSc2RzNURMZ3NmMXRST3FzVjdsM3paN0tLQzg5NEhTR1hE?=
 =?utf-8?B?ak5uYmZlWlFuZzVkc01zeFJvWFlMKy9hOEwrVGtHamR0cmI3UHdHOThOOCtY?=
 =?utf-8?B?T1plc3k4SExTbzJZa1ZzM0lMYTBpOXpDcmNObE1sWTVhc2FickIrNTA0Skg1?=
 =?utf-8?B?SzA2ZUVnbG9RczRHU2lkcHFQSDR1Y2Y3d1J4a3NDNUc1T1pEY2MzR0V3UUdq?=
 =?utf-8?B?Q1RtMlFOU1F0T2o2bXV6V08raHlPanhubUNQWGczaDVDRW5yM0dsVGRTR0or?=
 =?utf-8?B?dEQ5OTZtcC9WQ3Q5allxbnJQaFdQWGw5ZTd1TEVjUExCbU9JSytldkdhc2g2?=
 =?utf-8?B?RXZ2U1BEVE9wb0ZxckFZb2NjY2JSK3NjRlQwb3RHMzFnbi9WZW04clJCTlhR?=
 =?utf-8?B?RHdsODFmcVFBU3FjUXRPTWxrSUxwUnFVdXZtTXBlaEFlWFBiaU1SbzVHMWFt?=
 =?utf-8?B?SE90MldCWGJsaGxCZG92NXBSOTErYWRqMzdxQjFoZlRlTWZ4VkI3RTNjSVJn?=
 =?utf-8?B?aTlJdkFKNm9nQlMxV1FJZm90b292OU8wT3Zrb3gvaFpGQjA4cy9UcVB0VFBU?=
 =?utf-8?B?K0VPTnhhUTNhSUp1VVBXTlg0azQ4ZFBrZ3dacjRMWkxJTG9wMktiRWg4dG9P?=
 =?utf-8?B?MzNVVWhpeGhONVRldjZIOEZjVkpiT2V0SWRMNnRKKzVtbjNNNXZ1N3NqdVRD?=
 =?utf-8?B?blZFNTFQRUJKdG9aZGtIMXFIdmFDS2U2ZTZGai9VakQ1eHFQNnN1TXZBTzVW?=
 =?utf-8?B?bWdqcU9XRmRrOXl4cE03REZHUUlKTTJHVGVDaExmTUdMK3hxbC9XbEMvWUk1?=
 =?utf-8?B?YmxCS3REWklybXNVNzJEUjhKcEpQT1NKWlVIK3FxQnJOcTNFZWtSUnJWVWFY?=
 =?utf-8?B?QlV4SjZKbm5KcDhjaWdkOUlmclFtcVFoK3Q3Z1NQT2oyZGQ3UndvbVoxYWdi?=
 =?utf-8?B?eS92OGtyT0FtdFJmWXZ6R25KVTdPMjRtc1Y4WStUVldOM1NOMm41a1ZtV2lX?=
 =?utf-8?B?MXJoc1hDcTkvNUdsNEdqcUFvU1NhcDdtTjIrWmcxWm9WbnlSNDh0aVNob0Mz?=
 =?utf-8?B?dURzSi8xMzRtZXp5UUZXU0RUWTc2M2dnSExQcXZRYTZnVTVWTFJwV3psSlFv?=
 =?utf-8?B?b0g3UGRRaHdUenBOR2xNeWpJQVVkYTJxdldvMS85dUhEMmNNOTRDUXRFL1o1?=
 =?utf-8?B?aFBXRmY0dUowYzRaRm9TK1dYSWYzRm9XamR2ZjMyZkRJQTd4TUZZM2ZqL0tj?=
 =?utf-8?B?U0Y5b05TWkVEdm84NjJpWUlkZFJiRktUTVkweDNSQWxjNEp0eDBZeE1mRkZZ?=
 =?utf-8?B?MGxtZGM0RUNwYXR3RVlqYUhUZjBOQmFlV3ZFc1orblNwV3Rjei9wd2xYdUdD?=
 =?utf-8?B?T2ltZFhtNXVFMFpvL3p4OGEydG1JdkkrVDV2SjFzZTR1c0lzYm5aL1k1LzFF?=
 =?utf-8?B?STE1ODZnOVBacFZGa1pDUXVSa2dJZFhQWXc5bStCay9sc1lycmR2czRjTUh1?=
 =?utf-8?B?L1VnZUFwVWhhY1FHc29iSk1CTnlqdGNnZHlDQUpoNzFrdlg1UUxNclByK1Zy?=
 =?utf-8?B?bTB3S0Z2b0J3NllzVm9GaDV2d1M1cGZUdjI3VHY3NkpLTjhTTlM5OTdxTVRS?=
 =?utf-8?B?Z1JLRFY3b1gxK1BweGEvbUlvVW90ZGxnT2VUMm5UTTdFQmszRUFNRkM1QW1K?=
 =?utf-8?B?Sy8xYkZLZU1kMHcvNkc3M1FXVTVRPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tlyJvaSWWDQMiT+URU5nZuYmV2hN3KpLNBLxuy4s7FPx9ataGFGu4nkcJOMkD2MzcZxEA0ACeMIpUQwvDHFc64bNBXIDSt6MhiMVCGNDLstnS1ayY7DDjQZPBO0D9n6Vd34zp2HRpJvqmTSJ8snaRNqoThlGxvS293XJF1FAdCu1rxW9bXyAFCRH5ulXKTjTHivTVXAoDZ9XCEY+O0szWZYDj6iGKy32JYrYNolAKyDvBwIKiMtiJm0lrZy9Ol9pP6bB9LMTWY1KBoGnL7fyXTZ0zICoPhb5mUHtWjshSYct4Pc+fEt7qUynVHSsKq4w44h2WirGa3YFbE+/smiAwJYyeDEDw0ZPpnoyJKdZUKt69kv9XcMQhW/CbIhblKAoIabdWpqqq6TkiLIYzu3Z6ZUAHdeJBS15zC0he+DCJPlEoCI3rhJiUfA6r17euB4U
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 17:36:43.2680
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b775ff-e4cf-431e-2998-08de634acbf2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7624

This patch removes the line to include:: <isonum.txt>. From Jon:

"This include has been cargo-culted around the docs...the only real
use of it is to write |copy| rather than ©, but these docs don't even
do that. It can be taken out."

Cc: Jonathan Corbet <corbet@lwn.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
v4:
 * updated sob-chain,
v3:
 * Separated change into this new patch (Jonathan Cameron).
v2:
 * Removed include:: <isonum.txt> line as part of file separation in
   another patch (Jonathan Corbet)
---
 Documentation/driver-api/cxl/conventions.rst | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/driver-api/cxl/conventions.rst b/Documentation/driver-api/cxl/conventions.rst
index e37336d7b116..ed4237583d36 100644
--- a/Documentation/driver-api/cxl/conventions.rst
+++ b/Documentation/driver-api/cxl/conventions.rst
@@ -1,5 +1,4 @@
 .. SPDX-License-Identifier: GPL-2.0
-.. include:: <isonum.txt>
 
 =======================================
 Compute Express Link: Linux Conventions

base-commit: 075beffc378e799a0c7ec7332213bfffd9a16aea
-- 
2.47.3

