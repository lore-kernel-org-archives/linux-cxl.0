Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011039.outbound.protection.outlook.com [52.101.57.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693C3313E29
	for <linux-cxl@vger.kernel.org>; Mon,  8 Jun 2026 21:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780953036; cv=fail; b=dQ1eG1OWoB+ozK6IkuK+8Xn1nSsimiJk/cMJcYEcuhw3l4TlCmBkZ/jmwHhmIjvbrrpNd/4y6jl/457OvyVNJgzAf4jadwp8XV0nwYyi1f9vlGd0V/YRwHWNk9M8EpAdwR4ZU5IDFHYpDXUEITc7Z/CwU0hTiuV+DKf2v3hJXFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780953036; c=relaxed/simple;
	bh=qUl3UXmBkr1bIqa6e2KY6RkFkD7OWp390NV892525E0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=hH4v0eHcsLjbIDl0Vr8wMY0BqjsFFUToQ8BjZp5i/iI+QIArKTDZHEN3zBI/ZSrU/VfmK42FiaVEHcRSHW1uJ4cDvEeTtKzNIAHJUgqicgiavOaIMVu+rRA8kzutZe56m9BFyw4Y+Z2Xx+WGy1xqM9c36Jq08QyrUiMGeJmrHdU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mX1Sb23G; arc=fail smtp.client-ip=52.101.57.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mX1Sb23G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sLWjd6ci4GklbkvANeKenBS0jOD4U1DGlILEJ6PbNdBWgUS5HC760eJgJuF8V9QhQzOm/+b6WrJC4TVxoRX7O96TKvFHK/bhdvg+B8jN0ufNAzRdTXVFTfvqCTZphvmlbfGMO6HeVAKl2IlVtB3SDYuWBEhlov9ablEFF3+qPEGuQQ8txv/vr7Liwx2h68Kxba1pEq30Ghb5UfWeh4MtCdIXZ2NM7QZMpkVm5iVzkgciTsBgq6AQQryCP/mIBG8mLrvDdSb9UGEpoGYMFuRCVhMiLbjfV305vkL+t+S25wL45amJ6Kfv2RjonSSrv8j9KN2zobnAayPjqG0KSYvTfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Clo0E5kkY7eILj4aeqCZHfW6CdpDs3o3N/fSJjKfXyE=;
 b=UHdJFrKaiI+oPvQMo0D+ZUzQc0g3skP9fiMbF1pqGSazAhYCe5jFLLJn9PghRnh1Nq86BL/oHhK8923uWSIS7OzcAXU9She1r1gX84kR/xR8xMKr4ZzYIu5HkQDCO2fD8ERHP+d4GvcGmXzNWcNckO+LGadXM7xCY6sawuXRQ29JXsdCUd2VpN4QyR+52ao2Ti062VQ+/I1P+hkcW5k+lkxtb8qqq2r/60LQL4wBbYl9cB4BTnlc/s/PGvMRV0kt+TOlKSrRsC8sJiZa2XgDtZHae2k8JQcxZJeuBE7id6mCvRMuem2kVDKVHejkpQp7SPFMFvPk1+KWo1KLeoNBRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Clo0E5kkY7eILj4aeqCZHfW6CdpDs3o3N/fSJjKfXyE=;
 b=mX1Sb23GCe6Xl0+Xh6ctiFiYZm8SKxf1NVY3ue5LCgEDwFyav8035z5hUI4RyDpORwbA0J3Oy6m1KUBdUElJ8/Rpdyp3+j1xGzW567MANbQVmPtIZFjvcvQGSCa8L4hzOA/lZ2VT4zrFboWL0YFeuHKFxjHGsd9FvXTQh0f9jz8=
Received: from BY5PR03CA0010.namprd03.prod.outlook.com (2603:10b6:a03:1e0::20)
 by DS0PR12MB8070.namprd12.prod.outlook.com (2603:10b6:8:dc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 21:10:25 +0000
Received: from CO1PEPF00012E65.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::5e) by BY5PR03CA0010.outlook.office365.com
 (2603:10b6:a03:1e0::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.11 via Frontend Transport; Mon, 8
 Jun 2026 21:10:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E65.mail.protection.outlook.com (10.167.249.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 21:10:25 +0000
Received: from [172.31.129.70] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 16:10:23 -0500
Message-ID: <d430e2d5-3e16-4de1-a1a7-2ba6bb2acc4c@amd.com>
Date: Mon, 8 Jun 2026 16:10:22 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH 1/5] cxl: Add BI register probing and port initialization
To: Davidlohr Bueso <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<djbw@kernel.org>
CC: <jic23@kernel.org>, <alucerop@amd.com>, <alison.schofield@intel.com>,
	<gourry@gourry.net>, <dongjoo.seo1@samsung.com>, <linux-cxl@vger.kernel.org>
References: <20260605003329.2584012-1-dave@stgolabs.net>
 <20260605003329.2584012-2-dave@stgolabs.net>
Content-Language: en-US
In-Reply-To: <20260605003329.2584012-2-dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E65:EE_|DS0PR12MB8070:EE_
X-MS-Office365-Filtering-Correlation-Id: 528f66e3-4db9-4a7b-897a-08dec5a25bf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|11063799006|4143699003|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	vfTidYXdiwhGQMiAnKUt/4Ru3zfd5VjxTjUh7EJKATqVlqCG54ycpRbpZWfEPAxl2J8YY1oADcvROEarFcaTx/4SPvKnfSb3BibwUkbHoP7jxPSuNYYXUwrRfgJwST+ZzNqi7qVvrUFTzQ1XbOyVsHgEzW2W3585N83o34EdUQZ/E2/QREve9Xf0ET3so413nFzV4XGRJKYnVeyK28XuMKUEGqovIDvD12K8qgWObfWUyB2OkYHaDpUjFxbicmk/1/Xn6DmISADuV/JoB+MLLAUXPoLzFk5mXKc0jPxHNvXrFbqSZqRJPYbxGQkF5z4QQn4uCFI6VjS/kaZXO+lIjFodOUc3OE2GsyjYXGcceN/4lo00McjabfUx1tKyFaoz60fdojjbu1EgCMY45Sx4A0xk8CHLtSrg435i/aoPBjFuMYwuJyq+s1szATen25nkLtPEUqR/wFB7UW/RUDNwRA696L1cqsh86ztiJSys81IupX2X6FtuB3JEr26+ED7ORdpu0LU6gCgL4prbdk1MuADE5/CY91npFij/ui7Ed8x3mpClA6z59m9lIavph4+o1wpDcopsDJI2SMTXpKVT+GrETXZU/4kHHVzNl7HANvsdHLvZizxzvlA3Dz32crxoArulg9BVL7g2Ne0LUWPouKixT/pyp1gRk4doSY9gUnaJkMX9rqaLISgay+ay7UrNtMgoVMJUGX+kcsg2doOfVj9K9bl+6zzxm0QyS43E5Wk=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vn5LNFuq5syr8u4ziOy+LyMn++VhPh+05sLhWVXKeASYunI+z3yz6kggjz/Lq6UGlXxiEE2ZEM2WtQb+8uhGiCu5kTGOwcr50xb9jAnGlm0HdpEC5BqFPrQQR9sE1DiqjuYJy1dqaFHnPBV+tEUZWE+lA4GxnPdvKyUwiWKzEqHFvG1P9kuDlo5M2ZdQsxcOYmkzlhdwDb7lS899YS+jYu8gvxCqSyZJBYXFKPCrCDsFNQAGR0Ms3GdaFaxjNRUU/shVz9UnA5a9dgbwNUvCW91eSZJB8604JRvIrOKsmKShd1TvHweO+KNliEpCIwBV0DttxfmTxuV2vu37b410/lNmwF1MC7dnvx7R64pdTU6b2e4V23f182bQi98l/fqWwsyrQvqbMVcTepZRBvffcz3l0SO+gHqQeOJr2Bd/KESOrjSDT2XUk9Qy9V4tpw9/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 21:10:25.0217
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 528f66e3-4db9-4a7b-897a-08dec5a25bf8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E65.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8070

On 6/4/2026 7:33 PM, Davidlohr Bueso wrote:
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
>  drivers/cxl/core/regs.c | 14 ++++++++
>  drivers/cxl/cxl.h       |  6 ++++
>  drivers/cxl/port.c      | 71 +++++++++++++++++++++++++++++++++++++++++
>  include/cxl/cxl.h       |  6 ++++
>  4 files changed, 97 insertions(+)
> 
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
> index 1297594beaec..760f51b43891 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -42,6 +42,12 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
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
> index ada51948d52f..2dd712c5d312 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -58,6 +58,62 @@ static int discover_region(struct device *dev, void *unused)
>  	return 0;
>  }
>  
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
> +}
> +
>  static int cxl_switch_port_probe(struct cxl_port *port)
>  {
>  	/* Reset nr_dports for rebind of driver */
> @@ -66,6 +122,8 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>  	/* Cache the data early to ensure is_visible() works */
>  	read_cdat_data(port);
>  
> +	cxl_port_map_bi(port);
> +

I can't remember if I said something about this last revision (and I'm too lazy to go back
and check), but is this in the right spot? It looks like the port's component registers
are enumerated as part of cxl_port_add_dport() (in cxl/port.c) when the first dport is found.

I'm pretty sure this runs before that happens, so I either got something wrong here (likely)
or this shouldn't work.

>  	return 0;
>  }
>  
> @@ -128,6 +186,8 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	read_cdat_data(port);
>  	cxl_endpoint_parse_cdat(port);
>  
> +	cxl_port_map_bi(port);
> +

This one is fine though, the component register enumeration is handled as part of endpoint creation.

Rest looks good to me.
