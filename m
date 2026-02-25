Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880AF385525
	for <linux-cxl@vger.kernel.org>; Wed, 25 Feb 2026 23:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772063361; cv=fail; b=FM/KhiP8hMeqgkGrmb+rc1IXnIvW7TG+PnsYYnqiM/GCJFrT4gCWNtJ1725hrdh20NZlzUtNMGRI1paiIt0GtwLVkIOQHX2q7zKVO95YVUjKvxJW7VTbJ5bWM1h+K0hq4vfNO6Fv6seBA9ZJ3YLAoe4Ujl5wqA9NvNNpPsKpHXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772063361; c=relaxed/simple;
	bh=AztqrEHfx5xWrDF0U/9SJXj1A3N3RkeEHVYax/Dt+YU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=P1bz3RCgT1ZJugeXNVNk8pOj3tVcOnobHWiT7OTSHBy4pKGvgY4CVOzIN+2RdwunWxD1BwEI2NiAf0K+UCAz+PnlUbBKW/bX5y79rSlwOwmlqxwC2glF4g5kuML0GidjI1dzkd/xfFDzX3E9mCU3tInbMVSgRqgmt87lKhB8CX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kk6LT6Q6; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kk6LT6Q6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772063359; x=1803599359;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AztqrEHfx5xWrDF0U/9SJXj1A3N3RkeEHVYax/Dt+YU=;
  b=kk6LT6Q6MyrhKSiFkk6lZV9AdLqeOb/M5QnkPDYofknR2ed1PMJxv4nw
   6DgXUzeXTrVgIubq5wOVPf+FwBRew3WOJZWBabBx8NwsPkoehKwrsdmks
   kadQHZ38lYWh19hb2mfQIKXp6DlXex+ZM+ITjI/2cDEavXbLnnv2nKtCE
   IPXhCfeLOCZ5s7c/KW7rcLf8zOBqKTLmdTT7ZXbw9607nXnyzs6ZKFkNC
   CLl1Wl9LrP0sot2qFdPuNT/Sh1ABn0vifCaNtZ4o8kEtK09kJB2iBCr0U
   8rF+MdLJCWBhXF1CgLQVfwZVnp/6t+hoZeayevclVyOGXVby/Se6+dWIK
   g==;
X-CSE-ConnectionGUID: 1+csZbv+ReWKSycBpZ2WGg==
X-CSE-MsgGUID: YVF1v6DSTkSh6ZbAwG0z4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11712"; a="83447499"
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="83447499"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 15:49:19 -0800
X-CSE-ConnectionGUID: HXXSLBZ3SSiBNOGQANeZSw==
X-CSE-MsgGUID: 2N9VRJaPRb2DnXwbo2ethg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,311,1763452800"; 
   d="scan'208";a="219763757"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 15:49:19 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 25 Feb 2026 15:49:18 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35 via Frontend Transport; Wed, 25 Feb 2026 15:49:18 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.63) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 25 Feb 2026 15:49:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RYQ/t0WbBioBN0vKSs4CDKKeYoCg3AUqr31PodylvioU/4bxymhKi1b6l4mcWGOUVNU8dyZpfmZvR8rysnZIK/o6YVFQMeEAh2i4+wGSUKrhDtMAKZxaoLjwZQor+Z48A3MhsxtmBfYnmApjkHfclfZ9kqRPh7p49AaF5AKvBimUy/fHRss9dl5a2stuH0w1r1ViPRD6ceMpThSlLcw60OTvfxa8DfShhBQWHxJj/wiT4bOUyNb1gEDDKXR/I5W0sndK9TJqG9O7RiVJEBD9sKRNIbmooOU3pRys0l7RqZ05u88oaEN9tOtIN9dNL4zLcVfJg8SeHNt9wiz4LbbvHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sskJyUlqigd+8eydoo0p7kMAcAlmGQKnPhj6OeOdA7E=;
 b=MfG1e1wJYFRBbdHOQZ8igOIntk4aO6d4ataC913KoeeAge7j4k6hmYn+wru3OI4bIN0jM/gc5lCuqQJLN2wCay3OijkQHeIVdlqeb4sbKj6SCyLO2hZ/8CuFqwai2jz30hNKawu4N51SzFOsRZ8yUj+9qnFUdk/4cnmGaZWttbb3pNIfSU4a/SPWe6e7P9X/oJm4OnnLdo3JhmR8C+JRo/liproWdTDzRf9HGHgk5Byk3lMYyMYTmEcJHHEnsdS4JfDwhs3Cq72rrWIvfoiaq5CfxPHJO6mrX6fMOgUSdR7cHVdDDL5sErZfLOQ7VkPndmQdAuX62AkFALN3zQhszg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by PH0PR11MB7712.namprd11.prod.outlook.com (2603:10b6:510:290::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.17; Wed, 25 Feb
 2026 23:49:15 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::4a5f:d967:acb2:e28a%6]) with mapi id 15.20.9632.017; Wed, 25 Feb 2026
 23:49:15 +0000
Date: Wed, 25 Feb 2026 15:49:12 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: <alejandro.lucero-palau@amd.com>
CC: <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>, Gregory Price
	<gourry@gourry.net>
Subject: Re: [PATCH v2 2/3] cxl/region: Factor out interleave ways setup
Message-ID: <aZ-KeLC8tKemoNJH@aschofie-mobl2.lan>
References: <20260225122223.3841889-1-alejandro.lucero-palau@amd.com>
 <20260225122223.3841889-3-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260225122223.3841889-3-alejandro.lucero-palau@amd.com>
X-ClientProxiedBy: BYAPR01CA0055.prod.exchangelabs.com (2603:10b6:a03:94::32)
 To DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|PH0PR11MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: 977f379e-b419-4a63-fa0a-08de74c87bfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info: hmb9AAGfDG3q4PXu82G3PIeV8rRIpEPc02JkpRPOkw5LZL3Obe8+dR2T2gt8gcpmZJCH0zIxNv7CjSJIM3pMTKjM2Rr46XTT5Ip6horjcYWvx3D9HVxrtciZp8aGHWuDpkZ3aqU9EDxc5nX/xZY9ibmxfVO/eXIYg60mWaNtcPt+Wr5jtvdj2XD5F9V7q/KKQurvTBgSaAoxgixdH9rHB1Q8SOqWEc4brkPbnvbVTIsjkHYGmT1fPb5zcE60RXeiYSurWnZiB7rvpnNmpli46Z4Ybv7FPLULQOFYCcIRDfq0KXwRs9Rs9m+HNH041olSn+HSnBQcLUCuQBqrCNCKZs7p5+kpXWe1XcEIT5Q83IHvAuVWnNHhNiOvxpGJKSk4uUEQ0ybKsL8dBHOLFnEiWaEMicPOzVidEleJM0oWZ3jJ72M/8mY2aReQYOwzACaDb14kxQ+1Uu0NWw8tSwtnKK4GJklGw8ZZy5udbYGlO/FjnUDqLjWOzgwJfgHLBV+7E6DdytQVMTHde27MskokCxs4IA8+RBXvxOczTcB2mTUDUPPKMHQaPPjonxi3tcD1PqjlSVw5ixm013YY3EkRkLqg4IwADFE3Vz4XkHW6gugEFaTSdiY3AQiRVpaUvpZ0ffsNW+FsJlb+TMT0ibgG4kjZKRg4y9zmyQTh2D0Tt5XNnx9mArSiz0cfrmIayEH7Q5kIgu9ERlMTP4js2V9LHUaYsAdP+tg5X/4yKlLO3k8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mBEvfAHl6hRGY5pIGG3CKqeO2cuELomaoY/2qW6oSpOJ8F6QncQ5ShZUVozp?=
 =?us-ascii?Q?dZ8XMNsqaSBm21IBCaa5bRL6eEAPczfYs0HhBY9jqFuiIJ3RnPNmZwrgouM7?=
 =?us-ascii?Q?1R+bOpzOb/003RgIf7io6OoxA/Z2pQsrmAauJc6tWMrBdjEBiC2n8QTf88h9?=
 =?us-ascii?Q?PCsdslUHlSNpgMZTEFuZMfKalOQ6vvdCAxt3ZjClyy8JIHrRS3nvOt+CzN7m?=
 =?us-ascii?Q?ATn3pFzuyIFyQI3POy82vYT8ljqp+hKbK/NIwCx5s3+JVgOhg0B0mEWAo7TL?=
 =?us-ascii?Q?pd7/wIeHcCukj14iAkkaJv6V3suLrP++SMN7UPr7Q3mF+H5FstbnnMPPyT9s?=
 =?us-ascii?Q?M6cmT5TrvwLp3I/jv2gxQInfrUKtfl60M9Z5GBE4XC16X9UjKtXAmFzVZ45D?=
 =?us-ascii?Q?LBhQ+Th2DLOcjWNR3n0ooLCUdMvGauiEQWl4SHQbDgPACaxgg3X73oL0F4v4?=
 =?us-ascii?Q?chdiuk6Rwrkmu8qrxHC7PV4+LWLYXUbqvA0qQWmIaUFRGNWxCDdwsYNYJa9c?=
 =?us-ascii?Q?blZSNXNm9mKJfDFpV270nspKkhlhbaPaSD8jsz8WSAecgXHLQTjMwLoV9xUp?=
 =?us-ascii?Q?qxRPjKNQfAYEeUPyNfB7EOG+qiMnTV2JFjpmyGZywZmWPxjhBnaP+Eff26JB?=
 =?us-ascii?Q?QUKibPVpGIr/vtqjNcRc8Heb9iLNfKqqQY1/hscGlGQjKL0FCyfG1ZDRmTa6?=
 =?us-ascii?Q?Uwo8erDMIyNKsZT/rwMmViekyIExQ2jdJ/I9lXyhf001K1X3Crq4YldA2Q1t?=
 =?us-ascii?Q?c/m/RS1H02Glsfe3NLVICeuGenvyU+JLD0UyZbwbE2CvWk0CPjVVFByDKZIe?=
 =?us-ascii?Q?JwzuyA7GXw1gdG3A2PmUOcAF48fMQ27O+rVyjTPaxxmfjbqPGGVyC2WLiXiW?=
 =?us-ascii?Q?SwCc3rd1DyO9kg5kSU7exXFE/dfyLQozKNoPR7Njx9KPZ0V+m3zra75kYwzX?=
 =?us-ascii?Q?Sqqkqb13FRELCuAWDB021cEWvoRIzukNW07aqhTZvg36VWvoOl5rNpu03E19?=
 =?us-ascii?Q?gISG1TGqgTrffoDazrqyqJccUUnr+txzZDiDGXwcVTZ92tle+Wc3euTLyWp1?=
 =?us-ascii?Q?iFc1o1YwX31uuLQWDj01j4vEpsqR3FFLnApMDr6dzMjPE52dazeA9An4EAvr?=
 =?us-ascii?Q?2dLiHuYnlxhuFFwfX2+4eyYu2z+3eBwsz8LMnMIUoDl44EhwthzgFmE6pMlA?=
 =?us-ascii?Q?RtQxeaxcrlkFoSai99AxW+rXF1cAYzuFW6RpAf8cOK672EGU7TDOBrLad6m/?=
 =?us-ascii?Q?g/IXbZ5rCaxPWc8QG5EfiSh9GHOtFpdrYpWUMwU1pWdxLg8/xgpEgIhg4zi2?=
 =?us-ascii?Q?0LFgkgPH2vQzSeigM11zcwX1ghFdy/GeBpOcdVONlKz2lySGMfgcgnAdvaZ3?=
 =?us-ascii?Q?5ULLs2HZwDDM1ZpDXifRf6QfJk+5ZhmfP8sXn2AiYkvOB9vWhoeK8pvInjfQ?=
 =?us-ascii?Q?kWvElQcOIkXBDBpT9UEIfywu10vtH1nYC677XqghURqrqudggUzhTYuEyYMl?=
 =?us-ascii?Q?gXBXWLPmvHHqk16Rc0xzqYKLCx5Wx++DEpD2ZYJ+UZ4SnJcAYLXP3Va4DDCp?=
 =?us-ascii?Q?zAsbanogGCRMOm0X1jBdmue9jlHct+snD0EDEoNK40+3QWjeWK12ktVFz5XO?=
 =?us-ascii?Q?v630VodLabPF4ogTK53018Qj3QvffAgpSbpS8g7FHYP07yKTS+VOoEpLmwDr?=
 =?us-ascii?Q?SS+h1ru7wjXW9qfMtQjiA3R9T8lXZrCUynhryX/GD8VoIJcB8KlI/EQiCcO/?=
 =?us-ascii?Q?b3I9MhEvGilW2O8WDu+f+NeiPqgymP4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 977f379e-b419-4a63-fa0a-08de74c87bfc
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 23:49:15.6929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QxtCkp92qt2PTqqZwCWCdCPTlKWVl5uEQCHFOptkw7LHdUtyzIJlRlyghxwRj4aCdPLlC8XfExpalld8VDTj0UOVLsmqYNf/RKeYqqD9IBw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7712
X-OriginatorOrg: intel.com

On Wed, Feb 25, 2026 at 12:22:22PM +0000, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Region creation based on Type3 devices can be triggered from user space
> allowing memory combination through interleaving.
> 
> In preparation for kernel driven region creation, that is Type2 drivers
> triggering region creation backed with its advertised CXL memory, factor
> out a common helper from the user-sysfs region setup for interleave ways.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Tested-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/cxl/core/region.c | 41 +++++++++++++++++++++++++--------------
>  1 file changed, 26 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index cac33c99fe6a..3ef4ccf1c92b 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -485,22 +485,14 @@ static ssize_t interleave_ways_show(struct device *dev,
>  
>  static const struct attribute_group *get_cxl_region_target_group(void);
>  
> -static ssize_t interleave_ways_store(struct device *dev,
> -				     struct device_attribute *attr,
> -				     const char *buf, size_t len)
> +static int set_interleave_ways(struct cxl_region *cxlr, int val)
>  {
> -	struct cxl_region *cxlr = to_cxl_region(dev);
>  	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
>  	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
>  	struct cxl_region_params *p = &cxlr->params;
> -	unsigned int val, save;
> -	int rc;
> +	int save, rc;
>  	u8 iw;

Why the type differences? set_interleave_ways() takes an int while
the sysfs store path parses val as unsigned int via kstrtouint()?
How about keeping the helper argument type aligned with the sysfs
parse type (and/or p->interleave_ways type)?

Even if todays sysfs path won't pass negative, the helper is
being positioned for non sysfs callers IIUC.

Similar question with 'save'? Should it match type of
p->interleave_ways?


>  
> -	rc = kstrtouint(buf, 0, &val);
> -	if (rc)
> -		return rc;
> -
>  	rc = ways_to_eiw(val, &iw);
>  	if (rc)
>  		return rc;
> @@ -515,9 +507,7 @@ static ssize_t interleave_ways_store(struct device *dev,
>  		return -EINVAL;
>  	}
>  
> -	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
> -	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
> -		return rc;
> +	lockdep_assert_held_write(&cxl_rwsem.region);
>  
>  	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE)
>  		return -EBUSY;
> @@ -525,10 +515,31 @@ static ssize_t interleave_ways_store(struct device *dev,
>  	save = p->interleave_ways;
>  	p->interleave_ways = val;
>  	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
> -	if (rc) {
> +	if (rc)
>  		p->interleave_ways = save;
> +
> +	return rc;
> +}
> +
> +static ssize_t interleave_ways_store(struct device *dev,
> +				     struct device_attribute *attr,
> +				     const char *buf, size_t len)
> +{
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +	unsigned int val;
> +	int rc;
> +
> +	rc = kstrtouint(buf, 0, &val);
> +	if (rc)
> +		return rc;
> +
> +	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
> +	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
> +		return rc;
> +
> +	rc = set_interleave_ways(cxlr, val);
> +	if (rc)
>  		return rc;
> -	}
>  
>  	return len;
>  }
> -- 
> 2.34.1
> 
> 
