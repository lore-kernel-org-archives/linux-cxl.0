Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011008.outbound.protection.outlook.com [40.93.194.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4023D32D7FB;
	Wed, 18 Mar 2026 17:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773855810; cv=fail; b=XcEXhFPvpdlXyKiMcRTNFwyenzy97P/EJDI/CX7FO+/KO3YdyN8B9KjMDnQ/JVRSY/zEtkh7Mf8MxwUIECQCxZKybXWjYPz+SyzmzrmwtD3VPp0I6P6vBcysSw6cYrlQw7V51V6MZ7OSJ8T2X9R9DUB8dOyyF4/JTA9Z+74w9gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773855810; c=relaxed/simple;
	bh=YbxES0qRLCHPdvxctRuVqL2tlZAN2tEYec5eyzKRjc8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ifaM36kgsreGHRNoQ2ieJmc1dyqdAFzHqFC8xyRblN51JGTjgvM+G71BeKsdqV+KF8fFjBJ7S3m4bAgQJOE6eZ6jjkH588cpbbHc90r17oJkyDQ/Nh2z+GpXVLD+n8SAmNDU8ef6PRw1Fhjjb21aE9h4hi0UIsa3YnWp5XUj/EQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lZsPGurU; arc=fail smtp.client-ip=40.93.194.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lZsPGurU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lkkGzfC1QnAmb2yIAb212D3ZUqyl6HP2Mp6CnUa9uXm5Cy5XhKTSHHt3xc9SimsEehziW7lJ15IJ+yyFbErn3tx7lrCSVcrL45+ezoW0glJ82FuA5ZftlVZRtmxXlL+Y1N8soOhdn91e59BOqARy6ljaiklV8Envj6+OZpvOaY+dWjMxbJfjt8kG7gUE6Wa0wRyGRivcbjh46EPJ0H9l0e9pR+7qfzNywBmnBkNGVA4QzB+4jItqSNujSGgPRS4N8FNU8dlVQrsraWO05V9mRKbiJKtTZ9kOaCKq7aA8mOZ61ES28zv1h/6kFnj17UvYyKOH8N6fylgh4sP/eYcGig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1L2iwjBeOOFgoN/P6Y5s93EjVF5X0Ci3YdY7ptSMQ4c=;
 b=qzzdp/v5ZSBaBLLmEcfiOUMmWqbh6/Jtb0h/lrV9ZcNbHHQFdT4mdbsOm/kQ1SzHot82PNzyHgviPV5EESf/nO49xZo4O8wL3SqQJn2gvHH8gUjfu5JJ1RbMs2HJ7G9Kx5xQ2PdhtmU4MNdvs0VZneD6tCbQXuPkQ5aBf58Ad3Tcxfzi3ltHOsMTit1HycJvEYu3LNfCi/AmqFo+PYrDk/xZZHzS4/Chvvo6rcoJVkTri1JG3qmJ4NF0kue9bnfRaY3VBijpendKf3nEsDF6QMLTXNq1M7cM2UdwwWehxBSMczXwWk7Oy7yaR+3OQbi5zSHN1qsmIV58MUemYm7R7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1L2iwjBeOOFgoN/P6Y5s93EjVF5X0Ci3YdY7ptSMQ4c=;
 b=lZsPGurUJVDnEcRP90fYcHhhHcFjdPYkZg5pPyhS39Bpqy8E/ziuWhxprMsZ4chJF0FbdpPh3C29SowGG9jjMgIT8Tjm4NlczQKH1kkwnEC191Wd9R5YDeJPODRDn1tWwJTnSXcOJiVJfllpK9fTkH/Zhk8btTtIQi7nbZEqWt0hlOyV96Zg89kSnIuRPJG2g7i4MLmMf+GEx167NNR6pafigWOrjZC/5ayPp2zDIIS7yXaiv5dLk35aaQJVCvkYF4SiyNBtLibTouYBNeZHjozEeM3EqB7W5DKhJPVi76zykwUCh0G127g3rmlx4uKYospgNqm5qsu0z1S6E6HKlw==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by CH2PR12MB4071.namprd12.prod.outlook.com (2603:10b6:610:7b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 17:43:22 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 17:43:22 +0000
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
Subject: RE: [PATCH 09/20] vfio/cxl: Implement CXL device detection and HDM
 register probing
Thread-Topic: [PATCH 09/20] vfio/cxl: Implement CXL device detection and HDM
 register probing
Thread-Index: AQHcsZa9IUA2T5vdQka77h613kXyebWrfKOAgADuOwCACC1moA==
Date: Wed, 18 Mar 2026 17:43:21 +0000
Message-ID:
 <IA1PR12MB9030C5F487070C8D1E42384BBD4EA@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260311203440.752648-1-mhonap@nvidia.com>
	<20260311203440.752648-10-mhonap@nvidia.com>
	<26be5ee3-d7ba-4bea-9824-c514341cf324@intel.com>
 <20260313124342.00001add@huawei.com>
In-Reply-To: <20260313124342.00001add@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|CH2PR12MB4071:EE_
x-ms-office365-filtering-correlation-id: dc11a4b4-21e1-454d-0ea2-08de8515d95c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700021|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info:
 eh/D16FY6Jb7OH6PE+cbLWb/xqOWx1pI22E5nBjepXLxmKelZ2tLUYwx+M6a9+AzGp/m/r5xfqK2aj9htnx5kSfiwKvfejW1E16zwRYv0BwrWXu0wBVNuxBnbeoFFmH0oDH6OmZzQqxONYsUSKVycBspmZBnTUp2MnoqY6s2TibzWblbHzmsxSSEaHmw5jQauM9CTMFGTIf0shNyCLxTl9uASDjdBIxwRky+qa+xcVlO8eKMM6vWZcDPEI48CQFKPloSznfTVukcKV9yvKZmk1kgdkY5TjJL3aE0ZH7GOneLH7g/mnWXWLo7UEWlSTe9T815E/VenXqTi2zue/hmizxrMsklhwPkidYNTrlKNaJ4YfkC/5f1/w28QHD4ex2bPYdrVlAJoiux6cuQuLvns6cTrmctlsNd7Bd5J+Hnjd28Y1KjSaKso1RXEVPZU5sHzML5kWv4jySVKa+gf0JLFGkKOVdNTU/BbIztRT2ilBIX3Cis/eDNpm+HPbQIqv3tPbiivEbYKiaDmndHmJC6OVPbIdI21PrzXRbrDWhboPb1fFIlmKaTPyMcBIg9qrX9oW+Ob68X9yPC4msse6A/WXm4/y0w0ZnjsvNLjEIuV62fCvGxsC7Wal+lS4CHHL7FuSw0No97czDQ9wSdxEMrmtikCL3aX/0uX3rIOtwqCp/9XoQFvkB0meYkeq+rIM2WpyVsOgLa0AxpZixmHgx2c1qLK02EUPr0zsQfhrYRsMxUZqUT0Nji0YYMlfRIVw2UcE0GqNU873y6FLhtEaIs955gC5/GUk2OAnJ2y8QZ8ZE=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700021)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MyCxIQz/y0Rul28TMAT5pAntJhSHIbQ8Th/ig6xubCZXfnRNKnztGlNMes4S?=
 =?us-ascii?Q?yM2vjDvv8uZ4fLJC6myOM8qHHSOpWdwTp0EF2YNOW5EoAPt6LS6wnSsniLyj?=
 =?us-ascii?Q?eD4ljcqMySAk8gUU65ppX2zP8gYqi5/kxBWqSzhaamXb+qppkFibMEiHe4dJ?=
 =?us-ascii?Q?iAeObsnG3HDVHMtr79PEcRGrgSwYo8kwYRc8yYnTG2fDwgEPfUTm2vULixSi?=
 =?us-ascii?Q?UNBe2H03KQ352s0vPUnWvGuYWoSpXTp5oz8r6ZFMbf0sC1YqGsvxo0GiLSrf?=
 =?us-ascii?Q?9vB/3WY/uR0qlCm9DWHX5f4LQXCLeoGBoykJireqztxbObq87hV1rZhr8XE1?=
 =?us-ascii?Q?bIPgLr33xRM+zPVYRzym3UmvVzD1kIwJuePUjsotabTN/hJr42G26FG3aCnp?=
 =?us-ascii?Q?QxKeJuv6J0VIClsYFoV+n9Si3QWPRpK8VsSZOP0whX43sSZf7ZDwV+V5qev/?=
 =?us-ascii?Q?MjMcCcXj9cMJ3d53RVLNuq/5ZgJcNomjeLBdQDD9MHkebIdCpiWvFO0wezDc?=
 =?us-ascii?Q?9rm/2lQV+ZmAHpVrRJPURz5XJdQrwTjbYrTQlwSnxbC+Ro/ahzSgn5DRyhej?=
 =?us-ascii?Q?hnPiAJvDefC8a6YXps9owi9qO4cPaD5ZezAIa6zPn/dOJ9uG3AZt/QuamdVd?=
 =?us-ascii?Q?Qdd56rKHbld/o0Xi2RbyU2hpD/AO0jaYAsColltSCbaWNQtbfGiD1mrCkHV2?=
 =?us-ascii?Q?6L8Sje6lLbkCF4GTZk0+PHv+cIBaqdluWRu24P4r6erg7HyQnrRUVk2428HB?=
 =?us-ascii?Q?hmQp4Kpx4CpyLf3WcdG4wVNjYmaaHmM7B4IWF5no0JvVC/6+FK3/dexdbuxz?=
 =?us-ascii?Q?TzuUEduaIMB/3ZIKQKFVmlDMQgGmJjLUp2V3zNZFaewi3syOfP3kls5qVR7v?=
 =?us-ascii?Q?1fL4OAjLPdfS96xcdJD3d44yIcNIf0bXA3IfQAHNkt0BdWTB1dKS+d0998sk?=
 =?us-ascii?Q?397CRrB8+N00V6MUlvxvv4nLQKNWSs8aj6uPmXPYKdADVEeMAZDSmWOAXJST?=
 =?us-ascii?Q?VvOXL9wytVjwMObSf9eClynD1OCfqTYZl9s5/OlQA65Tv3B9mydAH1ZD+nnV?=
 =?us-ascii?Q?otItMn1eRhvdXoCu2jYb4sNvMT8+7ApqYXEQeWgMyfCQ8aJmDDP2LA+/ob9b?=
 =?us-ascii?Q?51OlNr29sDfXi/53JEzQ9+iugwQPoT3BafrC6iOy9w6Z096pEbL2sVyLOFyR?=
 =?us-ascii?Q?PYS7GJypm0qfivc42l2cFPCVZ9z9GktW50tx12WvsrxXejftFbK2JKzDOwaI?=
 =?us-ascii?Q?1UGItOuviHrMjcbQkP8UzRRRA9ZDKnDmKTqtb+G9fFNjzI6a3ez+YPWSP+i6?=
 =?us-ascii?Q?dyHMr79Pw6VZx0/Fd8jSHlRumZbQPn+S5KBBEzNaoWYV4e0ZF8+19WDWfWFK?=
 =?us-ascii?Q?CNBMZGJAYHRKDly9VaHpbVyli7xJHbnUH+qeRLyqJ1EMbB50OrAXXrj17FzW?=
 =?us-ascii?Q?Q/A45b3Me84kPuv8ncYTwoRKdJ5KJQtGxbfogwVSkr4HKNEQKydulK0reaUZ?=
 =?us-ascii?Q?4D1pqJ3OkLtfufrblWiRGwspEsrZzWqJti7X4MEYsN4Kp+/p2ixPtqB6UsyJ?=
 =?us-ascii?Q?YL9RTQkWW/QZVK6H/+XhXU9i/FpnLqdVZquk2adfNEoa77gSDVgq/50k5v8Y?=
 =?us-ascii?Q?bELCty+ZstKv16qM5nYCHrSmYv6DOcJqIDWDus8ihdPtKh5bZc2DnJlRaybD?=
 =?us-ascii?Q?GRILFgmSwlnHapD3KJG8BMuWZMK7tdsT+6G0BXKEkgOMbYOI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dc11a4b4-21e1-454d-0ea2-08de8515d95c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 17:43:22.0147
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ijy3myzvwqAU8xJthmnJ5xize6dZB4PvvlaQWI/6QCTjJ3tw3XU8iJabt8M0JS7zn00ppn4W4ilQKFmdvPNL0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4071



> -----Original Message-----
> From: Jonathan Cameron <jonathan.cameron@huawei.com>
> Sent: 13 March 2026 18:14
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
> Subject: Re: [PATCH 09/20] vfio/cxl: Implement CXL device detection and
> HDM register probing
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Thu, 12 Mar 2026 15:31:03 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
>=20
> > On 3/11/26 1:34 PM, mhonap@nvidia.com wrote:
> > > From: Manish Honap <mhonap@nvidia.com>
> > >
> > > Implement the core CXL Type-2 device detection and component
> > > register probing logic in vfio_pci_cxl_detect_and_init().
> > >
> > > Three private helpers are introduced:
> > >
> > >   vfio_cxl_create_device_state() allocates the per-device
> > >   vfio_pci_cxl_state structure using devm_cxl_dev_state_create() so
> > >   that lifetime is tied to the PCI device binding.
> > >
> > >   vfio_cxl_find_bar() locates the PCI BAR that contains a given HPA
> > >   range, returning the BAR index and offset within it.
> > >
> > >   vfio_cxl_setup_regs() uses the CXL core helpers cxl_find_regblock()
> > >   and cxl_probe_component_regs() to enumerate the HDM decoder registe=
r
> > >   block, then records its BAR index, offset and size in the CXL state=
.
> > >
> > > vfio_pci_cxl_detect_and_init() orchestrates detection:
> > >   1. Check for CXL DVSEC via pcie_is_cxl() +
> pci_find_dvsec_capability().
> > >   2. Allocate CXL device state.
> > >   3. Temporarily call pci_enable_device_mem() for ioremap, then
> disable.
> > >   4. Probe component registers to find the HDM decoder block.
> > >
> > > On any failure vdev->cxl is devm_kfree'd so that device falls back
> > > to plain PCI mode transparently.
> > >
> > > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> Given Dave didn't crop anything I'll just reply on top and avoid
> duplication.
>=20
> Mostly lifetime handling comments.  I get nervous when devm occurs in the
> middle of non devm code. It needs to be done very carefully. I don't thin=
k
> you have a bug here, but I'm not keen on the resulting difference in orde=
r
> of setup and tear down.  I'd like cleanup to tidy it up even though it
> would be safe to do later.
>=20

I have addressed these comments by creating a local variable before assigni=
ng
cxl to vdev->cxl.

>=20
> > > ---
> > >  drivers/vfio/pci/cxl/vfio_cxl_core.c | 151
> +++++++++++++++++++++++++++
> > >  drivers/vfio/pci/cxl/vfio_cxl_priv.h |   8 ++
> > >  2 files changed, 159 insertions(+)
> > >
> > > diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > > b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > > index 7698d94e16be..2da6da1c0605 100644
> > > --- a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > > +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > > @@ -18,6 +18,114 @@
> > >
> > >  MODULE_IMPORT_NS("CXL");
> > >
> > > +static int vfio_cxl_create_device_state(struct vfio_pci_core_device
> *vdev,
> > > +                                   u16 dvsec) {
> > > +   struct pci_dev *pdev =3D vdev->pdev;
> > > +   struct device *dev =3D &pdev->dev;
> > > +   struct vfio_pci_cxl_state *cxl;
> > > +   bool cxl_mem_capable, is_cxl_type3;
> > > +   u16 cap_word;
> > > +
> > > +   /*
> > > +    * The devm allocation for the CXL state remains for the entire
> time
> > > +    * the PCI device is bound to vfio-pci. From successful CXL init
> > > +    * in probe until the device is released on unbind.
> > > +    * No extra explicit free is needed; devm handles it when
> > > +    * pdev->dev is released.
> > > +    */
> > > +   vdev->cxl =3D devm_cxl_dev_state_create(dev,
>=20
> Rather than assigning this in here, I'd use a local variable for the
> return of this, operate on that and return it from the function.
> That both creates a clean separation and possibly make error handling
> simpler later...
>=20
> Also similar to some of the feedback Alejandro had on his type 2 series,
> be very careful with mixing devm calls and non devm, generally that's a
> path to hard to read and reason about code.
> I know you've stated this is fine because it's tied to the PCI device
> lifetime and you are probably right on that, but I'm not keen.
>=20
> This might be a case where manual unwinding of devres is needed (maybe
> using devres groups if we end up with a bunch of stuff  to undo).
>=20
>=20
>=20
> > > +                                         CXL_DEVTYPE_DEVMEM,
> > > +                                         pdev->dev.id, dvsec,
> > > +                                         struct vfio_pci_cxl_state,
> > > +                                         cxlds, false);
> > > +   if (!vdev->cxl)
> > > +           return -ENOMEM;
> > > +
> > > +   cxl =3D vdev->cxl;
> > > +   cxl->dvsec =3D dvsec;
>=20
> That's a bit odd given we pass dvsec into devm_cxl_dev_state_create() why
> doesn't it assign it?

Yes, dvsec was redundant in cxl->dvsec and cxl->cxlds.cxl_dvsec
Removed it from cxl.

>=20
> > > +
> > > +   pci_read_config_word(pdev, dvsec + CXL_DVSEC_CAPABILITY_OFFSET,
> > > +                        &cap_word);
> > > +
> > > +   cxl_mem_capable =3D !!(cap_word & CXL_DVSEC_MEM_CAPABLE);
> > > +   is_cxl_type3 =3D ((pdev->class >> 8) =3D=3D PCI_CLASS_MEMORY_CXL)=
;
> >
> > Both of these can use FIELD_GET().

I have used FIELD_GET for MEM_CAPABLE flag. For pdev->class, I see there ar=
e
other occurrences (drivers/pci/pcie/aer_cxl_rch.c) which use same check for=
 detecting
memory class. So, I have kept the is_cxl_type3 check as it is.

> >
> > > +
> > > +   /*
> > > +    * Type 2 =3D CXL memory capable but NOT Type 3 (e.g.
> accelerator/GPU)
> > > +    * Unsupported for non cxl type-2 class of devices.
>=20
> As in other places, type 3 doesn't mean that. What you mean is class code
> compliant type 3.

Updated the comments and checks.

>=20
> > > +    */
> > > +   if (!(cxl_mem_capable && !is_cxl_type3)) {
> > > +           devm_kfree(&pdev->dev, vdev->cxl);
>=20
> As below. That needs a name that makes it clear it is the right devm call=
.
>=20
> > > +           vdev->cxl =3D NULL;
> > > +           return -ENODEV;
> > > +   }
> > > +
> > > +   return 0;
> > > +}
> > > +
> > > +static int vfio_cxl_setup_regs(struct vfio_pci_core_device *vdev) {
> > > +   struct vfio_pci_cxl_state *cxl =3D vdev->cxl;
> > > +   struct cxl_register_map *map =3D &cxl->cxlds.reg_map;
> > > +   resource_size_t offset, bar_offset, size;
> > > +   struct pci_dev *pdev =3D vdev->pdev;
> > > +   void __iomem *base;
> > > +   u32 count;
> > > +   int ret;
> > > +   u8 bar;
> > > +
> > > +   if (WARN_ON_ONCE(!pci_is_enabled(pdev)))
> > > +           return -EINVAL;
> > > +
> > > +   /* Find component register block via Register Locator DVSEC */
> > > +   ret =3D cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, map);
> > > +   if (ret)
> > > +           return ret;
> > > +
> > > +   /* Temporarily map the register block */
> > > +   base =3D ioremap(map->resource, map->max_size);
> >
> > Request the mem region before mapping it?

Yes, added the call to request region first before mapping.

> >
> > DJ
> >
> > > +   if (!base)
> > > +           return -ENOMEM;
> > > +
> > > +   /* Probe component register capabilities */
> > > +   cxl_probe_component_regs(&pdev->dev, base, &map->component_map);
> > > +
> > > +   /* Unmap immediately */
> > > +   iounmap(base);
> > > +
> > > +   /* Check if HDM decoder was found */
> > > +   if (!map->component_map.hdm_decoder.valid)
> > > +           return -ENODEV;
> > > +
> > > +   pci_dbg(pdev,
> > > +           "vfio_cxl: HDM decoder at offset=3D0x%lx, size=3D0x%lx\n"=
,
> > > +           map->component_map.hdm_decoder.offset,
> > > +           map->component_map.hdm_decoder.size);
> > > +
> > > +   /* Get HDM register info */
> > > +   ret =3D cxl_get_hdm_reg_info(&cxl->cxlds, &count, &offset, &size)=
;
> > > +   if (ret)
> > > +           return ret;
> > > +
> > > +   if (!count || !size)
> > > +           return -ENODEV;
> > > +
> > > +   cxl->hdm_count =3D count;
> > > +   cxl->hdm_reg_offset =3D offset;
> > > +   cxl->hdm_reg_size =3D size;
> > > +
> > > +   ret =3D cxl_regblock_get_bar_info(map, &bar, &bar_offset);
> > > +   if (ret)
> > > +           return ret;
> > > +
> > > +   cxl->comp_reg_bar =3D bar;
> > > +   cxl->comp_reg_offset =3D bar_offset;
> > > +   cxl->comp_reg_size =3D CXL_COMPONENT_REG_BLOCK_SIZE;
> > > +
> > > +   return 0;
> > > +}
> > > +
> > >  /**
> > >   * vfio_pci_cxl_detect_and_init - Detect and initialize CXL Type-2
> device
> > >   * @vdev: VFIO PCI device
> > > @@ -28,8 +136,51 @@ MODULE_IMPORT_NS("CXL");
> > >   */
> > >  void vfio_pci_cxl_detect_and_init(struct vfio_pci_core_device
> > > *vdev)  {
> > > +   struct pci_dev *pdev =3D vdev->pdev;
> > > +   struct vfio_pci_cxl_state *cxl;
> > > +   u16 dvsec;
> > > +   int ret;
> > > +
> > > +   if (!pcie_is_cxl(pdev))
> > > +           return;
> > > +
> > > +   dvsec =3D pci_find_dvsec_capability(pdev,
> > > +                                     PCI_VENDOR_ID_CXL,
> > > +                                     PCI_DVSEC_CXL_DEVICE);
> > > +   if (!dvsec)
> > > +           return;
> > > +
> > > +   ret =3D vfio_cxl_create_device_state(vdev, dvsec);
> Suggestion above would lead to.
>         cxl =3D vfio_cxl_create_device_state(vdev, dvsec);
>         if (IS_ERR(cxl))
>                 return PTR_ERR(cxl); //assuming failing at this point is
> fatal.
>=20
> then only set vdev->cxl once you are sure this function succeeded.
> Thus removing the need to set it to NULL on failure.
> You need to pass it into a few more calls though.

Yes, I have added a local variable for this purpose.

>=20
>=20
> > > +   if (ret)
> > > +           return;
> > > +
> > > +   cxl =3D vdev->cxl;
> > > +
> > > +   /*
> > > +    * Required for ioremap of the component register block and
> > > +    * calls to cxl_probe_component_regs().
> > > +    */
> > > +   ret =3D pci_enable_device_mem(pdev);
> > > +   if (ret)
> > > +           goto failed;
> > > +
> > > +   ret =3D vfio_cxl_setup_regs(vdev);
> > > +   if (ret) {
> > > +           pci_disable_device(pdev);
> > > +           goto failed;
> > > +   }
> > > +
> > > +   pci_disable_device(pdev);
> > > +
> AS above, I think this would be cleaner if only here do we have
>=20
>         vdev->cxl =3D cxl;
>=20
> > > +   return;
> > > +
> > > +failed:
> > > +   devm_kfree(&pdev->dev, vdev->cxl);
>=20
> If you get here you found a CXL device but couldn't handle it. Is it
> useful
> to continue?  I'd suggest probably not.   If returning an error then devm
> cleanup happens.  Also, we should have a wrapper around devm_kfree to mak=
e
> it clear that it is valid to use it for undoing the
>  devm_cxl_dev_state_create() (I haven't even checked it is valid)
>=20

Added a wrapper around devm_kfree.

> > > +   vdev->cxl =3D NULL;
> > >  }
> if /* __LINUX_VFIO_CXL_PRIV_H */
> >
> >

