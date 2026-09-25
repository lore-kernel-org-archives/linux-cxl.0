Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20212EEC0
	for <linux-cxl@vger.kernel.org>; Fri, 25 Sep 2026 00:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790296267; cv=fail; b=RPTkuYaksm789FiV7hgGcqa6mTfnwGpqIW4gYi68bxBqqtjNvJ4PHN8bOi3rV24z9C/oCeyaXnxGqXfWgn1I0I8YZIFAmF+PxjY0y2fmJSFV1v6YJ3k3GN8XM22gy90hHNF+cWBqySE6223uEfx1QD9vvMQ2ewCEFHF0TduIcRs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790296267; c=relaxed/simple;
	bh=Y7pVHFRI0O5GIGFGWcXEQ2gMSIIsHm/pXtUfSvYVmM8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ue01g195XamxtupazI0hgFEkCUUVQrCt447fgGOOvLl3NMY6yDUfYMdssYTWACY2wqVcuH0RMItE8g7wPV4TVMUhjrnZhgWrZgfXnJuCx8tEcGlfmjkOVVF800qCmc1eyTfwqTy4sSKz/DMbbN2fkKEMWlPnvqoebDXYQzHkbf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lZGgYuAR; arc=fail smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lZGgYuAR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790296265; x=1821832265;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Y7pVHFRI0O5GIGFGWcXEQ2gMSIIsHm/pXtUfSvYVmM8=;
  b=lZGgYuARfsTbJDCTdW8ofsV4U8UYb54AlzDPseyO3B24jeApgD++HGji
   NG962v9PWBxQN979sbvp0WgBZevs19YN+StIgI4b9SsWHfFVi4qK9u5SY
   VjHGru3yPZcw/ARu0QY9LqqOLPM7p4J30iWt60w9Ge0bYboIVYazvgSJG
   WHMNUFlTUBZT/nnKCClpld0ec05T45bR0A29GiOtsqxxUblMTXyov+/4e
   zMIM5vB5xXAAfDgViLvan2uEylFQtwFMLM5wJOAIlj4mX2mis8zp24yvb
   RRsnEwZCSMWW+2mGyAhFW5DtjLlngm02V1aLHqW0ntmQ9ibpay1AWaULp
   Q==;
X-CSE-ConnectionGUID: atrjY7IBRvO018Hd1S0OJg==
X-CSE-MsgGUID: 4eyd4sFSRT2LN+aL4pcMsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="90948586"
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; 
   d="scan'208";a="90948586"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 17:31:05 -0700
X-CSE-ConnectionGUID: 1TO2O7B6ThOxO0YyQ4Ktnw==
X-CSE-MsgGUID: uLbOkCfLQMeiSsdFR9pSFg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,121,1787036400"; 
   d="scan'208";a="273677749"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 17:31:04 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 17:31:03 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 24 Sep 2026 17:31:03 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.12) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 24 Sep 2026 17:31:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1JMa3ckCSRWQTroGI5wZ3oT7nrN6B29JJmvsHVN/z4RT3w9tJ5p3unysNtnHzx3nkyFfmo+PxIIewQ30mc8QJpjyAQ+f8/NFcz+g9tQ2fv2+VZ2ZrylR7OmLTSoJCmgdHImZRMdLbiQ01fAbtuD5sFwXO26oQtWRZZAlRgUusdxmmljkRti/0VFFp59mcxt8ekxypDYPm+QyVkYsdxsYa6bCW7jKmQf0E/rm8H+AqHzYIoVAazBL8/G/wHGp4NWmTwr1AiPnL2w6GTMNJ0KsobRL8kziKceevhX67GVmSkCnKEBe61xDlYcI+9YC0mQpUvLkTbtdKTQLZNfqFf8iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fKYm2HLmggpcGwRXSownIpPLsbZp1jMZezk8usepOIg=;
 b=Ko7/nnYfKrASU/fKJjOWIReqMzaG+4t6S4kx/JY/cQ9TmPEt2edaKE7LQRgIs1NnXuYwZ/IRBYSJ3Mm4LNzKOfRIE/gG0pIvap2acCMe3UEocGrqu/Fsp0USAcn9WAbmJPKiflIYRd9UR28B77N4I0opyDNj966F+shs3nNYUI6iZlTNqlOGvvqkkmosjF+bP4nAbs31PGll9KMNnT+0Gk2byweaaijrfZeHSpVjEiScjqX9jSV/8cpMoOjZacs8TP8u6cPj5fmgP1fJ8vdnL7LCUMpVT065xjtqRTuIBZTwV4rhUN17gHaAgYNcwbxaL7EBr+BWYb27dhymVRr8qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA0PR11MB4733.namprd11.prod.outlook.com (2603:10b6:806:9a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.22; Fri, 25 Sep
 2026 00:31:00 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::6fbf:c112:d0a8:f1a8%5]) with mapi id 15.21.0451.014; Fri, 25 Sep 2026
 00:31:00 +0000
Date: Thu, 24 Sep 2026 17:30:56 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, "Li
 Ming" <ming.li@zohomail.com>, Robert Richter <rrichter@amd.com>,
	<linux-cxl@vger.kernel.org>, Jonathan Cameron
	<jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v5 2/7] cxl/region: Warn on user region position mismatch
Message-ID: <arXAwONM33mmNA3o@aschofie-mobl2.lan>
References: <cover.1788475206.git.alison.schofield@intel.com>
 <1d662e3ea78ec8b05fceb500f04e69ee9f6d4a72.1788475206.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1d662e3ea78ec8b05fceb500f04e69ee9f6d4a72.1788475206.git.alison.schofield@intel.com>
X-ClientProxiedBy: BY3PR04CA0014.namprd04.prod.outlook.com
 (2603:10b6:a03:217::19) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA0PR11MB4733:EE_
X-MS-Office365-Filtering-Correlation-Id: c732f644-7f33-471c-4cf2-08df1a9c45c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|4143699003|56012099006|10067099003|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: CuBYgcDhyqSdaU/xFlBsWgIYaI8OCCl81kyi1nPNda+ROFBlz3efHz699K0KeuRTbeQ/EOnR8icmTbtAzuVzuRjC4pPnqK+LDB8fn9YktO0RauUAKCNOVvLyzZ0CmDKH/Rwru1Tp1dUazTcFqkzz7iUA6oAJPD76yBxPCZnVDGbPpe8YsSQNVOlIsmWntaiYiDjIZ5KXmWkRui9mQSIfno+QDfAYl1K9BgJJI0OnI+5pgR1JlvqLXNq4rzjrKtk8c7TGvsVbaQzVNSDk5xP/S2VqqHfcqWxmd8F8hE9oWGj1Y4D4aScjwxT+Err2ujJPQcwD4v5PHlCr8i3FUA1ZMWhGDw6NV5fJ/T/PMprCp1WyN59XBvj+lvMFrGY5JMwziHDxhAq+Zhwfw/pnTBL6r3YD1oXsFpxWR2eYmhOLwvY187lCrMoKbktUU6S+ntJu16wpcoKLKCWDfysQzSEAA0itJZ+I12LqCp62Q6rWcxLsDkZU5CZCn3D3SCkbogaDK31C4j5+y3d8gHa07CRQJFJ1P3tjeq3Z2Nc2Dp+Ix2n07MjSbsdrTJ1eZhMGeuXlmkyeIyRPD9Nd0pm91t4XfMfyQnetn+XQZb8ggra7y/NAmxdKhjwv0+4UyD15AWUEnULHB1SdGpfhEZyozdFZGR+ga4DVelZMEJlz9D8sQxI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(4143699003)(56012099006)(10067099003)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UIFppYn3MFU8CjHTiTz+a4Awtf4ctOAW+CnfJo7bKlLZqJVxjvSqqaZ2HJqY?=
 =?us-ascii?Q?R3hJPZR4GhhCznEg1dtRiz9H2vZ6YHct/b39KKrlmto2/cCSAE41g5KVQNCs?=
 =?us-ascii?Q?BOBf88+7j4+XDYnkCXFskE5lWngOLx2nLEoSV5keobR7H3H3Nh7wxYtfVOCy?=
 =?us-ascii?Q?YXwN6vGcwoN2fQVFIaDMA3TX1I3QmN8VpJivq0jWnPcYRH22PPKkN5l0BSsv?=
 =?us-ascii?Q?H6UqlVYf1gH9fI2WVEXY9shgXIOCMekRQFEBd60ME0pLTLwxcWgSGQGrv+Oi?=
 =?us-ascii?Q?gUlvP8uf9Y2LCZ165w1SRRljHCmDKEzD4dUko3vOoVWkb7jgl7YSl8uGjdXk?=
 =?us-ascii?Q?1nM4cAh+9QZl0YtnVOkf0wD7dSgDrN0Bc88cUWWW6q82SoKm7v98ryro3UOc?=
 =?us-ascii?Q?MAU13Ij+w/l22eBYWDKO0AnhWP9N/5b9vN3CkOlA3TXDT5vGfky1mceWrdfB?=
 =?us-ascii?Q?gQjyrVfGdpiLoQWzR0dDoTgsmW8fS0vuD+DEU9DfqylJCdChCtriLX0UXM/A?=
 =?us-ascii?Q?kaKLMwkEhUcYwbvjRLL6gHsTcAxhnN/FS6E0p1f8A7ITPPloPoSj/r37iUOI?=
 =?us-ascii?Q?BHqHNby/e47DKpu5CFAnW4fSBslJRyoVINpCuidk/nCoxMKZGG1UCs22nH+B?=
 =?us-ascii?Q?2aq4E/O6wZGUMUUBz4Ld8ybpyooyX7Lh5V5xbVia0UM4Z4ihQ7oSr4V+0PLj?=
 =?us-ascii?Q?j6H6gku+wtyFMVJumA7EAwNeCmZ+Md/dAbewRzBh3dw/jKsYZReEoNTmCMYq?=
 =?us-ascii?Q?v7XOKRohnV6NGPh9H7mT1jIXG/3/HKHqSVJ8b8nR80DsXvwY29dSXG0D9eIo?=
 =?us-ascii?Q?/GHVQdkDbUuUvTq9RegEji2L4sqBTwCs1j9X3vA0b8/cP74hyXc5OhscZIme?=
 =?us-ascii?Q?yXn3rI6kw/v2FBjD3yKRajy9mW/D6inEke481r+P27AJZTgt2oSmwhdvyg2q?=
 =?us-ascii?Q?kZigKdhr2hXWd3It02qtCHAAW3uP5LJktC5QHGwdnhvCvQ8aGzjHjT3AvLWo?=
 =?us-ascii?Q?YKTAEUhzkP1FmeWz6P+asPeK9LQYhQJLdIGKJvKQAmwqwYbgSzB5K4/YKt9E?=
 =?us-ascii?Q?i0iS8xvjMBaQnYp820gZmTL/GxeIiv/MA4YFV6nVLB1nNiv4paXHyeNprcpw?=
 =?us-ascii?Q?EpYdtsiMpJMwsryFuij1y0UZXRDDaQ2IDDma6/rHtEillQfYVJXYve5qXRBq?=
 =?us-ascii?Q?j9XuUBVg51ejZZnFhUBT5B4nZ+bQHu9vBY6dK8toOcFZQ0+UJVO8eRIxizDS?=
 =?us-ascii?Q?teNeiY/emEC0h877RI7Zqd49NJJCb8q/IwB8vncr+Ur9n8u3jOMfC6T2RKHk?=
 =?us-ascii?Q?JAwUJ378d0oUs7HFcYckUyfVtGUuOLyms+o584PxfGpkd8lCWHIbUfoTRWve?=
 =?us-ascii?Q?pOZPUxvb3dOVZlrArDsXiudtV4UAayuHrW/tkxgTgZKeMUo1P9Yc05h/n07a?=
 =?us-ascii?Q?lmwXHqrtKaFz6As4JvNNrUqjIce7zCUOvGc0r53D+aQaPmkzqJSNLsaaS9UV?=
 =?us-ascii?Q?pY7NOhXHJvbtfVh4BsABNWSDyTqBP+KSqO++ITeLltFt4rlfLDMb5kyjTsuD?=
 =?us-ascii?Q?nS5qwZ+F/DaE9rr37qUXEjoX3VPXc+zoMET0glhEQPQgkac8w7dvefY3Rt1C?=
 =?us-ascii?Q?gG1l7/Xs4hb/Iwqir6YMjWXWNCutFdRDCgTDKhmHYC5UVyDMnf1iLOv1xPoY?=
 =?us-ascii?Q?dbTTSy2NO/OqkqlGyMJmGY05cDXoIX3JSDTheZIsIKEiXWSkN3Iq41p+mpQE?=
 =?us-ascii?Q?46VOhMpWsNBIyZjWZTsJ9PIkVie1z2c=3D?=
X-Exchange-RoutingPolicyChecked: RywT4jqvphB1L0NpqJO3oOY4MryC6GJgYfeyUPKihgiF7s+Yhvhp89zxov2ei0qlulxtcmw9qN3/MdbzcKE75J+xAHMkHfWFsYgLQ2do7Exf5PjZyRv2uDyCqcRLEvfzlfQeYhPIi18fDXcrBNJmExfZDwuFOrSTgKC9xhvcGC602VJjbzE9qL8o1xcCzL+eto4Al4RIO3lHcRwztWEzr/tZtQXXwaIpSNr1o3yu+cPgsGVX7cFCu0IWJ6L7Cf1LbnR6C85RCVhm3kkxb/9Tdv+oYS91LUFL1IDeCTWxqi1VbZVJxbRXWTGRALmsayv14NgODnBz/I9DDl/L73naeg==
X-MS-Exchange-CrossTenant-Network-Message-Id: c732f644-7f33-471c-4cf2-08df1a9c45c8
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2026 00:31:00.0866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SMFa+xbNRw2y3b2Qg47q4VIhJ/CjL5b6s1ggL1/OKQpZAbCo95CSa2qYz0A3hhPBOkIV5imBGrqXY1UTl3lNdgeII6/Ph1AVh3dFwEv5iQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4733
X-OriginatorOrg: intel.com

On Thu, Sep 03, 2026 at 04:23:44PM -0700, Alison Schofield wrote:
> User region creation includes a self-test that checks the assigned endpoint
> positions against the position calculation used by auto region creation.
> The result, matching or not, is reported with dev_dbg().
> 
> Promote that to a dev_warn() that fires only on a mismatch, so bugs in the
> auto region position calculation are easier to catch as that calculation is
> extended to support more region configurations.
> 
> The matching case no longer prints, so dynamic debug on region.c no longer
> confirms that the self-test ran.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

DaveJ,

RobertR also tagged this one.

I'm requesting you merge this ahead of the rest of the series.

It is independent of the rest of this work, and landing it sooner
helps me with a unit test that wants that message to always be present.

Thanks for taking a look!

-- Alison


> ---
>  drivers/cxl/core/region.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 27e63e6dab7c..6a698f36aa6d 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2215,10 +2215,11 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		int test_pos;
>  
>  		test_pos = cxl_calc_interleave_pos(target, &cxlr->hpa_range);
> -		dev_dbg(&target->cxld.dev,
> -			"Test cxl_calc_interleave_pos(): %s test_pos:%d target->pos:%d\n",
> -			(test_pos == target->pos) ? "success" : "fail",
> -			test_pos, target->pos);
> +		if (test_pos != target->pos)
> +			dev_warn(&cxlr->dev,
> +				 "%s: position mismatch: calculated:%d assigned:%d\n",
> +				 dev_name(&target->cxld.dev), test_pos,
> +				 target->pos);
>  	}
>  
>  	return 0;
> -- 
> 2.37.3
> 
