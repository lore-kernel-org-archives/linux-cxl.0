Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16469A2D
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jan 2024 00:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jg621+8E"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704413273; x=1735949273;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=edE6L7M+o3YIlcvQrranD7vEjJCbLgBj/QKIWrTwkgw=;
  b=jg621+8EY5t45BmTWA/TWtupeS1NUP/8MD8Vt0nzj+VXYe4AG2Q+fRrZ
   UWyjDIZV4jULl8K/x7b+NBXXSIfAMUBDq2Ff/bDTXYiPMnV8+dvhDnqFQ
   i44c5LUnPMl4mVDx6GaMeeXimlTny0FH3jkGHXpYpufu1XiDCX/K2ufcH
   fCsZfUghkJZd7L9IGZ/24mRpPXDNHtEI8LGM129dGoKpwedyy1Ak6bWag
   SbSazIcGIC/AxbXP5atsPDSVF7ylVDX+FeBi5SlqJIvydqBiriUIfXyJO
   LKtTyi/qlXpzg1aSHCU5vr0RvLtVF1w9t+FmwvcWr5OCJvKZrMzKz7wNK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="401179743"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="401179743"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 16:07:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="22330311"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Jan 2024 16:07:50 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 4 Jan 2024 16:07:49 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 4 Jan 2024 16:07:49 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 4 Jan 2024 16:07:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dZf4QVfkdMkrtQuQMls0mbL8hSatDh7v+bTYqKO4135FO9Ku0XbBLz7eUlF2/QGqq2N4hN6ahwdqrArLoI8bA5klQpvmvl9V8lUydVuKCpkrQUc955FPpOivBriQigsrRxPS4dwgjo/E7eldPqJzzmeK3EYljk3lmd5ZlYCF3ugHlUrt+2v0mUG4qEAyF5cqdFjnSiQX3FQv2Bv5HFZ5PNdKjZSXd21pR1aVJbNVRC0hZvH3y+U468EucPmKwd5bFbThdkDFvQ+Bk9PI5RnT6JDtAfFYYA2l91hpLFWceUFBcVnE6EA7WOuOtvv9cSLPP8Bb+faeYADqxlFPnTFMFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ruPa3IUuE6WRmJDJi//910nHgp2ltorD2xmd6qZP800=;
 b=iaBLcs2ZWyoGnFDKuP3ODOwElDlAGFrmhXVE2HN1pScyB9yH4xo4Y22Wi69p+zlIwSL+LaoV6Zlj3Eo4G2dJY3VGlmeuoJZq5TbKBL7H24t6BMUwrckjXaQjl9FIGG525gtyn7lcsde457qQNldTROyFLVSIuW9JTzUyS+0N9p8jdGZmUBW4SYwRZtS9ZNXxoK+7Wvl9HZMPOBokbCyAZUTEDBqfJ82nA6pZHlaFpXwZ4aAjxhAS1NGs/rfxoBIjSeVrhK0hSlpDXXnq5Bg2IDIhaQa5oXvTXE1PwKOldCuiARv/d5ONddcaOFrUJWi3zT4lUTZCmuFbmU4iZrjylQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB6821.namprd11.prod.outlook.com (2603:10b6:806:29d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Fri, 5 Jan
 2024 00:07:47 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7159.013; Fri, 5 Jan 2024
 00:07:47 +0000
Date: Thu, 4 Jan 2024 16:07:44 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	<dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: RE: [PATCH v3 1/3] cxl/region: Calculate performance data for a
 region
Message-ID: <659748504009c_8dc6829435@dwillia2-xfh.jf.intel.com.notmuch>
References: <170441200977.3574076.13110207881243626581.stgit@djiang5-mobl3>
 <170441210328.3574076.8557138214621981436.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <170441210328.3574076.8557138214621981436.stgit@djiang5-mobl3>
X-ClientProxiedBy: MW4PR04CA0215.namprd04.prod.outlook.com
 (2603:10b6:303:87::10) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB6821:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c1dfb55-3e14-42b6-dd5b-08dc0d8258f2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F5tN5hPzOyq8pyFIzExFrx0IAFSnM7NlYTX/nFTIyhr8J12FBzreitjktz4bgJmyHhwm+uvwBqzj6yuw7iCRX34scQPr/815AeIKbpFCbIQTtXZ1orAYA2X6pzfBjs9LkOC3RRuF1tiGdLJp0XuBIGMvPKb0J5Q71xmF5oACPBbq8ZKHiAFYC6kaUj7LqxGwrSghEt5j+JgRNkprp22SmyWNVj/3C4oG8i45/L0sUa1sVzmr7L1ETE48D5JjSTs3onYKsbduglTNx4Zng704CYI74LqRsUyCl45krpvCYjrh0dYPZ3Q9PK0TrHqCZ/3Nivtug+eDa3qTjxVmdqyVHaB9jBkFhB7CpIllZqtuL2yHOADsMFDis/3jMEO7ksfiip/HS0tmm/VqEsU2bdbw1+FCGoHqLIoSFtGD0GEc0+y+TcqGqq6CQH3REZUmt9xcY/D/gn7rzmHcgxK6fZtLbB+TAb4rOgbAO/UGNI+vuyFx34hC40oICQzCBcz4lEtUFTruRuCbbnOt9xc4qaoXU4dsFY2oN8ndAvB2pVA/wUffvMdbYLZLDLXZGHFcji6E
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(366004)(346002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(66556008)(26005)(2906002)(83380400001)(82960400001)(6666004)(316002)(8936002)(8676002)(5660300002)(4326008)(41300700001)(478600001)(6512007)(66946007)(6506007)(9686003)(6486002)(38100700002)(66476007)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xj7mUrQ5QcwgWc0NUzCf5Qd85OICzIaAwVhyR5gDuAaOghhRcJuzKOMzZXuT?=
 =?us-ascii?Q?Amm6BQZPagIzByRDRjZIuxwCJs3eGLec0gJ7Y6J/Op9TucAKNDk2H8XgAeGO?=
 =?us-ascii?Q?Y4Pn+RKDrGS0iiN2t01UqFT0j5xv99lTVGluISlSGCP2+OjF8yobhjUug6ir?=
 =?us-ascii?Q?vk4vNAHKCN6htofWiH14ywzabLCH99YgJMm3qyBEsWctokACvnWsAnY3bFwG?=
 =?us-ascii?Q?PqhRuixkKVwxLsQZVuSfa1twsO+7OY2Xmwptkf8jomeVZjU2+kJbCJBsuiT4?=
 =?us-ascii?Q?gYRLHU5YRbDQbVK83KIhMGRmNShZXs542xch5jFE7wlVnquohjkSBKm+X0W/?=
 =?us-ascii?Q?EyxdX5uFZNj37njgPDMjgLXjLufIeDu/rvSDK9sGDE9NmT0HWVImPoJ/25/v?=
 =?us-ascii?Q?71pHnX2BdMPLKRNgSNAOouah0mBGLk7b2KUOovwEAgCzbjC+XUIee1JvB4SU?=
 =?us-ascii?Q?TxQQyUO2RJJYcd3yxClfG2J5Qc22/KV9rdN1YpIEGNR2WORyLW19tL0XfakY?=
 =?us-ascii?Q?h/OQePRqzX5+aFRJGgMGdL2mrwfTScwCYd8DdbSGKuuFOzRuYayH7w0GsGqQ?=
 =?us-ascii?Q?amcDyd6NLKoa6UGmvbSQamjjdExRpW2KrPMGfYwhGkFk8udfxdykGXvLfkF6?=
 =?us-ascii?Q?heH6T651Pcq4YkWXUhYhjBOWXGmElAbT0IL650SUgPLsa92WWmsBSHOhoFZV?=
 =?us-ascii?Q?CMeLS1HRFl6XjftCLNteNIw1PJrwGjz07QlS9yKkwOvTbGA8Tc4YAtryHSAQ?=
 =?us-ascii?Q?/2KIUBSK1x06qnaH7VKJhZDCNrFJC2oOcno2OwAhi7kJrOd/ra5PaF1khPzd?=
 =?us-ascii?Q?OJwEZ5WFh6QYL6GXRG9b1Z4nfSW+nf/mC2WP1/CcxIA0O2INura8lT3JhuGC?=
 =?us-ascii?Q?apNtOLOpvBDnDmkbKx4e6cSsPxUAzH97wG7HwQxarPN97DWAStZFvwIcuPXa?=
 =?us-ascii?Q?NmO+IgUkWmrg5dKjxOhcrrTdE1CXLxwDvyU1SpwPAEvnxhjNnCZtBCi+dyvR?=
 =?us-ascii?Q?tfGOuzwqCED2DoBXiDAjvD0013cf08ZYodf+eXRdR0P/3KBqFj7EGSiPZk3u?=
 =?us-ascii?Q?N9bV62OH4L8l4u4XK77vhZ4/iCfLSNYdi9y5ppMoojAuXhfFeMDY3HtuJJJs?=
 =?us-ascii?Q?yJxgXtTcyCaJLx0KIjdvOfQE0A2GAp6tnksWaE+GSL9DRhJgXTRqZfiPCRpl?=
 =?us-ascii?Q?odw/hHzt6E1fK7IbdoEJ4f1MWbeTkcZHw+gAbfqxVOjelz/h4P5gpyfjzu87?=
 =?us-ascii?Q?N9sJA1+DA6f00TUBwNc5Qw0HyvvI4Kkbbwu/BJrHE7cbvWI1l7LRpCHIp2Xz?=
 =?us-ascii?Q?t2ykbHnDPi/fma4PK1Bj9cJ6cAkESOdpdTZBz7WQZK3ufLArfjN3hh3Vj/Bi?=
 =?us-ascii?Q?+71NjNfZTa9pvgU5mLcy3TLkRLC+GtiRf8PkzG+qSBJJavXV6rlGbGyGdowk?=
 =?us-ascii?Q?83QjnA5OoefivTsg83cKynLZt31tku1oYIZynkliXftqEd2nNyF/7KzzXeOr?=
 =?us-ascii?Q?rLh6E/R79O5ixgi7LKzxxQPPU9f0OekIVOkhIlTj20KuELgILt6bn28bXJAj?=
 =?us-ascii?Q?XN1SbXv3Y+m3X2Fh4Tcx9eoKtj1B8PNMGPEBwMUWDTOK3jD8csXw3n1bTp7D?=
 =?us-ascii?Q?cg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c1dfb55-3e14-42b6-dd5b-08dc0d8258f2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 00:07:47.0215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xv7qEU7UAQSfwIYfSdYBlRYpGUyt1qfu06LG5BYIktmBv8i+SFNm/rcU0rLLM6jepF/+ffRgHS2Od8tzBJxBt5kht09TX/JI2Fyc2sQlBLc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6821
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Calculate and store the performance data for a CXL region. Find the worst
> read and write latency for all the included ranges from each of the devices
> that attributes to the region and designate that as the latency data. Sum
> all the read and write bandwidth data for each of the device region and
> that is the total bandwidth for the region.
> 
> The perf list is expected to be constructed before the endpoint decoders
> are registered and thus there should be no early reading of the entries
> from the region assemble action. The calling of the region qos calculate
> function is under the protection of cxl_dpa_rwsem and will ensure that
> all DPA associated work has completed.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v3:
> - Clarify calculated data is same base as the coordinates computed from the
>   HMAT tables. (Jonathan)
> ---
>  drivers/cxl/core/cdat.c   |   53 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/region.c |    2 ++
>  drivers/cxl/cxl.h         |    5 ++++
>  3 files changed, 60 insertions(+)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index cd84d87f597a..78e1cdcb9d89 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -515,3 +515,56 @@ void cxl_switch_parse_cdat(struct cxl_port *port)
>  EXPORT_SYMBOL_NS_GPL(cxl_switch_parse_cdat, CXL);
>  
>  MODULE_IMPORT_NS(CXL);
> +
> +void cxl_region_perf_data_calculate(struct cxl_region *cxlr,
> +				    struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +	struct range dpa = {
> +			.start = cxled->dpa_res->start,
> +			.end = cxled->dpa_res->end,
> +	};
> +	struct list_head *perf_list;
> +	struct cxl_dpa_perf *perf;
> +	bool found = false;
> +
> +	switch (cxlr->mode) {
> +	case CXL_DECODER_RAM:
> +		perf_list = &mds->ram_perf_list;
> +		break;
> +	case CXL_DECODER_PMEM:
> +		perf_list = &mds->pmem_perf_list;
> +		break;
> +	default:
> +		return;
> +	}
> +

Given how far away this function is from any refactoring that might
happen in region.c, and that the locking documentation in this changelog
will not be readily available when reading the code later, it would be
nice to "document" the locking here with a:

	lockdep_assert_held(&cxl_dpa_rwsem);

> +	list_for_each_entry(perf, perf_list, list) {
> +		if (range_contains(&perf->dpa_range, &dpa)) {
> +			found = true;
> +			break;
> +		}
> +	}
> +
> +	if (!found)
> +		return;
> +
> +	/* Get total bandwidth and the worst latency for the cxl region */
> +	cxlr->coord.read_latency = max_t(unsigned int,
> +					 cxlr->coord.read_latency,
> +					 perf->coord.read_latency);
> +	cxlr->coord.write_latency = max_t(unsigned int,
> +					  cxlr->coord.write_latency,
> +					  perf->coord.write_latency);
> +	cxlr->coord.read_bandwidth += perf->coord.read_bandwidth;
> +	cxlr->coord.write_bandwidth += perf->coord.write_bandwidth;
> +
> +	/*
> +	 * Convert latency to nanosec from picosec to be consistent with the
> +	 * resulting latency coordinates computed by HMAT code.

Do you meen the HMEM_REPORTING code? Since access_coordinate is parsed
from HMAT data, it isn't the HMAT data directly.
