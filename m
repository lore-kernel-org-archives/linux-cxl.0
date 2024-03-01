Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D01C24B23
	for <linux-cxl@vger.kernel.org>; Fri,  1 Mar 2024 19:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709321700; cv=fail; b=bOr3OM4W9oDP3a23ASNLbysyEuaya+AUilJ11+Mx6KxeQQU/lxaaFq2oz2FvVQE5HnSxwoPXTWDohZqjrB7AyM9xE23Eh5vPEv5X47JkksAbR/OGUC3vbqxr328AIX47v2CW8t0UTuqFfheIqsgFzmyQbs51OMUmhSRwnKPgtuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709321700; c=relaxed/simple;
	bh=Ogn1V35WVw89agSuhYQn/9APdeOw3nIDIeBRZQKHkZM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=k+w+CjTMll9rN9djveu6vaUHrbvvUNyPTYFuDLYF00VDvIX3szHTcIrAYnyKk2ZPXA6mUuxrmYYq4fF7FINt3YPTgCMEJZtfi4IrL0Jbs/yujerckojtx9ZelS48Yg31qHb1+jFea2MxnGHhFV2pj3FZ8hbjbJfwKwr5XNygGbQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dsDCu5jD; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dsDCu5jD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709321699; x=1740857699;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ogn1V35WVw89agSuhYQn/9APdeOw3nIDIeBRZQKHkZM=;
  b=dsDCu5jD//lIXrp9FKtMOQScBjpJVy211z23MgHCM5Xd76+mI5OQm5Tq
   0Lv62pmyPEa8RWN9/YIl4F6lH4ySZcV+aphoYvR1f6tO6w6H8WeO9xEaM
   qEf7LSsVQGBqkYgxjxCsorDwL0bwOX5hdXYJmxgS2f/5mDs9UczvqFCiI
   MlMv3wiioBTHZ/qrIS2QU9XHNfTLneqThQWILsNdg6HBuUhUPN/R+tmDt
   uZJlEKq08S0UFeQ0p5OF8f3mCBcDvlqWRw0v5ChtI11jDIVMpNWwYnLZ6
   9a589f6ZYl8VMrx8COGSgKFjy8A8aIODzRtre3rcd5L6S6Huih1ViPFGJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="4000522"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="4000522"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 11:34:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="12954033"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 01 Mar 2024 11:34:58 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 11:34:57 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 1 Mar 2024 11:34:57 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 1 Mar 2024 11:34:57 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 11:34:56 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mnm9m9MLa9tWzGg1YReM0dxWZBGfYA2wZ2KG4VMtEUZSqp50rOV2zXYUjOblDL+id/VqU8q6hrS9ZUYAhw8LLf7LW9WOu/0531TOpm70vPl8Orpe/XFWcsLU6XaWSWzqGKztzJwZO1aUMWzmbvkSf+ADcKNpzqTpDrExpGAIuqAN03uwbvMsDqDeJi/YpqN7pGc9/VlQBCpUSMSS3bcvcfHn9sYUZyEUBLE6mWK2P973cSwMr31oqwzGSxK2EAtnKsq0ZygMHCH1HCw89pLBzB4A7Z2uJLOISVDURMUG5YsFZvfr/einUiWseBK874iZh1ezXtn0dFrCBGvoziHqsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qsBjcr3PoEpSnS+8DAa988iSN84VGh+clLE216BQDRs=;
 b=TfbFK6sFLrGrwFMrRz/sCL2wahouSJj89zDJYvcsQKK2K/1wRPHn1XwPi9xDWqijGbZUW6XGqss2pyXVO8RTEWbsx6KIEj+UZ3KjoCHb6NOorD1A8iiYYZCqq6wDc/5V+xQHM8vLyN8tyymklR/qwMyKEIksZX4bHcB1SxTsXSrxjtDBB5rldmm2yEeiXnffqgz4pozuV/9xFghBggkiv9+M/vziIg7C6whJkQRm9vPcRuKEhhmAugw4PBBwuUq81LFFIPWkqBYQ0HOUOC7j3aga7MkfjWRfwXerFKW16h73PUa0tWShIAGnO4zyAYiCmHuK19jCn4C9jDm4bZMuZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5806.namprd11.prod.outlook.com (2603:10b6:510:14b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.18; Fri, 1 Mar
 2024 19:34:55 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7339.019; Fri, 1 Mar 2024
 19:34:55 +0000
Date: Fri, 1 Mar 2024 11:34:52 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Alison Schofield <alison.schofield@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2] cxl/acpi: Cleanup __cxl_parse_cfmws()
Message-ID: <65e22ddcab471_2bce9294e2@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <170915213220.2419769.6117155173006983208.stgit@dwillia2-xfh.jf.intel.com>
 <ZeIekICjXpqVUrUG@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZeIekICjXpqVUrUG@aschofie-mobl2>
X-ClientProxiedBy: MW2PR16CA0027.namprd16.prod.outlook.com (2603:10b6:907::40)
 To PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5806:EE_
X-MS-Office365-Filtering-Correlation-Id: b6f6f5d8-207a-4ba6-0851-08dc3a26abfc
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +T9d4+5vrK69Dp63uoa8ABrkPDbgb472wfkgmxrIm+KFvdhHEaiuQQeDTr7C13IM81J0R3/n2waN/wjpkNywC7af9FMr6Gj5RCUh+9UVnFMzwcVSIAYLCxeaDb5r4FJGa8T+MWlYZq8jWZIEBILuxVxDc6MunN22l/v5vxZFFLWFM5qa1uuLgyBeOI8Vt+vp3BKa0/Zde8b28F4sRP03TgFfr6BqVfgQmHw7DOIxWtob4NUaYdlzpoWvC5tmeYAs5E8MtyoYfRA23gBbmkLuGSQJWWYOAxg7gg2NEIdMWbRg4BDtb6+48q8q9lQ6eCeLzf4LSQagttvAgdcQtL512eoevSbGXsprsu4lCjOgX+X3QzRbzCkWmIuUi1WNMOKrbYTDvAgnI3lpkzPQhzF6BlMFvlGX4efSevQvo6/FcnrLAVXb17vatIzTP6I+4jdLm6nAM++im0RroHBNVhVvopitt5EfR4zXY31LyoNbrZ8jqbhnr6B0xluLobo/ANgQ3naX12aneVEDh9y5W6JYwTvVb3YWWuo3djaaTg3QrkBZaIzE+LUlFQbOrK7TeM+BxyBMX4/eWKplDsCG8yXfNFUOTNP1PW/0OP/SeEdzH6OSaXI/NHqnLUQFnI/K6rb5olMwKNyytoIZkjNrZeFSjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bowCuxj29+xAnls1IG2lQzeC2b9aMmKSpb1kzgRQ1wlHumKgJoft2QdeEWEI?=
 =?us-ascii?Q?Fdbtjpmn6EWeDEKn6sWVlvKK6cggAywfaXCo5r4+240rGnIrX7G9RGV+PJxF?=
 =?us-ascii?Q?o8r7XT7p1+MPw/AZJ89a0gbrEXM3KmKNfdylat26zZqJrfUO2lctucot64yR?=
 =?us-ascii?Q?7WXPqQrp+1gIB7CxWU7snGxJRUDmZIKZCbdjBWTaa2fVgxWS2+51XMYqtZwm?=
 =?us-ascii?Q?+gKoFcZZQMaH7GHRoiAnH/xCYVxfbz8m1NiGMN8sBOBnen0SvC35NDhQQrak?=
 =?us-ascii?Q?laZOboPchIaaiViFneY4pbb7K8sew91gB4/ffWeiCL3xw/TPeDa7o7mHLpzj?=
 =?us-ascii?Q?MNJdDFmJj9+R/4YsT41HVBeUeyIQBnSZZJcyVGzbTY1nJ8PKSNYVrmZ/5lvH?=
 =?us-ascii?Q?bH1cGXDtM1BgVP8qRVAPxeHw8DCQ7b8HpI8TOfL8Xoqv+XJ/2BJZqfn76dWB?=
 =?us-ascii?Q?x/li8B+zZkO25muwWqGeqMKY2qyxjFwDuwLrziRRgK2o47lHKSCzYy/C2YHY?=
 =?us-ascii?Q?VZMqRHbzIhU7Gcaj4pf1zabBTI9SmmNHO6z+jsDebEKD2HL9q7cAl2AJbktW?=
 =?us-ascii?Q?UvuLyg9aY3g/LDrPF8V3F19y7iuIQJWF0OPfLx6kOcdRdEBoeefYXg2ZADSp?=
 =?us-ascii?Q?DnS3/ecc0+PKX54YxqNbGx0pfzGgH7/3lvTyXnwjcqeqWUcwVOBWZtDHB+xt?=
 =?us-ascii?Q?Ckx4KY3rnLi2dqLaerBn0XbsenEsWFy1riGnO4kGdeWU1QZjBhqEzDc3aTuO?=
 =?us-ascii?Q?qAnzXW7uXMuaNCxgdEz9OuOg1F/6CVAk18B27bLfwAFa4lIoC1EKV7KOmkbp?=
 =?us-ascii?Q?piowb244oTedqC83PEgL7LAFfTkolK7Ro0o28I7fdD9qoexshDFJG9+U2OSG?=
 =?us-ascii?Q?ig3y9CXuifJbcnwFtDH6QnhG1v2u8FwyRrzlwK9SL2jp2VL4pP8tu8/SoWte?=
 =?us-ascii?Q?TSzbQgKRBJ0jR98VIm7bVqNGGh91ahg9jGIPE9SZMTa4+CLJuQZcEGKUbT45?=
 =?us-ascii?Q?+hsHJ0Tt6C/Xh/gF2xR6WWD6ZsoQ+eabvnlkbWV6DQNvzZ/wD66Mwq5eXE/1?=
 =?us-ascii?Q?3Mqz39PFGlpec+j1gBn9Hh9TyzsFzenKy5/YVgm1ar00M60fSNCMvaf3jdRF?=
 =?us-ascii?Q?TvxU5qRiSiceKnJfSUV3IvLEdVSGUoa2CfsG+WHBWYbOuPcvxSai0tyyngN2?=
 =?us-ascii?Q?CzzqS5SrCuDzbQDAfNfQBN46K3TIYNKFa0ozsLr2TKnoDE5Nzo2xgtpk2eZP?=
 =?us-ascii?Q?2JRSLyFXkLha1miSuPNIL57znnRzJkk9PSfphGEpm5hsNC8tAdc2am9peIPr?=
 =?us-ascii?Q?+H9sinz4C/xXlZisRNx5c0IfHe3Pvq9/CS8BqcuLTg6GbxQan1hi62ElDT1V?=
 =?us-ascii?Q?z1lRnUxgs7t6l/9WGiV9l7y/4YOGYloj6A9o6eYOneHUnOa3lMlR59dl56ry?=
 =?us-ascii?Q?uJQ8EDCE0TBAfAfKHT10RvDjz0kbjGKGG3IFzPCVaeYGLSRbCvKBPB+uMOBK?=
 =?us-ascii?Q?xEHxey7LEAtS5rpo9VFrL7ppwcBQw2erVfbApJC0Bg7ho4n0H1u1Ji4oZvqq?=
 =?us-ascii?Q?tosPIQCao03awsyz6bKeKWTta1NGHKO1txgEbEEaVauuZ2UHzT5NKoAzUjub?=
 =?us-ascii?Q?EA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f6f5d8-207a-4ba6-0851-08dc3a26abfc
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 19:34:55.0151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0U5/jro9GVn3s2ntfRjQbmIMV1j+mpbCd1nc6MB2VX25S/Tv0Lu3pgKt7KMYCRhdMxt5S/Uf5DkxGLC7l8Xz7vIJnh8sniHEwD9MCq1GPAU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5806
X-OriginatorOrg: intel.com

Alison Schofield wrote:
> On Wed, Feb 28, 2024 at 12:30:56PM -0800, Dan Williams wrote:
> > As a follow on to the recent rework of __cxl_parse_cfmws() to always
> > return errors [1], use cleanup.h helpers to remove goto and other cleanups
> > now that logging is moved to the cxl_parse_cfmws() wrapper.
> 
> one question about helper below...
> 
> 
> >
> snip
> 
> > +static struct resource *alloc_cxl_resource(resource_size_t base,
> > +					   resource_size_t n, const char *fmt,
> > +					   ...)
> > +{
> > +	va_list ap;
> > +
> > +	struct resource *res __free(kfree) = kzalloc(sizeof(*res), GFP_KERNEL);
> > +	if (!res)
> > +		return NULL;
> > +
> > +	res->start = base;
> > +	res->end = base + n - 1;
> > +	res->flags = IORESOURCE_MEM;
> > +
> > +	va_start(ap, fmt);
> > +	res->name = kvasprintf(GFP_KERNEL, fmt, ap);
> > +	va_end(ap);
> 
> Why is alloc_cxl_resource() defined w variable params and using
> kvasprintf(), rather than tailored to the one caller and used
> kasprintf()?
> 
> Perhaps you have bigger plans for this helper?

Good point, thanks! I think this function can just take the window id for now.

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 1a47207932e2..db38ead0353a 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -325,25 +325,20 @@ static void del_cxl_resource(struct resource *res)
 }
 
 static struct resource *alloc_cxl_resource(resource_size_t base,
-                                          resource_size_t n, const char *fmt,
-                                          ...)
+                                          resource_size_t n, int id)
 {
-       va_list ap;
-
        struct resource *res __free(kfree) = kzalloc(sizeof(*res), GFP_KERNEL);
+
        if (!res)
                return NULL;
 
        res->start = base;
        res->end = base + n - 1;
        res->flags = IORESOURCE_MEM;
-
-       va_start(ap, fmt);
-       res->name = kvasprintf(GFP_KERNEL, fmt, ap);
-       va_end(ap);
-
+       res->name = kasprintf(GFP_KERNEL, "CXL Window %d", id);
        if (!res->name)
                return NULL;
+
        return no_free_ptr(res);
 }
 
@@ -384,9 +379,8 @@ static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
        for (i = 0; i < ways; i++)
                target_map[i] = cfmws->interleave_targets[i];
 
-       struct resource *res __free(del_cxl_resource) =
-               alloc_cxl_resource(cfmws->base_hpa, cfmws->window_size,
-                                  "CXL Window %d", ctx->id++);
+       struct resource *res __free(del_cxl_resource) = alloc_cxl_resource(
+               cfmws->base_hpa, cfmws->window_size, ctx->id++);
        if (!res)
                return -ENOMEM;
 
