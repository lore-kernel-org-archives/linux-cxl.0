Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012004.outbound.protection.outlook.com [52.101.43.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064932D97A6;
	Thu, 13 Aug 2026 03:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786592797; cv=fail; b=IiLmIXkdlxfvP9IV+ntjI+n3H9q5jCtjjLPO9g5aoI3P3BNREm7srFL3lHdDBb0YTf3lP+Z6zDjV3CWT50e0/1jhGGevsw0H/EfEn5EMhBZHWpXxac6pSC/vgpAf8kVnKRzyTX+lSqYuYJUYK6V1jj+guSX6i9yfIs4CGXKPmtw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786592797; c=relaxed/simple;
	bh=VFmyMXMqg8tcoIgwz6QVEmUkR+eqAEiQ3aDU3Zi0jc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CZr09wA1LefNLVrwbT3wN8mhXXlF69t+uWEoFqhJYUHQiBLfQy3GzPR3Vz1Gj9N60dooYJL+1ggjkIjRkWdB6Lp+QjhTDqnVT5iFjR/kt+Ct9b3qOcmfFKrJEFV/88eXVhcqmiIQj8mLlu5k1u8Jh3RfbZztxDSJR2UmZNF6vdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FIYSMN41; arc=fail smtp.client-ip=52.101.43.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FIYSMN41"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fxmP26jdEP0aW/vXDWOe40/NYbKD8AXvEavIQ/SeDRev/cHVMn69cKwz85HMzf8JxUwvidfAfvqftuUha7SAUSLhAl1sX+vLmkePsMXz7z3BhlWbvplMYd6jfM8xij2xC015bgu6iUUdX8NNH59+8VL57fxanmp95bbeML1JmSZkPuHvdm3iM6ZhSpWpAQBI2R8NkRyy/VevyR9yeA3el6shpsmHF7YAEASydppi38iuRZ+hY943dwbhDaEjnNQ7cOi2LrtzVOyj/fx8ss5RK6BXIyixjiKLzQt33YvJjySmV3+ibJLMhS4u0zWFynBHyhUgZILJBV7Ou+0K2yAv6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJ/w+FgUXkffWxt9iwsNfGAt5njzVP25NtvN6W59nY8=;
 b=SIHWWVb5/VY8vnkNkKaNFayZwkqdFSTPeHsDHr42pmwXBwn+P9BX1FChRocUOR9mJzfzdbZUA3K8zkL7FLkvNmYIAn1KZFCCeUkk+xGIg/a8fKwMvE93QkTWdMS+OzqXsXJGMhfsupV/O/hU2tugUap1931fdSXuiIo6B+oQftogT3+2uDVlf5HyqMobFgGRFoMSX65mOfqsF6CzEGnnApXlY1cX/emGoDRLqaVsREBPgDE0Egftn4UjfWbZ1VMDg79YZ4rqnSQpVIs5wuVkdwgg3wZ5nqGC2xKVnpSQYUSvMnuqUaCSQsHfAMZk2gaYwsgA9L5aId7gJlNdfso53A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJ/w+FgUXkffWxt9iwsNfGAt5njzVP25NtvN6W59nY8=;
 b=FIYSMN4196GNrdV8w3IIrXQHAWDWwy5U8W7bMJzcirzfeLnnoiOAAEk29OzBdycPr9Z0pbZM17w9+wi2RqDcHMB9/2idjkgog8jytUp3aJbNboQwOsxl5TdtfNEUJBlqp/e9LoXRJuxIgoirUSHwqzlhvO8pnOFYmAr6RVRhgiOzqqlDbwbYAeCtEmhENGECHo2jmIr83lXsNuZM6Ze8YZOIfmgrE6thLCxdB8kgsvRLHDqj2pAt9SOU/pktNjtR8fTTsPY7v6gvjUsZiciQlRR5CLkDZsGNATKiYBqWcxi6zXVGVmhH6ZfEFPyYfwaId34Vf709bSG/QyxzPigm4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by IA0PR12MB7579.namprd12.prod.outlook.com (2603:10b6:208:43c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 03:46:28 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0292.024; Thu, 13 Aug 2026
 03:46:28 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	gourry@gourry.net,
	rrichter@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kees@kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v5 6/7] cxl/region: Reject poison scan for decoder without a partition
Date: Thu, 13 Aug 2026 11:45:37 +0800
Message-ID: <20260813034538.13189-7-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260813034538.13189-1-icheng@nvidia.com>
References: <20260813034538.13189-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0017.apcprd02.prod.outlook.com
 (2603:1096:4:194::17) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|IA0PR12MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d5fabaa-a2e1-4224-99fd-08def8ed74da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|6133799003|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NVWTILMMFuzHCV/zd9x8PTinO72VnTaKZLuXRoC6Nbkm39Q7so8yKzVMBdVActyYN4YJ5X95bCynmk65T/1gzTWgmCe+zfcGDuQACIn8VuhfrQp1qY4mfxhJp4zsQigRBYa3k7LsCghnMtjkd8M+Bmy9NoDYTsOl7OTmVYxdd73EcJgfT4G0buk/PSgRKRoi+RXq9GtaQOlNIzJtsE7uS3siuzsIpAwbrVIEXXsgRr/fbf6R8g8yg7MxaQK1+iKLHe8emfJ/bU4MII8OYgspw1fhLduZj7uuaMIvrWYtGhxy7WvGDh89LucWjdO4uWwMoTITSCyZUN+n6uoZo9aR+dl0+YUj4Z08b1UY0ANZGzn6spL3ruwQfXJR66+4/CzN56XJ+kZOdmHGcs8Vlt2WfCAY5ISi7sAwpGIv0wSdXjwKR18FBHKyzd8aGHKt+eisDm/t5AuIIY366cVf2IvXm5z5B9LE1lm3y8Tdlky2wJyoH34QvUfiO6vq774hNGvdgHYmSQAAxBELzlRF6g4n4bm/3Y1+4l3nZ2O71xDpDxBiAyGtNn8sQUTzf1G8K2hsvaaJiD31o8c45QjF2YSOk5DKtmVoWNSlweXERv+dEVClKW8KoyeQ7+2o04p7QvyFZnZrAgn6xyF5F9T4Lwcqp2I3Ja9Ll74s1VIJvMIQJg8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(6133799003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S2BD3ZhPvZHcAT9gHjydPfuX1616wdtgo9MrFSl6mA1W/vS2+jFLPDcqhsDN?=
 =?us-ascii?Q?NiXhlpW1jsdRXtnYobOAhF5rbowDakUaHx49sIj+HcepHb31BGKbLgINhMpC?=
 =?us-ascii?Q?XbE1lsPiPNeiw94LcPyAdpaii/AZFKqipomiG13WvYjD5qcCObmnlrBsIY7v?=
 =?us-ascii?Q?BzFEid5p35sSJdmFRKrr8sOeT9j9YxfjA+Ic52SUBM/HfsX/U22NP3Qdd1uO?=
 =?us-ascii?Q?HZAC7TlQHrk+5gunjVbSGMynkNW1e91Ysb/Hux9H+xe/rin6FdQrp86GveVu?=
 =?us-ascii?Q?2p9CSXHyvr14On9IG4Ufdu5tjGZEZ8EH4jaypP2rIBNwnAkJh7WD58nSBamZ?=
 =?us-ascii?Q?SdS3bALn3ZWnlDS7/Jwi9XV/st7P33HsMBZ0VOpM3RwOvEWxQhSXOYuDvsH8?=
 =?us-ascii?Q?QKBEhWTpkI8Nvp9Km4Gw+ezgFde+Vygb42tYkEIWQb8A2uHQFMRd6Jy1Rs7q?=
 =?us-ascii?Q?wsLw1JK2a9gifgE8g8DQwb/Qmp15C7HuL+HMraCuGrxlU82XTdcmStDZDxt/?=
 =?us-ascii?Q?lmN/qqQojLxngLJTAke14GGm9FRGHn/qTeOA1XeYCvgASQ4g4Ifmx2KyIMPF?=
 =?us-ascii?Q?jb4YuypBWGXTIca3TVfDzwtJ/4+NtgvhC2YtLRzlXUZXbgJVO7iFnhKgjLhx?=
 =?us-ascii?Q?TVA9XsFxApi+vcm3Xoyuy3gmBAgWfdoxXVJHdfb1TqeZeCaItlPz5vqc4ksH?=
 =?us-ascii?Q?zL3ziAhrMmUtxaBxZDiAiDjv36Jc7LDoa41yD1h47JXkuag5xZSflq34Yrtz?=
 =?us-ascii?Q?jOdf5yKTHqG5p0CxWCA1qR7ZQvIihIlFKJeFxhbtGDRpneoAsPAAVZWSQzSC?=
 =?us-ascii?Q?iZWLWrZEa0xf688lwBTi7wTR1Jzzy6gWIme0m44eoy27G+NDGjmzdfwkuGMj?=
 =?us-ascii?Q?V4jfqXBfRPux0CEfCnQWjv3+PAioj2QUjiMvstSmPIEy+Sy/Ais8jRhKMzhB?=
 =?us-ascii?Q?yQzQyT174EE82toPusTOPV33RA0JMH8XMbzKa6/0HHoPL7Vr8uQY+0kmUoID?=
 =?us-ascii?Q?bS0MkzfiwZijbRxBNjK4KH02iW+lTvxCb8Oq5L2maRFYKyuwlO24vA/r+Fys?=
 =?us-ascii?Q?FUi1Hq+c9PHvscD/GMxy0mEcwkbqrvulPV6BJCkzSv/KoWpmglsEGIdfKA6K?=
 =?us-ascii?Q?N7W4XhW4q/BjqIv5vQAqmV6STCaWp81boSXVfrhOWCAL+hQPB9p9eqL5Ru6S?=
 =?us-ascii?Q?CsL8P/Oj7d1NIdLfMVjzga0IDxnyCfGl/cSvFQ2iz90DIVeMEKf71ZfZadxN?=
 =?us-ascii?Q?BeqsvPpd1wAFHU/W8u55OTC4/3gxM4TtMnP9XahezhK7/PQb+XXXT7tUNffC?=
 =?us-ascii?Q?1N/SfTKKdbAlQVG8zjvhmypHDFCzX1/srLsYxCze3zTSrDPh40uN9Jzp9+J7?=
 =?us-ascii?Q?wM8tRg9oi/GwLrOV07hcsqhRzcIT9I/hhVLpFwOG+gwlkqrM/1kOucjYSBd6?=
 =?us-ascii?Q?J3fCy8GouggwafwBhwSK4znw8xjljvNfN7UqvXui8jNTfe+r5mnHjFLSsgYC?=
 =?us-ascii?Q?zn7/EDSQ7rnBBmpp5DSvlAVmVOuiaJ0Y0ZBFp8sfxtLydOR17xIo/smREswZ?=
 =?us-ascii?Q?KlWgSZ+Bv13uwlrg/l28/MYAKPauJofm9G07mhqIZuOt5vC3qO7rEO9YnFhY?=
 =?us-ascii?Q?nFKRevhELkrzGgHMz9cieWKNQ/P86JgtxsagHwDWutivWZCzWECeC7OVhhkJ?=
 =?us-ascii?Q?XgkOiu36vDkqciDvN/MjS00u5wN9XpAERshmcXEPTdbSDkCaxVXLBVXJ+3jp?=
 =?us-ascii?Q?/l1KX01khQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d5fabaa-a2e1-4224-99fd-08def8ed74da
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 03:46:28.7646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +cCtBbjiPgLj+L9g5Kg18or/NRM8MhMJLJ7SIqiD7PEPEkn6Xa5X8o3Dbmohg7p2QeRHUVLGFO5mJ9iDNEgwQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7579

__cxl_dpa_reserve() may leave cxled->part at -1 when a decoder's DPA
range doesn't map to any reported partition, while still keeping
dpa_res. poison_by_decoder() then indexes cxlds->part[-1], causing an
out-of-bounds read when poison collection is triggered.

Return -ENODEV before accessing the partition array when no partition was
assigned.

Fixes: be5cbd084027 ("cxl: Kill enum cxl_decoder_mode")
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
 drivers/cxl/core/region.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index b7dc5d4988da..afe3fb57b7fe 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2954,6 +2954,8 @@ static int poison_by_decoder(struct device *dev, void *arg)
 	cxled = to_cxl_endpoint_decoder(dev);
 	if (!cxled->dpa_res)
 		return rc;
+	if (cxled->part < 0)
+		return -ENODEV;
 
 	cxlmd = cxled_to_memdev(cxled);
 	cxlds = cxlmd->cxlds;
-- 
2.43.0

