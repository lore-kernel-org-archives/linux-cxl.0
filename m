Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8702C77B7F
	for <linux-cxl@archiver.kernel.org>; Thu, 11 May 2023 22:42:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239512AbjEKWms (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 May 2023 18:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239487AbjEKWmr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 May 2023 18:42:47 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09FD2D68
        for <linux-cxl@vger.kernel.org>; Thu, 11 May 2023 15:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683844966; x=1715380966;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LXYGtRjIjN+iErdmQqzUD86DcRJGc0Yqn8znVuyc/Ow=;
  b=EDjZfdxiaLj735Eh/JDrPFCa8aUGjN1Gvqmpfn+5cD8L6F4I6Y1CKzyA
   clUM6OS8RrXBs53TV6WjCIBSohgUrDwZjyLoufA+m+qDvfwiFEh48MSgE
   JqK6pvKHRUoxHxBO04N50gfSgR9NEkkLSegG4/+E267fZ4oJo9M4A+yOt
   d148V/7qXUYIabckqE3+ZlrNx56dD6lQCA7lO3yAzdLXZCPA/pDwJNIqe
   hQkO+s8YrRHLD75/B70uw2fU76fnU6/ypinqRFIlihPg//AoS0ZdEU246
   38JD1z2E+73uRbzl2t4B3xM4nCegkJxreI/dcV3zNkpztTEL7yTS2Ie6S
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="353767980"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="353767980"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 15:42:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="730567350"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="730567350"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga008.jf.intel.com with ESMTP; 11 May 2023 15:42:46 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 11 May 2023 15:42:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 11 May 2023 15:42:45 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 11 May 2023 15:42:45 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 11 May 2023 15:42:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZL8sCuvogAU2Bb/sDVreWfpZ8jQtXPalZQfXpnbqnGtx9E6I3ckdyOGmD/+bEiN7JswUtrfD007/UfLZUYvCKSHqMHgpZO/20p3QNtQ6foBv7RBYFYhnMmOnHjPO2284g/Z1mO4eGVow45KpCIcisf8ct8TymDTMCsjcMB9ATAoqreJYJwbGs4O5a6/wGuygnIT/iZ0TXN9j2DGKdpInHxfDz0G0FF5iTVAavE4yZaz2bbZlFc4sBMO7eHSgk0j1XiKVSh1nhRt1xFoif7LEklKuzQDlTlIgbCVWiajrXx6gx2WXsGqs5zeIERuQxMSvCIDvjpd+H6aLnHwovfGJzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EOXjSelTyJMizFU4CNoEwCL3Sm6+Mjnc9ycXBeT6cnU=;
 b=jvwwiFO8F4OMjsieqd64jAI702symOHdC4o/8VDAvzld6+NzIJoPoISwZ3zZPjnxYgGL2BaDWs1TgJeFf4UWXE/iDp+No8Aw1X7nBTpXvJY5sWFh5EjAa8BxQgjwyJb+pvhxnHkQelSg+uB9gdAPWFn3zk6js0JEkrlZvH6FmK552zcHZj3EL2cjFHdxcuDPjo84Pmxb8i9vPj5w1mtx1E+clsU41jblpjihrZMWCDuMSo8yHyESfFt2Evh6A9/tTXOa2qO14e2fellSDP5MEXlL/Zu4cH0/BV6MtUaQnmsKwsx3s+1RokhlSwybR5Pj7icm0olrMwyuEHLq1DJeNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB6424.namprd11.prod.outlook.com (2603:10b6:8:c4::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6363.22; Thu, 11 May 2023 22:42:42 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%7]) with mapi id 15.20.6387.022; Thu, 11 May 2023
 22:42:42 +0000
Date:   Thu, 11 May 2023 15:42:39 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>
CC:     Alison Schofield <alison.schofield@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: RE: [RFC 0/3] Apply SRAT defined PXM to entire CFMWS
Message-ID: <645d6f5f52ff7_1e6f2942f@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1683742429.git.alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1683742429.git.alison.schofield@intel.com>
X-ClientProxiedBy: BY3PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:a03:254::12) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB6424:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a2901dc-ca6f-480d-3eef-08db52710774
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: whIox0H1rl6pSo/vc2ZME+YRzMXREG7sb0uJ4P7s/uPSkcidQJmcIy20veM/YrVY/atIF9NnZIKK7binAiGZSFtMP/DbpS/lOLFhKsPfAZ93xDZ696qgS/eu2FcQcLCSmQLerCx4P+SSXPYVMYwTm86ib2ft+M+w/9dceeHT50kgJ8jsX+utrcgRFYYqOEf+AoGiVWvZI1n9du+68ZtezEYSqvmm+NLLXHyfnjgIOD5vePe73l0lyWGlVIuPKvLq7tPltynSOZ4bCHknWTGkwV4TlzlgFldKPXebNo5fvYtx3X5g02uPClG4r4pdRDzUjPsT0bZhvCLjRuXV871BSA6G4iwD/YupxjwlFojmsjZNW2yJpWvVTMSWHCWhvqUZVq1ioyKm4pExgmuwokeDU/iBmbfOwiL/vx7ISSjX8wHM/m9i10va05GR9DfwrCEAe99e6Lw7kzuMqDe8ltSduW9skX7gpdAuBmpXPATXN8dgurmBxoPWOvmzdUjYNyTiw/LGvz800t+C/DJuXvwMqU/ttSAZVjWfY6vX1TQ0Y/mOMD6juUHzMXhnPyTNdP0k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(366004)(136003)(396003)(376002)(451199021)(41300700001)(66946007)(66556008)(66476007)(478600001)(4326008)(110136005)(6666004)(6486002)(316002)(5660300002)(82960400001)(6506007)(38100700002)(6512007)(8936002)(26005)(8676002)(9686003)(2906002)(83380400001)(186003)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hrh90HqvJaeLKIFWf3fAcDeLqAiQY4oZpTkGbxUN9H9pRy1DYGcFXNQ3P6xJ?=
 =?us-ascii?Q?UFPEjow3lHhoLj819oue9uTyX1+S4JsZ6UW11U/1ClqoS8rVh49pb7cFqqFd?=
 =?us-ascii?Q?ZQUYyUzwsnp18/y5LEVBdP/Kt5TFEcX2dsI32Gv11DLxnw+wRWYGU+trXYza?=
 =?us-ascii?Q?BhUpUEk9z0akFdNxJrojNu6BfQ4WcOPNAaBIHG//vAHLieGOSXIM2yz588QW?=
 =?us-ascii?Q?bcqXifDnkG7fhIbTTci+Yd2WkIQAD52Sc20Cu0U3Y+J5Io3loh3JYVZpxhbX?=
 =?us-ascii?Q?10AHDz9zHcQfEFP0/srOAtmcG5lrfCvLn6zfi1XK5bI/yxD2QiC9YGeDQwjt?=
 =?us-ascii?Q?6W9LpCaf+y3c6sPMw3+5vob2jj9GxGDZL2R2IAjUkwNqxnDlVcQ/NuyoLPCI?=
 =?us-ascii?Q?trB/IMGUlyEONB5jFIkDtXnsv7aSrfX9HisFWGZnu6I1H6DNeIjYsoptOffu?=
 =?us-ascii?Q?+sUxVGT3XsMUY2MqMosFGyp8SUx4JDh9EfaIe+gYLlyI6SrTdfTOBypb3C9s?=
 =?us-ascii?Q?6ZCBQsBx1OB5vBMmb4mexSiQuROxoVOtqYu96xbrDzJXi8CyQYkZlKskRhvy?=
 =?us-ascii?Q?77Ts7F0odTk0VV9Cy2tC2YoA85LeQYSBHf6lxmxG4G/bbOBuOTPd9MwQBHM/?=
 =?us-ascii?Q?Z+OwnWZ4O5UYwT6th6sKlFV7qx8/Q9FHrravFfVbLnPiR8W74f+0NEJBFr2c?=
 =?us-ascii?Q?HR4nDkGjsOOFqTchn+SRMtOEqkJBOtZ6rSS2JRE+d+Ev7Gtw6iZZeeS44lKM?=
 =?us-ascii?Q?nzFfcrqnY1728hvtNr5ZMb7JJPdvVhXHFa099TEnM0uDsttqIFB8mLDXoC+B?=
 =?us-ascii?Q?9qLhtjWvC3cPKWxyTIVUnA/vF3LCjg2+ZJIe32G/b5co72HciTBrjzk5KIfN?=
 =?us-ascii?Q?vYRbrZBV3zo61uvMgzd1nE2c8KytzY9pP3Ojiv6e4zk5y9wKIhhc1FmqNsk9?=
 =?us-ascii?Q?goV/yVrdO3X2QEmuwakIYuSy9q1AxMnHjlcdUfTul4sHRYhsBSPn5c9bcS7a?=
 =?us-ascii?Q?d5ToktHki75Dc+Gv0xfycXT2vH+1eXpGs374eJpYVh8dT2RtJpesCHuvYi0E?=
 =?us-ascii?Q?c47F5Vhl8UD8urdEHJEYazZbm90+/fVxa9qy7mSon4mOEJmMyTmeXVvFeEuq?=
 =?us-ascii?Q?lgItCJf82BWH8PZ5cZm1IezOtXiPfs13cDeWOSXGp14N6n1rwJ4vVjVOiwyS?=
 =?us-ascii?Q?2bT8FVs8Kt2eHJFw90fNAPrV7EClxE94ct2ggeGvhUycBJmE9/wnrv+DAyic?=
 =?us-ascii?Q?gLny3UHDIPUnKyPyIpwSNoB77KORq95lWHhRj5A3/ZxVjVTF9OT9e0NKWH/N?=
 =?us-ascii?Q?Y0zuKR0EMO2YGgOn2aJbP6yxOKla9BtrHyoDjzoL41Y/hy2I2/Duv1ccBZKX?=
 =?us-ascii?Q?j62Rp68kbT8YLyofgK8PUjF1bT8IMPNgtRJgMdMFv+1cVx9VhohOt3UBLajU?=
 =?us-ascii?Q?4/bI+QCeJ5GIf+/RS14JIdYO8iwzSqFfxl5+FOVAnwjyaDTzWXQx3/GTKl09?=
 =?us-ascii?Q?r5xc9cWQul6vWURfIfeL2wV5AAoRRzky9zCsAi5vzgqmr7EUgjUpQKiFAG/8?=
 =?us-ascii?Q?I7LW8TkKb9E77t6rP15SJVRG4cAPEWQpxdtND/7sezyrzFH/68VoxWBnFZ6B?=
 =?us-ascii?Q?1A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a2901dc-ca6f-480d-3eef-08db52710774
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 22:42:41.7883
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8Zs2CtOMnNUR+c8a6M28yni68sDgibotLVt/5ZlN7ByxN6Ylzwtmr0FNrM/UeAMkRsNLY0rjJEuimfv/PEfMKZptjoHqhY1yiRKslVE37ds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6424
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> The patch that created fake NUMA nodes for CFMWS windows

"fake" seems the wrong word to me. These are first class Linux NUMA
nodes in the end. So to me it's the "patch that extended SRAT proximity
domains by the potential performance-class windows in the CFMWS", or
something like that.

> not defined in the SRAT, made wrong assumptions about the
> SRAT defined entries. Specifically, it assumed an SRAT entry
> using cfmws->start, uses the entire CMFWS range, start through
> end. The assumption is wrong, and so the ACPI driver, needs

I also wouldn't say it was wrong, just incomplete. I.e. this is just
extending the heuristic to say that if the BIOS describes *any* portion
of a CFMWS window with a proximity domain, might as well reuse that
proximity domain for the entire window since everything in that window
is expected to be of a similar performance class.

> to examine the SRAT created memblks more closely to discover
> partial definitions of the HPA range.
> 
> This work-in-progress addresses that issue. The first 2 patches
> introduce numa helpers that are used in the 3rd patch, where the
> ACPI drivers parsing of the CFMWS is updated.
> 
> The patch commit logs, especially Patch 3, describes more
> of the approach as well as other approaches considered, and
> questions. So, perhaps, scan 1 & 2, and dive into #3 and 
> confirm or refute this approach.
> 
> I did not include our NUMA or ACPI friends in this posting,
> because I want to get a direction check from CXL folks before
> addressing how the helpers can get merged into the NUMA arch.
> 
> Thanks for looking!
> 
> Alison Schofield (3):
>   x86/numa: Introduce numa_find_node(start, end)
>   x86/numa: Introduce numa_remove_memblks(node, start, end)
>   ACPI: NUMA: Apply SRAT proximity domain to entire CFMWS window
> 
>  arch/x86/include/asm/numa.h |  2 ++
>  arch/x86/mm/numa.c          | 36 ++++++++++++++++++++++++++++++++++++
>  drivers/acpi/numa/srat.c    | 32 ++++++++++++++++++++++++++------
>  3 files changed, 64 insertions(+), 6 deletions(-)
> 
> -- 
> 2.37.3
> 


