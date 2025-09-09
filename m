Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976F03D984
	for <linux-cxl@vger.kernel.org>; Tue,  9 Sep 2025 16:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757435592; cv=fail; b=HgFwIhVWovZm+1vGbcXrbdy0nw2K6JhZiT2Bi+efNdw/U4jfiooKa6xNudx2RNIpp4XYHG7tI4pEHGrhPkQWo5clScb0S4RrfPtlF6/lB4Wd2E7TMeMQrJpIMViYYbfQYO3vI46C6G32PJa9cvpaBi2941T4tRvalRbjGRY53sk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757435592; c=relaxed/simple;
	bh=xvhgDYcb6RufVMIv1szSlGQ2/Ed71OJAMYFtl6ttTXg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:CC:From:
	 In-Reply-To:Content-Type; b=ObJNQCw4cdLJJDfXNoqRoe/W7fSbIwli3cAByEy3YmWvB7ZjKtAQTaiXsrrAme3WxqLxi6xHw3eGL30a0DrFuBgN1ip/zy0UcaV80KMUemASzrHI2MhP4dd2OGbLcGHngpe8Nc9mM88qe3vKeWXvyhP+QHg4plW3fb8gEOE5cRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xeBZbv4i; arc=fail smtp.client-ip=40.107.243.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xeBZbv4i"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o03QR9tvbe5oGYtykAqntcExKcJK+OWafHa+rP4F26RsDS9G5q02DPIPYbrpgSVesCi/K5nJn92vA4vmUZE1YYDKGqSCAHEsIEj6VCt177+CvGGL5JYeQ5t3gT3p2uW1AgZgU+BbGKxXCucn2b9Wu14x/oZ4NLZolhSc8jLFNwXpdNI6smwf3sqVIbtoWdk5X6EUaFpfZlE6WHQ+MM8buH6yffdIalMBIfyHK9tSRMGditaS532tITn6HnF/Z+KAKZHo3kJgtckEp4OnfWkLg2owbZWfSOwehA4VWDcQe9ijhBZwObARReiW0CHGf2mNiOuuExRUaYCDbhfVKYtfYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4DeUPf75bKN8K2TvOO8+TeHtcVj+dYrbS6thqISoT34=;
 b=ZkjsLwcj/I+nQOpg1fZFEYzfhTaH6kkw8dVyhGUEvULiHEQBJBr1SCFQsC8hASUCO0ZP4aFjCN2CaP9q2tjuzUFCxLt4BiRfSFnpqiQL4NbAh2YdfqvfBXY/NdBQSyFjfBwrIIULZGQy//ouF3VcpjGeVr29zLYew4X5qbmM39y9AmsU2C3ixQhSpE0tI3rGPB8s1nmRdVt4h2Mfw4DPB/9TaFmYRnqD3el2uus6g7p+LkNJ3GAV6vljlUeXyGd3UicUzB5Vcg6a/CSjlCteusRSaSUOTyovQ02cpgBhIvIs1LuGI7+U2e9ME1ll4gh14rDgpYTyBchdHXbt7mwkRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4DeUPf75bKN8K2TvOO8+TeHtcVj+dYrbS6thqISoT34=;
 b=xeBZbv4iJyq1gh6jKyVT1Kvuy9BnzpSGn5vu5Af3S22kios8e3IoKktEU/hki99f4wwIwB6UOMUdHAOoLNIRi9/9yQwR2xlyR6M5afZnzD8ugFDvl8O7BtDCr3l1DWnqHLWMScRSdB5sycxR8a1Aua22W4MS6olx8Azdk1WG7Ak=
Received: from BN9PR03CA0078.namprd03.prod.outlook.com (2603:10b6:408:fc::23)
 by SA3PR12MB9157.namprd12.prod.outlook.com (2603:10b6:806:39a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Tue, 9 Sep
 2025 16:33:08 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:408:fc:cafe::18) by BN9PR03CA0078.outlook.office365.com
 (2603:10b6:408:fc::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Tue,
 9 Sep 2025 16:33:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Tue, 9 Sep 2025 16:33:08 +0000
Received: from [10.236.177.220] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Sep
 2025 09:33:03 -0700
Message-ID: <38e7991e-2b8f-45c0-8784-c6f27aafe9ef@amd.com>
Date: Tue, 9 Sep 2025 11:33:03 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 08/18] cxl/port: Update switch_port_probe() for CXL
 cache devices
To: Dave Jiang <dave.jiang@intel.com>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
 <20250812212921.9548-9-Benjamin.Cheatham@amd.com>
 <00f7077d-cd8c-4788-92ad-e98327e9f6ec@intel.com>
Content-Language: en-US
CC: <linux-cxl@vger.kernel.org>
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <00f7077d-cd8c-4788-92ad-e98327e9f6ec@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|SA3PR12MB9157:EE_
X-MS-Office365-Filtering-Correlation-Id: 159c828e-c7ff-4c0f-d0e6-08ddefbe8f2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bnpLSmJvejY3Y3lBa1ZkOGZKeVBMdmhYZ2RleG9sdldYM3ExblZWL3JWNElK?=
 =?utf-8?B?U2tFdWt2NmxZMmQwYWd0Wk5TazBpVVc0bklNUENUdyswbmQxZFFPTGxuajM2?=
 =?utf-8?B?ZFNZZThxWEd0ckJYY2RibTltMnVmSHFFc2JBQjd4UDl3aXp1c2U0TlVJWW01?=
 =?utf-8?B?cGcwcFRsWU9pK3dPcXZDZzF6cVlIRnMyTjcrN3dxcVlRVFRPU0dCZmxsbFZW?=
 =?utf-8?B?K2NobHU3aDRzMHgvenNuZEp0aS9rejRvV0VVV09KUHFicTU0TWlsdHlFN0dO?=
 =?utf-8?B?YUZZaEhKUDB0Mm0xdDd4djFWZUNGZUxzdFN3UU5DWjVweXhrUHg5K0xOMSs0?=
 =?utf-8?B?LzBQWG8vMWEySitZZitGYW5sbk1rZmxxM2lIVk9ORXF2NWNIcnA0WjU2c1hj?=
 =?utf-8?B?bU1GOEZ3UkN1OUFqU04vSEoyY2doRnVXT0lRejZxdWdXb1A2SUJmQ3VwNmlH?=
 =?utf-8?B?a3o5SVhaRGJ5TzBQeERKR1RQTlZvQ1FPd3VHOUFiR3ZUU0NWamtkdnludVI2?=
 =?utf-8?B?NUJBZ0pVUmU0QVNtM3FYQjRkV1Rkek9sSEtFVGJ4NWRVeS9LSTRTbk9rWEhK?=
 =?utf-8?B?amNtcVJxQUVVUDRHMi81alB6b3RQU3V2N1hhQ3VZUmJkeVlPV1p4dkdhOWFk?=
 =?utf-8?B?anF3dUExbHFvaEhvczUwejBGUytUQVRIM1JZSi9sbm5wcEJnQkNFN1ZDRW9Y?=
 =?utf-8?B?a0ZiWWtPVFBYdkVIRXE0Qm5JUElieWZ1UFArUFhrNlAvSDQ1VzVVcHVsUDJQ?=
 =?utf-8?B?QzNRTitVY01uS2VabjFXU2l3bDh0THlaMGQ0a1RrTUZpKzhIbDljc3NaYXls?=
 =?utf-8?B?M2JaMVZaSXVvMWpuZDR0dE1IbjFUQ01vVktLSUJhQmV5cEwwV2V0TkpsUFRj?=
 =?utf-8?B?a3k1L3VPd2dSdWxnNUNpbVZHZFZsY3dMVHBlZFVLNGVOR2tZR0t6dklER0FO?=
 =?utf-8?B?TTcveXowSUdKQUxzbWwrUVdlRlVXaldyVkZ2WGo1UDh4bVI1ZExBTFNaNjRh?=
 =?utf-8?B?TG5vVHV2Tm5ITE9maVhDeDZUY0RtbXNxditSZzJGY2MzKzNFd3hRZ0V2SW5z?=
 =?utf-8?B?dkp0VWtJcUhlQnhXY2JndGhtZmVlK3NJd1RJUDFKUm5UWGkvbVl2YkVjTGlO?=
 =?utf-8?B?UDROdDZ6SDJhNkI3RkZSYjU4MUNWOVZvb3IvcjNGN00zamdiMmU0MVpJUXNY?=
 =?utf-8?B?bGsvTkhzNXl0N04vRHhPOUkxM0FDdEVUckpFYXFEK2NPUWxrdDBFb21NbjZV?=
 =?utf-8?B?akFnQ3pkMG9TTmRoSytXR29QQWdFTmFVakR5dnJSTFVQMUNXN2JFaytWQUt0?=
 =?utf-8?B?aGZmSnpXQ3RlT3hpR2FybmJicVBZTEFvVllKeXduZ3VHQzhxclByNlhCUSth?=
 =?utf-8?B?bVArdGFKb1E5Qmx6K1ZRd3dham81OFZLVXNsN1BRYVZuNnNFQ3VmRkJZbGkz?=
 =?utf-8?B?aWNlQWg4V0xTSVJvU3YxMTNUYWNPMzduSkljaTVYTnF0NlkxMEwyVHRXSHEx?=
 =?utf-8?B?cUJPOGZzOVJabnZPL1RmQjNWdDRIQS9DdjF4Nm1DZVJKOTBEdGh2SXlzMlpS?=
 =?utf-8?B?MHI0eCtyN0o2bUJPNkJTajY5N0lCSzh0KzkxZHczWDdINGJtYlBnQ3J6dUFk?=
 =?utf-8?B?cEhYT2MwY20rYU04dC9vYjR1dmIzbDhnbjF1MDBoTDdkSm1yaFk0UEsyVlpW?=
 =?utf-8?B?VW5iMHBadFNLQStiMGI2MElBbnNKWU1FdFFzeHpPVDVVNGRpUTJSTXNYY2lR?=
 =?utf-8?B?V0tqcWtqVjNCNFlna2RXNXFJUG5ZbEIxSFBjK2trallIL2FOUXBJVEt3czlX?=
 =?utf-8?B?anNxSDI4eTVjVGV0TjloeHRSb0Y1NWc5WHhDUW50eTlxRFJLeHlWTVdybGFi?=
 =?utf-8?B?dmNsaGhEdkZqVlVFSTE3dFBnZFpyak9RSFRVL0FHQmN4VlcxcW9DT1lCOGQ4?=
 =?utf-8?B?bERINlQrMkVNeHE3eTZZbmFxb2NPMlRSeVdVbU0vNStDK2c0NjdmNmt1UGg5?=
 =?utf-8?B?QjZlc2xCWmxNdTlEMWZJakxQWWhSUkw2VDQwN0cxcXovdytXRXc4LzJwN1FB?=
 =?utf-8?Q?5rVD3O?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2025 16:33:08.1152
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 159c828e-c7ff-4c0f-d0e6-08ddefbe8f2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9157



On 9/9/2025 11:20 AM, Dave Jiang wrote:
> 
> 
> On 8/12/25 2:29 PM, Ben Cheatham wrote:
>> CXL switch port probe currently assumes there are only CXL.mem-capable
>> devices below the switch with preconfigured HDM decoders. Now that
>> CXL.cache devices can be added below a switch port, it's possible that
>> they either have no HDM decoders (type 1) or the CXL.mem capabilities of
>> the endpoint haven't been set up yet (type 2).
>>
>> The HDM decoders being disabled (if present) is no longer a gauranteed
>> failure condition when only cache devices are present below the port.
>> Knowing what kind of devices are under the switch port isn't possible
>> until the endpoints are probed, so delay HDM setup and validation until
>> endpoint port probe.
>>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
>> ---
>>  drivers/cxl/core/hdm.c | 31 +++++++++++++++++++++++++++++++
>>  drivers/cxl/cxl.h      |  1 +
>>  drivers/cxl/port.c     | 23 +++++++++++++----------
>>  3 files changed, 45 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index 865a71bce251..6e04f1f4c166 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -205,6 +205,37 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
>>  }
>>  EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_hdm, "CXL");
>>  
>> +int cxl_validate_endpoint_hdm_setup(struct cxl_port *endpoint)
>> +{
>> +	struct cxl_port *sp = parent_port_of(endpoint);
>> +	struct cxl_hdm *cxlhdm;
>> +	int rc;
>> +
>> +	for (; sp && !is_cxl_root(sp); sp = parent_port_of(sp)) {
>> +		cxlhdm = dev_get_drvdata(&sp->dev);
>> +		if (cxlhdm && cxlhdm->decoder_count > 0)
>> +			continue;
>> +
>> +		if (!sp->reg_map.component_map.hdm_decoder.valid || !cxlhdm) {
>> +			dev_err(&sp->dev, "Missing HDM decoder capability\n");
>> +			return -ENXIO;
>> +		}
>> +
>> +		if (sp->total_dports == 1) {
>> +			dev_dbg(&sp->dev, "Fallback to passthrough decoder\n");
>> +			rc = devm_cxl_add_passthrough_decoder(sp);
> 
> This doesn't match the function name. We are no longer just validating. Although this whole patch may change if you take a look at my delayed dport series for v9. Just heads up.
> 
> DJ

Good point. I was just about to rebase this series onto v9, if this stays the same I'll change it.

Thanks,
Ben

>  
>> +			if (rc)
>> +				return rc;
>> +		}
>> +	}
>> +
>> +	if (is_cxl_root(sp))
>> +		return 0;
>> +
>> +	return -ENODEV;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_validate_endpoint_hdm_setup, "CXL");
>> +
>>  static void __cxl_dpa_debug(struct seq_file *file, struct resource *r, int depth)
>>  {
>>  	unsigned long long start = r->start, end = r->end;
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index c857c112772f..0dc4e5c96459 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -932,6 +932,7 @@ struct cxl_endpoint_dvsec_info {
>>  struct cxl_hdm;
>>  struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
>>  				   struct cxl_endpoint_dvsec_info *info);
>> +int cxl_validate_endpoint_hdm_setup(struct cxl_port *endpoint);
>>  int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>>  				struct cxl_endpoint_dvsec_info *info);
>>  int devm_cxl_add_passthrough_decoder(struct cxl_port *port);
>> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
>> index fbff4900c69d..56030066a652 100644
>> --- a/drivers/cxl/port.c
>> +++ b/drivers/cxl/port.c
>> @@ -75,18 +75,17 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>>  	if (!IS_ERR(cxlhdm))
>>  		return devm_cxl_enumerate_decoders(cxlhdm, NULL);
>>  
>> -	if (PTR_ERR(cxlhdm) != -ENODEV) {
>> -		dev_err(&port->dev, "Failed to map HDM decoder capability\n");
>> -		return PTR_ERR(cxlhdm);
>> -	}
>> -
>> -	if (port->total_dports == 1) {
>> -		dev_dbg(&port->dev, "Fallback to passthrough decoder\n");
>> -		return devm_cxl_add_passthrough_decoder(port);
>> +	/*
>> +	 * This isn't an error if only CXL.cache devices are below the port or
>> +	 * a passthrough is possible. Finish set up in
>> +	 * cxl_validate_endpoint_hdm_setup() during CXL.mem endpoint probe.
>> +	 */
>> +	if (PTR_ERR(cxlhdm) == -ENODEV) {
>> +		dev_dbg(&port->dev, "HDM decoder capability not found\n");
>> +		return 0;
>>  	}
>>  
>> -	dev_err(&port->dev, "HDM decoder capability not found\n");
>> -	return -ENXIO;
>> +	return PTR_ERR(cxlhdm);
>>  }
>>  
>>  static int cxl_cache_endpoint_port_probe(struct cxl_port *port)
>> @@ -116,6 +115,10 @@ static int cxl_mem_endpoint_port_probe(struct cxl_port *port)
>>  		return PTR_ERR(cxlhdm);
>>  	}
>>  
>> +	rc = cxl_validate_endpoint_hdm_setup(port);
>> +	if (rc)
>> +		return rc;
>> +
>>  	/* Cache the data early to ensure is_visible() works */
>>  	read_cdat_data(port);
>>  	cxl_endpoint_parse_cdat(port);
> 

