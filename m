Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012059.outbound.protection.outlook.com [40.93.195.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935A343801E;
	Mon, 13 Jul 2026 16:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783961104; cv=fail; b=OMq9yraw+KbWXQuMVAnGUgYm19JdseKMMp6Y7bdDY3RZYFGrnByjMX4j3UYnAH7n9jvJ4/p0kiSwyMKeZwcnKHGIMIZ9l+3Eh50/67lbjDusH92I1XGmp9wpfJv4rne01vyPbOPfUKz2cnYX+cIpkdevOc4AKBuKKQoxPwSFwp4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783961104; c=relaxed/simple;
	bh=EMcLTRjJDs2yWXSsOa9s39dYHB2PtestJGNF17lSbuc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=k0pq3KuyM85fXXUqOM1n0KOr9Z7M/ERkDG+6hc0toYWv0INbLvgBp2nJQYa6+DixDBQTn8TMnfmptc9DCHiUUbB+CjmkfumynSPGiT2tMK8W6P6OCapFs/sEKSOhbsp8vMWz6CBjKQOUdcEkWJ38sbgCUfcV2TII1xzY36X3gRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NW3EGzDz; arc=fail smtp.client-ip=40.93.195.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NW3EGzDz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pIQHBidRdfjQ/GH8x6hQ5ANcIoyF3CWakphQA0fXhKVx61hEuvEgM7PSjoTZmo4vZjPA7jXyHQOOAEsYmxCZAgqXPw6BOMtXD4PdOhJipZoe7TC4BtnshIu0leoxWy8y3iwHUGpF5IvY2HTjYm7a+wkA3/AYrTR7fwDoTpVudxtP70Bk1a8fuLdLkJDMfMYA9AUSvcKTPP3f/19UwRDP0VHDr6Iwax79xGy0PHdReAagi4vaOvI+GdiX5tZ3NobhYIQeEVIEwA4Z/sts59KrlnxwOVgBxS02+03fXQuuYQlwW15fQ+hLGju/Hqfx1xBNPFM14FBZJG7R2UVSibs3bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vqSi5PL5EwaEJgniJUNhfl/jt8PQSXVMcnczd1sdW+I=;
 b=HTnQeVQEVPTiiQ2wrfSZZ7YZBwWnTehmZ2xKI+xk9ymQiUtnokin1bwQE/uSvJqzUh9e65DQ1DJtwnV/bUQ1W2k5GCuSyLrgZssPN5JZfKYk7IiaKkCLd0XC9t52yrH1VTlf9CuOfvkMKzX9FCgJwphuualR5fXwxf2hNPv5Cke6cfKMUWGRWNbbdKF3+b2AhE9XE+OSqvoFJQfppm1+QMjSf90TfSRbeAjPrvCZIkS9atqzrXQOkGeqomLEZQ7VZW8Js1CiS1RXhdOKViHG4ZfLEScVQJAgrCOQw+jMa3yG6Mk3LaI0Ilix4zcTeBlRobekuLupO5wXkICErYhDXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vqSi5PL5EwaEJgniJUNhfl/jt8PQSXVMcnczd1sdW+I=;
 b=NW3EGzDzKG7jo2K9c+6uqUas1tmEMznZfV+1T7Z7gMDIhNJRr8Q8SV38VcZ2wKFFN/jsPl1VRxEU22hLpaycE65kaMmiM1U7AwxFSajHtncH87QXhMYtGc4Z+ZITeJEraO1WOzFqfm8+t4ku1chorWttEE1VmgYB6IUZUlsjyLVsDIk/lO3X7lOPGl5SC/EdzRc7clIm4+Qi0m69+Qh0vdhgzQQ6ZoOTFX6ET4ZWsO39qmdYcDRmIraWl9vNnR+BaYi13Ew0gs35s5kAMDlPEeWfM5+f1K7GTwI7DOCalMsWkxt/P3M7kDnOcL94F9xKZ3PPO5plPoTc07blVwL2kw==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by BY5PR12MB4324.namprd12.prod.outlook.com (2603:10b6:a03:209::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Mon, 13 Jul
 2026 16:44:54 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%7]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 16:44:53 +0000
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
Thread-Index: AQHdBMN4xuDJHQfm/UCI06mb/0iNl7Zna+gAgARCZHA=
Date: Mon, 13 Jul 2026 16:44:53 +0000
Message-ID:
 <IA1PR12MB9030E175587B09CEA7A4D90FBDFA2@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260625165407.1769572-1-mhonap@nvidia.com>
	<20260625165407.1769572-6-mhonap@nvidia.com>
 <20260710162322.012be635@shazbot.org>
In-Reply-To: <20260710162322.012be635@shazbot.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|BY5PR12MB4324:EE_
x-ms-office365-filtering-correlation-id: 6459e883-4f71-466b-9f01-08dee0fe10a7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|38070700021|6133799003|56012099006|4143699003|11063799006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 j+x0G58GJbbVH54LZtrvG8J7zfb9p0UFKthH4eYQNiCAMi1zkKChB+O715se7IiCqSTz/X447t6HiqN+oQGGDJ8EAQauhMmMjcy6CPL3wW+7CBdaWFAmyfXE0BJBp6tSuoul1hXyqUWtQr2daPA/zFulSOst+2ZcVQwHXfU/EnyvNC7/bLMPI7f8I/7gbsOtPnu/3HMkrwTuzoiNlDgrV/2E44/e5ZG/jn4ZRIXSvLGivTnePOFfsQPQhUTJf/fAy0e0lNOMOvEpeB0QQKp8OCntVH4W70ear9fL7BdNQYmOVoT4UoWOkAvjpYsZa69bA1cQ39WM3ZVcYu8uHOwoGzTNPKTKMe/ir5pY4uhXRYkuP00WwQOAnvlD52LCOmI3ujcoe3sq+WwJCIuF1bYhRqA7PF0C3yWAdwvqcHTSWYxXZ3IlzbQO5LcbQKWoPoYmY6LvrvSBk404+sISC0Oj7uUucwFO9SpZuDs1zQHP2IDDFYFDZZc/Bxa6jjoAf3meWXZdTBdDCoAz7H1E/k/kkFqHtcnkCLUQhKANrOZ/P7qwEFvY812425orsqyXGXLBkXYG4Gl1/aj8/bEujJkrwEGlQKGs+zaWdAHN7S5ymM+6V4e5D096qBq9s4j0HJTV1RjO9tcFy5ko1vnQDnhubSpM0D5lIftqiAPKKNOiWmTfRG3DpiEB4Y0kL/PN9MXpC0HVVvgrQgnB03WGbvEiTQr9kJ6ZcAnV7MqjtES/56Y=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(38070700021)(6133799003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?CcFn0wzV96barfzZP79Ut77bxX4os/COVAZqpLbrbA+RVeclvFQDbEafUh8C?=
 =?us-ascii?Q?hJ52DPRD3BPMwBizwUxphDKreu+oe7sJPsZ8isgDodA9IM6riHyS/QQdEWhD?=
 =?us-ascii?Q?5NdjcmAkV2lIp/lr2a/k6gGfrBTRFyjWBzks3Ov1Xbc/c83KH3ZT/Tgw2FdG?=
 =?us-ascii?Q?o1DbWanZehca8q6rkaUc1nxx6VIEnS1xv1NNMwWXfbmwT1jEThEn21sOdoB9?=
 =?us-ascii?Q?LH4dzMFbUTFGr2fzG7FmwwpnYxSohPaqf6ANyx3hUd3AGHWru5Jor3/N6qvk?=
 =?us-ascii?Q?mUCWz22Ev5sojGySrtQOQc16D2lfs7rLtiLzuuS7sU2zSHYCDNQcmoryI8iM?=
 =?us-ascii?Q?nZg2WbHpmFj+JKsIm2a/yb+tSbRGZN7boIwn8eY6cGZOKRIcgqr0wlLVW1PX?=
 =?us-ascii?Q?tyl+CKMBakqdxzECJhv36zKeodPtiRqdgXtH8zhK8keyoudwgFUmftqIA+Pa?=
 =?us-ascii?Q?IrHkRB2ZhkbcS7jd+92hhIJ+srnFT6cpSM4Wj5sZWnodo3CI78+0uSlIXZ8U?=
 =?us-ascii?Q?6f04Fz0a+aLQn350kl6S/Yy103D07oEkufhSwQvoo/a90rtTr+FGdbGxKnzT?=
 =?us-ascii?Q?rTtyJHC+ILR5O9HQXUE8Fjhm6f+oqgMTyX+AyE+AU+U6fhziuDFoi+tHXsZT?=
 =?us-ascii?Q?O8mHERWMcWlc/voL0NoDxvTGsFARfjqis3vEYUPNsqXug7VfhDw2y01qGuuK?=
 =?us-ascii?Q?3QwJMomNomK1HYT0tG6IOx1cvQrwLIMJgd6j1ZfaqdkHvFIbrFA/OUIxcc9G?=
 =?us-ascii?Q?kWWkQ1Hzzdpf5uSTAofCMjRC4JZiGA9TBHXtknn/w4jvsMz/siFkfMjnwZul?=
 =?us-ascii?Q?6REhMd9XWrIiNaM2ClTkd+HbmWCesPqqv070s13Dz0DiGptApCdQ1n0ZGWxk?=
 =?us-ascii?Q?HB/h4sYGej6pYxBW4gq/QvR4aklsfMxKAHfDIxlwwkWPjdOhMJPvTI5Wzapg?=
 =?us-ascii?Q?ev6zPa+CjhNxwxUov4q9xnBjcl2C27riOkEpODmvaviOWC6SRxK6O2V+CI6p?=
 =?us-ascii?Q?VMF58rhAdtd0r8Uu+TOauCq0ACI/gUK0poZ5ld+yFcP0F6IYQFU+IlUTgPU2?=
 =?us-ascii?Q?dvA5m5gT/4bwElJ5VEITShTAu+UlUWNsRE1lh2DYJ4DPj083c7mxEm9RuR4G?=
 =?us-ascii?Q?73id8oaLB9OfFnllkQbYsaV+8bZGrHZwy0HfDaKkKXcwbl4oDR5/oyeqxrI8?=
 =?us-ascii?Q?bXo/Agpflru2YLGvnqVzfhjBw2IhOq0yGSzRaJgpOEKp21v+cd5DRkx2pEZ3?=
 =?us-ascii?Q?X/Tn7pO99/Ejsj8oIZtBx9NfUzJLcXdueD20/Jc2WC8rD2z3UOol/r5fWPgw?=
 =?us-ascii?Q?roIZ+Sb7exfJRo5wGCpYLudEZXvHCukXw9kf0RjhLAF4pu+S2U2OmgVJ55Ul?=
 =?us-ascii?Q?16Wnz8PyWi90Ls0rsWo5Yl0GV1GcvE95c8JU3o0IsUvVkb1gDG+sWeeRv+N5?=
 =?us-ascii?Q?82yr2Q+g3FxweSIePlFNsDhKGU0ey2QKKBKDLotA8fSRQohw0IT7TVhMRgdd?=
 =?us-ascii?Q?r7EksSikx/9rLwyUvkfqIQ9z01gAlobe0bdSPUeh/vmWYwQa68DxcQfna4ld?=
 =?us-ascii?Q?KfUod6hR1wsR8ffMALcPFEOlEVbWFgDCvH6q2msiNnlqsghft1Yw927sViDm?=
 =?us-ascii?Q?Abpr0LsG8syZaxbcxD+zH2IMhhfuvubuhqZBi8kyr8HCSDPvmqTfBkoMlgu8?=
 =?us-ascii?Q?njvpCLCF/wX8tfoeXEDMylC+N7369mrtLUGR101G5XrwMgtd?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6459e883-4f71-466b-9f01-08dee0fe10a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2026 16:44:53.8362
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W/lTtfw0AtawzPdd2PrYv880LR7BbmlswSWFU6KnquDbEAKubjAls9F2LvL/TkNHIlPIR7OpCoUmGnfhaIRyHg==
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
> Subject: Re: [PATCH v3 05/11] vfio: UAPI for CXL Type-2 device
> passthrough
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Thu, 25 Jun 2026 22:24:01 +0530
> <mhonap@nvidia.com> wrote:
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index 5de618a3a5ee..3707d53c4de5 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -215,6 +215,7 @@ struct vfio_device_info {
> >  #define VFIO_DEVICE_FLAGS_FSL_MC (1 << 6)    /* vfio-fsl-mc device */
> >  #define VFIO_DEVICE_FLAGS_CAPS       (1 << 7)        /* Info supports
> caps */
> >  #define VFIO_DEVICE_FLAGS_CDX        (1 << 8)        /* vfio-cdx
> device */
> > +#define VFIO_DEVICE_FLAGS_CXL        (1 << 9)        /* vfio-cxl
> Type-2 device */
>=20
> Would we define a different flag for type-1/3 if we ever found a need to
> expose them through vfio?

Yes. The current flag is named VFIO_DEVICE_FLAGS_CXL and refers to
Type-2 specifically. If Type-1 or Type-3 support is added later, a
separate flag (or a VFIO_DEVICE_INFO_CAP sub-type field) would
distinguish them. I can rename it VFIO_DEVICE_FLAGS_CXL_TYPE2 now if
that is preferable; please advise.

>=20
> >       __u32   num_regions;    /* Max region index + 1 */
> >       __u32   num_irqs;       /* Max IRQ index + 1 */
> >       __u32   cap_offset;     /* Offset within info struct of first
> cap */
> > @@ -257,6 +258,36 @@ struct vfio_device_info_cap_pci_atomic_comp {
> >       __u32 reserved;
> >  };
> >
> > +/*
> > + * VFIO_DEVICE_INFO capability for CXL Type-2 passthrough devices.
> > + * Present when VFIO_DEVICE_FLAGS_CXL is set on
> vfio_device_info::flags.
> > + *
> > + * @flags: VFIO_CXL_CAP_HOST_FIRMWARE_COMMITTED indicates the host
> CXL
> > + *   subsystem committed the endpoint HDM decoder.
> > + * @hdm_region_idx: VFIO region index for the HDM memory region
> > + *   (subtype VFIO_REGION_SUBTYPE_CXL).
> > + * @comp_reg_region_idx: VFIO region index for the CXL Component
> > + *   Register shadow (subtype VFIO_REGION_SUBTYPE_CXL_COMP_REGS).
>=20
> These regions are self describing via the noted CXL subtypes, what's the
> purpose of double reporting them here?

Agreed; I will try to minimize the noise here.

>=20
> > + * @comp_reg_bar: PCI BAR index that contains the CXL component
> > + *   register block.  Get-region-info on this BAR returns a
> > + *   VFIO_REGION_INFO_CAP_SPARSE_MMAP that excludes the CXL block.
> > + * @comp_reg_offset: byte offset of the CXL component register block
> > + *   within @comp_reg_bar.
> > + * @comp_reg_size: byte size of the CXL component register block.
>=20
> Why don't we describe all of these via a capability on the relevant
> region info?

okay, I will have v4 to remove hdm_region_idx, comp_reg_region_idx,
comp_reg_bar, comp_reg_offset, and comp_reg_size from
vfio_device_info_cap_cxl. The device-level cap will only have flags.

This will also result in component register details to move to a new
VFIO_REGION_INFO_CAP_CXL_COMP_REGS capability on the comp-reg region
info, carrying comp_reg_bar, comp_reg_offset, and comp_reg_size.

Regions will remain self-describing via VFIO_REGION_SUBTYPE_CXL and
VFIO_REGION_SUBTYPE_CXL_COMP_REGS.

>=20
> Does that leave this device level capability describing the device as
> type-2 (by existence), with only a flags field to declare HDM as
> firmware committed, for future compatibility should we support non-fw
> committed?  Thanks,
>=20
> Alex

Yes, I will shape the v4 in this direction. The device-level CAP_CXL
shrinks to "this is a CXL device" (by existence) plus a flags field whose
only defined bit today is HOST_FIRMWARE_COMMITTED, leaving
room for a future non-fw-committed mode. Everything else moves to region
caps. Thanks for this suggestion.

