Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E0BC7619A
	for <linux-cxl@archiver.kernel.org>; Wed, 12 Apr 2023 22:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjDLWJt (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 12 Apr 2023 18:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229995AbjDLWJl (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 12 Apr 2023 18:09:41 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B4306181
        for <linux-cxl@vger.kernel.org>; Wed, 12 Apr 2023 15:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681337372; x=1712873372;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RGbdiBNZMeMK1YvUUcBMyltvpMRjBD73uFmQasEByWg=;
  b=PxuOX3EzUId3lalPLEvJZOeZbI1VgscEMhu8LmvGcGLXcVAQQIgHVsdX
   Yn2XXx+xOpfd+/ese+AxyRBXRJAdBr/Q1EchyzsbzNcAUMXKieVr7HN7m
   7ggkob44/OepGs8hhxPtPZdsFF75RJFxYqwkDh6S1WDwLvaFRvtCGSOcS
   vBD7SL20VeAAkJKeSGt4yWV+S/eitUAXpV3SdT6BPhdwmTcPrc+Prcx4v
   041NkX19q3rzZMtEggPpKw/kzWZFOOUNGWJCXQfa3w6kg4EX0hzj0bq7k
   SrKT0aouTiyeJ1czTboE4TRJVQypfXo26j3yALpCZK52Flp8ZXADpFKaG
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="344031688"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="344031688"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 15:09:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="778464406"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="778464406"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Apr 2023 15:09:31 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 15:09:31 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 12 Apr 2023 15:09:30 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Wed, 12 Apr 2023 15:09:30 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Wed, 12 Apr 2023 15:09:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jSRXHRc7dHcZbaxe2e6JJO4eDEXtFeodP5/j5kFPiZHQdIsIytKLGmFhhLA5JJ2wALXmwXWjlNiWdiz9iCbcRSJ9p1xfkB+i7/bzc77MJpV96lOIpOkXlQ/q6g13fPUPGaUPboI4bhmQhR9IjFw41CZ9b+BP8cCaDJFhCQdqxx1L3u6/6jPVexM8wPIix8mvdCFX1xnsQnvVwTKV5AiS/0q6uxG5yEKbBiEAezSG3blfO0J4NoIF7I6DFQEm6rNlLCI0YPthsXC2U3/btJKUh6IFGxpQHkAwYzVgLctYSmHW8m88bPClSGWnheWQa1lc1OEsDaQzvbq1J83Z5R6emw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9fJ9SXSSAV1KGnnE6VBqwWYxYkDMzhr/SgosaH30KwY=;
 b=NlgeHoedpZ85VPCdCiRl8Qzh2TxTmUzP7L69z1pUrn0iPOars/yF6LehUm/qpdK+502Ks/rXgeHoh4OwXigmLiuhQmv6qftcPXKi3ppR6hH1zX7kdk2/XoMpOCVXQD37L+twVGi+Bi4bSIMyBbGF0ZA1NAnSA8ue3mvZqRM1SRzggVj4rPQgAbGynluGB3jCNjgKBQhwnm89tNjdGQik9ezECIvWYA7uo0+mYk0qrkBQ8l2HBL0+JR1wnyCGK1dSQVNK0O6DKyoOQKJpPFVvnibx1OIx52SxwMlUsFZnUVkUl5yiuSebC51plLNIPzhToQqoSYm+r8aVlVko1dDhGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB5927.namprd11.prod.outlook.com (2603:10b6:510:14e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Wed, 12 Apr
 2023 22:09:27 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%6]) with mapi id 15.20.6298.030; Wed, 12 Apr 2023
 22:09:27 +0000
Date:   Wed, 12 Apr 2023 15:09:24 -0700
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
Subject: Re: [PATCH v12 4/6] cxl/region: Provide region info to the
 cxl_poison trace event
Message-ID: <64372c1496809_5f7562945f@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1681159309.git.alison.schofield@intel.com>
 <92a8eab0aadde1c65f57e03d1ae0160929b23921.1681159309.git.alison.schofield@intel.com>
 <643647e5502ab_417e29445@dwillia2-xfh.jf.intel.com.notmuch>
 <ZDb64ZQpNwZemQeg@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZDb64ZQpNwZemQeg@aschofie-mobl2>
X-ClientProxiedBy: SJ0PR13CA0057.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::32) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB5927:EE_
X-MS-Office365-Filtering-Correlation-Id: b4a7b7ca-4488-452d-4d5d-08db3ba294a2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: faLZ5TYeFoFMuDICzKom+jwPI4vNicMvTCYpv0oWAbJaNirN7EBCxTWMcDwyx0E31fGwlOcm5mlTGMFIiymYmTG+KJN1/s8kYZ5YMHbsKBMA/36Q3H3NjYyZBtKqpl7S+tE4mE1J9i1N3JnOVCTeKsih6MluKPWIN9RZOJJLOwOV1rgcqNUHxPTo6/Q9c6Z6FXZ3kH8+yy3i7HwGUAy4QENxxRIu2Cj9mkUqBoz+N497+b19h7ueBiWobeVGw421A5zh+xCX/UCLPCXd6mvJYad4MqTRGvU53oNQvequ5dHoACkijoHhgVJmLoD6E2fYHbs8UWiDKyxaR46SVCbxAihfAMdq93WZa1ZZ8pr76xXOE07uTumkVureAY62Mvm1Eowog0FH0j/GIXbKclz18ekig1fCPQKNLzJhQ2mqVpyIcrDg3oH4qD+BJRTHJKW1iALKrD6jYdyFL1G93e6qUZ3c/gljlzCzSplYbIxtWn+EIL2nW/b/cv2NPmyCsXntT30y1GZ9wQSSNdphSj6X3LG221TGbsEpnTLzRdStKdWt7r22TwfClL77FaBPeSNc
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(136003)(396003)(39860400002)(376002)(451199021)(86362001)(110136005)(316002)(41300700001)(66476007)(54906003)(66556008)(4326008)(6486002)(66946007)(478600001)(8676002)(5660300002)(82960400001)(8936002)(2906002)(38100700002)(186003)(6512007)(9686003)(26005)(6666004)(6506007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IsXbhIni2a6/GsR53IoNxZIfV4hbLaJ4qMcqZ0M9gSIMfjU44QXBhJqBTr3r?=
 =?us-ascii?Q?SHUBa2u8Xx0Vz7ZDK8dzNFO7GJ48QbGyBrLfugwjLRmhIsXMDJLWp5XcuoyC?=
 =?us-ascii?Q?/CrjpX0+qdcHtiIcysAwcyPmxKoLMq3HdaXUVTf2HBkR2wuS9rZg91p/Tzoe?=
 =?us-ascii?Q?jhbUxrAzz9HfwuAVpiZ5oTFP3lbecwXoTj+aybTbix3ipDiw/veelwlDlohI?=
 =?us-ascii?Q?cRiXdHNH9n5AIn5WtVSPi4lMrszKUwgk4at86LmxPeDH1OBac8Xvp3GiL/Rk?=
 =?us-ascii?Q?qT37KTvFMFnQol82TDhPjQgSTDj5dYIyxtd9BhhJ3EH4UNnLAxYLwR/66JTr?=
 =?us-ascii?Q?Vl3Fs+SOpggMluJMJkFaAR1UV394mQZHpT6jqZHE2o0jGgXLxXcC+rB3I1SM?=
 =?us-ascii?Q?UmiC/c/TW+xCLMWkGZWDZHmgANxUUb/6IWINqvqw0xjzj++3xFkuFDsfCoiW?=
 =?us-ascii?Q?3i1dIvktKB2nJZmM0sHxoCU0CQ+lvq3XSlXXBbUF9N89igm4XYbxMZ76tSCZ?=
 =?us-ascii?Q?TiBDH34cnyh8TxS8R6/x+VtaTaWPDdHdEP78Dt6QfT6BJdPoAmcEUEM6q5To?=
 =?us-ascii?Q?MFyXAV4Pv+gMXpK3et8w84DGa3tt8NzVtCxhMAH7FspvEBmRXCdOj61KenaW?=
 =?us-ascii?Q?3WeEWHzzKSZjrwTbUaZ3QXN/FrvqxNBsdM4TMepKF4z/gwwj5WKoUyawrWb2?=
 =?us-ascii?Q?vOcUJ0XVRQkac7Ls8ov2PFA8YjKzDwTJN/8zIXy5gJjFYgT2ah6HsW0lru0S?=
 =?us-ascii?Q?gdjCHRoLNNRvYdG3ov8GwXJwoprCD4HQ4/CcbUNqxbhSOUx25G8EiIvbGdXJ?=
 =?us-ascii?Q?e2OuSxJ2FgnI56t7MAkPN0DtfXX+SvkLXVOeUQhVH00A+b6DGMtfTs7zqAz9?=
 =?us-ascii?Q?7xqfTJbkKowi7pA6lPmfjKgp2gp3QpfuR+KnRppm8iAa2RhK6GA7+j7Cma34?=
 =?us-ascii?Q?7rS3MdXp8aApxtCFWLBaRq0CrR5/YTNW+S1F/tIa2KG34oLmutzVObM90isv?=
 =?us-ascii?Q?v8+JZqxrHjn1qU3io1TPvE5E55Ddihxo+nBA+a/w+Rm9H8+oLxEylgKBNY5s?=
 =?us-ascii?Q?V9ejwrahyyDjp94wh4okhZ5USPdacxVL/MKlagGchGiLFYKRSXD9dPpJiJPr?=
 =?us-ascii?Q?5BXaNo9TrrgrBOTP/mDDm0IMV5ERJgZ8Savhu9DsdXhTYDGbVcKVJ5Jq/Zc/?=
 =?us-ascii?Q?vxhKQ1meIs77sxIcVKuDBqYrabR0I/UBw0ocItMxFE3+L9PSLiyC9Y36zgqw?=
 =?us-ascii?Q?Lbhz184DBjHlSFH6j/04qTILH7j5EdQxd+mERvD2F3m3uS653Ahr7SHqx+5A?=
 =?us-ascii?Q?qf9Sz1ziGtpL19k42uuKPaSMvHakpYSQWpBrChq2XNDYbvaiOPF9VkK1uyvM?=
 =?us-ascii?Q?RsYqqaueAarsiJ0JGLbGj+wBjnw5Gk9RP8vHyPZkesJD3PuUsPrq6W4CsVTM?=
 =?us-ascii?Q?keKaD0Qk3kxPRmwyBxNl4OL3uc9HlTUhB+pQbphCdLhnPHtL6fznvTQjtFHE?=
 =?us-ascii?Q?WPxrZgnTvwfsuYPsd3OcgiASXtgEPYDB4+YQQAdn//dmSgfiwVmfuJNMtZmw?=
 =?us-ascii?Q?nyYABphiH6Eri02JqfV5vFUvzQ/gINWw6pF0fk2WS8RD1KxhH3/sQFo/R+b/?=
 =?us-ascii?Q?Tw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b4a7b7ca-4488-452d-4d5d-08db3ba294a2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 22:09:26.9611
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 19uAA1PfQrkYDaRw2JUoCq78RpoG69D+MowebDG+LNtcV/CnNQ6qQNn16q4tDNa5TjQqOaKw5JRt8TbVr2T+lAuHPLNcsE+Z3O/xWGHmscw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5927
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Alison Schofield wrote:
[..]
> > Ah, cxl_get_poison_by_endpoint() is a function pointer to
> > device_for_each_child(), that really feels like a detail that's private
> > to the implementation.
> > 
> > I would reorganize this to something like:
> > 
> >      if (port->commit_end == -1) {
> >              /* No regions mapped to this memdev */
> >              rc = cxl_get_poison_by_memdev(cxlmd);
> >      } else {
> >              /* Regions mapped, collect poison by endpoint */
> >              rc = cxl_get_poison_by_endpoint(endpoint);
> >      }
> > 
> > ...and then internal to cxl_get_poison_by_endpoint() do:
> > 	    
> >              ctx = (struct cxl_trigger_poison_context) {
> >                      .port = endpoint,
> >              };
> >              rc = device_for_each_child(&port->dev, &ctx,
> >                                         poison_by_decoder);
> >              if (rc == 1)
> >                      rc = cxl_get_poison_unmapped(cxlmd, &ctx);
> > 
> > ...then the header file reads more calmly with the added type-safety.
> 
> I'll take another stab at this.
> 
> A couple of versions back, I pulled cxl_get_poison_unmapped() out of 
> cxl_get_poison_by_endpoint() since it was not really work of the 
> region driver. (Ira called that out in a review)

I think it's ok to have poison_by_decoder() and
cxl_get_poison_unmapped() within cxl_get_poison_by_endpoint() because
decoder-mapped and unmapped-capacity are both a part of the endpoint.
Given that the region core and the region driver are both glommed into
drivers/cxl/core/region.c I would not worry too much about the unmapped
scanning being in that file if it keeps all the poison code better
colocated.
