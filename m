Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8BAC6FA8E
	for <linux-cxl@archiver.kernel.org>; Fri,  3 Mar 2023 01:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjCCBFg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Mar 2023 20:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCCBFf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 2 Mar 2023 20:05:35 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237D03E09B
        for <linux-cxl@vger.kernel.org>; Thu,  2 Mar 2023 17:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677805531; x=1709341531;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=02EWcBlxuAs9mkzxmRjwqMxCMtLStHyMAepKhhoWLno=;
  b=ACMlPKnSFb6gHSKn5VCLSZCKxy8QDLoztxvSGOwgyfMh2eUlYc6rDtEF
   bSMLQTrx5rRrR/dviROKbuVCmhgk67rY91ZLrXHt8IV+ReeiRWULZWP2w
   6NzinBKHE4Co9HBeTqhYZLkj/HlXCcwBVG1zn0ZZJx9sZWUgn9nUoKud/
   ZqKKjDCG4KvQHlzDwkMPaFZFPWvrrqk0iYF7ddKnrrUHSpBFtDxUk1cpH
   fUrZ0qj3oNda55SoRs2WLEjfgIpTiNBfYjgax4C+bOP6XtXEVrA/L2pcA
   bY840gpmacR4TxkMVg/SHI9GtBvTwIdyT7QNf69XppalBz1/5gdKQp/kN
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="421184636"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="421184636"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 17:05:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="739314190"
X-IronPort-AV: E=Sophos;i="5.98,229,1673942400"; 
   d="scan'208";a="739314190"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 02 Mar 2023 17:05:30 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 17:05:30 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 2 Mar 2023 17:05:29 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 2 Mar 2023 17:05:29 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.43) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 2 Mar 2023 17:05:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b1hZQvqU8TSa9qRNnt3fjy4Psm0w4CHFu2uB82qjMDFkFnVvhzGNtBjY8TlCBEiiVAZ+dsbDgCbuH+C18opIIZnyVl3znxLC418T10+RqKcN3NaYqZ4gDRQrd1YQJBrA+TQphDTyj7lec73Oa3r5EFXzrC5pbSX68SYlJ8k1q1xbP17c+Iao1Mk7jy4Y43XgMHpHWEY+liRoHWR7zRLh7jjTnOWoPKJZ1diPctFn/AQpJcEvWQ8lPtlv9H6umBz12ks6jelasVxRk9+3qrfaUxVllHIReB46enpjboMthgizcz3xP8CZ9tSHlWrLYnbZ6qBFA4yyt0cPP+ZEIRaCOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WAtOIVcc2wXk4FEGMSDnq6PuJj/34vkdt2ccdOEnh0Q=;
 b=a6WzQBXTzKp7s2tKi/7TUczO3VH3+ADEURyDJkXrkjrn2By6RKgcis/N1khdB8R/RHCxARoo7KMVsbZP/FP72RBTZzLFNgedYEFmWSy5bi79SNFKhrykrMmCDcQ+F1SI9vHkKV3OFeh2psc66ZQLoPHL+PAAu9ElGUQHy6EKPfbAURD2oGolejVdr5oyaXV7DKmoEeYd4zVBCu6XHGBo+7oV875uXmYqAAs536Xde/VQXykHzpXyJzrhwvaB52KLOBklFc/+i8Ro5nAHTlAXSyx+lAvB0/yhwluogxKk/kw0cx9QOyIE7YjzLfHFO1g56/Tb0NDz2u2VcD2jtwwTGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB6858.namprd11.prod.outlook.com (2603:10b6:510:1ee::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.19; Fri, 3 Mar
 2023 01:05:27 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff%7]) with mapi id 15.20.6156.019; Fri, 3 Mar 2023
 01:05:26 +0000
Date:   Thu, 2 Mar 2023 17:05:22 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>
CC:     <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3 6/6] hw/cxl: Add clear poison mailbox command support.
Message-ID: <640147d2b67a4_46c602945@iweiny-mobl.notmuch>
References: <20230302101710.1652-1-Jonathan.Cameron@huawei.com>
 <20230302101710.1652-7-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230302101710.1652-7-Jonathan.Cameron@huawei.com>
X-ClientProxiedBy: SJ0PR05CA0180.namprd05.prod.outlook.com
 (2603:10b6:a03:339::35) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB6858:EE_
X-MS-Office365-Filtering-Correlation-Id: 23e6e56d-191d-47b1-6548-08db1b835fcb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kcd/5Jo02vazCTO/xIwr5DBIguzBSfSiA7fDaaukYJUtDxCo6o/lrzSff48QL8DYZbQ2yQm/6r4i7S4L+g6LvQopU15hGwwR+n0n0/CCjMqWzbDSg+9xeLdvWBkMeaQt0VbiKUiN1Tz8/bD1dk97PFEUUK67Nrw5ofNB3KsC9oD5PGGqSAVr1KBY1Qsv8/AxQ/Nj+W+lcBPmM27ci5BnU4VGTVQzAM5tkD6qNfN0JBmbbbpqH6wevj9omeIniGptHP4ma/HdPTsaLTfFlNoAOzuz7AXeaJCcZGf9yfsdoOAbWMqQgSsr9Ry2rgxYydE6GrIFieL9bqFHU/1ga88IFUhaPz4c6Ujj6S/FGUHGGsmtswUXLiGdLaN77z2/BgeUy+jH0FOC+230SDNcURGDczbeRZd3v2rXl0qWSxGLr001NYbPdgL2lrIbVS/iSL8UJ4rr3Nh4YeGNQCj1/d24WvNN15coYcPMFZTjnCGt8WcblrdUjQosSUYzhq648SwGTnDoE7xCn2i2HXuMTudKHvBYYY5dDQ6Jl6bzPb1HB3NvZKgONZ3+Htu6M0MjIAYydjizXwkrPlo1rndFGqCebXsG/wJqM7qdNcn6BoV/cIIZpEyQPzKgMGQ2QA/JgCsHxqCyDnT71/kkU9zH0kguwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(39860400002)(396003)(136003)(376002)(346002)(451199018)(83380400001)(6666004)(38100700002)(478600001)(5660300002)(82960400001)(8936002)(66556008)(86362001)(26005)(186003)(9686003)(6486002)(6506007)(6512007)(8676002)(2906002)(66946007)(44832011)(15650500001)(66476007)(316002)(41300700001)(4326008)(54906003)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0c5TnR0zh8HysaCn1xLFN5K27lHZi5fZN5POe+XjopS2TBkxM+KV13u8TrRo?=
 =?us-ascii?Q?XOyEGtA/4kQzAQqgGqw4XMOqjJ6jMPCvPAN0S9qJpaTJhV+SLt1bwPnPJSbl?=
 =?us-ascii?Q?93AC+iy7jzOISkrRoER2Bx4fXxl05JwNNRtBHe2CovHlE2ulBT2ZvNogTIhI?=
 =?us-ascii?Q?Gp6/AxtaQ9ejtoH40MlHsv8wWKu7GvR2sP0nQk3qjBxEIZWIqHHrLUSrGZj5?=
 =?us-ascii?Q?XoRrZAXqFAQ9u40rEbrxtk55vo5+LNDiMkN4Obo/M0Cq4PPt+vuqakI0Izpy?=
 =?us-ascii?Q?HpXWcczLgsMdc4gHfClejPTgPtL/yJTg674pZsj6O8cBqlplOMYjZrNVFvS4?=
 =?us-ascii?Q?oBazHyA7sHUyAEQm0uysLldBgWgVT0S3swYBjNbmGLtUOtSDG+60x4kol2q4?=
 =?us-ascii?Q?dvZOQ8O3M3b1NAt57MMOhW3+3rWtjPhpTigay7ePp5Wp5f+P1ZE96t2ZjAJ4?=
 =?us-ascii?Q?4ZqDXrLo+Ol/OBmGcubAy4c371a/L0pp0eK65qHMNQuyXRi5aPJfaazFcf23?=
 =?us-ascii?Q?/jaSpoO6veEz1Q1UdeFxU3i8PKSQrnGDdXF6yZLxPUxiAMIFjEa1qzge40oW?=
 =?us-ascii?Q?9DB5ZJ438O1jrGFhs3VK5UEbn8lxlIEs0L0C8MhHhO80TOH97LBGewx22/f0?=
 =?us-ascii?Q?sztIJr3cBB/PhJ5c3eUUIBERo7i+I3wVtkuwnaJKvLNMq1BaAW7cz4PA0/hd?=
 =?us-ascii?Q?FyELC8jobAGpROw2TdU9Odqh47Oqvs98opCmhblch+xYw928V6V1K64IfMnn?=
 =?us-ascii?Q?C1xYHaitH0ieU8On3stg5zpLgWcgAM22qEPFmVNBdnIbxPUn4udf9AVNRk0P?=
 =?us-ascii?Q?8D0WHdDhOlXeI9eTq2xCCBdXOpIUR+KxHqYirq2NOmutHeEGv/LXITjv4LMj?=
 =?us-ascii?Q?Uas1GqPix89ji54zFborDE82lYIMyw8AWvxrPVPzJurhaLIrhPy9mcqHjns4?=
 =?us-ascii?Q?ecriYwGVIngeErYHmAI0RiSbBz/S07gKIEINm8uHYZslE1PWrJskf3mdxLyH?=
 =?us-ascii?Q?ZPGYS8M03wmzt1twt8OwqvvbsGlpLNKwxb8PZYQDT7jgvxe869Mfl/GvEXum?=
 =?us-ascii?Q?tD+x2Ng2JoduTLes4RcpxRbz5jIJIG400+fg3JT5BYn4ZWrnda4qu8djO6I2?=
 =?us-ascii?Q?QgXOO4F1jWfwMkZn9dJAsZtIVA7xqnzRFJIu6Qtp2lBLenfrbRWK2f/uoHjV?=
 =?us-ascii?Q?YQGsUBn489fcTuT7BuBr0b22v0XaP4B9hddegmqmIAcn0xgb+/o5S6KrixeH?=
 =?us-ascii?Q?y+Z46vKxuVSCLL2ea8biOwVyBwqexsIid2taJyynsxZN4rqWL66O5kq6HGlY?=
 =?us-ascii?Q?uvnuvsOoM2DAfXjNomndqYsAl3OgUM/bysyUjuWEvHPjvU1OHmZRbIAQpQGl?=
 =?us-ascii?Q?vzFqpNZxCtGkf0WjqygKKgmnXP6IZTAfQs6m+kuiOxjjrJcAPS4nreHwWEiQ?=
 =?us-ascii?Q?JquiD0QCg/biLx2NJfD61AA2XsH/ic2LZl9UAzBsbpp1WRkGIcB5WfPNDxOk?=
 =?us-ascii?Q?SfiFk/doXJtiZSaHjlnlBDBGZsfZKZqo8j7s6pSsb56/kdQ79Aiyfs+mxnXb?=
 =?us-ascii?Q?GlSFlzlTsX3rfEVg1kKZOh37myH4Ze4/qqnsQ/H+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e6e56d-191d-47b1-6548-08db1b835fcb
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2023 01:05:26.8327
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cKHphm0YoqqB2ViLKZ8hQp1t6XRjp5K4n5v2o/cZ5gr+Ppmv3SB4dJH8oUX5Qq0DqrmsSBowIFv5RpqfF4H50w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6858
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> Current implementation is very simple so many of the corner
> cases do not exist (e.g. fragmenting larger poison list entries)
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v2:
> - Endian fix
> ---
>  hw/cxl/cxl-mailbox-utils.c  | 79 +++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3.c          | 36 +++++++++++++++++
>  include/hw/cxl/cxl_device.h |  1 +
>  3 files changed, 116 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index da8732a547..f2a339bedc 100644
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
> @@ -511,6 +512,82 @@ static CXLRetCode cmd_media_inject_poison(struct cxl_cmd *cmd,
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
> +    QLIST_FOREACH(ent, poison_list, node) {

Because you are removing from the list I think this needs to be
QLIST_FOREACH_SAFE()? 

> +        /*
> +         * Test for contained in entry. Simpler than general case
> +         * as clearing 64 bytes and entries 64 byte aligned
> +         */
> +        if ((dpa < ent->start) || (dpa >= ent->start + ent->length)) {
> +            continue;
> +        }
> +        /* Do accounting early as we know one will go away */
> +        ct3d->poison_list_cnt--;
> +        if (dpa > ent->start) {
> +            CXLPoison *frag;
> +            if (ct3d->poison_list_cnt == CXL_POISON_LIST_LIMIT) {

I'm still not seeing how this is ever going to be true with the above
decrement?

> +                cxl_set_poison_list_overflowed(ct3d);
> +                break;
> +            }
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

Or this one.

> +                cxl_set_poison_list_overflowed(ct3d);
> +                break;
> +            }
> +
> +            frag = g_new0(CXLPoison, 1);
> +
> +            frag->start = dpa + 64;
> +            frag->length = ent->start + ent->length - frag->start;
> +            frag->type = ent->type;
> +            QLIST_INSERT_HEAD(poison_list, frag, node);
> +            ct3d->poison_list_cnt++;
> +        }
> +        /* Any fragments have been added, free original entry */
> +        QLIST_REMOVE(ent, node);

I think the decrement needs to happen here.

> +        g_free(ent);
> +        break;
> +    }
> +    /* Clearing a region with no poison is not an error so always do so */
> +    if (cvc->set_cacheline)
> +        if (!cvc->set_cacheline(ct3d, dpa, in->data)) {
> +            return CXL_MBOX_INTERNAL_ERROR;
> +        }
> +
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
>  #define IMMEDIATE_DATA_CHANGE (1 << 2)
>  #define IMMEDIATE_POLICY_CHANGE (1 << 3)
> @@ -542,6 +619,8 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
>          cmd_media_get_poison_list, 16, 0 },
>      [MEDIA_AND_POISON][INJECT_POISON] = { "MEDIA_AND_POISON_INJECT_POISON",
>          cmd_media_inject_poison, 8, 0 },
> +    [MEDIA_AND_POISON][CLEAR_POISON] = { "MEDIA_AND_POISON_CLEAR_POISON",
> +        cmd_media_clear_poison, 72, 0 },
>  };
>  
>  void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 21e3a84785..44ffc7d9b0 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -919,6 +919,41 @@ static void set_lsa(CXLType3Dev *ct3d, const void *buf, uint64_t size,
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
> +    if (dpa_offset + 64 > int128_get64(ct3d->cxl_dstate.mem_size)) {
> +        return false;
> +    }
> +
> +    if (vmr) {
> +        if (dpa_offset <= int128_get64(vmr->size)) {

vmr->size - 64?

Ira

> +            as = &ct3d->hostvmem_as;
> +        } else {
> +            as = &ct3d->hostpmem_as;
> +            dpa_offset -= vmr->size;
> +        }
> +    } else {
> +        as = &ct3d->hostpmem_as;
> +    }
> +
> +    address_space_write(as, dpa_offset, MEMTXATTRS_UNSPECIFIED, &data, 64);
> +    return true;
> +}
> +
>  void cxl_set_poison_list_overflowed(CXLType3Dev *ct3d)
>  {
>          ct3d->poison_list_overflowed = true;
> @@ -1140,6 +1175,7 @@ static void ct3_class_init(ObjectClass *oc, void *data)
>      cvc->get_lsa_size = get_lsa_size;
>      cvc->get_lsa = get_lsa;
>      cvc->set_lsa = set_lsa;
> +    cvc->set_cacheline = set_cacheline;
>  }
>  
>  static const TypeInfo ct3d_info = {
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 32c234ea91..73328a52cf 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -298,6 +298,7 @@ struct CXLType3Class {
>                          uint64_t offset);
>      void (*set_lsa)(CXLType3Dev *ct3d, const void *buf, uint64_t size,
>                      uint64_t offset);
> +    bool (*set_cacheline)(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data);
>  };
>  
>  MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
> -- 
> 2.37.2
> 


