Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F33EC7EE24
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Jun 2023 17:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233818AbjFFR6u (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 6 Jun 2023 13:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238462AbjFFR6s (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 6 Jun 2023 13:58:48 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4521D10F8
        for <linux-cxl@vger.kernel.org>; Tue,  6 Jun 2023 10:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686074326; x=1717610326;
  h=date:from:to:subject:message-id:references:in-reply-to:
   mime-version;
  bh=AER/K+x0kYvSIy0ViY8AP7IxbCv5d5aIaFgdSE83UYI=;
  b=JKi0v0FbnEvoIcUj/CETwUD7ts9f7JOkhambWZ0t8rcOOcKpjdx47i2U
   fS6MTRUa2Th1gMFUeILiZwkgMa3u0SKr4B4lGt7gpQipffPxEvdHBc2Vb
   pmJvUqqe3p55MRcgupOhDnoRmkfXUkHJ6OdElFFlMH8MEP+G5ZUwA825C
   tUAPrm5qWhAQ0HeCoE0+wQCyMes76LZ/rf0V/U4ww3ji17HypH3knWFgk
   T2fo4Dk3ysBx1+veIsvnf9gxYWQzJ1H5it1Zdk8hHr9J1O1EzSrpdBvmJ
   SvdUrj4kt2y7Fi0IDyrPaVKCYaFJrXt3oCQQpemgO5Ra+gsstd5esPbmh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="385072994"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="385072994"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2023 10:58:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10733"; a="709166200"
X-IronPort-AV: E=Sophos;i="6.00,221,1681196400"; 
   d="scan'208";a="709166200"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 06 Jun 2023 10:58:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 6 Jun 2023 10:58:44 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 6 Jun 2023 10:58:44 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 6 Jun 2023 10:58:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SN42jKvESMTlK7Lpey1u/x9H1KcmS+Ui3o2ZHUfU8Yt7Vhek++/ODTGXi/Ue4eABeWk6+QyncGQdgWXs+wPXxCeTIxV8Jb4zHhFtk5R3XXVIpnYFJmQzmIQgzCSCBhTE+/ns4K4B6r0joECumjje0EhBf9sD/P7Ll4wIVB/6p0NT3GxK/gSUJHC4ZcKvp7vveiFg5cAv0IetGgfSSsxBIII2Y2AHCM3RCsKzuViYXydFJF3tw0tJ/9abYXOmDVjKDFjThAmj4R2XO3H8o6MhyjGKJiq+nLsHJLOGBDigDh2bS80Bozm+augQxL2NyqHJ3Rdr9wsbQ8DuRIKVBxWWdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KaPbBtY4KsKnLQh1DnXJE0ug3/3s1CVT1Vo/ynPmZuY=;
 b=OnZbRnYPNelCG1BhLqVB1rgBJn5JYsb/cr9kByDTFyxZsRBLO0K3SrkLgbHAmM5oohraHTO9xKV1WxMUNEGXNyGZrYyULSxzmome9lgswVlEpwsekMje/4NB9/DL2fQL9l1vistq81ZdEyGW1M+i1dsyQUWdbTnFK0OTdKImYbCGyKLHtaqJxegsNQ2KIQupF4i6/zWAx5lGL9NZ0bzt0FPt1mIzwWGvw7tHMH4zi2shmchi31Xmj13gM0qu075X96d40EYK5iNG+htQjQfv13n7SaRARbE6irrm/g4iZhSVuVnmKbgkn15FFIwo5Hb/iEMOZHOu01totQNMNGAeTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM4PR11MB6456.namprd11.prod.outlook.com (2603:10b6:8:bc::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 17:58:42 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::95c6:c77e:733b:eee5%5]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 17:58:41 +0000
Date:   Tue, 6 Jun 2023 10:58:39 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     "Yasunori Gotou (Fujitsu)" <y-goto@fujitsu.com>,
        'Dan Williams' <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: Questions about CXL device (type 3 memory) hotplug
Message-ID: <647f73cf40c29_142af82942f@dwillia2-xfh.jf.intel.com.notmuch>
References: <TYWPR01MB10082116669BA002263DF132A90439@TYWPR01MB10082.jpnprd01.prod.outlook.com>
 <646c04bbbd96_33fb32944b@dwillia2-xfh.jf.intel.com.notmuch>
 <TYWPR01MB10082C8CB891827C6438D311D90409@TYWPR01MB10082.jpnprd01.prod.outlook.com>
 <646cf986dd030_afb7729452@dwillia2-xfh.jf.intel.com.notmuch>
 <TYWPR01MB10082A58633DCCB1AAC5DDC3C90419@TYWPR01MB10082.jpnprd01.prod.outlook.com>
 <TYWPR01MB10082A36ECFE209E4A05BA33190479@TYWPR01MB10082.jpnprd01.prod.outlook.com>
 <6470c6a44e869_1fc5429435@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <TYWPR01MB100824F6720970B5968E1AF67904A9@TYWPR01MB10082.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <TYWPR01MB100824F6720970B5968E1AF67904A9@TYWPR01MB10082.jpnprd01.prod.outlook.com>
X-ClientProxiedBy: SJ0PR13CA0186.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::11) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM4PR11MB6456:EE_
X-MS-Office365-Filtering-Correlation-Id: 81057cf0-10a7-48c2-6853-08db66b7a980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 76tXbuo6I4uHJ+QcCH8jdQZ/BOkdK9c1nkg8kJLVhxBfh0RYCQU1OQs+HzOJ1X5v0SiCY46G5LjAfmSNQQZ2JAuWAfx3ntI+eGuVAQysCDZrbTJEpcdL8Dpn2WVbZRSpT7XqfBh9Fg6S+JlJ6EFYxITCQuLtC4+ErowYMe2xo78HTMt/D75xlN8g5cWns6z85nMT7v1I3qVfW1K8dVIsfDmDGdLn6KA1Aqthcyrs0uLqlHlWte/hX1nIFvmfcZoq5bOlLRhJbGB4I60ifXvyNAicM7pgI9IwAjmO8XTmrqIOZPXSeO3x9nNHs8IRP8a5KSaBUB3iJkop37THaQBpb3TmJhCthQ1QvtHGhz39XCf6xAy1ZDWDS7W30PweGhr7doO/ZELZbe53ySb6D1xaq87e6SEXOIUh5cZcc8as+TAZJS/RA8GdWuqkqYo+PxRST+jGLolQnAUUBQ5NHZPjNMT1DHj2FX3iXQhLJUbXpWwFxJ8qavVRMvkmpRamXw6jel42CFmuq3mgVZL64ZItR/aOJQOT73YaRQ4t2IYCBsk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(39860400002)(376002)(136003)(366004)(451199021)(6512007)(9686003)(26005)(6506007)(966005)(83380400001)(86362001)(38100700002)(82960400001)(186003)(110136005)(41300700001)(2906002)(478600001)(66946007)(66476007)(8936002)(8676002)(316002)(5660300002)(6486002)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qEMDA+76UkHNOrsPJl9DuWEeDqmqw06ijJ0wWpZKKiP3HptA5yaGWJAnxvbk?=
 =?us-ascii?Q?M+xk+P+Q/y9dMtcNkG5mHr7MI+GXRURlnlzBR0r8azcOVh80ntQrFiarfQtL?=
 =?us-ascii?Q?mKp38aAAhHzFEHWB2in4Kn7nhttrFB8nVybAPtfCv5+4M/5OwRY0xnl2zD1R?=
 =?us-ascii?Q?3q5D8HfWCuf3s6e+RwkrwrkHApjHaEoVYF5nKyEsuc3SzO4SqzQtLqeTpld8?=
 =?us-ascii?Q?QnZyPaGMUL4ZeLzV7FvfxPvGn/u25fvtILuY5eKKFta6IXIu08+ArnxHqokP?=
 =?us-ascii?Q?FWZ3IuGMc6RcyF3RMM0ekl9OLXAkGxbIuCjidF8CR7fIuYfIIU99L1LBjupW?=
 =?us-ascii?Q?HsZnVcwyDZYN6DppKy1tiqiCRFWvNpzmFjQYiVPOxUA19nE7dSNfuB37mytB?=
 =?us-ascii?Q?qBr16SHc3/sdt8gAS4b5gcvn0NkzpmpQHv1lmKO31uJe6B6wkO1oeegjF+rx?=
 =?us-ascii?Q?NuQRoM5sClSLl9o0oW8OStexG6a/rHwYt75Fw25Ngxs54GFNWkzkCIlCtzNk?=
 =?us-ascii?Q?RhCr5MTzjUtMwsvR66fzUjqAEFpqSfQrmtDdBG13q7XT7Np8fs5z47Zwk+gD?=
 =?us-ascii?Q?KJF3wR8CyERVtUiLk/y1m/zKY+hQyzpj+kmlKEf5LTNXrsPrIHVdJkR2aldT?=
 =?us-ascii?Q?9t3tPg2Jya8fyMBomiTWosFbuEz0nZfgd7MBJpzYZA5bDmvz+2X0VbvfZ+UY?=
 =?us-ascii?Q?Xac+IG3KzLw3S2xXBWAiAkaGCIu9APuI/OA5LtrVnmcyOstV9PHwPzUrMjj8?=
 =?us-ascii?Q?QUxQhNZbjYLstetky3/R7Hm9gkuJ48KjpLK2931HX8EYBGIxAnFXI0RM1AUt?=
 =?us-ascii?Q?yhr2c4z9MXwBLcqCC4+wDomCbOjcWAL38V6bpXV6/mxhEB+spOq65vXfP1P4?=
 =?us-ascii?Q?7la350ELNnsNaWnKZCG4b+inhkEYSsTrGsaEfxUQvIFjqw74ulhYAGNTVqoQ?=
 =?us-ascii?Q?nsgzlxnC6r49WTR37zPviPPjh7U6muAStlzNqRrsaSZAn38aPkDApwAevRUo?=
 =?us-ascii?Q?5ZEv7rjIpL9fqrPQR5S+2fGFwLaPRlTMzdCIG0jSaxqdIVSjCaknImngBdYk?=
 =?us-ascii?Q?/MT7NIcm+K3M35kAZrVVDPlhPCIsPLZtmvIYrS0zch5e3trNKRWwInzvRmCO?=
 =?us-ascii?Q?dogwJXZIEWH2gPgw2j7LbIDkIzdGz4VLoRud/MuKU4zkDRR6kv+5TPt+T208?=
 =?us-ascii?Q?h6i9DAdP0p0uqarkj2+eTz5p0RJjOKnuXxnUgrzlQ1TTuzTQTjKB0Py+lf50?=
 =?us-ascii?Q?IzNb4Z/pCpScjZZ1ShoxIPWSe3bDxc1NuoAKT+nERlPOLpD5B5ue15AMzG4e?=
 =?us-ascii?Q?i0JhqPHFM2SgX/gIFvh9gMIECh6w5DxTXGsTVf8JqqCEUwNgk5GBahrYl9uu?=
 =?us-ascii?Q?oOMinAy4cn5thPA6Bl7m4M/YQEdl0pWhJ0b8Z/DgeTsO6ZK3qSAd+6AlaAlz?=
 =?us-ascii?Q?0ADRPPKQPvaZMzrJKuTZ5mBO4f5TB1j/WhnF0iCTd1laspxGXiLj6glQwHqm?=
 =?us-ascii?Q?h/bMYKM7a0+Fuvb0GI6fiswz02lN+MsFaUW0+MmnmC+D0Px0Hwj35vwdsXYF?=
 =?us-ascii?Q?ARLCnHStcgl+R0fvoECHb13h5683hMbQ3/0ErFglgSkmmYRCr1YSmNS7jNma?=
 =?us-ascii?Q?7w=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 81057cf0-10a7-48c2-6853-08db66b7a980
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 17:58:41.3612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gh56xv5xxfZNujZMnFl2Lxk2Wy08rpd2ME0F/yXbpD8pS/p1QWy4YlSVcDDdkQ7ihcXX+KC6GFE3SCMJ+uFQrJ0KbQaT7XYo06AU3oIo6+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6456
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Yasunori Gotou (Fujitsu) wrote:
> > Yasunori Gotou (Fujitsu) wrote:
> > [..]
> > > One of what I mind here --was-- which documentation describes OS
> > triggered hotremove instead of PCIe trigger.
> > > Because many hardware/firmware developers don't know the circumstance
> > of Linux.
> > > They may want to implement same system not only for Linux but also for
> > > VMware or any other system, and may want to obey only the specification or
> > any similar documents.
> > > But I found " CXL* Type 3 Memory Device Software Guide: 2.13.7 OS
> > managed hot remove sequence"
> > >
> > https://cdrdv2-public.intel.com/643805/643805_CXL%20Memory%20Device
> > %20
> > > SW%20Guide_Rev1p0.pdf Then, I can talk with them by it. So, it was
> > > solved.
> > >
> > > My remain questions are the followings.
> > >
> > > Q6) Are there any way to hotremove from outside of servers now?
> > >     Currently, administrator seems to need to login a server and execute
> > offline and cxl disable commands
> > >     to remove memory in it, right? But in future, something software like
> > memory pool manager,
> > >     Fabric Manager, or any other management tools which can manage
> > many servers CXL devices
> > >     will want to remove each server's devices from outside.
> > >     But I'm not sure it can available or not yet now.
> > 
> > As far as I can see all of the PCI hotplug state machines just coordinate the
> > removal internal to themselves and the PCI bus core without any participation
> > from the impacted driver before the ->remove() event. The ->remove() event is
> > too late to cancel the hotplug. So the change here would be either an upcall to
> > userspace, or some permission request callback to the impacted driver. Since
> > this is a policy decision whether to allow a given CXL device to be removed that
> > leans towards a userspace upcall mechanism.
> 
> Ah, sorry... My description of question was not good.
> I understand that PCIe hotremove is not suitable for trigger of CXL memory.
> 
> What I would like to ask is "Are there any agent or daemon which gets a hotremove 
> request from outside of server and executes offline and cxl disable region without
> users operation?"
> I suppose such memory pool manager (or others) would like to ask the agent to
> execute such operation.
> (Probably, the agent need to get the request by REST API.)

No, there's no coordination between the kernel and userspace when the
attention button is pressed. So any coordinated removal must be handled
before the removal is attempted. I think it would be useful to have a
mode of operation where pressing the attention button just notifies
userspace and it handles the coordinated shutdown of the device.

If the question is having a management API to trigger removal I am not
aware of any work in this space.
