Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4428C77B7A
	for <linux-cxl@archiver.kernel.org>; Tue, 30 May 2023 23:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbjE3Xxw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 30 May 2023 19:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233601AbjE3Xxv (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 30 May 2023 19:53:51 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94282E49
        for <linux-cxl@vger.kernel.org>; Tue, 30 May 2023 16:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685490814; x=1717026814;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=lJPncNeaLOS2tepKsMDMxe1BGST9oxqnZDsm4fZ74Gs=;
  b=QwdYqV63qzodCzavNaKOGXcTEmWZz7WbUVgRylvBDFdw6hYCXqxkrNxP
   NLl94SvADlHlilzhnDV6v4VNLT3zKvQTnhiim2z5gpIB+L3qtKSqpeTC9
   7Xqrmrzp0EApXrmM3ndzklVNHwK5crrQ/L1V6/3mHUSkGBYXOeGHt1/re
   54RN04hLPJBq/E4AMCF6Xf/UE6F+otxYF0W2pfygPL6EiH5llb5Sye6jE
   lHsAOMIdQ6NJYVp2XV6ceYIU35bfG7KfVXVLrMmLR3l66eUhPb3CeVDke
   AUmiw0+qSp9Eq7gu02AbYsn/0aS7UHY+V6wCRRtMizeeQ2NY8Zt7vHlNj
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="352577849"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="352577849"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 16:53:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="880937727"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="880937727"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 30 May 2023 16:53:33 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 16:53:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 16:53:32 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 30 May 2023 16:53:32 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 30 May 2023 16:53:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hxJvv97i7JoDHff+UDsgOHfYO/eHzI2XWNNO4b9IjekZFkbb3fz5hEw3PAzO/pbqm1bfpGTcKSrqRYCejcFDmMJRyEFWyZyZWQCkFPHeRINQ4I9u0hW1y3v3sdBOjUMmyXPXs0AzKkJdjr4VOVkEuwtTrR7hC1M10fF0ZCw61qhwaqSb0TARHnijJvcDyKAJrQLpt9CWxVbh2l+SgKBhPv1Z2ESzF37a8NsEYKmwB/lbYeixNhY6WbtopO1pca4NQu6VMqqIisGSTRuWC+rYfslZ4B8JNTg2Hgjb0Zm874FVe2JqDWT70+tTKdNUVpvac/+6Oy5KQu/Z+1+HHO1vtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lJPncNeaLOS2tepKsMDMxe1BGST9oxqnZDsm4fZ74Gs=;
 b=JwDjNnN5h2Eym43Tqu7H7gYrNV5L4D6OmJ4G8l7HZOmuZNCNhoQgtiAHMip+UVoar4SYnuo/1v+ArIGvahoOJDcLEU5W8FfN0qwIqclWgOCUUYEu99Z43RnN98tE62MOL4Ji8O2DzAYZRH4Z3EwWcy+Rf9hXgclf5Emcoe+Nc15QOtZTkGy4TWwR4B/02Vo5d4UKDiL1I4obffJSVo6q1bA2kxhy7ZobUhZ7j7JEeIRnbAhBJ7wYjZWtrha0twZ1aRsZJccRK72hWqkvmqhfpkw1If0o5cwDfkAqvSDw3L/WrFe0ovGjRVwxMXcmRulNmimGpfpRWfOt811kZZ41Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DS0PR11MB7190.namprd11.prod.outlook.com (2603:10b6:8:132::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Tue, 30 May
 2023 23:53:29 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6b5e:ef4b:bd3:36d2]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6b5e:ef4b:bd3:36d2%4]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 23:53:29 +0000
Message-ID: <26ea97ef-f69c-b1a1-8db6-7ed62aed8fc0@intel.com>
Date:   Tue, 30 May 2023 16:53:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Subject: Re: [PATCH 3/6] cxl/mem: Wire up Sanitation support
To:     Davidlohr Bueso <dave@stgolabs.net>, <dan.j.williams@intel.com>
CC:     <vishal.l.verma@intel.com>, <Jonathan.Cameron@huawei.com>,
        <fan.ni@samsung.com>, <a.manzanares@samsung.com>,
        <linux-cxl@vger.kernel.org>
References: <20230526033344.17167-1-dave@stgolabs.net>
 <20230526033344.17167-4-dave@stgolabs.net>
 <2rbjiulpjgpl6i4ilwbvndfteciagp72r6fkxlqtcik3t6kr4x@5jka73uukm7w>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <2rbjiulpjgpl6i4ilwbvndfteciagp72r6fkxlqtcik3t6kr4x@5jka73uukm7w>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0165.namprd05.prod.outlook.com
 (2603:10b6:a03:339::20) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DS0PR11MB7190:EE_
X-MS-Office365-Filtering-Correlation-Id: 3663f6fc-d15f-4991-7fcf-08db61691104
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3xqbsFC/Buy67mqNKvaSRgZ7TxaFOaovbg1OLMDfw07QvZO0LJs7FHxGkB2uLF8TxhS2B1uZe+5dGiX5JSho9Fm2ioYKvIzhBk64NSNb5FbuoiSOH8i1w4qYHMJcpCiOXt+DChWIU1z611V+sDz2c9BylgnbYlpVAAm/hmJtVhQYszqYW8RtW+2GdyamLVTBPo30ZAXJRz6REYe3wd7xnUFKZo+UZ65Haj0bvPrXeptxmAITi8RB+SGonSmEnGJaCceNh+/Hg6iahR5q10fOxZ/UKwacvxUgOBBxYv+kCDe+HCvDjBENgBSjNvWNcOSWTVevQwpiMOaW5ZqFwU0s6UreRfLu9basZqywAAxSnwMF21r6Orfb3vSdsdIYP6FNEYnzylEg/MlO9DYj69r7X8LSFHryw43xQcOLYExNX7Pprd+cl5S6F7y23HMjSNRlq0TOsnYvRD9L/Vrw7dyBoZowWn30XMMUm80WiihH8cmShPnlLrMjkIbv34vRMkoLrGFUuyxXnB24L77jFnT/XxSgNCz1AaG6KWeh5fTm1IJP03nbol4oHaFXy9Q3CPu42k3F4bwTGLvUkfRh2foM6WOtNfryr1iPgFTLvQv5bOwnL4nzA8H4/TuYT1MWBQHE+FrXn8JRkKa132M8U6xNtg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(346002)(396003)(39860400002)(451199021)(38100700002)(5660300002)(8936002)(8676002)(478600001)(6486002)(6666004)(316002)(41300700001)(36756003)(6636002)(66946007)(66556008)(66476007)(4326008)(82960400001)(83380400001)(186003)(31686004)(31696002)(2906002)(4744005)(26005)(6512007)(6506007)(44832011)(86362001)(2616005)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cjRERUVacm1nR2M2My9iUkVNbkorNUFIYkJJd3lkZkRMcVJTNEZhNFliSDcv?=
 =?utf-8?B?RkNvbWdhT0FpUHpVSEZoUVJ3Y012WThZcGdwM25vTTdFeXJIbjU1K3A3Z3ox?=
 =?utf-8?B?SzFWMXVlUlFTd0NaYk9Ka3dVWWhZekFtNVg4NHBxUGJpYWNOQXdtMyt3SmZH?=
 =?utf-8?B?N29nSllqdDB0L3I3bHFyTHB3T1lFd0JOWHFLZzVCUUlZUXdzdXE3VTNBYk43?=
 =?utf-8?B?R1U2WnVYOHl6ckpwR1h2VFZmdWQyekgwak5Mb2pDdStMTCtvUTMvSUFTYjd0?=
 =?utf-8?B?QUVGSElscldwNjY1cWNJWEVHOFRobVU5bGRZWkpYbDJsTkhzbkVmK3g0WDlR?=
 =?utf-8?B?bG91L0JOVHd1d24xeFN4SVRFdmx3cHpPSGFNOWlWaHUyNyttNmMydGZ6czJv?=
 =?utf-8?B?Z1oxWUhyaHpaOXAyVUxNdlpmNFBZY20wNk8wWlB0WDB0Snl3RkVnRm02cW11?=
 =?utf-8?B?dVcwRVJvd0hyeW1Odkw5c1NtQ2dtYUJrN2NQOHlqTU84cXVTUCtTUmRHYWFq?=
 =?utf-8?B?bUQ2YzFXbFBTSU12K2wwcnlqeDZIM29XdG1LZWFrWTYzQkpFYW93WlJkZm4x?=
 =?utf-8?B?Zk1ocGE1M05FRy9FSkZPRjQ4SkpVbC92eStsUGNWZS9TQzlldDMzT3pHMEIy?=
 =?utf-8?B?WHlBMnJmS01mL2RLL0Z6cnE4cnhjSndkbm9td05rWWk5bDdNTlhDWWoyOGZn?=
 =?utf-8?B?M25ISllUTTd2TDBmZDhhSGFSdHRHZ1VWaW52RncxWkN6ZXd6WWsrSDZCTmxV?=
 =?utf-8?B?ejJQQVhmazIwUE5RbllJb0tJV09aVFRGL1BadTh3bU4yZCtFeFhESHpyWmh1?=
 =?utf-8?B?MFVKckFiTlhQMVVqRHlSLzlWc084Zmd0c1p5S3RtblNJR0xJbDJtbmlTNTZt?=
 =?utf-8?B?a2dtQ3hQaGdnai8xZCtOZlNVTEVXaXN0K0ZENENtZnNVNXd5NEJ3N1gwQ2hW?=
 =?utf-8?B?Q1ZpeDJkMEVGNlltdFA2M0NVTXhZL2VuNTBaanhGRno3bTJHQVp6NHJKUHZS?=
 =?utf-8?B?VC9mR3RMV1Q1emRvSVhsaXhYcTFqNldXVlFvQTVYVkIxY3A5RzlsNjlkRTJK?=
 =?utf-8?B?Y1cyUXFXakFPU3pZb1NuQkxoTHQwQTlhVEs1eWMvS29tSDEwQmlxam1RR3FR?=
 =?utf-8?B?ekx5dGx6b1VEUTMzb2FQd25ONlc1SWhJaWJHdFVnWi84RHI3bVhZSHY0SkpH?=
 =?utf-8?B?bDV3MFZ0WHJVU1p0K0NJRTNUa0dKY1JBQTVKaG15RGUvdTRqTUxhc1BBZ1NE?=
 =?utf-8?B?aEZVR1dDemlzZytxaWRJajdFQjE0azF2UjIzbUxTM0E5SGRPSkpaalNFRXp6?=
 =?utf-8?B?QkxOUmJHakpGbjFHOEpyWkkyYmR3dUZWVk5KR2xkbnZwOFRoUXNtUnprb1lI?=
 =?utf-8?B?UENZc2dOOTVzeDcwdlV0THZFekFpUU5WeHdOckxSTU5aR0M0WHhPTDE2RnB1?=
 =?utf-8?B?anJldm5mM29DcTA5bFNKREFWRmpwYXVEc2tOK3pLU1QrejUxVDRhN1pLQlk5?=
 =?utf-8?B?TUtPUVpJdG9FcjVEVEZ4T2VQcTVRUmdJQ0h3WXlNcWRCVE9Xa0VlaGxESEpQ?=
 =?utf-8?B?YW0wTkdpSjZTenRqNXowcVdNVjF5aXB3THlDdU01MGRlYkxrWkxOOWxzTWt2?=
 =?utf-8?B?UnBBZC91b3ArN2JTMG5vMmx5YU1CZFJKSWNLaDZ1QmU4aS9KcVA0ZG40R0Zi?=
 =?utf-8?B?VnVGaHdvcmlvQTlXR0FxNmtKbU1KeDYrN2xWOGRhK0tKcUpSckVidEtJOEd1?=
 =?utf-8?B?eVZaNTBkaU1uVFh2KzBCbWVtMmJ5cHZrM0EvTlRDTWxiNHFwU3VNbkl3d3Bs?=
 =?utf-8?B?TVFjZXVCWW1IMnMzaStwQ0N3LzlQcEhNZjlYK085RzBPemMwTjNZMFhLd1M3?=
 =?utf-8?B?eVp5OXdFbitEcDV6YUppaSswNU42dXhQK0V2ZW5RSC9TYXVFc3JnY0tVN21s?=
 =?utf-8?B?TFNVUFRiZ2N1ejVuWVF0WGRKNnJodDkrYm16L0lqcCtSZ2V4TGZjSEFsT2h4?=
 =?utf-8?B?ejdFNGRQeS9FWGs4Z2JSWFo1eTMydE40MGl6U3RCNkh3UXphWXNtTDkyblhH?=
 =?utf-8?B?MW8wNWg1OVVCVWxoTEZyQlB5anRFVWFZQlgwSy94UE4yV2VPZ0xnOHNaTEhu?=
 =?utf-8?Q?KqyZ17yl8Ee1IPPYhxSYH9Red?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3663f6fc-d15f-4991-7fcf-08db61691104
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 23:53:29.0347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lDlKnJccCqYedYH76nXmj4zOc/eKNUaCZSBcmOh3eVspVYEZHQKJEQinRhzBEZj6esQSSIPyApT6IoNt5mJH0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7190
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


On 5/25/23 20:41, Davidlohr Bueso wrote:
> On Thu, 25 May 2023, Davidlohr Bueso wrote:
>
>> Implement support for CXL 3.0 8.2.9.8.5.1 Sanitize. This is done by
>> adding a security/sanitize' memdev sysfs file, which is poll(2)-capable
>> for completion. Unlike all other background commands, this is the
>> only operation that is special and monopolizes the device for long
>> periods of time.
>
> As becomes obvious in the code, this paragraph actually should have
> been updated: the pollable/read file for the status of sanitation
> is the security/state.


Reviewed-by: Dave Jiang <dave.jiang@intel.com> with above update.




>
> Thanks,
> Davidlohr
