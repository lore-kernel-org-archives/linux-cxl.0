Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013025.outbound.protection.outlook.com [40.93.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C74A3557F3;
	Tue,  2 Jun 2026 10:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780396821; cv=fail; b=MfPp5VaubCZxpBuckzci5QdpIXU4YH8V1pHFyKrjjfDuEJUL3yyaJdx8Ox6d2Mw4pnoEltgl84OC+IkExcH8PPGHFM5fK9EYXOq7F9GelguDhexI4zAO4WKMmTAVS8cyhLdf+lZYLwhQlbKQ1DpHYyI/GIxHR1K52YaVFAfdReg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780396821; c=relaxed/simple;
	bh=a16/qaFdGNEBYcdBj6drxtGAJCxX9Z69sglkYjOtSTY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JC8banayUeIvlrYg8F4WQcMKlZm0J8i7ojdSE2Ec6Y7yBK4yicaROkJJzfu2ZQHnW7rDIEhYwOlwfPBR+fyzfvqZwJUDyYOkQYlvzkQe+WCUuPtTwrG/2C0iPXvyWKSxRQyQVc7aqRwVbZu4Kz7kPfgALRtYet8tsy/bWhGG0Vs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jn5sYJDq; arc=fail smtp.client-ip=40.93.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jn5sYJDq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kg/BVSDM06gl/VWtwBflStip8eh9SbhIGNDdo2cWJww5dvn68aHs/qvJWtFNtEC5ek+C/4c2+bhy+9dI7RrnXKuZFfGt1MYfptq+CN7loKbq3vjfsGqBSJM8VX8O+GHu82dr0ausGKVJ5H47QSODJ8ZxTVMMU0eCtJKzgyiF9FcYI+BKQnLx3yJBk3XXALJcNK+hBUoBvdZ+onZ+y6LHxvGoXiiYshqG9VvwCLIRP7HZQzrnDD7SwBLj5Ji1DxC1PXcGdayYIE34ktfCTl9scaAsYLtXg6rWRpGkSejUgYoiomz1OGb0hkZ549uGrsla/cYUVEPL2lEheQn2Lnll2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a16/qaFdGNEBYcdBj6drxtGAJCxX9Z69sglkYjOtSTY=;
 b=yy5weSXw+79fnehSWwaHwr18mfA0AMFPF0jHeSWDIL0o4NY0r8Y12ePcvRRg0ATMb34esgK2ZsTiFGvQ3kTQbZu+6Hnp+IFMCWxZaNFtxL1Omq32q1EY5kjrheTWPhHFxZcL2UBXzCUCSqoHD68p+G1/Wf4RSVUIp3X13PXnLqWBMNcDdZxpSQWAlqIh9crY3iqqbBpRIJcwhMtBn74IHSMw9hFJbKpmboyfX3OvEPuu/7GcFPg9Z0Gv5T4YdX6yEoBrMdEaoM5j5eU8c3/x1W77NxDFlmvk/O0BYWf+BrQ1gcxS8AeAensaZgsbNwkrbXodeIupFO3by7I8c96QIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a16/qaFdGNEBYcdBj6drxtGAJCxX9Z69sglkYjOtSTY=;
 b=jn5sYJDq1el8F/J1UOL7ZhoTfsnq+MT8pXHsf9Rkf6wYi/HEMTUhNFv6/gN+kf1gUIa6INUQK5ES+8IuJRNLFVmFsF1w6UL/rqwfKqkBBmjc90oS9IONfDdgAwEOiscQYz0Dq3A4JnP2/X+imhDqeUJNYY14u9LvdmDDU1wuJSEQ6J4wlxEgGoX7xnpjypL1/XRiPxIzjifZqTdaDu6/qfPKmI1nv3ooNpHXrSnaKdq8MK4jnRtdoLll8pZndXYUvbglQeFrEwtG5KZ1lxSFmXR0caxG+evGGmQx+wic9MTvoi5OyH+SZH0SgLgWrY2BOeUybpTvjVYQ5F1S3lpDYQ==
Received: from IA0PR12MB7555.namprd12.prod.outlook.com (2603:10b6:208:43d::5)
 by MN0PR12MB5954.namprd12.prod.outlook.com (2603:10b6:208:37d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Tue, 2 Jun 2026
 10:40:14 +0000
Received: from IA0PR12MB7555.namprd12.prod.outlook.com
 ([fe80::5a27:a8d9:43b7:3b8d]) by IA0PR12MB7555.namprd12.prod.outlook.com
 ([fe80::5a27:a8d9:43b7:3b8d%3]) with mapi id 15.21.0071.014; Tue, 2 Jun 2026
 10:40:14 +0000
From: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
To: Manish Honap <mhonap@nvidia.com>, Jonathan Cameron <jic23@kernel.org>
CC: Alex Williamson <alwilliamson@nvidia.com>, Ankit Agrawal
	<ankita@nvidia.com>, "mst@redhat.com" <mst@redhat.com>, "imammedo@redhat.com"
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
	<qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Subject: RE: [RFC 0/9] QEMU: CXL Type-2 device passthrough via vfio-pci
Thread-Topic: [RFC 0/9] QEMU: CXL Type-2 device passthrough via vfio-pci
Thread-Index: AQHc1nGWvPFiki6WBEiAZDHEC2g8trYVdZwAgBQVvoCAAbph0A==
Date: Tue, 2 Jun 2026 10:40:13 +0000
Message-ID:
 <IA0PR12MB75555B8E9FDD4546F383663AAB122@IA0PR12MB7555.namprd12.prod.outlook.com>
References: <20260427181235.3003865-1-mhonap@nvidia.com>
 <20260519141314.3eda68bc@jic23-huawei>
 <IA1PR12MB90303161DD09A1E248852728BD152@IA1PR12MB9030.namprd12.prod.outlook.com>
In-Reply-To:
 <IA1PR12MB90303161DD09A1E248852728BD152@IA1PR12MB9030.namprd12.prod.outlook.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB7555:EE_|MN0PR12MB5954:EE_
x-ms-office365-filtering-correlation-id: bba82ade-0aa1-448d-505a-08dec093544d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|366016|7416014|1800799024|38070700021|18002099003|22082099003|6133799003|56012099006|11063799006|4143699003;
x-microsoft-antispam-message-info:
 pEqqWMbz2kfUBIsW8Nn5h/0kK6Uxfj6Cpbj4YwOk70teO/fTzrbJ/ADCgPoSsByz7xBLAibcNjcG3YO1VqRi3+4VNBq/C+VIdcTc0PxHUrjMjFxF2TapaM6K73gNpsJ1i8JQni4NNXkwnjLJzk8B86kxYwElxiAFfg71mBT4o9XRJpZpXFveePi7TZBmAkYqsNgqL7M0+J8CoZ5mMOmTjpUYu6UBbKrikTq1bUoMV+fhwE4R9/kU00m2wPUoXyjPdux1Zfdn2AVAmJmkJsiXwaGFLZXeRzof2AoUOW/5omh1UmDeaM1s1k1SYIn52lMBiuNbvCRvDXbM93PUli7rP/7aKnCuIL3KojyUe7pqSQpW6eu9SeTjGfX0rxhItSKPxf63vX8AKWkRzuTj7xMq64puQPC3GijKxAgTXDocwA6z2MOgSYPoUsnloxDz9oMlW4l6UVSxW/oWfNhsLsXA335iZGFTvcW3+y71QEDtvK263cO2CmA+xt3kAoG8DTwU415bVdzkTovcMPotO2FO64zQaoXtaM6tsS5rk78p+zexYQpTYBEOrCEH3a+Kfq5GVAoJ0sZJYw0iULtFWcjdoriYKRqd5IVGkaR04aGYzbFNkvKK1/Zl4ngVmUEiURFyamOFH1Ov+/xKUYCU7PWkS2JLzIwiFyoF1ZMSMR0hM0gfwo1Zmz8lDElQCmzlTPpKGAkZX9ohwisQ9SKlF6w3Sp5LIMOppAwJbi0EhR+xCdoLuExMdj2Szen6BfMC90Qv
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB7555.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024)(38070700021)(18002099003)(22082099003)(6133799003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7umbB1NJdFQ/rEcx+tGS3mMijJNhu/xDJdEHzHQTd1JKRiAzL0VrJhRcDKcq?=
 =?us-ascii?Q?y288whtEE77NYZC56TncDLSczdIAp8zoePrsC2N7HOCdiC14h6yuncLYknEP?=
 =?us-ascii?Q?3fM3PjDkfDBNoGBlQjI5q9bdN0/lU6aIZ9OonlJR6NDJwS/MpwSvpugOUCf+?=
 =?us-ascii?Q?YdO2KN4M2qJczrD4NxG7FOgFRhX7b983byNVuP07tNAM8MoUmZWjxNtScBJL?=
 =?us-ascii?Q?79KqE5/n2YvSUukfRC4vEyJl+DX3WiusWprIgBYiq3BsZP7H9Cp3/7ruiuIe?=
 =?us-ascii?Q?B68h9xdPUo/pue2i8YK2vkWHLGcFe1SDE0BhybASZaIQ5gsilragE2NKDKrk?=
 =?us-ascii?Q?NU2u/eS6oWD0r4Lv58WBTJ2tdGZUS+P/uVKuhQTPh5BSo0DZVllEQyb3WnRe?=
 =?us-ascii?Q?1v0Wez2Oir71mLoABaIXBTQtUwp10pRMhqE+otxEGxft0dQmPes1Z8J8+wz+?=
 =?us-ascii?Q?XppFjXSTdky7f1NA4MxgRmWFsfJuzr5A/b3K06E1v3iZqrtxBv+WYxsuEJnx?=
 =?us-ascii?Q?J8bqB2y9nMMsFmLY5VYK1n1H4a/x5qBUgkgXXHfpbei/pB+CwyfL3BZi6+hx?=
 =?us-ascii?Q?/BVAFZdCoAabtVepzULA3AObCqSsBUTgx4a0sCTsNHyMGuiiJtZEYjfvYpfU?=
 =?us-ascii?Q?tCI4WPxL2KBzXUet3JTV732iPej4gTDeIb8R/Tl/qNFgMTSyqlQuaIOk75s0?=
 =?us-ascii?Q?BsWf43/vI2FxzV3wp3c3IeSob3Ad+2fhpPUprsGvT3ic0pOQyfFCX/W8qDyL?=
 =?us-ascii?Q?MXNM7XkKzgVMY/+GE1VoTbil2jThiPv/alcxen7OCpo3ZszRz5V5vW0yI15g?=
 =?us-ascii?Q?KYR3WkNVOqpirPqCLQLzptsB44GBbnCiy/yy3jkSatOkjM55yanICV+CHxVH?=
 =?us-ascii?Q?dE3m63YovZfkwckt6lCG148UQMcurqLfReOz9YE0PMNJEhV/ZkvCHZwMaN+Z?=
 =?us-ascii?Q?viyL28cED5dcACCbK8lMYmoEo+0ZzCOcrHyLTTp0p5gVcbZtBxyrSSaMWaEn?=
 =?us-ascii?Q?gkYzQ/XABP/2oliTdccP7I8l8lAgDTr2kazeeGnAPiN3sA2unD6yI7gQVyMl?=
 =?us-ascii?Q?w+blF+ElsmRLGUi0rEm5Zdq0/UfUJZfvY7x8mKF3lZDU5SM04Ig6lJqmiuyu?=
 =?us-ascii?Q?Wj14RGzzUa96AbHcoVSYOt6wSZRpPcyYcTPo+xw/j+324jmDI2SGtf3rVJiy?=
 =?us-ascii?Q?VmD4spMQzYHgtXjLZgISajmToHuMZJ8TXRZRs8bLS9EVawZsWZ9v7RiU+pW9?=
 =?us-ascii?Q?vIcaKvfqg1ojmXwn6RjvygEJLw2qKapkcvv3FbnSxTnyMg4g5ivoca8tSsh6?=
 =?us-ascii?Q?FsRCpF+MSTmhSWfva/ScUk+WKvDp59Q3rWxdS3V7m/7K6OrKHny2Wexdm2V7?=
 =?us-ascii?Q?HDebaL187LcQU3Sm8AT0dItE413nN4kGaFDMFr7eTPsO+2Vsjt5pkJsYVWH2?=
 =?us-ascii?Q?wzAwKLkI9eNxzPiJuciE1cPbeRsrwyS+KZ609xNMdvAkwbqkQRbiQ/LEOKdU?=
 =?us-ascii?Q?cIO8d/juLYge7WKgmdOiJ3rNuDU3UZaX5LkYzPRfMcfMBU8FYONITrg01G+W?=
 =?us-ascii?Q?Q99D4cOODw0BHlw+N58x+t2qDv4WfcY40T+8ERXuBHsFXVVkjcju1i7f1ScK?=
 =?us-ascii?Q?kqZF95zExeT9e+m2ezGUvLiKIjTLBgYHOE0JPWXOhdQsattlTL/lq8wLuJGq?=
 =?us-ascii?Q?zU8rk1JrpgtiWG4iKht1xhrTFwCCtLF5x9ZMmd/lLIpKdX75L3QRXINNkclU?=
 =?us-ascii?Q?YnjP+xxe4Q=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB7555.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bba82ade-0aa1-448d-505a-08dec093544d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2026 10:40:14.0226
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FSkgvHjLVswkYWMcc79FzmyF/WsWYirHwXgjNw7e2zyDOFUkxicqVyAu2uHrH63mul6RdNvhU2HREmKE+rDLlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5954



> -----Original Message-----
> From: Manish Honap <mhonap@nvidia.com>
> Sent: 01 June 2026 08:56
> To: Jonathan Cameron <jic23@kernel.org>
> Cc: Alex Williamson <alwilliamson@nvidia.com>; Shameer Kolothum Thodi
> <skolothumtho@nvidia.com>; Ankit Agrawal <ankita@nvidia.com>;
> mst@redhat.com; imammedo@redhat.com; anisinha@redhat.com;
> eric.auger@redhat.com; peter.maydell@linaro.org;
> shannon.zhaosl@gmail.com; jonathan.cameron@huawei.com;
> fan.ni@samsung.com; pbonzini@redhat.com; richard.henderson@linaro.org;
> marcel.apfelbaum@gmail.com; clg@redhat.com; cohuck@redhat.com;
> dave.jiang@intel.com; alejandro.lucero-palau@amd.com; Vikram Sethi
> <vsethi@nvidia.com>; Neo Jia <cjia@nvidia.com>; Tarun Gupta (SW-GPU)
> <targupta@nvidia.com>; Zhi Wang <zhiw@nvidia.com>; Krishnakant Jaju
> <kjaju@nvidia.com>; linux-cxl@vger.kernel.org; kvm@vger.kernel.org; qemu-
> devel@nongnu.org; qemu-arm@nongnu.org; Manish Honap
> <mhonap@nvidia.com>
> Subject: RE: [RFC 0/9] QEMU: CXL Type-2 device passthrough via vfio-pci
>=20

[...]

> > > pxb-cxl bridges had no _DSM method. Without _DSM function 5 the OS
> > > defaults to treating PCI configuration as reassignable.
> >
> > That one is annoyingly controversial. I see you have Shameer's patch
> > so he can go into history of why. I tried to land that in the past and
> > I was far from the first.
>=20
> okay, I will check this part for additional details.

I guess the concern here is the QEMU regression reported with certain
devices with legacy IO port BARs having issues on arm64 when _DSM #5 is
specified:
https://lore.kernel.org/all/20210724185234.GA2265457@roeck-us.net/

For accel SMMUv3 this is fine as we restrict the devices to vfio-pci only.
One option, until there is a proper fix in the Linux kernel or EDK2, might
be to maintain a checklist so that devices known to have issues are not
attached when _DSM #5 is advertised.

Thanks,
Shameer


