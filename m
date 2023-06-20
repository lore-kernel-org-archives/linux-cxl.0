Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0202EB64D7
	for <linux-cxl@archiver.kernel.org>; Tue, 20 Jun 2023 16:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbjFTQYn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 20 Jun 2023 12:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjFTQYm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 20 Jun 2023 12:24:42 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170A4E2
        for <linux-cxl@vger.kernel.org>; Tue, 20 Jun 2023 09:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687278281; x=1718814281;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=JCo9IX5tnEAHyHhoTuYf+yXTguH3UassjvwtuQamFn8=;
  b=l/8wF8nkaYdqZ3eO8nkrg9PE/cHeyHC7w7DGcgswNRmDFKL2XY/QBRsf
   ptaL+mz2Fsj+Nxt+FZW85a4iActlflbZl1fy5F+OcHyhtfYMKtDsm9Otv
   zPVQEquQuV5nygIr+3CFQ4mYh7ZbGBwaPDEltdRUeeuwAx/lNbXurlWLH
   W5E1+tPvG9b2ZeeCAVzS2iJesg8UiH8yCQ01O/91VQl02OGScqrxm1Ac4
   ItRNEKvKvaEfpEjnZ1Wbax6QFfZM3CVsqXiBK5e0/QXG6ngnToxWa9PZh
   d7Xk0UqNqUsUMNlVnbZ6Jhxc9ZtcCTEDVzqtVqkYyNwRrzvvRlMezSeAq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="389202427"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="389202427"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2023 09:24:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10747"; a="691488259"
X-IronPort-AV: E=Sophos;i="6.00,257,1681196400"; 
   d="scan'208";a="691488259"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga006.jf.intel.com with ESMTP; 20 Jun 2023 09:24:06 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 20 Jun 2023 09:24:05 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 20 Jun 2023 09:24:04 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 20 Jun 2023 09:24:04 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 20 Jun 2023 09:24:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c+RxErxu7wA9HZ3BHHB3SESGDKFv5+Ynp7xFsFi6ZXjehtWVRF9lY13BYAh22T21xRDengDpn+4NRkM4QDj5ALxzppRYE7BsQ/yYOL20YyrwSkZSEDJMDg5p+dp+gS1Y0P/X+LaXuy+u4kfkxvHe2hQEQKAp9OIptNzwuVdMkPrf8RN835qgKQu/HLUZOHFxi+kzwQXwqR+W+F1OkOiT6h4rn4DFXCCeuMJEZQouKqZG9osnC9BUnJUQbucOsGBDWGSdPaNtE29XFTtI4XRGHTFWTuv9NUUZ4Agm7RoMwkYPh6qZaTJ0f5D6+QtxxuXt/SGUXYjz3IOSoXO/XF4OLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBXvsebQZ0N4C8UQEM2FC+P+yKzDW4ilUy8JaQLwrK8=;
 b=dQPZDXUx2MQC3w6htKdEP1mrCX52PqPSMgtRdgaHndbFQdzkCGdZmzmtIO5XRpJiknvMbRbHyZ/JNc3JtTk2VFYdWWtIMCdiQQ8QpVGGZwly2GoXv66+nK2HclRdkviwM9or1MbcHjJe6XTZyx76LNyRgl27Y60OyH0cFvEQAYhVoKwmn7pAYUnF69g53esVVOQiQjddAmZff/GXFEWelm8fc5GqFPTmabs68ToE6fFINSnX+CLyvEtjAl7vJOMyl7tegQuWZbqafgL8iwwpSbx8+ErxjI6QPNUawH7EcHvXwe3gskArfHrvOpNy9PGTGW9WIGH16Itig4tJrgs13A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS0PR11MB7409.namprd11.prod.outlook.com (2603:10b6:8:153::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 20 Jun
 2023 16:24:02 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::7237:cab8:f7f:52a5%7]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 16:24:02 +0000
Date:   Tue, 20 Jun 2023 09:23:56 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
CC:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/5] cxl/mem : Expose dynamic capacity configuration to
 userspace
Message-ID: <6491d29c4a019_483a2941@iweiny-mobl.notmuch>
References: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
 <20230604-dcd-type2-upstream-v1-3-71b6341bae54@intel.com>
 <ZIpeCsiJgLcD7eju@aschofie-mobl2>
 <648bcd316f4eb_1c7ab4294c9@iweiny-mobl.notmuch>
 <a6a0aad8-febe-d466-ed1c-105b8bf4cacd@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <a6a0aad8-febe-d466-ed1c-105b8bf4cacd@intel.com>
X-ClientProxiedBy: BY3PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::8) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS0PR11MB7409:EE_
X-MS-Office365-Filtering-Correlation-Id: 74c3b8eb-c216-47c9-e7d6-08db71aac244
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uVMnmbf4dgHwKvuL0OuKvYFj0HfaQezxj8LsuoNuCQd2eWFnxclHgfcduv6cwxsg8yX8bHklFoK1eRMas+ubcSwhmsgR8f0epRRLtSECtF3c7b45ptMXt/yoDAFCI6+9dQTgxl5ZmzqpODZYanofDK7bWdCifPauu0JU96UskZg2zB5j5t0r8JlDu3zNbO60sXstEV5ZxDEJJhl8Sqqyv9deMluqzPDmG0tUJC46aDXE8bX85AlKALgcDq7CLbjPS72f3L48JJyPKu5hIMdIAa1s60ghoF8TjYhnnWue7mlPyA/MxTh2Rl8pBfUA80Ukx5RTkz18aNeFWbuNOEUgiM0BTcZweUb8cVmdxIyZBXs368o7hHC9mxzXCGqhOaK5Mv82ulfcfOvVaBt0dPsrW7IcwNR85/Ub7K2LCXq1tl6NeSkiX5OKB+ufHTJAUpH13BnayZd6s050xQEmdZNgFgOEI56PZpe+rTUBg84VXUfpPka4eO03+tWyLvBNDDb7+5jp6vgsLZ9CF+KPMONeCCMkqHtE3jejUSRLh+fSWuh0NI/zjXBgeuFtiXVTaC9Q
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39850400004)(136003)(366004)(346002)(376002)(396003)(451199021)(86362001)(66476007)(66556008)(6666004)(110136005)(4326008)(6636002)(478600001)(66946007)(54906003)(316002)(8676002)(44832011)(82960400001)(5660300002)(8936002)(6506007)(6486002)(38100700002)(41300700001)(2906002)(53546011)(9686003)(6512007)(26005)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?y3+gytBRNhZ0fvxaWQjTGBLVKrna4iVrmdfegQ8UnsrOXqU8w6q30JpxSBzd?=
 =?us-ascii?Q?es5kiwV3yUdQqhiF5f99TpHp5jB03fvrS0Oc09AJh/rxq8kAQyVc1gHyHz9i?=
 =?us-ascii?Q?+N6HaUG0pwl0jnt1aXTLVpRsrbrJdrgZLUits7+IZbYJ3+JBty9cW2LTJPjQ?=
 =?us-ascii?Q?BOK2y+lb3rpkM2u0hDnClSEs+a0Yf/OzgJlGmWqv8/5ptfLah588rdK7CJFi?=
 =?us-ascii?Q?YmrTk6/O4AMtSXZCFDZSMavCVSTDpjZWEjFJ61qC2Gxpz4OiumV/QZc9VPOk?=
 =?us-ascii?Q?bt0UXdZQ1ilBKC8I/8weKbMifNq9hNQ8gB+VlzwyJhpq2hwxZv+LpiXPo2jb?=
 =?us-ascii?Q?YOQ/Kfcaloa3zoCc87jy+kghYjVg9tLrlIdC3ApqcP/1vudunprrJa7G6ru6?=
 =?us-ascii?Q?oHJSx3lyfEmsQYo+sMnfaFpqoCDNGw/QClKNAZUraiM27Yju1MNGkaUsR1Uz?=
 =?us-ascii?Q?/w9s6lY6Qa2/9IBYfeb/MYjtxWFaBx7tx3JjRDMf2256rOWBe/AF4cXWyuSz?=
 =?us-ascii?Q?cITAQXHy6Rx03kClRRT/BhoPInVpMzuzKtbxxqWVNFiHMT17N3dSbehIn7/a?=
 =?us-ascii?Q?keH899SAXCgIGcXwZRDjShRgRPeD9BTfPxP7JSot3/1z8p4afWx1yhWMrqNH?=
 =?us-ascii?Q?SNkPACU+GidQ3MTcNQoTi7YcLxP+J+yc74Lx0xCmYChB/YnTBQJHGZ85dprm?=
 =?us-ascii?Q?YD0aMD1cfTZIEs584i6duJZj5Iz6IMeQ/CoyJD17T+tWYNLVapqHIDynDvZQ?=
 =?us-ascii?Q?0+j12pImVerpoKuExxebUhlz2p13zypnF3V697SpGVkULYdAnJAIxyju/RU4?=
 =?us-ascii?Q?93l9p19O7mc58Ab2FP346CxJEH/Nx7S4+f6akQTPx1w7UaDW9oWQitxVZeLG?=
 =?us-ascii?Q?ThDWz/MRN8SShhEwigZydVEphpizf5Ul/zuOc6QYjzhNIhsgYJkGWNvNHkCK?=
 =?us-ascii?Q?6Yq4vy7BCUO2Pvxf5u+xz0CZJsAto92EuJe5M4btZIruvfDvZRISjlwS848Y?=
 =?us-ascii?Q?e/C8463En28asqr0RufcHO29mOGmwf7YCEG6QakswEGoVHiKCAKqSNu8Zrho?=
 =?us-ascii?Q?dUeRt57ttoHFMS5LlTCm0rrlwuP/zx2ktuntYORQs6wAXaylzzKGJXZDCuTO?=
 =?us-ascii?Q?MJlIMJA5v2s5hYMSIKvfTy8LaChZP32aLqvHvrJS0/1AJkOuQAPY/5vvLti5?=
 =?us-ascii?Q?TqTndoQeuwIzTljWUWal0g7rbujxKHp7KXD7SeCnU9K9MoGtw2zYpT1ZnENH?=
 =?us-ascii?Q?SFLXjWl8btdZAjQZSF2AaMRA0G+0ECiYq6o8oxs5+UUWCf6aHJAngV6lDI4u?=
 =?us-ascii?Q?uKT2Xt/Cye0ienSSd++yCpWARV7cz7jbprWOxAUxmHN8c1hxFnNJ+VdekO5i?=
 =?us-ascii?Q?+K9yuuvIYS/S9aBJ6FrmscvbqETgn0WjXMVNS3UhYS4XNrz+qhh0S6ExXl4K?=
 =?us-ascii?Q?g+pfGhVQmCzeGB6I2suZESZ/90vFQnCjxteCeJI72UYYQgzb3DQjyetjrwh4?=
 =?us-ascii?Q?MXEFBT+hDWZEOC9SN/XD94xjrgQ4GB6SK6X5p2kb3Fgw0r9xAVPoDphdb/PT?=
 =?us-ascii?Q?N/fEB/msslDjnY+3xS+EEcThluYleeBvOQdnxyfk?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74c3b8eb-c216-47c9-e7d6-08db71aac244
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 16:24:02.4415
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zrw2F/7E0aiLk7WZLON8abHa0/GY7m4dw+fDFdqaspAVuaBxURJfihx9Gocvj/Kf87khP72ccPBdUrmHhbx7CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7409
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Dave Jiang wrote:
> 
> 
> On 6/15/23 19:47, Ira Weiny wrote:
> > Alison Schofield wrote:
> >> On Wed, Jun 14, 2023 at 12:16:30PM -0700, Ira Weiny wrote:
> >>> From: Navneet Singh <navneet.singh@intel.com>
> >>>

[snip]

> > 
> > Writing the documentation it seems like 'dc_region_count' should just be
> > 'region_count'.  Because the 'dc' is redundant with the directory.
> > However, dcY_size has a redundant 'dc' but Y_size (ie 0_size) seems
> > odd.[*]
> > 
> > Thoughts on the 'dc' prefix for these?
> > 
> > [*] example listing with 2 DC regions supported.
> > 
> > $ ll mem1/dc/
> > total 0
> > -r--r--r-- 1 root root 4096 Jun 15 19:26 dc0_size
> > -r--r--r-- 1 root root 4096 Jun 15 19:26 dc1_size
> > -r--r--r-- 1 root root 4096 Jun 15 19:26 dc_regions_count
> > 
> >>
> >> A bit of my ignorance here, but when I keep seeing the word
> >> 'regions' below, it makes me wonder whether these attributes
> >> are in the right place?
> > 
> > There is a difference between 'DC region' and CXL 'Linux' region.  It has
> > taken me some time to get used to the terminology.  So I think this is
> > correct.
> 
> I think you answered your own question above here. If dc_region is 
> different than CXL regions, then you'll have to keep the dc_ prefix to 
> distinguish between the two. Unless you call it something different.

But it sits in the 'dc' directory.

memX/dc/dc_regions_count
memX/dc/dc0_size
...

So it feels like the dc is redundant.  But it is probably ok as it is.

Ira
