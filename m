Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EA11FFC47;
	Thu,  6 Mar 2025 21:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741295592; cv=fail; b=B1CfZ7y7Jk8s5Xi/RVh8kJ8h/GokIeV8UrwEEOADd7AbDuBaOVorRdB5RmEmBbG+tcCogr+hNnQkek2laLNywpgfRePf2vendw4Htg7xMd9QD2wVvHTfJV6KzdCdnlba8l4HLJdtQoq3kXyCvyV12C1uCdspGHhO/oExSW9FnJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741295592; c=relaxed/simple;
	bh=RUia4omUdevgnk1WQ1Ro8QN3kdQDufw+ZIdykIWmAts=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SprpPkOSr1dVlzyTWERyVqFrXJZFQjXN85+SJj9X9A46A4WR/mYBRLj7voeI1Ti2poeVenf/FglnpFslvMxJSvsJfV5lBNULqwU1Buhmg0r45PyXzaqlO4xN44dESrzyoY4Vh8rqa3ljJHE5yTi+2WUn6Sk2Lv02kCqNf6BS6bI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cScyblkX; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cScyblkX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741295590; x=1772831590;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=RUia4omUdevgnk1WQ1Ro8QN3kdQDufw+ZIdykIWmAts=;
  b=cScyblkXGpeek8qi4qRxJaG1TecICLJcYnbX3fU/QHQbAVAGWOS2laPZ
   aqivEV28efIrqx0CcUXSPEa3R7WWLnMCfpJYac1ztQH7cri0Il1Q/t2Wn
   xKwjvUNr+1shPd7TqKBALTIos3Coahmwc/mRRlqJ8Rs7RMknGkeXaXdQi
   ijOHa8HRofIu4F1yRdwldO5LPbf+hL6M4y0YTApQu7lMWZk/RPAFMmrtd
   yIV+6ArNUMu0uaCxNU+h8eONmJg5QOV5zfLiCp2eHAeNjUwPAMN40XcIj
   LYFCrjSXnnMn5EvgArpZ3aXpsclAEvMcmQDiZHzJxXDBhFwZvqCcZyt2f
   w==;
X-CSE-ConnectionGUID: SvM9JHyiTNqs9x5KiwS4CQ==
X-CSE-MsgGUID: buZ38P51SaO6idzfnIohCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="45137975"
X-IronPort-AV: E=Sophos;i="6.14,227,1736841600"; 
   d="scan'208";a="45137975"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 13:13:09 -0800
X-CSE-ConnectionGUID: uqrfZJCBQRmRZaghAziDgw==
X-CSE-MsgGUID: dPyZMLhKTb2x5uul/8Fr4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="156360157"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 13:13:09 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Thu, 6 Mar 2025 13:13:09 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Thu, 6 Mar 2025 13:13:09 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 6 Mar 2025 13:13:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ncDPgxo8F0nGsKg6G2haCa1/hRdG3n9l/iJtvLOIhWx/YmJD3NxeXJQ0b4lYlxPqh7re+bCI1aTUNGhjx8RhwpeNRTkxQZ5rYWi4SWOzg/t4TbKEljkeTviKKtPYuTI6BED4qZOOR2JNkxjbKOtNX6GI/OAKLgtGdHe/3f9Z9/RXfOwFdWUahi38AFLwAnRy1QR+77rPMPTyNnGcqDcAwBeg0b/0mwHjEdjI0iZqQ9TQmCdszuLbreb4RgGEN5no1tKjcYWieRrSVQsbKh8tHnvrDkJqxs76wCElPiUUlaGR0+DTUwWfxnNodqyjSSrSiyVnci9koBfq4Q7Wpa/DZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/KpbQlHgASN4qmWVWXdhw30M+idnakf8YvZNBDYZUM=;
 b=DV9jtW/h/eJGrxCmo/uJXYjiLWTexPsiVMsezb0x5dA7H4IcmL6si+bZCwhJoGzZ53I1rr9B6RtE8VnywssSPMe/SpQ1qP8lWejRty/gy/mbUDHuQ/pPB8gMFiaRBgXPf/+P9LepuzkaUZ9/pH3hP3avj6zi+eJSlT5Z3jMItzztQHbA79dCmpOhkevMxnlX9eHoaj/sqLmg2CJgIsEerJgIRsD746DR1DbRlJn4TykfLE4j65jKAIQjjHXIt43fM+6xlQVMeDXi6ZAK99QOgZlJJagiNjh6Fid9RE5TymJ5bwvH2x+ZVqjuW+1huuiMHytHh3enMZ8Bu5bnh/xRVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB7130.namprd11.prod.outlook.com (2603:10b6:806:29f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 21:13:02 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 21:13:02 +0000
Date: Thu, 6 Mar 2025 13:12:59 -0800
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
Subject: Re: [PATCH v4 14/14] cxl/acpi: Unify CFMWS memory log messages with
 SRAT messages
Message-ID: <67ca0fdbeaad8_1a7729486@dwillia2-xfh.jf.intel.com.notmuch>
References: <20250306164448.3354845-1-rrichter@amd.com>
 <20250306164448.3354845-15-rrichter@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250306164448.3354845-15-rrichter@amd.com>
X-ClientProxiedBy: MW4PR04CA0164.namprd04.prod.outlook.com
 (2603:10b6:303:85::19) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB7130:EE_
X-MS-Office365-Filtering-Correlation-Id: dcfc34fc-40e5-4c5c-943e-08dd5cf3ae11
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NFv3nfwhuCe6suZJGQFEHgdDmNqUla/hT4OKO/DxQjH7J5ymETCRsfAWkSGV?=
 =?us-ascii?Q?yUcsrBl3U88qG76q2yah/V2OxCEBPRS0TNVjh+6s/dub6FVzIVH/jzSuQHi7?=
 =?us-ascii?Q?7Y79XoOE21VRQXOcyYlFfKc0Y6MKPoysU2GeNcs9e55j6hCZDnZ3vsa27WjU?=
 =?us-ascii?Q?lYxdQROEhtfGQA3CLdc2NFIEgSfTE5iXoz0VIuDLcgvue50C1vWGQrFxZ0vG?=
 =?us-ascii?Q?2BvVibi6p2gTBFJQiuPzOx0Rz4qgIwUVkPmkDiD5FGHLo+9oDIsBigUpe6Du?=
 =?us-ascii?Q?s974074Aj58rk67eXBP/oj1GHz3RjLTJDPV+O4Lz59qdZiZ5N3v/rNXSKBOV?=
 =?us-ascii?Q?Rol4P6LkR03DW4UpUqBskieeA+eevRqh5vzhdfSoorOSlWvRFkeXFpfHUMFP?=
 =?us-ascii?Q?JsUzA64/MSChOrCCjE6vhsdXULlwHnf/MfJtCyOVOi18ZIxSZiqONyh9iBiO?=
 =?us-ascii?Q?/gvNKiClCk0ibbYpFskJKyFZBOcX/KPuXE4cK/516iCss+FaRzwMJjeqEXjl?=
 =?us-ascii?Q?dSP/lDnGUbSN+3H67Jb9OXgBG9gnAVaAlqsEm9zsSdP07qsQu1x/+7YvSBqn?=
 =?us-ascii?Q?EfxAG3+NOXS7Z88r+88n/zVNLfLPogXnSXmvLU6swrI6fkrxoPw9E60O0L9D?=
 =?us-ascii?Q?jZJJjBcXWeDRNwMduDDPp549XrXyxgrPh7IDmJYS7n2cX0N/UZmLtk8UNKEh?=
 =?us-ascii?Q?LcZ3uJA4qeR4V1mdWmxh9vvmt01je42sGuf4pEz+j2pxWZxgJ7fu6GEJuTDy?=
 =?us-ascii?Q?efYmqz5GxWuMBXjeIowu+YiJUSL6c9grQ9/bBxib90J1nBpx4AcnFQUjWFT/?=
 =?us-ascii?Q?Ha8s4ESEsWY1gYB14aKKQqgbvvrQBT5XV27CFykyqY7kWxjiZoaMSXnMm80L?=
 =?us-ascii?Q?APo20gJMSUIlJ1GC5qk6kbkbWhmylHXmKIa676wr3JGHTz+ZYrgU/CP5QltT?=
 =?us-ascii?Q?kescDj0C9sKHmuEvGSpqQGEIq711NdUrM89gX3jlCVUgW4CD+ERTuuBxcgvU?=
 =?us-ascii?Q?spXOe0vuY+O/qNBmTKC0BIfkGYpAUK+kB5XRl7W6hSwextyi9lGOeHlB3rtm?=
 =?us-ascii?Q?wpByJsKXLdPyjnaR94+kVg0U7YH7/EuR+SttFIAV5PDcmE2RtiNNhFdw6cBP?=
 =?us-ascii?Q?OangDxszPqOmY3oZfO75pe2WaJirPQvLDCBLZcjOxoqVZ8PP3eWN+HO6KweT?=
 =?us-ascii?Q?+aAatbyilC113/yfUMdTUT+qQLmkY9LxOFa4BKhXimQJLDWqVASxz0tbIFyG?=
 =?us-ascii?Q?ak+PfDczUfgNgUnJFvStmdWGM/g9BMyFGnnBdm1p0auQKtwBijjBlaLnXpBJ?=
 =?us-ascii?Q?LrshDK6ABb6Gb5+e6NxZq2YnP/mxL2QSjJRPj2DSrrwReE+PhaZKYIKYu97U?=
 =?us-ascii?Q?m2w31a3D64Mh5T2sM8OBsa9diFNk?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qPBNcsEk2cSjh/nrQB6t4yB7nrE8T5lr2zGq6TMCTRwEgsND2RTgPRW/jFp+?=
 =?us-ascii?Q?RgKWRM7wLXCqjJ2WPz7eRore0LQy0KbMgqnz+s8bXHIxYnlzOnhM9xOnd9CS?=
 =?us-ascii?Q?dLYJ+RH6ZIY46y8NtNCOGZyKhtnbyWutm9hzr+o3Uwery6UnaOMp41LKvaXV?=
 =?us-ascii?Q?xvOToyP52TgsxmXS1yanaqgV84zbSmfMZnwo3OxvXNV4AtTRhmp8HIKcsNKM?=
 =?us-ascii?Q?NIX6O0vbesWXHIC1cI4vKXjQmjBLYxnYwCKgpOCwbu2swpZaiO5bDRB5WTSx?=
 =?us-ascii?Q?Uy6JpzWSzB8It+/Ip7Qw/bvJnBkhgf+aBoRtSLDYboXBsXW+ofpoTIxmTzhB?=
 =?us-ascii?Q?QiWcvHYalfZhffxy+YO42mPBNKzBDGAbMKmBbwiKU09IMuFh7izzPvGTAzaI?=
 =?us-ascii?Q?wOEuzMyTVyKpHA065ATWTTOYZFeTjpNxFcX9pQqFnowTsC2z1LqzV7uCb6qR?=
 =?us-ascii?Q?YtpqB8XJQ7RVddDt91/TvNJe08Yimg1HgysXlmXpzGsCMNE2XJNY3EXcTwgD?=
 =?us-ascii?Q?iO8N8lNwTNb8L3UJ29B7etnY5a+Lz/oOj1/hN78V1fa4SUYDKr+/r0nf3ZBP?=
 =?us-ascii?Q?W9VGITRzy3lPX93E6ibVev1F8nLyXTIZvsvtEGN6LHhn9DfOBK07WJrEtw2e?=
 =?us-ascii?Q?3MZU12iMt73UcFLofFIXL6cGHrSTktfU/MfLDf6hCIs6fGsiNIrwUHdCbsgJ?=
 =?us-ascii?Q?wTXSvONZflL4FCGykJ+oyjkTrCCje8gq/mecoXdmSE56dVB5mKCq9DNKNgdi?=
 =?us-ascii?Q?RodCI5tO2bak2Gmrc/8x/kQREmIXyu3LC0890EXgG3EXPJJ9beuJ8LJNLJSB?=
 =?us-ascii?Q?SwCW0lT2m0/sAHACuB6NMToqjFOOS2TobeHezLNRtmZ4/YwjEuIvds/K78bF?=
 =?us-ascii?Q?0LinyHDMsXpLjaCm0oXp3XOtfufoD/zxNPSigdQS3fEuOCntbeABFSZ6aINp?=
 =?us-ascii?Q?bkcJixU/0rH/PRYBEiCa274OK2uNxMrgrrJWXr3HXIu3J9SBoMmsPGR3iQrD?=
 =?us-ascii?Q?8tg3+fiD77lYvdSdFdEle3D8cYpLyzY2Gn6QTvTw6F2h990SwBNX4AEKOU4s?=
 =?us-ascii?Q?jikKyBTbgLRGR8R5XnBmYQEygCnuE14t70eTvxv5BirHmgeSpjDMtU4grYcI?=
 =?us-ascii?Q?4lXvUX/JPKhumtDx8z0RJBUNPPypyY2MtajY44gMp750ELJAKmtZttjNm9Nc?=
 =?us-ascii?Q?Acl96Og7y2TFe1K5ZD5rzTAPwUnOugONXsNha1F+yiRc6VdG1BYvlPwAZ1mW?=
 =?us-ascii?Q?0ju+hvps3p40PEN/ELr1hAXaRdpSJsRMV1t1wmJoMdr7kEye7LI86GYOD2Kw?=
 =?us-ascii?Q?lgXhbogRNpfQPWwOZjKgj7EpHK7tnW6UxieYOSrgpXAHdcuOPEXMp/dmLupG?=
 =?us-ascii?Q?Ut2Fy37l3EnUalh7KtzpPH+QhpUnuuuIdUX2NzrAUewYjhlhuHv1+EpzL+6m?=
 =?us-ascii?Q?tpcdKpx92HGc0Kzr+3JPWH6x0+1HY4Ta1aSLAUZldRZh7LXtNFv2/WV7ynKM?=
 =?us-ascii?Q?aBubJJ7aeIjgISFbfwYuY1M3PWo4bAhTJg5GzSwENFOXSgoqcaq7Dc3zcCvp?=
 =?us-ascii?Q?IPLLX0WeZFLvZB/POL1sfwRzcDE9yVg4zi/Yocf+NfkfG7/JVPDsyQV5yRuf?=
 =?us-ascii?Q?wQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dcfc34fc-40e5-4c5c-943e-08dd5cf3ae11
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 21:13:02.5356
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KJV1NQgbLrFrhU8nQD1r/AsFb0mir4hcIPtauYdFWP4mUWsbqFvSMHLI1JE9nL0mA1uOFy6/oswxQtnGziDAgzNPkXN5aAGd3M9RFzplBJQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7130
X-OriginatorOrg: intel.com

Robert Richter wrote:
> CFMWS entries have a similar importance as SRAT table entries to
> describe memory regions. For CXL error analysis and memory debugging
> information of both is needed. Unify output of both messages to
> improve logging. Change the style of CFMWS message according to SRAT
> output. Also, turn messages into a dev_info() same as for SRAT.
> 
> SRAT pr_info() for reference:
> 
> drivers/acpi/numa/srat.c:
>   pr_info("SRAT: Node %u PXM %u [mem %#010Lx-%#010Lx]%s%s\n",
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Tested-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/cxl/acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

NAK on this one. If you want to add this print the best place would be
in acpi_parse_cfmws() so that it can include the PXM information and be
independent of the cxl_acpi module loading.
