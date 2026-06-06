Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013020.outbound.protection.outlook.com [40.93.201.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D4C303C97
	for <linux-cxl@vger.kernel.org>; Sat,  6 Jun 2026 06:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780728532; cv=fail; b=OPS7aLEbWWyD5fgYxip5cZOYn3gtAAajRpYd0tEH5zuHa1F7iFvQIprZOjv6Y8e9X/+XtGPTegjsh0GORj1LIsiiiiKXl71s7K6H9xjqPAt/AI+Nj7MN+n15DHIe1umRQ+snPz20maNjD16lj5sUiT7XjO2883b731I4oPfXS4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780728532; c=relaxed/simple;
	bh=Er+3jMrX+KYxBUcfRi/jIcve9y+J7xTSzbd8e40TRgk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CCBv/l8pach4a7WdPmLHElIIj+FqEE/Dda7oO9+onsG09C2mcytkBhs9sEWoHDApW1e31HC6VXmqX5ILf2MRK5eF5CEblvtsD+XCuUn15iKgxpKFis1bl8sJwk6+7TFf4/EaL3ipMoh7rJ1c1dk1pw0JPXH0HMVI2yXpy4NJI0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=in9O1Jrq; arc=fail smtp.client-ip=40.93.201.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="in9O1Jrq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w/qSiIfyMR2UEePjWUe5YvAcGMvyrCVYySYPTcKRORUxnqLTQqQX6G6/KM14C/l8ezVZmcSm2TZ75WhlWCfrrt9weWcXRJ8YeMQyw+3Op9CvdyxugJidSoDozGAkIzVnSg/0NPBVZf8z4/YYuxyHmVvRvlKG29LyZIlfr+mCdxf7owkjVfC+PL/jsWr/SK6W1TibRiKZ+nqjaZHVF9nBT9z3IDwBKtyYk2/3heS7HmThDiYzdWVWmhdZdrrmdrw6juQG/DkBmjTn1jqLD6QQJIVJftaNkMims7MqaGOetkFtPLmtG2dJ0kABtqSkw+FwcK+k+jt+Pi/OttrsWllFPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=06qYNqua3xbC25r2wnIhELCQMCoSZnZrSJzfrmaGPa8=;
 b=lOhvl8EBNrLVMTdeOpEC6xe2NXcogVFraZWvNJtHdcdaWApokXAcuECJkhMpFxXIIfjrMzmfUtH8IY5Llk1sl33giq4+6nJXYCSqV+Z+NakPy1E3gAMCMGNn3RDBnRvRg58YCAb6oEWw3FpXoM5rkSJTgUp41nV5isjs/oWIod/ERpC2VUgkhfd3/YnISuYKMeOFW0wb0Pxzzd6ar/CLTSeZtTlB9RnYauga/cXJj+Fd5nQd87+A/qNBdPQgjrcmNLv8ZXYtRZ5AdG4iDH6EZYNNgFvOL/nL9z0O8qEeEYCs8IcpNIT5JRB/kMThllIhW5y/w/mGaz6e9WMGOsQqLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=06qYNqua3xbC25r2wnIhELCQMCoSZnZrSJzfrmaGPa8=;
 b=in9O1Jrq1aYe+Yy1VEeUOODoALyVZYMqECs/utPRnwfqIbEaZKDTbmg+xFOi+/75EM1ddPPg65mmGTpefSi9T3HR9PnuN5QMhWYvAfp+QQSF7floUE1692Vr45eJd8KL+MccZucgXATlTkZvOZoyA6iKAPL6DGZFsvkPkJcc/C0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 IA1PR12MB8336.namprd12.prod.outlook.com (2603:10b6:208:3fc::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.9; Sat, 6 Jun 2026
 06:48:47 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%6]) with mapi id 15.21.0092.007; Sat, 6 Jun 2026
 06:48:47 +0000
Message-ID: <138239a6-8392-4a47-807b-ec0334d24b0b@amd.com>
Date: Sat, 6 Jun 2026 07:48:42 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] cxl: Introduce devm_cxl_probe_mem() and fix region
 deletion
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, Dan Williams <djbw@kernel.org>,
 linux-cxl@vger.kernel.org
Cc: alejandro.lucero-palau@amd.com, jic23@kernel.org,
 Sungwoo Kim <iam@sung-woo.kim>
References: <20260519210158.1499795-1-djbw@kernel.org>
 <9e85d980-4a44-4f27-aa18-8d01630a05e6@amd.com>
 <2a9791d4-e091-4452-af92-3601253bc748@amd.com>
 <5f399564-7efe-444d-a6cf-2c6176e57ad9@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <5f399564-7efe-444d-a6cf-2c6176e57ad9@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR3P189CA0063.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:102:b4::8) To DM4PR12MB6254.namprd12.prod.outlook.com
 (2603:10b6:8:a5::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|IA1PR12MB8336:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f9ec70f-1c86-41c3-3407-08dec397a868
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|56012099006|11063799006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	3JFZBrP+aUBmwVJZ6l5JBJ+v55f02RwP5tKdop2cX75zf5jKspas9tsyptkueW9hpj2kDLffiQNVBRX8c6NlhhKI64jG2hR+7UPRQ+nMQNNvcRq/ghxp9F84r1+Nt52tX2S62+gdoc7cp5Mg6inWomdI6QGMg+e/UkGa8TFJPsiNfLP4Jvhe2unN5TUg01nW+9mitsNEX6Lik5+/qm0UYZojU/fGoqpysFZ2nqakst0+Bdy+tH37+Ty0yeAx49Igf3yR1rWPuHlVZNbkqvFCptlz4NMrXLzdKS4Ui7iKYb2qjgJsykxEI8CPHEwjM2Sm590QPXDfFfSuxhO1Bfc7IWgfP/RQKvTcaN90+FKJ4eWs4bFL975SiFLIuwsZCGHQEiKKdZf3nefwckxZuNhgcUko+U1t9U6S3/FKBy0DPZ402xVGAZ705W8lEpDXxDCJccd97PERGunGWwMuLOz4ZlWVnvd55E+rFHlS8GIXA9NHdNK7Vox2w0H1jnyJ3fpXpMDwwOwLPDIoWDiaWY5YPIlvSqjGoo003kZhWmv6Z8Zti5U6X0mTNnL96QwWVPM5gLxKReStrWro7mdv5zt80N3XCURYGMHn7otM6dxlkNI55Dpp4/8G2RkJOFBNvngmQ9EpCErtPARTQR/wPDjcCAZHwNJb0ohjQX4ThqUwAppIt9Q+U/KlA+J0LcMupytx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(56012099006)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnBFTVFSaGkrU204dU0zZkI2RitEbHl3Y2VETFpvVllKbjNPL3AwT0xDSVpU?=
 =?utf-8?B?WDQyYnRVa2kvS2swa1NJVmcxeUlGOXpZWG1uQm40K0FDbTZEVndXOHFYZllr?=
 =?utf-8?B?ZVhHNFhnZ2N2SFRpOVhmWnZ5ZldXYk12R3hVQlhVQmxRNEZEWnJGNU1EakUz?=
 =?utf-8?B?TDFHYU5VVFVyeXdzY0hsY0xYZFgxV0VOTG8weEZoMHlaREM2bStRVjA0Yzh5?=
 =?utf-8?B?dndRbTNVTlRhUlFRNTJ1Y0g5VnlUZXFBd01xQWJrSncvYkpVNlZuS21RYzFp?=
 =?utf-8?B?QUNpWGhQcm9yQm5iMUpqQzY3d0tNZklLbURzcVN1UGdycU1sZnRYUTlDQXUr?=
 =?utf-8?B?bWxOaFZUVzNOWTV6NXFTNHRpQXk5SWphS3hpSEJoYTdSSWsxdE05UlZheGlM?=
 =?utf-8?B?QVBzWG9GcXd2UFNDbEtqakQxS1p3NitQb0p1OVNaVFdFWlNPL3hTekNNRlc3?=
 =?utf-8?B?VlFlYkNqQ0hNK0pRWURKWlNVcXBqUU5WNlhQQmJLMGVIQXBCcHdraFRaZG5Q?=
 =?utf-8?B?Y1FrMHVLWXAzK1dvR29MUXZmdzFwMjV3Y2w2VThPMmtXaHRWZzhsM0ZQdkF4?=
 =?utf-8?B?azFoVDVlOWsxd01EdGdndG1jL1ZpT1FmRllEbThQUVRYdkMrbi9RQ0piQU4r?=
 =?utf-8?B?M09BUTJSdDFLMHB5V1ZYZFJ2b3BvRWpFZDkrY29yRzU0Rm01aGxRUGg2RXg1?=
 =?utf-8?B?MFU4ZDhtc1VnZk9CendiWVArV0J1S2JDR25vZ0FUZWUxWjhzZ0Mxd3hnRGtW?=
 =?utf-8?B?SzdGNkxwcUVJTUJYZkN0UmM2ZDlleVhya2FYbEtRZTFQa2lmUGJ0ZUtianBM?=
 =?utf-8?B?WnZsSXdWWi9VbWVOck9CSkFIM09MaVZwdXBEdXQ4TWtYdlB3ZnVpSHBCbWRE?=
 =?utf-8?B?VlZwY1hWcHppVUZWbEs0bERGODR0L1d1bUt6Rk40ZmZTKzdQRGRmcWlENEtr?=
 =?utf-8?B?YXpGYTZvQTJsNE5NMGh3am1JQXBCYWtGbmpURGMrTy9lY1d6RnRTQzc3eStD?=
 =?utf-8?B?SUZzdERLNzBpNXU2d2w3aS8venpCeFhVUGVrWVNhNFpPN0xPSzd6TzdHZ1li?=
 =?utf-8?B?dm0yUkhqSS9UZVByRDdSWTBaVitMMHJlM1R4QnpPOXlpM2VZNmltSkdoZUdG?=
 =?utf-8?B?cjNlNVFIdFUwVW9ZOENCMk90MnBuOVl5Vnc1K1NURDlYOGpvQk1qK1RqWWF2?=
 =?utf-8?B?U0MvZ0FoVzFIYlcyeis0S014eWU5d3orOUxsUEhGVm9Oc3NSMHpyTzQya3J5?=
 =?utf-8?B?c1NoaUNQQVAzallrZWs2S0tvTEpMQ2lEVFYxT2s3Y1FnUXVkdVFhRENBTVJS?=
 =?utf-8?B?YzkyMzY5YzFHUStyTUt1QUE4TTVDVEVoeFFzbHRuOTJrNFFzV2ZWTHBNTkNx?=
 =?utf-8?B?ZjVqTVArdEJzQXcwMFBkM0c4UUFOdkpLcE8weHlmR0MyVGlsUjlSdkEwMHlp?=
 =?utf-8?B?b2I2d3ppNmQwei9ReUZaOWZFZW8wdUZ4Yk5FSWxUYzdnYmhTbUNXVXVVM3Jh?=
 =?utf-8?B?S2NRTnpjZS9xMDFtQWNmQ0dHbW42U3k4STFOZzdwelJGUUl1WjY2UXpjcXRC?=
 =?utf-8?B?QWZyTkRqYUVQOWcrdGh2eFhPWmlLTWczZ2JLNWdRemJ0bFkvZ3JUNEdybTFZ?=
 =?utf-8?B?a0FzV0pSbkd1a0hCRGhUaWkrMUNNU1FhU0FIM2lEOGU4ejhCdUxqOFZzZjZI?=
 =?utf-8?B?ODhjczNUaUVBNWhnMHpSTEJjTmxXWkpBRnB4TjJNSkR1YjZ1N0ZselJzZStp?=
 =?utf-8?B?RVI4U1hRY3NHVkNydjlFT2pNNEFubEhzcDRYVFFVWi9NdWorcVZHWVNJejAz?=
 =?utf-8?B?Rjk0UGVxSUJ2TnVnNGIrM0szeUEzVkNBdWxpczVYajVOV1FTN0N3emJlTnBN?=
 =?utf-8?B?Z0dhckVaMHBtNmFTWExQNzVtck4xem5WK0RUbG4yVE5hcCtERFhsb1ZzVE9s?=
 =?utf-8?B?R1AvNitPVnliSForYksreGtYVTZ5U2NKeEVRc3hEbEhMeXo1eDhKNi9CMmtV?=
 =?utf-8?B?Q01KdlJHNXdnUzdDa1ppd0lWd05TbVkvMGI1cGFkUXljeHBwbC8rK3hQSmlv?=
 =?utf-8?B?bGp5U0VBY0pjdXNTS0kzczI4WDA4NXE5emJEYWtEUHl4TndiR2VuNUIrZnBu?=
 =?utf-8?B?VklUZFZKUHRmaGYvdlZUZVV0VUQrVHJCdWVHWmpMc0YzS2hYbmE4NmErVkJi?=
 =?utf-8?B?bWR3WE05QzhwanBKejlDSUdWL0I1a21NS2ZjYVVRdURybFJqYWQ2TlhrU1lO?=
 =?utf-8?B?RFRMbmt0b1Z4TE12YmJDUWNBR2pIUkU3bWJLbjBKTzRkMFQrRnIxVURmY0N3?=
 =?utf-8?B?ZVJxczdUWG9Ob2k5N1oxSWgwamVUMXlrRk9NUnZWNXhsSDAzeWMxZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f9ec70f-1c86-41c3-3407-08dec397a868
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2026 06:48:46.9669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nRbiw2Go1qdz/IneHcrevk1qvIJD56dsE8F2S9JTOOg7GPSHwZFH0NqlyfHTdUYVVw0Syv7s3xBfZTCskrPlYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8336


On 6/5/26 16:20, Dave Jiang wrote:
>
> On 6/5/26 12:56 AM, Alejandro Lucero Palau wrote:
>> On 5/21/26 15:31, Alejandro Lucero Palau wrote:
>>> Hi Dan,
>>>
>>> On 5/19/26 22:01, Dan Williams wrote:
>>>> The devm_cxl_probe_mem() helper creates a memdev and retrieves a mapped
>>>> HPA range for the device. At present the retrieved region information is
>>>> expected to be established by platform firmware. A future update will
>>>> auto-establish a region if one is not already present. This arranges for a
>>>> simple CXL topology detach == Accelerator driver detach scheme.
>>>
>>> I have successfully  tested this with sfc and it indeed simplifies the accelerator driver. Removing cxl_acpi or unbinding the related memdev works as expected removing the sfc driver as well.
>>>
>>>
>>> I'm quite happy with this approach and I hope this is the last building block for the simplified (only with autodiscovered regions) type2 series.
>>>
>>>
>> No updates or comment for two weeks. I wonder if this is being superseded somehow and I did not notice.
> Are you not integrating this series with yours? At least that's my understanding given you are happy with the approach.
>
> DJ


Hi Dave,


This series got your review tags plus my tested and review ones. It has 
not been merged and and not received further comments either.


If Dan wants me to integrate this with type2, fine, but I think it 
should go first. The final type2 bits along sfc using this new type2 
support should keep simple and they will be even simpler after this 
patchset from Dan.


After 26 versions, I do not want to send new versions as soon as there 
exists a new possibility ... As I said, this series are promising and I 
hope they are the final step setting the way for my type2, but I guess 
you understand my precautions approach ...


In any case, if Dan or you want me to integrate this with my type2 
series, please tell me.


Thank you,

Alejandro



>>
>>> Just a minor comment in patch 5 and a suggestion for maybe changing the devm_cxl_probe_mem interface call.
>>>
>>>
>>> Cheers
>>>
>>>
>>>
>>>
>>>> Now, automatic region establishment on behalf of an accelerator driver
>>>> also requires automatic region teardown. The existing scheme of
>>>> triggering devm_release_action() of a cxl root device to destroy a
>>>> region is racy [1].  There is no path to coordinate multiple devres
>>>> actions, or conflicting devres actions, without using the
>>>> devm_remove_action_nowarn() workaround.
>>>>
>>>> Instead, move final region cleanup responsibility to the root decoder
>>>> teardown path (devres action cxld_unregister()). Expand the root decoder
>>>> @range_lock, renamed @regions_lock, to coordinate region creation, sysfs
>>>> manageability, and deletion. The @regions_lock also prevents regions
>>>> from disappearing mid-auto-assembly.
>>>>
>>>> Changes from the initial RFC [2]:
>>>> * tested with Dave's type2 cxl_test
>>>> * fix region remove by endpoints (Dave, Alejandro)
>>>> * fix user triggered region remove (Sungwoo)
>>>> * fix lifetime of the @attach ops (Alison, sashiko)
>>>> * hide @attach details inside the CXL core
>>>>
>>>> [1]: http://lore.kernel.org/20260427032010.916681-2-iam@sung-woo.kim
>>>> [2]: http://lore.kernel.org/20260403210050.1058650-1-dan.j.williams@intel.com
>>>>
>>>> Dan Williams (5):
>>>>     cxl/region: Block region delete during region creation
>>>>     cxl/region: Resolve region deletion races
>>>>     cxl/memdev: Pin parents for entire memdev lifetime
>>>>     cxl/memdev: Introduce cxl_class_memdev_type
>>>>     cxl/region: Introduce devm_cxl_probe_mem()
>>>>
>>>>    drivers/cxl/core/core.h      |   2 +
>>>>    drivers/cxl/cxl.h            |   8 +-
>>>>    drivers/cxl/cxlmem.h         |  27 +++--
>>>>    include/cxl/cxl.h            |   3 +
>>>>    drivers/cxl/core/memdev.c    |  20 +++-
>>>>    drivers/cxl/core/port.c      |   7 +-
>>>>    drivers/cxl/core/region.c    | 194 ++++++++++++++++++++++++++++++-----
>>>>    drivers/cxl/mem.c            |  95 +++++++++++++----
>>>>    drivers/cxl/pci.c            |   2 +-
>>>>    tools/testing/cxl/test/mem.c |   2 +-
>>>>    10 files changed, 297 insertions(+), 63 deletions(-)
>>>>
>>>>
>>>> base-commit: 5d6919055dec134de3c40167a490f33c74c12581
