Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2086.outbound.protection.outlook.com [40.107.101.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955C725D552;
	Tue, 11 Mar 2025 14:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741704830; cv=fail; b=p7P1rXe5HZObackrI7jH8OSvEORzDyQ8e+uh23DvqCR5slYO7qdwoqzVhF16GhngY58qH1m8jbHyV+bRTIE7e/L4PqChsZtrnbVinjGjtTx1Ldx2k5aMWmo9cHLGgiE2vXPDw5Kv+P6rRh86yfHsCAfZYS4FUKtusfUPYdTjUCs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741704830; c=relaxed/simple;
	bh=+pZ+nCIPBTOxVyi0ck2181XCCJ0b1ZxL5aoVnKCluCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=omjJQZ/dQtOE8ubELuiNDQkfzT7HvsVfKp7vBWxwOpoQ/njGkrFr5ip2cZwpb1CPZptjzOK37EXi5wo8tOTDilGw/aktKTTycEXltkeQQgK3f6sbh5HLrcZVTY0WZ/nRn7CqMDpanccqpkZ/tz/RhJEIIsxIWaYJl2biVH7OZcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UHluf3vI; arc=fail smtp.client-ip=40.107.101.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UHluf3vI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SmoLMzze1kKrDBtiycHh0sI2MFDqQYDMWPq7md4syq4OuoI9P5imcftGSoBRlwQFjTqtgUfNGylJeSgjrBnWWrqZt8CMbZB8aSXzdTNv1ru5RnD8C7nxMrYHI377arR02gyYXOrD08Vw4k1/58sqMQXkzJ/W8/bGoiHA40E5vAwZ8D78mzEumfGrtHT/OdahmqjFYNshMChygoxE2YcWIwjj1NqSrfrjNa/NisOFDmUDNaNQxEOGda4AflfuHGARw0VeE9lWunBZvpewpLdJHPBciL4RfYFZCJ6CEOQqGkLzjWIgzP9SI4333BvqDjvmbFfps4Ih2oj9Hi6BzCVhxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWM6NtBuz1dhbeJ5l2vvjCo4+SLr2Gpr8O0xO2xy+9Q=;
 b=IntV6yWayl4V8vmPDPiPiZzUSstW0h2YLzclwogpDT1hf7z/LDWlsXNcpDD+8I6DvcRlC6jarKYBwrWGPEfp0qQp4ySvBIYgQvp72SLROgB3GcY3ru/n5VEoS8UVDBlYIU74sMxdlAnBcupWvhiMi6jkH502A84jDroj1h+/LlNXUpMunyBVKEWlifFr1Qq1eIXigwS0k2bE6D49cwz1KLPJ8Lr9d3l8T+4b4n7qMQPN92atB2mNQdth9xl+NJScZxYonmDvR/a6gzO7QdjtA8mQaAEJhoVRmYyVDB2/yHF4umTR2MouxG11+fVCfd5QD0qR5NXyJrQQIz29JvHlpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWM6NtBuz1dhbeJ5l2vvjCo4+SLr2Gpr8O0xO2xy+9Q=;
 b=UHluf3vI4SIDdVdtJas8XHJGFg0euwZWnkbofpzQQAoB6kGmYJIjkDgQGX/JW3DvweoVisaWSYBz3RJE+JxXyvHLysac4LMgt6urw8+/8brawCg2D2NmDSkhNe7shrsmwHU7/whSnKkvjrUOxrnwURriLagYkV/sGkSJevRmK4Rvx+ppo33bF6rC5kDtSWirce2s+CONmUJjlv4glCc3Q920v3UTR2nsQVI7t/lVKF6TzvB1p2vGBoZRmpQp9Lw6XJ0zJlMLrtE0wpd1vgeXtrmHNd+Eftxuj7gTvVwpaF419fR4Bg3i1Cxxxr695FwwnsQS8fi9Wlq16LOc9LmGkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CYYPR12MB8940.namprd12.prod.outlook.com (2603:10b6:930:bd::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.27; Tue, 11 Mar 2025 14:53:44 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 14:53:44 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>
Cc: Gregory Price <gourry@gourry.net>, Yang Shi <shy828301@gmail.com>,
 lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: CXL Boot to Bash - Section 3: Memory (block) Hotplug
Date: Tue, 11 Mar 2025 10:53:41 -0400
X-Mailer: MailMate (2.0r6233)
Message-ID: <0C5749C4-B3EE-4393-A8EA-AA56B399E9E3@nvidia.com>
In-Reply-To: <4ae838ee-b079-408e-8799-e9530ca50417@redhat.com>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z7OWmDXEYhT0BB0X@gourry-fedora-PF4VCD3F>
 <CAHbLzkq6Me6nRaL6b09YxJ_nFkxb+n+M3-q_aJwOs2ZO4q8VCg@mail.gmail.com>
 <Z7TLwtQY3vGUw2bO@gourry-fedora-PF4VCD3F>
 <1b4c6442-a2b0-4290-8b89-c7b82a66d358@redhat.com>
 <Z7TswQbpPV590ADr@gourry-fedora-PF4VCD3F>
 <bda4cf52-d81a-4935-b45a-09e9439e33b6@redhat.com>
 <CAHbLzkqDQcrHLPzk8n0SMgkidH2ByCqdwfYXX=uBPQfOArWf8A@mail.gmail.com>
 <Z7d3vVdJ8UWU5oex@gourry-fedora-PF4VCD3F>
 <4ae838ee-b079-408e-8799-e9530ca50417@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: PH7P221CA0058.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:33c::28) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CYYPR12MB8940:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e78f24e-c422-4555-ec05-08dd60ac857b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0NzMFZHT3VQWWJLeXdha2M3VGxxQWEweURJbnFvUjg0TTVzODVEY0VKVkoz?=
 =?utf-8?B?Zk83a2Zqd25PeEdtWU1DdXViUGtkaVVJblpvZTVoY1hoOVFkUEFxZ1NtY1pP?=
 =?utf-8?B?OHJFMWl0NzJKdENub3h6UmZWZS9rNWdUNUFKMmFxanhsWUFtcXpmMFpDNjM4?=
 =?utf-8?B?dDdOb3ZtdXg4ejBGQjltRWtmQ2RYZTZjV0pOVVNvUnZCeHJYRXlWTHR4NXhv?=
 =?utf-8?B?d3BsZC8zVlpTVFVSb2RIbm53U0ExMmx4eWVaakpGM09XazV3S1Y5YTlXZ21Q?=
 =?utf-8?B?emRTOVdneUxqZGJETVdVRWMyanhzMlV0QlVPbHdrbE5PUXlRdUZwQ25tZk5H?=
 =?utf-8?B?ZS9CUVFkam8yaWJscDd6aENWTUNVNFRkS210eE5YNktNVmNMeUs0YjRSVCt2?=
 =?utf-8?B?cjVXeGVYRXl2RWRPWFB2RUMvZGVIdzdnbkRMOWowR25xcmdZR2hvOFYwOG5i?=
 =?utf-8?B?MHNMV25TdHJzbklOYXEzZ012MzJCQnl5NzNZSzAxdndJUXJRNVUvNlkrTkps?=
 =?utf-8?B?WTVRK1h2Y2VVWUY5WGFleTl3dlh5TWZkVm42cVFNWXUvWm9WM05lYlphdWw5?=
 =?utf-8?B?QmlXNkp2aWl6eVNHTHAwU3RrVjFtSW1qSnVRN1N5cGYyU0xxRWpMb3pqZTFY?=
 =?utf-8?B?NHFKeTMyckF5OUVXVDNPQ0QyWTJvR0NZUkJGa1RMQ1dVMGM4ZmpxVkpnZVN0?=
 =?utf-8?B?dnVQbE9DcVBzcWdrQ0dQeERNN1lDYjM1dWoyajhzRXJTSElUK2xuMUxSVEp6?=
 =?utf-8?B?cWc1dUgrbVJrcStveGxVdWdJZTk2N3BmTGlVdGwyVldBQ3ZRTFVhL09VS2t3?=
 =?utf-8?B?dGJEcTdwWFBtVW1yMHl4MHlyZ1ZXSGZubnQ1OFVrblhvbldZWVNsc25HdDdy?=
 =?utf-8?B?emFqK2dZM2ZycXltNzZwUWhnWWExMmJ5YUJLaUprL0k4eDArNTJSQ2dvSjZS?=
 =?utf-8?B?dXFoc3BoT2xrdHgxTlNKVTRvdzloOU1VT1hpdm15Z3VFSGFycGlGbjBLUDVS?=
 =?utf-8?B?eUhtelRLYjFnaEJSS0hKM1h3OCtwMFE4c0xTTHRyUnBINkp4d3VLZ3UwYXJU?=
 =?utf-8?B?RUZPRFlxZWRvRGlZYnNSWERJWVNGd2hZNDZzQlpoeVR6QTBXd3IwTDVOZFNQ?=
 =?utf-8?B?OW85djVyWGtGY1hnWHdzalhCOE50VlRpT1FjcnJSNWJBL1d4bDdlV0lCZ0d5?=
 =?utf-8?B?NUI0UG1FZ1JqQzd3b0lTU2lmWFZkb0V2YmhVNkdCaHpIdGZjZWRKN3ExdWhy?=
 =?utf-8?B?eUxpbTBoZk5tZVpPZ1lJOWxyVWlSQnhkRHVWUStvektZV09uV2U0VWIreVBO?=
 =?utf-8?B?SU9leWhiU1dxUGpOdlM4Rm1ScERYZDRFMFlFNnh2b21lYk5kQjR1ejJNL29B?=
 =?utf-8?B?QVdLaUs4K2JWeENKd0F1cElVYXhCUUlLU0x4ZS9YOUNob1ZVdDNPZ3RmSU0w?=
 =?utf-8?B?RllkeUp0QUpNVlhScHFRZ1lnWlFJb3M2b0RBQ3dKTkJtc0xUMm9CbTdWNk94?=
 =?utf-8?B?ejNsc0V2N0RYOWVnem5zeVRpQ1AxdHVtWjZJMlI4L3hqaUJDa2JEdXNidnVC?=
 =?utf-8?B?cXNTSW9sRndlVWZpZUNVbkIwYWI5UGlZMmpGaUg5SHoxSHBIT3l5TGhsOWV2?=
 =?utf-8?B?YjlDeXViR0dLeEwwdERSd2w3Slh2TGhIcEQzTGlSbHpTZ0RJYlE5Q3NzSE1I?=
 =?utf-8?B?VUp2YTR6cDZ3dDByWXRXbHpmU2QwNmRWdVltdE8veUpNYlM2ZFF2Q25tSUll?=
 =?utf-8?B?cGNtdlZ3SkozR3ZSZnJIMU92dmlhdXhSR3pRZ253QkhGQ3VVQkJKaVByNFBm?=
 =?utf-8?B?KzFwaXhiMXVWNi9XMU9kbGRkSXgyVjZYU0FyY2I1L2lZQk51V2tNQm5NZ0VC?=
 =?utf-8?Q?kR9/s/JJLW7Vl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dVpTSTRWY3h2YnF0cXRGMGZ0THBVbXlaTjkxcDFrTWhuUnJlZERIL1ZieE1i?=
 =?utf-8?B?YTkvMllNckNvaEsydm9YZEFJWjBFUDdBZFp0Vi9zVnBwVzFocytleWdTV1E2?=
 =?utf-8?B?T0FaOXp0TWZjNWhOdzdyOEJYMlo1dnpDR0VZeE1XU240ZTlpQVpOdy9rcjlq?=
 =?utf-8?B?SmxtNXNZUXI4YVNpZy93K3pPbUhXZzZ2ajk3NjRUOWt6M3l4aVEwd1pUQ2tK?=
 =?utf-8?B?YTdmQ2Q4QmtFUld3RUw3YlU0ZGdoR3NhMzFZbnZHalFzOWxqYjFpYk02elMv?=
 =?utf-8?B?VjJOa2RZWTVhZTZxaHBYR0wxQUxvRUlORzNIam5WTkJKUDQ0RWJvTGY2S09C?=
 =?utf-8?B?MXdQSldxV3NldlROWEhVZHRnd1V3MTVNTmVNRktFaUUvN1F2VEVxTXZ3eCt4?=
 =?utf-8?B?Y1dyeWhlQkZHRFhrSmNWSW0yMjhnR0RYaExRVXdPUzNpdXJkcy90TFhRZnRY?=
 =?utf-8?B?QmJaNzZ4Y3EzQytCS3dTMERpUTBmRzZHRENiR2FLR2MwTldBVHd2aVNveXZQ?=
 =?utf-8?B?N2tuZTFVTUloUHlCSjFOMldPelJhdkxzRTM2YlMwSXoyNWViUWR3aTZPOFl6?=
 =?utf-8?B?Y2R6RW0rYXNyZHlobGUreS9tUVppUjlQdkp5bVlCY2lRS2RIY0pZVkhrOStv?=
 =?utf-8?B?bmNLSWcybFFOUmx2QU9uVHhMdGp3SzJ6SkdQS1d2MzBxdHNzZlFXdlZyRlZp?=
 =?utf-8?B?b0o0RTJCSWZJVTVibVpQT3hBUnlFMDlXMndZRVFqOURjZGROZ2hyaGFiWnk3?=
 =?utf-8?B?NG9RdVIzUWswc1JHampkWGhWK29XR2R0WXFEaHJYQnN4cG5SZVAwbFBqYlNs?=
 =?utf-8?B?QW43a1V5UVRGakdBTWFPUmc3WXFJVmxML1BLK283UmcyajB5UHcyekFuRG1j?=
 =?utf-8?B?NHhKZUpZYWduSUs2YjBqUUFpNEZTeDRnRnhxeUNkb250MHJ1MHBTWGhLYmlu?=
 =?utf-8?B?VjMzUDN1Zit3SnhDL1dVVDEycE1PWkZRc2ZhbXoyOFhNNXYwd3hBMkRHTmNX?=
 =?utf-8?B?R0hTUkQrTWtRRzA0ckw0SUdoRVNRcVltb1AyQVJ4cmxEb3VVc0FEajZSTnN0?=
 =?utf-8?B?Y1hza1JzZFpFOU5wWWlONjFmZUNZT3hRSGxZd2NTSnRjYW1lK1FNTDJqdDQv?=
 =?utf-8?B?eUNJSnRUN0kzS3JGVTFDS3VxK0wreGp3eXFVaDN5cUxFalVTV3pUSHdUais2?=
 =?utf-8?B?K2s2OUlBSnFLYzRMMlNzczhzVGFKTEhpbWVpcEk4M2d6am5Mb1JEYllIRlg2?=
 =?utf-8?B?N3NJMGpjNERzVkt3enNWL2kzbmxOdHEzNGhHbEFRSjRDZk90c0Mzb2FmMU9q?=
 =?utf-8?B?U2FDQlBybkNqMThBVFpPUDBBVUlQVi9vVHJvYnhlakFOT1diRnlwQ2psMDhF?=
 =?utf-8?B?ZUg1MEFvNWpRWVY4b1NFdE8yVzFnRC9ybXdvZEttU3lEdUJUNmxRN0h6M3Zo?=
 =?utf-8?B?ZS9xZEUxcXJOTktSVE9XQzdqSnU5SjRObFp4SnIzb1hObGZ6aDlSTHlUSmFo?=
 =?utf-8?B?VU9VUC9tZG96dHloNy96SEsrbGRKbFh2K0IvMkpuQ0hpZWlKdVhrV0x1b3RU?=
 =?utf-8?B?VUJJMEhSNkRROGpsbHhKdUl0YnJvYWF5VEluM0M3czg3RWp0QzZFdDNxVFg3?=
 =?utf-8?B?Z0xaejdHaXZXZ2tpeUhmZHF5UEdxMDFkM1JWNnlIbmtlQjhyajRiM2RUeWhI?=
 =?utf-8?B?MFh6aVdyR1U2YXA1d2hYdDlRYXVqVGVURkFPZERha2VXVGRrSVFGWUJpVHpy?=
 =?utf-8?B?VitpbjlRZTNZYlNuMHh3TDdxcVg2cnEyT3pDZW84d2NURzFiM2RNNytKcDRF?=
 =?utf-8?B?S3pobXlDY0ZjSk9TdnlTcXRqejJrOEEyODM5cFNpaEVZYXNybng4U1hSejJm?=
 =?utf-8?B?TzZxL1BTRHgxdVVmMGdqNEZOSXlvR0c1MHI4UE1OOGhEMmtBdzVPTHQxVHFK?=
 =?utf-8?B?ZGdocGN2Qy9EK2hYMHJ5eEVyWEJKVEVwcEJlcEdSNXVsakNPWXJRU2RRaWhj?=
 =?utf-8?B?Rk4xTDF5d3dPRDl4NHBiTEJHVncweE9hek1nY0REdWhZR2o0UEUzREI5Rm1G?=
 =?utf-8?B?Umh6OEdEVFJyZ3lnQzZEVlMzTXN1dy8xWEFTS1plaDlSWmQzaHc3ZzB5SDFs?=
 =?utf-8?Q?76y03+XGDboqeTEfecBs1lnFD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e78f24e-c422-4555-ec05-08dd60ac857b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 14:53:44.8026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: au0ZofFzL+cWqDMFV3Yf5R5gNoLrX9jTc6scPphNE+JBkWVjIF5ycB1Na7D68ohF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8940

On 20 Feb 2025, at 14:26, David Hildenbrand wrote:

> On 20.02.25 19:43, Gregory Price wrote:
>> On Thu, Feb 20, 2025 at 09:50:07AM -0800, Yang Shi wrote:
>>>>> I will double check that this isn't working as expected, and i'll dou=
ble
>>>>> check for a build option as well.
>>>>>
>>>>> stupid question - it sorta seems like you'd want this as the default
>>>>> setting for driver-managed hotplug memory blocks, but I suppose for
>>>>> very small blocks there's problems (as described in the docs).
>>>>
>>>> The issue is that it is per-memblock. So you'll never have 1 GiB range=
s
>>>> of consecutive usable memory (e.g., 1 GiB hugetlb page).
>>>
>>> Regardless of ZONE_MOVABLE or ZONE_NORMAL, right?
>>>
>>> Thanks,
>>> Yang
>>
>>  From my testing, yes.
>
> Yes, the only way to get some 1 GiB pages is by using larger memory block=
s (e.g., 2 GiB on x86-64), which comes with a different set of issues (esp.=
 hotplug granularity).

An alternative I can think of is to mark a hot-plugged memory block dedicat=
ed
to memmap and use it for new memory block=E2=80=99s memmap provision. In th=
is way,
a 256MB memory block can be used for 256MB*(256MB/4MB)=3D16GB hot plugged m=
emory.
Yes, it will waste memory before 256MB+16GB is online, but that might be
easier to handle than variable sized memory block, I suppose?

>
> Of course, only 1x usable 1 GiB page for each 2 GiB block.
>
> There were ideas in how to optimize that (e.g., requiring  a new sysfs in=
terface to expose variable-sized blocks), if anybody is interested, please =
reach out.


Best Regards,
Yan, Zi
