Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012025.outbound.protection.outlook.com [52.101.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3423876D5;
	Mon,  1 Jun 2026 07:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780300584; cv=fail; b=ilZo54sFpGNR1i2peg4zsi/WjZkVhcPAx4mQZwA95ruFVOmiozgW1tmg2EfyNFp4LQweq7jpiuahb2Tl/z5TLZYCDubomf2g1+4QssSGM3IAhiKqqRCsbt8Rc7a/H6kXHjAIM3ZYn7TF02ppusEceO36qVIgHUy2z4jrhm+71to=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780300584; c=relaxed/simple;
	bh=CipCXj7+L5siK0UHVyeLr6E72tNKFmddAror4z/Yr5g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U9pWuWjO/DTd5pU7JjQrGoIJljSBrlz8Qnb/OpFEwbzW4a7OUicW/8WwZCeykqEdD5hb3bnw9x95Lw0sxhKRVRc8Iqr9dj0L0e0wKm7RmRwwkE9NGa0DkfJ/rG8M4Q1HehIn1i2W/w11AmaGwIXgJbw8cyAgdsXUkYXkZmznCxA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GAkKP45n; arc=fail smtp.client-ip=52.101.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GAkKP45n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iKviC51swj+JrHjbdLeEz6dsliu0GI0F5mMwLa5wTn1nshldbEU7NUnToB+v/Hb+MUrAn/woi0MqmLULhDhs0sT0AQUiWBagktukK/vqbjX5l1zJPBJ/B3oKrIpbem4R28gqPTfmHx9hTlBG788NRhKlpyICm0OrreagvMFQ+l/pBAz5B4K7GUqbL3fLupV39qF+ND2lFd1Mq6q8dApbjKR/ixV7w6SjuvSxFk+U8/6ogf6B88O8I2q/SyvwEUOPSQ6lnD27c4vE7y8PyLFGhDFFrED0u4kHz9X6WqVd5rW7K5gBPmgxt0zP3qVxhS4GZNWjYnHvh/V2IaGlICESqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9OZNYZIMLflo2tvbQ5s+yfYmIu8VzhNHTvJZZ1WekPM=;
 b=niOYXGdESi/QHZc/FcKktQoEsqZ96NV1HWB2dVwIFq98T81TiaEjO6o01KnR4lYfSZrOb3Bdx5xsA3ldwPIkKf6VHxW8Zvg/wI6iswBCvzgWaoSkjwo9w0zlA8kqvT3MsDtB+TRobL+myRmn5DInFH9kN2N/2KBxv9r7XbqRtMdtcaCEwQNW6HGyA8ZiSYhJbNHoRnvw52DAx+Zs1v+ZYCFD/IraAtMUZSxtDeBJsY49hlIPB4wCBKXkjvo/prh83KxSoSW+z/yrKxcQmAVYaQAllcFwuvU1TSkmM22+W5bIJASZgcpHvx9ydMjT0lcOt+s7PSI2bjqegh+io/By0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9OZNYZIMLflo2tvbQ5s+yfYmIu8VzhNHTvJZZ1WekPM=;
 b=GAkKP45nJKCIf58bh8OEIpO5DBI9RWrP+x8p/zeocrr5mGEKIBByfN7IJqlHJZkEDbPg8yKuLWK/lE6ir5kf0jWDVVF4dKLahyjMTIewsgVrxBWp5WtVATis4LtDNLae02D1XkM/JYwLt18/hsqF7H+4jAYZM8JboUpBNpLp5T/L2h9k5qxQCydlNYCa5pxQUsdydJeKAiK0gq5dHeModEdq/zR3BfQXTITv+oIT/i8wZhhEdolQHZLmxLiL25YWI2v49rq5oWu2kuhQUvwA336ylQ1BEazrJYspyM1GRkLnKO/4y2YMEymrd44pOUjf1kUeyMyVeGRZZdpXV9G3xg==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by CH1PR12MB9621.namprd12.prod.outlook.com (2603:10b6:610:2b2::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Mon, 1 Jun 2026
 07:56:15 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%6]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 07:56:15 +0000
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
	"cohuck@redhat.com" <cohuck@redhat.com>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alejandro.lucero-palau@amd.com"
	<alejandro.lucero-palau@amd.com>, Vikram Sethi <vsethi@nvidia.com>, Neo Jia
	<cjia@nvidia.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>, Zhi Wang
	<zhiw@nvidia.com>, Krishnakant Jaju <kjaju@nvidia.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Manish
 Honap <mhonap@nvidia.com>
Subject: RE: [RFC 0/9] QEMU: CXL Type-2 device passthrough via vfio-pci
Thread-Topic: [RFC 0/9] QEMU: CXL Type-2 device passthrough via vfio-pci
Thread-Index: AQHc1nGWa4JdJckdaUeXWwvR6hvQ9rYVdZwAgBQGnVA=
Date: Mon, 1 Jun 2026 07:56:15 +0000
Message-ID:
 <IA1PR12MB90303161DD09A1E248852728BD152@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260427181235.3003865-1-mhonap@nvidia.com>
 <20260519141314.3eda68bc@jic23-huawei>
In-Reply-To: <20260519141314.3eda68bc@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|CH1PR12MB9621:EE_
x-ms-office365-filtering-correlation-id: f67409cb-b1b8-4802-5fe1-08debfb34192
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|22082099003|18002099003|38070700021|6133799003|11063799006|5023799004|4143699003|3023799007|56012099006;
x-microsoft-antispam-message-info:
 DJUkWj6BUuMp3EebUZlcFhFieJ128sz4Jzn8SfNv/VuGhcSYK91+ASwhuRBQ0vJoUw0RHsW1M2hp4jJrCjHviHOvd7ZW10P7Nb17gf2sLL9pi20PLtAAfH9YTKdwdadTrIHcVNvvxlR/MG031zbjuU4vvfdumCN00f/fxm5q4yHJp7QbjA1fDYsGOdH8luCbt58TXDgfOgx+sdSwIqK/KzCJuTecF+ZBhjHs0/gztXJ2sBnNNVHHyrqIHfFXz/G/doEB4kRaaQy5VZOMKUbzOAavlfN3R/bDEmv7bs6kzuiA55KKTbwjZZEpzwt8TCWFyIAekfw3rdG52G589x7WjJhH8nDRGnnnVa8cJfNoKzeGcaoLmqJ8pM3mylX+Zk015/yirlV9mrVEXYUXRxqqyA+iBdfzB6DellbxtrqbRZnPNheW73uztFwebJI9EA2izVjBh/D3AUrJbOg9GKh6CLtqTeqfdBZug20LCtahHGqZch5P7txbObf9tX+tCzH6UAypLryq72yL/zbH3/fhK/2Y4EHAvHSgwsIe9IBRyScef5lCSfHp7eklfbO13o0ybs6Ie5ah3WjAOkmCeV2zdOHE6yObzU7EqK+6DLi/agOxjNd6BvH+VUGkJegfhqaeHADTvvMg+UIDfBoAPpb/83QkekljD19CSEU6vWlYPmQZHrnal3SczyPCACM8EiQpXZgA6bmMnSuXmhfeRkdFgih4P4SrF/kFhiaLFnwLkSrpOCUHk1+xUOqq6ezZIYZc
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(22082099003)(18002099003)(38070700021)(6133799003)(11063799006)(5023799004)(4143699003)(3023799007)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Wbpw85ujMaXJmMj/RrG5+GAe4fvhoB1DvgiEecNldHsEFBAloHutAxy54HOd?=
 =?us-ascii?Q?hc/bzb5JxRh6+pjDRS3nRgnytphzR2pVRXIU/DWmiau+7rTw2by9eCk/rFe7?=
 =?us-ascii?Q?fe9MbBUDuF3ifvy+VuD5gGz4rZ6SkCEeDek2FcGbJeC3tPjMmIlmG5IOsjXw?=
 =?us-ascii?Q?kxVZVLaSp1adAlV+l63ekQDOnrcijZGOx2gZ0kwLlsbEwRblZ7p8PV2cPyc1?=
 =?us-ascii?Q?aJaRKOaRi7cqsafHnPERANEvO3wGBQDz+GRQ7RU0ZRnASUu1t08eETsw6HuV?=
 =?us-ascii?Q?auqcl+c38HpfsuaRavZUVA+ahI8S4x6gBXXj7NmlNfNqQMmP1GtQYbUZwI+m?=
 =?us-ascii?Q?q319S92M6lhY8YsfGa8rZozv5Y3XMDg2XALOlk5TyrZvF142Z1kx+l2xFldt?=
 =?us-ascii?Q?6yK4t2LACMDLtB5CxY5BoYpX4P5aeL2LN+2ncCQrC3tShQQFNT/o1sqGLGiD?=
 =?us-ascii?Q?yUD3V/eZ10y8ojbPMsPTm3/u9uQmcWFZ6oA83aepqAjkp2akffvjtJUfEdj2?=
 =?us-ascii?Q?l9rpA1ALrw4atTfbKP2bg16rWZqmsAmPaa20ojp90ZSpYoF/SlkL2vO+IlAa?=
 =?us-ascii?Q?tb2hIwwfN7CJhSb4V+OqWOBCQ+bMfcLm+cyVzDy7fGErs6DJjsllFhtvRvDG?=
 =?us-ascii?Q?cNKhrPjbXV8nghx5aKm7eHht3sI3VkAMwY+thg690MCIRkKndvHWF5mVJzLS?=
 =?us-ascii?Q?EDuiksCSR4NCuIJHYsDwuDPfVhpinHB7tSPPnx2J+xwnQVPM+QiOzr5pkeRI?=
 =?us-ascii?Q?aVyY1ZFkLTUFh4GSpuR/217moJ8yUGTEUE67c/YhCMNFnsLESQmgGGT9YjgY?=
 =?us-ascii?Q?+ZyFL9bHVcKjTlhE87K9Bck3ZRacNVP7PWhdO1LLlRwn8ntxb8/OK6LYBr8H?=
 =?us-ascii?Q?Q9akk3Gnt5bs5FbUJ3ML66vBN10TNQdw27ly07wfa/jzJNUKoWeYpdhn2zcL?=
 =?us-ascii?Q?YinNzoqVxkFM4KmiOqS2DruJHtiuGAII0ZuoCk/eIfZNVAH21oVa8AEV42IX?=
 =?us-ascii?Q?+LBbqyy+mh2eA0SYS0ekQQRvLfntHEpcLin0t7ZGNt/gLK8q4+MezqMH/8he?=
 =?us-ascii?Q?IkMh0ZkVwRf6VvUUbo3Al9Qwz4DBVjhyboidc4dBaYof9MYjjdA1Vo5E6AJ2?=
 =?us-ascii?Q?jCPXPAN0Pm+xP9Hq2MKGmu2/kj+NOMZEp3c/+p1JAeMSe/kyfsTcApkvTwS5?=
 =?us-ascii?Q?WANIhwGxtRfD5gbXK2UEkwdi2nqdghFTu4v3mi/6/774rj3o9oW6jnivnoLv?=
 =?us-ascii?Q?ChzgerbAa4IHW/e6wRePSBuZikofNZ1uVFAgNroPqnI34FILm7uzzk/5j9cR?=
 =?us-ascii?Q?z/leasyX6186dXpZc2+S/iIM4AJhOy0jpZloNa8IRlufipr5eVIFfC+itwhI?=
 =?us-ascii?Q?B1PQeiqbKhm4mm9HoX/re1H01y3edwzlYB1N68mDQcBtq0ctbBas00f1gIZC?=
 =?us-ascii?Q?r4/4hF31SEDi42zmgFYT15WEEwxFjKqCPRDziV37uEGnnklOMIqsr4J47gKU?=
 =?us-ascii?Q?6lSMT8+pgY1dD8SOh0YzeIxn0EbLfwHrua6LXgdxAH0QobGfscahAsIjbro9?=
 =?us-ascii?Q?RilmYs554QYWjGwFPVL8t3ghzJS2qMWwi6OJnSAreqiPqVeB3ihyXWoX9zCu?=
 =?us-ascii?Q?Lq6H+rs0YmEroNF42EB5PsRqDIsC0ATOwm1S/pAulxg0Z1PrmDa+k6z8/PpX?=
 =?us-ascii?Q?Wzhj/fwDIR2RnGMY86JBKjgMQ6gdS2yDOKySjpKW6nVaxsP5?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f67409cb-b1b8-4802-5fe1-08debfb34192
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 07:56:15.3281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CHrVNYHbwMLYbH8iKjXYmT1x1XylI9eENIUjc77lFM+xwv6eLp99KhT9Difzjn913ILLKDTkYkqNZTBycmhINA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9621



> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: 19 May 2026 18:43
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
> Subject: Re: [RFC 0/9] QEMU: CXL Type-2 device passthrough via vfio-pci
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Mon, 27 Apr 2026 23:42:26 +0530
> <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > This series adds QEMU-side support for passing CXL Type-2 devices
> > (GPUs and accelerators with host-managed device memory) to VMs via
> > vfio-pci.
> Hi Manish,
>=20
> Having read this description I'm not sure I really understand all the
> constraints this is operating under.
>=20
> There are two basic paths to getting safe virtualisation of CXL.mem.
> 1) Lock down decoders etc against preconfigured mappings.
> 2) Constrain the more insane stuff via topology care - basically direct
> connect
>    only for now and let the guest program stuff appropriately.
>=20
> One possible constraint is making it all look like early CXL host stuff
> where the bios does the heavy lifting.  I don't mind if we have to do
> that today but I'd like to understand if it's a long term requirement or
> not.
>=20
> I think this is currently doing a mix of 1 and 2.  You lock endpoint
> decoders but ignore host bridge ones.  I think we need to handle those.
> Maybe I'm missing a check that a pass through decoder is in use (there
> is a commandline control to turn that on / off for single RP HB).
>=20
>=20
> >
> > It pairs with the kernel series "vfio/pci: CXL Type-2 passthrough"[1]
> > posted to the vfio mailing list. Patches 3-7 need that kernel series
> > present to do anything useful. I am new to QEMU development, so please
> > forgive and point me in the right direction for correct infrastructure
> > decisions.
> >
> > Background
> > ----------
> >
> > CXL Type-2 devices expose device memory (CXL.mem) through HDM
> decoders.
> > The kernel vfio-pci driver shadows the HDM Decoder Capability
> > registers so userspace can observe and control decoder commits without
> > touching the hardware register page directly.
> >
> > Without this series, the guest never sees the device memory range and
> > the HDM decoder goes unconfigured. The device shows up but its memory
> > is unreachable.
> >
> > Design decisions
> > ----------------
> >
> > CXL.mem is exposed to the guest as a dedicated GPA window declared in
> > ACPI
> > (CEDT/CFMWS) rather than a PCI BAR. The HDM decoder BASE must match
> > the CFMWS base and remain stable; BAR assignment is not stable.
>=20
> Note a lot of my thinking here is based on the related but not identical
> question of how to do CXL type 3 emulation for virtualization cases.
>=20
> My thinking for type 2 is we'd do similar tricks to for memory in
> constraining the topology so things like interleave don't cause us
> problems and CFMWS to particular device mappings are fixed (though in
> theory offsets with in CFMWS could change).
>=20
> I may be missing the point entirely but why does HDM decoder base (here
> the GPA address where the routing is configured to put the DPA of the
> EP) need to match the CFMWS base or for that matter remain stable (i.e.
> Guest forced to put it in the same place)? Is it just so the type 2
> driver knows where to find it?  (There are easy ways around that - or is
> this something baked into an existing driver?)
>=20
> There are a few easy ways to constrain things to reduce flexibility
> (e.g.
> we don't want interleave to be possible etc).  If we absolutely have to
> we can also lock decoders. The only reason I was avoiding that for type
> 3 device was that it isn't needed + can get complex fast!
>=20
> I think you are constraining the topology for this to work to PXB with
> 1 RP with pass through HDM decoders and no switches etc.
> That's fine for now but I didn't immediately spot the checks that
> enforce that.
>=20
> Can we have a command line example in this cover letter.

Restating the paths for CXL.mem virtualization for v2 scope

Path 1: lock down decoders against preconfigured mappings.
Path 2: constrain topology (direct-connect only, no switches,
          no interleave) and let the guest program decoders.

For V2, I will:
  (a) Document the Path 1 / Path 2 split explicitly in the cover
      letter, and state that this series implements Path 1 for the
      endpoint inside a Path-2-constrained topology.
  (b) Add a command-line example to the cover letter (you asked for
      this on patch 7/9 as well).
  (c) Add realize-time checks in vfio_cxl_setup() that refuse to
      start unless:
        - cxl_get_hb_passthrough(hb) is true
        - pcie_count_ds_ports(hb->bus) =3D=3D 1
        - no switch is present between the cxl-rp and the vfio-pci
  (d) Use existing CFMWS infrastructure and drop VIRT_HIGH_CXL_MMIO
 =20
>=20
> > A separate
> > VIRT_HIGH_CXL_MMIO window in the ARM virt memory map carries this GPA
> > range, independent of the existing PCIe MMIO slots.
>=20
> I'm not immediately understanding why the CXL.mem path isn't via exiting
> CFMWS support.  Why do we need a new memory window?  Ultimately you seem
> to map to normal CFMWS regions.  Also note you need to be very careful
> adding stuff to the memory map as bunch of other stuff above that will
> move - so it must simply not be there by default to avoid breaking
> migration of existing VMs.  Maybe that is fine, I didn't check carefully
>=20
> >
> > The Component Register BAR contains two distinct ranges. Accelerator
> > register windows are passed through as direct hardware mmaps via
> > VFIO_REGION_INFO_CAP_SPARSE_MMAP. The HDM Decoder Capability block is
> > excluded from that sparse list by the kernel and must be intercepted
> > by QEMU to track decoder state. A single priority-1 COMP_REGS overlay
> > placed at hdm_regs_offset inside the BAR container wins over any
> > hardware-backed alias at the same offset, with no per-window aliasing
> > required.
> >
> > The guest has no mechanism to remap host physical mappings. QEMU
> > programs decoder 0 with the CFMWS base through the kernel's COMP_REGS
> > shadow at machine_done time, after all devices are realized and before
> the guest starts.
>=20
> Ah so this is locking down the decoder?  I'm not necessarily against
> that but would like to understand what the constraints are that lead to
> that being necessary as opposed to guest programming them later (and
> late set up of the MemoryRegion like we do for type 3)

Decoder locking is required for this series because the kernel-side endpoin=
t
driver expects a committed decoder before vfio-cxl probe completes.
The host CXL stack commits the endpoint HDM decoder before vfio binds; QEMU
then locks it again at machine_done with the GPA so the guest cannot move i=
t.

>=20
> > The notifier is registered only for devices the kernel reports as
> > firmware-committed (VFIO_CXL_CAP_FIRMWARE_COMMITTED).
> >
> > The CXL.mem MemoryRegion is a mmap-backed RAM-device region backed by
> > a VM_IO|VM_PFNMAP VMA. The VFIO MemoryListener would attempt an IOMMU
> > DMA mapping for it when it is added to system_memory, which always
> > fails: pin_user_pages() refuses VM_IO pages. No IOMMU mapping is
> > needed for these regions - CPU access goes via KVM Stage-2 page faults
> > and device DMA to RAM uses separate per-RAM-section IOMMU entries. The
> > listener is extended to skip the mapping attempt for VFIO-owned
> > RAM-device regions.
> >
> > pxb-cxl bridges had no _DSM method. Without _DSM function 5 the OS
> > defaults to treating PCI configuration as reassignable.
>=20
> That one is annoyingly controversial. I see you have Shameer's patch so
> he can go into history of why. I tried to land that in the past and I
> was far from the first.

okay, I will check this part for additional details.

>=20
> > On machines with firmware-committed HDM decoders that reassignment
> > breaks the CXL.mem mapping, so the _DSM is added with
> > preserve_config=3Dtrue for ARM and false for x86.
>=20
> What has that got to do with CXL.mem mapping?  It can move the BARs
> around but those aren't related to the CXL.mem mapping.
>=20
> Can we break this description up into two separate parts as it feels
> like BAR mappings and CXL.mem mappings are getting confused.
>=20
> 1) Deal with how the configuration stuff works - bars etc.
> 2) Deal with the CXL.mem mapping into a CFMWS.
>=20

Yes, agreed these two are independent.
For v2, I will split the cover-letter narrative accordingly and reorder
patches so the CXL.mem story (HDM decoder, FMWS, decoder lock) sits
in one block and the PCI/BAR story (_DSM preserve_config) sits in
another.

> >
> > Known issues:
> > - The bios-tables test will fail due to the _DSM addition.
> >   A fix will be provided in a follow-up round.
>=20
> Unless I'm missing some checks, a whole load more than that will fail as
> device memory / memory hotplug region + probably the CFMWS regions all
> move.
>=20
> > - VFIO_CXL_CAP_CACHE_CAPABLE will require additional handling.
> > - Devices with multiple firmware-committed HDM decoders are not fully
> >   supported.
> > - Non-firmware-committed devices are not supported.
> > - linux-headers sync is manual and temporary; once the kernel series
> is
> >   merged, this patch will be replaced with script generated update.
> >
> > [1]
> > https://lore.kernel.org/linux-cxl/20260401143917.108413-1-mhonap@nvidi
> > a.com
> >
> Anyhow, seems like a good starting point for discussion.

Thank you for your suggestions.

>=20
> As we evolve the CXL support into including real virtualization use
> cases I'm sure we'll also throw up random corners around resetting etc.
>=20
> Note I mostly skipped the VFIO stuff on basis others know a lot more on
> that side of things than I do!
>=20
> Thanks,
>=20
> Jonathan
>=20
> > Manish Honap (9):
> >   hw/arm/virt: Add CXL FMWS PA window for device memory
> >   cxl: Add preserve_config to pxb-cxl OSC method
> >   linux-headers: Update vfio.h for CXL Type-2 device passthrough
> >   hw/vfio/region: Add vfio_region_setup_with_ops() for custom region
> ops
> >   hw/vfio/pci: Add CXL Type-2 device detection and region setup
> >   hw/vfio/pci: Wire CXL component-register BAR with COMP_REGS overlay
> >   hw/vfio+cxl: Program HDM decoder 0 at machine_done for
> >     firmware-committed devices
> >   hw/arm/smmu-common: Allow pxb-cxl as SMMUv3 primary bus
> >   vfio/listener: Skip DMA mapping for VFIO-owned RAM-device regions
> >
> >  hw/acpi/cxl-stub.c         |   2 +-
> >  hw/acpi/cxl.c              |   4 +-
> >  hw/arm/smmu-common.c       |  17 +-
> >  hw/arm/virt-acpi-build.c   |   5 +
> >  hw/arm/virt.c              |   7 +
> >  hw/cxl/cxl-host-stubs.c    |   2 +
> >  hw/cxl/cxl-host.c          |   8 +
> >  hw/i386/acpi-build.c       |   2 +-
> >  hw/pci-host/gpex-acpi.c    |  43 +++-
> >  hw/vfio/listener.c         |  14 ++
> >  hw/vfio/pci.c              | 411
> +++++++++++++++++++++++++++++++++++++
> >  hw/vfio/pci.h              |  15 ++
> >  hw/vfio/region.c           |  15 +-
> >  hw/vfio/trace-events       |   6 +
> >  hw/vfio/vfio-region.h      |   3 +
> >  include/hw/acpi/cxl.h      |   2 +-
> >  include/hw/arm/virt.h      |   2 +
> >  include/hw/cxl/cxl_host.h  |  10 +
> >  include/hw/pci-host/gpex.h |   2 +
> >  linux-headers/linux/vfio.h |  18 ++
> >  20 files changed, 570 insertions(+), 18 deletions(-)
> >
> > --
> > 2.25.1
> >
> >

