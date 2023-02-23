Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AF0EC61DA4
	for <linux-cxl@archiver.kernel.org>; Thu, 23 Feb 2023 05:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjBWFGP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 23 Feb 2023 00:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjBWFGN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 23 Feb 2023 00:06:13 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E8B630E9D
        for <linux-cxl@vger.kernel.org>; Wed, 22 Feb 2023 21:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677128772; x=1708664772;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=EK8JCtlb+5xs22yoU0+ipoqG99rlhEUSKjtZqa64PR8=;
  b=LW5LNuFYyq1UrRxZfUZAMTycOFCaxIuA7VivLMF1q4+0ipK1lrFQ60og
   N1/hnpPJG9wbDuN6Cx86uvjpO8abvIu6jxXX3BOPNeHYKEKSyDLfBRzJj
   S3p4R+QaFeWx9p7fgbry1GaSYCcvdWbIFk6tSI9NEtktGNHau+yNK0/20
   DGYVLJo9Vtqztkdqn6LuSoMRHvXZ9kHo7QmAFSV1WZYsylTjDgIDLhJJn
   SRfj7Auf5LmQ6/iE82utcsuOY/hrrQ92HboCAk/4tjlcXr8Tm2UCxl9bR
   YNIwClBdXPIzWX/MKy9USM8MBxRlIN1hu7JmbN21JLb2vFjTvA1zKHBbi
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="321262151"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="321262151"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 21:05:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="674379723"
X-IronPort-AV: E=Sophos;i="5.97,320,1669104000"; 
   d="scan'208";a="674379723"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga007.fm.intel.com with ESMTP; 22 Feb 2023 21:05:57 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 22 Feb 2023 21:05:57 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 22 Feb 2023 21:05:57 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 22 Feb 2023 21:05:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLc9B+81e7hvIcvEJrVOyZc26JZtTcq9yYOKGxF1cTIYgx/5sQxdaw+IitmxySYtzt4qyLDmS1PTX9trGvhLcL48xBrKB1X6Uj68dLqDrhk5Ggm21NIcGzpLJ2TVA9+mQYtl/GrDa1TxiJmJDkCVAm52qM2Gt4CTa1mTaGewzVrBJlwlFJtrlDSFGkCB8kkS+gk+lIfasuWCQBSsyDIniWYPZGc3DXZUu2m0kufpbevOOIxiWCAlxmDUN+hit+Mvnynb9jFUzxMNf6mSz5Arl1GZNJFeJHSeFB4ggixqaVnm0YoRAxkuOfZuWqY2j+xWUL6JqXap2eZalKwcMfOrjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gd9X9ywVAhUqH/vQdGjInNhhzg5sERW2FSZ8eMrDwcs=;
 b=O1GHPiTnqppk88lESOrgX6hqyJbjF/aaHCghCStm/fV2B4NemlzDdr5cCImQTiRmGPu/0DzhNgsLdr5EiLABhLnVEkWMhSFEU6WKY8JI4xTj6P3YJ7YSNfP+B/k6ZRO7oa2wBfBm1H0oLu9teEys5MR4a1qgBzAOCC3Fifr1GSXfXdostT2gQqGbezH8ksFPrNTmK/o8JGMzq5da7QOSbNdm5OGwv/Go3d8okMg234KKCN8TzkLi5PWTCwk1IfJCv8Fdq6E1qZ/yNza3jr3cxqWVkUF4OvEiiHLyewEqkruYezMPTUEAtnFfZUBMTws0GUxAvybuXehh1TLbiTsZeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB4948.namprd11.prod.outlook.com (2603:10b6:303:9b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.21; Thu, 23 Feb
 2023 05:05:55 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%6]) with mapi id 15.20.6134.019; Thu, 23 Feb 2023
 05:05:49 +0000
Date:   Wed, 22 Feb 2023 21:05:46 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dave.jiang@intel.com>
Subject: Re: [PATCH 2/2] cxl/hdm: Skip emulation when driver manages
 mem_enable
Message-ID: <63f6f42aa6115_19f329412@dwillia2-xfh.jf.intel.com.notmuch>
References: <167703067373.185722.16579529992799939220.stgit@dwillia2-xfh.jf.intel.com>
 <167703068474.185722.664126485486344246.stgit@dwillia2-xfh.jf.intel.com>
 <20230222132221.00002b42@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230222132221.00002b42@huawei.com>
X-ClientProxiedBy: BY3PR04CA0017.namprd04.prod.outlook.com
 (2603:10b6:a03:217::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB4948:EE_
X-MS-Office365-Filtering-Correlation-Id: 3035b72d-75f2-45c5-d2f6-08db155ba0a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EB132cigbQaDYWXcQLwN2BmSdFCU1CGgDK1eWwv5RtV0kSi4RpxSpgHIrDa3WV+9wzgvAsnWQ5iO6NZZ46R1tctgnijfiBwjvnqKTfhvyLGjhQhxyrblqF0/GcY8GBNR2FJsVdp3zWH2jTpThWpvrZBhZdPXYA8DLd+EXoM7gOfa2HTZca6vhKNbVCDOfeHucRaw0sByrqdbo2185ZdUTWwEejba6dHmZ/94ZmC2fREDLL04ZFYD0yuxMAP23YSCz2XgQOSEodasu7B6CJZ46cjbiX075N9QfataJ+Gc/AR7jyWd8HOq0cpzKeQpoy+wxvpH1fuuJTKPDt9VkIMnB2vH88mPtqQOERBV96VWIeBXUc/c2yHaS6fUHfVFXpYi+UYPjrCWkxU3Ss57Z4JBHbrqvvffsjAbklmSdskFR8liSITJHupsiTWrU6RG0TJP3mXU6OVBhKoiIxqKkV99zCN++pCywcjlNU+81fO9SdWzAeeqSbAPjkq4PzidSZuX6QqEmyGs4mjHRPAAEIqwCnKgFDtlEgmWHCxGC9cZmyVd8afLmiDaIFCFZcn7DYqn4xo1XDzjM24jyScfwS6z6Y4F3Ds441KlPimhK3u/PhHsd9Aj2LEjKb8O9KdTbY7y
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(396003)(136003)(346002)(39860400002)(366004)(451199018)(86362001)(316002)(41300700001)(66556008)(66476007)(66946007)(4326008)(8676002)(6486002)(966005)(107886003)(6506007)(6666004)(6512007)(186003)(110136005)(478600001)(9686003)(26005)(82960400001)(38100700002)(5660300002)(8936002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zwpYxDWoxfuDMNhogs51SeTJnV937AL8TZBk3z8T8Kh8VP4He7wW4r2LMZIN?=
 =?us-ascii?Q?k7saqK5beC1o1nw8+KXdLyZT4PId7cbHJ7tzRBxCILEnwq0z9R46X8dpXF25?=
 =?us-ascii?Q?fF2tI4fHNtMrl/nCsGm4TUrZA88Jdzhjw6CuzMu/m3gx7axfkr0vKRJHt3uH?=
 =?us-ascii?Q?ETjI25wrwidQqpgHWNJPu5Tk633I9qGAIE0curzGhcitkk93zRZpzRkww+Ue?=
 =?us-ascii?Q?46jxDJ0oq10tNcNJgcNtv4UpCQusNf302mBKToMhG+KD/WmEO3IOQyYAlNma?=
 =?us-ascii?Q?69BuqsiByPewqS2YmyEybZqDMOAeM0XAUl2MraxjW1phOC2UtMo+9KABKmxU?=
 =?us-ascii?Q?+eA5yMEuxWsrBfnTsuavaX1yNGM8Yj/5vGmq1ZX04BByu+5FNRFzUlOi+s1+?=
 =?us-ascii?Q?5O6fQI9Y2Krur5mD7jSvfAdptPQ7Fh8Xn/77n3SbJimkhUIJrSw7lQpwuy2d?=
 =?us-ascii?Q?NlUC/0iisCyX5N6EPzK4Cz/j0JydjGIdvCs3gTi8drUn4/gMeDn1H9tYcele?=
 =?us-ascii?Q?aWrzhY4/N70yLNkgDZydwulxzi+uYWilhhG+dYJzXPbtKBkr8QrpV7czGSW4?=
 =?us-ascii?Q?Y57oKI+jZLEspVnINm+JheDGo/fS+TNzUllj+s8ThsZ1PXHWdDWc0pY9u3hc?=
 =?us-ascii?Q?vrR9h06uyKWFPlqm5HayQ9AhPdWA0RIrrbxkzUxAR+V2aoQDn3/5TqkuHdhg?=
 =?us-ascii?Q?NuQEebu+9suvMDGeBRSrVurwNHftCGU3JVTM7MZ0VFa+r7EyzxhizrkoUl0f?=
 =?us-ascii?Q?M6xwChuhB1ikggUWBsQYH6Nbi6K3CqPN+i3KIbilGU4XwD7dAlDJ2fIrIpM5?=
 =?us-ascii?Q?NZ9supDfYGM4XgxUAwrSwKTgCWoZJc5P86RWXzwpHbI0VdxNGZ5dfzrtvrHI?=
 =?us-ascii?Q?7IelALyVzbkLTklo53o/ii/a3PJhRMQpuYNWACoNV4oEfvCb5/tikXEAR98c?=
 =?us-ascii?Q?MmMNq2pZPaaxvb1JU0IkXYGEcbkR/AQculMN3wpv4Z46St+6ajUeEvmuGNKQ?=
 =?us-ascii?Q?u2dJwqTkbYb6qGHIBQwEsfaaWBZ6gwAbYfoeinwBKGhBRlPoqqujFlHKpr9P?=
 =?us-ascii?Q?eLQf86TUU05BIXcHSlaiVKcJPXxeHOhgJFF7yP7CWoctMEAbaxuf47iHqv7s?=
 =?us-ascii?Q?bM8qFk1wELk+D6GZ97wXPxTnD7xTr8/BTkDusHb3FUdsiCHO32qksU9m/DGg?=
 =?us-ascii?Q?vInRZbM1bM6jcmv8KeOhp+RkRC2S36iU8zDwwzShvKUwlJakxMox+hff70r4?=
 =?us-ascii?Q?uSITODrAPbKFcKdsM8MFm1KMFznIw2N2tB2Zq7BQa55FmljUdAQqYS7yF1E3?=
 =?us-ascii?Q?KyX3dDUVSsflJNuc8aC81a27IVAGwBpy8UnNndMxNMFjd08gWKClJHNG+f6Y?=
 =?us-ascii?Q?Cx9odhOH0/pxfR6iqsm4M8evI0QYn0Rd8/DoJwz6S6cHAM78X3DkNxuehT/J?=
 =?us-ascii?Q?me9P/Ki2t/4QbqC68/XQry04wnojZB7Mh8yjBpS4OmXce2OSX35Xw5I5Wjnx?=
 =?us-ascii?Q?fsEo784uN1n+WpNsjUk4QCSyw6M30le2NQLMXu1/ZLXLurez3MwuW3YI63LM?=
 =?us-ascii?Q?sbJtpaq+KcEk6QX1c4/I45BOGxbIGLG6HCUj2C+YAZ6t8/WdlVos3Sc/1mdn?=
 =?us-ascii?Q?rA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3035b72d-75f2-45c5-d2f6-08db155ba0a7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2023 05:05:48.6492
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YNqeof8jf/SGbV47vB+U6NKXS1Z3OiBIWyPbzOerYFKhG9NoOcOu6vT9dbANb+RM4I8+8CYL7I0slmeoOaMIBh3bGzoe3pfKKRNJBc/qnWY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4948
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> On Tue, 21 Feb 2023 17:51:24 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > If the driver is allowed to enable memory operation itself then it can
> > also turn on HDM decoder support at will.
> > 
> > With this the second call to cxl_setup_hdm_decoder_from_dvsec(), when
> > an HDM decoder is not committed, is not needed.
> > 
> > Fixes: b777e9bec960 ("cxl/hdm: Emulate HDM decoder from DVSEC range registers")
> > Link: http://lore.kernel.org/r/20230220113657.000042e1@huawei.com
> > Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> For both
> Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> I could have sworn that mem_enabled was set when I was debugging this before
> (hence the odd dance in my proposal)
> 
> Meh, doesn't seem to be now so I clearly did something wrong!
> 
> Trivial comment below.
> 
> I still need to add more tests cases, but this solves the one that
> caused the original report.

Good to hear.

> 
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index d853a0238ad7..dd4b7a729419 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -695,13 +695,15 @@ int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
> >  
> >  /**
> >   * struct cxl_endpoint_dvsec_info - Cached DVSEC info
> > - * @mem_enabled: cached value of mem_enabled in the DVSEC, PCIE_DEVICE
> > + * @mem_enabled: cached value of mem_enabled in the DVSEC at init time
> 
> I guess could rename this to make the meaning more obvious, but would make for
> a messier fix.

Yeah, maybe a rename as a follow-on, but for now keep the fix smaller
seems prudent.
