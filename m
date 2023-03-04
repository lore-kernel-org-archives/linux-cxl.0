Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 705FCC6FA8E
	for <linux-cxl@archiver.kernel.org>; Sat,  4 Mar 2023 06:47:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjCDGri (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 4 Mar 2023 01:47:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCDGrh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 4 Mar 2023 01:47:37 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD4B1A95C
        for <linux-cxl@vger.kernel.org>; Fri,  3 Mar 2023 22:47:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677912456; x=1709448456;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=OevIdqSXs00zhbrSCAgW3TBaCATfwutS6k0u2VxEXsc=;
  b=mOyLFTfrb9h9X0TD+a3I1KbMmKzGj0EoSHlpegVVd34ZNMbfbbfJMm7w
   lTn6zuSCw2ww8ddsX36WiIk2K53wQKOZ4zs7hafTUC88pau6UF0QVFGek
   oKOnZD37iEkSbzP0I8R5/Znh7sitcqD2FS31gG0A+VeG3bjZZgD5GeWZJ
   OoLC3cBr1CLh3aDnLa7SXOewQ4UcNg+Q8aVfNGefpuosqxzMGCkliw3HB
   w1VOKP+eUDXLwZwcMcxKCxDZukX6++QJn+2M7TRT0aCr4QvWPDAPPVsj4
   kt8Ni6+omVBSTC4CbYSNOvQHkVmDPcYPo5qGeJ/SNr2CDW3qHCx4k+35y
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="362831930"
X-IronPort-AV: E=Sophos;i="5.98,233,1673942400"; 
   d="scan'208";a="362831930"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2023 22:47:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10638"; a="625595752"
X-IronPort-AV: E=Sophos;i="5.98,233,1673942400"; 
   d="scan'208";a="625595752"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 03 Mar 2023 22:47:35 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 3 Mar 2023 22:47:34 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Fri, 3 Mar 2023 22:47:34 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Fri, 3 Mar 2023 22:47:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OE6fs3jplJuCVqdZTMD6V14Vf32L7z6vhkgs+O/SV/b7bidK1Ir/nRGg9oXByb4O7u7+GbNF288qAgUR+RHx5ODUd1Jx2FC9JUFdfD84SLqTU9xqrEYkdlmb4EeJ3i8iqiNYoMrr+mNaPw/OOa07p5RhQuXHFtIh8/sPUevKVd5gGR7JXf0Adxs5EBCUXkyyAbpczijuWSKIgXKFDEIG4pW9rbEbCpsdP9GDJ4iM1BL3OuzVTAQI0JBN/1csPUxKgCLUfTwWm/vn4sStgH/J/+UJ/+dUk9y07OW8oa/qPljxBo3AdGH3UtXmjBIflDwXN/dyGb9LZ/yunPvAiBdvfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sznPojd45+vCte7wFZEdX/+UD1D2MWSUc9fwSFAqLx8=;
 b=lyyMNolXcy70LDWGsEPqpKOdyMCo+NniE890yVbLpHlOp/4bgPtG7IRUni3RPPrh61s0b9ptT64FiQt8bou0ZI5ZR1z0oWAKyQLpU6Ehigblt+0SD4eJgw0zMHuea44W4LcPQ3vKGralDsuUGbWRZNSGikf/oKIgDjDbmr57f2nOySxOmjEtCxX0NRLYQobqUIP2DkKCVX04vhX7OhNabH16mSd7vwnt25il8uSkU4As1hSUcnyGj7wOf4mdv0N6l5RUa96k4iJEMvgBsNjjjGDCFcp4GXXV88WqQ+dJUloVaPJ0OrgjVCp0Gw44mty1igsY07qrISAz0dczVRkfWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB6120.namprd11.prod.outlook.com (2603:10b6:8:af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Sat, 4 Mar
 2023 06:47:25 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff%7]) with mapi id 15.20.6156.019; Sat, 4 Mar 2023
 06:47:24 +0000
Date:   Fri, 3 Mar 2023 22:47:20 -0800
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
        Markus Armbruster <armbru@redhat.com>,
        Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?iso-8859-1?Q?Marc-Andr=E9?= Lureau 
        <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v4 6/6] hw/cxl: Add clear poison mailbox command support.
Message-ID: <6402e9787cad0_606a629499@iweiny-mobl.notmuch>
References: <20230303150908.27889-1-Jonathan.Cameron@huawei.com>
 <20230303150908.27889-7-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230303150908.27889-7-Jonathan.Cameron@huawei.com>
X-ClientProxiedBy: BYAPR08CA0002.namprd08.prod.outlook.com
 (2603:10b6:a03:100::15) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB6120:EE_
X-MS-Office365-Filtering-Correlation-Id: 72cc7c0b-97a1-46de-2b38-08db1c7c4ff8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fI1SiHI8lpopEBZRor0k1yfJDyKYMdfOoD04A9BPYIuEsHf7EzRPbimcVZM4FS/dJzX8OR/5qbkpn5XAxrTM+37EJiulTQAnuvOybHxLJXlk1gQij2gxgT2zA9D4pBPw3iX6ioOnxC8ua8Xl+kdHxiCzr678tYgP+SUP4fZslXxltkmx4EP17UCXmeZkDUM5Z1Zh1adUps0j8fMw9t03sIoHRQFDfjuOlH5XOme2hGQjNnjlc/pC4Inz8o5ztIHKlXcuSqJ5SvtPZbG5kwOr+WnZcZKCtQlsijNR2HhNO8Njm6oiIqiq9M8/gXn3bvqcZM8tTFGptb4oe1SLmg7FsGssKqYQLiAjOORKVSR6VNi5alvPyk0KauShc5Fi6VHAzojXK9MiJXbNp+ktQzkC/rEUiZiNeeW5ZZ5ZNKjXrLnlID2DuoB1HuJwz7/oHbijLMC862l3kWvSe8tkSrES3DiZdhQ7ombcOvV2niMqc0V9RHUNqbH50zfWj2Q8pYyOtltK7wFIQAs7m1+ea8N6IctHTJ8ZKbVW1oYhkFCboPzmk0/el4SsvF36sL9ZaToCOTkq/K5/gjxgzzL92aPgRnkHkTmDys0I2D7jSLzV6k+XdC/2cjRy2ugOsPRdgmfqGfP1sSD1IdK55peX3r0U4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(366004)(39860400002)(346002)(396003)(136003)(451199018)(54906003)(478600001)(38100700002)(2906002)(110136005)(15650500001)(83380400001)(8676002)(66946007)(66476007)(66556008)(82960400001)(316002)(6486002)(86362001)(4326008)(8936002)(9686003)(186003)(26005)(6506007)(6666004)(7416002)(44832011)(41300700001)(5660300002)(6512007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7/8wBKYTgS6c5OUV/ctn2TZvZHPFjS2QG4vFQC2uV7wpfzwAxwG+Z1dSq3dB?=
 =?us-ascii?Q?jDed6aZpFEJHan6U+7uNOhX9pOsYPugGKNA26YxjpyXwpI2qwVXxqSs9G4Nk?=
 =?us-ascii?Q?amn9R+VQ5clYaXZbN6OWtQc/LLk4OAdZyAvm2P7AQJ/I/hEHW3A9Y9iF+O0j?=
 =?us-ascii?Q?lXxHawACLLJ7tLzmjVHAmK2LCvk75+JtGLOwkVlePCUSQyqZngilbYDfy0t4?=
 =?us-ascii?Q?XqZkg4DN8LxFtM0FszLrUiqskzAqq+ZxK8cTtJA57tPIa1Tyounbkw2Gwtei?=
 =?us-ascii?Q?WbxVkBkoXvgpjb1FI91ei1p6c04RAtN9/cTNtrzMVoD1DDeifGhfN4Gl08/Z?=
 =?us-ascii?Q?FLJwWEGf7X//Vv7+TBxbyU/Cegj8e0j7zhypi6PZdrBIutlXj1i+39abAVcN?=
 =?us-ascii?Q?6XO0sOKrMe4WfU5J3kyDi8ZJhe78/iANlQig0WRFd3/AP5u6tAFp0j8mmE7B?=
 =?us-ascii?Q?FH983WYZ8Nv0IOBaUi0pAthcn7cel/FklHBphDSWPS2XZgHn847ovHLCBNa6?=
 =?us-ascii?Q?57J7uUiy+4gvLPUhCmET6vdMczJbqANuZykbph0l3jTQt50mVgcz0n8dKkhi?=
 =?us-ascii?Q?ZA80rQkJ6zehxfMYSeHJY6MwylI66byYtsaVUgqY2CPpaXWBUSr0Ea4r4prc?=
 =?us-ascii?Q?kEUB6/ihgCXz5wK3zN0ew8Jp1qxWbPBYi0NepnmppfA+KFI5mi3koeJ1GFFu?=
 =?us-ascii?Q?N/0n79jxU0TMR2EpiPmlAdo6MSFyiO1HrS6dmD//oJZ/D5MfldwqQE9Fn7Yj?=
 =?us-ascii?Q?SctFJYgCCibpRHf/6mw/dTf8LgfvxVPQaReFV+w3HsvJ9ID+i21KV1VqBsyp?=
 =?us-ascii?Q?/DqMHWWJDvtqegF79+XwWBdtcFwGvtkCbKNurhONa6DHLaTk3y+sjWRdxYF1?=
 =?us-ascii?Q?Mm5OK7caxqbD91URbMGjlJKlawCQEkzzaqzbmbdW51lkm9ct6WVWD/iHUKTC?=
 =?us-ascii?Q?VTo1k2PTs7fnqGm65U3z67O9F4jQwFfZkpM63dtRDpljfX64UIkPav8tyA1R?=
 =?us-ascii?Q?EQH2X4+UaVhzCCOaPRM9A2jRZXr4/dNzc4xd0S6m6pTehkwgZDWqa6sFbbZp?=
 =?us-ascii?Q?y0koqzd+EBW5fefV8EGkyHB6skJUDe3t+Aj3jIeOiMo84UXWcTJKzqgTOlAC?=
 =?us-ascii?Q?WCIR0ym300srWWpCKa0iRvx/zWGdCR3F9YfGekDhpUAW/EpGd1xd6o02/zVX?=
 =?us-ascii?Q?YQXS8kYsNx1gP8qsqaucGEGfZ/kkER021UR66adITobQ7IYewXjxSPgAzlNr?=
 =?us-ascii?Q?mvMJ3O2T71OyTSwWj3cqSaTCMD5K9jw68F0KFWUMTPBqdsb29YtQi44rny7k?=
 =?us-ascii?Q?p5Q7Vq3PqsSbvwQcCwQOb8GxUH/T1s+lm/q0/fng0Q4q0+Iot9IJQhjzBJzf?=
 =?us-ascii?Q?u8QTBqhuioqJbXwPkLP/ATmlpth7ZKgkAU9NumE29bs/8qyI9wl1o8FVmeNG?=
 =?us-ascii?Q?vzzHErLrC/kG7DcZdCecW7LXsJLh7Wmn4erX8ZsCWQCTy6WWLmXTsbNRY1tX?=
 =?us-ascii?Q?FxyqHergVNcabr9v5MD7YjDm3O8Ml+9HuwCAH4/crHxYYdTXG/40vYKTFacu?=
 =?us-ascii?Q?yzcXVkPKuj6bEpDO4Uve2D4YWrcVkoqESX4Jfk03?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72cc7c0b-97a1-46de-2b38-08db1c7c4ff8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2023 06:47:24.8430
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FlTpjSJo7W4FFZpHb9R1h+/FLbveavEwJL5RubNZgj6mAr7HhLVwrBMnu9EY5aqRWyDxtLz8+1EdtxybMI+1Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6120
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> Current implementation is very simple so many of the corner
> cases do not exist (e.g. fragmenting larger poison list entries)

One coding style change at the bottom and I'm still hung up on that loop
logic...

> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v4:
> - Fix off by one on check of edge of vmr (cut and paste from similar
>   but long fixed in the volatile memory series)
> - Drop unnecessary overflow check.
> - Ensure that even in case of overflow we still delete the element
>   replaced (in the hole punching case)
> ---
>  hw/cxl/cxl-mailbox-utils.c  | 77 +++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3.c          | 36 +++++++++++++++++
>  include/hw/cxl/cxl_device.h |  1 +
>  3 files changed, 114 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 64a3f3c1bf..0b30307fa3 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -65,6 +65,7 @@ enum {
>      MEDIA_AND_POISON = 0x43,
>          #define GET_POISON_LIST        0x0
>          #define INJECT_POISON          0x1
> +        #define CLEAR_POISON           0x2
>  };
>  
>  /* 8.2.8.4.5.1 Command Return Codes */
> @@ -511,6 +512,80 @@ static CXLRetCode cmd_media_inject_poison(struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +static CXLRetCode cmd_media_clear_poison(struct cxl_cmd *cmd,
> +                                         CXLDeviceState *cxl_dstate,
> +                                         uint16_t *len)
> +{
> +    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
> +    CXLPoisonList *poison_list = &ct3d->poison_list;
> +    CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
> +    struct clear_poison_pl {
> +        uint64_t dpa;
> +        uint8_t data[64];
> +    };
> +    CXLPoison *ent;
> +    uint64_t dpa;
> +
> +    struct clear_poison_pl *in = (void *)cmd->payload;
> +
> +    dpa = ldq_le_p(&in->dpa);
> +    if (dpa + 64 > cxl_dstate->mem_size) {
> +        return CXL_MBOX_INVALID_PA;
> +    }
> +
> +    /* Always exit loop on entry removal so no need for safe variant */

Commenting this is nice but I don't think it is needed.

> +    QLIST_FOREACH(ent, poison_list, node) {
> +        /*
> +         * Test for contained in entry. Simpler than general case
> +         * as clearing 64 bytes and entries 64 byte aligned
> +         */
> +        if ((dpa < ent->start) || (dpa >= ent->start + ent->length)) {
> +            continue;
> +        }
> +        /* Do accounting early as we know one will go away */
> +        ct3d->poison_list_cnt--;

Sorry to get so hung up on this but while I think this code now works I
still think it is odd and will be an issue to maintain.

FWIW I don't think we have to keep 'ent' in the list here...

> +        if (dpa > ent->start) {
> +            CXLPoison *frag;
> +            /* Cannot overflow as replacing existing entry */
> +
> +            frag = g_new0(CXLPoison, 1);
> +
> +            frag->start = ent->start;
> +            frag->length = dpa - ent->start;
> +            frag->type = ent->type;
> +
> +            QLIST_INSERT_HEAD(poison_list, frag, node);
> +            ct3d->poison_list_cnt++;
> +        }
> +        if (dpa + 64 < ent->start + ent->length) {
> +            CXLPoison *frag;
> +
> +            if (ct3d->poison_list_cnt == CXL_POISON_LIST_LIMIT) {
> +                cxl_set_poison_list_overflowed(ct3d);
> +            } else {
> +                frag = g_new0(CXLPoison, 1);
> +
> +                frag->start = dpa + 64;
> +                frag->length = ent->start + ent->length - frag->start;
> +                frag->type = ent->type;
> +                QLIST_INSERT_HEAD(poison_list, frag, node);
> +                ct3d->poison_list_cnt++;
> +            }
> +        }
> +        /* Any fragments have been added, free original entry */
> +        QLIST_REMOVE(ent, node);
> +        g_free(ent);
> +        break;
> +    }

Why not this?

...
    CXLPoison *ent, found = NULL;

...
    QLIST_FOREACH(ent, poison_list, node) {
        /*
         * Test for contained in entry. Simpler than general case
         * as clearing 64 bytes and entries are 64 byte aligned
         */
        if ((dpa >= ent->start) && (dpa < ent->start + ent->length)) {
            found = ent;
	    break;
        }
    }

    /*
     * Do we even need 'found'?  Or is ent null if not found?
     * I'm not sure how QLIST's work.
     */
    if (found) {
        CXLPoison *frag;

        QLIST_REMOVE(found, node);
        ct3d->poison_list_cnt--;

	/* If not clearing the start, create new beginning of range */
        if (dpa > found->start) {
            frag = g_new0(CXLPoison, 1);
            frag->start = found->start;
            frag->length = dpa - found->start;
            frag->type = found->type;
            QLIST_INSERT_HEAD(poison_list, frag, node);
            ct3d->poison_list_cnt++;
	}

	/* If needed, and space available, create new end of range */
        if (dpa + 64 < found->start + found->length) {
            if (ct3d->poison_list_cnt == CXL_POISON_LIST_LIMIT) {
                cxl_set_poison_list_overflowed(ct3d);
            } else {
                frag = g_new0(CXLPoison, 1);

                frag->start = dpa + 64;
                frag->length = found->start + found->length - frag->start;
                frag->type = found->type;
                QLIST_INSERT_HEAD(poison_list, frag, node);
                ct3d->poison_list_cnt++;
            }
        }
        g_free(found);
    }
...

> +    /* Clearing a region with no poison is not an error so always do so */
> +    if (cvc->set_cacheline)

For QEMU coding style you still need '{' '}'.

Ira
