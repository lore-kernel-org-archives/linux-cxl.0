Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010044.outbound.protection.outlook.com [52.101.85.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFC39530DFC;
	Tue, 22 Sep 2026 10:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790071954; cv=fail; b=us3gae+xAdCZk5hQNXoYf1+UtneTw58Oqj0bM3x46myfCWpLe/S7om4CXlrxTse7WC3EH4PjOluNMKClHAY4jNFrS5uWpVxkEGxTKhb4d3OYUAU2mbV32eurvUm8iua2etjaIb1l6/9C99iKTAPXy3XFP10pohJD+lWxzdDfYNY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790071954; c=relaxed/simple;
	bh=jKCMYO1gcoVPi1CW4RrkgynDAjw0C36/d0RRca3hBO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=d+o32t/OGxyru42Nb2l8nBfYXBbXUSrqsKqN8oIdlGgUBpKOpLbI9QRHa7vSw6G+5hjGygDMFaQLFovLG8XlDfrMOt+tKT3Znd019XKhnbS+jOFlro4w+OyqMnnJQWTTGbhe3zKbCTKSs21Z3QMZza2OXA17MeflLizGd1xPLX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tGbTQRt8; arc=fail smtp.client-ip=52.101.85.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tGbTQRt8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BSHZrcTjp5OdkuGscyDQIkae7kceX23TKzMYAtLm0p4YR3cotQpxCS4IntDiTqMK1BdPxZ6mO5CCfFPmgywlT9jJpgTPCuRMkEGMRFjc5qO6fDXs2ee3l5zrGlarOFbJuoyn3rDPXFWxVPyEfV0POaPs4qX82rZxc0EkmnQxomhAu8g+YokSITiQoybDhccJG1SAjNwfdoumUy4j5INKzINhogATOQqgPZDSyFo8/PoueQqMGKXM631JpX8k1tmSIPO7Qc4wdGVHLlv7aubi94oATVcw+pOI7okunzKvc+45Ilh1GoQpe5zCKBjHGYdzLS+vvpY5VtJgsnkVu7FqQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5GhBroHKPj5sq7vxLLKt5vRp8RJFfxA3VtOtFmNSONk=;
 b=AYMyFcgLEofD8Dk/zw+unON15NpmPT5z0AvRmyBmRDGJP3dEORsIEBQRB514u9JeumWaqNpWe6992XyqAz33r/majNcH4v/HK2R2mDa5t01xe31aBKvlDHImTcKAu4RMCCfj3K1PSrDQ95nlcQuXAVDljG3tjjg6Xh2716nC467EzJc6Yo76p3/krgMb2CmbFs1sI1MClvjzkRR8RHd8Po+TNbFU945Rp/tnDBDKmY71613DEr62DxoGXoezNvkVfvObrdDunfo08Re8dTrRsJqnVc1wfNxtkjwpov4uto9hVGyGC39MxUYh9Oy9+4H41cQOYg1kwDkZBdlaxNNreA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5GhBroHKPj5sq7vxLLKt5vRp8RJFfxA3VtOtFmNSONk=;
 b=tGbTQRt89HiVAVijcVnTvdXa1j0Q5Q9KX27eAIkBIl3vkSDeoWLXS/zbG6TkcdUSpGbG7fli/aiQCuceJU/WFSFNuxoZfqNYafiN99JDxAvAyorotg+43WllGrc4h+Ioh10+TvvtXIwl5V+oevr+YfK5C9Tp6R0EnDCz8KtFIZ54mjkJxNzj5wjEH42gMSVeIMEGF8ZUL+RWjqKDfpV98vB/ur5iFlZBfmfPnj1b+sZdA9tcV+nhZPhBrOnxcDT+huiWA0GckWIhV0rKIqG/IzuKtY1X+WaKoPpElZEpNqjv4wvTxe/qNLe3X/XOdT7btFltpJWrn2ImA1X6aeJnrg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SJ0PR12MB7006.namprd12.prod.outlook.com (2603:10b6:a03:486::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 10:12:05 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0428.014; Tue, 22 Sep 2026
 10:12:05 +0000
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
Subject: [PATCH v8 4/4] cxl/memdev: Don't overwrite the error from an earlier partition poison query
Date: Tue, 22 Sep 2026 18:11:29 +0800
Message-ID: <20260922101129.52794-5-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260922101129.52794-1-icheng@nvidia.com>
References: <20260922101129.52794-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::9)
 To BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SJ0PR12MB7006:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ecb883f-dca1-49d5-b8c4-08df1891f406
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mpK+UKhNNSfmmaUbvnwfPxQX8bgms/SW4iF/spvgeuGT0egg4w4cNat0AOdtdfZFqjmS1R5YuBStbTDpPt0sQO+EZ1X2umQLExlUi5zGvyEuG3hfU1U7yqDXBWqBNg3B46rVAl6IK9yQDO5ARpugKvttPbTMRy2mKm1AJbWwSkXurTUYpWkpTRe501CTUB23qmEej3Xn9Ow7eVAYO8ekA5GrWXUg9VDT/XGu+bMkLQHJtD2TwI555K8qJnimPiJ5vxyVdTfbsVL4jf/jBdTOgU5MQgyOeLDLyQUFVQJlwsboNyMnTQKPl75HoU915ATObkpHJsUKR9uPVZhg0yXLLW1AqaJLMahcUIDqn98jD1jk1FSRcUonPOk9UhR3522oYyqXo6N7Fntmg8yRzIqFP3ABrGm2r7IUbRcp1juusqZr67JxqNto3hPJVPL82MA99G+RoHDEaFFxRMpGgv0QOgITHTlAbqcgYys/gM7GoLTFBeKc3wjxfviB9PC6n/2LjN/Yly9/DdZBaGoVgtj3KhZKXkM4OG1H4RbbSFTkk8BBqu4Vs3zHmB/l98+H/iyv+8FYTvMyayFwKcE8MyR4i82/92n3B4ETsF+sFZSdcKeQF4Ye90+OXkhy7f1RvzoaMYWU8clOW3kBaXrW0XkMMWZSFSZFSzfMBxxtI6xVIlw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LlAr/BQ4vDPcCJsVXqEvhvyO1HY2vgbQYUKH6fKwuBigZr1yfqJSk4AwjVI0?=
 =?us-ascii?Q?aBH3PQqSIktUmHBxiex9AuapX/wV4PZ7D6IQzE3bMHnkfW6u8mHe7eIEkTmG?=
 =?us-ascii?Q?SHHLDXV/xF8JHSsaeSD6AuSn9jTJp6KgI7AFVpWO/W9CxsJvi3sfTffByIDr?=
 =?us-ascii?Q?NTSL8CkDg1V1PKwshRBUswupLMVd8UpbLiy0n0j0Z7GQNHFCQFAlE5ZFC86b?=
 =?us-ascii?Q?Y2Wk6FCx8CuQSO/L3buLniS19yslrJ3azooca4Bew/UpsV9gSSAP+ZpeEctV?=
 =?us-ascii?Q?t23agCInnoak8reeNzndIjBK+8BtUCRrGW2CxoSWfudOOHzNPwPOqsErpgPb?=
 =?us-ascii?Q?1u77kiPxTKyN0rkgfhYQ8hgA338MpIhc2vON8cx0Qks5DgZHIpQ42RaupzCE?=
 =?us-ascii?Q?M8Fh/Ja7hqHTB9VfWqh1eYxAoXj+VknKE8w2vbBD7lTrT+MjtaNlkHDN0Z6e?=
 =?us-ascii?Q?3MRU9pVhC5OphUAFgZsA8G2yNubY3lfRwVPzmCHMgxPHC0SygG3OMa2hatPy?=
 =?us-ascii?Q?0yONyM9rj+MA03xHUNEpCGgnrsIP/+YW7GUBvcoPboALJRcFgvRBVvjUJlD/?=
 =?us-ascii?Q?nUT/QQhZi2l2IlLdzfE6cmckvT4Z/2694k4cFLAGHR9wcZYUPaJ5pAEV101H?=
 =?us-ascii?Q?QbFpNSZL1OVoA1Aok+oWqqg/k01J5+n77/CKrjVFqO1/vsEZSWrFj4f6WhMh?=
 =?us-ascii?Q?Y68KOTSbMO5TcQpbIXQEMkGEAp79jaN48d+kfNFvRz/1JY/7NaGOE9vKRbNL?=
 =?us-ascii?Q?kPGZHtKz7tKsaRP7DOZ4fI5GEXn7FjLyF7ZcmXMobtM9rNIyTOaEdZOF9ce/?=
 =?us-ascii?Q?cvxuG5+lAgVwvOLyxkilEiVfU5ec3ev/7EyjFS4rrCCDZ+XTUIJVblFbz6hL?=
 =?us-ascii?Q?fhR+LH8zs0kbgOI1rbdj4c0N4FzeLHVcy9HvZh8uCT7AL242K9tqlEGJxXI3?=
 =?us-ascii?Q?fMAwTa4gxw//HU8n6eyPQoFekaLwy9RjVBugojU2AKCvWeysd3pTxeklkquF?=
 =?us-ascii?Q?FrkutI245wHnB6IawUJd08f7AQiXjOG6yJR0xURv+7Ek0gIpCyiLeNzVv4AA?=
 =?us-ascii?Q?A/uucxXt2DyERGJS/hXxcghuMhxB4ANfpvT5m4sQb6ip7hh7KfDgcVFonxTV?=
 =?us-ascii?Q?DEJVlLyyXxjUlWg+72aJ5eK0LQnftXwGbSGnnpQAnGagUrYBhytBsAPfE6Hn?=
 =?us-ascii?Q?r6lzGdxPJLtDiepbfP6r+gxCcdZgj9mQu7xYzHJxLZ0DsSvdlW5hUntiPuNF?=
 =?us-ascii?Q?xoDjm5elPjinUxGBi+NlTmf9SAlagcAQMqU520+H+hRrmv6+Gv8jssLjMMp/?=
 =?us-ascii?Q?xLlLw85N/MOD3wzbzCtT0hGuL+BYKMDSkLxnASPxLJsf6Gmk8UBAFIjONsiv?=
 =?us-ascii?Q?+Ahte3D5V1aupXpcC/KtAojajib5ePc0QAjUzbFZnMKWsuDKOV8TBFygX5cM?=
 =?us-ascii?Q?iU3hvrclSmW0PzfEQRcz/g7Qc50ImAspYtkXviMMbJBm+ge0+BcqZIKi9AGr?=
 =?us-ascii?Q?d1PpmKZucvZGrUv8f3m4mLGVO05IT3IQDM3sI4FXzgtby16nfSCjHuqJ5vEi?=
 =?us-ascii?Q?IPpXJB9wc/nCvxu05AAYygRgT5KomiyybBod5OkHY0H2IJAo8M/sZYDAFwHE?=
 =?us-ascii?Q?3FGFfK+vhN9ubLtMAxQ+L2gQsak4td/TUYGlqrEcUz0KLAOKXpS5hCXwjrdy?=
 =?us-ascii?Q?aWorUN2sJIhF8vaSFxOiHtWXpwd7/G2kBqV+qYhUqso+wk5Odf5Eaf1tiGxj?=
 =?us-ascii?Q?ungVodbUcA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ecb883f-dca1-49d5-b8c4-08df1891f406
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 10:12:05.6506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sn/YY2eMLWU6n+jhJkWgCksShDmyjOXrU0HIUME/+bQHwK5II9FNjoz8eYDmQKa4YT64INPMAasDutexNVpQ6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7006

cxl_get_poison_by_memdev() queries Get Poison List per partition but
never checks the result inside the loop, so a later partition's success
overwrites an earlier partition's failure and the whole scan reports
success while that partition's poison went unlisted. Before the loop
conversion the PMEM query returned early on error. Stop the loop on any
error not already tolerated as a RAM -EFAULT.

Fixes: be5cbd084027 ("cxl: Kill enum cxl_decoder_mode")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Closes: https://sashiko.dev/#/patchset/20260708074228.43654-1-icheng@nvidia.com?part=5
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
 drivers/cxl/core/memdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index b3419df586b9..e39b3d13fd56 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -231,6 +231,8 @@ static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
 		 */
 		if (rc == -EFAULT && cxlds->part[i].mode == CXL_PARTMODE_RAM)
 			rc = 0;
+		if (rc)
+			break;
 	}
 	return rc;
 }
-- 
2.43.0

