Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A55A1F9410;
	Tue,  7 Jan 2025 14:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736259126; cv=fail; b=O7bUKrHYT3ceC4k8hrx9YTnvtS9nwGSiCotOdkH/Zxx8IiC7N1pRH534K2yodwpb6bDQX/GBQynbeT+v2XJHqW3LPtJnD2xGiZksuIwVCUo/YtF84qkP81kWs6eVuSJPuQKFy2GUxUbK38cqPCdSCoUudroc66FVkVCdKV8FYS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736259126; c=relaxed/simple;
	bh=p9LBCdQavmzWJ/r3GMF6qDmJZ5gnXuRVEtQL3R5JwHY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LPw1vaGdbm7GygJTYmyuGfofq2vhbtUiBoCJ4bMyuAKRY3/jOurYpBZPWBXYseMWPO1eTcPiKkopjg56LOSS54fCMpZpLsYLzVUGpGiNpMr68wtnkaD55Gck1HU6xyj1LYQljy3bJ1qfTwO0hhuSLMY/x1Jb8x0nOlnxZzfXTDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iQMCoy6N; arc=fail smtp.client-ip=40.107.92.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iQMCoy6N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wSDJt9tclKQZtUc2JG4sh5xA0gBsFOSpr4QGOc9LGegZCPzwFLz4M1hwj5P78KiXPxyf6HX3xhkqq5Qe6A4qENCrIx24evl34Smhg6flzVqzMQLkoMM0oxKVzbu46zaNkW4PD64gBfnMeIbpP/858oMCWYoZ3o/PMgBDMiWCroprZATswOAy3wExNbchb//d17oI4N7CHE4hw019wKfr8MRjzxAeEfCWXdpx3TGcVcgduWDivGOMrztlAWsBgf+O8OheZafLAlhfgk78ygN6EG+JZsFn1FzDG7iXErbxbeFUifYP8gOwLGTM9F8lp2rGVZ4W5TmUDvYErjMWvYbj0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OD6yd1nSYN2DBTO7TDrpObOgN34VJlx/dEokoA+1UPs=;
 b=TLAcUx1HQG9jwVHYlrGgtgf5qJp2RkWDHOUCXgxWYUSbbVz8jWY/kgqH0VVZkf43QyajfrenUb0StJ9x/6y7a4XenBIPnQGH/WMi4CZ3R73P/VmFGm+s6/uIvaRzN5XZdzt4jUQ2wZvdYItAmoJptl85ojXBBTk9Q4DIInRHqlaYxNzM+WyJO9Rv+S0o2EUIe2FQNcjnN7Cb6t+F7wwoD2QEdn+L9M75XzN4iMojV3muTaUO+Sq6Al4b26gkh3kd2JDsMK/xm/oEZHWuOAtNDcqXTzlwRT+m77Y0rrqubjBnuKOzUKuGA8pUlhUrLB+5wgsKeNMSdQBQkZ6clF9Qzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OD6yd1nSYN2DBTO7TDrpObOgN34VJlx/dEokoA+1UPs=;
 b=iQMCoy6NaLM6FrI5mLZlegYkd0fZzhvedjnFoh1QmAriGoHBXnuh0BT0gvD6Bphywkaj96/OHZWjtLsFugEy3lLb8fwaHJeJmdnZvODD8BxkRvYyTzYadR3ojfemsLZ9GV8gS33s58+4hdi0gLm84jOk9tlaFpnqYcldMdGfpVM=
Received: from SJ0PR13CA0165.namprd13.prod.outlook.com (2603:10b6:a03:2c7::20)
 by CH3PR12MB8581.namprd12.prod.outlook.com (2603:10b6:610:15d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.10; Tue, 7 Jan
 2025 14:11:58 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::e) by SJ0PR13CA0165.outlook.office365.com
 (2603:10b6:a03:2c7::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.10 via Frontend Transport; Tue,
 7 Jan 2025 14:11:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8335.7 via Frontend Transport; Tue, 7 Jan 2025 14:11:57 +0000
Received: from rric.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 7 Jan
 2025 08:11:54 -0600
From: Robert Richter <rrichter@amd.com>
To: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: [PATCH v1 21/29] cxl/region: Lock decoders that need address translation
Date: Tue, 7 Jan 2025 15:10:07 +0100
Message-ID: <20250107141015.3367194-22-rrichter@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|CH3PR12MB8581:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b22c775-b508-4141-fee6-08dd2f253f3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RYTxV8QFPcHo4jkZevFgWunVVmQc1WSFsHYnX4+CfS8ITVtG4NBwdOo5SAl4?=
 =?us-ascii?Q?m51ulejMS/s8zLar185SQ3Y95HnIqj5vOOy+uvJYIIx+yYJmjXCVH3/wjeM/?=
 =?us-ascii?Q?K0xTmBuucAPEPHCSepUQja+7F2hQoBveOIyTnyzPw/hWhDgrEOmSDvL0Yf7f?=
 =?us-ascii?Q?Q029vEgeCki0VPsl6N3MnPj1wRTbh+Tk8q3pE4V3TPyTenH7Q4jyLWkF9Pu1?=
 =?us-ascii?Q?Qy+ELemoAaJYoRvRydRZi83xr3fMWOdQ9zWamHr2NW1GCXzzCTky9wANDQO6?=
 =?us-ascii?Q?3eCdSLMdyHZ1RKPS2SJOmMbRu6HxTgMo9qEc7b6pGZbJabcNpaHsuYijrBfP?=
 =?us-ascii?Q?jplOnp7lVbs+Sl0+i04AMCQiJc2BvHXjnkrH/GTVkh0jpFe5WTMphMWABSNV?=
 =?us-ascii?Q?xYY4GFYx0la9PJ27aYR8z9PBSd4hqpjSpjV87pwdvteAB3w+jBHwKEclZvpt?=
 =?us-ascii?Q?MwxZoqflBM5Yb4OX8v9TLWgRFuE/7cxpWJsPfGdWJT0hje7JYi6wTOx5jHMv?=
 =?us-ascii?Q?o7ILgAra866dzZcs/hvCU6FCLMNVkZT2bmn/Q9zsmAJhuNzdxms8z5Xzpthr?=
 =?us-ascii?Q?zEe1I21fK5K5mmDZyg2Ouw83+VEY6iIE7dqiMaq3Dr/epIoCwtReWSwu1l5Y?=
 =?us-ascii?Q?ja5WGS8CakEP01WATLyHnm3QYEhdlRsfEKHv8REXNCyVcQ1NhK8j3jRaLI1p?=
 =?us-ascii?Q?aYBPKumKnSH7IweVIf08T8WZqdy1+QLLcarHglXsKWRx+20+kWxdQYXn50Sy?=
 =?us-ascii?Q?c+lKNqZph242lkJGpewl70lLKl6KneKzgBmSp4dVq6B+yjAQUP4riBgss42c?=
 =?us-ascii?Q?BAGOq15hLZuUbWxrHvQc6CgGgI1Z3v/5YC07FI7M8ejWX9FpteH13jr2y3GH?=
 =?us-ascii?Q?UTrt0BZlXQ8SPY7lm3KCIEtMUfus44RukacO6xjyrxJDogumQyHgIa48vz8v?=
 =?us-ascii?Q?LoSUZLiu+Mtjudgi6VjpnjqC0QKsFsIIhsGjWBSAyWUFpOey9tg+Z1KBHpFk?=
 =?us-ascii?Q?Q20ty4tUq7SEY7Ff3iVHvWH4jNLqyv1en+fYjIMAhWgSWTJs0ZzvBs77IVdh?=
 =?us-ascii?Q?lWXTnH7wXC8y5YulvxAjrgeV6Uo8H4OAocrm2p0VxI/D5KvzRUeg1n7H4E9n?=
 =?us-ascii?Q?6UaX39Jw6Qg8GPG8K5JR2JTtCiuzpmEjA/G969Lrb3kQhcofi9I3aZC0TJVL?=
 =?us-ascii?Q?XyQ+F8cCzqhbivswzHadOLtI9pqu6bECign4uDUuV2rIXipic7Jf0+fbqvvq?=
 =?us-ascii?Q?X2Tei6QI27zyTjDFRMPO12aznc/oKPWa3vlLCC/GsORIyrw1Nl6XXOqHO5FQ?=
 =?us-ascii?Q?0Ujqw0EXldx85F0WxiNAw5zl6LEjQU9UH1o9/eBpk4FQTVvN2ZV+zNUuiBRC?=
 =?us-ascii?Q?n/2sE1BR7bqRwB7fkljI+bxDa4elXrbGT+X+kul4ONlIYEcoGgxA8Ay7WZdx?=
 =?us-ascii?Q?knFMTWwR3Rvshqw5qx6RyOqCd+DNsyCrDw/S9L14pzq/uJNvRyVO3JUC5VIi?=
 =?us-ascii?Q?dZJg0J/RCPcxLg4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2025 14:11:57.6370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b22c775-b508-4141-fee6-08dd2f253f3f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8581

There is only support to translate from the endpoint to its parent
port, but not in the opposite direction from the parent to the
endpoint. Thus, the endpoint address range cannot be determined and
setup manually. If the parent implements the ->to_hpa() callback and
needs address translation, forbit reprogramming of the decoders and
lock them.

Signed-off-by: Robert Richter <rrichter@amd.com>
---
 drivers/cxl/core/region.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 8d7893878362..681c26abc26e 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -3353,6 +3353,17 @@ static int cxl_endpoint_initialize(struct cxl_endpoint_decoder *cxled)
 		if (cxl_port_calc_hpa(parent, cxld, &hpa))
 			return -ENXIO;
 
+		/*
+		 * There is only support to translate from the endpoint to its
+		 * parent port, but not in the opposite direction from the
+		 * parent to the endpoint. Thus, the endpoint address range
+		 * cannot be determined and setup manually. If the parent
+		 * implements the ->to_hpa() callback and needs address
+		 * translation, forbit reprogramming of the decoders and lock
+		 * them.
+		 */
+		cxld->flags |= CXL_DECODER_F_LOCK;
+
 		/* Iterate from endpoint to root_port refining the position */
 		pos = cxl_port_calc_pos(iter, &hpa, pos);
 		if (pos < 0)
-- 
2.39.5

