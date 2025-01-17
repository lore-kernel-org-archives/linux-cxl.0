Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B171714A1;
	Fri, 17 Jan 2025 21:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737149508; cv=fail; b=TOBNlvGoe2GzsQTmQgWlK9lx6pOrCJl/k73jBcbb9aNE8yt96JVHiPwJiDpVmKosXPBgU27xyYnw0bF+EKcLfKm2C29gRZkSxQpuql146gtMLvdu1ZAfcy2KbaA/U5c14BApT5UN87TSI/nBBBcCKumuj2d9ugsSq2joXhDgl2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737149508; c=relaxed/simple;
	bh=ipj/XdlaQthajHaFraDVVln8UUatKW1L3GhSK5u9nHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=RTxQ9YzqXJM6SF2pCNjMOebArKV4Y+o+p1mWZJR4fho6GSH3v1FKKizNqSJHOpsTS380zrPGSp5OhJRU3QtRXEdbLm5ZKqbtY9RebqEOPkdWHFuPnPgaP4kI9SRAprH1Kpzi0gvabAIa+vLLVbMFOmbG3JMSj0PBKEvTzcI5VZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v2+XROsr; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v2+XROsr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cxI8pzV9U1e/rbs4xjbNucyJYPtDNFv33o+hEJ/u9J+6GxKFaGNuqR4VRLZ88TFsyRL9Ic+M3HM0OM/10V63MPu265T8JbSBDu7Pg/lhOsfchIAdoRBhwu8nhLkzK6/dszLMe4tlMBbtNuVhPl0NItI2f7u/mC8pxjkasit8rZ5Fm5CC489jnQJSSR13PA4r2Ojln6uxrENwn4XM38beTcUQSgVsP2GK8usO1rttopVqMRjcFqxGPad61JanEkNSZhqEcaTB+VbxOnvGixyx/Y5rQ9n4qgXRUEMw65qZrERlZzLMHTR/joteAKhKB+9OyeBlgECK0gWy/Lu8UWH8WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NUr/M1JdKiq5qwUtMJTVG9pnT/LR8bXY7kpRmLFvxU4=;
 b=d3t7U/efWAubUh4Zp9z3G/9OmerXFlyCU8bj3WTEg7AZP8lzPBNBuR2rbZw1uHMgDWFWnzWg2STmrelfd4YVkHB0DTl3gqacrpacBF/FvV4V6KFw7mZjHfSMpyn72NveKcySRKPlrRrRisYR9LS9N1P9jX02OoZ3YKCBX1xGa5wfZrNGjZubwE0fukyQbfoNDoxeoxSaNDtu8i3xUK/FJ9q2l60hS0MRZF5kuJY7VuFlICGcWMZQ8hQ5Qrbm036i7qpPCezVP8zzvrbWIXYwaxHR/V8sPcUT6fMVUeeFdyTYiYWnfRdPfgIomWLpJMVpTX6t43AS+AmmkIGMaJ+eXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NUr/M1JdKiq5qwUtMJTVG9pnT/LR8bXY7kpRmLFvxU4=;
 b=v2+XROsrvSk89KXILDzGRTj7rMZ+20WiDl/KHZUOb8mCCf4fgasVPOr+lq7Eeq1g4UHskw/OWe8zW5CnA/HgivZkge3wGVsWNfDA7DPlmNqpCNgMBDePm5zQ4Ii+etWXnntYHWdN6YoVsgxHBEFpo7Q9NbdKf5iVzYAYzl86EyE=
Received: from BN8PR03CA0015.namprd03.prod.outlook.com (2603:10b6:408:94::28)
 by DS0PR12MB8042.namprd12.prod.outlook.com (2603:10b6:8:141::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Fri, 17 Jan
 2025 21:31:42 +0000
Received: from BL6PEPF0002256E.namprd02.prod.outlook.com
 (2603:10b6:408:94:cafe::e3) by BN8PR03CA0015.outlook.office365.com
 (2603:10b6:408:94::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.16 via Frontend Transport; Fri,
 17 Jan 2025 21:31:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0002256E.mail.protection.outlook.com (10.167.249.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Fri, 17 Jan 2025 21:31:41 +0000
Received: from [10.236.177.252] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 17 Jan
 2025 15:31:39 -0600
Message-ID: <2ae858ab-4c79-4101-b1be-026655fc76f5@amd.com>
Date: Fri, 17 Jan 2025 15:31:34 -0600
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 10/29] cxl/region: Add function to find a port's switch
 decoder by range
To: Robert Richter <rrichter@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gregory Price
	<gourry@gourry.net>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Terry Bowman <terry.bowman@amd.com>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-11-rrichter@amd.com>
Content-Language: en-US
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <20250107141015.3367194-11-rrichter@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0002256E:EE_|DS0PR12MB8042:EE_
X-MS-Office365-Filtering-Correlation-Id: 2297c99a-39a6-4a03-2c1c-08dd373e5584
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YXorODhUV2FIVWdYY3pEZkkxTTBWbm1iWVg0M1JZOHJZS3RQeDQrL050WVRL?=
 =?utf-8?B?d0JLR2NsUjV1UGxiV3FvY0xMNG5xeVo5cmtYQkZ4YlRWWWoxR2x1Ukw4cHcx?=
 =?utf-8?B?dzJHa2I5dC90elRNUTdsVm9ycDRCeDFsd29uV0pYM1daSDg5Ymt6U28vUGhB?=
 =?utf-8?B?RDBRNU5Rc3FlQkgxdW0yazBhVkZXOXROOGo4eHd3QnB6eWdHRElUem14T29O?=
 =?utf-8?B?VTNOekUxWEVmeXlKbkoxMTAyQS9ibWJRcHNLUWRoeW1CLzNSdXJrMkRCK0RC?=
 =?utf-8?B?V0NqUzhWM3lNcXd5dXRQSXNPL21Jdis2aHgrMEgwdDFiR3k0Rm1SRTZDRlpB?=
 =?utf-8?B?R1pXNGFBOWV5VTRVeUp6WGo4R2hNSm55U0RNUFdUYVR1SlJBeWFPWmJmQkV6?=
 =?utf-8?B?WFhtYmdQUUIwdDMwN29MelNVTEwzbGxjcGhSbXJ1cDhhOVJLZXhXREZzWU4x?=
 =?utf-8?B?ZHNPa1BXY1pWMmsvVExpNk9CaCtPYlRlaTArVERXbURwRThoNHRjNlJFMEgw?=
 =?utf-8?B?RzZZUENuZnZXYlNYZ3h2QTZ0RFhYR21CMW9yVm9FV3lIai9TRFB1cnUrU2Ru?=
 =?utf-8?B?dk5TSjl4S0RadjlKWXhhUkY3bzQrUzUvcnhEVzZBR2NBYlBhbmduU05ORElY?=
 =?utf-8?B?bEpnTnYxcGIrRDVCSTJNc0ZRUnVPTi8xdHlBUDhHQzVENXo1MDVIL3FMZ1NT?=
 =?utf-8?B?K3ZkYnY1YjhwN1pVZGNQb1kreXNNbysxcUMrUWZPamV5ZS9POGF0QVhJakZU?=
 =?utf-8?B?L1BhdEl1c2RHbFJYbXNpR2swTEpzM2lZV1o5ZERjd05obm1vL01JVmVaTUJt?=
 =?utf-8?B?UjRqR1F2YXFwdGJPME5RWlZUcUJxQjE4NGFTQ0JqYTJIK3RzQk85RVdyVjIx?=
 =?utf-8?B?VkMvTUYrNzNNaWxTT2xnaW1uajJBenFNVnlhemhpL2dkWUFONnFtcHVWeURE?=
 =?utf-8?B?c1RnVkdlM2VnZ2RyS3BBUXZveW43WHljdzR2c1VvVm84OXBFaGhjQVQ4MWUv?=
 =?utf-8?B?Uk52dFRHOEpSQXJtTTlmc2FqQTR0NW9wd28zQS80NDlwTlV4N2tZaGNDQ2pV?=
 =?utf-8?B?SHY5bG5tenEwcldqWFdNM1NqV1A1MDl2OEhadnl4WGQ2VkVla21yZTBCRExH?=
 =?utf-8?B?U3dycDloVk94NDNTQy83MUNCZndrOWZXbUxQSTB3U21naHJtcE1TbVFXbFVB?=
 =?utf-8?B?R0NrZ29KbXcydUp2WHUxekVkb3hPcnUvMFlqMUMrSDVlSWNUU251dGVtL2Np?=
 =?utf-8?B?cUN4UFZHQ0hKNGc4bzg5WC94ekxCOFBKVlpNcVZhQi80QWx5aTBjbExCOXow?=
 =?utf-8?B?cllaUU53WHdWbEFJeFYwdytkSW84aE5oNlJoVnBGa0N4Qjh3V0xDYWZPYUN0?=
 =?utf-8?B?NTBCY3ZJRjhpWm5CUlVuVzRIaDJxWDd0eUJHV1Jtb0EwclhFWnJGREEza2hB?=
 =?utf-8?B?cHI0azRzbmVVRFFHZFpFZGx3Yk1XUng0RUc4L1R1aG02VWpMS0g5cHQzTWpt?=
 =?utf-8?B?Uk5Jc0tPc24wZkFoNlRKOHlaTGIzdjhNVC90eStVeUd1Mm4xWEY0QlY1RmI0?=
 =?utf-8?B?RzJlbmUzMW1LMkw0dmpqOU9KWTlaTVhVQlA4NmNuY01OeCtzdkxiUjhiUUJk?=
 =?utf-8?B?Qzkvb2p2V2d0K3hLNUhodllnL2lHZ1p5dDh0eGNteDZoaXk2cit1ZGtxWlFy?=
 =?utf-8?B?cUVjSDlucVlvUlFnUVVRdWJ4b3VhUnJlMU05aTRmcDlTb21NVUUxeTcyaUhP?=
 =?utf-8?B?akxjZXVvb2JZeXk4M3VnMUsvQjFtd1RVOEtLNlF1b1FtOGY1bDU2RkR5aHVN?=
 =?utf-8?B?ai96ZE05TnVuUXNMeXY4THVQWjBaRFo1OWkvN1A3aFBqYW5GOTY2S0M0Smd0?=
 =?utf-8?B?TU9MdExMM3l1TWFLUEJKRGFwSzFLRGxiT3cvQmY1NWtqMHRiOHlBRzRVaU9M?=
 =?utf-8?B?L1kxRlJoRW50dGRFd01Cd2F6RjRDTWVSbGdqZGN4K3Q5cVBsd3MvS0hOdDZV?=
 =?utf-8?Q?9iTFJln+st7lhDQPhgeXrIOu3QWfn4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2025 21:31:41.7922
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2297c99a-39a6-4a03-2c1c-08dd373e5584
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0002256E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8042

On 1/7/25 8:09 AM, Robert Richter wrote:
> Factor out code to find the switch decoder of a port for a specific
> address range. Reuse the code to search a root decoder, create the
> function cxl_port_find_switch_decoder() and rework
> match_root_decoder_by_range() to be usable for switch decoders too.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/region.c | 43 +++++++++++++++++++++++----------------
>  1 file changed, 25 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 5750ed2796a8..48add814924b 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3189,19 +3189,35 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
>  	return rc;
>  }
>  
> -static int match_root_decoder_by_range(struct device *dev, void *data)
> +static int match_decoder_by_range(struct device *dev, void *data)
>  {
>  	struct range *r1, *r2 = data;
> -	struct cxl_root_decoder *cxlrd;
> +	struct cxl_decoder *cxld;
>  
> -	if (!is_root_decoder(dev))
> +	if (!is_switch_decoder(dev))
>  		return 0;
>  
> -	cxlrd = to_cxl_root_decoder(dev);
> -	r1 = &cxlrd->cxlsd.cxld.hpa_range;
> +	cxld = to_cxl_decoder(dev);
> +	r1 = &cxld->hpa_range;
>  	return range_contains(r1, r2);
>  }
>  
> +static struct cxl_decoder *
> +cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa)
> +{
> +	/*
> +	 * device_find_child() creates a reference to the root
> +	 * decoder. Since the root decoder exists as long as the root
> +	 * port exists and the endpoint already holds a reference to
> +	 * the root port, this additional reference is not needed.
> +	 * Free it here.
> +	 */

Is this comment still true? I haven't read the rest of the series yet, but there's
nothing enforcing that this function is called on a root port. If it's meant to
only be used for root ports then it should probably be named that way.

Also, if it is meant to be used for a general switch decoder, can we always free
the reference? If so then all that needs to happen is a comment update, otherwise
you'll need to keep the reference and put a comment somewhere that the function
needs a matching put_device().


> +	struct device *cxld_dev __free(put_device) =
> +		device_find_child(&port->dev, hpa, match_decoder_by_range);
> +
> +	return cxld_dev ? to_cxl_decoder(cxld_dev) : NULL;
> +}
> +
>  static struct cxl_root_decoder *
>  cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
>  {
> @@ -3209,7 +3225,6 @@ cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
>  	struct cxl_port *iter = cxled_to_port(cxled);
>  	struct range *hpa = &cxled->cxld.hpa_range;
>  	struct cxl_decoder *cxld = &cxled->cxld;
> -	struct device *cxlrd_dev;
>  
>  	while (iter && !is_cxl_root(iter))
>  		iter = to_cxl_port(iter->dev.parent);
> @@ -3217,9 +3232,8 @@ cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
>  	if (!iter)
>  		return NULL;
>  
> -	cxlrd_dev = device_find_child(&iter->dev, hpa,
> -				      match_root_decoder_by_range);
> -	if (!cxlrd_dev) {
> +	cxld = cxl_port_find_switch_decoder(iter, hpa);
> +	if (!cxld) {
>  		dev_err(cxlmd->dev.parent,
>  			"%s:%s no CXL window for range %#llx:%#llx\n",
>  			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
> @@ -3227,16 +3241,9 @@ cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
>  		return NULL;
>  	}
>  
> -	/*
> -	 * device_find_child() created a reference to the root
> -	 * decoder. Since the root decoder exists as long as the root
> -	 * port exists and the endpoint already holds a reference to
> -	 * the root port, this additional reference is not needed.
> -	 * Free it here.
> -	 */
> -	put_device(cxlrd_dev);
>  
> -	return to_cxl_root_decoder(cxlrd_dev);
> +
> +	return to_cxl_root_decoder(&cxld->dev);
>  }
>  
>  static int match_region_by_range(struct device *dev, void *data)

