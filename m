Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F90DC7EE29
	for <linux-cxl@archiver.kernel.org>; Thu, 25 May 2023 21:10:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjEYVKH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 25 May 2023 17:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241411AbjEYVKA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 25 May 2023 17:10:00 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0389E198
        for <linux-cxl@vger.kernel.org>; Thu, 25 May 2023 14:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685048999; x=1716584999;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OAGMl7MtMGPaz9jFQqIz6P/+Di4VZs5t+clzxzglBAE=;
  b=T28R09DpH49nIEI8unf2KjWaRF8P4AMRxsBRZqATqm7mhIj74lot/ih9
   Zx9RD+nmjAQ/hz3CiGOlkpTAg1qXiRmQuHvN1R5H6Yj7rxNfKDTctmUVD
   HMWgK1Q/fG5lUdOWTlyxTXxAbJ8tWiQQhYScEZxKLrmWguoBqE6Ab83El
   59Enr4OAh+vfKYxa7OOMNQydNlE7UP6JEnaYvfB09bvm2YMV3CVDx94DL
   /pymYHZF3mVNVRcDGynve4LXDQseBm97A6iMS1u6ChbtEmECxsL9w0MZp
   VtPzon3kJVz0TTYdQNBYk/NILJSSSr667/GlqKYF+7y7SH6BC79msbiXc
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="343520361"
X-IronPort-AV: E=Sophos;i="6.00,192,1681196400"; 
   d="scan'208";a="343520361"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 14:09:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="774821563"
X-IronPort-AV: E=Sophos;i="6.00,192,1681196400"; 
   d="scan'208";a="774821563"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga004.fm.intel.com with ESMTP; 25 May 2023 14:09:58 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 25 May 2023 14:09:57 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 25 May 2023 14:09:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 25 May 2023 14:09:57 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 25 May 2023 14:09:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5VzRlN8XAyTAOT0g8pYj8PtfL6s8KwQp5sy4P+04QreqD2cb7hbfLR7ookMKT1wlf3s3A0LG0ef1/JSuojHID9PxOlV4u+EkN42lf5CiPNU5kG3IsO8BhD5fXv++7Uluc156LRvUy53/9clkkBHEXldzvN7FP87eMxbMiFzkQuR2zGEgvtlbnai+B0BnqJnyqe9W+KFf+x0/D11uFvvW34rDMCTTOjTI4o7cumJIgWuqa0vDbXB/fi2ktNprd/tGkELxyCJaH1y0rhd8PXrFuCKPzqNwvWnk2jPMWeTVKEVAPSBZLEFJPzWTFZgTUAdFXRC4+lKcCTTsHHSdAWrXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ex/lt0RQhGAOw2hVJpF8VfWFTKoGnDUOQYktU8+0RWc=;
 b=fNC03N5UGURh9uMSgQV2mq51z75NDAZ4GkpvOkbUyNNEMnI0v6wtpy5f92KgSPwXSxW8QiXVpwcN9YRVzrisdohXMZWV/CbQKdf5rpofhubkg4M1v/V75m55OVoCOR/msz1c14p/pudajrPhcq84vHq7mnRLeYoBVJWzmAJqNWDnZFvPwUeCqlJHpN9GY+XIOFlou5iJgoLDjtIx3EwEbBw39ywR18HlpKk8j5qoD0zJRDXKP3MWtddtHJ0bfzm9TPSipQ93QGD5OdCKSLHxhk9qjc7bqRPPPt9cvMNx8+BYSC0r4EKbiIQSNEP9jMk8USZhzNi37t6e6phuFwg/TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by CH3PR11MB7796.namprd11.prod.outlook.com (2603:10b6:610:121::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Thu, 25 May
 2023 21:09:55 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::b315:faf6:e706:ca61]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::b315:faf6:e706:ca61%5]) with mapi id 15.20.6411.028; Thu, 25 May 2023
 21:09:55 +0000
Message-ID: <75f91063-fb2b-199c-cac1-02277675bb23@intel.com>
Date:   Thu, 25 May 2023 14:09:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Subject: Re: [PATCH v6 04/11] cxl: Add support for _DSM Function for
 retrieving QTG ID
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
References: <168451588868.3470703.3527256859632103687.stgit@djiang5-mobl3>
 <168451601833.3470703.277986088556971387.stgit@djiang5-mobl3>
 <20230525174412.00000783@Huawei.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230525174412.00000783@Huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0360.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::35) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|CH3PR11MB7796:EE_
X-MS-Office365-Filtering-Correlation-Id: 89c77313-ff2b-475b-3bbb-08db5d646358
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZfBsM93TT2BoC02z/TBLat3lE247H2Z+LcAUJMmaBIuq3CVLHMfxGRB/bX56QlJ75148zy5pKbIGsLs8YzabKS1IJ9uqYnCh5rfRdqEd3H2mapIvWGpXF3dC2tf6RsUnOlDm2kL/4N6SS0ZWDoSp+fDrwRKe5GOsQ6uKAmM2wp3l/L6ksDsRIY1X35IwLEOrX6vGzWRIvyUzuw+n0QqFQQwc30MDZUIBpfQDiR43+I9qFyxhusPqeNGHP+x15M4DnxdMOsfVtTzd4JZo+j7YvWw8PpYH1457u0hy2uH/Z7VKONZyoHmGgBRqHZhHducbSWodb0+ELfVWg0iiSYRX4conf82khUaCDujhu5uji/XKabhCtZNJeBgfMYwpS5xXVs/etYw8nSE2epb+P7nKeuo6GZQ8qmUXF7Iz2bh+MLUTDAf4E7RX9nWZ1LcupXRNvuPe5I5i7/I6DabQzIWbDXp7TzJiUB7TluLMQoOBIPMQbpClfiQILMTA8f04neg95rryInoEVsSHpuBYk0KZ2OY8IUMjTRTMRWzZeYkXpGwT+G5ZEq5zSDsy63FuulOvxkG49GGw8gowbbtoSSSMoNvaH9MDwBfAJvMjEoLLD+zOPPQ30NhfYM+JLxWisA411b1v1P19vK3OZOVzYCsmjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(376002)(366004)(346002)(136003)(451199021)(4326008)(83380400001)(6486002)(6916009)(66476007)(66556008)(66946007)(107886003)(6666004)(6512007)(26005)(6506007)(2616005)(478600001)(2906002)(86362001)(186003)(31696002)(8676002)(53546011)(8936002)(5660300002)(44832011)(36756003)(82960400001)(38100700002)(316002)(41300700001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTF4bUZGNVk0T3U1RDZrUUxBM3M0cVZjOC8vdnNYQVNzNDAxZjdPNitnVW5Q?=
 =?utf-8?B?OGpBV2VGd0dYSlYzd3RLYkhNS2lsWWhsSE5ncURiR1BaRnlaZEVLSkN5MzRm?=
 =?utf-8?B?NHBnMm1ycmUyYVpVQkI3eHl5SEp4ekIvK3RvSG5aM2RiOEFXU0RWYXV2dWhj?=
 =?utf-8?B?Q3UrUEM1L1o3N2pSNVdjS2EyajgveWEzK0FGN21QV0pYWlZzYVhJbmZ6UkI0?=
 =?utf-8?B?Z2lLQmYrVVRNdEhlKysyUzVtdDQ1Z2xPWHVrUFljUExjYnpmSUh3ZTVjODVl?=
 =?utf-8?B?R3dCY25JQ21UdElpU2ZOdU8yc253KzMvdlRRSThGQU0wTXV0ajVvQk8vYks0?=
 =?utf-8?B?OGRRMEpzM08wK29FKzRYSnEvUEhPL1RBMk4yaWhqTENUTDFFN05yT0FxUlRE?=
 =?utf-8?B?QWk5NVRrd1lFQW9sZFRJaXA2aEJmVUNNSWRVQ3Y2c01zeGEzMThmVVc1ZHpm?=
 =?utf-8?B?MWFKNWVncndaamlhNVhiT2NxaFkwTmtYZUhQWUkwTzRaY0RZdTZiRVo3SFdl?=
 =?utf-8?B?bFVONjFaZEplUHlCN01zRVNuS1o3M3Q4MEZEci9MaHA0a240K1FMVEhaVnN6?=
 =?utf-8?B?SWtqTWM5NC85dUptRmpyeWxac1YxNVVkdWZ1QzM0M21aUVZ6d1NOZWRpV2l5?=
 =?utf-8?B?NDBTR1ZObVpFVDU3RmY2MjYvK1RZT1YwZkMzMG9NQjZoblp6VWREc3k1b2tD?=
 =?utf-8?B?ekprdFdJRnN1N3QrNEFIck5qUVRaR2ovZndOMkpMYmN5bjNlUVluZDMzRXlO?=
 =?utf-8?B?ZkJHVzBJQWN1TjZycUludmhTQkxYU1BYMmtHNlFvYUhKaFNBQnladmpJTytN?=
 =?utf-8?B?QkYyTjFvODc2Z2xhY2ZJclkrbjFjdEZ6bmVjT01rTEk5MklXU3hSSVNIYmFa?=
 =?utf-8?B?ZTMyUHE0N2tjS0pOc1ovS1pSM3cvS20vbXdkdEMwNFFTNHpHRFRPWm02U2pp?=
 =?utf-8?B?ODM0L2g5dDlCS09rVjY1YVhuanBpS1NxNHl1ZkdoWnlubFJiaTBxbXB0NHQv?=
 =?utf-8?B?WUN0aHlGTytrMnBwTCtwNWZQY1JBam1ZNTBpaWg1a2YyMnAyeUdOYXhTUkNl?=
 =?utf-8?B?VVhOdDg5d2dtZ1p3Y2pTc3UrU1VoS2NKTU1admxxU0hzUUVyenFwVzA1a0JW?=
 =?utf-8?B?VU83NWg3cnFsWUJoK0p4dUdTcVkzazZBUlVTWjhNRlRCaDdYOTNGckRkTDdx?=
 =?utf-8?B?MDFoUWdxNzZGNEFMU3kvNHpXOUtaTzVTaHhRK010L2JEMUo4dys2SmVaSllH?=
 =?utf-8?B?NjVUa2FhcHpqR1hYRmNGWnM0OE45VHRzVnVWS3BzODBnSjFaQk4zR3NoZkM0?=
 =?utf-8?B?VDhxZU5DdWVDZnhhN05kdzZ1ZmVxTXNWUnhrZ2x1VUJuOHNZT0k1cDhxWWJ6?=
 =?utf-8?B?cEMvV09oNXRyczE1Q28wdWtIRnRydEdTZmM3VzhucFh2ZXE0TVpIMm0zaGtt?=
 =?utf-8?B?RDV6eXI2VXJhVGJjbllOU25YaXRFK0U2V2pReDhNWXlJK0xpMUFmTzVEbnRL?=
 =?utf-8?B?Um4yT2tDUFMwMHhlNEhBYVVubm43eWhjRjlTZWtqVnVKNjk3eVh3Kyt0QUww?=
 =?utf-8?B?N1pDNnVZc1hwNkUvYnd4ck9RbTl1djdDSEI0R3JjeTl0bFpFY1luaEZTbHQv?=
 =?utf-8?B?VTBHZzZDczdhTEtoL2NKMTlWQzMvZ0s3L0Y4bE1pTnJKZTZsM0VOVkhOenVC?=
 =?utf-8?B?ZitMbElSYlRjRm0wd2NRWnBuQk9yNExMWmQwU2p4SVYzV1V6KzZiOGNJVkZ4?=
 =?utf-8?B?TnJ5TElYNSs3NVpIN25wUU81a2xKaTBqVWt6RzFraTZiSjd5M1pTbFdQSVRZ?=
 =?utf-8?B?RWpGODUwSHBkbzJMZ0lkcmNhVDIzejR3eHkzSVk0YnBuK3YwZUdqclJwcUdw?=
 =?utf-8?B?d1FEQmJNY29OVzJoendPa2RuVGoyUXRqN2c0WWhjTzV4UHoydklwRm1pOVh0?=
 =?utf-8?B?Ri9ua0RkaG9CTkdUTytnUTRsV2VBbDFlcHBETmdJK0hGeEVGR21KSkN4WnlL?=
 =?utf-8?B?Y1RJWitKUitUaGxJekp5bXFvek5HSUFMZ1lWVHdpeFdkR0hSZDZGTy93NHQ1?=
 =?utf-8?B?TjYxWEZ1eHVkeXBHVUhvRjVnTkNLR1lUcXNhNkh4U3FiUjNWWFQ0dDNQbzZQ?=
 =?utf-8?Q?ZR+GMuiM527qoJFHTlnAsDuSM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 89c77313-ff2b-475b-3bbb-08db5d646358
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2023 21:09:55.0519
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BF/oGME4hux4jpbhPcCZvQ9lXr4hXuEnwbKoQk9XUlVpTmHEh6Aw6wyyVFsRMw1AYOFm3vVSbyVCDKvMNeq1ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7796
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


On 5/25/23 09:44, Jonathan Cameron wrote:
> On Fri, 19 May 2023 10:06:58 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
>
>> CXL spec v3.0 9.17.3 CXL Root Device Specific Methods (_DSM)
>>
>> Add support to retrieve QTG ID via ACPI _DSM call. The _DSM call requires
>> an input of an ACPI package with 4 dwords (read latency, write latency,
>> read bandwidth, write bandwidth). The call returns a package with 1 WORD
>> that provides the max supported QTG ID and a package that may contain 0 or
>> more WORDs as the recommended QTG IDs in the recommended order.
>>
>> Create a cxl_root container for the root cxl_port and provide a callback
>> ->get_qos_class() in order to retrieve the QoS class. For the ACPI case,
>> the _DSM helper is used to retrieve the QTG ID and returned. A
>> devm_cxl_add_root() function is added for root port setup and registration
>> of the cxl_root callback operation(s).
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>>
>> caluclate
>>
>> caculates
> ?

Oops. Stray edits from when I was trying to figure out why my checkpatch 
codespell not working. Thanks. :)


>> ---
