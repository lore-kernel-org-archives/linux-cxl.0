Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2059.outbound.protection.outlook.com [40.107.101.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2716F16E863
	for <linux-cxl@vger.kernel.org>; Mon, 22 Jul 2024 15:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721662181; cv=fail; b=q2183x5hNKnIICcTrJRw03nivmlMWX9wcy7RYm3tgX6YooZb0+GLOHfmtvEI9XxX9JUPNFjVSJ2j+gGsK2yyx87aiiLnMoKBJKwvslWXTlIZ9ykqADPEEPbdqgjAZVs6z1+Blb/ittSQ6iZfrocUhuwd0onjc6067mYjFBNjyu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721662181; c=relaxed/simple;
	bh=/SeO4rKr/ayVqJw5vnV87TqBXGOTVaYK408JNf7yV8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gKU4QuuOytKQhtn20fn5gWbLIzbrHiLCSxHPEY1hhGhu4nWO0NcX99eQ1TyLmPpjxkXmkd83a5qfnYDw8h9GgUkMl58wSuVXMUCw4gsKxRkqCGJGtwe34/kyvvhSzUKFIFBYafmVNx/WehGbTHdV7gBSeePyYF5hiZ6QI+TK5gY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GkCRYFk1; arc=fail smtp.client-ip=40.107.101.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GkCRYFk1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LqoGUx5wqosmCy1MxyYwjTR5p+PHrtdOJDfJ5bIVaru1em6gzYkViHXwRBZ84uCfE7KVFpYUPIqJJho6NCTMjTiH4SCh5Xu54JGDL+jVmSd5GQSORx8yjfUnpP7W/uuZ+WTtwu3Q9/uabMUxP7SLNvfOzWgVPbPj31JNveXqdWmDcM8Da4dc31BKkhtOSPerb/q/S0CjHOYyd0Bg7pbQx8xeFNaq4f5KzaYzf0V9zYRz7BQNi7Unkaz367f2LZzaweGQJFhOt3NaimpM3UrZhSb2DMzziHMwuw3pCrkJ80FoTS5CYMBPZXycijOihrD8tdJWZy0ZLTL5An6zLEScnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxduSz0r3hGCBPVMWeqctnlkod4b9Jk2YA3QD6nYoCA=;
 b=mQeHcLGLNlEDsp2ARIWslYlZIKcwBeaH0vwlgN8+44J7/qCuUEbCGRIl++DUkRmrWInK970QqdCdqry21KvQ7konRMpRP5jKbjBDYF3KXVgaOaUOjB/e7SKzYZdFAmFwDQ3AlVIcC4xWwPE2MVN9ijq2eS4nzw3gohu2a5+XlAoxO+p8LocHHWi5H/HV/AVZ6oHeIumHbx9nPI57rnytZHkDAn2Lg2VOS6HojuPhte0K19ppzs/czXD/wliZSAeaLCfG1rU4z5CD03zCRbc8HSmsfT6vEY568Ctd3cobJWUH1oVQjFCDlFncX0LXzQzPbgvW7hUDCwMMa4kbpBTE9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hxduSz0r3hGCBPVMWeqctnlkod4b9Jk2YA3QD6nYoCA=;
 b=GkCRYFk1imA1+XmpbV/5UHAbYPfW2fXuYnDfjNXWjBNzeme55H03zZ8PnCMFBZYwI3c5c9gxrSZl3ZTDgsNn82QGtLtgu+bPOBAHasz24D0/RxZ42MwJ9ulRJhf3GfPpXkKK2Y2GhjY399ws8DKzp5j182ARFWThChKhl0G5RYOJCxK42L80+4tKeXY8g1e/gBVzeWWS0LjhCDj8TVk2WeN1ToggaMIgGwjKYcHwPS4hvOMesVdUE0si4C7p9Tr68obqe3wG8EZCpKGd+kCcroXsOGOxS920C8JaqewUZN7rSFO2lQ68dM8fUTLQ24vOf6+7yotrKxLorIba4StOmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MN0PR12MB6270.namprd12.prod.outlook.com (2603:10b6:208:3c2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.32; Mon, 22 Jul
 2024 15:29:35 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7784.016; Mon, 22 Jul 2024
 15:29:35 +0000
Date: Mon, 22 Jul 2024 12:29:32 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	ira.weiny@intel.com, vishal.l.verma@intel.com,
	alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
	dave@stgolabs.net, shiju.jose@huawei.com
Subject: Re: [RFC PATCH 10/13] fwctl/cxl: Add support for fwctl RPC command
 to enable CXL feature commands
Message-ID: <20240722152932.GD3371438@nvidia.com>
References: <20240718213446.1750135-1-dave.jiang@intel.com>
 <20240718213446.1750135-11-dave.jiang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718213446.1750135-11-dave.jiang@intel.com>
X-ClientProxiedBy: MN2PR16CA0051.namprd16.prod.outlook.com
 (2603:10b6:208:234::20) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MN0PR12MB6270:EE_
X-MS-Office365-Filtering-Correlation-Id: 09e6707d-dd12-42c7-1dee-08dcaa63175f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bEOk6+NjDG/jJEExY2D7ncEwEZAz1L/n1VkmWpOhBK//JFBsO2N8FggsG+Ho?=
 =?us-ascii?Q?VVQ4TP/m2ukM7wb9MwUglP380MyFd+urlfihTx9M8gvDjljkq5dUaP5Kc91I?=
 =?us-ascii?Q?axA5k7vJOI11REncQ2YCM7X8BO42HWu/7c8/xG/rYwW4kwv7Oth9PpJ6Jx/Z?=
 =?us-ascii?Q?fDos0YzJGHR7A6uab4xU2hJbbgxru/DwVyvW5gaHlv9uRdYhKgvLBOl2d5+U?=
 =?us-ascii?Q?cjQZZwFHo0vUBFICsQqgzgtljvTA6yRJarEh1E794BPJF2BpctREZDrtsG3E?=
 =?us-ascii?Q?AERYPS0nm2jap31OILoWHe4J1iWwAfb02Oargu1VLkCYmvp2Rc4SwJEyGLhF?=
 =?us-ascii?Q?dkGpXlOa6fksKBL9nrji9r/8sy/nZMgbNy70mV4PLld78nmdzsw+woDUjJ3V?=
 =?us-ascii?Q?ZFp83tmLAvLNz6sJ2jxMR5AAw96YdbaifJtUPWJlugQNddBBFQykzySrVG8u?=
 =?us-ascii?Q?qIOQr6OENkRxj2qqOQpXcjpXBKJF0OkX3i+He8uxlPWS+/Df+FvQ8OxC9AGX?=
 =?us-ascii?Q?y4FjHVcA20sD6Xk4pbXPAonOgLjwxHHTE2YhEFrdgHHBiC8l8Kg3ixoWZ9ii?=
 =?us-ascii?Q?x2TuX7JksxUhpyzEXe6U7UZI44Z2s4y12LtzyRr5t1TJnwCk211li6og/p0W?=
 =?us-ascii?Q?sgi6dLib+hUXoHYuVsq6AB+xbG+owTW9PBcqGNaPr35cpiwr9owlAmWrf/4s?=
 =?us-ascii?Q?lF0Nf6jCmm8Tj6eAzHFkv1jVEGgZ7i7lczC2ae5ZIx5tzTsSNw5Y18n5OvaY?=
 =?us-ascii?Q?oo5+42ipNCBmuuz4sr6uqWKH/6G6rDFKRzQ/wZIvqqF18SHqisF25h51CC4g?=
 =?us-ascii?Q?bFheB8N9VX1qZCcq/gnoygX5ZTKDBlc41Y6X9TwdP/H22OGg25xP45PhI90L?=
 =?us-ascii?Q?9mDE4+JZuPRScsPYrnAJkcF5U68F2Bci94WL1pI1b1xt+FFSJ+hn49x+XAFS?=
 =?us-ascii?Q?4Zr2CdYI3RiHiKJ+qayzquQfxJqoTBlthELCSDKTLI9yZ0Zj5xHErEDqPXC8?=
 =?us-ascii?Q?QBGlCA7qvd8/SepsPXNP++kmf3VPLnrc/hK3bfhQDX/DAV5isA3TjJ2a0ZFq?=
 =?us-ascii?Q?Z0kjl8NtV2mOaFy/hi9SlPH2ejDw+z9hDXiYeQlpoHHLSVNpLF3rfwoZougw?=
 =?us-ascii?Q?vjNS27AtDRYBJtYuEGOW/Ysk9ACKBzZOQxI/UZ2xdzMJdrcUWZl7sva8hfxL?=
 =?us-ascii?Q?SnxD8LlkRDNxJgD4XEXSveiY/VdhqCiNKx9fCj/UOdQv+NV1JVpW01LIHHkf?=
 =?us-ascii?Q?mMJFGgSpepaLtXQDzQE46Cjf605wzj5YDWosRRgxFnXU7VC+t6HqDwOEepZl?=
 =?us-ascii?Q?elh6uf882xq9aLeDLf2ib1WYH+MssGRQo3ab+qhpbbmfHw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mmSESGHqM5UmDIU5w10iNtkwYPBAcdn8ulU0E24QSkv4uH/BjviYBCLasNED?=
 =?us-ascii?Q?CIa0cQNQTmMyQDnPqY/6fZ3N1JqcoTUYE7P9ufg8WFquu8DvS45GHKZPBy9C?=
 =?us-ascii?Q?rrBhUMhSXOmza3GVBlVv33dRtAKm+ZqhvO89/8NiYrG/5PjJ/Arrznqoo3U/?=
 =?us-ascii?Q?aADmWU7ddZtqjJvC0LrHsXOJKEThFczA8fmPe0DmlJTusVnzhf1JWKDJu0gP?=
 =?us-ascii?Q?eAZ4Mz3Bs+6NSByBciM0QohUp//LcAroupaU/h+w61mbx4UP/btOZmZoMADw?=
 =?us-ascii?Q?zUiVpVVBPW0yUNt8zdOUZeRABiN/LYnvQdvPqHpgjv1fCCZ+2vM0PO+kNUbK?=
 =?us-ascii?Q?fNWigiX9Q6NyKLPVSCfl6gvWlVAzTY5uP2r9dZyON0aChvj1KZ7dLHqFTMft?=
 =?us-ascii?Q?ZAFy+9wAp1B0+i3wfNkfp3HKAklqR02/bl7bJ2Py/YbDJo8OsDZeb+o97SRb?=
 =?us-ascii?Q?tz2mosAwYsZnOThBoYZ/jjVOzFBidusXRiGzZrgTIb6+SLEU7hRhRqjAlLGT?=
 =?us-ascii?Q?4zLq0Hciv5qXfDB96AMKt2cSrcrJK0UAll56C3G4P+A/GpvFOASI0y5LQS4G?=
 =?us-ascii?Q?K6SiaZR80Bz6+H8dJqhTj+RzsQDv+jdvjSGpGKPIF1IHbkxJCA6FqCEzn4O0?=
 =?us-ascii?Q?dQOWn1tenp/Vik7goO7ER9q6fhwkIowzarFApFHCeRqZlPtgXyESTe8NrVxu?=
 =?us-ascii?Q?fEhbaePjaBkqBdKrtBATzJPN/bzmcNtbtWrd6SiT6BoXXDiu9r2z9njs0Rzp?=
 =?us-ascii?Q?+8hYoJRqh8kZ11/iaxN0HmzqX6Tt4JEZTuHBu5r58fPVEjDZ8AdLZgPk/sAi?=
 =?us-ascii?Q?0H6yhlEw2Vz4ku/2r8vmCb5nN9bd71dUhu5zeGRkLqGuOzDOt44NgQ/QBip+?=
 =?us-ascii?Q?24o4pdYNhbwJgFzwo7YrI9swu+9g/vwVyjVit/BKbjpuIvYsjuVlRUb3zurL?=
 =?us-ascii?Q?c2PFMj83/v7zRSRdHenzlPmoJ0pXVXm1lhiwVVj8i3SUTzMx2NLeM11iUo3Y?=
 =?us-ascii?Q?VLM87Th6OZFCEWtFy5Ejuev8zl78JfpdIhfAY4YwYBByg20ZWoLp+3kJ1VfZ?=
 =?us-ascii?Q?jX2TxE7mZJ2jn+uzmYs/3NdZgOI89h7pyovD6tfC1gslSqyqL8sT8zKx10eq?=
 =?us-ascii?Q?ABTS6aR7t6peWeoqlVyRBZPvzW6Rvfh547F6QRg4jv9Hy0W0WSqHq2GgdI/H?=
 =?us-ascii?Q?i1653wKbL8wBsfeFIsIgewkC2Smdv1B/C0SjmNim3KM0vCACRl0G52Xmbjdj?=
 =?us-ascii?Q?mwSfKSXoGbtqmPl2aCxcBEx12O/i8hCDp89Pv9EO8n1NMCadLytJC1qzkzBA?=
 =?us-ascii?Q?DeGRzCmWgEk8iBec/9jJPbgQpY3d2qQTWrkg23uRa0G05t+xNVg8i8AlBj4v?=
 =?us-ascii?Q?vpD+2ACOfh4tsqVr4ghQwzsq02D7ngAv7j+WHqkWJo20zTQaPTCo+iHQrJ77?=
 =?us-ascii?Q?pDfxt1spAk/6GLnJpKbrtT0j2umxhhTy4tVNpJ9W4RMTUDRfi6YSMeROv7Fq?=
 =?us-ascii?Q?haFCppd/avfPc1UtKKBWTe1qgzwtoYKV1Gd9wuLYSZ8cJX+mg5xnCRzJOGmP?=
 =?us-ascii?Q?tjdXwLWqtODtp4cDt5E=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e6707d-dd12-42c7-1dee-08dcaa63175f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2024 15:29:35.1649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JJwtO6FLrftqNwjtrdvprjLTvK9UKrt+5ojUeRDTrO7b1AkdyTY1CSlBKFUvkz4X
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6270

On Thu, Jul 18, 2024 at 02:32:28PM -0700, Dave Jiang wrote:
> diff --git a/include/uapi/fwctl/cxl.h b/include/uapi/fwctl/cxl.h
> index d3a735f1fe4e..de8949a28473 100644
> --- a/include/uapi/fwctl/cxl.h
> +++ b/include/uapi/fwctl/cxl.h
> @@ -22,4 +22,68 @@ struct fwctl_info_cxl {
>  	__u32 uctx_caps;
>  };
>  
> +/*
> + * CXL spec r3.1 Table 8-101 Set Feature Input Payload
> + */
> +struct set_feature_input {
> +	uuid_t uuid;
> +	__u32 flags;
> +	__u16 offset;
> +	__u8 version;
> +	__u8 reserved[9];
> +	__u8 data[];
> +} __packed;

This struct probably needs to be prefixed with fwcl_, but should it be
here I wonder or should the CXL defined structs be someplace else?

> +/**
> + * struct cxl_send_command - Send a command to a memory device.
> + * @id: The command to send to the memory device. This must be one of the
> + *	commands returned by the query command.
> + * @flags: Flags for the command (input).
> + * @raw: Special fields for raw commands
> + * @raw.opcode: Opcode passed to hardware when using the RAW command.
> + * @raw.rsvd: Must be zero.
> + * @rsvd: Must be zero.
> + * @retval: Return value from the memory device (output).
> + * @in: Parameters associated with input payload.
> + * @in.size: Size of the payload to provide to the device (input).
> + * @in.rsvd: Must be zero.
> + * @in.payload: Pointer to memory for payload input, payload is little endian.
> + *
> + * Output payload is defined with 'struct fwctl_rpc' and is the hardware output
> + */
> +struct fwctl_cxl_command {
> +	__u32 id;
> +	__u32 flags;
> +	union {
> +		struct {
> +			__u16 opcode;
> +			__u16 rsvd;
> +		} raw;
> +		__u32 rsvd;
> +	};
> +
> +	struct {
> +		__u32 size;
> +		__u32 rsvd;
> +		__u64 payload;
> +	} in;
> +};

Why all the structs and unions?

> +/**
> + * struct fwctl_rpc_cxl - ioctl(FWCTL_RPC) input
> + */
> +struct fwctl_rpc_cxl {
> +	__u32 rpc_cmd;
> +	__u32 payload_size;
> +	__u32 version;
> +	__u32 rsvd;
> +	struct fwctl_cxl_command send_cmd;
> +};
> +
> +struct fwctl_rpc_cxl_out {
> +	__u32 retval;
> +	__u32 rsvd;

> +	__u8 payload[];

This might be better as 

  __aligned_u64 payload[]

Which will force a 8 byte alignment of the struct which will allow the
payload to be casted to aligned u64 reliably.

How do you know the length of payload?

Jason
