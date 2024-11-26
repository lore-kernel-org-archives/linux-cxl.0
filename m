Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2063.outbound.protection.outlook.com [40.107.237.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443061D8E1E
	for <linux-cxl@vger.kernel.org>; Tue, 26 Nov 2024 16:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732639273; cv=fail; b=aArOAAHimfzJfzp/rPUJFhNLnj6sTTd89J1GyJTczR9hzu4PGlSEv+hWMm0xRVCWNf7oJzJwwkff7eh5t4UdHidycDlGvz6tHU2HE+jKOA5LZmfv7Q0AyP0xUlb8mv7VnopjD0QOK03d51lD3xMhNHspv2El6pYLhi8Z8Zl6+ik=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732639273; c=relaxed/simple;
	bh=B8apv5u4/m8qOXmOv3LXp7bGnYJb3FFCUYgKIpm8Wa0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rp1jG7IFDOeGvLKjfwIKrI1MW3czzOFiYhhRDLScvpSnm27SkET0RiTyamYr3AbiTm0m3+WGP23qVG1TbiJTKlu/XgdZQ4eWb05oqM6ky7R4y1DoX0+yu5extzMyZLO0D+JNsOl+oaw9jscr39IQEPtiYQquJfiZkLXpz+RmEds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Gxb+0+7g; arc=fail smtp.client-ip=40.107.237.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Gxb+0+7g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qchc9wHPtN5OLl+eJ2mKwn+/5mFu1rNkPRLAS5+1OVZaATHTZrzAOGQrx0j/83zsZ51P+OWt2luy1al77Dfxc0maOdUEJZfqWNEHZR5INsm45ILJUu0fxJqIccTNjWH0JfttCwWLXb1MYZs21S0DNE0Udyor4Q0WU6/65+pqkU10rMuwrNS5w60XBOHA35Sk22kywFk14do5CP42uVRssY7E582alvqwrGm4q07H84Z3aJS9vIMf+o2rbXbv60bbonTnFAxjEI+qpYpeNsTWKehWhKicpF2uX+tgn8o51SQuanHqCdVgJfkVloE3kO5MtcullvHN92lU6l2IsKkhYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HpgDp1Yo6zMC/Wq7xeZWIKh3+zbSb2CQ8b14Qc7P/pU=;
 b=LeReH0v5/VOyN/J3kvROJfRMx2jdwmNjv0e0nJMsm6nLNUkLEkq8nNtEPbcWNAjn5rSDDGV+SheTUE6MmQHMnrtlvsH/oYdH1BrdOUhhdWe/WrX/IoPylfys7rrOGsKQX/zcjMf2a7YFkgA6eoLqWR1+nF8AYFekLB1yFEGvgt/Wu4sd83iCRytjjfO7YeLh8iHhoaSlwwg7C4pCoS2bdXrgSHnICe5QqQBi5hR6O2/w20KkbJ8CKBHu7SCJFSJcZbmncsAa03mbuAL1zF43Spm8w9x9Rs9f/H+CeqJAZ9mf8rjcup+JPrFnIcQ2fff/jKqMyPVhRpn6JaGyLcruuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpgDp1Yo6zMC/Wq7xeZWIKh3+zbSb2CQ8b14Qc7P/pU=;
 b=Gxb+0+7g+WQbqr3BAc7M2bo+bdixCZnS3VS/7LUCFhqd0jxAaQW4qxR0Zs1OxxU+4zkMxGI6rcVSA652M8JfNA3T0ml6munT92Ab6s1k1GG37puNPomLDhrXu/NlwciIUkzf6tFVX+GJM8NUGGg8AtMg4NqsrwHEeB8Ai7NSNFc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH7PR12MB7017.namprd12.prod.outlook.com (2603:10b6:510:1b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19; Tue, 26 Nov
 2024 16:41:06 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%5]) with mapi id 15.20.8207.010; Tue, 26 Nov 2024
 16:41:05 +0000
Message-ID: <2dd5516e-3f98-2c5a-73cc-d4c9e2061f74@amd.com>
Date: Tue, 26 Nov 2024 16:41:02 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] cxl: avoid driver data for obtaining cxl_dev_state
 reference
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com
References: <20241114112435.45593-1-alejandro.lucero-palau@amd.com>
 <20241126160938.0000375a@huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20241126160938.0000375a@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DU2PR04CA0171.eurprd04.prod.outlook.com
 (2603:10a6:10:2b0::26) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH7PR12MB7017:EE_
X-MS-Office365-Filtering-Correlation-Id: f2fdaec4-f835-4194-b409-08dd0e391f42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eDNIY2IzeUFCNmo3TExqbkFoaytUMy9xMEJqTng2Z1ZVbVNoTHQ0RnNPcHBY?=
 =?utf-8?B?azRGSlVEZVFRT0FwSE5nRVA2cG9QS0lZR2hsa0dKOW9HT3YxY25YZVh6WXFa?=
 =?utf-8?B?dnRhZzdWLy9wUVh3SzB2MnU2SkpvTmFMUWtkN1lZYmdXWUxCSG56RkFZbERa?=
 =?utf-8?B?ZWd5NitoazZ6Q2dQd09Hb3pvSW8zT0ZZQzJ5L2o4MWNkemJSSVRsbGw0b214?=
 =?utf-8?B?b3YvQ2NpKzNEczdHaEtYeDZQeDBLNUdhdzhwekVsRlFXMnNLcFVlQ3F4YitR?=
 =?utf-8?B?MVN6NHNxTktwYXNCeFFoMUI2UUFTN0dXY3FES0dKWDhmVjEvMkYvWFIxZmY2?=
 =?utf-8?B?UXFLSVVrZjQwSy9CWXhySHRHY25zS1NjZStiZzF4Rm45cXdCV3l3WWtXbCsv?=
 =?utf-8?B?UENNU2hBL01rbTMzcDlrTFBycTVUM0J5Znh3dU8yamxqeUNiVXF0UmZhUW5L?=
 =?utf-8?B?ZHJ5dnkyK1c5Vko5RHd6dVEvNWxQUW13MVBNc1dWSzgzVjBibGVCYmZZQmtR?=
 =?utf-8?B?SmxRNTJmS1h0aGdBeXpTMk1zcDM2eFJMazVTbFduS2JMUkMvV29vVXZBQ3Zo?=
 =?utf-8?B?R3VzUlVjNlZYdktWNXQyMHVQL2RUejBCbWtPWk42Ynk4cjZ6a3FTT2Y5MGNB?=
 =?utf-8?B?R0F1TFd1b1FnZG10K1lPcktITlB5RnVnREpiTGZXcDhlNHFBTVZ3c1pScXJu?=
 =?utf-8?B?U1ZFbzVzeGxRbWtuVU5wb0pxZVpiVWY3S0E3OHRySFJseGR3M0JZTzhDSWFt?=
 =?utf-8?B?WHZpbU1xK3lZOUVEWkVFSUdBU2szQmthcFNCVzFCY21PcnBpZkpiRE5KT2FF?=
 =?utf-8?B?ckF3UjJPVDhIYkRVT3BYUTdzQXpocGFHdnhYcmlVM2Zkek4zWEg2dTNpc0Vi?=
 =?utf-8?B?bFZhL3pRMjdXWnk5QkdtMjhMY1ByUVJUb2hhY2dWNUhkSEpoRUpXK2NBY2dV?=
 =?utf-8?B?QXYwdVNjejRPMVdTNHdJMUhwYWQxQStjcTVvbFZKOGpVMk9zZUVIbkl3Z2FY?=
 =?utf-8?B?Tm9lT01GclJNU0QrRlVxL20rL0I2RnE0TUZmMjU2cGtvMU93NnlpTHNXSXhY?=
 =?utf-8?B?MldURDhzc0pQMUdXVmFsVCtsZ0JUM1BhKzFXYm5hWkszWDZMbGErRHI1dGxO?=
 =?utf-8?B?RzdCaEtOZWtGcGNyNmhkR2piNmUwMTl5QTRsRG5JYUNSaWM5TENybkVWSktS?=
 =?utf-8?B?OWc3WXM3SVJvcHg2WER6aU9vQTl3M0xaOElyZnFwWDhEbm1zSml3aHZwc3Mx?=
 =?utf-8?B?QVBFdXRWaGFVOGF4bDY2UnNVS1NSNk5BK2xyeDdwdkErUzZ0eVgyd09TTnRF?=
 =?utf-8?B?MUFIeWE3SjFJejJTMHNCR2xkY2hvQUV3SEFMSTBURUt3MnJEK2tFbnF0VGFD?=
 =?utf-8?B?TjNEOU9MM200SzBaZWpibThlM2U0WWQrQWlDQTBsWURydEtxdVBMd0RGQWJL?=
 =?utf-8?B?RDlTWXVJNWcrTlI1ZTNkNTRyTkU4VG9yNDJEQ3pBS1BWclV5VWNkbWVVMTJk?=
 =?utf-8?B?dWU5U3haeTZSK3VEN2lGNjJBaEQvMWhXdS9udnZxSGtyd2tqOUYwcXRDaklh?=
 =?utf-8?B?SXJUbzNLYmFvYVd4WDBKV0c0R0RidVlSUk5EVTVsajBFaFdGNE1RSkNMdGVo?=
 =?utf-8?B?NWxEM1V2YVltRTdFM3NNbkFKVmZjbStSeWFFZnNsUURyd2MxTUxVNXBJclpU?=
 =?utf-8?B?dVBvQWZNSWp4V3I1Sll0TEx5STFpSmxMVTdBQ3NHcUhHSG1hYlc3WHdYSkZx?=
 =?utf-8?B?NG1hK1QvVDJMd25GbjJsRVlBWk13TFBoZFNCZXdZY3ZlOUxPRlUyZm1rNkRh?=
 =?utf-8?B?UWU3QVJ1WHU5U1BNRVBYZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZnYxbWRKOUNTVlJ5cjFuS2V6MXJ2cXRmVlM3aEZ0L213cmZQTVBsajVaeld5?=
 =?utf-8?B?ZGIxTWlCalpCMmFrS2QzMEJ5a0kzc2o1ck8xM2s3bnI2N3VkeUFnbUs5MkNE?=
 =?utf-8?B?ZDBZL3FiVmx4b2p2SHFySG9ncCtqZGdFZ1RVNWxwdFZsUWorU3RBTVNsb1Ns?=
 =?utf-8?B?TzBOc1dxZHFkOXhaVEMrUi9mcmFRanNvRVQzaks4R3YyS25UYVQ0UVpCZzB0?=
 =?utf-8?B?NXRxcHUvRWRBRU84UCtpb1dvV3pxQnNyM1R3aUlNVnQxR3RKWEtSSXBMWmRZ?=
 =?utf-8?B?S2ZPcW5QbkZqenQ5UytxbncyR2praHI4QlZ3aC9UZU83Sm5GU2R4WFdhcTF2?=
 =?utf-8?B?VFYzcjNTanprQTRGeSt3ZTJrOEp4SVRNODRTcWsvMXZkVDh6Rzl6blRhZVNt?=
 =?utf-8?B?VHFDWVozekJ4MUxHRnRUVktJak9aY3pJNXZkZXlmVGVJMVkxSDZKUnZ4Um9h?=
 =?utf-8?B?WStNUnFYWVlaT2xiekFCRTEwazVnT3pFYXBxYk9lTzFqSStNVDhMVE1hdURl?=
 =?utf-8?B?eHgwa29HakpNNGdKVGFEK0tJWnVHVTZlSDQyUDRqQ01OUW9KK3hTVDVBUkth?=
 =?utf-8?B?TFNsYTNQbWQ4S0EySEFxQTN2NGI5bFFSeUR5Wkx1MlZsLzRFdGJCVEs2WG91?=
 =?utf-8?B?TnFKdXpJaXBEODV4Znh0TE9lbnN2N0JKaFBVcm5Scjk1N3VSUnVXOXZTR2Vx?=
 =?utf-8?B?akR0WkVYRWl6cXNOcDNmVFMxajJsWkNzbTlWUzlTVkN1S1kwL2hyazY1V2lH?=
 =?utf-8?B?bnZDcjhUclM1bHViN0Jkb0IrZnE4czlGeWV6bWJRblkyV2dEbHY5VTlBZ3J5?=
 =?utf-8?B?YXNBcmgyKyt6QzlQdnhXYms2OSs5MDZJK2FKNVBaWE44Y2tIRlYwaklid0Yx?=
 =?utf-8?B?R0xRWS9IczlCZjIydFlWS2FTeXFTOUVIYWVVZ1lILzlocEFuQWREQ25nU2ln?=
 =?utf-8?B?bDZGdWpRK3IvSkYvUmJ0Rk5mMWNvYTJ4UGtRQzdyVDNlQVhpQ2JMdnZOd0dJ?=
 =?utf-8?B?VDQ3Nmd0QnpyaCtrSnZidkQrU2NWWUVPU01CbG9GampPcGlRbTRZbDlmZFEy?=
 =?utf-8?B?bEhLMzYxaXp4VTE2eFU1c245WVV3a0JPcU9yazJkR1loc0F3UWozT1VHTTFH?=
 =?utf-8?B?YVJhRUdmRWJ1NW9KMHZpTk5uK1VjL0czcjQ2Yk1SM0s4OXJUWWhONWFIczJB?=
 =?utf-8?B?anhCcXArZXFOTzlzUnIzTFQ2OFVDRkg0eGdRUy9nejE2bnlGV29TWjJERWVm?=
 =?utf-8?B?VWplSVNnUTQ2QW1LMHZsOTFVNWsvZ3lLVU04djc2K3U2dkVBMitHdlhqVXBE?=
 =?utf-8?B?bTNIOEFpTFNUNW5YQWljTy9ncGFoSWh2bjhWeVE3YUVmMlJTMnJlTTgxejhC?=
 =?utf-8?B?TVRpY2xIODd4VnZJVmIyQnhoSHgwSTBmRElidFpZWS92R0NZMEVBaGJRNVdu?=
 =?utf-8?B?RTA5TUVLSDJqQTN3VmhFT1J3WmRSM0hSU0R2QTkvYXE2emhHd1dCT1FHdEtj?=
 =?utf-8?B?NnJvcTdZL1BBT1cxVkFnVjNCS1Fkd3g3S3JISEI4MkZkVllXOTJGZE8wcm8y?=
 =?utf-8?B?R0FzeFNkNjNNOFU4TkZWUWRWWlRhMDZtWnI2VmFLQ0hYSFE2a2dPUnkrUk1R?=
 =?utf-8?B?VDFlRVlVOW9zb2RVdUN6TnNZazF6RHl2bmpta1VjZi9WVmtzbDNqZkZOekly?=
 =?utf-8?B?UllOa2NiWk5NaVUwY1N1TEVQYjFVOVlEVWhvajNKaXkvd1FXTFJuWHpaMDdV?=
 =?utf-8?B?R1plRlAvQ0Y1a280VGVYQW96OTdMNUU0ZlB5SThNak1CbFBmQjFXZHByKzRh?=
 =?utf-8?B?TmdJRUZyTkxMNFlXL1NicjFzc2wxUGsvUWxYM2Z0emtGTEV5STNPY0t5WGlB?=
 =?utf-8?B?Y01wMGJxeW5VTW1GSWpxZEh0Qk9YZjc1YTdTc3pWQ1Z2eWNZVk5rdVFCWUZw?=
 =?utf-8?B?WE9ka0ZocjJ6UHVkdzA5QVF4Ulc2RkRwMTBsZnRVQTY3VGVqYThHVGhyY1NB?=
 =?utf-8?B?QW1VdlVjNE1TWmhaUU1ZSVZHNndtdGVyL1dLekdma0V3Y1JtYVI5aVpKVUx2?=
 =?utf-8?B?cXllUjJNeTJNaFJ5WHpKam8yaGZ3TXRad3lxOGxGY2c1R2dRVjVreDF5ZVU1?=
 =?utf-8?Q?S1OV9/8bLrSO1/uFT76Qwn9yK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2fdaec4-f835-4194-b409-08dd0e391f42
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 16:41:05.8663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1qQeA5dVZ22/5ikUsKLtUzTryplDTUE7OZLfPCKDGzSg28EcMQ3AwK1C1KZoKlfFRVzifl9TpkQUSFHhdlF6fA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7017


On 11/26/24 16:09, Jonathan Cameron wrote:
> On Thu, 14 Nov 2024 11:24:35 +0000
> <alejandro.lucero-palau@amd.com> wrote:
>
>> From: Alejandro Lucero <alejandro.lucero-palau@amd.com>
>>
>> CXL Type3 pci driver uses struct device driver_data for keeping
>> cxl_dev_state reference. Type1/2 drivers are not only about CXL so
>> this field so not be used when code requires cxl_dev_state to work with
>> and such a code used for Type2 support.
>>
>> Change cxl_dvsec_rr_decode for passing cxl_dev_state as a parameter.
> Looks like you also dropped the unused parameter port.  Mention that as well.


Right, I'll do that.

BTW, I sent a v2 fixing the type in the commit message "this field 
should not" and other robot reported errors.


Thanks!


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
