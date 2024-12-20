Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBC739FF3
	for <linux-cxl@vger.kernel.org>; Fri, 20 Dec 2024 22:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734732584; cv=fail; b=KJTzzlc6algLirMM3reaB5Q+ln0Ygw9Yv64U8FaAwXFxP4Msdq/m9sEsxcb13KnUNiVzFdClEplSZFhMJC52dRMjEsp1frOAYLI6mKSlpolnnvmca5siyFeYEdeGW4+65GCIbytAZdCE2nGz0H2kWApSflWR+clhSxHAj6j0/+M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734732584; c=relaxed/simple;
	bh=o+YUfBi4xRB7S+KyLMJY4/xufLcN7ZFJ4YlfjtX8zGk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hcsbpC1ubCPYYanwfUipjfDpS+QnYd/IBJZaw9Cu2Xd9f6n/U2gU+w9kHOjlqxbcHilju5JZEgxKpOxjJzOhR2kPUhG7isplsNFsmivc/mm4F8Q6E0FBPYeI2/iFDBR7MyC7iIVYp0UE8KAz/KRljbrWNBGSuS9jsS4Zgu457uM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y2Om3CWD; arc=fail smtp.client-ip=40.107.244.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y2Om3CWD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hj8S5sijHaquVyB4yEBq8WKBb9gdwYXzLHVADDBI2eGhwhD5qaoNaTBEU4rE+gOj5Fmvu8+MqwfCIrScSgBvxZjDLfQnCZZbGUllJyFCLOAO7EStOOFBge6D7SI74p7nSvMJohIkOuqt/N/5h5TF6skZtn6pRR4prt+uqRMaLHZF5C6/YoIre+ffxQ1X1YfqbIEmH4nEzMn94fIqEKmsHDCIAgTnzb8O8j6Y0xJHj07rHpbSVkG8qXKMxAO9BK9b6xrgqYVqZ89NAbh8pp4yNa6fxAftDX9v1uBCj7ErTqHWVBbFUxHjYRV1kSf70Ul+T9u2lESD4zNSDM2sFxpgdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ep/uJNGG4mXLpfoJfQCoNTyJf8UueGMvcVuDMv0BYys=;
 b=FJhSIXmS5MuSAbnROgEKtpIEjEMGh3fXp4qyN/sD5/XJS4dbXN/wf/VMRlAB072gstdF3WnpwjJe8Z8b4pl9buPXs9JB/ZTHecFg6hVKudQppoz6NK8sFoupIa11G03NS2mjeCblLyWqlXLwdEanqytrio3kG1ZqL0gzf7SjkxLZv59NU9u0ro6D+SmwkBS05c8cEviaSfRW8uBq7A5nU1mJPrU5yRiDlyjHHgUiBrDeLe3OH5uKqO1JW45XXTltf06xRF36HF+Ob1Z3cLeXFi8OcTOkjsd4oQcjNltvFs4SlzfQ6G0QZIi3uck+1TSWiKNPOsRWBz2H2Xe4KiUcCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ep/uJNGG4mXLpfoJfQCoNTyJf8UueGMvcVuDMv0BYys=;
 b=Y2Om3CWD0+hIihjHh/K8YVtiX+72s15rIN4UJgDsAc3GnI90dWrpYqV+7QIpOHIQYZIpR/Vka8efsIpplshLiD/W06+M97wXVHk61CIJohOlnTLuhSDiCwhndsMXE2lVoRR8drWY5VCFOpNiHqajkGYrfnXDe8oOQoMU2x+C6Kl+U9xHLEp9BZrDnFfLaPf58Z6ECzYuFR6rbcVrBNynwuVKXGA9/1kKHJLIFMlWCv96tjIpyF1Zid1dtbLL79u9q4USsqrRSUO72TC7iqmBXqsNClIdVvRcfMHEBI+dTjnw7PeZUrdCGcIU84+DvqEyfRuZ6JWkCJXNkzsS3dkrKg==
Received: from PH7PR12MB7968.namprd12.prod.outlook.com (2603:10b6:510:272::20)
 by DM4PR12MB5988.namprd12.prod.outlook.com (2603:10b6:8:6b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.16; Fri, 20 Dec
 2024 22:09:36 +0000
Received: from PH7PR12MB7968.namprd12.prod.outlook.com
 ([fe80::d6d8:c793:e295:e6a4]) by PH7PR12MB7968.namprd12.prod.outlook.com
 ([fe80::d6d8:c793:e295:e6a4%6]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 22:09:36 +0000
From: Srirangan Madhavan <smadhavan@nvidia.com>
To: Ira Weiny <ira.weiny@intel.com>, "linux-cxl@vger.kernel.org"
	<linux-cxl@vger.kernel.org>
CC: Vishal Aslot <vaslot@nvidia.com>
Subject: Re: [RFC PATCH v1] cxl: add support for cxl reset
Thread-Topic: [RFC PATCH v1] cxl: add support for cxl reset
Thread-Index: AQHbTTJ+/rGT4upjzU6dhrL8dd5SYrLqsG0AgAUMaxE=
Date: Fri, 20 Dec 2024 22:09:36 +0000
Message-ID:
 <PH7PR12MB79686143DE81D3156525BDBEC3072@PH7PR12MB7968.namprd12.prod.outlook.com>
References: <20241213074143.374-1-smadhavan@nvidia.com>
 <6761ae926757a_2a169f2940@iweiny-mobl.notmuch>
In-Reply-To: <6761ae926757a_2a169f2940@iweiny-mobl.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR12MB7968:EE_|DM4PR12MB5988:EE_
x-ms-office365-filtering-correlation-id: 4e38fbeb-695a-4f6a-ae27-08dd2142fd9b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?S47RHky/ZFIaApZWxJrS0WiBRdjIYspg3Yc81/AUDTwx6Xt2nvLfbJL2?=
 =?Windows-1252?Q?lFdsL+KGbK2dCgMeMrJEbziHbxAPvp0NQkiXo0s41EtrqWnNTPQW9fhb?=
 =?Windows-1252?Q?E5apI12jj3qCPwMBDoGzfTxxMgCxgvpv42bfXmxBwPLh72/FgmmZDhaO?=
 =?Windows-1252?Q?KIzUBukvnG8aacWFf7Yz/oqucSvWNlD1/GjdhF9RBQFYtxnUvbCMvhUe?=
 =?Windows-1252?Q?CN55hTuHSGivxmWN5lc01Z5P/g1zhKQOV05ihohLOi6vXiEh2CLH+pyP?=
 =?Windows-1252?Q?r2lYJXv2gue/qqBPD7Im2r+EGMYRJzgcUqJGTKP5AmicvfG/9pXo+uqo?=
 =?Windows-1252?Q?8oNfw5C4owJDkTJ8u2n8inhYnYj9eSXyhiBC16iTRU1PJcYXw2gIbaak?=
 =?Windows-1252?Q?0h8LjkBGv9VMeRDvLvWV1p/BsftKKjsnYL0qzR7BeCQh0CpIaw092YgC?=
 =?Windows-1252?Q?GE33LsXRRBYn07RAEXEARSfvWGh+M80BsPbFC5bWTX8u0Y9PBANzIS4B?=
 =?Windows-1252?Q?RhrjnOm/Wb9+Sc/f1fGGXoGVllNoCMYpDMTGNQbVkiZNyhm0u08t3Jj7?=
 =?Windows-1252?Q?1UFRO/M7xYgYGydTKB1Oymm6pa8LsN1nYuKYpSLo3pBw6mLtOr8LqwGg?=
 =?Windows-1252?Q?rotmajEF/RZ0wVk/ahbbqYkFdF1SyWRYgttiwMc5GiqZJi87HYZEV3vR?=
 =?Windows-1252?Q?5j3cLD4w5DZtbx+q79b5vye8kxWSO7nJRKyjv3VFi6tF00JwxVU/KT1O?=
 =?Windows-1252?Q?XipbfNc+VYwncTZduZ8PXOkqatHYWDoaWcaHr7Vn4brq2PSG8biu9bVF?=
 =?Windows-1252?Q?BV3YyNARO69K6ZpUQYJi0G3w/H0cNfttDfaXq/jMsUgHQSUFQKJXkupV?=
 =?Windows-1252?Q?9wF8ponTt+jYViorU0HpQoONLFcOslZzsVWy/lOW3S2ozT0Ml4efKfYp?=
 =?Windows-1252?Q?uTUlx6Orttm9+ztFtXUnCd8xDFs3WAOEjQIL7YB7V0W8eZ3zTWiOC41P?=
 =?Windows-1252?Q?LuEmVKrDJgK6umW63NWZ3dEtEBbRnza9Q1FfWp63LFEK/ewKq7HpBwYi?=
 =?Windows-1252?Q?tEirHOVCGUAqV5Icq4x23MsA6AZoY7xtCRPUQh//EmqtXXGz3uQis4E9?=
 =?Windows-1252?Q?mNgpN+HV3GkB1D3Tc3Tzi1T1e+ux0JcUybyPgcvd/FbbQOv/UDbDqbYs?=
 =?Windows-1252?Q?40TZAqooVlqGcjIH3eAQ42SFxRehwv37kipLMRC2QjLatA5LRtmXGKzi?=
 =?Windows-1252?Q?6MCYm1U3dpEA8diQcms11/dYXA559WjcFfHOX1dRplPpKjc2T9iilTE5?=
 =?Windows-1252?Q?ybKquh25csYG1OKe2xchSnaVOGUo1m/DlWdibGY+KICZlgcWzPJwpPPs?=
 =?Windows-1252?Q?if3/UHaUuCM8LwX08y2kcYQzL8+3AnJwGHNaVIkSBSNneeNpluTCLQ50?=
 =?Windows-1252?Q?NHulHVduxNf+AleifYh5VBpKFZ/+ZD+1E4eSRQeP830BexiFB4DzO21z?=
 =?Windows-1252?Q?ZmYBcYjsknbBQpWhoCZJo+dhksSx49Toyzu9FFUBzCCVLVWu+wfzQkcg?=
 =?Windows-1252?Q?PAYw5dMnlGZDdZgZ?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB7968.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?K3lpcgOcRlkUODL7pIOZLr8EdKwxgfgXAMLdRZQ2wBpAqdDE9jf6JYGS?=
 =?Windows-1252?Q?LoYZm7+bBzcVVmKWqGFS8o9U37rg1uwv68mpE5fil0TNLmDU8NU4sMtg?=
 =?Windows-1252?Q?97k5iWWBEfp4Ue3O4ybZCB9a0Ej6YXhFk9/eyMmcky2Pwdh6d3YQoCSg?=
 =?Windows-1252?Q?aauL48oFkgH3tCqHpb7RAQ8Py99Rp3mWmjW9KcxBh6UlmAoPhzhRAIKR?=
 =?Windows-1252?Q?JL8JXYn+j0L4bq5AYwz6o6xm2MaIJkXc21CwQ+h4shwgNm/prjs+4nQz?=
 =?Windows-1252?Q?bEQXZ4kvXDlS6XIZlZeYLcWzZTrkQdZxZGDLC6vVT6bkC03rh3TB3vvC?=
 =?Windows-1252?Q?jEek5/zMgLVRNShCgBQU8kPDttrs7BZ89UXjD1GIl/pty2G+hM7MZekA?=
 =?Windows-1252?Q?uanluGv+R1zh/UgAijswljcSIAO0a92rm8uIdOqC2Qtzn6NG3OcKYjeg?=
 =?Windows-1252?Q?NM9aw3QbOKFbil3x5iVFmyzCVvEIVa2d4pVrSaco9h/pzUdSbFK60y24?=
 =?Windows-1252?Q?NMYpbliJHQIS9F4wHuE4sq5GEGq7we/SgM+Sm6sLg+Zh/b4qJI2KftNS?=
 =?Windows-1252?Q?YnD3UVZwBKowX2261LDnE9UuemTqlZlYxLg9rEuGzNco3ZjiPxuKIIqh?=
 =?Windows-1252?Q?yQBBFWuXxpj2AWwzmCB334TWanWXQ8KoNIYSOrAe+bhTv0JvkyH0GHMN?=
 =?Windows-1252?Q?aNJFB+qY5RnJpUECPCdsyTPNiNLmrJ/qMoJeFmzOs3jyiVIlr3GhCYHc?=
 =?Windows-1252?Q?iHilc9N7UP0vX9TctXqRtHHqwdbttN0OLU/BowLO/fZ7vSTVSELcjjZW?=
 =?Windows-1252?Q?0nPUiQiqXsJ2bVEr+nDlpwBt86pXcnOt/iunLPqG/wkfyQgUYksPAkbo?=
 =?Windows-1252?Q?M/I2VyO8FBqEOSbjoi8lUEwQXS+6HPTpsxFnT6ZoIaK0YjvlSIsJGvdL?=
 =?Windows-1252?Q?fGmr1rtOFOdvHyHV7JKlpcwJUX7k5UluCl5307iPBeDolsQatY1rmsaf?=
 =?Windows-1252?Q?kuNtFGmcqDq+xiMXL/NLTBszqdhCilxJpe2FtOG3Z0XQhS6jYYDL4RAV?=
 =?Windows-1252?Q?Lc+AQXfnPF7O7P3uUZkFBnHyZA8g+61pcYjCGFynvP0+cMoFY27hIZQJ?=
 =?Windows-1252?Q?+7xHOU1cYqvsc3AJ9S7HcmNXOURdCQoYTGLO1P6t7LLrM3wHXc6wo007?=
 =?Windows-1252?Q?4NuLqHEwxopTBX2Ng46a4F3BNXr4kGBi4Z8qJII//BVaEChuoacl14Uv?=
 =?Windows-1252?Q?EhgeH72jltCg20N16clxYS8QFcaF98uVxcJeq6Lr7we3Fj7C33VKrbCD?=
 =?Windows-1252?Q?Zfaf5yncCLJ2hmT50zFp0N+JFUjEvpGxQw5InCNKg66jAQpeWdm+hvtU?=
 =?Windows-1252?Q?BUD7C0vyLtKwTpEzAm8LAs6CDccthiJ2p5hqj8tMqEJ/J53pfdijCioi?=
 =?Windows-1252?Q?fQur6L+9wuznFG1EfZJmInQ1caeE89NtUaYji39JWSPndjUlXFdLsp6g?=
 =?Windows-1252?Q?FMTOuIuWg+M6mi3veLaeWi5azg38kN8QrlvpjV1ZRd53RNApzwPYTucH?=
 =?Windows-1252?Q?QQiMreXTYDqT0eFhQ7qV10SUsCFFHZxLz/LJXtRLGUxdLR6rL9MdYcjA?=
 =?Windows-1252?Q?2KnRS1mkk442IrrVRievpf72SEQggW9L2NCK3+OBavCLznc8L00ukf+J?=
 =?Windows-1252?Q?3KZd81zk1Hy5Jfou0bqFOoegG6tsONrk406XvSOCZ04GGP1wUSErYU3y?=
 =?Windows-1252?Q?GcqidosPVjzUIuO8Nj4=3D?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB7968.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e38fbeb-695a-4f6a-ae27-08dd2142fd9b
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2024 22:09:36.2753
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V8M7Oa+cEoQvFOOA5H8ehYtNmMjjKkks5GDRGEensGZC3yOl6TR54/ablIN+IkJce7prP328kpbSqBnyLNzaGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5988

External email: Use caution opening links or attachments=0A=
=0A=
Hello Ira!=0A=
=0A=
Thank you so much for your comments. I=92ve added my response below.=0A=
Apologies for the slight delay.=0A=
=0A=
> Srirangan Madhavan wrote:=0A=
>> Currently, there is a lack of support for the CXL Reset method for cxl=
=0A=
>> devices. This change adds the support and implements the common reset=0A=
>> steps as laid out by the CXL Spec v3.1 Sections 9.6 & 9.7.=0A=
=0A=
> I'm not sure what the use case for this support is.  Do you have a use=0A=
> case in mind?=0A=
=0A=
=0A=
I think that this change would be broadly useful due to few interrelated=0A=
reasons. Without the change, even if devices are capable of CXL reset,=0A=
users will not be able to access the method. Considering the changes=0A=
to support type 2 devices are being added now, there will be more such=0A=
devices. Adding the support would enable cases where more fine grained=0A=
reset is required than bus reset methods/conventional reset. And FLR does=
=0A=
not affect the CXL.cache/CXL.mem protocols. Spec also mentions cases like=
=0A=
FM uses CXL reset for rebinding, error recovery. So I think that adding thi=
s=0A=
change would be useful for all devices with the capability.=0A=
=0A=
=0A=
> What happens if there are current cxl regions mapped to the device being=
=0A=
> reset?  I don't think it is enough to flush the caches.  Section 9.7=0A=
> talks about system software requirements for the HDMs.  How are those=0A=
> requirements met with this patch?=0A=
=0A=
Sorry for not covering that. Your & other maintainer input here would be=0A=
much appreciated. Since =93system software=94 here is not very specifc,=0A=
my proposal here is not very specific as well.=0A=
=0A=
Considering different platforms might have specific operations to=0A=
effectively clear the regions, some type of optional helper routines in the=
=0A=
CXL core would be appropriate.  This way if required, a Type 2 device drive=
r=0A=
for example can choose to use it if required.=0A=
=0A=
Thank you.=0A=
=0A=
Regards,=0A=
Srirangan.=
