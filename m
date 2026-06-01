Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010055.outbound.protection.outlook.com [52.101.46.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7803806D8;
	Mon,  1 Jun 2026 07:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780297327; cv=fail; b=MipRWiDgHIQVV5CmtS6LMfdxC8FPlf567ptzext0L+EC+4+edQyu10HCZ8yvpQXgn+N8dikb8gWQWUCjzfrhYy8aylabjhx2TlGnEHggP3a29nuZrTSRy7hubK4LWKtcSJlzy0E6/UCOXbWOJsKRVIaa21K0SW5JdtlSxClfkUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780297327; c=relaxed/simple;
	bh=8sRi+MxF1xSpXOlDcr7huXaV/OnJaxBwQ/KPhg+Cy+Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Q64eIUsvM3Q9CHkkjxBYLS7YP9lHYg/ir3GJFb6iLvErnMKIBirtBdWASoXa8YPiz6J30kQ8P82Cs2Se1LFS9vzHvLNrOECLaEFgNW1n8jmhvbD9ODDAJjWC/HPEUTMzvLPorEdHK6bylNie1pRxzn1TA8hXFIyklWffIZ+6u44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i4mn+AJp; arc=fail smtp.client-ip=52.101.46.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i4mn+AJp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gWWqTYK4yB47NxdA5NomKfl320QyWg+dZVpq+GTJRkZCjrTrzW5DXTKIwq+iphOrYpXultTqdXNBc0LcZ/wPl19OXpLQmDvTc9MSLhmve8EBsLcOriSTNxnr95J9AhPXYhfW/tATk9phOmrmAeLxqzP1GGScyCTsIU+u2SvJ5fxWwdj7IkJwor3sBdQjwB1U67TjeUg3JgXZAX6PdesllHfwASFw9VAFlNH+GoRJEjFrCpz/ESS3g+jaOZeN/pqe8F7JSZpZcLL9r4vjPgPCgKRhW2oyR/q0L8DDgxzUSLbezKMJqbKvYmbiRKeypeN9FpBM3Fu3zAsOCCfcHfvlLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRd0M1UOFkb1tjIiizfPZU4O4TKzgUPAHV5FPF+lzvE=;
 b=GbqDkf1kIJTnu2Prt6r5eqYashz1dLPkW5a/CVFuFTSGfrQoNhqACRHVDgFn/oAiPYzsFzM/zAnUqkxFW3akWs3xA19FvXXYu65TN1yI7GF1Zlf0x4YL/OsVXAz7ZYD9G7GbWQEfWBiZleXUpKv1YHeoNVwYECWNJpuKZUJMDXyPxJMTFgXXin08rDR9/lEKhyd5VHoaGhp1dt5yWKb7vuQvLNXljOUQlZSQcxmiMTPGocxMTi06hhG6lRoYEfL+OGd1FiFgNMhUZH2W1GJyy5V6COm9rXYLeAygJ7M/WKnH1k2wTJb4f7Wxu3eWJ5Z0aYoTsWGoggYoLk8n4gvlPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRd0M1UOFkb1tjIiizfPZU4O4TKzgUPAHV5FPF+lzvE=;
 b=i4mn+AJpN1Ws4urnuButXRoWzDXSmQCyZkRhvyV7u4+wEqEoz3+qEtWYOsYckSvlAJP2tbjOfkvadpr8fe5RcbGqU4ycxgoxHAxWwz0HaSRLzltoW7yA86LHR2MpTwGZUq1NH+Sl451LQPD1OQABaLekhGdik+tL84tWrSXiS5ZkxwTt0lg8PV9pmIJtFog/ESwfQ3nwwyBa5xy9DUAC1egD0oayN/PcZk4jZ4Ff/lrzeX0MlPZMnLfedvX6VWbptAfCfkW5QON5h7pL5K6aP9YdpVzO27ZXZUv64tXjCt1Q+gP888Ns0ljkPZoQ8eRl2dCklV6PWluWt7rgC/aQVw==
Received: from IA1PR12MB9030.namprd12.prod.outlook.com (2603:10b6:208:3f2::22)
 by PH7PR12MB7892.namprd12.prod.outlook.com (2603:10b6:510:27e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.17; Mon, 1 Jun 2026
 07:02:01 +0000
Received: from IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2]) by IA1PR12MB9030.namprd12.prod.outlook.com
 ([fe80::2c1d:ed27:b53a:97d2%6]) with mapi id 15.21.0071.014; Mon, 1 Jun 2026
 07:02:01 +0000
From: Manish Honap <mhonap@nvidia.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Alex Williamson <alwilliamson@nvidia.com>, Shameer Kolothum Thodi
	<skolothumtho@nvidia.com>, Ankit Agrawal <ankita@nvidia.com>,
	"mst@redhat.com" <mst@redhat.com>, "imammedo@redhat.com"
	<imammedo@redhat.com>, "anisinha@redhat.com" <anisinha@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>, "peter.maydell@linaro.org"
	<peter.maydell@linaro.org>, "shannon.zhaosl@gmail.com"
	<shannon.zhaosl@gmail.com>, "jonathan.cameron@huawei.com"
	<jonathan.cameron@huawei.com>, "fan.ni@samsung.com" <fan.ni@samsung.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "richard.henderson@linaro.org"
	<richard.henderson@linaro.org>, "marcel.apfelbaum@gmail.com"
	<marcel.apfelbaum@gmail.com>, "clg@redhat.com" <clg@redhat.com>,
	"cohuck@redhat.com" <cohuck@redhat.com>, "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>, "dave.jiang@intel.com" <dave.jiang@intel.com>,
	"alejandro.lucero-palau@amd.com" <alejandro.lucero-palau@amd.com>, Vikram
 Sethi <vsethi@nvidia.com>, Neo Jia <cjia@nvidia.com>, "Tarun Gupta (SW-GPU)"
	<targupta@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, Krishnakant Jaju
	<kjaju@nvidia.com>, "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "qemu-devel@nongnu.org"
	<qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Manish
 Honap <mhonap@nvidia.com>
Subject: RE: [RFC 7/9] hw/vfio+cxl: Program HDM decoder 0 at machine_done for
 firmware-committed devices
Thread-Topic: [RFC 7/9] hw/vfio+cxl: Program HDM decoder 0 at machine_done for
 firmware-committed devices
Thread-Index: AQHc1nG4jkRxZqV5Xk+1suvmucEul7YVcxoAgBQD5JA=
Date: Mon, 1 Jun 2026 07:02:01 +0000
Message-ID:
 <IA1PR12MB90304A1604F3C41C211F44DEBD152@IA1PR12MB9030.namprd12.prod.outlook.com>
References: <20260427181235.3003865-1-mhonap@nvidia.com>
	<20260427181235.3003865-8-mhonap@nvidia.com>
 <20260519140416.02a793ce@jic23-huawei>
In-Reply-To: <20260519140416.02a793ce@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA1PR12MB9030:EE_|PH7PR12MB7892:EE_
x-ms-office365-filtering-correlation-id: 739a885f-3ec2-49c8-ba90-08debfabae1f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|22082099003|18002099003|3023799007|11063799006|4143699003|56012099006|38070700021;
x-microsoft-antispam-message-info:
 BeKuS8X+aVNVEIBVbk+bKVAKmg4lbDsby/jKxMeQcaB7AcOngSkMv/bwuSNFJ9tODeOWy7+zVoRL3kBbwup3hhGxImp3kerVflWxxlEr7yELA0qBVaC9r2FGzgh1i3oM0Q4GBZY0XnkRYbnbiLJLzfd1JROYuSHlg0dQrXFtXkp9Mc+HeL0780J3ndVHZVwYUjKfwzkFaPPhUlLq1Al/tUsUBjfJdyw5LEYPlh1oS4xiovsdntbxD0YnvEax0YT8cqBbRcXLY7JCify345wuoP/siJfTnkODoxT//Nnyn6NLvZP3PH1o5xkiF+dYTKgBSTIsC1FeLjpAM+bHsjEspJBVBrXvACSqy+PE6NOD76koSedVVpHGEY43gcV3FO26Tiynqvz/xZBtzJvG5mSCtOXn5/eWBmpI8VRdvUN0HMEhGkXxVD3wgXK6Iv9ykB0wu3i7rscSwYdyYFkpRlnp46DeM5H9GJOAYcKbuc6FMlDIDS2+Wq8bw4bgIipK1d2svWsoAe/xspWQtleq6AkcVi9xrWRCu7VZUnY0B+aBiTD/zUOFkl4kFFDGbPu5thHNvGaFgOrEbbcKmgaZp/tQlr2a+CO4srUNLvD23ltb9HSz2chUyTQlLoFkVv6rEkPHOesK+wIfKPj2PEIt5v1y1DY8jbtAE+WU5qA789v/49M1GvxklqC4NZ6cE01J7Yp22a2iedrg+TTI+eQxRNoQjzmUH8ePEdJtKe2Scd7bQgJVBhzSvb52w+hCHDgIuRe4
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB9030.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(22082099003)(18002099003)(3023799007)(11063799006)(4143699003)(56012099006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?abmaNeqOM5gLjlRFWGA23n/klxdL2tm0K1GXDWtJFuFe5OdsGcG6gcU2q9RT?=
 =?us-ascii?Q?ixmucTGo+agJn6qhWzk50x3A7DfmwASKhv/CvRdeCYFefmp8xdD3lwCEJG35?=
 =?us-ascii?Q?9pzbNnqdEhkkVhNM4BeUwb69l7O8zCjXyGSvjcXSP886u8DdNFYWplLVpKaQ?=
 =?us-ascii?Q?QesclMgDRSXg3J1Ck4j1kd3Wmrtnw1WhvJgDIDnP7Ylj5a7hrunL7BA6/8AB?=
 =?us-ascii?Q?YFBeQM0F/PLuYt/Q/GkdTiL573mtymu3lT4d/FPpHyLVVIOy7jDccMT03cAh?=
 =?us-ascii?Q?q7/rQGCeV+u5ghhzT3753Qb8kWy9gLDwOg0lSZcczHcl/A3L6BOi0wIcPRh/?=
 =?us-ascii?Q?yfslR6/6d+og91jsAeqUmdtChnXm7yaBM1DqgMqzXMuJkHj906gGc0Y9wage?=
 =?us-ascii?Q?F+BqnDlNy1CBuDd7TPLiev1ZBI++ZL2Tdg1dIiwfFXQwIWOJ/1s2ZlxRm+G4?=
 =?us-ascii?Q?I196r/SttH4Ojf5+KanB7T+1Gs1DgeEWK8n3BxocKxpvqiIoFQ7lLqP7P3G3?=
 =?us-ascii?Q?UKo8okQgX55TrPR7sFhMTukcoj/3R13+y9e7+rb2J2ME76KHMaKlrbPd2luB?=
 =?us-ascii?Q?hbGOHDf7Eai3v1RIUIEqBOWeO402DYitOHAaHqMKz/vbBMORaSXMEg1t5OQ+?=
 =?us-ascii?Q?ZamL5yIpU5mw+HojiUYF2mHOM/F7QkK8roEIzEaneNc0ZyXQrfqIOKwi+1Wv?=
 =?us-ascii?Q?sBTNLWGBC7wEPFOPqym3EABxUBrUhQpuFs6qXzd9EnT+6K7mD1V9LEtrnqAb?=
 =?us-ascii?Q?shArYvHgU/S433YlfMlRnYm57+hcHVSRTNyerMd78O5TRORf5i7+yxkvPCI+?=
 =?us-ascii?Q?MW36HXeg2oxr1PaOpAwowy62kPNE7Rh996w8C3JFdKWcNOMf5q1CB9HnR5nC?=
 =?us-ascii?Q?ie3mmGmjLlJmiJwqRv8PSjEy2suIfzkLabu6wtuMkwr/VpGByhqoJKyrWTvg?=
 =?us-ascii?Q?0IeRWDaIsz15Qne1/rSOu7PTuN3XGD1c2PkvBGmsDDiXR4tZx21lQ/o6VD8+?=
 =?us-ascii?Q?xJGEoJA6KWiB3BqBDopkr8FBq/s5luLbJqSEEFl4UsnAvfevOBTaA4N0AAT6?=
 =?us-ascii?Q?5zHwEKX+GJnmyc3X2RB19CvF/JwZXL1CEqXz859jFA2U94BE9fuvVGmwvK3F?=
 =?us-ascii?Q?FKUtmsvRX6ime6RPpqTzswdOiLFW7Pi8zHvjj96FGoSRu3VNwIPUQsZM5KwS?=
 =?us-ascii?Q?cWAIp0/JelGlYNDyHTGitFBaJi/95YceJFUpi+9BOtQQwZ5YNQfTdAYt7bY+?=
 =?us-ascii?Q?C1ihwznIkHLDyz149bIaO7pUFiOFvDsXsxH8a3NWu11SEF5iwkhpWUqHScDU?=
 =?us-ascii?Q?AQkO4WLD8KY2XqgQv6Jd23iY04oi4tUNwyjUUPyDM0BmEqJyyhiZF8U9xMh0?=
 =?us-ascii?Q?5CNsDH5GoxVpe8rDSpTiBD5FDJkwyq04gg0aeAmxszLXeWOjhkz4fTHGF1Mt?=
 =?us-ascii?Q?fuKdgtjKrqrmxvlFVNX0F+lN5hB0pkTOo6LDlFxe+KtDPghvMavHD5GKwTP/?=
 =?us-ascii?Q?ZcwraxUzyPNIAzSf23Ozjdhi3K+cqvs4CSFN2AZXwcyVlk5RVzGGGqmMl7/Q?=
 =?us-ascii?Q?6/qn9RK7aEFawcx3HVHyWm8J43BIumUFqSUQAaYlLcgVEU9fkAV/pEcB7uQt?=
 =?us-ascii?Q?RMT2hnQWqdXdF+14ig7lzpUBw1YdAGeW9RK9KY0FugAC2q2T4zlcRYE9gF4r?=
 =?us-ascii?Q?eS6uIQNHJAtNdUPYEkgcTxdzEPWO9ze+HqtdqAcAQr7JGonK?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 739a885f-3ec2-49c8-ba90-08debfabae1f
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2026 07:02:01.4317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P0xIeBXZeu76c0hwrXrh/nzpatuaM1te0GtDs7bLxGD2pmVgj2zSguU2b7pvTNVdLzoXxS66XR6p4iu8jWuLig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7892



> -----Original Message-----
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: 19 May 2026 18:34
> To: Manish Honap <mhonap@nvidia.com>
> Cc: Alex Williamson <alwilliamson@nvidia.com>; Shameer Kolothum Thodi
> <skolothumtho@nvidia.com>; Ankit Agrawal <ankita@nvidia.com>;
> mst@redhat.com; imammedo@redhat.com; anisinha@redhat.com;
> eric.auger@redhat.com; peter.maydell@linaro.org; shannon.zhaosl@gmail.com=
;
> jonathan.cameron@huawei.com; fan.ni@samsung.com; pbonzini@redhat.com;
> richard.henderson@linaro.org; marcel.apfelbaum@gmail.com; clg@redhat.com;
> cohuck@redhat.com; dan.j.williams@intel.com; dave.jiang@intel.com;
> alejandro.lucero-palau@amd.com; Vikram Sethi <vsethi@nvidia.com>; Neo Jia
> <cjia@nvidia.com>; Tarun Gupta (SW-GPU) <targupta@nvidia.com>; Zhi Wang
> <zhiw@nvidia.com>; Krishnakant Jaju <kjaju@nvidia.com>; linux-
> cxl@vger.kernel.org; kvm@vger.kernel.org; qemu-devel@nongnu.org; qemu-
> arm@nongnu.org
> Subject: Re: [RFC 7/9] hw/vfio+cxl: Program HDM decoder 0 at machine_done
> for firmware-committed devices
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> On Mon, 27 Apr 2026 23:42:33 +0530
> <mhonap@nvidia.com> wrote:
>=20
> > From: Manish Honap <mhonap@nvidia.com>
> >
> > setup_locked_hdm() runs as a machine_done notifier after all devices
> > have been realized. It programs HDM decoder 0 with the CFMWS base
>=20
> Be more specific on this.  Which HDM Decoder?  i.e. what device is it in.
> Ultimately there may be several in the path.  Are you supporting that?
> The reference to FLR() later would only apply to an endpoint (can't FLR a
> host bridge) + the code is clearly operating on the shadow registers for
> the EP.
>=20
> I guess maybe you are relying on pass through host bridge decoders?
> If you are - you need to go check those - or better yet program and lock
> them as well.

Yes, for current RFC I had restricted the scope to endpoint decoders with t=
he
setup having default value for hdm_for_passthrough. You are correct, this
assumption was not enforced in the code.

For next V2, I will add realize-time checks in vfio_cxl_setup() that refuse=
 to
start unless:
    - cxl_get_hb_passthrough(hb) is true
    - pcie_count_ds_ports(hb->bus) =3D=3D 1
    - no switch is present between the cxl-rp and the vfio-pci

>=20
> > address so the guest can fault into device memory from the first
> > instruction.
> >
> > The notifier is only registered when the kernel reports the device as
> > firmware-committed (VFIO_CXL_CAP_FIRMWARE_COMMITTED). The host is
> > responsible for HDM decoder programming; the guest has no mechanism to
> > remap host physical address mappings.
>=20
> Maybe say why this matters.  Presumably because only thing we can program
> from the guest is GPA to HPA mappings so linear ranges remain linear etc
> (more or less anyway given constraints on how many regions we can plug
> into qemu!)

okay, I will add the details for this in v2.

>=20
> >
> > The function uses cxl->fmws_base (set by the optional cxl-fmws-base
> > device property) if non-zero; otherwise it falls back to the
>=20
> Why is that property needed?  If it is add it in a separate patch where
> you can explain the need to force it. Smells like a hack so far.

Yes, I will update in v2 so that this part is handled by the value provided
by CFMWS setting.

>=20
> > cxl_fmws_base global captured by cxl_fmws_set_memmap() during machine
> > memory-map init. If neither is set, it warns and returns without
> > programming anything.
>=20
> Which CFMWS is that base in?  How is that controlled?  We may well have
> some type 3 devices in same VM and probably want those in different CFMWs
> (we'll need to actually upstream the patch to control constraints so the
> kernel won't try using your CFMWS for those - currently all CFMWS are
> entirely flexible).
>=20
>=20
> >
> > If COMMIT_LOCK is set in decoder 0 CTRL at machine_done time
> > (left-over from a prior FLR?), it is cleared before writing BASE so
> > the subsequent write is not blocked. COMMIT_LOCK is re-set after
> > programming so the hardware enforces the committed base.
>=20
> Hmm. We should look into whether there is a correct way to reset that.
> Though as above from the description I'm not sure which decoder this is
> resetting.

Yes, I will rectify this in V2. This is referring to endpoint decoder.

>=20
> >
> > read_region() return is checked; failure aborts programming rather
> > than leaving ctrl uninitialized. All write_region() failures are
> propagated.
> > The function exits cleanly rather than leaving the decoder half-
> programmed.
> >
> > Add cxl_fmws_base as a hwaddr global in cxl-host.c (and a stub in
> > cxl-host-stubs.c). It is set once by cxl_fmws_set_memmap() and read
> > later at machine_done time.
> >
> > Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> > Signed-off-by: Manish Honap <mhonap@nvidia.com>
>=20
>=20
> > @@ -3486,6 +3646,18 @@ static bool vfio_cxl_setup(VFIOPCIDevice *vdev,
> Error **errp)
> >      trace_vfio_cxl_setup_params(vbasedev->name, cxl-
> >hdm_regs_bar_index,
> >                                   cxl->hdm_regs_offset, cxl-
> >hdm_regs_size,
> >                                   cxl->dpa_size);
> > +
> > +    /*
> > +     * Only pre-program the HDM decoder if the kernel reported the
> device as
> > +     * firmware-committed.  Non-committed devices need guest driver
> > + involvement
>=20
> For wording these can we be very clear which kernel.  Though I'm also
> unsure what FIRMWARE_COMMITTED means here.  Does it actually mean host
> firmware, or does it mean something running on the host pre guest boot
> (e.g. could it be qemu?)

yes, this is referring to HOST_FIRMWARE. Sorry for the bad wording.
I will update this flag name in the kernel-v3 and qemu-v2

>=20
> > +     * to commit the decoder; registering the notifier for them would
> write an
> > +     * uncommitted BASE value that the hardware ignores.
> > +     */
> > +    if (cap->flags & VFIO_CXL_CAP_FIRMWARE_COMMITTED) {
> > +        cxl->machine_done.notify =3D setup_locked_hdm;
> > +        qemu_add_machine_init_done_notifier(&cxl->machine_done);
> > +    }
> > +
> >      return true;
> >  }
> >
>=20

