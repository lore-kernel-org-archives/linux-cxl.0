Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012002.outbound.protection.outlook.com [52.101.43.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8085521CC5A;
	Thu, 21 May 2026 03:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779332963; cv=fail; b=BPqrtLMzVEURNuAki2bUukRCFcM+VCo4pv9rY0kT72g4MmI5kBaNsCtAqHhj4xMV4urDgkTSfUmoPmGaJkdDyHLdeTkzHHWy7Nf8SofLwavswDo4OBjQETxtlQ+2d0rZMWLgB/R9W/cZExAPm+bwLb8dkPvjvFwWm3hjrls30ZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779332963; c=relaxed/simple;
	bh=ZH2yncBmHjAI3a8yLMTHgeA7uWMnkVTfjNh3s4xQHYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uj9bKXSm1yCMx+Cx3JNfVyxQgTJdWKqJF5BqDIpRY5Ti6Bew77huhuenN2cuJ9u0rgWdF3ZFF35VjEX/BTyl8cQBTXC/gwIMccdaDk770Sy1F/fB/NoCp/s4j3c+J3aFbqkK9GApnVuHaZTcXe6e7yQlg+csteuaJ2JnlkWwnDk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SiczFgXT; arc=fail smtp.client-ip=52.101.43.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SiczFgXT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PuSavbNoV7IMYLFFoms0kZKtmBY7hP4izh/EB2syYypuJOI5ruMSDMgOCSUudq4igQtzvGljGnL2EuZxF8VXgm3lEIoHIdel+qSv5u0d9ar94UOg7rIWdmhDEdxnc/UhML6+hR6uHWFubxaEF9kLXH6crWPTJ811I3Re/2ClxP7QLrbW0unYq7/1hSaqAzzdtykxWgyF+cgfZSPzWCk6C1CE/Eo817ZdrPqiqROihAs557sK1fhWCTOwwjavwUD3A9ohaunHEFyipTkfCO/4uppQmpOn1ETmP/FZxICl9Ql6bOYYpRUJvBMaALEbJKfevqUjQ9Fgv4OKcrcrndUtdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0fwWKbKT7eAwy/fwa4qqXXtooz9WKZPJXrFHjkeBVBA=;
 b=ew11l19bZKC7wusq5tQt11JtGFoxt77DkkyjnY82cQTAoOeDp3CTzeW89n17RxFDdrLfsF2ernpJXiBoz/xHC4hlMPb9sjoQ9AowGejzUFqkUScLUxFKVkXctBy1okhB8OYmquRsqCXVjPstWMl6NIu8y2FPUW4W+VNNLaINDcwHfcSl2KB68f6fwFxP3ycWha7V3we3DbvfkOFExSsgLIAUEieze/h/GeNpoFfAO6BBG7BamjilOXbgHXq2Hz1CSP92xM9HJ1z7QRE4eMWu/ReIwL8Mop9N9UwwF0rEXpv9HVu+SXGb0dxKZZSk1K8grS4nufgqXoL2a+IIFmXGRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0fwWKbKT7eAwy/fwa4qqXXtooz9WKZPJXrFHjkeBVBA=;
 b=SiczFgXTtqdyFmR+kUOZar3oKTIbDZ6qc4SorBX41GwwUs5YPUvrSsC298kxDxTBIKbHwXbowWmZAeDNI/TC3G32Qbs3D8vJ8Wc98YeaMmewpvIpdpSNmssMhWCJm+m1pmbf0UzHc0c5DDX42cHLX0/7JRhz0wf7QIylDOeyLTfkAT4xNTzSQ4J0FGbgGFZOUHKsAPvQV0sP4JRm/cYSztZ79Eb6j6tspKyZDGQkBj4iGvVEQ97mkq02MlJwtib8XBV9DrTmNM+qvWc170IyNbVhESGgSlVtEbr73lAaegNXIPcHbgOnnEywZlqfV1A7P4MpNAmmFEMDKMPMwF8l+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SA1PR12MB8986.namprd12.prod.outlook.com (2603:10b6:806:375::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Thu, 21 May
 2026 03:09:18 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0048.013; Thu, 21 May 2026
 03:09:18 +0000
Date: Thu, 21 May 2026 11:09:09 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, 
	alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com, 
	dan.j.williams@intel.com, fabio.m.de.francesco@linux.intel.com, ming.li@zohomail.com, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, newtonl@nvidia.com, 
	kristinc@nvidia.com, kaihengf@nvidia.com, kobak@nvidia.com
Subject: Re: [PATCH] tools/testing/cxl: Align mock CFMWS to PMD_SIZE for
 ARM64 64K pages
Message-ID: <ag52CUdAvIRjBGBw@MWDK4CY14F>
References: <20260519233523.5991-1-icheng@nvidia.com>
 <144e80e3-1813-4c77-8c43-1f350f74230c@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <144e80e3-1813-4c77-8c43-1f350f74230c@intel.com>
X-ClientProxiedBy: SI3PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:295::18) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SA1PR12MB8986:EE_
X-MS-Office365-Filtering-Correlation-Id: b4a421fa-69c3-46af-060a-08deb6e658b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|22082099003|56012099003|4143699003|11063799006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	bwx5RgHdM9MNjFqOZItT4/NfyED3vKt2ftqUPunmIO130/OG9AysmOJGkd7lCkTnSYcUarwM9HlmYxbqa+mz45V0AfCxC1F+dByJustc5vFxy4ixgz2C2tBHKhr5ufyQbCVZ5qMpOiUhJsizooSRawMnrWB/4tfi8b3ELXrGy6YCw2Xf7SDXtPwhISAomvCY/s7Oy3csoDsphXfr8PxuZM3UTYK7+TxSwI+yrBa5DRLn4ZXrjTd5iuygprppsikz+yymFCRK176hXUvmkwD0mjwGi61b5ZiP9kcIlFnqOcWFkcUHPHXNgUJRcJm5cIUwuBfXJc5kYnjzJaeQzOEJRZ+xSMY/itjWgBgrRKK5qly7EYOXy+XUJBnW0sImN/VlFmCtXBY7xLno0+dABcjTc5t67n7uQNDPCBgxNtVpNsF8/acVjnWow9XLsycbpmofz/73ZAg8PJ40rp+ypIAJQo6ITPk2T2dOnEwYRm1X5mpXf2ROSl5goJtJtg9PiVNWLzbDDOmYR6Y8jihnEJN1Vd2WPe5FEStOaMRaVXavZyFrToXtHNEzKqureULwApB8lS1PkJBTzTRbDTnkNLlEd+e4NtYdDNk856/kaybwEAISDhkoDhwxnnU3vqJe6J395j1tfqjqGDeqnJrl3RX57wgQRpjOlY0UXsLm3bp1jx4Yb+oOblCl4PNkT0VL3TAg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(22082099003)(56012099003)(4143699003)(11063799006)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Affmviayid2hIyJ7lnz11EjAHeKJWXaq4tmg/fAU4qZ2lAYqGLE7v2UeWMln?=
 =?us-ascii?Q?P+C+nLBOm/SejWCqwTMs9OnBeI/EGT5Y2z+cs2zdq230hN0+pNHVzmTulJg2?=
 =?us-ascii?Q?eD45iUporhLwY+kFIlSC5mLQBPP8P1cuj14IexFxVDnbk9+zUj31V9z92kyj?=
 =?us-ascii?Q?338POmhj8p3vg7pUwpEFq9Xq+v6bSmeQEw2jYT6r7KeVPLDWgSIQfaMCiJPJ?=
 =?us-ascii?Q?v4YqEJhJ5c9HYXaOxgQhCZwsheX6Wd4E+N0monlCu8r+vWVtxpnwNqRBSdik?=
 =?us-ascii?Q?AkLJTZ8hFownPZNbeWrjK8FvmBHM3eFB0jP003lDu2ujLjIeroV5s1U7gu6V?=
 =?us-ascii?Q?hTkOaYLtwbRZDzahZgSW2/stQpzr79zWN0yLTud1QPJcKxzaEcdilMV7ziPt?=
 =?us-ascii?Q?DVmgUX5FxYarB1OerveBsyO5nb+eWejjcm+ZfbOfb3NYOApa1aBxruXEur2R?=
 =?us-ascii?Q?g5m+tX7D7yh22F+OmyANruHB3MiFhNVoKti94ouyDRADz0ln8Ti7m9WtUEDR?=
 =?us-ascii?Q?3I4fdsejpV5dZlXL1kzb0NmPOhkCII8rjcRrBupWz9Wcj0E2e+u2NWC2opYo?=
 =?us-ascii?Q?HPv2TsSXLbT0+yWFkMmCwDQ2oyYvy1C6nKi3uIwPpLrW8g2QnaiHSSGKLmJv?=
 =?us-ascii?Q?mY0zOKPexn/ldonk6ss2YUYH8tJlp9PQEu8I9VIpqhlyiCGw9aGycaariG4A?=
 =?us-ascii?Q?rrkh4LcBXZtGPvY86orhC+zTZL8htYPkSBrZHl7GoqsMKENyg3NiZXKCldSq?=
 =?us-ascii?Q?dTpcKUjGHKQR5usSJPSLtRWEdU+0zPPCYuvSilRbgVaYIBXLwtsy37VKMG4g?=
 =?us-ascii?Q?bJp/IiFNLDuYySZgrqiFor6jpf4upHGvec/Mt63JGK2kMfqUtQsyDUG/ZiaD?=
 =?us-ascii?Q?XLgzzlZKGtoHYz7ezoxPnWI+yBLTtKroDPmaeK+a4SuLjH/SfBKyzTr+PA8q?=
 =?us-ascii?Q?4ARAmyDJl5Y6eHgN1+LF6zUtcWHCus5spStLjM0hFnyOlunhF2M5AO9Os5Ta?=
 =?us-ascii?Q?NEsjzO4RSwkjzudQW+QstLHs6TY7YYdY8hGPaqEEkxoxDbM8sL1Bcsajrk2t?=
 =?us-ascii?Q?dzpNXCGJHryS3Ssh/+nTjya3bFYJ2qJi5vVWBhAvp5CcKsIKgyO7jwMTLmhh?=
 =?us-ascii?Q?VL18MmBX59aCAPc0J6P4qkt4RgsQhG/1gvAbdPFkns5g8DLg+C4ll1MsnZbK?=
 =?us-ascii?Q?jBAkcyhfF7GxIFfNRyDKm0fim6ZZcKefXXSbhGGcBLXmzrTnpdSN76jACt5y?=
 =?us-ascii?Q?yETGcSvHvHCG93ZbRLXm1MSPLAmEQxfkSJjoAHzAR8jvMQBOcM2DfHdIKvMj?=
 =?us-ascii?Q?boBeOpw+SYg6jkrSDMireLIrwjXhIDtmNLvW2q16nT5F56kKqcJWp+uWH7sM?=
 =?us-ascii?Q?zDs+ynl27XnBlxGqN5EXlH4a7KEW/59noCzsMhqnysJwt9wE2XMR55wv44Bd?=
 =?us-ascii?Q?v70ettqhk1P79F7BXtOJJ6wssiocpvNCwYmaqaPle4Wo3u+Bopps1DfDhAiz?=
 =?us-ascii?Q?UdFXt/Prdxfn94QKMz67f2tuwWUfPWuGglUex8760pYoKz1iHqQTKrr0jM0t?=
 =?us-ascii?Q?X9orgEKEnjqRcXxkTYg9JrZTopjnZ1MDRXI4bM5RF6MgiUSJ2vNh7alyT6Lj?=
 =?us-ascii?Q?V8YXiE46iKff6CGU6wnBlNMmUMV3c2+ic4dufYam4CDFHJmA7pGBEZ7r2rNp?=
 =?us-ascii?Q?Zaw5bK1eWuQ8agrimJhqYfyql9hZ3sZhH53j0vLVFm4jkBj3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a421fa-69c3-46af-060a-08deb6e658b6
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 03:09:18.4252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1+Z7CiUkmkgqxNvdit6SUgrHWnsRGmvSFYzUQCIEi4Oldkh8eIKCyNrvwbyE64XdasyQTsjucsujonxJXhwMeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8986

On Wed, May 20, 2026 at 11:18:23AM +0800, Dave Jiang wrote:
> 
> 
> On 5/19/26 4:35 PM, Richard Cheng wrote:
> > cxl_test allocate synthetic CFMWS HPA windows out of a gen_pool and asks
> > the allocator for SZ_256M alignment. It has been sufficient on x86 with
> > 4k pages, arm64 with 4k pages since their PMD_SIZE are 2MB.
> > 
> > But for 64k-page arm64 kernel with CONFIG_ARM64_64K_PAGES=y and
> > CONFIG_PGTABLE_LEVELS=3 , the PMD_SIZE is 512 MB, which is much larger
> > than the alignment cxl_test guarantees. That results in every CXL region
> > carved from that window inherits a mis-aligned start.
> > 
> > The DAX driver's cxl_dax_region_probe() then calls "alloc_dax_region()
> > and the probe fails with -ENOMEM, with error message
> > 
> > """
> >     cxl_dax_region dax_region1: probe with driver cxl_dax_region failed
> >                                 with error -12
> > """
> > 
> > It was hit while bringing up cxl_test on an ARM64 server with
> > ARM64_64K_PAGES config.
> > 
> > Raise the alignment passed to "alloc"mock_res()" to the larger of
> > SZ_256M and PMD_SIZE so that the mock CFMWS window is always at least as
> > well-aligned as "alloc_dax_region()" require.
> 
> https://sashiko.dev/#/patchset/20260519233523.5991-1-icheng%40nvidia.com
> 
> Do you need to adjust length as well as alloc_dax_region() also checks length alignment?
> 
> DJ
>

Hi Dave,

Thanks for the review. I think there're 2 things I would like to mention
* cfmws6's window_size is SZ_256M * 8UL, which is 2G, not 256M, only cfmws5 is 256M, so the
population in your scenario is narrower.
* The -ENOMEM comes from cxl_dax_region_probe() on the auto region, which carves mock_auto_region_size out of cfmws0,
which is 1G. On ARM64K_PAGES + PGTABLE_LEVELS=3, range_len == SZ_512M == PMD_SIZE and range.start == cfmws0.base_hpa.
Both length and start checks in alloc_dax_region() pass.

A region carved explicitly from cfmws5 with a non-PMD-aligned length would still be rejected, but that path was
already borken on this config and isn't exercised by cxl_test bringup.
I'll be happy to send a follow-up path that bumps cfmws5 to >=PMD_SIZE , if you think that case should be covered, too.
Though that's separate from the bug this patch addresses.

Best regards,
Richard Cheng.
 
> > 
> > Signed-off-by: Richard Cheng <icheng@nvidia.com>
> > Acked-by: Kai-Heng Feng <kaihengf@nvidia.com>
> > ---
> >  tools/testing/cxl/test/cxl.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> > index 418669927fb0..b40e4bbcc958 100644
> > --- a/tools/testing/cxl/test/cxl.c
> > +++ b/tools/testing/cxl/test/cxl.c
> > @@ -497,7 +497,8 @@ static int populate_cedt(void)
> >  		struct acpi_cedt_cfmws *window = mock_cfmws[i];
> >  
> >  		cfmws_elc_update(window, i);
> > -		res = alloc_mock_res(window->window_size, SZ_256M);
> > +		res = alloc_mock_res(window->window_size,
> > +				     max_t(int, SZ_256M, PMD_SIZE));
> >  		if (!res)
> >  			return -ENOMEM;
> >  		window->base_hpa = res->range.start;
> 
