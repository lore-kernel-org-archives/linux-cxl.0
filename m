Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010023.outbound.protection.outlook.com [52.101.85.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2934322FF22;
	Fri,  2 Oct 2026 04:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790916104; cv=fail; b=k1vQ+3Kf30pJxDUfBXxs8XJ4SxugLOJjuSnwaV28EdNGyTrVU/gLJlS1WE74JTU1TR8va5Lj73Ibcej9BkX1cCJxQTKf6LwmhM5CR0QIOFSNLBN5Aqg3YQcZHEtExIeaaVIJVxox2qU2HkjWRouzLG7n7wr+56fhRMTSJI7LmGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790916104; c=relaxed/simple;
	bh=Qv6Y+SIfay1uOd2HZS0UKDXmO7zwNP0nV81NuvGWEqw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cASKa/1UooMw5oP9bKMWD73by5S7BZWAfAhORNQxG6UUxnSIxs8mDE/+jv5mG4hKvrDATabJYXM0W8q+eHe5B/O0VBKkq7HiySnNy9ihLrGtwHVQrVlWLnjX8r8ihoWE2xiEfDHFhaihfJqXe2Doo3p8uYtbbwx3ujlDIELqvao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ngEH8R6p; arc=fail smtp.client-ip=52.101.85.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ngEH8R6p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=naTWOTk84H3siH/awDpXXpx4PziRYC/l/hQCITHYQicv5Vn7CFH1vlZFlbucS4OfMpAykS6mjNvvKoufXIk6nGGgeAi0M57bNTwwOX74Z5lvXXsxw3YCSGLVSjZfCHeAcSD4BT30WbEMX71nlXaUSgXMUlRZQJQuKqgjtZTCX2T50YYoVu01AAZ2sUU7mEDLnptUmjz36BOt4xV+V77QjiRBkKclZGKWtz0BRlFz3hC3b2Xsh/KtyHqBFM+TQt5qYyfrwM8xH79ZeRJRLUV1jClRphy/HeNI2wJ50mv9geIQ5ZZDunjoNrfuAPUO+lcTh3Gqr44nYwFJEX//mBi0sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7C+azOQHMg8Gg30GL3LCK8ZPsnI4DN42zZX0CSRKUac=;
 b=rCVKsONa+OeH4WqDOehxaM3H5036NMph5iRF76x5YoE/APCn/tMVntz5pWienwgle4XC/4bb6u60GIqABqBnbTyP36MJnO/4CLuaR2yG58G8o3enWtvt74Iat1p3gYcSFOwwDOKyOgEZKge0K/f0jY29LJ3m5QMa5bTiHzI0/RQnq2TB4PLwLr1X+KXG6Dff5wIQzKuz3nY3xT49nWdbjF9MEuanoG1u0vYrhrfH9rMdWyZz+ysBrHTBHJHV0yPxCX7qcjyaRWgaw0FD91L+VJxmhJUSwCfhSt8rkNM0eVIWjgFS1ehOCunkD/E6FMxALtxTU6kSbriJRUPOQzz7zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7C+azOQHMg8Gg30GL3LCK8ZPsnI4DN42zZX0CSRKUac=;
 b=ngEH8R6pDh4a5Uh+eKZu7/MCB8ZXFWd7JMsUfmKhxG2UCOFQ9Zz/iCUQ4XTSpuFiSXoRFXQ90LZ2/W/T4Y/aegF4uHPG2CgvfgWjk2yFl7UjvNEXCDD1d0y/WTt67u2El47yXBE650TDKOIGFbzGruh0Ot1tlk4KASw/W+1ZkFM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 SAWPR12MB999269.namprd12.prod.outlook.com (2603:10b6:806:55e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Fri, 2 Oct
 2026 04:41:40 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%4]) with mapi id 15.21.0451.022; Fri, 2 Oct 2026
 04:41:40 +0000
Message-ID: <8ebaae42-a0c6-4e9c-be1b-ca68a4769ed7@amd.com>
Date: Fri, 2 Oct 2026 05:41:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] cxl/region: Add region reference in memdev attach
To: Dave Jiang <dave.jiang@intel.com>, alucerop@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ecree.xilinx@gmail.com, icheng@nvidia.com,
 rafael@kernel.org
References: <20261001132023.17032-1-alucerop@amd.com>
 <20261001132023.17032-3-alucerop@amd.com>
 <6bc33514-8bfb-44d6-8fde-28f45dff5eb9@intel.com>
Content-Language: en-GB
From: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>
In-Reply-To: <6bc33514-8bfb-44d6-8fde-28f45dff5eb9@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0354.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::11) To DM4PR12MB6254.namprd12.prod.outlook.com
 (2603:10b6:8:a5::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|SAWPR12MB999269:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b870e8f-eec5-4c08-034b-08df203f7340
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|7416014|376014|1800799024|22082099003|18002099003|6133799003|10067099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	3gXopjtD9z/RM21B/XjfVkQDK5NIHW7jrWY8THilsviEuWcaWnku1GxY7uwiR0dkteD5EM3rshNjD29auIrU1Up70jjp3uyTAkBRPfmXP6hFcWNpvLTygZ5EtPPpy9WGbISe2yG3kWWDBMcNIr+WNNRqfkzxjIKzVVOJNSKoCZdGM/hwwCLf1vVvQrxO23Lzme/2a9NZQiZpgnt+hs5VqNurCL3wutomcC3IYXejnRVB3cFnBwiXGUDoG8rKfS9Sne5E68UyMXz5LfXKeAJ5DjyErJPb6YyYct5L2eOEPxNkf2439DA5gnIkYfLXba1m+hxmhVN4r5BhYIJ63/ogEq34je62LqGb0zNp3xLtvIWEOnyP1fMHq+vzQScxcM1HreY658J6Iihjuzu/5aw+xQ17JJ4ttlInPKgqWdVv6rTrRHRy1wqiTSkiRZMJr9n2Qa3fDyo8Q5s79ccNGfnuWNduY2axSalm4OcqXxfRXZnpXGvo49w62xesjpdJxFe5AUkDBu6Kzm6k+tT33GXEjCO15DmeU5YaGANPVPepsqpZGYMSPqAq4M70oE9deoTkPXIY++0NgctC/oWXGzxAszEXhm8ftOr1LZjD6CrFzp71BfTMRcrQpqour2QNQtXGusY0NMdEoLFpKRd46Cjudgr1hCde3IEmbMsQrOF8ObQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(7416014)(376014)(1800799024)(22082099003)(18002099003)(6133799003)(10067099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmJhekJqRzhmbEhUSDYvdEJHT2lvV25tNSttbExubGtkTGJSa2YrM29CYith?=
 =?utf-8?B?TGkrU2t0RktZYlQ4Q0JlWE93S291bHczV3FFamFKaWN5cVdrTTVKeU03MG5W?=
 =?utf-8?B?ekdnb3doTHQ2RTN0QWcwa3VzVVJUQWVHWlZ0ekdDNXVJc2h5UVV3Mm5CdW5B?=
 =?utf-8?B?U05BRjBvaVp5c1F2WjVuVWdvVEVxV1hlNXg2YWsxV1VFTTBTQXhXZkk1SlNu?=
 =?utf-8?B?QkJ3Z005ejN0YXMzbnA5U29KQWdvWThDQkpsaUVWV2NqVWU2UyttMzl0L0Ir?=
 =?utf-8?B?L1FaZ0ZIMXR4Smd4c2RwdDZISUxYamd2N3FvOGNHWnN6Z0dnME5NRzQvck42?=
 =?utf-8?B?b3Z0WldTdTVzN2ZZemRzY3lHUlU4TGpoSTRsSEptbFhhMHZydFJYRC9RdkR5?=
 =?utf-8?B?V1lPc29SRnJjUTBldU5sK2xJMHVzMlZ4STVsMFpJSjUyY05tZVpxRjBWV2N5?=
 =?utf-8?B?Vkl0NnlSSytaMENyaFRycWtjZ1A1cFQzc09ETXQrbEtjSHlwNzVQMGF4NzB2?=
 =?utf-8?B?NFlPUlNydGpqSCsrc2dydk1FREdTMWt3TExVTTg3RDBlWnNpTHpLeUU3ckxr?=
 =?utf-8?B?clp2azhCOTJRc2Yxdzdzbnp4b0tBTWFMckVWL0laS0tld3VPWGJTbVBPd2hr?=
 =?utf-8?B?YmtINFl0d1pqWEFicTNvVzVhWEtMa3lMZGRrZStyckhLSEw4SGlBblZqUUVZ?=
 =?utf-8?B?cWRDTDFZdUhkSUkrT3VIMUhvRzNVQXBIbmsvOG80MnFwMVhhaFA1Ym5VbFdp?=
 =?utf-8?B?TWVBbXVSV3RWY0tUc2FxcTNHZkJkSE4zYTlUY3VzUmduSUNyWDArdjlFdUJX?=
 =?utf-8?B?TVVLLy9iQXBicGpScTh6UTB4SmxMclJqcENUVHJidU5kRVNOL2xGSURvT2JJ?=
 =?utf-8?B?cW00WnlENytTck40cFZXWHR6MXNvcnpqZ1ZsUmh0QnBYNHJicXVLUnBaMDdV?=
 =?utf-8?B?a2xoUHRYeVlCKzBUVzNlRytNb2hiclVkRmtyOXdIRllYQmZBVUo1aGhVSytG?=
 =?utf-8?B?MC84VDUzREl2NXhyU0pJR0xJM0xScysxMU52dG1OOHpQMFdMTGpQOFV3Mnlq?=
 =?utf-8?B?bXZiOEx3MEtnRzdwWTlBUmFxMEoxRTRkaFg3dnZXZ2lHYTA4cHg1UGs3WFM2?=
 =?utf-8?B?U3VSOWJicHYzUGVQd3RFeDJpQ1I2UmVvcHVhNVlSajVSbDFVWHh1ekNlbTQx?=
 =?utf-8?B?bEtWelpZeDlqbnFOZmwzaGRGQ3g0Y2QxNlNYQVpGTWc0aVhqeEZSa2V1QmFO?=
 =?utf-8?B?TmxuZGRoK2VRbjBMYm16U0dMNlFYczk0S0Fqa3N6NDFKdXlUZmVCQmJUTFRr?=
 =?utf-8?B?c2pmdDA5R3p2YjNEQThna20xbXZSbTlobVlPMUZ0czUvaS9ESWloNGZ1ZVBj?=
 =?utf-8?B?ODFWYmhrTlQ1RkVidkd5VE9UVnRscDlGcmhoQnZpc3ZybW9mS1V6ZXVuU2cr?=
 =?utf-8?B?K2M4cW1XUEtOWUhQdy9CODhxdk84cWthcDA5WmZoM2JxN2xsZ01ManQrR1JJ?=
 =?utf-8?B?N0k3ZENKTTBXM1FaOVlkVVp1V2F3clBEeSs1U0FPcjd4U0FmNno1NnFXbitR?=
 =?utf-8?B?VDVTU1JFaEFXYnVQNkNVMlhZRHN1OG1ab0lKaGVmZVJuTW1XQVZWRHcvd3Zn?=
 =?utf-8?B?L1RMa2FyT3I0N2h3anNmbGtjZ1FOQzZQLzJIUTcwZjhGclExWktsTGFhRWhS?=
 =?utf-8?B?Q1N3VEVldmg5MEVWNE84V1c3TFVNR0VjR0wrT1J0Zmo0WHhXM2EyaTdIK1pU?=
 =?utf-8?B?bmQ5aXFPZlVaWks3TTZPcGlvZGljRVhtejV0aDNPcnIzUDd0Zko1RXlQNHY2?=
 =?utf-8?B?a0hveHJuQ3pxZTVjQm9oQVVGaTZ0SkxkZ2ZzT3lDZ3hpbWtGdFExdkxqcklK?=
 =?utf-8?B?K3dkRjRCaUpPL1NTbk1jMmxvcFMzNlBRbVE5My80a1dFUW96ZklPa1dXNkEx?=
 =?utf-8?B?MEhWUUlTQk11Z3UxQjlWWlZYa1VtNTJCaGpvby9CQXlINTRKV2NoNE5sSVBZ?=
 =?utf-8?B?NlNSa2NNaG5wVUFHLzhvQi9JaEd6Ymh0Qzh2alFQTEJ4cWhud0hFbWRPVFRF?=
 =?utf-8?B?RlNXaHdIR0NUclFoSGJsaWtERkljU0xmYWVCc01iaGhTRFZ6bjVzNjBCQXhq?=
 =?utf-8?B?QW9rZEJaRE5CYW1jdk9DYWVyMTMzN3g5aUhkTmN5Vk5SelJVZ0lQQVV2em9G?=
 =?utf-8?B?M2tnWitHZXZzU0UvU1lQR2dmZDJtanpybVpPOGU0cEZNVEUyNGppdGVVV1lS?=
 =?utf-8?B?bnVFSDVkR3pQR0pyRVphV0NoYVFGTXBHdnJHL2wxbkNrMU0xajRxQzAvbm5W?=
 =?utf-8?Q?r4O5Pd81EKOncMZr2j?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b870e8f-eec5-4c08-034b-08df203f7340
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 04:41:39.9887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uWS4Odn5xlKDmRaBrPCNECdpP71CLK+hWax9ErpvPXaozWcoHveyL/N1E3EJRJSUb9KMWeY6BiKGv+k3KcGEAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999269


On 01/10/2026 22:38, Dave Jiang wrote:
>
> On 10/1/26 6:20 AM, alucerop@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Use a new field in cxl_attach_region struct for easily link it with the
>> region the memdev is attached to.
>>
>> This facilitates device links creation where such a region is the supplier
>> with non-PF0 physical functions wanting to use the CXL region being the
>> consumers.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/region.c | 1 +
>>   drivers/cxl/cxlmem.h      | 2 ++
>>   2 files changed, 3 insertions(+)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 27e63e6dab7c..78ca7ebc3e55 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -4132,6 +4132,7 @@ int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
>>   	if (rc)
>>   		return rc;
>>   
>> +	attach->cxlr = cxlr;
>>   	attach->hpa_range = (struct range) {
>>   		.start = cxlr->params.res->start,
>>   		.end = cxlr->params.res->end,
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>> index c401e3a1af06..c598561b8e5f 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -104,6 +104,7 @@ struct cxl_memdev_attach {
>>   /**
>>    * struct cxl_attach_region - coordinate mapping a region at memdev registration
>>    * @attach: common core attachment descriptor
>> + * @cxlr: cxl region the memdev is attached to.
>>    * @hpa_range: physical address range of the region
>>    *
>>    * For the common simple case of a CXL device with private (non-general purpose
>> @@ -112,6 +113,7 @@ struct cxl_memdev_attach {
>>    */
>>   struct cxl_attach_region {
>>   	struct cxl_memdev_attach attach;
>> +	struct cxl_region *cxlr;
>>   	struct range hpa_range;
>>   };
>>   
> attach->cxlr is never cleared when the region goes away. Unbinding the endpoint port runs endpoint_unregister_region(), which unregisters the region and drops its reference. PF0 stays bound until the detach work runs.
>
> A non-PF0 probe in that window still finds the memdev and calls device_link_add() on the freed region.


I do not think so. This version, see next patch, relies on locking the 
supplier, PF0, before getting the memdev and potentially using the 
attach region. Only on PF0 release can such a memdev and region 
disappear, so I think this is enough.

I added comments in the exported function, cxl_get_range_and_link() 
which does the locking before calling the internal function 
__cxl_get_range_and_link() which looks for the memdev and the attach 
region. In fact, it should not be possible to obtain the PF0 memdev 
reference and the attach region not there yet, but the code is still 
checking that possibility as a sanity check.


Thank you,

Alejandro.


> How about something like this?
>
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 27e63e6dab7c..38ca73f12b84 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -4076,6 +4076,23 @@ static int first_mapped_decoder(struct device *dev, const void *data)
>   	return 0;
>   }
>   
> +/*
> + * Invalidate @attach before the region goes away so that
> + * cxl_get_range_and_link() can not pick up a stale region.
> + */
> +static void endpoint_detach_attach_region(void *_attach)
> +{
> +	struct cxl_attach_region *attach = _attach;
> +	struct cxl_region *cxlr;
> +
> +	scoped_guard(rwsem_write, &cxl_rwsem.region) {
> +		cxlr = attach->cxlr;
> +		WRITE_ONCE(attach->cxlr, NULL);
> +		attach->hpa_range = DEFINE_RANGE(0, -1);
> +	}
> +	endpoint_unregister_region(cxlr);
> +}
> +
>   /*
>    * Runs in cxl_mem_probe context after successful endpoint probe, assumes the
>    * simple case of single mapped decoder per memdev.
> @@ -4127,15 +4144,23 @@ int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
>   
>   	/* Only teardown regions that pass validation, ignore the rest */
>   	get_device(&cxlr->dev);
> -	rc = devm_add_action_or_reset(&endpoint->dev,
> -				      endpoint_unregister_region, cxlr);
> -	if (rc)
> +	/*
> +	 * Not devm_add_action_or_reset(): the reset path would take
> +	 * cxl_rwsem.region for write while it is held for read here. The
> +	 * endpoint lock keeps the action from running before @attach is set.
> +	 */
> +	rc = devm_add_action(&endpoint->dev, endpoint_detach_attach_region,
> +			     attach);
> +	if (rc) {
> +		put_device(&cxlr->dev);
>   		return rc;
> +	}
>   
>   	attach->hpa_range = (struct range) {
>   		.start = cxlr->params.res->start,
>   		.end = cxlr->params.res->end,
>   	};
> +	WRITE_ONCE(attach->cxlr, cxlr);
>   	return 0;
>   }
>   EXPORT_SYMBOL_FOR_MODULES(cxl_memdev_attach_region, "cxl_mem");
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index c401e3a1af06..7cd3a69cd5f5 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -104,6 +104,8 @@ struct cxl_memdev_attach {
>   /**
>    * struct cxl_attach_region - coordinate mapping a region at memdev registration
>    * @attach: common core attachment descriptor
> + * @cxlr: cxl region the memdev is attached to, cleared under cxl_rwsem.region
> + *	before the region is unregistered
>    * @hpa_range: physical address range of the region
>    *
>    * For the common simple case of a CXL device with private (non-general purpose
> @@ -112,6 +114,7 @@ struct cxl_memdev_attach {
>    */
>   struct cxl_attach_region {
>   	struct cxl_memdev_attach attach;
> +	struct cxl_region *cxlr;
>   	struct range hpa_range;
>   };
>   
