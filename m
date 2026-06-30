Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010012.outbound.protection.outlook.com [52.101.46.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72537248F64
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jun 2026 02:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782787868; cv=fail; b=jsaVs76NiF5evnlzEQ/UgA9VA2LqeVfCa5mfjfFuKb/ju3h204ytsU3rI/kvP93531QZun5YN1F7+95hKN4JJFZCOAa1IK5L91N480nS1dYpyqLC2PSD7Vz5RSywNOHLjWFFvcN7U0on3extH6fq7Kovd0uwZCu1QJRm1lFV4s0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782787868; c=relaxed/simple;
	bh=vvtEpwThrVlcS1Cl6JXQ3LPhtCYaBnDB11864FdEIIg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fe1K3cZlpmEN5/8WDTl9+/aKwfPhxsWyhWlZLQ/OCPU/Bno7eLyb/VtyqJhLcqTQDt1QNo8FteIQVSaM2RNqtCO4jaH7wOjezv6kGwzxxjOn12xkwFH+9jhKS7jXvI/pF9ZlniZhzRP2BfoPm74G2HiRmToTOPVOD5bszAciUH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EMkQcr41 reason="signature verification failed"; arc=fail smtp.client-ip=52.101.46.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EMkQcr41"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GLDdlNS/NWT9DRAI6B8bmlMAiKIaCdlbiSUZMasmAdZXWsMWiIn0jm3nuSe4RvM1tewhGqwcqkK68IydD41vyivyNWM8iYT8So+flMwbtNOh5YaHlcNTCFsD7iX7u0zlON9ESCvGIlqupGaf8lpJe1rHKL5GhnhhX/20fkSGXlo7hND4XnNg8O2a3BnpIt+R2NUtI//LXryWwy7nDm3pJB2NvDcHA7HyX9rVA2Wfsmf+qqMQNQlOuw+wF/iGAo6F7yMiXmrs9//M89u90zK9DMW93sOsqsVW77sCJ+AHvxfjCwAQqfzG/glidj6DI1UjvP/2MMLmpXLZzAvo2rKdJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Noqm2U9Px2aGUP/jsjDcy5FYMbHChSzB7PIK2uPZUjE=;
 b=UgqoemN5kSOmDt6uZcZ/pUyvj9gkOnLpteakfzcSt0QG3arV/gSr8EB8xmejEQ1RlikEKq+KdAxbm7C/+LwVwdu/fnPqbyRkBvrZcIxICLyEVnQBtE0CFvv3/BTZm8WWZGb1DkK858nHFnDulOmWGHpBgq+BxS4dcoWapBi1nSgxUGztbHitkkcWTWB5ioNsuKbxhMA9lRdJKD5wxIDwYKraGjvJkNSViU8EIltIElIVjQDhtsUQNMZOgWHjATxU18mzScZnP4w5LCPz3mui9PFY35eK0Kj5MOroq1P9mnHoGsRdDiZb6se5sS58h39kyIX09Z/PVKybHhovBR1UCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Noqm2U9Px2aGUP/jsjDcy5FYMbHChSzB7PIK2uPZUjE=;
 b=EMkQcr41kkCQDT4IIB47dQ1tNzEzcO+bjfS40Cqtl6zv+NgVZ53FNOdM+M2axCcthMBH/m8Pa+hXGj+vLpyEnSnVEIDCEA792iwnGAzPlc6KvhxUUxmQ6gPTNP27jxGf1bUWqu1Qug+bWGHQsEe+zxYCnPVN4czfAvFRdNycQA20AVBEoRqU4CM1e3Vy5ZNsT9uPb4i2Q4L06PPOB48BN3By4E0uwDCYBhO6C9Zo3lw3rWSruEp2O75O97cTe+5Q9T3mBT51nHiYu5ko2umDrE5ZRyIrSXqOGRJkWiFlzAcxK9C9bBWjKClE0fKDosJKubidguDxPlPJP+N4V7ABHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DM4PR12MB8450.namprd12.prod.outlook.com (2603:10b6:8:188::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 02:51:04 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 02:51:04 +0000
Date: Tue, 30 Jun 2026 10:50:57 +0800
From: Richard Cheng <icheng@nvidia.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3 1/3] cxl/features: Reject Get Feature count larger
 than the output buffer
Message-ID: <akMu49Z1Xcm96XWE@MWDK4CY14F>
References: <20260626104102.53892-1-icheng@nvidia.com>
 <20260626104102.53892-2-icheng@nvidia.com>
 <20260626105407.909B31F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260626105407.909B31F000E9@smtp.kernel.org>
X-ClientProxiedBy: TP0P295CA0016.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:5::20) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DM4PR12MB8450:EE_
X-MS-Office365-Filtering-Correlation-Id: 3345730c-7fb1-4ce6-6ea4-08ded6526d33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|18002099003|22082099003|11063799006|56012099006|3023799007|4143699003;
X-Microsoft-Antispam-Message-Info:
	uel9sP5HaQ5rXQuGanxBiDE7zpbRIb3fkAQOe6k8M3/BCkY4ok15HfeeYsreQH1ovK/b5VuQYE8vkEto1Q59BTNxZ0h/jTf6yExs7bcUo6fV6h01rFaJkFgO0bfoWyeqeJnJTuWu4PMB7Je0bC/kCMYXje8Wjr+m+gOrgO2qaHRytnDLKoa8DX97epIvnSWKLGCZd2SABnONnFXQBSmYAkyR6KPUgR/HfqqMt6N4WeJRnRGC2UNULxSs2nm6g377ZXSmCugfjWe+fkukW7YxonFE4hS9O0N+AzeVegD/P+KeoWNutOEsF1wDwTA6I37qqQim6jfgPAAsEgwqxESeMm4JNcgEcklQznqF7ir4DhBDQc/SyG6wWHjVrQ4Z6nPKgsM6kx/1ygKeQcJlQc0DshPqRK0zWwQ1xlIb6f6evXOhuZTvqppIw6UsDS5wLuF+bEzRVoX/lAmQmv/IRK8oEz++cBfYawgGFSu9zV6Y+MviF4+3dKnCFPP2ls3dRRGwjacr1t1YoqopI7iZ1oyNLS0mXTRfaVPjhy500rOc2tfwB/2+8gDqaTyilvTJJTOW2JOcYAYmyY4YXbK+1I5EFaNq+0Poth2fq4dtCr0SB05bUvnz2upZmukj+N5drAd9gJXJ53vgIjLHIMHVG0kJKDp/49/adLiWy8EvqtLHHzs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(11063799006)(56012099006)(3023799007)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?9pWoBp6mJfvT26HgjPBD7nIYCM5BznZ7wYehJhZCShSZltUgtTYF3F24pV?=
 =?iso-8859-1?Q?4bFJwTLF051Ra0JwJMY61joeAIQrIZ6AbfSoj/uVOqCVsg16yZyw7nZ5CX?=
 =?iso-8859-1?Q?LVb4zWxCOL7Q6oCKLxVgkrWAW7t4P8NdxCMkKvGUMnndt7uy/Mhc6tve8U?=
 =?iso-8859-1?Q?nEv14qo3kS9AngQylIGmnYPSgyMXUAmnmhn//YOpOyRuOXSRxigu0AggJo?=
 =?iso-8859-1?Q?Rf+WJ9kz/wfas8ZCE0dlCS+zL7ZJucvBwr29hqkbypkjCliLwbwDFHiDNU?=
 =?iso-8859-1?Q?yEw8IJepSdZINU5LO2c62yc+LVwkgRMB98QdquRmjyyo4ctoVntzUrdid5?=
 =?iso-8859-1?Q?3z4MnI2D4+07MZ76s8kWL/3L6u8eEgOnt6AiP2HZ4ZMF1Awa9VNVwBNlTJ?=
 =?iso-8859-1?Q?7Ug+zjGDdxF5xRZWy4QtipDGZl4LM6EydWJov5OM9ajAxC7fOIUNtjIeUO?=
 =?iso-8859-1?Q?Ib13Y0ChJA7femMNM2hWXthtQxEy87+gnmZDgMzkkjRXskkTSGiK4ULcq1?=
 =?iso-8859-1?Q?+hI7SQVpknUS69yV7D9TfNxVO3P40tSgahOvx1lHuPiVYfxKxvadpFP92k?=
 =?iso-8859-1?Q?6MTSJTNdCzYWAgc3BBBY1cjFuQZCM76CbeqKcEcHvZYfWOwU58wLQmvDUG?=
 =?iso-8859-1?Q?5tsxc13i6qRaLI042GfwUm8JrKIr3O86YEPlVw17gJFHZZpCaNpZaEi318?=
 =?iso-8859-1?Q?BYDk6k3xy7o4+vMYjd8hw8dlUMDISLsmiIjUE0MML7WNKRh4jeZAsCcKHg?=
 =?iso-8859-1?Q?rJ5V0NIao+CksuWVLEnH79E3JEAQMVvg2zQYL/lF4DfA6w24kX0OKS00/X?=
 =?iso-8859-1?Q?etjCq0WW29eEUaGa6dBHvkMpmJOhZvxGb4+jfCk9Cimdgcm8w/a6T58AWY?=
 =?iso-8859-1?Q?xd8mgn4r5bBTmL9tY0cjg5ATbYm36NiHkDW+OIZ8gUvbTH7FjSnQ+quFzs?=
 =?iso-8859-1?Q?6FRNczN3RTqV8XPtI0ClbXdYXxFX34w9nVUiKNoVmDGZwILTYz9WJfoh4N?=
 =?iso-8859-1?Q?ArgrFzz2o2ZOFfgta+pgTMiT1Q2/Ae9njPAply1Qg4w/YzzCsltnyvk1am?=
 =?iso-8859-1?Q?PcELofko+3yQ0r4TP2+4c3jSnyqS+MyeuOByan2/0HRC1iDVkf7PtXzfVN?=
 =?iso-8859-1?Q?RMWNyWhCHqVR/Ktkd6jrRZhDMbXLUwqv5qtA6MaSuY7Izt0vz8nWvc1WH1?=
 =?iso-8859-1?Q?jUO65nqfM+BlOiOzHpXqM4cAVzmNc3Y2ZC2pVdW3d8nrDi2gtcQopbXHjv?=
 =?iso-8859-1?Q?+8VVilBIwv/6SCApgaVR7oNmtj/NRhzEVPcTETPwyYC3+T5eMZFPMS1bxv?=
 =?iso-8859-1?Q?81lJQwrIhanmy0cgYjQ+uksOzMO2RzClM/Rb3vdMqhDyD+6jBFLxq67oY0?=
 =?iso-8859-1?Q?vJ8sY6FOp7HBH9uPV4bBdEP5KBneyLdX5X3H44/9zBQ/qAgrGjhio19DBE?=
 =?iso-8859-1?Q?s0dF7+Ppt5sWlciWmiNYlLVXDFvrPqAWrlfzHMQv9uW4/EhaZa1M+48Ltf?=
 =?iso-8859-1?Q?DXs9wje3+omWDWCYYyGJ9vKXE9WjYmR1e7x5ecqyMSCUzp10RRQZVKuywC?=
 =?iso-8859-1?Q?hU00BJSBcJcDlYIEkxqkbEMT7XPLA0f4uflE5WAvMeWwSCxjWOYucnOzjZ?=
 =?iso-8859-1?Q?vJ775MgT7r+cY1NR7RBqL+Vu03hcuMA8TV10uS/mK6Ag+JTYirabfdx2To?=
 =?iso-8859-1?Q?NgKwqKSpkVK1tEMoj5xj/8X5AwEjYALZKpvE4y5j/0CzOLEhsrzn38TX97?=
 =?iso-8859-1?Q?Lo4JAYOxHkOmr5SKVeooKpaAHb39qd2bzXspitYP0Cqxjn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3345730c-7fb1-4ce6-6ea4-08ded6526d33
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 02:51:04.4080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LC+iStlnPhthNIqo3toPY9bGtn8uFfVpq2fX8TsD+oCT6IwP3V4BWAMgCLZb4tvR1/QMrE7tpn5uu4zNHQovAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8450

On Fri, Jun 26, 2026 at 10:54:07AM +0800, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] Missing bounds checks on user-provided input length in `cxlctl_fw_rpc()` and `cxlctl_set_feature()`, leading to out-of-bounds reads and potential ZERO_SIZE_PTR crashes.
> --
> 
> commit 1f7098b182e4cdaf480b19545ca818cbf043bd29
> Author: Richard Cheng <icheng@nvidia.com>
> 
> cxl/features: Reject Get Feature count larger than the output buffer
> 
> cxlctl_get_feature() sizes its output buffer from the user's
> fwctl_rpc.out_len, but the device is told to write count bytes into
> rpc_out->payload. This adds bounds checking against out_size to prevent
> overflowing the allocated buffer.
> 
> > diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> > index 85185af46b72d..9c714ee42a411 100644
> > --- a/drivers/cxl/core/features.c
> > +++ b/drivers/cxl/core/features.c
> > @@ -471,6 +471,10 @@ static void *cxlctl_get_feature(struct cxl_features_state *cxlfs,
> >  	if (!count)
> >  		return ERR_PTR(-EINVAL);
> >  
> > +	if (out_size < offsetof(struct fwctl_rpc_cxl_out, payload) ||
> > +	    count > out_size - offsetof(struct fwctl_rpc_cxl_out, payload))
> > +		return ERR_PTR(-EINVAL);
> > +
> 
> [Severity: Critical]
> This is a pre-existing issue, but while we are adding bounds checks for
> the output buffer here, does cxlctl_fw_rpc() also need to validate the
> user-provided in_len?
> 
> If the ioctl is called with an in_len of 0, could dereferencing
> rpc_in->opcode in cxlctl_fw_rpc() lead to a zero-size pointer crash?
> 
> Similarly, in cxlctl_set_feature(), the operation size is calculated without
> verifying in_len:
> 
>     data_size = rpc_in->op_size - sizeof(feat_in->hdr);
> 
> Could a small in_len combined with a large rpc_in->op_size result in an
> out-of-bounds read, copying adjacent kernel heap memory into the hardware
> mailbox? Would validating in_len against op_size in cxlctl_fw_rpc() prevent
> this?
> 
> >  	struct fwctl_rpc_cxl_out *rpc_out __free(kvfree) =
> >  		kvzalloc(out_size, GFP_KERNEL);
> >  	if (!rpc_out)
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260626104102.53892-1-icheng@nvidia.com?part=1

I think this is addressed here.

https://lore.kernel.org/linux-cxl/20260620-cxl-fwctl-oob-v1-1-5758e34d784a@gmail.com/

--Richard
