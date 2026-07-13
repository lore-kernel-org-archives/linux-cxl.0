Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012037.outbound.protection.outlook.com [40.93.195.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF5134D4FE;
	Mon, 13 Jul 2026 17:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783964439; cv=fail; b=jqu6dbuDCUsQZbQYS11Yqt0GD1EdohxxdoOTVHFSt7Bb03/lDKXLA+Qu0OUNYyTQjJcolY3lzhtX4uuvYBMHlciby0NSWtUxKZcYwgTBPVtS/Rb+jpb7b8bW31ilOcEotvjW9Nfhku6RSidohHETs3zk0xr2O3hPB/+WRtfDL7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783964439; c=relaxed/simple;
	bh=K4hThv6lnbTUWCF6clTHQQXceHRbFrYyIOJH8mz9GC8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t8zyKZLnBQu3p9y5iZYdKiRpkblLhVba/OD9VGN8ystJm4NsQna9mlsDoUAy/t0ApnhfBCbf1lUU4rKiJz8Y84BJAP0eOYicyF26uKgeXCONtaBUdEERYxJ466dhGa4q1XmxRXXOBio+fVpFz1TFfvCv+i5p8uKBEFOUjwJn/Rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S2/FTYnb; arc=fail smtp.client-ip=40.93.195.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S2/FTYnb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J2+EX3PbSFgEJjN5xBGn9juVeZBN4hYJOtXIQtBS8FKRZ2EHIvo1TiyhQakwSYjDOSnfp7a7/vUI7PmPY0HbhwbCF58DeeQhd7Eof/H+T720tBlSAfFjNsVpR/VEWhvwxqU5Al/pKpqIy1SEFWNOY8BSBzimyOEwiMT3LBDDotqXblp7uDyAOLmxsa2DB1qTqfdIF9LDq2AjaOksVYU/Mo6PAH1Sjl0E2z1iqdCRpps1XUpzPe7WwSV8DLsMuDtBpQW57ID6A3mJf/krr0XybyqL2TBSiGX85ocTs5SYsbHEUsyKgsq7b7xKvlLZCHPSsOSevZ8vnMYyHRAvcM2Z9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cq8RP8jngoGDxJ542K0U/HE7eWn/mffYzdyUDBEd03Y=;
 b=uSUJIceXo/RkcSBxjxrIT9rq6XUsxC26sAvRRvCyZXSRKXTvTjeW6kXQf8xWXeE6y2mH/klwWB1LD4feER1EHrnGxwbsICIQ5BR3+tP+fQaqMGF1WyiCKcyIGfCzecZjZA1qIpUtiWd8O/EhNQSqcujtSX50H+JGS9tSiVUJ/Efb56Ns7QwS06cBhRTu+9qAPPYFvo/DvXn6EpVFJgYgEydBd3eqmSKb8Ubpm9pve8u4b3/I16wzQMmpGmxAEyXZLGiCASHo6/pZ0WWHDAmST+TUTmPefwQ2yhgJD1hxdq22R9pkvodgJho0t1YRn7B5iNsFQEzbXjC6kwgqLZxFXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cq8RP8jngoGDxJ542K0U/HE7eWn/mffYzdyUDBEd03Y=;
 b=S2/FTYnbLPHsyvfLUMkgMbzLrtqKgFF9fmTj/DDwkqVsmGHjHeBef3kNZt5RWmP+oH7xSIuHxfMkD93L2adHar1sNmfm9Y2TGxOG1yUbp4rXtQmQK2GkIpc+jTAZagK1u0T5dbThbqra6pPZRDC53zeWp5Sfm7ZiH+it338pCoaCsalBHXGpSNvwPOnYSlmBPdeOQ9ulod6rjmgd9UVBQ1xfl8RTbdult+19UPPOQmvh7JGmb+GDAJSGEWBQoFqSt5BkU1671n06CKxG4AFFtCGUxB6dmp7yTZ2fjD3H9fF9+CN6l5EbtPhCBQE8y1eCBEFlwR8QXki+3K4FDAQ9Mg==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by SA1PR12MB8119.namprd12.prod.outlook.com (2603:10b6:806:337::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 17:40:29 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 17:40:29 +0000
From: Manish Honap <mhonap@nvidia.com>
To: Alex Williamson <alex@shazbot.org>
CC: "djbw@kernel.org" <djbw@kernel.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"jic23@kernel.org" <jic23@kernel.org>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, Ankit Agrawal <ankita@nvidia.com>,
	"alejandro.lucero-palau@amd.com" <alejandro.lucero-palau@amd.com>,
	"alison.schofield@intel.com" <alison.schofield@intel.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "dmatlack@google.com"
	<dmatlack@google.com>, "gourry@gourry.net" <gourry@gourry.net>,
	"ira.weiny@intel.com" <ira.weiny@intel.com>, Neo Jia <cjia@nvidia.com>,
	Krishnakant Jaju <kjaju@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, Zhi
 Wang <zhiw@nvidia.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, Manish
 Honap <mhonap@nvidia.com>
Subject: RE: [PATCH v3 05/11] vfio: UAPI for CXL Type-2 device passthrough
Thread-Topic: [PATCH v3 05/11] vfio: UAPI for CXL Type-2 device passthrough
Thread-Index: AQHdBMN4xuDJHQfm/UCI06mb/0iNl7Zna+gAgARCZHCAACGZkA==
Date: Mon, 13 Jul 2026 17:40:29 +0000
Message-ID:
 <IA1PR12MB90301288F11754F9EE9A992CBDFA2@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260625165407.1769572-1-mhonap@nvidia.com>
	<20260625165407.1769572-6-mhonap@nvidia.com>
 <20260710162322.012be635@shazbot.org>
 <IA1PR12MB9030E175587B09CEA7A4D90FBDFA2@IA1PR12MB9030.namprd12.prod.outlook.com>
In-Reply-To:
 <IA1PR12MB9030E175587B09CEA7A4D90FBDFA2@IA1PR12MB9030.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|SA1PR12MB8119:EE_
x-ms-office365-filtering-correlation-id: 1620f6ed-52b2-48c2-be5c-08dee105d48e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|23010399003|376014|366016|1800799024|22082099003|18002099003|6133799003|56012099006|4143699003|11063799006|38070700021;
x-microsoft-antispam-message-info:
 WcRcjlBHaCwKMvUlTlJ6FPJZA62THOxNT1NNDmBMSbCfskcWazhYj+qLN+zUvZlhkAi1F8M7lZzPXJXzWPOn8bWxOQO8vKJroa8x5J3Awaxa2twsiGCz4mmEkQ6nYP5t6S1iw0ih3aXgP7gtFXaUS7KWgMkmRVGVF+3J65JyXLNyxCUR5Y6axHhTpduUTDSHv4Sk8fjyotQSWQWR0hM7R+kzvKuNxVcA5rtZYGEIRRyOjB4s59pDBI+sscSWmcm2WpCsP41mIAx00X8vlUeeV8DD3pgDFvmiORj3qPdr+psjYV9dw/2sezAHMf8eDBa/Gdgn2xUvh9NaPBeaxTBOdA5T1+G+KSkgX3XoRMiDWOdWwMUVQ/uSJ8Q0ENOaaHfIAGBIlW8+Xhg6lMxgaePrEFIcaPyET07CsoJ7PAhrzWJesut/H2P2ck4cllStvi5ShLP5TdwRNivNfrn7E8QB3t/IvBdYVWiFUNWI4w8tAEQ/yBh6Q92KV6j3RphNAM+ZDYiNv4eSdWIvQtXCRM90Zp8ntuwAt6MyZpkemuFgoGHn7nZeM1hx58MucT2D8UxAWwyPlFvcnoUBM+HOP3QxHgCLp73UcpB7xphyakAEJQNlIPtPuQ4tzMhkqouoRBs91y53USS+g4iYDeJiAB3V7M0ejgDrbsVouBpodw+0Ncm0C/vQ3Z1vy8U7gnxPMhFiRCoKW5rihxvj9hopilxu4XPU+zfBsh7Cqtukkbc2IZY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(6133799003)(56012099006)(4143699003)(11063799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2w93eFZu+lBq9zAymnX9AxUt+cSa94vXB1vMMBZ6X3Q9Z7FAz18FiKa1tyv5?=
 =?us-ascii?Q?vlH0msHQ303LxfNnEX5dpMIiu3/un1PuJE67fSqLHMiVuWQ+OfevLPLHsLMZ?=
 =?us-ascii?Q?ll/R7WkRax8FHzhpNdP+gFWBNNqSgqr+5vBjKRJjgA2YL0Qb5lQb2mrKi/5L?=
 =?us-ascii?Q?5IaTBej11xHEicTVAYk0UKPMcdyl6le5b2aNCw26tm7QZPwuPUoEUiikNjRJ?=
 =?us-ascii?Q?vpkD7WO1GC8mXnfYUdjrWEd+X79qDkKWaw3AAvUv8TDymhD3JBAPynsdUZfz?=
 =?us-ascii?Q?AWj1VHz+E54959xA2X1U+BIqHVwL7a3rBIilThOsqD4kGx0+wlEWQoWXQZgi?=
 =?us-ascii?Q?qRPEfyp2NK8ITVgD1m97ZL5wIv08dmIW2uK3NFUGvOxMfTUETWoYmuQd+UJv?=
 =?us-ascii?Q?prpvzjdskIcys/BJ8ozXFgs0ARH2HPlk9wpAvpWrcP9d1uVPNBfrMxbJ4rlK?=
 =?us-ascii?Q?JeDZAhDV693mDlX51DM19P7VB/uIpnWi1PLTiiqxXfUlddhb7+MqpK6ccZwA?=
 =?us-ascii?Q?b2vCvcneufP+M7DvcSi5zUoNJ3WPds+ZMoEA5KlAw7PDFKXvLnrFH4FZ6jUk?=
 =?us-ascii?Q?XutF2wqkiqLXLno/CWf87SF2NDczhOPCheAvTVYFbVi9XOYSDRxqIynk0n0O?=
 =?us-ascii?Q?YzKZln4P/qZMUq8AcvS5P34FbyMNOt3dasP7hGJ0BYUT7j6a0Ugya6+YsCy0?=
 =?us-ascii?Q?8qwzDPpxT8mdhOIrkzLEov+51uvBtkBQqKa+fJUtChzzyDfgtXwLWPUBIdKs?=
 =?us-ascii?Q?4B/hWUcFXMZfdFxt9oMZsykpA3xHpx5BX/O1REONiCLj6vttzHHrgTii43YG?=
 =?us-ascii?Q?CMvCCvd94bygSHa1gyjIJKcniP0uZL7ICxRZBeiDuZOWnJiPSsZmm8uDp17K?=
 =?us-ascii?Q?Eu5Ryey518hceqKLswjsUukdOK6HRGJkA6odPQMv7LLc7yQjsld3dCc18l2A?=
 =?us-ascii?Q?Q297s5wCFKXFOa5YnKCgaCKq7ftWPcNPl6/eQbCY6bjYvUmOjAw3dnq2KuqR?=
 =?us-ascii?Q?go3jM2btsiyyJ1pwBiGvQETLNsUjaftNj2cPPQp+FkCX1UaH9xyG9lmk3oSZ?=
 =?us-ascii?Q?9YHexSB2ac4A/5PRlacVMXaqcV46IGwTrrSyivgAOdh2tJrOE+EP83HPpHgT?=
 =?us-ascii?Q?xMPHIX8FSnQhLX5Lqh8a2XkteMRUnv01rUa0eo1I3hArNTeouo0YZbnGqjgh?=
 =?us-ascii?Q?2bNiJdbFLqcytkbOvRpP1ET0sulpV+gwM6g2riQ+oNxEChFAVvX3sbxS94nI?=
 =?us-ascii?Q?SaUug0B/SCJICZm+3wivyvTOVpSo5sXmWyUf0n40RwmQLNG7hKvwSePizUn9?=
 =?us-ascii?Q?S8tyHJJ2x/4K50uR8MptxYEdBMhk7qH6kcNRrwDAoL9uXJXD23YyyIOuZ/9F?=
 =?us-ascii?Q?4LWAlHTxeoYw+QuuNhJeeOAQFc/DSa0pCPWbQwlPVKdWpBE0VWIkd7B2ZlDM?=
 =?us-ascii?Q?UTm6KYbtlrnEwpO1X/BuBrC0bkxaHIkibYKaFoTBoC/ABS0c8dGMard65VJM?=
 =?us-ascii?Q?tc2UAy8EJPNiQBHZws+2K+D2QxUdaLh2nscze2PgUBNPqUiq4L4TD3tzLESF?=
 =?us-ascii?Q?TDKWDP71Ji/zPSWDMAumEOUwSyuO3t2bIBld57vFmK337fbl4VKSfLWUWeCU?=
 =?us-ascii?Q?1giuRKHulMEvLt+7fki4d+ccCqdh0Lru7vEUfsYOuWfKnNt7miP2nxNb1RoC?=
 =?us-ascii?Q?chJWai/bqMxnFc1jXXYDuz0q4gss9reui6WWDiNarnZEnWIA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1620f6ed-52b2-48c2-be5c-08dee105d48e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 17:40:29.0299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zc5xJQ9w3t4J9XImIzjsBmmR78zfHiSacr5sAogabTeLk+qlq06mm1P9VPaSfagZGbYg1NH/juHqLB5prxkN3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8119



> -----Original Message-----
> From: Manish Honap <mhonap@nvidia.com>
> Sent: 13 July 2026 22:15
> To: Alex Williamson <alex@shazbot.org>
> Cc: djbw@kernel.org; jgg@ziepe.ca; jic23@kernel.org;
> dave.jiang@intel.com; Ankit Agrawal <ankita@nvidia.com>;
> alejandro.lucero-palau@amd.com; alison.schofield@intel.com;
> dave@stgolabs.net; dmatlack@google.com; gourry@gourry.net;
> ira.weiny@intel.com; Neo Jia <cjia@nvidia.com>; Krishnakant Jaju
> <kjaju@nvidia.com>; Vikram Sethi <vsethi@nvidia.com>; Zhi Wang
> <zhiw@nvidia.com>; kvm@vger.kernel.org; linux-cxl@vger.kernel.org;
> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> kselftest@vger.kernel.org; Manish Honap <mhonap@nvidia.com>
> Subject: RE: [PATCH v3 05/11] vfio: UAPI for CXL Type-2 device
> passthrough
>=20
>=20
>=20
> > -----Original Message-----
> > From: Alex Williamson <alex@shazbot.org>
> > Sent: 11 July 2026 03:53
> > To: Manish Honap <mhonap@nvidia.com>
> > Cc: djbw@kernel.org; jgg@ziepe.ca; jic23@kernel.org;
> > dave.jiang@intel.com; Ankit Agrawal <ankita@nvidia.com>;
> > alejandro.lucero-palau@amd.com; alison.schofield@intel.com;
> > dave@stgolabs.net; dmatlack@google.com; gourry@gourry.net;
> > ira.weiny@intel.com; Neo Jia <cjia@nvidia.com>; Krishnakant Jaju
> > <kjaju@nvidia.com>; Vikram Sethi <vsethi@nvidia.com>; Zhi Wang
> > <zhiw@nvidia.com>; kvm@vger.kernel.org; linux-cxl@vger.kernel.org;
> > linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> > kselftest@vger.kernel.org; alex@shazbot.org
> > Subject: Re: [PATCH v3 05/11] vfio: UAPI for CXL Type-2 device
> > passthrough
> >
> > External email: Use caution opening links or attachments
> >
> >
> > On Thu, 25 Jun 2026 22:24:01 +0530
> > <mhonap@nvidia.com> wrote:
> > > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > > index 5de618a3a5ee..3707d53c4de5 100644
> > > --- a/include/uapi/linux/vfio.h
> > > +++ b/include/uapi/linux/vfio.h
> > > @@ -215,6 +215,7 @@ struct vfio_device_info {
> > >  #define VFIO_DEVICE_FLAGS_FSL_MC (1 << 6)    /* vfio-fsl-mc device
> */
> > >  #define VFIO_DEVICE_FLAGS_CAPS       (1 << 7)        /* Info
> supports
> > caps */
> > >  #define VFIO_DEVICE_FLAGS_CDX        (1 << 8)        /* vfio-cdx
> > device */
> > > +#define VFIO_DEVICE_FLAGS_CXL        (1 << 9)        /* vfio-cxl
> > Type-2 device */
> >
> > Would we define a different flag for type-1/3 if we ever found a need
> > to expose them through vfio?
>=20
> Yes. The current flag is named VFIO_DEVICE_FLAGS_CXL and refers to
> Type-2 specifically. If Type-1 or Type-3 support is added later, a
> separate flag (or a VFIO_DEVICE_INFO_CAP sub-type field) would
> distinguish them. I can rename it VFIO_DEVICE_FLAGS_CXL_TYPE2 now if
> that is preferable; please advise.

For this patchseries, I think keeping name as VFIO_DEVICE_FLAGS_CXL_TYPE2
is a better choice since Type-2 is the only supported case now; a separate
flag can be added when Type-1/3 support arrives.

>=20
> >
> > >       __u32   num_regions;    /* Max region index + 1 */
> > >       __u32   num_irqs;       /* Max IRQ index + 1 */
> > >       __u32   cap_offset;     /* Offset within info struct of first
> > cap */
> > > @@ -257,6 +258,36 @@ struct vfio_device_info_cap_pci_atomic_comp {
> > >       __u32 reserved;
> > >  };
> > >
> > > +/*
> > > + * VFIO_DEVICE_INFO capability for CXL Type-2 passthrough devices.
> > > + * Present when VFIO_DEVICE_FLAGS_CXL is set on
> > vfio_device_info::flags.
> > > + *
> > > + * @flags: VFIO_CXL_CAP_HOST_FIRMWARE_COMMITTED indicates the host
> > CXL
> > > + *   subsystem committed the endpoint HDM decoder.
> > > + * @hdm_region_idx: VFIO region index for the HDM memory region
> > > + *   (subtype VFIO_REGION_SUBTYPE_CXL).
> > > + * @comp_reg_region_idx: VFIO region index for the CXL Component
> > > + *   Register shadow (subtype VFIO_REGION_SUBTYPE_CXL_COMP_REGS).
> >
> > These regions are self describing via the noted CXL subtypes, what's
> > the purpose of double reporting them here?
>=20
> Agreed; I will try to minimize the noise here.
>=20
> >
> > > + * @comp_reg_bar: PCI BAR index that contains the CXL component
> > > + *   register block.  Get-region-info on this BAR returns a
> > > + *   VFIO_REGION_INFO_CAP_SPARSE_MMAP that excludes the CXL block.
> > > + * @comp_reg_offset: byte offset of the CXL component register
> block
> > > + *   within @comp_reg_bar.
> > > + * @comp_reg_size: byte size of the CXL component register block.
> >
> > Why don't we describe all of these via a capability on the relevant
> > region info?
>=20
> okay, I will have v4 to remove hdm_region_idx, comp_reg_region_idx,
> comp_reg_bar, comp_reg_offset, and comp_reg_size from
> vfio_device_info_cap_cxl. The device-level cap will only have flags.
>=20
> This will also result in component register details to move to a new
> VFIO_REGION_INFO_CAP_CXL_COMP_REGS capability on the comp-reg region
> info, carrying comp_reg_bar, comp_reg_offset, and comp_reg_size.
>=20
> Regions will remain self-describing via VFIO_REGION_SUBTYPE_CXL and
> VFIO_REGION_SUBTYPE_CXL_COMP_REGS.
>=20
> >
> > Does that leave this device level capability describing the device as
> > type-2 (by existence), with only a flags field to declare HDM as
> > firmware committed, for future compatibility should we support non-fw
> > committed?  Thanks,
> >
> > Alex
>=20
> Yes, I will shape the v4 in this direction. The device-level CAP_CXL
> shrinks to "this is a CXL device" (by existence) plus a flags field
> whose only defined bit today is HOST_FIRMWARE_COMMITTED, leaving room
> for a future non-fw-committed mode. Everything else moves to region
> caps. Thanks for this suggestion.

