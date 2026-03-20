Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011009.outbound.protection.outlook.com [52.101.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4D03C344D
	for <linux-cxl@vger.kernel.org>; Fri, 20 Mar 2026 16:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774023609; cv=fail; b=ij/hyOftFPewFg6ojxJ9Anwkfp6ms3zm2TehFOel0rXMIGPDtwgzOZkCweSuhLszA34ONpC0QoshInoRL3bQyqYQdOm//x2c1oVm48RdDxspEC2DdnEgJYoNpYuFPf+ZRNWsOEl5n4o2tQFY+MjhyfgBTysDZEqRHIaybcsz94I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774023609; c=relaxed/simple;
	bh=DhT02W/MvSvI5FazT0d0sYP+4hd7j2SDQDAcWz45cHs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=WIe2dhGeExexrUwfmVUVjeoyFZh9Cb8XYiU7Cl6u2TpU4fZJV8XIN+cvV5nyyKRWou2/hJqxLLXpw2xH8kVO1bjH/Ib+58mBqxCYek2OGghw00hZ2XgNb3JM8QIZmE9qhAuwPZZ9A0Z/TdzveWAcCErmXMliPRnp+VoodP6i97M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o2z9UTEm; arc=fail smtp.client-ip=52.101.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o2z9UTEm"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VYdEz4x2oT3n7TbTZsypyLEL9fTSNH0HHTsWCtQVnI8mAb/7aqHZDJ1hmFe3G1kXOav20ezA7Jf/6QBeiOff0If7lXH1/AVVqHBXHD2p/bmcHMRzV2Yq0T5RQebI+IIr8MCJ+28EDOgrG6QT29ZDbctI8YNcP9DhDYQaYJTfxTGSw0ibr0e3Rdng1IhzMEh7eiedchYZLwHdbASz6vHEygMT14OpOIVwmxklB8Ae9DejI0FgdZ4JMjFzTAaTYzqPONkYAwQRwbX5KjrKsA5tt0bwhFl/LZiWqW7S2w3Ps0W9wbmaZf6/FuYN5mDUCjLQxxKLCtAmyPIFCnuWOteSRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TOl6v4QvPvNA/tn+zNpMsIrG3Y1OczwEXhFKQw0QQSg=;
 b=e1dzwsA4Rs35DrD6cMZrttb4EjCkWq2nV+atMd8W0Wh72IU4iiq0D0of9I49F+KT/rTs7zr0nhAYczRy+0Fp3kqNJzwAECFzKq9Mkot4y/wfdpmTLQMPzZIcD2TLv6mYwPQnU6caBoEJNwsk1v4hPOQ9/A+DNahn/KN8a/xVzB6/OqVTx8DPXIpY70GPuoFxftD2xbeqy/PXiz9JcSYuqx85ncjl9u9uaEDenJRlV0VXuGMVgfdbB1P8ToKLDMBTQAuUuKSEPL5Ky2dortxNwBdM66oEpxbY5amX4UQINbuSUUMoYmGMMPMoX+sywy5Rm0+wMexJzynfI4AQgvkvHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TOl6v4QvPvNA/tn+zNpMsIrG3Y1OczwEXhFKQw0QQSg=;
 b=o2z9UTEmaFPdxuMQm2wFsEfGW4qY96VqrdjYGBBYZJrTMXPgRpzsGGFV/rCEOmS4SCIvbHMYceYIXa0WXLGmhYrOrazb7ZGOnWsZGS0sOKDIi6/Sk6UAA8EL6aZs6wRnnRnm1PFhg4qRPX3AuUME8ttUnhKPUb0czrwXXjRPNAU=
Received: from CH5PR04CA0003.namprd04.prod.outlook.com (2603:10b6:610:1f4::12)
 by DM6PR12MB4187.namprd12.prod.outlook.com (2603:10b6:5:212::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.12; Fri, 20 Mar
 2026 16:20:01 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:1f4:cafe::22) by CH5PR04CA0003.outlook.office365.com
 (2603:10b6:610:1f4::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.24 via Frontend Transport; Fri,
 20 Mar 2026 16:20:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Fri, 20 Mar 2026 16:20:00 +0000
Received: from [10.31.194.50] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 20 Mar
 2026 11:19:59 -0500
Message-ID: <28537528-bf9e-451f-a2af-2348f4caa10e@amd.com>
Date: Fri, 20 Mar 2026 11:19:58 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 2/6] cxl: Add BI register probing and port initialization
To: Davidlohr Bueso <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<dan.j.williams@intel.com>
CC: <jonathan.cameron@huawei.com>, <alison.schofield@intel.com>,
	<ira.weiny@intel.com>, <gourry@gourry.net>, <dongjoo.seo1@samsung.com>,
	<anisa.su@samsung.com>, <linux-cxl@vger.kernel.org>
References: <20260315202741.3264295-1-dave@stgolabs.net>
 <20260315202741.3264295-3-dave@stgolabs.net>
Content-Language: en-US
In-Reply-To: <20260315202741.3264295-3-dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|DM6PR12MB4187:EE_
X-MS-Office365-Filtering-Correlation-Id: d8e621d6-908c-4877-0a97-08de869c8908
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|7053199007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Gh1BBez4hrWHiERyS+AI2S2LS1mvybU1wYui0ON/FDBEOAq03OZ/oyvGC6E1wA2W+LB2eC1oWTHe6Yf8tCF+Sw8m6uIKwZHOPth9qazV95cJMnFcLQZJYzEveC5kgrkpg4Vp5g21TX5qsiNkW5pKYMpjs9ot7nLoANMyeV/DEWD/eQkBIBkvhFL6ZmJEVAyIxMY52HDT75TJox1YS1Xq3v+RoxdCm5XMaj82wTIYNYeGN5HvLFcJCNjKRkM+RYp6ZDkZlBvbXfFFUUVNc+90FYljBWepSTGbnvSztpTk+xuqcfqG7++lLkfytIec6ckqvlyq1j66oHTzAd1KM/WTtnK/NFkznJHt2WlP967HxDhEu7DefKZZ9MGh9M5OwF6EOdC+Pjkd98I82wY7JaA3+BKvpJVwdqeZ9TIw883+GVT6ohsXjCABvcq1VrKp6280XTexwH+bfwBdwa97WqmzZuqLd+Q6W9soc+da4xfmDCxGxIOyvCeykrghSWBi1EqwOX9qO57SvGppAA3cE/ad2KPoR7/SlRaGHFy/LCt2495VD3d9jRt5UIZ30TgqgUKCKFCoSFqVvG37CE2lqH9T0KbZejVbYNd6+R9vq+zDjnPLcycrtY8XlqsjZfO8PeeFMdg0Rcoo9c/Pay9FCByMYVWj7oJ7k4nVZGSDIm4yln2UsRwU9ABApVKczQ7yUVy4dmj6BSXjyvbDzkrpqfr2L26CeXTyCSGJdyjBUWgaUm7oShZv963gn5A8QkSiZMtjYJC4v7DQ8tSQWwYwnGjtIg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(7053199007)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oJrHW6n4G2giMgIaTlFnWqXGsuQT5y7CQzR70a3sWCLe9arcf8GBA9jDNzrZSNb1Dj0rX4wOv4rDUBr+nMHf6EShLg0eoM59ADd9YdS36FD7kQxRBpR0QqfnWURJY3DSbDQO7QrGszb1OLfHeeEmbwxggP7Ldg9iPPNHzhhHWy6C0IPJurD9qJ4OAdxbpkjisVkZ2Eb4g9ifPUDtVZweo5WFNhEOiarylbPL5MH/tsKUF5C2IDbGYVw4vir974hshCHXNwVVoE5DV30y0nFQvKzO9PLbmHwUmNycKLrYm95O/CEoj5NljerJXCNr7soo+Y35gVMHTmS7ugvdmt23osVaOYGTq1nBpqcHWrgFPcPqs+Tv9N5LTjXXB2y2/n4vUURQLlc04GCNG9/AEAIAEzIrPHbc/1Ofb+f5m/gYFGYHycycItnUmbwz48GNwfRZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 16:20:00.4667
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8e621d6-908c-4877-0a97-08de869c8908
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4187

On 3/15/2026 3:27 PM, Davidlohr Bueso wrote:
> Add register probing for BI Route Table and BI Decoder capability
> structures in cxl_probe_component_regs(), and initialize BI registers
> during port probe for both switch ports and endpoint ports.
> 
> For switch ports, map BI Decoder registers on downstream ports and
> BI Route Table registers on upstream ports. For endpoint ports, map
> the BI Decoder registers directly into the port's register block.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/core/regs.c | 13 ++++++
>  drivers/cxl/port.c      | 88 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 101 insertions(+)
> 
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 93710cf4f0a6..82e6018fd4cf 100644
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
> +			rmap = &map->bi;
> +			break;
> +		case CXL_CM_CAP_CAP_ID_BI_DECODER:
> +			dev_dbg(dev, "found BI Decoder capability (0x%x)\n",
> +				offset);
> +			length = CXL_BI_DECODER_CAPABILITY_LENGTH;
> +			rmap = &map->bi;
> +			break;
>  		default:
>  			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
>  				offset);
> @@ -211,6 +223,7 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
>  	} mapinfo[] = {
>  		{ &map->component_map.hdm_decoder, &regs->hdm_decoder },
>  		{ &map->component_map.ras, &regs->ras },
> +		{ &map->component_map.bi, &regs->bi },
>  	};
>  	int i;
>  
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index ada51948d52f..0540f0681ffb 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -58,6 +58,90 @@ static int discover_region(struct device *dev, void *unused)
>  	return 0;
>  }
>  
> +static int cxl_dport_init_bi(struct cxl_dport *dport)
> +{
> +	struct cxl_register_map *map = &dport->reg_map;
> +	struct device *dev = dport->dport_dev;
> +
> +	if (dport->regs.bi)
> +		return 0;
> +
> +	if (!cxl_pci_flit_256(to_pci_dev(dev)))
> +		return 0;
> +
> +	if (!map->component_map.bi.valid) {
> +		dev_dbg(dev, "BI decoder registers not found\n");
> +		return 0;
> +	}
> +
> +	if (cxl_map_component_regs(map, &dport->regs.component,
> +				   BIT(CXL_CM_CAP_CAP_ID_BI_DECODER))) {
> +		dev_dbg(dev, "Failed to map BI decoder capability.\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static void cxl_uport_init_bi(struct cxl_port *port, struct device *host)
> +{
> +	struct cxl_register_map *map = &port->reg_map;
> +
> +	if (port->uport_regs.bi)
> +		return;
> +
> +	if (!map->component_map.bi.valid) {
> +		dev_dbg(host, "BI RT registers not found\n");
> +		return;
> +	}
> +
> +	map->host = host;
> +	if (cxl_map_component_regs(map, &port->uport_regs,
> +				   BIT(CXL_CM_CAP_CAP_ID_BI_RT)))
> +		dev_dbg(&port->dev, "Failed to map BI RT capability\n");

Same question as Jonathan here.

If you can use port->regs then you can combine the endpoint and switch port
init BI functions below and rework this accordingly.

> +}
> +
> +static void cxl_endpoint_init_bi(struct cxl_port *port)
> +{
> +	struct cxl_register_map *map = &port->reg_map;
> +
> +	cxl_dport_init_bi(port->parent_dport);
> +
> +	if (!map->component_map.bi.valid)
> +		return;
> +
> +	if (cxl_map_component_regs(map, &port->regs,
> +				   BIT(CXL_CM_CAP_CAP_ID_BI_DECODER)))
> +		dev_dbg(&port->dev, "Failed to map BI decoder capability\n");
> +}
> +
> +static void cxl_switch_port_init_bi(struct cxl_port *port)
> +{
> +	struct cxl_dport *parent_dport = port->parent_dport;
> +
> +	if (is_cxl_root(to_cxl_port(port->dev.parent)))

This will panic if to_cxl_port() returns NULL. I'd split it out and check to_cxl_port() != NULL first.
parent_port_is_cxl_root() has the same issue, so still applies there.

> +		return;
> +
> +	if (dev_is_pci(port->uport_dev) &&
> +	    !cxl_pci_flit_256(to_pci_dev(port->uport_dev)))

If you can use port->regs above, this check would become:

	if (!is_cxl_endpoint(port) && dev_is_pci(port->uport_dev) &&
	    !cxl_pci_flit_256(to_pci_dev(port->uport_dev))

> +		return;
> +
> +	if (parent_dport && dev_is_pci(parent_dport->dport_dev)) {
> +		struct pci_dev *pdev = to_pci_dev(parent_dport->dport_dev);
> +
> +		switch (pci_pcie_type(pdev)) {
> +		case PCI_EXP_TYPE_ROOT_PORT:
> +		case PCI_EXP_TYPE_DOWNSTREAM:
> +			cxl_dport_init_bi(parent_dport);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	cxl_uport_init_bi(port, &port->dev);
> +}
> +
>  static int cxl_switch_port_probe(struct cxl_port *port)
>  {
>  	/* Reset nr_dports for rebind of driver */
> @@ -66,6 +150,8 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>  	/* Cache the data early to ensure is_visible() works */
>  	read_cdat_data(port);
>  
> +	cxl_switch_port_init_bi(port);
> +
>  	return 0;
>  }
>  
> @@ -128,6 +214,8 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	read_cdat_data(port);
>  	cxl_endpoint_parse_cdat(port);
>  
> +	cxl_endpoint_init_bi(port);
> +
>  	get_device(&cxlmd->dev);
>  	rc = devm_add_action_or_reset(&port->dev, schedule_detach, cxlmd);
>  	if (rc)

