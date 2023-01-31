Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780F0C636CC
	for <linux-cxl@archiver.kernel.org>; Tue, 31 Jan 2023 22:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbjAaWLM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 31 Jan 2023 17:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbjAaWLL (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 31 Jan 2023 17:11:11 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017835B599
        for <linux-cxl@vger.kernel.org>; Tue, 31 Jan 2023 14:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675203041; x=1706739041;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5qk13RnMaKWwMVw/krBQrs32DGu/Ny/5VNNEiJL2jTo=;
  b=aW7r/BXmEIGCkI665jWodtg7yCU0Z8SbqzZraFojDzOB/JO0hHCY79RD
   37y8jJ2nfqxNuLn2Eol9RH2nSKgAjQQqUsMyiGZ7cPdLpElRpEzGLvVZd
   YdUT+h8C8AvlAu+t0zvzXvJxf0+MGnrq+uO1T8DPbzoGG7ZDYcJ8/R9d3
   CwAMMdy1M5DfZ4DRadf1uNczWQW3/HNhepIzgw2BVgwj5XLD0kSjxyUvU
   YIQZOVpp6hPhiPKZ2AErx+rTFaRMy6hLS693ueUkcNfA6Q00/WFLfo+ZD
   JJcd6ygHnCgvZhmF4yv87/KyC9N77n3zBrMoIR+9BdiiE5LHb8XETI5PO
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="315942380"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="315942380"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 14:10:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10607"; a="910070481"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="910070481"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 31 Jan 2023 14:10:40 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 31 Jan 2023 14:10:40 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Tue, 31 Jan 2023 14:10:40 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Tue, 31 Jan 2023 14:10:40 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Tue, 31 Jan 2023 14:10:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QP7xyEP8ov+ba3Aqphvtcwz6q3k++9r8X9s79j7HGwn+bJnIOJNHNy/wtIU+cWyuHW9csWIcQ+KfWsElzR+An0uU79jqrK6sSYopycFok+Y3D24ZADZlpcc7ltRO+xGw5yIRbHVtDe3up+RRptfjbhWOpBXm9I2O00zNVsysz79luSsMAS4CcrtZdzrj80wxzPZA7V0TTKYvmJcgZMQAEqUu+VGkas+Dq0JyVL/kyC7UJwRjs10utgz1LZP/DwWn8xG84GhiJ/q8dLfI/BNjGTYi/cTh6TBt7oA7bAzNU0t4BecVrFIfgZmaRfFC6YPeC0kw5caJ5vuUCxz/TuyYsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eI6+ijuVP6h8jv2dtJEtChSlYjNbKICE8qTYn/YehRk=;
 b=MkfiBtDee83NYFE+2NtSovVZeqIbBVsCXH1lLEFOlHjQR702IVjG8rVvumi9QSZb80F2ZKFWHCktEZ38ggk29FmUyogMJsJBZjg4a1bhIuK3ZQE3zZ6XxvbYrsx+ucKXXtFdLJF3C4uBXsWhhHuqX2agVywI4bGKbUPxN72LWaF64Te74a4mDZJQRyA2Fdk7C9s3JXGg9LKdcTUcFuF3QJ8Ka4JaPPDaI8FtWL+fp7SNTMBx2XWqkR3JWsvyCPtEfNPcocDdy6tOnQJuX7cz+QcX8A+SSVTqeE301sVrOOSQeU08l7Bus8Co5B/wjCisTaw8AxFs89l5v9lWabvKKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SJ0PR11MB5680.namprd11.prod.outlook.com (2603:10b6:a03:305::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Tue, 31 Jan
 2023 22:10:37 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%9]) with mapi id 15.20.6043.036; Tue, 31 Jan 2023
 22:10:37 +0000
Date:   Tue, 31 Jan 2023 14:10:34 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>,
        kernel test robot <lkp@intel.com>, <ira.weiny@intel.com>,
        <dan.j.williams@intel.com>, <Jonathan.Cameron@huawei.com>,
        <linux-cxl@vger.kernel.org>
CC:     <oe-kbuild@lists.linux.dev>, Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [cxl:pending 13/21] drivers/cxl/pci.c:511:8-33: WARNING:
 Threaded IRQ with no primary handler requested without IRQF_ONESHOT (unless
 it is nested IRQ)
Message-ID: <63d991da1c19c_a8e3129488@iweiny-mobl.notmuch>
References: <202301291620.DxnDWLoW-lkp@intel.com>
 <20230130215514.6cviyuwhxgjlzj27@offworld>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230130215514.6cviyuwhxgjlzj27@offworld>
X-ClientProxiedBy: BY3PR05CA0021.namprd05.prod.outlook.com
 (2603:10b6:a03:254::26) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SJ0PR11MB5680:EE_
X-MS-Office365-Filtering-Correlation-Id: bd114ff7-24b3-4aea-fbde-08db03d7fb22
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jf/knoeY2we3Ec5w1ucgibT47AM32h+GJjNqzo3sOSdd3HYbmlpdD2pvOl5EFW2pDZIHmWPeVM1VpoJq44nWG2E6qmIaoviqVJ2q5UAAQ5kLyThD9bbO0s4VVbL6202f9Ty5UkZQ5UQnfKKQ8SxTuB9H7TkzNSK3CqcJLThl1MdMVyqomnRNGcX3CV9Up2g1Y1cXgOQ06x8lkTZd8rxO+gNTAOHcQQY34I4Kj2v0GGHbp62I3CmejmFDnTavrHfnKysvS15gx9EJZdB4aF+CybNpkSc6/DgHkFHpd0Z7v5RARsfvYiCJtRW6lqj4dLwyT7gCKUiFDDDe01BXoPfV28W/qDs/1rdiIpMqnrJTEUeMtVfciVHFAVMRxPzEH+3LSFs/L8oeqquw9AVz36nhXbXibvytlWk7mpXniyWDYYjaGJCBqHD9afYSNGeB+0S9d84Vz2spwh9XoVo410HKIUrVKT0TSIURgY1uAt+Xjofzj4/aNIDVIctJga3x770SASRzaDvejzsxdwXvGVMDaI4Ey2qtLIOD+aDp/Nocxglzggixf9b7GRA5sqIM3TDF2nXUkT3KzuSvuixnWLWlyuM1WsHhXqNTSgItnS0Rb5ZRkXp7rG9rXzH7BvbwDO3SaKK57sSX4zr5yTqcC0u6bVRTmULK5KnpXSBCanS2OFKHFY/QgtN0N4p5fQwq5NY3WOyRaFWkUp4mOQpbqqtM1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(346002)(39860400002)(366004)(396003)(451199018)(110136005)(6666004)(316002)(83380400001)(2906002)(44832011)(38100700002)(82960400001)(66476007)(66946007)(4326008)(6506007)(6512007)(66556008)(41300700001)(26005)(9686003)(6486002)(966005)(478600001)(186003)(86362001)(5660300002)(8676002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B6k/4OZhWj7Zi+tphVPeF5yGx+2JMnyiMjCFF+F4OkTMY+PDJmdVV5JQhycR?=
 =?us-ascii?Q?KFPoY5xwAFyBF67qmxAUlMO6yKFQQBzMFfFQ29HE9N9xhNvDGdw9DUrVROla?=
 =?us-ascii?Q?CntpWOhkBx1VfBIApCR59xUz1VEGbsCTCwQg+JOjLPXQdx3UOMwodZFeXCYe?=
 =?us-ascii?Q?LHqFyQsOIVOpPbzUDpfqpg30CfC6swOei9/CSM6XLueZwrW6ytKTVoXFGCcg?=
 =?us-ascii?Q?KnUw6jtiyTI83ZTYYkX2P7E66rjoc5Pf/RDh4Pn0oufXop2ot/WvlcYxsUxq?=
 =?us-ascii?Q?S+ZMi3gjujG8WKzoTUBPDS9M7MfM+oQwQiKHBy4LQvQwiH1RvgkZnEjh1Skh?=
 =?us-ascii?Q?TZMXjMVpcezl8Y60EXM6UGxInUJhpnO3sccaTTmlwaRynkWB4VJdAs3rjb7g?=
 =?us-ascii?Q?AqtWlqMCEpx5Genv22z1Ty1VtJIpGuSSs6GLHxCtDIZ3pZDaNX/CK1rFbgBi?=
 =?us-ascii?Q?AZl/ZiG9O6p8nu8JWJZyJTJe4YcDMcAdJ53EbiKekRa4LkY/ZzmxBhvYLtBJ?=
 =?us-ascii?Q?IGLioazXDrhjunKrapq6TJfTCbtDd7K9+W60SDNm14K1uQoundX/XxyR6j5C?=
 =?us-ascii?Q?JKWCoyjAp8aIEcp+LKlLd1Aq71Vz5dZSfqeObNLTwtHxk1POky5q8AjYSfA5?=
 =?us-ascii?Q?ovp7qL3J8j4BAHWrh1ivD1uqjnjIt3ubXc2KwntE484HfM0IPIXXfKw6V8zs?=
 =?us-ascii?Q?xaVM2qQLzgnksFtNv9UWqlyPr8cgE4c09C5Fr4hUTPzisoDHyuQeEWkwlsgi?=
 =?us-ascii?Q?LSDbXfqi0cB6QrT71A2R7mvJIHJeRAvsAA2Cpc91C1tnk0PTcXTZyBcuj+fs?=
 =?us-ascii?Q?U1E0zFMVfkFdDPr8UV4sTRajhUopyagMgHvl6SY865ENslTb3vaBt5IX/tc9?=
 =?us-ascii?Q?KHBcZLgkRhCcOeKmJEA6bVu5MWYEh/tOQwIiglm/GCdHDnpYBfBrJoTlAosz?=
 =?us-ascii?Q?6iVJyy3XLfOyzz0RuYesymrVANWXFk8gPchAUhzoAe+ILtVE4uHJHCPt6uIr?=
 =?us-ascii?Q?qdvfK+7cWnQg5j/8PDmDktd92srQtYFCqKYefr7cmRDMPhWvAF/KAHjZdf5o?=
 =?us-ascii?Q?t/w+HW10t9bTLoLy5puAiCetcEp1qjfh5uiu4kzz41wdzezjQ+WED8pyeGxu?=
 =?us-ascii?Q?O3l4SPfOJ+3ncRJJq7BcOcg3phEdNg9EQ1lewl9ueRQPDICyHue11MS4s1ii?=
 =?us-ascii?Q?yQ+fHJJzaR8r09bg2JxLj2O2D0EJIulMaNiS/444fn1DsaeWL0Isqy5QMPap?=
 =?us-ascii?Q?RH3P+QDZhxrvqvGCtghr9ZYl/+wfFlZsT8voqL3b6fjCFqFm2mw7aAQGx/F8?=
 =?us-ascii?Q?RyCtBYajg/bMBJgP4/A4US90DmkwZc3e30HaQZ434+GlsQYTLYy9BbXB+oq3?=
 =?us-ascii?Q?Fdpg8AuYZA3hlEbdauiOpB0QQN6MlHO/jBijDXEEPwKgjQc37hWLUqsGmUW/?=
 =?us-ascii?Q?669oZVi+6qLj0FrmmYt75CHDb6dgox0k8unayEj6cu38EwDZjAy63324lZUA?=
 =?us-ascii?Q?07EcUaLUqvTTzAe3WxT1eNmRvYQ1kmftaIvYCYPZsbSO9l7X2BXRtDzfiyv2?=
 =?us-ascii?Q?Cf3sj4eiRn1D5m5lBdWPbc6Trqk0pPpIVyYXOIH+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bd114ff7-24b3-4aea-fbde-08db03d7fb22
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 22:10:37.1470
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TWmKIduxlWlvwq301H3bmkzfxmpGGSZ6Picd2JdmnLjBGm4oZwFbbZqqrBYH6jb277nU3fiMUh74Qb8SFN2VWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5680
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Davidlohr Bueso wrote:
> On Sun, 29 Jan 2023, kernel test robot wrote:
> 
> >BCC: lkp@intel.com
> >CC: oe-kbuild-all@lists.linux.dev
> >CC: Alison Schofield <alison.schofield@intel.com>
> >CC: Vishal Verma <vishal.l.verma@intel.com>
> >CC: Ira Weiny <ira.weiny@intel.com>
> >CC: Ben Widawsky <ben.widawsky@intel.com>
> >CC: Dan Williams <dan.j.williams@intel.com>
> >CC: linux-cxl@vger.kernel.org
> >TO: Davidlohr Bueso <dave@stgolabs.net>
> >CC: Dan Williams <dan.j.williams@intel.com>
> >CC: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >CC: Ira Weiny <ira.weiny@intel.com>
> >
> >tree:   https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git pending
> >head:   ace4b76d4ab70335cffb5a1c8450d3b34c16771a
> >commit: a49aa8141b657a7fd33d86f7bed3ca07567ab37a [13/21] cxl/mem: Wire up event interrupts
> >:::::: branch date: 4 hours ago
> >:::::: commit date: 2 days ago
> >config: microblaze-randconfig-c043-20230129 (https://download.01.org/0day-ci/archive/20230129/202301291620.DxnDWLoW-lkp@intel.com/config)
> >compiler: microblaze-linux-gcc (GCC) 12.1.0
> >
> >If you fix the issue, kindly add following tag where applicable
> >| Reported-by: kernel test robot <lkp@intel.com>
> >| Reported-by: Julia Lawall <julia.lawall@lip6.fr>
> 
> Thanks for reporting, and I'm adding more folks explicitly to the Cc.

Thanks for the Cc.

> 
> >
> >cocci warnings: (new ones prefixed by >>)
> >>> drivers/cxl/pci.c:511:8-33: WARNING: Threaded IRQ with no primary handler requested without IRQF_ONESHOT (unless it is nested IRQ)
> 
> Considering MSIs are edge triggered interrupts, this should be benign.

I'm trying to understand this a bit more.  So I looked in more detail.  I
believe Dan suggested that I could use irq_default_primary_handler() in
this case by passing NULL.  And this would handle threading the irq
processing for me.

It looks from a software standpoint this should work.  But the kdocs
really imply that not masking the irq in the handler may be an issue.
Thus the 'requirement' of using IRQF_ONESHOT.

Is this somehow different with MSI?  Is this a case of the kdocs being a
bit out of date for MSI?

Ira
