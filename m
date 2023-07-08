Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F06EB64DA
	for <linux-cxl@archiver.kernel.org>; Sat,  8 Jul 2023 00:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbjGHAdb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 7 Jul 2023 20:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjGHAda (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 7 Jul 2023 20:33:30 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D2E1991
        for <linux-cxl@vger.kernel.org>; Fri,  7 Jul 2023 17:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688776408; x=1720312408;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=fQD7qA0JacRLdyRx7+NoHrJAdR43gIWNF1njB6VJE+k=;
  b=TyYOnjpahL/JitI26kkL+o5iNS7D8TQJFVH7GKOmZT51lvv23DJYQ2FL
   lYJ1sqPVsE2O+9w0vD+5PZCScgQOuaWJbtV8uCPSN22HqNH4ynrGwlREI
   CqX1OVzbnkK8ZPNdvZtNx0+Z4g6kO1ZGAlpTjtstJ3YMqNiJuDyiH+8Bv
   VnQq869/zQMiIQ/q0ADf/NEac875X10asxxUHtKUtN+kFG0vRQAnEe9us
   nLUn8gPuFjIfah1bdcHSK4A+7Q8ak7+wa+Ts+CGN+AXbf7Tzmw7mbBiRN
   4TUzicLxU+cnl8g6P+4KvZJdC/k8cneZvhgzpLsJt1K6VHw9sXH1hPYO1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="430075202"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="430075202"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2023 17:33:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10764"; a="714192370"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="714192370"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 07 Jul 2023 17:33:08 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 7 Jul 2023 17:33:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 7 Jul 2023 17:33:08 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 7 Jul 2023 17:33:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fL8F83nw0ZFR7703y/xOodwQCPBT4jPqs0Pu9rZtaG0OY1LL9x64Xt2i2dTbzRrfSk+4gokEhWBAcEk0ph3baHxfX4j6XaKXrXnHugy7N41fKnUToqcQ3HGIYyC+8xnit2uBixLNmdGx9H5dkq0XN0VvOJMxPQGfNhUacmSzVDeO0nJ/3vU/xyi6E0VThQvMYCVRHpL+LSMym9bAju0WJt7/UXfQbwAkzS80jt57otHpeskLfQCmlF/hDZjDfVgPsAaVZklLRENy/wg28KndXMRJS0egvGOWn2BSRY9f5iC2dUmLR8s0LLPgKiK9tzF152jVlm1A8rZB02UMZCNDQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1EbdXMYC6QT9iyJscjnvHBfUW2om32KuZyM/JvpeHxA=;
 b=Dw1oY0UFBEits86WChbSSoJ50gt/eAO9BGN+9YUzccH4jHi0UmDt0FM04gce4vmybvlXxg3bTzH6AwXPdEj50+jeVBV6TiY9r7ewmCnEgjcROdflrua/7CgVS3cGONy76lNiqoRubIflIIo3yeNajmudbfOp97Seuuy5OCLEQVxB/xeL1WfitGJMh2Da5Kl94GJIKcC3vQly900EgzFwDYwRd+jumuQOJmALe0Kolr8TZFwg5Wkfo/vTnFyym4Zgj3g+/saDp2u33POUYmgPor7GkwukjbY4sr9GjW5A20dn8VB5BVYWq3QZLVGpUEeeTY1wEi1bzuyWu/otIZRdsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DM4PR11MB6429.namprd11.prod.outlook.com (2603:10b6:8:b5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Sat, 8 Jul
 2023 00:33:06 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6544.024; Sat, 8 Jul 2023
 00:33:06 +0000
Message-ID: <ea6cc344-f65e-4eff-268a-3c0890b5ed0d@intel.com>
Date:   Fri, 7 Jul 2023 17:33:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.12.0
Subject: Re: [PATCH] cxl/acpi: Release device after dev_err
To:     Alison Schofield <alison.schofield@intel.com>,
        Breno Leitao <leitao@debian.org>
CC:     <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
References: <20230707161616.3554167-1-leitao@debian.org>
 <ZKiPFu0KY0alQxCJ@aschofie-mobl2>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <ZKiPFu0KY0alQxCJ@aschofie-mobl2>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0035.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::10) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DM4PR11MB6429:EE_
X-MS-Office365-Filtering-Correlation-Id: 921bbcd9-55e3-49c6-0e02-08db7f4ae5a0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: htAezFgL8lYGA7Vt7Oyv4GqlGk7zqIJsPKu6DDUTOC/PdNUSx42bbrnJ9mtVaN3tkwBQNUrcL2zOT9gax6RWbXLUVvGSPNGyGA+C1YxuJH8yUE5xh75Dz2T9jzfrT1RMU/8rt0Yo1VxQ1ZwasgiQXVS+Fx6VZ5cjaq3zfNLfVVMTYUYWUjcgixzMQnw6j6hQhAxMY/khPzSBo4dYP9uJB88chBNrHiZR13Ad2PsrdEVILc8v26mPze+Z25cxRXOHnHWGyZSPxk7DXBtL9nUpQB/LBgNcdFaT9jJ4YHqZwgXBTCmQ/VFLq0oHnMMhtvSWgSLnmjjAv4X0DTtgFbF5RUbWtphi8T4Nzre1pLZ9V6U0QqwoTBO1beOlGSVtGwQoJY0N6tepuiKFsv6Y2COGqBeSJm2znG/Kbl91DXUlbWav3geSi/5h+Gn9A3lOGY9k2mbaA4yxyZpAo+u7oXNeAkHfsOnrtr8Dygj7TUtwSX7fGK7zde475+yCrtsLhGibgeqD6wKjWOUDmgWlUT3Y668itwqg7VBQ4AyvWiFO9PAe4mCK7ex9e9aVGEzunkSQLQo9yD0TjPDv1+zDIFclRk2riyUjyMoE76sxyFsiDuAwc15DarX2fYuG7mh03iC5+zVD+2+Raz2OPzv3TAnFmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(346002)(376002)(396003)(366004)(39860400002)(451199021)(2906002)(8936002)(8676002)(2616005)(5660300002)(26005)(44832011)(6506007)(53546011)(186003)(31686004)(41300700001)(82960400001)(6666004)(6486002)(4326008)(66946007)(66556008)(316002)(36756003)(478600001)(38100700002)(110136005)(6512007)(31696002)(86362001)(66476007)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUp6bWxRMDY4QXlMcGNHRTRGWlZSQy8ra1BQRWhidnp2RlFPNGttZUNjemZB?=
 =?utf-8?B?bGZ1N1BFOE05RjhhMW5xVXc4TERmYTZsWTY2d2RkektnSzBvS0J0UWFFdkhN?=
 =?utf-8?B?eFZKTWpSL1BGM2p3b0Y3Nm9veG41QXJxb3U5bjd5bW5UN1ZCa0RGeUZNcDMx?=
 =?utf-8?B?cW8zcXorcjVpQy9la3IvYWlVU0VpMDVkWEVCT2xlVDQ0NmE2K0JaUEZZRVZw?=
 =?utf-8?B?SzhQTVN1ekxScXJ0ei9kZU9DYk5xeWZqYjZhekpFR20wTEx2S2VncW9rTVBR?=
 =?utf-8?B?cWFva2NCNkZhU1YvbkNSRlpqRnhzQUNvTjdFWTRvWFBvWGlndW9sSXB5OFRU?=
 =?utf-8?B?THJpaGJzMzFBYlQ3TCtVMXhxWTlVSUNnM3F6dWVkbThsZVlIampNWSt4UDdR?=
 =?utf-8?B?RHV0VEhYdlRvYTh4T0h3S2xRWHJLVnpLazZZNGNqUkNvd3gyaVp5d293TkFC?=
 =?utf-8?B?dG8wTXEzSE5QQmlrTDNacTFPeG5uckNPdHEvbVcyaVNzcEFrZXY3ZFYxMDVu?=
 =?utf-8?B?SEFvbkw0VjdsL1o4U0ZXdnQ2U1BCZ0VRbWRQUGc3V3g3R05oZU1vempWKytT?=
 =?utf-8?B?VmlZWXZMTzhJckZrOUZHSkpqWkFDUjZHaHpMcDVYcjlOcmZVR3c2Ykw4OFN1?=
 =?utf-8?B?YzFPOWMyU3QyUFB1eWRDN3N6azJwRzZlQ0hodlMxYnZpT3RaT00xWllLdkpO?=
 =?utf-8?B?aU50bXRkaTdHMGljeVBQTW5zZkRhK0tzRmZaOE1xY1VreEtyYTMwSTQ5TlZB?=
 =?utf-8?B?d0RUeEgvMVFhYTFUTWZ0YURUL3RlT1NTRFFNenQyL0Zock0vUnd4M2JoTnB2?=
 =?utf-8?B?Yy80K3ZobTNxVmFGR21xLzBKL2ZyaXFRMkZ2VEhmZ0s3Y1YvNExoOW5zUTMz?=
 =?utf-8?B?L3B4UThtaDdZcVRjRDFBZ01sU3lRcVJRQzFvZUVNNFY4U3N1N09qanFKK1Jn?=
 =?utf-8?B?eEVZOG9vRE81N0lBSFV1bmZ2Y2pjOWlNYmlyMEVqV1VNVENrOGlkNG9heGsv?=
 =?utf-8?B?eFpYbGl4ZTZSNTVGVVIyY0FLRi9OTmNiazZYWTVrdnp6Wit5SmVZalVTRFVY?=
 =?utf-8?B?dGUwUy9wSkhoTGZWcjlrWmJHNzExb3JNNkFKRjhvOHhJU3kxUXU1SmplMkZo?=
 =?utf-8?B?eFEvSzA3enJRbzRaM0NrciswUWlHVGtlVlhMcTR6ZjVqaEFsSWpxZ0dySmhw?=
 =?utf-8?B?SG1YWnZpVHVGaGYxdXdVbUQxVG1VRmcxZk5WTzFpdnBoR2UvODc1ck1mczRp?=
 =?utf-8?B?ZTVtcFRqb0VaaXJWREVSRWwvNUVkVUFadEJCZ1p5c1BFbWtrWWM2aVlSMm9X?=
 =?utf-8?B?SEluV1dFaUxUTTlzaFJ5ZFkvcTYvTTYrcGZuSzcrbjdWdm8vT29QSGtLYVZ4?=
 =?utf-8?B?UzdRblZaWmhoUFl5U0s1SEtUVGdTKzNwRFg0Z3h5WGRUVXpFb0hSUGJzZXlu?=
 =?utf-8?B?UGQ2dTg4NCtkSWx1WWVwaHNjR2JtZUErV1FMUHFlOFJ3Vy96TkI3cmNoQUhp?=
 =?utf-8?B?WUJISDNOWFdqSnVtNGNhcE45NFYyeFdnRVR6Z0NXMDhOemJmSmI2RG5sdFdt?=
 =?utf-8?B?dktHSjBCb2FYWkt0QTZKMlF4ekt4aVFLS3M3RkZCWWt3a1F3aHFSdjJyMzJt?=
 =?utf-8?B?a29wU05uRTBORXBub2JKTkxWN3JGQUgvTnpIMHVUT1phdVQ4dk9ST0tReGZy?=
 =?utf-8?B?R0JlcjBRVFNUWjI3NHNRWXZMd0drbHdPczJYMFNkeHZaekJ6WXdJanRhWENY?=
 =?utf-8?B?dSttVDFhMVNvWGVwSFZwdGVRbUd2MDFLdmQ2RHhPaFcwRDFQdm84Z0hDUGJL?=
 =?utf-8?B?TnpMUTBVeVZ1KzQyLytoSDdkZjlVU2JRU3J6RmpCa2xnMlhDRmNKcTJZK0dp?=
 =?utf-8?B?bTNJTlZMVWNWUkx0eTVUL1Bmb0hYN2RMSUpFdkpTZ0hCZXdmY1BsY0xPTU1L?=
 =?utf-8?B?VTdPVXgwWTVuOEllUGVmZnBGclVBMXNNWGUxQmFRZ2lsRDJpSE5mMUFtQUpM?=
 =?utf-8?B?Z28zRkpTdll3R2FGbmhEVVZ3M2hoaEUrUkpBWTNlcFlVZURiYTJPNWY1KzVY?=
 =?utf-8?B?RWJOaDk0RTF1VmRHa0hIY21sL0wramFrSXVuM05xWmFKdkFMUWNoeFppREtC?=
 =?utf-8?Q?WG4JzFu6NuXvK5BOf+K5I9CET?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 921bbcd9-55e3-49c6-0e02-08db7f4ae5a0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2023 00:33:06.2341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BArWkqyaDs+WXHcC2IAl6cUb8MptO3dDRbPBd6Yxqr/3tc8kMq4XeuHZ49azUzpp7PKHA/i3ivvpu4sBW+mkxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6429
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 7/7/23 15:17, Alison Schofield wrote:
> On Fri, Jul 07, 2023 at 09:16:16AM -0700, Breno Leitao wrote:
>> Kfence is detecting a user-after-free in the CXL, when cxl_decoder_add()
>> fails. Kfence drops this message, after the following:
>>
>>    BUG: KFENCE: use-after-free read in resource_string
>>
>> This is happening in cxl_parse_cfmws(), and here is a simplified flow
>> that is coming from Kfence.
>>
>> Use-after-free:
>> 	_dev_err
>> 	cxl_parse_cfmws
>> 	acpi_table_parse_entries_array
>> 	acpi_table_parse_cedt
>> 	cxl_acpi_probe
>>
>> Free:
>> 	cxl_decoder_release
>> 	device_release
>> 	kobject_put
>> 	cxl_parse_cfmws
>> 	acpi_table_parse_entries_array
>> 	acpi_table_parse_cedt
>> 	cxl_acpi_probe
>>
>> Alloc:
>> 	cxl_decoder_alloc
>> 	cxl_parse_cfmws
>> 	acpi_table_parse_entries_array
>> 	acpi_table_parse_cedt
>> 	cxl_acpi_probe
>> 	platform_probe
>>
>>  From my reading of the issue, the device struct being used by
>> dev_err() was removed in the put_device() before.
> 
> Hi Breno,
> 
> I'm not familiar w kfence, but I don't follow what it finds
> suspect here. Does kfence point to exact offensive lines of
> code, or ???
> 
> The put_device() removed &cxld->dev and the dev_err() that
> this patch moves the put after, was using 'dev', which was
> assigned from ctx.dev. It is not the same as &cxld->dev. I
> wonder if Kfence thinks we can get to the next dev_dbg()
> statement and misuse &cxld->dev.
> 
> More below...
> 
> 
>>
>> Put the device just after the message is printed.
>>
>> Signed-off-by: Breno Leitao <leitao@debian.org>
>> ---
>>   drivers/cxl/acpi.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
>> index 658e6b84a769..5179bf4211d8 100644
>> --- a/drivers/cxl/acpi.c
>> +++ b/drivers/cxl/acpi.c
>> @@ -291,14 +291,13 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>>   	}
>>   	rc = cxl_decoder_add(cxld, target_map);
>>   err_xormap:
>> -	if (rc)
>> -		put_device(&cxld->dev);
>> -	else
>> -		rc = cxl_decoder_autoremove(dev, cxld);
>>   	if (rc) {
>>   		dev_err(dev, "Failed to add decode range [%#llx - %#llx]\n",
>>   			cxld->hpa_range.start, cxld->hpa_range.end);
>> +		put_device(&cxld->dev);
>>   		return 0;
>> +	} else {
>> +		rc = cxl_decoder_autoremove(dev, cxld);
>>   	}
>>   	dev_dbg(dev, "add: %s node: %d range [%#llx - %#llx]\n",
>>   		dev_name(&cxld->dev),
>> -- 
>> 2.34.1
>>
> 
> (pulled in fresh code snippet to get the dev_dbg() in view.)
> 
>> 	}
>> 	rc = cxl_decoder_add(cxld, target_map);
>> err_xormap:
>> 	if (rc)
>> 		put_device(&cxld->dev);
>>
> 
> This puts &cxld->dev, not dev.
> 
>>
>> 	else
>> 		rc = cxl_decoder_autoremove(dev, cxld);
>> 	if (rc) {
>> 		dev_err(dev, "Failed to add decode range [%#llx - %#llx]\n",
>> 			cxld->hpa_range.start, cxld->hpa_range.end);
>> 		return 0;
> 
> This return avoids getting to the next dev_dbg() statement after
> put_device(). We cannot get to the next dev_dbg() statement when
> rc is non zero, but it seems kfence thinks we can.
> 
>> 	}
>> 	dev_dbg(dev, "add: %s node: %d range [%#llx - %#llx]\n",
>> 		dev_name(&cxld->dev),
> 
> If we could get here, after the put_device(), that would be bad.
> 
>> 		phys_to_target_node(cxld->hpa_range.start),
>> 		cxld->hpa_range.start, cxld->hpa_range.end);
>>
>> 	return 0;
> 

Seems like the code can be cleaned up this way. The double check of if 
(rc) is kinda weird anyhow.

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 7e1765b09e04..0573b476d29c 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -291,21 +291,21 @@ static int cxl_parse_cfmws(union 
acpi_subtable_headers *header, void *arg,
         }
         rc = cxl_decoder_add(cxld, target_map);
  err_xormap:
-       if (rc)
-               put_device(&cxld->dev);
-       else
-               rc = cxl_decoder_autoremove(dev, cxld);
         if (rc) {
                 dev_err(dev, "Failed to add decode range [%#llx - 
%#llx]\n",
                         cxld->hpa_range.start, cxld->hpa_range.end);
-               return 0;
+               put_device(&cxld->dev);
+               return rc;
         }
+
+       rc = cxl_decoder_autoremove(dev, cxld);
+
         dev_dbg(dev, "add: %s node: %d range [%#llx - %#llx]\n",
                 dev_name(&cxld->dev),
                 phys_to_target_node(cxld->hpa_range.start),
                 cxld->hpa_range.start, cxld->hpa_range.end);

-       return 0;
+       return rc;

  err_insert:
         kfree(res->name);
