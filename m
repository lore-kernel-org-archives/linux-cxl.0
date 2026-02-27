Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012022.outbound.protection.outlook.com [40.93.195.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D4427FD52
	for <linux-cxl@vger.kernel.org>; Fri, 27 Feb 2026 19:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772222367; cv=fail; b=DhlmBZySbYCen1PI1EqpzxtySLvmoaNizKl76y/hBg4HtyPTGpJegKTk2L3EJyayQOKiKnKFF9DBMF5m7UWvsRCMPc3ZUbleGJYCuWm/hktLpjEiOWGDK+QInsw1SwjqgiZPv+7L7XENeLWZqLzied249NxeBC+P+TAcA4eoWu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772222367; c=relaxed/simple;
	bh=OezQCG51YYeosPvGslr4iTso/ycEtbDOGJSeLLPnwhg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fhq8VpqQRYZhxfZU+CfLSMjqggnaEwCS1YQq+Zs4m49nbKCh6P+lQnJlPI4hRrPAfi8pUZC3UlKxtfbY3fIz/E2Gamab1JydzKoc/jOqsOCcR6+py8eVIWcLs48q7uvnObLg18NEYtU3x4XmuQQELhXR5pPDXuxDMjI0FvACP5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bKA3FMTw; arc=fail smtp.client-ip=40.93.195.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bKA3FMTw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LXXCjZAAz0im39tO80P7Zv5OwLAefruGG/QhmIGjyqGgMOm1faRSBZ14WF5yd8rrCTfKJ9mSz29MPv77yuJsks+3xwNNpaB7wwPdJDnqyGCtB8JIms/6my2Mt58rC20fN+kPXDshmkjz0HZ5CHGQ+rpn7n/+aU0ytMeUeQBjqoTolxY1F/8PP8zm+3n9W7ScSlhRNIBXIMlAjZSDWkEEZjZu6fQiBYmKHV+/pEvVEzOaqa3fVNE3OX3bTCjUVZKbVBdg0XdXikETdgZ0Dkj/PTq0Oq9VL/gOgvd53BMndTzdLma6I/ZqRitE0/jhKN8I5gLQgNQ12h4Sz0Ptr7Hewg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uyF+VeMB5msy9p9Z3OE1UqokVd4uDmuGyg5qPj9CYTU=;
 b=yczSEI4B67RkicWMxUSzzfjsFMTk7zU4O8Sh5ZQ5CUKK70krqq2sSIAhQxiiX2+1dWYEqb5xDOGCYKqFf7yHURMozzCU0aE5xhyM0gy+xMCvdr0jJ6c678ctE4t3Z3rw7HCZBEy2wbIeuuWJJiDwl3au8ucwjKmWPmvRb2kpGKbgnTEZGnQCzGksw/bZOrfZVzOAxt/sVo/gl6kwmr2ACvlbDBJMgUsqtHeBu0dvyhTai0D6hf4Mn/iMDib8xNpVoG8il9K1D4AJhLAklPk4NOkltg5OvkS4fPClB/AFC4o7y07+aRJMn7khKyvqFvBBdpZtapsEGDe5TQr3JVcM9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uyF+VeMB5msy9p9Z3OE1UqokVd4uDmuGyg5qPj9CYTU=;
 b=bKA3FMTwWlCa8Ee3YCK809uaYXdiE1PeMLqtI+AKh2r7zheGJK7MiyBZwJyKPsUlVBz5dEw1eJCrJGk0H+m6QTR2ZZj9peeg1IhJUV/Z9SYGBqifhuzC5VrgXw8oLCmGN09uyHoocFUBwPl9VfhiocVBrT6Nh0RzPIbi3W7iPsA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by PH8PR12MB7229.namprd12.prod.outlook.com (2603:10b6:510:227::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 19:59:23 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%4]) with mapi id 15.20.9654.014; Fri, 27 Feb 2026
 19:59:23 +0000
Message-ID: <c3d22e56-8762-421b-acfd-1b7dabdc17f3@amd.com>
Date: Fri, 27 Feb 2026 19:59:19 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] cxl: Move pci generic code
Content-Language: en-US
To: Gregory Price <gourry@gourry.net>, alejandro.lucero-palau@amd.com
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, dave.jiang@intel.com
References: <20260225121430.3839189-1-alejandro.lucero-palau@amd.com>
 <20260225121430.3839189-4-alejandro.lucero-palau@amd.com>
 <aZ8cp4_xhEspZxwX@gourry-fedora-PF4VCD3F>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <aZ8cp4_xhEspZxwX@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0090.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::23) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|PH8PR12MB7229:EE_
X-MS-Office365-Filtering-Correlation-Id: 57c4b566-8ca7-48db-674f-08de763ab3e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	WaTVL8QJ60cW5LK28HC5X36JZhWQV6qwEP5IU4jXC6xsNiAIKC28/OtT+kp6QJ3R0deOizFTMaYZcwQtFbZC2+CsFdgBxQI3S+nFtWc2sghBEI8SHCqXBg+CiqEJbgMbOMuym6k72eSkCyg4ldsEm5imEw5jfPul3aCTg+lEyuQ19vwLIfohFB8IIMZDP9bjZYGlV6rwUp+EgYUgXXPk0jo2tyC/cy56y7D+m8X4/ukbMmejOXkOpzeLE13YfIjb18uYSVt9sQF5iqxgwVXmG3gUa2FdvlCV4CVj3BP13lSlvXkg6gG0bnL41d00q5/AZjWwPCubkYajQffgeIJjGxvzVvHmecdKkqr/ryjJoNPtrGCjbo75s/3zqT17MlNvaUN9e7nzUd4QebRGbEz4v7ZeEZ5QA8UGpZDMEPTX0Lqu/NmQdtrc7avXbrIA4SId5MAzPB+mo7IxUF1GvP/Md7dlxE4ECUxlvlttzXitnjmxft3YcikXXUf9n7QHx7lbIfVRfwtp8sjDJV6EyU5S5WnpclusjFRB5Sv4Gya+UiJQubbJlRcQ43igbc6k/as+LYsHEdPWyNXlTTA5b/bsFlv03xKYFt2yzYvs8bDlTepi2qRkTdD+6e37rr5WuuikiShubzdAfod+A7gExa40ft0wQ5H8UdI9HBoIof/ucd7H3nnXMjPyspV2Pburz3FYDKktdIdd4HehcgltsHD1Fv94y8iuUEQmEbeftTUEdnU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REE2ak9IdDd0Y2VuWEFSTGQ0T2c3NGJNblp3eGthMEdrNStxYXFoMHNUZmZJ?=
 =?utf-8?B?VVRNVWpXREVnSDJ6MElUUFpRYmE0US96bW1IT3RJYTRuSWxsZ0Nya1ZTSHJ0?=
 =?utf-8?B?eTB6c2k0QlorbDNYSFcrK1drR1d6Q1VkNWhpTi8veUpYT3loWGZMN0xLVlhp?=
 =?utf-8?B?bEY3WnMrOWZUYUtIOCtTSGtIcWIyc2lZSEp4YWw2M05mNFFoSEsrZVBselRv?=
 =?utf-8?B?bWJjUDg2QWpXNEhPREJNUlliRnMrRDhQOGMybXRQeTNMVTFRU2k1aGhrVmJV?=
 =?utf-8?B?UkFPalBMQi9CL1FrRHA1N2hqNW9CeWVoYitqeWtneTRmYjZvZU9uVUQ0TW55?=
 =?utf-8?B?NjFJNnU5WmhlZ0tuRnFkLzRpSE9RRkRkcmdTR0Y2OVBLZUJwYmdzcmloRFM3?=
 =?utf-8?B?WVV5N1c4UXNYb2pCVExiNXVWMHNySFZ1enRPVzNITGZYMmJSdUFUWWZJK21y?=
 =?utf-8?B?QUdIL0JSTks4WVdSUUtETm5iQ1V2c3o1RWt6Z2VVMXdWUy9oaXUvdk9Ndlk0?=
 =?utf-8?B?MUVRWXdmUjlXMVl0ZWc2Ui80WTIwb0o4NjRveGowaUgyV24rT3FDSjNCQk5J?=
 =?utf-8?B?NGg0bkFRSXBhajlDN1NWbE41Y0xNOVcrc2ZNd1N1YWZLSThnK1hEdjV2b1Vl?=
 =?utf-8?B?aVFWMmhvamg1K1FTalpWZUhCYmYvWTR2SXVDYmdWRUhzd3ZOQ2dCQ0ZXYy90?=
 =?utf-8?B?TFNmYjUydiswdW03L2pmZjdUOGF1WGRhcG1kZER2bVlrZzZLQWwrdmlScDFB?=
 =?utf-8?B?VDRIa0tEcHAvZjlqd1VHaFZPQUo2TDZ2anFyZXlEODA5RC9VVVk4U3FBUUta?=
 =?utf-8?B?b2VjeEdDSkF3YS83WlV4cjRtdkgya3VHWnJZNnlkN2FDajRMYkxaL2dPOFRI?=
 =?utf-8?B?ZFgweDYwOFhpQTNsbzc0anZRMm5WSFVPUGtsZnZ1Qjh0L1ByUXdLSXdReVlH?=
 =?utf-8?B?UEUxajlNemlnRnUwNTcySW5sQTZaSjRWbEdEdWdKWVhNK2hQdk1qL2pPQjZG?=
 =?utf-8?B?cDkrTXdYNTBvdjk4aVlsbzlWVUhvbjVlWlJiMzYrUm5FQWZIRTlzOUkybmNy?=
 =?utf-8?B?ODh4d1VLRi9nWUw3UmNld1Z2emgvL2U4ZHI0MEVJcy9IQnMvUUJZcWUwZk1U?=
 =?utf-8?B?eTJaUTRVejZxcDZ5Z0xBMGllOVA1Q1lqWTk4RVI5UlUvdzhjbkVxbXMxMGhq?=
 =?utf-8?B?MlNFVnJJWi9NN0J6dkg3VjVnRHczaEZzYm5GOEsxWEVwL1RGdGtaRUJheDBu?=
 =?utf-8?B?UVQ4UVNpVXA1aXRtcENyUHZmTGxPbk5ZTTRnQ3h2QUNhc2dVRnVwQThNZytV?=
 =?utf-8?B?R0w4cEZEWG5IQXBNQit1OXZmY3A0aUNhQ25FMUIxMmZScnA1aWlVQ1hyci8r?=
 =?utf-8?B?R3krQ2c3RGlDdjZxdDVxd2haQWM1SWtZeXBLV1RUNjFaUHhpMjREM3NFd0lJ?=
 =?utf-8?B?czNuaTNPbG9DUUROWllYKy9rSGdVQWFnS1NTeWRLTE5ybUFqRVBiTmV5cTBv?=
 =?utf-8?B?ODlwZEhnZnJNTmJuQlZUSW9FUXdxNzNKeFMzdG5ib2pTeE1VaWZaSXF5RjVN?=
 =?utf-8?B?bGFyaGdDVTRBSVR3Yk0rUEhpLzJUeDhXL1V6N25FSXRLRitYQmNFWFlkTkZN?=
 =?utf-8?B?RW8vLy9aSGJ4MWNCNkRqRmdZa241cXp6MnpCVUhVMEN4QUYvSVpoQVRNa1Vl?=
 =?utf-8?B?OEgyZDZlVCtsU0htMlNPODZPUzBkS1E3cU9OdkozT3Z0UjQ5UXVNN05OcXNl?=
 =?utf-8?B?VEhMQjl2MThVUEswS0xMajdRcUVKS0xYajVsMUdxMXpLOEN1WC9DendqMmU0?=
 =?utf-8?B?WklMMlJLa3NQUVFHNStpeFpKdVZtSkRUaWk1TW84TjRBQUJWQWxqN0NoRXBG?=
 =?utf-8?B?S2Q2OE1GNDFEWElNZHNJRnVKWTJIWXdreUt5Y2ZUWTVhc2dpMnVpUU5wRG0y?=
 =?utf-8?B?REpydU9OVmkwdi9ueGVhdVZtd0tRcldKMGxvUWUyQVBRR3paL29telBvVU1h?=
 =?utf-8?B?bkF6eXF6bFpPKzhVRmVIMVBFVVJTTzJOWW5oajR4UytWMTUvR010bDkybG15?=
 =?utf-8?B?Z0RaSzdkd0FNWHFiZjFmZXhPTjd5VkNYMjNwWWlaVXBpdHN2K2hLOXFyaXNi?=
 =?utf-8?B?b1hCbkRyd20yWEVVZk8xc3BQZytwT2V6bXA0THJIRkFXNkkxalBPajZrb0Ri?=
 =?utf-8?B?MlVjTy8zOGkzK2RRLzVWb1ZpaS9pdEd3L0M2S0VpajV5dVkxWW51K3hYeE1Z?=
 =?utf-8?B?Y0twZDl3SkFZTWNkeUM5MmxGTHlqYUs2NVBkWm55ZFZyYlFhanRmTEY3dUdv?=
 =?utf-8?B?WnJsNU1aZU9yVmpQa0ZiaVEyV291SWNZQnBUNmRxaG1uZUxoUldSUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c4b566-8ca7-48db-674f-08de763ab3e9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 19:59:23.3044
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zkh8GAE4pViUP5hJotIMzXVysM/KyfKWKPq0qp2ZQzofByAruFgujeWw4tchxJ77F2V0ZzbVw1RCPuJ4DnDv4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7229


On 2/25/26 16:00, Gregory Price wrote:
> On Wed, Feb 25, 2026 at 12:14:30PM +0000, alejandro.lucero-palau@amd.com wrote:
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Inside cxl/core/pci.c there are helpers for CXL PCIe initialization
>> meanwhile cxl/pci_drv.c implements the functionality for a Type3 device
>> initialization.
>>
>> In preparation for type2 support, move helper functions from cxl/pci.c to
>> cxl/core/pci.c in order to be exported and used by type2 drivers.
>>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> One note for existing code so not a blocker (not really a bug)
>
> Reviewed-by: Gregory Price <gourry@gourry.net>
>
>> +static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
>> +				  struct cxl_register_map *map,
>> +				  struct cxl_dport *dport)
>> +{
> ... snip ...
>> +
>> +	struct cxl_port *port __free(put_cxl_port) =
>> +		cxl_pci_find_port(pdev, &dport);
>> +	if (!port)
>> +		return -EPROBE_DEFER;
>> +
> ... snip ...
>> +
>> +int cxl_pci_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>> +		       struct cxl_register_map *map)
>> +{
> ... snip ...
>> +	if (rc && type == CXL_REGLOC_RBI_COMPONENT && is_cxl_restricted(pdev)) {
>> +		struct cxl_dport *dport;
>> +		struct cxl_port *port __free(put_cxl_port) =
>> +			cxl_pci_find_port(pdev, &dport);
>> +		if (!port)
>> +			return -EPROBE_DEFER;
>> +
>> +		rc = cxl_rcrb_get_comp_regs(pdev, map, dport);
>> +		if (rc)
>> +			return rc;
>> +
> we call cxl_pci_find_port() here twice on the same pdev and pass the
> dport into the second caller.
>
> Can something actually change between these two secnarios?  Seems like
> we can just drop the check in cxl_rcrb_get_comp_regs?


Uhmm, I do not think we need the second one inside cxl_rcrb_get_comp_regs?

I will drop it and mention that in the commit.


Thank you


> ~Gregory
>
> ---
>
> cxl/pci: Remove redundant cxl_pci_find_port() call in cxl_rcrb_get_comp_regs()
>
> Remove the redundant port lookup from cxl_rcrb_get_comp_regs() and use the
> dport parameter directly. The caller has already validated the port is
> non-NULL before invoking this function.
>
> Signed-off-by: Gregory Price <gourry@gourry.net>
>
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index c32cc62c501d..d1f487b3d809 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -707,11 +707,6 @@ static int cxl_rcrb_get_comp_regs(struct pci_dev *pdev,
>                  .resource = CXL_RESOURCE_NONE,
>          };
>
> -       struct cxl_port *port __free(put_cxl_port) =
> -               cxl_pci_find_port(pdev, &dport);
> -       if (!port)
> -               return -EPROBE_DEFER;
> -
>          component_reg_phys = cxl_rcd_component_reg_phys(&pdev->dev, dport);
>          if (component_reg_phys == CXL_RESOURCE_NONE)
>                  return -ENXIO;
>
