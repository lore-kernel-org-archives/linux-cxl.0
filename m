Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 096EBC76188
	for <linux-cxl@archiver.kernel.org>; Tue,  4 Apr 2023 00:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbjDDAIf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 3 Apr 2023 20:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231468AbjDDAId (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 3 Apr 2023 20:08:33 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB2E3C14
        for <linux-cxl@vger.kernel.org>; Mon,  3 Apr 2023 17:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680566912; x=1712102912;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=kAphUKoMSJlF3whUDEyzj2wjGeE5U3I1sjjrlT26QGQ=;
  b=f4Le11QT3x6CR4f8YU0IYmOw9Fan8TT0PzhWt4vxLQWmMwacfIUv7nFk
   352f/GU0sWkDr71AaCP3DachQcfdmUfydfIY4ZpdXAePlAJTyrYHbolro
   i7tRQudSdrfhIqsf0DFfRqtptYTcVKPwYnnM1POIJoojJU5FP3QhclMHA
   GpGSv9kQu9R4re6Rl3IFTvoKJK5fzz7/+GdKa1V1f9ivBUrubOuySw+ao
   f5aHwBSH0I2rKJJ4xP0P5VgPX2MeImB3Kmf9PlYFKVPxXLlmJ6ggb/iNK
   dR0FIP67QU25igKnM9r2aEoRZyf1AJeiodB4RjPClQxN+mwhEZScFNTS2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="404807227"
X-IronPort-AV: E=Sophos;i="5.98,316,1673942400"; 
   d="scan'208";a="404807227"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 17:08:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="797284389"
X-IronPort-AV: E=Sophos;i="5.98,316,1673942400"; 
   d="scan'208";a="797284389"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga002.fm.intel.com with ESMTP; 03 Apr 2023 17:08:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Apr 2023 17:08:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 3 Apr 2023 17:08:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 3 Apr 2023 17:08:30 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Mon, 3 Apr 2023 17:08:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E69WIFCERWOlcULxoGVMyd0Uu6R7XkrdWNvbA/LwNsRn71eP1KEL1UhFUjrdEPW03zpIuXUk2eUF47KG1g1ArkCDi3NKFjujeueU4LGbwRphLK7o360ZZTMVKaYRM3FrhhebsELFehSRHOi4VM0M2lO9yBeX4CJSv60VgrB/a43eyMVd8QcQZyzWkhxBWDhQZuxjmWPnjOM9t7J5iMJcRbe61kNYN2D1yghdlNTj49iQ+uu5kNe2mCD65Mak0YVRYs+Y/oFm/a5Q12j6y/8fDkUZ/wso5+IF2wjZnRfTAV1+eJJJVW4PYLkTKDM81uMyNanOiIjJ4vnqbcszk++vKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/M9iJsfGx8Ad7Lx+v6hPa/tBy5eN7VQVnZ/a8DeAAq4=;
 b=RhYqdtPEFKEQZa4QDsyQL356vUI4/Qw/XUiHEE4YRmDcmjVGU7HfmDSKIgXoMavf+Gzj6yCcax+SPMeA0R19sMW5cFY0JX7Q0IGGNeze0JAplnFqouPAHjFp1skjYsF5IJZZF1l2HgQSZ3s+7NLj+cz2PXZAnwDAOXWnbQ7/or3vBrpJjs9leMDlls632SUdzUbUv5VdTOhkEDnVI8unl9Jy4AbDXTTi0V2cDH4fuZdG5YAkNq3s9KsFfjMRJqNJOajHYYyrQ0JqkChp7TQz7YoWpmMJn6A46aNGV9O6eLTwMRmcFrSh9I/3vxxkNQFJ0o4jGm0KZvqAkdJvTJsG+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CH3PR11MB7201.namprd11.prod.outlook.com (2603:10b6:610:143::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6254.33; Tue, 4 Apr
 2023 00:08:28 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%5]) with mapi id 15.20.6254.033; Tue, 4 Apr 2023
 00:08:28 +0000
Date:   Mon, 3 Apr 2023 17:08:26 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
CC:     Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH v2] cxl/hdm: Extend DVSEC range register emulation for
 region enumeration
Message-ID: <642b6a7a3b806_29cc29486@dwillia2-xfh.jf.intel.com.notmuch>
References: <168012575521.221280.14177293493678527326.stgit@dwillia2-xfh.jf.intel.com>
 <168056315526.436217.14417826023537916154.stgit@dwillia2-xfh.jf.intel.com>
 <1dc1b324-8e77-f98d-3fd0-a20cbf328d2f@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1dc1b324-8e77-f98d-3fd0-a20cbf328d2f@intel.com>
X-ClientProxiedBy: BYAPR06CA0020.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CH3PR11MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: 1421dc61-5967-4880-edc5-08db34a0b755
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: crpvIzUq8IT+7Mcy5MDmJmHXv6yzv2eE2z4n/l1gOO+E2bIHnHePhSmK8f05Lk5K9DCJ2evHXiyl2hQtJInGrgFllXqdjUIYLcgWjQOxmLfwca2vW4NlZz3GhHLJ4p34DLlR39XRiPkGsoFydCFr8gLMxydqgZDQCoQqIg+U5VxOHw8fNhRk47491zzN/s1EVN/P5amBoIG6aR/DyyWT2p+QcCk9u9Gvzv0ujOP5vEtt/1SNwHxHqyrxu/JOBHakBY2Cd/e2d6i8tV+CooL83xU958TXRCi3FFpku8uihuTgfLTBGqi+SwHWJmH5hZKN6F/qXXGk4GR0i0XaXH628B/WQC0obUyOChHhEFPf8XDnyQkXQzYrdVTlhMm63mIHcm+X5QlgKxcQnM9LlJcXqHJ93QEWoeYH9P6rJh8No6pkt9igD3Rb+9bhtP2wMYr7BvigDpmbrG3CPc9zILDspeCFw6XDNQQ1UeE4zHAHE0p+c0jC2r7qjAKRioZSw3CfFDI2lLgJzOac3sULtF5ZOYtEzB8Tz55Aw2IcpgXDj1WOVD+/6M/yStL4QiN3klN8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(376002)(396003)(346002)(366004)(451199021)(478600001)(4326008)(66556008)(8676002)(66476007)(66946007)(110136005)(8936002)(316002)(41300700001)(82960400001)(5660300002)(38100700002)(186003)(53546011)(83380400001)(9686003)(6486002)(26005)(6506007)(6512007)(86362001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gyl1dG06Cg1TzUb/tWW/NFIwnGVvzDEgvGsPjO2PQrZTmEOUyuolnvF1nIYi?=
 =?us-ascii?Q?2OnjfQap40RHOztiUYQRo9oRK5u1ITb7VGetD9iPF23Hj3up2bZQZf+fsa2H?=
 =?us-ascii?Q?S9veu1nmc3Dp7iomyNwcDe+raMBq/+CdXsSAzdcQ2oRg/6bdF1bFM+u2Tcy1?=
 =?us-ascii?Q?nc96al5lSqUvwR9s0fVENt2InV2VMStEjTre7rGA6zXG7XTqb8G4HmucACmH?=
 =?us-ascii?Q?RCzwOhqW1ivdj5FLRgbAp3aGxsxlOMRXoxIK+ChrIMihM1wflRI6Bz/WBFuB?=
 =?us-ascii?Q?JxLEG0HsmkEvQyLMavPrvgYQaQAA40mmo8Y4cNQRSbahhTsrzUEznL9eZljd?=
 =?us-ascii?Q?bjQ1y6Sx6KVSlwKVSL1mEeVqyJ+5tNkEib5wuOzTYXOQlVXqndDKl8e5UAyi?=
 =?us-ascii?Q?RjEnnWCbyAljDD2Slj6dMKQkiKv2mBg0bVX5YdapQgPoY6fBni2Z099uW8vE?=
 =?us-ascii?Q?pqHrG2SJXgLll89Yyh7YDfBEXc7qriUwUuhz73bu96kxPOZPuhlWCY5PtpGp?=
 =?us-ascii?Q?65X+WNFD6yo98B1BHBvfSgnclbG0KK5QUolKoBqQSx4bVJRslCZL/9TjyHf1?=
 =?us-ascii?Q?VtAxaaPE6tKEWttOh1kKRwE5vpLt5zH89NDTXZGX0McJ4vhzbCrHmOTgPS1s?=
 =?us-ascii?Q?ShKwVglHRU9v1eN9wt6ZfC2pRAkpZ8Kq2NgXooIyQZSTwOD5bKLA1geYe1Vb?=
 =?us-ascii?Q?vjYQ15DIOOsOBsEVkd+qqVLq1MhZl29TuWyiEc3cYWzWOeN8SEJT5vPy+Shk?=
 =?us-ascii?Q?rS5izlZgZIicQsUix/6QvH/rR1Fhq6t6EHUa2eCdJjZH96I/NHdIoLs09o2o?=
 =?us-ascii?Q?tXvT9FZWASvWmIVxHf6q1pzXKamCJQ9OIu5V5KY8EORXME+IRe4KxtHU7vpS?=
 =?us-ascii?Q?Uxq4OqFvN8mxRDdnWT2mwxs77nJ+iEDswRu1sOZj/GwrCU5Ui3AjBui+Vrn5?=
 =?us-ascii?Q?3gMT404tjSejcPqOblGSPreRrdg1jlNs3XQmDvCTrbBAu8V4XN1Wi/ZyGET2?=
 =?us-ascii?Q?zImXsL/MFSo9uTbnu/az2zvHgAPeW/pCyEsH8a+iJ8vXsLI9utzhV8ov/0Ru?=
 =?us-ascii?Q?o2RJwQgAh+KxU1nv/LL3ty39gcz9SVOZig3Rhr+zoTMYH8iOvaOXgcMoNzwW?=
 =?us-ascii?Q?4lHVUiN1JeX9yqAphqZhhDgekbMugoyPQ+UiQIpKoFg++A4sv7dTlM4l7iAU?=
 =?us-ascii?Q?7rMrUDzcbT6k+wUvzMkqELVOhBVDucr1dydyBzNgVOE30kJFLXQ3BsckUXUc?=
 =?us-ascii?Q?bxU6ZOXjN3beZNJnX8d57ysBenFIrj+TA4Zp9Gb9IZ9CCxBrboHJFB2DVEYa?=
 =?us-ascii?Q?w1QWfSUSmrkBw2nDEmyS0kI/tjUWD/TwQEWB7b65Gb9vfGcUtE3dS5HOlFFs?=
 =?us-ascii?Q?GPcSO80M0cJeuPU+ydWo2zEFX7jRGO27CEYhAK06IIfg3ZJFC2ptWK50JbaN?=
 =?us-ascii?Q?WDyEQWxtoKpfuacsiSj0AmWAaVuEA1ThVVhJczB3bmrfQx5Rpe4kfc3v7uF6?=
 =?us-ascii?Q?V3i2VF1g/rQW6wweyuHlkTuOMKCu325ajmI6MRfjX9GAyAzb+58uRrG98PjY?=
 =?us-ascii?Q?QxTgEt+3IJsMuIHZXpJVzElWB8Ek1oybil3WNAj6PS9h2IY+1tVux4MCP9bh?=
 =?us-ascii?Q?rw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1421dc61-5967-4880-edc5-08db34a0b755
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2023 00:08:28.0357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WQftq7uHxsg/rCIsPMuA/ELpudriWk/xxgFYfwdVgxIfGZWxEiaogJG8Ci3dEjqVz5Y+NwfhUjlmHlH0gbSCp4YITVvobRLbOmJZ7LJ90Pk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7201
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> 
> 
> On 4/3/23 4:06 PM, Dan Williams wrote:
> > One motivation for mapping range registers to decoder objects is
> > to use those settings for region autodiscovery.
> > 
> > The need to map a region for devices programmed to use range registers
> > is especially urgent now that the kernel no longer routes "Soft
> > Reserved" ranges in the memory map to device-dax by default. The CXL
> > memory range loses all access mechanisms.
> > 
> > Complete the implementation by filling out ways and granularity, marking
> > the DPA reservation, and setting the endpoint-decoder state to signal
> > autodiscovery.
> 
> If you don't mind making a note that the default values of ways and 
> granularity are coming from cxl_decode_init(). Thanks.

Changed this paragraph to:

Complete the implementation by marking the DPA reservation and setting
the endpoint-decoder state to signal autodiscovery. Note that the
default settings of ways=1 and granularity=4096 set in cxl_decode_init()
do not need to be updated.

> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Thanks!
