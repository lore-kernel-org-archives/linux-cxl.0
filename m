Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010001.outbound.protection.outlook.com [52.101.85.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8887146BF;
	Sat,  4 Oct 2025 13:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759584640; cv=fail; b=QniRMh0HcOYjMsLes6FrORHsBMwbK9GZOjuwfHOfKoJSVBEOQ5n974BAuRFdm9Bn75JpXUKTWMUn2uu7dALBJuEdH+CAQGjrtll5nUoXJB6IqvJmyBqp+EYn/gb9Aa70uP+IiTCDAm+0cYYKZNGX8Ck1yvm12GsVLZh8+VAr1+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759584640; c=relaxed/simple;
	bh=4e7HOiBjQws/+iUp6OAuVUP7WmKmojqgPnpKozJBM1I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eKTnSI7KupFn052q62hm009MLUn3ryL/SFDNgDlMSXjNs7EDNWMnIPIQzWy5uwBB1eVXoABTM1oVSFs3PMHcH/kDNG/o1DdUtfIbl5VRBvdbV6LAl4zCaIKjNk8Xp0STuQQl0Yc77ovxjMPeeJp8C67lhLbQoMhjQHvRdkUYefc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nI1z3ujK; arc=fail smtp.client-ip=52.101.85.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nI1z3ujK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ggEIlEfvpjyvyHf9il14M6Y24GN+hxiqrlTPwhSbNdx2NRSMqPQaPXIcdXhbrJKopzO6ak2c9rJOEz6ityqcTaKVAkipLzoAcj6JM4f1USYmVmPyo577FZVBWuVDfiLxcfbmvB9UOkrSdXloViI2fstmeH308pzMdUtqFJFRQHtAehkoiX3xC394B275FOjPZHhWCLndAIUNSbqm+svDzXX+CI9N0kvlzgl4HzKhTd2rUgPi40keS13u2B4bJDswRVOhn5qNzJSNO/r0mZ4Q3vaKUjzASiIZYIW6Y0NcEEIyzRHAnOZ1K4z+XhkQjhqn2X5dXKiHseqoTeabAK6yUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5svOSW5pJGkIOPXxpPBod5tjhgrveLfGpQ1wsZy0x4=;
 b=reD0Z0WWirWxqahxFqWoctQugAyOfjWvhCv4eRQJHMqZGNTEYHRz2fqJX1ID3nMwA7h90niWb0gekft51OUDgIy/gCclFmRW1sWSau2J0plG9FlbyTPiKcgKY+MsGWaqbTNbaSe4VF6LnUOKSruVvHykB9+zzjzGv2ioGtrKAmMHB+WtmAFTtpeiyl1RpiMFAOiNdQj4FPkI1ZvwAKg055XUvsw1L3jSlcTX2kVM39HoWfbPNglAMVCJ4nYZxUcELAFrHMCBRF3poxU0SUkoawgjB3Wiv7OyrwiOlHp8mmNFWn7RAMOzwLa+ITqhznpwMWthrYDLxdI7waLbARe1zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W5svOSW5pJGkIOPXxpPBod5tjhgrveLfGpQ1wsZy0x4=;
 b=nI1z3ujK8Da62a39VjcpKj5ql46mt5L2pbqa9KR4vyzg9I01AfUJqy6QRcojLWWYiojKlYMWpHwJUBv8nY+tnlwRj5CXkq74xAIJKNFa7JX0Ly32Z8cXWiE6rxOy4JBepVi/fzSSfWLnksYU9I1coQqdOELME4ixiwcDzDCQJphB4ugRHHTbZGvqVPpBLJf72k49F7qfQ6jJGdXKrkwZhYxbCSj24VJtTZ1qXMVtiGkwh6A3eFkaW+6M16taKWTOHHKUJaqJVOkI7lM4EPOAorB4m0exle7MpdziPrkypjUCoAQWy4WadJXr5Hk+tvU/2jpajUvhknkg4XsQCIoRKw==
Received: from SN7PR12MB8131.namprd12.prod.outlook.com (2603:10b6:806:32d::12)
 by DM6PR12MB4234.namprd12.prod.outlook.com (2603:10b6:5:213::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.15; Sat, 4 Oct
 2025 13:30:30 +0000
Received: from SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::ce21:6749:3d4e:2c61]) by SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::ce21:6749:3d4e:2c61%6]) with mapi id 15.20.9160.019; Sat, 4 Oct 2025
 13:30:29 +0000
From: Vishal Aslot <vaslot@nvidia.com>
To: Gregory Price <gourry@gourry.net>
CC: Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Alison Schofield
	<alison.schofield@intel.com>, Vishal Verma <vishal.l.verma@intel.com>, Ira
 Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>, Li Ming
	<ming.li@zohomail.com>, Peter Zijlstra <peterz@infradead.org>, Dan Carpenter
	<dan.carpenter@linaro.org>, Zijun Hu <zijun.hu@oss.qualcomm.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/hdm: allow zero sized committed decoders
Thread-Topic: [PATCH v2] cxl/hdm: allow zero sized committed decoders
Thread-Index: AQHcNADr7CR1e/ei5UC/raGgi2gvQLSv1FMAgAEE6Ig=
Date: Sat, 4 Oct 2025 13:30:29 +0000
Message-ID:
 <SN7PR12MB81317D99DDAB9680F10B58D6BBE4A@SN7PR12MB8131.namprd12.prod.outlook.com>
References:
 <SN7PR12MB81316C958DF0F4B10369B928BBE6A@SN7PR12MB8131.namprd12.prod.outlook.com>
 <cb300580-1297-4d4b-9a3a-2cf7445b739b@intel.com>
 <SN7PR12MB8131FBDB82D2A3A539FA09D0BBE6A@SN7PR12MB8131.namprd12.prod.outlook.com>
 <70a2ea96-0a4b-4185-8f37-ea77ed757b64@intel.com>
 <SN7PR12MB81319CD146CC8B4CFD45E62FBBE7A@SN7PR12MB8131.namprd12.prod.outlook.com>
 <SN7PR12MB8131F796BAE8B6243E088879BBE7A@SN7PR12MB8131.namprd12.prod.outlook.com>
 <aN9Q7BxpPOSYBVU5@gourry-fedora-PF4VCD3F>
In-Reply-To: <aN9Q7BxpPOSYBVU5@gourry-fedora-PF4VCD3F>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8131:EE_|DM6PR12MB4234:EE_
x-ms-office365-filtering-correlation-id: 347a8db1-10fe-41f1-f62b-08de034a2fde
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?DpK3VrXzkZnDJukLTsrYroza7Af57YGnELMcKr7RwoHsxqN+BqKiMSlljI?=
 =?iso-8859-1?Q?xEfqKxuxgnaBVM1TCB/RxGGJgjC84Hwaxzlx8q5BMJptjeNBiS8rwI0U3u?=
 =?iso-8859-1?Q?tJM2Ie1kzrqfpXCOE2+oCZR3nfQlqeHAdeB9riIUuPcmw8hY/XRRM1V0mI?=
 =?iso-8859-1?Q?ls+p1Grxnt4mzaWP/5DqFuLPx8SAW8dqNpzz83w/W7w6LUPhLpwwhKPOEg?=
 =?iso-8859-1?Q?wSIx04UG1pHVf2836/aLwzM/wHyU4JP8XcrU0h1G9LDSDqtAzCRLyjo/nL?=
 =?iso-8859-1?Q?5kktLhwpOVcIBtzKe4T8JodkY59Zbn4OnRftLgGejNeFKsgAUCk5Rfj5xv?=
 =?iso-8859-1?Q?L72ADaRE4ZisozoLZxUt8/ICbLacS9dKH7muqxsi4qhkTI7Nm0jMB4kGqv?=
 =?iso-8859-1?Q?9Ubdpq+qsOSwQj9Giu2wAopdMSJtinOS9Wc7pa9X+whEG3SDQdhpBHr1Qx?=
 =?iso-8859-1?Q?X6jenDdW3UzVoL0Z3IPcepm/rd2apRbfzms42aJq1pYJcD35sxs0sfsrUZ?=
 =?iso-8859-1?Q?JWzX137C/o1moe+DFiUIYWKFdTbUuV3joCCWbkuze62c77/AfubmR/XiF7?=
 =?iso-8859-1?Q?bDkpikIobBZEByP6F1sJyx/LdOAa0vKfYbzhRk3vchBni56jcmGL7yw2FI?=
 =?iso-8859-1?Q?iwQhoUVsmvYV/VOVeMdwhUPtpk6nAmH946f0ubEZkdmIn/UDZF3VdIIc76?=
 =?iso-8859-1?Q?G0kMRWZtjmd5OxlNXgNypz4y8iCFwZDg4uhuSlcvxuKtrYOTuT3Iii5pTO?=
 =?iso-8859-1?Q?bUhR/2BgsWa/KeGjaYRn08WUsw3yHj1YDZ28BsSvza1tEfN59XTNDNSdKe?=
 =?iso-8859-1?Q?0buH6+/UPryp72QlqMQO6XBCzpOd9iq2K2G6t/1rJIy4OTXVc9zZNq/vn5?=
 =?iso-8859-1?Q?dwI8wJua8j1NK0KW2CSXimlgRqCy88i57AmGIVJnCSpHDgdc1Vd0ojnv3K?=
 =?iso-8859-1?Q?E3SOYqCb/cb8TN8vKvkQAuZiuyXJxYizyGGR82hvVGS7x/+1J/zNj69F/x?=
 =?iso-8859-1?Q?SGfmffDsc0azjG38clccZlcFoHJXStJwE1MFtdkFwjjcIpb/Q6zWweb+Q8?=
 =?iso-8859-1?Q?VmZsEbvfbdUBgVF/uip5byS4PtmVO7kpRUL9n+ODl5kecU81+wGUxr7VKG?=
 =?iso-8859-1?Q?gHigXilm3wgoZrG5Y7mUAGmW5nkvwflv2uagHcIWm1GhxjPc1xwQvkpCu5?=
 =?iso-8859-1?Q?wvc1ltF1zu2m3kmzMIoIlNmuw55GgbNigglXogDaXGoOnWCoa/FMu4SH+Z?=
 =?iso-8859-1?Q?O89fryJycAjZa5VnoBFCv8/p95us2PaWRjxbWHxwMcyDNfYlzhP4WfAVZ2?=
 =?iso-8859-1?Q?Jn+J7HkrTJ/qC85eIqHNjd0pfDfwL+zHrM63bFL4o1lZqI7/RvdC8UJiSJ?=
 =?iso-8859-1?Q?AJP5cclO+3ds2Mdogm8jY5MQbQKwsZF7SCdGTZnjoOEwjUZqgVAk6RjO6e?=
 =?iso-8859-1?Q?CxI2c5PQwC3dXfIeH316/bJhZDrI7qU1FmhVuwx2ZxakYL+8ufRLe0Hh10?=
 =?iso-8859-1?Q?qFGs94GKmyq2+wb4XFSb6H1rBsZyZoCht8W5lhns2YQG05PBYrGwEmjlQ4?=
 =?iso-8859-1?Q?heCsEVjfenaB5KxEn1HVunbJ8e4Q?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8131.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?LaJF5JHF4GWMcm9yQrr6shteXPQ6xtVxHZSbf9oDp1qRXFwZ2ErnQTQTyq?=
 =?iso-8859-1?Q?VvXFtjT+iStQAkCJyxPpCEcIUxVB2SqJyM3wZKejeKWPH8UKCeEs40Prm2?=
 =?iso-8859-1?Q?El0f+i4syII2KcTxOtL9LXnifJQ517h9aECpbsLHOlMphUhW6ZbW5drnf0?=
 =?iso-8859-1?Q?M4e4YASHxjSspTKisByR9Pz4IPnGVORzn05bExIoblViQz+++melSuNCIW?=
 =?iso-8859-1?Q?jY8rrzOoseRXefgTTSSRc7/bckJNaf3GLz5dnXIlL8zSeNs4O7cT6rz+51?=
 =?iso-8859-1?Q?aF3pdLlkKQy/BvS10XxwIgVUXpUBlCBI8RY22RzkPjK8suOQQDsF5t5Wvl?=
 =?iso-8859-1?Q?ycLEF2ZqX3CKTrjDuaARFv/cYY9caDXk1vdisqxRMSUXjMw57g0yihBKuV?=
 =?iso-8859-1?Q?5u5w9MjpZascwqemnTMZZomYckZ74W6LSizenSsUH6CYOvQOsfYVvX80II?=
 =?iso-8859-1?Q?v1PNQdr+xmJq3HTyKipA3Muw+Dc6t1IwvN/Lob5VJ0WRHsl9sfyMMPp3Rj?=
 =?iso-8859-1?Q?T4/1x3or68+1+i0NatAVaT5Y5O57CBCBKHsdiet6M1a7pRG8EWfb6IsMNX?=
 =?iso-8859-1?Q?6L5nOPpCghkHFk6hMh3myZXTyIPwkX3iuEwhO/lR8WGqqyXcGmDcI/qIS2?=
 =?iso-8859-1?Q?ePJWg7jotFDRBLYlzfsaOLCP7pos7+cmCfwPd2BLCMmp2ollqIEhXUotog?=
 =?iso-8859-1?Q?vx4CSTIn1fzLxxL7EayXXZx80EmOXV4kTdItENmbbEHhxLPh2oY/3QKtVN?=
 =?iso-8859-1?Q?pxTLhXowyjF4Xl6D7wARDvl06wzXBR7plCqpzOwerkMqdxCXajeh7qrXV5?=
 =?iso-8859-1?Q?fLfxL2Zo53oE/mkfOHfTxWcZGCuqFwEgs4aCgh6rlRiqd3FMYEwAqxj3+s?=
 =?iso-8859-1?Q?LdeYyMe9NjT80TwKPDdDwtN/sjiE2zf2dh9c7biaD3pkhYRFpz9EAo0dWZ?=
 =?iso-8859-1?Q?JHp2A4nWmub2VXHu0513INq1xIqdjSOfouPvvqPkleKmDFldXoKSPQsG7w?=
 =?iso-8859-1?Q?aiA7KrAyI+mYDMfZj+u5a7UxPRNk7ocbd+2jx1kxXr9dw2m0ceR4hIcBha?=
 =?iso-8859-1?Q?XRFxtwWWWBNjMzJrCQE3UNAwUIst9D1IS7nUkHJdzOngeJ5LDqZTjgt5Cx?=
 =?iso-8859-1?Q?oCLlnKC7ycUPJ6L5APD3uCz3K5THDulkXxzfVo9UQ5ftoJje/qvN8r2f0V?=
 =?iso-8859-1?Q?B/AyFvR30xuDXpOWvOZyaRHmbrk3auNEKsS072u9z5m9/cJmTjBeVhQ0cf?=
 =?iso-8859-1?Q?1qozK7bjcwOvIk+OPqQVUr13QcCZchxj0sJgaSIBUr5g7z/xCRmactm79s?=
 =?iso-8859-1?Q?bnX9oU8xeZjIiJWG4VGvMrGye1RdOl8RkGmwkz9UvDf5SB3ic+c/RW4fIL?=
 =?iso-8859-1?Q?MTLLNuTPG4zh+KqHyM1qysJ0yqU7Oq4+CBSS7ILylLL0AjGPTf7Qh0n4IM?=
 =?iso-8859-1?Q?DdLVFg4WfkzS+AejdLEoffuW+PGFysZLH3SHpmgRxT9jXKeekbp0dGPZZl?=
 =?iso-8859-1?Q?kiEH3g026rJIUvl1/v4AkXG7x94aVScK+c3CcANXjKCgMWwlGbBY+mA89D?=
 =?iso-8859-1?Q?d5EqnQlkYVEVCQcfhrx+syhMhvikmNVgjVFBgrqVEeqyDvYIAilF3QpLtx?=
 =?iso-8859-1?Q?+Z/wW9uS2Tl+4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 347a8db1-10fe-41f1-f62b-08de034a2fde
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2025 13:30:29.8288
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8mVXdZvUiVYzq/yaybn+3gRQBbbNiP9SMFqfV561YJQLFjXp01O8RelREobZEGufEi9MCpMVaEX4GIVYrN8WiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4234

> ________________________________________=0A=
> From: Gregory Price <gourry@gourry.net>=0A=
> Sent: Thursday, October 2, 2025 11:28 PM=0A=
> To: Vishal Aslot=0A=
> Cc: Dave Jiang; Davidlohr Bueso; Jonathan Cameron; Alison Schofield; Vish=
al Verma; Ira Weiny; > Dan Williams; Li Ming; Peter Zijlstra; Dan Carpenter=
; Zijun Hu; linux-cxl@vger.kernel.org; linux-kernel@vger.kernel.org=0A=
> Subject: Re: [PATCH v2] cxl/hdm: allow zero sized committed decoders=0A=
>=0A=
> External email: Use caution opening links or attachments=0A=
>=0A=
>=0A=
> On Fri, Oct 03, 2025 at 12:59:07AM +0000, Vishal Aslot wrote:=0A=
>>=0A=
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c=0A=
>> index e9e1d555cec6..50164fd1b434 100644=0A=
>> --- a/drivers/cxl/core/hdm.c=0A=
>> +++ b/drivers/cxl/core/hdm.c=0A=
>> @@ -1047,10 +1047,10 @@ static int init_hdm_decoder(struct cxl_port *por=
t, struct cxl_decoder *cxld,=0A=
>>                 }=0A=
>>=0A=
>> +               port->commit_end =3D cxld->id;=0A=
>> +=0A=
>=0A=
> Went looking to understand what commit_end actually does here, can you=0A=
> help explain?=0A=
=0A=
My understanding is that "commit_end" is the high watermark inside a port w=
ith decoders. cxl_num_decoders_committed() returns this high watermark. In =
init_hdm_decoder(), there is a check to make sure that the next decoder is =
higher id by 1 (and must also be higher address). If not, it would error ou=
t saying "Committed out of order". =0A=
=0A=
Consider a case of 4 decoders (decoders 0 to 3 in xa_array/cxld->id). Decod=
er 0 is non-zero sized. The other 3 are zero-sized. All are committed.=0A=
=0A=
In the last revision of the patch, I was doing "put_device()" on the zero-s=
ized decoder, which shifted decoder ids to the left (ids 0, 1, 2, 3 became =
0 -> 0, 1 -> deleted, 2 -> 1, 3 -> 2). This is fine and no "Committed out o=
f order" error would be seen.=0A=
=0A=
Now, I'm keeping the zero-sized decoders around, so I must update "commit_e=
nd". So I moved it up before the "if (size =3D=3D 0)" check. This ensures n=
o "Committed out of order" error would be seen because each decoder is one =
higher than the next.=0A=
=0A=
>=0A=
>>                 if (size =3D=3D 0) {=0A=
>> -                       dev_warn(&port->dev,=0A=
>> +                       dev_dbg(&port->dev,=0A=
>>                                  "decoder%d.%d: Committed with zero size=
\n",=0A=
>>                                  port->id, cxld->id);=0A=
>> -                       return -ENXIO;=0A=
>> +                       return -ENOSPC;=0A=
>>                 }=0A=
>> -               port->commit_end =3D cxld->id;=0A=
>>         } else {=0A=
>> @@ -1210,6 +1210,9 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cx=
lhdm,=0A=
>>                 rc =3D init_hdm_decoder(port, cxld, target_map, hdm, i,=
=0A=
>>                                       &dpa_base, info);=0A=
>>                 if (rc) {=0A=
>> +                       if (rc =3D=3D -ENOSPC) {=0A=
>> +                               continue;=0A=
>> +                       }=0A=
>=0A=
> Don't need brackets here=0A=
=0A=
Okie. Will remove it in v3.=0A=
=0A=
>=0A=
>>                         dev_warn(&port->dev,=0A=
>>                                  "Failed to initialize decoder%d.%d\n",=
=0A=
>>                                  port->id, i);=0A=
>> --=0A=
>> 2.34.1=0A=
