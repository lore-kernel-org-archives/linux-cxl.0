Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010009.outbound.protection.outlook.com [52.101.61.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D714634B410;
	Mon,  1 Jun 2026 06:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780295332; cv=fail; b=JB5fOfBNYQ92EabS09MIKk4DHdnq+bWcrMpVcgtEGLp0vLYkSb1YdzsZn6JWOPA/6rLE/zFN0EMbXNO5TMNbqMLcBlPyG1hyc0WvDMxpk4B97jpb52T1Xlez3OEFQAhQcd5zbakzwD8FNi6KjBJ/fCvnyTiX+v18Vk9jiGYm7Ao=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780295332; c=relaxed/simple;
	bh=bR5IUNbZq1EO5NU1YHJxABMHx8ucdQSY3QkpjvwWvMQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZuMQf2AXAF/Db+2XF2YT/xMCXglT+VAbwPr6bLCiSXfJnPndtasbyXPc1LrOT5ViL8w4Ynp98goNxFfOA23GsNmu/YPgx3vfHyPJRHjzJg/x1nLe5ZnGS8cV65y5loAIKgh9SnkP2ZXQT15dN3Z1rqvvqXHMNDT0/42WzgLrErs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GNzcngSD; arc=fail smtp.client-ip=52.101.61.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GNzcngSD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yC3ZYR6NIWzgPxYf45K5/eMDeMxjc8XNpLVfDltrQVLt6+XdUJViJ0FjWSa1UHCu5LemWmtHyR2suLm/FSvr9DEhHvfXV66sZqA40e6r3krJvbWFbW0rBjXiTSryJvl2LMSCJAwzTiY47rNiZU0jprlsFGtw9KpgooqYgTnX+DRpbsD7MUWY7DxGgQh18V/Jav/9C5XcVTzS5DNgCLa6xK9mLQOhJaikCHWp/PGwEUaEqFuz0wNtzb6YPVNm1xu+TAlPWYdMWVMnq8bYQlh5H+UTR2tis3dcN675VzefynNOi2mlH3nJeOFyP792nD8Rv0tBGs/qFuodhK8fkIABUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrj6KsOuOCo5I41mM20N+6MAGsN7DqHFEfYUL+FpZtw=;
 b=llMuUHYobSX/Tdr2gQ4w/kVC4QLqcFDSbtXeXMmMBrWXciLZ25kTzJyHtSWASK41JGk9B/p+fhbi27kA26kzBq+nymUXjtsTb0GUNSZvbA+ulY6HfHhc1MKy5nBxK+9Of1PQFuBK8Mq9bGszSXcS/cYPK4EhEi2kX9MnEhuYw5fnbxgEeV6OKFpovIOkBL8xgs6UhwnxFFjxOa4t4kGSBlO0P/TPaBRqqHer3Keq63gDrz2Zuio9G57Ts9EY3qgGojqSmfvcE1nqQm5FVeZY4tVjSebeF4uxAqc/G0h82ffQXfS3Xm+noLe3pABMZqJgRE/9O+S37HAC0r+t7wprSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrj6KsOuOCo5I41mM20N+6MAGsN7DqHFEfYUL+FpZtw=;
 b=GNzcngSDqfIJvSo/piH+9hwH7Xck0OACPTRFCqgCcBC+SmnUshbCceGVYKPDtNV1/3+Hb3t4eUgEddE16XejP7WN4397oShIlPHBS7hSYtO7zRY/c0qgwGNuKQcRoYCNvkGmS1YltX7YTMOdOjy1d/wi909WDS02Q3iOCleKowGbGWsOKdPb+OmimcQmC5Nn0Rza02lecFOm+s2qEJdWEQ4xbNkh1SOS49vhWFEQ+AhiQSRmVvJnDYL7SZQGUYUx1RGQXWhfatsYkO9nDtR6Jlv09vYH3VzAUCNsLYqQMW1I3VMjVJq4DVfbovVZoWvZxEYFN4WZIVtkP/Ace9IApg==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by MN2PR12MB4255.namprd12.prod.outlook.com (2603:10b6:208:198::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Mon, 1 Jun 2026
 06:28:42 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%6]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 06:28:42 +0000
From: Manish Honap <mhonap@nvidia.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Alex Williamson <alwilliamson@nvidia.com>, Shameer Kolothum Thodi
	<skolothumtho@nvidia.com>, Ankit Agrawal <ankita@nvidia.com>,
	"mst@redhat.com" <mst@redhat.com>, "imammedo@redhat.com"
	<imammedo@redhat.com>, "anisinha@redhat.com" <anisinha@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "peter.maydell@linaro.org"
	<peter.maydell@linaro.org>, "shannon.zhaosl@gmail.com"
	<shannon.zhaosl@gmail.com>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "fan.ni@samsung.com" <fan.ni@samsung.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "richard.henderson@linaro.org"
	<richard.henderson@linaro.org>, "marcel.apfelbaum@gmail.com"
	<marcel.apfelbaum@gmail.com>, "clg@redhat.com" <clg@redhat.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alejandro.lucero-palau@amd.com" <alejandro.lucero-palau@amd.com>, Vikram
 Sethi <vsethi@nvidia.com>, Neo Jia <cjia@nvidia.com>, "Tarun Gupta (SW-GPU)"
	<targupta@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, Krishnakant Jaju
	<kjaju@nvidia.com>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Manish
 Honap <mhonap@nvidia.com>
Subject: RE: [RFC 2/9] cxl: Add preserve_config to pxb-cxl OSC method
Thread-Topic: [RFC 2/9] cxl: Add preserve_config to pxb-cxl OSC method
Thread-Index: AQHc1nGmOdYwxa1l7kS1zoyMfuq8T7YVbeeAgBQEMzA=
Date: Mon, 1 Jun 2026 06:28:42 +0000
Message-ID:
 <IA1PR12MB9030650957A9F939AD8F59A7BD152@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260427181235.3003865-1-mhonap@nvidia.com>
	<20260427181235.3003865-3-mhonap@nvidia.com>
 <20260519134539.1b11ace4@jic23-huawei>
In-Reply-To: <20260519134539.1b11ace4@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|MN2PR12MB4255:EE_
x-ms-office365-filtering-correlation-id: 1f44f341-0a3e-420b-5b33-08debfa70676
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|56012099006|4143699003|3023799007|5023799004|18002099003|22082099003|11063799006|6133799003|38070700021;
x-microsoft-antispam-message-info:
 RNgXKcdGURFgYofSRFDkd+lrVMfiQG+jT/10IcYNx4CVVDf3JjvGxCa2YhreqnzQZzj7oKS0Aqmph3kOSSRr6qzSi4NE3hK1Q1PY52/iZyAfT5Yzj/PUlbDYVhSzUogwu1it95AZPbibpkE1M2WE6kgwPgUMxsEf1VytLk/xJrbXXzQmJob14dkXsQfXFCEDROVT7mPTX6dPAjvaC5N9DI6g+iUqFSDIGWouUGOP1KszWSTtY/VP2L+BQ3m7AtoFV6TiYic0NQZAM1C8EnsxwJT+wpVlBoQdU8nqwpWvqEmYHm40bhxiynx85cnBfbMiAsak2abuOMHwrTIJp7vFUzfCJd3txkTFhH45DseaBnlj7YwoGIl7jdBX8bqhDihVNYbYOpDD4+8Q2P9anQgavtgepsGX9CRt4WdNgNwV+3/F9nJ3JeejUJGIDGczRv7r8cITWxbZV0ITnY4nB0AQMMJva9JVBeFMUiDMv6BP0SDxN9E/2uhQohcIJ9508Yj9OIRb0vwlyyqV3K6wU+NEOY3+IRGAPm3Q/UOAItvag3nXGvnKEyDizucZ+4fo63HqzaRoqPUvkZMl/PGhIcCraLLvaelP550/bZJbVF6nZ65UWUdNSZvF5ST/ywiPbhbyWncDup4iH2AM7PsDhAEynkA6JIfaS8JonU4c4al9wdu6ygCbttSYIDnR6v6EKx4AsTxdxvam5bqZ9deJwGiTm7y+kgGNoHinv6zONxU+k6339w0PdTyHPZpXVpaDYKav
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099006)(4143699003)(3023799007)(5023799004)(18002099003)(22082099003)(11063799006)(6133799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7ID71DWHUmIaUI5OfHyVC9C6ar2clSgUuaUb4ceLNcgieJKH4IFVBKhpTz+P?=
 =?us-ascii?Q?QY1iuVO0qCIOJrZatGuEYHGH2niMkezv/R1uViWhfWmts0trxgMhiq6tSBEG?=
 =?us-ascii?Q?0t7PPO776oWPLcDgyOv1jHea6f6grfeERpECjlW8B5dJd+Y0VMR8cuXNTrB5?=
 =?us-ascii?Q?Yt37tgxQgbdMiVZ7v3UBW0C3vFvLfhFOY+rWTnjcqgB9keixcZMTb9mUnC38?=
 =?us-ascii?Q?6esgLmE5hRZYftMyq6d0MCeRrxfffaA5SKAfgw8Cuo5tLW75G/YepAR3kh0C?=
 =?us-ascii?Q?p5BVdRi234g1HI8f/cklMMfoxcDAzp1frEz49V98biIGwm4jwIGPYLPRkjbq?=
 =?us-ascii?Q?K/1vSTsrPFzgIpfYG62IxpSmAR3nOxjualUKpg4w2xtWTPeaUh+kUYD7Tbhy?=
 =?us-ascii?Q?I2i/RQvNx9PuERR4sLFi/sNoDasTIsSbindIQqDbPfVXrQDDoO47oI7iRB6T?=
 =?us-ascii?Q?m2snmJ4Q9HFfzQdwF3cBgS1xHBg65xvwa+Drz1eGpqntafnbpA5jyhELNP5q?=
 =?us-ascii?Q?xsVqa5AyBlfJQVTLygEbqCrtJuyKJH7w4lmjDbAMhHSKexgh273TOrNhwxBg?=
 =?us-ascii?Q?XU8IrTkfl8NQycol2VT/S8fyGSeBSgyjV3S8/OuI4Jx/pL+6Xiv5qIUfOi3S?=
 =?us-ascii?Q?BH344KByqc09DT6m6d/TtqKdgNiT/7trMVknMiDy/5byNzom+6DGGnhVSHwJ?=
 =?us-ascii?Q?HSL1i0t2n/g8aQCKJKqtIi8axKrPXvBHBCHtZwDaJsQlAVMZO/VfTrFQr1fF?=
 =?us-ascii?Q?MbCl63NbCw4UGdXmvpLVgbxPELoz7R2WCjgomfVRgZcfT6D7uO8WOx112Ln6?=
 =?us-ascii?Q?Ib/7mqICu17PfG7X9qwmb7vxZJsUesEhP9tsIFyvdA6W93JOX+Xxzs+QZoJe?=
 =?us-ascii?Q?M2nMCCjbwN8MWSUQLYffTsdGka9iO0uuq+kbfFyEX9r/qVylHwcEbjNtc5IZ?=
 =?us-ascii?Q?1/0lewAi87HevTC0FXf5REBlL7ocM00uum8NRuI1ZhHY4MU/V0Lpi6qVH8Xz?=
 =?us-ascii?Q?tkmQCODilzIXt/TH1VP140XSNhhiQX09GqmkO0kZYTqLT55DKwvLojmaTv1i?=
 =?us-ascii?Q?qTipcyB6YHwB0vla+O8of6QtDwfIA2p3xWwTeJD+TnJaZixmLgWITm3ySLFd?=
 =?us-ascii?Q?5X3OMHeSVnibGxvDgmibQkzxlB4jjTV4sJE8mzjIPXTGYtpIOTDR/8HHqLrQ?=
 =?us-ascii?Q?p1HErG1BMP/eGm7lN4C79ZQR4TGvTpWr0LZrJ3IEe6GABRVKZTDxrEElpfPR?=
 =?us-ascii?Q?sxupajg/+Kp6Q8oWwjSoEmec3xgHvymOMC7evfUBpZW1UyqHFMB0HUFjKB+9?=
 =?us-ascii?Q?7eilqpuogXJXH+XRTA17Hu+QjWb5Eh9+mRymUE8DGZXspak5TMaIe9E7ykwn?=
 =?us-ascii?Q?3btPPu/7yRnY0L4TtPjgBR0J2xKTJHlTwlXZpk864bGfw1g+wT9Fso+pgzSI?=
 =?us-ascii?Q?AAtwb2QdncVuMwhWtFoBju3V5IwNKEqZ6UyJ8VP+H/samkLRAS4qxrKHgD60?=
 =?us-ascii?Q?5EXSPYLii4UaqSvH9NxfMqJrSoF3Je0jKGRIauMsBE2gA69cNaZSCUj9Zt78?=
 =?us-ascii?Q?Tvrnzdx+uBLzi3+W+LHrnag9VhStTtQibZusPWD+Ig8kLUKPaLm+CloqLP57?=
 =?us-ascii?Q?IEzjKq3Z7feSYzFq+Dq+Z8lhJIYtFNfcZ6zFQUoeEBuNEGDuzeSn+WI4jchR?=
 =?us-ascii?Q?0qZ+Yx3prl+Sgp2YkUW2SmcHBfDv9G1SA/58tGp9vVI6JBCd?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f44f341-0a3e-420b-5b33-08debfa70676
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 06:28:42.1218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1QW9M7zfK87FEL2jhDw9jEavOt+m/xCcRF52I2iEAM0Kg/rDK9T9G2I5YR++cUerfMkZ6f3Pjf0bUYB02FCQew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4255



> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: 19 May 2026 18:16
> To: Manish Honap <mhonap@nvidia.com>
> Cc: Alex Williamson <alwilliamson@nvidia.com>; Shameer Kolothum Thodi
> <skolothumtho@nvidia.com>; Ankit Agrawal <ankita@nvidia.com>;
> mst@redhat.com; imammedo@redhat.com; anisinha@redhat.com;
> eric.auger@redhat.com; peter.maydell@linaro.org; shannon.zhaosl@gmail.com=
;
> jonathan.cameron@huawei.com; fan.ni@samsung.com; pbonzini@redhat.com;
> richard.henderson@linaro.org; marcel.apfelbaum@gmail.com; clg@redhat.com;
> cohuck@redhat.com; dan.j.williams@intel.com; dave.jiang@intel.com;
> alejandro.lucero-palau@amd.com; Vikram Sethi <vsethi@nvidia.com>; Neo Jia
> <cjia@nvidia.com>; Tarun Gupta (SW-GPU) <targupta@nvidia.com>; Zhi Wang
> <zhiw@nvidia.com>; Krishnakant Jaju <kjaju@nvidia.com>; linux-
> cxl@vger.kernel.org; kvm@vger.kernel.org; qemu-devel@nongnu.org; qemu-
> arm@nongnu.org
> Subject: Re: [RFC 2/9] cxl: Add preserve_config to pxb-cxl OSC method
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Mon, 27 Apr 2026 23:42:28 +0530
> <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > Before this patch, pxb-cxl bridges had no _DSM method at all. When the
> > OS called _DSM on a CXL host bridge, ACPI returned an error and the OS
> > defaulted to reassigning resources across suspend/resume. On machines
> > where firmware pre-commits the HDM decoder, that reassignment breaks
> > the DPA mapping.
>=20
> Ah. Ok. So it's suspend / resume that is causing trouble. I wasn't aware
> PCI reenumerated on that as opposed to boot. I surprised more doesn't
> break.  Make sure to call that out in the cover letter as the impression =
I
> got was the problem was initial enumeration.
>=20
> Mind you I'm still confused. Why is CXL.mem path affected?  That's nothin=
g
> to do with PCI enumeration.

Yes, agreed, the FMWS region is described by CEDT already, no CRS entry
needed. I'll drop the CRS insertion in v2.

>=20
> Jonathan
>=20
> >
> > Wire preserve_config through GPEXConfig into build_cxl_osc_method() so
> > pxb-cxl host bridges get a _DSM method that signals the OS to keep
> > resource assignments stable when needed. The _DSM function 5 (preserve
> > firmware PCI configuration) is the mechanism used to convey this.
> >
> > build_pci_host_bridge_dsm_method() is promoted from static to exported
> > so cxl.c can call it without duplicating the AML.
> >
> > The x86 build_cxl_osc_method() call site passes false since x86 does
> > not use firmware-committed HDM decoders.
> >
> > build_cxl_osc_method is renamed to
> > acpi_dsdt_add_cxl_host_bridge_methods
> > The function now appends both the CXL _OSC method and the _DSM method,
> > so its old name is misleading. Renamed it to match the pxb-pcie
> > analogue acpi_dsdt_add_host_bridge_methods(), making the two root
> > bridge code paths symmetric. No AML change.
> >
> > Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> > ---
> >  hw/acpi/cxl-stub.c         | 2 +-
> >  hw/acpi/cxl.c              | 4 +++-
> >  hw/i386/acpi-build.c       | 2 +-
> >  hw/pci-host/gpex-acpi.c    | 5 +++--
> >  include/hw/acpi/cxl.h      | 2 +-
> >  include/hw/pci-host/gpex.h | 1 +
> >  6 files changed, 10 insertions(+), 6 deletions(-)
> >
> > diff --git a/hw/acpi/cxl-stub.c b/hw/acpi/cxl-stub.c index
> > 15bc21076b..d7c6731975 100644
> > --- a/hw/acpi/cxl-stub.c
> > +++ b/hw/acpi/cxl-stub.c
> > @@ -6,7 +6,7 @@
> >  #include "hw/acpi/aml-build.h"
> >  #include "hw/acpi/cxl.h"
> >
> > -void build_cxl_osc_method(Aml *dev)
> > +void acpi_dsdt_add_cxl_host_bridge_methods(Aml *dev, bool
> > +preserve_config)
> >  {
> >      g_assert_not_reached();
> >  }
> > diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c index
> > f92f7fa3d5..b32740a3e3 100644
> > --- a/hw/acpi/cxl.c
> > +++ b/hw/acpi/cxl.c
> > @@ -23,6 +23,7 @@
> >  #include "hw/pci/pci_host.h"
> >  #include "hw/cxl/cxl.h"
> >  #include "hw/cxl/cxl_host.h"
> > +#include "hw/pci-host/gpex.h"
> >  #include "hw/mem/memory-device.h"
> >  #include "hw/acpi/acpi.h"
> >  #include "hw/acpi/aml-build.h"
> > @@ -320,11 +321,12 @@ static Aml *__build_cxl_osc_method(void)
> >      return method;
> >  }
> >
> > -void build_cxl_osc_method(Aml *dev)
> > +void acpi_dsdt_add_cxl_host_bridge_methods(Aml *dev, bool
> > +preserve_config)
> >  {
> >      aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
> >      aml_append(dev, aml_name_decl("CTRL", aml_int(0)));
> >      aml_append(dev, aml_name_decl("SUPC", aml_int(0)));
> >      aml_append(dev, aml_name_decl("CTRC", aml_int(0)));
> >      aml_append(dev, __build_cxl_osc_method());
> > +    aml_append(dev,
> > + build_pci_host_bridge_dsm_method(preserve_config));
> >  }
> > diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c index
> > f622b91b76..f66ec8ed24 100644
> > --- a/hw/i386/acpi-build.c
> > +++ b/hw/i386/acpi-build.c
> > @@ -1013,7 +1013,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker=
,
> >                  aml_append(aml_pkg, aml_eisaid("PNP0A08"));
> >                  aml_append(aml_pkg, aml_eisaid("PNP0A03"));
> >                  aml_append(dev, aml_name_decl("_CID", aml_pkg));
> > -                build_cxl_osc_method(dev);
> > +                acpi_dsdt_add_cxl_host_bridge_methods(dev, false);
> >              } else if (pci_bus_is_express(bus)) {
> >                  aml_append(dev, aml_name_decl("_HID",
> aml_eisaid("PNP0A08")));
> >                  aml_append(dev, aml_name_decl("_CID",
> > aml_eisaid("PNP0A03"))); diff --git a/hw/pci-host/gpex-acpi.c
> > b/hw/pci-host/gpex-acpi.c index 7de57bbc46..247bd78152 100644
> > --- a/hw/pci-host/gpex-acpi.c
> > +++ b/hw/pci-host/gpex-acpi.c
> > @@ -52,7 +52,7 @@ static void acpi_dsdt_add_pci_route_table(Aml *dev,
> uint32_t irq,
> >      }
> >  }
> >
> > -static Aml *build_pci_host_bridge_dsm_method(bool preserve_config)
> > +Aml *build_pci_host_bridge_dsm_method(bool preserve_config)
> >  {
> >      Aml *method =3D aml_method("_DSM", 4, AML_NOTSERIALIZED);
> >      Aml *UUID, *ifctx, *ifctx1, *buf; @@ -204,7 +204,8 @@ void
> > acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
> >              aml_append(dev, aml_name_decl("_CRS", crs));
> >
> >              if (is_cxl) {
> > -                build_cxl_osc_method(dev);
> > +                acpi_dsdt_add_cxl_host_bridge_methods(dev,
> > +
> > + cfg->preserve_config);
> >              } else {
> >                  /* pxb bridges do not have ACPI PCI Hot-plug enabled *=
/
> >                  acpi_dsdt_add_host_bridge_methods(dev, true, diff
> > --git a/include/hw/acpi/cxl.h b/include/hw/acpi/cxl.h index
> > 8f22c71530..6fe6c9c58d 100644
> > --- a/include/hw/acpi/cxl.h
> > +++ b/include/hw/acpi/cxl.h
> > @@ -24,7 +24,7 @@
> >  void cxl_build_cedt(GArray *table_offsets, GArray *table_data,
> >                      BIOSLinker *linker, const char *oem_id,
> >                      const char *oem_table_id, CXLState *cxl_state);
> > -void build_cxl_osc_method(Aml *dev);
> > +void acpi_dsdt_add_cxl_host_bridge_methods(Aml *dev, bool
> > +preserve_config);
> >  void build_cxl_dsm_method(Aml *dev);
> >
> >  #endif
> > diff --git a/include/hw/pci-host/gpex.h b/include/hw/pci-host/gpex.h
> > index a7c2e2edf3..e5c2ebef78 100644
> > --- a/include/hw/pci-host/gpex.h
> > +++ b/include/hw/pci-host/gpex.h
> > @@ -73,6 +73,7 @@ struct GPEXHost {
> >  int gpex_set_irq_num(GPEXHost *s, int index, int gsi);
> >
> >  void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg);
> > +Aml *build_pci_host_bridge_dsm_method(bool preserve_config);
> >  void acpi_dsdt_add_gpex_host(Aml *scope, uint32_t irq);
> >
> >  #define PCI_HOST_PIO_BASE               "x-pio-base"

