Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96696EB64D9
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jun 2023 17:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231852AbjFORIW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Jun 2023 13:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237271AbjFORIS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Jun 2023 13:08:18 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC502695
        for <linux-cxl@vger.kernel.org>; Thu, 15 Jun 2023 10:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686848897; x=1718384897;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=K/a6KoK2YgnnubM/k1+GHPwJJzX+4RsPmrozeesql2U=;
  b=aSXC6bETBQRLwzWB/G7/x/jSnl0eB3eit0Kkm5I5k4O1LXyz7q5pGko9
   QjkEkMlmAwzvStvxF4wYdxRdsdkVkwiofFusBoVilIFzyVyA8PqC9sl9k
   Xsx3agD31X/NFDTdHD/Lc4lwzaS0PVqdgi8UQIldBN9lNZybxjH0/e0IA
   tZeR5qiFGjUHmaoFuzAdZg2TyCqWGuJOERALpx73H2qOtZ7cXb6sSkStE
   mRWDWhZtEMk9/Q/eiFwwVwES3yuP5dijEkWkkvn7NNKtXjPBCF4mb4oIx
   Sk7paNIeDH+HZ08PJHH9dHqIv/A3cI64eJwd7V7CyzcQuT8uSemHuMxdX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="387521444"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="387521444"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 10:08:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="715690952"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="715690952"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 15 Jun 2023 10:08:17 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 10:08:16 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 10:08:16 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 10:08:16 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 10:08:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CK154j1p1J4dysiX8w5jCYW3KSQ59PHAkCf5soxb8ZNFKUM+jkPH6rC7W4P3p89h7NDcJyvd3ZhYZaf0hoRvSGNY98PypXiCaZyrxXLZW9VGwOnFH/ueslgr8CcfbL4ln7uqbFSHAOYjRzTh+Eu5efB2UwqH+jKsgigHiiygGbzRUfrpKp3hnOOVKFvcZRjGMinsOXGNK6etQ/4qFHUMpCvXpZM+W24XgJxX/9+pvHT4j8Bre4/5Wv7Je7vzTkAr5b1ulzrvnuEUgAP46wN0L02AtakL9FIeJWuR4u3afdvEJmcXYZnOKaOSyhY1jeScjIHgeuFG/zj3bxAhAA7Fzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=teRlBF7/qaCrzzLTp4y9CVD6pkS9Ay3OkgRgA/JdC+k=;
 b=b0siyLKVvFTJV+8rxBrPCbwTUhN9sDDAwmpesp2tHKotmnA9C5GPL+2gc5JxWMg+YTsvlMnwO5OWv3chAUOAU4u5rnl4Q092sVfMGyVdMNnCF9F4qU2DhQKQgPU44/YBHPDTFEffm18lPqtk/gF3AIt1lTMLSkyMUVQRI7k47zALfwhK5Xf4tvv++/8PkIbeR+I0Zx8z4c7+UJhCw+j41iPAVrex5N8OOvsphy0p7/m5wAdyqEvwGKFdVVHAEdYStwRrlqeHYrZLbKCsxoWv0ZsV95sKaOAxLEM3LpmER1Sp+ria8gMjLpz9LynLq/rVi5yk8c1GpljYnp6XXsZh8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by MW4PR11MB5799.namprd11.prod.outlook.com (2603:10b6:303:181::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Thu, 15 Jun
 2023 17:08:13 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6500.025; Thu, 15 Jun 2023
 17:08:12 +0000
Message-ID: <42a5bf0f-dd14-3968-72d5-e55f4edf5113@intel.com>
Date:   Thu, 15 Jun 2023 10:08:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH 5/5] cxl/mem: Trace Dynamic capacity Event Record
To:     <ira.weiny@intel.com>, Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
References: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
 <20230604-dcd-type2-upstream-v1-5-71b6341bae54@intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230604-dcd-type2-upstream-v1-5-71b6341bae54@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:a03:254::22) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|MW4PR11MB5799:EE_
X-MS-Office365-Filtering-Correlation-Id: 750eeaf8-2b6e-4842-67b6-08db6dc319fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Us3YIepzlkeshH39PMoiJ6z4IZJbJ7TxV8uY8btBqPQjeolLeLLsa+4hhckhu/4G6q0GRHhQJR4/bdP4oROYlQdB7h5xNU7+B5XT+HKXdtF3B2sTSoP5j4PWp3v1WQNvi81WdIyEYEP64BkeynrOLQyf+X8Y0/s23t3nuGj+6FG3p+5NUf3wBab+oqjPRkzaOo+9g6b+u2KCZrzJP92Ko1yfskB2Mlv5c1+1pmZT/cD0oNgcfYGUcIeqYRLbZuvfqGyjYUYSfcV9RBnDOLCn+94DviY4nY4ahMTvnfvIjqmz0ub49VCr+kHc2zwIzUuQDBo93XvDi7L0eJiYMG6FTQvo3M/E5uYNteajy8biTT9uantgn0AlB1jnSz4NYcmVne/t0fz2CXPt2cRm/fBw8pJeWUEP+/wSiJ77wKH+HEktM3kTPTTRt5txEhTV8K2qcGeWQGByKb+w87Heq+GZA6dcFQ+tpLG22qce51sEOgdm6Dil8eWLPn5aI2342JpeLsN+Y9iLqioSpAzsOuI6dapc32djCP/DNXEwCJ1ZDLwHu9Bl0ymsEq9Z0G6zRkc8XRfZWPF9znyIKfs/Zf6cA08825mOKOF6AEoikvfV6nDOEgDq0RsGEFbpKtFhpBo5UK0yp9TDe3groHg5asdyQQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(376002)(346002)(396003)(136003)(451199021)(31696002)(2616005)(83380400001)(82960400001)(36756003)(86362001)(38100700002)(478600001)(44832011)(110136005)(8936002)(6486002)(6666004)(2906002)(8676002)(5660300002)(66476007)(66946007)(66556008)(31686004)(316002)(186003)(53546011)(41300700001)(6512007)(26005)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Tmk3SGVISjN3WmNqeVhLSHdPMlpiWTNyYjJJS0pFSkxzTUdoTlA1c1IyMmN4?=
 =?utf-8?B?bDZ2SHdhd0VnTmJoaE02VUNwb0NaVmxPZ2F4amRZVHZ3OUV0dkpnWlp5VUtB?=
 =?utf-8?B?aFFBaGRaUmNVNzk5YlV5Ykx2dGtvS2xVSGRUS1FqSGdPQmtBQ2tTTjh2b29t?=
 =?utf-8?B?WGVGenBLVzhPSE9ydWhDZGdWWU1QS2Z5dFpEclV1eVZTRzltb3lFTWU0M29s?=
 =?utf-8?B?UlpWR1p1WlJwblpkaTNWd2ZhaXd5cUFHZyt1RzErY2JocHQyZHcvREV4NEtI?=
 =?utf-8?B?Q29QQmsyekROaVpVN3I4RjBCK2RuVFFmczduaE16Q2NsREMwK3dkMDVuWDBZ?=
 =?utf-8?B?VzBRVHU5K0ZBSVN1RFhybUhUWU9IM2hnZjZhcko2YXRCYUsxNnVYNGl3ME4v?=
 =?utf-8?B?TFdxNE9oQmYweXVuVGRNMzJzSy96aG9FYWFGZ2tCUmZjWFVDY2hqS1F6SGtN?=
 =?utf-8?B?Vmx5TDhybGZMVU8yQnhEcnlTTDR6V2pCei9SWjN1WjJxSitqdmovdStzTHhM?=
 =?utf-8?B?RUs5cTc4MlhTQTliYXQzVjkvQnR2Szd2WFlGR3hVT3gxTFkzSTRwaUs0THV5?=
 =?utf-8?B?akdQK2VURVpxZ05pMW5XU21VankzZGdsM0tUaVBhVnFJWDNhNkJmcXJVSVgw?=
 =?utf-8?B?VXlWejdSUjh6cjY4Y24wK2NVTnlIWDZKWkMyeXZnQUl3UG9KL1d6NW1FNUxD?=
 =?utf-8?B?Snl4UFdWRDRzaGJiNXIwOFUyTGdQaExWZzdscnU3YnhRL1ZFVnZLUHlQMmpB?=
 =?utf-8?B?d0laclRHK0l4aXlrUXZFOE5lMnFqRkFKRFpCZFlGS3BYV1FYY2Fua3k1UFdo?=
 =?utf-8?B?UDV3ZVltT2dNNmhLNkEyeWNPcWlJKzFicGdIU2V4NDg3YURyc2VidXdSd1dw?=
 =?utf-8?B?ei9EdHljMHdVTXBGTy9XMlA5QkVLTURCUVAwOXRuUXFjOUE0MXBHc2JjZzFU?=
 =?utf-8?B?N2dmRDFVMG50TFlmSGR6WmlzZUc3NzNZRFZKYXdXb3h3bXNRYjBHeHhTYTZC?=
 =?utf-8?B?Z3VFcDZzcnVDdXl3elFkMEk0V0JsSzUyWENiRk5VME5KMkVpb2RicnRrK3pY?=
 =?utf-8?B?RklmcjJhZU05aDlBREljQmUxbkhBckw0YnFZK2xqaVh6Zm1UYmovM3dqK09p?=
 =?utf-8?B?aHY1bTFrRUZlODFnRSs0WmdpMEhRckZOT2pFdjB0QVZMbE1sckd5aSt3RTZ1?=
 =?utf-8?B?VC9SdVBwd1JhKytqYnE2R3FIc2dBejJ0aDh6NExRek1NUWw3bC9mR0Z4bWJR?=
 =?utf-8?B?ckI5VUtZYTZnekgwcTBOWEZ1eUQ0OWJmUlVybk05WGRZQjlHQXI1MWJaa1BC?=
 =?utf-8?B?czVQNjZyTG5LZkNOdUZnUExDTEkrOExGV1NZa3hhaVFWYlRWNlplNDlIdlhm?=
 =?utf-8?B?dit4clQ4UTZYZGthWFRGVnFPYU11bm45QjZmMk9RaWl2Y096V2Iya0Zjc2hP?=
 =?utf-8?B?Q0VQVmhZNTJ5eVpGaGd3Smp3NG5UdSt3OG1JZEFOOGZrNDRmLzRFUW1vdTY2?=
 =?utf-8?B?MlhKLzFvSFFVQ3JSdUdMaGg2cGI1OXR2WDBkWUlmZm5nTVBoV29oYzBLYXI4?=
 =?utf-8?B?RDZQRXJYTXRqdmU2KzN4Sk1LRjJTODZ5S3A0UXBxV0JzeDR4QWxMemRIVUVy?=
 =?utf-8?B?aEFiaThhY3hENTdUYWpYR0xmWkQ0UG11NlZjRDdlOHBwWW5Ld2UvUDhYZVcw?=
 =?utf-8?B?Zjg4MXNaOGRLZjl0WFQ5OXI2Tkt1WUxsUlZwNldpNVJXOVh1b1Y4Q2htVWRB?=
 =?utf-8?B?Z1RNeER6cnF1djMrcG5zWHhiYVZXb081QUwxUUk0c2xFaHhCcUhhK0pNUUZ4?=
 =?utf-8?B?N2NaS3BuZzVacklNTEpGeEt6YmZBK1ZaUmYwdmNrdnp4SkwrUUFjWUtqRXpt?=
 =?utf-8?B?TjdXSnJ4b2F0M3dFVWM0Y2dYUm5xNDhlcFgxdGNYR1VNZThOejQ0bUlyYXhs?=
 =?utf-8?B?Y1RSekwrYm1yY1ZqVDlzejlsVC8wcTVVVXlta3ZUbm1yMlBlNGxCaHg0UGhm?=
 =?utf-8?B?UmwrZCtnbmhCR05sN0VXR05YV2JHQkZwalhqY25zRWVsbk9JMXNsQjRhdEFS?=
 =?utf-8?B?dmR0Tm0zeUtOV1hDR3VsWVMyemtpRTl6LytqTHN3VWdrTnZzTUF4cGFISFdl?=
 =?utf-8?Q?mGA9Tm/zztn0UO06EZBxyxN6N?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 750eeaf8-2b6e-4842-67b6-08db6dc319fc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 17:08:12.6846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jo8GDRQtUjH6JdX9S8nRS8ayx8imUbbGGvjdHOJoZty6dfcqQLia3Gh4Ls+ogmKGRsNuPZUBzUrCH7HqiqvTgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5799
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 6/14/23 12:16, ira.weiny@intel.com wrote:
> From: Navneet Singh <navneet.singh@intel.com>
> 
> CXL rev 3.0 section 8.2.9.2.1.5 defines the Dynamic Capacity Event Record
> Determine if the event read is a Dynamic capacity event record and
> if so trace the record for the debug purpose.
> 
> Add DC trace points to the trace log.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>

LGTM

> 
> ---
> [iweiny: fixups]
> [djbw: no sign-off: preview only]
> ---
>   drivers/cxl/core/mbox.c  |  5 ++++
>   drivers/cxl/core/trace.h | 65 ++++++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 70 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index db9295216de5..802dacd09772 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -888,6 +888,11 @@ static void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>   				(struct cxl_event_mem_module *)record;
>   
>   		trace_cxl_memory_module(cxlmd, type, rec);
> +	} else if (uuid_equal(id, &dc_event_uuid)) {
> +		struct dcd_event_dyn_cap *rec =
> +				(struct dcd_event_dyn_cap *)record;
> +
> +		trace_cxl_dynamic_capacity(cxlmd, type, rec);
>   	} else {
>   		/* For unknown record types print just the header */
>   		trace_cxl_generic_event(cxlmd, type, record);
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index e11651255780..468c2c8b4347 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -704,6 +704,71 @@ TRACE_EVENT(cxl_poison,
>   	)
>   );
>   
> +/*
> + * DYNAMIC CAPACITY Event Record - DER
> + *
> + * CXL rev 3.0 section 8.2.9.2.1.5 Table 8-47
> + */
> +
> +#define CXL_DC_ADD_CAPACITY			0x00
> +#define CXL_DC_REL_CAPACITY			0x01
> +#define CXL_DC_FORCED_REL_CAPACITY		0x02
> +#define CXL_DC_REG_CONF_UPDATED			0x03
> +#define show_dc_evt_type(type)	__print_symbolic(type,		\
> +	{ CXL_DC_ADD_CAPACITY,	"Add capacity"},		\
> +	{ CXL_DC_REL_CAPACITY,	"Release capacity"},		\
> +	{ CXL_DC_FORCED_REL_CAPACITY,	"Forced capacity release"},	\
> +	{ CXL_DC_REG_CONF_UPDATED,	"Region Configuration Updated"	} \
> +)
> +
> +TRACE_EVENT(cxl_dynamic_capacity,
> +
> +	TP_PROTO(const struct cxl_memdev *cxlmd, enum cxl_event_log_type log,
> +		 struct dcd_event_dyn_cap  *rec),
> +
> +	TP_ARGS(cxlmd, log, rec),
> +
> +	TP_STRUCT__entry(
> +		CXL_EVT_TP_entry
> +
> +		/* Dynamic capacity Event */
> +		__field(u8, event_type)
> +		__field(u16, hostid)
> +		__field(u8, region_id)
> +		__field(u64, dpa_start)
> +		__field(u64, length)
> +		__array(u8, tag, CXL_EVENT_DC_TAG_SIZE)
> +		__field(u16, sh_extent_seq)
> +	),
> +
> +	TP_fast_assign(
> +		CXL_EVT_TP_fast_assign(cxlmd, log, rec->hdr);
> +
> +		/* Dynamic_capacity Event */
> +		__entry->event_type = rec->data.event_type;
> +
> +		/* DCD event record data */
> +		__entry->hostid = le16_to_cpu(rec->data.host_id);
> +		__entry->region_id = rec->data.region_index;
> +		__entry->dpa_start = le64_to_cpu(rec->data.extent.start_dpa);
> +		__entry->length = le64_to_cpu(rec->data.extent.length);
> +		memcpy(__entry->tag, &rec->data.extent.tag, CXL_EVENT_DC_TAG_SIZE);
> +		__entry->sh_extent_seq = le16_to_cpu(rec->data.extent.shared_extn_seq);
> +	),
> +
> +	CXL_EVT_TP_printk("event_type='%s' host_id='%d' region_id='%d' " \
> +		"starting_dpa=%llx length=%llx tag=%s " \
> +		"shared_extent_sequence=%d",
> +		show_dc_evt_type(__entry->event_type),
> +		__entry->hostid,
> +		__entry->region_id,
> +		__entry->dpa_start,
> +		__entry->length,
> +		__print_hex(__entry->tag, CXL_EVENT_DC_TAG_SIZE),
> +		__entry->sh_extent_seq
> +	)
> +);
> +
>   #endif /* _CXL_EVENTS_H */
>   
>   #define TRACE_INCLUDE_FILE trace
> 
