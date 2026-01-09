Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010051.outbound.protection.outlook.com [52.101.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D7B32ABCD
	for <linux-cxl@vger.kernel.org>; Fri,  9 Jan 2026 13:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767967065; cv=fail; b=YTlKddQW4zDkBfkIyR3O/heKFRB/w5V0SC1I7q30CbHxi35CS1XrpfIGpra4H65H3muZ1JlcHWOmqoBD3g10qumSr4KPIQ7gwQ4Jf0g/labKPntEWXD0BPz8VWfAFxBuO+EeqHCQGfiSmK116JfHU1sKMwoVPlsrrQuIHynCQ3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767967065; c=relaxed/simple;
	bh=VZI02y+fAPmJjlSpeziEGmAcX1Mvq8TlfsfBefsk4Gc=;
	h=Message-ID:Date:MIME-Version:To:CC:From:Subject:Content-Type; b=CImeSCJrHfgNFjXTWPWbk2sCfWgbs5L0WRHzgFj1MuH1ZC6yiHKXlm80//hJAW3ithcTnJ0jGFHy99q117exFrWG2KjynLC/zH5yoXTciL29BuBPDzKjzR1DUf4nACtK9hHcbatRzTnhWMzdWXgXtYGnYoUf/xV7dRq6Wj51spw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OuXdo17o; arc=fail smtp.client-ip=52.101.193.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OuXdo17o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xg94LOuXOflqlCqzxu4F7LLvxImsNe10HlQML6bSToQUrkKKBRfOPwaU/TcFhsfSvnE5MHO1lmYHGVNm2Q8Ngz87M4rVomZApKNTEHclBuje8esuVOYDIjQGJ6gAy0EpoQf4AnM9C3j6rmFf+FDXcEo2AT3VvfeuPNQmV1r7c1mOnYim6xj1wJgWhdWV6KK3pRy8qSqVaTdAwlMz98RyJ89aMkEox2S6DReZz2fwWud5qgHCK/fkUtBP+zn73tXY6KtOwnyrKcdfHtMPRRn/4ejRhC8VZFYZqoBWL2O0ga+mWf4u72p+LPxsdaPNtlSyPK94ijJPvi75n92mNb8BkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIwLDwy+UyJNLApeL4VglnFMQQ+QVmW5jb0A1Hz2sOo=;
 b=UE3n/51lO9xTuYBLqA16hTtRiL/i9SJiYEAHa5tgApD5vr74Gilgk9US5kHttuJYtfPxQCVN07QIkR3Rch+cG/57iN1OgfeDXnXgXQ4QO9mUPgCaUM8HvUKx41jrRxKOZf6mC+AUsQaXw/muQPNXQYfQbQvP0YsjTuPgNL+YozFSCRF9z4/yftKEZQ0UtGMk/rivkOB1BX92Vr19C9LaaqQaX+3Yu3kj/cCS+0pYeVJ++B7EdjWXCwPuxDZbLEyP3VlQwr+5XqTq3OEqmR8c4YQ1us8PL8aepi35cyouwQ0DEuVZjpuAvKN+fA0MFl2xnQhLlgo+DkC2DDOPEbpeGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIwLDwy+UyJNLApeL4VglnFMQQ+QVmW5jb0A1Hz2sOo=;
 b=OuXdo17o5SRT/Wgwf1uGJAsx0E7fwBN/MHJxOxyv5VByFKM1uxyNYlJtktvvxje8uIqWA9LUZfCfs6OXDThn/juEoDgdM8Eq7jVbpQdXbp80iDXbeVvmVIb5O4fCFR7avAsTCtZo5JPDeuyNx3DUwRvDLlkcujrlUMh4VBmDYVs=
Received: from IA4P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:559::10)
 by SA1PR12MB8096.namprd12.prod.outlook.com (2603:10b6:806:326::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Fri, 9 Jan
 2026 13:57:40 +0000
Received: from BN3PEPF0000B06C.namprd21.prod.outlook.com
 (2603:10b6:208:559:cafe::ba) by IA4P221CA0005.outlook.office365.com
 (2603:10b6:208:559::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.5 via Frontend Transport; Fri, 9
 Jan 2026 13:57:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B06C.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.0 via Frontend Transport; Fri, 9 Jan 2026 13:57:39 +0000
Received: from [10.254.59.95] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 9 Jan
 2026 07:57:39 -0600
Message-ID: <6e9fb657-8264-4028-92e2-5428e2695bf1@amd.com>
Date: Fri, 9 Jan 2026 07:57:38 -0600
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: <dave@stgolabs.net>, <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>
CC: <linux-cxl@vger.kernel.org>, <benjamin.cheatham@amd.com>
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: [PATCH] cxl/core: Fix cxl_dport debugfs EINJ entries
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06C:EE_|SA1PR12MB8096:EE_
X-MS-Office365-Filtering-Correlation-Id: 079017f3-b081-4f1b-a29e-08de4f870d86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TExkckJJdUhWUEs1M0lBeE5IeFpYSkxCWEoyV0QxM3BYcDhtc0FLT1N4WWJJ?=
 =?utf-8?B?Y1pMc3ZydG1CSHdBRlovd0NJTUVFTW1kbkk0akZQVEFZRGJHK2FrT2VBTzZj?=
 =?utf-8?B?d2pObmdZQU9vU2JNbE1kVlNpU004YlJrWmtxUmlCSUc3MFI4c0czREVWL2ZP?=
 =?utf-8?B?aGxwdzhuVFpnNHltQ255Q0M2ajgzeTVwY1dqM0hYQmMvRDlUZDB2YnFwdmhy?=
 =?utf-8?B?OFl6ZDFaSmxpTVp5TjNhUmVZU2JGY2s4Q2ZkQ3dzMy9zY2ZYNitlYVg1eE1v?=
 =?utf-8?B?VWlCSVpOTk9BKzJBRUZsNzZZTS9KRXRBdlg1N3g4QllXcWEzOXUyNFo3clJQ?=
 =?utf-8?B?bXVPM2F6aEZoUHNTQjlJeFJYM1JGYmg3WHJsN0V5OGROMlU2b0VGUStwV0RG?=
 =?utf-8?B?MFl6bU1xdkFpbUF1RmNOdGdtSzR3cTZIQktheDdkYTlhSkpaSVhXcTJ5ZjYy?=
 =?utf-8?B?NGxIcmtnSnJkSTdtRFBRakc1aEQ0Zjk3VXErM0N0elF1VlE0WGRzTzV3MFI3?=
 =?utf-8?B?dVJNTDRRamNBMjRpSXJURC8rTEpWMkpNL0J0RC84L2pMZ3creTlvaU4raytw?=
 =?utf-8?B?MTdRZk9xcDM3MWxRdGVFczF0SG5qb1lQTGJoMG52WTUwVHNLeUVnRzJuaGpC?=
 =?utf-8?B?MWUyOEZQVzRvMGpJYjRMQktHUHdac0c2RmNmaWdQRjdqdkZiMXBwY0gxWkc2?=
 =?utf-8?B?eXlvRytySlg2YXFadEMvRTU0bkV4T3pMZXkwUGFNTENUTWZISDNRaHFoOWw1?=
 =?utf-8?B?dzc4MHZST3NyOCthWTYrcDFtdFpvMjN6RTJkZjBaZUlJYkpKbDdTQWRnWGZp?=
 =?utf-8?B?NWpQejRXZW96OGFLV0xZOG9MbEZFNmlCeUxWQTM1Z3lPM3pqVjNkb3Q3RXpE?=
 =?utf-8?B?cVB3cDQ0bjg3R1BsajQxL0VwVnhiZE5JTFg0Mmc2L0p2cVlKc3dVNzFLZTZt?=
 =?utf-8?B?c2NyN1NqNi84dlVudkErTkxEMWtnNmxpL2ltdkZnNjFRYVkvY2YzbUY1QXB3?=
 =?utf-8?B?aHh2N3hTVHNkSDNuamR5SjU1dTdFeFIrbzJlamNUcEpQcEV3d3hFUjRNbFdH?=
 =?utf-8?B?M01DVkZwRk5EZlJWOHFWQ3V2K2hoSjJFd0hORlprTlhVbEVhd2JkSlYyaGJm?=
 =?utf-8?B?K3Zjd0tuNUxrYzBKZ1JMRkV4blhEN1Z3OGRvQzhkY3pRbklnOHZZUU4zVG5w?=
 =?utf-8?B?TlkvaExxWWYvUnN3SlhZN3RkSnJwMmNyTUQ4UEJvZVNXeW8zNlRDeE03V1cy?=
 =?utf-8?B?allHbXNYMm9NYzY5Q05oVVEwM1l0OTZ0ZDhncEluR1A4UTExZlp6L2xuR0ZT?=
 =?utf-8?B?NG5Pa1E1Rm1iY0ludGFzd2NnTXpBYnNiWUF4WUR3cGUzTFRLWnhqM3RoNXI1?=
 =?utf-8?B?eE9veHBnZ3FwbGJzWFFPQjQycFZqSkt3ZTZjbFZvdmwxU0t3ei9RQXJIRTMx?=
 =?utf-8?B?cThZc1dvWnkwWE4yeWFEdWpKYXJNdll6NEpQOFFjcS8xcm40M3NGakFsWWw2?=
 =?utf-8?B?NUlJTkZ1dWZXY3Q1Q1g1Tm1HMkdJU2NqWWM2L1hDa2V6em51b0hkVE81cjVm?=
 =?utf-8?B?N2RaTFJDUVFidU9KTzRsdFBLZFRIczZVSW1qaGJGcy9aOFhmV0pTN0lObUhI?=
 =?utf-8?B?NHRsYnYwblpCWFRvOU40bkMva25nKzdKZzFIdGlkQXltZXczMFc4TTNXa0dt?=
 =?utf-8?B?UTByM3RiZWR1OWZNeXFmdEZyZXIzWUdrOUpORkFFdnJNM09kVWlmdVpCa3Bl?=
 =?utf-8?B?ZDdKV1BqaVd6Q2VXYmMrcDY3bzlyS1E2MFQ2WDA5ODJXVy9aUVN6ZWo0Zmlo?=
 =?utf-8?B?dWZ6MHpqRkFjVVNJemJRZVZ6UmFVWU9zZkkwV1FROHpxbmdSdEFmY2RVNFVa?=
 =?utf-8?B?NktoMEJZYXBZKzVDeFhKTHRMUUo3NkRGVFNmeEpGa0FOTHVweUkzZGlpZXcz?=
 =?utf-8?B?aDVMNFVlbmpRc0VaMllibUhIcjBhWnAxc09pODRoNjlpVVk1YUx4QWkzc2dZ?=
 =?utf-8?B?SkhIb2Vnb1Z3K3JuUEtUc2NiY0VNa1VvcFYxUnFWblIvK3oxemtRVm1HZ08v?=
 =?utf-8?B?WjBsT1VXWVcrZVlSdTVSNk0wbkQ5UzRQSjdRUkd3dWxvajRMcWRhdVNhVWVX?=
 =?utf-8?Q?tFNk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 13:57:39.8874
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 079017f3-b081-4f1b-a29e-08de4f870d86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B06C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8096

Protocol error injection is only valid for CXL 2.0+ root ports and CXL
1.1 memory-mapped downstream ports as per the ACPI v6.5 spec (Table
8-31). The core code currently creates an 'einj_inject' file in CXL debugfs
for all CXL 1.1 downstream ports and all PCI CXL 2.0+ downstream ports.
This results in debugfs EINJ files that won't work due to platform/spec
restrictions.

Fix by limiting 'einj_inject' file creation to only CXL 1.1 dports and
CXL 2.0+ root ports. Update the comment above the check to more accurately
represent the requirements expected by the EINJ module and ACPI spec.

Fixes: 8039804cfa73 ("cxl/core: Add CXL EINJ debugfs files")
Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/cxl/core/port.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index fef3aa0c6680..54f72452fb06 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -822,16 +822,18 @@ DEFINE_DEBUGFS_ATTRIBUTE(cxl_einj_inject_fops, NULL, cxl_einj_inject,
 
 static void cxl_debugfs_create_dport_dir(struct cxl_dport *dport)
 {
+	struct cxl_port *parent = parent_port_of(dport->port);
 	struct dentry *dir;
 
 	if (!einj_cxl_is_initialized())
 		return;
 
 	/*
-	 * dport_dev needs to be a PCIe port for CXL 2.0+ ports because
-	 * EINJ expects a dport SBDF to be specified for 2.0 error injection.
+	 * Protocol error injection is only available for CXL 2.0+ root ports
+	 * and CXL 1.1 downstream ports
 	 */
-	if (!dport->rch && !dev_is_pci(dport->dport_dev))
+	if (!dport->rch &&
+	    !(dev_is_pci(dport->dport_dev) && parent && is_cxl_root(parent)))
 		return;
 
 	dir = cxl_debugfs_create_dir(dev_name(dport->dport_dev));
-- 
2.52.0
