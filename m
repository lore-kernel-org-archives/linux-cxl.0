Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A5DFC433EF
	for <linux-cxl@archiver.kernel.org>; Thu, 21 Jul 2022 23:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiGUXon (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 21 Jul 2022 19:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGUXom (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 21 Jul 2022 19:44:42 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B6E2F5
        for <linux-cxl@vger.kernel.org>; Thu, 21 Jul 2022 16:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658447081; x=1689983081;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=MaJWJkCyblcEOVV+9QGxPh55Hu6a1t2mPLNoNWK8Sc0=;
  b=PiYQAvSXd+oYEvbpG2kOxLSzH0oq87/iBc8CJvnz+u0F7IWkPNHGUl1v
   6NltW2njVVi25oMThgdlqX/EaBSaVxxO0Eupkgag4D1B3TdPugvyaZQjp
   EPaAhdqTgiytYcEDTSjaIv5LExO4ZmbXPqMOkBp+UuVQmT4JXvdhs/Tx+
   1mTXInLWyyX9mO31ePO/EQVLzugf8gwmKdVwF6PDQp9dIVob0G+dyqBJ5
   8LW1Fik5hq1mRrJNJ7zOOJvROuu+56YZn5a2Zd64DS/Dgwfg+GfdOiSB0
   NVbJj0rn+uazVf9ikZZb+y34OKtXOn1Gai3Um/D1JIINrP/glyXL5JTqf
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="312915628"
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="312915628"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 16:44:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="548972983"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga003.jf.intel.com with ESMTP; 21 Jul 2022 16:44:41 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 21 Jul 2022 16:44:40 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 21 Jul 2022 16:44:37 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 21 Jul 2022 16:44:37 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 21 Jul 2022 16:44:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ScFzjNhRJC9gR4++ptuFUOY7gwZRNL069QN2zCjxsED1Vf2em9jVsicTy7TpWnzB3VKMhlQ6qtTnFrMIx5en5BOHvYibiGgXnbZ5esClZuGz/NgouTlZOR1JO2NUA5uMIzZZc81fdTimvzPQDqcZNfHWdyFNnV9EHaewdPuVpeyKtipeOjIRmwByhafLsg9ge3BZ+enXGYDywH6XtxvdlVsdBBdLZly9HoB9NeKUyW9O+BCTJUUtqMNtwVAQfNFwzXSrAN3TNSV9+EwMdsSVxARscywZic4T6PXC3osVHhG5fCOgakgiUHbqg92Izp0KvQZElWuUEvNbXVdzZSSGxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9KiWfG+nw+vxrleLOFw/zw1rIbFfBwBUyfjQC4DMVls=;
 b=iZrIOhPK+e1F+vmHwJG1CHNKA/g7/YIMt1nNwNUgD/uvasFEfaKj4Jll0g9Aq7Xd48Ur9TslSH6wqliFaeHougTLfchIuLuD/Pw/F0l4ibiGzp1gR3ykbIiiee8wR8smlQ7FdKUkDNPFp2TdfBC38kcgs+ejAIm9RmZBZJbtlybxsqlXifiBIuLPGjJV5AvCzLPTrWVN5xtCV3A7GA8fBVYAEDIyJ9aTJ59wEM50uOZ9EegBzbf2tKBnRuRiVpQ/OpmNoa6kzQFRqahNbjK1xRawNyF/j0588nNMLpINetbVSe6b9+ltuKZmCcLLQIYS0HSvgcHHjzue5aHCDSMG2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MN2PR11MB3616.namprd11.prod.outlook.com
 (2603:10b6:208:ed::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Thu, 21 Jul
 2022 23:44:35 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::6466:20a6:57b4:1edf%11]) with mapi id 15.20.5458.019; Thu, 21 Jul
 2022 23:44:35 +0000
Date:   Thu, 21 Jul 2022 16:44:32 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <sunfishho12@gmail.com>, <linux-cxl@vger.kernel.org>
CC:     <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <dave@stgolabs.net>, <a.manzanares@samsung.com>,
        Matthew Ho <sunfishho12@gmail.com>
Subject: RE: [ndctl PATCH v2] cxl: Add list verbose option to the cxl command
Message-ID: <62d9e4e0d0d16_17f3e829497@dwillia2-xfh.jf.intel.com.notmuch>
References: <20220721192447.16958-1-sunfishho12@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220721192447.16958-1-sunfishho12@gmail.com>
X-ClientProxiedBy: BYAPR08CA0039.namprd08.prod.outlook.com
 (2603:10b6:a03:117::16) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9aa4fd98-d3a7-4b3b-acb9-08da6b72f780
X-MS-TrafficTypeDiagnostic: MN2PR11MB3616:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OGRrlTIgYLwX6dQ2y7QmY8A8qqZZmbCNewSAmmBodIR6CP2kmRXmzMw+jjO2zk7tWkS+NHZpvlPu6yfcHGS97yGICsqovW7xKsKWpn+SpXNPbhKVTpSiPHkSmTSPe5WuZrh3ywXNM5I2PcNLxoxCgOKgk+h/KCM3feqwMEKSfpoEJIB6wvpfXOl/mkjpxvygEAPO4+vSA5Q6i9/1syi45fQefOpi3xCM9EPEkwETjQCLAPYdLcAIy6aEznMtz3T0S1eX2b4H0rjAXueEwKIwBG+eUqp7aniztX2kPMwRjQFJDjqZCDv3M0Ws5SbFdsdV3Op31LyQIPXh5f8+iFzjL6Oz2fiOwveIoD8+Vi0ivHV/ue8xlgtNg5vTpFO7LacGtnQQw42N0Z72y8psShxk32zyRlUDRaVE4vuS/U7HxsM55dtVUR+kUITZL/HsHH/i07MUjdq81b0w09Jf4yx9WCfkXvkPWEX5I5OBXOc6r+FovEP9m7rge/+yOaWL8hcAArUc04JO6MiewqceKxmog/iGWCm60nwPbgFlhYUPqy3z1aA9JXTZmm5j/tj9BnYuSfGOUeaTO+bdNKbzNlw0m38h4eyTWxAYNh8ruDi/U27dNIk5/NyohtzhxFHNnUUPW3NrOEN8wROP/kA+dmIJ9t3sOnZ40AM7UbXd7crjulbOvOwP3Aq2o4jSB8XmF6G2tod4AH+ZHRUXOGdFrCojGpK1qUChO+JVxFQgYl+ayOIwuwTp2E3pAO+LRMHErKoSm1XRSLIutOlcEfE5vT5LoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(136003)(39860400002)(376002)(366004)(9686003)(6506007)(6512007)(83380400001)(26005)(2906002)(41300700001)(6666004)(966005)(6486002)(8936002)(5660300002)(38100700002)(82960400001)(478600001)(66476007)(8676002)(66556008)(186003)(66946007)(4326008)(316002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bHgcAWqdJajx4vOM1cs549K8vjuvS700ypSm6JkdFe7epvgPkKjfP3/w8Z2W?=
 =?us-ascii?Q?eTqIdqGfQLZI4sh8CnJqEOuYdhxnSPyYTK6OySm5iWXH/zddrTjxNfRcFlWW?=
 =?us-ascii?Q?x5QjDFcieuNK1BXUK97HwEAZnu+reqgWhi+mOliaAJ6YPU+TteFuuaMW6xCI?=
 =?us-ascii?Q?A0yaTU3JBHNS2OCLTCW5XqVIkcLq2mD5FS1LJ4AizNoQIHHaYZG5H5YDUKMi?=
 =?us-ascii?Q?GNQE2bwj8HopQV91Gb5fLHZbFIKzxQmN/IV6kqIfOcsqAaTZHeUeFNvhmsub?=
 =?us-ascii?Q?pprNkOYxdFsYCPoIrHBiEmjtT435GNi1Cb1CxghrL8kykY1HtgLuC9yGty85?=
 =?us-ascii?Q?hd1RYdCQdparSH8eGVq0ssq3XCy22MJNYtMTt68xeXNA7ylJHydiInK1VEfy?=
 =?us-ascii?Q?HXLzQDstlZRLQPDu7TjQOF25T8vnP36VenjxTWda7sdR50enc2GECac5+kVU?=
 =?us-ascii?Q?PhniCR46++aGcsO1QqFvQRmg159Z9x0VLA/B5C0zAD7XIrJljqU8+V/YXkPq?=
 =?us-ascii?Q?QurPtjUCnCjI77klAc02jU8LNHIJImBruyvj3/joy+aukVABqZmG61eQxZd8?=
 =?us-ascii?Q?2FhHMvnl/aKgzRFK8guZHKf+xVp058OdT9fJFrP5kCDg5koranmivSNRXEyv?=
 =?us-ascii?Q?e2HvIJpjn8PVE+JZ31UWZdObxH1aDhwurYgPCfhFO8o357M8QwZyoeohsOek?=
 =?us-ascii?Q?AekifUq1RdSLe0wCOHjn3ti+8mgxA0nk/QW39jt6Ds0/OAIr5VkkCA8VCZjs?=
 =?us-ascii?Q?j3FMqVSuscl+HQUDWeDhCOm3FWTHLM6ZHU4JRI5R1+jdbRpb8Ni7Ox+RjE4v?=
 =?us-ascii?Q?f0PCgqP6SMovDRuf7JV1V1Qv/PdHd1/KDPAf9faSKJFaBUCyC19dn5y9rwss?=
 =?us-ascii?Q?9Pi+W8wZkCkQ6a/FgFtSOw8gYWXi4PkIz/69psBydXtgs9Tp3bTnn4L4MoE1?=
 =?us-ascii?Q?90loji/pXWsfqL0ZMkA77Ti4WAyT7+chnqa/jIgrTmmJkP8wYd3l1ZzGDhJ0?=
 =?us-ascii?Q?yncqiqZIx1UJ+fstg4vLLt4b0M6uzckiNc/4N6mPFEv13BxkCLSw9kyyCea7?=
 =?us-ascii?Q?SgjPxLeS8qHIEE4lEClw7w+v+nUyaPSsve8I1O9j7VDTI/Y9Fas825R4D8e7?=
 =?us-ascii?Q?1Upf53CumJdGxP670FanawV5flKThPCW8IXpr5qaSlO+nmTTaMN5leRjZhUY?=
 =?us-ascii?Q?KyMqRDtzhQNQ+2T+ZMDEDvOSid6RHa/zdlb1oz5ma4vGNU3LurFAyF4M6t/D?=
 =?us-ascii?Q?O1Rg+W2U3fZuI9Rk2mLtqfvRa2UQhpL6eL79mjngI3PlGMhurrb7+3uQOezg?=
 =?us-ascii?Q?226KuXUBnsUxgkPup3j3hNfkN0s+qzKZx0hG7FnrR3FrEnfyYP+xBFovD0jg?=
 =?us-ascii?Q?g1yzAHLF/iS0aEfHv7qDvLkX0X7hAT7XlEwYgmqvqneBlcFHXQD0DyseMA1r?=
 =?us-ascii?Q?JfEz+fedX+Nfkyk2+rUGjK8HCYcCLaGvNLbOqyZQYpCOpdUEenCu8H6Z5sQM?=
 =?us-ascii?Q?rTz1REoqHVpkC35f9+ys7Pvk8eYVBdspUPGy6KAlREJEyk9aPvz0YE5Aiern?=
 =?us-ascii?Q?fbJeUfWgFy4zsWVG3GjPCmg1o3mI8jyowWZAlMy0AEH8Udjh9UIFM7sZ4fbQ?=
 =?us-ascii?Q?yg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9aa4fd98-d3a7-4b3b-acb9-08da6b72f780
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 23:44:35.0601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hmv07M7wAqzQMsjBc9yi5sRBu0UiUoFYJcmRFvjRYm4hkf7Klkp5RVEXOmwUDbZ6zwr5rp+AoTsvPnCLcZoHWoCFI/v+91dSDyNnuOp4JGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3616
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

sunfishho12@ wrote:
> From: Matthew Ho <sunfishho12@gmail.com>
> 
> This adds the new subcommands cxl list -v, cxl list -vv, and cxl list -vvv, and
> builds on this pending patch series that adds region listing support:
> 
> https://lore.kernel.org/linux-cxl/20220715062550.789736-1-vishal.l.verma@intel.com/
> 
> cxl list -v is now equivalent to cxl list -RMBDPT, cxl list -vv is
> equivalent to cxl list -RMBDPTi, and cxl list -vvv is equivalent to
> cxl list -RMBDPTiHI. These additions make it easier to list all of the CXL
> devices without having to remember which subcommand must be appended for each
> type of device.

Looks good, minor comments below that after addressing you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

> 
> Reviewed-by: Adam Manzanares <a.manzanares@samsung.com>
> Signed-off-by: Matthew Ho <sunfishho12@gmail.com>
> ---
> 
> Changes since v1 (previously titled "Add list all option to the cxl command"):
>  - cxl list -v, cxl list -vv, cxl list -vvv replace cxl list --all,
>  providing greater control over detail of the output. --human has been excluded
>  as it can be appended by the user.
> 
>  Documentation/cxl/cxl-list.txt | 20 ++++++++++++++++++++
>  cxl/filter.h                   |  1 +
>  cxl/list.c                     | 17 +++++++++++++++++
>  3 files changed, 38 insertions(+)
> 
> diff --git a/Documentation/cxl/cxl-list.txt b/Documentation/cxl/cxl-list.txt
> index 2906c2f6ef4b..f069aee8c674 100644
> --- a/Documentation/cxl/cxl-list.txt
> +++ b/Documentation/cxl/cxl-list.txt
> @@ -336,6 +336,26 @@ OPTIONS
>  --region::
>  	Specify the region name to filter the emitted regions.
> 
> +-v::
> +--verbose::
> +	Increase verbosity of the output. This can be specified
> +	multiple times to be even more verbose on the
> +	informational and miscellaneous output, and can be used
> +	to override omitted flags for showing specific
> +	information. Note that cxl list --verbose --verbose is
> +	equivalent to cxl list -vv, and likewise
> +	cxl list --verbose --verbose --verbose is equivalent to
> +	cxl list -vvv.
> +	- *-v*
> +	  Automatically enable --memdevs, --regions, --buses,
> +	  --ports, --decoders, --targets.
> +	- *-vv*
> +	  Everything *-v* provides, plus automatically include
> +	  disabled devices with --idle.
> +	- *-vvv*
> +	  Everything *-vv* provides, plus automatically enable
> +	  --health and --partition.

These descriptions can drop the word "automatically" without any loss of clarity.

> +
>  --debug::
>  	If the cxl tool was built with debug enabled, turn on debug
>  	messages.
> diff --git a/cxl/filter.h b/cxl/filter.h
> index d22d8b1f798b..256df49c3d0c 100644
> --- a/cxl/filter.h
> +++ b/cxl/filter.h
> @@ -26,6 +26,7 @@ struct cxl_filter_params {
>  	bool human;
>  	bool health;
>  	bool partition;
> +	int verbose;
>  	struct log_ctx ctx;
>  };
> 
> diff --git a/cxl/list.c b/cxl/list.c
> index 5f604ecddf3c..4763c7c36024 100644
> --- a/cxl/list.c
> +++ b/cxl/list.c
> @@ -52,6 +52,8 @@ static const struct option options[] = {
>  		    "include memory device health information"),
>  	OPT_BOOLEAN('I', "partition", &param.partition,
>  		    "include memory device partition information"),
> +	OPT_INCR('v', "verbose", &param.verbose,
> +		 "increase output detail"),
>  #ifdef ENABLE_DEBUG
>  	OPT_BOOLEAN(0, "debug", &debug, "debug list walk"),
>  #endif
> @@ -106,6 +108,21 @@ int cmd_list(int argc, const char **argv, struct cxl_ctx *ctx)
>  		param.memdevs = true;
>  	}
> 
> +	switch (param.verbose){
> +	default:
> +		break;
> +	case 3:
> +		param.health = true;
> +		param.partition = true;

add a "/* fallthrough */;" statement here...

> +	case 2:
> +		param.idle = true;

...and here.

> +	case 1:
> +		param.buses = true;
> +		param.ports = true;
> +		param.decoders = true;
> +		param.targets = true;

...and a "break;" here just because the ndctl project tries to follow
kernel C-style.

> +	}
> +
>  	log_init(&param.ctx, "cxl list", "CXL_LIST_LOG");
>  	if (debug) {
>  		cxl_set_log_priority(ctx, LOG_DEBUG);
> --
> 2.34.1
> 


