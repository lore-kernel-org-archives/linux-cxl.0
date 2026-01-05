Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012021.outbound.protection.outlook.com [40.93.195.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C30E02DECDF
	for <linux-cxl@vger.kernel.org>; Mon,  5 Jan 2026 21:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767647792; cv=fail; b=dAx2A/oLoIDPHOAOJp2K6bq2kGmQiGC7QXAUTuStro8tY91ULtQY4l26wsEgTFuEnTOgDNpTMpdKftCj7aFt/XVbYBc4bGXHD1VbcGk+2sRtqQTkgK9xutI1ijJ3dlVhk1NlAfoxrzfsHiIDq6+Uk2VFud9IYJBzm6vdiYBvKxg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767647792; c=relaxed/simple;
	bh=d1VOd2OF0yIlVMxAUlgHjsYcOrl8nDC8J8a6jeR3EF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lq9zjJMe/fnc+n0AZRyRGXk8ThQ3Q2FxlHPlHoXKvsm7TUZaQ34I5JSy9V/JA9K6rS+IZ4YOuCT/1TbB9Gw5FHDQbuFwyqJwgEgkkKMLUdabeyG7qniVtco+aO9YPCkRrqx30kpkj2TQDDjpEdsHUh+XeR5LW0eLU/KGK/5wzs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AoGR/iPq; arc=fail smtp.client-ip=40.93.195.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AoGR/iPq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QD4ucBedudeedzPlERHrPdNkEEXdoWMdF4nV1SdH5Pf9/RNcizoxp2znRPZCkZp+wblVa2U8rUeklg41F0yGatui/Y+d3RaEFwmQNobFUHRj+MapWErPipCfi4mB1/u9jftIB1LFkCRZwnGC//oZ0gjUmQB60lzA2i/ivXFBWGA/SlCkdcQsBEUsCiWXmYjfvPsDhJNmSgbKg1kgeR5Y0ffU1lFU+t53EhVBvo4/5tomMkHzWuQK3kxnnFI//YuPFnH7TL+av5rfnIL+sMf0oSCunnTRC69VRAJ/jInvQfV2QwvBQ1Pdv9VnaPMu6CU/uwOoOweuCK5sDtaULz7FTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O5wMx77nzAAeRHZ49F1KOwUtQn3ZvpUxsFYmf5TkCBE=;
 b=ZO51U18k2AsidEgqigjwznu2GsBVnF0Gl7tGTv1j9hG3mlevhwN/ngTw6tTeoba1slR/A90DezL3YZ0XhGsz2vbzh7cH+5c40MPVr6FwOPUIDv1dwnM8ZLsbGC0XU0irZIL2b+kMeGHc3B3P5oObIb0awUwTYy4bKSRl2xn24eUOjVjgw/13M03MLF/yleCZQBlhbyU5ZRbNXve7wYJUfqh9DCcKatCl3UhWNhk5QCZksBbHi0Y1H9J/Izak8xt71DX+X+4Jz1o8O1u5x1orDBjxa3Z0VkhYNoIJTR+yZfca3IaHjPhTP+CYIjKcLgkKgn9cAr7qE+oxdNcpH51fug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5wMx77nzAAeRHZ49F1KOwUtQn3ZvpUxsFYmf5TkCBE=;
 b=AoGR/iPq3Gvt84zFkJLwipeqFdg6e4T6u8L+8N++RhXzBWRYQNDAgVBUkBkk9QtVWY9vM3m0l+wH8TOojsnWjWs3MiDH0g1+FCcpzYmPVOtdAQP6IucaVgSNFlPu01EvhTvjzicxYoCoo/UHKM/7ggR88PowhNIpDYKWommYgyM=
Received: from SN7PR04CA0207.namprd04.prod.outlook.com (2603:10b6:806:126::32)
 by IA1PR12MB7685.namprd12.prod.outlook.com (2603:10b6:208:423::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 21:16:28 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:806:126:cafe::63) by SN7PR04CA0207.outlook.office365.com
 (2603:10b6:806:126::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Mon, 5
 Jan 2026 21:16:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Mon, 5 Jan 2026 21:16:27 +0000
Received: from [172.31.132.101] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 5 Jan
 2026 15:16:26 -0600
Message-ID: <4ca09b23-e8c8-45e3-8a84-d08a763bb0e3@amd.com>
Date: Mon, 5 Jan 2026 15:16:25 -0600
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/17] cxl/core: Add cache id verification
To: Jonathan Cameron <jonathan.cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>
References: <20251111214032.8188-1-Benjamin.Cheatham@amd.com>
 <20251111214032.8188-14-Benjamin.Cheatham@amd.com>
 <20251222134726.00003986@huawei.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20251222134726.00003986@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|IA1PR12MB7685:EE_
X-MS-Office365-Filtering-Correlation-Id: ecf19b6e-7d4b-4e62-a7fc-08de4c9fb020
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MWU5U1FWRTJHdXR3anhOK0pPNFUyOVZ3aTBHVmo2Q3ZBSGgzK2ZMQjBCVGsw?=
 =?utf-8?B?a05vUUY5TVFUOWtJUlhXeHp3VUp4T2x0akVOT2ovYUM4a1Z4ckdNMHJjMkUy?=
 =?utf-8?B?M2VNTmQ3Y0YxTWZsNHduYUpzaHhFN2RSbWc0TG9VRG9HUVlocEt2R1hzMTYy?=
 =?utf-8?B?Z0dyVWFxNmUzdm5GSlNPbWFkNmlWaWVuZ3VtNTVjc3p4ajhNcVRvUlI3bGMy?=
 =?utf-8?B?cWN5Zzc0LzJxeVVnL3NlUjM5OHBZYXdPemJsbXltejNvQVZkVnl3Y0dQdGJx?=
 =?utf-8?B?ckFZb0N6b1JRMlZuOU90ZS8vTnYwczhhU3Q0UVltTUJTNVhPZTl2dDhxdWJr?=
 =?utf-8?B?WVllOVZQMjNNL3J1eXJnVnkrUThSQXRUVGJHWjdmSHg1U0J1d0ZHQTlIMmxE?=
 =?utf-8?B?aytDMG1MNVNLWUNMVEdPL1lLTXF1aC9pSUdnNEQwSnJVa082ZExVemtBOXJG?=
 =?utf-8?B?UlNWUmpiUmFtUXZ5ZDZ1emdvbWx6Nk5QcS9Sc0t2Z3FxTGJrdmZjWkoxMFRv?=
 =?utf-8?B?MXNTVHc2aWYzOTJtbUVHZ2UvakRQYkdDelNrSmtjN1BLZVB6ZDVPQVYrcGNE?=
 =?utf-8?B?RHNySlp6WkJFQ05BS1ZwTEdUVXA5Zko3UXBXTUMxRmdYTHRhMUtXNEhFa2tj?=
 =?utf-8?B?ZWk4dHNFOG8zZkIyQnh4R1o2OTNtZjRkcDBHV2p1djlvN3lTeU53OWVsN1E2?=
 =?utf-8?B?ZUZZNGlEajZrRDd2Mlh4amE2R2I1MDE3SEtYSDBLYjhscXJaWlArVThTRlJY?=
 =?utf-8?B?dENia1V6RklxRGZWenBzMC91Vk5ubEdzM1F1QTMza3hFcU0yQkdNYUhabWZJ?=
 =?utf-8?B?U1daRjdIL0NYWExPUS9mRXIweGExV2N2eklXb0FDb2FIWHRtRGhEUkY5NUc0?=
 =?utf-8?B?UUxHMVJwRTZXTWg5QmZ4YndtbGJ4SFQvdzZDYWI4KzdUM3F5T1FjaFljL2NT?=
 =?utf-8?B?N3MzaU9VMFkyWkZyeWlTODFRL1EveHNiRG9IVk1tR0svNU80S3pITEhQdm4w?=
 =?utf-8?B?M1BHdm1xUUpYM2k5UlByUENVeEVBazE4M1hHSFRFVkhiSm9jYmhrSHVKMWhp?=
 =?utf-8?B?YnhzQW9HVHJNeHQ4NXNRUDlNZWRoRHlNbVFPK3U0S2h6NHQ2bGVUWVR5SFNn?=
 =?utf-8?B?ZFNYQ0RsVGcrUEkza1hab2lOUjlCcVVwVk5KMjR1c1o0TnF3K1Y2Q25qSGh0?=
 =?utf-8?B?cmFhZVFwOHhoZUQrdnBISWNndHJrb25QZ2c2NVBvcDUvQlR3TDZEOFpXMXlS?=
 =?utf-8?B?YmlqVnhxZ25kWU91bFZ0ZGFGbXNTUzNFd2kydUo3dndpSEJONDNlbjBpNm1u?=
 =?utf-8?B?V3d5QzV2bmlYeC9BSnhwdjg0aitWVW9kY0tvQm53SmR3V3RDenlkS0RRWGVM?=
 =?utf-8?B?c1hWL1ViTkd1MzBrc0hKNjJNWWxabXZJUGNwKzdiK1BrMmxBRDYxVXNpK1Jq?=
 =?utf-8?B?R1BZS0ZjZlNzOStzMklDY2tEY3BTMEc3NEhtSnIxeGpLOGdkVzE2Q1lYbWJz?=
 =?utf-8?B?TUd3YW5KNWtLSjY2eFRQbTJEQ014RTRTb0laUnhhdVRGQWZ1TGF0VHc4ak1h?=
 =?utf-8?B?NUg2STBxaVA4TVJvWW12OHU0ajlkRDdZTm5pMURUU3BEb1BpSHZ0S1Ztd0Fl?=
 =?utf-8?B?V2VEWW1DNWJjdUpzdUZ0UWYvN3VLYnRuK1dQN3N0eENXLzA1STM4dGZPNWVF?=
 =?utf-8?B?VlhHWWRRVkdSZWhJaWl2OWlsMW1FRmd2WSt4N0M2a24vemwvYkk2SVVpTjQ1?=
 =?utf-8?B?L0xPNGY3SVBRSGdyRUF1ZU92UzZKUC85Y09UMnlTK01HZ1BXN2pXclFwV1dH?=
 =?utf-8?B?bXlUWUltaWZBT01GWGpLWWRpcUtCNnFjWGM4RzRScXg1QXNyMEtBbFJZSTV6?=
 =?utf-8?B?eW8ySEVOeFYrOC9oVGRjMitpZVJOQUxNUno1bjdtOUhWcnA0bHJSanNZM0Fa?=
 =?utf-8?B?Z28xUytQcVFxcVpDcGk2MUxHUDB1ZVl6U2pWRURpMStZdXljQ1VNT0d3TWlp?=
 =?utf-8?B?Vyt2MG1kYnh1QWxaWEloeE1VRU9nQmU5WGhkT21oY2kyMTFWcS9DajBhbm9R?=
 =?utf-8?B?NkhmYXhmNDU1SmJXRnVudkhrTUx1ZGIxWlI0c2RXWU0wR3RmSkV1V0hMY1di?=
 =?utf-8?Q?IB48=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 21:16:27.0894
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecf19b6e-7d4b-4e62-a7fc-08de4c9fb020
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7685

On 12/22/2025 7:47 AM, Jonathan Cameron wrote:
> On Tue, 11 Nov 2025 15:40:28 -0600
> Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:
> 
>> The CXL cache id capability (CXL 3.2 8.2.4.28/29) is an optional
> This should probably be more specific given there are several
> capability structures and none have that name.

Sure, I'll update it.

> 
>> capability that allows for multiple CXL.cache devices to be enabled
>> under a single virtual hierarchy (VH). The cache id capability is
>> required for having multiple CXL.cache devices in the same VH.
>>
>> It's possible for the platform to enable and set up the cache id for a
>> CXL.cache device. Add code to cxl_cache to check whether the device's
>> cache id is programmed and correct. If it is programmed, allocate the
>> cache id to prevent reuse.
>>
>> Checking the correctness of the id requires knowing if the endpoint
>> device is a type 2 device using HDM-D flows. Add a requirement for type
>> 2 driver to specify if the device is using HDM-D flows before calling
>> devm_cxl_add_cachedev().
> 
> Probably support this with some spec references.

I'll add some.

> 
> 
>>
>> Programming of cache ids will come in a later commit.
>>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
>> ---
>>  drivers/cxl/core/cachedev.c |  20 ++++
>>  drivers/cxl/core/pci.c      |   4 +-
>>  drivers/cxl/core/port.c     | 229 ++++++++++++++++++++++++++++++++++++
>>  drivers/cxl/core/regs.c     |  20 ++++
>>  drivers/cxl/cxl.h           |  44 +++++++
>>  drivers/cxl/cxlcache.h      |   3 +-
>>  drivers/cxl/port.c          |  28 ++++-
>>  7 files changed, 344 insertions(+), 4 deletions(-)
> 
>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>> index 70666a059d1f..1504631ae620 100644
>> --- a/drivers/cxl/core/port.c
>> +++ b/drivers/cxl/core/port.c
>> @@ -750,6 +750,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
>>  		dev->parent = uport_dev;
>>  
>>  	ida_init(&port->decoder_ida);
>> +	ida_init(&port->cache_ida);
>>  	port->hdm_end = -1;
>>  	port->commit_end = -1;
>>  	xa_init(&port->dports);
>> @@ -2414,6 +2415,234 @@ int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld)
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_decoder_autoremove, "CXL");
>>  
>> +static bool cache_decoder_committed(struct cxl_dport *dport)
>> +{
>> +	u32 cap, stat;
>> +
>> +	cap = readl(dport->regs.cidd + CXL_CACHE_IDD_CAP_OFFSET);
>> +	if (!(cap & CXL_CACHE_IDD_CAP_COMMIT_REQUIRED))
>> +		return true;
>> +
>> +	stat = readl(dport->regs.cidd + CXL_CACHE_IDD_STAT_OFFSET);
>> +	return (stat & CXL_CACHE_IDD_STAT_COMMITTED);
> 
> Brackets not adding much so I'd drop them.

Sure

> 
>> +}
>> +
>> +static bool cache_decoder_valid(struct cxl_dport *dport, int id, bool endpoint)
>> +{
>> +	struct pci_dev *pdev = to_pci_dev(dport->dport_dev);
>> +	bool flit_256b = cxl_pci_flit_256(pdev);
>> +	u32 ctrl;
>> +
>> +	if (id && !flit_256b)
>> +		return false;
>> +
>> +	ctrl = readl(dport->regs.cidd + CXL_CACHE_IDD_CTRL_OFFSET);
>> +	if ((endpoint || !flit_256b) &&
>> +	    !(ctrl & CXL_CACHE_IDD_CTRL_ASGN_ID))
>> +		return false;
>> +	else if (!(ctrl & CXL_CACHE_IDD_CTRL_FWD_ID))
> 
> returned so no point in else.

Good point, I'll remove it.

> 
>> +		return false;
>> +
>> +	return true;
>> +}
> 
>> +int cxl_endpoint_map_cache_id_regs(struct cxl_port *port)
>> +{
>> +	struct cxl_dport *parent_dport = port->parent_dport;
>> +	int rc;
>> +
>> +	if (!is_cxl_cachedev(port->uport_dev))
>> +		return -EINVAL;
>> +
>> +	port = parent_port_of(port);
>> +	while (port) {
>> +		if (!port->reg_map.component_map.cidrt.valid)
>> +			return -ENXIO;
>> +
>> +		scoped_guard(device, &port->dev) {
>> +			if (!port->regs.cidrt) {
>> +				rc = cxl_map_component_regs(
>> +					&port->reg_map, &port->regs,
>> +					BIT(CXL_CM_CAP_CAP_ID_CIDRT));
>> +				if (rc)
>> +					return rc;
>> +			}
>> +		}
>> +
>> +		/*
>> +		 * Parent dports of host bridges are cxl root (ACPI0017) dports
>> +		 * and don't have cache id decoders.
>> +		 */
>> +		if (is_cxl_root(parent_dport->port))
>> +			break;
>> +
>> +		if (!parent_dport->reg_map.component_map.cidd.valid)
>> +			return -ENXIO;
>> +
>> +		scoped_guard(device, &parent_dport->port->dev) {
>> +			if (!parent_dport->regs.cidd) {
>> +				rc = cxl_map_component_regs(
>> +					&parent_dport->reg_map,
>> +					&parent_dport->regs.component,
>> +					BIT(CXL_CM_CAP_CAP_ID_CIDD));
>> +				if (rc)
>> +					return rc;
>> +			}
>> +		}
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_endpoint_map_cache_id_regs, "CXL");
>> +
>> +/**
>> + * cxl_endpoint_allocate_cache_id - Allocate a cache id @id on the endpoint's
>> + * host bridge.
>> + * @endpoint: Endpoint port representing a CXL.cache device
>> + * @id: Cache id to attempt to allocate
>> + *
>> + * Returns rc < 0 if id allocation fails. Returns allocated id otherwise.
>> + */
>> +int cxl_endpoint_allocate_cache_id(struct cxl_port *endpoint, int id)
>> +{
>> +	struct cxl_cachedev *cxlcd;
>> +	struct cxl_port *hb;
>> +	int nr_hdmd;
>> +	u32 cap;
>> +
>> +	if (!is_cxl_cachedev(endpoint->uport_dev) || id < 0)
>> +		return -EINVAL;
>> +	cxlcd = to_cxl_cachedev(endpoint->uport_dev);
>> +
>> +	hb = parent_port_of(endpoint);
>> +	while (!is_cxl_host_bridge(&hb->dev))
>> +		hb = parent_port_of(hb);
>> +
>> +	if (cxl_cachedev_is_type2(cxlcd) && cxlcd->cxlds->hdmd) {
>> +		cap = readl(hb->regs.cidrt + CXL_CACHE_IDRT_CAP_OFFSET);
>> +		nr_hdmd = FIELD_GET(CXL_CACHE_IDRT_CAP_TYPE2_CNT_MASK, cap);
>> +
>> +		guard(device)(&hb->dev);
>> +		if (hb->nr_hdmd + 1 >= nr_hdmd)
>> +			return -EINVAL;
>> +
>> +		hb->nr_hdmd++;
>> +	}
>> +
>> +	return ida_alloc_range(&hb->cache_ida, id, id, GFP_KERNEL);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_endpoint_allocate_cache_id, "CXL");
>> +
>> +void cxl_endpoint_free_cache_id(struct cxl_port *endpoint, int id)
>> +{
>> +	struct cxl_cachedev *cxlcd;
>> +	struct cxl_port *hb;
>> +
>> +	if (!is_cxl_cachedev(endpoint->uport_dev))
>> +		return;
>> +	cxlcd = to_cxl_cachedev(endpoint->uport_dev);
>> +
>> +	hb = endpoint;
>> +	while (!is_cxl_host_bridge(&hb->dev))
>> +		hb = parent_port_of(hb);
>> +
>> +	if (cxl_cachedev_is_type2(cxlcd) && cxlcd->cxlds->hdmd) {
>> +		guard(device)(&hb->dev);
>> +		hb->nr_hdmd--;
>> +	}
>> +
>> +	ida_free(&hb->cache_ida, id);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_endpoint_free_cache_id, "CXL");
> 
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index de29ffc3d74f..f4dc912d67ed 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -42,6 +42,8 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
>>  #define   CXL_CM_CAP_CAP_ID_RAS 0x2
>>  #define   CXL_CM_CAP_CAP_ID_HDM 0x5
>>  #define   CXL_CM_CAP_CAP_ID_SNOOP 0x8
>> +#define   CXL_CM_CAP_CAP_ID_CIDRT 0xD
>> +#define   CXL_CM_CAP_CAP_ID_CIDD 0xE
>>  #define   CXL_CM_CAP_CAP_HDM_VERSION 1
>>  
>>  /* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
>> @@ -159,6 +161,30 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>>  #define CXL_SNOOP_FILTER_SIZE_OFFSET 0x4
>>  #define CXL_SNOOP_CAPABILITY_LENGTH 0x8
>>  
>> +/* CXL 3.2 8.2.4.28 CXL Cache ID Route Table Capability Structure */
>> +#define CXL_CACHE_IDRT_CAP_OFFSET 0x0
>> +#define   CXL_CACHE_IDRT_CAP_CNT_MASK GENMASK(4, 0)
>> +#define   CXL_CACHE_IDRT_CAP_TYPE2_CNT_MASK GENMASK(11, 8)
> 
> As below. the -D bit should be in this name I think.
> 
>> +#define   CXL_CACHE_IDRT_CAP_COMMIT_REQUIRED BIT(16)
>> +#define CXL_CACHE_IDRT_STAT_OFFSET 0x8
>> +#define   CXL_CACHE_IDRT_STAT_COMMITTED BIT(0)
>> +#define CXL_CACHE_IDRT_TARGETN_OFFSET(n) (0x10 + (2 * (n)))
>> +#define   CXL_CACHE_IDRT_TARGETN_VALID BIT(0)
>> +#define   CXL_CACHE_IDRT_TARGETN_PORTN GENMASK(15, 8)
>> +
>> +/* CXL 3.2 8.2.4.29 CXL Cache ID Decoder Capability Structure */
>> +#define CXL_CACHE_IDD_CAP_OFFSET 0x0
>> +#define   CXL_CACHE_IDD_CAP_COMMIT_REQUIRED BIT(0)
>> +#define CXL_CACHE_IDD_CTRL_OFFSET 0x4
>> +#define   CXL_CACHE_IDD_CTRL_FWD_ID BIT(0)
>> +#define   CXL_CACHE_IDD_CTRL_ASGN_ID BIT(1)
>> +#define   CXL_CACHE_IDD_CTRL_TYPE2 BIT(2)
> 
> Need to include the HDM-D bit of this name or it's very confusing as
> nothing stops HDM-DB devices being type 2 ones.

Good point, I'll expand it.> 
> 
>> +#define   CXL_CACHE_IDD_CTRL_TYPE2_ID_MASK GENMASK(11, 8)
> As above, the HDM-D part of this matters. Obviously it's a long
> name but I'm not sure we can avoid that as it's a very specific
> thing!

I agree. So much for trying to keep the names "short" XD.

Thanks,
Ben
> 
> 
> 

