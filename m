Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="brXgEaq4"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0E6CD
	for <linux-cxl@vger.kernel.org>; Mon,  4 Dec 2023 17:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701739057; x=1733275057;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=h8jPMzTHBOSI3WGCe8ya8eWooZNRnb6T5palyP23quk=;
  b=brXgEaq4uhQweUjnH6aFrINIuj9Vwh+Zk7OTGx+WR4UVBMi+3VgztvxA
   c26w1rnpK9EgF3FgdB3IAO8f3X8sXbFh3JKOxgOa9GnGXYNaEzveVVHzo
   3/sVCpxpxrDmF2aUFcyNosQ71sgws1dmMoHNxxehrF4UbrRmS8M6+OZe8
   oAgli+8wHFl5OBthZx6NjQccFwrmtUixoq4v8CqdagBGtwAMzezLtwAE6
   pWghoYKdgLcYB30US8tcqB0y3y2uryit+5viASzKF4iCBrj7uOQ+uEnyf
   mXxRwIuqZCbXoQoLc4nneleG1j6UsN9rp58DN+LGK31fbJ/yqrgXMU3CQ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="390975566"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="390975566"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 17:17:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="841253977"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="841253977"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Dec 2023 17:17:20 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Dec 2023 17:17:20 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 4 Dec 2023 17:17:20 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 4 Dec 2023 17:17:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=achm2Qc626l17n5ON9+p9Zn6g39DZGVrLkf9/t2sm9VvqqqIzFYS+UhZay1qH7p1gzXGjcPIcoNteurzBMRWPQQFb2SzvK961CKvAgIbdwJWPyMGS5TB0j0lyKEdZTpvmOZjxa7kq/KTwRoUAdG5CD81IANy6EeopyPvPUmMRiDNfD+jIdpedRWA2WmHN+3fjV1FDyfq/SF4FjrC7t+c8oh5Up+IqCno1XCyg3uP4C7pgSPrXhk6WPIbJDO/G83tcSloUv3wNByEc09IGX6O1/6JuWzVvaAKGOcTDtRJz/yHfqAAoPGz1iSzldYuA5ez4/Ads8w1Gcedj54l2lHvlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hEP8wyTAgfvg3PEnET7a3IUXGRh5XPp+7KP2jNrX9Rw=;
 b=WkAMhpq4iigfFiSCxCPS+IVfUHlSJjq+Q8rXFjfh5yplIMB85kuE/9uer6AvKiOUMjlo6pLyD2WLXh4ESIjcaIvvWGS5Ze4bBM/ccUAIkQhdychFIy6q/i8m9HG7+ByK1v5gdN0gJHXThCp2Aw5qd/NSAHPrUaxX56w8J67jdKGkclt4yLbj9xIAypGBKV2Ab8d8ulnwhZvlo8+q6U9y3kwOnRnXT81c/1vAdCARaE6/P320OjtmrMPgUB8m8yMlcclhOanilIgCj7er+TZONYe3T7OMWOxBN/dRA0sPr7Sb6jQwrmKFcbqdaqEEEZ9MKfAsynpHqtrPWCBmfJzFfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN0PR11MB6231.namprd11.prod.outlook.com (2603:10b6:208:3c4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 01:17:18 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7046.033; Tue, 5 Dec 2023
 01:17:17 +0000
Date: Mon, 4 Dec 2023 17:17:14 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny
	<ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Dmytro Adamenko <dmytro.adamenko@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@lst.de>
Subject: RE: [PATCH] kernel/resource: Increment by align value in
 get_free_mem_region()
Message-ID: <656e7a1a79047_45e01294bd@dwillia2-xfh.jf.intel.com.notmuch>
References: <20231113221324.1118092-1-alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20231113221324.1118092-1-alison.schofield@intel.com>
X-ClientProxiedBy: MW4PR04CA0207.namprd04.prod.outlook.com
 (2603:10b6:303:86::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN0PR11MB6231:EE_
X-MS-Office365-Filtering-Correlation-Id: 2373f3e1-7428-470f-8f8c-08dbf52febe4
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IkRqP9cuAH8tpdAVYByxhHSKq6FKGuT/4MlE7MVQSejHrnoV/yd1gaa1y9FOz/ZpCJ5Zfd4qIhgT2ACDpu5R+uXird+L07eIqWv/k6E03jY0toHh7A0AuAklP/axryGGM86qfMg/px7xVISxjk6i5NmFuT27RXRraTdqSOxLdTMe17GwbKkB3qIGzNFR0t6kRqp5vYAaVEj/xHbU2iXbT2wS87wQWzRLcxzPhW0sC2arlprFp3vGhrNEq8Em+evjz/cDVSY6usO3Ly+4zPmpjoOsk1OCTIFSnqRCrUj/hO+UVRU0jBgBh/Y2aFt0jgPqzNb/vBMc4bM6Vjkubr4NYbqS6GDfqldz9/MQg6PgW5r6QvTU5aH9U6aQ7J7hi6ppeYZRXpAOYlu9++u6vz8WE4XsqWOjBvXHZR9E0cX0saalCFzlRlr7M+mIa/qTAD8K33M5DsTMVfnHALJfxYWKj+2XBhCS3yK8fyfi0gNllHg9MJx9Eswe+bKsU8ejl2OJu9qHsBLzCXQWZmsptGNdKM8fetmJsMtZJZovZ5ekRLFWkd2pji5ipl/klU8QqOBX
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(396003)(366004)(39860400002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(38100700002)(2906002)(5660300002)(6666004)(83380400001)(82960400001)(6512007)(26005)(6506007)(9686003)(478600001)(110136005)(6486002)(66946007)(41300700001)(54906003)(66556008)(4326008)(8676002)(8936002)(86362001)(66476007)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mqz9W9ekyyoSWns9fwCh/+2Q74usbguAq52yyGdTAiedJFTcVswE7LMm8txd?=
 =?us-ascii?Q?vi4bCipenEAFb5FlL4M6tSMhhrGSjzxWavtwAOyYcTiT8wLrVpLKeATJ/FIR?=
 =?us-ascii?Q?7cE5zr3e52mRf9FFEJUUi+o0/oB6X/8XPoTaISxDC6h8mfVlzMpeWcloNylr?=
 =?us-ascii?Q?plMwX9SISl3tpaCg84K5uii6q/f+XEpt3bxwqa8UxbB6PVMjfIbYFQ1yWExr?=
 =?us-ascii?Q?PcWz1Kk+S21reS5b6VR5kQR2bBoUwzOsUbI15ziECQZCSq+0n0aNtNvMKUfL?=
 =?us-ascii?Q?aHS6DN4Ij0l+0FrY4pJLMWhQ+c+0osVjECMYueZlpGVNJ0zq59UVazJmaIpZ?=
 =?us-ascii?Q?STDvBEpp5Nm6PFQo+2oUWSox6PnIun443z5Yl/Q/dgDyEv/fzqttc54P8scH?=
 =?us-ascii?Q?bbV7uao1SPRxXf3zA0uj1gF93EkY8Gs05cK9jk9aYTi46REcpONM3Fos+/mY?=
 =?us-ascii?Q?i3LNvoEJsJB+DNISIRbfBDArAt9okFn0LEp4RsJXd/JGLeHqzLm9tCV1ig79?=
 =?us-ascii?Q?AxfC8ugD8579xSoAbI8KZbV29UZYjHnjjmdjtwwHw1j/lY0M+UM1Gt9II1Kv?=
 =?us-ascii?Q?EtmdioN12fwDG01DZ1k1PFY0pk1nUDrz8jmkl8NrrnVJhKx1OJu4TaVJlPAU?=
 =?us-ascii?Q?oift7SoeVXzOjyMPS1pyZu70kV9TA3htTgJX0HqMsYl3+pvIZQlb3+T4CMxy?=
 =?us-ascii?Q?89xKExZwCtX6JvS1d7D3frzeYNzX+P46yMuYdNWFEZO1td6a8EnMxSm8o0WB?=
 =?us-ascii?Q?RNtZGPTsRj0zftuuvQBCPl9l0VYexG/5H6xSfNpDYzkTjttmDPKf0jKISRYd?=
 =?us-ascii?Q?qsAnnJe9IAOjy8+lWxjn3Ue6R/OU8AihMI38BRFv70JHsRIFo5DI/wAF/hgH?=
 =?us-ascii?Q?P5nZvlRhJSLTtyqjDKv3zkPP+83iWNVlCPlrGgU7rx6umXR2VspCYjcwWywH?=
 =?us-ascii?Q?mCVudyVvVzyCXcmRU9RYcV/U0XWgsJq5bL6b/j1jw+Znkafw6ZuZxF95ZbFw?=
 =?us-ascii?Q?UX74WH73mbKYLm/mQSHa19Mp+a0Um/WBRa4OIN+dXSn6+lhb/m37uqogvoJO?=
 =?us-ascii?Q?PPNLK41nCZiRy0SWmiY/ExnJrffgmj/cQbqjSBqOBp9U8aFX8gsBgyra2kRa?=
 =?us-ascii?Q?2ftK27+M8E2T20EwQyty81bgPxUKLlPURkh97BqhXIHFaGEC4vwyCz0ZlZap?=
 =?us-ascii?Q?c84iHHxxndihEdHb5kKHvcnK4PtGsdTHiZd/T3cWTDgDYIgtfAZo0LiVoSPF?=
 =?us-ascii?Q?HT8YkyODkiYFyc7kULX40280u+jXDvdWgCuaTqrc8QqCd4HtTsl2+K5IOTgb?=
 =?us-ascii?Q?NoFRDKLjt54lUvtzvu5kahI4VpNlA9WdA76bUv/rgluafeiEBDSovZyZfMcw?=
 =?us-ascii?Q?Ej9TT4yD95BC5c4h0YmKEYuE1YwtI7RtxM00OxuGF44NtU7IQZWZysl2tM2N?=
 =?us-ascii?Q?X8GpsTCvSrDPxDNQ8ovbAeFAWspg00ejytiE1IfIG55Rvc1lGVULRWuMlCvy?=
 =?us-ascii?Q?uHl7ojimqKu8ueqw3LP7qgIBkdzFs+Fj09xCAI4xXTZuXVO33l5uIeo28FGw?=
 =?us-ascii?Q?6mcoQIABJ3YbRavcXQyEaXYlMpFJk05RK/+sGjCqn66CVR9Z0MIe5A9rE6sG?=
 =?us-ascii?Q?WQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2373f3e1-7428-470f-8f8c-08dbf52febe4
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 01:17:17.6409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mUJNTcYplUG4pvzyEVdL5zwejnbannd6hR7RH3xqpgAB7fRAFzJp1UM603oSCCT2cjnvGHXKiYTXPA3cMiHi82VaifXCDjrYbMf2nLzUhvo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6231
X-OriginatorOrg: intel.com

[ add Jason and Christoph for request_free_mem_region() impact ]

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Currently get_free_mem_region() searches for available capacity
> in increments equal to the region size being requested. This can
> cause the search to take giant steps through the resource leaving
> needless gaps and missing available space.

The bug addressed by this patch is less likely to bite with
request_free_mem_region() compared to alloc_free_mem_region() since the
former does a descending search through the address space that is
unlikely to collide with an existing allocation.

Patch looks good to me, but I would clarify what a CXL end user would
see, so I'll append the following on applying:

"Specifically 'cxl create-region' fails with ERANGE even though capacity
of the given size and CXL's expected 256M x InterleaveWays can be
satisfied".

> Replace the size increment with an alignment increment so that the
> next possible address is always examined for availability.
> 
> Fixes: 14b80582c43e ("resource: Introduce alloc_free_mem_region()")
> Reported-by: Dmytro Adamenko <dmytro.adamenko@intel.com>
> Reported-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
> 
> A couple of below the line items:
> 
> The MAINTAINERS file and get_maintainers script did not emit a clear
> recipient list for this one. Start with CXL folks and I can expand
> it in a v2 with your help.

For this it is sufficient to Cc the other users of
get_free_mem_region() which I did above.

> I considered, but didn't, change the parameter naming in gfr_continue(),
> gfr_next(). It's a choice as get_free_mem_region() is the only caller.
> Thoughts?

Looks fine to me the @size parameter for those helpers should always be
the step value which is @align from the parent routine.

> 
> 
>  kernel/resource.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 866ef3663a0b..91be1bc50b60 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -1844,8 +1844,8 @@ get_free_mem_region(struct device *dev, struct resource *base,
>  
>  	write_lock(&resource_lock);
>  	for (addr = gfr_start(base, size, align, flags);
> -	     gfr_continue(base, addr, size, flags);
> -	     addr = gfr_next(addr, size, flags)) {
> +	     gfr_continue(base, addr, align, flags);
> +	     addr = gfr_next(addr, align, flags)) {
>  		if (__region_intersects(base, addr, size, 0, IORES_DESC_NONE) !=
>  		    REGION_DISJOINT)
>  			continue;
> 
> base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
> -- 
> 2.37.3
> 


