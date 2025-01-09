Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2080.outbound.protection.outlook.com [40.107.220.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38BB215F7B;
	Thu,  9 Jan 2025 10:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736420330; cv=fail; b=edjGLMKa1kYILTTv3/PcgsZfmo2eGlvXlnFgJJaAGRsZVd5UoVh840j3/OofSnikUdSfkGw5coy6utoo6R16bEtAUnwEVtGD+bmjlHKtaF/r+q9H9F5yhspKMm7/PlP7i/f5pPGLbwjLljkE6LMCZ7+rYkzAI+tmeSPtfD5ItS0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736420330; c=relaxed/simple;
	bh=8eI7hBRbthCVELnjxdwkOX3aGzAk3NgqhUbPHOLWPig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kEXDINOGb5hu+2vdldKhaDoLceWck0sDGtV3gIVi2BvSPTwAHt5MVDGNdmHCULQ6yq3vxLgS7MIpB7+Aq6olfI68fSh3L0DaLOLIbXSjFfc9sAKBs8Lf01c4Iq4MPwUmYq3AFfdDgY62qa7UsMbSJ8+6BFm/YMXPRmGnJAbUBI0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=S7fi7Gq2; arc=fail smtp.client-ip=40.107.220.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="S7fi7Gq2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pW8kD1l3h0ao013+ItVr4GxmNHrLYKlsm+vYrZzw9z30NeosLcx4GBCubQ/EowY+BrkpuKRM7telBsT05R8bNm9hppKht2QrJRam2dVnAEG3Kge0SSlZf3JBShHrVTDjxB5dcViwhzH9nIGAo8xI6oqdnDJwGGW4OVJyQA/QoOn+kTMKuXNvwgUlnKIMZBntndgkHKXQI5vsIjPsvuFYzMOHxzzShLKqXZsdlMUXeWGifrcST4yC45UTHsydERTw6lid/QnKp1B1/ZCiun3ZgVz1+1WdZPUP0bih2us6/155h4k6lIFxW9KsIUM1dfbyUr2WayicU7OH7Q6zoF4jFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tlIegcwRe6qshcE3Nd9+AH/wcyvfdR9DddYuQtdaQU0=;
 b=TUl51XzfoCfeeWOirXgjzVXmoYFbeI/quytBnEFRdamiwxuqKfWjxS23N4E+Bk6I+Z6kPkxsRxYZ3Gn8ZNEiD1GO7PIKlzTYAvVGGvXW4jncLOf/Tpa+JCQRqZCfW7uQNUfc4wQq3oCCIrylAfiXt06HpEf8NaaE766EYaPfOzducXQffMs5naVw+/AZ4wPUk2tW5PBmHYeoDXNdjmJDR9cy3bQrTLLqdZebBcYBfTIvSRrlZOUOESsCqi5YLgN7HISyY/suvPbSU/wv05hlbt3fRtvLp3Y8nShC4XlsBfWLOpKg2vCDWQ1v2SSGAe6RtjlvYiqDJzH3XubpgzR/3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tlIegcwRe6qshcE3Nd9+AH/wcyvfdR9DddYuQtdaQU0=;
 b=S7fi7Gq2QYiJXbcq3BoeekdTdnnc8MW/kjHuW1oyXlNGupugOoEv6ovUvA8gz+NRq2OQxXPiENvoBJ5H6O++R/sEmEwFzFJWJimIYkaK52rIZrQdh0KlueGJ0TaC66YpNhhyVbBCBIV+dzDw58OcaE2zWnMYnTKCTdSnzQNGxOM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SA3PR12MB8801.namprd12.prod.outlook.com (2603:10b6:806:312::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 10:58:44 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::b965:1501:b970:e60a%4]) with mapi id 15.20.8335.011; Thu, 9 Jan 2025
 10:58:44 +0000
Date: Thu, 9 Jan 2025 11:58:37 +0100
From: Robert Richter <rrichter@amd.com>
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>, linux-cxl@vger.kernel.org,
	Li Ming <ming4.li@outlook.com>
Subject: Re: [PATCH 2/3] cxl/core: Enable Region creation on x86 with Low
 Memory Hole
Message-ID: <Z3-r3VjDfgtEp_pY@rric.localdomain>
References: <20241122155226.2068287-1-fabio.m.de.francesco@linux.intel.com>
 <20241122155226.2068287-3-fabio.m.de.francesco@linux.intel.com>
 <Z2Cb4wZRk3bihXfr@rric.localdomain>
 <9930375.eNJFYEL58v@fdefranc-mobl3>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9930375.eNJFYEL58v@fdefranc-mobl3>
X-ClientProxiedBy: FR3P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::15) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SA3PR12MB8801:EE_
X-MS-Office365-Filtering-Correlation-Id: 89bff099-63fc-41de-8370-08dd309c95d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUFVdGlSNnFTelpGZHIxWFRJU1FKZ01JUU9ZQ2ZNeWNGNmVodmhSVitFTFk5?=
 =?utf-8?B?aXJNU3lrTFQ4S0kwVFdqdzRoeTRBZlBKc0RVaHpsRDMvdjMvRXZzY1Nwb2NT?=
 =?utf-8?B?M1pYZEtzcFhLZ1JBUTlDdXM2R2JEYy9UMExSUjhlVGFjdG03R2ZlZlZNcEoy?=
 =?utf-8?B?anJhZ21WbkR2YjVmeUQ0WlZta3NUQ2VORlgzY3psbmhhRUwvVWZQekJFYmkv?=
 =?utf-8?B?OEZrK2w0STBPQmFuVUVIdFE4WGFPSlNSbEY2TmNxMGlsRUFIeXU4ekw4OTg4?=
 =?utf-8?B?MGtEYW1VQ3lRREV0Sjc4R3dzWG82Njk0Qk5WRk8wSVVHUjJRY1ZFZm1lSDFq?=
 =?utf-8?B?Wmd1NjdpeWx3STRyYkQyMzFjeWdzdzNjdWFiZExoTXIxdUJhUVY0VGxpUStN?=
 =?utf-8?B?cVFlNFJFbnFkVjJueDgxNGpKK0FzblJLeTdBZzF1c1IyYzUrL0tNZDFTTlVl?=
 =?utf-8?B?WXl1UGkxSFdKdjVaY1NYb05oK2MyTERlV3RmcTlPSnZFMlVmd2t0c0FhbExk?=
 =?utf-8?B?MVdXREo2MDQ3MDUrcHdZSE9mK1NtdVRvT1JIcXhvVVJtNUtBQU1Sa1R1Z1JJ?=
 =?utf-8?B?dWNoRlhUbjR1QUI4V1NFa2ZPaGJOVU1tOTNvcUd0YWovcGdzMFFySWszMFZw?=
 =?utf-8?B?QXdoUzVqZVhWa0NEQ09xT1BoVlRHYmI5VVRkOWxKK3l1emlnQWEwSDdtTUhP?=
 =?utf-8?B?RFNUK0lIVVpUTTRTVXY2cGpnVEE2T2cyd2wwdGswdXRqUnFwakF3emdkWWlx?=
 =?utf-8?B?QXhkV3djb3pBQmpnZWFVb0dROXp4WkFSMU8ybG1GNVhCWHlERE14Q2hSQURm?=
 =?utf-8?B?T0hhMXlGSzNsWDI4emJOL2kwM0ZaWXFDMzBaSU04eGZrZ3hwbkpEK1pTQktn?=
 =?utf-8?B?NzVqbHhYRjl3RWVTRENoOXdqWkNUeFB1K1ZKNmp4VUN3NEF0OXpnTUJMR04v?=
 =?utf-8?B?QmtmNjZVanB0blI5ZkpnRHNXU3k4UW5QRHU3QWhFbW9JcGI4bkxteVlnNGk4?=
 =?utf-8?B?bkE4c0xYa1QzeW9VN3hZVlVEWms1UGZ5L1FWVGVGcmxEZGJQREpsdUNTUmNn?=
 =?utf-8?B?RG11aWpTRzRrS2xlZzY4Z1ZzQjdCdEY3dFg0SktLS0JNUVZjRGF5Q1BwRkJh?=
 =?utf-8?B?YlQ4bUdWbmVxRGdzLytFRGVRYzFaSHZvdWZReDRpdnFYOG0yQ2xXVjFHQ2ZY?=
 =?utf-8?B?ZDlaUmt0R3ZXWkRjSWoxUHRETVdYT3ppVG82bldsWkVlYjBMWWowbVVBMTRh?=
 =?utf-8?B?dEorS2F4SUgxVDRjY3V3cGRUaGdJbzhsbTNveUtJNHk2dm5QQzFrVmZmbzVu?=
 =?utf-8?B?UVNVcXJieXp3ZmFzeVJud0RwSW9uUlBsZkZoSUpkdjIxZjlTdDJpTTR5T2Mx?=
 =?utf-8?B?SUp4TDhrcFpWeVhVdVh6R0RkdUw4Z2YweGR6Qm8zbFgzV0xOOEg0Z3NScEo0?=
 =?utf-8?B?YUExczl6ODAwd1FFNlFHQ0FJUlFqVVpqZGhQK0hpeXNNdnk2ekIxeFlrZHZq?=
 =?utf-8?B?SlB5MzNWV2lCQTE1YVA4a0gzU1JEeWFreTBCZ1AzYk43V05SWU94SDg2ZnVF?=
 =?utf-8?B?ZXJVZ0twTmN2ajkyRThaYnh3bnVJaHNBdEN5VWkvSG9nVHAyc0lrclNlNTJr?=
 =?utf-8?B?YnpYckp2amhYT0tvY24xU1dLR3VGY0h1TUtVTnYvbTNlL2FxaTNTNzdaYlZr?=
 =?utf-8?B?ejNuS0ZGdU5HQkUxRllJdlh0RlJLbk45U29XNmd4MExYTGI1bjRHQ2VZSjhl?=
 =?utf-8?B?MkhSZFBqSHhKRUROcFJ2VkpEaitpUEpKWm5ocGpKbGdwcDUyanRya2lEZ2pW?=
 =?utf-8?B?RGFMWVlTVTZSNGUwZTB1TGwrQlYxc0ljRDFHYnhkYmVMeFZyYkFRdzhSN2JX?=
 =?utf-8?Q?Uaob7/Av0uxOc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aG8yWUZFVDN1MEFXclZ2ZHNqSVAzdk1ObkRENnNCeHozbzJlZWxWNndicXB5?=
 =?utf-8?B?U0daMDk3TE90djRoRDNldlpLbXo3S3VlVm13alU0dHhCMlFmS0w2TEtyVGkw?=
 =?utf-8?B?MlJjZ3JtbzczQ1JYM1VNTTd0aVZmcWY2Zm0zZlVPUHoxa1AweDIzWUQwZHRL?=
 =?utf-8?B?QjNiUmtMYWdFNjB1aUtJMkxjbi85cDdzaEpWa2NyRDdlOC9WRnJybldTYlpw?=
 =?utf-8?B?bkVHQWxBUWJ6N2xnMjFlSlhuZThvRXIwOVJSekNJYm9TTlM5ZnJmc29zT0FT?=
 =?utf-8?B?MnRmWTY0NjJ6NVJBTFE4eE1PVFI5R0UxTUErTkUxVk5QNHQzQXFsZnVMbzdk?=
 =?utf-8?B?dklHOFFpQVlBMk9NWXNvYkRpUnNlQ0Nja3NjSnFxQTlGeVpjbzI4dWZzY2ZX?=
 =?utf-8?B?VjY4TDRseFVrR0lqZmg5Z2ROMGFKRFlkVW1PdVd3bmhQNUROVE5YYk5lZkJ4?=
 =?utf-8?B?ajVacHM2RFNSRHdEVTZ0YU9EMEROcXVES1NZMENUT1FuQlVMQ2E4YVpVaXVB?=
 =?utf-8?B?UnI3a1Y3UUxXVWZ2NFdZOVkxUzZQYmtYb1lkdWs5eEZQaFROVEhXWm0vZ2sx?=
 =?utf-8?B?bHhscUZJaC92VEd4cUlqODNYZkFPcGlwVjVwQ3crdm9ORXVxMWdWYzZEOGJy?=
 =?utf-8?B?WWZWMDF6eC82djhKTklOS1Z3UUd1Ymc2eWRvdzFPTW5vcy9GY0MzZGNiSEdm?=
 =?utf-8?B?V1FkSVVPNU5RRjQ2ZFhvQzdVK2VDNGRLZU5USlFGaWhBQmtnQXZXZHN4ZHgv?=
 =?utf-8?B?TWZ2dUpSS3VrSjFVK2VLNTBqdGlZY2Q1RmFFUTErMlo0bmRlR3RodU1kK3NS?=
 =?utf-8?B?WE0rZ2JiU1RDVzR5WmtST242T25qcExDWFEwVURZQlR0RkdCZldLTFJEcEln?=
 =?utf-8?B?dFJrV3ZyQW5JMXJvWkM4NTNKamlBempUQWwvc21NKzh2Nm5nSThBUFo5RVAy?=
 =?utf-8?B?bGxiTWJ0bEZLaVU3UlA1VjExL2pQcDg4OWw4NVhtaDVQc3FnVjVmdlY2bHkw?=
 =?utf-8?B?eGxpR0FoalVzN2ErSXFUZVhyNjllbFlUb0lncStjN2NkOWYyeUpwVzMxUnYx?=
 =?utf-8?B?Uy95QXVSZDZBWnlVd2JjUFVlNWtocGNZWUd4b2xGTmEwUEVmSlhtVzNaMXg5?=
 =?utf-8?B?cVdIa3pyd0ZIWDdkNnVSOURVUWthdWM1enA5RTZDemRYUm1JWjRMRDNWM2RL?=
 =?utf-8?B?REk2cVErWkQzMXAyZHVpVTNHN09YTkdzYUZ0eit4aGlhUzBzZzdkZjB5Rk9V?=
 =?utf-8?B?dlJ6Q0NlMVZLODJaZFhtNXlvamV0Y1ljQmpDVXpza2FudWNmQjNuVFNHMEtZ?=
 =?utf-8?B?b1M1QXpzNUJpSEhQZlFWeXpaQzY5bU5OeFpZeU9ZMWVKcDNWUFM1cGpMNC9B?=
 =?utf-8?B?Z1hZKzhodDFXMWpkMnQxYVNzZ3YvdzBpTE5hUXNiNUQwZ1RMUUh1dXlSMURm?=
 =?utf-8?B?bHhRbUhodmNzd1Z3MGl0VU9ESGp3Tm8wS1Axdm12Qmw1QnlQMXQ2NXVOaVYw?=
 =?utf-8?B?YjZqT05sd0trN2dldk02L0Z5ZjJCNWN6YXYwV2ZQSm9uSld5Wnh5VXRxbm02?=
 =?utf-8?B?cjJkTTlNaWxvNWVta2Y1enVYRTM1VWtocGxaakozckNoTXdYVWlSNmo2SCt4?=
 =?utf-8?B?aGlyN0xWSjVNODZ3N0xtMDRIWVZyWEJTWVZTWlB0WUYwSmtCZyt4cVVyZ09q?=
 =?utf-8?B?UStiU2orUEhHc2NUQUEzb3g5YitVLzg0SHl1ZlUrL0k2aCtmWTZ2a3Y2eCtm?=
 =?utf-8?B?WmdOLzNNOG9KK3E5Y3VBSHFsQ1RTQUZPTVk2NG9IWm1yKzhydy9ZVGZMeWVZ?=
 =?utf-8?B?aEl4YlZjcWhzVVkwRVhKTW5CZTNnbE5mMEM3LzQvNUg2eHIzazhJaStmMk4x?=
 =?utf-8?B?Ti9LMjFWNVBOMTZReFc4WXB3MXZaNHZCTEYyMEQvVW9NL1B0WndnQnozdVJm?=
 =?utf-8?B?YnFUdHN5WWdXRzJibTF3b0Vxckg4YWdyczJDcTYwQkZERG1yaDhiZDQrd2ZV?=
 =?utf-8?B?L1VDNUlDUnFwSHd0WURNWVV2SmIxKzQwSy9CTVprZDFRam5qUXJTd2JsUjFi?=
 =?utf-8?B?UlpGSXd2dkp5MlBYNnlkTmNkUHBqMnU4WFhUZnBIbS9EK0V0TUpjOTg3Yklr?=
 =?utf-8?Q?RR1OStruPs4xfLp8T7HOTwDbf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89bff099-63fc-41de-8370-08dd309c95d3
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 10:58:44.5288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7zayrCbzLBqBggXfQ8SZbYzYZQMXrtxcEmWD+Fh2yeR6F9VSc4lb0BqA+U7NiOQBU0WjufYw38N0OWPIorYuaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8801

Fabio,

On 08.01.25 15:48:34, Fabio M. De Francesco wrote:
> Hi Robert,
> 
> On Monday, December 16, 2024 10:30:11 PM GMT+1 Robert Richter wrote:
> > Hi Fabio,
> > 
> > On 22.11.24 16:51:53, Fabio M. De Francesco wrote:
> > > The CXL Fixed Memory Window Structure (CFMWS) describes zero or more Host
> > > Physical Address (HPA) windows that are associated with each CXL Host
> > > Bridge. Each window represents a contiguous HPA that may be interleaved
> > > with one or more targets (CXL v3.1 - 9.18.1.3).
> > > 
> > > The Low Memory Hole (LMH) of x86 is a range of addresses of physical low
> > > memory to which systems cannot send transactions. In some cases the size
> > > of that hole is not compatible with the CXL hardware decoder constraint
> > > that the size is always aligned to 256M * Interleave Ways.
> > > 
> > > On those systems, BIOS publishes CFMWS which communicate the active System
> > > Physical Address (SPA) ranges that map to a subset of the Host Physical
> > > Address (HPA) ranges. The SPA range trims out the hole, and capacity in
> > > the endpoint is lost with no SPA to map to CXL HPA in that hole.
> > > 
> > > In the early stages of CXL Regions construction and attach on platforms
> > > with Low Memory Holes, cxl_add_to_region() fails and returns an error
> > > because it can't find any CXL Window that matches a given CXL Endpoint
> > > Decoder.
> > > 
> > > Detect Low Memory Holes by comparing Root Decoders and Endpoint Decoders
> > > ranges: both must start at physical address 0 and end below 4 GB, while
> > > the Root Decoder ranges end at lower addresses than the matching Endpoint
> > > Decoders which instead must always respect the above-mentioned CXL hardware
> > > decoders HPA alignment constraint.
> > > 
> > > Match misaligned CFMWS and CXL Regions with corresponding CXL Endpoint
> > > Decoders if driver detects Low Memory Holes.
> > > 
> > > Construct CXL Regions with HPA range's end trimmed by matching SPA.
> > > 
> > > Allow the attach target process to complete by relaxing Decoder constraints
> > > which would lead to failures.
> > 
> > I am implementing an address translation series and will post the
> > patches in a couple of days. It solves a similar problem to remap
> > (zero-based) endpoint address ranges to a different SPA range. I
> > implemented a generic approach that can easily be reused here. With
> > only a few changes to your series it could be integrated there (I
> > could rebase my code onto your's then in a later version of my
> > series).
> > 
> > The change I suggest to your series will also significantly simplify
> > your code and the function interface. The general idea is to have a
> > .spa_range attribute in struct cxl_endpoint_decoder:
> > 
> > @@ -428,6 +428,7 @@ struct cxl_endpoint_decoder {
> >         struct cxl_decoder cxld;
> >         struct cxl_root_decoder *cxlrd;
> >         struct resource *dpa_res;
> > +       struct range spa_range;
> >         resource_size_t skip;
> >         enum cxl_decoder_mode mode;
> >         enum cxl_decoder_state state;
> > 
> > Now, then an endpoint is detected, the spa_range is assigned,
> > typically this is cxled->spa_range = cxled->cxld.hpa_range (SPA ==
> > HPA). Whenever a port is added, a function cxl_port_platform_setup()
> > is called which could also contain a call to
> > cxl_port_setup_intel_lmh() or so.
> > 
> > @@ -865,6 +870,8 @@ static int cxl_port_add(struct cxl_port *port,
> >                         return rc;
> >         }
> >  
> > +       cxl_port_platform_setup(port);
> > +
> >         rc = device_add(dev);
> >         if (rc)
> >                 return rc;
> > 
> > cxl_port_setup_intel_lmh() does all the platform checks and
> > recalculates the spa_range for the endpoints based on the code you
> > already have. 
> >
> > The endpoint's SPA address range (instead of hpa_range)
> > is now used to construct the region by changing
> > match_region_by_range() accordingly. This avoids the instrumentation
> > of all the other checks you needed to add in this patch (use of
> > arch_match_region() and arch_match_spa() etc.).
> > 
> > The only function that needs to be exported is
> > cxl_port_setup_intel_lmh() then. Everything else is generic code. This
> > is also a good encapsulation to other archs, vendors, platforms etc. I
> > think that would really improve your series. Let me know if you have
> > questions.
> >
> Sorry for this late reply. I just come back from vacation :)
> 
> It's too early for asking questions. I'll wait until I read your series.
> I just saw you posted it yesterday.

np, my bad, it took longer than expected to send this out. Take your
time.

> 
> I'll rework my series and just export cxl_port_setup_intel_lmh() as you
> suggested, if it would result into a better solution.

In a v2 I am going to reorder and possibly split the patches for you
to reuse the first part then.

> 
> I can't yet easily figure out how to detect an LMH while still in cxl_port_add(),

I think you need to detect it close before region setup when decoders
are enumerated. I will revisit your patch again and take look to find
a solution.

> I'll think about it.
> >   
> > See also inline below, I have some questions and comments.
> > 
> > > 
> > > Cc: Alison Schofield <alison.schofield@intel.com>
> > > Cc: Dan Williams <dan.j.williams@intel.com>
> > > Cc: Ira Weiny <ira.weiny@intel.com>
> > > Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> > > ---
> > >  drivers/cxl/Kconfig       |  5 ++++
> > >  drivers/cxl/core/Makefile |  1 +
> > >  drivers/cxl/core/lmh.c    | 53 +++++++++++++++++++++++++++++++++++++
> > 
> > Could you name this file intel.c and have necessary Kconfig options?
> >
> I named it x86.c, but in internal review Dan asked to rename it lmh.c

The LMH detection is unclear yet, just checking for zero is IMO not
sufficient (looked at your answer below). As long as there is no
generic check a platform check is needed in addition.

> > 
> > If code should be reused later we still can move it to common.c or
> > similar. It would be good to guard that having a pci_device_id check
> > to a root port or a vendor cpu check.
> > 
> > See my comment no enablement above.
> > 
> > >  drivers/cxl/core/region.c | 55 ++++++++++++++++++++++++++++++++-------
> > >  drivers/cxl/cxl.h         | 25 ++++++++++++++++++
> > >  5 files changed, 130 insertions(+), 9 deletions(-)
> > >  create mode 100644 drivers/cxl/core/lmh.c
> > > 
> > > diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> > > index 876469e23f7a..07b87f217e59 100644
> > > --- a/drivers/cxl/Kconfig
> > > +++ b/drivers/cxl/Kconfig
> > > @@ -128,6 +128,11 @@ config CXL_REGION
> > >  
> > >  	  If unsure say 'y'
> > >  
> > > +config CXL_ARCH_LOW_MEMORY_HOLE
> > > +	def_bool y
> > > +	depends on CXL_REGION
> > > +	depends on X86
> > > +
> > >  config CXL_REGION_INVALIDATION_TEST
> > >  	bool "CXL: Region Cache Management Bypass (TEST)"
> > >  	depends on CXL_REGION
> > > diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> > > index 9259bcc6773c..6e80215e8444 100644
> > > --- a/drivers/cxl/core/Makefile
> > > +++ b/drivers/cxl/core/Makefile
> > > @@ -15,4 +15,5 @@ cxl_core-y += hdm.o
> > >  cxl_core-y += pmu.o
> > >  cxl_core-y += cdat.o
> > >  cxl_core-$(CONFIG_TRACING) += trace.o
> > > +cxl_core-$(CONFIG_CXL_ARCH_LOW_MEMORY_HOLE) += lmh.o
> > >  cxl_core-$(CONFIG_CXL_REGION) += region.o
> > > diff --git a/drivers/cxl/core/lmh.c b/drivers/cxl/core/lmh.c
> > > new file mode 100644
> > > index 000000000000..da76b2a534ec
> > > --- /dev/null
> > > +++ b/drivers/cxl/core/lmh.c
> > > @@ -0,0 +1,53 @@
> > > +// SPDX-License-Identifier: GPL-2.0-only
> > > +
> > > +#include <linux/range.h>
> > > +#include "cxl.h"
> > > +
> > > +/* In x86 with memory hole, misaligned CFMWS range starts at 0x0 */
> > > +#define MISALIGNED_CFMWS_RANGE_BASE 0x0
> > 
> > Could you more elaborate on this? Why is the base zero?
> > 
> I know it because I saw it's zero in all configurations showed by and discussed with 
> BIOS engineers.

As said above, an additional check is needed here.

[...]

> > > +/* Similar to arch_match_spa(), it matches regions and decoders */
> > > +bool arch_match_region(struct cxl_region_params *p,
> > > +		       struct cxl_decoder *cxld)
> > > +{
> > > +	struct range *r = &cxld->hpa_range;
> > > +	struct resource *res = p->res;
> > > +	int niw = cxld->interleave_ways;
> > > +
> > > +	if (res->start == MISALIGNED_CFMWS_RANGE_BASE &&
> > > +	    res->start == r->start && res->end < r->end &&
> > > +	    IS_ALIGNED(range_len(r), niw * SZ_256M))
> > > +		return true;
> > 
> > This basically means that the region base is zero?
> >
> Yes, it is. 
> >
> > How do you
> > determine the actual base address of the range then? The cxl test
> > patch contains a non-zero address.
> >
> Next version of this series is going to use 0x0 for real hardware and 
> mock_cfmws[0]->base_hpa for the topology created by cxl tests.
> >
> > this trimmed mem hole regions? Could you share a snippet of a CFMWS
> > entry for this?
> >
> Sorry, I don't have it because no real hardware was required to make and test
> my series. 

Ok, will reorder my patches in v2 for you to reuse and take a look at
your patch and the base_hpa setup. Will comment there again.

Thanks,

-Robert
