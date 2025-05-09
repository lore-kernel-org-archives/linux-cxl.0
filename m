Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F461274FE6
	for <linux-cxl@vger.kernel.org>; Fri,  9 May 2025 09:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746782073; cv=fail; b=mgJvnqixIYQvbauiAP+/Y5tbL+3cAc3uFemwYYZiPjDcvwi55kJZb7bF2VS3r9NOvB+2B9fLYE1EOHo/GZ5JYfwyu3P5EDKutUi2x+J02g06LLdmAmUyUl1e/fpbP9uGgOsBYj2b5jj+rzL7RL6GYa3WO2RBIbGJ72taqDDz+QE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746782073; c=relaxed/simple;
	bh=CnP2hYEgK54t4Xapg10c4I4nUWq5oUpgj8PU7Af7oT4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VQU3mvM4ZlFcDR+L0Hxc+FYbGTuw3uxe3+RbSI/kA+CNkTVlLDt96GNhULWW5J5xB8vjbouvrAAIOflyXJ1E0ERUavofdb6RnGl24wuj/mdK+lWG5VYJjUsOy7fNfQloCajYNGz+tuUjWqhAEUAdcBVnbBZOJqvJ1SpmZnT3Hhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=A/qJ8sXJ; arc=fail smtp.client-ip=40.107.244.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="A/qJ8sXJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QLWMauAc+zPeLqGIvlEIFQGyGVDJESVUKokc1MMs3zYIl1YKAUAKpE17DA1RFA55TPkSFs0aX4X1J+rGCXI4KtXe0lisotaAE/yfpxjO1agBy7vq//UtOfUz4QtN/T/s0Z844Fz/EPlqitTWsKh6+I+nqpn9ZCg3/wpjImD5CWqeuXJ9kpqUsY42XF7jFYjpFA4gF8ExrwrueFXbn4WleHUEENmtUHd3qQsOe+47QLKK4pMYY+LURAF1RgiQo6xPILLgIEvOdp/BEttyKnLeSSSaw6dy7DKroJW9l8sJms2qWczkmOQjbUpR1r4CRAHdNy6M3OB4ojD91IrIF+vQwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eeRYM2hmsrath00ibhzH+3Z45rWsRRnf0szKW9cl55Q=;
 b=hJgahm/V5obaH6bjTcX4HBnM/fnEJ+n0tof4rqSS981/n20FESJAkJcVqk8OB+rg6AaUnHGbuf9Eljso5MAyZbaiiAJMtUAmx5cTRunEtadjW/AmiRR17aH3vssdqkcC054TzwM5kuVn3mfVtSFZEwytrd906uwu/mqOsBsRC7evf6kAW7DWc1gag0al0Ajs1T1PdvE9P5N9SitgRtBLsussTHEHJ3ZvS5AerQ3UDIJzJHnizMC2IVFtcchcBrAznlPoV2WLqFzacC3F/4DhnL4+Vg2VW666M0sVP9kync0l3PQAWzOoW1F4hhxtHPDH+fJoZdvfr+hj5m86dOO6/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eeRYM2hmsrath00ibhzH+3Z45rWsRRnf0szKW9cl55Q=;
 b=A/qJ8sXJ6pUo6Vz6f5cSo5RlhoN9w+8ypu/BwM41RxYWdxJHR+wnunUqbc2pls8BO2EG2fWK+F7IYscCPew6zzYVwxAsQoaOPyMAMSp4JdiNHaepQUAvprRpKKs3+q+I2KhvwpIZX2crQAQWgqWewINxD4BQLa0cm+pMqgCaDvI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by SJ2PR12MB7896.namprd12.prod.outlook.com (2603:10b6:a03:4c6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Fri, 9 May
 2025 09:14:27 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.8722.021; Fri, 9 May 2025
 09:14:27 +0000
Message-ID: <788ebc81-8414-4250-8f88-eed2a7c0b12c@amd.com>
Date: Fri, 9 May 2025 10:14:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] cxl: Saperate out CXL dport->id vs actual dport
 hardware id
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: Dan Williams <dan.j.williams@intel.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 ira.weiny@intel.com, rrichter@amd.com, ming.li@zohomail.com
References: <20250507004310.3536991-1-dave.jiang@intel.com>
 <20250507004310.3536991-3-dave.jiang@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20250507004310.3536991-3-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0409.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::18) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|SJ2PR12MB7896:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e6a3bc9-be19-405d-ee1c-08dd8ed9e60c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YTlxVXVIS3Z2WC9aZm5ZMVROQXl2SlJFUXBXMllEdVlvZExMTlo2OTcvSmxo?=
 =?utf-8?B?VjRkVnVzbzNYcE80N3lPQXZMT3FNWlZuZU40SlFUNTUyUlQ2K0xyU2wrRFJJ?=
 =?utf-8?B?b0cvb1dMdFJmZ2JqRjlqWjNHU3V2RU16Wms0QXJlZS9hZHRTUmlteTd5UXVO?=
 =?utf-8?B?S2RPaFEwQ29IZUFLeGdEb1RWbHkyeVlGek16R2dpL1o0RTdiMFFwc0d0Q0h4?=
 =?utf-8?B?aG16TC9VaXg4LzVQbWRKSzlpK0FDTUVTK1lVekxIczlFOGtxS3hzK2ZCUmxY?=
 =?utf-8?B?RW9yY2FVYmIvV09UT2xGaklJSW5UQUMvUXM1Z3B4eklNR0pFdWlLY25PVk50?=
 =?utf-8?B?Wmd0K2x0dHA3NWxjcEZ4a3FUZDV3SkFyeHFwYytsb2t6MG1JUldGd0QwRFdk?=
 =?utf-8?B?S21adlRBRVJGNUxMbnNVdFRFV0NPa0ptckQyNTFVMXBPY0F1dklxbEpMT2dL?=
 =?utf-8?B?TGlsWGpFQVJYM2pHMW80MzdCWGhETGZzR1FlQ0RqVzhMK2JPNVVlODU1Mk44?=
 =?utf-8?B?NjcrM3NHNWhsVU9Zb2t2cXF3Y21FdS9rcUZBNnhGZndTSUFBbmdEL0prbE9M?=
 =?utf-8?B?eWtEdHJFUGhrYnNsYWVwUXlGR1hxUmN6N1MzZ0w3SjdLUjdPZnVyTHkvS3hF?=
 =?utf-8?B?a25iZGQrQkhtODZHV1c4Wk5CMlI4K2cyYUl2TDlRS094cGlSRWc0dkF2SXNh?=
 =?utf-8?B?Wm5VQ1owSHhCQmd5TExVMktDVnFUSVprK0Yxd3cxWG5kZDBaUXcrdkN3Nkc0?=
 =?utf-8?B?emRGRXB3M1pLYTNFT01ISy9YaFdXaWlLN1JvZVB6dE0zOTBERldXSVhwKzVP?=
 =?utf-8?B?bm0yekFvTXo4QVY1bFdOYk5DKzhUNG1YQ0RxUGtsZDE4UWQxWHZaLzNhS0xD?=
 =?utf-8?B?a3N4OWdaaTU4NkVFUldidWp4ZWRsM2w0YjJjSjEycHNhYXpyQjAycDhEV1Jt?=
 =?utf-8?B?OGhxRURxOWRuNCtUY1N3VEl3S3pkQWM1NWNhL1J5U0E4cTJxZW9pZnJjRk9P?=
 =?utf-8?B?R2IvejFYVW1nZ21XVWFrbUkyT1oxNGJobEZ0ZnY0Tm5yeitNdGdwbng1a1E0?=
 =?utf-8?B?Mk9pWC9qTng1NGdFZy9aV00zTmQ3K01pTVJCbW9hTWRodFhpRGtjV2d1VmUv?=
 =?utf-8?B?Z3ZhczVlclA4OGFXN2FQWS81OUI1aEl3Qm1DYjBvMms0TGQvdzJFbUplZUow?=
 =?utf-8?B?UzFRZVcyTTZ5dnh6amhFb0Y3UzQwSTBzY2Y5dVBxVzE5Q3ZaM1BxRjBGRjhK?=
 =?utf-8?B?dDYxb1gzd2xNTWhhSmdNSnJQWkM0aHJtUGpKS3pRc1c5dkFhZktjZlFPcksv?=
 =?utf-8?B?Rm0ySFRmcXNqUTdFaFVMb3VGVy9HQndLSlNNc1lkc1hsYTR1ZnFaYzdMNkRp?=
 =?utf-8?B?dktlS0IxU3FKZEkwT1N1WFNMVmJVWVdjZzVtL0xKcDZxZFhyMHA0c1p3d2Vs?=
 =?utf-8?B?NjEyTEhFQ2NMaDVrSDZnbDc2WkZZWGdnQWowbjQ3SjI0NkZ6MmJDd2Y5RzBT?=
 =?utf-8?B?ejZYd3o0VmF0V2d1UXVGR290ellEdkJQM0VPQitMVGxUL3ZJWVFqWjNNMW1B?=
 =?utf-8?B?ZjZaaTNnL3NaQkpYcHZtNWEwTlRjNDA3SmxoLzNRYVlsY3BrRHhkNGVnc1VW?=
 =?utf-8?B?aVB5SFRMVFJZOHd5bFkrTkRzazZhemxmYWhVVWpwTC90a0NVT0NQZ29LaEtE?=
 =?utf-8?B?MWF5TTVNNHBhcXNZYlByUVhiSVpMNm51QWdSZEVYS2VmbllvSjJiUUxTME4v?=
 =?utf-8?B?MUswSTVuQk94VFpFNDVBRDdjM2pJRFV2ZStqMHJnVVdnb1JXVHZEQ0FOTVZh?=
 =?utf-8?B?VVZnVGhQTWF5R0xHbWlJNVJkOW9tcmE2YStMQnBnZUpWUjFDNzRIS0xVbnlN?=
 =?utf-8?B?NjlHU0xOaDVMZ1NoTjkrKy9TMnRJeitTSC9BSkFhc3VzYms3eXViQVdFZTJM?=
 =?utf-8?Q?TB+sHEBi9lo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RjYwMkdoSHpCUXFBenJ0dmVpMDNldFMyblhVOGNGQmo3TlArdGw3SjBnckU0?=
 =?utf-8?B?SVRGUjdxY1RoWklzYm90cjRVeUxvcUZib0g3aUhHU2xkQ3UxNFhLZmF5aGhG?=
 =?utf-8?B?Z1ZMQW91UlJtRGh1SXQ1VWVHOGRBTTlwdjVrMDVmcjI3aXRpYzgrZzMxK09o?=
 =?utf-8?B?ZmdDODlISG5kNmJaZ3VzNmp6SzNjV3RhN3Q2NlN3dmdFblJBUFB1K3lJdmlJ?=
 =?utf-8?B?ajNsMVptS3ljeTlUZkRPUk1Qa2s4am4vYmRENGlCTmcyWGpQT2ZnS0Uybk5o?=
 =?utf-8?B?MEtjSE1ob21STTJQQjJ0OGlEdUNoYnI5S0RackUyWDdXVjhCQ0JJbzJ5Y0xD?=
 =?utf-8?B?WVV2alhPU01EbFJUOGY0V202STFRNi96VjgzeHpxd2xGRlNTb0hpYjJtVHJG?=
 =?utf-8?B?RmlTd3c5bmJxOGQrVE9FSlpSUVhtbm5JVFpVaytVeXBDVDQya3crNzJKT2lR?=
 =?utf-8?B?R1o0Z0p6MVVlTmlxcy9oUmE4b3doeU96ZjFIWk1mYitmNTl6VmxPSU81NVJM?=
 =?utf-8?B?TmxCR3BZdW9uUkpUR28zN1VSbFEzbTlVdlUwM1RVWHJES0loVVQ4bE9JVmpt?=
 =?utf-8?B?YnJ1REtSVTVhbjhSekk5emNGYWZLTXRTZXp2RHVYTFlnQjh5RmJKQk9wWTNC?=
 =?utf-8?B?ODZxVzNNWHFoTHdpWmZobFdJS0RzcW9OVUcrZFFyNnZMSXg3ZDdxNisrR1dk?=
 =?utf-8?B?d3dBeS9PQ1FiSU0ySm9xTkkwUm12VGxISm1vSk5BdExBbFIycXVVSTlRZ0hH?=
 =?utf-8?B?WU1xZkEzQkZIcHlGK2ZHTDRINnE3bVVJNnJ6akJMeXdtOXNlK0ZJcEc2MUhz?=
 =?utf-8?B?d1VUNXovbmxxeDVDQ0JCQTBJSVVJMmlIcmlDeWJwWFhMaWo5djFPbjVySEp6?=
 =?utf-8?B?ci9wMGl2eEZlRWVVeW9DNUhXMWRrTnZkaFlKd3djUHN5OGwwdEJpejZ5bkw2?=
 =?utf-8?B?dTU4QnpFVjVVVnhWc2tGZVo2c3dPbGZwNXVLNkE2YWpldkp0R1kvZDFZRW5I?=
 =?utf-8?B?dGRxeUh6dEFlL25aa0xXNDIwZHgwZmpGT3pId0VkclIrVW1rUDR4YkFKenFi?=
 =?utf-8?B?WlJXQzJ1RHg5SU5wYUE5NXQ3eG1vbFROalpYTHk0R3pBMmY4cUszeEhETjVZ?=
 =?utf-8?B?Q2lCZjhUSng5bjZOaWFiKzJMZkRKNjcyTkpReWpwS0tEb01NWkVZd05sbkxY?=
 =?utf-8?B?UXkvOXlhUW9UbU9vQUQ4Y2JiNS84K2YxZWlPOHprL3A3UkhvaDhJS3BUdXBU?=
 =?utf-8?B?Sk9LUjhFVkhoQXFCSllQL0srdzc3RUd2UGEzMnNuSVlkM3RwNEU1c09ycDV0?=
 =?utf-8?B?ZTIwK2lQTDdydDlPV0NSVEJjWmtvMzFlZzRuM3BxVkxSTytTdzc4U290U3Bj?=
 =?utf-8?B?MVE2VDFEV01SaVpWRGRUU0prYkQvREZ5LzJmY09idEFDZi92RVVDaXhuazNs?=
 =?utf-8?B?UWxPVk50UG5Sb1RvcllhcU9DSDJMUTBjcUFNaEZ2SzN3N3V1QlVmNjFqdHBB?=
 =?utf-8?B?OENzZXZIaUsrSDVrWFJ1ajhpVks2U3dGeUI1RUg1ZFZObVdXOUp4UXBVU005?=
 =?utf-8?B?Z2xQREkwSEphQldRMzBsNWdjS2RaOWVIUGxGaUV2T1lCRkVQRFNWdTlQZXdz?=
 =?utf-8?B?bk9mR052WjFuWm8yZFRoQlBxRTRBRTdRaERZaDhoUFZNQ25SUWhEK212S0tW?=
 =?utf-8?B?R2x6Tll5bEdqWWc0YmNad2dWb0RSRmpSTlA3UGcrdThNWmRIMWhkVE81V1Ju?=
 =?utf-8?B?eG1qc0VvNTM0T1hvZ0FPb3JnMHBKTmNmbzJQUTIwVkY3U05sTG1UZTNDNTJ5?=
 =?utf-8?B?ZVBQcGZBUTB4ZiszbG5PY0J5czUxaVFxREh2RWtPSlk4YVlRd01HbExpRHNW?=
 =?utf-8?B?TkZTdFR5dmR4L0tkMDdIRmtwQ0VPbU1BQ1JwM2JkMkM0S2lNQjg0d2FrYjZl?=
 =?utf-8?B?MHRYL0dpZVZIRFVSekovQ09helRSUThpczVDOGg5cGp0Vys1KzlaUDQ3SlBB?=
 =?utf-8?B?NzMvMHlPeUlmeUlPYTFWa3lqbTIxMTd2Tk5pMTlvbHhCNDdsRG5WWkt6RDlB?=
 =?utf-8?B?dXRwK3YyTlQ1bGQ1NHFhVUJ4SVZzYnduWEVxaTIrYTIrYnNsdjZndzdSeDVo?=
 =?utf-8?Q?2TB4NSInYMfNGBPZ3EbnroQwe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e6a3bc9-be19-405d-ee1c-08dd8ed9e60c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 09:14:27.7168
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E5PJiy5kqHC2rpjGjmbJm3by3gM13xJUVDtOIW/SXNGztj7m11yLrVn0u0t3v+XynzMm8nHSTuPfg5ynFaBhYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7896

Hi Dave,

swapped vowels in the commit: Saperate -> Separate


With that:

Reviewed-by: Alejandro Lucero <alucerop@amd.com>


On 5/7/25 01:43, Dave Jiang wrote:
> In preparation to allow dport to be allocated without being active, make
> dport->id to be Linux id that enumerates the dport objects per port.
> Keep the hardware id under dport->port_num to maintain compatibility and
> introduce a dport->id as the enumeration id.
>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v2:
> - Rename port_id to port_num. (Dan)
> - Use a dport allocator to deal with ida allocation. (Dan, Jonathan)
> ---
>   drivers/cxl/core/cdat.c |  2 +-
>   drivers/cxl/core/hdm.c  | 18 +++++-----
>   drivers/cxl/core/port.c | 73 ++++++++++++++++++++++++++++++-----------
>   drivers/cxl/cxl.h       | 12 ++++---
>   4 files changed, 71 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index edb4f41eeacc..f637e3631d88 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -501,7 +501,7 @@ static int cdat_sslbis_handler(union acpi_subtable_headers *header, void *arg,
>   
>   		xa_for_each(&port->dports, index, dport) {
>   			if (dsp_id == ACPI_CDAT_SSLBIS_ANY_PORT ||
> -			    dsp_id == dport->port_id) {
> +			    dsp_id == dport->port_num) {
>   				cxl_access_coordinate_set(dport->coord,
>   							  sslbis->data_type,
>   							  val);
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 70cae4ebf8a4..d7ad92e191ba 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -69,7 +69,7 @@ int devm_cxl_add_passthrough_decoder(struct cxl_port *port)
>   
>   	xa_for_each(&port->dports, index, dport)
>   		break;
> -	single_port_map[0] = dport->port_id;
> +	single_port_map[0] = dport->port_num;
>   
>   	return add_hdm_decoder(port, &cxlsd->cxld, single_port_map);
>   }
> @@ -720,21 +720,21 @@ static void cxlsd_set_targets(struct cxl_switch_decoder *cxlsd, u64 *tgt)
>   	struct cxl_dport **t = &cxlsd->target[0];
>   	int ways = cxlsd->cxld.interleave_ways;
>   
> -	*tgt = FIELD_PREP(GENMASK(7, 0), t[0]->port_id);
> +	*tgt = FIELD_PREP(GENMASK(7, 0), t[0]->port_num);
>   	if (ways > 1)
> -		*tgt |= FIELD_PREP(GENMASK(15, 8), t[1]->port_id);
> +		*tgt |= FIELD_PREP(GENMASK(15, 8), t[1]->port_num);
>   	if (ways > 2)
> -		*tgt |= FIELD_PREP(GENMASK(23, 16), t[2]->port_id);
> +		*tgt |= FIELD_PREP(GENMASK(23, 16), t[2]->port_num);
>   	if (ways > 3)
> -		*tgt |= FIELD_PREP(GENMASK(31, 24), t[3]->port_id);
> +		*tgt |= FIELD_PREP(GENMASK(31, 24), t[3]->port_num);
>   	if (ways > 4)
> -		*tgt |= FIELD_PREP(GENMASK_ULL(39, 32), t[4]->port_id);
> +		*tgt |= FIELD_PREP(GENMASK_ULL(39, 32), t[4]->port_num);
>   	if (ways > 5)
> -		*tgt |= FIELD_PREP(GENMASK_ULL(47, 40), t[5]->port_id);
> +		*tgt |= FIELD_PREP(GENMASK_ULL(47, 40), t[5]->port_num);
>   	if (ways > 6)
> -		*tgt |= FIELD_PREP(GENMASK_ULL(55, 48), t[6]->port_id);
> +		*tgt |= FIELD_PREP(GENMASK_ULL(55, 48), t[6]->port_num);
>   	if (ways > 7)
> -		*tgt |= FIELD_PREP(GENMASK_ULL(63, 56), t[7]->port_id);
> +		*tgt |= FIELD_PREP(GENMASK_ULL(63, 56), t[7]->port_num);
>   }
>   
>   /*
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 726bd4a7de27..e9c02e4d0d4c 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -159,7 +159,7 @@ static ssize_t emit_target_list(struct cxl_switch_decoder *cxlsd, char *buf)
>   
>   		if (i + 1 < cxld->interleave_ways)
>   			next = cxlsd->target[i + 1];
> -		rc = sysfs_emit_at(buf, offset, "%d%s", dport->port_id,
> +		rc = sysfs_emit_at(buf, offset, "%d%s", dport->id,
>   				   next ? "," : "");
>   		if (rc < 0)
>   			return rc;
> @@ -739,6 +739,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport_dev,
>   		dev->parent = uport_dev;
>   
>   	ida_init(&port->decoder_ida);
> +	ida_init(&port->dport_ida);
>   	port->hdm_end = -1;
>   	port->commit_end = -1;
>   	xa_init(&port->dports);
> @@ -1044,14 +1045,14 @@ void put_cxl_root(struct cxl_root *cxl_root)
>   }
>   EXPORT_SYMBOL_NS_GPL(put_cxl_root, "CXL");
>   
> -static struct cxl_dport *find_dport(struct cxl_port *port, int id)
> +static struct cxl_dport *find_dport(struct cxl_port *port, int port_num)
>   {
>   	struct cxl_dport *dport;
>   	unsigned long index;
>   
>   	device_lock_assert(&port->dev);
>   	xa_for_each(&port->dports, index, dport)
> -		if (dport->port_id == id)
> +		if (dport->port_num == port_num)
>   			return dport;
>   	return NULL;
>   }
> @@ -1062,11 +1063,11 @@ static int add_dport(struct cxl_port *port, struct cxl_dport *dport)
>   	int rc;
>   
>   	device_lock_assert(&port->dev);
> -	dup = find_dport(port, dport->port_id);
> +	dup = find_dport(port, dport->port_num);
>   	if (dup) {
>   		dev_err(&port->dev,
> -			"unable to add dport%d-%s non-unique port id (%s)\n",
> -			dport->port_id, dev_name(dport->dport_dev),
> +			"unable to add dport%d-%s non-unique port num (%s)\n",
> +			dport->port_num, dev_name(dport->dport_dev),
>   			dev_name(dup->dport_dev));
>   		return -EBUSY;
>   	}
> @@ -1114,13 +1115,43 @@ static void cxl_dport_unlink(void *data)
>   	struct cxl_port *port = dport->port;
>   	char link_name[CXL_TARGET_STRLEN];
>   
> -	sprintf(link_name, "dport%d", dport->port_id);
> +	sprintf(link_name, "dport%d", dport->id);
>   	sysfs_remove_link(&port->dev.kobj, link_name);
>   }
>   
> +static void free_dport(void *data)
> +{
> +	struct cxl_dport *dport = data;
> +	struct cxl_port *port = dport->port;
> +
> +	ida_free(&port->dport_ida, dport->id);
> +	kfree(dport);
> +}
> +
> +static struct cxl_dport *cxl_alloc_dport(struct cxl_port *port,
> +					 struct device *dport_dev)
> +{
> +	int id;
> +
> +	struct cxl_dport *dport __free(kfree) =
> +		kzalloc(sizeof(*dport), GFP_KERNEL);
> +	if (!dport)
> +		return NULL;
> +
> +	id = ida_alloc(&port->dport_ida, GFP_KERNEL);
> +	if (id < 0)
> +		return NULL;
> +
> +	dport->dport_dev = dport_dev;
> +	dport->port = port;
> +	dport->id = id;
> +
> +	return no_free_ptr(dport);
> +}
> +
>   static struct cxl_dport *
>   __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
> -		     int port_id, resource_size_t component_reg_phys,
> +		     int port_num, resource_size_t component_reg_phys,
>   		     resource_size_t rcrb)
>   {
>   	char link_name[CXL_TARGET_STRLEN];
> @@ -1139,17 +1170,19 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>   		return ERR_PTR(-ENXIO);
>   	}
>   
> -	if (snprintf(link_name, CXL_TARGET_STRLEN, "dport%d", port_id) >=
> +	dport = cxl_alloc_dport(port, dport_dev);
> +	if (!dport)
> +		return ERR_PTR(-ENOMEM);
> +
> +	rc = devm_add_action_or_reset(&port->dev, free_dport, dport);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	if (snprintf(link_name, CXL_TARGET_STRLEN, "dport%d", dport->id) >=
>   	    CXL_TARGET_STRLEN)
>   		return ERR_PTR(-EINVAL);
>   
> -	dport = devm_kzalloc(host, sizeof(*dport), GFP_KERNEL);
> -	if (!dport)
> -		return ERR_PTR(-ENOMEM);
> -
> -	dport->dport_dev = dport_dev;
> -	dport->port_id = port_id;
> -	dport->port = port;
> +	dport->port_num = port_num;
>   
>   	if (rcrb == CXL_RESOURCE_NONE) {
>   		rc = cxl_dport_setup_regs(&port->dev, dport,
> @@ -1211,7 +1244,7 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>    * devm_cxl_add_dport - append VH downstream port data to a cxl_port
>    * @port: the cxl_port that references this dport
>    * @dport_dev: firmware or PCI device representing the dport
> - * @port_id: identifier for this dport in a decoder's target list
> + * @port_num: identifier for this dport in a decoder's target list
>    * @component_reg_phys: optional location of CXL component registers
>    *
>    * Note that dports are appended to the devm release action's of the
> @@ -1219,12 +1252,12 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
>    * switch ports)
>    */
>   struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
> -				     struct device *dport_dev, int port_id,
> +				     struct device *dport_dev, int port_num,
>   				     resource_size_t component_reg_phys)
>   {
>   	struct cxl_dport *dport;
>   
> -	dport = __devm_cxl_add_dport(port, dport_dev, port_id,
> +	dport = __devm_cxl_add_dport(port, dport_dev, port_num,
>   				     component_reg_phys, CXL_RESOURCE_NONE);
>   	if (IS_ERR(dport)) {
>   		dev_dbg(dport_dev, "failed to add dport to %s: %ld\n",
> @@ -1455,7 +1488,7 @@ static void reap_dports(struct cxl_port *port)
>   	xa_for_each(&port->dports, index, dport) {
>   		devm_release_action(&port->dev, cxl_dport_unlink, dport);
>   		devm_release_action(&port->dev, cxl_dport_remove, dport);
> -		devm_kfree(&port->dev, dport);
> +		devm_release_action(&port->dev, free_dport, dport);
>   	}
>   }
>   
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index a9ab46eb0610..f4fe523aaf12 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -583,6 +583,7 @@ struct cxl_dax_region {
>    * @regions: cxl_region_ref instances, regions mapped by this port
>    * @parent_dport: dport that points to this port in the parent
>    * @decoder_ida: allocator for decoder ids
> + * @dport_ida: allocator for dport ids
>    * @reg_map: component and ras register mapping parameters
>    * @nr_dports: number of entries in @dports
>    * @hdm_end: track last allocated HDM decoder instance for allocation ordering
> @@ -603,6 +604,7 @@ struct cxl_port {
>   	struct xarray regions;
>   	struct cxl_dport *parent_dport;
>   	struct ida decoder_ida;
> +	struct ida dport_ida;
>   	struct cxl_register_map reg_map;
>   	int nr_dports;
>   	int hdm_end;
> @@ -655,7 +657,8 @@ struct cxl_rcrb_info {
>    * struct cxl_dport - CXL downstream port
>    * @dport_dev: PCI bridge or firmware device representing the downstream link
>    * @reg_map: component and ras register mapping parameters
> - * @port_id: unique hardware identifier for dport in decoder target list
> + * @id: Linux id to enumerate dport instances per port
> + * @port_num: unique hardware identifier for dport in decoder target list
>    * @rcrb: Data about the Root Complex Register Block layout
>    * @rch: Indicate whether this dport was enumerated in RCH or VH mode
>    * @port: reference to cxl_port that contains this downstream port
> @@ -667,7 +670,8 @@ struct cxl_rcrb_info {
>   struct cxl_dport {
>   	struct device *dport_dev;
>   	struct cxl_register_map reg_map;
> -	int port_id;
> +	int id;
> +	int port_num;
>   	struct cxl_rcrb_info rcrb;
>   	bool rch;
>   	struct cxl_port *port;
> @@ -750,10 +754,10 @@ struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd,
>   bool schedule_cxl_memdev_detach(struct cxl_memdev *cxlmd);
>   
>   struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
> -				     struct device *dport, int port_id,
> +				     struct device *dport, int port_num,
>   				     resource_size_t component_reg_phys);
>   struct cxl_dport *devm_cxl_add_rch_dport(struct cxl_port *port,
> -					 struct device *dport_dev, int port_id,
> +					 struct device *dport_dev, int port_num,
>   					 resource_size_t rcrb);
>   
>   #ifdef CONFIG_PCIEAER_CXL
