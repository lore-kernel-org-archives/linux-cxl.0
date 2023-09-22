Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2497CE7A81
	for <linux-cxl@archiver.kernel.org>; Fri, 22 Sep 2023 21:00:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjIVVAL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 22 Sep 2023 17:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjIVU75 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 22 Sep 2023 16:59:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F7BCE
        for <linux-cxl@vger.kernel.org>; Fri, 22 Sep 2023 13:59:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695416391; x=1726952391;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XF+PkmfKmmfKJPlVIAk53mJIBHivSF2TIyi3B5FZvHo=;
  b=YXSlaFNRRvj3daEw+uSVF39UYaRd1MhBdK0hxlgvoaENDpQRBB7wVUyT
   Y9Q3qHHhUU0tRB3ysh5iaCw1UPWZE/uw5BWnDNluRxx20Y9liEI08nexA
   fr4ROndZo/fOKVW0T5Vhk3AYT6k6ED2Z3deEwuQagkiA1KxTvwOPJHIYh
   ZZuWoHPllC2IPRrpVZEzQOjz1TnjCIm2sbFWsJkfnPNrRlW5IQ9DptQNS
   b2u28pVCo7CJkiPtqmGHQA4eK36Mh9Lpt0TRZTOYqDHfsJcf1mHreA+lC
   RGxyKGSOiVZJPG3WMVkfyuT9EnGDQE3Fvh5Fmj2iZH4MoEmg/bqr3HGnW
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="383691840"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="383691840"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 13:59:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="750965572"
X-IronPort-AV: E=Sophos;i="6.03,169,1694761200"; 
   d="scan'208";a="750965572"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Sep 2023 13:59:50 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 22 Sep 2023 13:59:50 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 22 Sep 2023 13:59:49 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 22 Sep 2023 13:59:49 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 22 Sep 2023 13:59:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UcgxcYAfzr6XhE4Ioj3aS98GZu0IOwxXMWYsl67iPNcjXsoctdnoIVo2MA86xvQ+52MosH1Cc05y6MsfF0WKi8aZPbh3RuG8qvBbzfPdz40hotM9RlV8zinsTrp7COB6fNuq4D1H+IItbAZj0NCEOo06yTecsKyCYxtGfnSM4kDtG3wuzQld897ALe5SGIHlQVkj7n/hnIjv7H/1bFwlZGaOvbzBIeRhdPTER3xoaaOJmB6rVz/GuEIFjVOGTJqLZHdnQpKVHZ0D2T3gLQiL6pw06AClArTQntNwW09Qrg7zw3a9UAfvPiVu1VBcUq3tNLvv4RVct9v+jDhNvpsRdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vWqJXVz+LCvKESXXHYCBblwVKoRST2pHGMj6sDcYJ9k=;
 b=Km+xEtCm76acVGTczSguYfPJE+vELh2nqK0eLEv/5zYTZsuOes3mdm+36+r4wps9/e6Km+1xuU5cpcihkHyjhDDSz3O4CCn9k60iNrCqMZ3uNkcmR5wA/Z/JUAxusQoK5LEBzrC9/nhmOWyhFf6gU5NIrST4QYRc6JF6qyI5wW28HFdOq2dqzXm7EbcgxJjwgtkvFy3RM9HrYTbgYuwJvjT0kxJikcJGyNn0URgGwTuWQ2ruVDti2TQJqZhn7bNnKwpj6rN477pyHBzzLiP4qCqNduD0UsO/46Fx/XveY6wkLCvAIHa1u5KxP2sGRuVpXZVM1D/9JKasCUJNT68QPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SA1PR11MB8426.namprd11.prod.outlook.com (2603:10b6:806:38d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Fri, 22 Sep
 2023 20:59:47 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::e9ca:a5a7:ada1:6ee8%5]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 20:59:47 +0000
Message-ID: <d0681b65-0141-68a8-08ed-a227df3c12b2@intel.com>
Date:   Fri, 22 Sep 2023 13:59:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH 2/4] hw/pci-bridge/cxl_upstream: Fix bandwidth entry base
 unit for SSLBIS
To:     Michael Tokarev <mjt@tls.msk.ru>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>
CC:     Li Zhijian <lizhijian@cn.fujitsu.com>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
        <linuxarm@huawei.com>
References: <20230904132806.6094-1-Jonathan.Cameron@huawei.com>
 <20230904132806.6094-3-Jonathan.Cameron@huawei.com>
 <f92187e6-c7a3-3826-f980-b95533e18643@tls.msk.ru>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <f92187e6-c7a3-3826-f980-b95533e18643@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:a03:74::15) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SA1PR11MB8426:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e2961ac-663a-4d9b-1f48-08dbbbaeda54
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qIemGZE80/51rdXy7Vkro5tCTelDD61/ROAPr2rX1k+Q265Zg13hZQrbifXGoqX+zzCwax6M6Hv3gTTH/A8F9+1kJl55PaDpwjemcTDqTqUBcSq8zR3Cc9E4MDJdchnbeH3EXIf8JO9ZXkNwytp4RAnc3VdRTACSvF1YCWY0yb3ucnSj3MRqx2nPSrEhlcVPkj8tr0OH0Rwj4B4QRNfq4p5v1WCU1ToXx8sOKaVeA7GMOxpYhQqIayLNN8m+27hCHtcXKW7wLXT24tb6e65OyDqCI5jZo6imQvL48OZxKIMUxmFMtrcS95thC+YnekW7w/Dq8ZvxAunTpDutiV5G3laVA1HH6qWcMZCGgUuGMl2f2rDXQHuPkOEkVLa4pM1+FoAa0cdolSychMv2onIafUTKfW1vhawxSWygkLbex27FDOGYF7oCWJJeNXAz5RyOMdKDE+Qdjjja00jeFvKUaZ8WumalJ9+M5tplM3gK8aqRiDNRTrt/foQ9jnZqeITRDV25p6Z2wO+F2mlh3KWiLeZWAAt7eykOdvzy6/MyO/H1IejF4k4mwiCtKX0q8F7Xvj/3RMzaq3pnFO3PWmqd7yZyovJzSgjj4zMnDvgZ8+69E3CuR7g5ijNDL8O/SGNcrxz0OQW3K3ktQZHXcoOOQg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(396003)(366004)(186009)(1800799009)(451199024)(41300700001)(38100700002)(82960400001)(6666004)(36756003)(478600001)(2906002)(6486002)(2616005)(31696002)(86362001)(53546011)(26005)(6512007)(6506007)(83380400001)(316002)(66946007)(54906003)(66556008)(66476007)(4326008)(31686004)(110136005)(8676002)(8936002)(44832011)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGdra2dNR1pqWDlrUWF6Ym5NdTJJaHo0Y0s1WkRpYkNHNGpOekJ2aG5TVm44?=
 =?utf-8?B?cmFlYmU4WkJEc1JHSDNuNXp3R0lzRmpDdGpkTmdpVzBHSkxLQUdXVW5OL2tI?=
 =?utf-8?B?dWp2YjJpWW1sQUNCN2hhMmgwWERnRHRYKzc5eE5FRWE2UXpNS0htbERpUFpU?=
 =?utf-8?B?VTBBRlNXVUxzYWl1dnJLeFRzRlhHeDhMOEdJbTVkd2ZmMHB5R09MUXBVem1M?=
 =?utf-8?B?ZWo3WHdTc2kvdTJPSHJadUxtVVR3Uzc1OU9QdVlJWTUvM2VacWNNcjhQaDJW?=
 =?utf-8?B?amQycVZiZmp5eGU3QjBRZjIyd0R6NG9HU1oyYlpoUHZRNWJKUHlmTXNLUG43?=
 =?utf-8?B?VktheVdDL0xvYzlDYmd4NlVpVGxHR25BOTcrU2VpdTJMOW94OWJpODZ5Y3Nw?=
 =?utf-8?B?ODJnTy9wdzhJcHB2cWlOeDdmVkM5OWdXVFBib1l1MGI0N1M4RUVhOU12bnRw?=
 =?utf-8?B?cEpZWmUyemJObUNFV1BGK1BZb0diRmlreUhqYVE2cmV2ZUVkdUJ0cFpBczFw?=
 =?utf-8?B?YzU2TnRobkp3Vm4vWnJvMzR2ZjFCOVd2QkNkek0xclhKajNYeHQzM3M1ajhx?=
 =?utf-8?B?eU01YU1uRXlBWU82c2N0b1Q0MVdSSTJhUDhxZlFuQXNtbDZRY2kxTGRQR1FM?=
 =?utf-8?B?TTBlTnNEL2JQanVIZnpuYXFkd252ODlrcGphb3NFUU5Vanp4d0E3MHpmVjRO?=
 =?utf-8?B?dE13SnRNaHBNVXptcmtLbjlxdkRJMWNpWDFEaXdUZllrNWx6R1N3VDJpYm1k?=
 =?utf-8?B?TzJ3b2hpQVdoN0ZPTG4zM2FhME5WQU40ZVpNZDZZdjIyVUlaM2hlbzZadG13?=
 =?utf-8?B?Q1dvckRyME5UN295L3JveFJ2dExzWjRTY3V2TEZ6WU9DcjRhMEtLZkxkb29Z?=
 =?utf-8?B?RW1GVGhIR3NwTEUwUjBXbG0vRWRNb1hWNFZCeHlnYUllNEN1L0R4c3UzY2xV?=
 =?utf-8?B?NlJHSEZMQ3VIaWdJaTMvakN6U2cyZWJ6Y1pDRkZ1Ykg5dW5RbTRyRFZ5N1RB?=
 =?utf-8?B?aS92bkl5VGV3K2VvZXkremR5WFIvQXFRaWVCTUN4Nk5BTDc5ZXdkVVo5TXoy?=
 =?utf-8?B?VU8vODFGV3MwSXNWN0t3bllMdEVtcmF0N2NCOWFQME1rRnRPd1ZYTWhmZHRa?=
 =?utf-8?B?NXlvZ2FwaUViMHpBSThaNDhsZ1V5YnBFQytWQXRvSDJOZFBmMVNwU2hrQmhz?=
 =?utf-8?B?R0lFYnhIN0prN2R0dHdCaDFxNENocldqVFExaGM0V0Q2TldKRUV4QVk1eUZJ?=
 =?utf-8?B?WTRXSTZlb0V4TnJLZEE1ZlFSY0tzaVZFSSsyVUllcFpjSFlBc0xjWi9QTnl0?=
 =?utf-8?B?V2VJdmxHK0s2UVUyNzFaYkRtdHJUUkU2WTduMkxEWmpnVGh2bC82NnlBcmRZ?=
 =?utf-8?B?cHJjUm9EZ2JPaE9nc0hKMng3Tk80SzN5WWVmV3dwZ2FwdE45dEtmUDhRMkNR?=
 =?utf-8?B?bmV1a2V2MjVqc0RsZ3h3OWYvUHpCTkxHR2IzUFNCYmRIQ3J5d005eVZiSWow?=
 =?utf-8?B?bDZTWUFiS3J1VGlEOGt1dTQrd1dib3piM3VBRlRtRDJZL2UwRjUyeEsvM1FM?=
 =?utf-8?B?QUVrTldGcDdONUFQS2lvUHZZWWZSWXFNUld6VG81U3duNkl6eGdnM3A4TEN2?=
 =?utf-8?B?ZHNMMnZWcCtEZlRLRm9sZ1lZdnQ5c0JjODZmS3U0eDlkNDVQODdhKzRqRWhB?=
 =?utf-8?B?azJYL3NsOU9MbGZtMnZabjFWVGVIRDlWdmJVRnROeFhsbXhmeSszeFoxTUFN?=
 =?utf-8?B?Q2pJTHhURENNVDVQM29TbVBacGFSV1l5K1dEMXExeGF5V1NIZ0RmSktDOXVU?=
 =?utf-8?B?dEh0aGxJWEtka241Q2w5L3kxQVhUZm9iVnNxUFdubWlrSkZNK2hEZVBmdXk5?=
 =?utf-8?B?OEZwS244NXl0VmwxOTM2NnBKUnBpRVBKcis0MWo4Mm90TlVHWVlYTzFCT1pv?=
 =?utf-8?B?SXVCSGV2ckxGOWdkSURUUWZPdXJiQXhMVmU5Y3ZZNkVLeU94WkdMWk9ZSzR1?=
 =?utf-8?B?T1M3NUxzS1dWdTVUUG1hVHdHU2pzeEkvdWxxMUQ3THVWQmd2M21OVVJSRW16?=
 =?utf-8?B?RiszTVFUNkNoV0pXS0lIYXhob2xMRHlzZDVWclZneHJVN1Y5RkVtbHdSWFFH?=
 =?utf-8?Q?b6L+/YXPXmW3g99uc6rZbcWl9?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e2961ac-663a-4d9b-1f48-08dbbbaeda54
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 20:59:46.7058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1oIbOVkpjrlpw0+ZshhPKb0IhIUd3jIjCW/fQO6OGqGfg8P7C70RtrIM9XLhFYiGPqZahWRXFqRFHlVFZf9wOw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8426
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 9/22/23 13:08, Michael Tokarev wrote:
> 04.09.2023 16:28, Jonathan Cameron:
>> From: Dave Jiang <dave.jiang@intel.com>
>>
>> According to ACPI spec 6.5 5.2.28.4 System Locality Latency and Bandwidth
>> Information Structure, if the "Entry Base Unit" is 1024 for BW and the
>> matrix entry has the value of 100, the BW is 100 GB/s. So the
>> entry_base_unit should be changed from 1000 to 1024 given the comment notes
>> it's 16GB/s for .latency_bandwidth.
>>
>> Fixes: 882877fc359d ("hw/pci-bridge/cxl-upstream: Add a CDAT table access DOE")
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> ---
>>   hw/pci-bridge/cxl_upstream.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
>> index 9159f48a8c..2b9cf0cc97 100644
>> --- a/hw/pci-bridge/cxl_upstream.c
>> +++ b/hw/pci-bridge/cxl_upstream.c
>> @@ -262,7 +262,7 @@ static int build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
>>                   .length = sslbis_size,
>>               },
>>               .data_type = HMATLB_DATA_TYPE_ACCESS_BANDWIDTH,
>> -            .entry_base_unit = 1000,
>> +            .entry_base_unit = 1024,
>>           },
>>       };
> 
> BTW, is this one stable-worthly?  How it's been found, - due to some real
> issue or just by code review?

Code review. I was doing CXL CDAT parsing. So I guess I'm the first user. It's small enough that it won't make much of a difference for the resulting computed data. Mostly just correctness fixing. 
> 
> Thanks,
> 
> /mjt
> 
> 
