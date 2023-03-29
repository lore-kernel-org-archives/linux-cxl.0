Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82828C6FD18
	for <linux-cxl@archiver.kernel.org>; Wed, 29 Mar 2023 21:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjC2VkA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 29 Mar 2023 17:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjC2Vj7 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 29 Mar 2023 17:39:59 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4C53C11
        for <linux-cxl@vger.kernel.org>; Wed, 29 Mar 2023 14:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680125998; x=1711661998;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9rmtTWhCRWqr24ga2bh+pr2Cd5OW5Pi850PFS3ASuVQ=;
  b=gVcxQ4M8xGsB38gDy0lv3ZO10xyAezh+TZcw0FZk5VyuDPCkLnB+B90G
   ttRiwO/g7XGkcLKB4OyMM1d9/wQKDtNUINiBqRI3HVz4wmDBxPN27Wphe
   zQKJo+GkW26cP/kNCi4zmOqJHwLWL5lcbo0QRbSL+w1HZVMvcQP5rzhcu
   u/NTT/kXgmoOurpy0FhMKhc3q9p3UuCh736T0xlL5QVYZ5JlkmtbJwMFQ
   KLw7DjmmnUtgYmgxcD6mEfl28nJJmTc6qwzvpafEfhyqDzMPf7ufoYHwb
   cHAGv09SDaWfr4KfnliISRMPeTUq3+DJJKGkJ3S3uTAOmrqP3qR1Yxgsy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="427279576"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="427279576"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 14:39:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="686992805"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="686992805"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 29 Mar 2023 14:39:58 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 14:39:57 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 29 Mar 2023 14:39:57 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 29 Mar 2023 14:39:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZLH51FDvMgwhv8/0153UXFRtSBxwWuQWZHdKCkDD07wmPfGR//w684pnTh21pD7SAtCjWITXAXYOgqcrOWAhKaqgnIp7vBnA3827cJGNMVnCq5IRCi8DxIpF8jXzrB5sNUwiGh//LLyXjBsIcBQFq1YAMJayRGPUjoqGLW3IjgURRS6zvsEx+2Oj2MIWRZHgci/wGVngdvrcbZJjEbOSr7BxbTw9x1JmEoDF9rAU10mm4vbiRx0BxeKdaKsAL61FBb+jGXDFt9ALa6UJ/Jaw+4p7gzuyr3L1RWOjwn5mpQIxAX4aRaWGfkBEcC/M4ymFqk0CgfwuWungkxDYwDS+Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2/UZnKPmfTSiYUHsX7dnoE20cGss2RA24HvDevkWy4=;
 b=hFy6XsuvDrBdDeLpmelO1e/7xwtadPeT8ko8DGruA0CXIJmru0YbkGMomyoKC+VhI/g0plMMU4JQZtWVlpmO6uUWf12261P14oJSfpSG+qKKZKzyWqItFs8M61FvRejAjtVslIzpR2Dv9Cfo3BwAE3952spF+61POSmBHHWxIiEq9Xc6hIjFo+aWL5in0W6G86igEkuOO7xiVrMHc/T6TtjFvaRVEOfsg6bMKQK1af8L1AnTTjbHQYZCRLEQFLyNRUS9dZk07CSMmOCzs/eSiSWS9Cqn809Jadde4RgMTrpB7/r0htzIinxPgqQhtHT+6XPwolTZqmFlRiIBfdATSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB4807.namprd11.prod.outlook.com (2603:10b6:510:3a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.34; Wed, 29 Mar
 2023 21:39:56 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%6]) with mapi id 15.20.6178.041; Wed, 29 Mar 2023
 21:39:56 +0000
Date:   Wed, 29 Mar 2023 14:39:53 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Gregory Price <gregory.price@memverge.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <dave.jiang@intel.com>,
        <alison.schofield@intel.com>, <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] cxl/port: Fix find_cxl_root() for RCDs and simplify it
Message-ID: <6424b0295461c_c72229470@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <168002857715.50647.344876437247313909.stgit@dwillia2-xfh.jf.intel.com>
 <ZCPLJme6t+Vm9wXY@memverge.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZCPLJme6t+Vm9wXY@memverge.com>
X-ClientProxiedBy: SJ0PR13CA0088.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB4807:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b35a5f0-4837-48a5-401a-08db309e2315
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PGco+6iDmvSPGFMPJnd372INWf449+ebL1ls4ZFVZRoS9ExV66nGrH8/CJtrgwz48sAaXTNC71KlJRDHluuxvAXsALcFr5SgLPelKRNfq28U4j4ioI94NWrPQRRcv99LO6SdQr4AboQT+RPB/Ngn3dewnqtgTRFwFydC25PyXmaBDZHsh02sNTmFig2Jv3DX41rjvSWrbPSJrn8m6XC9bpwQbAlWpjtz6Yw1/H6QKM5B961eNLPKfIV3VqNZquHaUT/QRP2JtfBSzpOhTHUTfsRFj8RYRvgKBWP61fmvR+EOoC03Euko1jNsVJjXNKWBK5ktCL+XDtrLg3t7w1jSlcUTaUcVnEPQnejmEFar2iqmNjdfWlylPSeBJYrIKRDoZ8bBeNJTTOl3rIB0ahhCWKs4tcHCtF4/IvcsVw2wZ5HqER+C38wCDzAvpKFz5jPAAns7Ncndd4QVCiD4c1yx1W2ERE+8+FlfgZ9/q6FAq9HWK8rFTTGXfO24xjH0B6gChGPtzIkxzu5RtfQVBPfdBEHocGCgI17z7GU8ko7DXD4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(136003)(39860400002)(366004)(396003)(346002)(451199021)(2906002)(83380400001)(8936002)(5660300002)(6666004)(6506007)(6512007)(316002)(110136005)(6486002)(966005)(478600001)(38100700002)(66946007)(41300700001)(26005)(186003)(66476007)(9686003)(66556008)(8676002)(4326008)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KD9Nuj5QJyyz1++LxrRyClj13ofjR49JhQzVcnBCmhgqU1+21Q/xTXYxhb4t?=
 =?us-ascii?Q?L0mYOakdFGswQnLy5KSYke/92FZSaX+WdVyb7eMSoZk5Kc8NRAJePGpfAQ0H?=
 =?us-ascii?Q?9KrSZkY/Jn8J4ZJss6LSkbdp+8BWejRDFWWWKRkQJ1o1rte1NMinNebedJ1J?=
 =?us-ascii?Q?0EiS3j6nT5/RisUhD7X7ydsnHTae4bh/LUl84m/mPEmm6/0yxwzehJ45IWvJ?=
 =?us-ascii?Q?4q2/0St3KxlmeAoswE6lA1eHcghWM7cdCmxgHSKlN6VkCLEIBN+yr2znXrRz?=
 =?us-ascii?Q?hnkori1SdfLD3CFVChBwZnEJQ+QEtspKYPcUFMBrm5hzvcSEOXnzgoGdvpv3?=
 =?us-ascii?Q?OHvAa6G4cRtoACNySmO/1ymMht1i2RoBQ2cS4Vr5axMZ4rdtHywu0dXqZLs9?=
 =?us-ascii?Q?7MSoUF7ppq/HukbsXPOrbgZ4eHB/RSM9GLuJm3AjLOF3KQ0W3IdqeladcUho?=
 =?us-ascii?Q?HzSwJUPhbvOg48naPgWGC01RmH1gBbh7SitDTu37/K8/7sADVyNiggqpzWUY?=
 =?us-ascii?Q?azjKff/Vnlg6l27iy1S3/osLJya9jtN7gWvEPWEs0m042ndR0Sb9W3/Xz0nw?=
 =?us-ascii?Q?oQFdZbxercAt8Kqzpknb5awMMbskWfEjTi5UWam9JF+FL4IftJ7EZ/hh4BAj?=
 =?us-ascii?Q?rLZDgHA6UtmBDe/epu5CL+t/dum3165iofOuelDJ/UWpbIaUqSnRY9MXRJgP?=
 =?us-ascii?Q?VGORgBKsUoBgHfGhywhGsZ7jR/06iQGJ8WNw+0FGvImDoJVBk4enTMXo4gQm?=
 =?us-ascii?Q?QA0CnRZLv2b7fxR0KCVsSVpmhXhMsG559cjDCYU2cuhhnakb8P157LmC9j22?=
 =?us-ascii?Q?OKfP5CcGpEPzD+KoGnq8G57un87xV077aCdwQfHK/Nu1GHDx5g+VbSGC1/YO?=
 =?us-ascii?Q?cNCo584IKSIbpHa9jMXJBO3h1tHES75N0MEiov3gRKFzKLsLQQAW2DN35Ams?=
 =?us-ascii?Q?egbRALah2TJDO6t4aneC0IOuYPYp6N2rRBU0Oxcas1KEx0Cb1itw5PDDW5Ux?=
 =?us-ascii?Q?Au0JgFs2Tn6d7RfOlqPvaf5FIttdYskH/cKcR6A5lEqc+qhtMNCbAU0ixBWC?=
 =?us-ascii?Q?+Z+ObwLA9FcZrrliA0eNbmr4Bs69o1JmY+TapMoWa6SENwy45RoDbnjO2oUu?=
 =?us-ascii?Q?IeGmT/ZUOG+aNBLxdjnAcF/u2dvUdKs0mgX7zRQu3oL05rYA/5vBtem7nrjs?=
 =?us-ascii?Q?ey5Brh334Qu0NHptO5Wf2j9yPWc69a3SUvJR4z0Oln/BRKiDhmqanJGh0Aj6?=
 =?us-ascii?Q?tkb1xqJOAu10VXum0gbIUrgNNWfw4YSpPUnID8dWlKv9ue/6T9dTrYZZH3MK?=
 =?us-ascii?Q?bT+CCtla+x/39fL4YoC+Z8GqpibKGfcKBy1snfoXXl6xkzdNwUWyXmv6PTCz?=
 =?us-ascii?Q?diDbK8CDkPJ1GfKiLo+TZSneY8h3UYyiB6kJBrYtyxrzkoF0hkZVLQbus+hs?=
 =?us-ascii?Q?bcHyMSOLng7zDw4fVQdwC18L6qGt0v9Q3wBIJnkVC7B+onfZk51OCBhoi2Fh?=
 =?us-ascii?Q?OhQZ9qATkR4PKQAPcyqjYyD/knbvG4VCqUS5Hg1+Ycw8pnMzH2azIJmstZyD?=
 =?us-ascii?Q?BM5xAQZib6RLs8a2fz8FD1TMmQXxtDz7A43z+eQi8LdU9KrkWGY2KFojU9CX?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b35a5f0-4837-48a5-401a-08db309e2315
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 21:39:55.6649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mkkaYSWs6ABCLPVf4spoKxwlkMgYqj/pJmULerPhxbY+UaFa+JDX4bf2Zq6/vVT4RQAkO82vIeBU9zYHYzRV1LMkMXXLv2o1mrMdE6slhvw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4807
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Gregory Price wrote:
> On Tue, Mar 28, 2023 at 11:36:17AM -0700, Dan Williams wrote:
> > The find_cxl_root() helper is used to lookup root decoders and other CXL
> > platform topology information for a given endpoint. It turns out that
> > for RCDs it has never worked. The result of find_cxl_root(&cxlmd->dev)
> > is always NULL for the RCH topology case because it expects to find a
> > cxl_port at the host-bridge. RCH topologies only have the root cxl_port
> > object with the host-bridge as a dport. While there are no reports of
> > this being a problem to date, by inspection region enumeration should
> > crash as a result of this problem, and it does in a local unit test for
> > this scenario.
> > 
> > However, an observation that ever since:
> > 
> > commit f17b558d6663 ("cxl/pmem: Refactor nvdimm device registration, delete the workqueue")
> > 
> > ...all callers of find_cxl_root() occur after the memdev connection to
> > the port topology has been established. That means that find_cxl_root()
> > can be simplified to a walk of the endpoint port topology to the root.
> > Switch to that arrangement which also fixes the RCD bug.
> > 
> > Fixes: a32320b71f08 ("cxl/region: Add region autodiscovery")
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
[..]
> Is it expected that RCD's will fail when set to EFI_MEMORY_SP?  If
> that's the case, then this (and the other patch) look safe and do not
> produce regression.
> 
> Just want to capture this behavior, as it appears there may be other
> issues related to RCH/RCD combinations.

After I posted this fix testing revealed the need for a few more fixes,
now posted. Most importantly for accessing range register defined
regions is this new fix:

http://lore.kernel.org/r/168012575521.221280.14177293493678527326.stgit@dwillia2-xfh.jf.intel.com
