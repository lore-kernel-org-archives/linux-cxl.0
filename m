Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010058.outbound.protection.outlook.com [52.101.201.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219B133FE05;
	Mon,  1 Jun 2026 06:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780295156; cv=fail; b=J8fLJpchKg0CW/gjhSBeiOWVQAwQ8PkGet8LZtc3mi8e3TxZwp0ZWKLo7TKt6LUA9dMsTXxGyFHbsSsJ9lVMmhoHo4Efw1s2oLnBkE+Ao2bXDRy7A9+2iz4yvUpKDolP1dbspqL0agU+1iRxAU2tTR6UMpYTpFrkPekPW+5Mwb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780295156; c=relaxed/simple;
	bh=4251F529Kr9NtRHiX/fJS74t6yauakD0kYcjSY5Ps4Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GSj2ZLZKszBL9ShrXDQL8rF9gyMdrjU10g65FlLFH3KfX6x8VLVfCKoUNEb8I1mpSNHFuDbdqKajRXx7/75kcg0QpTjSBdpl+bsdaVIXwSnYCdCy6dRGb8C0jeLwdmbUSJHTOjSx6Q/YItyFuvEzIuPcGKcFtyb0y5heqY2KpDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JsJsnP99; arc=fail smtp.client-ip=52.101.201.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JsJsnP99"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Smhy5zLFylZX959tYfr0uJaiZy3SLZPB5Vsvh4FHA4xZl6zrPlZ1lyeazGqHwKLSxfbVRvL1K6VYZbm1/xEDfD1EC5XNhFaUCPLUlcDPlTcXSQ+kSXo15m5oLi91GfWDPO/OTloOVIgOYnlBb9ChiZsUlx1gha1FpyC6Bf0cWjPn3S/UfW3P1/2/E2oaNIEzK2nCein78AvccI6NWCynCeTZK/pwaLvGQ/8JT0EK5ZG/l1OwL/iB9WQeC47mVx4j0CsHpB8qclPxVQnj/MBIXmwNpT6xE/ZWBU85xG22tzVi+CMv/OdhcfGpHq/h0rFwH7RzKW2JyKjsgn6T+8bv1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nujJWKSEk+j4uPdSFjQICZXL9VGzF85tI0bN+BR8KvM=;
 b=Qd73NRYn9PeW5jofXCdavRHZJUD2h966QJgNQMneDOMhncb4uHOfh0eZf/C7MZcLaOkNSXpR0YW8dEDv51BfuKxL8UgUq/MY1Q3PlOWdG8HQ+/RvyC7DsbqlvnNgSxOdKOlQrPyy7rOSv8xTK+ArjV03BA+9eQhd+pjAMKyvwGyURlViNbXPeLLxVeKFEJr3Y+rCpuIAjSqzPAAGKPRNjOUOsO+N1Hg6pGjJamtMltfOEX2ZXSYI4cspRWi0q31bcFQf0fAkFQRRmVR4DqsN4Ze54fm+1lRycoq6ffONKt25ngoM8tCyHRUyVeAjgAZH+LysFAh1Xq8Ba7aa2+sIbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nujJWKSEk+j4uPdSFjQICZXL9VGzF85tI0bN+BR8KvM=;
 b=JsJsnP99b5nzxi8U/6C5XWcXrLHkUQK5+aM0UwIGbM/rrSU1eabBq4/79VT1wVF8eq8kvwd8sNcsKld4s8iqnzseiNPdDOfd6GLrOcCJLU3dLGHMScP/ZAYsT53zv0VdPeDjkEmmt8wagvjt7gVI4tfndoktsmAfhEpxAJNGATcbZZj56zamyZEoruszxrlhVqCsfV/ynqYOF4XErzh83OxRukBfKiQLFK0G2Q+DwGnOoXzlSqoMhkqzijFRRTqClFySOzkJc6Q/oxSaW4KstRoGoEd+bL6leiEerEWF/wcIKE2djhJcKBAPzPmjrCtLNRUE6aV+8/A73BX3z70Saw==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by MN2PR12MB4255.namprd12.prod.outlook.com (2603:10b6:208:198::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Mon, 1 Jun 2026
 06:25:50 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%6]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 06:25:50 +0000
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
Subject: RE: [RFC 1/9] hw/arm/virt: Add CXL FMWS PA window for device memory
Thread-Topic: [RFC 1/9] hw/arm/virt: Add CXL FMWS PA window for device memory
Thread-Index: AQHc1nGdihclCKZIH0Gl4GzzPan94bYVbGMAgBP7NNA=
Date: Mon, 1 Jun 2026 06:25:50 +0000
Message-ID:
 <IA1PR12MB9030BFF376C4D5B62A672AB8BD152@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260427181235.3003865-1-mhonap@nvidia.com>
	<20260427181235.3003865-2-mhonap@nvidia.com>
 <20260519134014.474a8289@jic23-huawei>
In-Reply-To: <20260519134014.474a8289@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|MN2PR12MB4255:EE_
x-ms-office365-filtering-correlation-id: 699d0f27-222f-4a8d-38cb-08debfa6a035
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|56012099006|4143699003|5023799004|18002099003|22082099003|11063799006|6133799003|38070700021;
x-microsoft-antispam-message-info:
 iF9kiRm8y58dayzZQpe1S9dzW8gT9JKd1pNjCvTkdRC1tcpwj5n6kEpfwQ2SCPy8eAn59VTIqUQfz/IDehV5hpW+t8uSq6b9Cr0qqIpjGmclbLkmGBEjhZCuH75dS1fLDC3eRiR7Cwtd6sxodD0KmBNpJeWFERsO3X0N5VwAu44cTlJ8LHWDbaYTTDsN2pwgFGGhfEwATUjNTFXFA50SiukD12EpSul6sE9cnNQPSnN4AepHVIwieIi0hiEMDDFThHxOJt2xaWx5G8cylLtQAxZgGHQi4UEzvq+gJSzcebAG4vr+KlSCsLXOH3z5eG2omB/RRpNt+OEAjzMhWQfQHFvt3VIt4RxWFfFl+JmgGhAnrJ28quVbkcpSykm0r2eDxpINh4r/6qvFO672P7EcxR6Goss15ta1BWclXD4mePtKWWnR0SFY4aiMuANxM7ZDeIGuB4fyMlfiPJBim6McbG5d/nnKpkQs320IbDc8lDJ/syOKx0Xg0dP5CFnces4xtOFWRFTvrlB590uWo61JjyDf57IkrrR9XqJibpBJoXz1T0CvaxItzELGANRSxDVQ8EMp8gLkw+uH+QEkhpBx9X+2O524pUHJogWRqgnWsGhn6peOVXGMeRRPyJ78IOtRrCOOZlzRjyc0gSOCKoOw2Y1BoksBBt/KmJaUk1d4hqsLWvDE8Wldj9XVD1A8gn+AWW4nTKpEjj6V/1TgtEnKiNA8vRnjah09q5Z0Ias7ZL/+7JV35EEdJsD0N7M3mhyC
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(56012099006)(4143699003)(5023799004)(18002099003)(22082099003)(11063799006)(6133799003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?i+jDtsie4TdEdnDaH+K40iDjp4bJOQCQumq5mAyZPe9CCpx+yux9ybA2IwoS?=
 =?us-ascii?Q?S/pAwySAk+ygHMx2b8sVsMeRnkdXsnWcgH2Mk6aaZV470A4OPgv4tKnTZstF?=
 =?us-ascii?Q?iKcZhRt9aGAJ2dyQQUnZgqWJVetiFcooRK9iLm5ADdJ9vvVlQJ+RB4/OA7vS?=
 =?us-ascii?Q?W3UY0L5POXMBy/pABWY6ajV1sIWJ+udzh/5xToBl4pNNQjxFDZJFur6ttBNe?=
 =?us-ascii?Q?x6S/X9xi9e9kbkz3FTv4Q6kZS4haLD4WQXehVCjR2ZGEC/4DqOgCUqSBlmD3?=
 =?us-ascii?Q?HgxCuQYnAd0zhrxzvjwkpobmgsvrjPllDgshgNFAh+Zx+z8luELWfX+6U6LA?=
 =?us-ascii?Q?Hwko+O19KbplKWrpG0AQDvtaPnN5RW2G7nOZCSueLGbjRcmgbcBqeBC+Pyqi?=
 =?us-ascii?Q?RRly6zFoa9CJON2y9SXVa56dnAI0y9uENR1FBhZs6GFWVdJRS3/FMaKyHcw/?=
 =?us-ascii?Q?Q30uJjvs4jGkPWVOo+ta3zmBFPpGtsM0dpo6gBzb4fAWFtrortx2K90z7+Mt?=
 =?us-ascii?Q?gzQGCRlPX5zOUeBWl6cZOcSc++ogudEAQ4otPsG93BoJenI7GFBFeaxjQgs3?=
 =?us-ascii?Q?2wFXb9tNp3v5lC58Bjmh1xeYo17He0lzgDU39kAEcLmsG9gS6fxKN7ysQxN1?=
 =?us-ascii?Q?aQrsNVzF9Z1Ivso8OdNcXXicrY0gsa1E0Qd4kH50t9sn5uNR4ATeTUisRVVE?=
 =?us-ascii?Q?iX3ssnddEaUJH/DC8pJdmq0vNABYMUTO0XQ8tYFXsVaGW1mIjhamlF7beNyo?=
 =?us-ascii?Q?v7OqlLv7oq+Lr/tIrL4XtqukLLuB8madlZy+ShmCtBZUz2EKNZ+Np7wgifCv?=
 =?us-ascii?Q?3naXB+W25CVoDKL5NX9mwoVM0DELaPJmoKYQuk7aB86Y/Fcks7I1pCaU20Ry?=
 =?us-ascii?Q?pY1/yiT9vjdVYVAuSDBsG0E/0btm7Y10LaVCe9zxtg5dy2R37+S1vFsVhgBh?=
 =?us-ascii?Q?t6FDTjZ4adP9yTFyp77GmdeOkqq/wpt7XCgFgWOQxAu+r3Ew2YA3eH346BYr?=
 =?us-ascii?Q?+cs2BfV8zUBAFSJffpTdoQqFnTS/3HtrTNdfNl1OH2QEk5njB4sknDMZUQ3C?=
 =?us-ascii?Q?kZA+UZ1Anu5wQd3zURnVHNUV6t2dN0kMcUptYshsNV3I9kTBxdZ3NOzBx8UO?=
 =?us-ascii?Q?k9QG8Pn2MLY0Dp6B8vqTQ9sd2pibP94ZTbfxBixd6lhTFzkFM+noJmMzWVUl?=
 =?us-ascii?Q?OfNCZ1O3Ygj8xDbub4VZJ9hMbDqyQpyrlkM8vwRSGakmpxqaHkdWapRz0JTl?=
 =?us-ascii?Q?dWrZAZ6dPdSSRTAgn/D/lNX68kN0Z9j0sZHqxWH7w0EvTmV9IdIwBB2j+bPA?=
 =?us-ascii?Q?1dB+1i1HTtwDdu3lhqbRBg9iZrnPyJV8meGbrKiIOarTXVpBH5k39OyKTd1x?=
 =?us-ascii?Q?ZZZGqx24GGK79ZtjihsnXa/bobBMEVkYVF4tpDqvECiDyxWAGqrch7UcmiDG?=
 =?us-ascii?Q?mEH8RaaPhdrFBwm+9cZKBwTCVWc0lmqKmO7e7vsVbrmyPPCJAAd6jUUetMTB?=
 =?us-ascii?Q?e2CbEQVJJxjtleTDN83z+vl9pTtYJpFPgwRWqqfUUzkv8qPbBGpVAEQ5GktR?=
 =?us-ascii?Q?HJ6nB4yEBjr4HTIkn5IIksBdeAn/0aaqUFX+tVIVH2NOBb2ajIxUzC+yvCfv?=
 =?us-ascii?Q?4/vGqlPhhv2T6jrQNTUPBQ+t6qdw8CXLzkc61x0Kzv5xEgQj4VQermvPDBK0?=
 =?us-ascii?Q?1VCe9c59+1IA6zgMKJXOQGnvuZXDKisd7PIWmJB4Jysl4f3O?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 699d0f27-222f-4a8d-38cb-08debfa6a035
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 06:25:50.5354
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1X/wL8m2X3bHLFiaPbiLfDJbuo7WlucGkcI6ZFtzBxx5Utm6RYCQ5JNflV26cCH2BXwjn1hB6yoDy8GOnSqNmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4255



> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: 19 May 2026 18:10
> To: Manish Honap <mhonap@nvidia.com>
> Cc: Alex Williamson <alwilliamson@nvidia.com>; Shameer Kolothum Thodi
> <skolothumtho@nvidia.com>; Ankit Agrawal <ankita@nvidia.com>;
> mst@redhat.com; imammedo@redhat.com; anisinha@redhat.com;
> eric.auger@redhat.com; peter.maydell@linaro.org;
> shannon.zhaosl@gmail.com; jonathan.cameron@huawei.com;
> fan.ni@samsung.com; pbonzini@redhat.com; richard.henderson@linaro.org;
> marcel.apfelbaum@gmail.com; clg@redhat.com; cohuck@redhat.com;
> dan.j.williams@intel.com; dave.jiang@intel.com; alejandro.lucero-
> palau@amd.com; Vikram Sethi <vsethi@nvidia.com>; Neo Jia
> <cjia@nvidia.com>; Tarun Gupta (SW-GPU) <targupta@nvidia.com>; Zhi Wang
> <zhiw@nvidia.com>; Krishnakant Jaju <kjaju@nvidia.com>; linux-
> cxl@vger.kernel.org; kvm@vger.kernel.org; qemu-devel@nongnu.org; qemu-
> arm@nongnu.org
> Subject: Re: [RFC 1/9] hw/arm/virt: Add CXL FMWS PA window for device
> memory
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Mon, 27 Apr 2026 23:42:27 +0530
> <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > CXL VFIO passthrough needs a stable guest physical address range for
> > device memory (DPA) that falls inside a CFMWS entry the guest
> > discovers from ACPI CEDT. Without a dedicated range in the address
> > map, the HDM decoder has nowhere to point.
> >
> > Add VIRT_HIGH_CXL_MMIO immediately after the second PCIe MMIO window.
> > It gets its own highmem_cxl_mmio flag in VirtMachineState rather than
> > sharing highmem_cxl, so the two slots are independently controllable
> > even though both are currently tied to CXL bridge presence.
>=20
> Can we clearly state here what they are.  highmem_cxl is the root bridge
> registers. I'm not entirely sure I yet understand what highmem_cxl_mmio
>=20
> >
> > The base and size flow through GPEXConfig.cxl_mmio to
> > acpi_dsdt_add_gpex(), which carves out a QWord memory descriptor in
> > the first CXL root bridge's _CRS. The CFMWS window is system-wide, so
> > only the first CXL bridge gets the descriptor - subsequent ones would
> > produce duplicate resource claims for the same range.
>=20
> I don't follow. CFMWS are not system wide. They refer to one or more of
> the root bridges. I suppose you could argue that the 'or more' bit makes
> them kind of system wide. Right now I'm not even sure why they are in
> CRS at all as opposed to being obtained from CEDT.
>=20
> Maybe a spec reference for why a bridge should be claiming these
> regions?
>=20
> I'm not understanding yet why we can't use the existing CFMWS support so
> please add information on that tot his commit message.
>=20
>=20
> >
> > build_crs() already emits the bridge's own 64-bit ranges into crs.
> > The CFMWS window is a separate system-wide range, so only that window
> > is appended as a new QWord descriptor; the bridge ranges are not
> > re-emitted. A warn_report() fires if the CFMWS window overlaps any
> > existing bridge 64-bit range, since that would indicate an address
> > layout conflict.
> >
> > Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> > ---
> >  hw/arm/virt-acpi-build.c   |  5 +++++
> >  hw/arm/virt.c              |  9 +++++++++
> >  hw/pci-host/gpex-acpi.c    | 40
> ++++++++++++++++++++++++++++++++++++++
> >  include/hw/arm/virt.h      |  2 ++
> >  include/hw/pci-host/gpex.h |  1 +
> >  5 files changed, 57 insertions(+)
> >
> > diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c index
> > 591cfc993c..863e0680fb 100644
> > --- a/hw/arm/virt-acpi-build.c
> > +++ b/hw/arm/virt-acpi-build.c
> > @@ -176,6 +176,11 @@ static void acpi_dsdt_add_pci(Aml *scope, const
> MemMapEntry *memmap,
> >          cfg.mmio64 =3D memmap[VIRT_HIGH_PCIE_MMIO];
> >      }
> >
> > +    if (vms->highmem_cxl) {
> > +        cfg.cxl_mmio.base =3D memmap[VIRT_HIGH_CXL_MMIO].base;
> > +        cfg.cxl_mmio.size =3D memmap[VIRT_HIGH_CXL_MMIO].size;
> > +    }
> > +
> >      acpi_dsdt_add_gpex(scope, &cfg);
> >      QLIST_FOREACH(bus, &vms->bus->child, sibling) {
> >          if (pci_bus_is_cxl(bus)) {
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c index
> > ec0d8475ca..fa07819401 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -211,6 +211,8 @@ static const MemMapEntry base_memmap[] =3D {
> > #define DEFAULT_HIGH_PCIE_MMIO_SIZE_GB 512  #define
> > DEFAULT_HIGH_PCIE_MMIO_SIZE (DEFAULT_HIGH_PCIE_MMIO_SIZE_GB * GiB)
> >
> > +#define DEFAULT_HIGH_CXL_MMIO_SIZE  DEFAULT_HIGH_PCIE_MMIO_SIZE
> > +
> >  /*
> >   * Highmem IO Regions: This memory map is floating, located after the
> RAM.
> >   * Each MemMapEntry base (GPA) will be dynamically computed,
> > depending on the @@ -237,6 +239,11 @@ static MemMapEntry
> extended_memmap[] =3D {
> >      [VIRT_HIGH_PCIE_ECAM] =3D     { 0x0, 256 * MiB },
> >      /* Second PCIe window */
> >      [VIRT_HIGH_PCIE_MMIO] =3D     { 0x0, DEFAULT_HIGH_PCIE_MMIO_SIZE }=
,
> > +    /*
> > +     * CXL FMWS guest PA window - separate from PCIe MMIO so the two
> are
> > +     * independently sizeable. Same default size for now.
> > +     */
> > +    [VIRT_HIGH_CXL_MMIO] =3D      { 0x0, DEFAULT_HIGH_CXL_MMIO_SIZE },
> >      /* Any CXL Fixed memory windows come here */
>=20
> Why not use the infra this comment is talking about?

Hello Jonathan,

You're right that the new VIRT_HIGH_CXL_MMIO slot is redundant.
I will use the existing CFMWS support in V2.

>=20
> >  };
> >
> > @@ -1724,6 +1731,7 @@ static void
> create_cxl_host_reg_region(VirtMachineState *vms)
> >                         vms->memmap[VIRT_CXL_HOST].size);
> >      memory_region_add_subregion(sysmem, vms-
> >memmap[VIRT_CXL_HOST].base, mr);
> >      vms->highmem_cxl =3D true;
> > +    vms->highmem_cxl_mmio =3D true;
> >  }
> >
> >  static void create_platform_bus(VirtMachineState *vms) @@ -1897,6
> > +1905,7 @@ static inline bool
> *virt_get_high_memmap_enabled(VirtMachineState *vms,
> >          &vms->highmem_cxl,
> >          &vms->highmem_ecam,
> >          &vms->highmem_mmio,
> > +        &vms->highmem_cxl_mmio,
> >      };
> >
> >      assert(ARRAY_SIZE(extended_memmap) - VIRT_LOWMEMMAP_LAST =3D=3D di=
ff
> > --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c index
> > d9820f9b41..7de57bbc46 100644
> > --- a/hw/pci-host/gpex-acpi.c
> > +++ b/hw/pci-host/gpex-acpi.c
> > @@ -7,6 +7,7 @@
> >  #include "hw/pci/pci_bridge.h"
> >  #include "hw/pci/pcie_host.h"
> >  #include "hw/acpi/cxl.h"
> > +#include "qemu/error-report.h"
> >
> >  static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq,
> >                                            Aml *scope, uint8_t
> > bus_num) @@ -108,6 +109,7 @@ void acpi_dsdt_add_gpex(Aml *scope,
> struct GPEXConfig *cfg)
> >      CrsRangeSet crs_range_set;
> >      CrsRangeEntry *entry;
> >      int i;
> > +    bool first_cxl =3D true;
> >
> >      /* start to construct the tables for pxb */
> >      crs_range_set_init(&crs_range_set);
> > @@ -161,6 +163,44 @@ void acpi_dsdt_add_gpex(Aml *scope, struct
> GPEXConfig *cfg)
> >               */
> >              crs =3D build_crs(PCI_HOST_BRIDGE(BUS(bus)->parent),
> &crs_range_set,
> >                              cfg->pio.base, 0, 0, 0);
> > +            if (is_cxl && first_cxl && cfg->cxl_mmio.size) {
> > +                uint64_t cfmws_end =3D cfg->cxl_mmio.base +
> > +                                     cfg->cxl_mmio.size - 1;
> > +
> > +                /*
> > +                 * The CXL Fixed Memory Window (CFMWS) is a system-
> wide GPA
> > +                 * range.  Only the first CXL root bridge emits the
> QWord
> > +                 * descriptor; adding it to every bridge would give
> the OS
> > +                 * duplicate resource claims for the same range.
> > +                 *
> > +                 * build_crs() has already appended the bridge's own
> 64-bit
> > +                 * ranges into crs.  Do not copy them again here;
> only append
> > +                 * the CFMWS window itself as a new QWord descriptor.
> > +                 *
> > +                 * Warn if the CFMWS window overlaps any range
> already claimed
> > +                 * by the bridge; in the current address layout they
> should be
> > +                 * disjoint, but catch it early if the layout ever
> changes.
> > +                 */
> > +                for (i =3D 0; i < crs_range_set.mem_64bit_ranges->len;
> i++) {
> > +                    entry =3D
> g_ptr_array_index(crs_range_set.mem_64bit_ranges,
> > +                                              i);
> > +                    if (entry->base <=3D cfmws_end &&
> > +                        entry->limit >=3D cfg->cxl_mmio.base) {
> > +                        warn_report("CXL CFMWS [0x%"PRIx64"-
> 0x%"PRIx64"] "
> > +                                    "overlaps CXL root bridge 64-bit
> range "
> > +                                    "[0x%"PRIx64"-0x%"PRIx64"]",
> > +                                    cfg->cxl_mmio.base, cfmws_end,
> > +                                    entry->base, entry->limit);
> > +                    }
> > +                }
> > +                aml_append(crs,
> > +                    aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED,
> > +                        AML_MAX_FIXED, AML_NON_CACHEABLE,
> AML_READ_WRITE,
> > +                        0x0000, cfg->cxl_mmio.base, cfmws_end,
> 0x0000,
> > +                        cfg->cxl_mmio.size));
> > +                first_cxl =3D false;
> > +            }
> > +
> >              aml_append(dev, aml_name_decl("_CRS", crs));
> >
> >              if (is_cxl) {
> > diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h index
> > 5fcbd1c76f..88bb3c0bdf 100644
> > --- a/include/hw/arm/virt.h
> > +++ b/include/hw/arm/virt.h
> > @@ -91,6 +91,7 @@ enum {
> >      VIRT_CXL_HOST,
> >      VIRT_HIGH_PCIE_ECAM,
> >      VIRT_HIGH_PCIE_MMIO,
> > +    VIRT_HIGH_CXL_MMIO,
> >  };
> >
> >  typedef enum VirtIOMMUType {
> > @@ -147,6 +148,7 @@ struct VirtMachineState {
> >      bool highmem;
> >      bool highmem_compact;
> >      bool highmem_cxl;
> > +    bool highmem_cxl_mmio;  /* VIRT_HIGH_CXL_MMIO window; follows
> > + highmem_cxl */
> >      bool highmem_ecam;
> >      bool highmem_mmio;
> >      bool highmem_redists;
> > diff --git a/include/hw/pci-host/gpex.h b/include/hw/pci-host/gpex.h
> > index 1da9c85bce..a7c2e2edf3 100644
> > --- a/include/hw/pci-host/gpex.h
> > +++ b/include/hw/pci-host/gpex.h
> > @@ -43,6 +43,7 @@ struct GPEXConfig {
> >      MemMapEntry mmio32;
> >      MemMapEntry mmio64;
> >      MemMapEntry pio;
> > +    MemMapEntry cxl_mmio;
> >      int         irq;
> >      PCIBus      *bus;
> >      bool        pci_native_hotplug;

