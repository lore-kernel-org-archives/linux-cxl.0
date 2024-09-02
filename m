Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4DE14A611
	for <linux-cxl@vger.kernel.org>; Mon,  2 Sep 2024 06:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725259375; cv=fail; b=e5IYGUnjKL0H/HOkFkrx7QHeW945vksFo5n2NqIW/c8Ir590NnwGT6gyYupJiAtMDRheSjYBwgt7cAYU/6t2ZNlFnKBPFQxGHXD6nQepoYNHeyduhR4CmStcPX/NyFqJ0Uv2LbCsAWL2i8qcFB2VioRtQNcgNmOoO4siw8TPaps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725259375; c=relaxed/simple;
	bh=woat6vZw5a3r5X8heJ9SbKhJtB7Jc8Mfll19cNGd5c0=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hDOg3mVdesjcXcinJH9IWhRyTDOxlL/03UbEX+PIayzSKeg2bzwnCFONRSp3b4jyDXrxbprVDIPx27tHe5ygc0iva9Ks5U1sHWKcjylNhEI7x9QO1JgfCmlnRe60PQ10fpT21UwrOeIlBwCugWVfYt59ZWpdQOd5fwNCVxpPZQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=u75z5VeR; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="u75z5VeR"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48265rOR007090;
	Sun, 1 Sep 2024 23:42:37 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 41d7sxg3gp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 01 Sep 2024 23:42:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iKE81m0M5K+wskRXy97Da0UH8GRVxH+WPFwzVyqRqUNtZ0DhFMgslk/Opjw5fEYvznlCMZ5k9FA9EF2dKRP/fRRNYYxlByrXcOmXCRxjIgCJkY/SOH5IlCEKuiwc0nnRaEkVlqYU/4fc/Eo2YQYF5td6b78gXpsJg93abUjHZ6TDRWkBGhZMpee/m/yLxSkkhCCga3pPRb6kVHpEWrgMs36NohxLxCD3f29d6K7fLJ0OuuOT6MJzHWE3qz+yLbUW57IIS42P3IQ6lKE4CRU5/VcsyN7eQeiS4ZeD1GRTK6kkPuY+QRznJ3MirURe4azAk3jwqrt1GYc1tvk2K1BaZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4xuNfCYNsUJhYOE0bE4WYYtads3Miwx5c17LMppnN0=;
 b=VEi9F80xBpta8aDkLdSTxUMR1x52BdiN79R/yUO6nObd6d9qGxhup+yea9pczgbUWynJyYO2QpNLa4i9bb+cX6Wpx5HaEPbI9r9al0tmVteXDBhiNoCK2fFw0oZ1M8OxW2ILfJ/ITmqoqxSCKS31uimMb3T1yk/F98HuqapP3Ur/IrxfsdL2KVh9GDfNF72tM6JJIh2zmuTp+IJWq4YVXegw87tdHWHVgusc6I4dcCAm1og3+zXnBmckUwDRSOMuiMWh458oFVlLniPRZ1oo/BUFEu0Ue/BjnbTEzINo+oa5S27DaOLRyD8zH8VkcZpKQOs+JN2TIlrd+Vv8DVqPRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4xuNfCYNsUJhYOE0bE4WYYtads3Miwx5c17LMppnN0=;
 b=u75z5VeRn5GTV1EeHNuecq/uSH4ftxrhYUUNNh6wurHSBjyrAsqE1Fq/ShS12Zy5V4JMHRGxLp0xCVZduKQR6uJIDEUirzdjA4xuafxCGHfBD5uWW6elifDroeLNgi8NRqJJi+EhGbByGz0Fe1dWiTdPztwrZ6vYmLVR7lFnhEg=
Received: from PH0PR18MB4734.namprd18.prod.outlook.com (2603:10b6:510:cd::24)
 by DM6PR18MB3444.namprd18.prod.outlook.com (2603:10b6:5:2a7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24; Mon, 2 Sep
 2024 06:42:34 +0000
Received: from PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::8adb:1ecd:bca9:6dcd]) by PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::8adb:1ecd:bca9:6dcd%4]) with mapi id 15.20.7918.020; Mon, 2 Sep 2024
 06:42:34 +0000
From: Shinas Rasheed <srasheed@marvell.com>
To: "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>
CC: "Ravis.OpenSrc@micron.com" <Ravis.OpenSrc@micron.com>,
        "ajayjoshi@micron.com" <ajayjoshi@micron.com>,
        "emirakhur@micron.com"
	<emirakhur@micron.com>,
        "john@jagalactic.com" <john@jagalactic.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linux-mm@kvack.org"
	<linux-mm@kvack.org>,
        "sthanneeru.opensrc@micron.com"
	<sthanneeru.opensrc@micron.com>,
        "sthanneeru@micron.com"
	<sthanneeru@micron.com>,
        Haseeb Gani <hgani@marvell.com>, Sathesh B Edara
	<sedara@marvell.com>,
        Srinivasa Rao Jampala <sjampala@marvell.com>,
        Shariful
 Alam <sharifula@marvell.com>,
        Vimlesh Kumar <vimleshk@marvell.com>,
        Dharmesh
 Pitroda <dpitroda@marvell.com>
Subject: Re: [RFC PATCH] cxl/pci: Set default timeout for background
 operations
Thread-Topic: [RFC PATCH] cxl/pci: Set default timeout for background
 operations
Thread-Index: AQHa/P7j8X+ZQdhQjUCOrX5T/sFRTA==
Date: Mon, 2 Sep 2024 06:42:34 +0000
Message-ID:
 <PH0PR18MB47345DDF79DB8970D40D3BC5C7922@PH0PR18MB4734.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4734:EE_|DM6PR18MB3444:EE_
x-ms-office365-filtering-correlation-id: ea8627da-40a7-42d0-1173-08dccb1a6d63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?epcqU4mLFv9lL7fZxVp9vLcDJ5zq0bABcrflzzoi3I37ZqRxa/5ziUfS?=
 =?Windows-1252?Q?l9YZ3sHP8DHeMHJ77kinM/mMzd51wdP3TkHWYsOM/h1k8J3F+zqEIiT1?=
 =?Windows-1252?Q?MiR4wYXEVzNj9g/UvwMhUk1WAXMZOIZPhDuel3PR5Ft0ZkVTZa2v/l6O?=
 =?Windows-1252?Q?IeW/8iiQxAtoFCLWP/He1OHYkrV+9WdIHnECxECRr38MGYnWOJByL1N7?=
 =?Windows-1252?Q?Nsqlj7P/kaDKEcHjXgX8dG0VM8EIXSR8TPk9Q4hdYMNSXYzLJdhtxucC?=
 =?Windows-1252?Q?amUmheE8M1h7csHMZuEte4jFdcfydHblxPNkg0ag+Y56lYALXMjpVZX5?=
 =?Windows-1252?Q?uy1ec5GRyYZA0PEgDwPxpJDevA+NjspqZARqIUdm/O0iB+QyhqAdjos+?=
 =?Windows-1252?Q?GcwPQYg+E8XI3PigVGvDx5BelPzLnz+9hgyWaprP0Z7cWuDyG6I3wu0f?=
 =?Windows-1252?Q?dCWaB5HOVNiYCFUMtw4MN+eNq40DUDKsncSpDgN1luedW2WPO4EUpUCN?=
 =?Windows-1252?Q?IhLZuSv7JcGH+p1BFIpOWyQRQiwfe8hhi6Dr5xjWmpTFlC2Zj7dzxeh4?=
 =?Windows-1252?Q?vTVpHnn/gCpc/3/SVB+bRIFmt9+UdtqrgUDWSzI/KgSQnYOe/WThzjv9?=
 =?Windows-1252?Q?HF22vxMdbhg7AIxCYw7KIcs74e6Uxe9u4Rw9G9QtTra85mrlwz6ERfOz?=
 =?Windows-1252?Q?XCsXHJHjaKnBZyRu3xuqv82BKpKbSj4xNB5s4vm3PFH6kwnXC+KbVtow?=
 =?Windows-1252?Q?C/6tSESTwKUS9WMhUKHb3RS7CwIVDXAeOpwro3es6/AmCvbUGmx0sDUz?=
 =?Windows-1252?Q?J/mkl4/GXg/mawsU1ixCFTUcMsxLR7QPunhxUkIimRkGHeKhS3uQ4xLA?=
 =?Windows-1252?Q?iv7JPL6GdZmn6f9k4xqKQfCPrU+A9Z7XBNaYK5i4y4Lwm/uwqvNDJocc?=
 =?Windows-1252?Q?JZIuVqsJgYQnbmLAx6mxfyaRj4t89MeuTGhHEKYLmSpQ3qnxbi+uNJWG?=
 =?Windows-1252?Q?49QShVG6Ljg2U3ek2wLHhtKefTH6vI4XsX5NKTsf7ckLY748xwYw+xQ8?=
 =?Windows-1252?Q?GEcVpScF8np8oK8LbtuFf4dASgYsVu6oKrvZLdmiEysNUny7GgSI61U/?=
 =?Windows-1252?Q?OUbL5h3TdLR+oGHd1H67BXZtIzXcyo2nErgdFIn/Jcf8+5RML8xdaxLc?=
 =?Windows-1252?Q?Gv1rfUqFP47nZWFRkodQKZ1BFrVByTiobSJLfzEpZU1fOgUGc9t2MCCL?=
 =?Windows-1252?Q?D9msEk0Tw/VJujdCCtvkaeTBDvoOaWoIyBa222Ea+8sJydQw5UbggYO3?=
 =?Windows-1252?Q?cscRQk1N5f6yBDsahdXMbdIKP11cF17cMzOeUj3LTFcUtrTutbFPlXE0?=
 =?Windows-1252?Q?lK+ok/RAKKRLwFXQMw+b5ElDEh98Iwq6piwwNXiv5HsRV3KtbPLbMN7V?=
 =?Windows-1252?Q?z+u/NByoExL1Y4q/Lbb+mqE7fFKQprOgmRZDoo+vNVYWttw/rMlA4f9h?=
 =?Windows-1252?Q?Fjsy7eRmE/ILKpZ6QsqZx3Y3Elbuow=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4734.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?bIl+xSFIrFVJpRbOGH6dT4v92YvKBKKoJeIRty+/8wnUMibI6AZYSfK1?=
 =?Windows-1252?Q?6dBp9Y3lGQ45wHiFNhcQbUp9AfL0MgSZHTeOU/I+uTboWh2UD0DJybYU?=
 =?Windows-1252?Q?hobzNb9KUIUR4Cd6pplxpaC7zBss+rY59TCAjNUZ5nIxhf33pBL0sGlM?=
 =?Windows-1252?Q?/chg5InxfFsODA7stUXrj4WhxUp0/5zSVnkZeoY4DxtxOnPuHpDrrxm3?=
 =?Windows-1252?Q?l6pVTnrTv0BwgRD/wof+Xkb9fJkBMYEH9BXjYrarBFgrDTcTQ2xyJjTB?=
 =?Windows-1252?Q?POyZolGxQOX3kdE/uM9QwzWCcbpEZJ90bHGXYGR2/6vHq0RZ4EhKeM12?=
 =?Windows-1252?Q?wuZyqBs+O7kFWpdW/F5rSXvMqQ8qUCUQKlyP1NDjY6qlN10BSQW/oBjY?=
 =?Windows-1252?Q?gaitvMJ7J35F/afHl5BWBzEy+drUgjdk3a0ea5MezNLjnigN4nexBKfE?=
 =?Windows-1252?Q?VoxP0eRgQ2keda5+eCUKSCkf6hRk6E6y/EqqL8tRI/WHHY/uEEPoeW2I?=
 =?Windows-1252?Q?GvhdDU/sjetyO6CIl/cd0P5qlem3P4wVIHx47zmlcw/pfAhDw1qdfDyG?=
 =?Windows-1252?Q?g4HXmkF0OUmsLV0wFstQhaFqRXBdDDRV8oebUdR/wJTwg5OPIVlti59s?=
 =?Windows-1252?Q?4w00aJrV9iWbp76ti5JtQLkDC3sKEFguoL46DxQ2w8uMWOQ6qJdgzAYq?=
 =?Windows-1252?Q?ZJrb3LgAXfRWu2HlTpxkq/4hoyiqnMwQk0g/Cp6vHYPXnggddEZOJ/i+?=
 =?Windows-1252?Q?F+cVaEq4oeTtd4ogg6vTfjHBYh6v3wgcePdOLcCz8WA8ARfIX3LJ/HXn?=
 =?Windows-1252?Q?iG5ydLcBMhdQQC/EARdJts5GSAYqv3HwV2LIMM+4SQ59JUaXKMeb8wsD?=
 =?Windows-1252?Q?Fbd7mVQ04O7WoKx3TVJGk2q/lBi9y7RbIrugJqpX6ruEeLHUOBSupefr?=
 =?Windows-1252?Q?1PeVOLzrTb+mbaq6tEIzSOZi3tgS60hvptneAzlxWUWdjgiR/h8xipom?=
 =?Windows-1252?Q?TQRNjd/adXpG42nwgxZHO5AiTIHMS4pjwfHGQkfPUMmy5OEJvktj0W14?=
 =?Windows-1252?Q?3Gonhr/pM92RA81FArKQaIGK/upjvXSljfHc7mumjMlwQOnaTSUxKtgx?=
 =?Windows-1252?Q?cmqaZmUvbB4nzDJFhN4xsisnPmA/RYMPl40UxWnDzuiYqcZVNz5n0No8?=
 =?Windows-1252?Q?U9wiSbokzYG3gmeRbKR55gygMMvHhGjzxJiEkAmpRQSPisu1jvKJu6DC?=
 =?Windows-1252?Q?fl4JPq8OyOvFf3eijuQfQ+RxNXGnvdn82aF+Chj5UR9gfv+hhtodMl5f?=
 =?Windows-1252?Q?1cMZ9UKmBQ5uOIF3jvuzTelNkZiRns+FzdFSJjhuQ57D0DcPfEY3mrzV?=
 =?Windows-1252?Q?73bk6gM/o3KWIh2OWwf2m7r0/+c0A30tpYmzBq8K5f74fKqTLa0z8LbM?=
 =?Windows-1252?Q?44DY8qF5xkmn4cPOjzBxPRvIFBKulThxqrPV/yjn4Y9wFjZpzIiP9/tG?=
 =?Windows-1252?Q?r91nxVe0caEU/A7PYeWJGSsFeEmpqMqyHRElgNJ0Wom7JxcNxU9WjarA?=
 =?Windows-1252?Q?Sztvf+t4WaFIE3nPddPZi5YsMSvvzmOWSsHotG6rSq49DYpZQet6b2O+?=
 =?Windows-1252?Q?8iDMCm4agES9H/iBy7QPk5FJEcZsntHvWMHdr2VATUlCsiv2EJ4Eor8f?=
 =?Windows-1252?Q?J2HtHTqd9+zvFYXq0gBMBkBA5lUqJMrk?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4734.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea8627da-40a7-42d0-1173-08dccb1a6d63
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2024 06:42:34.4225
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qomTmCG5O/G81UZHWuT9zbrKNz6FYQUTb67TtmHFkbtEJk/LA1loa2vTiIJeDIQ5R75JZSbZYn8Ad8eMHI2wLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3444
X-Proofpoint-GUID: gN7n8dP_HSPfzO-bp_fpuKzISxlBHDVO
X-Proofpoint-ORIG-GUID: gN7n8dP_HSPfzO-bp_fpuKzISxlBHDVO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-09-01_06,2024-08-30_01,2024-05-17_01

Hi,=0A=
=0A=
Trying to revive this discussion about background commands. I'm sorry if mo=
re on the topic has been discussed elsewhere, =0A=
but=A0this is a patch that I could find which related to the same topic.=0A=
=0A=
The requirement for default timeouts (or atleast a mechanism to provide tim=
eouts to the command structure) seems to be needed=0A=
since the CXL spec doesn't seem to explicitly deny userspace access to back=
ground commands. This seems to constrain a lot of=0A=
functionality with respect to Vendor Defined commands as well, if a command=
 needs to be implemented as background.=0A=
=0A=
>> sthanneeru.opensrc@ wrote:=0A=
>> > From: Srinivasulu Thanneeru <sthanneeru.opensrc@micron.com>=0A=
>> > =0A=
>> > The CXL 3.0 specification outlines background operations,=0A=
>> > and support for handling these operations was added in following patch=
.=0A=
>> > =0A=
>> > Link: https://lore.kernel.org/all/20230523170927.20685-5-dave@stgolabs=
.net/=0A=
>> > =0A=
>> > Mailbox commands like =91Log Populate=92 use background operations=0A=
>> > to complete the execution of the command.=0A=
>> > This can lead to a timeout, since there is currently no option=0A=
>> > in the ioctl cxl_send_command structure to specify=0A=
>> > a timeout value. The default values being zero can lead=0A=
>> > to the driver reporting false negatives to the application.=0A=
>> > =0A=
>> > This patch aims to establish default values, enabling mailbox commands=
=0A=
>> > that operate in the background to continue functioning even=0A=
>> > if a timeout is not set in the userspace application.  =0A=
>> =0A=
>> The reason there are no defaults is because userspace is not allowed to=
=0A=
>> issue background commands. The CXL background command definition is=0A=
>> awkward in that it allows a single command to monopolize the mailbox for=
=0A=
>> an indefinite amount of time.=0A=
=0A=
I understand this is a design adopted by the kernel, and not actually by th=
e CXL spec (at least I don't see it=0A=
specifying explicitly that background commands are not allowed in band).=0A=
=0A=
>> =0A=
>> Instead, the approach taken with Firmware Update and Sanitize is that a=
=0A=
>> kernel sysfs ABI mediates access to the mailbox and facilitates bounded =
=0A=
>> timeslices between command submissions. It effectively allows the kernel=
=0A=
>> to manage fairness and more importantly preempt userspace if it needs to=
=0A=
>> issue its own commands.=0A=
>> =0A=
>> I assume you are only seeing this lack of a default due to building with=
=0A=
>> CONFIG_CXL_MEM_RAW_COMMANDS=3Dy? If yes, "raw" means "raw" and the kerne=
l=0A=
>> is mostly taken out of the loop of saving userspace from itself.=0A=
=0A=
This seems to imply that no vendor defined command can be background comman=
ds. Please correct me if=0A=
I'm wrong, since Vendor defined commands have to be sent as raw commands, a=
nd the absence of default timeouts=0A=
indicate that the command will be immediately timed out.=0A=
=0A=
Also, I understand the point that background commands (since there can only=
 be one) monopolizes the=0A=
mailbox, and hence cannot be exposed to userspace and as I see the backgrou=
nd command handling goes synchronously=0A=
with the usual command handling in the kernel (ie; foreground command has t=
o wait for the background command to complete or timeout)=0A=
but doesn't this defeat the purpose of the spec defined ability to run a fo=
reground command while a background command is=0A=
underway?=0A=
=0A=
>> =0A=
>> All that said, ugh, "Log Populate" has no facility to time bound the=0A=
>> population of the log. I do not think it is tenable for Linux to=0A=
>> surrender mailbox access for an indefinite uninterruptible amount of=0A=
>> time... unless you want to handle "Log Populate" like Sanitize where the=
=0A=
>> unbounded background operation is tolerated because the device is taken=
=0A=
>> offline?=0A=
>=0A=
>It may be pointless to do a component state dump only on an offline device=
.=0A=
>My assumption is this one is hardware debug only.  Patches out of=0A=
>tree or behind a really scary sounding config variable perhaps?=0A=
>Other than vendor log I don't think populate log applies to the other=0A=
>log types yet (they don't mention it anyway!)=0A=
>=0A=
>Jonathan=0A=
=0A=
Am I wrong to understand that this design decision is still in the open rig=
ht now?=0A=
=0A=
Another concern was that right now, a WARN_ONCE is issued when a raw comman=
d is ensued. Maybe this belongs=0A=
on a different thread, but are raw commands to be depreciated (if then how =
can Vendor Defined commands be sent?)=0A=
=0A=
