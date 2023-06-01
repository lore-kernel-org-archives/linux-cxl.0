Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E808C7EE23
	for <linux-cxl@archiver.kernel.org>; Thu,  1 Jun 2023 17:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbjFAROF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 1 Jun 2023 13:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbjFAROD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 1 Jun 2023 13:14:03 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33636D1
        for <linux-cxl@vger.kernel.org>; Thu,  1 Jun 2023 10:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685639642; x=1717175642;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gwEkhls0eIxXc61AIk5fntHwpHEsu3RsPR+IZTG5pC8=;
  b=LFESHQxp6cGndRPP1AWUQwfSoB3xN1R2MYSfsXIvymW2U8SmPcqEQhEZ
   xMRQw/PSD/UOxvn2Byh5hYyh4+mjboQ01DSbKbNnkst11bMw7j3YBrOla
   QzECmPJI8uXKWi3u+1quqWhHoE7GhKzxkoLECvkLrMLvQRbbF4QZ1zDzT
   niLB5CRlt0FvS9PvLGRuRdLjUu/PM+yj2p2Qnd0NXLhJXLczJGjehxAwf
   KsFJCyD56jHPdtCCv3f4jRlqzEfURyODXlVuMRbCUI00f+dsRWMyEMN6g
   WaJCEZpmqdFLBOximYT+gt9ZVzS1Qyu++AZlK9oJzpRWtv0UMcJuNBXjq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="358921264"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="358921264"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 10:13:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="657874024"
X-IronPort-AV: E=Sophos;i="6.00,210,1681196400"; 
   d="scan'208";a="657874024"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 01 Jun 2023 10:13:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 1 Jun 2023 10:13:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 1 Jun 2023 10:13:33 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 1 Jun 2023 10:13:33 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 1 Jun 2023 10:13:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLTwwUEz0wswdPW5MgovuuuIGQZEyYtAohshuWsBBzUlh/oLIq/MwBAFFKyfU9DoQpoSC6QIX/2i7OWoO5VLM2GmYRmNN5dcf3HfnfwLP2kM3Y6jEsaNVAFfytYXXvMTXeb9tBPaCgtTqPv8mB6GZJAS3DBFvphg5q0q84KBPAVSSfkWUKI0Zhb9b7PUyj3rnvWyAbzvPGNPs3KB8DLq2e1B9ND3J9Vr9eNE7j9gEDCdiqdVSXS54I9OaIKIJNSKWIHtf9Utjo7sQwwIgrwJ7/5eAl0er85vEGS4KyHPatt2ikug9p8UKvaU9EKYN1ggPQGqOXXTv+EadyRSTyTmHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QAXdRsywzJqgTNTcjoKKSakkfJz0wgZYJqHB3jBdjXc=;
 b=WjEKRxfi+k/f+YFgv/7B/VnNIWTOeFIzQizF67FeF0PW5dSCCXFUDvQ/NUa279SloRP9JgEt9lWTJc7LTnbqhGtoNGcAmqnXZZn49/egHn2TfmwX6c/BfYqTJiPFdarlL5f9nPtT0GdEFwxSgCC5Qa2tNhqkZtkAG96MnMPr37c2qvk2bJ47eQ7DtN9+emIMcfws/8Dptc11z5d798ekZWMF6zOPMwS7Tc0DTBa/SDEpZ1VCIlIVqimUGIjjUyavSxtO7rCqs6TVgxtC8Wz3xzswj7gvBY4c4ndR7EE8d2r0brK6uO17xpsBxBf2G+XD9+XoPuB8JNGXv2SlkteJaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DM8PR11MB5638.namprd11.prod.outlook.com (2603:10b6:8:27::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Thu, 1 Jun
 2023 17:13:31 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6b5e:ef4b:bd3:36d2]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6b5e:ef4b:bd3:36d2%4]) with mapi id 15.20.6433.022; Thu, 1 Jun 2023
 17:13:31 +0000
Message-ID: <8081b4a3-8c86-5b6b-e972-a09eb98367c2@intel.com>
Date:   Thu, 1 Jun 2023 10:13:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Subject: Re: [PATCH v6 10/11] cxl: Export sysfs attributes for memory device
 QoS class
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>
References: <168451588868.3470703.3527256859632103687.stgit@djiang5-mobl3>
 <168451605449.3470703.14744276101463857790.stgit@djiang5-mobl3>
 <20230601153021.000022bd@Huawei.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230601153021.000022bd@Huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR04CA0001.namprd04.prod.outlook.com
 (2603:10b6:a03:40::14) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DM8PR11MB5638:EE_
X-MS-Office365-Filtering-Correlation-Id: 975ed923-1ecb-4f41-dd47-08db62c385bf
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Er+jKrjpKz4vgq+JFGPyjk2qSFU5UjyfKyywRQ5LFhm+hmP3XFizUmw61xhGWlcVUtUR/Yr6E0L5rJ4xVfWCQXSaIPdytP6hVuF/lH79nHg3xygYqrzIayDi6XQAnjCT5YODWMIA+EFkwcZcIkqQzTbwTb/vw3u3n8ieuesu9xyksUf+YLqRd7NUCiYJ3lXwiMo8ui+3Lmsbt9GSjG0vQUSltZTTTbEIJhySMUsg010XJ7Y8ThsxHd2rtogSXyx23xhHk3d5rLoOLaEjcBDtkF5s+Tr13xu2hBhWtLLY8wt1vR0SkQ4GbYBcyBVFLzzr4KYOWyNhujmhM1eBr3126dp3g/5IbYRF6qEOuYLleujQ5D4EM1KAdT0AsEwwIjOTbDZGej5JU+uv7eCe4DAlkTVjhb0CPhB4KOv2ee3T3ioAssSVxHlco6o7ZgmRGz5v8yvPmflNm44Lyg5wRm/Z5TxF+wpjOy6/eJOItriPRmFEbsBQtpSQRYaO/nlADLmcocZS1CBz5V1+KuHKfGtleyqqgNNo+J8iVBGuKAuKNprUrVIWaKKw2wCJdViDTPr/tmkltaUGVhBxOilEKCpPCHONLonUN4QEeoCH2GFKAQKlmCGoxXJ9kfmJwkUhw0raL8H6TB9PG+AmRmj78R0rYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(136003)(366004)(396003)(346002)(451199021)(44832011)(6916009)(66946007)(66476007)(66556008)(31686004)(41300700001)(316002)(4326008)(8936002)(5660300002)(2906002)(8676002)(966005)(6486002)(6666004)(478600001)(82960400001)(107886003)(6506007)(26005)(186003)(36756003)(53546011)(83380400001)(2616005)(86362001)(6512007)(38100700002)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVJJSVpZYzBwQ3VseDVVcTZhNHFUNWY2Q1pVSWxHN0EvdmR3UHhyajlzZnht?=
 =?utf-8?B?RXo4cUk2UlA3U3JKOVV6WW1wQnhRbWRpbWROSmVFQVNFWGZEUG03b0RHaXhh?=
 =?utf-8?B?eklkR0xoWXoxbjUxcTI4SDJVbVlzdjZvbjd5VGNjc0ZncytCSHZJaUZFWlJt?=
 =?utf-8?B?RFJiQzBkWDVGdENrVG10VjlBd2docWxUUGw5bWlRVVhjM1VNR1JDZmx6VUVi?=
 =?utf-8?B?QmJoOTN3NDJqK2J4S0txY1BQc3RzT0VJT2krWjk5UGVmV1NRc3ZNVUwvZEFt?=
 =?utf-8?B?VmJCdWxkSVVOM0NXb2ttL1UvdTJKRUlmNW16NEZPSklUcEhPK3NWUy9tN01t?=
 =?utf-8?B?WlF0Z1ZnVk1HWWQxMExBQTFPQVRxS1U0R05pLzN5blpXS00reGJTME8vbDV6?=
 =?utf-8?B?eE41UUF3d1h1R2RDY1ZkNjlXOFV4YkFId1AxbExHTHZtdksxTnFNK2ZrKytp?=
 =?utf-8?B?U1JEMGFDWlUzdzYxZGlOVElJYjBnR1h2eFNyeDdscW9JZFlERXVRcjV3bWZR?=
 =?utf-8?B?dXN1TTBCaDVnVlFSaFZ4L3RBRU5RVDh1MUpMNk9pRG0zbnR3c0JEYy9PNkMv?=
 =?utf-8?B?RUphSDBpcXdHS1pEWDNKV0ZtM0lzczBKa1RsbXRhTEFKMWp3Y24yeG96S1lT?=
 =?utf-8?B?aHlPekFzMFpUSTREcXJiZ0NYUDFxcjNqdU5BVUdNNVFZbG1KK1lrQ3NtSTE0?=
 =?utf-8?B?MlIwVi90UTVIb2piZ041czRUdXRpME1yanl2ZzE4ZnZmOFdEUWdtUFpLVTA4?=
 =?utf-8?B?QnVoamVBWklBaklrb3FuamxHby9WbCs1Y243a1p0cVp1R2x0TUNZWGJic2U1?=
 =?utf-8?B?S0VJNGVZOU1MZGRBdVYrUi9jRE5sRmtJUS84QUdIZmRsNU0zSHVWOVlWdSs4?=
 =?utf-8?B?YVQ3Y2xEMVhFUFlVSWF4Q05nV25TelRsSjZleXkrZ0w5UWFrVGliNWk1NXN4?=
 =?utf-8?B?T3UxYjc5b3lYZHZUcFRRUDBpMGJ2azI2andCbjdmSEFCMzdyQkdweUREVkVw?=
 =?utf-8?B?TVFFbjFSL0IwemRZSVZ5WWNMNDNPZisxWGk5TmRDVG1uOGQ3K1lnOGJmQTFw?=
 =?utf-8?B?ZWU2Q1Noak9lalpaYU9jalp5TVVVWHo5NC9Od2p5eTBwSU9JNHNVdDZuTFpa?=
 =?utf-8?B?RmJMVTA0THFRenpYK3RxVitEM1RzMXU0UlhkSE56dm5NcFdLVGFxYUQwVVA3?=
 =?utf-8?B?R3JhNVNoVzFsQVJnb3plY0RuUUxDcS9OODMvd2ZjalU1c3hORnNGSUtVTTZm?=
 =?utf-8?B?amRRTFZkbHZWL1ZHN3NON2JlSFdjaFI3bHA5UVdkTnBqWEs4cTJQQ3E0MVJP?=
 =?utf-8?B?VFVvSUNXblMreC8zWjZoVGU0a3NJL0p6WitIbGhYbFpZSWJPc0NJcDU1MFhJ?=
 =?utf-8?B?K2VMMEVEVU9XYWJTcFc5RlNvcmZwRHIwekxZamVTQ0lYelJ5bWx2SnFJc1pm?=
 =?utf-8?B?ZWF2aGxJK2ZkSENXdTlGcFlnL1o4TDJyRWJsNW0zOW13aFhmZnc0aWF5T2Rz?=
 =?utf-8?B?QU11b21oZEVWTjFSdlJaWm8vL0JoTXZCQTNqcUNDRDRqeTFHNUJpT3d1ZUdX?=
 =?utf-8?B?TnVkUzl0VWFJVys1VWF5eWdIWXE1Um55OTh5QUNXOE93Unc2dHlha0t0bzJy?=
 =?utf-8?B?THBhVjVTWVBNcGN6WkdISUFXamdBOWtCM1VpSFQyeU5KdGRRb3JZdGhONXRp?=
 =?utf-8?B?Z1Yza1YyMGRVYUVDZkFyWFVRZkw5YWVNd09tOEd0ZUpiTHRLSmlyYVZUNHdw?=
 =?utf-8?B?Y2ZEeW9sRFdwaThLQ0VIUUQvdjdMd3VSYW56ckZjTTVZeU9JbkNJTSs1b2s2?=
 =?utf-8?B?TGxDeWZiWmJWM2Fna1U5R3o2Q0JtVjZWcjRNYnFWMm9xZllMOFJDU3dlc3ZK?=
 =?utf-8?B?U1BOYnhFbVEzaWNoOUt3cjVoelVvNHF1aWV2UXBHSFoyRVU2V0N1eWE4cEJh?=
 =?utf-8?B?Y0NzZkVMTzI1aUFJMktIR01xdS85Y2l2eWdMcXZqd1A5Y3NocDZ1NmRUR2d1?=
 =?utf-8?B?N2dSUjkralErVWs4em9rcE5HazNBZW9wTlNrZkcrL2JPUmJ6VDhJbng4NXlv?=
 =?utf-8?B?UStOeTM2aXhtUWs3K1laR29jOW5tcC9yMlFUK0UzU1dUNzJFWTZuUUZyeSta?=
 =?utf-8?Q?xo/2md/89SbyVpt5nmSSDI4V8?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 975ed923-1ecb-4f41-dd47-08db62c385bf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 17:13:30.7468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fq3GciZELRR1lZf2E3ZN3UPc06jqu00Ra0vFTGqHjkxCz+lVNdnCQ+RXVXGfaA1/opYXfWist4KRhyPT3n9b3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5638
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


On 6/1/23 07:30, Jonathan Cameron wrote:
> On Fri, 19 May 2023 10:07:34 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
>
>> Export qos_class sysfs attributes for the CXL memory device. The QoS clas
>> should show up as /sys/bus/cxl/devices/memX/ram/qos_class for the volatile
>> partition and /sys/bus/cxl/devices/memX/pmem/qos_class for the persistent
>> partition. The QTG ID is retrieved via _DSM after supplying the
>> calculated bandwidth and latency for the entire CXL path from device to
>> the CPU. This ID is used to match up to the root decoder QoS class to
>> determine which CFMWS the memory range of a hotplugged CXL mem device
>> should be assigned under.
>>
>> While there may be multiple DSMAS exported by the device CDAT, the driver
>> will only expose the first QTG ID per partition in sysfs for now. In the
>> future when multiple QTG IDs are necessary, they can be exposed. [1]
>>
>> [1]: https://lore.kernel.org/linux-cxl/167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local/T/#md2a47b1ead3e1ba08f50eab29a4af1aed1d215ab
>>
>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> A few minor suggestions inline.
> In particular some code duplication that looks easy to avoid.
>
> Jonathan
>
>> ---
>> v6:
>> - Provide full ordered QTG IDs from _DSM. (Jonathan)
>> v5:
>> - Change qtg_id to qos_class
>> v4:
>> - Change kernel version for documentation to v6.5
>> v3:
>> - Expand description of qtg_id. (Alison)
>> ---
>>   Documentation/ABI/testing/sysfs-bus-cxl |   34 +++++++++++++++++++
>>   drivers/cxl/core/memdev.c               |   55 +++++++++++++++++++++++++++++++
>>   2 files changed, 89 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
>> index ccfc7ecc61f5..7a4cacd382f9 100644
>> --- a/Documentation/ABI/testing/sysfs-bus-cxl
>> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
>> @@ -28,6 +28,23 @@ Description:
>>   		Payload in the CXL-2.0 specification.
>>   
>>   
>> +What:		/sys/bus/cxl/devices/memX/ram/qos_class
>> +Date:		May, 2023
>> +KernelVersion:	v6.5
>> +Contact:	linux-cxl@vger.kernel.org
>> +Description:
>> +		(RO) For CXL host platforms that support "QoS Telemmetry"
>> +		this attribute conveys a comma delimited list of platform
>> +		specific cookies that identifies a QoS performance class
>> +		for the volatile partition of the CXL mem device. These
>> +		class-ids can be compared against a similar "qos_class"
>> +		published for a root decoder. While it is not required
>> +		that the endpoints map their local memory-class to a
>> +		matching platform class, mismatches are not recommended
>> +		and there are platform specific side-effects that may
>> +		result.
> That sounds scary - perhaps "platform specific performance related
> side-effects that may result."

Ok will update


>> +
>> +
>>   What:		/sys/bus/cxl/devices/memX/pmem/size
>>   Date:		December, 2020
>>   KernelVersion:	v5.12
>> @@ -38,6 +55,23 @@ Description:
>>   		Payload in the CXL-2.0 specification.
>>   
>>   
>> +What:		/sys/bus/cxl/devices/memX/pmem/qos_class
>> +Date:		May, 2023
>> +KernelVersion:	v6.5
>> +Contact:	linux-cxl@vger.kernel.org
>> +Description:
>> +		(RO) For CXL host platforms that support "QoS Telemmetry"
>> +		this attribute conveys a comma delimited list of platform
>> +		specific cookies that identifies a QoS performance class
>> +		for the persistent partition of the CXL mem device. These
>> +		class-ids can be compared against a similar "qos_class"
>> +		published for a root decoder. While it is not required
>> +		that the endpoints map their local memory-class to a
>> +		matching platform class, mismatches are not recommended
>> +		and there are platform specific side-effects that may
>> +		result.
>> +
>> +
>>   What:		/sys/bus/cxl/devices/memX/serial
>>   Date:		January, 2022
>>   KernelVersion:	v5.18
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index 057a43267290..9366257e3183 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -77,6 +77,32 @@ static ssize_t ram_size_show(struct device *dev, struct device_attribute *attr,
>>   static struct device_attribute dev_attr_ram_size =
>>   	__ATTR(size, 0444, ram_size_show, NULL);
>>   
>> +static ssize_t ram_qos_class_show(struct device *dev,
>> +				  struct device_attribute *attr, char *buf)
>> +{
>> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>> +	struct qos_class *qos_class = cxlds->ram_qos_class;
>> +	int count, i;
>> +
>> +	if (!qos_class)
>> +		return 0;
>> +
>> +	for (i = 0, count = 0; i < qos_class->nr; i++) {
>> +		count += sysfs_emit_at(buf, count, "%d",
>> +				       qos_class->entries[i]);
>> +		if (i + 1 == qos_class->nr)
>> +			count += sysfs_emit_at(buf, count, "\n");
>> +		else
>> +			count += sysfs_emit_at(buf, count, ", ");
>> +	}
>> +
>> +	return count;
>> +}
>> +
>> +static struct device_attribute dev_attr_ram_qos_class =
>> +	__ATTR(qos_class, 0444, ram_qos_class_show, NULL);
>> +
>>   static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
>>   			      char *buf)
>>   {
>> @@ -90,6 +116,33 @@ static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
>>   static struct device_attribute dev_attr_pmem_size =
>>   	__ATTR(size, 0444, pmem_size_show, NULL);
>>   
>> +static ssize_t pmem_qos_class_show(struct device *dev,
>> +				   struct device_attribute *attr, char *buf)
>> +{
>> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>> +	struct qos_class *qos_class = cxlds->pmem_qos_class;
>> +	int count, i;
>> +
>> +	if (!qos_class)
>> +		return 0;
>> +
>> +	for (i = 0, count = 0; i < qos_class->nr; i++) {
>> +		count += sysfs_emit_at(buf, count, "%d",
>> +				       qos_class->entries[i]);
>> +
>> +		if (i + 1 == qos_class->nr)
>> +			count += sysfs_emit_at(buf, count, "\n");
>> +		else
>> +			count += sysfs_emit_at(buf, count, ", ");
>> +	}
> Bunch of shred code here with the volatile case.
> Add a little utility function to avoid that?

ok


>> +
>> +	return count;
>> +}
>> +
>> +static struct device_attribute dev_attr_pmem_qos_class =
>> +	__ATTR(qos_class, 0444, pmem_qos_class_show, NULL);
>> +
>>   static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
>>   			   char *buf)
>>   {
>> @@ -344,11 +397,13 @@ static struct attribute *cxl_memdev_attributes[] = {
>>   
>>   static struct attribute *cxl_memdev_pmem_attributes[] = {
>>   	&dev_attr_pmem_size.attr,
>> +	&dev_attr_pmem_qos_class.attr,
>>   	NULL,
>>   };
>>   
>>   static struct attribute *cxl_memdev_ram_attributes[] = {
>>   	&dev_attr_ram_size.attr,
>> +	&dev_attr_ram_qos_class.attr,
>>   	NULL,
>>   };
>>   
>>
>>
