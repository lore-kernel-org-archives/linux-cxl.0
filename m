Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2080.outbound.protection.outlook.com [40.107.95.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BEE1E25F8;
	Wed, 29 Jan 2025 18:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738174676; cv=fail; b=s/MRknWlBvvquFLJbMB40d8GtIR+CRq80mYfwweUjzhj9un0ZijbPHkF82+88gC0GWvqmTdEhmy73c0bob0kq2vq40lf8DQ/0zrd63x8L2ixRF8IguGG14KgCIy0PA8tj6McDiE0/7fp7QweuWRjbJXxxtPKWm5dIYu5JPmvYsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738174676; c=relaxed/simple;
	bh=iQhMey239t6JNIrQIDR9BI6PyOyWtwRoTlrlomZB5Ug=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GjC68nDeONBAvqzmqoVVpQALsMUQnCjQDYbM+ikRuWcG5NYc+frqjylZDFbBH0xeAu2nPwI31qqBR9bjNb2E7w63W8Osf00AH3C6JktipKNsI8oVYRq0th8IFng442MPSCvs9QQDndKTWr2VLPFSfLS8nb4U9Wtb0kGpAbl4T2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HkjWMhSG; arc=fail smtp.client-ip=40.107.95.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HkjWMhSG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G6TGsYDV8APjKUJMJvEryrEV27eTal8HCl4aEm4aHvYJO/bvORpvW3yMVfhdALCnhT732YHJ/Zq8MUEY4xs4Kgw9niQJ4QUepIHbAmBWAi6YVwWqhCy11vqdVH0+qqyFBUDigRp30EYNle4a8lSeHSuL+jEf8CjqA7V6WSp+2QjAHprfodwAnd8mz5gAquo6krwB8TyHrVL8fNvB/BU8pUBGmZD5pajQBsK/2wNVtd0YZZzPhGYDUXN0My2mnluNIYlFmU6bHUs73NlU4fmTWqkylkfMPEgUbxvYCNMg4vN7bYczvkEIuDeEJzcF7BUNRoIBy3oFrl+VND+kJxh4Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKTiQqOYCN8KUGFxlyAUNZlvT8bnzBi5VdjpcHsXA7U=;
 b=POldmONC2xEE36q4kk1EDtLxzSbhECDCC1rYy9SZq+TtJ5/p7kS0zmInrtJ2t11l8z28eBXVrdiKniMBWBpUaxUMo7uKlHFOxTb3lPkK2INlO2EHyp+/OlLtWtlqdhuXLXzIrAKpZRuJa4M7Sx7tmhT9mEovUseXYX7jwGbiIH78QRqPIFLI6rFLCY2H/+8rE+5R/xfCN3wSNTVzJYTpU/+HYdb1iovSLs9w6otsS9T685enqUslYSTMWZJwNPMw/OssyYLjEcYY6nX4dlwd8AFgkiqswQL7QbfgK83+uxuMYBkRBP1A1F4R0W8EbfLJ1IgQHi3Q20N55qDU4tg4+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKTiQqOYCN8KUGFxlyAUNZlvT8bnzBi5VdjpcHsXA7U=;
 b=HkjWMhSGxMmj/uij0SZtKnY4xyVV4W1hReSxYQfqwswkMVBhXFbrVkB1iPkeXPICCDicWTc4G8laWiOSQWiOocWCb5j3ItM0TNJ02D8sGhk9PM0Z5uCN59AmozFo/PUSvkR+DMR54YoiDuP5FIk+XHY0UTlIYoCS3v98uXv+25I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by DS0PR12MB8480.namprd12.prod.outlook.com (2603:10b6:8:159::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Wed, 29 Jan
 2025 18:17:52 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%7]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 18:17:52 +0000
Message-ID: <074f421c-1f2b-b92e-3e92-c3974f9f471f@amd.com>
Date: Wed, 29 Jan 2025 18:17:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH RFC 2/2] cxl/memdev: Remove temporary variables from
 cxl_memdev_state
Content-Language: en-US
To: Ira Weiny <ira.weiny@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250128-rfc-rearch-mem-res-v1-0-26d1ca151376@intel.com>
 <20250128-rfc-rearch-mem-res-v1-2-26d1ca151376@intel.com>
 <783abee1-e06d-45bf-2dc9-920c729978de@amd.com>
 <679a582927d8b_1e2dd62943e@iweiny-mobl.notmuch>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <679a582927d8b_1e2dd62943e@iweiny-mobl.notmuch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM9P192CA0003.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::8) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|DS0PR12MB8480:EE_
X-MS-Office365-Filtering-Correlation-Id: c1db2f3c-e7ef-45ab-a2a8-08dd40913ed8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eFZSVHc5MVFKR0ZGZ1ZxUzRjSzhXR2Y1em5XVHdQZmV5dTYxV1haY1FqZGtO?=
 =?utf-8?B?aXM3YUNXWEFlT3JWWTJYVlhtNWpFSXdGSGxzRXNCQlNwR0lCdTIwV1p0YzBG?=
 =?utf-8?B?enJSekErdWpvY0ptM3lQclJoTHpMd25lUUIwWE0ydHJPbTllZ3ZnclA1c25Y?=
 =?utf-8?B?SkwvZlZjaW9iVzhjRzV0bnJ2aGRJWW1rRCs0R3JxeWpHRS9wMmJjdFlOcFg0?=
 =?utf-8?B?T1gyNDQ3UXdZU1JERDZoR1ZhdkR4YzlQemw5d1NpRGFCbG0xYitWSjRDTkJr?=
 =?utf-8?B?VDFCSXFiN3hNd3liTHlIYXlrTEtZQk4vVXJKSDZLTHZEWWtiaDdyNlM2ZVln?=
 =?utf-8?B?UmRHaW9pU2Q5K0FSZ1FLR3c4RGNqRFY0VWFqNDM4ZnpwcHNLOXlHdHE2RWZl?=
 =?utf-8?B?M3JveUQ2TmZLMnJDZWFrOFNmNWdNbHZQS3Y1RnI3RHBpdmVqeGkra2JuOW5J?=
 =?utf-8?B?dENTdkhzcmlnVUM1TC9hZ1dQc1o2OWhSUnYyTURTa1VCQmJPN2Z1MG9XV1Vl?=
 =?utf-8?B?RDZ1Vkx3cVBIbmNPWG1JMTlGNWRIdGVuQ3plcmNINkUzTm9aNHViZWg1dkRK?=
 =?utf-8?B?OG1veXk1NFJMTUJ2aWlVRXN6dzJXdUswVFFBeTNrY1lBNEJDaTAwWmZVS1hi?=
 =?utf-8?B?TXBiSnl4Mk9nMzY1dTdTNjNTbERyTktvdkxrbkNBZ29JWmgrSWNWVEU0aTlt?=
 =?utf-8?B?TTdBcW95TGNHV0JIOUZuMm84RXhOZjlSUlVNRmZGRDIxTHRyZ1k4dHlYb1N2?=
 =?utf-8?B?OHZsUzVRK0V2cGhsbW10Q04wVXNwcklDcXNwbkVRQnRQMklqa1Nwd043V1dF?=
 =?utf-8?B?Vzhadlp6cTdHUVV2ejhwOG1pYkxNVVQ2N1NGMG5sMzU3eHRTM1NNUzR3bWpk?=
 =?utf-8?B?MkhTbGNtaUdxZzhobkw2RXcwdkJ6VHcyOGlSN1J3aWt0Zll3dEFJSCtsRkFP?=
 =?utf-8?B?VzRxUHlIaWNlaXhOV2tkRVVaSXdrd2tQbTkxTTdLc3VubVdwTk1QZm9vQ0JI?=
 =?utf-8?B?L2dRRWxJeEg3a1FEYVkzRDBwblgyT2gvUnhwMmI1bHB0QWdCREtwM3VNN0s3?=
 =?utf-8?B?ODRWNUpqa09LaDlvem1jVmNWc1Q4cThVcStKcG56cmYxbVF5MXlrV0E3NWM4?=
 =?utf-8?B?U3dja1BBMkxWV2MyNnJmalBnTTk2VFE3ZmhBSkhYUEVRWUlnNDVLVDJSSHQy?=
 =?utf-8?B?MmtrekErTURXNUxDWFVScUhnbHN4SGVvNzdLOHJFb0tHMWV2TldHNis4NVEr?=
 =?utf-8?B?Zm5VcU5oZkFDaWhLT0crb1Y1T0NqRmxObzZlNXVzakJKOGNQUzRIS203dXlT?=
 =?utf-8?B?VU1qelN2Z090cDl1Si9qcEdGdFhJSlpUVjNUODJiYk5zeGFBU2t6bURkaGN2?=
 =?utf-8?B?MkFnS0J2ck9HZzJNUFNUWDZsNVI5eXgzQ2JweXhoMHYyaFJURnNwcUF6cWpv?=
 =?utf-8?B?ekM1OEdaOEIxMEpTZ2JEUGFaNnNiUDRHLzB4QlNvQllSK21mVGVOS2xaMy9V?=
 =?utf-8?B?MTJSU3h4ZXZSb1I3NXNuWEc0akVwUi9RSzFqOEtBYjRUSkJSUDRFVG5ZRmZJ?=
 =?utf-8?B?QkkxMG5BTzlCbjFYTDZkalRSUStQQUhNSzhlQmNEZnVWRzM1OFN2THhwVHVx?=
 =?utf-8?B?Wjk3VDd3emtkKzFuL2MwMHlrWGN1MDcrVmsreDVXV25aai9CcStlSUNjaVpi?=
 =?utf-8?B?WSt4dDNsSVpVVFJGVyt1SHdmdTYrblNDdGNXbkJDa29pVDJYUllxRFA1bXZ1?=
 =?utf-8?B?d29PbGQybGdVeFJ6TlJZdGx0QnRGQlBaenVHazZuUmpyNERoZFlzWE5GS0FH?=
 =?utf-8?B?WThnK054eFAvaWtVY2psR0xOMytEVEdZdlVFcVBpMDJEYXZsbmg0M1ErYmtT?=
 =?utf-8?Q?lWT1VORuobKtc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TUREMVlrNGpXTE1ld240Mkt6S05mM1d5aFh6S1UwUmY4aktDd04vNzZpcDZi?=
 =?utf-8?B?OFRRYW13RGZ6V2JKd1lCYm9xKzhZNi9SZDBRUDg0U3dNVXNuMmlnQUxzMVNm?=
 =?utf-8?B?VG5QWWVUSWtiOG1WdElHSTJvZU9nYTFjQTVYb0FWck94MVN1TGFISStmZmZL?=
 =?utf-8?B?MU9abFN5aVpSRmxQNy9XUjExelZiS1JtaWVkcXIremtQODN3bGRucmd4d2NP?=
 =?utf-8?B?djZLTlFnQS9IS200b2ZlN1VJaUFzQnFIdmFZL213cDFOaXY2UDY2Vy94dDVJ?=
 =?utf-8?B?SzNaQXRXUGVZd0F6R0gxVWM1VG12UlkxcHpGRHlNWmlXZEJqZ2ZBRWtwSVlP?=
 =?utf-8?B?YXo0c25yaWUwNXpGTk5pS3lwckxOVGVTbnZMMjRSMUgySWlWQlU0YlJiRXl4?=
 =?utf-8?B?REJCSkRXZ1ppWkxtMktOOE1PTDdYczRGOGsxRWlMU2Rua3JnYXhLVDdQS0dO?=
 =?utf-8?B?UWZHNktocjh6WUJrSEw0Q1RJaTlLUldJV21hODZEQVVJc1VtVU1kUVNoUTJj?=
 =?utf-8?B?NWRyanJ1NkNpOGxBWGtmYkRkUlIwSW9aZTdHelloL1RXSG4vNzdFZ2dIT21S?=
 =?utf-8?B?TjJ3YytFemx3UWJQeTZPT0ZoVXJqYmZqK011YjJhNTQ2czVtK3M0RU5QeWdZ?=
 =?utf-8?B?VkExWnAvTTBOUEFwY3J0eWJyemJMOEthb0Zjc090aU9EcENWeGw5ZFFUTkFX?=
 =?utf-8?B?dnlsUDNabzgvRnVaUWRwMGVFQ0k3R3JyWjhTUVd6bU5UcjNZY2N1QzVRcm54?=
 =?utf-8?B?N2MvM21NK3ExZDF4Z1YyRG9tUnJqUlh1R0ZCd3ZrL0hEbEIrUzRGdTJrV09w?=
 =?utf-8?B?S2J4TmRYeXIwWFZDbVBaMHVmNy9Va0RtOUFjRFFnSE4vT1RzVm1JM0MrR0xa?=
 =?utf-8?B?M1B3RHhDOEF5dDJTbW5sNlRZUHVVN282b1paVnljZHFlc3ZSL2NWVDJWRTZB?=
 =?utf-8?B?OE1IZGhCdnNUbWlndXZiNFYzZGFucnpmeXpnaWZXUXBEam81STgrOXZJVmtY?=
 =?utf-8?B?UjhoQnJiem00Q3N2dnhmdXZJN3IrRWc1T2xaRGloMHVLWXF5eTVNRVNaTXhy?=
 =?utf-8?B?Mk10bVcwbVpMQk1YQ0cwZlE2WEZEcEhhaklXa3ZGWVZPamtVbTlPZzBUaDFz?=
 =?utf-8?B?LzJ5TDhLa25sREkvQXBqd25SeVk0SHhlbnYzL1BsWUQrMUp6SkhNYWwyLzRY?=
 =?utf-8?B?UndWUWRYakFtalI4RDgvVlFZYzExakpBM3hIWTJHajlWTE1EdnU2Zy9iR05M?=
 =?utf-8?B?S2lWSksvMHp1OE03Rm9YVjh1cmY3MkRMdW9WQ0ZPRGpuT3o3Y08rYzB3OEh0?=
 =?utf-8?B?V0dWWk5tUXJiSURBYVBFTDh5aUZ4UEdIalZYRzVZaTFFRnRXNEZ6dXlWZlFv?=
 =?utf-8?B?UlBXeDdqSm9ZK1k2bGkybTlvNmNHTkwyQmM0WU9nQXVyblhMNjU2R1Q3MXNS?=
 =?utf-8?B?a05VdlpHeHdhOXFlMTIvNForVXZlMHlEU0E1MDMrMUI0ODJORE9wdVpKUmda?=
 =?utf-8?B?VldsTmVlWWNRVkFsQXpyN0t6bVE4MnpZS3pqVEp1REMrUEMvUmsrMVFCRSsr?=
 =?utf-8?B?WVlDUDVObEE5Y0xJQnFpVXpjSXN3NkdCYnRoUXVnYkFhcmJRSVkvZVByOCtL?=
 =?utf-8?B?b041NXZqdmpsUzN1a0hub3Z2aUpuMVFoUXRPZ21JQ2kzSUR3ZHA0bDRBRmc5?=
 =?utf-8?B?cStoMGxzbExnS3NVa3NVaHZweDJLbW1admhmWklYYXRYSTJid1FyZFFRNkQv?=
 =?utf-8?B?K3loYUFBZjA4UURJT2F1WWJVdjljMnJyZC9mb004UFM1RDZMZVNHWGl3S3Fu?=
 =?utf-8?B?UjE5TExqN0pmdU1RYkpMMnJ0dm5JZUZnV2xmcGl1Yk5PZ3JhQXJNdk92YjZI?=
 =?utf-8?B?YmhCNG9SNzg1N3dMTkFlM3hjZU5Vc1Zpc0dVOHduSmorR0Rzb2lTUGZPdFNP?=
 =?utf-8?B?WlY2bWFDNmpIamZ4bGRxcm1kb241Z3VXTXNPZWxkcmo4YWdvSklKeEhUNzdE?=
 =?utf-8?B?anNyckgrY1lHQWo5UzBsTU0vZ1d2Nnp3c0J0L0U4L2NMbjQwV0lOQ2ZkWk8x?=
 =?utf-8?B?TlN6Y0hFdjlpY3h2TnNXVVh3MVVtZndmVGdSOWV2WTFyaTZveUc3dVZEeCts?=
 =?utf-8?Q?1+XhSnV5v/TNy7MrKdaA3lB99?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1db2f3c-e7ef-45ab-a2a8-08dd40913ed8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 18:17:52.7674
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zg0dyyvBO+hqew70QDN/q5TfsfwyHVtOY3f6vkEqZdPYokx8ZhlF5ZAUFxub3tF2DknRfRu72mS00eJGavytAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8480


<snip>

>
>> FWIW, I had (as part of current in-progress v10) similar struct than
>> used here for Type2 initialization when there is no mailbox.
>>
>>
>> I had added a specific function for initialising that struct, but my
>> idea now with this change is to have cxl_mem_dev_info initialized by the
>> driver before calling cxl_dev_state_identify,
> Why is the accelerator calling cxl_dev_state_identify?  I did not see that
> in v9.  My idea was that was a mailbox only call which is only needed for
> memdevs.  And cxl_add_partition() can be called by accelerators as a
> convenience function to aid in creating cxl_dpa_info.  (This and cxl_test
> needed that function shared so it just got left in mbox.c)


No in v9 ... that predates Dan's DPA patches.


Type2 without an mbox needs to give those values obtained from 
CXL_MBOX_OP_IDENTIFY. I'm using an struct for passing those values to 
cxl_dev_state_identify for having same function serving Type2 with and 
without mbox. I could have another function instead and calling that one 
for Type2 with mbox. My idea is to keep similar initialization than 
Type3 pci driver.


>> and inside that function
> I'm not clear which 'that function' you are referring to here.


cxl_dev_state_identify


>> checking if total_bytes already != 0 for avoiding call the mbox command
>> for getting the info. This will support both cases for Type2, with and
>> without mailbox.
> I think I agree with you except the != 0 to avoid mailbox commands.
>
> Unless I am miss-understanding Dan we need to get to a place where mailbox
> commands stop filling in structures unless those work for both type 2 and
> 3 __and__ are optional.  Because putting in special checks for the type
> within a cxl/core/mailbox call is wrong IMO.


As I said, I can avoid that check with a wrapper for Type2, then only 
Type2 with mbox and supporting that command (is it mandatory if an 
mbox?) will end up calling cxl_dev_state_identify.


> Ira
