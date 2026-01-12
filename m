Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012057.outbound.protection.outlook.com [40.93.195.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1540D2C032E;
	Mon, 12 Jan 2026 11:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768216655; cv=fail; b=R/URTS939XpHKUSACChcWjk4KSvV/CGycnU976n7fDfvC3MSHmlfehJeTjZKzqcZyIC6rvOw/p/o7H4ASytw3Rh8D+OYB2ddrP1xQ6HdKAmi4049LGA1eC4ifQdUkUEKPqBuhAX21VtG8eb7falLUiUYpvxrp7+6mDvfSUxOp48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768216655; c=relaxed/simple;
	bh=/hpjtkDjEoZQt/b8MvanyTMa3cZOn00cOWfo66hfjlo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b9aJHByUHgAHBKpajzB5buSmtDUGS33MmMmB0yUiukj5WwiwaQpC0B4xy2R3VrzkMzBTZbaF2eDGbjb/fyLLPxvz+O03lGVjKRWR2ZUD7gS8S6tXEv+3JztHSmb/OIO3PECaFTmRUg/yyOLvUMZ9EBiQ9i53HZr3nNfZa2jf8FU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Yhh+jVG9; arc=fail smtp.client-ip=40.93.195.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Yhh+jVG9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QPNHp5YwxdG1c1MJYg2DLAk33ool+x5wh/9/W89iz9GOVKUeJFBFRbbdEPFhUAgA49Gevyp2yyiMBV9Wf9SrrTG72LcqkK/E8E8nPCsReD3YgWKi+1T0pqIjYyJ3KjOElqhddzKm6s3LCte2Qvln8uANCJDMBl+ERejIN2AaHPFUcGW9oVQFm6cJeRKpLCSTEXoRP2mpGBSDmyerlsTWyRANgehivv8TfzSD8clKNYyGk86K/9Xsk/a41XCXe7D1fynGII/nafaQrxFWqpZ6btiGdjqyGzbbN2QeO0lLsIL7ZzpnhqFoBUl7AXGODpFQVO3m7gb7YwOfvAHaZxfZCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rexcm2QAoYkkLj2ONCnxwjewkIuSeaoZ6ZuUoMhYlsU=;
 b=Bdwrhf8hkAKXr4QvXNxeSVwbLOLaGv4Xr9r0gCbE693w4AnLiaahGO+UQ1Ih9c0OL+5rWrvMW7Edfcrg5TaXuEV63b5dRNoB0BDCLVp3jpV1YZcYW/eHItvLpwWUBm/uXqfCtLHn2wywT2Z/lzxmGpZ79c1xEVV8n0kA0pPzQRHyGtavyWjRUQH30Y+FWoVayeljOIm8HL54N0xRWeaGsoC7ma3HBnO47IPGWKtsk2pTHltnPqN/vAXTmbf/dZzha+r361rFTdWjbsNRmCWVKYBM0S+5/wI3G+/zH2BjUGrUZ6ZGZeO0eXSHS4bUIyvvlpqxFIwef2z41MwnZiMYpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rexcm2QAoYkkLj2ONCnxwjewkIuSeaoZ6ZuUoMhYlsU=;
 b=Yhh+jVG99+8CIarNzbZQalkc49RdPbwV8G2A5K6wUuG7DBEVOSo35DYNpbwOU+wGNuFaXRGzbzkMSJh11+iKIG2JHowOZZblBJkncWqV4Zz78UbFYlqM6kHBA8TU3/lLf/jQl6q5gO60kvbZAA79elG/KhaFJ+TrxxsIkwFe5d8=
Received: from BYAPR21CA0029.namprd21.prod.outlook.com (2603:10b6:a03:114::39)
 by CY8PR12MB7561.namprd12.prod.outlook.com (2603:10b6:930:94::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 11:17:31 +0000
Received: from CO1PEPF000066EA.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::ef) by BYAPR21CA0029.outlook.office365.com
 (2603:10b6:a03:114::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.1 via Frontend Transport; Mon,
 12 Jan 2026 11:17:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000066EA.mail.protection.outlook.com (10.167.249.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 11:17:30 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 12 Jan
 2026 05:17:24 -0600
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
Subject: [PATCH v3 1/3] cxl, doc: Remove isonum.txt inclusion
Date: Mon, 12 Jan 2026 12:16:43 +0100
Message-ID: <20260112111707.794526-1-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066EA:EE_|CY8PR12MB7561:EE_
X-MS-Office365-Filtering-Correlation-Id: 38988bab-1276-417e-f5f5-08de51cc2d2a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dDYrUys1eXpCd0FnYXFienhMWFBzL2k0RWhNeUdjL1lYUmlXcXI1ZXF6VFdR?=
 =?utf-8?B?ME9vanRTdHl3V2pFSUMxa1lYQUFkZFlqcnE5NCtUL2VMcndWU1U5d2lYeXZa?=
 =?utf-8?B?VTE5V1hqb3BrZ0Nma2swb0VGQjc2dUFsUnlldG9JVjZvaWl4SFUyelNxSWVN?=
 =?utf-8?B?L21aOE03WjZrVldpTExPNmtyMnpzUXNtazRYS2ZmTjFJOXBhbmcyVXlqY01U?=
 =?utf-8?B?Q05Da1NLTDhWcDZYY25rV25xZGpvSVh2QVBJQVlQNXBQYVhVQzJwU05MN1Jv?=
 =?utf-8?B?aEg1aHh6MG1CWm1lYXNxRjZNbGFnRzVTRGxqL0NqT01yWER3UGZSdWsrV25V?=
 =?utf-8?B?ZzlpRVo2R0VkZng1dW14b0RMd2xVZ3FsOHYvK2hLeUFEamEyTm1vT1RyNVNQ?=
 =?utf-8?B?ZmlkQTFsdGJIa2xUS3Z6eG4zTmNQd0oveWxlL2kvbmpBOFRrOWMxNW4wUnB3?=
 =?utf-8?B?UEhKYWZkVCtxV2k1OXRKd1FjbCtCcUN2K0ljTDcwMEQzMjZ6OFY3cEpoZ2Ns?=
 =?utf-8?B?c0o5bTBVaWNpSUMrZnB2YzM4ZGN4VXBUUHNOdVhPZ214UWlBSFNaVHk3cGRr?=
 =?utf-8?B?aDh1WTFObTN6Nkxia1hZQW5tRlZSL2huQ0M5SlRsMlRiTjFqZjlOU0I5YXla?=
 =?utf-8?B?cnZLZXIzMFFJM282bjhxL2dzZ2VuT1FPejVKUGEzRDlHb2JKNkdlZVlJVGYr?=
 =?utf-8?B?ZUZsQ1g4NDU0VHpYNlFFOTJSaUx0VzhZSHN0RGVuVU4rR1NtNkVGRitnTjVT?=
 =?utf-8?B?WC92UkdNdjNncDNrQXo1MHZvS0xnc3hDZHM4ZTQ5QzlqMC85MGNoYTFOdnZa?=
 =?utf-8?B?ZTVKUm9iUTVZNzJMVDJpUmVmSlJJMU5tZFRNcWZ3YmVJU1c4TDgyaExOQ0RM?=
 =?utf-8?B?YmI0bjlta0ZkTFRIM2dhaVZ4TVNldkNGdEZrT2NuQ3VmbEdMN2xNZXJZWktL?=
 =?utf-8?B?akhVSkpGb3lIc0tURkdsa0dKUjVLTFluVFF5cDZON21PU1ZuNzlJdGl6Tkxk?=
 =?utf-8?B?WDI0Q3dBSjVObjh2N1JrSCt6dDhxcGYzRFZXSW5yVTlIakFhSTYvY1hTTkZO?=
 =?utf-8?B?RmNUaTh5ODNTUDF3b3RKT0xYdFBlR1JmTUNaQ2hiU2puSUZwU0ZHeXRXd21S?=
 =?utf-8?B?RkRMRTNaTGNqVU8rd3ZsNThsVjh6b05qdUNHV1Q2U3BWOUJzZEVsMDlWdG8y?=
 =?utf-8?B?YzNwYW5EQWFLdU9TTXhnS3kvZmdrcEZYUFF5MStWSEs4VW4vT0JZeGxUclM2?=
 =?utf-8?B?cHZwNS9QRnpBdU9nUnVzTlFmYVBYaXdHay95bis2V0ZCeDkvSUhRZ0ZiQ2ZZ?=
 =?utf-8?B?dTk1QnZHQUY4RzhPbHhJKzZYSkYvaXd6ZmFtVWd1N2tNNDUwV2UyOTV1TEIz?=
 =?utf-8?B?U0lvUFgzZFJNZm1IZnZsMzFGM21tQWZ3cGlqV201SU92STRkalkxcjJ1MkhY?=
 =?utf-8?B?SkpJeWxNWVprdHFsZUIvQ2Q4QVp1bDkwRTBiSHJQQzY0bkVyWHliTHd5WDZE?=
 =?utf-8?B?K1NuWHA2U2lXajJ6SmRqT0R5c0t0Y2h3UWZjTzVSOU9MMFQ4WThnU0U1azFL?=
 =?utf-8?B?cWVRSGFUUDIrbVJ5bU8zYk1JUEtuNXZwZWw3Q1RCZUM5V3BET0t3SnphV0xr?=
 =?utf-8?B?akpVVUVhb0VpSEU5ZmN1NXVJb1ZIYTRDMjlLcWVCajZxSzROaG00dm1UM0pH?=
 =?utf-8?B?SVhwcnZHN2VyNTJIS0R2Z0tOUTBoVUh2SmJLWkk4UFRiYkQ3bDNDWUlSMVl6?=
 =?utf-8?B?N2RySEN4TDd5bHNCMkJLL0NrZ0o3Q0VLZm1HQVNpZjhHY1ltVXB2b0d6ZzlX?=
 =?utf-8?B?Qk85bEVOY0Fib0xDSExjZnM0Zy81by9peVMrSVdJMmg3VnJUcG55VTFXL0NY?=
 =?utf-8?B?bVIvbmNVV0ZCdlRjTFRGa3pYeXZzdGwrb2MybFV2T3NablVBTStjdTJkOURK?=
 =?utf-8?B?SFN5SlhJKzFsbnBDNUY3VTFGTXRHMWhRWTNKTzhNdzZBYU0yWW1IYWc4TW1X?=
 =?utf-8?B?ZmlVOUl6dFJCWHZXUlFhckZobHlvZnNRR09YbExmSld1Q0tmZG5uYXZHQ2o5?=
 =?utf-8?B?Qzlma1pvNkRxdUV1RmVlMHM0UndmelpJa2xQQVFZbkgrMVpBY08vc1VNWnF5?=
 =?utf-8?Q?X07U=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 11:17:30.4815
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38988bab-1276-417e-f5f5-08de51cc2d2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7561

This patch removes the line to include:: <isonum.txt>. From Jon:

"This include has been cargo-culted around the docs...the only real
use of it is to write |copy| rather than ©, but these docs don't even
do that. It can be taken out."

Cc: Jonathan Corbet <corbet@lwn.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
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

base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
prerequisite-patch-id: fcc9f0989a8a0ddfc5b979a86fd04ba90d34f674
prerequisite-patch-id: b27213af275d8501ee9dcd3b479fa26ba71693d6
prerequisite-patch-id: bad991aeebcf3102ec1b148c51e42c5bbd93f914
prerequisite-patch-id: 5466ce76edbf31ba5f02bcfba6c20c254334e14f
prerequisite-patch-id: 33ff5825ef83d504c9b6aec51d215974c5cee981
prerequisite-patch-id: 6f2c9a7dde1b06d1edb84002243f7b1296da5220
prerequisite-patch-id: 06cf89ee6434715b32882cd2be671cbbf0d22ef5
prerequisite-patch-id: ecb6bc026bf30619067374fe1dc3801206ab2a3e
prerequisite-patch-id: 1a788c49a6a47bd79c0bd76908eeaee4de651535
prerequisite-patch-id: 9cf6e4912b1ded288ee17ed3ffb495398b93fd37
prerequisite-patch-id: a74201c87644da52714381962c1300ea8d66665a
prerequisite-patch-id: 5d9d06847451ac486363bce7927b9fd6e026cd2c
prerequisite-patch-id: 23603937a6fb6695282fbc479c0bbdeb5b627e67
-- 
2.47.3

