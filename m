Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD4120485D
	for <linux-cxl@vger.kernel.org>; Thu, 10 Apr 2025 07:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744269146; cv=fail; b=FHOD28kTl4CVr32TPwlbN2nUCskh6nGgEH4pG8x8ZXsvlIoBdEqDErmBZOU4CMqj9EzhE+IoKj8agnDIIsBvl+hG0OANJ+EFt/qAuzdKCns/5ANuXBVz+1FxvULfp0aweGXsMMeobBx1fHKD6xvtPjhe/shomV1ULDp4RRaLZiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744269146; c=relaxed/simple;
	bh=4TzEql+57xJDrVcRYxCGDGdUmoz1utX+248Ac0cK8+s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FvcaUh2Ekipapz6YB0vlU96mmmXO5ZhYmltPAMFsPmM3rOxMbgQKZ/Ko3+izMG8YDIChZ+o0h+MtAPZbt2acivFYrj3E+3GDb6e2LcbtB2UWP556/PS7NyXy8NsX3Ab65ofjQWK9pF6BhVuvuSALlU7R9HwGpGgcT8RA3IVnQ5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Do32GKMK; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Do32GKMK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744269145; x=1775805145;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4TzEql+57xJDrVcRYxCGDGdUmoz1utX+248Ac0cK8+s=;
  b=Do32GKMK/a7haQaUl8sbKViT29LkbHSwN3f9jyPGXKyq66P4PstUiQzV
   Qb+8x9joysBy2dMYsP3ikYjobxerL/6enJ/poYfq8W7dIaGWAVpG5uH56
   0DuPtxuwWJqBB2UN7Hxe89i5Xy0aBFMeN0h/F3SFo7LG7SxW/NGqJK26N
   E5Ic+Vpdp7tUj7imT0EkhBWJAgiDn2fHD5mChEg6c+REJRahDLgA5cbSg
   RcMZp6UrELUChZsPCohAPytOAGa30QcHvGZanoq5xPjYhKlkDErrtIAnQ
   OnpVnuBtAax05Dm1+IbBt4F440FlzEcsTUYfrxsmqfjaUTyM2XH/39Og9
   Q==;
X-CSE-ConnectionGUID: UJ6uVWVCTNKdRQ6izQVmlQ==
X-CSE-MsgGUID: 3GXQTEfFThehAKxkyzDi8A==
X-IronPort-AV: E=McAfee;i="6700,10204,11399"; a="56438254"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="56438254"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 00:12:24 -0700
X-CSE-ConnectionGUID: kIQYWEv8QzusxPedokG7tg==
X-CSE-MsgGUID: OAmWwn67RxW/EUK8HJ7rOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="166028011"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 00:12:25 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Apr 2025 00:12:23 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Thu, 10 Apr 2025 00:12:23 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Thu, 10 Apr 2025 00:12:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KN99xZsdNtsTuZSQ3DynVO8fD46KSOkqchWqMZpr2MhwKVZ9/ok154VaUMjEfjrN1Td0s7qwA9+UWmZSqcXa8oC27rvJV8s5FzVn5OVFkC2TACML6JDz6dFRSXZ3+qgJzBxDl7/7yMiDTojMEwJcJ1Ex+l/bV33HkX/ZOi9/nk3CTa96Q/8Ny4FYBCaCNGteNSCi/JLgFlz68n5Fb/ll1L/cwazCt9bD1JEntO2Ozq971NtdoajjVC8HAS6DRtymH7BJWaQr0lzyg6wCTkttvQ3DDCU30NeiMP9A34qltLKcMEjFSuUa0lyOkYF0oBmijCtOSneCUD4J7vbmaRMc9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s89D/Sin59xtUe4ADLcvdn/O2Fzsulnn1V/HbAf3tlo=;
 b=q43lTB3y/IhK/BY0sbr76OHmfI9Zzs1ZMkgK5PGiDh+7321THDG9vkCuFD27UNdsPIPH/TA/pnu50IqXq+lBd3DDvYikhr4lCk3JeWE2h/hDVp9dyOrz9tXGCRRXvMA7dPeB8R6p3JYjEnLVK4aFIp5o70XC/QgCNkBJHbzRXVwYMPq7BfYDX1WUCW2Yu5VuKkE4rKDyM+4kHyEBgYCHkCLRuM5BBRp5P8e6iqHYrdl/DBqDl/vyWXTGXUeXNI9+gmqixEF0AtF3OIBs+iIbH2QpqbTEltJ/SiqnJLhBs8KdTAFz9qzipc6lU6G6j5mBDyW+/Lj5un55njcIzifXNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7458.namprd11.prod.outlook.com (2603:10b6:8:145::13)
 by MN2PR11MB4646.namprd11.prod.outlook.com (2603:10b6:208:264::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Thu, 10 Apr
 2025 07:12:21 +0000
Received: from DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::1a9e:53a6:9603:8f79]) by DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::1a9e:53a6:9603:8f79%5]) with mapi id 15.20.8606.033; Thu, 10 Apr 2025
 07:12:21 +0000
From: "Ye, Huaisheng" <huaisheng.ye@intel.com>
To: Gregory Price <gourry@gourry.net>
CC: "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>, "Williams,
 Dan J" <dan.j.williams@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>,
	"Jia, Pei P" <pei.p.jia@intel.com>, "Du, Fan" <fan.du@intel.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: RE: [RFC PATCH] cxl/core: reenable Mem_Enable bit of DVSEC control
 when RR decodes outside platform ranges
Thread-Topic: [RFC PATCH] cxl/core: reenable Mem_Enable bit of DVSEC control
 when RR decodes outside platform ranges
Thread-Index: AQHbpubq+9CWdaenhU6/yZQpccJG97OZHTmAgAGNdoCAALdegIABHHqQ
Date: Thu, 10 Apr 2025 07:12:20 +0000
Message-ID: <DS0PR11MB745835BD29A7A12C3AA3A0A49FB72@DS0PR11MB7458.namprd11.prod.outlook.com>
References: <20250406112752.1261855-1-huaisheng.ye@intel.com>
 <Z_SWjQA4qb3OE6Dk@gourry-fedora-PF4VCD3F>
 <DS0PR11MB7458325CE975067CBD63ED3E9FB42@DS0PR11MB7458.namprd11.prod.outlook.com>
 <Z_Z9yU_kWkWRp8YJ@gourry-fedora-PF4VCD3F>
In-Reply-To: <Z_Z9yU_kWkWRp8YJ@gourry-fedora-PF4VCD3F>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7458:EE_|MN2PR11MB4646:EE_
x-ms-office365-filtering-correlation-id: bea9bd58-390b-4500-082c-08dd77ff092b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?qKKvJB5qnM0LBlHltqxZ4smmmPqeF/8yWlzrOKxK+Uh2Li+C9+Ces0siYByq?=
 =?us-ascii?Q?bB8BkOb+qurjHbuWUdWiE8/if+D+qd9WYHGbv7p+txsxWW6YGiBgLICWj2kF?=
 =?us-ascii?Q?7xCgAjuRn65nJ0lgG5ZwoP1npJxfU4PSI5f0e4vOVZflmZpLgaccKFkCDa0V?=
 =?us-ascii?Q?x74YvfJkxiT2pzEDoE5VFTchtpE0KLZIWCmCTese0D2jrRQH2T4IUIAMzn4D?=
 =?us-ascii?Q?2KQAwo2nYQduNGJHoVIvar+YQ3msjeFeoRny+uZZWyenqeFiYagAlNtCe+W7?=
 =?us-ascii?Q?jZDAt0FF/vhrPyL0KH5d25blMVdlfzMnH5qfUMyxPI6NsyTgaDYwDg9Zno5W?=
 =?us-ascii?Q?CZWt9rdTr9W0P8pJArhORMNNZGDj+ltcFST5WhvgcpzEaSiwM0TKAJTtcDOt?=
 =?us-ascii?Q?SygRjh1PRAu1+FH2EE+anxXW+qloO5dtFSkjPbetewP0MpYwoB+rt95Z2TWG?=
 =?us-ascii?Q?t2G6asES0LNZeNk2HcFXjj2aElMd78KSmZY8UtbIj5nG/7t7KaM4GemJYCK6?=
 =?us-ascii?Q?HuCm307AloXjwEDKLGvD+ZuSCDnko4u0CwAYitLI68dmz79QWjuI3QC7+HsI?=
 =?us-ascii?Q?uooVDdvEDl04zWOtWE6Qp2oDNjAORzEDYZRY4gzvEjQ+py7ih4Oq4B95sERv?=
 =?us-ascii?Q?Uln4+tTQnbDPmaHM05UJUI9EhFDx4NAWfWAwktAQgkL+NaFkjaBncPYDW27t?=
 =?us-ascii?Q?txFJNQ775J8b822mi1TnnKyT+JVG4MOiZiAQkay6jSenuiFGYdXo5yNZcFQW?=
 =?us-ascii?Q?9ragW6bhZClSmD/dA2VdQkiKHLP0B4MEyBQYoOfWO8wQ/q7H0IinWURltaNJ?=
 =?us-ascii?Q?jAk7B5JLvrodtENLUatyiU4wrFTDe7PHvOsBABRPoOoITQr96ieJUtHGxNEo?=
 =?us-ascii?Q?1SfRar3QgjENlRv1Q1BjJDXP+VNNUvtTTN+G9qWAG2jpbKvmbrnW7g5m0s1r?=
 =?us-ascii?Q?sqcqGWVZ9S42cWRRdtWEwAMg8Oko0UPEFzpvj1XvuR31TC/CS4ljFnNto2iP?=
 =?us-ascii?Q?Sx/QZn87P37DC7yYbU+hwq2cw2FT4s38PWdp0GFE/J2+GDGFb6TXOW8VKQSJ?=
 =?us-ascii?Q?ZuQl51thIA14rnpp5IHbO5CBoXKja/cCIm4wzR2ShzqOJquAFqpVG8tEiHnz?=
 =?us-ascii?Q?R4qLvTVtKPZ5hlsdXg3YQqpqCCQTJfJWn6n7OB2T/Fd23rpqrV9ThY3b3AqQ?=
 =?us-ascii?Q?PCmF/HD/wcgiBvrA5pDOU4xY908wAV8+drxsA6dc/viJ+w1FKO3pMwnEK8jG?=
 =?us-ascii?Q?aaE/CW68HGKRywif4gVcYb+PODjLWHRXOLYcfGeXxPEMRVCWxXKSJo1U1BAz?=
 =?us-ascii?Q?z0bRrt/F7bxptBolXgfGxJ3aWZ2RgvFwL1fUA38IW3rUh0HRhl+m73K+hxnB?=
 =?us-ascii?Q?fpFGalP5hGsZ6E2+puTI3Pq75mXUgDTg43EhT+lwn1dFjcpuJp0EbwW5C8Iw?=
 =?us-ascii?Q?7GU+iqhoUApMjDX02W6w2czQ4gNFN6TaHpgwy0HvicFqVBzhnal65A=3D=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7458.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?OwH8JYH1eGCD4B6RIQkLuKvF+7hKM8i6EHEfnbxId+HCVyiCj3G3d/41nKbh?=
 =?us-ascii?Q?dmnYTtW0FFNtPKmwJomqC9kgfbPFriTBzqthdPLtrxDOMDmfgph4b6InidDO?=
 =?us-ascii?Q?Z11VW0PUjF9VlJtqplCGl29ZO4leDBs8cLgZTja8qfqAcoOVKCF5ipBYUPk/?=
 =?us-ascii?Q?f13xhfbaF2UG7wfLT9dK2WprnRkJ1LyLmfgLeo/xz6o9EnJ52LZpcDVskPK+?=
 =?us-ascii?Q?pFlmEjKEhu9SDsDQl1w2CCJoUX4fgaW5T2KsQZ2XGVG/O1CF6dvWDOrpBvNV?=
 =?us-ascii?Q?1MFnQXMliUmnUAVSj3hZ+Q5eqqT0oFzgyjNB1/WYidorFeiqv7Mnq2IvLdS/?=
 =?us-ascii?Q?LTx6TlnyCFPESauBonvT6FYqTl93qKzPYsxB68hEg+0bSVTxpbUwTGUuci5H?=
 =?us-ascii?Q?kBcRw5b37ny3VlflBhdV3V2oV9Jbadr5K82GFTFiBXD4uJ4lAeZjMUI44YNI?=
 =?us-ascii?Q?AW2anjJuYJcsT3uk9aIZUXPPpy31IkSNTCNwNU8e74U2sd/8jxwdyXm+LeDG?=
 =?us-ascii?Q?PBZpDypHHVup8Nx1Cs8HZfHEmUmWnDZoHPesDBXKCCVpkiVpHN8MfUNNx4oR?=
 =?us-ascii?Q?8PADcCdgDj6bd5bdlK29OwCfgXIAf7Vw/y8PdKMssWM5OvVhvUbO5zOjkwJJ?=
 =?us-ascii?Q?laIOME+9d8I7ZRzOHKiGCuFWg3C9ihoIEldsIuiR5RvO3lJ65Sx8T6wTbeSt?=
 =?us-ascii?Q?6LW75oqxU8FXtwehRUv1qQoqBqmfhgHIBjiKcnpkHu40cr5aXM/d0L7KA53d?=
 =?us-ascii?Q?aZN2l7XCVvgUaJI7QzJ6f7v34w9hSb9T+6i1I1tsVvr2NHz9loDX2SVUmbHE?=
 =?us-ascii?Q?kel8f68l3kQzaAzrtuIf7DzXiIbdwDeppTbfeLAcIqInp5DgdgljqccjM5jZ?=
 =?us-ascii?Q?M3IundXG+h+/Vb7hs5Ey2BCrsdg6JcXnAwnrvDCgRTxn91WEiwKaryZpU4lC?=
 =?us-ascii?Q?k9f61FpPhbLKKDF0p+CGAXb65gqmxRw7a6aom7U6wzTzDXwnvtghL3tdQPtn?=
 =?us-ascii?Q?93OqRpR8bEF28bFSptdvtzj7Lzgzt8WzICK6uXwrIiHyoCEYq6Fx9FnNV+eU?=
 =?us-ascii?Q?uwrQJX9H/wWRMvGYEmKgYLp8bY/Y5XuK+HM1Lta/MfnyhXd1U5vEQk95XhMd?=
 =?us-ascii?Q?0mzvHSYz8SqLMhpxAxpmSWuYKwsPQCLx4dlnVJkFluFwyqI0wyuFwgQJopU2?=
 =?us-ascii?Q?OizNcItK5l4I4RDU5/v7EfYD8cduh6MEy3LiDqTXfXeqQJ6vHeZAlbYsvoji?=
 =?us-ascii?Q?dr8FdxlTpU/MLQDlsrhItjUNGHyi+2LaHL+wtpmTqlzQ96pkFdwY3yLjWBBN?=
 =?us-ascii?Q?ZX/yuOwbHEewU61gSzjRlHwCz4l/icWHP301TLXLrudFE4WUdlj8O22VVFGs?=
 =?us-ascii?Q?/5mmP14Ofq3HwTmWL4lyrtFxd/jYUw4VgfqMmsDYWsZKM6+zlnmEqcaznPLH?=
 =?us-ascii?Q?DKKvXeYv2hypZHK5vUDa+YPfhODQYTNbCTCtV5rgOgx6Aww6J1Z5vbeuEjBh?=
 =?us-ascii?Q?ghr3x61XTF+wfpa9lAiYRVCzqUcVFLs+ylFnDZxgHnxJDzpFE5TPHhz1ByGP?=
 =?us-ascii?Q?8whwjJJoXBtN7PMyeZOn4fUNVZpBYI6HLNTXBd6T?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7458.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bea9bd58-390b-4500-082c-08dd77ff092b
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Apr 2025 07:12:21.0018
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: N7rFmiaXpo5/awEOvfTogCL/iY+auEDIIQXooNNEA4JBJymRdsl+mk483ySnqyrcMZq4klweFj/99IPtYqzuvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4646
X-OriginatorOrg: intel.com

From: Gregory Price <gourry@gourry.net>
Sent: Wednesday, April 9, 2025 10:02 PM
>=20
> On Wed, Apr 09, 2025 at 03:48:42AM +0000, Ye, Huaisheng wrote:
> > From: Gregory Price <gourry@gourry.net>
> > The phenomenon I observed here is that the content of RR is incorrect, =
as it is not within the
> hpa_range of the root decoder.
> > Here are the debug messages of dmesg from site scene. FYI.
> >
> >  [    7.683508] cxl_dvsec_rr_decode: cap =3D 0x1e
> >  [    7.683535] cxl_dvsec_rr_decode: ctrl =3D 0x6		<-- which means CXL_=
DVSEC_MEM_ENABLE has
> been set by firmware (Qemu)
> >  [    7.683557] cxl_dvsec_rr_decode: range0 base =3D 0, size =3D 214748=
3648   <- endpoint's dvsec_range
> >
> >  [    7.761781] dvsec_range_allowed: cxld->hpa_range.start =3D 11005853=
696  <- root decoder
> >  [    7.761782] dvsec_range_allowed: cxld->hpa_range.end   =3D 45365592=
063
>=20
> Are you interleaving like 16 2GB devices?  Because the RR here has 2GB
> of capacity, while the root describes 32GB of capacity.  Just trying to
> make sense of the configuration here.  If you can share your qemu
> config, tha would be helpful.

$ qemu-system-x86_64 -machine q35,cxl=3Don,accel=3Dkvm  \
        -smp cpus=3D32 \
        -m 8G \
        -hda /home/work/vm-images/centos-stream8-02.qcow2 \
        -object memory-backend-ram,size=3D4G,id=3Dm0 \
        -object memory-backend-ram,size=3D4G,id=3Dm1 \
        -object memory-backend-ram,size=3D2G,id=3Dcxl-mem0 \
        -object memory-backend-ram,size=3D2G,id=3Dcxl-mem1 \
        -object memory-backend-ram,size=3D2G,id=3Dcxl-mem2 \
        -object memory-backend-ram,size=3D2G,id=3Dcxl-mem3 \
        -numa node,memdev=3Dm0,cpus=3D0-15,nodeid=3D0 \
        -numa node,memdev=3Dm1,cpus=3D16-31,nodeid=3D1 \
        -netdev user,id=3Dnet0,hostfwd=3Dtcp::2222-:22 \
        -device virtio-net-pci,netdev=3Dnet0 \
        -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 \
        -device cxl-rp,port=3D0,bus=3Dcxl.1,id=3Droot_port0,chassis=3D0,slo=
t=3D0 \
        -device cxl-rp,port=3D1,bus=3Dcxl.1,id=3Droot_port1,chassis=3D0,slo=
t=3D1 \
        -device cxl-upstream,bus=3Droot_port0,id=3Dus0 \
        -device cxl-downstream,port=3D0,bus=3Dus0,id=3Dswport0,chassis=3D0,=
slot=3D4 \
        -device cxl-type3,bus=3Dswport0,volatile-memdev=3Dcxl-mem0,id=3Dcxl=
-vmem0 \
        -device cxl-downstream,port=3D1,bus=3Dus0,id=3Dswport1,chassis=3D0,=
slot=3D5 \
        -device cxl-type3,bus=3Dswport1,volatile-memdev=3Dcxl-mem1,id=3Dcxl=
-vmem1 \
        -device cxl-downstream,port=3D2,bus=3Dus0,id=3Dswport2,chassis=3D0,=
slot=3D6 \
        -device cxl-type3,bus=3Dswport2,volatile-memdev=3Dcxl-mem2,id=3Dcxl=
-vmem2 \
        -device cxl-downstream,port=3D3,bus=3Dus0,id=3Dswport3,chassis=3D0,=
slot=3D7 \
        -device cxl-type3,bus=3Dswport3,volatile-memdev=3Dcxl-mem3,id=3Dcxl=
-vmem3 \
        -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D32G &

Usually, I prefer to use 4 * 2GB cxl memory devices with x4 switch for debu=
gging.
This defect happens randomly but exists for a long while.
Once it occurs, only a reboot can solve it. It's annoying, this is the moti=
vation for sending patch to fix.

Best Regards,
Huaisheng Ye

