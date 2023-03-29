Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A31C6FD18
	for <linux-cxl@archiver.kernel.org>; Wed, 29 Mar 2023 22:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjC2WVu (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 29 Mar 2023 18:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbjC2WVs (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 29 Mar 2023 18:21:48 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B8F59D2
        for <linux-cxl@vger.kernel.org>; Wed, 29 Mar 2023 15:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680128503; x=1711664503;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=aUNNMHU6O1Uytx5BZgx9WEkjXNA6Vbrx00mo6d8FwE8=;
  b=ad/zevMx5suxUTgSr7CfXp7wbx6d1vDfSd6NAdPsKR/oOiXg6Zj1WMUm
   68R3szFZoQeLFTXuJ1VZkoe2VLO+TEfTgLtynWDzwiXEottOhCnQEx34W
   Ojyk2Xgbw9Z6wrPQ1nRbtZKQNvZz5O+n3VYnGPDwe4qL3HppTBcwvJRy3
   c1xtv7Os+ScnwNHx4UH037KZM2/HJ/V6oRyJAJkdP2RgQeu2gXvpXT1om
   L/nRr0V4LUH6dDOIFNlSL4aJsRTvhPx4PE+rUmhZQwIfo3U1VHlt5LlIo
   r0CB7kBFztE+P0NVjfGPOwbkEBEW/rpMXv0TZLDU8kphMIOsGXnYnNyEY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="405966624"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="405966624"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 15:21:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="808398020"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="808398020"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 29 Mar 2023 15:21:39 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 15:21:38 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 15:21:38 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 29 Mar 2023 15:21:38 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 29 Mar 2023 15:21:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X3vylNOUtSt3yoE73aBM1bSWkGy36w34O+L/Og9+umt8DpKvcODRC+ldF6vPSTvV9Z6KVLpH0TYUKKDfj+8EOz9SFWmLUzap492ByIs+q30ml+wi/u0gl1bfHU/WLLSCFjWpH+h8J+jCW0GMZUolgltTSWtCs6o9kvxYlmRIiBnYHF6Bm7TpgJScmva9isNt2cMEqdAbCTJBxdNnwcgLASU0mkd+a58D7CiGIsuU16nW0xboAETesJ5l003isTHjUBDTlm41Ab9UYr58mEDir8g6voR9w/91TgTGc6FvEbXE6wdoEvkjn/jPaChrHOpqKvTgz3B45KYtleM7dx2EnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YoTKK7FuFLHyCBAprzw7aVtYUZIc8ghoEBq0uB1EhgM=;
 b=RQ/wPvKq2tOF2UmeEW4YFbKsCqK19Tne2nqRtgXhfZUe27baGujNHmYODZDY1cpXpBzqmdwtAGjC94e8gY0ckeilsVpXy48WjMv5P/5eF3YRLafvAw/A2F5WYAeiMJy81JZJoOCGUjNrm+TnzHLCN0qA5Dtn22qixwR3rCFezcQvWYIKlPrADLdgHIPXRJA9hSBXSqb0fiRCmks6SJrQBinDjgEenzsMnnvVfqh/Lc7RAK+V6SwS3aRLkKxrqWiNVqkEFmAZ9kLOENibm+NroXlMV+CHXxNfzcKmMmBneS5qe1mK/CktWyPXdmuzAUwZZulruIEN9P2cQqXrm7G+gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM6PR11MB4643.namprd11.prod.outlook.com (2603:10b6:5:2a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 22:21:35 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%6]) with mapi id 15.20.6178.041; Wed, 29 Mar 2023
 22:21:35 +0000
Date:   Wed, 29 Mar 2023 15:21:32 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Gregory Price <gregory.price@memverge.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <dave.jiang@intel.com>,
        <alison.schofield@intel.com>, <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH] cxl/port: Fix find_cxl_root() for RCDs and simplify it
Message-ID: <6424b9eca6bb2_c72229462@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <168002857715.50647.344876437247313909.stgit@dwillia2-xfh.jf.intel.com>
 <ZCPLJme6t+Vm9wXY@memverge.com>
 <6424b0295461c_c72229470@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <ZCQSnlEmhGXF5gnW@memverge.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZCQSnlEmhGXF5gnW@memverge.com>
X-ClientProxiedBy: BY5PR04CA0026.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::36) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM6PR11MB4643:EE_
X-MS-Office365-Filtering-Correlation-Id: ca63e0a4-3bc9-45c0-b064-08db30a3f4c7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 70l2h8ELdIpJOXDsBA0IRDv3WAct2vlK8DRLrs2CiGJczKMqETN7tr9m2BUDNQlA/QYAmIHSS0Sg9pUdVZ785ucCsjtY4ySEVsMOY6HY5LesBJDaMSo3463sw/jrf+KN4LBhrfrQxtZ42DOzQzr1BBsNsXI57wp4MOVhoMfIXRQpzP+LLwSMqQL/7iVwk7rqZwMo0yJ5hXsU4+a3EcVzLQWOmFdyNEy9NYrM22vKsQYqkFc3nZR6VWnyKJwjxCP/PdzR9eoI9KhAdl9gxixRb/FRiqo15RoDplj4YtJtSOfetoZIaWrc78g5SxTGb/aGkOol7g4sNzCfUKgHVfLdCL4r0sllIz0U9z9DdSSG0L9tNoR278sLGe33d9IcOg/qtsWXjsH8dHN0liuPRAuU7lCzreCjEJ5lDp2aCPCyADEBZU1rg6j0Pbr/fs9Qctp77sd4AFAtOO6+CNDXhuNmNvWbum1+XefcYfV26mYmqd4itUQAL7OeOoq8BKXbgOrB4gIcJ6lClAgX1EjGEdTkyvvxT+14cnyUQoeKd3PXWaJGN+Q/7nyiI0PYFgi21VDyCNjrgVhCA6CzLe3YeIWyzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(366004)(396003)(39860400002)(136003)(451199021)(478600001)(83380400001)(2906002)(38100700002)(6486002)(966005)(6512007)(6506007)(5660300002)(8936002)(9686003)(110136005)(316002)(82960400001)(6666004)(86362001)(186003)(26005)(41300700001)(66476007)(4326008)(66946007)(8676002)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7hI/t+77DotqvwzL52FG5pSUeqze1ceo7wkkYYVOD/fG/dofbhaVnsJUMM8j?=
 =?us-ascii?Q?Vey6SOQj8cYfydQITB6Jj17ubc/kdqEY9T7W2dy7vGR3bgzddNyxzrcD8P6s?=
 =?us-ascii?Q?Yke37nQ7j6SKcVjtabjfyVVk38eZauUDCJqPd00hEihQYsCMRZkLfS0DFrSs?=
 =?us-ascii?Q?LjwM2ZeFPCV2zN4I7gE+2h68xq9+C58BFK4P9AngpbfEdbnJvKIRlnw6y8xn?=
 =?us-ascii?Q?aHPXDffmVj8uqGW8iR0mtLRhWLJ4bD6fsAZ5bDPYDQZI3twPD40Ndo157d3s?=
 =?us-ascii?Q?ElO7sgA4QoFzOqwlyWWixK0a+dae3vQ8c80smDiipPVGEt77CU2ZrpQslLB4?=
 =?us-ascii?Q?o3nJCokRvxG3WzbMueXUB0KDDFlR+6RcUOVdXZsjpnm057R5aQAslhqS2Q7K?=
 =?us-ascii?Q?ke7vj4iNCU+I0AszgsgIrQdU3sffJXJFc2zPpheJRYRCfea3J63m7f5u9PfE?=
 =?us-ascii?Q?w6CYsnjvngBWGxqut74mKULpTEh0fbWh3fZTLL8/atVUbb2FzsdQrr71oP2p?=
 =?us-ascii?Q?xXvmm/UVi7HEGWR0Fkg78ThKtWVizqNFSA4x1/OejcTeJxOD7AfnMF9MEkFM?=
 =?us-ascii?Q?66cwXeRX9/gwNO5IANdM0QmUyehecWkRcHVY7nb6UaxGTaWQYraPnFtsYslR?=
 =?us-ascii?Q?TaZ4kUA5BlslGcc641CTo0AT4Tp6Lo3oyQgGi+aPA9YgtBvBD47YENKjGkrY?=
 =?us-ascii?Q?AqJ5WIN6cFt1TfM4nZpn0BLzVOND/8lsqUhgZR6MemRIZb19qnE5nNgKmp+P?=
 =?us-ascii?Q?wM0K5+JlNQ9ZeMeSHZPTyfgtJ7xzefrUwfyUk7SDTsb/DEQqw1PmpGn57amO?=
 =?us-ascii?Q?oBkN0u+m3zOque9zfZduNfHkMbQljpLO0ye4zq3i6MRZhRALkT19CTF3t7SY?=
 =?us-ascii?Q?53AkNiAHTDnZ81rqD9FPfqdzz6GXOeidT6DdGMuYy6ovo8PHdsifuBViqNMU?=
 =?us-ascii?Q?6YqJA9ObQBiXZKw4aVJ7RKCUJ5brxbSOXd+Gbv58OkClXBnNQlUWt5QWv1W9?=
 =?us-ascii?Q?3gq96SxB+rfJxaoLwZc8v9VofFqPK+fmmpiqHahMzNOhIyZK730yjoBM30fH?=
 =?us-ascii?Q?io/GlO7uY3nAurjkKpREMQGXk0aML8DznulXDD9mWEensrANVkt76ipw4/E4?=
 =?us-ascii?Q?sXPld8b0Tv7ILI03d88AOA+UWmlrsW0htUIaPJMRP4S3mI80zumOtaykL1Of?=
 =?us-ascii?Q?6D7dSVHK6wxYT2J2liy+DA6zypQFGx2wVlxKFS9A3VLq8YccFnwoxcRFL2ff?=
 =?us-ascii?Q?vowVjn5mDuZqFk8cDx0aiInUdok7tOEHJnMI/ENIikmK7MLLo55uXG9zMPYT?=
 =?us-ascii?Q?QlVc6x0XK5hiuBAR3d792/6XHc/qF0mx2dMj5buEHA27qavfvzGqV6IrnXww?=
 =?us-ascii?Q?SVMZoS8PzU+j7LoFjeTYjq17duTHbJk36CRqqn9UyqeC5Prm9QQU6afpud0a?=
 =?us-ascii?Q?tWJFYy7PC8KLb7Y77PtQE1k6DiXKJPp0xZEBaHfmumAlZwOJIoX4/TrJAUIC?=
 =?us-ascii?Q?Uf9Wj2OEH9AS61eVDRZfHvk0GWsPxXIap0p8TQh1fMTVLDIvhjo+YS048zLm?=
 =?us-ascii?Q?gYeajzl7lARYG7yP48tGELf0racDsaSiH5uBZmy3vaFopN/hqYUOv+BtWUes?=
 =?us-ascii?Q?mQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca63e0a4-3bc9-45c0-b064-08db30a3f4c7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2023 22:21:34.9774
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AP8CZy42yloLskfP6CWhYbZCH44sasCjsYNR1NGxEr1IUea2//JmGx355J9oI679E8XDl/xyE8pnZrhczu168Ipkl+pAUqDUOxgw6RfP8tA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4643
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Gregory Price wrote:
> On Wed, Mar 29, 2023 at 02:39:53PM -0700, Dan Williams wrote:
> > Gregory Price wrote:
> > > On Tue, Mar 28, 2023 at 11:36:17AM -0700, Dan Williams wrote:
> > > > The find_cxl_root() helper is used to lookup root decoders and other CXL
> > > > platform topology information for a given endpoint. It turns out that
> > > > for RCDs it has never worked. The result of find_cxl_root(&cxlmd->dev)
> > > > is always NULL for the RCH topology case because it expects to find a
> > > > cxl_port at the host-bridge. RCH topologies only have the root cxl_port
> > > > object with the host-bridge as a dport. While there are no reports of
> > > > this being a problem to date, by inspection region enumeration should
> > > > crash as a result of this problem, and it does in a local unit test for
> > > > this scenario.
> > > > 
> > > > However, an observation that ever since:
> > > > 
> > > > commit f17b558d6663 ("cxl/pmem: Refactor nvdimm device registration, delete the workqueue")
> > > > 
> > > > ...all callers of find_cxl_root() occur after the memdev connection to
> > > > the port topology has been established. That means that find_cxl_root()
> > > > can be simplified to a walk of the endpoint port topology to the root.
> > > > Switch to that arrangement which also fixes the RCD bug.
> > > > 
> > > > Fixes: a32320b71f08 ("cxl/region: Add region autodiscovery")
> > > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > [..]
> > > Is it expected that RCD's will fail when set to EFI_MEMORY_SP?  If
> > > that's the case, then this (and the other patch) look safe and do not
> > > produce regression.
> > > 
> > > Just want to capture this behavior, as it appears there may be other
> > > issues related to RCH/RCD combinations.
> > 
> > After I posted this fix testing revealed the need for a few more fixes,
> > now posted. Most importantly for accessing range register defined
> > regions is this new fix:
> > 
> > http://lore.kernel.org/r/168012575521.221280.14177293493678527326.stgit@dwillia2-xfh.jf.intel.com
> 
> Are these patches on top of an unpushed cxl branch? I'm having a hard
> time finding the base patch to apply these to.

Pushed a preview with all pending fixes applied here:

https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=for-6.3/fixes
