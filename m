Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792473261;
	b=TJM8TbT+SC/m+erqkLURNnmlZ1Zx8BFt2qND1JTY/j/3xyI+KFJ/z10qVA7iB10mxs8a
	 tMRCFl1sjkqi8Xz3lHWvnTtdn0g+Gmle+AhfgyqZIoeWaZO5CV+GcZwRsp1sd+HesfKCQ
	 K0zYmUe9n2kBwSB2YpXy8Ca44tg31CH3Q9I6a80yCsa4mCxZlSNdBd7nmlwwRf1BhPeyz
	 noCJNR277aII8VUDaaEHhFf7TWSCy1splrGvQZ+r4gaN5artCr7kdienmu3lEZgQi+o1I
	 WKJDoF/pOLGLNByozsg0p7RKsUnNcJIHddxPkyzlcOqwxczdJvuacGJxsvbxUNIyk8A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792473261;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=QE3TOfXWe5W3BeAhYXEiyP7J03hCRS8XQRGiR0w0p6c=;
	b=cq4G4Xfw+wiohdDX/+YCXKn6262o36NAmpsA8tzvBf1C3+N7Fn2xQeEnFicOZNoM6aRy
	 eCj5JCbGRL0q5lsfT9G3YbDlBK4Bb0E1l+T67IIFTSjiXu5k3N/cROggxlHKJSXhcemGn
	 yBnSMTIqhQN9sY76tHRTyt0vejSHPRJQjk8T3A2RIHAKdCSiGUrt1jyk/aUVgZEAZUR2p
	 A7zEiTJKmR/Emn9WuPCCnqBQ2WM17hLSGQYDkaJ8e1Ne8iv+vCW/Gj3l0HFgOwMcI2Mvs
	 snCdSQZJD40Tk3rhgSDfIILJ8nLzDzclXMrYGjY7znoKY6LXGZk67O6IaE7jx9vLKQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mNTg3JaI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.193.21
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010021.outbound.protection.outlook.com [52.101.193.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B657606A319;
	Tue, 20 Oct 2026 05:14:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B657606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mNTg3JaI
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ygYUdHOjmYn1lBOKH44zZmkjfhr1tETOLABiTtrDOCA1HSMpWYOyQOb/sAQkzv43gdTAIhvkaHGnYh2cw6bjmn56RZa2HsC2B8qDe3hL2lxmluUJjJHaFMaEq1lm19ySGCOkrNhhONCIjIAdWtnEfcseQxNKq7bXjcSMY26npwEVWTkXNwkEcuevsPImZR2Yo0HJQJ0l3QTloVDeTb8UGB0ShOkL++qE1MwQy6ARATUBOini5gGazN0FyzbGe3s/5HWphQiOmNzJViiDIWHW+Qjkpo2TCLv7ALMH5M+T/0cSABVsIeRUXJV659rYGtTsxo+xAp+KX8Q3waEiOA/AEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QE3TOfXWe5W3BeAhYXEiyP7J03hCRS8XQRGiR0w0p6c=;
 b=taXfpPzrUMXHCmLhIYO/EkHY5YAL8/g/IW29YmFl2AHHSqonWoXxgddfA5gGtTY6wUBssEpmOcimYd2uRaB4idFbrUg16L5VLaJ7+axzRX9XY/GcUL+pKuDjuQrDGpJpPXQiGx0BAOqilSDsSlSMIGxqSJ6ocTenUYckYL97PWw+Go/hmCC1VrY/4pIdN0JDvKPkxVtixiR9zYOVghr1thMcNqwlw84BTppVGxsDob8nyAOQj7/EAiGpgKRKxr8q3ivIhu8F0548xp52QwI7A0VmuNmVFhEFIqLhrPOghKW3GaNmW8J6uIfdSmONW75lHpbAMJ6VpPjS2udNRC5sdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QE3TOfXWe5W3BeAhYXEiyP7J03hCRS8XQRGiR0w0p6c=;
 b=mNTg3JaIegCSoBByAukWXsdl6x5ZCFXDXd/B70uFjA6dg4X+SVG20co6E/BM1cE5XTYO3qxMJSTE3Nf6VtIcQL9bjb/mchf/O2rm/+y6SV4Jf+wAnAzxu7WGoJxkTB0Bdpm2HoTZdv5GjF2/b0BEo6aC3Z863rolLluaQJfI5r05go39/ze3aEhkRsR6/fzUu++jmHToUqPih6ECdlZdmLh5HYDkcKL50jlNoQWXILnJGEOfiaiSA5wvgo0dW9rtexk2Z/g2/nALwfi4aZVWDwfywBTtPgwhXm0YtGDZ3rPSIGY3i+dICt5ZfoZ0FVYujENqYgWU/R1bEJjatmQEZg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by IA1PR12MB292992.namprd12.prod.outlook.com (2603:10b6:208:5a1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 05:14:18 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 05:14:18 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	iweiny@kernel.org,
	ming.li@zohomail.com
Cc: gourry@gourry.net,
	terry.bowman@amd.com,
	alucerop@amd.com,
	icheng@nvidia.com,
	rrichter@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kobak@nvidia.com,
	kaihengf@nvidia.com,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v9 1/4] cxl/region: Scan all partitions for unmapped poison
Date: Tue, 20 Oct 2026 13:14:00 +0800
Message-ID: <20261020051403.14186-2-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261020051403.14186-1-icheng@nvidia.com>
References: <20261020051403.14186-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0049.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::18)
 To BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|IA1PR12MB292992:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b78dee9-736b-4b6b-b95d-08df2e68fe2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|7416014|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	0TZXml8TGLt3k/reJ9dHcxLizgI8oe4/RL5Xb1ElzIsR6+yPJQKGa0KTn38eEjXSfO5K4LfxPBEx9piFLzPaQyMUWKeG+UhXwxfIYNWBrwjDljscruGpJCOA+gLOjw0lJ0AUpMK98wdQJh87/VLvbfgcr+RX01bMVZYMYbWHisRD7yyUdXx0fY8DAAfO+8MpUzSysU6J8vFDEamn9jmT6CgDDSJVxVczdrRaIEkTfNfYZ2zVuQBZJfIBz/w2vYTI6pipeA8oyXoMpvOVxt0bzFohEV6vNF92CSWYmeCzjHmlb/VdCDz1B2RIHtioIAfREqNwa0DtpPesEywPAZLiV1QrkLFbTO0TI+o7IRXAo71phif+n5cMtLiDpeZxTv+NdxXHT5U1IMLLunk/cOM1XOrdpFI16LDEsZHRwkAgbBFeD2kEdkrtif/WEP4PQ5TJSE550DRBDTSIc2Sn5LfC9+aQ0nSrWYZu4BlbK69/UIepiFat11A1NBOaVUUfNn1+qBysaKWie3a6+MwU5RJhFX3g7EhSMnVubBytkqnnHjlcx7HYZqlJzqKnEJl+yiIuqKRtNJ9NB7dS2p7J013IM7qGATGh/E5fqDPAJhvMF0trpSreHcQJp0X7E7J4oStpyl467huACPl9q3cP/eeFvSzr7Ct7m/4wT1HuX+f5WOA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(7416014)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SR1+80lNQ4uJpJl1WSIVm0Xcl678zHGwDWKuI1a5FUlXQy77OrfaSIxFFGB5?=
 =?us-ascii?Q?G7NLNzwjacGPjxw/bEm65y8bCcgKvDULslZO9BtJ8vaOgs6Y6ajfHW/Sen3M?=
 =?us-ascii?Q?9AOF5uvjqW4crVM5ZHbRjGQss3RkFi/+NJFcZtIGauEOxRVsQbhPHxkfAXb8?=
 =?us-ascii?Q?Iy9QFDzrLYLHryY+8bB5rAUl7qeRp46+D1XB++CyFuV/P+Rg1q3bVD2QiZ1I?=
 =?us-ascii?Q?uSlnnypR5/WyZkTGyRF8Zsyk/54ZGcVIdlaT2mRMNM5FMNUx7Q8gtpRC5+FX?=
 =?us-ascii?Q?mrerg2WxztHBY2yOPL3boGOiJM8tD95rBKTrbsoPrJ8GLOPKmhmCiCp2ysmk?=
 =?us-ascii?Q?Llwqg7vltrkviYxNaAT3P6FmYnAtNXJgSGohZuYUIDOMq18UAyOCLQOmH5a5?=
 =?us-ascii?Q?b33ONvVNzwTkQ/SwlhNJ8TQKSLr9eAhoR6VxizqK6Ntr1K7heXEFPDuFEsOU?=
 =?us-ascii?Q?SQ8H08Wpck+SlH+byjmwzwezHyR/8UE8nvpFtATtjtF988iP68oU+3c/iYUW?=
 =?us-ascii?Q?hUhf2cPuXGFGQSmLhiLqer9g8PHORcFWE7aiPad16NRQ1BiAhMha5lAuY7U+?=
 =?us-ascii?Q?hMxA2XhR13Jr/lW4wOArTczwTxUESZiBJqXlYQA3it73qt+3m+EfxKB9+6lq?=
 =?us-ascii?Q?uQp5UXnzht2922mhKSR+AZUQTSC4joLIeOSF2dUExOnZSTxOYCxKQOyLn2vv?=
 =?us-ascii?Q?tI8p0/xwUpv3CALVUdq0BpeGTBO0Uxqc0ecPCgKaIaPdIHua0jHsnRVaUAIH?=
 =?us-ascii?Q?Fq0cFBq7Siz8rOsjxUZvNu1BHrQOYcrctT9XQmEZrA0O+TmJgAqDXNXOY58P?=
 =?us-ascii?Q?Dsgcii83isa/xoS6DnisYPsDWmlyC9+uacqXZwnvvHUwh8c4xVnufzO8xNZR?=
 =?us-ascii?Q?tm6E0IvCfh/GrMsXuYZzmyklrjosXBj5dt1tnfTlpG3pjztsKjUharo/HrAx?=
 =?us-ascii?Q?w/cJmHckGrMlQFvVB769s2rl255uVbMi3h/HOq+x2uJ8BQH4C4Gk9JfNB5mr?=
 =?us-ascii?Q?cAWS7vS7AfTP2L9wHCCCQP9LstKl463H74zvbZEqagi9Zj6iTkIMXTaUS+0h?=
 =?us-ascii?Q?R6RcmGwYUUimgUNU3Zf+JK/FiGO+2pQ83fdgwr3MrTMTSKL2AuSfDoI/pw4N?=
 =?us-ascii?Q?hmv4sLqCsavaSr9q2FTnN5xd2Zy6P2iY4t7EaO5Axi/FsSEaPrNz6hAxwLnW?=
 =?us-ascii?Q?waTUKwl61gv0v3a7W+06em+47AAfLpxXWJ8qFCw9KOmoydbAo8he2a2c5F4O?=
 =?us-ascii?Q?bd39dflwuWpWuHdesKaI+9bF2BotfluxaOwGGXBEQfsTu3KcUJoOrDqHK1nq?=
 =?us-ascii?Q?Yfvl79dS+QhrVKlKweBq5o5mjAU2svir91GeaVpzqxRX0871A9SyrZ2QnCrF?=
 =?us-ascii?Q?Gug0FjstOsHZkPlhNlNAUa5Dt3B4cF30ISp/AV8O5JyXD2ZFwvYazfKfBw1S?=
 =?us-ascii?Q?UhsIZkXdfSHn2TZsXz458emLASsxJgibUHA72XEQAS3niT8NtK+n9/sGnnRi?=
 =?us-ascii?Q?8Qui/oehVIvv/NTW3fvYQqTKSuznJQ2UqDhQ6vXMLjWHSqnb2mFD0LebqeS9?=
 =?us-ascii?Q?MSKZ37V2WmKfm60kncYWfbbz/UcTHGt2n3AcTl1h2jnMsG0dymSeBvVY4N8A?=
 =?us-ascii?Q?NYk0LTFImU9VrsA40V/OtFU8Sh0H66Eq685phD5A/mRY8hnFKaq+4hv56IJ/?=
 =?us-ascii?Q?/8qAAzW4DkYyI3t954bexdYVPEzFmXUDCeV53CIT1nZH2LME?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b78dee9-736b-4b6b-b95d-08df2e68fe2c
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 05:14:18.7174
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FBo0NhwMD02y6vNMbyRhLGbhdQSpMK4As0LH/LMFktTcdRkYHTVQeaH4nhnW15o/wZxdEkGqyXC5YABK1xl6Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB292992

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
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
 drivers/cxl/core/region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 27e63e6dab7c..b03f30c04d35 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2928,7 +2928,7 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
 			offset = res->start;
 		length = res->end - offset + 1;
 		if (!length)
-			break;
+			continue;
 		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
 		if (rc == -EFAULT && cxlds->part[i].mode == CXL_PARTMODE_RAM)
 			continue;
-- 
2.43.0

