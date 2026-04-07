Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011006.outbound.protection.outlook.com [40.107.208.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232E83976B8;
	Tue,  7 Apr 2026 10:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775557569; cv=fail; b=J8I7HC9rjYOPut6PDwH2o8qsZG91Fg+TKlyeNeVwHJXqM1KnixyOeo99SqpKVT5TSy71A5BMSiwu7FkfY/lZKYxe1JcTrwq9e6jqeG2On7UnBTwByVXjcYec+hiL/8xkJsa4dcqSkBL+QuLWQE9Ky8VL6w1JQVme0uhm+nX12XE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775557569; c=relaxed/simple;
	bh=ZmbwWj46CJAf0Pa7pwDUIM1EuhgOXH4XH3Nz/WgrmPg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GszVPbnXDHQ1zU/PWnx3gR+kj39F+t6ytWDOtd3Z08UYH0FJ/0Vqv8yd7UX1MhCLFCkSpL7daa4lyyzjj4KX2Nqmkg3dVMoE+/XucnvOAo0iWYOBkaCAe1pnlnijQewxotFJcQkIZSYnPxRi+fTWlYN42JNgeK9mVHZlVo8GFI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QvpIEyPR; arc=fail smtp.client-ip=40.107.208.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QvpIEyPR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JcotMYDYZgRUCH7GzLsCTxQbpCqlqpJzwI2wYHYC+hAt+42BYZHiAYS01UupXFkfJ+Lfxsild7VB4uGVJ5+9xD9QeAM+aEjSwJYy3KxvO6xjCsvvFYrPlAyKtoNXEv0bHzLudFh0DK4BZ9TWT8WqcbQhWOk/opw+/5qTBZKA4aAuZwzl86f1m/wfMQ+vJLsM9/xL8kkI20bm9OEq2ZQRrlI6KR/MSscsQyVboPM8TDiv6Br5kmdSdewC8oV99qDEB7reauwudjQpVjbGjPU/LDL93aoLgYcwTkmNNxSkLl7YmCr5iaAN05PVJAHt8dFJ/hXndx3i417lmKC7UQeNhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k2E6aeYysaVfxzNm3/Y2wiLQp+x8hMAHOn99K5x0DGk=;
 b=QdJh9PLdmgEraPM6DNFrSxX3s9S+hk5pytg0nyIonpm4e+VU8t3v+K77Wmm9Uc0pnX68c5BpGmu5f7pGyyEXrTG4NKyXYcYcmrVWL/Ia+OWfrsk6svrfX18u10GiRiTcA20KuAhNFDkauGUwaIybwRrNXGdjWK5ZUej4MPlI/dbhSMr/21GeHVc0Cc8L+Q+0CwoKME0JTzylaAKRi/dhxerLQxrK1k15uGqEkVfwABIzUJ/v5guWxjFwfkF2YbHbLplyNDtOqWAhFUQAwHeoaMgoR/7TaI8xdHmK4i9ru0v8wERNcrrpQQFXX5nfrUElY4aQrzIfU3cSePsjjtErqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k2E6aeYysaVfxzNm3/Y2wiLQp+x8hMAHOn99K5x0DGk=;
 b=QvpIEyPRvcd7/YwBbI2o6cIlJATPYAxAitcgNvEEjvlM4bU80x4JrC3ATwTcmaVWSh0Tz96SSQoSxMimjJ5YTIcu0jxR7ZMK5sNnPDcUbnR02tMOXAn7MeBnfRr2t0RYIRY2v36CXj6ikWaQ1459Cly+3V9Q/v/66lYjJm2jqus=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DM4PR12MB6541.namprd12.prod.outlook.com (2603:10b6:8:88::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Tue, 7 Apr
 2026 10:26:00 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%6]) with mapi id 15.20.9769.016; Tue, 7 Apr 2026
 10:26:00 +0000
Message-ID: <1bb8bdd7-1083-4b08-8d9f-21d218e383ca@amd.com>
Date: Tue, 7 Apr 2026 11:25:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/4] cxl/region: Introduce cxl_memdev_attach_region
Content-Language: en-US
To: Dan Williams <dan.j.williams@intel.com>, dave.jiang@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 alejandro.lucero-palau@amd.com
References: <20260403210050.1058650-1-dan.j.williams@intel.com>
 <20260403210050.1058650-5-dan.j.williams@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20260403210050.1058650-5-dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0202.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::8) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DM4PR12MB6541:EE_
X-MS-Office365-Filtering-Correlation-Id: d6518e9f-ad3a-4e6d-c097-08de94900fee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	WnKIMm/pZ2hWl+CPdWfQDlV940ltRaSjeD4l2d1LwV3znxqAYqmHYKnW+DYfULUc7gw2f7l8rg+ttnWQ/Z5t0gfruy0wHXmSlrUfxWBDUTUk48FALohEre6v9YR3/pOKYLdYQ+pJe7WbR9Uy6PBucujCydrize6q4EJberVKUiNLdTEQ/qN8+ZzxIDYFijqQuIeCd4W1hSa5kCGWsytFhzXb7KKfFxtbPpGtZEOYPpdEk0aMa/ifn2ifJqZh+564iIZQWgW5O5Qqr5nESp/T4S+9CHBRYXzsBOGQ4GRKAkffuBs38LsP+QhsDZV7pExXgbK28uaWf1clXHAQmYxDL1ARjjSL0X6rdfpKIGZxGtTSUw8Fbs8yShLB2MqbNbhynwbWZ/XBdCVVAAfG0P4pwQbgDXQLN7PvulCQk6Aa4yepTlL5Vyl0pw7IkGvHa1YcbhglpJ6v7zyliiAbRXDZaUIWwUJCSq4oek/+2FEJ1aIe53jMYTS8jXWVhtVRhz51faVlVyXEaf48MELATr1KulYfyuEi4bIxBvEH0GQsZrdBxINpT3jV5nUF2QcRuh9LwPLyXzJw0kmBm/F7YCKvSHzNP6jX1kvxj3wIo177grAAlsunLAzsMhrZLwDHJn4FA+nnbDkG9WHRJQcQKPCxGRV2xOmlhLDr22ggzOoe04U3sGxjRYQbIUGUUSEPRVO45uFli4ppFN1ViGBsQpnG0w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3NFTGZZTGFUWWVJaTk0YkpmSWFZU3owdE5XellFazZhb2NmM2Q4Q2piY1Zh?=
 =?utf-8?B?SFRxNXZYNkhCdGVlZ2JLWnVtZWhucVJ5bW1xNjNXVWt5M2ZqN3VBNjVRb052?=
 =?utf-8?B?enkxeGxqUFJRRElYTFFHd2Q4WmsyOUo5YWdaT2hsZ0lyR1dFTVk3R2ZKanVX?=
 =?utf-8?B?N2JaV2Z3YnlONDF3OW92RU1CSEVhRmZMS2M0ZG1CU3doLy9SMkFoSHpFa3NU?=
 =?utf-8?B?N2tkMGNlbUVYTWdDem5pQUFJS252c2JUeFZRa2Z1QjdTUDJhYTZ5MFVqOGJz?=
 =?utf-8?B?YncwT0h5c0Uwc1Q1elF3SWg2bjhLaTl2QTdvWXYrbGpVOUExUUYvYldOVVFM?=
 =?utf-8?B?WTJFYXhxQWNjQlpKcFo2cU1pYU9Yc2MwekVEMGNrRkQ2V2dZVFlLUVFzZ3FH?=
 =?utf-8?B?ampUc05CN25nOUlMZDkwM2M5d2tSaDU0Z0lkZlgyOUxDbHN4dVE0ZW9IcXRW?=
 =?utf-8?B?VUw2N2JDaHBDQ1hrb0xXRnpKcitmMzh5Z0tLMHBvajZEaGdTTFZiWUZkdXM0?=
 =?utf-8?B?aitIWGNjbnhIVm12TW5VYWhRbkVITCttN3o3bnRET1RMZDBOUkZFTkExOHBP?=
 =?utf-8?B?OGg5NXdtQWdPdjRqZUJPc1kxYmtZNFAyTzg3NExiMWgrdGpjaUx2SkNlNmt4?=
 =?utf-8?B?dC9nd0QrZ2RMMWI3SkhaTmowWW5vY2lzMWRrK2JkbmhCTzVIUzZzVXhraHdm?=
 =?utf-8?B?NGZKclBiMGh4QkdPeHFqVk8wbmJrb1BPb2d5bUQ2aWpwd1Y3cjdaZmd6cjRs?=
 =?utf-8?B?KzBMamM2L0hnNmFYaHdiSytFUDBSd2FIdzM0OHZZbS9iTlA2REtvQ2JTd2lz?=
 =?utf-8?B?V1VCWWN3dDNCOU5BN1ptMThLT01zVjB0WjI1b2g4S21Hb0xvajVrd1g1UFgz?=
 =?utf-8?B?K1pPWnhQcUF6V1dueWtPRlpuUEtuaTFmWmpSa3gxNGlOa3Y5ODNwSWU1Ry9s?=
 =?utf-8?B?S0psMHI4dldjVGd2UFpLcTRHbVFMSHhuNm5VeTVGQnMrS0tnYW9HY2kzZkRS?=
 =?utf-8?B?L2k3bWtiZFpHRGdmcEZjK2MwZm5rNTI4bEpUNkhZZ1BTMGVjUEIxdm95Q1FR?=
 =?utf-8?B?ajBNdUNLdFFaWUNyOHN3aVgxTWNOdHZzMngvS2lObkZKNUgrWDUzZTF0aHFX?=
 =?utf-8?B?NlNicDROOWpNMWM4MXNMWnVkcllQdGdVdXhGYS9yM3B6ZVlKcjY4MGFINFpT?=
 =?utf-8?B?T1YyU3lQdTgyT1BuazNtMXpVamRuWmlOWU1mQ2Z4dUg5OXhLQ1ljZmpEemUy?=
 =?utf-8?B?cTdncElEdlhMRkdwbnVmRmxQQkFsUTNIbkdyVm9SZ1BzbndZeGNkUVdkWlBp?=
 =?utf-8?B?eW01NEwwTHdiYkMva0VGSGxQWVFiQlh6OGZHUkhPM3dUd2xTWDlJWThuRDlM?=
 =?utf-8?B?cjR1b3I3T29Hc2pQQjBkdWhkU1c0WGphaFdiSjFTdnZERDc2YndZRUNmOHdE?=
 =?utf-8?B?dTRUdmtBWE16M0h6WnMybjd5bXhPVkxuY2h1U3BFZVFrQThjZ1lhbVBrQ1Z5?=
 =?utf-8?B?OTAzdUR5bDF1YXlSNlV3ZFpYMlNlcTZQRHQ3WEdBeWI4SjRiTUcxakV3SWRi?=
 =?utf-8?B?MjhaR0ZKa2FSSEtTTGxJMUloQjkrQ3Q3UE4xU1FJcVJBYWV3WlRSU3FpV09v?=
 =?utf-8?B?RmJRRXNZajZySnNma3BITGxCSzhhUW5FY3VtK3c2Qkswakh1RVAwRVZ1eHlV?=
 =?utf-8?B?QWNpZWR3VGxoejlqN2NYUGdwS1lOQWdOTmZYcnRXRXIrNTVMcTIydWJocVV3?=
 =?utf-8?B?cnZsSkRlYldtY3VNNGw4dkZHTFdwQlh3RHhiaGd0WGo2NWxSNm4yNG5PZ002?=
 =?utf-8?B?WkE5SHZQWFA3YXprc0pwN1JJd20xVVh6c3ljWVBxTHRHbkR4OEhKME5ETzh3?=
 =?utf-8?B?YVJ4aXVDbWNLNEpCUmxIcUdxVmJMaFhudFI1L0RGbFJpQm1NSUV1NDdYQ2pD?=
 =?utf-8?B?K2hzNm80ODB1aVZrd1htSjhGSnBhNy9jMEsyTzdsN2Y1bjVualRKa1ZDQTBK?=
 =?utf-8?B?YkM2cTRCejZ0SldrV3k3UHJXOWtRUE1XVCtiNjdhd3l5NXp4WTd6ZGVyUXc2?=
 =?utf-8?B?RE1uUmZ1aEk0S3l4YXRsQ3M0azFWK0lZaFVDQ0pLR1I2ZmtjdlRzdTRpcjQ2?=
 =?utf-8?B?MlFwSzgvRVpFWkVRTHZTbGVKN0ZiQ0xPdnhocnNxTUFpekplZmU1WndMZGVt?=
 =?utf-8?B?aEVDdE1EdEEwUUh3VnQyVENUOG11UE5Zb1FSSTNZd0xzdlJyb2xxd0R4Q2Jn?=
 =?utf-8?B?MU1yWkVQUnBhaGovNTh3eC83U1ZtbCtSNnp2bXh4TWs1djlzOUR6MC9EWURG?=
 =?utf-8?B?dDBvNGtEZXFKVTREbkprWmFJaFZHYW1YejdTTngrTnZ1Q3NqNzBoQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6518e9f-ad3a-4e6d-c097-08de94900fee
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 10:25:59.9000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b87CsDexqRsgme2vrfBbawIx7Oe8+NjiOITozKvs9m0TpVnMdEnwuNZIrC2yK+T2pyx5xuaKWh7ZYUUZpMguLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6541


On 4/3/26 22:00, Dan Williams wrote:
> To date, platform firmware maps accelerator memory and accelerator drivers
> simply want an address range that they can map themselves. This typically
> results in a single region being auto-assembled upon registration of a
> memory device.  Use the @attach mechanism of devm_cxl_add_memdev()
> parameter to retrieve that region while also adhering to CXL subsystem
> locking and lifetime rules.


I doubt this approach is safer than the type2 v25 case. Apparently you 
are reducing the potential concurrency issue if someone removes 
cxl_acpi, but I think it is as strong as the v25 approach. With the 
rwsem lock, the region will exist or it will not. If the removal happens 
after the driver gets the region, the ioremap can race, with your 
approach and with the v25 one.


Also, you are keen to use your attach function for doing the same thing 
I have, which needs to be justified. I can not see a reason for that 
attach functionality with the sfc case. You did not reply to that comment:


https://lore.kernel.org/linux-cxl/20260330143827.1278677-1-alejandro.lucero-palau@amd.com/T/#m21968fd0ddf02df3641194d1450cb2bd392def26


And although I have not tested it, I think this is buggy. Removal of 
cxl_acpi will trigger unregister_region and a subsequent driver exit 
will invoke, inside the autoremove call linked to the endpoint device, 
devm_release_action on something not existing anymore. It is the same 
problem with v25 type2 and potential cxl_acpi removal. Maybe we should 
avoid linking a type2-related region to the cxl root port ...


And IMO, hiding what we are doing to the user/driver is not convenient. 
Although current type2 is going to rely on a committed decoder, that 
will not be the case if we look beyond impending needs. A function with 
a name describing this situation can add clarity to the different 
possibilities to support as a follow up of this initial work. About 
naming, attaching a region to a memdev is confusing ... as it is already 
"attached" or linked, and the reason you give for having that explicit 
attachment not being clear from a safety point of view.


> As part of adhering to current object lifetime
> rules, if the region or the CXL port topology is invalidated, the CXL core
> arranges for the accelertor driver to be detached as well.
>
> The locking and lifetime rules were validated by this local change to
> cxl_mock_mem. This tests all the lock acquisition and cleanup at
> modprobe -r cxl_test time. More work needed to also test the full positive
> case.
>
>      struct cxl_attach_region
>              attach = { .attach = {
>                                 .probe = cxl_memdev_attach_region,
>                         } };
>      cxlmd = devm_cxl_add_memdev(cxlds, &attach.attach);
>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   include/cxl/cxl.h         |  16 +++++
>   drivers/cxl/core/region.c | 125 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 141 insertions(+)
>
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 10a9b8fa2f6b..1698d15ec1ca 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -153,6 +153,22 @@ struct cxl_memdev_attach {
>   	int (*probe)(struct cxl_memdev *cxlmd);
>   };
>   
> +/**
> + * struct cxl_attach_region - coordinate mapping a region at memdev registration
> + * @attach: common core attachment descriptor
> + * @region: physical address range of the region
> + *
> + * For the common simple case of a CXL device with private (non-general purpose
> + * / "accelerator") memory, enumerate firmware instantiated region, or
> + * instantiate a region for the device's capacity. Destroy the region on detach.
> + */
> +struct cxl_attach_region {
> +	struct cxl_memdev_attach attach;
> +	struct range region;
> +};
> +
> +int cxl_memdev_attach_region(struct cxl_memdev *cxlmd);
> +
>   /**
>    * struct cxl_dev_state - The driver device state
>    *
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 11bc0b88b05f..090f52392b20 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1123,6 +1123,19 @@ static int cxl_rr_assign_decoder(struct cxl_port *port, struct cxl_region *cxlr,
>   static void cxl_region_setup_flags(struct cxl_region *cxlr,
>   				   struct cxl_decoder *cxld)
>   {
> +	if (is_endpoint_decoder(&cxld->dev)) {
> +		struct cxl_endpoint_decoder *cxled = to_cxl_endpoint_decoder(&cxld->dev);
> +		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +
> +		/*
> +		 * When a region's memdevs specify an @attach method the attach
> +		 * provider is responsible for dispositioning the region for
> +		 * both probe and userspace management
> +		 */
> +		if (cxlmd->attach)
> +			set_bit(CXL_REGION_F_LOCK, &cxlr->flags);
> +	}
> +
>   	if (cxld->flags & CXL_DECODER_F_LOCK) {
>   		set_bit(CXL_REGION_F_LOCK, &cxlr->flags);
>   		clear_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
> @@ -4226,6 +4239,115 @@ static int cxl_region_can_probe(struct cxl_region *cxlr)
>   	return 0;
>   }
>   
> +static int first_mapped_decoder(struct device *dev, const void *data)
> +{
> +	struct cxl_endpoint_decoder *cxled;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	if (cxled->cxld.region)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +/*
> + * As this is running in endpoint port remove context it does not race cxl_root
> + * destruction since port topologies are always removed depth first.
> + */
> +static void cxl_endpoint_region_autoremove(void *_cxlr)
> +{
> +	struct cxl_region *cxlr = _cxlr;
> +	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
> +	struct cxl_port *port = cxlrd_to_port(cxlrd);
> +
> +	devm_release_action(port->uport_dev, unregister_region, cxlr);
> +}
> +
> +/*
> + * Runs in cxl_mem_probe context after successful endpoint probe, assumes the
> + * simple case of single mapped decoder per memdev.
> + */
> +int cxl_memdev_attach_region(struct cxl_memdev *cxlmd)
> +{
> +	struct cxl_attach_region *attach =
> +		container_of(cxlmd->attach, typeof(*attach), attach);
> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_region *cxlr;
> +	int rc;
> +
> +	/* hold endpoint lock to setup autoremove of the region */
> +	guard(device)(&endpoint->dev);
> +	if (!endpoint->dev.driver)
> +		return -ENXIO;
> +	guard(rwsem_read)(&cxl_rwsem.region);
> +	guard(rwsem_read)(&cxl_rwsem.dpa);
> +
> +	/*
> +	 * TODO auto-instantiate a region, for now assume this will find an
> +	 * auto-region
> +	 */
> +	struct device *dev __free(put_device) =
> +		device_find_child(&endpoint->dev, NULL, first_mapped_decoder);
> +
> +	if (!dev) {
> +		dev_dbg(cxlmd->cxlds->dev, "no region found for memdev %s\n",
> +			dev_name(&cxlmd->dev));
> +		return -ENXIO;
> +	}
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	cxlr = cxled->cxld.region;
> +
> +	if (cxlr->params.state < CXL_CONFIG_COMMIT) {
> +		dev_dbg(cxlmd->cxlds->dev,
> +			"region %s not committed for memdev %s\n",
> +			dev_name(&cxlr->dev), dev_name(&cxlmd->dev));
> +		return -ENXIO;
> +	}
> +
> +	if (cxlr->params.nr_targets > 1) {
> +		dev_dbg(cxlmd->cxlds->dev,
> +			"Only attach to local non-interleaved region\n");
> +		return -ENXIO;
> +	}
> +
> +	/* Only teardown regions that pass validation, ignore the rest */
> +	rc = devm_add_action_or_reset(&endpoint->dev,
> +				      cxl_endpoint_region_autoremove, cxlr);
> +	if (rc)
> +		return rc;
> +
> +	attach->region = (struct range) {
> +		.start = cxlr->params.res->start,
> +		.end = cxlr->params.res->end,
> +	};
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_memdev_attach_region, "CXL");
> +
> +/*
> + * The presence of an attach method indicates that the region is designated for
> + * a purpose outside of CXL core memory expansion defaults.
> + */
> +static bool cxl_region_has_memdev_attach(struct cxl_region *cxlr)
> +{
> +	struct cxl_region_params *p = &cxlr->params;
> +
> +	for (int i = 0; i < p->nr_targets; i++) {
> +		struct cxl_endpoint_decoder *cxled = p->targets[i];
> +		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +
> +		if (cxlmd->attach)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>   static int cxl_region_probe(struct device *dev)
>   {
>   	struct cxl_region *cxlr = to_cxl_region(dev);
> @@ -4257,6 +4379,9 @@ static int cxl_region_probe(struct device *dev)
>   	if (rc)
>   		return rc;
>   
> +	if (cxl_region_has_memdev_attach(cxlr))
> +		return 0;
> +
>   	switch (cxlr->mode) {
>   	case CXL_PARTMODE_PMEM:
>   		rc = devm_cxl_region_edac_register(cxlr);
