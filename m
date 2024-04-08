Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2130.outbound.protection.outlook.com [40.107.100.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD18F17EF
	for <linux-cxl@vger.kernel.org>; Mon,  8 Apr 2024 02:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712545095; cv=fail; b=KXVx6kBImyBuXB9+jQk0yZ4zoTmKLR0o3q+xD2uaY+QUdyhLHqbYjU0LuNzO5KV4ZiyPDQ2vg3RDjI1xEYopEfK7x1BLgVb7RshLFXi/TIS4s1Lgl1DcgqpbXD9Kgn5tb9vpJ5cs3tBOFjUgBnTJYR1xr8kzWu1N5jsMuNFsG58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712545095; c=relaxed/simple;
	bh=OJkTrHWzSQIIMBxbDKijtbpDEK4mcxQ6aO0FVc0z0LI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I0IT49ygtMbt7LJupYXWM5pO1voWpTob8agoc2KkwUoeTSQYUIoDswpeWP0MEuL1Up9D8XAYWePnZ5x95/GWBGaY1ZWRFDpBKeloNcKW/ussYneXPtlg0pDFzwkWswvsLaGvHrEP4e8QeM/tuiod3qUArNlnvKljZKOWqFvxKCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=L9/dJYNJ; arc=fail smtp.client-ip=40.107.100.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="L9/dJYNJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IHoFPcVF4bJOJAA+auhQniMOv+3uhEhZsa6eTag2dvMD1pf2cli8TSxpTVl5OwcsduXlm0gzVIHp6LBrL2eD0ZnMKxaTPsyZ5/RzPzzZ/y/SjefA84AHUmM3rXemKo7WNjUTt3es1n+f8HjeXNg3PRP6a3EYN066fXCLehgBE0FMSYTdZN2S1IBmOuJGB58odh71XVVM1Qz6D3enXjbrm3V2xTUjlLdz2/jpBNHFnJmbmkJ2I3f5UCPBBbDPl58bgnCCo0kpTkHF+jbpLUuUHUQIH2Oy//Jtbh6aBEsXrahSXe9JsQVmu48Q8OqBSrLHZXutNk0Cq5035Vt4YBCo7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJkTrHWzSQIIMBxbDKijtbpDEK4mcxQ6aO0FVc0z0LI=;
 b=JnFUoPjO2cgqYV4p6q8bZ+WriFt0Gno5oho4/p8p60cwrqYkYnXM0m9t9orXrmxXeJ0aOJbyxsYGVjr430A36GbD2Hc1ktXbHkcfmOM3kka3MJ8mSoPtdR3iJ5a0D0aCZyAogPVZ35QAD2BPtQf/tYlG+sG8dAinPkZGDmvh4TKJKmaESidI8Y3oJ1moEvjdRgiIdg4+8CUEswaYqDQKSOAJSmniXP+GaOhW+Sa0DRGSuJ/2tkZ/sh5IMgmHbjjg925vMfZ7NRZoTDkckXLlHCqjMf+wE6QqvA8xviXbZspHyifJMQ6c9d6NzZ9cXn1w81ZQmEUcuV3x6SCZyxA+lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJkTrHWzSQIIMBxbDKijtbpDEK4mcxQ6aO0FVc0z0LI=;
 b=L9/dJYNJlEcx84N9qr4w4WEf4+ChJwtbPI1oQZP5Ovpz7f/RNHXZlv5IpBmAa7gMfIo4ZthNAcHW5NTOUUCuWCAui1Ye+RaYksoNmlLMQcosqlyAZJuwHeYoDPVblLOnguOClnGHD3nt96AiavB/xxsDIyH2PTkwyO2KPJH2smo0MiamWEHS9nTK1tCrSpN9+ITr2b92igmekyc1jontlCB5YhIVZeLEZ/GH0NAvGLj+L5BgGe+hVAmfI/cGk4AqHTvgx1td7cxzk0WlHr8OgiguOD4JBF2lj1pL4jZwzhWgalXpYKgV+Kv9hA0uv4c2wGKgp+rm+NzFJDQe5d/l4w==
Received: from SA1PR12MB7199.namprd12.prod.outlook.com (2603:10b6:806:2bc::21)
 by IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Mon, 8 Apr
 2024 02:58:10 +0000
Received: from SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::dd65:cb60:936e:6995]) by SA1PR12MB7199.namprd12.prod.outlook.com
 ([fe80::dd65:cb60:936e:6995%6]) with mapi id 15.20.7409.042; Mon, 8 Apr 2024
 02:58:10 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
	"philmd@linaro.org" <philmd@linaro.org>, "mst@redhat.com" <mst@redhat.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Dave Jiang <dave.jiang@intel.com>, Huang Ying <ying.huang@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>, "eduardo@habkost.net"
	<eduardo@habkost.net>, "imammedo@redhat.com" <imammedo@redhat.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linuxarm@huawei.com" <linuxarm@huawei.com>, Markus Armbruster
	<armbru@redhat.com>, Michael Roth <michael.roth@amd.com>, Ani Sinha
	<anisinha@redhat.com>
Subject: Re: [PATCH 1/6] hw/acpi/GI: Fix trivial parameter alignment issue.
Thread-Topic: [PATCH 1/6] hw/acpi/GI: Fix trivial parameter alignment issue.
Thread-Index: AQHahbHjgc+Ytk3QJUOv3scC7T7NfbFdtRJL
Date: Mon, 8 Apr 2024 02:58:10 +0000
Message-ID:
 <SA1PR12MB71996471D7DEAE003803E679B0002@SA1PR12MB7199.namprd12.prod.outlook.com>
References: <20240403102927.31263-1-Jonathan.Cameron@huawei.com>
 <20240403102927.31263-2-Jonathan.Cameron@huawei.com>
In-Reply-To: <20240403102927.31263-2-Jonathan.Cameron@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR12MB7199:EE_|IA1PR12MB6435:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 qrElak44aXP85Vp6P4U6e8sf24HpR4ONwPVm2Kgnm1IIxvdqy3J6DxeqPpg6EsSW82HT7kf2BkVylJhyNojtpNiOw2W/bv/naGRH/7nWIabJtLb9YKCGQv8YKlF+e85NBdaRAUVLDGerWg/sRCTJtmIkSpbfVZ4cAP8sB24o7MOI1rAJPBhhALTMRPI1tv3dzgCTTy2gf7GIdEtSvlMVaJmrbwqR1BiJd8uPWbJle+m8rtXyvth32KMrPZPWryilxk/MvdzKsvJSdh9Enh3iWQgrk9+Y6Af7oMl1NQoiXV9Hn6NnxlGQ8TYJf/sm4XK0/HL463BDLc5h8kLu54BmeaJjK+tGsSn53b/q7K+VAKzYcRG0ZM+YXVEv3lJ6x6Wj4e6dnbo5CdvLjOXq4+BbE4pARJDEXEX+Soqt7lmrEC/j93qrSxVDcm6HOTHYkTvqsJu70VT8nILEu10uIUkDDvpcFIJR7oNLFBpDJICNDFfrSkXYH448mL5U9G4oGgPnNELfRPMJITOprmByBqKEsw7UtI1nsuuOWBvpHiXDY16NFz2oRmstOHIbpY3RtHZQd/mOpq6FebBCe6YDiRVeRy9CDHomlZA6tuMXfG0ZARGHlqFLWuukHZlkXe8UzUJKylB3ngL7hydC4WqX3hQwAnN+N3qy16JNcZqOAKXaoIc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR12MB7199.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(7416005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?gIlQ+EWP00rpAHpAGsNRnPCf8k/iI2e/OBrmkxtikcTBq5GdK5JgGeA26U?=
 =?iso-8859-1?Q?bk5PspUSYFdrOQfFBpeJhuVSqZzssSQaPYlKHGfO026kWj5R2rz+BTa+Pi?=
 =?iso-8859-1?Q?ViKAUP36UlqDLcmND7/h/7FE2/jh8dKsksVIV3mfJEW7kE/y5cER0NzhRo?=
 =?iso-8859-1?Q?w/pVtUsRHhI3Ni4K3q6UCTAiX3iWVBmx8C7WYmfEf62F7TrDzKk0jDuyvI?=
 =?iso-8859-1?Q?iVg9N7UVgK7kyrPO7xloyxj9dB2laFeTP359eUlqQDxcvmfVQ1KTzKPA7W?=
 =?iso-8859-1?Q?9bUNeAEiQNrhhYPG57RCRQ10c7Vd9W0u7Z8UjjlcGUZxt7gtK8F8QjELsu?=
 =?iso-8859-1?Q?ByB7jNPBKEbq9WO6YiQdNf85MTOP2JJR1xxnRzgveJryCwbEAnBVGQlNKH?=
 =?iso-8859-1?Q?6oZYG89glA0yteN+zHncNhAv7l+hf3sRc3EsQ6BYOPLHG5QlFszemelapE?=
 =?iso-8859-1?Q?gUuzKI5Sh/fKwsDqpldIYAWADWw1WPrqVt2siqvoEPj/tSRUmhs87qyYJj?=
 =?iso-8859-1?Q?tn6pSS3H3FhBFuVfZVEKjcnqEQ6/sqqLJMMd0m08D7KEiTg//kjMz9QTFg?=
 =?iso-8859-1?Q?PhDVlsSkS8NFnyifrnYsanoar0oyzGz6LQx7jsxviDYPGWUO50KftzPkv5?=
 =?iso-8859-1?Q?uZRhvMVc/zHMBV/byzPYKXczIdwEM2CT/5Vza6V1PEEKi8HVuW7mUsFaIl?=
 =?iso-8859-1?Q?kkQZopqg4WByWGPFVKGWJqcn+/sjv8XyUc2Nbl4xFSVQRpXicVwdO7wJ95?=
 =?iso-8859-1?Q?ED0iQ4Z4OuT34PsjVGk95LUb989b8zHghsx4tz4io7AJPFqw/eYFg75ydo?=
 =?iso-8859-1?Q?hX4bwOQY6LcUyPqmLRKkDYvCJFy2zRTctK2t4LsJDM0OC/qYR6+8ZCHLKV?=
 =?iso-8859-1?Q?/TWb4jxgfQypP35gcZ3Y7A7rNvnPFyNvIVTP1ZpWaNSZ9oqMxWzd1ChTCf?=
 =?iso-8859-1?Q?znyK5R+ABDA30myYz/hPqDnlkjJX6ROB0wCmNtkCouLtFdK6+Bb/kbnbnx?=
 =?iso-8859-1?Q?TK7agPcqLJo38P7BSBZF4VrM7ahHWPoUWJ646sL/4CY0MXfo0fJmFPjTqq?=
 =?iso-8859-1?Q?b7BKl3rLooBN7lsN51PETv2rw+mamIkjJHaEP44Ly27iTMIhR9LL9qSOw7?=
 =?iso-8859-1?Q?daXor1YOPlxaMEbQhDdrDZTxGWvpleg9/iDyF3+wy5DfQS9lVU5ujt1Fpg?=
 =?iso-8859-1?Q?ztjCYyYn7hkbmt1w8/BKoWm44Fi3Ow9UM+rbwUkv+DVjHbsoCGRXjkzzrS?=
 =?iso-8859-1?Q?3XO0RLDlYO5PEqndIk8KDWsEc12GhluEQgT348fC6mYqUSGf4BzX+oE/HW?=
 =?iso-8859-1?Q?o/t4mRQCLGagqoDfLQ4xeIo+Dq5SN8sUhvVqxswgmoXfMfSGeyz/58jqSk?=
 =?iso-8859-1?Q?IiVLprURnIwiERfN9OANCMRZ8TEflU3I08kQS0gYdLAfhAx4xrU2StWQcK?=
 =?iso-8859-1?Q?mjGJM+cwKwF3UtvcEHjBgwgHwFt3YYI+Fy2GTgf9pZP2TByWWGoQfJ3ckc?=
 =?iso-8859-1?Q?hKDx4N2IAeRCYyUhuO48/sujHGZp5uiIyhShEM0OBYOsdE6ziLrThgnxFf?=
 =?iso-8859-1?Q?gA6nJqHC1XlaqIBnYJWl2PSZB/OKqHCDlHr8QJOoO/A8SGdGNwi5SrF6dT?=
 =?iso-8859-1?Q?JVvoKMwPTYYNw=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB7199.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77d8f9b0-5b6e-4cb7-5987-08dc5777b98a
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 02:58:10.4830
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2P5Wsq2+CdfgIyyL+YhDLe0Z2rCCxGNMJoKlpAJ/zZ8exSGxrC5YNdZquYXs2GPlTjlZfiQ4FqnPrhMOeY8qMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6435

> Before making additional modification, tidy up this misleading indentatio=
n.=0A=
=0A=
Thanks for fixing it.=0A=
Reviewed-by: Ankit Agrawal <ankita@nvidia.com>=0A=
=0A=
