Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89BBF188587
	for <linux-cxl@vger.kernel.org>; Tue, 24 Dec 2024 10:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735034597; cv=fail; b=cdXijGIWBXuqNi17Iojnl0o1JHyDQP5mWpLhfTnesZpV44DHVaE/TaEfYezQ6I+QVvFH0x0Qkp4r5QZkzMJvSW4pWH+kaR73J/NsiGokAiclSB2Ji7En57eVswkkrJFRPBPL5/0iDrrPT6dw1MkK4PScOpzScaG+oKfbdps+evU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735034597; c=relaxed/simple;
	bh=hOKjJfSHCiMEHhxtj56+yUku/Pu2IFfs0/RC8y0ZzAw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XzMLU9JO5sDhcZt06Vam6F7eN5XBbGExopyloIBIxO1/0x5LrL936zYtf9HNRsSD6G62H5YFVW7VF0LU08gcvAmtBZ27Bb0vOsbVlxiyPZkz8GSVCWufd8FQaDmLvAPL/1ZCIOX6WM+dDH9vqT1JadeR/IyaMbrWrlYwUFNfSF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bqwQ6Psh; arc=fail smtp.client-ip=40.107.244.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bqwQ6Psh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RR+vznP2EQ5pY8fAUa0hp0gGIMrD9hlbL6WIQ3jj2uWwelr83uUCyMgvVfN6kpyAyLYlPVhUhcogK/fe4C0xhvyf7xLV0EjXXdd4b96FwsLBgYoZ0bEkVI53DmFUtS5Ngzm3cHjkL2U3xyIc34vvLTc+0/2yS7pZS4GM/lDb2olGy6oHXf1ePZuApedG4YctYqU0ED96eF0pIeUUz25yNnwZG+tik1oBSMZyJL8qdNbpgHgEYxM56pa6yjm5uO5YtG1aedla/np6t63Zo3jWEUoMxwNRXu0ru5Thsa+/g+ltNtJFJUWGdz/M37O1Q6xI3Ks19ilM49j4MShNerHbIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0cJB+VnC2AUWDwGPOMEXlA63G4c1tDv9KTu06oCI50Q=;
 b=KtsNdFcnav7giVPi4XwX/c9Fzq9dqeGvVV7jBvSynBbUhTCa85FzoDGELRXcol8ijqFQY9efMJuxY5HikdRQkvs3nzNHwKiC+WPmF78t5YHF1hakZZiNBpBFcdxfut6kC6RAMKktynWVjnrfQcnp+HNIUFLteBF1jwvHUFt47lEwC+9RDJiB4QyMT7Ld165f1xZnm3kBzdmr6IyWKPXPE+EZof4QYaXZ+dM2jM1FoLgA4kQraol1pVMhCQYS0O06r6eDhcwC/BXT58y4F1c+RiPmjHts7JhpHX9E2aQ/QQAOavCwlZbOnaYWMeUU9n5I+jrPnmZuRFPhzSgKg2Hcug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0cJB+VnC2AUWDwGPOMEXlA63G4c1tDv9KTu06oCI50Q=;
 b=bqwQ6PshH2Sdf5L2LjpZzfeC08vR6WBBKg+ntGUkn6VZ4aIuiiv4rnvIBfJjGZFcXKH+8lawXed6B+G/MYD+LQohqYbQsv+XAFgQEBqJCUKEj2caMomMCMWtADzhnrLZbAKPr657hHi9ZP3GfdZFKvWn3yTTGly9pQVAo3ZX94A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH0PR12MB8029.namprd12.prod.outlook.com (2603:10b6:510:26c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Tue, 24 Dec
 2024 10:03:08 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8293.000; Tue, 24 Dec 2024
 10:03:07 +0000
Message-ID: <5685ba8b-128e-398b-32da-bfe71c678c29@amd.com>
Date: Tue, 24 Dec 2024 10:03:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RFC PATCH v1] cxl: add support for cxl reset
Content-Language: en-US
To: Srirangan Madhavan <smadhavan@nvidia.com>, Ira Weiny
 <ira.weiny@intel.com>, "linux-cxl@vger.kernel.org"
 <linux-cxl@vger.kernel.org>
Cc: Vishal Aslot <vaslot@nvidia.com>
References: <20241213074143.374-1-smadhavan@nvidia.com>
 <6761ae926757a_2a169f2940@iweiny-mobl.notmuch>
 <PH7PR12MB796800828DEC6E60D7C7C0F1C3072@PH7PR12MB7968.namprd12.prod.outlook.com>
 <676603cdee673_2ec99229411@iweiny-mobl.notmuch>
 <SJ2PR12MB7963AC888E432469404E4FC8C3022@SJ2PR12MB7963.namprd12.prod.outlook.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <SJ2PR12MB7963AC888E432469404E4FC8C3022@SJ2PR12MB7963.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0012.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:3c3::14) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH0PR12MB8029:EE_
X-MS-Office365-Filtering-Correlation-Id: b9ce95d3-8091-4f6a-c129-08dd24022a19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGxnMFpvck53T0NZUUIzOU56V09xT3NZRUJYVFZySEVqM0d4TS9SMHVjTS93?=
 =?utf-8?B?RmR6ZExWdDJCQ2c4Z3lPNlJtRUNJb3I1VlNndDJvS3c2azk5ZWRXSU9NR3RU?=
 =?utf-8?B?UXRWeFpocWlxQUQ4TkJrVUNZUGQzWEFOOEg5TTJ1VUhtYWk3T0lKK1B1VnlW?=
 =?utf-8?B?ck1ielQyTW93KzVXbmZ1VWdpV3dVS2tYU0pDZXVSRGhOZFdORTljenhVVnZ4?=
 =?utf-8?B?MkE5Qzlwejh2UkoyQlo5a1dDREpOVURMVVhjb0ZZRnJ2WkswbDhqcTltU245?=
 =?utf-8?B?cTRYV0dKYzBVNzIwUWFCSU8veGFJT0hoZVJOTDNJUFV2cks4OVhGNWx2OU9J?=
 =?utf-8?B?V1VjOGVRR3U3elg4ZDFXQWZLTWZWa2VwKzUrMWl6bG1WYVBGZUJXM2k5c3g0?=
 =?utf-8?B?NG5HNGx6L1ZDVjZNWURBc2s1SmxnMkxGVUJnYzVsUjloWkVLTUJVRzNEZDFX?=
 =?utf-8?B?R25TeG5hbWZWZmIyTGI0UVV1eVNQWTdnN0crSWRiaG5RZTBXcjlLaUxBeVVI?=
 =?utf-8?B?ZU1IdDdpdE05L1BpUVZ0clc2c2FwTWJLSTFONi83OFo3akVBN1BYa3lCOUNZ?=
 =?utf-8?B?SFIySEphTFd0RmdwYmIvb3E5YUFJMlk1ZEw5bTZTSThWZWJNYVJMcEZUbXNJ?=
 =?utf-8?B?cm1HZlRNekVKTWZhQTAxNE9jeWptK1hmU3B1ejdyWENjaDRqTWdNWkJVT3kz?=
 =?utf-8?B?dE9wc1NaQ1BZeFZIYXk4ZXRML2Z2blluVnkvaHFleWZ1NVRPUEtqcWpFZ01h?=
 =?utf-8?B?UFJ0L2lYMWttNE9EWnpDakYyTUZ0ekhESW50VnpqRnNnQjNWZUNvWXJ4cjBN?=
 =?utf-8?B?YW92UkZnWmpyOXZsZ0lBVXd4bFZYc21yZlFoZDVYU25jakRxeEo3Yjk4WkNR?=
 =?utf-8?B?TWpMckFrL2ZDVWtZSVI1VGp4QUNGUnZ0VFAwVkFmaCswaE9acjh5SUZJN2Jx?=
 =?utf-8?B?eSs3TXBUY3VDQUpqcnM4NU5JNE8zelZxeVpTRzU2V0s0ZTc0cGQvMXJqLy93?=
 =?utf-8?B?R2huRHUzWWlyR0ZaM05EazJYbTVCS1VnOFVXWWQ5SStTa2FTWEMwb1EyejZB?=
 =?utf-8?B?dWNQajVKOWhGZHBydkw1KzVaeEw4bU80ZTk4QmRzQXhVMDNLaVBqTlZMMk1y?=
 =?utf-8?B?UGJJMzZYQzFyU2kvWlhBcUpmakZMSCs3cGZTeGFDMTZEUWpiQUhPYjVEUTlu?=
 =?utf-8?B?S1JMQS94VGNQc3NtTDRzaGJzMmxwNnpiZThWZ2lqa1B1Z2p5dWVvZDltZnFD?=
 =?utf-8?B?UW4rRkRaSWtFL2ZJT3Jpc0NBVE1venNKK0VVcW5iRmxOM3EyMlVvMUxSRVlX?=
 =?utf-8?B?MW0yVTVLNGg0ZE8yWkJZdFpDOWp4bnR1aWthWk9GK250WkpYRlJYV2hzYk16?=
 =?utf-8?B?eTZGdkdvb1RnT1B1U1lvZ0dIRGZRTXJlU3k0TW9xOEhWVVF6USs3STlrR01x?=
 =?utf-8?B?YlovNG1US1F4V2pETEpJRE1MMmU0Z0RnSFFiUjFpYjBVZTEzSTNWcmxlZkNZ?=
 =?utf-8?B?QlBSS1E3cTFiZy9aQWZCczdCeDk4TE40YXNLRVpBUGdUdXBUWHJJcWYvbzJO?=
 =?utf-8?B?T01VVWdneUV2Mmx2ODZNUFp5eThqVWJrMmR5aHZOUEtja0VkYTBuKy9XbDJv?=
 =?utf-8?B?Z3JXbkl4VUwrVU9vVzlWM0I3THU1OGVnQU04dE5TaWZ1UERCTlJoOTdPNktn?=
 =?utf-8?B?endKQkhRZ1VTOWJmVUtPZTAveXAvTzNuUm1KMmN5S1FDbVY5Vkhoek1rdjZw?=
 =?utf-8?B?dTZDcnpmZUJXSExDd3dGRjEzZnV6elIrVVQ3anpHWEdDTGxwYjQvWnI4OUhF?=
 =?utf-8?B?amw4V0tMZzZkMEs5d3RGWElFWThBOVhhOGw1cHRFK3NDczM5YzE0cFhyUjQv?=
 =?utf-8?Q?NuBxR+L6eiuPx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWVBNzkvaGM0Um8yYUpBQ3hYRjlMYmcxMVRzS0hBalNCMWpqTlc5WG9CdnJs?=
 =?utf-8?B?UEtnazdvcmxSdUZ2YWhTMXo2MlRxWGR6eU1Bb2NZTE43VFZlR0RKMWxtbWJH?=
 =?utf-8?B?ZDlYSStLWWxmcWVUVWxsL0QraytNcHJXMXVIczNoSkxta2xvRUVoMWQyLzNx?=
 =?utf-8?B?N0wrZDE4YlJwQlBRc2x5eXVaN0xhMkNRS3o5aWl4YS9wWmUwTXZ6YWFnRWt2?=
 =?utf-8?B?N3pOWlBNZ2JBM2tZd3lhRXoyaW1ET0lETVRsT0pYWnBvb2JFVFJZQWlsOWxO?=
 =?utf-8?B?VEZ5OS82djU5WnF6emxPanRVaGtldXVUVUVNdzVxQnFnM09tT1pDRklGQk9n?=
 =?utf-8?B?T2VjV2ZJTk50VkcvcE9mTjNrQ25XVVlKVmNZb2R2MUp5SW5MU1BoajVoUXN1?=
 =?utf-8?B?eEJrMGM2bGs2NVlIOVkzRmJ6WTVZVmZ4dkNJV0FrNXJFSFN2Ui9WblJScFdN?=
 =?utf-8?B?S1RaZVh5TXhxSW5ZZlZtRGJ5a1VyOEU5S2xzUllxUXhLaUtZYnlsTFZINGVU?=
 =?utf-8?B?QXNGZnlKNlVtTVl4OFhyOG5qTnh4dlNiZkZzN2V6dUdreDlYdkFVUWsyaVYv?=
 =?utf-8?B?UU16UXdKNEt2UDg0N3dqdXpTanYxd0pOZFdUZHF0Zlp5NTNkNnZoa3hVQk5Z?=
 =?utf-8?B?NHNJOUEzTWtBdVdXSy9lSWQ2N3FqMmZ6TzZkdnZFY1cvb1RVbTlRcUFETkxk?=
 =?utf-8?B?aXYyRkxEdEs3Tm93dWRuOWllSHdrSElLdVBhRGRhS2lOV1RoZFBOVmFaZVc2?=
 =?utf-8?B?anAxemlZRi9ad0s1Z04xR1hkUHB5WUhPZjhSYndDc1hpSExmVXhlZzdCYjRo?=
 =?utf-8?B?R1EyYmJMM3VJV3M5RjZ2dWpXTlFuZlJ6RzJGa0JabVQ4NG9GSU9HVnRhSUJ0?=
 =?utf-8?B?TkZ0S3Nuc2NoOWNxM1NTZkpjUVZweE5pcDVQb2V3ekluL0RLeTY2UzZDTFRp?=
 =?utf-8?B?NzNGRzhmWnBhQTdtUE1CVmxWWXRRUElQTmVUMkdyQ3d6bm5tdUt0VlZRaDZW?=
 =?utf-8?B?WnhJK05VZTN5SklpSG01NHJpdFZCb3BGNk43emhFNTNvUVJ4aHJ3MmdzOXdn?=
 =?utf-8?B?TUQxMU15a1hqb0x1ODZ1RlVrdkxaMlg4TWJFYkZrUHgwOTd6ZzNEd2ZZVERR?=
 =?utf-8?B?RmZLc0hVdlFHWkYvSVRHSWF0ZXhvbXNFVFJZMThHMlkwMmV6M0UyUkYrU2Nu?=
 =?utf-8?B?YzBLRGlpSGxHWEVhS2IxK2g3TkR4QUVRNFN5OTU0R3NsQnljTTh2MHI3OVhE?=
 =?utf-8?B?eSs2TTQ0MGVVNG1POXVOSk5vRTMvSU84MXdKMExENzlvWFlUS3U3SUgxM1ZU?=
 =?utf-8?B?WFMzcmRxTE5JZTdjUFdoUUtYWHRUWnhOWUtVZGdab09ub3UydXRCeHV0dnpK?=
 =?utf-8?B?MTVxZjlONnBaL0RxMTJ0OFBoOEt1VEdHVVEvbFlUQ3J5SC9kbll5VGU3MW5y?=
 =?utf-8?B?ZnRGYThNTFlEVmF4TU5URmdmZWFnU3czaTJ2T3ZDMzF6d2FMT2JKbFl5STlW?=
 =?utf-8?B?OHFSankvQnV6d1pNdThGQTBWaVlDblE5bFFXUE1LN0kvdStoZnFEK1hHQkNx?=
 =?utf-8?B?RkliNmNxYWVwaWgwRkhDUTlSUEFJNEFkZ2ZzR2ZFTUtpNDZMbEtaVlhMaEda?=
 =?utf-8?B?UHpWbURVZjVGakt5SDVmQnRGYUNTQnRkdEFYQ1R2d3Y5bUR1cHhKRWZHY2xx?=
 =?utf-8?B?bVRySzhjaUM4M2NVc21PTkNXYVNRZEVaaVJUSzZXakpUQ0pyaEhwR2ZXRVRl?=
 =?utf-8?B?NUFHKzV2WGF5UXN2cHhGKzVZUUUvL0gyNDRBdHN3L0F6NWpzQmVIMm9LenJJ?=
 =?utf-8?B?V2g2Y2xsbERJSEZhdnlBR3hiWFB3bUQ0a3pVbVFhMUN5RTRnVENzRXhDTUwv?=
 =?utf-8?B?c2lPZTM5b005YktuREs0TDR5WGhxejZ0VU1HZ1A4eVN5WGI3MjJ1RXdSaXh6?=
 =?utf-8?B?OEQ0NTdWNFFsWHhiN2JyS1pWSDE4eFNPc0Jtcng3OWVwTk0rb3lFc1NNQlhz?=
 =?utf-8?B?bkZXU1JzSXZuV3IydDZtQllTU2lGYWJKUXZpWXFOVE8wSWtOdWI4bnc5UFgv?=
 =?utf-8?B?cE1iVnZXN2hOM2pmOUFsdGkzY0MxQ3VZQmFkbUlYQnhsUGVEaWdMVzBxV3Rp?=
 =?utf-8?Q?JyYHxoD/slKHXLr1HGLixXx32?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ce95d3-8091-4f6a-c129-08dd24022a19
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Dec 2024 10:03:07.5113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a7ADBtTQbztGN9d0GYQw+s53iqueUFYH0xOIsTqhaDUjs69Y0+hu1l3awW10b/HnkcLOdyXQOlXhpIRZZNeevA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8029


On 12/23/24 23:49, Srirangan Madhavan wrote:
>>>> What happens if there are current cxl regions mapped to the device being
>>>> reset?  I don't think it is enough to flush the caches.  Section 9.7
>>>> talks about system software requirements for the HDMs.  How are those
>>>> requirements met with this patch?
>>> Considering different platforms might have specific operations to
>>> effectively clear the regions, some type of optional helper routines in the
>>> CXL core would be appropriate.  This way if required, a Type 2 device driver
>>> for example can choose to use it if required.
>> There are a couple of ways to go here.  For memory devices I think this is
>> on the user.  But I don't think that is a primary use case as I'm still
>> unclear of why a user would need to do any reset of the memory device.
>>
>> For type 2 devices I think the use case will be device dependant.  The
>> specific driver in that case will need to tear down their regions (with or
>> without user space coordination) and then issue the reset.
> That makes sense. So in either case, based on this logic, I am assuming
> it is out of scope for this patch to remove the the memory regions.
>
>> All that said I think this patch belongs with a series which implements
>> some device support.  Or is more general for type 2.  Which is what
>> Alejandro (cc'ed) is working on.
> Thanks for the feedback.
> @Alejandro, if you have any thoughts on this, kindly let me know.
> I can proceed based on that.


Sorry for the late reply.


I thought about this some time ago and shared my concerns about current 
CXL error management which should lead to a CXL reset in some situations.


Apart from that not being there yet, how to do the reset has the problem 
of the restoration of device HDM registers. I think the kernel CXL core 
should keep that information before the reset, and restore them back 
when the reset is done. Other possibility is to just unroll the HDM 
which implies involving all CXL switches in the path plus the CXL Root 
Complex. I do not know if there are other considerations for supporting 
restoration. For a, I hope, near future, CXL.cache should be included 
here, but it is not clear yet how to support it, so even less clear for 
a reset.


Of course, CXL errors can be more problematic than with PCIe, and a 
reset could imply the system (some cores) being stuck, so all this is 
quite tricky.


In the specific case I'm adding along with the generic CXL Type2 
support, if the system is stable after a detected CXL error, the device 
HDM should be configured after the reset, by implicitly some code linked 
to the reset triggered by the driver, what could be quite similar to the 
initial CXL probe, but if restoration is an option, the CXL core keeping 
the same ranges and somehow giving that back to the device.


I hope this helps somehow.

Thank you

Alejandro


> Regards,
> Srirangan.
>
>
