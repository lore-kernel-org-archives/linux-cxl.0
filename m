Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795076008;
	b=YAnfouvKfXnKMorGDVVAwytPvBSkTgJG72Cx+Yo0aQ4Hd0U3jdLAoquubfre05UwfecI
	 kd3hiwMDZkY5h8ghVh+D3V2D8PAXMfdSzriPURQgf8LbKS5fqCAGiqia829I3gkNrAZhb
	 MqTOuJXnBt60/LEAXPP98q3LokwuP2NQGSf5QOKNT2RJZ5Jp8A2WQ5kjOIXfLLLPZdtod
	 /t8ZTyfv804rqP8FYB2Xj3cTJmiyhQ5+WxWLykAJnt3eQBexJHVvQEqJ4hiYzYJZOOa9c
	 d6MapHvt5wBnXEIWxRL+9qP+WtzN4ZGqJBsqT+l3QvZBgzi25uZ1VaFS3dychYWuWXA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795076008;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=j5AnY3oYok0/WPAHavYtFBaIUaa1QEZ8Sk0s6OkzM/Q=;
	b=hoATE0kRfYyZDfnXKDqG11Zv9gPaVypg6OZhnfsXt2J99Jm1YgD26pmUvVjkG6dLlMR3
	 GwiN/jhU+YjYejtTiuMKAQmvQkQuKxJU8Q8B+VznCEXYraV6F6yEeE0QHWQtEP8CxsmGu
	 5PErTUWo+feZvO3Kn3+qptjMPhD6489s/Vv4Gjdt+XZVQ3hAkjpoalQN9ieI55HinsPY5
	 67w7iiGp0igZ7xIinrYXxMxIrzB1+FxVN8WJbmFFXjX0uekFLO+kgtfdeZmn9lRKkP24V
	 b1tBUS+f4bRLO+Iek8TFHqLEiUMbmDsezaPQdbNT/kx2EUUvX4N8mns30uc6nJ6Zjhw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=eUWOhFFi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.52
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011052.outbound.protection.outlook.com [52.101.52.52])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84820606A320
	for <linux-cxl@vger.kernel.org>; Thu, 19 Nov 2026 08:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84820606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=eUWOhFFi
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EFA2FWadZb2Tss+WswhYN+NCUwVB1TabdrF7x6NW3Ii89NmVWYA3FueWlZqrf6YmSS1HHikFtx1UA+L3pHxYzhdudx6pp/7sPXGsB6EGvJ5dNPABFlYmKlCObXOzhraAa7iAqbaRP8KPSgwP9sMOcQoogcK37MZqyg6Sv9EvHjHli8K/eizKS7IETpKMitHHlXyWVPnJe8NolplHPmicCZjqI2kUZ2wgiTaAzy4KlZtrSXeTPS619jjPxdM7SK4ENdZ9dWHnaqPL1UUf77pyoY5uT16V2+Sa43Y9eW9/V2QT266TUJ3gq/q5SEZgkPztnjiBAzm/XBuVx0BJrUCNog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5AnY3oYok0/WPAHavYtFBaIUaa1QEZ8Sk0s6OkzM/Q=;
 b=l7kyNSv5grhcEP6ZO4XBBBEfCPVNq/v347nsJfMoIRYEbjBE48D7V0DSuJZ2qCYglMd8zPFjNN8dIGNm0ZMRE7PaA+P3daQEB4gLTP6zG1AQf5sp32a4m4Bm45T43pJDUi21PHIXE0/Nhq3SWy/MHWrl3ihzCCcH5O6lKBF6iQ63rGtdx2Z0wwSEb632jB3SVg3Hp7o662Mk9NuWQjs87xW6RXxMBs7QDoHN3aBCyUThAb/VMtAmOUe1UIgaNYHcBK/24IMYaRTFDHJ1s7yu3HC/eCaDMLmx3le065eFT70H5EAu9hWFt3F2NUlmDlfrNhabks8Z9XJZiduXDYe4Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5AnY3oYok0/WPAHavYtFBaIUaa1QEZ8Sk0s6OkzM/Q=;
 b=eUWOhFFiy6BnIRWLAZhmBGlC8URcHVoG0K9gJC4YXh8MmPnHfA6fqCmaJuW0Gr7YrctFg4d9rpvDJ9HUNzUfYMFYhpaJcpHZHDz1A2Kk0riUQf4Pu2yGEibhJFSLJHc7Mkhzjs1Jj0/xesWUzbg/pLCT+da7uHqVJ/OtbHE5Zwo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 IA1PR12MB8335.namprd12.prod.outlook.com (2603:10b6:208:3fa::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Thu, 19 Nov
 2026 08:13:24 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%4]) with mapi id 15.21.0615.013; Thu, 19 Nov 2026
 08:13:23 +0000
Message-ID: <c887f9e4-7636-49fa-86cf-152bdf76c13a@amd.com>
Date: Thu, 19 Nov 2026 08:13:19 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/3] Type2 unwinding ordering change
To: Dave Jiang <dave.jiang@intel.com>, alucerop@amd.com,
 linux-cxl@vger.kernel.org, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com
References: <20261118191431.21781-1-alucerop@amd.com>
 <58fdf73a-a33a-44fa-bd35-a9610624d3b3@intel.com>
Content-Language: en-GB
From: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>
In-Reply-To: <58fdf73a-a33a-44fa-bd35-a9610624d3b3@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0003.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::10) To DM4PR12MB6254.namprd12.prod.outlook.com
 (2603:10b6:8:a5::17)
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|IA1PR12MB8335:EE_
X-MS-Office365-Filtering-Correlation-Id: a6f1647e-48ea-4603-673c-08df4614fb20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|6133799003|261009223027099003|3023799007|56012099006|11063799006|261102130727099003|261026140227099003|4143699003|261028144727099003|10067099003|261026121527099003|261021121427099003|261021123027099003|261022075727099003|261102123227099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
	2pSZR5RF/w84VS5aljXCYXSJTEYDrPFlXSiVXhUaOI3kmyRDyKKuct+E23F1dmCGmsaEJYbVMtUR66RBvMw2+Qfm8qFZo86rnvI2qoQKtIlQJFtA2BGfREydihgCHfMSto91OJsRuZKzTMvqBYfqRuc0WalLSzemZCnwvsIuMeRE8vF3S3gW4FkoY4rgb77sM2oYSrDA66Bc9PUpNVvlgoFxWJBJe8MtYpmn0QR8TUQ7JmnXJwDxxK1pe8MmAGlZ5cQRWn47hu6O52VGsKI5X8s8gBJDW39tE1v2azIsst+MUZoksmnuP0QNWFY+A6yg1qgB48j+zgysaskBc5r3kjm/MDwuj257W7AjrOycN1Jp5+9JNkvQuZ8g36PbVWxHAH7fpq8JRlKrHtTSwWum52/but2zSztK6+423+rfvs7ZRmWpzb9EBx1r8hAQpOM3UrgPmqr7nNmb5CEiXiDdOwQ6ozTwOLMBEI41nG+SFJdw1wzk+pgGOASvTxXXPiyAjTu3YYaSBWBdBuumDbLKoGIgth2m6GFXeVrjitelcU8vTEhyxwwHfxIKduKVQSoHsMPjjzqvfNN882RJTc7dMnBGl64uRuI4p5LQCdM8jabeMOe7hx6cCmKkL+gL3A6W
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(6133799003)(261009223027099003)(3023799007)(56012099006)(11063799006)(261102130727099003)(261026140227099003)(4143699003)(261028144727099003)(10067099003)(261026121527099003)(261021121427099003)(261021123027099003)(261022075727099003)(261102123227099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R2FEa0hJWFM1djRSbHlacm55Qk1QdXJDOEhLN0RDTGFBQ3E3NkpnV05RYVZZ?=
 =?utf-8?B?dTVrdXRXV1hiaS95YmJUejJlaTFNd3ZtMG9xanZHSk9NR2V2eHFUVmU1eXBC?=
 =?utf-8?B?OEVCQkhNelVTNUxSbEFEOXJSZ0lpRHZDdWlZZndoMUdDbWJhRFRFQm0rbC9X?=
 =?utf-8?B?VjFscXZ6SXIxcDRMcXdBQ1BSQ2UwQ1RaZXpkblBlUXcwUkdlZnNzR0ZOSGVZ?=
 =?utf-8?B?bkVyUWYwTnNuZUZ5Q2hwTmlIeW8wcTNhbnBXSVFWUXdERGsydFR1b1JjTmRG?=
 =?utf-8?B?c1B5ODR2VCs1bEpHajFUc0dDUWVqLzIwcDVvbG1uMlp4NW4yMTJpWnc3Wi92?=
 =?utf-8?B?RG1YNzMwdlhBYXdFQ2lHcDk0OUo3ZHg2d1R5VVc3ZytYMTQzWkRnaFpia2xY?=
 =?utf-8?B?U0FFYjVENGpES2RlVWs1RXBmQXFQb1MwcUhFRFdOc0Npc1Q1QTZHY3NxOFhD?=
 =?utf-8?B?SzZSWW5mSjZvdXYrbGE3dEwvOHFrMWZsRlJOR2l0TDltcTQvOUxSUEVGU0Vs?=
 =?utf-8?B?Q3M2UGI2cCtWWDJoalYvUlRUK1I0RGYzT1VVNko5YmFsU1BlU0dRdjVlNnFa?=
 =?utf-8?B?N290WGJBZzVXVDkxVy9SV1d2S0RkT3hyUWVNK2ZWS0IzRmVrZ1lzVkRHeS9D?=
 =?utf-8?B?Rk5rZyt4am9VbXdPZkRQeHBiemY4QUtRSjJqbjQxdlZEemUyK0M1eEl3NVE4?=
 =?utf-8?B?T3IvSzd1TjMrSmxtdHRnY08vcVY1VUw2VTZWTHoyV1BGZ1FJQVVXZXZ6eGh6?=
 =?utf-8?B?YU55K1dwczJ3c29saVJlNUVPb0YyR2o1dnhOaTJaSE1HaFZKeTFsdlowaTdS?=
 =?utf-8?B?V3kxL2s1QzI5MUZwNTlTVFhBcDQ2UFlYWW9IV01pcXJpbVE2NjlDZXRiY3BF?=
 =?utf-8?B?Zk9jbHc4dzVrLzEzSjkrRHhDWXdTaThLd0EvaXE1aW43d2lDL3pwWmFDVVRS?=
 =?utf-8?B?ZWx6cGdDcHVETnpic2swNERHWmpBQWorOTl2aUg1Ykk3ZUJYNjY5blJIblBI?=
 =?utf-8?B?NHd2aWR5Tmp6WG1xSk9IMzQyemExb29MYVp6SjNsN0pTcDROVW1VZEQrVWtQ?=
 =?utf-8?B?ZjB6NVhiM21MYlVhUkpJbGFDUzNNSmhWTzJzWnUyZWFvb2ZYdkl4eEtuY29n?=
 =?utf-8?B?QytUc3BFTmovT2dNRlRLSDVEMnB5ZFlyaVhGMEIwQy9wblY0SHdyaVVxWGY5?=
 =?utf-8?B?TVlmMzZHR1J6VEpKR0hWZlBXMk1CT2Vta2hpSWVkZE5LT0JlUFppK3JPQXNV?=
 =?utf-8?B?NUVpancyMHpBS21RblZ2K0FMaVhoUnQ2MEtLQVByNUZJbXFLR2xkNFhQRzBy?=
 =?utf-8?B?cVY4dDBFcTZMcDlua05DbHc2RC9CZ3psb3R0bFI1bVhSanhYQkJDdlN0dlVI?=
 =?utf-8?B?ekFmd09UZC9Hbkh0YU9pWEpqLy9pUDJSdVltY2R5eDQ4MUxISTNLNE14MVg5?=
 =?utf-8?B?dm9mNVVZdWU0Rlp0aE5QWUxydDV6WENCRmdOOTN4dGZyZGdUc2dGbUs2YlRX?=
 =?utf-8?B?T3dZdllVb1JkNlpFcm5ZQ0dyOE1aL2txL011c3RGRHBaRXVGKzJSZmNRK3FI?=
 =?utf-8?B?cURFS2x5R0hmL3dmYVlMaXR1ZEtRREI1STBKV1JTdTZxQ0FqS3hDRExEeEQz?=
 =?utf-8?B?bU0vWGJHWXZTSkk5cXB5dC9oejE4Yy9saFJtTWlQL00rZkttUEJPUWk3MGYy?=
 =?utf-8?B?amM1TGh4SFpQdlcwcFlRUTJGRytnN2hZTFp0TjQ5L1pjYlRrWitBK1dpQnR4?=
 =?utf-8?B?a0V3MEJ4Q3d6TGtYQ2gwOEJtY2szai9YdWtDRGc0Nko1Ny8rc0FTejNrcElq?=
 =?utf-8?B?M1NNTUdNOWNtS0svamNTMVc2NTFSeU5mU09ab1FFS01EejRJakY5ZnlNMlpD?=
 =?utf-8?B?M1ZVM0lKQU9OS1BoK0MyYlVtREhIdUVaakxGMHJxRDR5d3dSVUJ2c3Nxcnls?=
 =?utf-8?B?ZjR5M2FzTzc3QnJVQlQ3Q25RMy8wR05JQ0ptT0Z2dzlabG41M09Sc0JkNXNI?=
 =?utf-8?B?M2JkaG1ad0VzVkQvdGlTZWVGa1lwZkVoa2lORzBkUUI3cjIyd0FZUWxVOU1M?=
 =?utf-8?B?UDA0THZEV1hkeSsxWmJTcDN6dmZZZ1Q4ZHA4Yy96RHRjbjlLbGNBcTBYQVAv?=
 =?utf-8?B?K0owbzYwR1A2TUplcVdFdC95NkZuQXpVZExoRTkyQktMYXRLNjR2TlB4UWRi?=
 =?utf-8?B?VmFrZ3BsNTVodlVVSWxzbWdYdHNSOWx1NjFZYlc4SzlVY3JDMFJHaDBqSEVh?=
 =?utf-8?B?K2hZNnZXT0wyeEdIaWI4TFkydlhtWXhXK1haWGNLQzhkUGw4YWU5N1EweHJL?=
 =?utf-8?B?SlFCZnBpTXlJTTlYS0xnWlNRWmRZeStmQW1Na3duajhQTzN4ZWd2UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6f1647e-48ea-4603-673c-08df4614fb20
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 08:13:23.8299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oKyJIVS7+yB9NAW/IlRmJlYfcLFn/TS995Sk+R8qORboF56QcxZDX+w0mnZhHCS2aJvkVMx4g5NBuuZxlfW1Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8335


On 18/11/2026 23:39, Dave Jiang wrote:
>
> On 11/18/26 12:14 PM, alucerop@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> This RFC requires more work mainly with the tracepoints and surely with
>> documentation which, I hope, will get better with help from reviewers.
>>
>> Regarding the solution proposed for the described problem, I know there could
>> be other solutions, so I'll be happy if someone comes with a better one, but
>> my feeling is the current design based strongly on devm actions is adding
>> complexity which would be desirable to reduce somehow.
>>
>>
>> The summary
>> ===========
>> Current Type2 support is safe but semantically wrong: a Type2 driver could not
>> be (temporarily) aware about the CXL region (the one creating the Host physical
>> range to work with) is not there anymore. It could because it depends on the
>> unwinding triggering point which changes the ordering of CXL objects unwinding.
>> It is safe because for current Type2 expectations the physical mapping will
>> remain: those HDM decoders building up the path and programmed by the BIOS will
>> not be reset.
> Hi Alejandro,
> I ran the series under cxl_test with type2_test=1 and KASAN. A plain unbind of
> the accel driver oopses. delete_endpoint() unregisters the endpoint decoder,
> then the devm action from add_hdm_decoder() unregisters it again. Binding the
> accel with no CXL topology also oopses, on an ERR_PTR endpoint.
>
> There's also a Type3 regression. detach_scheduled is never cleared, so after
> one cxl_mem unbind/bind a Type3 memdev no longer detaches when its endpoint
> is unbound.
>
> With the crash fixed locally, the endpoint is never released after a Type2
> teardown. detach_memdev() puts cxlmd->endpoint after delete_endpoint() has
> set it to NULL.
>
> The ordering isn't fixed either. schedule_detach() is async. On endpoint or
> cxl_acpi unbind the decoders are torn down while the detach work runs the
> driver teardown in parallel. A trace shows the two interleaved. The detach
> can't run synchronously from the endpoint unbind. The PCI unbind takes the
> PCI device lock and then needs the endpoint lock to remove the endpoint.
>
> I don't think the driver needs to be unbound first. It needs to stop using
> the HPA before the region goes away. Every region removal goes through
> unregister_region(), so how about telling the driver there?


Hi Dave,


I'm looking at those problems you report above. I did not see them but I 
was pretty sure something was going to appear ... what makes my point 
about the current complexity stronger, or at least, the need for adding 
tracepoints to visualize this easily. I wanted to send the RFC for 
starting the discussion after this preliminary work studying and 
proposing a solution what was not so trivial as I thought.


But I wanted to quickly reply to this specific comment and the idea 
proposed below. Interestingly, this was something I tried in the past:


https://lore.kernel.org/linux-cxl/20250624141355.269056-19-alejandro.lucero-palau@amd.com/


Look at the cxl_create_region interface where the Type2 driver could add 
a callback action linked to cxl region removal. You can also look at the 
discussion there with Dan. He did not like it and wanted to always 
remove the driver in this case.


I disagreed then but I know think it is the right thing to do. It is 
possible to have Type2 drivers aware of such disruption and they 
changing to a degraded mode where CXL is not used, but from sfc 
perspective, after internal discussion, it does not make sense.


Moreover, multipf support implies to signal all PFs using CXL and it 
will need to deal with these concurrency problems originating this work. 
One could argue those concurrency issues need to be addressed but my 
point is to reduce that complexity where other PFs can not find device 
CXL in some intermediate state requiring to be aware of all those 
possibilities and add protections. I'm not saying it is not doable just 
I prefer to avoid it, always presenting the device CXL state in a 
all-right-state or no state at all. Relying on unwinding with Type2 
driver removal first, this is/should be possible.


Anyway, thanks for looking at this. I will look at those other problems 
and also the sashiko reports pointing to problems when devm actions 
registration fails ...


> The diff below shows the intent. devm_cxl_probe_mem() takes an optional
> revoke() callback. unregister_region() calls it after the region device is
> deleted, while the decoders and HPA are still intact. A bus notifier disarms
> it before the driver's own remove(). The async detach stays as it is.
>
> Under cxl_test, mem0, endpoint, port and cxl_acpi unbind all call revoke()
> before the first decoder teardown. If the driver unbind starts while
> revoke() is still running, remove() waits for it to return.
>
> I also tried your multi-PF v2 on top of this with mock functions under
> cxl_test. It doesn't look like it needs a deterministic order either.
> Deleting the region unbinds the other functions synchronously in
> device_del(), before revoke() and before the decoders are torn down, for
> every trigger above. cxl_get_range_and_link() needed changes for that. As
> posted it can deadlock against PF0's unbind. The fixes are on the branch
> after your v2 patches.
>
> The branch [1] has the full set and the cxl_test changes I used. Please
> take a look and see what you think.
>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/djiang/linux.git/log/?h=type2-revoke
>
> DJ
>
> ---
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 787988e92965..50c2fcee54b6 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -752,6 +752,13 @@ static void cxl_memdev_unregister(void *_cxlmd)
>   	struct cxl_memdev *cxlmd = _cxlmd;
>   	struct device *dev = &cxlmd->dev;
>
> +	/*
> +	 * The attach owner is unbinding and has already stopped using the
> +	 * region. Don't call back into it while the region unwinds below.
> +	 */
> +	if (cxlmd->attach && cxlmd->attach->disarm)
> +		cxlmd->attach->disarm(cxlmd);
> +
>   	cdev_device_del(&cxlmd->cdev, dev);
>   	cxl_memdev_shutdown(dev);
>   	put_device(dev);
> @@ -834,6 +841,7 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>   		dev->type = &cxl_class_memdev_type;
>   	device_set_pm_not_required(dev);
>   	INIT_WORK(&cxlmd->detach_work, detach_memdev);
> +	mutex_init(&cxlmd->attach_lock);
>
>   	cdev = &cxlmd->cdev;
>   	cdev_init(cdev, fops);
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 038233dfb142..e8a8843c2ddb 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2559,6 +2559,41 @@ static struct cxl_region *to_cxl_region(struct device *dev)
>   	return container_of(dev, struct cxl_region, dev);
>   }
>
> +/*
> + * Tell attach owners (Type2 drivers) the region is going away while its
> + * decoders and HPA are still intact. Every region removal goes through
> + * unregister_region(), so this is the one place the owner needs to hear
> + * about it.
> + */
> +static void cxl_region_notify_attach(struct cxl_region *cxlr)
> +{
> +	struct cxl_memdev *cxlmds[CXL_DECODER_MAX_INTERLEAVE];
> +	struct cxl_region_params *p = &cxlr->params;
> +	int n = 0;
> +
> +	lockdep_assert_held(&to_cxl_root_decoder(cxlr->dev.parent)->regions_lock);
> +
> +	scoped_guard(rwsem_read, &cxl_rwsem.region) {
> +		for (int i = 0; i < p->interleave_ways; i++) {
> +			struct cxl_endpoint_decoder *cxled = p->targets[i];
> +			struct cxl_memdev *cxlmd;
> +
> +			if (!cxled)
> +				continue;
> +			cxlmd = cxled_to_memdev(cxled);
> +			if (!cxlmd->attach || !cxlmd->attach->region_lost)
> +				continue;
> +			get_device(&cxlmd->dev);
> +			cxlmds[n++] = cxlmd;
> +		}
> +	}
> +
> +	for (int i = 0; i < n; i++) {
> +		cxlmds[i]->attach->region_lost(cxlmds[i], cxlr);
> +		put_device(&cxlmds[i]->dev);
> +	}
> +}
> +
>   static void unregister_region(struct cxl_region *cxlr)
>   {
>   	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> @@ -2568,6 +2603,13 @@ static void unregister_region(struct cxl_region *cxlr)
>   	xa_erase(&cxlrd->regions, cxlr->id);
>   	device_del(&cxlr->dev);
>
> +	/*
> +	 * device_del() unbound any device-link consumers of the region (e.g.
> +	 * other functions of a multi-function device), so notify the owner
> +	 * last. Its decoders and HPA are still intact.
> +	 */
> +	cxl_region_notify_attach(cxlr);
> +
>   	/*
>   	 * Now that region sysfs is shutdown, the parameter block is now
>   	 * read-only, so no need to hold the region rwsem to access the
> @@ -4182,14 +4224,42 @@ int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
>   	if (rc)
>   		return rc;
>
> -	attach->hpa_range = (struct range) {
> -		.start = cxlr->params.res->start,
> -		.end = cxlr->params.res->end,
> -	};
> +	scoped_guard(mutex, &cxlmd->attach_lock) {
> +		attach->hpa_range = (struct range) {
> +			.start = cxlr->params.res->start,
> +			.end = cxlr->params.res->end,
> +		};
> +		cxlmd->attach_region = cxlr;
> +	}
>   	return 0;
>   }
>   EXPORT_SYMBOL_FOR_MODULES(cxl_memdev_attach_region, "cxl_mem");
>
> +void cxl_memdev_attach_region_lost(struct cxl_memdev *cxlmd,
> +				   struct cxl_region *cxlr)
> +{
> +	struct cxl_attach_region *attach =
> +		container_of(cxlmd->attach, typeof(*attach), attach);
> +
> +	guard(mutex)(&cxlmd->attach_lock);
> +	if (cxlmd->attach_region != cxlr)
> +		return;
> +	cxlmd->attach_region = NULL;
> +
> +	dev_dbg(&cxlmd->dev, "%s going away, revoking %pra\n",
> +		dev_name(&cxlr->dev), &attach->hpa_range);
> +	if (attach->revoke)
> +		attach->revoke(cxlmd->cxlds);
> +}
> +EXPORT_SYMBOL_FOR_MODULES(cxl_memdev_attach_region_lost, "cxl_mem");
> +
> +void cxl_memdev_attach_disarm(struct cxl_memdev *cxlmd)
> +{
> +	guard(mutex)(&cxlmd->attach_lock);
> +	cxlmd->attach_region = NULL;
> +}
> +EXPORT_SYMBOL_FOR_MODULES(cxl_memdev_attach_disarm, "cxl_mem");
> +
>   /*
>    * The presence of an attach method indicates that the region is designated for
>    * a purpose outside of CXL core memory expansion defaults.
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 35268d1c387c..675d7e21f6c1 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -44,6 +44,10 @@
>    * @cxl_nvd: optional bridge to an nvdimm if the device supports pmem
>    * @endpoint: connection to the CXL port topology for this memory device
>    * @attach: creator of this memdev depends on CXL link attach to operate
> + * @attach_lock: protects @attach_region and serializes revoking it
> + * @attach_region: region the @attach owner uses, NULL once that region goes
> + *		   away or the owner unbinds. Lives with the memdev, not the
> + *		   owner's devm state, so a memdev reference is enough to read it.
>    * @id: id number of this memdev instance.
>    * @depth: endpoint port depth
>    * @scrub_cycle: current scrub cycle set for this device
> @@ -61,6 +65,8 @@ struct cxl_memdev {
>   	struct cxl_nvdimm *cxl_nvd;
>   	struct cxl_port *endpoint;
>   	const struct cxl_memdev_attach *attach;
> +	struct mutex attach_lock; /* protects @attach_region */
> +	struct cxl_region *attach_region;
>   	int id;
>   	int depth;
>   	u8 scrub_cycle;
> @@ -97,14 +103,30 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
>   	return is_cxl_memdev(port->uport_dev);
>   }
>
> +/**
> + * struct cxl_memdev_attach - memdev attach provider operations
> + * @probe: attach the memdev, runs in cxl_mem_probe() context
> + * @region_lost: @cxlr is being unregistered and @cxlmd is one of its
> + *		 targets. Called with the root decoder regions_lock held, after
> + *		 the region device is deleted and before its decoders are torn
> + *		 down.
> + * @disarm: the attach owner is unbinding; no further @region_lost
> + *	    notifications are wanted. Waits for an in-flight one to finish.
> + */
>   struct cxl_memdev_attach {
>   	int (*probe)(struct cxl_memdev *cxlmd);
> +	void (*region_lost)(struct cxl_memdev *cxlmd, struct cxl_region *cxlr);
> +	void (*disarm)(struct cxl_memdev *cxlmd);
>   };
>
>   /**
>    * struct cxl_attach_region - coordinate mapping a region at memdev registration
>    * @attach: common core attachment descriptor
>    * @hpa_range: physical address range of the region
> + * @revoke: driver callback, stop all access to @hpa_range
> + * @unbind_nb: bus notifier, disarms before the driver's remove()
> + * @host: device whose unbind disarms @revoke (the cxlds->dev)
> + * @cxlmd: the memdev, set once devm_cxl_probe_mem() succeeds
>    *
>    * For the common simple case of a CXL device with private (non-general purpose
>    * / "accelerator") memory, enumerate firmware instantiated region, or
> @@ -113,15 +135,25 @@ struct cxl_memdev_attach {
>   struct cxl_attach_region {
>   	struct cxl_memdev_attach attach;
>   	struct range hpa_range;
> +	void (*revoke)(struct cxl_dev_state *cxlds);
> +	struct notifier_block unbind_nb;
> +	struct device *host;
> +	struct cxl_memdev *cxlmd;
>   };
>
>   #ifdef CONFIG_CXL_REGION
>   int cxl_memdev_attach_region(struct cxl_memdev *cxlmd);
> +void cxl_memdev_attach_region_lost(struct cxl_memdev *cxlmd,
> +				   struct cxl_region *cxlr);
> +void cxl_memdev_attach_disarm(struct cxl_memdev *cxlmd);
>   #else
>   static inline int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
>   {
>   	return -EOPNOTSUPP;
>   }
> +
> +#define cxl_memdev_attach_region_lost NULL
> +#define cxl_memdev_attach_disarm NULL
>   #endif
>
>   struct cxl_memdev *devm_cxl_add_classdev(struct cxl_dev_state *cxlds);
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 702ae9ebdcde..cd3db7646c64 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -219,10 +219,39 @@ struct cxl_memdev *devm_cxl_add_classdev(struct cxl_dev_state *cxlds)
>   }
>   EXPORT_SYMBOL_NS_GPL(devm_cxl_add_classdev, "CXL");
>
> +static int cxl_attach_unbind_notify(struct notifier_block *nb,
> +				    unsigned long action, void *data)
> +{
> +	struct cxl_attach_region *attach =
> +		container_of(nb, struct cxl_attach_region, unbind_nb);
> +
> +	if (data != attach->host)
> +		return NOTIFY_DONE;
> +	if (action != BUS_NOTIFY_UNBIND_DRIVER &&
> +	    action != BUS_NOTIFY_DRIVER_NOT_BOUND)
> +		return NOTIFY_DONE;
> +
> +	/*
> +	 * Sent before remove(), or before devres unwind on probe failure:
> +	 * wait out an in-flight revoke, block new ones.
> +	 */
> +	if (attach->cxlmd)
> +		cxl_memdev_attach_disarm(attach->cxlmd);
> +	return NOTIFY_OK;
> +}
> +
> +static void cxl_attach_unregister_notifier(void *data)
> +{
> +	struct cxl_attach_region *attach = data;
> +
> +	bus_unregister_notifier(attach->host->bus, &attach->unbind_nb);
> +}
> +
>   /**
>    * devm_cxl_probe_mem - Add a CXL memory device and probe its region
>    * @cxlds: CXL device state to associate with the memdev
>    * @hpa_range: CXL.mem physical address range result
> + * @revoke: optional callback to stop HPA access before the region goes away
>    *
>    * Upon return the device will have had a chance to attach to the
>    * cxl_mem driver, but may fail to attach if the CXL topology is not ready
> @@ -233,12 +262,29 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_add_classdev, "CXL");
>    *
>    * The parent of the resulting device and the devm context for allocations is
>    * @cxlds->dev.
> + *
> + * @revoke, if set, is called once if the region backing @hpa_range is about
> + * to be torn down for a reason other than @cxlds->dev unbinding (CXL port,
> + * memdev or region unbind / delete, cxl_acpi removal). The region, its
> + * decoders and the HPA are still intact when it runs. On return the driver
> + * must no longer access @hpa_range. The driver is unbound later,
> + * asynchronously, as before.
> + *
> + * @revoke may run before this function returns, so it needs to synchronize
> + * with the rest of the driver's probe. It never runs concurrently with or
> + * after the driver's remove() or its probe failure unwind. The driver core
> + * notification for either waits for an in-flight @revoke and blocks new
> + * ones first. @revoke is called with CXL core locks held, so it must not call
> + * back into the CXL core nor take the device lock of @cxlds->dev. It may
> + * sleep.
>    */
>   struct cxl_memdev *devm_cxl_probe_mem(struct cxl_dev_state *cxlds,
> -				      struct range *hpa_range)
> +				      struct range *hpa_range,
> +				      void (*revoke)(struct cxl_dev_state *cxlds))
>   {
>   	struct cxl_attach_region *attach = devm_kmalloc_obj(cxlds->dev, *attach);
>   	struct cxl_memdev *cxlmd;
> +	int rc;
>
>   	if (!attach)
>   		return ERR_PTR(-ENOMEM);
> @@ -246,12 +292,35 @@ struct cxl_memdev *devm_cxl_probe_mem(struct cxl_dev_state *cxlds,
>   	*attach = (struct cxl_attach_region) {
>   		.attach = {
>   			   .probe = cxl_memdev_attach_region,
> +			   .region_lost = cxl_memdev_attach_region_lost,
> +			   .disarm = cxl_memdev_attach_disarm,
>   		},
>   		.hpa_range = { 0, -1 },
> +		.revoke = revoke,
> +		.unbind_nb.notifier_call = cxl_attach_unbind_notify,
> +		.host = cxlds->dev,
>   	};
> +	if (revoke) {
> +		rc = bus_register_notifier(cxlds->dev->bus, &attach->unbind_nb);
> +		if (rc)
> +			return ERR_PTR(rc);
> +		rc = devm_add_action_or_reset(cxlds->dev,
> +					      cxl_attach_unregister_notifier,
> +					      attach);
> +		if (rc)
> +			return ERR_PTR(rc);
> +	}
>
>   	cxlmd = __devm_cxl_add_memdev(cxlds, &attach->attach);
> +	if (IS_ERR(cxlmd))
> +		return cxlmd;
> +
> +	/* Don't hand out a range whose region already went away */
> +	guard(mutex)(&cxlmd->attach_lock);
> +	if (!cxlmd->attach_region)
> +		return ERR_PTR(-ENXIO);
>   	*hpa_range = attach->hpa_range;
> +	attach->cxlmd = cxlmd;
>   	return cxlmd;
>   }
>   EXPORT_SYMBOL_NS_GPL(devm_cxl_probe_mem, "CXL");
> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
> index 348d7404cd7a..a82a0e2fc609 100644
> --- a/drivers/net/ethernet/sfc/efx_cxl.c
> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
> @@ -74,7 +74,7 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>   		return -ENODEV;
>   	}
>
> -	cxl->cxlmd = devm_cxl_probe_mem(&cxl->cxlds, &cxl_pio_range);
> +	cxl->cxlmd = devm_cxl_probe_mem(&cxl->cxlds, &cxl_pio_range, NULL);
>   	if (IS_ERR(cxl->cxlmd)) {
>   		pci_err(pci_dev, "CXL accel memdev creation failed\n");
>   		return PTR_ERR(cxl->cxlmd);
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 1c04a7823f64..c672ec83d820 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -252,7 +252,8 @@ struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
>   	})
>
>   struct cxl_memdev *devm_cxl_probe_mem(struct cxl_dev_state *cxlds,
> -				      struct range *range);
> +				      struct range *range,
> +				      void (*revoke)(struct cxl_dev_state *cxlds));
>
>   int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
>   #endif /* __CXL_CXL_H__ */
