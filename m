Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012045.outbound.protection.outlook.com [40.107.209.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210DE25B092;
	Fri,  2 Oct 2026 04:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790916656; cv=fail; b=C27qTp7x1dPStzDfvja4Fh0wrb/VacIWJKIGz3EhjnsIIKpE7NalM1s/5xQDfwX1U5BXAP5YV1POYyhM58XugPyeHVpFQ9s50pnCO2tEQVPJrfPwZBSnBc3jtH59X7ljIiUuS76VYmX08Y/36JWtQOaILiVCkdz9pTDC/SrCako=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790916656; c=relaxed/simple;
	bh=6IyeSZlAIj5Xk789o2+PdNuzSyqGtC1qUsj/QT41IpQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rOz3BZ+9fctTdL5iQ32wv43/X0zLaVOHiLX8YMNAITaNH7SW34bNIOmGH0g9Xczldbf5/xR665htLYsxByvep/YTxfWqAI+KfyyeznXA6FBt5M9ZmnH2qqeItrVqst1WyDboqnfF5ZQtZtCqDpoZLwjHRg4j2YKIcVXbIRvLnW4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GenG+Oo9; arc=fail smtp.client-ip=40.107.209.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GenG+Oo9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=deiQ6yT3dIZnNUwL2ly3KmWi/Ba3QgzZ+teYZk+Ibee1VeuARBdbaVR18c6nmzNu1D1UXQEqudYYrxF4RpYzo5Tija+D7EYZEw94Dc4PPm+ZgVtX0zvHn27LyOvybf0mz0R8QBB0mOOtMvbNEbPTUdeMLayiy8a7yywvNcmx3QHX8EOyPm2UHwUxuNDeoBjWHdJfPxU9SfkUcpNzPvW2XFC+CfwOI6Xn2W10NlF5PCeKGWf9ufncIRvv6bCvYC2raGVtH+YHTHp41Bz5Va+0LNLbsCEwELshKGgygRIjgubZ1vXwziI53l/7LtHtQLHBsKcgyjdpS/wktNNNEEvhVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=In9+vHswEBpfbOwhPnQ3aDpKMmFrdUtaHT4S02Qkhps=;
 b=enoA76RXdIcGtaJTOxejAFbM1OMSQNyp/yHTxfzJF4K7/X4QAGr2DmqGJRwh7gr/7xTg5s/i9vbMuk5QytPOUYBjI988dg2nDqYatbmQ26i2byXHKkdARU2D34aC48lHHYK2+kTdMOweYJT9MK62xt1GXfCDuatJEVyvSIZ3ECXu22XgZ4RfGOYSmYDNBe14xmuKtHS3rzGLD+ulrt80UvAXEI53AfmmVMLthQIxHgRk4dqfx2kujpyEdPn4yl51706RjRJeLgbBdp2Ldsc2Q5oFSug8mA+ryJhVoQG4yh0NZlS6tjG6ra0BRKMEGTtx2YM5J3KZihOXIFtmEGNOlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=In9+vHswEBpfbOwhPnQ3aDpKMmFrdUtaHT4S02Qkhps=;
 b=GenG+Oo90tg7cNx4ZiTnh0vX6N1A403YUiSUnhB8NRu6KsUzBenkCHNC34FaKjM4a6cIfgor5r1ypUv861IIUM8MlyZnmvuPGWkJ8DA9a4VtLXTY1HghB1Ina0J/xWFPZl5G9gjoc/OzV9gM48a46yEMRuxKJxNU60qx1gkIy0s=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 PH8PR12MB6916.namprd12.prod.outlook.com (2603:10b6:510:1bd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 04:50:49 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%4]) with mapi id 15.21.0451.022; Fri, 2 Oct 2026
 04:50:49 +0000
Message-ID: <cd70c229-0fc6-4259-870f-5bdd6f5a020a@amd.com>
Date: Fri, 2 Oct 2026 05:50:43 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] cxl/memdev: Add support for multi PF devices
To: Dave Jiang <dave.jiang@intel.com>, alucerop@amd.com,
 linux-cxl@vger.kernel.org, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ecree.xilinx@gmail.com, icheng@nvidia.com,
 rafael@kernel.org
References: <20261001132023.17032-1-alucerop@amd.com>
 <20261001132023.17032-4-alucerop@amd.com>
 <13d92409-727b-43e7-a027-086c9a332f44@intel.com>
Content-Language: en-GB
From: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>
In-Reply-To: <13d92409-727b-43e7-a027-086c9a332f44@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0368.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f8::15) To DM4PR12MB6254.namprd12.prod.outlook.com
 (2603:10b6:8:a5::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|PH8PR12MB6916:EE_
X-MS-Office365-Filtering-Correlation-Id: edec6d19-dc1a-4231-3f17-08df2040ba7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|10067099003|4143699003|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	2sTWL8dcuhadcwSOACpu/HgkL6XR1JBjt9wRRX4fDhjO8hBCC8hxtZ5EObhOLw1A6TUreDV1B5569iHrJY+S8p9oLTM51jNtzx+Na57wphylSfIR8Ue/mUFadyYFWWlPA6wErC369IjJSa6v8ffilvIJvuZr0PCHPkiPhxVN7hZ8mNxCX3ZS9DzTePscRGsJB5dBO761hE+GR/KuiuaJePd5ikFIendOpsMmxaLGJW/z0wmF8SHmQTNko90kD8Nq4zuVv2XBIolrnH/ZT0/UKz2nUWPtvZNFFzGHP53pBel+BFCCNkF2ttxX4enTRRrnIalGJUg5MQzYMN2pGy4T4fzm+MFZzjhmtBvs5KW6GqyuU9GeOqZGetJpirkkjYdpW8btwRnaNSIW1NDwb0Xa8CZ7BgN+KeAgfHcOPICvF468/Lf4KVShV/ajjCWFUe/3Btdxms7KZNqFh9piUERxSr691O/LNXUzIiphnx7+J0oODKFiuTxGiz70M9Xhuu9fRjgCZh0oyRzDQKHOUpzA98Nvy/rZe4Sk/UT/tVFiTi6GN6IHawv6Y2K8//r36bVSZSDJZKW9ItJEFAiBV4V+NYjtsfNWU2OXqzwGD7FvZ4/q8yfmCI2MmaYA4M06GId7+p8uHSwzdR5VMnyPPz+dupDVIiTFOurtUvjfbnKBDEQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(10067099003)(4143699003)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WFlWNlkrbnRRZU0vOGZyRmZucW1EbUFvQUxmaVBncHdRMDRLZnVxS3BpWVlP?=
 =?utf-8?B?elRueThIOStWR3pJWllldTNEVnhBbkt4QWpmVFVudFVzOEFnbmxqTC9LV3BF?=
 =?utf-8?B?Z0FaTWtjVWdtU0Z2K0tHU0tnWDlHL2N4d2tBenNleko2RHpQTEdXQjdhT1NJ?=
 =?utf-8?B?a2tVV1dwLytKeVRiVDR4Ull2U1RpbVhjM01ram40b095Ui9hUGZkTURvSksz?=
 =?utf-8?B?aytrcStLUDRKUFRJNHNiUnJSRXk5VTZlZzMrYUJ0c3Vnb2xuekQzdUtyb3F5?=
 =?utf-8?B?VDJUYUliMUE3OUFVTVhoK09IdzJGcmFGK0JGWnFSNVZzS0RaTEw5bklSZG5a?=
 =?utf-8?B?WFJFaFV1cm8rejgrNzNWM255aU9OVlFXSkFEajByVzM2OUpnRTRVV1hwNEEy?=
 =?utf-8?B?TVJoUE1idkV0ZWtQRXF4aFNlR21ualROWW9XVHN5RkR0QWRMUUJxV1FEOFRO?=
 =?utf-8?B?QjNGQlBlZTkxWXdkbENsczdUZkVHWWRURy8zWXF2blJyS3ZzWWNxeGp4ZmxF?=
 =?utf-8?B?ZjBaRnhaNldQbDdFUStzSFJJdHdGNGNwaGhNZUZaV3IyVDdxc0JNK0hkYy9H?=
 =?utf-8?B?amY5ZkxnSUZHSDRRbm85VER5NGRpMTNvWnJNdGdTRFVpRzdwMlBJN21UNXJD?=
 =?utf-8?B?Wk1WampRTDBPQi9aZy9FS1BVeE9NN0krbFkwRXJLeXJtVEM0QmthQU9BbWJL?=
 =?utf-8?B?TFN4UUh6b2dCQTNUdEp2Y282L0oyRU9YK2pxMnV3TUZlZllCSk5DTUtZdTZi?=
 =?utf-8?B?RjUyK0NsK0tCOXAxajZvaGVPWWR0OFFjSFVGbEJ2cWxHTTVxNU9CMCtIL0Z3?=
 =?utf-8?B?TzRFOWd3REFjVVBHTDJackUreXFJY0pLQjNWL2Y2amVBeWxMdktpSytoR20v?=
 =?utf-8?B?dUJCSFJYVXZ5bmNzWGgrWmdrQnZyWWhQQlFOVHQyU1ZKbXN1c2lCWWN4SWlv?=
 =?utf-8?B?RkxOcnNJTStmMzRxTk53S2Jrd1Z4S3VqUHp4Mi9aTlpRSldzV0NCaVdQNnRI?=
 =?utf-8?B?MnR5aVc5alN0cGtpc0lqRlNaRXQydHdhMUR0b0c5OE0zeU9acXlwSW9nZHZU?=
 =?utf-8?B?dkJyeDA3Y08ydi9nWG1vM3NpOFFKY3k3a1Y0UzFOcG1yZUVoYlBTYk1mNUNN?=
 =?utf-8?B?cWdmUC9yZldnV0tPSlZMYno5ZzQ2U0NtRnh3bERHbnBGOWl6bXYrYjJWOEps?=
 =?utf-8?B?TGhaay9DbzU2Tmk3dVRGZzQ3VGlOVUk2YUlVS2w4RlM5bEllQUhoaHdLbGhB?=
 =?utf-8?B?WjRlalhOdzVNRERyd3BEZWUxcHdhRFEyOWtReU9MY3hhOWNpdm1HSDEzVWZX?=
 =?utf-8?B?VWtBbTFWZXlnUU5MNjJzZVNoTUlPa0tZdXg2Qi93bTErZ1NVK3IvbndhbytH?=
 =?utf-8?B?MjNrVFptWlFEYVRlMlM2MEw4bjRXS0ptbUxuZFJTRjE2TzZLVDh0VkRQVXJt?=
 =?utf-8?B?b21QdEhjQklVWHl5NFNGSUZ0cGtYK0VFSmh1QWpZYUwvbDRMNGw3UDBLdXBl?=
 =?utf-8?B?bWl1RjNhSmpKV0Vvbzg2eDZQUnRId1ZXVTdYTVJWdGM5aURHTFN1ZjNPT3lD?=
 =?utf-8?B?cU1zelFjTmZPMHZINFRJS3ZMY0hKSVNqVGt2VVNoamliZkcvVFhYUTVXbm1Q?=
 =?utf-8?B?M1Vobm9EcHkwNlFOK0JacVlsRVlTOGFNSi8wYW91cGJXa1I5L2VrajdwYWY0?=
 =?utf-8?B?T3ZYcVA1dDczbWZ0L25kWDYwakUwYWVIaXRiVFA0LzQycWMrWGdQcHA4SXlX?=
 =?utf-8?B?bmpNdzhzOURuSktSeEJDWlV3bk9IQklQOXFaTnNRTDBCM1h2RkFoN2d6TlZE?=
 =?utf-8?B?OVJvMnhKU2xWOUlBS0krTXp4NDUvVFhEOHM0MU5TYkoxT1RRL1lHQW1XRTJB?=
 =?utf-8?B?Q3lEQUJNRm5Wb1kyQ0NtL2RJcEpSRU1NeVNxOE9ndC9KNFdxLzlTQ2lXaXUv?=
 =?utf-8?B?N2xSYS9xOXM1KzBPeEtTL253cnJsc3RCZ0RHeGcwbFJvR2kzRjlya3k0V0Ew?=
 =?utf-8?B?TitIWmVSMDRMRlJMZGtJclA2NkhZcjdQWEFUMVovZnRIb1BUc2htNUhTSFBV?=
 =?utf-8?B?RjN2RmZnVit3NzdSdXo5TkovRVdUVDBFUFJUTGY0TnRVNlR6N2MrZVpaNmY5?=
 =?utf-8?B?c2hsaWlKbjVQZWwvTnVZV1JQMjRvQlVISFBkc2I4QS9xMnZGWnlWMVNwdVll?=
 =?utf-8?B?SlU4RlNWNW9kaDJFUXdTZmhxWUN6bVl4OUphakdMOWtqZC81SVVGSmF3M1VH?=
 =?utf-8?B?Y0F1VlBrVWtpQXRzaUhiU2pVU2lhekxkQTVJbFgzTXdNWER3WWR1dXVGTGZw?=
 =?utf-8?Q?c4ocVsYQfXd14nlRIb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edec6d19-dc1a-4231-3f17-08df2040ba7a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 04:50:49.0564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iG4sm2/PISCxSWXcvjg+58p7DlbJu5me2s3KX23mlnFXFb/I4G6PG0rNtcO52quxSBgmlRh5YgNQgbKvnUhoag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6916


On 01/10/2026 23:11, Dave Jiang wrote:
>
> On 10/1/26 6:20 AM, alucerop@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> A PCI device can present multiple Physical Functions(PFs) but the CXL
>> specs restrict to the first one, PF0, the discovery and management of
>> CXL capabilities accessed through a PF0 BAR. Other non-PF0 PFs need to
>> obtain the CXL.mem range to work with somehow.
>>
>> Add a device link between the cxl region a PF0 memdev is attached to and
>> the non-PF0 wanting to use the CXL region. A CXL region release will
>> trigger such a PF to be released from its driver first.
>>
>> PF0 being unbound from its driver triggers memdev and region release
>> leading to non-PF0s being unbound first keeping the CXL memory use safe.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/memdev.c | 92 +++++++++++++++++++++++++++++++++++++++
>>   include/cxl/cxl.h         |  2 +
>>   2 files changed, 94 insertions(+)
>>
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index b3419df586b9..799cb6e75639 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -802,6 +802,98 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
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
> cxlmd->cxlds can be NULL? How about just do dev->parent == pf_dev instead?


Not for a type2 memdev. This function should only used inside the next 
one. Maybe it is worth a comment.


>> +}
>> +
>> +static int __cxl_get_range_and_link(struct device *pf0, struct device *pfx,
>> +				    struct range *range)
>> +{
>> +	struct device *mem_dev __free(put_device) =
>> +		bus_find_device(&cxl_bus_type, NULL, pf0,
>> +				match_memdev_by_parent_device);
>> +	struct cxl_attach_region *attach;
>> +	struct cxl_memdev *cxlmd;
>> +
>> +	if (!mem_dev)
>> +		return -ENODEV;
>> +
>> +	cxlmd = to_cxl_memdev(mem_dev);
>> +	attach = container_of(cxlmd->attach, struct cxl_attach_region, attach);
> Probably not likely for a type2 device, but is there any possibility that attach == NULL?


As explained in my reply to your patch2 concern,  this can not happen 
due to the device locking. If the memdev is there, the attach is there. 
All that happens at PF0 initialization, with the PF0 device locked. With 
the locking gone, memdev+attach do exist or they do not.

>> +
>> +	/*
>> +	 * The cxlmd object does exist and it can be found in the cxl bus after
>> +	 * creation but before attach probe setting the proper HPA range. If so,
>> +	 * the caller will need to try later.
>> +	 */
>> +	if (attach->hpa_range.end == CXL_RESOURCE_NONE)
>> +		return -EPROBE_DEFER;
>
> Maybe you'll need something like this below to ensure that the region is valid still. And you can drop the above with the below code.
>
>        scoped_guard(rwsem_read, &cxl_rwsem.region) {
>                cxlr = READ_ONCE(attach->cxlr);
>                if (!cxlr)
>                        return -EPROBE_DEFER;
>                get_device(&cxlr->dev);
>        }
>        struct device *region_dev __free(put_device) = &cxlr->dev;
>
>        /*
>         * Region deletion holds regions_lock across xa_erase() and device_del().
>         * Being in the xarray under regions_lock means the region is still
>         * registered, and a link added now is torn down by its deletion. Drop
>         * cxl_rwsem.region above first: regions_lock nests outside it.
>         */
>        cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>        guard(mutex)(&cxlrd->regions_lock);
>        if (xa_load(&cxlrd->regions, cxlr->id) != cxlr)
>                return -ENODEV;
>
>        /* A decommit releases the region driver after dropping the rwsem */
>        guard(rwsem_read)(&cxl_rwsem.region);
>        if (cxlr->params.state != CXL_CONFIG_COMMIT)
>                return -ENODEV;


Because what I explained before, with the device locking and the region 
only disappearing at PF0 release  which holds the device lock, I do not 
think this finer concurrency protection is needed.


Thank you,

Alejandro.


> DJ
>
>> +
>> +	/*
>> +	 * Create the device link between the region and the consumer device.
>> +	 * AUTOREMOVE_CONSUMER means the link implicitly to be removed if the
>> +	 * consumer unbinds first with no consequences for the supplier.
>> +	 */
>> +	if (!device_link_add(pfx, &attach->cxlr->dev,
>> +			     DL_FLAG_AUTOREMOVE_CONSUMER)) {
>> +		dev_err(pfx, "device link creation failed\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	range->start = attach->hpa_range.start;
>> +	range->end = attach->hpa_range.end;
>> +
>> +	return 0;
>> +}
>> +
>> +/**
>> + * cxl_get_range_and_link - register a device link with the region PF0 memdev
>> + * is attached to. The region release will imply the link consumer to be unbound
>> + * from its driver first. Return the cxl region range to work with related to
>> + * PF0 memdev initialization.
>> + *
>> + * @pf0: device to use for finding target memdev and supplier for the link
>> + * @pfx: device to link to PF0's memdev region, the link consumer.
>> + * @range: to be set with the PF0's memdev attach region range.
>> + *
>> + * Return: 0 or error.
>> + */
>> +int cxl_get_range_and_link(struct device *pf0, struct device *pfx,
>> +			   struct range *range)
>> +{
>> +	int rc;
>> +
>> +	if (!pf0 || !pfx)
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * PF0 cxl memdev once created and region attached can only be removed
>> +	 * when PF0 unbinds from its driver which implies to obtain the device
>> +	 * lock before the unwinding starts. If this call from other PF races
>> +	 * with such unbinding:
>> +	 *
>> +	 * 1) if this next lock is obtained first, the device link is
>> +	 *    created and the later unwinding will trigger consumer (PF
>> +	 *    calling here) unbinding first.
>> +	 *
>> +	 *  2) if it is the unbinding the one getting the lock first, the
>> +	 *    memdev will not be there aymore.
>> +	 */
>> +	device_lock(pf0);
>> +	rc = __cxl_get_range_and_link(pf0, pfx, range);
>> +	device_unlock(pf0);
>> +	return rc;
>> +}
>> +EXPORT_SYMBOL_NS_GPL(cxl_get_range_and_link, "CXL");
>> +
>>   static long __cxl_memdev_ioctl(struct cxl_memdev *cxlmd, unsigned int cmd,
>>   			       unsigned long arg)
>>   {
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> index 802b143de83d..b28dce1f6f76 100644
>> --- a/include/cxl/cxl.h
>> +++ b/include/cxl/cxl.h
>> @@ -228,4 +228,6 @@ struct cxl_memdev *devm_cxl_probe_mem(struct cxl_dev_state *cxlds,
>>   				      struct range *range);
>>   
>>   int cxl_set_capacity(struct cxl_dev_state *cxlds, u64 capacity);
>> +int cxl_get_range_and_link(struct device *pf0, struct device *pfx,
>> +			   struct range *range);
>>   #endif /* __CXL_CXL_H__ */
