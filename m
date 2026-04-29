Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012044.outbound.protection.outlook.com [52.101.43.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A5F3ACA4B
	for <linux-cxl@vger.kernel.org>; Wed, 29 Apr 2026 21:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777497299; cv=fail; b=HW5dj1FFFQXh1wLgu/Qc10SMrG6sD7Zl4P5YiL3A+KWkg3WbNbEsXwRzEF+430fef/O8z/nu5Y3Rl4Nk+LeNqog7BdR3eKepZ2NZ72uGojiCWGwC8JHxbqqIMP+LOK009HfuGRAOm+9q7GC57Xp6uUlycUjlpdZ0BH2ANscxbuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777497299; c=relaxed/simple;
	bh=ecKdES7snjCGNhs459gxWiAksvtXFXJym0SNYeYQPx4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=cA/8VToKFpwX/AqkEcemDGXsyrVFZl1hiu+aKlJSZjXjW8i1Yyui9O8bxGX7/4KsFtQcrRs4XXjpcX+/rHdXI5vxadG5kG6SzA0X8ZEXLjbvCdGWBbc1TeUksds11nyoHlfMRfJP6B2mowksN3LgxrTWD1twpGDlLrLMLWKnGTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M58Xz2MG; arc=fail smtp.client-ip=52.101.43.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M58Xz2MG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZSf9dXJoEAG4XN6UbJPDQ75g40AlPvOuC4sgs/bdPT5JrPBzYKN5B2t/YmjhmicjBEBp29Ugrm2n6AfRzq/gpwmeINh+PbxR1ZsxqlesVkzDrYFWo/uOmwDyw0yZ3bNiq9SvQmTXAO1ZCslqxPHmW/k+JKK1ydjpadJjujVrjXZP24FNFIjl9QBifLtmqLvFP2fY0T/BGOe5KmqGxGIMEOCRovNEIvo7cWzhIPJ625/AkJ+M/+BcSRFaBprJj+uQw4b2na+uuOsWBK+2/rNE2eiR6Xh4pBI5dwitQTxgLensS+opmAS4hwRuYGB/P18Zi+Dpx10IrJ/Al/+mqf+Ylw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WcQxDAPqU1S7vhZ9UpZEAoW6LUAOXBJF/yTanibXSZ4=;
 b=PconklS6zgjukgFdnTooK4vuvpGbcNFvBI0iBqXmB2YwMwK4X9guFS63zUY4dZQ91pVFslvakR9Isx/847nNVktjM53yJV3cAnU2RjVeqd6v8r19CuwnJaP+CdPQcJLU2oGKjrv2VwSsksYBwY8k04C+RujxcbprfVgptVIgSRI6pIZJa/l0xqRK9iclwfS0pIkaNW9w13iWhgs8B/Ocp3OmL2rcZhR41aMO/YtLU7r0p3n+QBF0lDZeApnR/73KErgZePXriI/7SsAyA34+Sy0Kybbz1Daq/+1AXfkG6oAE18Tr/S6WRmxVixYnUC5VOMArpBB4IdWQFKR7zWgsCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WcQxDAPqU1S7vhZ9UpZEAoW6LUAOXBJF/yTanibXSZ4=;
 b=M58Xz2MG73wKJFBK7KvtYulNQWe17nge68fLb4npngZ5hBmRFQXOck1TAY3v57qLEs4WmtxR1JIEb6kmEerbkX7WCEg+KMq/F3OVXyUogsNK+BILyT0FkbkI+zw3ZJR/79C69LFn7ocVmFZlycLbAjPuG+afLK+yT5kwWALAHSU=
Received: from DS2PEPF00004568.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::50c) by CYYPR12MB8963.namprd12.prod.outlook.com
 (2603:10b6:930:c3::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Wed, 29 Apr
 2026 21:14:53 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:82c:400:0:1003:0:4) by DS2PEPF00004568.outlook.office365.com
 (2603:10b6:f:fc00::50c) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.2 via Frontend Transport; Wed,
 29 Apr 2026 21:14:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 21:14:52 +0000
Received: from [10.236.188.223] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Apr
 2026 16:14:51 -0500
Message-ID: <a8390b56-e5a9-4e06-b8f8-e66a8bd9e824@amd.com>
Date: Wed, 29 Apr 2026 16:14:51 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v26 6/8] cxl: attach region to an accelerator/type2 memdev
To: <alejandro.lucero-palau@amd.com>, <linux-cxl@vger.kernel.org>,
	<djbw@kernel.org>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
References: <20260423180528.17166-1-alejandro.lucero-palau@amd.com>
 <20260423180528.17166-7-alejandro.lucero-palau@amd.com>
Content-Language: en-US
In-Reply-To: <20260423180528.17166-7-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|CYYPR12MB8963:EE_
X-MS-Office365-Filtering-Correlation-Id: 7adab6ca-68a9-4641-9ae2-08dea6345acc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|30052699003|1800799024|376014|7136999003|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	L1TT2ayeNzNX+4+Py3mAeSQccoWnGRLseI6nlcCeefPkVFNvgtWplU8xjwJirfZCHVwScnIq2MNzdFj2etuHBrg+TLq/SlbSg6mwyKXhMUuqUXtHL5WxOGZnvaWfRbUL6gOYu4WNbNPiB85sMXX4vGMePox3BdcWDVq3DGLljwrJdgUvjPmjmxWCRNM7go1AY+xl+HDg6V8rTWnJz7xpCzIuY3DzW9AM/tZ0Hesf1UCsvBAiq30GmNHF5xC5JJK3l7BEqeMXWJqpXDSFhqe1lYx7HPMWErWcBpQe0NmQlHR/pBx3//YEW91RDPw5CTFv/jN1+NOBZTgPMRHK6E870880tN7AdoTaaTzl9JR4D9mzFWX3J+iudw0MLhs8osSuYpFxuyA8py8Gpttz1F4llyp/uIswmFffmHYR0yNB0hbLic3zfHdbLHHaSM9EQ/k1NhlIudFIwol3/9je//JRdhE1yNXoekabxyqrklVyiGP9+p7ce7T7jMQn4K8tYdUqRnByd596koc/Svm107sFGti1lZXmWMQYcuxEoTWxmN7c/7FAj++QlChDA68g0d3t1fwz6Jiw8VqIDM+ptjPHtXTdrTygKH20xbiPI2dQxlW6INNygSDTQDEuIip3uPE3WlPewknP6V3K0KWJf+wZn7v55Vo0VXi4Wgvh777vcfya/i3OTW6NaVg5NrXgE9ltivVDU2qYvYCSF3wpUC7QAK4e/Sn/NvAEZ93h0aojr56C8+JSC5nAOmYOyrpf7PSKGpP5iiZZ1uYxDugsyaoQRQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(30052699003)(1800799024)(376014)(7136999003)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vREWGmV9trAkUkLb3lmhE/2qF4Ek3XMYpb7RB7+NQt9rrhiB1t3jxxoNUxz8Qkox/as2xxRe2AUoBCgEbqXA4EWIZqFlftBH2JG5m7Xopt9G6LS+i2esVtfmLZeLdkxyCxMP16GW/+MELUXqLgqcvX84sOVFggA66iB7D4uSYsuBYyygA6Fn54D3iwOcPfP29c5z/Rlp9XDNiphfFHnr0nqnaWTx1/0TgkLPINqhEfmnxz68JkxBGc9T2/SRZ2wzHICi1aQMyOyg+eTkC51VZ1wJnHNzI8fA15b6QkI0wgi3xcwRZqSUQKZxExyi0iHvCpp/EzrwDnXXO2BBShkyi50NcFyLvPDoYTqqpwebmv1v4jxCO1DYPZExsjiORL3BYdOC8+CRPeHTWKILYomOvuU+jYSe8nPEh2XEowx1tA+16eqfnoJ+GTUhIGaXUMrN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 21:14:52.4450
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7adab6ca-68a9-4641-9ae2-08dea6345acc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8963

On 4/23/2026 1:05 PM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Support an accelerator driver to safely work with an autodiscovered
> region from a committed HDM decoder through:
> 
>         1) an accelerator driver cxl_attach_region struct with attach
>            and detach callbacks.
> 
>         2) a specific function, cxl_memdev_attach_region() keeping the
>            required locks for finding a region linked to the memdev
>            endpoint, and
> 
>         3) invoking attach callback while keeping the locking allowing to
>            work (ioremap and other internal stuff) with the related physical
>            range by the accelerator driver, and
> 
>         4) linking a detach callback to the endpoint device removal where
>            the accelerator driver can stop using the region range.
> 
> This covers the cases of a potential removal of cxl_acpi module or a
> accelerator memdev unbinding from cxl_mem driver through sysfs.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
> ---
>  drivers/cxl/core/region.c          | 118 ++++++++++++++++++++++++++++-
>  drivers/net/ethernet/sfc/efx_cxl.c |  37 +++++++++
>  drivers/net/ethernet/sfc/efx_cxl.h |   2 +
>  include/cxl/cxl.h                  |  17 +++++
>  4 files changed, 171 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e50dc716d4e8..68f5a1fd1b1c 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2711,9 +2711,16 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>  	if (rc)
>  		goto err;
>  
> -	rc = devm_add_action_or_reset(port->uport_dev, unregister_region, cxlr);
> -	if (rc)
> -		return ERR_PTR(rc);
> +	/*
> +	 * For accelerators/type2, region release linked to endpoint device.
> +	 * See handling of cxl_endpoint_region_autoremove() below by
> +	 * cxl_memdev_attach_region().
> +	 */
> +	if (type == CXL_DECODER_HOSTONLYMEM) {
> +		rc = devm_add_action_or_reset(port->uport_dev, unregister_region, cxlr);
> +		if (rc)
> +			return ERR_PTR(rc);
> +	}
>  
>  	dev_dbg(port->uport_dev, "%s: created %s\n",
>  		dev_name(&cxlrd->cxlsd.cxld.dev), dev_name(dev));
> @@ -4043,6 +4050,111 @@ static int cxl_region_can_probe(struct cxl_region *cxlr)
>  	return 0;
>  }
>  
> +static int first_mapped_decoder(struct device *dev, const void *data)
> +{
> +	struct cxl_endpoint_decoder *cxled;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	if (cxled->cxld.region)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +/*
> + * As this is running in endpoint port remove context it does not race cxl_root
> + * destruction since port topologies are always removed depth first.
> + */
> +static void cxl_endpoint_region_autoremove(void *_cxlr)
> +{
> +	unregister_region(_cxlr);
> +}
> +
> +/**
> + * cxl_memdev_attach_region - bind region to accelerator memdev
> + *
> + * @cxlmd: a pointer to cxl_memdev to use
> + * @attach: a pointer to region attach struct with callbacks for
> + * 	    safely working with a region range by the caller
> + *
> + * Returns 0 or error.
> + */
> +int cxl_memdev_attach_region(struct cxl_memdev *cxlmd,
> +			     struct cxl_attach_region *attach)
> +{
> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_region *cxlr;
> +	int rc;
> +
> +	/* hold endpoint lock to setup autoremove of the region */
> +	guard(device)(&endpoint->dev);
> +	if (!endpoint->dev.driver)
> +		return -ENXIO;
> +	guard(rwsem_read)(&cxl_rwsem.region);
> +	guard(rwsem_read)(&cxl_rwsem.dpa);
> +
> +	/*
> +	 * TODO auto-instantiate a region, for now assume this will find an
> +	 * auto-region
> +	 */
> +	struct device *dev __free(put_device) =
> +		device_find_child(&endpoint->dev, NULL, first_mapped_decoder);
> +
> +	if (!dev) {
> +		dev_dbg(cxlmd->cxlds->dev, "no region found for memdev %s\n",
> +			dev_name(&cxlmd->dev));
> +		return -ENXIO;
> +	}
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	cxlr = cxled->cxld.region;
> +
> +	if (cxlr->params.state < CXL_CONFIG_COMMIT) {
> +		dev_dbg(cxlmd->cxlds->dev,
> +			"region %s not committed for memdev %s\n",
> +			dev_name(&cxlr->dev), dev_name(&cxlmd->dev));
> +		return -ENXIO;
> +	}
> +
> +	if (cxlr->params.nr_targets > 1) {
> +		dev_dbg(cxlmd->cxlds->dev,
> +			"Only attach to local non-interleaved region\n");
> +		return -ENXIO;
> +	}
> +
> +	attach->region = (struct range) {
> +		.start = cxlr->params.res->start,
> +		.end = cxlr->params.res->end,
> +	};
> +
> +	/*
> +	 * With endpoint locked leave the caller to safely work with the region
> +	 * range.
> +	 */

This reads a bit weirdly, how about: "Let the caller do its region-specific setup"? I
don't think it's important to mention the endpoint being locked here.

> +	rc = attach->attach(attach->data);
> +	if (rc)
> +		return rc;
> +
> +	/* Only teardown regions that pass validation, ignore the rest */
> +	rc = devm_add_action_or_reset(&endpoint->dev,
> +				      cxl_endpoint_region_autoremove, cxlr);
> +	if (rc)
> +		return rc;
> +
> +	/* Link type2 driver callback for stopping use of the region range. */
> +	rc = devm_add_action_or_reset(&endpoint->dev,
> +				      attach->detach, attach->data);
> +	if (rc)
> +		return rc;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_memdev_attach_region, "CXL");
> +
>  static int cxl_region_probe(struct device *dev)
>  {
>  	struct cxl_region *cxlr = to_cxl_region(dev);
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 7d8a6c2133c8..9ca16b051d62 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -14,6 +14,36 @@
>  
>  #define EFX_CTPIO_BUFFER_SIZE	SZ_256M
>  
> +/* Called with cxl endpoint device locked for precluding potential related
> + * cxl region removal triggered from user space, allowing safely mapping of
> + * such cxl region by the sfc driver.
> + */
> +static int efx_cxl_map_region(void *data) {
> +	struct efx_probe_data *probe_data = data;
> +	struct efx_nic *efx = &probe_data->efx;
> +	struct pci_dev *pci_dev = efx->pci_dev;
> +	struct efx_cxl *cxl = probe_data->cxl;
> +	struct range *cxl_pio_range = &cxl->attach_region.region;
> +
> +	cxl->ctpio_cxl = ioremap(cxl_pio_range->start,
> +				 cxl_pio_range->end - cxl_pio_range->start + 1);
> +	if (!cxl->ctpio_cxl) {
> +		pci_err(pci_dev, "CXL ioremap region (%pra) failed\n",
> +				 cxl_pio_range);
> +		return -ENOMEM;
> +	}
> +	probe_data->cxl_pio_initialised = true;
> +	return 0;
> +}
> +
> +/* Called at driver exit or when user space triggers cxl region removal. */
> +static void efx_cxl_unmap_region(void *data) {
> +	struct efx_probe_data *probe_data = data;
> +
> +	probe_data->cxl_pio_initialised = false;
> +	iounmap(probe_data->cxl->ctpio_cxl);
> +}
> +
>  int efx_cxl_init(struct efx_probe_data *probe_data)
>  {
>  	struct efx_nic *efx = &probe_data->efx;
> @@ -81,6 +111,13 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>  		return PTR_ERR(cxl->cxlmd);
>  	}
>  
> +	probe_data->cxl->attach_region.attach = efx_cxl_map_region;
> +	probe_data->cxl->attach_region.detach = efx_cxl_unmap_region;
> +	probe_data->cxl->attach_region.data = probe_data;
> +
> +	cxl_memdev_attach_region(cxl->cxlmd,
> +				 &probe_data->cxl->attach_region);

I would think you want to check the return code here, no? I looked at the last patch
and don't think this will cause issues, but I would at least expect some debug output
here.
> +
>  	probe_data->cxl = cxl;
>  
>  	return 0;
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.h b/drivers/net/ethernet/sfc/efx_cxl.h
> index 04e46278464d..1c294cd1df56 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.h
> +++ b/drivers/net/ethernet/sfc/efx_cxl.h
> @@ -20,6 +20,8 @@ struct efx_probe_data;
>  struct efx_cxl {
>  	struct cxl_dev_state cxlds;
>  	struct cxl_memdev *cxlmd;
> +	struct cxl_attach_region attach_region;
> +	void __iomem *ctpio_cxl;
>  };
>  
>  int efx_cxl_init(struct efx_probe_data *probe_data);
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 10a9b8fa2f6b..22d9435b351f 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -7,6 +7,7 @@
>  
>  #include <linux/node.h>
>  #include <linux/ioport.h>
> +#include <linux/pci.h>
>  #include <cxl/mailbox.h>
>  
>  /**
> @@ -153,6 +154,20 @@ struct cxl_memdev_attach {
>  	int (*probe)(struct cxl_memdev *cxlmd);
>  };
>  
> +/**
> + * struct cxl_attach_region - accelerator region handling
> + * @attach: invoked at cxl_memdev_attach_region() with endpoint device locked.
> + * @detach: invoked at endpoint release.
> + * @data: pointer referencing accelerator data for attach and detach calls.
> + * @region: initialised with autodiscovered region values linked to memdev.
> + */
> +struct cxl_attach_region {
> +	int (*attach)(void *);
> +	void (*detach)(void *);
> +	void *data;
> +	struct range region;
> +};

I like your approach here, but have a problem with this. It seems like an attempt to circumvent the cxl_memdev_attach
struct above, which makes it borderline useless (as of now). Would you be opposed to folding it into cxl_memdev_attach
instead? I'm thinking doing something like:

/**
 * struct cxl_memdev_attach - CXL memdev driver and region attach handlers
 *
 * @mem_probe: Callback used during cxl_mem::probe for memdev specific setup
 * @region_attach: Device specific setup invoked during cxl_memdev_attach_region() with endpoint device locked
 * @region_detach: Device specific cleanup invoked at endpoint release
 * @region_data: Pointer passed to region_attach and region_detach calls
 * @region: Memory range covered by autodiscovered region linked to memdev
 */
struct cxl_memdev_attach {
	int (*mem_probe)(struct cxl_memdev *cxlmd);
	int (*region_attach)(void *data);
	int (*region_detach)(void *data);
	void *region_data;
	struct range region;
};

and then replace cxl_attach_region with cxl_memdev_attach accordingly. I think that's a 3-way win: You get
what you want to do, Dan's work isn't invalidated, and cxl_memdev_attach becomes a one-stop shop for all
CXL accelerator attach shenanigans.

> +
>  /**
>   * struct cxl_dev_state - The driver device state
>   *
> @@ -231,4 +246,6 @@ struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
>  int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
>  struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
>  				       const struct cxl_memdev_attach *attach);
> +struct cxl_region;
> +int cxl_memdev_attach_region(struct cxl_memdev *cxlmd, struct cxl_attach_region *attach);
>  #endif /* __CXL_CXL_H__ */

