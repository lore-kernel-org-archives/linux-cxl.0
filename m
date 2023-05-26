Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5D1C77B7A
	for <linux-cxl@archiver.kernel.org>; Fri, 26 May 2023 20:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237796AbjEZUi5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 26 May 2023 16:38:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236947AbjEZUiz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 26 May 2023 16:38:55 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA731B6
        for <linux-cxl@vger.kernel.org>; Fri, 26 May 2023 13:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685133531; x=1716669531;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=WpvCPXbbSfuTM3Tt40iOpRl0GRsOMd2KrtdURG+IZAw=;
  b=FR+gN2Oph8edwblXRw/55zkelzWcdhXEvRhrpqGRe1KzkFmq1RBXRFyV
   /13ZxmIZIt5sEdMz+7Ee+eeA4KChX2h+VVER0LnU0mgKPy3z9hPtazH3y
   GRPRNnFS6aNszBTA/D6lGaNYxaEm5IepKjn+aoAmyx22gcLFBMymfr2Br
   FHhuUOpRiLtH2pR9QrZY0aum0bn0nru7B6AlUqCNyppdglaS55gR80gHe
   pJXRSJyNXueTaYV2WTz1hVDDhkQkkFTQ6QwOMF4CDbX8JyOkx5DGTqF9Z
   V7nDZcVxvIGTHNK7u5mFNKp8sgzkw7NNVsvBHe32yvOM1EDLYOYxImQe+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="334654235"
X-IronPort-AV: E=Sophos;i="6.00,195,1681196400"; 
   d="scan'208";a="334654235"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2023 13:38:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10722"; a="655764561"
X-IronPort-AV: E=Sophos;i="6.00,195,1681196400"; 
   d="scan'208";a="655764561"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 26 May 2023 13:38:50 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 26 May 2023 13:38:50 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 26 May 2023 13:38:49 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 26 May 2023 13:38:49 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 26 May 2023 13:38:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AA1AIgAIy1DBXXvTCPL3Dvpfqbp8ZGEyFaMCyVaW+Njpsp3Aa0YL9+P/IIvBQQcuGMwxaCFGPjABmDpDvL0vXmOgzHOykKRd7BkQhnaUoSYe8ZJH/XirJvDmim31kCixyMHLUvcnuK7hDP1RhW86nh6lXzDKBk6r6xWFalINgQC/7+4qKg2pOSzLze2VFLhRn6ChGDpk3GqgNh6KPOcjyhz57fs0jtZNXdIhAU78ek1dOj3epSSezR6KX+g0hLHwuspXt1LcvfsJRIg/BMwCfxRCK0SY4qw+OxqdgAv4QWfIbo0AGM7/sDCcRT0LXHc/sGiUDEYbP7s3HVrsX1iavw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hepDgU4V4g117GkPBXeQEaB9jgboSPUQcL9dJ49188Q=;
 b=j68qlBixTVfXdQ5c2I7x5yMuZcMHm5w0DvLp2n8FqxshOeilxkLATAhvurArEL5R7YOuS17BdU1vR6d3q/qP9CTD1SQrtwxutYLOzwK+e/BISJidQEtmNYL9uf3badr73oVGjoynV836D8slDvaCs0q2eipnEpisRKTvwFRLTDEyuE2BZ44ozHQqdWdGzAeodH49DRULBTwtqU1MNikHrdbC0sqPAqrD9L9qden8+XN5sjp86AuXA2OXFyJ+UIJy6QmNq4zGEb9wgKaqUIm/Ozt91WBTXZgy5k8yES1dPF/IXJdOvhTymEtPOWxRxLwhjs3pVX6F7qFsjIAcoPODBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB7542.namprd11.prod.outlook.com (2603:10b6:510:28b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.18; Fri, 26 May
 2023 20:38:47 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6433.017; Fri, 26 May 2023
 20:38:47 +0000
Date:   Fri, 26 May 2023 13:38:44 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <alison.schofield@intel.com>
Subject: RE: [PATCH] cxl: Explicitly initialize resources when media is not
 ready
Message-ID: <647118d45239c_33fb329436@dwillia2-xfh.jf.intel.com.notmuch>
References: <168506118166.3004974.13523455340007852589.stgit@djiang5-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <168506118166.3004974.13523455340007852589.stgit@djiang5-mobl3>
X-ClientProxiedBy: SJ0PR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::13) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB7542:EE_
X-MS-Office365-Filtering-Correlation-Id: 283d19b9-36c6-4dfe-e7a8-08db5e293424
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p4AFh5NUS7JH0EFyu4NR2BZ7bznFUut3kyOhpMZGWAJsudEbo6Wuzc4Ze+/Qi8BDoMETUHHQeF6zsMUiAWaq1s1USbmyvnQVrH1hn5FnUti/g9E6ynYcwP4VccoaNta8y0t7+5Ut4AR0l6Fen8qu2xKxNCJywl3MRwczWX3rGUSqGjCZBKEmgWMzcfJYIwqXrTc5fuTAonDBYFEaPcOvnkDPZj96CON0ywSUh8jMovkKG26gj4txtlKWbBypUU42X2ttOp/JnKB2Oax0rhWfFd5UzKy+CaUaAoNHA8KqgQdq1k2V1zSftel5b2qmzImBbo8NXju1j/lAv21xGmRZKYk4r050mI7cxcYsD96iMIWo2bD8eohHk4hszzXmUDpCvqy3zuIQnSJKhRV3LItChIWEIN0Xxm/G7V9by3DumALcXlDUK70nsyIj8HPYTSjhGd+h70oqI/mqDyAqHRQBk73ykgkJgeF+Sgiy16Ef8v8VD/Xkz5noP+wNOO/0YHZbKgS+EXI0H9y+Q+okvcZCKihTFLFbyVtpcoTfaVGI0vYJJj7hbjSSVfbhRUIeZuPP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(376002)(346002)(136003)(366004)(396003)(451199021)(186003)(86362001)(83380400001)(478600001)(2906002)(107886003)(66946007)(66476007)(82960400001)(4326008)(66556008)(6666004)(316002)(6506007)(6512007)(26005)(9686003)(6486002)(5660300002)(8936002)(8676002)(41300700001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dKUDL7whFLxmHUqOSGuq5CLc2hzJCDx2pM51r/Fy87aLpxDOUJpaZ/Nh79Uz?=
 =?us-ascii?Q?FSas02DSyY9l6vSR19XoCU3MJtxBFJIE2QBtRSMUVNq4bN3TB/edO45QClZm?=
 =?us-ascii?Q?YatsA20Iz9H5f0Keu9ycOaJz6Hdt0q2OtsVJmMVmOpWOPJ8ELRS4nfn9IaQa?=
 =?us-ascii?Q?vZGHVkRNdKb2G7mOlrOdC8JUZVl+iznY8KWNNXVLjrQV9gxkZRnwzzYjxF8z?=
 =?us-ascii?Q?R3woAb7bqMGV05rfzfA3rqrVZ/QC6rzLWHG37sAcAgcMnxJwRKSKFtIXfieq?=
 =?us-ascii?Q?Scqfdfw/JENtXhtJXBzQ/p9b3exVlj+ulg8EPUc+sx+Vbqx4aZrgPezuvTsv?=
 =?us-ascii?Q?uVgObm5P1YSQykOlxzP7HkovKwWs0BO1PHZRSbmxU+DQRtIM/FgpmQuD8sEV?=
 =?us-ascii?Q?/j/Xa8qBKqC604MaE/MzfBhCSIwmQHjRptZDrVYnSkGSITye3V35/974wa8d?=
 =?us-ascii?Q?Qi5zhP9TePz6p3V5j4t/sr+H4zQOC/4v9WSKh4VrAvj91uULwBm6/4ImxumA?=
 =?us-ascii?Q?bWWub8QFynw6CFZw7ZAK6jU020H5i29tUFfwXYjSOXxC5q1/1ImjhkK9nMPZ?=
 =?us-ascii?Q?be2CiWDUyV7TGjrfc8tkOrJeAxo4qLDIuO4hPiv4tzg1menzh796dg6KZRhI?=
 =?us-ascii?Q?6ktz2r7pnWznV/jvaE3hncHaJ1D4Oa8iG+ugwp0CxFOpDlkdu7ia4FsX66LZ?=
 =?us-ascii?Q?8R6aFNRJ5R0JaCeANJ0D+0M3XaNtmEB2c8AInfe3j1MAKPfvHUt45aKFrazM?=
 =?us-ascii?Q?okYpjJjDOybHHkynzRaib3DfVGZXx9hWzqE1W80XDeOelHs7iI4qwfk7cq9+?=
 =?us-ascii?Q?OePld9DEnuyKlIRffJyUtypFbjaqacFf6mONn2kspPhmsukOVB9KC+O9bb61?=
 =?us-ascii?Q?2z2UySRsitL3sflTXGuAPZWDitg0dkFKoxPGL6AaoOvv+YIl9nNb7Gw+92zo?=
 =?us-ascii?Q?JtqM/oNH91i/6w5AxALCHie5mQPrQA5UAKJO3Gk+sRZZputH4fsgeuPM/F0F?=
 =?us-ascii?Q?0ezyHG5EQmyHmL/rNXAJ5lf06Bs8RDUvLqvtqB/Mt9iJhYvjTdYSrteDOTWF?=
 =?us-ascii?Q?ATcUXc+zAFr/bzOlcxqaXYlk52QLz9B1IyNom2pXZaH3mSk1xa6eMWnGzbss?=
 =?us-ascii?Q?YfDrIynvht0pVoI78/NXh4+binTjqziq8YsbzE6NYYRGLJiVRAz1cThJIQoG?=
 =?us-ascii?Q?jnOJ0JLVHi+J5RZVTuoPITMCmWk/KKnoDk7BVKCJ+MlTxlnqiBz0KrNNoF55?=
 =?us-ascii?Q?A7tumVqX5Dy6Q/obKoi0uft5G47EeU1RT9o0uTtDhMxF733BcRgY2yqZImqp?=
 =?us-ascii?Q?xV/JV+Xyq+jONc8/XBouZ9aZ2bVc6bCCkb/mfIdNkGQ07NoBznnPIZjSD/iz?=
 =?us-ascii?Q?RLjkGbpAt/V5lj1JEshw2XyRoi1h5jpeOvE7VILhC/leu8aFo2GM/x/GImR5?=
 =?us-ascii?Q?uVrgDDcaDsDMnlOzNiDcvtgksGcE8Ej/aF8Ekb/Z4ljbdkLJhkQ3iit/C9pT?=
 =?us-ascii?Q?4uZyxcxofFSsjp0Eb5uQtbNKJ3O8k3NbnUUaaAeRu9c4KTkw6IhsrU334kbe?=
 =?us-ascii?Q?oLeApRi9FAFHt0BbH7+8USkgWs8XMLlfs4rh2UQoDdzYVT945CIjjB+2tmBJ?=
 =?us-ascii?Q?Vg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 283d19b9-36c6-4dfe-e7a8-08db5e293424
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2023 20:38:46.6533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XnDk0RRldJyrO0ZPzdVePU0uMxsmytnDFbusHpYDSUp0q+fl1TAktv5G0i+sqDuZRf2POpJQqXVpDzHBrq70CmibiNn1RZx20tm92KGf05Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7542
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> When media is not ready, all media information are not read from the
> device. Explicitly set zero out the resources instead of going through the
> success code path with 0 size capacity to init the resources and return.
> 
> Fixes: e764f12208b9 ("cxl: Move cxl_await_media_ready() to before capacity info retrieval")
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/mbox.c |   17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 2c8dc7e2b84d..e1d257051a7d 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1105,6 +1105,13 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds)
>  	struct device *dev = cxlds->dev;
>  	int rc;
>  
> +	if (!cxlds->media_ready) {
> +		cxlds->dpa_res = (struct resource)DEFINE_RES_MEM(0, 0);
> +		cxlds->ram_res = (struct resource)DEFINE_RES_MEM(0, 0);
> +		cxlds->pmem_res = (struct resource)DEFINE_RES_MEM(0, 0);

Btw, DEFINE_RES_MEM() already casts the result to (struct resource), so
I'll drop those casts on applying.
