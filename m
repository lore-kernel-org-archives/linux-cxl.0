Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867D9433DF
	for <linux-cxl@vger.kernel.org>; Tue, 13 Aug 2024 07:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723533095; cv=fail; b=KOI2T7+MT05PYzg9XudS8LPP49En4kunkCffumDiBHdSeYIH8qaviNWqBilp6+eO54348u+hvywWpTAEcRiKUn5xMY3qqG6K8ELwcMrjFee+d6cfO6Qb0C/v+TGNo1atBoDIOXT/yv20P7dlZGkQN26UtowjVPEUZpdcyN8uh88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723533095; c=relaxed/simple;
	bh=DMmztZqam1Xov3L5RwGGFHU1KSP8Du1HLCZA/jAwchY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GnPSPA7rH/Ha+7hUMJjpOXY/7d5wlQ0MELOkdRyLfpMBJmrcgbmBpvlehImnVJr8UAba/K+ikfJ1nbcZcAg/UqCAcvKsFyuxfAwSbb8OaNYAan5Ac1ifT5zQK5eq0HrsjLN26XV4Gar5v6PR4XIUrr+Sr7MFX5CWZIu7xrbzm9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=LQDK+PKO; arc=fail smtp.client-ip=40.107.93.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="LQDK+PKO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pu/i77k55/hAWOXkqfDPp31kmeOGVONghffJ1vDVneiPoGNH0rOHcDyzXtqcdjbPvS4b90Evu3XP+aOg+RJLk/jUkKvAp3eVT8frOqaoamdX00mT3QllGaXO0olkt/UybEvsapE/Gd5XkY1EenF1Wyd802vf+dJnGvE7u0AYW7hCYUlReX7fJwtWeVr4cekUQ0jggSzwboQHdsgx/8pvyIgV7mrvTN9Bxws6qk94y8xNRViLmlC9M0gsDqW1sWnkLeBDjSVX1Zggg/jWsQZVN3gNLJYeIgPMpjYCUG7RJSfFvxT9oqywi21E3WkLvlfARMqNA80fuQL444PQosUlFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q73Cl/lTcis8Hm9bW5VYypClDdQijxs7j7L0SvIjkAU=;
 b=KxPc1ed23gaSA5CZ6abUizFOy+VH7QLpZ/HvHVncZIygomYwxIhUhBjsrXDIOqwP0WLzfDAR+D22URi3d/t5y1ls3jRFoXyFbiAq/vSZJZvMS4cny82eg0EkbQfF9hEhRKnWu0YWVNgvW1b+OnOfe1H8jmwYKypIowhPxfAfMKdXs2LNzLMesAB6c0OqsmCAfOc0c76acQvKfNQdR6CeWxTi1umADv2nGIIetyNDsuf0pP6U9MDeVUyCXHq8PmTaltL0UwtDU6sS084upAzoXWTEmZSPJN3KQBAVrQAhqNZc2oCXEYzxKrvx3G7z5KKKdxySccO9frucDUV2TKPstA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q73Cl/lTcis8Hm9bW5VYypClDdQijxs7j7L0SvIjkAU=;
 b=LQDK+PKOiDF9ZB/OySxNCMlI0E0RDQRXw3vOKae3vzQXHg7GfvcJZDP5WpVdf6U16OSwkrJgZGInqbO0vw2+kNYSA1Q26K2rcY+6Xld6mv6ibf+i6h0WRJ4k9r+hjN16YT5dov3whW/QwUJDsx8+vS9i+A/JiEIhI+ICQO80wyQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by MN2PR12MB4112.namprd12.prod.outlook.com (2603:10b6:208:19a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22; Tue, 13 Aug
 2024 07:11:30 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::f943:600c:2558:af79%4]) with mapi id 15.20.7849.021; Tue, 13 Aug 2024
 07:11:30 +0000
Message-ID: <3a3bddc9-08f7-0192-5a2a-d14f199721df@amd.com>
Date: Tue, 13 Aug 2024 08:11:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 0/2] cxl: Pull out mailbox bits to be independent of
 cxl_dev_state.
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: alejandro.lucero-palau@amd.com, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
References: <20240724185649.2574627-1-dave.jiang@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20240724185649.2574627-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO0P265CA0001.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::9) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|MN2PR12MB4112:EE_
X-MS-Office365-Filtering-Correlation-Id: 001a9102-5d38-4595-c002-08dcbb6727e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bS8wUzBrZzFzNTllTUNwVndtV2NyWUY1NHd6ZDY5blRYcjdCVzB6U1NrMTBo?=
 =?utf-8?B?Wk1OZVJEbFhRdW53dlBGWDhLOXVoaTZEZzFxelFpdFp3aFl6TXd1ZEJHOHND?=
 =?utf-8?B?Ujc3am1rZXoweXVFekp5V2krd0VuWUl4VFBLU0tXTk9HUWV2VU83aFJMOFg3?=
 =?utf-8?B?aXJyVzlZMVQ0T0dEK0NRbGJYaG5uVUJPWGJvS3FFdVBZNDNMNHhYUytGS3Fj?=
 =?utf-8?B?Q0ZBdzBtamh2cmxVVEJDSTlqZURCeHNIKzQ0aG0rSll6T3V6OEdGWjdZNVJw?=
 =?utf-8?B?TW1YMndrU2tsTno2YlVUQ1VXYXpPRTBvSVQ1UWwwMXdSaWZyc0R5eE1iVFNz?=
 =?utf-8?B?Nm1IUEJqQVNHbmxSNjFFeG0rWTZvUDVxWnJNZDNLM2gzSlhLblcxODRuM0cw?=
 =?utf-8?B?TnZHSGJvR0hRWXhCM3pDV2lBblBXNVNWcmRGc0ltb1FPTjJvOEZBUEhWd1Bu?=
 =?utf-8?B?dG1TR3IwMmJWbFd4UENpV21oeVpsU0Y0ZDRadHhmRk9PVEdlTm9zVDJPT0Fu?=
 =?utf-8?B?RDg1Q21zS3ZTMk5ReDVlNUNjYUNudk9OZ1luaXZ6K0lFRXBPM1lIRnVWc1ht?=
 =?utf-8?B?ZVBBZGtpMTNUZDQ2WUh6UUVFNmZscFNRWVpJSHpvNGNpS2N5QVJ5WjU4NjV2?=
 =?utf-8?B?VWkvRTlhbnJDdTkvcDQ2MklCZGRWNUYxNCtLZFpnZnEvMnJJV0VSeU5HbDh5?=
 =?utf-8?B?dEl6Z2djRDRqbitCZ0FLN1cwUWdBNDVXTForUkgwQ3J4b1EvSE5qcTduZ3h0?=
 =?utf-8?B?U3BzTVNUSVVhZ081OVhWMDZsY1kvNkJieTluZHJpWWRKcUdueU5RYzRZSzVx?=
 =?utf-8?B?VUxWMlpNNGovOU9Za1NrNDM5NEVPM1doV2RZQ1lXNXk1cWpyV2paNUtscGEr?=
 =?utf-8?B?Q0g4cU0xcmJrOVdhOEdZRVpDM2c4b2dydU1xZ05WdFBkVDZpdVJqdXVVR3BH?=
 =?utf-8?B?NXNEU3dUM0tpOFNRSURGRzVyNzVEL2dVUEhNZXliN05HZHBFVmszVXNIUWF6?=
 =?utf-8?B?bzBPaGxhSGhqWjRpZjVId2QxWURDNXk1a3ZSZzFJcTltUTA1cWxkTmk3NVpK?=
 =?utf-8?B?T2xEelgySTAzQTBjQUpNZmxsYTVaRlJJTXRnSTlrRXhlNHMzUUsrVVd2ekZw?=
 =?utf-8?B?dm11aTN1YlE5SjRZaW5Hb2lTbVdiM3NMa2t6Y2JHV09Xak5ZQlpteGsybkVq?=
 =?utf-8?B?UjRHUFNKTWQxbGdYZU9naUkvVDNuSFRwOXZrajZ5VVBpaTFjQlhTZWdzWjhO?=
 =?utf-8?B?SWhhRXF5NzBQTnZacGZLQ1dpZkZzc3dhb0ZnMVZsRWlOcEhXamNUNDdjL3Vl?=
 =?utf-8?B?d2pyT1JOeGNrWWwvOWNCQ2s2Y1ZFcWUzWWV2aEZTb0RuS1lsMDZXTjJyMi9Q?=
 =?utf-8?B?c01QYWJiZWFwUnNyL1ZDSmx0bHZxZ3B3VUVuV042RjRsTVYzN2hGRVhqQ0g5?=
 =?utf-8?B?cHZMWVZtc1FMOTA3QkJqK2hobU1vYVNuN0hsbWQxYTA0RWpVd0RBSG55K0hO?=
 =?utf-8?B?QU9iNEhIbDUvV282c0RSUkQ3SGR5K00vVytjN1JZRXZQbnc3Q21zOEVKODRD?=
 =?utf-8?B?c0dQS3dKRzFxdzdXT2ZWVFJTRFE1Q1dISEgvNkQ0NWZYZlEzaitnNnNXVEJS?=
 =?utf-8?B?RGZ6WVE4SlpBZ3JOZVFycUx4NVptK0YvbGJURnNaNUYyZmpRQmNuakM0VWlW?=
 =?utf-8?B?VEhpc28wTHpTTEgzY2tYcncyWmIySDRPWFhIWXdMMUR4NktFVUJuMkdVY2xT?=
 =?utf-8?B?L2IxQmczcWpRWHBVRktDRy9rWlpkQVVZMkhVNHNMSmdzdHFKMUJWa2FkUU4v?=
 =?utf-8?B?S01ORGlNcVNReVpkS3g2UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bkpUVWZ5Q2pUQ1h1R0hpVGhiemR0WWVWLzBrd0pVRTZHKzJMZWlLanVjamoz?=
 =?utf-8?B?eU5TdTh5c0Z0VFV0UzVPaEI2NDA4RlkveTBIb3JyZEJLVFh3cTUzTEFNYkJF?=
 =?utf-8?B?djl3Ynd1TXhGejg1emRCd29pa1BFV1JtRmdRS0x0a0tSemliS2o5RDJETFVy?=
 =?utf-8?B?VUVQS0I1UlFQU2FpNEFkdGdidjBPOTgycERNVy9ic0NZcjBqOW9rNUR6YWwr?=
 =?utf-8?B?VHFHdkFLYXBscmhLVHh2a00wVjBaYld6ZUVYa2FZWm5MUlU3TmM3anFRZ3VS?=
 =?utf-8?B?ZFdtOWtSdHBPOW5HclBZV3RPUy9ibUZldWk1ZmRIM1VqSDA5Tjh4QjVSc29x?=
 =?utf-8?B?RU9oSjhCMFoxbGkrbDZKR2cxWm1VRWJpSkF3WEUzbXdVRTd6REtaaWxNTkpv?=
 =?utf-8?B?bjQvdkU3NnRXRllFY2swZmNYeWpSR0I0VW5rM0VkbDZqbkZMUmMxZnM4NFpr?=
 =?utf-8?B?b2lwYWpac2xsSm0vWWdmZjY2Ny9Sb01SajFwMXg0bk4wVE9BNExmYlgzY3lN?=
 =?utf-8?B?azJLbkdZaWZMLzcrWThXOHd4eTVPMlNJZHdyMU5qVVpjTDlRV1lDS2JTSFgz?=
 =?utf-8?B?NHQ1K2Z6N0M5eWhvR09RbWJFcjlXaVJmVjhUREFNYkZSejRMTjFhVWZuZ09E?=
 =?utf-8?B?bjJxcUYzSytlZGw4bVJtRGduMy9CTnVGczluZHk3YXBxbU9jMFBwdkpwQXZD?=
 =?utf-8?B?RjlVS0VScmttL1RCUjl6RHVidlp0SWVXei9FVTU1WWEzODRpaFVpY2xJUjli?=
 =?utf-8?B?UVM3NFhVOWJsbkpTMUdMMnp1NWF1YXBvYkpGSDljVHlRaGtKQk1idGJnd01m?=
 =?utf-8?B?ZjZvVjBqMzRJMlJrZTlUT1pqa3c3ZkxJekN4OXVjL2pUcnh5SXhIeXlCVmkw?=
 =?utf-8?B?Y0VIemNxbnRxRzZrQjM3TkM2V09HV3ZqODBKcmNSSW5nbjNMdktsb0xZalEr?=
 =?utf-8?B?aUdnTEZpaTdVQ1BWSjc1Q3VOTDR5SGo2R0ZkY0F0RGtSUXpQMHRoeDZmVkYr?=
 =?utf-8?B?Y2tEb2svdWRkMTcxNjJCb1dUaUphZXhVUUhTZ3hIQSthM1dHbllNeDR5QThH?=
 =?utf-8?B?VmNReWovdk5KWHB5blJCdTZzYTE5WDBxT0hPZTdLSVRRaU96eXFIMWYzenRG?=
 =?utf-8?B?R1FqblE5MGYyeXJUSTlSQWxPR2s1aXNGZ0tDMmgyZnlSbUR0eEZaNlBKU3Qr?=
 =?utf-8?B?dlZDM25mYXNUZnpBWktUOEkveXpaNVJQRTkvcm55bXIyZm5iWjdkRC8raDMz?=
 =?utf-8?B?Q1lxZFVKS0htUnUvUFJVZ3A3NWxaZDd4UmFha09aZ25NbVhvOXFwTi9aV21B?=
 =?utf-8?B?dVdzTVVrSzBZeVRwNWEzb3ZNYXVNYWduTkpzOEpsci9pbWEvUmFXc0lvOFE5?=
 =?utf-8?B?NW9KbERsRVJMdWtQbzdsK1BHaXdXWFNSNVBkZUVQOE1zZkdTMW83NzRhcEtm?=
 =?utf-8?B?Q1NNWUdIMlEzdkNUZ1owZnZHMW1hNVZaVEE4YS9yeGpmYlduTSs5QjIzWmxY?=
 =?utf-8?B?Slh4dmdOSTAzdFhoQmRQTTdydmlVd0MwWnJ6c3BZV0RqZ1FVUlg0eFVvQ29O?=
 =?utf-8?B?MTdhdlh2Uk85eEF0SEFBNS9IaWhMaHJMdlYxTWN5NmU4dGNObHJieXJlTENS?=
 =?utf-8?B?c0NURXUzYVkrTnV3WDE3cXdZcm9ybTcwb3JleEoxTWpERjBpQ0daM1FrNUZh?=
 =?utf-8?B?N3VmckJheUYwSy9RQnJrYVNCUFVKUHQrYnpTL0JJdHJEN3J2VGVEN0xvbDEv?=
 =?utf-8?B?UTlUMWZBVnR4ZWRsY1V5aUI4dktSTGNPa1BBdkpkcmpQdm5rejdseXJMM0Zx?=
 =?utf-8?B?NVZaRStLUlNOSmdHSUQ1V3lCM1ZEb0VnWmtuS1ltOTJGSzJrZ1JuZ3dWWTFh?=
 =?utf-8?B?aTdwRGJvbmtqbkV0ZlVXWjZKVUxNNng3TGNPNzVsU2NFQjRMK08rcnEwR1BR?=
 =?utf-8?B?eDY2R1FkNzNSS1hrQlFEb29tTEFPdmxlUFI2UmdjMkt3VXpac2paYVlwZDVQ?=
 =?utf-8?B?N2E3SjhTaGUzRXQzeTJkTTU1WkxDWkR5dkZYYzVZRFFSN2N6WldwZ3ZKZ1Y2?=
 =?utf-8?B?ZWlJaHg5MU95b21kWjlVWktPOG9kWmNYVENNdUg3S1pxaHM1dDNqeVV2Mm5S?=
 =?utf-8?Q?dx8yMVWCGvoFkS18spn8Fg2oe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 001a9102-5d38-4595-c002-08dcbb6727e6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 07:11:30.7626
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DT583N2cP8zwcnWvwXLV2HkVhMSYth95oZ3iapxlpzVU/Y2Ae/SOgE+qJscNzWOmZF32HhSgmtPgLo8SdefWWw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4112


On 7/24/24 19:55, Dave Jiang wrote:
> Hi Alejandro,
> Please feel free to pull in the patches in this series into your type2 series.


Hi Dave,


Working on v3 for the Type2 support where I count on these changes being 
applied.

Thanks!


> The patches pulls out the related mailbox bits and form a 'struct cxl_mailbox'. A pointer
> is created to point to that in 'struct cxl_dev_state'. The cxl_mailbox is independently
> allocated if the mailbox register is discovered. This should separate the mailbox out
> to be used by CXL type3 and type2 devices.
>
> ---
>
> Dave Jiang (2):
>        cxl: Move mailbox related bits to the same context
>        cxl: Convert cxl_internal_send_cmd() to use 'struct cxl_mailbox' as input
>
>   MAINTAINERS                  |   1 +
>   drivers/cxl/core/mbox.c      | 139 ++++++++++++++++++++++++++++++++++++++++++++++++---------------
>   drivers/cxl/core/memdev.c    |  55 ++++++++++++++++---------
>   drivers/cxl/cxlmem.h         |  22 +++++-----
>   drivers/cxl/pci.c            |  88 +++++++++++++++++++++++++++-------------
>   drivers/cxl/pmem.c           |  13 ++++--
>   drivers/cxl/security.c       |  23 ++++++-----
>   include/linux/cxl/mailbox.h  |  28 +++++++++++++
>   tools/testing/cxl/test/mem.c |  46 ++++++++++++++++-----
>   9 files changed, 301 insertions(+), 114 deletions(-)
>
