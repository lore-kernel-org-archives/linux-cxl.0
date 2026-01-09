Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013035.outbound.protection.outlook.com [40.93.201.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E285D3328EA;
	Fri,  9 Jan 2026 12:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767961834; cv=fail; b=SH1BaYcvfUo8nYLxSXlghsNJ8g9U61VeJQaElp/3ODE6W3ECsSVSlmpyor4ZrTOLfo+/QN8rjg+qcO5YySKqVeuL0ERcNSqDOxCLO13L9CkIZYjWYyGTYI14vmEIE0VgpdH1uSTlLP/PZvvUGjYfAO5ziCXb5enV+McuNrJOh3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767961834; c=relaxed/simple;
	bh=LoP2nLXt5gjOkXATjdDIZqfaDbpQsD9XA8cHscWYtDc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YHSqz0KmqdLYk4JytnAhXv/Wp9XxT5qUq37/ltWaLP8up1R4X3o+8CyN7RJh8HFNSa893WPgxBTsmwfSJDdxB0iV+gOKD8HBm8mQdlCGDBppSGeaQRbD9ghwivQsOvE73Jp+psGEnD2n39xXaDU+f9jKY3K6eDOnndOKpezmhrQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sNJhXcgx; arc=fail smtp.client-ip=40.93.201.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sNJhXcgx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eHi+wtt0/FxX1FlVOaaeKCQfxXUl+zmR7EBvtWWCM2r9qwVVEVMcqLeyZS9TjS53vRm2UK0xugPEG/bq5zAFYdeFiQkVHBEdwn3y/bcaXVmoE7tzyQcPSsaF1EuZgzdo4gc65Frh6ITZZDq7i/b++G8piKhRFXvVwWDCmfydRDhQLpS4Gfi09nIegdcPgoSpWC8NRrSV7UBz+dS7Va/9EhFTnRFXZowqOcdQsjqOymB0orFQFBkLXXB8FNEdae16ZOxypd1BEZ56B5EiGqjFbEl/HqY4YC/NnXdtEgKyW387mEIjU2UzL2S5vfyNQlfirnrEE/4AzvYge20tH40EKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E/vTliMvMwVKmFdwuO4WuAklo2k8Jhs8FjSqqov6E2s=;
 b=ITSuRLHtTyoRDC0AMYZ4D7qk6G49o6hYEVMogj4oWzAqy1bI1iLDKvoggDbD5aa96C2fOFlMrsRX8yuEY7sU+4FSEAKNnjyKL7VdaksrnqY8J7EYq99zzbqwYBCRDjqHioOWDRljpmRlErzcnPgW4MdossDiInlBkWUl/cgsrZBuGCs/OWdFj+EUSuocxB6AGcD8y7S97c3H+SjHcEZzQxKwAxXacBbMpwGJDC1iXj2a2c/PYeYMwt/onL6ww8W845YSIGoQ/W52K7PHQToAR4C5I6R9XZt2Ck1cHpqZvoX77XCwLnKdxzsDnd7VUKmEf8lzT61nDOyFGNpJ3LLviQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/vTliMvMwVKmFdwuO4WuAklo2k8Jhs8FjSqqov6E2s=;
 b=sNJhXcgx5WaIpC3UdiNlBy0se7yLVHpyOjdt7NAeRJJ+/yF+l4CToYyFSlXCHUQFO5wF9hU4TSKAkPp0tKJIslGBrL+Dfc5Z4Qw9Q0yGpiaXZuy3QhBlnjjo/888odN0qCgjZTxC8W9o/bX6UXXqyzUktQ1ewGdpsJBJ4GWLdMk=
Received: from CH2PR11CA0003.namprd11.prod.outlook.com (2603:10b6:610:54::13)
 by SJ0PR12MB5661.namprd12.prod.outlook.com (2603:10b6:a03:422::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Fri, 9 Jan
 2026 12:30:28 +0000
Received: from CH1PEPF0000AD78.namprd04.prod.outlook.com
 (2603:10b6:610:54:cafe::11) by CH2PR11CA0003.outlook.office365.com
 (2603:10b6:610:54::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.4 via Frontend Transport; Fri, 9
 Jan 2026 12:30:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH1PEPF0000AD78.mail.protection.outlook.com (10.167.244.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Fri, 9 Jan 2026 12:30:28 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 9 Jan
 2026 06:30:25 -0600
From: Robert Richter <rrichter@amd.com>
To: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Ben Widawsky <bwidawsk@kernel.org>
CC: Robert Richter <rrichter@amd.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v1] cxl/hdm: Fix newline character in dev_err() messages
Date: Fri, 9 Jan 2026 13:29:51 +0100
Message-ID: <20260109122952.639231-1-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD78:EE_|SJ0PR12MB5661:EE_
X-MS-Office365-Filtering-Correlation-Id: 54a0704f-125c-4b50-7cc0-08de4f7adf3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MAW36AVpmKkPC9utVma64y8hWiClc+rz7MhEl+q5K2Hyf4Nd4UoOB+68EH19?=
 =?us-ascii?Q?auu1P42QHrTCp0GpDFhEYwNIe/jnsX3zpEn2rQPQC/AATeaGl4VNB3U5QVD2?=
 =?us-ascii?Q?xJs4rrEq4Q+5v0RLRoMvdPMCAATujsxSUK1FrkzcEjP1jb/YyH5ZAKt18Kh0?=
 =?us-ascii?Q?ijZAB41nDEfOl2K4JpdG8p2lV/PmK1freFzRMgn9yHkeoO8ArVXVEqYAOB9R?=
 =?us-ascii?Q?Q6p4zlYtApHg0HXNyxifoyMNKgX7zjteYRQaPpt3rkOa2ZVBlPAi8vYKM1zM?=
 =?us-ascii?Q?GvWPNJlyGezDrMV6bSoXGMJA7y72ooMX8zHXmD4TGT0HAkvkROPvh32T7O1n?=
 =?us-ascii?Q?KvGcXjkX9pkLKFaVNUr7Tu36v/aYFXWD4B2F/zChFZfCdmje0XLcOLuBc8nE?=
 =?us-ascii?Q?4i9JFp0er+0XJ28ENMFufKnHyqakZ0diCIHJe4Q20RvxFbOYHR8AoMZ8ttnK?=
 =?us-ascii?Q?FDJDjCVfNtxcfcLbs6NJd+CNRT1ZQBP7Mcdu7aW9PnsmfveAh2hjse6NhzML?=
 =?us-ascii?Q?3GB6AUSTKNQqM6zaXymACpL5zNVj7vk1uV02UphZPikMJsn+/eJVzVhsYs28?=
 =?us-ascii?Q?Xwp/0Hi9Z0O987/DQtA38Gv9UuIkygLELAZZk7snl9lqcXjOWSnfE19odZnc?=
 =?us-ascii?Q?51wHHpaWcZjkNgw+17/tY3uiisNep8KRddvjCujw6PMfHfnXQ0rGKi710zTv?=
 =?us-ascii?Q?KyWET358XRJAHkTe32GaLG7XipVt9zqhHXgXQ+WG1Bfj56+oSu9CiBot9emS?=
 =?us-ascii?Q?n4Ahg5+XHo13LL0cjImInRipB5IG+EFZLm6udZYH2ZFxxovpdmraGp2q5yAa?=
 =?us-ascii?Q?XaYHympw1m6ZkHHf68eJFhyL9fTG6vyyc5IL47kK5zPuBoLlrlyeSMHWg6bn?=
 =?us-ascii?Q?+jBOtVk0MtUuONaCAW1jrxzaeTgkHmQGysOvevhUxY9i3GsC9TQCmzMMIQPm?=
 =?us-ascii?Q?JL2UDCd0WEmE9tmtXW7Or9JA7jPNDvjRJggKLkRvjYvCQgRHIwdjoacC+ZHv?=
 =?us-ascii?Q?rbVW6FYP/6pTPy0p8UU4Y5jFTtlk20GNh+cErWvuVjba0ZCirkrID/NILFSR?=
 =?us-ascii?Q?Y4RtL3h7qRFwSa3NolGWj7qGHniclD5LokECFeTqs5QMosnUbqd3feEreYp4?=
 =?us-ascii?Q?p0TTIO9zzUdVXFX9yBAUo64lB5kwBDH9WXOuaqveDIj3dvxh4yf9aMXNVGJ8?=
 =?us-ascii?Q?1NiA8LwmfX78GGSl/Jmvvkx3OV8Ro3OBaE8cPhYnYJRLK6vhls3wedAYLDLk?=
 =?us-ascii?Q?ke+ew7urMXGmvodQgUfs1ij7P7PXSTQqlwnL/2S1xfCmyg8AYj3TwgUks5yF?=
 =?us-ascii?Q?DAC8zAR3qFATjssbVhdiETn69maXEbJ2W4btoqNqrbHzDxaL59vrqiPKdZKL?=
 =?us-ascii?Q?aphjmEbew7v35tsIddbQNRBMdNmmvQUBfb2L5u79PS/CbHJiI/rJU/TLBFxw?=
 =?us-ascii?Q?68mR8+M4wEE/vjyvqJtSHQKxMnnEei3OoxkGFhE4iAYFdEMWfl7uJ/8afaMb?=
 =?us-ascii?Q?Zj8dzNEvrzSZIgtDCtnRD/vO+ScjvoPFusNyPGfsKb2b7JfJFV0S8VxqiAl6?=
 =?us-ascii?Q?EU1//wQTTx5L5YbJrU0=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 12:30:28.2626
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54a0704f-125c-4b50-7cc0-08de4f7adf3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD78.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5661

The newline character is not placed at the end of the string. This
causes unintended line wraps, broken log level and unterminated log
messages. Fix that for all messages.

Note that the messages are changed to use colons now instead of
parentheses, which is more common use.

Fixes: 24b18197184a ("cxl/hdm: Extend DVSEC range register emulation for region enumeration")
Fixes: 9c57cde0dcbd ("cxl/hdm: Enumerate allocated DPA")
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/hdm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index 031672e92b0b..28611b350cf6 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -966,7 +966,7 @@ static int cxl_setup_hdm_decoder_from_dvsec(
 	rc = devm_cxl_dpa_reserve(cxled, *dpa_base, len, 0);
 	if (rc) {
 		dev_err(&port->dev,
-			"decoder%d.%d: Failed to reserve DPA range %#llx - %#llx\n (%d)",
+			"decoder%d.%d: Failed to reserve DPA range %#llx - %#llx: %d\n",
 			port->id, cxld->id, *dpa_base, *dpa_base + len - 1, rc);
 		return rc;
 	}
@@ -1117,7 +1117,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 	rc = devm_cxl_dpa_reserve(cxled, *dpa_base + skip, dpa_size, skip);
 	if (rc) {
 		dev_err(&port->dev,
-			"decoder%d.%d: Failed to reserve DPA range %#llx - %#llx\n (%d)",
+			"decoder%d.%d: Failed to reserve DPA range %#llx - %#llx: %d\n",
 			port->id, cxld->id, *dpa_base,
 			*dpa_base + dpa_size + skip - 1, rc);
 		return rc;

base-commit: 88c72bab77aaf389beccf762e112828253ca0564
prerequisite-patch-id: f44102a7b095afa1588a5cac012ec2e0d852c021
prerequisite-patch-id: c142edda207a3a69ae242182e51e9a8b8d78cf72
-- 
2.47.3

