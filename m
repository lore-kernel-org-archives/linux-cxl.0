Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012061.outbound.protection.outlook.com [52.101.48.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B03487BE;
	Thu,  2 Oct 2025 01:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759370239; cv=fail; b=UgBgMCReheTv8lvEn04ewYLbPSYEy+Spi76mnde0P0PTSDvFIOd2pvJ9o4mLrEBxmTqrXZKQvDLX4o8X6hi/CEJjz/FRAgWeWB9fa6i/zowKsRapGBFvEXz9AkC+uUjaMI5qlZpD8aYFp22jSb2JtBSWLUGGB7uxbSfVJalQX1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759370239; c=relaxed/simple;
	bh=Q/oOFWZ4lEErKUHQQWIAFvCJ5DA/NcgT2hOt45NDSz8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MxDG4gSRVo726fhlRjGo597FE3Ssyk2TF+szeMrWS2aKIFMHP8+r6c/buEyVQmvwUlF5tKX4GeQE0syeS5TsX8rJE/khHAahsJ0hPXrQLgMm8rmQRZCm69PRQ9OJGKOd3cfm2GAXSJ7xBzK0QbzJg73zLMHhJzf81EU1xYAaMHI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IBHUa0CQ; arc=fail smtp.client-ip=52.101.48.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IBHUa0CQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+jQtuXK9qEJdZYgc89gJePBfB7ZcgpwmGO0rEmMbCJBcVsV/NyOp7B0nCqGSVte6581L3gtEkiFRWgFyFNO06p5XvQAOgIaYY4oLCTOVQ8j6rLVIZ8ttMt9DY8uPNUqkN4HbsanJS4vb13Qguv79kS/Evau9jcGz01B+HqUwtU8kUlu2o4Po5GRveB2cT7R0ON0Q2x0YRiVxnALgSEYNB0B/QId2OUyi3LOM7ndl2AliqWl1ZVKRrc0oDy7MHqvbnQQlbPTbq1PQJyaYe/zxL2C8hcV3zkyYvlGD880dVclGDyquY8SCav1fBWiruOyK86PT3wCGCemYfAcnagNZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7s5aQWCTNtE1gJsOsM1SlDwo6Saz7F0aAVGTW7MEzxs=;
 b=c6SB4qZzShWz9auuPqrZ7TL9cqt6oeUKIIQxayyIHKPDsMlVcWs2lPI94gZGRUbrE43FX0SJCEqWKfuuns13FhNBedPOFNKNkhkhfmX0Mky5R3xsaaCCFe9UDt1uzfxmHjI7Dy1QETswfPkWlXD5qUPfv1n0kbV9XfJblWOCkXYkL3wC36h5PYyaCEbRaJM8vXpub9a26apXF5/3m3U7LwR2gOx9KUUQ9O1s/yDLRKYmEehWLKld9jPEhEIGFw6fed/p8nGbsSTYIobdbLDvAbO8cFLUibsmN/gVBzil30/b6tOVOsMPGX/I8xyYb+lcvgOqSvC8/3EB6sJhSXLVqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7s5aQWCTNtE1gJsOsM1SlDwo6Saz7F0aAVGTW7MEzxs=;
 b=IBHUa0CQugDwyHxkJjwrE9ranjQ0M+TK6GI3n+nHHojrluzB8WiKbIe1gaSMIFFxMj1NkybIdXwu1qx6LbnplWoQyhfAn9gw/8tuC34omulFV/QmNiL1k3xJqPQkwTnD1MMaZneeBHNY7mzNLcxrfJbQpoOQvRVZTHga9aCWTq7vCcFti4psqY2KUaYzVtPJERn2XuVPRap0ORHbioJmMiqmxdU3qgqG5Nq9an+NLbzz6v7ZpJxQdvjBrwC76c6UfKWRPwqn8pXxNch3QNQKkenW6BGTdL/nI03TcmqjavgnY//UCO9C52JQt6q8rubw/9OzavX2BWDp8Z+c4oWqXg==
Received: from SN7PR12MB8131.namprd12.prod.outlook.com (2603:10b6:806:32d::12)
 by SA1PR12MB6824.namprd12.prod.outlook.com (2603:10b6:806:25f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 01:57:14 +0000
Received: from SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::ce21:6749:3d4e:2c61]) by SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::ce21:6749:3d4e:2c61%6]) with mapi id 15.20.9160.017; Thu, 2 Oct 2025
 01:57:13 +0000
From: Vishal Aslot <vaslot@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira
 Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, Li Ming
	<ming.li@zohomail.com>, Peter Zijlstra <peterz@infradead.org>, Dan Carpenter
	<dan.carpenter@linaro.org>, Zijun Hu <zijun.hu@oss.qualcomm.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/hdm: allow zero sized committed decoders
Thread-Topic: [PATCH] cxl/hdm: allow zero sized committed decoders
Thread-Index: AQHcMxKXHWr3vqKdSEWsp5C061+MVLStzo+AgAAJi5yAAAwgAIAAMwl4
Date: Thu, 2 Oct 2025 01:57:13 +0000
Message-ID:
 <SN7PR12MB81319CD146CC8B4CFD45E62FBBE7A@SN7PR12MB8131.namprd12.prod.outlook.com>
References:
 <SN7PR12MB81316C958DF0F4B10369B928BBE6A@SN7PR12MB8131.namprd12.prod.outlook.com>
 <cb300580-1297-4d4b-9a3a-2cf7445b739b@intel.com>
 <SN7PR12MB8131FBDB82D2A3A539FA09D0BBE6A@SN7PR12MB8131.namprd12.prod.outlook.com>
 <70a2ea96-0a4b-4185-8f37-ea77ed757b64@intel.com>
In-Reply-To: <70a2ea96-0a4b-4185-8f37-ea77ed757b64@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8131:EE_|SA1PR12MB6824:EE_
x-ms-office365-filtering-correlation-id: de7fba01-ca71-4f4c-2cca-08de015701d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700021|921020;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?LDoA+gyytZutCWnrFgmgpbAneMHA3MsE/M3UmCHX+sfjUIJdzN1b8l8z/w?=
 =?iso-8859-1?Q?lsgCSa6ZRsrBdwnF2wwn/f5znkgdFlqpLIWyTHmoA01a9eFyvYoUq/+baw?=
 =?iso-8859-1?Q?25yONHj8iO0XXF8s4OOUHa8W9IqPQKWwof6GEVYzL/vmJSULDb9owfLSX4?=
 =?iso-8859-1?Q?IJ0k4juBTnkqTw/zgMpF0UB5vVPB2/uMroxT/LUNKyKOciSDGwPB6jh7AR?=
 =?iso-8859-1?Q?vGckaIgv78f/1QEqeCm539RRX8ULTZpbBMyZWfb+F8YhKpKbI529soh+gu?=
 =?iso-8859-1?Q?p8zPZQ7OTQKHjnezrWyp72b0bfQ46qHx0aEk2E7Nj780C5ClvQi9ON/7QR?=
 =?iso-8859-1?Q?ZfiCTO40xsMpiDvJtIuH8uJBQ0etO9IYx8/6nJu/LlpANcLOXJIDTo+EKK?=
 =?iso-8859-1?Q?HXa+QZ4+L7I2NEK6vVZCPf3YBEsiZRc699kSdVa2ei6qxphzkdBEsTETaj?=
 =?iso-8859-1?Q?j2ocSM0RrGNNBJtgPYzPGTamGwiVRxwYZ1mDXHoTlr07+J8oUw+kXU1EEj?=
 =?iso-8859-1?Q?meAvyCuVl2QLOrBHTf4OArLwXWo7ghC1JH2oTj52+bGn82Y4faiy8hVWQ1?=
 =?iso-8859-1?Q?M7NMtMLXYQUFVQVb3MXW28huabwOJ9DIuJdvYSmXG0unPAZ+GI2vbgaYlO?=
 =?iso-8859-1?Q?GLzK6tB8qmIdb0yeGNsctq7jhSAVNxwqVkF7NwCmYHZ+1SGNOlvE5c3ia6?=
 =?iso-8859-1?Q?8RhnB5GwYILD3s1MYVh87V6VjNq7df6wXvLm/lJ+jDNpDLxy8C6jpP9mUk?=
 =?iso-8859-1?Q?mGrzAJ0uTneCjlHj8W/tXOJ1HinMcDopqY8qXKOYF5Sr7tm+jT4Fh2WPGw?=
 =?iso-8859-1?Q?5bMSsXjaSmFwFg/bVmkxhBr8JVwjevrUDmNuknmgG0Kgdtk+3TMsqEJQ1L?=
 =?iso-8859-1?Q?2a8RD1CqyUFhyFkZSXXpOVtKjAy1xSgQhTCkar4gFqzzu4NFGVvMnYcIGn?=
 =?iso-8859-1?Q?gxc4rDliE8bGerskNApZib7G8TdWv6G0C65XkZqYSQUYRt1vPiIOKZfUAg?=
 =?iso-8859-1?Q?jFm9LlP6OF5jls6NqZckG+M4YdCsSbQlp4IIFwlR0LDzMR+hRcUHfVE6/S?=
 =?iso-8859-1?Q?u+Ab5Rpk1L7iJzgZb2bu6Hvkmi12P+/3GVhk+OjlINCDGRm+uKBtYLu5os?=
 =?iso-8859-1?Q?L50MKUW6LH6vyyKSfdxESiPhEdSF7vzT9qP75cBCDPi1ZDbbepSrrXH27Z?=
 =?iso-8859-1?Q?/CF9GklclAvzImKpRHudw4I9+sNffXWj3ngkuoCUG/x00W/w0sV5LfEmRC?=
 =?iso-8859-1?Q?teA/lPj+DOO/5JDDmEpkb5KEO6nLDTL8zAX3tK7QQKs/8A+J8gQn1QOldt?=
 =?iso-8859-1?Q?VIotNR6DH4JRFt20Mze0K+TKNOEyu90xlzsHvJpZmkUe6MWsWGfkckDPDK?=
 =?iso-8859-1?Q?bPy1bWrkZI5Wyq8QeS9tkLdK0Wk9xu5zF8V9Y5PRnxNk6XAhckGXcmUMH3?=
 =?iso-8859-1?Q?7nzdDkml4wukVnbUOH+wnpFuKLfAbDDe3Uuk67gBuAr2rk9XfYb2ybgwOg?=
 =?iso-8859-1?Q?fclC+VZ/AODKxCdFRLHyc5dP0jmxvpbkwlzEKtTAX/hwbt23hezwEdkFjJ?=
 =?iso-8859-1?Q?pc8bHHtWFzbPDZEVwJsSVJSLF9llkZgxE1EeEce/Qm3xae1tBg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8131.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700021)(921020);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?7BTVSGnOD+wQecbcEC++KJAMWQ2zfpHxms4Zke4hjjVxIaO7NtjnY24SUB?=
 =?iso-8859-1?Q?Q65dKtJwFgpyp64hWjJawFXhDj/B3/ytENDNPEMCRvYbN1u1O4lQJPeoYz?=
 =?iso-8859-1?Q?ycJ2mU8z1yluUhikgzXxCzXFksHeCvzHjloSZ6kai8ztykuDDHFjWRYHEV?=
 =?iso-8859-1?Q?RPzYEE7EvsZLThaj7oW6gKUnX0JZEkEV/JAGW5VYqcrwIWx1clQlyGzInK?=
 =?iso-8859-1?Q?BFgDU40673zRCW6/qJOpguSBz15D3jb38o8QyQHGkLEU2wzkCJM6tsg91d?=
 =?iso-8859-1?Q?SYiWGqbzwfVSyBpowQlhI+EzNFC7OWkghF45Q/gN7uPoH3APxSbcW3yCJx?=
 =?iso-8859-1?Q?gxQZaD7vg8hH4VoZxvbLGgM+evXvdQOHnd7mgLpMahZPCZo6r8WH2usFdh?=
 =?iso-8859-1?Q?QzgQIYFG/j3Ur2cBTBtbRaX3lkwgrzJmvBLbAcRcKTjLRAUxe643/kYXzY?=
 =?iso-8859-1?Q?159MqdL0lcoCycw+qEZkj+x4pAhxzmS6vgHWktuMP8RJSWlCZD8dN69p9x?=
 =?iso-8859-1?Q?Q6HMU+RK8ONIXmySSNDnxe15o/zThdiefiLQ2Ld+ZLb82MF/NZm/+/tIIi?=
 =?iso-8859-1?Q?p5JgD+77hwozDnGbxsi8J6l+RrvtUSsm8EaKexg6gsJQqlaXUfZPGUvXCq?=
 =?iso-8859-1?Q?CM15j/XnKCONx/IHd1zo5q6fmhlqrwKQhYBPeX60IyBIWKtkILYxycyOHb?=
 =?iso-8859-1?Q?AmDQyHCMpBMaYkabXuO1angL1ZUeRC88+ZnHP1Byacin9QOKLOxohblujH?=
 =?iso-8859-1?Q?gCv941x9wewykulqKHL3Spr7MVUtDRipehT0bi5BgQQmyf3dpFuYazaPZd?=
 =?iso-8859-1?Q?UeozYpObB0fIO4vxO/zuaPW4LEgUcVjFyzTavNVRIKUn3IBAfOIdc19B4P?=
 =?iso-8859-1?Q?/IscOrKDNtV6efY6rvT0Ull1NgRQvl4A+CuikM+Srakp8KGNkhP/zgceid?=
 =?iso-8859-1?Q?Dca31HPmtxKBx7gV8t9j061MrOsXhC8WutXTbWQ/SawHz64eNZ+h75tCad?=
 =?iso-8859-1?Q?4Dh+qKzt0PR+VmQ6iPGM1QNm+z3gWsMWkGw1cNtzX/9Mh8x7SWvJS2hVj3?=
 =?iso-8859-1?Q?cfFPbVN+H6ZNBFiuj0EC5hP5y0EiLiPEixMMECHp8ldR6Eiblqjt82DvWD?=
 =?iso-8859-1?Q?KLVg2o7+NsSrdLNgczPpkBBNnxA//YuausE1yy1H9IZieznF7atM866TxR?=
 =?iso-8859-1?Q?fiioeJ0ZbCJcnbXHAvvSlHqtUqV9XfGxKGoksSiBrSyREol2MS79+wMv0I?=
 =?iso-8859-1?Q?QOQU//15vCb2rWMckpC04vcjkd0IGbyTIUxmM4N7dPhIHmNO9AV3du6JIK?=
 =?iso-8859-1?Q?zEyXOnFnMTVVL6DB0bm7Mk2+lYk7V5zqmr//ajRVpAt3gA3N9Rn0BUaxic?=
 =?iso-8859-1?Q?3uT/9E81fIYJRXEdwq2qxSe+iZCRx7IwfN2T3RwjeDjzR7XyTKRXdQh1Z6?=
 =?iso-8859-1?Q?JoUzsGsHD6477HZiZdtaHHkjjHFtbmWpV59SPUJlAjQdiiYLP1nSxhESQv?=
 =?iso-8859-1?Q?bL/JNjWM1eh06xGJUIiwB4M3yLVM/UJaYtsgXwH+QXSwE5VIcKxc4DD1VA?=
 =?iso-8859-1?Q?9mk6Oq6vl9dtwteqyW0VRJPNZs3T+ml8T+6f3uyVcNU9CC/3Ecg8zHIsbj?=
 =?iso-8859-1?Q?tp/xWlbkTihgs=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8131.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de7fba01-ca71-4f4c-2cca-08de015701d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2025 01:57:13.7497
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LU8vBgeLdx5bwF7fu9IjBicc0KNo2NIFIgtd4zLPmmFUgrwFWtyT9E3ZpvawbN4uItNxc3KWWfio0CX+YdSJ6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6824

> ________________________________________=0A=
> From: Dave Jiang <dave.jiang@intel.com>=0A=
> Sent: Wednesday, October 1, 2025 5:46 PM=0A=
> To: Vishal Aslot; Davidlohr Bueso; Jonathan Cameron; Alison Schofield; Vi=
shal Verma; Ira Weiny; Dan Williams; Li Ming; Peter Zijlstra; Dan Carpenter=
; Zijun Hu; linux-cxl@vger.kernel.org=0A=
> Cc: linux-kernel@vger.kernel.org=0A=
> Subject: Re: [PATCH] cxl/hdm: allow zero sized committed decoders=0A=
>=0A=
> External email: Use caution opening links or attachments=0A=
>=0A=
>=0A=
> On 10/1/25 3:03 PM, Vishal Aslot wrote:=0A=
>> Thanks for the quick review, Dave. Yes, forgot to put the commit message=
. :)=0A=
>> About the copyright message. Should I not be updating the year to 2025 i=
n it?=0A=
>=0A=
> I wouldn't bother unless you are doing massive changes and in that case i=
t would be adding NVidia copyright anyhow for you. Also, typically linux ma=
iling lists prefer responding inline and > not top posting.=0A=
=0A=
Ah, understood. Thanks for the mentoring.=0A=
=0A=
>>=0A=
>>=0A=
>>=0A=
>>=0A=
>>=0A=
>>=0A=
>>=0A=
>>=0A=
>>=0A=
>>=0A=
>> ________________________________________=0A=
>> From: Dave Jiang <dave.jiang@intel.com>=0A=
>> Sent: Wednesday, October 1, 2025 4:28 PM=0A=
>> To: Vishal Aslot; Davidlohr Bueso; Jonathan Cameron; Alison Schofield; V=
ishal Verma; Ira Weiny; Dan Williams; Li Ming; Peter Zijlstra; Dan Carpente=
r; Zijun Hu; linux-cxl@vger.kernel.org=0A=
>> Cc: linux-kernel@vger.kernel.org=0A=
>> Subject: Re: [PATCH] cxl/hdm: allow zero sized committed decoders=0A=
>>=0A=
>> External email: Use caution opening links or attachments=0A=
>>=0A=
>>=0A=
>> On 10/1/25 1:37 PM, Vishal Aslot wrote:=0A=
>>> Signed-off-by: Vishal Aslot <vaslot@nvidia.com>=0A=
>>=0A=
>> Missing commit log?=0A=
=0A=
Yes, will add one in v2.=0A=
=0A=
>>>=0A=
>>> ---=0A=
>>>  drivers/cxl/core/hdm.c | 9 +++++++--=0A=
>>>  1 file changed, 7 insertions(+), 2 deletions(-)=0A=
>>>=0A=
>>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c=0A=
>>> index e9e1d555cec6..97a5f27f5b72 100644=0A=
>>> --- a/drivers/cxl/core/hdm.c=0A=
>>> +++ b/drivers/cxl/core/hdm.c=0A=
>>> @@ -1,5 +1,5 @@=0A=
>>>  // SPDX-License-Identifier: GPL-2.0-only=0A=
>>> -/* Copyright(c) 2022 Intel Corporation. All rights reserved. */=0A=
>>> +/* Copyright(c) 2022-2025 Intel Corporation. All rights reserved. */=
=0A=
>>=0A=
>> Stray change?=0A=
=0A=
No, it was intentional but I understand that for this small update, I don't=
 need to update copyright info. I'll undo this change in v2.=0A=
=0A=
>>=0A=
>>>  #include <linux/seq_file.h>=0A=
>>>  #include <linux/device.h>=0A=
>>>  #include <linux/delay.h>=0A=
>>> @@ -1050,7 +1050,7 @@ static int init_hdm_decoder(struct cxl_port *port=
, struct cxl_decoder *cxld,=0A=
>>>                         dev_warn(&port->dev,=0A=
>>>                                  "decoder%d.%d: Committed with zero siz=
e\n",=0A=
>>>                                  port->id, cxld->id);=0A=
>>=0A=
>> I wonder if we should make this dev_dbg() now that it's a valid case.=0A=
=0A=
Yes, makes sense. I'll change it to dev_dbg() in v2.=0A=
=0A=
>>=0A=
>>> -                       return -ENXIO;=0A=
>>> +                       return -ENOSPC;=0A=
>>>                 }=0A=
>>>                 port->commit_end =3D cxld->id;=0A=
>>>         } else {=0A=
>>> @@ -1210,6 +1210,11 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *=
cxlhdm,=0A=
>>>                 rc =3D init_hdm_decoder(port, cxld, target_map, hdm, i,=
=0A=
>>>                                       &dpa_base, info);=0A=
>>>                 if (rc) {=0A=
>>> +                       if (rc =3D=3D -ENOSPC) {=0A=
>>> +                               put_device(&cxld->dev);=0A=
>>=0A=
>> Why put_device()? Should we enumerate this decoder instead of pretend it=
 doesn't exist? essentially only a dev_set_name() and device_add()?=0A=
=0A=
That is a good point. The decoder has been committed so it should be accoun=
ted for in the OS.=0A=
I'll remove put_device() in v2.=0A=
=0A=
>>=0A=
>>> +                               rc =3D 0;=0A=
>>=0A=
>> Don't think this is needed since the continue will put it at start of th=
e loop where rc gets written by init_hdm_decoder() return value.=0A=
=0A=
Agreed. I was being paranoid. Will remove it in v2. =0A=
=0A=
>>=0A=
>>> +                               continue;=0A=
>>> +                       }=0A=
>>>                         dev_warn(&port->dev,=0A=
>>>                                  "Failed to initialize decoder%d.%d\n",=
=0A=
>>>                                  port->id, i);=0A=
>>> --=0A=
>>> 2.34.1=0A=
>>=0A=
=0A=
