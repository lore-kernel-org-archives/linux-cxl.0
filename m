Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5895C636CD
	for <linux-cxl@archiver.kernel.org>; Wed,  8 Feb 2023 00:55:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjBHAzc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 7 Feb 2023 19:55:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjBHAza (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 7 Feb 2023 19:55:30 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B67D29E24
        for <linux-cxl@vger.kernel.org>; Tue,  7 Feb 2023 16:55:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675817729; x=1707353729;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AjtrXmQJibmTRgI5BSRuZw3ncK5X/l9uR7nBNCbs2w0=;
  b=SBXsj+VMxywK4xdlPoPnI4GZkAT2OtIPASheTW1lXcm+8ZLWrcjpvbL0
   VN0PHKYM4uId8Sm6oqUK9oy8fzv1f4jCQIqXbUZUW3l2Pr+QEsDjFnid9
   C554FwBREm/6dAkett0SGbWn+aUlW8lbOrOYpb7AxlTMCRd2ZvqACGR2k
   bChKwGE4cUGwX0tdHMAIAd4oJRZJqDxqpCJGSXtbNELU2rGt0hOcxzKPd
   igZeAIxO1+PFYJwCKU/kqVAHBJWC9xMEQ5cks3AZV+7w1cqK/2OGZ4m2q
   +TFXDRDgkzdVTTNxtGOnHYGt9+Gnz0MZL6R0WhHLaAXUBrXGRNumYjkVE
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="330962905"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="330962905"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 16:55:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="912534211"
X-IronPort-AV: E=Sophos;i="5.97,279,1669104000"; 
   d="scan'208";a="912534211"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 07 Feb 2023 16:55:28 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 7 Feb 2023 16:55:28 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 7 Feb 2023 16:55:27 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 7 Feb 2023 16:55:27 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 7 Feb 2023 16:55:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bnPY34a+ZqdLjm2xU+I++3lmPOf8l1bG6Ygt/Rv1oCJqxDSv094bJqwoBVrBJXl8rRd66Uniuc/GvXQl7Q82aOjkavcFF062fGvvzK/pQDcrFQf/x6b2C3dKz2/eG/iE5QIoAfFpp4nhzo2hJQCI1QFed+SOjtky0NLMzStMjpCDgztXhePu9HOp9GQCCaQdO0UMF9i3Y8ZVJnR/t6HGeFanmU3uqeUcArpBj1J5QDkpL0Jrdv6dwC4KVZs7FTIW+NdJLxo8hSWK8PIEPnGgtdWDAN79tkz5Q8UVV8u4/6iRYOieMzgJJRqYdf/cnIZvSsiyJ3jkEwbys1TJs/e8Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0BCBKqvQqwv2+pzwZl14ehtj7ijiIrXkycZWEmprVo=;
 b=WgU14lQX3iR50Qjl2Y3L9L36unzKJER/s/d+SE1MFZEUn2JkwuJdbr/WaoOGsZWOxljlpzPKIz1Xt11Zjk9MetOKf+iSKXGSEg5en0Xgxqwdz7pu6Ac+JKxu5mE10hf44rPBRF1WUxIzdVpnZcSX97UzIWee5KWvG9IZi4sv1Y/YvTq153Nj33nLzvQme7VJFL3Q28md41iJtbwhi2EuSPH5u8LunnMxwd/6L4146yYdmN8z2c3X1qVDkw2u+a+aKnei7zrI1lrvBzQtTIxDwmEyjVHccHul8RzWWgtHm+vOmEjHy3q5CZIRtVvc5G+NexNvlKLW3vMoDvXj2/393A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB7151.namprd11.prod.outlook.com (2603:10b6:303:220::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Wed, 8 Feb
 2023 00:55:25 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6064.036; Wed, 8 Feb 2023
 00:55:24 +0000
Date:   Tue, 7 Feb 2023 16:55:21 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC:     <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <jonathan.cameron@huawei.com>
Subject: RE: [PATCH v3 6/8] cxl: create emulated decoders for devices without
 HDM decoders
Message-ID: <63e2f2f9b1995_e3dae29442@dwillia2-xfh.jf.intel.com.notmuch>
References: <167406522720.1455071.8837344641950166822.stgit@djiang5-mobl3.local>
 <167406535137.1455071.12470540886828540377.stgit@djiang5-mobl3.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <167406535137.1455071.12470540886828540377.stgit@djiang5-mobl3.local>
X-ClientProxiedBy: SJ0PR05CA0082.namprd05.prod.outlook.com
 (2603:10b6:a03:332::27) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB7151:EE_
X-MS-Office365-Filtering-Correlation-Id: b6498cf5-60a8-4e6f-9ad1-08db096f2972
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HgwsjZkQg6W51kLyOkgU4WOyHbkapcf/hUoM3QiF76LH91ATPWqYPCE+YYItMv9Cn3to8GgsNY4rrbLG6kHkjgmMC73g/WwR3MYcgL5kSIhPWA1BtpAdaAz0AXBzIR5MSOQ357Dc6J35jUFI9iVtqHMWfSKutgzqOkOlHlVlFOC2NBXMWYalMdGaAs5hJT6xTn95Bj6UMZg6TXzpov3kFGUAiEGihLyX3lK0SiIbOlQcWez1Jgj7b2c7KbmntJ4M+qaIGWdJAMuA+U4687eJyphyZBdhgkcHVrBbznR7og4S/Y0q+CQbnEUzpxzj+vYTMvDNtiU+wykfa8IneMGgcNfkIQQcaN9Q4xNgfA7Vr2DIprLHbtmY//YiQEzZ/IoEXWQwf+6LVDI2BPM3uRyBgauXkuKy2eQW8YBMvktIinsw1hhoyX8crPqMBk1ughXNRYVCU9rotMfjW/eDZE7frGZje3PegihV1UVnGF08CSm5pbQMQKW2xmee1PrGqU+xw+dnkf/nq86guaioOgyvx9KgTvl5fQtqCIOaTSMBSznm1vbeBOsd4FploCeF4zSFk4OsAsZRbYW8VS/VPtEcktSqldCnqjPyGtLQZc9X94nJ+9OZiiCN7ll1mvelnRXDxwMssSyoIZXDy+rc3KuuVg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(396003)(346002)(366004)(376002)(136003)(451199018)(83380400001)(316002)(5660300002)(86362001)(8936002)(66946007)(38100700002)(2906002)(4326008)(82960400001)(8676002)(66476007)(6486002)(66556008)(186003)(478600001)(6666004)(9686003)(6512007)(41300700001)(26005)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?usUpj1uyg8WquPM4aHX2BmymG5JpjaLefUP5ov/U0Ew1kJIKHfj8/P9sWdpS?=
 =?us-ascii?Q?sKKkvzLiw/eupXoJrCkHnQwGXS6CYIksCK2DIhd8460PDFYgGNXCCZ35rYIl?=
 =?us-ascii?Q?Z4WonHQgkJTM5vnnI6sfEfIoKLG/5onSAtLZEJJxxcGkduEYATVf4HW0G+cF?=
 =?us-ascii?Q?BKObnpnp/0g9giAnzfnkXyOV+NtHQnb5diEIXuP/03gATAstdnBkxVC+rFmg?=
 =?us-ascii?Q?fVxVypL5ZW2ffOSf+CzEp36i7csK1fFff9+MufjSjhTa7VkSRS6t+izWsXzc?=
 =?us-ascii?Q?R779jFL+KivtPPeJ0SNX9MrVtEAy9PQie88IBH2Ix7N+FNqoy1jreTLsyr9w?=
 =?us-ascii?Q?+bveZbzLnIrHKcyjy1SsRAFsCEJz7yFQG3qTCtSEce2GVT6uBHZTIgpFeE6c?=
 =?us-ascii?Q?efHZPOlCqc1AndpY1ivav+iExdM53dFe3n3CKheIPr0BlpK2MqKRRugBgQ/C?=
 =?us-ascii?Q?29APAYPUxIq/5iILhG8EErtzsdcfjO/9dwHCvZDLGaOiXsGthQzDZyTBHBES?=
 =?us-ascii?Q?hH02fMcygBgLKDj9+4HZqZrq1BJZqpIXN/7UQ0u0kTatmO3fcYrL6duWp3ya?=
 =?us-ascii?Q?cb1/PM17vHrsRlGSwUi5X38kqjABZMUKspNzzaXNE7FueE8pPgF31AkBs16B?=
 =?us-ascii?Q?6kiOW9DPDvHHsgfva0OffvKL60/8Cjl2bd2t3Yqdo5xJTyW/R7HVzahfIuYS?=
 =?us-ascii?Q?WGHHGbx+NNA7oBMAA6zkIQfafW7R9A2bJaEriPz09umyYQMBqUY50Y7QQdsm?=
 =?us-ascii?Q?wdxXg1CrpRHaO9JEsXlpdnTB9moE3aah7o6rN/LQXWi5ZCE993dOWmY1NadG?=
 =?us-ascii?Q?mYKMzl1inwIYfg/0XpSao9n6adQb3shmrvgsUZvs9tD2GX7Zww8WoSn9mA6a?=
 =?us-ascii?Q?UP0F5xLIA9kc68ogrkq01fkW4Nanj+v1mbbLo0mvVBWsiNjsBS3dia4E5f6A?=
 =?us-ascii?Q?nqNCTicUgqpp6SKRMRiJXax+0Y1f3dNuG/OxMUBPQ1EWlK3C585uGqOmNFKc?=
 =?us-ascii?Q?ceY1ZCNifppIljCddIfFB085RfdhLmEBfoLCZuM8lALrfRFRGq+q4s8Y+jf5?=
 =?us-ascii?Q?klAZpJ1NMF2B2JPNMPEUxpu7072lFawTPw8Rw0ML/zZLquu2OnarYpyamnEx?=
 =?us-ascii?Q?X+kR57/pI0eC12Z+gzuVK1n5fiAKAQ49W6cn95oIg0BgIlh0C6Yo6EmQNlGK?=
 =?us-ascii?Q?0bl1M8GNHzZKKSI3/2YyavYOJOx/KMy6CDTVNy8rQ5KS2crgIlD9MpFDneQG?=
 =?us-ascii?Q?P4Iz0mgzHNjk2NVS+Ico1hF1/zvlAruhMgLi5M/4EhL80UahlXqQZhn7u9PV?=
 =?us-ascii?Q?ZhzwayN0qFW2fTkNjEGrDsGt4YbhsO5TsN6Lh8I558WXBfk7KrkiiqKOycxF?=
 =?us-ascii?Q?7bpZN1H2gPRmGiDWcALwX6gZNiiPNoMvgTMuLOV9zJhOqmCOJLo/cWMq7k9D?=
 =?us-ascii?Q?EaX0uenitxgvcKe6tlNLcQvlSUa5y54rjWcF8x+Y2vUmPkujS4Q76zE+wtBi?=
 =?us-ascii?Q?4N1z69gT9Wrsvbiu5xPiJoUfhmTCmLLTp3SUZJ9nGIum1LeTRFnQ+Ed7mofg?=
 =?us-ascii?Q?bhHEO/Nk65SmJeof0aMsfuq6K1g/wu0azjkuqdgJfvRCeQ8QQifcV9jTSdYt?=
 =?us-ascii?Q?kw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b6498cf5-60a8-4e6f-9ad1-08db096f2972
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2023 00:55:24.6328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bpis2DkIpTwLQ5z6KrNi8evuXD/Q2NeHLaVb3T73tdczW4uRdVGtyhp4OJxap3vsRsP9ARXP4HdzO1qQEm0jqLV+MZMHZsTRfse7vaLF2Xs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7151
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> CXL rev3.0 spec 8.1.3
> 
> RCDs may not have HDM register blocks. Create fake decoders based on CXL
> PCIe DVSEC registers. The DVSEC Range Registers provide the memory range
> for these decoder structs. For the RCD, there can be up to 2 decoders
> depending on the DVSEC Capability register HDM_count.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> v3:
> - Drop unrelated bits from patch. (Jonathan)
> ---
>  drivers/cxl/core/hdm.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 86fe1be2e961..cbec955db4c9 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -748,6 +748,13 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  	if (is_endpoint_decoder(&cxld->dev))
>  		cxled = to_cxl_endpoint_decoder(&cxld->dev);
>  
> +	if (!hdm) {
> +		if (!cxled)

I think this wants a dev_dbg() for calling out a failure to setup
hdm_decoder registers for a non-endpoint port. Other than that this
looks good.
