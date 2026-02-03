Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011043.outbound.protection.outlook.com [40.107.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156643469E7;
	Tue,  3 Feb 2026 17:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770140223; cv=fail; b=GcgQtMGNNLzf3qzM7M3m3vWEi3CM1r2YhM4Jp/QNdIEcHfiGYuvUukfBcsHhrMRzhXBsVUkNwLDXEHI7/Mld800HhVlPgZB8W6l/eUm/v4z0SwMbNeNd2huyjicr17AU9sOWqF9KPai0SJE3r8NGWY+1QCBoJARt9l2O64nYylQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770140223; c=relaxed/simple;
	bh=C2+X06bKhtiJLa09NQ0gkMWJamkp/S9drFQxOdJyl3M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r279GgSobmq5NfcFol0iDCQFItyVqlJW8twPTQlTzFGcfmM9W2JTWiCq0TtDdtdtZXHgnMkXMuzgZ6TJRMbSdMe41Z7flP03ozxWGXLmM0nNqyEI3Zs5pP0aPDUherH/IJu5R35YhiWZyEVQaMvXk7m2j7cj2kqilMj4aY4uAWg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sEaVv8CZ; arc=fail smtp.client-ip=40.107.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sEaVv8CZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q7Secn+4Vwmn4bMMAD1smY4yAQlhY2vYANmnVpYwA+CZl/X2l4a4WeBGjG6IiCBXFjbYXgUBtFpIpkXRl4+uncu8VAi68y3N0xztZv1Iw98XywwuYWEAbbh5w12/mQA2v35E9tEBPGwMvnPZU/f6mtlxPuUTj4+/n59ohOwnVVLs6mJLnhAb66TJHtWXvnZ0850phg5OJcb5ArENeWPpAhXnVIKgkPsoe8HpEiqS/L9oPvgee+drb+irTdMOoaLVnd5xLWTg9SuceCRCVlhp5ln1aVB1W13jgl6jfvLTYU9wOfN7LRnl+OOJyi3kJ+aupHeLn3+/a3Y348pjW4Ihqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a9Ty0J1hoFYBcC0DBh3ByWCJ39K/czv/j+59ttBrwwY=;
 b=vSM8x1Oc9sdRRVzIEzIBID2nbrph3sR6Gq9UgArMSn24fS3LQmQKCeTke6rXQBIaRXaVh4MKwriQcPfLVCW+rSght33aHcUAW18wlfLd61WbRbc9K3LMcaf0rflAGtqwftxB1jFp8VXtBxSmX8uyZV18YRDJYNgsBqr7QnFoZuUTQG6ygDQ/uWVAyGw/t7PBxhvm8PW+zmSNpxlLYlPds7ms3GOi/7hwGO2Kd1nzpveFJmC4Ykf2etW2nA88udAxecsIAk1TNcA7keRq+1fiVV6bKXOSJZhnPD29LVkHXtucBbpZ4xbYm2x5cpYSsKKEFq/8yS2j98BknHB0sahR3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a9Ty0J1hoFYBcC0DBh3ByWCJ39K/czv/j+59ttBrwwY=;
 b=sEaVv8CZ3zTAPlv3/ozHG+8OzDs+kV6g0tZe4OPzLFInmCg0PLTnuMQiWWOVfdqzKQMfSU2vb/T2Ru0ww016bPETygpU6uck3pdPS0noS3f0Xb0K7XqsZyHYZcFQPyP37+C8gCNiljjVoQGk/K74E2mJIayDcxliJ4ICyIT4z3Y=
Received: from BN9PR03CA0291.namprd03.prod.outlook.com (2603:10b6:408:f5::26)
 by BY5PR12MB4276.namprd12.prod.outlook.com (2603:10b6:a03:20f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Tue, 3 Feb
 2026 17:36:53 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:408:f5:cafe::c2) by BN9PR03CA0291.outlook.office365.com
 (2603:10b6:408:f5::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.16 via Frontend Transport; Tue,
 3 Feb 2026 17:36:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.0 via Frontend Transport; Tue, 3 Feb 2026 17:36:52 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 3 Feb
 2026 11:36:48 -0600
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
Subject: [PATCH v5 3/3] Documentation/driver-api/cxl: ACPI PRM Address Translation Support and AMD Zen5 enablement
Date: Tue, 3 Feb 2026 18:36:00 +0100
Message-ID: <20260203173604.1440334-3-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260203173604.1440334-1-rrichter@amd.com>
References: <20260203173604.1440334-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|BY5PR12MB4276:EE_
X-MS-Office365-Filtering-Correlation-Id: e14ca0c4-8081-403d-404f-08de634ad1ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aHhLY3RIRk9LREUyTGJ6bW9qTmxlbUtpRmFTUGlFMzZKanhkZFU2Qll5aGlM?=
 =?utf-8?B?Ti9kdGJCUU5vL2hGSmdwWjNnV0J1S2ZKZkVqMFdvTGZtTWhwOXd3eXVqekNi?=
 =?utf-8?B?RXlWWnNhMmFRR01oam5xRDRoNTI5eCtWb2UwcGFKWTY2TW5NRXRqd3NuTkVl?=
 =?utf-8?B?eEMrREZtL2Z6ZmU5aldhVzdjbzhqUWJPWDN1VFZlRXgrSjZSRm1MS2JpMVNl?=
 =?utf-8?B?M0VlNS9VeUlXME04V2d4bGtvZVBIbE9ZcitVV3VBb09vOWVQNWhvbFZGU092?=
 =?utf-8?B?eVRrazBYUUl4MXRSWXJ2YzRockNBNXV3dTRCcDVaVmdIOUpKaGlUdFpReXll?=
 =?utf-8?B?SlRjQWd3bWJFei9Yb0lDdS9valhqaFZ3R0IzdHJTR3VVM1dSUEtsMTZkNThu?=
 =?utf-8?B?NGx3dkllWEFOWkpDRHV1ZlV4TjBONzRPaDNybHRNS1V1RXZBbmgxRXc2VnVF?=
 =?utf-8?B?WlRpTjF3bFBVaFg1bGxJbURkdVZWeW9jWmhuMUUxVTdxOUFLMDJsYlI5NzRx?=
 =?utf-8?B?THBiVmZQSXR0eHhIeVFEN00veVFXTXo5YjFaSmZDM0cxSDk4MmVueER3RitC?=
 =?utf-8?B?TlRBb1llSnh4dFhvMk9mdEE1eWEzSHFEVWFDVkp0LzVDelkxelBIT2ZoQmpu?=
 =?utf-8?B?OGNHK1psVVRhYnQxYmdoTE9MbzBtNU5jWkNKd1dvck5JMUlwWkx1MTBwc1cr?=
 =?utf-8?B?UFJQQjcwaHQwWFp3K0h0WUViN2FRam9vajdwdVdXa0xabVkxdEY0blBXY0NV?=
 =?utf-8?B?MVlKWHQ3SEludXBUeEM1WHdMMVJ0NDM2b1hyUWJvRDg5VEpoT1JnZEE1d2Zk?=
 =?utf-8?B?enFFTW56dy93d0VYbEVOVkRNT0hGYTNaM0k0TWJzd2o4YTdHSU5KRmxqNkpO?=
 =?utf-8?B?cGhKalM3RUROZDVNYllnZnRiT2toN3dCWjVTa0g4ZHZmTTQ5NEk2RVROZkgv?=
 =?utf-8?B?UnVEcDdla0lDTGxOUC90R3dYQzFuMVc3NDhxVHpxcXZJampGbm5lT08xWjZy?=
 =?utf-8?B?MUViQkhGZ0lGWEVLRnBEVTFQTEVnbWlDMTR3N0tyREs2endNYWpPdnF4T0FP?=
 =?utf-8?B?SWhNZE42alRnWUlYMGRXamVYc3J0OW1sMmRSU3c3VWYxeW5tdmpteWhPM1FP?=
 =?utf-8?B?RDYxR1daajdYZDVQQUdtaTVjVGNlQzRpd1dCWURTd09yY0R3dXNaN3hMV0pp?=
 =?utf-8?B?bGpTWUsybXAyQkp4bWgzQkNBQ0FZcmdqSE9PYURDa3NVQU1KMlBHams4ZFph?=
 =?utf-8?B?dFlISHdQOGw2Q1RieHRoM2FhVDc4R1RwUmkvUjV4YldrYTdQWkZ5RVhHMHBj?=
 =?utf-8?B?M3RRWm11Y0hKS012OFFJaXZSVURvTFRaaHR0Vm02cDdrVUVPdnEvd2J2bzkx?=
 =?utf-8?B?YXdHU05sTFBoc1lhTUIzb2pwMEFQNFlscVluMjRDbUg2cTIxTFpCdVhiajNk?=
 =?utf-8?B?Zjljd2ZzeTVsTlhOTm55aUM1YngrN3JMdHpiYjYrVWY3bWU4YWVoM2RtckpO?=
 =?utf-8?B?eXdoaFVPc3BDVk9tNHpjZjUxMXZpOHVKM2tNalRheU5BdWlCMEJBV1ZiM1hh?=
 =?utf-8?B?b2ptRVU2aG92S0NsNFFaY0pEOG51RmIyOFliNzJuMHlFY0h1V3BYVHN3MFp2?=
 =?utf-8?B?WnV4V2lVT1MwdlB5YXJUbFprbWhDVUttQ1VVRGl0NnVESk1rOW8ydVRJVzdJ?=
 =?utf-8?B?UWJVQUNQSEQ0YU43QVp3aEduRTN1RkJSUHdKS1FOcTlWOGxkdVFLL2xiczVU?=
 =?utf-8?B?WGc2TktmVVo3SnBnWllLQ3lHa0lPZWliVnpMU0tBdVFKZ1Z3ZTVzZnVRQ2tC?=
 =?utf-8?B?YXhYVld5U3dnbjBKZWs2VldvZzR0NFNwU3hWWkJ1aG9SWDJXSFRKbmwyZ29E?=
 =?utf-8?B?c0czSWs1b0dsOURJZkE3djVTTzlvaWgyWmR0NUIwK21TMnFObzZUUC95WHRN?=
 =?utf-8?B?cVRoK2ZUWVlwbEptVkgzY0VtVU1oeTE3cDNiUGFwU1o2SCs5SDg5S0RWOXd2?=
 =?utf-8?B?M2Nucm03Y0hzRGFyVmtmSTU2QkR6TjFtV2VKU2F3V0E5cVJwZHNjcHc5Z0sx?=
 =?utf-8?B?VzdJaUdZdDREcE9VQ1haeEpicmdmSFh6cXZQV2xQS3F6cHl6VTZQRFBub2ZI?=
 =?utf-8?B?WE1sM0pPejdaeWpBL0xqbjRrTXdtRVZ6V05hSjlPb2VMUjdPenZwc0F6NEo1?=
 =?utf-8?Q?fSqbMjMXwkxtO9ujzk2p7yM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YkZ2KbZc4xjeUXgIyW6ki90zXMumcnplseLLw3PmH0cVsNfuo1tXnMpeTkZ/ASJC4OPIDTiI93v4M4TttX+GskAduxVoBGL/Hq42x+xYhrkBtxtwwuGNnbNRa2Wn+qt7Xpz9eJbv+Q0dg8ctRlSuxr2bUnFEZksmRFNMcxFZZTnKueuiewxkXw0RyIYd4Qd4Od33zY2MEts6qT6dNdRMC6JX51mtzJ9+2QG/d4g7spA94qfcOJbBknA1T1DQvjxviw7w5RvvRl1wWf6cGrIsVVqgbyjamHxfpXZ43Cipd+5nDw6zod9GTT1SflCg/+iTGu/ClYK8hyzFgrotM8Wlj369oa2WlUbnaqK0BCMyywKOHZXttgfNwfTtWZ3Zj5Uk/snI9D4XjShFLf5VXxYdhdMHC/VYT7wCrkYE4+L2jT3nrG7SoOjfZzTODrwG6fwA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 17:36:52.9290
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e14ca0c4-8081-403d-404f-08de634ad1ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4276

This adds a convention document for the following patch series:

 cxl: ACPI PRM Address Translation Support and AMD Zen5 enablement

Version 7 and later:

 https://lore.kernel.org/linux-cxl/20251114213931.30754-1-rrichter@amd.com/

Link: https://lore.kernel.org/linux-cxl/20251114213931.30754-1-rrichter@amd.com/
Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
v5:
 * updated sob-chain (Dan),
 * removed specification of _DSM,
 * added PRM handler definition to the specification,
 * made PRM handler mandatory including the GUID handler id to be used,
 * added references to PRM spec
 * revised the entire doc and made small format and grammar fixups and
   wording improvements,
v4:
 * updated sob-chain (Dave, Alison, Jonathan, Dan),
 * added additional spec change for Normalized addressing and _DSM
   definition for address translation (Dan),
 * revised the entire doc and made small format and grammar fixups and
   wording improvements,
v3:
 * updated link in descriptions and add Link: tag (Jonathan Cameron),
 * clarified CFMWS and HPA range description (Jonathan Cameron),
 * use 80 chars line limit (Jonathan Cameron),
 * added block diagram to illustrate the example address mappings (Dave),
v2:
 * updated sob-chain,
 * spell fix in patch description (Randy),
 * made small changes as suggested by Randy,
 * Removed include:: <isonum.txt> line (Jon).
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 Documentation/driver-api/cxl/conventions.rst  |   1 +
 .../driver-api/cxl/conventions/cxl-atl.rst    | 304 ++++++++++++++++++
 2 files changed, 305 insertions(+)
 create mode 100644 Documentation/driver-api/cxl/conventions/cxl-atl.rst

diff --git a/Documentation/driver-api/cxl/conventions.rst b/Documentation/driver-api/cxl/conventions.rst
index 9267a697b2fe..0d2e07279ad9 100644
--- a/Documentation/driver-api/cxl/conventions.rst
+++ b/Documentation/driver-api/cxl/conventions.rst
@@ -14,4 +14,5 @@ same convention.
    :caption: Contents
 
    conventions/cxl-lmh.rst
+   conventions/cxl-atl.rst
    conventions/template.rst
diff --git a/Documentation/driver-api/cxl/conventions/cxl-atl.rst b/Documentation/driver-api/cxl/conventions/cxl-atl.rst
new file mode 100644
index 000000000000..3a36a84743d0
--- /dev/null
+++ b/Documentation/driver-api/cxl/conventions/cxl-atl.rst
@@ -0,0 +1,304 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+ACPI PRM CXL Address Translation
+================================
+
+Document
+--------
+
+CXL Revision 3.2, Version 1.0
+
+License
+-------
+
+SPDX-License Identifier: CC-BY-4.0
+
+Creator/Contributors
+--------------------
+
+- Robert Richter, AMD et al.
+
+Summary of the Change
+---------------------
+
+The CXL Fixed Memory Window Structures (CFMWS) describe zero or more Host
+Physical Address (HPA) windows associated with one or more CXL Host Bridges.
+Each HPA range of a CXL Host Bridge is represented by a CFMWS entry. An HPA
+range may include addresses currently assigned to CXL.mem devices, or an OS may
+assign ranges from an address window to a device.
+
+Host-managed Device Memory is Device-attached memory that is mapped to system
+coherent address space and accessible to the Host using standard write-back
+semantics. The managed address range is configured in the CXL HDM Decoder
+registers of the device. An HDM Decoder in a device is responsible for
+converting HPA into DPA by stripping off specific address bits.
+
+CXL devices and CXL bridges use the same HPA space. It is common across all
+components that belong to the same host domain. The view of the address region
+must be consistent on the CXL.mem path between the Host and the Device.
+
+This is described in the *CXL 3.2 specification* (Table 1-1, 3.3.1,
+8.2.4.20, 9.13.1, 9.18.1.3). [#cxl-spec-3.2]_
+
+Depending on the interconnect architecture of the platform, components attached
+to a host may not share the same host physical address space. Those platforms
+need address translation to convert an HPA between the host and the attached
+component, such as a CXL device. The translation mechanism is host-specific and
+implementation dependent.
+
+For example, x86 AMD platforms use a Data Fabric that manages access to physical
+memory. Devices have their own memory space and can be configured to use
+'Normalized addresses' different from System Physical Addresses (SPA). Address
+translation is then needed. For details, see
+:doc:`x86 AMD Address Translation </admin-guide/RAS/address-translation>`.
+
+Those AMD platforms provide PRM [#prm-spec]_ handlers in firmware to perform
+various types of address translation, including for CXL endpoints. AMD Zen5
+systems implement the ACPI PRM CXL Address Translation firmware call. The ACPI
+PRM handler has a specific GUID to uniquely identify platforms with support for
+Normalized addressing. This is documented in the *ACPI v6.5 Porting Guide*
+(Address Translation - CXL DPA to System Physical Address). [#amd-ppr-58088]_
+
+When in Normalized address mode, HDM decoder address ranges must be configured
+and handled differently. Hardware addresses used in the HDM decoder
+configurations of an endpoint are not SPA and need to be translated from the
+address range of the endpoint to that of the CXL host bridge. This is especially
+important for finding an endpoint's associated CXL Host Bridge and HPA window
+described in the CFMWS. Additionally, the interleave decoding is done by the
+Data Fabric and the endpoint does not perform decoding when converting HPA to
+DPA. Instead, interleaving is switched off for the endpoint (1-way). Finally,
+address translation might also be needed to inspect the endpoint's hardware
+addresses, such as during profiling, tracing, or error handling.
+
+For example, with Normalized addressing the HDM decoders could look as follows::
+
+                          -------------------------------
+                          | Root Decoder (CFMWS)        |
+                          | SPA Range: 0x850000000      |
+                          | Size: 0x8000000000 (512 GB) |
+                          | Interleave Ways: 1          |
+                          -------------------------------
+                                        |
+                                        v
+                          -------------------------------
+                          | Host Bridge Decoder (HDM)   |
+                          | SPA Range: 0x850000000      |
+                          | Size: 0x8000000000 (512 GB) |
+                          | Interleave Ways: 4          |
+                          | Targets: endpoint5,8,11,13  |
+                          | Granularity: 256            |
+                          -------------------------------
+                                        |
+           -----------------------------+------------------------------
+           |                  |                   |                   |
+           v                  v                   v                   v
+ ------------------- ------------------- ------------------- -------------------
+ | endpoint5       | | endpoint8       | | endpoint11      | | endpoint13      |
+ | decoder5.0      | | decoder8.0      | | decoder11.0     | | decoder13.0     |
+ | PCIe:           | | PCIe:           | | PCIe:           | | PCIe:           |
+ |   0000:e2:00.0  | |   0000:e3:00.0  | |   0000:e4:00.0  | |   0000:e1:00.0  |
+ | DPA:            | | DPA:            | | DPA:            | | DPA:            |
+ |   Start: 0x0    | |   Start: 0x0    | |   Start: 0x0    | |   Start: 0x0    |
+ |   Size:         | |   Size:         | |   Size:         | |   Size:         |
+ |    0x2000000000 | |    0x2000000000 | |    0x2000000000 | |    0x2000000000 |
+ |    (128 GB)     | |    (128 GB)     | |    (128 GB)     | |    (128 GB)     |
+ | Interleaving:   | | Interleaving:   | | Interleaving:   | | Interleaving:   |
+ |   Ways: 1       | |   Ways: 1       | |   Ways: 1       | |   Ways: 1       |
+ |   Gran: 256     | |   Gran: 256     | |   Gran: 256     | |   Gran: 256     |
+ ------------------- ------------------- ------------------- -------------------
+          |                   |                   |                   |
+          v                   v                   v                   v
+         DPA                 DPA                 DPA                 DPA
+
+This shows the representation in sysfs:
+
+.. code-block:: none
+
+ /sys/bus/cxl/devices/endpoint5/decoder5.0/interleave_granularity:256
+ /sys/bus/cxl/devices/endpoint5/decoder5.0/interleave_ways:1
+ /sys/bus/cxl/devices/endpoint5/decoder5.0/size:0x2000000000
+ /sys/bus/cxl/devices/endpoint5/decoder5.0/start:0x0
+ /sys/bus/cxl/devices/endpoint8/decoder8.0/interleave_granularity:256
+ /sys/bus/cxl/devices/endpoint8/decoder8.0/interleave_ways:1
+ /sys/bus/cxl/devices/endpoint8/decoder8.0/size:0x2000000000
+ /sys/bus/cxl/devices/endpoint8/decoder8.0/start:0x0
+ /sys/bus/cxl/devices/endpoint11/decoder11.0/interleave_granularity:256
+ /sys/bus/cxl/devices/endpoint11/decoder11.0/interleave_ways:1
+ /sys/bus/cxl/devices/endpoint11/decoder11.0/size:0x2000000000
+ /sys/bus/cxl/devices/endpoint11/decoder11.0/start:0x0
+ /sys/bus/cxl/devices/endpoint13/decoder13.0/interleave_granularity:256
+ /sys/bus/cxl/devices/endpoint13/decoder13.0/interleave_ways:1
+ /sys/bus/cxl/devices/endpoint13/decoder13.0/size:0x2000000000
+ /sys/bus/cxl/devices/endpoint13/decoder13.0/start:0x0
+
+Note that the endpoint interleaving configurations use direct mapping (1-way).
+
+With PRM calls, the kernel can determine the following mappings:
+
+.. code-block:: none
+
+ cxl decoder5.0: address mapping found for 0000:e2:00.0 (hpa -> spa):
+   0x0+0x2000000000 -> 0x850000000+0x8000000000 ways:4 granularity:256
+ cxl decoder8.0: address mapping found for 0000:e3:00.0 (hpa -> spa):
+   0x0+0x2000000000 -> 0x850000000+0x8000000000 ways:4 granularity:256
+ cxl decoder11.0: address mapping found for 0000:e4:00.0 (hpa -> spa):
+   0x0+0x2000000000 -> 0x850000000+0x8000000000 ways:4 granularity:256
+ cxl decoder13.0: address mapping found for 0000:e1:00.0 (hpa -> spa):
+   0x0+0x2000000000 -> 0x850000000+0x8000000000 ways:4 granularity:256
+
+The corresponding CXL host bridge (HDM) decoders and root decoder (CFMWS) match
+the calculated endpoint mappings shown:
+
+.. code-block:: none
+
+ /sys/bus/cxl/devices/port1/decoder1.0/interleave_granularity:256
+ /sys/bus/cxl/devices/port1/decoder1.0/interleave_ways:4
+ /sys/bus/cxl/devices/port1/decoder1.0/size:0x8000000000
+ /sys/bus/cxl/devices/port1/decoder1.0/start:0x850000000
+ /sys/bus/cxl/devices/port1/decoder1.0/target_list:0,1,2,3
+ /sys/bus/cxl/devices/port1/decoder1.0/target_type:expander
+ /sys/bus/cxl/devices/root0/decoder0.0/interleave_granularity:256
+ /sys/bus/cxl/devices/root0/decoder0.0/interleave_ways:1
+ /sys/bus/cxl/devices/root0/decoder0.0/size:0x8000000000
+ /sys/bus/cxl/devices/root0/decoder0.0/start:0x850000000
+ /sys/bus/cxl/devices/root0/decoder0.0/target_list:7
+
+The following changes to the specification are needed:
+
+* Allow a CXL device to be in an HPA space other than the host's address space.
+
+* Allow the platform to use implementation-specific address translation when
+  crossing memory domains on the CXL.mem path between the host and the device.
+
+* Define a PRM handler method for converting device addresses to SPAs.
+
+* Specify that the platform shall provide the PRM handler method to the
+  Operating System to detect Normalized addressing and for determining Endpoint
+  SPA ranges and interleaving configurations.
+
+* Add reference to:
+
+  | Platform Runtime Mechanism Specification, Version 1.1 – November 2020
+  | https://uefi.org/sites/default/files/resources/PRM_Platform_Runtime_Mechanism_1_1_release_candidate.pdf
+
+Benefits of the Change
+----------------------
+
+Without the change, the Operating System may be unable to determine the memory
+region and Root Decoder for an Endpoint and its corresponding HDM decoder.
+Region creation would fail. Platforms with a different interconnect architecture
+would fail to set up and use CXL.
+
+References
+----------
+
+.. [#cxl-spec-3.2] Compute Express Link Specification, Revision 3.2, Version 1.0,
+   https://www.computeexpresslink.org/
+
+.. [#amd-ppr-58088] AMD Family 1Ah Models 00h–0Fh and Models 10h–1Fh,
+   ACPI v6.5 Porting Guide, Publication # 58088,
+   https://www.amd.com/en/search/documentation/hub.html
+
+.. [#prm-spec] Platform Runtime Mechanism, Version: 1.1,
+   https://uefi.org/sites/default/files/resources/PRM_Platform_Runtime_Mechanism_1_1_release_candidate.pdf
+
+Detailed Description of the Change
+----------------------------------
+
+The following describes the necessary changes to the *CXL 3.2 specification*
+[#cxl-spec-3.2]_:
+
+Add the following reference to the table:
+
+Table 1-2. Reference Documents
+
++----------------------------+-------------------+---------------------------+
+| Document                   | Chapter Reference | Document No./Location     |
++============================+===================+===========================+
+| Platform Runtime Mechanism | Chapter 8, 9      | https://www.uefi.org/acpi |
+| Version: 1.1               |                   |                           |
++----------------------------+-------------------+---------------------------+
+
+Add the following paragraphs to the end of the section:
+
+**8.2.4.20 CXL HDM Decoder Capability Structure**
+
+"A device may use an HPA space that is not common to other components of the
+host domain. The platform is responsible for address translation when crossing
+HPA spaces. The Operating System must determine the interleaving configuration
+and perform address translation to the HPA ranges of the HDM decoders as needed.
+The translation mechanism is host-specific and implementation dependent.
+
+The platform indicates support of independent HPA spaces and the need for
+address translation by providing a Platform Runtime Mechanism (PRM) handler. The
+OS shall use that handler to perform the necessary translations from the DPA
+space to the HPA space. The handler is defined in Section 9.18.4 *PRM Handler
+for CXL DPA to System Physical Address Translation*."
+
+Add the following section and sub-section including tables:
+
+**9.18.4 PRM Handler for CXL DPA to System Physical Address Translation**
+
+"A platform may be configured to use 'Normalized addresses'. Host physical
+address (HPA) spaces are component-specific and differ from system physical
+addresses (SPAs). The endpoint has its own physical address space. All requests
+presented to the device already use Device Physical Addresses (DPAs). The CXL
+endpoint decoders have interleaving disabled (1-way interleaving) and the device
+does not perform HPA decoding to determine a DPA.
+
+The platform provides a PRM handler for CXL DPA to System Physical Address
+Translation. The PRM handler translates a Device Physical Address (DPA) to a
+System Physical Address (SPA) for a specified CXL endpoint. In the address space
+of the host, SPA and HPA are equivalent, and the OS shall use this handler to
+determine the HPA that corresponds to a device address, for example when
+configuring HDM decoders on platforms with Normalized addressing. The GUID and
+the parameter buffer format of the handler are specified in section 9.18.4.1. If
+the OS identifies the PRM handler, the platform supports Normalized addressing
+and the OS must perform DPA address translation as needed."
+
+**9.18.4.1 PRM Handler Invocation**
+
+"The OS calls the PRM handler for CXL DPA to System Physical Address Translation
+using the direct invocation mechanism. Details of calling a PRM handler are
+described in the Platform Runtime Mechanism (PRM) specification.
+
+The PRM handler is identified by the following GUID:
+
+ EE41B397-25D4-452C-AD54-48C6E3480B94
+
+The caller allocates and prepares a Parameter Buffer, then passes the PRM
+handler GUID and a pointer to the Parameter Buffer to invoke the handler. The
+Parameter Buffer is described in Table 9-32."
+
+**Table 9-32. PRM Parameter Buffer used for CXL DPA to System Physical Address Translation**
+
++-------------+-----------+------------------------------------------------------------------------+
+| Byte Offset | Length in | Description                                                            |
+|             |   Bytes   |                                                                        |
++=============+===========+========================================================================+
+| 00h         | 8         | **CXL Device Physical Address (DPA)**: CXL DPA (e.g., from             |
+|             |           | CXL Component Event Log)                                               |
++-------------+-----------+------------------------------------------------------------------------+
+| 08h         | 4         | **CXL Endpoint SBDF**:                                                 |
+|             |           |                                                                        |
+|             |           | - Byte 3 - PCIe Segment                                                |
+|             |           | - Byte 2 - Bus Number                                                  |
+|             |           | - Byte 1:                                                              |
+|             |           |          - Device Number Bits[7:3]                                     |
+|             |           |          - Function Number Bits[2:0]                                   |
+|             |           | - Byte 0 - RESERVED (MBZ)                                              |
+|             |           |                                                                        |
++-------------+-----------+------------------------------------------------------------------------+
+| 0Ch         | 8         | **Output Buffer**: Virtual Address Pointer to the buffer,              |
+|             |           | as defined in Table 9-33.                                              |
++-------------+-----------+------------------------------------------------------------------------+
+
+**Table 9-33. PRM Output Buffer used for CXL DPA to System Physical Address Translation**
+
++-------------+-----------+------------------------------------------------------------------------+
+| Byte Offset | Length in | Description                                                            |
+|             |   Bytes   |                                                                        |
++=============+===========+========================================================================+
+| 00h         | 8         | **System Physical Address (SPA)**: The SPA converted                   |
+|             |           | from the CXL DPA.                                                      |
++-------------+-----------+------------------------------------------------------------------------+
-- 
2.47.3

