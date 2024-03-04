Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539EC3FB27
	for <linux-cxl@vger.kernel.org>; Mon,  4 Mar 2024 13:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709557844; cv=fail; b=L6IIAl4+VnRd7BT1xzgtrcHP2Kl1khXtMeML0xChwVRqi85n95iqK1x5I78RGTqC64Wojrrnf0SE4sOclG2cMjKC/hkYSAUw52HxFPEQsnlLIavuqC5MmZz4XBd8GlUmdMSN6YFTOC0+o0xJ9oXS9MoxWkB9o5Nk16R2APkpzg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709557844; c=relaxed/simple;
	bh=+MzGHwldYmOsgzjhsSrUv8Ac+c4rT5h/tI9x3Gc/DSg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O4Yb/YfC5Bm5L2x/mqQ53ndZel4cBAdneivQydn7NYy9weatxkZWONLvWvnN46XSB78p1VFnrF9vo9AqWQLc5AuuxB7LqtkF8kR9EqnThs0YH5xrK2dUbnFmtVpcz18JuN2Scs0mx8ILGN7kjiLQCyfKN+w7OckbR+tY5jyGb98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=MRj1t743; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=ebLAy9Ht; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="MRj1t743";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="ebLAy9Ht"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709557842; x=1741093842;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+MzGHwldYmOsgzjhsSrUv8Ac+c4rT5h/tI9x3Gc/DSg=;
  b=MRj1t7439WXhc9u/6Gu7mIJJOlqhhLFZWcyMFs6JmeLHJlXHT/12oZlF
   zSEp/jXVlnx9LzSHrAJdUtEyoR3eJFEWkqwRQJ7Z753imfLi+oRG7jlXx
   CtOnH+SOA9kxWTiNKqu6pAPrlgPnsNYwB6+zs+B1im+WZfRWH2fX3JiIl
   vSwMD/tz3VB9rNkEtVGDzLjczhJ+k0R/rM3C6jS/t6Q09tBfV/HofDnhX
   VIrP3I9ovPhxRGLWI8zeLcryoMz79uQe1+MktMuGnNgnMaywU6AsganIO
   9jacx8cpmCz+VW4X3rEnwDv/CyXe7VgvIyxjwSvmZNI5FQfO64myLOuqQ
   Q==;
X-CSE-ConnectionGUID: PsrxNdRuTuiCco+Hy7RgBA==
X-CSE-MsgGUID: cxL5p5m0S82qkjyfJn8j+Q==
X-IronPort-AV: E=Sophos;i="6.06,203,1705334400"; 
   d="scan'208";a="10300606"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 04 Mar 2024 21:10:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRQX2CR02+kDSAtOvTMttIBSU5CAu3RzGrjYYum7wQCb5dpXwL8CoUOJoWjZ71S0E2nBRDhVbz/zKJIRR6H1wKbFgC4v8bVC4FVhtBYPsKFzHx9mUVVqOSSQjeUzZytjjv9RBuQ/8yNeM7XtSPqXiQFubiBhrtZwwAcpuMb8xDzP85yCNsXx4E0RNm6MV6PgbZXQJdaxA049VpFq7FEcPJIc1zPWEI9WCTpIMb0zuHsGYbO+1WsxeDReY1csgGd/wo46F5Brnj0IPRkR5cONxjwIXMx+U/4/HDYJ9wVKRjXZstLIAWAiDB7tl7t7Qg8NSItON7kGrqjhK4zpU+p7IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MzGHwldYmOsgzjhsSrUv8Ac+c4rT5h/tI9x3Gc/DSg=;
 b=R2LovV0FA6cUVxhgbWzQqD3ADQcw1ufUrH08fHrfKPz7UxDo1mRDvGpdDNRNiHVTYf3HBuVMxcFdYo3B7poygbm310+RU/fHrnVPHHeywr8uHPfcsvCf3P4Xw+ADEzvgRj0LwMBbKnLB8Aabs3LJy/DnMUrXcPttLo+8I4c2rNX7pCVbgpg/Gu7nV5E8qHBxZmUYmWqCm+vje0NnCn1dNY1rNEM58MmutrbggZRrrh4OZh87jdqqe9W5IMauwNRtR4wdpdU9+QuvSBCOEEIIzocOIr0KC3swbAywEVcTWzt94tAnyrWrd/e0VQMzwk6NBgEDX2cfDCX0oOn+PlZ+hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MzGHwldYmOsgzjhsSrUv8Ac+c4rT5h/tI9x3Gc/DSg=;
 b=ebLAy9HtCXs/8GvitJ8szQ+IHUN5B9QTuS3gi1VIro2HOr6Rd+WiE2UYd/mlNDmxxIipWDotFi8y+QuU1Pr6Df2y9hT4T2B5qlDSh9J90BV6dRzpqQvRN5zCCGN2XiVhySKqYB1XemayKYNSShaUvHdiEkL9ReIh1zVo66mzWi4=
Received: from BYAPR04MB5431.namprd04.prod.outlook.com (2603:10b6:a03:ce::16)
 by DM6PR04MB7020.namprd04.prod.outlook.com (2603:10b6:5:244::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 13:10:37 +0000
Received: from BYAPR04MB5431.namprd04.prod.outlook.com
 ([fe80::eeac:1074:a93:a99d]) by BYAPR04MB5431.namprd04.prod.outlook.com
 ([fe80::eeac:1074:a93:a99d%3]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 13:10:37 +0000
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
	"jim.harris@samsung.com" <jim.harris@samsung.com>, Fan Ni
	<fan.ni@samsung.com>
Subject: Re: [PATCH v4 04/10] hw/mem/cxl_type3: Add support to create DC
 regions to type3 memory devices
Thread-Topic: [PATCH v4 04/10] hw/mem/cxl_type3: Add support to create DC
 regions to type3 memory devices
Thread-Index: AQHaZPLNngLCRoWOVk2NOdjj9Cw/X7EnoMyA
Date: Mon, 4 Mar 2024 13:10:37 +0000
Message-ID: <ebab98e4-aa07-4aa6-84ec-768f6432e2f4@wdc.com>
References: <20240221182020.1086096-1-nifan.cxl@gmail.com>
 <20240221182020.1086096-5-nifan.cxl@gmail.com>
In-Reply-To: <20240221182020.1086096-5-nifan.cxl@gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR04MB5431:EE_|DM6PR04MB7020:EE_
x-ms-office365-filtering-correlation-id: 5fce51b2-9ad8-4a1f-6190-08dc3c4c7c1c
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 iYOs3zPdpVMiP26Bn7y4Kclfrj/pX+jfvI/TEVWiG+HnUwcPrKSJlRjIk1/4ZwG6h9/oKLU/p2XlAXoHBFsfvxaklP1vHkRUNmc3zRX5BzrKfBDrYCCsGTo6oIeYcb4SoJG5pePwBjow5wN8s+6hkPn5t5pV+fCTzmpZEET8fV1R4QIAvybRQfgopDG3I5PY3BsYwGGnw2FFFvaPug4beJ4B97UAgDFBsaljoohUMdL4fFSPhJGB8j6jrs3Rx6G21ZWEC5yB/bOP2M6XOuCbdtbEIdTwaDiZQ2/+A9l9rY/nBeAgOVNOUHOZ5zeor84ZIemU0i4DTPCktiEJLT6GqTP/uTOqWX52/xV7Lue6OyxpQF0M1ArzKKBHWWguBGavYMY2A3Pkm2ahM7OsUJKFpvmTKGL/XGHasMwyHCasuLVsdYlgtp8+0Kz/WuuFBe3BDQieaTXacUNWnQXGM+QHjT4nqY75fck4R9RG7PWbVkgCyzf8fU4tZ14jKiEK6pAaPomZ12L+dIuCbTqHkjk+qqjGxXeKIY+EUcaal+wTtcaVOcvTxcrkB8TA8ZeVDkZtoNMKitu3pA82bmugPPSLrQ8Yr2vLMRZc95TR1ycrxI/lc73G/+P4zXGZr4vxno6LNV975YlUs347WgJZYwKuCnwoSN0Tx2LAetDo0UGg2/mAtZEpybpFsKNnRPuDqYO5By9xRsoAipjzO/8TAr4/oZzVSXMiRgJNLzPQZsX4a3E=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB5431.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aElpU2tmZ25yamxYVkl3S2IyK1dsYlhtQ1NVWVF2QnlWUUFzQ3VPZXZnTmtN?=
 =?utf-8?B?OUhNblRmUWgzRHVvRTBZNVFxU0FjSzM4bXdNV25DMHpUL1pRLzRrWktFbWxT?=
 =?utf-8?B?dWVWcEpSdHpQdmZUNk4zcjBwaCtGZXVDV3RsWk9SZlM1RFRRbEw0NlVnYUVh?=
 =?utf-8?B?WERIRkVrYnNrdmRTa2xBQk9XM1VnYTVMZktOMEFFaWRnSS9uNThWNjkvOWdu?=
 =?utf-8?B?SEVYZklienpySVdnL1Jza0w4OGh4R1N6Y09YM2hXSGpRcW1RYWRiOUxOS2hr?=
 =?utf-8?B?SVU3R0NCTHJlaWlCRDFsUUtDMXdCUFprYyswaTA1TzVXZC9oWEUxcEtGNGhQ?=
 =?utf-8?B?WHk0YnF5V0pkS1J2OHY1Y01SYlJrWDVqZ2JUNE50RVU3cng4eUI1RHhYamlF?=
 =?utf-8?B?enRUVVFPUWRFNDVQVkxDRkwwT2JUdGZNN1VRRjN6aTdab0dvUWdsNngrVjRt?=
 =?utf-8?B?UmsvQlhpK2haY1g2TjVmWHdsL1hvSmFCQXNXbFNsRkkyUkN6RTBjMFRiVzJr?=
 =?utf-8?B?VXZtTFp2Ui9qOEVXUStkQTFiTFM2b3hhaU1SM0NneE9ndjVPeHo4Njg3VmhL?=
 =?utf-8?B?ckUvSjRrbVJsMnpGQlIvUEtoMVh4VnA0R2dSTzRtcDMya1piMjZZMTlZcjVv?=
 =?utf-8?B?OEp2d2owWGkvK3NYV2c4U0pZakJldmxIblg2Y3NHeUFsdXFnR2F5ckdPTk1U?=
 =?utf-8?B?KzJQUzBjV0VkbTZGaVA3U0UxcExERlpkTUk5N3dXSEQvd3N5bXJPUSt2YW5s?=
 =?utf-8?B?aUlScDI3VVFEb0YrVTJWTnMvN1I3V0YzT0UrOFEvTEMxd1NZbStoaDN6RUZp?=
 =?utf-8?B?OUhEZkczcWZ4ODZJNDU1RWNrUWhUK0hNOEdpTGs4YmJXY2lOeEs2Q1lBc240?=
 =?utf-8?B?Zlk0emQwNUZKdlBZSHlwVXdXMHFkeWZSOUw1allNQ01ZaFlYL040UlNOMDI5?=
 =?utf-8?B?bFhsc3E3KzNhcGdMQ2hrUE1kcUgyZUE2RkZuTHIxQXFHNVBsZGkyekFCYWdZ?=
 =?utf-8?B?eURlckcwMTJGam52Lzc2aFNjRDdPeE9wNitmbVpsdnYrditicWVEV29CbjdN?=
 =?utf-8?B?RmV4M1pDR25tc3Y3VUI2YnN2OXk1Nk02UTh3SEY2QUEyS0s4U2NwNXVFa2Jk?=
 =?utf-8?B?aW0yL1lYMW1LMlRwVGYvNHZqVkZTSHpqbEM1Rjh6M29rb21Za3FrbUpMdTBN?=
 =?utf-8?B?UnloNEc0a3hzdGZnT1h0RWdzVk16NjFFOXBPMUZ2RkROQmdQMWxaVThZbis5?=
 =?utf-8?B?WHc1WkdIMERhQk94ZVJTc0dkUmFsV0hwVkhJaXRTc2paRWhKZ3RMbmlsT25k?=
 =?utf-8?B?MHlNSUFicVhVN0FuSzV0VGVUNUtQQ2VoTjNlRUlPZTQ5V3dpVzV1dm9aRjd5?=
 =?utf-8?B?cjVwSk0vUlQwRTRQVnRLWFFjOWx1eDR0RHRRR1JwU2kvYkNxQi91eVRLR1VH?=
 =?utf-8?B?U3NaRkJ0KzJRL0hFeFVXWXdPYVV6NzJIeDlPR3VvS1dLRXRhdnV2MjYrRHZZ?=
 =?utf-8?B?SUpweFd1dlFIQStqTUtkZjM2YVUxWkFNVnR0UEdDcWpBdlhTN1BMaGZiT2FR?=
 =?utf-8?B?aUMyQ3ZUMHRlVjZLVWhYYWJnK0l5WnBZYlJSY3RCS0dIVURoQ05ScEhxS1c2?=
 =?utf-8?B?czUxWEx5UWxEeHcwNjFhdDhUVlIzUHVDd0VOUkdXVnh5MU82b3gzNHJkQlVj?=
 =?utf-8?B?YUFTSkIwclloT0JTdXZhSnoxaVp0VlhyZ1MwSjFFT2JvMWE4Tmt0N2FNN09N?=
 =?utf-8?B?ZHRNam9wbkl1QVYvbDE2RHhTTEFrc0xnYXByQ28wRDJFS2UzRm5CTGIySGF3?=
 =?utf-8?B?T2ZNOTZKVlVsWUJWcnROb21qTlZHMXlBZzUyZkxnRWdycnAxSVZOVHcrL3A1?=
 =?utf-8?B?YlI3OXRIZ3BqdnVEUHNDcngvUVBqK3JwcEdCZTVtZzl5VzllNXQvNXpUbGxT?=
 =?utf-8?B?TS9ObTRIYTF6TFozV0NRUzJuc3lNQVZrVGdGeFNsRVV2ZWErZFhyRnFsTXlV?=
 =?utf-8?B?YTQxOE93eUU4NUMrZ2RnemZXcEhreXZHMWhJQmNNaW90YXBuTHhGak5heHRl?=
 =?utf-8?B?WUszUHlrOXpXRVF2WDNFaUgwLzg1M1JBa1FXU1FVNTZ6WHZ3dW82MGtqd0RB?=
 =?utf-8?B?dWFuQlU0blBxNHRZK1JJNEhMbS9CSm03UVl3RkZiSmpWdnNBazJzNGFlallo?=
 =?utf-8?B?ZHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A70EA55C8FE0234EBE6D029A453CF0F8@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KH2UYvdz38HgCg/fHQY4BSB2CcfC6MVlE5SkiwOn6fh8IS8iGBgEoKCp24RmpEk79+VqZF/aJYH+r7+HDBJbGMuDBi5fOAp/caf2wzkdH+VCVQHc1vl91pj/mS3oy7QWrlzMXCTcfYDFCwSbIvctxhru+I3h+gTuol1zAz/nYu5BPaWLkH3EA8+zFEx1rVwGz+SJASOblspiWREfw5B0lEjvi/qu3YAIUzQG+epHMY2HY4hlkyoic3ZS2A8BJunWmR5EIMmDi0ASp5PjlIJrp/eSi6yUf5ap+ium01KJ1F6r7/6lpVdBDvhMIqI+64lhL+JN7UfosYYDzC1ewVgoxzNj5xxdjz9ohOp1nl+3pqjmVGC4Xn8xd5v1dpVX3/GsVG6aXxXBV+9/NjhDusD3MrzIPHP5vByFPl+D/q5USZB0RLTU3sO4A6K5pRC0oMgKHPynXhwFFKvWX/6P9hb9Io+Vu+isATckATvnCt9xg20e92fD0KZX2lgSqxeDDJrryhFwRcJy+7DGQLEMDLl7gUwRkfn3Q4mPzvhJBE88Q69dOOpFUL37pXJ3cBBUTTFMZpUA9xwo4FTdxK26viZcllMjvcsW+UWI2yM7qPMHNzRyLXUJpIaGjcIszLQ0OvQX
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB5431.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fce51b2-9ad8-4a1f-6190-08dc3c4c7c1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 13:10:37.6832
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RjIX1wkEQHrY8r+YOrIGEumx7yNFXcoc4prwkz4LYfh+2cWONAxSQlVyXvTydVH/3MmqwoxrpB7DQE3wbkDVdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB7020

T24gMi8yMS8yNCAxOToxNSwgbmlmYW4uY3hsQGdtYWlsLmNvbSB3cm90ZToNCj4gQ0FVVElPTjog
VGhpcyBlbWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiBXZXN0ZXJuIERpZ2l0YWwuIERv
IG5vdCBjbGljayBvbiBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVjb2du
aXplIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhhdCB0aGUgY29udGVudCBpcyBzYWZlLg0KPiANCj4g
DQo+IEZyb206IEZhbiBOaSA8ZmFuLm5pQHNhbXN1bmcuY29tPg0KPiANCj4gV2l0aCB0aGUgY2hh
bmdlLCB3aGVuIHNldHRpbmcgdXAgbWVtb3J5IGZvciB0eXBlMyBtZW1vcnkgZGV2aWNlLCB3ZSBj
YW4NCj4gY3JlYXRlIERDIHJlZ2lvbnMuDQo+IEEgcHJvcGVydHkgJ251bS1kYy1yZWdpb25zJyBp
cyBhZGRlZCB0byBjdDNfcHJvcHMgdG8gYWxsb3cgdXNlcnMgdG8gcGFzcyB0aGUNCj4gbnVtYmVy
IG9mIERDIHJlZ2lvbnMgdG8gY3JlYXRlLiBUbyBtYWtlIGl0IGVhc2llciwgb3RoZXIgcmVnaW9u
IHBhcmFtZXRlcnMNCj4gbGlrZSByZWdpb24gYmFzZSwgbGVuZ3RoLCBhbmQgYmxvY2sgc2l6ZSBh
cmUgaGFyZCBjb2RlZC4gSWYgbmVlZGVkLA0KPiB0aGVzZSBwYXJhbWV0ZXJzIGNhbiBiZSBhZGRl
ZCBlYXNpbHkuDQo+IA0KPiBXaXRoIHRoZSBjaGFuZ2UsIHdlIGNhbiBjcmVhdGUgREMgcmVnaW9u
cyB3aXRoIHByb3BlciBrZXJuZWwgc2lkZQ0KPiBzdXBwb3J0IGxpa2UgYmVsb3c6DQo+IA0KPiBy
ZWdpb249JChjYXQgL3N5cy9idXMvY3hsL2RldmljZXMvZGVjb2RlcjAuMC9jcmVhdGVfZGNfcmVn
aW9uKQ0KPiBlY2hvICRyZWdpb24gPiAvc3lzL2J1cy9jeGwvZGV2aWNlcy9kZWNvZGVyMC4wL2Ny
ZWF0ZV9kY19yZWdpb24NCj4gZWNobyAyNTYgPiAvc3lzL2J1cy9jeGwvZGV2aWNlcy8kcmVnaW9u
L2ludGVybGVhdmVfZ3JhbnVsYXJpdHkNCj4gZWNobyAxID4gL3N5cy9idXMvY3hsL2RldmljZXMv
JHJlZ2lvbi9pbnRlcmxlYXZlX3dheXMNCj4gDQo+IGVjaG8gImRjMCIgPi9zeXMvYnVzL2N4bC9k
ZXZpY2VzL2RlY29kZXIyLjAvbW9kZQ0KPiBlY2hvIDB4NDAwMDAwMDAgPi9zeXMvYnVzL2N4bC9k
ZXZpY2VzL2RlY29kZXIyLjAvZHBhX3NpemUNCj4gDQo+IGVjaG8gMHg0MDAwMDAwMCA+IC9zeXMv
YnVzL2N4bC9kZXZpY2VzLyRyZWdpb24vc2l6ZQ0KPiBlY2hvICAiZGVjb2RlcjIuMCIgPiAvc3lz
L2J1cy9jeGwvZGV2aWNlcy8kcmVnaW9uL3RhcmdldDANCj4gZWNobyAxID4gL3N5cy9idXMvY3hs
L2RldmljZXMvJHJlZ2lvbi9jb21taXQNCj4gZWNobyAkcmVnaW9uID4gL3N5cy9idXMvY3hsL2Ry
aXZlcnMvY3hsX3JlZ2lvbi9iaW5kDQo+IA0KPiBIb3dldmVyLCB3ZSBjYW5ub3QgcmVhbGx5IHJl
YWQvd3JpdGUgdG8gdGhlIERDIHJlZ2lvbnMgZHVlIHRvIGxhY2sgb2YNCj4gMS4gaG9zdCBiYWNr
ZW5kIGFuZCBhZGRyZXNzIHNwYWNlIHNldHVwIGZvciBEQyByZWdpb25zOw0KPiAyLiBtYWlsYm94
IGNvbW1hbmQgc3VwcG9ydCBmb3IgYWRkaW5nL3JlbGVhc2luZyBEQyBleHRlbnRzLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogRmFuIE5pIDxmYW4ubmlAc2Ftc3VuZy5jb20+DQo+IC0tLQ0KPiAgIGh3
L21lbS9jeGxfdHlwZTMuYyB8IDQwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysNCj4gICAxIGZpbGUgY2hhbmdlZCwgNDAgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAt
LWdpdCBhL2h3L21lbS9jeGxfdHlwZTMuYyBiL2h3L21lbS9jeGxfdHlwZTMuYw0KPiBpbmRleCAy
NDRkMmI1ZmQ1Li5jNjFjZDJiNWFjIDEwMDY0NA0KPiAtLS0gYS9ody9tZW0vY3hsX3R5cGUzLmMN
Cj4gKysrIGIvaHcvbWVtL2N4bF90eXBlMy5jDQo+IEBAIC01NjcsNiArNTY3LDQwIEBAIHN0YXRp
YyB2b2lkIGN0M2RfcmVnX3dyaXRlKHZvaWQgKm9wYXF1ZSwgaHdhZGRyIG9mZnNldCwgdWludDY0
X3QgdmFsdWUsDQo+ICAgICAgIH0NCj4gICB9DQo+IA0KPiArLyoNCj4gKyAqIFRPRE86IGRjIHJl
Z2lvbiBjb25maWd1cmF0aW9uIHdpbGwgYmUgdXBkYXRlZCBvbmNlIGhvc3QgYmFja2VuZCBhbmQg
YWRkcmVzcw0KPiArICogc3BhY2Ugc3VwcG9ydCBpcyBhZGRlZCBmb3IgRENELg0KPiArICovDQo+
ICtzdGF0aWMgYm9vbCBjeGxfY3JlYXRlX2RjX3JlZ2lvbnMoQ1hMVHlwZTNEZXYgKmN0M2QsIEVy
cm9yICoqZXJycCkNCj4gK3sNCj4gKyAgICBpbnQgaTsNCj4gKyAgICB1aW50NjRfdCByZWdpb25f
YmFzZSA9IDA7DQo+ICsgICAgdWludDY0X3QgcmVnaW9uX2xlbiA9ICAyICogR2lCOw0KPiArICAg
IHVpbnQ2NF90IGRlY29kZV9sZW4gPSAyICogR2lCOw0KPiArICAgIHVpbnQ2NF90IGJsa19zaXpl
ID0gMiAqIE1pQjsNCj4gKyAgICBDWExEQ0RSZWdpb24gKnJlZ2lvbjsNCj4gKw0KPiArICAgIGlm
IChjdDNkLT5ob3N0dm1lbSkgew0KPiArICAgICAgICByZWdpb25fYmFzZSArPSBjdDNkLT5ob3N0
dm1lbS0+c2l6ZTsNCj4gKyAgICB9DQo+ICsgICAgaWYgKGN0M2QtPmhvc3RwbWVtKSB7DQo+ICsg
ICAgICAgIHJlZ2lvbl9iYXNlICs9IGN0M2QtPmhvc3RwbWVtLT5zaXplOw0KPiArICAgIH0NCg0K
WW91IGNvdWxkIHVzZSBtZW1vcnlfcmVnaW9uX3NpemUoKSBoZXJlIGluc3RlYWQgb2YgYWNjZXNz
aW5nIGZpZWxkIGRpcmVjdGx5Lg0KDQpBbHNvLCBpdCBkb2Vzbid0IGxvb2sgbGlrZSB0aGVyZSBp
cyBhbnkgZW5mb3JjZW1lbnQgb2YgaG9zdHZtZW0gYW5kIA0KaG9zdHBtZW0gYmVpbmcgYSBtdWx0
aXBsZSBvZiAyNTZNQiwgc28gcmVnaW9uX2Jhc2UgaXNuJ3QgbmVjZXNzYXJpbHkgDQphbGlnbmVk
IHRvIDI1Nk1CIGVpdGhlci4gVGhpcyBwcm9iYWJseSBzaG91bGQgYmUgZml4ZWQgc2VwYXJhdGVs
eSBmb3IgDQp2bWVtIGFuZCBwbWVtLCBzdWNoIHRoYXQgdGhleSBjaGVjayB0aGUgc2l6ZSBzaW1p
bGFyIHRvIHdoYXQgeW91IGRvLCBhcyANCnRoZSBleGlzdGluZyBjb2RlIGFsc28gYXNzdW1lcyB0
aGF0IHRoZXkgYXJlIG11bHRpcGxlcyBvZiAyNTZNQi4NCg0KPiArICAgIGZvciAoaSA9IDA7IGkg
PCBjdDNkLT5kYy5udW1fcmVnaW9uczsgaSsrKSB7DQo+ICsgICAgICAgIHJlZ2lvbiA9ICZjdDNk
LT5kYy5yZWdpb25zW2ldOw0KPiArICAgICAgICByZWdpb24tPmJhc2UgPSByZWdpb25fYmFzZTsN
Cj4gKyAgICAgICAgcmVnaW9uLT5kZWNvZGVfbGVuID0gZGVjb2RlX2xlbjsNCj4gKyAgICAgICAg
cmVnaW9uLT5sZW4gPSByZWdpb25fbGVuOw0KPiArICAgICAgICByZWdpb24tPmJsb2NrX3NpemUg
PSBibGtfc2l6ZTsNCj4gKyAgICAgICAgLyogZHNtYWRfaGFuZGxlIGlzIHNldCB3aGVuIGNyZWF0
aW5nIGNkYXQgdGFibGUgZW50cmllcyAqLw0KPiArICAgICAgICByZWdpb24tPmZsYWdzID0gMDsN
Cj4gKw0KPiArICAgICAgICByZWdpb25fYmFzZSArPSByZWdpb24tPmxlbjsNCj4gKyAgICB9DQo+
ICsNCj4gKyAgICByZXR1cm4gdHJ1ZTsNCj4gK30NCj4gKw0KPiAgIHN0YXRpYyBib29sIGN4bF9z
ZXR1cF9tZW1vcnkoQ1hMVHlwZTNEZXYgKmN0M2QsIEVycm9yICoqZXJycCkNCj4gICB7DQo+ICAg
ICAgIERldmljZVN0YXRlICpkcyA9IERFVklDRShjdDNkKTsNCj4gQEAgLTYzNSw2ICs2NjksMTEg
QEAgc3RhdGljIGJvb2wgY3hsX3NldHVwX21lbW9yeShDWExUeXBlM0RldiAqY3QzZCwgRXJyb3Ig
KiplcnJwKQ0KPiAgICAgICAgICAgZ19mcmVlKHBfbmFtZSk7DQo+ICAgICAgIH0NCj4gDQo+ICsg
ICAgaWYgKCFjeGxfY3JlYXRlX2RjX3JlZ2lvbnMoY3QzZCwgZXJycCkpIHsNCj4gKyAgICAgICAg
ZXJyb3Jfc2V0ZyhlcnJwLCAic2V0dXAgREMgcmVnaW9ucyBmYWlsZWQiKTsNCj4gKyAgICAgICAg
cmV0dXJuIGZhbHNlOw0KPiArICAgIH0NCj4gKw0KPiAgICAgICByZXR1cm4gdHJ1ZTsNCj4gICB9
DQo+IA0KPiBAQCAtOTMwLDYgKzk2OSw3IEBAIHN0YXRpYyBQcm9wZXJ0eSBjdDNfcHJvcHNbXSA9
IHsNCj4gICAgICAgICAgICAgICAgICAgICAgICBIb3N0TWVtb3J5QmFja2VuZCAqKSwNCj4gICAg
ICAgREVGSU5FX1BST1BfVUlOVDY0KCJzbiIsIENYTFR5cGUzRGV2LCBzbiwgVUk2NF9OVUxMKSwN
Cj4gICAgICAgREVGSU5FX1BST1BfU1RSSU5HKCJjZGF0IiwgQ1hMVHlwZTNEZXYsIGN4bF9jc3Rh
dGUuY2RhdC5maWxlbmFtZSksDQo+ICsgICAgREVGSU5FX1BST1BfVUlOVDgoIm51bS1kYy1yZWdp
b25zIiwgQ1hMVHlwZTNEZXYsIGRjLm51bV9yZWdpb25zLCAwKSwNCj4gICAgICAgREVGSU5FX1BS
T1BfRU5EX09GX0xJU1QoKSwNCj4gICB9Ow0KPiANCj4gLS0NCj4gMi40My4wDQo+IA0KPiANCg0K
VGhhbmtzLA0KSm9yZ2Vu
