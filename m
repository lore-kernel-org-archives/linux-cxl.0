Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010044.outbound.protection.outlook.com [52.101.85.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 716245304B7;
	Tue, 22 Sep 2026 10:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790071949; cv=fail; b=ucFUYqJkmE5mFIh9AXApEgy9XWSB5TtmmPqe99xl1UIP+bVOk1uKZeUudsN3dZvb08e+NQp7RvX/LBzjB/+stAD/90gw99ud6UJZJUpeivsj7ABwIoBFx68Qonnkq7XKYuM3T2NaWbCHDndJkjor1evOcFwTdrLcJFW7WHLivGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790071949; c=relaxed/simple;
	bh=z5Igqj38rwF8cPDldQ7TmA+jRVo1KbibZbeAM1ZJ6+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=F6VzfCzZWJqPrU/edcflalQcXYk1YbpMbjrlwFF98v5IidrnDaagfKy5fqCDql2YcV9IqWkZNp5IQN8Z3GiYmTjukHP+iqLbyiYjfCpUAT1kg+2HWV0GIa3pxbeWP4UrGGp9bLJtI5O8ScUQ+ClhwrBAHn84+nYa8pyc7nPnDK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q3m+o5T/; arc=fail smtp.client-ip=52.101.85.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q3m+o5T/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2GQ40Qhc7eEnSYMAnjlJmruMJIAs0CXHZD1DnwtfvQrDT615K14wtVXpPTdNtBrTClqfA52mqHrNlTqt+KhIMJ6HzJIPVOKO4amlgCk+DR8h7/P+GMZuLoLIck7bF1Hq2MeKpz0seDmLBDRrSRj68FDY3JadGwxBUMQYxTqk/afkiCqus8UYVUXOCcBBlgTkDjTk/vn1CpjRHgYjss6H9jMZBsUkOL4kLqIA8T7A8yL90GbLAaES1yGCCrZ5WIGGMevUIi36BY0a9jBg0gELBt3pJpD2BxppvhXc36yBk2CVKxxnTyWBy/3wGTEFlZKob3rAaRhhnc0PRNuDw6DKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72yuE2aDWvdCIIadum6sX/U/ak5YiYc3F1KuFvT+5qs=;
 b=JcvWmy4RPgRSmvWAnmpXBznmDPYRPQmn98dTrZsbZgCBOU5lchUMEqx0LKAC2rhHquNAl/irDo2w0vMjf2Kb4AUPMWWsSpKexfMEqG1E/FVeimn2Sxq3ElDqRrlJJdngqGD5j5Gm9psE1tSyZrI21nhEPEh5BUp3dGu5BVP0oXmgHE5mgXcS3GpKaLD0iwpQGEc8eEgh6kDL2zWr/wN59TJ86upMMAmY9aALaZs+BSxv9dAru6X3+3jY2eiyBiD+SGFjqn6XfbM5Q/CfxUXEqWAaW+6Vr2bMfFEOadid623eMJSZPYoz2Ilsk/qVOe/4Paw8eqiX6OQc4saWlnmj0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72yuE2aDWvdCIIadum6sX/U/ak5YiYc3F1KuFvT+5qs=;
 b=q3m+o5T/VvE7M6wVKsY7gHjQx7tVHehkPSDnyiNGE6+t+Eu6WJM8pUYS6BXvFbQgp6s3F0XxFub0NEDrhyWl1SS3D/LzkyK+YDakg+7ntTcjCIr2Pc6CQNJfCj1zwivZBPjb8LEfT7qAa2E2VSWnhZgdTLeS9+xRXrtsL1/l+hN5CSJQdaW3FLbiwaX20Vlv6Jf4VNApd6elwgcUo0xGUOVv1n8isY/1N+tFRyow8WooW7cibVaejZ3p7KwMIdNaLOGqyYgpCZDocAdoixt7LjZYMKCQ7c9YpWjbllYvR6SMuMufXIEHoPuvkiBPwcTDMTDlbDfySZRcqTq4sGHngA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SJ0PR12MB7006.namprd12.prod.outlook.com (2603:10b6:a03:486::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 10:11:51 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%7]) with mapi id 15.21.0428.014; Tue, 22 Sep 2026
 10:11:51 +0000
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
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v8 2/4] cxl/region: Don't leak tolerated RAM -EFAULT from unmapped poison scan
Date: Tue, 22 Sep 2026 18:11:27 +0800
Message-ID: <20260922101129.52794-3-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260922101129.52794-1-icheng@nvidia.com>
References: <20260922101129.52794-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0016.apcprd04.prod.outlook.com
 (2603:1096:4:197::7) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SJ0PR12MB7006:EE_
X-MS-Office365-Filtering-Correlation-Id: 389eb786-9df8-4155-e383-08df1891eb84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|11063799006|56012099006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ldet4o8HSVBNSg531CF+pT9x0wt33tHK+LjdawR9Ev7PIv2zBDq7C1MmX/hAHEH1VNPl5fOj9RVSAxgccWQ8ePtbzDHuq/YuOjod3qV+WMe6a1ei/SbF5/Tr4spaHWAN4eueksekV4LTY4v7Wa8POfBhR2mwBpzV9/VBcJpkK2PVBlJ6T4i17Ts1TISsa8Q+Cfk9j0hw2VgQlYm8kYn/f2lOe1Q4Nia0XfjQ9FLbwSgzSVq/M9+UMuh+wzAJA4wAxLrC2LPjVcV5YCfygiWdcyHdoWJvIPZGvlNgixWO9jJQDv7ee5eyQSQsHpOMw2dGuCe+GoBszgeTrblyro8BvMVxqGsL2CcGUFbBl1km/AGcjUETu2F44D3m5Gx3qS/njrTQo3GYqjb5jaq4Pibzmo/2pKBZN2g3lc/7DAU8MDT6yxV03EToKmIp/ZmV15EpP521uJoAMBgb2OKVuCHgClwk+lSJByWaRGTpLUPesjbtKr9jUNntrRuqFmA5G7MRH7r1/J8ft2GMNxERmexIeZMzmFE9kRr5QfArVzRZXsMbVaek4nbWhVoO+oGMUT1L4oZdFsMTZ3ViZOFmFxV8gqq9DImOoMeI5Ua3tZOSAkacxUQ/i5qZE5tBKgXPMGUfw6wm9megWzxZ2auvjBPWX1BUAlTS7Jb80mQEdqqLiSk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(56012099006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R9FcEcU59kqCIx9TE+7ISwgRpSDe1aQWCm5CJLWmt1PSgEKLYRUP9ukWbGNg?=
 =?us-ascii?Q?oF/F1nniu3L0IZB6NlXq99Gdcmi3eoxEDb6cWs2V1iiaIYT17dgnMSBYXUDS?=
 =?us-ascii?Q?0iiAEgGnmOzJ5wAG7JjG++iGVpDzX64bYkHMphJqhW1Zmuy8eoqPkpCPKAZS?=
 =?us-ascii?Q?0yBPuP3q0rHFA2QU3aGFYL/nzpgIh2fR9psZyxFBo3+EdXGmmi2XpuN8FKxb?=
 =?us-ascii?Q?GHEiogfXbqVYlnyfkyhf1eLl8kQk2EsUv+9P1VKNNVbBXct/mo8N3Ap6fr7e?=
 =?us-ascii?Q?VcFaFYL2kMPnj5yFOZB1ljkBUTz8cFxGXTRP6JoFU3NzssdjOjIOKKn5dv6i?=
 =?us-ascii?Q?pffubelsNbC6tX7PNYQH+AeAIFJ80o3bFg4rb+d4PmPcmjcpMYfjx8lMH6zz?=
 =?us-ascii?Q?GCW0G5IGSrtqKTenKPo0Z3Xb2GTCHaZCZm8gzVOLJRGq7Xm+r+SExvWBnepp?=
 =?us-ascii?Q?7GEQe5bAUk/bQMTteWxoww7xVfiG5OgBWe8D4uGfvkDaG+bOjCL6AphZ95gJ?=
 =?us-ascii?Q?E2gZWw6zAvXZaZQfd4b1ZV9HF/iKTIs9QawKCcFYaxyKTUwMURNeGEWUYErI?=
 =?us-ascii?Q?0jyBB3N6YEez7358fwaYQuliv4LI9or1lH2vE6y6HkhuoXp1Gr06VdzGSr4z?=
 =?us-ascii?Q?yDbgopCRsm/tvAllWwYJ3eoA+vLEcRYazD7ZU/wSfDxL/ijYkKMjsIW5nz1e?=
 =?us-ascii?Q?RSrsJEunpmAPQfx+WDlXupT2DeJlg+w6LXqUpKcNzlKLMWt6exHymlr5s4s3?=
 =?us-ascii?Q?EwxK8QAJg564OIGtpOALcZt3Nk1+5ACoDkfr707JDr7oNvgSOPaTasHrixHc?=
 =?us-ascii?Q?8vQ72YzSowUNqIzE+FixRn4Kg+2I2QkrfYthQzMydW7p8EpvM3+3q2pOIxb9?=
 =?us-ascii?Q?kpOiM4KSCBs+K8bfOmtLounYRw3/ELEAgczQswgEIh1tAJkasMpMStsez+lU?=
 =?us-ascii?Q?O5hlx4npI1UBCMGNHn1iX1HRw+0L63eynvkDzqzKwKUQTSlw7GvRTEzJEq+K?=
 =?us-ascii?Q?c/xxnsaVAyBHKH2V3I0YR3iCDzy3c59+yA38/9TZC5yENdSithds7QLsF0ga?=
 =?us-ascii?Q?2E0RjisrvmedY43VvMv2H2FfiUl27kcDMXqr2L1yUx7B6IExKj1/VvI2Apvg?=
 =?us-ascii?Q?kCMGlSyo3N7nPfLJ/37u0LoYV0y1yF9Ga9JcFr3/kg4HLBSitkmvYbsIm2od?=
 =?us-ascii?Q?B0WQJcStJn8UcBOrzp3xZkH2xqHSIfVjQDx0lz9cNhX7xz/8x9Exo2rlV3Rk?=
 =?us-ascii?Q?pb4IjJWc6TrbHR4bsJ/J8z4Q3HzG/wjbDjATM75nsrUYTxuLrf7yQwl7qPTj?=
 =?us-ascii?Q?e5PR+ovMP57gfY/qGb1sXa8rtBE5e7fiG90IRbfhb7mySeOOKHZL8Drlj5fY?=
 =?us-ascii?Q?RY0yg5+1KkVrj8mIlhML/R+LSk+aDeonIGjNEqcWC5nEX/Gq6aQpWV1TeLkG?=
 =?us-ascii?Q?5qf/bYYRci0QstjZPB/bMJmDuumc+rWZOcuG8pfB1x/DLTQukkZqDJHRdG3I?=
 =?us-ascii?Q?8YX4fZ/91NLqBsRD7NeEGsnDvYScGNzwQrjJSHnNuCrpLsrfXU778Mw0+Q+j?=
 =?us-ascii?Q?elwSBcWu587wx64B23hMT4Av6u41J5UtMnpAA+Z1byk1DteGhxdAuGWMLu03?=
 =?us-ascii?Q?Ef/V9kpfvsuq73vEqBhZ2uhaZAN4AJ+rDK0LZXCkBSmu/WTOyRyWezJtUQb6?=
 =?us-ascii?Q?xvD0JrZ6LNejKUf5rSF1ArvcKpOXhtt/QfPHgMn2n/sZN3SQ5gueKOiW7fS0?=
 =?us-ascii?Q?4YYK4dzFqw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 389eb786-9df8-4155-e383-08df1891eb84
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 10:11:51.3790
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ij8ESP6xYwjdvYT86cr/1cEoC/TjNiOMDvvCmrQkD5/ND1C9vsEeng4KnkucdXOb8OoLhw/mSr6wk672P/o1Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7006

CXL 3.0 section 8.2.9.8.4.1 requires Get Poison List to return Invalid
Physical Address for a volatile range when the device does not support
volatile poison lists.

For example, consider a memdev with a single RAM partition and a
committed decoder covering only part of it:

  RAM partition: [ committed decoder ][ unmapped tail ]

On a device without volatile poison-list support, querying this tail
returns Invalid Physical Address, which cxl_internal_send_cmd() maps
to -EFAULT. The driver tolerates this response for RAM because volatile
poison-list support is optional.

When cxl_get_poison_unmapped() was converted to iterate over partitions,
the RAM-specific error handling became a continue without clearing rc.
If no subsequent query overwrites rc, the function returns the tolerated
-EFAULT and incorrectly reports the enumeration as failed.

Clear rc before continuing, restoring the previous handling of this
expected response for RAM partitions.

Fixes: be5cbd0840275 ("cxl: Kill enum cxl_decoder_mode")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
 drivers/cxl/core/region.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 7c7287315d72..042356c71ed7 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2954,8 +2954,10 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
 		if (!length)
 			continue;
 		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
-		if (poison_efault_forgiven(rc, cxlds->part[i].mode))
+		if (poison_efault_forgiven(rc, cxlds->part[i].mode)) {
+			rc = 0;
 			continue;
+		}
 		if (rc)
 			break;
 	}
-- 
2.43.0

