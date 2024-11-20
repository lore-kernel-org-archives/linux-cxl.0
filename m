Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0DF5824A0
	for <linux-cxl@vger.kernel.org>; Wed, 20 Nov 2024 18:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732128817; cv=fail; b=rPC4CGhLUFdJX4T+EvLWjylSf5GLshL4QNOXK36bHiEQw/dOCpoia9V6WktZJ1gPVLOgiHYEniOSdaR5hAVLt+DmuZy0DkBkP6c1nqIyDJHBn2ObcPuOwcFuW9GwcqtZpFfdZ93wsJmbALZlC2J8zIVGkMRWZ3ltI6/U0/cxJ9I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732128817; c=relaxed/simple;
	bh=Bb1P4OcGhRqMnfqAs7LPHKovWAkeYDq435AcHQQqFFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CNuHbnFggjDs73R323zOjuF2d+f2mE2wXwLCdcPUZIYK1oqe9anFvXwcfv+cYNYCGQ3UD5AnHHUVH9zYJIi2Z9/BNjfL/HLetDY2csFaved2HDKPceC2p1kFlAaN8yWEr7W4HcYIObuHyxEnrBUt4C0tgE1HEVt7e5remWK7e5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V1H1BrgI; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V1H1BrgI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aaCuyLFQkq1vRUYEnd1lYHGDccS2uU0/MgamyyRdYIpYYTgNBQmfme4znM4KFdKAPe0XOZpgj82VHMB3kXuk5G5pZDnlbwTraRe2TPlQu/aRcOtk8ZuudlbSdfLbIiqjEvkG05uOje09g45leYU/lD649ntLXuBcxAXTyRfWn+CHtpefB9J90iCHCBkW2IxaIcNAZ4b8GNvFpNj7rstN4cn2sKLiQ9TydHi1O2FwDiL6p1m6OFfQAmKP5/EQo+okCm309stplqjouNba5MFfMRx2I+2Fn13R9zN97KFJJE0SQpMRFEHIpqJWVIRG01PZhytMDFc8U8xlji0zrkWkJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cunGdP1Dq9hxqhXThHscfTVDq3IhSlY5JGfz6K5N0hY=;
 b=k0jxGdhKFD0BZ9SvPE7p8wJWOscI5gSKF46zsySVcKEHiAVVBZwXpY0XGa+k1ojIzaM4uom0qIKMdlbGDP+AzZRmXwgUVgvQWzjxzLVHsSQIDCCwF9ojT52VkeMycIG1p/Atld6TrAR0hdXVTqOGhI0SOyGNFelUYD0Grz2QErKef6v/ZAEVIbpm9vxqbyFpYktJkcuT8IRzP7JRsSRu+A00BhC+j7XEDKXjZ7lGI2tRo1V6o5zsEX/QL0oi+GTtTmB2W6Hc4OWwYM/E3oKrKtVak0wBNQXwkeZH+A5xIh+DcSG0FLNmkOQ76DWJT56diFdupnEW8hJSFDfG1cTw7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cunGdP1Dq9hxqhXThHscfTVDq3IhSlY5JGfz6K5N0hY=;
 b=V1H1BrgIwJRujnffqwWGzFOJn8uzpZW0Usn4nszNKgECMyf9WDhR+KkIkypAhp4+Psu0biaG1bOvuaBwsgSNk71BdER+v2z2ZFCIF+Ul9rPQHmYBdzReJdH1I8mnUayEwilSFt4OseEdSUUlX1YaylTvEKZh2ItLBx+3SJQTu9b7usPY1jm6+Sg/bJj1DbmiRgOYJTqRs6AtUtwGdObXq/lU1UuLM1PkGTZGUaLIVe/R0/c7Xf6dE7mPlTeqU8Tf0jjG3FTR3DGHjoyNFV/ibyz0LGizmfb12m+/lgy2iDtsHal0f10Y+PBN2Tqt4M8K+1H6eLz1vGOv5f46lHh1sQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB6606.namprd12.prod.outlook.com (2603:10b6:8:d2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Wed, 20 Nov
 2024 18:53:32 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8158.019; Wed, 20 Nov 2024
 18:53:32 +0000
Date: Wed, 20 Nov 2024 14:53:31 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
	ira.weiny@intel.com, vishal.l.verma@intel.com,
	alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
	dave@stgolabs.net, shiju.jose@huawei.com
Subject: Re: [RFC PATCH v2 11/20] fwctl: FWCTL_HW_INFO to return hardware
 information
Message-ID: <20241120185331.GF876522@nvidia.com>
References: <20241115212745.869552-1-dave.jiang@intel.com>
 <20241115212745.869552-12-dave.jiang@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115212745.869552-12-dave.jiang@intel.com>
X-ClientProxiedBy: BN9PR03CA0780.namprd03.prod.outlook.com
 (2603:10b6:408:13a::35) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB6606:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a47121e-95a0-4193-0099-08dd0994a107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lUBltrpIRy7fho2YJPdLWQKND6+OWoeISbabQin/hjcnRTu29MvguCO/sUGu?=
 =?us-ascii?Q?PmxJcPOE1p64AqRnILgKqetjYOMvFOXDlgjTNVsW48U7ECjn+0LW9RQ47pnn?=
 =?us-ascii?Q?FLB/62v9CsBdvejFGM71aDpVa1FZUcP3+5NOChrRLgcKzkkQ6HLgMLfJQll5?=
 =?us-ascii?Q?o0DeOmUdLT3EJsxhvz7qQfvNCgvE3tbiHsML0IKum33lkzL7NLhlHmeG3V1r?=
 =?us-ascii?Q?xx7Tb3MU/u+q4OaAgJRYRSiR0JUCF//GdU53IstZ4a0q3uBjCkVp5/AvRWDY?=
 =?us-ascii?Q?BtN9tJDXC8daNbCqE0XZkOHoTFNw9sQwg5/MVjY8dklslVkIHZQoY7v2JcAM?=
 =?us-ascii?Q?SZM0Nnxh5/3Dv///YcTJ5qtyd5h9qQAmZNPMBlB3uKr7fPprbZL/57Xt+F9C?=
 =?us-ascii?Q?vVq4q/tMrW+VX026P49NSXcqdKvTp17QElTgkbUXrWBZM5UDGks/l2fBys5e?=
 =?us-ascii?Q?lhjIdexogYevZH1cC9p3sffHNDJHCUMOPJq1dEQRNNVGsQ7yRBs1XII8sWq6?=
 =?us-ascii?Q?hIMS3llL9yWfo0wARYdG8y+WhZIUg2EqPR6H1P3QPJFCJGDysrlTF1pY0WJ4?=
 =?us-ascii?Q?WlMjsn4k3awfnNYtf578qhhWLPUQPnj8N0lYh/eptv6Wj1VXIT3NG8Y4fm62?=
 =?us-ascii?Q?6ScAwck22myh3MjyFtoL1iBhpomCw4XjICBLPFbbkd90BBiUonCJvcBHbNF2?=
 =?us-ascii?Q?PbzrebI0HhzstNODTBVwuB/EmplkelngWvHAPPnkfvj5pm/l6Nzq/17N/3FZ?=
 =?us-ascii?Q?iqW0fxIcB56lkOA/RTFxamJcFdjr8SJYF52F8LVBcinmyDa1n3QoemuzwKQm?=
 =?us-ascii?Q?W+xk+dT8Efxr8d0Bg0inng7vv2ysDkhrA3xtCqHikP54asn4o/gzftd5/xTi?=
 =?us-ascii?Q?wRi5DFZEOeNwyuBf8DwhLxq2ct4UxMjWDqiO0y9HQcUuZ1vuzLJ1Xn4JdQjJ?=
 =?us-ascii?Q?pPch4I/PX9qX3GlFEKaeFpEizf3N0cUq0PhUvn4XdCrdoA3wMZpjduZcJK1O?=
 =?us-ascii?Q?Nq9PQGqzl/UQLqic+56U8Y5y7Ws/QJ4p6lENxUzgQQ83kbMNjAhFNrcXzxtv?=
 =?us-ascii?Q?7eJeG7SiHOEhAZiWsHdLBZbeMS1obeggwMVCQfvFmB7pDwESYJtywj4OWj97?=
 =?us-ascii?Q?S8eA4vCDjE5eu0FEqUby/W5hP2ZgAoFHQ9yxaezHRIxbtiwzdABd6e9GZo4f?=
 =?us-ascii?Q?+MBAl3io6kridnUAPmjWqFZSpHVc5g38kDIc5DmpQcYIOgOAA0L8vPf11nBv?=
 =?us-ascii?Q?5LwgOO2cq9jI/aoomJzh0sNdRn1o971do8ihI16IKZ2ddJOJnGx5qGBlR4eT?=
 =?us-ascii?Q?c//FXwxcBhS1QBX5s23/FZv+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Uf8UtXSkK5EJeXtW0d+BbbWKF5XHmDRogVciHr+8o+kztIvnEXl3e6qvaJPZ?=
 =?us-ascii?Q?DJWpXmbr80mqVrLRg7T3AoO7ibs8SccMpJrcumoiQ1qX4phbIohAjNzAPGqe?=
 =?us-ascii?Q?NCQpIPMSj2E7oLR6w0DylV6UlI4+jokmEVqaS8mYW6pJY09WHxxqrFyTJ8y1?=
 =?us-ascii?Q?MslxkUYDsVLj6ylRUFWdFh29aQ9M3u/9gbdro7HO0o9Qn7RB5UvVZ3oMhr3K?=
 =?us-ascii?Q?TkIePx7CoWAK45cngH2XfSOSJQ5ATTXNB5CyAWRJvV4zlFr1GAW9vrB/akPV?=
 =?us-ascii?Q?monYAVpKqL9ifJITDs2f3v8A3wWFzGTv2ZLLbb7/u5KnPNnPeVgFfe0RtNpR?=
 =?us-ascii?Q?9Tqo+r7wCCgOgReuXzVh5L1DxbZEwFyHtgu0exbMhGHHhfN0Lro//vRiJWui?=
 =?us-ascii?Q?94mLZJ7QbvXDshAeQqmEpTu2CFGa61BZA/y56wcKmo+bmqFjJLqybVwcDNmN?=
 =?us-ascii?Q?MZLYvCdleHL+VPshlcGgf6B89gYKfkgDkyFzNsv6O76KJ+UM5m+MhNLq23Cl?=
 =?us-ascii?Q?Ea1yhQnmGDGmL861p9EN3PXBCB23ZK5+nzcPvL3aam2vcX1jVPeCEuSBlqmC?=
 =?us-ascii?Q?w5lL8J87D56kj18kGNMH6TtlWlrKtOe2VC580D4sfraOhmL6pX4j7uPaGGmM?=
 =?us-ascii?Q?uLtnSWcXeMSiNQt9dIjTipMhy01CdCD0puD3xZFSS290ZwO64ZNpZQ+javSa?=
 =?us-ascii?Q?ogixs/1C0FgBKi9vnI4HHbztth04+YHlxCx6xCxlVOSHvXmXOD9oN19p6T34?=
 =?us-ascii?Q?NWHR3ddnxckM+SxPGVN2dV+72XMtHxAhXmhYZHk3sbyBKfyQdaJu0MZHzFCs?=
 =?us-ascii?Q?5Dl7fmeX2Q0HfNB7jE9sABtTrKVd3uct2dh99dEW15t51Mw/P1RFwUPO+wFZ?=
 =?us-ascii?Q?kniW27rmMm2F2MlTYFJYwlU44bRJMsA2QlJy92fG/7X2ZhDFI46SCT+g5/8y?=
 =?us-ascii?Q?rKpLksG/BxzzEEsORvzNDd5/mkmODojV7uPesARlvOndajfp7u6XIi/txbDQ?=
 =?us-ascii?Q?U05guSl6HcZOmq/s/9QNGehH0FbMV71gXOjSv2BcjL72Vg6u51kvbuA08NZH?=
 =?us-ascii?Q?J5s2g14BLEzLZno17fGTdGTVKhXpTsgpKDOgft6KvJg0anuCu0Ui1iKYpbZn?=
 =?us-ascii?Q?7Jko1ZyqEZIEulLwc4ZnfNSOiv6l0KeU/yej/1bOZLhrlubUiBkymF8JWH5n?=
 =?us-ascii?Q?E/oyAqOg0G3IuwCYE5lYt8ihipBQAucV76bcTehnIcXRrPxtQBRhYhR/svVB?=
 =?us-ascii?Q?y1a2m77ZfgPWUtMHTc2yXw7EGqJdnQ+haMxyKTz1cIoaO6fNZBuWAjH0lkvl?=
 =?us-ascii?Q?Fs5a7f5bPVfUMigci5jYRZIrHIV8rvzrXKMy/aFIu+vBrozBjEzbDTPg6dVc?=
 =?us-ascii?Q?KQDxYmmzqEgAklyhCsCt4E5AsXFnC8213987TQf2eIccP6VTCP+vRVfs9f5z?=
 =?us-ascii?Q?buDDM4NAKPxj7TVhKKjp5So+HOYU8uUEHbLk75WJm9GDe/99bWH4RtiGVSTI?=
 =?us-ascii?Q?8uWsIOkYoEDlR1H6EwyRqFeyzGHKYoAQ90Yse7gF3XPZMl/DCxEU8BRwBl48?=
 =?us-ascii?Q?86Z9jqvsEmR7ta+xNTEA9nXEWG22m9vh2aywyilf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a47121e-95a0-4193-0099-08dd0994a107
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2024 18:53:31.9232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4mLTzmW8QOWDnRMbiRWFqM4XEcZsGOrcoCftQsamrap3ER35bJVpJxyNBSK1VY0u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6606

On Fri, Nov 15, 2024 at 02:25:44PM -0700, Dave Jiang wrote:
> --- a/include/linux/fwctl.h
> +++ b/include/linux/fwctl.h
> @@ -47,6 +47,12 @@ struct fwctl_ops {
>  	 * ignore length on input, the core code will handle everything.
>  	 */
>  	void *(*info)(struct fwctl_uctx *uctx, size_t *length);
> +	/**
> +	 * @hw_info: Implement FWCTL_HW_INFO. Return a kmalloc() memory that is
> +	 * copied to out_device_dataa. On input commands indicates the number

Spelling 'data'

> diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
> index 4e4d30104667..7334907e27c1 100644
> --- a/include/uapi/fwctl/fwctl.h
> +++ b/include/uapi/fwctl/fwctl.h
> @@ -37,7 +37,8 @@
>  enum {
>  	FWCTL_CMD_BASE = 0,
>  	FWCTL_CMD_INFO = 0,
> -	FWCTL_CMD_RPC = 1,
> +	FWCTL_CMD_HW_INFO = 1,
> +	FWCTL_CMD_RPC = 2,
>  };

Let's follow uapi practicies from the start, give HW_INFO 2 instead of
renumbering rpc (or we need to order this patch before RPC)

> +/**
> + * struct fwctl_command_info - Hardware command information returned from a query.
> + * @id: Driver ID number for the command
> + * @opcode: Hardware command opcode
> + * @set_effects: Effects to the OS and hardware when command is executed.
> + *               Provided by the device.

This seems like it needs a common set of bit definitions if it is
going to be in a common struct

> + * @size_in: Expected input size, or ~0U if variable length.
> + * @size_out: Expected output size, or ~0U if variable length.
> + *
> + * Represents a single command that is supported by both the driver and the
> + * hardware. This is returned as part of an array from the FWCTL_HW_INFO ioctl.
> + */
> +struct fwctl_command_info {
> +	__u32 id;
> +	__u16 opcode;
> +	__u16 effects;
> +	__u32 size_in;
> +	__u32 size_out;
> +};

What is the difference btween id and opcode? That should be explained
in the comment

I'd suggest to make the raw HW id to be u64 'just in case'

> +/**
> + * struct fwctl_hw_info - ioctl(FWCTL_HW_INFO)
> + * @size: sizeof(struct fwctl_hw_info)
> + * @flags: Must be 0
> + * @device_data_len: On input the length of the out_device_data memory. On
> + *	output the size of the kernel's device_data which may be larger or
> + *	smaller than the input. Maybe 0 on input.
> + * @nr_cmds: Number of commands requested. 0 returns only nr_cmds in output.
> + * @out_device_data: Pointer to a memory of device_data_len bytes. Kernel will
> + *	fill the entire memory, zeroing as required.
> + *
> + * Returns hardware commands information about this fwctl instance.
> + */
> +struct fwctl_hw_info {
> +	__u32 size;
> +	__u32 flags;
> +	__u32 device_data_len;
> +	__u32 nr_cmds;
> +	__aligned_u64 out_device_data;
> +};

It isn't really device data, so this should be called out_hw_info

Jason
