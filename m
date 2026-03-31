Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011042.outbound.protection.outlook.com [40.107.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C3F2ECE93
	for <linux-cxl@vger.kernel.org>; Tue, 31 Mar 2026 05:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774936729; cv=fail; b=qzcvGiIJOkVWwIIT4bHduZDjF71SH1EYUIlMqYtLq+UwwWRP7/bcFza88NTfoO6iY6FeFWNE5sFWRH4Cd384Bp9tKfrqvBXmRP0ZHmdEytsu55dQuE+lx/onhVEghbqqcQDptzOft79vspkk4reXazJ/LGOFO6Apq/V4RcT0YOA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774936729; c=relaxed/simple;
	bh=1Ytgl8jxtAED9QS3DhPl7xzGovKx4fe0ABc9OXYO7LY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Vyf5Snok/TLYxfRKBarCHUEBALVdEHwjFiBxkAhzR95AD33C/IziXQYWBLj6P/J9UOeJA+sQByXz4xZLrPcwxa51Cxzu8142vO4Si0rq746HSOGfcyQHKkXnypL9rIW1ZNpXZvo4x6Z5A/M6OV3+zb7VjI1sh6k3Myt0pMP3ao4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kz8y/dsq; arc=fail smtp.client-ip=40.107.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kz8y/dsq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AsNnL5ZDYqU+frDbravNjX3eJ4quKaupcE9tQHeK31iEAgzW7GnaY2A8Zvg7+vK216IXuTk61R9jXUziv9GIwc24un2nXqzGsAzs6/30GYAAb0O5r4g3+wIl8S9s8AAxRW385PJF8X/F6DbimJi4KB+unlm/w0WhHfgdNz1WJEChwDLd93K0DgbRliE1cV3IcnduHZYqrz7TYOosgx0zL5eTKI/Q81C/EVLlxnd3OAIkCG5GuMyW4eZyD5uRzGDpDeU+V0KQdCZn3o8DslID6QwKUsQX3+av3RqC48F8uAnPGloyjUNzYcOZZgPiPl0OrpcbbJw6yD8wTSSFgjO8LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHjyC8Ficn6DfQrU7aL4ns2AFqZvvKGgql0jc4DT/RM=;
 b=gg4p2dueSk79KzGJfMsCZcwgkxEvC3aaZ7H52DRsg3MSjDEekj7xZSaymSaSTcxq78A5C0Vc6sBE+Q+sk1dyYoABmmaYwSX7t5CUYT7nXr6QiSs75O+CFnhTQ2NVz+l4aVYwZtegG4rMkn5zAcHTCKQXYMwAKrsXiKhKsNxns7dQSKZjoX2q4dkuu/sksPBLz3If1WPm26IAdK/x/mBZHmvWmk17SV7SEOkSYhPaCFtkfOY45c0JMwWyiJ8NAahaP8hJp0RW8/qVLvJJoqOBt2FnQvN6FsD34sSNV5SDfIi6ZQkup9NMUrEHYWDIJsWL+5cW+b6s7TZdb1wnJyZr5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHjyC8Ficn6DfQrU7aL4ns2AFqZvvKGgql0jc4DT/RM=;
 b=kz8y/dsqiptMjQeiWC5YV5U2Yyg9Q8WoXtXs95LnaNQhJF5EdHUojqvRzHQYIahEweYkmh6yQgSGMM/5+udxhsM7YbRh6q0eLrYb6zLRd/xjPyDXoprYRzdUzOSz3A+gRJcXfzqYLs0rr5TlxQLCZ+v3exjbVdQ1BaxfRwl108I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by IA0PR12MB8376.namprd12.prod.outlook.com (2603:10b6:208:40b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 05:58:45 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%6]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 05:58:45 +0000
Message-ID: <7ab8c96e-2e9b-49ff-8b4f-3f716c496426@amd.com>
Date: Tue, 31 Mar 2026 06:58:40 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/core: Check existence of cxl_memdev_state in poison
 test
Content-Language: en-US
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>, Vishal Verma <vishal.l.verma@intel.com>,
 Ira Weiny <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
References: <20260331005047.2813980-1-alison.schofield@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20260331005047.2813980-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LNXP265CA0070.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5d::34) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|IA0PR12MB8376:EE_
X-MS-Office365-Filtering-Correlation-Id: bda75896-6598-488a-24ae-08de8eea9180
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	j937TkZ2waCqtDiiSpwgTexSbkt8vmUMoe7nOLckxKsIQWG4+/wtimdxMIyTHlVi79eQrLfjAMe/1D1P1wgyo9fbTG8ezFzKkdBPD/luYpuXW6d+2jci2A5fN5OXqYfVVnLUGqEKAu+TDD+/MVCsfEoInlf1PAiKgr7MKiaelrD36Q7w0bKc3r6RD3LVYmIYjU/Jh30L6XzgWZgkhoFJRHDEhFH1/l3RgI1xEMytJubhdlZNHt3jDk9xV0+4cUpgsfivmbDPA1rnQS5AUpIr/PyP+uhjaz1NUVrvAhc7/C/TZJ2L6bcob+jMnorurM4lGbRmhBsG0T24BZyUG9y1Y4Wuvo34gMS3r3Cz3R+284p80F0dvWcEA2CVOKlANaQaBpQ/5kPlDCDn/WnDjJlHd8Rx3Zigab7HfNNoW/bMmjOJqmQmzdou7SPVpiTocIs964/uZHhF9EQ84Rj1PXN0F5Lq4BlY0IP0FT74Ps1rdwm1E0R+SjaOJkXynjikXQeqE2oLB/GITe2qOtcgftKuYRoBUMy3XDdwzWloWS6qJcZkRsCHt1z53T0JFCey+D9kRqatLJnZzKOZCe7JiC9k6RybiI/E1IWePVhnC4vXKNj75Y75CJ4auRQdYrhqQQxksy64QiIZXvKXmaK+T+ZNbwTtCDWoueSJ4BDO/ZUI451Lj5fJj09SYZxrugIS0DX5Y34KJ0/eYDhJYRa9fbxoO2DeTQSOvbf0nfcVCuTCt4w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUlvYnlQQzgvOGJRZzNSbTZaSmY5QnRIeW5RYmwxTlFJREh5a2tHdE4wUkJU?=
 =?utf-8?B?bE54dC9BNFNrTGhrRlhvd2VQbkFQZzF4MnBLWHFPSXl6aDlSamdvNC9qcTVw?=
 =?utf-8?B?alJnS1M5dC9kWk5WTEh2SVZ5ZjVnZzJnODZXOFJPZFAraXM4QzRyRTJSNXkr?=
 =?utf-8?B?WmJiTjdiYXVaekFNR2VZR3kxTHdFdmF1K0pNSGpTbWJib2VoYWhGNE5FQ0hG?=
 =?utf-8?B?NjBtamdmNTZ4QnM4cFdtSmtveXgxd3h1bExUTzlGV2ljdFM4MTRLRm1xOTIy?=
 =?utf-8?B?SDdSemlKc0JoZUlod2dlSlNKeDFXYUdjbHlYL3IxOTlVQi82SU5JekRSb2tP?=
 =?utf-8?B?T1VkL1dUcnhsMCtlSHJNUndRS2JUTk1vT1F0c1p5TzgwcEJoK2swZG1pdnhr?=
 =?utf-8?B?RWwrdEJuSnhDL1hJa2VvcERMTVVieUZiQnorbDlYN0ZzNmo1NVNnQkUwSExJ?=
 =?utf-8?B?UEE5S3RER0ZpczhlRS94WWNXVUk0TndncHVJaWJjZE9IYW91ZHpTQ1N5ZEF6?=
 =?utf-8?B?Z3N2VXZXdzBBOFlGTGg5aUV1SVdnOVg4YWlOb1ZWRTN5Z1orRERDNE1wNkNq?=
 =?utf-8?B?dmR4L2ZLWEJ6dEZ4UDUrRXkzYzdnT2hyYXVnQ1BNM1BXZzZLWGZVd05QS3ly?=
 =?utf-8?B?czZiSWdkdGpMdy80YVZrQ0RMUW5TZHFWNHVWbHgyVmltWGpyZ2I3OU5aYUk4?=
 =?utf-8?B?bDBlK3c4a200Y0ZWTG10RzlWZlpWTUpZSjVaclpzTW82SlRqNURzeW94N29B?=
 =?utf-8?B?YkoxZEd5dk5lUi8zTGtzeVhQakZVWHNUemk3aHJkTTcwSGUwMVg4cDlnQktN?=
 =?utf-8?B?Y2w5QTdFdjJjUnZqZ2M2MTdqelFKOTFScVVyZDZleVNYSTdDamhRQkZ1YVhs?=
 =?utf-8?B?STRkOVJYL3piV3c4alozWkUreHhYeUxYL1RTOFF3KzJieFpVZElVZFVCQmFZ?=
 =?utf-8?B?MDhLRUoraU5HWlZlWCtmbTZPNFdVUnJ2elNPMUd4WmdOVnh4eUN4TTRjek9q?=
 =?utf-8?B?M0c2LzRqeDh5N0VWdTBkWjNXN0RPVVBlOXdnU3Y3QWVXdU9xVlExV0d1VUNG?=
 =?utf-8?B?ZGZDbEVNRzhpcWFkekQ3bWY0dFpicURCaklHdGkvVjhnM1JHZWlsNWhxVWZG?=
 =?utf-8?B?T3lNc3N3SFlkQzR4YlBvQ25PcUNGYWxKSWdlSUxucTE4enVuK2JzUFpyTEkw?=
 =?utf-8?B?QjlZNGpiRm5SVlBocGVOSEE0KzR4a2dHT3MxbWpZd0lhV0lOUmIyMExZOUZ6?=
 =?utf-8?B?ZnV0SkF6N3FpYVUyKzZNS1hrQWxLWVMzMmxkWElsSE1KR0w2TjJ5YWxtcU5l?=
 =?utf-8?B?OExuUXpGUTE2RGo1ZFZSZHZodnBnYzJRcDdzb3p0WVFzeHhaeXFyUm5HN0Zu?=
 =?utf-8?B?Z2tBYVdneUhZVDYwTk5zSFZkSzhDSTRKVG1xMlV1UUt4Uy83OHZWUjNZVXJX?=
 =?utf-8?B?NzBjanp0aythbmwyQ2JrR2hyeXliWVBsSlFJdW5oOFRSMUpFSVAvMndOQUJF?=
 =?utf-8?B?UVAySlNwbVVqMVgwYzdIdEhaV1VuT2FMQ3kzV2xZNkpPUUdqbDFDVTJhOXZz?=
 =?utf-8?B?SW1NUHdMK1J1cnVxdWJ5aC9wS29NcmRucEZmL0ZjelhudlNsK2tSbzB4OGUx?=
 =?utf-8?B?bit6blkwWWlZRlVGOTN1Zyt5c2tIZGJUVlZJK01XWkxYR3JWZXJnVTFnV2Nq?=
 =?utf-8?B?UFlYS0JzRExYSVR1MWkyN0ErUnd6c3lFcnE3VWtHa2ZXeDFTeVhFSGJwU1Vz?=
 =?utf-8?B?dkVsNkRpYUN4V0xFbzlTVGZpaWtUN0J3dFBHQnlkOTk3dGVrQlIyMXZqMGlk?=
 =?utf-8?B?Zlc4VENEYmRpaFhTU0U1SWhwakxSaUdHUlBNTDg4bEhTZDB3YkU2RVhuVitQ?=
 =?utf-8?B?VzZpMFdhMFlhNDloVG5VcDdNcVFLcWJiZU9hMUVJSjk5ejJzT21HcWVmMzly?=
 =?utf-8?B?Snl5eFVqUEJwZy9idnNDQUZFM1R6dk5qd25KQ3JqMGh5YjNaZ21pYUFVVTFo?=
 =?utf-8?B?dVhaRGw3L3M1U2tRb0d0UFBDZFhnZS8xblgxQnNvNzd4WHlSSEMwbndrQktL?=
 =?utf-8?B?bGt3U2hoUmljOTE5c09OOVJJRlRaU0lPaGJZdnl5ODA2bUlZeFAvN0ZSMWlS?=
 =?utf-8?B?a2FhSlZrZmlFMm8xREdCajJjeHlVbFRhVjZvN0FYY2tvdk5rQU9CejU0K3o4?=
 =?utf-8?B?L1l4dzZhdlc0RjJZNUtZOUFxVEFGNzNCV3RJSHpmUEVkZmZ5Rzk0RThWWVdZ?=
 =?utf-8?B?d3pMdWM0WFJvM2RncEN3RHF1Rm5Wa1RFc0kzODlTYWR1Ym1UOUNiUUVZRkdW?=
 =?utf-8?B?YStVZW5lVXlHanh6Wlg5QTJLWHVMRnVjVlNEUFBmTThab25tVDM0QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bda75896-6598-488a-24ae-08de8eea9180
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 05:58:44.9683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /WEWFn64A8+tlzaCdqgN2DgF2L8VYvNS91zdgfxlwSvJuEjJy7M28p2zPsEgncPyi4atD58OtS0dydOel5Tfkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8376

Hi Allison,


I think the introduction of type2 is weakening some assumptions of the 
core design, and this check is another example after similar ones added 
for type2. Not sure how this could be addressed properly, so I will look 
at how to make this integration seamless.


By now, as this check is necessary, at least as a sanity check:


Reviewed-by: Alejandro Lucero <alucerop@amd.com>


On 3/31/26 01:50, Alison Schofield wrote:
> Before now, all CXL memdevs were assumed to have a mailbox-backed
> cxl_memdev_state, so poison command checks could safely dereference
> the @mds.
>
> With the introduction of Type 2 devices, a memdev may not implement
> a mailbox interface, and so there is no associated cxl_memdev_state.
> Guard against this case by returning false when @mds is absent.
>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>   drivers/cxl/core/memdev.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 273c22118d3d..591425866045 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -204,6 +204,9 @@ bool cxl_memdev_has_poison_cmd(struct cxl_memdev *cxlmd,
>   {
>   	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
>   
> +	if (!mds)
> +		return 0;
> +
>   	return test_bit(cmd, mds->poison.enabled_cmds);
>   }
>   
