Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012032.outbound.protection.outlook.com [40.93.195.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F622DB7AE;
	Wed, 18 Mar 2026 17:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773856123; cv=fail; b=fhITQCmJy7QilOl9s6mvsm/00e0lRU/gmdzOVyArMUthTxfw+W4wDfcctsMYPVl1M0FNa4Zg362DVflXUDThOqHxtZETurpVMawJdpPe2z1FB3zEHVDx6jq89AOHSuCrhEE5wXf7EboO8bWz75I6RiOjuaKMstrHL6/AIkwyCEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773856123; c=relaxed/simple;
	bh=ggALchfeVlK+zuGjTs7oJZw5DgvNRLff1OZpqOK6otk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O5U7wtLC7af+U8+W3VSgnoglK4JkAoemfW9OrUR6BXJa1ZcY4jOh0I7kX+uvu3lUlmXnBbwokS7fHokf/cHnHA0umJe/wR1pLkD/nz1pbC539HgMzziJUm56Ob+4USw7sUq57tmdIzoO8A6cmBw7MaLx9ycX9pJyEb1jR+7zMF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j2/4XHUs; arc=fail smtp.client-ip=40.93.195.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j2/4XHUs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vZYfVTnL/B++GzWaoO0kJuj9aIO1qbJ/oxVMQfbPRcYCRs2wtvW8o+hDraD3pJPAzcDEl3w39tolbHRFxXX8BbFCfDSfPRmPiQnZHkBnYchV7YXqbR3Jb4TmBYLq7m1B4FdeC/r9SD3Jt/R9UdZXwPmzXrI6rKKXNwRB+fpTDeSQDRaQR3U38acpmaXOHkFeksQqHBERWQmYX8Dnlx4lJgsjuULTxMugjZ/qA7bgZx265Qlut7o5KDYzomNR9LeILXZgl4eLS1feSyN8p8UmK8RnpLwKU7nFyGT+D+1qSqdr692mE9qJQCsGx2WZ0zE9UetdsI/B86E0kuKYMqQgtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MwgEu9fg2uF7EAXhcMkeqjr9PvzJcwKoYwK4E1z3C/8=;
 b=kwVSWlREc5OWscsTf5gbZ3q8YHTW5J9rGD0qh/jBUSHqNfvyYtFwApX2LLQnp9tPbQUYKOJRaLqo9Mrcn+FgHPcPhND/CSk39sbpDMjJYUwgcFRls0LgJ+d3OmNmVrFWHYcvvKDxC5LCZXHsNlz/PolMLHLEwOLrMCJ5FQRu0TVxv4H8R7ZqgvSnAMt1W6vdoj7V8m+l2DnYtBXe8D8MN6gGkE+8MS/0mMsv/h4M1A//ARY6y/mu+kCSNX2AY9hAHSuRSq8qAyeYtPghUmFePuvh8xqSvLxt0U38fAsla0o8WTP2a9ZRFKk9U/Fg+Pkso1CkIdXYnODjSPUf6WTV4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MwgEu9fg2uF7EAXhcMkeqjr9PvzJcwKoYwK4E1z3C/8=;
 b=j2/4XHUsFx1k7utLBPJAvu9eM3mClbDQDW1tRh14UaQT3KrCmK46P588gviD6+x/Myz8frsgyDh0WnHA2iSVZYCN2uJxhFNOxl13URVHP1+vNWrpAFXASBoQ/2K19zpWFj9ftZ6uNXry85E+4VkPaLAOMMg7GuNdI+wENZQpuNCFM0UNjnlalvn53EjbJ3QYne9NrRDvckbA7pMRw5r8QhWXqRhZGfC0j8nCQRiCZn5N+DgTfV0L47KryTpAMI4TWC+GAgBhHFNW58OPj8qxgr2gPjV35AE72q5E40S2QO+tHfWJ455hj3CF8P2IIXyCfamnMydlfL47jMzyz9Zctw==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by CH1PR12MB9720.namprd12.prod.outlook.com (2603:10b6:610:2b2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 17:48:33 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 17:48:33 +0000
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
Subject: RE: [PATCH 10/20] vfio/cxl: CXL region management
Thread-Topic: [PATCH 10/20] vfio/cxl: CXL region management
Thread-Index: AQHcsZbDvcnCAeeMrkOa7ag2YLflCLWrg3sAgADp2ACACC1X8A==
Date: Wed, 18 Mar 2026 17:48:33 +0000
Message-ID:
 <IA1PR12MB903052909E311D36A0018460BD4EA@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260311203440.752648-1-mhonap@nvidia.com>
	<20260311203440.752648-11-mhonap@nvidia.com>
	<e2eaa470-c57b-4fa5-9810-4224ed314445@intel.com>
 <20260313125230.000058dd@huawei.com>
In-Reply-To: <20260313125230.000058dd@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|CH1PR12MB9720:EE_
x-ms-office365-filtering-correlation-id: 5ea9f649-4581-4cf2-061d-08de85169325
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 XCKFmeqyYANJXY0c7stzyUmYIQZJhtvZKveU7DAjs6dGGIcozvm+KDG2mvqhbgs95PkUBmPXIQE4Jy0/dytwC85yfv5kxep2PjOkdXaF8Zoxl21kLJEUaDmBrqPlhH0/eIBGnaAuDSpwXTGWCDdGNVI/y36RUt/kiCOP83chV7cwaIqzVNL3j0RPfGfq64rHjMrfWvyupcWyFhALs4qtDDPcWtQjL4z/OH0uFSMQCpNgqpx9tVOpsJ4euXs6RMyS/6A9192IKqiRZrXGQdMFf28DO+YPhijvRZZ183GjIrssi4EueJai+JdUvFJbB0/wMxgAn7yNyse6nXHDAl5DsVKGUYy6IJPihi8xZxipQhUC9FmwLasdcee662eU5knV46zrwCCLEWZVD0liU0Fe5FOAdVAbNPcxQ+1O61SGjkvtpHvyvSnLOCmcZldH3FWM1UA3dePd36vJJgP6GX/0v8PnbesYG09El6rinnrSGDKoZku+7Qyom+gGG/xOF1zmVzpot4+BCQ5TA+TIgwDveusrOUopUePuZGafLn3bC7i30GGx/puuAE878Qz3SHRIWnlFcX8CT0KviJFew177PxzQIou316s6jstu9yX0IfPsLVOu12o7GKRZn+iavAQoJXJohUdTsQaPQXrYyItdVCXmVvULMYaq9rF7S7DEPqDyucti5f8BcncgXzk6JsfRziwyQrO3KgzIDuxfbEEDVIEvs+MFSsBH7F32xNN3XNkxmoC812oa2tt1NcjN1h+8WiVIr45vRILMPW+wvjWDI9Q9Ef3WRtmpvmZpGagW7QQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?9o61v2Rmpw+6ie7LSlq/8UDz71QTNJ6ZTbU7XDaetoQcRvB50FJYQ/KdiZwv?=
 =?us-ascii?Q?a2aiaBm46L5LUs9lY0dNEcha4Ih5DjX2h5FX5wYj3Ho8enZBxGmFyLujyBYJ?=
 =?us-ascii?Q?jNWu+es3NQQPlJREnJOPzJNpmt2nilUfXsACvl2qhIjVAj1oMOaakmnFSvcG?=
 =?us-ascii?Q?w81qNzZsBqcnsS2rKPERo2g7xvU/h0TpXO3YAc2Vor3LD5rplGWKxQvLDTIp?=
 =?us-ascii?Q?jNzmhspNLPwvgH/8HT4342OxUxa6HLMQ8UZaohmXlOPCOWEVzcxTNk6MOMbj?=
 =?us-ascii?Q?G71kXW+fHRp8ZUXTmCnVsigjKl7shia/od2t3SS0sjVuyEs87qhp/KjRi8Vn?=
 =?us-ascii?Q?hMUaWyOwCwadXcTc8lsUO+TDMGnOjXMTpUascdtQM8q/hNU5w19M6NPwEOaG?=
 =?us-ascii?Q?GSrWAelsUDCWJ0hFydGaGneI4/dmFQK/nO5zVHZy1Jdku8I9Zkl59g6hj9IX?=
 =?us-ascii?Q?dh8LrOxqrFQN4NmE4PJO1xLpCEe3UyK/VV4BKZrVut4Cl/Uzfn8ruDtQzpxM?=
 =?us-ascii?Q?ItnhEvYxXE1R+faPwNbsm+/MNIZFDMNcqXK+XFBCvGwDcRXgXWG2VqJPNUoy?=
 =?us-ascii?Q?DUpYH9VehAQya9ZT2rxrU3ce549ICz9JZOf64ok7tZ8OFtC6J2SSnNkzbXAM?=
 =?us-ascii?Q?F8o72oo1MX+73P+uNchiOCXOlo4bU67sC2H2qEuTHiNERHrSxByCJoHG5Tmf?=
 =?us-ascii?Q?7uSAcc0rLkAyVH8HydKucj+Od6J+nS2RnkVhCIbMQWFD7uw/0GsqJ6BRh1Bx?=
 =?us-ascii?Q?Tqwp+UjpyUs/mWkTvQ/J1MQv/bEUQSgiKs4T7zKGJa6BFL9EPVysONLRimlA?=
 =?us-ascii?Q?X5mgUlhK+wbu4NlQMaIa+6Vh+kgL3561y6rMe125WlLmsJTCg30ijjssCBsd?=
 =?us-ascii?Q?6Tq9WF9uSC59GEBJY4m/pmbxP2mMrVQNUcCoHIiUzXZoP/LHbpZy03VTqdTw?=
 =?us-ascii?Q?ZsQ6FIrjae5p16EMRnpMK/qM3qttUWJ0/bv7727hSmWPxooPtVasA+++7yWg?=
 =?us-ascii?Q?ETaK4KEN/n03hkxGx4pwHAI3xTK4plGb0T34NgzQxIkDLTdm/RkWbD5UGDfv?=
 =?us-ascii?Q?y/JyzpeM49llpgdy11tH3Rd9x3kE55ZIJzS1Xd1YLkYV6xHDwqWypHdm0jwk?=
 =?us-ascii?Q?suFCyAAN93Dlyr3l2nPX7Av0GU6P1B3qRatgLfS1WX6lx4EjF4EIF4oCz/VT?=
 =?us-ascii?Q?JaLXN5RnA23vW6tMNb/OO8bYEmiJ1KIB27V8RLV0ctmONTSaYNWvWXqv0B6v?=
 =?us-ascii?Q?O+tj2JhJkr1sZakGc5x6MHFVB7jJOYZ9dbH67+mPaLvdJhKlUHMaNOQOX5xM?=
 =?us-ascii?Q?L25OQE2M2wfKi6cPUG5USVS9KGzerUxsWHGs5YCDaxgsarf0BZ5Q8jLzSzI5?=
 =?us-ascii?Q?ufKmrVVrIVaT32xnTLfJXWkbMFHOgfsQTPvCD7RuWDCM2POwltVNoqHLhXQW?=
 =?us-ascii?Q?BeoU975zsB4WW2RTDWOZU0dpVIhQl4zQ2jcq+KndZ00BofgqyIc/ytIC1Ls2?=
 =?us-ascii?Q?z6r3lCSnam48h0F2EO9IcYEQN+Kdu5U1h8dNKyIuGrJvTGn7nSTJKLwC3+OU?=
 =?us-ascii?Q?QyOYxka5OKn1G4GBFENRijSAYJ5L4ViQNlCKt7YpB/LDflvu1s8k6O1q4mDA?=
 =?us-ascii?Q?Bc2ix0bGg9XaBjyBmvqiaL1xHNkqCE1vfvxi28ucMrRxWi5Aq1Y+MELg7Bqj?=
 =?us-ascii?Q?rRzTZyi37AqhJtMhYefExNCBqeLb6kMnx0xNCa+DWw+5lWCp?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ea9f649-4581-4cf2-061d-08de85169325
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 17:48:33.7085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hFlDiBizcWox77CKQ+QfWC5PMMyGZ11NM7SurLbMbTgcpyiPByJ8Fx42tg18NigCfEnrbwtxAKhA6tWuknmrwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9720



> -----Original Message-----
> From: Jonathan Cameron <jonathan.cameron@huawei.com>
> Sent: 13 March 2026 18:23
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
> Subject: Re: [PATCH 10/20] vfio/cxl: CXL region management
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Thu, 12 Mar 2026 15:55:32 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
>=20
> > On 3/11/26 1:34 PM, mhonap@nvidia.com wrote:
> > > From: Manish Honap <mhonap@nvidia.com>
> > >
> > > Add CXL region management for future guest access.
> > >
> > > Region Management makes use of APIs provided by CXL_CORE as below:
> > >
> > > CREATE_REGION flow:
> > > 1. Validate request (size, decoder availability) 2. Allocate HPA via
> > > cxl_get_hpa_freespace() 3. Allocate DPA via cxl_request_dpa() 4.
> > > Create region via cxl_create_region() - commits HDM decoder!
> > > 5. Get HPA range via cxl_get_region_range()
> > >
> > > DESTROY_REGION flow:
> > > 1. Detach decoder via cxl_decoder_detach() 2. Free DPA via
> > > cxl_dpa_free() 3. Release root decoder via cxl_put_root_decoder()
> > >
> > > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> A few additional comments from me.
>=20
> > > ---
> > >  drivers/vfio/pci/cxl/vfio_cxl_core.c | 118
> ++++++++++++++++++++++++++-
> > >  drivers/vfio/pci/cxl/vfio_cxl_priv.h |   5 ++
> > >  drivers/vfio/pci/vfio_pci_priv.h     |   8 ++
> > >  3 files changed, 130 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > > b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > > index 2da6da1c0605..9c71f592e74e 100644
> > > --- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > > +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > > @@ -126,6 +126,112 @@ static int vfio_cxl_setup_regs(struct
> vfio_pci_core_device *vdev)
> > >     return 0;
> > >  }
> > >
> > > +int vfio_cxl_create_cxl_region(struct vfio_pci_core_device *vdev,
> > > +resource_size_t size) {
> > > +   struct vfio_pci_cxl_state *cxl =3D vdev->cxl;
> > > +   resource_size_t max_size;
> > > +   int ret;
> > > +
> > > +   if (cxl->precommitted)
> > > +           return 0;
> > > +
> > > +   cxl->cxlrd =3D cxl_get_hpa_freespace(cxl->cxlmd, 1,
> > > +                                      CXL_DECODER_F_RAM |
> > > +                                      CXL_DECODER_F_TYPE2,
> > > +                                      &max_size);
> >
> > Not sure what VFIO subsystem's policy is on scoped base resource
> cleanup, but a __free() here can get you out of managing put() of the roo=
t
> decoder.

After having a word with Alex for this, I have added __free macros.

> >
> > > +   if (IS_ERR(cxl->cxlrd))
> > > +           return PTR_ERR(cxl->cxlrd);
> > > +
> > > +   /* Insufficient HPA space */
> > > +   if (max_size < size) {
> > > +           cxl_put_root_decoder(cxl->cxlrd);
> > > +           cxl->cxlrd =3D NULL;
> Similar to other cases, I'd keep assigning stuff in cxl to the point wher=
e
> there are no more error paths.  Use local variables until then.
> (that would fit with using __free() as well which I'd also favor if
> accepted in VFIO).
>=20

Yes, addressed.

> > > +           return -ENOSPC;
> > > +   }
> > > +
> > > +   cxl->cxled =3D cxl_request_dpa(cxl->cxlmd, CXL_PARTMODE_RAM,
> > > + size);
> >
> > Same comment here about __free().
> >
> > > +   if (IS_ERR(cxl->cxled)) {
> > > +           ret =3D PTR_ERR(cxl->cxled);
> > > +           goto err_free_hpa;
> > > +   }
> > > +
> > > +   cxl->region =3D cxl_create_region(cxl->cxlrd, &cxl->cxled, 1);
> > > +   if (IS_ERR(cxl->region)) {
> > > +           ret =3D PTR_ERR(cxl->region);
>=20
> You carefully NULL this in vfio_cxl_destroy_region, but if you fail here
> you end up with it containing an ERR_PTR(). I'd avoid that by using a
> local variable and only assigning cxl->region after this suceeds.

Agreed.

>=20
> > > +           goto err_free_dpa;
> > > +   }
> > > +
> > > +   return 0;
> > > +
> > > +err_free_dpa:
> > > +   cxl_dpa_free(cxl->cxled);
> > > +err_free_hpa:
> > > +   if (cxl->cxlrd)
> > > +           cxl_put_root_decoder(cxl->cxlrd);
> > > +
> > > +   return ret;
> > > +}
> > > +
> > > +void vfio_cxl_destroy_cxl_region(struct vfio_pci_core_device *vdev)
> > > +{
> > > +   struct vfio_pci_cxl_state *cxl =3D vdev->cxl;
> > > +
> > > +   if (!cxl->region)
> > > +           return;
> > > +
> > > +   cxl_unregister_region(cxl->region);
> > > +   cxl->region =3D NULL;
> > > +
> > > +   if (cxl->precommitted)
> > > +           return;
> > > +
> > > +   cxl_dpa_free(cxl->cxled);
> > > +   cxl_put_root_decoder(cxl->cxlrd); }
> > > +
> > > +static int vfio_cxl_create_region_helper(struct vfio_pci_core_device
> *vdev,
> > > +                                    resource_size_t capacity) {
> > > +   struct vfio_pci_cxl_state *cxl =3D vdev->cxl;
> > > +   struct pci_dev *pdev =3D vdev->pdev;
> > > +   int ret;
> > > +
> > > +   if (cxl->precommitted) {
> > > +           cxl->cxled =3D cxl_get_committed_decoder(cxl->cxlmd,
> > > +                                                  &cxl->region);
> > > +           if (IS_ERR(cxl->cxled))
> > > +                   return PTR_ERR(cxl->cxled);
> > > +   } else {
> > > +           ret =3D vfio_cxl_create_cxl_region(vdev, capacity);
> > > +           if (ret)
> > > +                   return ret;
> > > +   }
> > > +
> > > +   if (cxl->region) {
> >
> > Maybe if you do 'if (!cxl->region)' first and just exit, then you don't
> need to indent the normal code path.

Okay, I will change this.

> >
> > > +           struct range range;
> > > +
> > > +           ret =3D cxl_get_region_range(cxl->region, &range);
> > > +           if (ret)
> > > +                   goto failed;
> > > +
> > > +           cxl->region_hpa =3D range.start;
> > > +           cxl->region_size =3D range_len(&range);
> > > +
> > > +           pci_dbg(pdev, "Precommitted decoder: HPA 0x%llx size %lu
> MB\n",
> > > +                   cxl->region_hpa, cxl->region_size >> 20);
> > > +   } else {
> > > +           pci_err(pdev, "Failed to create CXL region\n");
> > > +           ret =3D -ENODEV;
> > > +           goto failed;
> > > +   }
> > > +
> > > +   return 0;
> > > +
> > > +failed:
> > > +   vfio_cxl_destroy_cxl_region(vdev);
>=20
> Little bit of refactoring and this could be replaced with __free() magic.
>=20
> > > +   return ret;
> > > +}
> > > +
> > >  /**
> > >   * vfio_pci_cxl_detect_and_init - Detect and initialize CXL Type-2
> device
> > >   * @vdev: VFIO PCI device
> > > @@ -172,6 +278,12 @@ void vfio_pci_cxl_detect_and_init(struct
> > > vfio_pci_core_device *vdev)
> > >
> > >     pci_disable_device(pdev);
> > >
> > > +   ret =3D vfio_cxl_create_region_helper(vdev, SZ_256M);
> >
> > Maybe a comment on why this size?
> :)  I wondered that as well.  I'm guessing your bios isn't always
> providing the decoder and this lets you test.

This was added for handling the patch organization so that the patches
are cut at a short reviewable boundary. It seems this patch is not=20
cut correctly.

I have removed this temporary size and refactored the patches to
incorporate firmware committed decoder size here.

>=20
>=20
> >
> > DJ
> >
> > > +   if (ret)
> > > +           goto failed;
> > > +
> > > +   cxl->precommitted =3D true;
> > > +
> > >     return;
> > >
> > >  failed:
> > > @@ -181,6 +293,10 @@ void vfio_pci_cxl_detect_and_init(struct
> > > vfio_pci_core_device *vdev)
> > >
> > >  void vfio_pci_cxl_cleanup(struct vfio_pci_core_device *vdev)  {
> > > -   if (!vdev->cxl)
> > > +   struct vfio_pci_cxl_state *cxl =3D vdev->cxl;
>=20
> Do that in the earlier patch to reduce churn a tiny bit.

Okay, agreed.

>=20
> > > +
> > > +   if (!cxl || !cxl->region)
> > >             return;
> > > +
> > > +   vfio_cxl_destroy_cxl_region(vdev);
> > >  }

