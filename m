Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010032.outbound.protection.outlook.com [52.101.61.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6E830C628;
	Wed, 15 Oct 2025 02:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760496098; cv=fail; b=DuAUe6EotcXJtf+4D/GNmr0Mzvi+bPgRRy5eCLN/g666eiKLHhNX3A8xiuQ0E0+eX0JvPOCWIfI+mX6mSeqAwNSQ+lUdvnGG7sRXquR/BJ/pdsjqWMaBYjQZFZyuXVYmgJAM+kMt/0clxBxiPp6K66niIN/Wu6geqG8TnGqxauc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760496098; c=relaxed/simple;
	bh=JuAmlIh1rYtgWst1IdURgO6G/M2ktaHjVGY41weuD7g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QnEI7ObTs+mXvHofi6PRyYMzieO1YtZbxRb/xKNEPmlrWwtrQmhLqH5JW+E4dv7jeb6ksUXnFQ20YTBeXAIfhV3KZtDJRa+3I0cnyp/cSnGy0EVXO3j3thDenm4dhEqnLg0HnaP6RQiGKNOSNgiVO1Dcr18nBYlXI45JmEOXF2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pJXCbgWQ; arc=fail smtp.client-ip=52.101.61.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pJXCbgWQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sh8UAzx1qeZgsHPLRwVa3fpqW7DasMy0RHgZYgNSBX80oVjFrSq7VHOrrV5HUoIXkuyICbc8vSGl59RXrb6VwMxibWx4J0H5ffg2aubNpIKUmr8N6bYrOKBnvfwIPkMzG9VKV492yyJj/re5zBxp2ntbdn1467ZEFz3oo4ULRhe7AX4gPkrUad7zOfd474tveF/sGzjug29ENDjnGMpvLijR4cFFNWWHgtOo0zHGkBS0RUfniOyzwr0YqqGKFUBUxyVNLm4LBFBin0ulX/1HWatjkaspqUqka0wqQ70K1cRnENYlr8Mdj60H595bw1B36tmmXGFOlMhqA2ZFH36CKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YM8hLsEVa4BU3QWp5S/40GgyvGf3J6kr9Dz9Fx+zuA4=;
 b=E9m1FlBWOx+PkArKQcvsoYLSARLA+l+OfiTj1HMsDXdgklcILUJxgL3rPjBOS2Z/ealSfFlXG9p5TScxA0yrni0W253PQC5z9kVReKJnr6qx3h6U4FLzKXYheOms+cLGoyINu8ywEkabVijYW2QtKmurPOGvKhvC8GLlBnvCKAO5sZISuKiN//7087wg3qAmK/ws6LON5GUp5BhcSYB2EMMkN57dZHrVIrsLQhxQk8pCPejtm+GOwHm9hvOZt/J+ubPoZ7x5C6/lPBVvxitloISBmFqKkj/eipOs64hl4piGdhzYxUn6Bs3vWnuTwYC/YwlAQmhFaiqUWVZKW0CpYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YM8hLsEVa4BU3QWp5S/40GgyvGf3J6kr9Dz9Fx+zuA4=;
 b=pJXCbgWQ2ZovQF2ScAWVf0MmQGESOUZ6Sq3Wch5wrJSdkTGj5EAIB0Aa1W14gt+Vo4J+jJiyDJxVUx8SyBhgsCO5zo+gxieyupvcXXREIM37c8VG0273Qj7NFq1+0kLbvzLd4Q7jEwkJvAMj884aHh4P1Y9slBZRCEPW/s1OX7Ytg70MpaxfqmkRh4IuYarzbrduZiRVSEDnHN9874x10oaB1jYaDLLaLKMILAWIwpamPlzAxscOs6BzugEOx5h0dTbOIV04pom1OFl+TI8uZIfRHToHEigRw8sy1f7l3Eci3Ojn/p+H9itp2rJAxkv8o2W61718JuF0uYXQ6re+kw==
Received: from BL1P222CA0021.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::26)
 by IA0PR12MB7626.namprd12.prod.outlook.com (2603:10b6:208:438::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Wed, 15 Oct
 2025 02:41:33 +0000
Received: from BL02EPF0002992D.namprd02.prod.outlook.com
 (2603:10b6:208:2c7:cafe::3f) by BL1P222CA0021.outlook.office365.com
 (2603:10b6:208:2c7::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.11 via Frontend Transport; Wed,
 15 Oct 2025 02:41:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0002992D.mail.protection.outlook.com (10.167.249.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Wed, 15 Oct 2025 02:41:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Tue, 14 Oct
 2025 19:41:20 -0700
Received: from vaslot-linux-dev.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 14 Oct 2025 19:41:19 -0700
From: Vishal Aslot <vaslot@nvidia.com>
To: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Alison
 Schofield" <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Li Ming <ming.li@zohomail.com>, Vishal Aslot
	<vaslot@nvidia.com>, "open list:COMPUTE EXPRESS LINK (CXL)"
	<linux-cxl@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 2/2] cxl: Allow zero sized HDM decoders
Date: Tue, 14 Oct 2025 19:40:06 -0700
Message-ID: <20251015024019.1189713-3-vaslot@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251015024019.1189713-1-vaslot@nvidia.com>
References: <20251015024019.1189713-1-vaslot@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992D:EE_|IA0PR12MB7626:EE_
X-MS-Office365-Filtering-Correlation-Id: 61889534-00f1-49e1-6718-08de0b945a54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bA79lANd8kPf90Az5me+HDCHS5RPB1bRfGB4ERpMwUkn9dKZmL3pzz1slDa0?=
 =?us-ascii?Q?ZKRu/L6olmrGqR3YfitWh8zpCF4nF9duaqm48YdCEBo9nOcq9kC2XXRWX2UH?=
 =?us-ascii?Q?gYsRZNSNCBsculBRoddBL1iFhgIAhdIuK8piuLt2j+dDSW5bLKtoucdoa0P6?=
 =?us-ascii?Q?AJGY6Ho3nsAwKJLF/Y5BlEUKWjHBMbg3rHcxkftmYRjRJy3Tkz2gITCALS3y?=
 =?us-ascii?Q?Xv8nI2lbytfhmnXhj7sc6CPXowdaz6rGPaId5crPZykfbwPqM4PeEZUnVXDO?=
 =?us-ascii?Q?8D7+Q6pcCBxlTtBVJhyOv4Q+Nh/k+M6Tub0NJgrYQ+rmshxYyQ2sL3cM51AA?=
 =?us-ascii?Q?31sopg0tSqmhrvoip8ZAkN8YEkYzosGdZ2AEiUE81DcBnuw6XQtFGW+PcwKl?=
 =?us-ascii?Q?AatX0jhMKV5aCajhQJ/Gfka2h1umiICT9W3ma2Vd+BS7Wp3jrkC6gMWKYxMf?=
 =?us-ascii?Q?OrqfFZJT8V2liqsLBhQhPHdqDjrUGhBq+4X/ImSWmqzpShzP4U7BJ6IWSjD5?=
 =?us-ascii?Q?GTl3IbZ/6KJXpceLqxi04MB/7muNLDqnE32yFwVZ3QpRk379u1dEO+gMKhaO?=
 =?us-ascii?Q?O6z+E/jOso0Lgx44R18JTB/VJts78jIwXXATiFYwg8tA30yyPMIIe5Px4zpo?=
 =?us-ascii?Q?l2myp3QlnlDhMbdnF5egOHPA4UdEVSvfZIyMqYGLmmz0/Hk5P5KURk68MItk?=
 =?us-ascii?Q?hCLmfpOl2VIqUL0u/hqIyXOO/usubgwZMqQIb0aVgdaHpfXRwjn7wlAJ0nvt?=
 =?us-ascii?Q?tHhoMbnpBXoBJ58NIKakyL07nizNPTncRq9DZEoAtJpf0oD0CWEGkeARpCCq?=
 =?us-ascii?Q?nxi0Q3XneUFE1pYG5qmAgdF4m1sjGGePS6zxadPzT+MldvobJDe6J2v+AlWa?=
 =?us-ascii?Q?rXxkCaq6zx+JY9SzU1L5kJlx1Bp1un0SB2+xUQ+fN3tiV1oltLulJPblKUNE?=
 =?us-ascii?Q?WqIrYTO/ANKcMJwLeLQPWWWnv/AEQnecOPb++e9MlxZX621Cjm/7JG5TS56h?=
 =?us-ascii?Q?DnR0NGcjHGU1eBBwefc7KxfGQjFUHBXrsNGClCPTBTFsx3tN/8M2bj7BBxCT?=
 =?us-ascii?Q?33mV4KmglH1NT30zB5gkYHRiWEfVN9TcoP4ulieHEQ9YJSu+HKOnZJvknlSR?=
 =?us-ascii?Q?5UQNG64CDGcu4yWRw1o20RekUiMeUedsgmclN8735QicKazNWkzCurynYhuf?=
 =?us-ascii?Q?qqDsDJaUZoZlM9Vkkzs/xK1s6UydlddZxvlPXmr+dsdBmUX0ncpPIWVjbPGc?=
 =?us-ascii?Q?kk0Fc/65o89I084civUe5sXhu955optT6tYtmhNp5HLDnuVoSIwgzPtsKkW2?=
 =?us-ascii?Q?ToUVdS8AvH1cnBiwl3H/XUt/r0bf2Lgcj8sLp8l9pcc94D8O6tqB+lckuAhm?=
 =?us-ascii?Q?1GFVWU4qckaQgAtjbkSvG7SYHZeAN7PhVpR9NnXcT2/LQPlwnTKz6a7oH/R5?=
 =?us-ascii?Q?ljcplW9vs/Ac4yC8fzZbgjbWC6uJ+KoZQd5ttzsbmwjM5DkzHl0mEJikWHaZ?=
 =?us-ascii?Q?CRVh8sYUZq2VG6rHAJlBmrecX6tbLkHJqjWAJ3NRNzf1y4pafMOKq5ih9fUj?=
 =?us-ascii?Q?YsjSYJ3OTiFqsihATDrd5CWR5VvRzT1ypZr8NslV?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2025 02:41:32.9878
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61889534-00f1-49e1-6718-08de0b945a54
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7626

CXL spec permits committing zero sized decoders.
Linux currently considers them as an error.

Zero-sized decoders are helpful when the BIOS
is committing them. Often BIOS will also lock
them to prevent them being changed due to the
TSP requirement. For example, if the type 3
device is part of a TCB.

The host bridge, switch, and end-point decoders
can all be committed with zero-size. If they are
locked along the VH, it is often to prevent
hotplugging of a new device that could not be
attested post boot and cannot be included in
TCB.

The caller leaves the decoder allocated but does
not add it. It simply continues to the next decoder.

Signed-off-by: Vishal Aslot <vaslot@nvidia.com>
---
 drivers/cxl/core/hdm.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index d3a094ca01ad..1c036a485723 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -1036,13 +1036,14 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			return -ENXIO;
 		}
 
+		port->commit_end = cxld->id;
+
 		if (size == 0) {
-			dev_warn(&port->dev,
+			dev_dbg(&port->dev,
 				 "decoder%d.%d: Committed with zero size\n",
 				 port->id, cxld->id);
-			return -ENXIO;
+			return -ENOSPC;
 		}
-		port->commit_end = cxld->id;
 	} else {
 		if (cxled) {
 			struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
@@ -1198,6 +1199,8 @@ static int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
 
 		rc = init_hdm_decoder(port, cxld, hdm, i, &dpa_base, info);
 		if (rc) {
+			if (rc == -ENOSPC)
+				continue;
 			dev_warn(&port->dev,
 				 "Failed to initialize decoder%d.%d\n",
 				 port->id, i);
-- 
2.43.0

