Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2072.outbound.protection.outlook.com [40.107.236.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12826DDA9
	for <linux-cxl@vger.kernel.org>; Fri,  7 Mar 2025 23:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741389013; cv=fail; b=VOiJg9nRzyYufYraCzkedEeCPvfjcFNJ58l5Z8HcHJl4begy0xffTJ8ZpFBs+IR+iYhkMO9thR+A3GNsjKu+R5img3xuG/P7xZKAwC1Yi3mpHBmb/1q7ZesHUPkhydV5rV4RstJM9LWfYT/UOjpT5PEHGqg6JJDbECFkC4gZEIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741389013; c=relaxed/simple;
	bh=+wkmedFovaPH1MIqbIzjxd1t9liH+CS4NtasqCvarSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=APD6u/q3sW+C6Tnx/+OhMHuC0ICpGohY5ob2fQe0kqh4HT4i0zqFG0szxqBb3FON6D7tGfZ3fDidkEVjEB25e+2Blgg8eJH4Xkb6yV35VAnMB8J0WVgTQbmrShj419wdfekB2+ecgcs33rnDmOFIRtlQeF/Q6iTIflkxpte1EMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pQ/Gf8gN; arc=fail smtp.client-ip=40.107.236.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pQ/Gf8gN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uc8W00KAJVvsZ/j05FA+FKTm1j27WfrelWotYT5k1CBP2kZB66IADJLKwxTj0DStHzrk93YOVkuW8ezqxBqoBAILRzrhQubHz89Jl3Aq5O/H/Z1DdErGaAX7Ds0u89Wot8qjKl2LtjatmLMf7XLbCOlUCwYVvDHF8aWMHZwTTLZzyLk4z4j9EbIv58AI1ZNjoQ8UBudPnG8CIm5eskuE8es0lRoeVL4IUkEQBWhU4cUGvLdH6dTtnOGOCueHhqqXbyI8meVDXKD2awyjg15IXZ+XUn+hulfjEkQMXIMjKAMNKUxcCfx2P5p9W9XvtHGPNoNH/otM+lIQhdDDxEy+eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKoYhku3YFpSd9mlbV5y3jR7ZAJCLr/YHYdP/bb5TaM=;
 b=Hh1RAk71CPhPaM2gOGQBONWW1rGfpcQPMkBjDVqxJnWS1mbkSBrGcYqOcgYSLaL7B2HfjcLpr2J7PmKtd0xoUldPteYG373a+2c6OilmV1eVaTzoLpZdbee2k/bi1FxGPL4yM/MEEzJq1GzmHRDniq5/CIf3DyHUDJR/WfqiMCFRUHk+ya1AEv58RDv4NaZ6L6S6gaBotVVqs2WBNHOxHClbl9g3uLy1de/8f1nmaHZsIF5CCo4+GOFt9vZ4eRTJBoMetmmJfqdt7EjyvwaO7u448nucqdwBedHcEGXwJX0cLpMDqvQGTisXbB4KbybtYCFeSLTjeKNW7QxVfgqvMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKoYhku3YFpSd9mlbV5y3jR7ZAJCLr/YHYdP/bb5TaM=;
 b=pQ/Gf8gN0bHWbbL+EmRcDVM4TRDV99y2H9EdUAdmy2X7ky1Isox1HTcHSwC8c9/x/Veksj6DvqozaU8FXWjAU1x4uuevVqBiETHXzl2avzMX9CE/x6kMq9+rlohumbgjEsxTnZKF0p40Jnm+whFe0D/jzDSlBfWYUYuA9/3rJ0RuC0BZSdJptRRDM7/BQUdfM6xhPcN1kVLuJFDAByrdlkQZf8uZ2nGqjWu2xjnybgeaVJMpEct3Gho30hi3EC6yOQKoWI0Sy5upt7I+6SOGFs8EgRkzRTl+T+FAuI/kaWTiqZhgKYRSrtGYU24GB+OXHpfQkpSBLsdvYTF/WBSrGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SN7PR12MB8104.namprd12.prod.outlook.com (2603:10b6:806:35a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.22; Fri, 7 Mar
 2025 23:10:08 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8511.019; Fri, 7 Mar 2025
 23:10:08 +0000
Date: Fri, 7 Mar 2025 19:10:07 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
	Li Ming <ming.li@zohomail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] cxl/fwctl: Cleanup unused fwctl_dev from
 cxl_features_state
Message-ID: <20250307231007.GY354511@nvidia.com>
References: <174138547078.1626291.2681320775917569071.stgit@dwillia2-xfh.jf.intel.com>
 <1d180475-54ae-4095-bb36-f7ec8ee17f7c@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d180475-54ae-4095-bb36-f7ec8ee17f7c@intel.com>
X-ClientProxiedBy: BN0PR04CA0107.namprd04.prod.outlook.com
 (2603:10b6:408:ec::22) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SN7PR12MB8104:EE_
X-MS-Office365-Filtering-Correlation-Id: f21c42ab-4c0a-4c8b-5431-08dd5dcd3439
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FfTkiHBaXb84OCxB+VwqLuLoESuyFqeZgTi0NLJ+H8PLMKlobm6xgvmIt/9u?=
 =?us-ascii?Q?gLpQ/tHfl684eGYSPztceQFICR4FymXFhT6Uctno2EpkDAtNu3o4ITmvkvTL?=
 =?us-ascii?Q?M6/H8h5/uRdT0jOiYO/kU8tdqZGmgkqY9RqN+erjdNTe664Y8TZVioafZ7Ks?=
 =?us-ascii?Q?LMwaVZ0WO/5er94OepXkH1Eb8NAMifTO1ceS3YFuUFVo6UlNeUjOQRLBOoZh?=
 =?us-ascii?Q?9wStwvaQ5xrCMxRU9Gal+13sJFD0A7hPhGoeCFqsw/P9X9tckFdaMarSLmrg?=
 =?us-ascii?Q?ChUM9qQankmJhcNuMAKwsDqlr5EgrCNZCPXblD6nHcAkLggfqLTEQF5409YO?=
 =?us-ascii?Q?75dhLiv1+NTX1kpJiI+w00vuRND4/+aYFHQPllV5yjBJlqcrcmUhOxs8KlwL?=
 =?us-ascii?Q?2rb/YjeXFLbW/z+ViqY1QGZoolRzMPqREAtV6mreg5Gadc2ZH+exdIAsT/z/?=
 =?us-ascii?Q?Ow/DGFm1vcsdT4M897Vkx64xDy0SHXB8LUB3iJdhnoKikgQ4SQ20X8i+bX1Q?=
 =?us-ascii?Q?qd2SFgbERxtx/B//YMYyNE3x/Cy8A82sCp0s+oBZLpxmuVoz66v6WX/IoGXM?=
 =?us-ascii?Q?UItUNVUB48eWwueM1QYcMp4i5Ly8sPCQsgBfru8qyD65A1dhuKtHgwYj7D5j?=
 =?us-ascii?Q?T+W62Ya4MQILFKeNJ17ns4eVYpDiEpCDcM8Rwh/LRz4XcJ84WKMGWIjkjKMS?=
 =?us-ascii?Q?yuYj0nxbtTGpcCoSVGXP7G55+nHT6VbGbwIZqiz1aD62bB+GZZC6McJoMK1V?=
 =?us-ascii?Q?rVXbjLk+8WF8AEY1MDnod4HFh9b9ul5/hqGJbsScCZW5qlb5KCpk4CD23afc?=
 =?us-ascii?Q?OYMa3oGklAud5Q4dyqqmkINsdCPqms+BgQf/BPu8x+exVr6UaDdupc29ExHc?=
 =?us-ascii?Q?ZKGfCIiD7krpawteWt8/y7NQPP5ziVB+Jh7rQKrz7ZzJIUhpTGuwVSils+yd?=
 =?us-ascii?Q?bCKFe0rmAU0CTQDmKH3B8spFKBovQdWIeRtonc6rMF1HDgdLTKmLn43cv4bj?=
 =?us-ascii?Q?vtTkl4SSCY41tk8EhIHNKagMOauqr0Pjpj1erNpGYo2oYxWS7KWiype8CQf2?=
 =?us-ascii?Q?MHGqs0+5mqcRpFKZWOQ72aiFak63up/8QboB4bsIRUH/xVjdsk6V1u/Sgk4p?=
 =?us-ascii?Q?ql9qTaTK0G/cnaJMIFES0gabVvhLr72+YrcroxSnoXtf+/i3C/kgoMj82gBV?=
 =?us-ascii?Q?ycZFn+Aw6EW5KtQbF930hHdk1HGOwwTS9Ae5TtukgtncvPIh6DoM2RjdoldK?=
 =?us-ascii?Q?6Yb2T4C0Cx6AIZQsakxy37zHHQlmUg1zpliEr75CSH8t1t20amoNYr+iz+aW?=
 =?us-ascii?Q?aaGH/xJe7PzphSPsjilg4VPorF5CS1+7Ltu0+S7y0ZwGP0EyClmaQkR1dvrw?=
 =?us-ascii?Q?rkPIOUbMLBezQCeO/BS55ViB0/DN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?770f4gJhUaAs6jYo2cqK6dZNkDPN/WcRv3Hr570s9sUXmg6TS8x8CqsIrp7p?=
 =?us-ascii?Q?6vnTt/ZhwI2UoiVeV96Uxe3yP17ZX9y/di3R0XMAAWdmfIOiDxzGxPtnDpEK?=
 =?us-ascii?Q?0v2kh6Ljh3djSs5xgQyca36/+I+bBBV+kO/SAM1sZ13iaQUBQI088bOBz1NH?=
 =?us-ascii?Q?HkSvA/Ej1gtrNYgv0LFY7hdsArH4h7fbH6kwViLPolSeGSTpBrUn/ySqxYc4?=
 =?us-ascii?Q?nDuL+74zA2aiZwaeslfusttR08DSHeboyhiqE9eX35LVNsJDZiZ98/cBApdy?=
 =?us-ascii?Q?s4bxKj8b8Yeb8jOTV0kuThg2nj5C2M0pHblRu/rhTz7o/YTyTXnwEw1fM9aY?=
 =?us-ascii?Q?IrhohvfYO5Dx5n6gMYvAyBp0aH8T/OoK4w2Esal8EOpK65Y5UGqzes6ww/7C?=
 =?us-ascii?Q?KNHcqOdmz4cs8tPiaOMQxB5kwG6grIDNSl0ixVPijBmQTKpGYRTyEVLl8e2n?=
 =?us-ascii?Q?R3ULg9bZHLYBu5LoTno6GtjlYxEyIIuLRyBh9Ml9Be7T+/pAClTV5MIekA6o?=
 =?us-ascii?Q?DGToedZYUbp2jSjPfYY+f+CTO/gzgXTztyoZJdvHTTYnUGgKD2MUoUMY/Gzu?=
 =?us-ascii?Q?2Oi1V5vS7gwcaEDkjqQErxw2bLefvSFv4M4Pxgd4bVCbknhmRF97qfPHsIFx?=
 =?us-ascii?Q?341P0wfxnWYsRju0IooSPz0HNXK1BdNh8s5+hpKRVu/bIgc15k0Tt/+x1aPK?=
 =?us-ascii?Q?oLw7vpzFXCpV1OpsJDinWHZinZkF2WNwYR4g4JAE8J2Uycn60FbwCBTS6fz8?=
 =?us-ascii?Q?hJygmxeLNNdmhxLv4/+AhN749KZlvbaEPfcChQgHbcJFIyPjhNznGNLfrmnf?=
 =?us-ascii?Q?WksOCC4yqOhxmsqG25oHqRTRJwh5L35tNtbqhVIepOoOcATW/IxCS4N12mVS?=
 =?us-ascii?Q?dgPYLLK0XUojop5A5QKXLorYAxu9YVwpNDNEnCK45M78SIL47OtEnrW8RRh3?=
 =?us-ascii?Q?WwHsdaT/La3F7+jc037t8bezG3owjITNJsxgl1Q8I56goOp4KHth5/w7A4Mz?=
 =?us-ascii?Q?/dpy0nbFuxAy+qFvtIeoQsL8ZkFF3jt9rbsJkzs1ZGQuy1p+X2lvRwNb0XN3?=
 =?us-ascii?Q?/0XOhzs3862adfu/I2ux2M1OqcdSxYeiMeTJnt6x9pu0IBz/hRlnoShypLeb?=
 =?us-ascii?Q?fv1M6RK7WJPkqKT9Wz8pYJIk2aROVZefUvEqRlRsi9dL7iof5uWBOp2fV8iq?=
 =?us-ascii?Q?I8gH2Ad6qlb1BxR1KN/qua2nxytC2CvYnsVPKOv5xNPv/SuMnkYOM5q1DSG/?=
 =?us-ascii?Q?Ojw4U42ypFAVZyr3IjKi892jaSRaiDlRjegRhTMFbJsUZQ4GznkPSXptaKl7?=
 =?us-ascii?Q?i3kbwZCGHc5EdtKmWDwNv0DugIJPEF0VFcvHuysoBoNdBejfTooK1lMbi/rC?=
 =?us-ascii?Q?F3KHOdnmaUMx7+Up1oJlrUNVdob26VoeIiUT7oIy/sw/u8nco99ZbxVxl4H9?=
 =?us-ascii?Q?5H0JQRT8BM0g3q+zW8Alj1pIOC3f4Q1lURpZz7+1/epmgAiOKMyEDa7JshqE?=
 =?us-ascii?Q?JWOI/qhH96hcqq1GSkoI4IFxhno15GWHG1HTA1OIPBu4ys9xomYvpFC/p4K/?=
 =?us-ascii?Q?40aCLiaQeiEyycGSzXU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f21c42ab-4c0a-4c8b-5431-08dd5dcd3439
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 23:10:08.4580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HvvGzbaCe/TZ8cfnqnalxMFAkF7WnA7Pmrj9C4oPrUptyc1nLmQZTKm1CQAaHesJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8104

On Fri, Mar 07, 2025 at 03:26:02PM -0700, Dave Jiang wrote:
> 
> 
> On 3/7/25 3:11 PM, Dan Williams wrote:
> > A review of devm_cxl_setup_fwctl() indicates a potential a use after
> > free condition for the ->fwctl_dev pointer given it is not cleared after
> > devm_add_action_or_reset() might have released it. However, nothing uses
> > it, so just delete it.
> > 
> > If it ever comes back it should be returned by devm_cxl_setup_fwctl() so
> > that users can always assume the pointer is either valid or NULL.
> > 
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Li Ming <ming.li@zohomail.com>
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Jason Gunthorpe <jgg@nvidia.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

I can squash this into the v8

Thanks,
Jason
