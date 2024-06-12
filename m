Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BE910A0E;
	Wed, 12 Jun 2024 04:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718166131; cv=fail; b=OZ+8AxOq4UfInaPclGHKU8Bs+r/FxQLms4z7by0YHbn1yZAsnSriUeRaBuvnyaF2frbJxtJ/FcXX9Uc74+1e59XnMK+OF8XyRXQrOxhecubTsHlzSy+wx0pHRYnnuwMNDv02PbleRhSpdi1nSLD0QDljEA1roHe9HzJaP8fq0xY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718166131; c=relaxed/simple;
	bh=jdTBA6s1PkxhLW4fHAgunCHCMC2NRbblWhnDJoRjodI=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OQOrU9v3nPzX5yz+72PQqXUlyJVOeCjb5de4FXTBlvNQeYxsbyeUD0QkR5N1gUhrfYK9kV00u89erphYMBD7lR1WiMCnl/PIWqPhmCGYqO4KWQ1xmPhsydpDUfXTXncWOZ5yTig7qR5hYlHJCg1WdW9Nt0gcGhdAe6bzPO4M85I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PiJFSARW; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PiJFSARW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718166129; x=1749702129;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=jdTBA6s1PkxhLW4fHAgunCHCMC2NRbblWhnDJoRjodI=;
  b=PiJFSARWuDMz+1bjI7CP+7rtQeHefvDnvW65TBK2N3l7nRQrXOg/Tgg2
   zS+uW5CXWJPj6ust4d0fgmw57j5YSm7wYvWPUjh3Y6K+ps6LXVvGr7Bxi
   rLcXt31fbU7vSLE/71tOBgO6smxYSDh8Y5xNbh39gEKo8PscA0xdbsnCg
   vUpBxusmWTJ0NhNZmEkN2lRu8ur6J+xdY1TBzuEVfeO5YliNTOjwwktvd
   CtaCyCdvmbSz5sA4famfd5682CoU9Au8sH6hD5Ok/3BKBoK9KyEJJcMXk
   f9rrisIp3cH5CgVlTpSTjv/beAFrd7XVP6ipMBCe8Q65jYNc1FKGAWfu7
   g==;
X-CSE-ConnectionGUID: ZvmSrgDPRN6Qi1ZcwJp80g==
X-CSE-MsgGUID: Fk9h0X5XRRSl//60Gpbi2A==
X-IronPort-AV: E=McAfee;i="6600,9927,11100"; a="18690958"
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="18690958"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 21:22:09 -0700
X-CSE-ConnectionGUID: H/ssiqIJR5+3SogLSHvy3Q==
X-CSE-MsgGUID: eXA9dp65RoKozCzg3nTP5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,232,1712646000"; 
   d="scan'208";a="39718130"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa010.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Jun 2024 21:22:08 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 11 Jun 2024 21:22:08 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 11 Jun 2024 21:22:08 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 11 Jun 2024 21:22:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7G7aCON2A5BKd6I2EcmSkIqruOoG+MbTBLH4FyXlYPMaNKGyhFVcvW6o0vzQ35St3vHv646Xcrqv5u1wLuqAxjSJsNt2WDCWE2thN2wWnSVAumUTwckXXv2HoKGJsKPwYCafQs5GyfYyiKAkHWrL+0KYVsD+iFbkqhDb+OdDCBcyjw7bqAEluGdUIxgWNtQC1BGCp+txw9BO0sIZa66tJUi3eeaq5ODfuPRKFLwDzbDZAAVYW6Vqcg3qOtbPC43wcYD1cZaLUE4t8DYM1YjdVWgS7O0t80mKfNqFmDYyGI+G6ADQP0kkFg3YKQ55mVQW5ONhJQc5dkXv5xMsg/3Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2BceySZLpXtBF6StyXeFE2zFXl4uqZItpn+G1tqA9Lg=;
 b=O384Lzqnseb4NFmM87LlimId9R112hmr56SF5L1SrwJgDA5A69vDWcqxyMeTVw0hmp9ol8RA31u1DKOssJps+kUZwS2JJUis5+pasuj7qB/DjO9yvdkf/47u0E9EEZsc/OWqO38dQuB/ia/EVFklsU2YnYgj1cffSmTDPBX7+YRMcvXcRjmhKHTt84248OqGSUSAa7EaBl0bluMIzhtpk/1M5PzWX/OdCFSogFMqU+TVkPrrEhhm0+SiYecWJDtUmYiH3YsvIHcZhIMIYqtZQA+IiR98VRXbKWjHegPcM7Qx2Bn1c7zg8x83aqzhq6NIrOiFDdxuF2Cn2qpG7nkt+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by BL1PR11MB5224.namprd11.prod.outlook.com (2603:10b6:208:30a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Wed, 12 Jun
 2024 04:22:06 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%6]) with mapi id 15.20.7633.021; Wed, 12 Jun 2024
 04:22:03 +0000
Date: Tue, 11 Jun 2024 21:22:00 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Huang Ying <ying.huang@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Huang Ying
	<ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>,
	Bharata B Rao <bharata@amd.com>, Alistair Popple <apopple@nvidia.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH -V2] cxl/region: Support to calculate memory tier
 abstract distance
Message-ID: <66692268d4745_310129469@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240611055423.470574-1-ying.huang@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240611055423.470574-1-ying.huang@intel.com>
X-ClientProxiedBy: MW4P220CA0028.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|BL1PR11MB5224:EE_
X-MS-Office365-Filtering-Correlation-Id: b5ab5986-7e0d-4322-8112-08dc8a973608
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230032|376006|366008|1800799016;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wCC1mPoqspM+GWCElq/iHWJq1ZooEYcT+5l1HI+Z+ammj9/8y1ag2XKiwjO7?=
 =?us-ascii?Q?WCreKN2iHLR33fK4towQi8XRpGskPm4afwQkdZ7nRP5wwymSJLGx/I5WRhAg?=
 =?us-ascii?Q?eG47+KiNIDRoGS+KE4NxFop7kA+HJkefsoanPHr7N3NoBarC/7YAf42JWbi0?=
 =?us-ascii?Q?F8jtEXluutYsEzhSFBtI43WmuhxLNKhtxjQhOSFzokH9+Q0Qialiqp3dOoZS?=
 =?us-ascii?Q?JCCy8uw3Z80QkRzcgU8HR9v6sMdQ6dwDeTvsoJohRdoOH/im/p6/4OFwPcNM?=
 =?us-ascii?Q?1XBNWTYDDfI3gQfOsy3IZixhkjUxf05mJmdoZ0THaDcqR3RKQGol6oBTa89C?=
 =?us-ascii?Q?4bQeTALhSPYDzBsiDD6TUmfh+9hp2ThMhlKAcsOyFuoZaV4CFWZRiuHgrdR8?=
 =?us-ascii?Q?hDJ1zACGYOa0//23K+vYy5jCu2aTtOIWpqbAhibCbkebVmkDSg2zbmmk99P2?=
 =?us-ascii?Q?29UMUo5bVY6eLPDPrgo/+qIFAzuNzUTlnUfkjILZ6rAi2jNtaP7oDfAADVKF?=
 =?us-ascii?Q?Pm6pTBhdoHcKh9Qi7WJFT/cBng72wdmDM90aVP4MVdoymaQjYfZbwv9ZnUqw?=
 =?us-ascii?Q?L9MpTuVUy5KeCtaC2CSMCDpeM7qXP1FaO9U6rU6+FCC1xuVBi7dLXkZgXz+7?=
 =?us-ascii?Q?aIV+RuMahiGqD1g3GY79soY8l7QmpQ9KkSHlaNDwqiq/mGFLjK7n6zMFeUCG?=
 =?us-ascii?Q?PpaUXm81ntV3vbng4ixsqUllKp6jJHdg9uBEmId0kO4rc+l5jF7UfiL/UmBr?=
 =?us-ascii?Q?dUcqhPc+xz86q1vPNIoMsOcplDQt65Pl748hzsRdaHz9/WAl1+2fah+OXy56?=
 =?us-ascii?Q?I9m1+f/XoNBu2eURjVYuWGuyfXu06JklA8y6beSPNCAOe1RP6gDqoJPSwH9t?=
 =?us-ascii?Q?0nwtpwo0EJus0R/QnELsLo0OTLjxb59M5nrHs58t0i1qJfLQ/YlV3HagIbAR?=
 =?us-ascii?Q?Jd/6AZwAiYseiy59W6q2OPDASFwA+057aUUnq33dkYZmQg+ESs9atXJd9NHj?=
 =?us-ascii?Q?bHp2gFB0XgJhhm4HtW9ZyFe6ChbXPopisYBNSnOjcr9Zoj2DbbzaOleSlzBP?=
 =?us-ascii?Q?80mAghgAdkKCFauhReuV1VeDMRu7CFTZSKeFt9dAEnndG5HjAzC35cxGSju0?=
 =?us-ascii?Q?X3NoEiAT3yThvYlgu6NUBuUf+kE3B9Kb5PYl3mkDt0+HQkB88F9KTcBMsx8B?=
 =?us-ascii?Q?2qZNzwRLm7bfa0MxSMoAsZfedjgMS/ztmR/GuqgjIn/213iGtszMA1fbh4/7?=
 =?us-ascii?Q?rV89oRAfepLex1ERVyTkyeq9xjEdjQHu5DIVVdBbF6duSsZCDtJrN22gDQVr?=
 =?us-ascii?Q?8mjXY7pwd3UeEg2D0uYFc0xm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230032)(376006)(366008)(1800799016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YvrgYxZS39K6VWkT8FSH9NChuz8r9fMNdYnV2A62bqWq3hqUgXOdDV160w3f?=
 =?us-ascii?Q?NPqICmGSvI23ckRArxGOfMGsRvvwOT5AT8ObG4Gwn7Mlo75+caK2LISog3vO?=
 =?us-ascii?Q?YM0g/5igaS8sr4wHME6za8zy3bAdf8VoTJj4N9mxmmRBUnfRrbl8lkndvKDN?=
 =?us-ascii?Q?I9rnApkmYHQcWYRzOOJi4xPZHo9R7+KAB7Yausc/54gsVzn7PEM4Bl5zSac7?=
 =?us-ascii?Q?+EVHY0nGai8H1lFmphy3DkUGtnoBI40JLUfmBU4xyvM1cGtHk05Zbbud+uUA?=
 =?us-ascii?Q?nsKU57VNfBv7h/s8cJUrnO1r/4m1hNJZ06QqRyG59j52jXG5wsu78P2KUOFe?=
 =?us-ascii?Q?gz72Rr0zLJ6fIVkSH6SlRKfAg7P/Hx80zeWHV2AytGvEa/9EBUgaNPbRhKnq?=
 =?us-ascii?Q?sl2DtItY0ulnN2dMmktHYAPU1FLPMxP86zpdt8p92sY39HXiLWDV3q1NO8iz?=
 =?us-ascii?Q?yRwgjtjsoOh3Zj5jRLd8V3JL3ih9Oy/U2LDbKdvySw4xXreYMxwrC0D1hEZO?=
 =?us-ascii?Q?qIYa+eYo0dvR6zL5UIJhtvPZmCgcvhY8Bbk0b0t7V5jok0NC6phAOXmPyNFf?=
 =?us-ascii?Q?c9LFqjBsZRCIZE6jh48wuZyN6689HyKiRGKldS3RwofXNvsbS5doyvxaMo6V?=
 =?us-ascii?Q?16SRXqUGzGv3KbG+A7bfChrOFuHEm6D+nptv4EVljHaazZVXVVYnDsTh5cuH?=
 =?us-ascii?Q?yUDXgWDQAUYqBflDqPttb96cdx2+OD3D3YQ7yiNtdaNYrNSGqX69UCSbwVyG?=
 =?us-ascii?Q?7nB44CovXzl+eNE6qJKUUsf7XgTi7yMFd0KITkeRKi3F8xGTgLjs+T4Fr40V?=
 =?us-ascii?Q?ChJBt6IKtAd1Vd//GappurMUJDtyohBazUQ5HoQPDve4tIb3Yw2HsRAVbdIR?=
 =?us-ascii?Q?G8OLare1XA6inOHaW0ePmdTIxoeAgQRInBqeM3B7vyHap/Z4GYgkdTQ0rKjW?=
 =?us-ascii?Q?tkLrV+lIw4K//aagfpWjFCEwfrutCkFJV4F7gfkWUhxakfhvjCilJpU9crI9?=
 =?us-ascii?Q?DmiXyxbjTiKCD2sPIf8oPTVIeGrW9uDpMze5RGLIU/Yc3dUesVvTequHPk7I?=
 =?us-ascii?Q?KdJdQxapT9rcYkMkzfwvUgd7X/vTLKqzAEXCkwtqerwMs/GjPYzgi6ifdmy/?=
 =?us-ascii?Q?bjG4vo9A5OO5ry3zB1lg+SipaKmE9Z8RdHC0nZ2v0cULFN2EeLreqdlhGPmb?=
 =?us-ascii?Q?QuVH2rKse69pzDIrzu0aanCCchNckjtXZpxgiEMXcX1TExpJ+YHLR2J6nEON?=
 =?us-ascii?Q?VZwBHKPn+/FmXSVgIreLhQzuvPlS3U53HqeZcdloD6DNiBcd5Srf7BSrlHM7?=
 =?us-ascii?Q?2n/h9GmIjWgXYalAcBANo5labVQORDsSNfUcLsO/Ds3zJMK4IO0n+aA7AEkW?=
 =?us-ascii?Q?SpOLCe3TNq7ow7Lec+2m/gjxrwDpc6AonPqOae2CsyG76tjp3yveeeuwij7d?=
 =?us-ascii?Q?+1+YYPaHDd+kSwt8/XSmgnV71DzP0TcSZNKq78FKdYLHh88sVJuwdQ6WF0Oe?=
 =?us-ascii?Q?SjmxVIIbNAA8EYIJjNkxdS/AxYsmqnPIZH732dlpcWpGXTOTHTmkjNO1rnF8?=
 =?us-ascii?Q?qeX4Svq8VXZUaRsWsSlsuGQdi3UOqefrtBOFyQ3T+wQ9w829Fxau/bXPu/DR?=
 =?us-ascii?Q?Ww=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ab5986-7e0d-4322-8112-08dc8a973608
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2024 04:22:03.2047
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rsc4OMGXEhGMKydX36Mfykg2mAhRplYP34+wSv9HhAnnXPL7ckUP32InOYhypo6xOZTPNX8lQO/54qw1zr1+ZLdNJ/NN4KJc+2iqxh8XRbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5224
X-OriginatorOrg: intel.com

Huang Ying wrote:
> To place memory nodes backed by CXL regions in the appropriate memory
> tiers.  So that, pages can be promoted/demoted with the existing
> memory tiering mechanism.
> 
> The abstract distance is calculated based on the memory access latency
> and bandwidth of CXL regions.  Which in turn comes from the HMAT
> and CDAT, etc.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Bharata B Rao <bharata@amd.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
> Changes:
> 
> v2:
> 
> - Added comments to struct cxl_region and minor fixes (Thanks Jonathan!)
> - Link to v1: https://lore.kernel.org/linux-cxl/20240531024852.282767-1-ying.huang@intel.com/
> 
> ---
>  drivers/cxl/core/region.c | 40 +++++++++++++++++++++++++++++++++++----
>  drivers/cxl/cxl.h         |  2 ++
>  2 files changed, 38 insertions(+), 4 deletions(-)

Looks straigtforward to me,

Acked-by: Dan Williams <dan.j.williams@intel.com>
