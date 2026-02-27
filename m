Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010053.outbound.protection.outlook.com [52.101.56.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B10B21D3F4
	for <linux-cxl@vger.kernel.org>; Fri, 27 Feb 2026 19:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772222021; cv=fail; b=H2rrXrnemncQvhtEJ+2vsXEi32aPK3YLx3scvlSk9CBq5vZXXRRtzRcxa405MvMnv448Rr0dwQDmSNer6V9zPdlSOeXaLV2ldHJpd0vGCEugF2pJKStTuLGO5n8skYem05elZQXvs0zhYqHtkk2h+9pV0aDEHwqCiP45WdDc61w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772222021; c=relaxed/simple;
	bh=mQQqU66BzSkbD2m5kQVq17I4cEGyGL4krlzLcD8YN6c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=D68AhMg3Uyb0Rhf160CWnoKuZuJG2MVe2WAfPnqJivNiD6TJxf8EZOfoqcJku1+1Q9pylA6RKn8X3Jxozr3JxWzrjqm/gUhnaExQMwkTLGRJdXCI7AMLUzXE9DCS/Wl396CWZmQLvDcOh7y6omtdkydIeIDeHjvBzIlrBe6wNB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dhsEZ1zb; arc=fail smtp.client-ip=52.101.56.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dhsEZ1zb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lquF6SS1mWe/NGbh/RpzSqT+jJRjDmK3NT20+PbFbwQLXYHgDDW9niBNJ5Y6urMHRY8kkubrMMF+if6rULN1LHm5y/fOB4ExEmvZ2z4TdFAsAZt/mHW09EKwGVqIU74VNmLboUeB1OGZxuaX/Y1ZXg0YbOkrWclGew2K+AHSUONRiBGUfS1paKWJAVb+5sv9dLtScWtAkUULiY86QKWBUpViaRSNej/rwytPFQFwkgrIyZWk68hejo8FyiNgbmmsrCzDE11h+Xjei/qBCA3Bm6f5TI3r9N6NqKIhLbup+ro28GIPb4GJSS1WyubiF7yE5IQdflYQ8gPxVpoMUddRBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zH1dmNghrzflU/nLSLJosafNVfULdNmXk8bEWm/nCLA=;
 b=XgEE1MrV+WoS02etEMNAxwUeIjZuYXVEdhXosHZqFhSvy79HEqN9BBuH+fvOJxIR9k4opqebDE77QFCRde+xOmlCTURY/Ow5xb7deH2ANVhOTanro5dHc001yqwBDMzlI/qi31otPAgiw218sM1I1uI0p7B0cD/2kJP4PCGIRCFQf9lfhf7/6P3zSyKYsKa9B6/ZloMX6qnXaFKjlJhXBKGafdWddzHZ/jPARPvwjh6PBd6s8CnpLe/RR1AdfGWQlfJ7K3UgfWSHzOjjqToqQ5TOrjtYOenl+s0tgpqY4tHg87fx1HEmz3POqr5wbV22ZudjZV5HVObrOMCnc8gI1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zH1dmNghrzflU/nLSLJosafNVfULdNmXk8bEWm/nCLA=;
 b=dhsEZ1zbv8RyIJ9S3m0BRBZ+IohkoDNOkU21uhoWIOmURyFM/yCRtdE68TyWCRksRjH3JEdVhDrBGLbHkNVNwsv2nQs9wG2MlUjbRdsI/hHmTUs4OLG4ksJZimfKWCTl3AfI9QJXaVaMlClcZn3s4StHpeGyWWue9PtVZruuMXE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MN0PR12MB6125.namprd12.prod.outlook.com (2603:10b6:208:3c7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 19:53:33 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%4]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 19:53:32 +0000
Message-ID: <039e6bfd-32bd-472a-8513-c7ebe7d59f0d@amd.com>
Date: Fri, 27 Feb 2026 19:53:28 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] cxl: export internal structs for external Type2
 drivers
Content-Language: en-US
To: Gregory Price <gourry@gourry.net>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
 dave.jiang@intel.com, Alison Schofield <alison.schofield@intel.com>
References: <20260225121430.3839189-1-alejandro.lucero-palau@amd.com>
 <20260225121430.3839189-3-alejandro.lucero-palau@amd.com>
 <aZ8WuBEAYBNIpSDY@gourry-fedora-PF4VCD3F>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <aZ8WuBEAYBNIpSDY@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0174.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36f::19) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MN0PR12MB6125:EE_
X-MS-Office365-Filtering-Correlation-Id: 8edec4e2-8e8c-4bf0-c9f0-08de7639e2ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	2hh7V1jBWLJP8F9B4bDQaNQRTDJ9mBEFoaoQjN7I5IprJD1Q0bgHvlAyPL/IqZoivyt7lXwMWyRZNrEcNadKIx8LFRlRFtopgzrMYKkHN3lDtnNEfJc1Qj58OSRujbS0pfqeEo9OmvB+QIIC2XWKncq+Ae5VJnMT17D8FV0hZUBzEBuyAooyMQFfP7IQRUXYs8CZ/RcnJHvUkG9XnsTgu1sMrIbkJHTmNrm5a8XJNOdDsjobpJJas8GKCMhXW/4CLbpxGBzZipmuYC7trvAPGIaMxhtqW0LMavNG+K8vj6zXNBdBF3MjeL+4MDw9JpLmNsMrIz3XtRZwO0glwPdsjTzbQ8urk6/Yn9zPVg4DbWA1RVDbFQYHwA+rFkSHh/kgfAZ2TFC7QT+hdbNTqTlxnHoNkp0pSlRv3TTNcQA09GkA52A9hM+1xV/Ck2a3aXJ6kS20Pa4ClvzdxaRbKWgohjek59Vj+NWDdLQ6cFyTslabnk5BlKTJMFWijruT1twnyM66E7h9/YOEEQr0DjRE30HPWv6Q//GKtHkMeLLH5efKaTG4SWM+rVx2G0BCxLitnEkRXxxG1OvLPgOu2GchhDMCnZS/t34zr4pmxtkbBkresq4XJm4u5yv5Uz9ljf9LFcW9ENMzenni50Jbv1Ly61zA9fwhzHtDGso8K+b8Z+y/fI7h1BvhfZhg0aFICgqCbT9MOasxWlC6y3VGd2zvRrQxiLG1Zi2LLzq07OlShkw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGRvY0ZCOFhBc0hzcktuRzNqcGZ6bzg3TFZ6TWFTUWdPZHYzZ0UzRDdscEw1?=
 =?utf-8?B?aWZVbjJMUmRlaDJIK0ZzU0lJenQ5SUIxLzdSOXU3T2VhSEV3S1JTalVlN1J2?=
 =?utf-8?B?QjU2Qnpib1YxdDNsaHk0T3lYMzVCY00wODQxbHE4S0JqVWVvMGNqYWhHV2Fz?=
 =?utf-8?B?RkJQUHpLT3BQK0R5N3dFS2JkYmt2ZlFuZEhGWmtpcUVpTXVWOFJBK1M2QTZY?=
 =?utf-8?B?OUFrN1pRVElWREpCRUUxQTRxMTdlcHRiTElzWFZZNWJid0lqU1ZLV3Fjb2ZS?=
 =?utf-8?B?WkZlejBrYWlvYmd6NFkrTjNIVEhwR2pScy81OThhRjhpVEt2dXZtT3lvb1JW?=
 =?utf-8?B?VHVUSlpYL00vVUhGNThpRXpBUU9saDZWM2RzeVBLMkR0YkVGOTh1Y3JaNVBV?=
 =?utf-8?B?aklvay9DMnBERlZ0bFNtTVBYMklNSGlIMERLR1NoVjBPOHRvVE54SU5FSTk4?=
 =?utf-8?B?YU1NdVhCdVRWdGdKTk50NVFITFpwb3RPMkFlb0svZWVjajFTek1WUThDbEZV?=
 =?utf-8?B?SnNlT1NMaHV6YjBITUQ5NE5hM1VtL1VrdUJPa3FrT0c5Wm9XZ2FKeERkbStK?=
 =?utf-8?B?TjFBRGM5Q2ZnRzdES1FNRDVFaFRYelFKZWI4eE96RHl1ZmVZdnhtVDE1dVFU?=
 =?utf-8?B?MVpmNE9oUTZZQVp1ejhZOU5Pb0Y1UDJROFoxeVVtTUtGcnZneEMvbitZR1dm?=
 =?utf-8?B?VlV5WlpTb1R5R3drYU9KMld3QjVLUVRBb2VON0RvZW90dzk0TGpLV04wZVM1?=
 =?utf-8?B?QUNNMG5RU1FRVUs4V2phOFl2QjdBNTVOVm5yVVBjcFlwNkR2Q0thYnJldy93?=
 =?utf-8?B?aU1lZER1YU9rUU4zd0FTRnpKNk9sU3QyTVRYQzdwM3Q5b2plR0E4dTZVWlZC?=
 =?utf-8?B?RGp2ZHUxMzNVRXJCM2orYTdzdU8yMFJMNkh3d1RiN3VRNnNXRkYrenVIU29s?=
 =?utf-8?B?UjdxNlpRYXZ3RnZSOXUvNHllVVljT2NPTHNoUHRHbTY0ZDFFLzU4K2QzOXdt?=
 =?utf-8?B?bTFSdEp3aGxBaUZBajhHbWtvYkViNTNFWlNVemNXQU9EODJVS3JjMjhwdVRw?=
 =?utf-8?B?Qlo1TVc4MVEzcWkwQVhOeEhwRFE1UWhjMTY4VjFybVFZc1RXWFROenFxZExP?=
 =?utf-8?B?MkdXU0srbFR0dGRXdlNBeXM4WkEzeUpSSDhjNHBpV1lwcVVDL0dpYXIzamgy?=
 =?utf-8?B?bHhad2NCT2FBeFFKbEN5Y2RjdnRFRFJXbExCd2QzZUxmcE4vZjhlNjR5WTJH?=
 =?utf-8?B?NUZ4VUZzTzZlTkNkZXJsL28yUlhGVGlvQ2sxU3NJQzFLdk5NNmFOQmRhaHZ3?=
 =?utf-8?B?TVhsWVhBWTJ3NmpOaXgweHN4SWZGQW5DRE95d2NSZ3lDalpWcy9DczA0bER0?=
 =?utf-8?B?N0ErdXV6MVVkSnUzbW9YeFBHdFcrQmE2S2w0VndpSUJuYS9ZUEkvTm1zSkxO?=
 =?utf-8?B?NlBVYUdXM1cxZU85UzB5bXorT1Y5WGpaTnJ2eHV6QU9iaHdTQ3g1N0ZpSzJv?=
 =?utf-8?B?RHBTZTdEdllmZjR4bXNkdnBFVkZvT1NKdGxYUVZzY3VlaDNiSkt4UTVSc0Zx?=
 =?utf-8?B?Tlg1bTUreCtMNnBBOU9TY25tcFlaRkEzTkFZNUswQ3ZSQkZTQ1dzSkRpcEdM?=
 =?utf-8?B?bXY4RmkrbXR4TFI1K1lDUDJBTlZScUFIMlpIb2FMamIrdWswNmNoSk1uK29u?=
 =?utf-8?B?a2Rpb2R0SnZmMEJOS0JvQUFBVklXc2g2RHRDR1NWWkJmK0lDQ3dUeUttMUFS?=
 =?utf-8?B?a0s2NkdrWmFTN3BGMjJSV2tuK2xoSWJ5TEhoNDRrQUhZbVJJdExONjU2MTdu?=
 =?utf-8?B?d3RvaCs5R3ZOOE1GY0g5cENYZlZjT1FvKzBDM0FxVXg3ZmtZOEVMQzlkcWFP?=
 =?utf-8?B?Z25GQUJWUEk1MHBSTEsyWDFhbjJod2FFY1lGNmwvUDZGSnFvOVlvYUpVdzk1?=
 =?utf-8?B?THFhYzNyZEhFS2h6MVJuMUd1VDhZTHB2NkZJYlYxV3pSeE1xYUV6SGFkc29x?=
 =?utf-8?B?V3c1Z3ZESHdsZnhycmRTSlZvV0hKajBNYlNIdEtiNExjdDAxRWgzV3JWQk02?=
 =?utf-8?B?TmtHUDhrL0lybFhqZzVQWXlCYUd6RE1PQ0lJTUZEc1VNNml2UzhURUlyckMv?=
 =?utf-8?B?c2lVTlV5SDRCclRFcnZLQU1lZCtoZWZ4UXZKS0ZXOVBVQ3JiSzNkWGFQUzV2?=
 =?utf-8?B?clZsc0ZIZXVxbFpXVE1XMnc3UkdGdXM1V1pkWWdqM2QvQ3hyT0d4bGFROUlk?=
 =?utf-8?B?UzYybDUxdU5VcWlRT3cwa3lQN3N1TEZ2bDgyRmtmeXg1ajRrbkNJd1dkanUx?=
 =?utf-8?B?T2FMUmRJTmJRSG9NVzZXSTVDVUpFZytGVkRTMWhXeTRxa0p0OUUxQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8edec4e2-8e8c-4bf0-c9f0-08de7639e2ed
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 19:53:32.8673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4wdmwHNlgTw4cKrAERnOxw+YyKtm7Dm/9WAp8Y0qJ+0YOysMRfhDAZ9cPRMssCm/oNgUdv+52/8ucAeCReei4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6125


On 2/25/26 15:35, Gregory Price wrote:
> On Wed, Feb 25, 2026 at 12:14:29PM +0000, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
> Mostly two nits
>
> Reviewed-by: Gregory Price <gourry@gourry.net>
>
>> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
>> index 04c673e7cdb0..0d350b69f1c8 100644
>> --- a/drivers/cxl/cxl.h
>> +++ b/drivers/cxl/cxl.h
>> @@ -12,6 +12,7 @@
>>   #include <linux/node.h>
>>   #include <linux/io.h>
>>   #include <linux/range.h>
>> +#include <cxl/cxl.h>
>>
> ... snip ...
>
>> diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
>> --- /dev/null
>> +++ b/include/cxl/cxl.h
> ... snip ...
>
>> +#include <linux/node.h>
>> +#include <linux/ioport.h>
>> +#include <cxl/mailbox.h>
> ... snip ...
>
>> +struct cxl_dpa_perf {
>> +	struct range dpa_range;
> You dropped linux/range.h from the move.
>
> Probably still builds in most cases since range is likely included
> somewhere else deep in the stack, but correctness etc etc.


That is right. I remember some issues with this. I will add it again.


>
> One other nit, you mention Type2 drivers a lot in comments:
>
> +struct cxl_dev_state {
> +       /* public for Type2 drivers */
> +       struct device *dev;
> +       struct cxl_memdev *cxlmd;
> +
> +       /* private for Type2 drivers */
> +       struct cxl_register_map reg_map;
> +       struct cxl_device_regs regs;
>
> Is it reasonable to think that these would be public/private for *any*
> *any* driver building from the public headers?
>

Those comments were explicitly added by Dan. Any external driver to cxl 
core should not use the private ones.


Thank you

