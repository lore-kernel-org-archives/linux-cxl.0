Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A27C19F2B
	for <linux-cxl@archiver.kernel.org>; Wed,  3 Aug 2022 21:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236186AbiHCVXK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 3 Aug 2022 17:23:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232909AbiHCVXI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 3 Aug 2022 17:23:08 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D842A43E
        for <linux-cxl@vger.kernel.org>; Wed,  3 Aug 2022 14:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659561787; x=1691097787;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=rS7dnjj1oDWrAkT4LZAY8Es/0eGpBvGawDTrP3RPlbc=;
  b=kgzDmW1Zc6x12gVcvDUrxt75hr8tVGuy5yxqwWBiZtNgttaYUqlXbgWv
   pcL+5W5mIBKviNLX+fOcdx2/6l8Yk+pZ+uwDMzJZ/shmklT/SqCtlMAii
   ImnfQQ7qlq00mi5RP42jlg86B+aLJWaAO2LprnHxC0zbZJRcPg6KrF9YW
   uvHP9JXxjDPSwRhjM5K6yxcqdai8uccGbHjLy/Al/Mfuj0+S0Lqqu8mG2
   Y39ul80ddOeuIrERFlrjyQaAx34q3B3lj0kRId6fU9Q429F091IG+LFA3
   Z0TnJulKLQIZOhixaAZsT8UYC70EyZPIGC+dDhOwOLHLK6HzEdcZGL/q4
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10428"; a="276698071"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="276698071"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 14:23:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="599774736"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga007.jf.intel.com with ESMTP; 03 Aug 2022 14:23:07 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 3 Aug 2022 14:23:06 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 3 Aug 2022 14:23:06 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 3 Aug 2022 14:23:06 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 3 Aug 2022 14:23:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OxgdB9kja5J8o8zeQLK6C2Z6KZnPLCf22A05rk8bxNERPWlxsTAjrC2rwzo6NNHrpawGjqkHJuXy9hMnmElfLUXy8ItzmzAgrh6SYRP2D8UiMi5hOYQw7tAJQQ+bybOlrLO1Xtbi1fqxFLWA39EL+zuETQa7prJJG5S4CKF4W7e51Tnt9/3rukeXbkyXeNf6Z3N0ONjkOc8Qw+5Zbikdtkmc1JSpMmAQLpS55tyxt8sRCzs2N+eqReO/D3T0lpsLqyEax7XyzR4a/mfjkOiwr+xAUFv6gHxHWStSjFQpztbrj/gB5ZkpY+/krrGbFZUdCSwyideqK93V13qCSMYLRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fNA0xLhHjuSQ9WIz6EPtWqxg2dI3Af2n+n0RzBoMDjY=;
 b=CHpiRQg5eRN6lswtAQuwL2kxHPKWmRuqHic7jfRXW0twiKcjZcpcVwdm3mnaKdGw4Tr2pa5wVPqky37OfCetPrXX7HnTrG7ivzu9Udewb5Oa9KYfmCH4bIt81uE9eKRXENFnJ4/zLI5tOn768N109rb4+cKmmyLosbjHNL3V29FfM76JtI1NsQaB6t7E/ZICJd909x5z+idYfMd/r/c0NdxIMlgp32mI2VXgF471oubz5tUcblU7BT8SFwjCa7EidhhSyvn/OxyypaDR37c+lMbELuZ/XCUIqpFZReh/goP91kruyOX62zCDAl/CVQv9nNJhl4GP8XrfNNJOjiDYcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM4PR11MB6311.namprd11.prod.outlook.com (2603:10b6:8:a6::21) by
 BN8PR11MB3732.namprd11.prod.outlook.com (2603:10b6:408:83::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5482.14; Wed, 3 Aug 2022 21:22:59 +0000
Received: from DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::b965:e89c:548f:d058]) by DM4PR11MB6311.namprd11.prod.outlook.com
 ([fe80::b965:e89c:548f:d058%3]) with mapi id 15.20.5504.014; Wed, 3 Aug 2022
 21:22:58 +0000
Date:   Wed, 3 Aug 2022 14:22:54 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, kernel test robot <lkp@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <dave.jiang@intel.com>
Subject: Re: [PATCH 3/4] cxl/region: Fix port setup uninitialized variable
 warnings
Message-ID: <YurnLuV5Yin5JnkK@iweiny-desk3>
References: <165951145706.967013.3023584411011908037.stgit@dwillia2-xfh.jf.intel.com>
 <165951147487.967013.929590444907251028.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <165951147487.967013.929590444907251028.stgit@dwillia2-xfh.jf.intel.com>
X-ClientProxiedBy: BY3PR10CA0018.namprd10.prod.outlook.com
 (2603:10b6:a03:255::23) To DM4PR11MB6311.namprd11.prod.outlook.com
 (2603:10b6:8:a6::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bcdfe865-b827-445f-d903-08da759656b0
X-MS-TrafficTypeDiagnostic: BN8PR11MB3732:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KwBcMyC5clXKI8fX/yMlFsMn4h7CZuTKTTPwZFI4wiQENukLs5jVH/3dytA28n1gSO6pXB5MiWqiJUx2ymiltqv7FgKulY7jCf9h5IL5Pkk2iaY0G8kgmziQYBmlU+Qr/cPRjS/oJtQwg5rcBz12TO3FQbpun5cfpGbJgFkF9DcgKtssx5u/CcO3l2S56e7Vy5tUZpHQY/Fs0eW2mAVP+Fso6JVG8aRF/tnLvQSG54VvMoijpHd1xsx/a0F8RuYB9Te35ZSJW70lXn5x5CLg6lpZEI4XGc9jtyvUg3Mif31GirDwqp/Z5XJSF4dnugIXSFEi4zKray53hpGVZavPoTZ5RimGWShq8YkcnILSVOTBm91gRwFapvNaxr2QOwa55ffPb/7GW41zYcs8cypt25vlGyitpkx4lXEF3ZthV3AfAZ1rmgniGqKhoZCHOLZvcgUh126IdGHjgyMa6pviwKjZgtEQV8+PQf6kMOz3290tWfQc9+N6aEkPP5vgztFrPPuyv8BL4kENsom/YPpVmsf41q8LxJfDvmVl3a2TaxNz2/KReLAK8EYbJh5SR10qFqWEdZUC9b6id0FuyyYWj3qauxpiLWB+h2Pf0cIBCMcJrMA/7IV66yC0axGStM12dDjilvwfhoxo/O9iSTYJRyMCPqbpsJY/JT41RyDdr0V2gybJKT4mZqp/gWZvTYhJyDrwlq2U9K+Rb8TLvPvn97qPCPE4fJc//34WsCK6qB/x3T/x676LotSd7R0rKGv7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6311.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(346002)(396003)(376002)(366004)(39860400002)(26005)(478600001)(38100700002)(316002)(9686003)(6512007)(186003)(6486002)(6666004)(8936002)(6862004)(83380400001)(41300700001)(6506007)(33716001)(82960400001)(2906002)(8676002)(66556008)(66946007)(86362001)(66476007)(4326008)(6636002)(5660300002)(44832011)(107886003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FATkgECPVvPPf16qjee0BoidAvs0DwRqtSxcRtQ8LgTQC7vxs//Ga5BWQKME?=
 =?us-ascii?Q?GpUaWFQ7hK/eZfv9pVpeSxs9qodb2ucGG69/l0x2QxHsOxnXWUNpANbbf9ke?=
 =?us-ascii?Q?WDbMSjIrUNpgWBiH/h5LEIZQHMmHftLbjRYY9s7l5CB3DvwVUwDAFgh5jQ1N?=
 =?us-ascii?Q?0JBvIwy1Y1PUPfh5qvsKmpbFAtGOkKnkiEnO2s6qJJtZU3SKQ7S7T4L7oMKe?=
 =?us-ascii?Q?qLgNC7ZsPDq81JSqZVKq2GsMuo5Qf7LPQ1DQSdEEm5VUU5o6qOZOZMF5h/Nl?=
 =?us-ascii?Q?rG7MTeoApm+pizb70UqXB3lsK4dz1OPzcXTc9+frX07RLsGYCknrcd2MM54C?=
 =?us-ascii?Q?ehG/olLuJoSg1oyRkvkCYkRwp6RL8kbdHYBNcH+sXblgz+uUvTVyeuLoghNc?=
 =?us-ascii?Q?c/FWr3vgXrfTZmbmiKiGZNAJnnycRRT8X5FjrnTLXJxnYprElS0a+NEVLZR6?=
 =?us-ascii?Q?trV+amf8khiIvaE7iEKuS4+l9kp2HEZjfol75Tpu6RJscKssyiz0qY035is3?=
 =?us-ascii?Q?iqQ0wXiWeHgcKBo7O0ZQ/jn3NejiaIRqKirL4w+dB4FRxgZ5AFL4jjHsX/kQ?=
 =?us-ascii?Q?mNDAcdJ46CbH07glT/r2CxvbMcPtYpEcptjchnn5IuB1NLWJ9wFg4zfhWeOW?=
 =?us-ascii?Q?ff4DmKPJPFVY3ZN7/AfGAoR4rM8wQT6qK+ZeWEp4sTfSUO/qyG9NOd7yWnB2?=
 =?us-ascii?Q?l1bwCJdvKPr761UHwjWcgTVZw/vVYtg8n0lNcM9LfI4b4TApCGIeMKpGc2vf?=
 =?us-ascii?Q?kD/EqTQC7Kb5E8a+ucKm60dnSQ1Lu3lqoqqVkMYhLrl4fRiVuKazOexhRLle?=
 =?us-ascii?Q?Wdxm4USw7fnJGgTfFuzFKI6DXlxaDzo2XhPP0ThzM/qUCvCof37wGajHj2r8?=
 =?us-ascii?Q?S7ILqqYDl+8qK72ajfyOEbi9qLGtzfIxYUGUPoysVRLLCl5zY76KAL067sUc?=
 =?us-ascii?Q?79aUyFwdWt8ATKGsRr/KHsAsFcpE1FMc6KuED3svYmZgv5yrJ5BnXj98TraU?=
 =?us-ascii?Q?q1vbwv7zGyOI22XZp8ogIJveGWIXZK+p9S3mDwjWPIEb2KTmvSOm+4mbtUxG?=
 =?us-ascii?Q?SJMNBZJozUmrW201a68DjX8babQ407dLf5+OYL1cbvHkWsT3gaBlifAUeVxO?=
 =?us-ascii?Q?Q+Z0C5EHggJMI0HmR2S55NiRehs2Huzx9PHeQ5RNoOXbqDWKlybGWyOOhdJQ?=
 =?us-ascii?Q?yZg0ZOQj5rCxSM0k/g2GiwAaxSaL06mwUoEtIehhcY4Abjj2ZH17mkPyETRF?=
 =?us-ascii?Q?O4/lagCFBn1v5/uhEobvNyxLsKj8XFIaBPQAxFMnVYSudgir2lDB+SXuBDGn?=
 =?us-ascii?Q?pwixP6zq6/oLy4iZvOCF/OYhHCdGyGpTCJmOx71zd2fsB23cc6O+uvhcx8eq?=
 =?us-ascii?Q?g4FhGcQdyM+zmClm/PNMGEAn9c7Bm7aKnntPtJk0QiqI0Rrim2susLuh1ecD?=
 =?us-ascii?Q?rf+CKYxhxjUXlL858zFTb6x1hMVpmS5EpjGdxik4BEOTeUvZ5cro5FsYFBaL?=
 =?us-ascii?Q?fVZRFcJ2EZVa8wuw+7z45eshITKpk7+OX8tTiTb7AIALa1EgVtMn2l9U2+lW?=
 =?us-ascii?Q?LMKZzrMNnnkh5ZaXnRcqgTsr8Iycjt09+lz4F2mE?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bcdfe865-b827-445f-d903-08da759656b0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6311.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 21:22:58.8202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FHticsiSINvIZUZB6S98VB+bjY48jf7cKrggTD349dOe7/oNvgKNPFllpXOX7tWyifvepH0JPX8sJt/b1FweBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3732
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Aug 03, 2022 at 12:24:34AM -0700, Dan Williams wrote:
> 0day robot reports:
> 
> drivers/cxl/core/region.c:1068 cxl_port_setup_targets() error: uninitialized symbol 'eiw'.
> drivers/cxl/core/region.c:1068 cxl_port_setup_targets() error: uninitialized symbol 'peig'.
> drivers/cxl/core/region.c:1068 cxl_port_setup_targets() error: uninitialized symbol 'peiw'.
> 
> ...which are all valid reports. Add debug statement to consume the,
> albeit unexpected, errors.
> 
> Fixes: 27b3f8d13830 ("cxl/region: Program target lists")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/region.c |   17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index a073f16355ca..5c931b6eb4e7 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1059,8 +1059,21 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  		parent_iw = parent_cxld->interleave_ways;
>  	}
>  
> -	granularity_to_cxl(parent_ig, &peig);
> -	ways_to_cxl(parent_iw, &peiw);
> +	rc = granularity_to_cxl(parent_ig, &peig);
> +	if (rc) {
> +		dev_dbg(&cxlr->dev, "%s:%s: invalid parent granularity: %d\n",
> +			dev_name(parent_port->uport),
> +			dev_name(&parent_port->dev), parent_ig);
> +		return rc;
> +	}
> +
> +	rc = ways_to_cxl(parent_iw, &peiw);
> +	if (rc) {
> +		dev_dbg(&cxlr->dev, "%s:%s: invalid parent interleave: %d\n",
> +			dev_name(parent_port->uport),
> +			dev_name(&parent_port->dev), parent_iw);
> +		return rc;
> +	}
>  
>  	iw = cxl_rr->nr_targets;
>  	ways_to_cxl(iw, &eiw);

Do you need to do something here to fix the potential uninitialized use of eiw?

Ira

> 
