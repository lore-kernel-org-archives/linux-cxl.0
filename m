Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CE5C7EE26
	for <linux-cxl@archiver.kernel.org>; Fri, 19 May 2023 17:48:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjESRs2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 19 May 2023 13:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjESRs1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 19 May 2023 13:48:27 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E4893
        for <linux-cxl@vger.kernel.org>; Fri, 19 May 2023 10:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1684518506; x=1716054506;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wdDxgP8mBLeCJuH6mOEvJJIw32S7hJtzzQNfUGoA6IY=;
  b=g26B5f2nKaYskJu1xrzg/voIcMsnppYyNohc80ZFIrlxPqWCcX2298xU
   UvBh/Bm3UmA2oswoUd7KMV1Ny1hfYCPBLimp9w9rq0acqRc03THO9Aj2L
   EGmLpPZ7HSvbngG3iOGk8L6aqtoDghjrP2omhDj9U1pcByeZbai7vKQ1T
   qFaHEOFkZwOzQbEPi5uRJ2nP9f6//V8Sgkr62HZ/3BoSnZm2IrrJEz9Jz
   d8HW0Z5MQtycSKnIU4yP7wq6XXUltUbFBCiHnTuIdTlyJCXU6no53nWhF
   L/ytirwaHm3V6d1cmONs1+7RIQbWQqfs09QQw5f+BC0YKqERNOM+gzL31
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="380655921"
X-IronPort-AV: E=Sophos;i="6.00,177,1681196400"; 
   d="scan'208";a="380655921"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2023 10:48:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="876919198"
X-IronPort-AV: E=Sophos;i="6.00,177,1681196400"; 
   d="scan'208";a="876919198"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 19 May 2023 10:48:25 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 19 May 2023 10:48:25 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 19 May 2023 10:48:25 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 19 May 2023 10:48:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iytH0iBAW4Q60+/s/JExZ/XIaTarHbHoi4eWmaZ/Ag2SDm8Ato1Q28FVRQcRX0qGrIVZSv+YDICSsU39oo6ffzIshTTHJo3g2RCUM9hEofCoU9e0AvF6BbSF9sFc7w7+B+VrWWm++kXP/+GgM5vo/Tg8CaWex34Of1Lky8fcfIdGH8zlOZXOgz/bOuSvX7hvtf6ufFj+OWNHqpwJpFWZuZ4cBwxeU1CMW6T7T1xRTUWxw6KAuDqJS3o/iWHSXMiZ3NalVnXIuKjLrDOY/kACg+C8vrG9CJtq4WajuxM/Uj5BoyQwfBJz34h457Bi0XnRsDMuECK2mO9Vsi9CWCXNyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11Uvudk355/364lB0mEIhSFjOG5GNTK1+YWlmiDCuEI=;
 b=k0yMUbGK6XfbjMOLXd1fLas8ITdyfGSF52MELhIohtYFh3L79ci0YsF3bZQyVAWV026WjcnKeHtt4c359frjYdLW7uqJiEad0+pi4idjiQY3ehuhXAQlXEb5RtOuTzJUYalsmfMwOQn6S6IgFO9vIpTF8WflEpDiwRdGTH47GA8Wy2dFcxnoShhY8ajjV2EoJvOfrvEUBpmcvLe5PsFGIhDZ0nGlA4r+TKAJDjTrh1Aq3u3vSIxhDcrNMJw/jox/T4D1oDcF9VpU6dJB5wvFoNlCnh/DyB0wUjxkHpFOY5NzfogNZc9CXCUCKHDdIexzLj+6fcjk6gSKByNJFcckxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CY5PR11MB6091.namprd11.prod.outlook.com (2603:10b6:930:2d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Fri, 19 May
 2023 17:48:22 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4fe2:e207:596b:d145]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::4fe2:e207:596b:d145%5]) with mapi id 15.20.6411.021; Fri, 19 May 2023
 17:48:21 +0000
Date:   Fri, 19 May 2023 10:48:13 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>
CC:     <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?iso-8859-1?Q?Marc-Andr=E9?= Lureau 
        <marcandre.lureau@redhat.com>, "Thomas Huth" <thuth@redhat.com>
Subject: Re: [PATCH v6 4/4] hw/cxl: Add clear poison mailbox command support.
Message-ID: <6467b65d75bc1_1231462942d@iweiny-mobl.notmuch>
References: <20230519141803.29713-1-Jonathan.Cameron@huawei.com>
 <20230519141803.29713-5-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230519141803.29713-5-Jonathan.Cameron@huawei.com>
X-ClientProxiedBy: BYAPR08CA0021.namprd08.prod.outlook.com
 (2603:10b6:a03:100::34) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CY5PR11MB6091:EE_
X-MS-Office365-Filtering-Correlation-Id: 52e7e4f8-41d6-4ca0-3ffb-08db58913c76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IUAerX3ZdPspAee+HKsamazP7+Dlq1DzKSvrpjSaffkm/iQs3oqlblhIEbduEKUHi9Q+V1mE4Spk3sqYXuSc0CKEJ42jKFdDVpHqaqJ5glmElCcQ8DcIbx1YTwIcaEbCVebOFAdYqaCD46jZI85jQNETSe+5R2GQ4z3DjQPqnHMZsPojBorptilw3crLxyUEn/vuilGOT2gb87IbztQW2hCEI54JRcr7/9lzkjUO41hR9HJcCs4cePvUaPHt+Z0ScN+SRXjQG5+13Bbh7K+n0PqG3Vy9oZY1DW+FZSiAyIHfyUEnAll+ZgvNSTGthi2jOvryye8DgaCy9cbcCLsTou4TbszNy1p5sjO2p9VJ7Lvqqg/04kxV8K+IUIwcNfufx2Ay8KSCTq3O2EY607HAYKrvJaXczxuiRj3qoZs6vfZQxo/Bvdl+h0Cn+zUPf2ioKb3AZpGfTKGfb2bUpkx1UI2eqZOOoyoDowpSK/Hfjz7H/f/us2d8Gf/PnwNCeEYjAlSLlfx7fjJFwfw3ICqzsOe0dAOizFdMirC72wp/Zne+LXTkcmnvUYsHa6a9yb9I
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(136003)(376002)(396003)(451199021)(110136005)(86362001)(6512007)(6486002)(54906003)(478600001)(6666004)(9686003)(316002)(82960400001)(5660300002)(26005)(2906002)(4326008)(8936002)(186003)(66556008)(66476007)(41300700001)(38100700002)(7416002)(66946007)(44832011)(6506007)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qAHxB2QBo8RMLiTfxDaFLJW1XzyMufhJmV9Agi+XX7sn4q8VjTX3fF+ERaYf?=
 =?us-ascii?Q?RHkOOPLcIucFLiwoU3WPQjfIPGgQ1nkR/wCrkbXkhr8iwyoaZfCK6wR/+05L?=
 =?us-ascii?Q?7U8MCKyjhiXq2XylGFzNOziD3Fv10g72y9uO/q6vRQwnkFmUA7JqV1GOKr+u?=
 =?us-ascii?Q?IeSz7TMSXhYnAE8ysjYyuh1Yh2yJrEbup8KTRfRTSfgRzAnB6Qye4ApHll6a?=
 =?us-ascii?Q?PWHH0+cNi62mGOsp4GdfEti1qqVLCU8XejTrmzq2YFZ3Rqaomnem1sC71Mj3?=
 =?us-ascii?Q?uQmFLWwDORBdsY9nCQtVfjCz91rG2x5XfTkGE3lDa4c2x1WcjM6tbO12FRBB?=
 =?us-ascii?Q?MSbKKq/ZKfvjVCNLO7j0ATWTDfqy9HCmlgM324rR6f7umHEtqEezRBZIpQEP?=
 =?us-ascii?Q?tswARS+h8orjQr5sPazS7uetLio+f2f7Wz0FqTgXIrhG9SqSDWeT8tteCctX?=
 =?us-ascii?Q?WXezNcBk4k95VJazFaN60D/5LYkyDKy2dbLtjFUYYgG0rqMd0wb/M+NwKUFR?=
 =?us-ascii?Q?OvRUV0Ep990VQcZdMNlSxcg7S/CVxOzzqQlmpjZ3E/ePTlph16FENYcjEYPF?=
 =?us-ascii?Q?EscUTAaUI7zKCK3/UoIQklISVTwUY0D3tSw2DEiOdSLjs8XMFYHU1BXCJOjK?=
 =?us-ascii?Q?rsxZKIQ9mv7i36vnhBoiL2GNOhhzrxXfwiRR+KBF5e2hxIIBNHwCxLBgm+2B?=
 =?us-ascii?Q?qmAloUFLHq7qXmvJQ0GobNXRFAfvFmv77xscUxyutPNrRihJc3KKjpiQlwb1?=
 =?us-ascii?Q?H/KumUbPbg70IQSALUyPG+7E8NFEH16QHAdH6vk/6Q+Xr3jW8062Z4RBQ1Jw?=
 =?us-ascii?Q?Tk1dOlDhrrws8pT8ZSDrXdB/iD5SOnY+mt+Y1voSDhVAkXKz3SEjMm0nPaFv?=
 =?us-ascii?Q?vfYiEbiYvnCMe4AeweOXZwpXhXPFOJZvAOmSk/Utf1i7gBZ0MEKEBoZ2oAU5?=
 =?us-ascii?Q?gQgpINePNukct7xGeawRuAnFmG51MdjpX5uhWU02zM0iLk1qC6WRXG/31YFz?=
 =?us-ascii?Q?yT4E95BZrrgIWUjizm7csevhtQ6LepQ7flUShgTo6oIHH4eNWY93qwD92wPM?=
 =?us-ascii?Q?bFhs0fmc1Vn+OxZwSAmlz2k5OLEUjWV+zyqEauFsMxfw/pm5NDQcDLksqYKf?=
 =?us-ascii?Q?twLMwqQUS4L/rleT7+wP5Sni0mEkjVucBqLhT1UKuWjj9vzEibb2fEtNpwt1?=
 =?us-ascii?Q?djDDwMpPpnqLZO7HfiJGFKdYl15u+sOm16spGkPqYaIntq02ko6F3+RKR23k?=
 =?us-ascii?Q?3FU2/hV9rLkXS5J8EhF2x4MzSB99oD8jnnq4ygnXjU2QfltMCSXvQyHPPgcB?=
 =?us-ascii?Q?+krW/CS5DgjOuPNlThqubi5X+uC0ykPWw85/fClqwaLOXuIpeWYBR7qhFqun?=
 =?us-ascii?Q?DiJdVxhg1xtW7wXLTm8Jf9gclLNdrk5zHrXZCvv40BEdCSjvuEMwHMo3a8ES?=
 =?us-ascii?Q?1z7Jvkfnqa7Ep87NNONuYvhnVQOEyNOv1/5e8p+ISaM2i2iejzdb9lWEPT//?=
 =?us-ascii?Q?cCoJeOIR2mNTytBdNvVGyvZlIRqu5rCV4mcdSzMygSfw/RKdbRHjTh/BeqYu?=
 =?us-ascii?Q?mpMzaJji/qYSB+/1eQFOtFTIFkYxBir/02IbT3j5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e7e4f8-41d6-4ca0-3ffb-08db58913c76
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 17:48:21.3711
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6CiqYIBouiyrSNZQ7wvt0iJmGi6BLt/51/a2ffvAMdni1EsWiN+cUdEsv9lnfdaDngGGTbTm6iJ61XiIZlaAwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6091
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> Current implementation is very simple so many of the corner
> cases do not exist (e.g. fragmenting larger poison list entries)
> 
> Reviewed-by: Fan Ni <fan.ni@samsung.com>

Minor nit below.  Otherwise looks good.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index ab600735eb..84022d7ae3 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -947,6 +947,42 @@ static void set_lsa(CXLType3Dev *ct3d, const void *buf, uint64_t size,
>       */
>  }
>  
> +static bool set_cacheline(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data)
> +{
> +    MemoryRegion *vmr = NULL, *pmr = NULL;
> +    AddressSpace *as;
> +
> +    if (ct3d->hostvmem) {
> +        vmr = host_memory_backend_get_memory(ct3d->hostvmem);
> +    }
> +    if (ct3d->hostpmem) {
> +        pmr = host_memory_backend_get_memory(ct3d->hostpmem);
> +    }
> +
> +    if (!vmr && !pmr) {
> +        return false;
> +    }
> +
> +    if (dpa_offset + 64 > ct3d->cxl_dstate.mem_size) {

NIT: s/64/CXL_CACHE_LINE_SIZE/

Ira
