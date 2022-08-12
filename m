Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEF7C25B06
	for <linux-cxl@archiver.kernel.org>; Fri, 12 Aug 2022 01:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234493AbiHLBCR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 Aug 2022 21:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236270AbiHLBCF (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 Aug 2022 21:02:05 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CA774DF3
        for <linux-cxl@vger.kernel.org>; Thu, 11 Aug 2022 18:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660266124; x=1691802124;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=lYab6d5NimLLEeO4KCa0pV3kudre36now6nGHz++r6o=;
  b=MPKEG5LKj8rnIHPZ3JrwYRH84mF3QIUi1VuY3djopVfxOs96QIhTkihS
   oFC2QvPjNHGcaSfx5Gp/TyFks+r1RDx6A2wx2QGgxL3Pt6tG/xZYvV7An
   LQjogZ4l20PbaI9EV5wL1z4Ps246K8xpuwqRedz7w0F9R67W0wSCdwZCj
   m6xosbvj08yQMvZcicdALV4zKjRrLa9V3RGZNX99cjgpMryPcrg+Qacwk
   SjUeAp/udihrPJfH32Xmb5tlDy+clLJ+fxyV2lSuRrBwpcfRzTIBc8WhH
   8q3WJy2Fkg35kuqDQmrYneVpW/tKJgMIsJXBQ857PKS7ipnN7W6LMDDEk
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10436"; a="292289510"
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="292289510"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2022 18:02:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,231,1654585200"; 
   d="scan'208";a="708824332"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 11 Aug 2022 18:02:03 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 11 Aug 2022 18:02:03 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 11 Aug 2022 18:02:01 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 11 Aug 2022 18:02:01 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 11 Aug 2022 18:02:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mm+MftcndQh65iaoQT6klqTvAt4fLY4bFO5iYN3u934yW/l6XRDkeNjJgBsUfmgMZrAo3dc6SbEaN1jb6OwqJ8C613HsID1y67PvoBCaeHnBUbQhli4yz9BDLMQ2AFsIF3CehK1yS3ORZTETUVrTPHrWoIBd703eeLVpxlGgdjJMLZmaHozGTyYx4WDYeOpWTxJhOahs/Sf9YtwJoeh0veqa4JKXRNn95fY9aSKRf3TkZNKBgEuBbXlGwFvuQFED7utfaaRpbIXYO7L+hFrRxR9uCt5u2TG3zCWbnQdUijZI7AdCz5ZIicqjdaDPuIuQ6d7gKigHM4/JYtr4hizrZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2AT/CqfmQgJRXmu4VfN1ZipEsclZVQuQ2OkcGjgaIo=;
 b=IDz9DHIpvVE+XbRQLce0pKYfSa3sFe5umJc25FJlXFGZUo0iRiVuVwnixcWwsxAtXDOtHk91asvE/RdDaSh2ql2CVtHCG9A3X0UPULO5sedh07RnJKMYpOMrtEhn3p5b2fBOWGkPO95vOX8+UKMdKcRe8Uzt2JhxMKZQSX9p58ss37hdyl5n1ZV/TQqO5mj9f1rhQuARnYiMpicgh/VJ3uxt1F6pcNaaOlRJs/q34vAhMsHO4fAxffQZR+nDp9u/HW95LWyPu1RAuO714tXwHIhwfatjkcq0zFTCN+lQVxlwKsLl0IqzL0q/yaL7kLvvTkYJwCyiii+zAir8kyYL3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MN2PR11MB4143.namprd11.prod.outlook.com
 (2603:10b6:208:137::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 12 Aug
 2022 01:01:59 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5504.025; Fri, 12 Aug 2022
 01:01:59 +0000
Date:   Thu, 11 Aug 2022 18:01:57 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC:     <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <alison.schofield@intel.com>,
        <Jonathan.Cameron@huawei.com>
Subject: RE: [PATCH v2 2/3] cxl: Add CXL spec v3.0 interleave support
Message-ID: <62f5a684eef9e_3ce68294f1@dwillia2-xfh.jf.intel.com.notmuch>
References: <166026184968.1454405.494690416353090765.stgit@djiang5-desk4.jf.intel.com>
 <166026222055.1454405.5853343066246585992.stgit@djiang5-desk4.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <166026222055.1454405.5853343066246585992.stgit@djiang5-desk4.jf.intel.com>
X-ClientProxiedBy: SJ0PR05CA0118.namprd05.prod.outlook.com
 (2603:10b6:a03:334::33) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a95e1358-813e-4517-f1ba-08da7bfe4234
X-MS-TrafficTypeDiagnostic: MN2PR11MB4143:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wLnLvkSQUr6qE8aRb8xEj3FHMBxDhmIiiXfE+gi71guoNw+V2Ub86WQ+3IsTDob6FYiXEbOLXmTk2qe39dwmxtc2OxkUYeuspg9c2usDdCabonUAiV1DPF0FmcGrgBaHdZZwrrF8rPqYzft6EeKkKX4xBbu+V+iM9CeDhSc+vVqqUVLm92JXWULAfn8/M94I+jwYGKTHR113CCWoMVeFoIkSNJnt4YaJ+ZCAk9viAHo9+ammUT7HjUTx/Xf8FMmhdl1GS9jjU6zmk33PIaa3M2pH1UQGBERoiO69bO/usk7imGS1928bQb4d8f+iSE0kulScWnWK5kXbK52iWZwzq7aJEfGov91LARs7UprFJoLp2rZuFJEdmaMP96lbGlawsVpSOGlF2JZfaFqEe6+O0zMzrRYVjoc6qf2yt5C6wZ2zShstlMuP3dwEHxiWDD0tC+4yHQrGa4uzJwwYmffKgwpnxGzL+MKmcZYSDYXxbgrz80mSuW9zmP5eeoh3w6xcZx3Uk0lo8cVjrF7XU7Jm2JFICXR6jc48KCcxP2N1JGbjD86v9sjDz8r1CReAaoLJhAkm1xUcC0tx9OesKXBvGL7Pc2FplJq305dqP7Qds8OwZZtEnd41ba/FSOUewviBthxBkXs9yG5+RkGc9knzM7x1dlf+wENanrX63UGK8pPJl82ek89IYRSLfg5hyrGDQbXB/q6peJom29g3H0T62A9Su4twLUvkrXmJYSO8cK2qp1RRVqksAXpxN7MWiUPI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(396003)(346002)(376002)(366004)(83380400001)(86362001)(82960400001)(38100700002)(478600001)(316002)(6486002)(66476007)(4326008)(8676002)(66556008)(186003)(66946007)(6512007)(2906002)(6506007)(26005)(9686003)(5660300002)(41300700001)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?14iuKlNdi1V/9lhtlbbxKg7R9jVvfv2CIElG5EEPTyeldd3/Yl57TQ+NU2BB?=
 =?us-ascii?Q?bkXuCmkvxRcsaTkiZ2cGUTG1IyiKIjQOZ28nHAPeoiUJJcGh3JwA9ZV0x1ou?=
 =?us-ascii?Q?74c5Xp3nEE1SkJxeBvuSzYSZbkc2K9NgLwgMkaZRbR47CRLONT4cmt1N+BXr?=
 =?us-ascii?Q?AESgF3vhUBK5+aCh7K2BNHZeD6ICPB9J4GlBZS6SITyWULATJV+6uCjo5h1z?=
 =?us-ascii?Q?OWwoAYAh0DBe1M/vyDHRI9/Azuvm3AlaNxgFBE7/9c42J1vPoG80ZcJF+t0l?=
 =?us-ascii?Q?o4NDP8x8c6HGMw4G5YTBaIym8zJ/Ppwd2+BQBggOr/Y10mTa7jNTTtJ7fJs8?=
 =?us-ascii?Q?Tdj/pxGMXZs5z0+86VFlMraVmI3+nJzceVeKFACqRlz9F8OPDGDK4LzaDshK?=
 =?us-ascii?Q?ggM7aepkWBFT60/oQ3rPKM86mfu9VixQbopFyNstqGhctLDo+aA1YOtha6vl?=
 =?us-ascii?Q?7FoDS4InUeHD2KeXBf6D9q+nOTZ3AQZqJvkDWGCP2REH504dSaiS139SO4M4?=
 =?us-ascii?Q?f2ePq4dA3LZWpHQw5+dmKAnilOpa1XWWIE+cmAHH0pOIgsgc2tOqL8583KUJ?=
 =?us-ascii?Q?I6xwEaR15+ugPGATpSe2enpDHh3mBDze3BYV5BGrngAK261ekWdahZI5+eni?=
 =?us-ascii?Q?MOpX2oIPVkWsaBAezCaylalkywWQDkKmVmV3FOWsIms8CeezGDnqncqJmMLL?=
 =?us-ascii?Q?JQjhgneA11/SOc01+PLQjthCadFDd79H6xV9b+9pZHsFkBV2CA83V40WB7MG?=
 =?us-ascii?Q?z8v0en8RfOPT6xBTXMOPlnEkKzUmf6bnAgNIvIo/OktrD9d1LZMnMJR+IIpy?=
 =?us-ascii?Q?P5hVxQ9u7gZUGCmSzQnNE1uohY0i1Y4yJqlg3O6g8vgM9lSytniT3svsjHEW?=
 =?us-ascii?Q?Ck1YjukHipdVOiOMMJpxfDqRPba3DY3L+yN8cYVhxMxjM82flZwu+p1/YNTI?=
 =?us-ascii?Q?M0RYudXhgmIDjcsxnescwB4GnAI1jj1UH0qqtnxUmRXteW4/E1W8Hht0hQR1?=
 =?us-ascii?Q?69xHxfYtIK/eS5Oh2dCSt/L1lZ4mMP53gmHiWDqNk8zbvSJ2D4ZSZNvnjwls?=
 =?us-ascii?Q?t7iwduZEgOlu+/kb5EuAhJNbpVTu0AW15UkjTQIfhDL8FofnJhznjdiCXaZ1?=
 =?us-ascii?Q?QNgeLrPeYmvLAiybPyE2ZqAIA/gxDhJmts94/4OtegqjisbCtym5i/skUnKV?=
 =?us-ascii?Q?pQQJUpEnh8H7MTXTCtrT4h/mc0s5VWVcCbF48rYrp/CnJX8gzQPTTilkhqIr?=
 =?us-ascii?Q?jUyM47f4mwEhzvH5a+06XWkvIHateliaFZNtuzA88JqNkypRlgc3TGKFF8VL?=
 =?us-ascii?Q?AIvaXQZxq0oSaHlKFK97f7qwgBs4TZCZi9G5PHoPFWqHHJ06Z43/7kFa9h4v?=
 =?us-ascii?Q?oJmjPjWeBD+dixH4ZGLQ0sr1eL4ZxiLDVp12RYNSJxWktlQqxjy1+Jos7jhc?=
 =?us-ascii?Q?sHhPFKZ9bWRCtoSyLbG++DDVwSyQsjjJEaGG0bBe3Buh7A6h5Lp16z0WLYuM?=
 =?us-ascii?Q?4pqtm2jyELz0yXXV5BANRU7hAtmq+wB6OVRHG5X54VSmAMePwVEARFPJgvlA?=
 =?us-ascii?Q?q10dxgvqzVX2HQUO0RPpC/aoiitJ4Z2XtPq13w93rvHqTf62okMrS3hDp506?=
 =?us-ascii?Q?SQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a95e1358-813e-4517-f1ba-08da7bfe4234
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2022 01:01:59.0272
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9qLBNIyc8fHbQTd4sAvSvwlx9lAaUFGdKH2I9D5BOe8MuF9YcvSr8HX32rxPMV7fF/nXuzRqEShbXBgCGKPa67db8E0fEBBwxB5bIopUQ2w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4143
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> CXL spec v3.0 added 2 CAP bits to the CXL HDM Decoder Capability Register.
> CXL spec v3.0 8.2.4.19.1. Bit 11 indicates that 3, 6, and 12 way interleave
> is capable. Bit 12 indicates that 16 way interleave is capable.
> 
> Add code to parse_hdm_decoder_caps() to cache those new bits. Add check in
> cxl_interleave_verify() call to make sure those CAP bits matches the passed
> in interleave value.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/hdm.c |    6 ++++++
>  drivers/cxl/cxl.h      |    2 ++
>  drivers/cxl/cxlmem.h   |   13 +++++++++++++
>  3 files changed, 21 insertions(+)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 8143e2615957..0baf3c4820a5 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -80,6 +80,12 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
>  		cxlhdm->interleave_mask |= GENMASK(11, 8);
>  	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_14_12, hdm_cap))
>  		cxlhdm->interleave_mask |= GENMASK(14, 12);
> +
> +	cxlhdm->interleave_cap = CXL_HDM_INTERLEAVE_CAP_DEFAULT;
> +	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY, hdm_cap))
> +		cxlhdm->interleave_cap |= CXL_HDM_INTERLEAVE_CAP_3_6_12;
> +	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_16_WAY, hdm_cap))
> +		cxlhdm->interleave_cap |= CXL_HDM_INTERLEAVE_CAP_16;
>  }
>  
>  static void __iomem *map_hdm_decoder_regs(struct cxl_port *port,
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index bc604b7e44fb..105d814941e7 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -42,6 +42,8 @@
>  #define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
>  #define   CXL_HDM_DECODER_INTERLEAVE_11_8 BIT(8)
>  #define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
> +#define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY BIT(11)
> +#define   CXL_HDM_DECODER_INTERLEAVE_16_WAY BIT(12)
>  #define CXL_HDM_DECODER_CTRL_OFFSET 0x4
>  #define   CXL_HDM_DECODER_ENABLE BIT(1)
>  #define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 625fce0b6c2c..ebd645d8bbb4 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -393,14 +393,24 @@ static inline void cxl_mem_active_dec(void)
>  }
>  #endif
>  
> +#define CXL_HDM_INTERLEAVE_CAP_DEFAULT BIT(1) | BIT(2) | BIT(4) | BIT(8)
> +#define CXL_HDM_INTERLEAVE_CAP_3_6_12 BIT(3) | BIT(6) | BIT(12)
> +#define CXL_HDM_INTERLEAVE_CAP_16 BIT(16)
> +
>  struct cxl_hdm {
>  	struct cxl_component_regs regs;
>  	unsigned int decoder_count;
>  	unsigned int target_count;
>  	unsigned int interleave_mask;
> +	unsigned long interleave_cap;
>  	struct cxl_port *port;
>  };
>  
> +static inline bool valid_interleave_ways(struct cxl_hdm *cxlhdm, u8 iw)
> +{
> +	return test_bit(iw, &cxlhdm->interleave_cap);
> +}

I think "test_bit(iw, &cxlhdm->interleave_cap)" is self explanatory, no
need for the valid_interleave_ways() wrapper.

Other than that:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
