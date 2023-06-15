Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0341FEB64DA
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jun 2023 15:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345004AbjFOPuk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Jun 2023 11:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345025AbjFOPuH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Jun 2023 11:50:07 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F64296C
        for <linux-cxl@vger.kernel.org>; Thu, 15 Jun 2023 08:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686844204; x=1718380204;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=8HL3xBVurtI210EWEnnfrvUhVbCJIBOS662bHkfefWI=;
  b=NhHCld3g6T1p1ErHleWQ/JhD/f8nksK2moqxiXiHimkvYVhd4/8BSz2T
   E8lm9wAtD3W4gV2QNkCq/nh7hFvhnQw0M7xvUvSlyUOTIPUIZeNrkYTtl
   9muoB4R/nPB//eamsJZhyWBtru+TIMCQwKikJYiboPgKtWPTaj7/eLq2i
   QFhXSI3IiIst8I89eAcIbFhKzwUPNVCK/Sj7preVetHLdEBvCvARRkRNV
   UWg/zbmdJVc8mX5aJDNjXbP9j7gshfK1kb3zyOz6SZ7nUZg1Tu+wxFgPi
   o+gTXsOX5avZ/RIzFWhdYd13KNPMwX+tICQGX3zdvFtWiR4SaF5wG1XNS
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="361459399"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="361459399"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 08:41:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="959254778"
X-IronPort-AV: E=Sophos;i="6.00,245,1681196400"; 
   d="scan'208";a="959254778"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 15 Jun 2023 08:41:23 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 08:41:23 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 08:41:23 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 08:41:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MupovCFnXdxQpBuQrB3xvdfZ3vp1zFIiSCBdpLZpLcVFXpV9SJQqRAXNSYjJYilnbWDKmoQ6IVvJfPwWPyGW5hk0oD9BsiYIDta9Xg4oJkAJk3ZqjVS2Y5ldYG3bAdIFB9p6Okk6Qlq6euNTvmPWt8q3S4bC1DrcLbQKL0z2ROxdY26763g/EZCQ3TgOzx8BeI1+RU5gov7KpDEEoYob3VE42/2tTpr3zt5KtdDbzron8HzxckK8ckia2rfarsVKS7sPKjXwZ55DoiIIR+pFm81402yPuL6IBTcLU66GXIF0JlaIAZZdRzNe1I8Ov0tU+0eVO6KwdAOB8U6n38OwBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=muo5tipuOZkW8ZH402HU73v6TbgRLrZ1emTcp7EqfWM=;
 b=eHrzBsAK+aeJuz2jXczJgpU5k/loX8Xs+52lyY7QvB2aAw1fL++KnZnvvde+7DxCjUdsfXQ527nzjq49H+aZUWQRZDvZA3VGSJ9kgnom2AOuaArCN/OBXMA7tqeaLsbXlQj6+NO3UalQxf8HhpLIMiYyAU0WB0OExZC0YOmMM7DqAUbbDW0oY9aI5pmtfba8NbJtsaTHD/2Bew8RMagYK3WucJRZRypqk83eor3eWHy1O+M3IcUdHALJHs/nB8ATA/VTJazig+1xAmVBlNtDB5hhBBBS2B3s8avhbL6FPR+zZIhLzIoWSyQstZnTiRqTTTjWGLGOs24Akj+FQIQVTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by PH8PR11MB6684.namprd11.prod.outlook.com (2603:10b6:510:1c7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.25; Thu, 15 Jun
 2023 15:41:21 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6500.025; Thu, 15 Jun 2023
 15:41:21 +0000
Message-ID: <10d6bd64-8afe-7d03-2edc-08a6378a77e3@intel.com>
Date:   Thu, 15 Jun 2023 08:41:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.1
Subject: Re: [PATCH 3/5] cxl/mem : Expose dynamic capacity configuration to
 userspace
To:     <ira.weiny@intel.com>, Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
References: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
 <20230604-dcd-type2-upstream-v1-3-71b6341bae54@intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230604-dcd-type2-upstream-v1-3-71b6341bae54@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0071.namprd05.prod.outlook.com
 (2603:10b6:a03:332::16) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|PH8PR11MB6684:EE_
X-MS-Office365-Filtering-Correlation-Id: d1bc7c22-1945-4569-e62b-08db6db6f752
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ra8T4K3knkD5OiXSiiRUnShoYP9Imgi6B8LlHQzZRDPPMxNY5FLp645tanUsDv1796k6nwDBclxTCd8BY2t7f53Uvm8DaUvWl4vJn2HALR4Jzw5mXtjhr2mYA4pI8Xz3O194dM69wMLZC6YOFNXpJgfb4FiWGy1AYuPesGjkVZLtF2hbnveeSYkOWcfjw0uh86uwaWmyXy1iQMV6sXKAuSmjE9ccaTDgq7swKzNHt1Dp3j8xG9bS9ijhSK2al9U64sg6O4Y6fRJ73uflns4j94xTukFfRSQL83fjvjz7m7RLhCLPwjNV7eru77xd+bDzlYxNVYtf6sR/sjtKJiy4mSYLdghVcj4J7ij3xgIFhhn9KPJz9i1EOKWp05prN2uytOjilp3p3JM4m6NsRaLDoy61V4DRg50Sj5oy6GzGLD85+PAvheLs08e0CbL5Tbrha/8XoJbFecMSqY9U5xae10HdpHNy95I7Xe0eQZstG1pxY8vHOOuP4aLWPksUObBJzCey2FvqNR3freVeQxwZXtwYZeU+hZ4uiesfJ+1L6i/RQzCJqLPvQ0iejyg2N4ynpgIBaOr6R4YcuBfALdWrHK64Jb9sKc3TFpdQcX1dY4O8pCsl3T7egNG7elRUuyoFfQCRvBgKdr8Wmc7MbmYxMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(366004)(396003)(39860400002)(346002)(451199021)(5660300002)(82960400001)(38100700002)(2616005)(53546011)(6506007)(186003)(2906002)(26005)(6512007)(44832011)(478600001)(66556008)(66946007)(66476007)(316002)(6666004)(8936002)(6486002)(8676002)(41300700001)(86362001)(31696002)(36756003)(31686004)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WEJDeWZHMnc4YmljcXd0Z2x1eXlORTVaOUduZnlNdnQwaVUra0E5NmxtUnZi?=
 =?utf-8?B?cHhaT1ZRNVFKNW9SWnFMVGE0TWNndWEwZ1B1THJ6V01EYXVpTEVDWDdvUHg5?=
 =?utf-8?B?dHZUTmQxREdRcHExelVoR1I0Nks2Zk1McldsaC9KTHFyMW50czUrRGwrblhK?=
 =?utf-8?B?SFdmYTRnMzJvc05ad0hNbjRKbG4wVkpaN21ZS0wzUVRHQjFWOXVPWDZJLzdv?=
 =?utf-8?B?Qm5uNU1OVWw3ZGI3UE9yY3ZkdU1OWEFiVzlJckxHRERna1hIZ05xbUxSdHNP?=
 =?utf-8?B?RUdBZTUxVjFrbmlLdzlnYUVwU0Q2UDhmeEdPS09TQ2JqaVpqMTM0eDZrK2Yw?=
 =?utf-8?B?ZkZoT3hjNXNNU0FxZEhrZStoZ0Vldzlmc0R1UUFhcnZEMXVrK0pCT1hqb0F4?=
 =?utf-8?B?UkdCM0RtbE9yeUpiTWxRSWRxTWZCTy9YQW5tTUErSjdqaVZvU2lFNUVMSmRQ?=
 =?utf-8?B?a1BJci9Yd25ZM1JncVVwNDg4bGZ6RmExSHRtMEVabVFDRVlmYW92OVRZSFNY?=
 =?utf-8?B?NUNnNUZuYWxQNnlJOUFYcWRkcnhPM0I5ZVNIMW1OZm5oNjBxb3M1T1BXT3Ns?=
 =?utf-8?B?RTlKbDZMS25Ea1IzVzNYZHo0cFhEb0N3R3N2WHRualg1TlJ4RzB2YjJhSkNm?=
 =?utf-8?B?dnljREMyOXhoNmhiSEhCaGdXMXAwUGZnajNQUzZ5QWd6YUNHRHY4aWhvMDhv?=
 =?utf-8?B?b2dJbGNNb3g5M3Y4VGlNQUpNT2J2cnFsNjBCdHV6ODhzL1phOURtSHVuMXpY?=
 =?utf-8?B?YkZEY1JRdHdPbklyT2hZVEVQVGR2ZVJkQkMxb0tNaWhJL2xQUTNsRDZ1MjNh?=
 =?utf-8?B?YnM0czFUZnd3MTAzc2tlcjhFTVVxQUMvQi9DRGYvYWF1SGJmY25EbzAvU3F0?=
 =?utf-8?B?NUFxSHIxVXhHbW5hK05ydEtwK1pObkRYWkROOGtmU29WKytlUEpPSXFaR2lq?=
 =?utf-8?B?blBUWFBJaEdXV0pQcCtUQnF1L1hWbEM0dVQ5R0NRa0U2MWtyTUtnbGtFdzNX?=
 =?utf-8?B?ZHBScTRncjZ3YThvVWEwemE5d3pMTEJzNjdKditkM3JxNUxreWVNUEl5aXlI?=
 =?utf-8?B?R1UyRlQ4b2EzNmVVRCtGUDdOY1hZbUI5a3I0cnZhcUtNZWpkcGdFQTMvZjRa?=
 =?utf-8?B?ZE5rL2NOU2YwSG5hOXpmRmQzTUtGcUlvM29wQXhZVFhlVEJnNFJkUTRpaUFQ?=
 =?utf-8?B?SDJ1b0xFRjFMTDNEOXQ4aVNySHhNdW1XWjJXSzIxaFBzVjZCeWZWa1ZsRGI1?=
 =?utf-8?B?QUR5ai9zMnJHcyt2a0VwYTZqUXlqY3c2cm1HZVNJUTFoandJZk1zSGU0MS9P?=
 =?utf-8?B?dERRd0VYaE5JSFdpS2JaQ0hQNUJINHZ3cnBWbVZrdHlxRzVzRW9aY25XTlpN?=
 =?utf-8?B?VHRzL2xxMElJRG9wUUE4R3daZU1KVU95KzgvMHU0VE1lTUJwVEdDZUo2Mk02?=
 =?utf-8?B?TEhWOHNrVjhZb0RnT1dPQS9TelBLNkxHdkZUUW1YbVZySzMzMDZxTjJiNHZM?=
 =?utf-8?B?NmYxKy92RWNFTk1yRUFNNW5oekxuYWo1S1VHWjcvNE9GazY2LzdYaHlmdGFT?=
 =?utf-8?B?anV6OFJ4QUJlU3lBNkhYWSswSC9QZ2pnM1c1cTNRR0JGbGlmTjhvcjkyZ0kx?=
 =?utf-8?B?WkpORW9xVmtScUFnNVlOQW05dzdVRURNTHdGMFdxOTkzWTdYWk1CcU5tMVJN?=
 =?utf-8?B?aFZib0dhSDZXK0QyQm5DOTh1NC9OM0NKdGtDMjRhenhENlFneGtpOXgwUXdN?=
 =?utf-8?B?QUxqaU5uaTdOYVloaEQ0MjhoTmdFM2dRbXl0QTV6T0lHMGJ5Tk90WUJBa1Rn?=
 =?utf-8?B?MXlIb20vZjlrbm9oaWN4NUxoaS9FUHJuVkg5eUkvWE1HT1pibytpMHNkY01I?=
 =?utf-8?B?dVBzYStGcXpIdlRWRjNJR1I0WFZHT1VOai9Oa2dxUHZWOHJXLzNHTVJzM1R2?=
 =?utf-8?B?bzg1Q3pVR1VjVCtFN2o5VTQvdzZOV0VIck5YaE1zV3NZaVRqOXFFWGJGMUt0?=
 =?utf-8?B?SlQ3WUZqTEdvbFROd2Z3Tzc2QzQ3ei9Fa0lwT1B5UkpGM1huZ0ZqQXppaW43?=
 =?utf-8?B?OEhDcTVRNU1ZVTN4U0xsa0hTWFZsOHpKRzQ2aENHUjU2a2FXM0NSTi9KcEZp?=
 =?utf-8?Q?9oBAGJVyPu24ZMV4HDcI5+yF+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d1bc7c22-1945-4569-e62b-08db6db6f752
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 15:41:20.9848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VUUtsmnwzVPaHXalo26iKMSKZAM7Dl2fPg0wgD29Z/ORhGhdyrGcE/y4M0QAZAqyUcQ5LdXmyGv2E9D7ukXRrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6684
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 6/14/23 12:16, ira.weiny@intel.com wrote:
> From: Navneet Singh <navneet.singh@intel.com>
> 
> Exposing driver cached dynamic capacity configuration through sysfs
> attributes.User will create one or more dynamic capacity

Space after '.'

> cxl regions based on this information and map the dynamic capacity of
> the device into HDM ranges using one or more HDM decoders.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> 
> ---
> [iweiny: fixups]
> [djbw: fixups, no sign-off: preview only]
> ---
>   drivers/cxl/core/memdev.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 72 insertions(+)

Missing sysfs documentation?

> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 5d1ba7a72567..beeb5fa3a0aa 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -99,6 +99,20 @@ static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
>   static struct device_attribute dev_attr_pmem_size =
>   	__ATTR(size, 0444, pmem_size_show, NULL);
>   
> +static ssize_t dc_regions_count_show(struct device *dev, struct device_attribute *attr,
> +		char *buf)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +	int len = 0;
> +
> +	len = sysfs_emit(buf, "0x%x\n", mds->nr_dc_region);
> +	return len;
> +}

Just directly return sysfs_emit(). Also, emit region count as decimal 
instead of hex?

> +
> +struct device_attribute dev_attr_dc_regions_count =
> +	__ATTR(dc_regions_count, 0444, dc_regions_count_show, NULL);
> +
>   static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
>   			   char *buf)
>   {
> @@ -362,6 +376,57 @@ static struct attribute *cxl_memdev_ram_attributes[] = {
>   	NULL,
>   };
>   
> +static ssize_t show_size_regionN(struct cxl_memdev *cxlmd, char *buf, int pos)
> +{
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +
> +	return sysfs_emit(buf, "0x%llx\n", mds->dc_region[pos].decode_len);
> +}

Should size be in decimal format?

DJ

> +
> +#define SIZE_ATTR_RO(n)                                              \
> +static ssize_t dc##n##_size_show(                                       \
> +	struct device *dev, struct device_attribute *attr, char *buf)  \
> +{                                                                      \
> +	return show_size_regionN(to_cxl_memdev(dev), buf, (n));             \
> +}                                                                      \
> +static DEVICE_ATTR_RO(dc##n##_size)
> +SIZE_ATTR_RO(0);
> +SIZE_ATTR_RO(1);
> +SIZE_ATTR_RO(2);
> +SIZE_ATTR_RO(3);
> +SIZE_ATTR_RO(4);
> +SIZE_ATTR_RO(5);
> +SIZE_ATTR_RO(6);
> +SIZE_ATTR_RO(7);
> +
> +static struct attribute *cxl_memdev_dc_attributes[] = {
> +	&dev_attr_dc0_size.attr,
> +	&dev_attr_dc1_size.attr,
> +	&dev_attr_dc2_size.attr,
> +	&dev_attr_dc3_size.attr,
> +	&dev_attr_dc4_size.attr,
> +	&dev_attr_dc5_size.attr,
> +	&dev_attr_dc6_size.attr,
> +	&dev_attr_dc7_size.attr,
> +	&dev_attr_dc_regions_count.attr,
> +	NULL,
> +};
> +
> +static umode_t cxl_dc_visible(struct kobject *kobj, struct attribute *a, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +
> +	if (a == &dev_attr_dc_regions_count.attr)
> +		return a->mode;
> +
> +	if (n < mds->nr_dc_region)
> +		return a->mode;
> +
> +	return 0;
> +}
> +
>   static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
>   				  int n)
>   {
> @@ -385,10 +450,17 @@ static struct attribute_group cxl_memdev_pmem_attribute_group = {
>   	.attrs = cxl_memdev_pmem_attributes,
>   };
>   
> +static struct attribute_group cxl_memdev_dc_attribute_group = {
> +	.name = "dc",
> +	.attrs = cxl_memdev_dc_attributes,
> +	.is_visible = cxl_dc_visible,
> +};
> +
>   static const struct attribute_group *cxl_memdev_attribute_groups[] = {
>   	&cxl_memdev_attribute_group,
>   	&cxl_memdev_ram_attribute_group,
>   	&cxl_memdev_pmem_attribute_group,
> +	&cxl_memdev_dc_attribute_group,
>   	NULL,
>   };
>   
> 
