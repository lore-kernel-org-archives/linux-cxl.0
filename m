Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174FAC7619A
	for <linux-cxl@archiver.kernel.org>; Wed, 12 Apr 2023 01:48:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjDLBsG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 11 Apr 2023 21:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjDLBsF (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 11 Apr 2023 21:48:05 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E351704
        for <linux-cxl@vger.kernel.org>; Tue, 11 Apr 2023 18:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681264084; x=1712800084;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=H7PzVMtos2mDBA85Lpx08Nlgazwoj6wtoY6Etxw6Nyw=;
  b=liDjBiCvtay295PSINs04jUqFjOC+meV9oo99oyq+NJFyvidoASnm9kE
   9e4P/8nSuEvt6IImwC9AHTg9p5Sntv7gfXrVj2fFAWlQ0WxOqRB/uhzNM
   ihmiAmx9/Rl/2137I8f0tY3XRD15YjSXb7kLdaczqy/zC73jTj7mQ7LZp
   kYQuaAAt4foH4r/+bXki1P8e3DDb7eYesnHWJbZFN9NhHYlGyvtIrD1vw
   NXhJJRWmsEhnVl+fKMYQYTm+07PTavGT1eikDYVjtwMHoBKD9BH+Wtymg
   voaa6WAHfCUMN4nuA0AOlGlVrd99oVjU8wFLBzkg3PhjNxgkhaMqBS1P9
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="343783270"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="343783270"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 18:48:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="863122890"
X-IronPort-AV: E=Sophos;i="5.98,336,1673942400"; 
   d="scan'208";a="863122890"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 11 Apr 2023 18:48:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 11 Apr 2023 18:48:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 11 Apr 2023 18:48:02 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 11 Apr 2023 18:48:02 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Tue, 11 Apr 2023 18:48:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NgITvdj0AlTXtOiDrG5J5SKFf42i25RONPl9Vt9cCzj37Eq0nOkdEaMnK3fpiB+fwuh1jplnxGMkUErkPXSacv7Xpfa3Je1ajdTmP/fovkkhfQPPeFXlYd/m1nqBAxxwgKZeewhSyMYAkMNG8XkhKn+VJ6y6RWoNiSdVzOE/4fGaDxLy8sw5b9YM5gLWzXsbEfZ50Jl988JsMuLDDnZF3D5SueM//6wGC1rYLu2cMbvxM9UmmJLQHuEGm0HQBrgoIsywFcofzQGsw84VX8q4cwVgZYX7SzQczynRQMMLw7hHrOWQe92DoGoGPwws7hwk56jmBkEy3WexsdtDPDWHGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUiC7D2hWG6CAa96itGPqBHUbQR56IxPITg21KDrb9g=;
 b=LhfMXFrebaj3DAgtdWsS/uLEXmhQVm30pyFn+IeWu2TyE53qG6uqpb2U8q1cKf7/Ee1GSyCc6jKj0rcCycqfFgY48NCAiqkVO9Psa/mcLqIX4ikL3adlvFhuro3fimlqrx4fmYAYT5ryouueY1ctMh4PdOLgVpP29UpIvwxXRgjbpCYp1HcbL2jSKYTx8W2W1yDFCD9KCX2wlUgtEWMRMxvqnOMcPU0TIEcGS5kkLYWLgjSXGpcjfXRtP0n2w5m5CeFL3bGEaKlyJ8L5cxsnLGMgecYi+mAxxH6h5+xWSJf7GupMTKzS13iKj/Zd8m2nw3HeSanP4tn3B4aOPeIZaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7215.namprd11.prod.outlook.com (2603:10b6:8:13a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.36; Wed, 12 Apr
 2023 01:47:59 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%5]) with mapi id 15.20.6277.035; Wed, 12 Apr 2023
 01:47:59 +0000
Date:   Tue, 11 Apr 2023 18:47:56 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH v12 1/6] cxl/mbox: Add GET_POISON_LIST mailbox command
Message-ID: <64360dcc59cb0_417e294de@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1681159309.git.alison.schofield@intel.com>
 <e87e1792e147a46f348019cc772e06f2ea19e970.1681159309.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e87e1792e147a46f348019cc772e06f2ea19e970.1681159309.git.alison.schofield@intel.com>
X-ClientProxiedBy: SJ0PR05CA0073.namprd05.prod.outlook.com
 (2603:10b6:a03:332::18) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7215:EE_
X-MS-Office365-Filtering-Correlation-Id: 85a03863-7b5e-4902-0fde-08db3af7f140
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LzKUo5XsQoJPAquJ/L/RanMbcKntAqNDjSPfxY+fBwXhB59gaDrCP9hG1q0Xs2bAvMX3nt+RWlIE3vSZiQIgZK25IoSiG+as9qnfe2R9VHsS0OCLk1UFtmgytiwVaE0IbOWoZ5vDLkJdxuO3rdBkiVX77dBCQO8OGaM64l9GrlDoBP4YDefF1794phNrYQLQXE6goE525tOieU+JCqlLigTwOhpEubDSL4laWErhFF3JBVuZ6dLS9WXXLA5kzl6BQS2hXn5xH8wija0GxZxLau96vJVQCjz3KUM77TnEgiWe3qCRXS7IY1GYHDfdvm33WPXo4Rwtcs2hEdg91XhAA5VkvZZXzZFDiOasG5w+xK0V3t2hIFEXtN5GM2ZW72d6vZDsB0W+phL3JxGqv/ws5Uf1cnMFdRw9Lx+aRv/7tqc7MmgUQ/aSKF04zWXfIpKzVgMVizO3sVjrM5wr99rAV2C3BvVgbLR/mCCg8P87J3OU+0lqWQatY9K91CzMqugFBqTcLIlx3eMLBPD2wy1H/EXKfX0bOgER+zBFuZghA4+K2qCU8uUiqhg8gHrN8Hez
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(39860400002)(346002)(396003)(376002)(451199021)(54906003)(41300700001)(66476007)(66556008)(66946007)(4326008)(8676002)(6486002)(478600001)(110136005)(316002)(86362001)(6512007)(26005)(9686003)(6506007)(6666004)(53546011)(83380400001)(8936002)(2906002)(15650500001)(82960400001)(5660300002)(30864003)(38100700002)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WNfG/b1uszusAn1U83dotn7P4R5GsXKIumPPYcDhzxSB6PV3hfCFcdlT88kN?=
 =?us-ascii?Q?uZy1I2QaSgGe0sTWj2rklcIF+9oHth25REc5teYmz9Df5ZwytC7wcYNBOWdp?=
 =?us-ascii?Q?XKsiI99rlrdjXya5khCzbJPF5W4boVou2Kpn9MIq0gKyLWmvd13ute/vjnrQ?=
 =?us-ascii?Q?lMGSm8aXIJc9OWRHTSpoDkvQMlIyw3L8prfxHeCDJFwA5U1bTlTs+PfFIYNq?=
 =?us-ascii?Q?Jhi69xlgGqHmM5Xc6wOiTx2JTc3nQNNa8eTddCPfG+P9XqnAopQ/UtSmETA6?=
 =?us-ascii?Q?SoP5nW3Nv7KwA9BtBsqjniR4hk7NOMQm3ToZMMxlWltZ2G/4Qt1mWNvkCbqU?=
 =?us-ascii?Q?K8ArPkLbDJmyiBj1WRifYm7XLkmA3iMj8/PNWpDf92SOUhLCIG3MDQJTPStj?=
 =?us-ascii?Q?Wq1FdT84UnGXYUR1Q6bHUCRhpi2xL9YLlr4x/HU63Ok3dNo+Rj9rCdXoL4u/?=
 =?us-ascii?Q?/Q6Th0psrjnInOPUzmK/McslshjRsZTPVJy3mVvnqwK+972TLzbqzwi556x2?=
 =?us-ascii?Q?hbaDO6fmm/UC2WqusuTjVlF1Xi3/C92iCUme+pey0sRoCyjZBDHDGdagehfI?=
 =?us-ascii?Q?gEb4v8SMJY2QOtN+/vZXB4Y/J+CdmyobLJEcYouFUcQA3Q2tTn52VlKUmE7I?=
 =?us-ascii?Q?wGse2l3zR6oRw/THUvKDhIGpgx+uBNb7ZihyM4FEw6qDJKCc8bZuscqwOmh2?=
 =?us-ascii?Q?7iXPrtXHdJ3S3Nk2JV59rO/5lh6l204eN6b7CYo2RKzzqVsmyWcmSYYmkvyt?=
 =?us-ascii?Q?Z785HiIu5atJ6W0RZv/kRD08m2v9/P1lTg8s6hUg2l4Lret0sqrsfmJ2zR5J?=
 =?us-ascii?Q?pv3S3Sw8kzG3AQkyhbnZaMq+Fv0shDXp+4o/LZQEDM+ebK4mzqRYfVdwRUMY?=
 =?us-ascii?Q?pfT/TbyQ/cXn+6oWLq0qxF06a8kBdH2DuzxNJeX0wzAmUgsAbSnZwXtS9tdW?=
 =?us-ascii?Q?jLmtrxMl/Ktc0IAFvZ1PfMg96yaKvoxu31KJEFweNIi5CMNFOYr0zln9+krV?=
 =?us-ascii?Q?pwMu2aO8fHlClNeDqLLdZxhVIeAYNnBlDEC3y8YNiRQAOgYYYwSataityl6+?=
 =?us-ascii?Q?Bb6k5p7FUuUak53gd5FR4/uNFu6XD/GJr0chytSeTj2cNtMq19nPr/HI3iZ7?=
 =?us-ascii?Q?SsSRApqDGUosOGgkzkZckuU0ozd9Rq/w81y/qrVbkjrnqW4ksQlIso5A05y0?=
 =?us-ascii?Q?ZN4xrqqKrnp11hX8rz+buwcyw6RUqO+BqUYlmbR9K4cuzuiAB5R6DECOqM9h?=
 =?us-ascii?Q?sA+Q0s/MTjus4VuHSWaUb0TpvV0cCqmebYwE32BTeDZYZq5K4K9GHsvoIu/K?=
 =?us-ascii?Q?izRgOtBV5IBFvgph0EkHGI7J84GlS06QEuiJ29m/EuUiF+o/7kLqqZ0+dgAN?=
 =?us-ascii?Q?tQIRvAcWdiXYZ4svO4drS8N+MGnRpMAt8dn7E1vs2KgUCVSJH1UkNTNCXPD4?=
 =?us-ascii?Q?sKnhu1S7GHhGRVRzDRLwOWtTfeDe2fdFEdt1+GskgobtENMRmN4ayfUjY9Hk?=
 =?us-ascii?Q?8lzfqC8hyEttlznCwcQWbiLDkCWp0XMTCob0rtnjA2TxBnvVaImKHbP6hErU?=
 =?us-ascii?Q?0olERDCvV2RdHkka+jARwapKL286k1DSqTvWkARaZvFDtGio/N9mKUB+i/GX?=
 =?us-ascii?Q?kg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a03863-7b5e-4902-0fde-08db3af7f140
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 01:47:58.6322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aUravXcNSxGsITIOLrfZtPKmVW5J22FCCXYdaQ4M5fG97umPfRzESSj1nmRjLdHoxQsiSAnDB8ZU5+pwmXpkwTcaspabzbeNKVOePycexRQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7215
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> CXL devices maintain a list of locations that are poisoned or result
> in poison if the addresses are accessed by the host.
> 
> Per the spec, (CXL 3.0 8.2.9.8.4.1), the device returns this Poison
> list as a set of Media Error Records that include the source of the
> error, the starting device physical address, and length. The length is
> the number of adjacent DPAs in the record and is in units of 64 bytes.
> 
> Retrieve the poison list.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> ---
>  drivers/cxl/core/mbox.c | 71 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h    | 67 ++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/pci.c       |  4 +++
>  3 files changed, 142 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index f2addb457172..69a5d69dd53b 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -5,6 +5,8 @@
>  #include <linux/debugfs.h>
>  #include <linux/ktime.h>
>  #include <linux/mutex.h>
> +#include <asm/unaligned.h>
> +#include <cxlpci.h>
>  #include <cxlmem.h>
>  #include <cxl.h>
>  
> @@ -994,6 +996,7 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
>  	/* See CXL 2.0 Table 175 Identify Memory Device Output Payload */
>  	struct cxl_mbox_identify id;
>  	struct cxl_mbox_cmd mbox_cmd;
> +	u32 val;
>  	int rc;
>  
>  	mbox_cmd = (struct cxl_mbox_cmd) {
> @@ -1017,6 +1020,11 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
>  	cxlds->lsa_size = le32_to_cpu(id.lsa_size);
>  	memcpy(cxlds->firmware_version, id.fw_revision, sizeof(id.fw_revision));
>  
> +	if (test_bit(CXL_MEM_COMMAND_ID_GET_POISON, cxlds->enabled_cmds)) {
> +		val = get_unaligned_le24(id.poison_list_max_mer);
> +		cxlds->poison.max_errors = min_t(u32, val, CXL_POISON_LIST_MAX);
> +	}
> +

With this new interface I do not expect we want to support user tooling
that wants to retrieve the list via ioctl. So I think this wants a
lead-in patch that deprecates the poison command support so that the
linux-cxl community only has one mechanism to maintain going forward.

Something like the below as a lead-in, and then you would add code to
cxl_walk_cel() to set a flag for the "get poison" machinery.

-- >8 --
From f2cd1d1e09fe6f36255f3b8cd831b2b4903045d4 Mon Sep 17 00:00:00 2001
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 11 Apr 2023 17:48:45 -0700
Subject: [PATCH] cxl/mbox: Deprecate poison commands

The CXL subsystem is adding a formal mechanism for retrieving the poison
list. Minimize the maintenance burden going forward, and maximize the
investment in common tooling by deprecating direct user access to issue
this command outside of CXL_MEM_RAW_COMMANDS debug scenarios.

A new cxl_deprecated_commands[] list is created for querying which
command ids defined in previous kernels are now deprecated.

Effectively all of the commands defined in:

87815ee9d006 ("cxl/pci: Add media provisioning required commands")

...were defined prematurely and should have waited until the kernel
implementation was decided. To my knowledge there are no shipping
devices with poison listing support and no known tools that would
regress with this change.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/mbox.c      |  3 ---
 include/uapi/linux/cxl_mem.h | 31 ++++++++++++++++++++++++++++---
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index f2addb457172..8e24038b8769 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -61,9 +61,6 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
 	CXL_CMD(SET_ALERT_CONFIG, 0xc, 0, 0),
 	CXL_CMD(GET_SHUTDOWN_STATE, 0, 0x1, 0),
 	CXL_CMD(SET_SHUTDOWN_STATE, 0x1, 0, 0),
-	CXL_CMD(GET_POISON, 0x10, CXL_VARIABLE_PAYLOAD, 0),
-	CXL_CMD(INJECT_POISON, 0x8, 0, 0),
-	CXL_CMD(CLEAR_POISON, 0x48, 0, 0),
 	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
 	CXL_CMD(SCAN_MEDIA, 0x11, 0, 0),
 	CXL_CMD(GET_SCAN_MEDIA, 0, CXL_VARIABLE_PAYLOAD, 0),
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index 86bbacf2a315..90f17343f1ba 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -40,19 +40,22 @@
 	___C(SET_ALERT_CONFIG, "Set Alert Configuration"),                \
 	___C(GET_SHUTDOWN_STATE, "Get Shutdown State"),                   \
 	___C(SET_SHUTDOWN_STATE, "Set Shutdown State"),                   \
-	___C(GET_POISON, "Get Poison List"),                              \
-	___C(INJECT_POISON, "Inject Poison"),                             \
-	___C(CLEAR_POISON, "Clear Poison"),                               \
+	___DEPRECATED(GET_POISON, "Get Poison List"),                     \
+	___DEPRECATED(INJECT_POISON, "Inject Poison"),                    \
+	___DEPRECATED(CLEAR_POISON, "Clear Poison"),                      \
 	___C(GET_SCAN_MEDIA_CAPS, "Get Scan Media Capabilities"),         \
 	___C(SCAN_MEDIA, "Scan Media"),                                   \
 	___C(GET_SCAN_MEDIA, "Get Scan Media Results"),                   \
 	___C(MAX, "invalid / last command")
 
 #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
+#define ___DEPRECATED(a, b) CXL_MEM_DEPRECATED_ID_##a
 enum { CXL_CMDS };
 
 #undef ___C
+#undef ___DEPRECATED
 #define ___C(a, b) { b }
+#define ___DEPRECATED(a, b) { "Deprecated " b }
 static const struct {
 	const char *name;
 } cxl_command_names[] __attribute__((__unused__)) = { CXL_CMDS };
@@ -68,6 +71,28 @@ static const struct {
  */
 
 #undef ___C
+#undef ___DEPRECATED
+#define ___C(a, b) (0)
+#define ___DEPRECATED(a, b) (1)
+
+static const u8 cxl_deprecated_commands[]
+	__attribute__((__unused__)) = { CXL_CMDS };
+
+/*
+ * Here's how this actually breaks out:
+ * cxl_deprecated_commands[] = {
+ *	[CXL_MEM_COMMAND_ID_INVALID] = 0,
+ *	[CXL_MEM_COMMAND_ID_IDENTIFY] = 0,
+ *	...
+ *	[CXL_MEM_DEPRECATED_ID_GET_POISON] = 1,
+ *	[CXL_MEM_DEPRECATED_ID_INJECT_POISON] = 1,
+ *	[CXL_MEM_DEPRECATED_ID_CLEAR_POISON] = 1,
+ *	...
+ * };
+ */
+
+#undef ___C
+#undef ___DEPRECATED
 
 /**
  * struct cxl_command_info - Command information returned from a query.
-- 
2.39.2
-- 8< --

>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_dev_state_identify, CXL);
> @@ -1107,6 +1115,69 @@ int cxl_set_timestamp(struct cxl_dev_state *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_set_timestamp, CXL);
>  
> +int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
> +		       struct cxl_region *cxlr)
> +{
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_mbox_poison_out *po;
> +	struct cxl_mbox_poison_in pi;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	int nr_records = 0;
> +	int rc;
> +
> +	rc = mutex_lock_interruptible(&cxlds->poison.lock);
> +	if (rc)
> +		return rc;
> +
> +	po = cxlds->poison.list_out;
> +	pi.offset = cpu_to_le64(offset);
> +	pi.length = cpu_to_le64(len / CXL_POISON_LEN_MULT);
> +
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_GET_POISON,
> +		.size_in = sizeof(pi),
> +		.payload_in = &pi,
> +		.size_out = cxlds->payload_size,
> +		.payload_out = po,
> +		.min_out = struct_size(po, record, 0),
> +	};
> +
> +	do {
> +		rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +		if (rc)
> +			break;
> +
> +		/* TODO TRACE the media error records */
> +
> +		/* Protect against an uncleared _FLAG_MORE */
> +		nr_records = nr_records + le16_to_cpu(po->count);
> +		if (nr_records >= cxlds->poison.max_errors) {
> +			dev_dbg(&cxlmd->dev, "Max Error Records reached: %d\n",
> +				nr_records);
> +			break;
> +		}
> +	} while (po->flags & CXL_POISON_FLAG_MORE);
> +
> +	mutex_unlock(&cxlds->poison.lock);
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_mem_get_poison, CXL);
> +
> +int cxl_poison_state_init(struct cxl_dev_state *cxlds)
> +{
> +	if (!test_bit(CXL_MEM_COMMAND_ID_GET_POISON, cxlds->enabled_cmds))
> +		return 0;
> +
> +	cxlds->poison.list_out = devm_kzalloc(cxlds->dev, cxlds->payload_size,
> +					      GFP_KERNEL);

Given the payload can be multiple pages in size use kvmalloc() like
cxl_mem_alloc_event_buf().

> +	if (!cxlds->poison.list_out)
> +		return -ENOMEM;
> +
> +	mutex_init(&cxlds->poison.lock);
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_poison_state_init, CXL);
> +
>  struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
>  {
>  	struct cxl_dev_state *cxlds;
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index ccbafc05a636..a3033c8dd8e2 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -215,6 +215,24 @@ struct cxl_event_state {
>  	struct mutex log_lock;
>  };
>  
> +/**
> + * struct cxl_poison_state - Driver poison state info
> + *
> + * @max_errors: Maximum media error records held in device cache
> + * @list_out: The poison list payload returned by device
> + * @lock: Protect reads of the poison list
> + *
> + * Reads of the poison list are synchronized to ensure that a reader
> + * does not get an incomplete list because their request overlapped
> + * (was interrupted or preceded by) another read request of the same
> + * DPA range. CXL Spec 3.0 Section 8.2.9.8.4.1
> + */
> +struct cxl_poison_state {
> +	u32 max_errors;
> +	struct cxl_mbox_poison_out *list_out;
> +	struct mutex lock;  /* Protect reads of poison list */
> +};
> +
>  /**
>   * struct cxl_dev_state - The driver device state
>   *
> @@ -251,6 +269,7 @@ struct cxl_event_state {
>   * @serial: PCIe Device Serial Number
>   * @doe_mbs: PCI DOE mailbox array
>   * @event: event log driver state
> + * @poison: poison driver state info
>   * @mbox_send: @dev specific transport for transmitting mailbox commands
>   *
>   * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
> @@ -290,6 +309,7 @@ struct cxl_dev_state {
>  	struct xarray doe_mbs;
>  
>  	struct cxl_event_state event;
> +	struct cxl_poison_state poison;
>  
>  	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
>  };
> @@ -538,6 +558,50 @@ struct cxl_mbox_set_timestamp_in {
>  
>  } __packed;
>  
> +/* Get Poison List  CXL 3.0 Spec 8.2.9.8.4.1 */
> +struct cxl_mbox_poison_in {
> +	__le64 offset;
> +	__le64 length;
> +} __packed;
> +
> +struct cxl_mbox_poison_out {
> +	u8 flags;
> +	u8 rsvd1;
> +	__le64 overflow_t;

I was wondering what the "_t" meant, I always read that as "type". Perhaps
"_ts" or even just spell out "_timestamp".

Aside from the minor fixups and reworking the enumeration mechanism per
above, this looks good to me.
