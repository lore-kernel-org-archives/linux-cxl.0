Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A79C636D3
	for <linux-cxl@archiver.kernel.org>; Tue,  7 Feb 2023 21:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjBGV7D (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 7 Feb 2023 16:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjBGV7C (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 7 Feb 2023 16:59:02 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937DC3B3C5
        for <linux-cxl@vger.kernel.org>; Tue,  7 Feb 2023 13:59:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675807141; x=1707343141;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=wrPjnM6nQ6naBCkHh0vSyAI2AU2LeMJ+iNkEpyCoO+o=;
  b=VG/gG66VZhjmbUDnhAkiMpU0ric5rOn8g1cGLmnlxle+TqC71F7rsrgu
   WbxTuBvQl/TniDlIvTck5odPkbEvMMl9BaeT1pfOJY27es0WgsEHY4SbF
   hvvPxbd4bCxpiFcgGdG2BccjmmR6USu9ukpgnq9qECFbcidMOhkHt+bmm
   42pf+6dT1iIlBeIkALP9LUXemeyQkmD19b02FfQeG5cTB69ldg9hfZ+a1
   Dl7iqxm/o6VlwKWTZIyTQjh+nJfZR4xZEG8NFGqkVUXIw3aC+fWGBsdhG
   iKlQ9cgqP7SSbaJZed6tWDxz2sj8pSQSBZme8iPOQhw6xggnu21IYpXLA
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="328286921"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="328286921"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 13:58:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="775737604"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="775737604"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 07 Feb 2023 13:58:50 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 7 Feb 2023 13:58:50 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 7 Feb 2023 13:58:50 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.44) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 7 Feb 2023 13:58:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HgZc01hpDEf4NPrLYYlzQMTjyBmBKFQjIfWGfq3XLdCKFzOhx4vwE80ogWkASMyld+Mq7jFjAjoJhW/QOdUP5SgNyXTOJ5NgKOZ27TdyF8SSOiIYkQdN3GyRH/8QIYerFaveq7Cv0ivLmP6Byp0gT2LT/PN6+TTsNjvB/pIqI4wPytqndqJ4S4OLzdqJiB2qSWFOMwRioa6jJTSWNsz5HWvj30KLtZoo4PjjPK/uawSRFYoJla6jg2y+2eLh+SSeaf6PpVl1ifCN+nnIp3TJKY/S+FpuxU6AHsG2d6Y3+UocqOvkI7rDbZpPlY6jYsk6sLHvE7b6Fk3VNTEAk3E/iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bDH51jl6Ua8E4HPVGTIJNXTnhmpGyuumziRtJeC0HNo=;
 b=d45PsEgVMsy5QqQAHGzqm3LJ1eorDaRBi3R0ltWWWxSsjakjQCpVZ1TaYn8C8QxcGMRhcQOqPI6wpgiJdkHyBR5b8g9Rzjzk3/AIPehW3QM59V78m6ZVwc2mcxBzPEVFNDT6gfwiRYttqTVIt26arqKK7fLsDkzfTuNXc0DOBLJR3z6kpXpkwRJEpzJH0PzMG14BhBxqU4AEJQbnk1tg7JLbz6QAjc7CV1yxo88NB/VMTh76rveMIGPQBjNCoFPV0fZnxtoSPlhHFVo+WxkyDWieu23hnmLGYEN9VEkdMEZqEOsTRE0ELAcL//16MdoaLpdz4V4nWQleY04W2wtt8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB8208.namprd11.prod.outlook.com (2603:10b6:8:165::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.36; Tue, 7 Feb
 2023 21:58:46 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6064.036; Tue, 7 Feb 2023
 21:58:46 +0000
Date:   Tue, 7 Feb 2023 13:58:43 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC:     <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <jonathan.cameron@huawei.com>
Subject: RE: [PATCH v3 1/8] cxl: break out range register decoding from
 cxl_hdm_decode_init()
Message-ID: <63e2c9933a27e_e3dae29415@dwillia2-xfh.jf.intel.com.notmuch>
References: <167406522720.1455071.8837344641950166822.stgit@djiang5-mobl3.local>
 <167406530747.1455071.6556733331321082239.stgit@djiang5-mobl3.local>
 <63e2c8d4bcc4d_e3dae2947d@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <63e2c8d4bcc4d_e3dae2947d@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: BYAPR11CA0105.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::46) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB8208:EE_
X-MS-Office365-Filtering-Correlation-Id: 9038eacf-0fea-4407-f370-08db09567c2d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n+siqhajRYCPFOvRtC2MoioL3KJN6Prk5jg/W8UKPQ9ws9Wm1rzeQi5qPqlBB7tTTxTTLKdSj0Rmgz+kBvUhZICtMpXeiXkRWLR5PUmFF8rPh0X+DJeKiKiyJKbaqwy98jQBlw884JOqwsdyB2dBPoIUydLk8/6NEqTSmYUXgoq4BMcZb1Lg2GO+bmrqOUmMoxpUnm25gM3v/mtaWKWJaTU4qD6lTdrnUTQknz1XaoUjpUTe0ayVdvL7jq0SHN4m3LFUDuMVqQ2bmw1XBuJCCjy+sJaAs+V3ztGnXTNNxwpE9fAiDtm6Gqa9+z9HfbU6AooSCLb5tg3sJ+FftjQOTzfgIbXscTBoG7bzZKMYz7lkKiZ2yg4wu7BoGqeGlEYZnRkhZQ6EE4EhVh7r3TuYUtCOLJgdPkl8EPQUEfBjBYzMLmAiItjCv5871/tZhaVUljhGU5uN/eobBESQyArhtGfxEbkrChQIMchnWy9wXdBkK6gHl9rcfkEzk0BkRCov2ishkNvGbUqLYml0SAvPsrIUM+4TYJVSl6YbMhetXgnvu0n22M/C2KpgLsmkgm1g5SG6dFsUv2+WOo+u/eKvrD3DemntJiJJJR0sKcpi9bWli3iFdUSX7Wtvjvv21DkRHF1K/qxEsbvS7xI6Mf8Shw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(346002)(376002)(396003)(136003)(366004)(39860400002)(451199018)(110136005)(86362001)(186003)(6512007)(2906002)(4326008)(66946007)(5660300002)(66476007)(8936002)(41300700001)(8676002)(66556008)(26005)(478600001)(9686003)(6666004)(6506007)(6486002)(38100700002)(82960400001)(316002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7J/1vK3CP3VJhUNBEN7LzVHVk9CbGQ74lkRBeRopAnWjZZsfPUM6GN+6fJcY?=
 =?us-ascii?Q?WoWQMZISqzmKP5B0MfmakLDTtU2dbIJOUuieO6PZj+9t9DNAydVMEH9sNxOU?=
 =?us-ascii?Q?0vvSfevDcRMTGH0WwmKpYM1dG/WKZrvIx1IgOmHDIiEthBHgmHEYTESQdCXg?=
 =?us-ascii?Q?aiOFcKaFTBVhVA1l2SDP0h0/BOqX9OM0CV9mAj8ZNF6ERQsvClnDtQGF4v+f?=
 =?us-ascii?Q?oCaSI18sIEKwga7IusF7jsUgaeO0vLS5H1ikOXCG1PexM3Cuz0igGSNed7Yw?=
 =?us-ascii?Q?3XWD+v+z5lm4w2bMRReknfLEmjVNib/WM5cx/kLQ9ksywBOTL4Q9eQsvpU8i?=
 =?us-ascii?Q?t4V9P92BWrvH6pkywhu2ZFVpR0KYJYvn7H27KmGXFSsLOBmD5nFCAFlfL1LM?=
 =?us-ascii?Q?0GN/f/7AMYfkAE4g/v30t0V+YT65pA2ggaDjSle5LDowe87uqBkT3BcoiuVF?=
 =?us-ascii?Q?W6j17LS6poquOfBHIwThlxdUk0sqNY9JB/97sUsg0sWMxVl1k/XxukZZe/+0?=
 =?us-ascii?Q?8lWQpAf5a7yrk+Rrl10EuTBuDsAuwGXz6aXr8Unw4px3jbNRw7jUrlfyxaVW?=
 =?us-ascii?Q?ZpybXenCdWi6A+uSX4ujrYatLJtiT8mEFdZrRTU8dNpSFFgnwlpoXQCc2Toq?=
 =?us-ascii?Q?T/SvoUiYKCVNSHT9lxXPb12DCY0duSUGbqZRLArgvI8GzFf+PzwplT6aMDkc?=
 =?us-ascii?Q?fBsB8tvXg1RQKPxaRxqJt+tI441fB3bQawERl5oYLqIJ4TyfOAd3psDionDA?=
 =?us-ascii?Q?GMyBrSE2d0ntG4sWDlmxrAkL/ngakl0i3AdD41jufQaOlYZ8PDCX4XtedhsU?=
 =?us-ascii?Q?z1GUKaMQPRGI7R0PKzoHYU7dhNlH5nKmHjY1K/XAdH/L8J5QQZCLMQMgyBm7?=
 =?us-ascii?Q?pwcZeeGUmqGH/96kaPiBBYxp0nKqMqj8SEjaKKjXdBQOWv/rcEtndL7owZIV?=
 =?us-ascii?Q?PG/7HGLCUM9BhN7+1nuceDvFZnOobv7neRHXcfk1nAenrmXsjOWNW0ds1KJF?=
 =?us-ascii?Q?aWwNPpbc1LtfsOFT9haYObCIXN+TUErdxiYjlQtXN3cPbg8BKwiJEeOz9krP?=
 =?us-ascii?Q?PJObJcnO4BWWpmkpIbozqZm5nNAJPBKpg/SuoPA/jHYfLP8HXfEwkAgNAXCF?=
 =?us-ascii?Q?iuI4neIMGtgKTrirERD/x8VB0AV5K2DZ40Z56ORcMv4GJk0oXrbmLtsXAutG?=
 =?us-ascii?Q?IEvTPJRXMCCdIxQwnEiKvE6POt9MAnfqNVaxe/MaqzbmzqKuU0TRrHcH/RoD?=
 =?us-ascii?Q?HJeGlqwfyD+8E5sfEyKMu+vyh8nZZhCfLastmmL+wqMU4D2bIzmUTEdEazJi?=
 =?us-ascii?Q?bc+pLI3XT+tuxWXTb1U8p0IYNSOoJhqLPR9AALti7tqqBWpS/rQcK7/PhMIl?=
 =?us-ascii?Q?eq53vHyEqR9X0f+c2whj9yEBDEIz1YcxYM4a3X5KjOqnatCzetJrqR9kqGU8?=
 =?us-ascii?Q?KNGbNCj3ZCf+wWPEaxo2wlrP/E0Gm9d3HZ72LKLWpprVwMyzYaPKo9xRHw9i?=
 =?us-ascii?Q?+1D89g5ZSShPl12XC/8OXIBYvqotv+e6+5qA2CLII+RHSCNiQfqQzWYtMT3W?=
 =?us-ascii?Q?Ik5Ri65x/XddvjiCbWuYv0QII87mxWC0d7OvPqNl7slz17jwClaqiV5vF6Ok?=
 =?us-ascii?Q?wg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9038eacf-0fea-4407-f370-08db09567c2d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2023 21:58:46.0468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lhymoDolS5pvXO/knnTlFUMK2luKwddrJLLoncJOXWQGA+E07/VBt4coFisYbPncB2BEq0NBD8cPtpBuT60hPZJg7vzrHOg4GujpUGeWL70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8208
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dan Williams wrote:
> Dave Jiang wrote:
> > There are 2 scenarios that requires additional handling. 1. A device that
> > has active ranges in DVSEC range registers (RR) but no HDM decoder register
> > block. 2. A device that has both RR active and HDM, but the HDM decoders
> > are not programmed. The goal is to create emulated decoder software structs
> > based on the RR.
> > 
> > Move the CXL DVSEC range register decoding code block from
> > cxl_hdm_decode_init() to its own function. Refactor code in preparation for
> > the HDM decoder emulation.  There is no functionality change to the code.
> > Name the new function to cxl_dvsec_rr_decode().
> > 
> > The only change is to set range->start and range->end to CXL_RESOURCE_NONE
> > and skipping the reading of base registers if the range size is 0, which
> > equates to range not active.
> > 
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> > 
> > ---
> > v2:
> > - Refactor to continue when size is 0. (Jonathan)
> > ---
> >  drivers/cxl/core/pci.c |   63 ++++++++++++++++++++++++++++++------------------
> >  1 file changed, 40 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > index 57764e9cd19d..a8ecc6ddb3d7 100644
> > --- a/drivers/cxl/core/pci.c
> > +++ b/drivers/cxl/core/pci.c
> [..]
> > @@ -410,6 +400,13 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm)
> >  			return rc;
> >  
> >  		size |= temp & CXL_DVSEC_MEM_SIZE_LOW_MASK;
> > +		if (!size) {
> > +			info->dvsec_range[i] = (struct range) {
> > +				.start = CXL_RESOURCE_NONE,
> > +				.end = CXL_RESOURCE_NONE,
> > +			};
> 
> This should just be .start = 0, and .end = -1, or .start =
> CXL_RESOURCE_NONE, and .end = CXL_RESOURCE_NONE - 1, right? Otherwise,
> range_len() on this range will be non-zero. Likely moot because the
> range will be skipped because @ranges++ gets skipped, but it looks
> strange written this way.

Actually, IIUC, this update can just be deleted altogether because
@ranges++ being skipped already invalidates this entry.
