Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011027.outbound.protection.outlook.com [52.101.52.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615E23C342D
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jun 2026 02:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782787917; cv=fail; b=ujagTDUA3pP0BWyVC6l+fXXiNYpr37kP7pLFv8TA0qxc3Gf9g/mxhrZNZT+T6Gnhf+mqmuRs9s+qKxYDGziNrw3Zy2hHyEa7D+yt7tMMCUwOfvmRMbXzfisJ9sn+5Czf13ScpvGzL/CrgzvXJOIvtAGy8luqOJyzSnJ/OETcEKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782787917; c=relaxed/simple;
	bh=0YEYAH6Y/HbvW5FT/sXozjmyrnUw+KA0M/6J8Afeh7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tBM03DTUuMdtlauRPlCGg+MeNdMbVCq/St75tPy6eyz+zwBXk27piA+/2dR3CU+7B/qKqAgjPU473C6IM+gQs/ELH4R0v09omYYeKOv+di70Yd6FYlei+bOfBiZ+OtHyY7AkK8dssT6FfBhMCRsl+6K0wul/BTx/UszCGtpFNSM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CaV7k+Iw reason="signature verification failed"; arc=fail smtp.client-ip=52.101.52.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CaV7k+Iw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SlbGHrO8IFkIXK4Qd5N8Tds+fTxFX4oojShZknwmkei+p+sfeBbS9ucAeKg2H/BW2N8UTmA7caib61M4cbIVJQeiW3Q9IEwKjbkcgK2bDObwgNXzTCWqD4G63wibz3U4L5NmiSMT60tFYC3IycEZzYep/tHw1xQhDckaB7AvtCdMO/ucQFYQ0gU29LsmMILW+uX70AhzMYakCIW1ELyh3P24GylMqNvAi2R0k3izs+z0EA++p+mbo00QNE7L+vSgVkszQ+Qym50ObyB6lXWsgiN4iJJ+XmhdrpiurRefB6+k7WXQdGuUTV4YfXxI9Hrn/euYaukUlSxtXbGC1ICJ7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CXWvuYT3Dp0ji96rNBJ9zbnsClDz45ppYIrQ/U7oZ1A=;
 b=kTz2L509omnu7oqZ/BeXqIjTbq51s/BJhTRCFCeqTDglo2bJvzsQ5xzs3ZuZn9yM57Rr+sd5KHKiQbDRYE60ltMSrYKeBzEmH7tsDyfrcCesG5zRkTBqWh38aDXUyl7+xAnoBdGUaWr2VMmea/K8ZNPXqNTKNISHcE+UYOpuFgWP111egNPsZzkwxoWyU7zI6Y4BcW46tCkO5J/cp/dwG4uizdgh7DCNldUvlMhS+zRcFPtmOfOiUR8N0NhXsf5DJ2AhiEtjDmK4bEKHETQ1sRxfYJX8eZ5mkPWbyof0q9V6Dy3PhBn3Wi//ZdQknsGTJfIHLE2uvjGiS0OUrp2WyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CXWvuYT3Dp0ji96rNBJ9zbnsClDz45ppYIrQ/U7oZ1A=;
 b=CaV7k+IwtJItYV6dAtZdYFqQYPmUFG3SBWH6UJLlI5ooEiYL8UM2yFuW9CVZI6FR8lYn3Qw2WuccTM3sglmKE8rliwqboQ1ul3Ma36mQuI+H55ucvlYLQcvKYH7mcpRoBTSzXp8X6tJGXrKKYGg8geXf2EgAWrvLpWCSlt/nc+y9iUPESzFnVVSBDjrcZcT9elyNsAlQT/r6/Bal44RnChkO2yOgqCHYClcN4T2ktU+vHPIJYsqFFBebcV9eP92DVcHAJy8XzASfRmdQVM6JtmKXRRwKevMJSlpcxQMECnFf170O5EBEqTSVIYKCzrwdXwjuXp42MCTmeC10Ri2pmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DM4PR12MB8450.namprd12.prod.outlook.com (2603:10b6:8:188::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 02:51:53 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0159.018; Tue, 30 Jun 2026
 02:51:53 +0000
Date: Tue, 30 Jun 2026 10:51:47 +0800
From: Richard Cheng <icheng@nvidia.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-cxl@vger.kernel.org
Subject: Re: [PATCH v3 2/3] cxl/features: Reject Set Features output buffer
 smaller than the header
Message-ID: <akMvG2N0UkaoBuF6@MWDK4CY14F>
References: <20260626104102.53892-1-icheng@nvidia.com>
 <20260626104102.53892-3-icheng@nvidia.com>
 <20260626105612.B7CB81F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260626105612.B7CB81F000E9@smtp.kernel.org>
X-ClientProxiedBy: TP0P295CA0048.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:3::19) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DM4PR12MB8450:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bbc8e0a-079e-48b0-59f2-08ded6528a95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|18002099003|22082099003|11063799006|56012099006|3023799007|4143699003;
X-Microsoft-Antispam-Message-Info:
	zF/52svSYNnEdVWyoWKizgTHH1KIaOWmrTBWQwVc3+raY8TC6XLq2sT05RUm6s6DvzTpeg4ikS876pPHdqp0ksacnDORGdwQV8zy8QJEgOiuSv+s3dsg1Qy+Np/rNbGJjhwWi25HDckd5KM4EfFPm3MaQoki/wp+lltOEy+/6QfzMvOVep++c9+LBp0/RO8Ut37hI13XSISqcDLfNYknyHKmCcv+50FUMbGeAJixVDahpxFqzn9sHMYONDNdMARnzVeH51rZH0bS/x/YWAIJfUKhaBIsTDiEE4uNZqzxgk69H/rgl6ziN6GgXDfuPka4OZgD2/Mc8zYP0dfLYAwSYPCJw3tKL+CWbju3M5NTbO0lZ3hBNT89rokCTtMFqxP0TqLD6DSreJJSJh4R9iWNUS3B/aJV9xgJP9YUJzZjliULGJRH8cwi20cuHfvxDXl0jnH4rRZhlhykKs2poFU+eG3BjBecQOY6O+R1NfVk+SBmu1SPQaT11qUAU9WUSHblul7mWgjCzoyzn21DC/UqVmIL8AaPg7lCpFVbDTZdKZbxQLGa1/S/ptIV4WWLlbPj2ag0LTnrB+4jcPtZOsrz0hTqqqjKmrvPNbz3SqJbbRsF0kU2HbddOUJ1YY1h4i4TbBchUPYlSlbbPf9eOJHmI/w8G62fcQ7WDjfQYXFdEcs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(18002099003)(22082099003)(11063799006)(56012099006)(3023799007)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?LD1CEGg3ykMuNHckbBAvxPglqjp0g7ASvJ18hRynd0DBA1edrf70/aKAVr?=
 =?iso-8859-1?Q?kQRBKRCEbJihD9GnZe0T9fj6kf3E/okookOQReLq+L2dKgeCJtgrCfqU9t?=
 =?iso-8859-1?Q?qnBGVgj3GIl1iDXE37nlQJiN+pnJyGrnjoW5YKDMCoBUwGSy8GIIsprsO1?=
 =?iso-8859-1?Q?6Fgbcp000/ql0sQ8rIVXHLHOUA8BblzLFPFoUkB8F32hfQ9UOrvz13b5xn?=
 =?iso-8859-1?Q?yY/qv/8WuCN51NB1HE7JuzLurzwsq5P/mhtp047LJVTbRV8BH557d5lPqL?=
 =?iso-8859-1?Q?2BIoUM+n/AcJusc7nHBzqc8F1bsGEBbJ107kzY6uLU5RQMees+DGzfcSCj?=
 =?iso-8859-1?Q?zaF67t6Zfn8jhHTAJnY3sAQfYuYS5WeyMqs/zhykPn/vcLHqT1NHuYDLGK?=
 =?iso-8859-1?Q?U6WB4aG78r4OVvMzw0lNAuOYBkvxpjvXuzMuA0t6np1GjwxzkbkRKODOzU?=
 =?iso-8859-1?Q?a9FWT2sCkyhrXC1kIQ1tBaPc8zXA132yoJPOhAGXrA9W7DAIlikL9BJINo?=
 =?iso-8859-1?Q?IzLYnKq/k7ImdUHs9+qtRQKDfrbqvIrRC2iKwKtd+m0r7U7hp/lFlgakCx?=
 =?iso-8859-1?Q?kxhCiLEwU8nqhtF5Y1sB1gAV1oXnezV0Q1l1wxN/PEttek6O8tO3Rb2cCJ?=
 =?iso-8859-1?Q?bU176yg0vWrbyVWNH6o3g63R3VFeW5lwhA1z84hxaQx68RB46TOeYJrDVg?=
 =?iso-8859-1?Q?yeDf2BVVgbDV3j5HOpxK6sr1JKDmLznA2LR+SrNtVcuPCID+7NYbFd9RLZ?=
 =?iso-8859-1?Q?oxUtKn2rHARklJMew58k0SMu16G9sl/NL7y3SghkF4ADQBDF8YyAq5D/QF?=
 =?iso-8859-1?Q?ODfAKXTW5SSKtYIahyu5nC2nWy/tW2gROAz5DHmRv5GxbiVZnL6crBD4Ai?=
 =?iso-8859-1?Q?bD7WiKw0Z3ReufxCdOsUKVPvZ3pV4zYUUffeqySDOBXg185+pqcwkOS/9l?=
 =?iso-8859-1?Q?bI3MeFN8Hnk5meK59e5cQiNtJRKQIi6jusZBpXFlpkBoO8Nxqm4GaldBEm?=
 =?iso-8859-1?Q?hg3VDmIg8xus252gsK885k4zbV5vraxanv37KsoW4uvJbHzN7HWoWcbOr8?=
 =?iso-8859-1?Q?qkBsNgXeD+SBGTO8dMPeOK2jZ6pmqaIYQrHuMJ3Z++sgdNQAkZj+vgBvJe?=
 =?iso-8859-1?Q?Mk4mSWf+bt7VM0oYbrll6PDg4IIfP62F+0IKk82xXG+j+vXPqJ65Kz8BC+?=
 =?iso-8859-1?Q?TBk/Uj9pdYQKu97wp2kzlkIY1Lxw6kS1DoCMC8JxXqMl5e+Ty4JN+HpDIo?=
 =?iso-8859-1?Q?Ng/gBdR1ETGUoMC78ta9Bwuq8+rKGiww3K5ac6I/CGvGlLIxYLHrhsZonn?=
 =?iso-8859-1?Q?zLHNPRZRgeXhN2yhhYJsx4ecZsMWuEyTLKUMhbxrBCGuLrhDJ7ZEcm5duK?=
 =?iso-8859-1?Q?Fx1k+kD31sqgYM6uq/KMVScp9/c14kyqWqIWEFBZEXR1cP8iKTnVrRf083?=
 =?iso-8859-1?Q?1R6b+QZhOYjpRdFPkuJbR4SDPFPgK3mGEiyo8d4MSjqajpisQYKWnVvyLN?=
 =?iso-8859-1?Q?BK9J7WKObL5G3smv5Uy+6eVo4mi5EMm4ImFbbg6VXNp7PeK5ZsjyqxNWal?=
 =?iso-8859-1?Q?xP53B6zjAWOoCx+Nu/bYQgfU+Oem8fZLnul/obJ6ydS1OgfGxxLxub/SDg?=
 =?iso-8859-1?Q?qr+6nHi+4FQike7uIaEvUyOo5vNTHkXk6TvmAjAzjMuofQ9I0LnT1zPLTD?=
 =?iso-8859-1?Q?2KY1SIqOezHYEjr8egcPP0l1xjxYhOd5DWenfSUfr823Vu6EvVVFvFYChu?=
 =?iso-8859-1?Q?a2xt8inDOj3Kx/ay5AplMfz9JjevGUwtTgjXXxfj0GMY7elRpPf6iY7f8x?=
 =?iso-8859-1?Q?nR9aCT8uOg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bbc8e0a-079e-48b0-59f2-08ded6528a95
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 02:51:53.4938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ckb4JOMePsD/TvOQyQVL4n5jgQDjr3EBOGSM6w9ztcd9wE6HBZIMkTC/ZYkbgK10rdC/ZWnaCvMY54eSYtmyrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8450

On Fri, Jun 26, 2026 at 10:56:11AM +0800, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] Missing validation of the user-provided `in_len` parameter allows a `ZERO_SIZE_PTR` dereference and severe out-of-bounds reads in the CXL FWCTL driver.
> --
> 
> commit 149380dfe9472c578ca9fd76d4e5bb0c5ac85c19
> Author: Richard Cheng <icheng@nvidia.com>
> 
> cxl/features: Reject Set Features output buffer smaller than the header
> 
> cxlctl_set_feature() sizes its output buffer from the user's
> fwctl_rpc.out_len but never checks it is large enough to hold even the
> fwctl_rpc_cxl_out header. With out_len == 0 , kvzalloc() returns
> ZERO_SIZE_PTR, which passes the !rpc_out check, the subsequent
> rpc_out->size = 0 then writes through the poison pointer.
> 
> > diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> > index 9c714ee42a411..ed18ccb5e236e 100644
> > --- a/drivers/cxl/core/features.c
> > +++ b/drivers/cxl/core/features.c
> > @@ -520,6 +520,9 @@ static void *cxlctl_set_feature(struct cxl_features_state *cxlfs,
> >  	flags = le32_to_cpu(feat_in->flags);
> >  	out_size = *out_len;
> >  
> > +	if (out_size < offsetof(struct fwctl_rpc_cxl_out, payload))
> > +		return ERR_PTR(-EINVAL);
> > +
> 
> [Severity: Critical]
> This is a pre-existing issue, but missing validation of the user-provided
> in_len parameter allows a ZERO_SIZE_PTR dereference and out-of-bounds reads.
> 
> If a malicious user passes in_len=0 to the FWCTL_RPC ioctl, kvzalloc(0)
> returns the ZERO_SIZE_PTR constant (0x10) in
> drivers/fwctl/main.c:fwctl_cmd_rpc():
> 
> 	void *inbuf __free(kvfree) = kvzalloc(cmd->in_len, GFP_KERNEL_ACCOUNT);
> 
> The driver unconditionally dereferences this pointer in
> drivers/cxl/core/features.c:cxlctl_fw_rpc():
> 
> 	const struct fwctl_rpc_cxl *rpc_in = in;
> 	u16 opcode = rpc_in->opcode;
> 
> Also, if a user provides a small in_len but specifies a massive op_size in
> the command header, handlers like cxlctl_set_feature() will read out of
> bounds of the kvzalloc'd heap buffer and transmit that data to the hardware
> mailbox:
> 
> 	data_size = rpc_in->op_size - sizeof(feat_in->hdr);
> 	rc = cxl_set_feature(cxl_mbox, &feat_in->uuid,
> 			     feat_in->version, feat_in->feat_data,
> 			     data_size, flags, offset, &return_code);
> 
> Should there be validation of in_len before casting and accessing the input
> buffer, as well as a check to ensure rpc_in->op_size does not exceed in_len?
> 
> >  	struct fwctl_rpc_cxl_out *rpc_out __free(kvfree) =
> >  		kvzalloc(out_size, GFP_KERNEL);
> >  	if (!rpc_out)
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260626104102.53892-1-icheng@nvidia.com?part=2

Same as the previous one,

addressed here

https://lore.kernel.org/linux-cxl/20260620-cxl-fwctl-oob-v1-1-5758e34d784a@gmail.com/

--Richard
