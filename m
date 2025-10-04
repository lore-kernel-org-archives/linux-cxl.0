Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010068.outbound.protection.outlook.com [52.101.56.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C824188A3A;
	Sat,  4 Oct 2025 13:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759584895; cv=fail; b=JR0nD0RY172cDks1NQ1ssc1uR6PYcRQBulCYCFnbJsJwW136rrs826A5uNNcpTAppX8azKiM+1IsLOOoxsqVFqsoBajZWbj8fwhV8son1JDKpVtG7GHyeykaUvp7blX0G54bu13wYfkIiz5R7JNTy7X+1/vell4/SDq3fc1y31E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759584895; c=relaxed/simple;
	bh=bG1otvyWb8uDPS/X5CoOp+sE7s6KYDK251qiyO8EoHk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VzIA/Pyh6EjRC90jwj1TNsOL5DwJNYwLv/FBGYHciroEfG7q2HCDw2olqQzliOdyDyVsX/PIhhlKXX/Am3QFzaR/7Ae0S4ruOY7EZr3YKN0uXjAyR+3DKrbgMcZQFz0oGGTeR+alw8njQ2iMRAmLRQFQgPa72Z7vHB1db3nyRW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dyxn7etM; arc=fail smtp.client-ip=52.101.56.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dyxn7etM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=le1eI3JGSmAAHF/0BhTaKw+b/ZHa6QEdYsCIuEWKoNbdnknyjTFqg6byD9W2vtGaTnGIpFu4JjkVQXOw+FN2LhiJIhz1iJvABKiXlfy9jLW59+kSaM0+fS2TW+hbsvEejZ91dC+x1KUCRAETDQ2FZpxMA5zXOgFOuU5FuplfvVl+vWTNIguCKxs++qLMY6Sook8pCpFQnFtzOoNmnwH7RfDUlRdNO3yA5WDtm6KlmEAcLg8fbw+NE0YLiVKEb3VX5sEFBO1SAqT34gcJMk77QTE3vQE+vmVdHQxC+BWTCQrSCfMJDYib+WFe+Tj6oBBCdeZ4LhGPH8hL8dcLB7OIsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bG1otvyWb8uDPS/X5CoOp+sE7s6KYDK251qiyO8EoHk=;
 b=qZfPKEBmRinLWswoKwBp2y6zcKLkdftcOTaMR7su5/WjGmVAT3hDHLX2QSXWIAU9sxu0cMcfDpEQZ7enA1s+CyNRrepXgR/GwTmiNJo/0kClXsGdkpVA3U08vFw1lkZR/emNsr77NRqRauCAtlEDx0E8rZHsISQoMkQBVTIk2UVq/wV9mP4lTiHStxP334QGNfVsOqjAP+PiFZkmqHqNdBnxdQhl7abqSbOjnvgMKdxqy6/tvAcWRR3a/f4JQB+mlNb/If7frOjO/XqEw6Y4/0g//nu0xBcvrFY5rdIKIc23PViugErOLJg7CvJBdaUaG0xJn2gaiC5xmi9FgfLx5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bG1otvyWb8uDPS/X5CoOp+sE7s6KYDK251qiyO8EoHk=;
 b=dyxn7etMZqSCXioiOXExkiEDkSs23GqKRoJttKucXVeO2kll3x22Z/FpB9E4MJgblAXD0KI9SVXM+REouegTEZ3MRu5NJ06BtcbLP3uV7pT+jAfAlKbPnA55W6dz0T7KFiTIXCjqN926mK1kkMjHn4+UbsOyvRGyBCxtV9s8KNGQh4H13MuMkQVvSpyaraW6aq5kdlR5IXwH7MGtEO1xBr2G8uZQVvWtUn+OX/XiHCqNN99wOVkUeLovzfiasVT5BODMo5HiqEX7C+ohWuFMH5fBAFp9sqWXL2x1mwCtUUSqZxgEvKQDHA4zjOX8EFFWBcScTjJ4BKYlh8SZp+vdDQ==
Received: from SN7PR12MB8131.namprd12.prod.outlook.com (2603:10b6:806:32d::12)
 by DM6PR12MB4234.namprd12.prod.outlook.com (2603:10b6:5:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Sat, 4 Oct
 2025 13:34:46 +0000
Received: from SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::ce21:6749:3d4e:2c61]) by SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::ce21:6749:3d4e:2c61%6]) with mapi id 15.20.9160.019; Sat, 4 Oct 2025
 13:34:46 +0000
From: Vishal Aslot <vaslot@nvidia.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: Dave Jiang <dave.jiang@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, Li Ming <ming.li@zohomail.com>, Peter
 Zijlstra <peterz@infradead.org>, Dan Carpenter <dan.carpenter@linaro.org>,
	Zijun Hu <zijun.hu@oss.qualcomm.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/hdm: allow zero sized committed decoders
Thread-Topic: [PATCH v2] cxl/hdm: allow zero sized committed decoders
Thread-Index: AQHcNADr7CR1e/ei5UC/raGgi2gvQLSxHXeAgADg8Vs=
Date: Sat, 4 Oct 2025 13:34:46 +0000
Message-ID:
 <SN7PR12MB81319DDBBDE50B372F99E9D1BBE5A@SN7PR12MB8131.namprd12.prod.outlook.com>
References:
 <SN7PR12MB81316C958DF0F4B10369B928BBE6A@SN7PR12MB8131.namprd12.prod.outlook.com>
 <cb300580-1297-4d4b-9a3a-2cf7445b739b@intel.com>
 <SN7PR12MB8131FBDB82D2A3A539FA09D0BBE6A@SN7PR12MB8131.namprd12.prod.outlook.com>
 <70a2ea96-0a4b-4185-8f37-ea77ed757b64@intel.com>
 <SN7PR12MB81319CD146CC8B4CFD45E62FBBE7A@SN7PR12MB8131.namprd12.prod.outlook.com>
 <SN7PR12MB8131F796BAE8B6243E088879BBE7A@SN7PR12MB8131.namprd12.prod.outlook.com>
 <20251004000631.h4vnnpxathjyoez7@offworld>
In-Reply-To: <20251004000631.h4vnnpxathjyoez7@offworld>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8131:EE_|DM6PR12MB4234:EE_
x-ms-office365-filtering-correlation-id: fe833dde-88d8-4ae9-aab8-08de034ac8e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?RvDb5Dn5XsLyVB/J90duTLNeWfSm6UcPgmAF7KSO28GpmKgqqIpRkF52tV?=
 =?iso-8859-1?Q?JYn7MV/6Z2zrs/eFFKfd7F1bW01iPgwgxU+B8oPO4t28grG7tOFGeZY1Wm?=
 =?iso-8859-1?Q?Oe8Yj0fNAMwRKh6y+XAk+iovl5G+aux1JjKHhSEYf+XALsnJgdMjZeYHFK?=
 =?iso-8859-1?Q?UM/uP0P2BTqprNdqj0FUnEheywaUghvSV2bXI9Y3qc6rzNeVJANwTJKtg4?=
 =?iso-8859-1?Q?Dueme0MDdexTQr7+lnWHer8uzQSSt+jVuYrN3dsEif+br/zx7E2L6ZBVeA?=
 =?iso-8859-1?Q?3VIbq7deQUeR8UrRO71pjfac6DwezCikI3ZIo9T7R91RagQrn/PrCCGOBP?=
 =?iso-8859-1?Q?RJQ9kE7RhpoYbFCaboZ/o85b8XiyWOTo16CY5Bl1A3f7nnBLabmej/I0jH?=
 =?iso-8859-1?Q?0sIXI7TAVJVy1vngKfUW3Nt8bswqMlJM2O+TBkj8gfxP+Vjhx18zIA7ehl?=
 =?iso-8859-1?Q?vF2CK9Slkh2lUAB6yFjfCdPRM1nW1RoCpRrNL2d3lDhEqqn/uEutja1wfc?=
 =?iso-8859-1?Q?NA0cnpUSU+/k9AbFCgYoPNdDlcPpGxnCS+sZ4zmqerDVcAq0YqjVoAqzv6?=
 =?iso-8859-1?Q?Nj+67eVacxvY3RJVwqngyKzHSwzmImboEX9dzzb+ZzEQEYPNplQsxH86kG?=
 =?iso-8859-1?Q?uFLHn/XDyjMvHzOyBHh1qZb0WjsBA3GGUjp9jspzkxeX8wfYq/PBRl6b8k?=
 =?iso-8859-1?Q?cR1Jof+FYism4IMo7zHO5LIhT8FYQFToIbNlVpnWrGwy8nLtJf7AuGKYfK?=
 =?iso-8859-1?Q?5btR+sJyV5jHCTkaym32PuxFO2jo5Cr6TUpayIjyJFiULeQpbR4umOisK0?=
 =?iso-8859-1?Q?4bBEmzVFKQJheZlzzpiKeaJKnIF2QvMCtw5pOB8OIDN7xzLUN6tr0KTKge?=
 =?iso-8859-1?Q?E83H67urLNU0xT9sOfIFyImWjSWCYImh3Y2pa2OxEYzCwjwJnlAE3x28Pq?=
 =?iso-8859-1?Q?SRIXBQfAF/JQtFULSlIEL0/KCCUCdY9rWu2erD4j8/It+4nsHhQzV1Pnbh?=
 =?iso-8859-1?Q?pFfF/9UmRte5QuxKf0L5eRbg6SDPLNeQcLBNT5/RqZmgFR12fAEuzJsdms?=
 =?iso-8859-1?Q?p8owuqZJxIsc1c2lfbOznfIVarfSvt3pmcl49uHYMeMm5YVsOwVRbmeBTG?=
 =?iso-8859-1?Q?+mZQYxLlaIo5StAXEBYRIwtADekF32sQ3boRtR6nxAEFTJpNudNk+y8GQH?=
 =?iso-8859-1?Q?qIr658AQlmKhb3zkoiogXwDUd/qtUYbTH54CSZN09n/0dQ3kug3ewr+nB0?=
 =?iso-8859-1?Q?fPPXlW4FsQzKU99ykwPaVVn49SOxVxhjtpN5ALZSz9ASNeqUTbikXPTZ6a?=
 =?iso-8859-1?Q?nxIp+0ZZFDIWDmlBlRrKl+B+DrN3FcQbui31GzNYIrRTLjuKsvSUTDEsjF?=
 =?iso-8859-1?Q?nCZS2e7s0s540HMHr9VpVfu0wTh7W6gI0mY1RHvIKarxqWEH/qyEaZ8YDo?=
 =?iso-8859-1?Q?CH1wSr54/BZ0RFwCvtqQpxePx5A1YU+xnAAMXZBfTfhv/gwZandWGdxm3B?=
 =?iso-8859-1?Q?+eFsXU7tGq7GJqKi14cMe1CZGXUMOq+pnWx9uD+eWyJNs34/CFAFbL8bA9?=
 =?iso-8859-1?Q?xqJpGwdCNob2N1FY+ztsq+4VRGge?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8131.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?hVj7M/07jHsS9lSxRixItZ+1sLUnhTGaeUsAGfl6e7mFgBab2cO2hJ42pV?=
 =?iso-8859-1?Q?CpjZMuIDGOm0yl20x6TJ+i9ekB0M7XIAq3W9fRsoO5pYD6W2fQjf6CnxHr?=
 =?iso-8859-1?Q?nB61UzqOuZ0kdSvuQAfRcqQvCOf3HHsG9c1L7aHH+wA1Qhb9A2cNb+2EJS?=
 =?iso-8859-1?Q?AiY68YWBlNxdFYRG/lZ8yZu0Yz2GrRt8F4VmGi+38decVXAtiQIwUlf08L?=
 =?iso-8859-1?Q?s+LPIAigtKX8XJC1kuH8rkg+4gKK0oW6gt/OxVLt7p6dbVlwvKfGunyXo6?=
 =?iso-8859-1?Q?OC6HjAhiiA3zjrWikl8RIhU4RIRLq4e7SPqvuPJ/6F5jTdYkxGEun/xZ4T?=
 =?iso-8859-1?Q?R6qBbPPv3h0EjQi9UkVIU1L/vwlK35IAvsgD4IYKy0NZLv0ioVbm3a1YoE?=
 =?iso-8859-1?Q?fRck/AeH2rvMWwt1z+BWx5MfzPXf+r97DnbdQp313wI0ujzZgRwNPKioKd?=
 =?iso-8859-1?Q?398ZGvk8QZQThskvn4vqVxfv5fYL/1S3jGYYitlv6W+PmiVGxBigIUAO3u?=
 =?iso-8859-1?Q?hmS2dHE3j4hwd5GRRoe+qfoFac4WZLCT4dMeqxnUpC22ixrU7KjVMPgBx2?=
 =?iso-8859-1?Q?4hJr/GsI00Wr3KArrRcI4FQyMi5BdFjjCc2qXC52spjkKpWIlpyq+11vQp?=
 =?iso-8859-1?Q?ut3kAm+JndntkFw0O5eLJBzT2OmrI9qbM+BTiqHd3zEfloaA+iGP+QP6VJ?=
 =?iso-8859-1?Q?2vRMsV0Klw6UP2kUTqMQRwZWT/BKHcEEaqzh0TtuhfyA/WKJSQ87nJDN5G?=
 =?iso-8859-1?Q?tVyeWamuoM1rA1ZxWjCYsy8gpV+Ps5ntrP3Q+CtvHOdCNCbksXokYxdUoH?=
 =?iso-8859-1?Q?undNrb+/tEJ3HLZnYjCxdz6PCEjA9I1UTEf9kHydC5sj7n8DMiCE4CSgIM?=
 =?iso-8859-1?Q?Ew6NFGzc481JCrR7BtkTC/hGQ+mLzL4Ug6WtvqmkfCvuJ807orPw4BGe+P?=
 =?iso-8859-1?Q?LoADamh+8gi5J3D0yLWYDr/DblA5qjw9sthBg0fuX1wbEVEUaBmhrvc8Hs?=
 =?iso-8859-1?Q?agunbjLJnBo+MS5iDedq1ib4vq5FHWAKXVw52eJJqWTWiG1imJo6YFgt8A?=
 =?iso-8859-1?Q?aQ7gHNuEHXugMtLI3orjTSY4CP23UVsTMNFBzYkmjbV+D63yKyVbpebw4E?=
 =?iso-8859-1?Q?cOMBZFy7YGytDvYC6qkxOUpvC5T4QG1a9Tg0DpE4iX1QNCBEHm5PDRqb+8?=
 =?iso-8859-1?Q?98FSRmnvtUhG2AuN1vu9MIP+k5I74uNAdKA1Dkb4+JkXGzbt5quWbEMgnh?=
 =?iso-8859-1?Q?Umk2yoReDWWy72cc5krkkvDE6HFb2FDKwI4ypI9ecRQnRycivMC4uod2QW?=
 =?iso-8859-1?Q?wry+O+1jYkaSfzsv55uCSzTQxRPyGZAjO7Cowt+OEsZdanP+1+cgyljy3E?=
 =?iso-8859-1?Q?f0rS0kHB5z89rdYm/k7xviBPQ8v+B29At9Oz90Tzc0H7LYo0Zt0LWy2FhU?=
 =?iso-8859-1?Q?bpwrIa2+iAVKUiJzCP10LVpOIiAnUo+7Oc2DtbvWoT0wwvoh8sbL8GyWq3?=
 =?iso-8859-1?Q?4YR0cjdFYgBuQsi6+glYu/mTkWWLV+QQcKmBQLmnhipJcOa5JNEUTkvpv6?=
 =?iso-8859-1?Q?bbDaocxNCjsCayQCW2ruUismlrbJIUc0VU1BLzq11Fpm1LiTlo+ML3dEpc?=
 =?iso-8859-1?Q?8rEueiX6EPi7I=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fe833dde-88d8-4ae9-aab8-08de034ac8e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2025 13:34:46.5860
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y3nefiQKSKXWQel2QAt6kR1NDLQssijoNVfBXwIC/ReEtVBohJgto3fBS8rhU3Dm9OJH2fZS8wSuJPVINO8+Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4234

> ________________________________________=0A=
> From: Davidlohr Bueso <dave@stgolabs.net>=0A=
> Sent: Friday, October 3, 2025 7:06 PM=0A=
> To: Vishal Aslot=0A=
> Cc: Dave Jiang; Jonathan Cameron; Alison Schofield; Vishal Verma; Ira Wei=
ny; Dan Williams; Li Ming; Peter Zijlstra; Dan Carpenter; Zijun Hu; linux-c=
xl@vger.kernel.org; linux-kernel@vger.kernel.org=0A=
> Subject: Re: [PATCH v2] cxl/hdm: allow zero sized committed decoders=0A=
> =0A=
> External email: Use caution opening links or attachments=0A=
>=0A=
>=0A=
> On Fri, 03 Oct 2025, Vishal Aslot wrote:=0A=
>=0A=
>>init_hdm_decoder() fails with -ENXIO if a=0A=
>>committed HDM decoder has zero size.=0A=
>=0A=
> This can be removed.=0A=
=0A=
Thank you, Davidlohr, for the review. Much appreciated!=0A=
I will remove it in v3.=0A=
=0A=
>=0A=
>>=0A=
>>The CXL spec permits committing zero sized decoders.=0A=
>=0A=
> This is enough info, no need for the quote below.=0A=
> And then add "Linux currently considers them an error".=0A=
=0A=
Yep, will fix it in v3.=0A=
=0A=
>=0A=
>> See "8.2.4.20.12 Committing Decoder Programming".=0A=
>> It says,"It is legal for software to program Decoder=0A=
>> Size to 0 and commit it. Such a decoder will not=0A=
>> participate in HDM decode."=0A=
>>=0A=
>> This patch updates init_hdm_decoder() to return=0A=
>> -ENOSPC if the decoder is commited with zero-size.=0A=
>=0A=
> This is not needed in the changelog. Instead the reader=0A=
> could be enlightened for potential reasons and use=0A=
> cases of 0 sized decoders.=0A=
=0A=
Understood. Will update in v3.=0A=
=0A=
>=0A=
>>The caller leaves the decoder allocated but does not=0A=
>>add it. It simply continues to the next decoder.=0A=
>=0A=
> Thanks,=0A=
> Davidlohr=0A=
