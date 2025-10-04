Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011011.outbound.protection.outlook.com [40.107.208.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F1E78F3E;
	Sat,  4 Oct 2025 14:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759586713; cv=fail; b=bfkYZwO11SNRXhqOC8lxCIDyDwwKFYXnvRtuLCR6hfnPGTKLDDGGV6RdGr8DFHmG3jpeB9wkgYQWsRvigVZWLYFgtFyReBa1P1HabgzKJP5+n3g31+SNBVBc478JoUABGFXRecAEOFLRKbNumSP3CjwKUSu9wZY8Claf3aVines=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759586713; c=relaxed/simple;
	bh=RGnOnNRzAQRBXWv1IbaEA+UaqKSudoO5gdGcYZZkhOw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n3beBa0sqrfEzyzCvrjiMYZotzIP1Jz54LPCGOPn8tl2iyxHgwwb4iAeFL+KGOJAtdMTBmBNHtygE91vb1BYxjZGI2NMQoUOpNNBQ+rNfpRGAo3ADYo9o8WQCDGuHwu8ANqdifTRIr03amX+4SQez4xFBCj3XRp/uq/4MU0ObTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=g0So+PK9; arc=fail smtp.client-ip=40.107.208.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="g0So+PK9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sHL1X6ObSOXEYILomi1+vjPqglFVtQS3VvhIhzBhZDvKim6KRjvgWzvHpiIOrXo4Uze2IvLR+EJ2Kg2xQcm8ErYEX7YODYhCMxf2aHZK6tYEOdpbAKORqEhk7dyXtKJgufJ2bBXTRGESWBMDYz+/DjRjumqyjFUDr8gnE3BhBzXafBMYoc5JGJsExr18N7pjC54Et7QcW8Lih6MaZulQNzsJBCKQ5sZ//knLQOzONLdG9E9l5V/hbEluBeBdtiYNulxyTELmJBSzT5W+5eisscBlZMdRsBDdMuVYVhUO+EjH/aMWCnAUpxrGcLdi/yP5rfEjbhSk4PAK2WuuencRFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+jeASC2NW7B9CG9Gi34J5U0V8TBh4wfcs/HCBsWo8M=;
 b=X6m3GVx1Df1ist3zWaKI9/QM5wREB1FdpI/pCiqEe28tP/FpotmyFhx+gpofD19YWIxpRRDpXuTogsITq0e5Qbo9fYaW0idRdfYGhCHRsEolZ7bHf3PfTt3+hD4j2amKv652D5yI6kakc9QONzKqBreQhXjcFY8wV7lpIIx5G4nR9EpB8IRhsxIXPMzRHcLF/0EDvq7fpY18sp5k7E4iQjOZXMInvoLvi4U7v5ghj/w86XZ0hcldNu1quswVYDmkP74zv/8J3YSK9k79qRUqU+D++H4PizzCQLi7u9Abqhe9E+NIZRt1c1Cke1R8r2lCKIOSNBTUd0J0lal6e6u99g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+jeASC2NW7B9CG9Gi34J5U0V8TBh4wfcs/HCBsWo8M=;
 b=g0So+PK9ejdtIGqOTHDdLGerkXg8Pgj0PcwQuq3HZQo7/aeXfL5vHcx8neE/PKRf5M0fRDVuvYejnZpe2tJkPoSQVE8AWZ1LoxhB61U0EgYr1FdqLolTAfVB6g6d/NGTaEPI6txDF1frRyDjjGwX9nntwA9UvWb2ScOdzKn7hBr1U6DInfXu6Mvdxa9Xs49RlMSPHqrVgB6f4dHU3g53LCrIjK6OX0M8PCjsHi2ZwGohPkcQwX9uEHjdd7neC4iJBiCTMVbxklgLPfvx0Kx1dPC6N4hdxO649UCMZidRQA3xZ08oMPyuEeJ3Gus1mNgAdz9hwBbxSv+rV02HIgr7tg==
Received: from SN7PR12MB8131.namprd12.prod.outlook.com (2603:10b6:806:32d::12)
 by SA3PR12MB8804.namprd12.prod.outlook.com (2603:10b6:806:31f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.18; Sat, 4 Oct
 2025 14:05:03 +0000
Received: from SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::ce21:6749:3d4e:2c61]) by SN7PR12MB8131.namprd12.prod.outlook.com
 ([fe80::ce21:6749:3d4e:2c61%6]) with mapi id 15.20.9160.019; Sat, 4 Oct 2025
 14:05:03 +0000
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
Thread-Index: AQHcMxKXHWr3vqKdSEWsp5C061+MVLSuWlYAgACjEoCAAJ6eZIAA/2oAgAFtRSg=
Date: Sat, 4 Oct 2025 14:05:03 +0000
Message-ID:
 <SN7PR12MB8131FC2DE9E9A521CE91339DBBE5A@SN7PR12MB8131.namprd12.prod.outlook.com>
References:
 <SN7PR12MB81316C958DF0F4B10369B928BBE6A@SN7PR12MB8131.namprd12.prod.outlook.com>
 <aN4SSEmaCaxbeiwJ@gourry-fedora-PF4VCD3F>
 <02a4b5f1-ad29-4825-9040-ff96e328f674@intel.com>
 <SN7PR12MB8131EE31375531673BCF0C62BBE4A@SN7PR12MB8131.namprd12.prod.outlook.com>
 <43ca6827-2bcc-41d3-8a7b-3aec24f2b0e1@intel.com>
In-Reply-To: <43ca6827-2bcc-41d3-8a7b-3aec24f2b0e1@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR12MB8131:EE_|SA3PR12MB8804:EE_
x-ms-office365-filtering-correlation-id: 93034b79-21c6-4b53-f728-08de034f040e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?yUwKlCyIaflHcJoPix6v9d1xQwvtNjVGP/nqy97yGqga9XFwbl9iZKSpWZ?=
 =?iso-8859-1?Q?6ysg5b72p+ooEv7sfo9GjvjoLNhJCP2rMVw6ATONEt19Jl7C0h7ELu8M8/?=
 =?iso-8859-1?Q?5znxnPt/xeiIsuX8GKrQnmsQm6VFp0IWRdtov9NX0ueN5fH4qLB5DvKzka?=
 =?iso-8859-1?Q?hAOoT2Gc8qI5zOP6PZ/FcSGtwTVXQUOp7//AGOo0/6PzzCaEwG6ygGrXmf?=
 =?iso-8859-1?Q?p1qJbiUWvFGVL4sMuA0hPrucCE+8Q71ATO33toTVnUB+qiLIUf0BPhm0v1?=
 =?iso-8859-1?Q?dvQj96u4n8ua1I5d2effkAC3Gxi/1vQGHFYGi/VD80rpjIl3PxCGZn6ABk?=
 =?iso-8859-1?Q?I+xi5j238ovZKZYfFFjPtOCrEk+NUIA6ZKoprytAsQ4p+jTIrZq00YrB9n?=
 =?iso-8859-1?Q?jFAhwpkxahE4LwHYyvRC15sTrYL1bwcDPPkfGcbSedOT24kL/L0uQFSCEm?=
 =?iso-8859-1?Q?i5u/yFZuNRsBrtK1sw1Qo/7s+Ug5wCIAPOiDQ64MJ+DPv4lEm2wVc+7hFR?=
 =?iso-8859-1?Q?Jj3c3ed7wUrfhUcb0KQEHAyeseP/WB8S/YGcyz8fJ5ljJqbIKeme5hk/Z1?=
 =?iso-8859-1?Q?4KmCsTQO7htlJklQ5MxOzY4bpI6lZXPusC0pT5yGaqTsGTXUfvmNHjMAPK?=
 =?iso-8859-1?Q?OS9rPdFzx0hjJJqbwMivvlFDoXbKNLzxkMzMdma2mudHLxMbBDOCHJx35n?=
 =?iso-8859-1?Q?DqMmnjThk4E7CzYTBJm9OjD1tqGwBV3R5HMOlFJtjNDAQtqG0jbEoqPEWv?=
 =?iso-8859-1?Q?eOWZJnc2S4RSOtSgMW3L0Gsnq82Bir4H+GXENQyDUJKAeSk83Q06DsqAsU?=
 =?iso-8859-1?Q?Oi+bCHHdHJoRZ5+rW/UkY56+wIf6m0sO34daEem4lwjfgoDBMotlZbAX9Q?=
 =?iso-8859-1?Q?LizzRavXzTuDoo//qG3qazH8p6z/YCewXA+cFdNqtHY5Ijtwqz/V1KGRTE?=
 =?iso-8859-1?Q?cXroXU5Bfh6litZ/W47/E59fHdEBLM/Vg8PBUmUBY59eaz+zNH4M0hHH+m?=
 =?iso-8859-1?Q?Fo/yYJMBQCNkNFYUWZIgNTvcRboQyaqQcb97gye0kWNscRjVtsqIQmW1BI?=
 =?iso-8859-1?Q?IU8/QwL3rx5baOtsVKQ3tMAxR8n3FOxI00NlwE2KQMaRFKxnGLtP3Cr3Ys?=
 =?iso-8859-1?Q?TzrbYQ2sdlrrg++XB325bHbNXrfeCjY+S6DZszqt5CxQm6LpI9a6UH6dLT?=
 =?iso-8859-1?Q?GIcLAf9UAy0JGzbt2udvLyV8J0qvckGMyQlfehljdAFXTQuXBS1EWRpTS7?=
 =?iso-8859-1?Q?/aPZSSBulXgt3XXLxtElqY+ktNiwgK5tt8hCZtWPe1Vq55uA8kUCv2Vka4?=
 =?iso-8859-1?Q?e3lmvmRAfASvA92X3ZYmJN50jzhZi3eiy/ULKL9Lnm9PNXFula1uuOI83I?=
 =?iso-8859-1?Q?JXU4OAUrjZb4AchDeyS2FPsazAkAGwqt13oW/p1nwtJ0lVikbOq8JhxPef?=
 =?iso-8859-1?Q?vOHctrpbqi7EfkKP9Hc3pKOoZUNY3sqOTzcoITMo4Ja2QAJ7qs6UMWEFIL?=
 =?iso-8859-1?Q?HKHdKRQopLi229F96kjeIcW8XESYxPUKA+2p7GWVu+0fmlRN6mZeTvIBXt?=
 =?iso-8859-1?Q?31S9gKjl0yx64xu5ee1WUZfn4zau?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8131.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?NjqLf20lTwrWkdAsZ6X8smZAA/rSpk7jlP5kLfjZ99EqidoBgdLRm4O4Ob?=
 =?iso-8859-1?Q?tVXX3a+1382vwh83tD9iPAxtROmscC7XcsWPxu9lgRbIx9cvVRzigzD4EA?=
 =?iso-8859-1?Q?xFgg8n8LmTA20d8+siZdOYYTq3Xgae80RNXKX2TCpOJwv16INTQ2IMuev/?=
 =?iso-8859-1?Q?WEYRholNHPy1zJcqUMJHQGbAPBOTxISEcwGJuOizNShUB+eIFeAKS46U25?=
 =?iso-8859-1?Q?iu2yeiwHiijWgPhJO+DTMSins4yquTMku/Diwspe1Smkhs8L6bVHtN22k2?=
 =?iso-8859-1?Q?HHpZnqJXFsU6dNbyzNYH1y9KY5KxZ1rbzY0skHK/2bfjoRSTouCsAPtEHa?=
 =?iso-8859-1?Q?e5qkUkexYNF906ty+nAw9+S4h2QhzD7E6ObBSVGhqC/BFurLoqF+xIuxRr?=
 =?iso-8859-1?Q?P/7iW/xeS59VxPv9h+D0Yuppxe6DGos4xcQifprvN9R/4ADC5AxNl64dBt?=
 =?iso-8859-1?Q?WcFw/9POiDGZUEYXETNswYfvkAbBJyDLWalRL4ja8oovUxhPMCeP/ZIiQ6?=
 =?iso-8859-1?Q?zl9ZRorIAe9UdgOBfLOnGGcAN5fqsdjWDQAsPV9NUTXEnKyjqUy66KfofZ?=
 =?iso-8859-1?Q?bSfUh1fGfHH82+5gYf8VVR6QGK6SR9FnNyRXBLx/slRdvltt5J2YZr+9iG?=
 =?iso-8859-1?Q?1JU1N/or8WcTe5moJvoEd+DOO3VdR9oIeOo+JwS2VGfhNbJJ54ITUuVXbR?=
 =?iso-8859-1?Q?s7hp9vHYchXAQvDa06kx+Xy1CbOKJHLQEeb1+ohXIIjj6L3lfodYS2gM3U?=
 =?iso-8859-1?Q?NuHN7fiME6Epsc880/DuXJhpafdASZUAlfk9BJSx2zJS17xPT6CbDxn1VU?=
 =?iso-8859-1?Q?fbxrU54VS8G4bINdbxUH/TEu6OGt8xzuFyLeMdCulKoy4qQSFMYeOE088s?=
 =?iso-8859-1?Q?bbvAL2d1kjtLAS6PqJFqIdssjspLqdBImH3oR+UzsoPNxS1uveSdrk1PY8?=
 =?iso-8859-1?Q?wsNCCwxBXHrorN3OvpilqI6saVXqmRmZ3o5eG90UNfbNbdEelo0dClpcPe?=
 =?iso-8859-1?Q?km0HZTN4Kwm9ppkumr5AHfS6HwO1DygGI//qjPEEFb3slXQ3UZjWBGWs9U?=
 =?iso-8859-1?Q?HaHQCMOetDLBt3XxVn5uVyaQUxcHypL/wXohjN/oh2cVHDQVjD1yvWIzi5?=
 =?iso-8859-1?Q?kkZokPgfCf2e1IPhPE/yBFmuOd5i6YiJ2+xC68s7HqFzq/nj9+p1NY/0vC?=
 =?iso-8859-1?Q?hPShLOP9h3zv5YOaqjKwtJCvgJZlv4eU6BwOsqfTrIQKiuu93lmMe0iaHd?=
 =?iso-8859-1?Q?SSh/K17jZJfBsrQSeP/CHn1ElYUnNyenXsnl1d1DaOv+Mafbr5xRAAFI1U?=
 =?iso-8859-1?Q?Uyj1RvYwgXe/4i1RaxBwtl97iQPQ78WJNOdT7grn/8bdsH22Vh+WiEAR/h?=
 =?iso-8859-1?Q?WdTf0skCUjiySkCX8LC6xmhMwC2VvHdNsaBBIoSHlsFE9jgR9hqaMaTiT7?=
 =?iso-8859-1?Q?MylD3HyRoBX6AKV0E2zqoiXaCh19cDp5DI2VGpDlsiHHdEy0+Zn6DF2+Uz?=
 =?iso-8859-1?Q?8dSqbgz1Ulwo7PomYnCnmxZ2nI6kOWo1lgLOrNPKsV8/FWhtrasPFdob8P?=
 =?iso-8859-1?Q?m9me1IyswqaycMalofq/Oa6yr7eiNND7m6J/ltcDC0ka3WqRi/x+/z8mxE?=
 =?iso-8859-1?Q?T5f78c+vh+Oaw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 93034b79-21c6-4b53-f728-08de034f040e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2025 14:05:03.8097
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g3C9rE3w50wce9/Nd2taeGueHapRJ+CFrikWDV15+Qhwo6a8RWjrHx/iFotD5Hwu2yTuHBw0oFfbtUYY5hIJ5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8804

> ________________________________________=0A=
> From: Dave Jiang <dave.jiang@intel.com>=0A=
> Sent: Friday, October 3, 2025 11:14 AM=0A=
> To: Vishal Aslot; Gregory Price=0A=
> Cc: Davidlohr Bueso; Jonathan Cameron; Alison Schofield; Vishal Verma; Ir=
a Weiny; Dan Williams; Li Ming; Peter Zijlstra; Dan Carpenter; Zijun Hu; li=
nux-cxl@vger.kernel.org; linux-kernel@vger.kernel.org=0A=
> Subject: Re: [PATCH] cxl/hdm: allow zero sized committed decoders=0A=
>=0A=
> External email: Use caution opening links or attachments=0A=
>=0A=
>=0A=
> On 10/2/25 6:03 PM, Vishal Aslot wrote:=0A=
>>> ________________________________________=0A=
>>> From: Dave Jiang <dave.jiang@intel.com>=0A=
>>> Sent: Thursday, October 2, 2025 10:32 AM=0A=
>>> To: Gregory Price; Vishal Aslot=0A=
>>> Cc: Davidlohr Bueso; Jonathan Cameron; Alison Schofield; Vishal Verma; =
Ira Weiny; Dan Williams; Li Ming; Peter Zijlstra; Dan Carpenter; Zijun Hu; =
linux-cxl@vger.kernel.org; linux-kernel@vger.kernel.org=0A=
>>> Subject: Re: [PATCH] cxl/hdm: allow zero sized committed decoders=0A=
>>>=0A=
>>> External email: Use caution opening links or attachments=0A=
>>>=0A=
>>>=0A=
>>> On 10/1/25 10:48 PM, Gregory Price wrote:=0A=
>>>> On Wed, Oct 01, 2025 at 08:37:26PM +0000, Vishal Aslot wrote:=0A=
>>>>> @@ -1210,6 +1210,11 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm=
 *cxlhdm,=0A=
>>>>>                 rc =3D init_hdm_decoder(port, cxld, target_map, hdm, =
i,=0A=
>>>>>                                       &dpa_base, info);=0A=
>>>>>                 if (rc) {=0A=
>>>>> +                       if (rc =3D=3D -ENOSPC) {=0A=
>>>>> +                               put_device(&cxld->dev);=0A=
>>>>> +                               rc =3D 0;=0A=
>>>>> +                               continue;=0A=
>>>>> +                       }=0A=
>>>>=0A=
>>>> How do you suggest actually testing this? I briefly poked at this in=
=0A=
>>>> QEMU trying to commit decoders, but i found myself incapable of=0A=
>>>> exercising this path.=0A=
>>=0A=
>> I tested it locally with our BIOS (UEFI) where we commit and lock all de=
coders and=0A=
>> all except decoder 0 are zero-sized.=0A=
>>=0A=
>>>=0A=
>>> It may be worthwhile adding a cxl_test test case for this.=0A=
>>=0A=
>> Yeah, sure. Would cxl mock tests be the right place to explore this?=0A=
>=0A=
> Yes. Under tools/testing/cxl. Let me know if you need help with that.=0A=
>=0A=
> DJ=0A=
=0A=
Hi Dave,=0A=
    Would the test be a separate patch or part of this one? Thanks.=0A=
-Vishal=0A=
=0A=
>>=0A=
>>>>=0A=
>>>>>                         dev_warn(&port->dev,=0A=
>>>>>                                  "Failed to initialize decoder%d.%d\n=
",=0A=
>>>>>                                  port->id, i);=0A=
>>>>> --=0A=
>>>>> 2.34.1=0A=
>>=0A=
=0A=
