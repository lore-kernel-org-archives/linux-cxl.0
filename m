Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010041.outbound.protection.outlook.com [52.101.201.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C9F3F1AC4;
	Wed,  8 Jul 2026 07:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783496621; cv=fail; b=jlZhyCn85QIKw0iBGkTvocfYOJ2JPcBmHD5nNbBGGC7q6ti49UWy5TC3HIJX8Fsby98Y58zxgoLcar7ZjQ50ApNAfGYms8zJjyntwc1QfBDfOqpay+HlhZdXXXua5QrRe+aa4UQ4z3nB3HCWTBB52pULCpM48V1rdnRTq8SBjPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783496621; c=relaxed/simple;
	bh=kW18MdXOTh/8+unYjb/n1LrERHrEGST26xq+lwa8dB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E2ClBoYp+ij5yp2v7no/ykI/1lXqtt2fUUpXLFb7Rl40tN8uGz4ueT1tadZga3bClbSyeaLlVoVyML8JwFLZV2TvR8+CNstV3F4qtsnpUFh47xY6FZ/Hn8CfK+MPNe1BhCIMC/9M9WXby700GIO/jsJeiaC5XVNz+FmHYWP3Bb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WiG4lGZ1; arc=fail smtp.client-ip=52.101.201.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WiG4lGZ1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VE72tXWTueRy5twWo9YG/S8WO2YyyTLhwXE2RZIXPft1+fCFLMiwkx2M7EoojKH2tjUm/WOKtgcxWGY0pHg3iX9JSNIV/g+qSuBOew8rRpXKwWbH9bto8q18Zz3KFXWDHcZutxbvMw9V5adekKPwtB6t5oahRUsVy8adLmcPMP0VrnIh+xJB3IKbE9ckbRfZQo2r8iXkbMtjRt6u7l8Dk2ElCZAmk/YAvWB0WgGc2bjPfD0RWBT80g7a1mX3wtWRhdnjuz+CG0iWNGxcCsRKfOVW6EVzOGUn3F5b9YILC20Y8BKywHdEhZLQ8UooH0LfhIduJWigFjy2mkUGU8IVJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZC2Jur9tx4/N+DlNztLzUtcM1TFZK9JtZTeWAvyyC4=;
 b=DgftE6sgWfdNCNJRhfxxwRSDQpVNTMVZ7mpt6iIMJE+yDkGoWUQ+UkpLqXZmPh8Ie40qpHCZUW0lfXRtZuBr8QZktUgAB47tH05jyc0ReyYvkSiLvhKn0nuhNvvAdLJu5DIRMAHrPetJdzuGorx7PAmz8JcSEgJhrkRexSIpevItshFwJJp8jNUhBn3rtR0YrgYbjNpP+79mSgpWEv8GkUBFNaHKdAhRsmKdcuVoZ3AKQlB2wdE9/TrUdR4dtYWMKdCyL8GD/omfjAVYtoyaNm7QtPTCE47CZDaWyxdXiEtz0BDuG34qIGzsp7gUi0zp3LgnqrivLLBF2sDAHRMINw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZC2Jur9tx4/N+DlNztLzUtcM1TFZK9JtZTeWAvyyC4=;
 b=WiG4lGZ11qmX0sFC9IWwEDh1LHTmPuUrBa7YKGsmTZrRuCCywL/X9nPancB9Q8Z4Htc10EBdLlG/J4eqjnCHBJMpKkbQj1cdxVR675V/hfMIuFSb8iNwUFDEJ2tRvRnlXHkTUXpZf2tZx9jTqfRUuhA5bs5MU4ZZxb8PEgowzHdRgXwpiIYeVnYK8CrDK5kmXlIZ/AyYFff/HXlRfMfTadz5LYw+okNttx+bcJVTQF/mpp58HoETnA156d3dDt8JSWjmTmif6KwKwZyDm/jYhgZKSFp5TEsC5ER69/WEJquWLtozVOZJuPt0GouY0gN3YbZGyW5sQcrJSR86bA/L4g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by PH0PR12MB7840.namprd12.prod.outlook.com (2603:10b6:510:28a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 07:43:05 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 07:43:05 +0000
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
Subject: [PATCH v3 5/5] cxl/memdev: Don't overwrite the error from an earlier partition poison query
Date: Wed,  8 Jul 2026 15:42:28 +0800
Message-ID: <20260708074228.43654-6-icheng@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260708074228.43654-1-icheng@nvidia.com>
References: <20260708074228.43654-1-icheng@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0058.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::17) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|PH0PR12MB7840:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c6aa348-ad0d-41e6-0b94-08dedcc48bbc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|1800799024|366016|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	UPqA5qoaKdOYj8LS1HDgguBX5HbKqGLvZPPiz4ROC0aQY0+Iye889ImEVDSECSB0DPAH2p/btjdY3pt+aFUvU5hiunkiOOU2vw4f6piMYCyzD6gV1q5JvnX4JqeXqwfjo2QOMtd+nbylScW7yqKrlsQNax1stsFewjFSojie7EWMTwlvOc5z1UwC9nQ5XQH+4PXfZWGZr/w62RufL8+2Yc7dtjxpr0XRLhUNdezWiALGvr+bDDN6o3UJuYcTgLKN4hPok0F1x1oy6WZNpwoMO4r/9HDi0H97KIV4uoxxRF49beet2AZvbREntVy9BHoJUNd2L3VHIGMkzNDOZVpCFP8LdW3mVw5QLOHVwTtjU/IrJau/DTC19suNZ5mBqvmN20dSTyWtp/inyys8qkrE8W8KpQ44b+4mM5E0JU1qBOXj+CgJscR4nSwjpQJFg7/lKKPRMG3Fk6oYZeRTKQg10w9yuii56ep49ob/gY+qM65PfeF/utphnPii5CgHDf2uS06fhxMEcrLT6V7Ad2jg+h/26uN/PtpBH+za6YnvzLzfIM2MtbWyVxopMDICJUip3lKp/8BXyzmebv149pt0DDKUbusFQ3D/2s010cu5on8xmQV3tE+i++lUNJ3MsCuk5fle35b/AIh/f9ny4M17T/e4qOt9ZJW3PNRJz1xFccQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(1800799024)(366016)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AKBUNNYK2VJrDZrtvs/YSvRZ99K9PiqlMTAQ9Mpyo1+YzTwb9eITWYspXMr3?=
 =?us-ascii?Q?ilG80phlSALIXlMGSaH8/J3wvRLjGWw6A7V6XMbcqCkINmf7YQGqAl6/Kfpe?=
 =?us-ascii?Q?vN1nNvlz1shbA8Le58Gm88tNJOskIajIYhPve+IM8IMFPGtm92DjdmCqqqV7?=
 =?us-ascii?Q?fXzs4XnRlB5s2qhVMwAEEwfxf2isEgBPUaoKotxUIqO9ZwmAUI57aMGkohAe?=
 =?us-ascii?Q?iBnIu4yYyKnF8UsxJ47iatAF2jXDLHBvl6zmy57/mFgSgnafwaNd2i1XQs2N?=
 =?us-ascii?Q?nSPRZ8hLi7O2w/fjqG0ysg3pSVQ1JGspYTtjvoFYnXr4/SR5svnzej20oYue?=
 =?us-ascii?Q?w6S6tJya8vR4GByWZtmL2wHIGiw8e2g/0Co3j03T3GIs98EUFZcHRdaAcONE?=
 =?us-ascii?Q?7SGmV5nRqaDyxABabtwvE1PwcHeSxga7yuogllqQ6hsxHTASYH3L6w3UMXPr?=
 =?us-ascii?Q?1eitm3IxO80K0fmkog2b/+nA7ikW4U41BGzF9hz3ehU174gdYK6mg+Qy9oYI?=
 =?us-ascii?Q?ZuLe0PBgedv3JFXPIZ2HkZSVhXvC5nC6xmPrWDqXowgGGGhFawEE32Xo8SUf?=
 =?us-ascii?Q?7ya4799wSNNLR69phOmzHBeRi915IPBr4yt+Bu7XdyzHQx9hzJFmL4UOX1Y3?=
 =?us-ascii?Q?J/1M2zoqsRrl3AhC1B1Bk6S5kXEKzzDIk9UQN8azBUO5pTUIiqlouCd0//yF?=
 =?us-ascii?Q?bHft8nkWyQ1vubfDoDhHZIEBkFOJXpuMBe4vMdrDI2OUQTG3VXs/c2oUyDWu?=
 =?us-ascii?Q?ajr+7iiWbFdmh97U2ZQmrsHPQGFfMxi7BW5cEZtiLsFZNdpDAZOry6/oAQHE?=
 =?us-ascii?Q?OXDZdi+qTrxhK9GC3AzQ2TWC890G42gkWiMMfnOLnIl5pD+UyuRNLhiGHDIj?=
 =?us-ascii?Q?Eb7Q3lrj/k2fue9KSA/L4iUNR8nnaCMk1cFLqPaenCkSq68ZcuPCk+g+09Ak?=
 =?us-ascii?Q?DYv6wJjt4S1JT1+UDWraP4oVmaMNreISHiMH8xJkAErDI7dfBWW8fmyBe4dO?=
 =?us-ascii?Q?Y6C+EvAsisC9w8yNx6o2FUzn6KqDK4YWMkPGCtOoDRH6YrZhZM4yHfnKtvbo?=
 =?us-ascii?Q?SP6gtR5qUxDIRqeAJlpAsp7oxRnjgZ6I9VACAxm/ioAa9s//UeUnxh7Wq7Al?=
 =?us-ascii?Q?I03ppeON1xr9RjaVOT4FZQ2+JkI8Cftln5sf+3Bq2AhVLczevQrESmbJGRX4?=
 =?us-ascii?Q?QotLCBrhPagA/KBuTErKTxm/Lhb9fnyuSu2OQZgrXOYOwmd0EzfonPFCOm2b?=
 =?us-ascii?Q?zqBBljZNyjMFHCmDHRCnc17a/KxY2FShLeDn/p44u5pW9RrtUezebMw8XJTL?=
 =?us-ascii?Q?CQ4kl3MtHF1TgjVs9qQCBKOmPvvKw7KAaL9oEtyxv3reXwU04lO9QHaBxLJ3?=
 =?us-ascii?Q?GrPWV21+9k7qJmcjz+WWF9f6eMmsyzDbU3kXfzxg/JH2A4cDn0ZKFZbTWuUR?=
 =?us-ascii?Q?6GHwpam3WxssQTDfPFTiqH/5TG7D9xOfjo8uVZcnTbC8qJ4cmQjzHyLzFRMV?=
 =?us-ascii?Q?gdjn52ztV2hqtGiz9VVemMLhRxXlb3crgH6/iah8GZYsEJjCTwMPRb1Omvuc?=
 =?us-ascii?Q?Kza0KO411nOt7bXE1PCn1cCVB+KesKargdwWIcEeFlHBbzHjOM66ZREePoaC?=
 =?us-ascii?Q?TSGZlLrSv50djGMtjrzPxp4JFxN1vc8skhO3HAD6UttOXXeOCfCxIet0CmvL?=
 =?us-ascii?Q?4Gg0U9j9Pf2pd9Kb4cSGpfpqQQOWvxHdPuD8x251HQ9U37Z2j/Ur46Wazyni?=
 =?us-ascii?Q?/wCrf5brNg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c6aa348-ad0d-41e6-0b94-08dedcc48bbc
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 07:43:05.2103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +IsA36KHcn5uM4Sv0xADczAqWwzn+1OqV4/U/w4fDegDNXJOhP98HX4Y6TfIyYcN/M7Haq7GdbcDnwlbgBgq6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7840

cxl_get_poison_by_memdev() queries Get Poison List per partition but
never checks the result inside the loop, so a later partition's success
overwrites an earlier partition's failure and the whole scan reports
success while that partition's poison went unlisted. Before the loop
conversion the PMEM query returned early on error. Stop the loop on any
error not already tolerated as a RAM -EFAULT.

Fixes: be5cbd084027 ("cxl: Kill enum cxl_decoder_mode")
Signed-off-by: Richard Cheng <icheng@nvidia.com>
---
Changelog:

v2->v3:
    - No code changes.

v1->v2:
    - New added patch ( sashiko-bot's report )
---
 drivers/cxl/core/memdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 33a3d2e7b13a..8718964b9c5e 100644
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

