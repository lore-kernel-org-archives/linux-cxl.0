Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012000.outbound.protection.outlook.com [40.107.209.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4943A43803C;
	Mon, 13 Jul 2026 16:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783961331; cv=fail; b=b/xccmounOZU1jQz+k5qlYKh//E9QEnD9/3u4Omvi/0VFIBBTRqRXaRr2WPcdo3iQBCNdJLavI8IWWDAKnKzIMeFNpjmX/loKBjNO+TI6SkWo736K/pAcbccMAELPVHlupOZV//uOJnR2xCaV/nh1N/59NuH12FLZ6rqrMfDBFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783961331; c=relaxed/simple;
	bh=sEfd9bBPPmwC/nmYZgu4vu1sgZaUGJNWwjMGH1xFkRo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QIvN+NL8AOp4A1qO5GcoSZ9qMHKYYcqKNTOb6d5AQUhBP1WctbJIV27c1FphR/vxJA+aB7CpZO4p9ZNyeaUefDBi4NsNboIHYiM/QIY22m6GZXV734wUZTfeO7hRZbM14GIMaPlJbhm0UmBA3gOXNQsr8tImaOsR3U8DuRDMIlY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JNrRKDlx; arc=fail smtp.client-ip=40.107.209.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JNrRKDlx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OIq7d4n4agAPWEh6vwzjqJMhqp7NyQobryDaDAd4pRT82UCwkGC61Wa6u1lASkpdlvO5uEYEglUFUg4xiLbUtSsORER45hIqu18M36vu3BvycMRMTmvoiK73jsutMa5/BUcpEKDW3OjyAEAArF1LYMGYgXkR2P6cAHzpuqUpSLkS7H2N3l6NzbdityRczBBPtzB9oCIzXCN/UXgFKYwgicU+Ivs+EVGyD6CmgGNeRiyE+Ww09ANfxB3ZinISDOdJv48QKDkr6vD4yXDJ9H0HddiV70/To9Sg3HZcz0vlpKIiR0qsR++X8W6lJpxNcwLzX1raF1tS/35G2h0eiB3CPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d1vwJEOD6J0MZu71dwr+e2IsFahAfPlubwaJKf5ML40=;
 b=o9+dfBOsJWqSLMxiwEK4QoYefzG+exyaTZ6NpXu9lV8Rv6HVsa1RA+zKuFY+F2C5I/IC+H+DBcqnjCPatnmSu5MU+AYSMuSmKeevmS5X1kfYLstABy42RXnynOraW/EGVV7YO94C1+rMfsSFFwLg3+FaoeD7PcEBhcQ/Zkhzt6u+ajOYpelAmptIhHjhq0y7fejv2oXikRgX8nk1FDvEMc6WEN6ehprjgvUwtqzF9Asp/d4bdXblp9fr+qnElsQdI3HeCimuxbn8k8q5lEgFxbEfGjBut6LLqjqtiMZKj4Fatl+mlqAUV8RQ6kDGP2PcXK853hB4+xlSc63eJKPcyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d1vwJEOD6J0MZu71dwr+e2IsFahAfPlubwaJKf5ML40=;
 b=JNrRKDlxMpU+meu6FgisPPh9zZFVpyq53l+1LrzVCcZUqcTjaC6nfb73mWt7MgiFlwHBaRoEv+PRZXPF43OTDWHqZfjRM3Tqvjz+kQa1ubDZ+a1QbWRf+IIqk+YLs7QdLOc5j/2yC5o2TfxwV5eQdaMflJRkIPYC5JepTV5UB+i3R0TOdxePRUstKc1B+POQBXsR5wRqOOPGvJ2Aj5ulaf9Hz4175BS7h7OG/a1m1JFgqfeTnX1+mmL5KUKMpcfb1WRQw0X+280L6phV+r5LNlBoZONt+O+8nKTVej1WYNn3f/kfJbVHT7X+2kSAvlPVN1spD0RfODDZlCLzQ0tZfw==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by BY5PR12MB4324.namprd12.prod.outlook.com (2603:10b6:a03:209::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Mon, 13 Jul
 2026 16:48:46 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 16:48:45 +0000
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
Subject: RE: [PATCH v3 08/11] vfio/pci/cxl: Add HDM + COMP_REGS regions and
 DVSEC clipping shim
Thread-Topic: [PATCH v3 08/11] vfio/pci/cxl: Add HDM + COMP_REGS regions and
 DVSEC clipping shim
Thread-Index: AQHdBMOJDTKf/GwLEkq+lH+aIoSuU7Zna9iAgARXOPA=
Date: Mon, 13 Jul 2026 16:48:45 +0000
Message-ID:
 <IA1PR12MB90302564411A6FAE9FB5A97EBDFA2@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260625165407.1769572-1-mhonap@nvidia.com>
	<20260625165407.1769572-9-mhonap@nvidia.com>
 <20260710162309.2c257883@shazbot.org>
In-Reply-To: <20260710162309.2c257883@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|BY5PR12MB4324:EE_
x-ms-office365-filtering-correlation-id: abddd927-cd4e-4822-b841-08dee0fe9aee
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|38070700021|6133799003|56012099006|4143699003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 wuaUpD+odHOfNUMQSvFG2qeUe8U69ZRF/Y1pRPrGogcS8IKgK1oBqf2MOqLcMyvNdPyUkCIsQ5aAih5c0EeniMQbcDsYY947InGmXaETFW6TSbb0aBs96wG9skLFXSULDDR3/jrcZQAq6KNbo/4ElRhtx10jI+Mr7xRSgSuUaeMJwgO8rpoucxAionH5d/SbGju/QBPX7PqEQpVF4Tai/rThzcvD4FGw8jX8VErzXjHP2mvbWZUtDIeUYHxlmlI2VzvSNBR3sxLpWG/HjZaWJCaj16RoaLKVJng61dgIuMJdKXZiBi3or4PZsO7ggfHJTE0oapYwTx8oRv4z1J7SbOrQUjslayS60yj2lpZgBnTKeZW1Lv+CE0vz0tVyLrc8QXIlZMeXlMpzUnhucD9vmvaR/UAbyB4107f20JmL4ztkTY+jzEens0kFyTeEQOVSAOlUVwt7q+wPtRHWjOapnHUOiIq5SIy2iD/GhaIpTa3tFQ3vQ088RE3EYdqW1yxkpOeqmQ0XfSxfLcR6ZBEgX0B/+DJntN3qxdXv/j+JUfq+3HdhlpIQXdBQVfX/7FyP5Ol87Z0aylYpFoG+t4aeBehG9G7+hocX+sqYQLcX4ad/MsGxNQphFdyYkV2tQtNqgfu8JOzHjVCEErt7U7gl98lojJYnyB31B/3ftrHK0wIjcYNcIMpQonQwm0lZxVZc47CAztzwbQ+qmPC7N+dC7xEN98CiL/u3SLz3nr1pQxo=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(38070700021)(6133799003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1y9vN6vecp2fdfMFY+u6M1KAXJXv9lHacQlirofari5J3pqA3PbYGBUvetGI?=
 =?us-ascii?Q?jjp6I/yX+GZ6SP+yVds/dBCQfX2f8B+6Knq++1/s7RBAKDN2VXtEvHhlmP9a?=
 =?us-ascii?Q?5DmXm1iNHAm4+9S+szc2KVt1BsBfJYs0+uGZ7I1Jp3WKoSjaSiRfKdtGhBK0?=
 =?us-ascii?Q?Id/KNK6XSSQJ1CeZOsam1m4bXe3PLzfw7TxTyPA7Hi4IBxbq+dswWnexg6M6?=
 =?us-ascii?Q?/p3910UTqgs8G+Dj3oeuFQ4azecSzctQm26QzdaoTm5KnX0NelfVu9BmKxG5?=
 =?us-ascii?Q?i9KuQ0lJ3SjRHJ81Jn727eWy7X4A66z58hPgXe/2tjZZlYAEc4/st4oP4dXO?=
 =?us-ascii?Q?d7BImaWb1Rxe82F0+TTBel8kp3WWDPMbLVWORi9haioDJHmPuzao41nPf0iB?=
 =?us-ascii?Q?VPWqfrDRDuoyYKZ60lVy1U6HxzWVbjc45ful3hXOuiBXI3pz05sFfvwRiGgA?=
 =?us-ascii?Q?lJMphzpfAlV0w5kndraX/0PkxJ1zlAuJkgayshF0mWQyOFQA/tyO9dLH/v5A?=
 =?us-ascii?Q?dm3aY6iPvLoHlqB6jaKlXV+4nBo6zQwsvCJhULrJm/Fc4SQHWBFsr280TXiL?=
 =?us-ascii?Q?vJPApCpIVvQLILQTDjPxS/Sgm4l7EnHocBVJfmBFVrbgBGBjyanhLlfZv4s9?=
 =?us-ascii?Q?unZcuIkhduyBQLNngVimJm1mxle/m01RyXQz1tzncJBgEbWx8MszZv1Di9A9?=
 =?us-ascii?Q?vtGNF3rBZjVdRdQLxq27FoJdZsStQRD6hKcR0WWw/u7JWXDKrqr6qcwW/2si?=
 =?us-ascii?Q?Bif6uCUyYAOmYtmjezFVhxbppo8vspXEjK0nM4M6kOzu59GvOvyTtaxYPqvn?=
 =?us-ascii?Q?6cZLr7EoBX+T1qrVuK5QHiKibhqya3vOWOqWZKIgS0eapmzi1YHZ2j5vdi1x?=
 =?us-ascii?Q?Oaut1CG4b6qEzpyF+REM6BSoI7cTS7Ja6oNCjOSqUKdUsgOk6N7Dpdg0DfK4?=
 =?us-ascii?Q?U1nLcaOy3ijLGfZVF2lukwD0OpiFTTeDiqiHJHiN1HuLWKrAJL5pcv3BmgDF?=
 =?us-ascii?Q?fWEEaIRrcbKVJJCqPjDv4EhuGVAKbs0fHZ+cmE1qw8tTdyy/+dIujCurcohy?=
 =?us-ascii?Q?8X68NlxH6zsHSEwIswadx4dGjy0nqjCm16HtPhzQuUYiJMGAS1uYMHTTAXy/?=
 =?us-ascii?Q?tkzXKGBxvGUgGtumkIBTby+CbFxWZgSu8TN9DFE9HuZxsfws3EQ+YshpdpGr?=
 =?us-ascii?Q?rBWnyEBgUYOqbXGrGBF2LRITF+w7XIFZcGyC+/ObryNgiWtid37gV/YJXSw3?=
 =?us-ascii?Q?KK8xOTBDhj78+7xiJsqN2DJnWHlicTVyXlqOIn9x7EiiwLHPhoxXDVUKKJl6?=
 =?us-ascii?Q?rfHH2xRmpu0tkm4e9VkaXM5QyZDoJaC9+mYjihUl40XUiavf+IYT7yMbiT5y?=
 =?us-ascii?Q?NVFVBE2XIfrhmlUU52bu20qcaGjTw0QItQycy7la/72SQM/AHSi7h84Zy7Cq?=
 =?us-ascii?Q?/r7e7UtOOu+agNjiuxtA/RKhSst0gfXseGxd/vwYKgplQnQj5dUraZztaefa?=
 =?us-ascii?Q?eAxpJiDynsv4Kvt3xAz6C8drDyz6gnfzSGZ1bsnYomtiPtsyhvDtNK5RchD2?=
 =?us-ascii?Q?pjuANdObStE6jOrmAirhLh9ZccKgunGej69/tfFdDV1Nxo3aIQSzWc1TvJF7?=
 =?us-ascii?Q?jvkxa4F2ZH2BUHX4BW8oYjrGENJcYf43/7H8lFyTB2SGUP57qltqqF5cE0tQ?=
 =?us-ascii?Q?fNafIaNnFrj6lZfAn2xZin5nVtBPq/FUvhOsFbbK0pzbUWCE?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: abddd927-cd4e-4822-b841-08dee0fe9aee
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 16:48:45.8733
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5kCprlMnKda55TneOD8x07vF71cE3ifAFbqogFU1rkESGwm/lxltUsCdimLn1D7B9iyIC6L+9YxfxVeXHlKF1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4324



> -----Original Message-----
> From: Alex Williamson <alex@shazbot.org>
> Sent: 11 July 2026 03:53
> To: Manish Honap <mhonap@nvidia.com>
> Cc: djbw@kernel.org; jgg@ziepe.ca; jic23@kernel.org;
> dave.jiang@intel.com; Ankit Agrawal <ankita@nvidia.com>;
> alejandro.lucero-palau@amd.com; alison.schofield@intel.com;
> dave@stgolabs.net; dmatlack@google.com; gourry@gourry.net;
> ira.weiny@intel.com; Neo Jia <cjia@nvidia.com>; Krishnakant Jaju
> <kjaju@nvidia.com>; Vikram Sethi <vsethi@nvidia.com>; Zhi Wang
> <zhiw@nvidia.com>; kvm@vger.kernel.org; linux-cxl@vger.kernel.org;
> linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> kselftest@vger.kernel.org; alex@shazbot.org
> Subject: Re: [PATCH v3 08/11] vfio/pci/cxl: Add HDM + COMP_REGS regions
> and DVSEC clipping shim
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Thu, 25 Jun 2026 22:24:04 +0530
> <mhonap@nvidia.com> wrote:
> > diff --git a/drivers/vfio/pci/vfio_pci_config.c
> > b/drivers/vfio/pci/vfio_pci_config.c
> > index a10ed733f0e3..b9f30a33515a 100644
> > --- a/drivers/vfio/pci/vfio_pci_config.c
> > +++ b/drivers/vfio/pci/vfio_pci_config.c
> > @@ -1898,8 +1898,15 @@ ssize_t vfio_pci_config_rw_single(struct
> vfio_pci_core_device *vdev,
> >       /*
> >        * Chop accesses into aligned chunks containing no more than a
> >        * single capability.  Caller increments to the next chunk.
> > +      *
> > +      * For CXL Type-2 devices also clip at the CXL Device DVSEC body
> > +      * boundary so the generic perm-bits path handles the DVSEC
> > +      * header bytes and the CXL hook handles the body bytes; without
> > +      * this clip a 32-bit access at dvsec + 0x08 would span the
> > +      * generic Header2 word and the CXL CAPABILITY word.
> >        */
> >       count =3D min(count, vfio_pci_cap_remaining_dword(vdev, *ppos));
> > +     count =3D min(count, vfio_pci_cxl_config_boundary(vdev, *ppos));
> >       if (count >=3D 4 && !(*ppos % 4))
> >               count =3D 4;
> >       else if (count >=3D 2 && !(*ppos % 2)) @@ -1909,6 +1916,30 @@
> > ssize_t vfio_pci_config_rw_single(struct vfio_pci_core_device *vdev,
> >
> >       ret =3D count;
> >
> > +     /*
> > +      * Give the CXL Type-2 hook first claim on this access: if the
> > +      * range lies inside the CXL Device DVSEC body, forward it to
> > +      * cxl-core's register-virtualization helpers instead of the
> > +      * standard perm-bits path.  -ENOENT means "not for me; use the
> > +      * default path"; any other negative value is a hard error.
> > +      */
> > +     if (vdev->cxl) {
> > +             __le32 le_val =3D 0;
> > +             ssize_t cxl_ret;
> > +
> > +             if (iswrite && copy_from_user(&le_val, buf, count))
> > +                     return -EFAULT;
> > +             cxl_ret =3D vfio_pci_cxl_config_rw(vdev, *ppos, count,
> &le_val,
> > +                                              iswrite);
> > +             if (cxl_ret >=3D 0) {
> > +                     if (!iswrite && copy_to_user(buf, &le_val,
> count))
> > +                             return -EFAULT;
> > +                     return cxl_ret;
> > +             }
> > +             if (cxl_ret !=3D -ENOENT)
> > +                     return cxl_ret;
> > +     }
> > +
>=20
> I think the solution here is just to set the .readfn and .writefn for
> PCI_EXT_CAP_ID_DVSEC to dvsec specific handlers, rather than the raw
> write and direct read handlers.  The new handlers would detect whether
> the reference is to the CXL DVSEC body, possibly via ranges stored in
> vdev->cxl, and either call through to CXL handlers via cxl_ops
> (previously suggested), or fall through to the raw/direct handlers.

okay, I will have handling for this in v4.

>=20
> >       cap_id =3D vdev->pci_config_map[*ppos];
> >
> >       if (cap_id =3D=3D PCI_CAP_ID_INVALID) { diff --git
> > a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
> > index 05ab4ae59157..2d2dae278d1e 100644
> > --- a/drivers/vfio/pci/vfio_pci_core.c
> > +++ b/drivers/vfio/pci/vfio_pci_core.c
> > @@ -501,6 +501,23 @@ static void vfio_pci_core_map_bars(struct
> vfio_pci_core_device *vdev)
> >               if (!pci_resource_len(pdev, i))
> >                       continue;
> >
> > +             /*
> > +              * cxl-core already holds request_mem_region() on the
> CXL
> > +              * component register sub-range of this BAR.  Skip the
> > +              * full-BAR request so we do not collide with that
> > +              * sub-region; vfio still owns the BAR via the driver
> > +              * binding and the iomap below succeeds without a region
> > +              * claim.
> > +              */
> > +             if (vdev->cxl && bar =3D=3D
> vfio_pci_cxl_get_component_reg_bar(vdev)) {
> > +                     vdev->barmap[bar] =3D pci_iomap(pdev, bar, 0);
> > +                     if (!vdev->barmap[bar]) {
> > +                             pci_dbg(pdev, "Failed to iomap region
> %d\n", bar);
> > +                             vdev->barmap[bar] =3D IOMEM_ERR_PTR(-
> ENOMEM);
> > +                     }
> > +                     continue;
> > +             }
> > +
> >               if (pci_request_selected_regions(pdev, 1 << bar,
> "vfio")) {
> >                       pci_dbg(pdev, "Failed to reserve region %d\n",
> bar);
> >                       vdev->barmap[bar] =3D IOMEM_ERR_PTR(-EBUSY); @@
> > -701,7 +718,10 @@ void vfio_pci_core_disable(struct
> vfio_pci_core_device *vdev)
> >               if (IS_ERR_OR_NULL(vdev->barmap[bar]))
> >                       continue;
> >               pci_iounmap(pdev, vdev->barmap[bar]);
> > -             pci_release_selected_regions(pdev, 1 << bar);
> > +             /* Mirror the asymmetric setup-time skip in map_bars().
> */
> > +             if (!(vdev->cxl &&
> > +                   i =3D=3D vfio_pci_cxl_get_component_reg_bar(vdev)))
> > +                     pci_release_selected_regions(pdev, 1 << bar);
>=20
> It would be much less ugly to create
> vfio_pci_{request,release}_selected_region() wrappers that mask whether
> the region is actually requested or released than to disrupt the code
> flow like this.  Likewise below, think about creating wrappers that do
> the right thing for cxl and are no-ops otherwise.  For example, embed
> the vdev->cxl test into the function to cleanup the callers.  Thanks,
>=20

Agreed. I will add helper routines for this as suggested.

> Alex
>=20
> >               vdev->barmap[bar] =3D NULL;
> >       }
> >
> > @@ -1051,6 +1071,16 @@ static int vfio_pci_ioctl_get_info(struct
> vfio_pci_core_device *vdev,
> >       info.num_regions =3D VFIO_PCI_NUM_REGIONS + vdev->num_regions;
> >       info.num_irqs =3D VFIO_PCI_NUM_IRQS;
> >
> > +     if (vdev->cxl) {
> > +             ret =3D vfio_pci_cxl_get_info(vdev, &caps);
> > +             if (ret) {
> > +                     pci_warn(vdev->pdev,
> > +                              "Failed to add CXL info capability\n");
> > +                     return ret;
> > +             }
> > +             info.flags |=3D VFIO_DEVICE_FLAGS_CXL;
> > +     }
> > +
> >       ret =3D vfio_pci_info_zdev_add_caps(vdev, &caps);
> >       if (ret && ret !=3D -ENODEV) {
> >               pci_warn(vdev->pdev,
> > @@ -1093,6 +1123,12 @@ int vfio_pci_ioctl_get_region_info(struct
> vfio_device *core_vdev,
> >       struct pci_dev *pdev =3D vdev->pdev;
> >       int i, ret;
> >
> > +     if (vdev->cxl) {
> > +             ret =3D vfio_pci_cxl_get_region_info(vdev, info, caps);
> > +             if (ret !=3D -ENOTTY)
> > +                     return ret;
> > +     }
> > +
> >       switch (info->index) {
> >       case VFIO_PCI_CONFIG_REGION_INDEX:
> >               info->offset =3D VFIO_PCI_INDEX_TO_OFFSET(info->index);
