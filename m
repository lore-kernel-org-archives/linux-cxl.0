Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011060.outbound.protection.outlook.com [40.107.208.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FF2156661;
	Thu,  9 Jul 2026 01:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783561059; cv=fail; b=mVbpsYAKeClpCxZUCVaJwufJVP8JJVsJj0LceYjuzsQfgExibcdplrKNXX7w+JDS1b+TwgKF6f7H9lI5je9fc6c09DGwnALRhORsWezMbh3GqvvvpYBGQ7wtAyQzOol7JW+cDbZW4So3wVZt6q83yua/n0XLJEIwrxrxUhSyZgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783561059; c=relaxed/simple;
	bh=VcqTYqmDg3yAj9VNspiaNGXJ5HwN8CCyAbnpHUVrK20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fURAveHE3qYllaFZ2COiJOGgExRzfLNTjjAqmYjhM1XiKswSR+BNlcDOW8zTuwnW3mXHAY+doMo8Kf8XFInryuppuLq9S6Idx/M11kCRp8kSMxImlVNtokxKKtVDL9Veq29KTAitiFL4zEW2kqlB30RQSm5MdzNBykM85HHA1x8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=peYdKFfn; arc=fail smtp.client-ip=40.107.208.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="peYdKFfn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IOTAklXsXXoHECvN4U33ASgf9qM1ndp2P/cFyGo9Ogp7leWwJFqoxm3a/Qko73JUz8syWYZaO5LAv82Jq/t0+SuirGmft1A+FgsCPXLZC+nMW+b6o53WTGlD6uH+XEfrBMs63UN7KSs2NsPfLejVKw9GaWYpyZr6rMu3iI3qcvM0a1A9wPwDPMGy4TGUqvps2VTvrILzwqs+4vgg2AMtD+HVJNpQZM2pQnAQy8CSqgwSRfIZFbBVx2kf+oyC1QI2vJZiuY3rkUv3PHlP0RSEDwxdDKVQPSF3eKuCJvih2SyF4fV/AUY3/H2P92WPrAYZkzA9Lag9VrYkLMib/ZuRug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yIKP6jzJ3JrPaf5eV4qE0Rnp9Z/fozK8QndHDTsjHWc=;
 b=cBvTWeDbgOjOzeNV7nd57Ph3PVLdiV9EBfvYF4U0VUX2NHWKDVBGcZh48j4IJ29A1FHH/dDdy3roh7cX1bAVkXNOP9NyfYSlnTMaRAblQI6kwo9ffGkhxBT1XoDj6xWZ1LT8hMlf4dz/ySmQyMcPw2chQUwH8XB9TO6QItIZ6eLcKB1CXZj2YYSlvC1Bf8fVjCDWW6ZW3cFaNK2N886l8jazoeRwlw8jw1Pp6U8Oqfq05T9vkeB1iOegkSLqKRsix+8jt6qztRQWSiA1QRLw/NhBIFzxbGfBwG1SoIEJjAYuRrkx9/e0a8jBIaNaorFLTUZzAMMMs8hwf7aM6Q7vmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yIKP6jzJ3JrPaf5eV4qE0Rnp9Z/fozK8QndHDTsjHWc=;
 b=peYdKFfnyDfsOnQnfa9q9lzbAYKA7eNwqM4gAKzGq6v22R/iNMgPdFWpmzK8dPN4m5yQNiH54M9+BuuIlkPNJf/DYGrULuTGar8CYOGVSLS0BRnBq0Sh1QytbOcDJJW6zzp7tPQEQDBxwC3Q5fMzQsiSuglVK8OvQRafciGB/wFe1aTfU8t6sDq9vUSFKBsm34Ell2oF2czvwvG+isARqDRTsbDbcPB7RK4p3JRcliXKjSUZEeJIxVRXEsFEVZcEzYEjU4TFjqf0RikfPIYc9q2EmCgoJY9dullsqMt9fZpz2/5Ym0do7ZKH8hqL1591BVsgEmguptfzTid5O7Np0Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SJ2PR12MB8953.namprd12.prod.outlook.com (2603:10b6:a03:544::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.15; Thu, 9 Jul
 2026 01:37:34 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0181.014; Thu, 9 Jul 2026
 01:37:34 +0000
Date: Thu, 9 Jul 2026 09:37:25 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
Cc: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org, 
	linux-acpi@vger.kernel.org, rafael@kernel.org
Subject: Re: [RFC PATCH v1 1/1] acpi/hmat: preserve hmat_adist_nb notifier
 block
Message-ID: <ak74Kzuf6g9z9pOr@MWDK4CY14F>
References: <20260630143507.30193-1-alejandro.lucero-palau@amd.com>
 <20260630143507.30193-2-alejandro.lucero-palau@amd.com>
 <akYPrcsz2tWl7ga4@MWDK4CY14F>
 <c88a09b4-6478-4c68-87f0-485dc6634af2@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c88a09b4-6478-4c68-87f0-485dc6634af2@amd.com>
X-ClientProxiedBy: KUZPR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:d10:30::10) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SJ2PR12MB8953:EE_
X-MS-Office365-Filtering-Correlation-Id: 77f03d47-3950-4afe-0593-08dedd5aa62d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|23010399003|1800799024|6133799003|4143699003|11063799006|56012099006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	sJhHaITcudI+m6WKtQw4RH2Ni9E+I0AskRJ65HaF/hV5HlwHaTJGnM/gzfg2eY6xl06fQgS1mlYTA+Da0N+ET12hHsON62dq0s5K9ofifaTPvkqCi7Uu30Y/0L21zUau49zsdkob1ThvEbWM+hSZD4EV7laopMBbLhaGCMe1gWUi7GeoU3e6UtuVpcyARTGIhOAVJ896tuoYKSASVju1iuWaRRDVgH4Nn9LkbUaOHR0ik1R/y43ptgjKvvTG1qg0yLxBGNTfzMqnVoT0adVDlikuDfnDzVOXw2iOmgeX4gHW6sCDHhF++RHIMjVLcMFQNqKBfBTB45kUVJh9A8D91MRD9ShEBN6xdxlTfjbBNaFgAaS6X7IWsKPZzX/KhUYmJeY/dPXsI5CRCGAqeFYa9KXNc9VNmTyABBhBkGk8tI1vi7JX8LZ3jrcjdp/6p9fV2yCnrnjnM39JD25EQXX5F/3k5aGyBRxfDhj70N9olCR3xxuVFAFn87456pmAI8onsnS5zRCLPpvnIXJxjy+U4DEBv6WHmDs64z82FEsF0Ph8MEMzcN4vchhLI9zcoR1gaH1V7+mrpm8cG6OyLh7bpV3/KRqen1WPb2iiBaY2UtYaYpHGevti4r0uSugc4uphSIo0p2Q+XpoQgkOe+yzlaJGNqWUsNjjACZLSXQzKjRs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(4143699003)(11063799006)(56012099006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?paDvBSd8Xi+vIK2lvNFDacP3JhhGC6ZTaSh7cP6skoIEtiojziJ+NJ6Jqeat?=
 =?us-ascii?Q?JXzpPmIlsLMZm6FiwupnbL7J8In+LDdANAMSM/YlsBNFl62R0CWkFoK8eZSF?=
 =?us-ascii?Q?Q8JueI1N8UWNj2ut4BflpkgH725UnmX0Y7Tj4Xh9za7kl7zmSc2AbUHeTEDa?=
 =?us-ascii?Q?CYSDUSGJW3TPnmDXTnznXW695YF7KkdP3c0un/l1g/4qRQyhWv8NcaQ88ve3?=
 =?us-ascii?Q?buhvcDVyVeqJe2IzUldFO9Cd4Q+QLd/IThGdJ42JqY0Xru3nOJ7Ek/UpNe9P?=
 =?us-ascii?Q?Zdd2D57D776hY2jnm1kMdYSpCHQgEqUH6MFFbq/eQW8LjmnGhq840Gye3aXL?=
 =?us-ascii?Q?aQ1+qlE8PjT2y0XQclr1Z9R3QnKUKRyKRJHHqc1qCeh5ltC+IRKYHWFO0G8i?=
 =?us-ascii?Q?IdRFCg//2+hN/ppIRVBik0WYhR35AzbuY4C9wttZGX+Y5XPvyXDfcm8Nf+GM?=
 =?us-ascii?Q?yztkcQaGzdHBoAi6U6Ii7uvJYOGbAt5Y8xf/fH4sVLDXN27t0PI+ZB+77cxa?=
 =?us-ascii?Q?z9Id189vahM79nuPZWiiXDGWd2kC212eU41gu/xh1WKvvOrRg0brV38HZ62Y?=
 =?us-ascii?Q?H7LMCpoA9cJxf2drAgIQogNJqD5ycBhmqgsJ3rdaoyvyl37gr9PBPk2bGaCW?=
 =?us-ascii?Q?AC1P8R5SqJedx24tVc6neQxbt/h71imnbVlpdNjXDiva9bn+on8p62eVHsk1?=
 =?us-ascii?Q?dz1dfbk/TuVXA7HeYFIoDBwRGJsgNlxabtwH6M4zIP8km3in9+AqYMS3HceL?=
 =?us-ascii?Q?78CcVl/60y7MVDLybV0ZzzudKoYHzZsiYkOx04348Z+g7kLdU6eOJkiUIwoy?=
 =?us-ascii?Q?+1zmwejc8d5stOdQkvKHjYZWTzZtg5fnpHhC0SkP+HU05XrLNqy/AjIWlOlq?=
 =?us-ascii?Q?YSNHEnw3Oj9tYIbfUFAy+Wh+WwXTKTUzuTB4ERxzq/uhsGd5LpuSP0qKQ0Ow?=
 =?us-ascii?Q?J0yMpLRMMIa14UNO4yxjJZ1I+qridKVb8ukXJbbDDs6ceuEDo3GFx5LRL5Gp?=
 =?us-ascii?Q?dkUuj7LnPYHAFdzPIOrU4nPcHM1lroyAU5zE4R+XtyCPsWGhSWY9naUWw2St?=
 =?us-ascii?Q?8Ffcr1A6BqQZtmzcQNnoB3A/LV/oc0VvtQ7GRZhFMHwdeJAlPNie5ce5xbfw?=
 =?us-ascii?Q?Dq1lMKCoAviYKsgPFxxFWWwVEQKQXXC7ppWptZm+QPzuyG9cczlOoScgu5tQ?=
 =?us-ascii?Q?WZMwgZJA8a/CtyCaTJpN19g39Fn/a/keia3SJQvZ0KHVlgCKagQ00QU1PnV+?=
 =?us-ascii?Q?9CZBNlRUPRqJpRYEW4xexPxoQ8CjyFTFno33R/KFuK6gLwU+lXfWTcfH0zy1?=
 =?us-ascii?Q?ryX9027dFc2h8jP633RG/Hbczjeyx6s7aB8TK1WhSzMU2HFjsZ5xlOe0QJGf?=
 =?us-ascii?Q?ePfr9/bC8Qm0hBu3xfnzPf7rMwN2WFqUEsSnyfJ1LA4t65OkjuGBI81+4nE4?=
 =?us-ascii?Q?WvFKS6550YJhkERaqsxsKuUzfs+k/4A7n/aoBldmsLYu4SzLWxxybpj9sD98?=
 =?us-ascii?Q?kCpfukiZue/dglWGDG65HK/wUvCUQY/mJ+DkUsVVJCMMoWwwo2iqHNa1AUKM?=
 =?us-ascii?Q?AYR4kv5qOovmov6S/M7LMKB6ZmVOmILp7SHoHOy605tXLw7lFFZolBVRZIRm?=
 =?us-ascii?Q?5gHP72HsEhmzEwVmNB3Nhj66oUhCc0zzHK8LQt72qLY5I6DosRKwtzd94iUm?=
 =?us-ascii?Q?FhS6D7Q8pPf2kRN8X4JfkmWesr7nfU5p+C0eCl1SC+vBY05A?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f03d47-3950-4afe-0593-08dedd5aa62d
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 01:37:34.2002
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fdIp1V/ksXDp54oz0BIZ59xm38PO4gOlNKC0dnn6sxgiSrHziIafcaAJjyNIDEP6yyjsorievof7RzUy3UIcLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8953

On Mon, Jul 06, 2026 at 07:57:09AM +0800, Alejandro Lucero Palau wrote:
> 
> On 7/2/26 08:20, Richard Cheng wrote:
> > On Tue, Jun 30, 2026 at 03:35:07PM +0800, alejandro.lucero-palau@amd.com wrote:
> > > From: Alejandro Lucero <alucerop@amd.com>
> > > 
> > > Remove __meminitdata from hmat_adist_nb declaration preserving it even
> > > when CONFIG_MEMORY_HOTPLUG is not set. Otherwise further notifier
> > > registrations using register_mt_adistance_algorithm() will find a
> > > notifier chain likely corrupted. This is the case when a CXL Type2
> > > driver will load after kernel initialization and a CXL region created from
> > > its committed HDM decoders registers an mt_adistance_algorithm notifier.
> > > 
> > > Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> > > ---
> > >   drivers/acpi/numa/hmat.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> > > index 9792dc394756..3006789ae31f 100644
> > > --- a/drivers/acpi/numa/hmat.c
> > > +++ b/drivers/acpi/numa/hmat.c
> > > @@ -995,7 +995,7 @@ static int hmat_calculate_adistance(struct notifier_block *self,
> > >   	return NOTIFY_STOP;
> > >   }
> > > -static struct notifier_block hmat_adist_nb __meminitdata = {
> > > +static struct notifier_block hmat_adist_nb = {
> > >   	.notifier_call = hmat_calculate_adistance,
> > >   	.priority = 100,
> > >   };
> > > -- 
> > > 2.34.1
> > > 
> > > 
> > I think this is not limited to CXL type 2 device.
> > cxl_region_probe() already calls register_mt_adistance_algorithm(), and CXL_REGION
> > depends only on SPARSEMEM, not MEMORY_HOTPLUG, so with NUMA=y, MEMORY_HOTPLUG=n, CXL_ACPI=y and CXL_REGION=y,
> > any runtime CXL region probe walks the chain. I would suggest some tweak for commit message.
> > Also adding Fixes: 3718c02dbd4c ("acpi, hmat: calculate abstract distance with HMAT")
> 
> 
> I think you are right. I did say it was not affecting Type3 because I was
> assuming only Type3 regions created during CXL core initialization and
> cxl_mem "active" before after-initialization kernel memory release. I will
> add what you suggest.
> 
> 
> > 
> > And maybe keep unconditional removal rather than a consumer-keyed attribute.
> > register_mt_adistance_algorithm() is callable by any runtime module,
> > not just CXL, so a CONFIG_CXL_MEM-keyed condition would  still leave the hole
> > for other callers.
> 
> 
> Not sure what you mean here. The way I understand your comment leads to
> contradictions ...
> 
> 
> "keep unconditional removal" suggest to me unregistering hmat_adist_nb but
> "keep" confuses me as it is not unregister now only memory released based on
> __meminitdata ... but maybe you mean exactly what I did and avoid any change
> to __meminitdata declaration based on a config attribute, what is what Dave
> is suggesting to explore.
> 
> 
> Please, could you clarify this?
>

Sorry for the ambiguity, and yes, the last reading is what I meant.
I mean your patch's removal of the "__meminitdata", not unregistering
the notifier.
I think it would be better not to replace it with a conditional macro.

To be more clear about what I understand,
1. with MEMORY_HOTPLUG=n, "__meminitdata == __initdata", so hmat_adist_nb
   lives in ".init.data"
2. hmat_init() registers it, the mt_adistance_algorithms chain will hold a pointer to it, nothing ever unregister it.
3. When boot finishes, free_initmem() discards all ".init.data". The chain still points at that freed memory.
4. Any later register_mt_adistance_algorithm() call walks the chain and deref that stale pointer , causing use-after-free

Note that, register_mt_adistance_algorithm() is an exported API, so any module
loaded at runtime can trigger it, not only CXL. Dropping __meminitdata
unconditionally closes the use-after-free for all caller, and the cost is just
one notifier_block staying resident.

Hope this clarify my point.

Best regards,
Richard Cheng.
 
> Thank you,
> 
> Alejandro.
> 
> 
> > 
> > What do you think ?
> > 
> > Best regards,
> > Richard Cheng.
