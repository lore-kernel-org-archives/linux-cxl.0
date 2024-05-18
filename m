Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C841C686
	for <linux-cxl@vger.kernel.org>; Sat, 18 May 2024 09:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716026390; cv=fail; b=X+la2sG6z2wzoZgXputDBliEhwBuLjtbc9NLVgm8gZZPmbIUGMe2vqlVmYajXESRnG+OKmZfFLW8vIHmDTvWQd/4Kq3nxLqExVdeLO6QNaSw4fwH/IhkiTzxtLXeO6huHzbMY+edH1X/w0+2ocrT/KsFP79eroondlWOkLY08QY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716026390; c=relaxed/simple;
	bh=50DDT0SLh2bxyAxLjiFrlPHMy57/siEDMOuIJA0KAfA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AXCXHXzhb87KI5qDJVS8OciWtzbEXiazoaihQZbKceXyhrLkD8mzLdQZff2MDSXKl91pUj8IIRNxegjvmMZ7+9gMy3J7oBAU+S3wNYt56gP37h8Hi8R1m/KpmMu9d8qeeAz/vVQtBfv86HgGtPWY8Hu1MFswJJxtB9r9dHwVDkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4TLaZwBX; arc=fail smtp.client-ip=40.107.236.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4TLaZwBX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqyywfmKM9MB5rLN0AHCLjfkW2clPaIbdWJMJw326v9zgHwZoCZNt0q0rmP+acJzmcIiizH8ZTPihGaHRKyWfVUv1myofE7NlcQQPm5MVP+B5mMyPCXnGobopBO1RIJf+RzJ7xuROvJHvoqSf/bikscPfCw7WGatTyuE5CdN9oDR0sKxmCl+DJOantThMH8gllK5f+NO5PzIQJGOC/WmWhF3Ono9I1h3I4rtWSiss6SIUhFugLTJIgRQca67NwutMr6Y0Zaj+H5jyfbXBz+fdSSJOtP+s5t1j6qU/Og4rKToLFxdOhIRbvNccEAGgjI7b1PAYDQsHUB/VxUgQKgBEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZRDynFs3EQhgSW71hFTgm7r7HmVNGG9pUCwBylJZ1Mw=;
 b=gXzjfqO2cRp5bOJHtOWrqPsT6Ay6w3Vf+FuJkN3OAgZ89UtcFDXB127I+qw2X5PnUvNuhULZD+rLGrQOaGg1Q681c6AYQLJgxP+a1Pv/fbcvcA+jlfLHCJ/3c/g/E4LIQV8LF/vSWuAIBxG9AR2X0rLb8HrPMaTbzS5Q/spxko7k7Z1jpa4IbaA5Be/VtTQQppPkjNZ6CrZCsvJWPGltGcK9U7fZY7u2o818ZxKK7UW2QBpnz4kjitzK0dbnN7pi/rb/PJoS6zZsL4/pDUqSIb+51Py7l9kE0rwiIpywnS34iLsnmoUXgOgE8cSN3P39RTtalzoBAmLVw9su8MVqzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZRDynFs3EQhgSW71hFTgm7r7HmVNGG9pUCwBylJZ1Mw=;
 b=4TLaZwBXHOFmjuHd50pqn51BY8B78DkG7+vjVx3zq9TDbUy+S9SRjZ9f/wa/NpQhQn8aZe8JmkHKKrHRWZwu9POzQukX3rQdkGJuIR3pkfR2QTNKxSJq24ckxsjjMWsSv+wasUIDAfUJsVlIp1HkgawZAb7wouLqNyKFsu2OW3Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH8PR12MB6842.namprd12.prod.outlook.com (2603:10b6:510:1c9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.30; Sat, 18 May
 2024 09:59:45 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.7587.028; Sat, 18 May 2024
 09:59:44 +0000
Message-ID: <0a5e5366-92ef-d608-43ab-e0756e0458c8@amd.com>
Date: Sat, 18 May 2024 10:59:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 00/13] RFC: add Type2 device support
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
 pieter.jansen-van-vuuren@amd.com, richard.hughes@amd.com,
 dinan.gunawardena@amd.com
Cc: Alejandro Lucero <alejandro.lucero-palau@amd.com>
References: <20240516081202.27023-1-alucerop@amd.com>
 <66469ff1b8fbc_2c2629427@dwillia2-xfh.jf.intel.com.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <66469ff1b8fbc_2c2629427@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P123CA0101.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::16) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH8PR12MB6842:EE_
X-MS-Office365-Filtering-Correlation-Id: d5f0f998-97e5-422f-57c3-08dc77213e84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2xOZzhIL0RsUVFWRmlQaFVsVWMrdlRyNkZJWXRsYUlRV0h6Y1Q4TndRMkhD?=
 =?utf-8?B?VmYzTmJJeTVEdE9SKy9vTnZkcEhyUDJBVmYweFZMdzFKNkZDM0FVb3FsY1lw?=
 =?utf-8?B?L08xMUhweWlCQXlDSGRYZTNTdFZadUxGWDZ5M2s5K0hLT05LSmxLMWxabzZH?=
 =?utf-8?B?RXdZcG1EU2tPbUNTcDlOTU4xd1pPUWtrd25UTjlQdjIyR1BGVFhCVmxkYk5D?=
 =?utf-8?B?MDZmMzFxM3B0bnd2VkJKc0NoZlVvU0NreS8wREdMM0hURkIya2t0MUxNcWxW?=
 =?utf-8?B?WHhIMGx3UkMyak0wdCtoYTgrcmVMSUYzT204YjVrS0p2Mlkvd21PN2tQNHMv?=
 =?utf-8?B?bHVYYU4xbHZUejRUcVZRUlAyZEduZWNBODFNZkNvUkg4di9IcWlvS3dvNDVk?=
 =?utf-8?B?ckpyczFwZ2YzQ0V3TkdJdE51SHdCNUF5NWtkVGljTSt4L3Y3WkJ0VlBMUFNG?=
 =?utf-8?B?cFNWcEhiNkU2Qm9mQ016blpaTEFBRjNLQUREcU1vS0NycWdpazk5bmh1OW9y?=
 =?utf-8?B?aXkwVEtDbE0reUk0NjR6c2ZORzRPM3VRUjRsTzBXTTdYMHVva3JGUVV4RVpo?=
 =?utf-8?B?OTg1L1Y2ZEVYbTZBclVCT0NEYWcxWXUvbFZoTFlOMlNlcmVhNG96LzV1Y3pV?=
 =?utf-8?B?aHhxcWJxcktYdUo3L05PdGhPM1o2eTdhUDl4VEk0b09SQVIzcTk5d3lMUFcy?=
 =?utf-8?B?ajRFQ2t0UHJ5R2ZBY0tzeWtvU3VGa2w0dXlWbU1TeWRQZW5ObjNNVHloMDF6?=
 =?utf-8?B?c1BxeGk5WnU4TlQ5TzZ2aGxtVUIyR0R4YXRSSHo5T3hKQlNkZFE5dXFMd2No?=
 =?utf-8?B?bW84cWxodzAyUUthVU5USjk0WUxvQXg4dStpeXdEN0RkVmFMYlFvU0g0QVNx?=
 =?utf-8?B?ckpna2k1b0JSQ1FDV3RPdFlBcnUvT2R4cUpYRHJxVFMxSUdUdSs1K29lcEJK?=
 =?utf-8?B?ZEI2bXF2UU94dTgwVzZuWWw5MVo1by9peGVwQVgxdTJTcEtCZWM1SVA2L2FZ?=
 =?utf-8?B?MWxWMkppRllJMHRsU2o1STdrUTFOekErbUkyVmhFdTdCa0o3N0RJNXl0bCty?=
 =?utf-8?B?b09kejdvb056Mk9PQm1UeGlHNkxScWc5L2RYczR0b2VuQzVqS01yWGlQMXVz?=
 =?utf-8?B?SnRXbkNNYm1PVTZPcExyd3BIcGI2QjVRNHdFUHQxWk0vQ3dvckJqejF3ejNw?=
 =?utf-8?B?YmJHZ3hBb1duR0Z6OGlESTNwZ0ZLMHVqNXpNN0hvNEhPTUovd1BUSmdmay9B?=
 =?utf-8?B?YmlzcTh2Q0RrMWZZS21lanljelZqbnk1NHVibVlhaHlCMjhoOWpFbDhQNlF1?=
 =?utf-8?B?NkdiSlpIK3BlUGV0alRlc3NaM0JIWjJMRlZyaHQ0N3B1Z1pIYk43NlBmQzRE?=
 =?utf-8?B?VXh0QVVvbjhxNjE4bnhmUGEvbDJYWjc5UTlaa2VNM1J3ZS9QZjlTdXp1MlI2?=
 =?utf-8?B?dXAvdzBNQ0tDNkdpNnZLelBoWStwbXRNaks0ZmgvTjlSSjlQYnRGMGV2Zk4v?=
 =?utf-8?B?L0Q3eUdGNlVmZHJuZlNMeWlTYlBlL1BpWjdJZ1ozenJDODlmZEtvRE9YNjcx?=
 =?utf-8?B?UStOWUdlWFJsVGhXSHJ3TnZIYnZpQ3JLYVM5aVd4blJzYm9QQzg2RVdoemtP?=
 =?utf-8?Q?S5/zvE3uUXx1ro74QsmeBTWvSjgPZXeuB4YFZcpABy4A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHh3VXZZVHk4Z0pkOTJIa3lvZ094cDNESUNCNFI0NER0VmRIWXBDZmRMY1JE?=
 =?utf-8?B?Q1FFVHlGVDV6UFhFc3ZESm9lMjFLdDNHYXl6SUd2UjVPeDhjWVZYTEF0eVlJ?=
 =?utf-8?B?ODUrdUUwR1E5Y21qa3EybkVvK1JabUtzZ3dVbU1HcC9NczFGekZHeTF5QWNw?=
 =?utf-8?B?NVFiUDVuekFFa2J0a2pNK2Vhc1VPS25DbEtFdlpGdGRZSWp1UDgrYjJtNnV4?=
 =?utf-8?B?dHpMS3JZamh3eTRlSkFvZmREek9aSGFkOG9JTXM2ZUhsWGhPdElkZGh3WHRI?=
 =?utf-8?B?Ni9Xb2hJaGxRZVdPc0tEUTZISy9WQVVxei9kMDlXbTVlQy9QZVZQMDFGVXox?=
 =?utf-8?B?a3R4czNDNm1wNzhRalpxMkU5UktTT3p4SWV3Mi9KNTF6aEdCOHZ2bVVFMEE5?=
 =?utf-8?B?R0VTWk5VTDEvNHRiNDhrMUMvRzlSaHVzb1pTU2VacnVYQVdaTUxOZVlXQlV0?=
 =?utf-8?B?UFhVaGc3c3hidnhPMDZEQ1NZT21DcnN2K2RvTmQ3ZHZ0dlJkRFo5Wi9UcXpZ?=
 =?utf-8?B?YzllY1NHMm5YYy9sQzV3UC96dGdLNUM3ak9hRjIxOVRXVGplbGlTNU1nWnJK?=
 =?utf-8?B?dnlRM3Vyb2kvZWZnSVpXODFiVHJTVlNRYkZpV21ockp6ZHE5UE4yYWQyTkpN?=
 =?utf-8?B?ci9rT3RkZjlnNDdwU3h4c0syWDRmaXQvcE1jVCtZTUd4d2hOZHVHa2xoM0Nj?=
 =?utf-8?B?M0c3V24wTElFOEh1bmRqNWVhbEJmNTY1d1hEM1dvUVFsWnp4aXdhZEkwTysw?=
 =?utf-8?B?UUNnNThoMzVaVHJJc2U5RHhJVTBtNXJ1bmJDOVp6RzZxd2ZNZEtxamdWa3kv?=
 =?utf-8?B?c3Jqb0dab3pPMVdFRGwrVTZhUUNTZ0FESnFXdWlkbGVNUms3VmNmcnRtVktp?=
 =?utf-8?B?YzNOd0x5TFcrQ3Bwc0lQMnR2aGhMNGdjbk9RZHQvMUlhbTBhVVRFcHI4ZnZs?=
 =?utf-8?B?dCswYlYrQy85cHRLdTFJTUxZR0FZb1MzVklubjR1VXlRWFYreUdIM1pGcUg2?=
 =?utf-8?B?cG44V01lL1FiTUFBMzFHN2gyUnFwcHlVVFJFWHpvU2tlbGlqcnArWURRZVF0?=
 =?utf-8?B?U2xvcjdvT3ZieEcvNERIYWZicktVYzRRNXpnNTREV2RzMnVaNkNJT01UUEE5?=
 =?utf-8?B?QW1rWXpiNitzN0VIbTljaW12eG4wS000YWZFbU40M1pzQ2o1TFhwNmNjb0ZL?=
 =?utf-8?B?Tm5GdlJuY0kzMnV0OWE2OWM3UkVIM1lXLzF0N1RZbEpPdXZCVGFMVU5nMHZi?=
 =?utf-8?B?d3N0TmtMTHpqSGMzVlJiUmFVZjdQa3ZXMVBoMEppN0JqbkNkRk1mZ0ZoVWs1?=
 =?utf-8?B?Qy90YU5SV0hvbWVJMWhyVUdZaUJ6V0x3WXZlNndQd3l4a3BXUVpKaUc4b3RT?=
 =?utf-8?B?d3NNdXdCc3VGK2ExNFpzRkQ0VXdGL3JIRW04NWptcFpYWFd1S1ZpeklGNVNH?=
 =?utf-8?B?NVhscXRMQkxhaXJ6UTNOYzdkWVoxdm1DWmhQMVVKWDlMaFJpS3BTby9jS3Vl?=
 =?utf-8?B?SzlLbjBIcWNNVGZBS1NMdlo1SFFpNnVIeDVOT1M5bUdLUWxjWSs0SmVPR1JM?=
 =?utf-8?B?ZDVhU2FVL0JwRWZMRW0xanJ2Y3Rxa0VPUjVhTFZXZ2pmeE5iQ1U3YmFzamth?=
 =?utf-8?B?TmxIN1VYV0RPa1IwWm9sd1NLOUFBU1RWODNkdmhLZlJuZnRiWkNyREV1QzJ5?=
 =?utf-8?B?L1ZIYWE3c1pMMEMveUlmbHNpQktPdTMyaEJPaHQ5THE2QUFEbzJIeTVBMkNG?=
 =?utf-8?B?TDhQaHJNd1BqckNmUy9xODJETWZtczNrcHZZSk5ZdDBqNEV2Y09HWlFISnIr?=
 =?utf-8?B?Q3VDQnFGQjZGVVlpWmhqc1M3cjh1NW9PaGJ6TFVrTFhaNnZqVjM5cHZTRDNl?=
 =?utf-8?B?VllOSFJPU1FQSkRzd2VGSnM5bjlsRUJiOVBUVEVmVFIwYXhPa01sUXN6em94?=
 =?utf-8?B?NmZBa2FPSklZbTI5d2RpbWxPcUVIRzlhN2pJN093dnpNYVpPUUh0aFV2Vk1y?=
 =?utf-8?B?TDdCMStSbDdmSGR6L0dTUlhHTmhLQXB1UGY4dlpacmZ6R1dKekI5TnRETTFB?=
 =?utf-8?B?ekU1MkgwaWVCbGdSRG9Qb1I0bWl1WTJSSDBPTTJyWFBKdHRyVU43d2ZHc3F0?=
 =?utf-8?Q?R7NsFOBCjWhibLHo5w+vSTTbS?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f0f998-97e5-422f-57c3-08dc77213e84
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2024 09:59:44.7535
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T5OoJ/3zwChhqzJMYx4b365B9/4KaxCmDm71e54XKH+HBdnjy4++fzoTKwkYTI02pbZn5FF23vJ30vISIpxbag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6842


On 5/17/24 01:08, Dan Williams wrote:
> alucerop@ wrote:
>> From: Alejandro Lucero <alejandro.lucero-palau@amd.com>
>>
>> I need to start this RFC explaining not what the patchset does, but what we
>> expected to obtain and currently is under doubt: to configure a CXL memory
>> range advertised by our CXL network device and to use it "privately".
>>
>> The main reason behind that privacy, but not the only one, is to avoid any
>> arbitrary use by any user-space "client" with enough privileges for using a
>> public interface to map the device memory and use it as regular memory. The
>> reason is obvious: the device expects writes to such a memory in a specific
>> format.
>>
>> The doubt comes from the fact that after implementing the functionality exposed
>> in this patchset, we realized the current expectation seems to be a BIOS/UEFI
>> configuring HDM decoders or HPA ranges and passing memory ranges to the kernel,
>> and with the kernel having a default action on that memory range based on the
>> flag EFI_MEMORY_SP being set or not.
> Lets clear up this confusion first.
>
> My expectation for CXL accelerator provided memory is that it is marked "EFI
> Reserved" in the memory map (or CDAT), not "EFI Conventional + Special Purpose
> Attribute". Recall that the EFI_MEMORY_SP attribute is just a *hint* that OS may
> *not* want to consider a memory range as part of the general purpose memory
> pool. CXL Accelerator Memory is far from that definition. If a driver needs to
> be loaded to effectively use a memory range that is not a range that can be
> transparently converted to "EFI Conventional Memory".

Well, that "EFI Reserved" is what we want. However, AFAIK, it is 
EFI_MEMORY_SP the only one being discussed with our BIOS/UEFI contacts.

Because how to assign those flags seems to be based on BIOS 
implementation, we count on some BIOS versions doing the wrong thing for 
our purposes, so I have been working on a workaround implying udev 
events and executing a modified daxctl for switching a dax device mode 
or even removing/destroying it.

Anyway, that "EFI Reserved" flag gives up hope.

>> If it is not set, the memory range will be part of the kernel memory
>> management, what we do not want for sure. If the flag is set, a DAX device
>> will be created which allows an user-space client to map such a memory through
>> the DAX device API, what we also prefer to avoid. I know this is likely going
>> to face opposition, but we see this RFC as the opportunity for discussing the
>> matter and, if it turns out to be the case, to be guided towards the proper
>> solution accepted by the maintainers/community. This patchset does not tackle
>> this default kernel behaviour although we already have some ideas and
>> workarounds for the short term. We'll be happy to discuss this openly.
> It may have been subtle, but even in my initial RFC [1]. I was explicitly
> skipping exposing accelerator memory via device-dax:


I did not see that. So, happy to know we are in the same page here.


> @@ -3085,6 +3183,15 @@ static int cxl_region_probe(struct device *dev)
>   					p->res->start, p->res->end, cxlr,
>   					is_system_ram) > 0)
>   			return 0;
> +
> +		/*
> +		 * HDM-D[B] (device-memory) regions have accelerator
> +		 * specific usage, skip device-dax registration.
> +		 */
> +		if (cxlr->type == CXL_DECODER_DEVMEM)
> +			return 0;
> +
> +		/* HDM-H routes to device-dax */
>   		return devm_cxl_add_dax_region(cxlr);
>   	default:
>   		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",
>
> [1] https://lore.kernel.org/r/168592159835.1948938.1647215579839222774.stgit@dwillia2-xfh.jf.intel.com
>
>> So, this patchset assumes a BIOS/UEFI not programming the HDM decoder or HPA
>> ranges for a CXL Type2 device.
> At least for Linux it should not care whether BIOS maps it or not. The
> expectation is that whichever agent maps it, BIOS or Linux CXL core, that agent
> honors the memory type specified in the device CDAT. I.e. the "Device Scoped EFI
> Memory Type Structure (DSEMTS)" in the accelerator CDAT should pass "2" in the
> "EFI Memory Type and Attribute" field, where "2" indicates "EFI Reserved" memory
> type for any HPA that maps this device's DPA.
>
>> above, a Type2 device added after boot, that is hotplugged, will likely need the
>> changes added here. Exporting some of the CXL core for vendor drivers is also
>> required for avoiding code duplication when reading DVSEC or decoder registers.
>> Finally if there is no such HPA range assigned, whatever the reason, this patchset
>> offers some way of obtaining one and/or finding out what is the problem behind the
>> lack of such HPA range.
> Yes, that was the whole point of the "Device Memory Setup" thread [2] to show a
> plausible way to reuse the common core infrastructure for accelerators with
> CXL.mem capability.
>
> [2] https://lore.kernel.org/all/168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com/
>
> It would help me if you can summarize what you did and did not adopt from that
> proposal, i.e. where it helped and where it missed the mark for your use case.


I basically took your patchset referenced in the RFC, specifically the 
19th one, and tried to work with it from a pcie/CXL device driver. I did 
debug all the problems precluding the CXL invoked function to succeed 
and applying those changes from previous patches required and not 
committed yet. Patches 7, 8, 9 and 11 are based on your patchset, with 
just some minor change since I did not see a reason for changing them 
after studying them. The other patches are those fixes for having a 
Type2 finally able to create a dax region and map it.

> [..]
>> Keeping with kernel rules of having a client using any new functionality added,
>> a CXL type2 driver is increasingly added. This is not a driver supporting a real
>> device but an emulated one in QEMU, with the QEMU patch following this patchset.
> Lets start with the deltas compared to [2], the observation there is that much
> of the CXL core is reusable for this type-2 use case, and even improves the
> organization of the core. The consumer of the refactoring just ends up being a
> few new helpers around the core.
>
>> The reason for adding such a Type2 driver instead of changes to a current kernel
>> driver or a new driver is threefold:
>>
>> 1) the expected kernel driver to use the functionality added is a netdev one.
>>     Current internal CXL support is a codesign effort, therefore software and
>>     hardware evolving in lockstep. Adding changes to a netdev driver requires the
>>     full functionality and doing things following the netdev standard which is
>>     not the best option for this development stage.
> Not sure what "netdev standard" means, and not sure it matters for a discussion
> that is constrained to how the CXL core should evolve to accommodate
> accelerator-local memory.

You know I could not add to a netdev driver just those changes for CXL 
initialization, then mapping a CXL region and doing nothing else. Such a 
mapping needs to be linked to something inside the driver what is just 
under development and testing.

>> 2) Waiting for completing the development will delay the required Type2 support,
>>     and most of the required changes are unrelated to specific CXL usage by any
>>     vendor driver.
> Again, [2] already path cleared the idea that early plumbing of the CXL core for
> type-2 is in scope. Just need to make sure this effort is focused on general CXL
> specification use cases.
>
>> 3) Type2 support will need some testing infrastructure, unit tests for ensuring
>>     Type2 devices are working, and module tests for ensuring CXL core changes do
>>     not affect Type2 support.
>>
>> I hope these reasons are convincing enough.
> I am happy to have general specification discussions about core functionality
> that all CXL accelerators need and plumbing those ABIs to be exercised via
> something like cxl_test.
>
> I expect that cxl_test only covers coarse grained inter-module ABIs and that the
> fine details will need to wait until the accelerator specifics are closer to
> being disclosed and the real driver patches can start flowing. In other words, I
> am not keen to see QEMU used as a way to proxy features into the kernel without
> disclosing what the real world consumer actually needs.

Sure. FWIW, this will end up changing a internal driver mapping HW 
buffers which are now based on PCI BAR offsets by same mapping based on 
CXL region mapping.

This involves, PFs and VFs, and because CXL is only advertised by PF0, 
this all brings more complexity to those changes than could be expected.

I think taking the CXL core to the support needed, hopefully based on 
this RFC, should be started as soon as possible instead of waiting for 
our driver/device to be ready.

>
> Now, that said, there may also be opportunity for targeted extensions of the
> QEMU CXL memory-expander device, like DPA capacity that is mapped as "EFI
> Reserved" device-memory, but lets talk about the specifics here.
Yes. I'm actually using qemu hmem and kernel efi_fake_mem for some 
testing about those workarounds, so happy to help with new qemu support 
for the "EFI Reserved" case as well.
> Also recall that the current CXL driver does not yet support parsing CXL PMEM
> region labels. Support for that ends up looking quite similar to an accelerator
> asking for a specific DPA range to be dynamically mapped by the CXL core. So I
> think we can get quite far along the path to enabling type-2-CXL.mem just by
> flushing out some of the generic type-3-CXL.mem use cases.
OK. I'll take a look to those pmem needs.
>> I have decided to follow a gradual approach for adding such a driver using the
>> exported CXL functions and structs. I think it is easier to review the driver
>> when the new funcionality is added than to add the driver at the end, but not a
>> big deal if my approach is not liked.
>>
>> The patches are based on a patchset sent by Dan Williams [1] which was just
>> partially integrated, most related to making things ready for Type2 but none
>> related to specific Type2 support. Those patches based on Dan´s work have Dan´s
>> signing, so Dan, tell me if you do not want me to add you.
> It is fine to reuse those patches, but please do include:
>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Link: <lore-link for copied code>

Ok. I'll do the changes for next versions.


> ...so I can try to remember if I still think the source patch was a good idea or
> not. Again, a summary analysis of what did and did not work for you from that
> posting would help me get a running start at reviewing this.
>
>> Type2 implies, I think, only the related driver to manage the CXL specifics.
>> This means no user space intervention and therefore no sysfs files. This makes
>> easy to avoid the current problem of most of the sysfs related code expecting
>> Type3 devices. If I´m wrong in this regard, such a code will need further
>> changes.
> Not sure what you mean here, I am hoping that sysfs ABI for enumerating objects
> like memdevs, decoders, and regions "just works" and is hidden from the
> accelerator vendor driver.

If a Type2 is fully private, should be any sysfs files about it?

AFAIK, those files are mainly for user space able to create memories 
joining them, or for changing the dax mode. What do you think a Type2 
needs through sysfs apart from info? While writing this I realize I have 
not thought about power management ...

>
>> A final note about CXL.cache is needed. This patchset does not cover it at all,
>> although the emulated Type2 device advertises it. From the kernel point of view
>> supporting CXL.cache will imply to be sure the CXL path supports what the Type2
>> device needs. A device accelerator will likely be connected to a Root Switch,
>> but other configurations can not be discarded. Therefore the kernel will need to
>> check not just HPA, DPA, interleave and granularity, but also the available
>> CXL.cache support and resources in each switch in the CXL path to the Type2
>> device. I expect to contribute to this support in the following months, and
>> it would be good to discuss about it when possible.
> Yup, especially CXL 3.x Cache ID management. Lets talk about some ways to plumb
> that, because it is also a general CXL specification capability. Another topic
> is what is needed for CXL Protocol and Component error handling, I expect some
> of that to be CXL core common and some of that to be accelertor driver
> augmented.
>
> If you think we will still be talking about this driver enabling in September
> I would invite you to submit this as a topic for the CXL uConf.

That would be great!

If this RFC work is integrated by then with the CXL core, that would be 
fantastic, but the CXL.cache support will still be pending.

>
> https://lpc.events/event/18/contributions/1673/
