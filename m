Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012008.outbound.protection.outlook.com [40.93.195.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E7063E1D13
	for <linux-cxl@vger.kernel.org>; Thu, 21 May 2026 14:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374683; cv=fail; b=VSc/BPbwcP3NfBYeUvEumQCnfj7eKDuhd3tp7guRTwBNkn8FsJXoP/O/pRcXtbtPVpdd6TDeNtKU7fiXliHjN72KTf+CjG79uwuSRWnq0xUWRSTi0RbCVtVkm/P+SytEOTyrSfH6iwY2gVhxf4Ft2IuJzW/ZrJrqhNuaFUJFq3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374683; c=relaxed/simple;
	bh=9nJjUm0JIbj+QND3T3G3KiPJPMr2ZAAUTXG33YpACR8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pVyrcRVkRkvLwYwjNuwFvoGKIiyvFqluNtbx7oDHo31/Ih/exr3zk8bQNh40g/yX/j/WcnU/i2vusYcXd3yvMMStQaVkJTo+vA5PbRYtIqCIkz9mN3iNYl/zzBwsBvizwPkxAQThv+BgDdd7zAuH4I5PHEnQEr7eL7gmULqZH/Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uUsYY46d; arc=fail smtp.client-ip=40.93.195.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uUsYY46d"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mBVwQuJ+455oIx7K6VBY8PsN6J0QExobr01L6+Nk2tVosn6pOrS3WfmCiIpgwDQRnhUnsxwQSTY+OZFqCjIxdbujUOxpUIglXRlkXqv04XusRb7Y7994Rah/SgG9E3gWlRqIGusfTqRqel3TpC+YuCzPZhLzxjG5diArGSI3AAoBOt4X18eUd6GbG5OVB2F9Z4r6A4GIhG1w6AdVU6PBrXAUl9/AWje1Vum608xG/pW5aF71qL3k/foDLS5mbqO7Om7ZzS6IgIWzp+vNhdE6V+ldqgTvP9KuqGsua6Am2nTYhhONnhAvKhoSttVm9clz+J40gnQr/cI9thd8Zl8b4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dyL5DVde+cmzN6EFa6CmxLenpxdB7zfg2dkNANoZmRw=;
 b=eAFpewAmtUOxAC6eTuRIQQGB+XXLJHfIyS2SL+VhQsdi8JMhBObeneucQje//OZ+ZpfkKH064IMXjvyKD+s7LjRpzk8NjS4C0/rqG/heabCQsG+8oKn1RrbuHlFDFrKG5vn5rvLnQFLwAonKG/KxwIEjxZFVssQ5sUTGP8XfFScFo6Wx1Blqh2DyC04x3PVePBCbWuexBrZLcfj7lfkPBKGM2zgAZPtn8raexuKCH4iqAKhtme1LC+BV2zH/mu9Nf12Rihw7/nbrKsvspJakPFWF9FXFzwsxyahNdCk0OW8dgIasjrm7CP32aCsV59QyUl6JSFgbh/4lj1TuhIw9Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dyL5DVde+cmzN6EFa6CmxLenpxdB7zfg2dkNANoZmRw=;
 b=uUsYY46d1d12APM6M5cklhscVq8KAnnM5jmo6srEW1Pnvk4iRtWkXyauETBFWuMWS0EkRAJYVphDcjWZAB9ru9KbDNWr6GjN1nMJdLbFC0BwXFGdvM7xWqZ84ZTPoHBUquyWpQDhhX51vENICuamdFGV3kkAT02iDBCz5/LwZ58=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CY8PR12MB7585.namprd12.prod.outlook.com (2603:10b6:930:98::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Thu, 21 May
 2026 14:44:37 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%6]) with mapi id 15.21.0025.023; Thu, 21 May 2026
 14:44:37 +0000
Message-ID: <7448d99f-ff3a-4fa5-91bf-e0b168b1d7e7@amd.com>
Date: Thu, 21 May 2026 15:44:34 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] cxl/region: Introduce devm_cxl_probe_mem()
Content-Language: en-US
To: Dan Williams <djbw@kernel.org>, linux-cxl@vger.kernel.org
Cc: dave.jiang@intel.com, alejandro.lucero-palau@amd.com, jic23@kernel.org
References: <20260519210158.1499795-1-djbw@kernel.org>
 <20260519210158.1499795-6-djbw@kernel.org>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20260519210158.1499795-6-djbw@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0165.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18a::8) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CY8PR12MB7585:EE_
X-MS-Office365-Filtering-Correlation-Id: 5773d1ca-e001-42ff-9af4-08deb7477b93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|6133799003|18002099003|22082099003|56012099003|3023799007|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	Cz7CYqVU+iRgg0eF0BplnNm8v9hWJqptVvHCudcaiy4QoxqvyGtmq/b/m5g/NqFmgE0z1YdPZDM3Apu61BNzjFOexorL8M0O+muZw30LxB2wPZY9HYBVeCMBLv6fANDOO0MeEbjoKDanOrpLER5s3elBgFzLGO21Lc2RimhTZRUSOh38qwhgVgE4epI1/NinAsSiK9IKiq3OWtySvUKaMtZzorRQ+RoEMIXLyLzoTBbUolm0zXARCq7lla+ovBAMIkuiUx0cr2uBaLf9bGGBbyCk/VLK3vijAYAKRnXRxzvaAu8P5+O1ef9fRaUUzhFigr6ukDlRj27o3MOyQE722Hr2FVUYp/YpTrYKGxoVZhoB4C1lcbdtKWZlL6SC1U74lSywtgu6/QK9CPgREGX0jot9B7wQs7j+aX9QlVTZ1HazxXrsogJg383UYkNMk8aRLogVbgQ+0t6pNObezxQTypTAGZqn88zt70Kcvugo/aXUYsM3vMY3LQg2N1MXU5mdAra0LSC1xESIfSfIAA3IaGi0c+HJ7KCsaLMUDsjxNfI1yZE18mVL3HGkp3FPlZqR7E1PBrjbtC9nRJRSLbz+eV7upTeDBZQL8pTazawIxrFwsMyt38HKdFuMIBULEeLP52zjjHElhqhe412Q5PJUhqLnIk7t81j2QZ4ON5wIr0Rq8nbaJ4fYaTlULxc2tpYc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(6133799003)(18002099003)(22082099003)(56012099003)(3023799007)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Rnhza0o5OTdsVDREbmFYZXpHY2lXcGNPalFYZVFGV3laV3lWZ3ltajh3ZC81?=
 =?utf-8?B?N0tBVjJsaDd4ejFVSisvRGhKWkRycnIyU1BpZWtRZFg1cmVTNDlNbDMzSWZB?=
 =?utf-8?B?Y0QwcEdiNXVmOW9MSjBNQ05qbmF4WkdYVGdhaWhxbTQvYi9tZzN2c0tScytC?=
 =?utf-8?B?dWtVSTk2bjJSN1V1eHNTR3cxSUtxSXduRjBrZkFYcXNjSHJkUnlZaFVnMC9x?=
 =?utf-8?B?QXNqYTFoRm9zbS94dXpZQ21RWVI0N0hMcktMbkJVNnBKanlRSkhvaHZHdHFt?=
 =?utf-8?B?aVh2LzI3UXlsemcyK1FnWHZqbmdnYkNsSFpQR0dqd25sN0QyVFM1enNYRnFj?=
 =?utf-8?B?RFZ5ejUzc3NjNXFaK2JiUUM0cm5nelhwcEp5SURsbjRTWTNGSjB4ejlDUjk2?=
 =?utf-8?B?ckZ2SE93dFZ4YmlLTXUvbzJpeHRpUFdKWGZTRHk1NHJ3MEw3ODYrT01JRmtt?=
 =?utf-8?B?RVNQUVoreG9OVWlyankwTXZuVnFwVE0xbGR0MFA5L3R3QzhjWjUxamhNQVM1?=
 =?utf-8?B?MUJoZ2dtd3NGaHpjRjVLTC9FWGRLSVFOZnUyS3FmTkNtVGxKR2V1ME5VY1Bs?=
 =?utf-8?B?NVR1bXF6Q1hSRVJQRXVsdFpCYXpiWk96NTY2Y01KOWMyOXVVaWZpMUgxV2Nz?=
 =?utf-8?B?NDJxZDFOREhNVVJuajdwTzdhNHhVdks1dXdqcEJVZ016WW1NY2Y4ZndQL3BG?=
 =?utf-8?B?dG1BOGFUTVczUldxK0hQbGwyd1BQS0ZuSVhvYXRhL0tMOExOdEl0aTF2OVpL?=
 =?utf-8?B?UjVteXg0VTZPVEo3RmR5ZVlBQnQvQk9CSzhxVXh6YUg4bS83c0xLMU9EVFlo?=
 =?utf-8?B?RWZWdFoxc2hoTVQwZFpUa29lMytFYmk4UmVPSDI4ZVdXMVNJR1VtdmhoVlJv?=
 =?utf-8?B?T1J5d3JKN2dianA0Y2pMU1lUdG4wUDAyUVBXNzN4d3FUYmxPWkxiOHhrK2pr?=
 =?utf-8?B?c2k0Njd1VXhDTGhLSW4wZ2lFQzUvd2FkUXZlOW5nOTRQejVGQnMwbldQcmJv?=
 =?utf-8?B?eGJjNVY5MkhieUhyaW9aczZiRFF4T2xFL25ZUEIwZFdEd0JJMkJkdWp5b1ly?=
 =?utf-8?B?UldkVjlhOW51WW0zOGg5ZHMrZi9QMkVpMFRuT3FsT3lRT0RqVkxjNjE2Z2I5?=
 =?utf-8?B?WFlZZFpBTmlrRlJTTHVpbklnT0owQ0VDWFlEd1lWQW5qbUxHVWF5elBNalE5?=
 =?utf-8?B?Z256dUcrN1gvS1pnc0xaTFhrY09LckM1MDB0eHJSY3IxREl0NU5EaVF1YzJy?=
 =?utf-8?B?QXlVREExMU5wT3dMeXMwaG4vS3NXeDNUQ3NQSzNGdDM4MklXN1IyRVhycGRR?=
 =?utf-8?B?QjVzTmJIR2sxMjVxL1Y4N3J4RjNjODQzQndkVVBWclhKWWRGSHQrUWkrKzNO?=
 =?utf-8?B?dlRUSm54Z005dzBSUnFSTEpYcEtyOHBRdDBkaElKWXpLYmo2MUVMaVI3dU11?=
 =?utf-8?B?cnIveW1XQlgrUWZuNVpwRTdpVjlaOWkvbDMyQXFjMDViRVlOdmlQWUJkcXdS?=
 =?utf-8?B?bHp3LzVwNDlWQXE2WkRIL3BSV0ZFTVJYU1FkVlJHMGVnNmhZTHU2TUI3UU55?=
 =?utf-8?B?MWFybWZIb0xneHNLTDZEYmM0ZytNcHA5RitIOXVZK3ZkNkl2OHlCSzJ6a3dy?=
 =?utf-8?B?M3VQdFlPbHVDUHo5eUVUYWZkNEZET3VxSFI1YkRva3RkenFNbHBPOUE3Rnl1?=
 =?utf-8?B?UlBIMnQ0dnBVNE5oc08rQU9hREtPQ1ZsdDg4TThNYjVKWFo5aklCNHF1Wjlj?=
 =?utf-8?B?ZG9aekxyN2psOGFUUnk3L0d2N0lKTFJ1MDloT2l1VFQ0TTEwODJYZnpsVXNY?=
 =?utf-8?B?R013NGl2R1ppYnV0Mnd5dHE3NGZjc2JIOXc3V3U3WEJHaWJLNW9uNHVXRmVa?=
 =?utf-8?B?L0lpc2dSaWJocnh3VGpIWXJLRFZseGlGVnkvdnFtWFRhMlFndDM3dHY2L1po?=
 =?utf-8?B?Q3hJN2lrQ0FoOEpXOXVFRWdxUWdHTGk5RWFqaTFTKytFb21aODc0K2tWckhj?=
 =?utf-8?B?MGxTQ3pPbE8yL3V0SEhTR0RpY3pvSTFqUVRUM0hqV2FRcDhOd3U1ZEdsaHRH?=
 =?utf-8?B?QmJsbEM1RUs1Uy9tVFQyckRMVDE4dm0wNkRIREJRNUFEYW5BY3FvbEZHbURs?=
 =?utf-8?B?a0lIN2hhZnU5QlUzb3lDWHVJQ21rZ1IwdFA2UUxkbzJIK1ZyeWlrMjJFdlg4?=
 =?utf-8?B?NHpjYlRId1lqU2MrckhVcjZwelhCMmRoSE05UWxsL1RjNEo2MW50UXlLUVBa?=
 =?utf-8?B?NlBza3lrYzRCWUlFN2pjUm5zemc5cUk0QzI4Y08xb1RHcEsxTnBHSS92VVdr?=
 =?utf-8?B?eGp6Q2NWRVMzYXBScCtvcWx2Sys5TmNpTHdlb1NiTkNhUnZiampLUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5773d1ca-e001-42ff-9af4-08deb7477b93
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 14:44:37.8114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SCxe6RvhyaCmIR3gW0Bd7rhgAeqZjjF9ImE/ygHNUFb0Tp7a8f69NYq7JO/mgJJ4wtSE1baYabgaqZ2V6BBq+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7585


On 5/19/26 22:01, Dan Williams wrote:
> To date, platform firmware maps accelerator memory and accelerator drivers
> simply want an address range that they can map themselves. This typically
> results in a single region being auto-assembled upon registration of a
> memory device.  Use the @attach mechanism of devm_cxl_add_memdev()
> parameter to retrieve that region while also adhering to CXL subsystem
> locking and lifetime rules. As part of adhering to current object lifetime
> rules, if the region or the CXL port topology is invalidated, the CXL core
> arranges for the accelertor driver to be detached as well.
>
> The locking and lifetime rules were validated with Dave's work-in-progress
> cxl-type-2 support for cxl_test.
>
> devm_cxl_add_classdev() supports the general memory expansion flow where
> region assembly is optional, dynamic, and user controlled.
>
> Cc: Alejandro Lucero <alucerop@amd.com>
> Signed-off-by: Dan Williams <djbw@kernel.org>


I think this is all good enough as long as we only support:


     1) the accelerator driver removal if cxl_acpi or memdev unbound

     2) autodiscovered regions


what is what we need now as a priority. So I'm happy with it. Let's deal 
with the complexity for other cases at its due time.


My other concern with the driver removal was a potential race with 
driver probing ... which I do not think it can happen as the device will 
be locked during probing. So apart from a minor suggestion below:


Reviewed-by: Alejandro Lucero <alucerop@amd.com>

Tested-by: Alejandro Lucero <alucerop@amd.com>


> ---
>   drivers/cxl/cxlmem.h         |  27 ++++++--
>   include/cxl/cxl.h            |   3 +
>   drivers/cxl/core/region.c    | 124 +++++++++++++++++++++++++++++++++++
>   drivers/cxl/mem.c            |  50 +++++++++++---
>   drivers/cxl/pci.c            |   2 +-
>   tools/testing/cxl/test/mem.c |   2 +-
>   6 files changed, 191 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 776c50d1db51..d3bdd00f94b3 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -34,10 +34,6 @@
>   	(FIELD_GET(CXLMDEV_RESET_NEEDED_MASK, status) !=                       \
>   	 CXLMDEV_RESET_NEEDED_NOT)
>   
> -struct cxl_memdev_attach {
> -	int (*probe)(struct cxl_memdev *cxlmd);
> -};
> -
>   /**
>    * struct cxl_memdev - CXL bus object representing a Type-3 Memory Device
>    * @dev: driver core device object
> @@ -101,10 +97,29 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
>   	return is_cxl_memdev(port->uport_dev);
>   }
>   
> +struct cxl_memdev_attach {
> +	int (*probe)(struct cxl_memdev *cxlmd);
> +};
> +
> +/**
> + * struct cxl_attach_region - coordinate mapping a region at memdev registration
> + * @attach: common core attachment descriptor
> + * @hpa_range: physical address range of the region
> + *
> + * For the common simple case of a CXL device with private (non-general purpose
> + * / "accelerator") memory, enumerate firmware instantiated region, or
> + * instantiate a region for the device's capacity. Destroy the region on detach.
> + */
> +struct cxl_attach_region {
> +	struct cxl_memdev_attach attach;
> +	struct range hpa_range;
> +};
> +
> +int cxl_memdev_attach_region(struct cxl_memdev *cxlmd);
> +
> +struct cxl_memdev *devm_cxl_add_classdev(struct cxl_dev_state *cxlds);
>   struct cxl_memdev *__devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
>   					 const struct cxl_memdev_attach *attach);
> -struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
> -				       const struct cxl_memdev_attach *attach);
>   int devm_cxl_sanitize_setup_notifier(struct device *host,
>   				     struct cxl_memdev *cxlmd);
>   struct cxl_memdev_state;
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index fa7269154620..016c74fb747c 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -223,4 +223,7 @@ struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
>   		(drv_struct *)_devm_cxl_dev_state_create(parent, type, serial, dvsec,	\
>   						      sizeof(drv_struct), mbox);	\
>   	})
> +
> +struct cxl_memdev *devm_cxl_probe_mem(struct cxl_dev_state *cxlds,
> +				      struct range *range);
>   #endif /* __CXL_CXL_H__ */
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index faf9785c0509..ce99f0650764 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1148,6 +1148,19 @@ static int cxl_rr_assign_decoder(struct cxl_port *port, struct cxl_region *cxlr,
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
> @@ -2560,6 +2573,17 @@ static void unregister_region(struct cxl_region *cxlr)
>   	put_device(&cxlr->dev);
>   }
>   
> +static void endpoint_unregister_region(void *_cxlr)
> +{
> +	struct cxl_region *cxlr = _cxlr;
> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> +
> +	guard(mutex)(&cxlrd->regions_lock);
> +	if (xa_load(&cxlrd->regions, cxlr->id))
> +		unregister_region(cxlr);
> +	put_device(&cxlr->dev);
> +}
> +
>   static struct lock_class_key cxl_region_key;
>   
>   static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int id)
> @@ -4057,6 +4081,103 @@ static int cxl_region_can_probe(struct cxl_region *cxlr)
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
> +	get_device(&cxlr->dev);
> +	rc = devm_add_action_or_reset(&endpoint->dev,
> +				      endpoint_unregister_region, cxlr);
> +	if (rc)
> +		return rc;
> +
> +	attach->hpa_range = (struct range) {
> +		.start = cxlr->params.res->start,
> +		.end = cxlr->params.res->end,
> +	};
> +	return 0;
> +}
> +EXPORT_SYMBOL_FOR_MODULES(cxl_memdev_attach_region, "cxl_mem");
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
> @@ -4088,6 +4209,9 @@ static int cxl_region_probe(struct device *dev)
>   	if (rc)
>   		return rc;
>   
> +	if (cxl_region_has_memdev_attach(cxlr))
> +		return 0;
> +
>   	switch (cxlr->mode) {
>   	case CXL_PARTMODE_PMEM:
>   		rc = devm_cxl_region_edac_register(cxlr);
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index ff858318091f..67d31482f06b 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -183,27 +183,59 @@ static int cxl_mem_probe(struct device *dev)
>   }
>   
>   /**
> - * devm_cxl_add_memdev - Add a CXL memory device
> + * devm_cxl_add_classdev - Add a CXL memory class-code device
>    * @cxlds: CXL device state to associate with the memdev
> - * @attach: Caller depends on CXL topology attachment
>    *
>    * Upon return the device will have had a chance to attach to the
>    * cxl_mem driver, but may fail to attach if the CXL topology is not ready
>    * (hardware CXL link down, or software platform CXL root not attached).
>    *
> - * When @attach is NULL it indicates the caller wants the memdev to remain
> - * registered even if it does not immediately attach to the CXL hierarchy. When
> - * @attach is provided a cxl_mem_probe() failure leads to failure of this routine.
> + * The parent of the resulting device and the devm context for allocations is
> + * @cxlds->dev.
> + */
> +struct cxl_memdev *devm_cxl_add_classdev(struct cxl_dev_state *cxlds)
> +{
> +	return __devm_cxl_add_memdev(cxlds, NULL);
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_add_classdev, "CXL");
> +
> +/**
> + * devm_cxl_probe_mem - Add a CXL memory device and probe its region
> + * @cxlds: CXL device state to associate with the memdev
> + * @hpa_range: CXL.mem physical address range result
> + *
> + * Upon return the device will have had a chance to attach to the
> + * cxl_mem driver, but may fail to attach if the CXL topology is not ready
> + * (hardware CXL link down, or software platform CXL root not attached).
> + *
> + * Failure to probe the memdev and/or setup a region for the memdev
> + * results in this function failing.
>    *
>    * The parent of the resulting device and the devm context for allocations is
>    * @cxlds->dev.
>    */
> -struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds,
> -				       const struct cxl_memdev_attach *attach)
> +struct cxl_memdev *devm_cxl_probe_mem(struct cxl_dev_state *cxlds,
> +				      struct range *hpa_range)


The accelerator driver does not need the cxl_memdev reference, just the 
range to work with.

I would suggest to change the interface to


struct range *devm_cxl_mem_probe(struct cxl_dev_state *cxlds)


then return pointer to attach->hpa_range;

>   {
> -	return __devm_cxl_add_memdev(cxlds, attach);
> +	struct cxl_attach_region *attach =
> +		devm_kmalloc(cxlds->dev, sizeof(*attach), GFP_KERNEL);
> +	struct cxl_memdev *cxlmd;
> +
> +	if (!attach)
> +		return ERR_PTR(-ENOMEM);
> +
> +	*attach = (struct cxl_attach_region) {
> +		.attach = {
> +			   .probe = cxl_memdev_attach_region,
> +		},
> +		.hpa_range = { 0, -1 },
> +	};
> +
> +	cxlmd = __devm_cxl_add_memdev(cxlds, &attach->attach);
> +	*hpa_range = attach->hpa_range;
> +	return cxlmd;
>   }
> -EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, "CXL");
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_probe_mem, "CXL");
>   
>   static ssize_t trigger_poison_list_store(struct device *dev,
>   					 struct device_attribute *attr,
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index bace662dc988..267c679b0b3c 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -878,7 +878,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	if (rc)
>   		dev_dbg(&pdev->dev, "No CXL Features discovered\n");
>   
> -	cxlmd = devm_cxl_add_memdev(cxlds, NULL);
> +	cxlmd = devm_cxl_add_classdev(cxlds);
>   	if (IS_ERR(cxlmd))
>   		return PTR_ERR(cxlmd);
>   
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 271c7ad8cc32..095ca544ac02 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -1769,7 +1769,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
>   
>   	cxl_mock_add_event_logs(&mdata->mes);
>   
> -	cxlmd = devm_cxl_add_memdev(cxlds, NULL);
> +	cxlmd = devm_cxl_add_classdev(cxlds);
>   	if (IS_ERR(cxlmd))
>   		return PTR_ERR(cxlmd);
>   
