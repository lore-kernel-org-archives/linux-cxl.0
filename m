Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012030.outbound.protection.outlook.com [40.107.209.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A6561D5160;
	Tue, 31 Mar 2026 05:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774936108; cv=fail; b=KrouqWEALcA3ZRE6EJlzyMlhiF1Qf2mpzr3JOg/iqyrsVA+Gs93Xn4RzmC3ef2LfLyDSnusaPjs0UdLfCXX2cphIOGZ1i4idXAWOMpwwk8Pt6z6As4mEw8CR2Qj8SpqfzPsbxjJWyzwiuqSxiY8tpYOH2OLIcz9biioOjuSUjHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774936108; c=relaxed/simple;
	bh=AxZBiLWwMVuiKlJFaumPkrFg9T0NM82EITVa7z3nMAQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZbzVW7uRuuzNLq79Gb5ovDjVufWuCiRhCz6zdE6BEMvNlh3pzXt8I+5tRFwN+K/xoL7Z7ctd+cVSKmA57W7qbK48Y3PkO/NptAG3Ikv6Lj/OQcp6HuwPmrk67utEK+086mHgS4oIzvKYu4m/u0CA0JTWZ8NH7c8ZukdJseN//LI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VV6oSLAT; arc=fail smtp.client-ip=40.107.209.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VV6oSLAT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZlY6A7dVT1UI/q52Ul45NGW1CsMLKnB2RkvGmydXg3QEMPAcgDaqakpRw7laBuQ9sM6m8jpVKR5bN78R0dJmEb2hOzrp1qGlpG5IPkOUSxbq93V35+BpQca4A9eb8A2YcA27QaaCh1dH42VfelV1HaBkNQacbkiTmIhf1O22FZYp/ouKbUffYDgM4GSV5cV+UQO8mRT2csf5KWDTzdJZ/C2bYtGB7ZErdWhwhzVkmdj5WEsc7BrcfgO2bel/WXqFTbpi7xmMxUUNQ8eNasMQ8osBANw4TXVh3qslZoc9+F45Ad7GdS8pRwXzin4qqJv5bUcZSOA9BrAFmGKbuwqd1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97RCvd2NigdVtBqsdRpz2karLVK+2gf2vBaMfpVyg1M=;
 b=xz02DV1XUUKeb/B+VgAoTNOMToolURX02Jyeb6ZAddo+7o08RKUUVs77J3vmW9k5hb+nI6SVQdzp9xMLsYG7ZQAokVkwiXFieAIBFdL6GHTmAjcKszjQreoAv4T05sC926W2Zs34YpLSGicHu9sY/rhCis0lsbf4XFqM/SSqzUXbOpEYBRnBQ6Yd0Ewvu/e3PJcAMQfGCHe0y4sc3f5M9tp5nm36LctdhrlETwojbGp7SOOJfbfaZ+SpCWIYKrfUMMSaujfpNW6ejHoS/sZOJElfaCaY6EvqknVVvRsJdJXUzmtMuKlSxP9PKBGg8Ewjjl/6c88z2gBo9BOk31LQIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97RCvd2NigdVtBqsdRpz2karLVK+2gf2vBaMfpVyg1M=;
 b=VV6oSLATwWu05u7z0i+65qufbFOKJqlCXC240FtFpP4MfAoGlw3vrG5b8p19Nhyt5ch1C0NG4kCGR4IEEj20RYYmWeSevYC6ZIYOgy/NNp7pAhi40OFeqfk22ILCFWvMOe92DMeH1+P9qL4F3j646xt7dYrn9KDGE/GBNkTcRyo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA1PR12MB6529.namprd12.prod.outlook.com (2603:10b6:208:3a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 05:48:24 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%6]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 05:48:24 +0000
Message-ID: <4bebbaf1-d196-4370-8282-d95c952faa6b@amd.com>
Date: Tue, 31 Mar 2026 06:48:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/region: Add a region sysfs interface for region lock
 status
Content-Language: en-US
To: Li Ming <ming.li@zohomail.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
References: <20260329-expose_region_locked_status-v1-1-cd860feaff6e@zohomail.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20260329-expose_region_locked_status-v1-1-cd860feaff6e@zohomail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: ZR0P278CA0020.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:1c::7) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA1PR12MB6529:EE_
X-MS-Office365-Filtering-Correlation-Id: 2eeeced0-6739-455e-6c87-08de8ee91f96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Uqcck/J9uZZ/td7QVklD2Vy5pZfyeFrkeB8z3n91a/mpL7LpPwPL39TXGKxtpigsN8OEcEbsK/zmaSRMrgmpZNy2pC63Nm9rzaCLTDUYa/NrUw92Ff/BHroaiRjBvkw4fClKrrVqQQLtErdi1sekZLtgGHr1btYK+eoucU9QC/yCpy1o/wU8Wq8ak+Q68Z5wIRZbvg7oYBQxZRSTwY/HxlkRs0oxhgwE2+xwhSTd52HOcMaz7joBlbO1DAHkxofoiI+E/so+CMR2RgNpRZTr1L3SLiEAu4Gk7LovcZFtnCLN2jQTUtf544OfzEyecaln+mj4tmATl5+Jm0wDlJcvAvKLEGmkwGH/JgOniWnby+OCh/0U3CwDvPuvCEH2A9FgpIorYY7wyuAWtN4MOvIJDnZQ89psh2grcaHHBwOB5a5sZr3hpPBKhmalWjZZ4JFR7xEu0EvIK9SuOTYnkPlCxv7VFpcIqjPIjrGr7p5yhohlc8B78xgMpMYcbxNf34VLzIWyL8bOiWacDbRipKE8gE72h0hrR2aDdNt1ZeEi7AEsLHBrRPh2j/NWknwdqf1+u8EWSI1YIoxUzW+H9+lwSOGQgCKBsY63bvfhrBgkEvJ097RUnRddy0dTQXh32MuTrvqPYasZkPr2GmWIBsXy0Os+niD8+WAGSgyluSzzhG/Ek2Qg3VYtGwSv09q++SUG6fOwnNwFtGigZ4I729RgZSHY/PxkGCisDUQBgz0CAZE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NDhqeVVOb1hDWEhtSDFZM1N6a3ZVR3k3bWJlS3lZcDNJRnRHa3dXb1FSZnlU?=
 =?utf-8?B?U2EwUjVwWHFudUZ6bCt4TEwzdWRCUHB5aUkrcEY1TzdKSFhTLzRTcWt6RjRq?=
 =?utf-8?B?NGFxYmt1bExudXRLbmwrbnU4NTQ4RENwZGZESEJpZXZxL2ZCaFpiUDY0Y3RK?=
 =?utf-8?B?aGZIV3dqZk82S2J6TGdqNDNhV3ZMN1FBNVZLaDlyNG00aXlHWUZWZmJpb3c1?=
 =?utf-8?B?ZDVaWURwNVRtRENNRDhqVFhhVHR1dW5udk5rTXl4MnI5RDE5V3BHYkVRSnBN?=
 =?utf-8?B?UWF4cnRDRWowTi9oYXJLRThScVRSRHF3d2FsWmVmTE1nMmxickVBQXBQNTVP?=
 =?utf-8?B?UHlEOHQ0QXY5eFN4TzU5OUdadTVpcW9XcDZDTlFpYUFGN1J6U0NGbGNCeWVy?=
 =?utf-8?B?dGJmV291ZThWMmxSTVFSMWphV0lIZ0x5b1EwUy9tcDVBdStIbzlBWWNrUm1N?=
 =?utf-8?B?czdycEpzRFRWR3VWRHhIdG1kaVYxalF6RFh3MEI4UjdoS3NFYk0xd2RpbmFF?=
 =?utf-8?B?b0F3dzdUOVMvWWpEdktNNUV0ZXBSb1R0TFRaRnBpc0dyaGMraGxkVGFVSGNX?=
 =?utf-8?B?eTJSRmdvNExkY0czQlJGRkI3RzVoNGlRYW1GWExidVhVc3Rjdm1jcHZFOTFq?=
 =?utf-8?B?a3lLS29YUzFhK0VVZkZYZ2VCQUJuQWlCSXFxOTFnMVNDbEtaNjFmVWc2K0lP?=
 =?utf-8?B?OW5jVjFXMWljMHc0dnlvMTBDTmFVWlNkRnpkN2VjRkJxV3FMTXNuVlBZdUJj?=
 =?utf-8?B?MGx2U1pTajJHZElVMElpRmpOQy9GVDNjaFZWVHYwdmlCWHlqeXdzc1pJRkM5?=
 =?utf-8?B?TnV2bVRCdzlnWXJZREVrWXpzY1Z3OERnZHZPV3M3dTE4Skd5RUhjTnRBelMr?=
 =?utf-8?B?Y1VyL3I4ZWF6K01aSTMzMFZZc0RRQUFxRzVtbjRmcnhqeTdETHJLOGt4WTRj?=
 =?utf-8?B?RlRwelZTOW5UeHB6Z3oxTm5TLzJBaGd3a21QMWt3MHVtM0MwSDAyTzlTdm9K?=
 =?utf-8?B?NWc3U3QxQW1pUjIwQmFQSXRvRlE3Z1Y1STl4NGtKdGlNSmZJaW9QbHZNWVpn?=
 =?utf-8?B?NmczODlHV2FCSmQyUSt3blQrbG9tUzRkekhZazl4dE9IdVh4cWl2RmdsVzBL?=
 =?utf-8?B?Z0dBZWcyMUVzMDFaQkF0UHlnbDU0eGlLRzhGaDFGVVlSM0xMK2Y1SncrV3hU?=
 =?utf-8?B?ME84ajUwbExtaVdHNmgyR3BDWVBEemFUeEE0UXloVUJ3UEUzNDkvQ0JiSlRo?=
 =?utf-8?B?SkJqNnVZYXUvM21PbXhTNG1LWVJZS0hBT3pDVmJGcVFoTGttZjBhU2lSQzFh?=
 =?utf-8?B?QWpOWHNSMTRNaHFHeVpoZnJpWFYvUmlCUHRMZUZCcDFFTFdUVG5qSXZwaldM?=
 =?utf-8?B?aTAza0I3bWUzNk0yZmZhY2VSZlVmTFV0Umw3cnh1ZHFMNXU4NGVBZHdjMTFz?=
 =?utf-8?B?NExwZ0NtK3llNDY0WmpRdFFCQktNTkJ2RUVjNVUreXAvTkdkZ3lTbnREMlZX?=
 =?utf-8?B?TVVSOU9QRHMvUTIxTURINHMvVUhkeEdJeUtiWXdDNkl5ODl1SVNMVW1jNEcv?=
 =?utf-8?B?aHlDZ3JRS3NqZFpuaFNvQlkvV0ZCYmhJRy96TklEeTBwb2lCeVR4SXIrTExL?=
 =?utf-8?B?ajZxRTh4ZTVPR3dVYWxrUVliSGFlTVRKYVRQN1pKeVNIQWNQUXg3aTdmL2V0?=
 =?utf-8?B?UUMwOXJseEdpVEpwS1c0RmpzK3N6cWpnelRHbVlSVUtyeHhRYm1YcTBuY1pz?=
 =?utf-8?B?aDRUK0ZCcFdSQjVwVk9Ha3ZOQlhuMjdFT2lDZkZpWmRiaHgzR0FrMnQwUXRD?=
 =?utf-8?B?a3lZVlVKeVY5amt6NENjTi8xT3ZwdWZTTnBJQktGeEcrOTJIa1JoUXArWjk1?=
 =?utf-8?B?bGZ6czR4K3ZKQWJaOFlyZTZWb1pmQjFVYVkyNGszNWF1cy9jS2VSQTFTMm5p?=
 =?utf-8?B?SDRuVGxRSzZWRkh3MGNnR1VaUVpWU044MjlsZ2ZDdFQ5bnNWaTNnanZsSTF0?=
 =?utf-8?B?NWJEVWJYYkpNaGNDZEFPbWVvRm03OHg2Q3VGTXBzR1pjOUxoKzdRTmtXQjZK?=
 =?utf-8?B?OGN0d3lGZFBRd0p2bG90Uk5lVWQzRFFlZElhYXVJQmtWRDgxMStFYlpsRngx?=
 =?utf-8?B?WGEyTzdPM3AvVzhERTdkUXNnV1RJWlNlckwwZTA3NDAxNk5ZV0R1bEk4S21G?=
 =?utf-8?B?RUFXV1ZGM0kzUm1sS0tVNWVNWjgxM1o5N2tFOHh6MjFTeW1KaWpLYTNIeCtF?=
 =?utf-8?B?NHhkTExEUjBrdkpSYk40NGxZZTMzQ2QzMnVSRU83d1BMMU1ZZVdRU05YdXY1?=
 =?utf-8?B?UnhsdVExd1plZkdpVys5OGRBMkZ3OStCNDl2aW5Xb2pCcytaTWtVZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eeeced0-6739-455e-6c87-08de8ee91f96
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 05:48:24.4223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hfItqRNaF/rNw12Fw2XpUdksFe1ekwxElVplSMBFyBRg5EBcSGmxMiqgyZfy362BpQruTjMTBpCvFAqgdq+hxw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6529


On 3/29/26 15:44, Li Ming wrote:
> If a region is created on a root decoder with Fixed Device Confiuration
> attribute, the region will be locked , meaning region destroy
> operations are not permitted. CXL region driver returns -EPERM for
> region destroy operations.
>
> Although the locked status of the corresponding root decoder implies the
> region is also locked, exposing the region lock status directly to
> userspace improves usability for users who may not be aware of this
> relationship.
>
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---
>   Documentation/ABI/testing/sysfs-bus-cxl | 10 ++++++++++
>   drivers/cxl/core/region.c               | 17 +++++++++++++++++
>   2 files changed, 27 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index c80a1b5a03db..50bf7334465b 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -508,6 +508,16 @@ Description:
>   		(RO) The size of extended linear cache, if there is an extended
>   		linear cache. Otherwise the attribute will not be visible.
>   
> +
> +What:		/sys/bus/cxl/devices/regionZ/locked
> +Date:		Mar, 2026
> +KernelVersion:	v7.1
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) The lock status of the region, region destroy operations
> +		are not permitted if the region is locked.
> +
> +
>   What:		/sys/bus/cxl/devices/regionZ/mode
>   Date:		January, 2023
>   KernelVersion:	v6.3
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 42874948b589..95d81816008e 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -767,6 +767,22 @@ static ssize_t extended_linear_cache_size_show(struct device *dev,
>   }
>   static DEVICE_ATTR_RO(extended_linear_cache_size);
>   
> +static ssize_t locked_show(struct device *dev,
> +			   struct device_attribute *attr,
> +			   char *buf)
> +{
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +	int rc;
> +
> +	ACQUIRE(rwsem_read_intr, rwsem)(&cxl_rwsem.region);
> +	if ((rc = ACQUIRE_ERR(rwsem_read_intr, &rwsem)))
> +		return rc;
> +
> +	rc = test_bit(CXL_REGION_F_LOCK, &cxlr->flags);
> +	return sysfs_emit(buf, "%d\n", rc);
> +}
> +static DEVICE_ATTR_RO(locked);
> +
>   static struct attribute *cxl_region_attrs[] = {
>   	&dev_attr_uuid.attr,
>   	&dev_attr_commit.attr,
> @@ -776,6 +792,7 @@ static struct attribute *cxl_region_attrs[] = {
>   	&dev_attr_size.attr,
>   	&dev_attr_mode.attr,
>   	&dev_attr_extended_linear_cache_size.attr,
> +	&dev_attr_locked.attr,
>   	NULL,
>   };
>   
>
> ---
> base-commit: c369299895a591d96745d6492d4888259b004a9e
> change-id: 20260329-expose_region_locked_status-b05c4b8f97d6
>
> Best regards,


Reviewed-by: Alejandro Lucero <alucerop@amd.com>

