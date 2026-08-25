Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012025.outbound.protection.outlook.com [52.101.43.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16FEF3CF20C;
	Tue, 25 Aug 2026 07:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787643459; cv=fail; b=o/e+89BD0XLoNcfIjgZjxvn4f3lDqrjywAzcgyxCTgyJIIadu8nG8r8BEFVnYFt47PMu3BWggCvGTWQqps10RCxuKV9mSGjJ4z4JtKJdj9WG1csSHtqiKoWGdleOR3KPYSGRwUZKqvtRRv6Q2f49OnQnb7ng4K8ClKceveR3ZY0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787643459; c=relaxed/simple;
	bh=pW2wCJPB4UonUbLb2KEkyFRnQmNtOYWhL88FgMoEul8=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n30t+erXd6C1HzPz/rnl4sVndqlBkTPA8ZW55lFRUmb+PKdGhNzBEmiwFJrHUnuK/oG7lJ8kwiUunG/O/3CUu3OfoFjhVSh1w2truIQjSc3Pt4GIIfusYdwpGMsWfJWRzEFL8SiZ9J9npti8ZTW7vqONPypXS4IehHE47GQ28Q8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WjffZ8Xz; arc=fail smtp.client-ip=52.101.43.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WjffZ8Xz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wErtGQwGxREaFfmZ/MOho7PMAEfYiSIQ9ler89ZeXcFqm8Nbqyx4BsBJH2JPJEn4Rv3Wc99VhaM5fqXSCpv2bgnKDhzjZAm3Add6QgwhNLO0mHBmrAqmQUJPksaR0191sfT5fED/9NQmJzmeKRMB/NaRPB2OiP3bjI+tWr1Ufy+lBQF5rGfdpvpCKRd9Gqadh2NpsBXMR7rA7rCpNIAOPkyt/QqkeVp3qmEF/kS4rGFsMOqcr2XieYEn8wziWVAb7WaWyOOj+oGfCrSX1XxVq4gGMjqc2Vq3nnPBQR3fQrN5Ir5paVozeuurqPHMGfwspSFGamTXi8LJaU0EufrUMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+DOoEeW9KIehvqRCpzTxjZL0kp9ocL7dhgW5ezUGEF4=;
 b=wzm9Z6m1jk3MBytz0ILY29Ug9to3hMOG56O2muJiG1DvU07gMl6W49rDasuVKtmHi54nTPNfS39qxX8EqW6/+cj/VI802P6KfE7h08DVG7DBUOkBiR2rgKLsvgdtHy9SVzk8/DwQhF7qUevalpwRaaIwR+8IT3JRncnKx1VtVFceSS0KfABLpmHCKsLEpNNV9k539dfR6RJWULbTYqUc9GZ+oWeR9yCJuXXAOkM9rt7phy4C2ID9YPJ0o4t3u19i5OhubeHMdoeeE4w6XF74oT3xo8JGnF18OvOYbB4odwbBec/VmwuexhNgYvsQM7S10VNsKi9426u/bvkudnsWxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+DOoEeW9KIehvqRCpzTxjZL0kp9ocL7dhgW5ezUGEF4=;
 b=WjffZ8XzgRpDIqlSkKRrrov7Ez1PoWlrBC5qf7LuEdDk5K0iZ/J+QgeAk+utGBHi3UWSyR67yjvGBt0e1q7SOnJVP7jcfspHA/g6ZlC3ok6CSCWJY18PexD1XjVM0+tvZfdcdNWV+HKuvuJIjEZAhEys/D6LF8GgLmSfdX6bWAg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 CH3PR12MB8355.namprd12.prod.outlook.com (2603:10b6:610:131::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 07:37:35 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%6]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 07:37:35 +0000
Message-ID: <a313b340-9263-4204-b0b2-bc492cf746a4@amd.com>
Date: Tue, 25 Aug 2026 08:37:24 +0100
User-Agent: Mozilla Thunderbird
From: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>
Subject: Re: [RFC 1/2] cxl/memdev: add support for mutipf device
To: Richard Cheng <icheng@nvidia.com>
Cc: linux-cxl@vger.kernel.org, netdev@vger.kernel.org, edward.cree@amd.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, dave.jiang@intel.com,
 Alejandro Lucero <alucerop@amd.com>
References: <20260821155134.260053-1-alejandro.lucero-palau@amd.com>
 <20260821155134.260053-2-alejandro.lucero-palau@amd.com>
 <aov-jfhJtNtZJxlN@MWDK4CY14F>
Content-Language: en-GB
In-Reply-To: <aov-jfhJtNtZJxlN@MWDK4CY14F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO2P123CA0089.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::22) To DM4PR12MB6254.namprd12.prod.outlook.com
 (2603:10b6:8:a5::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|CH3PR12MB8355:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b25347a-48f3-4cfe-e86f-08df027bbb21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|6133799003|10067099003|4143699003|56012099006|11063799006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6GimGQgVGtG8VtnWjU+IbOqdGAdtqg5jm4+tAw7AcctsY6R5aQw21mBGof3wVwtUA4aeni8Vr1f/uLp3fV+iZJhudyIrSYEB8MGlC2mYoDmUhDGqLHUDjJE6llunWIqswlAk/HSBcMqJLofukRTtxEWSQN2CVl0puirDsq+KqdhuL9MqrR2q5LEooW3oHuzs9FMT8ILp8bIYZhm+X+/IMzvdXUdVR0WMfhs3/6+LllugK0tSpcfjX9ENpEtiRh0DZb1lWggaR7fupRT5qgftNKsJ4MLssqtASU5PPrbVc5cf+2nCka+E2SB+eLbDk5G9mb0LakNNJ6NVlMgg9/pMj1yWBRjFM4rb2AXZCaeNQxnGbd9ZfsXxY/6iEx+fL0pisAHs6eFoA5XWiqkQsyhtSVX0uLVrOJ9JYh9TYxNb0YFblI+/Shk5KLF9mWIqmkcDD7W6P7r+fwqfasoI2vkC/+Cjq4skwgzDYFrf6RaQGwyAxi9xM9Yn1zGgd9DbLWLPv9pX/NRAdLMYWA1U8uA1UE9LFqWLS+JcN+msokd2Izpb4eKxs5cHLU1ZZF7CBRiEinE0Fh+XOdezqMHlSqThou2G3goN8GLYDE25lscdMw3w1OqyprklclMJ65pHlaMGnj9+X9WtRpxlrM5Xy072S52dvW8kacpF1IH4Hp/YPnM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVZuZ3RERU1SOVhOZUQ3RXExTkxsZkFjT1VZcFFjOHBIWmZlOFlSUG5GSDB1?=
 =?utf-8?B?bHFRMjFmZ1VCU1VwNHpFSFVNaVl2NFJxZGVTWkMxNm5tRVNOelgvTi9WMXI2?=
 =?utf-8?B?N084dDZyY1Y1Z25Ya2V4TkIvaDdYMmZRQ2d3bEtQVld3WWgyNDU4cXU2Q0xo?=
 =?utf-8?B?aFBhYlpNMmJsTjcvdGptbm5rTXU0VzNYN0lYaEc2UkJlTlNEZUNhbHdkN2N2?=
 =?utf-8?B?bHFlY3hrS1RNcjNuQUhSZFhkOElTSi9peHpqaXZjM3lHZU45VnhYMmppZnZN?=
 =?utf-8?B?S25iVlJFZFE3dXpLWE80UzlFVlJTbGtGN0VKcXB5dkVUUThva2ZCcW42WmY2?=
 =?utf-8?B?MGl5ZklHaTB0VlhmNThJWnozSTIzVWFvclgzK0hkZjkzVXdhL2xkSG9GcGpx?=
 =?utf-8?B?M0NLOE5JY0F4dG5zRFhBS3JmVDdTYyt0c2o2TjlHS3ZDdDVPVTVQdmxvRmM0?=
 =?utf-8?B?cDBkakh5R0hYMytjVGpkUEJqWVBjNlJtcmlYMmxHSjRjdm01ajJNTkhub1hY?=
 =?utf-8?B?dFY4cmJuY3pXS0NvdW1ZM2ozMTNFUmRHbUJXalFSTnFmN2k5bmtoQVptZC9C?=
 =?utf-8?B?c2NUd2tOMXROa205clJpM244MjNrVWtadVk3eEo1MjI4Vk9HaFVSOVlVZmdT?=
 =?utf-8?B?VnRVNnFXWWtURGZCMk43VFNaSlAyS2o0ZWIvL3gvcXRJcDIxR2ZLYWFwNk9T?=
 =?utf-8?B?UEdOVUZiSVhPUktWVmxXQXNPWUFORHo2MC90Qk5rdmhNeG9iNDI2MnB6NWs1?=
 =?utf-8?B?ZXhvM3d4aTZNeU10eTZmaldoNXJUNVhkSlJ1UjVFQmw2cVVyMkVSMHpRRDZO?=
 =?utf-8?B?Vzk3RVVvMjNVNDB4Y3NzZ3ZYNjJsYWdTWWlFa0tWWUVjdjZ6ckhQZlVpR3p0?=
 =?utf-8?B?Vjh5UWtCWGVkb25FOVhPeU1aVzI3Q3hPemZkNGxMUlEzbVBibVM0OXQ0N2dG?=
 =?utf-8?B?NDdyUjFGcDlyWTVscitUYnZabUNXZW9Wd1labmtJT0VQVDZ6a055SjA2MHZi?=
 =?utf-8?B?ZkgxeXpQR2FSNnp4S0V1MXdRQXNidGNpeUliZmNHMmRTMFFkVExZUGpRNEtB?=
 =?utf-8?B?WnFXTmhGOW05TUNFOVA5RGpCbUhIR1FJd3NCcFY0Ky8rd1lxUjhKQ08vbGwy?=
 =?utf-8?B?Ry9LUkZDTHh1Qzczb3Z0c0xURHBoeU8xVHUzc2o5TVFkOG51MDZuWDFOcmMr?=
 =?utf-8?B?UmZURGJoRDQ3aHB4MGFmWmlmenpOYlpCVW9SOGhSM0wycDhKSU1vMzhCZzNG?=
 =?utf-8?B?V3hreVNvWmQ5MTRwWlJUbWpUdmZua3p0V2pSQTR4cjFsNHRhZk5EOE1XZUg2?=
 =?utf-8?B?U3NaMW4vNlcrSzZnVEk1bXdEOWVTRmJqTGxhdEFKRFJNeU5iK3dMVEY5UTdX?=
 =?utf-8?B?UGhlbXFmUHR4WG1GMVRiOEVKQU1pSy9lWjUxMmE1QjdRSmhOSE1NbGQxa2tK?=
 =?utf-8?B?Q3hpd09HMHJWcUVpbHBocDZsRHpxemtwWE5NNkdiTklWSE5HQ0o1U3pqN1pq?=
 =?utf-8?B?amo3RzlPU0dCQ3daU3kxVmVxNWRWYXd5Z000TGFRUzZDZ3FFTmhYeWdUUUwx?=
 =?utf-8?B?RThDVVlHc3dkUlFiTm5pQ0NtRW9mTEJHQjFMd0o2OWpSV3ZwTFBudHVDNHVQ?=
 =?utf-8?B?bHpxUDhzM2xHM1RkbHIyZ01QcXdGaXpuQmpNb2VOQTNBL2dVSkc4dlo5ems5?=
 =?utf-8?B?bXhQQzdMRlBjQXpqS2trTVFGdnlrQlB4V3VNdFpYRm00dGdXVlpPRDVlbDJ1?=
 =?utf-8?B?R3lOdHFhN1lLVlhxMjRCYmw1OWRKMzJjQVZWR1pEam5UN2JqU2ppaTVOOEQr?=
 =?utf-8?B?OGJpa0k1OU9odXBpOGlWUFJaMUJCVDZURjZXWmdRNGlkVnRLUFVscHRFY2hq?=
 =?utf-8?B?MWdzMDFNQ1dNVklieUtDY0k0bUFKd2UvMmVIMVdpbkliNVUyNVhjTzZGQnFT?=
 =?utf-8?B?L1lTRm5MMzJvYVlJdmRrYnYyV3RKckY2SVI4eHJrSjlMRGF3ejhDdDRtZ1ly?=
 =?utf-8?B?NlNsOWFlTFYweXNRbEo1SmtrbVlrQmsxdnA4U2JuQzVGVlVoaUpMTEFtOTll?=
 =?utf-8?B?WWU2bDdMV2Q3YkwxdUJlQm9qUVV3OCtkZ0ZhNnVpSWlVQ3FiU09kbjFHcCtk?=
 =?utf-8?B?VzdiSG9WSFZGQnZNUG9xd013WmR1NDI0NGlyL1RYQjBkdXU0WFhQMVpWZmlF?=
 =?utf-8?B?N0RzT3dUK3MvV1BwRm1zR0JRMjg2RW9rR3Z5MHpjbXcraHF2eUlsNmxiVkZK?=
 =?utf-8?B?SmJpMjN3ajF3bFlvZC8vcU95WHVtbWJMOFM0WVpNeU51VVlHMjkrM0xpUjNG?=
 =?utf-8?B?U3c1SGlKbUNxdWNacjI0TXNVcU5ndmR5TGhIdUptL3d5WVY1WDRCdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b25347a-48f3-4cfe-e86f-08df027bbb21
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 07:37:35.6096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YevzwcTUGmDG2+jeBOM43F0Vi39NYw/H/Vv1v1GCF6RbiG3ws/jOwGj+oOBud+qcNMLJqJbLHvbHjml2Qonp5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8355


On 24/08/2026 09:33, Richard Cheng wrote:
> On Fri, Aug 21, 2026 at 04:51:33PM +0800,alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero<alucerop@amd.com>
>>
>> A PCI device can present multiple Physical Functions(PFs) but the CXL
>> specs restrict to the first one, PF0, the discovery and management of
>> CXL capabilities accessed through a PF0 BAR. Other non-PF0 PFs need to
>> obtain the CXL.mem range to work with somehow.
>>
>> Although this could be handled internally by an accelerator/Type2
>> driver, it requires to properly handle changes to the CXL mem device,
>> mainly its release by the CXL core, but also potential CXL device
>> resets. When this release happens, those other PFs need to be told about
>> it.
>>
>> Implement a way for non-PF0 PFs to register/unregister to the memdev
>> linked to the PF0 device. At memdev release, trigger the release of
>> those non-PF0 PFs devices registered to such memdev from the driver they
>> are bound to.
>>
>> Signed-off-by: Alejandro Lucero<alucerop@amd.com>
>> ---
>>   drivers/cxl/core/memdev.c | 122 ++++++++++++++++++++++++++++++++++++++
>>   drivers/cxl/cxlmem.h      |   1 +
>>   include/cxl/cxl.h         |   4 ++
>>   3 files changed, 127 insertions(+)
>>
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index b3419df586b9..327c4da3208f 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -26,6 +26,35 @@ static void cxl_memdev_release(struct device *dev)
>>   {
>>   	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>>   	struct device *parent = dev->parent;
>> +	struct device *sibling;
>> +	unsigned long index;
>> +
>> +	/*
>> +	 * Type2 multipf support implies other non-PF0 PFs could be having a
>> +	 * temporal reference to the memdev, only for registering/unregistering
>> +	 * as sibling, requiring to postpone the memdev release and the sibling
>> +	 * management until no further references. While detach_memdev() calls
>> +	 * for pf0 release from its driver (parent device of the memdev device)
>> +	 * it is not safe to invoke for sibling PFs to be detached at that time
>> +	 * as it could race with PFs registering/unregistering as memdev siblings.
>> +	 */
>> +	if (cxlmd->attach) {
>> +		xa_for_each(&cxlmd->siblings, index, sibling) {
>> +			device_release_driver(sibling);
>> +			xa_erase(&cxlmd->siblings, index);
>> +		}
>> +
>> +		/* Several possibilities trigger a memdev release with one being
>> +		 * its parent device (Type2 device) released from its driver. If
>> +		 * so, such release is the context for this function, precluding
>> +		 * the mutex lock and therefore safely avoiding to invoke the
>> +		 * release again which would trigger a deadlock.
>> +		 */
>> +		if (mutex_trylock(&cxlmd->dev.parent->mutex)) {
>> +			mutex_unlock(&cxlmd->dev.parent->mutex);
>> +			device_release_driver(cxlmd->dev.parent);
>> +		}
>> +	}
>>   
>>   	ida_free(&cxl_memdev_ida, cxlmd->id);
>>   	kfree(cxlmd);
>> @@ -795,6 +824,7 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>>   
>>   	cdev = &cxlmd->cdev;
>>   	cdev_init(cdev, fops);
>> +	xa_init(&cxlmd->siblings);
>>   	return cxlmd;
>>   
>>   err:
>> @@ -802,6 +832,98 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>>   	return ERR_PTR(rc);
>>   }
>>   
>> +static int match_memdev_by_parent_device(struct device *dev, const void *data)
>> +{
>> +	const struct device *pf_dev = data;
>> +	struct cxl_memdev *cxlmd;
>> +
>> +	if (!is_cxl_memdev(dev))
>> +		return 0;
>> +
>> +	cxlmd = to_cxl_memdev(dev);
>> +	return (cxlmd->cxlds->dev == pf_dev);
>> +}
>> +
>> +/**
>> + * cxl_get_pf0_memdev - register as PF0's memdev sibling
>> + * @pf0: device for PF0 used to match current memdevs.
>> + * @pfx: device to register as sibling to PF0's memdev.
>> + * @index: where to register the device in the xarray.
>> + * @range: to be set with the PF0's memdev range.
>> + *
>> + * Return: PF0 memdev pointer or error.
>> + */
>> +struct cxl_memdev *cxl_get_pf0_memdev(struct device *pf0, struct device *pfx,
>> +				      unsigned long index, struct range *range)
>> +{
>> +	struct cxl_attach_region *attach;
>> +	struct cxl_memdev *cxlmd;
>> +	struct device *mem_dev __free(put_device) =
>> +		bus_find_device(&cxl_bus_type, NULL, pf0,
>> +				match_memdev_by_parent_device);
>> +
>> +	if (!mem_dev)
>> +		return ERR_PTR(-ENODEV);
>> +
>> +	cxlmd = to_cxl_memdev(mem_dev);
>> +
>> +	/*
>> +	 * we got the cxl_memdev and the implicit get_device in bus_find_device
>> +	 * makes the next steps safe.
>> +	 */
>> +
>> +	xa_store(&cxlmd->siblings, index, pfx, GFP_KERNEL);
>> +	attach = container_of(cxlmd->attach, struct cxl_attach_region, attach);
>> +
>> +	/*
>> +	 * The cxlmd object does exist and it can be found in the cxl bus after
>> +	 * creation but before attach probe setting the proper HPA range. If so,
>> +	 * the caller will need to try later.
>> +	 */
>> +	if (attach->hpa_range.end == -1)
>> +		return ERR_PTR(-EPROBE_DEFER);
>> +
>> +	range->start =  attach->hpa_range.start;
>> +	range->end =  attach->hpa_range.end;
>> +
>> +	return to_cxl_memdev(mem_dev);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_get_pf0_memdev, "CXL");
>> +
>> +/**
>> + * cxl_put_pf0_memdev - unregister as PF0's memdev sibling
>> + * @pf0: device for PF0 used to match current memdevs.
>> + * @pfx: device to register as sibling to PF0's memdev.
>> + * @index: where to unregister the device in the xarray.
>> + *
>> + */
>> +void cxl_put_pf0_memdev(struct device *pf0, struct device *pfx,
>> +			unsigned long index)
>> +{
>> +	struct cxl_memdev *cxlmd;
>> +	struct device *mem_dev __free(put_device) =
>> +		bus_find_device(&cxl_bus_type, NULL, pf0,
>> +				match_memdev_by_parent_device);
>> +
>> +	/*
>> +	 * This is not an error but a possibility if triggered by PF0 being
>> +	 * released which triggers the caller driver releasing pfx. It should
>> +	 * not happen if the caller driver does the release of pfx independently
>> +	 * but we do not have a simple way to ensure this here.
>> +	 */
>> +	if (!mem_dev)
>> +		return;
>> +
>> +	/*
>> +	 * we got the cxl_memdev and the implicit get_device in bus_find_device
>> +	 * makes the next steps safe.
>> +	 */
>> +
>> +	cxlmd = to_cxl_memdev(mem_dev);
>> +	xa_erase(&cxlmd->siblings, index);
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_put_pf0_memdev, "CXL");
>> +
>>   static long __cxl_memdev_ioctl(struct cxl_memdev *cxlmd, unsigned int cmd,
>>   			       unsigned long arg)
>>   {
>> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>> index c401e3a1af06..430014c4a046 100644
>> --- a/drivers/cxl/cxlmem.h
>> +++ b/drivers/cxl/cxlmem.h
>> @@ -54,6 +54,7 @@
>>    */
>>   struct cxl_memdev {
>>   	struct device dev;
>> +	struct xarray siblings;
>>   	struct cdev cdev;
>>   	struct cxl_dev_state *cxlds;
>>   	struct work_struct detach_work;
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 802b143de83d..883ce9f1b73f 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -228,4 +228,8 @@ struct cxl_memdev *devm_cxl_probe_mem(struct cxl_dev_state *cxlds,
>>   				      struct range *range);
>>   
>>   int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
>> +struct cxl_memdev *cxl_get_pf0_memdev(struct device *pf0, struct device *pfx,
>> +				      unsigned long index, struct range *range);
>> +void cxl_put_pf0_memdev(struct device *pf0, struct device *pfx, unsigned long index);
>> +//struct range *cxl_get_memdev_region_range(struct cxl_memdev *cxlmd);
>>   #endif /* __CXL_CXL_H__ */
>> -- 
>> 2.34.1
>>
>>
> Hi Alejandro,


Hi Richard,


Thanks for the review.


Replying below to your suggestion.


> I agree that non-PF0 functions must stop using the CXL range before it disappears.
> However, I don't think cxl_memdev_release() is the right place to unbind them.


For solving concurrency issues, I had to delay the real detachment to 
the time memdev is released. This is the problem:


1) PF2 is bound to the driver and probed. The code path reaches the 
point where the PF0 memdev is obtained for adding this PF as a sibling.

2) PF0 memdev detach happens. The non-PF0 functions attached need to be 
told triggering their driver's release.


Both are going to modify the list of attached non-PF0 functions, so some 
locking is required, or the memdev could go without awareness of the 
incoming sibling. For example, the xa_store will happen, as a memdev 
reference was taken, but the memdev detachment based on xa_for_each 
could miss it (RCU read) and nothing else will not look later on for it, 
leaving PF2 using it as the driver release call does not happen. Note 
same situation but for PF2 being independently release do not need the 
locking since xarrays intrinsics will be enough and no problem if 
xa_erase happens twice as the index is unique per PF.


The problem with locking is if the second thread gets it, the first one 
will be waiting. Then the second thread will call for PF2 detachment 
implying call to driver release ... which will try to get the PF2 device 
lock in use by the independent PF2 release ... leading to a deadlock. 
Checking if the lock can be obtained is not enough for dismissing the 
call to driver release.


> For Type-2 device, PF0 driver creates the memdev, and therefore the memdev
> is tied to the PF0 driver, while CXL core manages its attachment to
> the topology.
>
> cxl_memdev_release() is the final object release callback. It can run much
> later than the CXL attachment teardown.
> For example, an open /dev/cxl/memX file holds a device ref. PF0 and the CXL
> region can be torn down while that file remains open. During that time,
> other PF driver remain bound with mapping to a range that's no longer valid.


Right. I did not think about this possibility, but I think the memdev is 
safe to be used as long as the related CXL region is present which 
requires to preserve the endpoint HDM (plus the Root Port related HDM). 
In other words, I think for this case extra device references to 
cxlr->dev are necessary. I need to think about this with more care.


> I suggest replacing cxl_get_pf0_memdev() and cxl_put_pf0_memdev() with another
> helper, e.g.:
>
> int cxl_memdev_link_consumer(struct device *pf0, struct device *consumer, struct range *range);
>   
> It should live in cxl/core/memdev.c , and the behavior is something like
>
> 1. Find PF0's memdev and take a temp ref.
> 2. Lock the memdev
> 3. Verify that the memdev is still registered, driver-bound, attached, and has a valid HPA range
> 4. Create a managed devce link via device_link_add(consumer, &cxlmd->dev, DL_FLAG_AUTOREMOVE_CONSUMER);


Interesting approach.


Not sure this could do the proper thing though. 
DL_FLAG_AUTOREMOVE_CONSUMER seems to remove the link, cxlmd->dev in your 
case, when consume driver unbinds ... but it is the other way what we 
need. Maybe I do not understand well all the implications with this 
approach, so let me study it.

Thanks!

> 5. Copy the HPA range
> 6. Unlock the memdev and drop the temp ref
>
> This helper can return only an error code and the range. The sfc driver doesn't need the cxl_memdev pointer then, and
> no put helper would be needed.
>
> And driver core would unbind the non-PF0 consumer before unbinding or removing the supplier ( memdev ).
>
> I think this can remove the sibling xarray , raw device pointers and mutex_trylock() context check.
>
> Would this modle work for your teardown requirements ?
>
> Best regards,
> Richard Cheng.
