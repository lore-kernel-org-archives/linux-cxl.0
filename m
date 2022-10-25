Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48D6FA373E
	for <linux-cxl@archiver.kernel.org>; Tue, 25 Oct 2022 17:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbiJYRiq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 Oct 2022 13:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbiJYRio (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 Oct 2022 13:38:44 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6679216DC03
        for <linux-cxl@vger.kernel.org>; Tue, 25 Oct 2022 10:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666719523; x=1698255523;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Cs11F9rX8JU95dKUEVSXBfdyz+WQaoQelgNDfOnenL0=;
  b=KZZ8qG/13zKbiRqMea+CyNhTg3L/Bv5ftZLjaPpWsT6MR29Aj/sxeKNP
   7nArc3U+rgNG4CAJ4XobCCo9B3fwsED+8y5d0/mXqNz+i6L+2vZ/cpjws
   97inRmyIt7MAzOSCK3OVLleW0cLjzjLfptnNSg7AFhVtJZJeeYFH6JeAR
   DAG5K68NYnN6RUm6LbQuL9Eo3HlxSnw3x3nn7lu4LgfRI3kKp5meOEPY6
   hd/B7coekP2HAirZ3oQiCJ1E45sYpUTgswEhSGN0oEe07T/U0j4KAYwPr
   YevEOzyOcfBrnrFHneWlwfI2DjmHIMCQO8vOk561cQN+GGeM4enuLYDQX
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="306475532"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="306475532"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 10:38:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="664994959"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="664994959"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP; 25 Oct 2022 10:38:42 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 25 Oct 2022 10:38:42 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 25 Oct 2022 10:38:42 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.42) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 25 Oct 2022 10:38:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hLVrCQNeMvs3tdXhcc2WQh0WxfOlPcC/gW38T9iFRLH/i1QITUlzFe8fqJRpqLbP5HghKahOcQTP/AxQ1nIJgoiVcuNKDqvQcxrUMBm1fBVgoFotO0yI+U7rP/5k0BDnNScLFEYI+iuOYtCipLwRCqAGg7dl2lQEvfeZMZ2zYUl1xl3t+CQPNuxTCftgYKkwG9pxkaFx8dwuNaz31xBzL/LHVhrmyEPLzJ7sPr5aWxKlTZpr7/JJW+BCSfLuSN0UR4lvwsYvsdTcLmoDkBz7I5IrCxFLpxRGyrSYLLH3bLGKODjBLfFCx1ICsRZYMUburj43xImu2K8oddF5OdR7Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7A8eaRA/4Q/fngai8/Pdbtzmi9kxNyyF6/b192NV71I=;
 b=NEQ71AEAh8C+qyVXTfwVTFIypYZbvCPv8WwDdVqqYstmbuB5AGx+Ajdw1S7gWd+ET2tTNu+Tu3u4kcYDYub/HQCbJp7U1yw9HZSYtX+jCEPatacpyMhfR7/LL1e7EhlJyCL2Ia0uC3hqSpDPd/nyTE0JnLNq5QRpMAMctyKUqWStfUqCLJPFYcjpAfrVOCjpmolDRP36tU21kSXquXSxiiORvKCGmAKNeoB8/Fv1P0p0d4IU32aMPLtPi/i7DRnsVvncanBk/N+tsh3/n6mdC/EeDyqB16GXXWDZa0AJReX8CU3ZExhDc2X8NlMLH4dEwqw54+32qdghq4E64mXdHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by CO1PR11MB5137.namprd11.prod.outlook.com
 (2603:10b6:303:92::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.21; Tue, 25 Oct
 2022 17:38:39 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::7d5a:684d:99f7:4e83%12]) with mapi id 15.20.5746.023; Tue, 25 Oct
 2022 17:38:38 +0000
Date:   Tue, 25 Oct 2022 10:38:36 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH v3] cxl: check decoder count for end device
Message-ID: <63581f1c896be_4da329499@dwillia2-xfh.jf.intel.com.notmuch>
References: <166662616015.232090.4970569004666131514.stgit@djiang5-desk3.ch.intel.com>
 <20221025120842.00003c29@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221025120842.00003c29@huawei.com>
X-ClientProxiedBy: BYAPR08CA0050.namprd08.prod.outlook.com
 (2603:10b6:a03:117::27) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|CO1PR11MB5137:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e9a1565-87c3-4e42-72bb-08dab6afc032
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RM26BD7ieHpkpmKKhkJBBex70iHNacaxDpDFWQemLLuJXv+hhjhvOLnZ4COr5r6AEJxqqmq8/hIgKbsz3BF8PYhqQpN0lmMaDd3X6svXPy80y9BaM8eJgHZN/hzvvrTqzwMZ5DItF4C1OIxz9blORJ0lACUjsy9diAchAONgJkBFtjbmo3euCrAmSyOv9d7ppg32snt08J9zZDhuyPVz8IeoDplxGhtB/ctPOZq9vUOA9/Y1Xg+iegpwmpHt0X04v/acHVnLNayHEcBOpGI0UlHiQB0bIjqON1ihJ8exUdFVBAIG4U6i1LmEZM2adz6cyjR+9VB/zQ6mZ1TIXhT7sNTHZCh8q4/n13EqRC271J1v7kBQVh8Orpv6zXan3S5RILJOhNsZENY9Xq1ECZkaW/RRCc+65t16sQAUwZh7e9yZvqCQ1YucN1Nj9Ha/hyNAFhWEgFqXIblvtjBcz0Ls0pWPoWeHixKuQ31ov9NYIJuny44tlkr5HTe/tJXevEbaRHkJcYKpOXOuqChxusTvcd+/mScBEnnk67cGMgcaV7K62Kk9pyO4EJyXjI+KsRjbIO1U6NEIkTrvM7TMr8xVLNPbtcElngalv+UFf08YmNdJdRXhC3vOBqTo0Gi7yAZu3N8qWd2fjA0AfQjHSOYL/DvxbhqSRjG5pUfUGpvYM6FFZ5wvNORmfgYwWSw6kRq10IG8UmyreJh+0kdqeg107w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(346002)(396003)(136003)(366004)(39860400002)(451199015)(186003)(107886003)(38100700002)(6512007)(26005)(9686003)(82960400001)(6506007)(41300700001)(86362001)(316002)(2906002)(5660300002)(8936002)(478600001)(4326008)(6486002)(83380400001)(6636002)(8676002)(66946007)(110136005)(66476007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iZvsmELXWABxeJK43zgmrI0Q33fklzskywpMlngFHwUej7trf0IqHuub405K?=
 =?us-ascii?Q?k5si6P0IDiuAeFU3jo01RdCMZXyAWMSxmyCqzFYfMV4ca78vzyKjlcXF9ZQB?=
 =?us-ascii?Q?faiPfz36uhxoCG/wrF0eZggDvpE/e6P+jokhVD9o//sPwUh07h+v9zje8SUH?=
 =?us-ascii?Q?f39kNBce00rxxwfyoEBB/AC3aAP5wD3rBw/jI+yR5Vu4yxsWNq5nhPcHZ22P?=
 =?us-ascii?Q?NVLQq9Y/+8D8vCfO9ljxPOWXGarI44tQjU9c8UwmajRZ4IcadB/6BdvLPQy0?=
 =?us-ascii?Q?TdSYxJ8RjPlNO0PxacCHLSDkDDWtuiP6h+1dRi8snajANUKKas7/T+Zy26yl?=
 =?us-ascii?Q?CYrks5mhphup6whOjFeSP9MrJLdbYhiVhTCcGZO0YdnTrn25weFBmn4vZACj?=
 =?us-ascii?Q?57pJ5W2u3Teo5Z0uxqiyK65qZERbwGd7SEjwvdep1CZZUL7lJpP8oe8cm4Ny?=
 =?us-ascii?Q?sPld41tBIGDU8dkb+uilzNadwTicRSlvOz9XbxD+g92NLE4jBTX7VTU6WuZS?=
 =?us-ascii?Q?UenqZC4LQR2QwPo0YTrfd+25ejPWTrFu7DU0qJsyH0i8jdkLUiNObZezt7YC?=
 =?us-ascii?Q?4wsV1neZ9H/kG09UxhPbRjjL24tnCfXdguQoDeLbeQc+9GAJzG+Ruk4Pgn8W?=
 =?us-ascii?Q?GX4ofNX+dNbHt8KgY+cPbutk8p26rYfm5S8OIrYc9/5bkUQ97tVdf1CVsY3y?=
 =?us-ascii?Q?uak4u0PF91wVd1NWLaxiNK7omuuC464ytiGB47CzNHQAJIcQ1ETrAR/mvssi?=
 =?us-ascii?Q?5HPZhI/IARZ0gqotwvAuIlNbnYGw1WyuOEGTDO2StzXXAiCkhgWWBrZyPRdn?=
 =?us-ascii?Q?uKK5xPgId9S6L+/HT03IhpcUfYw31bZKxlwg+o5tSL6AImkIZXcw5xqIWTKF?=
 =?us-ascii?Q?wnKil5wa6S/xizOPY5wBDi3NJnc6uecubS4X78zdFDmUdHcg5gh0/AnuraOS?=
 =?us-ascii?Q?VbjwZRmL8B4VnAtOUWOLHUfvGqe/QBRMzxbPSKZP4AR45/uCwRVJpevXcjeI?=
 =?us-ascii?Q?ipWJTrdH2di+Xxk4frZ9KtbCKjDNNpBwJSDvOdgvi8qkAsm/hMwGcd4U96Qi?=
 =?us-ascii?Q?uy/9Bhkib3imQebEmisOWMeTFGI88z8clkFaRHct3fGwdkrva0pTkk1SnapR?=
 =?us-ascii?Q?Q61gxDG1S9wxM3rL463OpPFjOloAPJW71+1E8VdcJDW/nYiJ1he307BW4HVo?=
 =?us-ascii?Q?6xLp/1J5hKWnXMeffZ+LE72Fu+8IQvdWKJ9MNMt11oogIdRB/0aDVGt5dxUq?=
 =?us-ascii?Q?CndWe0WwjT+Im/beR1QdPQv+kYAlZchkUqHooXEVyjaRdpHTP4Td6dmM0F3z?=
 =?us-ascii?Q?gBqsRC1pxckoOCX/0YaWYjPUma4TJJlHDIa5QkKM6hyVGCCpwjGTAtc1V+0e?=
 =?us-ascii?Q?iRDC4TjYCao2boGWY6y6tKfKm+N7ZJJxtW6kjFexZQjCDqVKZUajhhYdXfd9?=
 =?us-ascii?Q?KWgculgM2b34ls1YEAQsduQLfgMq+aFpWbMSbdAg6/uDHXa1HvDkz9GHuyFN?=
 =?us-ascii?Q?i2MBCrPaxZ2nr2CxNe66sylEUz5b6tJWjG803S6Rc6kkT0Y9AtGgBpoMmX1e?=
 =?us-ascii?Q?SFGwWasio0V0ccKSIp2Rq+pCTp4cSLgY/MxwX3Qmlbv8M8z/yoCb4lKkJ+JT?=
 =?us-ascii?Q?Nw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e9a1565-87c3-4e42-72bb-08dab6afc032
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2022 17:38:38.8909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sTVQjWLwnVbDx1R4AWTw1mU8KTunllyOtzcY3ZPnoOfyv6dIUFlhxZZrmTDM/Z2kq5kxyl9Mw7TlK1ontBeJJI5wwa+3nNQLSPyzGB05I+g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5137
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> On Mon, 24 Oct 2022 08:43:30 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
> > CXL spec rev3.0 8.2.4.19.1 added definition for up to 32 decoders. It also
> > indicates that for devices, only 10 decoders should be advertised. Add
> > check on number of decoders greater than 10 for devices and emit warning.
> > 
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> I wonder... Should warning say CXL r3.0 spec violation?
> 
> Seems possible this might grow in future versions and so it
> might be nice to give a hint that it 'might' be valid in a higher spec version?
> 
> I don't care strongly either way though.
> 
> FWIW
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> > ---
> > 
> > v3:
> > - Fix commit header and output message to reflect code change from v2.
> > 
> > v2:
> > - Remove decoder count reassignment from violation (Dan)
> > 
> >  drivers/cxl/core/hdm.c |   10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index d1d2caea5c62..c3b756f93261 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -71,9 +71,19 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_add_passthrough_decoder, CXL);
> >  static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
> >  {
> >  	u32 hdm_cap;
> > +	struct device *dev = &cxlhdm->port->dev;
> >  
> >  	hdm_cap = readl(cxlhdm->regs.hdm_decoder + CXL_HDM_DECODER_CAP_OFFSET);
> >  	cxlhdm->decoder_count = cxl_hdm_decoder_count(hdm_cap);
> > +	/*
> > +	 * CXL spec rev3.0 8.2.4.19.1 indicates CXL devices shall not advertise
> > +	 * more than 10 decoders. Switches and Host Bridges may advertise up to
> > +	 * 32 decoders. Set the decoders to 10 for devices if more than 10 are
> > +	 * found.

Stale comment, the "Set the decoders to 10" is no longer done.

> > +	 */
> > +	if (is_cxl_endpoint(cxlhdm->port) && cxlhdm->decoder_count > 10)
> > +		dev_warn(dev, "Endpoint decoder count (%d) > 10, spec violation!\n",
> > +			 cxlhdm->decoder_count);

This is still too scary for how the kernel is going to handle it. I
would expect:

dev_dbg(dev, "Endpoint decoder count %d, expected max 10\n")

...what downside are you seeing that's prompting this patch? Sometimes
Linux might want to constrain what hardware can do to avoid code
maintenance burden, but I do not see that harm here. Otherwise, there
are users that treat any log message above KERN_NOTICE priority as a
sign of a broken system. Is a platform with an endpoint with 16 decoders
broken? Also, if we do this bounds check for endpoints why are we not
doing it for bridges for the > 32 case?
