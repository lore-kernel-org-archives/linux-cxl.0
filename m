Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BD326AC0
	for <linux-cxl@vger.kernel.org>; Tue, 14 Nov 2023 18:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F2blvBHJ"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79D34121
	for <linux-cxl@vger.kernel.org>; Tue, 14 Nov 2023 10:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699986063; x=1731522063;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mTDSe1UZi0sS0YSzSpKeQwYZjzJ2POVYdIy2K2b1WGc=;
  b=F2blvBHJ09+Nj5hJECNp4lErkWB0c9ODT1r9NP1L6EoKjETB5kL5kXrX
   jJT3+cQPKgM8gtZZWcMvNOreH2O2XVLj2Ck8le1JzsY9+Iwl1t2P4bFpW
   qYjUYrFjPkJewrhy4+LdKsPLYnYf28d5OLKbDKWCXl3Vnaz6HZVeangZq
   vhtICRmP4oRM65ZSxRP3baUdaIEhN72YuFYa8PNffz2ta6Y7fmwCxsI+S
   3RwSV+O7ztRXW2rh0ZRLaJ79OsNROJhJ6DO0dv3siJx3q3lSIpBocP7o1
   w+NfRY1spei0WqRO2bi5kWoK0sFJey1PwLRmphuEbFqtNky+gfGBgNFJ8
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="394633180"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="394633180"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2023 10:21:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10894"; a="793882792"
X-IronPort-AV: E=Sophos;i="6.03,302,1694761200"; 
   d="scan'208";a="793882792"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Nov 2023 10:21:02 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 14 Nov 2023 10:21:00 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 14 Nov 2023 10:21:00 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 14 Nov 2023 10:21:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ibw65nNkYpkLgCtj6VRcvIs6zFJt+jVUEVOlJJLYtYd/itDjMA/ia07JGolaq5+GHFDfr68F48U7/YfqepEG7T6jMRUA9vn/jfGi1Dh916mptLJKr8nso88fsb5SkwVyC0BhefxPQj1+D5J2K1oxE9u0Kx1cm/bKwGx/rP724v2oI/xba6H1vhkpuZxdOxfVhQhcbdrgATuUYfsLe1ElPw4RpW/OtMNsoc1bYG7LyHGeYv+5798kdG8Kwczy7grCsKKB61AbXu2KDDOkJEmiuUTZ59dXvTXM9QXlUtJsrd9XU5pkUOVYL4LTWz1+tESPKOHZwwsBAHEezff3KITkDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fu7pg5MfbFzHUCTjG1onvplh1meOITTtca+CG1sITIs=;
 b=TGbkhYscOYefSaksjGEz8w4cFQ6VMVts1B8HapmTIJqufZZn4RhCzQJr2QxV7OD5y2hHQwP9AsdApDViPtguZa78Dp170Fkc6vEXX7ej2iuOoZ/JXykdeXzan+7SSvRuLV9Gm0cfGuWnLuDOq4GnlyPKR9tD4VHQpRpCpnQVME6zVYW2FJLTiL4P+kcyXE0pt1WKlawo7yjnnlUfXFSJ7qy3WjcY+emPC9LAaQQCqF+JfN9xdRoTt5TJ9XAeu5LIvS1CuEeSTgjHY7+sm2F7zpxF9GCsbcbbN1oSrH+g+fsX5pk7n7O2CXUat5KVmTNYGpOgBH7Ae+InLw00XcryLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SA1PR11MB5946.namprd11.prod.outlook.com (2603:10b6:806:23a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 18:20:57 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::28a6:ecda:4bb7:2f9e]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::28a6:ecda:4bb7:2f9e%7]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 18:20:57 +0000
Message-ID: <5795412a-6ad4-4333-ab1f-0074101805b0@intel.com>
Date: Tue, 14 Nov 2023 11:20:54 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] cxl/core: Hold the region rwsem during poison ops
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>
References: <20231114025342.1123681-1-alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20231114025342.1123681-1-alison.schofield@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0191.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::16) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SA1PR11MB5946:EE_
X-MS-Office365-Filtering-Correlation-Id: 94e8bf85-7d2c-4b20-78a6-08dbe53e724b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KmueXQ88OKRS5Ksa78EdGsU1f9IMRFKuwWfueXxctYswUoPoeXP94yI0mKZWcEPTUW5AFP8UN6a4RtD6qFyABN6rjU+vjgmMbVi2p27loGZhsikioDgTPkwb9pZbkSHbKbC11wAkdPfTiNxPwHrdrJHw69bansDTYB9rv8BdLcVZg2XLpyNgPoa8+vc7ZXZri00vu4l4+akBLAVR6OP6GrCXOp2bbap+JXuFhSzzFfwi8oSHHrqAFygg4hHXepfsZAKabq0kovC0v/Hn2ahFA8WaFvJDtFLF4FPJljFgHPkQj2vp//aC9oFRbyElb0NGCZcbt8iaR67+YGAxwwkLjcRqBZIoFxgWO/WtpAFUf77TXYQQ6IFKkwEew5vCY/NmLHSzuJ541XHvRaa51IcxJBhmOHyECda91nG9+KU3Xy/h8FpYx8848i6gVjAxI0VwaHbVxgxv/XKEC+KpnKLlI3lnoAfufQtTwqw9vgg+Nsr3aj6dxBsJBKa4l/H6sMqdxS600jrjNT58qstgiv4i1X7T43j0XVqhUDVOXhdNC03LlCSnqJ0HDDdUFDDkY7YeZqrw7+1VaGlSvMo9okY7iB3YIx/BOkLjLqV+WOy4/AjONzktip0cmmmyELWCzwNq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(136003)(39860400002)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(31696002)(82960400001)(86362001)(36756003)(44832011)(6512007)(2616005)(26005)(8936002)(8676002)(5660300002)(4326008)(53546011)(6666004)(6506007)(2906002)(83380400001)(66556008)(66476007)(66946007)(110136005)(6636002)(316002)(478600001)(6486002)(38100700002)(31686004)(41300700001)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MmZSNko5SjA4aS9BWitvV1RMVWVqOVZOcVV5d0Q0SHpEVHVrS0psRGJERUVv?=
 =?utf-8?B?U0hSb3k0RzVEVVRYa0NJZWlJRnJseEtEZnBYekZrRVJDN2VyTVh5OVRFYUh4?=
 =?utf-8?B?NjVUQy82TFU3WDB4UG5hTlhIbmxkaG5tMDRHTGJzQ2hTVmxkbHRyci9DcnNN?=
 =?utf-8?B?ZlVwUmNoOVZsT2NqSWNhZldKeVJ5ekZhRzZyM1RkTjFzdDFhbzRDVml2TEt2?=
 =?utf-8?B?YXZoZ3h5a3lvYlQvcU9YYkRXTG9LUFh6U0wvY256cnFibWxzZk5xU3RsQVEw?=
 =?utf-8?B?Z3NYWVVDaW9TUENtR1A1YVlrSlhlaFRnWWRGZ1BvcG8zNis1emRCcVVVZW5o?=
 =?utf-8?B?T0QyY2Z5bmpyTzlKd3psdk8zTDRNVjh1dXpHU3NkTGhBWks1dEpaNktaTnd4?=
 =?utf-8?B?S3lrYjZRRkVFT21pWXd4V2FmVzd3OHBrM0k1dmxmcjRkaWd3S2JiMllERWo0?=
 =?utf-8?B?MnA2a0thb25aQUIrYkFjRzRhTGhVRS9OVy9SeUEzMW9kaG54MzlnZWNCbzdJ?=
 =?utf-8?B?cUdRUjNJQkNFYlJlb3FWdW5HK3I5SmthN2lxUERheERKemVPN1daR0J0ODZm?=
 =?utf-8?B?Z2FvTGVQcnFRKyszNytBUVVHTzNBQkFVL0F0djRZbm13WnZ4cFRQZHBUSUla?=
 =?utf-8?B?RVUySjh3aEc5ajZ1dERoVUlsWFMrSEZ0Yk5pbXpPRXNKUXR3UzBBMzRjVGFs?=
 =?utf-8?B?RTN0TWhQRm1GRDlvZktyVjlqSG4xTUc2NTRXUlNQUXRRbjl5cHh3UG9WdTR2?=
 =?utf-8?B?aXdzMksrM2krbTlHSG5EaXBZOEhPeGNTbnRJMmlDOFJnTHVUVDF4QUFmVG9I?=
 =?utf-8?B?RkRKeDNrVjNZdlduS0JBU3NXSVpwdXBVQ2lvUU52Qy94WDdTNHNNTG9PTy9O?=
 =?utf-8?B?U3N0U09EaEd1endVRllBWVdwWlIxU2MxMDFDTDZOOEZ5b0tlcm4xRlBNemU4?=
 =?utf-8?B?VkUyTFl1bURqSXhrNC9wRVRzcW9NbkttS0tSK1cxelhkaFQ2VU5maGVnY0Fo?=
 =?utf-8?B?TDl5d3EwRkhrRnNYNmZLMnJoRXRqVHRQdXRZVTExbXJ6Uk9Na0xFZkE4RGl0?=
 =?utf-8?B?Rlluc0Q5VjNnUUlhczdKNjFlUlVTeHViQmdVMGZpSzdGNHd3OWVCSmF6S3ox?=
 =?utf-8?B?U2pGUkljcFZLcFJOS2h6Vnh6cCtyOG5TR1I3TkhITFQvMW4xaWRnYlhYMWh4?=
 =?utf-8?B?VDFvY1R0Zm1pUnRkZHQxVHdNNWxLdEpVNHZvOHR0b2dZTWt2WFdMWHFBNEsy?=
 =?utf-8?B?dVpxc09mUHJCMHMvUDNwMldlRFlOcUNWK3JtTWlRSXlvSkMrYjQ1Z3Z1TU5W?=
 =?utf-8?B?VnFvZm54cDVtY25LbzV0MkFOYXhjNTErVlpKUUF1TmhMUjdiY2RDMzM1aXli?=
 =?utf-8?B?eCtNM3RBU3NJT3VZMitKVkIxOExvaUJLMDV0VFRzWU5FenA4Um1oZ2cvdzlW?=
 =?utf-8?B?bEJiVTh1QURYSkJmWEorbnJrTUVSWjVyNTJSMDZ0TFBLM2NabHdrNjFKc1c4?=
 =?utf-8?B?N29mcEZxbVVGT2NCQTVyRDkwSG1SWVgzYlFDckx3OHY5dFNzZ1dmWXFJV3R5?=
 =?utf-8?B?WnBKcUtvcHdaN3ZmZ3lSQVExS05RMzFlUTRwVDc1OW4xWGVxOWd4a2xxVFI4?=
 =?utf-8?B?aklhTzdXV1pxT2diamIxeCtTbDlKZ2FpM040ZVVWUVJPUFExSXdPcVdsOWIv?=
 =?utf-8?B?ejljZFNqWVdKczRLcnRUYmlKYkdsMVpMN3hZYzAwMzh1bVZWc3c5Z1lMdktw?=
 =?utf-8?B?UnAxbWJFTnhTVG1xWE5haHhpcE8xWFZUWFlDc0Y4RHFwVUdIdXJDV2J5NGJp?=
 =?utf-8?B?ZXIvb3NlWlhtSUJLWkUvYVZNWEZzaUI5WWpabmpkSVNLaGk1ZnJpYmdCNHN2?=
 =?utf-8?B?eitUR0daQWxuUW02aFJhSDhUQlFuNGpzQThtL1VxZitsK3FJemFyS2J0UE1M?=
 =?utf-8?B?ODltbHdBOHZMY3B5TWJGYmpXS3BWZFlqdTBTMUM0NUdOem8ybDlYd1dscG9I?=
 =?utf-8?B?Tm4wbnN6eHlXSWM4OWExazEzMGRlODNhRzRXcllwMUhVbVpvbVdoT2RJdlVQ?=
 =?utf-8?B?TFhLLytiWldsOWZsWlM5SXNwRmRhbStlTHFhU1ozL1NMYWJHMVMyN29Qd1Ju?=
 =?utf-8?Q?j5ljc8e6Cv62H9x2LHlekvKE2?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 94e8bf85-7d2c-4b20-78a6-08dbe53e724b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2023 18:20:57.3167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LZgBrcMLK0di35ssXDDyFGq1Ec+M2wJU4is7Hn16dXoGRJ7ZpcTwTGuipPXO8AP9OPFW+tpWz5y9bF4Z5BrI0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5946
X-OriginatorOrg: intel.com



On 11/13/23 19:53, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Commit 458ba8189cb4 ("cxl: Add cxl_decoders_committed() helper")
> added a lockdep_assert_held() to make sure all callers hold the
> region state stable while doing work that depends on the number
> of committed decoders.
> 
> That lockdep assert triggered in poison list, inject, and clear
> functions highlighting a gap between region attach and decoder
> commit where holding the dpa_rwsem is not enough to assure that
> a DPA is not added to a region. In such a case, if poison is
> found in at that DPA, the trace event omits the region info
> that users expect.
> 
> Close the gap by snapshotting an unchangeable region state during
> all poison ops. Hold the region_rwsem in all the places that hold
> the dpa_rwsem rather than in the region specific function only.
> 
> Fixes: 7ff6ad107588 ("cxl/memdev: Add trigger_poison_list sysfs attribute")
> Fixes: f0832a586396 ("cxl/region: Provide region info to the cxl_poison trace event")
> Fixes: d2fbc4865802 ("cxl/memdev: Add support for the Inject Poison mailbox command")
> Fixes: 9690b07748d1 ("cxl/memdev: Add support for the Clear Poison mailbox command")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/memdev.c | 18 +++++++++---------
>  drivers/cxl/core/region.c |  5 -----
>  2 files changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index fc5c2b414793..961da365b097 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -227,9 +227,8 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
>  	if (!port || !is_cxl_endpoint(port))
>  		return -EINVAL;
>  
> -	rc = down_read_interruptible(&cxl_dpa_rwsem);
> -	if (rc)
> -		return rc;
> +	down_read(&cxl_region_rwsem);
> +	down_read(&cxl_dpa_rwsem);
>  
>  	if (cxl_num_decoders_committed(port) == 0) {
>  		/* No regions mapped to this memdev */
> @@ -239,6 +238,7 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
>  		rc =  cxl_get_poison_by_endpoint(port);
>  	}
>  	up_read(&cxl_dpa_rwsem);
> +	up_read(&cxl_region_rwsem);
>  
>  	return rc;
>  }
> @@ -324,9 +324,8 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  	if (!IS_ENABLED(CONFIG_DEBUG_FS))
>  		return 0;
>  
> -	rc = down_read_interruptible(&cxl_dpa_rwsem);
> -	if (rc)
> -		return rc;
> +	down_read(&cxl_region_rwsem);
> +	down_read(&cxl_dpa_rwsem);
>  
>  	rc = cxl_validate_poison_dpa(cxlmd, dpa);
>  	if (rc)
> @@ -355,6 +354,7 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_INJECT);
>  out:
>  	up_read(&cxl_dpa_rwsem);
> +	up_read(&cxl_region_rwsem);
>  
>  	return rc;
>  }
> @@ -372,9 +372,8 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  	if (!IS_ENABLED(CONFIG_DEBUG_FS))
>  		return 0;
>  
> -	rc = down_read_interruptible(&cxl_dpa_rwsem);
> -	if (rc)
> -		return rc;
> +	down_read(&cxl_region_rwsem);
> +	down_read(&cxl_dpa_rwsem);
>  
>  	rc = cxl_validate_poison_dpa(cxlmd, dpa);
>  	if (rc)
> @@ -412,6 +411,7 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_CLEAR);
>  out:
>  	up_read(&cxl_dpa_rwsem);
> +	up_read(&cxl_region_rwsem);
>  
>  	return rc;
>  }
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 56e575c79bb4..3e817a6f94c6 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2467,10 +2467,6 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port)
>  	struct cxl_poison_context ctx;
>  	int rc = 0;
>  
> -	rc = down_read_interruptible(&cxl_region_rwsem);
> -	if (rc)
> -		return rc;
> -
>  	ctx = (struct cxl_poison_context) {
>  		.port = port
>  	};
> @@ -2480,7 +2476,6 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port)
>  		rc = cxl_get_poison_unmapped(to_cxl_memdev(port->uport_dev),
>  					     &ctx);
>  
> -	up_read(&cxl_region_rwsem);
>  	return rc;
>  }
>  
> 
> base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
