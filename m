Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2043.outbound.protection.outlook.com [40.107.101.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F933FC01
	for <linux-cxl@vger.kernel.org>; Mon, 20 May 2024 15:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716219727; cv=fail; b=QpWD76kMLqTDNeVDMWVMhkCmoMSVC22zyuYUEATCQJNJ8r+rBZU78ImT9Jbxo+0vmXITkduiXAP7DDHp83Ma0wckqymV8qMxC4H92ft5XgYmPRa6QfTl9gLJZPCPJ450xfcqR1oFUI26Md8QXaqx8Tdn4t4Yw/N4JQ9bysbWBcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716219727; c=relaxed/simple;
	bh=2q7WIKcvml+6nX2N/WwXVgzOBZwTPIlWBhNOMP5uz/A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WsENhfm8wXHSmp6ccZyrh/I4jeSttmft4ayyu1lcCSuA2mPrgDvBJydOJUloSFbhf46JD2cYbX79GmxU3wbV7/yE+MxGdhuf5JdmvOgH7bJmFxAL81gyNwNs3A0iUTyIkB+dfUrtHI7uDsNZPJLWCIn4vYh268wwzlc49V7NakQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yDSGOwyc; arc=fail smtp.client-ip=40.107.101.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yDSGOwyc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adyA5kqcsU1zgqGfA7IAIRexfmThlx3eUoDJYKnNBAF3rQFgFWyzBFmMbeCLL0j5JMkxGcGjnK+ye3mcyNeysf7SgOCj8fHKuCs4251DwpxUhNOGiVU8eqa2IecHxQvfz34jNEqs7fwJ9NofGZZBSZ34xgEcyivHnm6KPDU0pOlvk19aBx1/wIRkjGO1qyfhir0jO3piL3Ea4AvGND9Kd9B+NmLrtFgKAduEqdbr+htHKu2XW2bLVnnJwuC/icilmtm8IJD15GBsQhchfhTHva23C/GBZX3lJn66mOFF8bcoGrQkcuPYn47RplLv1rt8upOQiHQ4tp5FGMWy3vsGtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTDMe375lbU1XXE7I9zBEWexLG25/GXu77CFFn0GOk4=;
 b=ScxwUFx6/0vm2q2M1WsVpzIiYgByScdQNDmdUEu6jFtbdi/G26iKFXgTdkKYVbQXG2Qa6y3UvDy5bo9P5fKuQScExoVNIKooyHlJa+IeMhOQq8/lTwZN6GvCWwAIpDBCIjhuhL+Cuv1Nl8fWkzDPBEWU+xsXBJlM6PivybsNEduYgO3o5Os/KjTDUYR3n1wtbzVobnRnM4vBIPSZawoyGMax65IXk5q35oeQ1B2Q+OuSNAiYcAT9eI016w1yP7jCs3Np6SEK66aXoFOb4qjpGn/MRzz5z3hW6kIDQCYvZONCv8Ewyrb8b+BUnWa2q3uPg4NmvSHipZe4NZ5bRJOJPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTDMe375lbU1XXE7I9zBEWexLG25/GXu77CFFn0GOk4=;
 b=yDSGOwycaNj12s4ktdL9skLac4wVJzG7xTAQ8xfv9epy6mr3OXzbRZMmllC4df2/0iBC1ngHPKzQyOJnZ7UqwL7+qZ/glBjXIbkLwaUPfifhJGiOzrhfZpx/Z8k3tZ2LmV823SOLEFvHGhiSZWh+1Y0uCkJXU4ZG/7X7grBCenE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MW6PR12MB8705.namprd12.prod.outlook.com (2603:10b6:303:24c::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.35; Mon, 20 May
 2024 15:42:02 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%6]) with mapi id 15.20.7587.030; Mon, 20 May 2024
 15:42:02 +0000
Message-ID: <b176052b-200d-1583-bb86-759c1cd4a2ff@amd.com>
Date: Mon, 20 May 2024 16:41:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH 05/13] cxl: fix check about pmem resource
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
 pieter.jansen-van-vuuren@amd.com, richard.hughes@amd.com,
 dinan.gunawardena@amd.com
References: <20240516081202.27023-1-alucerop@amd.com>
 <20240516081202.27023-6-alucerop@amd.com>
 <20240517154031.00007e35@Huawei.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240517154031.00007e35@Huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0083.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::16) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MW6PR12MB8705:EE_
X-MS-Office365-Filtering-Correlation-Id: efe0b10e-ddb8-4f59-757e-08dc78e364b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QzRSWnE2NVAyRVFYUDBiWkYzVyt3anBRdkxqZ202Q2RzNkN3UVhoQWpSSHFB?=
 =?utf-8?B?SytyNmRPWHgxY1NpWGJvTVFTM1VFUmQ1a3VVSFZNN3pZa1dhdklodU5XZXl3?=
 =?utf-8?B?TWdxUmlVb2grM2taZkVuM1p2dDVlcFVQeUZpUndzTUhYY3NoM1BlbUZsYzNX?=
 =?utf-8?B?UXdudlVWWjBzc2MrTWlFak1OZkwwSUpQc0JiNEF5elV1Rm9oSENhSGhGeVZ6?=
 =?utf-8?B?UzhwQ0owTVlQb3FGOXBJdHI5VWRVbys2S0w2NWw2QUpOd1dMblRzT2E5elpt?=
 =?utf-8?B?TDNVTDdtbjVWSkMvek5yUlpZMVY1b25ERUtQTzM4d2I5aHE5ZHlNU2xpcWYv?=
 =?utf-8?B?UzhtclJYU1lPMlorYlZxODR3M3c4ZlpZeitHYUMwZFB0NUoyQVdlM2RGOHcr?=
 =?utf-8?B?UjduRHZDV2V3RHk1Q2ZEbFN1Y0h6NDNLTTJTcHFXRGNxZTNjZTVKTE1kbnNO?=
 =?utf-8?B?OWIwZ2FnOHZ2MHUrUEg3YWtSQWgvS0NqYnlMUlE3ekpjdUpzb0Fxay9pTlFH?=
 =?utf-8?B?eGhtOE9mYmx5M2xMaEs2Ui81ZHJ0ODVieUpBbnlsK2d1dTkxOEFmR1RLQzBS?=
 =?utf-8?B?WEdnRm5PL3Y5Mi8yRDY4T09IdDdaTUlTWHRpQ1A2a0hGOGdOcFhnR05KWEVG?=
 =?utf-8?B?dFVweldlYk9VbjBnT0I0QjFTb3JSUmRhcWlyMUZLajU0R1V1TzE2SDZnM1RX?=
 =?utf-8?B?R2FRaXFKUE55WUh5MllhSVRMWEFhSjZlVkE0d2cvM2ZydWtXS1NjY09YSUtE?=
 =?utf-8?B?MmtYRWFxNjV6ZDQweWZsRkIybTZPYVUwdmo5ZHIwenBFMzRxM2N0RjhlTDJ1?=
 =?utf-8?B?S2RLVUVpRElwMWwxcUFrRzhKanZxTmpRYkRaelV4NVNTTWFxYXdOSzRhTGJs?=
 =?utf-8?B?bm84WTE1Z1VISTFaSG16UTJSbFZvU2tXUk9hcUxncXpmVndZOFp3L3hmTFQx?=
 =?utf-8?B?RzRBTlFDMmpQKy9NRmorQlZkZzA4aEphRkIveUlzZ1dVdEVvYWwyMTZkM0pB?=
 =?utf-8?B?QU5xcWtjTlROVDkvRWhERW0xZ0oydlE0amlXZFZIcXR6SjN5dVNHcXpLTnVx?=
 =?utf-8?B?WDByUXR5OHkxTkR2c0ZmZ2NHYklUQytQTCtsQUZmam5zQld1QWEwQVhhVG1z?=
 =?utf-8?B?YkpRbkNUTVlMZmdmS29YRWhCRVdicGltNjRodi9jY1l1ZFFGRE1vZ1o5SVBK?=
 =?utf-8?B?elNXeDRPaC9hRVhXbjNuQ3JhM2VCSFpNTTFWRzBacGtuU3MxVDkxaDcyU21S?=
 =?utf-8?B?VEdaYjU0TmtPSmdvYU5zNWovNWV3OVg5ZnF3RHJubUJTSDNMblhEYW5jZ0Rl?=
 =?utf-8?B?MTJtRWNsWW1vWmZ2K0R5NytPVEVCVmZKUUpobXZFcFc0YTFDUk1icVZMRE5O?=
 =?utf-8?B?NTVYblpOV25vREJmTnBpaWFrVG1pbHNTdkhFS3JaUTZzY0ZEdHhpVnBZeUhr?=
 =?utf-8?B?SCs1STlURGtXWWdVd2txOXo3RHpqckt5TUorTEhsZjc5N1BZZjY0OHU1VWNQ?=
 =?utf-8?B?R3lYVnRPSDFVUEc2MUJSTlExcHNBWFBkd0xlZjZ2a3lKYy9MRklPOUp6VHlO?=
 =?utf-8?B?c240QjU3djk5R0hVc205VVV3aWZQOGJrSHhDT24vZmFxL09rM1F0aU0renU2?=
 =?utf-8?B?SWpSNjNFQ25PdmZpZ0FpelIzZmJCZU1wd1BSYmNyeUkwalc0SDR6ajU1czJ0?=
 =?utf-8?B?NjloRmdzWktOeGxBeTNIZ2U3VnI2ZnNQenpIdTJPU1lhM1FiMnBRMVNnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RzArVWpRRnE2Uyt6VkhqelVIWTZ4bkljMkFHMzNWR2FyOXIwSVRnTVp6a2Y3?=
 =?utf-8?B?WUpYQUVXK1FmcWhCaDhpUlV1Y0MySEEyeUNqYUs1eXUxaTVYNGpZR2h2bEJQ?=
 =?utf-8?B?aHdmMzVaWnNiUldiR3pENUp2RlNBKzFraDdkcVRQZ2w1bzBaeFhWQ1h4Vmt1?=
 =?utf-8?B?V3c1Z3Bqcy9PbFZzRnZtMGEwUVVTVWduZUpaNzlSY3pGNGl3azFORUUxU0Zu?=
 =?utf-8?B?WVgrYjNsb09qYU03YmFNbHQ2TlFpUGJaU2ZZSGVxbW5xbGw5alFZOWwvVWZt?=
 =?utf-8?B?VU1ySmd0NTZ0bDhwNFhFdys1R01STXpGcXJ0bmdSemxNeS9OYVE0ZHhONUY4?=
 =?utf-8?B?Zks3YlgvUXAxbGJPTjd1ZDJYWkJNVjVoTGZWWDhxMm4zOW9Eei9IcWEvQllH?=
 =?utf-8?B?TWJ1SDNEaUs1bUpqL2VaRnlGd3F3U2tPQzBGZEZHWlIrTEtxU2RPUjZycHpD?=
 =?utf-8?B?V3RNVHVUNkl4VlRxVTJEZStmSXhMeDFVbSsrZnJzRFJ4ZG5Ya2VSU29QSnNl?=
 =?utf-8?B?cXhFam9CRkdVNGxhS1BqSENGVjd6c1hSekc1ZzNLNkZlcXVuVXdTL0w0ZDVO?=
 =?utf-8?B?cVM0UjBrYzNoS2dOS1ZNR0NxbDNaN2NuQ2dWenorejE3dzhSZ0FNTUpkSlZW?=
 =?utf-8?B?YzZBSDdWRjNyL3hNMVEweVhVTnJPcVhQbzhIaEVDVkZ2c2NFYWs4MUhmT2xa?=
 =?utf-8?B?bmwxMkJnbzRJOU1PNi8zSStEbXNiNTlDNUs4ZnpXRldFU3AvWHMvQVhmTEFD?=
 =?utf-8?B?alptemJHek5qR3V4c251MkY4UnowNGRDTGpXNkNnbU1CVjFqOTR1ZTFBK2E5?=
 =?utf-8?B?NHRVWlZhdVJnd3hhOHE5Z0xSRENJcmUxcFN1UmpGdEdSY2NlNzdCWTBncmJM?=
 =?utf-8?B?aWxKNmErenhxMUhxUHR0ZWo2b3hsQkhrUXJWNTl0bUh2VmxCRGRGYWNNbk9r?=
 =?utf-8?B?SFBNRUk0dmVLbkU1RDliSWxsemhzQy82TkhpcUdXRzkxMTJZVmVOSk9PS2JN?=
 =?utf-8?B?aU4vUmpJK0QwMWpYVkp0bzBtVm96c3cxa1dVRHlmaGZkZWNFN05JaThjeUVw?=
 =?utf-8?B?d1R6WVZ0YS9FMS9YTURvWHJ4dFMzeGdIb1k2SEJmQkFUK3lyN0ZuSEFqTDUy?=
 =?utf-8?B?ZmVCTTh4MzlZZE4zYVI0bTl3d0pkaGttTlRXQnBHSHNsNkpPTFkrZFRMSW4z?=
 =?utf-8?B?TzdHRC9tQXRnU1pWOFpUaCt0emZhL2VJdGRud2VpL2FkaUsyNlcrelgrTTVH?=
 =?utf-8?B?ck8zb3hwbDhrbndYajZQWGVtNUZUZFk3bTF6amM0NmNhSDlHRzFmcDdlbzFG?=
 =?utf-8?B?eStkUTVsNGlIK2E0RWRlMEg4M1I0TEtGQmRRaXJmWmpyWUR3eW9md2xPR0Nu?=
 =?utf-8?B?eklWV1pEM2RvcVRxSmkvNnFoc1owVm5YNitFRG9vRzd2R3Q2QTdUSWRCdUI0?=
 =?utf-8?B?b2cxbWQrUFZURk1jQUYvWWlNMXM2TDJyMWVBOWJIZlI0WWNKK3dudG9uMmNk?=
 =?utf-8?B?cURjRlVyM2FHenJxYWR0ZVBhRU13UHBkMit0aTFseDFlY1BvMlBjVUtoTkxI?=
 =?utf-8?B?MUF0K09aNFVEajNFSU5NV0RyMEVaL0hHOXFrM3puQnZRTmJibzVOTHRKc3pz?=
 =?utf-8?B?UnVSNGM3bHRHalc5N3NIWnBQd3h6MENmaDBSbEhwZ2I1S2tjSGd0SWhYMnhV?=
 =?utf-8?B?ZGg1MHYxS0pEN3djSmk5YTdtOFdnekR2Y1ZUdzV1MWR4N3lkVWFvdmxrUy9h?=
 =?utf-8?B?dFFzSVdsZ3hOZmVaNjNKZmE2QlhyK2V3UFV4SklyZzBQd1R3TzhpMzMxbkd3?=
 =?utf-8?B?cWRlbXNpc3dyOTlydTM2OFlQRUN3UFFNYUpGNURNWUtEWllSV0hxQ3hDZFhy?=
 =?utf-8?B?YTFCNy81NTBCTWh6aWFyRGxnNVpQTGY5b3VPS0V1UGdpTTZFdWtqWjV4bFhN?=
 =?utf-8?B?Y1ZjSXc1dnc1WWgrNEZFZGI1U1BScWprbWkyRFR0RklxQm5sTjdzdEROUE5Q?=
 =?utf-8?B?RmlrNHBVUUhQM3lucDZsUWFiWWZvZ2NtRy9ENG5PSmhzd3drdVVVZk1ldzJE?=
 =?utf-8?B?SHVGcXdOSDQ2WVdaaG9rZVBlTVA0SU5xTTlLd0QrK3BYb1NWeGJhanJhS0V3?=
 =?utf-8?Q?1JzUPVJgBarTQUYR9pLrXTmaP?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efe0b10e-ddb8-4f59-757e-08dc78e364b1
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2024 15:42:02.4505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +caekmmPXY+vonQFUJbNbxROhAjlgp5a/0qZ8rau7kcsAF+WgKz5oiIZYZBYa9Hsxn8CDszHRECGEZI0cAdaJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8705


On 5/17/24 15:40, Jonathan Cameron wrote:
> On Thu, 16 May 2024 09:11:54 +0100
> <alucerop@amd.com> wrote:
>
>> From: Alejandro Lucero <alucerop@amd.com>
>>
>> Current check is using resource_size which counts on a range bigger than
>> 0. For a resource with start and end being 0, resource_size returns 1
>> and implying a false positive. Use the end not being zero as the new check.
>>
>> Note: If I´m not missing anything here, this should be extended to the
>> whole linux kernel where resource_size is being used in conditionals,
>> and where the likely right fix is to modify resource_size itself
>> checking for the range not being 0.
> The start and end being 0 is a valid resource of length 1 so that
> should not need fixing.


Uhmmm ... I have problems understanding this but I guess there's a good 
reason for it.


> These should have been initialized with DEFINE_RES_MEM()
> / DEFINE_RES_NAMED()
> That will happily set the .end to -1 resulting in a wrap around
> so that you get all bits set.


That makes sense, but I wonder if we should have some function for doing 
default initialization of those fields like this which some users, like 
an accelerator with no pmem, will likely leave untouched.

Maybe inside cxl_accel_state_create in patch2 something like this:

     cxlds->dpa_res = DEFINE_RES(0, -1);

     cxlds->ram_res = DEFINE_RES(0, -1);

     cxlds->pmem_res = DEFINE_RES(0, -1);


>
> Sometimes this gives slightly confusing range prints but otherwise
> I think it is fine.
>
>> Signed-off-by: Alejandro Lucero <alucerop@amd.com>
>> ---
>>   drivers/cxl/core/hdm.c    | 4 ++--
>>   drivers/cxl/core/memdev.c | 8 ++++----
>>   drivers/cxl/mem.c         | 2 +-
>>   3 files changed, 7 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>> index 47d9faf5897f..c5f70741d70a 100644
>> --- a/drivers/cxl/core/hdm.c
>> +++ b/drivers/cxl/core/hdm.c
>> @@ -432,12 +432,12 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
>>   	 * Only allow modes that are supported by the current partition
>>   	 * configuration
>>   	 */
>> -	if (mode == CXL_DECODER_PMEM && !resource_size(&cxlds->pmem_res)) {
>> +	if (mode == CXL_DECODER_PMEM && !cxlds->pmem_res.end) {
>>   		dev_dbg(dev, "no available pmem capacity\n");
>>   		rc = -ENXIO;
>>   		goto out;
>>   	}
>> -	if (mode == CXL_DECODER_RAM && !resource_size(&cxlds->ram_res)) {
>> +	if (mode == CXL_DECODER_RAM && !cxlds->ram_res.end) {
>>   		dev_dbg(dev, "no available ram capacity\n");
>>   		rc = -ENXIO;
>>   		goto out;
>> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
>> index 0336b3f14f4a..b61d57d0d4f4 100644
>> --- a/drivers/cxl/core/memdev.c
>> +++ b/drivers/cxl/core/memdev.c
>> @@ -197,14 +197,14 @@ static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
>>   	int rc = 0;
>>   
>>   	/* CXL 3.0 Spec 8.2.9.8.4.1 Separate pmem and ram poison requests */
>> -	if (resource_size(&cxlds->pmem_res)) {
>> +	if (cxlds->pmem_res.end) {
>>   		offset = cxlds->pmem_res.start;
>>   		length = resource_size(&cxlds->pmem_res);
>>   		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
>>   		if (rc)
>>   			return rc;
>>   	}
>> -	if (resource_size(&cxlds->ram_res)) {
>> +	if (cxlds->ram_res.end) {
>>   		offset = cxlds->ram_res.start;
>>   		length = resource_size(&cxlds->ram_res);
>>   		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
>> @@ -266,7 +266,7 @@ static int __cxl_dpa_to_region(struct device *dev, void *arg)
>>   		return 0;
>>   
>>   	cxled = to_cxl_endpoint_decoder(dev);
>> -	if (!cxled->dpa_res || !resource_size(cxled->dpa_res))
>> +	if (!cxled->dpa_res || !cxled->dpa_res->end)
>>   		return 0;
>>   
>>   	if (dpa > cxled->dpa_res->end || dpa < cxled->dpa_res->start)
>> @@ -302,7 +302,7 @@ static int cxl_validate_poison_dpa(struct cxl_memdev *cxlmd, u64 dpa)
>>   	if (!IS_ENABLED(CONFIG_DEBUG_FS))
>>   		return 0;
>>   
>> -	if (!resource_size(&cxlds->dpa_res)) {
>> +	if (!cxlds->dpa_res.end) {
>>   		dev_dbg(cxlds->dev, "device has no dpa resource\n");
>>   		return -EINVAL;
>>   	}
>> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
>> index 6dc2bf1e2b1a..a168343d2d4d 100644
>> --- a/drivers/cxl/mem.c
>> +++ b/drivers/cxl/mem.c
>> @@ -174,7 +174,7 @@ static int cxl_mem_probe(struct device *dev)
>>   	if (rc)
>>   		return rc;
>>   
>> -	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM)) {
>> +	if (cxlds->pmem_res.end && IS_ENABLED(CONFIG_CXL_PMEM)) {
>>   		rc = devm_cxl_add_nvdimm(cxlmd);
>>   		if (rc == -ENODEV)
>>   			dev_info(dev, "PMEM disabled by platform\n");
