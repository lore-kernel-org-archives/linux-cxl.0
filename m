Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC19FC77B7C
	for <linux-cxl@archiver.kernel.org>; Fri, 12 May 2023 00:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239685AbjELATA (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 May 2023 20:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239691AbjELASs (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 May 2023 20:18:48 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7465683D0
        for <linux-cxl@vger.kernel.org>; Thu, 11 May 2023 17:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683850712; x=1715386712;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=EaAeSL/57pK7ybovPbTjnS0ILyK++ZrfcNFMEL7fQKU=;
  b=ZOoEjYxx6JwLAjXjR0oFrQ/z+uE0512Wr3QKZ4PKJNiNGle6iQ5lX7NZ
   1nNsQWPJVnOGqNm4IFelc22O0EX99+wHgOaCDfq2LDSMvW8yfPmL6WLyk
   qa70RqTEp9m2N46TBlVA7tU6FYdVCo0JezakJfuWNRz9g2xrDiouXcy80
   XDvoPVOPscf6DpTjb4vhDOO6Nia3KKGtS0dnBl0HH/tbBkW8QTreGA0YZ
   gTlGdNH9B7RYPFTo0+gpKnA7z8LBX54/leEgjL5mLUg+JezsV3gpLSeq7
   9oagognyocvTfKUWEAzdNNb3+4MBIuM0cHNRcJbgr6mMNW6MXI8iaFz3e
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="350696299"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="350696299"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2023 17:18:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10707"; a="702955171"
X-IronPort-AV: E=Sophos;i="5.99,268,1677571200"; 
   d="scan'208";a="702955171"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga007.fm.intel.com with ESMTP; 11 May 2023 17:18:32 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 11 May 2023 17:18:31 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 11 May 2023 17:18:31 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 11 May 2023 17:18:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BaE8RduT554ZslxVmqnUWEPNY5HXkDztSXolmOucTzufKn1bWDvKj2qqJQISo4FIVWaxiKx8P+gypN9K5RM+KyvLXkYJVwK/FNrHoEh81NOHVvLVM/BEQwEmonsXhgpNu0T/iyOE+fEkeht2vg/yFSAsxJ4h4pT7joCyWx6ar1xE1GewrQ+nLibeGBF0FIvz8j75zSiFqjIUewRpb+Xez7daZAJPaoQnm7/IBKGoWq2ptJA1KZppLgXgNYsuQ27LP1JHTrKaFiBXiQ1p3EJ7gBnSjSFPQKywcXB5OCnW1Tm4GeWYp0u5i+bLc2Lh2y/ufwUn64XgkevhVgRLmA/kew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNT4Q0Qi2ajTj6T0oOYKFCf4evxwc2AOqwKrDk69Ae4=;
 b=WePKa9qtpDDahui1Qo6L3W0pjGYTmYcHB3StoS7cIFfa0PMeKJP44aku3ZIe9hf3SrVkZL/m0sL5svHi3z6yY//ylb1ux176qkei9UQsCelSMZmQH4w1tZyE+u25AB6sfvmC9nAyN/KIIQYaPCXemjwNXzdSpPTpqcpHQuLajesZj5egZCgmDLWAejQpm9QHSXt8Bw72JzeT4MiWM7g+ya3TzwNAel82oB4NcH3zkagg9tSwvbvAkdBtEZFzzTUg5D2HKRJHdcELhx8lQwM6xaq44F/T8iwz4Xrjt5IT+1Tuhx+JsEF4/t4dHNHUfG7EB5NVgY/lBbAPU2ZZG8FwHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB4886.namprd11.prod.outlook.com (2603:10b6:510:33::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Fri, 12 May
 2023 00:18:29 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%7]) with mapi id 15.20.6387.022; Fri, 12 May 2023
 00:18:29 +0000
Date:   Thu, 11 May 2023 17:18:27 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [RFC 3/3] ACPI: NUMA: Apply SRAT proximity domain to entire
 CFMWS window
Message-ID: <645d85d378a85_2ec5d294d2@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1683742429.git.alison.schofield@intel.com>
 <79a10b7101a8fab56f9ff3f9a4de73bee3156b40.1683742429.git.alison.schofield@intel.com>
 <645d7765a218a_1e6f2944c@dwillia2-xfh.jf.intel.com.notmuch>
 <ZF2Bz9Kw9rNOyOdZ@aschofie-mobl2>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZF2Bz9Kw9rNOyOdZ@aschofie-mobl2>
X-ClientProxiedBy: SJ0PR03CA0250.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::15) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB4886:EE_
X-MS-Office365-Filtering-Correlation-Id: d862b5dd-3346-46c3-269b-08db527e6970
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cnnokYOCZl1Fa/EDDYP9JPsw295S7ATy+dxzWfnuIRePbRDrclnspU3V6CU6TlUui9+GlfYqTiDUGUdCgbKYd81W1EGuPhDvN27QYXf/mLtL2Be+68X7XZRkJXAR8FUXyM/HOLICHIhoTHIw6aQdiOWgsKl9Z8XgAQ7lV2INye3nZKqBQCbgjFW6OLZuf/Knt7be55sYYR90QenJ5zRqxoCKgRhalwRcrblKN8q4/TKqIdRgcFlNDvHq0DaPhPw1UjSbEZudAWE0an3IaFOQzFIFrtW+IZ5ejc5+BkscZY4q0UEHL+9Jk+NxQbPCKGZDFxgauiWPhkRVMLc55XoPjPamg7hYyJQzJdShwUVtLLvlkS53eU60ahu2C4XezAIwTuiMcrKkicYntnxWi6H2AaveHyICdWQO7+37Jxa2JQiq8lqvjVs7J5mXqYlVirTzsSqZrDKoGDTjeCicUtdOel9UqMFAgXYeRuTiViaZr4Am+8A8rSmVtvP20Rxx7N4v4nLpav57C1RVScW6fTwWjInybUxGr56bQpn3QIooCmzoja2gq5nMMDjl4L5sL/6k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(376002)(136003)(396003)(39860400002)(346002)(451199021)(6486002)(8676002)(4326008)(66476007)(66556008)(110136005)(66946007)(54906003)(82960400001)(2906002)(8936002)(38100700002)(86362001)(316002)(41300700001)(5660300002)(478600001)(186003)(9686003)(6506007)(6512007)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGJxYkxlQnlYcDhZamRQK2MwcStlUC9VUWxRcjRYTXVFZk5wSld2MXFDTi9N?=
 =?utf-8?B?VEMxSmYvM245dDc1emVibmFBUmk4aWY3QmVtV1EzVTdacm5TSFNuanlVVXFH?=
 =?utf-8?B?Tkp6RU5OTGhvZTB3Q2pEbWE0V1VpZDIxQTBtK1N4dGROUDBBWGZYamE2dzZC?=
 =?utf-8?B?SnhQcFdGb25tdXJSV1dlNnFUdFNEbjFTTm0wc2N3N1k4VUJPZHovMG82cVJi?=
 =?utf-8?B?NlB0V2hlamRWV0doUWFXVFRXRGozdWYvMWs1LzNZM25JblNQSkk3MnZQUmZR?=
 =?utf-8?B?TGkvNTZXU0RnOCtZOEw3VXp4U0pPZmdhMU5Pemd6RFdCYWVSN20vei9tVUtW?=
 =?utf-8?B?cXNvb2dsNWU4VVgwcWNWdHpMeW15akh5R2dpek5CdGIrcjJScU4rb2lDNWZQ?=
 =?utf-8?B?TitIU0cwVlAzUEo3elVLcTBpSEJXdmRCRWMrbEM2ZkhJKzgwRVVzNnpRVmdK?=
 =?utf-8?B?eGZmRHd3WXcvY2luMitZK1ZTNnlNUlNsbEhEU3JkYkVEd2d3b0hEdlVxUkRD?=
 =?utf-8?B?VlpoR2pPUkdiZzE0SC9BWjlDQlQwS0lrNHNwL1Z5RW40bVV6M3N3NWNqUS93?=
 =?utf-8?B?ZTZhNnFzazJmSGVqWi9vbXprMXFVaDVWcmtML1NVQ2orZnpiS3FrTFlQWkUy?=
 =?utf-8?B?Y2tjbC9yVm01WE1aTXFaZHJCTlJBaE9mK3FRSC9LNlZsT3czQmY5TVJkNmQ3?=
 =?utf-8?B?LzRvVHArQzBuRS9pZjR6TWhSdnhqbGdMcEtTZndsZFByaXV0akVmcW5ZZGJi?=
 =?utf-8?B?MU9hMVQ1QzBwVlAxUERJUTZPamJrY24wSmh3M2NjemNsSTJGQWZFT2IyTThC?=
 =?utf-8?B?eWdoT2xoV2E0MHZZRzZUU2FlOEFBcWJqN2VmK21OQWRMdlZ0WkpqbkxnTUpC?=
 =?utf-8?B?a2hoUEhFbWNsaUZ3NWtzdWZaWkxsZ3YrWkZrUXhzNlZud0hxZlV3Q25wZDNN?=
 =?utf-8?B?S1hrUTExc0pwb1RuQUd2RTczU2lZVUtJZ2dRaThQS2RNaTFBaFRmU3o2ckEx?=
 =?utf-8?B?aUVsam5yM1VpRFdkajdzQUJKWnZtYmZiNEUycXc2UldHVm1jMiswMVhRS1lH?=
 =?utf-8?B?RFZtenZXeEN6RkNMYThqMEtUY0xIU3lhSDAvNlZJcG9KaUZRUTllWXlGTzFQ?=
 =?utf-8?B?UkNKck1XUlUxaTRUc3kzSEhTRm1qZDdmUzdTU1RwNWZvMFdwdmxLcUZCb0VX?=
 =?utf-8?B?WWI5RzM1aWJNRjd1ZnFtY1hxaTJkaEpQcm50KzFzRG1wVEhlOXV6Nnoyc25C?=
 =?utf-8?B?S3NLM0o0VWE1Y0o1RXlLRlFacDlmOFpOa3ZOa0FRcnFyYjlmVXlRMmVNaUxB?=
 =?utf-8?B?d3p6Q1k1ajVoSXhJRTliamJUNEZwMHBYZ21ZenZLeHVhc05jN2F1QWpraEtV?=
 =?utf-8?B?cGhXMTl0Vk50bVhia1lGYTNXeFI5dG5OZmRvSFhyVFR1K2MvK3IvMkVERWRB?=
 =?utf-8?B?bnBrbXJiS3d0anZ0NWI2R3F4OXlzVGZoakhZUHdFMkZHdTc0OFhhTFdMNHpP?=
 =?utf-8?B?OFpoYS9hVkN3UFJ3YWdodUdJY1U3ampEQkJmalRrN2JQRkQ3bGFOTWdscmcv?=
 =?utf-8?B?OTU0TkZ3RGJqbmRRNk93dzV3UmJnZS81Rk5GNmpuMUdFdkRCakJxWEc3YTkw?=
 =?utf-8?B?SUZDVmh2czlZaGVpVjNoQno5endzQkRrcVVFWER2cnJXUkhNemozZ2Q0K0Zx?=
 =?utf-8?B?NDZwd0dINFZiY0tsY2huZVdJMW52Zi9KV0wyZXVEL0QxV3hiTkcyTFJTZEVV?=
 =?utf-8?B?eGZSZWpuc3BxZ1o3dFdJV1BHRXhianI5NzJ2RkVmaEg0d2JTK0x6VCtXMldM?=
 =?utf-8?B?YU9TbDNqYjZFbjYwb2JueWdvWUw1OFkvYVBPWXpjbG1lR2VPSG40dk9tSFdP?=
 =?utf-8?B?ZGtObTJIaTFxTGVuZTJVVTBLc0xhNys1NXI3UjNweFlnMTJwOEdtQXdla1hS?=
 =?utf-8?B?d01RbVJ5NXBUV3VOejI5YXpjeHpBdlNKWTVjKzRITXJnN1RhUjRhdkdaR0dh?=
 =?utf-8?B?RWdhYTh1THh2aWJ4cWVyaUJRZ2pEL1dpcklGUGptMlRrTDc2MEF1dnNobW9Z?=
 =?utf-8?B?VUtvVk80UXVmaTdXSUJlU0VuRHBGK3VHTVhzQWE2Y1NQNkY3dTZsQmFjWEFx?=
 =?utf-8?B?N1N4aGRaeTkzRThVdVhHbUh4bm5wWjNBSjg4bWZ3alVDd1pYYUhxVUM1dGpj?=
 =?utf-8?B?Wmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d862b5dd-3346-46c3-269b-08db527e6970
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 00:18:29.3196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oJ6QXOd1OWLaSIKQY7nVJNOdTK8xoTqgDVQG3fyDKfbMToBVKUv+nTKTMyIQNGu4E1LADtO512ixtXJnBb8h6RK8EeF28viD0CQVS+XMEP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4886
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Alison Schofield wrote:
> On Thu, May 11, 2023 at 04:16:53PM -0700, Dan Williams wrote:
> > alison.schofield@ wrote:
> 
> snip...
> 
> > > +	/*
> > > +	 * The SRAT may have already described the NUMA details for
> > > +	 * this CFMWS HPA range, yet it may not have created memblks
> > > +	 * for the entire range. Look for a node with a memblk covering
> > > +	 * any part of the HPA range. Don't bother figuring out if it
> > > +	 * is partially or wholly described. Replace any memblks in the
> > > +	 * range with one single memblk that covers the entire range.
> > > +	 *
> > > +	 * This preserves the SRAT defined node and Proximity Domain.
> > > +	 */
> > > +
> > > +	found_node = numa_find_node(start, end);
> > > +	if (found_node != NUMA_NO_NODE) {
> > > +		numa_remove_memblks(found_node, start, end);
> > > +		if (numa_add_memblk(found_node, start, end) < 0) {
> > 
> > I worry that this blows away information in the case where the BIOS for
> > some reason decides to describe multiple proximity domains per CXL
> > window.
> > 
> > I think this wants to be an algorithm like
> > 
> > numa_fill_memblks(start, end)
> > 
> > ...where that walks the range and for any gaps in that range extend the
> > last memblk to the end of the gap.
> > 
> > For example if the CFWMS to SRAT mapping is this:
> > 
> >  ┌──────────────────────────────────────────────────┐
> >  │                  WINDOW0                         │
> >  ├──────────┬────────────┬────────────┬─────────────┤
> >  │PXM0      │ GAP        │ PXM1       │ GAP         │
> >  └──────────┴────────────┴────────────┴─────────────┘
> > 
> > 
> >  ┌──────────────────────────────────────────────────┐
> >  │                  WINDOW0                         │
> >  ├───────────────────────┬──────────────────────────┤
> >  │PXM0                   │ PXM1                     │
> >  └───────────────────────┴──────────────────────────┘
> > 
> > ...and if that finds nothing to fill, *then* create the next proximity
> > domain for the window.
> 
> Thanks for the feedback Dan.
> 
> Is there any guarantee that the first PXM begins at cfmws.start?
> ie...that gaps always 'follow'
> 
> This one's easy:	gap-pxm0 	becomes all pxm0
> This one's easy too:	gap-pxm0-gap 	becomes all pxm0
> 
> This one's not so obvious: gap-pxm0-gap-pxm1 

Good point.

I would say that pxm0 consuming both gaps is ok. pxm1 grabbing the
second gap is also ok, whatever makes the code simpler.

> Imagine those are quarters. Is the end result 50/50 or 75/25?

The window is all one QoS class anyway as far as CXL is concerned. So
the end distribution is not much of a concern. I.e. I would not worry if
you end up with 75/25 even if 50/50 was possible.

> I'm wondering if there is any policy in existence or this is new,
> and we are setting the policy now?

We are trailblazing on our own. The reason why I think we have the
freedom to make an arbitrary decision here is that it is unlikely that the
BIOS describes multiple proximity domains per window, but on the off
chance they do lets not throw away information.
