Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010044.outbound.protection.outlook.com [52.101.193.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB0B384238
	for <linux-cxl@vger.kernel.org>; Fri,  1 May 2026 10:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777633153; cv=fail; b=H0EHHWWFJuipHVDDj9AY4241roK6hA4Etrt0XJ+7MLQOiTRQ1yAaFSNSju8VpjMFWuVwhgI6lOZaPxkKqLsjcmHaMSy9cykgibr7T2U35Z3NuRRK16aYN7ho8usOtUsFvetHOtlkDJBTFvYF9PVv1TcTvvh+/D6udPWp1lWKVkU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777633153; c=relaxed/simple;
	bh=BmPSia9kgitU7BDCxt1CTiu58rOSmhtDr4XhJ6BCEKQ=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SynjUcPFc+nuFoRyZ2I+ZXcZ68Qz2lkA02xx6ZGl8t/BS/MfhGz+XP0vinZOA5pJEu4QmoWz0YpnyOwPH2eWfLkd7cx+QKbHGcPDoOJNc5c1UXZNw/037GhLwMYAZvh4R36nvK40LaAMI8Tyhqs8teDJtsfLNkW3Ye9vh8EtSSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xY7Kcdkz; arc=fail smtp.client-ip=52.101.193.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xY7Kcdkz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QCf6fjCuDtgXA2LNhKn6mTnR6c0IMQf1s1rRoW/FYuTj54/ESnDartz+HHaEWZ/jU1kijT+mdNtYbSCM4w/Oeb3tLqFMfZLwTWNJ/ojFvsVXpEy9JFfuXZohUrW1NCCKgtM+Prg7ajN0DK7bfqB0Tj3PhfhTCq8zYr7TBo8pSoJN+bjuUrGX2/eAZfC4fDKQD+126NBvTh+NvSM3sW43d+uLXBssAcoI4go0yGD1u0nPfXu0/1/PnOdAkHiZpAsYzNGbgLSsft4eaOnrqKdVVv5ONy4KumP+GNasoZhKmNyRyDI7DmBGqKII/pdZ3VplGScaL53zmU70c78lEyImNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqu6waR8B03coZL97jDxiB2D/C36YADw3GIpuhTXPOg=;
 b=Ralzs8xGwzDEWFF9UeGi9D9Oh2YR3//VAlvNxDxL62cTOixOzy0yvZ0RJUtwmf/nnUmQn+PqIzEwdrSDFSyPT3v8RnPhkBIrUEZ0xMk2IDcxpFo2YGWFB46/ab1u2XnkHJ8FQoJt5K/ghKA9C/Jmo5NOS8Jy7oPab4JnObm4fVYRAJ8CvSDWf8O2J+R0c8eFNWLD3Tgg15QgGHCO/GM0vq/us/KbPIZQe2lL/xhO25JLCbyq17pjIsDn9D4fBbrHhibYo/JAVSISTZTtcaElkUUeZqskhNdNJl1ZQz/emirmSRvdJh7rRXfRSh4arXvN+OmqC8YJ2oC0BLXA/rh+6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqu6waR8B03coZL97jDxiB2D/C36YADw3GIpuhTXPOg=;
 b=xY7KcdkzIOySdve40++VeiysbwqJtscn+rslN4eFlVrKC0bFnRnDEURM544K094yu4leSPrVGrdwSRTpOGFhiEnY4ALZtYk96B7rzd4iOMqkvnwTZ6h+Dd1lAP6PfSy2Oq1lf5MaE9W1rpSksPu9Mvfne0IEWVvbCjcQpvMYWho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SJ2PR12MB8136.namprd12.prod.outlook.com (2603:10b6:a03:4f8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.23; Fri, 1 May
 2026 10:59:08 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%6]) with mapi id 15.20.9870.022; Fri, 1 May 2026
 10:59:08 +0000
Message-ID: <b5110c3e-c5ee-4305-b307-704837fe4f9c@amd.com>
Date: Fri, 1 May 2026 11:59:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v26 6/8] cxl: attach region to an accelerator/type2 memdev
Content-Language: en-US
To: "Dan Williams (nvidia)" <djbw@kernel.org>,
 alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 edward.cree@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dave.jiang@intel.com
References: <20260423180528.17166-1-alejandro.lucero-palau@amd.com>
 <20260423180528.17166-7-alejandro.lucero-palau@amd.com>
 <69f409325f7c0_3291a910046@djbw-dev.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <69f409325f7c0_3291a910046@djbw-dev.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P193CA0007.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:102:50::12) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SJ2PR12MB8136:EE_
X-MS-Office365-Filtering-Correlation-Id: 46d4a158-e185-44eb-3545-08dea770ab39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7136999003|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	SebJZcQ3aViTbNbgarOCRR7MfqTlChkahlTmFlssdTQUKCLLqkeow/eIdwGHyzOXWKriI9AspH7jU0+EHE1BBbb3IJTHn4lf7OeWt1kuk0n20cX1DPzDWmUIX4VgowzBoMnr/UoclYWIol9ySBz5U+cWTk4/BFAa1OUqUFvClGIiliPcM3HOLwVUkJcMOnIKBOCJYqxaR20EaGt6U36HAya9QCFG9VJyzarh13EweZ5GYpwFkifc7SXynBpF8HMDwRM4WAytFYJqeeieEP5VvletxrTetlcATuacUUuinBv6XIIKlCHBoC3258xJtSPbTaZ8dqUwFe1VP4i8tPBPoSi81pQu94E37nVhnGaGsTtcfth76benaTziHpuB6K68PGQK2kcYlQR/GRyQ/dcgwXE5u+4v+CgeKFz4pjxj7282YlK8ZRAAXAHrqPm+dOyyudY2rDMzVTgWhoTCYAPGLVjNsh4hdz0YeAPUDV0idf6Gk230M9r3MhO7BD1fjzd811u84y/tGibKIBED0hwNoUaIk5JsewdtdLIgozptX8s3xbHr2iKcTvFzUXjdJFnVADJgDdXZ4GplpOKVkBaozwf8ejAW2g9fv3OnI91/5DRIJ6D5FvoSXAW6/gTT9ujMcPWKOjaXMUnqP4lLBEQPW/CO4+Lr+yD01H60W12QrTSIaJCqHOwmrCOvdadxXyCZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7136999003)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eTM2ZnpFR3hjNUpxSTJ1TE5uS0JaaC9zQnVlUDFXZVNXQUNxSXFwUmplMjcy?=
 =?utf-8?B?STBTUXlmczBsVGs5bE1Uc3hpN3Jad0NRNkVDd05XREF2YWtTbGJ1VTljU09X?=
 =?utf-8?B?ZldZVDlRR2lnRExTMEZDTDhjZ2hUNERvUzkvOUk4OFVTYWVXUG1qckdVZWFk?=
 =?utf-8?B?dEZwKzZWZFMrTW1tYm9tSTBmbUZ6T0dLTTllRUNBNFJMUzlYK2pJL2ZISUps?=
 =?utf-8?B?Mm9vTkN0YlhaR3BlOXBFOVJaWDhiVUJLTWUyQnhWaG9lQkxFdGVZNER1anVC?=
 =?utf-8?B?aThSbTVTZTVQbnNmUDhOWFhaU1JpTW9kYTFsRUF4cllxSUZselUvb0NCSXRQ?=
 =?utf-8?B?YzVFb3IvelRsSHA1a3Mxa0VPQWZiTXI1WjY3MWVaaUcxY2dYQnBWSTQyOEpX?=
 =?utf-8?B?Vkx4MlZ3SmR1WllTY2JFRFJwQmt2VTBYMUs5bWEzcGVtaHNwKzJXVFBmM0t3?=
 =?utf-8?B?dUR5MUF6TW5wZVNOYzZ1ak9NdzVVcTByd2l5Y0VmY01aUVdoYmZOMmtxcE1K?=
 =?utf-8?B?d2dYQkVoQi9VcVphcW1LTlFXQlNEcXNCWlZGREMwdFZNQmdGRFYrSFlZUG9O?=
 =?utf-8?B?U1VhMzBQNWxWSC8yTnhUd1QxUmJvYUpZY2cvcisydkEyR01BWW02bmUrYVpt?=
 =?utf-8?B?NFZBR25sc01GaUlobEREeG92Mkg1b2QzZi83Mk5vSld6cnpLcDNPTnRBWm9U?=
 =?utf-8?B?TlhqRm91VGtzQkJoSUZyWkE5TjhjZnVHUkN3ZThTMWRJQzY1bW9haWxwanVE?=
 =?utf-8?B?cHpHLzR4RWpqN2o5TWFVdkVWMVdsWENkZ21IM2w3aE5aNDRQWWNTQnNlMHVr?=
 =?utf-8?B?bmxmTTJtd2JjWTRpZ2pqdElGQTZaajB6SmNuVHRJUFA2T3NVM2tqcUdXWHRT?=
 =?utf-8?B?U08vemN3VW9wbmtPQ0NqeHdsc1NzSHVEY2hQU2ZFV0lmMXNVcFVOZ0dZTnJW?=
 =?utf-8?B?cW9QZ2RyWDl5aDl4dWFWNEhTQVpnbXBFUDJoSXN1Y3ZhWG8vd1hsWXc2RUp1?=
 =?utf-8?B?QjU5NU1ZN1I4bnhVZ3ZxSGRXYXBBcTkvRGY2R3Fkem4xV2ZNK2dEUnNraWVi?=
 =?utf-8?B?T3ZTczVlT0NvK0dSWE9lOGpLTmkvRXdPM2lsQmQzZy9uTXRZTS96MXg4NlBk?=
 =?utf-8?B?Vi9DdjFiOEdmZnpYSThZbUVTVlVVRkJVVkRVNWY0SS9meExJUkc1VE9lVEVn?=
 =?utf-8?B?RnhNS1BXUDF3b0dyMkc5NTM2R2lSRVIwTWRSZ0phcXRDdmNaZStSQnJaNjIw?=
 =?utf-8?B?dmowbDJrbWZwejVrZ3h4dTl5aGNCdTI4MmRRcUF4ajdlenhxMGoweUhkMjhZ?=
 =?utf-8?B?MUQ1S0h4dEZGcmNFckYzbzN4bC9lZ3oyZ0JQY09jemE3dDltelE2RjRFTjBO?=
 =?utf-8?B?TlEzUFBQTGFuTnVSZjdmM1ZyY0t0QTBjcjNSOUVDc2oyMVdTcXBIWkJVaFo4?=
 =?utf-8?B?TTVPZlFMSy9RSmhJTmx1a0FVZWJFejlrSDdGQTlrNEwzWC8wejhueDF1NSty?=
 =?utf-8?B?dklVbllVZmVrdGpxaEtrQ2RrSUlKM0RmOFBOdXV3cmNkakxnOHFFZ1ZEbThZ?=
 =?utf-8?B?OFlkcHQwKzFHWWlPbjlFdWxicjdJeXNvUm9pZjFNSXU2ZmdwejhXeVFKaHdG?=
 =?utf-8?B?TTdLSFBDUmEyMGc3THBYUWwwRkk2MXdDTTRqL2xOa3pkaTZ4T3BOQUQyWitB?=
 =?utf-8?B?Skh2aE9yeVk1N1FnbC80b0lkRkljTDRxbERzQkxCYnViYjZzYVVMR1ZKbklt?=
 =?utf-8?B?NWdXMnk5WWtkbU1QQUFvV3ltWTE3cGNDSFR4TkZzY3ZDTk1aMEZKS2xUd3Uv?=
 =?utf-8?B?SHhQYk15Ri9EdDJVaE83YXB2dGdiQ0tudURjNTRQdzBNcGVvenUxaktSL0o4?=
 =?utf-8?B?ZVFnTTFyRTc3T3JlVnQ3MUxZUTNuMElsc0JnWGptamRYdU4xVURHYlpCZFlM?=
 =?utf-8?B?aU5KTWFDNUMzSEluS3FycFAxMk1PV1Bpenpiby9HOHhTVCtZM2ZFSEJ2OXJu?=
 =?utf-8?B?QTc5ZUgrWEVTWWxSa3hDdlVjMVFaY01POVpqWGdhYWtsdzlMRnBLQ2tleWc0?=
 =?utf-8?B?RElnN1p2ZkJRdjkxQ3pWeEY1M0c2NFJTb01ZMW5QUEFDQlVmQlM4OS9lOXdE?=
 =?utf-8?B?bnpjOFBkZzg4TlBSVXI2VU5FaFAvOCtaankydWFiU0tjbFJVanFHbUkvc1dC?=
 =?utf-8?B?dVgwQ2w2UEw5aXU4WDhKR1I3cEkrVHRrOWxjTWJnWndxOHdxbWJza1QyWEZm?=
 =?utf-8?B?cjJYQnZjZkZMaHRFQzB3cWZsYzhTcEZUVE5jWW14S0d2Unc1NFFER0lXd2h1?=
 =?utf-8?B?Z3lrejFON1dVTWJ2SjRXSENhS01BNVE4Z2tOYkZ5bGpKcW5OZExMZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46d4a158-e185-44eb-3545-08dea770ab39
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 10:59:08.6833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mDsu4RnZ30BHCoEOxJPD0kEk4DEhXYvRgg8cLq9qWGnQtUqOSGLov6vvZtZkP3cfPHW/FFakSGkufDzAbbNpzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8136


On 5/1/26 03:00, Dan Williams (nvidia) wrote:
> alejandro.lucero-palau@ wrote:
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
> A couple problems here.
>
> 1/ Nothing stops a CXL class device from implementing a decoder with
>     CXL_DECODER_DEVMEM (HDM-DB).


Uhmmm...


>
> 2/ This breaks the automatic cleanup of autoassembly failures in
>     construct_region().


I did not see this potential problem. Looking at it.


> We simply need to support multiple independent sources of
> unregister_region(). Stay tuned for a scheme for that.
>

I will.


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
> This does not handle the case when ->endpoint is an ERR_PTR() because
> the memdev never attached in the first instance.


Not sure about this but, is it not the success of devm_cxl_add_memdev() 
ensuring this can not happen?


Note I decouple region attach from memdev creation. No memdev, no call 
to this function.


>> +/* Called at driver exit or when user space triggers cxl region removal. */
>> +static void efx_cxl_unmap_region(void *data) {
>> +	struct efx_probe_data *probe_data = data;
>> +
>> +	probe_data->cxl_pio_initialised = false;
>> +	iounmap(probe_data->cxl->ctpio_cxl);
>> +}
> I do not see how an async event can safely zap that ctpio_cxl space with
> zero coordination with the driver, and I do not think you want to burden
> the fast path with new locks to coordinate this.


You should look patch 8 where your concern is hopefully tackled. I need 
to test this further, but there is no need of additional locks.


>
> Can we please stick with the violent but simple "unload driver" approach
> for now? Someone removing cxl_acpi, disabling port drivers, or disabling
> the cxl_mem driver gets to keep all the pieces. Just like force
> unloading your storage driver underneath your root filesystem. Do not do
> it unless you want to see the fireworks or test various hotplug flows.


I have to disagree. The use of CXL is only part of the datapath. The 
driver can keep going without CXL. The related buffers can be used until 
the sync between the efx_ef10_disable_piobufs() added in patch 8 and the 
CXL CTPIO datapath.


Although the option of unloading the driver is possible, I do not think 
CXL should decide what to do here when there exists another option.


Thank you,

Alejandro


>
> This graceful handling of something that should never happen, outside of a
> test suite exercising CXL core object lifetimes, is not a near term need.
