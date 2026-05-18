Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012008.outbound.protection.outlook.com [52.101.53.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE621398918
	for <linux-cxl@vger.kernel.org>; Mon, 18 May 2026 21:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779139733; cv=fail; b=ZOGdfx7zYQosmpQb0c4kifGnceVSAs5mAWthamyLNpm7PuPrZk/KlALLpsdtby89KJ0/cJskzkvePMT6oOg3AXSOs/Ga4EZfkKJIqkCCURV6tuOgxOnKGyVxjsz9s52MaRb62kh3oI6i+hPJ1RvOZODOtp+5k2XFAG9OyKgdz6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779139733; c=relaxed/simple;
	bh=HjpVN5UxlcbS5SFMfIk7Srvob9nI8cim00uDvkLhZZw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=MYe5ey/D0JlXQ9GM+zQKYRIb1xZTowfhdy/ghxLL1L+vTPvQbAQysGHkGjffAofjJg+wTNVfynI2r57ViSObtL52SRggcxJHsPgNugp3ebwRht9SFBWS+rQZkrN3Z+PHhGqTf09HGojEUmOxl5SkZ0tjLEcvrzCrFgHNyq2gfMc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TLPE7Xpp; arc=fail smtp.client-ip=52.101.53.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TLPE7Xpp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bao7f7g6cDqmMqR/TMHmMLY3d1o4KrMIeO5HgmR97NJZit8Y9dhMypLCFV+2XFgneZ2Y6lqLH9zmbX8si6Dv0THXVC0WLjdTb/mcaYnsuQQxH9tEiC51+olxBIGzGviDT3zx7veldZPoCiJmjKkGyVHb3Igb0Ff9sc99206sPVzPJXsMxAbU6sLEGQjWEx76p5R7ESwzuNXKE1tmmz5kDnJKzKBm1MtA6KYCbOJTsBGIN6hluImyrqDixnwl8dr52XK5adqij/JIgdyAxNcyAGUMVIQkiArLj4hnPVmHQ7KryeHA3b0iTYurayX8XooRBKXmQWB0eM2ozwZ/jptuAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3eFbiRa7bVxOTQiZD0U4bFzOFZvi2Go2pUEdp+s5+48=;
 b=jy8Is7rXrvsJmu2rTy2b9iFEeBOLp0VwlxVTrdoGBAejvhDQH/ToIEmmJX6n7T6/V7+HVOYH3APF5vtOidt0CM7rdTPgmN2j+2/XYkdKCrWtTpv/Wyk3T+kwN7j/5rz4bj7viuMsZ8c77K0wZBl1CRCFqq+8jED84D+IDQ6r6C42N9UYyKEECk1cfyotjnF51E/tT7kuh4GyAhyOouZK98uCw6zjhyLuxYKuBXqpwO8H/aqddefrkW/uzu3636Y1QSKNl5UkRuMllJ8Bz0ykAye6+s3eP9WEab3Ac5t744drFokW+c9r7EZiqCrKAePF2lJE67OrqJvnw1Lm0OjcPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=stgolabs.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3eFbiRa7bVxOTQiZD0U4bFzOFZvi2Go2pUEdp+s5+48=;
 b=TLPE7XppMuDbf/RWiHgYG88KdDaEjQ0e++IhduYHpes3yVZ9uIUkrBYJh4wDKiJ3J367RmcXvjavFipZr7YSvQqW0Q2H229lNAXUUCd3HbKay9lRAxNijje9HcWxFcT24+waZPydaEuGX0VbblJTnwS2o2RzQ/DU79AaFDtNxEc=
Received: from SJ0PR13CA0014.namprd13.prod.outlook.com (2603:10b6:a03:2c0::19)
 by CH3PR12MB7762.namprd12.prod.outlook.com (2603:10b6:610:151::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 21:28:43 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::67) by SJ0PR13CA0014.outlook.office365.com
 (2603:10b6:a03:2c0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.13 via Frontend Transport; Mon, 18
 May 2026 21:28:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Mon, 18 May 2026 21:28:43 +0000
Received: from [10.254.60.74] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 18 May
 2026 16:28:41 -0500
Message-ID: <3156f93f-13dd-4c71-9a26-b59b8607f914@amd.com>
Date: Mon, 18 May 2026 16:28:40 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
Subject: Re: [PATCH v3 1/5] cxl: Add BI register probing and port
 initialization
To: Davidlohr Bueso <dave@stgolabs.net>, <dave.jiang@intel.com>,
	<djbw@kernel.org>
CC: <jic23@kernel.org>, <alucerop@amd.com>, <alison.schofield@intel.com>,
	<ira.weiny@intel.com>, <gourry@gourry.net>, <dongjoo.seo1@samsung.com>,
	<anisa.su@samsung.com>, <linux-cxl@vger.kernel.org>
References: <20260516022037.1761453-1-dave@stgolabs.net>
 <20260516022037.1761453-2-dave@stgolabs.net>
Content-Language: en-US
In-Reply-To: <20260516022037.1761453-2-dave@stgolabs.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|CH3PR12MB7762:EE_
X-MS-Office365-Filtering-Correlation-Id: 24955ece-63d3-415e-29fa-08deb5246fc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|22082099003|56012099003|18002099003|4143699003|11063799003;
X-Microsoft-Antispam-Message-Info:
	2FgTOuF3vUQ1mAgD8lrvtVZczbxYil085nnSa5oWuQu4RV+i9fbVNWd9X4LIVEVzD1c5W+RACu/DNc5IweeSTUFsyR8TgjVtpWFbSQVPYefkjIJZgimfpxR3PPxMa9JXQNzF5hmc1WXRTlrJ9QGrihQKtW0Ors4lobLtZf6HRuhTE9++oJsSwZxzBgnrzbK71ERUi62JyIOw20V5X/XE4QOnAD4EySmUImyZyFfIIDY7LLy1WOBwhr2k/P9CjBpsVsuz+FaUiB3kOqJz9gXeAGIMVMLqGqLDRcw100UXVMltWF6ftM2Ctze/Q+orL+sahv9IdkQizBO6Jjl696ZKJVMnt/jOSTFFBOXuHOsN72QIP6YDOZWji8rlcUU4KUbK+lPNIlUCDUuuijRiuJL3bz+0cFubBqMq89K6SMM825zY3AYsBW2nQBcUFqe626hYvLQ2IHJec5ZnNzMYB2EHv1Bde96bWenmYawOtB1GkQ8H0KIzWXV4gK3ij7umalDZGwTrkbVRe9PtqnEVoF18T8z7gQXN+YmWXY+YhvXFhzGv60YZ7+X2uXDRFaTNi+Sx5TlQgcxcTVh+Na8juToAvZykGD2CSwWgfAw82XJKgmB0M8C045vXlAPgWHCNCvhDTVhXXyZzYuRUmo7cVZ6gi2sYwueKVgi2RJ3exRDCezASXAsmuWctH/XvtpHO7CFOmPgAMmFGJU75PVYwidl5hyOl9Fv/Q/f4JUDzXqBH2zA=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(22082099003)(56012099003)(18002099003)(4143699003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	z5HLMO5rx+pbdANkeNvBI1Hs5uuzpiv4sipV0Cu9SWpzNLcOMNBeU/SRUXQWHvYGGZt+Ptmre1I/jYApYy6bglFAtp6CkOmLsYrAHuwNQlneLp1kCEJI+lLXiWwpInYnDRAoai7AVeY/ou5nWL42sovCvZUH8j+ZqO5Yo1/SZ3Oa+rmzfjNtuXYooDr/kKgWPjRWUO1x+OieVYqDNn0AWXgvAUpuPv9a+8/gwNDmJ7WMXJeGFgO3aJkXAL/cGWpgGPW8Iw/nKZGJAi6+LaQFq3T6agBCBLdDlODy57k9QkNhOuOJyJr+J93SzDji7s1Yej/D8jaLJIpgaOSKTzzpCk8k1nyA0LFmLtACdWmmhfzHoA3ZbWx27UubtMaPISG1GagkYi7P07UPwQWTL4rw1+m2RIJWdsUtHLn8rwzmLRTQD3ktklPbpoFiovY1mo5C
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 21:28:43.0145
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24955ece-63d3-415e-29fa-08deb5246fc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7762

On 5/15/2026 9:20 PM, Davidlohr Bueso wrote:
> Add register probing for BI Route Table and BI Decoder capability
> structures in cxl_probe_component_regs(), and initialize BI registers
> during port probe for switch ports and endpoint ports.
> 
> Each port's probe initializes its own BI cap and the parent dport's
> BI Decoder. Switch DSPs are therefore mapped by the children below
> them (endpoint or sub-switch USP), and a root port is mapped by
> whichever cxl_port sits directly below it -- a switch USP, or a
> direct attached endpoint.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/core/regs.c | 14 +++++++
>  drivers/cxl/cxl.h       |  6 +++
>  drivers/cxl/port.c      | 89 +++++++++++++++++++++++++++++++++++++++++
>  include/cxl/cxl.h       |  6 +++
>  4 files changed, 115 insertions(+)
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
> index ada51948d52f..e0ac9432848a 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -58,6 +58,91 @@ static int discover_region(struct device *dev, void *unused)
>  	return 0;
>  }
>  
> +static int cxl_dport_init_bi(struct cxl_dport *dport)
> +{
> +	struct cxl_register_map *map = &dport->reg_map;
> +	struct device *dev = dport->dport_dev;
> +
> +	/*
> +	 * Already mapped. The BI Decoder iomap persists for the dport's
> +	 * lifetime via the parent cxl_port's devm context.
> +	 */
> +	if (dport->regs.bi_decoder)
> +		return 0;
> +
> +	if (!map->component_map.bi_decoder.valid) {
> +		dev_dbg(dev, "BI decoder registers not found\n");
> +		return 0;
> +	}
> +
> +	if (cxl_map_component_regs(map, &dport->regs.component,
> +				   BIT(CXL_CM_CAP_CAP_ID_BI_DECODER))) {
> +		dev_dbg(dev, "Failed to map BI decoder capability.\n");
> +		return -EINVAL;

It looks like the return value of this function isn't being used. I haven't looked ahead in the
series, but the return type should be void if it's never updated.

What initially caught my eye here was not returning the result of cxl_map_component_regs() here.
It's probably better to return the result since it's the error code of the actual problem, even
though it will always be -ENOMEM.

> +	}
> +
> +	return 0;
> +}
> +
> +/*
> + * Initialize Back-Invalidate registers for @port: map the BI Decoder on
> + * the upstream parent dport (root port or switch DSP), and map this
> + * port's own BI capability -- BI RT for a switch USP, BI Decoder for
> + * an endpoint.
> + */
> +static void cxl_port_init_bi(struct cxl_port *port)
> +{
> +	struct cxl_register_map *map = &port->reg_map;
> +	struct cxl_dport *parent_dport = port->parent_dport;
> +	struct device *dport_dev, *udev;
> +	int cap_id;
> +
> +	/* no upstream BI registers above host bridges or the cxl_root */
> +	if (!parent_dport || is_cxl_root(parent_dport->port))
> +		return;
> +
> +	/* BI requires 256B Flit on the upstream link */
> +	udev = is_cxl_endpoint(port) ?
> +		port->uport_dev->parent : port->uport_dev;
> +	if (dev_is_pci(udev) && !cxl_pci_flit_256(to_pci_dev(udev)))
> +		return;
> +
> +	dport_dev = parent_dport->dport_dev;
> +	if (dev_is_pci(dport_dev)) {
> +		switch (pci_pcie_type(to_pci_dev(dport_dev))) {
> +		case PCI_EXP_TYPE_ROOT_PORT:
> +		case PCI_EXP_TYPE_DOWNSTREAM:
> +			cxl_dport_init_bi(parent_dport);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +
> +	if (is_cxl_endpoint(port)) {
> +		if (port->regs.bi_decoder)
> +			return;
> +		if (!map->component_map.bi_decoder.valid) {
> +			dev_dbg(&port->dev, "BI Decoder registers not found\n");
> +			return;
> +		}
> +		cap_id = CXL_CM_CAP_CAP_ID_BI_DECODER;
> +	} else {
> +		if (port->regs.bi_rt)
> +			return;
> +		if (!map->component_map.bi_rt.valid) {
> +			dev_dbg(&port->dev, "BI RT registers not found\n");
> +			return;
> +		}
> +		cap_id = CXL_CM_CAP_CAP_ID_BI_RT;
> +	}

Nit: I overlooked that this is now mapping the port's BI capability, maybe a comment above the if statement
so that readers don't just gloss over it (like myself :/).
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
> @@ -66,6 +151,8 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>  	/* Cache the data early to ensure is_visible() works */
>  	read_cdat_data(port);
>  
> +	cxl_port_init_bi(port);
> +

Do you need this to be set up before an endpoint arrives? If not, I would prefer
this to be mapped with the other capabilities in cxl_port_add_dport(). That may
also allow you to get rid of the below call in the endpoint probe, but I'm not
sure about that...

>  	return 0;
>  }
>  
> @@ -128,6 +215,8 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>  	read_cdat_data(port);
>  	cxl_endpoint_parse_cdat(port);
>  
> +	cxl_port_init_bi(port);
> +
>  	get_device(&cxlmd->dev);
>  	rc = devm_add_action_or_reset(&port->dev, schedule_detach, cxlmd);
>  	if (rc)
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index fa7269154620..8ce9b4e9ca73 100644
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

