Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A37AEB64DA
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jun 2023 21:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232666AbjFOVa5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Jun 2023 17:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjFOVaz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Jun 2023 17:30:55 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CE41FFF
        for <linux-cxl@vger.kernel.org>; Thu, 15 Jun 2023 14:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686864654; x=1718400654;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=cfKSog4S4uAIm260wyje/Y4dbVSvIuG3BTsbXFXSWFY=;
  b=QUfTjxG1NU6zl/S+XEKXZ6dFnzJweNsPVj7T5hoYloqvVvn5Rt8fj57W
   0WAtGbIb33HnmG24mWYzWTgUoVV5SFne2a/bWlG4xwizqAPqBo2beLddn
   220WfmerkxThbOs4ERor+Z7JLFNtKm9GMya8NHkjhv28TJ8UU3FAcyrZD
   Hdvk9aIGLKvs1DNrwX4T7vJfLmVtvtXbj8MFrsGFy9165FiiNpU11uoEG
   /c445ekE+Ii/PK5oYnFzRutW/d7HZCJl2uSzrGGlIpGVFRdpjc6d4ktFa
   vF2eOO+PQ93uN9nznhM4+wcz4MuXW2MsDgteNuBxN3ypygnmPgQh9hT+k
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="424977117"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="424977117"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 14:30:43 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="745828180"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="745828180"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 15 Jun 2023 14:30:42 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 14:30:42 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 14:30:41 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 14:30:41 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 14:30:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lRlqOeClA7KqtHWvnw4Mq61nocpvGifR3x2JLxCjigR3qsOTPZjYJjBtpoTzHHzcYVfUOZIcMoFNVeRAcZLHffTbbflBGD+L6dgAoarZTFIc3rHip5/aOXUxQSVxG43HopS7Zdyegv4hpxqKNr8RHAGuEi1JqaKgx3yHP+K/3Ukjd+bCX3jyd5q8R99zTJR3rjFp9xvPp9sMaGLjVLLSkooHlOyDd4N8yTclzz9rVU+Nke034AbiqJY8tJ/9GciHaOxj0yKluQ4LMiHCl7adCms9x1licob7G24ilKwU9Nv0rIvtOVkgu8MqV/Ao7utj0kK+oLessB3yCxTgH5fjEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T9+i0rzqS+zuSTRi2rdKdxofyUUMmZWrKVKnSQiC8Ps=;
 b=VzT+6vD+/MhZcTWhp8RLJhhvrhb+kJQ2ZlFCa33hOBB1e5VGwL31QqD9SixeuFMpLH4tjkuUIeaSyHbfeolYuFE2dCtvYRRejHyAzEHTq8i4hjbfhVmjQSlNtJPfHJCFincSPItWVZnVNSTS1EeXuMwIH9vWAKQxoaSSnqBotniT5cOgKFpU7ADr8wfKKrCvhmskh4c48/M2dgIssg9+rABDr54ZatkatRMmg0GWNIu79aKGM7MWBjSoEG259eJPG4q6QkjhUkWLN0rFGozQgEofNKjGUA+iXVJZocI6MwKjP4Fs33cP8qp2eid6cZhEK9vkgAkuzHrNhZgi/lPWcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CO1PR11MB5074.namprd11.prod.outlook.com (2603:10b6:303:97::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 21:30:38 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6500.025; Thu, 15 Jun 2023
 21:30:37 +0000
Message-ID: <3ce55a00-ae25-c58a-841c-e405692978da@intel.com>
Date:   Thu, 15 Jun 2023 14:30:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH v2 06/12] cxl/memdev: Make mailbox functionality optional
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
References: <168679257511.3436160.9707734364766526576.stgit@dwillia2-xfh.jf.intel.com>
 <168679260782.3436160.7587293613945445365.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <168679260782.3436160.7587293613945445365.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::43) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CO1PR11MB5074:EE_
X-MS-Office365-Filtering-Correlation-Id: 636a0ad7-ffb5-445d-5d7b-08db6de7c289
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZGD0ByxD4QTctf38O8455X5XdpgsPmkzmoXtPiV/Ner6/gfwcYaQGexl/5OeosfBa1sG8DpMUfSL4QaNqJJcZmJmf/1jX/MSmd0Uu449DPzws1u33uo9s2upuZq2NHPRC8Gs/MT/4JuNw1NMOoIPM5+/lVVHIFcs5tNArLXx5O92FOSWUDDJ6VxDMrzgAxlqB3usqHwZxxcl7ecOcAZkUBP+U4qit7N/XHKi/sOj1A07jwvtBrbuEbvbdvXycGETNuYFivvIxxy3jxACmInaRmtrN/ZeVj7EfHMGpMzwb+ODdEvPaPmWxNWGMGimSSJYx8efRjQxv3EpDo2tDJw8SGfEYw2uieC27eZmovMeY+fthZNANMs7kCftrboxKSILp/Fu/Xod/nNaL1DQarYaDwrkNPYf98KYop74HLGoY/BbOIzgBowiVl2zkonoJ1/f+E+uV1nwVuq+CIF65dRKAMVWD1TdkIhsA21t6EeDFf/yGDwhvEWNSMuvLortxbhORg2ZXh6z4DRsTuOu12xmp1fqyQksdLlGZEh5CRVr/VJS1AuI4y0wGqkJRKnlvMg3xVPScdh8siLb0fP6roB1cyTfS+KMgZst26xg9ZtwnF3ASBsxXKIMIyMe+9CvHklrx0NI1KpMo6iuhq5qHQ/kLg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(396003)(39860400002)(346002)(451199021)(5660300002)(83380400001)(186003)(6506007)(44832011)(2906002)(31686004)(15650500001)(2616005)(6512007)(41300700001)(8936002)(26005)(8676002)(6486002)(31696002)(316002)(53546011)(36756003)(478600001)(82960400001)(66556008)(66946007)(66476007)(38100700002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eE1rS0d3MFhmTUU1VkVtTHp5V2JGUkh2ZkJEK1RZdzFSNFpPVmZOUE1JWkZI?=
 =?utf-8?B?YVlGeUNQdlArWGFkbGwvVmFPM0dCbENBNC8zeUU2YnlvTy82bUdtRG5nVFZN?=
 =?utf-8?B?WmQ2RGxDMlIwYWliQzdIQ3NIK2pPL3dHVjY0VXBEcVF0eHNHZTZxajJUUFNL?=
 =?utf-8?B?RUFsZUdrZWJGYWZJejFHb1p5dUpoNnBUZ3MydzFyUmtRb2llZW9pY2tURDBG?=
 =?utf-8?B?N3U4RVhJZXBHdmY3VWg2UHNzNG5UQ1BXZjIyYWZ0U0EzK2JvZ0xVUDVhWnY5?=
 =?utf-8?B?Ky9yM3JVVi95eHNrZ1VxQ0QreUd5RmZCTmQ2YWRzd2xCNHFmN2FpYzdFcUxu?=
 =?utf-8?B?NXU0THF3bzVKekdJcnpTeUVnMzZ6U0Jkc2pud245cFNKZTZ3VjdlaVFKOVl6?=
 =?utf-8?B?dWFQWDB1VzIraFUxbVBINFVaeHlEQUJmYWlxclFRS0hicEx6L0ZTK0w3TXZh?=
 =?utf-8?B?dTVremwzY3d3NFYrMzN0K1VsMXNUM0tza1FNVHpMM2E1SzRZNUM0ZU5ZTmsy?=
 =?utf-8?B?K2tEVU9IWkkrOTdhOStqTzF2U3RzYVd1T3d6VEo3TzJkNXNVQit4MWVBNDFD?=
 =?utf-8?B?dkVqdm5rZ0lSbmI0N010ZnoyTWlwSE1vdGJRWXBlTE5sbzZJbEZwZElRMmRv?=
 =?utf-8?B?SUE2NThxeHE1NUFqajR3czFxK3QrQXQvemw5NW9XNituV0JVeWF0YnhORVpJ?=
 =?utf-8?B?L3gyRXh4ZzhWRkR4Ym9mYzNmY0ZsKzFCdW5mOFBPUUpIZDhVVXpUakN5cjJD?=
 =?utf-8?B?MUR2VUs5YW1yU1dyOUdhV1U3dFF2WUNPa2JNTDgwVG1FVmRQTXFzOWdrOHoz?=
 =?utf-8?B?TUVqZm9yNXE1K0F5SnFsWVhqSkVLVFh6L0FtSmRlVVdWblpkb3BQS3NrVVlI?=
 =?utf-8?B?ZmpMYW9XZ3h6Z0lPWlJNcW5HeHB5aVZOa25pbkFVV0gyODl5dUlZYzhidDJT?=
 =?utf-8?B?MnBIQ0FyajZaOTd4NEdOa0RaekpXc0lmYzFaeTdWaVh6MGc4ajY4NzlRenpE?=
 =?utf-8?B?TExONEg3UFRsUThZNzZKQzFDQmkzMStjSEh6K0JRTzh5Nm1sZTNYS2tJZGw2?=
 =?utf-8?B?UVc0enBmUlA5Zng2aXRwL1FmcEpJR2J5QmVsbkt3KytSZWdhRjFwK2IxWFdF?=
 =?utf-8?B?MzFNV0poS291RWEyVkRmNlJvN0lhcEZuRDJtWCtLOStkTmgwV1IwM29SMkND?=
 =?utf-8?B?WTZMWWxrYjR0UjlyUVF2N2hLTHFpNVkyU3I5Rno1TDZSc09pSDdwOTVQbGR6?=
 =?utf-8?B?MHlBY0RXeXh0V3BRdXhVaHFiU2FrVGZKKzZ6SWt5bjlYOTVlZXdVZVpOL1dQ?=
 =?utf-8?B?M01NR21PQklGSXRUUXZrVXhQVG9wU25TNmYrd09pK1ZVTjNQakFraXFmeHR1?=
 =?utf-8?B?Y3ZnWWlYUm1BWURkMk9zRjJtdXJoVG5XMEt6cmNWbVFGZzVsdVkzQ2JSM0Ry?=
 =?utf-8?B?aWZjVjUyZDN5UUNZZkY1d2tQS0IrS2dGazF4S3Rza2VzT1hpMmdkS3lVaUlr?=
 =?utf-8?B?Y2NvOUl6SjQzWG43UW1rV2VsRnJ2RnMxdEJ6MlpIOVQ0bWI0S2lLYXUrMTdo?=
 =?utf-8?B?cUo5OVRQa09kVFY0bngwNmpWRWl4OVIxYnFhRTVFQ0pCNzJJRG0zdFI2K2Fs?=
 =?utf-8?B?dkZFMUVHYzgrbUlBOFQxS3VlVE5WOHNWZ1hKZmVBVFE2TFNzRlY2dWZBRjFD?=
 =?utf-8?B?dE5rRllTU0ZvYmtXdCs0aEpwOXJsUW1yeFVoNHZyMVJDWlhMdHdEOUVSQm5q?=
 =?utf-8?B?VWZLYldEUEhQSnkrT3EzTHdxRFVWdTAyV1FqeVJlUUZSNkNENVdNVUlzTnMr?=
 =?utf-8?B?NTZTcjdFeElnNXFsZk84TTB3RUVwSnRsS25nSkxwN2ZrTURDRVdMdGora3B4?=
 =?utf-8?B?V2d0bkQ5SGFBUjlYMEU2bXZjaGg0SnlVcGlyV2ZjNmlBVDZ6bkQxcG1XWGxQ?=
 =?utf-8?B?VldZZnc0WnprTXdsdEp0Y3VKeWhvQlVLcmo5M1ZuTXdtcUNYYUZDV1QwZEtP?=
 =?utf-8?B?U3pDeGRXc1hwbXY3ZkZObktYNTBlT292ZWVNM1U1d1FxcnBIV3U1RWZqSEhG?=
 =?utf-8?B?Uzc3UVBUMWErUWVUWVBGVWY0eXl0RUUzdUg5R21Ic3VHTDExQnlKRm5HaWRl?=
 =?utf-8?B?WEQ4Z2dRTjJTSWFHMVp0eThONVlsMXFLeDh5eEtpN1FnQVpRTTJUYy94dERz?=
 =?utf-8?B?UEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 636a0ad7-ffb5-445d-5d7b-08db6de7c289
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 21:30:37.3025
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QRC1WfABX3LPAPi00WFZ0n43e0mwfykdk+iMgwTzR4OBPdkNpDcn5Q0QJLkuVvU/cjtC7g9kr7vPzCSNHWDsXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5074
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 6/14/23 18:30, Dan Williams wrote:
> In support of the Linux CXL core scaling for a wider set of CXL devices,
> allow for the creation of memdevs with some memory device capabilities
> disabled. Specifically, allow for CXL devices outside of those claiming
> to be compliant with the generic CXL memory device class code, like
> vendor specific Type-2/3 devices that host CXL.mem. This implies, allow
> for the creation of memdevs that only support component-registers, not
> necessarily memory-device-registers (like mailbox registers). A memdev
> derived from a CXL endpoint that does not support generic class code
> expectations is tagged "CXL_DEVTYPE_DEVMEM", while a memdev derived from a
> class-code compliant endpoint is tagged "CXL_DEVTYPE_CLASSMEM".
> 
> The primary assumption of a CXL_DEVTYPE_DEVMEM memdev is that it
> optionally may not host a mailbox. Disable the command passthrough ioctl
> for memdevs that are not CXL_DEVTYPE_CLASSMEM, and return empty strings
> from memdev attributes associated with data retrieved via the
> class-device-standard IDENTIFY command. Note that empty strings were
> chosen over attribute visibility to maintain compatibility with shipping
> versions of cxl-cli that expect those attributes to always be present.
> Once cxl-cli has dropped that requirement this workaround can be
> deprecated.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/cxl/core/mbox.c   |    1 +
>   drivers/cxl/core/memdev.c |   10 +++++++++-
>   drivers/cxl/cxlmem.h      |   18 ++++++++++++++++++
>   3 files changed, 28 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index ab9d455e8579..1990a5940b7c 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1272,6 +1272,7 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>   	mutex_init(&mds->mbox_mutex);
>   	mutex_init(&mds->event.log_lock);
>   	mds->cxlds.dev = dev;
> +	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
>   
>   	return mds;
>   }
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 15434b1b4909..3f2d54f30548 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -41,6 +41,8 @@ static ssize_t firmware_version_show(struct device *dev,
>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>   	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>   
> +	if (!mds)
> +		return sysfs_emit(buf, "\n");
>   	return sysfs_emit(buf, "%.16s\n", mds->firmware_version);
>   }
>   static DEVICE_ATTR_RO(firmware_version);
> @@ -52,6 +54,8 @@ static ssize_t payload_max_show(struct device *dev,
>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>   	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>   
> +	if (!mds)
> +		return sysfs_emit(buf, "\n");
>   	return sysfs_emit(buf, "%zu\n", mds->payload_size);
>   }
>   static DEVICE_ATTR_RO(payload_max);
> @@ -63,6 +67,8 @@ static ssize_t label_storage_size_show(struct device *dev,
>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>   	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>   
> +	if (!mds)
> +		return sysfs_emit(buf, "\n");
>   	return sysfs_emit(buf, "%zu\n", mds->lsa_size);
>   }
>   static DEVICE_ATTR_RO(label_storage_size);
> @@ -517,10 +523,12 @@ static long cxl_memdev_ioctl(struct file *file, unsigned int cmd,
>   			     unsigned long arg)
>   {
>   	struct cxl_memdev *cxlmd = file->private_data;
> +	struct cxl_dev_state *cxlds;
>   	int rc = -ENXIO;
>   
>   	down_read(&cxl_memdev_rwsem);
> -	if (cxlmd->cxlds)
> +	cxlds = cxlmd->cxlds;
> +	if (cxlds && cxlds->type == CXL_DEVTYPE_CLASSMEM)
>   		rc = __cxl_memdev_ioctl(cxlmd, cmd, arg);
>   	up_read(&cxl_memdev_rwsem);
>   
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index b1a72e01e4de..1b39afeb369e 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -254,6 +254,20 @@ struct cxl_poison_state {
>   	struct mutex lock;  /* Protect reads of poison list */
>   };
>   
> +/*
> + * enum cxl_devtype - delineate type-2 from a generic type-3 device
> + * @CXL_DEVTYPE_DEVMEM - Vendor specific CXL Type-2 device implementing HDM-D or
> + *			 HDM-DB, no requirement that this device implements a
> + *			 mailbox, or other memory-device-standard manageability
> + *			 flows.
> + * @CXL_DEVTYPE_CLASSMEM - Common class definition of a CXL Type-3 device with
> + *			   HDM-H and class-mandatory memory device registers
> + */
> +enum cxl_devtype {
> +	CXL_DEVTYPE_DEVMEM,
> +	CXL_DEVTYPE_CLASSMEM,
> +};
> +
>   /**
>    * struct cxl_dev_state - The driver device state
>    *
> @@ -272,6 +286,7 @@ struct cxl_poison_state {
>    * @ram_res: Active Volatile memory capacity configuration
>    * @component_reg_phys: register base of component registers
>    * @serial: PCIe Device Serial Number
> + * @type: Generic Memory Class device or Vendor Specific Memory device
>    */
>   struct cxl_dev_state {
>   	struct device *dev;
> @@ -285,6 +300,7 @@ struct cxl_dev_state {
>   	struct resource ram_res;
>   	resource_size_t component_reg_phys;
>   	u64 serial;
> +	enum cxl_devtype type;
>   };
>   
>   /**
> @@ -343,6 +359,8 @@ struct cxl_memdev_state {
>   static inline struct cxl_memdev_state *
>   to_cxl_memdev_state(struct cxl_dev_state *cxlds)
>   {
> +	if (cxlds->type != CXL_DEVTYPE_CLASSMEM)
> +		return NULL;
>   	return container_of(cxlds, struct cxl_memdev_state, cxlds);
>   }
>   
> 
