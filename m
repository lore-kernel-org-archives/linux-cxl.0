Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1483619E973;
	Thu,  3 Oct 2024 14:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727965703; cv=fail; b=k0zR+hDjQurH3UOObiQNCXX2+dLLim1J7ypN5jiWAgoFVMAMIZZCdC230X4T69MU4eJihTfoEYHpc/UV+0Ta/FD2zgSzSeAZ6Wp2Tq3icY/gfRWvbwq9piSwsymCv2yFtEAQBFdaz/uWPDtlTAHQApKRgA0EtLoEwpj3IzFDwGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727965703; c=relaxed/simple;
	bh=nlZpId1EWjsM0XsXIGjt8fBlFzpJnGx9e+h2+vRdHek=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gJNNgqRYGIP8q+aMgu8kvwlYUVGgbsdQ8/AJmpv+pOwTCrvYL8C5HOiZ73lru3Yc5a0LAnGz83NrVSDJ2DE7rJMHhrfar05K4IuYspKyYBNGBshjkBMvpDfTrNZ/AJssUxtms81donjK6HqELfmwu+iSHzffuIL1IXtsDKK2dUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g57nOkTN; arc=fail smtp.client-ip=40.107.94.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g57nOkTN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yGq1VQmFIrtq2Lek1Kb/5Hxsgr76/CF3Qf2F5Rji8iJZYCfpvvL6brYtZXCMMj3h9zNMI3iRqrejJzyZ+lr1sg2ZK5SyZhXipEtS3bKZAb0d10MIMjrjAN3CifYVEnZsWTTfMX7zMJK2qCDxpL7WM7qCyNTpDp6FPeOLPKyOy8QXJ3VlKaXLcAl5ClDdPYtL7G6DBeMMRhI6F3cYYi7xhEosq75DOYTHnbKx8tQbuHLZaLB/yFQOggRQzXlLso5DpCwU0+O2hkTWYzoZJgCH2ctw2xEWcMcrlCLsaPzUg6/8Xu3ebnI36SQc0bDy295m4D9XBWBTroB2RtOAuyuIPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fFkRZrtfCBZQsVHZaQ561m5PXvIo5auSi1R12ILwlvg=;
 b=JoQaG72Ou7887xhQTKwzDInAPQhkCsnjurI/QcUWBD4rZd4YpTdUZB9z5qSU7olNQdIoXViVuuITihI/T6s/s4tYZd7GhVvcWQJvTY+1lZ1XyWUqYhBM08HF7Wedk8hjgixmwC46yRzqCblIsv328ayS14bksfrXdgvYlaSQPzbCftt1qTP2ciBk56zHEiLgBQLX5NIs8+IuxmQlKdSzvDt3g/t+K3ycFLbeT/n/8o62pTIAsMu6nW6Mz2TriE2HXk4YyHrcScrU0qYr5r7H7zvyXYwTH82LDm53uOml59NUHp6dEtJF6fkw1CqhA0g3VSeviUgZUlkjNLIBcnQCGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fFkRZrtfCBZQsVHZaQ561m5PXvIo5auSi1R12ILwlvg=;
 b=g57nOkTNyXk3NDdCMc+Nor92NoaPGRZKiGqYL6DcniS1lIrw4RTs1ytMVyue8yuppn4Gx5r1NACmtkVUKi6I1hFpjUvAFNS7WPTkOHySzTqlDBd7oVKhjBevvkPhT4f4rIJSjthQyDf1aha/2MowwvF1/F3/JvesrdrB5d93RqU=
Received: from SJ0PR03CA0207.namprd03.prod.outlook.com (2603:10b6:a03:2ef::32)
 by DS0PR12MB7584.namprd12.prod.outlook.com (2603:10b6:8:13b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 14:28:17 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::c1) by SJ0PR03CA0207.outlook.office365.com
 (2603:10b6:a03:2ef::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18 via Frontend
 Transport; Thu, 3 Oct 2024 14:28:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Thu, 3 Oct 2024 14:28:16 +0000
Received: from [10.254.109.133] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 3 Oct
 2024 09:28:11 -0500
Message-ID: <9d6fc7c9-e94e-48e2-8c41-b6bbf5e1e3cd@amd.com>
Date: Thu, 3 Oct 2024 09:28:07 -0500
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: <benjamin.cheatham@amd.com>
Subject: Re: [RFC 4/5] cxl: Set type of region to that of the first endpoint
To: "Huang, Ying" <ying.huang@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Alejandro Lucero
	<alucerop@amd.com>, Dan Williams <dan.j.williams@intel.com>, Dave Jiang
	<dave.jiang@intel.com>
References: <20240925024647.46735-1-ying.huang@intel.com>
 <20240925024647.46735-5-ying.huang@intel.com>
 <85a73846-4d8d-4f28-b748-24904b749bca@amd.com>
 <87a5fmng5z.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Language: en-US
From: Ben Cheatham <benjamin.cheatham@amd.com>
In-Reply-To: <87a5fmng5z.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|DS0PR12MB7584:EE_
X-MS-Office365-Filtering-Correlation-Id: 3112c78b-9c88-41cc-d286-08dce3b79eed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OVZQeG1pVlNadUkvMFJYVkp0NUpnYUpBS0NRSmkyWE5rVG5DbFJIeGFOYUVR?=
 =?utf-8?B?Vkp3cytOMkNtb3F3Tlg2K3c1ZjA0bDdBNUNzTXJjVGVyMzEzSmIxUVFxOWNi?=
 =?utf-8?B?S0tmVHNYdlBESDlkV3ErblhpcWV3T0xCTG80SmZ5MC80eWdzSFgvaEJQb1pK?=
 =?utf-8?B?OERzN2o4K1NPcHVpRXd0QUJXaHROeTdoSzJHKzFBMjdIM0toNWFOTmtMd0dP?=
 =?utf-8?B?c1g3L0psWTJ3eVhOVTk2eEN6REdMWGd2MTZ3bjlzU3pxeWRjdmwzdjFiVFBh?=
 =?utf-8?B?bU5TZmlWN0VSei9NdXl6S1RlMUlFVHU3WlR6bVVkbHFnUnpCdTZzNVR1c1JD?=
 =?utf-8?B?NFRPMHplMitRTWNFM3RUWDhQYTA4YW0yTGZJVC9mWkxVY0hMYUVmbkNoTzVF?=
 =?utf-8?B?SGVPV0pnRmNUeXIrRlVYTElNenAvU1dicDFPYVJkMjlPOGV0WDZQYlBSK21h?=
 =?utf-8?B?ZWczT2NCUDk5WEZqYzlSUXpHWmhKTGt3YWs3U1MvQ0Qrb3JqclNCL2dLUGYy?=
 =?utf-8?B?VTU3bDFjaC9KODluc1c1NkU4bG5nd3p6SmlyUEdJTDhtVC9GeFJuT2FVZXpV?=
 =?utf-8?B?Q1RITGJpVS9lbTZuUU80ZGlkTUdNb0xTdUJReGNBQmVReFU4WGFPeU5iV1ZV?=
 =?utf-8?B?QVVCSmg5K3l3b3FYQ1d3eGlrdzFCaE9VVzc2Z3ZDUjV2bmM0eW5sLytFSDZv?=
 =?utf-8?B?cTBOYmlCZ1VoRDVON3dzVW5aMWlMWWs0YkpvaVVHS2ZhdWZKN0E1WU0vNVcx?=
 =?utf-8?B?c2s0anZ6KzBRVnpHR1YrYVJpbVV4MEU3cjUvQ3NFR2RMZGZZbC80SzVNTzN5?=
 =?utf-8?B?UTNydDZZNjYrbDhhbkZJT2hmdTBSUlpXTWxqNHNBR3R3VnRVT1FjTkkzdzVt?=
 =?utf-8?B?RTV4TEpLTGt4MmZrZUYySS8rNnlobEg4UE1HZUpmVXVqRkYxVWttbVdlMk9M?=
 =?utf-8?B?eGNDanh6QnhLb2I1UXlGc2s5N0V0d3ZmS1NYdGRiNWFiM0pzemhRZFduaGdG?=
 =?utf-8?B?bTF1VlUwcndQbUoyeUVCR2ZYSkhBc0IzbUdtd29UVjlWak9weVkyejcxdXYr?=
 =?utf-8?B?ZE9NS1RUa3pvU0hIZWtyNDYzb0pWRWVYREZtUHY5YytWMms5WllQV2hsbWNY?=
 =?utf-8?B?UDdnWWpiZGsvVStKYlhWK3djaUsySUE2NWlldUpFdWhmSWp4dE1zVVluaU54?=
 =?utf-8?B?VVNqaEwwbDhFNndzVFlRN2hNeEpBdHh2MWhaM3d3NGJmMkx0VlBDVjRuM214?=
 =?utf-8?B?a2taOVNlUVNjS3ljalpUTkJhWmY2dk0yOXVWV1ZrTDQzTkpidS9LOUdsZnBz?=
 =?utf-8?B?RUwwZExzMzNHV1FMelhzdmpBbmMzRFlYbTdxd1FnTjdBcnUxM01GYjUxRGFo?=
 =?utf-8?B?YUdrcVY0RURqWUNBZ3JiTzhuQzV4NkM2cVJ2QTQ2d2dxWEJqZlhzOExCdFEw?=
 =?utf-8?B?ZUxUaVV3dStmT1NkWllRNjBtZytKMU5iWHdOOVRNbzNzYnVnbFN6REthUm41?=
 =?utf-8?B?ZU9WUlRlVWdGSy9xcUNDN2tyRTVVYXVUYWRKaE9hTDdEL3RvWDFsVzBBOHFB?=
 =?utf-8?B?OGRiaU9PYjd6aVgrWHpFeDR2SUhiVEQ1NXg3UTJNNmZaNGJKNFc0NzUySno4?=
 =?utf-8?B?dEUvNmd0d0REdnZhRWRlRGdzM1FDbnZhbWsvME02QU8wOUNtWGNOVGtFN1Q0?=
 =?utf-8?B?MzdUeEs4WlRkVlp1Y000K3lEYzNpL2syTWhyMkpVajA3M3dWRWdqWnlCRDU2?=
 =?utf-8?B?RUFLclF4aWtBTzZzUmp6b2pPbkcwNzVOUFhmbWVqeGxkSWF5YmhtaDJaZUpU?=
 =?utf-8?Q?QAb0JZa0+M1wHaxDAVPseFJgdG07tx2K1KF48=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 14:28:16.2799
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3112c78b-9c88-41cc-d286-08dce3b79eed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7584

On 10/2/24 8:12 PM, Huang, Ying wrote:
> Hi, Ben,
> 
> Ben Cheatham <benjamin.cheatham@amd.com> writes:
> 
>> On 9/24/24 9:46 PM, Huang Ying wrote:
> 
> [snip]
> 
>>> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
>>> index 2dee78e9b90c..5633b7316cb3 100644
>>> --- a/drivers/cxl/core/port.c
>>> +++ b/drivers/cxl/core/port.c
>>> @@ -139,6 +139,8 @@ static ssize_t target_type_show(struct device *dev,
>>>  		return sysfs_emit(buf, "accelerator\n");
>>>  	case CXL_DECODER_EXPANDER:
>>>  		return sysfs_emit(buf, "expander\n");
>>> +	default:
>>> +		break;
>>
>> You can drop this imo. It doesn't change anything functionally considering
>> the break is immediately followed by a return.
> 
> Sorry, I cannot do that.  Otherwise, there will be build error.
> 
I thought that might be the case, but figured I'd suggest it anyway. Oh well!

Thanks,
Ben

>> Thanks,
>> Ben
>>
>>>  	}
>>>  	return -ENXIO;
>>>  }
> 
> [snip]
> 
> --
> Best Regards,
> Huang, Ying

