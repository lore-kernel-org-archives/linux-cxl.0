Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BA018DF72
	for <linux-cxl@vger.kernel.org>; Tue, 10 Sep 2024 15:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725982643; cv=fail; b=owmmlHHl2g2Y3y5b0fYfM6JBd1BKnAe41oPiOtf+VjjNaR4mYxoAuJN1nrjNdACLFAa2FHIsS0dz130DcmESaviV/KchxT9NynS4Ojz2Y6OcPY0Wj4SoCMxam3W65VfWOo02MwGNYDLT2lkZwyLMhSU13iXWU4cmlJ8jDYlrTCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725982643; c=relaxed/simple;
	bh=SL01P8yQ+mUYDWk9LZrKAlBVx3h+q2yOIWMMXJ6nFa8=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ounL72FDH5njHDtPDyKSreA9wBeCkFToC595Gbln/OtTRBeaTtOwlxdOzRvzWa4T5A9fy/iBknJYTFzyU8gPPGu+wTL7MOJtuBhXTVjl3/i9dSjr1IXT99JanuThQhRngBd9SSelYKD+5H+uF6dQLFvR7mwnPY1+kklvHIdZ5sU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Wg4SOnlH; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Wg4SOnlH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725982641; x=1757518641;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=SL01P8yQ+mUYDWk9LZrKAlBVx3h+q2yOIWMMXJ6nFa8=;
  b=Wg4SOnlHS901ukeP1XY9a7FYb7cGVp249WuC/Gh+9ZH2fWcdu4yAwZh0
   hWrf0zJz2P+Typ1JX2SIRT5DnwYBOZEvT7IIBnPasZtLiplbmLuO6vHg3
   SwMfGv5jD6Jbq7hd5nlofR5OCfZTA9Lgxe23yxohnjzrKNWTaLcLuMDHD
   I1+DRO6UJ4k0QDVzpay/fQFgV/yb+lGxZ3PWEhUfLzslzm4AcEJO0Aozo
   cfuxMAqe/vtf+W5PkmG2m0grILo+RnapNDHPv/an1nvEjrycPMTx4v3ou
   taIv1IwcTT9SN5VyrEJ9MF4w3JXkd3wlUdHjhIjAt5lupENmU27IB/b6A
   w==;
X-CSE-ConnectionGUID: eqWAg56fT+abqdUXDTkzZg==
X-CSE-MsgGUID: DVNuJjHVR/CXeps/cxpyVg==
X-IronPort-AV: E=McAfee;i="6700,10204,11191"; a="35309587"
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="35309587"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2024 08:37:20 -0700
X-CSE-ConnectionGUID: PooZVY8tRz+yceXu2tfLQA==
X-CSE-MsgGUID: h0C0Yc91Tl+BX0fg4TcSaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,217,1719903600"; 
   d="scan'208";a="66693517"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Sep 2024 08:37:20 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Sep 2024 08:37:18 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Sep 2024 08:37:18 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.43) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Sep 2024 08:37:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wKWv7z0KTNnqrnp94S+K3jUmnjCcNHgZcaxiE6J5n/nXxgPn5FEut301RVQWe8kaDF2NLcFZUIrIgcU4pKROTOjvnMq/OQ4ybFjlIM4LWJjL34IiZhI5k/EqOpvDonAyXCcUUtufQbpo6asAPKh4Ozt8D5zVe5NEP2tclVAkh9qd26Vk8n/wXiPHXcxXhZdWR1W6UtdXpi0QSNDNHRwAl/2CmRcG2rSCTZpnezqt2UN0BTo001asWCflRFtPNr4scJt5JaVLYx+xMQAfUPNln+8+acWbYvUQHYY3tMVbhca2Sux9Fiul5s/n2PbaHTGtWkg/she2sL1MsZ3VRalOeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kxJKADOr+7s0tkhbR3SjGKOm5AQlejqhv8ai7Y9fGMw=;
 b=gStp8VvnndhRIgu/w5AkxO7IIsaf/sb6+b77lYcC0JPmz0JRK2xaIqbTjp0VJSPjuoSDhu593aHZ3jLjmr6TpYPZxHIonJC85WC5Mf25VQ5dmXG+YbWjXcshCfbx1uGrk9OqFb/p+7lqwQutTTgwts+8A/Z0txoMcD3pXdRahxu5rg10hFKNUzLdmNpQnkIYXxQL6ZiUTE2nCE4h/n5EihzuBHvky7M3CNNHY82P2WFrpxHE+pnpF/gJwWPruUWbavwz3clJefvwTnsi28VqMLeni8rhs44r/HlOD25yvUl9aBU9UwZQdHBT4phw04r6t/Jn74v4yyo6PjFfuVhL0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by CO1PR11MB5201.namprd11.prod.outlook.com (2603:10b6:303:95::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Tue, 10 Sep
 2024 15:37:15 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::cf7d:9363:38f4:8c57%6]) with mapi id 15.20.7939.017; Tue, 10 Sep 2024
 15:37:15 +0000
Date: Tue, 10 Sep 2024 10:37:11 -0500
From: Ira Weiny <ira.weiny@intel.com>
To: Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	<linux-cxl@vger.kernel.org>
CC: <alejandro.lucero-palau@amd.com>, <dan.j.williams@intel.com>,
	<vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
	<Jonathan.Cameron@huawei.com>, <dave@stgolabs.net>, <fan.ni@samsung.com>,
	Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v4 2/3] cxl: Move mailbox related bits to the same context
Message-ID: <66e067a78ce9_3d5dd32946c@iweiny-mobl.notmuch>
References: <20240905223711.1990186-1-dave.jiang@intel.com>
 <20240905223711.1990186-3-dave.jiang@intel.com>
 <66df8232cec82_3c80f229462@iweiny-mobl.notmuch>
 <c476dc9a-8607-417e-ae07-effba90cf02e@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c476dc9a-8607-417e-ae07-effba90cf02e@intel.com>
X-ClientProxiedBy: MW3PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:303:2b::16) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|CO1PR11MB5201:EE_
X-MS-Office365-Filtering-Correlation-Id: b3de7ff4-e660-4f9c-e200-08dcd1ae7226
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rojX6ntPiz5AtY2spD95/+ZGTP7LLJ04DwNnj/I3v9YNoFbmJiay2L0Ev7TS?=
 =?us-ascii?Q?c5bVAjdcoxe82pmQPE0CV8CzwIXglXT9mBZj/ubyT9mDMYll1ayLQndU6+/F?=
 =?us-ascii?Q?vRVYUpI99UYOR/bhp5sbfvP3MKYR3DKAw5DT/YTvkV5NneGI+AWPQfqjixbF?=
 =?us-ascii?Q?FOAtPiynHXc1ZuilmZoLwmKBkPGt2eRFwdEgcLFMX9dL+SowVPg37y3hhuWS?=
 =?us-ascii?Q?hkgZsk1X+d3H05WlHKyJYRIetycZBsg/8cO30HGgPeI2BoFFp2k2al+s+ZzY?=
 =?us-ascii?Q?7o9stAmLGwsL5ZJXjHo5XEC4eKCWpc8f7/CKnihVKeHGj0PtfCzM9+hPeh31?=
 =?us-ascii?Q?mb01w0YYb+BtLaKHCD7Z1F2T6ZU7wl37DgdV1CnzPIGIPlO143C7tJuKjxqd?=
 =?us-ascii?Q?ae+lZN2jY0v4hnvegsbizh0dMzMcB+fATni4/IwESJvQQiRQZe0hJ0pI7nXU?=
 =?us-ascii?Q?r9Z6GMctFPrJ+LyBSx9oOf3tW23Qd/r5RVsRtZWmQayRfz9sNKUNiDtwIGNW?=
 =?us-ascii?Q?mAOl6NWX9VYlHV82K4c0kLYGxeOImL6O3toI9Bj+HxcuhluTRone3+Tvsjjl?=
 =?us-ascii?Q?2M+EHHUf//nPe1gdEUORGsUrJ7cgCn11IsO7Aj1ss/RHTm01oocKYB9JRAha?=
 =?us-ascii?Q?9M6Su6Q3qy+s0ICAFWVQzAQsJa47HmQ9n52kmAGFHQhMM+bPEvNuE2cicq2h?=
 =?us-ascii?Q?2VSJY+arTM5J+ZvXp76t3Y6OQ/nf3gsjLhEksMfHMaLcPI4ll1KvJ+On2QpR?=
 =?us-ascii?Q?dk9g0pASEljD5Sv9VlNk9w09NINmKPeykiUzO7tl+NlBl/do7rgiLtmYq3MT?=
 =?us-ascii?Q?Nh0BbTYiTd9MzM7dQm/zGXCrZQDIvEgvLKaI5XR9EDqlkbsZTxcr3L/Iylit?=
 =?us-ascii?Q?govkE/VOekS54C6To2+K/q1ixRFlpAPMopEhbt9OlN/TJ35i0i53ZYW/e0Ix?=
 =?us-ascii?Q?jeF/ct7PLN0B4elLLt2Exd7+qXp+aih2T9TGe4rUl0POnapknVvCHdEUmBCX?=
 =?us-ascii?Q?lMeLmSDhD4WdBKUR3mQJaTOIyvn0T24Ey/rcrbUwPKYfSYqzEqoSwl6Z1ko8?=
 =?us-ascii?Q?QGPgqzWUK1OIOMEhApcN3v5wtArO1UwVGrVp3Gwdbvs04XKAeFETbl+CrvA8?=
 =?us-ascii?Q?aTdPVh9jRYGssOhFdqfTxcV6HQZOaauZkWTUZly3Xz/IlYwzS/iInZ+xbVzr?=
 =?us-ascii?Q?VbfncvE2PO1IlUgBmPQI/DZjzVpL3rnVHLiH7o6rQjxGDcHcwAdZmggys6aV?=
 =?us-ascii?Q?C8C1fs6RIA4hgBz/loJtrcvSanphHDc9jdiVsWkHnfpkHfRTgl8AXZng7khZ?=
 =?us-ascii?Q?y3G2Rhtr7UU4LSl84xA7PLLAIOHqvugL6r/2to7pv3fmIQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sqjZogqlYoFIAPo0lrXG4k7JkjGezBPvtMJ6R2BkkrVT2Gxsk4lLdgFb3xd1?=
 =?us-ascii?Q?Bw3h1zICFeTe1PrR84CLAYeNjTv5L8LPphhzwNBtHKBJYgllc0Fqd6RDKVzg?=
 =?us-ascii?Q?TLhgNjN0YB/SYTEmHqLFfnxNECIP9cHdgVLUTshhZgAbKpgHsCwoXU3uRV/o?=
 =?us-ascii?Q?h5hDeBZG3J6umDZNMmp0+fdhpfuhtAv+nE1Fhix0qRWdR/Hw03xH2CiVxiGA?=
 =?us-ascii?Q?lwcwgnyj06K36hov0Ovphrlv2Itz2BVgrpXj8RMl8GX76AG6yEb66CGUr3q0?=
 =?us-ascii?Q?GxRLAjys+1sSulDk2J8+Cp3aIYqBU6kppg7e6ka4BzDkweE8UQQu0pVV2Bs5?=
 =?us-ascii?Q?ucPUvHVAwnJlxX/Ag/aJ7osT0J+JOZ/ZhFy2mr+ZONzvp77hGlQtabK30dHv?=
 =?us-ascii?Q?b3EOWxCsVrXf3G1z+FAD3kqoyOPG2wMjFzsbyweg3/q+hQDtEVG2kQZW7imO?=
 =?us-ascii?Q?M0zs1D4SEHIHuTo0JXE/Xf/r7hkfO5wA117kotyajaUHi82Feg7OL7DvLFq+?=
 =?us-ascii?Q?xm1L337jEzmoITJnav7nglh9z32eVVED6GLMxRc9jGvEViEszy05B4TtwVGO?=
 =?us-ascii?Q?H6KuqMhoTBCUxp6RL67Xc8WrI3FhGUnn9NhYT+DE+uMTLAJQSwWhOpoTVWAf?=
 =?us-ascii?Q?B75/A4ODGTLlISbRjoU5UMb+4rh47Do6vOGvxYfgP1EjWA/5EYoTU3+Rw5Jv?=
 =?us-ascii?Q?66wxwL+XYZl7LSE5yo6JQs4wG1D7o4djVhZ1rZE0VREXiagEKvRvEYGjoIRR?=
 =?us-ascii?Q?EfuVjxG44D/oiD3gnoNkwfniMlAfpX5czsevOd+qsgdZECW4VOgPlhEsKgOx?=
 =?us-ascii?Q?/GCwsVKfdQqMaL6uikKdcxZmwWu2o1Y4jKN2MNsfKZHjbNfmqa+f46vc2Nc0?=
 =?us-ascii?Q?vby52G/9cwA8QcqFyffmD/t1GVIPD+2OQsMta7su79IryEePNnZ7u595sGg3?=
 =?us-ascii?Q?+ecuRqjat1ISM1HcusrbeimWU1ZxM6vUqkRG8lKR7RnX+t7RP12szladqzCJ?=
 =?us-ascii?Q?uFUdFwyulrCe2WfREEYjgN2FSE5eFKjKO4wLaeq0GWkJOLNH7+5zSBgPPJpd?=
 =?us-ascii?Q?rnhX8xJXbfRFdrhO0vfQhpG+86gKGGTHyzaSIl6pNTCVR4vZP4eJjbQeJglJ?=
 =?us-ascii?Q?iPiWGelJCBNrzziI6zfRjlKwka7LLyGL+detoU4BO38AHrPvyJLConRkMZTL?=
 =?us-ascii?Q?7BgOqy/qc2IRJ14EfU4bGNx+CDALlimvfgyWK1psPrg93F5YbIOn/G7uIWSo?=
 =?us-ascii?Q?aIFXCKgDu8x+7OUTwV4ScAC0WCpOIgVOKq/YNdxZ0gtr2AbDmK91n1hYKHO6?=
 =?us-ascii?Q?71NkLfO+fYgCtsPVx53zHLtsuE2FudR1jMmtBZiGpylHUEupRz0pd2keiyyn?=
 =?us-ascii?Q?P6U671LPXBwnyxqhyshYrQUeGZ6yAUncmh1WR4Hw1GGbE3006ejLBGg2hJAc?=
 =?us-ascii?Q?hoNxRHYsl+dFDd08s+s5ihreI9MZSOm2OafALtC322KCkxj7+cMGwQMLgl4n?=
 =?us-ascii?Q?pyQ9RLMsGzu38LVGYeMSCqtFxH56Zeha72akFAZ1tYs5lnD0N/7uMOYYYSts?=
 =?us-ascii?Q?CwT1dxtbO6PvRw9HcPlAAtSuGuM5Wx3GVFtWMLaM?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b3de7ff4-e660-4f9c-e200-08dcd1ae7226
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 15:37:15.0885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1UBbDKM+EzuXgWU2dwlVCA3q/VDm6t5ziAQ6T/gq3COy1q/84Z92GAmDh1yeodMqrRs5GDsweoZMV7LZXpgTwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5201
X-OriginatorOrg: intel.com

Dave Jiang wrote:
> 
> 
> On 9/9/24 4:18 PM, Ira Weiny wrote:
> > Dave Jiang wrote:
> >> Create a new 'struct cxl_mailbox' and move all mailbox related bits to
> >> it. This allows isolation of all CXL mailbox data in order to export
> >> some of the calls to external kernel callers and avoid exporting of CXL
> >> driver specific bits such has device states. The allocation of
> >> 'struct cxl_mailbox' is also split out with cxl_mailbox_create() so the
> > 
> > 						cxl_mailbox_init()?
> 
> Yes. Thanks. Leftover from previously.

Ok with this change.


Reviewed-by: Ira Weiny <ira.weiny@intel.com>

[snip]
