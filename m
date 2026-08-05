Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011010.outbound.protection.outlook.com [52.101.52.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489793C1D61;
	Wed,  5 Aug 2026 03:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785899810; cv=fail; b=suIMkX+6yyEdyzFB6LAxy7oRmor5yfjyszNtteh1+Njen0rRkUQ8XU3Mz/PgTfxlR02Wrs93F/5Xhf4S4XkDWCOWlORYrIT3a022yGfsYIn5EJAYfr55akWcHX7a8wWYvlJV6T1IsqX3nWB1CfmjFPY7iZVHQRVBh2vxakHuZFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785899810; c=relaxed/simple;
	bh=4Q8ldJN5ur5vBj6yj5SKHyogVig/6iMkuf8BegcD1gM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=EtVDWhMWsTZm9fMGa1bISnaL+2kzb+Jbl3jc6k7/jGgXpPfehc1YdzokahvGCWzruwchYn5ZnTvZlpiblIwn6gE/c2z4v9pk0vHoY9D4WTfY+a+6HFzv9fnn+YQWuGE03b+o83eIsl21sdfM/w/2B14pzftJyi7JvX9Zrd48JrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WgFK5epC; arc=fail smtp.client-ip=52.101.52.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WgFK5epC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gIJ8Y7ecyd5wk+qKSPRpw/k/re5b9GOfFsT4LhwuDkv2rkqx651Nkj5wC5e295b/4rOm7KC4hnMLriYxJ9Lb2D1zoPCQqCti7e0TUdBOSG9sOLJSOVuNGmCAL8G0kfXfIt4Tv8ylWUADqXQV9nqbTD2rH26jWLGJWGnJ5RacvxIVzOIKZ1yoLzOq3kdJoLJpuTP3pC5h0ux6KclfO5gKn5MGL8Y8euxx/vk6G7P3i90Bx0EiwNFcIhIDxriHJmgo2G6EodF3SmweVygrmxFytRvVdvk7IhUXqx2Qw8tV3WdL9WP/pSDJ65GvDgkIYfj+8H5k3ppPmYaHvjOdue/PTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+7WJcn4yvCI66E1w4JhfX9djipJFE1LmKbOcwM+qNI=;
 b=EevJig+ipSV+I/jRJylBfRfzEOdRztPiGjRc8Ve1G2/43ohMDA7FAtZy/xEOsYNm7oKQNMr+spS42ibSoY06+hzjoygZVkhFmuafvSDlpftrNeXr4wwaZ7ow0QWC6KA/kOxekQPB07PzWmovM/p+vpsmoGgMvYzrbt4IbQ3bJ/q0wOyR0a1fKEj4Y5o1LYO3KV/3vPdzAIA4rmfkU/44pin8fSttGPbUH5anxA/CsxmogLkOFEIvmYFzJ2tWJ3r6usbfbagPaLwOTiHUT4P6JSKlxop2tgVtaA8IiW071qBCaEsIedqgmNfTwcGKiuIbnA/TP33sah4IPicB65imoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+7WJcn4yvCI66E1w4JhfX9djipJFE1LmKbOcwM+qNI=;
 b=WgFK5epC9B/VRjAjXjQXWkapHov5xfnHkXGz+48AqaqTeQ6l2UiWtzczTFImnaEymQ5OanVM4tMYX402fBA/cBnCd4KJ67wHmaEHFbpVBLGhygsZOSWaWJaPXd3NmYs2J+3DPh5waro6IbQ4qFz/UfVTVTYrvlzLT0kc1TNUdWnNBLDXlsgS0R2mt6OfK4HYpJ4jzCP0T8cuXewD9J8oFqyW8m5b+9TODM1GDs/aCfF9K5yoBHwwQdZtYWWnZjJY9iKuJXCh+Jq8SRQSvhu9tdjMNn3tcSBu1i3ItXPDBZrdM7VQy+FqNKdjY9ud69180Qt7LY4kMhDsFQJCklO3fQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by PH7PR12MB7257.namprd12.prod.outlook.com (2603:10b6:510:205::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 03:16:44 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0292.013; Wed, 5 Aug 2026
 03:16:44 +0000
Date: Wed, 5 Aug 2026 11:16:39 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: jic23@kernel.org, dave@stgolabs.net, dave.jiang@intel.com, 
	vishal.l.verma@intel.com, djbw@kernel.org, danwilliams@nvidia.com, iweiny@kernel.org, 
	ming.li@zohomail.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
	newtonl@nvidia.com, kristinc@nvidia.com, kaihengf@nvidia.com, kobak@nvidia.com, 
	vaslot@nvidia.com, mochs@nvidia.com
Subject: Re: [PATCH v8 0/3] Support zero-sized HDM decoders
Message-ID: <anKpY6Y1Sqne1f7Y@MWDK4CY14F>
References: <20260731064902.34127-1-icheng@nvidia.com>
 <amzu-kZU36ivFhZ0@aschofie-mobl2.lan>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <amzu-kZU36ivFhZ0@aschofie-mobl2.lan>
X-ClientProxiedBy: TP0P295CA0054.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::18) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|PH7PR12MB7257:EE_
X-MS-Office365-Filtering-Correlation-Id: e6e926c9-5454-45df-d0ae-08def29ff9d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|366016|10067099003|56012099006|4143699003|5023799004|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	pq3qeLCvTC/P09C10LkIaTXcxraBvvHatfhEOI2VhX42Z9gkHjVnOUNGhiKpVH5S/0piKnge6+HOt+7/2HXAX9hY+Ex8+ZsR/KfJgNB9NamHwAlmnYnibN5Io3d/FySSBfnoAScXMhHdUxgrv6nka7i6SCmYOMlqy7Vay4SlsuThF5rwuCNdatzroD2CQPab4E2K+PrEp8Fdj0EkRazMkrDcIriZbSypmubhUBOevDDFIRM+y5DFDno6liZ+eq5nWCVgphWBvTYTK+9N65lbYdHdouIJdZoSt9jy/HgIev8D/ln0OgPFbTMuatqX5q6rE3NlLHmOrTvBze3qJ6mJDxnD2pmX8hSjWNUpyFGdkmr/1VVC9kK1srrpspEzc15AXUfulZEFnztWFa7/bHCg1nuwejmHatEi8rgInXweEePwc/Y3GnhtHGu4ewgIGeyVNfmtMHBasM4xGMkG1XFcb0beoDp8fJYJd98lafrhbTu+b4VDplYbDg26nhW4kSfMNWkqcNUuCNit5rC/GE48v9UTiuKSCKBvMtf7Vx4wIrxJ772O5nVOVfUQx/3VKZJUENMCxuBw3hPWXwYPW1kIpakind6m0R4slH+k1RKiGRYcIcOCwK41n9olbxhKFAOXayk+xB8Z3n18/XW3jHtUqsMU3zK2msSlEYQe2LO6wHY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(366016)(10067099003)(56012099006)(4143699003)(5023799004)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6PuIym7+qQ4P+MraSje/2ss50di2pCrqLpqDcJ9TP02b8ZxX6MbA7+0RsMwA?=
 =?us-ascii?Q?UbPq+AVv4YJLPOxAr67vLuDjrKbtSAaMkrbm23CLaK2z3OwlUslQjXHD1Gh+?=
 =?us-ascii?Q?iDMuYCG9e/ITkQKulX9A2jgbW9j1LO3JKkmOMTMgBPQosaxlnc67N7N7xs6c?=
 =?us-ascii?Q?sOATza2NCcJPLR5ssYnfzauJiyNxYzIMZsulcEwXe5g4If0E9twy+yz+yY+m?=
 =?us-ascii?Q?KQ6wL547W5ne3VBhv71wxmu3KMonPozQVdCcKqr1xQqPBhwUW6zEkM3gGCzS?=
 =?us-ascii?Q?4K1kVB6qPd0tDCE1bBQ+EVaHcNRHmz5IJe9CFUcqm4GsWHmGp10nXNmoYglC?=
 =?us-ascii?Q?qItaWVsjSCwrBRBuc+/uhLmAsXunobZwgUPkpsKLXX0EpKq95wYP9bNXWGBA?=
 =?us-ascii?Q?T+OunC86/fiHj2qM8rJ89tG/P6xsN49SI1xKvU1S0nH/Bvkik5M2krJa47WL?=
 =?us-ascii?Q?Ppg/qH6OmelN1kHNCPGP8ihUfe33YDP7QKGQzN4nk/encdRy+DzF9eoVPxGF?=
 =?us-ascii?Q?YS9/lgTAs3lKeOzhrrewMovTaUVBES1BLzXrMhsOoYAEj7rdtKMm48vrjoGe?=
 =?us-ascii?Q?4Zwfk1m3S635BNZiAXQoC75asLeYrynN0dJWcqK+a5SdeZQ9M804J7ui6E+2?=
 =?us-ascii?Q?Pxjvz7ouYs7kfiwGp3EfPlnbLmtgeNV/UIGWrEYW2hgUyWoH+bwPdMFuLw8x?=
 =?us-ascii?Q?eIYcpEMqPrX/Kf+ufjeWqmjluUV/oaPV3xd+PRs0wBqgSqGZADr/o56akx/B?=
 =?us-ascii?Q?Ph1uFZxCt9UHrGYlTzbkt52vCuAWo0ai71+lPKxPkmONdYz/Jv95KFQ1sVas?=
 =?us-ascii?Q?6Ac0XpPl8HqeqPeHCzf/GYseg4bjbkNzZ1pCfoiDMEX9dhLEHOP29pRiRO59?=
 =?us-ascii?Q?93Nn+wKxgTR5Zzp7nQBhx5i1P5R9hbJnRjbtOx8+eZSZ7kxlH2Jq9Yq2Mt9Z?=
 =?us-ascii?Q?jmevmqAewaadqGqdFu5faWth6JUri4GW87UboPrlnZG9kMELIIvDSKbZrRNl?=
 =?us-ascii?Q?XN7Htn4w1ZHsupl3pIpahKgmNs/Ei+ONR2lK87AFCC7LdnayWLX/kQOC1SF4?=
 =?us-ascii?Q?U+9sbcqQe7HQXY7SGpA/zEsKrPz8HYAuX1gN21GT4qSkRVAcRS+R+EzqoTmV?=
 =?us-ascii?Q?DkxhX4W8f3PRv+/JkJ+drk1HuaijNRuH4WkTRtZrev2hExukA4djUhezk95m?=
 =?us-ascii?Q?qYJe/BEJR4ANKxt/kIx3oMR50lbAGFE2ZUcvt/mTAB868dWaLwpQ6At0NbKE?=
 =?us-ascii?Q?2SGTKBopGP83hDYBbVoWlmO+21X++B7OULo5Xq6rqsVrtq/5+9NVsp3JNGUX?=
 =?us-ascii?Q?vOc7P8uTbO1sGm4NUAKw1ksgoIyWjlZxAG1V231AksX2e9UQTKzLvKUhWOA/?=
 =?us-ascii?Q?GtKVWKRVMCBonaKmWsYvpHYX2PRZebyBQPxnR3m3oDVBFjeZkcMB3SSL1J6I?=
 =?us-ascii?Q?7/PHRCq2pZrCoWvZJDr7+N/AuNm6FDN2GWRXeeh7BYHZoDxcH64tNZ+1YIN3?=
 =?us-ascii?Q?LtswoDadMMT+ECzu2eb+kRcL6qr0R/IWQbWTLVFBGRpq3I9OaASxypRl8X9k?=
 =?us-ascii?Q?EpYd2fOvdJBLRc0Az6U5pBXpq5Hvf1X2652n67xDY0913wQnPiysC3z/JqcS?=
 =?us-ascii?Q?xdn0EnDiYhjnvB+VtLNM/8IxcB5hlGtBB6y7W8/FvPtRiss27I34JM81ssV+?=
 =?us-ascii?Q?SSXjisaZHbD9ezQLIQAj8CUyAwbWZBvDyP5qHNsUtm0LAqntpBCdPFDLZARW?=
 =?us-ascii?Q?EiMUSpN3nw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6e926c9-5454-45df-d0ae-08def29ff9d3
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 03:16:44.5888
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9FT22Cv8NWd/qgqFDWxyD1QCyq+pst+YT9H4ANyq+UYa6dW4UfwSx0cADBynOZ18kayyTHdEwnQvloWm2ydMzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7257

On Fri, Jul 31, 2026 at 11:52:42AM +0800, Alison Schofield wrote:
> On Fri, Jul 31, 2026 at 02:48:59PM +0800, Richard Cheng wrote:
> 
> skip...
> 
> > 
> > Full cxl suite with mock_zero_size_decoders off -- no failures:
> > """
> > $ sudo env "PATH=$PATH" meson test -C build --suite cxl \
> >     --num-processes 1 -t 6 --print-errorlogs
> >  1/16 ndctl:cxl / cxl-topology.sh       OK                7.81s
> >  2/16 ndctl:cxl / cxl-region-sysfs.sh   OK                5.28s
> >  3/16 ndctl:cxl / cxl-labels.sh         OK                3.27s
> >  4/16 ndctl:cxl / cxl-create-region.sh  OK               10.70s
> >  5/16 ndctl:cxl / cxl-xor-region.sh     OK                5.76s
> >  6/16 ndctl:cxl / cxl-events.sh         OK                2.77s
> >  7/16 ndctl:cxl / cxl-sanitize.sh       OK                5.73s
> >  8/16 ndctl:cxl / cxl-destroy-region.sh OK                4.16s
> >  9/16 ndctl:cxl / cxl-qos-class.sh      OK                3.25s
> > 10/16 ndctl:cxl / cxl-translate.sh      OK                0.94s
> > 11/16 ndctl:cxl / cxl-elc.sh            OK                4.21s
> > 12/16 ndctl:cxl / cxl-dax-hmem.sh       OK                4.56s
> > 13/16 ndctl:cxl / cxl-region-replay.sh  OK                8.66s
> > 14/16 ndctl:cxl / cxl-security.sh       SKIP              0.02s
> > 15/16 ndctl:cxl / cxl-features.sh       OK                1.42s
> > 16/16 ndctl:cxl / cxl-poison.sh         SKIP             11.23s
> 
> Hi Richard,
> 
> Curious about the SKIPs.
> 
> I'm running this w the base commit you noted, and no skips, so no
> functional worry. This must be environment. Guessing you're hitting
> the first do_skip of cxl-poison.sh, no CONFIG_TRACING. Maybe the
> keyutils for cxl-security.sh.
> 
> Please take a look and see if you can update your environment.
> Poison one is obvious, since this series is touching poison. Security
> one is less obvious, but as Anisa recently showed us w DCD, a seemingly
> unrelated test can uncover latent issues.
> 
> -- Alison
>

Hi Alison,

I re-check my machine, and I make cxl-security,sh work now, I missed to install keyutils.
And I do have CONFIG_TRACING turned on, cxl-poison.sh won't work on my machine because
the alignment problem.

On my machine
is_unaligned region2 3
addr=105491107676160
align=805306368
do_skip 'unaligned region not available for testing'

105491107676160 is exactly 805306368 * 130995, so the x3 XOR region lands aligned and there's nothing
unaligned to translate against.

cxl_test anchors its pool at "min(iomem_resource.end + 1 - SZ_64G, mappable.end + 1 - SZ_64G)"

so the window base follows the host memory gap, and no module param moves it.

I'm not sure this is really my setup's environment issue or in fact a test gap ?
If it's the latter I would be happt to fix it in a follow up patch.

Both run_poison_test() rounds pass, so I think everything this series touches is covered, only the unaligned
translation section is unreachable, and this series doesn't touch translation.

Personally I think this is enough prove of test for the serie ? what do you think ?

Best regards,
Richard Cheng.


