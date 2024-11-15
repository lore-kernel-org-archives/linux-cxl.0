Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BB51339A4
	for <linux-cxl@vger.kernel.org>; Fri, 15 Nov 2024 06:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731653123; cv=fail; b=RCqSbfBdkTyakM1yUsFEUq6Zub9KEeGEdVtpXMOjg9+S7NCGbb465m2jVBhMsQj4kQ1lQZv+ogRI9bEQul+OIqioo6LWusBrh0fIRTgmlDtCW0X5D90PZe4u2ZnDu3oV0yCPpxTlCdKkrtpVzARjzEPkj4JHnzGh01fpZItgzWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731653123; c=relaxed/simple;
	bh=21OmYmY3dS3ji6CWtiv/rSZh40cEIo/5VRn21dBoR6g=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mAQbCC9MQI2lierJHURRTMr92VzG/daZhKpFk66LShlvtJN/kCBQmyppyOUhBNgTt3B8kWrymMFWj6zG93iXga0Hdm6op4SyZCdYXTNZG+pIfP+WbPMWj26AVWcQKdDoCv79u/JPtLKkZzqF9A3rCorod6CEwkMs6A6YviMQEV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HWoz/WbI; arc=fail smtp.client-ip=40.107.243.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HWoz/WbI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gCGZqfDQCEnG5AYAlv+thymV9mSuLsV+7CNTlXE2ZWSjuZzp04hhj4TuhJ2YwoO4QPLqJhpnCedmbJoUMve3ru9LRfFdL7F4gbdKW/gytQm60MyBBcpP3y0iYiNnxdEjDmAaOHCdGHaoDm5HAsbjBy9dlvqbHQB5/y0dnJ1HVhjevxw86RniGjaTXUxEm1XiC/BHj3OOV3VmfOy1n2tcnfy3z6XSjeXlDXonKdUpThxswl8qtnAzt5QbeAMzX75JZKn5rlD5vfqYCcDZ6GN9FvOJvIhzPICF6N6PmnuSy3PyK2U3jOljf1nBzwm5zrB8X0K2NkwTOtDaUfFuakUfkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ejjf4Koko+xEeG32rlp1Xc5QajS1BmXmYH2VeD5YE3g=;
 b=Ag8qJtqTEZeRGE7QrKNf8OHvaA1i43GRrUQzAVLbwUMCzwuaaBdrbtbFnehzqdcnGPMwYy/6ewdNu8IKU1z2+CTOWYmgwzxY9vAKsJHkOTanp07xQe9F04D3OumZ8pEHy3hsDpiHyUdYpSdNd5X0fTp5csvsljKVnDklsH7Z5m1MGHRsYcRBuyfijV+USSDUqSzZqW+MwSkYrkamoL2ptpEHJImhknP0O1wxsO1jNVyHNmQwYzZC/0wHHWfKtdO95Squ5/jTc2wmC0So5MT4wAXgBy1pqid18OOiU9nvpbXr9cy4U04dNGYP9smwg6vNm6MqoIlN+vOTD1cfNNvnFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ejjf4Koko+xEeG32rlp1Xc5QajS1BmXmYH2VeD5YE3g=;
 b=HWoz/WbIF1bfBdyOhc0JxjrOuM86hBfWoSBxTuIg4zGFMIuqIkBrsi+hSfXpCqfTSlg5SoZNm+oZwsGfXIt5GbhIM8QoVQ4EAbsJ+Y/b9uB+SNz2KXbUmzPXidWGti7nah4fep+64CMFs6SPLbsAMevffvvDgXJm+7f4Bmhut2U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SN7PR12MB7853.namprd12.prod.outlook.com (2603:10b6:806:348::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.19; Fri, 15 Nov
 2024 06:45:17 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 06:45:17 +0000
Message-ID: <f4c10327-d39f-c6ae-001e-20f7fddc35ce@amd.com>
Date: Fri, 15 Nov 2024 06:45:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] cxl: avoid driver data for obtaining cxl_dev_state
 reference
Content-Language: en-US
To: Fan Ni <nifan.cxl@gmail.com>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com
References: <20241114112435.45593-1-alejandro.lucero-palau@amd.com>
 <ZzZjzDCiOKbemv8R@fan>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <ZzZjzDCiOKbemv8R@fan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0363.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::8) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SN7PR12MB7853:EE_
X-MS-Office365-Filtering-Correlation-Id: d60b53f6-c082-4529-67d1-08dd054110ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WlZoL3dLT3VlWWpOMzJVQVd2OGVsRDZ0SmN1QjE5VXEvenB5RGtNT015cFRn?=
 =?utf-8?B?ckdveStpN0pLTFJNdnhsOVZYemplWjcwK21Wd0NlUFZVZzhoVy9Ub0Roc3Y5?=
 =?utf-8?B?endQR01rL0p0aGpXNnFxOWVwZ3BWcEVJdjdRZ2JyTVJudForR01tRWVNL3Yw?=
 =?utf-8?B?WU8zTW14bEZmL05nbmtVb2ZBTmc4MGdqYjNtbVdZNHo1SDhvZ2ZhR3Q1blZC?=
 =?utf-8?B?UFRyOGJkNGsrK2VFeXQ5RXQ4MS80ak1CeGQ1S0JwcHpRMHlkc2FhalZPQVZ2?=
 =?utf-8?B?RFVkK25sRFlJM2JPZmM4ckY3YnhWYTlvcDNOWlJwN2tyM3NEYlExOXlNVnlO?=
 =?utf-8?B?V3NRTDlIdDJtWFZQTU9BdFRiUnJXVGRkUUYyNDdDRi9KVzlWa3VzQ3pFOG5K?=
 =?utf-8?B?eUF2S05USUloTVRhMEtFUVF3aUJhM2RxT1RHYW43a2hJQVUxdGxkaWcvQkUx?=
 =?utf-8?B?MnZqdUphK1JVNGxjOEtzWnJBSS95NmxXY1dUWEsyaXFSRVJzWDlGZVpIUUV4?=
 =?utf-8?B?OFhCQ3JWaFFhdjkvTGtLbmI1dFA2WWhJbjBERUhpM0ZXakc1U0l5dW9OczB0?=
 =?utf-8?B?YVZka3VjV1JhS0VsZGxxcjZ0VU9OMlJrVGlPV0l1SEM1bjJuQVlCVUwrTnRR?=
 =?utf-8?B?cC9qeEVrODgzb1JOV2FiTzJ4eE5GVjFBbi81c3BidzJEOURaWlZKSkgxSTBH?=
 =?utf-8?B?QVByVGJaLzRmeGlpaTRPazJKb1RWUnh4WWtoQ2dsR2ZVbm1SRzIxRXlmRVJN?=
 =?utf-8?B?WnVKNU1DeE5mN3pqUmpGQTFzYmt4VlVub1NBVUluakEvUEc5WnI2SURRNWln?=
 =?utf-8?B?SENET2lmQStFS3JNbU4zWVRNaHpITFQrcGdObHN2bjl3T3hzUmxBYzN0SFhO?=
 =?utf-8?B?dmZic3FLQlZTVGZIMXoxWGhDdGRFK2o2K3pXUFIveWI1MGQxZmlLLzF1cDQy?=
 =?utf-8?B?SjlDclN0MTR5WXdmbWc0bTRSY1QyWFg2Ulc0TW9SL0VsbGY0VEcrMUhuUDlV?=
 =?utf-8?B?bTg5NjdaYWJ2RnBnbjFzWnNMc2JjRVM2U1JZRW9TejFHOTFLbjVuUnhpeTZS?=
 =?utf-8?B?ZnBBMlRZNUtDNUJGWUswY1VlR3p0ZGpqZHQ0QVpzQ3VBZCtPSTVSNHp4Y0Ru?=
 =?utf-8?B?cWY5by8wK1R3cGFURjkySlArcjRvVTRldmttM2VCZU5QNjFML1FzVFVYOFNG?=
 =?utf-8?B?WTlPeWNxSVM1R3dHUGpsM1pKNEtFVjBicDRVSU8yYkprWGtVWG5aSktIa3Fa?=
 =?utf-8?B?emd3bzFGMUFOWXFCTDJwUlQ5eER6NUY3Rk12ZlVHV2QzZEExelpjcDhQd0V2?=
 =?utf-8?B?bkhldGdwd3pyQUplMjJudkl0Nk5wNnpOaGtMeEt6QkFoVnZGdytENVd6TFhk?=
 =?utf-8?B?R09UK2llQ2c4a3RWMmtueUgvZkt0amdLQUhxRXR6ajRqQnJuRVJyUmRsa2Q2?=
 =?utf-8?B?SDcrZVFaQ0Rja2g4ZndxOVJFNEJNcFhEWW1qZ1BDcGsvQUhPNU9mUDZhZ054?=
 =?utf-8?B?WDhMdGRla3NsbWRMSElQTFcvWURUMnRuMEUzWktQZTdWM2Jwd2VaZDYvZmdI?=
 =?utf-8?B?NHBmRUVjR210ZTVRMFU1azVKeE92Tk8zRmJjN2E5ekNjQS9EU2RjOVZkTmFH?=
 =?utf-8?B?ODBMSWhwVlRWbmpLUVBFNUIzUGN5Y2dVY2Y0M1Q5b0VxQlA1VzZaU0dSb1R5?=
 =?utf-8?B?T2QxdnVNNytvTUsxdjBlendSVXFaOWJTVU9BTmlWdUgvVG5xbUtQMHNUQTBv?=
 =?utf-8?Q?WQFjyKisdoIS6UFTyH9t7Xxoa2l7BcX7nTQF0YB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkJCYmF6TThUcUpKRzBxWnhEY3k3RzJSWGVvSk9iRmE1RTlPd2dNSkFBUy9S?=
 =?utf-8?B?WmZzQkQ4b2pVTkQxTklWOFB6WC9hK3V4cGRRSWN2UDZQdFYvRS93czJUU0Yw?=
 =?utf-8?B?aFlQZkt6cHY5WEVZOWJ2RFRjZWVuY1BsV0pRQ3VWdjdBWXdtbFFRalQzWkky?=
 =?utf-8?B?dkY3c0pyNHdnV1dJbXUzejVqcWNidlJBTFdZeWV5UGVoM0FOQTNTTXV5MEdU?=
 =?utf-8?B?dVdaUkRPTUxGR3VoUWNVV05WeVFXVElZbUo5RGpZOG1na1ExY0NkRFlnZzM2?=
 =?utf-8?B?TW9jc3Q2dytCTXBHRmNVWEhYTW5MT2gycDV6bFFaeVZ5WHpoc1p5QVlpcVRF?=
 =?utf-8?B?TFRSS1lKbk82TWprWHExYW5USUYrZmZRZmd0Z2l3clhNc0FFVVNjTjE4SVQ1?=
 =?utf-8?B?MnpvSFlIR1NHY0IvNVBvS1hqaEIydWFSUExYR2pnWldqREpzckR1WEhaWThD?=
 =?utf-8?B?UUkyVmNSSFNyUU9JV1c2djlEOXVNa09IdXdrczREWlRrMXlLbXF4YnhRbkxU?=
 =?utf-8?B?VWR4di8zQStsYkhveTV2REgyeW5kOG9KOWRzQVRQUFBjNEVncU9TVmtKcmZ3?=
 =?utf-8?B?aXdtY0ZkcDk4aEFwNUQ0VVVIVHd4R1U1M1IwRUI2TWRNd1E4MnZ6bDhyZmtx?=
 =?utf-8?B?d09oVHBMSWNWaURUM01nSUtMOERSYXg0WUMrR2Jjb1BlWVFYMFU1ZXBkYjhJ?=
 =?utf-8?B?SjcrdU1GMWE5NzBUTUxWdWVmV21velBLcGhPd29WcncyNmxvdmhHTUpNc1Rj?=
 =?utf-8?B?N0wrek5kSEFIYUdNUC8vT05lN2ZsdC9nc01mMEFDQ01jeEsyUU5haURnYjAy?=
 =?utf-8?B?dTl3ZElRdEN4a3E2RklybExXU1dpKzNaUU1idkYyb04weUxQU2VWdis3ZmZ3?=
 =?utf-8?B?OVBCSmlQZ1N3OVVvak9LRTFmM0pjanJTMmRlLzl1bHZMSnhuYVhjL3MzdzBH?=
 =?utf-8?B?S2ZWN1duQS8vVS9XKzJmUElUbzVPQ0pxMWFjOG1LaVorWHUyRlRFejRVMTRk?=
 =?utf-8?B?Q2NHZzVUZUhMZG8yQ2MvYlQ1eXRGeXU2SWx6cllrNVU0Tyt5WmFYdXY4VXg3?=
 =?utf-8?B?NVg2cjAxWTJNTDYrY3ZKdEt3YWRKVzdOaXJyOFpNNk5wR0F1Z1dlTFhyenFG?=
 =?utf-8?B?V0xyQWpKL1FvTFdKSkJobExvelp1alBtNDlXejA5ZGN5eVMvTmtxUmZYMVZh?=
 =?utf-8?B?S094OFNpR1hTeFZ4OWpObmxRYU5aQU1BMzNwUUMrN29kYVkyT3o5UEdzYlVI?=
 =?utf-8?B?cGxzbnE0MGFlWkNJZ29pTzJVS0tjWEFFK1RWMEZmbUJKR3B5Y2NuWVgrbjdn?=
 =?utf-8?B?dnF1dHVRaFNmRlplQ2h6OWl2VkFCTWdkelpiYkJ1NHlQL0pnK3cwNWpCcGpD?=
 =?utf-8?B?VHlQMjNIT21XSzU5V1A5N1JNOUZRdklnSm4vL0VBM3ZPRVhFNU94TGt1dExp?=
 =?utf-8?B?ajR2MU8weEFCUkF1b2ZrOGxwOW8zMXZ6MWppYUpiVCtDcmlTTnV4Ynp4MERO?=
 =?utf-8?B?anUxZ09xVGQremFIUE5CZnh3ZVNEWEI3c05WRmZBU2o5YzNaUUIxUXh3algz?=
 =?utf-8?B?WlIyT1J6SUZnWEY0azBKUmNJK2VQc3Z6YllReFNQUjU1VjgvbW9IQk9Pamtj?=
 =?utf-8?B?bERuTkxlM2RGOHZjRXNGS1Vpb3RHNnV6bUdDejN4ZzJkamM2OExTdll3OVc4?=
 =?utf-8?B?UUZrK0M3NUZMZmJZcUhrbnJkbitOQS9mU3pvem1VdU52U3cxN2k3L3cvbW5o?=
 =?utf-8?B?RzdpRFZyM2twOGRWVXN0SWVUaHRsU2JQcDg0OXA1WjlBMzlqZktWTktxRzFs?=
 =?utf-8?B?a2ZpZkNGN2JNZEdCOHgvRWRmSVN1a01FSWV5NDJsdTNySDh0aUVHRW85K3Zw?=
 =?utf-8?B?bWRqb2F2OG1iRzNBVHJTejdIbHhYVFA0Tkd1TTJtYkwwK1hpcXRGa1FBWFY5?=
 =?utf-8?B?YkpDbTQ1QjlOZ1AvQ3Y3YnpaeU44a2Y4MWkxUWxrMTZNSTRMVjRJbnNESUd6?=
 =?utf-8?B?em8yT2RpbjBtMEttYVR6YkFhbGdadS9ZRExXcitpTjBjcFNPYnVwenFmRFRU?=
 =?utf-8?B?elRmQmJwWkZVWFQ4dmRtakp1QzY4dG8yVVFwMWFXMmk5ZjgyaGNMQWw3UVU5?=
 =?utf-8?Q?poESrBG0ou+isNdo7aj3Ritox?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d60b53f6-c082-4529-67d1-08dd054110ed
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 06:45:17.4481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5TEgROG9NSxH1mM6AlLCZb6rmVTl5bSN0cPvlSlP4tlgFu3E8S6UrGurB/ilSpwip0o4UpGPqvIYqKFYaKo1cQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7853


On 11/14/24 20:55, Fan Ni wrote:
> On Thu, Nov 14, 2024 at 11:24:35AM +0000, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alejandro.lucero-palau@amd.com>
>>
>> CXL Type3 pci driver uses struct device driver_data for keeping
>> cxl_dev_state reference. Type1/2 drivers are not only about CXL so
>> this field so not be used when code requires cxl_dev_state to work with
>> and such a code used for Type2 support.
> This sentence is broken to me. Do you mean something like "Type1/2
> drivers are not only about CXL and for type1/2 drivers this field
> is not always available for cxl_dev_state." ?
>
> Fan


Yes. I hope the original sentence makes sense when the typo about the 
second "so" is fixed:


"CXL Type3 pci driver uses struct device driver_data for keeping 
cxl_dev_state reference. Type1/2 drivers are not only about CXL so this 
field should not be used when code requires cxl_dev_state to work with 
and such a code used for Type2 support."


>> Change cxl_dvsec_rr_decode for passing cxl_dev_state as a parameter.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/pci.c        | 6 +++---
>>   drivers/cxl/cxl.h             | 2 +-
>>   drivers/cxl/port.c            | 2 +-
>>   tools/testing/cxl/test/mock.c | 6 +++---
>>   4 files changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 5b46bc46aaa9..420e4be85a1f 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -291,11 +291,11 @@ static int devm_cxl_enable_hdm(struct device *host, struct cxl_hdm *cxlhdm)
>>   	return devm_add_action_or_reset(host, disable_hdm, cxlhdm);
>>   }
>>   
>> -int cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
>> +int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>>   			struct cxl_endpoint_dvsec_info *info)
>>   {
>> -	struct pci_dev *pdev = to_pci_dev(dev);
>> -	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>> +	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
>> +	struct device *dev = cxlds->dev;
>>   	int hdm_count, rc, i, ranges = 0;
>>   	int d = cxlds->cxl_dvsec;
>>   	u16 cap, ctrl;
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 5406e3ab3d4a..42a46e78d786 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -812,7 +812,7 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
>>   int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
>>   				struct cxl_endpoint_dvsec_info *info);
>>   int devm_cxl_add_passthrough_decoder(struct cxl_port *port);
>> -int cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
>> +int cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>>   			struct cxl_endpoint_dvsec_info *info);
>>   
>>   bool is_cxl_region(struct device *dev);
>> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
>> index 9dc394295e1f..acf2ac70f343 100644
>> --- a/drivers/cxl/port.c
>> +++ b/drivers/cxl/port.c
>> @@ -98,7 +98,7 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
>>   	struct cxl_port *root;
>>   	int rc;
>>   
>> -	rc = cxl_dvsec_rr_decode(cxlds->dev, port, &info);
>> +	rc = cxl_dvsec_rr_decode(cxlds, &info);
>>   	if (rc < 0)
>>   		return rc;
>>   
>> diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
>> index f4ce96cc11d4..4f82716cfc16 100644
>> --- a/tools/testing/cxl/test/mock.c
>> +++ b/tools/testing/cxl/test/mock.c
>> @@ -228,16 +228,16 @@ int __wrap_cxl_hdm_decode_init(struct cxl_dev_state *cxlds,
>>   }
>>   EXPORT_SYMBOL_NS_GPL(__wrap_cxl_hdm_decode_init, CXL);
>>   
>> -int __wrap_cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
>> +int __wrap_cxl_dvsec_rr_decode(struct cxl_dev_state *cxlds,
>>   			       struct cxl_endpoint_dvsec_info *info)
>>   {
>>   	int rc = 0, index;
>>   	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
>>   
>> -	if (ops && ops->is_mock_dev(dev))
>> +	if (ops && ops->is_mock_dev(cxlds->dev))
>>   		rc = 0;
>>   	else
>> -		rc = cxl_dvsec_rr_decode(dev, port, info);
>> +		rc = cxl_dvsec_rr_decode(cxlds, info);
>>   	put_cxl_mock_ops(index);
>>   
>>   	return rc;
