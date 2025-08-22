Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2051.outbound.protection.outlook.com [40.107.94.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9795A19E97A
	for <linux-cxl@vger.kernel.org>; Fri, 22 Aug 2025 18:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755885729; cv=fail; b=ZoS3iEOrTrrNsFWgwvgQ3/1VU8glOmiTJNPz2G6GZXSnQ/+ye56ssHAuilU/bZrwnrcadhx7gIrxMziDHk0ktq15cqPlEbcrMvWSOjxvOn6+P8MhSmdl7zArOSUJXI03NsZesadjR1CpB7pmB+efNsvBGrSFs+Ifd0XsTaLB6q8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755885729; c=relaxed/simple;
	bh=dK4egsoANIT2MiVDgxpMst5wrw5RvlxwPqC+w5CB1Tk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=p5epKWiCdEUSNvTdu3jaW/g2RN6lrkvszwozwUQcowaI25fKlw0qy4DMwJj63w9G1iIc/AaqVGNU9r+QW+U4gRevyoeN7fohs4P8PMoyhxRXVeXewp5apjB+rbACdfQHRd3lFkFX0zzbTGVauSsKnCYnZMAgZKK8zhHSNtp4Tk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=z7GaYKAc; arc=fail smtp.client-ip=40.107.94.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="z7GaYKAc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fajejZt9r0ETdlZVxQQVDxhVen1WphOwI/++WTe0RzIDXCRTd0bML1/mvmCIKRonHWdiitOHoHxMgmMLSYKsmLLA9aAYj0z/wjk9Efba5/pfG5NY1AKIzGwR0aW8fDtJKD6Z00JekEZ8Ot2JuAK2MJY7+c0i78S8aEeWJjQOS/KKdf1E3iVfEZN+jaU4g755TX23/FW9am5PvHk08bDsn5zsz0PIY82jYxQiU+7D1h+0sdaZJkkNaD9MdiI4tPCQz82TldMDXwSeGa0c47pGB3WRkklZcWdQTVHGbR9uAjeFRQDvvq9EuHAUJ4zsyVr8jdyh4aR77uAkt+aj200wFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pR0Y8DnxQhKejl3YPRKCpwlQOInF4gODOBdHFh1qRvA=;
 b=UvORJZ+7q6MuDRu2ViUM+SacGbHCO7YNxnGsrA/jE1o8xg3PEONgF+m302Re3EkG9Vl87a3wAF5f13JRZnH1OVobAMm0+CRHOqlC83g+eiXEokiHm1wG7jmTiYfwpPtiaVMzaq/3/6YqbrB3/R90XMZYCztpmGYSPBO94H0x32gQyk+w45Zk2iOgXedznzQYHXMMlEew1dP2pxcNfpX6sL/+AogGq6rFXhQSzhzZxJW+cRNwq7vXt6tsUz99LwvXm6qQV7HmQTlVTcawGB+P1bBhLmPE/C+LNuSx4ffswonQS015VaLXazLmlxs5htOM3bYjdhA+CVa/8Km7zIu2mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pR0Y8DnxQhKejl3YPRKCpwlQOInF4gODOBdHFh1qRvA=;
 b=z7GaYKAcA5PFhD9753cfWzyRtSj+tyzW70Ja282RIwlMe9bd2+RM3UOdvJOjWT/Cbyz4XVeVAm+uCBAGRvFHrioEhSA127cGzPvzmM3q7MCxChi/Dp+KT8FzxySmUssvCuk8dC1PSsfqnZj0fUhFOsmzPy5uRduW6/0cgS70IoM=
Received: from BN8PR04CA0047.namprd04.prod.outlook.com (2603:10b6:408:d4::21)
 by CH1PPFC908D89D1.namprd12.prod.outlook.com (2603:10b6:61f:fc00::623) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.21; Fri, 22 Aug
 2025 18:02:03 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:408:d4:cafe::dc) by BN8PR04CA0047.outlook.office365.com
 (2603:10b6:408:d4::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.17 via Frontend Transport; Fri,
 22 Aug 2025 18:02:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 18:02:02 +0000
Received: from [10.236.176.149] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 13:02:02 -0500
Message-ID: <5e63e9a9-f769-40f3-b206-46f413352350@amd.com>
Date: Fri, 22 Aug 2025 13:02:02 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 16/18] cxl/cache: Add cache device counting for CXL
 ports
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
 <20250812212921.9548-17-Benjamin.Cheatham@amd.com>
 <20250819163034.00006479@huawei.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20250819163034.00006479@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|CH1PPFC908D89D1:EE_
X-MS-Office365-Filtering-Correlation-Id: 20b3f349-d33d-4afb-5c6e-08dde1a5ff85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2tIWG5RVlhEMHlTRm80Wms4L3p6OHJEOEhjMlBqMnJ5Q0tETDVMSlo4b2dv?=
 =?utf-8?B?Y2h1R210N2wycXNFYVdISHIyR2Y2UDFQTk1kcmVGS2dxN0tqT01XMDgxVTBN?=
 =?utf-8?B?ME9RdEQrUGdNcnhveXA5VVVuZ3ZicG5rUUtuR1VUY3VFNFFObHZ0NTUvelJI?=
 =?utf-8?B?bi9XWldqSkk2bkpnMlZkbldxS0FBYU9ZVWowM280T1daSEdIclZJVEQ4N0NR?=
 =?utf-8?B?d3l4VU02UEwrakYxR1JJeUlyNUxjOS9ZRTEwZlFUYWo4bWYzdDZGdGJsR3V3?=
 =?utf-8?B?MFRhQldPRjZMTzlqQnpqUnpDNGQ5MVE4eGJZancvbXhtQno2Qkczbm9yTmJE?=
 =?utf-8?B?TW12YkNNc0pocDZsdmZJQWw0aEtuS0ZuUGk3ZktLbFpLdHN1QXorWWdkc1Fy?=
 =?utf-8?B?QzBpTDY2ZlNYRjlNc3hjK0NTMEFXZ1oyOVdTbWRTR2pCM1ZlZ3dpeldrVmhz?=
 =?utf-8?B?dU85TEhZaVZQdU42THhsZExMeXJ6WVdkN240ako2MWNKaXF3V2ZmTE53K0My?=
 =?utf-8?B?QXRXRzFMLzF5cXBnbnZ5aStQK2t0a3R2Nm1QZUpDZzd1OTY3bUUxVUF4ZVF4?=
 =?utf-8?B?S3ovK1RnS3NBWEEvMVkwcWdLNUpCQnNEd3JKUWZySk5VeUZqVFdvRk5HRlcz?=
 =?utf-8?B?U20wTnV1ZCtYcWFNeXJzQWZyWll1SzdranVCZmtVVDRxTm9uTFZVODVZdXZq?=
 =?utf-8?B?dFZJM2RuQ3QvZFlqL1IyOVJuZXJnMHdqTE1mYmFRalJxWS9BbnRSQzhGRGFI?=
 =?utf-8?B?QkxUam5oYWd6bFhZNHVyWVJFTHZFTTFpVXVVOUxYZnB2YTROZXBCSHhNQVV5?=
 =?utf-8?B?dVNWK3BhQjF0UkVpT1ZNaWRhS0xrTzhyd3U0cEErNVF0OXVUVjUra1J4NXRL?=
 =?utf-8?B?ODlxWGxrMUlFZEJOQ0ZmelI3SFpUTGZuTkJ5dk1valFJZmlJdlh6NWlEQVAy?=
 =?utf-8?B?RElhT3N4THpZMFMyV3JFWFF3bVVMWW5HcUhESEtoeXViYjUveUx1aU5lNGZ0?=
 =?utf-8?B?VGNIT2IrcHM5cGNTR2VnM0FNWnEyQVoxaE0wUEJQem9CMnpTazZDVStjNUYx?=
 =?utf-8?B?K3BPbi9oU0NaTDdhTEozZE1nelNPVEpQdW04a29zQm10dHl1YTdRTmsycFRj?=
 =?utf-8?B?QjVjdWZwclgzbHpEVkZ6OUtYNjlUOVBQRXlsUXZiQnlYUU11eDdiMXdhcDh4?=
 =?utf-8?B?MlF2eGVvS1ptWjB0S1ZKWHFsSTUybWdyRytzdkdzQythc2t6WFU3cE9BTnox?=
 =?utf-8?B?Qmd3QzVMaTF5ekJLMFhGelA3d3ZXdXJ2MEZPRnV3d2RjTFhzMUQ2UWhkYXdT?=
 =?utf-8?B?Z2oxQ0E3QjZRa0Y5MkRlT3ZxeTFJeDZ2WkQvd0M0WlpvekJQVFp1RWVNblpG?=
 =?utf-8?B?akZGb2pDMGwrNWlEUDZ2VDJSVmFUMWJHalU1c0d5TGgrRytjVFFNL3pQTFdz?=
 =?utf-8?B?RUJnNFMvM3R0MVpuYnBjY045bE53ZjBhTGkxUmNlbVJYTUdST3RsbURhb2hy?=
 =?utf-8?B?bkplaEtaaTFqbTc1cXVwL2Rzc2x0TDNmS1d5ZnplMElHSWdjRDZDck52R3ZB?=
 =?utf-8?B?Y0FNRFZHT2oxcTBldndUc28vMEQ1bllCRENCejZjblBsanJNWldIQWU0S0FM?=
 =?utf-8?B?bnl3bHl4dE95d1JEQWhSUUd6R3lrVXlCS2lrek5xVlJiVW84dmtHVHJZWmtq?=
 =?utf-8?B?MVJnQzZDVTVzWjk4RWgzVmM1bTZqdkpoOEJqN2ZiVzEwRGlBajJtbHJyQmdx?=
 =?utf-8?B?aFFPZ0poRS8zVzhyZWpUSDhSMzdsaGJJM05hRTlvV1BEcTRuZWh1bkdOclUz?=
 =?utf-8?B?U3JteVhFVFRhbnBXZUE0ZnlUQzJCZVlkNWRHajZ2R0lyMXNJMjlJVUdxMG91?=
 =?utf-8?B?TDlGNzhzL0x5eVVFeGJLTmUxeHpUOXRjdU95UGFUUnV0VDdkbnluYi9CKzJu?=
 =?utf-8?B?cjA0YWl5MC9hem4zUExZM0FnMVpObmpUdUNYZUJuOXlhZldUNVVHT0JRRXI1?=
 =?utf-8?B?dC9iT2RPWEZJMm0zL0IvZnM4TVpaOTZtM1hxZUR4Slp2Nm9iSjd5bWw4T29k?=
 =?utf-8?Q?RSS6eL?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 18:02:02.8839
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20b3f349-d33d-4afb-5c6e-08dde1a5ff85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC908D89D1



On 8/19/2025 10:30 AM, Jonathan Cameron wrote:
> On Tue, 12 Aug 2025 16:29:19 -0500
> Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:
> 
>> Having more than one CXL.cache enabled device under a port requires CXL
>> cache id capabilities (CXL 3.2 8.2.4.28/29).
>>
>> Add tracking of how many cache devices are under a port. If the required
>> capabilities are absent and more than one device is enabled under the
>> port, fail allocation of a cache id.
>>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> 
> ...
> 
>>  
>> +static void cxl_deactivate_cache(void *data)
>> +{
>> +	struct cxl_cachedev *cxlcd = data;
>> +	struct cxl_port *port = cxlcd->endpoint;
>> +
>> +	for (port = cxlcd->endpoint; port && !is_cxl_root(port);
>> +	     port = parent_port_of(port)) {
>> +		scoped_guard(device, &port->dev) {
> 
> I think you need to check this succeeded if the aim is to ensure
> that port didn't go away before this decrement.
> It might have gone away just before we tried to take the guard.
> 

I see your point here, I'll change it. I don't think I was even considering
if the port still existed, this was just for concurrent access if multiple devices were
leaving at once.

>> +			port->cache_devs--;
>> +		}
>> +	}
>> +}
>> +
>>  static int devm_cxl_cachedev_allocate_cache_id(struct cxl_cachedev *cxlcd)
>>  {
>>  	struct cxl_port *endpoint = cxlcd->endpoint, *port;
>> @@ -167,9 +176,17 @@ static int devm_cxl_cachedev_allocate_cache_id(struct cxl_cachedev *cxlcd)
>>  		rc = cxl_dport_program_cache_idd(dport, cxlcd);
>>  		if (rc)
>>  			return rc;
>> +
>> +		port->cache_devs++;
>>  	}
>>  
>> -	return 0;
>> +	if (!is_cxl_root(port)) {
>> +		cxl_deactivate_cache(cxlcd);
>> +		return -ENODEV;
>> +	}
>> +
>> +	return devm_add_action_or_reset(&cxlcd->dev, cxl_deactivate_cache,
>> +					cxlcd);
>>  }
>>  
>>  static int find_snoop_gid(struct cxl_cachedev *cxlcd, u32 *gid)
>> @@ -239,7 +256,6 @@ static int cxl_cache_probe(struct device *dev)
>>  	if (rc)
>>  		return rc;
>>  
>> -
> 
> No comment. :)
> 
>>  	return devm_cxl_cachedev_allocate_cache_id(cxlcd);
>>  }
>>  

