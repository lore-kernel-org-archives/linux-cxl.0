Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010041.outbound.protection.outlook.com [52.101.201.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E693F86E0;
	Wed,  8 Jul 2026 07:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783496592; cv=fail; b=Vnyhp7X8RG4nZfik31z1VuuV6pdG0MFsxTFfdn/qeBiJd4u3irHr86o8kQu2o92gskICDkIsYIFRgcjaUM2Oed82UYzoIzAzh6dxux7iRUkN0aRTvduco9AC/wnf0Lyl93oCi3Ebi+IMB1750jWT8TxQk8EUYKiC8SpMsYpUbM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783496592; c=relaxed/simple;
	bh=mBkazddkycq4ZjnWBsv8HsxK1KpQZenCFAb5mF0u/xM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YXCVHn7LyLAZY0mfqUpsV/sbhq3eudr8nMVbikFLVC04S6BTJOomBP5kqIY00+LD+IjfUZDB9fJdpY6XSD2xE0ZOxVim3sx9WLLglnVlK5UhZywvxXnVPNxZFP2u4DzKYXZYUl+fGGBxEUEzHLg/7aoc+JUaEOTOkmx/ombCBWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l+96n85U; arc=fail smtp.client-ip=52.101.201.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l+96n85U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1PiCM43G/kQsGNfL7BKH4JIfw+dH1+lC5m4Cyfl2KIj2ftbWQlVpO5ScF6T5+c3aGWuGmoYdR4wNH3sQapHvrv7cjkGEcr9X7tGILTXJc0pCfrDG17AsbGTigaYOCBEJ7cq7yB0l7vN1djfO17ajqSG4mj8x2o6gvgXfWaOWpFwBkt3+3kV4bQ8kiJWJRIzVa4YKTmto/PQrGNh/m5T47PAIFu74luNTjtBl1Nmrl0If7uRhKncDKeLQpNXPPIsTet2AUm5JCGxiCdlnouA/pwLEjUTc7DCSZMkzANsithNwvK+ONV27i1uuyrQsZeRgJ2UhhUOZ9YZyYQcAzQZZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AQFvtrHd/NXkSV0BbFKm4ffO8tOCDCtIZ3Trxyz55t4=;
 b=mFXTDaW64WtvmdjotnyJBBBJsJpw4nU/AFb+I+upCvf46oTJA6I7AWaLGdmOZQ5/7RiVArf8ksKEeG+rs3RBQT/znVgfAhpTM4chxSo1fWrofJ+QHr1wgUd0cUgD35sKkNdWnROAiZIL78zuPR9VJUz+kQct/aKKtwEv8w+TbVNFKuX4EHMQ3AuSQs3USeRwdJNJQEAFOWNFYVq0evulh93mrAZVCcVwoZIViuxW0eTnSi+33e7QYesjB+UZLHv31Zni1JkKQxpdBE+VKLgN7HjXXmSZzWI9R7Hjpcjd6vD8Brg1eTkFQ0zmZ42JP/AJmjWvfnNl6tI+6AsX+x7Gzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AQFvtrHd/NXkSV0BbFKm4ffO8tOCDCtIZ3Trxyz55t4=;
 b=l+96n85U4G2Jsd+UWm/mcI0xixe5e/IAs5dJZXb8v0LXimXC/StC/EFIvMSxwSzP3/mw+Rw/APhEP7KOMeG0WYHnRutdu8el5aSwPUi2u5ibvVKlqcJEO2bVRARQkOKurMuPlY1P8JTeksAdSdLBGQ31ZqwWWTE14FMiiCaBZAchaTNxl9SaCplGlwRbkWED4ffYekBoOuxYEXiGI1cb43loNFqAOjO4XdAaH2gQdcTC0p3xpOCRs13Jt3gaVdbCMIKIQ5Yzm18zWHWd2Wg4LpHM7cEBm7mlIp2/I1kG/WfG38fMolN49QZ4I4X7dVEfyJZD/MG5F/TzY4R/uD6b9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by PH0PR12MB7840.namprd12.prod.outlook.com (2603:10b6:510:28a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 07:42:47 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 07:42:46 +0000
From: Richard Cheng <icheng@nvidia.com>
To: dave@stgolabs.net,
	jic23@kernel.org,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	djbw@kernel.org,
	danwilliams@nvidia.com
Cc: iweiny@kernel.org,
	ming.li@zohomail.com,
	gourry@gourry.net,
	rrichter@amd.com,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kees@kernel.org,
	newtonl@nvidia.com,
	kristinc@nvidia.com,
	mochs@nvidia.com,
	kaihengf@nvidia.com,
	kobak@nvidia.com,
	Richard Cheng <icheng@nvidia.com>
Subject: [PATCH v3 2/5] cxl/region: Scan all partitions for unmapped poison
Date: Wed,  8 Jul 2026 15:42:25 +0800
Message-ID: <20260708074228.43654-3-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260708074228.43654-1-icheng@nvidia.com>
References: <20260708074228.43654-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TPYP295CA0042.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:7::20) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|PH0PR12MB7840:EE_
X-MS-Office365-Filtering-Correlation-Id: e9a81546-243e-4b5a-a4cb-08dedcc480c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	WjUhOVCavVjPtLGKZQqfrC6GuXeZZKakCRIQDuOu+8r07+KZuMMHFxihCPx1hz1il4UXLs8isxIQX9oRpB0Q9AykP3TGdK2n67JchLFKgxxuO0VRNqPdpJL4gJTHAII9Ztz88qswex4UmzEtV+WoPpwKicu5e2GIwOTqrVXl2+F4LkGYf7+ZC8yDyBDlpjb0ap5pzi5H0cA5xWQsmT2E235L7jRIlvlJ/xLzQh9piLFQs3hlYRfxGIRj73gfHjviXR63CN4VeHv8d5esfD6IxN6hgJW7Ok5HTtY9VJ8wyQtgr5RlhrSw1cs3ZoQhp955g1gNUdRuJScTG5xV33TNjrjn5+tO7tV2G/hvJ9cZSJIDGVjBcBXKX8W+UVtnnZrEw/R630bcXFFsq44kkTgWlA+yChL5mMLBs+/jMsYnesB1mtRtyx7aldK6eUcGewalIyxEX7epdbHtlQYv4u/dp/xmwcTnWxAfSDZt+fd3agl5LSgFvK6tQj9KDdSI0CPbqN7YNQEe3YFnuvfXiYFSpYUBkVyTI4RAPyderpCZIvTG/vgu+T0lAPna6oUI1CxkfZWXXFtdSzdFQR8cBMSh9SbdN/XBtl5/kxU7+wZBqKbBiyZFz5RJmPRgsCufkMGpClJumnI0lGg9KUc5YKhPdSK1p952Dtn2CxUL23yZswU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3njZ/e1fQa7EgyyqViXwA0FFTOPvzIhOgxiQjdCkG383rVgwdyMxpuYA/q7x?=
 =?us-ascii?Q?n1+PxYS10nFkrJhgR/junm4r7hTtA+Sw+2bboVImqiYTptEVK6Gd19iijMct?=
 =?us-ascii?Q?W+lik5fVKnRXnFqmNWwrTpfYJRNR/TXMba8srPwbQ0HoyHMTykjNL/3e1VFH?=
 =?us-ascii?Q?gkxJODrXJPRp4JuCgWQacNRdit3qBPf5AN8dAlVs4nz6eVaDc7UkUH8Ds1OL?=
 =?us-ascii?Q?zuQatOSUvCA6LDSVfhFRz6rfgzsqbiFUyj/hozEnxBPj4sk5jCNH9f8JuDD6?=
 =?us-ascii?Q?MDIaTU9vE+xqXJ9siO4DEEpuOb/KB3gXuH2oRJVReGC3jVoaWj6d349ItN7x?=
 =?us-ascii?Q?SwCzRVZ0tyxA/h1y231d+qbnfPS1JNDJY/L4Z3UQcTmORS6gQASS1t+1wqyX?=
 =?us-ascii?Q?n7TVqANrxcBnm35GBsAeFAEUktHizC+QXGxs3VrZ9dl9mgRXXY24caeRFgra?=
 =?us-ascii?Q?UZ2MtFKIUm6juKBcHykBs853Llds9YvmJ2Co80Ck2NQeZ1We4Co0nJ+KLdqJ?=
 =?us-ascii?Q?Qd/y1C1QBO+rRZsvkcOGaELaAK+bHPaC4KFyXp15TDglBSO8eFNpf2flxl8r?=
 =?us-ascii?Q?D8H6O28/NWDAaDSpmGSJq1XqPUSNxIza1f7ksYoo09UInjzsHAag0okbp6dW?=
 =?us-ascii?Q?brAgQ14aHeORJLS6WpRMzdJesKjftn+s3krCto2ntrCNiOLYqxA9gXA6J3h0?=
 =?us-ascii?Q?MUw2F53yPSFBKtXKmeq6HuIW0dStwglyR4J57KK9k1XmeFgHEAC/7NoICI/u?=
 =?us-ascii?Q?tUHeb8GTHFvkpjfabJxeHcsF/mEE0JVT+YDvwN11RPNtUZaogrnXtyzXARyC?=
 =?us-ascii?Q?G1fMHnrWOaMQZOJNjOynNoqkLoJM9luz+dBgsrPs43PuESGbKFRr+gNYtDwO?=
 =?us-ascii?Q?deo71NgWpvEwPXNN9MbNNs/yPGK0XZPMnXZcpqSoCoz4quibToKDVhK4U2dU?=
 =?us-ascii?Q?gpY6iqLXyCCXLeI9Sj+hzdV/49It7N5E/8+GQqURygrqyUqUVyAUlz6k0F2D?=
 =?us-ascii?Q?oqHwSGO/naE/Gx+L3XHFoXAcxBmfd/9aizcYqiNNtp2HWn+GOpF31Z5st/Es?=
 =?us-ascii?Q?K2/SbXLtKYWpXJHvx1x4aQDCHxA+DrmwyYPQXpmOzWtF0liGaZhR3684A/ch?=
 =?us-ascii?Q?ImTXVHQXkYgn11tgnR7IGwk7hqyVuHI+7ZC0MnZjxdObpC+uUCa2nuWfCOc7?=
 =?us-ascii?Q?0xzUPZtWLJJNCBMo/2FZz5yO6RnZvIchAddvzbap3VFYxldU6Jnc2W07Yirz?=
 =?us-ascii?Q?vYdembIU2CFHJwXyUKVRNOe8jbI7uBbRq8/yBWib8XH0+GOLaWZP75zfhc/L?=
 =?us-ascii?Q?fZC97YuaqTq9M2jE0oYOdz8svIukX2CBJorp9sV/3ahJwq6qsSbo0Kcbovb/?=
 =?us-ascii?Q?XQFLrlEcsvpSm0OSWpZg2ZPu9ecQuICSItToflqvzl5TEiDNAxycghRVAYnu?=
 =?us-ascii?Q?T5b0Eu46fI36zwchnXIED0sUubxdegEALzQClpQfN9sLrmBgWlYG02xGcoGE?=
 =?us-ascii?Q?iJOWe15OqkROVIQPVk2a+BncXr0JK0qgeEhdIozr5OI5CvyEge1w8JZMJ0hJ?=
 =?us-ascii?Q?USObBiVPUox93ohjnPvJxg2WPTdrFYIm9JEmLkvVHaQkmbgUXNcvl2ebFAyO?=
 =?us-ascii?Q?qi1aJQMLFUCBGuTYSeFqFbnvDdFUrwtqfKEYj5cwpJEOIQv2ZMn4MhyEyWJc?=
 =?us-ascii?Q?jpr6Ldb0hTynUUK6r5WWFQAUeBN9T4KKiArPicCs1s+EYbroFrz3Rsg2sKY8?=
 =?us-ascii?Q?MAg93bm2/A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9a81546-243e-4b5a-a4cb-08dedcc480c4
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 07:42:46.8379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W8Us1vV1CttfGOMcK7/s7M7iCTIVymVcUzac2OkR3jT/RfIdtwyLxlK+hVt8JgJiyY6/dcIttcCnCfgnWzRhNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7840

cxl_get_poison_unmapped() sweeps the unmapped tail of each partition
from ctx->part onward. A fully-mapped partition has no unmapped tail,
it's a normal per-partition state, but the loop treated it with break,
aborting the whole sweep and silently skipping unmapped poison in all
later partition. Use continue so a fully-mapped partition is skipped and
later partitions are still scanned.

Fixes: be5cbd0840275 ("cxl: Kill enum cxl_decoder_mode")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Tested-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
Changelog:

v2->v3:
    - No code changes.

v1->v2:
    - Tweak commit message
---
 drivers/cxl/core/region.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 1e211542b6b6..be246fb09c99 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2931,7 +2931,7 @@ static int cxl_get_poison_unmapped(struct cxl_memdev *cxlmd,
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

