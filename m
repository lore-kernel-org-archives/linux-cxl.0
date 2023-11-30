Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DmwLN6vy"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB0D10A
	for <linux-cxl@vger.kernel.org>; Wed, 29 Nov 2023 17:22:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701307328; x=1732843328;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0JebKowRRxYjeO3IW43TX3AACEIMAQUDNsDO/ep4aVM=;
  b=DmwLN6vyEFdSdbQTLd+nA1lr+fv55MlYWbmhP7QjrRCTq8UJw4dviUDq
   dNBpfk5ija44v18H1FFnED/Gb6/Y/C74k7cOVkzU4wwVyUtmQ4kax4XOm
   LntanfPRYrhJPrUYn/sJVMcQ2okOLWin4qzZ3S1r/CIQaUBFkgQQb8LYz
   C8ZcoGQlWmua6YK1XsL2ulJdfDzKqvKXI9uKJghoBeUdxIrJzDDJEqK3k
   NhH924+9KR6R12ssSRWddhX8jpyxy6HgPsbsRzTP49GOvKjHwOts2j6bG
   ubz70gi/HIXd4GSYMA1oIHvfubAkD+YtSG36RATfCbUXW+06nbBzdoXvx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="6465225"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="6465225"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 17:22:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="803472390"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="803472390"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Nov 2023 17:22:07 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 29 Nov 2023 17:22:06 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 29 Nov 2023 17:22:06 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 29 Nov 2023 17:22:06 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 29 Nov 2023 17:22:04 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mHEZQr4YKsRgNWLnlIL0Q6Lsvw9loOtv5mWlySAha67kkamODp+7smuCsi4agNX2slorAcZTHywYpdr/xy82RCtT/fbsj8UcPkGx0709Nk2+b4i+t51ABM3KFL5eTIyXEIrP7LTpJzhX5BRzFnFrlUtwlZ3xnbNXU77SKh1DJGQ8Je+pULMK0YHPghOzKopCBtmfv4G59XBzdxOxdbxGUvhBrWiH3AmQEZ7MXLW0xvhFQn4/erAvBBSflQBQ7cflohk4Spn/urw+WuDijOvVLMIgM3nqrkJSy5KlEYMx4h1IAu1VnwneAJlW89GM0ZsBpqq4iNuy/2q5bsti790lXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lot7HBQnyvua+8Zu9J/7Am0ZYZPD1ZKiVEM7GzY+P30=;
 b=e1wGPTegbdEUaUDypDVDYbQvFUxFU00BgSiuRPSRAGjzWWLg82CLhnIN76mY6bxG5qFadrJDa5Gl7R61P/xWAGGCwbJLjCixum/CuHavoSdS/p2XZaywBJV6obntCQpxgtWnNoP6bfFWCRGWhBJnWuCTGi/jiXrY4S5zpcWErs8UBiFF+esQki0pxUS2NkDutISq5h9yC6BVXZOQVFGjWP0UlVD/pYsUBBHbioN80RcYmXZejf0Yy9g8wU07kjycWHN9jVVZJQazJfKDjgm2+pidxV8ApTAV9a5bNvtBx1/JaYuDnF44EVh6IcCDWzcB2KEeZYDCNBl/iNyJsO5kHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB5280.namprd11.prod.outlook.com (2603:10b6:5:38b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Thu, 30 Nov
 2023 01:22:02 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7046.023; Thu, 30 Nov 2023
 01:22:02 +0000
Date: Wed, 29 Nov 2023 17:21:59 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH 1/2] cxl/core: Always hold region_rwsem while reading
 poison lists
Message-ID: <6567e3b7b3f06_c3ae294a7@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1701041440.git.alison.schofield@intel.com>
 <08e8e7ec9a3413b91d51de39e385653494b1eed0.1701041440.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <08e8e7ec9a3413b91d51de39e385653494b1eed0.1701041440.git.alison.schofield@intel.com>
X-ClientProxiedBy: MW4PR04CA0341.namprd04.prod.outlook.com
 (2603:10b6:303:8a::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB5280:EE_
X-MS-Office365-Filtering-Correlation-Id: 71a5fbce-ffd7-4cac-f1d4-08dbf142c16a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: q06/Q8m+hsQX9keUAkc5wWxOuN3Xm3KTmR+lnA74lThfRjedIRupdOQNoSZ8R3/Pcz62qf7h2RsKUZvu994QLlYgqJnuNXyRVqDSiYlHNQl29sznw3pvPYRvIofnbxC1lMK+NYGyN3viuH5yQv9leDNemDVZZlja1LElzNNZeDqMIerzFkX+RGY5kHZJ2JJ8K0Jgp/uddLkkMMHxKcxS2ZgITcHFD7MSg1OIezNTQeUYTkJcQBU/PabPLFtr4rRlbpNKfU89pS9mrvTRjHmJkzyzcBgizaEcwiGQPyJuDhl2LYD8asbRzr50av/PWrquP4aHS/ZG7BCU8IaDKjGqXwWdlLi950cg083sJZXyJYJvkpuml9pskcYQ6cqme5BKJ5Zpunp+iGFPaNr/2ruHHIV7jfuwx7iTxnPOd376sQRsdIPIGqqE+PkKvvynJzUsB6OR4eoj4GQ2DjrZEIDX+I9jASkslbyYb0MVR9C/WMYiCDjEBR3YnIi99kaPyo6xKLbYFneSHCZX/kJIcjdFRq5Z0uEt08n27XLPimoPXTMkzWukQOZAHO15tb/l3n2yGAcdHfhSPN7EA0jt1vWoh2ypran8ksMQaeTQd6goyvfJPj9h3t02/v1B+9gKGxMf
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(366004)(346002)(376002)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(5660300002)(478600001)(9686003)(6512007)(6486002)(26005)(41300700001)(6506007)(82960400001)(38100700002)(83380400001)(86362001)(2906002)(202311291699003)(6666004)(66946007)(110136005)(316002)(66476007)(66556008)(4326008)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HcAwnXtQoj7aRHzJrc0lHtuIGQgnRf5xUftySCyodfsknfBdhp2LS+isJ1Oz?=
 =?us-ascii?Q?K+IsEQloxgB5mmLtzQ2sdkGFBazTvrwacVF0yojjmCf+cLYJZNDzxsFyZhO7?=
 =?us-ascii?Q?xdyddeq8/CU7ghyglGPCa3G3QRc0481nBrvi/nGZui1clXD75Y5KSft/A599?=
 =?us-ascii?Q?EMICaSI28bNFh0PUw++XDgqwfcdrxZdfkr1vtLSqQUQQu6F0yi27R0iFcozl?=
 =?us-ascii?Q?iOLVgjM87ej9WjU70+yFWEk/jQSyo8l7or5daq0g3u4//iJ8PjdakSjjPUq4?=
 =?us-ascii?Q?QsenKLAeedvY8VAjNf2OamEWOWJjZodfkv0IZPSj5jLQT2M9y1soL3ptfkJ2?=
 =?us-ascii?Q?8hrssQ7yLMYYocA+6fmps/KkL8W5bkqVOoPZh9GRdljhm1ti/Ng92SYaS655?=
 =?us-ascii?Q?bls3D2pXrzJFKXXJrBYWPVl/kBX98vZgTAyiJtRDlgH5efMtHyM3yvi88g+O?=
 =?us-ascii?Q?nPp8wi/h//dRYu1fd4hdIU9kveDQ7xsSujdXRJ6F5B/9tTkfqmQTe2nNmcfB?=
 =?us-ascii?Q?05Qgn2OXjiFQPF/vhXpvWTRIri5S80kfL3v9TTly1hQkWlKNtsffiA9I4993?=
 =?us-ascii?Q?/5BC4LIIxad+zFcMGF5Kl1I37XvJW7GXDhRytQCebEw+bYLusux+hjrPF4A6?=
 =?us-ascii?Q?Xt2t4d7yrh+o1k2lRZ37PDWFzZ2jcSi5CtsGTwWnzSmrCMvg+d4MptZA0itc?=
 =?us-ascii?Q?k2ApFH/yhflP4vglxqPVNLr4FPMe57hWTuIt/mxAQCO7ENZART6B94dgWw5l?=
 =?us-ascii?Q?kfOJsc0weUO2Jm/cBAXom2achpkzOrn64NDRyA0KKAznVxzjvEhL2KpkWqfS?=
 =?us-ascii?Q?/ioEcJOCvCwg5n3LAr/QrPzwY2cJENvPzRfKOyucc6eqYCTa1C+7qk7/Sxal?=
 =?us-ascii?Q?kffWwdHg007JYYc8BuJ+GUkeIgZZvMSVzphCRDNYvS3qjrCYww6PG6eKB5KX?=
 =?us-ascii?Q?+lE4657O48vVtCQd6kF5MoT0atnkLpAu0TvN5/bBWcIvahLOddxr+4yXvPLB?=
 =?us-ascii?Q?wTuxXgcYpiYFeMSgeCUG709GH2eKIX5GL2aLKuMUBmYx6I5ScmNpjj5j0/um?=
 =?us-ascii?Q?/6YGCg5dXOIHqHC2Dc6/HWLGpiOYilUl9fqowejMgCquKcaB3TsKW0d9Ls0I?=
 =?us-ascii?Q?v2ibBU0vEbL+XUWNrkkHlugGKACPZC2bpP9u9LUYrpOHai4TIUYJHwdWCxwo?=
 =?us-ascii?Q?Yx2mfwP9HefxQq7jVRxOZf/ChZDp0BYng30p6UR4rkeV288pai0yGGp+U1qi?=
 =?us-ascii?Q?e28OgpBishVsjuXqMX4JGrvGt0MauMm85NJhXIA8YEmn09d0UYAOl9O/MG5w?=
 =?us-ascii?Q?xdTQk9G3CvdOxTqrh4rG+dDzeTqI4O9DMiTqulKsEP2qBkPcD9jsmHXWhBV6?=
 =?us-ascii?Q?yLXWH7Cv6QqrIUBe7bPMsl6Uy1AbZkOEN5es9Fftj6G+dP6NpnoMuV7cYArb?=
 =?us-ascii?Q?XVz1+rqrvTOdWNwuyZGFDgIH7WAkAtbpPHY9GvzMAhrEJ9Sd8T9+g/yGbyt4?=
 =?us-ascii?Q?sj8gjmBPwwuT9o9uz8bbNFYc/SMToHPfKsYHehjvJ7TpwD3YGN7iMB0+hkPi?=
 =?us-ascii?Q?GZQGv3IeTSFbdcCmBHgKCr/U4KdivuqU9RENokELaS91mBwnphfc7ntnfaz5?=
 =?us-ascii?Q?4Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 71a5fbce-ffd7-4cac-f1d4-08dbf142c16a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:22:02.0365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PW6EB7qDqwp2K0pS9mAgXA4apFBIW2q0yqPkULX7Zn+OWtWHKl8uziKHIFekuaLUfJp7rKyrEITeJXlPaJQVmkBbOUFet5MFTLV9EowwWsk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5280
X-OriginatorOrg: intel.com

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> A read of a device poison list is triggered via a sysfs attribute
> and the results are logged as kernel trace events of type cxl_poison.
> The work is managed by either: a) the region driver when one of more
> regions map the device, or by b) the memdev driver when no regions
> map the device.
> 
> In the case of a) the region driver holds the region_rwsem while
> reading the poison by committed endpoint decoder mappings and for
> any unmapped resources. This makes sure that the cxl_poison trace
> event trace reports valid region info. (Region name, HPA, and UUID).
> 
> In the case of b) the memdev driver holds the dpa_rwsem preventing
> new DPA resources from being attached to a region. However, it leaves
> a gap between region attach and decoder commit actions. If a DPA in
> the gap is in the poison list, the cxl_poison trace event will omit
> the region info.
> 
> Close the gap by holding the region_rwsem and the dpa_rwsem when
> reading poison per memdev. Since both methods now hold both locks,
> down_read both from the caller. Doing so also addresses the lockdep
> assert that found this issue:
> Commit 458ba8189cb4 ("cxl: Add cxl_decoders_committed() helper")
> 
> Fixes: 7ff6ad107588 ("cxl/memdev: Add trigger_poison_list sysfs attribute")

I am going to drop this Fixes: tag. Every kernel that has this commit
also has f0832a586396, and the there is nothing left to fix after
backporting this new commit.

> Fixes: f0832a586396 ("cxl/region: Provide region info to the cxl_poison trace event")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/memdev.c | 9 ++++++++-
>  drivers/cxl/core/region.c | 5 -----
>  2 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index fc5c2b414793..5ad1b13e780a 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -227,10 +227,16 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
>  	if (!port || !is_cxl_endpoint(port))
>  		return -EINVAL;
>  
> -	rc = down_read_interruptible(&cxl_dpa_rwsem);
> +	rc = down_read_interruptible(&cxl_region_rwsem);
>  	if (rc)
>  		return rc;
>  
> +	rc = down_read_interruptible(&cxl_dpa_rwsem);
> +	if (rc) {
> +		up_read(&cxl_region_rwsem);
> +		return rc;

I am going to leave this as is, but for future consideration I think it
is ok reason that cxl_region_rwsem has a higher chance for contention.
Compare how long cxl_region_rwsem is held vs cxl_dpa_rwsem. Once it is
acquired, just commit to being uninterruptible with plain down_read()
for cxl_dpa_rwsem.
