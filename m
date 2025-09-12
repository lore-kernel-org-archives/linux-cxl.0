Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2052.outbound.protection.outlook.com [40.107.237.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB1231A06A;
	Fri, 12 Sep 2025 14:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757688386; cv=fail; b=CWmARNQrSDbMh0EBRe+z51TuE6DvmfsoV6AlFBy6gDEpW1U0JOSaf5FhocT9c9gqw2ANg474Npztu/g6B4g44ZWtmWtrSnxlCgdJ2tZTo8IQeGwBK6biYjYdRh8isLAPeCz5cncAadHQsAnPJbzsWUCL+CwAFEPkscbdfugbTd4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757688386; c=relaxed/simple;
	bh=emaafFtaqkhaZuHStihWgn2sdkx7SomK4VFHyxJMkJI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BVtoAzI8tvy7XxCv8k3pDNobHoqSQ9OV7LCvLNc13Yg1Y8C1mabdFoNg+jhNfnliIxKruZoI8mCtIhrEi0bM/TxPTY9qTkbenWnfJVRTVZ1OMKjw6Xnx9oT6mDF+T6ryaLqaa73hr7LLavvEjIsSKSxD0UPVuYH9AknvlHN8tUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=qlLDSlOY; arc=fail smtp.client-ip=40.107.237.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qlLDSlOY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yjeq4DWtxpUi4Mu1klNAL9ovsDi1ODYD6BlbEpAod4SexMgAfJ0nv0O7mt1zmHHBG2zd46grn7WmXyLFYqkXv6oNcpmZZL1dr6jU28EwCi42vMWe6LkvcLsIhz/g92dw9eguudogBoeO9biZFebebTIXhZPBqA+5XT/ScZqmk3Bg5R8ynCRG+p7WZ/sks9JvMjmELgRkU8AYj2DEC8sf6aZx+wBA7r5SmvO9jI0GjqoSnMHMqI24B4DVfpFAoHIwrbVfVcBucQ/fHptnBXCI6Rfa5acvu14YllJZEH+sv7CA2H6yDUmnqpNh0C7ceECiBej4TMc9olpKbLR9+D+PEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dFcryGL6IBiY/Zf08tsks9V1ovHywZ65+kQyq+hwPvE=;
 b=sBz+nzZPRl5E9mmMmHs3mMvo/WFKJTVP2uv9EF7LBDGLpNTbxtvcrYmOOwxl8qwUJMusLdmPB1SRK6nVUi+dKVqFzomEg0EjmaSlZjiS9RGue3fOKZVQCDz/U6pEnoB3BBpaim+vxOzEr71Xut+G7bQ9gepH9MROZYYeiJgXqt6s1NFT1DXpV2dGg5D4ONMSFEKy5bUckkap+w+JNzHrU7yLe3D0L/nmpEvUREwVxS3wkFEWanvEgRa45eA4Zl2h4L28MWdisCJleP7yIlMY4AnXP7o6HW+xzgxCGSAWafZNPeLHaHfBdv3bBwltKY498HpMbogFW3FCuBnKtB9npg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dFcryGL6IBiY/Zf08tsks9V1ovHywZ65+kQyq+hwPvE=;
 b=qlLDSlOYIJQpxm/YP1/bYw/rFhXk2k1+tLzI+KhyzLgGBmwCrVu1AldUSrm7pzu3MFjKWKsKanF/1FEgkRIwYWeXdiXT0kgVyGnIn3GkW5iovsEi9g594FZBxxXdlw1ZLC+Tpn3VHJ8Nn7lTrLehIP11bzgHFiHSOAoJGI0grTE=
Received: from DS7PR03CA0053.namprd03.prod.outlook.com (2603:10b6:5:3b5::28)
 by DM6PR12MB4451.namprd12.prod.outlook.com (2603:10b6:5:2ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 14:46:14 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:5:3b5:cafe::42) by DS7PR03CA0053.outlook.office365.com
 (2603:10b6:5:3b5::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Fri,
 12 Sep 2025 14:46:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 14:46:14 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 07:46:05 -0700
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Joshua Hahn <joshua.hahnjy@gmail.com>, Robert Richter <rrichter@amd.com>
Subject: [PATCH v3 09/11] cxl/region: Lock decoders that need address translation
Date: Fri, 12 Sep 2025 16:45:11 +0200
Message-ID: <20250912144514.526441-10-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250912144514.526441-1-rrichter@amd.com>
References: <20250912144514.526441-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|DM6PR12MB4451:EE_
X-MS-Office365-Filtering-Correlation-Id: adc6e995-1ea5-4045-9aa3-08ddf20b1f7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c5eR1w1Js3PiGnbCg9i7c2ScQfureja1qNUSZorEt1ZW8e1N0iy/9twI69hV?=
 =?us-ascii?Q?PpIjOJ8uUt27/iU4akt823sQoTFR6DlwvmDREnty1jp/LGV2jW0CWXJ4m4rR?=
 =?us-ascii?Q?Sc/7r8peXyrPVaTpKlVt3l9XDfSIqN2vIuuluY7WDovb3YxdxUNak7DPIOkq?=
 =?us-ascii?Q?Qm9HGHNQprn9plXAVM+/QI0+Itx1S9UZu5Ujq5H+uoDruZt9OoSoR+vgjHG5?=
 =?us-ascii?Q?HMo8ISQbfServPgK790st3YdqEksrxrVfwJk+R3eVmsVsnzmzW00vQ8HVO3A?=
 =?us-ascii?Q?1FT4HjsGKvXxuuR+3L/264L5NHmlc0oF7LoV/giH/5PT7NkKMYRXk48sP4IN?=
 =?us-ascii?Q?fBVLx/MbZGzQst3hqWAPkWHJdTe6+NR+TjW6LQxwN8x1w28V+FBeNsy1+N/w?=
 =?us-ascii?Q?NlFI0i5d4vMZgDDQ8Zd31gMof+R3adeGdLsnLuHYsgVs5scN0w2zUxq3wQ9K?=
 =?us-ascii?Q?BrmAjQK7hDWhvHktSqGY0w1M7bpfZt4LT4XUGtV34J196BM9811zhCblhUzy?=
 =?us-ascii?Q?L9lyxTjLWiTbCwv7W1fO0RrRShLV8nwOrv4XvBSYggvZ3ZGHpD+1kVKQCS/e?=
 =?us-ascii?Q?cUKRVLcLjmGviULNXZd2XlOog8Rg3nDLJoiP7Tc701OZ7kKU+VNNGRS3FxuB?=
 =?us-ascii?Q?MDAFdEMJFzI/e/mNSoByer/qu7+PY0jFU5j0TEhmD1UTY5odEDF2JXUd+cqr?=
 =?us-ascii?Q?smbZZJvZ2/jlAKRx/nesGwEGYcy0Tep4gvHrjfeNU1/BxAKYAmSxFBmNiR2v?=
 =?us-ascii?Q?FYaaJnC/46sCjj5GvlymJYc9W09UZj6Xne856lrRBU46FaND2ihSyHpKKhmu?=
 =?us-ascii?Q?HfqWYb7OaUXZ4Q8sG3d2+P4+mKLBMO6MnXjGpq2vK/u1rskQRbNDGFV+RSZz?=
 =?us-ascii?Q?WsG8Qm2Ci8G7XIQDz8RY1HC0Pt2HjJGAergRY1xs/r4TDQI4Abz9oOoEmZBc?=
 =?us-ascii?Q?y/U5q8RwZJ77nxV5s/U3+O92fKagnx6W5uGGx3q7c2/7Cdxf6aPQUheCSMIM?=
 =?us-ascii?Q?xz7uekUjBjRiMQurXK2MbIoK7YzmXHaUpCV2/20a8tmMBMQDguk4kXQ600Et?=
 =?us-ascii?Q?Lm/cU88LoaBBOCJ+gQ5aL/Io+nKZvCC0AgzUqhMgEOHtB791QyzBg+XE7HVX?=
 =?us-ascii?Q?If84Yhsh5W7huESS2wnKp9HI2dHZivi/N3Bia5QsRXBsdOJrqAqETfeQnZr8?=
 =?us-ascii?Q?HP0jbfqrQ++U4wt0YIxi/+M3OAcpog2RtBCVSCIcqWkimhPxsaUsHaKWrIqX?=
 =?us-ascii?Q?FauWhDX4WPmNbvEVKvmjL19vDfu2BnlShURIB+KpCS9E648f71UbVabZ46CD?=
 =?us-ascii?Q?mhhb/ZQCYlvZn9M7Ho5fTzVHw+aoZ3wyiYkruM967XTJpcwZ2O/wbSWf8pQS?=
 =?us-ascii?Q?cV6JphXHqAe1hw+y44AftwPAwBrNdgeNy+rP2+PVhmYl1LejdMN/SJapHmgd?=
 =?us-ascii?Q?XBqFwXJacKRxByRlXMbhizkYmL2lzQhOoaNZpqoUq05mWJbHe7KUa/G4NwYB?=
 =?us-ascii?Q?B7imShazSM2ufu85CUhD0F+1nVq7XZi0FrOc?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 14:46:14.2687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adc6e995-1ea5-4045-9aa3-08ddf20b1f7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4451

There is only support to translate addresses from an endpoint to its
parent port, but not in the opposite direction from the parent to the
endpoint. Thus, the endpoint address range cannot be determined and
setup manually for a given SPA range of a region. If the parent
implements the ->to_hpa() callback, address translation is
needed. Then, forbid reprogramming of the decoders and lock them.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 9fb1e9508213..44ea59252ff0 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3497,6 +3497,16 @@ static int setup_address_translation(struct cxl_endpoint_decoder *cxled,
 		return -ENXIO;
 	}
 
+	/*
+	 * There is only support to translate from the endpoint to its
+	 * parent port, but not in the opposite direction from the
+	 * parent to the endpoint. Thus, the endpoint address range
+	 * cannot be determined and setup manually. If the address range
+	 * was translated and modified, forbid reprogramming of the
+	 * decoders and lock them.
+	 */
+	cxld->flags |= CXL_DECODER_F_LOCK;
+
 	ctx->hpa_range = range;
 	ctx->interleave_ways = ways;
 	ctx->interleave_granularity = gran;
-- 
2.39.5

