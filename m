Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD201F936;
	Tue, 13 Jan 2026 00:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768262770; cv=fail; b=tLz3LfphiNJVpOicIGoB1foGd2YmOg/m0lXQK75UkDSQ0/5RvV5v1snS3Vcg55DlTRWygWbVx6b7OUuZMa4m5aIQBF3+SOCuTDqTqPT0uDT6WP/cPyEMVLgvQRm4cO/ne5RcRuiHHYLN8UHxn9aFliKi0dFyf4lYnVi0vpu7F/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768262770; c=relaxed/simple;
	bh=HcOwBgotvkA9/t5AImk1IyyaIlFPVcYQeFyRlCd6w50=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SRGk5QjsVpCD7HA5cIeGlgl0C6v4XsWdGFT6yvYumBpa01qFgUhPWUYCBWW1H3OZ1BceFH+QJCkt9JWk6tlAYAvwzVWNSi+NUtFjUqif92U9a7SCb95YjwoOpLdjTutOPQb4SGenP4SI9RjIOtL6lLYtdIu9cDhfxw8G0odtdHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cLFXBcay; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cLFXBcay"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768262769; x=1799798769;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=HcOwBgotvkA9/t5AImk1IyyaIlFPVcYQeFyRlCd6w50=;
  b=cLFXBcaywBbe39vrpVLKXW3G5SMi4fpG16hubiammRPq4MKIqYZmCAM2
   utKVRVlAC8+AO6kbBj4vxGPpbz4RBnLVp506TrLXPlQS4yIjo4HqBKTAr
   I7JTxlAuz8i0GC1PqEwNnurZM8q5kn2x5IBozdxHP0gFxaXS3OWyCvtqt
   lgk84WL6/7+q/q1n1Rc7wq5hF6Zrd+IshZ7yNcEq7Fu7Iiq2DjXlxUXT+
   nbmw9lLy2boduNpkV+3I84dayxaQrcXAfEpVSkRLaApU/HCk8HiKppcxA
   qKA4oUJdjdBF75HKffTz8Q61USBdRuLpwYBGEfiQT/Yjsky4ue7QkBUhq
   A==;
X-CSE-ConnectionGUID: 5ljZVc53QgWzCjFJYkccqQ==
X-CSE-MsgGUID: IYu5XRjwRU6ydYf7S6CKGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11669"; a="80186394"
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="80186394"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 16:06:08 -0800
X-CSE-ConnectionGUID: GVN0BijOQCeZUiT0OmWF7w==
X-CSE-MsgGUID: BXQO+ex+QWKcMpNHPNaM8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,222,1763452800"; 
   d="scan'208";a="204134295"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2026 16:06:08 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 16:06:07 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29 via Frontend Transport; Mon, 12 Jan 2026 16:06:07 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.23) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 12 Jan 2026 16:06:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JKCEVGFwAjpRZy7r7RiZqhzen9F7PvL/GSemHwILY1zbQ4dBzkTcP4Svd7q8i4xBP9XOk3EuRkubL6veerAlXAephZ+vwQGHoUY3K4Yw+1ti+JOnn8+tNaIpx8WkQWQY7L3Ub0eTqQNJslA5FfTpJMJoan+ZFHXQTva+RYM4x515Z4yWtaxyOD4rNdOtP0LFkAk0hdaoX4ihUaxkEVU5IofjMnou73WMbaJuu+zRH8Pi7agIL9I41MnP+XBHF7BfCqwdXzVZE1XtcQRQfeDRAG9j8GlLhGx6Xo63uA9DnzYP0vsx26sWNxgvIUJNP5/XT8zuGd37Z6XrRcvt3I+UMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTRKkxS4XV8Ob9V+gRxOot0rikFoEKKgO8XgFjmaiuI=;
 b=wAuv1OSTIB0XEKvd/Z5r8OC3e/gLAYR0lEg8i/2vC2KubXbdHdfaZrZQM7wWzaSoQq2l4IYkt+w1jp9+35QFpXzukrODDrvlVi+IXmk5Zl5HtBtT7F0D/xM5BXS3NJj+WTFHm1jNBxlEnR75bA9ZZAX+YU5SZTL6Qm6jZx1/BM5MVP5rKuW3keucxY8wt2BXpkSh7cFRVn+XFzxo/uq2Gl0rUA4AeJZ2yBgetPyWYH/XQ7u3VDIAGLxLEW6+wWCCgoL3lpdWe1oDiuP+E6YYH3NqlDzkICq9tTVNyhlNLofieZp6LdThPVwjKNnjBZPXzrT73CSXVG7fzHzCcYdCiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com (2603:10b6:f:fc02::9)
 by SA2PR11MB5129.namprd11.prod.outlook.com (2603:10b6:806:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 00:06:00 +0000
Received: from DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee]) by DS4PPF0BAC23327.namprd11.prod.outlook.com
 ([fe80::46c9:7f71:993d:8aee%8]) with mapi id 15.20.9499.005; Tue, 13 Jan 2026
 00:06:00 +0000
Date: Mon, 12 Jan 2026 16:05:52 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>, Dave Jiang <dave.jiang@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, "Dan
 Williams" <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] cxl: Check for invalid addresses returned from
 translation functions on errors
Message-ID: <aWWMYJSqlmLkYQBP@aschofie-mobl2.lan>
References: <20260107120544.410993-1-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260107120544.410993-1-rrichter@amd.com>
X-ClientProxiedBy: SJ0PR05CA0049.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::24) To DS4PPF0BAC23327.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::9)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPF0BAC23327:EE_|SA2PR11MB5129:EE_
X-MS-Office365-Filtering-Correlation-Id: c718e252-12ed-423e-a520-08de52378883
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?n0EA4DUYuzSABUGI324efvRNHIabpG+zD/PKO+PTHP3djx16aAlhOs7+SYau?=
 =?us-ascii?Q?zYHsRMCCetSyNmzh61flrhafPDA2tHRQgptMG0hSA03ZCctcF/OjTQOKC11M?=
 =?us-ascii?Q?lhneAFCGc8AA8stOs6TYB9O6keP7/ss6h1/QQ/gk11H3Cj2z25KoqqWqcxyz?=
 =?us-ascii?Q?raLbltXaiFHf08/wYTVGA/KyIO2eTuzVzeJ8aVrFU47ChAU3PtwX4mn55I42?=
 =?us-ascii?Q?/C0Vgm6deaUpjJ0c0oEEiojuxL73FV6OoHKDIOWctrACGh4j/SI594f6v0qW?=
 =?us-ascii?Q?H9QM3exYIPi15d2lzyDVYJ9VI6GkIz4/jA2VcUpYtqQFV29NlfC1SRNSpek+?=
 =?us-ascii?Q?nez+Lnqn1WjoVsKwHZx1d0qIlU7wwNvYBrnhFRQvWs40tKWKBB0Gu2Lm87o2?=
 =?us-ascii?Q?F2ah98TTIXUpgXKHR/M5VYrRD9laylSKr7VFHGCWPZQMidrSDeCbR86TJCJs?=
 =?us-ascii?Q?hq74XGjfOPGy+UPwEZSciSoNrzKrGVAcChLxXa2URhULAtoVHqpJ6t8RauRr?=
 =?us-ascii?Q?hqM4Y/B6TxPgLCH6xfAX0Dtvizqp7mcqWUCtDNG7UNNac1OY+iGpIfimo8p2?=
 =?us-ascii?Q?miyib1csCdEzzdZ3YyeyQ2PP6VXfK9WAjGSo8FnNa2SmSm6z1yy86l8akZMS?=
 =?us-ascii?Q?Xt6niOKCCNqKVjWNJHYHeDhWSbXnOAYju6fO16F2e2snTL2AsZDrJLiIRrcs?=
 =?us-ascii?Q?Rgi9iTeyRCILagtAasI77wlcIAZCTNR4UDgV6i3AJ10TMAPp1d7OUmaRnnns?=
 =?us-ascii?Q?YxT9BFHkNpbXFex7TmUspvgLJKhD4y3dgB+S03TZa0AJFrlHdZ2Dne1Mpzkh?=
 =?us-ascii?Q?CZTkU7zwQMxyvbgTuxSMPCqigU0m1DbVbC7hX7ploBJaj6S6xjJHmuzb8of8?=
 =?us-ascii?Q?r8HCdbVH5yILs4lgWwdvF+rybD+ioRF/0FFhIfki02PG6Jihk11i00wc62VP?=
 =?us-ascii?Q?8rNxLriH9aGnA1rPNyyH20s8rAXNujFEceonBnDW42p0DBQueJXssdQZu4bP?=
 =?us-ascii?Q?qnbydn3AggzK9K7PQSCJnnBYcXMieKd1H7iYgryMKZkzZqkedY2g6Gyp8PE4?=
 =?us-ascii?Q?Efqk396U0H5YMc5dvmglPkmG9fkvUgwbDDnja5P8vHaWkU+Gy45fytAiwril?=
 =?us-ascii?Q?M8RLHnpKgRjEbqty7sRMo1VK12O+3r+0jTx5RxRyIbhM6X7T2hnsY+3gx7G1?=
 =?us-ascii?Q?pzR+OIZTeAQwFa65CbTvmNHQ+1Diset/G4yRWe/Qja4A2O+Aq3h7KdBmoSDR?=
 =?us-ascii?Q?2rI6zrMDd7LXo0iaiDkThk13OxHHrVLEb7hD6dcqkZ94y9nIjWl/ynpZVSZ5?=
 =?us-ascii?Q?5cz1xQ2cQVwSBBYIgPol3bQ0H5hbR9m6WuO06q1b0tcPFOVtqo4aPkDyw5iY?=
 =?us-ascii?Q?QrWC7Yoe80qcHn0+ZB0ld+z0mcA0MDgd1wotytu7x0ALhxQPIx4wy/xJI38Z?=
 =?us-ascii?Q?8An3xPP91qRGgiQ0D49Zs47UF4MoRpE0?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPF0BAC23327.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L+IYONSt3jaVrXDM0qyJmjATtEtps3RcY6Wt4OJAwCMC75QoWa8YG1Jswkd2?=
 =?us-ascii?Q?qX2uKOccDlWZzcO+rJwzqSREr8Llex4JmwBYmCqvsInPJY7sCdzbDq4DVo3+?=
 =?us-ascii?Q?TXCmSqByVsy2MsoxF29M5ryWZAWyT2eanx6ZgqSWaeNSWD5iA8r3jDSv671m?=
 =?us-ascii?Q?n2iFKgBdTXx90bF+3OxGtIvF0wWPIni+wVTwAuNuTl0cNTfXvrZTIRP/xvKl?=
 =?us-ascii?Q?wsKKk/Ta2mpVsjk04XstbH8YB6RYgxg0fa7emthVZioDaJoqeFciKz8vWy40?=
 =?us-ascii?Q?nu1lx7KxIrIi1wKdshgcmHqXbaQ11bAjdsaIYU75/c0KUFGjjUcjgO4B1CAd?=
 =?us-ascii?Q?0j6HbWBLsaiU58+zj81AWbi/J0dMH1OqJ6Zs5Kd3BmUEm9OAkAOEY+YlePB0?=
 =?us-ascii?Q?T32YRNtMbPIdKRWLYWEmad6nNApUADlzSY1iMssfcohWBeeEw+wZBBtUoWvF?=
 =?us-ascii?Q?L1YOql91qe7LUJMX82Mtt5IK+bEY2SxRrROUz+hfny3VH+DzU7PZRbD6cWDr?=
 =?us-ascii?Q?tGwOk5mmDFbMTkOyih7JTYJ9FodhA0cPjY0YdM6s2PxlBKrzDPjEbVsIGxRl?=
 =?us-ascii?Q?1+E2NVTvjG3VUyqgBGutgS7ndB+o9236/G38dTNuyqomPXGhNbb3zyWu+q7J?=
 =?us-ascii?Q?S7DTCTGI4N2WYyiJID1e9i1XVid6n44u0xphHD4jD6TzPJUVTKvhXAZIKtDJ?=
 =?us-ascii?Q?QvUxrD82pKZp9t5j8YTL6MloGA/UGPrIjpO7IAp9Fzj/5JgV6ohx022gcaPG?=
 =?us-ascii?Q?pZIsX4TJItneFZ8SQ+B72vcH6a4K5iKtvLCSkBTHgxmtO9cfWdgRtbunXI64?=
 =?us-ascii?Q?s1g85EkVK/Jj3tg8ZC5eslUYBcZ/ct3acmY+NAU9mddMrjU/u+XQR7sljuOy?=
 =?us-ascii?Q?tH9CBd6TGPhDWH0XThuQ4k+OLTVfFBA2j87Fxa9Kjpz4fVhV/8SGjQRngIeb?=
 =?us-ascii?Q?jONOC/MDwIA2dw5ExiBTS8ET2LItdoRGXjXXAjMK1cIBNJdekj6pVFQbexz2?=
 =?us-ascii?Q?smQ4pxjq/tbLsm1WfGlQGHCcxIvoATgUBJVB0+2vgrEocy9KgD0eXhza8wV0?=
 =?us-ascii?Q?TYKtdnCQHrcmUomS3/gvNhtt+zsCZyQmKKu8XeqsnwhrEhZ2Y5qKfBNy1XZk?=
 =?us-ascii?Q?DutAy8SpxWMi6Ul6PbtO62zpjXlEoljCyAIOE9CstNDt4Oerle9zAjR03Uez?=
 =?us-ascii?Q?aa6ofXIqeBkTVTQhth8MXhmjeCBaTERufFcWlH9LKXPBHm+a5CHjXZiOLOsP?=
 =?us-ascii?Q?fN1tsjngyc/CEm6O73IzKyJ5E79PrcNZJuOg5QOMm5GHxK/N7+UC+SUfZ3Tr?=
 =?us-ascii?Q?njP1mUN8QJH6QC7AvH21p92gBJ5lZ9g5UU3L/f0JP3BN/eUoVro/SdE2aHED?=
 =?us-ascii?Q?fGxQ241PH+0YQBSiTa17e2LXH2LWrOgLyzgRLzgr9Nm+M7VYgAlK1baMz3S9?=
 =?us-ascii?Q?Jw/GNtRLTCRMFI8tl/jXsOUFHaXMJc58W6N6QCxg9rnY6Vn3ORDCUbUM3s2N?=
 =?us-ascii?Q?AiQf6107tP1xzlq4tx/+gkjXSWuwZNYdgbon+b/drxcws2a2uSahi0FgwLri?=
 =?us-ascii?Q?YgMtU/T6P3xI2NQKZLoixpS+GW5pbf0SEFG9SVuo/it5x84bPOTPmASki0/D?=
 =?us-ascii?Q?a1QSnXzk0gQ4yxZt9yVTCGXoiglufH1wwPWef3phHYvHt1jiQiXa7L7ZSKOc?=
 =?us-ascii?Q?vV1S6ylrEISe2I4kVia39JLNp9fxyEm8B4R7IaHk9sBgCcHkkodEi5SrKll4?=
 =?us-ascii?Q?nwkqHjDEUZb0lcGLZd3BVAWm/r2QYUk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c718e252-12ed-423e-a520-08de52378883
X-MS-Exchange-CrossTenant-AuthSource: DS4PPF0BAC23327.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 00:06:00.2801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pMrN+sKAwuFoyFROnEYMdGMh3wxG/rT0ux4bzhYNVS373fWz8hKz4fJcBS9XgqYkAjkXQkhCdRx+AtbdtSIlBP5NPURiPvi5wGH6xnngIxE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5129
X-OriginatorOrg: intel.com

On Wed, Jan 07, 2026 at 01:05:43PM +0100, Robert Richter wrote:
> Translation functions may return an invalid address in case of errors.
> If the address is not checked the further use of the invalid value
> will cause an address corruption.
> 
> Consistently check for a valid address returned by translation
> functions. Use RESOURCE_SIZE_MAX to indicate an invalid address for
> type resource_size_t. Depending on the type either RESOURCE_SIZE_MAX
> or ULLONG_MAX is used to indicate an address error.


DaveJ --

Please see if you can get this in as a Fix in 6.19. One of the fixes
tags points back to 6.18 where we introduced poison by region offset,
and the other points to 6.19 where we refactored for testability.

Also, please add this user impact statement to the commit log upon applying:

Propagating an invalid address from a failed translation may cause
userspace to think it has received a valid SPA, when in fact it is
wrong. The CXL userspace API, using trace events, expects ULLONG_MAX
to indicate a translation failure. If ULLONG_MAX is not returned
immediately, subsequent calculations can transform that bad address
into a different value (!ULLONG_MAX), and an invalid SPA may be 
returned to userspace. This can lead to incorrect diagnostics and
erroneous corrective actions.

Fixes: c3dd67681c70 ("cxl/region: Add inject and clear poison by region offset")
Fixes: b78b9e7b7979 ("cxl/region: Refactor address translation funcs for testing")
Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
> v3:
>  * updated sob-chain,
>  * changed error handling flow in test/cxl_translate.c (Alison),
> 
> v2:
>  * separated from this patch series (Alison):
>    [PATCH v8 00/13] cxl: ACPI PRM Address Translation Support and AMD Zen5 enablement
>  * improved error handling logic and early return on error in
>    region_offset_to_dpa_result() (Dave),
>  * use RESOURCE_SIZE_MAX to indicate an invalid address for
>    resource_size_t types (Alison, kernel test robot),
>  * improved patch description (Alison),
>  * added line wrap for code >80 chars.
> ---
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/hdm.c                 |  2 +-
>  drivers/cxl/core/region.c              | 34 ++++++++++++++++++++------
>  tools/testing/cxl/test/cxl_translate.c | 30 ++++++++++++++---------
>  3 files changed, 45 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 1c5d2022c87a..031672e92b0b 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -530,7 +530,7 @@ resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled)
>  
>  resource_size_t cxl_dpa_resource_start(struct cxl_endpoint_decoder *cxled)
>  {
> -	resource_size_t base = -1;
> +	resource_size_t base = RESOURCE_SIZE_MAX;
>  
>  	lockdep_assert_held(&cxl_rwsem.dpa);
>  	if (cxled->dpa_res)
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index fc36a5413d3f..5bd1213737fa 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3118,7 +3118,7 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>  	struct cxl_region_params *p = &cxlr->params;
>  	struct cxl_endpoint_decoder *cxled = NULL;
> -	u64 dpa_offset, hpa_offset, hpa;
> +	u64 base, dpa_offset, hpa_offset, hpa;
>  	u16 eig = 0;
>  	u8 eiw = 0;
>  	int pos;
> @@ -3136,8 +3136,14 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  	ways_to_eiw(p->interleave_ways, &eiw);
>  	granularity_to_eig(p->interleave_granularity, &eig);
>  
> -	dpa_offset = dpa - cxl_dpa_resource_start(cxled);
> +	base = cxl_dpa_resource_start(cxled);
> +	if (base == RESOURCE_SIZE_MAX)
> +		return ULLONG_MAX;
> +
> +	dpa_offset = dpa - base;
>  	hpa_offset = cxl_calculate_hpa_offset(dpa_offset, pos, eiw, eig);
> +	if (hpa_offset == ULLONG_MAX)
> +		return ULLONG_MAX;
>  
>  	/* Apply the hpa_offset to the region base address */
>  	hpa = hpa_offset + p->res->start + p->cache_size;
> @@ -3146,6 +3152,9 @@ u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  	if (cxlrd->ops.hpa_to_spa)
>  		hpa = cxlrd->ops.hpa_to_spa(cxlrd, hpa);
>  
> +	if (hpa == ULLONG_MAX)
> +		return ULLONG_MAX;
> +
>  	if (!cxl_resource_contains_addr(p->res, hpa)) {
>  		dev_dbg(&cxlr->dev,
>  			"Addr trans fail: hpa 0x%llx not in region\n", hpa);
> @@ -3170,7 +3179,8 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
>  	struct cxl_region_params *p = &cxlr->params;
>  	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>  	struct cxl_endpoint_decoder *cxled;
> -	u64 hpa, hpa_offset, dpa_offset;
> +	u64 hpa_offset = offset;
> +	u64 dpa, dpa_offset;
>  	u16 eig = 0;
>  	u8 eiw = 0;
>  	int pos;
> @@ -3187,10 +3197,13 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
>  	 * CXL HPA is assumed to equal SPA.
>  	 */
>  	if (cxlrd->ops.spa_to_hpa) {
> -		hpa = cxlrd->ops.spa_to_hpa(cxlrd, p->res->start + offset);
> -		hpa_offset = hpa - p->res->start;
> -	} else {
> -		hpa_offset = offset;
> +		hpa_offset = cxlrd->ops.spa_to_hpa(cxlrd, p->res->start + offset);
> +		if (hpa_offset == ULLONG_MAX) {
> +			dev_dbg(&cxlr->dev, "HPA not found for %pr offset %#llx\n",
> +				p->res, offset);
> +			return -ENXIO;
> +		}
> +		hpa_offset -= p->res->start;
>  	}
>  
>  	pos = cxl_calculate_position(hpa_offset, eiw, eig);
> @@ -3207,8 +3220,13 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
>  		cxled = p->targets[i];
>  		if (cxled->pos != pos)
>  			continue;
> +
> +		dpa = cxl_dpa_resource_start(cxled);
> +		if (dpa != RESOURCE_SIZE_MAX)
> +			dpa += dpa_offset;
> +
>  		result->cxlmd = cxled_to_memdev(cxled);
> -		result->dpa = cxl_dpa_resource_start(cxled) + dpa_offset;
> +		result->dpa = dpa;
>  
>  		return 0;
>  	}
> diff --git a/tools/testing/cxl/test/cxl_translate.c b/tools/testing/cxl/test/cxl_translate.c
> index 2200ae21795c..2d9b75b30dbc 100644
> --- a/tools/testing/cxl/test/cxl_translate.c
> +++ b/tools/testing/cxl/test/cxl_translate.c
> @@ -68,6 +68,8 @@ static u64 to_hpa(u64 dpa_offset, int pos, u8 r_eiw, u16 r_eig, u8 hb_ways,
>  
>  	/* Calculate base HPA offset from DPA and position */
>  	hpa_offset = cxl_calculate_hpa_offset(dpa_offset, pos, r_eiw, r_eig);
> +	if (hpa_offset == ULLONG_MAX)
> +		return ULLONG_MAX;
>  
>  	if (math == XOR_MATH) {
>  		cximsd->nr_maps = hbiw_to_nr_maps[hb_ways];
> @@ -258,19 +260,23 @@ static int test_random_params(void)
>  		pos = get_random_u32() % ways;
>  		dpa = get_random_u64() >> 12;
>  
> +		reverse_dpa = ULLONG_MAX;
> +		reverse_pos = -1;
> +
>  		hpa = cxl_calculate_hpa_offset(dpa, pos, eiw, eig);
> -		reverse_dpa = cxl_calculate_dpa_offset(hpa, eiw, eig);
> -		reverse_pos = cxl_calculate_position(hpa, eiw, eig);
> -
> -		if (reverse_dpa != dpa || reverse_pos != pos) {
> -			pr_err("test random iter %d FAIL hpa=%llu, dpa=%llu reverse_dpa=%llu, pos=%d reverse_pos=%d eiw=%u eig=%u\n",
> -			       i, hpa, dpa, reverse_dpa, pos, reverse_pos, eiw,
> -			       eig);
> -
> -			if (failures++ > 10) {
> -				pr_err("test random too many failures, stop\n");
> -				break;
> -			}
> +		if (hpa != ULLONG_MAX) {
> +			reverse_dpa = cxl_calculate_dpa_offset(hpa, eiw, eig);
> +			reverse_pos = cxl_calculate_position(hpa, eiw, eig);
> +			if (reverse_dpa == dpa && reverse_pos == pos)
> +				continue;
> +		}
> +
> +		pr_err("test random iter %d FAIL hpa=%llu, dpa=%llu reverse_dpa=%llu, pos=%d reverse_pos=%d eiw=%u eig=%u\n",
> +			i, hpa, dpa, reverse_dpa, pos, reverse_pos, eiw, eig);
> +
> +		if (failures++ > 10) {
> +			pr_err("test random too many failures, stop\n");
> +			break;
>  		}
>  	}
>  	pr_info("..... test random: PASS %d FAIL %d\n", i - failures, failures);
> 
> base-commit: 88c72bab77aaf389beccf762e112828253ca0564
> -- 
> 2.47.3
> 
