Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013014.outbound.protection.outlook.com [40.93.196.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CE93C8C7F
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jun 2026 09:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782812816; cv=fail; b=iFZ+WIjGAdiSZIar9UmBCZoiVzzkTV9iwiVnNTxVBBZ3/z+Lys2NuL698HVs4beQYlhqWDhu932wICr/C1ik0CEPBQyD4pSC6gJpbW7shkFcah5+KdPOsQcWm4QL46NLLDkvqAhBUgyTlEEeUcxVP7SpN7q2s99RKC6u0x6JEkQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782812816; c=relaxed/simple;
	bh=AxEu+eM6c/9990yNLe2jdXf3tB6DYXMnQk1rFO2rjp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WOiZBCd63/WwLJb7MjTgXnNeRWMBq0Z23pwpqb0Z+KW6ijARj00SWEB4w3L4KcuNr/ZqUJNtbA1pBHmOrueKLY1AvWlXdhiAVm0YscUylQm3JnZifAWfexS2FQ/pb7oocpB6/y3ZwsDiBz7H5fs1qiwe61c8TM0c4zFRwtLxJ6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=fail (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BZkgJ4Bx reason="signature verification failed"; arc=fail smtp.client-ip=40.93.196.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BZkgJ4Bx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fj3Q4+pLaY7M/POey8nbZT/OLHhNylmxDG/rDjD6RPhxDvh5amosH+c8j2AqNnDjOc12FAtQH4RjmmXNsNQSW1vYgf/tIBsZ56/trimDS8q8FW3os2+6bMAEngpDXdGpuP0sFAFwCY4/YlvS3QZL2cMC1K/Vwn+cOjkfUnx9zpBhPf7pUCdnYWgQgJqFGH8Nr6cfFSeLO0xHswyjPqC/1KAA+mXgessfy4nFwrXKwdiIKGjDMRcitXoV6VQ1jE9S9Zo3wIJNxzEkttmMbrCZQ+l5I8hqhWi+olyadJJJ8WUbRSq4cWIPzd3vspVQK7CGvvpM6y1BDOnvknQIYABScw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4+n1i6TI+zrm/vKJAX5hBHtnigUwGwYYO0Pw0J7k4vk=;
 b=meUvrgUZk1hsKG9nDC+yWafZTRngNr+rHbj6CETE4a0hUY90WSlEz7wV2vsZWrdPOhJhI4jUEyyzCg9tYQKJkoCStgflUjWawE3u552BqAegQumkeD7gSZSLfktaztQb4IZ55c0sddprENYCURLN1+3XESk9cL4m1ytcmAt7Z5bydhE0h7DXZInDmtLl6QGF6M47urhAxFWvaYSsrLWckSkXM50f+gkoN/8ARC7S0TExHk2yTIxcQScKml3AnAU1wPkZ5w/nyy9n8ThIirnd30hqKa279Z/UboCQcg6oCtjW09lg94ZoPXxYVw9xmVYmN3jYuiWppLaOA5koEBcfIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4+n1i6TI+zrm/vKJAX5hBHtnigUwGwYYO0Pw0J7k4vk=;
 b=BZkgJ4Bx5e3zet5NuFsrgF2WWHQAveJjMvfAXhkc5828Oiy1i1An2MxT9F+b98KSK8CQFR11oW4F2/xOZvsAAe3+iI1H59I/+Q+tbA/XDImTvaX8xy8lb+c7AidA11GCjr5X2c4HGq2bx5WWKYv+Z+ZvN8nYS1ADQ9cCRHp/m7RSS1qb9cX0pewjpAJzGJxhm/Z8cqCdXjglKELQQvgaFy36X9LMkn8nF2n0vdpyx6wqwKwMT5kBPJAJ+bSbUnpSZeDurh7Dtjn17ccsvzziAni+CNHDo7cUKp7d0MORV2r1neduP55KB54mfSLBAupaKFhRl4AXuPm8AV8v5RZW3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by MW6PR12MB8759.namprd12.prod.outlook.com (2603:10b6:303:243::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 09:46:43 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0181.008; Tue, 30 Jun 2026
 09:46:43 +0000
Date: Tue, 30 Jun 2026 17:46:36 +0800
From: Richard Cheng <icheng@nvidia.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/3] cxl/features: Reject feature offset that overflows
 16-bit field
Message-ID: <akOQUX2t6kP0i6lY@MWDK4CY14F>
References: <20260630074657.43077-1-icheng@nvidia.com>
 <20260630074657.43077-2-icheng@nvidia.com>
 <20260630081440.E62231F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260630081440.E62231F000E9@smtp.kernel.org>
X-ClientProxiedBy: SG2PR04CA0214.apcprd04.prod.outlook.com
 (2603:1096:4:187::17) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|MW6PR12MB8759:EE_
X-MS-Office365-Filtering-Correlation-Id: b68785fb-316a-4735-5817-08ded68c7e2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|23010399003|1800799024|22082099003|18002099003|4143699003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	YTAxU3TTz91qPqtPSBYNDvXm5Q4H5A3hcMn0ntZxNjafYNZlZLkQAG0q5FGHVywf2cF0LEkd0jWFLoHoYkyzw5+a+6KOhXsx3wDIWL0R08qFdzTqs7mtHHSU1LO64x+qZrHzSNs0mhieTVDWmCi178PwLkTVgiksA9VKSnNAFjQlXZASkgOcpmebrSaSxM0Uq6xAerdJL16QahX8Vgp50Usb+h1kNzc7QdflJ6zImCrVSRmZgr+Ok/zmyBLoUrid9JccRwEBFlflBwrFWP+zH0NW9E6e8jwTAM7tKrFpmT1PMvq4rWWJzykOMSb9qCkeOA/hSXxePJ5XvdbgKIE9U4ibUk+UUtHBNdPelPa9B1H3Si2e3mMa4w/tmcUvks1a5DnJLP68PPfG6hyLfx9rVysKRZAG6HWEQyDFHpnmZRYWxJc1ovOC7V/4HPZjK9+OPW2xg2ckpPeG7zw2EOddb6sEVmc5R7cIfHJhNY7DOAeG6i3c/QQNsVC6Sj5w10T7DqADWF8tcqp7v3Sd8jfCo8lik7svhlEvUdhAnolNOaL0utmjBql262uZHv+Ff58wuxNjNamaDepmSg1AUey1ZEQtOqyBg9u/n/c6OEiv4v3Ng7OopTwaMY5AqtOQdiP6ws+UdFpUPQIxIJgpQkccxfiAM04t7zXN8kRNdM23MDs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?V7xOERvM43khQWG80wPWCF4liNimyHML6VmTpqO/p394xzWJ9BpVBig9Le?=
 =?iso-8859-1?Q?W5+QoP+N7TJ1qZZ/y0cKTuVAlEgbEg7Tpuh6SnyvWJVLeWwxaq2Ne/kGuD?=
 =?iso-8859-1?Q?xeX16XOdyTgRe4oy9OT7p3Gy/wxxGIRS090399fsXujwjQD9AEgvfArstV?=
 =?iso-8859-1?Q?EU4iBN0tKj0Sv4G/SZiDWwsBvqeqGECAuyTw+6rMee1Vv1sale/mZAagWO?=
 =?iso-8859-1?Q?obLHwSF59QxXljcJ9UPG2eGNOMzybvKvRN0IIT5KBIYq5d7a6iwHO5knwc?=
 =?iso-8859-1?Q?wO24WQANhOKsYUfWDszNgdMUuzBeHLHZWKx+IAj0Sz/QlCgpBalAjhpt6k?=
 =?iso-8859-1?Q?y0R716uXlcMLrJoXZW0WAiwJ2mbQfgVwOaQXV0V2447OmoYGBeJqmn4LIU?=
 =?iso-8859-1?Q?YU0Z5l00EwYHfsCxfT4nESCf5JFMqKRShAQvYYn3F2+zeD7ur+cysdXiPK?=
 =?iso-8859-1?Q?NyqJD5cVWjwFOaQTE1mPxpIzlBa5yDvIDjTUcqvKqYl133XH/lv8zkcX1A?=
 =?iso-8859-1?Q?p4k1yjV/LgrOwbLdg9bqrybTmkR/jD/7sisd0S5/Iazh2w/I9z0WNN58yQ?=
 =?iso-8859-1?Q?ILvpyBhcwtETHKT177gXzRiyonTSySzpDFz/mzu5V3h7u5z+ckt88fyHbI?=
 =?iso-8859-1?Q?JL3Quf6uDQNsqC5LQcsrSYGZqx/XvgxOFQY3WJQXb+fFantgWWrJMgxsHI?=
 =?iso-8859-1?Q?xlGPccIqnV+GD3rm/V2pfQClzZQbHxRlV1wPT7mtD0QLMH06BW9Dj7NUm7?=
 =?iso-8859-1?Q?l/DFEt6lBV4rIvYJ5Kldkv2xH9ff9/QM7WB9m6WKTX0QsfvEJYvUFjadRJ?=
 =?iso-8859-1?Q?FkkquhlKKM/fRo+naEv5JdP3v0N53k/kXSRgIwh/SqcQkhs1wAlsnwLGae?=
 =?iso-8859-1?Q?mc9Fs6+r8kuscem/p6jCLubROpPLVf4xq2Cjee1ekECxlFGmQ3fkiYl0o8?=
 =?iso-8859-1?Q?Ne1PZVp8AR95lVCdHQP2mHBhcmKrvk+fbTNHfQ0nvZLc88LaxWxzTdHOYh?=
 =?iso-8859-1?Q?70yB7aFfrGsapCzm4CV2HW1SzR+10KQUTsczoP+FtLS9xEFynylquznbFX?=
 =?iso-8859-1?Q?sd4fVIz1dlpDlvlTBjq3vuUvXo38hEOMLnWa7Bs1e+GIM6CFS5LowJEyla?=
 =?iso-8859-1?Q?zMsJTv+qPWaOSmLzidNoSKjF3u9HeEbYzAyak5Ck4quF/1l3vooVUOo5Z+?=
 =?iso-8859-1?Q?J+sRngBuJyTvOm1T1/8DpZBvCGMqOU1lKIrMFgcFF27TnyPucGFvvNUZwo?=
 =?iso-8859-1?Q?2dPXSkpCrLLgWfsFpZKM/zdxicrYe/7cxJ9dsBU/25bn4a37h62wDHK1rC?=
 =?iso-8859-1?Q?CdidDsYTbTrp+PgqlZigNmFJC21LKwlzTI4oDfH0Uxj7Xt7SJQCu0BvhJT?=
 =?iso-8859-1?Q?diZGtnIgblMzKK6G0ZFAicuNIoMGixNrSxcEly1K8fYj6Xa88ZQfTrD2Qt?=
 =?iso-8859-1?Q?M0XOVJOwTp9MD91kVcptAdA4gh//33H8AiOXPzha8CaJnv7fGIZ8AsZWC5?=
 =?iso-8859-1?Q?t87rz12+J8AmtlWap1r8py2LO8MD1kpniA9gfcdKzDb8+M5PUrjhThV5s8?=
 =?iso-8859-1?Q?ekg4o0VnjbDIQjnrBdoh2A6rYCN+hB3KPktvXDgsp+MgpEVE2+ddWgGOVc?=
 =?iso-8859-1?Q?OlwDHqEMDq16zfGtQMtl6NFQHCRsp4FX8PDGIlINWZYyfkU048XU9CjT14?=
 =?iso-8859-1?Q?Ww7fGQo8soVkGLmodjoYRu4hS6oQJ/mGUIuAN/28khEICqNyCuCZj9y82V?=
 =?iso-8859-1?Q?ybTurNQx0Pj0InJboT48bBFwCdV5Y1yjMOe9wK3bTAivc86g7++tcSudu5?=
 =?iso-8859-1?Q?sxf0MwAAIA=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b68785fb-316a-4735-5817-08ded68c7e2b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 09:46:43.7069
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ugc+T9PHG810zy2NXCi0y34ryeG7NbETgitYEb7tnLD2WJEAiYCo/cu9+lJjRUxsbhN1QkB5W8WQxAnJhrN1Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8759

On Tue, Jun 30, 2026 at 08:14:40AM +0800, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> 
> New issues:
> - [High] The bounds check `offset + feat_data_size > U16_MAX` is vulnerable to a 32-bit integer wrap-around on 32-bit architectures, completely bypassing the validation.
> 
> Pre-existing issues:
> - [High] The CXL fwctl RPC handlers fail to validate the user-supplied payload size (`rpc_in->op_size`) and structure boundaries against the actual buffer length (`in_len`), allowing out-of-bounds kernel memory reads and ZERO_SIZE_PTR dereferences.
> - [High] `cxlctl_get_feature` lacks validation ensuring the output buffer capacity matches the user-requested read count, leading to out-of-bounds kernel memory writes.
> - [Medium] In `cxl_get_feature`, the output buffer capacity parameter `mbox_cmd.size_out` is not scaled down for the final iteration, allowing a misbehaving CXL device to overflow the destination buffer.
> --
>

These 3 pre-existing bugs are already addressed and I've sent patches for them.

--Richard
 
> commit 5ab5a6aebf166b549e1dc9a1b5568aa38e4c661e
> Author: Richard Cheng <icheng@nvidia.com>
> 
> cxl/features: Reject feature offset that overflows 16-bit field
> 
> cxl_get_feature() and cxl_set_feature() build the mailbox command's
> offset as cpu_to_le16(offset + data_rcvd_size/data_sent_size), but never
> check the sum fits in the 16-bit field. Via fwctl, a user-supplied
> offset plus count/op_size summing over 65535 silently wraps, steering
> the device to the wrong feature offset.
> 
> > diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
> > index 85185af46b72d..db5964ea184f1 100644
> > --- a/drivers/cxl/core/features.c
> > +++ b/drivers/cxl/core/features.c
> > @@ -237,6 +237,9 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
> >  	if (!feat_out || !feat_out_size)
> >  		return 0;
> >  
> > +	if (offset + feat_out_size > U16_MAX)
> > +		return 0;
> > +
> >  	size_out = min(feat_out_size, cxl_mbox->payload_size);
> 
> [Severity: Medium]
> This is a pre-existing issue, but in the do...while loop below this code, 
> mbox_cmd.size_out is assigned this constant size_out value:
> 
>     mbox_cmd = (struct cxl_mbox_cmd) {
>         .opcode = CXL_MBOX_OP_GET_FEATURE,
>         .size_in = sizeof(pi),
>         .payload_in = &pi,
>         .size_out = size_out,
>         .payload_out = feat_out + data_rcvd_size,
>         .min_out = data_to_rd_size,
>     };
> 
> Is it possible for a misbehaving hardware device to return more data than 
> requested in the final iteration? Since the remaining buffer space 
> (data_to_rd_size) can be smaller than size_out, could this overrun the 
> feat_out buffer by up to (size_out - data_to_rd_size) bytes?
> 
> [ ... ]
> > @@ -287,6 +290,9 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox,
> >  	if (return_code)
> >  		*return_code = CXL_MBOX_CMD_RC_INPUT;
> >  
> > +	if (offset + feat_data_size > U16_MAX)
> > +		return -EINVAL;
> > +
> 
> [Severity: High]
> On 32-bit architectures, feat_data_size (a size_t) is a 32-bit unsigned
> integer. If a caller provides a large value like U32_MAX - 32 alongside
> an offset of 65535, couldn't offset + feat_data_size wrap around modulo 2^32?
> 
> This wrap-around could bypass the U16_MAX check, potentially allowing an
> out-of-bounds kernel memory read in the loop below. Should this check use
> check_add_overflow() or otherwise explicitly guard against wrap-around?
> 
> >  	struct cxl_mbox_set_feat_in *pi __free(kfree) =
> >  			kzalloc(cxl_mbox->payload_size, GFP_KERNEL);
> >  	if (!pi)
> 
> [ ... ]
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but looking at how fwctl
> handles the get feature RPC in cxlctl_get_feature():
> 
> drivers/cxl/core/features.c:cxlctl_get_feature() {
> 	...
> 	struct fwctl_rpc_cxl_out *rpc_out __free(kvfree) =
> 		kvzalloc(out_size, GFP_KERNEL);
> 	if (!rpc_out)
> 		return ERR_PTR(-ENOMEM);
> 
> 	out_size = cxl_get_feature(cxl_mbox, &feat_in->uuid,
> 				   feat_in->selection, rpc_out->payload,
> 				   count, offset, &return_code);
> 	...
> }
> 
> The output buffer rpc_out is allocated exactly to the user-controlled length
> (out_size/out_len), without verifying it can hold the requested payload count.
> If a user supplies out_len = 8 (just the header) but asks the device to
> read 65535 bytes via feat_in->count, doesn't cxl_get_feature() write the
> hardware data past the end of the 8-byte allocation?
> 
> 
> [Severity: High]
> This is a pre-existing issue, but the CXL fwctl RPC handlers appear to use
> the user-supplied length fields without validating them against the actual
> allocated buffer size:
> 
> drivers/cxl/core/features.c:cxlctl_fw_rpc() {
> 	...
> 	const struct fwctl_rpc_cxl *rpc_in = in;
> 	u16 opcode = rpc_in->opcode;
> 	...
> }
> 
> If the incoming buffer in_len is 0, in could be ZERO_SIZE_PTR, which would
> cause a panic when dereferencing rpc_in->opcode.
> 
> Furthermore, in cxlctl_set_feature():
> 
> drivers/cxl/core/features.c:cxlctl_set_feature() {
> 	...
> 	data_size = rpc_in->op_size - sizeof(feat_in->hdr);
> 	rc = cxl_set_feature(cxl_mbox, &feat_in->uuid,
> 			     feat_in->version, feat_in->feat_data,
> 			     data_size, flags, offset, &return_code);
> 	...
> }
> 
> If the input buffer is smaller than the structure size, but rpc_in->op_size
> is spoofed to a large valid size, this derives data_size from the unvalidated
> op_size rather than the verified in_len. Could this cause cxl_set_feature()
> to copy out-of-bounds kernel memory to the hardware mailbox?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260630074657.43077-1-icheng@nvidia.com?part=1
