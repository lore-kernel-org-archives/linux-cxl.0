Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4771120CCC0
	for <linux-cxl@vger.kernel.org>; Wed,  4 Dec 2024 16:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733330016; cv=fail; b=glJ1xeJqPi9ixu0AYn+mjLcxFfce9NP7weJhWp0vXe4xF5YaDf4Yi/4dPy+ZtSB813V9TapZISEdjCdR1vlIHmv4MIM5EZ07uOZieQNLESkTPVe8UOJ7Xvspih0jbtBQEPx5J8L8pDKsqHKX7/W+NL1v9HDb4QZPVdNLiD1llZ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733330016; c=relaxed/simple;
	bh=mbmvshzmNxNtwAW6LhhjbXfCMvddmmzxfGtkJkREpy8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dk70JebsDOmQxlNuCM1XoT3O+O++h7i6qq9jMQg7T797vpBY3exXyR0mHD9gLKzYE9rWpUFfWlCSvXJm9aIaglYwsP4BkO/eVm4qJup+oVprHWbVCXGfNgxsx7nsyKgaL0CVOTh+vRFe9OUoNGJPNCvJ4C5O9yRMdJlOj8MTHYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CElVePCx; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CElVePCx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t05J62tEyoldmp2AKH5N6KeakEt9eSxZ1Ak/RO1oAs0BJ2zkzPkuxgqdxAJ21jIDNgG7xn2DFAIC6yCm8hq+E3Oj745k0BGWtqI5YGpcHZthmKfuo5PkBfWgkDa7HHeWl2qFW8C5/cBM/SG3tKcLpAUDdICVBCl1BER5rYUUvwe3qxaY0jHh+eRS0FqU8TpyYi/i5RQBkF2HIfyD3GENEGXSrC0KRdf/GsyV2IUdAtqsrVd4KbvU31q/OvqdKUG29ENNgMQFFPi3uSCY9y5b1bT+3h9DUyO4kp4gXQz1oerZ24WHh8sqqRq3ZWTPNwPQer+oSePaXqA95czAFxxzHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nWsaZZK2aASjHstHPDkq3qcoNqJ5uaJ+5edDIsWOiCQ=;
 b=Jb4ADu1KcJSY9VTmvn1EKvYDvV1rjHR5f5hcADHIE++0aEKxjmXgK+i2ZDkxqvxQ13WIeleOo6R8QFOBmifnfGCwmg3e3QXKNq61NiI34Sch2nCrXbr7XBQkvLQ+myRpzTamzXrQkCg6FzfVABlLO97cpg/Ulgibk+8JGOdOyjw/Hhxt6Fn7y62FNie1nGRMHURFgVwrChJ69PZ2dSpFaUtpw4PIKkr1uQVWhfmK1cuW14Ommisv1VdfqmhExcuJHo2xC/qg2ZfEKc8eHTbsNuoqR0eQ5M2tFAIEx/flUJfJRpAFMlC8UEvqX+os+9oQeGLeJA3ZPkj1NBi+X+JB5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nWsaZZK2aASjHstHPDkq3qcoNqJ5uaJ+5edDIsWOiCQ=;
 b=CElVePCxkfOCoA6qBfSqTyXyBSA1qryF3AFqO4V5/25o3TshqNsK7X30VGJQNIzykx26ciWzUgNA3TrGhs6HtuBQinjuwvRIDkekHFRw0HVP8iQ3FIb22topFC2K4PkLHwSiEOrJQo4sn5fnIaaQsDofKA2S20KT+LcrmZvZiFg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19)
 by DM4PR12MB5769.namprd12.prod.outlook.com (2603:10b6:8:60::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.20; Wed, 4 Dec 2024 16:33:27 +0000
Received: from MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::4044:a263:92a1:6b3e]) by MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::4044:a263:92a1:6b3e%3]) with mapi id 15.20.8207.017; Wed, 4 Dec 2024
 16:33:27 +0000
Message-ID: <84758a54-fe7b-46d9-848b-ca416051a570@amd.com>
Date: Wed, 4 Dec 2024 10:33:24 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: Update Soft Reserved resources upon region creation
To: Fan Ni <nifan.cxl@gmail.com>, Nathan Fontenot <nathan.fontenot@amd.com>
Cc: alison.schofield@intel.com, dan.j.williams@intel.com,
 linux-cxl@vger.kernel.org, linux-mm@kvack.org
References: <20241202155542.22111-1-nathan.fontenot@amd.com>
 <Z04C1JDl7N2wES5A@smc-140338-bm01>
Content-Language: en-US
From: "Fontenot, Nathan" <nafonten@amd.com>
In-Reply-To: <Z04C1JDl7N2wES5A@smc-140338-bm01>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0118.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::6) To MN0PR12MB6222.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::19)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6222:EE_|DM4PR12MB5769:EE_
X-MS-Office365-Filtering-Correlation-Id: 21239297-07dc-4372-262b-08dd14816110
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Qit4R3QvdzZRMjJEY2RxcnMyb1hXYnBmditMZjZsZi9NdndDa2ZyU0Zicm5L?=
 =?utf-8?B?SlFJcjIzNnJXZXUyV1RHcmZoM2VFZUJCclU3V2tYQ25FZVJNWW9TZU9qYStm?=
 =?utf-8?B?OG5XUWxrZ3BFUmNJeDBZMU1UUUgvaU5UeXlFbmdBSVFHbXFEYXQzVjc4MVA1?=
 =?utf-8?B?SXNRZytVNFg4MjJUOFlaaWFqcVpXMjJManU3V1lJZm1JelRzekdybXVGdmQz?=
 =?utf-8?B?dVBXOXZaTWh4d2grVk5IdVFoa1dOUndRYTBONjB6eUZYdnUxbkJ1aVAyMkVs?=
 =?utf-8?B?QzFyMXRIcnErRC8yb1dyeCtSWTVVamVuczhtd0ZqRFRiOW9hTEJFMmRvc1ZN?=
 =?utf-8?B?UkxBT3JRd2UvanNtR0tvRVppeEl6YUlUK3ptLzFIL3NCQVpMZGRTU0hWN1ls?=
 =?utf-8?B?c0tCV0RlMVdPVEJ4akZlTG5vRUtBOHdQMGJhOGdUWVNsanJiS1ZxQmdnOTM2?=
 =?utf-8?B?MFBUVnV0dkhyVVU4QXczTjZUY25hMDBxYmExZjQ5bVdEZkJjQi9tYkg4RWhY?=
 =?utf-8?B?VTdpMFYvVXR0WDI1U0tldXA5OXRaU3lHUytITGRWRUN3d1gwTlZ6TVl1ekIr?=
 =?utf-8?B?V0JrVXBPWXZHZlpDMmtrRHdXNkxKVElVdHNLaEF6ZWJXOHpEZ2dhRXdxWWJC?=
 =?utf-8?B?eWdRYUUvckY0N2dZeUdTSzhOVU4wVjdrdFY4NXdpVFpNcUZNNGdzME9sMmRB?=
 =?utf-8?B?c0ZpcjljSFFpVWtMbExpaGFaWUpxRnk5TURoc25pMFlTazYvRzUrcW1IYmlU?=
 =?utf-8?B?ZmZqYnFCZU1Vd2ZtMEYzTWNBWjdyb0hUSkdXam8rRGV6RFRJTjd3b1VyOUZj?=
 =?utf-8?B?cGk5SXBaUlFuYWgrSTdBV2xMbUVpUlMzeWVqZ1o1VWlnb0NDdHRNNjE1b21O?=
 =?utf-8?B?WWNUL1N0TEo0NE5Ec3pmRTlvaUUvQ0txbVBPU016M1kvejMrSFRXS2FkbkVm?=
 =?utf-8?B?WkhIZGZxbDBTd2RPQ3ExaGswNTNaOUpBQW1pbzNOSW5vS1R5VWIwbGFuUGpu?=
 =?utf-8?B?T2kwRzFvOG9CamtsTXZJMXhkMGNDbXhtZWZVRE9oZjFPY3B6S29XME5iM0lu?=
 =?utf-8?B?SnF0NVJyaU1yRkUyTmIxdWs4MVo4cTBzN2ZtR0ZQY1R3WnFDZkNPOFVaRVE2?=
 =?utf-8?B?MG1YUVJVT25WbTN5NVlrK1ExWXZneUFkcGs2WmIwQk1Bb3QxdkpGN1lOVGcr?=
 =?utf-8?B?WEd3R0FFaW9ZWGoyYWh4WmdIZ29IOW5JYnJjQ0I3emo2OEtZQ0hoSFVRWjRF?=
 =?utf-8?B?Y0NDMHpnUEZ6UjRIaUdVK3VMQkJhY2RpcUlMcmROYXZsaHduN1NjVkY5NmJM?=
 =?utf-8?B?Y1pSQ2lzbGZ2YnFpTURLQ2RSSGRWOFVJZVJZb1lvSnJDQWh2dGNRd0M3YmhH?=
 =?utf-8?B?akM2UTYyTktqVXlNTWVYc0lYaEZLVE9OWDFYdC9nOUptT0E3aFNNS29BSC9Y?=
 =?utf-8?B?eVh4dGhjYm11aHd4YkFoM25FbjJLNGtQbWpDQXBmdEVBV0QzWnBwM1JWRG8x?=
 =?utf-8?B?RDZaS0JDcVpZMXZNL2VTQS9NT3pJbDNSYzZYcm56T0VRanM3SGI3TjYxRGFD?=
 =?utf-8?B?RVJGSldtZFhGSGk3eDVjcUtWT0dWV0htVWpqdXNERkxWTWllTmp0MnFlUE9S?=
 =?utf-8?B?N0JQNXJiSytsc2lvbWNEQW9wMHNNSU83WE1aK0RoYm1mQjJUaEMyTDFaeEVk?=
 =?utf-8?B?Y0VNcnlmdHY5eVNkeWFHQWl5NUNQRXlxTWVRM252UzhVVG9XRllwR2RhaWFO?=
 =?utf-8?B?RkM5MU1UVElkcnhDZyszVGE0Z2V0cFE1ZHlXd2phc1RrL3R2bXRBcmNiRlNM?=
 =?utf-8?B?U0Y0RGJOSU9uc0UyMFFpZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6222.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TVR3aEd5dU1MRWlOZjZudHU5c3hHV3hSOWdWT1BPT2tWS1dhV2J4Yi9ESHlS?=
 =?utf-8?B?eDdPUmI1ZGNWMXkvV2cyZ2V1N3ZETVBTZVI5WkZvL2xGZldNTGR3QWlxZi9E?=
 =?utf-8?B?RXB2c0VUenpGZlUzMEk5UHg3RFJxMGVXaGhId2ZtOTQzQzVwbWYrZHNuRU43?=
 =?utf-8?B?SHdISWUrZjlhWHROZy94TDMrbEpOZExSVmk5STFEYjlCamFnNmd6cXJ1L21n?=
 =?utf-8?B?RHNoVFVBVyt3QjJ1R3NCcWkyMWNIbkduQTdMSEpsK3UzdjZpUmFNSlZsU0xY?=
 =?utf-8?B?enVESlp2OHcxRW81elM3WTAwYTQwT2t6QnZtc000amtVNThZTTRyTVFwU1B4?=
 =?utf-8?B?eXlBMDRBMnlEWU5sRi8xcytUTWRzaU5aeUpIWGxvTndEN2pVdHZpUHpRYVJt?=
 =?utf-8?B?WFA3NXF6cWZUS3Jwc1RWVDZ1QXRiNnZCeFlrc01HQlYyUW96N2NmdFFZVktz?=
 =?utf-8?B?dG1TZHkyYm11ckNIaXRQQUZLNVcydGRPcU45MXkwTjJyUThjdDVPNzVyTlA0?=
 =?utf-8?B?RmlLb0Y0eThGWXNaMjhqUitvWjJFVytNN1Z2VjlneHVROWswb2hRcVNVVWRp?=
 =?utf-8?B?MDczRjhxRUQxbldvZThZNGFYYnZYcE9uTWJsaGh3L0FWMmJWQXNZZW05cUdD?=
 =?utf-8?B?aXIyc0JnS0J3NUhFQnp3eFBZeG91SFhCdCtvdWVyVXduUHFxVU5rdUtPRHI0?=
 =?utf-8?B?NjdFVU5NN25vdnp5b2NtRlZCZUlZaHUwcWlsM0dhcW1tbFUzSkVtOVowbVpK?=
 =?utf-8?B?U1kyT3dKOGJrbHJxU0lib251OWxwZXE3TmM5NzAyR0x2dllISGJXSkozaHpC?=
 =?utf-8?B?VmdNbnAxOTRTODlhSEhMYmJ6YXdvR0EzQVI3VU1udldUK2ZRTkRrTVlQZmMy?=
 =?utf-8?B?YTJjcmRPQzBQM2l4Z0VYNTVkdnlvUHVDRTlZei9INjBUY0xSVkxqUElKa1Er?=
 =?utf-8?B?RWh4QXVvVUVZcjRvM3pHWk44TEpISXphQ05oU1crdExoRXdvWld5ZUllMTla?=
 =?utf-8?B?M05kQURuS1d3czh1K1k1dEpHV1hidnROM2FUekErY2JZL0Z2aHgrY0NwK1gy?=
 =?utf-8?B?Z2RhWjcrUnZWZ0d6OXVBMkVUVmZFNjhwa3prSHh5WjBYR2Y3elV1aXcweGVz?=
 =?utf-8?B?Qk1YZXVka3JscXhrUVRxM2VhYzlZbkptM2NkOVd3bWR2aXE3Y2JQM2ZqK2JK?=
 =?utf-8?B?OHpHN0F4VTJWV1BZQXdXNm91bzlqMHlLQXN4SkFtWnhGcjhVaWVuSmk2Y21t?=
 =?utf-8?B?YklJeGx1QUJleGhVNCtnTVRnZXRaUWw0bnpwTS9rSTU5cGFzdHQzL2EvTmh5?=
 =?utf-8?B?aXc2Qm53Q2Y0MWNlbERJM2J1aXhxVkFsL1dBWDEyaTQyUSt0U0Z4ZlBWejBX?=
 =?utf-8?B?c3pDT1dpc0o3TGVkMndYR1hWVU1zT2NGcytSVi9xckZZVFlVbGRqekNzUHlU?=
 =?utf-8?B?MzdKYzdwUGpaQVUzSXM4WHdwUVVpdmFDcUFlL2NOK3lCSmVVMUVJdEtUT3Fs?=
 =?utf-8?B?cGVjeWdBaFI4UlZvM0dwWHlJL2lFV3A1c3FoaGZUOGN4REVvOTM3RnNvdnVT?=
 =?utf-8?B?dkNxMjE4Z05WcGZ2UEdacllLRkhtTEFKR1R5ejBpWEg1WUwyRkNxdFhaVGZQ?=
 =?utf-8?B?bXhiblpKT3ZTQWNrREgrYkJqYjloY3JPZ3FEdHNSNkJqZ2MyVTZVcEQ0UXNX?=
 =?utf-8?B?RmRuRjkxRDBoUjZwM2Y5eGNtakw4UXM3bjBNSWlxQWFZOTBrNWdkMWtJaXA2?=
 =?utf-8?B?VEVSc0F1VkdoT21ESWRFLzFaRFEwZi9jY29nT2lHT2tLenJxNGg3M3lYTkVQ?=
 =?utf-8?B?M0RaSi9DUXY0bHl2MWZOdk81K0NIODIyTFZoTldxRytub0JCamd3dU9Oam1B?=
 =?utf-8?B?NjBYU0x2ekRQL2VMYmdmL285MlNQeGtFbFBObllOYW0vZjFTRlY3Z3NNQlNa?=
 =?utf-8?B?dVdUUm5jS0dSUDEwVGdLb29SVmhGNE1BMTdVYm1iVjAxVDkrZUpaTkl6eXpp?=
 =?utf-8?B?bGJoeTNWMiszbGNUL2k3d0lwcERQZmVuSzR5VFdRTEl1VTJDenlOTUozaUpX?=
 =?utf-8?B?QmVFaVpua1dNbzlzajlGRnFzcjZ1RmpDYi9pSHJxQmJsQXBjWUNqRDgzaytC?=
 =?utf-8?Q?tvzOExwlPVrqmU1HggFERlUpA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21239297-07dc-4372-262b-08dd14816110
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6222.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 16:33:26.9890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JV17FqhpSLIQbFfzkgcxwZ1YF68Di7BtSjgqpmpVixufJPWEosrKiNefRaKDpPW8ph9s6sNn+BLzAb6ZaxIJrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5769



On 12/2/2024 12:56 PM, Fan Ni wrote:
> On Mon, Dec 02, 2024 at 09:55:42AM -0600, Nathan Fontenot wrote:
>> Update handling of SOFT RESERVE iomem resources that intersect with
>> CXL region resources to remove the intersections from the SOFT RESERVE
>> resources. The current approach of leaving the SOFT RESERVE
>> resource as is can cause failures during hotplug replace of CXL
>> devices because the resource is not available for reuse after
>> teardown of the CXL device.
>>
>> The approach is to trim out any pieces of SOFT RESERVE resources
>> that intersect CXL regions. To do this, first set aside any SOFT RESERVE
>> resources that intersect with a CFMWS into a separate resource tree
>> during e820__reserve_resources_late() that would have been otherwise
>> added to the iomem resource tree.
>>
>> As CXL regions are created the cxl resource created for the new
>> region is used to trim intersections from the SOFT RESERVE
>> resources that were previously set aside.
>>
>> Once CXL device probe has completed ant remaining SOFT RESERVE resources
> /ant/any/
>> remaining are added to the iomem resource tree. As each resource
>> is added to the oiomem resource tree a new notifier chain is invoked
> /oiomem/iomem/

I'll fix spelling mistakes for next version.

>> to notify the dax driver of newly added SOFT RESERVE resources so that
>> the dax driver can consume them.
> 
> In general, the patch is kind of complicated and hard to review for me.
> I am wondering if it can be broken down to make it easier to
> review.

I had thought about possibly breaking this into a few patches but wanted to get it
out for review. I'll split it up for the next version.

> 
> One minor thing inline.
> 
>>
>> Signed-off-by: Nathan Fontenot <nathan.fontenot@amd.com>
>> ---
>>  arch/x86/kernel/e820.c    |  17 ++++-
>>  drivers/cxl/core/region.c |   8 +-
>>  drivers/cxl/port.c        |  15 ++++
>>  drivers/dax/hmem/device.c |  13 ++--
>>  drivers/dax/hmem/hmem.c   |  15 ++++
>>  drivers/dax/hmem/hmem.h   |  11 +++
>>  include/linux/dax.h       |   4 -
>>  include/linux/ioport.h    |   6 ++
>>  kernel/resource.c         | 155 +++++++++++++++++++++++++++++++++++++-
>>  9 files changed, 229 insertions(+), 15 deletions(-)
>>  create mode 100644 drivers/dax/hmem/hmem.h
>>
>> diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
>> index 4893d30ce438..cab82e9324a5 100644
>> --- a/arch/x86/kernel/e820.c
>> +++ b/arch/x86/kernel/e820.c
>> @@ -1210,14 +1210,23 @@ static unsigned long __init ram_alignment(resource_size_t pos)
>>  
>>  void __init e820__reserve_resources_late(void)
>>  {
>> -	int i;
>>  	struct resource *res;
>> +	int i;
>>  
>> +	/*
>> +	 * Prior to inserting SOFT_RESERVED resources we want to check for an
>> +	 * intersection with potential CXL resources. Any SOFT_RESERVED resources
>> +	 * that do intersect a potential CXL resource are set aside so they
>> +	 * can be trimmed to accommodate CXL resource intersections and added to
>> +	 * the iomem resource tree after the CXL drivers have completed their
>> +	 * device probe.
>> +	 */
>>  	res = e820_res;
>> -	for (i = 0; i < e820_table->nr_entries; i++) {
>> -		if (!res->parent && res->end)
>> +	for (i = 0; i < e820_table->nr_entries; i++, res++) {
>> +		if (res->desc == IORES_DESC_SOFT_RESERVED)
>> +			insert_soft_reserve_resource(res);
>> +		else if (!res->parent && res->end)
>>  			insert_resource_expand_to_fit(&iomem_resource, res);
>> -		res++;
> Maybe we can keep the original (res++) here to avoid the noise since it is a
> style thing and does not affect what we want to achieve. 

Yes, I can make that change.

-Nathan

> 
> Fan
>>  	}
>>  
>>  	/*
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 21ad5f242875..c458a6313b31 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -3226,6 +3226,12 @@ static int match_region_by_range(struct device *dev, void *data)
>>  	return rc;
>>  }
>>  
>> +static int insert_region_resource(struct resource *parent, struct resource *res)
>> +{
>> +	trim_soft_reserve_resources(res);
>> +	return insert_resource(parent, res);
>> +}
>> +
>>  /* Establish an empty region covering the given HPA range */
>>  static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>  					   struct cxl_endpoint_decoder *cxled)
>> @@ -3272,7 +3278,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>>  
>>  	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
>>  				    dev_name(&cxlr->dev));
>> -	rc = insert_resource(cxlrd->res, res);
>> +	rc = insert_region_resource(cxlrd->res, res);
>>  	if (rc) {
>>  		/*
>>  		 * Platform-firmware may not have split resources like "System
>> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
>> index d7d5d982ce69..4461f2a80d72 100644
>> --- a/drivers/cxl/port.c
>> +++ b/drivers/cxl/port.c
>> @@ -89,6 +89,20 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>>  	return -ENXIO;
>>  }
>>  
>> +static void cxl_sr_update(struct work_struct *w)
>> +{
>> +	merge_soft_reserve_resources();
>> +}
>> +
>> +DECLARE_DELAYED_WORK(cxl_sr_work, cxl_sr_update);
>> +
>> +static void schedule_soft_reserve_update(void)
>> +{
>> +	int timeout = 5 * HZ;
>> +
>> +	mod_delayed_work(system_wq, &cxl_sr_work, timeout);
>> +}
>> +
>>  static int cxl_endpoint_port_probe(struct cxl_port *port)
>>  {
>>  	struct cxl_endpoint_dvsec_info info = { .port = port };
>> @@ -140,6 +154,7 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>>  	 */
>>  	device_for_each_child(&port->dev, root, discover_region);
>>  
>> +	schedule_soft_reserve_update();
>>  	return 0;
>>  }
>>  
>> diff --git a/drivers/dax/hmem/device.c b/drivers/dax/hmem/device.c
>> index f9e1a76a04a9..c45791ad4858 100644
>> --- a/drivers/dax/hmem/device.c
>> +++ b/drivers/dax/hmem/device.c
>> @@ -4,6 +4,7 @@
>>  #include <linux/module.h>
>>  #include <linux/dax.h>
>>  #include <linux/mm.h>
>> +#include "hmem.h"
>>  
>>  static bool nohmem;
>>  module_param_named(disable, nohmem, bool, 0444);
>> @@ -17,6 +18,9 @@ static struct resource hmem_active = {
>>  	.flags = IORESOURCE_MEM,
>>  };
>>  
>> +struct platform_device *hmem_pdev;
>> +EXPORT_SYMBOL_GPL(hmem_pdev);
>> +
>>  int walk_hmem_resources(struct device *host, walk_hmem_fn fn)
>>  {
>>  	struct resource *res;
>> @@ -35,7 +39,6 @@ EXPORT_SYMBOL_GPL(walk_hmem_resources);
>>  
>>  static void __hmem_register_resource(int target_nid, struct resource *res)
>>  {
>> -	struct platform_device *pdev;
>>  	struct resource *new;
>>  	int rc;
>>  
>> @@ -51,15 +54,15 @@ static void __hmem_register_resource(int target_nid, struct resource *res)
>>  	if (platform_initialized)
>>  		return;
>>  
>> -	pdev = platform_device_alloc("hmem_platform", 0);
>> -	if (!pdev) {
>> +	hmem_pdev = platform_device_alloc("hmem_platform", 0);
>> +	if (!hmem_pdev) {
>>  		pr_err_once("failed to register device-dax hmem_platform device\n");
>>  		return;
>>  	}
>>  
>> -	rc = platform_device_add(pdev);
>> +	rc = platform_device_add(hmem_pdev);
>>  	if (rc)
>> -		platform_device_put(pdev);
>> +		platform_device_put(hmem_pdev);
>>  	else
>>  		platform_initialized = true;
>>  }
>> diff --git a/drivers/dax/hmem/hmem.c b/drivers/dax/hmem/hmem.c
>> index 5e7c53f18491..d626b60a9716 100644
>> --- a/drivers/dax/hmem/hmem.c
>> +++ b/drivers/dax/hmem/hmem.c
>> @@ -5,6 +5,7 @@
>>  #include <linux/pfn_t.h>
>>  #include <linux/dax.h>
>>  #include "../bus.h"
>> +#include "hmem.h"
>>  
>>  static bool region_idle;
>>  module_param_named(region_idle, region_idle, bool, 0644);
>> @@ -123,8 +124,22 @@ static int hmem_register_device(struct device *host, int target_nid,
>>  	return rc;
>>  }
>>  
>> +static int dax_hmem_cb(struct notifier_block *nb, unsigned long action,
>> +		       void *arg)
>> +{
>> +	struct resource *res = arg;
>> +
>> +	return hmem_register_device(&hmem_pdev->dev,
>> +				    phys_to_target_node(res->start), res);
>> +}
>> +
>> +static struct notifier_block hmem_nb = {
>> +	.notifier_call = dax_hmem_cb
>> +};
>> +
>>  static int dax_hmem_platform_probe(struct platform_device *pdev)
>>  {
>> +	register_soft_reserve_notifier(&hmem_nb);
>>  	return walk_hmem_resources(&pdev->dev, hmem_register_device);
>>  }
>>  
>> diff --git a/drivers/dax/hmem/hmem.h b/drivers/dax/hmem/hmem.h
>> new file mode 100644
>> index 000000000000..95583b59cef7
>> --- /dev/null
>> +++ b/drivers/dax/hmem/hmem.h
>> @@ -0,0 +1,11 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +#ifndef _HMEM_H
>> +#define _HMEM_H
>> +
>> +typedef int (*walk_hmem_fn)(struct device *dev, int target_nid,
>> +			    const struct resource *res);
>> +int walk_hmem_resources(struct device *dev, walk_hmem_fn fn);
>> +
>> +extern struct platform_device *hmem_pdev;
>> +
>> +#endif
>> diff --git a/include/linux/dax.h b/include/linux/dax.h
>> index 9d3e3327af4c..119b4e27a592 100644
>> --- a/include/linux/dax.h
>> +++ b/include/linux/dax.h
>> @@ -282,8 +282,4 @@ static inline void hmem_register_resource(int target_nid, struct resource *r)
>>  {
>>  }
>>  #endif
>> -
>> -typedef int (*walk_hmem_fn)(struct device *dev, int target_nid,
>> -			    const struct resource *res);
>> -int walk_hmem_resources(struct device *dev, walk_hmem_fn fn);
>>  #endif
>> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
>> index 6e9fb667a1c5..487371a46392 100644
>> --- a/include/linux/ioport.h
>> +++ b/include/linux/ioport.h
>> @@ -14,6 +14,7 @@
>>  #include <linux/compiler.h>
>>  #include <linux/minmax.h>
>>  #include <linux/types.h>
>> +#include <linux/notifier.h>
>>  /*
>>   * Resources are tree-like, allowing
>>   * nesting etc..
>> @@ -249,6 +250,11 @@ struct resource *lookup_resource(struct resource *root, resource_size_t start);
>>  int adjust_resource(struct resource *res, resource_size_t start,
>>  		    resource_size_t size);
>>  resource_size_t resource_alignment(struct resource *res);
>> +extern void trim_soft_reserve_resources(const struct resource *res);
>> +extern void merge_soft_reserve_resources(void);
>> +extern int insert_soft_reserve_resource(struct resource *res);
>> +extern int register_soft_reserve_notifier(struct notifier_block *nb);
>> +extern int unregister_soft_reserve_notifier(struct notifier_block *nb);
>>  static inline resource_size_t resource_size(const struct resource *res)
>>  {
>>  	return res->end - res->start + 1;
>> diff --git a/kernel/resource.c b/kernel/resource.c
>> index a83040fde236..8fc4121a1887 100644
>> --- a/kernel/resource.c
>> +++ b/kernel/resource.c
>> @@ -30,7 +30,7 @@
>>  #include <linux/string.h>
>>  #include <linux/vmalloc.h>
>>  #include <asm/io.h>
>> -
>> +#include <linux/acpi.h>
>>  
>>  struct resource ioport_resource = {
>>  	.name	= "PCI IO",
>> @@ -48,7 +48,15 @@ struct resource iomem_resource = {
>>  };
>>  EXPORT_SYMBOL(iomem_resource);
>>  
>> +struct resource srmem_resource = {
>> +	.name	= "Soft Reserved mem",
>> +	.start	= 0,
>> +	.end	= -1,
>> +	.flags	= IORESOURCE_MEM,
>> +};
>> +
>>  static DEFINE_RWLOCK(resource_lock);
>> +static DEFINE_RWLOCK(srmem_resource_lock);
>>  
>>  static struct resource *next_resource(struct resource *p, bool skip_children)
>>  {
>> @@ -1034,6 +1042,151 @@ int adjust_resource(struct resource *res, resource_size_t start,
>>  }
>>  EXPORT_SYMBOL(adjust_resource);
>>  
>> +static BLOCKING_NOTIFIER_HEAD(soft_reserve_chain);
>> +
>> +int register_soft_reserve_notifier(struct notifier_block *nb)
>> +{
>> +	return blocking_notifier_chain_register(&soft_reserve_chain, nb);
>> +}
>> +EXPORT_SYMBOL(register_soft_reserve_notifier);
>> +
>> +int unregister_soft_reserve_notifier(struct notifier_block *nb)
>> +{
>> +	return blocking_notifier_chain_unregister(&soft_reserve_chain, nb);
>> +}
>> +EXPORT_SYMBOL(unregister_soft_reserve_notifier);
>> +
>> +static int soft_reserve_notify(unsigned long val, void *v)
>> +{
>> +	struct resource *res = v;
>> +
>> +	pr_info("Adding Soft Reserve resource %pr\n", res);
>> +	return blocking_notifier_call_chain(&soft_reserve_chain, val, v);
>> +}
>> +
>> +static void trim_soft_reserve(struct resource *sr_res,
>> +			      const struct resource *res)
>> +{
>> +	struct resource *new_res;
>> +
>> +	if (sr_res->start == res->start && sr_res->end == res->end) {
>> +		release_resource(sr_res);
>> +		free_resource(sr_res);
>> +	} else if (sr_res->start == res->start) {
>> +		WARN_ON(adjust_resource(sr_res, res->end + 1,
>> +					sr_res->end - res->end));
>> +	} else if (sr_res->end == res->end) {
>> +		WARN_ON(adjust_resource(sr_res, sr_res->start,
>> +					res->start - sr_res->start));
>> +	} else {
>> +		/*
>> +		 * Adjust existing resource to cover the resource
>> +		 * range prior to the range to be trimmed.
>> +		 */
>> +		adjust_resource(sr_res, sr_res->start,
>> +				res->start - sr_res->start);
>> +
>> +		/*
>> +		 * Add new resource to cover the resource range for
>> +		 * the range after the range to be trimmed.
>> +		 */
>> +		new_res = alloc_resource(GFP_KERNEL);
>> +		if (!new_res)
>> +			return;
>> +
>> +		*new_res = DEFINE_RES_NAMED(res->end + 1, sr_res->end - res->end,
>> +					    "Soft Reserved", sr_res->flags);
>> +		new_res->desc = IORES_DESC_SOFT_RESERVED;
>> +		insert_resource(&srmem_resource, new_res);
>> +	}
>> +}
>> +
>> +void trim_soft_reserve_resources(const struct resource *res)
>> +{
>> +	struct resource *sr_res;
>> +
>> +	write_lock(&srmem_resource_lock);
>> +	for (sr_res = srmem_resource.child; sr_res; sr_res = sr_res->sibling) {
>> +		if (resource_contains(sr_res, res)) {
>> +			trim_soft_reserve(sr_res, res);
>> +			break;
>> +		}
>> +	}
>> +	write_unlock(&srmem_resource_lock);
>> +}
>> +EXPORT_SYMBOL(trim_soft_reserve_resources);
>> +
>> +void merge_soft_reserve_resources(void)
>> +{
>> +	struct resource *sr_res, *next;
>> +
>> +	write_lock(&srmem_resource_lock);
>> +	for (sr_res = srmem_resource.child; sr_res; sr_res = next) {
>> +		next = sr_res->sibling;
>> +
>> +		release_resource(sr_res);
>> +		if (insert_resource(&iomem_resource, sr_res))
>> +			pr_info("Could not add Soft Reserve %pr\n", sr_res);
>> +		else
>> +			soft_reserve_notify(0, sr_res);
>> +	}
>> +	write_unlock(&srmem_resource_lock);
>> +}
>> +EXPORT_SYMBOL(merge_soft_reserve_resources);
>> +
>> +struct srmem_arg {
>> +	struct resource *res;
>> +	int overlaps;
>> +};
>> +
>> +static int srmem_parse_cfmws(union acpi_subtable_headers *hdr,
>> +			     void *arg, const unsigned long unused)
>> +{
>> +	struct acpi_cedt_cfmws *cfmws;
>> +	struct srmem_arg *args = arg;
>> +	struct resource cfmws_res;
>> +	struct resource *res;
>> +
>> +	res = args->res;
>> +
>> +	cfmws = (struct acpi_cedt_cfmws *)hdr;
>> +	cfmws_res = DEFINE_RES_MEM(cfmws->base_hpa,
>> +				   cfmws->base_hpa + cfmws->window_size);
>> +
>> +	if (resource_overlaps(&cfmws_res, res)) {
>> +		args->overlaps += 1;
>> +		return 1;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static bool resource_overlaps_cfmws(struct resource *res)
>> +{
>> +	struct srmem_arg arg = {
>> +		.res = res,
>> +		.overlaps = 0
>> +	};
>> +
>> +	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, srmem_parse_cfmws, &arg);
>> +
>> +	if (arg.overlaps)
>> +		return true;
>> +
>> +	return false;
>> +}
>> +
>> +int insert_soft_reserve_resource(struct resource *res)
>> +{
>> +	if (resource_overlaps_cfmws(res)) {
>> +		pr_info("Reserving Soft Reserve %pr\n", res);
>> +		return insert_resource(&srmem_resource, res);
>> +	}
>> +
>> +	return insert_resource(&iomem_resource, res);
>> +}
>> +EXPORT_SYMBOL(insert_soft_reserve_resource);
>> +
>>  static void __init
>>  __reserve_region_with_split(struct resource *root, resource_size_t start,
>>  			    resource_size_t end, const char *name)
>> -- 
>> 2.43.0
>>
> 

