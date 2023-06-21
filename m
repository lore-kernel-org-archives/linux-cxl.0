Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB8C3EB64D7
	for <linux-cxl@archiver.kernel.org>; Wed, 21 Jun 2023 00:00:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbjFUAAz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 20 Jun 2023 20:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjFUAAy (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 20 Jun 2023 20:00:54 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11138184
        for <linux-cxl@vger.kernel.org>; Tue, 20 Jun 2023 17:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687305653; x=1718841653;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mkU500HGtWMygbEeX3KT9hNNt89mxpP4mrCWJ/1s5/Y=;
  b=JtfMavOQ3ldpmlgRDeSFljBtGhED6ukdYsKhTBDLGVIXHKXPU41SU4GT
   9DFmAhpW7bk8D6pjO61Xid5ibRhyhoPuUwb5C2gZ3gkwKi+Uuuyypa2Es
   Yaov1p+GTiQLRnpIHtUnfUWoQkw8+YXn6tFjX6VTBeHzYUDnPOnl8tFIA
   3bcABuW3cewKZJoukB4Edn0l7zOAKguiZZNEFMKR+Lv5RP5qV+1yt478o
   TD2/f+triAzCZQ5I9rNll6qUhBf76xH1pv10loQkNKtWFI1xGwXLcEiHU
   Obzs096qymIh8RHxRMd5E1nkBKV0tJG0Z3m6s7/Jy+PvtpahHIx6T1JQh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="446389461"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="446389461"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 17:00:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="888436092"
X-IronPort-AV: E=Sophos;i="6.00,258,1681196400"; 
   d="scan'208";a="888436092"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP; 20 Jun 2023 17:00:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 20 Jun 2023 17:00:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 20 Jun 2023 17:00:26 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 20 Jun 2023 17:00:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbPh/UMPFIwA3oHZ2f5KFZuxhR1Hx5lCt8JuiImR4Qi0SvhWV/ZAiiuRGcrD6+y8CGk2q+tFPpbrrU/iB560nBNPd9U8SoBI7nnEc77UOJi09z51ODqqJK1RL57YUQXOyx5fkSDAF6/0TRxWi0N+z5FMruuDNrZwsMlOudgEFHjZqGnAzyGbChaQMaATsAQ3LS4hcO5ycj52QvsjGxfRSp7y0erFaLDNJ1PP+FcpkKehaV8QDI6cE5rQtTrUdqbjtoNwcjedeVpmgzxndWa999Qdsan1mXC9aBeRUbxvNtmyLsGwWft2REv/HIFZI38DObUQxRgWfMsKaBrpBWY8Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAhns8t4wAgDk/IB+BqgltwOzplMnAo8CTQaorSgmo0=;
 b=W5MEjbe8f1Z5dB60GdYG3thUZUEboWhyFbASYdDhrImhtSB+xCbcDOF8GhNoLpUFQm7mOhm619uXY1VfIYXsyHEt5WpgUpXryYbILhOHxeVCFbwRh4HWaujXFFCS65aOP6omfGTIYN6AV/QNnC68AhcCJlprIZZkGmXBmBL/WPZq7n6Ijh9eYAtgSIYDpa4ZHGG6MlSMRu5Yi7nxbJIy6216X/0P6bBzbiICpmUUAi7ISskLL6mE1lkdxXlVcWzmgN/5cxq1tU9Ivr9fKdAUoZM/5suSdoQlrkh0kWLcaPSbJiz8ikD6oYBp5/dsj/GaXSUb+pO42LXMqsvOuSjUbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SN7PR11MB6678.namprd11.prod.outlook.com (2603:10b6:806:26a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Wed, 21 Jun
 2023 00:00:24 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6500.036; Wed, 21 Jun 2023
 00:00:23 +0000
Message-ID: <9d186f97-42af-2386-d180-d6fc117fc415@intel.com>
Date:   Tue, 20 Jun 2023 17:00:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH 1/3] cxl/region: Move cache invalidation before region
 teardown, and before setup
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vikram Sethi <vsethi@nvidia.com>
References: <168696506332.3590522.12981963617215460385.stgit@dwillia2-xfh.jf.intel.com>
 <168696506886.3590522.4597053660991916591.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <168696506886.3590522.4597053660991916591.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR04CA0016.namprd04.prod.outlook.com
 (2603:10b6:a03:217::21) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SN7PR11MB6678:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b9f8b3d-2d1b-4722-dec6-08db71ea82c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +fSU+2ZEV1rLPUxutfMBL7HdHZl/aZLDSJ7TBc5DjFO/aj6kNMVeMJ/eXnlDdYRw2zP4DTllhq8WrfRVrA2hloZOSMlLZRptuHjT1HhDu8yaddFlPpOotcU6gteRfjU9lCQT5uVSPsPeJdtwCb6FGrskHndENM7mxt/EgrAv6nDtKITXJeU4eHkB0nqdelx0BF/wuqTrGNnHe/Ba0Vl0kUFaeEfPdlK1e35R0aqs0bh/rVrF6r0qMMm9S435G7hb8BQaXpj6OPp5luU0LZwAjQMdHA9ldxsmLmnVemhTgVDtI39K6UdPR2O5F+4JlQmYREyYAKARMsGrsGD+djFI7ji/JkXB9B32qQjcrvCJxAwb1/mxORo3mupXhJWNbjlgj4eEb60xfHe8nmvxZBLW+k+aNl6drSGtLdK2QJq4j7ySQh0PT8ssYrFfpAPv10dU//3Bh52sU8Ou2yeyV70c0OcCmJaHJ/4T82hnQ/R4h1BcfP7s20d41ky5IgtA2U2ZPVHvILu0iKSKfO8MSauHeJ8GukwMEGWts/cIBWRp2fgXAC/bintiDn81rlHcVBrZjGo2U6jcpDRKq38sy1BlEahWq2QsH4f+/pVygfj3T2ReZBRO5plPUFsvsEjeTqsmouXGtHrSxTvaHDUqdN/xdA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(366004)(376002)(136003)(39860400002)(451199021)(45080400002)(6486002)(83380400001)(478600001)(86362001)(31696002)(6666004)(966005)(54906003)(82960400001)(66476007)(66946007)(66556008)(38100700002)(316002)(26005)(6506007)(53546011)(6512007)(4326008)(2616005)(186003)(31686004)(8936002)(8676002)(5660300002)(44832011)(2906002)(41300700001)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHl1SDUxWWlMN0h0K2ROcVlXc1kxWFlBb2VKVDVnS1oyb3ZtMnpxaGNBQkVC?=
 =?utf-8?B?T3FGYXBUcWlMSkt0RHBaN1c3RGJ5YTdTdVJCTitvVXQzRnpJeTF0UDBLUm80?=
 =?utf-8?B?UGVRVVRIVExqTjBLVmd6Zm80K0JnQk5sWGR3ZkpzZFpjMmZudDB6bEhBdmt5?=
 =?utf-8?B?eGs3ZWM0WEFUNWZCejBjVE14Mm1DKzd0WjRpUmRsazQ2dEN2R1hGZFZZb1l0?=
 =?utf-8?B?Q1BOUnNvcHVpemk2VWtzdS92VjRJdGpmNDQ3N09Ic1NCaEtoMjFHTEhTektU?=
 =?utf-8?B?MmhpTVhsWS9WUWhQZHVVM21SWThaNFFUWGFxbjhvQ3daaFM2d2lQVk1DNkk2?=
 =?utf-8?B?Y2F4R2Jrdi90UzZvNlBYTkh2OGlBVTJoOWF3cmw3alowOUtEN09FVDJkMGo0?=
 =?utf-8?B?ZUNZYkVVUEJuLzM0MXh4NEVKZWlyTkc3TytDK2lYckpHQWRWWG9Qbk5mMzZB?=
 =?utf-8?B?NTBGRTFiTXJ0cWplQTdvdGVxSGJUeE5iU2hWeXBYUHZLNWlUZGhUU1VHM3o3?=
 =?utf-8?B?b2hBNEZmdzZ5SEVsVlQwdVFmS25jb25KaHFvZXJWNWpLemw5aytMWUhkNkY2?=
 =?utf-8?B?UTB4NWMza2FUREFnelloYVlXLzFmY1F1STl3RFFXUVpkMTVtZ3hRU2tNVkxE?=
 =?utf-8?B?VFZickQwaitwUms5SnhxN1NHd0ZqQ2UyODg3bFhpZkFEQ3FBeVZEY3lBTjJt?=
 =?utf-8?B?Vm0vWWxuSkRjMnEvdXd5RC81WU1lQXdjYTYvWHYrUC9yVXVURjJNSmE3c002?=
 =?utf-8?B?MUg2RDBUNEhDdU1IZ295RXhNb282cGU2WnBZUkFQSlJSeW0rK2U3VGxXRXN2?=
 =?utf-8?B?ZGlMWitRTEFqbzZ1ZWtVLzVNMG5TY3lEdUZsYzRPVnBpN1ZCbGNPLzgrRlNW?=
 =?utf-8?B?T0lQSE1XbGdFVDlrdFBJcXI5bVNVZDdYUWd3d2FUMDFxMmdabTNNbGxKTDlB?=
 =?utf-8?B?Ni95Z2xJMng1MWdpSWF1TEM2c2JGcHNsUFFXL3BieWY5K3lIRGErMHBhVXB5?=
 =?utf-8?B?V1JLb1RMUkp4MlhzZHMycmlQKzQyeXdEVHpwMUxoS2FzcmJoaDljNFF6WEhi?=
 =?utf-8?B?VCtlaFNXcjBudFhYQkFUUzFhSm9UdkN0Q1hyQlYvRUNOMk1kRVoyMjkzREU2?=
 =?utf-8?B?cHNhdjdYYjRIZ3h0d1NzNU4zblN1RDZUMVBscC9BcHBSRFZaYkFMNHBnSWRW?=
 =?utf-8?B?UW5JQUduRm1hUFlCTFdVdTNuTlFTKzVmNnU4enFaVFRWVGoxYjR5dHJ6c2Jj?=
 =?utf-8?B?alBtcy9Jd2s2eENicEdTN1NlSERjdTMvWWNoZXV2NkVuN3pkTHUrRVlqcFQx?=
 =?utf-8?B?c3RZRFhRSmM4MnZCREFjYitmaGw5S3Znd0JiNm52V1ErLzVRQTVXc0t4Ymdq?=
 =?utf-8?B?NFdMWkNLSXkyVnExTmtHK0t2N1NmZisvSUwyM2JlLzdPTVNBaTdWbjlOSXZp?=
 =?utf-8?B?R0dlVWR5bUlZOXo2bW44OUtZdVFIUThsUlBxUmhickdkUjRFcG81ZmxuSTRW?=
 =?utf-8?B?KzZtNnBQaGV4cW5PM3ZqWHpZQkZIN0o4VlRVYWVGWlMrYU9uNk5GR2J3K0ZE?=
 =?utf-8?B?bUpuTEV4YnRGUnExRUtvdDRKR1ZoNUJzNzgzVGkxNTE1TmJZTVBZaGxmbDc4?=
 =?utf-8?B?NU5rMjN6K29YaWc0SzJBZ2ZFNnFVVUNma29kYjVjbUpMcGY1aEZvRnJ1eTVM?=
 =?utf-8?B?WUZRa1hIN3BnYjJiVjh4WUx4VkJaTFlSaGpGODJ4aHE1MlMyRm4yekZUQTZs?=
 =?utf-8?B?VkhqT3JoZ0M5bEpqT3VkRk9sa09hYVl5SUwrbnk3UmtvdTlCVVlKTnArWEc0?=
 =?utf-8?B?ZlNOTU5CQ0ptT1A5aWFhcGQzMit5VmxPdDFaQ1N0SWl5dWhIaXg5dldtbENx?=
 =?utf-8?B?WVZTV2c4K095cDEwOFVpS3FOMThpOWNUQjBoaW5TMkVJbnJ3RElmb0t6akNj?=
 =?utf-8?B?ZStRR054MndXN3B2TWJZM1R1T3NUWWhiVGpSbXl1UmNVT2dVSktVZ2cvQVdy?=
 =?utf-8?B?YjhUMlRCRWRMaXBiOC84R0RjME55dmNmMzBHaC94UHdZcG54UXJOQU02SlR6?=
 =?utf-8?B?STFRQUVFTlVDaE12emxGYVBBVVErd0I2b3pjRkZrV1hYTk9aTDdEblNsQ2py?=
 =?utf-8?Q?yWwE85iWuRnhDoyP1EH3mPcIR?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b9f8b3d-2d1b-4722-dec6-08db71ea82c6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 00:00:23.8085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FaVSWwet0mubFICLDEFibiFzP3d2cq3AhRIqSU4FRtHKqc3YpSW3UjmTXmt6UlljpH9NhcWEVHzmyOorM0/A2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6678
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 6/16/23 18:24, Dan Williams wrote:
> Vikram raised a concern with the theoretical case of a CPU sending
> MemClnEvict to a device that is not prepared to receive. MemClnEvict is
> a message that is sent after a CPU has taken ownership of a cacheline
> from accelerator memory (HDM-DB). In the case of hotplug or HDM decoder
> reconfiguration it is possible that the CPU is holding old contents for
> a new device that has taken over the physical address range being cached
> by the CPU.
> 
> To avoid this scenario, invalidate caches prior to tearing down an HDM
> decoder configuration.
> 
> Now, this poses another problem that it is possible for something to
> speculate into that space while the decode configuration is still up, so
> to close that gap also invalidate prior to establish new contents behind
> a given physical address range.
> 
> With this change the cache invalidation is now explicit and need not be
> checked in cxl_region_probe(), and that obviates the need for
> CXL_REGION_F_INCOHERENT.
> 
> Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Fixes: d18bc74aced6 ("cxl/region: Manage CPU caches relative to DPA invalidation events")
> Reported-by: Vikram Sethi <vsethi@nvidia.com>
> Closes: http://lore.kernel.org/r/BYAPR12MB33364B5EB908BF7239BB996BBD53A@BYAPR12MB3336.namprd12.prod.outlook.com
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/core/region.c |   66 +++++++++++++++++++++++++--------------------
>   drivers/cxl/cxl.h         |    8 +----
>   2 files changed, 38 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 013f3656e661..d48c5916f2e9 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -125,10 +125,38 @@ static struct cxl_region_ref *cxl_rr_load(struct cxl_port *port,
>   	return xa_load(&port->regions, (unsigned long)cxlr);
>   }
>   
> +static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
> +{
> +	if (!cpu_cache_has_invalidate_memregion()) {
> +		if (IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST)) {
> +			dev_warn_once(
> +				&cxlr->dev,
> +				"Bypassing cpu_cache_invalidate_memregion() for testing!\n");
> +			return 0;
> +		} else {
> +			dev_err(&cxlr->dev,
> +				"Failed to synchronize CPU cache state\n");
> +			return -ENXIO;
> +		}
> +	}
> +
> +	cpu_cache_invalidate_memregion(IORES_DESC_CXL);
> +	return 0;
> +}
> +
>   static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
>   {
>   	struct cxl_region_params *p = &cxlr->params;
> -	int i;
> +	int i, rc = 0;
> +
> +	/*
> +	 * Before region teardown attempt to flush, and if the flush
> +	 * fails cancel the region teardown for data consistency
> +	 * concerns
> +	 */
> +	rc = cxl_region_invalidate_memregion(cxlr);
> +	if (rc)
> +		return rc;
>   
>   	for (i = count - 1; i >= 0; i--) {
>   		struct cxl_endpoint_decoder *cxled = p->targets[i];
> @@ -136,7 +164,6 @@ static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
>   		struct cxl_port *iter = cxled_to_port(cxled);
>   		struct cxl_dev_state *cxlds = cxlmd->cxlds;
>   		struct cxl_ep *ep;
> -		int rc = 0;
>   
>   		if (cxlds->rcd)
>   			goto endpoint_reset;
> @@ -256,6 +283,14 @@ static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
>   		goto out;
>   	}
>   
> +	/*
> +	 * Invalidate caches before region setup to drop any speculative
> +	 * consumption of this address space
> +	 */
> +	rc = cxl_region_invalidate_memregion(cxlr);
> +	if (rc)
> +		return rc;
> +
>   	if (commit)
>   		rc = cxl_region_decode_commit(cxlr);
>   	else {
> @@ -1686,7 +1721,6 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>   		if (rc)
>   			goto err_decrement;
>   		p->state = CXL_CONFIG_ACTIVE;
> -		set_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags);
>   	}
>   
>   	cxled->cxld.interleave_ways = p->interleave_ways;
> @@ -2815,30 +2849,6 @@ int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)
>   }
>   EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, CXL);
>   
> -static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
> -{
> -	if (!test_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags))
> -		return 0;
> -
> -	if (!cpu_cache_has_invalidate_memregion()) {
> -		if (IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST)) {
> -			dev_warn_once(
> -				&cxlr->dev,
> -				"Bypassing cpu_cache_invalidate_memregion() for testing!\n");
> -			clear_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags);
> -			return 0;
> -		} else {
> -			dev_err(&cxlr->dev,
> -				"Failed to synchronize CPU cache state\n");
> -			return -ENXIO;
> -		}
> -	}
> -
> -	cpu_cache_invalidate_memregion(IORES_DESC_CXL);
> -	clear_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags);
> -	return 0;
> -}
> -
>   static int is_system_ram(struct resource *res, void *arg)
>   {
>   	struct cxl_region *cxlr = arg;
> @@ -2866,8 +2876,6 @@ static int cxl_region_probe(struct device *dev)
>   		goto out;
>   	}
>   
> -	rc = cxl_region_invalidate_memregion(cxlr);
> -
>   	/*
>   	 * From this point on any path that changes the region's state away from
>   	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index f0c428cb9a71..187abd8ba673 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -462,18 +462,12 @@ struct cxl_region_params {
>   	int nr_targets;
>   };
>   
> -/*
> - * Flag whether this region needs to have its HPA span synchronized with
> - * CPU cache state at region activation time.
> - */
> -#define CXL_REGION_F_INCOHERENT 0
> -
>   /*
>    * Indicate whether this region has been assembled by autodetection or
>    * userspace assembly. Prevent endpoint decoders outside of automatic
>    * detection from being added to the region.
>    */
> -#define CXL_REGION_F_AUTO 1
> +#define CXL_REGION_F_AUTO 0
>   
>   /**
>    * struct cxl_region - CXL region
> 
