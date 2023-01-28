Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E77CC38142
	for <linux-cxl@archiver.kernel.org>; Sat, 28 Jan 2023 02:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbjA1CTV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 27 Jan 2023 21:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjA1CTU (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 27 Jan 2023 21:19:20 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C1ED5999A
        for <linux-cxl@vger.kernel.org>; Fri, 27 Jan 2023 18:19:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674872359; x=1706408359;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ms3TRL3xoQ74x8kNLuyNqjijymHNG32KV/MYNASyh/Q=;
  b=eWf8/cC3q+fhvjDhfuPmawHEka5BiFbuF7ysiEgaUcaAiaPPRoHZspyo
   8SqaJgcFSjBrkLvX3J+10bbakm3F7Y+nZPLfoyhLHzyPwLaG/lfWq39Mc
   p4CmzoUqJcoZpWreAos1+Xrhh8hTJ3l/hNiq5tf1IZzCp5P3ZzB4YCenC
   7OMkQ4vajW6i67374Cqiatz6qzPA0dChKjLHODpy4AHTqWiLee6PpuD7o
   ZlqaOFfjxYrG2YDYoXUiOsAwoynwwzK0q4GkYEeNO6XVjm+WvTv0umlJd
   d1WFC7uRhxpBIUfdI4/bAVxr148hjUrPn2poNMobk0zgAG31j67e2BuVg
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="315207115"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="315207115"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 18:19:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="771785170"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="771785170"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP; 27 Jan 2023 18:19:18 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 18:19:17 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 27 Jan 2023 18:19:17 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16 via Frontend Transport; Fri, 27 Jan 2023 18:19:17 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.103)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.16; Fri, 27 Jan 2023 18:19:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cbicDfrdojRSMinORTXtGFQgw1rYRjn/uffbFjD4p0n0M0stGRmkJ2RZF+QWk8NMKUFx2n/6bFXapPa8mVmqwXRm/I4LEBmhf24BhZYY4Bgna0ey6EOET+ck5tinSqjms7EtHPDpydkZgjYv2XfYjSAqbYc0QdKOO8SzLSP4UdvePSsIjejjIjevLUYdc1uzRgurx9I10tPVefabprVLV092XY2Gtl+lAK4r05ViG/LIskItUk4DN0Ghj2FN+OhedT3+1bpTFhyXnXCiiTmqttLJLvcgmu50JPUud0cdaB1cLF4bLtpvjxSSwej4XLWeTiuj7jZaSqg8AIGPU3Cekw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5rp6jT30rqWXrhkRAeyTxFBRUzDwKOuzTv3OnduzlY=;
 b=MxgnOZ/YvwzFzv0TeKE60bXlwnwfTtof8+qYoCVrlChOwCQv08IIVlyTG0d3Psc+7CBemqWiWnrFmYWwG9YkCwEm/ksrpspxITqvYLnPT93jbxkYf+erJ4etdyYKZzJtcUK8zDnXd4R942dzVAw/Yur5wv5pcsCzwy+MlMH8tUVB2eQi7DR6ufLoACSAAFVM1/TiNPlbyn9R6LF6nQSXkeTvExRH90lrVwSaa6ibrIjcu7VuV+zhaaHhrNM/lMEV93OECFsyF+4ct8Wx5+Y+vPP5s5E5TRetcK2unClbrT7I8HNRLw+YODDAEeDppb2cVNmfgT0nxyoJNvbylobV6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB7701.namprd11.prod.outlook.com (2603:10b6:a03:4e4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6043.25; Sat, 28 Jan
 2023 02:19:15 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::421b:865b:f356:7dfc%5]) with mapi id 15.20.6043.022; Sat, 28 Jan 2023
 02:19:14 +0000
Date:   Fri, 27 Jan 2023 18:19:11 -0800
From:   Dan Williams <dan.j.williams@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 2/6] cxl/memdev: Add support for the Clear Poison
 mailbox command
Message-ID: <63d4861f33384_3a36e529469@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1674101475.git.alison.schofield@intel.com>
 <3ae253f32602a62fa7521d5787b1b26b1c808275.1674101475.git.alison.schofield@intel.com>
 <63d464b7cb7ff_ea222294ef@dwillia2-xfh.jf.intel.com.notmuch>
 <Y9R3uP/EBBt86ow/@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Y9R3uP/EBBt86ow/@aschofie-mobl2>
X-ClientProxiedBy: BY3PR10CA0004.namprd10.prod.outlook.com
 (2603:10b6:a03:255::9) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB7701:EE_
X-MS-Office365-Filtering-Correlation-Id: e94dac13-f759-448a-d521-08db00d60cbb
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bu45bsEW3WQFcDOO8BWBQ9oipkNCikVQOYSpvwgVJPs5lWwrswiROX0UexMT7awbOH57/aQqU0BtRTIsH7bakGNTun7SR41o72c1ZvJzIOvkH96CunsEPrBTkRBsulkS8F0d/IQm445G+1Lu2ql44tFroa7NGhDe2MVE7qWuzr0M6Cxb/9kr5Q0wuqUzBFtO+KlwIfBkPNfuzTVRe2mW4dAMgZuq3/bgHUJKvygiZ3oy7exACUzSZXXexIblswmqslg//Jhx8iKRgaUw5BGWD2zomnVs8jrc3X6n75DG7+XRubDTrt4qlWPfJhsI8mAs0VPtvPspAVpvTEVZZ2zA9JUj/jT+6TCfsjS3J3TlX2Kej39O4Avrhb7NMsNmEFbSs97QDl1ezoB9Co0LqbHHv9Iyx1NhY/pI5OHiGxbbN96ZdIh/fPiCk7Icbjj2rnARKmrGwO20SyLvHb5GjLSOPdSh9g6l4MYIJACPLs7GLo+LfLK8fRT46x2oOT8MTnlpD39xCBboskAtYL4UUJbg+U4S/yNDR1pv5igUp1tFg4MUhmsojM4ZosYTQQCtUR+3DTrf8yhRIh75SCRa1NEmMXSFmdKj5IXNUeimz2aiIT6+dxchb4O49Wm96QNEKDKSNDEhMhYfbfju3tucp5XnVkI+CLizZ58/P4y77lHIWcr37/eGGlTo68YJNTAHKnEk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(366004)(396003)(346002)(376002)(451199018)(66899018)(54906003)(110136005)(966005)(316002)(478600001)(6486002)(2906002)(15650500001)(186003)(6512007)(9686003)(6666004)(66946007)(8676002)(66476007)(66556008)(6506007)(38100700002)(82960400001)(26005)(41300700001)(86362001)(83380400001)(4326008)(5660300002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iVqtaN0DPpSJCqEvT6VGVeeQjCJtIAb4KRNCZ+IMVcty1EuP7jhi2OtlFJ01?=
 =?us-ascii?Q?+igp8TGfkm/zHdmGsQaQVIw4jtnNd735WrWKX3A7HCIAaXxlv0KSg831VMGZ?=
 =?us-ascii?Q?iSHDH0XnEvvgOeKWdj1QTE02Ql32lOP2yNTaJboOzYc64nWosf90B2s1K/RA?=
 =?us-ascii?Q?qJmTiwwznVqapHtLEFj6DIEUvAR2O5/UKE8TYE/tCkIDSFKJMulfxE2sm/0f?=
 =?us-ascii?Q?CfgTLvtQohemcNhjU6REhaTD8Gom83YE8ESAN76i/0ndGtLXOlqIeUL72D0E?=
 =?us-ascii?Q?LXCh/4riEiy76CGxLx9XntLRIZuoZdYaazCs8TfmTuCsPllS4PakMAf1hG8P?=
 =?us-ascii?Q?8kXdyj9ZY7rdxhxOhD+yIW54B0tdsMWbF5wdH5/eAuVbmJEwJwyCzFgaHQH4?=
 =?us-ascii?Q?JpB3kRbaHp0LZMcSSGgGX5zjKA55Sd/u2p8vZMbiWv9DD57Ftyrvs60nvwYp?=
 =?us-ascii?Q?kILQwhwzj0EcJB8X3Gs2AFfMw1sq4PM5WN+c5OjBw3TCR8VusEURADatXzLo?=
 =?us-ascii?Q?8wINVa5CmCvQCoMHlvNmZ49RFr8XVFsiTHpdDqJ6AQe66BWc1M0LvBlAbBeM?=
 =?us-ascii?Q?A/LvHZ7GwtEefUyfp8tOkU72VD8Rjb0up14YQeEiekV0JmmI5NctqCvw6ERl?=
 =?us-ascii?Q?QbghiK0iKMyb1/pdEOKcnnwPvKsAKaSUXUYDwRuhqF/R304YHlbzDO/43XWY?=
 =?us-ascii?Q?rOGmozBjrxpV4AetzqrXXqt4hkELnROi7NyOCkKt5LVpE7ierahguc/+fJ4d?=
 =?us-ascii?Q?QpY9MIkmcIWpWWw6k1RMBwQQbJEsO6gukUUHbiYuJrAY5DaEMI1Jr+AGlr8f?=
 =?us-ascii?Q?7FL19tv9RqOEebBFJTciH9cgFwOKuIKA/K8rh0YvzfoorfIPsRzu/pyroqIT?=
 =?us-ascii?Q?2dY/5SPG2A3ymzVyvzsuZc3nN90DyPPTixGN1HyH15mImxZ1Q557QRUIkHA0?=
 =?us-ascii?Q?Jo7WQ36mVb+CavtabLnmA64FpBe9shN+VNaXuQ0sRA+6YyPQn4XoJVj/v5AZ?=
 =?us-ascii?Q?in4CqaljPA8lsQieqjWxX8sZz9gvbGMMqMZmR/usw4Q03OPi+jIEopDH56Dd?=
 =?us-ascii?Q?QllzVxAwWOEMwOkPcbFnABXD/Q3BqLHv7tSg1olMFDuSaMu446Va38ad3XZ7?=
 =?us-ascii?Q?bnTLuLsiqP/gmo1NrP08hYwXdB8ATbbij850l5eDQ9elznMd66tIPDY9Ncry?=
 =?us-ascii?Q?wHYYpCrAI7C1K4MDVMBf73n2ahCil/NRW0TxPNA0Ut4ni+4+cVQWxxPjfHJg?=
 =?us-ascii?Q?Tmtj0xrwcYN0okYtMFKx0eWYR1v25h6YRKYqIBRyhELqRU7ZIKFK4wQJE+WW?=
 =?us-ascii?Q?3WAlUuJaIuQKE1bsyr2wateJpNnLb20QTwBglyYGXT8MJ3lgbvXrhwYjUd3/?=
 =?us-ascii?Q?V4+pWHWUv0QdA3UsbV8IdVEMBHo98RDaos/aIU/eoz+MV/FXw5lByxXKvbpi?=
 =?us-ascii?Q?orUNRnK/+vyr4MkXDmQn0cuC5p7uK5IpF8yET9M6kLGNOwU8QHgmnynvjH2V?=
 =?us-ascii?Q?aoFNJri99cZKPFCJ7Jn6LEtKmBzuhFIQ4UDWMzSCRougeBXlkBX0ICyp5gDe?=
 =?us-ascii?Q?ucRR3pCiv6AM92l8SOMQfOTXSKd6wT6HCDN8sV+Ri0IBEnDAHZx20N4alwNB?=
 =?us-ascii?Q?wg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e94dac13-f759-448a-d521-08db00d60cbb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2023 02:19:14.1101
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aWC9WH3AIkVIdy5muhrXpEUu2cEX1Pfuj/gFBByQSXz9yygJUW4ZWNGXgjviHb8QdmYNKHD1e+nkx2ihvDGFpDzn3+Oq4Jz9dXj8S3GgPow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB7701
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Alison Schofield wrote:
> On Fri, Jan 27, 2023 at 03:56:39PM -0800, Dan Williams wrote:
> > alison.schofield@ wrote:
> > > From: Alison Schofield <alison.schofield@intel.com>
> > > 
> > > CXL devices optionally support the CLEAR POISON mailbox command. Add
> > > a sysfs attribute and memdev driver support for clearing poison.
> > > 
> > > When a Device Physical Address (DPA) is written to the clear_poison
> > > sysfs attribute, send a clear poison command to the device for the
> > > specified address.
> > > 
> > > Per the CXL Specification (3.0 8.2.9.8.4.3), after receiving a valid clear
> > > poison request, the device removes the address from the device's Poison
> > > List and writes 0 (zero) for 64 bytes starting at address. If the device
> > > cannot clear poison from the address, it returns a permanent media error
> > > and -ENXIO is returned to the user.
> > > 
> > > Additionally, and per the spec also, it is not an error to clear poison
> > > of an address that is not poisoned. No error is returned from the device
> > > and the address is not overwritten.
> > > 
> > > *Implementation note: Although the CXL specification defines the clear
> > > command to accept 64 bytes of 'write-data' to be used when clearing
> > > the poisoned address, this implementation always uses 0 (zeros) for
> > > the write-data.
> > > 
> > > The clear_poison attribute is only visible for devices supporting the
> > > capability when the kernel is built with CONFIG_CXL_POISON_INJECT.
> > > 
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > > ---
> > >  Documentation/ABI/testing/sysfs-bus-cxl | 18 ++++++++
> > >  drivers/cxl/core/memdev.c               | 57 ++++++++++++++++++++++++-
> > >  drivers/cxl/cxlmem.h                    |  6 +++
> > >  3 files changed, 80 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > > index e9c6dd02bd09..7e4897e7bc05 100644
> > > --- a/Documentation/ABI/testing/sysfs-bus-cxl
> > > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > > @@ -438,3 +438,21 @@ Description:
> > >  		inject_poison attribute is only visible for devices supporting
> > >  		the capability. Kconfig option CXL_POISON_INJECT must be on
> > >  		to enable this option. The default is off.
> > > +
> > > +
> > > +What:		/sys/bus/cxl/devices/memX/clear_poison
> > > +Date:		January, 2023
> > > +KernelVersion:	v6.3
> > > +Contact:	linux-cxl@vger.kernel.org
> > > +Description:
> > > +		(WO) When a Device Physical Address (DPA) is written to this
> > > +		attribute, the memdev driver sends a clear poison command to
> > > +		the device for the specified address. Clearing poison removes
> > > +		the address from the device's Poison List and writes 0 (zero)
> > > +		for 64 bytes starting at address. It is not an error to clear
> > > +		poison from an address that does not have poison set, and if
> > > +		poison was not set, the address is not overwritten. If the
> > > +		device cannot clear poison from the address, -ENXIO is returned.
> > > +		The clear_poison attribute is only visible for devices
> > > +		supporting the capability. Kconfig option CXL_POISON_INJECT
> > > +		must be on to enable this option. The default is off.
> > 
> > So unlike error inject, this interface leaves me cold because it is
> > changing the state of data without coordination.
> > 
> > You might say, "inject poison also changes the state of data without
> > coordination", while that is true it is expected that media can go bad
> > without warning. What software does not expect is that memory could be
> > put back into service without coordination. A memory error wants to be
> > cleared by the agent that currently owns the memory, like the page
> > allocator clearing PageHWPoison and putting the page back into service,
> > or a filesystem restoring a file that was previously quarantined.
> > 
> > The only way this interface can proceed is if it can assert that the
> > poison to be cleared is not mapped by any decoder which makes the owner
> > of the memory the administrator using the sysfs interface. That limits
> > its utility.
> 
> It is a debug interface.

...but it isn't. It's an arbitrary write 64-bytes of zeros primitive.
Nothing gates that the location to be written was one that had poison
injected to it. 

> 'Changing the state of data without the
> coordination' yes, but isn't that coordination up to the user.

There's no way for the user to control that. Consider a block in a pmem
filesystem that is actively adding and removing blocks from files.
There's no mechanism for a user to coordinate that from the driver side.
It needs to be coordinated from the filesystem side.

> I get putting more protection in place, as in not allowing
> inject or clear of a DPA that is mapped. 

That solves most of the concern, and truly makes it a debug interface
since the user action cannot possibly confuse any other part of the
kernel when the DPA is not mapped.

> Do you expect, or fear, that users will 'trigger poison list', and
> then issue 'clears' of poisoned DPA's directly, instead of letting
> core-mm and filesystems to handle poison?

Yes. This policy is also carry over from pmem enabling where you see
that "ndctl clear-errors" is tearing down namespaces before issuing the
clear-error command.

> > Inside the kernel the expectation is that the core-mm or filesystems are
> > using facilities like movdir64b to atomically clear poison without
> > needing to hassle with a CXL mailbox.
> > 
> > This sysfs interface can move forward but it needs the idle checks and
> > locking before it can issue the command. I would also have an eye
> > towards skipping the mailbox call on architectures that have poison
> > clearing instruction like x86's movdir64b, because as the spec says:
> > "This provides the same functionality as the host directly writing new
> > data to the device", so just try to do that by default. However that can
> > be a follow-on optimization.
> 
> This (have an eye towards skipping ...) sounds like you do want
> users to be able to clear real poison using the sysfs interface,
> and for the the driver to be able to coordinate it upwards.

No, the reverse, that clearing poison from sysfs is a debug special case
because it cannot be done at runtime.

There are existing efforts to teach other parts of the kernel how to
better deal with poison memory in general (nothing specific to CXL) [1].
Correctable poison is a new concept for most of the kernel. Usually
memory_failure() is a one way trip to offline the page.

[1]: https://lore.kernel.org/all/20220603053738.1218681-7-ruansy.fnst@fujitsu.com/
