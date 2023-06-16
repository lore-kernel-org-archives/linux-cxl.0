Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF984EB64D9
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Jun 2023 02:06:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbjFPCG0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Jun 2023 22:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjFPCGZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Jun 2023 22:06:25 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BEE2135
        for <linux-cxl@vger.kernel.org>; Thu, 15 Jun 2023 19:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686881184; x=1718417184;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bTzFcxH2N3meaU9f5xVtGW22wZxk0ayrluTrRKvnKVU=;
  b=RoRurPbwVV+zxx3w6L0bnmDd8cRUBbM+XXwvdTojNwKWofKAcML/u9oh
   TblDVj/Uv0hx3DvS1YmLip/y9Rg9qlnmRF1SplfMacGJmJjnBlIfdjqMc
   P/lLgel8VnTOu1tUU2A2fnxl+yRc/80N2OcxS3FWXVj5boZLCIJZVNyvF
   Hu7mhsm/SaNjRgdafsD1ydBgOG+Vlk0W/nVJhcrYgtaDgqKY6sd7iIvIH
   KSTbCnAZoBDx7ZEUBpMu2tFXhCUDvEmlE4VCEKgfwGFUtx6UBYKp+ATk6
   B51stl/EIjKwM2WosXUjxfmIccxC0DE/CNARpQO6f4/3hHC08Qw4Rgjn/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="343832233"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="343832233"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2023 19:06:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="706902926"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; 
   d="scan'208";a="706902926"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 15 Jun 2023 19:06:23 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 19:06:23 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 19:06:23 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 19:06:23 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 19:06:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EMzqOpy0z3nO+BqJ+jEQ/hKJxfw+gag/bIKiNNX+zIqrXgyTlgL+6Gh3tqJPpvRRiUwaw9GldexV91trpyu+KvMdrbO5m4exenZoOYPacFZ9Va+Vi77EBYc0y5qFgXF2b+x2I/tjFsJZxkHibcpk/yAGzcaeval+uYq6UBNsDEG45Ok7HYbq1IJF6iVoYlfT+0//dkjbxe+WxZw9Z1xWORt5I02KC5F6L969ct204GJros5XTfIDX6bkqpys5dICR4d8ME138KNP4X49zhfCU49d8aM8jF2tVA70qiWHz6C7z3oft8D4XMQL8RcFGQA+q7uLG1STBjR1C4rDxdnPVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=frkOgU58D6mFFS4hw9Vn3dltGzxlJQPAXd46HRfzbp8=;
 b=NAp02KH8HDF7gXIxK4HqeQ6QCHmT5VU2EYIZjm85wEG4PLeZa/albiMAVNQ7BFDD1r+t6ACeNiEW1zp/aelMq9WzmLrnHmTwTvmToFURxbUxCQ+E/h6DwcSMrUH7BYbPX9/RoIxTRe1vGPouKOEK4NpG+OsNdHYFzO3atk2lmPo0wxnVWQmo9wXBJmPG0vb3o/gi+VjQOLTF3duwSNob797L5y8HDGdOb1ncfqxyM3Ch3cfKH6aErkSxtcP+ewmSBKTZhwWcdQsFc9hTxe79bo584Bn9mz3g6/1oQk2L+KPN6XAwHpB38B8rgFgrSMhkUUeiZw1gU3fGhSHZu0K/JQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA1PR11MB8376.namprd11.prod.outlook.com (2603:10b6:806:389::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Fri, 16 Jun
 2023 02:06:21 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5%7]) with mapi id 15.20.6477.037; Fri, 16 Jun 2023
 02:06:20 +0000
Date:   Thu, 15 Jun 2023 19:06:15 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        <ira.weiny@intel.com>
CC:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/5] cxl/region: Add dynamic capacity cxl region support.
Message-ID: <648bc397c5380_1c7ab42946e@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
 <20230604-dcd-type2-upstream-v1-2-71b6341bae54@intel.com>
 <ZIpZmn69Z1PyVsED@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZIpZmn69Z1PyVsED@aschofie-mobl2>
X-ClientProxiedBy: BYAPR05CA0085.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::26) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA1PR11MB8376:EE_
X-MS-Office365-Filtering-Correlation-Id: a861b9c0-6002-4631-9829-08db6e0e46ad
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PzuqwbwQK9c1UHxisXzzJ3TCSFtHfAWAk6qmro/slzc3aMPtuoIc1q8so45e260payUG5C20SyWye0zc3uEIzepvOpN3vJ70psU6ZVHYfdf/xugpZOnpyNbCv4XTnf20//3gwDr/DQp1DWYbtjdDGBSIMXShNxvPtu12nbODHSDXHQ+f4GHhJfYXoOvO1iAnIKVSQZF1qCHMG14W34tQ4XQtPgy1B/80eYM4Q87XjFvtOMZN7bOQIFfjW7wG1eKqP6sEP5nHo3EB/iPKrsPgYMEtNE4ECVtBL0sH6z3a9vHQeopi+glxMVguwr8z0EYjVZn3KuCUIZk7zmGXPKxC9k3EjQA+twQzmgqNickPcHnm9ODs/siHMWLp3NSunaWRsTCm/7+QSUW/BxzLnqDabWEqVRK8DPLc7HHyEu2RWhTAscl9NqTbgAFKQHayY1EhVA2bIu+YwuIjoA0+srMM2xvhTbw8dUzdM0w0clCKxxLgMlNdVX99hOlm5vX4GaF/v2wF+ZOrVquhTupXNgLgeThnAon3c6t3BKK3jAg3Y0psvTBM0YVEbCErYC3/RKgH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(346002)(366004)(396003)(136003)(451199021)(54906003)(478600001)(82960400001)(66946007)(8676002)(38100700002)(41300700001)(8936002)(66476007)(66556008)(316002)(4326008)(83380400001)(186003)(6486002)(6666004)(26005)(9686003)(6512007)(6506007)(5660300002)(44832011)(86362001)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?svaRqkH2kAhYRp3f5++uYNE6XT7B0AAPkw89Ymo5JWcYi7cZletPX2dW2yeI?=
 =?us-ascii?Q?KQBH+BCp2C9zyRKtMsIbhGjxWx7k6//6jmWT1VaZGKvRpHDW+t4gZI3sd6yH?=
 =?us-ascii?Q?rsrMNE4Lg68oJoBky0hfBOb6sPDoc+Ay5qKppHpTZYsyLSw0LxYeEM4pYdkC?=
 =?us-ascii?Q?dax23OFMkYKQKN06FjsIfx1+p3l8n3dpWN91SVIapzQs6AzeTf0g5XZutB7n?=
 =?us-ascii?Q?GQKK7uus5SdVH6pvHxHOfwiFV96f8J2/9ZcJPdIC3dXcCU5v3KMyFSVauwjZ?=
 =?us-ascii?Q?5E3MdGW1cfDTQRS5f3NjH0QW8TYG7IuTrZc1X234v1p7g8/PMJ+iH76/Gt/m?=
 =?us-ascii?Q?+ywjwITSIj/odcQF4H99DHNtF3wgabEWvka6RdegYrl3AZUtnA5/Y9vcWkyk?=
 =?us-ascii?Q?8M/Z26hz/3EV8B7Msuj87Rb/NE1uopCEGl4z25nLKGBo6wNes9fcYSA8GKYS?=
 =?us-ascii?Q?bKVDnNZYb/7+UtZua2KGgb8zEQKl66aTEfC3tVda5a3jHUdXzf+DrqWiEm32?=
 =?us-ascii?Q?jT4UDCLoGBSnuUBt6Fp9QV9Xq81shFTr6xZMVUvlU7Zi9K4Ze75YCu7mnkW3?=
 =?us-ascii?Q?0baE6YoEmKK318P+pvHY19j7APGVnR+8R6DZbu0wTtNiBJDswrnn31o4PDJ8?=
 =?us-ascii?Q?qPWpb/jgue5yJSKs7XqNbGGoEPuUD2u6gLEYwSouT7xgVktyB1dQHzFyBvj/?=
 =?us-ascii?Q?4AnO/4H0xkHw9sQPcPDGqTiyA0lFCDKG81uiFmVPAaH0r84Ea/qancYBzUXn?=
 =?us-ascii?Q?bzP4/SX1Mq20KyUUPRxKmFCauYV8GbY/KrqcmTyVle9YCLYIE/w09MYGwloO?=
 =?us-ascii?Q?IxkSxK4Tgs1ySMv0KFj9sLF+mMtqxNHGP6qSTcsStCphbxsePkr0WzHOOAsy?=
 =?us-ascii?Q?Y9nA20oU90p60MPbEX+euCNYypwa/FMnprrR1BQjuRy7PGeEgXBEusXuOAtJ?=
 =?us-ascii?Q?W63F9y6IcHOy+3HJ2zEnCKRclGpFJNN88hRSAl0rlKFroYVTwPpp3GNuZ06y?=
 =?us-ascii?Q?Cd6tXpBM1DeTQANSlQWaxwXviGofQPZ6xL9whWN8cNfhW/+SeSjFAFQgqfOe?=
 =?us-ascii?Q?UUeHjnGfNxIxQO2vm3dOOBfICYAUVeH1XlAcGD65s6px0b2eSJSPmTDlMYJn?=
 =?us-ascii?Q?+AXMVNDk0r+2WWmxC9VpOSOy72hW/cE1EXyJePAaLZi96A53Hnm+6pPEWxAn?=
 =?us-ascii?Q?qF2f3lDaFuhHlGWcHmFjZ3dePeE7Hoe/0l5UsZ+FUu7ptKxV011Kb47gqtEA?=
 =?us-ascii?Q?TO2Cz/t7dJFRaGnlStSG3Ie2OdjtkHhf2tj5x5sEusfOm+e8hsg/ZHs6yplx?=
 =?us-ascii?Q?AVU7FYn//9r5mDJDDAR+9CaCxFqW+fDUlzmrOXPe6ahDeWyLg3ONjLXuGDxi?=
 =?us-ascii?Q?FTAK1TvbIUpWY89Bo7Ym2qyAhJZcu42Na0Ka0gISR792ywkEW68APcL1q2gZ?=
 =?us-ascii?Q?IM3YuSqr+SunFS46fCFyxnbhVw71Igc5TbGrXjpnySLNkVHJXVe4yMY+W4WF?=
 =?us-ascii?Q?cZ0rcYTicejQXi8lfG00bWUGvPxcCQ8YdBZkORNqDTALvTeM3U+sePkVfLb7?=
 =?us-ascii?Q?77SzADltH0guuFVEY6MnYRvypeaOmvDh/Tofrbd6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a861b9c0-6002-4631-9829-08db6e0e46ad
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 02:06:20.0959
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4HuoA8WIgJ/mPe8PwECsHP1sMDWHatQ971M/Mc5q+RUpP/vRMjdhkTQP7xzXed0eqjQeZ1JbiobVou6NectQGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8376
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Alison Schofield wrote:
> On Wed, Jun 14, 2023 at 12:16:29PM -0700, Ira Weiny wrote:
> > From: Navneet Singh <navneet.singh@intel.com>
> > 
> > CXL devices optionally support dynamic capacity. CXL Regions must be
> > created to access this capacity.
> > 
> > Add sysfs entries to create dynamic capacity cxl regions. Provide a new
> > Dynamic Capacity decoder mode which targets dynamic capacity on devices
> > which are added to that region.
> 
> This is a lot in one patch, especially where it weaves in and out of
> existing code. I'm wondering if this can be introduced in smaller
> pieces (patches). An introductory patch explaining the DC DPA 
> allocations might be a useful chunk to pull forward. 

The patch is < 800 lines long.  And would be closer to 700 lines if there
were not 8 different 'modes' for the various DC regions.

It is also very self contained in that it implements the region creation
for DC DPAs fully.  And I know that Dan prefers patches larger if they are
all part of the same functionality.

Dan?

Ira
