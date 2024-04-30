Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4364C1B806
	for <linux-cxl@vger.kernel.org>; Tue, 30 Apr 2024 23:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714518011; cv=fail; b=hBr5YtKcy/yU3VqJjKiewto+pMnzPOH2TU3R5WI1OuHUaow0dhz8qG/SW3xSo3t+TMLkKs2X5B1gDLVAvWzFkPPkj2p3Q6t7JN1bkgwbiQ/pJeHtKHDkXRwc69xzfr4E6Q4zE5s2wuk+JrHGJE8R0Zs9V5MA//GRqdbjAiXRF2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714518011; c=relaxed/simple;
	bh=hUOZ4w9gQMYfLt6E7/0Ok0bUsxBUfxQgplTMigdCcWQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PocESL9UDYV1xs8Pu9RWTd3/9Vmm7W0BDD/Ii8qEC6PfLg0taZqp9fE0DzqCUiQYUInrYfCCTZdI73GP051uA/EwoOdp//F5J1l5HMsb49oBTUkw0cF7tcaZUpejoL1iUDyMzfz9RtSR2k5luNYwwvcQ4TFMHbmQbxUzVjIc2V8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G6glWaUi; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G6glWaUi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714518009; x=1746054009;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hUOZ4w9gQMYfLt6E7/0Ok0bUsxBUfxQgplTMigdCcWQ=;
  b=G6glWaUilNhxdUL78aUh5/5NIHDFDhXFDbemvcxx2F/cV6aGT6b1hEJ5
   ncNe6C2z+WRAcTVAPbCdiSLwsv6o4o5y4VOsixHjl1ga0a/O/J/2+A91F
   2eH+tX8HWMaaPiVJ1YW0pA1R9+cBQFD3ZH6asYIWmsdX1XT31yJ8K4nlu
   aAO9BHCbBpV+TK/W0B5xRWiV47kIrUi7mNwgUxKKBMKcU3ILcSvWR8SKp
   asgs60M4wsmEmiRU1uL2AR2FZITZjrepgicAO8b38sXEMO0H6JSimnBKe
   jJEFUPoMhCFdp3gb05R0pRF2/RKplTnMogfw+rE/oVUjKz0vkOikiWIom
   w==;
X-CSE-ConnectionGUID: dDdmR9RGR+yf2sywWmOmIQ==
X-CSE-MsgGUID: Zpkyr0J1TS2xbsTf5NYmjw==
X-IronPort-AV: E=McAfee;i="6600,9927,11060"; a="21400333"
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="21400333"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2024 16:00:08 -0700
X-CSE-ConnectionGUID: e+6PQwvqRJymqCo8VW/LcA==
X-CSE-MsgGUID: Wfk340tGShqBi68fe/Kl/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,243,1708416000"; 
   d="scan'208";a="49832915"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Apr 2024 16:00:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Apr 2024 16:00:03 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Apr 2024 16:00:03 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 16:00:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NV0TqE8DlxFOM2rQ7axHtYivcM2p15gNRgT7mwBKofgOvKK0NixGq+RjMEm+G39hij5RHYvEJUl/QopYShUFWbg9m0i0dL2fNXDevfZ6flVSzBI84ubvPMHTWXvjUE/Y5lxu/WE2J6izl595NOdtnEJ6Am6RCGRPrmWvzzH2dG3e41NzQXLoq8AGAM5csYbpWnDd06miLFTyO+iuAnaSxlwPq6OiQiFEb3ur6dKN5WrFBii+6A43Ji0632dJpItjm50XXN6KdMN5TgNxzpZJnWqhDCqiRYWAOsNydvFeiCmkxunJVAKXGLzUFRK8PkjfBRmj2dag747nW0Qdsbu/MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E4Sd7wvvfoS6aKgtQBaUIQb+G4cMBmMRx2XXe+wedHM=;
 b=EYTTsjdyWHJ+hl+lD9X0b/Hnt+OOA5KAMhsoLiyQzeyVVL5iqoKyQTZhY6cmqTkJeQUy5VtBZtTTGNjJDfremxb+MW5Q1/rFqKHhnhtPoFtL/Po9Z1oWw2cE6afIO5WdNaLvZePioZomYnnECBdIEOegvsXNGAcRzytp803aO2pBJJkJFfszQBwoUjCEoAcJ2kknO8ejnvvatrOqZnozHK0+G8Dze5LBVsB22SSmRBwqp5HjJWOkoVEKikGbOOxClHFfL9Kiy47Mu1A0Mgl5SCpdAOsgXgdDCJhZqubiIr/j3tDNqH0XWaNpmB+5xyOv2i+uyOymD24SHTni48kaeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM6PR11MB4658.namprd11.prod.outlook.com (2603:10b6:5:28f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Tue, 30 Apr
 2024 22:59:56 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%5]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 22:59:56 +0000
Date: Tue, 30 Apr 2024 15:59:54 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/3] cxl/region: Verify target positions using the
 ordered target list
Message-ID: <663177ea1ca3_10c21294f5@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1714159486.git.alison.schofield@intel.com>
 <a5121a8d37dd62581015452a77113f88df2ede25.1714159486.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a5121a8d37dd62581015452a77113f88df2ede25.1714159486.git.alison.schofield@intel.com>
X-ClientProxiedBy: MW2PR16CA0040.namprd16.prod.outlook.com
 (2603:10b6:907:1::17) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM6PR11MB4658:EE_
X-MS-Office365-Filtering-Correlation-Id: c1fbfddc-d4d5-4af0-3a85-08dc696940ce
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?j0C7D5+Dq6gJHUiHHXFOA86G8Kh60MXI0vpgOXzOXstgefugpASlVDaHtiti?=
 =?us-ascii?Q?rbHwzEMTBCl4NdX2QxekgH844q9IqasewfBjZWka2jT8L68puI4gAsBzFRak?=
 =?us-ascii?Q?8rdPCb6JoUOfhtMIUTr1wKccJ8XaFgJ2FCORz4/gzzUXB5p8tq/nSBgu8yD6?=
 =?us-ascii?Q?7ojpu3eXKblqL1AGqhTFW4cx56xr2JmwLH4OzBMC78/3pTVm6ytFjGQf454V?=
 =?us-ascii?Q?uJSff5RxjtMtyo66Fp5wTJeyFCEGD3QrOHDIGMIDSp2xXvB37SXzwRqSbnc0?=
 =?us-ascii?Q?iRd0AuAiE5LzvkwgdlZe4CoG0tNxHSFf9ilmHVNPFn4LXyZB3nzI3FdfSWd1?=
 =?us-ascii?Q?CNRud4okWBwbz/EphjiWvR897jwrTx5sCzPM50XHID/16nWvU2axO+ZmmeTJ?=
 =?us-ascii?Q?AkO4uL8roYhhXeZtnDOHlzt2M8D+x1HJVAx5I3TzHG5VJ7XxV+R0250A9W9o?=
 =?us-ascii?Q?wT55jdhKsPJ0lN459I7RyaVLVdagGb4uf7G1wM/tFfJgqjJ45VGg6ZRsdHsd?=
 =?us-ascii?Q?bJU7ITq/AAjSNRea05Sk4LRTvAQmKD+VwhiakyVKgD6WatsQfNt5ziN+qolb?=
 =?us-ascii?Q?Fm9fOcSHyV9PMH5/z0jmG7hP/48BxG1bbACBnUr8kRe7sgqDK5F4eSik11p9?=
 =?us-ascii?Q?oircHtloABbFopb+zOUFaNQiZyEwcCc2ApuA3cuwSdrUyVDh0NQMNiuHRxwo?=
 =?us-ascii?Q?I72diY2vHjnTbEn6j8wsZ3YsXAyW7jjewZHoWUJQmTXM9kEIjjsGUkDe7ucV?=
 =?us-ascii?Q?nZBgxIe4HfLGaE3DQmeY5V9cuZy0TgRFQPiQ88dZNDEjeOtRlPO+hSsGcUel?=
 =?us-ascii?Q?SoN+UPj3TEcH954Ck/rM0Das+9BLK5wo1qKSFGgRepI3rJgCvpKRuHCQ1Sa6?=
 =?us-ascii?Q?s21kmco5Yop9vPszHVls/pSpjU3m19NHu4RoPmQZzH3IJdcBjd6uPj1nTs6Q?=
 =?us-ascii?Q?Nfga6PD5y7jxmX/8WoFpuPG9kgE10eaW7GA4p+3u4zqi+jmPzThY8sIEfyI6?=
 =?us-ascii?Q?bQs3+SBSV3Co41NEVOGZRj0+GBeQQ7+MoPKFaa4Q0EiNCu72f+j8nUePGoM+?=
 =?us-ascii?Q?R397kBGhovfXr0T0T+a9Qbk144Ucs0WljKI/zgi98Qym8VRIfJNc2buFAHGX?=
 =?us-ascii?Q?wDdhS4CknfrPCuPcrQSNABiam4XSw99SokCgPnjB+BlWBjF67bWjHwhgrhzM?=
 =?us-ascii?Q?ZJEfzhjQP+UBo6v04wLFaSzkD1SiZRlavGhFTpzPSXNrrjvEYsIW52gLLVWI?=
 =?us-ascii?Q?fB0yvj82wG9XoL1qFMYcXp7Z4SQcTnQ8nEkOTipU2Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dt14p1Tuj4OuGVcZwsq+DmcjDONhX4QdlGL66p7WV3bZ1W3QpDDq205uhAM+?=
 =?us-ascii?Q?0DB+YMs2in8aUwd5FcPGPCmG1yte97RTmgqAPOGMrzeYS2cfn6iIZy1rT5XG?=
 =?us-ascii?Q?tYgQKmDGyloI898pyBFf+qzJ2/0hXBTW0HVCzl86+LT5Vu9HXwiEBG/T7ceM?=
 =?us-ascii?Q?GP8xHsiGoAfFEN1/3XgTiqvtyX4hBCbNIGsPnCJfWWl0b0iwD3nWYQzcn/lw?=
 =?us-ascii?Q?Nz1Fcot3uLcNUAMtwvFTZPTHrN22S/mCUmFLVEQHxF/Ihk6Wcpz6UFsxnqk6?=
 =?us-ascii?Q?8ki0JcQvNCHTOLR/nIPnzbWKxWdTGKmCpVT7b4qH/37yEBDKYufbKqo7r8yQ?=
 =?us-ascii?Q?Pf7d2caRIifXm126rXQKitWKGGBHES7Ua7z2P6TuibiOFYpNDKDf/BVRB9ej?=
 =?us-ascii?Q?XGlx3XPi+0rBI4PwlVB8mAGTzoLIhb3TdwLhN/IEjpl5O+lTxr305zJ0neuc?=
 =?us-ascii?Q?vS3KMYgNmBwisc9HhkESwTvETNkbP9wvxLmED2KNEOkkk4XPn15RDY0e2NcM?=
 =?us-ascii?Q?DGCA5lwjsiyWenOfvpOta6sxHWAF27DIejRWxuJnbmdllnt9ChnY+7aBtRuf?=
 =?us-ascii?Q?UUIi1O7LBcJgAKzBJ+U1YvNLR9q1th6Z9cWANq2h97gtTW61OtWw+xgat8pY?=
 =?us-ascii?Q?RaIKyfpKi+RJ9hjmNPttRI1GzfU4R28wMIztyPHqBwMQ2k0lJj/3fFTdlWMw?=
 =?us-ascii?Q?T8D2CxUufkpHEGTGRNL8Il3tcsY/s/UVGdF2Oi3Z9075laBR5kw8I9OpSggW?=
 =?us-ascii?Q?qemuq1fpSQ+jITuki3nQgOt7vB+w41oy+LJDubSlRfTlFRNlUY1WuItzwoWS?=
 =?us-ascii?Q?w6Vp3h/Gc2mzOeE4haMswkh5iEU11hFHoI+9tbLOhm2+kAtQ7mdxOs12iuUs?=
 =?us-ascii?Q?wG+W2gXg5WM4eSttcjd8MPEHahHli4/DYyQ3QJkR/qHFo4HwKArCb6m4BaIp?=
 =?us-ascii?Q?Mw6yg8ZmdvmmJis3OvpGX74HLlKdDlYpawgziAcp61Qw0GmUpMFUNciSIFum?=
 =?us-ascii?Q?ZvxM8GXMLiVuj0CiXwtXU5l17JVaiCOMRGRLetf6aFen1AyOYgaoaH4Sdk9U?=
 =?us-ascii?Q?beOY14ZGdHiIKjlps1eSS2bigiV9vUN4moW3C3hlrr3+sF2Ym5FSXKrrtuNB?=
 =?us-ascii?Q?x/9HAWI4ZNSlINlKq+o8X8TgYynrxzhSK83/4HFOrzgaPWIj6qldiRHX54W2?=
 =?us-ascii?Q?SDaPpUtAGNlEjHkvUsXjVbE8WRG681X21LtY+yFfPH/rb07PgbEUMvZd8sIO?=
 =?us-ascii?Q?3fA00SHnIgTKiQjfe3v+QRZlqJ3cgci/R4gkUNcHUYfSj/rMSCVLDqiCrQRW?=
 =?us-ascii?Q?uGH0jMpwhLFEiHUvdzg7hHX5rC/V5RhOrvbVjeh/+3huCNR04RgbM1JnNZg4?=
 =?us-ascii?Q?Fh1+dtHR9JBxNCdhu8WiovTDreWzmNIRV8NH6I9f2rUVNezw4Uf8AdOTPgCL?=
 =?us-ascii?Q?ehQyQA+s7SUOcd/yrE53yQXxCxA3KZWaNDBVkjT1o7YO+g2ChwLJP90Dvhmo?=
 =?us-ascii?Q?U7as4ZTPFwWa4i+Bs6n7NifGValHEJN5oglCtdloakNOCHk71G1mXGpJuh4g?=
 =?us-ascii?Q?opHZIs1+s1kLoZztfairu34VRyB9wR/50Pipa6evEMJTaXI8HwKUEq0Gq90P?=
 =?us-ascii?Q?tA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c1fbfddc-d4d5-4af0-3a85-08dc696940ce
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 22:59:56.0545
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NtuaAg0u0dpVh25M8QXscx1Yq1Uo5gdEJ14PSZm/LXdxIih9bmdl8DYm2cAyebkShib6MAkX/oYRJ0lKe96vXvAGMLm327KWzgNC/LAF5jw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4658
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> When a root decoder is configured the interleave target list is read
> from the BIOS populated CFMWS structure. Per the CXL spec 3.1 Table
> 9-22 the target list is in interleave order. The CXL driver populates
> its decoder target list in the same order and stores it in 'struct
> cxl_switch_decoder' field "@target: active ordered target list in
> current decoder configuration"
> 
> Given the promise of an ordered list, the driver can stop duplicating
> the work of BIOS and simply check target positions against the ordered
> list during region configuration.
> 
> The simplified check against the ordered list is presented here.
> A follow-on patch will remove the unused code.
> 
> For Modulo arithmetic this is not a fix, only a simplification.
> For XOR arithmetic this is a fix for HB IW of 6,12.
> 
> Fixes: f9db85bfec0d ("cxl/acpi: Support CXL XOR Interleave Math (CXIMS)")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/region.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 5c186e0a39b9..3c20f8364b26 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1559,10 +1559,17 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
>  				      const struct cxl_dport *dport, int pos)
>  {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_switch_decoder *cxlsd = &cxlrd->cxlsd;
> +	struct cxl_decoder *cxld = &cxlsd->cxld;
> +	int iw = cxld->interleave_ways;
>  	struct cxl_port *iter;
>  	int rc;
>  
> -	if (cxlrd->calc_hb(cxlrd, pos) != dport) {
> +	if (dev_WARN_ONCE(&cxld->dev, iw != cxlsd->nr_targets,
> +			  "misconfigured root decoder\n"))
> +		return -ENXIO;

This is a nop because root-decoders by definition have all of their
targets covered in the interleave, and the driver passes the CFWMS
interleaves_ways setting directly to the @nr_targets parameter of
cxl_switch_decoder_init().

So drop this warning, which in retrospect was never needed , and it all
gets cleaned up in your next patch.

> +
> +	if (dport != cxlrd->cxlsd.target[pos % iw]) {

Looks ok, but I don't understand why this patch is tagged as a fix?
There should be no end user visible change of this conversion, right?
