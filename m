Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ACB5FA373E
	for <linux-cxl@archiver.kernel.org>; Tue, 25 Oct 2022 18:47:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbiJYSrV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 Oct 2022 14:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbiJYSrC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 Oct 2022 14:47:02 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCFD1162DE
        for <linux-cxl@vger.kernel.org>; Tue, 25 Oct 2022 11:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666723612; x=1698259612;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hqdLtfFvY5iYDvdbVQujFRBBNpI75Ev9WPfAHm/ARkk=;
  b=kMbJDAKjK8HFdZJOioATN2GloqUYUd6h+JRvn0V7pZDthhlPrPYNXx2k
   Z5nRYQSjY4jZ3kcCdA9UXgtZ+lGqP9dwcSX59RqLrhNMfJbfqjsSeGiJ0
   QH9jXGLrsOTKDlmGyVh8PBDn+1hw1Q4WtrCe04kJaYCSjwP2R5xmRF+Yb
   LwVA2jMqMPPIOOR1YV8RQ2srVukL/pc4d1jXZZawTKZKnCWTFCqDaj86g
   9vtBs9JRW7A2aCLlt9dHj0PESdq5aNnzwVgXDrRyKRi/F0Xo4blw5rk3p
   hk44XQSUiQdIReMmpy8LLSZAzJopLPInPP+Xn2jTvde/7qfhy9IY6OmFW
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="371975088"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="371975088"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 11:46:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="757028749"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="757028749"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga004.jf.intel.com with ESMTP; 25 Oct 2022 11:46:51 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 11:46:51 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 25 Oct 2022 11:46:51 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 25 Oct 2022 11:46:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iqqwqPBdR/xQFZjwlQIGbK4anSEkdR+//jAPXnlPm5uRGTTEl9DF3qneFSqENPfAsd5OUlJ8zYAeaUqy4rAYhgY/u03bNHXT4aVcS/b4Zcx1oU2T0pwB+yfQsNG74LAp175To8+DzKLSl2tDREkyA7CAhMN411bVcWLmM1+k6QUOJ/u+bf7g6l1Yjy1ZP1SayDTDSZbn4La81jc1W4gppiI+dnX/TWmswAkUmT1ORxwrBlKMnOGpihsR4TxXF76fyVZi4zCV5Z35PKSBEVlvnJmeY5am4aFLWOsCeyawP0gO7kvgm3i1H1YLyIlyUOeJV2agKUmS8hl/EWVwrJnwpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z17/I+/TqzugX3EmsmYvoBRbXRm4U0pmj85OQU+Zta0=;
 b=Z6yygbroXbr1/fXyQfBqSkQj2uM0yqX9tyefw3DswO/Gk9k5Ea+ka0WFoaNBBLCbx5BK0f+AwoffD0wi1+i6mDITfJS2mrYA7lofyXxMMWmGbAjBOXkADu7yRWxrp7yM3BQNDzLU/ndxsx770UBTGCqO2uP9aLDrcJvX0uazHwtnOf5RRBNfh0HpgwLrhjlZEGa7B/JCTb1mhmB1iL97QLaYlK6wPA09UPqHCVSIu/7+57jMEsMO/ivnFUeeLQO+MMeGXYBILzNbzRwSrpluNRuNAoiImJ8idtha73co6GB87KrKM4GqhQGDqB0tT4gHXxhoy7nsZ1B1/BW16S/o/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by LV2PR11MB5999.namprd11.prod.outlook.com
 (2603:10b6:408:17d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Tue, 25 Oct
 2022 18:46:48 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5746.023; Tue, 25 Oct
 2022 18:46:48 +0000
Date:   Tue, 25 Oct 2022 11:46:46 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     <linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>
Subject: Re: [PATCH v3] cxl: check decoder count for end device
Message-ID: <63582f166a651_4da329441@dwillia2-xfh.jf.intel.com.notmuch>
References: <166662616015.232090.4970569004666131514.stgit@djiang5-desk3.ch.intel.com>
 <20221025120842.00003c29@huawei.com>
 <63581f1c896be_4da329499@dwillia2-xfh.jf.intel.com.notmuch>
 <26e06276-cc96-3485-a8ef-cd0f91a16e1f@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <26e06276-cc96-3485-a8ef-cd0f91a16e1f@intel.com>
X-ClientProxiedBy: BYAPR07CA0076.namprd07.prod.outlook.com
 (2603:10b6:a03:12b::17) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|LV2PR11MB5999:EE_
X-MS-Office365-Filtering-Correlation-Id: 89687489-227c-45be-a797-08dab6b945c2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gN33DDFmbrxW1mmvMg9l3omBhGpEQt4fLk4AfI7YslLzvXwoRNq97l4iQkdoJ2wZNJ3ydPvOsr+WbfLqY5LXGbz49wXWqhtVAsYuw2uhzCiCqkcBerJ3YIed5AMmLjt2F5jieZBvRTJEMtLgFKg1v+4yQ5WuydXZ68kCBQ8s1s5P9Z/WkW0TtR0Cjckb3Cr5V8lWvctgdcUQU2dayhZY5VR9YY7D29EhwbuI2HBjcYk9AMkZB9rzDxl4uMWbgGVg7KfXJnmpBDFR6OsLVLy+Ge+oqax34i8OzkH+sHnpLXLqcs05Nl1zdxnTkJbbh9iB93CuK12uta5nYjiUueUfj1wGnu4iiXuS+y8oI2RL80gGwAuiI+rVHq46GYejXQkM/69i5Hw89qa5IabsFl9aTOTFH0DApbwC0YrCUDwfu8Yrwzg0kAIFyRtVFJTIOfAlWjWSSxd0u/qeNwd5v8y9oQkjF4zzIrcFtpAg1Uwjf09dZNr2AUVgjsW8DWWaDa4nRyrcqlIHvTOByzJLvhCKOPfuAK2721Iiev53MCJUr5hq+Gb1+fxoyjqJYOFYRnijHQaAwqHjpsZYgm5dmGYwCf+RhEVd3GCFThgfOg6goU5Weq5pkMNvTTKVD/HMAXb05qKm8YpF+XY5Fe1RH2JHHho5TLWe2oqCsDpWmXtXKZtG3I4jmCUKQ6zMqXyPYoBGl2j2Iu41oUpKaK3WBrCLAg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(366004)(396003)(39860400002)(376002)(136003)(451199015)(5660300002)(186003)(83380400001)(86362001)(82960400001)(2906002)(8936002)(41300700001)(26005)(6506007)(107886003)(316002)(53546011)(6512007)(9686003)(66946007)(66476007)(66556008)(6486002)(8676002)(478600001)(38100700002)(4326008)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1ByvyNGQJhegSrXMr4N84Pe88IquZdbuVR8kKqe9BUamlTeElpjmQp2IkGNI?=
 =?us-ascii?Q?y6cqpjGJQh69pJO2ixc4tU6/VoMVoIGjxhbZ9yN7KMvkiLfiBKcZT7+CN5ri?=
 =?us-ascii?Q?i1ZG7LQ2Lmz1G8MP/UBEVfrPXgX6mu1J95cSq5paHdhwheV7FkdySB1gmeYS?=
 =?us-ascii?Q?L9ap0pCuAfGH3ONdPa4gwvLjr27zupRrUkoF3jdimphz+9o3LmXqy+vB2EAK?=
 =?us-ascii?Q?dOLR7wvGwCd2HhDDIvMmC8QyGfopJtB52AR1Va4fE9C+7x+iF+QI24yKpS3R?=
 =?us-ascii?Q?1pLPYwkmJ1n2QKC/57aKUZwQclwXunEYkfH/Xr6L/hXB8TiBj4YYKKuCwzDY?=
 =?us-ascii?Q?UgTgKSMUZyHRLwblRwsBqGcEiD99XFXK0qwhC7kz/10I4vEMl9DaV8eJM4Dn?=
 =?us-ascii?Q?ZdCx5Zp4aluoAZNo43nIhh/JIhxg4UiqkHI1AXl1SpiIQdB6NJwT4XeKrT0j?=
 =?us-ascii?Q?w/2JRlBdltZFoBzcgyH+Nw+QUtQmG5eVO6UzB1WBR1E/NT+W6CXKn/ARIAag?=
 =?us-ascii?Q?xOHELWq9FcZttrfOCH/ENbIkt8AUxUbSbXcY+fvtlSf7CEyZYD702hWJW6tj?=
 =?us-ascii?Q?6iBZRZ0GCl9eACTFsE4KKjsA2JjLH5/vVd98UNDcVucI1GLipKkC+/e09p/r?=
 =?us-ascii?Q?XxKbTbMr366tcDsZZJrXLuS0oX4ZjB30UOPZaYZFbX8B9lEidHUsWPSz0EMR?=
 =?us-ascii?Q?k86lX+bP0ii4DPj2dnbAJEloLjdSTvaoITbpiTn9UyBdRaAEaEF0znfS2kQc?=
 =?us-ascii?Q?OELx/1uDdzdiqkxJIHp/qXXZsAwkFC0kklRTdtpDDyvrx/9VwUE/DWkbAv8S?=
 =?us-ascii?Q?2kimBmgVhyweLIURu2UnXvmakCPSvEDqveV+nJEFp7GfAy0smiy8+oGKnsYp?=
 =?us-ascii?Q?hRa0lW206G2RkaDom8Z18UgBLladEJn8klIrxcs8hLoPu4IWVWlJJquc528W?=
 =?us-ascii?Q?gbdpx0UVYNvPPcemcYK6rUgsIH599wW+OOp7EsTwUEYFQvZKBX0THfFowRFB?=
 =?us-ascii?Q?hrindtUBls0HcADM7K8vW6BVAOy09gbGa7fRFfb+MjWXaIr7Y++bW4am5/6W?=
 =?us-ascii?Q?7YeUo7ORuIk2YZcKVGCiAs4Pepf51Mnn/+SVRr4TCrGPKBejJcuCyOhmj270?=
 =?us-ascii?Q?mtRBWH1+WvaJJjvg5Zx0SL017DKy+FRXpqakALWEarwXxOY2Wc5mZ71bvV8k?=
 =?us-ascii?Q?Zv1ZtAeVciidt6oow4u3vEFksCPHOrzEvRnJAcHeerzMSbVPKGUpSg+xFvoB?=
 =?us-ascii?Q?2zd7P0nBDHp0NOc4mgu5RTjwJw0V8TqygCG5vJI6dE8Ec5+b8xx8mYorgj2B?=
 =?us-ascii?Q?pvMnyJK+1cAtOrMwazgCEX2jZ58q2HbnMQ8MholVm3uvXZhevRXiXhUxmos0?=
 =?us-ascii?Q?BOARjArpsf5BVNh8j0AvEojVn7o19BvRTykg0GKwiZqcJELKhaOpTUxcNbsN?=
 =?us-ascii?Q?VgdWu+dTxZx4/M5/jYK8DfMc2JCs5Vk1eXD+tQg7Z+OZgwr5C/Evu2E1sizI?=
 =?us-ascii?Q?9J9v3oXNNSDGvrFaYT7voXeSjRbd7d+vin6Hb7FwdUQYF66IaH6N37OGwm1w?=
 =?us-ascii?Q?IdzE/baIRSwuRl9n8d/hw0o/WpYYVdEpaG58YqRgE1DfzTYixGWjMWV+QA2z?=
 =?us-ascii?Q?AA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 89687489-227c-45be-a797-08dab6b945c2
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 18:46:48.4123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IAlQcqS+HP9m6W3z8CCnf9O6XIIaWYHQm7EzZISjgu4j/F5j9bn7LZgjIeGCSNExNM0xlI78+rGtP/XqBTkLybECHTfF2RMXdIbYERAh+VU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5999
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> 
> On 10/25/2022 10:38 AM, Dan Williams wrote:
> > Jonathan Cameron wrote:
> >> On Mon, 24 Oct 2022 08:43:30 -0700
> >> Dave Jiang <dave.jiang@intel.com> wrote:
> >>
> >>> CXL spec rev3.0 8.2.4.19.1 added definition for up to 32 decoders. It also
> >>> indicates that for devices, only 10 decoders should be advertised. Add
> >>> check on number of decoders greater than 10 for devices and emit warning.
> >>>
> >>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> >> I wonder... Should warning say CXL r3.0 spec violation?
> >>
> >> Seems possible this might grow in future versions and so it
> >> might be nice to give a hint that it 'might' be valid in a higher spec version?
> >>
> >> I don't care strongly either way though.
> >>
> >> FWIW
> >> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >>
> >>> ---
> >>>
> >>> v3:
> >>> - Fix commit header and output message to reflect code change from v2.
> >>>
> >>> v2:
> >>> - Remove decoder count reassignment from violation (Dan)
> >>>
> >>>   drivers/cxl/core/hdm.c |   10 ++++++++++
> >>>   1 file changed, 10 insertions(+)
> >>>
> >>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> >>> index d1d2caea5c62..c3b756f93261 100644
> >>> --- a/drivers/cxl/core/hdm.c
> >>> +++ b/drivers/cxl/core/hdm.c
> >>> @@ -71,9 +71,19 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_add_passthrough_decoder, CXL);
> >>>   static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
> >>>   {
> >>>   	u32 hdm_cap;
> >>> +	struct device *dev = &cxlhdm->port->dev;
> >>>   
> >>>   	hdm_cap = readl(cxlhdm->regs.hdm_decoder + CXL_HDM_DECODER_CAP_OFFSET);
> >>>   	cxlhdm->decoder_count = cxl_hdm_decoder_count(hdm_cap);
> >>> +	/*
> >>> +	 * CXL spec rev3.0 8.2.4.19.1 indicates CXL devices shall not advertise
> >>> +	 * more than 10 decoders. Switches and Host Bridges may advertise up to
> >>> +	 * 32 decoders. Set the decoders to 10 for devices if more than 10 are
> >>> +	 * found.
> > Stale comment, the "Set the decoders to 10" is no longer done.
> >
> >>> +	 */
> >>> +	if (is_cxl_endpoint(cxlhdm->port) && cxlhdm->decoder_count > 10)
> >>> +		dev_warn(dev, "Endpoint decoder count (%d) > 10, spec violation!\n",
> >>> +			 cxlhdm->decoder_count);
> > This is still too scary for how the kernel is going to handle it. I
> > would expect:
> >
> > dev_dbg(dev, "Endpoint decoder count %d, expected max 10\n")
> >
> > ...what downside are you seeing that's prompting this patch? Sometimes
> > Linux might want to constrain what hardware can do to avoid code
> > maintenance burden, but I do not see that harm here. Otherwise, there
> > are users that treat any log message above KERN_NOTICE priority as a
> > sign of a broken system. Is a platform with an endpoint with 16 decoders
> > broken? Also, if we do this bounds check for endpoints why are we not
> > doing it for bridges for the > 32 case?
> 
> This is purely the spec changed for 3.0. Should I add check for bridges 
> as well and add debug emit for both or just drop it entirely?

I see your point about the decoders > 32 case since those are not even
defined in the 3.0 specification, however if the driver had been strict
about the 2.0 decoder count limits then 3.0 devices would start tripping
a dev_warn() unnecessarily. So I am skeptical of being noisy about spec
compliance in places that have no material affect on the behavior of the
driver. If it turned out that the decoders above 10 were broken we could
fix that with a quirk, but those decoders are otherwise avoidable via
region creation policy.

So I think just drop this, it does not add anything and ends up asking
more questions than it answers.
