Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4837C05027
	for <linux-cxl@archiver.kernel.org>; Wed,  1 Feb 2023 19:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbjBATZK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Feb 2023 14:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjBATZJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 1 Feb 2023 14:25:09 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77A682407
        for <linux-cxl@vger.kernel.org>; Wed,  1 Feb 2023 11:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675279504; x=1706815504;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2Yufp73x7KBvOeq6Ge3NpBUUPS+OdFRIZsD8F32mF0A=;
  b=B5BsWZXE0yx6zzvHnYvDtIgqfL/Ro8+f+8XsxF7Sa/UjfltSi5Um/tGB
   L7+ohWbpuMB/IsLhYFTpx4sIj2zfc2t2/GtbGMhiYxoyx5Aqv0uxhVtqu
   BrqpFFAIjON9IEenG5qb4udSNsVf2IvMHGi55I+D6im5/swHdlByFSVRs
   837IgfjAVVc2KU6wg9nMRzpQDT611+6g6chsQqGNW84AzZ7EexsB25Kxc
   jAUGvoRzvewXDaijFvyLbFRfzDGG45lD8qpjN8RTca3PvFyDKC+Vu0IoP
   CKdh5N99SbucMg1k6ock6LuKwOCUw5g3BoVDMYVbhxwkYeGw0t9c8V0if
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="308591551"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="308591551"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 11:25:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="667021843"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="667021843"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP; 01 Feb 2023 11:25:04 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 1 Feb 2023 11:25:03 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 1 Feb 2023 11:25:03 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 1 Feb 2023 11:25:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ExaPmtPTG8hpk7DF0iBEB69Mo/rpELH9phuZ4uaV4Ijtp33e4U5lh7TSfNMP7Q4Y6k96T6jrrUvK/GniTJ/EHsRmwUr8D+CBRRJk0ukrnSnHXfJecalT4PwILiHNBY+jAzljrc5ULXm6MugxcPPwcLSXhsuxBzWPmDbFoyZf8ZZWfL1JRVi8vPeIG4iTpgguLDIB/fxc3mqp/1Yu1UxckTIQUQj2+QbPm1KUJ6v3IFRTzPGSVJUKijtnIAWzRdcX680hiBGMUb7+YCLu1WRe3Y/m+8MjLnmZXiLMgKQvhL8L0FJUs1zR3HPv9bsVulRa3dUieqFTGrVXpiz7els1HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcS5VG0+aaybA9ZW5v8TrWSMsAD5D34NGxDxdVH3VmQ=;
 b=C+tJ9CwYeBco0PwXRbPemDh050S6YZb/AXh1mZDEVQhcWR4emPSvNqtLUGh81hBMkZbnFqmTQyTimBu4aMkPGN9XdgL+Kak7jljy1pY0r5L5L6Ix+opGUyWxNLzVR/udG6S9I6rLmzQH8FjVy3/JJvCUNnkwI17Kn6k9YPf6XCxcUtu81djYFAEbJPQqM1y/s8/SHfnAWxC33dMDwusfpdIUjcPeCZxAJKuhiCm4Ngb/CdhDM209+XeHHu4JtNlCQ3ArVBKcHCx/9XetcFWZfdW5iusBw9jGDDt3sq4sksf/j1+GrGVpZ+8NIcUNgCBoblrJau/QHeGqut+j2XC9gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by MN2PR11MB4567.namprd11.prod.outlook.com (2603:10b6:208:26d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Wed, 1 Feb
 2023 19:24:59 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%9]) with mapi id 15.20.6043.036; Wed, 1 Feb 2023
 19:24:59 +0000
Date:   Wed, 1 Feb 2023 11:24:55 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Ira Weiny <ira.weiny@intel.com>, kernel test robot <lkp@intel.com>,
        <Jonathan.Cameron@huawei.com>, <linux-cxl@vger.kernel.org>,
        <oe-kbuild@lists.linux.dev>, Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [cxl:pending 13/21] drivers/cxl/pci.c:511:8-33: WARNING:
 Threaded IRQ with no primary handler requested without IRQF_ONESHOT (unless
 it is nested IRQ)
Message-ID: <63dabc87909e3_b941e29489@iweiny-mobl.notmuch>
References: <202301291620.DxnDWLoW-lkp@intel.com>
 <20230130215514.6cviyuwhxgjlzj27@offworld>
 <63d991da1c19c_a8e3129488@iweiny-mobl.notmuch>
 <63d993bdecd01_3a36e529454@dwillia2-xfh.jf.intel.com.notmuch>
 <20230201002701.a7lwsouomqvoheso@offworld>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230201002701.a7lwsouomqvoheso@offworld>
X-ClientProxiedBy: SJ0PR03CA0192.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::17) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|MN2PR11MB4567:EE_
X-MS-Office365-Filtering-Correlation-Id: c04d5935-eb86-45a6-fcbc-08db048a0248
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AVRBpdCEfdSBiMlayDmJw7P+uiqkOb4l2DUgk4a/dfRnlussmL1Y6LYvZmYyxkRS6fPHefUL7rC44rVAsCKZtrRW+I4tOiMtHeBWPgLgXx0vU1s+Qy0tqr8Mg0WLP3T+dv6vUiuRRDI/AH6s58F/WsRwRhSXhhXsNlUS2GIew27DzwOe6JWsAQAJGwq1A5ehNfIr4V1AlTgcfBWNM1iaMZzaXd/MndyAtxL6+Vp93zyjrA1k3YPLqfwhc89qlcXM22lGZGOVc90ePzJFgVI+GnNxgt0lgCU3mADa/WG9Rz5xoNSrDPi4iBKP1z4uPD4/jijDllROFvGiM++1rtNI41genfVSHulsi+LlvPpQquEkCA0Lmqd+guI4CwPytl0xEYX0XgQfyNJBiH23FW+0qbu24Vzq6nnrW09CG/oI2eqdqsUG+8TdabY4Ppb0mPU8OuRt/iPCrU2hrH73zdjLZfdmT1dm9tBsyl4NnI/KFMY3n7skqURq2PuQplhn52pHuhOnSU/xk9PsOcbp5GCJ3pm5CpUCMQd1TNhjpuM0IzkzrcCmaIc50ViEaTJ2XX41Pv4LwOYtuVcFitNOLHwoLq6H+D6IzbqN1UM9m6fDgj9QUVXH7r2SrGw6whvhyrYzlg2mY/gNdVzyn0fu6kPCCw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(346002)(136003)(39860400002)(396003)(451199018)(6666004)(6486002)(478600001)(83380400001)(82960400001)(110136005)(6636002)(2906002)(54906003)(38100700002)(41300700001)(86362001)(5660300002)(6506007)(8676002)(66476007)(26005)(316002)(4326008)(44832011)(6512007)(186003)(8936002)(9686003)(66556008)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TrgUp44y6oZ3SyPpeQfMfCFsHUS1CN1bLrwTnpHhkB71088SWy3tefUvaP10?=
 =?us-ascii?Q?QiNxr+v6BBXTUkO4kP866mb2C6EkxFbZgmiCTTSOQF9t9SrSRzwENrKnR25S?=
 =?us-ascii?Q?FwRBFpxNJ1iMBp10A7Aa/6TRJ2Dgr+8RDFqjkuFtFBPtnJyG+z9oPUeThK5U?=
 =?us-ascii?Q?KB+Fg1s4u4R7bpyMDGo+Nlr/baMM1xFVsEiIXat+GO0a6FtewRHABe6hGq0Z?=
 =?us-ascii?Q?I22YrJDcpA5A0eVkJGho0z+hwpqAavEvr2SDBcDKupMBkMKJPLCql0/O6yhR?=
 =?us-ascii?Q?w+ixRZKccRlCBZXRzWFyk3uAxjnYNKELPXG7MWwHarsqLGZcdaIsahb1COeo?=
 =?us-ascii?Q?22oG83seqIJQvqYgPep53bHgLfppt0cYf9R3p3pZNoPTaqM6i054gWPi1jf4?=
 =?us-ascii?Q?IxsVIvqn+ECT+yHdtY2lTrUdWGudJK4rJYGyy0+06A061uSPQmAVe/OGfhVU?=
 =?us-ascii?Q?Ph72Bcbw7eOLbv4ooqrSmRtcmPecQIQQYF1jmwlZOu9caOcAuURo4z4WbX3+?=
 =?us-ascii?Q?brN37uvCO8HRCFHfnbuftM7pFKJopFUow1NTUuDEDpRVZ9ZBntWb+uSdyO83?=
 =?us-ascii?Q?kui9FQAM4vRAuWnHTXS0zf8kXZBjKES9JdKaRX8AUSOIxBkB/B2OQakUziC1?=
 =?us-ascii?Q?tMoBs47ZYIvkRwWx9bM7/Jnwo05PvhkJFHWNf7iKl5pBTb5xfdQFk4eUaCNY?=
 =?us-ascii?Q?LJU0Bsc9eD69XnAo+SnX1KCyxzIsfJK/7sDrQFoM3wj/aCJXcTypHrKsSyDF?=
 =?us-ascii?Q?mVVJftTefBF0nPKa84a1ERDAuylrUjq3Q1gaHCpb2o16lgLJlLBH4aIm7cma?=
 =?us-ascii?Q?hLtksMaHO4DpQsxqq0Bk9vE3kH7MyrfLcH/3t5d0aVwVlIwuxiddPOOEJgYQ?=
 =?us-ascii?Q?66DlX1It3a3cpvN5QwrU2Aok5BiOfdUquAY5aCaHfTl2WDgl9Ww6kifHYGYb?=
 =?us-ascii?Q?E+ijOYomaJloVCPfl/R/lcdpsZkY+2sxIjUH8twd/AV22piZ/r5uXew/+YHD?=
 =?us-ascii?Q?x4zRscc1Y45hfOr+i2RhcfqcMBnleM5Ckm/gtevPEluotb1Fn7zIKVmksEyV?=
 =?us-ascii?Q?D7rRBIyAscr6fDeh3ZM6HfTT1BGc1/hfDsZ3sQxecz+4hHoX6kNu9NUf9Msj?=
 =?us-ascii?Q?ZVqRSdebuhLOnPO4gT5+/Hsxl8ss8NBO68pay6Y6NL/QaMpmWjUixP2LhAu+?=
 =?us-ascii?Q?zRoRiOIgMY1mw/HUE1cXuosj3BHV5CYUqiSCVcIAApSNRJLB5ao+tqJKu9Bm?=
 =?us-ascii?Q?URHonuIMnRnYgs8Y5QdgNt3HC66QI/z+kgcbmL2z6VVgAv61W56pcW0+aFxl?=
 =?us-ascii?Q?xlohVkEnO9wOSlxdIG1y8MofUFUnGUMO86ajgMLF414OQHx7700+blyEgDnP?=
 =?us-ascii?Q?ZGtinhWLGnS5+dJ6jwDrnyCLm+/IMGtLdnICFDQfGlxd92F6iNnhueeB4Oqs?=
 =?us-ascii?Q?HQQ8zhoHDh6NrLqupj2wVACZKEo+O7OZ5qDUc5YLXb7nBYwfICWvfXsM/dQq?=
 =?us-ascii?Q?UHlGNPVjipfarpdvNrfKXlfXcG7BD+TebfJZBNA/ZmXsJeTQYVvtEvQvXhsc?=
 =?us-ascii?Q?uWuzbGZhTicndbT5RoZ+xx9LYJ5KaFyv/6NfcX5g?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c04d5935-eb86-45a6-fcbc-08db048a0248
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 19:24:59.5736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KkhmShSondnzHS+EbgdDVkAi/7C6m/eKVK50YKoctsLwwpUj56vAjDJqjRWMowj58Lm9rpiLb+PUoDiiPY/NzQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4567
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Davidlohr Bueso wrote:
> On Tue, 31 Jan 2023, Dan Williams wrote:
> 
> >Ira Weiny wrote:
> >[..]
> >> > Considering MSIs are edge triggered interrupts, this should be benign.
> >>
> >> I'm trying to understand this a bit more.  So I looked in more detail.  I
> >> believe Dan suggested that I could use irq_default_primary_handler() in
> >> this case by passing NULL.  And this would handle threading the irq
> >> processing for me.
> >>
> >> It looks from a software standpoint this should work.  But the kdocs
> >> really imply that not masking the irq in the handler may be an issue.
> >> Thus the 'requirement' of using IRQF_ONESHOT.
> >>
> >> Is this somehow different with MSI?  Is this a case of the kdocs being a
> >> bit out of date for MSI?
> >
> >My reading, may be from the changelog and not the kdocs, was that at
> >request_irq() time it is difficult to discern level triggered vs
> >edge-triggered. So for the default primary handler, that does nothing to
> >quiet a screaming level-triggered interrupt, just require oneshot mode.
> 
> Right and it's only level-triggered that are the problem after done with
> the hardirq handler. So in the msi/cxl case we already know that all this
> is edge (sent once and forgotten by the hardware), which is why I was saying
> it's harmless. It's still probably a good idea to have it explicitly oneshot
> semantics as Dan's patch.

Ok that makes sense.

Thanks to you both for clarifying and to Dan for the patch.

Ira
