Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013029.outbound.protection.outlook.com [40.93.201.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E1151AEFB;
	Thu, 15 Oct 2026 12:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792068933; cv=fail; b=T94GwIffgNtvdo9VnHxnSaQMow3+P1jk1XjDZLRXMBrOA90AFNRSpV8zc9CHJfeMUOYtd4SnGrVyhaNM3aM8lculfjHa1cvzbSIuYfkiW54bFuQL1jiBSABX5yiwpov6pLlEXP7vdtlXzS58+PNuAgL84VhxDyrYY3DfPFPjZHc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792068933; c=relaxed/simple;
	bh=3DTI6VfBNAc/hxfuZS4wGNhqm9WnB+FTjr3YudrPuUU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R8QQFNSL+/AlY5Pnt6bSBrPMx4YRRAJsUMUwx6xLRszcdyTWLg0MUBDqVxzs88FX5FVvTcAw/RegOS+bOTk/RXcbtc1djzIeOJmt2SEGN1kki4K9yvDz5QfNtBT4mei8jX4QyPuCu7MsiGHuw/RFGUcTwdfhOXMP86V687Iv/SQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RC4tBcjq; arc=fail smtp.client-ip=40.93.201.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RC4tBcjq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wFX+ZEfG9wPgYxM4ZBaoGOSW8ywzGpSHNOMQjk8iaLTsg/HtaLXesvVUTu5njaYueb2YOx6RM3QNd5LV8ioU5eEtyjNxa0bw3A+oWhomzqm5lJXsaXeYVKjwCfr79dIuxAko7AO886NjIxvTGhFbzX53ngsfpMgpIqTuDbxbjw+5VZPGiZP05jHYG68Wp4W3Gn2fW2nyiJWUPoUbSn8Sw0vD3Yk4QE6OSOIHifljk9mUu976eKseUmsm8eqGzcS6iZJV2IeEDzqO1eUnhUvtE02xdBq20uQ3EoER2XymJ1mbIwV5bccHRw8KbuMlnUehINNLjEpeda3AV23jTVWGLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H60B8s5cxWsAm/A9Iot4RqFM61PmvVczYNWbEF75MC4=;
 b=UJbROv15/Hz9pzsvd+ZaPYviFDM8+gQk+GKXvuf2xUsTtxZzxxCFpz6E4HHKsSxQMpIctmrAb2QVHToZZ950c6o7FhGBMvUcBYWdy1ESUrXg94GnsN2eLgYkzZ48LdNAyn5XUfc3esBczgRkWzBMrl3w7LsSPd1BosTsQhveqkyoGKLLefvtMEoXALCmmdEvJFplYB2Zd/V/pYdMDY77COihqXukIQtROAUfOMZgL4JbFM8G2/7dsVQGVTx6hqlRwEq6RsxqLSHY4plU+V2WAKv7WSz3DJmTjaMxTHg0ADCU2h49gfKiAcagA6PImhgU6T4cAdWVKZ1Uy5uk6D6C3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H60B8s5cxWsAm/A9Iot4RqFM61PmvVczYNWbEF75MC4=;
 b=RC4tBcjqLc7FbyvtJxfo5jG0AoCFsnWi27YZAlkwqq0JZNSTYhgew1FrJl5bBrCSDZ2jtQo6gavFmlQtcPeKh//r2EzSOSgcZ1mYA0VlCEhDd9tu9HmTWCC2sEiwLex5afJiI1KlOrW0JAFEhSaGTwD9Ijr0Y5Jl+xaId2jBui0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB6254.namprd12.prod.outlook.com (2603:10b6:8:a5::17) by
 CH8PR12MB9840.namprd12.prod.outlook.com (2603:10b6:610:271::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 12:55:25 +0000
Received: from DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1]) by DM4PR12MB6254.namprd12.prod.outlook.com
 ([fe80::8211:9b5a:99d2:ffa1%4]) with mapi id 15.21.0522.012; Thu, 15 Oct 2026
 12:55:25 +0000
Message-ID: <1f9be2f0-952b-4cb9-8a7e-4c6323cc7874@amd.com>
Date: Thu, 15 Oct 2026 13:55:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/3] cxl/mem: Add explicit RAM region creation for
 providers
To: Richard Cheng <icheng@nvidia.com>, jic23@kernel.org, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, vishal.l.verma@intel.com,
 iweiny@kernel.org, ming.li@zohomail.com
Cc: kaihengf@nvidia.com, kobak@nvidia.com, newtonl@nvidia.com,
 kristinc@nvidia.com, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261007090540.43817-1-icheng@nvidia.com>
 <20261007090540.43817-3-icheng@nvidia.com>
Content-Language: en-GB
From: "Lucero Palau, Alejandro" <alejandro.lucero-palau@amd.com>
In-Reply-To: <20261007090540.43817-3-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0533.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::18) To DM4PR12MB6254.namprd12.prod.outlook.com
 (2603:10b6:8:a5::17)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB6254:EE_|CH8PR12MB9840:EE_
X-MS-Office365-Filtering-Correlation-Id: a1aa153c-498e-488d-bf69-08df2abb94ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|23010399003|56012099006|4143699003|11063799006|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	n6fs24znSEZh/Ti6mxWtSty6rUiAWhlnS0Gv3e/YNuvDCqVr3PJCymyUG59zYSd2T0Vcd/7rWCMQPOUKhDv4PPZkpAALgOtNCtwBBRpLn/ogRIOJ0jgkNuKgFWjmjmG45pwpXtT3QkDpeLEhiswTKy8AoZOJ6fguM7qnxNLDYwMXdTq1QZAnLF6DO6NdyVZwl7QOAoKxAagskuwI4IPdBleo5lGe6Y9WZraQIgzbOt1jjR/tpmHw5bs/LZw82ooo2ImHG0AjD+ZQyM3kh805PjkQAe6wpmIQV8UAIO0c9Qjkmon1ltlRT91QhSBG2OWUFGqEXvNdFOoQijHKTrbM2vDddivtZpgt2hpNp7HBjyKQk9toeGPeCVTlIx5sjvca/yQWV9QgcO80tt7VdUgGksxTs9tzOXrPKS3g3G1qMqIzfjJVsfMdmW2lnRF6Gw7DgqSrXwGM+jgO20OxCiR/lYoFIWUUpCNWXfRIlPNr1Tcuvu5sYHAc+QqwXklzOeJuzXymM2LJJMrUwp4VED5f2ew9kSVyLw/Aw8IqbJGuMV2Y9Qv6RPRiO3cWVf4WmSqR3OC03kBbN+Uz+Vk2orfG1opyX/tee2sd88LHmN89mRfo5Ygarmy1/Oaqkre5xMfhYlWBruhG+bw7zrq/l6yRx++gPxIzDWQZO5UNGcU43cc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6254.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(23010399003)(56012099006)(4143699003)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGZ1dXRXK2Myc1VmQ2E2c25SdUJjSWdkZTFYZW1XOHFrSFlWYW4xZEg3OGVX?=
 =?utf-8?B?QlZzamdSblg1RjFHV0VQMFFTTktJc1RHL3ZKRUViZ0NwUCtZY3FmaWZQNFlm?=
 =?utf-8?B?MzkvNzNYZGg0NUh4bkpycFRCVUtIWFFQdWhoNXlqYXdBSldjVGNrOEVDTEg1?=
 =?utf-8?B?Ukxadm5qeVVHU1RhMTE2bHZqeFpMT3NTRHE3bi9WbGhQcllXY2NpK24wVmJr?=
 =?utf-8?B?N3htZkRHNHFCZGdQQUVGWit0Rm1BQWgyYW92UXlUTzJJcnpjSnl3dGRraXN4?=
 =?utf-8?B?RTlWMDM5dEg0a2lKUTBGRlhpWkRhb2NBRC9XelN3Um5lRUVHcllwczVBV1Vr?=
 =?utf-8?B?WE9XNnZDam10Y1JPQXYraE9XdzRpR2RVWUY5eW14RDhocHk0c0lIOWFJMnM2?=
 =?utf-8?B?ampscklwUkdNMS9NOXFyOW9uRURvcmM4dEFuaGNva0kyd3Y0UDRBOVpNUi9N?=
 =?utf-8?B?cE5pK29nK2hDSnRDYnVHN09Bc2I0eStDMXdIdjZJZDBDMlpGamZQdmd4Umgv?=
 =?utf-8?B?MkN1cllBRlJReWlTMW95a09CKzdsU2dNMzE3SE1JdXZscGhXNDBLYnYvdzFN?=
 =?utf-8?B?dTlhOUdHZU9qZXBEUzd6TDNxUjVvcHNMbVlDRFpUek9XRjlFa0VVaGhoREJh?=
 =?utf-8?B?L1dMSkRkMjZxQWhTckNSYjdnc2VuV01kRkczZG45Tkw5cGFGQnMvK1hkUUdL?=
 =?utf-8?B?a2JBem1LS09RdUlmVWJ2M3dhSHJPTjFrVi8yUHNjais1MitoSGFFd3BZRDUz?=
 =?utf-8?B?RWlIREZiNk9hWmFxNXdSWXZ4cjRCQ0FSME5VTTMxTUJnZWwySFI1M1NTaFI4?=
 =?utf-8?B?eXBtamJWaDIzNUJsaUN1aytIaVI4eVhZaWNISzhzeTdXbGV0TDRDR2hiZm15?=
 =?utf-8?B?ZUQ0ZGRMYXJaTUlIUkgxdTdENXQxYWV4VTN0bWMweUF6V2RjNTRmRVVNQ2Fm?=
 =?utf-8?B?SGNnWk5OejNwS080aVFDT2dCTkwweGViZFlDOTRMcUdnaUNoemYwcE0vb3pB?=
 =?utf-8?B?cGxhL0ZUNC91Rmo2MXQ1ekVVOU9BNi85YkJOWVorNDJyOVNFNHJvdFhVYjB2?=
 =?utf-8?B?R0MxcnoyM2lXT24vTEFPUmR4c0hUQ2REM1VMTlVmK3Fidk8zd3p4aERFMVFj?=
 =?utf-8?B?aGVpakhMc29NNVo1bDIzVWp5Q3paS25kK0g4WXh2SEhnOTRzNjlQbW54SjNW?=
 =?utf-8?B?R0x3VDB1RjV0S2ZJVUsxdkdhd0xMMklsejNORXpwdjBxRmtVQW9qdVBJK014?=
 =?utf-8?B?eFMwWm1UWW42ZXdERUVzcEJoa0tvd3NWcHJFK1V2UXNNMGdNZEZHQ3QrSyta?=
 =?utf-8?B?Vkg2OGFhR3Z6RzdzSXkwdVdIMjk5anZrek92RkhHeGZTeWhEV2VUN3NMSlVh?=
 =?utf-8?B?ZVJGQTcyOUVCdkpjMnROc1UvdXhTT1o5RUREaFhVeit5dktBbXpVQU9uam1x?=
 =?utf-8?B?T29WdTFJM0o4RUVIemZYVHIzc3ludmJOa2J1UDBhd1RNcjIrN00zMXBQYUxx?=
 =?utf-8?B?TGt3MmFGcjhQaW1wbXdxejM4MjZLQkh1MG1Kb0ZDKzVPTWdaUndyeWdCYkNi?=
 =?utf-8?B?Ym9kbmJjUVpjVUZDb0Q4dE0vZ0RmYWxheVNnT0lKNzg1cExLYWpGZFUyZGZW?=
 =?utf-8?B?OEhocnpQS3F2azk3TTRvcFdnQU51SjRRWUdJdUhmbXFEU2YrUUlpSWYyMU5I?=
 =?utf-8?B?MGRjUHl5aUxYWHV5c2ZoQjJwSW1yS0x2TExsSjF2dStWN1FJbnVZU0E2Ykdo?=
 =?utf-8?B?NTZsZ0NDeFp6bUFzd2xWNXhTdnYzVVd1ZnY2OVQ0N2NmYSs1Rks3UmFxdDNh?=
 =?utf-8?B?WTZLdFd1cVp4ZjJCMlVqUUxZRkxXRUlHQjM2QmdGamZtTUNnTVprWE5QRURx?=
 =?utf-8?B?Uy9KVHEwOTNtOGxSWmowb1k4bStjZkJSZ1NoVmhZQnp3S1hHNlNRbmNHa2R0?=
 =?utf-8?B?Nk16aUg0dXFrMTgwRWU5TWM0UkR1SVRWejBYWU1UczhkNVJUSzlENG9ubXB0?=
 =?utf-8?B?UnhtM215UVgwR01WMjhKbGZHa2pEUTNhQmNaRklUYmtEa0UvVmV1UUtscUli?=
 =?utf-8?B?WnpEcU90WUFTaHpNWC9RMFNseXFKSFVYWlNMakljT1NVVHZwcXJqT0xBbm1D?=
 =?utf-8?B?VUVoWTBkWUpvamloalowbVM5djlDaW9YTmp0RHo3cHRPbHBUSDZoZi9HQ2gv?=
 =?utf-8?B?VnFwbzlnQ3EyRURWUE9MSmp4L0JsczZGQlBGS0xsWkd3UnRTQXNSa25rYzNh?=
 =?utf-8?B?alIyU052cURYd0g0cUdVRlZhVzd5ZzJNYkxKTHM4T0hua3ZQNlFqeXRpVlhN?=
 =?utf-8?B?T055OGsrZ01BZFd2RVMwaGR4UEZTVzNoR1NTOFgyN3QwcElkUWdrdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1aa153c-498e-488d-bf69-08df2abb94ae
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6254.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 12:55:25.3005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wJGI5UUoY1CUIpwEYVkUharH1fIVHS03RfuOkKtI3ZG8ASr54WddrStabIDQKT7KzjZ6D1zqbIanP/SXpCMKWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9840


On 07/10/2026 10:05, Richard Cheng wrote:
> Type-2 providers may need a region when FW supplies none.
> Add devm_cxl_create_ram_region() so providers choose the size and
> creation time after registering their memdev.
>
> Reuse core DPA/HPA allocation, decoder setup and commit. Serialize
> creation against sysfs decoder writes, unwind failures, and reset
> SW-created mappings on detach.
> Keep provider attachment separate.
>
> CXL_REGION_F_LOCK also reflects FIXED CFMWS root windows. Restricting
> the reset exemption to locked AUTO regions allows teardown of
> user-created regions under those windows to reset programmable
> downstream decoders, which previously remained committed. The root
> window and HW-locked decoders remain protected.
>
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> ---
> Changelog:
>
> v1 -> v2:
> - Replace implicit attach-time creation with an explicit API
> - Accept caller-selected size instead of allocating all volatile
>    capacity
> ---
>   drivers/cxl/core/port.c   |   6 +
>   drivers/cxl/core/region.c | 223 +++++++++++++++++++++++++++++++++++++-
>   drivers/cxl/cxlmem.h      |   7 ++
>   drivers/cxl/mem.c         |  31 ++++++
>   include/cxl/cxl.h         |   1 +
>   5 files changed, 263 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 6024bc9c1376..741240021cc9 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -235,6 +235,9 @@ static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
>   	else
>   		return -EINVAL;
>   
> +	/* Serialize partition selection with kernel region provisioning. */
> +	guard(rwsem_write)(&cxl_rwsem.region);
> +
>   	rc = cxl_dpa_set_part(cxled, mode);
>   	if (rc)
>   		return rc;
> @@ -276,6 +279,9 @@ static ssize_t dpa_size_store(struct device *dev, struct device_attribute *attr,
>   	if (!IS_ALIGNED(size, SZ_256M))
>   		return -EINVAL;
>   
> +	/* Keep the free/allocate sequence atomic against region setup. */
> +	guard(rwsem_write)(&cxl_rwsem.region);
> +
>   	rc = cxl_dpa_free(cxled);
>   	if (rc)
>   		return rc;
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 7a64a730587d..4cfa0a644481 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -250,7 +250,9 @@ static void cxl_region_decode_reset(struct cxl_region *cxlr, int count)
>   	struct cxl_region_params *p = &cxlr->params;
>   	int i;
>   
> -	if (test_bit(CXL_REGION_F_LOCK, &cxlr->flags))
> +	/* Provider ownership must not suppress reset of software-created regions. */
> +	if (test_bit(CXL_REGION_F_LOCK, &cxlr->flags) &&
> +	    test_bit(CXL_REGION_F_AUTO, &cxlr->flags))
>   		return;
>   
>   	/*
> @@ -374,14 +376,12 @@ static int queue_reset(struct cxl_region *cxlr)
>   	return 0;
>   }
>   
> -static int __commit(struct cxl_region *cxlr)
> +static int cxl_region_commit(struct cxl_region *cxlr)
>   {
>   	struct cxl_region_params *p = &cxlr->params;
>   	int rc;
>   
> -	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
> -	if ((rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem)))
> -		return rc;
> +	lockdep_assert_held_write(&cxl_rwsem.region);
>   
>   	/* Already in the requested state? */
>   	if (p->state >= CXL_CONFIG_COMMIT)
> @@ -408,6 +408,18 @@ static int __commit(struct cxl_region *cxlr)
>   	return 0;
>   }
>   
> +static int __commit(struct cxl_region *cxlr)
> +{
> +	int rc;
> +
> +	ACQUIRE(rwsem_write_kill, rwsem)(&cxl_rwsem.region);
> +	rc = ACQUIRE_ERR(rwsem_write_kill, &rwsem);
> +	if (rc)
> +		return rc;
> +
> +	return cxl_region_commit(cxlr);
> +}
> +
>   static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
>   			    const char *buf, size_t len)
>   {
> @@ -4111,6 +4123,207 @@ static int first_mapped_decoder(struct device *dev, const void *data)
>   	return 0;
>   }
>   
> +static int match_free_endpoint_decoder(struct device *dev, const void *data)
> +{
> +	struct cxl_port *port = to_cxl_port(dev->parent);
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_decoder *cxld;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	lockdep_assert_held_write(&cxl_rwsem.region);
> +	lockdep_assert_held(&cxl_rwsem.dpa);
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	cxld = &cxled->cxld;
> +	if (cxled->state != CXL_DECODER_STATE_MANUAL || cxled->dpa_res ||
> +	    cxld->region || (cxld->flags & CXL_DECODER_F_RESET_MASK) ||
> +	    !cxld->commit || !cxld->reset)
> +		return 0;
> +
> +	if (cxld->id != port->hdm_end + 1 ||
> +	    cxld->id != cxl_num_decoders_committed(port))
> +		return 0;
> +
> +	return !device_for_each_child_reverse_from(dev->parent, dev, NULL,
> +						  check_commit_order);
> +}
> +
> +static int cxl_configure_ram_region(struct cxl_region *cxlr,
> +				    struct cxl_memdev *cxlmd, u64 size)
> +{
> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_decoder *cxld;
> +	struct cxl_region *detach;
> +	struct device *dev;
> +	struct range hpa_range;
> +	int part, ways, granularity, pos, rc;
> +
> +	down_write(&cxl_rwsem.region);
> +
> +	dev = device_find_child(&endpoint->dev, NULL, first_mapped_decoder);
> +	if (dev) {
> +		rc = -EBUSY;
> +		goto out;
> +	}
> +
> +	down_read(&cxl_rwsem.dpa);
> +	dev = device_find_child(&endpoint->dev, NULL,
> +				match_free_endpoint_decoder);
> +	up_read(&cxl_rwsem.dpa);
> +	if (!dev) {
> +		rc = -ENOSPC;
> +		goto out;
> +	}
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	cxld = &cxled->cxld;
> +	part = cxled->part;
> +	pos = cxled->pos;
> +	ways = cxld->interleave_ways;
> +	granularity = cxld->interleave_granularity;
> +	hpa_range = cxld->hpa_range;


You keep these values for restoring if error, but these should be 
default ones for a free decoder. Shouldn't they?  In fact you are 
checking some of those values inside match_free_endpoint_decoder. Some 
values could come from init_hdm_decoder(), but why should we keep those 
for the case you are addressing here?


I do not think you need this but a function to reset values to default 
values for a free decoder. Maybe factoring out that default 
initialization happening inside cxl_endpoint_decoder_alloc() and reuse 
it here for the error case.


> +
> +	rc = cxl_dpa_set_part(cxled, CXL_PARTMODE_RAM);
> +	if (rc)
> +		goto out;
> +	rc = cxl_dpa_alloc(cxled, size);
> +	if (rc)
> +		goto restore;
> +
> +	rc = set_interleave_ways(cxlr, 1);
> +	if (rc)
> +		goto free_dpa;
> +	rc = set_interleave_granularity(cxlr,
> +					cxlr->cxlrd->cxlsd.cxld.interleave_granularity);
> +	if (rc)
> +		goto free_dpa;
> +	rc = alloc_hpa(cxlr, size);


In my series before removing this region creation option, the logic 
added since original Dan's patchset was to look for the biggest 
available hole. I think we will need a policy like that or just the 
opposite depending on what we want to preserve. The times when we will 
need this are not close so maybe this is good enough by now.

Also the logic there was to look for hpa first and offer the option of 
allocating less space than requested if not enough hpa where the 
previous commented logic about the biggest hole makes sense.


> +	if (rc)
> +		goto free_dpa;
> +
> +	down_read(&cxl_rwsem.dpa);
> +	rc = cxl_region_attach(cxlr, cxled, 0);
> +	up_read(&cxl_rwsem.dpa);
> +	if (rc)
> +		goto detach;


This seems weird, at least the name for attach failing: attach failed 
therefore detach?


> +	rc = cxl_region_commit(cxlr);
> +	if (rc)
> +		goto detach;
> +
> +	/* Added after DPA reservation so decode is reset before DPA release. */
> +	get_device(&cxlr->dev);
> +	rc = devm_add_action(&endpoint->dev, endpoint_unregister_region, cxlr);
> +	if (!rc)
> +		goto out;
> +	put_device(&cxlr->dev);
> +
> +detach:
> +	down_read(&cxl_rwsem.dpa);
> +	detach = __cxl_decoder_detach(cxlr, cxled, 0, DETACH_ONLY);
> +	if (detach)
> +		put_device(&detach->dev);
> +	up_read(&cxl_rwsem.dpa);
> +free_dpa:
> +	cxl_dpa_free(cxled);
> +restore:
> +	down_write(&cxl_rwsem.dpa);
> +	cxled->part = part;
> +	up_write(&cxl_rwsem.dpa);
> +	cxled->pos = pos;
> +	cxld->interleave_ways = ways;
> +	cxld->interleave_granularity = granularity;
> +	cxld->hpa_range = hpa_range;


As commented above, I would use something like 
cxl_endpoint_decoder_init(cxled)


> +out:
> +	put_device(dev);
> +	up_write(&cxl_rwsem.region);
> +	return rc;
> +}
> +
> +struct cxl_ram_region_context {
> +	struct cxl_memdev *cxlmd;
> +	u64 size;
> +	int rc;
> +};
> +
> +static int create_memdev_ram_region(struct device *dev, void *data)
> +{
> +	struct cxl_ram_region_context *ctx = data;
> +	struct cxl_port *endpoint = ctx->cxlmd->endpoint;
> +	struct cxl_root_decoder *cxlrd;
> +	struct cxl_switch_decoder *cxlsd;
> +	struct cxl_decoder *cxld;
> +	struct cxl_region *cxlr;
> +	enum cxl_decoder_type type;
> +	unsigned long caps;
> +
> +	if (!is_root_decoder(dev))
> +		return 0;
> +
> +	cxlrd = to_cxl_root_decoder(dev);
> +	cxlsd = &cxlrd->cxlsd;
> +	cxld = &cxlsd->cxld;
> +	type = ctx->cxlmd->cxlds->type == CXL_DEVTYPE_CLASSMEM ?
> +		CXL_DECODER_HOSTONLYMEM : CXL_DECODER_DEVMEM;
> +	caps = CXL_DECODER_F_RAM | (type == CXL_DECODER_DEVMEM ?
> +		CXL_DECODER_F_TYPE2 : CXL_DECODER_F_TYPE3);


I thought this was only for Type2 by now ...


> +	if ((cxld->flags & caps) != caps || cxld->interleave_ways != 1 ||


I think some of these checks are also performed later on when 
cxl_region_attach(), interleave_ways for sure.


> +	    cxlsd->nr_targets != 1 || !cxlsd->target[0] ||
> +	    cxlsd->target[0]->dport_dev != endpoint->host_bridge ||
> +	    !cxlrd->res || cxlrd->cache_size ||
> +	    (cxld->flags & CXL_DECODER_F_NORMALIZED_ADDRESSING))
> +		return 0;
> +
> +	guard(mutex)(&cxlrd->regions_lock);
> +	do {
> +		cxlr = __create_region(cxlrd, CXL_PARTMODE_RAM,
> +				       atomic_read(&cxlrd->region_id), type);
> +	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
> +	if (IS_ERR(cxlr)) {
> +		ctx->rc = PTR_ERR(cxlr);
> +		return ctx->rc == -ENXIO ? 0 : ctx->rc;
> +	}
> +
> +	ctx->rc = cxl_configure_ram_region(cxlr, ctx->cxlmd, ctx->size);
> +	if (!ctx->rc)
> +		return 1;
> +
> +	/* Region unregistration acquires cxl_rwsem.region internally. */
> +	unregister_region(cxlr);
> +
> +	/* Retry HPA window exhaustion; endpoint and DPA failures are terminal. */
> +	return ctx->rc == -ERANGE ? 0 : ctx->rc;
> +}
> +
> +int cxl_memdev_create_ram_region(struct cxl_memdev *cxlmd, u64 size)
> +{
> +	struct cxl_port *endpoint = cxlmd->endpoint;
> +	struct cxl_ram_region_context ctx = {
> +		.cxlmd = cxlmd,
> +		.size = size,
> +		.rc = -ENXIO,
> +	};
> +
> +	device_lock_assert(&cxlmd->dev);
> +	if (!size || !IS_ALIGNED(size, SZ_256M))
> +		return -EINVAL;
> +	if (IS_ERR_OR_NULL(endpoint))
> +		return -ENXIO;
> +
> +	guard(device)(&endpoint->dev);
> +	if (!endpoint->dev.driver || endpoint->dead)
> +		return -ENXIO;
> +
> +	struct cxl_root *root __free(put_cxl_root) = find_cxl_root(endpoint);
> +	if (!root)
> +		return -ENXIO;
> +
> +	device_for_each_child(&root->port.dev, &ctx, create_memdev_ram_region);
> +	return ctx.rc;
> +}
> +EXPORT_SYMBOL_FOR_MODULES(cxl_memdev_create_ram_region, "cxl_mem");


I think you do not want to export this one but only devm_cxl_register_mem().

> +
>   static int unregister_memdev_region(struct device *dev, void *data)
>   {
>   	struct cxl_endpoint_decoder *cxled;
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 8c050bc308bd..9f074007dbf8 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -123,9 +123,16 @@ struct cxl_attach_region {
>   };
>   
>   #ifdef CONFIG_CXL_REGION
> +int cxl_memdev_create_ram_region(struct cxl_memdev *cxlmd, u64 size);
>   int cxl_memdev_attach_region(struct cxl_memdev *cxlmd, struct range *hpa_range);
>   int cxl_memdev_setup_region_cleanup(struct cxl_memdev *cxlmd);
>   #else
> +static inline int cxl_memdev_create_ram_region(struct cxl_memdev *cxlmd,
> +					       u64 size)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>   static inline int cxl_memdev_attach_region(struct cxl_memdev *cxlmd,
>   					   struct range *hpa_range)
>   {
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index aa08d88ab104..00bd7d9fe561 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -241,6 +241,37 @@ struct cxl_memdev *devm_cxl_register_mem(struct cxl_dev_state *cxlds)
>   }
>   EXPORT_SYMBOL_NS_GPL(devm_cxl_register_mem, "CXL");
>   
> +/**
> + * devm_cxl_create_ram_region - Create a provider-owned RAM region
> + * @cxlmd: provider-owned memdev returned by devm_cxl_register_mem()
> + * @size: requested region size in bytes, a nonzero multiple of 256 MiB
> + *
> + * Reserve @size bytes of volatile DPA and HPA, establish a single-target
> + * decoder path, and commit it. The caller chooses the size; this helper does
> + * not consume the device's entire capacity or replace an existing region.
> + * Obtain the resulting HPA range separately with devm_cxl_attach_mem_region().
> + *
> + * Requires an unused programmable endpoint decoder and a compatible
> + * non-interleaved root window without normalized addressing or an extended
> + * linear cache. Persistent memory provisioning is outside this helper.
> + *
> + * The region is removed and its software-programmed decoders are reset when
> + * the endpoint detaches. Failure unwinds the new allocations and leaves the
> + * memdev registered. Returns zero on success or a negative errno.
> + */
> +int devm_cxl_create_ram_region(struct cxl_memdev *cxlmd, u64 size)
> +{
> +	if (!cxlmd->attach || !size)
> +		return -EINVAL;
> +
> +	guard(device)(&cxlmd->dev);
> +	if (!cxlmd->dev.driver || !cxlmd->cxlds)
> +		return -ENXIO;
> +
> +	return cxl_memdev_create_ram_region(cxlmd, size);
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_create_ram_region, "CXL");
> +
>   /**
>    * devm_cxl_attach_mem_region - Attach a registered memdev to its region
>    * @cxlmd: provider-owned memdev returned by devm_cxl_register_mem()
> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
> index 3019e3ea5f09..b873bd0cfacd 100644
> --- a/include/cxl/cxl.h
> +++ b/include/cxl/cxl.h
> @@ -225,6 +225,7 @@ struct cxl_dev_state *_devm_cxl_dev_state_create(struct device *dev,
>   	})
>   
>   struct cxl_memdev *devm_cxl_register_mem(struct cxl_dev_state *cxlds);
> +int devm_cxl_create_ram_region(struct cxl_memdev *cxlmd, u64 size);
>   int devm_cxl_attach_mem_region(struct cxl_memdev *cxlmd, struct range *hpa_range);
>   struct cxl_memdev *devm_cxl_probe_mem(struct cxl_dev_state *cxlds,
>   				      struct range *range);
