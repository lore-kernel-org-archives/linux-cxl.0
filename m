Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792489345;
	b=IAiHzSb3DGhy4avo8UiA06ahG6hR756bmOq8X96dOAsxSNsVHPu+FXAgMsm6XHiHsFTE
	 DSf333kU8fDcjK30G6Jy6llRkYi+rVkZ8l0icI/VKwXSuPvUP8sbj3tiMsskj31BvAfPi
	 Ie6HWeLmItIrBPa4tiz+boPrFDwmXkqQJFuL5TkqkXp6JiYdwvm8xUhQChLItEnStTkRK
	 aNo/F9TxMqBf4+LzXzav/bnfAsojlml7uwjKXBjAgLgzaXnHso8WbLhqBPBu+ozqRcaSg
	 +fpg2IJr1FOKaMf4HRMj9/PnEfr9CJ+wpF+pm9JecEX/IcY3+n1HMasd2Y/zOEKBGHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489345;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=3Vxcy0N8Nhy4mFQO6FEFs+2Bl2lVYK54YuF1SPVHgsg=;
	b=4bjA0XjP2Nt9lnU8yyzId9EjdOv+kHCRKMrwJQ88WprfLGY5jQrkBBT5Fzpib4auUuOE
	 KHgehsQEJI5p6+1wAwoADlCTHowvoBXYAGF434aWaEhxlXE5a+xSLJ0ZeGwTpxrBOIHIu
	 yXWgOKRk+7Sr+J+BGh/q1SbZVz+ytjNBxBLxjmNPQwaR+zeVUyg3oHcd8fzUy5Fz5oO/O
	 OqFVlfHDmNUA5yu/qkAmQsJsiCcnctVS/fu0kQmVPHN7XR0vmtc0fo6Lv2OWGIH0qkWdC
	 SQtrprhDqZI1ge7fvU8cY5SJ831dg6cX0p7mw7t54ctms32hrEwmNnGviITwllED7Sw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RYzMzCAK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.16
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012016.outbound.protection.outlook.com [40.107.209.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F268606A32E;
	Tue, 20 Oct 2026 09:42:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F268606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=RYzMzCAK
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a3YuF76W0RdEnrZJmT0ll2+itPnsFfKFahyxz/dg+lTEGZ4QRkQtC9/bY+A5gOH3hHG746vE7Cb+N9j+2ZROwFRshUDLj7UtYEbP/gY3XjlVLMYiuN1nA3mt61K7qlBR2m8JSodHkVYtI4u2fbk0G6IXTUBI/DVYjgAaXDEmohd0HZEYG5bBf6pKz/sjJdKClaOCLiImsNT61MLsUEAVP52I2unXPqPUnj8v4cka8RxYlnX57lbVYIzRGRBW6/0b0zh3/tITVsMw1IOPBwrfdgdQkbI5YZPDZmabCf+0EVdk2fGbOZh6Yd3F+/zNspiktTGlWsCCgkXRN3W4s0fdCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Vxcy0N8Nhy4mFQO6FEFs+2Bl2lVYK54YuF1SPVHgsg=;
 b=AqPSa6EWBN21D4S8FfrqLsVevZIH90y7fYdzjl3sQPd4WFNwQnSVb0aLZTGjIwaJQ4F35yBppVdAKZwclp3HyIPBfjQxO+XzBITmTEEy4KdoPnuKmpSXbk/uBWlC6sc5CYN8VTap2URP08Nj+WmCShqQUuRO3aisWPcGgqkRRawM+aqlwMsx5A+lSYfQ66AP7a9DQ0pEaZsDJMIkq1AmdGsGrwDprvjYv/DfnyiJzuTwig6oeBkOKZ5Dh9ouuuQb/A85u0gEEOANI8+KLPZOhkVCXIsH59p+4OtVVDlqU8ttg1fIICNGnoZilouRhzUj/QAFwSQqb8gUvF0zY/BclQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Vxcy0N8Nhy4mFQO6FEFs+2Bl2lVYK54YuF1SPVHgsg=;
 b=RYzMzCAKRp39idVWal1PGoIW2S4NR9UpAt+jI3lje9qrdDdOGhcgTWAPIv0/kS7KzST9sybK1CuvHeEGWEvuP9QunggF7L1Ue9b/q0vc4tHv3yf/UNba3sBR0pbQMET+xy/hRMhg72GjQHoe61QDQYwiKrHKf6KkLoGHqYig7Sgp+Sdup5wY0y5vZHJmCqrgVc2VsfhmMwD+qlw7tUbOnhnOe7wy5f1FQ4psEU8BZTs7LfSWF7COo0cZSMpdaijANsVMWxHeeqSj9xy3YtyZYhvWTsn54bw8if5y/01npXGVA5Mfk/nYTzv2/6m46epJHp+Lz+pi6seWlJ07dtAEHg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by SA5PPF7F0CA3746.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 09:42:22 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 09:42:22 +0000
Date: Tue, 20 Oct 2026 17:42:17 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Li Ming <ming.li@zohomail.com>
Cc: dave@stgolabs.net, jic23@kernel.org, dave.jiang@intel.com, 
	alison.schofield@intel.com, vishal.l.verma@intel.com, djbw@kernel.org, iweiny@kernel.org, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] cxl/mbox: Return success for
 CXL_MBOX_CMD_RC_BACKGROUND
Message-ID: <atc3PJRk3M_RBmMG@MWDK4CY14F>
References: <20261020090352.939795-1-ming.li@zohomail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020090352.939795-1-ming.li@zohomail.com>
X-ClientProxiedBy: TPYP295CA0029.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:a::6)
 To BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|SA5PPF7F0CA3746:EE_
X-MS-Office365-Filtering-Correlation-Id: eaceba5c-f7e3-48f6-fc19-08df2e8e70dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|56012099006|11063799006|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	4C/F3cc5kVwByBt+uLdnOYKqaOLPBQeWb6ZTWiOxO+zhS8wWAND7JH52mwDcSyBJQqa9fpE3yKgU5ZbxMIb33LAKrn1FYcznE+B5dO+Lqu6SUS0bLuSuwEDFp4+luz7s1GKvH58fKqX6XBO+m1tY01iqXEbNs2KWb1W6Mf/CblgvsJM9aBvnHiblCL5Vnv4d0AIXsThHPHgNBFijV9o75gBp0Mo3SkO1uCO+ZeU4QroziyAa0bKwV/HMZoypAeXusor/QMoxCmuIVa41wxqtjZnRjvUKEXlIz9yOPr7nXSQa8/SpZIAWooF6aIaETY7KV946Pge3rzVV/9mMkxliQi3ySib+gkSE0RzEZUpBRenVr3JL5NIB2FnbDdi40k4ZF9omUjk6B8y0uP9RSKaWq4X7QPus/JBnZWmcGNrfewi/sWr8EDldmmeYj1BOEkFQW+VxpDWEzpboDAt4kVVnDWktIQpjDwHlSJLFqHfmBQyvUDav+9idKaSkzeT7GRnsQBLvR8nvPA67OEazBjVX7dE7GiU1ttNTqHmnOEaHysZrqdE4fvbllvZjP71PVk5q7X47DR9l518HVRn9NRWDybsEmyb26AX9O2IVpmKufL/OrWV1aUx0teHPYzsGLVQ8uC744E2FoI8JFcypefSvL1F6rOysXfB/f4vuvqAUhVg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1vpWcrJR72KHc9ZvsrkRLIGh39oVBNxpwmxex3MYf4Qzw7lKSwYDYmGBY9SD?=
 =?us-ascii?Q?XO4R5T9X6v67o4rFbOA/S614XHqhwEjHR8iGi8nCJjMMeHyByXX8LoD9KPMh?=
 =?us-ascii?Q?MFXL8/EyDQ3Yd79B9ZZdGwb58wj7H2fM9wb2o3GU0JeuLoVvJ4RTBhONVCH8?=
 =?us-ascii?Q?Fd52Hc6cP3/WYPU7yYSPb2SXecxsUBVvYTEOEj1gjZIdRaZ7BNV7mYxBAGjx?=
 =?us-ascii?Q?7L1M3aP8OE5gJ6FH1IGxiwmEAsdNIR+JyRJuJy+dfAC5FXfRJ5/Sd9x+pIAS?=
 =?us-ascii?Q?ot1Tdvf3XBuDCdlRshjYed2m57OXKkpLTWd2vmxcXBXR++4gn7qm1i8REXxv?=
 =?us-ascii?Q?ZF1u89OPXy/kd8dhd7jTwnlf1HXb67ji1ztpLWdO6JBDlCj/Jbu1k8DNslAC?=
 =?us-ascii?Q?M7jC8Q9br32fezpbmQfatKg+1EzqynQBYIEGyLHpe4NAnA7/jZwrxG/ymmkV?=
 =?us-ascii?Q?Osp8kXqvJMGA2iWWd+QwYX8RItH8XGjLGqzJQnIHuawcPyqverTlYTp2i1L/?=
 =?us-ascii?Q?6jyxGtJGynH7SGcUShjJptaqfsUDsuHNrjnZCf/9SOpx3GWuAm2i1h122/zh?=
 =?us-ascii?Q?CLJSlwEMUOTTS4SgMVy60DWRPYvES1V5NzC+9RSHgSFSBIa5ceieuRwD2/dD?=
 =?us-ascii?Q?0+b1pxQaWThF7slHG4g8wje3M+eB5kOB0F+jArHeyzooPIC+0IBYtX9aE7S8?=
 =?us-ascii?Q?knJSOmbyBaWC26qWWtaybFuGokWexnKHpOOtpewjJkXLJzdFumtaMXPb8OJM?=
 =?us-ascii?Q?2beLUdevgPUXDCjdXtAVhsnIs2Op97gL1UsbIwKyGyj0iNlUATOxAZXS5+5S?=
 =?us-ascii?Q?oPCPdAUUKwbWPLOS31QBrD/FOlPbe5odcUmDhig/NgHmeVLRZq0OTNPx96Ee?=
 =?us-ascii?Q?OR1fFKUcESwSb6LDccl7EJ0X/YhcRDZceZF5iNx5c+4nHSN3j+yGdkGIZln6?=
 =?us-ascii?Q?0xgJNZPebp2VfCw79BKExLl0E77Pf0cOZdYiYQ2xxipu352H6Hrjcxjfyl1n?=
 =?us-ascii?Q?ftCBH09BZB7OxcSwe5sMZqUYBVWrBJL/xAd5z+/WwnG/vjgErAa9BCF6NeU5?=
 =?us-ascii?Q?Bo5O6oCHMiLRFOe2jWFjsBFAouKt7RKvVAF7mWVAhHw4zzYxK8/tVJdnjfH4?=
 =?us-ascii?Q?6JKZKbmHPQD7635JUjD/ytnPMRiScQtxagfWvEGA/Kr8PnbvL8CNJzTDHzSO?=
 =?us-ascii?Q?kuKZWeqo97xywUrEU4aBJ/NGcHrEG4ZEKOGy89XY7nJ5ohorViBHT/ItavP/?=
 =?us-ascii?Q?YUJmH/0I1e59ycNsS3Qkk2Smvyel/m/x4C7/vjn68nTWbffm4impKBvS/GQO?=
 =?us-ascii?Q?uzPI4jMeelc1TUnJHkGoBar2I3uzyA/q6fzu1voKGZQG4YimIiJISMW+X8v5?=
 =?us-ascii?Q?DCb81/mUOv27HfZmfkXn4Dx/jRH9t0ZOaxo35IweAKyiieIaTK3Q50/BSkqV?=
 =?us-ascii?Q?eiy687K23XA1/ptzh/lCPY8ctG3gDIwmhnrzboJ/mXwXNy/zULAsc6m/povq?=
 =?us-ascii?Q?u8EZyzwt5/lQPHJR+Eez7trLysrZQfRpEXKxW9ktLza0+P9JvZ/oe5GTSm/J?=
 =?us-ascii?Q?Vtmz2edXt8OXUqvrPS2LcpG3a/kNMDIGaGjLfl7JLEcZv2AipEPaKEiPy0se?=
 =?us-ascii?Q?ATeNUS9l/AMzEtg4e3beLZeS4ZLsZULftqiN6fKH+Ym45xu9jFwTzUBIrtod?=
 =?us-ascii?Q?y1Kznlnkx8Sy2THf2Hz3DoVVlkfUyANGl/3xF/4hD4+7xc+D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaceba5c-f7e3-48f6-fc19-08df2e8e70dd
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 09:42:22.6736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2kQPyuqGav77Yhzj8W6IXSBAE/9Rh66g7mfeN9fNMMkY8wFsnEwMe4bHm8xr5shL90LFZHCICbH9AaPvU588Cw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF7F0CA3746

On Tue, Oct 20, 2026 at 05:03:52PM +0800, Li Ming wrote:
> In CXL subsystem, each mbox command hw return code is mapped to a
> corresponding errno value. Currently, CXL_MBOX_CMD_RC_BACKGROUND is
> mapped to -ENXIO.
> 
> However, a BACKGROUND hw return code indicates that the command has been
> accepted by the device and continues execution asynchronously. It does
> not indicate a command failure.
>

Hi Li,

Can we have the spec section written here ?
Btw I wonder how you trigger the error ?

Best regards,
Richard Cheng.
 
> Return 0 instead of -ENXIO for CXL_MBOX_CMD_RC_BACKGROUND so that
> callers do not treat a successfully started background operation as an
> error.
> 
> Fixes: 92fcc1abab09 ("cxl/mbox: Improve handling of mbox_cmd hw return codes")
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---
>  drivers/cxl/cxlmem.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index c401e3a1af06..cc71d7a84cdc 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -160,7 +160,7 @@ static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
>   */
>  #define CMD_CMD_RC_TABLE							\
>  	C(SUCCESS, 0, NULL),							\
> -	C(BACKGROUND, -ENXIO, "background cmd started successfully"),           \
> +	C(BACKGROUND, 0, "background cmd started successfully"),		\
>  	C(INPUT, -ENXIO, "cmd input was invalid"),				\
>  	C(UNSUPPORTED, -ENXIO, "cmd is not supported"),				\
>  	C(INTERNAL, -ENXIO, "internal device error"),				\
> -- 
> 2.43.0
> 
