Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540A010E3
	for <linux-cxl@vger.kernel.org>; Wed,  9 Apr 2025 03:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744170570; cv=fail; b=T9lK0YYBNCUPAWRx2tbzM+lYeMEBgERZwvpzgTnCU2ErgulPvQHugsHWAxiH/uhroSumUXHy0ypmWrCQNj1oHk7o5MG3JanWzriCD8SHfd/DgN9fc54DmBbdCj84I+bpjYTWCoC2sFgj5CnhdTNVdE41r4taZ3VDv2xF86Z1wQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744170570; c=relaxed/simple;
	bh=KmpwjBUFIUUdaAsbQx6xCQaJjOgnHb8AjS94OjMKD1k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EZbSVZFDeMqqqrFlzicCEkZS2wiBxJelCWfv/B4KTU99YvvbE+Hnss02CFuSHb1u6r2yufdaxtojrF7ffADUqLMw7rQnqs2h2Kq4m96Emwh1xd1IgeN39ptCWlJUvaeffeQo0zQike0CEVopCvqp/pRi+NIxRKHli0RGHZfUYrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D+Wc3XWa; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D+Wc3XWa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744170567; x=1775706567;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KmpwjBUFIUUdaAsbQx6xCQaJjOgnHb8AjS94OjMKD1k=;
  b=D+Wc3XWaCDR2MR7bbhiGQARxjYBF8Myzbg9fhBNZHGYLpAlTovnHrEiU
   lHcvMCa9xOufZIyRr9Na3cLrT1aRP7s/GRNKzPdcZxjg3HRAI7j3zSpmZ
   md5SOCZjSJe4/S5EdC0uLjY/EWvLotXrpdvvje//+zJU04hiaY2ojY6iX
   ZwZZy+KFdLuSqZYjRLz3KzThAVTcMiAkj8ILUEiH0vvJvohEvRax20LAX
   w04mwRo1TBEzALYHb2IhiQOasVsqdpw8STZXE5993/++ykZEgrcFPU+pP
   oGXAt9Rm2QnboPxKvhQUndoh0d1FrCYTzuHtcMNCWOkxp363D9PKCGzzt
   A==;
X-CSE-ConnectionGUID: ol8Q32EgQR2Svjydahj8pQ==
X-CSE-MsgGUID: LbcVBQAmQGe1gG02rQ3ufw==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="63171268"
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="63171268"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2025 20:49:26 -0700
X-CSE-ConnectionGUID: kr6gfWRmStSgcOtfIfs74Q==
X-CSE-MsgGUID: 601yx0AgQzKx+beBkt9kSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,199,1739865600"; 
   d="scan'208";a="133322864"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2025 20:49:26 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Tue, 8 Apr 2025 20:49:25 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Tue, 8 Apr 2025 20:49:25 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Tue, 8 Apr 2025 20:49:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fUquq/bduEDpbeTeAprpP3qiIC7LacEM1Ecr2Uj5Ijk4begL5VRBAeJlpMQcbgytvXPxrKLfbPQgFGvtFNvprPkEahC8ry9VGhiX/mF7QhFmc5/AliC7MxC38UTQ761aN8p++dMGyfjwSE1cMZwKaPnWRwnXT3JVrUimo0ogguwVYUKe7TZ8+9MAXvMjiy594wI+q7XiVQN9sVAS5etYV8fUuJ0madxzfyXV709TssFJrCZb7TpPZCkVLnv4SuJOYA3cnuif8AGYXmDzFiRV2uBfJPOFEljWkPNkaLur0omon7IRlS7l7atKGM9R6NhjCy8kGpwZHcDaIVbfvxNCEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2pJu+EMb8PRKZdQKbDRHT4X6X0rGRjxskwf6CDgNEs=;
 b=lAusMqyBCE/oI4PxFWbIPp74XpbPtZX7tQiBtT6pGjEyBGMNFT3fCZ90qDFAkcVR8lbulKpLSr62avZb1hEa2GwToYWR1haE9FjFEYVVGhJXR0W0oRkyMgxykrZIyobgvhy03QFpBKFCxq3G1oH1Tx+EGC4t14OJmhkp90qNlzbDi9RvemBqQGn0Rzu6TUthTMTBjn/FfBe4MKNMgll7PdzYN38cNXAtvNt7VuMrxh76nB7Ua9xZCKxnTJzYIO79hMdeBWuyVUQ7e8UTxpA42ZUcKoz1QAcxk7cXw0oYHBxLagkzxkwRm2yi7eUOPbYIKBsmenm4c8gokH0GdKjCtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7458.namprd11.prod.outlook.com (2603:10b6:8:145::13)
 by PH7PR11MB6054.namprd11.prod.outlook.com (2603:10b6:510:1d2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Wed, 9 Apr
 2025 03:48:42 +0000
Received: from DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::1a9e:53a6:9603:8f79]) by DS0PR11MB7458.namprd11.prod.outlook.com
 ([fe80::1a9e:53a6:9603:8f79%5]) with mapi id 15.20.8606.033; Wed, 9 Apr 2025
 03:48:42 +0000
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
Thread-Index: AQHbpubq+9CWdaenhU6/yZQpccJG97OZHTmAgAGNdoA=
Date: Wed, 9 Apr 2025 03:48:42 +0000
Message-ID: <DS0PR11MB7458325CE975067CBD63ED3E9FB42@DS0PR11MB7458.namprd11.prod.outlook.com>
References: <20250406112752.1261855-1-huaisheng.ye@intel.com>
 <Z_SWjQA4qb3OE6Dk@gourry-fedora-PF4VCD3F>
In-Reply-To: <Z_SWjQA4qb3OE6Dk@gourry-fedora-PF4VCD3F>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7458:EE_|PH7PR11MB6054:EE_
x-ms-office365-filtering-correlation-id: e7020a50-cdf7-47e5-3912-08dd77196c06
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?BDRV7JyRKc+zuAd/GkqPiSDpahfn/bh9COBCFXanJYTlcwCPPJxs5zaHw2lb?=
 =?us-ascii?Q?Q9RCvpnf+HzMW0Edr7WRC/ShbGrjWc8tEzqur6ACAbV0gcFg+RnZfnicU2nW?=
 =?us-ascii?Q?ngxFHBo1rtxirA4VwEw7g6EaBNHiiv3LI9E+p+pFyQO8V+UEBR4UMetdvr3m?=
 =?us-ascii?Q?AjQtUAyH73topt+WBiYZamku+z1tto9EZs64KpEVS3V+6xTiEPp6G2WLmEC5?=
 =?us-ascii?Q?h6hZ6N0NrGREeTLiOkuROfOf0X38KOJXNrglyAHWRObxvRZ8R/i2o2fujbtp?=
 =?us-ascii?Q?89mWBXeBdkJNQ2H5lvP7G8C6ejMjuwBaLS1kUNEUGM6HO2WoMmo6qKoZP46z?=
 =?us-ascii?Q?Ngrw6Wz+0+J2V3NREtQsuH8y9PqH7wku7Y9OIDNhgUaTZLzyHmSBxJYonl6r?=
 =?us-ascii?Q?OeZ5VMVUCbOMQFvk9DIaxuk5pRrN0YHcrs2TsBuqj4Ckbp62dbjZQP8T3uWa?=
 =?us-ascii?Q?xUlSNBkBxPjGeIYnlwaT8UWP1zStL99wNG8iJIAT5XZcE8Kr9R1O0XGw3eJT?=
 =?us-ascii?Q?XQOcSHrnEJ4lD63SyW1x1141VJ/0ffq7vBqquvsRYP2nd1FBNgSQ7PRrkxQ+?=
 =?us-ascii?Q?E00HV8GjP5Hji+TKXkBzMJotMT5Y+7cd357UmF7dxkh0lPKpCJlzxHnFRDEq?=
 =?us-ascii?Q?9WBXzzDiL5dvADvdVE14AePmXxh6bq/VpGqJyYD4a6sU+jar2nXYjY5xbAQ8?=
 =?us-ascii?Q?xXrZyIAkX6/i3NedLfN4x0C7arTuSb+uFUOoH5eLXAjQs7WvzlkgJHoJg6DV?=
 =?us-ascii?Q?uyKkMra9DDoXeRx9RwiYCFC+mBIuD6lLj3piMGWanoO7YsWR2Ue+z+c0ZJpU?=
 =?us-ascii?Q?DOq2JsVoBicfZ/BkcTH3sK+dnBOoBGi/AOn3XAvr/iYfDWMbhLLXdaDy+M66?=
 =?us-ascii?Q?+aiwTaHi064l9SrUHNutB/wDonSGFYeivHzVuzP8QtJYMrp/COVj/sONv/xn?=
 =?us-ascii?Q?fuJbuZ9UXkCgG4nd3MIbIZhdSxn+q4ptxJ2S/ov8q7ReBahhoLzAiN8+Z8sN?=
 =?us-ascii?Q?bo4HNCxV/xr8LqrBcLC+YiV10ttSfxCaKDyQCNx76i/iA/4atKqzb8tycJfu?=
 =?us-ascii?Q?mKOPOgnxBD4q7nD3tdX4mAjcq6USu5+AVhn+fr198DmG5Dn8zRHu6dGEBrdS?=
 =?us-ascii?Q?lVCCpq+sJhNrI8viiuF8pEvcCsbGoAZIcrM9g5yrdYhmbd8KyvI4x2IbeaeD?=
 =?us-ascii?Q?hwODjc0jCaMKxX0nRtlcqFkoCRDExX6568L1LQ4EWJlybqZgqnDk1UPxgUqX?=
 =?us-ascii?Q?2ZxOK6hl60+JB5443MuaYMAF1RIPFmUj0s1H6N3qsqswnCbIv0NfpcqhHEYj?=
 =?us-ascii?Q?kZi7/WWVIuKKQJCtsCm8GGyRMoqDgzDlQ5jRCs/L5teZLmTlKKGS5eFbEIpu?=
 =?us-ascii?Q?l5GZieXzLA0tKqvkCcRUc+GdkHZ99K2DCT70Ket5wzImBrdhus8UN/2+YeHZ?=
 =?us-ascii?Q?tH6yu2Qp9tJ+HOwsqPKxst5i8vBZA36R?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7458.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ijizdOAuoKBEK2MrC6vJAVFKkFPQRNbIzXjsUPJ0OI/kb7iY6Nf9nXZc/DtY?=
 =?us-ascii?Q?iHUhYxdGBJERb51jhjbdy0+YBedSE1xWUygGjCWW9ufr7AxiZlTZZZRYWffZ?=
 =?us-ascii?Q?ABHstZBsX7FlzDWGwQaNSvriQywBnJGVDr1NTLvMVueEFwjkjG91s3LhIKB4?=
 =?us-ascii?Q?osOo9jiVVK4qZ/Ft0+McQgf4bxLWqYkiegw+54ZKASbeYREoJR9tT0xMFhWn?=
 =?us-ascii?Q?977rByjoH+i+9x/gPKiq24QBt2LqAwiuD4iNxzPJo315Xj00GZ9P6gLKd/2+?=
 =?us-ascii?Q?9yvCSmJKDtVx6vfFt28w5bhIHTWMbmShvQo7Jymvwu4kxp6wMotdklz8D9ON?=
 =?us-ascii?Q?mSWchk136gBZc/8OEZu0NDzTQvhJUSj955Qe5tOTRW35gD7Ug9DFOSDIhnVK?=
 =?us-ascii?Q?5KxZL+7w7FSnz9aZKiWFIxhWLxSr4ETF/I44cn/MIWyC3XnEhoQljkBtBAZI?=
 =?us-ascii?Q?kWHAOkQvsadOmnVXsG8kx/BNpGXU6+LX5L5J0LwLeNBNtn9iVpTQA1VZq8Lq?=
 =?us-ascii?Q?Mp7j/IEkfMttT29wqTw1YIJdB/P3CntFyT3bR3tK612gPp67SG0oLn7ZRKat?=
 =?us-ascii?Q?JBDmJo0Jpc2kOX6GSQsPsuLRQdFanIBTJbJNK/iI1b8hDHuFe8rRgDbG6srB?=
 =?us-ascii?Q?rFpMO2cwRk/dZ0HVxzKSQJHZEcyoqtfCXD4qSiSh6FQnqaGpxIDKqevq+91l?=
 =?us-ascii?Q?ghnEezTtRu/VC1JDwQ7rhfNwOeec84J+B+r+7EFFBrsFzI61EZVTzGGgQIyc?=
 =?us-ascii?Q?hasl/kQBbCtgyyg8mqTC1v5PeTtvRoJ345iTo8HPVRTz3yxESemCqBDqoSAC?=
 =?us-ascii?Q?QtuEPo1d83J33T4xpBu5Zqnu5Rf9t9RkKXaWXnWwNfH0wpgJCF3Y4/vsX9Qp?=
 =?us-ascii?Q?tKedgAoNQtPzUqzUInjHE3rBjzv4R+tOaCydNVnn/peXT+0XrlPCjeJV2p+5?=
 =?us-ascii?Q?pCWxUXWOo/o7KBcMbUz1BqjpfUm6BQAvNRnpc1JohzdOo0sJ6rACuoepKBgG?=
 =?us-ascii?Q?BlX2/Z8W2dQXwyKOFKxrk+YDZhDvpm2ejSeBq/JXr4zlHpjWQGJ2SbBOGLWJ?=
 =?us-ascii?Q?n7/accdginOrH7dorQClOsTz+FRcvAFTG0MPnjrEXnBEvV0jOM8/X6pNXG9o?=
 =?us-ascii?Q?00eCBL64keTMcagOolCmKty1iH3Wvr3hnxhTGKY9/AHq1LhZgZC249zg8WaO?=
 =?us-ascii?Q?FQphiInTfYm+P7yOVnuINai9lUlL9sMj1NNFH7MzOgdEJsxD3EqZ1zuYAGfX?=
 =?us-ascii?Q?IFVUO47iAaQ1wZ4ARRQB5mJ/N0BFdZZEPnZXy/CG3HmxMOA7XnIMFZO3hip3?=
 =?us-ascii?Q?6R+Ma32RJnvWw6cLtc2pCMHaeEMQfW7HDQMC4E520husZJeDltqp5s+6E3HW?=
 =?us-ascii?Q?jXQqDFR7H8AtYBYf56Hc6n6BTr0JpbHIaWvRQ4yp1h1Pt5ewPdhCfopDQq7C?=
 =?us-ascii?Q?GM8H5GiEkYBylDfvu1fZ+BffFi/U9WqmrJ/WYR3rIHGF/pj/4mwdQafAk1l0?=
 =?us-ascii?Q?ezxxRpTrLgxEyPD8pmpgUUWYWL+kWX1cGrfDWTsRJfQ3BfI2QCHFHo4z+szn?=
 =?us-ascii?Q?2m30C//jypbrgfa3KFQ0c64x1mt+i/GHLmdBBIRT?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e7020a50-cdf7-47e5-3912-08dd77196c06
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2025 03:48:42.6618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MHkIi/kjrNwdOjsMsVjewE/967dvZMT1u6OcM2XP3TYUQ8Ry42rQV1MNldHgrzcHNt90I9RBDE+IBnF8reVZxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6054
X-OriginatorOrg: intel.com

From: Gregory Price <gourry@gourry.net>
Sent: Tuesday, April 8, 2025 11:23 AM
>=20
> On Sun, Apr 06, 2025 at 07:27:52PM +0800, Huaisheng Ye wrote:
> > In some scenarios, the probe of endpoint ports would fail because of ra=
nge
> > register (RR) decodes outside platform defined CXL ranges.
> >
> >   [kernel debug message]
> >   cxl_hdm_decode_init:447: cxl_pci 0000:10:00.0: DVSEC Range0 denied by
> >   platform
> >   cxl_pci 0000:10:00.0: Range register decodes outside platform defined=
 CXL
> >   ranges.
> >   cxl_bus_probe:2073: cxl_port endpoint3: probe: -6
> >   call_driver_probe:590: cxl_port endpoint3: probe with driver cxl_port
> >   rejects match -6
> >
> > This defect could be found with Qemu CXL branch for a long while with a
> > specified probability, even with the latest branch cxl-2025-03-20.
> >
> > The root cause of this defect comes from that, bit CXL_DVSEC_MEM_ENABLE=
 of
> > DVSEC control has been set but in cxl_hdm_decode_init
> > CXL_HDM_DECODER_ENABLE has NOT been set and also endpoint's dvsec_range=
 is
> > not covered by root decoder's hpa_range.
> >
>=20
> The explanation here is a bit confusing.  Please clarify if my
> understanding of the issue is incorrect.
>=20
> Observed problem:
>    Some firmware/BIOS sets MEM_ENABLED, does not set HDM_DECODER_ENABLED,
>    and does not program the Range registers.  This is possibly the
>    result of defaulting MEM_ENABLED to 1 mistakenly, rather than a
>    programming error / failure.

The phenomenon I observed here is that the content of RR is incorrect, as i=
t is not within the hpa_range of the root decoder.
Here are the debug messages of dmesg from site scene. FYI.

 [    7.683508] cxl_dvsec_rr_decode: cap =3D 0x1e
 [    7.683535] cxl_dvsec_rr_decode: ctrl =3D 0x6		<-- which means CXL_DVSE=
C_MEM_ENABLE has been set by firmware (Qemu)
 [    7.683557] cxl_dvsec_rr_decode: range0 base =3D 0, size =3D 2147483648=
   <- endpoint's dvsec_range

 [    7.761781] dvsec_range_allowed: cxld->hpa_range.start =3D 11005853696 =
 <- root decoder
 [    7.761782] dvsec_range_allowed: cxld->hpa_range.end   =3D 45365592063

>=20
> Suggested solution:
>   Linux should detect this and reset the MEM_ENABLED bit and simply
>   attempt to enable the hdm decoders accordingly.
>=20

Exactly, after resetting MEM_ENABLED CXL driver runs as if MEM_ENABLED hasn=
't been set.

>=20
> Question: Is this only observed with QEMU? If so, can we just fix QEMU?

Yes, it only happens with QEMU.
Physical CXL card with Xeon doesn't have this issue. The firmware set CXL_D=
VSEC_MEM_ENABLE but also CXL_HDM_DECODER_ENABLE has been set, so it works w=
ell.

I agree Qemu should fix this issue, it occurs probabilistically.
And I think this patch would help CXL driver to dealing with various firmwa=
re situations.

> > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > index 013b869b66cb..5452bb285140 100644
> > --- a/drivers/cxl/core/pci.c
> > +++ b/drivers/cxl/core/pci.c
> > @@ -448,6 +440,29 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxld=
s, struct cxl_hdm *cxlhdm,
> >  		allowed++;
> >  	}
> >
> > +	if (info->mem_enabled && !allowed) {
> > +		dev_warn(dev, "RR decodes outside ranges, have a try by disabling Me=
m_Enable bit.\n");
> > +
> > +		/*
> > +		 * Instead of Return error when RR decodes outside platform ranges, =
reenable
> > +		 * Mem_Enable bit of DVSEC control for a try.
> > +		 */
>=20
> Your comment says to "reenable mem_enable bit", but you clear it.
> I think you mean to say "reset mem_enable bit, and try to enable hdm".

Yes, thanks for correcting.

> > +		rc =3D cxl_set_mem_enable(cxlds, 0);
> > +		if (rc)
> > +			return rc;
> > +
> > +		info->mem_enabled =3D 0;
> > +		cxlhdm->decoder_count =3D cxlhdm->decoder_count_cap;
> > +	}
> > +
>=20
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 2a25d1957ddb..60b538f8b677 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -855,6 +855,7 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 =
cmd);
> >   * struct cxl_hdm - HDM Decoder registers and cached / decoded capabil=
ities
> >   * @regs: mapped registers, see devm_cxl_setup_hdm()
> >   * @decoder_count: number of decoders for this port
> > + * @decoder_count_cap: number of decoders from HDM Decoder Capability
> >   * @target_count: for switch decoders, max downstream port targets
> >   * @interleave_mask: interleave granularity capability, see check_inte=
rleave_cap()
> >   * @iw_cap_mask: bitmask of supported interleave ways, see check_inter=
leave_cap()
> > @@ -863,6 +864,7 @@ int cxl_mem_sanitize(struct cxl_memdev *cxlmd, u16 =
cmd);
> >  struct cxl_hdm {
> >  	struct cxl_component_regs regs;
> >  	unsigned int decoder_count;
> > +	unsigned int decoder_count_cap;
>=20
> Why is this needed, as opposed to simply re-reading the count?
>=20

They can all do it. It's easier this way I think.
Many thanks for the comments.

Best Regards,
Huaisheng Ye

