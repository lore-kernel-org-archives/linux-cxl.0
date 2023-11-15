Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AkvjiBVR"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B96A2D61
	for <linux-cxl@vger.kernel.org>; Wed, 15 Nov 2023 09:38:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700069914; x=1731605914;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wITvLLNidooBloXJcIC1dLJyPDReIV92oTepOsarKSo=;
  b=AkvjiBVRh69JoUuGBdoJYQ8/WnAntnphOPTPeIqkWLTlc2P1aP33bzwY
   0bljZgoB02pfVuxi15gQAs+AHoncm5Bg/vIdOMD7grNoC9wpL0yA7TYl+
   /tR+t5bZv+/K6JG38/ASgMPuMiLre2gh7oHEnJNMf/ZSEloHnkIqpTffM
   oq1h2+cC8j/IS0lsDa05IExEO4/BfgHQEuyeSEOe63lhqzfgywWHVnYVF
   pIafqVb96B0srP1rtIl3gLCLmsRQS9aXEStt/P14TpS1OTaCfwhRYFvOn
   /Ay12yeEAwd9DhTh1zOmUUUG7f+J+LtDllB95S9SAqqdsMJ0mrOzXQpTg
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="4000740"
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="4000740"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 09:38:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,305,1694761200"; 
   d="scan'208";a="12840005"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2023 09:38:31 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 09:38:30 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 09:38:28 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 09:38:28 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 09:38:28 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k2B6JRJMJXhOhxJH20LQ5MJnHRQfCVVOKun71fcZhvrQnz0xCOSWz0ef/uaTke8l2naEdjS1kRSKRGW0OyE9LTSxlIbOXnWFLfFNZnTfUsVwPqQpXyv4/RuBaBcACdYF3veSfSOBrXThA51CcD1+LyCNcIa0XZXIZ0F7vTSAHRkA/EzK0qTYMGrdKly6RbpY24WTdHO0c5EW8s3AGCVaNDr5Q83sPiUjbNeu5Kizp/P3rTUwIx9LfllBLfibO2L7uhD6+4B6imXMlL85wjXRKspmOG49x417yZv7qd94O2fdnuSbqVnMady7IxASgJgJMe1CobsPYZoCzczdV0pIvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8miXOokvCwaWCv3XdjWlexK+TNwzLstrAGJqCSNy3wY=;
 b=QiQQ8hnY6lu05nsXPJopAy0yM09Unkfpmb5kkLVxPb6TfbSmS+sQ266E+igUuHT/uUrXwUJDuWW+7drlx1z87l9WkAWI2nraAbqoOGRYWTFZmzjnozamUwZqjJOQjPFKjgjCnobSs3UYnhEuwPArU6wXkRoKnNM/H9StVC4hmDgyMhzZPt9+Jk6oz7GsuPwMez9T3Nnd2sSNRpFh8ADc4Jih+7Q/3BzTKLDLP1yDJINqbZXmSXCJPBfVBRb1U1RYFIYxtQ9xFeaHefG2VVj4HOh7BPj205naZ2iecImSir68e0boXNXdoDrZGjh2CPom3n8iMNAwarfpM+o2PqNYbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SA2PR11MB4795.namprd11.prod.outlook.com (2603:10b6:806:118::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 17:38:26 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::28a6:ecda:4bb7:2f9e]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::28a6:ecda:4bb7:2f9e%7]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 17:38:26 +0000
Message-ID: <cce6fb21-aee3-4547-b7ef-7f043305e330@intel.com>
Date: Wed, 15 Nov 2023 10:38:23 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [PATCH] cxl/region: Add dev_dbg() detail on failure to allocate
 HPA space
To: <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>
References: <20231114040147.1124696-1-alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20231114040147.1124696-1-alison.schofield@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::28) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SA2PR11MB4795:EE_
X-MS-Office365-Filtering-Correlation-Id: 3edaebba-8efb-49c3-bdbc-08dbe601ac3f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AU/6GBfpmF20ogOwVrR2u3Nggfes/eMUycYSMJVXdyqax5aZlCF1gRwybuL0v65p+RsL8fu1K633eoynqLe5YzW+5aU5y1KPg74Jctfq6VRFLtwNHUAL8E7BKdlLMiutVvEcJCFolaGHAzbwD9MElw3KOh/9AGebpMnC77ZsV5A/w0OUnm0ndJnbFd12p9/rWRdTk8vnQLyka3y+ayznskhUTjQgTIZKXOQA02IThc8rBJJ5pmjvyla9VRrgQ/ax7/FgjE8VrYGVgeMszMqXXSR9xj6MDx25POUMU269kFmjtEp/ONZ15jISqgBxYAl5HzoZBsHUYK3dR44IE2rDRJhD5BFkyi7uxmGahkI0kXC+V20AoeFpG771C3T2JdcsLULa6RzGmy4FFSB7o9FFVea1eWO7xassZOVZIqfRzMqGOa7Y3o5EMz+J8jyeYP0y/MOdUOZlERlMLZcXxuMS6SLA8K9eYN3yZzJ4Tk+M/qmUvitMqXlH/qTeEplWvmjJWpvBJARJVqtiZIZUchcXoeyLKhaKkwQfmoTyF8sAYeO6wdkhcpqMQhTDDyAaaU/JZMFr9QwLuayw95QUCiI4y30u3HvsXu08GDhckxvf0YpdRCbTua93bEc7E4G1o3C3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(39860400002)(376002)(366004)(136003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(6506007)(44832011)(6512007)(38100700002)(36756003)(2906002)(26005)(53546011)(82960400001)(83380400001)(31696002)(86362001)(41300700001)(2616005)(5660300002)(66556008)(478600001)(6636002)(316002)(66476007)(66946007)(6486002)(110136005)(31686004)(6666004)(4326008)(8936002)(8676002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUpaVUdoQ1M3R3diVkNkL3E2ckFtVURCWGF4cmFoLzQ1MnVCTzBvS2dhVnhM?=
 =?utf-8?B?Um5ZaElkYUJrM0gwTXFtdThkNUpGRnArOWN4RWlZWG1QdkhEVGdha3J3SWRi?=
 =?utf-8?B?R1RtSUp2ZGlQVEZFdzZnaUlYMmxiRmFFZExTclVwOHpwREk4VEdnOGZXQ3d1?=
 =?utf-8?B?bC8zUTZrVjZRenNrSldOYWhuWTQyT0kvN1h3YzB4VG5DNmVmNXhlY2REMzFx?=
 =?utf-8?B?T2N5S1BIK3dSSS9kVnErRUh5anBZcUhVZmMzT2tyVThLb3FabElzMHhtWnhY?=
 =?utf-8?B?WnMybG1XaGtmci9jTHlDWjlDQm15a2Y0YWM0azVuVUFhN2lhR2lndXRCcjg5?=
 =?utf-8?B?QjM4SnVYWGNqbDNlZWEwOFNwTkQ5SmdzV3loejAvSXgxaU9mQitDTmRPeGFs?=
 =?utf-8?B?OEtKZ25ORVlCRUJ1YXpBa0dVVFVzVk5PQ240RGhsci96VjRraVVkUythampQ?=
 =?utf-8?B?WjE3NTBqTVN2TStzajNUdGJ5M21Hc1lCU1FtYS9YNkNQQU5VM3IrZEF5b2Nm?=
 =?utf-8?B?em00aEZIQkx2T1g5SXFsc2ljRG41K1pUM3JkcUoxc3FONGJ0dFMxdFFwcmpQ?=
 =?utf-8?B?NjBTcFlQYUVleXRrMDRBWkJyRTA4d0s0aFRpRzZ2T3NqM1hBVkcwMXFyWWFW?=
 =?utf-8?B?YXBQTjJSbktOb0QwaEtxNjJpZkgxd2MwMnV6eGVkcXo3MUQwRmJCRStCMkdE?=
 =?utf-8?B?VnZNdER5NWJ1ZGw3NFdFenhJSy9tME5wNkhVTWk0SlUzaElXS2tCdS9VendP?=
 =?utf-8?B?RUZBOFY2QTY0dUtPVzZWV21FNUtielBsaSszTUdEdWY4QWUzTnhjZjNXbGQ5?=
 =?utf-8?B?OXdNTmxJVm9tcFh2YVJURjQrR1QyQ2Q0ZjZDbkk0WTFLcTZrMVBWNndLOTJT?=
 =?utf-8?B?bUdGbXF3MFNjc3Noa2o4NjFHdHFLSyt6d2pIdkZYZmZTSzZkTXRBeVdicVBp?=
 =?utf-8?B?ZEYwKzNrTDBnOXJ0WWgzMC90NVNmNWVXNEdaMjBTNk1YTldrbFdMQlY5UUVp?=
 =?utf-8?B?UFB0SUtXVTF0OTJhUzJGSXREd1ZlU2FCZWpFUFdWQTBQbDhkbEJuN085UGxJ?=
 =?utf-8?B?K1lRSlFLZkR6UjQ0Q2RWVndVQzREbEJMN1hBVFV1UWtLRi8rMXBuQXJVc09C?=
 =?utf-8?B?MTM4ZzUyODk4YTJDK1d2T3l4NGJYQ05jNSt6K1BqaElWWGFqWEVtZmlTd0NW?=
 =?utf-8?B?b2hiMEx3THk4VVE4d21RQktqYTFDdGV4aFppRHVDbyt5S1lQZStRWXN6REtW?=
 =?utf-8?B?bE0yOWtLV2ZBY1JQdlVPSEgrL2w4RUJ2aDk0SEpsdHZ4QTQwc09vUGpPUzhu?=
 =?utf-8?B?cjRQMWlJVE5SRWFTdHRlejJmOWF2Y2paaDlZRURjWXBGSm9lTzhiM2hoU0tL?=
 =?utf-8?B?ekZNbmMxR1ZoZ1BGMU1PbGE2QlUvTG45WGovdThXcVFKalB5cDU1KzRoOStz?=
 =?utf-8?B?TGNHekFVZjN3TERtRnZsMXhDOGo0am10M3JyYzVXZ0hSdmU0OXowQkl1dFgy?=
 =?utf-8?B?ai82Z3FFRTJZRnhJK0hRZ08zb1FUdXQ4SDE3dnZDb3B2WlBwc1FKZ1RWVzJi?=
 =?utf-8?B?TkVGRS9ZUEkwU010amJXRTdmblhBZDZEWk82WEk4MXNUSVVtRW1tS2dFODRI?=
 =?utf-8?B?aXo2YmEwbmNrYS9iZElKNHZyN3hzclN4cVNHamFDcDRvZDBpZVZvT1ZCVmZq?=
 =?utf-8?B?TU94aWhyelhCV0lQQ0FZUkNBeG5VUk4yQmNNRGtJWjhVTGNXdFI3aEpnWU5l?=
 =?utf-8?B?SjNpNHZCUll6YlphdkNWMjdpMVZCUUozMFZSMkdLdUU0MUs0MnVSME1xMWRa?=
 =?utf-8?B?aVNTVWx3eGQ2ZnBIRHAweDQzL3BORExuTFZjN2RBWnZkYUVabzVBMTFZaHBV?=
 =?utf-8?B?Y2VPZGY1MForaTBiMjl4SUk1NVk1TGU4eEEyUlhBMW1kalJmbzB1RmlrbE04?=
 =?utf-8?B?cVFsZnQyak1tQmtUeUJuQ3E0UWFrL2hkV09ZdWw3MnNiRFdwaU1LNzd2dmxS?=
 =?utf-8?B?NEFWZ2psQ0l1U056KzFuQklHYmh0RDN2OXdCUlNaMmhxanJ0UjF0Mk9hc21L?=
 =?utf-8?B?OStuVFZsb2Z4bWtRcXhHNGdkM0pxajIxMVVlcnQxcTZuRzl1N1JucHpmdHU4?=
 =?utf-8?Q?gMIuvROeie/9flnJfSxm4Q6WW?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3edaebba-8efb-49c3-bdbc-08dbe601ac3f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 17:38:26.5022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sOfjC4fzhYnlmuhJu2Dzdf0QBBMwdQZtEj/El+7nRwrd+wBSauEmK1o5obczinwmSrtpRaslR8pEg6Uuw0EjcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4795
X-OriginatorOrg: intel.com



On 11/13/23 21:01, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> When the region driver fails while allocating HPA space for a
> new region it can be because the parent resource, the CXL Window,
> has no more available space.
> 
> In that case, the debug user sees this message:
> cxl_core:alloc_hpa:555: cxl region2: failed to allocate HPA: -34
> 
> Expand the message like this:
> cxl_core:alloc_hpa:555: cxl region8: failed to allocate HPA:-34 size:0x20000000 in CXL Window 0 [mem 0xf010000000-0xf04fffffff flags 0x200]
> 
> Now the debug user can examine /proc/iomem and consider actions
> like removing other allocations in that space or reducing the
> size of their region request.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/region.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 56e575c79bb4..0e6a378f1913 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -552,8 +552,9 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
>  	res = alloc_free_mem_region(cxlrd->res, size, SZ_256M,
>  				    dev_name(&cxlr->dev));
>  	if (IS_ERR(res)) {
> -		dev_dbg(&cxlr->dev, "failed to allocate HPA: %ld\n",
> -			PTR_ERR(res));
> +		dev_dbg(&cxlr->dev,
> +			"failed to allocate HPA:%ld size:%#llx in %s %pr\n",
> +			PTR_ERR(res), size, cxlrd->res->name, cxlrd->res);
>  		return PTR_ERR(res);
>  	}
>  
> 
> base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
