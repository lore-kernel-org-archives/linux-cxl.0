Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F11D1991B0
	for <linux-cxl@vger.kernel.org>; Mon, 17 Jun 2024 22:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718664656; cv=fail; b=ssi/Kqbxol8RYnNcxgIbCKYv2vuP1aKlW+s5Yq8rEA6dbPb5KFbJL25Wte2NHYiymqStYsAC0b0HUkp76U+DSSQt+IvX/I0NF6wBwOdTE1Mz5IcOtMusp4TZFA4lzAR1YP7uTXG/j44JpzTJ+7NQpqajUGVcPgVAUCeq7zYZI8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718664656; c=relaxed/simple;
	bh=zni/Skg/pFW34dZ8+nvjU/ZpIJ6/kVAUz3LwWpvR8ro=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VXHd2szNRPucNbuu1BjnXZuo8otuvvQDVazuCzrUSCsJC8hNySkSBr+2QFaCxCtBLpaEysSAXG7a2uQPdJqUokdIxhA7WmfH3+LD7b4Al7haKwWKFEmMLIzr6rkI9YLlDNkmf1DeDp9df9M38GNeve7bQHUICraLSiFpBAsMx/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EFe9yxdg; arc=fail smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EFe9yxdg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718664655; x=1750200655;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=zni/Skg/pFW34dZ8+nvjU/ZpIJ6/kVAUz3LwWpvR8ro=;
  b=EFe9yxdgAHcHROhb2Ml26UNvL0JgjzYWJarzVtnd4+ANfACZZZpQszoE
   CRPFIIAQWMvR/Qw4oQ7uSBcFP9ht7aEI9E2ZjLvWRi6iQnjFNerBOTNd9
   t7hEstCJuRdDEZKp6lb0uQB7nldG0IpIGfTn7zDrKQZLjayvzAywklRbr
   WPtna2XXA6keDSddtNbuOtwKkiI/pvZeFPOWz1qJFQnu0PpqlsAHcmrU2
   x9LuPq2dILrSuuNP0k8mI2SIJcx/Y8tjWGcQW5oeIoi1ZafpNPQw7ztBn
   +6OqlAp8kKMGDX7A/JVCnWo7D/B7xSdUI5a/Gvh3KrPwoA8BvzgWUNSx4
   w==;
X-CSE-ConnectionGUID: AafK9/IoTIOgTcaZG+tv/A==
X-CSE-MsgGUID: okjRKnRdQuWi5jrMGQKzMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="15663366"
X-IronPort-AV: E=Sophos;i="6.08,245,1712646000"; 
   d="scan'208";a="15663366"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 15:50:54 -0700
X-CSE-ConnectionGUID: pRKSN7cXRneqUZyVS3JsDQ==
X-CSE-MsgGUID: BWRhgGhETnOcJLunlmP2mg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,245,1712646000"; 
   d="scan'208";a="41441922"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Jun 2024 15:50:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Mon, 17 Jun 2024 15:50:52 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 17 Jun 2024 15:50:52 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Jun 2024 15:50:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJGVWQDVh12yMlHkihEu8SUaPKno3f1g37vxIv8koFibJmZWuaFfpkJb33yDB3lZSovEYq1TZYibCToUJIU7CxemcCUiMt2YftFe5VCovekNX+EbtqVvE9cQQoxW2VimT11z54jpgbHLMxoJ3UlxrxUwNyhi/Wa1WxqFk8rD6+H0vkigebPbaK68Nul/n8sZaeFQJaEXGar066jVa56ds+TIG/HXDZk8BJAlWRbXGxGgRdujArQFVnsg2vv+JdS17Vdq3E4ezOOVCRqKjMb6EsZcbBX9mkbwnXbov+ugsCZyKRTL2CUtpnnrVEqfCQy8I/AhVuEhhT+7lKXP/o4phA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhwsR9ky0X5z3/FVyRwhftczyOgPzoZc4zW8LHg985c=;
 b=nDD37GdPbT6BxNr9VteodP8qJtrn2ptqplixNugHzG3QDnsmrgkNu+rCkJnb6LMslqy3JmmUsHaSgBJplXuVSobu4gt09D123XXo4j39pQIQbtFJaGW6w5U2UEmg4tKfNpBCC2Sv70yobTVsrqcu4fod2wStHfpHzcSCRqKpWNlJCckwTVWP+txnRTNEsshnI3mQN9OYHhHzFjWw3ffdBDijVsmfyqIUwDs0rGOkTccGSVq1Dkw7+44HNEz453zIGgziRc80E27DdFp0vSTO0VndsKLyMY061mzUWUoJ7ahm87y8hPB8CYLa77FJBMa+EyziUf5jbW8XqmqR2WuQvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB5028.namprd11.prod.outlook.com (2603:10b6:303:9a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 22:50:33 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7633.021; Mon, 17 Jun 2024
 22:50:33 +0000
Date: Mon, 17 Jun 2024 15:50:30 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <dave.jiang@intel.com>, Adam Manzanares
	<a.manzanares@samsung.com>
Subject: Re: [PATCH] Documentation: CXL Maturity Map
Message-ID: <6670bdb69f996_3101294b8@dwillia2-xfh.jf.intel.com.notmuch>
References: <171659842954.843002.8140957498380360424.stgit@dwillia2-xfh.jf.intel.com>
 <20240606154001.00000507@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240606154001.00000507@Huawei.com>
X-ClientProxiedBy: MW4PR04CA0064.namprd04.prod.outlook.com
 (2603:10b6:303:6b::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB5028:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ccb7d66-c481-4475-a2fd-08dc8f1fe50a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|1800799021|366013;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?O2OppXY7fn6x4DnAd5ErY3WuhzxFaouJcasISKc1io3m2nrFmA4lvrl3F+FH?=
 =?us-ascii?Q?4Qsqi66o4w36OF3JrJ3hMlz6yUXYB1Y3ao0ORfZFnjA2EdqRto+3auZRYGQG?=
 =?us-ascii?Q?OOSnY4aT04ff4wYdQ62HVAGY4VZUbh18xonGwflSt7MWzg8DuJq6hb+X0lDH?=
 =?us-ascii?Q?IGXtkhxo3IRId/c4Jiy119vMMt98ry8vcD6HfQlOwQpoEU0QvP8JR8gyRIc1?=
 =?us-ascii?Q?XXXdYOXzWGg10fCLWQl6L0Fpl+XROYMSh+6CeLY0cil7dgeszZ2VHLDVxPMZ?=
 =?us-ascii?Q?xn3W7drI9ImyDW98IPuzOwWK60skENHSKyo72m30JF65y1kwZ5H5hYijonRh?=
 =?us-ascii?Q?YmJZTiipM9pyfNZIll0y9jO49SYR83TJcdggNojrFgl/zcYC5MOKqg4lO4rY?=
 =?us-ascii?Q?YeXF+Czs4sZsLxdw6Mvv8hs6qKHiZQsAu99Vinf/821bKsB0+cibC4J9V5gB?=
 =?us-ascii?Q?x484XgCOSgC9yXReT+VVDcbQ1ucIHMLfg6krpi20lGARTDW4tgdDJ6t0o7fQ?=
 =?us-ascii?Q?aRilg0jjxl8wpp4rcAgmJCNFI1mHCpfe+u4xAXFCtRoZEdCRCf9YJrPtVP/d?=
 =?us-ascii?Q?fekGxm6KO0W/2oe56I6m5PlPoyikMwzUvipHZxHC4rNxuzJCloHZtQjLsBWi?=
 =?us-ascii?Q?B3ZVXwl6CuGwlSDsKxXAfpgcaCLhkNgp0Ktq/TwTE7jUIrhAITnGJEgx3jCJ?=
 =?us-ascii?Q?r0RAAZYOpASa2zQmgeXRC4YvfUIMuC/MYsaG2AUH3lbbKqOn+lzPozW1zTEc?=
 =?us-ascii?Q?ylq3IEzX/n2VSXGEnYb2GVfO9pl5E6maUdrNU+7irX2jOV2U8ojpr34gjtPd?=
 =?us-ascii?Q?IRrQEskmjOmoxp4/KPf61iGOtLP7JIIZkqjEWWi4dCjLPglbcNV7jJmVegvv?=
 =?us-ascii?Q?UZJ5WMLWGeo4by8b7arnBmm5MwRj7no8/kRjOcE55WC0by/3o6gs8yZUosTT?=
 =?us-ascii?Q?sDZ2LpbUY2hFXfGRId6HLmdiV93TFHgFdsTmpIsDZdd+eoCUeb0a6cKIZgfZ?=
 =?us-ascii?Q?9uzhLgvGXJd7ovdT1+SkG0kKgXGM7K2kEyn08gaw0c4q73bHjQhrB9WKWj/2?=
 =?us-ascii?Q?kaY0FpxDARPpuLeIkpof014/2W2iSzpFO/7KvwTFPfeKlX8QEOhVSvztme8v?=
 =?us-ascii?Q?/oP943FgKzwUW0FY3W3/a/R2TLWyYsD+di0QK+6jVG3mq6IzVa8rIOvarwy1?=
 =?us-ascii?Q?NNKpgvmZh8Ra3m3dpSBWWNAXRbyzZFpcD1N8OngCJmpRWclffFl/iUlwNmX2?=
 =?us-ascii?Q?U9kwG91x4o6/vATccJGbwkTUbXsxc2hWTk0o3G0tFQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(1800799021)(366013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VhTls0KcpelSvZgK4pzrukyssXQT1tV6MxdyE7FR2MirEJ+sB1og4E28X+gU?=
 =?us-ascii?Q?h6MFxiaSF4FP8CqPLEJGrnMz1/EWew7m2TC8CrLaaMUzu/1aGGGrBM5p0cJC?=
 =?us-ascii?Q?XhhAkqi746sPYmMJj0pDfO21mgm7UZGsT0nnvEUYaG/3rlkoH5o6W+N/YV1X?=
 =?us-ascii?Q?6FZm4u9oQoKJXv0RzSjywNbhWw5JxuubA62UKl+3IEsXPihP7IiV9/O38mYY?=
 =?us-ascii?Q?XSV/UiiaLzyzLTZEG5YVqiAq80HT57jCvsLkwYnyrzJ1gu7M5BfWcj7+Y3qk?=
 =?us-ascii?Q?n0r1ZfpEFXR2gcdAhR7SiHltDFKyqDutz678TNYgfKfTx31P0xMjbE0i70wv?=
 =?us-ascii?Q?d7OyeJffrFpRtxN+MKa3u3vBU7WoWceItZbExSWBDIM0fAvVCMqS8PAoZy3l?=
 =?us-ascii?Q?ryE1VLVByzqs7s6i8mbYeflXcXZCv7DBWM7aCYAY1wCwFUHENdKxhkfxDYkl?=
 =?us-ascii?Q?W4qL0H/qVG/y8hDyZ/0KrJeTQhEAqGvT30W6czuIqKtmUczw2E5PvjrGOwJz?=
 =?us-ascii?Q?xIZoo9RnYKc2oubNyQ8xlQ6mhJoUlJFzPgcsPqRmuRAzcrZ9AVbgvx8bAzbF?=
 =?us-ascii?Q?zGP5Hv/pg6lSXOGjKxwlgjJqHQytCm4/XwFr0oj35+W0O/aPv8m8Ye/HbSzQ?=
 =?us-ascii?Q?S8SqPULVS+fpvrBmuhli/KCkAE9sZBK1Ed2AM9ZXECBweegNubVnX8sxyQUJ?=
 =?us-ascii?Q?Uy5tQVRL9U+7thUfz77adEe6NcAfp1XjwNoHvH0xibIUyjEz45lVugLz2NhR?=
 =?us-ascii?Q?Ncd2TX9d0hZvOjsJ8ftabcWru4NkQStDU+BAhicQ9UdSAO/FWfvF65kJ4gW/?=
 =?us-ascii?Q?8JK759tY7DkkJrYTE1Kb7gFmdQ+9qlIiYKwxfYUFbE6Mp9LzWGFfrrL2BqB8?=
 =?us-ascii?Q?MXWthtqhPVdUsYQIISzJ5Ag6/Q7GDNodSFDcQiGHOtx/6J4gt1AmZ/R054PW?=
 =?us-ascii?Q?DjSo67lGHU90LhlLy3mS4jlYSfDmxg1gBUj4PrCi4JIK/WE1r59EgtNFpAHS?=
 =?us-ascii?Q?Y/GQwYybPfWGJucRmY1hG40peEXi9e+04wYLj1oqVYpfw38/QNAoizelHJFH?=
 =?us-ascii?Q?YUKC4+8qD8LXmYYGGAORQAVptcUJkZwf4Q1z3tYW4CCDmvuAjAvwaV2acjXE?=
 =?us-ascii?Q?sx81Uye0dyMLeUI95WN3YsbX+FS/s73Vd40u29rUsxmbVklXicuuGGWj0OmB?=
 =?us-ascii?Q?l5lwBLlnx00aB6XoaX6wxDRc7aaPOm27HixrxQhMtOar0lP30CCTxeZa5Y3i?=
 =?us-ascii?Q?Wq+AEjuc5GL3gNGLuiP1JYcxiE8sU5UzJf4kQGz6mmhaYTHO2CNHQnVPEhVs?=
 =?us-ascii?Q?pjv5EATAEKuXkdrCDLyPzMretWL3VF9GcdkoCHSetmyfbnAwQJTiKzs6Oq+g?=
 =?us-ascii?Q?CAFO/Ft8dd+12GMKdORxhvSRdTyn4trYqC8i6h9ynGvWeOD3QoOcslbSPI+4?=
 =?us-ascii?Q?k/O7LvDfYLaPFcPg7OQiV/Pl/1fjl1VV31PIxKOA98e/Ota+ACxnFuZZWGCf?=
 =?us-ascii?Q?GjgSmA0FOD1I1GrxNpZEJPIZ9eWXATBVvXlZ85ochZgmbuJnrYOVSECcg/jV?=
 =?us-ascii?Q?I+kpO/YuQ1iP83tgqULucaMK5NTla7qcAJsc8DErlhGXYPJPFpSAgcGN946I?=
 =?us-ascii?Q?6g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ccb7d66-c481-4475-a2fd-08dc8f1fe50a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 22:50:33.0499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6xcAza3cT6KplbCQLpYDK5f0GgTwscpHyiqBsvXJPQtewKewV9Okab72OJF7TRB6lNNAW4e9bFyYs5dnOmS4NIzfm+L0cN2mBr2fgAFNu6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5028
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Fri, 24 May 2024 17:53:49 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Provide a survey of the work-in-progress maturity (implementation
> > status) of various aspects of the CXL subsystem.
> > 
> > Clarify that in addition to ongoing upkeep relative to specification
> > updates, there are some long running themes in the driver that respond
> > to the discovery of new corner cases (bugs) and new use cases (feature
> > extensions).
> > 
> > The primary audience is distribution maintainers, but it also serves as
> > a guide for kernel developers to understand what aspects of the CXL
> > subsystem need more help. It is a landing page to document ongoing
> > progress, and a guide to discern exposure to work-in-progress features.
> > 
> > Help wanted / welcome to expand on the "Details" section.
> > 
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> This feels like a really bit opportunity for bikeshedding..
> 
> Ah well, a few comments inline. I've tried restrain my natural tendency
> to argue about number assignments.
> 
> Adam's email address was garbled in my email client - fixed up.
> 
> > ---
> >  Documentation/driver-api/cxl/index.rst        |    2 
> >  Documentation/driver-api/cxl/maturity-map.rst |  173 +++++++++++++++++++++++++
> >  MAINTAINERS                                   |    1 
> >  3 files changed, 176 insertions(+)
> >  create mode 100644 Documentation/driver-api/cxl/maturity-map.rst
> > 
> > diff --git a/Documentation/driver-api/cxl/index.rst b/Documentation/driver-api/cxl/index.rst
> > index 036e49553542..12b82725d322 100644
> > --- a/Documentation/driver-api/cxl/index.rst
> > +++ b/Documentation/driver-api/cxl/index.rst
> > @@ -9,4 +9,6 @@ Compute Express Link
> >  
> >     memory-devices
> >  
> > +   maturity-map
> > +
> >  .. only::  subproject and html
> > diff --git a/Documentation/driver-api/cxl/maturity-map.rst b/Documentation/driver-api/cxl/maturity-map.rst
> > new file mode 100644
> > index 000000000000..9c5bff6484dd
> > --- /dev/null
> > +++ b/Documentation/driver-api/cxl/maturity-map.rst
> > @@ -0,0 +1,173 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +.. include:: <isonum.txt>
> > +
> > +===========================================
> > +Compute Express Link Subsystem Maturity Map
> > +===========================================
> > +
> > +The Linux CXL subsystem tracks the dynamic `CXL specification
> > +<https://computeexpresslink.org/cxl-specification-landing-page>`_ that
> > +continues to respond to new use cases with new features, capability
> > +updates and fixes. At any given point some aspects of the subsystem are
> > +more mature than others. While the periodic pull requests summarize the
> > +`work being incorporated each merge window
> > +<https://lore.kernel.org/linux-cxl/?q=s%3APULL+s%3ACXL+tc%3Atorvalds+NOT+s%3ARe>`_,
> > +those do not always convey progress relative to a starting point and a
> > +future end goal.
> > +
> > +What follows is a coarse breakdown of the subsystem's major
> > +responsibilities along with a maturity score. The expectation is that
> > +the change-history of this document provides an overview summary of the
> > +subsystem maturation over time.
> > +
> > +The maturity scores are:
> > +
> > +- [3] Mature: Work in this area is complete and no changes on the horizon.
> > +  Note that this score can regress from one kernel release to the next
> > +  based on new test results or end user reports.
> > +
> > +- [2] Stabilizing: Major functionality operational, common cases are
> > +  mature, but known corner cases are still a work in progress.
> > +
> > +- [1] Initial: Capability that has exited the Proof of Concept phase, but
> > +  may still have significant gaps to close and fixes to apply as real
> > +  world testing occurs.
> > +
> > +- [0] Known gap: Feature is on a medium to long term horizon to
> > +  implement.  If the specification has a feature that does even have a '0'
> > +  score in this document, there is a good chance that no one in the
> > +  linux-cxl@vger.kernel.org community has started to look at it.
> > +
> > +- X: Out of scope for kernel enabling, or kernel enabling not required
> > +
> > +Feature and Capabilities
> > +========================
> > +
> > +Enumeration / Provisioning
> > +--------------------------
> > +All of the fundamental enumeration an object model of the subsystem is
> > +in place, but there are several corner cases that are pending closure.
> > +
> 
> Feels like we should in passing mention that we support none of the
> bits of CXL fabrics that are host visible (so mainly G-FAM I think).
> 
> [0] Fabrics / G-FAM (chapter 7)
> [0] Global Access Enpoint

Are those [0] or [X], not even sure what the kernel is expected to do with those?

> > +
> > +* [2] CXL Window Enumeration
> > +
> > +  * [0] :ref:`Extended-linear memory-side cache <extended-linear>`
> > +  * [0] Low Memory-hole
> > +  * [0] Hetero-interleave
> > +
> > +* [2] Switch Enumeration
> > +
> > +  * [0] CXL register enumeration link-up dependency
> > +
> > +* [2] HDM Decoder Configuration
> > +
> > +  * [0] Decoder target and granularity constraints
> 
> Feels like you added this one just so we can tick it off ;)

True, the list was a bit of brain dump. I also expect that "git log -p
Documentation/driver-api/cxl/maturity-map.rst" to show small edits like
this. No need to overthink this informal list.

> > +
> > +2 Performance enumeration
> > +
> > +  * [3] Endpoint CDAT
> > +  * [3] Switch CDAT
> > +  * [1] CDAT to Core-mm integration
> 
> [1] x86
> [0] Arm64
> [0] All other arch.
> 
> I guess could argue that's a core-mm problem, but the CEDT code
> just all functions that are only implemented on x86.

Oh, good point, will add.

> 
> > +  * [1] Shared link
> 
> [0] Shared link. We've not merged that one yet though getting closer.

Ok.

> 
> > +
> > +* [2] Hotplug
> > +  (see CXL Window Enumeration)
> > +
> > +  * [0] Handle Soft Reserved conflicts
> > +
> > +* [0] :ref:`RCH link status <rch-link-status>`
> > +
> > +RAS
> > +---
> > +In many ways CXL can be seen as a standardization of what would normally
> > +be handled by custom EDAC drivers. The open development here is
> > +mainly caused by the enumeration corner cases above.
> > +
> > +* [3] Component events (OS)
> > +* [2] Component events (FFM)
> > +* [1] Endpoint protocol errors (OS)
> > +* [1] Endpoint protocol errors (FFM)
> > +* [0] Switch protocol errors (OS)
> > +* [1] Switch protocol errors (FFM)
> > +* [2] DPA->HPA Address translation
> > +
> > +    * [1] XOR Interleave translation
> > +      (see CXL Window Enumeration)
> > +
> > +* [1] Memory Failure coordination
> > +* [0] Scrub control
> 
> [0] PPR
> [0] Sparing 
> [0] Device built in test

Added.

> 
> > +* [2] ACPI error injection EINJ
> > +
> > +  * [0] EINJ v2
> > +  * [X] Compliance DOE
> > +
> > +* [2] Native error injection
> > +* [3] RCH error handling
> > +* [1] VH error handling
> > +
> > +Mailbox commands
> > +----------------
> > +
> > +* [3] Firmware update
> > +* [3] Health / Alerts
> > +* [1] :ref:`Background commands <background-commands>`
> > +* [3] Santization
> > +* [3] Security commands
> > +* [3] RAW Command Debug Passthrough
> > +* [0] CEL-only-validtion Passthrough
> > +* [0] Switch CCI
> > +* [3] Timestamp
> > +* [1] PMU
> 
> Not mailbox, plus breakdown into switch vs type3 - see below.

Done.

> 
> > +* [1] PMEM labels
> > +* [0] PMEM GPF / Dirty Shutdown
> > +
> 
> PMU
> ---
> 
> [1] Type 3 PMU
> [0] Switch USP/ DSP, Root Port

...got it.

> 
> > +Security
> > +--------
> > +
> > +* [X] CXL Trusted Execution Environment Security Protocol (TSP)
> > +* [X] CXL IDE (subsumed by TSP)
> > +
> > +Multi-host memory
> > +-----------------
> > +
> > +* [0] Dynamic Capacity Device Support
> > +* [0] Sharing
> 
> Break this one up
> 
> Memory-pooling
> --------------
> 
> [1] Hotplug of LDs (via PCI hotplug)
> [0] Dynamic Capacity Device (DCD) Support
> 
> Multi-host sharing
> ------------------
> 
> Requires DCD support.
> [0] Hardware coherent shared memory
> [0] Software managed coherency shared memory

Looks good.
