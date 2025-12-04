Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013024.outbound.protection.outlook.com [40.107.201.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FEE285C8E
	for <linux-cxl@vger.kernel.org>; Thu,  4 Dec 2025 17:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764868152; cv=fail; b=P6JFYS4offq4K8G2TkSSVvACdYKbL9/O2BqahCetuTmYre1lNRJCl7pVttqPKKlte0p6CvJvR9DfI6PMhGgiF9YE1AkZSBS5t2kUHO4hxt5BoF4V+4+5dmWAK3FqIjmxIXKZkZkOsBHHuEbnsDjdhfpIz9cptssq/tsftqDRads=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764868152; c=relaxed/simple;
	bh=3q763wn87299vv86M/d24TTeZppQ85t1PSi79N1f1x4=;
	h=Message-ID:Date:From:Subject:To:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m6q802Gqc6lQW8QBZKech5dvkMOFoFj9P39nQ7LViejzvQDZjUjWvIfRb46HOgmURf3KG5Bqm4rcfIrq7nNQo2u65pYSbHten+K+ww2D4pwnbadsiaUk2/YjpEbF81xDDL+/ShE0uvAsbHGvwl33kGX/yHIpoBSmTq+xNVYC0ZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=C2+p8CoX; arc=fail smtp.client-ip=40.107.201.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="C2+p8CoX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o2cvMkv0GF94CutGmtUHK4dcFq1r0YI8jioem+y0evOkvgq6zZtj2nXZHUke5Hmcdl/SExlaUJ6JSeS1YxqU+G03DxwhKH2wRYaw8kej7b4wU479k4l95U8gZMwuE7z4pSPIbXdp7KEfC97u5Tx7lJGnYNhdek38e0PzE1KbVpjL2jPQNv04mmw3OsN5HFD0isNBss6Enn88sMM5y4ehbyOFyVOv8FyvrIz/UeNCgg/fkT7yHMxKmW+2kE3gCfrzsii6TBhHrPZI5bOekd8YVFVVimdoVuCYY98y2t5lal4JNMitMiIfqmZ9StZK0pnH+QQCkAe1CncTMBvoCT2STg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ei9iA/MWIWWD/tEZ+CMM+A7Rk5/7mQPyMWUeYdiMR68=;
 b=pdd5Me1wbrf4EqQtmhetCCx+s7pQCeusVLdVyeaQqdGYONkSEnmAaJGq5PzXqxtIQGEWV73ruZdI10AUZ2w6gcTOKIx+g4LQ6nPL+VxVQFufYHb4fZ3u4e53vQy9dSUeE9/sv98NSgFUZxMz+8tt/jXvB1WItUfSKDHkDSpiRWehgT1sg9Y+OjCJliLWgyu+WANv6oBhJicYRP+epT8xK8z+AhxuJsdfIeakVpT9wkBfL/jCmnI2fHp33rB6Nk25QG7ZcEkgTnL9PL4kTbFQDcehIhbRMpwoaCZZjJ/uRj0xEMQzaeTf3ot9y2d/9E2QvP9MZdrZl7C3bVo9oIjZnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ei9iA/MWIWWD/tEZ+CMM+A7Rk5/7mQPyMWUeYdiMR68=;
 b=C2+p8CoXSmtLYNNZfEfuXeMTNyPqzhi7U0I9Dj7oMPuvt+28dXOsG7WIqYM01Es1EuwKqod6Ed2WhmVrF/650gjwiuggXl0E2BQQGsNxDhu/NIDHzfEO/exgYLv8isS39aEXHCLghNHbTUonCivKZft0Le6XF96CbOMfMRdTYm4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH8PR12MB9766.namprd12.prod.outlook.com (2603:10b6:610:2b6::10)
 by LV3PR12MB9402.namprd12.prod.outlook.com (2603:10b6:408:213::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 17:09:07 +0000
Received: from CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14]) by CH8PR12MB9766.namprd12.prod.outlook.com
 ([fe80::499:541e:a7d8:8c14%5]) with mapi id 15.20.9388.003; Thu, 4 Dec 2025
 17:09:04 +0000
Message-ID: <a012db59-9c69-4300-b14c-79aa31b91882@amd.com>
Date: Thu, 4 Dec 2025 11:08:20 -0600
User-Agent: Mozilla Thunderbird
From: "Bowman, Terry" <terry.bowman@amd.com>
Subject: Re: [RESEND v13 25/25] CXL/PCI: Disable CXL protocol error interrupts
 during CXL Port cleanup
To: dan.j.williams@intel.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 dave.jiang@intel.com, alison.schofield@intel.com, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 alucerop@amd.com, ira.weiny@intel.com
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-26-terry.bowman@amd.com>
 <691e86a8a1cb5_1a375100fe@dwillia2-mobl4.notmuch>
Content-Language: en-US
In-Reply-To: <691e86a8a1cb5_1a375100fe@dwillia2-mobl4.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0139.namprd03.prod.outlook.com
 (2603:10b6:5:3b4::24) To CH8PR12MB9766.namprd12.prod.outlook.com
 (2603:10b6:610:2b6::10)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH8PR12MB9766:EE_|LV3PR12MB9402:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b0057db-3b50-495f-1603-08de3357d3c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDMwZzNYYUZPRW9MVi9zbmRKcm80SVduRWpiK2o5Tm9yRkJTbmZBajNGZEtG?=
 =?utf-8?B?OWxITU84Nm42UVlXTmxZdFJ5VGI2L0VraGlRM1QwcDFRTkdJVUk5a096OFE4?=
 =?utf-8?B?U0VGVytFZmp0dGRTYU1pbVZ0TCtFNmNsTWxvM0tseDA2dnNUc3Q1L1VTWit2?=
 =?utf-8?B?ZEw0NFRSeEtFQ3JDWExvYXUzVlZBVy9GbGdTRVF1enhNbVlGOTR1ek16MlM0?=
 =?utf-8?B?RkNCT1RLeXZmRDMwODR6OHJBaEZScEtjUmh1WXZIdnRJQy9hWi82WGtray9u?=
 =?utf-8?B?MHpERzlYVFp4UTR0blB1WEw2czhGYytSV1NQMVhqQTBYT1h5ZXlubGJHS3Bj?=
 =?utf-8?B?R01NU2ozYjgza0RZVnJWMm5rdTBuQzBibzRscEZvaXNUd3ZxVnRsRWtpRERF?=
 =?utf-8?B?MXN5U1lPRzNXc3RoeWUvY0lFVlh0NWozanBlRG9jYS91cElTOVlNRFRXd3pC?=
 =?utf-8?B?ZGVQWWV0RzcwQ3RzMXFQQVUxa09vdXlJUnVIMnhnK0JWTGc0eGdpb3NjSUt6?=
 =?utf-8?B?dTZGa2Q1SkFnTUt2dGZYQ3BpRU82dVBLSkFwTlRORjNFd3VnRndZcUR2UnJK?=
 =?utf-8?B?R3JFcll1MDFaeXBBVzU2ejg5LzRmS1kvMDJidjhySDloYVF3dS95TmtPb0dD?=
 =?utf-8?B?emNsNm9JcTBneXhHYnZaTUgySUxCVDZrVmpoN0F6STE2WFM4THNmeDI2Q2N1?=
 =?utf-8?B?MG1KK1lhenVoU2lZU2NnL3lCNjQ4c1lqbnZpTi9FYTVGN1FBVWNsWHoybFRU?=
 =?utf-8?B?aGIwaFBHRjI0Rm91dXAyeERUM0p0VjlKcEk0aVkxRVFvZSsxekt4RlZKbmFM?=
 =?utf-8?B?UjRxSmtDNksybG04T0ZwbDVTWkMwaUp0eGNJVmlXSGxiY3VXZ0pvOGVlemZ1?=
 =?utf-8?B?UnZJcHU3UFQxaHhwQUdvZ1Z0U0tPTDcrakhQTmpWQ2hUTTdWOTlkY2djbGNV?=
 =?utf-8?B?eTJqS2NONWs2NGJPc01FRGJjRTZ3NldROGFoc2hEb1dpdkwvM05teWxYMFFw?=
 =?utf-8?B?Y3pPWGRPSkdpb2Q1cU1TNzFqQzljaTBHOE5yVjJ1Tzg2NkswU1Q3Mmc2N3R0?=
 =?utf-8?B?N2sxaHJFNWRYM0Y2RWV2N282WWorS2J5S1FiK3NCRFRjUUZSOFB1bUR2bFlz?=
 =?utf-8?B?ck1mVGdFS3VBTHk3MkJSMkxOWUtaMmM1MmpVUFRlUGoyREpPVFlQVmdnbTl5?=
 =?utf-8?B?aEJud1V5cVJiVFdFa3dWOUFiNUU2aVF4aTQxVlFYRnlOeTJrckNJMHpXNHhK?=
 =?utf-8?B?R2R6MVAzNWZqazVHM1cxNlBwdE4ybWZDQkl5cFVsSk9SdUk1OFZwL2xpNGN1?=
 =?utf-8?B?dGh3MnJaNjkya2lmaXpYK0FuZzdxa1VQckErdGNSVHBuUk84MXFSTnRkOEVw?=
 =?utf-8?B?UUxrdlFpVi9wV3RzQ3VGM0p2QVM3RGpWM3p1K3VGM3RIYkNqQXBrL3VhTEpW?=
 =?utf-8?B?bzFtMUVJSjhUc2NIREh6MnJrdlBRUDY5RWhiUHhTSFV1T1RpVlB4NkM4Y056?=
 =?utf-8?B?VEdjVDBvOE1FaDJvM0tJNGV2Rkx0L0xuV1R6d0ErTVlsS2Y0ZlZpYlZNcnVx?=
 =?utf-8?B?K0tsMGs2K24yV1hJTFp5QUM3WFdZOG9JcS9DZm9KUllFSzF6Nklla0M3ZXA5?=
 =?utf-8?B?NFRYWGRJRnNPZFZNUWRYazNCV2dNemg4ckdYdkN2WDhFL0RpdnlMQVB4emdJ?=
 =?utf-8?B?N3ZLWmlHNkhxZUUwa0FZdk9TN0JaSlZrdFoxSDZsUStYdXdlLysrbS9ZT0hJ?=
 =?utf-8?B?M1oycDMyekZqNTI4ZGJrUWxpMjlBeWphWk03LzR4ZXRVMTA3ckVBdHZyQkc0?=
 =?utf-8?B?YjVUbDRwSnR2R2Z0dElTSzZkYzdlM2Y2N0pkY3BWMy9TSFlQM0ZyK29QKzhz?=
 =?utf-8?B?SCtLOFhEK0ZCNVNkZE14U1B2eFpWQXJwT2xnaHVPai96dXlFVWloRitTRHdk?=
 =?utf-8?B?N0JLY29vNFVxTnorT0ZVUUY4MzYyZXd2QmJxOVk1bzV1T2U4RWxYZy9ES3FG?=
 =?utf-8?Q?OOQ6Y1v9fghGj+kuseL1PsjX8SFtAk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH8PR12MB9766.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1QzTTcvOTVyb2xqOENCY3RZU3ZVbERqcW1US1R2RVBtcUE5dkJTTmo3dnVy?=
 =?utf-8?B?SnJZMG1JTmh3aEtYSm1vQlYxS2k2VnlydjNIdUtWY0NFWDNja1NqeU1ZRnlV?=
 =?utf-8?B?ZWpqSTNIQWEyRU5ENkI1VnlvZjBOMmtWRmZWemVBRUZxYjFBR3RpVk9nK0hQ?=
 =?utf-8?B?OXJ2YVFWUCtRRk9WUmxWdFFkaWZpcGYxSE1UMm5NajdScENncGtlcVhMeEdn?=
 =?utf-8?B?Qm5lODJ2eDFYUU1jUEMxayswb054VlJ4bUJxMm1DcEt0WmdnNFRmZzVtMU05?=
 =?utf-8?B?aHJvUmFlb3J2bFJFV1JrYmlsZ1EvYytMQk9tMzNWTFVXTjUvRVBYSmRhbTVu?=
 =?utf-8?B?UGNuay9SQ2RnYUlJU2pKaTNRUEVFRmEyNjlmMFYrK2ZoZEM2K05mSjdXM0ow?=
 =?utf-8?B?aHdkMnE3Ym1nY2tYdmNBZmRFOVBEZElOWG8xVWZwL2ZkM1NmbHErQVVPdnQ0?=
 =?utf-8?B?MXRUTWxZeCtQc2FldGVXSHlXa1ZhTTBnWktuR25uMGRmU3RRNkNDejd3Zlo0?=
 =?utf-8?B?ekxUZVJ2eFJUZXJXV3ljeFFmanFOS21RRk5EU2RvUkZ0QXV6MGhTeEdZZGxF?=
 =?utf-8?B?TTFQNWxYaHU3ekRYWlg1UXFuOWNBUXkvd2JCQjBISU42RjlXaFFLdjZYSFoy?=
 =?utf-8?B?SDVJNGVDTGlrRXpaeFFQalM3cFVzbjZUL3RDUlJycEJZYWtHaU5VNzZMT1RM?=
 =?utf-8?B?aVBqaWZHQTNMeTQ3cVB4K0lyODJVM2g1WWdod09OU1JYbXRrS2lmMm5weEQ3?=
 =?utf-8?B?TmFEZ09VOVVyZXVlb0pSdXh2YlVmQmtTbTlOM0YrQUZ0WUhJM0pvVEVTUGFh?=
 =?utf-8?B?VlIyRkN1ZkJqa3Y3a3JnQ0RPTTdkdzhhdGxEYnJwbkdvZytMdnVFSDV2Zksy?=
 =?utf-8?B?ZmU3eVV4RzJWMWhMcGdYbzRoSVg1Vm13MkNHU0w2RHRVRW9vRWlXVW9OUDJ5?=
 =?utf-8?B?WWlWV3BhaUx4QVVITGVVWWk1RjVXbHg4clZkR0d1QndhbFhEWENBQTZCYTVX?=
 =?utf-8?B?dFZma1RUbFdGZkQzVUR2MEhIWTlKTnZhd0VmUGd6YmRNWCtDdnM0d05saTFE?=
 =?utf-8?B?Vkd5WE9YeFdDQU5aanVwUm8vK1Iwc1p6b0p6ZS9MdERRcW1IU2FZUDlMb0dV?=
 =?utf-8?B?eXNYbHNzbEY5T2ZWajlURCtjcmJyaXRVekZ0bHJoRTMvNmtFSnNOeklyRnpH?=
 =?utf-8?B?aElEMHVtYXBaQVVEa0FuOE84eDhYUTZYMXE4OUNqRDQ2ZitrK2JVK1NhTE9q?=
 =?utf-8?B?RENvUkp0ZnljVGRTTkhDVE9ham43VlVxSFRXeGVsc1ZkRDQ1UjFHSkFuWW5r?=
 =?utf-8?B?eU5hZWlJdUlDZlpPNTEySkdZK2I0Vm1STGRtU3JvaGUvWGIzM0ZNZlQrWk5h?=
 =?utf-8?B?ckFvVUNLTkRjK3Bjd1VzZ3plczIvVTdTQ29rRWF5SU96QlFvd2ttSVVUS2kr?=
 =?utf-8?B?T3A2R2hxemZqTGRhd0x2TU91UlRwaEwrZzRQTHQ3TE9uVElrQnZXMmFTeHJB?=
 =?utf-8?B?VHJudUd1WWNSdit6c0ZMNjAzV0hCODc5K0V0UTM5MkpNMnhOOWovd0sySEpO?=
 =?utf-8?B?dElTQXFKazVKK2hhMlBheTlxaFkzUW52VlpXb1QyaDZJN3p4N2xJMUpLT3ps?=
 =?utf-8?B?Y2RRT0J4S01LazJnZnZ4S2lEaEk0bVBLeXQ5N0ttelJoMHZRNUx4ZFQwSkVq?=
 =?utf-8?B?NkFLZnpqZFhHWlJ6d0p6KzdOSHA0cUxxbVp4aWtXVTNPSGtNbUlsTll3YmdP?=
 =?utf-8?B?bWMyNnlMVEt3WUl5Sy95K3dmcHBLUjFXbnZ4ODZaVUIyQVdkY1BHV2lIOWdx?=
 =?utf-8?B?Z1UyemR5VXBaSTAzVGprKzFjL2tvd0NvMVcxNFdvV2ppWThWbHNxV0NwOFl2?=
 =?utf-8?B?NWhLalpaaVk3dEpjTHNEZUliL1pnZ0QwelJIZ0dIRVgzN0kxWWJkbm0zTUti?=
 =?utf-8?B?R0FZdzRiWnFBc2t2Q2xBQy9HMUU0cEJaWlk5bFdxTnYwbWV1OWRyTnRlRmMx?=
 =?utf-8?B?LzdTVGVyUy8rY0s4b1VRYUdLQnFtZTd2cVZLR2dRWXBRY3ZoOTYveEpuUVBz?=
 =?utf-8?B?OHpzNmRrSzVnYU1pdXBvempTSCtTT1hJMWM0eDdERXdRZ3ZSVzBUUDJKOU1N?=
 =?utf-8?Q?w1ImwRAAP2vAGQ0qSQaEhFNV3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b0057db-3b50-495f-1603-08de3357d3c7
X-MS-Exchange-CrossTenant-AuthSource: CH8PR12MB9766.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 17:09:04.2457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PnyvETfMhNG5jMinJtNPVTp8gzsYgBct4MtfSHYeWeYS6O1kZDvcIQOWXrUdf8vV/X4I/aTrLB6ZtzfEuY9O+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9402



On 11/19/2025 9:10 PM, dan.j.williams@intel.com wrote:
> Terry Bowman wrote:
>> During CXL device cleanup the CXL PCIe Port device interrupts remain
>> enabled. This potentially allows unnecessary interrupt processing on
>> behalf of the CXL errors while the device is destroyed.
>>
>> Disable CXL protocol errors by setting the CXL devices' AER mask register.
>>
>> Introduce pci_aer_mask_internal_errors() similar to pci_aer_unmask_internal_errors().
>> Add to the AER service driver allowing other subsystems to use.
>>
>> Introduce cxl_mask_proto_interrupts() to call pci_aer_mask_internal_errors().
>> Add calls to cxl_mask_proto_interrupts() within CXL Port teardown for CXL
>> Root Ports, CXL Downstream Switch Ports, CXL Upstream Switch Ports, and CXL
>> Endpoints. Follow the same "bottom-up" approach used during CXL Port
>> teardown.
> This comes across as too much special case sprinkling.
>
> If it is just the cxl_port teardown case then the simple answer is only
> enable interrupts at cxl_port::probe() time and disable them at
> cxl_port::remove() time.
>
> Can you clarify the exact nature of the unwanted interrupts because the
> PCI core does not manage AER interrupts in the same way. It only ever
> enables interrupts for root ports, so I am confused why CXL needs to
> manage interrupts on a per-dport basis.
>
> Maybe cxl_mask_proto_interrupts() is misnamed because the device is
> never enabled to send interrupts. I think is just mask AER events,
> right?
>
> In any case I think this belongs right next to the code that maps and
> unmaps dports. The endpoint case should be handled by the endpoint probe
> and remove handlers.
>
> Also, if this is really a problem this patch should be moved earlier in
> the series before the kernel starts unmasking these new event sources.
> Otherwiwse, a bisect run will start hitting spurious events if it lands
> in the middle of this series.

I didn't observe any issues but thought it was needed. Thanks for the 
explanation. I will remove this patch.

The call path for enabling is below (masking will be removed):
cxl_unmask_proto_interrupts() -> pci_aer_unmask_internal_errors()

-Terry



