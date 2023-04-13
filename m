Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3B1AC77B61
	for <linux-cxl@archiver.kernel.org>; Thu, 13 Apr 2023 18:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjDMSe3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 13 Apr 2023 14:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjDMSe2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 13 Apr 2023 14:34:28 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30E8769C
        for <linux-cxl@vger.kernel.org>; Thu, 13 Apr 2023 11:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681410866; x=1712946866;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3X9yIypZZl1JRaczhAkIZD1uEeyYddB26LDtgwV4Nu8=;
  b=WV94g00XBmBhiwP1T7cxDNA7qmUbX5Xe24KuQlxogxWmOPfwTC1MhGCP
   rNuR2zZvB0ROSrnJcMDDnBqP3Ki7lMdtksC9e8Wdjg7I6fS0MpG1O9Gjr
   yXSnk1I6Kw7+dwSIU9N4IP83NyQWsrAJRAnxiyCXSuO/AiDk5AXo/R5Ji
   1PQueX/9L5TuHqBrIRQhgaDZqb9T16S0RPWWDFDIY0HFq7UPEoOoDlWLs
   BRero26Ek03XUG53ZvmzPUUAgJJNlsHcFX2RgCYFCFxNdCcgGk7UbSI4J
   R+NGqAY1+iNTO76XggMLTJk/ALSQPDXmLSM9WLi5/HckuyxWkwN2FekA6
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="409452542"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="409452542"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2023 11:34:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10679"; a="666867625"
X-IronPort-AV: E=Sophos;i="5.99,194,1677571200"; 
   d="scan'208";a="666867625"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 13 Apr 2023 11:34:15 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 13 Apr 2023 11:34:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 13 Apr 2023 11:34:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 13 Apr 2023 11:34:14 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 13 Apr 2023 11:34:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GEeIT3u2QkUKu2ZOP2FT5/su59X917AaxvXQLjV8DJyZqCIL6fmABrhSDR6BnPP5hk7fgc5SgvcOTJewel50K7ksg9Bz7J+1oqDHki14osYgeEgIyTGVewR/Mecmmawe53BVWpijZV22ghCIVTRFZNVKF+ihvQtWA08bCyS1ZmQ/KpixCy+8YsmSDKarlgOF1MIEG3S55CDM6v8iupBGfC6jdtCW7llUudl0RJHvNYiJIzVjbsHtAgMls7QqtvVw+V9WS7pF42yZyTngRoDtuhIXGS6dXYqaYnNcmasrMAxfE3Ft7T95HT5yCpO0pHmoZNqatLkpfrrU23ZEV+UQrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/fO4GpaqiuLxjDlwas6PTnKnb3a/45mn64fucyJTyw=;
 b=g9DrH2HtBu77cRMLkCL4KDE88WQmFpMvLopiiBn3IUn4jYz8tkn8LNX0tXHbHw/2a5T+gmrEBT+pIdnR5WxZU2T0exKL4+8NtMahEvQB66+eIMGovP0xFTucUXlgp5VmBTxwhKtSHrkfxwz8TDno1Fs1CnezC1BKL7PvFgG2F7y87aGeJItlWYgoM6SQKBZg6Ab8MD5c/X1pQryVGR06qGbvmxohEr48vxkb9jfeLelNMj5w4KdCB8W3AX8etjwRIfEV1osvQhEq/QOZr9S9mXFqnn9uheKAgINAV0RkHxVMANClXWjoA1dxosjmAvi4CN+LfMHwNULTp0trhQk0Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MN2PR11MB4615.namprd11.prod.outlook.com (2603:10b6:208:263::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Thu, 13 Apr
 2023 18:34:11 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%6]) with mapi id 15.20.6298.030; Thu, 13 Apr 2023
 18:34:11 +0000
Date:   Thu, 13 Apr 2023 11:34:09 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        <linux-cxl@vger.kernel.org>,
        "Jonathan Cameron" <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v12 1/6] cxl/mbox: Add GET_POISON_LIST mailbox command
Message-ID: <64384b212236a_5f756294c2@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1681159309.git.alison.schofield@intel.com>
 <e87e1792e147a46f348019cc772e06f2ea19e970.1681159309.git.alison.schofield@intel.com>
 <64360dcc59cb0_417e294de@dwillia2-xfh.jf.intel.com.notmuch>
 <ZDgyezzrVAxV/Kdx@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZDgyezzrVAxV/Kdx@aschofie-mobl2>
X-ClientProxiedBy: SJ2PR07CA0019.namprd07.prod.outlook.com
 (2603:10b6:a03:505::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MN2PR11MB4615:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c25e298-46e9-4f15-6746-08db3c4dacc7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: azIehzfvo1aX0RQDFrjfWbmOaiQ/SXZj/P3Z1kThfT7q5M3Xmr8Vd1Jvg0cs9M/nV5UZ7yUcFLJgfFrHx/efymfVRUagbP6Cs0IwpqSOIc7Mnb+Q+CijS736+96im2KlvQxghq5gKxBUtpeQrkN4Bl07uSosJ0apvi/QONg8OQKi3WAgn1Df/uSGkgvUHZnTFG4PVs6PoBPUVmbHE78U7Rz4JOF0ptSmSuwa1zACRyHTLg9LcK7NWFAb4ahze2gCrm8evTBYLZ3AXQ+Ig3bZuMH/tmt6rg9RFfi0BrIpmZHJeBbpYy3bn1VLbo7kD3lkOKOAKXhDPvYVnIE9k/Q/BQb8E3zskP+x/JZZFQhPeCRhVv9R33/zPENE9L+1GaXVBgs1NXu5GKFsGJKG8Zqmbggsai/MtTtBzMQG5uNNnVGXINAEqcEPLtDtRUeYbDqXlR9mFOyTyhMrYPnpqfkpIgzoJStVmYW9CMnn60c34iqMIY+GfoiXqDBTQjeWouejrdQ4ecQfcddl5m8MwqQDBLO0vIdVfnMaGBDwKn+lbJuE00e9oSG8Bu2hy2vz87wr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(376002)(346002)(396003)(366004)(451199021)(8676002)(5660300002)(186003)(8936002)(41300700001)(38100700002)(2906002)(83380400001)(82960400001)(53546011)(26005)(6506007)(478600001)(9686003)(6512007)(110136005)(6486002)(86362001)(54906003)(316002)(4326008)(66556008)(66476007)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IB3fz91SNu5dCb7+185OJiWEeKtCnr0syOrtl3UVAmuwoKC36YvnekEFzA8f?=
 =?us-ascii?Q?YdWPYaRmiF1eNAL4B1+7ikgm62LfFHCMDilc0tEec5kXKjwQYT3UWbaW0syo?=
 =?us-ascii?Q?4pGWCcnQcXt9fIU6a0LmEa35d10FOAv6Pp+7Em0Q4Lpjz6L9XSbKwdzvJ5ml?=
 =?us-ascii?Q?EvB2ksSn2oOPgpVZrUaeHW+z24NJZkHBHcG3Dzg74gUu4pz8TSaih3rbg6yc?=
 =?us-ascii?Q?X9M0HCmJcv0CHFCkUpx4q9xuweVb0kg7jcznqdUJDty876MAeUGTcPo1pUVE?=
 =?us-ascii?Q?USHKyH+3i9dIJMmQ7Cebog9iD5HPBXVMUBqfgCcqH3U3OVHBHAeKmgafYlZx?=
 =?us-ascii?Q?ov4+BIMclXYv/K5orJpmlGoVqNel5MKIgvpTOQcH/ILNyx+ZGcMm9hezowOA?=
 =?us-ascii?Q?cd5DWSoePuoycOKhHPuOEgbwyrlGeOflJqZpDVy3i6UQYZZU2S3TUlktF3ul?=
 =?us-ascii?Q?iUnzUQX3PIvxhE9yWmVMQDA1uTfIXQ+hh2Fro2fZTEes4HAAJpDHnIfg0EyD?=
 =?us-ascii?Q?d4b9zWf10+C5/QHCBGVWobk96+KR462wD/rqsW/R34WZ9Vz+m0tqYeOWjvkq?=
 =?us-ascii?Q?eEjoHjIuEXhrk04kNelJaN59zG4MzPVK1nTFNdfbI/qd4pvG6KSqyxbmPe0O?=
 =?us-ascii?Q?aRIuV3Fa8DUCwvS0CFUAvd5f58H9U2Q4gT5yqrAeaoNwiJ3Rf1h05BVCUBM8?=
 =?us-ascii?Q?W7bNtniZaH03RQ5zwVPiDn/KvuhBvFYZ6cBlu3l+l+KsZCrq6Ue2sc9G3qKE?=
 =?us-ascii?Q?tPZEnt5IRpBX3p/VXmFtqHVNokG5uimuMiDGeFekvll59MZK9IhNefdoPFfi?=
 =?us-ascii?Q?ZU/RyBVEcWXgMvXY7qt07KNhwdMNf3K/6jhl4QoMJQ5mH5gbhMh7h+d5jwMx?=
 =?us-ascii?Q?6Y3OxnYs2mjWkuvI+TGkVyhd7TjbQBHEbnLYUvl0Xq6XjV+l9CogcfA5X4Ni?=
 =?us-ascii?Q?N7ldeI2K+x07RPgzWV7XY+0CruO2pcatCfrI9idQxTWCap6xzycSDu9ROXlj?=
 =?us-ascii?Q?dOI+xEDBEDulDr6iQDmQk5hCcv/GMrjHDD6oCLhR5vw4gD0HOpvxZK8Zs8wC?=
 =?us-ascii?Q?1CCIgod8uJzn11koBgj6mHgnOtUf46yCfnzRwDuZzbs1pk7uKyzO0SdMijln?=
 =?us-ascii?Q?DEpvmirIHMqYb4m4/AVmTDLhVsVaMBJXK16bEuDBT63/h5G3JTaAygt53pZ9?=
 =?us-ascii?Q?nW0aqHifGVDdg2L/GoVKhMYY5bqxaJBRVrDbgyCGILYfRdHlpkLWjXuPnzMy?=
 =?us-ascii?Q?0RwfNtYByCSKP06sgA3GIMIPr2MKAdpbER1m2vqC1g2JJLBKIgt/Q/F+QGDS?=
 =?us-ascii?Q?n2RtJTSrhZtrUVbIJiMOIajVOM5Ucs1ag/z29fuGwhFKNEHE2PfrouNTiyBc?=
 =?us-ascii?Q?F7nyo1QFSbgoayb0Swmv58wo1j/vjQS2f0i0PSXDwvuDB0aRGl4ziwSdhumZ?=
 =?us-ascii?Q?UIM2KbCaOMjx8ksXBDklRjZFERsZasguZcZ1EGjpqyuyZ2f/1ZvhKSfhvx9K?=
 =?us-ascii?Q?hevYchA6GXUcOy2gsDgg4YEfmylM5yNXbn7gIhHMtr32ZRS5pJdIMo0wW2lo?=
 =?us-ascii?Q?/wiJhjBtaV6iSNGy//PQrQbBuO4Z6lqVThOtNLYYexqA6tOncZTFutZd1fex?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c25e298-46e9-4f15-6746-08db3c4dacc7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2023 18:34:11.3811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i6jw+SfMZ0Ah2LBJKnxsU/dhwI/48uM6DTUeSPK1xjPAwhNUr356p9H7TIP4QRxWxqLTt+1oeJt7t5W0bThvuNp0kZLUM7MQuQxCZaII/0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4615
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Alison Schofield wrote:
> On Tue, Apr 11, 2023 at 06:47:56PM -0700, Dan Williams wrote:
> > alison.schofield@ wrote:
> > > From: Alison Schofield <alison.schofield@intel.com>
> > > 
> 
> follow up on the deprecate patch...
> 
> snip
> 
> > 
> > With this new interface I do not expect we want to support user tooling
> > that wants to retrieve the list via ioctl. So I think this wants a
> > lead-in patch that deprecates the poison command support so that the
> > linux-cxl community only has one mechanism to maintain going forward.
> > 
> > Something like the below as a lead-in, and then you would add code to
> > cxl_walk_cel() to set a flag for the "get poison" machinery.
> > 
> > -- >8 --
> > From f2cd1d1e09fe6f36255f3b8cd831b2b4903045d4 Mon Sep 17 00:00:00 2001
> > From: Dan Williams <dan.j.williams@intel.com>
> > Date: Tue, 11 Apr 2023 17:48:45 -0700
> > Subject: [PATCH] cxl/mbox: Deprecate poison commands
> > 
> > The CXL subsystem is adding a formal mechanism for retrieving the poison
> > list. Minimize the maintenance burden going forward, and maximize the
> > investment in common tooling by deprecating direct user access to issue
> > this command outside of CXL_MEM_RAW_COMMANDS debug scenarios.
> 
> I'm expanding the scope of this deprecate patch to include Scan
> commands, and want to make above statement correct, wrt what is
> allowed in raw mode.
> 
> Today, Scan Media (& Results) are not allowed in raw.
> It seems like in the spirit of raw, we should allow the scans. That
> would be same as the raw allowed commands Get Poison, Inject & Clear.
> 
> Thoughts?

The goal of blocking commands even for raw access is for the kernel to
say "hey, there's a formal interface for this, use that instead". At the
same time there is the "raw_allow_all" mechanism for those debug
scenarios to opt-in and say "I really know what I am doing". I think the
raw_allow_all hurdle is high enough to prevent splintering of user
tooling and encourage collaboration on the commons.

So I would say feel free to continue to list commands in
cxl_disabled_raw_commands as a way to document the commands that we,
linux-cxl@ community, believe need to be kernel managed. Rely on
raw_allow_all as the release valve for expert debugging.
