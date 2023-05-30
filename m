Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD55C7EE23
	for <linux-cxl@archiver.kernel.org>; Tue, 30 May 2023 23:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbjE3Xgb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 30 May 2023 19:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjE3Xga (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 30 May 2023 19:36:30 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC1FAA
        for <linux-cxl@vger.kernel.org>; Tue, 30 May 2023 16:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685489789; x=1717025789;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=z24ifkaKtCfeijwmZQPYlmkSdPwpAw+t+oOQVvyxl0U=;
  b=Z7vlhu9VhgvDR07NXGtiXAiwGuiB3z1Ehi8tIhuZadT+/ZRg9gKayCAP
   UjDK9oRYbDuf0j8B5TzZbhv7o6vtrAY8v7wD94GUhAIXE/ZutnusDEzDz
   wSPtdKlpQSStMpuIPRhsEZmGK0Ly91llYiCOKTgFdwlMrBKdifbpaLnh1
   PKQn1/cpspR+L5euLh5OoT05cTLYmRYQS0l40OhLqId9F9PqZZN0c6aIS
   dzESB5Fr4dNnY21Y8UMwyg4Xat1VCIh/VrMqCsoKnMM63X/sTMEhBXpf8
   boykK8i5yxfbbup5smZLRkaYn9eB1E3SO4mnoUEEpSqmPZNS4K2soVroh
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="353919637"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="353919637"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 16:36:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="706638466"
X-IronPort-AV: E=Sophos;i="6.00,205,1681196400"; 
   d="scan'208";a="706638466"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 30 May 2023 16:36:28 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 16:36:27 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 30 May 2023 16:36:27 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 30 May 2023 16:36:27 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 30 May 2023 16:36:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eA5JGPFZS8Fon8CMGDQvLNe4MnjzUPjksNz7aVSlR69kgkiIRsJ6PdrJAUANm/BnrOSSZTvC6ml5AS4qgCNNMo5HlW8yIDei1sKFUozeR5EUIfOeWLEYQpF6ut9mCfLkRfRroUMqyVZa2cCsyl/q50AoJ93cOcVlxR+5gror2Pm3vgac/yr2Di/IB8cdHHesiftYdZZ3qLmc+ANh6i/bGv/uLwTvO8EZ8PES1XHh9f3kCT2WXt+k0R+k2Z3SP7B+o8sXgh8RsPqXXyfAFhLxBgxIjwDugjjD8fSuGvlNnp1ChDZZNTsZhZCjPRiV3KTC8MPY3Dnh+zFOIv2HnC758Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LoKl3HK4Qwg3776nF5EExjxI7A6YRsZJQ88ZP7ZWiI=;
 b=UkUm/4kzMO3i81a1Ks8WXsrEcU09IGlcFpNdLlvednpxHWQ2kUr8mLgSaJUIVt59ZMUk5eoatDuY2E/pxjUO5k5Dzqv4JcVZ8aa3RfAHpRg7ZnQAP+K+GOUeUt+69q/3IJ2g516WEjpnyBA2AX/O6pK9HPCRuQYAFINKLtQSahqE8Jwe/lDMBJDj5a9X/DYDDJAg7EBx0PVsslplSwfNpCUbeM8+AWwMOaRPJajoPhLHlZzzs5U/QhCeOPq2jmgc02Geb+d9nlWcdeAA73dcQWmWAlA8Hb5OSruGRB4yR/uDHBVjdvtq6Z8ahsZji3mCpPNfLF4dekHgBl2XNUVUMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by DM4PR11MB6043.namprd11.prod.outlook.com (2603:10b6:8:62::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.23; Tue, 30 May 2023 23:36:25 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6b5e:ef4b:bd3:36d2]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::6b5e:ef4b:bd3:36d2%4]) with mapi id 15.20.6433.022; Tue, 30 May 2023
 23:36:25 +0000
Message-ID: <25925dfa-d2ee-c9dc-90b8-875d2c74eed5@intel.com>
Date:   Tue, 30 May 2023 16:36:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Subject: Re: [PATCH 2/6] cxl/mbox: Add sanitation handling machinery
To:     Davidlohr Bueso <dave@stgolabs.net>, <dan.j.williams@intel.com>
CC:     <vishal.l.verma@intel.com>, <Jonathan.Cameron@huawei.com>,
        <fan.ni@samsung.com>, <a.manzanares@samsung.com>,
        <linux-cxl@vger.kernel.org>
References: <20230526033344.17167-1-dave@stgolabs.net>
 <20230526033344.17167-3-dave@stgolabs.net>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230526033344.17167-3-dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR06CA0032.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::45) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|DM4PR11MB6043:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a2e2c0c-511a-4309-fc5a-08db6166aedf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o8mRlgwS0v2WgW3IY76DT9ct++z+MNLgoRg6NwxcDrad62gENGTDcdH6mV7peQYPYYFzaCFyHNj8hW5BuTigcHGDtlDNL8J7UPT/IIqzaFvSiX+iOrWd2BHMTK8MtUC+u0qbZ/ztQrBBrFcU5VKPhh0/RZjhfVJ8/0Nh262d81ZIJCnGh0vxyndKXP3RT9eXHW3Qg34sdILZI0B7xLyfRLPQpM5PnwrjDQrY2uEZQ41/r+PAELtoLbmLZmMdfvhi9nxtTNm/uU7DlV42FfQHYjTUJsKUKaoysABzdDZ+ahQsOpiIBp3grDxCje0FZMMGnkYgawQr5iiRx9gVAABPktLM7xdBbXtJJpLWuJHP/pSU0fxwGhDYcc7hUB8pqnYlYtgzCeeu5/ARZQou/7khoZDKgNeyOYBNGkPfZ6v4Oz+CnWKgVUiqd38XTI6WGEWeTZOqYxeewaWbDN+0c5JHKgx/XeTmnY2577kR1Tv/pmde6wj6f5eHxdHnnkiodrl1sZGKLofaIDFZtrIQY76kJhd3p8JsuvUpJt2kUXdDrezLoFkceF3/1aHtYHeYxvhkR4WJ73nrE0WY5LU8ZCAHTF4vRFTgT1OTYirRWA/u3EBMsDJogQerYY059zQQduE1g3Y8/v3Sb2YMChOve6YX5g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199021)(478600001)(8676002)(8936002)(5660300002)(44832011)(36756003)(31696002)(2906002)(86362001)(66556008)(82960400001)(4326008)(66946007)(6636002)(66476007)(316002)(38100700002)(41300700001)(2616005)(186003)(6512007)(53546011)(26005)(6506007)(6666004)(6486002)(31686004)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SFFTVVdwcVlmbXpyRUFuaFpHa3R3TGZLeHJsQkNxNkRIMVRGTE9mNmNudGdT?=
 =?utf-8?B?dit2UmpiUW5qWm5Jd3dqN0tXb1o2bjNwRWpPN3hLeklNMUpjTCs4bEhCcE1L?=
 =?utf-8?B?dUlKZTMwQVhibGN0UFkxTzloWVludENSSUJtVzdSWHVKdWQyRHpHd0swZnRI?=
 =?utf-8?B?dmQ5Y2FRcEtNS0x6L0Ezb0tsZENlMVBxdDlWaUR5d0JXUkZyNU04cTBwSFlj?=
 =?utf-8?B?Yk5IaHIvaVhDMTJhd3FoeGJGeU5CV1pxTnJrdzJPQUIyM0NXVFJ0b1JUaFZT?=
 =?utf-8?B?VWlqLzg0QzB6aml4WkdaZTBlcDZxbnh5cW0zREVMV0VMWkluL1Uvb0huZ2RV?=
 =?utf-8?B?M1NtcEdBa29HWlJPbEVYQkFEL3pkUXV2U1VDWklDTWJZVHQ3cFVjMTQyRWY4?=
 =?utf-8?B?WEpKVjRCbWY1Qnd5a1htUXBIZkp2dUVOaGh0RWNoYnM2SFlVTC9rR25oQks1?=
 =?utf-8?B?QjBxdEN5NXlNYjhWbGJQZlVDZ0JoZlQreXhRSkZPdGxUYjRrRXpncUZkVVd3?=
 =?utf-8?B?aStwZDh0RzcxR2RCbEtTU3N4OW5NOUhwQ1NrS1A3RGhSQTQ2cEpYakhiYitT?=
 =?utf-8?B?STkzRHRUMTRITmIzdHdmZEZCNVcyRHE2Zy94VkpYUHlKMWxlRlE3VHZJYjVS?=
 =?utf-8?B?R1RCSFJnYlFXMVlSKzk1TDJwZGZ6bGFRYVQzcklRWjZBVXhRQmhPM1J6cDFI?=
 =?utf-8?B?VCtLZnhLSzc1eUpQRnhIV0M0WUFxVGpxeUtGeWtqdHQxckovNitkT243Y3By?=
 =?utf-8?B?aW1ueEJZMFNSZTE2RTMveTdtczBRZjhNTTEwTG1iQy9CaVdNaGdXYWIzS3RH?=
 =?utf-8?B?L2RqNGFDOHM2Y1c4aGlDZkhsUjFjSGNHNUFydGdnMlBMOWJiT1F0Z1Y1UXZE?=
 =?utf-8?B?ZXpGbGQ0TUJtUGVBeGVSMDJxVlQrTW01cjZVeHJuK1BKMlF3RGIzeHd2YUEx?=
 =?utf-8?B?Y1BjMjdoWVpkcG01SkNTS09NWE83cm9OUXkwZmZZbGZNcE5Wa25LcmRhNTYz?=
 =?utf-8?B?UWVxTjFMWUg0cTIxNHdZSjJQQit1VnZHTUZYVmx5RGJLY3B2MjI0amhUS29W?=
 =?utf-8?B?S2U0SzE0LzRhbTg2WnRJU3U5SCtQQTcwSm8xd2lCZ2hybytaWUZmM2hUelFL?=
 =?utf-8?B?OE51OFd4bGt1em1lRjFzWHRsNk5HN0E4YVNtWUI1WkZGTkY1MHRHbjFNdHls?=
 =?utf-8?B?SFRVVmR2MmhRSzQwOXA2TW1menQ0MHlSY0s0STdwSEFsbzl1d0svUVE0aHJG?=
 =?utf-8?B?UXF3SW9udFJBS1BFbElCN3Zwdjh6a21pdlo0WjU1ditUMzRBN1lPTUd6Q0hx?=
 =?utf-8?B?UlduSExTVkZIelNPc0xpZXVjU0xEemxwK0ZRbDdzd0o2NmFibWRObUNDOWww?=
 =?utf-8?B?VkRiM3hhbklxVkxqazdQOS8relZjaHNGS2Jvak54M1dlNnRiMUxqM0FmeVls?=
 =?utf-8?B?aGplRlNwUXlCNmtLanphZGh6OUQ3TStGcVdqVEppL3ViRDBLTVZFeTU1V0lV?=
 =?utf-8?B?c3R1MGp4UFhpZmJRTS9QZFBOa2FMV0pTaUU3d0t6Z2g2cXhpNVZlNkh2eGpq?=
 =?utf-8?B?SCtBRjExTjJ5RVVKV0R4Z0paNTRuNTNodFJPREU1VndBLzFqSGdqb3M0d3Vn?=
 =?utf-8?B?dmloUGY5Q0s3bmFIbEprSllRU0NlWk5ldSs5MmVUbnBpbzU0STk3ZnBQNWVN?=
 =?utf-8?B?Q1lUaVI5TFFscC8zQ3d0N0VnZVB4NmlPNXc5YjEydHRlUVhyYUlscDVCM0xz?=
 =?utf-8?B?TDA5ZWV2QXQ2cUFPNkRFaHhOam51cFNOdlZXZ0ZiNVVVdXFNeDN5TThxSnRm?=
 =?utf-8?B?U2VXSWM1Y2twZlNXa2ZnR1NEVjdpUG9kRjV4enpFdDc3WWdQdkFDVGhuYU9a?=
 =?utf-8?B?cTZZRit1VlpPcVVQZjBQeEt6RG9QYnU4VVpRSHo4VWNKdDZIZllnMzRTZUxV?=
 =?utf-8?B?RHgvOTU2Znh5VncyUCtZbzdBM3o0UzU1SjJsTGlQZXY3djU2OU1HNE5VOHhq?=
 =?utf-8?B?UExxd0cwQTNENzJydHpIcWVma0FxZ3B6dXJscnkxT1BwNDNRYVlBMEh5anJi?=
 =?utf-8?B?ZC8yV2Rid2UxQXhxWHIxNS9UWmNxTnYydVY3aTdVcG9aK2haV1FiVTZjL0JL?=
 =?utf-8?Q?W822WoaKqFibQg51qI2mNMBt7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a2e2c0c-511a-4309-fc5a-08db6166aedf
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 23:36:25.3189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RWFN+bv78DvBeDsVqyDVhlod7MeTBHoxFK8aEVBi1fTWmJP126ZWw/GUm/tY6WdIB5rR8j9FVhE54OoE21y9Ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6043
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


On 5/25/23 20:33, Davidlohr Bueso wrote:
> Sanitation is by definition a device-monopolizing operation, and thus
> the timeslicing rules for other background commands do not apply.
> As such handle this special case asynchronously and return immediately.
> Subsequent changes will allow completion to be pollable from userspace
> via a sysfs file interface.
>
> For devices that don't support interrupts for notifying background
> command completion, self-poll with the caveat that the poller can
> be out of sync with the ready hardware, and therefore care must be
> taken to not allow any new commands to go through until the poller
> sees the hw completion. The poller takes the mbox_mutex to stabilize
> the flagging, minimizing any runtime overhead in the send path to
> check for 'sanitize_tmo' for uncommon poll scenarios. This flag
> also serves for sanitation (the only user of async polling) to know
> when to queue work or simply rely on irqs.
>
> The irq case is much simpler as hardware will serialize/error
> appropriately.
>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Just a minor nit below, otherwise

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>   drivers/cxl/core/memdev.c | 10 +++++
>   drivers/cxl/cxlmem.h      | 10 +++++
>   drivers/cxl/pci.c         | 83 +++++++++++++++++++++++++++++++++++++--
>   3 files changed, 99 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 6e1d7d3610a2..02763e83545c 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -460,11 +460,21 @@ void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cm
>   }
>   EXPORT_SYMBOL_NS_GPL(clear_exclusive_cxl_commands, CXL);
>   
> +static void cxl_memdev_security_shutdown(struct device *dev)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +
> +	if (cxlds->security.poll_tmo_secs != -1)
> +		cancel_delayed_work_sync(&cxlds->security.poll_dwork);
> +}
> +
>   static void cxl_memdev_shutdown(struct device *dev)
>   {
>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>   
>   	down_write(&cxl_memdev_rwsem);
> +	cxl_memdev_security_shutdown(dev);
>   	cxlmd->cxlds = NULL;
>   	up_write(&cxl_memdev_rwsem);
>   }
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 5329274b0076..02ec68f97de2 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -264,9 +264,18 @@ struct cxl_poison_state {
>    * struct cxl_security_state - Device security state
>    *
>    * @state: state of last security operation
> + * @poll_tmo_secs: polling timeout
> + * @poll_dwork: polling work item
> + *
> + * Polling (sanitation) is only used when device mbox irqs are not
> + * supported. As such, @poll_tmo_secs == -1 indicates that polling
> + * is disabled. Otherwise, when enabled, @poll_tmo_secs is maxed
> + * at 15 minutes and serialized by the mbox_mutex.
>    */
>   struct cxl_security_state {
>   	unsigned long state;
> +	int poll_tmo_secs;
> +	struct delayed_work poll_dwork;
>   };
>   
>   /**
> @@ -380,6 +389,7 @@ enum cxl_opcode {
>   	CXL_MBOX_OP_GET_SCAN_MEDIA_CAPS	= 0x4303,
>   	CXL_MBOX_OP_SCAN_MEDIA		= 0x4304,
>   	CXL_MBOX_OP_GET_SCAN_MEDIA	= 0x4305,
> +	CXL_MBOX_OP_SANITIZE		= 0x4400,
>   	CXL_MBOX_OP_GET_SECURITY_STATE	= 0x4500,
>   	CXL_MBOX_OP_SET_PASSPHRASE	= 0x4501,
>   	CXL_MBOX_OP_DISABLE_PASSPHRASE	= 0x4502,
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index a78e40e6d0e0..a0d93719ab18 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -115,16 +115,52 @@ static bool cxl_mbox_background_complete(struct cxl_dev_state *cxlds)
>   
>   static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
>   {
> +	u64 reg;
> +	u16 opcode;
>   	struct cxl_dev_id *dev_id = id;
>   	struct cxl_dev_state *cxlds = dev_id->cxlds;
>   
> -	/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
> -	if (cxl_mbox_background_complete(cxlds))
> -		rcuwait_wake_up(&cxlds->mbox_wait);
> +	if (!cxl_mbox_background_complete(cxlds))
> +		goto done;
>   
> +	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
> +	opcode = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK, reg);
> +	if (opcode == CXL_MBOX_OP_SANITIZE) {
> +		dev_dbg(cxlds->dev, "Sanitation operation ended\n");
> +	} else {
> +		/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
> +		rcuwait_wake_up(&cxlds->mbox_wait);
> +	}
> +done:
>   	return IRQ_HANDLED;
>   }
>   
> +/*
> + * Sanitation operation polling mode.
> + */
> +static void cxl_mbox_sanitize_work(struct work_struct *work)
> +{
> +	struct cxl_dev_state *cxlds;
> +
> +	cxlds = container_of(work,
> +			     struct cxl_dev_state, security.poll_dwork.work);
> +
> +	mutex_lock(&cxlds->mbox_mutex);
> +	if (cxl_mbox_background_complete(cxlds)) {
> +		cxlds->security.poll_tmo_secs = 0;
> +		put_device(cxlds->dev);
> +
> +		dev_dbg(cxlds->dev, "Sanitation operation ended\n");
> +	} else {
> +		int timeout = cxlds->security.poll_tmo_secs + 10;
> +
> +		cxlds->security.poll_tmo_secs = min(15 * 60, timeout);
> +		queue_delayed_work(system_wq, &cxlds->security.poll_dwork,
> +				   timeout * HZ);
> +	}
> +	mutex_unlock(&cxlds->mbox_mutex);
> +}
> +
>   /**
>    * __cxl_pci_mbox_send_cmd() - Execute a mailbox command
>    * @cxlds: The device state to communicate with.
> @@ -185,6 +221,16 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
>   		return -EBUSY;
>   	}
>   
> +	/*
> +	 * With sanitize polling, hardware might be done and the poller still
> +	 * not be in sync. Ensure no new command comes in until so. Keep the
> +	 * hardware semantics and only allow device health status.
> +	 */
> +	if (unlikely(cxlds->security.poll_tmo_secs > 0)) {
> +		if (mbox_cmd->opcode != CXL_MBOX_OP_GET_HEALTH_INFO)
> +			return -EBUSY;
> +	}
> +
>   	cmd_reg = FIELD_PREP(CXLDEV_MBOX_CMD_COMMAND_OPCODE_MASK,
>   			     mbox_cmd->opcode);
>   	if (mbox_cmd->size_in) {
> @@ -233,11 +279,34 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
>   	 */
>   	if (mbox_cmd->return_code == CXL_MBOX_CMD_RC_BACKGROUND) {
>   		u64 bg_status_reg;
> -		int i, timeout = mbox_cmd->poll_interval_ms;
> +		int i, timeout;
> +
> +		/*
> +		 * Sanitation is a special case which monopolizes the device
> +		 * and cannot be timesliced. Handle asynchronously instead,
> +		 * and allow userspace to poll(2) for completion.
> +		 */
> +		if (mbox_cmd->opcode == CXL_MBOX_OP_SANITIZE) {
> +			if (cxlds->security.poll_tmo_secs != -1) {
> +				/* hold the device throughout */
> +				get_device(cxlds->dev);
> +
> +				/* give first timeout a second */
> +				timeout = 1;
> +				cxlds->security.poll_tmo_secs = timeout;
> +				queue_delayed_work(system_wq,
> +						   &cxlds->security.poll_dwork,
> +						   timeout * HZ);
> +			}
> +
> +			dev_dbg(dev, "Sanitation operation started\n");
> +			goto success;
> +		}
>   
>   		dev_dbg(dev, "Mailbox background operation (0x%04x) started\n",
>   			mbox_cmd->opcode);
>   
> +		timeout = mbox_cmd->poll_interval_ms;
>   		for (i = 0; i < mbox_cmd->poll_count; i++) {
>   			if (rcuwait_wait_event_timeout(&cxlds->mbox_wait,
>   				       cxl_mbox_background_complete(cxlds),
> @@ -268,6 +337,7 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
>   		return 0; /* completed but caller must check return_code */
>   	}
>   
> +success:
>   	/* #7 */
>   	cmd_reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_CMD_OFFSET);
>   	out_len = FIELD_GET(CXLDEV_MBOX_CMD_PAYLOAD_LENGTH_MASK, cmd_reg);
> @@ -376,10 +446,15 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
>   		ctrl |= CXLDEV_MBOX_CTRL_BG_CMD_IRQ;
>   		writel(ctrl, cxlds->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
>   
> +		/* flag that irqs are enabled */
> +		cxlds->security.poll_tmo_secs = -1;

Use a #define instead of -1 magic number? CXL_CMD_TIMEOUT_INVALID 
perhaps? Would also apply to all the checking of poll_tmo_secs in this 
patch.


>   		return 0;
>   	}
>   
>   mbox_poll:
> +	cxlds->security.poll_tmo_secs = 0;
> +	INIT_DELAYED_WORK(&cxlds->security.poll_dwork,
> +			  cxl_mbox_sanitize_work);
>   	dev_dbg(cxlds->dev, "Mailbox interrupts are unsupported");
>   	return 0;
>   }
