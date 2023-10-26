Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E91C2C4
	for <linux-cxl@vger.kernel.org>; Thu, 26 Oct 2023 05:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c75W8xBi"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5779CD6
	for <linux-cxl@vger.kernel.org>; Wed, 25 Oct 2023 22:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698297497; x=1729833497;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2/JuOZspEAZ3lX7jYi3t1Jg2dvTruoaRtlPGfd2a0rY=;
  b=c75W8xBiLkh2BRUc1/MzU7veOjYt3r2tHyf6pQIECd7UpwPQzyTxfU0k
   306Ogw6qMDzo0YGAedOKzfKvj/rBxqI/zDAEnBk0n2mbgeBmxZigsTPJd
   H8LzUIN5/IU2BhGLcXTkTNfCmoMH7KPA2SVH7vHx7tN+BE0reC68ODKGo
   SRyXh4+uq5uHIRKg4oBUUQEZ7gYVnq3YAmz7mnGBBtKm3FzFYBcEOx4mx
   Cj+ezCrgafOcGbVjNcEAhpQk8BVHs5ryE6CLWaLHUFO6pQFztWPwm/Mng
   kJ+KCQK+OEQx3tzpZuGW97s94x4WNYfX9C5E/1dCurEjhZ3uiLIGdUubL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="391331183"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="391331183"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 22:18:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="849791101"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="849791101"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 22:18:16 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 25 Oct 2023 22:18:15 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 25 Oct 2023 22:18:15 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 22:18:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWUr88lH5lu8UNYo+6tv4jCJjQcZ/wzt76vh0ltk36cD2GLK8Y0tz3Iqz8i3+A3IwqP6l0Z5THm+kr6CpP0vq5DyzW65EKmmr4ujf3XT/ZOQ0FnS3tyqLSl3jvOq5Hwgh9Xld2VtGAuUU17uXhQ+jB52SxKdp9iNr4dxpW5gXNDVPGtQOJNkk8PQoixu+4T5bkBybnpAfGkiT4vVyEgM3Y+4mf4gcb8HasAxn5yhvsiTPcLYiBpLalJIGn+tOXwO8RboqpqWhmGBLH2taUgJOuuLtuZdAlVBLUWnPVACZ8jUEDgRSdtlBoTrDZS6VYk1nHfXXqiXJ5m4QSsHVy4cOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/tTUR9Sfwnh2kxsT8QDJzQLDXf851BiyaV4I35EciYE=;
 b=n1/c/MjbrwE5HErzk+pPPVhkuRiWORFfLONyT4/N0eATtqpJzATiKsdCdImc4FmkJlX4uh2js+SbWOXcmpUQja4164D41l5A8A6gpmaC7KlsreU1VsVlKnymot4fS9X1us0JnYKXs05s44phWGksEX+YNWMSR0PXkub/mDyaoYkrmiStDnUD1eo5AWootDD7zTKUva/R0uTeQ5WNLtKti+D1P9yzZ1XhSwRykLLqPKa+63ZDOQuifzfc5Xy6D4YplwFpQXZUPkgCtprYxncEq9JKeUiTgZ9nogblNkDjYJwW33H9ComHi+eueGoQaLj9wMSGGqTvSXX9FEJC2YP78A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by MW4PR11MB5797.namprd11.prod.outlook.com (2603:10b6:303:184::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 05:18:08 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::e75f:ec47:9be1:e9e4%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 05:18:08 +0000
Date: Wed, 25 Oct 2023 22:18:05 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, <alison.schofield@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
CC: <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v4 2/3] cxl/region: Calculate a target position in a
 region interleave
Message-ID: <6539f68d9dc34_b8db294ac@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1698263080.git.alison.schofield@intel.com>
 <0ac32c75cf81dd8b86bf07d70ff139d33c2300bc.1698263080.git.alison.schofield@intel.com>
 <6539e07eab5a5_1894294b9@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6539e07eab5a5_1894294b9@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: MW4PR04CA0159.namprd04.prod.outlook.com
 (2603:10b6:303:85::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|MW4PR11MB5797:EE_
X-MS-Office365-Filtering-Correlation-Id: ca86120c-8ca3-4c13-5082-08dbd5e2f063
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rvfwyb9gB1T36EBTzBE2CXUSari1FF0/j3ZvbPK4BPo3sv75qUQdIUdmv3aEmS6LXbB9ZXHszs9B1reFZa62crFOj9rEnr9pGzHg0HQF5su7/xe2jnWpqljHV2sQinfYRScw+60WswnF01KwoNWgKo2QJuZ/CdvZiU7T/hGnLHVK/Eqelk2EF8f54UGIP6zP1Lult3ilUbKchl9xOS5U8R16YI8piVW5NkF7/KcKHgJCvSx2/RIv1vGDrGXBn41vTRdHSe3scFEsVRHtcFDi/QTNDWHeJyhEgi1cz/U8xiFIOiQ8vgwk8JlK6NoNdj78bQ0tUvki9cXiEG21v16YXpRRmWNsstZxF+2IrTv3WX7LYDtSC/xnP68+iaIE3VK/9fhYbzBL3WgOtTKvUwHHDgK0BzDb4TsUbySr9WjbO9jgAZ5XdnfnzWDVpejKf/LhDSsZMHq2hPPRIJXi4NGanuRi/6Fzl3H3ev+8xrZDajr2xMDGwYHCAHO8ldy/E5bymL8pO+k7bYIOytGzPYVD7wP5tWERBdvnmoRoOe1mAl2M8I7qGO1RBy2ptczIwagQ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(136003)(366004)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(2906002)(86362001)(41300700001)(38100700002)(6506007)(6636002)(316002)(66476007)(66556008)(66946007)(110136005)(478600001)(6666004)(82960400001)(6512007)(9686003)(6486002)(83380400001)(5660300002)(8676002)(4326008)(8936002)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k/mA69jWcM024m/vehYGfIi5uPUdtiDc/j0s8dMrwE5TDE/EV/A10OM1Rt/H?=
 =?us-ascii?Q?EHHJQfJRoE1GGClKTONnORFbCRJgxgQNwSnH1IWAgk8wOQoQF7qPUzqqdjVM?=
 =?us-ascii?Q?C7zjNe3uFnZAoFaAZ/RJAg196AIasiN7WmyUjlxxGSh0f2wIhbRGf6WsZ++V?=
 =?us-ascii?Q?d7uX0qdARsLppSHyBe5aHQjK/ZibRDkE7D5gcw/l4wexw1av2saliNA96DES?=
 =?us-ascii?Q?aJZc0mR4Gyb/AUQ3G4oBBrpX1upEM4phENptwZca87O3mexVM3C+mGa7WWbz?=
 =?us-ascii?Q?UtWzYiL1R9zGVEnzAPcjfEHcNejrAGcFsvbMCu25EWlhVBZV9u+dhsdvpETR?=
 =?us-ascii?Q?TnkFxGmhw1bUGGBnHPw/JGzhDOcAgPR+uPp//qKS/GsB5OfPrvl9zO9yywzj?=
 =?us-ascii?Q?fbg+A4ciVRtG9AS+cF/cpVnJ8eJbVd5fOJPovpmgMpY0Q/iXWuCsTHcKkekl?=
 =?us-ascii?Q?LFmAp0y/zuFRrxOdiSN7BCWyuRbHsvnmhfpnU0i2C7pP//q3ARABK80SmOC4?=
 =?us-ascii?Q?Jfo27+rUYGmbjXCf/etBKlnPPM2rf6WBzMln4wZTomehUwP6KZiE3+/uEpfc?=
 =?us-ascii?Q?NXb5VYPC+RgwtaWExuUw1qk5eSDXn/4fRL0nRzYaNO7uM76iAEmFItKjzGk2?=
 =?us-ascii?Q?5w5MTEPFRosw5MfvAjXI6pZGUFFOws3ykJDNhka5rnVRccX1cowdR/EkRqeU?=
 =?us-ascii?Q?zUwgP8wjmopq/OEFqNF303UrYrTTNE8Edv+lUoBqgIj7csVfx+FWpXa66rOM?=
 =?us-ascii?Q?Dd6VLsUHOvqkZSiWhyvKA9dbcewmx3P7PdcWYOrn8fIoNqdOe0XwBobt1IAu?=
 =?us-ascii?Q?Oeq5AkyKp2+DhrrGNXDKdapD+ijCnHj44BNs29Qhf7W5o+QxX7LqQghZcMPP?=
 =?us-ascii?Q?zhWQR6DQ1/nPUHPXPwVruwmzHIO92ENXuPM4d2+T89fF+t0LNaJb3GTDcKO3?=
 =?us-ascii?Q?8gPA0DQSxgCWDu+S9TET+jyddubSaE2XgLADqZ+0YvXX2kMIpnNd7rGXvR/4?=
 =?us-ascii?Q?zsuvqRUg6fVwommvARZk+RsCrqWaz+gH9fHSIe+x8HlUzLIpjINndm1iD/Hj?=
 =?us-ascii?Q?k7NRthoN12R0h0lttyvf0OfgJc/ugmrXuzjn9MEeJ6p2qUP3gB0UaHFHymVN?=
 =?us-ascii?Q?7A/9DQ59VRdpZ5v7KAHqLkmyCUjgxUEJ9373mwiyNLQjqzU2CBjS0jQ8QDkW?=
 =?us-ascii?Q?JMXVMQfAI4c1PZ0vMue97Sf7o1z/MAOPAVd5TlB9ptRgNptPJZ/fNVXAwQ2S?=
 =?us-ascii?Q?82MCRYvMDH5qjIYVIVa6fZkeGnSlm/4EanYdh5TxL/ozyi5Q0t8gaPWsuJ4O?=
 =?us-ascii?Q?omzsAbq9BhAmskjW64kZun/vBhuWrblwcIzj92AgQ2BaL6p7pePT4i6GNct8?=
 =?us-ascii?Q?M29/J6/iLC539QqbJ0PgvXjFW0hmfgMgUtvHwyQwbBoUBzEN9WzfTFmtvZec?=
 =?us-ascii?Q?Mi5Vji+/Zd6vpoY6o7sX0rKYE8r7YbSyr5G0tIZcFBY/E7lz95pL2blqiX1F?=
 =?us-ascii?Q?DQoY2j7GAZEIYXhcM0YgOGu9S8JapkA/qsYoB0ibVrh6uY/F5Z3obME0bENc?=
 =?us-ascii?Q?Dq7ntsm7JMyLJ2vbEWmQdYLGGKdK0HnE/M+z6EviZLqSJH8B+XexHXcd6ekm?=
 =?us-ascii?Q?Bw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ca86120c-8ca3-4c13-5082-08dbd5e2f063
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 05:18:07.7448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u6Pmmb7dSN7VOiWy+tONVzaiidV9xxowXZvNuG1CliY71K4aOr+CYPffhZxcJvVMUVCQ5MCgvkQbpRsXxY2UxIigxYmU+vm1cAHpLrh3dxg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5797
X-OriginatorOrg: intel.com

Dan Williams wrote:
> alison.schofield@ wrote:
> > From: Alison Schofield <alison.schofield@intel.com>
> > 
> > Introduce a calculation to find a target's position in a region
> > interleave. Perform a self-test of the calculation on user-defined
> > regions.
> > 
> > The region driver uses the kernel sort() function to put region
> > targets in relative order. Positions are assigned based on each
> > target's index in that sorted list. That relative sort doesn't
> > consider the offset of a port into its parent port which causes
> > some auto-discovered regions to fail creation. In one failure case,
> > a 2 + 2 config (2 host bridges each with 2 endpoints), the sort
> > puts all the targets of one port ahead of another port when they
> > were expected to be interleaved.
> > 
> > In preparation for repairing the autodiscovery region assembly,
> > introduce a new method for discovering a target position in the
> > region interleave.
> > 
> > cxl_calc_interleave_pos() adds a method to find the target position by
> > ascending from an endpoint to a root decoder. The calculation starts
> > with the endpoint's local position and position in the parent port. It
> > traverses towards the root decoder and examines both position and ways
> > in order to allow the position to be refined all the way to the root
> > decoder.
> > 
> > This calculation: position = position * parent_ways + parent_pos;
> > applied iteratively yields the correct position.
> > 
> > Include a self-test that exercises this new position calculation against
> > every successfully configured user-defined region.
> > 
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> [..]
> > +/**
> > + * cxl_calc_interleave_pos() - calculate an endpoint position in a region
> > + * @cxled: the endpoint decoder
> > + *
> > + * The endpoint position is calculated by traversing from the endpoint to
> > + * the root decoder and iteratively applying this calculation:
> > + *	position = position * parent_ways + parent_pos;
> > + *
> > + * For example, the expected interleave order of the 4-way region shown
> > + * below is: mem0, mem2, mem1, mem3
> > + *
> > + *		  root_port
> > + *                 /      \
> > + *      host_bridge_0    host_bridge_1
> > + *        |    |           |    |
> > + *       mem0 mem1        mem2 mem3
> > + *
> > + * In the example the calculator will iterate twice. The first iteration
> > + * uses the mem position in the host-bridge and the ways of the host-
> > + * bridge to generate the first, or local, position. The second iteration
> > + * uses the host-bridge position in the root_port and the ways of the
> > + * root_port to refine the position.
> > + *
> > + * A trace of the calculation per endpoint looks like this:
> > + * mem0:	pos = 0 * 2 + 0		mem2:	pos = 0 * 2 + 0
> > + *		pos = 0 * 2 + 0			pos = 0 * 2 + 1
> > + *		pos: 0				pos: 1
> > + *
> > + * mem1:	pos = 0 * 2 + 1		mem3:	pos = 0 * 2 + 1
> > + *		pos = 1 * 2 + 0			pos = 1 * 2 + 1
> > + *		pos: 2				pos = 3
> > + *
> > + * Note that while this example is simple, the method applies to more
> > + * complex topologies, including those with switches.
> > + *
> > + * Return: position >= 0 on success
> > + *	   -ENXIO on failure
> > + */
> > +
> > +static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
> > +{
> 
> This needed a minor fixup for the RCD case, since RCDs are directly
> integrated into the CXL-root with no intervening ports. I went ahead and
> rolled this hunk:

Nope, that hunk was broken and did not fix the issue, but the below
does. The reason this was triggering on the RCH region test was due to
the fact that cxl_test defines a sub-window size region to
auto-assemble.

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index dbaea89dfa4d..6f8a50bf6201 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1500,6 +1500,8 @@ static int match_switch_decoder_by_range(struct device *dev, void *data)
 	cxlsd = to_cxl_switch_decoder(dev);
 	r1 = &cxlsd->cxld.hpa_range;
 
+	if (is_root_decoder(dev))
+		return range_contains(r1, r2);
 	return (r1->start == r2->start && r1->end == r2->end);
 }


I'll fold this into patch1. The root-decoders are a super-set of
switch-decoders and the range they cover is a super-set of the region
range.

The failure mode could intermittently trigger a crash which I need to
debug, but I am fairly certain it was due to causing auto-assembly to
fail in an awkward place:

 general protection fault, probably for non-canonical address 0x5a5a5a5a5a5a5ab2: 0000 [#1] PREEMPT SMP PTI
 CPU: 23 PID: 1468 Comm: cxl Tainted: G           OE    N 6.6.0-rc3+ #1120
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS edk2-20230524-3.fc38 05/24/2023
 RIP: 0010:to_cxl_port+0x8/0x60 [cxl_core]
 Call Trace:
  <TASK>
  ? die_addr+0x32/0x80
  ? exc_general_protection+0x19b/0x450
  ? asm_exc_general_protection+0x22/0x30
  ? to_cxl_port+0x8/0x60 [cxl_core]
  cxl_region_detach+0x19/0x210 [cxl_core]
  detach_target.part.0+0x29/0x80 [cxl_core]
  unregister_region+0x42/0x70 [cxl_core]
  devres_release_all+0xb8/0x110
  device_unbind_cleanup+0xe/0x70
  device_release_driver_internal+0x1d2/0x210
  unbind_store+0x9d/0xb0
