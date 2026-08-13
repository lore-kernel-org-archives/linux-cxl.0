Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011060.outbound.protection.outlook.com [40.107.208.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798BD257435;
	Thu, 13 Aug 2026 03:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786592779; cv=fail; b=SE7qsSb1ufDwERNuTrNTR3/a5nBAXttPDEuk1cUPsrJQ9r+qJdXOW0SRPJp8W/WvDiLZn4MSbs40qgovVSceZI9JPh/t7BAgp5O7akmf4ipGW+Wkhl8rlBMgipu+fqJM+ceVq/O2vZakb9c4DCCsyQ4LMtgvewxjC5LuuemqHkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786592779; c=relaxed/simple;
	bh=zBsmORreD2h3FKYFKes6260lQCIMBwcEsrpBp4p8AVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cb92sf8cDl18CE8W46HFcuPbtempMoIt5Od1d3wWEZqsRa8EC5fvz5LifkBSnWIgYbOPDAGkUhsUoHVcOvtno5R1diP9D8jUzehxCRmkiJWJTNo++Rd169H6UuXxN0O3EJfj1DoPCBSg9qv40AtzV3FEvvyTMtTNHowCRePGR2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cplNLEG0; arc=fail smtp.client-ip=40.107.208.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cplNLEG0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ikhq45zWrIkXtTPn1K3zOhaIkMD1hc/M7fWYrhZx27KH6r3k/sT29prpJ9YokKlhIo7fu5rqydVKBiuyrthSpx+CaKKx0biMRsz8+IijKmDFp+rVdbodR4vyJ6jItNNoA7BJaJsgGn/QwKnVd5twdL54vhmjFD5F64mVkXrdqnrFi+OoCwSgtaQ8I8X/ngxSQvrRmfxo3ylWYNnvkDF6ZmonnvFpN3bptvo5y7L4GW9LxcP0k/2Lu+YUZCHh6aDMULBc+5w35JwmyHNoB+y/0rgqyMl/bXFVUVTmD6ywidlsJKaeIemCv8TXiwcLiodD/vGFvVZRXXiiRXBPhRQPLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uRbySNrBgmxr00b7zAbOvHMIvwaIdc+gbkt7kitIzUU=;
 b=m6ax+mztf4D2f4kAY6EYeAds+OyiYxLGtugJHoIpySuEp9c79iLRvAC1s461FNBIZ5TXxQVVfL5EuYJtkNWvlsV4nnaA1pp1j0Xb3xejD5rl9ZZaEnpo+PmiAk7O+BcX0M+qrG3ICbhfP9tBgY8egrxKxRufyxTUJgvOIgeUk6NyWSJPmfa78Pbj6aQCxQz7gNrWE5aEvuLa9/3VDLdzD74+mnKM+hcmr+XOkNTwT+ZvaF4Ehlb+RTXnaGbqUqfPkEbc6XA7T7aNSJhN+q9V3Kof7TPMfog3lBMDSzGJ5Dd39DvSFDBloU6wN+hG0Sm2jw0WP4rxjxQIettNruc/ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uRbySNrBgmxr00b7zAbOvHMIvwaIdc+gbkt7kitIzUU=;
 b=cplNLEG0p98FVDJcbG4ZBAMUewAK3vovFFWX/junT4Wz8LlAfMVdkQzL6x5wCrmjQ2er+N7LspTVhYJ24DaD39cGRo0jMgYh1bl2bmNrETwvWwIuHn/h1ihjSLQVdw5fFDnpjI1LwzcyBfMTS6rBs29WsAzVyJPMoeZpwrG+93AA9UsCVC5jBxffoLWKp7GtIyjdMejJUQ7XkTXUc7Xd/4Cq4D/xyLiyMNL17DbFboNzcx69zescsDgIzY/XeEs56HT8sH0jlkz2tksI0IsN7wHAi0ZX+ziHaP7gEFb9NE0pqEbChMuSdPeOSyu6nTVlstZDiJsxl/YBcrV32KDMWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by IA0PR12MB7579.namprd12.prod.outlook.com (2603:10b6:208:43c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 13 Aug
 2026 03:46:14 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0292.024; Thu, 13 Aug 2026
 03:46:14 +0000
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
Subject: [PATCH v5 4/7] cxl/region: Start unmapped poison scan at the committed decoder boundary
Date: Thu, 13 Aug 2026 11:45:35 +0800
Message-ID: <20260813034538.13189-5-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260813034538.13189-1-icheng@nvidia.com>
References: <20260813034538.13189-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KU2P306CA0059.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:39::8) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|IA0PR12MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: 266b380a-5e6a-431e-0f4f-08def8ed6c82
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|10067099003|56012099006|11063799006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Hd4z4fsLkWWm2zQzK3uLRcrCrmbhcu5bs4acLFQ1RsXcTLB3BjhrlKGswK1m4HJmmrNoWRBhmZ5ZoGZW75FG+WMuSfKS3Q1cshiEDACOPBG6MeIn/WGJRziWtwuWGUuUd6fFYpz1Crddt6qrgoo3YIxp+ov4SaNRe2LkErTZweCpN+d0bz8Y/8iCrypkVSgs5Yv+XmL8hkWdY5sisHc3HR/Kp2ibbPiKyY8COmYEZeAC7w2Gy9w/mLw37N3U0f4I5mknbqYrpzWZasl2pughZ/i0d3dpsIfJo2HEijuxAiWGmbI8Su+tX80mDUxHIYHoik4AqsN7thCDCG6JZy/HmRlT8W6HHkHBPwu+GJ1vlT8sBSCDd5IPYFZiCQKkCYUrgJY0ZKp7cPYbAoevAiQjtpe1WSBPALJUKzr7BT7e7BMoxyD3frXzrfddUFXdDgZ4JUPiqHuPSJ1xT9louWdfAlZ8RdFrvWkMvuzZCObcjQc7OSIDCg0P1rNhV2njRqN0fYU9sg+1ytdDLFXchvIX9NyoalEsba8eqY3jNmDI7xHGQGR3CiCcmHFkQ4Uum39VuVVAX/0qusfqTeeOVmB2n3ngjJfD9uAyAebZWzBtPLUOoBdEf2BvYAqbrmiwvpFHci23eEhMGhw6I2L0hHFjx7SHSVITaJtLYgOO4s0by8E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(10067099003)(56012099006)(11063799006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F8RrNvQyj7z36WdgQwq8LcjSmMiounr4uCp/EVJ8ory276YIbnuB1jZVj5FV?=
 =?us-ascii?Q?AQm/72QMT75jJ1Q59fYnE6J27apfzx0Eup7YtO89nJOSgS35HG8CR4oE+FkX?=
 =?us-ascii?Q?eIpIphq+nF/y6RulPpW+CPfI/NJ+pLOK+0cs1FMOACa44q2iWn8uWhMw9EJx?=
 =?us-ascii?Q?BCIpQjaab74MMe+ATIC01dVjy378BstZ8l7UpXxEPhY9Sb+vcNfX14qcdRxK?=
 =?us-ascii?Q?zviHh8w8JlwqwK6vZkuPRyCqHRLJ1PeWxuP2iFZBG3Qxyq9JG3eQMhX6nwbI?=
 =?us-ascii?Q?UkZp0R07CqOr9U0tSDseuziN2HsxK8RxJ2L/rcG+PjFmxstq32hiHiGUsu2l?=
 =?us-ascii?Q?IQwuA9nurH7Rr2LtFuDdTWOOtF77aS9TExd52uA40BOkI2l9P7OfYaNtUDv4?=
 =?us-ascii?Q?kZH3h07eBzdIfQVIYnljDA4OhxTtlSSjZNFtBobeQZKqJiHB2F6CyKLPspG/?=
 =?us-ascii?Q?XMy0yrmTCndDkT9DZnrf92SsL6fPRYzcUMXEyIofkDgkqG168dt8gyYSOjzS?=
 =?us-ascii?Q?lv9Kt8jwOE02XGYazF3UbXUmIXLW1Zxy7BPbt+mGNgoyfiDd1DLkZZQZf43s?=
 =?us-ascii?Q?AsLByYtR9VLYNGKLPwgEx670KGJ5aCnRGBVv7HLRGX4HNB+uwh3zpVGAq7Ji?=
 =?us-ascii?Q?5E7CuzMrb1+nFJKCAp3nRMjnofYy1vtl4Y+5Z+j78juH8z0/htu8T9VTqtMt?=
 =?us-ascii?Q?iSPaKc7bC0PrdAlcZgdnqNwXWlXX4BXyRKWbL/8a4Y6ds08WWCOrWB/N0MZv?=
 =?us-ascii?Q?MTvIcgeYnsOoO8SChEdZ9hAwZFkZvURdsCSkIZj27GutkqV0GtagMLbw3FPz?=
 =?us-ascii?Q?lJbHfcNNSgK4jKM+N1fi5OdN3VHjE5lPuzyjg3px/iXArgA835l/7cUJT6mU?=
 =?us-ascii?Q?YUNErA5wWfzFv7Qr0nKdCEXKkLo92xKOpei3Xaom7Cf9flpxw5eLOi6jtvJC?=
 =?us-ascii?Q?SRsMGfWcGSOJyik/xKFcL9cAMft9MdcKR4LE34EFcjzxPlHhrpmRTu0QiZVA?=
 =?us-ascii?Q?kYXzBGwU1JNG7+DpcQ+970wR9QaIR4iFwx+gwiy4ytZh2T8hNLYs2OiTB5+R?=
 =?us-ascii?Q?O3ivFKFS0F0kqkCkCAVXdd+VLkmIy2vfqkuCe39z3bZWTtC2xYwOUmirgBE6?=
 =?us-ascii?Q?Dsq4PbPdC5xfdctR+pykTiYQZ+ruNNG/zMQvQdn3HFlGndUUoqewTx4P5A84?=
 =?us-ascii?Q?cTKVxCYm3aAP+3do87sD3VaxkCi8Ms4E1fDMUd5uL8mjOYIi9PD3+YOI0Ihw?=
 =?us-ascii?Q?3Z25GrEbKnQSShYGaTuPWxIZz1L7F9S2UT9AU96QjnNMEkXcNimnx9Cu2lm5?=
 =?us-ascii?Q?7S6SQ7Mf+NMK00e01Sie3SN8UtRnEjfNWnZM40zF6tLzOlG916+yBDNvil2Z?=
 =?us-ascii?Q?yd7TYNAAp85lIIBf9LJ0YCp1V0NkJpujXQXyG+6i8bB2sckEnCKH3DpOVd2T?=
 =?us-ascii?Q?38h33SxU7UPLhmBaTlIo6tfTKB/QPqdJpryLG8+03F3IkIvklX7Qgp4erWEZ?=
 =?us-ascii?Q?bxE+ILJ2FEOCsBq5QfwuaS2xdKuR7mdKtiqL7oMFrPZ1DPEDUoXV2HcTV2KL?=
 =?us-ascii?Q?p+dg/CwGqz7vQFjt49Ujdf+cT+ywcPde9EzwsYXYqjlrlrsVF+idims6qqzS?=
 =?us-ascii?Q?dE/u/xN5DASv4NyZQWWsB21oj0tu256CqEXkMb2krw7+7UPXaGTWaU0pztZm?=
 =?us-ascii?Q?LIt/cdSji+Vfcdba2ih80ttUsk6i8tvHcgyXi7aLesUohVFQqpfLYIwLJ1Hh?=
 =?us-ascii?Q?2IEppVhQTA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 266b380a-5e6a-431e-0f4f-08def8ed6c82
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 03:46:14.7836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bDUo30PpkVknOPxbF9J8JcGwptoxeGC6k5I31hzGQsp/SLv5QfIuJVl5TDdQlfK11IVRP8NZKjeYE3OJgH0m5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7579

poison_by_decoder() stops at the last committed decoder and records the
handoff in ctx->offset, but cxl_get_poison_unmapped() ignores it and
starts after the highest DPA allocation instead. Allocation exist for
uncommitted decoders too, so their DPA is skipped by both phases and
poison there is never reported. Resume the scan at ctx->offset, and scan
later partitions in full, restoring the pre-rewrite behavior.

Fixes: be5cbd084027 ("cxl: Kill enum cxl_decoder_mode")
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
Changelog:

v1->v2:
    - New added patch ( sashiko's report )
---
 drivers/cxl/core/region.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index ddf12075b95c..b7dc5d4988da 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2907,7 +2907,6 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
 {
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	const struct resource *res;
-	struct resource *p, *last;
 	u64 offset, length;
 	int rc = 0;
 
@@ -2920,10 +2919,8 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
 	 */
 	for (int i = ctx->part; i < cxlds->nr_partitions; i++) {
 		res = &cxlds->part[i].res;
-		for (p = res->child, last = NULL; p; p = p->sibling)
-			last = p;
-		if (last)
-			offset = last->end + 1;
+		if (i == ctx->part)
+			offset = ctx->offset;
 		else
 			offset = res->start;
 		length = res->end - offset + 1;
-- 
2.43.0

