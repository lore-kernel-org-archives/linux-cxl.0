Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EK3gGnnt"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40C41713
	for <linux-cxl@vger.kernel.org>; Thu,  7 Dec 2023 15:35:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701992105; x=1733528105;
  h=message-id:date:subject:from:to:cc:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=StWB0UJuzWuQdgHtpBBOEsDYB6/UF6jNiHPA5v7lqLc=;
  b=EK3gGnntZIlsJhld+uW/OEz1dbVcRjsMKUS1+0iFXYAyi0K0NCgPa7o4
   jH8VnSU2Nng8iyDYgWryQE4X7BMe4uJL2aFrzO2Ruev5BTy86vJBuFYKU
   wgIdd1RwxoV/8gmovpRcxEhIJ4dPhNcJ8uimb6Fty0+PzUqltJ52ZX2dg
   bAgG3C0ZcprOIkZFvhX3+ITYNBSROzj/zQUhSjQ3hU7muHmyDAtpqri7o
   lj7neeZu7YQiTKrMc7ur2QW32XocfeJERgsUsPX6oBkQG7B/7WcwYik5S
   zoE1CcRSsN9nu2aLAJFrYq6aZ43cK/Nqan69tlTfQO/Yye3l6SIbw7dQI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="1406238"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="1406238"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2023 15:35:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10917"; a="862664798"
X-IronPort-AV: E=Sophos;i="6.04,259,1695711600"; 
   d="scan'208";a="862664798"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 Dec 2023 15:35:04 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 7 Dec 2023 15:35:04 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 7 Dec 2023 15:35:04 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Dec 2023 15:35:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfuOjgd0m9XlXHxHMlDTUiKH/VNo9U/2ykeTbJq8bahi40RPl2u8NBMkffSlahEYM0Wk53VcL21So5aeWTdJNe3S760VcxSnGFO01p+W7rl8EWAyOhGWhSZARx4jCuqE1FO+5vyP0QEfqIi3o5Elpf/UUaLUM7do0h0KHts69zrgWbMBbgbEkzGODXSad8IBOnRCaeSJNYZanO6+l7lp3XtwsyePCE2DfwGvgFC74QrXrZRTMYkM/v97zimm6VDtqEeHz6T4JlP7kyPgPEeIBhzSj7UyvlH2BCZi3aeaDnV3G3f+hqqoalk2fq9g6HtBLNoI+c0hxpSSb6oLCW+LHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tFd2JKQgPqR2Cc974/I1Ir0YtsJCgkY7UkT5hDuZzUk=;
 b=nAeYnOrAFHPtXJpAytvyMR1U7SWDpbssXJKh8NvWzNgCN+CuxX3aUPmGDyc/GsGsvmew4qstAZtbjfl2dbxJh5TS23Udod2XtjFrc6ZQ6dd9wHakECHAp6g0CLOVj7JXMWAF0A/CjEs81KccDr4QMRTAlEnUOfbx+ToedbOILM7R9L0QgivjqtlWjlUjg0C09dDu3mvxPnXrG1jy0zm7q3gVCxH2V4DzSiPePVaMxY9Y0sdvIhQWFXJgvexyKZS4EyeED36pLpAm9tR6SmfUR6lUXSK4i+WuIPEk3QGfg9putqjvMczsNRphVJ7leFvmM8Eq2hLybloOl62Fe5zHMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by IA1PR11MB6491.namprd11.prod.outlook.com (2603:10b6:208:3a5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 23:35:01 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6f7b:337d:383c:7ad1%4]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 23:35:01 +0000
Message-ID: <5cb208da-8e49-4672-abdf-0c682ba4c1d9@intel.com>
Date: Thu, 7 Dec 2023 16:34:58 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH 1/3] cxl/region: Calculate performance data for a region
From: Dave Jiang <dave.jiang@intel.com>
To: <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<jonathan.cameron@huawei.com>, <dave@stgolabs.net>
References: <170199183593.3543732.2735037388423785616.stgit@djiang5-mobl3>
Content-Language: en-US
In-Reply-To: <170199183593.3543732.2735037388423785616.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR02CA0019.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::32) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|IA1PR11MB6491:EE_
X-MS-Office365-Filtering-Correlation-Id: c827fced-2132-4983-414f-08dbf77d215d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KK2f3N+hPpU/rKWgZNAFWOfSfZgZ1dPPB4xIjoW1JCOVdCYhvi2ugq+mITtOuSzqsadHUA5FqfjBnNZa+ES2sFNEWNMcCF25ZccfulnqVteSg32CoRHo1OnZ2itkCzUmrXvWLGjxmMaoIItMBDaNrJ6MWESRa5WLy0JdOLDtZhJ5ZoRu0BoHkoaceXluAXLVjSJx/PYzIXtrIn5erUKE9o3L/hS2Fxv9c615kJCbipn4XfexIQWzQyzRHG7CD/e1FjR8blxLbnC7qbfNfKHJ3d/l2991+S/8224AFrplJl4OB/YHB0W1H3d958BDA7U/+VFLK3YSqkq6widpYI7Dt91CefLKmvROGpNbn0wN1j8AI9BRKUxEFH83LiP9Qn3KME/J4Hs4a3v40Woe3sHg7rDWE8UIbnx+4NLUURx/Csa2+lpXF9Wn+SG1B7JvNq1yk6fLw70AhRKGgZRNLPN0Lb68aTd2g+kUF5ekq2EhMDik6AmigTL3H5kSwvhQfuPR6QpX6GtB8BF/K0qEgakC0J5KvrMm3WETer284un1MdhxOKIGtDA4NwIs1B28y8jkXIOEbKToZj13Nc0Eh/+ns7NrufQLFp0vjWz7p95a73xF0htccGTwY4XLfMtuYfsb
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(376002)(346002)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(4326008)(2906002)(8676002)(31696002)(8936002)(86362001)(44832011)(5660300002)(36756003)(41300700001)(83380400001)(53546011)(82960400001)(6512007)(6506007)(6666004)(2616005)(26005)(38100700002)(31686004)(66556008)(66476007)(6916009)(66946007)(6486002)(478600001)(316002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S2prbFdWdTd3UU5jYW9jMHZDWVdBRHloYU1NcERyUHcydTQrWnE3NVJBTVla?=
 =?utf-8?B?WUV0bWdkTUEyaGVvcWNSSUFqWDdxMDlpTTBsSVJIMnpzeWx2dXRJc1h2MkUy?=
 =?utf-8?B?U1VyNFJmSVF6M1NEZlA5WlhBYUpPRGpvVWd4Y0hKdUNOd2hOZzA5NE9pMU52?=
 =?utf-8?B?elJvcHE4U1JxL2xrVml6di9zdGlpV3BpUk9INjNXVnlLdHFZSUlrQUZWS2JR?=
 =?utf-8?B?SWNZL1IvKzFVWEJvaTdDN3RQY1J1NWUzUXhWRnJib3NZK0NJUzI3SnkvSWh6?=
 =?utf-8?B?NHRzSndmT0xUbDgvSmlLYlpMSFYvVjZtZnlob2RHMEJ4RmIxUWF2KzNySnJ4?=
 =?utf-8?B?aW5zdWhCeFZFdXlPSmVSQ0I3V2dldzhpa3hyUWd0b3pYTGRNOEFhdHhJN051?=
 =?utf-8?B?NEZLM3F0SW92TkQwZThzRGV1N2tpaGFLYzVDb2k4cDBPU3BnS084aXBmeDJi?=
 =?utf-8?B?eWtmbEJ1eE9jRmVpS2o2OUk0NDQ2UFFHTEU1Z3FOR252Zk1xaXczNjN5WEFJ?=
 =?utf-8?B?NjNVcWhzVDNyOEFDWERmaFI4aE9SUk1qUW5JUmVodUsycnZLZE1mNlZnOGhN?=
 =?utf-8?B?eGxxWmJrRm9UUk1FWlBwMGZzbTFrV2lNeEhJZE9wTHRiUnNuVHQra0J3WWxK?=
 =?utf-8?B?eWxqVUVZcXlkSXZjbjJ5TjI0T2hyV2tyeEhPaEpXa000V3N5RG5hVXpIejZQ?=
 =?utf-8?B?T2szdWpLaUJWRGFjbVdDTDh4R0x6a3gzVWt3ODlWVWpBWllDL1RVOVlBRFVm?=
 =?utf-8?B?WXNmdENsNTZJVXlTM2F3VndudVhLTlJFVXJXZm43NGsycVM4K2NiYTZCTStj?=
 =?utf-8?B?c3JVYUM2K0lQSXgyVGNYMHNKT1N6N1k3VDlyRUdhYUEwbU5DMlFSSHpkV0t6?=
 =?utf-8?B?UTVNRS9TT1RWUUJPSU90bVpJSnlnME1oOFJQcGlENEVXOE1XU3N2dTlsazBo?=
 =?utf-8?B?V2lObkFUQkZFZFRsZWIxRFZyQk9QSHVjTnNFMVhjK2xIUEE4UUFJQXpiaVJZ?=
 =?utf-8?B?T1lUSktqTXVlSlcyWGhWbXVZUytVcU5jVm5IS2hCNkRCTHYyVXhOaHFJaWIr?=
 =?utf-8?B?VGtWc2p1b3FkWTZHODJCVFpvSCtDMUJnSkQwZStsM3l4dHlnNGNQUG5TZ1hI?=
 =?utf-8?B?MVNjOGNQSzFITE1OZjgxWllzU3gySWtSUHNlTUxoZjZXbjN1RVNSZC9sbW5q?=
 =?utf-8?B?WTM3Sjg4VWR0UFRRdlNUaGNURWxHWTdLczlnbVdTTUNLU3B5UmJSSUQzQkhi?=
 =?utf-8?B?LzVsMHhVY3JxSHpLSmR1b3pYK01UQmJrbkhGMldka1hmVEN6VDl4bUhUMXg2?=
 =?utf-8?B?d2dLby9NZVJIVERpVHJKOWtWWlRBcE95bWhkcjJ2S05mZGtpNzFlcHp5S0tv?=
 =?utf-8?B?VmZjaU91ekpUd28vVHNtbUlROTNmdWxKZ2hxSGVpcUFiTnNISDhycDNRMThw?=
 =?utf-8?B?ell1bXZianh4RWpWZFpyR3diSUxCR3dTbVF1cHl6bjFWSmJpQTZwT2pva3cy?=
 =?utf-8?B?L2xsRVlLVlZpNVdZQTRIMkVIMmpFZEZGVVNDQW4xY1FBNW9VeU9tWS9KUU45?=
 =?utf-8?B?bWdweUwvbGVYUlFiZ1o0ejBPZ29laXFrZUpKd2VxR3ZtUUx3Y1F2NkEwRWk0?=
 =?utf-8?B?UGZzbTFCemFUQkNqb3d4Y2NpMWlaNDUxdGxDd3pRck90UUU0VGFpTVg2SGhB?=
 =?utf-8?B?V2diNmFyNVhnNGR6aFVmTVJYNjB4UkIvWEVESTNhbVBRaFVWcDVkUkwvRGxD?=
 =?utf-8?B?a2o1cWNIU0FhSkhnUFN6S2NucnpYU2YycUx5T2pXSm8rRk5uaWljQlhUSE16?=
 =?utf-8?B?NW92MHNuQXpaaytEQUlyTU5wQWVwUThpNFkzd3d1WnhEZ3F5SGdiMXRiR0Ur?=
 =?utf-8?B?Y0xjNkFWUnFvN2pvWFZFUFpwRDY4TUx4ZHZZbkpSYVRrKzNUZmY5VkthdWNJ?=
 =?utf-8?B?NHVEZVRmYkdMT01YZlQyQVR6VDd4VmxmYmdmekk5cS9INDFEQ0FvOWZjOExT?=
 =?utf-8?B?a2tvWXZiMHNMUHhpSDV0RWZUUzNqU0xLMmJaNlZ5WE55OVlVMFU0eWJNdEpp?=
 =?utf-8?B?MDkrRlFwcE1ZckRxZStqa3Yxc1VnSi9KL1pudDVYZ2pyOHg2dG1abUJ0UmJw?=
 =?utf-8?Q?cNVpyP+kMcZIts7zx6SVkwQ0i?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c827fced-2132-4983-414f-08dbf77d215d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2023 23:35:00.6997
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lc0hwfuU7Z1nmfFCEV9rYtUTMeIDPSLGInlu2Y4gj4+dQaYZ08WZAELUgaXARWHaEwG1MYxsjEhl7q0lUwCuZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6491
X-OriginatorOrg: intel.com



On 12/7/23 16:30, Dave Jiang wrote:
> Calculate and store the performance data for a CXL region. Find the worst
> read and write latency for all the included ranges from each of the devices
> that attributes to the region and designate that as the latency data. Sum
> all the read and write bandwidth data for each of the device region and
> that is the total bandwidth for the region.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Please ignore and see the series. This was an accident. 

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
> +
> +		list_for_each_entry(perf, perf_list, list) {
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
> +	return rc;
> +}
> +
>  static int cxl_region_probe(struct device *dev)
>  {
>  	struct cxl_region *cxlr = to_cxl_region(dev);
> @@ -2959,6 +3051,8 @@ static int cxl_region_probe(struct device *dev)
>  		goto out;
>  	}
>  
> +	cxl_region_perf_data_calculate(cxlr);
> +
>  	/*
>  	 * From this point on any path that changes the region's state away from
>  	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 004534cf0361..265da412c5bd 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -529,6 +529,7 @@ struct cxl_region {
>  	struct cxl_pmem_region *cxlr_pmem;
>  	unsigned long flags;
>  	struct cxl_region_params params;
> +	struct access_coordinate *coord;
>  };
>  
>  struct cxl_nvdimm_bridge {
> 
> 
