Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010027.outbound.protection.outlook.com [52.101.193.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E542315B0EC;
	Fri, 17 Apr 2026 14:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776437539; cv=fail; b=i/aVx2pGT7SSGEKFuwWN+Ooo6iixjaV9boDlDcYZWE3Ib+GeC/Ud5QqSckr9fGfPL5O0SAeB86JgOj8PnkEjvA7xvve2SZ1q1Sel7690nWisJrRJS3sXmXIeqs7jDvFzR8aggxSvmoFWBfDLz1q60cZ0NEcPNahuLsEOj/uvipk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776437539; c=relaxed/simple;
	bh=mp5FxOD5mpaEe/96wdrrdZxPQXrzJZrnbrnJ/pGTQ84=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eK77RqLwSv8lFsaSdvwm+otKJWPz93wW+4A7FQRcAUiPepj3es0zUdLCSjNXm0LRAw723tlyfSd0xSPLLbHjaN6+SlCb1oJ9GPEDe9gtmpOUY8AZk8ztT9PmN0C46xLOsdaI4ReuvsvD53LJUUVoWK63Q/Bc/f70vavye0jEg/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kpW4Pff5; arc=fail smtp.client-ip=52.101.193.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kpW4Pff5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HjiPeGDqABzGZHKAzfLY8eaWZv268JoMfUMIEVegH3kskGR0D7VgQSO4cZlMrM/GHc/VuxqmDys5daC2PnQgvtBG/SuSM5kzzgENv1Jz9bsvyS842/tNOik/WBzxKCgdQZc5m6fi5903Vj8A9iVR6e6nzf7Bvwoo2arH9awKQHvCezUjRHW5dOXtKTujkt63f94hyTI9dZ6y7DXzKXKvtRiDi2LjbMSZ05RnUgZRlBUsOQFEs/UYwaWoJVrF7eR0G3fc3a3ddswD8kIAifhvADP/kqjc6ZgqrmEyLL7YRZ1D3o8mv6Ia7eS7YhHNE2s120fjUzWFaIBeZkAZR6SiYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mp5FxOD5mpaEe/96wdrrdZxPQXrzJZrnbrnJ/pGTQ84=;
 b=Nab3xzn+I0f++OP+8nPQI8kAUoncicbuxpVh2K5i46XrJRMMhI2C63eWQqAmQNvWnItCIdrCdWEad534QyHmieHAWUBsNF3Br1/RvCi24pRMXVPYN5iXjFATx+tSKwGVY2wUpNz1FB1AqLOHSDhZ1Mic8KugcW1dOMgiPRqJMU0wecu3RdI9+P/WMHZ0O+fTZ/76nQZVkHHSGbekuk+hMc4uGclmRh8MAOxWhagJs3KmCOcFixuanGtJwP3OuFrs4gsAU/NgQ46iWssG9wJ6Q+m79CPnH4v5gIcXKiFFyL5dTcW4/wz+87egTSPDmBN8For2jKhPC948hueRwWhT6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mp5FxOD5mpaEe/96wdrrdZxPQXrzJZrnbrnJ/pGTQ84=;
 b=kpW4Pff5lPDPQCdLDVurVEJ//DXHYkuEEom0Uo6ubjbMYgQXGKeBmpwxrwYkZ69dt6vSQ7yRGyF4sNnGiOGLLTzrx2LWABoA58NdkI4vkGSz+PAuqCQ+QDX5ziKkqy/9bmw5hUIFzX4ZB6INDxKKWCOhUVk62aMMhgRO0AW4tYRRowF5z+YP7fC9dMAkKGetmerzch+m9ImXo6bRVCgV4LT/lWO68HipNKSO/M2cWludNV8P1DQA7NlWPGelUHTw/SNJYXYVF4KqIBMnZtu4bLARLaRaW7H/IRCVilAwZTFU2LkKG7zVZEh+B3PufDGgaK+TGZX4mApSy4uf1XRKAw==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by SN7PR12MB7980.namprd12.prod.outlook.com (2603:10b6:806:341::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Fri, 17 Apr
 2026 14:52:13 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%6]) with mapi id 15.20.9818.017; Fri, 17 Apr 2026
 14:52:13 +0000
From: Manish Honap <mhonap@nvidia.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Dan Williams <djbw@kernel.org>
CC: Alex Williamson <alwilliamson@nvidia.com>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alejandro.lucero-palau@amd.com" <alejandro.lucero-palau@amd.com>,
	"dave@stgolabs.net" <dave@stgolabs.net>, "alison.schofield@intel.com"
	<alison.schofield@intel.com>, "vishal.l.verma@intel.com"
	<vishal.l.verma@intel.com>, "ira.weiny@intel.com" <ira.weiny@intel.com>,
	"dmatlack@google.com" <dmatlack@google.com>, "shuah@kernel.org"
	<shuah@kernel.org>, Yishai Hadas <yishaih@nvidia.com>, Shameer Kolothum Thodi
	<skolothumtho@nvidia.com>, "kevin.tian@intel.com" <kevin.tian@intel.com>,
	Ankit Agrawal <ankita@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>, Neo Jia
	<cjia@nvidia.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>, Zhi Wang
	<zhiw@nvidia.com>, Krishnakant Jaju <kjaju@nvidia.com>,
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, Manish Honap <mhonap@nvidia.com>
Subject: RE: [PATCH v2 16/20] vfio/cxl: Register regions with VFIO layer
Thread-Topic: [PATCH v2 16/20] vfio/cxl: Register regions with VFIO layer
Thread-Index: AQHcweW3qEQZGUYksEezJvXZTdKFmrXNvlWAgAGGhwCAAAwfgIADT4+AgBDOwnA=
Date: Fri, 17 Apr 2026 14:52:13 +0000
Message-ID:
 <IA1PR12MB90305B038F2A088F31F56767BD202@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260401143917.108413-1-mhonap@nvidia.com>
 <20260401143917.108413-17-mhonap@nvidia.com>
 <69d0169115c06_1b0cc6100a5@dwillia2-mobl4.notmuch>
 <20260404185330.GD2551565@ziepe.ca>
 <69d1685538f45_556821002f@djbw-dev.notmuch>
 <20260406221025.GH2551565@ziepe.ca>
In-Reply-To: <20260406221025.GH2551565@ziepe.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|SN7PR12MB7980:EE_
x-ms-office365-filtering-correlation-id: 8a5a03c4-2f9b-4795-3f42-08de9c90e936
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|18002099003|22082099003|56012099003|38070700021;
x-microsoft-antispam-message-info:
 A3DR2XrFfi4NsfD3+Im7+qpK9BOD9ps7mcyIvlMsDZEaBnEF4VgCa1hrgEd2EEVElR8s6D5uKQeXKidINJvQ/Rr75XrZUqUG7iQhiFAubOmO+sAvmNSLbjKN39k+Okdcmzsv3HwViwo1ZD4ECPt8KCwCLJI0IB9Rpyw6ruXUtMwTyMWDn9KxUgQ87oh+i1cpAdjnghheEsVkBNeI6rZ3Hc9xVE33LVJKqDU7oe5RaSaTqrtN3ascgRO7M12E62dJSf77DFD06qxJDl1DC0DbsN3WcfNFmWO12eW9hIvhiKpPEe2hKoTfI0Q0Eo5pnw+EdBThaf8rqkfL8lJsLVjys9TzR7igt4QmjwW2ZAdOl5h6C0QmujXbu7hb06tOT2B/ZYkn0qpy2d92ILHSHZUZ6fjRPgeZF9WTGyP4ICJBguR674sgKQDtZe4kYNKQWhOdZ1NIW7jkCLvtroKbs1NzCga2Ue2wG7/e8Ic2E2aJRvtRmv/AptoIg6YglrXM21DfZtiJ5quR0EG8nd4d3JZ6d0AlWJnkFx9zKCrhoYOpBEfMAgT4DdCjEoYT025PcxS5u8auRnWzSdQy32rWroEsSgCSrip5eDLY/6BIuxanPWGPf3bB7XXq9ZfZTatbgPYV4R89dD9PH1ezP/rJR95AKtPYqYbD4QLngjptCnmmj6zMq+9HjnJ1EG67/cPe/8P49iV4ZB8XgcnKCyF6+DMuAjmcq0YRFdUOX+sSM4RjJij/ohYzezYfFB/DyrFBNdSXHcMLwETt2ZRrhDF5vYWW7LLw2lu1Z+pGbXasO2VdJgQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(18002099003)(22082099003)(56012099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TTYbAh3+69Q/18rJ7fCOcRAkkhGjEp3XoUD88FWtrSu80UASkRJpBvpPP2QL?=
 =?us-ascii?Q?2Jwhg6eCiZ9cT24zHKT2uW07eU7jOce7U1b9aHpzT4Q6CrvYjynD2hYNWmu9?=
 =?us-ascii?Q?GW7QeO8UJ9go59lA+TJlOKhW/VQksGmJ8TbbVTiKcjHSoCmpJATrSnw9QY7A?=
 =?us-ascii?Q?xI0Wse/1rEZA4vvqU4hd1NENhgDeTqJ5egw03WSvkY3NCwuz17oy/+N0VKiL?=
 =?us-ascii?Q?qPOlEYhE1ypAdGG9hRupyPJFsnMUgTdsKrT3c8a4bQtaCVmjU9UvVwAdDEFc?=
 =?us-ascii?Q?syz+a2rRwt6/XcCSViNX225/+5dTZPyGV182dUHHRNzYhl0cTD+dDdybL//2?=
 =?us-ascii?Q?TFkYPkG+j2aH6iPhmYl3kdO5zpyeOt35YN+q1tWLpkTykcLw/oQX85Rz1UV5?=
 =?us-ascii?Q?bmKhsUxIRs6T36AQFLOPzkX3ybaUUnf1ufZ2ZI58OjMtZDTGYowMcG9wk6Qt?=
 =?us-ascii?Q?itihiTFanoYsTiqvCrcG0D3thavwY/73pwJLR/8uh5oD1wIp23hO+UTSeLUC?=
 =?us-ascii?Q?YWPCbbgFv6g9eRWA+nMi4vd55SI9JqVXeghpQacbORdOjzxF6PHFsgbGIaAh?=
 =?us-ascii?Q?KdV/nBmFXkSnWYSRrucGeN1d7NCw6NzWDUT+bDjRGpjM3F+NEkg84+tVhBzV?=
 =?us-ascii?Q?mAM4rSbapTrDeKl+tjbgYTEAUhgiInrD1OfCcLKeRncGrZAYYUqDSY5zeIBu?=
 =?us-ascii?Q?ls7yBywepkk6m007gTWQHtmCDl3/4Byv9yFVU3CorPzmJBmaUuGbSEpbFdcH?=
 =?us-ascii?Q?qy+wpR51wjMdoxzR3x4JoxelQzCqd9EtPyHDfPYKpletQpAVhtIrGwO7ezXZ?=
 =?us-ascii?Q?OglgXRo0Wg3sEqAKPY7Di8hTs5yrxHT7wFYDWDGl6QnE+tKEMBoUsxhDnujD?=
 =?us-ascii?Q?sSkSPP9RdRP+GWrF30Lk/PhNhM0b41NossafHaefN0o6YTjbCqiCkOmUS5CU?=
 =?us-ascii?Q?fPaq93znGVSVmMHhfhyahGu0ZK2wE5o/WCQhE0ee0LvdFg+NUVpsCaHtYZWO?=
 =?us-ascii?Q?ifZswUdhPj+rrcMccWZzmY0yGkeWt3hs1uWTimioSlJge9khhKT7fbDqHkQ/?=
 =?us-ascii?Q?eXkwTP6vXlKQSz+NTx9juC8ZQ2rNHTlc7U9wnTc8Rdf9LIqvgL0r87LH/dip?=
 =?us-ascii?Q?aELE2+4G0JSjTd/h7Z/7ifMrQKCsdQgeOnwuXABwMoEW+zcuCsN7lerVquco?=
 =?us-ascii?Q?D9gK3KMtGoewGSLP2sIAB4g1zHpxV0T1en6eAlRWs4/7g0e3EokfIQXPj/6d?=
 =?us-ascii?Q?2ZF4Cvj2CdhJkAGn0NEKLlJ5HFThN/4nN3LqTlJoqQS7/ZP64Se7Eg3t5Zqu?=
 =?us-ascii?Q?fr+tUleMkxA5+VK6VXIM9MW3fjW1akHElPlFFyi8uHpSt5Z99r5KafkBwM5I?=
 =?us-ascii?Q?Ft7gJIEOTpmDoWdc4MZIvxjg/WcwThG+JCpO0aMc5BwBxXIq1ZL5bmbrhewe?=
 =?us-ascii?Q?BvMNqTIAdbBchDTDM7i1qyHqOUiW1C7/8fGRZRRkVC3Ra64qQOZt4ULcFMTL?=
 =?us-ascii?Q?k0GqhQxGamoxutYfg510NC7lJ8Sr2Tw9XoE52kiTLk37kmnaCfQFzpd9jgnD?=
 =?us-ascii?Q?SyWC6cc6MPd89PeqL1On1SxzeqnXxmQBwq4eH0iuIfl/TS65SqfbRAk2Whgg?=
 =?us-ascii?Q?P0IR93jJUfM8rAlHDiFk9wUf43hW7ri5CAyNMHTeCcbht3lpFNteXKQOHXWs?=
 =?us-ascii?Q?+uoszuxKeTe9RKTQw2sXOx2iDP3b7moG/U1XKj0Sbl0BBXkm?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a5a03c4-2f9b-4795-3f42-08de9c90e936
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2026 14:52:13.4666
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NNbsejzV+pQvT9Jg5Ns18hq0BEfYx+FCsXMUioakR4oj9VEXTqxKS2Oy86F249T7e9w0h9X19ltncsBfcl0FJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7980



> -----Original Message-----
> From: Jason Gunthorpe <jgg@ziepe.ca>
> Sent: 07 April 2026 03:40
> To: Dan Williams <djbw@kernel.org>
> Cc: Manish Honap <mhonap@nvidia.com>; Alex Williamson
> <alwilliamson@nvidia.com>; jonathan.cameron@huawei.com;
> dave.jiang@intel.com; alejandro.lucero-palau@amd.com; dave@stgolabs.net;
> alison.schofield@intel.com; vishal.l.verma@intel.com; ira.weiny@intel.com=
;
> dmatlack@google.com; shuah@kernel.org; Yishai Hadas <yishaih@nvidia.com>;
> Shameer Kolothum Thodi <skolothumtho@nvidia.com>; kevin.tian@intel.com;
> Ankit Agrawal <ankita@nvidia.com>; Vikram Sethi <vsethi@nvidia.com>; Neo
> Jia <cjia@nvidia.com>; Tarun Gupta (SW-GPU) <targupta@nvidia.com>; Zhi
> Wang <zhiw@nvidia.com>; Krishnakant Jaju <kjaju@nvidia.com>; linux-
> kselftest@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> cxl@vger.kernel.org; kvm@vger.kernel.org
> Subject: Re: [PATCH v2 16/20] vfio/cxl: Register regions with VFIO layer
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Sat, Apr 04, 2026 at 12:36:53PM -0700, Dan Williams wrote:
>=20
> > Then I assume it matters that memremap() sometimes silently falls back
> > to the direct map. The "VFIO owns" expectation needs to guard against
> > some helpful platform firmware mapping accelerator memory as System RAM=
.
>=20
> I don't think how memremap works under the covers matters to vfio, it
> takes in a phys_addr_t an gives back a KVA that is cachable kernel memory=
.
>=20
> We just have to be mindful to not allow mismatched attributes on virtual
> aliases.
>=20
> > At a minimum having VFIO fail to map in that case helps with the
> > argument I have been making that "no, EFI_CONVENTIONAL_MEMORY type +
> > EFI_SPECIFIC_PURPOSE flag" is not suitable for accelerators with
> > private CXL memory. Those want to be enforcing "EFI_RESERVED".
>=20
> Certainly it should fail the request region if something else is using it=
,
> so if those EFI flags plug it into the mm and it is plugged when VFIO
> starts then it should stop.
>=20
> The direct map isn't really "plugged into the mm" but it does raise the
> mismatched attributed issue.
>=20
> Jason

Thank you all for your suggestions.

As pointed out by Jason/Gregory, the whole design presented here is
VFIO owned device regions + mmap + vmf_insert_pfn (patch 14) and registrati=
on
at vfio_pci_open_device() (patch 16), Lazy fault (vmf_insert_pfn), zapping
PTEs on reset.

I am convinced on the memremap usage as discussed. VFIO owns the physical
range exclusively: no struct pages are involved (vmf_insert_pfn inserts raw
PFNs), and memremap(MEMREMAP_WB) gives the VMA the correct WB cache
attributes.

As suggested, I will add request_mem_region for memory range and a failure
message if we cannot request mem region at probe.
This will also catch the EFI case: if firmware marks accelerator memory as
EFI_CONVENTIONAL_MEMORY, MM will claim it at boot and request_mem_region wi=
ll
return a failure at probe time itself.

I will also add a comment in next cover letter explaining why we have decid=
ed
to use memremap and not ioremap so that the decision we have taken in v2 is
entirely clear at the start of review cycle.

Manish
