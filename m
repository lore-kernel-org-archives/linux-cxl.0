Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E8CC04A6A
	for <linux-cxl@archiver.kernel.org>; Wed, 16 Aug 2023 01:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241142AbjHPBwt (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 15 Aug 2023 21:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241141AbjHPBwj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 15 Aug 2023 21:52:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9358210D1
        for <linux-cxl@vger.kernel.org>; Tue, 15 Aug 2023 18:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692150758; x=1723686758;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=dPcR/0w+wS/kyOCCiugItMooLOgCW6nS/Oxwi26SXME=;
  b=jXa7oCmNvc9v+tSk1hUrA0kNxQgvy5ndp4nRrkbIxsL4xn7/S71xbLwk
   exptMoqn6iYBwe5D2S9yHu80sZTwZNuDLfkMq5wEHliPlU2Ve2rvYYjoB
   kFVtbQ2baJlAMItS8cAX7HhZ9bAQrPoTAtYyOjeE7v0KvoIvsPzYlTseG
   yuNlyCY7i5kcz5a30sM/4fOJV2UoXEmbOjkuvR6+cIaTaPomY93FplXyd
   ZAX/HSJJYVXGgYAvhSu+MLMxujuCmZJH3r8KYqef2LllEmBHxJkKzSL6J
   hFiJb0qaDgZkZ7yHZwVySVnKQgo7bzuHF3Bf7Y5zXpwVryN8o2wfSBh2X
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="352746827"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="352746827"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 18:52:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="848291172"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="848291172"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga002.fm.intel.com with ESMTP; 15 Aug 2023 18:52:38 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 18:52:37 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 15 Aug 2023 18:52:37 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 15 Aug 2023 18:52:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOUd3cXl+sbmPud2tsppEdDHwBoogAQd0FZVb+Dx7D8aN+X30Sitha1RMc379QZakCePztd8Hl0PHbEtVXRIw7A9WxQqgX7CaHSckB/P66HpeRVpaDGZ3gqKd36KG3AMRrcwQvTgtWWcwvvluFIWlaKKlSy9kOiB/xs+SFidL1IpjunI1QeDRe0e0ThGmMgCrXnCIAwOGjkr/iXncCICbWeHpqBB0D0eqFm0IcumhsnY5bKLQxvbo5DnSzA2Nm6DRKm/0fX5lMj0LAEcYviYDhZzVNe5W4uoPwHUUQkcDvISYdiBu0K/uxzbtOR7iqUM9wIsodXRBHWmdZnMGdKIBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Q2roAgVFDq+kf4UnHQ93EeN2ZoLl0fANYDllMwz+hM=;
 b=ddQ5/67Qc0espcSjqa2cjPzt6yWy5OCO+ha54K/ZWvHHSvIG4ua0NdLSMRy9j9LV69FL9ZvjdrIhVGd7y3M/LEfoZ3xdWuph+ekfYa+prHI8Y0G7h+aImc2c+QLqNQ/qOfpAG+m4PxPkQJDHCIR8m4S5WUhf3fNBmWvWhZ4K2D8vDHfqcQeDSXudRPqHJZXHnlAQximLwru87fsoYa9nFwOLvfRWCBkJ0PIYsjn5+uAHCNP2iR52OCIEQgsTaLrVwpM8xlhHS8Ucv7QDPd/t/hXuUK29jOZA+0nJ164c1kbeBpm86JTY4U1qvhs9CSYC0buyDnMN/80Bz8ke4YOl0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7707.namprd11.prod.outlook.com (2603:10b6:806:322::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.24; Wed, 16 Aug
 2023 01:52:35 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6678.022; Wed, 16 Aug 2023
 01:52:35 +0000
Date:   Tue, 15 Aug 2023 18:52:32 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     <alison.schofield@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: RE: [PATCH v2] cxl/mbox: Remove useless cast in
 cxl_mem_create_range_info()
Message-ID: <64dc2be07dc3d_5ea6e2943d@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230815172052.22514-1-alison.schofield@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230815172052.22514-1-alison.schofield@intel.com>
X-ClientProxiedBy: SA9PR13CA0167.namprd13.prod.outlook.com
 (2603:10b6:806:28::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7707:EE_
X-MS-Office365-Filtering-Correlation-Id: ee05a11c-4c87-4caa-1eee-08db9dfb7677
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VoOtv71YzPSY1/3tpJ9k/ui7qsMSvz4lcoAqiX0gry9e34lQ0S9VavoU7z1c18Y5kZWmurKDNpalp3muqHdwPnDttwVin8U/9qOQnBBO8DvGDjW3D+Z7Wfez06JWYwAB/C+lsxXKJpdKDu/trpW74Io5h7yNvytedIgGPfT+kzyN0C/LrIGIHclHjcd1JAh+ZTqxq4pxtqX/4UH6yG0s3XWahGufsCwhMvlmWQ5nEqgfltKIDlM3L4Wn/JK7DgJC2Iud+zc4+YKrxjvvSbztFg59fhr7Y4bVeNyR6dIxSVxN+Dn8HhstCynEaF5rlVcOMr2vEUBgoTFWtfs/z91H1qYScHlaryinIbGy+E1eqvC07LF/BC88r++f+ZSC7ipsXtPfifWEuo3/falumEaN4cjpDGkZn3tMIvh3XyxdE3eOHhmjcLzimdOjHVkmS0M9Y+X1LQHp3LdW94mvCde9HvqH3f4z7oQQEdlyKgLKA7CuF+lhBazSpWLxR++GK4yJrLIiwwtbSJJ5aSoURyZcHyoPq1lvMrRo6F+Hc51Ebf/K3Ij+nSMMjBzgWlNU8ZcD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(396003)(366004)(451199024)(186009)(1800799009)(4326008)(5660300002)(82960400001)(6512007)(6486002)(83380400001)(316002)(66556008)(9686003)(86362001)(478600001)(4744005)(66476007)(6666004)(6506007)(110136005)(26005)(66946007)(2906002)(8676002)(8936002)(38100700002)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/6RBQqGM+Tf8V03XNU+rzXRr+X2gQremPFrkxCzeGoAVHsVOGSaB1dJHYziw?=
 =?us-ascii?Q?dhWwUDuk+U93U4D0hqkU6J7NgeDalEKlDe03BKJds68YGstxaqXrO4NQ8aqo?=
 =?us-ascii?Q?MoGmkgRDlAETtRNGyPJHQa43BmUqeA98HH0E1/6shxZpEDZE1lMgK3bPLp9d?=
 =?us-ascii?Q?rOvpoXvjuBa3IEToaFntzjI33pKIQoUDmk1A5aw6wtWMhgTQREK9gHB6jnF7?=
 =?us-ascii?Q?jgJsx7sG5XTbIeg7Auz7NgXXWc1PEKY/TQGWNdkvoOwYJ812taMpIpwyR1pZ?=
 =?us-ascii?Q?arKfG/bJYGsLQvOZkUXmYB5fObvczoqAOmpgegZn0Nw67aXLth0F+U4Tq76c?=
 =?us-ascii?Q?Y2eZFIt73Vemr/Dgyw8XwFwIJxmve+YyLMBcBWSc+IJE7xwfqLSiL0S4ELMx?=
 =?us-ascii?Q?qQWC0elsqYGcsnAVuHm/TmhrzGyzeO2USkTkoNihgRX35bopZutqvUP4fsmQ?=
 =?us-ascii?Q?ULQ2VJqIQpeSmOsA9EYbExkBVtO4IonO1SOc+Vfa2F2MegcEnSMapv+xltfn?=
 =?us-ascii?Q?vQKTmZMpCuXUTkQGLRQA1l/Eq+NEIq6+8FEJMbPN0cABYe63UREnl6wGad9O?=
 =?us-ascii?Q?gBntfNr7w9zkun/JFms+qzQ26zu6mPsm73LhG2rUzrFw+NNlQHEszhFXz6ee?=
 =?us-ascii?Q?hucYixxyOoKwXoACFxB+xso0xq/tYb3Mslh3vy8CPf2UGotiDjRnQKFvrAB/?=
 =?us-ascii?Q?DHCFSgGQ/uclVFBwIH5XL9kOTDjllk1txAxPnF7Sa1wHj8MyWHeVbjlXJqxj?=
 =?us-ascii?Q?p6iYJvSWvdTnKXVwxNidWlokbkVXsVFUrqgBDRpojb2mDIjO5BccJFqvoKoO?=
 =?us-ascii?Q?zhQNG9YtRVH3C1eok3W+imv9CAuDxf8tnL2bb4YQrLE9t+njkXDNvMQReVea?=
 =?us-ascii?Q?cnVUArVL6FWe0mTsAsDIWNdV7KXybXdXFWhQlvdn+SQLsR0SGRt0y4wPT0vQ?=
 =?us-ascii?Q?8n5k40uQuXWNAcirQcozK9zFbxp+2sH3N95T71dZSzRIhpWPk505KDx9999g?=
 =?us-ascii?Q?o4LNd5t3Xmof/oB+jnbG027PzDNfsOqU+ihYsZyXsKD2HDDOgDJgOVP4nuIM?=
 =?us-ascii?Q?MHzUHzN6decdmWWdxRsYvVh9skglEO1cq5o6LVwn/LKcuotbZnX+FuBAsVbs?=
 =?us-ascii?Q?J2Ws5IhvUORp2WGz//FsdbHuW+XtLXtnqyHoj0LOBjMp6a6fZoNr/gVdeXJp?=
 =?us-ascii?Q?KX4ZVyCWNasxeRoiXQvYLUJZwjdOoc04WfNrdTjwLRC49b3IjK30tnot+Hzo?=
 =?us-ascii?Q?e73qYpY1K3s/KdtjFQP3fPU6R4m8JCr8SR0J+ZZYYyYgkd1Xncujno/8An7c?=
 =?us-ascii?Q?Sj5hAykeXwVm+29GdMYw3yekcTReN91gmmXloaSadopJF61RVrBQ0Ps3YgTd?=
 =?us-ascii?Q?FdrPFvg30F+wbFo9fSzk5jv41oRpKC4Nw0WWv3zlA92BbJP17O9wN+ytxE9u?=
 =?us-ascii?Q?hoIoDSiRWEimBKd4F+7tgv4QnKyypI74bdwopVAqffAjmbzaPI4/10KtXmVH?=
 =?us-ascii?Q?bwE/bK/q2bM1NteDeE/rBxI9NyM9OUVyAbNI83PWKq7xUoVoHvf3DfKcXOEf?=
 =?us-ascii?Q?ktkrv3/rileaHW2XgGzCoyFoVDstCRYZV0+6RlZawlJe+0Q6IRVnRDH6JZf3?=
 =?us-ascii?Q?+A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ee05a11c-4c87-4caa-1eee-08db9dfb7677
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 01:52:35.4434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aBaqRPfkf68RkF7/iz1kMPBMpmGuRTskKHLEBfo3HXUSA4VSdtIbOueWnMUw2YPrx1zqspktgo0k80vsBpohLCY4d559rfZjCoG+ZmpZMMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7707
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

alison.schofield@ wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> DEFINE_RES_MEM() is a wrapper around the DEFINE_RES_NAMED() macro
> which already has the (struct resource) for the compound literal.
> The user of the macro should not repeat the cast.
> 
> Cleans up these sparse warnings:
> drivers/cxl/core/mbox.c:1184:18: warning: cast to non-scalar
> drivers/cxl/core/mbox.c:1184:18: warning: cast from non-scalar
> 
> Fixes: 52c4d11f1dce ("resource: Convert DEFINE_RES_NAMED() to be compound literal")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Looks good to me.
