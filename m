Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8827B15B97E
	for <linux-cxl@vger.kernel.org>; Wed, 20 Nov 2024 22:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732142024; cv=fail; b=fjb6ppCdd9Sf4eVvxGXp2+bHNZhTh3jV7WTdG2WX2Y9fNXuzqjbDsGoc36mzskTvS9h5Q15EqiLPBn+IQfiYJVekvKklHQzyvH2nPstQwPoO1L6UnKOtVPQmvxQtLj/HYx65as4FrwLov5PY2Xmt2LQs6qEVAOKVYAU0hrMm0N8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732142024; c=relaxed/simple;
	bh=JNDZSgNG/3HxwC+DlUgwqYaMto5iOkpWEtBKvCXrMUg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f8Rs1X8sGXHXFT5RQ5Cr7ObvJLORXbZRh68pabTS1AcNoX8Wsyz8B6mjB0Y+AcVqI9L3Cfp9mJNiznCRS9H5ebW/v+5nmGRnMVk93PzZOFp5dSaYUEMAK9w6KqL5WRzTyL4hcvaSOtKrTEHdW7EPkSJmLAYRolTzLkD4cBU53Go=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=amXjV9AP; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="amXjV9AP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DZlva3B8HI/m351aJonyoNNJ97ffs92h57pvHqDlfA+aKgnpCVLdNtEyhOnd+m9rLtN7WZ1xLlAiaqrupYUePwKAmdiWqjA+MVJh0ErQ3jqY+QojJXVHAvZDBHGqzkTtHLp31TrFiefxBdfSsXbboPGIUjAT6LxBXIQfb7sgDAzmQCYeVUJMZFX4+n4EdiuTFSJyX2pMnr+zJNDzkBimPA7vuShIjUD4w3SpRKUcncFsgfZ+0xZTNWwVDFzEwkO+TqG1q8K8bKgYmrfSf2+qhCchw02JOg5W4ncC9pfBSREtr5F28g/0MxCNCKstsS0CuVXqNKm01Ekix5WBxIswzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZoES8m+/C+Xq1/SDCT1XswmN1ZWNw2x8lIaN6cuYcE=;
 b=mGqtpu47DPIPGxhNJVXliDcwC5KEwHsony4iEmxmddtBuwrIc6tVSZLlCaDDVxkridi6nxfpZLjlBnBv2fxolYT+55RJBDNuM9ssksZKBcScCrSlhSxoAYKyN+x3S9hvJ6S6kdIjm9cDE3qSAhf90qrsJj4JeUI6ifpa35x4DbiICBThGNkY0uTClgLQpCgnwnkQTKFNmV2J0yc1OpLbNOK0GYAElAwQEXTR6HW3gSCifqH6JM57UDCx8NJDJoGgwCb7gxgafNb+HJkVOyv5XKwKfdPS3klJ+u2mg7aAfHU6iiIHZnZ42eer8gLAFOmQrISs99SZbEWZdw6HkUTkTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZoES8m+/C+Xq1/SDCT1XswmN1ZWNw2x8lIaN6cuYcE=;
 b=amXjV9APtYU94AHfBHeKM5R8584ehtFg6lWQAVCN8oGC1idClLTpYJKtnHh7eBdYbCQcowsjGCJG6YOay/x8Ya+xfdHBVuDaBvr4VpuMPyKnWfHLJUcp5nfu+0fD/p6tsqpQFXCjDKyj400C1dcBrmFbFEGlOB2+0BJCs/zaE23t9IFypFRN7WHGy51ED0b/46CkQAbF+nvMk1cYDtlAAfbVE8zrg/eht2KmSJgKu5yxtFphSqpGvIms3eAXEBmwnR05gNLaplypz35QaxLBO5MLy9tI+AGvtkNlHzRA1acsIpg0gCcpYLgNoKwvd4Zwp8hrE6Q0Hmxta8AC3RJlhQ==
Received: from SJ0PR13CA0166.namprd13.prod.outlook.com (2603:10b6:a03:2c7::21)
 by CH0PR12MB8531.namprd12.prod.outlook.com (2603:10b6:610:181::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Wed, 20 Nov
 2024 22:33:35 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::49) by SJ0PR13CA0166.outlook.office365.com
 (2603:10b6:a03:2c7::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.14 via Frontend
 Transport; Wed, 20 Nov 2024 22:33:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8182.16 via Frontend Transport; Wed, 20 Nov 2024 22:33:34 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 20 Nov
 2024 14:33:17 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 20 Nov
 2024 14:33:17 -0800
Received: from localhost (10.127.8.9) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 20 Nov 2024
 14:33:16 -0800
Date: Thu, 21 Nov 2024 00:33:16 +0200
From: Zhi Wang <zhiw@nvidia.com>
To: Alejandro Lucero Palau <alucerop@amd.com>
CC: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	<iommu@lists.linux.dev>
Subject: Re: RFC: Kernel CXL cache support (and IOMMU implications)
Message-ID: <20241121003316.00001cd3@nvidia.com>
In-Reply-To: <cc2525a6-0f6a-c1c8-83e1-6396661efc8a@amd.com>
References: <cc2525a6-0f6a-c1c8-83e1-6396661efc8a@amd.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|CH0PR12MB8531:EE_
X-MS-Office365-Filtering-Correlation-Id: 63ededea-5a67-48bf-360f-08dd09b35eb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?empNTW9SblFjeWdyandLdXBTaWU3dkRBQkRiby9kT1dSdU1IczQvRm8xYktY?=
 =?utf-8?B?WFkrQS8walRtZkxRMDBvWUpLVjdRaVM1ZEhkZTd6VVUvUmsvNGVZQkdJamxB?=
 =?utf-8?B?TG1CdUl2R0F6c1dVZUN3bUVvSzIxYjVIc3AxcUJ5QkI4VC95NitKMEg5ZUJO?=
 =?utf-8?B?c2FlWGNsOTVnUTNVUWFpaTlDWDdkTU42K08yRGhMRVBsSG51akIwT1NaTVN0?=
 =?utf-8?B?d0hHTUJHSlVuWmVGUi9KaCt0MkF4VlpOcm11VUwvUFBHM2czV3pOWHJYSS9R?=
 =?utf-8?B?ZmFkbTBuQnpOc1RNOUpVTlZJWm1NaEttcExuQm43Qjlady9xcHEzOWgwenk3?=
 =?utf-8?B?T0VJZGFjWGZ0YUlCYmdjMUJ6bm5rUkc1VzVGVWVVMzd0dnA1eEY1UFh2MmxQ?=
 =?utf-8?B?eEs3OXpFN1JBZmtHanJpRHZJMDllYW9IT3RYelVuOFlZYnZ6Y053YkJKcnIr?=
 =?utf-8?B?MUptWG05NEZEcThoMlN4NUVpWlFTK0dqdkRnRGpQSTVQT0cyYlpmUjlKVkRx?=
 =?utf-8?B?RXhXN2RTeVI4Rk5rRmdBUnNrNERhdE5xb2NBdTM5WjBBZmZFSzlJZ1RmQzdk?=
 =?utf-8?B?VnM1b1E2MkZCUU1Vb2FkV3djNi84SVJvQU82RkhOMGdKMVpkeDlqci9YWGhL?=
 =?utf-8?B?bGRXVXFnQ3lQQXcvQUdtNHFWKzVaQjhWMVNzenVFbGRvVHM0dE9HenhhcHpQ?=
 =?utf-8?B?T0V0RFlmRFI2WXVCSTFqVmhoaEpVOVN4TTRlbGdaTjRGRUhTdVh5SWlodDcy?=
 =?utf-8?B?L0w5T282RTFxeW1QK0pOUmxSVUIwdUtPK25rMXFkbUdyL1hEamJVOEpGL09t?=
 =?utf-8?B?WHR6blJYT2RDVlplT3dyZVoyOHpzdE5Lam1QQzJ2L3dhQUFOMFJHTSs3dlc2?=
 =?utf-8?B?aWhCd1lnbzcrVmVDcmVFSTVCQVN1RGloYTBlWnJSQXYxb2lEV2h0NXRHVFJL?=
 =?utf-8?B?QXVrRkNlSDZMUXJkWWRHRnUvYkdvU21aMCt5Ym95bGFMYk1maDBaeUNmRFlh?=
 =?utf-8?B?SVNLNHlUVFpYVnJIdHR0eTN6VzcyOHV6dFdwa0JIZ2dqRXp1SXhCYmZOVnly?=
 =?utf-8?B?MmJ6TFoyWkJWUmNHQ3lVc01hbFdQR2FSS250elozeW1PcUZET2EvalhDbCtB?=
 =?utf-8?B?VFJsRmwrUkxmcFJiVVVwdjhXWjFWWitWR0V4NlNNQm9ybnR0WWliS1BQRk1N?=
 =?utf-8?B?VGJyalpwbHdZSjZQdmY4WjlsRmdLY3NFTjJ5RWpVYmJ2bEVVb2hjdkJ6TkpE?=
 =?utf-8?B?OUJremFGaHNXekFDaWowSG9vanpUMEdhMENzb0lPQ0NxZmlDVm9CNCt2QzRn?=
 =?utf-8?B?N09NUEI5Ni84WWxqWWg1VXVvS20yN3VpQzF0Vm5mWWJKTEh6L013bmxwbkE0?=
 =?utf-8?B?dFc5YncwUWpZYktxZEY1ZVV4Z1VmWktna05Ndys1NEdrVk1QRWpKSUNrMzdS?=
 =?utf-8?B?d0tCeGIvVlM0aXZPbVBGRVdsaG1XVzV6dFk0WFlHSWZwRktVUzlGbWN6clBa?=
 =?utf-8?B?OTJUK0pya1pZUEZlNlNXdHMyQ09zREdxSXhieE5kRFJKREtxem5ZWk1QMWh3?=
 =?utf-8?B?QXgxOGNBYndWZGljUlhFbHdWVytXaXZwbGFpNzNJYU10UFg5aGlEMyswUjlM?=
 =?utf-8?B?cmRMQTVZMGo1clBock84LzlxaWhtSGtUV0RRb3c4eG4zT0wyOCtNbk1XTE93?=
 =?utf-8?B?OXFJOTM5bzdrVmxVTnMrcnh2cHAyNXk3eUhGeGFoM1hFQ1lzNTF2WVZTV2xn?=
 =?utf-8?B?QUljTkkwb1JYOFJTQVNyRVd2MU9MZmtnNERtTkY3dVpQTlA3Wm8rK09Ib3Rx?=
 =?utf-8?B?QVNIaWVtWGFTV01MaWtrQVdaT0dIcE8wNTZMaHpCMXExK0ZVRjZRRXljTnda?=
 =?utf-8?B?bGRpeFh5VjFNa29XT21RTlh1SVYxMFN6YlJIdHVXT0lhVGc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 22:33:34.7958
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63ededea-5a67-48bf-360f-08dd09b35eb5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8531

On Tue, 19 Nov 2024 16:52:15 +0000
Alejandro Lucero Palau <alucerop@amd.com> wrote:

Thanks so much for the doc. I just quickly went through the doc and here
are my comments.

> November, 2024
>=20
> Tittle: CXL Cache support by the kernel
> Author: Alejandro Lucero (alucerop@amd.com)
>=20
> Version 0.1
>=20
> Introduction
> =3D=3D=3D=3D=3D=3D=3D=3D
>=20
> After the LPC where I presented the current status of the Type2 CXL.mem=20
> support
> patchset, and some ideas about supporting CXL.cache, it is time to dig=20
> deeper in
> this second goal, and discussing the security/reliability aspect as well.
>=20
> It is also important to try to describe how this is going to work and=20
> what the
> kernel needs to know and enforce. Reading the CXL specs when having in=20
> mind some
> specific use case can easily lead to assuming certains aspects with a=20
> different
> perspective from other readers/use cases. To start with, it is necessary =
to
> differentiate two "CXL cache" functionalities when a Type2 device is in=20
> place:
>=20
> 1) A Type2 device caching Host memory.
>=20
> 2) The Host caching HDM memory, that is the memory inside the Type2 CXL=20
> device.
>=20
> The first option is also what a Type1 device can do, and the kernel suppo=
rt
> needs to manage all those Type1/2 per CXL Root Complex knowing the resour=
ces
> limitation, that is the snooping cache size.
>=20
> A snoop cache allows the host to track which memory is being used/cached =
by
> those devices, enforcing the cache coherency. The specs are not clear=20
> about some
> important aspects regarding how the host can enforce the proper use of=20
> this by
> devices or even if the snoop cache needs to do so. At pages 786 and 787=20
> of CXL
> specs 3.1, how the system software should deal with CXL cache devices is=
=20
> given,
> but this is inside a Hot-plug section. I think we can assume the Host
> firmware/BIOS will follow same approach for enabling CXL cache, and the=20
> kernel
> needs to look at those devices with CXL cache enabled by the BIOS for=20
> properly
> handling the available space in the snoop cache.
>=20
> It is also worth to mention the CXL.cache protocol can be used in the two
> "CXL cache" functionalities listed above. However, the last CXL spec impl=
ies
> CXL.cache only used for the first case. Some comments about what the=20
> specs say
>=20
> regarding number of devices with a cache for host memory:
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - up to 16 Type1 and/or Type2=
 devices allowed per VH.
>=20
> can be easily confused with the limitations of just one CXL Type2 device=
=20
> using
> CXL.cache for enforcing coherency of its HDM. This limitation is=20
> overcome with
> forcing Type2 device using HDM-DB, which relies on CXL.mem instead of=20
> CXL.cache
> for HDM cache coherency.
>=20
> While the Host is assumed to be able to access HDM in a Type2 device, and
> keeping data in the host cpu caches, it is the Type2 device=20
> responsibility to
> properly manage cache coherency of its HDM. There is nothing the kernel c=
an
> control here.
>=20
> Therefore the interesting part and what this documents tries to cover is =
the
> Host memory being cached by Type2 or Type1 devices. While the main goal is
> discussing how the kernel needs to handle this, and to describe how it=20
> should
> work when CXL devices are used by the system/Host, some comments are made=
 to
> cover the virtualization case where those CXL devices can potenetially=20
> be used
> (device passthrough) by guests/VMs. I try to expose the current security
> problems where IOMMU is used for restricting what a guest controlled=20
> CXL.cache
> device can read/write in Host memory what I think needs to be clarified by
> hardware vendors.
>=20
>=20
> Understanding the memory accesses from CXL devices
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> For the sake of presenting the case about kernel CXL.cache support, I'll=
=20
> try to
> explain how it works (I should say "how I think it works") and the main=20
> points
> to discuss regarding how to implement this support. So, do not take the n=
ext
> explanation as the definitive answer or guide, and if you think there=20
> are errors
> or maybe too much generalization at some points, please help fixing or=20
> adding
> further details. Also, consider some parts as just me thinking out loud,=
=20
> what
> maybe help other people (or confuse them!).
>=20
> The CXL.cache protocol allows devices to be part of the coherency ring=20
> of the
> system.
>=20
> Let's start with a Type2 device reading from a specific host memory=20
> address. The
> final situation is 64bytes (cache line) from host memory copied to the=20
> device
> cache, supposedly for being used by the device/accelerator. If the data=20
> changes,
> because some host cpu modifies it, the device will be signalled by the=20
> coherency
> ring, so the device will know. The important point here is the device can=
 be
> told because the Host knows the device has a copy or the only copy of that
> data/memory. And that is thanks to the snoop cache implemented by the=20
> CXL Root
> Complex.
>=20
> A device caching host memory can be used as well for writes to host memory
> through the cache coherency ring. A device can not just read host memory =
and
> keep it, but it can modified it. The implications of writes versus reads=
=20
> are not
> important for the goal of this document. It requires the device to=20
> support more
> protocol exchange cases, but regarding the snoop cache, it is irrelevant.
>=20
> There arise obvious questions about how this snoop cache is going to work.
>=20
> First, with the simple case of just one device caching Host memory. From =
the
> specs, the device CXL.cache should not be enabled by the Host if the devi=
ce
> cache is bigger than the snoop cache. However, what does preclude a=20
> device to do
> more memory accesses than what the snoop cache can cover? This can be par=
tly
> explained with some allocation control for CXL.cache what is discussed=20
> in the
> next section. But a "rogue" device could try things like this, what for=20
> the case
> of a single device using the snoop cache and without any other concern ab=
out
> security, is probably fine:
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - With a Type2, the snoop cac=
he will tell the device to release=20
> another
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 line, meaning any=
 modified line to be sent back to the Host.
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Any performance problem wil=
l only have an impact on the=20
> device itself.
>=20
> Then the case of multiple CXL devices caching Host memory in the same=20
> CXL Root
> Complex and therefore same CXL Snoop Cache:
>=20
> * How can the snoop cache track reads from different devices without one=
=20
> device
>  =C2=A0 monopolizing the full space?
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - enforcing snoop cache slice=
s by software?
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - allowing specific/limited h=
ost ranges by the kernel?
>=20

I would like to compare it with the approaches that solves the similar
problem of the CPU cache since they might have similar essence.=20

CPU cache suffered from the similar problems that noisy and
restless neighborhood keep poking the cache that might cause performance
drop. Nowadays, it is solved by the HW mechanism, cache allocation. For
Intel, it is called cache allocation technology(CAT) which is a subset of
Resource Director Technology(RDT). They can be also used in the
virtualization world.

Before SW gets the support from the HW, many research papers were talking
about solving it via page color. E.g. allocate the VM memory with page
color awareness for different VMs. But I don't think those ideas eventually
land in the mainline.

Back to this prob, I think probably SW is going to rely on a HW mechanism
to solve this problem nicely and decently, the same as CPU side.=20

> AFAIK, there is not any kind of hardware control for avoiding this=20
> contention.
> Note that with the proper checking by the BIOS and by the kernel (for=20
> hotplug or
> those not enabled devices yet during boot time), the size of total=20
> device caches
> allowed per CXL Root Complex should not be bigger than the snoop cache=20
> size, and
> therefore theoretically no contention at all ... if the devices do the ri=
ght
> thing. From software the only thing we can do is to ensure the CXL.cache
> accesses from a device are within a range with same size than the enabled
> CXL.cache.
>=20

What would be the consequence if we violate this rule?

> Therefore, some memory allocation API is required for dealing with the=20
> amount of
> memory the snoop cache can track, and the host memory a device can=20
> access to.
> The device needs the physical address to work with, and it is in this=20
> required
> translation from virtual to physical addresses where we can enforce the
> restriction. Of course, such an API does already exist, although not=20
> with the
> checking we need: the kernel DMA API.
>=20
>=20
> (Secure) memory allocation=C2=A0 and CXL.cache
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
>=20
> DMAs allow devices to perform read/write operations to system memory=20
> without any
> cpu intervention after the (meta)data about how to perform the DMA is=20
> given to
> the device. CXL.cache is more than DMA because the system memory caches a=
re
> implicitly involved but for the sake of handling this by the operating=20
> system,
> not too much different. The important point here is there is no restricti=
on
> about the DMAble memory to be used by a device, but due to the snoop cache
> limitations, this needs to change for CXL: code aware of the snoop cache=
=20
> state
> and what a device requires needs to be consulted for properly handling the
> available space.
>=20

As what I replied above, I think we probably need a HW mechanism to solve
this problem nicely and decently. (Thinking sharing cache is
also a pre-condition of side-channel attack, even here is a snoop state
cahce.) With the HW mechanism, allocating the space of snoop state
cache might imply a glue layer of snoop cache management for different
CXL HB vendors to plug into the CXL core.

So when the CXL driver is initialized, the space of the snoop state cache
is allocated. With that is solved, for restricting the device to access the
memory (creating/mapping an IOVA for the DMA memory), SW can still leverage
the current Linux IOMMU/DMA APIs.

> Should we use the kernel DMA API for CXL.cache allocations? This API=20
> deals with
> memory coherency what is not needed for the CXL.cache case. However, it is
> connected with the IOMMU functionality what is required for CXL.cache if=
=20
> it is
> enabled.
>=20
> I think the solution should be to implement a CXL.cache allocation API=20
> inside
> the CXL core dealing with the snoop cache available space, and to=20
> connect with
> IOMMU kernel code when it is enabled.
>=20
> A security aspect behind DMAs is a device has (usually) no restrictions f=
or
> memory access. This is true in a system with no IOMMU hardware, and=20
> CXL.cache
> is not different in this case. With IOMMU is a different game though.
>=20
> First of all, IOMMU will be in place for CXL.io, what implies legacy TLP=
=20
> PCIe
> packets. A CXL.cache operation can not be handled by the IOMMU hardware=20
> and the
> spec states ATS to be used beforehand, that is, the CXL device asking=20
> the IOMMU
> hardware about the physical address to work with, and keeping that=20
> translation
> internally. The CXL spec specifies ATS service extensions for CXL, and=20
> some ATS
> requests can tell the device some addresses only to be used through=20
> CXL.io. This
> implies some sort of knowledge about CXL is required by the IOMMU/ATS=20
> hardware
> which depends on how the per device tables are programmed by the Host.=20
> However,
> AFAIK, this is not supported yet by any Linux kernel IOMMU vendor=20
> support. Note
> the usual IOMMU device/domain tables will/can be used for normal DMA=20
> transfers,
> so IOMMU configuration, both in the Host and by the HW, needs to know=20
> which parts
> of the domain are for DMAs and which are for CXL.cache.
>=20
> Assuming this support will be implemented at some point in the future, the
> questions are, when?, and, how safe is it?
>=20
> Can a device issue CXL.cache operations using arbitrary physical=20
> addresses? It
> seems there are some cases where the hardware can take control of PCIe TLP
> packets with the ATS bit on. For example, if there is a PCIe bridge in=20
> the path,
> and with that bridge using a specific redirection table based on=20
> configured ATS
> per device ranges, any TLP with the ATS bit on will be redirected based=20
> on such
> a table, and implying no redirection if no table entry. However, that=20
> does not
> seem to be in place for PCIe Root Complex implementations. For example, A=
MD
> IOMMU documentation states ATS TLP packets are not handled at all, implyi=
ng
> trusting the device, and if more security is required, the IOMMU=20
> hardware can

Are you referring to the ATS translated request here? I think ATS itself
doesn't consider the security in its mind.=20

> check those TLP ATS packets as well, spoiling the ATS advantage. Note=20

Yes, AMD IOMMU has the secure ATS support, but as you said, it is pretty
straight-forward, basically just check every translated request when
enabled.

> this is
> PCIe, so CXL.io will likely keep the functionality, but CXL.cache operati=
ons
> follow another path with apparently no further control to enforce the rig=
ht
> addresses within the allowed memory ranges per device are used.
>=20
> Because this apparently lack of security for IOMMU and CXL.cache, this=20
> implies a
> CXL device should not be used by VMs or any other user space controlled=20
> driver
> with CXL.cache being enabled. This seems a really serious limitation, so=
=20
> maybe
> I'm missing something here.
>=20

I think at least for CXL path, IOMMU should have the similar mechanism like
secure ATS, and let the user to choose if they want it to be enabled or
not.

In reality, many CSP design the HW by themselves and trust their HW won't
do messy things, they may want to enable it only on the 3rd party HW.

For confidential computing world, secure ATS is mandatory, and performance
drop is the price of security.

> Regarding virtualization, assuming the security problems do not exist or=
=20
> will be
> solved, while CXL.mem can be supported with an ahead mapping by the=20
> Host, with
> CXL.cache this needs to be handled when the related driver asks for speci=
fic
> memory to access, and then to configure the IOMMU/ATS tables by the=20
> Host. This
> implies the emulation needs a backend, what an ahead mapping, as currently
> proposed for CXL.mem can avoid.
>=20
> Finally, if my concerns about the security of CXL.cache with IOMMU are
> unfounded, at least this document should describe how is this solved and =
the
> security enforced by the hardware, and if the kernel requires to handle it
> specifically (what I really think is the case, at least with IOMMU changes
> managed by the CXL core).
>=20
>=20
> Summary
> =3D=3D=3D=3D=3D=3D
>=20
>=20
> Next the proposed tasks to perform for supporting CXL.cache:
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - CXL core handling per devic=
e CXL.cache enabling based on CXL Root
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Complex snoop cac=
he state.
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - CXL core implementing a CXL=
.cache host memory allocation=20
> restricting
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 the physical memo=
ry a a device can access to through CXL.cache.
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - IOMMU being CXL aware and d=
ealing with CXL.cache vs CXL.io=20
> requests.
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - Clarify CXL.cache and secur=
ity with IOMMU.
>=20
>=20
>=20

