Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D95F3714F
	for <linux-cxl@vger.kernel.org>; Mon,  9 Oct 2023 18:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fTketFm6"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098E69C
	for <linux-cxl@vger.kernel.org>; Mon,  9 Oct 2023 11:18:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696875534; x=1728411534;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=B9gAplKvgxbAmvAaZDQt4+N1nLh444zYerwUwvu0H+Y=;
  b=fTketFm6eW8dJpdM0oLe/kKvN89hwRIxQZPvpLRGqMB3eoCbfi8GWaqh
   Hr0STXMXZ+zGP61fA991S8wxLAEGY9LfT5BvtS4Uk/HDAIhTwCuxyOA/D
   ywsP8LjmOetyjRirufSYXIfyiRjkP03yc4s/7TDm3YH6B1qGO3IPTNayy
   HWn1KYpatgLW4yDwSdk2ivY1+q5ZApSqyx8/4EwUZ2ICH0M2QLFL/I+q+
   hlpGppmc5ovDSKWCcN6sFzvIUJjQ/91RQCGFkoIZ7U8aBsPVjZ9B+F1Rk
   sqQyhxmXZnFMbYuHv14yo5URuEeAnhETs9KbAXoQiZSUWHUDQlF5YTACv
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="470475580"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="470475580"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 11:18:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="823424275"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="823424275"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2023 11:18:49 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 11:18:49 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 11:18:48 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 9 Oct 2023 11:18:48 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 9 Oct 2023 11:18:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0GSQ/SsnIY39NDoVzLpd6cUYRaN2UtEIHbCVv2EcO6TuIOLi3ysXuoBdjKXUE83d/3nZ86zyAHZ/Rk7ep0cd5jXeVSk1WK0z/GPpluniv/6yqoCfg/4FpqwMFd6PndGt8mXOZSUO/0N4uJyZVFchwE+hrYNQtfecYXzJ1v1N9Nss78sjuAAn4ud+LoxGlfSK9HEpgBVOsQSNmntZqW7GQqzBlHRp2+5hgtXPR275LPrmbYwasmEZQSC0IO85cAclUkweh76+Crk+mDf7IpsVGnC3IBJZlI/NCwNoAgFQ5WFFR/gehowzdS5hjSgcefEgfD4h7jodm7md15liRV8RQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nobEkLoelduAOv0UMlAywsKC3lPJGbaekL5lD7kL654=;
 b=MqWnZmDp60M6x65vuvaVAZ5axhif+Td+wA6Kn/Oja9y8V8hI/7POfBOiWfv3+FG1e5NWQMNMgqGXnSrUg4vp6fCEfA4pMitwPByqvJeFKA8Wq+MihqyC41czkV8Xh/V2WFI+B4BYVC621ghQTimR4131aUE8yKFkSAGOVuswLKZJZq6X5BhYmvIzgY7bKW+IJ4wVUDp95C4rQy73AQheHpybIsS+Seb9loiGItuwJfglDotdBB5QAg9FyII+VhI4d/lH7XooHIaNbhPeYRazl2bbmAArw7UD7/44nsKNkcck6Y0fN/pQwSNACHcvrC07JFzE/xmuOHXl6PkcJd6+gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6341.namprd11.prod.outlook.com (2603:10b6:930:3e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Mon, 9 Oct
 2023 18:18:46 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6838.040; Mon, 9 Oct 2023
 18:18:46 +0000
Date: Mon, 9 Oct 2023 11:18:44 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH v3 07/10] cxl/memdev: Fix sanitize vs decoder setup
 locking
Message-ID: <652444042bd98_ae7e7294ad@dwillia2-xfh.jf.intel.com.notmuch>
References: <169657715790.1491153.3612164287133860191.stgit@dwillia2-xfh.jf.intel.com>
 <169657719974.1491153.15276451196916291864.stgit@dwillia2-xfh.jf.intel.com>
 <65237eded9811_1d988429470@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <65237eded9811_1d988429470@iweiny-mobl.notmuch>
X-ClientProxiedBy: MW4PR03CA0144.namprd03.prod.outlook.com
 (2603:10b6:303:8c::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6341:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b39ee12-4cbc-4f72-e7e0-08dbc8f42d60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zopXj7Al9EPHm5lDtHEO+QQ9NiBVZhFOmNQanfIS2SpoVREEB1LcFEtc0qbr62ltAK+8e/Q0yb1ZjRaCULfWWIxzDxzbvyEdQmrHhsEqIb6tnplSRI02HuCW5bEuteU9s+tB0GyzGBRaLTppgBmrnI2qC1zHiHZILyvcaFNu2WSmWVKA8cMFQXSZPrCBOlDXuNzrTyt7/0zs6rZmicRFoVPJrcsJCbzofB0FOhsdoN4uhoQGcdtVip5n5hdP/YGOcTo3sZ3DQh0iUyDOxgVvHvJxj7AvqACh8N45DMuCQRsWHcgW7Syb0g7hcai6Q2K4+751ewNBEHNuEEvYkaSuLDCrx+8Ny739/8OWnYBbMg6stE5kRA6tjBCzVJPzJfjH7ZUh4JBPgjjYvLRh73++0TOW0YGPKZm9IZNdGrejeyVYfOp1eDmX32hmNuuGbG31ncM9TmgHzUIuCQvcIhvo2i79rc25OZbrSPQ8RGJXRACId9mAi49HhEIjWyj5rlZw4RcXaxIkFb8vxQvj7g5fsllRyaq2Kya2pM+2Xpa7k+9x5aPIF7yG9onwbaChEZlC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(366004)(376002)(396003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(6512007)(6486002)(9686003)(66556008)(26005)(66476007)(66946007)(316002)(110136005)(83380400001)(8676002)(4326008)(5660300002)(6506007)(41300700001)(2906002)(478600001)(38100700002)(82960400001)(86362001)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?K5Q7CwkD4qxvIB7KQbfvcVFm21+g1zI99Nuf5yTB/IbR2x047M4BRnqlkDcA?=
 =?us-ascii?Q?rXhIV6DKe4Uru+XkQWOK0+1WmzgVNwWn32Cu8PNsC5EYxjYHnqHgPac829hX?=
 =?us-ascii?Q?JCEk3V6cyrbh9oII1Y/E83VosZHTcExAy82QfQO2CdaEVgMrRCO0RJJaPsZ7?=
 =?us-ascii?Q?zZ1beS6PZ3muxHN7C/MRD2myqfzEpQ34Rp4wl6Hd5Q3zRbLhSaIdlv1SAtag?=
 =?us-ascii?Q?q6hk8plAcMI7doPPHlOS2220CiBakKVJ2lfzhAB4ibgpQxpEzAsEGGfMYGfL?=
 =?us-ascii?Q?k41vM4ucNHyFeQ/JqKZxsYuPoph8cqdYIBvsXz3W3SFr4RdUn7lLPuuezP8f?=
 =?us-ascii?Q?EetDRbc3oLzexRjkcXW9VODlBO4ZZitfZed0tfXDXBmmWBfscxg7TnjC0SXp?=
 =?us-ascii?Q?DdRrQmRFsKN1/XpHpTXTkfDdTJ2IiZpugSi70F/XTjcujFPbRttYDv4zaqez?=
 =?us-ascii?Q?L7TrzwzcLLY42ADEHH7Tl6oYhL1+VJkoO/PAjvcqEJQqNGonOF8nlYYx1K6J?=
 =?us-ascii?Q?PFY4GrxgoHUYB3rCdrOJO7nSxmiZhpjFc61NkKVRK4110UmGiZd9+aCadbzg?=
 =?us-ascii?Q?B42r6jlMXlYqbTz3Vnq032DdV/Ys/31tZ/Dd+Z+wHEOoZIvfFxTDsWPb1PjX?=
 =?us-ascii?Q?z2uWlODlUvNk9jHyaQ76p1q//GYTAJtsAMpmJm3f2Hf3UDEwjZhHH43d4Rfz?=
 =?us-ascii?Q?a2F06xYIPciMUXAFDAveA5gpaYGJmVbf6RTHgATdzHzFL1MY6gQLoSnKe8Di?=
 =?us-ascii?Q?q57UtTqO1zP7Y+ibZXyQJThgkaz9XR2WfHQoH/xGfj0TwBVdGMkDwDRTFQwF?=
 =?us-ascii?Q?qgNYFXc1GTq2I+3y9RYvLCRc1a7l6HeoIbMa4ioQsqfYlrC38j00cgPpZG9S?=
 =?us-ascii?Q?UKVW3v+rq0v+zUIXUYFPDfNIMtV8lWlr8P2ciGPv0DwZrQXq5jo/KERrM/gi?=
 =?us-ascii?Q?0M4n4zHmBTCjJ6a2MTITdZgfy/TRD1qxcb0wAd5iqxBgx8o5BIgUOI2rTvPs?=
 =?us-ascii?Q?7By/updkhAXzf+MZhiLluyH+PInw8nNf8DDnYVVMpYxlN43IiL3LmQ8nbZol?=
 =?us-ascii?Q?updm2YDy3d8gfOYEHI4x6BvSU0nYuqsV/r2DiUp+WgFBq5XIN2chPokDpkLE?=
 =?us-ascii?Q?sUrycPtHfYeAWcb1cgmemcOd6yvX7RxPCBWlS6d8io3cKgPiWT0ile0Q6Af1?=
 =?us-ascii?Q?nxHIKeoWszsohH0tR9iwdkOT7UhypzDzq+n68IbOOQ5F9eQf0GT69jGRIxyk?=
 =?us-ascii?Q?+XBup/zThaTPHxVcOBuMK/XPYOdKoxLmKsE4KhCT0vhOXWR4cqC9HlGcMW8T?=
 =?us-ascii?Q?QsAIciPbmMFBzMq/cENgukCM5zIfWlpweylBoPo0TTcxij0OXLvi1WKzagsA?=
 =?us-ascii?Q?gUZlm2c67AX0uWU2bZv5dKitvjvWbNfy0XLDDgE5HRL7AFQUwbnsFfNn2Sk7?=
 =?us-ascii?Q?afuNMyXRPJxduGbo3o7O1DIdgPTuRtUnEsdvCqvjYKj902Bqup8W8OwK1fbq?=
 =?us-ascii?Q?BL0sny8/b7w8n//Zfk1Oxudc+soF8CztP9PSPQJ0A3y1CBI2wCNe7X+nPdOE?=
 =?us-ascii?Q?nBsll7nPMUDVtnhn6qrxEA9gGdCt5fqBFpD0NchU2HqIF+S2UKPGJVTEqjYp?=
 =?us-ascii?Q?gw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b39ee12-4cbc-4f72-e7e0-08dbc8f42d60
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 18:18:46.3973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9YWpnQ3cFL2zoCvruPJ0HUAv2PMDHO1wYdGtVsqOYjupCmS9S+S89NpZztuAkrv2IWFDrsvW/C/DDmAzLE9tPbIWQ4x+ApzE/Y07Kx+T5I8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6341
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Ira Weiny wrote:
> Dan Williams wrote:
> > The sanitize operation is destructive and the expectation is that the
> > device is unmapped while in progress. The current implementation does a
> > lockless check for decoders being active, but then does nothing to
> > prevent decoders from racing to be committed. Introduce state tracking
> > to resolve this race.
> > 
> > This incidentally cleans up unpriveleged userspace from triggering mmio
> > read cycles by spinning on reading the 'securiry/state' attribute. Which
> > at a minimum is a waste since the kernel state machine can cache the
> > completion result.
> > 
> > Lastly cxl_mem_sanitize() was mistakenly marked EXPORT_SYMBOL() in the
> > original implementation, but an export was never required.
> > 
> > Fixes: 0c36b6ad436a ("cxl/mbox: Add sanitization handling machinery")
> > Cc: Davidlohr Bueso <dave@stgolabs.net>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> 
> [snip]
> 
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> > @@ -650,6 +650,25 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
> >  		return -EBUSY;
> >  	}
> >  
> > +	/*
> > +	 * For endpoint decoders hosted on CXL memory devices that
> > +	 * support the sanitize operation, make sure sanitize is not in-flight.
> > +	 */
> > +	if (is_endpoint_decoder(&cxld->dev)) {
> > +		struct cxl_endpoint_decoder *cxled =
> > +			to_cxl_endpoint_decoder(&cxld->dev);
> > +		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > +		struct cxl_memdev_state *mds =
> > +			to_cxl_memdev_state(cxlmd->cxlds);
> > +
> > +		if (mds && mds->security.sanitize_active) {
> 
> I'm curious why this check does not need to hold the mds->mbox_mutex?  Or
> how this may be protected by the cxl_dpa_rwsem?

...because cxl_decoder_commit() knows it is holding the cxl_dpa_rwsem for
write which means that sanitize_active can not transition from false to
true in cxl_mem_sanitize().

It does mean that in-flight completions may race, but that's a benign race
where whatever triggered cxl_decoder_commit() is already in the position of
needing to wait for cxl_mbox_sanitize_work() to fire.
