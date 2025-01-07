Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593681F239A;
	Tue,  7 Jan 2025 14:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259147; cv=fail; b=qUgs6WaMGIH/FxoxLhfaYipcq3OYAKiypxE8SJ8rEpAGOOms27j7Uy7pwP+b4Z7TdsllKhJRjzQuvgxjynWFXm452D+s7fvS5/exAPRm0VbppeojHO1TR6AeS4Rp5WZ9tstT8rgZhHayPHVdgeiwuVDEy5AVr+bSUFeVfRdjg0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259147; c=relaxed/simple;
	bh=Y8XUqli4PCwPiMfhS4fBrcAbRCM9gjg3e+km+xUfNu8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uY5vUmtIpKwZOv8vj2m9b6FT3Ycm1GDwj9LHLUOtXi+R9q+y/02PMOz/mQJBd6kuuuSoNwbEeBmM+nbV9W3BukTHR4XRtUiW2W6O/wNwouo4EKtoWPWq+RBwX5CqqQwcGGjtxasyNVGYTLgFJ4ZdS2xDg0r6vQwpr4RQXLcU6jE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Vswb4Zyl; arc=fail smtp.client-ip=40.107.236.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Vswb4Zyl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ybDkh7EMxMPv0XjbaE33ayP5I/WmUqzbNvSs6qCrqbNaf6T3VYjBfMG6sjdvthi6nX56Wq6etDNDRr0by2aZiDEXlrjT1sJWQWw3Wweobv2/3KX7A2DymLkKGSStWTG6LXPzVGJN998EjU6AcYw3nK7W8uB/9Epzg6Twro1Qu9LLXOCYtinkA7urQZTy0XkIht8p9DOqq1DApP5kJwjXNmiH/7sQYlVI1eyCs/8Mbl6dfbUvmU5czRgYKWd2iuYSrs6AiekmvrL/o12joslKOvNO4aQgNlbvxGoMIBOmMpcPrezQ6PMKICN9+96MQ523GuNWSrVml5obOoLiDQPzcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVloCcpSzCrE0aWSgqgROV7rVJsnrKLA1LX0aJiD1xU=;
 b=rVkRa0BLJEaCR9iWcBAY9o6lnFCMiZpOQ4TWWMd9MG/ebfUT1vK2YQZLKJp8116p5EqtdAM8gk3+Wmb2vRuSqO6NJrMNAF7bck6i+4F4fqbcmS8twXYJqCz5WJE9le4HfAoHE9OiOteM3R7cPcJxXGGNAUUtWIaikbKct1FxfXhzm8cY7wvHc9zidkMaecLelCD0pGt+LPT+J5HRHEAIv8liS0mC8QmiUUPRpyr3o/hwM8AM3P67EsIDlMGwBj4AUKQxxum19vDD0MKHIP6FIN5i6xOVHEajdmv42ldiqT94yh9JzJqbI6aR1TU/jtVt1Y6ZKlxLwRe1sheJOJj1MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVloCcpSzCrE0aWSgqgROV7rVJsnrKLA1LX0aJiD1xU=;
 b=Vswb4ZylxDv6G2KvMEuF09b+Co/ggERBWRoW9nNrVdQcZLBGbIG9PGzA2eFTE9X00MwaGsJMIZ+P9InokoMxdgjwCHq0OzU8fqMsoanv49sy4NQjj1vCg0z6H6x2rjyi8HYYOKGS6ERfJM5IwpyM9meIwG9UwvWhMFrIQYryOxU=
Received: from MW3PR06CA0028.namprd06.prod.outlook.com (2603:10b6:303:2a::33)
 by BL3PR12MB6523.namprd12.prod.outlook.com (2603:10b6:208:3bf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Tue, 7 Jan
 2025 14:12:17 +0000
Received: from SJ1PEPF00001CE5.namprd03.prod.outlook.com
 (2603:10b6:303:2a:cafe::a1) by MW3PR06CA0028.outlook.office365.com
 (2603:10b6:303:2a::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 14:12:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE5.mail.protection.outlook.com (10.167.242.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 14:12:16 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 08:12:13 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 26/29] MAINTAINERS: CXL: Add entry for AMD platform support (CXL_AMD)
Date: Tue, 7 Jan 2025 15:10:12 +0100
Message-ID: <20250107141015.3367194-27-rrichter@amd.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250107141015.3367194-1-rrichter@amd.com>
References: <20250107141015.3367194-1-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE5:EE_|BL3PR12MB6523:EE_
X-MS-Office365-Filtering-Correlation-Id: 4251a331-b920-4d6a-a9a5-08dd2f254a72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3rgvrc1TQ9mnxATFW6SmMXTxxKrc3rhKlX90/Z9HP7YTOFdwsJalxRY7U8n1?=
 =?us-ascii?Q?Xg6eFltOX92fDJZ/Pa7I9sV7hM0aqN4C6P+2APgsnSeEc2jd1jLiyscR6Pll?=
 =?us-ascii?Q?l7kOKNEvhUUKWfIMxkepToFveGFuK5IDo3aJdxcAj3cepM8fPeRmC7ZEL2AR?=
 =?us-ascii?Q?+axxJPv6bF4b7o3+9NuoSatX5yTJfDuaBl1OY03NTA4EG6D15S+y6mF6N3ZX?=
 =?us-ascii?Q?i/EudEd4Z8ywOOnqvQYrXbTK48vluwThC0mmb/MSPVMuYsVjf/0w1qiIjVsT?=
 =?us-ascii?Q?58yYzvS6rVLRaEQZh/ht2WUjdpQb+qQJZ8F68iSrRdtiZZ52i2zXQNpxm/o8?=
 =?us-ascii?Q?jWda0f2DVZH8jHhnoKilXB70kkxac2oaE50R2OjT5bbwWAlIqzhNuKE+An7H?=
 =?us-ascii?Q?oWTSGwdH3vZRyJCSmdxpYtgFhjJosamGVAs/usGrINz8VYLqUq4SPfKeewhl?=
 =?us-ascii?Q?VzI72EZNQsGWCmx2GlTAodUf/ESiZD4Yy6GlsRytr8ZfYkVhc0CiFSoMtTM9?=
 =?us-ascii?Q?0nNLsZu1dNjYrhkYNwpMm+Lk4jo73b6OwbjqViAto+82dKj3n+yxHRuwMYRV?=
 =?us-ascii?Q?9+WpjMFgAb51E5hk7ixB6UClY2h2Dmb+B2JUxHw0JaYXbV5YBrhiKM/J9HqK?=
 =?us-ascii?Q?0LIzS3Nuo5S2gTCm3pv3D+1cHBgsuce0RbiqERgSn6B0FLM0mObl5OVmJadv?=
 =?us-ascii?Q?VbSm4mz8bd3QoTvekGA5yuTVOdeU4wHy+eTQwtGzcvm91DU+WcZPssSyFP+R?=
 =?us-ascii?Q?wItr5mfUKhsFNcPtF2kRv0UBuPyZtkVj/Gvi6JDeSBv9bepNpRt/mGsqw9+t?=
 =?us-ascii?Q?u4NlexNFzWYhcw46UV7T3elHJoOY7pikYacei0aQFSf7vf4JljyDth1YmxDj?=
 =?us-ascii?Q?+g8Bk4a/VeRHy4d62faRkSwYVmXeVDc2q/8gH5Q6qk/tUO8ppsOmY+VybMNj?=
 =?us-ascii?Q?UApRHgZPvSKJsLU4GZ6SDjXEkRKaQOs0i53bCPRFj9T1YK/aB7uJUPgkrS72?=
 =?us-ascii?Q?Sd8AyDwZnD7T5epQ3U5ZxOHvz4VqdSKwNxQH0e2IlFgcqrfVgrJeftSguIhJ?=
 =?us-ascii?Q?tTR/mCGyymI+vEgGrYIom3WqtfPBvIb3aTCr2wevPK3AjeVfM4jyomCCv2ls?=
 =?us-ascii?Q?TDsgkcdINXW/v4ppGybyOFm/iYohMyhbguRCqtxF6eItirev6kfjStIrl3ea?=
 =?us-ascii?Q?Hz5CX+5MM3oW0VHfDrvdXBdmAaaIRTwFIeBaexSL7arHQelScFAykJKgwhzb?=
 =?us-ascii?Q?xZmQ2fZuBPWcxgmPsDf8iWmH6K9pxEXf6DMr2y6/D8g+T8LKwR9p/BM9qCSU?=
 =?us-ascii?Q?MNRgN/m8erAWoDhZSTM8IFvVSFy670zXrsskOFmwnaLvMAfiaIYDlZPiU8IG?=
 =?us-ascii?Q?ZcNfw1KH4p9O/9P7G0LA0QAxmlz4yubW8K97j1Da3555cWUBD+pMa60d0hxU?=
 =?us-ascii?Q?ZjbwSz64nJTRQ3cfbrrIiOkbn+mVcXXwhejmP3WU8/BlyWfM9ZxzliSdL553?=
 =?us-ascii?Q?x5yrnoi8P59LefY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:12:16.4083
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4251a331-b920-4d6a-a9a5-08dd2f254a72
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6523

Adding a maintainer's entry for AMD platform specific CXL support.

Cc: Terry Bowman <terry.bowman@amd.com>
Signed-off-by: Robert Richter <rrichter@amd.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 910305c11e8a..13791005995e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5778,6 +5778,13 @@ F:	include/cxl/
 F:	include/uapi/linux/cxl_mem.h
 F:	tools/testing/cxl/
 
+COMPUTE EXPRESS LINK - AMD (CXL_AMD)
+M:	Robert Richter <rrichter@amd.com>
+M:	Terry Bowman <terry.bowman@amd.com>
+L:	linux-cxl@vger.kernel.org
+S:	Maintained
+F:	drivers/cxl/core/amd.c
+
 COMPUTE EXPRESS LINK PMU (CPMU)
 M:	Jonathan Cameron <jonathan.cameron@huawei.com>
 L:	linux-cxl@vger.kernel.org
-- 
2.39.5

