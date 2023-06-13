Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72DFEB64D7
	for <linux-cxl@archiver.kernel.org>; Tue, 13 Jun 2023 22:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbjFMWPW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 13 Jun 2023 18:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbjFMWPU (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 13 Jun 2023 18:15:20 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0342510CC
        for <linux-cxl@vger.kernel.org>; Tue, 13 Jun 2023 15:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686694514; x=1718230514;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=61C+oGGEdGKrVGHBdUrgucZCwrH4J8RLi9+QpAixJHo=;
  b=E+qleCXXY0bem+EgAkv2Gw3nzAoPCY+jjX2MJlgnD6X+RIPIOHllCXEi
   dTiHxWMGLIbHlzw1b7tvx8QVZHVT1ZgGhLdbt2PEGDyIyMmV1H29aoVQW
   T/0WBkufrm9ivOE0XQLiO7SfX+tGTnxpU8ZP8QGfSrQMPW6moAwWjW/dW
   HYyZ54X29ETH4/UshYahIL1Z/S0sVthmUwE96Q8hRn/lYW+XCL1Q4sAvn
   0J4xwiUEWD9jLRvAJq5BT1Le0JCvMircox4S5MbMsfAU6M6C+Gq/OXC9o
   0qXKl4qc9BPd8UWXmUvo4Zq1mSEF2TXwbSHszMnOmZFTcN1B+5HZ20Ruh
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="386866883"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="386866883"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 15:15:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10740"; a="714959990"
X-IronPort-AV: E=Sophos;i="6.00,240,1681196400"; 
   d="scan'208";a="714959990"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 13 Jun 2023 15:15:09 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 15:15:09 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 13 Jun 2023 15:15:08 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 13 Jun 2023 15:15:08 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 13 Jun 2023 15:15:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X2QhP1pF6FNvIYGUkH/V0jJsptnqZIkB9AbrfA0u8xI0K1bVazg0AqqAvBaQtUpdujFMBngBOiFTor6O7WSNOFXRT4Gg2DIu8BgWJ+4ciwnwM+A9a0sDZzYDwmqtLcvzyhJEu3jqSI67WAMg1QYp8Nf0zRTcsrfvrSMxrmlXTAqBp1mwninSJGpubruMCByPdHV4SDzXCnY2AXKUuPJpLmwtIZiWzabED5O3Qe9TfAlzS9MPDcrU/2JNT6/Hv/iLwuEo8eqTYX8/SUubaFxXEmPJtBeamy3wCAdJ0j1owV62IOPwf9id68RLvu/d0ObE5dG708SyQll8eerLxx8yMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6ccKS18pps6QxzR4mrrBDbVndAy7xhzRn+OE/RZjnU=;
 b=gDSHpUG0+p3LVlkIt7bKv3ehAkzFhQVGhCbjkBLyM799mWlApjlHJPZFP0G2XafCNzmQIdt48oivZWEzflAlkigISrX8FEteh7WGFBD1IhHNjwqmHWils56ZNuCZTh9FVXn9glFV5vvU9dBt894IzSpkqrbjBPnCka0CzlvPxc9ae90/9mkJ2pBm8KmVayKsm3OlKtqCfNnryX3StkKqmly6TKy9u0h5g7ZqR7ExzrrRZ9nJyC7jBTEib3/xZ31WtkGD44epYZ8/sKH/rPl+Zs5KxfCGUKhVShLWqr8hzxalLbyqnjKTmlYfMlrNWLwyPd/SgLtfcmaCruYoJjruvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SJ0PR11MB6621.namprd11.prod.outlook.com (2603:10b6:a03:477::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Tue, 13 Jun
 2023 22:15:04 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::ef38:9181:fb78:b528%7]) with mapi id 15.20.6455.043; Tue, 13 Jun 2023
 22:15:04 +0000
Message-ID: <8034a0a7-85d8-56e8-0f38-443d14cebd2d@intel.com>
Date:   Tue, 13 Jun 2023 15:15:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.11.0
Subject: Re: [PATCH 03/19] cxl/mbox: Move mailbox related driver state to its
 own data structure
To:     Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     <ira.weiny@intel.com>, <navneet.singh@intel.com>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
 <168592151409.1948938.14287743104711770676.stgit@dwillia2-xfh.jf.intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <168592151409.1948938.14287743104711770676.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0231.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::26) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SJ0PR11MB6621:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b917c89-9107-4888-a00a-08db6c5ba356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EwhjreJzg31r4dIjWcLVZ8XzH9It25TFQHeb1juIvyLjIX/MCXi+Y7kN4kzr2v3epxvN9zTdkjLe3iqvkhln4TCFf09aOmsX+l7WRGsJQcwSh6YXE23Y6/dT1gGmkd5tEepjDo+K6qzvPvZcojaak+s9unxlK9u1TGwauFO0u8wwYoTJ8RrG/WS/URonRnfQlxIn7dIyPR+X/9EhQGSXdup5no8BcnJ05Vs/9aaAYwlNVj/fNff3muqs+5up1MhS9yx61HHnO7kv0CNEodQCv8B9drbuYtZBJbIbNzUnacCbJ8oP3jqY+wDkYxUOgR6Rr772Z1xZU/ISBrMNDWUhzVY/c5mJaH80/OzjCgzmzZuJrzIvWpHh7umpCmDgvIxS62e+CPGr36+kXJoAK71KrUsXgl8Eg1+UujdCy7lyOwi7gk5ep03AytDfPzg/MVOr8UN9src53X9QmgO+OQUtSLatXVCuMVePKUH3/l37kDFl5LuBXoVqrbNA6Xe9sAwlMhSuv2uISF95ccgsvT3SnesFVlN9lDW5s+tPuBQblJaJldlmZ3BmztnLXrX9Elh1fYYXKX5OWC7T0YoIGz8Nh2iXX6krIwSZVqtDlj6TavjiaQFK0WoOu8GUOH6WICJ0TjyWvwRvtekYijzG2QrTasWwwo9cgTrDIU61ptnnmZ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(376002)(366004)(136003)(451199021)(26005)(86362001)(6512007)(53546011)(2616005)(186003)(82960400001)(83380400001)(36756003)(38100700002)(107886003)(31696002)(6506007)(8676002)(4326008)(41300700001)(31686004)(316002)(44832011)(478600001)(15650500001)(30864003)(66946007)(66476007)(2906002)(8936002)(6486002)(5660300002)(66556008)(6666004)(43740500002)(45980500001)(579004)(559001)(47845004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TURNUmpDUnlhOEx2eDlXb2NmVUpSU3Z6N3JQNWRhL1dla1M3d3A1S1VLalov?=
 =?utf-8?B?Nkh2ZVc2a2tRT0VNS0VUVm1VdWdhZXpPcHRsZmJkQi8wSHJHVmg3S01qajY0?=
 =?utf-8?B?b3dqbXBjZHdkSUNTZWhGNzhtUFAvTGlyWTF4RWtYcjh0ejJmWXpXVDRweGVK?=
 =?utf-8?B?L2JFZDlmYVRwSVd4S1lKQjNwa3ZDb3M5UTRSbm50aVNOUHFvZm9lNy9LUDhl?=
 =?utf-8?B?Q0NFN1gvYkkwNkdWOFNUTjcweFdqSndqa1NMS1p3N1lGbW50Q1I5MmpZNGVF?=
 =?utf-8?B?SnhuUlBma3Zka1JGMXNJSjZHczZjOXNYeFZ5NU83ayszMTczcmRxNmtQRFNU?=
 =?utf-8?B?eEo3NEx6M3lrYmFuaVNteVM4MDFmWnc4YUR3T2lTajJYL0pZTHRKcVdncEpZ?=
 =?utf-8?B?Nnc5ZlRPeUtzSG1LTHozbXBPbGswMUU0UzkzUm10MitZUUxHSnlleFpFTlRZ?=
 =?utf-8?B?UGRUSDBKN0RqR0Q3UFhCV0p1WkZrWTNIQktEOUdUMTJ6VENnY2VreHVHMTdT?=
 =?utf-8?B?QVl5cGRPVm1TTDdPaUZWK0VFM3REUlE0L1NDYUNKV2ZCRm9KVW82UTB0TXlo?=
 =?utf-8?B?aklCc09GdmFnaXplYkFYTUpkNkpNV1NoWWwyZk83ZWk1NmxmT1MreVlpc2xN?=
 =?utf-8?B?eFMzcnpuVjQ1akxaTThKdUNZS1RsYjg2WjB6UjhxR3h5aENtdy91NEVFYmpN?=
 =?utf-8?B?RndZMFpSTjdGd2FiZ3FaNURZNmpRa0ZFY2FPcGliRkpHYkRJaDI5U1haZ3NW?=
 =?utf-8?B?THZHa1FGYVVjS1g4ekRsSWJONG5ycFI4M3BYckJXNHJNWlJiOFI3YkVUUitS?=
 =?utf-8?B?amd4WVVCdTlZUk9kWDZIZU5ITEpDb0N6cVJvYXhnb2k3Ykh2QVRUdUpjd0xj?=
 =?utf-8?B?NDFEc3NjNCsrUUpLQWswNmswU1dIUFhQV0lnK3hWOFY5QVJ2SEJabDhiNENo?=
 =?utf-8?B?K0ZXT2prcmhYUHl5WVlHRy9NNEg2c1I5WVRoQnJmU1E4Z3hGbnU4SFM5N2NB?=
 =?utf-8?B?bW5KdmRWR3lPKy9sMTNxSWZlMGJUWGFDbGZyWjk0UDhUMlFPM0FqN2hUWDFJ?=
 =?utf-8?B?WGRqeS9kc044azFMUjJUYVY3Nzd2aGVjeTQvejRiQ0puUGlGZDVkbGtCb21l?=
 =?utf-8?B?SHdvZ3Zmc0J4UUx6cUZHWGZYbmdqclJoSEhYTEJrZzNXWE5FZCsvbHRkeC9W?=
 =?utf-8?B?Wlh2eHpYVU1WaCtSNmxCY3VEQm5WU2RyWFFnSUZ3ZXhwdDB6Ky9SV1V5TVA5?=
 =?utf-8?B?dkNjQTByTkVaYWZCK3JTUFRpR0gzc2ZXNnhKcHhCNGRTbVB6UVNLMkdNaS9L?=
 =?utf-8?B?VEgwTFdlb2ViNWdYd0t1M095am9VQ1Z0c1ZpeXdhRDQwSGRvYVprbTNKeVBQ?=
 =?utf-8?B?cTF4MVVnZzVoUHlMOUNqL3c0bDJQV2pEZlVRbHN3ajhEeVlma0xucG9HTnEz?=
 =?utf-8?B?SGpISy9BWDh1V3ZOdTRSRWRkS3Yvc0gyTjFiSDN4dW02eEkrWU9uWThvUTN0?=
 =?utf-8?B?dCtsMVFOeXRYUDVrS0prakpWek5uVXhRWjJEeHgrQ1ZrVGlMd25PN0NQd3o2?=
 =?utf-8?B?bTRlWVB0MW1MaUdnaW1YcmgwOW9YMzVoOHFBUC9JRlN5OEFJNDBTREtSeHZS?=
 =?utf-8?B?YWllUTVKOWZ5MVJrQndiVTBkSEswTW00NWRzRlVEWnp6U3M0UnAwMFBBMkoy?=
 =?utf-8?B?M1BRTnZQdEdjeHRnblF3d0NWaGVQb0Jzd00xdThDZWNqVVB4QXN0R0pHSml0?=
 =?utf-8?B?K2Q5bEUveVFLeDVPdHYwNDMvQU1XZmJtd3FnS1hQcEhFVmE0Y3ZRMGppM0Vz?=
 =?utf-8?B?OFJSeWxwWEZIUFppS0hReHNWbzBxVXRPTE5rQ2k5d2VKYXJ5S0FSQ09WOEgy?=
 =?utf-8?B?U0xIbUNrbzVKaHpsTDU2c0N1b3UvTUFobGdpc0V1ZXJxTVorRnNidkdsWU8v?=
 =?utf-8?B?aTVUMFdEZm5lQXhacDJ4RUpzQW1XQzJLTUgxeXFZN1hkQmEycDhVSE83WGQv?=
 =?utf-8?B?S050VmZqckFXVjRBVW1HNGFVR0xIRVoxbUZIZUQ3Mi9aSFZyaGZWeHZvb0M5?=
 =?utf-8?B?ZTNvdkRKM3FYSWU3dGZ3dEZtNDlUbWJKbWlyVnRaNFd3Q1FjOTAra0tPR0hC?=
 =?utf-8?Q?QQ66omC2Q4ACoSTexjc9yc+8U?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b917c89-9107-4888-a00a-08db6c5ba356
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 22:15:04.4076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dcnwgSONOpuvwTuJPKsKrygg88jMjwmQxAn7FpccF0B297IfdGCZGPkl6yxAgULGVPE/6evcC9d5tOA3d/U3CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6621
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


On 6/4/23 16:31, Dan Williams wrote:
> 'struct cxl_dev_state' makes too many assumptions about the capabilities
> of a CXL device. In particular it assumes a CXL device has a mailbox and
> all of the infrastructure and state that comes along with that.
>
> In preparation for supporting accelerator / Type-2 devices that may not
> have a mailbox and in general maintain a minimal core context structure,
> make mailbox functionality a super-set of  'struct cxl_dev_state' with
> 'struct cxl_memdev_state'.
>
> With this reorganization it allows for CXL devices that support HDM
> decoder mapping, but not other general-expander / Type-3 capabilities,
> to only enable that subset without the rest of the mailbox
> infrastructure coming along for the ride.
>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>   drivers/cxl/core/mbox.c      |  276 ++++++++++++++++++++++--------------------
>   drivers/cxl/core/memdev.c    |   38 +++---
>   drivers/cxl/cxlmem.h         |   89 ++++++++------
>   drivers/cxl/mem.c            |   10 +-
>   drivers/cxl/pci.c            |  114 +++++++++--------
>   drivers/cxl/pmem.c           |   35 +++--
>   drivers/cxl/security.c       |   24 ++--
>   tools/testing/cxl/test/mem.c |   43 ++++---
>   8 files changed, 338 insertions(+), 291 deletions(-)
>
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index bea9cf31a12d..14805dae5a74 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -182,7 +182,7 @@ static const char *cxl_mem_opcode_to_name(u16 opcode)
>   
>   /**
>    * cxl_internal_send_cmd() - Kernel internal interface to send a mailbox command
> - * @cxlds: The device data for the operation
> + * @mds: The driver data for the operation
>    * @mbox_cmd: initialized command to execute
>    *
>    * Context: Any context.
> @@ -198,19 +198,19 @@ static const char *cxl_mem_opcode_to_name(u16 opcode)
>    * error. While this distinction can be useful for commands from userspace, the
>    * kernel will only be able to use results when both are successful.
>    */
> -int cxl_internal_send_cmd(struct cxl_dev_state *cxlds,
> +int cxl_internal_send_cmd(struct cxl_memdev_state *mds,
>   			  struct cxl_mbox_cmd *mbox_cmd)
>   {
>   	size_t out_size, min_out;
>   	int rc;
>   
> -	if (mbox_cmd->size_in > cxlds->payload_size ||
> -	    mbox_cmd->size_out > cxlds->payload_size)
> +	if (mbox_cmd->size_in > mds->payload_size ||
> +	    mbox_cmd->size_out > mds->payload_size)
>   		return -E2BIG;
>   
>   	out_size = mbox_cmd->size_out;
>   	min_out = mbox_cmd->min_out;
> -	rc = cxlds->mbox_send(cxlds, mbox_cmd);
> +	rc = mds->mbox_send(mds, mbox_cmd);
>   	/*
>   	 * EIO is reserved for a payload size mismatch and mbox_send()
>   	 * may not return this error.
> @@ -297,7 +297,7 @@ static bool cxl_payload_from_user_allowed(u16 opcode, void *payload_in)
>   }
>   
>   static int cxl_mbox_cmd_ctor(struct cxl_mbox_cmd *mbox,
> -			     struct cxl_dev_state *cxlds, u16 opcode,
> +			     struct cxl_memdev_state *mds, u16 opcode,
>   			     size_t in_size, size_t out_size, u64 in_payload)
>   {
>   	*mbox = (struct cxl_mbox_cmd) {
> @@ -312,7 +312,7 @@ static int cxl_mbox_cmd_ctor(struct cxl_mbox_cmd *mbox,
>   			return PTR_ERR(mbox->payload_in);
>   
>   		if (!cxl_payload_from_user_allowed(opcode, mbox->payload_in)) {
> -			dev_dbg(cxlds->dev, "%s: input payload not allowed\n",
> +			dev_dbg(mds->cxlds.dev, "%s: input payload not allowed\n",
>   				cxl_mem_opcode_to_name(opcode));
>   			kvfree(mbox->payload_in);
>   			return -EBUSY;
> @@ -321,7 +321,7 @@ static int cxl_mbox_cmd_ctor(struct cxl_mbox_cmd *mbox,
>   
>   	/* Prepare to handle a full payload for variable sized output */
>   	if (out_size == CXL_VARIABLE_PAYLOAD)
> -		mbox->size_out = cxlds->payload_size;
> +		mbox->size_out = mds->payload_size;
>   	else
>   		mbox->size_out = out_size;
>   
> @@ -343,7 +343,7 @@ static void cxl_mbox_cmd_dtor(struct cxl_mbox_cmd *mbox)
>   
>   static int cxl_to_mem_cmd_raw(struct cxl_mem_command *mem_cmd,
>   			      const struct cxl_send_command *send_cmd,
> -			      struct cxl_dev_state *cxlds)
> +			      struct cxl_memdev_state *mds)
>   {
>   	if (send_cmd->raw.rsvd)
>   		return -EINVAL;
> @@ -353,13 +353,13 @@ static int cxl_to_mem_cmd_raw(struct cxl_mem_command *mem_cmd,
>   	 * gets passed along without further checking, so it must be
>   	 * validated here.
>   	 */
> -	if (send_cmd->out.size > cxlds->payload_size)
> +	if (send_cmd->out.size > mds->payload_size)
>   		return -EINVAL;
>   
>   	if (!cxl_mem_raw_command_allowed(send_cmd->raw.opcode))
>   		return -EPERM;
>   
> -	dev_WARN_ONCE(cxlds->dev, true, "raw command path used\n");
> +	dev_WARN_ONCE(mds->cxlds.dev, true, "raw command path used\n");
>   
>   	*mem_cmd = (struct cxl_mem_command) {
>   		.info = {
> @@ -375,7 +375,7 @@ static int cxl_to_mem_cmd_raw(struct cxl_mem_command *mem_cmd,
>   
>   static int cxl_to_mem_cmd(struct cxl_mem_command *mem_cmd,
>   			  const struct cxl_send_command *send_cmd,
> -			  struct cxl_dev_state *cxlds)
> +			  struct cxl_memdev_state *mds)
>   {
>   	struct cxl_mem_command *c = &cxl_mem_commands[send_cmd->id];
>   	const struct cxl_command_info *info = &c->info;
> @@ -390,11 +390,11 @@ static int cxl_to_mem_cmd(struct cxl_mem_command *mem_cmd,
>   		return -EINVAL;
>   
>   	/* Check that the command is enabled for hardware */
> -	if (!test_bit(info->id, cxlds->enabled_cmds))
> +	if (!test_bit(info->id, mds->enabled_cmds))
>   		return -ENOTTY;
>   
>   	/* Check that the command is not claimed for exclusive kernel use */
> -	if (test_bit(info->id, cxlds->exclusive_cmds))
> +	if (test_bit(info->id, mds->exclusive_cmds))
>   		return -EBUSY;
>   
>   	/* Check the input buffer is the expected size */
> @@ -423,7 +423,7 @@ static int cxl_to_mem_cmd(struct cxl_mem_command *mem_cmd,
>   /**
>    * cxl_validate_cmd_from_user() - Check fields for CXL_MEM_SEND_COMMAND.
>    * @mbox_cmd: Sanitized and populated &struct cxl_mbox_cmd.
> - * @cxlds: The device data for the operation
> + * @mds: The driver data for the operation
>    * @send_cmd: &struct cxl_send_command copied in from userspace.
>    *
>    * Return:
> @@ -438,7 +438,7 @@ static int cxl_to_mem_cmd(struct cxl_mem_command *mem_cmd,
>    * safe to send to the hardware.
>    */
>   static int cxl_validate_cmd_from_user(struct cxl_mbox_cmd *mbox_cmd,
> -				      struct cxl_dev_state *cxlds,
> +				      struct cxl_memdev_state *mds,
>   				      const struct cxl_send_command *send_cmd)
>   {
>   	struct cxl_mem_command mem_cmd;
> @@ -452,20 +452,20 @@ static int cxl_validate_cmd_from_user(struct cxl_mbox_cmd *mbox_cmd,
>   	 * supports, but output can be arbitrarily large (simply write out as
>   	 * much data as the hardware provides).
>   	 */
> -	if (send_cmd->in.size > cxlds->payload_size)
> +	if (send_cmd->in.size > mds->payload_size)
>   		return -EINVAL;
>   
>   	/* Sanitize and construct a cxl_mem_command */
>   	if (send_cmd->id == CXL_MEM_COMMAND_ID_RAW)
> -		rc = cxl_to_mem_cmd_raw(&mem_cmd, send_cmd, cxlds);
> +		rc = cxl_to_mem_cmd_raw(&mem_cmd, send_cmd, mds);
>   	else
> -		rc = cxl_to_mem_cmd(&mem_cmd, send_cmd, cxlds);
> +		rc = cxl_to_mem_cmd(&mem_cmd, send_cmd, mds);
>   
>   	if (rc)
>   		return rc;
>   
>   	/* Sanitize and construct a cxl_mbox_cmd */
> -	return cxl_mbox_cmd_ctor(mbox_cmd, cxlds, mem_cmd.opcode,
> +	return cxl_mbox_cmd_ctor(mbox_cmd, mds, mem_cmd.opcode,
>   				 mem_cmd.info.size_in, mem_cmd.info.size_out,
>   				 send_cmd->in.payload);
>   }
> @@ -473,6 +473,7 @@ static int cxl_validate_cmd_from_user(struct cxl_mbox_cmd *mbox_cmd,
>   int cxl_query_cmd(struct cxl_memdev *cxlmd,
>   		  struct cxl_mem_query_commands __user *q)
>   {
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>   	struct device *dev = &cxlmd->dev;
>   	struct cxl_mem_command *cmd;
>   	u32 n_commands;
> @@ -494,9 +495,9 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
>   	cxl_for_each_cmd(cmd) {
>   		struct cxl_command_info info = cmd->info;
>   
> -		if (test_bit(info.id, cxlmd->cxlds->enabled_cmds))
> +		if (test_bit(info.id, mds->enabled_cmds))
>   			info.flags |= CXL_MEM_COMMAND_FLAG_ENABLED;
> -		if (test_bit(info.id, cxlmd->cxlds->exclusive_cmds))
> +		if (test_bit(info.id, mds->exclusive_cmds))
>   			info.flags |= CXL_MEM_COMMAND_FLAG_EXCLUSIVE;
>   
>   		if (copy_to_user(&q->commands[j++], &info, sizeof(info)))
> @@ -511,7 +512,7 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
>   
>   /**
>    * handle_mailbox_cmd_from_user() - Dispatch a mailbox command for userspace.
> - * @cxlds: The device data for the operation
> + * @mds: The driver data for the operation
>    * @mbox_cmd: The validated mailbox command.
>    * @out_payload: Pointer to userspace's output payload.
>    * @size_out: (Input) Max payload size to copy out.
> @@ -532,12 +533,12 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
>    *
>    * See cxl_send_cmd().
>    */
> -static int handle_mailbox_cmd_from_user(struct cxl_dev_state *cxlds,
> +static int handle_mailbox_cmd_from_user(struct cxl_memdev_state *mds,
>   					struct cxl_mbox_cmd *mbox_cmd,
>   					u64 out_payload, s32 *size_out,
>   					u32 *retval)
>   {
> -	struct device *dev = cxlds->dev;
> +	struct device *dev = mds->cxlds.dev;
>   	int rc;
>   
>   	dev_dbg(dev,
> @@ -547,7 +548,7 @@ static int handle_mailbox_cmd_from_user(struct cxl_dev_state *cxlds,
>   		cxl_mem_opcode_to_name(mbox_cmd->opcode),
>   		mbox_cmd->opcode, mbox_cmd->size_in);
>   
> -	rc = cxlds->mbox_send(cxlds, mbox_cmd);
> +	rc = mds->mbox_send(mds, mbox_cmd);
>   	if (rc)
>   		goto out;
>   
> @@ -576,7 +577,7 @@ static int handle_mailbox_cmd_from_user(struct cxl_dev_state *cxlds,
>   
>   int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
>   {
> -	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>   	struct device *dev = &cxlmd->dev;
>   	struct cxl_send_command send;
>   	struct cxl_mbox_cmd mbox_cmd;
> @@ -587,11 +588,11 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
>   	if (copy_from_user(&send, s, sizeof(send)))
>   		return -EFAULT;
>   
> -	rc = cxl_validate_cmd_from_user(&mbox_cmd, cxlmd->cxlds, &send);
> +	rc = cxl_validate_cmd_from_user(&mbox_cmd, mds, &send);
>   	if (rc)
>   		return rc;
>   
> -	rc = handle_mailbox_cmd_from_user(cxlds, &mbox_cmd, send.out.payload,
> +	rc = handle_mailbox_cmd_from_user(mds, &mbox_cmd, send.out.payload,
>   					  &send.out.size, &send.retval);
>   	if (rc)
>   		return rc;
> @@ -602,13 +603,14 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
>   	return 0;
>   }
>   
> -static int cxl_xfer_log(struct cxl_dev_state *cxlds, uuid_t *uuid, u32 *size, u8 *out)
> +static int cxl_xfer_log(struct cxl_memdev_state *mds, uuid_t *uuid,
> +			u32 *size, u8 *out)
>   {
>   	u32 remaining = *size;
>   	u32 offset = 0;
>   
>   	while (remaining) {
> -		u32 xfer_size = min_t(u32, remaining, cxlds->payload_size);
> +		u32 xfer_size = min_t(u32, remaining, mds->payload_size);
>   		struct cxl_mbox_cmd mbox_cmd;
>   		struct cxl_mbox_get_log log;
>   		int rc;
> @@ -627,7 +629,7 @@ static int cxl_xfer_log(struct cxl_dev_state *cxlds, uuid_t *uuid, u32 *size, u8
>   			.payload_out = out,
>   		};
>   
> -		rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
>   
>   		/*
>   		 * The output payload length that indicates the number
> @@ -654,17 +656,18 @@ static int cxl_xfer_log(struct cxl_dev_state *cxlds, uuid_t *uuid, u32 *size, u8
>   
>   /**
>    * cxl_walk_cel() - Walk through the Command Effects Log.
> - * @cxlds: The device data for the operation
> + * @mds: The driver data for the operation
>    * @size: Length of the Command Effects Log.
>    * @cel: CEL
>    *
>    * Iterate over each entry in the CEL and determine if the driver supports the
>    * command. If so, the command is enabled for the device and can be used later.
>    */
> -static void cxl_walk_cel(struct cxl_dev_state *cxlds, size_t size, u8 *cel)
> +static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
>   {
>   	struct cxl_cel_entry *cel_entry;
>   	const int cel_entries = size / sizeof(*cel_entry);
> +	struct device *dev = mds->cxlds.dev;
>   	int i;
>   
>   	cel_entry = (struct cxl_cel_entry *) cel;
> @@ -674,39 +677,40 @@ static void cxl_walk_cel(struct cxl_dev_state *cxlds, size_t size, u8 *cel)
>   		struct cxl_mem_command *cmd = cxl_mem_find_command(opcode);
>   
>   		if (!cmd && !cxl_is_poison_command(opcode)) {
> -			dev_dbg(cxlds->dev,
> +			dev_dbg(dev,
>   				"Opcode 0x%04x unsupported by driver\n", opcode);
>   			continue;
>   		}
>   
>   		if (cmd)
> -			set_bit(cmd->info.id, cxlds->enabled_cmds);
> +			set_bit(cmd->info.id, mds->enabled_cmds);
>   
>   		if (cxl_is_poison_command(opcode))
> -			cxl_set_poison_cmd_enabled(&cxlds->poison, opcode);
> +			cxl_set_poison_cmd_enabled(&mds->poison, opcode);
>   
> -		dev_dbg(cxlds->dev, "Opcode 0x%04x enabled\n", opcode);
> +		dev_dbg(dev, "Opcode 0x%04x enabled\n", opcode);
>   	}
>   }
>   
> -static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_dev_state *cxlds)
> +static struct cxl_mbox_get_supported_logs *
> +cxl_get_gsl(struct cxl_memdev_state *mds)
>   {
>   	struct cxl_mbox_get_supported_logs *ret;
>   	struct cxl_mbox_cmd mbox_cmd;
>   	int rc;
>   
> -	ret = kvmalloc(cxlds->payload_size, GFP_KERNEL);
> +	ret = kvmalloc(mds->payload_size, GFP_KERNEL);
>   	if (!ret)
>   		return ERR_PTR(-ENOMEM);
>   
>   	mbox_cmd = (struct cxl_mbox_cmd) {
>   		.opcode = CXL_MBOX_OP_GET_SUPPORTED_LOGS,
> -		.size_out = cxlds->payload_size,
> +		.size_out = mds->payload_size,
>   		.payload_out = ret,
>   		/* At least the record number field must be valid */
>   		.min_out = 2,
>   	};
> -	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
>   	if (rc < 0) {
>   		kvfree(ret);
>   		return ERR_PTR(rc);
> @@ -729,22 +733,22 @@ static const uuid_t log_uuid[] = {
>   
>   /**
>    * cxl_enumerate_cmds() - Enumerate commands for a device.
> - * @cxlds: The device data for the operation
> + * @mds: The driver data for the operation
>    *
>    * Returns 0 if enumerate completed successfully.
>    *
>    * CXL devices have optional support for certain commands. This function will
>    * determine the set of supported commands for the hardware and update the
> - * enabled_cmds bitmap in the @cxlds.
> + * enabled_cmds bitmap in the @mds.
>    */
> -int cxl_enumerate_cmds(struct cxl_dev_state *cxlds)
> +int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
>   {
>   	struct cxl_mbox_get_supported_logs *gsl;
> -	struct device *dev = cxlds->dev;
> +	struct device *dev = mds->cxlds.dev;
>   	struct cxl_mem_command *cmd;
>   	int i, rc;
>   
> -	gsl = cxl_get_gsl(cxlds);
> +	gsl = cxl_get_gsl(mds);
>   	if (IS_ERR(gsl))
>   		return PTR_ERR(gsl);
>   
> @@ -765,19 +769,19 @@ int cxl_enumerate_cmds(struct cxl_dev_state *cxlds)
>   			goto out;
>   		}
>   
> -		rc = cxl_xfer_log(cxlds, &uuid, &size, log);
> +		rc = cxl_xfer_log(mds, &uuid, &size, log);
>   		if (rc) {
>   			kvfree(log);
>   			goto out;
>   		}
>   
> -		cxl_walk_cel(cxlds, size, log);
> +		cxl_walk_cel(mds, size, log);
>   		kvfree(log);
>   
>   		/* In case CEL was bogus, enable some default commands. */
>   		cxl_for_each_cmd(cmd)
>   			if (cmd->flags & CXL_CMD_FLAG_FORCE_ENABLE)
> -				set_bit(cmd->info.id, cxlds->enabled_cmds);
> +				set_bit(cmd->info.id, mds->enabled_cmds);
>   
>   		/* Found the required CEL */
>   		rc = 0;
> @@ -838,7 +842,7 @@ static void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>   	}
>   }
>   
> -static int cxl_clear_event_record(struct cxl_dev_state *cxlds,
> +static int cxl_clear_event_record(struct cxl_memdev_state *mds,
>   				  enum cxl_event_log_type log,
>   				  struct cxl_get_event_payload *get_pl)
>   {
> @@ -852,9 +856,9 @@ static int cxl_clear_event_record(struct cxl_dev_state *cxlds,
>   	int i;
>   
>   	/* Payload size may limit the max handles */
> -	if (pl_size > cxlds->payload_size) {
> -		max_handles = (cxlds->payload_size - sizeof(*payload)) /
> -				sizeof(__le16);
> +	if (pl_size > mds->payload_size) {
> +		max_handles = (mds->payload_size - sizeof(*payload)) /
> +			      sizeof(__le16);
>   		pl_size = struct_size(payload, handles, max_handles);
>   	}
>   
> @@ -879,12 +883,12 @@ static int cxl_clear_event_record(struct cxl_dev_state *cxlds,
>   	i = 0;
>   	for (cnt = 0; cnt < total; cnt++) {
>   		payload->handles[i++] = get_pl->records[cnt].hdr.handle;
> -		dev_dbg(cxlds->dev, "Event log '%d': Clearing %u\n",
> -			log, le16_to_cpu(payload->handles[i]));
> +		dev_dbg(mds->cxlds.dev, "Event log '%d': Clearing %u\n", log,
> +			le16_to_cpu(payload->handles[i]));
>   
>   		if (i == max_handles) {
>   			payload->nr_recs = i;
> -			rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +			rc = cxl_internal_send_cmd(mds, &mbox_cmd);
>   			if (rc)
>   				goto free_pl;
>   			i = 0;
> @@ -895,7 +899,7 @@ static int cxl_clear_event_record(struct cxl_dev_state *cxlds,
>   	if (i) {
>   		payload->nr_recs = i;
>   		mbox_cmd.size_in = struct_size(payload, handles, i);
> -		rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
>   		if (rc)
>   			goto free_pl;
>   	}
> @@ -905,32 +909,34 @@ static int cxl_clear_event_record(struct cxl_dev_state *cxlds,
>   	return rc;
>   }
>   
> -static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
> +static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>   				    enum cxl_event_log_type type)
>   {
> +	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
> +	struct device *dev = mds->cxlds.dev;
>   	struct cxl_get_event_payload *payload;
>   	struct cxl_mbox_cmd mbox_cmd;
>   	u8 log_type = type;
>   	u16 nr_rec;
>   
> -	mutex_lock(&cxlds->event.log_lock);
> -	payload = cxlds->event.buf;
> +	mutex_lock(&mds->event.log_lock);
> +	payload = mds->event.buf;
>   
>   	mbox_cmd = (struct cxl_mbox_cmd) {
>   		.opcode = CXL_MBOX_OP_GET_EVENT_RECORD,
>   		.payload_in = &log_type,
>   		.size_in = sizeof(log_type),
>   		.payload_out = payload,
> -		.size_out = cxlds->payload_size,
> +		.size_out = mds->payload_size,
>   		.min_out = struct_size(payload, records, 0),
>   	};
>   
>   	do {
>   		int rc, i;
>   
> -		rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
>   		if (rc) {
> -			dev_err_ratelimited(cxlds->dev,
> +			dev_err_ratelimited(dev,
>   				"Event log '%d': Failed to query event records : %d",
>   				type, rc);
>   			break;
> @@ -941,27 +947,27 @@ static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
>   			break;
>   
>   		for (i = 0; i < nr_rec; i++)
> -			cxl_event_trace_record(cxlds->cxlmd, type,
> +			cxl_event_trace_record(cxlmd, type,
>   					       &payload->records[i]);
>   
>   		if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
> -			trace_cxl_overflow(cxlds->cxlmd, type, payload);
> +			trace_cxl_overflow(cxlmd, type, payload);
>   
> -		rc = cxl_clear_event_record(cxlds, type, payload);
> +		rc = cxl_clear_event_record(mds, type, payload);
>   		if (rc) {
> -			dev_err_ratelimited(cxlds->dev,
> +			dev_err_ratelimited(dev,
>   				"Event log '%d': Failed to clear events : %d",
>   				type, rc);
>   			break;
>   		}
>   	} while (nr_rec);
>   
> -	mutex_unlock(&cxlds->event.log_lock);
> +	mutex_unlock(&mds->event.log_lock);
>   }
>   
>   /**
>    * cxl_mem_get_event_records - Get Event Records from the device
> - * @cxlds: The device data for the operation
> + * @mds: The driver data for the operation
>    * @status: Event Status register value identifying which events are available.
>    *
>    * Retrieve all event records available on the device, report them as trace
> @@ -970,24 +976,24 @@ static void cxl_mem_get_records_log(struct cxl_dev_state *cxlds,
>    * See CXL rev 3.0 @8.2.9.2.2 Get Event Records
>    * See CXL rev 3.0 @8.2.9.2.3 Clear Event Records
>    */
> -void cxl_mem_get_event_records(struct cxl_dev_state *cxlds, u32 status)
> +void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status)
>   {
> -	dev_dbg(cxlds->dev, "Reading event logs: %x\n", status);
> +	dev_dbg(mds->cxlds.dev, "Reading event logs: %x\n", status);
>   
>   	if (status & CXLDEV_EVENT_STATUS_FATAL)
> -		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_FATAL);
> +		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_FATAL);
>   	if (status & CXLDEV_EVENT_STATUS_FAIL)
> -		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_FAIL);
> +		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_FAIL);
>   	if (status & CXLDEV_EVENT_STATUS_WARN)
> -		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_WARN);
> +		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_WARN);
>   	if (status & CXLDEV_EVENT_STATUS_INFO)
> -		cxl_mem_get_records_log(cxlds, CXL_EVENT_TYPE_INFO);
> +		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_INFO);
>   }
>   EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, CXL);
>   
>   /**
>    * cxl_mem_get_partition_info - Get partition info
> - * @cxlds: The device data for the operation
> + * @mds: The driver data for the operation
>    *
>    * Retrieve the current partition info for the device specified.  The active
>    * values are the current capacity in bytes.  If not 0, the 'next' values are
> @@ -997,7 +1003,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, CXL);
>    *
>    * See CXL @8.2.9.5.2.1 Get Partition Info
>    */
> -static int cxl_mem_get_partition_info(struct cxl_dev_state *cxlds)
> +static int cxl_mem_get_partition_info(struct cxl_memdev_state *mds)
>   {
>   	struct cxl_mbox_get_partition_info pi;
>   	struct cxl_mbox_cmd mbox_cmd;
> @@ -1008,17 +1014,17 @@ static int cxl_mem_get_partition_info(struct cxl_dev_state *cxlds)
>   		.size_out = sizeof(pi),
>   		.payload_out = &pi,
>   	};
> -	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
>   	if (rc)
>   		return rc;
>   
> -	cxlds->active_volatile_bytes =
> +	mds->active_volatile_bytes =
>   		le64_to_cpu(pi.active_volatile_cap) * CXL_CAPACITY_MULTIPLIER;
> -	cxlds->active_persistent_bytes =
> +	mds->active_persistent_bytes =
>   		le64_to_cpu(pi.active_persistent_cap) * CXL_CAPACITY_MULTIPLIER;
> -	cxlds->next_volatile_bytes =
> +	mds->next_volatile_bytes =
>   		le64_to_cpu(pi.next_volatile_cap) * CXL_CAPACITY_MULTIPLIER;
> -	cxlds->next_persistent_bytes =
> +	mds->next_persistent_bytes =
>   		le64_to_cpu(pi.next_volatile_cap) * CXL_CAPACITY_MULTIPLIER;
>   
>   	return 0;
> @@ -1026,14 +1032,14 @@ static int cxl_mem_get_partition_info(struct cxl_dev_state *cxlds)
>   
>   /**
>    * cxl_dev_state_identify() - Send the IDENTIFY command to the device.
> - * @cxlds: The device data for the operation
> + * @mds: The driver data for the operation
>    *
>    * Return: 0 if identify was executed successfully or media not ready.
>    *
>    * This will dispatch the identify command to the device and on success populate
>    * structures to be exported to sysfs.
>    */
> -int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
> +int cxl_dev_state_identify(struct cxl_memdev_state *mds)
>   {
>   	/* See CXL 2.0 Table 175 Identify Memory Device Output Payload */
>   	struct cxl_mbox_identify id;
> @@ -1041,7 +1047,7 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
>   	u32 val;
>   	int rc;
>   
> -	if (!cxlds->media_ready)
> +	if (!mds->cxlds.media_ready)
>   		return 0;
>   
>   	mbox_cmd = (struct cxl_mbox_cmd) {
> @@ -1049,25 +1055,26 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
>   		.size_out = sizeof(id),
>   		.payload_out = &id,
>   	};
> -	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
>   	if (rc < 0)
>   		return rc;
>   
> -	cxlds->total_bytes =
> +	mds->total_bytes =
>   		le64_to_cpu(id.total_capacity) * CXL_CAPACITY_MULTIPLIER;
> -	cxlds->volatile_only_bytes =
> +	mds->volatile_only_bytes =
>   		le64_to_cpu(id.volatile_capacity) * CXL_CAPACITY_MULTIPLIER;
> -	cxlds->persistent_only_bytes =
> +	mds->persistent_only_bytes =
>   		le64_to_cpu(id.persistent_capacity) * CXL_CAPACITY_MULTIPLIER;
> -	cxlds->partition_align_bytes =
> +	mds->partition_align_bytes =
>   		le64_to_cpu(id.partition_align) * CXL_CAPACITY_MULTIPLIER;
>   
> -	cxlds->lsa_size = le32_to_cpu(id.lsa_size);
> -	memcpy(cxlds->firmware_version, id.fw_revision, sizeof(id.fw_revision));
> +	mds->lsa_size = le32_to_cpu(id.lsa_size);
> +	memcpy(mds->firmware_version, id.fw_revision,
> +	       sizeof(id.fw_revision));
>   
> -	if (test_bit(CXL_POISON_ENABLED_LIST, cxlds->poison.enabled_cmds)) {
> +	if (test_bit(CXL_POISON_ENABLED_LIST, mds->poison.enabled_cmds)) {
>   		val = get_unaligned_le24(id.poison_list_max_mer);
> -		cxlds->poison.max_errors = min_t(u32, val, CXL_POISON_LIST_MAX);
> +		mds->poison.max_errors = min_t(u32, val, CXL_POISON_LIST_MAX);
>   	}
>   
>   	return 0;
> @@ -1100,8 +1107,9 @@ static int add_dpa_res(struct device *dev, struct resource *parent,
>   	return 0;
>   }
>   
> -int cxl_mem_create_range_info(struct cxl_dev_state *cxlds)
> +int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
>   {
> +	struct cxl_dev_state *cxlds = &mds->cxlds;
>   	struct device *dev = cxlds->dev;
>   	int rc;
>   
> @@ -1113,35 +1121,35 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds)
>   	}
>   
>   	cxlds->dpa_res =
> -		(struct resource)DEFINE_RES_MEM(0, cxlds->total_bytes);
> +		(struct resource)DEFINE_RES_MEM(0, mds->total_bytes);
>   
> -	if (cxlds->partition_align_bytes == 0) {
> +	if (mds->partition_align_bytes == 0) {
>   		rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->ram_res, 0,
> -				 cxlds->volatile_only_bytes, "ram");
> +				 mds->volatile_only_bytes, "ram");
>   		if (rc)
>   			return rc;
>   		return add_dpa_res(dev, &cxlds->dpa_res, &cxlds->pmem_res,
> -				   cxlds->volatile_only_bytes,
> -				   cxlds->persistent_only_bytes, "pmem");
> +				   mds->volatile_only_bytes,
> +				   mds->persistent_only_bytes, "pmem");
>   	}
>   
> -	rc = cxl_mem_get_partition_info(cxlds);
> +	rc = cxl_mem_get_partition_info(mds);
>   	if (rc) {
>   		dev_err(dev, "Failed to query partition information\n");
>   		return rc;
>   	}
>   
>   	rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->ram_res, 0,
> -			 cxlds->active_volatile_bytes, "ram");
> +			 mds->active_volatile_bytes, "ram");
>   	if (rc)
>   		return rc;
>   	return add_dpa_res(dev, &cxlds->dpa_res, &cxlds->pmem_res,
> -			   cxlds->active_volatile_bytes,
> -			   cxlds->active_persistent_bytes, "pmem");
> +			   mds->active_volatile_bytes,
> +			   mds->active_persistent_bytes, "pmem");
>   }
>   EXPORT_SYMBOL_NS_GPL(cxl_mem_create_range_info, CXL);
>   
> -int cxl_set_timestamp(struct cxl_dev_state *cxlds)
> +int cxl_set_timestamp(struct cxl_memdev_state *mds)
>   {
>   	struct cxl_mbox_cmd mbox_cmd;
>   	struct cxl_mbox_set_timestamp_in pi;
> @@ -1154,7 +1162,7 @@ int cxl_set_timestamp(struct cxl_dev_state *cxlds)
>   		.payload_in = &pi,
>   	};
>   
> -	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
>   	/*
>   	 * Command is optional. Devices may have another way of providing
>   	 * a timestamp, or may return all 0s in timestamp fields.
> @@ -1170,18 +1178,18 @@ EXPORT_SYMBOL_NS_GPL(cxl_set_timestamp, CXL);
>   int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>   		       struct cxl_region *cxlr)
>   {
> -	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>   	struct cxl_mbox_poison_out *po;
>   	struct cxl_mbox_poison_in pi;
>   	struct cxl_mbox_cmd mbox_cmd;
>   	int nr_records = 0;
>   	int rc;
>   
> -	rc = mutex_lock_interruptible(&cxlds->poison.lock);
> +	rc = mutex_lock_interruptible(&mds->poison.lock);
>   	if (rc)
>   		return rc;
>   
> -	po = cxlds->poison.list_out;
> +	po = mds->poison.list_out;
>   	pi.offset = cpu_to_le64(offset);
>   	pi.length = cpu_to_le64(len / CXL_POISON_LEN_MULT);
>   
> @@ -1189,13 +1197,13 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>   		.opcode = CXL_MBOX_OP_GET_POISON,
>   		.size_in = sizeof(pi),
>   		.payload_in = &pi,
> -		.size_out = cxlds->payload_size,
> +		.size_out = mds->payload_size,
>   		.payload_out = po,
>   		.min_out = struct_size(po, record, 0),
>   	};
>   
>   	do {
> -		rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
>   		if (rc)
>   			break;
>   
> @@ -1206,14 +1214,14 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>   
>   		/* Protect against an uncleared _FLAG_MORE */
>   		nr_records = nr_records + le16_to_cpu(po->count);
> -		if (nr_records >= cxlds->poison.max_errors) {
> +		if (nr_records >= mds->poison.max_errors) {
>   			dev_dbg(&cxlmd->dev, "Max Error Records reached: %d\n",
>   				nr_records);
>   			break;
>   		}
>   	} while (po->flags & CXL_POISON_FLAG_MORE);
>   
> -	mutex_unlock(&cxlds->poison.lock);
> +	mutex_unlock(&mds->poison.lock);
>   	return rc;
>   }
>   EXPORT_SYMBOL_NS_GPL(cxl_mem_get_poison, CXL);
> @@ -1223,52 +1231,52 @@ static void free_poison_buf(void *buf)
>   	kvfree(buf);
>   }
>   
> -/* Get Poison List output buffer is protected by cxlds->poison.lock */
> -static int cxl_poison_alloc_buf(struct cxl_dev_state *cxlds)
> +/* Get Poison List output buffer is protected by mds->poison.lock */
> +static int cxl_poison_alloc_buf(struct cxl_memdev_state *mds)
>   {
> -	cxlds->poison.list_out = kvmalloc(cxlds->payload_size, GFP_KERNEL);
> -	if (!cxlds->poison.list_out)
> +	mds->poison.list_out = kvmalloc(mds->payload_size, GFP_KERNEL);
> +	if (!mds->poison.list_out)
>   		return -ENOMEM;
>   
> -	return devm_add_action_or_reset(cxlds->dev, free_poison_buf,
> -					cxlds->poison.list_out);
> +	return devm_add_action_or_reset(mds->cxlds.dev, free_poison_buf,
> +					mds->poison.list_out);
>   }
>   
> -int cxl_poison_state_init(struct cxl_dev_state *cxlds)
> +int cxl_poison_state_init(struct cxl_memdev_state *mds)
>   {
>   	int rc;
>   
> -	if (!test_bit(CXL_POISON_ENABLED_LIST, cxlds->poison.enabled_cmds))
> +	if (!test_bit(CXL_POISON_ENABLED_LIST, mds->poison.enabled_cmds))
>   		return 0;
>   
> -	rc = cxl_poison_alloc_buf(cxlds);
> +	rc = cxl_poison_alloc_buf(mds);
>   	if (rc) {
> -		clear_bit(CXL_POISON_ENABLED_LIST, cxlds->poison.enabled_cmds);
> +		clear_bit(CXL_POISON_ENABLED_LIST, mds->poison.enabled_cmds);
>   		return rc;
>   	}
>   
> -	mutex_init(&cxlds->poison.lock);
> +	mutex_init(&mds->poison.lock);
>   	return 0;
>   }
>   EXPORT_SYMBOL_NS_GPL(cxl_poison_state_init, CXL);
>   
> -struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
> +struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>   {
> -	struct cxl_dev_state *cxlds;
> +	struct cxl_memdev_state *mds;
>   
> -	cxlds = devm_kzalloc(dev, sizeof(*cxlds), GFP_KERNEL);
> -	if (!cxlds) {
> +	mds = devm_kzalloc(dev, sizeof(*mds), GFP_KERNEL);
> +	if (!mds) {
>   		dev_err(dev, "No memory available\n");
>   		return ERR_PTR(-ENOMEM);
>   	}
>   
> -	mutex_init(&cxlds->mbox_mutex);
> -	mutex_init(&cxlds->event.log_lock);
> -	cxlds->dev = dev;
> +	mutex_init(&mds->mbox_mutex);
> +	mutex_init(&mds->event.log_lock);
> +	mds->cxlds.dev = dev;
>   
> -	return cxlds;
> +	return mds;
>   }
> -EXPORT_SYMBOL_NS_GPL(cxl_dev_state_create, CXL);
> +EXPORT_SYMBOL_NS_GPL(cxl_memdev_state_create, CXL);
>   
>   void __init cxl_mbox_init(void)
>   {
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 057a43267290..15434b1b4909 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -39,8 +39,9 @@ static ssize_t firmware_version_show(struct device *dev,
>   {
>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>   
> -	return sysfs_emit(buf, "%.16s\n", cxlds->firmware_version);
> +	return sysfs_emit(buf, "%.16s\n", mds->firmware_version);
>   }
>   static DEVICE_ATTR_RO(firmware_version);
>   
> @@ -49,8 +50,9 @@ static ssize_t payload_max_show(struct device *dev,
>   {
>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>   
> -	return sysfs_emit(buf, "%zu\n", cxlds->payload_size);
> +	return sysfs_emit(buf, "%zu\n", mds->payload_size);
>   }
>   static DEVICE_ATTR_RO(payload_max);
>   
> @@ -59,8 +61,9 @@ static ssize_t label_storage_size_show(struct device *dev,
>   {
>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>   
> -	return sysfs_emit(buf, "%zu\n", cxlds->lsa_size);
> +	return sysfs_emit(buf, "%zu\n", mds->lsa_size);
>   }
>   static DEVICE_ATTR_RO(label_storage_size);
>   
> @@ -231,7 +234,7 @@ static int cxl_validate_poison_dpa(struct cxl_memdev *cxlmd, u64 dpa)
>   
>   int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>   {
> -	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>   	struct cxl_mbox_inject_poison inject;
>   	struct cxl_poison_record record;
>   	struct cxl_mbox_cmd mbox_cmd;
> @@ -255,13 +258,13 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>   		.size_in = sizeof(inject),
>   		.payload_in = &inject,
>   	};
> -	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
>   	if (rc)
>   		goto out;
>   
>   	cxlr = cxl_dpa_to_region(cxlmd, dpa);
>   	if (cxlr)
> -		dev_warn_once(cxlds->dev,
> +		dev_warn_once(mds->cxlds.dev,
>   			      "poison inject dpa:%#llx region: %s\n", dpa,
>   			      dev_name(&cxlr->dev));
>   
> @@ -279,7 +282,7 @@ EXPORT_SYMBOL_NS_GPL(cxl_inject_poison, CXL);
>   
>   int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
>   {
> -	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>   	struct cxl_mbox_clear_poison clear;
>   	struct cxl_poison_record record;
>   	struct cxl_mbox_cmd mbox_cmd;
> @@ -312,14 +315,15 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
>   		.payload_in = &clear,
>   	};
>   
> -	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
>   	if (rc)
>   		goto out;
>   
>   	cxlr = cxl_dpa_to_region(cxlmd, dpa);
>   	if (cxlr)
> -		dev_warn_once(cxlds->dev, "poison clear dpa:%#llx region: %s\n",
> -			      dpa, dev_name(&cxlr->dev));
> +		dev_warn_once(mds->cxlds.dev,
> +			      "poison clear dpa:%#llx region: %s\n", dpa,
> +			      dev_name(&cxlr->dev));
>   
>   	record = (struct cxl_poison_record) {
>   		.address = cpu_to_le64(dpa),
> @@ -397,17 +401,18 @@ EXPORT_SYMBOL_NS_GPL(is_cxl_memdev, CXL);
>   
>   /**
>    * set_exclusive_cxl_commands() - atomically disable user cxl commands
> - * @cxlds: The device state to operate on
> + * @mds: The device state to operate on
>    * @cmds: bitmap of commands to mark exclusive
>    *
>    * Grab the cxl_memdev_rwsem in write mode to flush in-flight
>    * invocations of the ioctl path and then disable future execution of
>    * commands with the command ids set in @cmds.
>    */
> -void set_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds)
> +void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
> +				unsigned long *cmds)
>   {
>   	down_write(&cxl_memdev_rwsem);
> -	bitmap_or(cxlds->exclusive_cmds, cxlds->exclusive_cmds, cmds,
> +	bitmap_or(mds->exclusive_cmds, mds->exclusive_cmds, cmds,
>   		  CXL_MEM_COMMAND_ID_MAX);
>   	up_write(&cxl_memdev_rwsem);
>   }
> @@ -415,13 +420,14 @@ EXPORT_SYMBOL_NS_GPL(set_exclusive_cxl_commands, CXL);
>   
>   /**
>    * clear_exclusive_cxl_commands() - atomically enable user cxl commands
> - * @cxlds: The device state to modify
> + * @mds: The device state to modify
>    * @cmds: bitmap of commands to mark available for userspace
>    */
> -void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds)
> +void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
> +				  unsigned long *cmds)
>   {
>   	down_write(&cxl_memdev_rwsem);
> -	bitmap_andnot(cxlds->exclusive_cmds, cxlds->exclusive_cmds, cmds,
> +	bitmap_andnot(mds->exclusive_cmds, mds->exclusive_cmds, cmds,
>   		      CXL_MEM_COMMAND_ID_MAX);
>   	up_write(&cxl_memdev_rwsem);
>   }
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index a2845a7a69d8..d3fe73d5ba4d 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -267,6 +267,35 @@ struct cxl_poison_state {
>    * @cxl_dvsec: Offset to the PCIe device DVSEC
>    * @rcd: operating in RCD mode (CXL 3.0 9.11.8 CXL Devices Attached to an RCH)
>    * @media_ready: Indicate whether the device media is usable
> + * @dpa_res: Overall DPA resource tree for the device
> + * @pmem_res: Active Persistent memory capacity configuration
> + * @ram_res: Active Volatile memory capacity configuration
> + * @component_reg_phys: register base of component registers
> + * @info: Cached DVSEC information about the device.
> + * @serial: PCIe Device Serial Number
> + */
> +struct cxl_dev_state {
> +	struct device *dev;
> +	struct cxl_memdev *cxlmd;
> +	struct cxl_regs regs;
> +	int cxl_dvsec;
> +	bool rcd;
> +	bool media_ready;
> +	struct resource dpa_res;
> +	struct resource pmem_res;
> +	struct resource ram_res;
> +	resource_size_t component_reg_phys;
> +	u64 serial;
> +};
> +
> +/**
> + * struct cxl_memdev_state - Generic Type-3 Memory Device Class driver data
> + *
> + * CXL 8.1.12.1 PCI Header - Class Code Register Memory Device defines
> + * common memory device functionality like the presence of a mailbox and
> + * the functionality related to that like Identify Memory Device and Get
> + * Partition Info
> + * @cxlds: Core driver state common across Type-2 and Type-3 devices
>    * @payload_size: Size of space for payload
>    *                (CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register)
>    * @lsa_size: Size of Label Storage Area
> @@ -275,9 +304,6 @@ struct cxl_poison_state {
>    * @firmware_version: Firmware version for the memory device.
>    * @enabled_cmds: Hardware commands found enabled in CEL.
>    * @exclusive_cmds: Commands that are kernel-internal only
> - * @dpa_res: Overall DPA resource tree for the device
> - * @pmem_res: Active Persistent memory capacity configuration
> - * @ram_res: Active Volatile memory capacity configuration
>    * @total_bytes: sum of all possible capacities
>    * @volatile_only_bytes: hard volatile capacity
>    * @persistent_only_bytes: hard persistent capacity
> @@ -286,54 +312,41 @@ struct cxl_poison_state {
>    * @active_persistent_bytes: sum of hard + soft persistent
>    * @next_volatile_bytes: volatile capacity change pending device reset
>    * @next_persistent_bytes: persistent capacity change pending device reset
> - * @component_reg_phys: register base of component registers
> - * @info: Cached DVSEC information about the device.
> - * @serial: PCIe Device Serial Number
>    * @event: event log driver state
>    * @poison: poison driver state info
>    * @mbox_send: @dev specific transport for transmitting mailbox commands
>    *
> - * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
> + * See CXL 3.0 8.2.9.8.2 Capacity Configuration and Label Storage for
>    * details on capacity parameters.
>    */
> -struct cxl_dev_state {
> -	struct device *dev;
> -	struct cxl_memdev *cxlmd;
> -
> -	struct cxl_regs regs;
> -	int cxl_dvsec;
> -
> -	bool rcd;
> -	bool media_ready;
> +struct cxl_memdev_state {
> +	struct cxl_dev_state cxlds;
>   	size_t payload_size;
>   	size_t lsa_size;
>   	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
>   	char firmware_version[0x10];
>   	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
>   	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
> -
> -	struct resource dpa_res;
> -	struct resource pmem_res;
> -	struct resource ram_res;
>   	u64 total_bytes;
>   	u64 volatile_only_bytes;
>   	u64 persistent_only_bytes;
>   	u64 partition_align_bytes;
> -
>   	u64 active_volatile_bytes;
>   	u64 active_persistent_bytes;
>   	u64 next_volatile_bytes;
>   	u64 next_persistent_bytes;
> -
> -	resource_size_t component_reg_phys;
> -	u64 serial;
> -
>   	struct cxl_event_state event;
>   	struct cxl_poison_state poison;
> -
> -	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
> +	int (*mbox_send)(struct cxl_memdev_state *mds,
> +			 struct cxl_mbox_cmd *cmd);
>   };
>   
> +static inline struct cxl_memdev_state *
> +to_cxl_memdev_state(struct cxl_dev_state *cxlds)
> +{
> +	return container_of(cxlds, struct cxl_memdev_state, cxlds);
> +}
> +
>   enum cxl_opcode {
>   	CXL_MBOX_OP_INVALID		= 0x0000,
>   	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
> @@ -692,18 +705,20 @@ enum {
>   	CXL_PMEM_SEC_PASS_USER,
>   };
>   
> -int cxl_internal_send_cmd(struct cxl_dev_state *cxlds,
> +int cxl_internal_send_cmd(struct cxl_memdev_state *mds,
>   			  struct cxl_mbox_cmd *cmd);
> -int cxl_dev_state_identify(struct cxl_dev_state *cxlds);
> +int cxl_dev_state_identify(struct cxl_memdev_state *mds);
>   int cxl_await_media_ready(struct cxl_dev_state *cxlds);
> -int cxl_enumerate_cmds(struct cxl_dev_state *cxlds);
> -int cxl_mem_create_range_info(struct cxl_dev_state *cxlds);
> -struct cxl_dev_state *cxl_dev_state_create(struct device *dev);
> -void set_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
> -void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
> -void cxl_mem_get_event_records(struct cxl_dev_state *cxlds, u32 status);
> -int cxl_set_timestamp(struct cxl_dev_state *cxlds);
> -int cxl_poison_state_init(struct cxl_dev_state *cxlds);
> +int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
> +int cxl_mem_create_range_info(struct cxl_memdev_state *mds);
> +struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev);
> +void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
> +				unsigned long *cmds);
> +void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
> +				  unsigned long *cmds);
> +void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status);
> +int cxl_set_timestamp(struct cxl_memdev_state *mds);
> +int cxl_poison_state_init(struct cxl_memdev_state *mds);
>   int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>   		       struct cxl_region *cxlr);
>   int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 519edd0eb196..584f9eec57e4 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -117,6 +117,7 @@ DEFINE_DEBUGFS_ATTRIBUTE(cxl_poison_clear_fops, NULL,
>   static int cxl_mem_probe(struct device *dev)
>   {
>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>   	struct device *endpoint_parent;
>   	struct cxl_port *parent_port;
> @@ -141,10 +142,10 @@ static int cxl_mem_probe(struct device *dev)
>   	dentry = cxl_debugfs_create_dir(dev_name(dev));
>   	debugfs_create_devm_seqfile(dev, "dpamem", dentry, cxl_mem_dpa_show);
>   
> -	if (test_bit(CXL_POISON_ENABLED_INJECT, cxlds->poison.enabled_cmds))
> +	if (test_bit(CXL_POISON_ENABLED_INJECT, mds->poison.enabled_cmds))
>   		debugfs_create_file("inject_poison", 0200, dentry, cxlmd,
>   				    &cxl_poison_inject_fops);
> -	if (test_bit(CXL_POISON_ENABLED_CLEAR, cxlds->poison.enabled_cmds))
> +	if (test_bit(CXL_POISON_ENABLED_CLEAR, mds->poison.enabled_cmds))
>   		debugfs_create_file("clear_poison", 0200, dentry, cxlmd,
>   				    &cxl_poison_clear_fops);
>   
> @@ -227,9 +228,12 @@ static umode_t cxl_mem_visible(struct kobject *kobj, struct attribute *a, int n)
>   {
>   	if (a == &dev_attr_trigger_poison_list.attr) {
>   		struct device *dev = kobj_to_dev(kobj);
> +		struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +		struct cxl_memdev_state *mds =
> +			to_cxl_memdev_state(cxlmd->cxlds);
>   
>   		if (!test_bit(CXL_POISON_ENABLED_LIST,
> -			      to_cxl_memdev(dev)->cxlds->poison.enabled_cmds))
> +			      mds->poison.enabled_cmds))
>   			return 0;
>   	}
>   	return a->mode;
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 0872f2233ed0..4e2845b7331a 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -86,7 +86,7 @@ static int cxl_pci_mbox_wait_for_doorbell(struct cxl_dev_state *cxlds)
>   
>   /**
>    * __cxl_pci_mbox_send_cmd() - Execute a mailbox command
> - * @cxlds: The device state to communicate with.
> + * @mds: The memory device driver data
>    * @mbox_cmd: Command to send to the memory device.
>    *
>    * Context: Any context. Expects mbox_mutex to be held.
> @@ -106,16 +106,17 @@ static int cxl_pci_mbox_wait_for_doorbell(struct cxl_dev_state *cxlds)
>    * not need to coordinate with each other. The driver only uses the primary
>    * mailbox.
>    */
> -static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
> +static int __cxl_pci_mbox_send_cmd(struct cxl_memdev_state *mds,
>   				   struct cxl_mbox_cmd *mbox_cmd)
>   {
> +	struct cxl_dev_state *cxlds = &mds->cxlds;
>   	void __iomem *payload = cxlds->regs.mbox + CXLDEV_MBOX_PAYLOAD_OFFSET;
>   	struct device *dev = cxlds->dev;
>   	u64 cmd_reg, status_reg;
>   	size_t out_len;
>   	int rc;
>   
> -	lockdep_assert_held(&cxlds->mbox_mutex);
> +	lockdep_assert_held(&mds->mbox_mutex);
>   
>   	/*
>   	 * Here are the steps from 8.2.8.4 of the CXL 2.0 spec.
> @@ -196,8 +197,9 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
>   		 * have requested less data than the hardware supplied even
>   		 * within spec.
>   		 */
> -		size_t n = min3(mbox_cmd->size_out, cxlds->payload_size, out_len);
> +		size_t n;
>   
> +		n = min3(mbox_cmd->size_out, mds->payload_size, out_len);
>   		memcpy_fromio(mbox_cmd->payload_out, payload, n);
>   		mbox_cmd->size_out = n;
>   	} else {
> @@ -207,20 +209,23 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
>   	return 0;
>   }
>   
> -static int cxl_pci_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
> +static int cxl_pci_mbox_send(struct cxl_memdev_state *mds,
> +			     struct cxl_mbox_cmd *cmd)
>   {
>   	int rc;
>   
> -	mutex_lock_io(&cxlds->mbox_mutex);
> -	rc = __cxl_pci_mbox_send_cmd(cxlds, cmd);
> -	mutex_unlock(&cxlds->mbox_mutex);
> +	mutex_lock_io(&mds->mbox_mutex);
> +	rc = __cxl_pci_mbox_send_cmd(mds, cmd);
> +	mutex_unlock(&mds->mbox_mutex);
>   
>   	return rc;
>   }
>   
> -static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
> +static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds)
>   {
> +	struct cxl_dev_state *cxlds = &mds->cxlds;
>   	const int cap = readl(cxlds->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
> +	struct device *dev = cxlds->dev;
>   	unsigned long timeout;
>   	u64 md_status;
>   
> @@ -234,8 +239,7 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
>   	} while (!time_after(jiffies, timeout));
>   
>   	if (!(md_status & CXLMDEV_MBOX_IF_READY)) {
> -		cxl_err(cxlds->dev, md_status,
> -			"timeout awaiting mailbox ready");
> +		cxl_err(dev, md_status, "timeout awaiting mailbox ready");
>   		return -ETIMEDOUT;
>   	}
>   
> @@ -246,12 +250,12 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
>   	 * source for future doorbell busy events.
>   	 */
>   	if (cxl_pci_mbox_wait_for_doorbell(cxlds) != 0) {
> -		cxl_err(cxlds->dev, md_status, "timeout awaiting mailbox idle");
> +		cxl_err(dev, md_status, "timeout awaiting mailbox idle");
>   		return -ETIMEDOUT;
>   	}
>   
> -	cxlds->mbox_send = cxl_pci_mbox_send;
> -	cxlds->payload_size =
> +	mds->mbox_send = cxl_pci_mbox_send;
> +	mds->payload_size =
>   		1 << FIELD_GET(CXLDEV_MBOX_CAP_PAYLOAD_SIZE_MASK, cap);
>   
>   	/*
> @@ -261,15 +265,14 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
>   	 * there's no point in going forward. If the size is too large, there's
>   	 * no harm is soft limiting it.
>   	 */
> -	cxlds->payload_size = min_t(size_t, cxlds->payload_size, SZ_1M);
> -	if (cxlds->payload_size < 256) {
> -		dev_err(cxlds->dev, "Mailbox is too small (%zub)",
> -			cxlds->payload_size);
> +	mds->payload_size = min_t(size_t, mds->payload_size, SZ_1M);
> +	if (mds->payload_size < 256) {
> +		dev_err(dev, "Mailbox is too small (%zub)",
> +			mds->payload_size);
>   		return -ENXIO;
>   	}
>   
> -	dev_dbg(cxlds->dev, "Mailbox payload sized %zu",
> -		cxlds->payload_size);
> +	dev_dbg(dev, "Mailbox payload sized %zu", mds->payload_size);
>   
>   	return 0;
>   }
> @@ -433,18 +436,18 @@ static void free_event_buf(void *buf)
>   
>   /*
>    * There is a single buffer for reading event logs from the mailbox.  All logs
> - * share this buffer protected by the cxlds->event_log_lock.
> + * share this buffer protected by the mds->event_log_lock.
>    */
> -static int cxl_mem_alloc_event_buf(struct cxl_dev_state *cxlds)
> +static int cxl_mem_alloc_event_buf(struct cxl_memdev_state *mds)
>   {
>   	struct cxl_get_event_payload *buf;
>   
> -	buf = kvmalloc(cxlds->payload_size, GFP_KERNEL);
> +	buf = kvmalloc(mds->payload_size, GFP_KERNEL);
>   	if (!buf)
>   		return -ENOMEM;
> -	cxlds->event.buf = buf;
> +	mds->event.buf = buf;
>   
> -	return devm_add_action_or_reset(cxlds->dev, free_event_buf, buf);
> +	return devm_add_action_or_reset(mds->cxlds.dev, free_event_buf, buf);
>   }
>   
>   static int cxl_alloc_irq_vectors(struct pci_dev *pdev)
> @@ -477,6 +480,7 @@ static irqreturn_t cxl_event_thread(int irq, void *id)
>   {
>   	struct cxl_dev_id *dev_id = id;
>   	struct cxl_dev_state *cxlds = dev_id->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
>   	u32 status;
>   
>   	do {
> @@ -489,7 +493,7 @@ static irqreturn_t cxl_event_thread(int irq, void *id)
>   		status &= CXLDEV_EVENT_STATUS_ALL;
>   		if (!status)
>   			break;
> -		cxl_mem_get_event_records(cxlds, status);
> +		cxl_mem_get_event_records(mds, status);
>   		cond_resched();
>   	} while (status);
>   
> @@ -522,7 +526,7 @@ static int cxl_event_req_irq(struct cxl_dev_state *cxlds, u8 setting)
>   					 dev_id);
>   }
>   
> -static int cxl_event_get_int_policy(struct cxl_dev_state *cxlds,
> +static int cxl_event_get_int_policy(struct cxl_memdev_state *mds,
>   				    struct cxl_event_interrupt_policy *policy)
>   {
>   	struct cxl_mbox_cmd mbox_cmd = {
> @@ -532,15 +536,15 @@ static int cxl_event_get_int_policy(struct cxl_dev_state *cxlds,
>   	};
>   	int rc;
>   
> -	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
>   	if (rc < 0)
> -		dev_err(cxlds->dev, "Failed to get event interrupt policy : %d",
> -			rc);
> +		dev_err(mds->cxlds.dev,
> +			"Failed to get event interrupt policy : %d", rc);
>   
>   	return rc;
>   }
>   
> -static int cxl_event_config_msgnums(struct cxl_dev_state *cxlds,
> +static int cxl_event_config_msgnums(struct cxl_memdev_state *mds,
>   				    struct cxl_event_interrupt_policy *policy)
>   {
>   	struct cxl_mbox_cmd mbox_cmd;
> @@ -559,23 +563,24 @@ static int cxl_event_config_msgnums(struct cxl_dev_state *cxlds,
>   		.size_in = sizeof(*policy),
>   	};
>   
> -	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
>   	if (rc < 0) {
> -		dev_err(cxlds->dev, "Failed to set event interrupt policy : %d",
> +		dev_err(mds->cxlds.dev, "Failed to set event interrupt policy : %d",
>   			rc);
>   		return rc;
>   	}
>   
>   	/* Retrieve final interrupt settings */
> -	return cxl_event_get_int_policy(cxlds, policy);
> +	return cxl_event_get_int_policy(mds, policy);
>   }
>   
> -static int cxl_event_irqsetup(struct cxl_dev_state *cxlds)
> +static int cxl_event_irqsetup(struct cxl_memdev_state *mds)
>   {
> +	struct cxl_dev_state *cxlds = &mds->cxlds;
>   	struct cxl_event_interrupt_policy policy;
>   	int rc;
>   
> -	rc = cxl_event_config_msgnums(cxlds, &policy);
> +	rc = cxl_event_config_msgnums(mds, &policy);
>   	if (rc)
>   		return rc;
>   
> @@ -614,7 +619,7 @@ static bool cxl_event_int_is_fw(u8 setting)
>   }
>   
>   static int cxl_event_config(struct pci_host_bridge *host_bridge,
> -			    struct cxl_dev_state *cxlds)
> +			    struct cxl_memdev_state *mds)
>   {
>   	struct cxl_event_interrupt_policy policy;
>   	int rc;
> @@ -626,11 +631,11 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
>   	if (!host_bridge->native_cxl_error)
>   		return 0;
>   
> -	rc = cxl_mem_alloc_event_buf(cxlds);
> +	rc = cxl_mem_alloc_event_buf(mds);
>   	if (rc)
>   		return rc;
>   
> -	rc = cxl_event_get_int_policy(cxlds, &policy);
> +	rc = cxl_event_get_int_policy(mds, &policy);
>   	if (rc)
>   		return rc;
>   
> @@ -638,15 +643,16 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
>   	    cxl_event_int_is_fw(policy.warn_settings) ||
>   	    cxl_event_int_is_fw(policy.failure_settings) ||
>   	    cxl_event_int_is_fw(policy.fatal_settings)) {
> -		dev_err(cxlds->dev, "FW still in control of Event Logs despite _OSC settings\n");
> +		dev_err(mds->cxlds.dev,
> +			"FW still in control of Event Logs despite _OSC settings\n");
>   		return -EBUSY;
>   	}
>   
> -	rc = cxl_event_irqsetup(cxlds);
> +	rc = cxl_event_irqsetup(mds);
>   	if (rc)
>   		return rc;
>   
> -	cxl_mem_get_event_records(cxlds, CXLDEV_EVENT_STATUS_ALL);
> +	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL);
>   
>   	return 0;
>   }
> @@ -654,9 +660,10 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
>   static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   {
>   	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
> +	struct cxl_memdev_state *mds;
> +	struct cxl_dev_state *cxlds;
>   	struct cxl_register_map map;
>   	struct cxl_memdev *cxlmd;
> -	struct cxl_dev_state *cxlds;
>   	int rc;
>   
>   	/*
> @@ -671,9 +678,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   		return rc;
>   	pci_set_master(pdev);
>   
> -	cxlds = cxl_dev_state_create(&pdev->dev);
> -	if (IS_ERR(cxlds))
> -		return PTR_ERR(cxlds);
> +	mds = cxl_memdev_state_create(&pdev->dev);
> +	if (IS_ERR(mds))
> +		return PTR_ERR(mds);
> +	cxlds = &mds->cxlds;
>   	pci_set_drvdata(pdev, cxlds);
>   
>   	cxlds->rcd = is_cxl_restricted(pdev);
> @@ -714,27 +722,27 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	else
>   		dev_warn(&pdev->dev, "Media not active (%d)\n", rc);
>   
> -	rc = cxl_pci_setup_mailbox(cxlds);
> +	rc = cxl_pci_setup_mailbox(mds);
>   	if (rc)
>   		return rc;
>   
> -	rc = cxl_enumerate_cmds(cxlds);
> +	rc = cxl_enumerate_cmds(mds);
>   	if (rc)
>   		return rc;
>   
> -	rc = cxl_set_timestamp(cxlds);
> +	rc = cxl_set_timestamp(mds);
>   	if (rc)
>   		return rc;
>   
> -	rc = cxl_poison_state_init(cxlds);
> +	rc = cxl_poison_state_init(mds);
>   	if (rc)
>   		return rc;
>   
> -	rc = cxl_dev_state_identify(cxlds);
> +	rc = cxl_dev_state_identify(mds);
>   	if (rc)
>   		return rc;
>   
> -	rc = cxl_mem_create_range_info(cxlds);
> +	rc = cxl_mem_create_range_info(mds);
>   	if (rc)
>   		return rc;
>   
> @@ -746,7 +754,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	if (IS_ERR(cxlmd))
>   		return PTR_ERR(cxlmd);
>   
> -	rc = cxl_event_config(host_bridge, cxlds);
> +	rc = cxl_event_config(host_bridge, mds);
>   	if (rc)
>   		return rc;
>   
> diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
> index 71cfa1fdf902..7cb8994f8809 100644
> --- a/drivers/cxl/pmem.c
> +++ b/drivers/cxl/pmem.c
> @@ -15,9 +15,9 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
>   
>   static __read_mostly DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
>   
> -static void clear_exclusive(void *cxlds)
> +static void clear_exclusive(void *mds)
>   {
> -	clear_exclusive_cxl_commands(cxlds, exclusive_cmds);
> +	clear_exclusive_cxl_commands(mds, exclusive_cmds);
>   }
>   
>   static void unregister_nvdimm(void *nvdimm)
> @@ -65,13 +65,13 @@ static int cxl_nvdimm_probe(struct device *dev)
>   	struct cxl_nvdimm *cxl_nvd = to_cxl_nvdimm(dev);
>   	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
>   	struct cxl_nvdimm_bridge *cxl_nvb = cxlmd->cxl_nvb;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>   	unsigned long flags = 0, cmd_mask = 0;
> -	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>   	struct nvdimm *nvdimm;
>   	int rc;
>   
> -	set_exclusive_cxl_commands(cxlds, exclusive_cmds);
> -	rc = devm_add_action_or_reset(dev, clear_exclusive, cxlds);
> +	set_exclusive_cxl_commands(mds, exclusive_cmds);
> +	rc = devm_add_action_or_reset(dev, clear_exclusive, mds);
>   	if (rc)
>   		return rc;
>   
> @@ -100,22 +100,23 @@ static struct cxl_driver cxl_nvdimm_driver = {
>   	},
>   };
>   
> -static int cxl_pmem_get_config_size(struct cxl_dev_state *cxlds,
> +static int cxl_pmem_get_config_size(struct cxl_memdev_state *mds,
>   				    struct nd_cmd_get_config_size *cmd,
>   				    unsigned int buf_len)
>   {
>   	if (sizeof(*cmd) > buf_len)
>   		return -EINVAL;
>   
> -	*cmd = (struct nd_cmd_get_config_size) {
> -		 .config_size = cxlds->lsa_size,
> -		 .max_xfer = cxlds->payload_size - sizeof(struct cxl_mbox_set_lsa),
> +	*cmd = (struct nd_cmd_get_config_size){
> +		.config_size = mds->lsa_size,
> +		.max_xfer =
> +			mds->payload_size - sizeof(struct cxl_mbox_set_lsa),
>   	};
>   
>   	return 0;
>   }
>   
> -static int cxl_pmem_get_config_data(struct cxl_dev_state *cxlds,
> +static int cxl_pmem_get_config_data(struct cxl_memdev_state *mds,
>   				    struct nd_cmd_get_config_data_hdr *cmd,
>   				    unsigned int buf_len)
>   {
> @@ -140,13 +141,13 @@ static int cxl_pmem_get_config_data(struct cxl_dev_state *cxlds,
>   		.payload_out = cmd->out_buf,
>   	};
>   
> -	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
>   	cmd->status = 0;
>   
>   	return rc;
>   }
>   
> -static int cxl_pmem_set_config_data(struct cxl_dev_state *cxlds,
> +static int cxl_pmem_set_config_data(struct cxl_memdev_state *mds,
>   				    struct nd_cmd_set_config_hdr *cmd,
>   				    unsigned int buf_len)
>   {
> @@ -176,7 +177,7 @@ static int cxl_pmem_set_config_data(struct cxl_dev_state *cxlds,
>   		.size_in = struct_size(set_lsa, data, cmd->in_length),
>   	};
>   
> -	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
>   
>   	/*
>   	 * Set "firmware" status (4-packed bytes at the end of the input
> @@ -194,18 +195,18 @@ static int cxl_pmem_nvdimm_ctl(struct nvdimm *nvdimm, unsigned int cmd,
>   	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
>   	unsigned long cmd_mask = nvdimm_cmd_mask(nvdimm);
>   	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
> -	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>   
>   	if (!test_bit(cmd, &cmd_mask))
>   		return -ENOTTY;
>   
>   	switch (cmd) {
>   	case ND_CMD_GET_CONFIG_SIZE:
> -		return cxl_pmem_get_config_size(cxlds, buf, buf_len);
> +		return cxl_pmem_get_config_size(mds, buf, buf_len);
>   	case ND_CMD_GET_CONFIG_DATA:
> -		return cxl_pmem_get_config_data(cxlds, buf, buf_len);
> +		return cxl_pmem_get_config_data(mds, buf, buf_len);
>   	case ND_CMD_SET_CONFIG_DATA:
> -		return cxl_pmem_set_config_data(cxlds, buf, buf_len);
> +		return cxl_pmem_set_config_data(mds, buf, buf_len);
>   	default:
>   		return -ENOTTY;
>   	}
> diff --git a/drivers/cxl/security.c b/drivers/cxl/security.c
> index 4ad4bda2d18e..8c98fc674fa7 100644
> --- a/drivers/cxl/security.c
> +++ b/drivers/cxl/security.c
> @@ -14,7 +14,7 @@ static unsigned long cxl_pmem_get_security_flags(struct nvdimm *nvdimm,
>   {
>   	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
>   	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
> -	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>   	unsigned long security_flags = 0;
>   	struct cxl_get_security_output {
>   		__le32 flags;
> @@ -29,7 +29,7 @@ static unsigned long cxl_pmem_get_security_flags(struct nvdimm *nvdimm,
>   		.payload_out = &out,
>   	};
>   
> -	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
>   	if (rc < 0)
>   		return 0;
>   
> @@ -67,7 +67,7 @@ static int cxl_pmem_security_change_key(struct nvdimm *nvdimm,
>   {
>   	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
>   	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
> -	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>   	struct cxl_mbox_cmd mbox_cmd;
>   	struct cxl_set_pass set_pass;
>   
> @@ -84,7 +84,7 @@ static int cxl_pmem_security_change_key(struct nvdimm *nvdimm,
>   		.payload_in = &set_pass,
>   	};
>   
> -	return cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +	return cxl_internal_send_cmd(mds, &mbox_cmd);
>   }
>   
>   static int __cxl_pmem_security_disable(struct nvdimm *nvdimm,
> @@ -93,7 +93,7 @@ static int __cxl_pmem_security_disable(struct nvdimm *nvdimm,
>   {
>   	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
>   	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
> -	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>   	struct cxl_disable_pass dis_pass;
>   	struct cxl_mbox_cmd mbox_cmd;
>   
> @@ -109,7 +109,7 @@ static int __cxl_pmem_security_disable(struct nvdimm *nvdimm,
>   		.payload_in = &dis_pass,
>   	};
>   
> -	return cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +	return cxl_internal_send_cmd(mds, &mbox_cmd);
>   }
>   
>   static int cxl_pmem_security_disable(struct nvdimm *nvdimm,
> @@ -128,12 +128,12 @@ static int cxl_pmem_security_freeze(struct nvdimm *nvdimm)
>   {
>   	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
>   	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
> -	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>   	struct cxl_mbox_cmd mbox_cmd = {
>   		.opcode = CXL_MBOX_OP_FREEZE_SECURITY,
>   	};
>   
> -	return cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +	return cxl_internal_send_cmd(mds, &mbox_cmd);
>   }
>   
>   static int cxl_pmem_security_unlock(struct nvdimm *nvdimm,
> @@ -141,7 +141,7 @@ static int cxl_pmem_security_unlock(struct nvdimm *nvdimm,
>   {
>   	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
>   	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
> -	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>   	u8 pass[NVDIMM_PASSPHRASE_LEN];
>   	struct cxl_mbox_cmd mbox_cmd;
>   	int rc;
> @@ -153,7 +153,7 @@ static int cxl_pmem_security_unlock(struct nvdimm *nvdimm,
>   		.payload_in = pass,
>   	};
>   
> -	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
>   	if (rc < 0)
>   		return rc;
>   
> @@ -166,7 +166,7 @@ static int cxl_pmem_security_passphrase_erase(struct nvdimm *nvdimm,
>   {
>   	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
>   	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
> -	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>   	struct cxl_mbox_cmd mbox_cmd;
>   	struct cxl_pass_erase erase;
>   	int rc;
> @@ -182,7 +182,7 @@ static int cxl_pmem_security_passphrase_erase(struct nvdimm *nvdimm,
>   		.payload_in = &erase,
>   	};
>   
> -	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
>   	if (rc < 0)
>   		return rc;
>   
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index bdaf086d994e..6fb5718588f3 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -102,7 +102,7 @@ struct mock_event_log {
>   };
>   
>   struct mock_event_store {
> -	struct cxl_dev_state *cxlds;
> +	struct cxl_memdev_state *mds;
>   	struct mock_event_log mock_logs[CXL_EVENT_TYPE_MAX];
>   	u32 ev_status;
>   };
> @@ -291,7 +291,7 @@ static void cxl_mock_event_trigger(struct device *dev)
>   			event_reset_log(log);
>   	}
>   
> -	cxl_mem_get_event_records(mes->cxlds, mes->ev_status);
> +	cxl_mem_get_event_records(mes->mds, mes->ev_status);
>   }
>   
>   struct cxl_event_record_raw maint_needed = {
> @@ -451,7 +451,7 @@ static int mock_gsl(struct cxl_mbox_cmd *cmd)
>   	return 0;
>   }
>   
> -static int mock_get_log(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
> +static int mock_get_log(struct cxl_memdev_state *mds, struct cxl_mbox_cmd *cmd)
>   {
>   	struct cxl_mbox_get_log *gl = cmd->payload_in;
>   	u32 offset = le32_to_cpu(gl->offset);
> @@ -461,7 +461,7 @@ static int mock_get_log(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
>   
>   	if (cmd->size_in < sizeof(*gl))
>   		return -EINVAL;
> -	if (length > cxlds->payload_size)
> +	if (length > mds->payload_size)
>   		return -EINVAL;
>   	if (offset + length > sizeof(mock_cel))
>   		return -EINVAL;
> @@ -1105,8 +1105,10 @@ static struct attribute *cxl_mock_mem_core_attrs[] = {
>   };
>   ATTRIBUTE_GROUPS(cxl_mock_mem_core);
>   
> -static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
> +static int cxl_mock_mbox_send(struct cxl_memdev_state *mds,
> +			      struct cxl_mbox_cmd *cmd)
>   {
> +	struct cxl_dev_state *cxlds = &mds->cxlds;
>   	struct device *dev = cxlds->dev;
>   	struct cxl_mockmem_data *mdata = dev_get_drvdata(dev);
>   	int rc = -EIO;
> @@ -1119,7 +1121,7 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
>   		rc = mock_gsl(cmd);
>   		break;
>   	case CXL_MBOX_OP_GET_LOG:
> -		rc = mock_get_log(cxlds, cmd);
> +		rc = mock_get_log(mds, cmd);
>   		break;
>   	case CXL_MBOX_OP_IDENTIFY:
>   		if (cxlds->rcd)
> @@ -1207,6 +1209,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>   {
>   	struct device *dev = &pdev->dev;
>   	struct cxl_memdev *cxlmd;
> +	struct cxl_memdev_state *mds;
>   	struct cxl_dev_state *cxlds;
>   	struct cxl_mockmem_data *mdata;
>   	int rc;
> @@ -1223,48 +1226,50 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>   	if (rc)
>   		return rc;
>   
> -	cxlds = cxl_dev_state_create(dev);
> -	if (IS_ERR(cxlds))
> -		return PTR_ERR(cxlds);
> +	mds = cxl_memdev_state_create(dev);
> +	if (IS_ERR(mds))
> +		return PTR_ERR(mds);
> +
> +	mds->mbox_send = cxl_mock_mbox_send;
> +	mds->payload_size = SZ_4K;
> +	mds->event.buf = (struct cxl_get_event_payload *) mdata->event_buf;
>   
> +	cxlds = &mds->cxlds;
>   	cxlds->serial = pdev->id;
> -	cxlds->mbox_send = cxl_mock_mbox_send;
> -	cxlds->payload_size = SZ_4K;
> -	cxlds->event.buf = (struct cxl_get_event_payload *) mdata->event_buf;
>   	if (is_rcd(pdev)) {
>   		cxlds->rcd = true;
>   		cxlds->component_reg_phys = CXL_RESOURCE_NONE;
>   	}
>   
> -	rc = cxl_enumerate_cmds(cxlds);
> +	rc = cxl_enumerate_cmds(mds);
>   	if (rc)
>   		return rc;
>   
> -	rc = cxl_poison_state_init(cxlds);
> +	rc = cxl_poison_state_init(mds);
>   	if (rc)
>   		return rc;
>   
> -	rc = cxl_set_timestamp(cxlds);
> +	rc = cxl_set_timestamp(mds);
>   	if (rc)
>   		return rc;
>   
>   	cxlds->media_ready = true;
> -	rc = cxl_dev_state_identify(cxlds);
> +	rc = cxl_dev_state_identify(mds);
>   	if (rc)
>   		return rc;
>   
> -	rc = cxl_mem_create_range_info(cxlds);
> +	rc = cxl_mem_create_range_info(mds);
>   	if (rc)
>   		return rc;
>   
> -	mdata->mes.cxlds = cxlds;
> +	mdata->mes.mds = mds;
>   	cxl_mock_add_event_logs(&mdata->mes);
>   
>   	cxlmd = devm_cxl_add_memdev(cxlds);
>   	if (IS_ERR(cxlmd))
>   		return PTR_ERR(cxlmd);
>   
> -	cxl_mem_get_event_records(cxlds, CXLDEV_EVENT_STATUS_ALL);
> +	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL);
>   
>   	return 0;
>   }
>
