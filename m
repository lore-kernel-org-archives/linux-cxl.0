Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118AEC001DE
	for <linux-cxl@archiver.kernel.org>; Wed, 16 Aug 2023 01:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbjHPBo0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 15 Aug 2023 21:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233136AbjHPBoA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 15 Aug 2023 21:44:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD78F10D1
        for <linux-cxl@vger.kernel.org>; Tue, 15 Aug 2023 18:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692150239; x=1723686239;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=sWVSOLS97zu+M73j0fUWLtDIzlWdJCYdYp+BffHs1uQ=;
  b=L4QECj0FIhfMQBVrDVadrk32EsplvCPm4WoWUy7fcKWtOjMfjNctd1Qq
   KS3+QZelzvGst+TBrITWLTaledFCy67I9TOQCV8NASif/LChe8v+Darhr
   b6tRpGVNlh9vR8DHqywvvP8aLW42qZNXATRNLDd5JDAallbFR4h1xcKhq
   JOHu4SjH9lTZjiw9AQV29qKi+PMmTWRf63NeTC+hSLJQlmP1wqUc+K/ND
   Fw3kiqm2tbCFkK3Qyacq752QkNgSlX5kj9usvHmvr71WxmNaIzmHa/cIP
   rn3Bjt0qgSnh8hJzs1Ekx/+3+8stOF1/FRKnMQ7Z4roXwk0QNXrT+zyQ+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="458768461"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="458768461"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 18:43:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="857632096"
X-IronPort-AV: E=Sophos;i="6.01,175,1684825200"; 
   d="scan'208";a="857632096"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 15 Aug 2023 18:43:58 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 18:43:57 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 15 Aug 2023 18:43:57 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 15 Aug 2023 18:43:57 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 15 Aug 2023 18:43:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kTGHLA7/tfjjOudRLWbYOuDmnzUjz7DG36f+bItEvTv1j8gXGrQK9GICcRiA1poC1+NCYEmjaCeTvmYNfn3nBcBEPHpiXeC+eFc3mFRYnn03VyWaTv499XMk3wxVh7j6r0rg13PaICn85/LqGHu3pdPmbx1IzSwMKiw2bKPmRpIE5wLgZnZ8fqev731rJBqcPBcaSxy3riGflLDhg2UfaWpWCkfBmZgJoL9vwH66MDV8RTQLwttQTp8+pgeJFP99u7f9io0hji1/yKaTgQ7TXa9JBZv+mN88XBBOOliagLoMiXo7dD8iHt46ZneW/aMS624XcSsgCLdpQY2jFI5HTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWtiWnaZOCM1MdYrT14i5xgIh+jWk1+Zef6iBrLAOrY=;
 b=Dom3KFnfb1aVVqloIkGzUu8QSwYEolOjpREtyx9YCRK9K66/c8JEIvyyIns18FgiC+XzSGlQNQvGN0L1CoKDeIt+Rz9TZ88wCvMnLDx8uvYBklJXpi/3SnxlISX6+Sg2NbhfAXw8GMBNWiJ3p5wPOHaNSizpsuNq0j9l1QQr1l0X00l1VMnx0cmT9I+5CUHWnxnyyIuZLJVM0KDPyhZjY/xkYBLQqkWQRw4BtY0xTUIWruVvMr1L1KItCpGsEWADULqVpUp0gko7H7QmVH1P8oPD9RhK7fJkPKlfbSJC0Cuc2mAu1/b3ZpVoxlQFBTOXpLvYUMEnBVnNmVAchbFb7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB5373.namprd11.prod.outlook.com (2603:10b6:5:394::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 01:43:50 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::acb0:6bd3:58a:c992%5]) with mapi id 15.20.6678.022; Wed, 16 Aug 2023
 01:43:50 +0000
Date:   Tue, 15 Aug 2023 18:43:46 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/region: Match auto-discovered region decoders by HPA
 range
Message-ID: <64dc29d2c38e2_5ea6e29481@dwillia2-xfh.jf.intel.com.notmuch>
References: <20230804213004.1669658-1-alison.schofield@intel.com>
 <64cd782673ff9_2138e2946a@dwillia2-xfh.jf.intel.com.notmuch>
 <ZNwUp2Nqu4/3m5Um@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZNwUp2Nqu4/3m5Um@aschofie-mobl2>
X-ClientProxiedBy: MW4PR04CA0036.namprd04.prod.outlook.com
 (2603:10b6:303:6a::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB5373:EE_
X-MS-Office365-Filtering-Correlation-Id: 77faafd5-376d-4489-29f3-08db9dfa3d4a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 90B2YpGtLRAD09O7hBWO0MPeK3qZHTNfbJ+2mM01U5lDjvTDf6Lz0Ly4jwuy09bD+fGgTpT/h5vl0gSgDONojWyn34zMyErsPToTcgC+CBeE1i6pRCNEPiCHEb4YlI0sTOmmP+OYGFkkYud1E36hM06bXqJLaP0gEc60RweTi7XUTF7fRrMuzPkEZKk5yKiai2Ns3hzsOWzbrxAbj9iQIb4wjExkdY7RsKdXqqXIb5MqLVr9sH8TqNxI4tSdgj5c57i079gUAJAQdnSEKhbquYs7ntQOXDNZmIj39AMxq59OhuVKJ2A5iUXS+EEbjWmDKaH4Purmi4lSM8pc98G/orakdZrMtI2QIcyy4GCHLGz1RxqcddS46B0rDUebK9pqg7jj7z2aK/wZMsdLtEH0k+HjqCBxxPth8aFHLlz6J9aNL572Z05a3r8h/e6QPopMltGSW1stIu8Tju7OScx8TeoIUhLrAZXFLf61FGluCi4vOl/h3gRgRc8OkbZdi9lQdhXGN2+F232j5YNSakz4WDD9551qvESjKqgvUfO2lqy2n5ByBrAIvUWOD0ojuUk3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(136003)(396003)(346002)(39860400002)(451199024)(186009)(1800799009)(26005)(66899024)(9686003)(6486002)(6666004)(38100700002)(6506007)(54906003)(86362001)(316002)(66946007)(5660300002)(478600001)(82960400001)(8936002)(4326008)(8676002)(83380400001)(41300700001)(66476007)(2906002)(66556008)(6512007)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k7N9JzkiLVJa3TK7bSw4GL55x6VIHJgCs6sX70JgbAP/+xnqvXT197dTR8M9?=
 =?us-ascii?Q?UsiLuCH5xMuBsUw7NRPATAVkEDW2rA8Qf4ZKUs1fcP5unpHAXR3xeJV8YFZQ?=
 =?us-ascii?Q?dNyaavDT91N/bbxDrhOxKf2solXFDrN3YNoLX0+fOuS51+kQtnqNS26sW36c?=
 =?us-ascii?Q?ZFRjZ7hDyxCF1ju+4ukdEZweawtO3Yv1aXjUnGUz6mXTjtWDHy0HdQFNmJcA?=
 =?us-ascii?Q?yCgiZDqjKaM9oxQWyD8ti/rCxHQ/Z6CjgQ2ZGpXaGVAkDENEQh1U1k3dpU8z?=
 =?us-ascii?Q?rh6cS4+yQBaid5DYPh7T0V97zm+dHmX6I34HDQoaGKLQZJe/VM0kEagRyFdT?=
 =?us-ascii?Q?kAe8Ra6knJfWwLvwyZAxoW6NiGJSRDXeTDct6zXyq0IwZdToBBmx3yc608Mj?=
 =?us-ascii?Q?B+yJUoqoSS3Kulo4e46rKAW1zIIgWET3iLc/9SUVZ0ld3ZXe78XMZTH536kg?=
 =?us-ascii?Q?0yLqLMCya98yfb43SfwOsNw0KaNeVkp1AW0s3/X1HKcUnnzHkhEA+KT2ccWr?=
 =?us-ascii?Q?qOdnu0OypIDcGs/+iidw/QMH/NnLySbK6isAxv6RYM5AR5Kg7iF324d9hYfB?=
 =?us-ascii?Q?8pH+z/V/aYWk4eJQcLadHUbdLHpOoprdUl6FikvZ6hKOT9iwNK/Z4R7gJCnM?=
 =?us-ascii?Q?wb6aWRt9gtcYd0n1OGwr3gTJ17PyR15es2DXyc/MLmJpRdodD5iO2GUnG2XU?=
 =?us-ascii?Q?5J+QpZpHVeTD/wbBoCt6LY6l1HQbYmYqPVj4hBRlad0z7uK7EZEzFc7arXoX?=
 =?us-ascii?Q?9fPJM4sriZW9kBdjpIkr8ngQziixoC1JuzwGNtoEPgPAg1US7m6rEHAkA7Ln?=
 =?us-ascii?Q?EW7Wx7oXi29Kk56QP0FP97sDXGJVA5sRwT3rsCZblLGV6laBR8uBJm+36i7P?=
 =?us-ascii?Q?QuPn/AOjVPNFKJ/0fZIV1Uluo5xhe/WxL9HFOVPIAIUnvdMrm2ohP+7gwo9f?=
 =?us-ascii?Q?AqQMxKy2MtH0hz0pdyQOn1NdRYHdbc/BU8I+GO6pCL3a5dO0+QNW+OSc9A9q?=
 =?us-ascii?Q?jL36tPcQGlxk1GwBXSSAY0D6d3lWkwN/nXKU2luKlXwFpQL1xslpkjGFjsLv?=
 =?us-ascii?Q?uP94glTWLddsM9Iwq60AWpa7dcayDyOqlnI8vVTUey/kV9UiEd3qozsOhEn+?=
 =?us-ascii?Q?0IGzYwiqt8CYjN4M/cRoinXsjU89VFTBgtXk3Hx8t6xPYHDP7cqcin/bslHn?=
 =?us-ascii?Q?Ja5t7iao8Xbw3VGHP98rSF8OzTsIVlBOrYEtJrOXDXViHaDxZx4y2iuFApns?=
 =?us-ascii?Q?88cxwSXOaAQUHzm49V/ZsZrXXscA0nBnoYeWRm4QzkP13cjOE1LWrOO0HA3N?=
 =?us-ascii?Q?4LK6YCYO4kFnjmexnNrgGR+eolgkRAdWtJ6GQUsCLoPSRIyqGyBcrlPaF/SA?=
 =?us-ascii?Q?6LIznt/1pgSEhVXRrz4la8cx6mtJKcdwcmz6S4s+xMxKgMObcZ8bJouXxnIT?=
 =?us-ascii?Q?FjUyLD2wULnAukaGTti32MP8rNXo8jmSeKDisgvIMUx8NmK+8AKQrPqPeYHn?=
 =?us-ascii?Q?2HQN1zljwDuWjyC3i6PraE6Uq0EAgozY7VT7yuGMVUPna8QpioyFOCxLn6YE?=
 =?us-ascii?Q?NX+FT0HRUBtDd73z3wNQxp6/2vJY/u137qU0ycw74NS63a/Wsxj1ouFFuI2y?=
 =?us-ascii?Q?7g=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 77faafd5-376d-4489-29f3-08db9dfa3d4a
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 01:43:50.0948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7oC9Dk1o9loWDfW/UYroq5FjhcC8MZHXeQcMeb72BStAmmWNv+hzL4jHVcyGZkZ6LNOx2UnmemmvB4B8J+WWXfnQIWX+Jmf2nKoiMByVk0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5373
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Alison Schofield wrote:
> On Fri, Aug 04, 2023 at 03:13:58PM -0700, Dan Williams wrote:
> > alison.schofield@ wrote:
> > > From: Alison Schofield <alison.schofield@intel.com>
> > > 
> > > Today, when the region driver attaches a region to a port, it
> > > selects the ports next available decoder to program.
> > 
> > A small nit: s/Today/Currently/
> Got it.
> 
> > 
> > > With the addition of auto-discovered regions, a port decoder has
> > > already been programmed, so grabbing the next available decoder
> > > can be a mismatch when there is more than one region using the
> > > port. Match on the port HPA range for auto-discovered regions.
> > 
> > This patch looks correct to me, just a couple questions beloe.
> > 
> > It would be great if it was accompanied by a cxl_test scenario that
> > tested the failing case, but barring that it would be good to have some
> > logs from a scenario where people can notice if this fix applies to
> > their failure.
> 
> Cxl_test:
> 
> The cxl_test regression test for this fix is to setup 2 regions for
> auto-detection on the same port and load/reload enough times that
> the HPA violation occurs when the fix is not in place. I'll see
> about adding that in a v2 of this patch, and an ndctl PATCH for the
> regression/unit test.
> 
> Dmesg logs:
> The footprint of this failure is only visible with CXL DEBUG enabled:
> 
> [] cxl_core:alloc_region_ref:754: cxl region0: endpoint9: HPA order violation region0:[mem 0x14780000000-0x1478fffffff flags 0x200] vs [mem 0x880000000-0x185fffffff flags 0x200]
> [] cxl_core:cxl_port_attach_region:972: cxl region0: endpoint9: failed to allocate region reference
> 
> When CXL DEBUG is not enabled, there is no failure message. The region
> just never materializes. With this patch, I hope the HPA order violation
> is only a dev_dbg() level message again.
> 
> Makes me wonder:
> 
> This case aside, the 'opportunistic' approach to region assembly doesn't
> offer a place to make any summary statements about the auto discovery
> results.
> 
> In cxl_endpoint_probe() we get here with CXL_DECODER_STATE_AUTO :
> 
> >>	/*
> >>	 * Now that all endpoint decoders are successfully enumerated, try to
> >>	 * assemble regions from committed decoders
> >>	 */
> >>	device_for_each_child(&port->dev, root, discover_region);
> 
> Do we need to do some expected/found work here?

In the PMEM label case the CXL core could do that because it would have
an idea of what is supposed to be there. Otherwise, this code path can
not tell the difference between regions that were partially setup before
a kexec happened, or regions that were fully setup by the BIOS ahead of
time.

It might be worthwhile to report on System RAM that intersects a CXL
Window and expect a region to show up, but between BIOS quirks and bugs
it is difficult to make crisp "expected" statements here.
