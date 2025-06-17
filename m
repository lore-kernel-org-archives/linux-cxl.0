Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B353BBF2
	for <linux-cxl@vger.kernel.org>; Tue, 17 Jun 2025 17:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750182470; cv=fail; b=DDqRcr4Lk3Jqs3Dt3k3n1ryad56r7xIM570l6ULwLk6575JXL0w79mQlvcCaL2H2x0f4L3MhftZcs6c4cuuG4lE/IBK9nCFsZF1nD+QM0GoayLXU3iqI0F8yqwXNgJhVzrseckMXvjTV/ruzHwfURXcepnR5ENM4j9g2YO9ht7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750182470; c=relaxed/simple;
	bh=dbue0wBXFO82YrJo3wc0WN/PJiX5/LXtdM86cVL0nrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QN1b+RcFmp0JbUEDQEPYu2jOOW1In8XDnSz+Tt84hduJzYs4YmgMh/WLnQsC6Ty5EXveaJ8bl1ilF7ZkxqDLnLC4gG/SwAGd04yEXeArEbajmyNvCx/NlnNpRd4kIWraTlybaaeUeJ/MYaRYH+3vhwwnnbfiQeJhiYTKJuxzTX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Va1A/3US; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Va1A/3US"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zKzOasEb3Z5KfvM1zOAe1sVpzAFoyHzfYnWzaplsvzMbjSc75sF2d+R8mcGzB2oJl9pIk9I26oscWAMzb0VcLu6z4HMg/stX2AEBBgdr9eYt4X3y/z4Srq1dkyFYgEsPb2pKjlCRgodWiA8zQRoi05yMrvhZkm60RYZabIeXoQRLKOiSjqwdznfFcyHLNbJo73g1GHEeU2dul9Xm3oiLIy96RTE5VKxG3/7zKcrJDU1+PPbM2CBc2/dSANoGLXrGNJqcujmQlV6kP0oIhq1+nXq25TYKNvHZQwN6miV0fydtTJD0BaT5luesBBOr83d/E5XwJBQqFRAZwKU/h4BS2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dbue0wBXFO82YrJo3wc0WN/PJiX5/LXtdM86cVL0nrQ=;
 b=ZH/VxIxy7TMb5+vaDUBUW6NUMe/dqgpNvc7f4yxA9MO71LxM9lcCWguQCvNLPzxhys19DlithVtS3Oj2C8txlY0vqVhfvvsl0LrS763h1vWY6NXLbagkMciC/yDZoV8FQJ2aO+ZClStZHfBzT4gnLihBPAlm8955y9rEEJHH9IFvlDNJb2gCtAir3ZahbpHbtI0xQnobuqHL6euA5MgR8ZOORHsaswdq9vqY4b6++qeZKikEPhT1ZcnNwCqbjg0BoL2zsnvefwpNThVooV0B/nrGrDto1FqYZWQLcJMoNMz47jtH5gzVMALqYaKUoPDmhUfxT4RrfLczoWtDgi0cow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dbue0wBXFO82YrJo3wc0WN/PJiX5/LXtdM86cVL0nrQ=;
 b=Va1A/3USZgIOWh0a47a3xK9iAC6Hdf8p8drniYH/RFiTI+OIi8RGLyCzkvW/MeOFFyWRHk34WWolAWxjVB0GLarUpL3VUpIgKyelOcFLLgsmDc0KO9aCTyVZ9GYl34m7QEyu+BrPVQt+PYvQTMbON7m90miAFy6hhrUrnVGB+RU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by DS0PR12MB8785.namprd12.prod.outlook.com (2603:10b6:8:14c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 17:47:46 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%6]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 17:47:46 +0000
Date: Tue, 17 Jun 2025 19:47:40 +0200
From: Robert Richter <rrichter@amd.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org,
	dave@stgolabs.net, jonathan.cameron@huawei.com,
	alison.schofield@intel.com, vishal.l.verma@intel.com,
	ira.weiny@intel.com, dan.j.williams@intel.com,
	Alejandro Lucero <alucerop@amd.com>,
	Jonathan Cameron <Jonsathan.Cameron@huawei.com>,
	Li Ming <ming.li@zohomail.com>
Subject: Re: [PATCH v3 0/9] cxl: Delay HB port and switch dport probing until
 endpoint dev probe
Message-ID: <aFGqPIYg3ChfdlxK@rric.localdomain>
References: <20250521183443.3828320-1-dave.jiang@intel.com>
 <aDm3zR2LkC3joLFL@rric.localdomain>
 <ff8ec7f0-6cae-4c1b-973d-c126ce60435a@intel.com>
 <aEBp30k03GP46eBd@rric.localdomain>
 <026e7506-b248-43bb-9118-5e3c3d817c90@intel.com>
 <aEK4hx6wNkpvYK9K@rric.localdomain>
 <aExAezx8lmYIQ5GK@gourry-fedora-PF4VCD3F>
 <945da654-8648-49f9-8ed0-99c165d90198@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <945da654-8648-49f9-8ed0-99c165d90198@intel.com>
X-ClientProxiedBy: FR4P281CA0102.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::9) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|DS0PR12MB8785:EE_
X-MS-Office365-Filtering-Correlation-Id: 15de3174-7a13-4a1e-264d-08ddadc711ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ry7fMHo8xig35w3mHP6EpWXgmNOW+2CCSZEZItz82Q/hVVzBWgv0bLipciyZ?=
 =?us-ascii?Q?MW21EQ+SQ1ZYwGVhHbUPLOM547pF/OGE+g/IMGhVNl006Cof2VRJXpbEDDjK?=
 =?us-ascii?Q?o6WTy/p8ruUCGM3za6Et3wQXfJdV4XbyiITTpnmLt3kr/MzpGh9+ZBWzVd0x?=
 =?us-ascii?Q?Ayuwnm3+js+VrAjfkF4QpFr+irbhTAXsoVc6Izk2SE6GX7L/W9smYSsWEwe2?=
 =?us-ascii?Q?aZ2xVWgpGfHZETyLWLTyQzCiZotbtsB81iHpfWoSd9WSLprD2f2k7LuSZ9gB?=
 =?us-ascii?Q?QdhmMkx5oMz0QcnbVfysILg3pl+g3sLaJDOGFn9hWPR2eH7wTr+PXMPCni2n?=
 =?us-ascii?Q?gxPdvVd/oWAREEjguEIYMHMlJ386ih8SvYBzXQsFoYU7PkaQh7XrJrt35/jU?=
 =?us-ascii?Q?ykxi+kqzsciKjnaRhcpGO3T2zfKHqQWxIvQawlv/7h845j0xsMNoCKQmPIFj?=
 =?us-ascii?Q?e9Menqkn8ACo6ov3DqIetHtWlp3jKjbhT8nNskFBs+L1AvZPAlKrCeE3be+2?=
 =?us-ascii?Q?ki6BfhpovYjXuOPBS14nJTCW2ADxkzV/lgHFbQ+M5l02YuwohcMXT39ZM9zo?=
 =?us-ascii?Q?lriKm7VQtbx8wv2PPTKFdVBLEv5GoFgnMvwLXgJa/6Nrstl6x8X+o0+cxj4l?=
 =?us-ascii?Q?u/oJINz1VjINWSYN0Gg2L/8NxFYBE4nmGZlkoprzxPAq4uV/Km5DRS7p06n9?=
 =?us-ascii?Q?2/kT44+tqXFeUs91yfPRZ9DG7XVFmIKKqG5FjR6khGNeWunMeEqtrRAzpl5/?=
 =?us-ascii?Q?YVR2/AZKAHxMAgHVK/K1nMd+OeqKmV+v84HfOMc/Q1IG8jXbAhKMZCpMM7V6?=
 =?us-ascii?Q?t6PVhC0yta6xcOhpK7K4QNMzvMC96p8c/Pdm57pFrJZxQGehVEsIN3QShqAV?=
 =?us-ascii?Q?UJYdbnYUfj4KtFGSAjWkmLsNSEqvwmO2Bzf6XiqfRUUyviV1F66lXnCkDlrg?=
 =?us-ascii?Q?s7gtyF/bzCCqtTzrRiwneG9mws8O/X0CuT53Jgw4bSOyFiijkdsSeowte66Q?=
 =?us-ascii?Q?bDJ1kp6njN/SvuUNL7OEjsdMeuw+2xusv4LhKIUlnZaiSFjXdWalPxZqxN3G?=
 =?us-ascii?Q?rAall+PFGjgYj7UwPPMnkQuPITjXrLoF8Uemal2FkjDSH8b64yUxgyHpyzlg?=
 =?us-ascii?Q?0DqGzxedFsI0UP52X3jlWWbDuFjpLHs4yRTH9gmf2IOrf+qXmNqyasrlIaYT?=
 =?us-ascii?Q?cTX5rMmwEDmIp68+/GznRg1dw2KtQt0iv06JtnY2VTtBR/GrpDHPXaU19Vab?=
 =?us-ascii?Q?uEreDZkeV/3qopRsYchrBnQyTaBRPgZh/l+wnq2e9jMX4ngTHWCmPbRpo1gK?=
 =?us-ascii?Q?huz30OW7t8dJk+tcffyF3RHpnZPXcZoPW+mbZ9jrs00YxkjAZMJrWcdK03GA?=
 =?us-ascii?Q?t0LjIDM5tv89hgVYbPoZXrWQvJU5xs7RS8hxbx3zN9QE3Q7/tQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IgXqInBcTXCJSzlwe3GuDYiBjwECxgW5g/DWT7CygwVmqEw91DbFK37MxBGG?=
 =?us-ascii?Q?NWuNv300W18cdekxpfBmKjNktSGFLHCTq0ee4yTmG1SmfXRhgv900LA1/8BY?=
 =?us-ascii?Q?tICvjlmLCH0oAHXec+NZkBRv2sk8fv3FUhEQXYfMtN8fGhs3uOe4m2UijFMX?=
 =?us-ascii?Q?TqLboo1eg1wVFZ7ZDst4PSP25jCFeZJdQ3QSz1+PA4MdF/UVq+8PHuHXYUoF?=
 =?us-ascii?Q?ZdipLWRyj56nVAPiREnRk4jWJEIbBl52v6DGktJi7fOfYip+bjmwd+G1Gk//?=
 =?us-ascii?Q?Ht2gqMWNYDkBnQp3EQrG9cOqX/JzRc462P387XK+iVqojS8N2ywuVRUNWUGK?=
 =?us-ascii?Q?pn/QGcr3bD2EHi//1xcX7VZu7Hfh5nRnPuLjyVTsr7kt7MBTjoIMoR6367ho?=
 =?us-ascii?Q?a0FuALA49ypRZ2N9Kf5KTC6R9BKruftyqBR3crK70HVRTMZwqBqVjTwTUjQC?=
 =?us-ascii?Q?e+O1VQqLgPMavyLUXlgM88jnVJl6Huau3EdrKSdXulwiA/Z8qZ9p05xFo1An?=
 =?us-ascii?Q?WiVX+Utn9GdbmDq8Efqy4n3ZuoBvwioOR8oWweyPz9yQPRwWUIJdTh39ZMv0?=
 =?us-ascii?Q?QW0xkDO+kmlmjQOXlIFz7NIcKl2KKlDNPHlgioCDnwSMU+1C87DFc8ire3q8?=
 =?us-ascii?Q?hA+gfRCsFhfv+hkcSTa97SfQPyixWOzAKXmnCQz1Q5BtnTFhsxtKK+KuK90A?=
 =?us-ascii?Q?KYcZGopNDSKaiIB9s9A47OGYdv/Cdw89K5rq8NWfiPUvMmaZaGr+gpGQ2XCI?=
 =?us-ascii?Q?otxGEo7DQeV6VSEoLo7eYgIDxUoGrG+FXWnkwZLKtQHUP+7/cLXwABquk0kp?=
 =?us-ascii?Q?BypxpWZ7z6+zzc+RyaNGGSITLzKVJsuQ/Zo8fUjtQUDjESlqXOtlvWNSbZcR?=
 =?us-ascii?Q?tqj2nU327DLRQpqpqlud8TJD3j4ZfaEiIDLQeEyYr4ldPJbn7tOZtEua5P3Y?=
 =?us-ascii?Q?t4MYTUCgJxAzvHudwZDntstTEQZAERm013bdQd4L0Em1VrX3fyu3zqosicNY?=
 =?us-ascii?Q?0D8BDTavjINc4LjM21eALaJqOm9fNaRSJCnRlA/LGLIZ/L8UeuLCv3VL+CcY?=
 =?us-ascii?Q?DOkwdlfumlUjuogJvhJwMSY3rOFY7xqsXCfpRfMXQQ9mky30vSQ/uZ8kC1Gp?=
 =?us-ascii?Q?E1pNax0FllfWsJkFgzOfbAR0qj0wsPOB7XHRfjIpg0x9OsbXEpQ+Gt92dlG0?=
 =?us-ascii?Q?0mGRPjeFvjrSzF4tYUFuphIgxQoovykD2bVBVYFdnAl1Z7dSvR+uzeur1gqf?=
 =?us-ascii?Q?fKkH+2vPGFXry1NrXyxJRyT4bAnRQqzwabalIg+DmI4LKXcRdtTuqsNQJ74l?=
 =?us-ascii?Q?OHDRwQ2QNEYwJwk5bvLkTIjLj2ibQWrUyxJHNwd6qeb3nnyAbyp4+lsupBxv?=
 =?us-ascii?Q?01UoR7D07AvehlyLqEsETdeVyGf4m6md7tuLDtoVotmwef8kdWem5zmOeYoh?=
 =?us-ascii?Q?lbNhdNwkmvUYtY7Ef2+zv26tFh/gChsgTFHSGIltP0khB7CW0m83jBTh7A7t?=
 =?us-ascii?Q?57mY+BBC9tYGbLlFkbwrxQngJu9UITAaYMRwx63t0GDwwQI0Y1w3VILccB63?=
 =?us-ascii?Q?21hLgou7rLnnGL24lM8HXoEmoiMwausw66RsbmcB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15de3174-7a13-4a1e-264d-08ddadc711ad
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 17:47:46.5284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wZw2mZAMlQOUx25rb1csYcl/NENDAbUMbIMA3fwbU1pv3Q/F49ITB4yoI8AJ4uSez0HhqIiGZfV7G0FE+joWZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8785

On 13.06.25 08:43:30, Dave Jiang wrote:

> I'm currently doing testing. But so far it seems possible to do
> dport allocation at a later point as Robert suggested when the
> downstream port should be valid and we don't need a separate virtual
> id. We'll see if I hit anything weird. It's working for me on qemu,
> but cxl-test needs some massaging still.

Great, goint to test this once out.

Thanks,

-Robert

