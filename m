Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4941C433FE
	for <linux-cxl@archiver.kernel.org>; Thu, 13 Oct 2022 23:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJMXLO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 13 Oct 2022 19:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbiJMXLO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 13 Oct 2022 19:11:14 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F2C16D8A3
        for <linux-cxl@vger.kernel.org>; Thu, 13 Oct 2022 16:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665702672; x=1697238672;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bQ2n8ohaT4Fi6VEmKyuYPPRAW49svOCA4soZqAimcDY=;
  b=Ee2vDA62Lpoe5PRgIV4C4fc7uoXE3JbsHKPyCsa0Ci5ZwZ76oShwPTME
   zQpxhz3VKOVkG29NHExm/yFa2y0hin7UeegNghpj5P019UrRzww2t4crb
   6lJyR4vaSKcDdq1sxH1jIlTZfsvFjVWMHH95JU19jr6It+l1v3k3zTXC+
   XF9o3ZEhiRPDVId9k0fEX+/LZ+TschNh0oYF0MTbgmx6jf+Z9TVg8AUNZ
   rmMhgFGjJaWbPewXYMvpOAQcPOhJZ6qeAJu55+SDC1BGoVkfSNpwXP9pp
   q8hXJUxeBXJnp46KIOMaaMU7txBRYaH/LO737KhWUO3FiZc2VhJVmCuZe
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="305219976"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="305219976"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2022 16:11:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="802425726"
X-IronPort-AV: E=Sophos;i="5.95,182,1661842800"; 
   d="scan'208";a="802425726"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP; 13 Oct 2022 16:11:11 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 16:11:11 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 16:11:11 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 13 Oct 2022 16:11:11 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 13 Oct 2022 16:11:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/qC2eU3apCvBnssnOfK08a5rxFfFVvIs+9OH0mpT1lrSZ+vDoPsimzcitim3oB3w0x6iNLA0B2EXwRd13zR4I6jKaoCY4iv+LHmGqPVKyd4tuIiXzs54IGJpNfhsgkw3u08WLL4yYhO+3Yej6KZvoPto9UAOy8Z22lWyz534Q+wjVRY5EMpIHsJbFfMj6F79Wo2juy3w/+Y3uF9PiRx2JtjOMmeQ9GR0FFpzOlNOGH1Ny9akdgcOHomz6YRG8e3ZcYBHw0wsdY1TyoHrIvI7X5ztLNunhq4QIKeJQOA65dViPHYgMLi2Hb6ZMM8rX9rAf+m6ll0Zp8aeGLxqVtDYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uonutfbj+AGK6yxT7WjYepyDbk+aUK6PehnEMr0783A=;
 b=n4ba8snRFveRUxd+WqnjNtxUTLOtCdvVkkGEYpJwbCU2pqZG9F7HIAJJqV7sMaf7SvsZ4msQmc82M8fCXR9WobgHB+DIylwPVW/heyuTyLVUSLH8Fb7TqayAozFI1UXu9z9JJzWsbLuCbquLCm0rSG2WD6iFHEJ6c/RUfEblIupx5OFnn9AdpX+DDM7TRETX+79+SYetc2ylKO7luqwXZGIvQQFIri9ZX5iRoGlZkMn6Qd40XlmOeJSGQ1fEW++pWvZqFHeV4qVDgn2RQ0Mlc4gH24CVzpuPkKq9e0gr14kzEOn269H+aLXx+LCcB5xmMgjgbG/0Lgp1W1q0T6i8RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ0PR11MB4910.namprd11.prod.outlook.com (2603:10b6:a03:2d7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Thu, 13 Oct
 2022 23:11:07 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6f83:c165:aa0c:efae%8]) with mapi id 15.20.5723.026; Thu, 13 Oct 2022
 23:11:08 +0000
Date:   Thu, 13 Oct 2022 16:11:04 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <qemu-devel@nongnu.org>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [RFC PATCH 2/6] qemu/uuid: Add UUID static initializer
Message-ID: <Y0ibCFpR0HJwBI1C@iweiny-desk3>
References: <20221010222944.3923556-1-ira.weiny@intel.com>
 <20221010222944.3923556-3-ira.weiny@intel.com>
 <20221011101317.000079a1@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221011101317.000079a1@huawei.com>
X-ClientProxiedBy: SJ0PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::8) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ0PR11MB4910:EE_
X-MS-Office365-Filtering-Correlation-Id: 869ce559-ab43-466e-9c1a-08daad70365d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WCOHs5Bj0Q3QgNMOjvbCP3pXr3ddQoiT+SB/AaOxR6QZHvAzF5ZcnNNhWdl2j+eNhqC8Tnl1HCLaWqsZzbTTKxAwHs21oWhh1w+3OxMpPXBpsV0veu0rlxAcpwNfezrF17MZS88/sEkVFPK7NyO5tYm+AiSa8ACVIDGnNT7TyYZ0dKf8XZVuSb/aaMHg32UnCBZID2MClYE+9fa/Aa7vBojDdIMLxGX5MrTLiq5W628whQbl8GplVT9XIOVRoUaSeCRuVBhXGLJjgcsL3QSFZqRWvRxZnbrc3hSmBSIQbNxEG5r+lJPq01vtP5iDIbrrEYold8xH+VJzJg11S4AUcFMBw+lyUgzNACCbIx1D0kU+nWkap+hsxwDO9FMsG4W3+kLxfzdnJNddc4zMxP872PNvyvbYelNzxc6bUs8XF2ixN67jn4tPPFjMRciOCSvjDKXWY+Ahr54c8aHefmyaVBRStcryYT9uYUjI5ESumn+C9MtMdizfYYb5ETp9uHGyI0Hf7cmDkeQYgzLeTfqoOXcLY4ttX+NeNRQjOUQ1jvFoRpP8jdR6lTbvFjNzHAsnhkWef1lO9RZsl/BCr7k4AQk/ErMciB/Lu6fciJED9srLgb1gnWzY/Ws/Qa51LTS/2S3OPc6GHe8sAJb17tATjqQL6lFZpyydJTaNGgWErPM2jONrpjxI488Q6POlAz+Ia0HMBXrOCcZLDzbqWO9+kg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(7916004)(39860400002)(396003)(346002)(136003)(366004)(376002)(451199015)(478600001)(6916009)(54906003)(316002)(66556008)(8676002)(6666004)(66476007)(66946007)(4326008)(66899015)(6486002)(26005)(6512007)(9686003)(8936002)(41300700001)(6506007)(33716001)(44832011)(5660300002)(2906002)(186003)(83380400001)(82960400001)(38100700002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IfYCcqkSve6wQ5rty+uIbCmnwr1k/VZKR0r1KgxGBnDtzoYUDUoVDT7wBFYO?=
 =?us-ascii?Q?vWVUbZDJGhrppIDkFvzrJqRa4vzEXt9Y4AYbGwoTSD2aCyhtd2IaaAh+jaln?=
 =?us-ascii?Q?Gfdt7pAGpgcrUUBqIrXi6g8W6TI/C2NSghTBdT3iA5aUGrgrIHIBk6LQBTiY?=
 =?us-ascii?Q?EqdLKyxAdk5ZnY0PhaW7bxMF6/UEHlPs0xgT+7559y7ZEucL4WUChZrA4A0k?=
 =?us-ascii?Q?tPR1hlLZMmjQQAdJauN1ih1pEUIl8yC931Ud2kxI8IOPiNfmoUdaYnubd+/5?=
 =?us-ascii?Q?SSVd5VhZYi2xePZhayeAc5YKVScooZM5/ggHRw/XKieAIg0SWtSOaKDNpF9p?=
 =?us-ascii?Q?u2vqmUxOTr0BuS8LI9AkONUQgsMEJETSKhJbSfPd+KY1cUASr09Xy3K5sJGH?=
 =?us-ascii?Q?Xafnw03S5JyRkFisSmtMpumwaFvnEEIGbVlIR21z2s/kY0WwoioW+jpWHIgk?=
 =?us-ascii?Q?p7IPKdrDv0R6NHsPVc3+vT7l3wXngb54vlw6Rt7tXRwTp/0rHfolHEKFHpaU?=
 =?us-ascii?Q?jtMKnRzTRHNSY10trpgPuYhvsVGKtlyCJQboO5eT933MVk0+maiZtQnwXhPA?=
 =?us-ascii?Q?p2K4jnR3PktX0aLii1fpSZYvRxhLIyIuh0Q3TLwy4YU52PouRDfz+I0KUUr4?=
 =?us-ascii?Q?aw2XK3TL9Rw8pGt+p8b7/OVghN8kbl3QYFCxaWD3lMi99E5L73LvoLDlFRF7?=
 =?us-ascii?Q?P1tVIqdGCXZrdrZSDvRq/xighil92/EuZolacqWYm2PKRAL2mO0NN7xkz/Zw?=
 =?us-ascii?Q?GEhkUVwIS3xs0d2mCN0b4d35TjGzCDBr7O9xoZC6ZusaK/bBnTym8aQ6XKUu?=
 =?us-ascii?Q?gnCHaW+WR3SJNHue08LyQ7QR2GD9+fAqQc/5b/FjshIJYyqgWeUut2jMCnsb?=
 =?us-ascii?Q?lagCIUJcr/tq1+F5a8LKc/tojXlt3eFgzBQ66eTjlluFRTETmgczzcyUIAkg?=
 =?us-ascii?Q?iGHWehxj//2pjO0RbJyJMRkZwjEnSyvvFHdyV/H4Oe5k0ie1qziHruWG4MgA?=
 =?us-ascii?Q?G+u17oLsTwJ6DZwOYqeVN9z4IfXBRVGlv/bRXMiGecS/rZJbPpEc0xyYDaC7?=
 =?us-ascii?Q?oSP+2nM/8mMaZAtB/ILt7t0+leqplS5TGvA5BToP1EmMirmzKPXvRTfewT9Y?=
 =?us-ascii?Q?hVMQNQWSL3tbVB96xjsrbkUuIXT8FCF6TLjdkBUHDpn/mUh3/q6zQF/ZJz3j?=
 =?us-ascii?Q?VUY5tzqLD6Xx3FVVCNJBf2jCDPxASLWQYjvj9zjKMuhzAeR2qpbYnFzwyFbb?=
 =?us-ascii?Q?XzouWJyYVvHQCnWqZq0PXeRHydx9nFq3LiUlm16D454667Qt3m7EVpidIkjZ?=
 =?us-ascii?Q?zZtAtirK9Ztzq/ArDdjeBURSTnOGzx9NA/ZIkXpqC/lAkiciDjl6z6TQFtX8?=
 =?us-ascii?Q?QlixL+ZnDIwMthaYuLBRzlYdNmR8nEF/1XGd6YJiq5RP6Bab9oDJj5Sl+xUA?=
 =?us-ascii?Q?FcHcmEf5rqjz2jFEdlWvnLCs0mI4tcYbmqqtRStM+BkwVPi40ZbJ/49s+F8j?=
 =?us-ascii?Q?3P55IogUVUxcQ6YOYYr5iEfm8aIEHU0LauVqP49aQdrWfKVkpTb5LgILVxVa?=
 =?us-ascii?Q?jGLn/3BeCP0kiTZyr2WbL7BVhW22B0d4zazWlTqGFwijKpzIdhjyLX7Cv6pn?=
 =?us-ascii?Q?UA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 869ce559-ab43-466e-9c1a-08daad70365d
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2022 23:11:08.7665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uExilZASSeX8H3rdTkMoIrQtPSE//mioNFyNPx7IW7QIrgzz6hk+CCyrXYdFIeVZHLLyWugbA1XYohmSSCj1gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4910
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Oct 11, 2022 at 10:13:17AM +0100, Jonathan Cameron wrote:
> On Mon, 10 Oct 2022 15:29:40 -0700
> ira.weiny@intel.com wrote:
> 
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > UUID's are defined as network byte order fields.  No static initializer
> > was available for UUID's in their standard big endian format.
> > 
> > Define a big endian initializer for UUIDs.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> Seems sensible.  Would allow a cleanup in the existing cel_uuid handling
> in the CXL code where we use a static for this and end up filling it
> with the same value multiple times which is less than ideal...
> A quick grep and for qemu_uuid_parse() suggests there are other cases
> where it's passed a constant string.

I'll see if I can find time to clean that up.

> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks,
Ira

> 
> > ---
> >  include/qemu/uuid.h | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/include/qemu/uuid.h b/include/qemu/uuid.h
> > index 9925febfa54d..dc40ee1fc998 100644
> > --- a/include/qemu/uuid.h
> > +++ b/include/qemu/uuid.h
> > @@ -61,6 +61,18 @@ typedef struct {
> >      (clock_seq_hi_and_reserved), (clock_seq_low), (node0), (node1), (node2),\
> >      (node3), (node4), (node5) }
> >  
> > +/* Normal (network byte order) UUID */
> > +#define UUID(time_low, time_mid, time_hi_and_version,                    \
> > +  clock_seq_hi_and_reserved, clock_seq_low, node0, node1, node2,         \
> > +  node3, node4, node5)                                                   \
> > +  { ((time_low) >> 24) & 0xff, ((time_low) >> 16) & 0xff,                \
> > +    ((time_low) >> 8) & 0xff, (time_low) & 0xff,                         \
> > +    ((time_mid) >> 8) & 0xff, (time_mid) & 0xff,                         \
> > +    ((time_hi_and_version) >> 8) & 0xff, (time_hi_and_version) & 0xff,   \
> > +    (clock_seq_hi_and_reserved), (clock_seq_low),                        \
> > +    (node0), (node1), (node2), (node3), (node4), (node5)                 \
> > +  }
> > +
> >  #define UUID_FMT "%02hhx%02hhx%02hhx%02hhx-" \
> >                   "%02hhx%02hhx-%02hhx%02hhx-" \
> >                   "%02hhx%02hhx-" \
> 
