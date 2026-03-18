Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011031.outbound.protection.outlook.com [40.93.194.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04756277CB8;
	Wed, 18 Mar 2026 17:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773856319; cv=fail; b=foIdMIA7qRM9n0UDtwSeujzE/hcxZsJ1/OEAtoMLsxZE6Y6BhZaUt8Z6z/G/RVHyREUQUkZtd3I3WlQv27SmuCQ6gglF7Gg7tCbzbM6M4eyrt1RIOoansNsJPbGrSnqf2yDNaHWm4yDk2jq18OVYY82tc7mNf9A5V6gj31ffVKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773856319; c=relaxed/simple;
	bh=fvm4/VIS/rImLdAI8NTQE0HRakVuru9+5T5fSr/Jka0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fc8Uixs8/xzeY0aWFf0JkyPkEzf+AnCcmcJB1FAjuTrIfYtaa8LR5vLqyJfO0q1QNUqNfo5AVwcRZXp6nU/5hTiem1ShX81Ux5LgPU0MpAZR3sPyH5gnbBzJJgSL4IFQoY2l4A0Sj23N54mgVyZWLWhpaMU24WJnqLd1GZcCH8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fGMwnWuQ; arc=fail smtp.client-ip=40.93.194.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fGMwnWuQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RezPyoGu2Zm+nY+1csZQ8gr+em7gnnDqfQ90HaT5y1DTJM6v3Y6Lv5gh3BBWSBVvNJRrtKOq0S3Q2us+t0/jXPpSHeA/NkZjWthRbZ+4ROlgZwzNpAkOiuIlKm7ymqwsEuFWhPVI54W7NsfKX5hmYdj1HmIP2I5CVoboyILpuOAKGKAMD3wI+PSVxCZHgX/F1sUATtPJc77wLZuSvq5I/fct80Hg9bdiWKWTEHmzeJBtzhu67s8DddPkW8D6ptuQ3nUOrCLl+PPiHKXaXIDtcvGiwgYDm2W1eLQB6aeHWHvVtjm6vmEUVjfKTTrfLEwf4DjB2fBhS7ucBzvd8VzDLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fvm4/VIS/rImLdAI8NTQE0HRakVuru9+5T5fSr/Jka0=;
 b=EWQhwhNnTXGMlRsnnXsZCIqXLltsnbw5FSsuMPvATznxITKonuaaVABfEvjgyR+LGpn85qq1AMh+zKpS6uMMh72lLfYOcCA2p3Crjv7n9nYTE7Bs/webGxrQ+g2J6QR7VdLCPClZ6yu3kL0pTSskn5wEXNFwwmIXAdoNHIXh04S2uxRIbfybF+clMXDnD1Ci9RftcpAfDahMNoYrkWjCFJ2joVOga4HaSCnEuVP5aHrFm71YNRj5dhGzKlZwI13BI0UKz/2RO44hVnKWuN2zAJKSCNANe/72FscLzhWosj6CmLINQ34+zqxPIK9eTNiPuxcC5+GIYzVhh+V3bQrzIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fvm4/VIS/rImLdAI8NTQE0HRakVuru9+5T5fSr/Jka0=;
 b=fGMwnWuQFzB+bxx5XihqWvxqMr0l/FRmFTZH4wOvHU327X+sb3Xi0wVV48svNedRxVAdVKWQBXkRUNg5JNWn8DO85QXnaCgPMp4KDJpufdHxMtlUFvTpmNIUaNisP+uDjdjMREvS7qeeTXBcBDO8eK22QO9YUNfE1yEwxD4BF18eANHBc/GSLV9DK4W9Y4JWz0B9qr3HmTiw8GI2e8oFcYaWvefqv5yiyMvbRE29vUWmMY5eqi8eZ7HDQH2z0QIqQK0lOCQYer6v7FadOjM7v1/RCcr6Rn+juT18L7bkYKUJlXFQH/XPhXry20AvJOVsyjaQthjcGKYgH4egUfP8ng==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by SA1PR12MB999110.namprd12.prod.outlook.com (2603:10b6:806:4a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 17:51:54 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 17:51:54 +0000
From: Manish Honap <mhonap@nvidia.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>
CC: Aniket Agashe <aniketa@nvidia.com>, Ankit Agrawal <ankita@nvidia.com>,
	Alex Williamson <alwilliamson@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Shameer
 Kolothum Thodi <skolothumtho@nvidia.com>, "alejandro.lucero-palau@amd.com"
	<alejandro.lucero-palau@amd.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"vishal.l.verma@intel.com" <vishal.l.verma@intel.com>, "ira.weiny@intel.com"
	<ira.weiny@intel.com>, "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
	"jgg@ziepe.ca" <jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>,
	"kevin.tian@intel.com" <kevin.tian@intel.com>, Neo Jia <cjia@nvidia.com>,
	"Tarun Gupta (SW-GPU)" <targupta@nvidia.com>, Zhi Wang <zhiw@nvidia.com>,
	Krishnakant Jaju <kjaju@nvidia.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Manish Honap <mhonap@nvidia.com>
Subject: RE: [PATCH 03/20] cxl: Move CXL spec defines to public header
Thread-Topic: [PATCH 03/20] cxl: Move CXL spec defines to public header
Thread-Index: AQHcsZaoXaXiS49oSEGXVBKnfr1oT7WsY7aAgABNsgCAB7o8gIAAMFFQ
Date: Wed, 18 Mar 2026 17:51:54 +0000
Message-ID:
 <IA1PR12MB9030A4828EE4C3E2B5A7DC21BD4EA@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260311203440.752648-1-mhonap@nvidia.com>
	<20260311203440.752648-4-mhonap@nvidia.com>
	<20260313121805.0000611e@huawei.com>
	<fd232cc5-f2ab-463f-9238-44e2514d4ad1@intel.com>
 <20260318145633.0000392c@huawei.com>
In-Reply-To: <20260318145633.0000392c@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|SA1PR12MB999110:EE_
x-ms-office365-filtering-correlation-id: fe08928b-ee43-48fa-4d98-08de85170ae4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info:
 3KEREAg08Gv+qU26m3G5t3fmyJk07c1ZI7x4ty+ykLVG7l/GPafbteHbPLAT+ZQ1TXOrArQp2dwsmtiCweBIyxOF35quUyEZ0wjulqsdRNs/P5kG0pc6g/TDDtV+26L+Ny5wMtip3oinUkTInoghSeuaHAy5i0lkqMB2IC6js3H9Wcqs1GeFRkJE8Pqh54Q5qKciAcn7XPnYzD54jYYrEliE2lyaF822LpkCmz5h8LmyP+lKguQMyNmPiPt9ojN3Y1D+0TstJF1WjCrQ2JXp5ClXNLYQDDYt5DuBIxmuFbSqP+/5QYKW5wFU1p76yVCnHmMB7MN4H26OYl98BPN/Ld3ZFI0WjCn4kmbNPSgOOEX3PH1XiLlp8gdTVf2syK/e+j3zouBVirG1XKM2x00hshhvUH9kPW8+QLpc7ho5XOnjvGatAChmuhZFcv4f/U9ibw65gEtdE8HGsPNtErUJyCmHRbg9JhDIRU2CrStJs/ZJrdngBMmdt8TvUjInGPqezRFYXmFXUVEmmOxetaki3pYet0YCwlqwdz7HidrNLorYGqjuJIxwLx4k7wsLEx2NWFv1Fx4tsiovwtFY6lIj028nOzPu6/RUu2RbAZSJACOsV9M9XqlqJLjxvT/M5N1RQ8MW2cePEMcPMpy74iV44fdOgQeK5OV4y7CHFbgvAw/9cp6BHbvhApvA81UVoRN5uAXI/t5LzzEEPuNb/nunBRPcJtx0BztnIza9duASFHJtiVS5JIFjk3U/6vynjpRFAqT4keOnpJD+INrbQmXNXoZQNWK/JPB8q5kj6th1wOE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?eRQKgaYmE2edfX1v0LFLS+FHn6qUFYpnTySvxU9ZJE5EgL0ToPRbUnH8ZQK1?=
 =?us-ascii?Q?6WQR3JtL3AFxONdwCGm/E84GhXjE4eDxDcVk02pxtRn8WfA+i860bGAc4Hrl?=
 =?us-ascii?Q?qTtuiDEGX8xbTLRI3b+OXrNUiLgUyn6Elj8Pw8oelAkvrlEPaZ9WpWXuZMQk?=
 =?us-ascii?Q?l254iHzVuzIxX1ApRp54akPFM7DSbaZ30gktb1gmP8Bpn3IV99uawNq1mMCu?=
 =?us-ascii?Q?gabVy2fJs+TCKrYn8eKphwAUAwy2NXaPiumxq8BjGM6SE2bAjke411jO/Dua?=
 =?us-ascii?Q?Yd5WPXQsrlu5XWsZVRVbieMRxSS6neiPnbBNNk57DjTM5+ne2IZ4N53TNWEo?=
 =?us-ascii?Q?lkpi9GZ0AvdDxqQksRMur5w+iC9BmJa1iJAq1mF/jU2xhcj3dK/8ALYLKi/w?=
 =?us-ascii?Q?w8rXnQ1w35UhpKy0CD7rQhl5Eetz29cqwiH0rQ1F3oKsF2+jOpmdDeXTzMNr?=
 =?us-ascii?Q?VNzwxwiec3klU86fKxD+kF3r5Nf5VKGhIpHIPCfd1+B166NTERX9dfE7lGae?=
 =?us-ascii?Q?gGE29HtqtX9HvO8zhK+z/i6Nl0iQRYDp1OxFECCoSkjr1Ihq5CcMcn3dZlvZ?=
 =?us-ascii?Q?MEi4u6Iw6drEl9SeCjWoph/QHY7kVFZeme30sSRYGq72DrBZRkWNez0p9UCc?=
 =?us-ascii?Q?hd+azCYfg3z7n4xQztrEu4I9di6NzW/tZo1nDYbMQjb4co8CAvQV+Kd9acHi?=
 =?us-ascii?Q?3DDvBNXi8qrDBVZfiUhW606igL0WsB890OGxlLz4mt1MbyAW8UwcTNG8MPAk?=
 =?us-ascii?Q?MzLVTTd1joYu9IAKZgmI1Qgmm1qPkxblUSWtno0cvkSdZQlb0yoY+rhoe6Ww?=
 =?us-ascii?Q?Wt0Y+6e+AEBMEgrxFcgOLhUz3pMLQHr0Kxa663L8E3+x2ZLWPScqdhqeA20G?=
 =?us-ascii?Q?26JpNLsOxvyDaDDdea043OmKGXkogeHodi++4S0vuvWKTTzRLzpxYvZqYPX1?=
 =?us-ascii?Q?nVfAHdJa1/Kc3uGT22H9X5MDxNgYGKKLiub3LWBevbdbBmvFmzjij4bbYSvh?=
 =?us-ascii?Q?FN0JI8WWw7Ny1lJ6sQuMWbqj8JWr8g7mn3Srlf+JBcxLuwsKXXpJOBMgI9yw?=
 =?us-ascii?Q?AMzHZC9tCemzlAuWEvec87M8EIrqdys9jx5DfMO3COhranCd6SOkvJu3vrLo?=
 =?us-ascii?Q?++JhoXjrECM4FyauRVWdx7QJZwTYQWjKV5ZBQOw8okg9C37sOW81XdNwlEfO?=
 =?us-ascii?Q?mKIY4Nwk+8FIye3H3OpxP7UXlMdrrm9nJOA43KJ53jlqdhxqCdrA6h/Zzcng?=
 =?us-ascii?Q?ZCg7I9zryvZRsx2gQPUmP5SZK3nkm1rBjeaxNVFe0TVsWXo69WpxsHLHmOp8?=
 =?us-ascii?Q?LtkZq59+xltxZkWT3tE5Q1BIsBrq2wIaySyD2R0o0Mu+xhhRz4DENXpVBcf4?=
 =?us-ascii?Q?31lSrvHz2OImhLzZJWIl5Np4IbjhgBrcCefcEsvX3TiCOr6om+o2VmM7bqiZ?=
 =?us-ascii?Q?Zt2BKR4p5fi447Ye84kcrVFAt0qyr6tzN+iwe2NaZ6Jrz61LJ2AqPELXqCbg?=
 =?us-ascii?Q?qV6B9o5dCsH9I87X2HulzrxFMjY7CxLuVhk4JjQAqsfHbjQFt23xJcvkK/+g?=
 =?us-ascii?Q?imxl85umT3fAUG2pnrom86azGSOHcVZyU2EZrDsb8s0kIrZbuV0Jfadu4IH2?=
 =?us-ascii?Q?5Z52vUSYjP5FX2p3oj6z2daKxUV5tC4UMyk3yvw8N4LqdLwASNfeLYsp5wMp?=
 =?us-ascii?Q?ALNVMrQRL7BnBoMJOnE6SlS59XbBUaxJawbq2E7jQ0WIallM?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fe08928b-ee43-48fa-4d98-08de85170ae4
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 17:51:54.5465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MDN3x88SXCFZ1klKj1qmUBV18ECmtLW+fG53y3YSORPw1XiTpAgvOSshwVSCDTSR4tqSjLoT2LB4UZnWgDsGcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999110



> -----Original Message-----
> From: Jonathan Cameron <jonathan.cameron@huawei.com>
> Sent: 18 March 2026 20:27
> To: Dave Jiang <dave.jiang@intel.com>
> Cc: Manish Honap <mhonap@nvidia.com>; Aniket Agashe <aniketa@nvidia.com>;
> Ankit Agrawal <ankita@nvidia.com>; Alex Williamson
> <alwilliamson@nvidia.com>; Vikram Sethi <vsethi@nvidia.com>; Jason
> Gunthorpe <jgg@nvidia.com>; Matt Ochs <mochs@nvidia.com>; Shameer Kolothu=
m
> Thodi <skolothumtho@nvidia.com>; alejandro.lucero-palau@amd.com;
> dave@stgolabs.net; alison.schofield@intel.com; vishal.l.verma@intel.com;
> ira.weiny@intel.com; dan.j.williams@intel.com; jgg@ziepe.ca; Yishai Hadas
> <yishaih@nvidia.com>; kevin.tian@intel.com; Neo Jia <cjia@nvidia.com>;
> Tarun Gupta (SW-GPU) <targupta@nvidia.com>; Zhi Wang <zhiw@nvidia.com>;
> Krishnakant Jaju <kjaju@nvidia.com>; linux-kernel@vger.kernel.org; linux-
> cxl@vger.kernel.org; kvm@vger.kernel.org
> Subject: Re: [PATCH 03/20] cxl: Move CXL spec defines to public header
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Fri, 13 Mar 2026 09:56:10 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
>=20
> > On 3/13/26 5:18 AM, Jonathan Cameron wrote:
> > > On Thu, 12 Mar 2026 02:04:23 +0530
> > > mhonap@nvidia.com wrote:
> > >
> > >> From: Manish Honap <mhonap@nvidia.com>
> > >>
> > >> HDM decoder capability structure and component reg block size needs
> > >> to be used by VFIO subsystem. Move the macros from private CXL
> > >> header to public one.
> > >>
> > >> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> > >
> > > Not really related to this patch, but...
> > >
> > > Maybe this is the time to think about doing a PCI like
> > > uapi/linux/cxl_regs.h header?
> >
> > Sounds reasonable. Maybe makes sense to be in uapi/cxl/? There's alread=
y
> a features.h header in there.
>=20
> Sure. I'd forgotten about that directory.
> Jonathan

Okay, I have moved the CXL r4.0 spec defined register bits and flags in
include/uapi/cxl/cxl_regs.h but for the bits/flags which are required
for emulation handling, I have kept in vfio_cxl_priv.h.

