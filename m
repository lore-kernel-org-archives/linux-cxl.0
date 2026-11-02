Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.33
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793605321;
	b=qihtLctu94po2I7t2VzEz001mMeQcDh/sJN/cTlBiEhzf9ypi42otKu72cAXtWSU2twW
	 x1sMy5AqZbonC7i+CBjSqTRSWywt90HJCElI8Ek/zRYlU0zN8QN0sNoFUDCsN8dQxrZec
	 rXJ+SD1SJCPJZITzKz/2xbN9XlOdhj2lHbrFHpl3OFO0QbxXZYcWX/oL2AX8NBUD2/FBM
	 ab3pCjkJRw6TnVlsNDashAWVCJEruwlknIdHcE7OyHdHiRkgDAFGRYC9dA+Vc37iKFc2R
	 8/EAmsYZ5Jegi4koTVwJqefSBfvX0XmvD3A00WnYjRCU+qY94qaKioGRQCbf8rPE5Tg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793605321;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=U9FmB3i/J603ogsEwVeiqr6Rab02heo9TBWOX7LTCJc=;
	b=3fbsJ/FzsB4Db3f+PbtEIhHLTPahyOOdiCEIV+y6My56xXnHxQXTKoCPabvyvxgzimNR
	 ZKD5gku7Hs86851nohZFX95RenGUW0YqrBgXFBPGjHFzK2s8U2D+AKBssBXX3NNOAEp/3
	 SwDFItDsgX9xQkwFf7bOHbg4wp9TAuBVhEIIA33wx6oYt90gAckoUVidSyex6gEBEdRN4
	 wJwkx0GPabVLTb7UV39uS/f7JKoGt63Em4SZIXzUZUV/CtCI++iMogYPRZVTq5qbmVcaN
	 ZP554Oz3VdKijEw9vlaqv2CZRr4foLbmpTyxM+/Mx1Ba5uDHiyhPePopFXtoNnaF0Xw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mhxndCF+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.33
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011033.outbound.protection.outlook.com [52.101.52.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3572606A331;
	Mon,  2 Nov 2026 07:42:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3572606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=mhxndCF+
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=My5+pNRTlJBId4Gxh9tbDovrcw4PCZERax9n4rQSAG1cQx7zxGcfVCxpneKE/Fmamp+faySUTtmPyTWfNK73L4jnpbsrTyERAEPhyFHM2lgkr9nWtkI8BgpejET4icGbHKh4aruFXZQY+SHNykjtGAjyryA51Ugxai02lfaNX7S8XK9YlmCHgvNanwsuz5GIbulDBnUcAoRiwoUu4W7p8EXLGVwN8JF9XOavWgttpcdYHPca3Y/+0QAW3+wfRIRF9ii/w5JIr9dteAtkOTGjRe6xpbKG86RHeMnJBvLCD2sJNnAzVojt1hKpxaFqAJiA63MNVW1drs2/A2SUz3cHkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U9FmB3i/J603ogsEwVeiqr6Rab02heo9TBWOX7LTCJc=;
 b=WaiV089w6e27sk9alBGAqbLlDy8GOuu/22iYWTG4SQnAQieUi2QJoyNcu7Wvtv68u/AqgqDk4F86x3PvYXwoYU/J4f1vm9Djf/TXtE4/G+kC+y3HwNyO9Kbva4/eQDKDq19trkEqx5b+CYFpUwdnB32R9b9m9FUAdVWrD7BnJUrQFMASweNx0TkWUDSRwScnXCYty9UZpb5bZ9oH9DYpWcWUWRYneDtIdSpfsoff91fwgnFtIp+3+wVajnYbT7+GgmIIYEqv6a8/3A3TzvsGwPJsW7XBQbdjzwoTok7f5CdQslSwhQjvaAAey5zdcD9TelznK4tsk5YCelaKysZf+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U9FmB3i/J603ogsEwVeiqr6Rab02heo9TBWOX7LTCJc=;
 b=mhxndCF+qrDaW/ZuRij7sVm//NgRDZl5yZns+MePIkDJSH6C/wue6JA3tgmdPfQntx/hbPavg4KY0s2Vjxkq6AjOeD+qTTgq4EVxPiJ8UztPbo3GEKqp0seQhKXLkTswj9iCHepHmqgwxU3D+NFN9AHbbOzsSgP6FDM6WFedS3clCpH6CBo08UAdOH7ZobysMcOWa8ubZ22Z2bf9eqW275o+M7ylG3L/RSDD8QDSvZxQjrqkfSLB30uIzLAC0VVKzaXK6k+7SpsLMY2Lf+EBLnM8Wj2Y1Ham6TN24HS/Ne6/6E4CsuYud5s3SOOk+1IKt9FU49J3Op3K+DzfMPTyeg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by CH1PPF0316D269B.namprd12.prod.outlook.com (2603:10b6:61f:fc00::604) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Mon, 2 Nov
 2026 07:41:56 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 07:41:55 +0000
Date: Mon, 2 Nov 2026 15:41:49 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Jongwon Lee <ai@linux.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, 
	Jonathan Cameron <jic23@kernel.org>, Dave Jiang <dave.jiang@intel.com>, 
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, 
	Dan Williams <djbw@kernel.org>, Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] cxl/edac: Fix event record lookups for memory
 repair
Message-ID: <aug-fvSTBNsdUd9J@MWDK4CY14F>
References: <20261101013418.87326-1-ai@linux.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261101013418.87326-1-ai@linux.com>
X-ClientProxiedBy: TPYP295CA0007.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:7d0:9::12) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
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
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|CH1PPF0316D269B:EE_
X-MS-Office365-Filtering-Correlation-Id: 16254ee9-d34a-4ae6-4087-08df38b4c438
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|260925021311599003|260925022911599003|260925021911599003|11063799006|56012099006|261026121527099003|261021123027099003|261021121427099003|261009223027099003|261026140227099003|261028144727099003|10067099003|261022105027099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	u7rU7GmwR2ViqzhOsLEAbxjR5ZhsDui4o3jb8oE+wHsMfWMvpM10hZT9iNyMXzouGjMDslYe4qgcnw8V3SMMFhYSbCK5Vvdf3x2ZxG628Md341Kl8FgRunm2ZiPLlMOsXq3gqjSqGPab5rUxqOV07ETahrKImonqznfvNWSi+WMwFCW05Br3mYrEonmM/kbGPlWy7yhKZbemvLpK2wAqCplKYPJ4RMCsuBDYgRuEwfwwHY8AzA4oj6uKE7y6M6AHMbcPKptCAFOijyn3qUlwI6md65Ll9uWabKc1p0BL/OvWxSF5sadzgjaECHnI1jkqA+giiKIht+tuuBNTSW7F1wI+J/BMtE3w+eoduISPdq5x7PNxtDoGEF8T2kM7qMGV1XCJlSedS7RkQJYdWHYgOa1Dna0KXpPMXI0/ujKMpLCuVj4QTQ0PnlwHxJr5vFw4UCK0n4L66saA1Ze3GTrGARD6AEQAXcqIaRcMAQO0XNXoalSNpLN/eimSS9xra0ntqlNSj4L4yVY3ZhXA2UlgLzV2pjS9V527tnfVNmRM4+FpHBwpcYcrQTYHVvhEtsiEDaeqKhYPjZ527JD4uN9kHP4ssBvNYhaiRqRsZiW5KkAm0flNaFyl6kEbbPLHfikgeUVTrhIWl7WoqkVJ55g2oPPwBfLRRl+x5ZoGzRCk/dc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(260925021311599003)(260925022911599003)(260925021911599003)(11063799006)(56012099006)(261026121527099003)(261021123027099003)(261021121427099003)(261009223027099003)(261026140227099003)(261028144727099003)(10067099003)(261022105027099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DlaJCCf/AFZQ/Dc8icgrEogax9GtjXYM6eBGOiOpMDJ1m/pHFXdFqQ88gZPf?=
 =?us-ascii?Q?+BeficMU/bqBfAoKSqYkCahHsFCeqD6pV/OQhk+iKP//xQylAruAUJMrOSqb?=
 =?us-ascii?Q?NlgV6T2pgY3lqDR5PAt/4rJK/HblXx7yiyE8SpFmeDDzLdM6YC77M/JTRxpq?=
 =?us-ascii?Q?rsTTr9jWJr3SpZvK9Ihy6tSeqlKUnizXD34MbMY5yU1IAJ7/ap8CnAf6idjf?=
 =?us-ascii?Q?PKeJxHyjLCGyqBV/p29d0w/GngR+7wHARxrQwBoyEHFzU9WItnmzTcpNHUni?=
 =?us-ascii?Q?u7+EVZn1gHcLINCmaSwvUHsMSVTADZ7cMF58n3h4vQjgfsmhqWV/Xrn60CJ3?=
 =?us-ascii?Q?Rs7TCRzVJhRv8tJAb9PhVOp4tz5msFcdhzAyyQJZXwWz46fQEb6s6fnK9/Ds?=
 =?us-ascii?Q?h95OHakxnDT58A1aix6ksIKTc/QcGl+eDM6TwPbRLUR2MOJNU6XWw5Hb2BSQ?=
 =?us-ascii?Q?1oCYNqkwt9Hbnvoy8iXV3/JV68JE1Jme40FpdPZiNer8dPXidQg4DPUT2ZDu?=
 =?us-ascii?Q?QHVi4q5w2rUEqLlEi2lesaRL0hOy9SJZWSczu0qaRO+kJp3hab2Os7OJJ6ZA?=
 =?us-ascii?Q?rGeRyCMuUNFwibRlNyZ+KOxAalxupue62RJKVq9PtAgXlkN9NmwElR24MEUL?=
 =?us-ascii?Q?BHCBovDShdfE5AQp2z0w3yF5PP0NrsUeVj7YwO+luA8JRVr72zjyc81QPdKd?=
 =?us-ascii?Q?OLsRbeeLVFVzznwx5h4KBMd60vYVtUKHEaQOW5uWHy01US2MyZbilpl35X2Q?=
 =?us-ascii?Q?Uy4unZnF2IM9baHtB/DPluCsOE1aQoxmqKIWCBmRuVDUZ+DSP5KoMlRumBSS?=
 =?us-ascii?Q?pBuLUouMY/VTk/BWcugiQw4pPrUL9ojjEy35Tbw4/7NssBBd8ZhnPzaeFGTB?=
 =?us-ascii?Q?f+XUE0VY/KkthPGZqHkzmtZ1D0MTbblCvKNBxG67EGtEUbDHROu4C3HMVAFq?=
 =?us-ascii?Q?/C6BLiIi4DkDqlhmlS/zoX0cQEloOWAp/GbcOOIjEsbljF19Uk5vaiqgw0FG?=
 =?us-ascii?Q?Ma67dQXPhKpCdeu3y5oFCs7hNX+p+XTtrpPoe7q0HhpU669R6fygKWHVTJCK?=
 =?us-ascii?Q?nNrlYPT2Bugc8QnlMTe+gTwqviJo+WSaLMQG5nY08yjDAh7oqVIRP7qhO370?=
 =?us-ascii?Q?kM35qJf0K6ujREFuhr/1FvVDFVDEdReBZ+Od4W0INR6jvHT7fl1aaYEcGQFZ?=
 =?us-ascii?Q?X439r/LbAIUyan1NQ2JvZogB+V2hPrIJytdvLFnCADim3QxlRXyHsSykCOCZ?=
 =?us-ascii?Q?R2tWjBYuG/JnnpVAYkvnQZo5Gwxe7RkuaFaG4cIybazu87LFo67ELTY6m4rv?=
 =?us-ascii?Q?w758RG7AvtE878izqxZQRnKDoonEHkxMJGzFTu+y/AI/SwLB4bBiUOEqlzHi?=
 =?us-ascii?Q?cMUsVIft07hTqgf4k9CPYAAyup0vzefFtjY8hXalT45M81RuHlsVhzVgvSmR?=
 =?us-ascii?Q?wf7r34KvHkypdOXmZHQ4zi9f4ceIZqgcFBW5tj4+Z5lTzTwtymZaLKTY/JKv?=
 =?us-ascii?Q?0o7hTcogAYCxCm1fBKYlZN7MT+C9jAGQuzbFLJwst1AQdqVX0b38h4fgNr2n?=
 =?us-ascii?Q?OjDYcL6TTBW5ewYhgxtkJUNQr+0Fcjyc22sOF8McwNTX+dW6ZcI3VN7B6gAs?=
 =?us-ascii?Q?736hAElaZcqpKM30uopbBeoj2e5g/p/LTJnYrjgEaGiN9U4vmXXdWz8wVHwF?=
 =?us-ascii?Q?QagS1VzDO7LBhdEXQdfz2uQhfBs81X+yPdxrQATATKc4rrGRAsZlBx+PJFk6?=
 =?us-ascii?Q?//DlozPoqw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16254ee9-d34a-4ae6-4087-08df38b4c438
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 07:41:55.0874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y7v4GfIlMA18a6BaBK4p2y0/mBYDmUXPxincuahdjywTITfOlvN4ZYyypBFNyFDrVuIPazuj+iRmY5uBup4Hqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF0316D269B

On Sun, Nov 01, 2026 at 10:34:18AM +0800, Jongwon Lee wrote:
> Patch 2 is the DPA flag masking fix from v2. Sashiko's review of v2
> pointed out that the repair path reads cached DRAM event records with
> no lock that keeps the event path from freeing them [1]. That race was
> already there in cxl_find_rec_dram() and cxl_mem_perform_sparing(); v2
> added one more read of a record, in the General Media lookup.
> 
> Patch 1 fixes the race for the DRAM lookup and the sparing path. Patch 2
> does its General Media lookup under the same lock.
> 
> I used xa_lock() instead of RCU freeing. The cached records are copies
> of the spec-defined event structures, so kfree_rcu() would need a
> wrapper struct with an rcu_head, and the lookups only compare a few
> fields. Taking device_lock() in the repair path, as the event path does,
> looked like it could deadlock against unbind, where the EDAC sysfs
> files are removed with device_lock() held.
>

Hi Jongwon,

Small nit, if you don't mind maybe place the description of patch 1
before patch 2, that will help us when reviewing.

Some comments in the following patches, thanks.

Best regards,
Richard Cheng.
 
> Changes in v3:
> - New patch 1 for the record lifetime race (Sashiko)
> - Patch 2: General Media lookup under the xarray lock, returns bool
> 
> Changes in v2:
> - Moved the Claude Code note below the --- (Dave Jiang)
> 
> v2: https://lore.kernel.org/r/20261031161121.15948-1-ai@linux.com
> v1: https://lore.kernel.org/r/20261030072721.31970-1-ai@linux.com
> 
> Testing, QEMU master (b574eaf) with a CXL type 3 device, region
> committed, KASAN and PROVE_LOCKING on:
> 
> - Same test as v1/v2: DRAM events injected at 0x1001, 0x2000 and
>   0x3002, then a repair requested through mem_repair0..4 for six DPAs.
>   Results match v2 for all five repair types.
> - Race test: the host injects DRAM events every 20 ms (the same DPA
>   again and again, so xa_store() replaces and frees records, plus enough
>   distinct DPAs to hit the 200-record overflow path) while the guest
>   requests repairs in a loop on all five mem_repair devices, 300 s.
>   A test-only mdelay(20) after xa_load() widens the window.
>   Unpatched: KASAN slab-use-after-free in cxl_find_rec_dram(), called
>   from cxl_do_mem_sparing(). v3, delay inside the locked section: 3780
>   repair requests, no KASAN, lockdep or WARN output.
>   Without the delay neither kernel reported anything in 600 s.
> 
> This series was developed with Claude Code.
> 
> [1] https://lore.kernel.org/r/sashiko-outbox-192042@kernel.org
> 
> Jongwon Lee (2):
>   cxl/edac: Read cached DRAM event records under the xarray lock
>   cxl/edac: Mask DPA flags in the event record cache key
> 
>  drivers/cxl/core/edac.c | 112 ++++++++++++++++++++++++++--------------
>  1 file changed, 73 insertions(+), 39 deletions(-)
> 
> 
> base-commit: cf15f9f2361dd4002203716b7b878393c0eee4bf
> -- 
> 2.55.0
> 
> 
