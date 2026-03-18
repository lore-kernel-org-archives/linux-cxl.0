Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011009.outbound.protection.outlook.com [52.101.52.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F40B3D75CC
	for <linux-cxl@vger.kernel.org>; Wed, 18 Mar 2026 14:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773843168; cv=fail; b=mCZW8CWAWCmUmRJdDat5U6EKRkPlIUD9wnxjbN7sLB9bS1/kNXsQ67KELdBo55DkUiWi5J6OGRTEE37LxjuNerg43QA6bbiV0jPWbyLLvZwJ3Hy/ttG++bvlN6La2qQcskeJ64N74lbW76cavlEai+auc0zcn05MqiJJBuqspjk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773843168; c=relaxed/simple;
	bh=ScbtAiX5TF3cHlxIp7YPLNYmoe8mOUfIXP8XCQZEKAw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=TTwMq3uUxVgA18Bpemghz3BmYt2QVHkHaN64npBvdXhmpv9myrBqZozYYE3ZjvDArljq17xwE+56VQPbfQtYErigpvKESGqUDSU2F+R7p/Z73vDKmOnLOz/pXSvN1LTIVhzXQRLHV5PVcA3C416qJiWFPDKUZ8F3xshv8agfNXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zCmTS4Nv; arc=fail smtp.client-ip=52.101.52.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zCmTS4Nv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y5jYckvzKAe6n7MJ8bVEcs0o1dc1ikmMIm9GFZV93a6BlHZe7MOzFEADPScprgp71Q+KkoRPInc5L2jWDCxmGVd1aZlFb1Y5vexhvDZ1C9PgkDiSTEFmb0Knu1y0JQRNYpF/6bTZr8nxnfdyX2UscFoFmn6moNgvWZzgFCzrcPsY8veZnnzhh0sUCUcgeumR4CeS6R5H0uaax1hgA+YAkSBtp9i6zAEitdthyoABP3zGoXwKwJlXoBeBcPS9jG+942jyxOsuYWxbrLg84WezeqsrUjsK1ytVk65yiVCeTqy9d648hZ9iMleJ/SNj4qQIdgRGHwfPWjSoDUVNtsz1jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cKBEd7tbMRz6BnqiMHNsnGAQVv6+iZBIS2DcXTU5Wic=;
 b=JKYsSsTyns6zuLLHv4JivALZgQAJGeNFtfakIw82MUqyefux5z8kS2ZJdTyHljLVs1fOo42VARmOHsoDp9lSUJA68IX8CSZHe3gyuK3qAX+VvHdllcXLhVP6T0HUs+xuoP9jRX5E2AGpkRMkJUWCsC4jYrXARN80+Jb5kDlyQyc+wvqmV/+MH1e742II758mhbnDxrZTXZyL41ovQDC3Jh7mmwMcwVRRzSlzPVgytUopwgrWGXN8m9WfM2uq1mlMWgvberRqWFNrFXsOKzGNlo8Fsj7oISvEh3hN47o4oK/2k1nbTDxcjeO+VIe78JBMTzKngekF1Db/AScsQ4NWhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cKBEd7tbMRz6BnqiMHNsnGAQVv6+iZBIS2DcXTU5Wic=;
 b=zCmTS4NvrOApX2VrLCAxKr4pUYKmG798P8A+swSq1f3zA9UqHLAlHDDxlrLHVBsF8+8LpoFLH7krpfIxymUTo6SLMDujK/tgPv2szXAkoX2IXcWlAHWn96VBgD/9Wrek9cjgeaJpnlzqnWBTo0SpGKqbIlkVPvEkn+xw7CPeKXM=
Received: from BL0PR05CA0001.namprd05.prod.outlook.com (2603:10b6:208:91::11)
 by CY5PR12MB6036.namprd12.prod.outlook.com (2603:10b6:930:2c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Wed, 18 Mar
 2026 14:12:42 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:91:cafe::52) by BL0PR05CA0001.outlook.office365.com
 (2603:10b6:208:91::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.19 via Frontend Transport; Wed,
 18 Mar 2026 14:12:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Wed, 18 Mar 2026 14:12:42 +0000
Received: from [10.31.193.168] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 09:12:40 -0500
Message-ID: <93651c0f-230f-4dfe-a6a7-5c4b23a178b8@amd.com>
Date: Wed, 18 Mar 2026 09:12:38 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl: Add endpoint decoder flags clear when PCI reset
 happens
To: Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
CC: <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
	<ira.weiny@intel.com>, <dave@stgolabs.net>, <jonathan.cameron@huawei.com>,
	<alison.schofield@intel.com>
References: <20260317234926.3545119-1-dave.jiang@intel.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20260317234926.3545119-1-dave.jiang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|CY5PR12MB6036:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b9f0ba3-7be8-4094-b4d5-08de84f86b5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|7053199007|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	CK+CrjTOMQoJOYVXM3lkhMN6Q/kaOlpwWOC7XFqsfedpF/kSOyccQOspMg/tXxpBwgw4216g7ZvrMaQGqslZYUPgsAMmKruLhcxh2ECkO/fb0FXupxoAApzdDl8NEGAC4Auzpws0Ztk6qcT41wyVpibROlnZwilytU7wkovbOTNM4uSQuu+Eh2v++soVY78+W4bwkSKIfzSJWk44qNg4wfzVBG+7sE/Ka54FFn/8xa4Ge6WRs9GRbT7cgROfXpb69fcuGxIwRfX0RSrfpOJN4KzJP0OMTGy8bwpMVHY76riC2f97ur4zwkTO8p45Mjeit7dHyNV1ISrX28xvlvKmLED8tueqeitiuI9FWsJbUEDhUtLNQ9goX8pHa5o7ikkc2akZfvM1s5wHt6+SAaK2zQ/xQgw1ooNq8GuCNnHvX5s9Sokw6PW6KAEVdQwp/ecB/+nqsa8wRqlO3Oeuapbwu/qBnCOdtRFiF4XpUEk/zLDYMv4dFUN3OnpiLuNW0PnqPbaDXuyrXS0ZxXGPwOuEGoJAX+17hTjW3Aa5P1xoYhOJbFbX3IgNFGqKknHxC+8ZYYVY74bVHEV+/EVUK/V+oelVr+VV5zT1tYi3Lkhmou/1Sw5VaWvf75ZOBape3ElbEi46iYl7EHO6T7lTJVwPoOwmlOkM6mHwIwwtx71qoU+b3+3ZpPxnaQUsWzFrzBWq4AvQwuoN8Xv9nPrmia93tHuAb5EoQpyl1m9yIL1BAF4z7NtikYB38OKnkhc0LOKw3K/dj3exv87pnsBpo6PR4w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(7053199007)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cCoB/qnQKmqjotg0U1QGghrD/rICzoJMiNtPvlJfGKfS4DvWk2ODgTh2lQiDdPglgVlc154K6UMnLDS/Pe5Oh37o9oD5nbVTB0ONGhnQRMI7e1b8i7fPMOiVE77MDK+GezKnFagVmkz/lRefoXI+KPkkPBZs8Kh0+zB1th+G3tY/+zQwICfe6Efb7T7a9j5KR3zsFY1zfnA314uP+FeHWfjidcOfhlZ7dUjzbkpfmtWkw+ib/ecAQws9U/KsMT3KZ6J8LC2OqYoNEDysSn+JugChpSt7oqVA7Fzzy1NdZ8qAtxCat3tri2M2FncRHD8VPGRVzIE22neBXgjNTrCE8XdiVWnNFru5Sh3AWOpzscwQBxhKNSk++ZcDNsIXCktfxpBecC0vQw7tQiVqomxPOKMSGemZQYsKrPXPbmOqvWY9s5yXp1hUL/VZnP3xDcZG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 14:12:42.0728
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b9f0ba3-7be8-4094-b4d5-08de84f86b5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6036

On 3/17/2026 6:49 PM, Dave Jiang wrote:
> When a PCI reset happens, the lock and enable flags of the CXL device
> should be cleared to avoid stale state flags after reset. Add flag
> clearing during cxl_reset_done() to clear the relevant endpoint
> decoder flags for all decoders of the endpoint device.
> 
> Reported-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v2:
> - Rename CLEAR_MASK to RESET_MASK (Alison)
> - Make the helper function take a mask argument to specify which flags
>   to clear (Alison)
> ---
>  drivers/cxl/cxl.h |  1 +
>  drivers/cxl/pci.c | 19 +++++++++++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 9b947286eb9b..d09c84bcc015 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -333,6 +333,7 @@ int cxl_dport_map_rcd_linkcap(struct pci_dev *pdev, struct cxl_dport *dport);
>  #define CXL_DECODER_F_LOCK  BIT(4)
>  #define CXL_DECODER_F_ENABLE    BIT(5)
>  #define CXL_DECODER_F_NORMALIZED_ADDRESSING BIT(6)
> +#define CXL_DECODER_F_RESET_MASK (CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK)
>  
>  enum cxl_decoder_type {
>  	CXL_DECODER_DEVMEM = 2,
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index fbb300a01830..a0bba4b4db92 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1030,6 +1030,20 @@ static void cxl_error_resume(struct pci_dev *pdev)
>  		 dev->driver ? "successful" : "failed");
>  }
>  
> +static int cxl_decoder_clear_flags(struct device *dev, void *data)
> +{
> +	struct cxl_endpoint_decoder *cxled;
> +	unsigned long *flags = data;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;

I would either a) rename this function to cxl_endpoint_decoder_clear_flags() or b) change
it to use struct cxl_decoder devices directly. The generality of option b is nicer imo,
but you'd have to throw in an extra check for switch decoders (or add a is_cxl_decoder() helper).

With either of those:
Reviewed-by: Ben Cheatham <benjamin.cheatham@amd.com>

Thanks,
Ben
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	cxled->cxld.flags &= ~(*flags);
> +
> +	return 0;
> +}
> +
>  static void cxl_reset_done(struct pci_dev *pdev)
>  {
>  	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> @@ -1045,6 +1059,11 @@ static void cxl_reset_done(struct pci_dev *pdev)
>  	guard(device)(&cxlmd->dev);
>  	if (cxlmd->endpoint &&
>  	    cxl_endpoint_decoder_reset_detected(cxlmd->endpoint)) {
> +		unsigned long flags = CXL_DECODER_F_RESET_MASK;
> +
> +		device_for_each_child(&cxlmd->endpoint->dev, &flags,
> +				      cxl_decoder_clear_flags);
> +
>  		dev_crit(dev, "SBR happened without memory regions removal.\n");
>  		dev_crit(dev, "System may be unstable if regions hosted system memory.\n");
>  		add_taint(TAINT_USER, LOCKDEP_STILL_OK);
> 
> base-commit: f338e77383789c0cae23ca3d48adcc5e9e137e3c

