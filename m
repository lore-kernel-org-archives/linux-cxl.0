Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357AB1B280
	for <linux-cxl@vger.kernel.org>; Fri, 13 Oct 2023 17:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lhhgb6wO"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED675AD
	for <linux-cxl@vger.kernel.org>; Fri, 13 Oct 2023 10:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697217635; x=1728753635;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rVwUqEOkYJtyBvZWEY0+D3TY53c92ub5Orok/60FABI=;
  b=Lhhgb6wO0Kfyhs9T1tSoZGIYw3OzHd7VViAxAkPAACQR2qFtRZJ1vqaC
   01dRffiEp8j7iVFzoYzPTSqFlJUtEZIYEUN8kSxnIwgPTqxWP7EDa8G/G
   bP2V3gVXtz1s3lhq1YANzOFzHJV0Z0qaRzs/hl6L3cMPrY/ze3GLw6RNu
   TMfb5tln8SvtekUbgSCx/uey0mb6EsGJB8RpnDJBzpsE7eTcb95txPfgT
   JwYagM30rhSrnNFyulr9iBzol6KE1ioereM10BeOIWu2FYHcIXkUNEHK1
   7xOt6wwt+FD7kJfxT/d08K+15BPknA/gT5JMru6/0JX0o/rnyWJT1+0N1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="370295119"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="370295119"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 10:20:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="878601906"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="878601906"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Oct 2023 10:20:27 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 10:20:27 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 13 Oct 2023 10:20:27 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 13 Oct 2023 10:20:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mdLmKAF/1LubBRDh1x4mNXr1JnEzsuk38BRsOimY5Rfa5IB5Hg6TTGDo23AXUHcKaINWWxb2gMTYrNeODWnrL1pt4MnQRmjWRkBwm57N6tvHqMDOtOQZAlPrX1B/88/ByyzA454+e7fIOjLa9J44cXvAtxpcEsY0hvNBDhLx6vPsidijey/TsTcsw4GET81xxgxUlYW42wHe6/Q+M+UJsYGhk8UlOVgYxF4QdgXPJL2U/Cz+P2oaA+7J6apXdsXW36KcOJYa8QJ/QXQ1k5F8zleTsiD/Mer16Hj6am6oBHW7JmyFcwtMOEqEOyfiCxy9n5WzFcAdasD/5PQklCqJ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05hRI8G5MstdQpUUktUDwL1RBAbS+wQHS6puF/4wVPA=;
 b=azjtqRwvT5eIOpd4dvyMdIk9Akd0nWLmETgoqB3tSUzww9X4cmphlknpH0o2cPdMViOyrJQ4DyIc1RUqPs5de2YrhvgD7sAofxbHZ82puiF/H5sVtp2KcG6trAALb7kzLxGH7YuI7oMiWQVn1HR9X4SmMRfNNdfzKHMQ5obiIa+9875iTepPNCkxlTOFBdOd5GO64dZ3Djg6oG6bkbVYdsigoprqe7xMWALFteS5ktNaF1blOzrrbsXMmHdh6nYP8pQvOUptATCc4UMvgkMAjy7nxyOFyaZzoOu45WQ6inl3+YHVr4KKOneg4Agzu9MMdwFUKcQ//JUDWTryzaPIKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by LV3PR11MB8508.namprd11.prod.outlook.com (2603:10b6:408:1b4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Fri, 13 Oct
 2023 17:20:20 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8%5]) with mapi id 15.20.6838.040; Fri, 13 Oct 2023
 17:20:19 +0000
Message-ID: <5c65ec8f-0cf5-4b6c-b647-2b4e44512472@intel.com>
Date: Fri, 13 Oct 2023 10:20:16 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v3 07/10] cxl/memdev: Fix sanitize vs decoder setup
 locking
To: Dan Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>
References: <169657715790.1491153.3612164287133860191.stgit@dwillia2-xfh.jf.intel.com>
 <169657719974.1491153.15276451196916291864.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <169657719974.1491153.15276451196916291864.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0055.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::32) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|LV3PR11MB8508:EE_
X-MS-Office365-Filtering-Correlation-Id: eb59f994-5565-4420-3164-08dbcc10ad03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LohFxp5cPFIw4Q1yvYaAZvhwBTs8p7VTixaOzEUlTVHhJrEeB/nKa+apLfgg9/yfvQF1GcRC3/HuR5pKaiDBd4NX/n2CGjFd+8nVmPIfdrspTlr8LFVHofwujJT6kg/W2bZFUkGo/s7bJok69uqsc+BM95b5KaEDYYnJYQT4PDYHPTJ3IgQtqJIeGjxp0qkKoXHjYcu+5Wad1DxbEEGi8mMBsbWpbxJ44zY8/3rgUqVooQq+xWY1ViaY2gtANu68qPIC7qIm3FFLeOIRcckzsDGWZhFVkglnKV+iid5r+VFgVxF35enmSUnV158lrpgJe6nyhUL4uOYv8p2nylhbD9GN27g3QXHzOcREmQPedwUDNZBFXuH0Btjt1gdgNXQXXB6AeerE2VeGv1t3MgZkaB0yJCf5mTLbln6BmWqr6DmfFczGrBR6Rt8My+FZTNgHz0Ap7suVD33zh9IIJJvQfO7rTNk/eXQj6c8EBozdJ4MODMpym7F4LeDtpCGTDOzIfwfuWv3ca9OcdxUFK3F22lxa474nufPFp11JoBthv/DiHwNZLrspZUvtR1LJihV+xTZoHSkII7zgb/mwNbaAWlxw8n7dabsA1/+yoz2by+m0jBbrAdX06NvODLJhtK4QLhkf/NIz1rG2u86DLQ/sug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(396003)(376002)(366004)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6486002)(478600001)(6666004)(4326008)(8676002)(66476007)(66556008)(316002)(66946007)(30864003)(31696002)(86362001)(8936002)(82960400001)(2906002)(38100700002)(36756003)(5660300002)(41300700001)(44832011)(26005)(6512007)(31686004)(2616005)(83380400001)(6506007)(53546011)(45980500001)(47845010);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUhtMTFCQ2pweDhqOSt4OFJ0bm04Y3N5dDhoWFZqQ1JhOVYvQkQvWUF4SlFN?=
 =?utf-8?B?NkVQSU1FS3JmTnBFUEZxSmhtaEtmY1VTNVRpVkNQbnJNOEVqVkZCL3QvUXZ5?=
 =?utf-8?B?V3h0MG5oSWlVK0hJVjJmeDcrWE1rMjZtcnBDQXZCVmpxUXd6NEJ5UDEyTWlT?=
 =?utf-8?B?NGZVV241THJ1NmR3MG9rd2s4aFE2Yko1dHg5MXI5UUFVWGg1QnJWTld0QTNX?=
 =?utf-8?B?K01qVThGS2tIb3lMNU1pYTNHTnJBWEtxVkVnYzZvMlFYVHI2K2hFUGNadURs?=
 =?utf-8?B?eXpaVVBSYTE0c2FwbDA1VDFmUWtSTVRPVE41Z2M4aE1SYjJYcDVHN3ZZd0Ri?=
 =?utf-8?B?ejdvUkR4TmNGK0xIOG9lSDVxRDlEY0pocVZHVVF5czU0U2RyOEt2MjlYZm81?=
 =?utf-8?B?VGloaWtpaDdhS0l3NllZUmdBNW4zamprSTVYd3JtTlZ6dkJ5ek5SY0hIY3B6?=
 =?utf-8?B?WE52ZU5aTlMrL1dYbFBlU01XcDhWUHV5a0hZNFBqSWRwSVZpTHR5VU1TUzlI?=
 =?utf-8?B?SHVsSGsralA1VDV2NWRqNHc1TlBJZFd1ZFF4cUE3SXpDR3RxQlJPQUt5SnNI?=
 =?utf-8?B?UTdYS2J4OC9XSHVFNjQ0RHByUjEyRXAvRWNEblNIUjd1blAySDM2UWVXVVVv?=
 =?utf-8?B?VEpMMnFVVWRvVW8zaDR3a3lUa1RqbW1Id0FzbEdPMUl1UDRFSFk2V3V0R3dT?=
 =?utf-8?B?NTI2WHRCaDE0VU13cGlWWGkyYlV3TkJKNHhRclpzRUJOMGpZOVR5cHJkakVa?=
 =?utf-8?B?NE1GbU55VkszL21uTmtPQXg0eFpraDBDQ1Bmckx0ckl2d3hmVTliV25ZQWRX?=
 =?utf-8?B?WDRyV1NyK0JmblNhTXhibFFMMnROcEZwM3Z2cHVHa0Nhb044UGNaUlA0eHB2?=
 =?utf-8?B?eG56QjF0QnphcHVjZGlWOEl6NUVKVGxldWUyZUNGeUpqbDZ3eG5YWTAvSmdz?=
 =?utf-8?B?YWVPRTBUMitReHZZSDhLM3pmY3BtMnFEaTJQaElWZEZROTVmYmhMUW9lMERP?=
 =?utf-8?B?d3B2WU1uZVB3R1lhNFRHZEFHSHJGY0VkS0FFUmRUVStqVzNFY01scU8vbVVi?=
 =?utf-8?B?MDdoMFU2eXBqVTZZa0FaZFR0dlV3RVlKOUpNOHMxUmdjeWxkK0pYK0NkR040?=
 =?utf-8?B?TU1uL0ZFL1VGTnFxQ3llaWd3ZzZLM3NmWDBkOFNXMG02WmRxWXkweDJlMURi?=
 =?utf-8?B?U3hZMUlkZ3dYN2s4ZmdvMzNjWm5HUTVQOEFKM0laU1F0aVZoQWtwT0N0WlpB?=
 =?utf-8?B?WlFUbUttWlUwRUxjUDJacW1XNFhwNXFpL1pZS0xOUWFiQzBPdElhOUcrZ3ND?=
 =?utf-8?B?MCtwY1BjWEJFbFhzdkJ1SzJxL2Qxa25Ubi9yVURMMXBjTCtzcUlMQy9ZbjZu?=
 =?utf-8?B?d0Q4OVpwOVZhcUJKSHBOaDl6Vy9lZCsxM1JrenhKeXNJdDlERGgrNm5yY0cy?=
 =?utf-8?B?ME9uamx4SjdXWGxzMnJneW5sNEZXdnE5aTVqTGlEeTl5ajlSU21Qb3lYeDN0?=
 =?utf-8?B?bkljRkRhU0gxWjkzWm5uc3puMFg3UVBmSUtkNEovMDN3NUdyOGpaT29sWXlH?=
 =?utf-8?B?ZE94ZTV3eVhPQnhrSTdrZHRFVXRqQjlkUTBINis5d2tWelFDMXQ0aWdxUVVw?=
 =?utf-8?B?Y2JPNzBjWit3YWZYaEE0L0czS2gzMUgybWw1S1hYUG9ya2NkbmRYSm5MOUJk?=
 =?utf-8?B?eEpYSS9UbDU1ZXhaZ0lrdTZKR2xUYjVreDAxenYzYmx4NTc2UWQ1bzE5U0RU?=
 =?utf-8?B?Y1JmUUwyYTk3eGZtd2QwcE1ZUHdjUTV0T0piQi9HZkE3REx4Y0ZhT2RxYVR1?=
 =?utf-8?B?aDkzOW1zVlJTV1NvZGo0aTVlRzBQZzVnT2JuNngxQWZZVWtMRXJTQmNCT2Nv?=
 =?utf-8?B?RmJJOE1RdllkeXhWOFlGeUliR3JrdDNDdjBvN0h0WEtNUHZMbjJJbVlGQ01W?=
 =?utf-8?B?ekVld0dhT0UxR20wMzR0dit0WDh2c1pEUnpLdkM0ZzZvdk9DR2NkVi8zbEZy?=
 =?utf-8?B?YU90NURybTJLcWx5dk5tM0xDQjBSdXlnMmFJMGZ3aStmdWpzd0ZpWnRqTzNv?=
 =?utf-8?B?VU5DTXZMVXJSaFJWU0grcVFrNDg3VjBXcDNCRXNxeGw4QjZIMFVFMEVxdTFr?=
 =?utf-8?Q?Jhi/65Q7pGMJFUwbQc0AiZTto?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eb59f994-5565-4420-3164-08dbcc10ad03
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 17:20:19.8534
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQbKZU/voBnJEAumj8mAhMkkkhbvU3EEz0WgS+uGx+Nj1WGZhJBVvbYDRikiOEGGoxHoYmbSizF37YjrzoJgfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8508
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/6/23 00:26, Dan Williams wrote:
> The sanitize operation is destructive and the expectation is that the
> device is unmapped while in progress. The current implementation does a
> lockless check for decoders being active, but then does nothing to
> prevent decoders from racing to be committed. Introduce state tracking
> to resolve this race.
> 
> This incidentally cleans up unpriveleged userspace from triggering mmio

s/unpriveleged/unprivileged/

> read cycles by spinning on reading the 'securiry/state' attribute. Which
> at a minimum is a waste since the kernel state machine can cache the
> completion result.
> 
> Lastly cxl_mem_sanitize() was mistakenly marked EXPORT_SYMBOL() in the
> original implementation, but an export was never required.
> 
> Fixes: 0c36b6ad436a ("cxl/mbox: Add sanitization handling machinery")
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/core.h   |    1 +
>  drivers/cxl/core/hdm.c    |   19 ++++++++++++++++
>  drivers/cxl/core/mbox.c   |   55 +++++++++++++++++++++++++++++++++------------
>  drivers/cxl/core/memdev.c |   43 +++++++++++++----------------------
>  drivers/cxl/core/port.c   |    6 +++++
>  drivers/cxl/core/region.c |    6 -----
>  drivers/cxl/cxlmem.h      |    4 ++-
>  drivers/cxl/pci.c         |    5 ++++
>  8 files changed, 90 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 45e7e044cf4a..8e5f3d84311e 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -75,6 +75,7 @@ resource_size_t __rcrb_to_component(struct device *dev,
>  				    enum cxl_rcrb which);
>  
>  extern struct rw_semaphore cxl_dpa_rwsem;
> +extern struct rw_semaphore cxl_region_rwsem;
>  
>  int cxl_memdev_init(void);
>  void cxl_memdev_exit(void);
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 4449b34a80cc..506c9e14cdf9 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -650,6 +650,25 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
>  		return -EBUSY;
>  	}
>  
> +	/*
> +	 * For endpoint decoders hosted on CXL memory devices that
> +	 * support the sanitize operation, make sure sanitize is not in-flight.
> +	 */
> +	if (is_endpoint_decoder(&cxld->dev)) {
> +		struct cxl_endpoint_decoder *cxled =
> +			to_cxl_endpoint_decoder(&cxld->dev);
> +		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +		struct cxl_memdev_state *mds =
> +			to_cxl_memdev_state(cxlmd->cxlds);
> +
> +		if (mds && mds->security.sanitize_active) {
> +			dev_dbg(&cxlmd->dev,
> +				"attempted to commit %s during sanitize\n",
> +				dev_name(&cxld->dev));
> +			return -EBUSY;
> +		}
> +	}
> +
>  	down_read(&cxl_dpa_rwsem);
>  	/* common decoder settings */
>  	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 4df4f614f490..67aec57cc12f 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1125,20 +1125,7 @@ int cxl_dev_state_identify(struct cxl_memdev_state *mds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_dev_state_identify, CXL);
>  
> -/**
> - * cxl_mem_sanitize() - Send a sanitization command to the device.
> - * @mds: The device data for the operation
> - * @cmd: The specific sanitization command opcode
> - *
> - * Return: 0 if the command was executed successfully, regardless of
> - * whether or not the actual security operation is done in the background,
> - * such as for the Sanitize case.
> - * Error return values can be the result of the mailbox command, -EINVAL
> - * when security requirements are not met or invalid contexts.
> - *
> - * See CXL 3.0 @8.2.9.8.5.1 Sanitize and @8.2.9.8.5.2 Secure Erase.
> - */
> -int cxl_mem_sanitize(struct cxl_memdev_state *mds, u16 cmd)
> +static int __cxl_mem_sanitize(struct cxl_memdev_state *mds, u16 cmd)
>  {
>  	int rc;
>  	u32 sec_out = 0;
> @@ -1183,7 +1170,45 @@ int cxl_mem_sanitize(struct cxl_memdev_state *mds, u16 cmd)
>  
>  	return 0;
>  }
> -EXPORT_SYMBOL_NS_GPL(cxl_mem_sanitize, CXL);
> +
> +
> +/**
> + * cxl_mem_sanitize() - Send a sanitization command to the device.
> + * @mds: The device for the operation
> + * @cmd: The specific sanitization command opcode
> + *
> + * Return: 0 if the command was executed successfully, regardless of
> + * whether or not the actual security operation is done in the background,
> + * such as for the Sanitize case.
> + * Error return values can be the result of the mailbox command, -EINVAL
> + * when security requirements are not met or invalid contexts, or -EBUSY
> + * if the sanitize operation is already in flight.
> + *
> + * See CXL 3.0 @8.2.9.8.5.1 Sanitize and @8.2.9.8.5.2 Secure Erase.
> + */
> +int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd)
> +{
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +	struct cxl_port  *endpoint;
> +	int rc;
> +
> +	/* synchronize with cxl_mem_probe() and decoder write operations */
> +	device_lock(&cxlmd->dev);
> +	endpoint = cxlmd->endpoint;
> +	down_read(&cxl_region_rwsem);
> +	/*
> +	 * Require an endpoint to be safe otherwise the driver can not
> +	 * be sure that the device is unmapped.
> +	 */
> +	if (endpoint && endpoint->commit_end == -1)
> +		rc = __cxl_mem_sanitize(mds, cmd);
> +	else
> +		rc = -EBUSY;
> +	up_read(&cxl_region_rwsem);
> +	device_unlock(&cxlmd->dev);
> +
> +	return rc;
> +}
>  
>  static int add_dpa_res(struct device *dev, struct resource *parent,
>  		       struct resource *res, resource_size_t start,
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 4c2e24a1a89c..a02061028b71 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -125,13 +125,16 @@ static ssize_t security_state_show(struct device *dev,
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> -	u64 reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
> -	u32 pct = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_PCT_MASK, reg);
> -	u16 cmd = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK, reg);
>  	unsigned long state = mds->security.state;
> +	int rc = 0;
>  
> -	if (cmd == CXL_MBOX_OP_SANITIZE && pct != 100)
> -		return sysfs_emit(buf, "sanitize\n");
> +	/* sync with latest submission state */
> +	mutex_lock(&mds->mbox_mutex);
> +	if (mds->security.sanitize_active)
> +		rc = sysfs_emit(buf, "sanitize\n");
> +	mutex_unlock(&mds->mbox_mutex);
> +	if (rc)
> +		return rc;
>  
>  	if (!(state & CXL_PMEM_SEC_STATE_USER_PASS_SET))
>  		return sysfs_emit(buf, "disabled\n");
> @@ -152,24 +155,17 @@ static ssize_t security_sanitize_store(struct device *dev,
>  				       const char *buf, size_t len)
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> -	struct cxl_port *port = cxlmd->endpoint;
>  	bool sanitize;
>  	ssize_t rc;
>  
>  	if (kstrtobool(buf, &sanitize) || !sanitize)
>  		return -EINVAL;
>  
> -	if (!port || !is_cxl_endpoint(port))
> -		return -EINVAL;
> -
> -	/* ensure no regions are mapped to this memdev */
> -	if (port->commit_end != -1)
> -		return -EBUSY;
> -
> -	rc = cxl_mem_sanitize(mds, CXL_MBOX_OP_SANITIZE);
> +	rc = cxl_mem_sanitize(cxlmd, CXL_MBOX_OP_SANITIZE);
> +	if (rc)
> +		return rc;
>  
> -	return rc ? rc : len;
> +	return len;
>  }
>  static struct device_attribute dev_attr_security_sanitize =
>  	__ATTR(sanitize, 0200, NULL, security_sanitize_store);
> @@ -179,24 +175,17 @@ static ssize_t security_erase_store(struct device *dev,
>  				    const char *buf, size_t len)
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> -	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> -	struct cxl_port *port = cxlmd->endpoint;
>  	ssize_t rc;
>  	bool erase;
>  
>  	if (kstrtobool(buf, &erase) || !erase)
>  		return -EINVAL;
>  
> -	if (!port || !is_cxl_endpoint(port))
> -		return -EINVAL;
> -
> -	/* ensure no regions are mapped to this memdev */
> -	if (port->commit_end != -1)
> -		return -EBUSY;
> -
> -	rc = cxl_mem_sanitize(mds, CXL_MBOX_OP_SECURE_ERASE);
> +	rc = cxl_mem_sanitize(cxlmd, CXL_MBOX_OP_SECURE_ERASE);
> +	if (rc)
> +		return rc;
>  
> -	return rc ? rc : len;
> +	return len;
>  }
>  static struct device_attribute dev_attr_security_erase =
>  	__ATTR(erase, 0200, NULL, security_erase_store);
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 7ca01a834e18..5ba606c6e03f 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -28,6 +28,12 @@
>   * instantiated by the core.
>   */
>  
> +/*
> + * All changes to the interleave configuration occur with this lock held
> + * for write.
> + */
> +DECLARE_RWSEM(cxl_region_rwsem);
> +
>  static DEFINE_IDA(cxl_port_ida);
>  static DEFINE_XARRAY(cxl_root_buses);
>  
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 6d63b8798c29..d74bf1b664b6 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -28,12 +28,6 @@
>   * 3. Decoder targets
>   */
>  
> -/*
> - * All changes to the interleave configuration occur with this lock held
> - * for write.
> - */
> -static DECLARE_RWSEM(cxl_region_rwsem);
> -
>  static struct cxl_region *to_cxl_region(struct device *dev);
>  
>  static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index fbdee1d63717..6933bc20e76b 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -364,6 +364,7 @@ struct cxl_fw_state {
>   * @state: state of last security operation
>   * @enabled_cmds: All security commands enabled in the CEL
>   * @poll_tmo_secs: polling timeout
> + * @sanitize_active: sanitize completion pending
>   * @poll_dwork: polling work item
>   * @sanitize_node: sanitation sysfs file to notify
>   */
> @@ -371,6 +372,7 @@ struct cxl_security_state {
>  	unsigned long state;
>  	DECLARE_BITMAP(enabled_cmds, CXL_SEC_ENABLED_MAX);
>  	int poll_tmo_secs;
> +	bool sanitize_active;
>  	struct delayed_work poll_dwork;
>  	struct kernfs_node *sanitize_node;
>  };
> @@ -884,7 +886,7 @@ static inline void cxl_mem_active_dec(void)
>  }
>  #endif
>  
> -int cxl_mem_sanitize(struct cxl_memdev_state *mds, u16 cmd);
> +int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 cmd);
>  
>  struct cxl_hdm {
>  	struct cxl_component_regs regs;
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 9955871e9ec1..06fafe59c054 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -154,6 +154,7 @@ static void cxl_mbox_sanitize_work(struct work_struct *work)
>  		mds->security.poll_tmo_secs = 0;
>  		if (mds->security.sanitize_node)
>  			sysfs_notify_dirent(mds->security.sanitize_node);
> +		mds->security.sanitize_active = false;
>  
>  		dev_dbg(cxlds->dev, "Sanitization operation ended\n");
>  	} else {
> @@ -292,9 +293,13 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_memdev_state *mds,
>  		 * and allow userspace to poll(2) for completion.
>  		 */
>  		if (mbox_cmd->opcode == CXL_MBOX_OP_SANITIZE) {
> +			if (mds->security.sanitize_active)
> +				return -EBUSY;
> +
>  			/* give first timeout a second */
>  			timeout = 1;
>  			mds->security.poll_tmo_secs = timeout;
> +			mds->security.sanitize_active = true;
>  			schedule_delayed_work(&mds->security.poll_dwork,
>  					      timeout * HZ);
>  			dev_dbg(dev, "Sanitization operation started\n");
> 
> 
