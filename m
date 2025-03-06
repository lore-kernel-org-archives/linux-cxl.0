Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC55318B47D;
	Thu,  6 Mar 2025 19:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741290765; cv=fail; b=EMOvGD0pxmvcwdGkgWAEHEjalHHcU7upDw/kJ/LLmK3vEUsJUfc5ZLjVnDKt1H4yc+ieSYKvcaNhPsrpQrI/6iHJIxGWonPR3P1ZgtXYq2YFsHFM+l+KanmB0f5pR50J1xdhnwVH+Sr6sAWeXtAzfVCoNwkMT0sfB4NYyjhmslU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741290765; c=relaxed/simple;
	bh=w8aJ2s49soLKvTxW3a2XVNQ1mvstdTu9F8qyZquXDSY=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZMVdy7xA5Lm0vEgtIJQvbajeWaqdBDmb1Iy36hqI88EG73v6a44grOm1wUwry6LcTIxoMX1gG4kg+pX479BlzyrqscS/JBsoML0EEjep4oS/RLQF5haxTaKIR8qJk1lzUppEa7epL0T0zx5KKpNuTJxfbSvua0eh3HoQzI8B+0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lOtdC+LB; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lOtdC+LB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741290762; x=1772826762;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=w8aJ2s49soLKvTxW3a2XVNQ1mvstdTu9F8qyZquXDSY=;
  b=lOtdC+LB+cHsaaOZP7O+qPFGeG7aaMZBwiZ2NtBTGAaaBNNKZ/o9vM1P
   1N237JVzRN162C8x1eAntH5b1+FhCU7kuem+bxw5Hwu2T91+hU8Hq00E/
   uYDfMczonwF2xoCK0YcP3OeBvXpigol0era8nwM5ufbYd7uAAiLxp2Twb
   o8SkUD3e/D7GRy84IlvxKuczg8XvLy7aYyPeDQ7QII+hT58jwxrvjcENp
   7iXif4bVefx8tRW/uPJpsUWy+LnlbCGxbQdlH7jxei5/ph7Krqbpxe8qj
   bWKnkM2HWAa1/7FZ/WnbZiAEYabiLsLUlxVRyvKN3pTHrTTvCmaaLOU+s
   Q==;
X-CSE-ConnectionGUID: eAljLm7yRwuFyv1TOyVFXQ==
X-CSE-MsgGUID: jn0maHrxQzOI/psZyzSLqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="52530613"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="52530613"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 11:52:41 -0800
X-CSE-ConnectionGUID: ZMZL8OxdRyC+BzkdhCYfLg==
X-CSE-MsgGUID: lpay5+EDQWOGen0rKhRdcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="120037237"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 11:52:41 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 6 Mar 2025 11:52:40 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 6 Mar 2025 11:52:40 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Mar 2025 11:52:37 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H6YDYQO3xZLQzJPfYjbmXxbKdK1RF0b2c0lcd220WHLkJA9QqtHMqTgG5Y4N0qyFgLFzqNX6bLUFGikBJkyRb50MzA134P0iuh3p+8Sx5BFwZFGYBzqtcXXKKKFNP9zRN1LiXkEedMHP0lR7ZDB4/kAW30Hg0sbrazIjUyRuUcS7riZg1WCDDnHTciH+CqH0KfxCJeqRhJlLdVksGL7Nr9QbyZX52/UZcDbCQvpe7iZU8JrnCQxLpyKiF97JQVqV2BfJoTCtujMH4hztzllav17/GcYVSSN80B+eImxC2QWsuCvqogWi6LXdeFfh718YgqagGlK05PxAl5viay/y+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Puan4zRDcCiTAs64mKzGywBxiW3fHShJ/DS9sBu1954=;
 b=yuVhhSe+aPU/wPezlsVx42dHnBld4JWKUf6VN9LcVtSo+bcznJhjWYlnrlvtIgtJEeyG6nr/WJ3pNtKDxxCuGLFImSWJlx294ph8Jbbzw8BbMcdtmlID1ULPw0df2kyeNTH2PtIsxsZT0jWBrM1ut9X40QKutm/s4fdlQ+yItTwyfOuaxkN7LvKuKgr9miZU0BlztC10G964Jjghr26Qs90zeFrKfHoauZ37zVpgyM17tUlOTgee3P2hasVWvDNdGdYCxP4OKgaMTy17W2V2jYN+e8vKxi4kDFwS0TdudNGxciCiMnFSzmXikJNN5n2uIGSKK3Z0Xrqc17tbCcEgEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CO1PR11MB4770.namprd11.prod.outlook.com (2603:10b6:303:94::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Thu, 6 Mar
 2025 19:51:54 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 19:51:54 +0000
Date: Thu, 6 Mar 2025 11:51:51 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Robert Richter <rrichter@amd.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, "Ira
 Weiny" <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Robert Richter <rrichter@amd.com>
Subject: Re: [PATCH v4 05/14] cxl/region: Rename function to
 cxl_find_decoder_early()
Message-ID: <67c9fcd7e7fd3_1a7729440@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250306164448.3354845-1-rrichter@amd.com>
 <20250306164448.3354845-6-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250306164448.3354845-6-rrichter@amd.com>
X-ClientProxiedBy: MW3PR06CA0024.namprd06.prod.outlook.com
 (2603:10b6:303:2a::29) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CO1PR11MB4770:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a66ceed-912f-4b3a-238e-08dd5ce858a8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?X0H8B52NYEfl/YLPZMDwGNE6eAFHoSfJgGh1RpANqPDC1gU79NZkuYYjMsnW?=
 =?us-ascii?Q?ukMTPIdoATb6u/X+z5yQumxXReaIuavXAZEvfaspj3Ux/3Pym+0kYXmsEsv+?=
 =?us-ascii?Q?lw1n6fIy514MvXd/iQ9wyd5s8YARMWxMhwFkj7t/Cx2iRP+qRxQQILQFB72+?=
 =?us-ascii?Q?YRkXh7IW+pvjoTot10uX0p+Mo8O6p6Xl8TzgCXk4u53RXFj0IgegisCFnu9b?=
 =?us-ascii?Q?0xtvv0Yg7VMIFzAS+YV9KxpH+adU41s4U3A/3OILkovbV+Pdi8EgyyQaE/Qb?=
 =?us-ascii?Q?VqwtQHSdK5vavVwY3WkNnhI5VALXC9VMRgOyaa3Fl+7sZdRJRIz5Oj2cXKNH?=
 =?us-ascii?Q?vw5vXr/C+jS5e93QEAU2qvyHJAVj827LmpOsh05nHujjul/93SlnMV4yJsCU?=
 =?us-ascii?Q?dlB2R+TJc1wtmsVP+Hm0xjw1pw1pNIjbuzS0N5+cVKlouezEWZvLddXnSsbn?=
 =?us-ascii?Q?OGuKdtqdxDPMSvzJed01DYD1k5fsMNy5AERjw55K4oDqEIpjfj3bBDsRKps5?=
 =?us-ascii?Q?doNfvfsGEffiBz/nawVeUYKeprFz1bKK2z9qTt5F70w3lnDIWRJX9GJulmGB?=
 =?us-ascii?Q?LGMO8eAWqJZgkQH+dZZo1GoCuUJe9D7Ui87qiH6yUsy9MyjSY9g3VpTJG7Ht?=
 =?us-ascii?Q?f9dhUlTLxwBNY1ArhC5YTBUgE7r++YC0G5Ulh3/UkF9GeFCJaIMVOuW3FTvK?=
 =?us-ascii?Q?Ltttd0Bj9J9TrOedUZ3fyvk7usNS5LcLLN+KpsBCSmYp1sdsXCvMlS0GPjC8?=
 =?us-ascii?Q?hskT8smsRHRLQgCsPrVoamJ2fXblUaSYTDu1N8coygCW81nn8l1kjMTtu7vQ?=
 =?us-ascii?Q?rvjiF/SCqUJ/ibtGp9jRHQXwiiPDkHeZ1GVPkCmYAKeUzQk4g6t0B6aCqEvo?=
 =?us-ascii?Q?4KCWuTq3CfoyxFtQX7pnMVy9ruZjXla7HlYSKG5L0JKNVcDBfinFa6igRS1h?=
 =?us-ascii?Q?HZHbiMuQDqjYUb15Au/hYzIlBJHbt+Lwm0e+QoTobEvBGx9afxtQuiLpU0Z1?=
 =?us-ascii?Q?xqndnaciJTgxTGxwH7PZV2By6oyAUoxBmnrtDHamKhPS6jucbrRHHXsq27Ba?=
 =?us-ascii?Q?NxfX7i0ifQBrVRNnth72vIV5vjuOf1p65S3ylEms6ltEz4J2NKuodNJnImj+?=
 =?us-ascii?Q?kTeKbIcNHtBDtEaxPouc83Ulywk3ZXlrcgm6h7i1xshsMDky+WzX9dpAnbB2?=
 =?us-ascii?Q?09bI7i+BAyPWsNlJ6ILQSgWKiboOeEgJ37rL2D5aHPP18gIHrK7LLrqbiAta?=
 =?us-ascii?Q?aiwu9AE7kkACFpw+fI0/Z7JSUTqJ6/s0Ab2ssDmp2tLcR+eSXEfYEDEcxLSL?=
 =?us-ascii?Q?gtgnPgWxWxl1J7znNN2ZodegVI/xz+ISIRAwGR3Pv3/9sdahkgSizYKncmgz?=
 =?us-ascii?Q?qnSiEziqGLZJ0/Mqqcl5Z9snqmpd?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DBLk5ZdYlNYzmm11Ggno5yBEs82s0ZKKZ7lByf7PcgrcXs28gmsvZc8pmgxi?=
 =?us-ascii?Q?MbtVF4iw+Y5FgGZloqxBy6FFALaou3KCJs7InhQTIQFMfunUbeJ57JYuLVDK?=
 =?us-ascii?Q?JgPh3J0haqB38Re43nq/J1fM7Hs7Xmn5/ATt48q2QJij5zjcmLJj+U6yKESr?=
 =?us-ascii?Q?k/YLEHVaeDRk+b/Lph1INL9x93x7M7A0SWxXDGQ4MwB1tGLlzOt6g/faJQk2?=
 =?us-ascii?Q?QwwfEErjokFJ+q+UgbgdA82exnV6qMzVLPxHjU3nerVmePKG7Lde4lbM2Jp+?=
 =?us-ascii?Q?4fthIe13aWGixEu4eDULTlVU6ViIbxYmQ55fxAEIvCugAf8rtOuK9poqWHB9?=
 =?us-ascii?Q?AsuvPCTjarU9iSpxniJ8VB9FxfJuh+dyb9OmjCdInYGbcG/wATyVZYWeoMTc?=
 =?us-ascii?Q?HZLYUIYlXXnijjy4ztekPbxeascCeI0rz6yfD28JcokLCS9/cmElIqBNVxI/?=
 =?us-ascii?Q?l5SIuCBgrYiAM7u98sOfY6JpzZ+ccPFPyJlpHjVugL4ZGy0Nq3fphge7abZl?=
 =?us-ascii?Q?f91NCVrwZw1yuOc1FP+lP/TInokKgrqSgK9N4w7i1fQvMrf+QmUkNzKqp3FZ?=
 =?us-ascii?Q?dkDW7x8nGCdCJ3AFHHa5+kWBMhnpAFpGD8p1ipmKYQnyqmVArxB6ygOsOhwp?=
 =?us-ascii?Q?vDzEOkpocPQpXnjp3T+ipCfxVkXmGoXjOOF7yQOP+fMBzY1lSMAIxDYSJ60n?=
 =?us-ascii?Q?zjpglVEfC4lRCrCCKNMGp/nGvt+/W811tdwVvEOZzGB6XWiLZymL4IgJ+G8F?=
 =?us-ascii?Q?7cqWBeMsh1MqKNCB4nBTacIyhQmIHm5leSf199MyfnGf3RFtFVbmJP4hLYxS?=
 =?us-ascii?Q?ZXK/3BewB5fxoI+7oqDKOwE4iAPkVpDBu4ionwIVOWOjA7/dHEO6o9sY/SKC?=
 =?us-ascii?Q?KhYd4GPLBrgt+aEUCV8oYaujyedr6axc6H9qnvQfggwUhy/GTN8+j4DVt1AS?=
 =?us-ascii?Q?qg2APpWDYone656iFCbJjSvkzKJB9Wm9D4SHB8+IbJRwBNm//GeKdSOXl8Hu?=
 =?us-ascii?Q?daSqde+gMZzTK5qJ4PfAAHjhJb5xC+VZ5EDWS05NfJu7+a8WpYvtzuXwHEKJ?=
 =?us-ascii?Q?QhEPghdxXsOlCF/x2L4pgL+afUf0TkuNKPkVrEemuWFC0u5i0TxJS0UP3GnZ?=
 =?us-ascii?Q?uf8gu82HQaK8Mvh7zYvcooPi7QRLawwF3zNDssHoY/HNJGdgzC8/875pqxYm?=
 =?us-ascii?Q?6dJ3wJ4lvwD8nXb2fmMO2W0T/VIkrPyVuThIRFHYSuhozYD6yR8O+vk9bttz?=
 =?us-ascii?Q?M/iEFzoJrgigU2krt/Mt9dwe1vQO/a4kW/RCREmdnuQZ18JR2rz3+7zSndtB?=
 =?us-ascii?Q?qtcI3RitqnUmiQyG77DOAiedqAM9T+z1ym87JarIahPOda8GkXBug+2dzGrJ?=
 =?us-ascii?Q?UQmc8wSofG2gJ5+Dn2Y3rnEHjp7fEUyPv9cT9oQV8VzDmRQWVlsS2NcsXLM1?=
 =?us-ascii?Q?kGzVRbSCW8Qv587NKiPDIlZ+cpH1JpcAMxvN0Z+x/V1MdVpeBamlbOOhRRmv?=
 =?us-ascii?Q?KUdZ/oXRRguARkmlsBuf1eB1Kwd34z6zL+YDjA+1o0ZUJrm03kvTyjlWVcBp?=
 =?us-ascii?Q?pY64m15Fke0XnXOb1ilcV7THc62A4kfRIy/7Q0XCoIf9i7JADz2a1yhmcapN?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a66ceed-912f-4b3a-238e-08dd5ce858a8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 19:51:54.7437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f/NWnmYBUr5gLrGnsmukDoX99bE8B02Zmk8F+7dyLyrJf4Vd6PUSS66tjADSeTXYtPPOlsngU0rzEN5E4KOX2aZ4xfGbUt1ORDWOdOHWi9E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4770
X-OriginatorOrg: intel.com

Robert Richter wrote:
> Current function cxl_region_find_decoder() is used to find a port's
> decoder during region setup. The decoder is later used to attach the
> port to a region.
> 
> Rename function to cxl_find_decoder_early() to emphasize its use only
> during region setup in the early pre-init setup stage when an endpoint
> is not yet attached to a region (cxl_region_attach()). Once a port is
> attached to a region, the region reference can be used to lookup a
> region's port and decoder configuration (see struct cxl_region_ref).
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Tested-by: Gregory Price <gourry@gourry.net>

"_early" to me has always meant "before some other subsystem dependency
is available", like the "page allocator not initialized". So I do not
think this name helps readability.

> ---
>  drivers/cxl/core/region.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 4f79cc17c9c8..e40ae0fefddc 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -865,10 +865,18 @@ static int match_auto_decoder(struct device *dev, const void *data)
>  	return 0;
>  }
>  
> +/*
> + * Only use cxl_find_decoder_early() during region setup in the early
> + * pre-init setup stage when an endpoint is not yet attached to a
> + * region (cxl_region_attach()). Once a port is attached to a region,
> + * the region reference can be used to lookup a region's port and
> + * decoder configuration (see struct cxl_region_ref).
> +*/

I like the sentiment that this function is only for setup paths before
the given port has a cxl_region_ref established for the region, but
"pre-init" is not defined. Let's just call this function what it is and
document when to use without making the reader of this comment wonder
what "pre-init" means. Something like:

/**
 * cxl_port_pick_region_decoder() - assign or lookup a decoder for a region
 * @port: a port in the ancestry of the endpoint implied by @cxled
 * @cxled: endpoint decoder to be, or currently, mapped by @port
 * @cxlr: region to establish, or validate, decode @port
 *
 * In the region creation path cxl_port_pick_region_decoder() is an
 * allocator to find a free port. In the region assembly path, it is
 * recalling the decoder that platform firmware picked for validation
 * purposes.
 *
 * The result is recorded in a 'struct cxl_region_ref' in @port for
 * later recall when other endpoints might also be targets of the picked
 * decoder.
 */
