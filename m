Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3476EC74A5B
	for <linux-cxl@archiver.kernel.org>; Thu, 23 Mar 2023 17:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbjCWR4P (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 23 Mar 2023 13:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjCWR4O (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 23 Mar 2023 13:56:14 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DF2144B8
        for <linux-cxl@vger.kernel.org>; Thu, 23 Mar 2023 10:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679594173; x=1711130173;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GLwpKZTu5anwXiSAt4P3kcLplhdCXvT4RgeX/vaF4Yc=;
  b=TmCOmH7eceH0mTDzThFlL5nR8QK9Vh26z94gGSwZHrtN2utvwK5TRFUF
   YzasliuAjumqD3imUTebM0Pcj7oem6BIgBsQSpAS/Y61ucGPqiE9IDSGv
   M1SbBNo3Ku1isQ+Yima8tgi0+BRWyt7TDNR4RC6/w7wg1Cjmd2A+jIN5+
   LrxWqZC/uyvLr5c80JCD2bR0VD7CMJ9y9DXECEKQ2pKScjEMuObuvQ0J+
   ldR+twkfqBNki2geXCejy9UknqPHhgukmi3ahMpzTgfrvLDM5ubgwEB7F
   1Cg3gNyZZSZ9fNHCs8r81T+muQDE6cnVzPQehY3h43HxnnI6Y8NLwWYHt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="339607673"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="339607673"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2023 10:56:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10658"; a="751591975"
X-IronPort-AV: E=Sophos;i="5.98,285,1673942400"; 
   d="scan'208";a="751591975"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga004.fm.intel.com with ESMTP; 23 Mar 2023 10:56:13 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 10:56:12 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 23 Mar 2023 10:56:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Thu, 23 Mar 2023 10:56:12 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Thu, 23 Mar 2023 10:56:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHZZZYW3CrpZSEKIh3D5xCj29NQ8jDR6c40W/i9DIoziIJqAwDvb2XgYPsmwLHrHWE06Kft/Y2Xam7XEJXCLebkiEdYy3QOo38OO8K6cUY8BzDX73YJm6O3u/Jr28wTdgsonDW6WNFcrFIzvDlHBa2lpnI9gVvoQBy+J6jc4VUJX8T+iQox5v63sTI+IJZ6M/nPeyr9IkWv+8NuUA7AwNBnkQMzvglsR+frmJy9js3fda0l6BlyoNbyJjJu7Jrm5uOZzAedSNhVotHdfx3knZzkEeUCHT0JRa4IyRYvnOtKWnPAuD2AdpnRqnFxeMoSopmmYV+yst3bS7XYWwPqhBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7FusNltRYkk3N5t/AX5G8viBMWfgsDUukOFtZ+Y7j1w=;
 b=O4MhgF0ONnOjEJ4nbxp5lQuL0IOSMo0fZ04e8PQnoERiSJ15GeQ5bQNkvzfZ/TyvcwGUztvDm8tOlKiBRBesSyn+YfmeVLrrQI4j4e93FtraWirspwYGLUEeKaGzL2Fv/AILmsiu8Gja2He6+fKKB8GzBji6Q+ZNKnnztwSYA+Ly+XLgiDdvWlFnD5kvOUmwW7QAiCt898Il/ofXhBAsmjg+bySpH70YdFQp0O40f73z06yYuLnoJqbFgtTM5Y0NceySCrpZjHXn1dAPCoEeKEibPhcTYxc6hv6PgMeUJ1vY+QPUbEbveJhQXlKd8RD6yHhihR1u+zTLPMI6AvBBBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7282.namprd11.prod.outlook.com (2603:10b6:208:43a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37; Thu, 23 Mar
 2023 17:56:08 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%5]) with mapi id 15.20.6178.038; Thu, 23 Mar 2023
 17:56:08 +0000
Date:   Thu, 23 Mar 2023 10:56:06 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Gregory Price <gregory.price@memverge.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <dave.jiang@intel.com>
Subject: Re: [PATCH 0/2] cxl: DVSEC Range emulation fixups
Message-ID: <641c92b61e09d_1d657a294b4@dwillia2-xfh.jf.intel.com.notmuch>
References: <167703067373.185722.16579529992799939220.stgit@dwillia2-xfh.jf.intel.com>
 <Y/gPhE3hDnTEd6PI@memverge.com>
 <63ff9d85215e_495bc294e2@dwillia2-xfh.jf.intel.com.notmuch>
 <ZBnmqGxU0kqubfPM@memverge.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZBnmqGxU0kqubfPM@memverge.com>
X-ClientProxiedBy: BYAPR08CA0063.namprd08.prod.outlook.com
 (2603:10b6:a03:117::40) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7282:EE_
X-MS-Office365-Filtering-Correlation-Id: a0659185-2017-4391-2a14-08db2bc7e12d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5PYpOQXNEPMCc9bnGHjCTNOf/3XGlf6H6nJ5dkbZNmaQmCEnqPW+a2mkOoittI9WSlTlt+L58kCuBp9n2YedyJihw09fxWJRDpW1pQODAT1CE0plGxLUNG0aEUZ86lmCnUUBSkh8GvXXtJwwsxtLZ6wxTViJmT7L9/vu1FBMLD4c/DiW7j99GYUNh6zs3XhtHBhx6yUILJHqZodkJ8tJ86NR8GSiOjG1VTPjyyDnStK+x6l3zaect4Id99T/F2jpAd0YhJy+qtvoDt9BbWuhL3i77VHC/9ezC33zla1t5BELWQc56ugNz5WuV7Pgqt2L1c8etcFVyCpD5ffmWszNMYtubY98+EtMmN6wvaWDCexR+qRUBGbCXlLKt8BuaY9zpikp6WUV1+HEImA5ERAFxiEecvMW5jEaMFO1/rMi6oVtJLiAYH//IQNjteoT9MFqRgVioy405ZpXyjg9hfCvjtEyia0hOno3+wsIPGwjy77jZfVFph87+RfR+L5pxFOu04TPq83ewdRDmF+bQ+wPDvFkEbrnQ6EdQJc2AD5xf7T+pb3omH57/9r5MqKDrEGeAcjtuhwGmityp1uNmZtJKsK9WqxbUm3pUK/TKwA0CzDkEzoSS+LzjH6uUJqP+50X45vlqe0ddOk7oVsqKaZtbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(366004)(39860400002)(346002)(396003)(451199018)(86362001)(82960400001)(8676002)(38100700002)(41300700001)(2906002)(66476007)(5660300002)(4744005)(66556008)(4326008)(8936002)(9686003)(186003)(83380400001)(6506007)(6512007)(316002)(478600001)(66946007)(26005)(6486002)(107886003)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?E2LNSWtet4goGTVgozCqLVDg13eE3NmLAhumkN5lXsiPyI8OXGkOtBagA5Gk?=
 =?us-ascii?Q?xxBwUzQv+L7Lib74C6ZC1wpNgXaPjhlmP5a63wy8CfBpLtKcLq9z9K1HKzsc?=
 =?us-ascii?Q?0nOwQNKNHmWtTqIAqwSQkGkYXPeYk9LuCMxSuv+TkGAxx0F5lHI/7XqzhDl3?=
 =?us-ascii?Q?g/1JJDqfY3eFnB9CPRKrZ/b/2cgXyCQfvWbjuFfIFEqfIjypSVYs5Pus3lmn?=
 =?us-ascii?Q?+xFSTgEOKCexSK916W2fqGzmpxFJbEZvZFqYsXhx/pClLcxY3bMHS8JrHrhV?=
 =?us-ascii?Q?aISZSoj2cHQIpo6Uy6C8cXI/zPk2ER4u66cEk0dc2aTVh6xFs3cBZs12nRrv?=
 =?us-ascii?Q?S1NMziR0JyrS+LByXiIiyVLPOIgxtkpbQL1pqkvxMC2EwnS0uKwyynU2P7xk?=
 =?us-ascii?Q?VcDKVQBzoojtJN+++syx+mdIfT8mWQGfXMZygY3MCHb9Bcm1mQv4CCjvqFbI?=
 =?us-ascii?Q?Pv+YN5sZqv3sNSkQoq7UzK4GDInxIm+gQ9oug9++3xm3eVD639sEnKJRY5z/?=
 =?us-ascii?Q?EoomwC0Md8a64BQ/rVS+FlPiVpb5aG2k33PbaxQzPldLVv2JOnRyhboC/hCK?=
 =?us-ascii?Q?DxdYeRakP4pAh1AnvskVftGmQiaXJ0+RoDkil6HxWMyt5l99PhMSx6OzZl7P?=
 =?us-ascii?Q?x//SK58pkh1B9Su0Zn83CKuzxVcdrXhKEHqOejfQPRHOoxu9xdrK49Q0ZGm5?=
 =?us-ascii?Q?T381s+Htw4bDf52srhU3ddyXJsrcJw+iMV8NXTFxeHrkP5HWQ5K9A6U1Ispp?=
 =?us-ascii?Q?PD1ZmJrabJTMMuiqLf0A/2m46NbOTvV58+cP+lNx/s+VvyG9IXgpPFjRrrrx?=
 =?us-ascii?Q?XTEvGW/HVlS/KMn9gyKkW+cKshKqdXmjqeUttM40aahn/T9fJBt2hYh94lrd?=
 =?us-ascii?Q?ReLGd1KSAxVrBIEJw86c4U+nUjSg8m3u48S844Gi/waBVnEycNEJ7oDsNccS?=
 =?us-ascii?Q?NkWoNgk786ljH0+CiZ7w1aAUqdWUjGuuqRfNwAXAPtaMni07xCupBFXWdwpP?=
 =?us-ascii?Q?cw5RIbM03ooxK6ukx6WB26FleKjo6QvjJA5UIYR/+BAYd/b9+njMZW7Khktc?=
 =?us-ascii?Q?qWQddF23YHSeMBVcr3poTFsH9CzAswzJpitrzQPgALIr18HO8VJkPBYgiuaS?=
 =?us-ascii?Q?y6jDoWNCor4iFvp1LcsYka9fXOMGPQze/f3JJgJvw14j+7lfkzqHQM5Z0ZBC?=
 =?us-ascii?Q?PqfmnQf4kUkrNx67dqMRm+hAMYmpz0wWm4GcRKTHBRIghIeg/RjqIklSkSew?=
 =?us-ascii?Q?Joxhw3bK9zW6XJ0E0CSTH1Z1rxodv9gisXQXAb0L8ABP0SM6ppC3xorJYuK3?=
 =?us-ascii?Q?262CtbQb3iTz38KIltn82ZodebDYoWhrTfwjveyV0bDX088PHdU156xm5qDQ?=
 =?us-ascii?Q?eYg4jqbYuuhBbF3XdNlCSpXODAFTN2C04ql6X7T2XUH2qNaXZUNE728VmPMc?=
 =?us-ascii?Q?6gGYqnZbWYk0yfYzXh74myo+JuBo4N7gGOFgRpjnveYBjgvLMLelM6oKj6YE?=
 =?us-ascii?Q?1RgoL7QwAjk0aPDZWCUSEqWakOzvmugocQVGJfgXtEmhRiUJvrYkJIPNtNfi?=
 =?us-ascii?Q?HdDoWWVBbywqDUhSzZIIF8K/ugEKsPDGCSDTYRqgGgEgaM/yXfmxn2bcOxU1?=
 =?us-ascii?Q?XQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a0659185-2017-4391-2a14-08db2bc7e12d
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2023 17:56:08.1564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7w/R0AVAbJe4Wk7K268VX3lH9d1DVCWRpSy4XuWu5NvYOVes7YrmP7+GY0txEAGpTsRI/l/ZLCbFj8cZSt7YjR/RMsp+JqM7hN42f0Pm+rk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7282
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Gregory Price wrote:
[..]
> > If the CEDT is broken then for RCH topologies the device component
> > registers will also be missing.
> > 
> 
> Just following up, you were correct that the CEDT.CFMWS was broken.
> 
> There are other issues that appear, but I will wait for updated BIOS and
> then push a bug report once i validate it in a more sane environment.

Ah, thanks for that follow up. I had set these aside, but will go ahead
and queue them up for 6.3-rc.


