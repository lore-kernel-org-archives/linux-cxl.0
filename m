Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61467219E5
	for <linux-cxl@vger.kernel.org>; Fri, 13 Oct 2023 16:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SKJ/c8hz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FE5AD
	for <linux-cxl@vger.kernel.org>; Fri, 13 Oct 2023 09:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697216259; x=1728752259;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=yaQbMUjna8FMmQFVsWf/WmmwXmvhYGlXJF1QsmLsnbc=;
  b=SKJ/c8hz2uq56Zdl4Jd6e84imn6kAPZ/Cq9W0qf5ly66DCc69+7v55bq
   N0LSE2qH+B5uH8qrC+5WjbtZUHSdH4ZXTL3cjEH+JH2Yg/Bex/xYKqkkt
   bVacVvkGCeC4sWH0RCSNrCo9S7ltAYj1kyqn+O6XgFiNEpZK59THtOIO5
   M4aZ/7GyLjzq5IoeEvDWU5HalEAS0Ah8J68y+qJ/0Tn2e+NY3edNFHQ3B
   5Mt1u/86pgVCv1gwzyGTfQ8pKOZJVYwnWB/seDuzM8ZfMPoSe37+SerCh
   Ft6c5q1Wd24fcaTmWJ0dV1PEb8rISTvDybKx86swfg1OyAMGcDgxSldtL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="3824605"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="3824605"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2023 09:57:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10862"; a="731421650"
X-IronPort-AV: E=Sophos;i="6.03,222,1694761200"; 
   d="scan'208";a="731421650"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Oct 2023 09:57:22 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 09:57:22 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 13 Oct 2023 09:57:21 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 13 Oct 2023 09:57:21 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 13 Oct 2023 09:57:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBAJeEHOcT8P8bo0wfIMZbRGwrriJhjiwfissSID9NydDeKKgrv3QQKZBAWsRHO6lXxGqTy5C4c5FjteseBgHlAAtigm5IpL8AWIhqJIWWMkwEnFEX/yZaHOJmyEeC7BnP8wZ4hBFaz0DHJVMaC19QrTnWDblKsIeZsWo0FHUqvUh5rds8E77SMsNXv0nvRWfVCXT04TF/W1EjLUGNTu437lW6C1lVJpmdGxDTl+1EszVSwLhx/3sNx5f3LsB/LyVTm7n/IN/cXgAIvbdR2m55EU24KJen8c2sNI6AAqB+FOngdSm/+yqF8LRZFI0lCW7fSxmhW3J5NL3jff797Tgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efrrJexmPqzVqeyJWP5G0gscezU7SJ3csnaEaDdRbJ4=;
 b=QzctpOvZHCxS6DU+M/dO7tgNk1seEe7OkZB71qKlv+iiO5C77bjUa8/yILMvelKx1Ayu71RscI0Hi5embc6t0wFqoh0aR/ucAfmyUGOE4irUqsa9Rd/bGKMKJEd0pXgyhQMWtNP0GQoUIWNepao6Yr5RYVZ5Rmq2Hp99zozLJ2QOk8+anEmZZXWUv4pgfJfeociccZeManh2lCnDwSdo1x+ZTPgs2z+F/1B++oJkhHRPtUmcz0DVAgqy/wchSKV0cufGvQ/hdhPxlfwMnoY3F4BW1g4j8rqyVFaAfAyBOkxclipES2Sj1iL4c3w4oJ5/hgnTSnLQB9Q+0y2BzAOpyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DS7PR11MB6223.namprd11.prod.outlook.com (2603:10b6:8:98::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 16:57:16 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8%5]) with mapi id 15.20.6838.040; Fri, 13 Oct 2023
 16:57:15 +0000
Message-ID: <6fda3467-aa30-4eac-a258-63a4876e0c82@intel.com>
Date: Fri, 13 Oct 2023 09:57:12 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH v2] cxl/region: don't try to cleanup after
 cxl_region_setup_targets() fails
To: Jim Harris <jim.harris@samsung.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "dan.carpenter@linaro.org"
	<dan.carpenter@linaro.org>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>
References: <169696311899.1171696.7812961484055097837.stgit@bgt-140510-bm03.eng.stellus.in>
 <CGME20231011145132uscas1p13e9fb6dadfa3d5b61fc410449122a013@uscas1p1.samsung.com>
 <169703589120.1202031.14696100866518083806.stgit@bgt-140510-bm03.eng.stellus.in>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <169703589120.1202031.14696100866518083806.stgit@bgt-140510-bm03.eng.stellus.in>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0153.namprd03.prod.outlook.com
 (2603:10b6:a03:338::8) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DS7PR11MB6223:EE_
X-MS-Office365-Filtering-Correlation-Id: d837fd7d-86b1-4847-8fee-08dbcc0d73fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cqzVO/9p/XPhIIKDhIsScK7NfYG+J8yrXzL6W/3BUGaoN1hcezj6v+uR1fniJ7VV5xZo96vt2ZqMeIKkD5B+BX8kmO75ilTjbER8yORPWZTOiHIB7H1e3EJHmFtHH7RLFp4QQdGIu6G9PruzhC/7sU7R/THuSvyVjTzCP6FTh3XJOTVuT/jx2oROrt5ZWpsAKnjRbVRgmAlFv4GmWroPPNouNeL99VXzVZmgjf3uwkABx9fUtxPDw2ARa3upf8ySyrq+WhereRaRvgyfC1JgEfajO8c03C72AYltmA9mGevk08lLue/7pn2yBeTw3RCu8srZpQK1Dk17s/mgn4yQU5nEKxAxoesDqZrxPW5yWm9DDxZIJjXWZp68CJObkqG4VLohHv9FbNJ6S7jjgcYiepYZdtVloomNU6SwkCX/7J361P5tyLmqeJjLNE8vEtr8Ssu4msGn93lZkTo7nrStjTK38Lrdez1Z23j55xm3LctcplHSJZz0h4nFOcz69rebiYKZgkHe4Hx8S4g+aYihWGTnh05yPo81UTHqi/NCXIpmR9qS39v4fedcfb7FCRWVmS7zAOBnusX3f9TFkM6zuoJGwnGWWEy99t3Kjso3FM0RtA0+pYHWq7C/45xv/x3b
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(82960400001)(26005)(6506007)(44832011)(66556008)(316002)(66946007)(6636002)(36756003)(83380400001)(66476007)(110136005)(6512007)(2616005)(86362001)(53546011)(38100700002)(31686004)(478600001)(6486002)(31696002)(2906002)(6666004)(5660300002)(8676002)(8936002)(41300700001)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b0pjVWo5MXRHVEdSOEdKYy9IcTUwNnlaRTdRYm1nTXJMYmZhOWI2RHRuTWE0?=
 =?utf-8?B?dllCMDh1aWUyZ3pSVHY1NG5aSDBpcXFVaXZod2V5M3AzbjFkYVVEcHg0MDBT?=
 =?utf-8?B?ZE81RXBTS3VFQXpIMjdweTdTcDQvMXBGK1VKRkJKaXNYQVBMMkZ2bEZpZmZP?=
 =?utf-8?B?b2JwMmRqRGFpMkM3YmdlTytIRmd3N3ZjOW9FMSt1RCszcVlVeGFpaU5HbGpK?=
 =?utf-8?B?dWV6RHNwWlZML3ZIdWFWdkJwZkFlSUpuN0dicDc2cFBab0hNVWpNWitKMmVB?=
 =?utf-8?B?Wnpmczc1cmF2dmlPWWlTbkY2SUxKVFZxalZvOU5BUUMveUlacnZlZWpuY1B2?=
 =?utf-8?B?ejJlTTEvTThkMDB6elJPR1RDZVBwaGZ5REcvcTdRc3cwOUNFd3ozSFVreVFG?=
 =?utf-8?B?ZHV6OGpERlNjbWZCeDd0OG16TjhjWjFkc3A2cnk4M1BXRkhFNitWSDJTQUFj?=
 =?utf-8?B?M1RyV3ZuRG5KYmswbGRiMjNMWmdqMmR6WGVBYTZwZHZYdmZ4b05PTHB6Ujhh?=
 =?utf-8?B?YUFGZ0Zjc3dsWmdmQWw5dGRyNCtkakRCRVpIemJNNE1GUTVYckxVT29EVGor?=
 =?utf-8?B?RGw4U21GUitqMWJGQWErVlo2K0l0cWdOcU0wVmd0M2cwMWhUeHpTMXpDd1c1?=
 =?utf-8?B?aUwyRUdWYVluMlc2TVdTMW5Ncm1PbFhjM0x0Z25mYVJ1V3IwaHJMNk44Tjhp?=
 =?utf-8?B?OFVQZ2ZFOW1GOWVWd0tiTUNhbjRGTlJId2UzK29xS0pjbmlKREx1cHg1UXlk?=
 =?utf-8?B?cVJERlo1L2JZY3JDeXJMb1dwb2Nzd1BteWdRaEJ6WDhIM2VnSnlMV1cwaVB5?=
 =?utf-8?B?YTI1dlFMYVg4STl1cHp6QlVkWmcybS9kOXhiWmUxZ3NRVnQ4ZlRwOExoMmk2?=
 =?utf-8?B?MERmVk94UWNKcmRHSUhKR01sa1R4QzNjbmhpQWk5NUFEeUUwUVhZUHg5R04w?=
 =?utf-8?B?MnJlZVgwU0VPVGlDMXlMMnlpeGRMOEwvRjNtbGFoQ01VS1RTc01hSzZDK0lU?=
 =?utf-8?B?KzlTckpHRklGbEdubkZmTU0ybVFYMkRTTlhUVDFyRWN5ZHRrdWZTMU9VV3Zq?=
 =?utf-8?B?cW9nL0hwWVVUZFMrZVZSYjNRZTlvc25vVVBDdlRxUVNraTRHY3FvVGVUdmht?=
 =?utf-8?B?Q21IeHMvNzRaZUw4dEwxaU9heGtyZE8rT2d0V2l2eUtyN3JDcG9hcFlGRnZT?=
 =?utf-8?B?ZEZpZVlJS0szYWVNb1dtaElONVFOeWdaaUtQT3BPVXVuVElaM0p4cHZUYnJz?=
 =?utf-8?B?TFhjd2VTM2xjYzlYaUlLQll4S3dVbWptcElhK0Q5MEgwNkxFVURuckZselY5?=
 =?utf-8?B?YURqZEtubFdCU2tTcXBKbFhka3VQdUpkYVU3bzBONlZiNU1GbUthekFMOENO?=
 =?utf-8?B?eXFWRXhIQ2p3TkpnWWd1R1NJbkdZR2pNQWhtWmNtVG10Zkw3WURPRXZPMG5z?=
 =?utf-8?B?MHRwY0MyYmo4Smt5N0orOUlDRng5WGdjU0pzZC96cVVRdXVzeXFFME9qdGkv?=
 =?utf-8?B?V1lCQUxDYTFGa094YUdadkloTGJremw3WGZFall2M2xabk5Fb05uZXZ5OWxu?=
 =?utf-8?B?cFpLL0ZhL0JPTWozMUNQVS9WKzdWTGt5am9Zc0NxYWhtZHNNRGM0MmdnNEgy?=
 =?utf-8?B?bG1SMS85ekVrY2wwa0N4eCtRYU9IZDFEOGdoUWs2WmlKNUc1V2hpVlpDdkRt?=
 =?utf-8?B?c2VSS0ZIQ243UGxwaTRSSW1uNXV2emFFb3lLM01ZWFVJcjFDL2ZWYVNyZXVk?=
 =?utf-8?B?RlhscHY4MEY4Zkp2Rng0Z3E5TGFzQ0tNaEhpMHd1WWQ0WDh4QW1tb2MyUjBY?=
 =?utf-8?B?dzZvSmErTVpzYjhLRy9FZUJ3dVV2Tmo5NXhMWEo3dkdQb1ZCRDAvd2F0cXk1?=
 =?utf-8?B?STVLQ20wdU9QYzFpaWdpUEFGYzJxZFVJQWxHVUo4Q1Z1L01FUjViSGt1UTdC?=
 =?utf-8?B?bkkrUnpnWmpkWXIzOXkvR2hLZHF1TXppTlA4NVRIZVZxdXdmUWtyaDBmVzE4?=
 =?utf-8?B?QnFYcUt4WVMvTFZ2VjFIMEJmSTNhS1RUUHU0Q0NGcjIyUWlhelVySjkxQi9m?=
 =?utf-8?B?YjhZd2lyZXZNbjB2cHV1bThHV0pMR0E2L084ZGhEaHJNZDU2ZFdTTnhGSGRj?=
 =?utf-8?Q?Y3e8S1cRhfU4NzAUlEKfC1lVy?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d837fd7d-86b1-4847-8fee-08dbcc0d73fc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 16:57:15.8261
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V/qX2Ar+iEyMt3E5316Dq9a8fwAgMxeG5mlMCdYikwMLSpWaNNF5XgrQig0NlArNowPk97wWdh7iYHLneMdN2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6223
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/11/23 07:51, Jim Harris wrote:
> Patch 5e42bcbc ("cxl/region: decrement ->nr_targets on error in
> cxl_region_attach()") tried to avoid 'eiw' initialization errors when
> ->nr_targets exceeded 16, by just decrementing ->nr_targets when
> cxl_region_setup_targets() failed. Patch 86987c76 ("cxl/region: Cleanup
> target list on attach error") extended that cleanup to also clear
> cxled->pos and p->targets[pos].
> 
> The initialization error was incidentally fixed separately by patch
> 8d4285425 ("cxl/region: Fix port setup uninitialized variable warnings")
> which was merged a few days after 5e42bcbc.
> 
> But now the original cleanup when cxl_region_setup_targets() fails
> prevents endpoint and switch decoder resources from being reused:
> 
> 1) the cleanup does not set the decoder's region to NULL, which results
>    in future dpa_size_store() calls returning -EBUSY
> 2) the decoder is not properly freed, which results in future commit
>    errors associated with the upstream switch
> 
> Now that the initialization errors were fixed separately, the proper
> cleanup for this case is to just return immediately. Then the resources
> associated with this target get cleanup up as normal when the failed
> region is deleted.
> 
> The ->nr_targets decrement in the error case also helped prevent
> a p->targets[] array overflow, so add a new check to prevent against
> that overflow.
> 
> Tested by trying to create an invalid region for a 2 switch * 2 endpoint
> topology, and then following up with creating a valid region.
> 
> Signed-off-by: Jim Harris <jim.harris@samsung.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/region.c |   14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 6d63b8798c29..2b3b3c62d0a7 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1658,6 +1658,12 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		return -ENXIO;
>  	}
>  
> +	if (p->nr_targets >= p->interleave_ways) {
> +		dev_dbg(&cxlr->dev, "region already has %d endpoints\n",
> +			p->nr_targets);
> +		return -EINVAL;
> +	}
> +
>  	ep_port = cxled_to_port(cxled);
>  	root_port = cxlrd_to_port(cxlrd);
>  	dport = cxl_find_dport_by_dev(root_port, ep_port->host_bridge);
> @@ -1750,7 +1756,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  	if (p->nr_targets == p->interleave_ways) {
>  		rc = cxl_region_setup_targets(cxlr);
>  		if (rc)
> -			goto err_decrement;
> +			return rc;
>  		p->state = CXL_CONFIG_ACTIVE;
>  	}
>  
> @@ -1762,12 +1768,6 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  	};
>  
>  	return 0;
> -
> -err_decrement:
> -	p->nr_targets--;
> -	cxled->pos = -1;
> -	p->targets[pos] = NULL;
> -	return rc;
>  }
>  
>  static int cxl_region_detach(struct cxl_endpoint_decoder *cxled)
> 
