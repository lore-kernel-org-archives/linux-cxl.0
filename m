Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010011.outbound.protection.outlook.com [52.101.61.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079151EFFB7;
	Wed, 18 Mar 2026 17:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773854502; cv=fail; b=CoDMQlG0DdIOZ4O0aLrE5HPZAKAk1UX2tAeqn49rJu+0MCzzf/laN/+32WDolD/Zqi9+wk2Y7BnVGVLf9t/9hq7DGdcOMqgzfaDylKCCmj2QctiweKd0N0d1RFW+zV/82+jydbE7+ClyR5IGNaYYg8/Cmv/cw1dbKHC7+lcYf04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773854502; c=relaxed/simple;
	bh=F9tNIESsu7/8d6btSOw747Z7UiQmrfo9MrkyK0gsWBY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hy7WsoBGuqNAYkFyBQZotFmPLZjX35erS99yCxE6rv1LvYGnTE34XHQCR5RBZI2jKzkUPG7Kk2vL/WKsZhzh/hTj6fRyvUduG+WurXIYVV68CvPI240ODlmxqZnFJfQ0QPx2k6Dy3D7DGwrKEfaA9eiq0Dgm+2xwx4P2wGb8OFs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=igWoJqge; arc=fail smtp.client-ip=52.101.61.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="igWoJqge"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GhpQ/mNF3tb2aDDNnywOD/WKHIatEQgicn3j8xPxmC/9kwG9Cew1wXwwVAUFb7QC+vpBmN0DpXsQxPa7wLZ4NAmdF+XmQhwiBUAfuDEt9I0BDtmUgA+1hgH3ssYm+tfoRX71at/FyHF8EijFGd29ouzIE0sR14y3JsThLIxUrm7NanCRjJnd+IBBvHae/dSR+0d+GxcyA+X6YMvtfeVtyLSgzTtKdjGFsgqwoG31VqVHVkM0cK3gNowQ2shLqdc/RAGO0w1B7vnUGzpwhcgBY7c+vyLojlRfetysV03vhtnTMEazeDm3t5npVb0h0SGIo/jRGIgDzpU5xcK7ax0Hsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2mGKQXte83Gjso5WuERzoxp9HW86yBQzHgGm7W//aA=;
 b=Q6shCv75Gymyx7V43zHAKdiTgfS/rokDLbk8Afeavv9vHYrHSThtcYIF+ta67AeJ+t4ZCOyz/7ogADniRLf1clVFpsKChaNMwr18z6l/DLkeG7lNk/qRXLvhaI9BQ6nOPY+DloaC+p1Ss1geMuMOaJ3bOi7U/2hHT0k8jx62vd7SPFPdkrdEX/TTDxEIA/hVC7QH33HAWEhRrVx1eskUDGh5G0le1WGwC/DL8ChCU5G5is4p6NR3cEQ/kCjKr+Jt7tRdPYUvmrphKd5yvXenPfHdHRXnuISgpmwBd50yCAQ8zAIS4DsyDkQwvTxiFJGeiZbTFe4zDKZj7v04LV9N7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2mGKQXte83Gjso5WuERzoxp9HW86yBQzHgGm7W//aA=;
 b=igWoJqgeZCJtKki6wY7yeNEjPkkxlauLV8vlfDhIyvJfU2H9QSueVIpoPYnlUA82xWlCW6RYLpcHNjfOe0/QRRkRA5+rhRY1BRaYtnx1CoWPiuR6MqvM+EvJ+m1eQb1GEq90SjpTccOzT3jw6oMR8lcd4/fRf1Zw3SkfVeLROlrhMhp5ARt8Ty5e9oT/qNsSy+Flve6krQI6GmDguWmi+lRMK71EZMD2l6pUBQCqYdo2hHqVJUC4VbpP9Ej7hLvq1rFsFNDLuM+hFu4MdgIbOKc5CeGYBSsfi1HqgYjpnMhlr9eN/xcgYyxHIGjrBpUbKd+68vgTjKfUQfmfIMtGTw==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by DS0PR12MB6463.namprd12.prod.outlook.com (2603:10b6:8:c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.14; Wed, 18 Mar
 2026 17:21:34 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%6]) with mapi id 15.20.9723.018; Wed, 18 Mar 2026
 17:21:34 +0000
From: Manish Honap <mhonap@nvidia.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: Aniket Agashe <aniketa@nvidia.com>, Ankit Agrawal <ankita@nvidia.com>,
	Alex Williamson <alwilliamson@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Shameer
 Kolothum Thodi <skolothumtho@nvidia.com>, "alejandro.lucero-palau@amd.com"
	<alejandro.lucero-palau@amd.com>, "dave@stgolabs.net" <dave@stgolabs.net>,
	"dave.jiang@intel.com" <dave.jiang@intel.com>, "alison.schofield@intel.com"
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
Subject: RE: [PATCH 08/20] vfio/pci: Add vfio-cxl Kconfig and build
 infrastructure
Thread-Topic: [PATCH 08/20] vfio/pci: Add vfio-cxl Kconfig and build
 infrastructure
Thread-Index: AQHcsZa5olYMfeIj3Ea06OwpaIoRFbWsZkCAgAgte9A=
Date: Wed, 18 Mar 2026 17:21:34 +0000
Message-ID:
 <IA1PR12MB9030DA60610A425109080614BD4EA@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260311203440.752648-1-mhonap@nvidia.com>
	<20260311203440.752648-9-mhonap@nvidia.com>
 <20260313122711.00007986@huawei.com>
In-Reply-To: <20260313122711.00007986@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|DS0PR12MB6463:EE_
x-ms-office365-filtering-correlation-id: bfe912db-fbec-4765-e22f-08de8512cdcc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|22082099003|18002099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 8+BgajjAO1TddeAU01WfXerEF+MLGTODba+g7OKrHodIPyi3NeHOfhoHMt1evYHhlirtPvIoe+5Y8CMJaSj5G//Nuu1bjaEgG8u/ab7t1+ciuCpfYLc+Vtv3ggJrppJs4PBmMpg5H+woWwTfIINyLdSoi4X9kBXFdiuF/hJcj0xIxA9WalkzzAUHtl7Anz8iw5S3jMN6xDNyPR0JsQEq379vvFxBN7sgOF/IZNAD0dYnTmuBWD1qoMjVaaScwWd6dNK+wSJ5rylatsy6Fztu25cyMk5hgmvutjAtwLSNRswuJmYDXNIxmiaKkEe1/dE5hBNxvtCwytI8ZIn8oYVMx1vQiBWPV1h7eYomwBt+WHpJH2TPeoZd1/4iISfIxyQEwCpSOZOPlabPzZ1WifqZRL7rQQGsH9TXYRbiYGHdZtgM/EdZzpD65sPwyfiUAsujclA6A0pB5bA8we/2OedDsJt+gcnIOY4cZsa1DDAMMoURdM6+C0NMMPzWJdCw/+xTn8zHydAFzbCv2U8HupkB0Ciqv47UjI1LzODza/Qv5uKPBF8ZXBeTLgfxuO2EMis5+sp6gOTsf/u0VsNCoIFzp1hAGi7PL7j1UJz1jGDXdzv72PkAUP49U1zE832nqw1ePzboEblBb2G8W4O3UXRU9xuDH7UtlT/7BC5w54Bvd6MlgvxJqEOzGaJSwvXnB6ifGKKgTaOvO7UcmHzCH17+SqOIq/MgTEI+cBwF3xhZNIUvzjvJdRkDIUn8hG7QP+MRpX3o9KPm4g0dhATEyKGG4igPp3R5H/el8vRzLHNgL64=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BSeu3ynU1iKqRjqfXV6fxavejX5i8O00aMdT0AOfDDGS9qJo3/71tHZzp4Co?=
 =?us-ascii?Q?1LTuedT3Vtg6B8SlE5z3VmzykyuWI/DK9QZ9YxWu1ySGPN6jL91LnRQVly0m?=
 =?us-ascii?Q?BwDK+dZQFK4YFf3DVhpfSGV6D/lB/uIzCi35yWvCr7Zlx516SMGe19jt3imL?=
 =?us-ascii?Q?kVwXAc7e8z07LsDfhTCG1NuhPQMNNVr+1Aglk7t40HqyrhadMmKQ3l6qD4uv?=
 =?us-ascii?Q?qw+axa8p2tNyvVZnlO7/vlYjDtYIpTbuwrdNxiUutGLqYlzDMj4EKkZden1c?=
 =?us-ascii?Q?JBiDojHnR/MvhVZ89Op6OT0ZBq6ZHYayz2iHLo+eCUPQQbYtpkK4f6iayACw?=
 =?us-ascii?Q?vVRQeY76kdxYp3/npntHECl20Eu8lLMxW2KuLLlXGvnS7eQJCdNY38piEoXV?=
 =?us-ascii?Q?LNsxJbzbDBtu8JrP/MX6i9+u2El58h0xp5b7mAh5bi5E2F8aqQpG9T1Z94Cq?=
 =?us-ascii?Q?6NQLdHadoN73j94ZH0kRuWEH7hRgs6XvDyaXbBY/fdTRGlA+Rln4mnR3khE7?=
 =?us-ascii?Q?eqWcET11ZCWxyR577QwCpL0L21ZjrpMQUVUIjrCtQ3iYOE2sRsm/TjmGaXaV?=
 =?us-ascii?Q?zJLSWQfGX/XIY/5vOZetO2SaPYZgX7AH3B3cYg1T2DL5RcEBKIzb/v2Ds6wA?=
 =?us-ascii?Q?bIvyizIRtxnwYXsk4ZhiHgXzWUQkm1mSr1kzspX8rpQSySifrxhCRxE5pJlf?=
 =?us-ascii?Q?Sdp+FPhgBs24mEHsXo6G6GOdwmgbQfOsON7YcF7X/ZDIkuylY6W0GvNqesVS?=
 =?us-ascii?Q?QCCp/V94AElZUnySq/Lf8VyykJ3uFHm1p8mpZgH2UIMWnmxZbSlr/NynwdAA?=
 =?us-ascii?Q?bDFd9ZRfB4xQD3AKhQjYkXMfDPNSVgVbrUrGNxOtnDcUB8UmG8rmW6rt/pqK?=
 =?us-ascii?Q?hhSpUveWuPl4neZ9JHx6n9PllmKflrelcB3+iqe0VC3r0MGut2Ay3LX9hoy4?=
 =?us-ascii?Q?qHzEuvpEbJRUYVmEiZer30szPoyHPEjkRtSMRdAzupINoO0052KSkxd5B1d2?=
 =?us-ascii?Q?aNw8y1w403t1gDlzTMW9u0z755OLMSvH1Pabr8aMup3gLdN9DG7q+M3PBQFk?=
 =?us-ascii?Q?635i6ATTeiEfrOV4rmgP2rFINY3hfT5oK+imT0rS+Dk/gM4gOH6Y6femDnAR?=
 =?us-ascii?Q?rUvW2uo+9dYN7clCT/SOCeTLkJAvctxtYUzNNHdsJHpzXTifJJzfoDh6cwq3?=
 =?us-ascii?Q?eeMuTV8PbkmmpXVoLMUcfOL7S5V1nNGTaeHr98Aq6GvfyYorvissrYa9txuB?=
 =?us-ascii?Q?mmQM195rNZPqqxmsGsPL7t8pPpbkX62YeXiqgmp5JtlRX8L8JZljt0oLhbh2?=
 =?us-ascii?Q?06RytyLq+5WUgAWklPSnAlrXWsMQnY6isfhwTtF5M8KADwKB/n2ukmK654J5?=
 =?us-ascii?Q?1XuCgqYoSxOCVAbZduw210NrEUyirl+am9flYsBqz6Wljgjt0bhFdycyXvmz?=
 =?us-ascii?Q?KbhFHbExw32JJ3VIb9bQHsur7Gley6p+IDp0qUldXeD+e+iaDpTvv760mmbk?=
 =?us-ascii?Q?9Dw4D/M9cZ1PEPCXzdI3fdMFFGyZOdt88xthoNktcca+ahXELRPMJwCoEA+/?=
 =?us-ascii?Q?T1yIa+KMbriXEmdoOwW9e/p369SShScK1BwNkYyehOoUDP/98D+cABuml27L?=
 =?us-ascii?Q?oen/jo2o7Ds9FJgGqO94w7rrLtJsyTgKyW9Vg6xbeKMyqVVhEV5rnNeN/d1A?=
 =?us-ascii?Q?vCoVjJ3enCDX9YilEczl/apQVHi2mxPHYTn8/FsKLVS9j8yI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bfe912db-fbec-4765-e22f-08de8512cdcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2026 17:21:34.1570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z41XR0kS6skV6Y5U/tyrG7COxteWcsWcd4oMakDM7p9+Ss9Ea3yKZ5MUEZwFsyVEW3MNvxOzG1JVTiL2J4iXqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6463



> -----Original Message-----
> From: Jonathan Cameron <jonathan.cameron@huawei.com>
> Sent: 13 March 2026 17:57
> To: Manish Honap <mhonap@nvidia.com>
> Cc: Aniket Agashe <aniketa@nvidia.com>; Ankit Agrawal <ankita@nvidia.com>=
;
> Alex Williamson <alwilliamson@nvidia.com>; Vikram Sethi
> <vsethi@nvidia.com>; Jason Gunthorpe <jgg@nvidia.com>; Matt Ochs
> <mochs@nvidia.com>; Shameer Kolothum Thodi <skolothumtho@nvidia.com>;
> alejandro.lucero-palau@amd.com; dave@stgolabs.net; dave.jiang@intel.com;
> alison.schofield@intel.com; vishal.l.verma@intel.com; ira.weiny@intel.com=
;
> dan.j.williams@intel.com; jgg@ziepe.ca; Yishai Hadas <yishaih@nvidia.com>=
;
> kevin.tian@intel.com; Neo Jia <cjia@nvidia.com>; Tarun Gupta (SW-GPU)
> <targupta@nvidia.com>; Zhi Wang <zhiw@nvidia.com>; Krishnakant Jaju
> <kjaju@nvidia.com>; linux-kernel@vger.kernel.org; linux-
> cxl@vger.kernel.org; kvm@vger.kernel.org
> Subject: Re: [PATCH 08/20] vfio/pci: Add vfio-cxl Kconfig and build
> infrastructure
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Thu, 12 Mar 2026 02:04:28 +0530
> mhonap@nvidia.com wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > Introduce the Kconfig option CONFIG_VFIO_CXL_CORE and the necessary
> > build rules to compile CXL Type-2 passthrough support into the
> > vfio-pci-core module.  The new option depends on VFIO_PCI_CORE,
> > CXL_BUS and CXL_MEM.
> >
> > Wire up the detection and cleanup entry-point stubs in
> > vfio_pci_core_register_device() and vfio_pci_core_unregister_device()
> > so that subsequent patches can fill in the CXL-specific logic without
> > touching the vfio-pci-core flow again.
> >
> > The vfio_cxl_core.c file added here is an empty skeleton; the actual
> > CXL detection and initialisation code is introduced in the following
> > patch to keep this build-system patch reviewable on its own.
> >
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
> Hi Manish,
> A few trivial things inline.
>=20
> > diff --git a/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > new file mode 100644
> > index 000000000000..7698d94e16be
> > --- /dev/null
> > +++ b/drivers/vfio/pci/cxl/vfio_cxl_core.c
> > @@ -0,0 +1,35 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * VFIO CXL Core - Common infrastructure for CXL Type-2 device
> > +variant drivers
> > + *
> > + * Copyright (c) 2026, NVIDIA CORPORATION & AFFILIATES. All rights
> > +reserved
> > + *
> > + * This module provides common functionality for VFIO variant drivers
> > +that
> > + * support CXL Type-2 devices (cache-coherent accelerators with
> attached memory).
> As I mentioned for docs, that definition needs some finessing as also CXL
> Type3 devices, though intention is not the ones compliant with the class
> code as those can be nicely paravirtualized.
>=20
> There is a whole class of CXL.mem only devices with various forms of
> accelerator that never need CXL.cache and so aren't Type 2.
>=20
> E.g. Compressed memory type 3 devices are known to be in the wild.

Okay, I have updated this wording to specify the CXL capable device expecta=
tion.

>=20
> > + */
> > +
> > +#include <linux/vfio_pci_core.h>
> > +#include <linux/pci.h>
> > +#include <cxl/cxl.h>
> > +#include <cxl/pci.h>
> > +
> > +#include "../vfio_pci_priv.h"
> > +#include "vfio_cxl_priv.h"
> > +
> > +MODULE_IMPORT_NS("CXL");
>=20
> Most often I've seen this added at the end of file next other MODULE_X
> calls.
> Whilse we don't have any of those here, still feels like a sensible place
> to put it.
>=20

Moved this to EOF.

>=20
> > +
> > +/**
> > + * vfio_pci_cxl_detect_and_init - Detect and initialize CXL Type-2
> > +device
> > + * @vdev: VFIO PCI device
> > + *
> > + * Called from vfio_pci_core_register_device(). Detects CXL DVSEC
> > +capability
> > + * and initializes CXL features. On failure vdev->cxl remains NULL
> > +and the
> > + * device operates as a standard PCI device.
> > + */
> > +void vfio_pci_cxl_detect_and_init(struct vfio_pci_core_device *vdev)
> > +{ }
> > +
> > +void vfio_pci_cxl_cleanup(struct vfio_pci_core_device *vdev) { }

