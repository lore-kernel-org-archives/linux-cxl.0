Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010055.outbound.protection.outlook.com [52.101.61.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2171952F29A;
	Tue, 22 Sep 2026 10:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790071972; cv=fail; b=eIMs95BWJMWnzGDJcJjxxxbbX5kfzawQa+S4H5+PuXAKKfby3kedZGnv6SYJGlFmfZAwgny1COHyx+EeXBlUAtr9Fha/CsOlO6MRPdiVyJdDIa4pz7nxEDlAVdsBj202PMXeuxVvKpl4S2hmIuVoXhEDoszQX9TbUBssnOHLQmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790071972; c=relaxed/simple;
	bh=GxhS0k+c98Ncjy3Wi6yjC2WuNl3uDQXMO9x49VGnl3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RTq7UvHA1zDUKWWondk/d7oSnJTYHW9a1nrEgIk86VDClXD79LEZB7P5KcXcb8mzS3bh7c2+awyxZdG7Ytl8BBy7Z/hHZS2LYsg9cbJbFDls2FoBp+A6TEmsofoh98USSKMJhq2CH6N7aPSFSx9OqCqwi2LzVeWJjh84g59cY3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ex/aKVD3; arc=fail smtp.client-ip=52.101.61.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ex/aKVD3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pc4GTWMU8nohMDHwLgsPnpGuUpxIwcXmpEbpvzFQzW19j5kWUWxxFZU3XtvGapmj7c5f3zJjnQOIZUEDkhpYEv6ITdZSEzj7aQ6Ke6yxpoD4qqMAD3zMnlT0d8D+58TRQlREYTcjuu6CV/tivvrxNcrjOIjtKjkgBuYYpgUCv/njKVpbPFsKgxdCJM/uTnnB7Of8cqz4l1+SH1D6ySb+9f6JYWVIeZ4mq7vIbBMxPoNZAYgHPb9Wb8YTOfrUt33HKrr+ZzgpH5LsKeED01vTTibj5xp7cp5LRzHyBnVq+lsTZHIkZ90j136Z4yWPO2Cp2prbMX4HkmnZVQ4bPYcAlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c0baA/HxT9Gyc+Su278SLqdXdOxnQ3Aa6UJyT296iMI=;
 b=XwTnyZ27cbT/Khnw9gtkAsYqWmK1f/K9WVcGOGslQqDQyPcN858ctkwJCM5ipjVFiV4U5c9thM6luAEHG29qVsDcz0tGBy8Pb1Ia4fNxxRnNlsknJGZ3UZRoxE3krhzppADgiWykS0P0+haFHtBBmqWH8Auz0j2AVpArkHpsP2hZv0nPc2OzMOnG55MNwkceRDV5WOobkdYVPKwc7QX4QJ6wAhLmyQFN0fJ6bqcQ1J+zkdd9TbvJghtzQyesqFpqP9lSi39jRrSD4zLZMDEO9H6/WChtYyWqYfYHiVzWYUzgyrjOYsa13zFb5Pr00m5snokxYn+Zy0MOkMFwvgaEdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c0baA/HxT9Gyc+Su278SLqdXdOxnQ3Aa6UJyT296iMI=;
 b=ex/aKVD3KEiBfzswDkwK77Dq/gNhxVZ5TQMT9cPxwH1OKlfFnmeKh3WAecL9uII5i9dJ3dm9S6X9f/Phi6griUC8WXX/mPe9fwD++m6Sk4CQZArBlLfAWAYOX9eic/ro5qzxWh2iX7b7gL+2j1TL9E+W6W9HuMLM4ui84ZA4UJ9qp4rZR9PCeqowh1s4o0QctJXWw+ys64svv4zNSpPTCz5u2WZom0gtKhju3hSXZuen8ZlBZqh1UeqOdNegqhhl+WGjEPvjv+g/zYOJEQND0itg8dMwrf7oLSPGEUHB0T+5XORoEWP2ipLhaSLlHll/b39SB2Z7DwqdguyJkOrH8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SJ0PR12MB7006.namprd12.prod.outlook.com (2603:10b6:a03:486::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 10:11:44 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0428.014; Tue, 22 Sep 2026
 10:11:43 +0000
From: Richard Cheng <icheng@nvidia.com>
To: jic23@kernel.org,
	dave@stgolabs.net,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Cheng <icheng@nvidia.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v8 1/4] cxl/region: Scan all partitions for unmapped poison
Date: Tue, 22 Sep 2026 18:11:26 +0800
Message-ID: <20260922101129.52794-2-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260922101129.52794-1-icheng@nvidia.com>
References: <20260922101129.52794-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0002.apcprd02.prod.outlook.com
 (2603:1096:4:194::22) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SJ0PR12MB7006:EE_
X-MS-Office365-Filtering-Correlation-Id: 963bc6e9-ca61-4b9f-fe84-08df1891e6fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	GsJy3uGLDqqtDRLq4r1vve0Y+E+9p1F1v2+ye9PzDIxmyaiIoaPVOfi7S9dxPNdkal61jbLOZIEOD/8NZ15kLXJhjkKzCcERP5LHUUdk8U6rPQMO7pHWNtSB7qVYEvlBSeuyEf/uZweV3bGEOzS2XlpSu+qFQS5KX49TLieN0uNLwYAGhzUR7N93+Fz+Kv2qNGAWyiHbUOUsXtcISPwyw/E7Ex/n9Dmw/joPdSArvpxmXwaOtYsBtYDEkEhs0ajHzv2gtFmXK21AHZ1OZDxJh4jEP9B7ppnPsoicsGwzJJi3JZSvQfghfIgRY36D7aki9pbzf4bhcmfW5xlBqsg9FTYP3vrTutbttoZttiUIZmQQqEfdokxQ8iKxApsQzdjdfCZDeIxSCF4Cx36x0I/izWrZ0YbyIMCELKtmuiX7xQqxeZUVvguHwkCHvSNAdsdxV84MYHcPAHceN+A0Y6g5NE2j6nEMC4DgKmevOq8GT85rdo7P7WUQ8AhH+bRrsUNW6zr50MuMqA6cp7SAawaZmb3blDI2vvKAS4oU0PkVaALijm2asQe4y9SvuCvd7hFLE3gRKpQ5ozT06xTb8YBEuwuuLcDlPOqFOVtZvkc+/QJrcg+o/xu/+u+b0g0hr3O/IgIxMWLNRB9X0D0wDhkD8eOUR8ephnCGnPbEVjGL2hg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UtLjsMC1EfF8HF0pVMmvIyhmwtnXGaX3qG2e8t5KNhlDXlmf25KWZVPU3y3O?=
 =?us-ascii?Q?K2hd8nOQ/nA4eRTFn8JOTh5wZptclErFhfsv1Jky3/OkQFslZUpXgbNOk4h+?=
 =?us-ascii?Q?ZUZApQrjn45do7oQgcoHNHnhb13o5oh/ClTX0xTw12T5FAgRegJUCCC7v1ge?=
 =?us-ascii?Q?nYeJcDRnXTFq4bYjv+oybKCxgxJY4ilwvCk/RJLPzuiZzGj+x4haJ2OYMKFj?=
 =?us-ascii?Q?sYMK/vfi7AQx85or81jD/uBWipLGsPUDlbNmMvdkFCbPOd8WXHA1Z8Ue8nax?=
 =?us-ascii?Q?wD1rlNKW0QlNezADAOyrb09c6ffaBGQ96xXkNyTV4tpwO7hnLj0aO7Peve7G?=
 =?us-ascii?Q?nVS+oEb15TuS9XdiAG9Qx1Q+i/3UjHoBLb4BLDsq55ETSYswgBltPTOh13Tm?=
 =?us-ascii?Q?nru0dOp8Sa3vA2TI1gMFCz/WXNyBnpCD+NtJr6ULxp8TzhMljwQCBTl0dJ3V?=
 =?us-ascii?Q?K7rlihZJT4ytA87LZRa68rV/QUJbU96D7I//JSdEzgUby6K+1t4F8M3B37MG?=
 =?us-ascii?Q?D0iaaKcHlhRebSFSp9kXlQGZamvdYxKdktnsXa5oskkN3+iZyF8HcVDxlTmW?=
 =?us-ascii?Q?p2BdOYrRdCTDE9Z0Wl7GC09wr3J3bA18Ilk7kwXfgeVFKSnbXqwxxFcvd5Pk?=
 =?us-ascii?Q?ms3cALsMw03R3n64jttB9GmAF+5nBo/E8CvceQXp584DRewnonpC+MWwVs72?=
 =?us-ascii?Q?O2PNLsn58JuD1vCadfo6QYuJ/mhlyzoyVCOji6onq/LU75zRcsbGcqRjqAvh?=
 =?us-ascii?Q?ENwuXuJWdMC7gKxvqU0Kx1pcMRDLPFsXB/0DjibUn6RK9iwzqRosigMB7tXS?=
 =?us-ascii?Q?o/0ZCE8drOL1k5pCgiNtskDAcFfc9x1noi1ATBX6nhKPFk2YwAbgbNS+HkAs?=
 =?us-ascii?Q?9gGKAA+zsuZqEUHilEfaHzscH3vUjMzhQGDe6LFfWcXY+Y83xg1pE92YNjNi?=
 =?us-ascii?Q?fTB8gxmPAJmV5b0VZ7IyUekbT/8wlnQO/LCiVbm22VoSBui/DsLJdrhcDc4A?=
 =?us-ascii?Q?AS83yLsVyniiYX9Eh4IRJkeajmeavWi2lmuX4Oi0wVQrHiH87h8Vr5w6mGxe?=
 =?us-ascii?Q?r/kkjd1snRPgtvASgTVsEdG7egL5+oZ6Xl6w4FlSp2D5/uv/54Ca+IbiPNJt?=
 =?us-ascii?Q?YpDI8L1xHRXyQd0d591vI3EBTBjgcAuW/nQjsO1vIafYf700oTh62nNTWSuu?=
 =?us-ascii?Q?xzG+ZPcK0kBmFzq8BLqSmgYJ9Imn45nxDoCckRtlOmDVbhnlO5ZCZkrKrVUl?=
 =?us-ascii?Q?xpfZvbJGS7mmHq8yvywQGg7FILBg9Zr/+bWdL3N+j9KS4lQCiSf5N0EqDSsT?=
 =?us-ascii?Q?06ffhn1g4ZZhpiHKhzgeth/bJs0049oxTfmI7b6JDpj96Ejx773WxXK7yr+9?=
 =?us-ascii?Q?fK15qhZW/vXy8Ck6/q6du4ZnMmND91BYMQy79RQYycS3cW7mYffKVRd1RWR/?=
 =?us-ascii?Q?wV7P/o7f+OsqQiZ4HhmfQF5GPX1QMSyCxjjGoRTGsYL/UGg6RZ0Cf3DvTbwA?=
 =?us-ascii?Q?24N9v3EBdzbpT86fkeTViuuSnGrcWehlI9ngFQ1PhPTzSY1pMCaRhaoSwA3f?=
 =?us-ascii?Q?9qBTkaVDJnrj1ZqAFXcVnSw6ujTroo7cW/QSrPbg75xQluF9IkGNLlOiwcI5?=
 =?us-ascii?Q?z44C3glb4xZAsvcxqNgCKTXtuzIm51C20Cr+A2RpLGCoco4cWc1pK2ObHsgQ?=
 =?us-ascii?Q?BtRCECUM2qTYi/xgsqjzQv4+R0iR8RKfa1o+TRCcrAZKfTvXci/hIwsTlR52?=
 =?us-ascii?Q?B6oawCKQGg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 963bc6e9-ca61-4b9f-fe84-08df1891e6fe
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 10:11:43.8008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iSaxSujGq3xY01oYIgsMcchwJRV3s6Sk4mMameMtjFqHzlPD98EXeU/7gbeUhb0Zxh7xIRf+hnlL+jymGNQhLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7006

cxl_get_poison_unmapped() sweeps the unmapped tail of each partition
from ctx->part onward. A fully-mapped partition has no unmapped tail,
it's a normal per-partition state, but the loop treated it with break,
aborting the whole sweep and silently skipping unmapped poison in all
later partition. Use continue so a fully-mapped partition is skipped and
later partitions are still scanned.

Fixes: be5cbd0840275 ("cxl: Kill enum cxl_decoder_mode")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Tested-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
 drivers/cxl/core/region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 5ef0ca0694ff..7c7287315d72 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2952,7 +2952,7 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
 			offset = res->start;
 		length = res->end - offset + 1;
 		if (!length)
-			break;
+			continue;
 		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
 		if (poison_efault_forgiven(rc, cxlds->part[i].mode))
 			continue;
-- 
2.43.0

