Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF95C77B73
	for <linux-cxl@archiver.kernel.org>; Tue, 30 May 2023 23:55:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbjE3XzT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 30 May 2023 19:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbjE3XzS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 30 May 2023 19:55:18 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C5F139
        for <linux-cxl@vger.kernel.org>; Tue, 30 May 2023 16:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685490908; x=1717026908;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=k1Lw0i9iXDyfui3tQYmNmvP6GsMSRNmqYxgw1zQdycI=;
  b=F9NdYkYys+cyCsVawC680QZVfiRDCsZAmske2RkCfUJyUuA9iqX63JDn
   3oGnPtcz7nP/UWEEZo3MlP6PB1ShlTS8+I4i7i8K1NaRWygu41frn6MBQ
   nPtUuBaC7iAaOH52d6Ld3aXxKkSX4N1nAsratSkVLOFvRHoclKvptVC5Y
   Qon6uNbpfyjB19KonOTOBuoCaJKdX51vJTtL+U9sYv4pFEoLgGVVNNK/R
   evTj9MzzRNGbbNplcrzweJSpyy0mFR4nGrFCxDOOYZopVeJm6IjYjasvX
   /R+gHYeLDq/95fftSep1PLpWqEcRns2UWzrYpr6iJsSvbU7qRIKlCLPar
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="335427727"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="335427727"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 16:55:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="700846435"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="700846435"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 30 May 2023 16:55:06 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 16:55:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 16:55:05 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 30 May 2023 16:55:05 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 30 May 2023 16:55:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SK6tsu68pqhlWEC6LIIv8kcvIv5zJxuDnm4IENmvR71sD3wHBEyYWGbWvJ5XUioK2dGM6vO/IhAhUAtyWGAlqNiyjRAcjMn7FNzkAJYnqHkXmA7adDiV7svPwSo9R5s/fnYpGp60ii1lNVOhYzMesEK1tVwrmwjZtE9IXaQZnaXm+LnDkEX+MbLhcLe9vyA8yzwGhttqKQlXXnGdgikHr9YUrYYEl1kIXfZNkzZVRm66XSmo+JXnwggbj00guy2Slk3ojZxKhf2qNoJJl7YYaKBxKEi3j1n5K3b8i59BCbsDsyb1nWy/KD+mRjlsgqQItkfhJOmVFvC4d+5ZaEbq9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2FEODpJELHLns1+TVbkIXnI0foMLzuYwDTG7VrU92Y=;
 b=IMYWD9weyYu81pAIWQGFSgMmXaQyRyaZTG2LTxpvQx+jX/LVuzgtwjSXucsy7iGH9T8vktcTNxw0Cf2OYZQTNGvdMmy8vwEU0OzwsJFtkR+HTB7kDlC1XzQAC21dUbg1yHAmWN00iPM6saYRGEG+9I/oAuLUC1m90QoanXXCZHDbHH/yvH/w/407WzKF8YgD+7kdCjPF0QPqQLS/JR3cgzYS2YmUcLEzwxKri8xYM3fR0KFWBghMJxb34GgZqKy61zliuhPNT8gJOBNs2LFkyk2+QUGACBHfBUwn7KaCfS9bPd+RT5K2R2xPCxMERamhu8lfm6KtVNPOe93GTxMGLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SN7PR11MB6948.namprd11.prod.outlook.com (2603:10b6:806:2ab::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Tue, 30 May
 2023 23:55:03 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6b5e:ef4b:bd3:36d2]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6b5e:ef4b:bd3:36d2%4]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 23:55:03 +0000
Message-ID: <e06b17d7-938e-45ae-c128-a530bd6a48e5@intel.com>
Date:   Tue, 30 May 2023 16:54:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Subject: Re: [PATCH 5/6] cxl/mem: Support Secure Erase
To:     Davidlohr Bueso <dave@stgolabs.net>, <dan.j.williams@intel.com>
CC:     <vishal.l.verma@intel.com>, <Jonathan.Cameron@huawei.com>,
        <fan.ni@samsung.com>, <a.manzanares@samsung.com>,
        <linux-cxl@vger.kernel.org>
References: <20230526033344.17167-1-dave@stgolabs.net>
 <20230526033344.17167-6-dave@stgolabs.net>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230526033344.17167-6-dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0168.namprd05.prod.outlook.com
 (2603:10b6:a03:339::23) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SN7PR11MB6948:EE_
X-MS-Office365-Filtering-Correlation-Id: ae8fe750-1c19-4c66-5485-08db61694936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xbOaddWaBCESY7GWr5OY8iArrVHIoopaNtHMVBxNgBvl/7KRX8NuY0QwktQkou4NfPisPhF4YMJr/1JYUQZ+NJEhCr/A571iiv0oFknoxRGscbUevu8RfXdWt7jwleBmCHH64iZTZDvEl+/2cqZf1lD1LWY3p4WOM7HaVyTCIKFivLMMmy0nJXFXyPmoiNrLbBQjyjjZb/dDxpCBiAGG0ZWodaoI2+S2KbdjmLp7MFhBvkwJK5KgCd/pguSWpVdCSQsUQwhf+OuJ6qzfHkxJKU3rnp1yQW+lwkNiqUuI7CQXNsr7qLy/4RSJykvt6RmWWn7rPfsJDMpHiyXRb+pBacWXI8vJS6lr67svfHhHRW4yn52ZRyh3aZqo6ByA7braljaLcpGBLDmzYMoLZGx0Hdp6efZoJNL4m+paBtGCtGuk6X1BfXWkVWPT+mrBA9W0Yqpk0HHj2atNm+mKTvDCWZ86Jh0MNo2DArFFsbdj6pLKfJ1yOUUuvAm6o/QCQDh6QRwD2x15BqqfAPNG8JOgzsZQ3WiLQYnmtzP+DdzANdhtfVMDBsUN35A+anG8Vdp28N1XQj9hrTsULHFUxqjtANmEvh7XLWSPCXCWR1iULfdyv/Ah3PnXk6GFgpzp+FOJuaYrFSKEhmpXHgQbYZxtkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(39860400002)(366004)(346002)(376002)(451199021)(38100700002)(82960400001)(31696002)(86362001)(36756003)(6486002)(2616005)(26005)(6506007)(6512007)(53546011)(186003)(41300700001)(8676002)(2906002)(8936002)(5660300002)(44832011)(6666004)(31686004)(478600001)(66946007)(4326008)(6636002)(66556008)(66476007)(316002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjRsL0F1VkdMdWpNME1ubmVMaFZIZlhXRnZNaW9mSkgzTkRXeXJtRWhxUnlQ?=
 =?utf-8?B?d1djeWhhbEVRZnY0L2FLc05mSkNNQWRwakZ3bDR0UUpTSzVPVk1CZFYxV1Y2?=
 =?utf-8?B?YnF2UnloSXlLd0hBeWpMODhnTWJJSlR0ZXhlWjlXVFIrZEttZTQzamFZSXNJ?=
 =?utf-8?B?VDIrSjByOGFoc2JDZEsxdkRXcnB1dVY2aFdqTVNKT3NZUkFQTFBFWnFOMEFl?=
 =?utf-8?B?b2JLZ2VuWjg3L1JJMTlRQ0hSN3pRclpuYWR6bnNjeXpxVHVWaWFjZDBSTzhY?=
 =?utf-8?B?RHlscEN4TStJblNFSUx3NWVYRkk4dTZBYjJUQmxVdGNsdnRWcXdTTG9EcGxT?=
 =?utf-8?B?bmJKUFBhWC9WM2JLWTBIM1VjdmRhcEJ6Uzc5Q0dKTkdpUm5GTUE5R05KQzVa?=
 =?utf-8?B?b0ZUN0hia2RleTNCSjhKR0I5bnFIVlZKYUp6cW1RczVldk01b0xnYTNDVEdr?=
 =?utf-8?B?T1pVRGd5VnFTNEZjdURsSkZteUZWRHNBT2xiMG9ETHM4ZUF1RVRlU05kdXZN?=
 =?utf-8?B?bHcxbHN6a09TNFRWWkJYQVBEY2x3MWV5OTlTTlZLeTBkeDRXTHBpaVkyODIz?=
 =?utf-8?B?WGJydWFmcy8zVVExWkUvQ0JFcTk5QUVHaWZjZENqN3hvYWFJS3IvVUk3RjZn?=
 =?utf-8?B?eFE2YXZqVWJLdzZRdlgvSk1BZTlyNWx4RDBqN1MyS01jM3djUFVQRm1mUzU0?=
 =?utf-8?B?ckR2MjBGa0NFZFpFcExvZ3NBS3lwV3o5R2FCYmFHN0E2clZsKzRuWngvc1hQ?=
 =?utf-8?B?VjhveVkzOUpoMTFkZHpWNUhvM0Y2cVgvVGkweHh0Sk1qemt6U1VTYmhlTUZ1?=
 =?utf-8?B?cUpaQU9BY2duV013WUpoUjlxd3FnejVEN0Y4NGxWMm9kYW1ZVHJKaFNPNHlP?=
 =?utf-8?B?L1RxbWw3bGlja3JDTHIzN3M3cHpBQUx3S0dpcGVDUTFaYk9VUTRGbzhTQklu?=
 =?utf-8?B?a01DNitKcmh1T2pOZUdzZ0VrbUJ1L2t3QndPTWFuYTY0RDJ4TTEyK3NSbnFT?=
 =?utf-8?B?Y1E1TGR2cVFnR01Uc2pZOGVEdEtnMkNDSDRRUXNFeWIwMXpobm5VZUpRdnNy?=
 =?utf-8?B?cHNCdDhXcWl2dnFqRTRQeFg3bXRyS0o2bHFzcUFLV0pMVU1nZzJKbGE2WFRx?=
 =?utf-8?B?bi9xSXorQ1pSWVdid21MYVc1WjRYcEg4SWhqSHhTTGJudUZUQmE2UTZzWmdt?=
 =?utf-8?B?bU1oeXZQc3BRSzk1R2FURGRWZ2tqTDhXU0J4Ri9sUWJMRWtUbXZjZEdtNFAw?=
 =?utf-8?B?ZHUxdWVvSmliWHVOVGZqMXdkYllVcTZTd21JdGN2N3QrVzZ1b0hEaG95QWRK?=
 =?utf-8?B?MHRNSE0rZ3VtOHF3OHA5Wk0yYmhFd0N5K1JnUzB6MGVZOC9iNmlXbU8yRUdM?=
 =?utf-8?B?YTd1M04xUDBoMEUzelAyeUQwSitpZGtRdWgvcVZKQk05Y09UMkkzME5ha0pC?=
 =?utf-8?B?MlJOdmdmZkZKeHFkMmJyQW5aTXl2bDNEY2NseXYwL0pZTGpZb0hKcU1ZN1NI?=
 =?utf-8?B?c0kxTWtnV2lrcjVSMVM2dW9Lc0JjZjdFdFppL2RZUjc2ekJOMXRxVHJJTmNo?=
 =?utf-8?B?TThmK1pQM0VzdzZNam5xWkVQdkhienUrc2ExK1RUbnZMcmFjUGRrbXpVTk01?=
 =?utf-8?B?TFh5RjV2QXRuTysvaDdDMUR6aHJ5RXBlNUMrbCtVS1JLUzNPR0RqTGc5VFJP?=
 =?utf-8?B?N204TDBhd3NFYXlQajNEUFFnWXpZQWpKODcrOEN0dXZRcHBzdjVuek1HRVN1?=
 =?utf-8?B?TFhFTTZoVCtBQjJrcmZQRE1DdVNMbUNWOXlVejVLRHZjMlpNdnpmaEduNUxH?=
 =?utf-8?B?c1BBcWpjTmRjVmJHa3JBYXJ1UEIzZU5hZHRDdE4yWGJ2LzAyeU5Hb1JmaGp3?=
 =?utf-8?B?L3BTVFNpLy9DUEo4alMxMFBJdEU3TDNDcmhQNkoyUjB0ejZUc2phQTNNUjV2?=
 =?utf-8?B?UmJXU3FBaEEvRUh0ODhBV0tjZFdrNE1VZG5TL0hheDZUV1JQVDJVNmtmeDRa?=
 =?utf-8?B?MW0xZW1UcThaa21BSGR2RUYrMnB6eWhtbDNMdXFWWlRZNVpPZzhyZCtXOGVp?=
 =?utf-8?B?aUxTMjhvVm50K3BsZE9OanA1QUl1d2Uwb3pWS3V5THJidlNsWXFiekp3aDVq?=
 =?utf-8?Q?Y1ojUz63ZjFfwUOCZx6bqEImA?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ae8fe750-1c19-4c66-5485-08db61694936
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 23:55:03.3766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rpCzGZdft9NfSvooNgQQHHLIhERG290hQInWiu70DyrazN9nT6XkZfcmi2Wz5jvgUM4SpwvMI1Xux5G3MXigFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6948
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


On 5/25/23 20:33, Davidlohr Bueso wrote:
> Implement support for the non-pmem exclusive secure erase, per
> CXL specs. Create a write-only 'security/erase' sysfs file to
> perform the requested operation.
>
> As with the sanitation this requires the device being offline
> and thus no active HPA-DPA decoding.
>
> The expectation is that userspace can use it such as:
>
> 	cxl disable-memdev memX
> 	echo 1 > /sys/bus/cxl/devices/memX/security/erase
> 	cxl enable-memdev memX
>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>   Documentation/ABI/testing/sysfs-bus-cxl | 10 +++++++++
>   drivers/cxl/core/mbox.c                 |  6 +++++-
>   drivers/cxl/core/memdev.c               | 28 +++++++++++++++++++++++++
>   drivers/cxl/cxlmem.h                    |  1 +
>   4 files changed, 44 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 5753cba98692..f224c1215f22 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -85,6 +85,16 @@ Description:
>   		the device to be not be actively decoding any HPA ranges.
>   
>   
> +What            /sys/bus/cxl/devices/memX/security/erase
> +Date:           June, 2023
> +KernelVersion:  v6.5
> +Contact:        linux-cxl@vger.kernel.org
> +Description:
> +		(WO) Write a boolean 'true' string value to this attribute to
> +		secure erase user data by changing the media encryption keys for
> +		all user data areas of the device.
> +
> +
>   What:		/sys/bus/cxl/devices/*/devtype
>   Date:		June, 2021
>   KernelVersion:	v5.14
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 51c64829f20a..6622eac66bf1 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1102,7 +1102,7 @@ int cxl_mem_sanitize(struct cxl_dev_state *cxlds, u16 cmd)
>   	};
>   	struct cxl_mbox_cmd mbox_cmd = { .opcode = cmd };
>   
> -	if (cmd != CXL_MBOX_OP_SANITIZE)
> +	if (cmd != CXL_MBOX_OP_SANITIZE && cmd != CXL_MBOX_OP_SECURE_ERASE)
>   		return -EINVAL;
>   
>   	rc = cxl_internal_send_cmd(cxlds, &sec_cmd);
> @@ -1120,6 +1120,10 @@ int cxl_mem_sanitize(struct cxl_dev_state *cxlds, u16 cmd)
>   	if (sec_out & CXL_PMEM_SEC_STATE_USER_PASS_SET)
>   		return -EINVAL;
>   
> +	if (cmd == CXL_MBOX_OP_SECURE_ERASE &&
> +	    sec_out & CXL_PMEM_SEC_STATE_LOCKED)
> +		return -EINVAL;
> +
>   	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
>   	if (rc < 0) {
>   		dev_err(cxlds->dev, "Failed to sanitize device : %d", rc);
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 90f23e53d483..d06c8539e82c 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -163,6 +163,33 @@ static ssize_t security_sanitize_store(struct device *dev,
>   static struct device_attribute dev_attr_security_sanitize =
>   	__ATTR(sanitize, 0200, NULL, security_sanitize_store);
>   
> +static ssize_t security_erase_store(struct device *dev,
> +				    struct device_attribute *attr,
> +				    const char *buf, size_t len)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_port *port = dev_get_drvdata(&cxlmd->dev);
> +	ssize_t rc;
> +	bool erase;
> +
> +	if (kstrtobool(buf, &erase) || !erase)
> +		return -EINVAL;
> +
> +	if (!port || !is_cxl_endpoint(port))
> +		return -EINVAL;
> +
> +	/* ensure no regions are mapped to this memdev */
> +	if (port->commit_end != -1)
> +		return -EBUSY;
> +
> +	rc = cxl_mem_sanitize(cxlds, CXL_MBOX_OP_SECURE_ERASE);
> +
> +	return rc ? rc : len;
> +}
> +static struct device_attribute dev_attr_security_erase =
> +	__ATTR(erase, 0200, NULL, security_erase_store);
> +
>   static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
>   {
>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> @@ -411,6 +438,7 @@ static struct attribute *cxl_memdev_ram_attributes[] = {
>   static struct attribute *cxl_memdev_security_attributes[] = {
>   	&dev_attr_security_state.attr,
>   	&dev_attr_security_sanitize.attr,
> +	&dev_attr_security_erase.attr,
>   	NULL,
>   };
>   
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 408ec33c8480..758fea7b9dbf 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -392,6 +392,7 @@ enum cxl_opcode {
>   	CXL_MBOX_OP_SCAN_MEDIA		= 0x4304,
>   	CXL_MBOX_OP_GET_SCAN_MEDIA	= 0x4305,
>   	CXL_MBOX_OP_SANITIZE		= 0x4400,
> +	CXL_MBOX_OP_SECURE_ERASE	= 0x4401,
>   	CXL_MBOX_OP_GET_SECURITY_STATE	= 0x4500,
>   	CXL_MBOX_OP_SET_PASSPHRASE	= 0x4501,
>   	CXL_MBOX_OP_DISABLE_PASSPHRASE	= 0x4502,
