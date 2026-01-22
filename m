Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011007.outbound.protection.outlook.com [52.101.62.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A63222597;
	Thu, 22 Jan 2026 17:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769102700; cv=fail; b=uDpqAha/4HNqddon1uebQiuXEBmKuG4ou4QAyC5OAgFG3E62R/AkBkeZ/KLEsRngXuYBx+FiHk/jumLBIybXOK+N9SUoiadaG+5XoxFvYTABjyz3sBTDqdYhABmX9LaPlK5apM2W8VUrYUPQTF81345mX7a1WgW5n0i3g1atw7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769102700; c=relaxed/simple;
	bh=EXoq1pCZZcWxotObjEHKu5k7JWXYvLUaaXUaQ6hVjPU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bUmXgDPla/peOIIKmN3Gwmn95WNmMwvHzJMNfscR/cyKbe+xhDe57P38EabfBm649vWROcm6v4p0eKMkgw+IuMUg93R6wPfLV8CSXFxJUulCzC1o8HBrxH+nz/fzMxPZw0QMpTSmua7shob7gwyA/u4F0WwC4rRWHg7E3oWeBqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r06439Lg; arc=fail smtp.client-ip=52.101.62.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r06439Lg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bvkX2GjzOvJUqda62qViQVd/dLrXWIJ7uNJKaBeZ+GBqm/UXzJiQXQW9hOi6rNMGSIAHFEZAKcRayJGsxNzTWs9ZdTM4lnRxjiWeRWJWPMNrwTGjA16EVumaeFtSYLEUYBfTbJQNZvTGf5auyRrYJR7D5tOahOD59upwY7qeFAzkuZKPYqC4Ut36JYf+UcqrlCOQWRYCCsooSyYGU09xyEC3My+6r2ePR216nOdqkJmIYeo8byopADMJsAwOS98Wvt5D/AEyNZXR8PvtokC6omA7y3qiDGamQkVM46vk5lI3AxhYwjOOpPMvNnhlc002a40nJjDhk/wVeS3UdceoNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ukmOzyUhw/XsMnmsfpPf7iECdYA4K5dm1bO97Gk6Cw=;
 b=Zn7TxzWyOuUBZsoQoLvgbV0LWKMivvuEO3Yi1Tlu2Q719iDLfDpo2G4iSafniyb56beux7KoHpLy9QDUtQb5MN7f/qmvPQcD2r5GavlVWsK71nFzzlELl981XC89nNH8O26PBSsCFpMA0+PVbVcuQ/ZDWqs9WvN1ZqNd5u/ZDRgxrocAMMhu45/8XhonIimGUXaeGel4K5JnZy9cAoWwzRvzxv7OhQUScrscmqJ+IT1FWBhJfk3tfOfdDnbe98N5m8i0SPx9z7dYK6f71Yn3k7JW4TWY/rz1pIqY1gt6p84Ocvu9oZIKj+f3QcsfS91ajxcPkRky2xPae3OlpVc+Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ukmOzyUhw/XsMnmsfpPf7iECdYA4K5dm1bO97Gk6Cw=;
 b=r06439LgrXrWrQfV79CbmTK7Np5+X+ZbCvpoGGa+GWiREKkzUL1PufTKoaxx4KlBMUIhlnQ9h3tOvH2nLgR5y098TCbeNLhH7QWM8NhEQbZSk3XEUE8jDtP5rk+VwzXAC/yJ1m5FaMHJVpkAWVWUSpwGJD1OeRsK6r1suBoWITA=
Received: from PH8P223CA0018.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:2db::28)
 by SA1PR12MB999107.namprd12.prod.outlook.com (2603:10b6:806:4a2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Thu, 22 Jan
 2026 17:24:50 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:510:2db:cafe::4e) by PH8P223CA0018.outlook.office365.com
 (2603:10b6:510:2db::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.10 via Frontend Transport; Thu,
 22 Jan 2026 17:24:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 22 Jan 2026 17:24:49 +0000
Received: from rric.localdomain (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 22 Jan
 2026 11:24:44 -0600
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
Subject: [PATCH v4 1/3] cxl, doc: Remove isonum.txt inclusion
Date: Thu, 22 Jan 2026 18:24:27 +0100
Message-ID: <20260122172432.369215-1-rrichter@amd.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|SA1PR12MB999107:EE_
X-MS-Office365-Filtering-Correlation-Id: 9203857f-bbc0-4c90-fa25-08de59db2580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZHB6b09qd1MrUW8vWFNJemdXOHgvVTBsS1cvVFFEaTluZTdxZEM1NlFxVXhC?=
 =?utf-8?B?V0I4c1czeVdQdm5oNTMyTVlQNWljUE9Fa29TRkxDSmtHaTNsV1E5VUhWZjhw?=
 =?utf-8?B?ZXVKbDZSTklRMFhxOE54NHcvSFdRZndlWkRoQVZlTzZMQzF3U2tXd3d1NUhp?=
 =?utf-8?B?cC9VSVFMQytHZDRwZG1oaWd1MmpmeDgxQzlLd1pjWXgrZW9TMU9MaTVRZHpC?=
 =?utf-8?B?amlRRzh1OWtacjNjeVEyZEgwWWphekZmZjNacVM4cjVBSEpsNC80QVE1anJx?=
 =?utf-8?B?NXpCWTZZbkpIUVAzM1FacmRjVXgwNmI5RzdDNjJCVDhPWVVUQ081Qm9FYXJ0?=
 =?utf-8?B?OUtZSkE3SzZLSVhLalZCL0tJd2J1UXVRTnorYS9hQk0rN1I3czZVRDRkc1Ax?=
 =?utf-8?B?WndacmkxTmNuRDdjRTBKVkhNS0pQQis5N3AyWGMzWFFuV1hSK2psYVVRTmht?=
 =?utf-8?B?QXE3WGNDbmwrOXBVTmZhcnc1RUtqeUduM2psK2tTaDdiRmNTQTZvNTJqUERO?=
 =?utf-8?B?a1N5cVFDUlViZlB5dzBTNHFzYzlaSExEUzBXVnJrSVFOem5aUTVldDFpWEJx?=
 =?utf-8?B?WjNxdlhFd2hWMjVmdERUUDFKdVFhK2x6ajZ5a1FQb0V2L2xaZ2VwQUtlVVdi?=
 =?utf-8?B?bVlFRzE4eTUyUFgyK1hOQURJQmhyTmRhaFNmYndrVnRnTFNScVJ5Qno3WG96?=
 =?utf-8?B?YlJuUVpUZTZXSDNQRkpnZWNBNWsrTGhsYnJvYk4rQUx6UUJtNHRqcjlFMi9I?=
 =?utf-8?B?SFBvbUlhR3JGcm1xd3hQaXd6S2t2YTJsRUU0dlkrNzZBVHN3NXVRNHc5NWRl?=
 =?utf-8?B?Z0VJSThuWERYT3h6VExiZWVpUkNoS3hLS2YzZEI5VEZtbE1ZMHg1eTMrd2Uz?=
 =?utf-8?B?MWdDT0Q5L2lMOGxyZkwrYnozSmc4eUJMNURwUjMxTG9kQkFpL3h4ZTRZcURE?=
 =?utf-8?B?dS9ocHp3cGthb0tYejRQeFRJK2dIUXFOYTVLQlpUL3ZSMW1PSkhTWUtjMFd2?=
 =?utf-8?B?RWlua2QzR3dTeWlHOVJvck9YNmkwWjlPRWtlYVNQSS90SkdhOVVnRzIxOCtt?=
 =?utf-8?B?dEhPc1JEM0hGNTZyQXpRMlZXVGhpMTUvK2VQYVZDcjhQK0NNU2lSZjM1amxi?=
 =?utf-8?B?UXpUK1VJeUl1blhNdm1RTVhHaERRVkgvWmQ4S0svSjVZSkpuOXViSGMzVXhB?=
 =?utf-8?B?M2hKVCthTGhKQjhPdTFpMldDNnZydy9yT3Z1QkF4RXVzd2tVWFE0M21VR1Bm?=
 =?utf-8?B?d3h6QVFjSTVYdWZseUhvMktsOGx2Mkp5VFlMdnc4V2w0Q25PTHRpV245aW1x?=
 =?utf-8?B?MEc2aWY3RWc3Ykc2SXg5cFcwV1pySGgrU3E0M1N6TXpwNVpZRThGN3d6VVJH?=
 =?utf-8?B?WEJNVm5jVGdhTmVGL2ZyaHVzV21IWjkyTTRtcnU3SnJmOUR1bGFodDJNREZj?=
 =?utf-8?B?aVJpTXMyODRGajcrR2JVVFgyelFkQUNuMkg5OVlwRkR4SUdXUG5ydjVUNTlX?=
 =?utf-8?B?VGx1YStRUm80K3FBVEVac2NjNGticElORUh1b1M5VlV6M3lCOHkybXVudndV?=
 =?utf-8?B?enQwblBnQmY1QXo4M0wvSHkrQlhCYVYrL3BLOFlMNkxMeDB5S2plWEF5R2xv?=
 =?utf-8?B?NnM2MU5xVis2WGtSZnZ4d3VtQkY4ZHR2NEZjZ3ZaRmIzU0Qvano0NXNFSlVL?=
 =?utf-8?B?MmJZT3NSTWYwS0FmS3JaLzdnbHRBNy9idGdPRCs4Q0VhTjFEQjF6SDltUkVJ?=
 =?utf-8?B?UnZQNEczb1pxUkdPL2NwcUF5UUxvRlFlNGRtbE8rcHpZYVg1TUV4WjBRdS9y?=
 =?utf-8?B?dHh0ZVBWa0I1cW90bUdFK3JmMjBFMDlscEp3eSt1QUpjYXlYV3EyUDUvdlFo?=
 =?utf-8?B?NVNVbmh2eGV5Nlo2dSs4ZHIrSkFBb2RlVjRQMk05RkNMWXBPUFVhQmVwNmNx?=
 =?utf-8?B?clpuUjNBQkVhS0N4bzNZRCtQYk90ekNkbjg2U3Z0L3BQVUl4Z2o5R3YxOVAz?=
 =?utf-8?B?Nm5PZDhIMlhOQWlIZW1oTW9PNnQrd1NTZkUxdDE0S3BSYWVQSklVZmYyL2pD?=
 =?utf-8?B?dGNjL1JDS05PYmpOQXI3djBrRFJ6OUgzaGlmc1FNY3JXT0ZYbnRRSjU2TC9o?=
 =?utf-8?B?VlBUS0o5TmxXOWVNUEM0ZGNSUytFYkxsNFRIbmpPSTdEaDArZ3RjTWNvaHhV?=
 =?utf-8?B?dzBWbXMvVHZvOFJJc0xXZGNlaTBoUDBJRWN0anRDNzdENEQ5NmtXUVFYcGpY?=
 =?utf-8?B?V0J1T1JOcjZ5dk1QSXM3c1pvSFpnPT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 17:24:49.4235
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9203857f-bbc0-4c90-fa25-08de59db2580
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999107

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

