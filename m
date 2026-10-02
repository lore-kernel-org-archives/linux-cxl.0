Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011064.outbound.protection.outlook.com [40.107.208.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10E0385D90;
	Fri,  2 Oct 2026 05:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790919241; cv=fail; b=NXSiNwAJGY3eRuoPLlelpYy7Nm3qjCjU+QXcHhviDUJIc6TQqlGVk56zE+XeeoFZCnuasOBkw81yleVp1Dj38QfvV+1ySSVSqqgUkI6L2AhsJ//GvKmcYBe32a8qppffZA25EzmT4XLWQeouqGHScFto4jmvtnPCEElrHON/v5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790919241; c=relaxed/simple;
	bh=Y0sHUyIM77be/vp4pU/0rsGMGPpc0KAQilB+BTH1nmc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=j3Gti5uUmLP3wSFjkablMnm3et86Ji4EgP81evCzUX+xlLrpKQuXEZ7XuMrr9oUk57ECOD1wmcvKxO68auWKRP5aAjrnofPzGoj7LK2xowdnoPRk9tEJuXoen8lAR1eHT2+XbQHbC6XQmOxtRdeGCJU/OMQggwjYP8p4cgCCQyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Cbyz+Gt7; arc=fail smtp.client-ip=40.107.208.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Cbyz+Gt7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qx/DHZCS1XRMz4T71WMI1K7xJ0nRAUWWYMbNmeQBRU/Fcst9bLYeZ34buqMLn5Ls8T3iRCdnkfMrLt/V+IEikAtRvDFukTh1ntd9kr0bHoHKNjoGGqgNQAJq5nL+kuazxRmacoNGj6SSlWNk65porRpjm20ipQ2aWdx0FEPciS0m6gOe5n/GVt964GhPUaXWJmfdTLleQRqWUqw9zQMHCHIQhfPzujJZerkkfRQhRxCzcH/5zlGCm/wwVIxjBzzV3YwK4yzdV7HjFeVG8Yuzdv63saQ+sQ5YEOzFJiTx25QRszde1x+M+5BCw/1BAKeKTvlT8yxAQFLSnxp/GdQ5yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6PnmGx1B5Jvs2n9jY1BARUtVpEfPo5BR4gGuVFe9o8=;
 b=tHcUDCjJu335ysF5ykoxOhGWsWObZWeFDa1Wg6PfTsXscgvncGFn1OSo2ApQpK/j/IDGkIpcXE47IqOeH2TsELabDGC5aN4bbiy4EtU5cPNdzwBa+BXInsEYj+NTy4+8SM5+472aBNfht5IXzTQucGCsQgJZ/Z2xec1PNjTl6RyvRvrXDMOwSM9tH0wh32ucyiBNEdFpex8iTMD5Ud4hIZUdckknKbhp5fz2goEfi4Z3qquB+JszwQKXPLOldaNvB19/L2wWhCImA59lgGX9QVRFQdz81aV3OE2xH2v6J+GXU2gx2z6HG4x4F71vOUqEyMzi1GgoFNdGUY4R27uHGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6PnmGx1B5Jvs2n9jY1BARUtVpEfPo5BR4gGuVFe9o8=;
 b=Cbyz+Gt7NRLvlQzawDvuvuKd1otKy0LdoTysx89KeqNSLseW1nQ0JsPPnmdV6br46hdGsQoe0gsP8eN0amy964dXmOYZQQe5BA3i2HhkgHFTTGNzUA/bPCj4mfsoSN4V3ENQN0sPKir26LzxBZn+R50NF5F776MHT0l9nnVvibQ=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 MN0PR12MB5836.namprd12.prod.outlook.com (2603:10b6:208:37b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Fri, 2 Oct
 2026 05:33:53 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%4]) with mapi id 15.21.0451.022; Fri, 2 Oct 2026
 05:33:53 +0000
Message-ID: <dcfb10e7-d07e-452b-974a-7e949c809465@amd.com>
Date: Fri, 2 Oct 2026 06:33:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] sfc: add multipf support
To: Dave Jiang <dave.jiang@intel.com>, alucerop@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ecree.xilinx@gmail.com, icheng@nvidia.com,
 rafael@kernel.org
References: <20261001132023.17032-1-alucerop@amd.com>
 <20261001132023.17032-5-alucerop@amd.com>
 <57254762-04e8-4a98-9265-5376f75a6f3c@intel.com>
Content-Language: en-GB
From: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>
In-Reply-To: <57254762-04e8-4a98-9265-5376f75a6f3c@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0116.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:bb::16) To DM4PR12MB6254.namprd12.prod.outlook.com
 (2603:10b6:8:a5::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|MN0PR12MB5836:EE_
X-MS-Office365-Filtering-Correlation-Id: e74c0ecf-1d38-4d6f-970b-08df2046bef8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|23010399003|366016|1800799024|376014|22082099003|18002099003|56012099006|11063799006|4143699003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	4J2dqCfnGYsxfXez+FpvHDBlHbc4GiWyIViLGxRCB/hw0fIjfYrgWXoS9rDzFdREeDcmPnERnuVacre4nUI/PGv/+JvGs9uEXjYCMPzn2qL1+BFsyqrkKrEYirjKJ7Upu6Z66l8hWAcsiMmuH5sSTmYcnyhZJyds2yNapHK2q6AHkrF0AhIKxvLr1GQyt2f/OnHPCe99W3dlkkqcCCcN13R/LErpvZjyNPmnzfm+9tdH5oBdf8ihYPt5QW2DAxK3ZTDm+6x96E4Hto2z0djtGnLVD3es3NwveaCC41mJC334tSRGHmZttqBjbiRkahqpg3yXiwRkIAD0+HjWD6QQTOHQ2DkPTMdMq4roYk/HcP73QfzC9aWLb+RuAm79R56pIjpr2SO0ylW3nZr8qiV3bj/YaFx6/+FfIvvNLDmH7kgFnVuNqQYbQEre/MV0xC6VyTe9EVmhFC4IMLZlvKCVUElTzeEoUAyVIlk9nrUUUSHQ1Ld00JmGqbghI9X4XqycagVCAVfvuawb5Ppexgx7/bSAwwUFD4QKOFDKdnP2tK4a9gnoeZ7rr09WDUfYYMc00Q7VMaQRpOzoySq4PKCHh5pRuUe1JAPOKJHYX3ViFL1ID4T8AsogwmJKeruxMLTBqgBwOUjv6rYC4ZebqiukMcfaeHr2AtKGzlcpFDQgx9Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(23010399003)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dkVuMlZuLzNaVjhsYkMzS255SFJGNzVYT0kxYU9OSnFlaXRZYTdybUZ1RVdU?=
 =?utf-8?B?dXlNS0NObmt0MEZCSE5YQ3JkeXg4dy9OLy9rVitMcXc2SWpvUy9uaGZNbnJa?=
 =?utf-8?B?OGtWc1hzQUx3dHdhaUt1Ny8zTDZ1Y0w0bTdvZ2ZJNTdtOEgyRGF5QVJuay9s?=
 =?utf-8?B?T0MwZGZIZTc0U0VXUUtvazhDUVlwNUVOdGRkTnpnYjY1V1RxUXhJQXlLSTk3?=
 =?utf-8?B?c1BsY0RqTUxpMmdoakZVODIvZXpLa3Z4bkxmMVlUREQ1U0VmSjJLM0hieFRH?=
 =?utf-8?B?SURmQmVXa2Ftd0wreXZ3cW5WWnVNaVNwZ0Fmem11RVZ2ZzltTHRMamJ2WVBh?=
 =?utf-8?B?Z0tXRXNYbWVmRlJ2SnRQa3NJVEQwS1JsU29pT1F2RjBEZktsdGRtbEdWTm5k?=
 =?utf-8?B?UGNEaTJzanR0RzVvdUhEMTlxSHpOd01XVEU2WHVqbUxCRURjRHlzYjBEME5X?=
 =?utf-8?B?OWwwdnhNUkxDNUVvTHhpYTFJU3RGc2lHUlJSaEtwREgxMG5md28xN2tzTHlJ?=
 =?utf-8?B?bjU5elcreFV1SE44YTFaSHdSZGppanp4Qi8vMkw0c0ZsOHBZY1FpYW1ESFQx?=
 =?utf-8?B?ZFcrVk8zWUxvNU13TlBlMk9DdkUzT0RCZ1BhNU1yUTFwdGlzWm9INW1Bdldy?=
 =?utf-8?B?bHVERTBUVEpMUExjbjBsbEl0YVBsaVJTM2d5WDBXSWc4eVI2UU1aUmkvc1Yw?=
 =?utf-8?B?bWhMbEt3WTc2ZFpnQnF4QTVHbXVOdFdGYldra3ZPT0xTZTh2YmRtL0Y0UTNL?=
 =?utf-8?B?VjNRUzgzRm9FY05sYWtlZEpoa0o5cFhTckx2dGpCdmgxNzFlUGsrYnBkcmZZ?=
 =?utf-8?B?bnhOZlovTTBucFltVWwwYWxlQ2MvVE5SYjJJTTdVMXJYY0ZpTm9qblpsVHJC?=
 =?utf-8?B?MVQyTTdGUlVuTWdCaWx5UFB2c1FjeUw4WnBCMlE5aDhmOGlNd0llNExwR2pi?=
 =?utf-8?B?RDB0SG5HdEJxbU9lTkpVUzdBL29LZWZpSUFidWc1QVJTYTBWOUpHckdBQlhz?=
 =?utf-8?B?ZSs2RHFyb0tqM3Y1a3ZXUGViM291UVczdC9EL2wzcktFMjhvQkdxRUhmblQw?=
 =?utf-8?B?OWN1UUxBRzlRS0FuZWNpTzhwbjNSZkFWUVExU1JhTnBJM3RLeTUvclh2ZFBl?=
 =?utf-8?B?eVhXb2RrSXZsY2lDNjBRQm9yWjZVb2liazRlNmw5eVJ6VS8wbG10R2ZZaGMx?=
 =?utf-8?B?NW9OSlR0dW15enowa2dKZ0JUOHdURDhCWXJnMlBqeW1ZVDdLZ1JNTHZXWlpw?=
 =?utf-8?B?c0FMN0JYUHZjdkxTVmVJbWgvWmg2TkgzbG9KdENmNURDTVRHVHVmbERndzB1?=
 =?utf-8?B?NFB3U2xsRWVrdkJDZDd3dWZPWHNNTjFJcTZiUUZSMDFxaHh6cElaT3FQcUJ3?=
 =?utf-8?B?Ymh6RnROZjdRTDJkR3U3Nndhb0JWK3pOYkNoUmQrQVpMQk5pTkpvZmIybWY5?=
 =?utf-8?B?SXA2OGpmZUhhVmJrQUF1R0orOFhJVXU5NFJsNVA3Z01waFdxYUp0amtXamZY?=
 =?utf-8?B?cGhJbkFuZ0M2eFNzYTZzbHNlc2EyYWRHRVh5bStoTXRIbytDek94MWN3Zlo0?=
 =?utf-8?B?MzIyVS9MN3lseGxNbHRJNkg5V2ZzamEwUFJLeVhBMlFrV1kzT1ZYdjhkVkJI?=
 =?utf-8?B?Q1RpMHA4RU1LZVdwVzIrcnl0UWRIbEtvUm1yTkFCcC80U0Q4d09DbnhsLy9a?=
 =?utf-8?B?QTVEZkdyQS9kN3pBRGt6SEJNMUxsYkZzQjF1QjNuQ3JsbjJlUWErcHBMT0ho?=
 =?utf-8?B?R3pVL1BNTlV1WUZGZGVKVmtnL0UvRVVIN211bkVLQWZobkNqR2dFaHgxazk5?=
 =?utf-8?B?L20rY0xjTzQxVjM5OTlJR0hWYzJFbjVxWSs0cWdxbitvUU9lSFBad3U0Nmp0?=
 =?utf-8?B?MVJNRlNZM2VxTWxRd3V0ZjdDU3lmMUVNbWNNaHp5QXNlT2dpbkhQVTBDWUQ5?=
 =?utf-8?B?S1pGWUVhRnVRRTljc3BBMEppSmFVSnRqNStHckFTVFhocXR2cjJqWTFrdDFF?=
 =?utf-8?B?N0xsUG9qdWtDWXRuUkhoZGhNZCsvTGRmem9vL01WMEp2VG9mWDhkT0k5anFm?=
 =?utf-8?B?dk5PNDRhMWl2VnZ4ZjB2bjlTbkdKTTVaVGU4eHlkdkhtbnB6OUY2aVFZc21x?=
 =?utf-8?B?bkdzYjk5Sk5UVWxtRVRxRVMwN0ozWUR3SDcwWjlwckpNYmFtMWRSWVlENG80?=
 =?utf-8?B?M0xYQldLbzZDc1llcXArWjFJdlQzT1BaNkcxbFFndUtTbHZrNXVXc0tmVlRl?=
 =?utf-8?B?VW5IMHFJbGhWRDlWUnhpK0JJQ3U0dlJ2QkJneTc1YytFN1hXZkZvSDQ4Y3Q4?=
 =?utf-8?Q?rx3da+Q+Zohirbbh0R?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e74c0ecf-1d38-4d6f-970b-08df2046bef8
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 05:33:53.5041
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ffHoe4ZtYjYbqr2rURYuh+VN+IIl18+WJcwE7RTghxMgJdupZkKSv1j2e0ldGndshuJahMrG86acTU/ucnTOig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5836


On 01/10/2026 23:32, Dave Jiang wrote:
>
> On 10/1/26 6:20 AM, alucerop@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Use CXL core accelerator API for linking a non-PF0 PF to the CXL region
>> its related PF0 CXL memdev is attached to, allowing non-PF0 PF release if
>> such a CXL region is released itself. This can occur in different
>> scenarios like PF0 release or CXL memdev release.
>>
>> Obtain the CXL HPA region to work with and the ioremap based on such
>> HPA and an offset based on the PF index.
>>
>> Refactor CXL initialization with different code paths for PF0 and non
>> PF0 PFs.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/net/ethernet/sfc/efx_cxl.c | 100 ++++++++++++++++++++++++++---
>>   1 file changed, 91 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/sfc/efx_cxl.c b/drivers/net/ethernet/sfc/efx_cxl.c
>> index 348d7404cd7a..f884580cb528 100644
>> --- a/drivers/net/ethernet/sfc/efx_cxl.c
>> +++ b/drivers/net/ethernet/sfc/efx_cxl.c
>> @@ -13,8 +13,69 @@
>>   #include "efx_cxl.h"
>>   
>>   #define EFX_CTPIO_BUFFER_SIZE	SZ_256M
>> +#define EFX_CTPIO_BUFFER_PER_PF_SIZE	SZ_8M
>>   
>> -int efx_cxl_init(struct efx_probe_data *probe_data)
>> +static int cxl_map(struct efx_probe_data *probe_data, struct efx_cxl *cxl,
>> +		   u64 devfn, struct range cxl_pio_range)
>> +{
>> +	struct efx_nic *efx = &probe_data->efx;
>> +	struct pci_dev *pci_dev = efx->pci_dev;
>> +	u64 cxl_pio_pf_start;
>> +
>> +	cxl_pio_pf_start = cxl_pio_range.start +
>> +			   devfn * EFX_CTPIO_BUFFER_PER_PF_SIZE;
>> +
>> +	cxl->ctpio_cxl = ioremap_wc(cxl_pio_pf_start,
>> +				    EFX_CTPIO_BUFFER_PER_PF_SIZE);
>> +	if (!cxl->ctpio_cxl) {
>> +		pci_err(pci_dev, "CXL ioremap region (%pra) failed\n",
>> +			&cxl_pio_range);
>> +		return -ENOMEM;
>> +	}
>> +	return 0;
>> +}
>> +
>> +static int efx_cxl_non_pf0_init(struct efx_probe_data *probe_data)
>> +{
>> +	struct efx_nic *efx = &probe_data->efx;
>> +	struct pci_dev *pci_dev = efx->pci_dev;
>> +	struct range cxl_pio_range;
>> +	struct efx_cxl *cxl;
>> +	u64 devfn;
>> +
>> +	devfn = PCI_FUNC(pci_dev->devfn);
> I think you will want to use pci_dev->devfn directly. If you do this, devfn is 2:0 and PCI_SLOT() will evaluate to 0.


Uhmmm, I think with the refactoring I'm not using devfn properly here. 
Let me study this further.


> Also, does this device need to handle ARI?


Not for sfc devices.


>> +
>> +	struct pci_dev *pf0_pci_dev __free(pci_dev_put) =
>> +		pci_get_slot(pci_dev->bus, PCI_DEVFN(PCI_SLOT(devfn), 0));
>> +
>> +	/* This should not happen! */
>> +	if (!pf0_pci_dev)
>> +		return 0;
>> +
>> +	/* Is the PF0 device configured with and using CXL? */
>> +	if (!pcie_is_cxl(pf0_pci_dev))
>> +		return 0;
>> +
>> +	if (!cxl_get_range_and_link(&pf0_pci_dev->dev, &pci_dev->dev,
>> +				    &cxl_pio_range))
> Is this error check inverted?


Yes. I'll fix it.


Thanks!


> DJ
>
>> +		return  -EPROBE_DEFER;
>> +
>> +	cxl = kzalloc_obj(*cxl, GFP_KERNEL);
>> +	if (!cxl)
>> +		return -ENOMEM;
>> +
>> +	if (cxl_map(probe_data, cxl, (u64)devfn, cxl_pio_range)) {
>> +		kfree(cxl);
>> +		return -ENOMEM;
>> +	}
>> +
>> +	probe_data->cxl = cxl;
>> +	probe_data->cxl_pio_initialised = true;
>> +
>> +	return 0;
>> +}
>> +
>> +static int efx_cxl_pf0_init(struct efx_probe_data *probe_data)
>>   {
>>   	struct efx_nic *efx = &probe_data->efx;
>>   	struct pci_dev *pci_dev = efx->pci_dev;
>> @@ -80,26 +141,47 @@ int efx_cxl_init(struct efx_probe_data *probe_data)
>>   		return PTR_ERR(cxl->cxlmd);
>>   	}
>>   
>> -	cxl->ctpio_cxl = ioremap_wc(cxl_pio_range.start,
>> -				    range_len(&cxl_pio_range));
>> -	if (!cxl->ctpio_cxl) {
>> -		pci_err(pci_dev, "CXL ioremap region (%pra) failed\n",
>> -			&cxl_pio_range);
>> +	if (cxl_map(probe_data, cxl, 0, cxl_pio_range))
>>   		return -ENOMEM;
>> -	}
>>   
>> -	probe_data->cxl_pio_initialised = true;
>>   	probe_data->cxl = cxl;
>> -
>> +	probe_data->cxl_pio_initialised = true;
>>   	return 0;
>>   }
>>   
>> +int efx_cxl_init(struct efx_probe_data *probe_data)
>> +{
>> +	struct efx_nic *efx = &probe_data->efx;
>> +	struct pci_dev *pci_dev = efx->pci_dev;
>> +	u8 devfn;
>> +
>> +	if (efx->type->is_vf)
>> +		return 0;
>> +
>> +	/* are we PF0? */
>> +	devfn = PCI_FUNC(pci_dev->devfn);
>> +	if (devfn == 0)
>> +		return efx_cxl_pf0_init(probe_data);
>> +	else
>> +		return efx_cxl_non_pf0_init(probe_data);
>> +}
>> +
>>   void efx_cxl_exit(struct efx_probe_data *probe_data)
>>   {
>> +	struct efx_nic *efx = &probe_data->efx;
>> +	struct pci_dev *pci_dev = efx->pci_dev;
>> +	u8 devfn;
>> +
>>   	if (!probe_data->cxl)
>>   		return;
>>   
>>   	iounmap(probe_data->cxl->ctpio_cxl);
>> +
>> +	devfn = PCI_FUNC(pci_dev->devfn);
>> +	if (devfn == 0)
>> +		return;
>> +
>> +	kfree(probe_data->cxl);
>>   }
>>   
>>   MODULE_IMPORT_NS("CXL");
