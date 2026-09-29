Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012005.outbound.protection.outlook.com [52.101.48.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CF535DA4C
	for <linux-cxl@vger.kernel.org>; Tue, 29 Sep 2026 04:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790654797; cv=fail; b=aclfq7Y/ykokYFoyXqAg7tlkhredMyce289pWs+b4T3jTSXEbZpxV9lkRJEvb0LuAz4+bJQ6C9I5zRM+sB5wYo8Ofj3fsOvsz443qp2HMmwmqMciLWglr6GTBFfw5weIZfz0DSXnIGymxPU6fxygRh77j1q+oamabNWok/4sNPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790654797; c=relaxed/simple;
	bh=4OKpcmuQiiQ2JGzmcVss6oJ2vfbYDI8PDsJImIwDSTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ch4FtuotBs3nYNKg7HA7t740MpWVxLFECB0E6EaXAS0eyIKJqh8KMWksP9elkeLJh1irHMlz55QcPsfMcU4k3zCPaFVB6mTlFqyrjfDevw9KjUiUSrDWU/ErQYPU8/4XUixIuv8zpojYCYatk575Hvlk4m6RjgDAILe5Y177p9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mQZYFbC2; arc=fail smtp.client-ip=52.101.48.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mQZYFbC2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IM72SWppXqqRjZwLdhrkc2s1nXJQkqCYOxqgpBMxRgb4hneZqjp5vmCEnYP4PsqRy7Yz5DHXy4sCYWuW3EJ+3Ls1EM8+krh6O6PwRvuhIvrfw4fm6FCn6Y80FUl5wukAIGtg78B4T4mjbXLaFS/D6jomjC9uan8PxY11hzgwPa4AEyZzaQoE3m4vnMXWcMhiN42KomXWTLT98svO0GhE0pYp7x9bqyjO8IKxjISht3jTqXwTJYzoIkmzhE0D4S3w1yC/lR64PQPoaXKQ83IRiLQWGDPvK1o4Sc6lBNFJkFALrzl25teM7d2LZ1xBa0sSS9PXMxRBMyT9qEGk+t7JUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9W/FmQsmtgJFZczVbwTViExtQerrR0nj4lUrkyRWCuk=;
 b=FYTAqxPoqhm9q5APT6q/6zQBlGJkB9A/RmB7a6ykNewJ+CBkPtk2Qu8sU+w++aTGQ5KTy62WlQrpomxlyVIyeIYP2MnYdHNnflyLrRgufLYigSXxqYd2OrYrBu3aPCx2wTG3MdiGyrriDBl2r9IMM8/CVAbz8UCqFAQZh5hzoVyoV+2GYC6zsRXAGugG+isbT+RSXqkiCOSx0Nwu9fqutYDH/lrOMhJBMNkY19D1u/DvqAPgOIOMYKFIfK+2IPMGNf2R6Tfxc4rBCKBwrGiDAZKKsRpgrG6iFGNnHoqizRJATKUFc6GZydFMM8AA5PRsE38OWjBpS8JaTbroC17Y8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9W/FmQsmtgJFZczVbwTViExtQerrR0nj4lUrkyRWCuk=;
 b=mQZYFbC2JifTQhh1DX/sCiy4OJzLbWZPwosri+YRlvprJhumpj92UCK77qYTvtMsgXVA8jKozow+iL/54tTecxOyH4UiwWtQeKjeYWEvk78abBf+5v48zykrvO9lqzYSS/5hv6SfzvW6fq0gi/XcJ65vCp7bJmg1VtDmU03b18N5nHJL9vDl2xwo+8pi7Ig23QOLKOqukJQG4JraVQo7/k4cQqyApjkKh/GF/Ptr7S8hnWCZ8aXceniN1ws0ZcSg2/IcZn+7m0izx49IIdlIS36B7s7+tdtOo2LZx0yrw1VdEaDbtygak5Z91Z0uMCCZ2CbXPh0hOA6pBdDeRaS62A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB2370.namprd12.prod.outlook.com (2603:10b6:207:47::27)
 by MN6PR12MB8567.namprd12.prod.outlook.com (2603:10b6:208:478::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 04:06:29 +0000
Received: from BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8]) by BL0PR12MB2370.namprd12.prod.outlook.com
 ([fe80::86cf:c3ec:2cf5:74c8%5]) with mapi id 15.21.0451.014; Tue, 29 Sep 2026
 04:06:29 +0000
Date: Tue, 29 Sep 2026 12:06:22 +0800
From: Richard Cheng <icheng@nvidia.com>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: dave.jiang@intel.com, jic23@kernel.org, alison.schofield@intel.com, 
	ming.li@zohomail.com, benjamin.cheatham@amd.com, alucerop@amd.com, 
	linux-cxl@vger.kernel.org, Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: Re: [PATCH v9 01/10] cxl: Add BI register probing and port
 initialization
Message-ID: <ars4reMzd-5pR7YB@MWDK4CY14F>
References: <cover.1790103847.git.dave@stgolabs.net>
 <b865ac6b59ca14cdf48389f3d4a25e16b9e8a597.1790103847.git.dave@stgolabs.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b865ac6b59ca14cdf48389f3d4a25e16b9e8a597.1790103847.git.dave@stgolabs.net>
X-ClientProxiedBy: SI2PR02CA0026.apcprd02.prod.outlook.com
 (2603:1096:4:195::19) To BL0PR12MB2370.namprd12.prod.outlook.com
 (2603:10b6:207:47::27)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR12MB2370:EE_|MN6PR12MB8567:EE_
X-MS-Office365-Filtering-Correlation-Id: 980c5778-bd54-4264-e8f9-08df1ddf09e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	rjiS/s80299StZQnrO95R/mkC4pYWS/SWW0uSAuJEEs9Vc4MLHvXnHkpeOQmAe6Wn2kwzRZceopd0y9ryeWfVQ72dU9NPsLNfEbjjX179bjLP0Dyn4nNQWnkGAENmcardyNqPHWooxsORZX0Dj7zn4exqYBnjBVYVD2ajVUl2uOnMuQC5bn5/HgDwNY/9PSnND9iHZvcxba6hKdbAPMVk6N2o2MeMuO/vq+V5c46fVeQflmDzCH7sHBkxwPVnatlaOL1Tq+Hz703msq37a4sJWGlSf3qJPNUOjhkG7AtW3CvwwD7l5RbClxutqFrybMtAi4GDPhFdYvd9jC2/a5a+nCSEw6PKfIXdAHM2xU+gez+lc5FTAQENyZASqZS79Vk6+zetdKSBr9BygvCxkFqFIKfTjZEvC3CUaFA7nqTOsASLgyVVyEgmmiJyKiNn47ehEe0HdEkbDe+Zrd/LHlXLIHoihgzQlsW6/TM4mS1lGLsrsyL8Q2W3BCncmQucHPLEJq3LJS3ftemIGs9zmDMMZjW6C/HExenF0dSuA0/6t2WtczOkl1nmJYjb8QY694CW0wHtgR0Kj6N6kmB6odzaa+yG8mh3GnoCobXZxq5eV0DM16iSy85r9cir6LYjl3G9XBjsMHJ71Ki5g5WoKrGSJ/QW27hqpJtc0e9Ea/4DtQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB2370.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0DmoXoGxdpElnK1AoVJqAbpYKFJPr0TGokR8nVlkX8tMBKP0t7ZOWS+08xYN?=
 =?us-ascii?Q?SHM/HST3osfFBpV+KcAWEaT56SojDGJz9u32RLB/oF+U3ru6XLr/+HWStdp3?=
 =?us-ascii?Q?tLAJA4Uk1YWh5vdWoo6lnmQNcdJHQSeuRQFw8vBhduHqsTZFMu1x9mN0msbo?=
 =?us-ascii?Q?Kdc8lE7rFDG/v7w/5Zqyox7SOOjhdxdKkQYKWxaaxbv8OSDmeUhn+6GkM2L2?=
 =?us-ascii?Q?t91EDFmfNIesqsTeS1YZc9qKgHwNiioTg18I0omNODFECyyfQoFBR/ayEybr?=
 =?us-ascii?Q?sFZ2bLcOuC/yLp1mS/6BhjxmADnS+h3zHsjYdxBP6PQPFDABiyYL+lh/vjSG?=
 =?us-ascii?Q?P1fiRDB6VWfAfJEQHUuXL1I2f4XH+e1TPpWkOJD3DSEfqmclP7/EQbZ+lmfe?=
 =?us-ascii?Q?Yaw7KO1XNt9XCOgg1IsxLuO0lbFOu2vDlZ7DGhVD8n3v9Bswt+0FSoFvIkqm?=
 =?us-ascii?Q?UEBjGmfw1g3eRok60Hw2GHlu7C8qkfoLM74P3w8E9EBhPtz82tvSymNbr5do?=
 =?us-ascii?Q?NygZALJqAeqShm6Yw35lRlm7Z9bn6dyVmcJ4796SmhLRyosPmmW9nLntl24K?=
 =?us-ascii?Q?y6Jkn8W2HADWmukaTiht7uy9IfsTCgIk6spej5ob9I5WoHiLCuhLrrL9r9WH?=
 =?us-ascii?Q?cojxaVwRMkKLjXJ8GzVB37Rv/WtgDz1LK1Ztr6Z8VstbDMddVK0VG8JMOrOR?=
 =?us-ascii?Q?Hhz5KHXCxmAa2mIH+FH0vXzhhyphE0d9dRnxjxedRHPUZPRZafXGe50OLkip?=
 =?us-ascii?Q?mJxu1c1fZ8ZVrdA9CNPYhzcVucAA9WOXEz2gA1BSj3FlSeMgcbPqQN5G/KfP?=
 =?us-ascii?Q?j9iG5wmuTIfn/b16MX4ALjqwVyZtyUk76f12FoERsaMR8bQdoi3ANExlWACo?=
 =?us-ascii?Q?Bxe68SExqG7SgTPtMNvv0deCmmGl/Zx+kh9zO4AF2BDuJHkPelmNNr9PdThw?=
 =?us-ascii?Q?IiXxZeOHc6iP8rv0sPYsUdiRlQ3Lo6j8qWVbhVMn2c5/McqTksPnRLgcWfah?=
 =?us-ascii?Q?Hgqz8SUvId7l3N6MTTc6DK9wF5ISBjKh5lFGj1SzzWUNxbYvOOI1k16BwtEx?=
 =?us-ascii?Q?LCBo7wNkSVzV6YwVLaojVBTIKNiW/eNuydtfJeqN1P2wqBsKPEuVd2fTZ5pD?=
 =?us-ascii?Q?esQdM1bP//hgR2E9Sj2RqFcXPVti0aYuy7S2p97dFUt/SIkZXT4W/+WSRBqv?=
 =?us-ascii?Q?uYKYeXsyHKJc1GzE6uS9fGPpCUX8xhCivnzl4JEdDs/6zgb+fgN+Led5Pyyv?=
 =?us-ascii?Q?3+zkGzZhOi3yzfQMLsHAjDYqx28uvvzFtPSMUIEt8SMA4y+/zzRzlCULbEgi?=
 =?us-ascii?Q?I5AkA+HPzIKCzCCgMFI+A4PIPXnHRqCSE5V8CILHviTqeWl6Kv+gHyz0nfRr?=
 =?us-ascii?Q?qvxIjOsdZokU7yCko1Z2xAxJUGlS5U4ZpC/OLzzQF/LfpJDntXhqqdShCQ9p?=
 =?us-ascii?Q?1jrODPq0U3FUWhR0jBhc9lfEAjP+rEIKPMWkfJ7i+F5dXAXY923foVyVzPoH?=
 =?us-ascii?Q?IrxlvRH9kLWMtnkwjXOrElTm+ojz3P0C2ScjuDODV2xYrDJGcKRpOqUCIC46?=
 =?us-ascii?Q?ittDANnig5qNYf3EAq0/ADWXm2HlEKI9fDeEkrjpe9lfmeeVNyIWOkQv7LKE?=
 =?us-ascii?Q?TFWdfQ0cBCF9eHauJ3jn6GsRN+Y33heSWXUWUCw75YYNnxEJWnwTVEK+sWL5?=
 =?us-ascii?Q?J2JXJPnLgaxCvtoJJBM8IvJouXyDu42E8Kbch8xSkmre9mBP/SM6rO+OtQdU?=
 =?us-ascii?Q?CixXRNE5Ow=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 980c5778-bd54-4264-e8f9-08df1ddf09e1
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB2370.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 04:06:29.4225
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +xMslvz0qVL/ItZVyM/IXGJP7DcmfAq0SUnBN/LZhSPwMk/I/iQYVr16lcaGVvIVu8VK9WHSPTbavKOc8P7PWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8567

On Tue, Sep 22, 2026 at 04:38:38PM +0800, Davidlohr Bueso wrote:
> Add register probing for BI Route Table and BI Decoder capability
> structures in cxl_probe_component_regs(), and helpers to map them.
> 
> cxl_dport_map_bi() maps the BI Decoder of a downstream port (root
> port or switch DSP) at dport-creation time via cxl_port_add_dport();
> devm_cxl_port_bi_setup() maps a port's own BI capability when the
> upstream link is in 256B Flit operation - the BI Decoder during
> endpoint port probe, the BI RT of a switch USP on first-dport setup.
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Li Ming <ming.li@zohomail.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>


Reviewed-by: Richard Cheng <icheng@nvidia.com>

Just a nit below, no blocker.


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
> index 35eaf636adc9..384bad8cb70f 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -208,6 +208,7 @@ static inline void devm_cxl_dport_ras_setup(struct cxl_dport *dport) { }
>  #endif /* CONFIG_CXL_RAS */
>  
>  int cxl_gpf_port_setup(struct cxl_dport *dport);
> +void devm_cxl_dport_bi_setup(struct cxl_dport *dport);
>  
>  struct cxl_hdm;
>  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 9d807c1a002c..b8676a3d6ec9 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -927,3 +927,41 @@ int cxl_port_get_possible_dports(struct cxl_port *port)
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
> index 625e4aa427db..131ed62e8db3 100644
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
> index 20c2d9fbcfe7..f2c424d129f7 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -93,6 +93,18 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
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
> @@ -212,6 +224,8 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
>  	} mapinfo[] = {
>  		{ &map->component_map.hdm_decoder, &regs->hdm_decoder },
>  		{ &map->component_map.ras, &regs->ras },
> +		{ &map->component_map.bi_rt, &regs->bi_rt },
> +		{ &map->component_map.bi_decoder, &regs->bi_decoder },
>  	};
>  	int i;
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index cab8ce39f465..65be3b91259a 100644
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

These 3 macro all refers to 0xC , should we add comment that they're
independent of each other so if in the future someone wants to refactor,
they won't accidently treat them as dependent value ?

Best regards,
Richard Cheng.
  
>  /* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
>  #define CXL_HDM_DECODER_CAP_OFFSET 0x0
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 99cf77b6b699..eab935eca9b1 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -58,6 +58,47 @@ static int discover_region(struct device *dev, void *unused)
>  	return 0;
>  }
>  
> +static void devm_cxl_port_bi_setup(struct cxl_port *port)
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
> +}
> +
>  static int cxl_switch_port_probe(struct cxl_port *port)
>  {
>  	/* Reset nr_dports for rebind of driver */
> @@ -128,6 +169,8 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	read_cdat_data(port);
>  	cxl_endpoint_parse_cdat(port);
>  
> +	devm_cxl_port_bi_setup(port);
> +
>  	get_device(&cxlmd->dev);
>  	rc = devm_add_action_or_reset(&port->dev, schedule_detach, cxlmd);
>  	if (rc)
> @@ -252,6 +295,8 @@ static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
>  		 * on failure, or the device does not implement RAS registers.
>  		 */
>  		devm_cxl_port_ras_setup(port);
> +
> +		devm_cxl_port_bi_setup(port);
>  	}
>  
>  	dport = devm_cxl_add_dport_by_dev(port, dport_dev);
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 802b143de83d..278b84b08c83 100644
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
