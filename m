Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6ED912BF24
	for <linux-cxl@vger.kernel.org>; Thu, 13 Feb 2025 07:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739432112; cv=fail; b=M/bawwC1A9Y0vc/qRxFq99FCs6HbF6z9LhpPxJexVhWDLcmt0zbQ9QZfeppe4mV3sug7QypE4EfhpBfNcGb0qwXKqYUGeloXEHkFLlMB5WfP/Qz+dfY6R6ejztNfrkIQGHZdIUWKtYcnIxEfivGZQDB1syydLmQQvcVSeRKiJ5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739432112; c=relaxed/simple;
	bh=kw3F9NdEkIFBpwDiDzx2mo/SFnhGOz35pJRaP3gYCL8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ohe41HC209Iz1yqxgdEBaewRuv9HuBdJRtm6ciaX5TqZ+cVaRuEJYC6H0jqmvk9+5VPtBxKndbQyR1NSaQmvq51m5CekVAkQRPe6d4El+pfiE6yeYfymcQvoAwda4VXE3+RYW+tVjWJcbli2TyVrLncEBygqm5DU720QFf55yu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UzPCHCYh; arc=fail smtp.client-ip=40.107.93.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UzPCHCYh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YWgpMWuyAZKa4XdS3zPDC5ShZx1HNQTcDVjxc9rMF4J4SVv2UI1WjYI+5L4X2/SlcXye8Uqawac3ZHdOM3Rtx+gK71wi/EBsvSqoRkbLjATlSxy38p5+wBPVCpzKSCDFcU3U+xf08kh4Y+7w2ZI696c5THVeynxIQdzV8P7Lc5wuzDk76c/voZ2sUnvS7naWc2N8PFwTsct0304LrIB6D/Y/VvQn6jSLnTPSGvQ4d5oU4Epa6joFyNQ795fEWCgEbcyK+WIMpe3EqvOpcXR9IDvb4cKud6jWwmKIHOOxaoqdjz2cev7+ZbaZ686rQEj4EL+o95OxQmfKvySFMiXqqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8tJ5RMpwpBRBC4jlyzCgT2lehPJ+/wc1XJFKLT1i8No=;
 b=poyAnzrkLB94AgSoF3iQVhPbYhnN4+Df3clHAIIaemayBFW2JGfpIFu6clHokWFWnQJ3d5O2qavq+HT3OOS1FViiLmpKzExukeK52vRtv0cdTMdxPL7ujKFigtGQUigy3JCn/mhP7Ls4o4PBEf0R7MAksHojV5Jlo7FniR4NjAk3wueSTNBKIps9pHSy2w9p6/w4UzOE0Rf3A6wPzvNdy4Vtx6VpA6dxsoPk6dp49FIF5jkjLB/FbIWFwsp79+ifnQL9CPLDmlEYTE3F5B40sZV1boHrI0z0sumT1t5H3PTwal9f5AejAEAXwVAkXafJpdCxThsFTSerAwPgK3tzbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8tJ5RMpwpBRBC4jlyzCgT2lehPJ+/wc1XJFKLT1i8No=;
 b=UzPCHCYhV4eLhLZ9GskcUiL7euIS+AGmnZbVmnZ+7JvrRKMUXrcWchQz/uUkbtzIYl0IqDbOu1/Ru/+eE1cNH7dmAE6YsOsVRJ9pVuIZTjN/rar+Oeosqu4gJadNBq1u0MXjkbw0IARuZQ3JRnVzWBqGICNCuh+/Uqrdc6EhaWehIK+/4MXj7lsCpV+7Si/KtDEhjY/Rr4R7DDPgEEvjBI5Tv4qyV9T4JZWVkaWne4QkA0uBKNzsvll2oDeds8jojoAigOLgjkB+Ga3fzs9/EWZKCt2Pp3A0unTSHt/PwTbpS7nOtLS4eOieoeKtawfUH3RSln5oAPFNgYzYFP/yOA==
Received: from SJ2PR12MB7963.namprd12.prod.outlook.com (2603:10b6:a03:4c1::6)
 by MN2PR12MB4424.namprd12.prod.outlook.com (2603:10b6:208:26a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Thu, 13 Feb
 2025 07:35:05 +0000
Received: from SJ2PR12MB7963.namprd12.prod.outlook.com
 ([fe80::c716:516e:5f3c:cd85]) by SJ2PR12MB7963.namprd12.prod.outlook.com
 ([fe80::c716:516e:5f3c:cd85%3]) with mapi id 15.20.8445.008; Thu, 13 Feb 2025
 07:35:05 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Ira Weiny <ira.weiny@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>, Dave Jiang
	<dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>, Vishal
 Verma <vishal.l.verma@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	Alejandro Lucero <alucerop@amd.com>
CC: Zhi Wang <zhiw@nvidia.com>, Vishal Aslot <vaslot@nvidia.com>, Shanker
 Donthineni <sdonthineni@nvidia.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v1 1/1] cxl: add support for cxl reset
Thread-Topic: [PATCH v1 1/1] cxl: add support for cxl reset
Thread-Index: AQHbeT866Aw7Tg8YnUuaiXuiaRS3l7M8FWaAgAjKfW4=
Date: Thu, 13 Feb 2025 07:35:05 +0000
Message-ID:
 <SJ2PR12MB7963F8F9F215F55087D38F77C3FF2@SJ2PR12MB7963.namprd12.prod.outlook.com>
References: <20250207090327.172478-1-smadhavan@nvidia.com>
 <20250207090327.172478-2-smadhavan@nvidia.com>
 <67a63fcb6350_32b9f22943c@iweiny-mobl.notmuch>
In-Reply-To: <67a63fcb6350_32b9f22943c@iweiny-mobl.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR12MB7963:EE_|MN2PR12MB4424:EE_
x-ms-office365-filtering-correlation-id: 9ca3c71b-0e78-43c1-5991-08dd4c00ef4e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?4zP4svDH1Xg7X1fQcakla6xKwKAFKbhByBpsxZfj3vhNV56zhJPUYoZHyZ?=
 =?iso-8859-1?Q?Tp5xSobkC/wjgPWqVJfXybiBNu0nbaJVrui1YOvy/Y0ab1NF9HYm5VGFSR?=
 =?iso-8859-1?Q?OGP1a5CplbR4ejEoZyvy2hMOITLCwonFuQNJYoJL2hWC8SQQ8yMKQK8ARG?=
 =?iso-8859-1?Q?nNFINZ7nPZLLjdPRi4Nq/TWwD4nhyYj2WHCxMVI9EmaqEGmSaEPtqzzKzw?=
 =?iso-8859-1?Q?HqflKcCPsXDNfeywqUi1CVoIBcH0HZW4aINbvF3yZceou7Dv0OTtgac/q3?=
 =?iso-8859-1?Q?Kale4cfpNsG4v2IdjkiNYO47Sitf68HFTcyTIsVl9HAP4VgblqnKGArN88?=
 =?iso-8859-1?Q?fdympDVPigG0iXXfXdySkeeB0pQ816sWq2WezdaBi6rLM8tJZycvdyGpLC?=
 =?iso-8859-1?Q?snDzOp12TjXUZYpwSk7e910fUvwFoJGAPqJqDbfkOSVTvY72Ml6BScnHnV?=
 =?iso-8859-1?Q?jlHfktGXCRHhs8smWldncppQ2+nxpWY+JAsySUHDhoc5dd/46LaZgxncKG?=
 =?iso-8859-1?Q?CRLUbSaok/I1ySHXPqxWITNJ3bfLS80WJYyCkns6zbDNVgM5jNiUowq3Wy?=
 =?iso-8859-1?Q?Ozclg+6tW745NnhtWZVTTOW2U9vqLbIp6VaNPEZqXi4KOOo2AJzsBeTlZw?=
 =?iso-8859-1?Q?D+3x9U4136xua2RA0V8e4WztPtM00q2WPeQ4ZnA4fexHuBeui19GQEIfSh?=
 =?iso-8859-1?Q?0jRJ67FTFyBMOm7JzpetR843TPycakU72tXAVOp8c//Yn0qETvm94XrUDp?=
 =?iso-8859-1?Q?AJMEDF3DGxjy3KfNq1O9myMAGNjBTjNybX3j/wJNqFe2VGJ6Z244XVEBpI?=
 =?iso-8859-1?Q?ax7i18Aepe0EuexN5KXO9lPSBB4v0cUF3scYMpRE3sFNx54ADKMr3lyX0e?=
 =?iso-8859-1?Q?FGJsbYHqdOUqD72MwykIjGmx0N7mQ6wkis/ETeLwYGoJfjVBsKWOz+IRPA?=
 =?iso-8859-1?Q?kLRSctGhw2eVRQ/3txN1AgM21TQo22uZjVzcEOSi629OSyfm0b96rQo4w8?=
 =?iso-8859-1?Q?AQdI5ZokkXril2kQ44h5WF3hcUJ/gzJsFCULVBjOLFKGw9U473UeIlhuZK?=
 =?iso-8859-1?Q?xHyGwqBvTzpX1//R8w/TbSFWVrD+mV4uOudsmO/Hff7yEwllZeM8qmQrDt?=
 =?iso-8859-1?Q?4iLr9h7vbbSb98ZUGokZJUy8fgRCGypZ6mZ2OLy9tg7hrgeoWza6/j149h?=
 =?iso-8859-1?Q?mHLJWblxbX4iaJ/fkLCZgLGdH7aHfYZIsjDOPk+uDkIuqY3Tcc1fFJ2nU+?=
 =?iso-8859-1?Q?+y9+yjKbhCG1zZAjT8qhZZUOmZLDJXGu4+jaerhoeaTJZfDusv/+A7vmoX?=
 =?iso-8859-1?Q?DvzlY6CcCrSyhj/TfgEG4DpdW9csWqtBtMfzOS82jdYdGxdn3/nCkCoy+0?=
 =?iso-8859-1?Q?UWg5bBiIxwqSwAZoSxtZAv3VpZm0iu+3KOxF2tXLWw46xSzfb3qR4khsBT?=
 =?iso-8859-1?Q?XyY4hIty25gfCSHgyoxsE3rhzE65Je8RFPGPKv5LHLwZgB65vork5azcvX?=
 =?iso-8859-1?Q?GqiWQbx46iO5SN+TC1i0RS?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB7963.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?MmJNxycLt7LkKeZfMI6oweX5UqdqWPy8gEeweerZ8ogOX1CaV1gioQ1uiZ?=
 =?iso-8859-1?Q?NZcQZdxpJNFy2mYh+ouGBl4uf9a+uDsnkAIfU+HELKCMAzBv29nS3VqNN5?=
 =?iso-8859-1?Q?lAZ+kkKi6VCy46avwSsUOltydcM/qNPzGEFgt+BQQaDNWjzDI4sxYm+wLU?=
 =?iso-8859-1?Q?+g6M0CTcUYf5bb1cFz9jnM454I1cxELRSftIQhHgUYnRn0GIpM/5BRkDku?=
 =?iso-8859-1?Q?aNVvnwtaY3i3RwuW5n/u7BWZ1Pijt8VUVznBPK6ZtJhcV5/rAF0+btFXYu?=
 =?iso-8859-1?Q?AYXKRzsteswSzrRrqfx6gRmZoUEedGIUPZbLeb3EnZeQGqYgWCji8JHRHQ?=
 =?iso-8859-1?Q?gA+lrug7n9THscf0WSvn/4Qn6eAUKqrRF/JeN/4odW3V326TAo4ulce7DG?=
 =?iso-8859-1?Q?SwnBXFpUe+6TnKuM3ptzbMEIu6PquZxc6sTrsVGu/uH1WeeXyv9XEPZpRO?=
 =?iso-8859-1?Q?mSRrJwwgragmOktPOsVKUmdKeeTQUeICfp2kRyf3DblwYWvbduBa7pY2ri?=
 =?iso-8859-1?Q?lLM0Kwni7Ta9IrLZ1GxK1jxWtuKfJqjblAaG3LpQuSL9MQWaJT+Kr3WR5g?=
 =?iso-8859-1?Q?VWOOHImkw1he4GxANDSlEM40aBdxzqHannyJ4JN1BMt3IJMFYVSxhafGV1?=
 =?iso-8859-1?Q?eMFfu+01SoARfpr9sFFEMsY7Kyt/1JcbKOZnfD7HQTBw1urSo6Pie3U0xc?=
 =?iso-8859-1?Q?M6BDeRLE6tUB0naZKCSnjoxrijYqnUDGroeamh6z7NKZZf19C9h/58h5IP?=
 =?iso-8859-1?Q?CaErz+FAvkw4XsVvpr6HUKPNBT3olwTwCRjOmuFRNxPKNvRvPauJabiCIT?=
 =?iso-8859-1?Q?74pgGEuW487uJ08Wqr8pSr/W1k3vBs01xvkMtLFC47UMKRYFJwniNSsZ0h?=
 =?iso-8859-1?Q?vh1CkUwyMIYm7hp+yo+k4dUTZQ5SroI/BvFtE29D4psSzv5VX9GVtclP/H?=
 =?iso-8859-1?Q?6EE1aqqt8+Xc+Q2DgO3O0yor1jEB3AjzUokE0hDm7xpa1kTS1Tp4adPup+?=
 =?iso-8859-1?Q?qvs2bNmWk3ymJvFC1sB4ua3/UdVXLro2LXCi5CQ76gwDUXu4LlAJy7/TDv?=
 =?iso-8859-1?Q?l3gBoC3KtkTm+Ly6ZKuhRv+8+6MQnl9YkrORCEADH0SnZRxZRhjhYmQdt+?=
 =?iso-8859-1?Q?hWFezEpiuGKGPJgLoe1+tmGU+m2ea0wAN4Jmf6Jwf88t+JkcViYfJSdQE9?=
 =?iso-8859-1?Q?6jduPtnOTuxUlHZomGgWZI01G54MdQBNHjBTRaOrG6B/bf8g2M0IRiw1Cp?=
 =?iso-8859-1?Q?bVjG++G49sWd891hZ8J3LUFaexIv5zfqVi7a71cQkiIbYyXmbwqvqqzc1u?=
 =?iso-8859-1?Q?TRoa8x1AM9p+9qbSas0ZmboQFMBHpsp0ZX8rlIe8pSUcKFDWmAb55Yywiq?=
 =?iso-8859-1?Q?F5KRBQzpqEVyFdw9WkdA9Kxtqbceo0Yez8SmksnBFhH9Dm4Lb5qQblqe1I?=
 =?iso-8859-1?Q?kRBrWCkd/+6otWKdkXL/RnqxmFk4jLDcH8pgAKDPnBOIaXsiLH6vrFY3Cc?=
 =?iso-8859-1?Q?tqCky3XvEPyj8HpgXiB+vFP9O6MjYSJ14mjnZ1jZagWArCETcj22PvKEne?=
 =?iso-8859-1?Q?y+ci6RQFlN4knXtaM87UXw8wkguYcmMisG212qDgjzY1reOcamJnPicOqG?=
 =?iso-8859-1?Q?PQAIL0e5In5Dk6iXqLcfA94/Q8+L9gthO+?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB7963.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca3c71b-0e78-43c1-5991-08dd4c00ef4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Feb 2025 07:35:05.4826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vGBuATwpNqMhqEHQHLYGeKdAJND82Q+e3JYr+ju/KqEQlK6dlQHw7PsVkx+dNJMcunLiF+cHm5NO0Ggc3QF+Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4424

@Alejandro,=0A=
It would be nice to get your "Tested by" before the next re-spin.=0A=
It would be really helpful to see how the patch works with a type 2 device =
changes you've added.=0A=
Will that be possible?=0A=
=0A=
Thank you.=0A=
=0A=
Regards,=0A=
Srirangan.=0A=
=0A=
________________________________________=0A=
From: Ira Weiny <ira.weiny@intel.com>=0A=
Sent: Friday, February 7, 2025 9:15 AM=0A=
To: Srirangan Madhavan; Davidlohr Bueso; Jonathan Cameron; Dave Jiang; Alis=
on Schofield; Vishal Verma; Ira Weiny; Dan Williams=0A=
Cc: Zhi Wang; Vishal Aslot; Shanker Donthineni; linux-cxl@vger.kernel.org=
=0A=
Subject: Re: [PATCH v1 1/1] cxl: add support for cxl reset=0A=
=0A=
External email: Use caution opening links or attachments=0A=
=0A=
=0A=
Srirangan Madhavan wrote:=0A=
=0A=
Generally this looks good.  Some minor issues below.=0A=
=0A=
> This change adds the support and implements the CXL reset=0A=
> steps as laid out by the CXL Spec v3.1 Sections 9.6 & 9.7.=0A=
>=0A=
> With support for Type 2 devices being introduced, more devices will=0A=
> require finer-grained reset mechanisms beyond bus-wide reset methods.=0A=
>=0A=
> This change defines the necessary CXL DVSEC register macros.=0A=
> For devices that support CXL Reset, cache lines are disabled, WB+I is=0A=
> asserted, wait for cache invalid status, Mem Clr bit is asserted and=0A=
> finally reset is initiated.=0A=
=0A=
This commit message should be in the imperative.  For example:=0A=
=0A=
"Type 2 devices are being introduced and will require finer-grained=0A=
reset.=0A=
=0A=
Add support for CXL reset per CXL v3.1 Section 9.6/9.7."=0A=
=0A=
The rest of the details are given in the code itself.  BTW why not just=0A=
update to 3.2?=0A=
=0A=
>=0A=
> Signed-off-by: Srirangan Madhavan <smadhavan@nvidia.com>=0A=
> ---=0A=
>  drivers/pci/pci.c             | 183 ++++++++++++++++++++++++++++++++++=
=0A=
>  include/linux/pci.h           |   2 +-=0A=
>  include/uapi/linux/pci_regs.h |  25 +++++=0A=
>  3 files changed, 209 insertions(+), 1 deletion(-)=0A=
>=0A=
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c=0A=
> index 869d204a70a3..cf6009f5bd6c 100644=0A=
> --- a/drivers/pci/pci.c=0A=
> +++ b/drivers/pci/pci.c=0A=
> @@ -5026,6 +5026,12 @@ static int pci_dev_reset_slot_function(struct pci_=
dev *dev, bool probe)=0A=
>       return pci_reset_hotplug_slot(dev->slot->hotplug, probe);=0A=
>  }=0A=
>=0A=
> +static u16 cxl_device_dvsec(struct pci_dev *dev)=0A=
> +{=0A=
> +     return pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,=0A=
> +                                      PCI_DVSEC_CXL_DEV);=0A=
> +}=0A=
=0A=
NIT: probably not worth having a whole function but...=0A=
=0A=
> +=0A=
>  static u16 cxl_port_dvsec(struct pci_dev *dev)=0A=
>  {=0A=
>       return pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,=0A=
> @@ -5116,6 +5122,182 @@ static int cxl_reset_bus_function(struct pci_dev =
*dev, bool probe)=0A=
>       return rc;=0A=
>  }=0A=
>=0A=
> +static int cxl_reset_prepare(struct pci_dev *dev, u16 dvsec)=0A=
> +{=0A=
> +     u16 reg, val, cap;=0A=
> +     int rc;=0A=
> +     u32 timeout_us =3D 100, timeout_tot_us =3D 10000;=0A=
> +=0A=
> +     /*=0A=
> +      * Wait for any pending transactions.=0A=
> +      * Assuming this does cxl.io stuff.=0A=
> +      */=0A=
=0A=
The comment here is generally not needed.  In particular the first=0A=
sentence is the same as the function name being called.=0A=
=0A=
> +     if (!pci_wait_for_pending_transaction(dev))=0A=
> +             pci_err(dev, "timed out waiting for pending transaction; pe=
rforming cxl reset anyway\n");=0A=
> +=0A=
> +     /*=0A=
> +      * Disable caching and then write back and invalidate lines.=0A=
> +      */=0A=
=0A=
I think this comment is wrong...=0A=
=0A=
> +     rc =3D pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCAP,=0A=
> +                               &cap);=0A=
> +     if (rc)=0A=
> +             return rc;=0A=
> +=0A=
> +     if (!(cap & PCI_DVSEC_CXL_DEVCAP_CACHE_CAPABLE))=0A=
> +             return 0;=0A=
=0A=
Isn't this checking for a cache capable device?=0A=
=0A=
> +=0A=
> +     /*=0A=
> +      * Disable cache.=0A=
> +      * WB and invalidate cahce if capability is advertised.=0A=
> +      */=0A=
=0A=
Then disabling and invalidating the cache here.=0A=
=0A=
> +     rc =3D pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,=0A=
> +                               &reg);=0A=
> +     if (rc)=0A=
> +             return rc;=0A=
> +     val =3D reg | PCI_DVSEC_CXL_DEVCTL2_DISABLE_CACHING;=0A=
> +=0A=
> +     if (cap & PCI_DVSEC_CXL_DEVCAP_CACHE_WB_INVALIDATE)=0A=
> +             val =3D reg | PCI_DVSEC_CXL_DEVCTL2_INIT_CACHE_WB_INVALIDAT=
E;=0A=
> +     pci_write_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,=0A=
> +                           val);=0A=
> +=0A=
> +     /*=0A=
> +      * From Section 9.6: "Software may leverage the cache size reported=
 in=0A=
> +      * the DVSEC CXL Capability2 register to compute a suitable timeout=
=0A=
> +      * value".=0A=
> +      * Given there is no conversion factor for cache size -> timeout,=
=0A=
> +      * setting timer for default 10ms.=0A=
> +      */=0A=
> +     do {=0A=
> +             if (timeout_tot_us < 0)=0A=
> +                     return -ETIMEDOUT;=0A=
> +             usleep_range(timeout_us, timeout_us+1);=0A=
> +             timeout_tot_us -=3D timeout_us;=0A=
> +             rc =3D pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVC=
TL2,=0A=
> +                                       &reg);=0A=
> +             if (rc)=0A=
> +                     return rc;=0A=
> +     } while (!(reg & PCI_DVSEC_CXL_DEVSTATUS2_CACHE_INVALID));=0A=
> +=0A=
> +     return 0;=0A=
> +}=0A=
> +=0A=
> +/**=0A=
> + * cxl_reset_init - initiate a cxl reset=0A=
> + * @dev: device to reset=0A=
=0A=
@dvsec?=0A=
=0A=
> + *=0A=
> + * Initiate a cxl reset.=0A=
> + */=0A=
=0A=
Given this is a static internal call it seems best to leave out the kdoc=0A=
altogether rather than add the dvsec parameter to the doc.=0A=
=0A=
> +static int cxl_reset_init(struct pci_dev *dev, u16 dvsec)=0A=
> +{=0A=
> +     u16 reg, val;=0A=
> +     u32 timeout_ms;=0A=
> +     int rc;=0A=
> +     u32 reset_timeouts_ms[] =3D {10, 100, 1000, 10000, 100000};=0A=
=0A=
NIT: Maybe...  give the spec reference for the timeout values.=0A=
=0A=
> +=0A=
> +     /*=0A=
> +      * Check if CXL Reset MEM CLR is supported.=0A=
> +      */=0A=
> +     rc =3D pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCAP,=0A=
> +                               &reg);=0A=
> +     if (rc)=0A=
> +             return rc;=0A=
> +=0A=
> +     if (reg & PCI_DVSEC_CXL_DEVCAP_CXL_RST_MEM_CLR) {=0A=
> +             rc =3D pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVC=
TL2,=0A=
> +                                       &reg);=0A=
> +             if (rc)=0A=
> +                     return rc;=0A=
> +=0A=
> +             val =3D reg | PCI_DVSEC_CXL_DEVCTL2_CXL_RST_MEM_CLR_ENABLE;=
=0A=
> +             pci_write_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,=
=0A=
> +                                   val);=0A=
> +     }=0A=
> +=0A=
> +     /*=0A=
> +      * Read timeout value=0A=
> +      */=0A=
> +     rc =3D pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCAP,=0A=
> +                               &reg);=0A=
> +     if (rc)=0A=
> +             return rc;=0A=
> +     timeout_ms =3D reset_timeouts_ms[FIELD_GET(PCI_DVSEC_CXL_DEVCAP_CXL=
_RST_TIMEOUT_MASK, reg)];=0A=
> +=0A=
> +     /*=0A=
> +      * Write reset config=0A=
> +      */=0A=
> +     rc =3D pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,=0A=
> +                               &reg);=0A=
> +     if (rc)=0A=
> +             return rc;=0A=
> +=0A=
> +     val =3D reg | PCI_DVSEC_CXL_DEVCTL2_CXL_INIT_RST;=0A=
> +     pci_write_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,=0A=
> +                           val);=0A=
> +=0A=
> +     /*=0A=
> +      *  Wait till timeout and then check reset status is complete.=0A=
> +      */=0A=
> +     msleep(timeout_ms);=0A=
> +     rc =3D pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVSTATUS2,=
=0A=
> +                               &reg);=0A=
> +     if (rc)=0A=
> +             return rc;=0A=
> +     if (reg & PCI_DVSEC_CXL_DEVSTATUS2_RST_ERR ||=0A=
> +         ~reg & PCI_DVSEC_CXL_DEVSTATUS2_RST_COMPLETE)=0A=
> +             return -ETIMEDOUT;=0A=
> +=0A=
> +     /*=0A=
> +      * Revert cashing disable.=0A=
=0A=
NIT caching=0A=
=0A=
Probably best to remove the comment.=0A=
=0A=
> +      */=0A=
> +     rc =3D pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,=0A=
> +                               &reg);=0A=
> +     if (rc)=0A=
> +             return rc;=0A=
> +     val =3D (reg & (~PCI_DVSEC_CXL_DEVCTL2_DISABLE_CACHING));=0A=
> +     pci_write_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCTL2,=0A=
> +                           val);=0A=
> +=0A=
> +     return 0;=0A=
> +}=0A=
> +=0A=
> +/**=0A=
> + * cxl_reset - initiate a cxl reset=0A=
> + * @dev: device to reset=0A=
> + * @probe: if true, return 0 if device can be reset this way=0A=
> + *=0A=
> + * Initiate a cxl reset on @dev.=0A=
> + */=0A=
> +static int cxl_reset(struct pci_dev *dev, bool probe)=0A=
> +{=0A=
> +     u16 dvsec, reg;=0A=
> +     int rc;=0A=
> +=0A=
> +     dvsec =3D cxl_device_dvsec(dev);=0A=
> +     if (!dvsec)=0A=
> +             return -ENOTTY;=0A=
> +=0A=
> +     /*=0A=
> +      * Check if CXL Reset is supported.=0A=
> +      */=0A=
> +     rc =3D pci_read_config_word(dev, dvsec + PCI_DVSEC_CXL_DEVCAP,=0A=
> +                               &reg);=0A=
> +     if (rc)=0A=
> +             return -ENOTTY;=0A=
> +=0A=
> +     if (~(reg & PCI_DVSEC_CXL_DEVCAP_CXL_RST))=0A=
> +             return -ENOTTY;=0A=
> +=0A=
> +     if (probe)=0A=
> +             return 0;=0A=
> +=0A=
> +     rc =3D cxl_reset_prepare(dev, dvsec);=0A=
> +     if (rc)=0A=
> +             return rc;=0A=
> +=0A=
> +     return cxl_reset_init(dev, dvsec);=0A=
> +}=0A=
> +=0A=
>  void pci_dev_lock(struct pci_dev *dev)=0A=
>  {=0A=
>       /* block PM suspend, driver probe, etc. */=0A=
> @@ -5202,6 +5384,7 @@ const struct pci_reset_fn_method pci_reset_fn_metho=
ds[] =3D {=0A=
>       { pci_dev_acpi_reset, .name =3D "acpi" },=0A=
>       { pcie_reset_flr, .name =3D "flr" },=0A=
>       { pci_af_flr, .name =3D "af_flr" },=0A=
> +     { cxl_reset, .name =3D "cxl_reset" },=0A=
>       { pci_pm_reset, .name =3D "pm" },=0A=
>       { pci_reset_bus_function, .name =3D "bus" },=0A=
>       { cxl_reset_bus_function, .name =3D "cxl_bus" },=0A=
> diff --git a/include/linux/pci.h b/include/linux/pci.h=0A=
> index 47b31ad724fa..efcb06598f26 100644=0A=
> --- a/include/linux/pci.h=0A=
> +++ b/include/linux/pci.h=0A=
> @@ -51,7 +51,7 @@=0A=
>                              PCI_STATUS_PARITY)=0A=
>=0A=
>  /* Number of reset methods used in pci_reset_fn_methods array in pci.c *=
/=0A=
> -#define PCI_NUM_RESET_METHODS 8=0A=
> +#define PCI_NUM_RESET_METHODS 9=0A=
>=0A=
>  #define PCI_RESET_PROBE              true=0A=
>  #define PCI_RESET_DO_RESET   false=0A=
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.=
h=0A=
> index 3445c4970e4d..52618c5b095d 100644=0A=
> --- a/include/uapi/linux/pci_regs.h=0A=
> +++ b/include/uapi/linux/pci_regs.h=0A=
> @@ -1209,6 +1209,31 @@=0A=
>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX    0xff000000=0A=
>=0A=
>  /* Compute Express Link (CXL r3.1, sec 8.1.5) */=0A=
=0A=
v3.2=0A=
=0A=
Ira=0A=
=0A=
[snip]=0A=
