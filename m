Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3327BC636D7
	for <linux-cxl@archiver.kernel.org>; Wed, 22 Feb 2023 01:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbjBVBOT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 21 Feb 2023 20:14:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBVBOS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 21 Feb 2023 20:14:18 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9410E23101
        for <linux-cxl@vger.kernel.org>; Tue, 21 Feb 2023 17:14:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677028456; x=1708564456;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=nT2ZCssP47RAGM2g3sbvO+fGjClggD8+sbELx4El1UE=;
  b=A/S4izN12MzezIehuRCTjIvHjdP0Sos/JS4b91l2/JaRmIlSlPMlj4dJ
   J6UjYWvagLqIU4uWX4EzQTNRLnFuELaIdgSajHj8o/Hki4IQT8uSvsgiB
   TNv6eyyG1NBKDgSqnJw8n3PxFZKXQ+jQN/BoDHgHgdSDvYoO2F3oFpzlo
   u259TnB5GLCTO4krWdiV+BMBHo+oYMxYLTdQW3VcVUNUgWJKbpJcVGkDW
   Wgr8315wV+FjXs26hZ1hdJzKPuhRvy1xXmSCDZOGmLt1Vb6rWWhoXkKIZ
   L0hY96M59BSgK/xgHHzfe4TvZd4bhmbFoy8rYrMKiJ+OKniYTYtouJ2Cz
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="312428310"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="312428310"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 17:14:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="845937234"
X-IronPort-AV: E=Sophos;i="5.97,317,1669104000"; 
   d="scan'208";a="845937234"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga005.jf.intel.com with ESMTP; 21 Feb 2023 17:14:15 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 21 Feb 2023 17:14:15 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 21 Feb 2023 17:14:14 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 21 Feb 2023 17:14:14 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 21 Feb 2023 17:14:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVCCwPTvqrt/jeaCZ7GpWI8MtLb3w9koTucsy4iO2iegMRjvPuH2e4omjAYIZ79JfpUioa1ZMFvn9s/+DhuFZHuaeZDPbQahTDilwNXL49a8g549I1FZ7thvQZfR0jFw5iF+3IQMipd0GA+s9yGNFPFzpG+hid2Aia9diGiAGXWJu39w8Veogh0GLf/wE/v9lNv8yZVqHn2aQqpRmsjZ0YujBODweo6qDqn4S5pHNi8TFhEVniBdemQRxCB6X06uYnFz4cKb32dDfPXgwm7UtuKb0suz9gJsviQy0S9OgnUYViq2oTfcve5bwvJYhe19yrIZEYNGQOqgbx25ByA7mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GrBcKIYoqZbnQpQnBiKAi4nzOem8x/LWVOl0YEF/rHY=;
 b=BrQCstL5Phd0PlJldOFDOv68nUZ6uqIqxRDPTnvKM5AoIewPcu8qm0vjQ7VycAZOOZsxYq/RFTaJa4CzcNhIrcA/MXmWNOEFLAii5iAszfKfMdgmXhpizIQmzSIH0bbu+6TKgyomc+QOl7iLOMM4JyAKjfMHQPiRl58bU2PAsLx7LS0mey6c9E4C4g/gbB4ihh2NHX+ibbxxzLNjm/LxS+SBxuHxaUJutc2kDdD7pbnXusPlMO0itpzC8MXwGQ5NePGpnOmR5ut2R+414/8jZtfRFg2U6L9YL+9+ZA0bVkT7H0qsa6lluPrfY+DeBrJ3tuENhwwGLJbbp5sKCS+NZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BL3PR11MB6506.namprd11.prod.outlook.com (2603:10b6:208:38d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.19; Wed, 22 Feb
 2023 01:14:09 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::84dd:d3f2:6d99:d7ff%8]) with mapi id 15.20.6111.021; Wed, 22 Feb 2023
 01:14:09 +0000
Date:   Tue, 21 Feb 2023 17:14:05 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>
CC:     Ben Widawsky <bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        "Markus Armbruster" <armbru@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>, <alison.schofield@intel.com>
Subject: Re: [PATCH 4/6] hw/cxl: QMP based poison injection support
Message-ID: <63f56c5d6b269_1dc7bb2947c@iweiny-mobl.notmuch>
References: <20230217181812.26995-1-Jonathan.Cameron@huawei.com>
 <20230217181812.26995-5-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230217181812.26995-5-Jonathan.Cameron@huawei.com>
X-ClientProxiedBy: SJ0PR13CA0120.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::35) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BL3PR11MB6506:EE_
X-MS-Office365-Filtering-Correlation-Id: d59300b6-7341-4e94-03cd-08db14721977
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uZBoL7QasJfJ7T+f+nVDxTLAe8UoNBX/Rjxr2E7Apv3ozGcjGjTnvDk/J+zBveS16EVWJ0wW+Y1AtvChodJaekYievsztcTD+lZoGTZSyFCWYYYh0r8iBbac4HN4AIK3GURzbvZO0eUNGKUVGMJ0e064NGetyhDuhM3KYZqrzaVO2ezUIMBlTpDI+vbdFAKxm3VU5eE82zvD+cuVGqyeqAm5OUag5wgGhZ/5vqI9s72wnfjsPzcItOhKma7eDSsK4LWXIxbiLOwkmvkpFbYI3MvuN2qJgpQZ+YQSyh74uPJzISy945UOAct1pbEnDfPEJ1/+08wVF50UbMuH3zfGgepZM1NZsKNZUOOXHOLvDVIt681+COaiwZjDfSUUsa9ZWAwdqajWxg4zzV07R3h/usIuyr25g9PmmlVIGqWsMiOVn3v6ynu0p7yGycBzeCERTqKTBQ4BgupP02ewl7KDHg/cwluuaKAG/L0O15tnQIonhofHBZ5gcVD0yzz4Km38kmKCY6C1meZlycA1N6fMTrEcNIIbSESYtrkQSqpfRl2NpiNExma5/xeZXrX7dIBU3UBLIMwvupEl+VkERwOQBqWVaDGE1T7xGmlu79rZJnUXm/pGfXQXuonoTVVPeeh7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199018)(2906002)(86362001)(30864003)(44832011)(82960400001)(110136005)(38100700002)(66899018)(6512007)(6486002)(478600001)(186003)(6506007)(26005)(9686003)(966005)(66476007)(6666004)(66556008)(66946007)(316002)(41300700001)(83380400001)(54906003)(8676002)(4326008)(107886003)(7416002)(8936002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LzqObNf5hhbqTChsSIwb0OLjg6PZhrNox7u9mnt87XqWeLcbEP6O7+PgWVn/?=
 =?us-ascii?Q?+9G3AdllhMvOXRQTeGOXPFEA6VlVFvzALxOHO/rzBiudJeTQynifwhSLQ2IJ?=
 =?us-ascii?Q?NUXYqeFSh1T+ckHf+mC3QBubvA5VL8MAx7vfOPVstsPubwjPj79uhCStahqp?=
 =?us-ascii?Q?h/shYEDP9B4He8CWKtQ/szHbn7hEu0hkjn+wgT15N2bETjJfuwnHX6dZXmei?=
 =?us-ascii?Q?p4eCMUsRuPxfI4bqbTWFgQRgtcu5dEIRLKEeT+MuDUguWqBiwY36hGONNbL6?=
 =?us-ascii?Q?dWXmBMPyImvEJ6Iy9/sALNt6wwicGHtU/m9NBCvsZDdrgzu9+5lBPO/8ZwmH?=
 =?us-ascii?Q?dPxI3H1kR6tKgfg/Fp1AtUdf5Xi2MT6froIwgKEsIJXalo2n1PvPm4zURp5B?=
 =?us-ascii?Q?ABuR/XFY4+6eyCfSbFsLgrAFhOtwVn4uJVc3oVLw3Z5NnJKx/iz33H2ylr5N?=
 =?us-ascii?Q?k+3emWrtXvU35vd+xnTZq0BjDBQK2/PzpHPM8kcBuPRl8RiNxYivRSsBAYD5?=
 =?us-ascii?Q?Qx4FoBRcL+MqgvyvlkmSE9nfy6bVnuv0T0wo1BQ9a0oZVKZvRmJgNiZrSEmt?=
 =?us-ascii?Q?BrN+kk8DksgK5wiY3RHWl/ki8hbCeDzFHOOvDAl2bSNyK3ktHlN13jWp0Iek?=
 =?us-ascii?Q?VS2e/H0tiRKx8lXDvHWllKJBwwkwzADdn3SU7SFUkcYPujODDb9X8331USUy?=
 =?us-ascii?Q?zNxMxO4VhXx4pXPdx/7iEf1ic/fwp1kI5HmOt0s2GSjgSn8NUynamQSpy7LU?=
 =?us-ascii?Q?SvJZXIZYR9EwqK4jhzPJFbytyUpAfR/9seL8Vser+mKCXWPMH0xZd/zjN260?=
 =?us-ascii?Q?sypbDMWXoXyHO1OeljJt4M516zYN7g05+5bCdDJrlcSF5DK3GdViVZpFf6Kk?=
 =?us-ascii?Q?3YJwDPOdHA6Dl570U6BAt3qcSVqXSQzEQd0xlWhhTlFtRzsnP7fjTIdL41P1?=
 =?us-ascii?Q?75P0YlXoBgFeKVoIRK/5CSolSHE6Z+wlcBGBFBazBd+VAGf7XQySpj9XLrXZ?=
 =?us-ascii?Q?f4Xdj59RaNjDu0SwyAc/wsgbJEnMIJ0KzcfLFfghT8f70ijPskss3BXsCD/z?=
 =?us-ascii?Q?Zn8iiksVTdpyyVPeoG9RnraBUfREKuRCH4NFgDrSK4t7RnGQoqo8JeLw35wA?=
 =?us-ascii?Q?UugNGXyLdre+L+bdEiMui4AdrUUsi63W5xyOXBykaml2lTYqaJQaMGy0Bkna?=
 =?us-ascii?Q?wbu57srwHCFXjHDg3jST2I31jGCT/BpI85P2pxk9+wxGp+Y5MK88LUenaFt1?=
 =?us-ascii?Q?UZI59t/Z7fJGpS8Ktfu3ZXCvisgSKkreLb0t23SVHclcfQ4scNk4NZJjjDTn?=
 =?us-ascii?Q?qvvFurg5SneShO8tnEDORGheMdGWEMt+m4PzwXb2vtO590N7qkfVIz6CF5IG?=
 =?us-ascii?Q?Tv/JCagSFTt2ql1c3xgu7w7v5dpraS5yA9Gmz/CfoxbGxed5x2KW/7Ln50+l?=
 =?us-ascii?Q?/nCqDf+BpEj/Fw/fNRkhwQFAhZC221brSr/PPEvtsN30BOdCbEWedVemz9Jv?=
 =?us-ascii?Q?vFtnWqH4GtTNnOuQcqA21dcHmgxlq2X3ed4zFpvt26ipgvMC60pjfxZ/5eBc?=
 =?us-ascii?Q?JyoW3XDzZiktwvjYGSKLANsLPmmbzH8aVjR9F+n5?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d59300b6-7341-4e94-03cd-08db14721977
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 01:14:09.2395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Njrq1KHBRJnrxNBEA7i9Xys6SDFChW4Q2rtkjaDuaHmFHWCnjvdt2SycaoVd5VExsnj5dTmE2JznzrJwDSiVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR11MB6506
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
> v3:
> Improve QMP documentation.
> 
> v2:
> Moved to QMP to allow for single command.
> Update reference in coverletter
> Added specific setting of type for this approach to injection.
> Drop the unnecessary ct3d class get_poison_list callback.
> Block overlapping regions from being injected
> Handle list overflow
> Use Ira's utility function to get the timestamps
> ---
>  hw/cxl/cxl-mailbox-utils.c  | 82 +++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3.c          | 56 +++++++++++++++++++++++++
>  hw/mem/cxl_type3_stubs.c    |  3 ++
>  hw/mem/meson.build          |  2 +
>  include/hw/cxl/cxl_device.h | 20 +++++++++
>  qapi/cxl.json               | 16 ++++++++
>  6 files changed, 179 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 580366ed2f..cf3cfb10a1 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -62,6 +62,8 @@ enum {
>          #define GET_PARTITION_INFO     0x0
>          #define GET_LSA       0x2
>          #define SET_LSA       0x3
> +    MEDIA_AND_POISON = 0x43,
> +        #define GET_POISON_LIST        0x0
>  };
>  
>  struct cxl_cmd;
> @@ -267,6 +269,8 @@ static CXLRetCode cmd_identify_memory_device(struct cxl_cmd *cmd,
>      id->persistent_capacity = cxl_dstate->pmem_size / CXL_CAPACITY_MULTIPLIER;
>      id->volatile_capacity = cxl_dstate->vmem_size / CXL_CAPACITY_MULTIPLIER;
>      id->lsa_size = cvc->get_lsa_size(ct3d);
> +    id->poison_list_max_mer[1] = 0x1; /* 256 poison records */

Using st24_le_p() would be more robust I think.

> +    id->inject_poison_limit = 0; /* No limit - so limited by main poison record limit */
>  
>      *len = sizeof(*id);
>      return CXL_MBOX_SUCCESS;
> @@ -356,6 +360,82 @@ static CXLRetCode cmd_ccls_set_lsa(struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
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
> +    uint64_t query_start = in->pa;

Should we verify Bits[5:0] are 0?

> +    uint64_t query_length = in->length;

Isn't in->length in units of 64bytes?  Does that get converted somewhere?

> +    CXLPoisonList *poison_list = &ct3d->poison_list;
> +    CXLPoison *ent;
> +    uint16_t out_pl_len;
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
> +        out->records[i].addr = start | (ent->type & 0x3);

cpu_to_le64()?

> +        out->records[i].length = (stop - start) / 64;

cpu_to_le32()?

> +        i++;
> +    }
> +    if (ct3d->poison_list_overflowed) {
> +        out->flags = (1 << 1);
> +        out->overflow_timestamp = ct3d->poison_list_overflow_ts;

cpu_to_le64()?

> +    }
> +    out->count = record_count;
> +    *len = out_pl_len;
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
>  #define IMMEDIATE_DATA_CHANGE (1 << 2)
>  #define IMMEDIATE_POLICY_CHANGE (1 << 3)
> @@ -383,6 +463,8 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
>      [CCLS][GET_LSA] = { "CCLS_GET_LSA", cmd_ccls_get_lsa, 8, 0 },
>      [CCLS][SET_LSA] = { "CCLS_SET_LSA", cmd_ccls_set_lsa,
>          ~0, IMMEDIATE_CONFIG_CHANGE | IMMEDIATE_DATA_CHANGE },
> +    [MEDIA_AND_POISON][GET_POISON_LIST] = { "MEDIA_AND_POISON_GET_POISON_LIST",
> +        cmd_media_get_poison_list, 16, 0 },
>  };
>  
>  void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 8b7727a75b..3585f78b4e 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -925,6 +925,62 @@ static void set_lsa(CXLType3Dev *ct3d, const void *buf, uint64_t size,
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
> index b6b51ced54..6055190ca6 100644
> --- a/hw/mem/cxl_type3_stubs.c
> +++ b/hw/mem/cxl_type3_stubs.c
> @@ -2,6 +2,9 @@
>  #include "qemu/osdep.h"
>  #include "qapi/qapi-commands-cxl.h"
>  
> +void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
> +                           Error **errp) {}
> +
>  void qmp_cxl_inject_uncorrectable_errors(const char *path,
>                                           CXLUncorErrorRecordList *errors,
>                                           Error **errp) {}
> diff --git a/hw/mem/meson.build b/hw/mem/meson.build
> index 56c2618b84..930c67e390 100644
> --- a/hw/mem/meson.build
> +++ b/hw/mem/meson.build
> @@ -10,3 +10,5 @@ softmmu_ss.add(when: 'CONFIG_ALL', if_true: files('cxl_type3_stubs.c'))
>  softmmu_ss.add_all(when: 'CONFIG_MEM_DEVICE', if_true: mem_ss)
>  
>  softmmu_ss.add(when: 'CONFIG_SPARSE_MEM', if_true: files('sparse-mem.c'))
> +softmmu_ss.add(when: 'CONFIG_CXL_MEM_DEVICE', if_false: files('cxl_type3_stubs.c'))
> +softmmu_ss.add(when: 'CONFIG_ALL', if_true: files('cxl_type3_stubs.c'))
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 44fea2d649..3cb77fe8a5 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -270,6 +270,18 @@ typedef struct CXLError {
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
> @@ -292,6 +304,12 @@ struct CXLType3Dev {
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
> @@ -317,4 +335,6 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
>  
>  uint64_t cxl_device_get_timestamp(CXLDeviceState *cxlds);
>  
> +void cxl_set_poison_list_overflowed(CXLType3Dev *ct3d);
> +
>  #endif
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index ac7e167fa2..bc099d695e 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -5,6 +5,22 @@
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
> +# @start: Start address

NIT: "Must be 64 bytes aligned."

> +# @length: Length of poison to inject

NIT: "Must be in multiples of 64 bytes."

Ira

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


