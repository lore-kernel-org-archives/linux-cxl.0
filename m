Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9E4166F32
	for <linux-cxl@vger.kernel.org>; Tue,  4 Feb 2025 18:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738695039; cv=fail; b=JSJekiiT1C5RctQZp3CRQKyf4uhINyQWdQbXh627WZxhiJsxhR1rn6c1BRSB0alj2wkp80dBKang5VvFXpkjYb+1ELlK4ZFRWMB7zWKpvTd0+EHJ3LsmsObVvvtBm4+getCWKi5cwkTHWzyBLdeHMIftnKK2iBwlEfuEcJZssiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738695039; c=relaxed/simple;
	bh=u63ovATNKG6//3bgm1X6LUDlm5GncexMh+xmMS+86Ss=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QhphZ2VkLe4mzzsBkKPLMH/DKfT29DnBSwHjUldftI22MjKlhStZ6HZPCzUWQr+YxDFPHQZquxZCVGpsndl1zC/YjS43+3VprkbfWyWcSGd+pi6lceQB0dMzjt26QBjrzqOrEdc/QPcIjVOXdmp/y5NHZCgW65daFNQtRneakJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mse3MCAs; arc=fail smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mse3MCAs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738695038; x=1770231038;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=u63ovATNKG6//3bgm1X6LUDlm5GncexMh+xmMS+86Ss=;
  b=mse3MCAsliwK0JQ2Fn8qDL7j1n8zL7ULck35af2i+yARarV83mu68TpH
   50RDz69cxljLeiGuO98+S7nHUaj9C1VQJOuvD0NNpNXKwVAbCT2OsUsIp
   E7P3+L0pjP10pAxEleWTox2jFx3+RuwTok1eoFhMrourzCffdjCdUhwUo
   31tuhFY4RjbT3eDfoRe8ZG8r5NWk3Z0HGiznXzaabiMDWw2NWiXMAmtt1
   J+6SPodSUMn4vAeoohviUX4dZOHn5uzzdoYKUMLTUP7ktDj2Yvo7UjdU3
   OVEj+CUbDXnXjMOk+YBrfDM/c2AQHE8zWCGpjTrNy1RsQ5uX+UEjW1Dh3
   g==;
X-CSE-ConnectionGUID: EBv/vAH7QZquRTv+jkV0zA==
X-CSE-MsgGUID: J5GToePcQnGKCIJ0QVa36g==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="39268556"
X-IronPort-AV: E=Sophos;i="6.13,259,1732608000"; 
   d="scan'208";a="39268556"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2025 10:50:35 -0800
X-CSE-ConnectionGUID: LTiPLCV4RaG0OHgxVqYwGg==
X-CSE-MsgGUID: wgH2bjrOSHqT8N2GaOKV/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="115861076"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Feb 2025 10:50:34 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 4 Feb 2025 10:50:33 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Tue, 4 Feb 2025 10:50:33 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 4 Feb 2025 10:50:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=udjiWClP/vGicVSpw1RaquXhxwUMmqgld25a0EgNlzBGOyEPYd0o0hI9z0zd3qufUDQ7rh6rJcxT5+NSGRaC74GtZjzgueA2Wvuuzjjs70wMyuUxK+C6e24XjFBHNRTTvhYaFYb/nD/HOyva2Lk/6dIdMUt6o/ukJBE3CWlTygrtx9yqkxoVKDNyU8RlkGUyhWih6q4gDLKFiOqqnn+N3Zg/81QFTnbUFyOMOE7AXzegIMuDEelRJAVbFy3U87/7GZ4ZFoP+NhTA6N0XMb1j1JemORiylqz1sK/SIV3iiMvwBkV3qjZ9fyIrMLhwPDJkhSqdhvUCkSkdloEC3EDKMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RGFOSDozs8KnbydS0Pyf77A76pU0+57U8KgsDe3L5jg=;
 b=HgbeWa2SUFjAWxIwKSwzLuVSXjH79SuwTmqGBrGsEzw0EGa8LtGsI0F/BShH2je3wYoME3LF1ZLTC5M40IrRAsUZsMMdMpuacNf/xkYNREWnSmuWIo/x4BV01pb3sRDHvxrBS/Zlpgr1JB0icJS9d6b9M6bEI+O+PcuiqNVgfwSV3ko83EE6dPZUxxc8jxuLBTuD3EPyiLbyliOWvDHoS1RrEObLQNK+Gfpu5J2tlEGGD2YSvfBD0aO8XQFO4z6RphK0amPXhijFu4LiZR55ttijSMnZsfSVZi07iFLR9LoDbKxulFry7DFn0i7JJyvEFPr5O9yXVwwaZD//uE08Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by IA0PR11MB7282.namprd11.prod.outlook.com (2603:10b6:208:43a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 18:50:03 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6b05:74cf:a304:ecd8%4]) with mapi id 15.20.8398.025; Tue, 4 Feb 2025
 18:50:03 +0000
Date: Tue, 4 Feb 2025 10:50:01 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>, Dave Jiang
	<dave.jiang@intel.com>, Alejandro Lucero <alucerop@amd.com>
Subject: Re: [PATCH v3 3/6] cxl: Introduce 'struct cxl_dpa_partition' and
 'struct cxl_range_info'
Message-ID: <67a2615970a65_2d2c29452@dwillia2-xfh.jf.intel.com.notmuch>
References: <173864304059.668823.3914867296781664103.stgit@dwillia2-xfh.jf.intel.com>
 <173864305827.668823.13978794102080021276.stgit@dwillia2-xfh.jf.intel.com>
 <20250204115047.00006a9f@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250204115047.00006a9f@huawei.com>
X-ClientProxiedBy: MW4PR04CA0226.namprd04.prod.outlook.com
 (2603:10b6:303:87::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|IA0PR11MB7282:EE_
X-MS-Office365-Filtering-Correlation-Id: 338296a7-91c8-49ac-bf0e-08dd454cbc46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TsWzLW7Q9O9OQ3prDntzMbFBz2U6/UkorvFV1jy95/+YjpikqdAkE1MCcqlo?=
 =?us-ascii?Q?pPVToufZXLW0lfOaB007QXRABVrMdzT/13F7DzXyLQStCmQoJPXnN8fuQUmy?=
 =?us-ascii?Q?NJfVhGgVnqF7SwKuQKSOIoIPxBp8dLmwfqTdDSD6NUe+mO73/pNoGxm9wWPj?=
 =?us-ascii?Q?CRal0M/NcYC8F9tdG9Xj7I9PhuxCuuqVpjA0bxohT2TyU0WxaAjV3pav2Zr2?=
 =?us-ascii?Q?phtLMsXgTEEqEc/Ntj5gWC5ZXyUCiszMy81SYt/fUfbD0NWj/53lZT7oPI1N?=
 =?us-ascii?Q?l7aPITsiTX4PVHODZx+LrOD5uL741Db1nWmZsmGWFT5RtvpL18CwcDMfYIm/?=
 =?us-ascii?Q?OX+B+h3zecKehGjghK1ORaNV9bi0sRe/Yb3S7AHRN84MNnW4q5zakH5dRPsN?=
 =?us-ascii?Q?3sHADEgyqTs7EgXi8NdycOMXEoNuMyQDjr9QpJiw7JsO3Kx6CyBGmCv+nceU?=
 =?us-ascii?Q?gsLSSa+L477nW3yWgI+LYadmeWtVHT8eotpHq4H2GBN2iizNpKMVI6174Uo2?=
 =?us-ascii?Q?RIC5VctEgEkxWHcstsaV5E5XPDn5Ud+cBDrOIqD174KV8h+W6aY7Odytia6r?=
 =?us-ascii?Q?tkCd6Zr1YoCi6RXniwoRk2uRUIyK5vQvEzIuZr3ZUWR4K/71VtEvCE3HykPK?=
 =?us-ascii?Q?wdFnnROJkRvrJom+Ahb0MySD828DVn72zvxufdCwPL06Y6ju9mY06+AsG1Id?=
 =?us-ascii?Q?vz1gAGypRAQt2exFNkyfn4Rkb/pLoeA6Rxz1Em2TDulRiZr838ErxIwbhrps?=
 =?us-ascii?Q?GFNwsdKOVc3jwfJY7sfGsv6sGJ3rxFeZJMgI1urU4Hjp6KXfBkJfqGE57hKb?=
 =?us-ascii?Q?X+G5QloTzeYNC7tQ+HbGX683NIzVMr7nXMZF03RGppMTfTgzamCxCDCPN+/Y?=
 =?us-ascii?Q?5lU+N7jMfc00Hbt8+pfLoyUm6OC0iTGWqxVQThm2lOq0mLQQ73ejieJGTTFD?=
 =?us-ascii?Q?T765Nn9UlpRg43Eyyj8QSYgYezYdoR1e9gGP1k2+tn8Ruvwa2whCZzzKWBqj?=
 =?us-ascii?Q?EywHIaojWoxMezB7kRpmBPGsOr7d9jAs/jeTDndKDguDqMaJr/fahqwR5fZK?=
 =?us-ascii?Q?C6RJPI6UfGDOfrw2QXJGSsy2Q03XGIdTqPrmvDjB5UUDcVL7U1KNrz6iha9G?=
 =?us-ascii?Q?Isehi+XZx46TztkSmnzpC3sQT6+ASqJVGRcwg1vf3/vM9AUP2S9cGXrWUwmE?=
 =?us-ascii?Q?biIiA4mt7YMkpXAGz4xbYg+zJDRtZiU47jRrNiJ27cQu8AT7mBGrfWYfCnQp?=
 =?us-ascii?Q?n655U+LXEosXq9xCxUKf1mVvlX2NxuLhhqahxUeV8fSEZeSe/hkTxo+SVN05?=
 =?us-ascii?Q?WzbzhKztSStL0nMFnfnFbDwRO5hNpaJLZKxal+tfngJNeQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RBUi/RajQJxAnfm+JmYN9Dy6kylt3ppdHxreZa8OdthiazacEWIR66yPME7p?=
 =?us-ascii?Q?CbD8IchWvvmeLNDXNwjUD0BxBxdMizMGfzPcAiUaCvFbqYnD6ZMrAs9mHASf?=
 =?us-ascii?Q?Qz6o48ROlDABPYRrC2l4k1s56FUO2BKPcI/D1mtC/3TkaixBcmH1aQrBesqj?=
 =?us-ascii?Q?766KoCOh/ad1afcpkbyO411fNS1FEZj5sivdCHemKBHGQZqfQ4idH3U622T0?=
 =?us-ascii?Q?rqTy9IPup0hSA4ZJrYx1j0RHuy+NmT08rYTccaCFOA3etuLksf3r976yjDdJ?=
 =?us-ascii?Q?2Ln5mw7Z/eGt9CkGH/98JvxtG1On78oJJ1hWW6avDjLVRq/ORMnl1CEovM77?=
 =?us-ascii?Q?7NoI8uU/s3/cSJC66hRGviQzv4kE/WZXb9S0ImBxM3MG+mJ5dRDSsfLqttJ2?=
 =?us-ascii?Q?WOXlvmL9w28GqWM4qDgpm6VLa3XS5cY9ZNe8OUxZ0U6yk9EPXj13HUj71YKQ?=
 =?us-ascii?Q?Rj+9+Pej0RtSuKA7/vAq+zkKcekyND58QZ/cdHK9gTYci8SrPMOF5tMiIKGq?=
 =?us-ascii?Q?4xO9oOqUK0dabsQz3abOfN6p83xeKZy31OmhjYg+eijcAO97miFyDOpirgHq?=
 =?us-ascii?Q?KmlgRV1ruSmuOWuecRp2wWE3lQutqqkOWKciZVu80te1O9UC9sE8u1u4fR//?=
 =?us-ascii?Q?3/riEsGIjvnXQ4MJGOnMyxYTkq3XL06PR/Pv1OhGDF/2K+/u7gwepqmj9KKN?=
 =?us-ascii?Q?6L525Fkcum4SlrbJxNvCecuEr0GDDm+OKDFA3xyFkwmw0Ou/m6s4NqQGxK9w?=
 =?us-ascii?Q?Ib0Vnc6tLjGhWrLx2uxQiYeVLO1NX0CbnCQJJZrCEJtne7bi+YUQ7a7HdgtU?=
 =?us-ascii?Q?CfDCgKW2Ja6/um/5IRO7omQK47vqEJMIZgADZmh4VWYdaJNlEh0UiFnb8D1C?=
 =?us-ascii?Q?DIr878JdsdSirwFGYnedrBuVKsMVBfx1Px2ZCx2cBisuv02+5DDdZh2rCcfW?=
 =?us-ascii?Q?JhuRiC2ooEMcRtXzlh5nFsCYSpp7/Di1gCrUYsBWgUMnVptzzZy567BN5MYB?=
 =?us-ascii?Q?mNWVxbRKMuHp60PTBx4LXzFuy2Sgre2wHMC8c32OsSsfoJF3ZlVXRLgq+er5?=
 =?us-ascii?Q?sPE4IhBQoUKtRKJEl/TNS+H35IKdFlzK+zsDYZI19Hj6y263jv+Jh8XT9vj9?=
 =?us-ascii?Q?ALCDNHLrXmW45+tUokjNeoXXbk30GsTmIiOOoaIxVU1OqPdlgD3YEewLDgD6?=
 =?us-ascii?Q?BVBrY5yRMqScPgTTq4payqsAKUYzBhBoa6FHlqIShmDw4uw4Zw/a7yNFhsf0?=
 =?us-ascii?Q?9TrXVV3/D5BC2CzZd6H2344QDUUcsHtF9QxFZCrQPu5sMmD1mbE0eR4H6eBd?=
 =?us-ascii?Q?IUHoagr/IyXwPzF0/Z/8kuZF2lXalKTSTGBwB6iIhrPkO2IoTFYUPb2lnuco?=
 =?us-ascii?Q?MQ6ImYTzu5sIucTaVQAEy0P7yBaANbm1MzO3aDp23lRAAW692KT79b2hKz5i?=
 =?us-ascii?Q?2jxbwgRwuRVaOqC+0ydbwXDO2Qgb1qVrFK7z7GL7qYc8w2cnbcOzLcaUUTMp?=
 =?us-ascii?Q?qrnRsIYjHfbmh5Vs5cC6r2DUVR+Adboshusr60vwzgYjb2UC/eyQhWig0hi4?=
 =?us-ascii?Q?LRSegoDrjTA2EKRWFSGORaSEeOrbTOQ9lprD92haqnwiPrd5mA9eIn+xCykx?=
 =?us-ascii?Q?Sg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 338296a7-91c8-49ac-bf0e-08dd454cbc46
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 18:50:03.6378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P57TiUdJElxPNjcaIzbjA1Q4qJfHsI7Hiv+W8eitX7QJ41NzWFE6x+/1fnAIswuSeB5jbHocs3BjY+TXRUFgDpOlwvFnD2o5fap/zJbInXc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7282
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> Hi Dan,
> 
> My only real question in here is whether the ram partition must
> be zero is worth explicitly optimizing for.  It reduces
> some chances for code reuse.
> 
> Either way, this is fine.  A few other tiny things inline.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> > Link: http://lore.kernel.org/20241230214445.27602-1-alejandro.lucero-palau@amd.com [1]
> > Link: http://lore.kernel.org/20241210-dcd-type2-upstream-v8-0-812852504400@intel.com [2]
> > Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> > Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> > Reviewed-by: Alejandro Lucero <alucerop@amd.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> >  drivers/cxl/core/cdat.c      |   15 ++-----
> >  drivers/cxl/core/hdm.c       |   88 +++++++++++++++++++++++++++++++++++++++-
> >  drivers/cxl/core/mbox.c      |   68 ++++++++++---------------------
> >  drivers/cxl/core/memdev.c    |    2 -
> >  drivers/cxl/cxlmem.h         |   93 +++++++++++++++++++++++++++++-------------
> >  drivers/cxl/pci.c            |    7 +++
> >  tools/testing/cxl/test/cxl.c |   15 ++-----
> >  tools/testing/cxl/test/mem.c |    7 +++
> >  8 files changed, 195 insertions(+), 100 deletions(-)
> 
> > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > index 48b26d3dad26..ea4e792f789f 100644
> > --- a/drivers/cxl/core/hdm.c
> > +++ b/drivers/cxl/core/hdm.c
> 
> > +/* if this fails the caller must destroy @cxlds, there is no recovery */
> > +int cxl_dpa_setup(struct cxl_dev_state *cxlds, const struct cxl_dpa_info *info)
> ...
> 
> > +EXPORT_SYMBOL_GPL(cxl_dpa_setup);
> 
> Trivial but other exports in here are explicitly name spaced. Does it make
> sense to relad this one?

This was a concious decision to start distinguishing the symbol exports
that are between drivers/cxl/ components, or exports for CXL specific
use cases (like insert_resource_expand_to_fit) from public exports for
the wider kernel.

So, I would expect any symbols that get "promoted" to public usage in
the Type-2 series also drop the symbol namespace and are audited to not
assume a cxl_pci driver calling context.

For example, this is why cxl_dpa_setup() takes a lock where one was not
needed previously.

> 
> > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > index c5f8320ed330..be0eb57086e1 100644
> > --- a/drivers/cxl/core/memdev.c
> > +++ b/drivers/cxl/core/memdev.c
> > @@ -80,7 +80,7 @@ static ssize_t ram_size_show(struct device *dev, struct device_attribute *attr,
> >  {
> >  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> >  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > -	unsigned long long len = resource_size(to_ram_res(cxlds));
> > +	unsigned long long len = cxl_ram_size(cxlds);
> 
> Belongs in previous patch perhaps?

The motivation for including it here is that this is the first patch in
the series that makes to_ram_res() start returning NULL when the 'ram'
size is zero.

> >  	return sysfs_emit(buf, "%#llx\n", len);
> >  }
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 78e92e24d7b5..e33b2d5efed9 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -97,6 +97,24 @@ int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
> 
> >  
> > -static inline struct resource *to_ram_res(struct cxl_dev_state *cxlds)
> > +
> > +/* Static RAM is only expected at partition 0. */
> 
> I'm not sure this simplification is worth it.  After all can define
> a helper if it is useful to have the to_x_res functions and define
> them in terms of it.
> 
> static inline const struct resource *to_mem_res(struct cxl_dev_state *cxlds,
> 					        enum cxl_partition_mode mode)
> {
> 	for (int i = 0; i < cxlds->nr_partitions; i++)
> 		if (cxlds->part[i].mode == mode)
> 			return &cxlds->part[i].res;
> 	return NULL;
> }
> 
> static inline const struct resource *to_ram_res(struct cxl_dev_state *cxlds)
> {
> 	return to_mem_res(cxlds, CXL_PARTMODE_RAM);
> }
> static inline const struct resource *to_pmem_res(struct cxl_dev_state *cxlds)
> {
> 	return to_mem_res(cxlds, CXL_PARTMODE_PMEM);
> 
> Or just use the to_mem_res() throughout and drop the to_pmem/ram_res() helpers.

The to_*_res() helpers are only transitory to unwind the
partition-specific logic in favor of generic partition metadata. They
are gone in patch6. Also the hard coded expectation that 'ram' is at
zero is less a simplification and more documentation of device
expectations.

> > +static inline const struct resource *to_ram_res(struct cxl_dev_state *cxlds)
> > +{
> > +	if (cxlds->part[0].mode != CXL_PARTMODE_RAM)
> > +		return NULL;
> > +	return &cxlds->part[0].res;
> > +}
> > +
> > +/*
> > + * Static PMEM may be at partition index 0 when there is no static RAM
> > + * capacity.
> > + */
> > +static inline const struct resource *to_pmem_res(struct cxl_dev_state *cxlds)
> > +{
> > +	for (int i = 0; i < cxlds->nr_partitions; i++)
> > +		if (cxlds->part[i].mode == CXL_PARTMODE_PMEM)
> > +			return &cxlds->part[i].res;
> > +	return NULL;
> > +}
> > +
> > +static inline struct cxl_dpa_perf *to_ram_perf(struct cxl_dev_state *cxlds)
> 
> Similar. Is it worth position 0 optimization?

Again it's less optimization and more documentation especially because
shipping tooling embeds "ram before pmem" assumptions. It serves as a
cheap early warning system if a device under development breaks these
assumptions.
