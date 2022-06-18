Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 591D6C433EF
	for <linux-cxl@archiver.kernel.org>; Sat, 18 Jun 2022 01:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383500AbiFRBgh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 17 Jun 2022 21:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbiFRBge (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 17 Jun 2022 21:36:34 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCA737BEB
        for <linux-cxl@vger.kernel.org>; Fri, 17 Jun 2022 18:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655516192; x=1687052192;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=KuWg9kPYdc64nXHIP9LNawhYe5c0+VRPdYJliEtWRxE=;
  b=RC2IPnKR4QV7F6vTw72iWx27/wNFv5THr0iLLh37jzRgEbiYcHSxfxHf
   DGDK5e7kMy7P/+aNLMQYzKYcCZ/Ft0tAFq4zA/qew5sFEMj8zRiekE8GT
   680W7YGmAHw+7fSrlrh42VZjqlJQjQjgIU5WDldkV3Q8BKFofDfUILD6G
   x9ZZTwlVPr8morcwKIzHvmoEgdW/4r4HR35l8gqVmMsn78i8xZdhXtiOD
   ukOK8XEZoUmQqvEa8sJLD3H1ulHPKnqzBb/ksjucUfVpuHZ5EKH4q1edo
   NKpvwptlcvaEXHcNY6JmgRC/wI2+/j7NI2+KpIQQrTR962j/ste/MyhrP
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="341302234"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="341302234"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 18:36:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="584218612"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga007.jf.intel.com with ESMTP; 17 Jun 2022 18:36:32 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 17 Jun 2022 18:36:31 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 17 Jun 2022 18:36:30 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 17 Jun 2022 18:36:30 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 17 Jun 2022 18:36:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B9OUQ2PpPRHt+Q1S+rpcwsXRNTzi08wyb7UeoJ6Sc0HweVlmtYCss3lCijHiWL3lxQRsvqwkj1g2OKrK7yCD7IuLgt5LspVMalHd7Xx6GQMH/lNgrT3FDlLghlTTRLELQ2gzcw0nFqV+Fmp/C91zG+mVSk9+/f5sWli8WCHDxZuQ2j/hSCkOhb8pNTSAvYtd5vQ2IsYUzov3TjqjpNI8xiSnGObdn+Ry1hQfVe3ddRokS//c2PEWy8op51VCDv50myvkVVOKQ/JAKuKBcHSi9tZjcHofZRXbrnm3S4AJE+i1mojtlu5St8yZoHmWjca7wAlRMa0wRfTIfz5oKbiMAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f4UKrkF4+Ijcj1mlZSNhuNzSW7gQej67G2/DcaxylzE=;
 b=m0ZbVa9oG58vOTA1RF0WbnFSWaq0cLes0LcF6VV5VH+xqiS1msOjG/6S7YFsDKib9eM9Hd0B9pvIBJGjYCBadA0I3J3skzDK7oUOH4LDcOaVCwJL9hInIiENTtuv5lwmf/ifcJ3XJIuW4AYeB06oQHudoScTkDYjzzbg6iuoFM7A7vlaLsp18Uq7gtsdx9yslsmuhS+kYNQHa5ZvDSCi7MOyDkLyaMxzaTCaU0+DbRN1kivSElE0nvj7Omli+cXI9ipAGp/YvtOGDbb2aiiM5oqEpd/lPqPo5OQLVQcFo8aLPAEAA/PNhGeE8nmK4K0PC42QNaEut5xhL9WtO9bu2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15; Sat, 18 Jun
 2022 01:36:29 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::f50c:6e72:c8aa:8dbf%7]) with mapi id 15.20.5332.023; Sat, 18 Jun 2022
 01:36:29 +0000
Date:   Fri, 17 Jun 2022 18:36:27 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Ben Widawsky <bwidawsk@kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <a.manzanares@samsung.com>
Subject: Re: [PATCH] cxl/port: Check for sane CXL.io values for device DVSEC
Message-ID: <62ad2c1b8e5e_89b132947a@dwillia2-xfh.notmuch>
References: <20220611020246.140637-1-dave@stgolabs.net>
 <20220611040321.gmjyddcyb4q73o4e@bwidawsk-mobl5>
 <20220611042601.ezsjsoq2kaov76e3@offworld>
 <20220611181956.6od4hlfr3z7mutao@bwidawsk-mobl5>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220611181956.6od4hlfr3z7mutao@bwidawsk-mobl5>
X-ClientProxiedBy: CO2PR05CA0108.namprd05.prod.outlook.com
 (2603:10b6:104:1::34) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e39936c0-0158-4f45-bf63-08da50caf736
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <PH7PR11MB65222044307D180D14E0E7B8C6AE9@PH7PR11MB6522.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NQuIlcceTjAJR0kNU+H9lZU1l0n6VBRyzOORAnviAoeRY1eB1Pu1Rta9ly6ZDRe51+brEDifOY1XzT1nzToZqd2nG5tKkGnYdKTczT5kTo35rmlfPKwOW2vEEKLe+XbPT9DHerEZv0/TxxCUvWhV/jDPAT6UuAKGOgcSwFtAWI/Apvvkwa+/tZqJo0hFSYyTh95G/6lByT/5Vje53hLmcQYkhAZWp4PthE+YNVPumhr1rtPCjqdtXZJEIpz6zasskNtL8AzS/rixfAJm9BsV/WjrfwJPe04PxpQQEAYj7KgdXbCou9HTkvohq5d2dYQoJCNQF/goh0k4hz+MEfBITciZcDn8Nnl9fL7p7OCBlSW8yxq4k0D04v7LUvVWgzwZSL45LrhF44dzh1ZxNzalbUVJFg3EO4zPnE3om0BNafXe/R/cjN5xBdcYf1tqHypQcTE5ZtoDxaBRYB4ZLGTaI6M6BzXn5Ol7l2UC7LFAISpmo5A7NyDyi/M94bFczltknGIfiGL6mLGzioRBWM0tXYtTA45q0BeOvMonwDgAUidhtsmBGYckzY34CDX6AOA5TDaFrz/ho0T5CubjkbgYbrocpSgS6tIgVttIB/lw6XJeJ0aBbGFyNwg9ec7rbE+nI19gOYk2rg68ybVKWu1DiQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(186003)(66476007)(66556008)(6486002)(8936002)(8676002)(110136005)(38100700002)(82960400001)(83380400001)(86362001)(316002)(5660300002)(2906002)(4326008)(6512007)(9686003)(66946007)(53546011)(26005)(498600001)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hAi0LWKi+DqYdu/7Sqcgmz1K4gfO90trOzg+wYte1zCoDM3zVi0smO1XJTbQ?=
 =?us-ascii?Q?XRaXDJN90UgIume5jr4//5IOWceQbc39FLqCPnduJeDRuuuCvEP2d6O3KYgq?=
 =?us-ascii?Q?0S8+0BqN/Y2dj7x+AVG1cNqu/6O8VJeSnqNSHPGguPzhDS4EeNOH48rwjzvK?=
 =?us-ascii?Q?+a7wMOOfMvoHDQXjtgpshlEbSvaNzdiIZsCGObIspwTobpxKLBTCZ/TsfIBZ?=
 =?us-ascii?Q?4IDhgmST/OQgeKt9RhdVmFC+c4YiBDl6WoSHr3xzbGRlKorpTgen9YEJUs7o?=
 =?us-ascii?Q?2DalPeacL0twcxCq14VGdf/FTTSD74UsXVPl1qHidy7iZhb5CV696ZKO8+rG?=
 =?us-ascii?Q?nEfQdDF1C+FEgk3mD6A5QcSLKb5lnVWSzpZzYUu4brNhrrLcgeT8osI4KqNY?=
 =?us-ascii?Q?7cnx7eX0deg1ZTEhz9TrZoQcRV4TZfrLtWUnSwlQcDUyJG6Pt41YKSy38vth?=
 =?us-ascii?Q?jsfRLJpk93MXUAA9KvmmsRHCAk2My1ewbJQmj/o0T0c9UR9IzvIHKc44lXyr?=
 =?us-ascii?Q?RcdNaKjcC8K5pvXnQXSx49/K6M9SPLqX6MNNij8HWHq+QpiWwU7bo2qRtiap?=
 =?us-ascii?Q?xW+TBGeZ0CI7hleV7R4juuorjTQDviHJECosx8YidBmZCFxkkmx6mjtZUgf7?=
 =?us-ascii?Q?kCZQrurmpAnpTyWRIEgtAqDxRHybjUCUss+QRLX1+ue60+ohLznD6N/DnGml?=
 =?us-ascii?Q?qaDAhWHMyXmjYHkl6tbua4lHzSI/dBtQCDvjYS3UiAOoUsZ4EBTWo3tV2l2K?=
 =?us-ascii?Q?x8pDFSP2Vg+r6AbVkSdvY/H+zzBTSr9nqhPEugrFKk9gFi/Ksqrdgc2zw9GR?=
 =?us-ascii?Q?xkL2u5eClA88432iI4QupP39ky5WSvYsnmSvzkNIgVIDxHGZFz/tPZFYshp4?=
 =?us-ascii?Q?+yjwq/OrFiDDX0kb5pOyabbmHVCrm8ldoOKx6e++SwfZ4TGKpyMjgwnDLTrs?=
 =?us-ascii?Q?ahJlFgcgGDGDLqCdp8M3j6bVVpcOHHd9P4Q4fCaSwRvgfx0eFu/6TkBXRz7I?=
 =?us-ascii?Q?7DfsxvxHrTsbxjyU865GjPg916ti1Qli7616bqzc5SYqRCotFUqiUhmtdC0X?=
 =?us-ascii?Q?3MHaLg/VPiUi/zseviOqVAncV1KgcVpkKs0K+ZzNNpHwWJxrdqmW+xDr1LsI?=
 =?us-ascii?Q?mcMz6r/xhfHkzzg4dZMZIhKrc36tu5212MvRJNCYQ3LKg9HC/mFqvALPX8hb?=
 =?us-ascii?Q?lt3JIT2SCdJzgsSDky0bha55ATaiwvv4QuUBsV1NHhL0Caxa7eRuD2E9db1k?=
 =?us-ascii?Q?8GSszABTmE1hFy+t7dopAGUzxk3iC24+myKNVVEkBK1uE3heh8jEcFDYvVPR?=
 =?us-ascii?Q?+pMGewmGUTSdV0Bs35x3iWpXJh+65rAWmcSlLAghmOh7IOhBIWlatBypkY90?=
 =?us-ascii?Q?4BAQwTfyIjj7458ywOtEyxFa423jfYPNwmaWjZTZTqLjfLNx+cfpozS7VFvy?=
 =?us-ascii?Q?eu8G+KYuUNlQmEY9nMKl6Sxkjj58oZYUkV1XPxQB//iKDbsvBf6x9XXJxp5P?=
 =?us-ascii?Q?8niGOVY4ib9+8yUu7CBvRr/DP8ina6UkCuK1Y4SdQi1oXNT6EJr6BlAKTXyL?=
 =?us-ascii?Q?7bbx7+TjleHjs0rEJkA7N9+opnuNitWsMB64Lq79EHo+Ce0drJxzeUjXUiV1?=
 =?us-ascii?Q?esjQMQ05fRTZj8b04Rtdy3HC0kOQwiKhkp+zjRnbc3mfkQYh5V9TydDgx/S5?=
 =?us-ascii?Q?klmzZK3w1D9772V+d5CNvNZY0xu97Faxz/E2dMTRwIBgoWUFRHIsj+/HKNmX?=
 =?us-ascii?Q?DdFacsrXNAYGX5WX5C6/f1maofi9wE0=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e39936c0-0158-4f45-bf63-08da50caf736
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2022 01:36:29.0022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UbIlSold6qtMTfufJMmscbMW0ZwuT29sQqb4XpGZLoczPubSJ/SY5xV6A5JJy6xpoVr2BhSl0a+ldyhum2P97f7e7blVq/lSxX84TYHvuhg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6522
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Ben Widawsky wrote:
> On 22-06-10 21:26:01, Davidlohr Bueso wrote:
> > On Fri, 10 Jun 2022, Ben Widawsky wrote:
> > 
> > > On 22-06-10 19:02:46, Davidlohr Bueso wrote:
> > 
> > > > +	if (!(cap & CXL_DVSEC_IO_CAPABLE)) {
> > > > +		dev_dbg(dev, "Not IO Capable\n");
> > > > +		return -ENXIO;
> > > > +	}
> > > 
> > > I don't know if it's worth doing this. We wouldn't have gotten to the registers
> > > if it wasn't CXL.io capable.
> > 
> > Yeah I thought there might be reason as to why bit 2 was checked but not 1.
> > Does this also apply for CXL_DVSEC_IO_ENABLE? fwiw I thought this was handy
> > in case of bogus dvsec setups via qemu.
> > 
> > > > +
> > > > +	if (!(cap & CXL_DVSEC_MEM_CAPABLE)) {
> > > > +		dev_dbg(dev, "Not MEM Capable\n");
> > > > +		return -ENXIO;
> > > > +	}
> > > > +
> > 
> > Either way this check should still be moved before reading the ctrl
> > word.
> > 
> > Thanks,
> > Davidlohr
> 
> I don't seem to have this code in any branch readily available, so it's hard to
> say. In general I don't see a marked improvement in doing this, but if you can
> address it in the commit message on why/how it might make better debugging, then
> I'm all for it.
> 

Agree, the capabilities are additive. So CXL.mem does not get negotiated
unless CXL.io is also present. However, if a device declares to support
CXL.mem and not CXL.io I would just claim "Robustness Principle" and try
to keep going with init because as long as CXL.mem cycles work and the
device responds to mmio and config cycles then the value of this bit is
moot.
