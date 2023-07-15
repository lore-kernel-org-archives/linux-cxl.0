Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A986C001DC
	for <linux-cxl@archiver.kernel.org>; Sat, 15 Jul 2023 03:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjGODQ1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 14 Jul 2023 23:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGODQZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 14 Jul 2023 23:16:25 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E5CF35BD
        for <linux-cxl@vger.kernel.org>; Fri, 14 Jul 2023 20:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689390985; x=1720926985;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=e3WZouWcIee37SCPGFTjMnzqJp0HsjDUZR1EID5/jn0=;
  b=ZHFiAlPtT/DNwbIhmrzCNRBDEWVJ43WJiv4FVcBNzxlUbvL5jkNJVM5l
   9c1BQIX//d2GVB7y5P1XjvDqHnI7N/RMPsUUnacwvtymMu+M3xWUJvVOm
   Ba63ZTj+jiLywiO2WHoaT5l02vg/BwAHbBALa20KaaBsMd8fQn8lF79oY
   31QbroDgJ/iQzkWZyfKiDeCIrJGhLkaHwMZ4cHodS+9rERmISsLOYjp6/
   t92EQU4v+tchmD+Xwa9POrbJk+MNSVQGCNbTHxgZI0geDL4p1c+jipZp4
   uKdDGiCV5vnHi4r++9BaayPPN17dKHLTH+CGTu1weGvl2iv9jmoRA21HS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="364497876"
X-IronPort-AV: E=Sophos;i="6.01,207,1684825200"; 
   d="scan'208";a="364497876"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 20:16:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="757780643"
X-IronPort-AV: E=Sophos;i="6.01,207,1684825200"; 
   d="scan'208";a="757780643"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 14 Jul 2023 20:16:23 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 14 Jul 2023 20:16:22 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 14 Jul 2023 20:16:22 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 14 Jul 2023 20:16:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/yokuCaKq6wP/Tc5f6WrzaLCTz14k58ynIdThzJQJIDFh7Jzoo95EZ5aTc7BiR2OnxbOXuU29pxKyHVhAVtYSOlEsBSwDz8ssRpC+MFfuoR+EDqr51i4vqBt7YYpwDuIxN1AkSOtTByWiEDSIznFMAiwomUqvCodDIDuL5IpMjaCaVBM/m1w53Rn6cfQ9BVhSwVz0m15YVxQqaalNSMdgeFFVDfjQfLDFfuh2J4IySYBlmfmzV+hqjU3O5c9cssWgJdp1U4J98WWzLnpbnqFD9SkvKrK58TMEIMXQgvnR9G5TkqmmUgLtk+fv3KQzZklN8i93Mq+raahOJMDhWKgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y/usyNLcn7T9wrzeTkFNk0ZflxI0mOyyduxZdBd1lLA=;
 b=I3r0LBxzqfmwLhpn+OBADI0wR4EpJTHv4HY9coZSckQYTMPZiKQbNQknOtDd1Nzra/WzQJe253Sox/pW/4zjS9F8c94HkKban95VCmLvYga/fUB2ZVd/Dx50GBNOazw6nIj5k+QvKFCV/MGat7xCe4rYuElXyvw/w+/hQnyLYSkUN+/j7w4yBTzxT1T60ILMNDmFatK0IrNp/aSFBcH9e6LQkHN0DNvs/G2fc1aPMPRuKk2cSsooxDWNgqMODL2PxICUYu+7SlrY0BrxKn42/JrsXJOX9/ZycnTUtPFaabHBxhv1hD6atD9eCF+dRO77VpUUgdDfWIDDBznBwTr98A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6137.namprd11.prod.outlook.com (2603:10b6:930:2b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.28; Sat, 15 Jul
 2023 03:16:20 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::aeb:12b5:6ac9:fab0%7]) with mapi id 15.20.6500.029; Sat, 15 Jul 2023
 03:16:20 +0000
Date:   Fri, 14 Jul 2023 20:16:15 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Breno Leitao <leitao@debian.org>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <bwidawsk@kernel.org>, <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dave.jiang@intel.com>
Subject: RE: [PATCH v3 1/2] cxl/acpi: Fix UAF in the error path
Message-ID: <64b20f7fc808e_45a62943b@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230714093146.2253438-1-leitao@debian.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230714093146.2253438-1-leitao@debian.org>
X-ClientProxiedBy: MW4PR04CA0131.namprd04.prod.outlook.com
 (2603:10b6:303:84::16) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6137:EE_
X-MS-Office365-Filtering-Correlation-Id: 78912ede-7e5a-4760-b4e1-08db84e1dc09
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G/8YxrvptFAmRHjMZy+tMc/4hDlnrsIRhqX30pcY5oflg+1UHRGq8UFR3QMVIGzHowxm2412ryX9a/8lpGvCr2Ku7Gnjb9f5F+XHmUW6PEOcsqc2kqHT1ecVN8yYAn47jaciB6Q4FJTwyUcLzqNc4nWFVMu3MyvnhvQBedbwwHxhhtKPXRNDbBvJkVgAqGFmYgCSv+AuSxP6+Ha55mXPcYxB/REbX70nGStm+7nCdjjyhTxrbCbm7vBnRKblV0CDofJPUxCIrCl5imayV26otfsgbr5m3u5wcXzGxY/cz22MxzCU0VcMNZvJeM49FiwJC3KnNcQZNpvLt9nb2spabu4PBdgBlXRO+VXWV0WxT2u+jlzAhDHqkCxVdHmGv1AtD/G/3MpZ9aUq62AotoaNzMtbz42TT+I+KhBMsf6q3RSo0wnpzlG2Gc9ep8/w31m7j35hZyMFqmNpOS1+zhA1PQb8h6YBkx+farCMf1WBqB8XSG73DyBe7MSwoFIN3gxSOkf7h+hlUvlGIHTDm4AUe3KkzTDT/O5ljuJsZ/CUCqoKdPD2yrGSXl5W9wtJ3qri
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(366004)(136003)(39860400002)(451199021)(6486002)(6666004)(186003)(83380400001)(6512007)(26005)(9686003)(6506007)(107886003)(66476007)(66946007)(66556008)(4326008)(478600001)(82960400001)(316002)(41300700001)(38100700002)(5660300002)(8936002)(8676002)(86362001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1fU1l580ZqKozOxMvTdcGAkSPoDl1grvcvCpqcIDNMLneRmMRbhbm7bMxbPS?=
 =?us-ascii?Q?r34YRSyUMUqnyPet1hxoFdjwMVyC7C0jmv3U5z7QoTllR3+HN370yCg06Aur?=
 =?us-ascii?Q?wIt0gTpvVv1oyKJuuCfSraVH8Mbw7HNhXkl/ONKuSZmVAf5qm/YlwIYxHa/Q?=
 =?us-ascii?Q?h/rDodv6UQ0yNzqvWwQVnwdIZ0QMnKvwS3kUg4Aw1NkVemLvXNDEI2Fr8ciI?=
 =?us-ascii?Q?JTG+dsPlbIquUDpONSMXUDV7y0vWORNR65UcQ9d0ok7RipfSoUD5mm2r4G7Z?=
 =?us-ascii?Q?aAOpXRjuy3MzYCBA8QjmQWjwlrhCpvjrVHXwPQXwsGO9QoQDhRFxPZ40eWES?=
 =?us-ascii?Q?m31bnmiWsYfx15eQBrv3Kb1IDLa3L1oPITsNO01pyqii8N94Mwu65ti2jQWL?=
 =?us-ascii?Q?gU6YOVS8i9aGzN3HTej6ryAv1X85VkUWjoOxnf0jIB8117VumzILd6c7scDH?=
 =?us-ascii?Q?qGAlYH1cglCuhwQLqDe5VCFcR9pnopd0pXf6qHnztFr8cquKZuEEmfkKRIS3?=
 =?us-ascii?Q?bVNZqsNvbzgAc/ZjhPClZug8+GA7psJFhYUvqCnnPGo9hx+P+OWXM5n5Y/rD?=
 =?us-ascii?Q?deicBB0oWCpDB+2X8SThxwsChLXqjdtKeDxvcMOMrB2nGSe1OS5r4RNwFlIK?=
 =?us-ascii?Q?etjumDZ+tygSwijdzTy9tFtFQp3zgJT19Wwq9vRxIaR07qoafIEzDs/WfBcP?=
 =?us-ascii?Q?oh3matIQX6RB38gvaITMzyPH7bh5uQ56OEmzl7nCuvoX73MOqGmozx6okMSK?=
 =?us-ascii?Q?x7TB5DZfivrELqGldMtA//qu99NA86BVYJX5EUSEtck4BsGn3iF2Nm98BJ0t?=
 =?us-ascii?Q?gzd1SAKsQN5g1r/qnj7vnPpN538xg78L5OQJxI2iwp/gtzPil1cFqGWOru7O?=
 =?us-ascii?Q?roUlxYhmYdDdgoz7/q2IEl/l1s5qcxrM0GBh1diwF7tuGkD3EvmUGqtNHUFe?=
 =?us-ascii?Q?Edzl5RAnxrgAy3TcsvZAgyd4scDtxV1Jvsy2kjwa94p5YHPFt6pRvZlvwDCU?=
 =?us-ascii?Q?nwn9OG1RpOv6G/GhX5xjrxNwB09jLw43czIsUlt4iyyLytDsUMlFvPqFxsse?=
 =?us-ascii?Q?0qGp81pWGHW1aLX2Vhnj0t+zBrBGplyo0+yqPqLefMTODZB6p98CVH2oDRW1?=
 =?us-ascii?Q?Jop6XaSEKbM1Hk8/cIln1KW/oIrV1z74tcjxp04OA2GdimLD0czEG90JYADv?=
 =?us-ascii?Q?PJLzsVgVKb6oP10U/9MY4G7fJMXbaA7jYj7AFzQE3L3AgVouJS0OTsYneQMH?=
 =?us-ascii?Q?4U4Ko6WgDHKZVtLG1Ve3P0Q4RM59BGtwXSn46YJMdi227sZ1GAQTepO436Fe?=
 =?us-ascii?Q?EzhJRvIEBZBA3EEdwfsdk6NBhHWZ7Uxmw8X3zwl0MyqvAjfbegOK0m6LS69H?=
 =?us-ascii?Q?rGD/tBUpg5Ox7uvK1tIcq3whmqzUyU5GFnq1cer0QEu38xnV4oGSRJXgX1WO?=
 =?us-ascii?Q?5+vcIs9Q1Lmy5mJPxoaT2b7EOd06zg2ZcGmtP5lpjxJ76rtH2YXFSKgxQALh?=
 =?us-ascii?Q?00mGTTVZ7ZUpJ9pfGLAkUogOQ6+SpXCqKK3D2pVw+etsD7cI5GtetzuJ0BXp?=
 =?us-ascii?Q?zgElssdWnDhFGn7qX1pDg197PclGWKB7ft3beqCCNwIUazxvm6UuHIcv4gCG?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 78912ede-7e5a-4760-b4e1-08db84e1dc09
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2023 03:16:19.8482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ahd6MrGRHxNOqu1jz1F2bzqLVvJ/s32FgkqeGGLLBMAWQcBwDa0YZs7jnoktp1d4ACDDAUgxumhya+rW1aZApxrmXuC1wLhezyhirAO1rag=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6137
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Breno Leitao wrote:
> KASAN and KFENCE detected an user-after-free in the CXL driver. This
> happens in the cxl_decoder_add() fail path. KASAN prints the following
> error:
> 
>    BUG: KASAN: slab-use-after-free in cxl_parse_cfmws (drivers/cxl/acpi.c:299)
> 
> This is happening in cxl_parse_cfmws(), where put_device() is called,
> releasing cxld, which is accessed later.
> 
> Just use the local variables in the dev_err() instead of pointing to the
> released memory.
> 
> Fixes: e50fe01e1f2a ("cxl/core: Drop ->platform_res attribute for root decoders")
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
> v1 -> v2
>  * Return the error (rc) instead of swalling it
> v2 -> v3
>  * Split the change in two patches
>  * Fix the reference instead of the order
> 
>  drivers/cxl/acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 658e6b84a769..642983da01cb 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -297,7 +297,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>  		rc = cxl_decoder_autoremove(dev, cxld);
>  	if (rc) {
>  		dev_err(dev, "Failed to add decode range [%#llx - %#llx]\n",
> -			cxld->hpa_range.start, cxld->hpa_range.end);
> +			res->start, res->end);

Came here after the 0day report...

Since this is switching the reuse @res, it can also switch to using %pr
to print the resource.
