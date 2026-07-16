Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011022.outbound.protection.outlook.com [52.101.57.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13B442464B;
	Thu, 16 Jul 2026 17:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784222027; cv=fail; b=PDBRBnm0FGPz3+eP0elc1vRV6A70mKEvXuz0e43rphV4SDL/YDBbvKJwTNY1+yNNmomqHqaiS6y98dzKIq1mvlwU79wauVDakLA+oLWk8QmPdOy2oxGSks1C0DUZIkq1GrvqQBu8EhJSMyYCX+9p2BfmrgE9rbrmsF0OuUX+4xQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784222027; c=relaxed/simple;
	bh=tI2pZ46MeuNMEi6jGUfRNzSF1knzEL7Gd3VNDQGVwM8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NI4Fp9I3l000IwiiJvsFKNaL2HKYGxaBA5A4K8kYwrTNne+WTBnalohUh9Nwj0Ozx8H0Rz2l9MYl9ic0Rl3ZLszL14xuSs2N+QgjlmbXRBqlzEoQGF2Hg5mVN1N2LDjyUS66TY281EBhQxoFklOxg1Y84wN4ODTAXLyaaTa7zEo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g0otGVlp; arc=fail smtp.client-ip=52.101.57.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g0otGVlp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mjTsoFhvhtO2IhKTK8V88JrcWhHhMLp+sInnvYOqOiC7qeT8Lh/dX2nruss6pBx9S/WWp94E2SPuJ5zLbUUWLGsZtUlxPWWzD9R1wn2MjYPM13OSeprITtBk1qiF31F2MsurzoXV5OZsOnhG11B9DmmWcXIAY02Yxi7kf5LB1Fkoq6UzhBorc2zTeDS5kRvxeI+ZEJYrqQkmk5OoY2YtgohLcfnVTlVJ1iPnxmZqydzLyZHsPuNAF7HAyDGFB8A5IbX09ByHlsRkW5RjG96v5aqY37Tk5kcVP1gbENCvXU1aIbWppSv5Q8qUpn6tBbnAeCOxBuDLK4ll7odkUqzPVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9rvY48xg8emahi9xnLq8X1SeM2ZX94/bD6ipUvrjTvk=;
 b=DzmY0Z/n/pU07YMHsBIsYINTBDMKGKbAyMsh/hW0dDxwVqdmBXyncw74vQbru6modAX47lM4W3yHGSRTa5GVBa4cqO606WS+oIZTE/RoxadT1ygFhcOzR5BmhXPLUnGKmilYEB7iOVYv02LWCzIo0tWw1fA4S7dZo9ktiTdAMmtloUK98Fdi5DCRl1ZCcgPEPnj2YjmYvbmeD2i7FRvjyyDYK9wK8G4Dcvu1qXtGEYYG/U5xmV8ov1EHogcxUaUMm5He+12SFNNz2W+9g5o3P73/4a7rLHilg59kNIrlgkP9pussPVWBXvQf+P/OO8Zk6guTfu1YjHKJcDInQYoZJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rvY48xg8emahi9xnLq8X1SeM2ZX94/bD6ipUvrjTvk=;
 b=g0otGVlpcrbgHhQYtVFaGGCvbf87cWlQTbaQ5lxQw3uG8EZH5hoBiDaMWv+guRnJf/s/6zgqa+emx2oNrmm7jzaPX+GwwqEPZp18rHL+U7Bf+JOhsVy5vi0335m/JVYaxsGSO5w/aFjaMFXeu/HrgJv3zSieHmQxRKijW5CPMvI=
Received: from DM6PR02CA0138.namprd02.prod.outlook.com (2603:10b6:5:1b4::40)
 by DM6PR12MB4404.namprd12.prod.outlook.com (2603:10b6:5:2a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Thu, 16 Jul
 2026 17:13:42 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:5:1b4:cafe::99) by DM6PR02CA0138.outlook.office365.com
 (2603:10b6:5:1b4::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Thu,
 16 Jul 2026 17:13:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Thu, 16 Jul 2026 17:13:41 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 16 Jul
 2026 12:13:41 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 16 Jul
 2026 12:13:41 -0500
Received: from galena-46a8.xcblab.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41 via Frontend Transport; Thu, 16 Jul 2026 12:13:40 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
	<rafael@kernel.org>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v2 0/1] Fix hmat_adist_nb for CXL
Date: Thu, 16 Jul 2026 19:11:13 +0100
Message-ID: <20260716181114.35962-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|DM6PR12MB4404:EE_
X-MS-Office365-Filtering-Correlation-Id: 90cd695c-465c-438e-bc3d-08dee35d95df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|6133799003|11063799006|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	pb6gthOY0/dbLBNxQWETuwUSjm4p4Z1anDv8VxYWhLHYDldRJqnsnOHV+9pJOZ+b1+HW+jJ+a5mFijRe6KtP3WZ+4gfOwMIOID90X5Y2ba+WT+5jrmvMM4BOYEaDWIp532uIW5up+0soNc0y9ZLHTRGkaYRPXcoQC6NN8eTJ5xH8XYbhDuGiRx6+TJM2WKZ5tYf2vjBLtwgoO0E6lzyUc+CxxOKYwEOEnYRaxUdZOfGc3V7WC5hfJ02Qv/WuH/BTDIMz6Wo+kifQfnBnoTRHqs4+PltrGoY9uxIauAl46rtSAWDgWo2VMWUhHBvwagX/bb2PsPFYX7GQIseQdhjCILN6j4A2ZFwCr3m/6Sl3Ny5yYkVj9GSyHSNY469ZIIXFVPVClys9MCctjwqD+iFK4sq/SAdfvGuetbZ8lK7bDSa0C/jB6MRNk2UQBMJHSxE1a31Ftooe4/xfQ5elSxlQBpoDctXgrnuzI1VA98ZuErnvIFjWEqTnbXdy3RdJ+VKbXG5FbN8moX11UMFr6k7vdx9u+DVQn0sUyvmb7iCozpzTTG2KMU1Q6+oXYWUa2VdwOQxqSOSQ827bWjxZ2dx6SB4WtO6if/WNC4aw+y21p4dKUr+FdocLT0Mfra0716k13PecR0qYmHRSNd2N5M81on0hP5kdc6W9LYuMy62TWP3//ziLp7ZCCeFxrEHVvbUWLzc8g3JR8OS9f9b4yjYy/g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(6133799003)(11063799006)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HuVGi3xRS/V9p6F4hvSOemWyueCuRZmFSIwevMXmnuMOqz43wjNE8M1s3WQx9Z5RQehWWLXOfdgiDp3OcDl9avE3uTRJI3rnnvhc23Sj0iOpXWoMzJhh9pFjB9a9B4T6STLeMI9zrdzidDdnYi1BWtYjISw+LMVHuCUHFqtuO3PzhE/99EsrL/eBiPS6j8owumb05F3OHQ2UedW41lhYBbi4FKlYUlAq0rEh8GnXuT+Y8e0yAh69JTfPj3aYTX9vnDlTjXGXRTOnHDUyAflBU7KjsWb1nAENFm7hkFxsbjUTYm3ygVz/9ks9b7RkGTFB6vUMnJ+fvMsKnVpiQvLghtZ6d5m9am1PcwMA+W4TSQnK3gCoumPP00p1tXeT6TGMe+6gJyGduSmX6Ls00Cu2AE4YfFdVNkYeIASF2FHwWxeXuhKEFfd/vsF/vuLPQc1m
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2026 17:13:41.8237
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90cd695c-465c-438e-bc3d-08dee35d95df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4404

From: Alejandro Lucero <alucerop@amd.com>

 v2:
	- Add Fixes (Richarg Cheng)
	- Change commit as fix for Type2/Type3 (Richar Cheng)

RFC
===
While working on adding CXL Type2 support I found a problem with
register_mt_adistance_algorithm() which is used inside
cxl_region_probe(). It turns out my kernel config had not
CONFIG_MEMORY_HOTPLUG enabled leading to the hmat_adist_nb notifier
block deleted after kernel initialization without doing any notifer
block unregister, leaving the notifier chain unaware of this. A CXL
Type2 driver can be load after kernel initialization and with a kernel
not enabling memory hotplug, the notifier registration crashes if the
released memory from hmat_adist_nb is reused.

I'm not sure but I do not think this can happen for Type3 devices
because the related CXL driver is used only during kernel initialization
if memory hotplug not enabled. Type2, aka CXL accelerator drivers, is
coming and the problem will arise with certainty.

I have contemplated to modify how the identified __meminit and
__meminitdat are defined in linux/init.h, extending the case for being
empty definitions if CONFIG_CXL_MEM=y, but I think it makes sense to
only avoid the use of __meminit for hmat_adist_nb.

FWIW, a Type2 device should not require CONFIG_MEMORY_HOTPLUG and its
memory is currently initialized by the BIOS. Maybe not having memory
hotplug enabled is unusual and even more with CXL, so another option
could be to enable memory hotplug if CXL mem is enabled.

Alejandro Lucero (1):
  acpi/hmat: preserve hmat_adist_nb notifier block

 drivers/acpi/numa/hmat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


base-commit: 8cd9520d35a6c38db6567e97dd93b1f11f185dc6
-- 
2.34.1

