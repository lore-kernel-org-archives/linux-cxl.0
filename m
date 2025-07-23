Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AF33093D5
	for <linux-cxl@vger.kernel.org>; Wed, 23 Jul 2025 14:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282673; cv=fail; b=pUbHN9GgYIQ8i2mKDyDhd/P7W3vLzq1m5L21wwW6rUyi50yQxEkaWbnoQc/v4e6QOsYiclFg89Zz8GyBs2dw1dIAI9OuHnF9QNob0ztfu696/NnsgQbR5MgVLlR599m1+zvxYAbkHyxqYXj5lF/rMjrorUv49Nk+WfGByq7ggMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282673; c=relaxed/simple;
	bh=lIEpGMOw2JzAtWAkv51QjRquPD8yK50NANSfKgLTvq0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E+G+/cYFr5kSgCHk+t3W0yU8ppAolExcAjfa9lyau934C2Pp4i7m8CTDPBduBbBieayw407aTS9gpvvWmxJIZkiUOO1cAogq/xccqNhDVgiocKpI3lWD81kvQr1958lYH+VdIC/yZ3uftMBBnLXuerXJdIWIwo9bHrlvSgPmvIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=y0pbO+Kp; arc=fail smtp.client-ip=40.107.94.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="y0pbO+Kp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EjmLWgsq3wqfpLKlDFp/cuKNH7QYjPMulayjEHNfr6oEjQcBA7BPsrO+oLN2GRQRPUJ24n+82aku+oloQOogx9FSbtvXSvRP/2eTF8Ggb1cMa9vyDR9qB4S6og2D1IRqA9NtHx3orX4Czak4s5HYz3vCE/nJ5B5IL6lu5fuiH4smrblUEuTCY+JBDVSf90WlrJ8wQfAT3FNGYrAHGBJPntuV8lNN0kC2iU5znG0ps0l5YtlMU0B8TQF6ajIXVxYkyRIb8aTGdphVLd7+1kow5GkvW+3Y5vg+ccd5WaJAPbNAUtjgLzm3Edict/qOLy2WgCExhVTQvSaJMfB9RKA5Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQehjXydyWHNsjgZ0ikOCLvOWJfMSg4k//ybi/q9V/s=;
 b=KZUphUCXpsQZF3Fiu/9dB71l8BUvYnoH6GPr/zwRwGP/M0EWEggPzp6fVEYFuy6Z+esFZXhxieb3jJYuKKDrBwRtNGJtz2DIQXOJb5DUv0gjsE9zCd5xLbP5yan7hQNSn6IzZyTJ2vMIs/2pvkU7sitMhTdsaUBGP7oSPa6+H7IYRtz3NdJQJOURFGPK7O5ZRMgPnck4NeVybNowugohtfpwe9f7hrkDLwB8laEluo7KnjceWDdFEw1sGtvHYB3jPszFoUivFLqE4CpAoCzrGFL1EPDtpOBkZCAdW4tbVm2sJv5XBgmPzceJlgUIfok44lTFG62YDtQksow1ySOHRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQehjXydyWHNsjgZ0ikOCLvOWJfMSg4k//ybi/q9V/s=;
 b=y0pbO+KpnAhifIFjASaYgJZs9OsqWx+kyyqxcRKY0S7u+aXUYyAZjVt+Rnev8eTo3kwDnGAwfI5lc6rX8AQn8Kq21dUtfdeARhvcYHcnS8AxMn5lspyuxezKa8XDvEmGnxfmyirry55p4FeVhZknLq6zfxKzUyIaUl0rbfsv1wo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6391.namprd12.prod.outlook.com (2603:10b6:8:cd::16) by
 IA1PR12MB6555.namprd12.prod.outlook.com (2603:10b6:208:3a1::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 14:55:57 +0000
Received: from DS0PR12MB6391.namprd12.prod.outlook.com
 ([fe80::bd77:d598:4de1:27a]) by DS0PR12MB6391.namprd12.prod.outlook.com
 ([fe80::bd77:d598:4de1:27a%3]) with mapi id 15.20.8943.029; Wed, 23 Jul 2025
 14:55:57 +0000
Message-ID: <12646336-9be3-4bc2-adf9-bfd59c589251@amd.com>
Date: Wed, 23 Jul 2025 09:55:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl: Remove ifdef blocks of CONFIG_PCIEAER_CXL from
 core/pci.c
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, Robert Richter <rrichter@amd.com>
References: <20250721170415.285961-1-dave.jiang@intel.com>
Content-Language: en-US
From: "Bowman, Terry" <terry.bowman@amd.com>
In-Reply-To: <20250721170415.285961-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0155.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c3::25) To DS0PR12MB6391.namprd12.prod.outlook.com
 (2603:10b6:8:cd::16)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6391:EE_|IA1PR12MB6555:EE_
X-MS-Office365-Filtering-Correlation-Id: 41f0e7d5-cc1f-4bb4-a26c-08ddc9f907c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QVN0SjM1bkZqaG9MTGYwK25aRXRPZDJVZnphckVSRlpuMGxuNUw1MmJBdC9U?=
 =?utf-8?B?WmJPMjM2WEFUMEk5OVM1U1ZtQ21odnJzMU5kSXNDc2d4S0ZJamY0KytZYWow?=
 =?utf-8?B?Z2xzOXpaM2NRaDN1bFRUL1Nyd1QwVEw1NytjdzBHNno2QVNSREJhWXhyaVF6?=
 =?utf-8?B?clJXMTkvWnlWd3EyTWg2d0oxRm52eU84UGg3bjNFRFJKMktSRysvSkdORDF5?=
 =?utf-8?B?SHNoOEc3Vnl0M1o2QjdHZHFtanJCdFA0UmdNS05rYXR0WlNhNWFUTjBhc0V5?=
 =?utf-8?B?UDlPaUZxWnl0cVEvTDlSeUNtZ2VLWWkxclpNV0RwMG5HMVMzaHh5amNuTjh5?=
 =?utf-8?B?QXJjSDBXRTZVTVBkOTlRQlRGdVdKOVNmck8rcHdSVXh2V1FIL0FwOEFrYytE?=
 =?utf-8?B?SDFHa0hGUzdpRlBaV25CbGRheTRkMklTTXF2RjEvbGorSzhRVUVxRDVIUmUr?=
 =?utf-8?B?UGFrMHgzb0hENFB2Z1RVVThRK0pRT29VOFM1YjNRazlJVlMvbERSaENOZVZj?=
 =?utf-8?B?amNBdVA1QTMwQUtjSFpNakNPR1hmTXdqY3Jpb0w2UDg1YUlQV1dldjhJLzly?=
 =?utf-8?B?L0lDYllKbG13VlZFa3RyaEE4SnJrQm11L284aTM3cHNMVXc5eTRKVTB6SFFR?=
 =?utf-8?B?M3RMYWEzU1hjYnA3UzZzZlJDcGkxTmhlcXZ4MnR6TVJyQmliQUllbHkzVHQ3?=
 =?utf-8?B?ZG9RSFo3eHIvV3NrNm5OV2VxQ2hwc2tJWUN1eE40WHVOTmRTRWY1Nm8ybkdN?=
 =?utf-8?B?aVRrY29xc1VTOW9NRnNaMUxDUXNKaEQxNWp4RndZbE9yckV6U3RSWDhJQ3VS?=
 =?utf-8?B?NjlRakJGeDdhT093R1VKWGU3ZDZXK0RNaWkyenhWZmtQRUc1czA2dHZZS2xF?=
 =?utf-8?B?RUthcVppZElud3RWZkJhUkZaWXgvRE1IM1RTdWhYYVNWSk9qT0tLN0JQcDA4?=
 =?utf-8?B?MUROYVJ4ZGI1Q3k5NkJtT2k4enJpbFM0Z0ZxSk4wQ1BXWWh0c0tkZlFJWHA0?=
 =?utf-8?B?ekxmMkR4RXRhVE9KanFXL2dIazN4UGNYczZ3QnFUbmd4RFBFOXVrdXpCZEk1?=
 =?utf-8?B?V0x2MWEwTVM3Yk41cTNmRDVWMlUyU3RuZG8rTXpEZHhRQ1l4bC80MVhSUzBq?=
 =?utf-8?B?S2d6QXVhZDc3cWpWY25OTXcxMDZTclF6MjJ6dnVpU3N6L2srUHlaSE5oNnFu?=
 =?utf-8?B?dWJNSnBBbXB4YjBzcUZ4SGdvdHZZdmZTZ0J4VVBWYUxCL2hUTGY3NVNFNzln?=
 =?utf-8?B?Zkt3alY4ZjArS3lkVXdzZ1lsYWkzWkx3ems2ZHY4bk9LWXRGNk9JTU5VOGs3?=
 =?utf-8?B?Z0twOXlrODJ4Y0NWbXVYMjVadWZQYm5pQ25sbXpDRHdneE9BTFRUcnA4ZFBv?=
 =?utf-8?B?dmxDbGJxNGY3b0RHanZsS3MyS1ZFKzJ6N3JDdVZlK2ZZMXJQOGhvV3JFbXNQ?=
 =?utf-8?B?SVJJMHZSM3R2djZEc2xKTnlRWUtOQTE0dW4wWGtiRmpyaHdoQ2lxTlJoMjF0?=
 =?utf-8?B?VFlOaWErNkNPa2NkT2k3VmpYN1hiNU80NGgzWXJIM0NsVXNpalFjNWt4T2VR?=
 =?utf-8?B?ZDRPNEVtK0pSMWVzNWQ1dDhvNDgzM2pka1FXcjdsQy9XM3FrejJYb1ZwQ1lo?=
 =?utf-8?B?bzd3anU2ejZmYk80TDVxakp1TjNUWXI1Qy85RDc4RWZnUTMzUVhuSGxCWjlM?=
 =?utf-8?B?Rm5HUW9YcjFpQkdabGlXc0NjV3BmSklDUmZSRWVjZVBEclBKWXpWUkFOM2FG?=
 =?utf-8?B?S3dLeU80b0ppRmJlb1ptaW1iSk1HRExPb2ZSeFYzTzE4U1JkQVdTd1pWVWRp?=
 =?utf-8?B?TXlvVGtncm5icmRmUUNjZ0ZUS0Q0M1RsRUJoN2VrN2tITDNQSTgzMkpLbE94?=
 =?utf-8?B?YWRhcEhIbkFiUVhEMHpBQUtyYzZpcXNFVHdZRXJaRXRza0RkN3hrVzZjUXJR?=
 =?utf-8?Q?VTXAMp0TEAY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6391.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2U5ZVpaaGtKbjVXWHZMZHR2Ym5IaGlqQWhDZVhIRHd2RmdQaEFOZURURDI1?=
 =?utf-8?B?ME5sMDc1Z3dNazl3cmpnTGNrL3NPU05ISmptTWNsN0RGOGxvNFBxUHpESjNo?=
 =?utf-8?B?NkRMdVA4MFB5U0doM0Q2M01mTm9KTEdlWUZFZjlLZWErWTJ1V1NPWGtMK1di?=
 =?utf-8?B?enM4MnhjdnZ3dkJYWVEvU3FCQzluc3UycGNDUm5NMys2a0RkUUhFS01mdzYr?=
 =?utf-8?B?bFdKbjV6WFA5azdyK2Z3dUg3QjVXdzFBa3h1M2xEemIrYUFqUUpyQ2xUcjhC?=
 =?utf-8?B?MDNOcStheWo4dUU1eG9FYThrNkpHMHhlMlhyQkloOXNWZ2txaXllN0cvbGQx?=
 =?utf-8?B?UlhLWDZUUnMxdndIbzZQQ1d3cjhDWmhYWDBwdGtoQm9CRUFlQXVQbFJQVTZr?=
 =?utf-8?B?aFFPRDZXeS9qNUZYckVETzg2TDhmRTV1ZGlvSFFUbFQ2bXdWbG9TbnFuUE1y?=
 =?utf-8?B?eDNaQlhYY2d3SHBlNGlTRUdmQjRzRzVXYnZGcTB1RklJVkovM016aVduTjdY?=
 =?utf-8?B?U2wzRkNMQkhuS25WVUxLTDVwRld2M29weDBHTmJzcUQ4V1F5Q0RSWndUYXdX?=
 =?utf-8?B?SDJOWFVKcjl2VmswWUZEamFWYi9qbjVLaHZXeWdHaDdoR0gvZ1NMZk1RZW9p?=
 =?utf-8?B?REtOV3UyZ3AyQzA4R0xEWXhnVzMyK2JjVU82Zmt1bUNOc0JOVFY3UUI4cWFV?=
 =?utf-8?B?S044MnRyNElDL1FtNzBQRlJzTUVQSHVJVWd1eFNEaXk2OTE2NmtCR0JVWXNl?=
 =?utf-8?B?a0FVaUhuNjA1QlpYZ3lKclNSVXlRSDA0UHdDakRaOUwrUzVlR2ROK1ZTRlBt?=
 =?utf-8?B?QXJiRUY3NGpUbW1NWGtDemZ3Q244YkdCUlg0eUZCY3lOcklXak5WNHJhKzQ3?=
 =?utf-8?B?ZUxKS01Va2lSWXMzQ0lEVFF3NDRnZll0UDVzMDVBSkdWdFBxZEhaZk5mSVRP?=
 =?utf-8?B?UVdLNVhUbWpldjVtMWYrNURnZUdHUnZuZGdWMzhVQVBQNUlFMGwzN3I1a0wx?=
 =?utf-8?B?Z05VYXk0aUVST2Y3RldGMWlNQmFCOUJjTHYrVUcyUXNwdnl3M3ljYm1PeVlh?=
 =?utf-8?B?V2N5R3gvYzdLWVgwUlFJSFZNUDYyUFVNcllKaS91anFQTUJsMHdOU2xCZ093?=
 =?utf-8?B?WFpBRHFPMWROMEpIc2RCR0tJRXBlYnJweVlCRnViQWtHSENKblUvME9xdVBB?=
 =?utf-8?B?T29oV3p2R0doRGl2eXRMbytVRTVxbEdMQ0I3ZHpnRkhyTzNyWW50T3FtL0pG?=
 =?utf-8?B?UCtSRyswekFpaHhiajZlK1cxM2tpNEN4TTE2L0hUU1hXVGxGbmRxa1ptbVNl?=
 =?utf-8?B?VzkrVTBSNXBuVWs0VU9BWUhJUFM1VEM3QzZkNFlIZ2l6OWVVcGZ6UG5UR0Jp?=
 =?utf-8?B?Zllad3BPd1B6cEc2c0ZYSHZYbjhFSUhyRHpJUlhBbkFwMEw4RXMvejFvM0NU?=
 =?utf-8?B?NnpsbVR5T040aVZ2bk53Z05xem9qbnhiM25pNXIvUUNaWjVITjh6ektMZEVL?=
 =?utf-8?B?cUpIeGhmWSsyV1FvZVZxa1cySmpGK1Nsdkk1Qi90QjJCNXpvVVowYjQ4TG0z?=
 =?utf-8?B?NHdlcjMvL3lQM2xIK2dvM0NZYXlQMjIwd3ZTY1RwenhHd3BOWXVxdG5aN2hu?=
 =?utf-8?B?ZGxKRXR0QStRSjViN1BET0IwWW40YVRkdTRJMHpGUUJQZUx6d3pSSHRZSTN4?=
 =?utf-8?B?RWxJbENHaG1MTkY1MStXNmh0YW8rSkg4ZjY3Z0dCU2tDeUszMjkwU2NhMlFj?=
 =?utf-8?B?bjFYck9GZUppdHJFT2pYclBTTmkveld4ZmxXeUQ0Q2NnSHRHWEg5bVZSNGwr?=
 =?utf-8?B?RWNkKytNZStIdFdkaGR6eWJ2cHRTZ2Zta3JhaXl5aGh2OE1rZGxFS1J1R24w?=
 =?utf-8?B?YkhTL2xGbG1JckV0bzZ1MXA5ZGRMeDhBMFc2K0VFZ3hkMVpOOGlVM3ZwMFVw?=
 =?utf-8?B?dlpYcTkveENUeTQ5Z1ZTQk9oM2duMnAvVHY0RXE3Wkd1VUJNUExyckYyRC96?=
 =?utf-8?B?K3prRncra05DYXoyclgySDZsWlcxYXJhbkp1NDkyMzkrS09yMVZXV2w1Nk8v?=
 =?utf-8?B?d0k2OUY1S1JoSmZpUmo0a3l5NVlhcDN6WUc5dEduc2hEWVFzOEhTWStlWEFn?=
 =?utf-8?Q?X7XP4yyM/8rDUmhhHMjwKnJTy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41f0e7d5-cc1f-4bb4-a26c-08ddc9f907c1
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6391.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 14:55:57.3621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0K971LWuTC6S3/ZAiCtiQMzsIumOPZtEfMi1ji4lYdd6PsjPFAhIupe+jwSnorcfMax93wHo5N+PT6Ac1r7xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6555

On 7/21/2025 12:04 PM, Dave Jiang wrote:
> Remove from core/pci_aer.c and move the CONFIG_PCIEAER_CXL ifdef to
> cxlpci.h to deal with the exported symbols as needed. There is enough
> AER handling code (and more to come) to move the AER code to its own
> C file.
> 
> Cc: Robert Richter <rrichter@amd.com>
> Cc: Terry Bowman <terry.bowman@amd.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v2:
> - Address 0-day reprot of cxl_handle_rdport_errors symbol undefined
> ---
>  drivers/cxl/core/Makefile  |   1 +
>  drivers/cxl/core/core.h    |   9 ++
>  drivers/cxl/core/pci.c     | 171 +------------------------------------
>  drivers/cxl/core/pci_aer.c | 168 ++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h          |   8 --
>  drivers/cxl/cxlpci.h       |   8 ++
>  tools/testing/cxl/Kbuild   |   1 +
>  7 files changed, 189 insertions(+), 177 deletions(-)
>  create mode 100644 drivers/cxl/core/pci_aer.c
> 
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 79e2ef81fde8..bcea856157af 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -21,3 +21,4 @@ cxl_core-$(CONFIG_CXL_REGION) += region.o
>  cxl_core-$(CONFIG_CXL_MCE) += mce.o
>  cxl_core-$(CONFIG_CXL_FEATURES) += features.o
>  cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += edac.o
> +cxl_core-$(CONFIG_PCIEAER_CXL) += pci_aer.o
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 29b61828a847..96c319c66a48 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -136,4 +136,13 @@ int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
>  		    u16 *return_code);
>  #endif
>  
> +#ifdef CONFIG_PCIEAER_CXL
> +void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds);
> +#else
> +static inline void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) {}
> +#endif
> +
> +void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base);
> +bool __cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base);
> +
>  #endif /* __CXL_CORE_H__ */
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index b50551601c2e..bd78369bc3f4 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -664,8 +664,7 @@ void read_cdat_data(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
>  
> -static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
> -				 void __iomem *ras_base)
> +void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
>  {
>  	void __iomem *addr;
>  	u32 status;
> @@ -707,8 +706,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
>   * Log the state of the RAS status registers and prepare them to log the
>   * next error status. Return 1 if reset needed.
>   */
> -static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
> -				  void __iomem *ras_base)
> +bool __cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
>  {
>  	u32 hl[CXL_HEADERLOG_SIZE_U32];
>  	void __iomem *addr;
> @@ -746,171 +744,6 @@ static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
>  	return __cxl_handle_ras(cxlds, cxlds->regs.ras);
>  }
>  
> -#ifdef CONFIG_PCIEAER_CXL
> -
> -static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
> -{
> -	resource_size_t aer_phys;
> -	struct device *host;
> -	u16 aer_cap;
> -
> -	aer_cap = cxl_rcrb_to_aer(dport->dport_dev, dport->rcrb.base);
> -	if (aer_cap) {
> -		host = dport->reg_map.host;
> -		aer_phys = aer_cap + dport->rcrb.base;
> -		dport->regs.dport_aer = devm_cxl_iomap_block(host, aer_phys,
> -						sizeof(struct aer_capability_regs));
> -	}
> -}
> -
> -static void cxl_dport_map_ras(struct cxl_dport *dport)
> -{
> -	struct cxl_register_map *map = &dport->reg_map;
> -	struct device *dev = dport->dport_dev;
> -
> -	if (!map->component_map.ras.valid)
> -		dev_dbg(dev, "RAS registers not found\n");
> -	else if (cxl_map_component_regs(map, &dport->regs.component,
> -					BIT(CXL_CM_CAP_CAP_ID_RAS)))
> -		dev_dbg(dev, "Failed to map RAS capability.\n");
> -}
> -
> -static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
> -{
> -	void __iomem *aer_base = dport->regs.dport_aer;
> -	u32 aer_cmd_mask, aer_cmd;
> -
> -	if (!aer_base)
> -		return;
> -
> -	/*
> -	 * Disable RCH root port command interrupts.
> -	 * CXL 3.0 12.2.1.1 - RCH Downstream Port-detected Errors
> -	 *
> -	 * This sequence may not be necessary. CXL spec states disabling
> -	 * the root cmd register's interrupts is required. But, PCI spec
> -	 * shows these are disabled by default on reset.
> -	 */
> -	aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
> -			PCI_ERR_ROOT_CMD_NONFATAL_EN |
> -			PCI_ERR_ROOT_CMD_FATAL_EN);
> -	aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
> -	aer_cmd &= ~aer_cmd_mask;
> -	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
> -}
> -
> -/**
> - * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
> - * @dport: the cxl_dport that needs to be initialized
> - * @host: host device for devm operations
> - */
> -void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
> -{
> -	dport->reg_map.host = host;
> -	cxl_dport_map_ras(dport);
> -
> -	if (dport->rch) {
> -		struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport->dport_dev);
> -
> -		if (!host_bridge->native_aer)
> -			return;
> -
> -		cxl_dport_map_rch_aer(dport);
> -		cxl_disable_rch_root_ints(dport);
> -	}
> -}
> -EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
> -
> -static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
> -					  struct cxl_dport *dport)
> -{
> -	return __cxl_handle_cor_ras(cxlds, dport->regs.ras);
> -}
> -
> -static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
> -				       struct cxl_dport *dport)
> -{
> -	return __cxl_handle_ras(cxlds, dport->regs.ras);
> -}
> -
> -/*
> - * Copy the AER capability registers using 32 bit read accesses.
> - * This is necessary because RCRB AER capability is MMIO mapped. Clear the
> - * status after copying.
> - *
> - * @aer_base: base address of AER capability block in RCRB
> - * @aer_regs: destination for copying AER capability
> - */
> -static bool cxl_rch_get_aer_info(void __iomem *aer_base,
> -				 struct aer_capability_regs *aer_regs)
> -{
> -	int read_cnt = sizeof(struct aer_capability_regs) / sizeof(u32);
> -	u32 *aer_regs_buf = (u32 *)aer_regs;
> -	int n;
> -
> -	if (!aer_base)
> -		return false;
> -
> -	/* Use readl() to guarantee 32-bit accesses */
> -	for (n = 0; n < read_cnt; n++)
> -		aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));
> -
> -	writel(aer_regs->uncor_status, aer_base + PCI_ERR_UNCOR_STATUS);
> -	writel(aer_regs->cor_status, aer_base + PCI_ERR_COR_STATUS);
> -
> -	return true;
> -}
> -
> -/* Get AER severity. Return false if there is no error. */
> -static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
> -				     int *severity)
> -{
> -	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
> -		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
> -			*severity = AER_FATAL;
> -		else
> -			*severity = AER_NONFATAL;
> -		return true;
> -	}
> -
> -	if (aer_regs->cor_status & ~aer_regs->cor_mask) {
> -		*severity = AER_CORRECTABLE;
> -		return true;
> -	}
> -
> -	return false;
> -}
> -
> -static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
> -{
> -	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> -	struct aer_capability_regs aer_regs;
> -	struct cxl_dport *dport;
> -	int severity;
> -
> -	struct cxl_port *port __free(put_cxl_port) =
> -		cxl_pci_find_port(pdev, &dport);
> -	if (!port)
> -		return;
> -
> -	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
> -		return;
> -
> -	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
> -		return;
> -
> -	pci_print_aer(pdev, severity, &aer_regs);
> -
> -	if (severity == AER_CORRECTABLE)
> -		cxl_handle_rdport_cor_ras(cxlds, dport);
> -	else
> -		cxl_handle_rdport_ras(cxlds, dport);
> -}
> -
> -#else
> -static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
> -#endif
> -
>  void cxl_cor_error_detected(struct pci_dev *pdev)
>  {
>  	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> diff --git a/drivers/cxl/core/pci_aer.c b/drivers/cxl/core/pci_aer.c
> new file mode 100644
> index 000000000000..cf1e9377752e
> --- /dev/null
> +++ b/drivers/cxl/core/pci_aer.c



Hi Dave,

While adding this into my series and looking closer, I believe that pci_aer.c filename does not accurately reflect its content. 
The only AER-related code pertains to CX1.1, which is now a corner case. The AER driver, not CXL driver, logs AER errors for 
all other scenarios. There is no AER processing in the CXL driver except for CXL1.1 dports.

Most of the code in this file is related to or will be directed towards CXL RAS. It's important to note that AER and 
RAS are distinct and separate registers, with CXL RAS only utilizing the AER interrupt notification and UIE/CIE. 

I am concerned we are conflating AER and RAS, which may be misleading for others. We have other instances of this 
confusion, such as in the cxl_aer_correctable_error() and cxl_aer_uncorrectable_error() functions, which log RAS instead of AER.

My series aims to clarify the distinction between AER and CXL errors, categorizing CXL errors as a separate error class. 
At the least, can we add a documentation block at the top to indicate this source file provides functionality for 
CXL RAS?

-Terry

> @@ -0,0 +1,168 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2025 AMD Corporation. All rights reserved. */
> +/* Copyright(c) 2025 Intel Corporation. All rights reserved. */
> +#include <linux/pci.h>
> +#include <linux/aer.h>
> +#include <cxlpci.h>
> +#include <cxlmem.h>
> +#include <cxl.h>
> +#include "core.h"
> +
> +static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
> +{
> +	resource_size_t aer_phys;
> +	struct device *host;
> +	u16 aer_cap;
> +
> +	aer_cap = cxl_rcrb_to_aer(dport->dport_dev, dport->rcrb.base);
> +	if (aer_cap) {
> +		host = dport->reg_map.host;
> +		aer_phys = aer_cap + dport->rcrb.base;
> +		dport->regs.dport_aer = devm_cxl_iomap_block(host, aer_phys,
> +						sizeof(struct aer_capability_regs));
> +	}
> +}
> +
> +static void cxl_dport_map_ras(struct cxl_dport *dport)
> +{
> +	struct cxl_register_map *map = &dport->reg_map;
> +	struct device *dev = dport->dport_dev;
> +
> +	if (!map->component_map.ras.valid)
> +		dev_dbg(dev, "RAS registers not found\n");
> +	else if (cxl_map_component_regs(map, &dport->regs.component,
> +					BIT(CXL_CM_CAP_CAP_ID_RAS)))
> +		dev_dbg(dev, "Failed to map RAS capability.\n");
> +}
> +
> +static void cxl_disable_rch_root_ints(struct cxl_dport *dport)
> +{
> +	void __iomem *aer_base = dport->regs.dport_aer;
> +	u32 aer_cmd_mask, aer_cmd;
> +
> +	if (!aer_base)
> +		return;
> +
> +	/*
> +	 * Disable RCH root port command interrupts.
> +	 * CXL 3.0 12.2.1.1 - RCH Downstream Port-detected Errors
> +	 *
> +	 * This sequence may not be necessary. CXL spec states disabling
> +	 * the root cmd register's interrupts is required. But, PCI spec
> +	 * shows these are disabled by default on reset.
> +	 */
> +	aer_cmd_mask = (PCI_ERR_ROOT_CMD_COR_EN |
> +			PCI_ERR_ROOT_CMD_NONFATAL_EN |
> +			PCI_ERR_ROOT_CMD_FATAL_EN);
> +	aer_cmd = readl(aer_base + PCI_ERR_ROOT_COMMAND);
> +	aer_cmd &= ~aer_cmd_mask;
> +	writel(aer_cmd, aer_base + PCI_ERR_ROOT_COMMAND);
> +}
> +
> +/**
> + * cxl_dport_init_ras_reporting - Setup CXL RAS report on this dport
> + * @dport: the cxl_dport that needs to be initialized
> + * @host: host device for devm operations
> + */
> +void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
> +{
> +	dport->reg_map.host = host;
> +	cxl_dport_map_ras(dport);
> +
> +	if (dport->rch) {
> +		struct pci_host_bridge *host_bridge = to_pci_host_bridge(dport->dport_dev);
> +
> +		if (!host_bridge->native_aer)
> +			return;
> +
> +		cxl_dport_map_rch_aer(dport);
> +		cxl_disable_rch_root_ints(dport);
> +	}
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
> +
> +static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
> +					  struct cxl_dport *dport)
> +{
> +	return __cxl_handle_cor_ras(cxlds, dport->regs.ras);
> +}
> +
> +static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
> +				       struct cxl_dport *dport)
> +{
> +	return __cxl_handle_ras(cxlds, dport->regs.ras);
> +}
> +
> +/*
> + * Copy the AER capability registers using 32 bit read accesses.
> + * This is necessary because RCRB AER capability is MMIO mapped. Clear the
> + * status after copying.
> + *
> + * @aer_base: base address of AER capability block in RCRB
> + * @aer_regs: destination for copying AER capability
> + */
> +static bool cxl_rch_get_aer_info(void __iomem *aer_base,
> +				 struct aer_capability_regs *aer_regs)
> +{
> +	int read_cnt = sizeof(struct aer_capability_regs) / sizeof(u32);
> +	u32 *aer_regs_buf = (u32 *)aer_regs;
> +	int n;
> +
> +	if (!aer_base)
> +		return false;
> +
> +	/* Use readl() to guarantee 32-bit accesses */
> +	for (n = 0; n < read_cnt; n++)
> +		aer_regs_buf[n] = readl(aer_base + n * sizeof(u32));
> +
> +	writel(aer_regs->uncor_status, aer_base + PCI_ERR_UNCOR_STATUS);
> +	writel(aer_regs->cor_status, aer_base + PCI_ERR_COR_STATUS);
> +
> +	return true;
> +}
> +
> +/* Get AER severity. Return false if there is no error. */
> +static bool cxl_rch_get_aer_severity(struct aer_capability_regs *aer_regs,
> +				     int *severity)
> +{
> +	if (aer_regs->uncor_status & ~aer_regs->uncor_mask) {
> +		if (aer_regs->uncor_status & PCI_ERR_ROOT_FATAL_RCV)
> +			*severity = AER_FATAL;
> +		else
> +			*severity = AER_NONFATAL;
> +		return true;
> +	}
> +
> +	if (aer_regs->cor_status & ~aer_regs->cor_mask) {
> +		*severity = AER_CORRECTABLE;
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
> +void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
> +{
> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> +	struct aer_capability_regs aer_regs;
> +	struct cxl_dport *dport;
> +	int severity;
> +
> +	struct cxl_port *port __free(put_cxl_port) =
> +		cxl_pci_find_port(pdev, &dport);
> +	if (!port)
> +		return;
> +
> +	if (!cxl_rch_get_aer_info(dport->regs.dport_aer, &aer_regs))
> +		return;
> +
> +	if (!cxl_rch_get_aer_severity(&aer_regs, &severity))
> +		return;
> +
> +	pci_print_aer(pdev, severity, &aer_regs);
> +
> +	if (severity == AER_CORRECTABLE)
> +		cxl_handle_rdport_cor_ras(cxlds, dport);
> +	else
> +		cxl_handle_rdport_ras(cxlds, dport);
> +}
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 3f1695c96abc..73397da7f970 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -759,14 +759,6 @@ struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
>  					 struct device *dport_dev, int port_id,
>  					 resource_size_t rcrb);
>  
> -#ifdef CONFIG_PCIEAER_CXL
> -void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport);
> -void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
> -#else
> -static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
> -						struct device *host) { }
> -#endif
> -
>  struct cxl_decoder *to_cxl_decoder(struct device *dev);
>  struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
>  struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 54e219b0049e..5f73ce42a758 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -135,4 +135,12 @@ void read_cdat_data(struct cxl_port *port);
>  void cxl_cor_error_detected(struct pci_dev *pdev);
>  pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  				    pci_channel_state_t state);
> +
> +#ifdef CONFIG_PCIEAER_CXL
> +void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host);
> +#else
> +static inline void cxl_dport_init_ras_reporting(struct cxl_dport *dport,
> +						struct device *host) { }
> +#endif
> +
>  #endif /* __CXL_PCI_H__ */
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index 31a2d73c963f..54b49d8e6b40 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -68,6 +68,7 @@ cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
>  cxl_core-$(CONFIG_CXL_MCE) += $(CXL_CORE_SRC)/mce.o
>  cxl_core-$(CONFIG_CXL_FEATURES) += $(CXL_CORE_SRC)/features.o
>  cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += $(CXL_CORE_SRC)/edac.o
> +cxl_core-$(CONFIG_PCIEAER_CXL) += $(CXL_CORE_SRC)/pci_aer.o
>  cxl_core-y += config_check.o
>  cxl_core-y += cxl_core_test.o
>  cxl_core-y += cxl_core_exports.o
> 
> base-commit: 347e9f5043c89695b01e66b3ed111755afcf1911

