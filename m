Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4819BC6FA8E
	for <linux-cxl@archiver.kernel.org>; Fri,  3 Mar 2023 00:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjCCAvK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Mar 2023 19:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjCCAvJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 2 Mar 2023 19:51:09 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6C8D166D1
        for <linux-cxl@vger.kernel.org>; Thu,  2 Mar 2023 16:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677804667; x=1709340667;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0UKFvzgrYmeFdPOAwsR8eer0iLUVhAuqs2IWh6XkwAE=;
  b=TyCDxRjJQnlldSYzQgpSvOR9wMVukbSZm/s/PLc454bIv8iB7Iv1HloL
   BiOVIvV8D1Nxv1skfKiVOyjk4HXHZLDvgMzCNFwIpU9kjcZo2JlbmS8C9
   ZU4fewCbJKmuOEmVetRbUpEkf7Tek1J7Lq7xSNeCX9OY2AD+QQD3cIUXD
   ZmyIfUnVA71mb2sp3W2T9Xksm8DDs7uIvWEHr41S2Ww7jaL+5Mx3dUsXW
   3AQPARhxImZ7Xr4gAZdY73nMsw5h8lIS7ZTcbmeqAsimT4SQ3Vxb7dHoN
   lCGGSPrLrrLKMgUzZn/Wnnbntu8qOwn/l/Fl8jUsqdSKzrFvM3DHnXJ6N
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="318730290"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="318730290"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 16:51:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="705470930"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="705470930"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 02 Mar 2023 16:51:07 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 16:51:06 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 2 Mar 2023 16:51:06 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 2 Mar 2023 16:51:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=goIDFhfJj5tchdMwdtiYcE3x/S+0kFURYvoqsUy9JQn7QGDxMy6+5JNFDA5JMOWKqlQp9EiP/hE2SKUKz1EJNVmcBvI6AZUoDS32QNUlsIRHTugw+QeRPFB3TrTy4ljpXKgoVKMy8c4elH6RqT74EIGVdo9wFs6z5eZaETyQmR1ZD3ckoNc8z7jglOguBlfq9T+H6ZIhWmFsnaVKuEEv6PaQ5NF8DJYyr/VE9c/CQCdhRj0OJupOk9rF/kZ0FM7bNRowj9MyTTcymAhHxj18WWLLnH9wU3t/JRQx3ZdUkoh7zvMBMr4baJX1Ki8ZRT1Af3Y83OX/UPaEK1fyvJ9HHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2VMO+CngYEq8ReU0Cuulm2Q1ZALk1wR7oYZSZ5RVcQ4=;
 b=D4Y/5CyscNtxMPGsLmhqIk0nK2Dw5zOAFUGMF00Un3wmx9SqqOXs9fKKHle3Kjq/RrQTPm6+albxFRIVWVgYbEOjz74C0jDdnhcz5wvGRCXLN7ntYdC8pN2zi9mSYdJIPCfJTU4l8S5PIFVkJeJSE6YP1o4b1Y0M/37imj0tmEn9h4Xvzf+fmu1JPi3rXFuHziyE5UUfRArmEJaaJ0ZY93YBney49nSkSgL44YwbC30Iw5WVMm3izCkf4IW3Rpdg/3IPexyV0tmI4insMEt4NSXAalWQ+edIfxfoEtYehEElWdJ9I2i15PFOT0qQfPBbA1h0vdpCl6IUQu4ujcLNgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS0PR11MB8020.namprd11.prod.outlook.com (2603:10b6:8:114::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.29; Fri, 3 Mar
 2023 00:50:58 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff%7]) with mapi id 15.20.6156.019; Fri, 3 Mar 2023
 00:50:58 +0000
Date:   Thu, 2 Mar 2023 16:50:53 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>
CC:     <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Michael Roth" <michael.roth@amd.com>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3 4/6] hw/cxl: QMP based poison injection support
Message-ID: <6401446d8d8dc_46c602942@iweiny-mobl.notmuch>
References: <20230302101710.1652-1-Jonathan.Cameron@huawei.com>
 <20230302101710.1652-5-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230302101710.1652-5-Jonathan.Cameron@huawei.com>
X-ClientProxiedBy: BYAPR11CA0093.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::34) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS0PR11MB8020:EE_
X-MS-Office365-Filtering-Correlation-Id: a4a7b2c6-dbf5-4f36-450a-08db1b815a21
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8WaR6/5xBnqPyKY/Qrajb32jXNLAe7vA5usbV+6OXpp2blb5hJbxU/g1NOLNWpWnv08xhxVon06APqhTH9iBWjaEdAzsCg1BsRqKgh+uoB66ux1fcDyamJK4iS1keVCntNaldj0DsOCsMCoCCvNn3V9vP3VtbQSlpk1UrypnRhWrv5DDD7cXbUZN0/VEP0IyO+o4Vn0HhqAukF0sObVYgoX0ATAeYq7hXAUtLWyOKVV5y/sQO3Df4AAthpUNHRMvaycZUHzb9DnFVeebodP18jYDcUlinqhujAdyisTXShubDtqNhzYuppz1rlF4TpXHru1Ithmet476Qf1QG7bPWty6elYjIppJjEyJQ+grZgoO5vZv9iNJw/HhyxAHsuwMZ2sJ/XIyiF8zT1XKp4Px9/ApiNohZzOzNfo5ozc9m0afslSx6OZ19JLO56UM17tCC2rmzevnP1aM2tNmduSRdfkgLy9Figpn9DVxytzv8h+JMtRFc0k2TmCZjlAd1yl+cqJ+iy8nXDhU9lksrmGzM2zPbGSwVpOQNlnFJ3JuRITs73PSjNm7DEUgPcGNafG1aDVjDMWvBp0XRpzpSwXlIxLyUHMRsl0ub4XyNh3X4+5NXVW0wjwESJax5iWcPaXR
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(346002)(376002)(39860400002)(136003)(396003)(451199018)(966005)(86362001)(6486002)(26005)(54906003)(41300700001)(44832011)(66476007)(4326008)(66556008)(66946007)(316002)(478600001)(5660300002)(110136005)(2906002)(6666004)(6512007)(8676002)(82960400001)(8936002)(38100700002)(6506007)(83380400001)(66899018)(9686003)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MSOfdJzEwvzabmenWkHJWzRdHK93vazHSh7qdp7FV32TQgyCWY/9wVfF4aoP?=
 =?us-ascii?Q?D4cKmZXrQQR5GIOpGOl/nbzDNbTgc3oAZ7cqN+YYZiRUNYcCmP/PMJkPPtz7?=
 =?us-ascii?Q?7sAGzwnsjHZmTDUUOlWvzCR9sLQ7p8mQWDZH0n4hq0608AWuItlCavTEeZ8N?=
 =?us-ascii?Q?SkB11L93Bt444428WM1CxuPFnGZ0LP6o9B7NTTeCxJ274Npj1OhgJv6iUG1i?=
 =?us-ascii?Q?HlOpU3DJwdvZeu80QBmtOCMDaeMjwPMO6aiP7XWSa4K3wI8xk7EhB/sw5gjG?=
 =?us-ascii?Q?nk9n5Z/WWP//HelkseCW7h11O/CDcAqgqkXv9abvBxRY3LZ2nvgHe8m2d9d6?=
 =?us-ascii?Q?OKMofxXHurBfePFcbL/VPYbc4oMYQfDBcueAkk3+cT4ml4NkMc3PdNG9jWUI?=
 =?us-ascii?Q?GPxa4hOlGW/r0J4BpQNBa7PaMhgWfI75YtU3q4lZMNmNOGigmr7bgl8vMKtB?=
 =?us-ascii?Q?lwSdvEGUWsoYi5hWvTJMFV3bOIIhaFfFo9xRMOTsYQjF7ixrz0EINWSdyyXb?=
 =?us-ascii?Q?2OwcLhlmtRkz5Dq35Fe/YHKhWGBSyxxY7vleLXmQ+iNQ4K9NI8+vj2NVjcfN?=
 =?us-ascii?Q?LJJVqTMMnK0+vlP+dbSX8BRA/kATMzF3uEaYdGk8BkRS4MVJo9eC8HR4CK4U?=
 =?us-ascii?Q?UqOtUriBFpnVz1sRlN/8kCGkg6SzF11QLysBIhb7BfqQuS/2bba6uMabvsFc?=
 =?us-ascii?Q?aSUEaU9RwKsXqtFfI6Isizk/+I/0D2v3EiMN5juOdLwHD14vMP5FIM3RXiC6?=
 =?us-ascii?Q?N201BRijEq4Y4AmHw0UlLJvlzetQasz0OZL7TutkF7Hu/AWirlA92oW7xWUe?=
 =?us-ascii?Q?+ZuKLg+ehZvIA6uMqXwqoKtq4n3Rb34rTTyA4wfdJi508h0MWOQfUztsl6sC?=
 =?us-ascii?Q?TGrOzcYGJs6XBITUXh30asUB4coWhuqh2ErRhEeANa2rnqW6UF3NM+F+Y4vX?=
 =?us-ascii?Q?ay5CS7qoUiPmkuyvkiYpByl16ahYeoejiRKvmtw/LA+XTQRPbR4niaGY67VD?=
 =?us-ascii?Q?AP7qoqMszTyWZIFyrNfZNoB8SEfe0MkehFhEKTXie/sf1xNa3cAoqP7DdAwC?=
 =?us-ascii?Q?VtJ56hOFFUAYKU30Cg34Phz+wkjvmnYSTg/Lfp8Xulzr1EfW7ZPTH0P6OYJD?=
 =?us-ascii?Q?c2yswXzSbAB5lvioYWW4rXF4wCEB9xcfNdN/nUXWAh3Olt4u2fCNHp6g8wkr?=
 =?us-ascii?Q?kF+sEX6kjNIUkDu94RNHtV9pMJlyhZuACcIg6KL/5VrrC5KcKZbMGiWuQwTC?=
 =?us-ascii?Q?8N4Y9AbJQNEtEdBQNH6C5/ZIYwbBrhIoVtnygev5Lj+JWwXkRQziDmicqshY?=
 =?us-ascii?Q?o9S2wRO8Twjt6RkxCDcwgjas5BaGMTSPJ2cddv2sAtct6QLgD4HT23r7h7HY?=
 =?us-ascii?Q?U4rWv4y9KT0H8oeCqRziKUbd71fdLyOJnGkZe5dXPiifFYL7QvQ3ELckkNZm?=
 =?us-ascii?Q?QHQaqWSsr6CIWpDmUcx4dfukB9jDjp/jYOaR/aVCixTUL7l4uAL9XZobEh8x?=
 =?us-ascii?Q?1RK/yzNj9MZtfd3jWzQZzqnajtD+TLalFnER4PJ7W4mV/7MsCPfalYg3r5eL?=
 =?us-ascii?Q?RL8XKebTMFCaGDz+YMBuAwIpJjf2OdxNxKyZ5QBV?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a7b2c6-dbf5-4f36-450a-08db1b815a21
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 00:50:58.2260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GhgVLlWqwZtO1ihs/3VY5azJED/Rtxk2EFQZ29ikd96GNAW+rrqQGlzAsQp+BrWvShUGGhuCSRsgQHrkeA20aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8020
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> Inject poison using qmp command cxl-inject-poison to add an entry to the
> poison list.
> 
> For now, the poison is not returned CXL.mem reads, but only via the
> mailbox command Get Poison List.
> 
> See CXL rev 3.0, sec 8.2.9.8.4.1 Get Poison list (Opcode 4300h)
> 
> Kernel patches to use this interface here:
> https://lore.kernel.org/linux-cxl/cover.1665606782.git.alison.schofield@intel.com/
> 
> To inject poison using qmp (telnet to the qmp port)
> { "execute": "qmp_capabilities" }
> 
> { "execute": "cxl-inject-poison",
>     "arguments": {
>          "path": "/machine/peripheral/cxl-pmem0",
>          "start": 2048,
>          "length": 256
>     }
> }
> 
> Adjusted to select a device on your machine.
> 
> Note that the poison list supported is kept short enough to avoid the
> complexity of state machine that is needed to handle the MORE flag.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> v2:
> Improve QMP documentation.
> Fix up some endian issues

[...]

> +/*
> + * This is very inefficient, but good enough for now!
> + * Also the payload will always fit, so no need to handle the MORE flag and
> + * make this stateful. We may want to allow longer poison lists to aid
> + * testing that kernel functionality.
> + */
> +static CXLRetCode cmd_media_get_poison_list(struct cxl_cmd *cmd,
> +                                            CXLDeviceState *cxl_dstate,
> +                                            uint16_t *len)
> +{
> +    struct get_poison_list_pl {
> +        uint64_t pa;
> +        uint64_t length;
> +    } QEMU_PACKED;
> +
> +    struct get_poison_list_out_pl {
> +        uint8_t flags;
> +        uint8_t rsvd1;
> +        uint64_t overflow_timestamp;
> +        uint16_t count;
> +        uint8_t rsvd2[0x14];
> +        struct {
> +            uint64_t addr;
> +            uint32_t length;
> +            uint32_t resv;
> +        } QEMU_PACKED records[];
> +    } QEMU_PACKED;
> +
> +    struct get_poison_list_pl *in = (void *)cmd->payload;
> +    struct get_poison_list_out_pl *out = (void *)cmd->payload;
> +    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
> +    uint16_t record_count = 0, i = 0;
> +    uint64_t query_start, query_length;
> +    CXLPoisonList *poison_list = &ct3d->poison_list;
> +    CXLPoison *ent;
> +    uint16_t out_pl_len;
> +
> +    query_start = ldq_le_p(&in->pa);
> +    /* 64 byte alignemnt required */
> +    if (query_start & 0x3f) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +    query_length = ldq_le_p(&in->length) * 64;
> +
> +    QLIST_FOREACH(ent, poison_list, node) {
> +        /* Check for no overlap */
> +        if (ent->start >= query_start + query_length ||
> +            ent->start + ent->length <= query_start) {
> +            continue;
> +        }
> +        record_count++;
> +    }
> +    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
> +    assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
> +
> +    memset(out, 0, out_pl_len);
> +    QLIST_FOREACH(ent, poison_list, node) {
> +        uint64_t start, stop;
> +
> +        /* Check for no overlap */
> +        if (ent->start >= query_start + query_length ||
> +            ent->start + ent->length <= query_start) {
> +            continue;
> +        }
> +
> +        /* Deal with overlap */
> +        start = MAX(ent->start & 0xffffffffffffffc0, query_start);
> +        stop = MIN((ent->start & 0xffffffffffffffc0) + ent->length,
> +                   query_start + query_length);
> +        stq_le_p(&out->records[i].addr, start | (ent->type & 0x3));

Shouldn't the mask here be 0x7?  I see we have not define Vendor Specific
which I think is good but maybe better to allow it here?  I'm just not
sure what is going to happen if someone comes along later and wants to
use that value.

Ira

> +        stl_le_p(&out->records[i].length, (stop - start) / 64);
> +        i++;
> +    }
> +    if (ct3d->poison_list_overflowed) {
> +        out->flags = (1 << 1);
> +        stq_le_p(&out->overflow_timestamp, ct3d->poison_list_overflow_ts);
> +    }
> +    stw_le_p(&out->count, record_count);
> +    *len = out_pl_len;
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
>  #define IMMEDIATE_DATA_CHANGE (1 << 2)
>  #define IMMEDIATE_POLICY_CHANGE (1 << 3)
> @@ -411,6 +499,8 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
>      [CCLS][GET_LSA] = { "CCLS_GET_LSA", cmd_ccls_get_lsa, 8, 0 },
>      [CCLS][SET_LSA] = { "CCLS_SET_LSA", cmd_ccls_set_lsa,
>          ~0, IMMEDIATE_CONFIG_CHANGE | IMMEDIATE_DATA_CHANGE },
> +    [MEDIA_AND_POISON][GET_POISON_LIST] = { "MEDIA_AND_POISON_GET_POISON_LIST",
> +        cmd_media_get_poison_list, 16, 0 },
>  };
>  
>  void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 572ad47fa2..21e3a84785 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -919,6 +919,62 @@ static void set_lsa(CXLType3Dev *ct3d, const void *buf, uint64_t size,
>       */
>  }
>  
> +void cxl_set_poison_list_overflowed(CXLType3Dev *ct3d)
> +{
> +        ct3d->poison_list_overflowed = true;
> +        ct3d->poison_list_overflow_ts =
> +            cxl_device_get_timestamp(&ct3d->cxl_dstate);
> +}
> +
> +void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
> +                           Error **errp)
> +{
> +    Object *obj = object_resolve_path(path, NULL);
> +    CXLType3Dev *ct3d;
> +    CXLPoison *p;
> +
> +    if (length % 64) {
> +        error_setg(errp, "Poison injection must be in multiples of 64 bytes");
> +        return;
> +    }
> +    if (start % 64) {
> +        error_setg(errp, "Poison start address must be 64 byte aligned");
> +        return;
> +    }
> +    if (!obj) {
> +        error_setg(errp, "Unable to resolve path");
> +        return;
> +    }
> +    if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
> +        error_setg(errp, "Path does not point to a CXL type 3 device");
> +        return;
> +    }
> +
> +    ct3d = CXL_TYPE3(obj);
> +
> +    QLIST_FOREACH(p, &ct3d->poison_list, node) {
> +        if (((start >= p->start) && (start < p->start + p->length)) ||
> +            ((start + length > p->start) &&
> +             (start + length <= p->start + p->length))) {
> +            error_setg(errp, "Overlap with existing poisoned region not supported");
> +            return;
> +        }
> +    }
> +
> +    if (ct3d->poison_list_cnt == CXL_POISON_LIST_LIMIT) {
> +        cxl_set_poison_list_overflowed(ct3d);
> +        return;
> +    }
> +
> +    p = g_new0(CXLPoison, 1);
> +    p->length = length;
> +    p->start = start;
> +    p->type = CXL_POISON_TYPE_INTERNAL; /* Different from injected via the mbox */
> +
> +    QLIST_INSERT_HEAD(&ct3d->poison_list, p, node);
> +    ct3d->poison_list_cnt++;
> +}
> +
>  /* For uncorrectable errors include support for multiple header recording */
>  void qmp_cxl_inject_uncorrectable_errors(const char *path,
>                                           CXLUncorErrorRecordList *errors,
> diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
> index d574c58f9a..fd1166a610 100644
> --- a/hw/mem/cxl_type3_stubs.c
> +++ b/hw/mem/cxl_type3_stubs.c
> @@ -3,6 +3,12 @@
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-cxl.h"
>  
> +void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
> +                           Error **errp)
> +{
> +    error_setg(errp, "CXL Type 3 support is not compiled in");
> +}
> +
>  void qmp_cxl_inject_uncorrectable_errors(const char *path,
>                                           CXLUncorErrorRecordList *errors,
>                                           Error **errp)
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 02befda0f6..32c234ea91 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -242,6 +242,18 @@ typedef struct CXLError {
>  
>  typedef QTAILQ_HEAD(, CXLError) CXLErrorList;
>  
> +typedef struct CXLPoison {
> +    uint64_t start, length;
> +    uint8_t type;
> +#define CXL_POISON_TYPE_EXTERNAL 0x1
> +#define CXL_POISON_TYPE_INTERNAL 0x2
> +#define CXL_POISON_TYPE_INJECTED 0x3
> +    QLIST_ENTRY(CXLPoison) node;
> +} CXLPoison;
> +
> +typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
> +#define CXL_POISON_LIST_LIMIT 256
> +
>  struct CXLType3Dev {
>      /* Private */
>      PCIDevice parent_obj;
> @@ -264,6 +276,12 @@ struct CXLType3Dev {
>  
>      /* Error injection */
>      CXLErrorList error_list;
> +
> +    /* Poison Injection - cache */
> +    CXLPoisonList poison_list;
> +    unsigned int poison_list_cnt;
> +    bool poison_list_overflowed;
> +    uint64_t poison_list_overflow_ts;
>  };
>  
>  #define TYPE_CXL_TYPE3 "cxl-type3"
> @@ -289,4 +307,6 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
>  
>  uint64_t cxl_device_get_timestamp(CXLDeviceState *cxlds);
>  
> +void cxl_set_poison_list_overflowed(CXLType3Dev *ct3d);
> +
>  #endif
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 4be7d46041..9ebd680dfe 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -5,6 +5,24 @@
>  # = CXL devices
>  ##
>  
> +##
> +# @cxl-inject-poison:
> +#
> +# Poison records indicate that a CXL memory device knows that a particular
> +# memory region may be corrupted. This may be because of locally detected
> +# errors (e.g. ECC failure) or poisoned writes received from other components
> +# in the system. This injection mechanism enables testing of the OS handling
> +# of poison records which may be queried via the CXL mailbox.
> +#
> +# @path: CXL type 3 device canonical QOM path
> +# @start: Start address - must be 64 byte aligned.
> +# @length: Length of poison to inject - must be a multiple of 64 bytes.
> +#
> +# Since: 8.0
> +##
> +{ 'command': 'cxl-inject-poison',
> +  'data': { 'path': 'str', 'start': 'uint64', 'length': 'uint64' }}
> +
>  ##
>  # @CxlUncorErrorType:
>  #
> -- 
> 2.37.2
> 


