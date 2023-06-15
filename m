Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48BCBEB64D9
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jun 2023 21:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjFOVbk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Jun 2023 17:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjFOVbj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Jun 2023 17:31:39 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A871FFF
        for <linux-cxl@vger.kernel.org>; Thu, 15 Jun 2023 14:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686864698; x=1718400698;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yyapj8LXBRWw1gbq5PG0TZGXiwbjgWqsat34KnnK8s8=;
  b=hKObsl4jDqzFCTh7TU8iOBg2B/Tb94460kq4k9hy18uUjfdK1GLpY0SK
   8jjo2DiqTs79jhyFRpmOLfH+3Q357+VsyDjYGQcfgsbS8SAQYByeYy523
   8/KO92v/S/3OCECUtCKNiHbFE/Ih1I3ZPwubqk50ELArs5LT5YEK2X9oi
   RTHrvMUybw9LJFAgrWjjE1XG6BvAMH5wiQsso0uUIPg+P/+oARCoPziTf
   Ui78bneBwGsR4f6aCz+BXybcGexbHgEHejPYkhIo7TUhfWtNc1lzXkwgS
   XDssLvQiGP9jW/DU9neWi6vIVUoDy1gztbWiKXCy5oUh3zQotOKZIYGAQ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="424977368"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="424977368"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 14:31:38 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="745828828"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="745828828"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 15 Jun 2023 14:31:31 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 14:31:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 14:31:30 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 14:31:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=be47ygh/Lv47kLeY/1do12YZk9C5AiYoonqH1QQPZJRRb0PL5Z0DYBOWvRESBZQll3vQtIq/PY6hev0RHncdAiWxCsXPZyLzHY72X5tGMQKm6s+ce5Fkh1TANCj2l3wi3JARKwJcNIWROYcc8SiphCRvtEjzpvQ94Tj5IswylkZBvddwyJVYH/Wjzqh7a0YZp2nhdQo3M97npJuTL4NKHd2htH1zMUWzFanMLd6o+tjBLGicwTx+e7d1r2ugJIZZGLEws94CGMTYHGWerctV3SS8JL424nSOMbV/fxlqYPF3Kql+Loo4BmuxydKmr+YlesCqdBnnnLHdcoV0BfKzmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+RjcC+ZeHICrWj0Ke9g9TQ9ywezcfuQQyh7EKnCKIw=;
 b=gCeMZxgnKZgUC5VzhXV9urhbF9tsPRNMES8/A8jPdM16aJ+nRrgNO6Lsu1eT1gZX08QTGohJs2zNL0+LAiOctTXnsgj4gcirMkp/p7SBSNPLHUmyHLAj3yd49uLKP/xmloov7IPHSgLQL3Qz1GCkZO+ItnL9mDP9t3WlEoLqfLGOG2yZh6E/nCgPLi3KsY5L3kSFoItVmnEjlRI1V559XeYx3C3oVvFBL/bCJ9PcEkD5Gx5th32dOxlNCOImIIE66nahnOMarpvaQ7RgBED/GNA+Jcx905f3NnKSJQEW9aDQlDHBrAGPfLN+reOZuRhtm+eBswQp46PiJfZbxGGp1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CO1PR11MB5074.namprd11.prod.outlook.com (2603:10b6:303:97::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Thu, 15 Jun
 2023 21:31:28 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6500.025; Thu, 15 Jun 2023
 21:31:28 +0000
Message-ID: <f10eb10d-635b-4f76-5fa6-532fa268cc39@intel.com>
Date:   Thu, 15 Jun 2023 14:31:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH v2 07/12] cxl/port: Rename CXL_DECODER_{EXPANDER,
 ACCELERATOR} => {HOSTONLYMEM, DEVMEM}
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <168679257511.3436160.9707734364766526576.stgit@dwillia2-xfh.jf.intel.com>
 <168679261369.3436160.7042443847605280593.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <168679261369.3436160.7042443847605280593.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0009.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::22) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CO1PR11MB5074:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d3002d4-0877-4591-3bfd-08db6de7e0d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J2OXkD+QFRtXd6A73O6OhQqxTGfT3pQW1d6Hb8QAi1tSntVs4GLbSbor3lTcWGVO1wI3gKx8Mwo2BSdmKF8q1wojsJFAE2HfJ52v8YrDztarKXBGMzSZ7bA/qNJRnfuMFaoA1x7sKX9Qd1nEuZIckZ9AzhnG2yPK+hEfE23YjFZX4pZRDLzj1kILHHg5/VDbup0B2uu+MIEgM/n7Irv4P5v3SKDRgGL8F//KABD2SKtg/HvKGekAGC+dMI7PBIEsdAUQ8lApf166Kt+B3lBeKXJ3e98LZPEIBPHJ9MPrOoti7sTEycGDA4uogvAZobN11ZlXoYK/jjWaoCwFo7OM9s0oRo+4jeBDlum6JnPDvOsCkmm/9JPfJtoczYDcciTeuKaD2uDnXL6GH43qU8y+DK8DcJ5vr7jCOZPour29fmCa/O3POX1sMtEV7Ljb7yMm1de9GQh+bQ8R5Dh2oVXt7rSiV7x8PBKZiHI9qrCrKz3jZl6Cf4TT+9untvD5ow8I6v2uUpGi5b3EpwBTaZRhR6P12TN0yywwBDJpj+ga8TTD/yDqqrhCv5sK4tj1XgCO0HRwCDD87Dp/HsC34VPcHtW5XTrNQ1eMgZ4A+nb+u/3XGvuwZLN2NmifcXfm4JACpnMoNsM2dk4+GRIW/+strQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(396003)(39860400002)(346002)(451199021)(5660300002)(83380400001)(186003)(6506007)(44832011)(2906002)(31686004)(2616005)(6512007)(41300700001)(8936002)(26005)(8676002)(6486002)(31696002)(316002)(53546011)(6666004)(36756003)(478600001)(82960400001)(66556008)(4326008)(66946007)(66476007)(38100700002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eGUyV2dvRzNqQWZFY0xUb1k4VjBORkZlWmp3S3FsL0xqVEkyV0FKY1BNdkta?=
 =?utf-8?B?TFlOYzlXSjJCZjY4R21qTys5Tk9lakZZVEFnWjBRemJOR1hvOEJSQlIwWXV6?=
 =?utf-8?B?UmhIWjVNS1k0SG1NLzdZTnh4azVUb29NUVBnUUE2Yy9jR2N3K3UvQXp2a1Jk?=
 =?utf-8?B?SnhEOFFwODJIVHp3aXMydEI3MXRBVmJFK1VrZHh4Y3NKQll4M2Uya1Axb0ll?=
 =?utf-8?B?MmtUZUFyRFRrTzZGRkJtd2tjK1lkSzV2SUovWjNrbmJFbWJHZkRlbDl2QXdH?=
 =?utf-8?B?NzJhYUx0MWRaNytsSlQ2NkY4cEt6TEZBdFV4TTJBZUkyL053SXZRNkFVbWlP?=
 =?utf-8?B?T2dXMFhJcHJjN1FZVWtGc3VJSTlCam12WVJmOUdqRXlXRjh0bC9BWmxvVktt?=
 =?utf-8?B?d29aaFhtUCtuUTl3STZtSjYxRGhsMko5a1ZlZnYrYzl6anltQlBIRG1lKyto?=
 =?utf-8?B?dU1HUHpEcVJGMXFWOUJzUU96SlNIMk1mbGtvTEZSTFEwaUZOWVhCTmR0Rlpr?=
 =?utf-8?B?TU1QbWRoZmFVN2tIYzA3YkdrNjdiZU9XMFEyczJBR0djWlduNWFxc1MzNjh4?=
 =?utf-8?B?M1pjMDYyU2RJVmRuU0dBTUNGYlc4bEVSN2xSV0xxWlREZTFraEI1ZVBZWXg4?=
 =?utf-8?B?QURzVXRHbFpIUWtIQ2VlbEhBNHlCVlJ3dnRVWXV5OElUTXoyR09WZUJFZFJh?=
 =?utf-8?B?UzNnMWxaR0Q4anpqaFJzWFBEVXJWeTJGbDZMRGhxeUI0aDN5YXQ5akMzS1NY?=
 =?utf-8?B?ZGROa0JsTXJ3RW4vWGVGY250U05zRmJEbXRTSjhlR0FaaUk1b1dsMGE3d2Fi?=
 =?utf-8?B?bUZhMHFPeXE2Z3NEWnY5RTJrVnA4WEFNYWVlbjNCK2hGSTJNdUwwZDZxR3dJ?=
 =?utf-8?B?c2dPSVgycHlGcE5xaWZjbWN4eHo2eVRiMEdiS1g2eTB0ZWgybStmNVRFc2Fm?=
 =?utf-8?B?eVBwZE5SUUFFeDhyQUdDM3kweFJpWkphaTJtSUpCaVNReFdkMTRxK1hUV3FO?=
 =?utf-8?B?Sjh3dTRCVXA0emhZZjl1VGt4TUJXUU5teWpFUS93Vng2Q0hLbEJnODRWbmFC?=
 =?utf-8?B?UmhKblBLanhqYWl0WExrZjIwbkpIYzJSYmZkOW1FKzFhQ3BOQTZVbzVYQUU0?=
 =?utf-8?B?bm14aFpSYjRyU01CZjBFQmhCMlQzNUltT2JvQjQ0dHpXWUw1TVJJaW9nMzN2?=
 =?utf-8?B?RGRXTmhxaG9RYkNWdnh3QnVabFpMTlFUdSt0ZDJXNU82YzVLYzdlSVJ6L2pQ?=
 =?utf-8?B?aFdGVDdqSkhzODlMMmRBS1N5emNVZ0FMYUV0Q1NER05xNDBkd1U5VWZ6ZWdt?=
 =?utf-8?B?UkdiczdRZGlQNWc0N1lhNUxySTFYSGxjNGRqb01oRDBUNUUyNnowMWxUd2dD?=
 =?utf-8?B?cDhzazhFdHZWUjlhck1Yck56cGJmK3hJRUdRMVJ0SDcyeEcrb3ZVZzNSZHhi?=
 =?utf-8?B?OFVteTJ6N3VVdHZWQkZFOHk1VUwwMVJPejVhSWpyYktHRytlU1plYWFkdXhX?=
 =?utf-8?B?Q0Y2Z3Fqd1huMkJqRDdPUDVSaWZwZ0RqR3NGU2FWV0dkY0xSQS9nTTlzZlgy?=
 =?utf-8?B?ZE4wT1h3bHdIRmpaQzJoRVVJWU1IQ2NoWkp5R2p5eFZ1SzJoaE9yeWhQV01U?=
 =?utf-8?B?UzB0MnI5TFJiV09ZUWpCNlFvaHhJZUR1TnFSclJIbFNENHVVSmVma0c5Yy9S?=
 =?utf-8?B?MmhkK0RncUplWkJmOHpyMVJMUUEzeS9GbmZ3SlpFd1UzZDF1MHZUMTdnMmdk?=
 =?utf-8?B?eGROWjhVMHJ2NFVDQTl0RmNiU3lHcWhmWmJlVkpuSHpvR3NoODhDTGNIb09I?=
 =?utf-8?B?RWt0bytTTEZnbllaREdxaWV0NXd2MnZWYkZ0b3hnR3lMMzVxY2R2aHRFazFS?=
 =?utf-8?B?Mi9VWFg1SGZ0SHdTbml2b3gyNkZwa3lrNUlqaFVHZzB4cjBqdzdMOEE0ZWUv?=
 =?utf-8?B?MXdHNW52TGZueEtsQ29qTlRuYzB4U05yc2R2Ykk3ZzJlVkRBamVPVWVkVG1w?=
 =?utf-8?B?YUpkajVqNmpVWGNiTFd3VDRFNnQzcE11ZGF1L1lUa0JUaHVTZ1RFYjBTQTJB?=
 =?utf-8?B?WWF4RlYyM013ckxSZmNMZUZOTXhoVXJHbXlPUmpaY2E5SFdTSGp5ekVZdHdQ?=
 =?utf-8?B?NC9EenorQVh1QTYreEJ2VWtCKzlsWEhWcXd1NUloN1VSWW1GNXRoMzBVbUc5?=
 =?utf-8?B?L2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d3002d4-0877-4591-3bfd-08db6de7e0d6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 21:31:28.1338
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V4q13dBPLP3BIH+fNdZD0mYlNghMtClpWYVtFJPZ3ML+Hdk7RnNG31iQKrnPdiSYIWndq1Gb6JT0mBVT0u0VpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5074
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 6/14/23 18:30, Dan Williams wrote:
> In preparation for support for HDM-D and HDM-DB configuration
> (device-memory, and device-memory with back-invalidate). Rename the current
> type designators to use HOSTONLYMEM and DEVMEM as a suffix.
> 
> HDM-DB can be supported by devices that are not accelerators, so DEVMEM is
> a more generic term for that case.
> 
> Fixup one location where this type value was open coded.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   drivers/cxl/acpi.c           |    2 +-
>   drivers/cxl/core/hdm.c       |   11 ++++++-----
>   drivers/cxl/core/port.c      |    6 +++---
>   drivers/cxl/core/region.c    |    2 +-
>   drivers/cxl/cxl.h            |    4 ++--
>   tools/testing/cxl/test/cxl.c |    6 +++---
>   6 files changed, 16 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 7e1765b09e04..603e5df8aec0 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -258,7 +258,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>   
>   	cxld = &cxlrd->cxlsd.cxld;
>   	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
> -	cxld->target_type = CXL_DECODER_EXPANDER;
> +	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
>   	cxld->hpa_range = (struct range) {
>   		.start = res->start,
>   		.end = res->end,
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 7889ff203a34..79170de13d89 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -570,7 +570,8 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
>   
>   static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
>   {
> -	u32p_replace_bits(ctrl, !!(cxld->target_type == 3),
> +	u32p_replace_bits(ctrl,
> +			  !!(cxld->target_type == CXL_DECODER_HOSTONLYMEM),
>   			  CXL_HDM_DECODER0_CTRL_TYPE);
>   }
>   
> @@ -764,7 +765,7 @@ static int cxl_setup_hdm_decoder_from_dvsec(
>   	if (!len)
>   		return -ENOENT;
>   
> -	cxld->target_type = CXL_DECODER_EXPANDER;
> +	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
>   	cxld->commit = NULL;
>   	cxld->reset = NULL;
>   	cxld->hpa_range = info->dvsec_range[which];
> @@ -838,9 +839,9 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>   		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
>   			cxld->flags |= CXL_DECODER_F_LOCK;
>   		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_TYPE, ctrl))
> -			cxld->target_type = CXL_DECODER_EXPANDER;
> +			cxld->target_type = CXL_DECODER_HOSTONLYMEM;
>   		else
> -			cxld->target_type = CXL_DECODER_ACCELERATOR;
> +			cxld->target_type = CXL_DECODER_DEVMEM;
>   		if (cxld->id != port->commit_end + 1) {
>   			dev_warn(&port->dev,
>   				 "decoder%d.%d: Committed out of order\n",
> @@ -861,7 +862,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>   			ctrl |= CXL_HDM_DECODER0_CTRL_TYPE;
>   			writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
>   		}
> -		cxld->target_type = CXL_DECODER_EXPANDER;
> +		cxld->target_type = CXL_DECODER_HOSTONLYMEM;
>   	}
>   	rc = eiw_to_ways(FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl),
>   			  &cxld->interleave_ways);
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index e7c284c890bc..6d7811b26b5a 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -117,9 +117,9 @@ static ssize_t target_type_show(struct device *dev,
>   	struct cxl_decoder *cxld = to_cxl_decoder(dev);
>   
>   	switch (cxld->target_type) {
> -	case CXL_DECODER_ACCELERATOR:
> +	case CXL_DECODER_DEVMEM:
>   		return sysfs_emit(buf, "accelerator\n");
> -	case CXL_DECODER_EXPANDER:
> +	case CXL_DECODER_HOSTONLYMEM:
>   		return sysfs_emit(buf, "expander\n");
>   	}
>   	return -ENXIO;
> @@ -1550,7 +1550,7 @@ static int cxl_decoder_init(struct cxl_port *port, struct cxl_decoder *cxld)
>   	/* Pre initialize an "empty" decoder */
>   	cxld->interleave_ways = 1;
>   	cxld->interleave_granularity = PAGE_SIZE;
> -	cxld->target_type = CXL_DECODER_EXPANDER;
> +	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
>   	cxld->hpa_range = (struct range) {
>   		.start = 0,
>   		.end = -1,
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index f822de44bee0..6a875f86901b 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2103,7 +2103,7 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
>   		return ERR_PTR(-EBUSY);
>   	}
>   
> -	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_EXPANDER);
> +	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTONLYMEM);
>   }
>   
>   static ssize_t create_pmem_region_store(struct device *dev,
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index dfc94e76c7d6..ae0965ac8c5a 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -290,8 +290,8 @@ resource_size_t cxl_rcrb_to_component(struct device *dev,
>   #define CXL_DECODER_F_MASK  GENMASK(5, 0)
>   
>   enum cxl_decoder_type {
> -       CXL_DECODER_ACCELERATOR = 2,
> -       CXL_DECODER_EXPANDER = 3,
> +	CXL_DECODER_DEVMEM = 2,
> +	CXL_DECODER_HOSTONLYMEM = 3,
>   };
>   
>   /*
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index bf00dc52fe96..5565164d6658 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -713,7 +713,7 @@ static void default_mock_decoder(struct cxl_decoder *cxld)
>   
>   	cxld->interleave_ways = 1;
>   	cxld->interleave_granularity = 256;
> -	cxld->target_type = CXL_DECODER_EXPANDER;
> +	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
>   	cxld->commit = mock_decoder_commit;
>   	cxld->reset = mock_decoder_reset;
>   }
> @@ -787,7 +787,7 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
>   
>   	cxld->interleave_ways = 2;
>   	eig_to_granularity(window->granularity, &cxld->interleave_granularity);
> -	cxld->target_type = CXL_DECODER_EXPANDER;
> +	cxld->target_type = CXL_DECODER_HOSTONLYMEM;
>   	cxld->flags = CXL_DECODER_F_ENABLE;
>   	cxled->state = CXL_DECODER_STATE_AUTO;
>   	port->commit_end = cxld->id;
> @@ -820,7 +820,7 @@ static void mock_init_hdm_decoder(struct cxl_decoder *cxld)
>   		} else
>   			cxlsd->target[0] = dport;
>   		cxld = &cxlsd->cxld;
> -		cxld->target_type = CXL_DECODER_EXPANDER;
> +		cxld->target_type = CXL_DECODER_HOSTONLYMEM;
>   		cxld->flags = CXL_DECODER_F_ENABLE;
>   		iter->commit_end = 0;
>   		/*
> 
