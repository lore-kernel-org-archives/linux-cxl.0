Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A793C77B76
	for <linux-cxl@archiver.kernel.org>; Mon, 17 Apr 2023 19:39:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjDQTji (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 17 Apr 2023 15:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbjDQTjd (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 17 Apr 2023 15:39:33 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E612572A5
        for <linux-cxl@vger.kernel.org>; Mon, 17 Apr 2023 12:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681760364; x=1713296364;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=uQ2REYuK1dwcWzMRwv3VSMYvDMMc765EMWDik6SjXB4=;
  b=KWIiRAIIyizA7+KOsauINtGb4HqBJ7mvpEZ7bEsFbE4EWUpBd5Ul1xL3
   VDwkfnA+jEpIZ8rccqFuuvn7CfO6QVtO3w7KpUs69+2fzQGT2TyexWIwi
   oUnjRYLhW35BEjlVjmfGQXh6zbrpFA4fJW9gyYSTsGuzGtmM4g0qttn68
   6Qzw7guRDEEZd4Nnbz9Qr9dSjSXzQd03GvkPdB19a/gYzmAS018S0GOXv
   Pw+oF3zx9ZPgYLkOEDbkD4+bxYDdcQs/SUwlo3ExvkkatsNPeSc/Q+rpf
   vKsKpjDxi+RMe/y1oOEdicSVG+11bv9ms5wBiLfsH544PkAGlYZa0p3bU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="333790569"
X-IronPort-AV: E=Sophos;i="5.99,204,1677571200"; 
   d="scan'208";a="333790569"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 12:39:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="693335504"
X-IronPort-AV: E=Sophos;i="5.99,204,1677571200"; 
   d="scan'208";a="693335504"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP; 17 Apr 2023 12:39:17 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 17 Apr 2023 12:39:16 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 17 Apr 2023 12:39:16 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.45) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 17 Apr 2023 12:39:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MeDl5mEWUknnW3jwWXA5xq4twtgdyqhg9ZLXsasrAmwkp7AXTxxcAOk7VAmXHCYlTn4hCZE+YDZk/HaS/2yDH0nXi0y+xbWNrELkc/yvrfA/1I4aiGMaw/2dzix8T1fUcUzOBnySmmrphCqk3Yc5hYuMWF31pJ58JPhOqxGdEzb2+5O3Hv10ehhKl5iAlZOMes4C3I215kSjaFirJtbxN8yCvW4JoXgereypIfSsX27K2s5RtlSS59zb06rr32PC6wFZqPy19DzWV8XuV0S6f3IvIWnm1WgO123Ib0JhJ3tu/700KmoFb1VB6TPSVCGUCmU9TGnyquANMbjyEnLx+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXuqpm9BnFsXiAcGA5Up49l379kJP4sAl9nLOYXVOOU=;
 b=j6wri1oqckEiNCn1bdaCx+wkUZRM2+aXIz2EZp9r2LL67kN04xOxMVuOUehBJxmWXcMW5JyskDbvcENAek6yXn0E6YALelcGOvHVLWrywRPMQMwrHgjBXN0mU28uKiTQvOosZphYGhnI4Lp1iig5qg0n0uNxTVeg/xFd+UsyG6m3aoERGyq2x9F+OVOyLdYf7umbzg1z+fXgpi+0e+KxDhnY2ydc/fM3lYix8UwV3hO9XD3+c2w68hoQzoPrLDBiEX3rC3Uw6tRbb2MHswkj+dVq/BQ1hUqfbHb7zaKF8OGA4aAZ8nHPWkXHGS72CZ2WqVZsVcwnYE6st8nlwOByBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH7PR11MB8034.namprd11.prod.outlook.com (2603:10b6:510:247::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Mon, 17 Apr
 2023 19:39:09 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%6]) with mapi id 15.20.6298.045; Mon, 17 Apr 2023
 19:39:09 +0000
Date:   Mon, 17 Apr 2023 12:39:07 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
CC:     Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        <linux-cxl@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v12 1/6] cxl/mbox: Add GET_POISON_LIST mailbox command
Message-ID: <643da05aed721_1b66294ef@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1681159309.git.alison.schofield@intel.com>
 <e87e1792e147a46f348019cc772e06f2ea19e970.1681159309.git.alison.schofield@intel.com>
 <64360dcc59cb0_417e294de@dwillia2-xfh.jf.intel.com.notmuch>
 <ZD10hpfDnXaatUOE@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZD10hpfDnXaatUOE@aschofie-mobl2>
X-ClientProxiedBy: SJ0PR03CA0271.namprd03.prod.outlook.com
 (2603:10b6:a03:39e::6) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH7PR11MB8034:EE_
X-MS-Office365-Filtering-Correlation-Id: b2bc1978-863f-4170-5c27-08db3f7b69ef
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OMoPbMuzDQCkMQBHkFvs4RXXDLfVFlLahpyoLoPPHjAkJIYJoDqolPf56KNO0xcHFEn6/5bgHk/3mKKt4ufLA1WFR5SFFJqEi5442KEpulkQYwQJYzDSzV8BNtjvEFxm1rSUQUK3FHoQv6ehWuuPagryFQ/AlmrAV5a4ZNRz+m68PZK1DZx+sN7A0Q/yZ1r+8ns3zyV94Ra6UcWgfOzk93ksT3BAYU2dACx7WTyo87fnfz4xDTxgteYgyRTurbm1BP5vSwq8ruUQ4k4V+MsnMau2RiSnWlA2PbUaZGGA743Y+dKH3QNAXemLGv3N5EHYCRbMepdTt5Opt1p09sL1qBW5sg1vprG6uJWS01TWGuoDTe63pUq4ewu1kVvKPtyxAn0uGh3PANGqge0GtqSilPCRcPgMy8emLxtNZWknNWTy/DOWahmp1Nb6HFTVzfOqp0vqF/0CyAJkHWvwRZuk1VnmgJ0r3XbgaqkwAzj6sFme6a0q+Ow9WsVBxMjHON8OGCTUZxQOGc3ItP5Yc+PK6v2mzb6P6yEB0taRUdaYQNuWvjltDvOZ4aRogDXHwiZL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(396003)(376002)(346002)(366004)(451199021)(2906002)(86362001)(41300700001)(8676002)(8936002)(66946007)(66476007)(4326008)(66556008)(5660300002)(110136005)(316002)(6636002)(54906003)(82960400001)(478600001)(38100700002)(6486002)(53546011)(26005)(186003)(6506007)(6512007)(9686003)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?p7GR3J/2pG3IQupHDK3aT3f1xnFsQZThIjpilvyPE7HBmYBq/c/Ge4f4G/QY?=
 =?us-ascii?Q?1ixkkgvSJ2TZ8bw47oVzpn4fQ+72/IswU3gLplDwHlKlTrTYDfkHpT2UoCmy?=
 =?us-ascii?Q?W/K02gopNsthwAgIWaZfBCIKMbI+ehI2sPabxQpYCAu3ZAKaoLTfEenLmyTz?=
 =?us-ascii?Q?Coxf31Vup8HUxVfFxarLPPlDG54esh9URZpqquS7M19DZ2Ygfo7CkbH8FQ5D?=
 =?us-ascii?Q?Hn2Hi75b0PnBlrAvdcsYM5IRNW35OmT/KsQqua6d15kMn/JE3KX2Mwyzs+GP?=
 =?us-ascii?Q?E5/GcOidmNZONy+JKlDzeSfJYu3wHSiaotWBvLwOMpHWMk9HXq1AC0FnlgeQ?=
 =?us-ascii?Q?lDVAaCtG4BTVT6zsI63qBvgWXmXt8SD4ixynYD/9LXbYiiM4zNjIk+HjHMbF?=
 =?us-ascii?Q?Lx534SuWOtWxvvB+6WStTE0pfl7xFNwSo5Zea5yW1+E8Pyt7WhN48raFAlm/?=
 =?us-ascii?Q?VsOK84piw+NnotYhrkQAlG40ZWBCTfdqfE8BBMqeMZakEVp39HRFaCxTBLh9?=
 =?us-ascii?Q?LABAjcWDv1nP3IRcMtntCkXKC4meOGnIH+L1tCtGRzlJXgQWwBX+DFnOvofP?=
 =?us-ascii?Q?jzG+VhOsOghQd54Xung1a5o/HZwoXXNRKj3aNknTtKK/wXvg2xI3UHeiYBGj?=
 =?us-ascii?Q?7JTkqJtA5uVgdvHeFqPMmijInsaknEMaU3gBfR99jxa+/glRxIa0eewnUE9G?=
 =?us-ascii?Q?czYIi1XGUdpQd6XKM5/IUG33eDNEG4qMCqYJwmnEGpscGz32SYyOLQT2iTPa?=
 =?us-ascii?Q?t3gUfX3faR6czvnjzkKjc1VwQa2tezz7CodBNjonDVh41WjqSuvfRAQJKU7G?=
 =?us-ascii?Q?T9MtUQe667q5DJeQGQ5vBJeMBCB+UI0ewv9ZPfWMMMXdBR3E9q3JVGWqNllb?=
 =?us-ascii?Q?ZJ65ujefd6IzZL8wZIjZ5hG0fOqOV+v1q2wsgoO4AjQrOk4QJ7yoYhoDBNSd?=
 =?us-ascii?Q?iEBVeaLdKB9FwNh8ZWZCM5SMZ+uVJopShWPbdi58QpkEbmAMKqbp9hWDLm8z?=
 =?us-ascii?Q?F1UkiMzdMK2IzSNgVrDjmK/er1ZsXO3osKxERqDii58ROOxcGofgGzUVeKMT?=
 =?us-ascii?Q?4pJifBrhGsm3sqRq+vDK4SH2YGmX50DFQTSiruy0zGhxoedqh9pLZaS/B4oN?=
 =?us-ascii?Q?mPXpbscZ803gOjAWKjGQ3AGyIREASIyDYznTB4oJ/R0EMBNS6i7Gj/Ok7zbV?=
 =?us-ascii?Q?dRN7SmsrnzkShBTAFaOLfXKJ0VGb9ujcmAum5AwWiOUMkB3uX7l/DsB5ENpe?=
 =?us-ascii?Q?eUp7Vv1bLExREKPYe8cZoXqjwIxDshuwSbSkrBzntEEpkPcmDLCO3nvQBqW7?=
 =?us-ascii?Q?yzWEGqvs4ws+KGrcpf6AKuNdfDE08Xp4WBAmXetufQxjUTsQgvJF676K0Jsj?=
 =?us-ascii?Q?hIN5UTpakMeeGo35ZFrsP5XSseGMp3edKH3CPx4BTncu6+jR/e0C0jsKsHfd?=
 =?us-ascii?Q?0CYbiIZGXYnNZCrMmC8hNG2W87NKpQCm9OvSjuCP3PgicLLeKBAoT4rzVudT?=
 =?us-ascii?Q?UkYNmWOxwafoOgLfI8VeZzcPNqJcOogb9j6i7ssOEYi/dtHNpCoQb7nJqUjQ?=
 =?us-ascii?Q?tiDQIXwlHqjD+qghaS4e9NYHmINI09aOsm6TOyeyFp3jqiOcJdKLtlyXI/fb?=
 =?us-ascii?Q?DQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b2bc1978-863f-4170-5c27-08db3f7b69ef
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2023 19:39:09.5905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w2cabcS+X0b7aEHAb7VaeMIYkpjPnbU0q+df2DXnIjHQdUWveMoSUci2hMDooa6tXLZkPBKk6/WHRQVuv6RNjszlOVkNDvqljZD7RgoDa/s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8034
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Alison Schofield wrote:
> 
> Dan, Vishal,
> 
> Following up on using the new deprecated list ...
> 
> On Tue, Apr 11, 2023 at 06:47:56PM -0700, Dan Williams wrote:
> > alison.schofield@ wrote:
> > > From: Alison Schofield <alison.schofield@intel.com>
> > > 
> > > CXL devices maintain a list of locations that are poisoned or result
> > > in poison if the addresses are accessed by the host.
> > > 
> > > Per the spec, (CXL 3.0 8.2.9.8.4.1), the device returns this Poison
> > > list as a set of Media Error Records that include the source of the
> > > error, the starting device physical address, and length. The length is
> > > the number of adjacent DPAs in the record and is in units of 64 bytes.
> > > 
> > > Retrieve the poison list.
> > > 
> > > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > > ---
> > >  drivers/cxl/core/mbox.c | 71 +++++++++++++++++++++++++++++++++++++++++
> > >  drivers/cxl/cxlmem.h    | 67 ++++++++++++++++++++++++++++++++++++++
> > >  drivers/cxl/pci.c       |  4 +++
> > >  3 files changed, 142 insertions(+)
> > > 
> > > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > > index f2addb457172..69a5d69dd53b 100644
> > > --- a/drivers/cxl/core/mbox.c
> > > +++ b/drivers/cxl/core/mbox.c
> > > @@ -5,6 +5,8 @@
> > >  #include <linux/debugfs.h>
> > >  #include <linux/ktime.h>
> > >  #include <linux/mutex.h>
> > > +#include <asm/unaligned.h>
> > > +#include <cxlpci.h>
> > >  #include <cxlmem.h>
> > >  #include <cxl.h>
> > >  
> > > @@ -994,6 +996,7 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
> > >  	/* See CXL 2.0 Table 175 Identify Memory Device Output Payload */
> > >  	struct cxl_mbox_identify id;
> > >  	struct cxl_mbox_cmd mbox_cmd;
> > > +	u32 val;
> > >  	int rc;
> > >  
> > >  	mbox_cmd = (struct cxl_mbox_cmd) {
> > > @@ -1017,6 +1020,11 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
> > >  	cxlds->lsa_size = le32_to_cpu(id.lsa_size);
> > >  	memcpy(cxlds->firmware_version, id.fw_revision, sizeof(id.fw_revision));
> > >  
> > > +	if (test_bit(CXL_MEM_COMMAND_ID_GET_POISON, cxlds->enabled_cmds)) {
> > > +		val = get_unaligned_le24(id.poison_list_max_mer);
> > > +		cxlds->poison.max_errors = min_t(u32, val, CXL_POISON_LIST_MAX);
> > > +	}
> > > +
> > 
> > With this new interface I do not expect we want to support user tooling
> > that wants to retrieve the list via ioctl. So I think this wants a
> > lead-in patch that deprecates the poison command support so that the
> > linux-cxl community only has one mechanism to maintain going forward.
> > 
> > Something like the below as a lead-in, and then you would add code to
> > cxl_walk_cel() to set a flag for the "get poison" machinery.
> > 
> > -- >8 --
> > From f2cd1d1e09fe6f36255f3b8cd831b2b4903045d4 Mon Sep 17 00:00:00 2001
> > From: Dan Williams <dan.j.williams@intel.com>
> > Date: Tue, 11 Apr 2023 17:48:45 -0700
> > Subject: [PATCH] cxl/mbox: Deprecate poison commands
> > 
> > The CXL subsystem is adding a formal mechanism for retrieving the poison
> > list. Minimize the maintenance burden going forward, and maximize the
> > investment in common tooling by deprecating direct user access to issue
> > this command outside of CXL_MEM_RAW_COMMANDS debug scenarios.
> > 
> > A new cxl_deprecated_commands[] list is created for querying which
> > command ids defined in previous kernels are now deprecated.
> 
> Dan, Vishal,
> 
> With the driver no longer returning these commands in the
> cxl_mem_commands[] list, they will appear as -EOPNOTSUPP in
> the ndctl:libcxl cxl_query().
> 
> Is there something else we need to do to actually show these
> cmds as deprecated? Something like query the deprecated list
> and add a new status to cxl_query(). 

No, because any software written before the deprecation does not know to
look to see if they are deprecated, and software written afterwards can
read the latest header file. So an EOPNOTSUPP return is all that is
needed.

> At the moment, my goal is to do what is needed in the driver
> now, and pick up any accompanying libcxl changes after the
> driver changes are merged. A bit worried I'm leaving something
> undone in driver today.

As long as there are users with new needs the driver will always have
undone corner cases. I think this series is in good shape.
