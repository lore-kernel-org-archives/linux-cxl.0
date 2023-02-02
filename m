Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352E9C61DA4
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Feb 2023 23:58:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232240AbjBBX6s (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Feb 2023 18:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjBBX6r (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 2 Feb 2023 18:58:47 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30468728DC
        for <linux-cxl@vger.kernel.org>; Thu,  2 Feb 2023 15:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675382326; x=1706918326;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=c4BxY/IYHdleRJ0Tm1uAIFgh+evZ9FF/cJaBi9wdJ+I=;
  b=HGymQGhL5kyVqkmnn2qwgXDXlN+cymAgBtEiqlQ1FkN/1xWDeGHdzqFM
   DcNaiGfbQ5GXDYEu6UXCii5PM8WcHvQ0fETa3ZbnAi47BtCk4hhh2yU1/
   vwL8PeZgMW25PXQCRPJ+iIN9Xpm5AdVTEq3S58FrlarnLZ87ekgDbTNZI
   0tP1etwIaJ4nOZc5FcEOjNbN8hA12fUSCEsv9MQCPnwjMp778PtKwpWLA
   Tk9MZ6qFGQ9DLooqz6hu0wJItHENomKzncRk++qP3ZCAJY6Bv4wQN040m
   KWu7HD9t0KAz+jmz+UgxZ/RE5FOozSKQYY7CjXMpRtaUKbiC4tFASfLjO
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="308251715"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="308251715"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2023 15:58:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10609"; a="615503445"
X-IronPort-AV: E=Sophos;i="5.97,268,1669104000"; 
   d="scan'208";a="615503445"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 02 Feb 2023 15:58:45 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Feb 2023 15:58:45 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 2 Feb 2023 15:58:44 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Thu, 2 Feb 2023 15:58:44 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Thu, 2 Feb 2023 15:58:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZlGGvs4XkuvbhUODJ03MgKZ2ZCMyjJ9Q9EXyhHtzcA/Oj0d77IRpmAHAg/dEPPQUtwXtPH3wNuq9t9HDK0R638HkCa+FFcg5Ly5pzfgK+r996zgC81aocGxfbr7iL0mXOS5A1Whg9fzFzmRU6Bj7LEQdkum2lWIn2tAZyEqCROl+5bnRFk4dA7F3jFzocFMhui69r9gZ93Zy5+B2tSVIYjz2DiEYqeIKpHY0GYNAsCtR7gAteN3LAreQ0MavYt2elT7wS6K8DamRf5tHYMJJtlG0d0DzLpG1n745yBUXGhalD+dv0XXxZkrLJPsM5/VRlq05XBqGanwvyX1CjxJayw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C5dxnuKwxKKr+Q5R+qKzmJjxZ0/uBEJ7Ob4Ar2BBUOk=;
 b=S+O6/gVKC1+RneoW6nhVDCoh+zIRDh+y6nL8qZVLhajZ+xVwSO5QAZs7+2uwLsdaLtYq/EMxE1E/+ldMCc6pJ/znkI0MlAad/vsz8okeqrURaI84BWyifItp0z2NCDgUsl6fjTvGKE214hsw71lFgr3teQFYSg0mA/teaSUsB+9xlqNDEvyobqJS5q6LuhoeP3Mtw3lRr20i9Oz6MTKN4rjayNk9Evm3iBQHHuMwCqykZUTLxyVXAxKyaeIgrHkH6EXCkgd5TLZX+rK6L78XtgAXtl2mH6QYxgE2cVRWV/EZoXy7svP9eMzDY7M8+pPizhlvmWUKK86+CQ5VmzJiNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by PH7PR11MB6354.namprd11.prod.outlook.com (2603:10b6:510:1fe::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.38; Thu, 2 Feb
 2023 23:58:41 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%9]) with mapi id 15.20.6064.027; Thu, 2 Feb 2023
 23:58:41 +0000
Date:   Thu, 2 Feb 2023 15:58:38 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Robert Richter <rrichter@amd.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 3/4] cxl/uapi: Tag commands from cxl_query_cmd()
Message-ID: <63dc4e2e9de47_d9655294a3@iweiny-mobl.notmuch>
References: <20221222-cxl-misc-v3-0-60d4f35e4b39@intel.com>
 <20221222-cxl-misc-v3-3-60d4f35e4b39@intel.com>
 <20230202095821.00001a98@Huawei.com>
 <20230202100125.0000590a@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230202100125.0000590a@Huawei.com>
X-ClientProxiedBy: SJ0PR03CA0031.namprd03.prod.outlook.com
 (2603:10b6:a03:33e::6) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|PH7PR11MB6354:EE_
X-MS-Office365-Filtering-Correlation-Id: 2927145a-3ee6-4205-0058-08db057968c0
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5NXLRHGmRX3F9L0+twELOSu/t1OFIzpBSOOYkmQqPxFm5joxxXiA3aModvohOsYeETJN6Z61tzc6iO+9FuSgejD6XB5n+8WxF7U1GDJ5n5KV3xqSrazld0vGeS+MnSAP8zj/HFV2t14m8Q5/PYnoeGQUSc5/B+yrvp2cpH8e4DMmrXUFVTWfuPkddpGM5esIMbRVAnk+WG6br/dAwiyZHehhQtMF/NKgC4t5PISvTK/LBFylfCdsRodSgW7MFMCLvgKFzPntdb7CsXOWwCj+kUBKfx+Yd7CHpypA0HkDw/s7gsY9LkcktBBn9vjVjEL1zISMekesR7rE20xEci/yAksoh4rtwxnbGkq12wBPZC8RndSy2w6mGm3thrbVaHrfY432pwftiA5iKFnoV0I+vrZ/pE93VbEKlEf3odSLXX8MpgK42lG4AwYpAhAxFdcBYYDbx2z6eNml5i9HhK0RYjy0smcTGyin99vWwaarRoGP8wzUY+7O/FeZzkYVaf/edy1wmq21gS7qf3zvkBTBIBXxgCLtGWpR7AzJL0QyeuWfIsi0HLouzjiZ48bCOefh3L63iOcrtKh6pRQxB/4+5YPugS6Yo/kHCn8UtxvUqvmJL8YLqMB+7kCsg3m8qgr+GrFkv/YyRg9ELIgdsn3pkYSxeO1yvWVr5UbJrBAcrXqiZKJxwHwvGDggfQJhHxwIUKWjKfsbsWyCaZTzl8tnXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(136003)(366004)(396003)(376002)(451199018)(44832011)(6486002)(83380400001)(6666004)(38100700002)(82960400001)(6512007)(86362001)(186003)(26005)(478600001)(6506007)(2906002)(9686003)(4326008)(8936002)(66476007)(66946007)(966005)(41300700001)(66556008)(5660300002)(316002)(54906003)(8676002)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YJZK4+i88vg60zAqFtW5bc/eV9eED+pYsocUw0PEacoSvGiOxqWsxM1ha6Qj?=
 =?us-ascii?Q?O6zrfHrbSiaCDNAYHjwhLNHzQge67vQ1O+BY5dhrsMgz8HjhtPzYKF7OOstJ?=
 =?us-ascii?Q?T2Kngl9zZk5iC1Y1qrTHqeq7vQPgNj1cKBMFI858ucefSmkX8L/ZXWeaZn1i?=
 =?us-ascii?Q?sUksYjOKelCHv+6GA3ZJbgm4Ia3ZMhW2FOG7f7MduAiFbw6gthuPQXnhyqHv?=
 =?us-ascii?Q?9Sz+u03hsAorXZYg26a/1hMpo5WEb+UHsAUC/zKrWcbLwXWXT6JiG9Z9oFjw?=
 =?us-ascii?Q?dnUHko2nUxlriHJri3RdOFL8Tn3iusGsu0BhF/VNioaDGy7rThtrVIjVGBEG?=
 =?us-ascii?Q?/8N14Ftd9v480jEvbx1qM/ZAWLHEVcq3lSJvLOPhqFIYhq9BxnSiiCBqCe/9?=
 =?us-ascii?Q?NYKf449rVF5ApwlkpxbsREwupHMFSJ9BF26i+Sd9Ga/2O2QeihTZ5FJBsSTx?=
 =?us-ascii?Q?fTj1DaynD+vffNhrI2M3ALgpBXWdyooGFXnfKlHZA7jU+hwBM0OGG6sTsSaf?=
 =?us-ascii?Q?X/HM8GI295BBCA/LxtppgcIDrm4wrc4e8om3agFdWyc6V2ZasHAOvs/eQFlG?=
 =?us-ascii?Q?LubaxXJVP4tJEzpqjFmn0WCxnMKZFtfape0qLNrUZP9dAd+HMyCCFA5L+pkB?=
 =?us-ascii?Q?Rd+JY2x76t+XsFYakKTJOn6KuMv8o/3rLUR+KlHVTknvihs8aTvTWPRdChVc?=
 =?us-ascii?Q?24yeJ7Sn58juTJUkrfjfwlpRHRYnbcu36Z7mPxcU2ml9b6MZzO6H6iDwbkBr?=
 =?us-ascii?Q?Rl10c8EY1FzyM9NuE4GvZ8MDs+/5wqlow47hmsMGwu3elBTHXGLomVQl4A/H?=
 =?us-ascii?Q?F9YcC/ZoXLiwSopoiBeIMG/iluPiaSOjnMJGX42d+/30LP54h7EwCsSZVHbQ?=
 =?us-ascii?Q?FkV6LZ1UKVLBXHfNQMCkxjN3lx6tRLC0TeQxzuzIR9quhJ00x2y1wyucCIMA?=
 =?us-ascii?Q?Rfo22mP4L7Ge7CeWv/KkxRlZmrgWAw0VIKrMVtrMYQGuOXR9VaijPRD5OueC?=
 =?us-ascii?Q?waeTqw3EqnUM3/W5pEiPJDIKEcOdlSVa27PzWFuj4EvZiR429NjO0A9Sgyws?=
 =?us-ascii?Q?LO8fPxCCRXCRSQb0mzXA8zZ9Ft19QMvMiKviHPgoD7bsmVtAIPJDKfSqqUX3?=
 =?us-ascii?Q?c+SzsZUXnmMs6d3lICV3KPlsnZBHStZeldD8P6ZkvxJczEL4S5ovZA0dUbq/?=
 =?us-ascii?Q?/kakpOOupz8G7iVyd8ERk9DmcUbain0yJDeoh2rNDopf/0IaI4JL3Cs0PBez?=
 =?us-ascii?Q?kwApIgtG3dBCoQYUefNdxW5RjikuPcoUiQVUXomEv+qoL4U6tFVFelCtnzlI?=
 =?us-ascii?Q?BEXjoH7ZVQ4O3ZXXQEI9uCujFeHSYoJyGR2BLwgMxoQtL2L6x4gL8o1T1DkF?=
 =?us-ascii?Q?KSUlwQNYbi2Hp2HdiTKqjSUQLSiK8GdfWyP0RZ1RNs1FrkwpxS9eox6xkxtn?=
 =?us-ascii?Q?1SJAh9Wc/2oTNXx4AIWi/Mt8OE4kP/HrmmeHWqvCAesOMnSq2GECxASHPsok?=
 =?us-ascii?Q?2eHA15RBB3ILJvyPVWxJEf+WWd79SWWadV4zQgr1rAnkv1zdQcsZLJuVxIwq?=
 =?us-ascii?Q?HkfX58K2zrqLKEzgJSZRsRn7+CcK08ovQ3J+oEqu?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2927145a-3ee6-4205-0058-08db057968c0
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2023 23:58:41.1694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oOiMNq9QrWboQhq+W2dTxFJRnTDFdDn/2ANJ7mC9juyFSRchTD81+b7d9alsSZA0AOpktTHiPQ8xaz6EVOUGyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6354
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> On Thu, 2 Feb 2023 09:58:21 +0000
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
> 
> > On Wed, 01 Feb 2023 17:23:12 -0800
> > Ira Weiny <ira.weiny@intel.com> wrote:
> > 
> > > It was pointed out that commands not supported by the device or excluded
> > > by the kernel were being returned in cxl_query_cmd().[1]
> > > 
> > > While libcxl correctly handles failing commands, it is more efficient to
> > > not issue an invalid command in the first place.  This can't be done
> > > without additional information being returned from cxl_query_cmd().  In
> > > addition, information about the availability of commands can be useful
> > > for debugging.
> > > 
> > > Add flags to struct cxl_command_info which reflect if a command is
> > > enabled and/or exclusive to the kernel.
> > > 
> > > [1] https://lore.kernel.org/all/63b4ec4e37cc1_5178e2941d@dwillia2-xfh.jf.intel.com.notmuch/
> > > 
> > > Suggested-by: Dan Williams <dan.j.williams@intel.com>
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>  
> > 
> > No mention of why we can use space in the existing defined flag mask?
> > 
> > I couldn't find a reason why we couldn't previously but Dan's proposal
> > was to reserve that first bit so I'm wondering on the reasoning one
> > way or the other!
> > 
> > Other than that detail, this looks like a good solution to me.

The reason was covered in the previous discussion.  I pointed out that the flag
Dan mentioned was an internal one which did not apply here at all.  So I did
not mention it.

	> > I also think it is a bug that this command passes kernel internal flags
	> > like CXL_CMD_FLAG_FORCE_ENABLE.
	> 
	> AFAICS It does not return that flag.  CXL_CMD_FLAG_FORCE_ENABLE is a flag
	> in struct cxl_mem_command while struct cxl_command_info has separate
	> flags.
	> 
	> AFAICS only struct cxl_command_info is exposed to userspace.
	
	Ah true, CXL_CMD() leaves info.flags unset.

	-- https://lore.kernel.org/all/63d85857b1648_8e2c29465@dwillia2-mobl3.amr.corp.intel.com.notmuch/

> 
> On second thoughts. Some docs for the two flags explaining what they
> mean would be good to have (as there isn't a reference to how to use
> them in the Docs patch that follows this).

Good point.

I'll respin with kdocs for the following:

/*
 * The given command id is supported by the driver and is supported by a
 * related opcode on the device.
 */
#define CXL_MEM_COMMAND_FLAG_USER_ENABLED BIT(1)

/*
 * Requests with the given command id will terminate with EBUSY as the
 * kernel actively owns management of the given resource. For example,
 * the label-storage-area can not be written while the kernel is
 * actively managing that space.
 */
#define CXL_MEM_COMMAND_FLAG_KERNEL_RESERVED BIT(2)

Ira
