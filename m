Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5FAC7EE2F
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Mar 2023 06:38:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjCBGi5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Mar 2023 01:38:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjCBGi4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 2 Mar 2023 01:38:56 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FDA149A6
        for <linux-cxl@vger.kernel.org>; Wed,  1 Mar 2023 22:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677739129; x=1709275129;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ajfbht6VgojwC3ZgyL+LZDv6M3tDThrmV3a2NIdi8zo=;
  b=f8MXWtYXKJ0qjBk3/niL53mNOFnVkOH7pqnPfn43GdjQpal2cu1IpcPw
   Y89etglukl86bbrPjtPURWh3kpTSttbt/HGOGhImNvvdWTATCiCmpJO77
   lwZL9FcRnEi5jkqjlIv+FT5v/+VBVzY+sKTwoeqxs1vbjqqVE1GPqEhd+
   s9Ai+y+WUxGXdEqJdiuikKCPfkpTLf1Af8wCzpqeolz8qR7IIegg7XWlX
   7LPEUZ7+/jjh7YndoIklhxJyP9CtL5Dmg7CF4HrRmcpvsVMiwk78gIDhf
   /vI0jdApzGuFfVewXtRaFFFtdLFRpsYV0rmzKWh55fTgrE/mjeLIdgvty
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="332118378"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="332118378"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 22:38:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="1003985867"
X-IronPort-AV: E=Sophos;i="5.98,226,1673942400"; 
   d="scan'208";a="1003985867"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP; 01 Mar 2023 22:38:46 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 1 Mar 2023 22:38:40 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 1 Mar 2023 22:38:39 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 1 Mar 2023 22:38:39 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Mar 2023 22:38:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbZ1fPlr7uZrysR4jWAgoTHcQ14l2nKZ34eqnjkJzIoTtf8ddlVJulaz8pzpTpLXRmKi5RKCej5LTGiBNGZqVWvioXZ8d+CJNvQY8E+/UwL0113uBQ4zxmsnCdNzJSg/Tt3sWi7iH++ERlLo97ID7rmPYO1ROrr+ACgBedY6CMEjmgQXdQadTHQKtm+I21PRO/LKQ/yIhSN3cVaWK1sHVrMd/4AIHtNWhL9Ga+qAEoKKAiNcMFa0D37TXfQhB+vKJp/pJyvZ6WYLFP0OA+3pBRPTplTriFwX79iwml254rsGNv4hJF/JCIJ/tSYPjyP0WUx8ha6ltk+X0OXlWQH9dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0d8+oiZhDVvyb28H0Oqdne4vYxUjqv2H3zF2uGd8i9E=;
 b=ACzT5TW7DdvujMi6GAy8FfKKhg4iJLClHRvtorSNop2E5Fj4OfIatOloKsRQWlb/IQEM4qQ0g0nm25pL3FKxC8oXDD2i6QzC5cJAeqNbWbgURisZtzM/qi67J0sH6Og/SOb1ozM1+8JM2/Fc6xz1rvwORlUIc0UletyUydzjWoyEbI94uRDy2E9wSK5F+cIk7KRrbcGzD2Ecm/xRArGRbvpd29UNV/2FW1P1KyoQYfI9pJpP12o52I9lRIlFsY/QPKoU1lUNyrGjppZpy/UQrfej9rPz0duHz4hn5o7daDO9uiZ/JJh14AOUVMKqHnVtCi2W8amgoAKDD125OJteqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CO1PR11MB4883.namprd11.prod.outlook.com (2603:10b6:303:9b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.18; Thu, 2 Mar
 2023 06:38:32 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff%7]) with mapi id 15.20.6156.019; Thu, 2 Mar 2023
 06:38:32 +0000
Date:   Wed, 1 Mar 2023 22:38:26 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>
CC:     <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v3 6/7] hw/cxl/events: Add injection of DRAM events
Message-ID: <64004462d4dec_3a6b5294bc@iweiny-mobl.notmuch>
References: <20230227173416.7740-1-Jonathan.Cameron@huawei.com>
 <20230227173416.7740-7-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230227173416.7740-7-Jonathan.Cameron@huawei.com>
X-ClientProxiedBy: BY5PR16CA0021.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::34) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CO1PR11MB4883:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e487652-3d54-4b25-3a65-08db1ae8bd2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nGbd2etmIA37G/QDl33ABK1wEnK3fP4cUayfcRl0q/qIq/DBs0pG27/evlM1YQT6jKBXvHgmmVkxNfV3QneZfkYWcsPe9/uZ696QDkOt9czo5Yv24p9XIDzM69cMHigPFhNIrwFiJCRdkzE7y9c8Jo22jO7m1Of71O+PKfhKoaBNmsSaY7+sSYje/VGyg2sY+Ccc3bOXnz3yVmNwlftewsaoGcHGYm2IAbhDZhn+DhQqVNCzIuXqgvqsS/1H3t2nkb70YSpHPl4p+e6Rgi2XEgpgppBRLT2v19Kkv7vnSaF4M1MB5MprrP8OnFsgBWXtczoVymqJxjtN8vx7L5neOYOHT2IYMoiDQ1mMZU2QECB4lP+vBcMYPJMaVZD3qFpTu0nr0KnCviIPhrHU9zG0Gu+zKi2DvWROOWp91s5Ao0Q5bX9eJwFpx3dxkHxxkHDbVFoCrORdbo/7MmJTbq0/b5k4QuCnYcR+NgIWAvr4/Jx+JLXS21wufa0aOjwr9VdyWikV73Fp3m9ypoTPMgIk1FzIix0thjVcaXRIX2+efds7WEgF6YCHEWggTZkiI14HBE4s7/u3STAqzrXKi51cY3Qfb6MQE222SgIpA3C2n+CYQtnVKuXX/6wSe80vpi0tB9g+GViakKTLoQqKp7TAPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(396003)(366004)(346002)(136003)(39860400002)(376002)(451199018)(83380400001)(66556008)(26005)(82960400001)(38100700002)(478600001)(44832011)(5660300002)(66476007)(86362001)(107886003)(6512007)(6666004)(6486002)(186003)(9686003)(6506007)(66946007)(8936002)(8676002)(2906002)(4326008)(316002)(110136005)(54906003)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ih5vkvx71Qx20ye6FX53uAMwJSaqrvlQw6YsoaHLfUrQdulpQ+q4t748EkEA?=
 =?us-ascii?Q?jnO0NZNOY4se59x3ldCKD7029cplkc5P66Fxg/sAMUByF1N5YqkJFcoNGKje?=
 =?us-ascii?Q?EbQfEgCwt0DmecpXDneixqIvGKmT3mRIcSRd7wWD/Lj71XafMtrXPfCkglYh?=
 =?us-ascii?Q?Yadcb0ufR9hasdk4FXl9OXrTbEc1yfNd5tWePgldAOeLo7j+dS5CfQBlSP/d?=
 =?us-ascii?Q?elYVJk1MjnatUj0k/+FhfUOEf0jooaybU9HD4vX8M0Rzt0w45mD7kuuT9iGe?=
 =?us-ascii?Q?9VYh+64iYVJDJaUAQ9BSuP7LXFnOGHJMswYEoF+FO5uDk0Ak9xtBVFNod5Ey?=
 =?us-ascii?Q?E0+iSwD4Qe4K2Luhx8ZnAnbcdmlnRhV9vRG+XsXcRXkaSJpgZEeLfzKs2zYu?=
 =?us-ascii?Q?YmdSDBzSqKoq1v1UgNUq+mvn1mLtQPcSJhSC3kFrSQPlRQYKlSx0ZsCiE1Mz?=
 =?us-ascii?Q?pfKmyxLGeBQDjcJVWw6Vy0R94GUnMK38jnrW0mCRcnH7bsZ/GUnUSoDdYc6M?=
 =?us-ascii?Q?mVm6oX6+kz5mBlqfEjmoi5IRAsaXKRoBaLUcjF7LJ4VTi+5R8lTahxtgM1D5?=
 =?us-ascii?Q?NwlytNbtE7pIKCnJ5JnTCls63EZps48DyV0bQ1cVOE1aj9XPlj/03j6AFMxn?=
 =?us-ascii?Q?/+UcRn8qV9OJbfzry6XBvR++Zi+LmNTr+6vNwcpJyVf5uh++wZQZr+5ZesTT?=
 =?us-ascii?Q?7HTComPWwdu2LvD1R9hi8aesNXZN2BqT0tsf+0pmjvaW90eG0bNor3LaBQHx?=
 =?us-ascii?Q?oNDvCcWnBoFarvaSM1jbkB02Zh05pwUPJ4DI51dRHHHK3DkOuJytJZWXMCEB?=
 =?us-ascii?Q?S7S8gM2i57x97lgDAAdYAufvSkWzJhrMGn/qOXK1FkDYJeSMGWIxAuLn9y0B?=
 =?us-ascii?Q?Cxfohp2QwZBFf8AE3Air5yjzw5mLnM3dIzCaXLWpu8Mbq5C/DmQ9N2XrBS0O?=
 =?us-ascii?Q?y47R+ARx50xnt0iIVSrITnwV/2bITjdVbBfgLGPtd9TgoEsYpGn/RGvN6WlQ?=
 =?us-ascii?Q?J/u5eg8m426KexN3iv+a+WgGRrOqt3aylduOAedjUOjPbdDI9qSox+tYgHHW?=
 =?us-ascii?Q?Xpfn64a+RHLN2bL3jxiIrJxC9azvEvRuNRkRXMvuISYUIpwqykwyiIyn/Q9l?=
 =?us-ascii?Q?V7EL4ODEA6lRyrCigd+o2um51rla35SXpzpYV8piglfb/W/UANOnEYyejYaL?=
 =?us-ascii?Q?by3KsIkdCqzTO9RMrjVf5kmXs+beelwLgN6x/Me9vdGYlVTNSLzPQlPsYozC?=
 =?us-ascii?Q?cSbzyvU36dPrL48Qif/Xk0pqNaUVJ77K6XdEvVsujx5f+ScsZXcwte8YgC2H?=
 =?us-ascii?Q?rohpEXa9gOYKwzzwWJ+AT42ZPieKDZcwr4Ulg6K0PjSBd5UEmRXhftLm35ZB?=
 =?us-ascii?Q?IR4ByHG+NFxOigNftuTqUPIyYplbqikxRMAYBiU5oJTsnxu/MKWKhteEIFk2?=
 =?us-ascii?Q?7BlV7az7vQIv/xTPNB5n0JXb6ml3WkilqethLC6YTrLGtLra/hr1We/GG4vh?=
 =?us-ascii?Q?bHMTMJMNLTs1V48H0opOhNhGj7llQTl1fxUb2YbZkmKQoTrq+A3O+k11THl7?=
 =?us-ascii?Q?tCM+pJKx9PvZxMafEqE5h10gmAIUC0JLaI3xJZfe?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e487652-3d54-4b25-3a65-08db1ae8bd2b
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Mar 2023 06:38:31.5264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w7waK/EZWBuNf9LGj6jUNjRlXqEVK/km1A1FHO7evJ0NDrRLArmLiE843IwYXdgP5nCPh8JrgCb1rh0uDMbkKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4883
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> Defined in CXL r3.0 8.2.9.2.1.2 DRAM Event Record, this event
> provides information related to DRAM devices.
> 
> Example injection command in QMP:
> 
> { "execute": "cxl-inject-dram-event",
>     "arguments": {
>         "path": "/machine/peripheral/cxl-mem0",
>         "log": "informational",
>         "flags": 1,
>         "physaddr": 1000,
>         "descriptor": 3,
>         "type": 3,
>         "transaction-type": 192,
>         "channel": 3,
>         "rank": 17,
>         "nibble-mask": 37421234,
>         "bank-group": 7,
>         "bank": 11,
>         "row": 2,
>         "column": 77,
>         "correction-mask": [33, 44, 55,66]
>     }}
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  hw/mem/cxl_type3.c          | 115 ++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3_stubs.c    |  13 ++++
>  include/hw/cxl/cxl_events.h |  23 ++++++++
>  qapi/cxl.json               |  35 +++++++++++
>  4 files changed, 186 insertions(+)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 5d55943df2..cff5341b7b 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1167,6 +1167,11 @@ static const QemuUUID gen_media_uuid = {
>                   0x85, 0xa9, 0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6),
>  };
>  
> +static const QemuUUID dram_uuid = {
> +    .data = UUID(0x601dcbb3, 0x9c06, 0x4eab, 0xb8, 0xaf,
> +                 0x4e, 0x9b, 0xfb, 0x5c, 0x96, 0x24),
> +};
> +
>  #define CXL_GMER_VALID_CHANNEL                          BIT(0)
>  #define CXL_GMER_VALID_RANK                             BIT(1)
>  #define CXL_GMER_VALID_DEVICE                           BIT(2)
> @@ -1262,6 +1267,116 @@ void qmp_cxl_inject_gen_media_event(const char *path, CxlEventLog log,
>      }
>  }
>  
> +#define CXL_DRAM_VALID_CHANNEL                          BIT(0)
> +#define CXL_DRAM_VALID_RANK                             BIT(1)
> +#define CXL_DRAM_VALID_NIBBLE_MASK                      BIT(2)
> +#define CXL_DRAM_VALID_BANK_GROUP                       BIT(3)
> +#define CXL_DRAM_VALID_BANK                             BIT(4)
> +#define CXL_DRAM_VALID_ROW                              BIT(5)
> +#define CXL_DRAM_VALID_COLUMN                           BIT(6)
> +#define CXL_DRAM_VALID_CORRECTION_MASK                  BIT(7)
> +
> +void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
> +                               uint64_t physaddr, uint8_t descriptor,
> +                               uint8_t type, uint8_t transaction_type,
> +                               bool has_channel, uint8_t channel,
> +                               bool has_rank, uint8_t rank,
> +                               bool has_nibble_mask, uint32_t nibble_mask,
> +                               bool has_bank_group, uint8_t bank_group,
> +                               bool has_bank, uint8_t bank,
> +                               bool has_row, uint32_t row,
> +                               bool has_column, uint16_t column,
> +                               bool has_correction_mask, uint64List *correction_mask,
> +                               Error **errp)
> +{
> +    Object *obj = object_resolve_path(path, NULL);
> +    CXLEventDram dram;
> +    CXLEventRecordHdr *hdr = &dram.hdr;
> +    CXLDeviceState *cxlds;
> +    CXLType3Dev *ct3d;
> +    uint16_t valid_flags = 0;
> +    uint8_t enc_log;
> +    int rc;
> +
> +    if (!obj) {
> +        error_setg(errp, "Unable to resolve path");
> +        return;
> +    }
> +    if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
> +        error_setg(errp, "Path does not point to a CXL type 3 device");
> +        return;
> +    }
> +    ct3d = CXL_TYPE3(obj);
> +    cxlds = &ct3d->cxl_dstate;
> +
> +    rc = ct3d_qmp_cxl_event_log_enc(log);
> +    if (rc < 0) {
> +        error_setg(errp, "Unhandled error log type");
> +        return;
> +    }
> +    enc_log = rc;
> +
> +    memset(&dram, 0, sizeof(dram));
> +    cxl_assign_event_header(hdr, &dram_uuid, flags, sizeof(dram));
> +    dram.phys_addr = physaddr;

I know I did not do this either but now that the devices can be volatile
memory; Should we try and set the Volatile bit based on the address
provided?

Or should we just allow the bits to be set by the user for testing?  I
think this is what I originally thought but given the new functionality it
may be best to make this more 'real'?

Either way:

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> +    dram.descriptor = descriptor;
> +    dram.type = type;
> +    dram.transaction_type = transaction_type;
> +
> +    if (has_channel) {
> +        dram.channel = channel;
> +        valid_flags |= CXL_DRAM_VALID_CHANNEL;
> +    }
> +
> +    if (has_rank) {
> +        dram.rank = rank;
> +        valid_flags |= CXL_DRAM_VALID_RANK;
> +    }
> +
> +    if (has_nibble_mask) {
> +        st24_le_p(dram.nibble_mask, nibble_mask);
> +        valid_flags |= CXL_DRAM_VALID_NIBBLE_MASK;
> +    }
> +
> +    if (has_bank_group) {
> +        dram.bank_group = bank_group;
> +        valid_flags |= CXL_DRAM_VALID_BANK_GROUP;
> +    }
> +
> +    if (has_bank) {
> +        dram.bank = bank;
> +        valid_flags |= CXL_DRAM_VALID_BANK;
> +    }
> +
> +    if (has_row) {
> +        st24_le_p(dram.row, row);
> +        valid_flags |= CXL_DRAM_VALID_ROW;
> +    }
> +
> +    if (has_column) {
> +        stw_le_p(&dram.column, column);
> +        valid_flags |= CXL_DRAM_VALID_COLUMN;
> +    }
> +
> +    if (has_correction_mask) {
> +        int count = 0;
> +        while (correction_mask && count < 4) {
> +            stq_le_p(&dram.correction_mask[count],
> +                     correction_mask->value);
> +            count++;
> +            correction_mask = correction_mask->next;
> +        }
> +        valid_flags |= CXL_DRAM_VALID_CORRECTION_MASK;
> +    }
> +
> +    stw_le_p(&dram.validity_flags, valid_flags);
> +
> +    if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&dram)) {
> +        cxl_event_irq_assert(ct3d);
> +    }
> +    return;
> +}
> +
>  static void ct3_class_init(ObjectClass *oc, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(oc);
> diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
> index 55d19b0e03..235c171264 100644
> --- a/hw/mem/cxl_type3_stubs.c
> +++ b/hw/mem/cxl_type3_stubs.c
> @@ -13,6 +13,19 @@ void qmp_cxl_inject_gen_media_event(const char *path, CxlEventLog log,
>                                      const char *component_id,
>                                      Error **errp) {}
>  
> +void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
> +                               uint64_t physaddr, uint8_t descriptor,
> +                               uint8_t type, uint8_t transaction_type,
> +                               bool has_channel, uint8_t channel,
> +                               bool has_rank, uint8_t rank,
> +                               bool has_nibble_mask, uint32_t nibble_mask,
> +                               bool has_bank_group, uint8_t bank_group,
> +                               bool has_bank, uint8_t bank,
> +                               bool has_row, uint32_t row,
> +                               bool has_column, uint16_t column,
> +                               bool has_correction_mask, uint64List *correction_mask,
> +                               Error **errp) {}
> +
>  void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
>                             Error **errp)
>  {
> diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
> index b189193f4c..a39e30d973 100644
> --- a/include/hw/cxl/cxl_events.h
> +++ b/include/hw/cxl/cxl_events.h
> @@ -123,4 +123,27 @@ typedef struct CXLEventGenMedia {
>      uint8_t reserved[CXL_EVENT_GEN_MED_RES_SIZE];
>  } QEMU_PACKED CXLEventGenMedia;
>  
> +/*
> + * DRAM Event Record
> + * CXL Rev 3.0 Section 8.2.9.2.1.2: Table 8-44
> + * All fields little endian.
> + */
> +typedef struct CXLEventDram {
> +    CXLEventRecordHdr hdr;
> +    uint64_t phys_addr;
> +    uint8_t descriptor;
> +    uint8_t type;
> +    uint8_t transaction_type;
> +    uint16_t validity_flags;
> +    uint8_t channel;
> +    uint8_t rank;
> +    uint8_t nibble_mask[3];
> +    uint8_t bank_group;
> +    uint8_t bank;
> +    uint8_t row[3];
> +    uint16_t column;
> +    uint64_t correction_mask[4];
> +    uint8_t reserved[0x17];
> +} QEMU_PACKED CXLEventDram;
> +
>  #endif /* CXL_EVENTS_H */
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 4ec06c0335..32f340d972 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -55,6 +55,41 @@
>              '*device': 'uint32', '*component-id': 'str'
>              }}
>  
> +##
> +# @cxl-inject-dram-event:
> +#
> +# Inject an event record for a DRAM Event (CXL r3.0 8.2.9.2.1.2)
> +# This event type is reported via one of the event logs specified via
> +# the log parameter.
> +#
> +# @path: CXL type 3 device canonical QOM path
> +# @log: Event Log to add the event to
> +# @flags: header flags
> +# @physaddr: Physical Address
> +# @descriptor: Descriptor
> +# @type: Type
> +# @transaction-type: Transaction Type
> +# @channel: Channel
> +# @rank: Rank
> +# @nibble-mask: Identify one or more nibbles that the error affects
> +# @bank-group: Bank group
> +# @bank: Bank
> +# @row: Row
> +# @column: Column
> +# @correction-mask: Bits within each nibble. Used in order of bits set
> +#                   in the nibble-mask.  Up to 4 nibbles may be covered.
> +#
> +# Since: 8.0
> +##
> +{ 'command': 'cxl-inject-dram-event',
> +  'data': { 'path': 'str', 'log': 'CxlEventLog', 'flags': 'uint8',
> +            'physaddr': 'uint64', 'descriptor': 'uint8',
> +            'type': 'uint8', 'transaction-type': 'uint8',
> +            '*channel': 'uint8', '*rank': 'uint8', '*nibble-mask': 'uint32',
> +            '*bank-group': 'uint8', '*bank': 'uint8', '*row': 'uint32',
> +            '*column': 'uint16', '*correction-mask': [ 'uint64' ]
> +           }}
> +
>  ##
>  # @cxl-inject-poison:
>  #
> -- 
> 2.37.2
> 


