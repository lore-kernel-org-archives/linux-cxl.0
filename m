Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6D1C77B6E
	for <linux-cxl@archiver.kernel.org>; Wed, 12 Apr 2023 05:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjDLFSv (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 12 Apr 2023 01:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjDLFSt (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 12 Apr 2023 01:18:49 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A131E422F
        for <linux-cxl@vger.kernel.org>; Tue, 11 Apr 2023 22:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681276728; x=1712812728;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Kl5k3cDOojyLCzyKuVZnjkLmumd3yZdHTf5quNBY+mo=;
  b=KNXVX/6poRqb0Aw3oMGLVRqPUjm1yy71nZWnHv4Sj5jZSrvhvpea0GwK
   n1tj8+rSoG75DSJuFwsg1RMIBuRZrk7F/Ty8E1bFAZotQLy2x2CHYx5ah
   vbTOqvLB4WdKDGqTbTlScEl63UliYnzSzul+KpQlDa5EQKG3CBjFUEpZV
   OZmjDQNSNzNfSsWEtOmtyQ2pdcB0hY7snZfXZmJd6vjUOGKNIjYHdJYUk
   UWGClanN2UBa+42O7cdeusnMhdzUgIE9O2xm291NvzeUD1LYj01bPMv3G
   e9qh0ULg8qn9C8h+u1mVG0qfAa1aUpdrQyU+yWKWr9wLPUbw+q6uVywhL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="332496445"
X-IronPort-AV: E=Sophos;i="5.98,338,1673942400"; 
   d="scan'208";a="332496445"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2023 22:18:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10677"; a="753387204"
X-IronPort-AV: E=Sophos;i="5.98,338,1673942400"; 
   d="scan'208";a="753387204"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga008.fm.intel.com with ESMTP; 11 Apr 2023 22:18:47 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 11 Apr 2023 22:18:47 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 11 Apr 2023 22:18:47 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 11 Apr 2023 22:18:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kmad0XSw6rAQzB5J9abP8MOHcMRO4eV20dvqgV0385dgUlAUMRV84hQ6U254cneVs8E32n/PL0ss928MFYYx+FYOzPXaEAhQi9ikIAS42rsgrOC7ckJLfE6YUGT36fPvbmDGtLFxrG2BFofrNc+56lfQuW++pkrCJCY+pCtXAMUFIALSIPOT7GVa3+xpQIgPpbFQFSvAPZ9+puHfnGBD59qQnz7soOil/YpZE5gWjYpses+Dnsiitc0MCstXHgiDIZ69AV6wtia3rOd0hF1eDE9NeBM96mwgtvehQKfn89yGjUF+bePeU7VzQ1l4aYbxCFxghNpZwR/OwoaJHVn/TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQUfisZb5OfjBeulp2Juua6D3BWIPM4PRux9vRNTTYE=;
 b=NbyDj9Yaw61Wanckq4e4XIrCvCPk0UnYCfW2GkWt85Izmrln/2PoqpLyKl+kHqKZvNfkyoQMJKulKEbKEJ7SHC8QdVitPqEK4lyTFOiVWDallpudW9DdOq44vBTaIxcJDUxJjwuJL5Q8APDW3JBzyYil9ZUN7ShfTicTTcrusTCaoR9ivcdvkNZRhs5WscmOKsWZz4P0dnjhuS8rPLtteC+ZY+ZsveiYMQWwbwpcD86Y2MTes5NFkuS017NWXNl5xTQ7GeB19IKm40lAsm7TDRfM9/11LYKZac6eJJd6O/i0t7b4l59HcNwyWI7gcAYWfrp5QaNxGES4YP9JlwDrqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB7264.namprd11.prod.outlook.com (2603:10b6:8:13b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6277.35; Wed, 12 Apr
 2023 05:18:43 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::ffa1:410b:20b3:6233%5]) with mapi id 15.20.6277.035; Wed, 12 Apr 2023
 05:18:43 +0000
Date:   Tue, 11 Apr 2023 22:18:40 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        <linux-cxl@vger.kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v12 1/6] cxl/mbox: Add GET_POISON_LIST mailbox command
Message-ID: <64363f30a6370_417e294d0@dwillia2-xfh.jf.intel.com.notmuch>
References: <cover.1681159309.git.alison.schofield@intel.com>
 <e87e1792e147a46f348019cc772e06f2ea19e970.1681159309.git.alison.schofield@intel.com>
 <64360dcc59cb0_417e294de@dwillia2-xfh.jf.intel.com.notmuch>
 <ZDY3dR0vA6+zihxN@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZDY3dR0vA6+zihxN@aschofie-mobl2>
X-ClientProxiedBy: BY5PR20CA0034.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::47) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB7264:EE_
X-MS-Office365-Filtering-Correlation-Id: 241435c1-2c14-4ab5-8f33-08db3b156214
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xM0hWbbGRMY7YyoMZ3h2Br0UhSxG/ofILlfS/RVA/qDXKoMF6z0BaI+yr9UVR7s9wm0AuXSuplSMbvGTC2mx7chDH0hjPRB+Og6z0IXgV6cOz4v/IQv0Ti5gy34hpTeNPpT/NYPsMaRHgHbXmRY001Z2rCdm7nHfpasEVx3ebm1plb8r7ZjcP4oMMrAm6XbuvBldAbKf3Cvi01HZcigOdtbq7m+g9DlWp22ieC3mPB36vCuZiA58H7PS9lvv5FAAS/RggiycV7zQ3/PXB5DDiM1KbpTPRlljOu/impdpjb+Ve96ixUpjyQZRwrdY02r50f7ry7ayOLUjjK6Ubs/kwhYUJQOfbzKlN205JhmZRhnnAwe1vICzdgjA7CR66yMxVKPcs5IB/bvPx62ccuWOeZrWCTI9EFfjEO8LOUcTYLB9rw0glq3dy3nWLa+RyNcagjdh1zUMN2L6MhELo409RBWeo1fLqOaFSCj57a8THit6XoVGuvZb8pl+Y910Ji+2XIXxFUZeUzRicYIq30vm4SjDA6Qzmamr9vUHg1gyd3s=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(39860400002)(366004)(346002)(396003)(451199021)(6486002)(4326008)(478600001)(66556008)(66946007)(66476007)(966005)(8676002)(41300700001)(316002)(110136005)(83380400001)(54906003)(86362001)(26005)(6512007)(6506007)(9686003)(15650500001)(8936002)(5660300002)(82960400001)(2906002)(186003)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rObshpFmIjgpYmeojDISSooDK29Wqrh5amgL0SZDojdRMDkRR5c1ZIQQUAdq?=
 =?us-ascii?Q?gAx1HQnIph020SkxTGay4wN15gsITHm7+F18CmaMxS7Ft5k7/N+USFpz/Hau?=
 =?us-ascii?Q?CsF9R6XVj9aVWIAfHG3H4mptDRZ/yKM5z4ol2u83DfsXb5qcoX18jbTGA3HV?=
 =?us-ascii?Q?4PmtdmjEfJPBtR7PRzZio83j34mPxuVcSgxqAbTRMU3YNiqgk27sjneOGjHB?=
 =?us-ascii?Q?lFvwop9YvTCahR3TajMEx/0hFzIAy2XD7cAmHaOdOox0uNxLpZbbPQDwS3kx?=
 =?us-ascii?Q?JYianob0CjOAmEJt5JxeOtifcrFQbjESeT65EirK29zxSjrlGyJBQA2sVNBC?=
 =?us-ascii?Q?fMX93wtyZIjB2VW898RenwYXzfSg4Bickiub/lk6tqmrImnMyUgt9jOZmW3Q?=
 =?us-ascii?Q?Bd6scrOinLTO19+T4/Do+lsNTryCTbZEIWMWSlaGseHRTOmhVEFL7Qcb863m?=
 =?us-ascii?Q?RLUQRQB+5ZdDU+GQb5mn5QtLhbC9ulRp2RTYOb9kob+p6reNU7GIoHr8EP5X?=
 =?us-ascii?Q?VprKnXdkeuhi+7YW7DkJVqdEGjcMFi6BQ/a1KC6anf0PSCekINWCRiXugmQM?=
 =?us-ascii?Q?s10R3HsC72S4gUPVDVDUSyMrB+IudQUPMk1Lwg12yauiAuFG2qTswbm9FLVy?=
 =?us-ascii?Q?VAdJSESIyciooDP9pYAiTtve4y1U+iGXlUYJ128C3YobZxSCVwoDkkpKSzKN?=
 =?us-ascii?Q?TMwasZ6gg/DNeR1XPyxumj9lPbRvJ+w0BZxyTB6zvnRamZ815k7WW9Z4v0/9?=
 =?us-ascii?Q?jSR5VeQwz53+55JxTVTOX0yy+Vu5sg8sxcWFNq+2uit6CENzTbdp1xHgNHMG?=
 =?us-ascii?Q?wblUeBcB16vfeMvzf1IkLV2NN0zGrXnCur0tARy0L8RS+7ybklHIfT+VZCm5?=
 =?us-ascii?Q?g4lIfQt8AzsvB0JY4GCyWnTdYI4PbcJTSVSJS4OM/Z8fPykin+I/5JVH0tp1?=
 =?us-ascii?Q?V1OtjbE9MIHfd5oe6FEET9oFuh71IVkbpmaUYqoqeDL2EL9NZBWODeG10ysI?=
 =?us-ascii?Q?VMs+lDV+dfuN1VfEg46mRMJSwAPRtOqqycJgpHvJUKs0YZQ8UBAaisCRR7Yt?=
 =?us-ascii?Q?Rqk/qP1PaDzl/WqkCgOr6RaTnClxlAORjcVskLEO+9Ks2zY/9Srf3SZ+/2wC?=
 =?us-ascii?Q?Urbb661AmEW9PY/OGSMV3JE66qbkahTH3/fHn8JUxCQuPV3+53T9ul1oEpOr?=
 =?us-ascii?Q?28m4Vv/0cqW2rbArhlKKSIQ1djsoMbYhKk67c7aMU8GAL0reGAPGFQCi1ehV?=
 =?us-ascii?Q?SAf0uKqgWVwNspbsJKeDBCw9S1lEJxq+4i4siTK41q5RtEs1dmevCF98pZDc?=
 =?us-ascii?Q?dHhoVSkq3TIkuxbvb1LzKCyqrDuCyOW81pfvtCCAVTkFmP7y7aBSpJmNb80A?=
 =?us-ascii?Q?KWa/SwaHWvnuxH07AsuGT0XMqF8TsvkxbBs1A1DCcH2iYOaudOh6IcXgB4Sw?=
 =?us-ascii?Q?rNriAkFlgYyiI+T51Bn7TMO8SxD/2xuVwgdxmFQ/hUVSxliSUcUxSmppXP4T?=
 =?us-ascii?Q?5a9MZ+DUtPEI2RmNZjnhcoqfD4al18eK94mroZvOjbQK6eGzrhamZoyN9liz?=
 =?us-ascii?Q?63Pj9MxVTggTJUsexQoJdlJU++6oX7Ws7nzeZTHO5LKwU86X0TZZY4xmjODB?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 241435c1-2c14-4ab5-8f33-08db3b156214
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2023 05:18:43.0817
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OEQ/98PP+KBvUo+4yagTxnHb0l1SGShCRSR/0NqlCEBAEeBk39Q1T1Y5iWWpxMQhQ+s8eb03OSdMhr1ASou2GHuxd4RKaJISUjeX4+d+7dI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7264
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Alison Schofield wrote:
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
> 
> In the inject & clear series, I made the commands kernel exclusive (and
> also blocked their usage in raw mode).
> 
> https://lore.kernel.org/linux-cxl/1576040e-e8db-bc78-2fa3-622c8f7da8ec@intel.com/T/#m5b86f3e88ee7ad5b92843babdb9fd41b7f03cf36
> 
> Is that not enough or not the right protection?

I think I'm having deja vu and maybe we talked about this already and I
forgot the outcome?

The concern is having a consistent approach across the commands that are
valid from userspace all the time, those that are valid sometimes
(temporarily marked exclusive), and those that are unsupported from
userspace (unsupported via raw command being a special case of that).

For recent new mailbox functionality like CXL_MBOX_OP_GET_EVENT_RECORD
and the DCD commands, that are only expected to be executed from the
kernel, those are kept out of the CXL_CMDS list, not marked exclusive.

The commands marked exclusive like the label commands return EBUSY, but
only while libnvdimm owns the label area. If libnvdimm is disconnected
(echo pmemX > /sys/bus/cxl/drivers/cxl_pmem/unbind), then those commands
stop being exclusive.

So, I think I want to keep "exclusive" as a set of commands that are
suitable to build into a user tool just that the tool needs to know the
rules about when those commands might be busy.

For poison the user tool is expected to use sysfs + trace-events, so
including it in the list of available commands returned by
CXL_MEM_QUERY_COMMANDS only to never be able to execute it seems wrong.

Marking it deprecated as a "whoops" feels more honest and brings it in
line with the other commands that are permanently kernel exclusive.
