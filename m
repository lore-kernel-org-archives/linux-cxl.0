Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35E6C4332F
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Dec 2022 17:32:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbiLPRcI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Dec 2022 12:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbiLPRb4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 16 Dec 2022 12:31:56 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB521A213
        for <linux-cxl@vger.kernel.org>; Fri, 16 Dec 2022 09:31:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671211913; x=1702747913;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=e+mIqkKRyHLxKs444Xj59sZWvznWRkmkI2vyobN5oAs=;
  b=eP/b6ckNJv0VUOWUdMCQxAqO3QDP23roFMeDzq5+usJC2pjxYIbFS5Rz
   EJMzMov9s9QLGwND/u/eCYzkiiNVDwiL0mZ5OGWovXjv1NdMgvW5usisG
   1JdXsX5DGfohhyU3wFFNAcpzb09S4kXonnGI4aJRjjIvMUPzoDtHM2BEu
   w4uIqmYfQBZRoN3dt99wiBeXKMbwF17W2XZjKcqH8bM0HeBoy0jrzTLcI
   +svSYBClROMziOZbOfaCeX2iDhiDyfYaTjbUz3mDSHlkT1MWbyRw7HwuF
   p8gF0wPNKyu/pFAaCVyi6qGxBZkaI3/F4XUO80UMQqI+aU425wtKPkxLd
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="298686624"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="298686624"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2022 09:31:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10563"; a="643339360"
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="643339360"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga007.jf.intel.com with ESMTP; 16 Dec 2022 09:31:52 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 16 Dec 2022 09:31:52 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 16 Dec 2022 09:31:51 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 16 Dec 2022 09:31:51 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 16 Dec 2022 09:31:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BAsGb93qFGJit3aJcmsj4tjXV0Hqoh2HE7UxylZ2va0LkcRxkwJC0Ain+GnVnWyq3Pj9I4caIb7Qd8qNWxHM96u/dM9lzY3uIXkkO7uPv3w7OsXUIuTZ+eoQHAFvKUuB0O/f/lbIRJ6m530bwxuMe+2BzJ8J7NJV67KWm0UHSJszf7YF3X0M2b/LfAbCey77/bq4Qi2/h4iVJYR6RTTqk/IcX/J5M0zdhkgkAqleNviDbytZ0cO/4FKdJB92SIRUKtxHcAZLZJOoG2IB6iQPjSa5T1Q4aEaTytaLPJwDYT9BN5LJkCtwgAstWrW/jrNcLzwK4bKTL7gNpZXqgU9fxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e+mIqkKRyHLxKs444Xj59sZWvznWRkmkI2vyobN5oAs=;
 b=ZPObf0HXQ01uaLbt6qmbst3sQQ+tPVI4mtFZgpUBi1yg8/3umYMcOv6cc23gG6Cp+NuyrWEqL0OUHdU1nxk3Bx/cJkS8k73ygB/TBpkndj7dsaOx6tBwbbMPk9N450CCGYuqD6V8CgdEfZzCJEh+EmlQg1yFwsmDDxPK2CWeE5DIHuzj0r5Ds7jfXBNpxxO2kB/7sMfKNNblPQlXsij7PcwgruZRLhxnhcR8hV1Olz5G4X7TR/8GzCa3XeTgUkR6weisFPZLFVF8B+3JLJOnU87tbsTBxtYUyJkaha80g/PzHVOP8BB/I+PevLjxRk+c2A+rE4rmIrKSuu6NNyTgTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by IA0PR11MB7933.namprd11.prod.outlook.com
 (2603:10b6:208:407::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.12; Fri, 16 Dec
 2022 17:31:49 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::340d:cb77:604d:b0b%9]) with mapi id 15.20.5924.011; Fri, 16 Dec 2022
 17:31:49 +0000
Date:   Fri, 16 Dec 2022 09:31:46 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Davidlohr Bueso <dave@stgolabs.net>, <dan.j.williams@intel.com>
CC:     <dave.jiang@intel.com>, <mcgrof@kernel.org>,
        <linux-cxl@vger.kernel.org>, <dave@stgolabs.net>
Subject: RE: [PATCH v2] cxl/region: Only warn about
 cpu_cache_invalidate_memregion() once
Message-ID: <639cab82dfd15_b41e32941d@dwillia2-xfh.jf.intel.com.notmuch>
References: <20221215183836.24136-1-dave@stgolabs.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20221215183836.24136-1-dave@stgolabs.net>
X-ClientProxiedBy: BYAPR06CA0012.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::25) To MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR1101MB2126:EE_|IA0PR11MB7933:EE_
X-MS-Office365-Filtering-Correlation-Id: 05f2af43-a6b4-48af-553d-08dadf8b697d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y92hff1XwFWfvlzz8e1eqob68ykiszv9qrjbXyZIsmnPhWWwa1RTbFyck8uZOiVGSIM13cLwvbJsrQedVpw1o860XP6SESzwv9SsIH7+Yy8vDZyaNIIJgSKBSVenhVoO0WdPkxcrWsna7hhYjJbDQyMy3z7gx+pGt4E3XL3DXNFUnBWIQyOWDyzuCJTFC9b4jnHIL0tZ3ryKFuoUhcR5x6kVvItfa5alD4Oe+oBoPQQAIpNETo2Zfh4kLbZOlijF0u509v/Y+wHR0MII1PZc9Y9zNc0xHYgtuH5VFtiZLDGgZU453sb7B8knaDZfh4X8vKPYlIVNoR5ChBVXnKnYWBcU152sCXBzl/cDAJ9DTcn9LZZNliUaYNHzR6bV3mR5DPVpUdPKpSTTNmSNFMZ3T1lg57aRJtULMnWf3bwb9FGHMz8RWOVXPSFfgL4+y5LF4qI8a0MB+NN+tIsoapl2IOqNLVkb1YGILK1xW6OosNR7it8rxzrNSDSm36qHAFeBfxrQQKgRK5TwRGXG6+y2UgyT31xmilQPSFCBtvIxgfCdd85D6DPGDNtk9jiFZHhSnYL3tCVjBx15H53lJXZGux5Upl04ZG3jOL4nxHEGKUhtFbGvP1EJnhChg4wyLlzYXg0GMUGE6+JP/fzSknvXbA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(39860400002)(396003)(376002)(366004)(346002)(136003)(451199015)(2906002)(8936002)(5660300002)(66476007)(66556008)(8676002)(4326008)(66946007)(558084003)(6506007)(41300700001)(316002)(26005)(6512007)(186003)(86362001)(9686003)(6666004)(478600001)(38100700002)(82960400001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1SM232JwqDNC31D6RBO9+hgbVBbX9hJlqtodp+Mq1Xz21SKRPAa+obCuFH4Y?=
 =?us-ascii?Q?3AObIn7+/oGqjMLAKZYot4hxNTOBZEKhtkoepH+sQsYDT9ZRKJaNc8XtOA7v?=
 =?us-ascii?Q?B4eO5LOrT/KjEqWjrcby20vVPQsO3o9mrhy6IQEy1x7KaVD9sHxarETyxqMJ?=
 =?us-ascii?Q?f5fI2vmHY7gBdfXuIKn1qlvOvOKmuvmnPcl7E+hFhoOC2VJ3LpyTvhAbRnQY?=
 =?us-ascii?Q?zfT9NZ7jLJpuVpB4ODewyfVBuOHFJ7xUGZxMPHtfRWPgqCiC8tygXINj0GR3?=
 =?us-ascii?Q?7iU7f3AbJSsXA+FEdr99H+zHN4PusJDf/TAXY+d8J1tCRHZZ9TMYmoToJwZ0?=
 =?us-ascii?Q?1A7r2+3955D7V8u2Z9sP78zjfw5e8fJhduyN5dCxwPIoJLMfVnTbrvETTCte?=
 =?us-ascii?Q?ooFdTByyFmscF2nPqRZQ+HOT2XIKmOcDvyNf98IAnnNCwoc/DaGXZRjjoCRD?=
 =?us-ascii?Q?SftTNfDDSS4dO3gEJ17rOM+BcKSHrAu/7OJ2KoW8hPxU7l3frDDaPTRjJr+f?=
 =?us-ascii?Q?1OyiQvPPiTrCAOwEfU/0NGglMw1x2bvxgtK1IN7GMVXKwIpHpZSvt6n2Qcgd?=
 =?us-ascii?Q?r2P/XCZAdmOCTaokM9fFxYG+rCg9b5fVud6LaZoqodrGXydvp4XwR0pBsbsI?=
 =?us-ascii?Q?YOZpWZwfdyJQ+dg7caj4FyzUZNw4O4tqwd/OH+nr0AAaRuvoL2JLminC4Lsb?=
 =?us-ascii?Q?CenkKr+HYbPgzCQ2QW6wJKVvjjEPP/hZ3X3uOREI/xgV08nRXZ3jXK0ML6ch?=
 =?us-ascii?Q?WY1lfZ4RMs4RRuX9xG317PzpMghPlPgnm23IlzqbQT+JEppuWYdFkTihY+lo?=
 =?us-ascii?Q?f6r8EKxt5RvOfZQundIEA7tUAuRSC0xFpXlJS5RHBy6gdpmxrQ1RgWYnQgi8?=
 =?us-ascii?Q?6z/2D6AKjMDUxH1SEDdfghDGAPvvc5rq7il+O5SJtS0D337cfYcXifEsdMRY?=
 =?us-ascii?Q?IWdlCKRM8VvxgZh8AtnltSyt4oHMiC2k6F0TdLhELgNnzUvaEr/nIMLj2OPC?=
 =?us-ascii?Q?1pMel9DsXIhjwiZimYAArRWoqaH70URQ29+Z9ZpXggvVmP1CKnsfhp7QL1pW?=
 =?us-ascii?Q?I/X0LrgaD5GEVnHTCuV1vyMDyP/jVvbvGoXJxKIkCm57XgyU+tcwRRX+MbQw?=
 =?us-ascii?Q?quNP2RaxkxW4csULmHENGCl+aNDvsbnAcuUotQL3hWZ+SaQc4kua1DROLfO0?=
 =?us-ascii?Q?0NIm29Crz+7UMZL6A3JHdUcQhE24cvh10kjGKzOTX8onL0EEhAydwYqEf3ao?=
 =?us-ascii?Q?1wyPxrWlqcsBYsdtId4/tPurR8vyZjBTfww1luUFwHm5KxFhWhso1owI2SlO?=
 =?us-ascii?Q?Npehj06shuzTdsl689nJeBKgXelEofPrSFM56Rxvc5bWJG7OhhFDyHk4hi1m?=
 =?us-ascii?Q?PQ58I/tTqpSvLshoFmFPGbloWlm8uusKCf1N0+Y6pLxGuz+XqgSdBZzuhK1Q?=
 =?us-ascii?Q?wIb5cA589og6c9uYg67aiKmeBsAqhC+h2WwBf90L4tgoBHKgo5OX37zt/VpM?=
 =?us-ascii?Q?JkVlDcAgY+ozg3NFHXLCLdNjbvHui+Z96OOqpCD/g3mbHsfO7obkBJjJWUE/?=
 =?us-ascii?Q?yuQ4Yt0hDV+DqgvKu+2aN7b96jrp21b7uw+7ljg7dKv6WQ+mK4XH+0+p7wWd?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 05f2af43-a6b4-48af-553d-08dadf8b697d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2022 17:31:49.1334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vh+qHsKPTpUUHnwT4p6jzPtQ8PxstrrDAkkDHoxPCOtA1Ewu+3o0PA+0JZRyhIBG42u9saDPnZMQyCQ/YBxWCEkzczgQNgJo7Kpt4Rozm00=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7933
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Davidlohr Bueso wrote:
> No need for more than once per region.

Applied with this fixed up:

s/per region/per module load/
