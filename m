Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012003.outbound.protection.outlook.com [52.101.43.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1283C3242D4
	for <linux-cxl@vger.kernel.org>; Fri,  7 Aug 2026 05:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786081115; cv=fail; b=Mu7DAevjPDqwYrcIDzJoVlwpQSx/2/cE8FUOL+7Fbe8TTabELyy66y/3H2qN2zY2QRarm1Xvan85KH51a5x9hpyjGjNVyv4x2bdEzn0V/wrAZ6AlqRPmKj2/EY+CDBjob0gM0rWJXDfXDK2n7My/7F5r2TAyfYgbEfHw6czTapM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786081115; c=relaxed/simple;
	bh=ydTx+4gdV8VnON+VQEqM2M16jcTw2djVbSvoLHnxBAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=md9RSztuYszHwCaw5E+Rm7wEsAruMREhsklPeyvTdBcGAgnR4uPGXloTwKNYdwN905uf4RLpiM9pIPD+8fg4AhWSbjhVjoKxV45kvHH/Mo/vffpADFT+W5pdamXadNMw1WYFUu0DtIh0Q4gNKDIg0v+nN2QJGHmlck5OTLCS5es=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qazdZlWP; arc=fail smtp.client-ip=52.101.43.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qazdZlWP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p9pRr8D3wQ/LYW+vqG8x3MK4+QA5IWCk09g78HSCljGkG9i7The4dY5FOqYY+0Pa/UOF6y/q65I9A6Skr65flPFgFD7PPz711eBsl+b1ETJRNvn0IJhD8c6L3cQ6vYI+KfW90aObnOuSSAh6rnm6f3/hNQOqOAS2dluy5qffLkivjNaLK90Gj0rSkYxeM3fQPSdyVMI2LuzNycg6O1dVBlYyIsTrAH9QISP6ih7Z4iQGoDsw6AQEkUq6RcJJb9cHHNId1EkJLbbIu5LtshXnI0ml+aNeDN6vWGtM3MaNPI5doWHrvXBK8HcNbHWBfuLwM5SAT0Bbs17p9b436wz2RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bZI8h7syHZCdRR6bBaQodclkqZQmRVojjtWNQu+Qm0Y=;
 b=aBoq0yqwPftJ+fPDZOhbDTqMfDCu1ExE2YV8mRJm6ja770Okgvg7vs3f+pyx20ZjnxriNPwYmUfsKyPR9G0saGSD24DHLnj9O/I6FhSrPOFk7aXxuSDbZpiV+Pz2axiqANw0bbn5kemMnLpGgGStr/0jB+sZF5PtxBpuDFEYCtbcbDmWcFzAVTDKlpWAlCeqFTpjhfmAcD8d4ib0x79p8707lDEmhTej8ZjEN4WWdnZfmYAr/Q4ZDQYmbxWtxZYcd84mefyPy6ubXBs9raPU1IDut0/UCOwoEHE6ACqwS8lyzgO72IvSOqvLnZg/qzJvxIGznSIeWCVyXs+z4S9GHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bZI8h7syHZCdRR6bBaQodclkqZQmRVojjtWNQu+Qm0Y=;
 b=qazdZlWP1qkGcdXors6SEbFYJDhWXf4pWvRCiLklC6fTGLbD+ijAKIp0kvUNwUIy7kwumYX2u/NGrxtK4vkNiB4m5kJj+Lp3wEWkLVTyGtCIigaJbUStxtY9iZXB2qaSHlr457RMFdxXEHrdk383rV5YPkNCPAyayF+28oM3dp+Cwy7EbZSfdMIAvgFjPnUVKtoWEdMr/4Ol/S1hT2ChuimMPkBLxaXTAGNMbHenT7sHp/9SWdc3WRolHJChRGGnIvPwIFneu0CHmv+GUmFea6w3A/jjOIlJxNpZqCh8rXEeEmTmQHW9mySWfzm5J5yC8mxqEg+LWldkZ9znyUswdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by DS7PR12MB5791.namprd12.prod.outlook.com (2603:10b6:8:76::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Fri, 7 Aug
 2026 05:38:29 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0292.018; Fri, 7 Aug 2026
 05:38:28 +0000
Date: Fri, 7 Aug 2026 13:38:22 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: dave.jiang@intel.com, jic23@kernel.org, alison.schofield@intel.com, 
	benjamin.cheatham@amd.com, alucerop@amd.com, dongjoo.seo1@samsung.com, 
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v7 1/8] cxl: Add BI register probing and port
 initialization
Message-ID: <anVt9LtGbP8PzklF@MWDK4CY14F>
References: <20260728144136.709882-1-dave@stgolabs.net>
 <20260728144136.709882-2-dave@stgolabs.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728144136.709882-2-dave@stgolabs.net>
X-ClientProxiedBy: JH0PR06CA0009.apcprd06.prod.outlook.com
 (2603:1096:990:77::13) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|DS7PR12MB5791:EE_
X-MS-Office365-Filtering-Correlation-Id: c2046820-9140-4570-b561-08def4461bd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|56012099006|5023799004|11063799006|4143699003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	H8WVQvTTZh3fBuCCqDGiUhR07CORTzQTRicVydxH3rTX5bJBpaR3T5ySiZtmWcGlDVoQuF0QaG5Z+EFvaBeT2ls7GrDbXIcGfW4Q9IaLZsgNRYMBy+z1aVL2m3ovdDEKynsLO6u7lAkRNtxH75M38zP/jV8PqVM5BznQlk+ZaolmMKa24h2pr624G6Df415UVwjR2a4Syj6kfjgq0ujBDvSGLn/mWVgeuLYFQ/efUEjYtrUal9YyL8evw9p61cT0cVgccW5/iGsiDdEk6Hv8DJZQN0gaStT5hbjYo/WQx7FahfRG6W4oNIPPgPe2C6UxPJUrs0xSXx+MWA1U7f8dHozXEpyVx77FeQusy3MSTEorRVHowgXfp6Hihkbz/l2u8rafl0E5jqbMVSEZToSYARAa+96R2MLwli5gg4+prp3lhlAvi70gjb/X8tYCEN5ALKqtTxam2u8bIIVU5MP7HKQEyxi0j6BDq5x+WWXaBOYF+tpZiWv6TN0uOCTHN3uRyiRAYhIJkv56sqqwGDbS9Gd9FJYpi8UXYy+q3zr+18V9GvmntCtEG0Uyk/A+AFby4wvBpTcrXb/OQeR8uN/KzyHxdd7hmmh59o3tuXHTDjDuC8ybA7x1HuS7sHQ3WxfpInlFZRz5ZQQskjBOYw5sP3F+qw86NeTlBXQKXXNdKvA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(5023799004)(11063799006)(4143699003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3ldbQZy5+kvvnrZDT4PTLPTecx0uhKIfyCDZdtB4/EtLc3UD16H3wGm21Rh0?=
 =?us-ascii?Q?rXjzKRyPjXRkdC5GCruRcjUNAxJUaUDaJMWDs8Np3vJaxgFWAPh6HzPLlBg2?=
 =?us-ascii?Q?+Vlb9+hSPZsOTtHfP73Us/DVsmxRlvYTt4QPWDv17Qt/vaaYxkGMrC01OWu3?=
 =?us-ascii?Q?KC/3TwINnHwfqtT9P9KqcvM6NLvzSesjc3Sqjk2LFDa3TNcRaEu9FK3Us44O?=
 =?us-ascii?Q?yavMDLG95AX8bQXJR+ilmyT8JxRDIm4B7tQbNSa4AXtvz3OiJhY2zfpUZTcO?=
 =?us-ascii?Q?ZiYchXS6g5XSKwJlKIUItr8BnKll9Gv69HmmkyCl/PB1zJ9svc0lPuskmUN6?=
 =?us-ascii?Q?vTsiIT+LU88GujwAuboMCSXXrwh5LyjsapcajIP/oCAFdFJEKfuF+EBuuPJs?=
 =?us-ascii?Q?ZC2ixM3BAiPcfOQGUSe2gN8DmGDf/LRZH6qziKBbQugcylA+DF1uf7QnG6Ll?=
 =?us-ascii?Q?mFqXhw0DQzw4lK9cFi7NepfF5QO/UkD+DzeG+iD5SfgXz+OCPC2zFSYCG+l1?=
 =?us-ascii?Q?UOOt5QYt8cTilyJU+YKwDtNly/j9idcnIF23OffLLiLkqPjTmen9GqLTsZnN?=
 =?us-ascii?Q?DIml45SOH/2LPzV5/UXm/GV9VL7hTT8ttlb9wwsfiEHY609vcskDTaa28wzP?=
 =?us-ascii?Q?Wa3gvlClgM18NKlkDaENq8fI0la/Eswq/iUbvaIoMHcj/ae7b3PClbzp9VJ8?=
 =?us-ascii?Q?4zf7Yy5LGnvMLlx3SK4PpUWQIV/SsY5702atR5JEblU/iJISfDGDoQZ2syyK?=
 =?us-ascii?Q?3vkWAHnfangGBhJk0u+594NDHmfhMyKmEcZpY9RlWE6LxIHNOpz4yzIWXbA3?=
 =?us-ascii?Q?jMSEYCkt+wbaTBtmlafU3m+p3pTSJqhgSbk3NV7mpeDZ3/tsLflGW+O+56LH?=
 =?us-ascii?Q?rL2N5RlrdN5RZle2cD76QAqEX0pbHactkgAXhWZI12GbyPSTiZcGDF0AYrT8?=
 =?us-ascii?Q?PzA5Uv59GrS3fKvQYEbZv7ZK3+KA+GFaZ+ea8auvR0sos4AYcfRfg6AToMIo?=
 =?us-ascii?Q?0KLQv8H2HR3iyqYTOGrCI0JH275tW7LLhVLOf8dIV+EpeOsITNAOI5fNBr77?=
 =?us-ascii?Q?3aPLDALuLqp8fosj+BjzUg7HqqY6PwyrP0Ykh3sou6Cs6zq9/Z4mfcXzzJiu?=
 =?us-ascii?Q?QvNzF0aOqaoxtBGGm0B/XQ+4vcD67e2iwTbBJU4i0uUcVtlzHJQ8KHYiPJfp?=
 =?us-ascii?Q?oEmZ8h9/zJCKtqj6pGddSDZDNfCuicsgkALj0B5au/nRZRUbLARnsBgQYirQ?=
 =?us-ascii?Q?lhNVIrReA+FrKnF9g3bIrwNcaraCU7fxZgSrFPuMPYEkzk+eJFOf/AeFuKAv?=
 =?us-ascii?Q?okPsAR/lDA3L8StZzjJGudsZ0FkWWFi5AqtjnDGibP9HD0H6h2iMwUVRWIWJ?=
 =?us-ascii?Q?hW86mA8f9Sw1wKuK69adGms9UkH1+YE4O2ekz91sxXHue3YRTA7nylg9nE99?=
 =?us-ascii?Q?9QwqoJTjn7FnaDZGSVT/gPiDp9/6wjLypQYsS7nGiTRZbIpAY4I2gNMDVvWy?=
 =?us-ascii?Q?/ESj3MPGBTxMkNCpBBppqv9OQT1qDA9SHVV/JfkcBOuXeRgq96a44unAw0ky?=
 =?us-ascii?Q?TAy9lqK2cpfr9N+D6Z9j3aRANHF2vCYN3QXT1b3xZV0jQZ+HRHYcrpD5di63?=
 =?us-ascii?Q?djwESPTAIXJAV3aEQBfKwO0xf4MarHfzmYjNOMoEFwr3iO5hmcY0dK89pDqb?=
 =?us-ascii?Q?cQ7UXg1Rcc9//uTnCA8/BsqHQ+98vvOrdwCZ1LTE/4DCunGO/fJn7kVi+nJD?=
 =?us-ascii?Q?Qc5GQIrmZw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2046820-9140-4570-b561-08def4461bd0
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2026 05:38:28.8477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7tOBSOa+pVWnTw49wBgaIBtDuFuDyHZlzZMD6pl7rMLb95dDrPDbxO05rtvMc4THkpX7Y+CC7WpekQOTmC7iSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5791

On Tue, Jul 28, 2026 at 07:41:29AM +0800, Davidlohr Bueso wrote:
> Add register probing for BI Route Table and BI Decoder capability
> structures in cxl_probe_component_regs(), and helpers to map them.
> 
> cxl_dport_map_bi() maps the BI Decoder of a downstream port (root
> port or switch DSP) at dport-creation time via cxl_port_add_dport();
> cxl_port_map_bi() maps a port's own BI capability during port probe
> when the upstream link is in 256B Flit operation -- BI Decoder for
> an endpoint, BI RT for a switch USP.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/core/core.h |  1 +
>  drivers/cxl/core/pci.c  | 38 ++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/port.c |  4 +++-
>  drivers/cxl/core/regs.c | 14 +++++++++++++
>  drivers/cxl/cxl.h       |  7 +++++++
>  drivers/cxl/port.c      | 45 +++++++++++++++++++++++++++++++++++++++++
>  include/cxl/cxl.h       |  6 ++++++
>  7 files changed, 114 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 07555ae63859..e36b55fd63bd 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -209,6 +209,7 @@ static inline void devm_cxl_dport_ras_setup(struct cxl_dport *dport) { }
>  #endif /* CONFIG_CXL_RAS */
>  
>  int cxl_gpf_port_setup(struct cxl_dport *dport);
> +void devm_cxl_dport_bi_setup(struct cxl_dport *dport);
>  
>  struct cxl_hdm;
>  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index e4338fd7e01b..f82559d8a8c5 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -926,3 +926,41 @@ int cxl_port_get_possible_dports(struct cxl_port *port)
>  
>  	return ctx.count;
>  }
> +
> +static void cxl_dport_map_bi(struct cxl_dport *dport)
> +{
> +	struct cxl_register_map *map = &dport->reg_map;
> +	struct device *dev = dport->dport_dev;
> +
> +	if (!map->component_map.bi_decoder.valid) {
> +		dev_dbg(dev, "BI Decoder registers not found\n");
> +		return;
> +	}
> +
> +	if (cxl_map_component_regs(map, &dport->regs.component,
> +				   BIT(CXL_CM_CAP_CAP_ID_BI_DECODER)))
> +		dev_dbg(dev, "Failed to map BI Decoder capability\n");
> +}
> +
> +/**
> + * devm_cxl_dport_bi_setup - Map BI Decoder registers on a CXL dport
> + * @dport: the cxl_dport that needs to be initialized
> + *
> + * Must be called while the dport's devres group is open so iomap
> + * allocations are released on dport removal.
> + */
> +void devm_cxl_dport_bi_setup(struct cxl_dport *dport)
> +{
> +	if (!dev_is_pci(dport->dport_dev))
> +		return;
> +
> +	switch (pci_pcie_type(to_pci_dev(dport->dport_dev))) {
> +	case PCI_EXP_TYPE_ROOT_PORT:
> +	case PCI_EXP_TYPE_DOWNSTREAM:
> +		dport->reg_map.host = dport_to_host(dport);
> +		cxl_dport_map_bi(dport);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 1215ee4f4035..b2f8fb9547d3 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1242,8 +1242,10 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>  
>  	cxl_debugfs_create_dport_dir(dport);
>  
> -	if (!dport->rch)
> +	if (!dport->rch) {
>  		devm_cxl_dport_ras_setup(dport);
> +		devm_cxl_dport_bi_setup(dport);
> +	}
>  
>  	/* keep the group, and mark the end of devm actions */
>  	cxl_dport_close_dr_group(dport, no_free_ptr(dport_dr_group));
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 93710cf4f0a6..a6caa793e7a4 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -92,6 +92,18 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>  			length = CXL_RAS_CAPABILITY_LENGTH;
>  			rmap = &map->ras;
>  			break;
> +		case CXL_CM_CAP_CAP_ID_BI_RT:
> +			dev_dbg(dev, "found BI RT capability (0x%x)\n",
> +				offset);
> +			length = CXL_BI_RT_CAPABILITY_LENGTH;
> +			rmap = &map->bi_rt;
> +			break;
> +		case CXL_CM_CAP_CAP_ID_BI_DECODER:
> +			dev_dbg(dev, "found BI Decoder capability (0x%x)\n",
> +				offset);
> +			length = CXL_BI_DECODER_CAPABILITY_LENGTH;
> +			rmap = &map->bi_decoder;
> +			break;
>  		default:
>  			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
>  				offset);
> @@ -211,6 +223,8 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
>  	} mapinfo[] = {
>  		{ &map->component_map.hdm_decoder, &regs->hdm_decoder },
>  		{ &map->component_map.ras, &regs->ras },
> +		{ &map->component_map.bi_rt, &regs->bi_rt },
> +		{ &map->component_map.bi_decoder, &regs->bi_decoder },
>  	};
>  	int i;
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index c0e5308e4d1b..f9fcb6387fc8 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -39,9 +39,16 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
>  #define   CXL_CM_CAP_HDR_ARRAY_SIZE_MASK GENMASK(31, 24)
>  #define CXL_CM_CAP_PTR_MASK GENMASK(31, 20)
>  
> +/* CXL 4.0 8.2.4 Table 8-74 */
>  #define   CXL_CM_CAP_CAP_ID_RAS 0x2
>  #define   CXL_CM_CAP_CAP_ID_HDM 0x5
>  #define   CXL_CM_CAP_CAP_HDM_VERSION 1
> +#define   CXL_CM_CAP_CAP_ID_BI_RT 0xB
> +#define   CXL_CM_CAP_CAP_ID_BI_DECODER 0xC
> +
> +/* CXL 4.0 8.2.4.26 / 8.2.4.27 BI Capability Structures */
> +#define CXL_BI_RT_CAPABILITY_LENGTH 0xC
> +#define CXL_BI_DECODER_CAPABILITY_LENGTH 0xC
>  
>  /* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
>  #define CXL_HDM_DECODER_CAP_OFFSET 0x0
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 99cf77b6b699..a527dd13fb68 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -58,6 +58,47 @@ static int discover_region(struct device *dev, void *unused)
>  	return 0;
>  }
>  
> +static void cxl_port_map_bi(struct cxl_port *port)
> +{
> +	struct cxl_register_map *map = &port->reg_map;
> +	struct cxl_dport *parent_dport = port->parent_dport;
> +	struct device *udev;
> +	int cap_id;
> +
> +	/* no upstream BI registers above host bridges or the cxl_root */
> +	if (!parent_dport || is_cxl_root(parent_dport->port))
> +		return;
> +
> +	udev = is_cxl_endpoint(port) ?
> +		port->uport_dev->parent : port->uport_dev;
> +	if (!dev_is_pci(udev))
> +		return;
> +
> +	/* BI requires 256B Flit on the upstream link */
> +	if (!cxl_pci_flit_256(to_pci_dev(udev)))
> +		return;
> +
> +	/* map this port's own BI capability */
> +	if (is_cxl_endpoint(port)) {
> +		if (!map->component_map.bi_decoder.valid) {
> +			dev_dbg(&port->dev, "BI Decoder registers not found\n");
> +			return;
> +		}
> +		cap_id = CXL_CM_CAP_CAP_ID_BI_DECODER;
> +	} else {
> +		if (!map->component_map.bi_rt.valid) {
> +			dev_dbg(&port->dev, "BI RT registers not found\n");
> +			return;
> +		}
> +		cap_id = CXL_CM_CAP_CAP_ID_BI_RT;
> +	}
> +
> +	map->host = &port->dev;
> +	if (cxl_map_component_regs(map, &port->regs, BIT(cap_id)))
> +		dev_dbg(&port->dev, "Failed to map BI capability 0x%x\n",
> +			cap_id);

Do we need to distinguish an optional absent BI RT from an advertised BI RT
that failed to map?

In both cases port->regs.bi_rt is NULL, then cxl_is_bi_capable() accepts a NULL BI
pointer for a USP, and __cxl_bi_ctrl_dport() consequently skips __cxl_bi_commit_rt().

So a mapping failure of a present BI RT can be treated like the switch do not need a
route table.

I think we should treat mapping failure of BI RT differently.

Best regards,
Richard Cheng.

> +}
> +
>  static int cxl_switch_port_probe(struct cxl_port *port)
>  {
>  	/* Reset nr_dports for rebind of driver */
> @@ -128,6 +169,8 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	read_cdat_data(port);
>  	cxl_endpoint_parse_cdat(port);
>  
> +	cxl_port_map_bi(port);
> +
>  	get_device(&cxlmd->dev);
>  	rc = devm_add_action_or_reset(&port->dev, schedule_detach, cxlmd);
>  	if (rc)
> @@ -252,6 +295,8 @@ static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
>  		 * on failure, or the device does not implement RAS registers.
>  		 */
>  		devm_cxl_port_ras_setup(port);
> +
> +		cxl_port_map_bi(port);
>  	}
>  
>  	dport = devm_cxl_add_dport_by_dev(port, dport_dev);
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 016c74fb747c..2816954680b3 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -34,10 +34,14 @@ struct cxl_regs {
>  	 * Common set of CXL Component register block base pointers
>  	 * @hdm_decoder: CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure
>  	 * @ras: CXL 2.0 8.2.5.9 CXL RAS Capability Structure
> +	 * @bi_rt: CXL 4.0 8.2.4.26 CXL BI Route Table Capability Structure
> +	 * @bi_decoder: CXL 4.0 8.2.4.27 CXL BI Decoder Capability Structure
>  	 */
>  	struct_group_tagged(cxl_component_regs, component,
>  		void __iomem *hdm_decoder;
>  		void __iomem *ras;
> +		void __iomem *bi_rt;
> +		void __iomem *bi_decoder;
>  	);
>  	/*
>  	 * Common set of CXL Device register block base pointers
> @@ -80,6 +84,8 @@ struct cxl_reg_map {
>  struct cxl_component_reg_map {
>  	struct cxl_reg_map hdm_decoder;
>  	struct cxl_reg_map ras;
> +	struct cxl_reg_map bi_rt;
> +	struct cxl_reg_map bi_decoder;
>  };
>  
>  struct cxl_device_reg_map {
> -- 
> 2.39.5
> 
