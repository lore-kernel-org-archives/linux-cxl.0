Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013012.outbound.protection.outlook.com [40.93.201.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5727728A3F8
	for <linux-cxl@vger.kernel.org>; Fri, 20 Mar 2026 16:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774023644; cv=fail; b=UjbO82AKSa9XcLmqnwVOFEMZjKa3lavM7AJV3XthluTKzu95Nl7Hq/yq1zYU5iVdbjl5N6EaoZHkRdazIaTMXbj2JgZMZGHFOiJaPZ7NxGcG08jM9UiKhCaUzJW7ANGB8355D7Y7Y3c1eXOi2SWaMhFy/AMapo6pyJxx+qLuqFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774023644; c=relaxed/simple;
	bh=7udd60SaShv5VrHK4x5XO3JcFWzd2yBJUxHnz60gK80=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=KDee4xyVYf+19gEkzMo10eGBfP1Xa/I991TQ3FNaWA1WGRTQ2mQTHFur+BurUWgOYQT/cO6+Rii8Lslt8KCle9/HhO1PoPz9XLkO39guWazow4Ha4B8JohOPRv75DAZIzcuIqWHyzqe+M412W1HqNpsXxuE5Sxhh0tjP8KIDM84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jVVcrVfF; arc=fail smtp.client-ip=40.93.201.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jVVcrVfF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mV68BnG9zic86aBL4M7n9P8IWA6KhEK65ZAFFmPxi4sa3rTwuqfjyxDGakeJBaq0eT6ApilwrrECO+O9MnxJgqnekZGAXA1SVOH6angDMDR65isxHXs2KxsYIhsZ5kh5aG5tqMZR/ErtDfQtcXOoi79BcI3J4zNs4hId+S+iNegTPmWApeZXbXD4q1hLVylKuyTfnXuF48JTfIYza0LDkH9MbKu70z/WnK25T0wLCvHZ2lUDqwMFjN+BiVA94S/w53zRFczQeiDJptmrXpzMhPRdSXdAbUWKU++Pl4fsJtemtai5VLam6TdlihH9Ynm+yFQIV5juBXazOfhKtbWvQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vse5I/e24dIZqrgahrXxv1zXDYoFZ+byS1IDEdwJrOA=;
 b=fwXLKMI7hHOxYUrRp8UsYfM7vceqFPoxZJqPJeEuOooe2+mrAbLr5ejsXt0r7SMY+jsw0biJGE7KMnL4HTA+vN2BhJKI9g6kKVjVbLmcdUBvuq6Aogz8kcLI3FIL3hAArk85cROuw2ueJMTZbj3CjmxDpCP1Q9eEcE784UyR6lFjElRcjfrF52dDXc67uUrCbI4PyhFOrlwAWxQBZydmufTcM+lrnYzGi39kMavN9mcG5TH8uqpI81qLCDBrleyJ1ISZ4ckfLTj+U4VrxalZRZxzcj1q40K7tAQw9qC/4FYGxldFy2dJ7ZbNBICaDg3a//x/KhJ/ZhxQJ739PtBxxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vse5I/e24dIZqrgahrXxv1zXDYoFZ+byS1IDEdwJrOA=;
 b=jVVcrVfFN5kdXCMFsFYDQGxmWXZCa6gicpje4K97tOAjtnoqz5pvhjd9MhO5gzwULLJkulRF2B0g+UR/U25YiJkwrrwGNUIvPTGzpkfc6nI45H+Cf9zDvjA9ef+rJP+UevfRu573c/I5pnn/bsyCjIjFzwNF6/xKqiD/ToyvH5k=
Received: from CH0PR03CA0031.namprd03.prod.outlook.com (2603:10b6:610:b3::6)
 by DS4PR12MB9634.namprd12.prod.outlook.com (2603:10b6:8:280::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Fri, 20 Mar
 2026 16:20:38 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::15) by CH0PR03CA0031.outlook.office365.com
 (2603:10b6:610:b3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.23 via Frontend Transport; Fri,
 20 Mar 2026 16:20:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 16:20:38 +0000
Received: from [10.31.194.50] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Mar
 2026 11:20:37 -0500
Message-ID: <db39fa66-3b40-4291-8538-13674a3a438f@amd.com>
Date: Fri, 20 Mar 2026 11:20:31 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 5/6] cxl/hdm: Add BI coherency support for endpoint
 decoders
To: Davidlohr Bueso <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<dan.j.williams@intel.com>
CC: <jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<ira.weiny@intel.com>, <gourry@gourry.net>, <dongjoo.seo1@samsung.com>,
	<anisa.su@samsung.com>, <linux-cxl@vger.kernel.org>
References: <20260315202741.3264295-1-dave@stgolabs.net>
 <20260315202741.3264295-6-dave@stgolabs.net>
Content-Language: en-US
In-Reply-To: <20260315202741.3264295-6-dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|DS4PR12MB9634:EE_
X-MS-Office365-Filtering-Correlation-Id: a62d9edd-0cba-41cf-5ef5-08de869c9fcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700016|22082099003|18002099003|7053199007|56012099003;
X-Microsoft-Antispam-Message-Info:
	v0boOspMGGnYBQgxEawzVTz+omcLJU8IMLwvhqALV817p7AP10z9oUoILfypACEY9v6qgYHJ6Iaxdp0Pkb+xJUT8R/RBJb0QJ6O0Y5CRsF9rQpJ5Fi+OnSRio2U44Aus66FKhjYkmqE5tgYxxD/6i+GS4zpAMonhoW5dY7ppQ94bQSRWWwJom9d2p6R+b1m4h7xkA5F9gmXF4MAQ2ewumyCATd2wpAzphj3zEojP7oFm4ZwBm3SlnYS7xMasCM0UNCVuY1yY0SQc4OPbuA2QTq99QWcyKB/BVwSPRWme3wOpUUcypFuWNWfSnEoJJ+e1c89mYnt6uDrVig49POunbQBWDKRPg82pLAMr/JCspCX7N69G04GzXN9zm2RoC6HgWVwxEty4vAyMrXw7qnqliqZKSWJ4AF5rHg/vfEWpmsMe0eFV+E7WVcXnZQbZCndgtVWBJOA50GaUKGTmSefsz9Qq9EuQtXTZJ4aiSGD48vwHJBAmZvZrqOyAZ+8PFuDglTmj2g1ohhGg26Bc7jWGKXyzlCUtyD/DwCX4dJGlwfATcAG/lB6D9tTx4asUB3hKsuzS5KGs2SJeKGJp/GRDFEKLIpIJV9x/Do3fHjcwBPJNLFhN7fd/wzp9xTZozybifHvf2B9k+W2YLmnihs70lkyFMDjL1GVTd007wMSvH+8eGyOno3rljlJ+ZOnRSqnTrnGq0EXhkKfAtbAOtPGXoWGOGGrUlYn9mjNP21uRTqEoYtoS+Se6qnoyUKVRI3nP3/1JvnhF1E9BsMDPayGjhQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700016)(22082099003)(18002099003)(7053199007)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sxDyu1YVH2yUwpEitPBxDJQj94hVZvIXhjaUcLjlVvLYPo06GPcCCCi50k+uf9+WooCs/fS6OamqvA2mB4weE8eri7rpjYte0y9XtpOX/OLquFLZfHI0o/ubB5eFYP/Ckn22TfO2RUXkgSW53+vQTqrVhWlARwzXgCFrlPdWnKnnopJs3CFSmsSDoZqZK14oO8PJ2wBHiRASXfW2dM5cl1fn9jPZEkMrzWbAHeJPp5EmVFTlYAyv25ftKbDL3MMOxE5C1CUnZyyV1nTR3ocSv4T4rOjYhPrfCLg6lGxuB/Ett0KKfUljhAhpKqb7PrpdfkRrRkELtLHXOZQZta8iZahQ96f1U2+f+wy8qZxZAL2lly5Sd7X/t1nc4oHipK2wZpFed6mB/fP4DVlRGcZ+u8MAlw+lj4LUAdpVIEvdiK2OFamJbQe0paAOq+9Kud4g
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 16:20:38.6645
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a62d9edd-0cba-41cf-5ef5-08de869c9fcc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9634

On 3/15/2026 3:27 PM, Davidlohr Bueso wrote:
> Add cxl_dpa_set_coherence() to allow setting the coherency type of an
> endpoint decoder, with validation against hardware capabilities. Other
> than the HDM decoder supported coherency models, the main dependency
> to create these regions is for the device state to be BI-ready (cxlds->bi),
> for which already committed HDM decoders with the BI bit set detected during
> enumeration is currently not supported because endpoint and port enumerations
> are independent. Program the BI bit in the HDM decoder control register at
> commit time.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/core/core.h |  2 ++
>  drivers/cxl/core/hdm.c  | 60 +++++++++++++++++++++++++++++++++++++----
>  2 files changed, 57 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 19494a8615d3..da4c094b6702 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -97,6 +97,8 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>  struct dentry *cxl_debugfs_create_dir(const char *dir);
>  int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
>  		     enum cxl_partition_mode mode);
> +int cxl_dpa_set_coherence(struct cxl_endpoint_decoder *cxled,
> +			  enum cxl_decoder_type type);
>  int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size);
>  int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
>  resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled);
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index b2db5967f5c0..6a6071b1f1dd 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -87,6 +87,8 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
>  		cxlhdm->iw_cap_mask |= BIT(3) | BIT(6) | BIT(12);
>  	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_16_WAY, hdm_cap))
>  		cxlhdm->iw_cap_mask |= BIT(16);
> +	cxlhdm->supported_coherency =
> +		FIELD_GET(CXL_HDM_DECODER_SUPPORTED_COHERENCY_MASK, hdm_cap);
>  }
>  
>  static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
> @@ -603,6 +605,34 @@ int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
>  	return 0;
>  }
>  
> +int cxl_dpa_set_coherence(struct cxl_endpoint_decoder *cxled,
> +			  enum cxl_decoder_type type)
> +{
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_port *port = to_cxl_port(cxled->cxld.dev.parent);
> +	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
> +
> +	guard(rwsem_write)(&cxl_rwsem.dpa);
> +	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE)
> +		return -EBUSY;
> +
> +	if (!cxlds->bi && type == CXL_DECODER_DEVMEM)
> +		return -EINVAL;
> +
> +	/* Device coherent only cannot be set to host-only */
> +	if (type == CXL_DECODER_HOSTONLYMEM &&
> +	    cxlhdm->supported_coherency == CXL_HDM_DECODER_COHERENCY_DEV)
> +		return -EINVAL;
> +	/* Host-only coherent cannot be set to device coherent */
> +	if (type == CXL_DECODER_DEVMEM &&
> +	    cxlhdm->supported_coherency == CXL_HDM_DECODER_COHERENCY_HOST)
> +		return -EINVAL;
> +
> +	cxled->cxld.target_type = type;
> +	return 0;
> +}
> +
>  static int __cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, u64 size)
>  {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> @@ -713,6 +743,9 @@ static void cxld_set_type(struct cxl_decoder *cxld, u32 *ctrl)
>  	u32p_replace_bits(ctrl,
>  			  !!(cxld->target_type == CXL_DECODER_HOSTONLYMEM),
>  			  CXL_HDM_DECODER0_CTRL_HOSTONLY);
> +	u32p_replace_bits(ctrl,
> +			  !!(cxld->target_type == CXL_DECODER_DEVMEM),
> +			  CXL_HDM_DECODER0_CTRL_BI);
>  }
>  
>  static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
> @@ -1030,6 +1063,14 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  		else
>  			cxld->target_type = CXL_DECODER_DEVMEM;
>  
> +		/*
> +		 * Autocommit BI-enabled decoders is not supported.
> +		 * At this point ->bi is not yet setup, so there
> +		 * are no guarantees that the platform supports BI.
> +		 */
> +		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_BI, ctrl))
> +			return -ENXIO;

->bi here is ambiguous, I think you mean the endpoint device isn't configured yet. If so,
I'd spell it out.

Also, why don't we leave it enabled and then disable it if the device doesn't support it
as part of cxl_mem probe? It adds some unnecessary work in when it's disabled, but
allows for more configurations.

> +
>  		guard(rwsem_write)(&cxl_rwsem.region);
>  		if (cxld->id != cxl_num_decoders_committed(port)) {
>  			dev_warn(&port->dev,
> @@ -1049,16 +1090,24 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  		if (cxled) {
>  			struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  			struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +			struct cxl_port *ep_port = to_cxl_port(cxld->dev.parent);
> +			struct cxl_hdm *cxlhdm = dev_get_drvdata(&ep_port->dev);
>  
>  			/*
> -			 * Default by devtype until a device arrives that needs
> -			 * more precision.
> +			 * For type3 HDM-DB devices, users can later change the
> +			 * target_type, if supported by the HDM decoder.
> +			 *
> +			 * Devices that support both coherency modes default
> +			 * to host-only.
>  			 */
> -			if (cxlds->type == CXL_DEVTYPE_CLASSMEM)
> -				cxld->target_type = CXL_DECODER_HOSTONLYMEM;
> -			else
> +			if (cxlds->type == CXL_DEVTYPE_CLASSMEM) {
> +				if (cxlhdm->supported_coherency == CXL_HDM_DECODER_COHERENCY_DEV)
> +					cxld->target_type = CXL_DECODER_DEVMEM;
> +				else
> +					cxld->target_type = CXL_DECODER_HOSTONLYMEM;
> +			} else {
>  				cxld->target_type = CXL_DECODER_DEVMEM;
> +			}

Could refactor to:

	if (cxlds->type == CXL_DEVTYPE_CLASSMEM && !FIELD_GET(cxlhdm->supported_coherency, CXL_HDM_DECODER_COHERENCY_DEV))
		cxld->target_type = CXL_DECODER_HOSTONLYMEM;
	else
		cxld->target_type = CXL_DECODER_DEVMEM;

The if statement is a bit long, but you could add a bool above to hold the second part, i.e.:
	bool dev_coherent = FIELD_GET(...);

>  		} else {
>  			/* To be overridden by region type at commit time */
>  			cxld->target_type = CXL_DECODER_HOSTONLYMEM;
> --
> 2.39.5
> 

