Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DBA20EB
	for <linux-cxl@vger.kernel.org>; Fri, 22 Aug 2025 18:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755885665; cv=fail; b=axFTaZzhRaeB3qiuAnVj6O9AvZu0U4gFZVtdxsZk7llcIqBCOb+fIahTeB+mK7MBQHbim66Idkuw2yhVdnvtV6hvHBGj6QCpIDWG499UuXP7e25wwlKuE2nKOuXO2Uv3dA0wSGKworGH8BmRah3CfM9DcEJ6LBjPFTuGTgfiN8A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755885665; c=relaxed/simple;
	bh=ILjkx3iuuy9bdSoLgySudxNKoBCyURvjjnAMhrvHsMw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Jv690CQivlsDQKAr9/QREe4V6fYPvnfjPb9BlHTaZPPtx2ZxfMnrJy81oIWjtto0OruuQrsVEO/L7wODaC8A/7oZKL25V7zWW86v6eV0gSF2ihFDFv496DB/YMaKg+ffE5y+wFum26U1Xp/kROC7XV6/kFY3AMSkbxA8smwu0/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VBLW6AlG; arc=fail smtp.client-ip=40.107.236.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VBLW6AlG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I5egnpbzkb64jfxDQIlXfOWgfbil2Ma6FoHmJhQ1UUnTFdmQLgKpIxV8mUAT3Z+8WVXdTtCNJS03xm799FjXGpNDOepN2coJjMe1Wqvg22wSvm/XnoZoAjp3fOnGBqZxCQDYwUD/BJ2VhU6JlkY1p7BLhXJM2AFFtvP997IntH5E1G989eU2FhbQyvr5EYftDAMDjt3Ei1y/DJS+RMFKbZDxuwBK0CvWsgkfwFs+jKSWL09aIwLoGoEaBbnl9merRBOHaOwHBCVumw9cHKT1iuIjpHyfHnZjFAELmsTaiVpUD9Y1rxbOEmIGpkqDbLW1wVv9asSPp0KnuQ1YOF3aAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfJGwfbLuavnsEhTkwHmbgKstJF/PCrTLYBbdO2+hWY=;
 b=DGgRtMCcmEqu1cFxvH9WRkDPUvYY+tP9eoNXAIlYjI3a8ZfCJfzzg9cPjvw2q/fHEQzGFix7Ic79CR6opzY+QN23rcAKK47hoVIjG5nh8qjI25QYgN7OCda5vmLegq0JEYEOLmRKa9QfTVX6rLc5rnJh/+Jk3jlvvXDCNe7Cn4Y4wdfSRxSZFQ6o12wQfN+r0ABdpAh6Xjd+TrsLe9HZaZqDYHhItmkYklEQGl2p5HXDYTsJ0iBfkrk7zEP3xcW5O1SU5gVbMHbFcAY9mm4DfgjL8EQrLCwOAH+J62Arckec8ho99Bin2lxV2vQ/kozFA8VohFGcghyvCyx5JnA/+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SfJGwfbLuavnsEhTkwHmbgKstJF/PCrTLYBbdO2+hWY=;
 b=VBLW6AlGsvwv4UmmZsQ8hD4TP7SOUSh+y1BCEQ338tGYVLgivCg9EW0d4MvVRdi1J6YesLdGoGqC47D9HJ3ibzwB5uIG0yrhHicwX6KlRKEgt+oNO73T5tPpZiQ3KvoKHWva+SMQsi9necGAKuyyBH5NTH2i9SoqyqUojbDUeUo=
Received: from BLAPR03CA0121.namprd03.prod.outlook.com (2603:10b6:208:32e::6)
 by MW6PR12MB8865.namprd12.prod.outlook.com (2603:10b6:303:23b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.18; Fri, 22 Aug
 2025 18:01:00 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::99) by BLAPR03CA0121.outlook.office365.com
 (2603:10b6:208:32e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.19 via Frontend Transport; Fri,
 22 Aug 2025 18:00:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Fri, 22 Aug 2025 18:00:59 +0000
Received: from [10.236.176.149] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 22 Aug
 2025 13:00:57 -0500
Message-ID: <c2ab5adf-a806-4d41-86a6-60d576012f01@amd.com>
Date: Fri, 22 Aug 2025 13:00:57 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 06/18] cxl/port, mem: Make adding an endpoint device
 type agnostic
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC: <linux-cxl@vger.kernel.org>
References: <20250812212921.9548-1-Benjamin.Cheatham@amd.com>
 <20250812212921.9548-7-Benjamin.Cheatham@amd.com>
 <20250819125330.00006c4f@huawei.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <20250819125330.00006c4f@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|MW6PR12MB8865:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d478c0b-89c9-44ff-f20d-08dde1a5d992
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SkVCOFpkRTB3d290YTlRdldkVXNmRXB4WlFRTlRBU1J0eHA5UFNhTEZsSno0?=
 =?utf-8?B?MzNuRVUyTnZuRmtUbEduVjNBQlJPWWpHckhZNHpYLzJkdDNyenFlT0FReXdj?=
 =?utf-8?B?REdPMWFmRXd6SzNyT25CeVR0RmhVVFFZTXdzVFpDdTN3SWRXMDAxN1RLc2Fn?=
 =?utf-8?B?Rzltck01b1IwcjdETVRHckEwYkdXMzBrdFZUeTd1Vlo5ZXVSOW5kQU5mTVBV?=
 =?utf-8?B?QnJOaU5TTmp5ODgyVWNqcDZ2UURmMXZ2SXNZL3VrazY3eENNQnk4bnBTNXdl?=
 =?utf-8?B?UFBnVEVTL0Z2a3FtY0JTTWRvMTZRb2xEVi9KYUJZNTJTdjJEUVgzU2ZNaDF3?=
 =?utf-8?B?M3hkYU1mQTU5K2xBakN4anlmM0NWUSs5bmNaekEwcE9PVnN4SkllOWJxRENj?=
 =?utf-8?B?OTJLMjlwd0xuWnN0OGY2ampnaVlpRFNtdSt4YXBvb244SW4wdmxzeWF6YkRO?=
 =?utf-8?B?NG5ZaWo2eUdHWjg0Ry92ZDhnQmF3UzhtNXVoazA5MjNjczNlYmpBU2JQbDIv?=
 =?utf-8?B?VzViRUxpMzNDNk1lK2daRTVEYVZDd1BrSTIwQnJra3lhcjJEWE5VQTlPTjFr?=
 =?utf-8?B?UFdOcU5IY1Fqcy9NVXdkT3ltbE1qQS9ISlEyblFBb2owQ0JCdko3elRtdXBE?=
 =?utf-8?B?dE12UnVIblZnOUs3TEhWVXplaTROQUdEaHNlSzNwQmtqNzJWN3cwVVNmeVFt?=
 =?utf-8?B?eDlBVUtoc0pIQ3c3UHJqZ211VS9BMTRqaDhUcmEwM3FjSGZiWjRPMDVIbXo2?=
 =?utf-8?B?M3R6ZnNycTlzSUtvd21sMGRuK3lhZXpSazZ5Um9ES3Z2RXMzMDkyQXpLR1hu?=
 =?utf-8?B?QTZWblZpT2NmVG52OVptaFdpdTVuemc5MEViOXNLYnYxd1VrQUh5alNoQjlv?=
 =?utf-8?B?RC91OVoxcThDb1E2dnZSVGtrVVg2RGl1Y1krQ3J5QUVqaXllejJyaExLRWJP?=
 =?utf-8?B?K1lXOXhXOC9Wc1RBcWtFUjB3UG9McngreEpWb250MUR6Ym1Ia3k3SFdZV29X?=
 =?utf-8?B?ZmllQUVDWVN1T1ZOWVVqT1ZXWStoRkg3UVM2NTNyUEJ6ZGlYUndIL21kQVhR?=
 =?utf-8?B?c25rZEc1VUJRSGRtbVJ2aEpMY2NhWWwzU2lRcnc0OThFa1FETHNsT0pweGdy?=
 =?utf-8?B?VFpvWU9VZHJiQzlyejBLd0lHR0dNT25qaW13M25mellkc2wxMFFEcjFHQ3Q5?=
 =?utf-8?B?VS9ueWJsanZvRWNFb01ZSHRLRnB1LzF1WTJsZWJGY0ptR3pjWnBZQU9ZM3lK?=
 =?utf-8?B?ajNyY1F1NHVkengvVVBSNi9EUGFTMXB0c082SGRrSnE2KzJsL05VYUNMTWln?=
 =?utf-8?B?YnZVQkJBRHArVnlzNCs5U3lhUXRWTkNzVEo2eVhyTEphdWZtdzZpQjJ6UDIy?=
 =?utf-8?B?ZkxBY0RMZDN6UXc4VWV3d0RUZGZKTGRObXNJZHJYQ1Rnb1VzdW8vUHEvU0N6?=
 =?utf-8?B?U1Z3Y2EvcWdycmhhc0JlSHZuWTRETWZaai80OXVSWHJ2dnVaVnlXVGluZmdm?=
 =?utf-8?B?RkhPVTdzcDB2VHltbG1UcytiYnhKbFJNYmVsOURjc2p0Mk9LSkx4SDdITUoy?=
 =?utf-8?B?WDBpR3U2alpLRGl1c3ExT2phYnVpYXFHYlJQLzhKVUFneEN3ZStreC91VEhN?=
 =?utf-8?B?bW9YWnAwcThPcHN0cy9DN3BZS1AvZHNPcVRaM2VXT3NnbldZRUU5eE4zTHA3?=
 =?utf-8?B?S0tmZ0Z0MzRCMGs1aG5DakFQSmJRVjFzV1RyZmNTM2pNS2JGV3l0K3JpTHFn?=
 =?utf-8?B?Mmg2aWlaRUh6OU9MZ2F0ald0RG5zVnpMWTl2MzRib1MxRHRLeWRXeFRFWS9C?=
 =?utf-8?B?TDFxZXhyV0R2a3RLSnFmcHNzNDBVeDk3ZlRCS0E1VXZLb3VOb2UzOFAwc1Zn?=
 =?utf-8?B?ZGd0eGFLWldiZnc3UjVGZmNrbTVkanZuZ1JrTGpVZ0ZORVVnZnY1V1hRVDRx?=
 =?utf-8?B?aTYyNzdkTDMvT1daZ0lqZ2FqM2JSOUt1WjV3aktNNjNKYkJYUTZaRGUwVjc3?=
 =?utf-8?B?WHZXajVSMjdWWGlNdzIwUEt5V3lKYUhFeEc1VkxNbnZJT0pUWFhwa1QvS2dn?=
 =?utf-8?Q?oyvVay?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 18:00:59.2194
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d478c0b-89c9-44ff-f20d-08dde1a5d992
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8865



On 8/19/2025 6:53 AM, Jonathan Cameron wrote:
> On Tue, 12 Aug 2025 16:29:09 -0500
> Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:
> 
>> Change devm_cxl_enumerate_ports() and devm_cxl_add_endpoint() to take a
>> generic struct device * instead of struct cxl_memdev in preparation of
>> adding cache devices to the port hierarchy.
>>
>> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
> 
>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>> index cdac7bfa2289..c615e6c4ee60 100644
>> --- a/drivers/cxl/mem.c
>> +++ b/drivers/cxl/mem.c
>> @@ -104,9 +104,11 @@ static int cxl_mem_probe(struct device *dev)
>>  	if (rc)
>>  		return rc;
>>  
>> -	rc = devm_cxl_enumerate_ports(cxlmd);
>> -	if (rc)
>> +	rc = devm_cxl_enumerate_ports(&cxlmd->dev);
>> +	if (rc) {
> Not immediately obvious to me why this needs to be set.  Perhaps a comment?

It's based on the changes Dan made on the 6.18 probe order branch. It's a change made for type 2
drivers to get more fine-grained error reporting when probe fails IIRC.

I don't mind adding a comment though.

>> +		cxlmd->endpoint = ERR_PTR(rc);
>>  		return rc;
>> +	}
>>  
>>  	struct cxl_port *parent_port __free(put_cxl_port) =
>>  		cxl_dev_find_port(&cxlmd->dev, &dport);
>> @@ -138,7 +140,7 @@ static int cxl_mem_probe(struct device *dev)
>>  			return -ENXIO;
>>  		}
>>  
>> -		rc = devm_cxl_add_endpoint(endpoint_parent, cxlmd, dport);
>> +		rc = devm_cxl_add_endpoint(endpoint_parent, &cxlmd->dev, dport);
>>  		if (rc)
>>  			return rc;
>>  	}
> 
> 

