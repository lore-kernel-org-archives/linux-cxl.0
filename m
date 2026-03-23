Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011009.outbound.protection.outlook.com [52.101.52.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940EC3ACF03;
	Mon, 23 Mar 2026 14:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774276620; cv=fail; b=ComO2z+Red675Lq2DY8vec2S8BMnWbPC+7hK8uieDdamncnguccgvPpsmx3Tux7CVQ5hPZRUarSOG4oTdVMAVU/oeDG+CZH3kcDrQvOvcv5jrqOY0jErALI7L4sNQdrZB/x8Pm2CB989GpqeRWvzPJe7EM2BlbVcIy4AKmYwjZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774276620; c=relaxed/simple;
	bh=uO+FL8T2GgdfPZE9YfzKYp5sTRqvQ3AooOUq76UPf1c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RDyymXOBLzcCKIET5dM1gEJrMabYvlkNZOaJhlfQxXCkOyARO7Rqjl6k0eoSd2ZGz00c3/E2STBowvKr5e4vhpDuSDUBwgg+9wrv04BeenrjQaBhF1JszV/kHy3AqjFbGOwmIGL/eqLc/AvfvJprmbBR1j8d3hzgXNI1KgA+QL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bCXR42q+; arc=fail smtp.client-ip=52.101.52.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bCXR42q+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mtfuO3oBZ3ZxPyMgzbwqgfn560ybP3Ih/go3bdNF2XVp2cSQlpfULP+6ddl2CQHvftqOFEDo+1ZF+kJURduR6llDI7NFrfCXE1vrvCTCNQIgodwxF/fMKfZEFSXbTZRA2EsCrcN3K7OHp/zx3jReJsxTfScpvYc1XYkTQud0gy7mHGJvJNnlLiTo09ku0p5AVyhnFUVFXWUNVTx+OTzRXGx6BTu5INfeKN01b90rm5Xmt5pIH7tK7M0RfWaR6PKV409j7nqwDM6V57aYTSDFGj8l/G+I/RQh9lJvwWWdTKY9tOJDw+k5as2rwfrWhm+zuklDZQM32etjXV3ZOJggxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1KzJLCl6xXM51zVdsG4qCVH2YaJjHhF0AEWHTD58Abg=;
 b=gi4xZRgz/SGOgMqd1YEHb5SGVRzjkQ5E1XQuJeGiQE/Wbzzew0TwWergPsGf6LkLyjCQcaVK+D9SgElsz6rMDgzr0FIxUyAMQUddSuy5AHgjPNgex0brUKJMEp57O+lFhYxDgnyvunGKByMIhvEMYVytswJ9mZ+1tHEbmZNhgFGWVqEcJCKMf0tggBpi1mNpJwXIOEgCSKCYyOiQQlV1tEALpjfiW2GIr7ryhfr16YTarXFLHCDzUe1F8dOpe1sRu0ZMcsvuR25rEeXIq3libUaCjKlZbLvNLAjiEkGNYb4DL/K6yiDH9Ef0FLyzovnm/i1tjK1RLdLiL2PU/x2jCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1KzJLCl6xXM51zVdsG4qCVH2YaJjHhF0AEWHTD58Abg=;
 b=bCXR42q+Ats1Me0SB0L9BiJXYbYc44ABRb4sMcZHnjuwZiSIpSaU37Ghi8oJRCDCxlvE9uzqgjGqxaohDzHPcrnBoPFg8iV0ooTYGvfqW3j5GfYSdd+GS5hNp+6sAix0KVCIg/JJETELehBdf4pelfek8xqDZF0q1hTy3ZT2zMkNCrgbpQRwvBk0Op4TIIFskE0LhQOquKNQE2qMz7dGVGCzvta0CxdlyhU0nlo4Qp/SgLM4B+yy1jAWShuCu/2D3uu/19UAXZBYe0yn8P1ebj8hzZyGIA8z0kMCZ3O1jhwMZBznJaxLY7XhUOg26Olgqj80Denax3c4eBLXb7zCsg==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by SN7PR12MB6984.namprd12.prod.outlook.com (2603:10b6:806:260::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.15; Mon, 23 Mar
 2026 14:36:54 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%6]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 14:36:53 +0000
From: Manish Honap <mhonap@nvidia.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Alex Williamson
	<alex@shazbot.org>
CC: Aniket Agashe <aniketa@nvidia.com>, Ankit Agrawal <ankita@nvidia.com>,
	Vikram Sethi <vsethi@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Matt Ochs
	<mochs@nvidia.com>, Shameer Kolothum Thodi <skolothumtho@nvidia.com>,
	"alejandro.lucero-palau@amd.com" <alejandro.lucero-palau@amd.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "dave.jiang@intel.com"
	<dave.jiang@intel.com>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"dan.j.williams@intel.com" <dan.j.williams@intel.com>, "jgg@ziepe.ca"
	<jgg@ziepe.ca>, Yishai Hadas <yishaih@nvidia.com>, "kevin.tian@intel.com"
	<kevin.tian@intel.com>, Neo Jia <cjia@nvidia.com>, "Tarun Gupta (SW-GPU)"
	<targupta@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, Krishnakant Jaju
	<kjaju@nvidia.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	Manish Honap <mhonap@nvidia.com>
Subject: RE: [PATCH 18/20] docs: vfio-pci: Document CXL Type-2 device
 passthrough
Thread-Topic: [PATCH 18/20] docs: vfio-pci: Document CXL Type-2 device
 passthrough
Thread-Index: AQHcsZbqDWj5q9OyiUWoNyL+92alnLWsYnqAgAbjS4CAAsu/AIAGL+rg
Date: Mon, 23 Mar 2026 14:36:53 +0000
Message-ID:
 <IA1PR12MB9030922D69CC296A76997CBFBD4BA@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260311203440.752648-1-mhonap@nvidia.com>
	<20260311203440.752648-19-mhonap@nvidia.com>
	<20260313121341.00001bfa@huawei.com>	<20260317152445.67a93881@shazbot.org>
 <20260319160630.00002c6d@huawei.com>
In-Reply-To: <20260319160630.00002c6d@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|SN7PR12MB6984:EE_
x-ms-office365-filtering-correlation-id: 1c52eab2-12da-4c45-dc0c-08de88e9a07a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 hqvpde23Pw7HESbwubZu7TZhy05We3Kx96c3zdVvryTKxEuq8xMcYKIDsbF2y4aC2Cn3G8/pjDNg+e7efqXifC8qVIQyBE5rPPFKsojApQ4T3HfjOhMPmREAI1ibkctfCx9C7Tc0qMRBqLcJdyC+f/VtwM3RIZUddFk+oOc4/0rgYmb1UPU5LgLBp0O0G56pSyqSFUe5QaK7uv3kOuQtTgpvQBbHYGmEuTVxfqWQ2gKkMNBbcn46uy395hAHL9uwnqBr0kHnwsJ+oayHWhVxrxg0Iiga9bI4Y6j2GzCWHy812nwfCK6OLUXwHSfUCX415gA+WPG6uCMOhfjTRNKOzXjEKoah0W1esJqqKmePhsiuYIGvVLV3vBudC073XFA4azPkYAgLki/BRjDbC+R6Zy1ZfJmj8DSSrcKrSO76WbXCE6D9BeYHKCglxqcO7nT/yR0D6LDzKBs9Tf3hoUnzC09yvO15Zz9lg20+2QN8Xg0widt34A+1OiFGOzMPB8QizlUoKBNdA7PQAhuJjuhtYtaKKIGVRmi5MgQkozxKzEsg937vnmJz51fOBNFyYiOJ0yOdNDRtN3xQZgTzw/Hzhx1bImUYWgi0I8SmnXoGYgbEh4BkT9hMCGZNvNGRqmC5AS+ijtUBAImAHTjr0CBHMt58c4ZlXvpH1/UINNTcvSwOZxm3NrlZEBriXICW2/CKqXNngbxTXgfZR7mERg+8vklIF5p/ivaxGVFe5onxJAS5DymBWnweyBqivC8C58flK6i0ANR8bnuKnSOFzJBZegNqw+ijq24TnwnRouhsiAI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?IiUYpbhDZxVIKwN+5obhMWyEs4LkKSEEV52mq2NL4Z9qrmZMptaRdMtGLLDD?=
 =?us-ascii?Q?JYw8yj9jjSKxXD3XhLg819HCuyHP3oooMxGbodXRooB4tkSejAXrkCeSSRl6?=
 =?us-ascii?Q?hTBFeV4jeAULNp4o2NYiykb1rFqqFEn9lchGHx+oc5EcirvOnKsh/MUewmcH?=
 =?us-ascii?Q?8Wd6PHqiuJxBYCEeFIM92YzyM/lKLG6JJnSXvP8XTJqpemrFLLkO+Evzdbn9?=
 =?us-ascii?Q?M82/uib9PWyPnGcFo6b2UmrQHuJZNQYoR8jHTgDYec7e6vzputYy5K3KTUdB?=
 =?us-ascii?Q?mf0wGBeaNc/VLnig9WXfzxj/LZ5RZmCj22HrbAPRmAPoLLAvKWFvliRW54W4?=
 =?us-ascii?Q?VhVwBk3leQ/BWHJjegT9na/AN6uuVsFABkHf2HM929ekAvMmqGIw86//4U3s?=
 =?us-ascii?Q?OGxkQafAtZIWV1Ouo+IFm/kNe6H5FEyl8i6Hoc/8Ozj5VQjMc26unPdZrHc7?=
 =?us-ascii?Q?2DM1/FYPNuR1tS2ng51r6jTFRRuGQQWSRnq35qJdsO6QIRKVIHs/bYmHjWxk?=
 =?us-ascii?Q?ETRZwBsnQf2j8fhlKNBwUOxHahxVQYjvalnn+nLrVo1lS245izt3JT00IJsl?=
 =?us-ascii?Q?xF4cw3vGfDsYImbfypf0PxAaoqQNiSghq1u/wzRFNqLlW5rAwc1TLCrShBl7?=
 =?us-ascii?Q?EuHFJaNR25wko6nHNJc/EAysH7JR1lRS1CM2dZq+ExYsL1eD0SG3vcnqQLZ1?=
 =?us-ascii?Q?fG/z/gsE+xIrRILaUxB+EFcB0crrVwEK2LAcHDjMne7jVHRNCUazQCxv9jhL?=
 =?us-ascii?Q?g9jtsV1eL8iptMMEx/V1WIG/+uG6UXptDEr3M9zGEJg5tCAZJRcSvIeRBOxi?=
 =?us-ascii?Q?CGb7JKz0dZgPTozmuEohY/6y2qcJp3ggzVtEb5wlSzi+e+/PziyD1g1DeQZf?=
 =?us-ascii?Q?09Cu39l15y9OMlQ6aBbl/hoHCteH3B38ZDRBSI1QBS0Loh2conVEumhtKFvH?=
 =?us-ascii?Q?mhCjIl8lSbBTAMJGmyA/sOKmjzZiF/1L6GhU39k5KqscIME9krYktXo47Lj9?=
 =?us-ascii?Q?M9ePghrwTPsDZLECyrjCyjKoVuQiy/Jm0poQJOE+WRHbomYfSoOsBxJOWG/h?=
 =?us-ascii?Q?VvlDzx+elWA73B09GI9i/CHALf/EJFAlHaso10OaqGG6vItzo/96Bexv+7/W?=
 =?us-ascii?Q?XvHNgHbZhfBHx8Ve0rtTHYlohbftJfpULT2Gf29OP4usuPjkQaWs+xOrK7+U?=
 =?us-ascii?Q?mdw/pvsB5yl7VPXf3h9zhbQqZqumQn7UmQTpDG7bXZrcVcCe7x0mTe/nqx0k?=
 =?us-ascii?Q?Q9+dYW+V6yopMw1/DYyosRieca962xCOlzeCk60okRcNmk7oWNiZSKB0onQs?=
 =?us-ascii?Q?bG9tjCXIcu7cLXKVkHnhe2epN5Q7cDf7KziL8R+n6SbRZ7zyJYb4fli7cHCr?=
 =?us-ascii?Q?zj4uQInAz1PwQpQQdDz5Y6aaLM4oNntz4Zojhai+oalwTYgnYQ8EoGZSXAnR?=
 =?us-ascii?Q?gfU69I9xY8Pg8r4i6jMua9Kh7tbZeJ0tlSeLdHR7PtN7MxGc5CoxbIEyeOaH?=
 =?us-ascii?Q?atO0QQ1MFBq5pNlOl87A2eWWdwxOnFF9U/e006eZIh4JM3j7CY3/x6EVM5gH?=
 =?us-ascii?Q?8+pUuje6L2HgFDHBhxMip9pqjuUalNUk2yfobSo4eXncsUMwer0BSwrGsaeO?=
 =?us-ascii?Q?V6LmoDG+v7qrn9YMMlsN/h9cc7j8LALBtLDrWMqlpGfom1seRwK2+AndKmjI?=
 =?us-ascii?Q?F8bcfEn7g86thYh2g+1vzOVMaBy60IgpeguNghj560U1EzjY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c52eab2-12da-4c45-dc0c-08de88e9a07a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2026 14:36:53.4102
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /0fvgWrKCcfKKE+VkbF3DqkOhqjawpzxoeViqzDsF4M4lttTrIX3dgAvG5WBgWgkLzb8iLxCo8QpAqQlXk4wxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6984



> -----Original Message-----
> From: Jonathan Cameron <jonathan.cameron@huawei.com>
> Sent: 19 March 2026 21:37
> To: Alex Williamson <alex@shazbot.org>
> Cc: Manish Honap <mhonap@nvidia.com>; Aniket Agashe
> <aniketa@nvidia.com>; Ankit Agrawal <ankita@nvidia.com>; Vikram Sethi
> <vsethi@nvidia.com>; Jason Gunthorpe <jgg@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; Shameer Kolothum Thodi <skolothumtho@nvidia.com>;
> alejandro.lucero-palau@amd.com; dave@stgolabs.net; dave.jiang@intel.com;
> alison.schofield@intel.com; vishal.l.verma@intel.com;
> ira.weiny@intel.com; dan.j.williams@intel.com; jgg@ziepe.ca; Yishai
> Hadas <yishaih@nvidia.com>; kevin.tian@intel.com; Neo Jia
> <cjia@nvidia.com>; Tarun Gupta (SW-GPU) <targupta@nvidia.com>; Zhi Wang
> <zhiw@nvidia.com>; Krishnakant Jaju <kjaju@nvidia.com>; linux-
> kernel@vger.kernel.org; linux-cxl@vger.kernel.org; kvm@vger.kernel.org
> Subject: Re: [PATCH 18/20] docs: vfio-pci: Document CXL Type-2 device
> passthrough
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Tue, 17 Mar 2026 15:24:45 -0600
> Alex Williamson <alex@shazbot.org> wrote:
>=20
> > On Fri, 13 Mar 2026 12:13:41 +0000
> > Jonathan Cameron <jonathan.cameron@huawei.com> wrote:
> >
> > > On Thu, 12 Mar 2026 02:04:38 +0530
> > > mhonap@nvidia.com wrote:
> > >
> > > > From: Manish Honap <mhonap@nvidia.com>
> > > > ---
> > > >  Documentation/driver-api/index.rst        |   1 +
> > > >  Documentation/driver-api/vfio-pci-cxl.rst | 216
> > > > ++++++++++++++++++++++
> > > >  2 files changed, 217 insertions(+)  create mode 100644
> > > > Documentation/driver-api/vfio-pci-cxl.rst
> > > >
> > > > diff --git a/Documentation/driver-api/index.rst
> > > > b/Documentation/driver-api/index.rst
> > > > index 1833e6a0687e..7ec661846f6b 100644
> > > > --- a/Documentation/driver-api/index.rst
> > > > +++ b/Documentation/driver-api/index.rst
> > >
> > > >
> > > >  Bus-level documentation
> > > >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
> > > > diff --git a/Documentation/driver-api/vfio-pci-cxl.rst
> > > > b/Documentation/driver-api/vfio-pci-cxl.rst
> > > > new file mode 100644
> > > > index 000000000000..f2cbe2fdb036
> > > > --- /dev/null
> > > > +++ b/Documentation/driver-api/vfio-pci-cxl.rst
> > >
> > > > +Device Detection
> > > > +----------------
> > > > +
> > > > +CXL Type-2 detection happens automatically when ``vfio-pci``
> > > > +registers a device that has:
> > > > +
> > > > +1. A CXL Device DVSEC capability (PCIe DVSEC Vendor ID 0x1E98, ID
> 0x0000).
> > > > +2. Bit 2 (Mem_Capable) set in the CXL Capability register within
> that DVSEC.
> > >
> > > FWIW to be type 2 as opposed to a type 3 non class code device (e.g.
> > > the compressed memory devices Gregory Price and others are using)
> > > you need Cache_capable as well.  Might be worth making this all
> > > about CXL Type-2 and non class code Type-3.
> > >
> > > > +3. A PCI class code that is **not** ``0x050210`` (CXL Type-3
> memory device).
> > > > +4. An HDM Decoder block discoverable via the Register Locator
> DVSEC.
> > > > +5. A pre-committed HDM decoder (BIOS/firmware programmed) with
> non-zero size.
> > >
> > > This is the bit that we need to make more general. Otherwise you'll
> > > have to have a bios upgrade for every type 2 device (and no native
> hotplug).
> > > Note native hotplug is quite likely if anyone is switch based device
> > > pooling.
> > >
> > > I assume that you are doing this today to get something upstream and
> > > presume it works for the type 2 device you have on the host you care
> > > about.  I'm not sure there are 'general' solutions but maybe there
> > > are some heuristics or sufficient conditions for establishing the
> > > size.
> > >
> > > Type 2 might have any of:
> > > - Conveniently preprogrammed HDM decoders (the case you use)
> > > - Maximum of 2 HDM decoders + the same number of Range registers.
> > >   In general the problem with range registers is they are a legacy
> feature
> > >   and there are only 2 of them whereas a real device may have many
> more
> > >   DPA ranges. In this corner case though, is it enough to give us
> the
> > >   necessary sizes?  I think it might be but would like others
> familiar
> > >   with the spec to confirm. (If needed I'll take this to the
> consortium
> > >   for an 'official' view).
> > > - A DOE and table access protocol.  CDAT should give us enough info
> to
> > >   be fairly sure what is needed.
> > > - A CXL mailbox (maybe the version in the PCI spec now) and the spec
> defined
> > >   commands to query what is there.  Reading the intro to 8.2.10.9
> Memory
> > >   Device Command Sets, it's a little unclear on whether these are
> valid on
> > >   non class code devices but I believe having the appropriate
> Mailbox
> > >   type identifier is enough to say we expect to get them.
> > >
> > > None of this is required though and the mailboxes are non trivial.
> > > So personally I think we should propose a new DVSEC that provides
> > > any info we need for generic passthrough.  Starting with what we
> > > need to get the regions right.  Until something like that is in
> > > place we will have to store this info somewhere.
> > >
> > > There is (maybe) an alternative of doing the region allocation on
> demand.
> > > That is emulate the HDM decoders in QEMU (on top of the emulation
> > > here) and when settings corresponding to a region setup occur, go
> > > request one from the CXL core. The problem is we can't guarantee it
> > > will be available at that time. So we can 'guess' what to provide to
> > > the VM in terms of CXL fixed memory windows, but short of heuristics
> > > (either whole of the host offer, or divide it up based on devices
> > > present  vs what is in the VM) that is going to be prone to it not
> > > being available later.
> > >
> > > Where do people think this should be?  We are going to end up with a
> > > device list somewhere. Could be in kernel, or in QEMU or make it an
> > > orchestrator problem (applying the 'someone else's problem'
> solution).
> >
> > That's the typical approach.  That's what we did with resizable BARs.
> > If we cannot guarantee allocation on demand, we need to push the
> > policy to the device, via something that indicates the size to use, or
> > to the orchestration, via something that allows the size to be
> > committed out-of-band.  As with REBAR, we then need to be able to
> > restrict the guest behavior to select only the configured option.
> >
> > I imagine this means for the non-pre-allocated case, we need to
> > develop some sysfs attributes that allows that out-of-band sizing,
> > which would then appear as a fixed, pre-allocated configuration to the
> guest.
> > Thanks,
>=20
> I did some reading as only vaguely familiar with how the resizeable bar
> stuff was done. That approach should be fairly straight forward to adapt
> here.
> Stash some config in struct pci_dev before binding vfio-pci/cxl via a
> sysfs interface.  Given that the association with the CXL infrastructure
> only happens later (unlike bar config) it would then be the job of the
> vfio-pci/cxl driver to see what was requested and attempt to set up the
> CXL topology to deliver it at bind time.
>=20
> Manesh, would you mind hack at small PoC on top of your existing code to
> see if this approach shows up any problems?  I don't have anything to
> test against right now, though could probably hack some emulation
> together fairly fast.
> I'm thinking you'll get there faster!  I'm mostly focused on this cycle
> stuff at the moment, and I suspect we'll be discussing this for a while
> yet + it has dependencies on other series that aren't in yet.
>=20
> I'm not sure the PCI folk will like us stashing random stuff in their
> structures just because we haven't bound anything yet though so have no
> CXL structures to use.  We should probably think about how VF CXL.mem
> region/sub-region assignment might work as well.
>=20
> Sticking to PF (well actually just function 0) passthrough for now...
> For the guest, we can constrain things so there is only one right option
> though it will limit what topologies we can build.  Basically each
> device passed through has it's own CXL fixed memory window, it's own
> host bridge, it's own root port + no switches.  The sizing it sees for
> the CFMWS matches what we configured in the host.  We could program that
> topology up and lock it down but that means VM BIOS nastiness so I'd
> leave it to the native linux code to bring it up.  If anyone wants to do
> P2P it'll get harder to do within the spec as we will have to prevent
> topologies that contain foot guns like the ability to configure
> interleave.
>=20
> This constrained approach is what we plan for the CXL class code type 3
> device emulation used for DCD so we've been exploring it already.
> It's still possible to do annoying things like zero size decoders +
> skip. For now we can fail HDM decoder commits if they are particularly
> non sensical and we haven't handled them yet - ultimately we'll probably
> want to minimize what we refuse to handle as I'm sure 'other OS' may not
> do things the same as Linux.
>=20
> P2P and the fun of single device on multiple PCI heirarchies as to be
> solved later. As an FYI, for bandwidth, people will be building devices
> that interleave memory addresses over multiple root ports. Dan reminded
> me of that challenge last night.  See bundled ports in CXL 4.0, though
> this particular part related to CXL.mem is actually possible prior to
> that stuff for CXL.cache.  Oh and don't get me started on TSP / coco
> challenges.
> I take the view they are Dan's problem for now ;)
>=20
> Jonathan
>=20

Hello Alex, Jonathan,

I will shortly provide the updated vfio-cxl patch v2 and the QEMU RFC as pe=
r
suggestions mentioned here.

>=20
> >
> > Alex

