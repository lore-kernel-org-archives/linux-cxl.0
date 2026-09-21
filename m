Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012051.outbound.protection.outlook.com [40.107.200.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FEE483BD9
	for <linux-cxl@vger.kernel.org>; Mon, 21 Sep 2026 11:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789989627; cv=fail; b=jf3ztPy8q/ReKjimPPOg8dvoFj8O1xi9OZ6CNJ3plTZTOEJ5pDwhk6vXeBBvF6K4SJRjr/FrENbpy/cBHOdZB+2MzDfrhx77ucnfUjdw3DqQwtZN7Tyndt/GxO/lsyXvrIlpWvINMANzh3GwfItq6tHjwZg1edMXpxtVLE9gmsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789989627; c=relaxed/simple;
	bh=ulyxmcc+0j+DIBk4S1bNjoPgsI3H1xBAqFziU2YVx+E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TZLkyMmdNA9MeDhD8DdWFgKdgR0Ota2ofgZ/OmPI7/sAqmeb8dHb7bmNI+bfxuWt55wyJa2JnZRw/7exwBG/poyC4ne5AykCJreCcGTfab4w3gEC6ESVHDhuyfXFBBsqvvtFSOAs1XSobUDmPk4nwhgSlNsoiLsul6sTgqMq+oM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lyrAz/9o; arc=fail smtp.client-ip=40.107.200.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lyrAz/9o"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uT4sW031i0RUX0gZEG0okBredrSduo3/6ehhEmq1Kacdt0Lb5ke5vXodQScSIufpegTtyLYGTLbDYEzg40rY73bpM58wG8HwrZ0zhCS4vDU1Db7Inrz6vLWzdmom9x0xEGu4SdR8Hn3BD/8sfCjPMdMW+fKFB8ezkFDOZOP9ZP5mrLQ7D7RqikubMBPFe7IROwCuEh3PqHRJ8VtvBO/2h2o88a4iSim/ghwjRctx/jvipVXXEAHC4ogEJzfCcbk4Kth0QGvZ+UVMTkFtfcDT1d7UTHf7akiBatRlEGwmyDqPCTBTUt0qosOykHtGtokN8wPw9FX8ikuoZcdVqAKEdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYyLK9kUnd0Fz3OgpfI3uV+Q3zgFQTWTT9qrl+wXXrM=;
 b=wkOD68AK5jvxM+A96LhEB6/oJwuwfr91s92uUOb0Zc6jKsxtKuydGO7YdyrVGl0vjKKSuBbSlwFZ6ml6Hroh12LRqvmzoWXOLYoS5jru65iG2spbZk/kryA9iyf6KUk54tNSMabIYh3BSPbWlGEf9Uw1u0tNXK/2JMiit/0D916g3TKResveNBaxpoz2huGdEoTRbcF7SQ6kc0EUqPTDrEM3ED7CyexyTpp/drRDAR3Nsp3MJ7MY0QyefDllw+8gPmXICcL0euM4uzPGJuWOidALF2QgUUYaUrTrNZG/xeVeCXZHIvqXf+f7MSXyYCmZ2R+t/5auPZHWW0/mHU1Njg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYyLK9kUnd0Fz3OgpfI3uV+Q3zgFQTWTT9qrl+wXXrM=;
 b=lyrAz/9ofVp2PHMrsrMcE9WSuJ7MjCxT4P20d/hjS1srwDlKYNU/pGwmqDiRQNbsY3gulvynW7IZ6PhXLnHlCla34eUQoMUSwxtSOfTzq7ol9BIiPhbFYXg4ltB1lj/Zd8KB3thor9eN7EgXBa7UL3+8SAkmy6sTO4Msh8pO8AmSUXa0uu6Hqpd9YdPQnnu9HHgolIpjf6Wv4VoxeJ2tdbXeU7TkziMV4iiwdx/YyYul+8f5+0S8O1KZNX5z/qUAH/IUnaGXOSXG7B0xYLpPCeKQ0WYknlfTXU0b+3FGrj6bwZFa9Fu2osku8ecISt0niRBaF8Kzp/ql/kcbWpBL5A==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by SN7PR12MB6715.namprd12.prod.outlook.com (2603:10b6:806:271::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.14; Mon, 21 Sep
 2026 11:20:21 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 11:20:21 +0000
From: Manish Honap <mhonap@nvidia.com>
To: Junjie Cao <junjie.cao@intel.com>
CC: "alex@shazbot.org" <alex@shazbot.org>, Ankit Agrawal <ankita@nvidia.com>,
	"jic23@kernel.org" <jic23@kernel.org>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alejandro.lucero-palau@amd.com"
	<alejandro.lucero-palau@amd.com>, Srirangan Madhavan <smadhavan@nvidia.com>,
	"pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>,
	"mst@redhat.com" <mst@redhat.com>, "imammedo@redhat.com"
	<imammedo@redhat.com>, "anisinha@redhat.com" <anisinha@redhat.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "eric.auger@redhat.com"
	<eric.auger@redhat.com>, "peter.maydell@linaro.org"
	<peter.maydell@linaro.org>, "richard.henderson@linaro.org"
	<richard.henderson@linaro.org>, "clg@redhat.com" <clg@redhat.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>, Krishnakant Jaju <kjaju@nvidia.com>,
	Vikram Sethi <vsethi@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
	<qemu-arm@nongnu.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, Shameer Kolothum Thodi
	<skolothumtho@nvidia.com>, Manish Honap <mhonap@nvidia.com>
Subject: RE: [PATCH v2 10/10] hw/pci-host: Emit a _DSM on pxb-cxl to preserve
 firmware PCI config
Thread-Topic: [PATCH v2 10/10] hw/pci-host: Emit a _DSM on pxb-cxl to preserve
 firmware PCI config
Thread-Index: AQHdRgusjCvcpjApBEmlZKJiGhQPPrbXNMmAgAG08zA=
Date: Mon, 21 Sep 2026 11:20:20 +0000
Message-ID:
 <IA1PR12MB9030CA9286783E104703456EBD842@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260916184412.3825713-11-mhonap@nvidia.com>
 <20260920091429.717003-1-junjie.cao@intel.com>
In-Reply-To: <20260920091429.717003-1-junjie.cao@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|SN7PR12MB6715:EE_
x-ms-office365-filtering-correlation-id: 15c82fc7-8b0e-4fc0-eb2f-08df17d252d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|23010399003|7416014|376014|10067099003|11063799006|6133799003|22082099003|18002099003|56012099006|4143699003|38070700021;
x-microsoft-antispam-message-info:
 tJ04Cr1qv7AFvIjij5Zhovpac92SiGQ+PROMOw26CInuW5KfAZBDpyo8b9RM0XpoHhXiucnFYPUZ1h8kUrQhsdb0bATaNJ95wDJPFbhpJmpaRo/Wv6bCu4b0yCiU98eRNZwG5/MdxvkppZGpyc11Uh8APJ5los5EjvkOyzYpJ7Y0pijCpjpl7bLEfPmNnJm21EHb7VjWb+rzDFC2UBC/DRP37ZI5X/V7qfzgLP37X9dLvdeL4wJb5h9W2UxGmAdcYNW2Ybc4y1d4YMqB1G5H/SwdEOgxHL5GtFlPHf9WqfU8EbtiVS2e8FrikmRn/GCyXhTXYBe6+d0FYAlSX40WdnnSyKXsvFaVnSSJIoqjT45Raf8w2CUvniieWSzwgPA7RvVvNQkQOyAUdzUsxHJjfs8S5pCVK0lvmgkxSEbTo03HWOfQ/wAS+syOAQwNhtAU+6jpGVzjo4soe1xDkEbZudEoRHeitHAAyL4pfVrlLx6OJaH7t+Z0XFnRCpUB3bxrC8Zq9FPxyh6l25YoSUJUtXYa8E4kiYg9H70+tC56n5XyU7DnmgNUsBS3cy2CWS510pc1xFDoW33+A555NBZ6Ve15Xqo0MxevSB0/DtA7jLkcBnouBNpJesEfL9QTOI+uIhyKPZV00ACYpyqd4r2Q9vD+vaw2SHAf6QT1aZOwPxCkSVh/E/bAV93jprgtgQ3qrXbZyR+pbnoDsezf4z1wMtUbeNE5Bi/De/5H0M5y5Rc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(10067099003)(11063799006)(6133799003)(22082099003)(18002099003)(56012099006)(4143699003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4v0b0zEf6xenkPL9GQAanBz8bkhTn9nCDWDznmNn4HoboW5vi/9TAoLhwiGN?=
 =?us-ascii?Q?3/7x6nn4rELItcHSp5oKfGfDZJ5fNfInzlgMaKvRnOSylGjH7xEKE9Fl6o48?=
 =?us-ascii?Q?Uyc1bgFpvErBiYHhSwoIOVHyBax+KCj/RZXPWEmZ5L4Jgl+R/+oVjALpFuCK?=
 =?us-ascii?Q?jsr6EFjc82T/+3mbI5RdQ4hwJtaj4644B8RfSzvJYQZw+k0VL3yktySSfV7p?=
 =?us-ascii?Q?YT+uTTWuQrG1tWuGTh84uZzP6Qvtim7lapzmLRe4NUn7iiRmi5JTb5gFi7Cb?=
 =?us-ascii?Q?Z4XC/hrVMhvpAFEHD7gsbpcgixdQUYvdkN4IgweUjzG8jDNSs5IIcN91G6kC?=
 =?us-ascii?Q?3A22jeEDBcrVLII0f22bGp3hWDLKzXacZnMlumILGL8mJOPtRvBlaJq13hV2?=
 =?us-ascii?Q?sEo3x3A6UXa0gWQc6tH0/Ol4OboqdObNTgg0LuFwy7jYiVYEQRhssIb4jNRf?=
 =?us-ascii?Q?0ZHGE4Pncuyn9ChX66rgpq77yfFHFp95nJNjyJQXZPQ6FvwYudVF2msxdWqd?=
 =?us-ascii?Q?2ngo3gebJJU8OcnIk4wgxfPWrmNgFAIW5Kt1izosQP8A7GtQK6GBg4l4rJzC?=
 =?us-ascii?Q?BkYKIHK8gzRicgaTcpyQ2w++hHb8dhlpxFqYLfIljccyKefEn2jT5yfrYHL0?=
 =?us-ascii?Q?io5re8cgoTny+sHcSVInBETQ1tzzOfVC5obuapf+szJQTcmTr6fXjXXKTp3S?=
 =?us-ascii?Q?bIzxdb7/A1BSENQ0uIRC/EisftZxEMz8CdW2/vwmkNDgfLSWDKuCcdbN4aLH?=
 =?us-ascii?Q?VSQ1zsN5cl8yINWac9NXS0wXGRxC70x5DYUK0ZSS4Q9SJS0Aa9dnsROYwotk?=
 =?us-ascii?Q?yg8M0b0RSgs+ZdJKZvp2bKqbW76CdbXBMaCkly7enQSjnhdI3piKIXMtT0H0?=
 =?us-ascii?Q?pUUvJptypZOYBv8ECZaZBqn9kzfBmemGr0cfc5pDKMDvXVFaVXXKIYG0FRHN?=
 =?us-ascii?Q?C6ffZHCpvTLjDqxNgYuVlHV157bEdEWo8PfiAj722W+t2kzFzgwOp+ZHFpYs?=
 =?us-ascii?Q?rAwuk6RkwVF6dIdtlMV/IGhrQTmAQCIKmrM+Ikn3CldavCTRScEilyPL7S/7?=
 =?us-ascii?Q?lfXpAATbAq+p5zQ6xfbyLO13ntf+V5NX1Bkt6fU+rbZk4dHnSLYgXKqydU0l?=
 =?us-ascii?Q?BmHBub5x3g9FYaLNuJhia0jeKE0uSd3nZCUdFkrA/U5css6Hzys19otUuFsi?=
 =?us-ascii?Q?ALHDq/acaX2BqHtcsWFY3yR5UkNW6YDss8mHBtpEx0zhTri5QpSYHA0YABWd?=
 =?us-ascii?Q?J4SIkzl37YOoRWeeQfht6Q96zdwkx7rNFT69m4mY1oCC+ZUjUNFtlmecHtvy?=
 =?us-ascii?Q?GzaP3UCwL8MrIPqqjV+yxc2hVLym2huk708kyWJ5njAl2ztwC+uCVRb2IX0E?=
 =?us-ascii?Q?+n7p9pwrEyV+7x/Kd9t13nCXx/jNn6qra9C2qnSTU3PvbOTttH/0o8F9MuKZ?=
 =?us-ascii?Q?g6wStpcKCucTBLGD2QxzVvogCoiygwjgxU9TBGVhPwxjvLf7EXXdDdpx7OhE?=
 =?us-ascii?Q?eWZ9844O3dhXXow+M1DnLwdKCHf83SpQsOTcF4vq2DtoBeeZngnlSZXSwzO7?=
 =?us-ascii?Q?yvFyjzvpNzrUkscr4XuN/2rucyRJf6zI8sVZWui9eGGvxbwiCvMWsKNXRNqt?=
 =?us-ascii?Q?5GBD4C1oZKHH1Fox0cVt67cv6Z7pjZMgHfgruiqRFFbVZ7bONBbsK/+v6AEs?=
 =?us-ascii?Q?KJDQ9m9kZ0PAvecucwrGcvZe4Waw/ENxTd5W7NVtglnF8v7e?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB9030.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15c82fc7-8b0e-4fc0-eb2f-08df17d252d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2026 11:20:20.9624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XIDmJWqe2rJvZi0/ITpqwi6dRngCj+vynQu9zdAe6hv+0PgAdvMPC+PfmLEEr6IFGOZxvGYd3KuQ2BaVRLWDUg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6715



> -----Original Message-----
> From: Junjie Cao <junjie.cao@intel.com>
> Sent: Sunday, September 20, 2026 2:44 PM
> To: Manish Honap <mhonap@nvidia.com>
> Cc: alex@shazbot.org; Ankit Agrawal <ankita@nvidia.com>; jic23@kernel.org=
;
> dave.jiang@intel.com; alejandro.lucero-palau@amd.com; Srirangan
> Madhavan <smadhavan@nvidia.com>; pierrick.bouvier@oss.qualcomm.com;
> mst@redhat.com; imammedo@redhat.com; anisinha@redhat.com;
> pbonzini@redhat.com; eric.auger@redhat.com; peter.maydell@linaro.org;
> richard.henderson@linaro.org; clg@redhat.com; cohuck@redhat.com;
> Krishnakant Jaju <kjaju@nvidia.com>; Vikram Sethi <vsethi@nvidia.com>; Zh=
i
> Wang <zhiw@nvidia.com>; qemu-devel@nongnu.org; qemu-
> arm@nongnu.org; linux-cxl@vger.kernel.org; Shameer Kolothum Thodi
> <skolothumtho@nvidia.com>
> Subject: Re: [PATCH v2 10/10] hw/pci-host: Emit a _DSM on pxb-cxl to
> preserve firmware PCI config
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Thu, 17 Sep 2026 00:14:12 +0530, Manish Honap wrote:
> > under preserve_config, the _DSM. Gate the _DSM on preserve_config: x86
> > q35 passes false as it does not use the accelerated SMMU, so it emits
> > no _DSM and its ACPI tables stay byte for byte what they were.
>=20
> Confirmed: on 28e7aad522 plus the series bios-tables-test passes on
> x86_64 (q35/cxl and q35/acpihmat-genericx, the v1 failures, included),
> aarch64, riscv64 and loongarch64.
>=20
> accel=3Don is out of reach under TCG, so I forced preserve_config on virt=
 locally
> and booted an arm64 guest (7.3-rc1 based, defconfig) with a
> cxl-type3 behind a cxl-rp.  With this patch Linux keeps the firmware BARs=
 and
> bridge window under the pxb-cxl; on 09/10 with the same hack it releases =
and
> reassigns them.  No ACPI errors either way.
>=20
> Tested-by: Junjie Cao <junjie.cao@intel.com>
>=20
> 08/10 still says the x86 bridge "still emits the ``_DSM`` method, but its
> function 0 returns an empty support mask"; that was v1.

Oops, I missed this line. In current v2, _DSM is gated on preserve_config, =
so x86
q35 emits no _DSM at all rather than an empty support mask.
I will update this.

>=20
> Junjie

