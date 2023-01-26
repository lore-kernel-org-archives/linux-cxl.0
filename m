Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB735C54E94
	for <linux-cxl@archiver.kernel.org>; Thu, 26 Jan 2023 05:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjAZFmR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 26 Jan 2023 00:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbjAZFmP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 26 Jan 2023 00:42:15 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A115AB59
        for <linux-cxl@vger.kernel.org>; Wed, 25 Jan 2023 21:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674711734; x=1706247734;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5/PaFROUPlk0qx2Pm/L0Qnz9itgbl6Q8BhEHXrpra9g=;
  b=aN4Zk2ld/vWmhym/BzNLL3/q1uEysAlQSuxFM2juUMegRc9Tf+c41xus
   3DqOqD16dZN97uczKiWAhoeDA0vtpcYFIRA3yKOuDTlh4ATG7eW0K3FuT
   YmCKEkO25Ct3DyhnTXv/1YtBuGMLjWZlWsqi8RqI3cEIKb4DVjy4X8N9B
   7rNWctRwFEb4YqoU7uUS4UZlIpms0BNaJU3y1jebAbXhf1XhzQuAmIItF
   SUgrCTxlyBLp6Zil9XOgfGQlQoTmTLvQJzeD+nmb8ajz/4WXheMZ1enXk
   Obbj4Y6UeCA25K18YhQyUa+QYwAgXRJtCipqdYVNp8fdMU/D1LumjRsEF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="314652644"
X-IronPort-AV: E=Sophos;i="5.97,247,1669104000"; 
   d="scan'208";a="314652644"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 21:42:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="771007305"
X-IronPort-AV: E=Sophos;i="5.97,247,1669104000"; 
   d="scan'208";a="771007305"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 25 Jan 2023 21:42:13 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 21:42:12 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 25 Jan 2023 21:42:11 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Wed, 25 Jan 2023 21:42:11 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Wed, 25 Jan 2023 21:42:10 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WGaCefzdp6tX3m+A65HlYATWi29rMpKHu0fw5yztwwvfwxale4NuvPNXCx1ymTB0UqH5Z3Oo5u/xMLoMZch2U5NSFajHQhwi/VeIREw8p0K5yLKHZjDIGwMikPmdLs1TU2zslaUt6bZYs9qvyO+4vtlse9QuJS5ey/EV7BCuj4LqeCmF0AoDhMPA2holHRHWsEFKcpC3K/ZAy2PNsipLSVMYIUF9kl5cB7kQCG0gmNWvUhbqkPbDQCqGAN3OnE9uJuqH4ZbC2DcuOf+zjbzHa9PmMdLibhIm4H9bKFywDMIoYkXRVY28Ux57tTHRtSMH0HioJJMGRnFO64rFWMJGJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EhN6ZGMuVXJO1AlpvDs4Lt7SWTwCS10dusmen3X9+sc=;
 b=lmDmMgiP4H0MYvXldyZitzCbf1JOYEKTVM9lFaLeEKXdkCP1Iz2i5TfwF/AfHKTYPp8RQrlagY1PnoTQVA5SYYAp+wMWd5TYRHJw2u2b6w7OxIHQmzWV74UzBeTN+pGF5Oi/S7YV2OSxdwnduV3hh7mPJBhNyY2AhBSApQStjIxm0t4Mu+f7KHsUXk4t/4QWfSHmbmWUM998Nudi49jTxYLW2u697dG7TD8rRTDVlS5T2/Qu+lVBDZ7+vxFF7y98MHR7Dub2RiqsNcGhsh0g3ereR1myfXIXDnLm6Mg0841/EYBBgkHqvfLxWVh2apZ4I121OMzSP8MPVVaw7iuACQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS0PR11MB7804.namprd11.prod.outlook.com (2603:10b6:8:f3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.22; Thu, 26 Jan
 2023 05:42:07 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::6851:3db2:1166:dda6%7]) with mapi id 15.20.6002.027; Thu, 26 Jan 2023
 05:42:07 +0000
Date:   Wed, 25 Jan 2023 21:42:04 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>
CC:     Ben Widawsky <bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        <alison.schofield@intel.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>
Subject: Re: [PATCH v2 0/7] hw/cxl: RAS error emulation and injection
Message-ID: <63d212ac26dc_3e0422944f@iweiny-mobl.notmuch>
References: <20230120142450.16089-1-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230120142450.16089-1-Jonathan.Cameron@huawei.com>
X-ClientProxiedBy: BY5PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::17) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS0PR11MB7804:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dd8c603-2ad7-469f-d1ac-08daff600fb2
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kd9o7UeAlNQ6eP6b2kg7rfBy4tEG0Cs0TLKHiPdxf+cL1z68HStQ3KMVBvSIprj2ePfPLKlArposA6y2sxXTK/uoXpBRPQEyA110jAL27/mA1tOQRh8uUwtZuqJfhhf2x8KUyfsp6owyrAq1YOSnWI3tKwWLqqtX5fwvPZKJWIIIdx5/lfdzdIzabSFDZgOfwVhDFEW+O81hil/UVk+FatPlu36a+gnXX/AITvkaDAnG1k//JGE5bQRIKl6VA9GHR1GfLFukRPWAnXybcxhz5p+0S+YdCOYvd0VKxP3gTCYSSPZ3OI6gpkB+UUdFy3CMFVBi78i5lNm3hERjiAWwyB8Av1sTxZsv7jhDGlDOftPhUQ0QCQLFqgEtbBlaYhbtkS3kOi0Gy1VFciphgTdSAzPXxkyu1AWzee9HBp6+TrrwUbc/iaj2/0EYjuV5m6q7Z20SigA28RIbhTMZyxOEaqn95H9AhZ52b97JFZLySXc50VYCvGlPGviYHLUOaZDRrwmOOAdFkTsxeJeUD+fNIIYH73H0XCZiL3UWEj2f7wlzcsdggQNv7Ubpzl6cK1fthRCkVUV1RTPySfT0BvW4X4sQO83G1iAv+i5F3gw3Vr8izw+by62QmpdQPHOhkz2Gh4dZ+YGOHsvTzleBsuU/XzCo5RAymsXQr05ZKP9WFchxzPWuR9Qcq1E+99tzY3xUF3X6IBZyDU+cwJqa2+c5TQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(136003)(39860400002)(366004)(396003)(346002)(451199018)(38100700002)(2906002)(44832011)(316002)(110136005)(6486002)(478600001)(54906003)(8936002)(966005)(41300700001)(86362001)(83380400001)(26005)(9686003)(186003)(6512007)(6666004)(6506007)(4326008)(66946007)(8676002)(82960400001)(5660300002)(66476007)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EZrwDizl4C6G01DAMpjPLkQYXZjRx3yh4Pg+Al49mGXwYjk8GS7KEcKWOV4e?=
 =?us-ascii?Q?08UiAcijpUswWOrjbE+iGieP1jLdMxTjWz5i5D8MW7wsTX7uGWhOWQN/pJ6D?=
 =?us-ascii?Q?92cckRGu/3Dy52gXcU8msZAEYE1A2KclOCw53x7Iqx87hL1xA++x+6s6H//t?=
 =?us-ascii?Q?IG/7njyqhXTFrekcS0NZ5LR1XVX7q0wQ9julzahSqrD8f/d/xGMhaiUDEaVE?=
 =?us-ascii?Q?9Tz90+XpeQ8zEZ762/ySZOzdXacsQDeYufplP5pLD6o7z4m+/o45mrxxOVzA?=
 =?us-ascii?Q?lGFfOkhaaIp0a1RN/nqSvhQKNq3NPczBuoxOqRIkZ3rL66jYJ39J4SIaRBDP?=
 =?us-ascii?Q?7x04ZFiMWVcspu2l3eI+ReJel3+6VJCI8Z/cG7hPWGwmcFRR9lJX6WK7dLPw?=
 =?us-ascii?Q?3hjK+7s9CMedN4ivvZKcMutnPLQIGthasJM4yfvtCYdwbP72nLWEyaWZLPYX?=
 =?us-ascii?Q?AuUllnYH3RGvnlTyyQyV9xyDmSPlR6/+766KIhWSJM7R1bcWGyq1eq2Rcl/+?=
 =?us-ascii?Q?j4JYixVJz0L4oc5WRbwczaQOEReJcwR3BQ6zu4PcmwCTuaeoTiP1jdMnJHzA?=
 =?us-ascii?Q?dEgkwdQmeFG2a14YxtGGu1uPLmkYkjQXtOsZywmM3yyRqGf1/BUxGxFyrR6t?=
 =?us-ascii?Q?AStbwCazwsK5+ea+d3pJOo2/c8iHd7A1+olgAVEouySDmWcB7lBYvjUxx7BO?=
 =?us-ascii?Q?qsn+HICBbJ927niOhZovm1hIAWXe5eV/x6eJM9GOJoVMCPmKsg7zc4XP+3SA?=
 =?us-ascii?Q?4ymdxU1Lrf1BxwNQEzsMqAyrF0G/8h6XxQepIVGb6mca02C0FU7/GKbuRW7K?=
 =?us-ascii?Q?cFUGW8EyO02vh5mWyXLi00NpfWxGcUGT/vIkXVUla6ykV5G+9d2lxdNywzFX?=
 =?us-ascii?Q?qqTii71PFJ0xVO0VVtHubzmeArBaDRoFkIot5RIsh+9fkGevHYUlEgJbNSZ/?=
 =?us-ascii?Q?LTmNaZSJGcNv0Hoht8kLBCs5JrC9sjNjPKhUJ9cLqRgLbPq5iflss3cIy4cP?=
 =?us-ascii?Q?yr8wem8uREqfmWKz8ziyk1Sy0TVMnlS9vYc8iqjFmfzwXqWA1Vn6Bekj2a+9?=
 =?us-ascii?Q?quhDSgnVqRqC739gXZZMzzBoXPHkaDRCE+bLJeqAH/QqFyQ4xZ+ovzBnzRli?=
 =?us-ascii?Q?U1GIfQp+lnTcNTWGeMy4GQcFPrgDvOH7CbxPQ2tjWqGUDLI0RqA3AnKKptrl?=
 =?us-ascii?Q?O+teGlkHbOTzjZkpel1DvvEQhR7BIqlSQz1XvI1pTld14a6RUeOs8qEnMrhM?=
 =?us-ascii?Q?2jEJGZTsK6L5Dpdo9BWy3HaseKdftLa9CdgnGC10RV4DN5GvwJNmpohS+L3s?=
 =?us-ascii?Q?1Jg4Yaic6LoH8//j/+tGi1IW4XingBaDa7yaZ5LWAaymfc8Mcip2bqYLxMr2?=
 =?us-ascii?Q?SSmZDusKPQrW+wPG9dmZUW4k40aKFmX8Ul9oWuHSQyRkiyKP22cgDAzS2J+o?=
 =?us-ascii?Q?zzFrPYHkx92JnY6cAv5C1bSUZqiZnMDp2TcPwtOAnd5uljN2jbv1sDcM2Gxk?=
 =?us-ascii?Q?9hZo2LnK/zQ5Y6MVxcbif8DHvxQ94V9teJ3bmQMN2Wt92kssk/YPfNPGHCoc?=
 =?us-ascii?Q?ScFIZysxF8o3qFm+NquJcVUJJAwp4UK72v7yFFC7?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dd8c603-2ad7-469f-d1ac-08daff600fb2
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2023 05:42:07.4459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7bmNAU/fLXqL8hMCxSllvtAv3Y9WR9TUpsmEn4g3wgDanMlydIsxSzHIzkzU3wd/G4Nv0XElQls+1FxSsutIbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7804
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron wrote:
> v2: Thanks to Mike Maslenkin for review.
> - Fix wrong parameter type to ct3d_qmp_cor_err_to_cxl()
> - Rework use of CXLError local variable in ct3d_reg_write() to improve
>   code readability.
> 
> CXL error reporting is complex. This series only covers the protocol
> related errors reported via PCIE AER - Ira Weiny has posted support for
> Event log based injection and I will post an update of Poison list injection
> shortly. My proposal is to upstream this one first, followed by Ira's Event
> Log series, then finally the Poison List handling. That is based on likely
> order of Linux kernel support (the support for this type of error reporting
> went in during the recent merge window, the others are still under review).
> Note we may propose other non error related features in between!
> The current revisions of all the error injection can be found at:
> https://gitlab.com/jic23/qemu/-/tree/cxl-2023-01-11

Thanks!

I see all of the patches for the event log stuff has landed in this
tree.

I see the following:

	1) I have cleanup patches for[*]
		a) The timestamp change
		b) the g_new0() allocation

	2)  [PATCH v2 7/8] bswap: Add the ability to store to an unaligned 24 bit field
	    	Was left alone.  I'm good with that.  But did you said you
		wanted to move it into the CXL specific code.  Did you
		change your mind?

	3) Thank you so much for fixing the optional variable stuff!  :-D

	4) And thanks for the CXLRetCode fix.  Thanks!

	5) In the latest code from 1/20 I see you fixed the static const
	   UUID,  Thanks!

For the event stuff I have tested what is on this branch with the cleanup
patches.

I was not sure if you wanted me to re-roll them or just send fixes
patches.  But I'd like to move forward with the fixes submitted if that is
ok.  Those are all minor issues which don't affect the behavior much at
this point.

[*] https://lore.kernel.org/all/20230125-ira-cxl-events-fixups-2023-01-11-v1-0-1931378515f5@intel.com/

Thank you,
Ira

> 
> In order to test the kernel support for RAS error handling, I previously
> provided this series via gitlab, enabling David Jiang's kernel patches
> to be tested.
> 
> Now that Linux kernel support is upstream, this series is proposing the
> support for upstream inclusion in QEMU. Note that support for Multiple
> Header Recording has been added to QEMU the meantime and a kernel
> patch to use that feature sent out.
> 
> https://lore.kernel.org/linux-cxl/20230113154058.16227-1-Jonathan.Cameron@huawei.com/T/#t
> 
> There are two generic PCI AER precursor feature additions.
> 1) The PCI_ERR_UCOR_MASK register has not been implemented until now
>    and is necessary for correct emulation.
> 2) The routing for AER errors, via existing AER error injection, only
>    covered one of two paths given in the PCIe base specification,
>    unfortunately not the one used by the Linux kernel CXL support.
> 
> The use of MSI for the CXL root ports, both makes sense from the point
> of view of how it may well be implemented, and works around the documented
> lack of PCI interrupt routing in i386/q35. I have a hack that lets
> us correctly route those interrupts but don't currently plan to post it.
> 
> The actual CXL error injection uses a new QMP interface as documented
> in the final patch description. The existing AER error injection
> internals are reused though it's HMP interface is not.
> 
> Injection via QMP:
> { "execute": "qmp_capabilities" }
> ...
> { "execute": "cxl-inject-uncorrectable-errors",
>   "arguments": {
>     "path": "/machine/peripheral/cxl-pmem0",
>     "errors": [
>         {
>             "type": "cache-address-parity",
>             "header": [ 3, 4]
>         },
>         {
>             "type": "cache-data-parity",
>             "header": [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]
>         },
>         {
>             "type": "internal",
>             "header": [ 1, 2, 4]
>         }
>         ]
>   }}
> ...
> { "execute": "cxl-inject-correctable-error",
>     "arguments": {
>         "path": "/machine/peripheral/cxl-pmem0",
>         "type": "physical",
>         "header": [ 3, 4]
>     } }
> 
> Based on top of:
> https://lore.kernel.org/all/20230112102644.27830-1-Jonathan.Cameron@huawei.com/
> [PATCH v2 0/8] hw/cxl: CXL emulation cleanups and minor fixes for upstream
> 
> Jonathan Cameron (7):
>   hw/pci/aer: Implement PCI_ERR_UNCOR_MASK register
>   hw/pci/aer: Add missing routing for AER errors
>   hw/pci-bridge/cxl_root_port: Wire up AER
>   hw/pci-bridge/cxl_root_port: Wire up MSI
>   hw/mem/cxl-type3: Add AER extended capability
>   hw/pci/aer: Make PCIE AER error injection facility available for other
>     emulation to use.
>   hw/mem/cxl_type3: Add CXL RAS Error Injection Support.
> 
>  hw/cxl/cxl-component-utils.c   |   4 +-
>  hw/mem/cxl_type3.c             | 303 +++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3_stubs.c       |  10 ++
>  hw/mem/meson.build             |   2 +
>  hw/pci-bridge/cxl_root_port.c  |  64 +++++++
>  hw/pci/pci-internal.h          |   1 -
>  hw/pci/pcie_aer.c              |  14 +-
>  include/hw/cxl/cxl_component.h |  26 +++
>  include/hw/cxl/cxl_device.h    |  11 ++
>  include/hw/pci/pcie_aer.h      |   1 +
>  include/hw/pci/pcie_regs.h     |   3 +
>  qapi/cxl.json                  | 113 ++++++++++++
>  qapi/meson.build               |   1 +
>  qapi/qapi-schema.json          |   1 +
>  14 files changed, 551 insertions(+), 3 deletions(-)
>  create mode 100644 hw/mem/cxl_type3_stubs.c
>  create mode 100644 qapi/cxl.json
> 
> -- 
> 2.37.2
> 


