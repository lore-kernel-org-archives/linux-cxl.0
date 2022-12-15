Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00E8C4332F
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Dec 2022 17:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbiLOR3M (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Dec 2022 12:29:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiLOR3K (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Dec 2022 12:29:10 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9646931DEA
        for <linux-cxl@vger.kernel.org>; Thu, 15 Dec 2022 09:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671125349; x=1702661349;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=l/qfpdEy4KNNi69YAkVnC3Ms0OzVCLhbzIG9s/09028=;
  b=AL9ZvhLycBcSJKK6WLGw6PGkRujlFDU/nAPuQBS5JrS6MWEA+gxMt4c+
   xXPPoMHNDjgfxMAC92K7/v1jY3rY3ayyMRQapAaGP495CsvHO46M882wl
   RSFvDgh/LyJL33rmPerkBO2dtXc7fWPhaJGIQbcQJl6eQXvKYHNmM5dHf
   m8n6WptecowwmRrSxa9R/gXDBJbYlt21L1O5JFuMfD3txI3dtbesGdOSO
   q/hOiioFCw/JZJ4eVYNu9k1HtculWqTWnm+IbakjPiPJBdwDzGYrQrzns
   qOcehKoKht+K0sjvDRrvorTpv0Lh/VbG5OR5BDtXvIcyNpalBQ38C+OKR
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="316388336"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="316388336"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 09:28:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="718092328"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="718092328"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 15 Dec 2022 09:28:52 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 15 Dec 2022 09:28:42 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 15 Dec 2022 09:28:42 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 15 Dec 2022 09:28:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1XiELBCB0beQM5rSqvTmmBgB+NSzB4pZh0TqmO9YSoc8YyU0dxXe87P6rYjtRV3Zz8gXUnvemu9KRjScY1V9lF5/TRWmlLieOB9bLcYTNuf6ONP6p+2dTGEubdj4CdSXckqUjXMXTgUsP0FV5LsDlwwNb21LEHtd+Nl+fD5ULjC3l3y9KWObIOZE79SG/zw8704+n81ChvZQaJmYupr5yzVdV8BC3uERQAidwO2FhB4ugWshN3Xq0aBBC62Uc68FkGMR7SaUNdEruU3iZnDWPBc0xHus6C6FMXD8BXZMZvYzi40XTurSY+GYQmBTH+0BQVtjKnD6FRxY1bLXT8MvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HcyKH3V2RdoGmTu4RXq4T4mcGBzDvD2KABdZt6+a7OU=;
 b=Gf/Qkdp17ZmuzbbuVrciwFdd5rG28m5TApNbRNSBkaREOmO6XMz/hCIDsQ7DV8nORCg9vctmvk8/H9WJII0qrb1CcPQ8PVuCR1z4cAcgQ1ZC9t2uu2KuEZw2gBBvYr7yOIV/HChtBtoJZFRcmIsuSwaRyOmhr3y3yx+wZFHTX09rnPB/WmvsKXtblOZTtuF+yNlgRSW+3khr4NRgN21XcCLrtyQgRPD3MiYQ35w7LBTiKVlxutKGbOEo8BRTwVUZaxpk0xD+K/fAjFzDDD2GhsKEaDRhBvrxapiBASjS4Xg4b9rZw4P+VxSzvwLURq5Iingho0GOTQ01XHMVtGoN0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MW5PR11MB5785.namprd11.prod.outlook.com (2603:10b6:303:197::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Thu, 15 Dec
 2022 17:28:40 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::288d:5cae:2f30:828b%6]) with mapi id 15.20.5924.011; Thu, 15 Dec 2022
 17:28:40 +0000
Date:   Thu, 15 Dec 2022 09:28:30 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <qemu-devel@nongnu.org>,
        <linux-cxl@vger.kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2] hw/cxl/device: Add Flex Bus Port DVSEC
Message-ID: <Y5tZPiiJQm4el40t@iweiny-desk3>
References: <20221213-ira-flexbus-port-v2-1-eaa48d0e0700@intel.com>
 <20221215171633.00000ac8@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221215171633.00000ac8@Huawei.com>
X-ClientProxiedBy: BY5PR16CA0006.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::19) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MW5PR11MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: b9da1ef4-96f7-4ddb-36e4-08dadec1ce51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9SaFao9+H7Ob9Y8wLjhgk9StU5UzRUWXSlQcg2ReX1/S45oGkLwzWRg/EtbZT7T7TQv6XpNA4/07JRMYRlQq2jQxlwRkes/FlkeWZy6/KSjt1sqMo5QI92fJvyrKhZHfhEsqU5CWWxOamQj7mf8jUwPXpjR8JcdN6xiTkcoP/oREUb4DGHMOo9RATcWH2OdxWVvVy8ai1uHClI0vXEiwQcX4oEtOGWKeV+QzG3j7zxZyEPeFElRd9X9+ln69kDf7BZu9l7OpHVY+3kQsDbokUSizMbTBHNwWwub0bd9UaAF8EBfz8krY6p86R43/FjFB+VsOdWas0Bb69XbC9oeSLIlHbOHMc+Co4PcfUGawRdTh4QU49VIOciHmKPa6Od64kgpjUkPMXYHJZjgiLGy7ozLSZPpruSjJDS0HAuUIj0jTD3F2GfCUbaY3k1/LVKsT8FTUbJBQUECpXz0/R9EEHpRU4Pd3Cw6KSLPzV2csOlv5iTzRRI4aU18vMJSNG4ceSdYOx1cbeO9GthkS7DlCxGdA52qdeEulq7EVREplNAv1poPzQW6e2zyIlpAVRV0yT4iFQobt0/cJJw8v4qameOBn/IKXbmMAeMdl1xI/9YxQkK5fOXdIMv9Pt4hJtAFJSibCCb6cMiJ2Zf/hl8x6H+1y44m/YzZ1WNQGOQDTLIBYeOdOCpCPM19H0r1Ez7pybjoUL3/krAd8nUAvSHO8Bw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(376002)(396003)(346002)(136003)(366004)(39860400002)(451199015)(83380400001)(33716001)(6506007)(966005)(478600001)(6486002)(86362001)(38100700002)(9686003)(186003)(6512007)(6666004)(66946007)(66556008)(82960400001)(66476007)(26005)(8676002)(4326008)(54906003)(6916009)(41300700001)(44832011)(316002)(2906002)(5660300002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6SSYy1lQJGerwQAPvIfF3SO+x1TIO0uIk1E0t0uVWKu/dv21oGuzpAdY5jNe?=
 =?us-ascii?Q?W8ytBoJiLyY/frCKxCG57AGuC4rMipLGl7V9kk1eIRS8M+DxTrJDr1SB4mr3?=
 =?us-ascii?Q?fRgqDceSSbjmtlFROJ2jqYqduMACynswLt+jIwmZs6KEi9r7YGSxuS2q8UUn?=
 =?us-ascii?Q?65kTxcL+F1BWn+k6lhraa5UZCgc1obzo1FzmiKwdwqXBtnnnwVzpOl9hq0ci?=
 =?us-ascii?Q?WJHpacH0KLxydNY8eTuqJCSWCdzLIeow6MowssawtDcvuyw1SIqCxFw84cPh?=
 =?us-ascii?Q?fFyH5n0yKufGGP93FOeNnU4NrIuxL9THn6Q1uEDduDoAmbxTagnAhI1hE0oc?=
 =?us-ascii?Q?ieai8u5H64qsuwChbIDYdi6jKdEFrTrDMdCT1pj93ufxnTVDzXBKA3xGI0Q2?=
 =?us-ascii?Q?2dWmeh2NylyT0IqGlVrD5B2ZPXX2ft3MTa1rFXXdT27A5K2IPr/M9cTn24uI?=
 =?us-ascii?Q?rLIUkVRp12dc92z+7uhlm13xLIkuVHGh88eS5ZETT87AmGRPmwP51U3GqsfO?=
 =?us-ascii?Q?ZKH4hyVsjIjYJpn8pXfR4uQdiAXERdds++Vanm8GtKAwy1NfzLxOxtaRyNzC?=
 =?us-ascii?Q?bmTimVOXb8wbSUyL4U8Wa8s7SsZEfDuf0P2Ys/LeElQQrICU6ciX9GAxt0xH?=
 =?us-ascii?Q?wa7CmLp9smmTpFnxF23ftKlr7yKMUH/Thwff5ltrKyYyXhhey21QDZbc2QqU?=
 =?us-ascii?Q?dmvz2nZ58jhb5R2Ri4PK2J0DgMuF9NO3izCa9PxbLlyBlXr0t6KpAmnl5bHt?=
 =?us-ascii?Q?mi9/1KFboiby0k7PxA/vGDXw22MP2KL8YO5lcbV2y4AV+9rp7zb4VWpVzGuK?=
 =?us-ascii?Q?A6lYMSEYK+aP2mWwQKF64tgs0bQjMnVANE0dk0V4WnDON6PtUyu8sdWGyk5K?=
 =?us-ascii?Q?PFA0izzy8ZOH+nFKboZbmOTflDqqWzPe9XQ7myyvUeGZl6y/u7Pz/tUhLz5K?=
 =?us-ascii?Q?zGWdFv26qbvRFI4RanKLdK6e+JTKvnyx6CWFA+7MTkxGSLL4k1YyBR07rq7p?=
 =?us-ascii?Q?dY8LbdjO3e5HPb3tzM6khO34XFyuvGm1tWX/+qoIC2YAWlpa8x9/lYXdwOsP?=
 =?us-ascii?Q?1nHZ99WRONa1pcHFZLSS0OESvS5E2Hj+vnUt70yKFhB2pqBoo8dPauYQ2hy5?=
 =?us-ascii?Q?npVkpyT6sXtTcHuaHGDpIFifhQqAoblRTN03RA4E0OAgS1ffQW5aZ58yAG+g?=
 =?us-ascii?Q?usbkzTcZSJL6BJY0pV9xtMGre/Rx35Q7UvLx1WUZdxEaGGvNuCAnmeNzHvBj?=
 =?us-ascii?Q?IbMC5ymj0a1GxbhoxfMiVpzAQPDMdOZ8czbB/3ete6TEr7lvS3eIBAg5yvbI?=
 =?us-ascii?Q?AbGZn4XkwImgxdYFhJIt7UzwZTzoRf6LiVo2Q5aHpwZmcBhilxz5SlKj2vKI?=
 =?us-ascii?Q?WLa0ZH63wZKcMEMlfV426s+sbcpvgeUySxoS7z5rtc/3ZlaYjqp6V2Hquv/r?=
 =?us-ascii?Q?fJfOqAtmyylo0SBR4+HLPWn09lcw2awUBEld3y501rQfA4s/zcwK4hC/sFMw?=
 =?us-ascii?Q?BQJFnjh8AbN18eL4jizv+tQQcvey3uO9X6Yys9BjYK9XbcVZOHxPoOdG/ORj?=
 =?us-ascii?Q?V9Ia3Y/Y4mJ7iWFA5WE7Dylnwx9Ej4ZU4c5eyi92?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b9da1ef4-96f7-4ddb-36e4-08dadec1ce51
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2022 17:28:39.9235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /CClkHhX/7whbwr5ra6wzlhEFy/4W6GIB9KWdBvH5Uo22nS8egc7qoRhfzvCFB7ji3kFIlRbzrc4ud8X23lbgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5785
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Dec 15, 2022 at 05:16:33PM +0000, Jonathan Cameron wrote:
> On Wed, 14 Dec 2022 12:54:11 -0800
> Ira Weiny <ira.weiny@intel.com> wrote:
> 
> > The Flex Bus Port DVSEC was missing on type 3 devices which was blocking
> > RAS checks.[1]
> > 
> > Add the Flex Bus Port DVSEC to type 3 devices as per CXL 3.0 8.2.1.3.
> > 
> > [1] https://lore.kernel.org/linux-cxl/167096738875.2861540.11815053323626849940.stgit@djiang5-desk3.ch.intel.com/
> > 
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Ben Widawsky <bwidawsk@kernel.org>
> > Cc: qemu-devel@nongnu.org
> > Cc: linux-cxl@vger.kernel.org
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Looks good to me.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> As Michael wasn't cc'd on patch posting, so might not get this directly I'll add
> it to the front of the series adding the RAS event emulation on basis that's the
> first time we'll see a failure in Linux (I think?)

Ah thanks!

Sorry, I thought you were the 'maintainer' of the CXL stuff for qemu.

> 
> Michael, if you want to pick this up directly that's great too!

Should I send directly to Michael in future?

> 
> As a side note the WTF? is because we made up a hardware related time delay
> number having no idea whatsoever on what a realistic value was. Cut and paste
> from the instances of this structure in the root port and the switch ports.
> 

Yep I just followed that based off the other code.

Ira

> Jonathan
> 
> 
> 
> > ---
> > Changes in v2:
> >         Jonathan                                                            
> >                 type 3 device does not support CACHE                        
> >                 Comment the 68B bit                                         
> > 
> > - Link to v1: https://lore.kernel.org/r/20221213-ira-flexbus-port-v1-1-86afd4f30be6@intel.com
> > ---
> >  hw/mem/cxl_type3.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> > 
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index 0317bd96a6fb..e6beac143fc1 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -416,6 +416,17 @@ static void build_dvsecs(CXLType3Dev *ct3d)
> >      cxl_component_create_dvsec(cxl_cstate, CXL2_TYPE3_DEVICE,
> >                                 GPF_DEVICE_DVSEC_LENGTH, GPF_DEVICE_DVSEC,
> >                                 GPF_DEVICE_DVSEC_REVID, dvsec);
> > +
> > +    dvsec = (uint8_t *)&(CXLDVSECPortFlexBus){
> > +        .cap                     = 0x26, /* 68B, IO, Mem, non-MLD */
> > +        .ctrl                    = 0x02, /* IO always enabled */
> > +        .status                  = 0x26, /* same as capabilities */
> > +        .rcvd_mod_ts_data_phase1 = 0xef, /* WTF? */
> > +    };
> > +    cxl_component_create_dvsec(cxl_cstate, CXL2_TYPE3_DEVICE,
> > +                               PCIE_FLEXBUS_PORT_DVSEC_LENGTH_2_0,
> > +                               PCIE_FLEXBUS_PORT_DVSEC,
> > +                               PCIE_FLEXBUS_PORT_DVSEC_REVID_2_0, dvsec);
> >  }
> >  
> >  static void hdm_decoder_commit(CXLType3Dev *ct3d, int which)
> > 
> > ---
> > base-commit: e11b57108b0cb746bb9f3887054f34a2f818ed79
> > change-id: 20221213-ira-flexbus-port-ce526de8111d
> > 
> > Best regards,
> 
