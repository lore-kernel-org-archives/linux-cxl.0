Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2694123D7CF;
	Tue, 10 Mar 2026 21:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773178486; cv=fail; b=Btx0hMoZqqjkg3M3DZ4M06k1Fp3d83uSryc+1gH5m0UH6VDeuCUH4a/1WYzbMwErg/spiSw06zNXlHWcdp0V6PDl/bQVNxG46U4NwlNC5ShoXMWQDP4Gr9ePJiobO4L+qDiDfxa04HBhdO4831GXrE4e7ifQmoSS7W9NDWkLdFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773178486; c=relaxed/simple;
	bh=CKJ/s31uDSlery1JbJQ1n2b4b5f6/KXtTtcwmAhsGeU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FDvbEHjaEy8ObnZFOh8XB/oeMu0QjIlxVMOO1TpQRcTTWkCzBzqCFddsJNf4le/O0k5pzIGEV90Lw3cRXJgMyXyIXLx6iVSBU3MfXrQ4P4uxhOTg+RgA/W4DrBV56scSLAJstoCDDmHkg+NGiRKUM2OiYZhDI9kzH/43CkJ/Fuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SlsjCu3F; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SlsjCu3F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773178483; x=1804714483;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=CKJ/s31uDSlery1JbJQ1n2b4b5f6/KXtTtcwmAhsGeU=;
  b=SlsjCu3F1HsKZ8D300i3TGXCAT8GsEmizTJPUKJ1tPri4rJuiG0jWDDG
   oKyol8IAhSvZCzD2q3jSAg+VIIMsnlE8quTspgAzgyvP/uphpAunV557r
   ndINxn4dd07lUETA5A3iF3VGYkot6DLDEqLwRWKPeR14/0N+cLgoT+KxS
   +8PvjvqEwRpjWc/W4C8lwwovA/JIEloiVdRv51rjyGMGUCr+uCWC0zprK
   eGkFNImLqU3jcdn6/dvLw9brHdNMPfrJ5+5P8wnplisKq/CpGuUYDbhqc
   vjww6g2YoFnxpPJ8VtNE37f7vyXTMqHrgsLhqBBt4LNhrHIwIUwr9BPbg
   A==;
X-CSE-ConnectionGUID: 5aDEaZM0Q7iR36bDBGuXCw==
X-CSE-MsgGUID: KD79DiU7S+WPz2x+jf30bA==
X-IronPort-AV: E=McAfee;i="6800,10657,11725"; a="74281234"
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="74281234"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 14:34:42 -0700
X-CSE-ConnectionGUID: n2Se697JQNKmQz/jnQ7rlA==
X-CSE-MsgGUID: KXNxtb3cRY6ccAsGCSI1sA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,112,1770624000"; 
   d="scan'208";a="216573881"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2026 14:34:42 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 14:34:41 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 10 Mar 2026 14:34:41 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.3) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 10 Mar 2026 14:34:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vIP56MeEBiBAlU5B0tZ0zsRpKSG2j0hTq1fzKbQ0oKT6a+bIOwCBi8XefQyyJGGOn4j16uapQlDz0oo7fjDsJHzFpHrQgslVklrpyKBraXSs+qAxWAgpGfsyL5Chm1F0iE6XTgF5B+E1sdrVxydNZNO9y2Oikhm4WMaLf/EfqnSzKDUKpCoCbrVThBl82xa8tgHaJ/fAjbhyvx782K1ZH5BmZEpqcMp0dyVLz9WcB5spSsNJWtpdZiwBLbHqQC/xUnReLt8hJdj4+jN3xKBOXg6iLEarrW6jNDxgyNKo8iYrQj9eIMQlxlE5U9l9AlJ6zvUJWC/s5JHT3xDvb/2zvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UHEilBRxedWsapXgLpyzilQbSkJTzBCgEXzicXptrdk=;
 b=SiCv0Nb00+mIFSkg0LD1rIEArRSQ9HA4vXJ6Klzb6Z2AzIz4T7pODKRaGUkna9hJVC41rXTVh62OP5I+Qdlrog6mPiRd+5IZ3vb3vYZma9KlpFswkkfZ+IcfN2NizR9FD6mEI+EA01Ayc9z7YcYqR6tcdvPjXqQ7xEOV4I6vu5jlM6wRgjHgLx13cNIYUcJnnYzVgptLoi73XYAsRIpXzA5tpyVVq2IW7RFhke3lbS2TinVR10h+FExWrcYlEHM2MGBRlxNTyFtJ+9/wzPToUB5FW39nuN/wyg+38zICtJufjTNgp9NBbzWTn8QWwZNUjBJHPVVWzHW5JdN7CVLV/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by CY8PR11MB7136.namprd11.prod.outlook.com (2603:10b6:930:60::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Tue, 10 Mar
 2026 21:34:38 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a%7]) with mapi id 15.20.9700.010; Tue, 10 Mar 2026
 21:34:37 +0000
Date: Tue, 10 Mar 2026 14:34:29 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Davidlohr Bueso
	<dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>, "Dave
 Jiang" <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, Ben Cheatham <benjamin.cheatham@amd.com>,
	<driver-core@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/7] cxl/memdev: Hold memdev lock during memdev poison
 injection/clear
Message-ID: <abCOZf9vkau0AyWL@aschofie-mobl2.lan>
References: <20260310-fix_access_endpoint_without_drv_check-v1-0-94fe919a0b87@zohomail.com>
 <20260310-fix_access_endpoint_without_drv_check-v1-2-94fe919a0b87@zohomail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260310-fix_access_endpoint_without_drv_check-v1-2-94fe919a0b87@zohomail.com>
X-ClientProxiedBy: BYAPR01CA0058.prod.exchangelabs.com (2603:10b6:a03:94::35)
 To DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|CY8PR11MB7136:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b691f20-0192-4ef0-cda4-08de7eecd476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: IJMVP9v8Om8c5nOzD7/EuS2qjesXjByOL12jTMsBDPhZg7FA02XDpyjBEtfeleo+GhUqjQ6XtIfHMiP8LP/mx9Orc7fuSNYYD9TJ5mZWWWfHq/zyB+P15aQe/vhCOT77Sz8X6++tD7cR2CgLVNrTDxo6CJMwn8nfDN0um/5spVXA7CdDsbNAUyXelSQNWzrLJV5aDhCPGuvtLPatkcj60mcLICvN5GK3opDMXIOG4mtQuf5MyoaF9YoL00/3LLoJxw/dzkfaYFtDMjQtnfbCTj/Ym3TA6rYs/npVK1V0Cq/7zFG6u4IeKoJdR7cMpTtFqkqRHXhOUYCqFmYFFZqT8E9IDkqhav0V6BHxgT0RBzblpfYqmfK8QOeqD6Nyj3Xd6jPqc5qAGJSgyHbGEKv7JQ0M7NlCWPXXKs5j3fYTZKMVJ3A+2JgCGmLn8+ZcmXbgneJOTXG6nyxlkZcvy8DBZm4bHeXYfP0s8ynzMKXzlh9RrRE8DDHKzuvqJdqhbKe5B954WFpRuuaI1oWEO3nEynjTvu7k+T816uj4HGow8BMI5dWbScYKPHD3ztXwINxGTyVNJxHH1xBNFeE3z3WFBGxE0YnJVv9uzBm1PgzYp3Yo6BdsFEXGqNGt9911Myx9yAKa1MKw4S6znDnmQBMVi4d3s8fCgRXDWTEtn+c64t6Gpt954RtfqJLT1aOmHev3atc4uqyHeFswDiDEK6yYJterjyRFFa3Iim1C/10kjbc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qTGIRbPX7twKjHYsV4c/WMkdEjvQEamUD/1F3Vd7UcOxpSPcprRuld3Gi4J1?=
 =?us-ascii?Q?LIP3iOmYZgEWgqmuhvKOBwNq+rzwCiDaFvuq5coxhuuOOEcu2Fg7diT+XMfS?=
 =?us-ascii?Q?1y/3H/yUeowuftDD/NvjsZtJPcnQWNe6b7atYnzH6Eb4yjro6ifBALXOKv4t?=
 =?us-ascii?Q?EIy3ce2bf0HyGLbrkW7QsVSGavVJTIjlfBTwKNNCxYTSb+IxQ/5ym7eY2xKX?=
 =?us-ascii?Q?vZXgTFeIJ4oYYMT4ejH2KgYKQxbLsWTN8DTXsDzBokgF5Kfy3E2m5CURjua1?=
 =?us-ascii?Q?nKoZnxrn5lzJDZD4CVoBuJSpuy3OpbxPgscdSltwEH/sw/W8TXPqRvtpTmoF?=
 =?us-ascii?Q?SdRNcVlUWtTbjXEZtxYpgV9ty0H2f4HESPRt1MytAbVPdSoBcaJEPDezfXlW?=
 =?us-ascii?Q?2+Mw8OoQnODYdGHh5VHRAFVDO80FoawdrytfV9fxZSqfjJRALBxgy/khmQ2j?=
 =?us-ascii?Q?+VMXNSVYmmYBNdUt9xrAe+namizJg9hmrBJddMdLPHfHO/mpB1et22rk3KMX?=
 =?us-ascii?Q?0Bue/QyYvOmfxILKnigrgrVgABAt/VPCfBtrdAKbQyioP0MPyXiLCCNwhIr1?=
 =?us-ascii?Q?X69gI2crym1VwNhomPcUtkbwgk03JDY0d2KOsTe04ob1PLRecESGKdCSFBIX?=
 =?us-ascii?Q?cm7oA0f14lfM1pQUL9UYJkjdv0mdpfo8qWNS/TYkstTBjuVIm/zm2Xz0OtUo?=
 =?us-ascii?Q?uj3QJTDKk489/so6AO0HDcgg61Zvmu1vE//IdVzWhNNB4RsKnOEb15aQ3rdP?=
 =?us-ascii?Q?FquH1TtBmTMyAhvcErMI+DgZ1izdTHV0WTimTjj/16jAkKv3lM/Q/jHwr7TK?=
 =?us-ascii?Q?XkbVK22hlVr8xe4oZtL/G2elLSFK0aWI00YnBv3nTaoDVc6ojc0CDpzoMNG6?=
 =?us-ascii?Q?QydML+LJn+GZwj+sPX6BAn/t2it35To37Z/11I+5GLllOQQU1JYl9cNAP8Oj?=
 =?us-ascii?Q?kFnF0sZyJg4LGK3jhkHldlTTnnp+yzphlG04g3LcIkFTw5jOVd2fex/8Yhg9?=
 =?us-ascii?Q?YNA44rAaVSBtwVpe/6l6QA0xF5/U/DNWV1Z3bWRtTe3l0cQf8qwfHKNBOT/p?=
 =?us-ascii?Q?kL/rVX8Uoq88DGeB3aG1B+vyjhwdLyxfHUeFggopY4Jtvsq8HqYnoKGnBI07?=
 =?us-ascii?Q?gBxCM6GWe2bo4S2hKx7PYsYZJoKxAEB3GIB/cG97EY7/otH+Ejep09XzYh/P?=
 =?us-ascii?Q?qdrHLRPr3/+DXLsblBSu4T6AaZXcmNGWiOuyqR9B9WSxUS8j2n12N+9xGzfY?=
 =?us-ascii?Q?m7qLmsxAmb7+59c1e1YAtUoJ71UM0ULMDN3Q70utHyIE1GdCE15jhDvJUeNd?=
 =?us-ascii?Q?9VJnI3iQ9jdOyZuHuyTcpvfBe6P0fjgxvZQp9jvY4BOuYX2nL0XfufBrMr4I?=
 =?us-ascii?Q?YwvLFOwopTtZrDUh+Hekf5i89epQJEEOmFf7d+pyoKtjePvluGavncH/XGj1?=
 =?us-ascii?Q?Ssg7plUvYgM82h7kdtJLKZcLhzDDaa4YgWY3JeeQRbUMALKGLNVcD5XwLS+O?=
 =?us-ascii?Q?kI3hxSJ2gXL3h7kP5XlHTpdoOvxHyxwbw1zpsgmPLi//aR1Vta25cl+7IOKZ?=
 =?us-ascii?Q?YzWWiBzQrRKPhFqJtfTI2sDf+m+ZxGaF2Kkvv/iUmKBS/wRqaHznkUZPM6ET?=
 =?us-ascii?Q?zSBkZcsDm3GEf5WZdAeS9saASP/c8ujrr93Bt1kUs2u/Mthx+oV5J0YDDoGC?=
 =?us-ascii?Q?ac9qs7+KGwMad+MLpFFWSuLX28XXw6F4MjHwABYEreHH40irx5Fgw+eVzj/S?=
 =?us-ascii?Q?9aJRaIcMUcYmXKlG1fkZKoSSoKMOeMo=3D?=
X-Exchange-RoutingPolicyChecked: mk9pqAVY6qSDe2Nym2xlJ6GA9SdjsB02U02L6VNPkeCA3jdwM3jPtwajSswCne/0XgxReVv5ZfdpXeIDzN8Q5NMaaK+JRyuyK3MNJKzykXM5BTdbfDXqqIh6S28eZU1cWmf1wx8TrqW+jgEFAxtFOGBhe17DIbm2YnNBdy9uvsNS/R4Y1xLMiKVLetfXir3jq7Bfh/gY5zpoEdVL5Y4Ex+DH6u+YKF+hWMW3TwSwYE2FgIQwONxNMtxotubfOfXu93AoprSBZQRoMzQJg7JkT5eVAKohKUCjJm826wWN6Cyf14xiChOBC/6lEDJD8e/CXYF00MGSW+03xKZGTt/XKw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b691f20-0192-4ef0-cda4-08de7eecd476
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2026 21:34:37.7275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qcrHSU3vRi5bNht75ppgUXAAQW7KzCWGhSOOIVpcMERLwjIDjvNj6ZrbQSzAIjas0qIX6292QFYGtnm9Z9mPDcOgzQ4W3pdnK6KUzxU5R0k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7136
X-OriginatorOrg: intel.com

On Tue, Mar 10, 2026 at 11:57:54PM +0800, Li Ming wrote:
> CXL memdev poison injection/clearing debugfs interfaces are visible
> before the CXL memdev endpoint initialization, If user accesses the
> interfaces before cxlmd->endpoint updated, it is possible to access an
> invalid endpoint in cxl_dpa_to_region().
> 
> Hold CXL memdev lock at the beginning of the interfaces, this blocks the
> interfaces until CXL memdev probing completed.
> 
> The following patch will check the given endpoint validity in
> cxl_dpa_to_region().
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---
>  drivers/cxl/core/memdev.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 273c22118d3d..8ebaf9e96035 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -295,6 +295,7 @@ int cxl_inject_poison_locked(struct cxl_memdev *cxlmd, u64 dpa)
>  	if (!IS_ENABLED(CONFIG_DEBUG_FS))
>  		return 0;
>  
> +	device_lock_assert(&cxlmd->dev);
>  	lockdep_assert_held(&cxl_rwsem.dpa);
>  	lockdep_assert_held(&cxl_rwsem.region);

I'm having second thoughts about this since this call site is not
the 'beginning of the interfaces' as the commit msg suggests.

What about taking the device lock in the debugfs func, ie -
mem.c : cxl_inject_poison. If the goal is to avoid using the debugfs
interface before probe completes, that does it.

At this callsite, we make sure nothing changes out from under us,
no endpoints attach or detach during the work.

>  
> @@ -331,6 +332,10 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  {
>  	int rc;
>  
> +	ACQUIRE(device_intr, devlock)(&cxlmd->dev);
> +	if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
> +		return rc;
> +
>  	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
>  	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
>  		return rc;
> @@ -355,6 +360,7 @@ int cxl_clear_poison_locked(struct cxl_memdev *cxlmd, u64 dpa)
>  	if (!IS_ENABLED(CONFIG_DEBUG_FS))
>  		return 0;
>  
> +	device_lock_assert(&cxlmd->dev);
>  	lockdep_assert_held(&cxl_rwsem.dpa);
>  	lockdep_assert_held(&cxl_rwsem.region);
>  
> @@ -400,6 +406,10 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  {
>  	int rc;
>  
> +	ACQUIRE(device_intr, devlock)(&cxlmd->dev);
> +	if ((rc = ACQUIRE_ERR(device_intr, &devlock)))
> +		return rc;
> +
>  	ACQUIRE(rwsem_read_intr, region_rwsem)(&cxl_rwsem.region);
>  	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &region_rwsem)))
>  		return rc;
> 
> -- 
> 2.43.0
> 
