Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F8B32E12E
	for <linux-cxl@vger.kernel.org>; Wed,  8 Jul 2026 02:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783476560; cv=fail; b=oUM2LIDqM2xptB1RCRx/ZtaDJgTxAehGyCNzj1g0Ztxk3/4ZQdZazWbLsuXKTHc056HELoKeus7Ck9+eNYUlAQMM+Wz+cfyELcusb/1jNLc3QoYEJZQ54TXV2z8A5yjSWLJMUCMueFXTXrcAZxH8Cyw1rMQqnpVeDH91kW3p52E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783476560; c=relaxed/simple;
	bh=eW1Zr+uACNeX1Q75PbzV0E44tVUMA29iJ/f05+8569M=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YkCfDZ1YV8Sg198YzaK8bs0JwBqisv+qXJexQ7GOFUIFU+CIXyCuE3PaMm0pKEDJFdFjgbYoiykYhq0+qsrpSToxqwEy+9SFe0g8OIHSNHPcmMBYLetZGjVVBqWuu8p48jJef1zBdyGMXcicjjS0ntGqDSpJ+aG3gNnBZCGygiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KAg9Ijzx; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KAg9Ijzx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783476559; x=1815012559;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=eW1Zr+uACNeX1Q75PbzV0E44tVUMA29iJ/f05+8569M=;
  b=KAg9IjzxS+hA3yneqki7Lhzf8xl7/PpNI68fxrDRExEDv6P3OhKoaMNG
   wiVDSQBzPMbY7s+B8UTwqUaNbzqLz2rAGdVSxTNZu17ITpzinZuEPlx7M
   M/DzOX2/9Jz3QORj/8qDluotyabU3tliGRPLGH3B4pJg9SPt4O+kMjqY8
   QsBMGekdNHq7F1AABISLpi8ZU59pukRt9T0vt831M8fp5x+Tj4dIqSZuT
   NW/eDdO9Lf4pWSIWDpLVepzCrPFkbzEz/mj1InACRx0X4VtvGZFamTOBa
   alp34Dqre4yz3M0yCNFQLT1I2nrKM/2pXshz8VAlvmk9hHcRNjMLsXJyx
   w==;
X-CSE-ConnectionGUID: mwxrnNNcSXCdZPv/spcInw==
X-CSE-MsgGUID: 1FlJTe8uT5+1J2UPh8J+Kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11840"; a="94738968"
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="94738968"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 19:09:18 -0700
X-CSE-ConnectionGUID: yLp/Sp3jTiWvLSrQKdSh2w==
X-CSE-MsgGUID: X8I9hhccRjGfo5zIasUhPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,153,1779174000"; 
   d="scan'208";a="258033984"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2026 19:09:18 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 19:09:17 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 7 Jul 2026 19:09:17 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.23) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 7 Jul 2026 19:09:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HSZ9PX2C7yryIGv/Ba9EAIJzQKQ1Byy/n5VlMrGCNW4pIDhiEzaUZEXpVFnHaf44lTREzEyTGFezNOammNCbpkIHJzGNT6JBa3jAiRDkILITeLG5ZSjSjUjv0qodLmdF8hglUdytgloOH9O+ZZA47Wb4PI2m8bpvdXYtM3hzAQ/dlUxMS10ay+jTm0H6lw5fuSNePnGjH3gIxVIH04VRw/h7EAIyE4bBd8sFWVT7Ndjzt0EVBLSX1BXJBvzkI1p9cb0b2cB+faapuWuH+5eM1sCZF2HFBqGc1HqzccD159Hl6zZYQBc4IK3e5JZZNfTdxk81vKS19t920/l2eCChGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fCpJVvCeg8Byj5hsuxUe80wBm7dgv+2xLRXrD8xZKOc=;
 b=Pg/D8oePa9sUmnSGSccF7j4XoY9Zn5SSfrzgcC9B7R5gTgRRB3kCdnMG9qh+abcvqLQKzdJZggh3gZgm1unGuTHK85anBRLlmPx2gEW2wV3NKnwE7HUghQh5CIGRUMz+PAeY9wsw/TmI6y2Ng1AVok3RL30YBllTm3ZCXqV8JEXa8A9Bk1UCyiOkxZHfsgtOpzBpBVr+HQfWi9G1kPHwfBBDoLXMXJKA+vHh1+sKJBJTj888Y6ojqfHrt7cjIdorxnjzj5vOi656nBnEBC0sw5hGZldC46YqyZ3LxDb8gghDT+GGeV3Q1Iq7ms7s4U18ocgGzQcOD3PW29EM2WXbAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SJ2PR11MB8300.namprd11.prod.outlook.com (2603:10b6:a03:548::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.18; Wed, 8 Jul
 2026 02:09:09 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::a195:49d4:38c5:3891%4]) with mapi id 15.21.0181.012; Wed, 8 Jul 2026
 02:09:09 +0000
Date: Tue, 7 Jul 2026 19:09:06 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>, Dan Williams <djbw@kernel.org>, Li Ming
	<ming.li@zohomail.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 2/6] cxl/region: Derive port granularity from selector
 bits
Message-ID: <ak2xQgpfqN87Enqz@aschofie-mobl2.lan>
References: <cover.1781199122.git.alison.schofield@intel.com>
 <8958317c8d2a02f021f34712b69846a709f702f8.1781199122.git.alison.schofield@intel.com>
 <aj5r8tTFW0LJrqAi@rric.localdomain>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aj5r8tTFW0LJrqAi@rric.localdomain>
X-ClientProxiedBy: SJ0PR03CA0105.namprd03.prod.outlook.com
 (2603:10b6:a03:333::20) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SJ2PR11MB8300:EE_
X-MS-Office365-Filtering-Correlation-Id: 06dd326f-fa1c-4577-4b4e-08dedc95e5b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|23010399003|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Y5CBJmArp+y2dOc0yzMoOp8YUKht013LQoRlLe+I9AezDXinq2jYFimfHnRFl5FkNPYzgS3K0wfRGTkBx4OXo+928LH5DlfE4uLXTPyboF1YihhL2yB9RCvKPdb93EF+3pAGAJti2t6py0jkjVrummwHVwAM9Uvq8VbH0NQbmLlTR3j65ObKqzNfxeAU1pLFU3Qv6H8lrNBjMFZDFC4hOqQAyCxidV6q051sbgSRTK9dsiEI7HCTEneOUc3GgLrQ/4hCc472yJl5D+O7zIIhVczW+jqefQs5qmJHJ+1otOaPcACa2HFJ7GX612KGyCNzOINk8TUVPwDbUFUTm3RcmxtUeRLuLs1IFV658hXRFOmLbdURGPrMqt0o72B9AKoZ4qIHUDsJnzIHm2Wy6B29cPNnHU2KX3ocEIQABYEY764ElKkvRC83FwoCm6ruvVi0Jg2OtVYoLYhWdYY+pP6xu9tgCeI2dGVA1d7jUKZQB51V9ezxZrapnmOgRlL81vlrv9hE6D3Eg3getgk24d5C4pX+pc5H7L8FndmUBfW3fbkYYQ2SyrOxtDliwJ/p2MAZq1BBKaO+g9UShZwTskoDI9/j6w4OLI4y3aYLpN765hFoRljYH8Lzz3Ad5FHoJP+qdHrQqouu5Nv/dorfNZ+oYtxjKsTt5TG3JML5woWiOwI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(23010399003)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N5mJnLiOc6jjyYx3ctQptVo2PDpn33ceu+X8+XnA9xr5fQ6faDxSK4Lfuc9c?=
 =?us-ascii?Q?NST0OpLHQcwZsm6j+At4mIvcLrUv25yHyd0Mpwg1QLQ4JgkzXuxSjr6JDmVC?=
 =?us-ascii?Q?cQ0/y3YRvuM4+8nNjPEW7eTpwE/ntWe54XI7OdLDsj0aQJN1DW5uvUf0IDvv?=
 =?us-ascii?Q?/XMC+H3pYFsU9LCA53AEFvKWT3KbrBauwjUf3gDhBIT2PNVB2zZocD1V6Klc?=
 =?us-ascii?Q?hVMdqnbgOUTOpqqF+3NQFj2kapM/1JPU2y0UeAqwLDJlcSjBSwfov488v2q+?=
 =?us-ascii?Q?ApCConS5th3QlwF4jIAOJugE7YZAdI1bEzdxIIxVLlx+hsgX4UcvvbJgiUyh?=
 =?us-ascii?Q?68J8lMgTbKlbmlnslgisUbyaGWjhjKLOCBeDVM2WSi4pRFZeSL22JwSzeydk?=
 =?us-ascii?Q?bkMizUaeoKmX+0+oUb46EevPH54RI8LPL8FYnU1l1SPOlg0TI3gj7BIr+0+4?=
 =?us-ascii?Q?S5kHDaBSgR9VQd+UY6d7cl9jAkvzIkgtu/E0TVOOgbyDdSSCjPSH4XGPzWKn?=
 =?us-ascii?Q?PTPO3HOBYH9WmITQqqmuUR8qnrcqfF/GsQ0X3FGqomr46Qdw7BA1XkDiz3m5?=
 =?us-ascii?Q?TrZwHu7sGaYO2RYAlvZ89jnFSajiyS/rkPnPcPrNHS7DfYJ1PhPOB3DCRx4W?=
 =?us-ascii?Q?JciuT+IVwIkXDIpzEunmTrZghUcgGoeiX+QLhAqYILHGYxH03f1J0rcAcaLd?=
 =?us-ascii?Q?mZEFEtvSv/hVpNUZn+AkSQVaP5oYQGLVuqsLQLGwCbf8+TueClwks07pg38b?=
 =?us-ascii?Q?3m6LYl2g3dHGVVtil+1T/LQt1029/XFIhW8B4vpdRKKVO0nGUATFgaouKaVX?=
 =?us-ascii?Q?HAwiR63yuS9CznSQ5jHbf6zmfpcBvp0wWjf4w0r9MtGZDdUphl1fIcMutHSl?=
 =?us-ascii?Q?qMSlamg3X8DCTyIVK2kNzX96c7J8ixTZutiZpZU9la9XvwZYKpglKHHkP06h?=
 =?us-ascii?Q?m8BrGjdenXaol0D6LAHWex0ZEskseJgMN56ilrtIZi5wP0E0AP+7S/mPoFVN?=
 =?us-ascii?Q?RQnhNLaJxN+ds5noxAm9zuMiNakwusXt0z87n8GT8ipvY8bIe4esWte7tslI?=
 =?us-ascii?Q?dtCURpkGNSYS9bkSNgmcMELq6r+ATI4Gu365bmHAzGBNYC8rnmsOP1+pIkYE?=
 =?us-ascii?Q?6O7p44LXt2sgruNgRsy7tknZfCkm9pAp0t67+4khvgVIb/rLDhPiSYGLHhhA?=
 =?us-ascii?Q?gDKzvIJgEpYBhzsWChZ9mJuCex4nJOFghdAYw7yXc7TErH3ot5YqwWpmbb5m?=
 =?us-ascii?Q?DF1SNkaLX+3OAbcgNmw4Vh7TQH6xqP7Lpm4adFI0g3VEjL7uJMup80fxQCtT?=
 =?us-ascii?Q?boqpuQNXPratUPMMYWcYibsvbCrYCDIXXgaJBFswgJ2VF5/2XBeup9ihBtSj?=
 =?us-ascii?Q?wYfMfmmjUWf08OHlfsxGrV/b1ElBNeQAIwol0j84zqBKPms6UlEE9sCYXjSc?=
 =?us-ascii?Q?dRz1gIMYXEia0U8xA0tGW//2AVVYnHthB1wdFn9RRD+7dwIfBCZUc7onjSCs?=
 =?us-ascii?Q?1y9ymzf88MUC5KQCsTzzFibZjiqgwwoDh0aIJlr3BjYpvRcDKuSND5M/9Q3C?=
 =?us-ascii?Q?XTaan9urfpMmcTLSV78Mxd2CCEeAQe83QHE3kxr5mx063Eq0CjGVAE5VUT0h?=
 =?us-ascii?Q?12LFY4s1B2kHlLBdRtY7bgxYIZwRCvitbBbIsLKynsggoYKuk83cuTkmcMI+?=
 =?us-ascii?Q?JS0Hj00ES6jeSRJY9CjwhBgTMGmzBbzDXkML/zhI9pyyPTAtC6GWXcV6KNF0?=
 =?us-ascii?Q?lo8QV8IWvchh8SqDBsBTAp/2+N0mhfw=3D?=
X-Exchange-RoutingPolicyChecked: FrmwjnsNEwdwk/mAVAemmyJTvkhEIs0M0/FCMRhywVEMDFe3H5E12iWVjJL2zNxGbdTNcmZz415yrUB3A8lY6m2WWo6OH0ssL17dKA+lnYEAT+0Ddl6evrueAHkl7ME9AZmxpdkbOH+sadC4QQChsKTdJyO8q23wEZjxpF+IYekpM2Q4A3hiNjLuMdjqXRNcjuFc9xZF4B2DTp6ZbBd+pyq3n7VMLu9/CIoHuAIy1PiQUtCb8J4pg/TtPuSq0+kRQqtZ/3r0MN2qHew9K2NpH0yOUdOglIZcQp1l7v/pzkqqBJQAnfmxP5ymt0BKGbH+/OlwQ2/x1icXmv6WrTdbvQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 06dd326f-fa1c-4577-4b4e-08dedc95e5b3
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 02:09:09.6459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ShPK0cI20Zq4rBzmY7uJ9ptANQ8ycnltgP+KyEPjNTTeVnbLR0DJKh7m1mZRwdrnDGC7196dEKj6Wvwtr85R8FD0vqOxjrmh74EPrXcXDTc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8300
X-OriginatorOrg: intel.com

On Fri, Jun 26, 2026 at 02:09:22PM +0200, Robert Richter wrote:
> On 11.06.26 10:47:26, Alison Schofield wrote:
> > Selector-bit validation uses a single same-granularity formula
> > for user-created regions. Mixed-granularity layouts need the
> > programmed granularity to depend on the type of decoder being
> > configured.
> > 
> > Derive port granularity from the selector state:
> > 
> >   AUTO:    keep the firmware-programmed value; the walk validated it.
> >   iw == 1: passthrough; consume no selector bits and span the parent
> >            stride.
> >   iw > 1:  claim the lowest selector bit still available to this
> >            level.
> 
> If we change the implementation to use selector bits, this patch may
> change again. Anyway, see below.
> 

The selector-model question is answered in my reply on Patch 3/6.
v3 keeps position/granularity derivation in value space and keeps the
selector bits as the validation representation. This patch is updated
per your comments below, but not rewritten around selector arithmetic.


> > 
> > This lets an interleaving switch beneath a mixed-granularity root
> > claim an inner selector bit instead of colliding with the outer bit
> > already owned by the root.
> > 
> > Add a final check that the derived selector fits within the
> > remaining selector bits.
> > 
> > Remove the auto-region granularity equality check that duplicated
> > the old ordering rule. The selector walk now validates auto region
> > granularities.
> > 
> > Originally-by: Robert Richter <rrichter@amd.com>
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> > ---
> >  drivers/cxl/core/region.c | 30 ++++++++++++++++++++++++++++--
> >  1 file changed, 28 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index c859c8661281..d5d19ed62171 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1533,6 +1533,9 @@ static int cxl_port_setup_targets(struct cxl_port *port,
> >  		return -ENXIO;
> >  	}
> >  
> > +	/* Selector bits still available to this port. */
> > +	selector = cxlr_sel & ~selector;
> 
> This is only used to calculate ig for the non-auto case. Can be moved
> there.


Done in v3. Calc'd at the point of use in the non-auto path.


> 
> > +
> >  	if (cxl_rr->nr_targets_set) {
> >  		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
> >  			if (ep->dport == cxlsd->target[i]) {
> > @@ -1545,7 +1548,23 @@ static int cxl_port_setup_targets(struct cxl_port *port,
> >  		goto add_target;
> >  	}
> >  
> > -	ig = p->interleave_granularity * parent_distance;
> > +	/*
> > +	 * Auto regions keep the firmware value, passthrough decoders consume
> > +	 * no selector bits, interleaving decoders claim the lowest available
> > +	 * selector bit.
> > +	 */
> > +	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> > +		ig = cxld->interleave_granularity;
> 
> Move that to the CXL_REGION_F_AUTO section later below.

Done in v3.

> 
> > +	} else if (iw == 1) {
> > +		ig = p->interleave_granularity * parent_distance;
> > +	} else if (selector) {
> > +		ig = 1ULL << __ffs64(selector);
> > +	} else {
> > +		dev_dbg(&cxlr->dev,
> > +			"%s:%s: no selector bits available for iw %d\n",
> > +			dev_name(port->uport_dev), dev_name(&port->dev), iw);
> > +		return -ENXIO;
> > +	}
> 
> That can be moved to non-auto only part.
> 

Done in v3.


> >  
> >  	rc = ways_to_eiw(iw, &eiw);
> >  	if (!rc)
> > @@ -1557,9 +1576,16 @@ static int cxl_port_setup_targets(struct cxl_port *port,
> >  		return rc;
> >  	}
> >  
> > +	if (iw > 1 && (~selector & get_selector(iw, ig))) {
> > +		dev_dbg(&cxlr->dev,
> > +			"%s:%s: derived selector %#llx exceeds remaining %#llx (iw %d ig %d)\n",
> > +			dev_name(port->uport_dev), dev_name(&port->dev),
> > +			get_selector(iw, ig), selector, iw, ig);
> > +		return -ENXIO;
> > +	}
> > +
> 
> Same with this check, should go to non-auto.
> 

Done in v3. With these moves the AUTO path keeps its checks in
one block and all derivation is visibly non-auto-only. That
reads much better, thanks!

-- Alison


> >  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> >  		if (cxld->interleave_ways != iw ||
> > -		    (iw > 1 && cxld->interleave_granularity != ig) ||
> >  		    !spa_maps_hpa(p, &cxld->hpa_range) ||
> >  		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
> >  			dev_err(&cxlr->dev,
> > -- 
> > 2.37.3
> > 
