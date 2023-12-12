Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hNUa0S8w"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B59A7
	for <linux-cxl@vger.kernel.org>; Mon, 11 Dec 2023 16:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702340399; x=1733876399;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=k14njk/rm0pOH3lHZmEaeFpA2GTJ+1uLlD7uFC7kKCQ=;
  b=hNUa0S8we/4LKmcZmDGRc2vnVwwtwXtEBynXmo2vHT8TApxCkO1OJqqo
   UYX3RpqaoHXGcPdXn/1zWLm1wjl9JvJU2N8LZ8O1YjPr3PeaslMLXqUwy
   tAtk5fgrkpBN5o1oyuD4iunnGzDGTI8G5nnlyWKVWAdyrGlrzHkuHhxze
   FQ5yHQcPrQ04vCbhxkK5u56MIYfEs25ZI3Y1RFbhnI/lP3O2vPPwKMYvp
   02rh+lDtpQo0A5EZkSSpzKiqKHkrKHdOthUSc9RLgWMYoI5hJp9xQAfCC
   jiOatXEq25dQnR4ZQ6FEapfh3st7Dx87YzHnQctFWQR3yR+/yKA/0T2pq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="1546293"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="1546293"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 16:19:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10921"; a="946536368"
X-IronPort-AV: E=Sophos;i="6.04,269,1695711600"; 
   d="scan'208";a="946536368"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 11 Dec 2023 16:19:59 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 11 Dec 2023 16:19:58 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 11 Dec 2023 16:19:58 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 11 Dec 2023 16:19:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SCKU7MESoF5S/jJxPsdnN1DHAfVmCeqchfqAJ9vIBGgVIsV324t8epkvpbLGr9ZWLxvtJLVJSWTBt4ohTHbyYhD8En48M3O4GZiywHQEzxJwXNtxkhzgBPvgwy3IWWHXgtmoN5qBA6mUIf+9EqaKk1GPAiFOqn3EQCuFXfm9DGtAMciwD/rAcmxRm0fJ56RZHdob8gaj3yxOqOuUOVasvK6i6eCXcEQnJjdWLUODe5iQVgOOFS9sGQSXJyB7BGPfARyoEYIIPcQtaUTBKF1dW6ZLj1bL68JIvDFDMZ9p1WGzeUh3YehSSdARZK7NqSRpP+gbchTE1EdfXxBejUJw1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NqwuzDmXow/E+EMRkpfdZEqrPjluHi+rMrM0kredXk=;
 b=IXVHVmebbnNY0DVml1i7+r7JxkZDEsSsx8KMfNQ03vnaq7WKiUKkN4wElhxoEiRi6/57u8L1rPhUHnhPk4umU6P04dewCrhcy2Lyhvb7q8IRpsC6ssJnexAgs0C3MLUyqE2oXT6exsJCA+6cuRECoOJoqqY37jC5gvFPk2717OxrlbjQPwfhYD+PYUXaN3O2o7mLklb/o1KjxqFlSmxYc1GFotCilYP0IPAmhLxTR6BbtiW7A+weVokV5oNDIxMyRtc8GHpXUIPVdeEJryQK8W4FBJEiQBhw9JVOfZGIyohxcBvBhWqOnVhA3fmMEZkWfzsd7EsMpYI4ZodFz4EOjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB7613.namprd11.prod.outlook.com (2603:10b6:510:285::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 00:19:53 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7068.031; Tue, 12 Dec 2023
 00:19:53 +0000
Date: Mon, 11 Dec 2023 16:19:50 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<jonathan.cameron@huawei.com>, <dave@stgolabs.net>
Subject: RE: [PATCH 1/3] cxl/region: Calculate performance data for a region
Message-ID: <6577a726a3102_a04c52947d@dwillia2-xfh.jf.intel.com.notmuch>
References: <170199184936.3543815.17537965163543815359.stgit@djiang5-mobl3>
 <170199190986.3543815.7111880145751330916.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <170199190986.3543815.7111880145751330916.stgit@djiang5-mobl3>
X-ClientProxiedBy: MW4PR03CA0157.namprd03.prod.outlook.com
 (2603:10b6:303:8d::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB7613:EE_
X-MS-Office365-Filtering-Correlation-Id: 48ad5b90-199d-4fc6-ee4f-08dbfaa8100d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0pvtDUGP2PIR9CkCyoBwK8HM09m493tizd9pVM2HH/o3oo5z03Hsx6GNpFRvnErCFtXR30KK5M82IFbSMk5c12A6HeS1LBpkZwqFPLSUFllIe12VHFw3taWzpqfeogsWrOr5cX6gZXPgRTr5V1ZwLyfB5IG3l4QW1N4Bkq6n7Jy4QMrthDCielUIqtErimMvV53cDHwEtZVZ0PsVObRo1oRrPkxp6V0TJJBzOKSMNOhzogr9m0H0zQ6W+YCKkB2KvtZBWb3Czj7urmXVZukT+NAJ/d4crKElz8PwQ21Oyfet4wVCkVF9kfr+EdPQHHxQ9Zr8pm6fjhdgkS6NkT7cnRkfyjCcfO7yfhprgSTz3qKJYz1LIjNDSwp0tyB197oolDkSKtvCyH3LGYhNkdklJgB81vQB0Jtxa0HJBrSvnRciKjR7Z++aNMDNmK/KvOnsH669K6pgmzfC/SmC6nsidYUuGMj/XzpCalXfOs0bRE5DQJWHEvJPMMRy0jTydj15Qrtm1UDjF8BOMgFX6nnEJkKr4d+VM/yB7+Uo0li63PkQdApVcCXYfWbYxFI1qaQ2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(376002)(346002)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(6506007)(6512007)(2906002)(66556008)(66946007)(66476007)(9686003)(86362001)(38100700002)(4326008)(8676002)(8936002)(5660300002)(316002)(478600001)(6486002)(41300700001)(82960400001)(26005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dxdX9rPZCkmNNLv3DSnXSihA+0IlVLGjLiju04jNLEfLqFmwpf66IUs3nr1F?=
 =?us-ascii?Q?cDqTm0NxfKVRqdkWkDkAfO9TQk6latXtC5CJarXIZmELVDFISCY62Br568NW?=
 =?us-ascii?Q?gpoi3KQX1t9i01tcYX+l7lwPgWmbdXp1v9QO5j++2FVQmEaAsnb4zbE5LASm?=
 =?us-ascii?Q?ZXkrlAdeuqfyedmRrHAwIxJyAMCiOtclolb/uDEeoGt0al/MSW1LgTvYv0tm?=
 =?us-ascii?Q?xtcSL1IQfPyk81Bde0Wy+VYzYABfvrho3vvQUx3v8NuqTQGvhTL2EdL0L0Lo?=
 =?us-ascii?Q?1uR7GONqeMH0fEb9CCSQCzJ3sGDKrGS13jOs3+tfzkYNb27bdxyg+qWYBqR7?=
 =?us-ascii?Q?MpUnV7jysvj5y3dHMQ45BEZdXU08jZb/0asTC10JvFNsG78r2xf70NAKKl4l?=
 =?us-ascii?Q?50fzNnFeoMtT9Etd7m/tQ+7kISs7bNtN+E7xtGhENJpWTYtwY7u76Z0B+sX+?=
 =?us-ascii?Q?d41DGrFLcqYi9uiKwLW7niExYbrBqvi7birw04+iv8nVorbM20c1oHJqPH2z?=
 =?us-ascii?Q?YTcLguFfsmKdYLZUnByxloZgPEgK6R567S1jCmlz9tM4d7rR940nYsMeIIMb?=
 =?us-ascii?Q?3IGB1lpB5MhtTBPCq+KofiwnR4RiSIJSxDpp0wMKsW5DyMJ4c70CHVREP+Dv?=
 =?us-ascii?Q?+pc2hER+rFlc6v1RokkeTD7EOKJkzY0w+jC8HK8mb/sp2RUPqwYj6/yCW15R?=
 =?us-ascii?Q?pjdpin/32Cj2k6eSOgNGQpUSt0PpqZd8EqUYEVrWRij0XRi58nt8ZFoebD9u?=
 =?us-ascii?Q?4Tea0lOIbmBB38mT32/VjgWjghvHppTAb39lPsbBMV4I2IR+QU61Uqh13laB?=
 =?us-ascii?Q?KsuI1O6/DOvkbq7Eh8jnhTpYSF+lhNoO7I7HfycyCDlmLcRPewDEA7q1MY1k?=
 =?us-ascii?Q?9dFvmWHNEOnudJIbeNWZWXVkZF2BLu/65RGvxM2Lg1oLrioefAQTFwxf+3zz?=
 =?us-ascii?Q?gqjg0Er3pbUQcmKd8P85NN0W3mw9s+/l/LXpB5HjhVx285x5NUwtpLiN8lb9?=
 =?us-ascii?Q?eFBIc+YzyJAr8y4yjA4cC6ipMjHTiSPcbyUutbcaepGIUYiCM/BdiQJkuiz9?=
 =?us-ascii?Q?vdT2a0eQVluMb6OroNR3LP3Ax8A0pgReKmK0ObbUquAlop4b3CDmJvn4r3Wy?=
 =?us-ascii?Q?mfCwfQHx06ZUx4GBvs/XM8wHlK+blr0x3/b8M+xMlyVGOEcoav0P3ZLWGEu0?=
 =?us-ascii?Q?yb5t836FSYaxC13uhzRxD7Mqx+3SXubUr+LWq7TZH5AoQ2ewHeg6LpdZ/5ve?=
 =?us-ascii?Q?NmuEtmB+WxU5FSzoanynhBa+D6f6pxd3w47JgLO1xry41ZI5jcBdkgz0IVs7?=
 =?us-ascii?Q?/8a+TwmHmE6O/aF3B4wlglldwh/Ddi8kqk3K6PBd/DP01uhnSw+Q/SjZKkVq?=
 =?us-ascii?Q?Bi7lTQf9MO4f8X3RCThFyGYeU2NFwqnstsPVKruAbat51NHed8MQlwSnkYs1?=
 =?us-ascii?Q?4v3mnpABoqta8ZU56Apf2qqqj+l9Rxnld3mVlBhd2R/AATBVnJApidM1ZhWY?=
 =?us-ascii?Q?rh/0UL69d6W3ho4EZ1wUDVEpzi4wNFjjZtYzo1Vm+esBRk3fPx5S0QJwlG5p?=
 =?us-ascii?Q?uSAY7E41WcMm2uUqqIhPlY9YOON6poQqLReLktTZw0BlHtcjhojPY597rOe5?=
 =?us-ascii?Q?TA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 48ad5b90-199d-4fc6-ee4f-08dbfaa8100d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 00:19:53.4973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e6Og/6ZHZHcyxNNKXqyp+94X7dhJFNvEGZEjE6Ktk/0GcVo/uSIHVxWIW0QRd2btLnV9SC2CxFXe546rtmPfjQvtSMIagq3BfZ48EWFbUMg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7613
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> Calculate and store the performance data for a CXL region. Find the worst
> read and write latency for all the included ranges from each of the devices
> that attributes to the region and designate that as the latency data. Sum
> all the read and write bandwidth data for each of the device region and
> that is the total bandwidth for the region.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/region.c |   94 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |    1 
>  2 files changed, 95 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 56e575c79bb4..d879f5702cf2 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2934,6 +2934,98 @@ static int is_system_ram(struct resource *res, void *arg)
>  	return 1;
>  }
>  
> +static int cxl_region_perf_data_calculate(struct cxl_region *cxlr)
> +{
> +	struct cxl_region_params *p = &cxlr->params;
> +	struct cxl_endpoint_decoder *cxled;
> +	unsigned int rd_bw = 0, rd_lat = 0;
> +	unsigned int wr_bw = 0, wr_lat = 0;
> +	struct access_coordinate *coord;
> +	struct list_head *perf_list;
> +	int rc = 0, i;
> +
> +	lockdep_assert_held(&cxl_region_rwsem);
> +
> +	/* No need to proceed if hmem attributes are already present */
> +	if (cxlr->coord)
> +		return 0;
> +
> +	coord = devm_kzalloc(&cxlr->dev, sizeof(*coord), GFP_KERNEL);
> +	if (!coord)
> +		return -ENOMEM;

Why does this need to be dynamically allocated? It's only a few fields
that all regions will likely have, just include a 'struct
access_coordinate' instance in 'struct cxl_region' and check if the
values are non-zero (memcmp()) to see if it is initialized.

Saves a devm_free() error case.

> +
> +	cxled = p->targets[0];
> +
> +	for (i = 0; i < p->nr_targets; i++) {
> +		struct range dpa = {
> +			.start = cxled->dpa_res->start,
> +			.end = cxled->dpa_res->end,
> +		};
> +		struct cxl_memdev_state *mds;
> +		struct perf_prop_entry *perf;
> +		struct cxl_dev_state *cxlds;
> +		struct cxl_memdev *cxlmd;
> +		bool found = false;
> +
> +		cxled = p->targets[i];
> +		cxlmd = cxled_to_memdev(cxled);
> +		cxlds = cxlmd->cxlds;
> +		mds = to_cxl_memdev_state(cxlds);
> +
> +		switch (cxlr->mode) {
> +		case CXL_DECODER_RAM:
> +			perf_list = &mds->ram_perf_list;
> +			break;
> +		case CXL_DECODER_PMEM:
> +			perf_list = &mds->pmem_perf_list;
> +			break;
> +		default:
> +			rc = -EINVAL;
> +			goto err;
> +		}
> +
> +		if (list_empty(perf_list)) {
> +			rc = -ENOENT;
> +			goto err;
> +		}

No need for this check since list_for_each_entry() will already be a nop
and not set @found.

> +
> +		list_for_each_entry(perf, perf_list, list) {

This looks like a potential race / problem as region-sysfs and
auto-discovered regions are allowed to start running before
cxl_qos_class_verify() runs. cxl_qos_class_verify() needs to be
done with its work before any region might see it. It needs to be the
case that these unlocked walks of memdev lists are ok because they are
known to be stable for the lifetime of any region that might read them.

Somewhat glad that we never went back and added support for "immediate"
(CXL_SET_PARTITION_IMMEDIATE_FLAG) DPA partition changes, that would
make all of this that much more complicated.

> +			if (range_contains(&perf->dpa_range, &dpa)) {
> +				found = true;
> +				break;
> +			}
> +		}
> +
> +		if (!found) {
> +			rc = -ENOENT;
> +			goto err;
> +		}
> +
> +		/* Get total bandwidth and the worst latency for the cxl region */
> +		rd_lat = max_t(unsigned int, rd_lat,
> +			       perf->coord.read_latency);
> +		rd_bw += perf->coord.read_bandwidth;
> +		wr_lat = max_t(unsigned int, wr_lat,
> +			       perf->coord.write_latency);
> +		wr_bw += perf->coord.write_bandwidth;
> +	}
> +
> +	*coord = (struct access_coordinate) {
> +		.read_latency = rd_lat,
> +		.read_bandwidth = rd_bw,
> +		.write_latency = wr_lat,
> +		.write_bandwidth = wr_bw,
> +	};
> +
> +	cxlr->coord = coord;
> +
> +	return 0;
> +
> +err:
> +	devm_kfree(&cxlr->dev, coord);

Another reason I do not like open-coded devm_kfree() is because it is
not supported by cleanup.h and still needs "goto".
