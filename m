Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BD8305660
	for <linux-cxl@vger.kernel.org>; Fri, 24 Jul 2026 21:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784930079; cv=fail; b=aMU6Ta0dcxJmsbH44ki7GXqsUVVlmjgTobtwdsYQO6ZP8S5MZIz7hNoFYYGSbjQ3kwNVjSGdE4Nu7xlkWiQVJt7HfzpMf6vsxFrr5F0IgqSt6fULzyeVXpdPEQIrgVSFuggNbFeE0csaEC1dR/aB/Qt9cXKJuuI5KUWq/MnJ8t0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784930079; c=relaxed/simple;
	bh=9C73tOgyFiHh5SHSCEaQI/EgoDs+42YOLqzaxv7eUfw=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=vC38N+6ZWrybLUg6HKVnb2pZJWRkAG8dL+BI+A3wtyXz+qnl+5Pch/MMihTwufBNkxDPPCssm1oHhj19t+x4K7BpXOyolS+rsyMxa+eO2EvpPnNn9tMwx9USRreroqwaG0JPifViAxc38bDxZ6CpPF1hH0Y3JfxGldYh+S/ozvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LcDcQCrO; arc=fail smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LcDcQCrO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784930077; x=1816466077;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=9C73tOgyFiHh5SHSCEaQI/EgoDs+42YOLqzaxv7eUfw=;
  b=LcDcQCrO421XmEkjEc1OT3BBEs4COMY59h9w+KKzvfhzUVE/Pil2Hhyg
   nG8oDyYYo+4N4x89vPIRElXA75Oxth4IwFObBHMq77ABCLo2PVdiPEr/L
   4EFz91HgvWRU6fXICFAnQn4HwH9f/5NAFFSRW8a85/s8H1Ih08TOzq4qS
   1gZbwQUNbKFq2J3bMr06yCsjDclT5cFvWjzIjypEsE/aaF9hTNAvrv86T
   9GC+JqohvWVF506d01UCtnxgnjKdtX9P1Yo4T9tIhxAmXAQlf7NNBk+3G
   Hvt6RT9jpAmBI9zU1gxeLna9X/NuN6dgGKkL2zh1XoaWw1d/uYydTALNI
   w==;
X-CSE-ConnectionGUID: FzQX2fEMQw+G0EO+3wXWFA==
X-CSE-MsgGUID: gvXfMakSRaKn+skPECXXVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11855"; a="96974997"
X-IronPort-AV: E=Sophos;i="6.25,183,1779174000"; 
   d="scan'208";a="96974997"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 14:54:37 -0700
X-CSE-ConnectionGUID: QGIpFXOQTPC1A/CJimqdHA==
X-CSE-MsgGUID: PqlxDlpiRK2+CgAumD5uhg==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 14:54:37 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 24 Jul 2026 14:54:36 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 24 Jul 2026 14:54:36 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.30) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 24 Jul 2026 14:54:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OGTboeezsefJdxKokqVnBgEZENqDUX795/dMav6ciA2t8ADpQ0kfIYzaS4WXFSMIrxromEBO0n0flJIjXCS+JsbC0T1ci4EGjQE5Bfcjyf053buq6jhHFSr1oDBEVBv2plo4WkRCqU8/V+g+Dp3QN5LnSixCmPTIQQgm8+huN6pf2dGCagH8oGcoW4MVlJMd+MDXOutSgl8a8x85CvrFvojG/AYcDjg5yyccoaI30+q2qpZOQY+BiTwF2J7mQUPPBPiJBGJDETbP7HJ350rxS2M/UndRYjNhiZ2tE0HodWs0KMe14evEnhvLF0F1EVKolh/mn/IcScd7Vy3wvgRd7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YyIFMvL+nLe25QvJh9yh8O9Hsj4bngFluck03KwkYeA=;
 b=kR7OuCo74PIbvRhslfPj3M9b+DCSuCZ/KA6784lBfLdZGGL5mJDrtMXZEH3jPe2FP2Kg7OrMVbiIVJfh6wjUOMns/3zYTP0bbBUKCD0T+R4RC1//qyFDp0xZoXLDKX9C/QHYhlZvnf434x9ghoHtrmh/NXFznSaGsPIFI4WO9rTuWjwxJ/nVeKBYVJzorPy/P3fp0gBd6GcKWCRnxhuWnc4rbed2fa99ss/mSwWo8z+hUdjXs9r/ENTzGbDa1HHxyVtF/u7chX8beFSTD5DwPhL3UM6BQiLrEoVx1Uiq4DUGnqC9I6KnKWeaK/lZZmmRh1myrHupwFqgYaxgefY6jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by DS7PR11MB6077.namprd11.prod.outlook.com (2603:10b6:8:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Fri, 24 Jul
 2026 21:54:31 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::e721:90d7:9214:2d53%6]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 21:54:31 +0000
Date: Fri, 24 Jul 2026 14:54:23 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, "Dan
 Williams" <djbw@kernel.org>, Li Ming <ming.li@zohomail.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] cxl/region: Fix use-after-free in
 find_pos_and_ways() error path
Message-ID: <amPfD6yFiTdYoMbm@aschofie-mobl2.lan>
References: <3a36953b5c665cb9544ba61dafbea0b0fa508c77.1784654628.git.alison.schofield@intel.com>
 <20260722005315.332375f7@jic23-huawei>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260722005315.332375f7@jic23-huawei>
X-ClientProxiedBy: SJ0PR03CA0362.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::7) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|DS7PR11MB6077:EE_
X-MS-Office365-Filtering-Correlation-Id: 1977f2ae-e083-4bee-b045-08dee9ce23ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|23010399003|376014|1800799024|18002099003|22082099003|3023799007|10067099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: V5j6B3x32Xo1BS8eDcHNDNSogqkoMjomVB7oMFSogRMgOD4gTjBQ3YA3g1J7q8Z3PfIBJmzJCif2yeJsz9acZYgiLe1/RxB+OToeXt9qNc+iTGMwqvzc/WfLAnEmLQ3Gium/zCyBgXyYxjy/Vgm024FGlCktD/yuEDKoCcV3n596BEftD/Vxg8dT87JxgatfH80MHZRPbBnDAOO7EWoAQXfDtppKH0eL0hmqGOlWQIJ78T+4OL4RM1RnAbDNu1amw3X13R3ZDvkTpxRNTD+4Cib2+IyqymsAjSzzpSboSsR/KtMjC5vCPRkqrCfm79hbSvJpi+Cvlp+HwiKTxK9XDxLjKvCzVSkdlbCddBFRSyTGeWOh0y8fRtKOFOhy4VKtPO/TNTmMZrnzLvZ9oBHj6GW1n1buN6ThcRDu/wlv201X50+/CEH/NRnPrYo+sH2NE22lQE30JgCJFNTm1R//dSBNogjhusMMPKpIfRaibdqucyk4L1sEGLqTklevMmacAOI7llODHXytLTAtJoAPdjVzKXqbGlbxbr2+2CiPLlmJqIlR/wTiIcSCqQqGvLEBB0ZnkCEVPYevqA4GWzvuVuynMochmLeK3NIhuNatUGRmfmCSRZlgDGiuLLA9GySiJVd8BtFaG9zSCOpK4NGLPD4wrKRVqwWIXoZD2XzAsIg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(18002099003)(22082099003)(3023799007)(10067099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?H8THBIgGPyirqixOH9qOXeLb0X7ekxHgQuSBGIq1QkM+K4lueXYoOKlwpNt9?=
 =?us-ascii?Q?IdVi1EKtnte1ESf9PwAxt60TtpCju9jQ8NOQyBzG386wuINxhVjT356+2lfb?=
 =?us-ascii?Q?pIo+4112d96JajzxWRMlrSiP9erc4DVFulHHJUD7lqdQBxSp31mOnEfV36UA?=
 =?us-ascii?Q?OSySmuuTXjt9+4o3m89qDFpkP1VtlWOws2nJ/mLKBWobUkOmeLq+cSBzes2N?=
 =?us-ascii?Q?+QT+G9DvCr8aIHvlsSuThoVvbpaIgsLaLpgMgpjgeCmd7BdWdRCDQtvfPyJt?=
 =?us-ascii?Q?5BAjDdNZrozpX5HnHRxwPoeztl9juqKjICL7gVk+Kr8SvJn43KHISHLx47wZ?=
 =?us-ascii?Q?JIW+gmf74txafaFmWRNTpFk/udcOvmg2IrY55oguOxM/KA2Lc9IaG48XCaWw?=
 =?us-ascii?Q?hR2WSbi2UzWtH7+YiKEjMAWqqhajbcmiYpY/sYe91Wp+FurdBqaAC6fAsL9y?=
 =?us-ascii?Q?NQtYjVH/ir/0y/MlCaBzfILnwJTDL//CvQ/ipOF8cYGVJwGjRK9CBMI/WFBW?=
 =?us-ascii?Q?t4MW1hzEesf0SLmfJmkhVy7vSAtjkm1uQnaASEtw+hHgat3viynMd8BFPwoF?=
 =?us-ascii?Q?5i3LM7gZn2+3SluGKeReNnISSLksMFO7HmEKizwvpAVOpB7tBUrqDrwqD3x5?=
 =?us-ascii?Q?caKdc58vFkxiI08KjTM64ED7b/wCuxc+qMPechAcVVH58mT/D3ho9p+WMVcu?=
 =?us-ascii?Q?1qFUtrpDFh6KMZa7+SoZf3CsUWOrbBe77KXwOx8crho/RbxTTRvd5uFI0TUl?=
 =?us-ascii?Q?7Z0DvG7c95LJMjZtJcDb4n3Vjnh4STLG3DfYYvze/Q+PVkBjKBipFflQhg1R?=
 =?us-ascii?Q?lYUAaqyqb0oGdM4/X0r5jUA7lJ1yS5/n2ODh2lgM4xH+VL7N+fFgpHmHlf7V?=
 =?us-ascii?Q?w1mVZMrLhLIh9Cr3YN5TlwVZ34mj/5dh5Jfa46sA8+kkFebtbVdZ8McFjbtp?=
 =?us-ascii?Q?b8o5OZ8GkX/cLy0WE+aAeVhRBAZ2Pcx7eqj9VKnn7cJpKyV8/8k9rNp28eE2?=
 =?us-ascii?Q?9IHH06KHygT4Q8qq25nBmeTG0bwyQ70fZsTTDWVb6YjZuBs0U28dEp9+c5Bu?=
 =?us-ascii?Q?2aUnUJ7qS4lPOa7Y+oHK6deEwesm0/AJzOki3ZbsXnTe3IfekAp1I/s4vDmy?=
 =?us-ascii?Q?dGqEFuq9iQ44gl6mTWUsH4u1gzimVAe7aeVvZI9/fGL4gByACqRrx7dV2PBu?=
 =?us-ascii?Q?MZQxGJDu5E8XWjm/E8+2tN+RgD6ka0imtjRgMc22ZTFQXCwmGWT6j3jWB8vr?=
 =?us-ascii?Q?bUIaY4L6OnsXsdt+DetzDQ0Qgt1f0xfMDFls7ABlboPGAHyitOZYijzpukyn?=
 =?us-ascii?Q?fQrSEtqtQY6xepisUYWHUWZ0DhQSSlFhK0fdrVkIyTNd1DiPMewCT0OuRfpO?=
 =?us-ascii?Q?pDqKwfbILgQ+erHVCZtYS0EpkW0DeSsBMwGH6NBlr2hRkEqZnjQTR0/WZAA2?=
 =?us-ascii?Q?3pfbXR4M065LGt8CuDilEuWUZx2RuPRb3PdGcJq0shidBfHKFNPeJptKn4VP?=
 =?us-ascii?Q?N7vH3TmgcpKDNHHJAygmlSyCFIFP6AkX6pjI/KrTnwTDeZPgvemHE2NeDDj0?=
 =?us-ascii?Q?mPp8c6E3S2x29Ek1rDS/DXBpf9k5zbhJTn2GbEtZ1z1N4MlIXKkOLyJwtFuo?=
 =?us-ascii?Q?RE+IKjDKKu3qcAHD6ESGi35ySEZAu1u2SpZrqyhqVLGgqUsVE5W9ITlduzKz?=
 =?us-ascii?Q?52RFiB4sL4jj+UH9Vw6NxhE+fwajHTJlF0UPdx+eSicnSDtKKpWf+Ag5C5om?=
 =?us-ascii?Q?nT7GbXI/zFE7sCRDHOiwN2iNSlDIUeQ=3D?=
X-Exchange-RoutingPolicyChecked: kQ9Ahl80BNkrwY0wLs6APbwRoW23fb55VVX/daU7n0NlCtG43geFh0X7HuTWaerWfq0EDIN8cESi6GXP/qzsu0jlWMPwn/RxIggmt8yZrprpBqSreI5a1ROZQ4j2mVNEeydRSkEGIebqR6sMjcvfgUA12J/bSfYtUPIATVagBR+O0AC4yPS0tBzat3Eev0D6W5vBKyER6scmPg7NQmXAw5ZQxgb3dozM1KUb4ah3RieKzhaWbCA60KaCYJElWUb46nWpOx6PhbbbQohFhRFjnhvKF2E3JYWFAFErG8LVWBebl4w50M0Ii2sgmwaO4/2qeaQUuYYQdPCLmbYAcGtkgg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1977f2ae-e083-4bee-b045-08dee9ce23ef
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 21:54:31.1736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ynrmkVMwf+YEvXDJorKfOQovbnQVq8ibO9Qxp+GOL58T4gPQ+BYLjs07ODPOHkkFQ/YdKgCoop9/TwdHZYnaEMT0UCRdCHLj7MmxgLaoYSU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6077
X-OriginatorOrg: intel.com

On Wed, Jul 22, 2026 at 12:53:15AM +0100, Jonathan Cameron wrote:
> On Tue, 21 Jul 2026 10:37:03 -0700
> Alison Schofield <alison.schofield@intel.com> wrote:
> 
> > The error path releases its reference to a switch decoder before
> > logging an error that includes the decoder name. If the released
> > reference is the last one, the decoder can be freed before the error
> > message accesses its name.
> > 
> > Drop  the reference after the error is reported.
> 
> Bonus space before "the"

Bonus rescinded

> 
> > 
> > Fixes: d90acdf49e18 ("cxl/region: Add a dev_err() on missing target list entries")
> > Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> 
> Fix is good but needs more analysis than I'd like because two different
> paths to the same struct device. 
> 
> What follows is very much a suggestion so if you disagree I'm also
> fine with this fix going in on it's own.
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Thanks for the review.
A change to dev_name(dev), see below, folds those two paths into one.

> 
> > ---
> > 
> > No changes in v2.
> > Reposted in series w the __free change in patch 2/2
> > 
> > 
> > 
> >  drivers/cxl/core/region.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 1e211542b6b6..c86dd9d55e93 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -1938,8 +1938,6 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
> >  			break;
> >  		}
> >  	}
> > -	put_device(dev);
> > -
> >  	if (rc)
> >  		dev_err(port->uport_dev,
> >  			"failed to find %s:%s in target list of %s\n",
> > @@ -1947,6 +1945,8 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
> >  			dev_name(port->parent_dport->dport_dev),
> >  			dev_name(&cxlsd->cxld.dev));
> 
> It's not obvious from that error print which device is which.
> Maybe the print should therefore being using dev?  It's the last
> line that matters.
> 
> Might need a rename to make it clear it's the switch decoder dev to
> make this all really clear.  swd_dev maybe?  Or just take the view
> the code is local enough and keep name as dev but switch this to
> 
> 			dev_name(dev));

Yes, let's make that clearer.
dev and &cxlsd->cxld.dev are the same device, so the output
is unchanged, but dev_name(dev) makes it clear which device is logged.
I kept the name dev:
	dev_name(port->parent_dport->dport_dev), dev_name(dev));

-- Alison
> 
