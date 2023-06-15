Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E39EB64DA
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jun 2023 21:29:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjFOV3R (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Jun 2023 17:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjFOV3Q (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Jun 2023 17:29:16 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F3FE69
        for <linux-cxl@vger.kernel.org>; Thu, 15 Jun 2023 14:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686864555; x=1718400555;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=i+saXqVOCF29ZmsNot9AYw5HC8vZlU3ZsCRecI+OCjI=;
  b=L6GDlWWu35rD4HI8m8b5H8Dn9VK+VnFKkIJyBThUbG/74pV2Oup2NI4Z
   F8zGQKAGKVZAh5BuXuzX0vPoq23FRAUzlfPwz+8+LBXmriHqFzgQz/PQ+
   ozs7Bog90s3t5R7wM3VfAre6ekFv2zcquyKwXEiwonUUcFgjcwpM9CxTs
   ITgUoh5HQ5QMBBiJrfdF4JptpYtQdYZfDiEwiRxfZWVy1jigqeDzZnnjq
   OFUF1boGwIZEQGckSbdLKWxNIQEOYcYCAVXjjAH9bRyqEpuJcXyONp/RW
   AN7tgzHtK835U2bFjc1e5xefeIT5g8lHOAkPYJu0kKtB9GAinEEiZyDrV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="424976695"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="424976695"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 14:29:15 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="745827471"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="745827471"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga001.jf.intel.com with ESMTP; 15 Jun 2023 14:29:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 14:29:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 14:29:13 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 14:29:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U36dO4ziDGaDI65VhLMXyBRD3BdAOYu+/YGPvpJoo09mqaE8alYiRnE8cxbDRIpWwIL5cNA1YZSZpS6SesX90ZQB9C3fDsLm78L7nM/cgXOD64iThklBav+P/TUVrlDPFKXB7TMacNg35YSG88nUIPcR8VNCAYm1mA5lEqCWM1W0+HYOFQGY/15dahm7Jni1KMIySZmFwOUBQhRbVDxDMKLLbtLqv+snrko1QqpraRktrok2oz/smzF237NeTbVkQg2H9kxC6bfY47iGQKH8EKAmQtCZlvXYHrrLIiS2WjpTvvD3fZtZZV6NoYS18HIT5PiDZGmTWPwVUFgDdBRHnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k4bBbl4LeAPbDPf7QQhXIzDts08/PyjWs6QwhpAzX1U=;
 b=DpOXSVn604ouGXHVHXmjWzM4syWlQBjM/TrlyM06DXDbrWXt7BJgzjUrbzeHwwsWMccbNHB9uyuNqr1Ssl08WsbC4w0vNwSi+fX13srIYiZ2H5vUDrtrulFdNt6+cH6tT1w0+6lNMEtHJBBEKgv5ysmOuTdEhJrphgwQnLusZmuLuojciEBNB2m4VJtu6Y3fur9fG+Ld+u47k3jnxQG645+qvg2dhJKiW8LQwUDQAiMIqVWMUuhTzykNWOvEF+C7O6qWERKIbddZrxdyryIqctISI9JZe136PfxgBMdvmEr5QfcKqlkN26PzvVJllvx9Ksi00LYQlE7vnqR6JWoGZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by MW4PR11MB6981.namprd11.prod.outlook.com (2603:10b6:303:229::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Thu, 15 Jun
 2023 21:29:11 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6500.025; Thu, 15 Jun 2023
 21:29:11 +0000
Message-ID: <a4292abc-1884-5d39-4802-1e06b54328d8@intel.com>
Date:   Thu, 15 Jun 2023 14:29:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH v2 04/12] cxl: Remove leftover attribute documentation in
 'struct cxl_dev_state'
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
References: <168679257511.3436160.9707734364766526576.stgit@dwillia2-xfh.jf.intel.com>
 <168679259703.3436160.12583306507362357946.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <168679259703.3436160.12583306507362357946.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0066.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::11) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|MW4PR11MB6981:EE_
X-MS-Office365-Filtering-Correlation-Id: c7975264-215e-4033-4983-08db6de78f19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fZNCJFC4LPO9VGw0G8jsPorE8NuzjSwrBjFKCA885GIDJqyMc1xJWKQeu8fBeybuJDE4JJp31vlIsKAH56p8dY4ikbME8SPLEwmV8Gn1WFG7dSOLQIGyImamBe3idr6FwPTJhYjyqUd7Hv2rpblrejHjB8DNEpuz8HRPca1awnhyDu8+0SyLMfN4rgxk5nxo7d9B7aBbp75VewjHFP2QQ+B/QL6iI0yals5NoToDG6Vjt6ZpSyjQY3KFeeFSNlzRgaz76Hga20E1cwUHBqGtD9q4IC0Rj+17QiNu0i+SHcptyXX/9s9IIKF+IFluEIdxNtcp7R3R+ILH4CAA9/WZfmW1xGVMSgV+mbcO4SIvEddJnfAMl+Wh/2ArlgwdL9L+b9YOiQF3/nxwWIc5q3gLu5S2ZkkxBIxFYowrlcMHuk8YFw0UUdswDJKq/xZM5AX/toBJZHhoGYEwki3PYuCH+Agny3rg55qXPw34u530YcKg6+qyyy2k8ogX2ul2hAH9cwXYRSKPo0ZEMDv1SIM5ycY6+8AnLfY86f9ZJeC7bVoCyZwR69Dr+exv44kcXsTvQBu3Kd1ES6ydM3j0f7x6RR4AXXRFHJSg0INcoZLcPhyUphFVmKqKBkIROnIct/xSd32D4YJSkFg40macn9V+Rw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(366004)(346002)(396003)(136003)(451199021)(31696002)(2616005)(83380400001)(82960400001)(36756003)(86362001)(38100700002)(478600001)(44832011)(8936002)(6666004)(6486002)(966005)(2906002)(8676002)(4326008)(5660300002)(66476007)(66946007)(66556008)(31686004)(316002)(186003)(53546011)(41300700001)(6512007)(26005)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXFjSE4xenpTVUFLbndJaEhQd1hDd0d2Yk1vdzZyOXdhTzVlN2Zqd1hIR3Vl?=
 =?utf-8?B?ck9nYUVCTFdsNjl4YWdJa0tvSkdpKzJIYkkycXpYd2tja1lML0dmbkRWeUlC?=
 =?utf-8?B?N29LMm9Sdyt6bFd4WFVVMUoraDNTU1hoUWR6b3dzWTJsQ09jcUxNZEJJUnl5?=
 =?utf-8?B?N3pHRSt6aEVJenA0dXBobUFJYllSbFBqT2ZUaXl4c0lwKy9SMzBxYitleU95?=
 =?utf-8?B?YnlIMURUSEhmL1M2S0d5dnMvZGk1aitwZ29QNko2YXBSaHVLWDB6SjhjRjF5?=
 =?utf-8?B?a3pZbTZMTVI4cFJHajhML3A0TjNmeGNLRGk4eHhrcDQrMFF0MTQ0aWYvdWtJ?=
 =?utf-8?B?QVlaK2E5dUorci8wNVE1QklhZmIwWGphNms2MEhROGhkREU2ekdzZlhlNEFO?=
 =?utf-8?B?RjYzdDVnRkhlYWN0TVdXdjcxdEhSZStsZVhia09vZHRBeHFMOVl5ZEY5akdV?=
 =?utf-8?B?SXdkTitEWkNDTGVtR0FGQm1Ea0NJL0tRQU90R3RzNUxUbnEyUEdUV1VOaVhW?=
 =?utf-8?B?WGJIYnh2K1lxb3pqV2FES2VJa1ZDM2U5dDZsTzMva2VQQVpJamNEMEppL0dH?=
 =?utf-8?B?NUZhNG85UjZGOE1KcVhOUE5jZ1ROYUhLYjMrTlJBQWNrNUJ6RUpZQ1lvL3RZ?=
 =?utf-8?B?QUVEQm94VldsZ0hNd2l6UDZOZE9EYmMwZjRVa2k2cVA2MUVpU0w5NjlWY0pj?=
 =?utf-8?B?MzNMejFlaTZwVllRaVJxZzJoZkdxSkZMWHEvZGpUanBNNFJnK2tCWCt0UEtB?=
 =?utf-8?B?eHV1ZlRhLzdHR2FLOGU2d1U2VUdCbXh1VWtjTUZRT2I5dndZZzRvOFdhcG94?=
 =?utf-8?B?NFk1VzJRUHBWL1NScUV4a2lyTGlyZUtLR3pscGh6ZjhUOTdhUHlOdGlSTWJQ?=
 =?utf-8?B?UVAxbFVrVmNDWXQzcHQwNHN3Y0NjcDRCd1QvcWVVSjdBNmVaR3ZzNndkWXla?=
 =?utf-8?B?SzJjamJucjhTeFpUdWJxcDdxckY1UjdvbnFCcW9FOWZ6SHZUdTJjRERYMkw2?=
 =?utf-8?B?bmxHYUo4Y1R6bStLL3ZYVGdzTlRSQnZqL3I1NzA0ditmUkJqSjVhbEIvVlhQ?=
 =?utf-8?B?eGR4a0djd1B1cm9HZ1M1eC85bWRHUEJGaXo3MFBXYWI2amhHMWJwaURPekRK?=
 =?utf-8?B?OWdwcGFHaktxRCtZWFpxRlAzRm5uQlBpVnYwbm44dEROTGdtdHpqSlYvTVBm?=
 =?utf-8?B?T1R5eXJibjJpYk9Bd1RaN2xoLy9acis3SUZPQTNwZXdobVF5a1BLT0cyTExR?=
 =?utf-8?B?dEFtUFYveGZsQnAybW9oOHNhQzg4TUdZK1Y3Z1MwSkIwWFFMUmZBdlptTFZo?=
 =?utf-8?B?cGtXWkR2VE0zL0g0eGhJemt2WUgwSnljVlIvNndpQjBlSjBYbkRnczNPWnlO?=
 =?utf-8?B?ZUFQQW85eW5jNnFKNEozQ1Iwd3FQdE5VNHhrWTVxSm1oYXNoL0tkOTFQL2JG?=
 =?utf-8?B?MHQ5WkFmQWkwWkZjZ0d2a0tZZEp0ZHpPUGpXSitqbWNPOHBXNWIwQVZRdHBW?=
 =?utf-8?B?UlNtTlFuZ0V3SkljSmtDQlVZOUNveTJGRU5uZDBlUXA2NWFUZHJZQ2ljQ3ZQ?=
 =?utf-8?B?WEVXWUxSai9oSmVxQjVYaC9wR0duR1hmR1dObGR0eExaZlNvd083TTVQYWQr?=
 =?utf-8?B?Tkc4SGY4UmtMVGtwOTR1QW5UMVdDbGUzRW1BY0ZSenZJRlV5MHhkQW1vOVVS?=
 =?utf-8?B?UnY1cEVjSkZsejRIWWdJREpxd2M0RnNGdUdERDVENWZ1cjVraGxidTh2SGR2?=
 =?utf-8?B?aUNIWitIRFRDdkFoR1VIUlE3TzlGQWsxQlJEMzlMbkJEV0ZUTW50cWo5alpr?=
 =?utf-8?B?QU9uOEhNTGJkK0I3ZGc4U3F4UTAvVFVqcGRzS2J3a1pzazhsUUxVNnhKN2Ny?=
 =?utf-8?B?QVZEdGVuMmVsM2JPakRra2J5K0JYSTE0aWh0V2g0NGJlUUdJd3htMTh1Si9B?=
 =?utf-8?B?TU1ubFlDV3YxQ3RHTC96MFc0ZG5DOEdqQXF5TWNKeEQ4NTdWUW5lWmdsZDFW?=
 =?utf-8?B?UlFWMXFGWXlOVmhpcStCNWVXc1NvTGtjamVCaDhHN3ZhZE50aXg3VWJucElZ?=
 =?utf-8?B?TGdhNTl3TUNVNGlDOVprUFdtd09KYmtweXBObFBwbk1mYU52SS9RaXEwaGhQ?=
 =?utf-8?B?cmFQV1NQd2s5Z20vTVVRVFlJMHFZVUxaWXdmRU1Ha0NrRU8xb2NFTUJBL0JU?=
 =?utf-8?B?ZHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c7975264-215e-4033-4983-08db6de78f19
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 21:29:11.0659
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XQJM4jjUcffHJMDPflNxWlAvtId7RCjFLUQbIcqi8z4Bx5l0FiLsS2J+BMpWZhkmfnQyiI0oX4aDBRu4XabIog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6981
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 6/14/23 18:29, Dan Williams wrote:
> commit 14d788740774 ("cxl/mem: Consolidate CXL DVSEC Range enumeration
> in the core")
> 
> ...removed @info from 'struct cxl_dev_state', but neglected to remove
> the corresponding kernel-doc entry. Complete the removal.
> 
> Reported-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Closes: http://lore.kernel.org/r/20230606121054.000069e1@Huawei.com
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/cxlmem.h |    1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 8e4ba5b52902..66896fc6c43f 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -287,7 +287,6 @@ struct cxl_poison_state {
>    * @next_volatile_bytes: volatile capacity change pending device reset
>    * @next_persistent_bytes: persistent capacity change pending device reset
>    * @component_reg_phys: register base of component registers
> - * @info: Cached DVSEC information about the device.
>    * @serial: PCIe Device Serial Number
>    * @event: event log driver state
>    * @poison: poison driver state info
> 
