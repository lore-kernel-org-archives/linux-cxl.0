Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE655142E73
	for <linux-cxl@vger.kernel.org>; Fri,  5 Apr 2024 09:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712311050; cv=fail; b=cCwCmL7pvbRLOpQCchWncMwqpNFq5ZmzfC4ecYRIz67+PbyaUK0byL3HSuaflxAOqQywUZAF+gfrLHVEarcvSxBvw18oIfrhRh6NUZvES6dS5rWVg12zZe6k4vMrmMk4WmtZ4dDGAv6A1O/vYISgy6DLeBHC8IffjGF5mu83w3k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712311050; c=relaxed/simple;
	bh=TVS4BWrq7xIGlz5+WGwIl/SFpYdgf7+LdAl2c+cNJmE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ezHsH81GkLzPq39XIgyYZjHLkfMvWIfH0mscdTlYjEv3nE4GcrhQYfOfFiur4Ky4uixBxM9AiYLc/Sj/1czk7nYYeLffIAnZoGdg13n/CiMrP5UQbJNN5xO+v2aXOfDqlJSXl4g+6lp0i0OQRF8c7kT5BdaTLATG5tXpmXuBZBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=MBVSOBZE; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Y0FJMGJC; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MBVSOBZE";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Y0FJMGJC"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1712311049; x=1743847049;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TVS4BWrq7xIGlz5+WGwIl/SFpYdgf7+LdAl2c+cNJmE=;
  b=MBVSOBZEm+6TLSx+9MfkHVlkm20Mk7bm5r5tSsofy11UT3LJd1sgObBe
   R6q6EyYtIn9GeEDsIvLAidEstZnmne/jo//ACcl26GuVzyASRLUNT76yJ
   VptdY9pewuleso0KxRIRlIpHGiuXeKBncZFTl3HkNieRgbWwKPb48aWRA
   p9xD1vBuE/FFmARUUwLi10tvOCTzRPAOzcoSnZxyJrSpgOScEGUB5rCHu
   feTjIl2Fm1H3YNFKppViy3hepSejeLQztrZIPYI3T/RJwa+YOCG9WBAo2
   BeKnJ2XUUjKukpeEoTTv6BLXe9SM4jNyAUzfgOJZRIJCq1s4Vc1rWKYM3
   A==;
X-CSE-ConnectionGUID: WO7cxWJ9QU+9k08WmWlIyA==
X-CSE-MsgGUID: Whj161FQSM+OMtnv0KuxzA==
X-IronPort-AV: E=Sophos;i="6.07,181,1708358400"; 
   d="scan'208";a="13157715"
Received: from mail-bn8nam11lp2173.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.173])
  by ob1.hgst.iphmx.com with ESMTP; 05 Apr 2024 17:57:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nblqLR3ckhreUGc/Hoab/WnjiJLZ4tw/k4u/0KqDFdbtbAwsHxRGpnCyDlZ4uHr7iyDHIcRfszTeyvrOkLLxd7Cn2lUzAyhI5HaGzEHKK0/MSUiDnU4g6/wCcdnEImvBdXwTBii7IZZXs1Z0I2Zz0DFnCg80bITI3LOANY1sGDY0Dozy6HRPq+YK0HZXHh0ezoJi4FVzGPL6NknYuY0E1qMzxHZ1K1TBI3gcW9sYHys/FGJgbjQ6RuxlxysuxPdbD93WQw/5GHsHcLaC1L6b7xO6rvFlmdyTtvYGz1TtD6SVjAGznt5hA0R6uOf3MVSbxjkUHEwwOzq6Kq8tnipOGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVS4BWrq7xIGlz5+WGwIl/SFpYdgf7+LdAl2c+cNJmE=;
 b=lDKpNvJpmSQ6SH36JcQW7ASB8gNoKl5mNolD3d1o0R39dHQb7DIVcZWdbmL7bbwrC+qzBiC9fZx+achJr5W4lfbY0EluEIwIkYRxUz9HaHoto9chcKxBiaEgzrr9q1nUjFIcxXYJqgAAwClocqj8OJGXNb7NRMHuYIz1w/LJF+Vv2CtcCdhGfdXE6cEfj2omNY7JNODEZp7YA/ET0k483ftI6L5ML1pOx5c/diCi7F0ElwOKNQKl1sHuGP0XuYh9mbuaRWYmWrdkUcNDqo5y7HNIX6IH1D4BIdkugH6YpUXLtrPq56XoENRI+Tiuf4Ri48daG6P1fifhMSi5beDsVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVS4BWrq7xIGlz5+WGwIl/SFpYdgf7+LdAl2c+cNJmE=;
 b=Y0FJMGJCFNO6Uxav0A46KLFe8pVHQXMhQugEJgRDT8FdLJNfwhwkHHi2RiK7VoKcojswkS73tMwkWfMpiMtw0XLCkpAzLbH2DLOuzYl7zDOXYvUnhWJ2X3ghlDOHHX+4glJ49cXfv6SOcwtqcd/POdQHt3uyv6g5Z/peEgZA1Jo=
Received: from BYAPR04MB5431.namprd04.prod.outlook.com (2603:10b6:a03:ce::16)
 by BN0PR04MB8000.namprd04.prod.outlook.com (2603:10b6:408:15b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 5 Apr
 2024 09:57:19 +0000
Received: from BYAPR04MB5431.namprd04.prod.outlook.com
 ([fe80::2ab2:43a3:658b:b8c9]) by BYAPR04MB5431.namprd04.prod.outlook.com
 ([fe80::2ab2:43a3:658b:b8c9%7]) with mapi id 15.20.7409.042; Fri, 5 Apr 2024
 09:57:18 +0000
From: =?utf-8?B?SsO4cmdlbiBIYW5zZW4=?= <Jorgen.Hansen@wdc.com>
To: "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>
CC: "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"gregory.price@memverge.com" <gregory.price@memverge.com>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "a.manzanares@samsung.com"
	<a.manzanares@samsung.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
	"jim.harris@samsung.com" <jim.harris@samsung.com>, "wj28.lee@gmail.com"
	<wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v6 11/12] hw/cxl/cxl-mailbox-utils: Add superset extent
 release mailbox support
Thread-Topic: [PATCH v6 11/12] hw/cxl/cxl-mailbox-utils: Add superset extent
 release mailbox support
Thread-Index: AQHafudZtDFFlQlEW0Wafy18tkoEUrFZgXsA
Date: Fri, 5 Apr 2024 09:57:18 +0000
Message-ID: <dd9318d8-7553-4dc9-9075-8645fb6e091d@wdc.com>
References: <20240325190339.696686-1-nifan.cxl@gmail.com>
 <20240325190339.696686-12-nifan.cxl@gmail.com>
In-Reply-To: <20240325190339.696686-12-nifan.cxl@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR04MB5431:EE_|BN0PR04MB8000:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 hpfvqB6spRa5fnokUMivshQbBgV6UGRPapcr6DJv3rVUs7+JyjtBg6St3L2NhM7/K+LRomWcMSnCUn5tqVrHjXu01y8sJYJ/6ECyuILBKD6KxBjrg5prS41cSaGuUNSa4H1ObSb+B0zzeZdMGg0MOAude8vOgEiqxFVMsLTR2om0nUwep/zIMlNtn4iR5AYKkJ8lV15YvJbIwHHoIbohfWt/5YS6hQJlDJzeuLhCcB+Hbd+7wxeWzOTXPLpi8FPRBrU9aUYVxL1A8AEwi3yQAHXKQdZj4/9jbyasnuGW+nWo7UPFkrMta0oXjMu0mlyvr2GtcBIXDTxQxR5KtdBcDYrmZ40vMWERHtxkNk8MlrjqtGcqBCXlBgRlVUHf4XUa7MU/eWsH3X63zSQ+AUAsJ9nLz428nN14nkF81PC2HUMWB3FtASQM83cuWv8mxifAC+l0nP7t07HMx1g5pTNoCmyKrby4etiFnLNzfHEwPBxef2XhMUE1v1vtM1HEojazlgrRoANCi/5wuskBHIv+uxuYPhFCxsWFqQGmHbk1Jp7U2Ss9lZzxcWFBi0MkL32GSkhL7xgdjtbejoObGFmrPfijBIzdvoAH/Sc+TPjoIvGzMMMPE0RPsPxXXJM5nReIim2r08wQB3/C7nbxacsUa3WgX4IC4oZadgiWY9HIruQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB5431.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(7416005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?blR3K05FVUhVRXZiMDdFQy9kaVRZc2o4NFhmUFBSSVcvWjRLREMvV2x2YUhk?=
 =?utf-8?B?V090UmVRRms5bEF2MW13Q2tvUDBrVVhaWnhoQmQxQzNJb0Yvdy9pOTdwL3py?=
 =?utf-8?B?SmVwKzlGNlVpZ25ZRHdreHdCeGxpZ3E5RitpVCswN2JteFBnWW5BVzg1N1ZT?=
 =?utf-8?B?OG1tQVBvdWRLaExoOEZoUTFpQndHcUtjWWV3OVlGaFQrTjNoR20yNjFUTmwy?=
 =?utf-8?B?MDNxRit5UkxSUm5aTVY5b1hRQnU0cklaYTlmbkJ2cmFTUUE5eVRDZ2hGQjRZ?=
 =?utf-8?B?MGh5azlyb0Y2WDB5ZVErOXRwSmRuZXVaUkovaU9qbjU1SVp1bTd3UXpBWkJ3?=
 =?utf-8?B?ZzU2aWZRVTRHeTB5QUFNZ0NWemw2bDlzR2tIcFdtbXYzOUlKLzIvWWRBQlIw?=
 =?utf-8?B?U1hidGF0emRTbmpteGsyYmRHVzRkdmFDdVBwRi9NekEzMHVSbDh1Qi9WdG9E?=
 =?utf-8?B?bW1sMHUrYS9IS3haa0ZRUTNIYXZ6bGd6Q212RDNFVmJRN3lzcmliRC9MSkZm?=
 =?utf-8?B?R2tBY3MzcEZnMzY3bmZvOVBrWm9zSklGWEN1M2t1YTlZMVhoYUFEajRnL010?=
 =?utf-8?B?Vlc3YWZ1OEhaSEpIZXJ3dGpvVW01cVlzWk0yOEJLWVJQZ0o3ejNiZmtyektH?=
 =?utf-8?B?R1lycFJmOWNtWWMrYWk3WHZab3JIRTBtVGpZYVJuZlQ1RWMyUmx6ZXFCSkZy?=
 =?utf-8?B?bFpZem80S0FTeTNydU1ScncySEc4TVpOcnhuR0kwMEFQWnUraElIZFdROUIr?=
 =?utf-8?B?TEE5UUViOW1xTmszMnA3V285M00zRVZoYWRGbXVIeXRsQ1JPdkZ5OEd6L2tM?=
 =?utf-8?B?ZDRSMHdTZWZMZWE1dW1hWENOcTE5ZW9uMldSL21FKy92RUV3VDVyUVhiMGFq?=
 =?utf-8?B?N1pJcGw3ZU0yWGFIL3BKVzlkNmJYK0JHM2pNZWxEaGk2eEFmTHorVURDV0Fw?=
 =?utf-8?B?TVJWb0pFZDhzekZLUzZoWnp1aDgrWS80V25LcWJhb2hUQU9vRDVOZ2gyVER2?=
 =?utf-8?B?WC81MExvUitZM1YzRmFvWHFvNmhhaU4rTjZ1Q1piUkNkWW1sRExhMVVqMGJB?=
 =?utf-8?B?ZnR0QmR2endmUHJRaW1RTW9hTFM5YzZ4dEVXeDI1MHhTekNhSlNQaEluSGxP?=
 =?utf-8?B?aG5sMmNkQTA3OHlSV2pOYVh0Q0ZYM0RSV1dFUDFzdmZuS3Zra2lvQVA5SmpP?=
 =?utf-8?B?Q3o3Uzl1UWQvWDJRRXBsU2RTLzdDclI2a2tZMHpSK1hOYWVrMVN4bDlONkhh?=
 =?utf-8?B?bEN6TzNLZXVsaExMbEp1Q1VyYW5Za3dCeUFodE1YNU1lK1hFWlpBcEtkRDBx?=
 =?utf-8?B?d0pkU3ZpSjBtL3NZUllTZ1pkMjF3OHQ3SXRmYUN4blhQVHVEWkU3Y05EV2Ey?=
 =?utf-8?B?ZitRY0dzbXV0ck8wcnJ4WDhtekVHY05WMnErR2NwL0xjNHFRRHEwaTVicitq?=
 =?utf-8?B?N2NrUEFvcmMzcWVrWWVLNk9MeGhjRDA1SnMzTW5icGx5dDJiY0NYeWs3eURM?=
 =?utf-8?B?Vm42d0xhRzczQjEyUWg0bXpkMUtEclBDc1kwY3JrdldSc1pyc3FpYkZENlhm?=
 =?utf-8?B?bUpLdzFZRit6aFZpdlZ6RDlKOEYzVWxrazRHbkp2cHFtR2FTT1Y3WDJYSE9x?=
 =?utf-8?B?a2JKWmVRTVI2Q1NGbGZnWFFzQVZyLzI4a2Fqa284eFlhckRLVGVOS2NCTHhB?=
 =?utf-8?B?cGNnMFRNK0NzRXJQdnp0TERPUjc3RkgrNWNXZGQ4UjZLTWVvSXlRNlFmSTNE?=
 =?utf-8?B?Z2JUcG5aK0Raajc1ak5xVkFoRUZmM0RteHZnT250NG9uZ0wrS3duK3UzRVZv?=
 =?utf-8?B?RTE3RnJDc2QvYlFJaEJPZUhwMVkwUnluRXVBVENyU2VWUGs5dk05MTdTUU1E?=
 =?utf-8?B?OTBGZ2hQT05zQXhQYW9QYUpyWm05eTdpN3BIRWdVdTQ4TldkaGltaXlvNWd6?=
 =?utf-8?B?ZUh0cndoa1lsMklLT0FUd0duOVBuZW1uYTNsWHNQdS9EUmIrdytVSFByaGxi?=
 =?utf-8?B?MzRoVUI4K2paVU12VFBObXlYdFZpNWliaWFUby81cmhUZUZSYytsU0pNdWFo?=
 =?utf-8?B?UUxzY3FMcFd1L0NsK1dTTndrdXpQSHpqK1JsR3gxQ2lYYWRwSXAyUm9RdXFr?=
 =?utf-8?B?eUtyVUZ2b096NW9nb0tiOXVKaXdRTFdYODJweEN4WWxRdjhIK0pVZTNlMjVR?=
 =?utf-8?B?OHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B037E06210A4D445BA3C58DD54CDABED@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	oIG/5Ea9k4Mc69GOCaxcBIGQXShwMGVFDARKgOoI8vn4ZRf2XZmkas8MihWeGIFL5TmO+W0tWB3HNzjYzZxPvd9bgLzrYHgCmY0Cbd87dtfJBBV2z+mVAoh4ai09DzInJOO8XDRNre/o9an7wsRA1XmmxTvQk5XBgnQelAm344ndNSD6BF5m1jRNPVwIXcnnLBoZuKJ4GKNtoG8LxrjJk9jagShAnTETq1dkwS9mA14g6afgaWfjlQdiNbXO1x9572m0iXX6H2PE05fFFoYlRRFbTZxPSKm0dwOML6bxXnxxDP9WXpdqgTkcH+wjk/+XgMMDov3yPBwz/fk2vXaP5JlnLmIMf01Xp0/5g86LeSiSlll+xYzT8Kr5+w2mxLjTI6SZXhKPCyAlMBk7ru+R9Pq/O7MdVlO7qrQd/OC9DrVpksYjTk9nmjNiQhIGtsjuLjQsZVQr/7VfuN9Tv+TR0cjMmdBz9lDfGcwzm4fUB9hZ3vOU0Vj8sQc1Ryoa7ornfATPBeLcGeLV0+geaP62Yhw+e3lemhziYZ7MxS8/YlAvLlnQCwCjnfNsYFVHZTy/3cBu7Ml6Wjk3k7Xl9RBjG30R4Q3m7sEdS1Sm2xkzAwlX8sgwx/H0HWfcqFQZAchm
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB5431.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2badc4a5-b00b-4caa-f96b-08dc5556c7cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Apr 2024 09:57:18.6991
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BS4MCc2zHqZbMeuOu+ds83vVDpFDq+s7VWKeSUYTiAWkxWfKFiWLP+Q4uDbAe1aQEaaqDCqyRPoojGWJEcqu9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8000

T24gMy8yNS8yNCAyMDowMiwgbmlmYW4uY3hsQGdtYWlsLmNvbSB3cm90ZToNCj4gRnJvbTogRmFu
IE5pIDxmYW4ubmlAc2Ftc3VuZy5jb20+DQo+IA0KPiBXaXRoIHRoZSBjaGFuZ2UsIHdlIGV4dGVu
ZCB0aGUgZXh0ZW50IHJlbGVhc2UgbWFpbGJveCBjb21tYW5kIHByb2Nlc3NpbmcNCj4gdG8gYWxs
b3cgbW9yZSBmbGV4aWJsZSByZWxlYXNlLiBBcyBsb25nIGFzIHRoZSBEUEEgcmFuZ2Ugb2YgdGhl
IGV4dGVudCB0bw0KPiByZWxlYXNlIGlzIGNvdmVyZWQgYnkgYWNjZXB0ZWQgZXh0ZW50KHMpIGlu
IHRoZSBkZXZpY2UsIHRoZSByZWxlYXNlIGNhbiBiZQ0KPiBwZXJmb3JtZWQuDQo+IA0KPiBTaWdu
ZWQtb2ZmLWJ5OiBGYW4gTmkgPGZhbi5uaUBzYW1zdW5nLmNvbT4NCj4gLS0tDQo+ICAgaHcvY3hs
L2N4bC1tYWlsYm94LXV0aWxzLmMgfCA0MSArKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0t
LS0tLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyNCBpbnNlcnRpb25zKCspLCAxNyBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9ody9jeGwvY3hsLW1haWxib3gtdXRpbHMuYyBiL2h3
L2N4bC9jeGwtbWFpbGJveC11dGlscy5jDQo+IGluZGV4IGEwZDIyMzkxNzYuLjNiNzk0OWMzNjQg
MTAwNjQ0DQo+IC0tLSBhL2h3L2N4bC9jeGwtbWFpbGJveC11dGlscy5jDQo+ICsrKyBiL2h3L2N4
bC9jeGwtbWFpbGJveC11dGlscy5jDQo+IEBAIC0xNjc0LDYgKzE2NzQsMTIgQEAgc3RhdGljIENY
TFJldENvZGUgY3hsX2RjX2V4dGVudF9yZWxlYXNlX2RyeV9ydW4oQ1hMVHlwZTNEZXYgKmN0M2Qs
DQo+ICAgICAgICAgICBkcGEgPSBpbi0+dXBkYXRlZF9lbnRyaWVzW2ldLnN0YXJ0X2RwYTsNCj4g
ICAgICAgICAgIGxlbiA9IGluLT51cGRhdGVkX2VudHJpZXNbaV0ubGVuOw0KPiANCj4gKyAgICAg
ICAgLyogQ2hlY2sgaWYgdGhlIERQQSByYW5nZSBpcyBub3QgZnVsbHkgYmFja2VkIHdpdGggdmFs
aWQgZXh0ZW50cyAqLw0KPiArICAgICAgICBpZiAoIWN0M190ZXN0X3JlZ2lvbl9ibG9ja19iYWNr
ZWQoY3QzZCwgZHBhLCBsZW4pKSB7DQo+ICsgICAgICAgICAgICByZXQgPSBDWExfTUJPWF9JTlZB
TElEX1BBOw0KPiArICAgICAgICAgICAgZ290byBmcmVlX2FuZF9leGl0Ow0KPiArICAgICAgICB9
DQoNCkluIGN4bF9kY2RfYWRkX2R5bl9jYXBfcnNwX2RyeV9ydW4sIHRoZSBvcHBvc2l0ZSBjaGVj
ayAoYWxsIDAncyBpbiB0aGUgDQpiaXRtYXApIGNvdWxkIGJlIHVzZWQgaW5zdGVhZCBvZiBsb29w
aW5nIHRocm91Z2ggdGhlIGZ1bGwgZXh0ZW50IGxpc3QgDQooYW5kIHRoaXMgYWxzbyBtYWtlcyBt
eSBwcmV2aW91cyBjb21tZW50IGFib3V0IHJldXNpbmcgdGhlIGJpdG1hcCBmcm9tIA0KY3hsX2Rl
dGVjdF9tYWxmb3JtZWRfZXh0ZW50X2xpc3QgaXJyZWxldmFudCkuDQoNCj4gKyAgICAgICAgLyog
QWZ0ZXIgdGhpcyBwb2ludCwgZXh0ZW50IG92ZXJmbG93IGlzIHRoZSBvbmx5IGVycm9yIGNhbiBo
YXBwZW4gKi8NCj4gICAgICAgICAgIHdoaWxlIChsZW4gPiAwKSB7DQo+ICAgICAgICAgICAgICAg
UVRBSUxRX0ZPUkVBQ0goZW50LCAmdG1wX2xpc3QsIG5vZGUpIHsNCj4gICAgICAgICAgICAgICAg
ICAgcmFuZ2VfaW5pdF9ub2ZhaWwoJnJhbmdlLCBlbnQtPnN0YXJ0X2RwYSwgZW50LT5sZW4pOw0K
PiBAQCAtMTcxMywyNSArMTcxOSwyNyBAQCBzdGF0aWMgQ1hMUmV0Q29kZSBjeGxfZGNfZXh0ZW50
X3JlbGVhc2VfZHJ5X3J1bihDWExUeXBlM0RldiAqY3QzZCwNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgZ290byBmcmVlX2FuZF9leGl0Ow0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgIH0NCj4gICAgICAgICAgICAgICAgICAgICAgIH0gZWxzZSB7DQo+IC0gICAgICAgICAgICAg
ICAgICAgICAgICAvKg0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICogVE9ETzogd2UgcmVq
ZWN0IHRoZSBhdHRlbXB0IHRvIHJlbW92ZSBhbiBleHRlbnQNCj4gLSAgICAgICAgICAgICAgICAg
ICAgICAgICAqIHRoYXQgb3ZlcmxhcHMgd2l0aCBtdWx0aXBsZSBleHRlbnRzIGluIHRoZSBkZXZp
Y2UNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAqIGZvciBub3csIHdlIHdpbGwgYWxsb3cg
aXQgb25jZSBzdXBlcnNldCByZWxlYXNlDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgKiBz
dXBwb3J0IGlzIGFkZGVkLg0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICovDQo+IC0gICAg
ICAgICAgICAgICAgICAgICAgICByZXQgPSBDWExfTUJPWF9JTlZBTElEX1BBOw0KPiAtICAgICAg
ICAgICAgICAgICAgICAgICAgZ290byBmcmVlX2FuZF9leGl0Ow0KPiArICAgICAgICAgICAgICAg
ICAgICAgICAgbGVuMSA9IGRwYSAtIGVudF9zdGFydF9kcGE7DQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgICBsZW4yID0gMDsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgIGxlbl9kb25lID0g
ZW50X2xlbiAtIGxlbjEgLSBsZW4yOw0KDQpZb3UgZG9uJ3QgbmVlZCBsZW4yIGluIHRoZSBlbHNl
IHN0YXRlbWVudC4NCg0KVGhhbmtzLA0KSsO4cmdlbg0KDQo+ICsNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgIGN4bF9yZW1vdmVfZXh0ZW50X2Zyb21fZXh0ZW50X2xpc3QoJnRtcF9saXN0LCBl
bnQpOw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgY250X2RlbHRhLS07DQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgICBpZiAobGVuMSkgew0KPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIGN4bF9pbnNlcnRfZXh0ZW50X3RvX2V4dGVudF9saXN0KCZ0bXBfbGlzdCwNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBl
bnRfc3RhcnRfZHBhLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGxlbjEsIE5VTEwsIDApOw0KPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGNudF9kZWx0YSsrOw0KPiArICAgICAgICAgICAgICAgICAgICAgICAgfQ0K
PiAgICAgICAgICAgICAgICAgICAgICAgfQ0KPiANCj4gICAgICAgICAgICAgICAgICAgICAgIGxl
biAtPSBsZW5fZG9uZTsNCj4gLSAgICAgICAgICAgICAgICAgICAgLyogbGVuID09IDAgaGVyZSB1
bnRpbCBzdXBlcnNldCByZWxlYXNlIGlzIGFkZGVkICovDQo+ICsgICAgICAgICAgICAgICAgICAg
IGlmIChsZW4pIHsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgIGRwYSA9IGVudF9zdGFydF9k
cGEgKyBlbnRfbGVuOw0KPiArICAgICAgICAgICAgICAgICAgICB9DQo+ICAgICAgICAgICAgICAg
ICAgICAgICBicmVhazsNCj4gICAgICAgICAgICAgICAgICAgfQ0KPiAgICAgICAgICAgICAgIH0N
Cj4gLSAgICAgICAgICAgIGlmIChsZW4pIHsNCj4gLSAgICAgICAgICAgICAgICByZXQgPSBDWExf
TUJPWF9JTlZBTElEX1BBOw0KPiAtICAgICAgICAgICAgICAgIGdvdG8gZnJlZV9hbmRfZXhpdDsN
Cj4gLSAgICAgICAgICAgIH0NCj4gICAgICAgICAgIH0NCj4gICAgICAgfQ0KPiAgIGZyZWVfYW5k
X2V4aXQ6DQo+IEBAIC0xODE5LDEwICsxODI3LDkgQEAgc3RhdGljIENYTFJldENvZGUgY21kX2Rj
ZF9yZWxlYXNlX2R5bl9jYXAoY29uc3Qgc3RydWN0IGN4bF9jbWQgKmNtZCwNCj4gICAgICAgICAg
ICAgICAgICAgICAgIH0NCj4gDQo+ICAgICAgICAgICAgICAgICAgICAgICBsZW4gLT0gbGVuX2Rv
bmU7DQo+IC0gICAgICAgICAgICAgICAgICAgIC8qDQo+IC0gICAgICAgICAgICAgICAgICAgICAq
IGxlbiB3aWxsIGFsd2F5cyBiZSAwIHVudGlsIHN1cGVyc2V0IHJlbGVhc2UgaXMgYWRkLg0KPiAt
ICAgICAgICAgICAgICAgICAgICAgKiBUT0RPOiBzdXBlcnNldCByZWxlYXNlIHdpbGwgYmUgYWRk
ZWQuDQo+IC0gICAgICAgICAgICAgICAgICAgICAqLw0KPiArICAgICAgICAgICAgICAgICAgICBp
ZiAobGVuID4gMCkgew0KPiArICAgICAgICAgICAgICAgICAgICAgICAgZHBhID0gZW50X3N0YXJ0
X2RwYSArIGVudF9sZW47DQo+ICsgICAgICAgICAgICAgICAgICAgIH0NCj4gICAgICAgICAgICAg
ICAgICAgICAgIGJyZWFrOw0KPiAgICAgICAgICAgICAgICAgICB9DQo+ICAgICAgICAgICAgICAg
fQ0KPiAtLQ0KPiAyLjQzLjANCj4gDQo=
