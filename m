Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6DA81FDD;
	Tue, 21 May 2024 15:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716305170; cv=fail; b=C+8jteiLSN+q09yRPXc7d4oCEkjNEOeEPP9gYTbRlI0Hhuy7WC1Jfe1eDINIIS5xrWz0WWGbPS0IYRSe9LxJHknNlgrwSyzIq4K9MV8ztn4/Louc81yRjhEWkYVrhEMxDSXfoCF+dbqp3q6ERcbiRi7oCm1UYN51NpHM76cMwcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716305170; c=relaxed/simple;
	bh=opwiXITfGQDkVg57NYPhC+vPiPiHRcya+4JzMnLl+og=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jPS1L1ljzrqmsnPNvCdiCTL4sivK6IqgIq2L+z/CtG6RPa5LSdu+VRl7WIqFkRtQxlMseDVNSyurXgzEzy2/hLQGIiyWAf3ZIpLw4yR7I/CysahnwFfz1RMrym0q4eFccqyWNd2cXT5jdvRGCaHtEQPTx0/iZZHg1kt4w+KslJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DZ7+lHJC; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DZ7+lHJC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716305169; x=1747841169;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=opwiXITfGQDkVg57NYPhC+vPiPiHRcya+4JzMnLl+og=;
  b=DZ7+lHJCaaUAgmhp9mpuoRUCTxtoWE7arTKXC0D5onjyQsEMI2nlodGR
   dCXNEFRtw4NLyqvLchbvrK4VcWfGpmHNjM7ya3syWxPQAOJwoBfCokeav
   ZQ41ZSoP1aebS5szuBU9Ph0hHqmbXB6u3psniuFP83xZ219gZDoNVqowh
   ncC5vYMrV1vtLbxOdEvXtwLeN9msLp93hqOSmlQmBcxBZfs9kxlz9tk4N
   EEgD4fcQFOrUw/8poL+S95ique9GKXmHbEMgXaqt0VCOEx+qkaMAp6XF9
   NREOncal8u79/Unzi+l0qWPfnSWAiamZMeI+xygwiGG1tKwY9pf9AnM69
   w==;
X-CSE-ConnectionGUID: 2/bLJGWaTKGnEN3obVWR2Q==
X-CSE-MsgGUID: 8VIQF0c5QquLkd1JLRZJKg==
X-IronPort-AV: E=McAfee;i="6600,9927,11078"; a="23115095"
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="23115095"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 08:26:08 -0700
X-CSE-ConnectionGUID: Z8465AKPRjeHFdKWVhw61A==
X-CSE-MsgGUID: h43v74roTOawDtb7Kqhvzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="37455493"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 May 2024 08:26:09 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 21 May 2024 08:26:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 21 May 2024 08:26:07 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 21 May 2024 08:26:07 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 21 May 2024 08:26:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IgKVv2jI2kT99vozLQPKXcm3NIj2G8mAeWcprpxO83WiLVFfShueboOr5+n1a/iD0iACTJR2zlcTgyh8QlOBXGGXqmK2xXDub+3VLIHvFvnHKyIU4vdksf0CyRnK8LS6IDc4O5sCsy4Z9fajKOt6By702WYmNne732a8oHAw2Unhq2V09sIpFpuDj5crQNteG2vJbtSVOL2/0ptRJ5mkN6N6SBDjr1vs173mJD8TZaeShQWYPYCmjnx1/dbX+JhnhJl+YVAhNzje5R9MRT0FvxXdcbDSLNnKs6/2Rc41M2/xqsO5g5B7X6hpaEiyVYzzqPAKtd6xBxRI42SwUu4ykQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5KwZT+9BcJxcNSOSLoT0pm9oxZGSa3+6EYVzWeM4HTc=;
 b=Hpq/Pu7fccPGHPlbM3mHb0k+CoR1MwicDS4C0NZPDEJ45VRE1a19KuXrf9KaZV+mU4XdE8V88727vp/h1xfeLfx6rLTpAiHdS9TwszoMB/hit/8+8hRmZuaLOIvdMHTiLdSoWnW9Bfd7zcgn2ZWIpV4n/9YaqGzobzFNeTpnLrgO3UB+BX5AoqBykRRqYDmUCZeuLqBdkMqdv065xHNQ/23crw8+wAc+e00wwv8OqZ4uIO/X2bkgG0PCdJzE0j+uFue7xsn/p6/URplVzGvS/GKpJRUpizrnEW12HdfvaEF8D4vw4NHhg3Y7IKRMYgAbxK7PZ1QA2xUSx+CvNZXMEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA0PR11MB7749.namprd11.prod.outlook.com (2603:10b6:208:442::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Tue, 21 May
 2024 15:26:03 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%4]) with mapi id 15.20.7587.030; Tue, 21 May 2024
 15:26:03 +0000
Date: Tue, 21 May 2024 10:25:58 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: <nifan.cxl@gmail.com>, <dave.jiang@intel.com>,
	<alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<Jonathan.Cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>, <a.manzanares@samsung.com>,
	<dave@stgolabs.net>, <linux-kernel@vger.kernel.org>, <nifan.cxl@gmail.com>,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH] cxl/region: Add module license declaration to cxl region
 module source code
Message-ID: <664cbd06b5342_364af29491@iweiny-mobl.notmuch>
References: <20240520193106.994172-1-nifan.cxl@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240520193106.994172-1-nifan.cxl@gmail.com>
X-ClientProxiedBy: SJ0PR03CA0031.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::6) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA0PR11MB7749:EE_
X-MS-Office365-Filtering-Correlation-Id: b777b81a-4415-410b-6e15-08dc79aa5369
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FkbQDyrJIssGYejBU1qZI6xKhndR7mqgquph4lWZKlZbpUZmLFv6bydbLWHF?=
 =?us-ascii?Q?Su99n/PCIFWxsJqfZHdfhIDUMJu+jQgEOKvVa3lezyJxpBG01RyU/onm1pcS?=
 =?us-ascii?Q?CYmopyWEkqaUqjNAAGp2kTNYxD3w8Z9b61dm2Pd6428r8T6cxjqMpfSnYt7G?=
 =?us-ascii?Q?gbS4A/m5q1bKbZHIZfm+iFZ5eUv7Fjh3uelDUbgTy58zai8Dnx2NBK7nySKP?=
 =?us-ascii?Q?+7PoraIZoo7XrpWhM4y2WSxRDiKk5Pzi6jMTTcmwDPowvmp7cav36i3x2lo7?=
 =?us-ascii?Q?1VsGuKl96DhF+NHZeY8tZMuH4XNg1zfWRisoEo7zkwJw6K/EAxM/EbYtAHgG?=
 =?us-ascii?Q?xU9L37laTpVt8o6NJn12jHPsSmccZX6mC5EELZacIa1sUK4vN303tz5V69jn?=
 =?us-ascii?Q?6GpnLA2t51muuSdb1/uO0r4Lcz5mjs8hq6SduQPCPTmRVhzKp+aNAn/qqPEo?=
 =?us-ascii?Q?YH1SM4DvayEhd3+YWKhBBK9PKvKGeEAFv0nAzLlEjoqtbUs2AbYCnkWE+WCe?=
 =?us-ascii?Q?RPX8XGPO2ZPy1JDp+byknA8Ib/YwoOamkOCgEzVUlPvxzj6Dxmz+ElWYEYMe?=
 =?us-ascii?Q?e8YkVgxEpG4cdckEPXsxhMKGRPRFzZIz6JFxtT2fQUKNzWt83eETkqPJqaFR?=
 =?us-ascii?Q?KKNwEZtrSHSQZbFqcTxBurSjA/FIlHQtE/qt1NIFjGua+qaFCdr65cuLTDLr?=
 =?us-ascii?Q?Nfre7lVk/q9TsX22em5gN1sDoi2OQWF92WdTniHxOXa88HkqIuOeCgKgRruP?=
 =?us-ascii?Q?ydnRJPbwh9C0GSt+UXxazOTa1aQFd0LGMd9IvKjSYyAm3gcCS6mJzfVQlR/h?=
 =?us-ascii?Q?LhSs77etCUbaFDSVojjH5ifUgzRgSK+vUoDtLAgx3g5qQWIZFB4fY4EUa8fo?=
 =?us-ascii?Q?EpoPY6z+WHEbCyC+vHMb1GJc+aYkZcGxjdVuNLcJLXaFa+hlHlZK826xUlDr?=
 =?us-ascii?Q?5MJPjCfSBqOLWhNnEk8ggDLvuGq23L0eXZiHZQzw72V+UwAnDPZqY8U0d56P?=
 =?us-ascii?Q?glT0YvomrfZzsl4OFmf6J1iAZRolaFhfVsWcMBZ+k/lnl+1r/6J9qmu1gzUl?=
 =?us-ascii?Q?euxE92VhmvxA2BHDKQdQziQYKZb+OUZGg9IKGJEpMDN7lM//lSLcYGMOVHgd?=
 =?us-ascii?Q?RaPDkQA5kgnrgZIXVe/EBkQMtDW6KWZepBAV2c403DwLTdJ9d+BLeVb53G9n?=
 =?us-ascii?Q?HtBemOyJzv7yrZEi30dVipz+3i6zD2n9LeNy3EmUWLM4YobQ3s4iYq2ar37x?=
 =?us-ascii?Q?PUzG/dCypAhlfRVQITG0VuIK7XT90rRS0FA4Jn1p1w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nvgpOuZhdHPZxHmlufE2JNcYAYnWiR1SzrOb6gSPfJDfLR3p5QG63zEBsFtV?=
 =?us-ascii?Q?tXMHYHyeGAehQIy2LLEMzmbQZlHnGCv3/IxsGk+vqXhSiHAP1jyeZxpV8eqx?=
 =?us-ascii?Q?/HNk9bUHf+HnARVeEpbaPkUsIbEBZdo/BqE32fBwbNEL3ExQU6Op7khkX4FF?=
 =?us-ascii?Q?AK+pxAaHuTE4rJg3PG5+oZr5BXZyixpaahD/8xHsul3Vm7J4+2zFXwwC8sEp?=
 =?us-ascii?Q?Sn8RCj78ZgK+Jfn9OT+0Qdgeh0LwL+xKkVPNtZmrgCNJ08UmICNcIHpI3NMV?=
 =?us-ascii?Q?83kFLX6K88mQghIWYE4Rnod8ZlhcAJWoCwLaBue/71Zgk4MArv8/uSf9hZjI?=
 =?us-ascii?Q?+9JStRwhvNl7lFBBBwVgw1YEiih0QBpil+jz5cEMyMg8iYDzJYL3nNW9ZIx0?=
 =?us-ascii?Q?DY5slZ4cOGi6hGutuHzVyzwRc8Bifzsj9EvchkaqGrSTJ1H1tluB9qMO9JEP?=
 =?us-ascii?Q?Evr1JrbLH8AdKsI0PemQ3Yr3Ebk0IO3slTSUZh5e3ZTK7Spf1jAGNc1qJfYP?=
 =?us-ascii?Q?KeCki1GgVEsBcfkKYBeNr/26auX4NAybhpZZIilHrdfUwcY4j33+fWUH6dfT?=
 =?us-ascii?Q?SHFZ3HY5XzGXjOBY6loO4+1d3AQarTaexseLOVczyPvFjdCCWLyJwVvlSGIF?=
 =?us-ascii?Q?uoABV4t4cza5Enc8sAW+nmlEFKKanGUsTiQIJojpjX4IJcsQ9+KbR4+W+MMh?=
 =?us-ascii?Q?1scCqFqJPxwMbVH4UYEIQGRAaRO7c5MsUTSybmL2R+yOSr3ic/BkjQuZ/SCo?=
 =?us-ascii?Q?l8ngmKz9SdPr3EvHMw1XoMqZ6elTHkKGIj+McyXakrjNfsdWU7u2/2yxdcKT?=
 =?us-ascii?Q?rBFMIbdiUzujKU7dbE/Kc96psnML5RFGPLezdcsNuMXweG0cHNmZ+dsmz01H?=
 =?us-ascii?Q?ua/jdXKEbdths4ZH9kM9S4TSXzUI8n82MPwNZM5EhuluujMv6uLRpw0gWExv?=
 =?us-ascii?Q?2dg3N61ncgA9wb/Xg3LdZF2mlxRB+oUYs5x2q2QFX8lBWxt+SlomcLEDnn/N?=
 =?us-ascii?Q?ZVYJMrh1+5ochyuD7jU5skH6TOjCMZ85+9XGjjoWCLJ+CZdbtWo6pL2WY+dy?=
 =?us-ascii?Q?X4+kyovt7xLjhcegO0VsH7SZN2jDTa6sF3Nu4qgYWcTaqO4k4TTjZbY6p61P?=
 =?us-ascii?Q?Jq7/rnZbEkFizzeAaWfDy6d6L8JHQMuchUspPj6v6efjzIo92AESym6eVEjF?=
 =?us-ascii?Q?1ryV7IWuxG8YOFtGEueZ5oaBZVkNeAvr4RdUwDVqJbL++jMrerT1fH+wMjGN?=
 =?us-ascii?Q?Gchm9/iiJaXJoucgsmsl0+g5Oa6CECfPGtlswmN8cTtWMJamSGN6BBww+tks?=
 =?us-ascii?Q?X09/0LEmGPPrIarme4rICmDeDJlqwX7gobRJWM21OTeW7awVy4xOuQJ4+oFT?=
 =?us-ascii?Q?bCBmqNppcb9hYzJWB8t3rY5FlU5uIasxPCj2NC9ZXtEAK9jT9hbIs9bvIlGO?=
 =?us-ascii?Q?ZaosJwyyrZHExHHM9kHwv5EjWA9ZQXfIcsCdhjmyg9W8TQMs2qSWKHt2yFJH?=
 =?us-ascii?Q?cHElP7eZTn2iuqigo41j5I4a7Ac3vBYTsWRWYstPc/Wiytmpkjlkkv8o2meH?=
 =?us-ascii?Q?HIQzhP0SZ4SEwRacCFfhg/00Gt9vzGa9ngyH/tf3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b777b81a-4415-410b-6e15-08dc79aa5369
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2024 15:26:03.2975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BDCmm99mOB7RpLIxDWptATrlsMfQ/gpzksKuw7T0O/VUs1xwOV8LCbsT3UvlxFhVnzglAVNcpiH4xRZKtG7LKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7749
X-OriginatorOrg: intel.com

nifan.cxl@ wrote:
> From: Fan Ni <fan.ni@samsung.com>
> 
> This change explicitly specifies the licensing terms for the CXL region
> module as GPL v2. This commit does not introduce any functional changes
> to the behavior or functionality of the CXL region module.
> It solely adds the MODULE_LICENSE declaration to the module source file.

Why is this needed?  The region code is added to cxl_core when built and
that module already reports the correct module license.

10:24:55 > modinfo cxl_core | grep lic
license:        GPL v2

Ira

> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> ---
>  drivers/cxl/core/region.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 5c186e0a39b9..e299ddcbd1a2 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3204,3 +3204,4 @@ void cxl_region_exit(void)
>  MODULE_IMPORT_NS(CXL);
>  MODULE_IMPORT_NS(DEVMEM);
>  MODULE_ALIAS_CXL(CXL_DEVICE_REGION);
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.43.0
> 


