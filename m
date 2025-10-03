Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010067.outbound.protection.outlook.com [52.101.193.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FF910F1;
	Fri,  3 Oct 2025 01:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759453405; cv=fail; b=iOlGkHNPkslk/MLDaEHMbYRQOqrcqthoGUzZWj8xHt6BZ9oJspqJbqsVuqOI47IuA9aXRk6FSRvtzvZ6eagX0HOQUTIHyqgHrzGlYHSjR3TmrSjjTcyEyqgBuVTvZGR0TykTEnMkckL0pw/A6u15E0kmFNnUtTT4ICufIGiI0Ng=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759453405; c=relaxed/simple;
	bh=aZPDKfxmgrRl9DAW8cScZzMj7vgiWSK2xBSE/6l3wc8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cUvyvuF7ufbtEeunrkPpprunyMe17P+t/gbGO0T/p+fcWFKf1zYVWhrtPjw/H7+w6x80UJZVkfb7Gui0VueXEPNz2XEDG9neTmWMYFdv2sqKwk5Pnu4ObjNibhKz5ChU5oxct9XixF4Zuiw/f1g2jnJlJJQg6ebwEcdYF9giSdI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=guUfy6V7; arc=fail smtp.client-ip=52.101.193.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="guUfy6V7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rgh13oWFyyLUctrtejYr7Tsp0qT1hxWbj/6nFAOSgSP9kxMvTimJASkdiT9ZA88awW61rflet0vvD5M59FUpMsQsQ7v+Qlx45aYYtgBOr8RIBFmpUGqILyMRUQBdXcSIcjrswWr7W4pNiQNATxiClIJU7B1uw5B98mirTjXUTnu3p7Hp/15sdpWwdqjppbjhLW3V0YYV8MsdC/lmhSNzZ38VZg+dMe2eHeDcgwtjfNOH2wmqyZ84VwITjK5plfN1bI4+C3I+vmbrXJrNSi/0MhLu3p4kAukfqY5lvFPseFv5gVSUXQbktlkDFJSJZxDafgx7AoumQI53pC/CsbJNlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjH9ddsoXxjGn4FcWGBKUcDeqhkMcYbZ72F7YJrYsAs=;
 b=HQDmavDiwu0EthDBRYPyr7mXIBSI4L6FtovrQiP89kCuWocDq369LMqR2wx4UeRsxjpc0dHBs1GPf9G+b7Fa1Mks9yOzBd/o7eBn7dTkCjsELwgDTADD1FO2/KiAWOed7RN0xyeDSrcrpdW1tq5SnL4sI4Rp/pwjb/W1YNIS2gn3KzMgxEQkDse1sZyNFFvFzPetfb6kqK6/Cna2Wb6orbdImV2YcbhIgB1wm7TW8eTIYgEA6rpbvxRAjgcxSUHAYdqf3pConBXnugDNWqdaFN/WcEjcCrf9vZHIKobg2BMSR0kNaYENHcEfSb/j46ZH8lyUhTjqVBHBV3voNk9+bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjH9ddsoXxjGn4FcWGBKUcDeqhkMcYbZ72F7YJrYsAs=;
 b=guUfy6V7imcjgYUo3tmGdAk7BVRQGZuVvxghtaACbFz08yYPx6zpgtWY9fC8jdm8/t27bJ+g/DJoOHG/GI8nViuuliBmIxLgzbUrSzu/EKdu2ePKOXufLU5yRhkYK0SzHfELPBC7fPWZWDv4O2eqJbzqbyvXYHfi7vz3lqdwYU2kY3kyeajH5ALbaq29C2wqM3ZLGMlVN8Ag6PQOBJqwdHJLUH5m3Sdh5A0nQMgQHuEJKXbbILRqEzh8NIndGPsAJtNZWWjT/zVYqTzFv5SjI/e8fOE6ZT26yRT4vqvoAX1aLfm5A+JQGIButvwTYMWEM83ESAicp/vhMl40ZpjQqw==
Received: from SN7PR12MB8131.namprd12.prod.outlook.com (2603:10b6:806:32d::12)
 by SA1PR12MB9546.namprd12.prod.outlook.com (2603:10b6:806:459::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Fri, 3 Oct
 2025 01:03:16 +0000
Received: from SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::ce21:6749:3d4e:2c61]) by SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::ce21:6749:3d4e:2c61%6]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 01:03:16 +0000
From: Vishal Aslot <vaslot@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>, Gregory Price <gourry@gourry.net>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, Li Ming <ming.li@zohomail.com>, Peter
 Zijlstra <peterz@infradead.org>, Dan Carpenter <dan.carpenter@linaro.org>,
	Zijun Hu <zijun.hu@oss.qualcomm.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cxl/hdm: allow zero sized committed decoders
Thread-Topic: [PATCH] cxl/hdm: allow zero sized committed decoders
Thread-Index: AQHcMxKXHWr3vqKdSEWsp5C061+MVLSuWlYAgACjEoCAAJ6eZA==
Date: Fri, 3 Oct 2025 01:03:16 +0000
Message-ID:
 <SN7PR12MB8131EE31375531673BCF0C62BBE4A@SN7PR12MB8131.namprd12.prod.outlook.com>
References:
 <SN7PR12MB81316C958DF0F4B10369B928BBE6A@SN7PR12MB8131.namprd12.prod.outlook.com>
 <aN4SSEmaCaxbeiwJ@gourry-fedora-PF4VCD3F>
 <02a4b5f1-ad29-4825-9040-ff96e328f674@intel.com>
In-Reply-To: <02a4b5f1-ad29-4825-9040-ff96e328f674@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8131:EE_|SA1PR12MB9546:EE_
x-ms-office365-filtering-correlation-id: 8dca60f1-479a-4640-404f-08de0218a2dd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?y2mM4ogWoE6wUsHzLuDT6v5C8jYcksrqr4tWNgS97gbUiMAvPLFhvi2TfE?=
 =?iso-8859-1?Q?t6pBYXE2Ox0t0JL8ocXkBeQU1xMJ7ev8UKcqaTaGgOfLa50dspLvBChmdC?=
 =?iso-8859-1?Q?R9nAWxq6EnnPZkSwsS/ya6/WChnfOmEP9cXinXUzNsV6gG2/ioYO7cAeEz?=
 =?iso-8859-1?Q?qvl3482mN1zXTFUbmybKLMxeM+0Oz6r83HdFSgeFpIJ3453ny25IUooLq2?=
 =?iso-8859-1?Q?Nev7vCL7nKl+FkqiGrDep5jjbTNGxBWRzvzstBy30/DPEpIcLtSjhSucle?=
 =?iso-8859-1?Q?VkoGewG0YfzpllhkRY24ilzZbFO4aKzgB/LoVQoUxvRjEvuzHSTICD+bT+?=
 =?iso-8859-1?Q?Ezotx9Xp+JVPhhqHo997QdujyTjeC5ZhQmOoUnHEpRVcfM3/ct3/nSAQCo?=
 =?iso-8859-1?Q?ZQt+zdzsqrhivNQGXH9kJlfFk9OCeQ78vokplS20aLMGVi4T+DbV7P8/q6?=
 =?iso-8859-1?Q?vLTDj/ydppAomZteIFkwBD7cSbDtBfmnEpKtrtlTtDgRtM0iLye8UIv7/I?=
 =?iso-8859-1?Q?q4x3Mbaf6na/LXe9d1bz6rNIJyFMIMRV5/z4oCUxSQNJM2WgYiXu0stFWc?=
 =?iso-8859-1?Q?Wl30pb8ZGY1YnSUeT2EFh0Vadn6V3UOtC8Wsx/Y85mpVLwsdr1xnhHUEqn?=
 =?iso-8859-1?Q?iCh+Knj60bytCYZgzU37T5vaHKgChVr6gg4ey5FQONq3a1P8LFC3f+nPvH?=
 =?iso-8859-1?Q?qIju+omjxoC5uwQcblmG7vUxsXsRQGP5H9knFDfZAOBmbwFxa9r/NxXD+9?=
 =?iso-8859-1?Q?sB4jz19wsFusuehbbXjjXH79S4WbPvJ/fVD3GxlVzC668lRHRoDsUuofOk?=
 =?iso-8859-1?Q?AZ9MOa8Ha27w8mOeKMS/oTtJllBllRg4TkPUPjHjW981JRrvI6I1JngSR5?=
 =?iso-8859-1?Q?uzqcaJFsJeQs8sKcfXA4dLk7KFiFPjkIkjCz5YLCpFzLLJ9vxsX95mcyCs?=
 =?iso-8859-1?Q?3CgGRlRiT3DRq+8rAbSIs81JXRaS3TZq2RdDh1xoHrW55BG6dTJog5pnTn?=
 =?iso-8859-1?Q?G8s0DPzIK/h/w/XfoCEFmhlrQBpZzO3LTq8ac4oHbZDKkoZsSejZKdmgIU?=
 =?iso-8859-1?Q?09Jf9gV520OiFyQcXWY7womMhLPnJlxF9dkHoCd5uOdexrdRwX/ONOwctd?=
 =?iso-8859-1?Q?N05jwy3zPeQag7+WvtIz35gDPsj7DLg0W+oZSsgk2ANvjiDSPc0njDtmot?=
 =?iso-8859-1?Q?4e6aK14RnJPah8/QnArkiJWXjBs6Fgb/oLQ+zNIisrgchugcWqVj0JL+tI?=
 =?iso-8859-1?Q?uoYoYuP6s0ghiPf8uc+PNfqhPV6gVG5O7ux9HKafRsdf+/V5JbQ/J9i6xL?=
 =?iso-8859-1?Q?ttbiaddAdbtl13MlxpcnC+ZTe/XmVkUCsl6l3rFeMJDMqy+7TzzvInAo3W?=
 =?iso-8859-1?Q?mNrpmIyqF8NOE5JlJrZbtdeAeI/mdBvQAfCgPG8EvRxTaWhi7JHSGuv4xd?=
 =?iso-8859-1?Q?8n01kqGPFAozzLwuxBTq7S+UpyqAmXzWP0NWXKqOLHUj8XjCXAjcUg4oYI?=
 =?iso-8859-1?Q?+l6pLhatGdBBbzmMcZFqegKEmHDRbUUT+cy3Jkbul4hlMkRw1E9Wycf6z4?=
 =?iso-8859-1?Q?7Y4LCTuJke4exn71fEbvgrq18xIp?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8131.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?6TSma/89LJ2UuJirqH1ER9ToiIbUnoOxU08Q18tvTPgPY6JskvSi/wb0Oa?=
 =?iso-8859-1?Q?CJANj5qh00Qrr+BXYoP8N6kszUFBrn26KKPGSfn7M6fDwZ5JeoLotP4Ec9?=
 =?iso-8859-1?Q?uvP5+6ErlEN7M/uFuh9hbRFE9z35UWMi60HnohtiSj9VimRcLT+S2yioFZ?=
 =?iso-8859-1?Q?9Ul6t0GDsJ1vkBHLGS5ZxsfDcp7hriA8HC9Gh4uqYMI8NdqCFAbj9dOQLd?=
 =?iso-8859-1?Q?dmc8h2tWhwiIQM4yujLe4lLWcjcIh/ftSNWaSAUX6g9m3/wheepsifehRK?=
 =?iso-8859-1?Q?ZZ5hmj7XzqJyLRjnVwDeDnE/qE+/z2JrDSId1c32VAJ8kTZrXPaT1x2zaD?=
 =?iso-8859-1?Q?/K9N5Psh5MKcy7IV0PTBeS6gUW8k+O4bV8K9hMiqGkGyyEE8xjJR1k9cAl?=
 =?iso-8859-1?Q?evnv65xR5gKp8OYXRbVyFBoj5cmHWonkkTkW7VH2al/TIEKt33HewccvSn?=
 =?iso-8859-1?Q?dz+NbbClz0Z7BE4q3QWFG4Nj6yP2WWfCjcBz910xe86V+oZX6r9TL+mhM5?=
 =?iso-8859-1?Q?IvaTgtfryXXLHIzt/K9EL9Mlgkb0D4j+k+x8czZdV9RrvNBpkY4ikWVNT6?=
 =?iso-8859-1?Q?PJFlkCpKc5b8eNMFCv9JTj+tRCEC0OMMp0Tb3xbKZVFoI0cJjk4OHNj/Je?=
 =?iso-8859-1?Q?Jrka+lLbmXNsaTx0+pbjnhhNKNS5XsJ2PrY7J5PnOpP+7i67LEDhk1LCyS?=
 =?iso-8859-1?Q?z6EweRzrT3yWqwQraHgzaNxAHmtYX8rmWXOlLKCgcNAW/aY8ZfiOqR0gv6?=
 =?iso-8859-1?Q?p39DDFPUguupX88kDfVQ4ATvBUUXaFwp8lEHqL0xmmHA0LaC/FQ8ztqGv1?=
 =?iso-8859-1?Q?/qNxrJ48pXFFfQhj0b8du/TSicKNHEwZuCNAEOTSTLdOTdzcLa25eeI0WN?=
 =?iso-8859-1?Q?KTm3zczllEYoyiZwQ9iluc99/v4JSV26v+7tUGHVN9VUBxg0VlGJw1Whnh?=
 =?iso-8859-1?Q?EzC6ys3uBUrxxtp40D9c7QLO8joRkfEos50DDvUcA4KMvdDQlPXmgWgp7u?=
 =?iso-8859-1?Q?LeW84NE/V+YF7XyvC+MMq94zEy2AKKkxbladNun9eqG7W2xvUihp5Qnm7s?=
 =?iso-8859-1?Q?ThrO+2tZYykINwVElzN7sPJiigvpppbzd2kNIKjemBcTYLE94hvz8m2e5x?=
 =?iso-8859-1?Q?YoEIsuzmyx4XFCeYrTwBij9iIq2Waj9LaHrD1P80/ZoKWDxsQ8lEyMxDPR?=
 =?iso-8859-1?Q?Hybz66g0oEFVj+9AVzRF2JaA4F/975yqNP74TyBuQBfz5WaqX1VM4uBF/z?=
 =?iso-8859-1?Q?hWn2LmyIUIIsC1iDJ0kOK1CIrLp6QfMDnWVvs0D9ch0FF41EYAtIeEYGEj?=
 =?iso-8859-1?Q?VOjyB33Xi8HMTHePGLgbtClF1Akbz1GAWZ2MVtC5AGTFWK380JPpXnaewP?=
 =?iso-8859-1?Q?imK/QgzLSb50+cARYo+b+929zCY598C2ZG78locIwu81K0n2gSTBNo0qlH?=
 =?iso-8859-1?Q?8YY28yPirUiqd+qFM9VfhYvbYm8zCHMgd7ozI1CE/Jek0dXwxDUzaTHWgL?=
 =?iso-8859-1?Q?+tZRWcBv2dhiCh7U56XL2coRbHJiTMH6MsQJJGnBs/POZmkDuebpTGzhny?=
 =?iso-8859-1?Q?bf+YXGtOJ7SMDXpGEpJayKU0pIZseOh3abMYhZJ0hSB9U1sAzIVd+vFusj?=
 =?iso-8859-1?Q?dlKeyJNZ4hj0E=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dca60f1-479a-4640-404f-08de0218a2dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2025 01:03:16.7466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4lVl3r99bhkIVT5u5p7ASMCoZFimlSHs7Xt6oIIzKcDhCWj1xJoakuyqfx2FLuSu9TuzbmRFg3c1DTh2tGEdvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9546

> ________________________________________=0A=
> From: Dave Jiang <dave.jiang@intel.com>=0A=
> Sent: Thursday, October 2, 2025 10:32 AM=0A=
> To: Gregory Price; Vishal Aslot=0A=
> Cc: Davidlohr Bueso; Jonathan Cameron; Alison Schofield; Vishal Verma; Ir=
a Weiny; Dan Williams; Li Ming; Peter Zijlstra; Dan Carpenter; Zijun Hu; li=
nux-cxl@vger.kernel.org; linux-kernel@vger.kernel.org=0A=
> Subject: Re: [PATCH] cxl/hdm: allow zero sized committed decoders=0A=
> =0A=
> External email: Use caution opening links or attachments=0A=
> =0A=
> =0A=
> On 10/1/25 10:48 PM, Gregory Price wrote:=0A=
>> On Wed, Oct 01, 2025 at 08:37:26PM +0000, Vishal Aslot wrote:=0A=
>>> @@ -1210,6 +1210,11 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *=
cxlhdm,=0A=
>>>                 rc =3D init_hdm_decoder(port, cxld, target_map, hdm, i,=
=0A=
>>>                                       &dpa_base, info);=0A=
>>>                 if (rc) {=0A=
>>> +                       if (rc =3D=3D -ENOSPC) {=0A=
>>> +                               put_device(&cxld->dev);=0A=
>>> +                               rc =3D 0;=0A=
>>> +                               continue;=0A=
>>> +                       }=0A=
>>=0A=
>> How do you suggest actually testing this? I briefly poked at this in=0A=
>> QEMU trying to commit decoders, but i found myself incapable of=0A=
>> exercising this path.=0A=
=0A=
I tested it locally with our BIOS (UEFI) where we commit and lock all decod=
ers and=0A=
all except decoder 0 are zero-sized.=0A=
=0A=
>=0A=
> It may be worthwhile adding a cxl_test test case for this.=0A=
=0A=
Yeah, sure. Would cxl mock tests be the right place to explore this?=0A=
=0A=
>>=0A=
>>>                         dev_warn(&port->dev,=0A=
>>>                                  "Failed to initialize decoder%d.%d\n",=
=0A=
>>>                                  port->id, i);=0A=
>>> --=0A=
>>> 2.34.1=0A=
=0A=
