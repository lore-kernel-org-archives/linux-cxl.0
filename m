Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A686EEB64DD
	for <linux-cxl@archiver.kernel.org>; Fri, 23 Jun 2023 18:02:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232334AbjFWSC2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 23 Jun 2023 14:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjFWSC1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 23 Jun 2023 14:02:27 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2F22133
        for <linux-cxl@vger.kernel.org>; Fri, 23 Jun 2023 11:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687543346; x=1719079346;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=40IsD2FTVF3IzuhcPIbFJzya1VhKERtnADpohpxN+GQ=;
  b=fBB++cLQlOySO1yc7wINBGqIl6syUDCYtrUSaD/2hjX3L+c2HsDfwoet
   95U5k5ORNdRuXTW+WQmEyS0a5kBBiooNEwNSEEOF+Vxb86uCxgVHN/WmC
   zBZnx6DDtZVYnHjrEs8FfrUJ27+EvBEkfHwXH3jljrdCYSW7TLYlfi9+X
   41RWbfPjQ64RR2b5hB9B5VP4+Z83+jrlcnjgy6O1CNO6y+2vzuqtAvIWK
   CPQZjI+MkWfz7mCE/2ez9lhRvdoLNfHvBMxAhfH9D3i69hijhM9tqFEbK
   Lmjo23j7makBWzYkE4HYDWQQe5Kkh4yd1otMz1q7g1jJVmkuJaew+dICX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="360860154"
X-IronPort-AV: E=Sophos;i="6.01,152,1684825200"; 
   d="scan'208";a="360860154"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 11:02:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="709528776"
X-IronPort-AV: E=Sophos;i="6.01,152,1684825200"; 
   d="scan'208";a="709528776"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga007.jf.intel.com with ESMTP; 23 Jun 2023 11:02:25 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 23 Jun 2023 11:02:24 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 23 Jun 2023 11:02:24 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 23 Jun 2023 11:02:24 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 23 Jun 2023 11:02:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=atGa9oED1MY598SzOg0ugU//dlqMulgtz6UznEjri6yKNpvt0aV3gLZBvipbABymmOdQPeNcKkqOCXiXOA6/NpiARLpWRYOCqP/JN9ZBVV8fK/+72BfTKDvBWscUj8h/G3hGLSmT+bcKzJcbyLZMvF2uGsDoZGlL5eMm2qZ+YywkKhyYUNJudK5f01AMmGc/H0lPT/n7ZM1pCeEMDx6Ifq+XPtFF+OKrHmHb/aGHsVHHATaycmgXiVde3lvaJTY1954kc03wYlV9YvtwOBsxj42ZAvo5oCaqA2QvCNTB54QwtchGrWIm+RaGTpbisK4XbFR0uDYdDk6O5UlNfsghDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Tfmk2KcDLbT9VBbi3oPWo+IovFhyTL5dbwmLEYbvBo=;
 b=TTR0TT9DFowqChh3QfQ0oq4ZqJop4Gt0ThQz6zxSIWGUna1zFS/QpR4mvypsfG2FKky7Nig+6C9iRmoqKywgZCtEM2mw3DZn26S+arSWufPIXEQeNn8SaRwlmpyuChM5m3UU3ytlAIkVa8H+OEG57aHYkF1DmdkwT8puIrruP2Yg2sqaXuRUh1sM/j8yKMzkfIBfy9t2UG55QR1Pb1BoNTTrZnTxj4mRdJ2UkKcIcVOZDuUqoEHWdaa3ZVZRYZD+3ybkL71NGLtJgrYSPMn9mdxqC/x18necUm7myPq0rvb2RjObQtDYEi0hZK0WtLv9o3U0qQHYLXPaf09CXXzHxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by BL1PR11MB5496.namprd11.prod.outlook.com (2603:10b6:208:314::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 23 Jun
 2023 18:02:08 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5%7]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 18:02:08 +0000
Date:   Fri, 23 Jun 2023 11:02:02 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Fan Ni <nifan@outlook.com>, <ira.weiny@intel.com>
CC:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <a.manzanares@samsung.com>,
        <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>,
        <nifan@outlook.com>
Subject: Re: [PATCH 2/5] cxl/region: Add dynamic capacity cxl region support.
Message-ID: <6495de19f3535_4ccfa294e3@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
 <20230604-dcd-type2-upstream-v1-2-71b6341bae54@intel.com>
 <SG2PR06MB3397C7844B305A9C1C0C2F0AB25DA@SG2PR06MB3397.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <SG2PR06MB3397C7844B305A9C1C0C2F0AB25DA@SG2PR06MB3397.apcprd06.prod.outlook.com>
X-ClientProxiedBy: BYAPR02CA0050.namprd02.prod.outlook.com
 (2603:10b6:a03:54::27) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|BL1PR11MB5496:EE_
X-MS-Office365-Filtering-Correlation-Id: 94a8ae7b-5b9c-436a-5554-08db7413f5d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UCgpaFrYxNzIahfKHqO40tHFe0Y13LK9VhYN3W4cloPttwI8b9Dt2LucMj7uSRP5g+PYGOihj6UrBgNQ/ueQwuvizcY1BLczhSWu0u9dVuPfENpEmo3Qry9k9o0GqKLma3LrtpJPZZeDsJPF6sVPsT8Rzk5jbokwxsaWvu34LB6fMYTMfr3FnEb78/UQHN/5zm1ccRf8KltJ/B36ADc2EJh/1ltiq97fIjKKKQeLXm7Sd0TVudlyuh2pEbBEBn3UGpmkxAGQbRH3Az+KP6bmMoz/CdDBIIGYtzoFiOfj5dKFvOgWRXqLB9sFDGa0ElxtwqJBdPMOiQt+6fEWLLrV2Un48Fv4l1BXphLpv16AxZmQWUXl55E0ao/WHiK8g4T3a6JHhgUc96VzfMFO3e3UkjZPZoDZg3VN1bK9BgiJN10q1yujLzB5z/GSkSbhtJD0UvVM4B5v1ae37PPZ6XQ+AZBVTX/mU/jjcb86K5LjUSsK9SRV5SLBplQnWNkhJLvZZRufqceCzJhNqygD7gQK/xkn5r5iBbJnp7qkYQvUOheBWazyQI7TWOfRoyXo/1tF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(396003)(39860400002)(376002)(346002)(451199021)(5660300002)(66556008)(316002)(66476007)(2906002)(44832011)(4326008)(41300700001)(8676002)(8936002)(66946007)(54906003)(6486002)(9686003)(6506007)(26005)(186003)(6512007)(83380400001)(82960400001)(6666004)(478600001)(86362001)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sv/wXIsWs+Whnizvc4IZN9MOq0RqklzThCHFC7rIuDZzn5gtd+IAHAaHsgHB?=
 =?us-ascii?Q?3Lf2cEu/KT3XH/Z/+EmEpCH4SGrRcuMs5nuF6Zg8AtzZt/TBRcb2qd35PbyR?=
 =?us-ascii?Q?X/VHl/Ie1Yn5C4mOvMi6uJVjbtdIOt6RrWc5SSPsCjRU486t1kpKq6vlpcCG?=
 =?us-ascii?Q?5A6gbNaeU9E3C8ZgkokFvyL63fcNVjCLTu/mMcSPGq+0ttg65BsPBc6g8mNe?=
 =?us-ascii?Q?9NUn4na8dqgpxuD/rMbL5CPfzyt8GhkdKKCh4FVQktkGkFc7l2sO1L47ZkPq?=
 =?us-ascii?Q?mX0Kb8CSdg6dKBGnCXLMUgbPeDJq2zoW+zJqqu8gN9EHKL0nj4/3/HGIm3Kj?=
 =?us-ascii?Q?ESz469uweXWJx2pE79nhRtpnRoGn9W4bI95JF1ASFovoTD7JF639FPhtienS?=
 =?us-ascii?Q?tSyYkhsdNVB8hGqA6aFJ84bsZ8HhfrDRqMMYoj3Q5TwNyabc5Z6HQ2ahfRau?=
 =?us-ascii?Q?Oo/0Giu9WC1ivYB31JG5EzSou809Otru/OmiVAP6Fz3c+OQW6D+S6WxREb9P?=
 =?us-ascii?Q?OdEP0mIar4LJXT5bgoK23pzapgkzQQbxIQVm2Jq7nDJExiTtAUIDQgbjndiK?=
 =?us-ascii?Q?rjqnwhAJ8bay6b+gFjVBAMCZEvu2S5is2QF5Vht5BDmfQrFNoGs+A/U29xvD?=
 =?us-ascii?Q?TO7AT22bUEmUQif59qrqL5+qm7GYBQirHLSTXx9ckLVZUGy2DNf36p+KR4pr?=
 =?us-ascii?Q?YcioqO4nEUWWKbvtkAHGPn14oFDvuxnmX1MmXWLumwelL+4OxyYLi/LlpZJD?=
 =?us-ascii?Q?dtc37eWAppuT0Emzl9CQ0AAdxGOZbqAuPOciBhG+D47HJ9bS018fVtINZCy/?=
 =?us-ascii?Q?9mNgKH/zb4hRSEH1jqneCjCDrNaoeEWE1j+hm+6Xh96GxR1opY3x6puxaE2A?=
 =?us-ascii?Q?AB4+fkL8MDqHEsDfgU+/0OkA75+LaQE17Nsw5xeaoH9gplVDrM0gUyeN3u5i?=
 =?us-ascii?Q?qIO2Tm1PYjSkyExb3CY/jD5VuCoBmMRsH9YvSW9RwoIs9L4xDgV4DxeDOB91?=
 =?us-ascii?Q?Jhx/+ljpH6J0WlEsFwbDhG3s+pgbpF0yC6P+4PLnEyueS0x/sAGh+K/6vXxb?=
 =?us-ascii?Q?r+p+9arjeowPuodoFkFNchY66rwr5ydRcAk7d3tMOvoSjCeTKBXmrJTSYHS6?=
 =?us-ascii?Q?2ChWliGI/HXEwGot+zaQ/hg0YYXQZQatJRlKaHBUNB3KoiWTs7V1X0hxBllz?=
 =?us-ascii?Q?NL1As09L5i/XdqfwHudDjv7hf7ehqbAeRZkDfcd6yn82y9O94UXXEpFAmPxG?=
 =?us-ascii?Q?1trq3Mo1nnlr2RnhV6Co+PF5zGUT9BFInjAA/zmiTDRoHp9Nj+WW1lzroE3C?=
 =?us-ascii?Q?jtg0hPjh3fCMJ7Ui+QUmJZHIkL4Dw/Q+QXR1sA7CoG65yBzIF3lc6Y6wrjH6?=
 =?us-ascii?Q?ORFFRYq8HGxdcKoOeNAhYPorV82R/FOjEfHPTJdIm9Vh0PxZnzhfR+ELE3SK?=
 =?us-ascii?Q?EADsiVOFrt1VACfubwtMLsgPpSKPd/oPC5x5sE9r9NdzaFIhVqyCzrg/iTxd?=
 =?us-ascii?Q?1mXMu5fOs3XXcDfpVvGYe1v2kdeAxx02i5XmwNeUcPriSyxLn17hEjZ7XG8+?=
 =?us-ascii?Q?XQV93zmH14PVWvcs0S0kKv0YDBRg4WAy/D2G2/k7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 94a8ae7b-5b9c-436a-5554-08db7413f5d7
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 18:02:08.3377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KAzWJvyc0JQF+LhlU2nvZH8lxPCkipCbVre1ibli+apyK8+NWXkkp7TArcpMKFj+SqYe0xTl5i3kxB5+qXwigA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5496
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Fan Ni wrote:
> The 06/14/2023 12:16, ira.weiny@intel.com wrote:
> > From: Navneet Singh <navneet.singh@intel.com>
> > 

[snip]

> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 543c4499379e..144232c8305e 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1733,7 +1733,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
> >  	lockdep_assert_held_write(&cxl_region_rwsem);
> >  	lockdep_assert_held_read(&cxl_dpa_rwsem);
> >  
> > -	if (cxled->mode != cxlr->mode) {
> > +	if (decoder_mode_is_dc(cxlr->mode) && !decoder_mode_is_dc(cxled->mode)) {
> For mode other than dc, no check will be performed, is that what we
> want?
> 

:-/  Yes, looks like I may have screwed up the logic here thanks.  But this
code is changing because after this thread Navneet and I decided to introduce a
new cxl_region_mode enum which should clarify this check.

[snip]

> > +
> > +static ssize_t create_dc_region_store(struct device *dev,
> > +				      struct device_attribute *attr,
> > +				      const char *buf, size_t len)
> > +{
> > +	/*
> > +	 * All DC regions use decoder mode DC0 as the region does not need the
> > +	 * index information
> > +	 */
> > +	return store_dcN_region(to_cxl_root_decoder(dev), buf,
> > +				CXL_DECODER_DC0, len);
> If all DC regions use DC0, what will CXL_DECODER_DC1~7 be used for?

Before sending the patches it did not set well with me that the mode for cxl
region was not longer 1:1 with endpoint decoder mode.  I basically hacked in
the idea that DC0 decoder mode would represent DC region mode.  But this is
really hacky.  So this is why we have introduced cxl_region_mode which
represents ram, pmem, or DC in v2.  I'm still squashing in all the changes and
clean ups and should post something soon.

Ira
