Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7FD7C25B06
	for <linux-cxl@archiver.kernel.org>; Thu,  4 Aug 2022 20:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239062AbiHDU0a (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 4 Aug 2022 16:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233368AbiHDU03 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 4 Aug 2022 16:26:29 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC9125EB5
        for <linux-cxl@vger.kernel.org>; Thu,  4 Aug 2022 13:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659644787; x=1691180787;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=D5hwgSuImtMNt1Pxav0gmM5on00+GGDaGoW3HjSQ8fY=;
  b=iZesrFvPulzNqmhXvu4GzErr6sBUVWpA/0xnjQ7ihOEQq8h7vaMolM9s
   SiqMRh81uCZKH1v9OAOUKwG0EESZYoZ7mawR5X9fnamnhMg3dxxxbXsmC
   tJUPtaNKazwr6WjS4ORF0j9OOYova6bk50JbIgiZ/FNFa9NZk2FEkrVb7
   xXSAG4NGMCY8jJWEAQpmXLoKzuc+PvSaJ8NVmIqr/JSl+8osSA8UJbGmm
   S0GcVyCPB4+eFsJVn7Uzp4gfboi1TkW7lr3mjEpQhqyQ6qfZlAeUwRUqq
   ZdgTbl+hpivfI5wFhJ4oB5VJLLsYwouksoOI7cEJD6LkBkSFsDsv/0Q9H
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="376335515"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="376335515"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 13:26:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="553854639"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 04 Aug 2022 13:26:26 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 4 Aug 2022 13:26:25 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 4 Aug 2022 13:26:25 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Thu, 4 Aug 2022 13:26:25 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Thu, 4 Aug 2022 13:26:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eAhp2svtFhtYURnLNdK9jGfp1lViqiGvHZuFLzFcda3+V4wR/lHXNkMRTE5gE41xSD6hSWuPTCzsD3Z3+L40BcDyPeSTGS8Km8JPtzgGAE/a9VfgT+31vyjZOwDqIKCLEW5Ege/vg4KWWAcmG1zZZeOjycA/kJFQCEevMv8gWieIhsYqOSzZaHsCWEyhn5U94OL+FT3B3IMiRfWAM4dMCQyJ3AJC418xT5FKUXyTUdKzcKw7joAGlXfhXWIcBIQ58/PD4BbjXwbXwh+9Ecu8nKK+bl6b3rDV/sovB1yN2XMtmwortPpeuw4pMu+rz16rcoJSOvVgYdZmMeuesI8iPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L9K+8l3rCfzu5/T1/ZLEGc+cPV2tG6o1yIjfwQTGBmc=;
 b=YDgbXAvuVB30GDeZJSXold6HzU65WL5broQSY5DWnq1QfF9df/hJob8+NSivsLywq8z5OOB42TO+kIonEirTADteJpmznqUod4gt5S5guty212MKo62uCosTqzrtBbvdY/bY/8TROdqOLTpCHqwfzSuAKCgtsz0cmTs8ywn3i4gQtGsTYfC8vUJcjNhRu8gLgBejNqKtXVGM8qk3UeE4lBTJ9SMlApG+tTTthP5J7+MiXQrWKRuWfj+9xCrBELDTWuu32vm58UFv3czNHjHS68RnRK7lPAWrqVr6HAtcDvJwNp/JkFzkXZcsq9CYcKR1PKv7h+ioZK6XJBVTcNw3kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 (2603:10b6:301:50::20) by MW4PR11MB7125.namprd11.prod.outlook.com
 (2603:10b6:303:219::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Thu, 4 Aug
 2022 20:26:23 +0000
Received: from MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12]) by MWHPR1101MB2126.namprd11.prod.outlook.com
 ([fe80::9847:345e:4c5b:ca12%6]) with mapi id 15.20.5504.014; Thu, 4 Aug 2022
 20:26:23 +0000
Date:   Thu, 4 Aug 2022 13:26:20 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, kernel test robot <lkp@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <dave.jiang@intel.com>
Subject: Re: [PATCH 3/4] cxl/region: Fix port setup uninitialized variable
 warnings
Message-ID: <62ec2b6cb463b_881482944c@dwillia2-xfh.jf.intel.com.notmuch>
References: <165951145706.967013.3023584411011908037.stgit@dwillia2-xfh.jf.intel.com>
 <165951147487.967013.929590444907251028.stgit@dwillia2-xfh.jf.intel.com>
 <YurnLuV5Yin5JnkK@iweiny-desk3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YurnLuV5Yin5JnkK@iweiny-desk3>
X-ClientProxiedBy: BYAPR01CA0047.prod.exchangelabs.com (2603:10b6:a03:94::24)
 To MWHPR1101MB2126.namprd11.prod.outlook.com (2603:10b6:301:50::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03b7a072-1d77-413f-ef4b-08da76579902
X-MS-TrafficTypeDiagnostic: MW4PR11MB7125:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fV/2RB+ImVD4xUG4ORF2Clz7AzWpXM9nr5ccCaSAzcyHesN5UFYCLAa4hHqJlldYNaf0b592CJRdXtdGk5yRWLtp9P6wJ5Tf7n8txvZKqlfP1NQ6pDeqnJZJKxJVjVzfCfCoACIZH8bs3PtqCco3w7O10cerfI2T/zyCOgS91HDV3xen8LgBtCqE3YqoxHAXGh7NK464tcjvNfuRJ4C9yaPVHBg8o8RRgueYTYrfWP3H7avfv9LwiGsbi2XwBaqbXKEcC0b5FRwbn6H9iGwrj8LJLaga4d34zCAJYcUdkX4OyneXtmJFMmSWK5FIoqoZRhYEaIIXVsweJ9brD+GBXhlPCK2tRHyOt6w4ESdaKpLOpAK7O4MTxfdtWSzdrpx2kXT2m/OHhGhTdqAoNyFi+TgR/T5dNLez5Tnj0PF06sz5Gt3SVXU9rlkNqrWMO0qxlOJki7mu+a8L3UTaeyV/iWc8Khxf1aOUQzVezwoibsCY8kFnLsd4LwIoxwv5qhdoioZAOp6o03w6UTuOn14X3xKAg5OnHsN+q6M+4Lr9D1BcEXhCg852c5tke9503AYATKItCa1eDGLoXeWVnWdSwmY0/DVR9y/AIhy7s9Mh9XQXWLd/d38DN7kq1YuWJ9gYT5PrOd6fpp61oykR1xD0h+kIdCcfNmk//i1IxetEogbnarnVHXs70dGoocVCTn7XB//eObSCXdaUL2J9u3jBDyFTNeKTjp+1nX1yAog7udJ8AwW9+TYsrrnUSZtr7XBq
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2126.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(346002)(39860400002)(366004)(136003)(2906002)(83380400001)(82960400001)(9686003)(38100700002)(6486002)(66556008)(186003)(4326008)(110136005)(66476007)(66946007)(8676002)(316002)(6512007)(107886003)(26005)(5660300002)(6506007)(478600001)(41300700001)(8936002)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?USbCDqGWoVtht7hCQE4pQf69qlQvQfY9q1AKXAqs9YvVTr506ByQqRh6JggG?=
 =?us-ascii?Q?JqjOgNh4ZSMbhJiGTWXeYSuRzWuJ9FkUJzhlxIH4RJ3CFZ2gb36U4Pp1pheL?=
 =?us-ascii?Q?zOFP+8brN9V0LsH0ywhdibTAvJZFTngDPrVQ4UPZygJgd95JgmmJfQUxwkEP?=
 =?us-ascii?Q?xe4vFyWLsTwC6JfP8PBhr34ZwkvjCchlQUeUX5HSylfwHhPY7x0F06g9iKGt?=
 =?us-ascii?Q?tpG3GwHUx95tpK7fsMePtDUv/1Fzim51DNwU1cjqXI0DJus1w2Cyy4SKMnj0?=
 =?us-ascii?Q?nsRn1IA7SUSKY8JBb1WfOK61TO+ZPwVXsvhbH4T45AYIE3f7bXTIjbBgvl7B?=
 =?us-ascii?Q?TEgAkKQ6X0uypIninPnJb8/zlx3fb+rNo4ku1iGRlAlapz7Y3w08s58S78bz?=
 =?us-ascii?Q?z/c5R6jARsBnHmiq3qNC3+NWRNVhctH05/4yi2T5bI1SEJRAgL6Y2MRN52CV?=
 =?us-ascii?Q?YC4sZcL0Fhb+7zMixLTRcsF3W+fE02pXwTWhGIDldP4V2a0m9DULwO+LcMkg?=
 =?us-ascii?Q?qhKYMUVdjl+QXeg339IDegn7mkYKpQHCKkjSVKp3DlWECr9R1RYyZDZu11Fr?=
 =?us-ascii?Q?9B9DhXVHsCcEFa28RYr/BpX1fAYPM9M6g5RHNhq/W5Fzf6WaTc7+yQBnVeDH?=
 =?us-ascii?Q?4Q+oBVfkwzZUj0lZ/HIdC5axzmgi1L9zFsXExNp8p87jRaL5D86za9CxCG3H?=
 =?us-ascii?Q?jsNgSS7aNZK6Dw3WCxej8xgMxQmXuIQCzpJfcbCZU3tyYTDPrEwYUJuLrX91?=
 =?us-ascii?Q?MSziQGwx5ORpjFrjdLh7vL5tbshy2NKh1yG8PpWRaOGnAiV098TvUQaFTPFO?=
 =?us-ascii?Q?uYZ4Ybc8FLNc0QK2tQNnELaBZQB5byKpErkIIQEc1tmR7QLkmA9Hv/uEpbmz?=
 =?us-ascii?Q?e0k65AyBtROK7QgX4UmnjhL9zv/H8I5+niFrgUqHVQ/9K8WcVGsjEzzj0/lm?=
 =?us-ascii?Q?+Q0DDfkTKbwZtBcsYma4Ako/W8vG7ZWyZwq1Bzc7/yyDzGSYGHl6RydVCJj0?=
 =?us-ascii?Q?SoBxKETQIMSCh0JgTmVyMFO7buVy+eCJ5jhRlB6SgRrLc5AqPhtSSFtRkkvh?=
 =?us-ascii?Q?FYGlG5dmtFGjzNeWUmHC+LkCkHUjc8YH5F9vvbxNmMrShW+fCM98RcM7wfpV?=
 =?us-ascii?Q?A2kY7r3WYa9X1icJRCIJgFLyNnFYCWwFYMQpi0n9/UEszmIqdB3INfllcZ0m?=
 =?us-ascii?Q?Mp8UKiGiao+gSx8DknO1ze3EvPBzIcanb1L0U5Ayw3ID3saFTKfXkVjQHK8u?=
 =?us-ascii?Q?0WrvASZPre+WMgLU0K9cQMP0LNSQzM5IJedaQ6+XOzPWwNtEC3c0jwZ27WJy?=
 =?us-ascii?Q?KQvsIdMaQTZ968ZEyVz+Cf0pnaZQAYwimr2lOc4736hQxAEbRrtQaIGyu0ry?=
 =?us-ascii?Q?o47hpQ5UsEoINbQGO7GWQAKLfgYvMTDzyMXRaLHf16cKW0HxA4ZmqPfX9PX4?=
 =?us-ascii?Q?ZwZ8YERSScH0QcPANtCJoCPtkdO5NDjQYw/THFKOFDmadPzzaFfJAETHzNXX?=
 =?us-ascii?Q?/qThFET3Pmmye4OSZTqWnSuHGvvE/A1gH9uegxZxYdSfFgd69Lgipgb5Fo3p?=
 =?us-ascii?Q?mB5rbK3istqSDTyEfGMgArMb6GVYRdsZ/Mmn+00pwz4OK6AL5Bw1MK79CxEQ?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b7a072-1d77-413f-ef4b-08da76579902
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2126.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2022 20:26:22.9403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2N8JnDipJhNIZnT9lFQOav7gAxhj0UpvSyCqyTC/43O3z7nAKyO3vj/klBxe3Z+07itICZrLnhCW1ajbo+apx/za3sgzS90JwNsfdg8TOXE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7125
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Ira Weiny wrote:
> On Wed, Aug 03, 2022 at 12:24:34AM -0700, Dan Williams wrote:
> > 0day robot reports:
> > 
> > drivers/cxl/core/region.c:1068 cxl_port_setup_targets() error: uninitialized symbol 'eiw'.
> > drivers/cxl/core/region.c:1068 cxl_port_setup_targets() error: uninitialized symbol 'peig'.
> > drivers/cxl/core/region.c:1068 cxl_port_setup_targets() error: uninitialized symbol 'peiw'.
> > 
> > ...which are all valid reports. Add debug statement to consume the,
> > albeit unexpected, errors.
> > 
> > Fixes: 27b3f8d13830 ("cxl/region: Program target lists")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/core/region.c |   17 +++++++++++++++--
> >  1 file changed, 15 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index a073f16355ca..5c931b6eb4e7 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1059,8 +1059,21 @@ static int cxl_port_setup_targets(struct cxl_port *port,
> >  		parent_iw = parent_cxld->interleave_ways;
> >  	}
> >  
> > -	granularity_to_cxl(parent_ig, &peig);
> > -	ways_to_cxl(parent_iw, &peiw);
> > +	rc = granularity_to_cxl(parent_ig, &peig);
> > +	if (rc) {
> > +		dev_dbg(&cxlr->dev, "%s:%s: invalid parent granularity: %d\n",
> > +			dev_name(parent_port->uport),
> > +			dev_name(&parent_port->dev), parent_ig);
> > +		return rc;
> > +	}
> > +
> > +	rc = ways_to_cxl(parent_iw, &peiw);
> > +	if (rc) {
> > +		dev_dbg(&cxlr->dev, "%s:%s: invalid parent interleave: %d\n",
> > +			dev_name(parent_port->uport),
> > +			dev_name(&parent_port->dev), parent_iw);
> > +		return rc;
> > +	}
> >  
> >  	iw = cxl_rr->nr_targets;
> >  	ways_to_cxl(iw, &eiw);
> 
> Do you need to do something here to fix the potential uninitialized use of eiw?

Yup, good catch. Added:

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index 7b794147bf7d..ab99c1c3b2e9 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1004,7 +1004,13 @@ static int cxl_port_setup_targets(struct cxl_port *port,
        }
 
        iw = cxl_rr->nr_targets;
-       ways_to_cxl(iw, &eiw);
+       rc = ways_to_cxl(iw, &eiw);
+       if (rc) {
+               dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d\n",
+                       dev_name(port->uport), dev_name(&port->dev), iw);
+               return rc;
+       }
+
        if (cxl_rr->nr_targets > 1) {
                u32 address_bit = max(peig + peiw, eiw + peig);
 
