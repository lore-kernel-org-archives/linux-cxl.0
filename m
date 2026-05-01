Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012001.outbound.protection.outlook.com [52.101.43.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5AE2DA76C
	for <linux-cxl@vger.kernel.org>; Fri,  1 May 2026 10:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777631714; cv=fail; b=YJTaUTwYtLnQOd/RnpmW6rVOz0l8fnZnh2csZt26zDxce5HP4YWEWTiYcSVn1n8yfaKqP+YhQEVNf153bJRTumUn9hcwVrS1e6K5pD334mXWIYi/NSbyKe0jUXEOC6o68XCfUJ9sw1x2OHP6PZjzg6RTelzdEaKG93NqCSTocec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777631714; c=relaxed/simple;
	bh=ZTggzlnwUxSY4I+obEaBUuhK/1Lzj+vo0vLWr8nWMBE=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=TpaSjNIsbBPrzaMTRb1w7Mb58VUyG8r2a3f+01qrBsHpKMaiMEM7urgjgXEK8CjESGS9xzwd2XvRF4NBiJpORx6c3L4znHWexJ9l5Yu/tPwCt64iqYQDqE2vG84ietE+HFk29gy86vozhtpOS/4DzlE+Vyr0w7CmJM7WfL8Aij0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pYBJ7p/Z; arc=fail smtp.client-ip=52.101.43.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pYBJ7p/Z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BUw33DvFo/uX6U7P3S6F+zjWzixagG4Y50PMhtCo77h/AFk0o33LwqwM+US49BlSs/wjS3KA+XGe7auVsvh84PtZu73aQ3HoeTkmx0i32kE8lZ/UajXddIAsr7Bsea+K8Apo/VycygLC0ReIta3lM/7+xuJic9s3kK+Wfz3P1Z/0Sfyl1pHkV5VfO/zYDrc1R2Iy5AsKz2f4narrZpKshp2jU1dgpkBRNxVmXTqGghnURCrtspFLBZu9RAk2jc0uIPmEOMh6IkYSbM/G5fFHUakOrQ8O3r3DrRZlE/XuthRwimHA9+bbgg4/75/GTTPeP9unXyqbeY2wwlV9t8+g7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SOz32wvKqzmEOwRtIrrmAlU+pQBA3ByepbJKvDOG+kM=;
 b=WFu2ruf79GcXSHFYD6IkYF7FbNiJjVx3KueHWWAS9j+IOHI+GIYYctH+UdsVHgJ2q9bgCjLcCsFu38ImbgYedS7XguWRuGNu6rwtfmtlYW+3w99xEwOSmafd8a8pHTDIEYdyflfKQ1sZ2IZi4Se/Wk4XHt9awY2JCc2DKmr+BuYCcQWSajHO0jlq711d6hZe3lz/2yfFBx7Z51KuyBwOIGU+HLyjw1djLU4ANqyneXqOMsp8HHuvfWf4JDYR3ZWQnzx76XBbAfnBv1tqJk74RPBxoxQ6unL+tbi/HHmCpixaBwOrIOK4yMNvl5eerCrW15x+9k3BgvITrNkulITFzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SOz32wvKqzmEOwRtIrrmAlU+pQBA3ByepbJKvDOG+kM=;
 b=pYBJ7p/ZqO4K4gRCF9KYME1pjGcIoPa/EOcEKv3rfIGDyp6ifNG5u+USbClC6/VL0Rm2XS5IrUgQul4zbAEidsihoIMqmrb+vytIzrSiabAf4EhmO4wkJsf/QH8BrhjsPY+BzMGKHTYmXENRH5RZZoMz5nGi/StyLW0a2cooNaU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by BL1PR12MB5705.namprd12.prod.outlook.com (2603:10b6:208:384::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Fri, 1 May
 2026 10:35:09 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%6]) with mapi id 15.20.9870.022; Fri, 1 May 2026
 10:35:09 +0000
Message-ID: <4277a34e-4edf-44b7-a6a2-05668791e080@amd.com>
Date: Fri, 1 May 2026 11:35:04 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v26 6/8] cxl: attach region to an accelerator/type2 memdev
Content-Language: en-US
To: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>,
 alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org, djbw@kernel.org,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20260423180528.17166-1-alejandro.lucero-palau@amd.com>
 <20260423180528.17166-7-alejandro.lucero-palau@amd.com>
 <a8390b56-e5a9-4e06-b8f8-e66a8bd9e824@amd.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <a8390b56-e5a9-4e06-b8f8-e66a8bd9e824@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0352.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::15) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|BL1PR12MB5705:EE_
X-MS-Office365-Filtering-Correlation-Id: b5033e39-b205-4c3d-d4ca-08dea76d513a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|921020|22082099003|18002099003|56012099003|7136999003;
X-Microsoft-Antispam-Message-Info:
	L/x6Vd5tflcXQfzPlfbQ/nmnWSOAi3U3DrJ/rJgdJslv4InZT6VET87LbGu+GEdUxUCl4nXPf7V0TTG6vTz91foIakNrIbiDCBAGAP5tGxHEwTbCAVhS2sYa4UzCw/25UH/cI2/kGsOLF/XB/VJDpfy15RY2BbQlVnLlmHGUQFwcOsOWdvpvXJ/5w+uFyvrHegzMi3A6cbSGHaTegZwb8fB+mblGZBBMOuHZs3VAC30ih7usrocSU3jTVcrWZWCiHahof1LL5IIj0aLRNEGrxZuhByS+oc3eu9nL3dQMsEkdC3lNG0FTYHIK5EqVF1xeTnL/+bJv4djkWOECcgtusOJvs6AmVnv9uuWM/iNNP8PwkGDnov6K0Nsg0ysGW9LQiEQe+KxEDLBLQoaTvkLp/gsoJ6PfZ3SP7JhVKbrD2Es/AOrTdbtYv9+YUP/1ixccPEwEg6a25KBsG4LAdEvN77a3cqNZb6fxszkF8hJ2MGlnUKGqQqca/gFJwwPjUrRkqSYwuuqsV4gp+kPB6DQ6U69Re4JAqB+YEWIjiX0hrLXUHT5AoROmue45c7Po+zvM2DsG06NidVJUIJ/akTxDLyfvnUOpbPftK1XbSJfsp0FyBbYJvWl6gJ17IDvWhFvkEBuqeYdieTyQRW7UHfuHN2kbz9O4HpF+rMccp8YC+87GsfvsLcZ4re6jwwYJK7k9TIXk4/1tRXqNluVgy2gxJczjr7Evb4etTTS3mEPYtYQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(921020)(22082099003)(18002099003)(56012099003)(7136999003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aU9RaVRpMk1NZ1JHbktmTjI0VzMyanZwSTFLZjNFZXJNVFk0aWpjMk5aTmVK?=
 =?utf-8?B?T1FEaTZoeGVWKzlyVlFuODhwSDVxaEx2SmU1cmltMlVWbkFzN2RWZWNtRHNI?=
 =?utf-8?B?bVZjVjZGMUFEK2kwZnpZbXpVY0YxM2Z2L1Z4SktvZGpnUzJJTlFENVRkMmsy?=
 =?utf-8?B?VUtwOHhLU2d0cm81T0lUQTFnYllQS3BjaFNlSzI0Y3d4Ti9Bdjh5ejFTdHF6?=
 =?utf-8?B?Z29lRElpcmg4TGFWcTUrUGliVUF3b1BkU3lJVVlRdDJTN0NtMFNCamEwME1l?=
 =?utf-8?B?aXVMbXBobDZ5bGxRVmRDQVdHWVFQc3NTb2RkbVpGMUR6aENVNlV1ZnhIWUdm?=
 =?utf-8?B?TTlyK0xRMWJlKzhPWjhPcVNRTkZJYnRlcS9lajkxSzE0azJOdHdvdkpIcXZD?=
 =?utf-8?B?L1krMWJ0RkNCS1E0NTdkNE1hc3ZOakxONXR6cURlQk9BaDZ2eWh4Wi95WGxk?=
 =?utf-8?B?WXNBblEwTFNJaVplNHpYUHlIWmxvZUZUREpjYTBhMzV3TzdWVVJJcmZoOTda?=
 =?utf-8?B?dVBUYktYVi8yU0h4Ymg4REYwWlhITDBIck5TRTBad3VnMlNWR2h3L2JHOFZV?=
 =?utf-8?B?aHZqcUplWlRBMW5YN0dyMUt6RUx3SU9wZjVCY0ZZaDc5ODRuRWJ4dWVxeVhV?=
 =?utf-8?B?L21tRnl6dUp6dnE3YW9xeFBZVFVldHNVUGplN3pNSnlHWng4UnBDTFFwMHhu?=
 =?utf-8?B?WEpSdHdwMHkwM3FDanA4bW1PU1AyR2VXc2xsUWx2aklUK1k1R0hCU1FHaDV5?=
 =?utf-8?B?RlRyaHJJOGhCSEltMnhlL3R6cW9ySFFWR0xWM0V3V2RDWE42ZG9YSkp6Vm5F?=
 =?utf-8?B?NW5PTXhCeEMvM3NZN1FhZmJtQWg1Mk1oT3c2NGRTeWo2c21YTkVBeXpTdGZj?=
 =?utf-8?B?b1VENyt5V09CZGlYaVBEL2FMb2FUSlA2bmtld2NEbVB6STlTc21xZWh4T1Zh?=
 =?utf-8?B?ZXJSbnRUNmRkbDdDWDBjL3FHM25qVWlDZHFnaDJXcjF3ZVVWUjVIYWV3dlJX?=
 =?utf-8?B?MlRIUUFOMThEc3VLZ0FmdUU5V3VUL01WbkhmUjZKa0ZzVDdxNmFQR21RS3dW?=
 =?utf-8?B?ZURmbXUwSnZqaWJ3Y2V5bk94dVJzQ1VwSytEWWR1a1ZPREdscEFXY2RlUlRG?=
 =?utf-8?B?aEVmWHhRaERkT1BWVG9DWnFlTXo3YittdWxiOUtNOUF3R3JSWEFZb0ZKL3ZZ?=
 =?utf-8?B?NVpxS1k3REdyV0ZmL2dUOHp5ano3SHhRVFFWWmkyTGh3SUw0NEZ6Q3V0UUJC?=
 =?utf-8?B?djNGa0VZRTNuVlo4MVBRWkhMNmFCZVA0QnNpMmo5UVczV2hyUmtLc01RYlc1?=
 =?utf-8?B?WTRXR1NCNHVnYUo2K3dRaEVTOE4wcWhKYXJ5ZmJIZ3IvenoyQVVDODdsNUp2?=
 =?utf-8?B?V0VQSG9yTDBYcnVsMEFoMlVnbU5qOURkWVk3cllJOEtvV2hUZHFER3ZUUSs5?=
 =?utf-8?B?WWpuWlo1UlJpUXdWc1VSUGJvVzZacDcxQ1dVbGpJRnhlcDEvVzlTM2g3RHBw?=
 =?utf-8?B?NUpXZTJqL3pUT1RMMXcyVHRIZlhhT1NjTE5DQ2pUajRaeXdOUjdORFJ0WEJS?=
 =?utf-8?B?a0hDRE9KemQ1Qm5BbFE3V2Y3aXVEcEk3QWxLeXVBS1lyc1FNSWcvNjJZRXJO?=
 =?utf-8?B?OVdWS0ROdGk2Q05yd3piUjMvNEVXZTFaaEV5bWk4d1RERm1kOHJleER1cE1x?=
 =?utf-8?B?RjVyWGxDNm1zS0Z6K05nMkhvRDZjZmpKU29ZKzdLalYyRCsrTkMxNUdGdzA4?=
 =?utf-8?B?SHJNTjd5b2VnY1lvUU1handXYmpTRDVkSG4zdG8yOHR3NXNYcTg0VkVKL0th?=
 =?utf-8?B?aitjQkpTTVk1ZGgxczJSVy83WTNIT2lFa2xxS05HdHhwMEFnMkV5cVN4L3ZU?=
 =?utf-8?B?SXBGLzdIL1pVanJIZDdTK1pEY1c0bTdReUlxVUxweWFDR3g0TFlib1MyZ2lo?=
 =?utf-8?B?a0NqZXBtWklpL1EwNlR6amdoY2dpTFR4WUs2ZWVzdGFlWGNaS0RnTW1walNs?=
 =?utf-8?B?RzZPQUJzanl5SmVNVXN3M2Q1bnBOMXRLTWFsQm9XcWRkUWFhNW1jUU4rb0Zx?=
 =?utf-8?B?M3RJb3pUcldlS3JGTGhuWUQrSG9MdlpkMy94SEdWVGkyWFNFbmpGQ0R4clNx?=
 =?utf-8?B?WnlVYU5vc3k2YXUvTTdnNnFEaTM0NEZ1emx6UGQ3aFVyOEJpOStndnVRalZy?=
 =?utf-8?B?VmpIK0RGcTBvY3dDZHhYWktjeHRFcWlOM1F2VmxNNktMWWdTdk02OTJseEtI?=
 =?utf-8?B?MVp4K0hRdnprOEVHaGFwZXM3d3NJVWFxUVVvN0lSNHN4eFNXdWVXbzlOYjVp?=
 =?utf-8?B?K1N5MldaQXllUXNWUHRnM0ZjYmFBTjlCUjBsaHExeC9SV2NlUkdDdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5033e39-b205-4c3d-d4ca-08dea76d513a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 10:35:09.0657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KjQoNrI4q87QUrT8cjjb6OBQPuMvPU4LNrCOxuAUy7lhWOl369nqVZ4mEjzFn+ZzbMVQ+DJLgxJBUqF8bcYdGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5705


On 4/29/26 22:14, Cheatham, Benjamin wrote:
> On 4/23/2026 1:05 PM, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Support an accelerator driver to safely work with an autodiscovered
>> region from a committed HDM decoder through:
>>
>>          1) an accelerator driver cxl_attach_region struct with attach
>>             and detach callbacks.
>>
>>          2) a specific function, cxl_memdev_attach_region() keeping the
>>             required locks for finding a region linked to the memdev
>>             endpoint, and
>>
>>          3) invoking attach callback while keeping the locking allowing to
>>             work (ioremap and other internal stuff) with the related physical
>>             range by the accelerator driver, and
>>
>>          4) linking a detach callback to the endpoint device removal where
>>             the accelerator driver can stop using the region range.
>>
>> This covers the cases of a potential removal of cxl_acpi module or a
>> accelerator memdev unbinding from cxl_mem driver through sysfs.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/region.c          | 118 ++++++++++++++++++++++++++++-
>>   drivers/net/ethernet/sfc/efx_cxl.c |  37 +++++++++
>>   drivers/net/ethernet/sfc/efx_cxl.h |   2 +
>>   include/cxl/cxl.h                  |  17 +++++
>>   4 files changed, 171 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index e50dc716d4e8..68f5a1fd1b1c 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -2711,9 +2711,16 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>>   	if (rc)
>>   		goto err;
>>   
>> -	rc = devm_add_action_or_reset(port->uport_dev, unregister_region, cxlr);
>> -	if (rc)
>> -		return ERR_PTR(rc);
>> +	/*
>> +	 * For accelerators/type2, region release linked to endpoint device.
>> +	 * See handling of cxl_endpoint_region_autoremove() below by
>> +	 * cxl_memdev_attach_region().
>> +	 */
>> +	if (type == CXL_DECODER_HOSTONLYMEM) {
>> +		rc = devm_add_action_or_reset(port->uport_dev, unregister_region, cxlr);
>> +		if (rc)
>> +			return ERR_PTR(rc);
>> +	}
>>   
>>   	dev_dbg(port->uport_dev, "%s: created %s\n",
>>   		dev_name(&cxlrd->cxlsd.cxld.dev), dev_name(dev));
>> @@ -4043,6 +4050,111 @@ static int cxl_region_can_probe(struct cxl_region *cxlr)
>>   	return 0;
>>   }
>>   
>> +static int first_mapped_decoder(struct device *dev, const void *data)
>> +{
>> +	struct cxl_endpoint_decoder *cxled;
>> +
>> +	if (!is_endpoint_decoder(dev))
>> +		return 0;
>> +
>> +	cxled = to_cxl_endpoint_decoder(dev);
>> +	if (cxled->cxld.region)
>> +		return 1;
>> +
>> +	return 0;
>> +}
>> +
>> +/*
>> + * As this is running in endpoint port remove context it does not race cxl_root
>> + * destruction since port topologies are always removed depth first.
>> + */
>> +static void cxl_endpoint_region_autoremove(void *_cxlr)
>> +{
>> +	unregister_region(_cxlr);
>> +}
>> +
>> +/**
>> + * cxl_memdev_attach_region - bind region to accelerator memdev
>> + *
>> + * @cxlmd: a pointer to cxl_memdev to use
>> + * @attach: a pointer to region attach struct with callbacks for
>> + * 	    safely working with a region range by the caller
>> + *
>> + * Returns 0 or error.
>> + */
>> +int cxl_memdev_attach_region(struct cxl_memdev *cxlmd,
>> +			     struct cxl_attach_region *attach)
>> +{
>> +	struct cxl_port *endpoint = cxlmd->endpoint;
>> +	struct cxl_endpoint_decoder *cxled;
>> +	struct cxl_region *cxlr;
>> +	int rc;
>> +
>> +	/* hold endpoint lock to setup autoremove of the region */
>> +	guard(device)(&endpoint->dev);
>> +	if (!endpoint->dev.driver)
>> +		return -ENXIO;
>> +	guard(rwsem_read)(&cxl_rwsem.region);
>> +	guard(rwsem_read)(&cxl_rwsem.dpa);
>> +
>> +	/*
>> +	 * TODO auto-instantiate a region, for now assume this will find an
>> +	 * auto-region
>> +	 */
>> +	struct device *dev __free(put_device) =
>> +		device_find_child(&endpoint->dev, NULL, first_mapped_decoder);
>> +
>> +	if (!dev) {
>> +		dev_dbg(cxlmd->cxlds->dev, "no region found for memdev %s\n",
>> +			dev_name(&cxlmd->dev));
>> +		return -ENXIO;
>> +	}
>> +
>> +	cxled = to_cxl_endpoint_decoder(dev);
>> +	cxlr = cxled->cxld.region;
>> +
>> +	if (cxlr->params.state < CXL_CONFIG_COMMIT) {
>> +		dev_dbg(cxlmd->cxlds->dev,
>> +			"region %s not committed for memdev %s\n",
>> +			dev_name(&cxlr->dev), dev_name(&cxlmd->dev));
>> +		return -ENXIO;
>> +	}
>> +
>> +	if (cxlr->params.nr_targets > 1) {
>> +		dev_dbg(cxlmd->cxlds->dev,
>> +			"Only attach to local non-interleaved region\n");
>> +		return -ENXIO;
>> +	}
>> +
>> +	attach->region = (struct range) {
>> +		.start = cxlr->params.res->start,
>> +		.end = cxlr->params.res->end,
>> +	};
>> +
>> +	/*
>> +	 * With endpoint locked leave the caller to safely work with the region
>> +	 * range.
>> +	 */
> This reads a bit weirdly, how about: "Let the caller do its region-specific setup"? I
> don't think it's important to mention the endpoint being locked here.


I wanted to emphasize the safety of such attachment regarding the 
problem of concurrent unwinding triggered from user space.


>> +	rc = attach->attach(attach->data);
>> +	if (rc)
>> +		return rc;
>> +
>> +	/* Only teardown regions that pass validation, ignore the rest */
>> +	rc = devm_add_action_or_reset(&endpoint->dev,
>> +				      cxl_endpoint_region_autoremove, cxlr);
>> +	if (rc)
>> +		return rc;
>> +
>> +	/* Link type2 driver callback for stopping use of the region range. */
>> +	rc = devm_add_action_or_reset(&endpoint->dev,
>> +				      attach->detach, attach->data);
>> +	if (rc)
>> +		return rc;
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_memdev_attach_region, "CXL");
>> +
>>   static int cxl_region_probe(struct device *dev)
>>   {
>>   	struct cxl_region *cxlr = to_cxl_region(dev);
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 7d8a6c2133c8..9ca16b051d62 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -14,6 +14,36 @@
>>   
>>   #define EFX_CTPIO_BUFFER_SIZE	SZ_256M
>>   
>> +/* Called with cxl endpoint device locked for precluding potential related
>> + * cxl region removal triggered from user space, allowing safely mapping of
>> + * such cxl region by the sfc driver.
>> + */
>> +static int efx_cxl_map_region(void *data) {
>> +	struct efx_probe_data *probe_data = data;
>> +	struct efx_nic *efx = &probe_data->efx;
>> +	struct pci_dev *pci_dev = efx->pci_dev;
>> +	struct efx_cxl *cxl = probe_data->cxl;
>> +	struct range *cxl_pio_range = &cxl->attach_region.region;
>> +
>> +	cxl->ctpio_cxl = ioremap(cxl_pio_range->start,
>> +				 cxl_pio_range->end - cxl_pio_range->start + 1);
>> +	if (!cxl->ctpio_cxl) {
>> +		pci_err(pci_dev, "CXL ioremap region (%pra) failed\n",
>> +				 cxl_pio_range);
>> +		return -ENOMEM;
>> +	}
>> +	probe_data->cxl_pio_initialised = true;
>> +	return 0;
>> +}
>> +
>> +/* Called at driver exit or when user space triggers cxl region removal. */
>> +static void efx_cxl_unmap_region(void *data) {
>> +	struct efx_probe_data *probe_data = data;
>> +
>> +	probe_data->cxl_pio_initialised = false;
>> +	iounmap(probe_data->cxl->ctpio_cxl);
>> +}
>> +
>>   int efx_cxl_init(struct efx_probe_data *probe_data)
>>   {
>>   	struct efx_nic *efx = &probe_data->efx;
>> @@ -81,6 +111,13 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   		return PTR_ERR(cxl->cxlmd);
>>   	}
>>   
>> +	probe_data->cxl->attach_region.attach = efx_cxl_map_region;
>> +	probe_data->cxl->attach_region.detach = efx_cxl_unmap_region;
>> +	probe_data->cxl->attach_region.data = probe_data;
>> +
>> +	cxl_memdev_attach_region(cxl->cxlmd,
>> +				 &probe_data->cxl->attach_region);
> I would think you want to check the return code here, no? I looked at the last patch
> and don't think this will cause issues, but I would at least expect some debug output
> here.


Of course, I forgot to do so. RFC hastiness ...


>> +
>>   	probe_data->cxl = cxl;
>>   
>>   	return 0;
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.h b/drivers/net/ethernet/sfc/efx_cxl.h
>> index 04e46278464d..1c294cd1df56 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.h
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.h
>> @@ -20,6 +20,8 @@ struct efx_probe_data;
>>   struct efx_cxl {
>>   	struct cxl_dev_state cxlds;
>>   	struct cxl_memdev *cxlmd;
>> +	struct cxl_attach_region attach_region;
>> +	void __iomem *ctpio_cxl;
>>   };
>>   
>>   int efx_cxl_init(struct efx_probe_data *probe_data);
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 10a9b8fa2f6b..22d9435b351f 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -7,6 +7,7 @@
>>   
>>   #include <linux/node.h>
>>   #include <linux/ioport.h>
>> +#include <linux/pci.h>
>>   #include <cxl/mailbox.h>
>>   
>>   /**
>> @@ -153,6 +154,20 @@ struct cxl_memdev_attach {
>>   	int (*probe)(struct cxl_memdev *cxlmd);
>>   };
>>   
>> +/**
>> + * struct cxl_attach_region - accelerator region handling
>> + * @attach: invoked at cxl_memdev_attach_region() with endpoint device locked.
>> + * @detach: invoked at endpoint release.
>> + * @data: pointer referencing accelerator data for attach and detach calls.
>> + * @region: initialised with autodiscovered region values linked to memdev.
>> + */
>> +struct cxl_attach_region {
>> +	int (*attach)(void *);
>> +	void (*detach)(void *);
>> +	void *data;
>> +	struct range region;
>> +};
> I like your approach here,


Thank you.


>   but have a problem with this. It seems like an attempt to circumvent the cxl_memdev_attach
> struct above, which makes it borderline useless (as of now). Would you be opposed to folding it into cxl_memdev_attach
> instead? I'm thinking doing something like:
>
> /**
>   * struct cxl_memdev_attach - CXL memdev driver and region attach handlers
>   *
>   * @mem_probe: Callback used during cxl_mem::probe for memdev specific setup
>   * @region_attach: Device specific setup invoked during cxl_memdev_attach_region() with endpoint device locked
>   * @region_detach: Device specific cleanup invoked at endpoint release
>   * @region_data: Pointer passed to region_attach and region_detach calls
>   * @region: Memory range covered by autodiscovered region linked to memdev
>   */
> struct cxl_memdev_attach {
> 	int (*mem_probe)(struct cxl_memdev *cxlmd);
> 	int (*region_attach)(void *data);
> 	int (*region_detach)(void *data);
> 	void *region_data;
> 	struct range region;
> };
>
> and then replace cxl_attach_region with cxl_memdev_attach accordingly. I think that's a 3-way win: You get
> what you want to do, Dan's work isn't invalidated, and cxl_memdev_attach becomes a one-stop shop for all
> CXL accelerator attach shenanigans.


I would prefer to have such mem_probe aka attach by DanW decoupled from 
region attachment.


First of all, because they target different situations, endpoint not 
being ready in the first case, dealing with a potential committed 
decoder and auto discovered region in the second.


Also, the mem_probe thing is not necessary for our device and for any 
other one connected to one  CXL Root Bridge as I have been saying since 
Dan added that option (or waiting for another reason behind its 
necessity). I agree it could be necessary for other drivers, so happy to 
have it ... for getting the memdev. Note the current patchset version 
does only cover the case of a region already there, but as the effort 
had since first version, there will be a need for getting a region where 
the caller can decide the size based on not only available CFMWS but 
whatever the driver considers knowing the amount available and the own 
driver configuration. Once you have DRAM in the device, I envision cases 
where the amount of memory used for CXL purposes being only part of it 
because the device/driver configuration decides so, then using some 
portion of that memory for other internal purposes.



>> +
>>   /**
>>    * struct cxl_dev_state - The driver device state
>>    *
>> @@ -231,4 +246,6 @@ struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
>>   int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
>>   struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
>>   				       const struct cxl_memdev_attach *attach);
>> +struct cxl_region;
>> +int cxl_memdev_attach_region(struct cxl_memdev *cxlmd, struct cxl_attach_region *attach);
>>   #endif /* __CXL_CXL_H__ */
