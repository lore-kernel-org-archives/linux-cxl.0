Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2079.outbound.protection.outlook.com [40.107.96.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEF82F24;
	Mon, 24 Jun 2024 16:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719247570; cv=fail; b=gyBH4j7uqfVlCCEKNXRgmfoTRQmsFg5AJWvUXhS8xs1WO/iBN+deFNToPBBGmaWWG/T7wOSeN6y6EiEorO9W2mpGtDZKziXdMbjJLjZk6YMth2JUo2EH3ATd+qmQ8QCKLSIoT03Edg1vc7cnnFmP+tuVFgsfNzmMGj0/Q4Eoz1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719247570; c=relaxed/simple;
	bh=aQIwqFYYg5l2urOlBrsMadON72GWY51VO+JrzJRTWK4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ECcRyciyjAefu5mZmmLFP+SgPeZrVzMZPc/Sxbar2V/zxp1qmoz2CZOgSJo5w3+cKAgeViVHcPalQ0aTaMCuWJ2OPyZlf/Irwu0wjE3lkf4iWmAJDgoANWf7grVgUdfegTWBL5gp3p/pSHwUkRlMvTb/YPkld80KSl1+eBO4ArU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=euxTCt6l; arc=fail smtp.client-ip=40.107.96.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="euxTCt6l"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPExMAAt0UUMyIxjcBlmONGWZFpYRHJsvNupU+ntzG9TezXgSd1vuUZhNMHzJg0sUoB00Rn8XRVKvi8quNbv+r5jPXOIYxsyv4xeuv76aIOgMlCUlAOHZNMCaHKaP8+XBcHQf4xmGckPQDAmjfS86z0i/IehNbURJG7GtfGD2PyuiaC0epwnSEMIvc3T7YkLLse6f4fuJnuZbZnHcOGvmua9QcAiU8XCqmwmwx14JcAHVxIaK8aKZ17itoriZKHJ1ACEVgd574UHmqSWVUKsrFHIUfIyKRlnO5iH0Hpgyk9fDNa4mQ9OM9JZ610w6fk3M/Wz9/Uail89d8bvXU0rpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ybkdyNblnIIXqfWPNTf9TncQ2FseTsErE8rt6WcvOgs=;
 b=WxvIv6/vKw0D+4nyX0wkpnhGpe5rQ4l1RjPU8QyiHZrgl0nZcbFLhvmsSLyWrvZlAFWcU07ukiqEhyr2Aq6DIkAvysVJp5fxg+MI3AbtJDmVmq/WmzWedBN0fmx2PiudW0x/lNdJiX8uNTS9Ysx+pLsGu+Aym0jJoKMuiSFO9MdYomepAXWujbvF/0KQEWR9yUlknTa8+s/4SDjWVZ4VHsacOL4XJ0fF6867EPEkFA4vIREDYN0VZ989Nb0Q3+UrXwm0TbWpdvTyqTpf3L5LTvR5RXiEOKUGEcgSxZ3fKGBNlDoq0FO5eEeP/kgSoJUZohnV1q8uX63CRDfwj636ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybkdyNblnIIXqfWPNTf9TncQ2FseTsErE8rt6WcvOgs=;
 b=euxTCt6l0mcr8A7pGlZcYroEZ/hj+BQwjbnjOIVR5rdh+gdNI6H7aQuPnULXw871w1BypbCttvl3+bmYxDYdsrG1dj88Y00vyEN/ftEZM1ZuTRFda7pEm+l9LxI0EOWZ59u+7emu7ooJ/k42nai+Sos9/hPD8O1UalrBE/jxO6I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL3PR12MB6380.namprd12.prod.outlook.com (2603:10b6:208:38d::18)
 by LV3PR12MB9330.namprd12.prod.outlook.com (2603:10b6:408:217::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 16:46:04 +0000
Received: from BL3PR12MB6380.namprd12.prod.outlook.com
 ([fe80::66cf:5409:24d1:532b]) by BL3PR12MB6380.namprd12.prod.outlook.com
 ([fe80::66cf:5409:24d1:532b%7]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 16:46:04 +0000
Message-ID: <c5c1a814-0706-462e-81b2-f8ce814bbe9a@amd.com>
Date: Mon, 24 Jun 2024 11:46:01 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 9/9] cxl/pci: Enable interrupts for CXL PCIe ports'
 AER internal errors
Content-Language: en-US
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: dan.j.williams@intel.com, ira.weiny@intel.com, dave@stgolabs.net,
 dave.jiang@intel.com, alison.schofield@intel.com, ming4.li@intel.com,
 vishal.l.verma@intel.com, jim.harris@samsung.com,
 ilpo.jarvinen@linux.intel.com, ardb@kernel.org,
 sathyanarayanan.kuppuswamy@linux.intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yazen.Ghannam@amd.com, Robert.Richter@amd.com
References: <20240617200411.1426554-1-terry.bowman@amd.com>
 <20240617200411.1426554-10-terry.bowman@amd.com>
 <20240620141514.00007c6d@Huawei.com>
From: Terry Bowman <Terry.Bowman@amd.com>
In-Reply-To: <20240620141514.00007c6d@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0035.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::10) To BL3PR12MB6380.namprd12.prod.outlook.com
 (2603:10b6:208:38d::18)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR12MB6380:EE_|LV3PR12MB9330:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e79cb3e-1e7d-416e-4b12-08dc946d22fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|7416011|376011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WHdEZVZ4M3FyaXdORU5taUl4b2pYUUZLOUgyM0FobFkrYVl5YVlYeGE2b1ZH?=
 =?utf-8?B?bE01dWxSb3hGWVlidDFmRmZyUW9sM2tnR0lwcnp5TUN6SjQzQWJ4Q2FFUXdY?=
 =?utf-8?B?ZnVCRFIvWGJZb3lvc1doL2VPeS9aWk9zOEQ4Q1NGOVN6NzRzMzUxSERmNkpn?=
 =?utf-8?B?SjJCSFJCTkhUY1QvMG5JSjNrYUhsUUtZamNEd2lEVEZvUWpIRkVpNHVsWHkv?=
 =?utf-8?B?SWsxekcxdnlMSGZKVkQxTDNEcmEzNHJ0akdOODJRaGkvWWx5dlkzR0QvTklF?=
 =?utf-8?B?SVdqZWxPVFcrNHg2TThtQTFaaFlIUFpqeDNuUXNQQTVLRUs5UjRTZGVmZFB2?=
 =?utf-8?B?THQ0M0diU01DTE1GeGE1SkY0VVRWU2UwaSs0TU5LaDlwaUhNV2w2a0Z1eTNW?=
 =?utf-8?B?M2RLbiswcFdFN0MrVWE2RytIMW1OaVlqQWpaVEJpUW8vYmh6NExsOEp5S1ow?=
 =?utf-8?B?UlE4QnB3TU5KQTRyN1hVbUZXSmRnTHc4YzBXM0FmVmxwcXRlQUtMSXlFMVgw?=
 =?utf-8?B?ejJ5RnNzTjErY2xxQmlTeWM4K3ZBalgxWjFlRkcyMkJRNWpseTNCcm12T25U?=
 =?utf-8?B?WktUTmhUWDJqVUlaOTVJT0NRYnY1aXlwR2k1ZVNtM3Z6Q3NiQUt4M2pMNEFn?=
 =?utf-8?B?dFkwb2tKWHVFZlJDdEM2LytYOFBDUWprMnVPWUhhTGx0L3Bab1V1YmlxWGRP?=
 =?utf-8?B?UXpaTVNmcHcxK2tlK2JVbGZCZmcwWW9JYUtrbVl3N3pBVzJuQTdkRWk3ZUMy?=
 =?utf-8?B?Szc1UlcwNms0eDdKVjBUaGRlNis3ZVBhRWVkd2lwZi9PaHRkeDFvcU4wUi9t?=
 =?utf-8?B?ZStqU3FvZmpRWjA4VmNxbGlPMDl1YVhkekNuZis3ZEN3SzU3eW1xUlVZazZi?=
 =?utf-8?B?VlRDbWgrNFByY1BMTnpvcUZUWEJPM0d4UExsNzMwV2R2N3pFdHlJd1RrTXVy?=
 =?utf-8?B?c1hOMzFQUy80bGM5ZDY3VzBFWDVvUEw1KzAyYVBaYkNLZkpWTjV0NC9wVEFn?=
 =?utf-8?B?cnplK0FIQTRJMFlla2FzaXQxL0hGMHV6L1BQOEtYdGd0bXdBVGp4R2k4SDdu?=
 =?utf-8?B?Mzk4TjlPV2YxVnlXbUEwR1A0bUs2aTNSZ2VROWVRS2poV2hSTlM1V1Q0U2sx?=
 =?utf-8?B?eFFKVE4vTmZ3WnZKSXZPakF2dmlrMVlwT2Z6MWt0TFZIWFJMb2pXU0tyVHhI?=
 =?utf-8?B?T3ZiNk9OL21WSDdQZkZRdmVSUnQveUY2QlZVMzBLTkdBWWU3aEVmUFdJdUNL?=
 =?utf-8?B?Mmhvc29nQ3Qwek10b09QTFYvSncwVGZzVDdqc3M3ZXBwSStUN002Tm9GalNW?=
 =?utf-8?B?aFJjKzFzUHFwK2FCVy9yKytwbllHWGt4S3l6R3o3UEY3SWFPanhMM1VkYWpM?=
 =?utf-8?B?ZGJzN3N4M0NHQUZPaWZhUndZdUtSa1RWQW9XdG5MZHE1dEx2eks4RWprVWtm?=
 =?utf-8?B?QlpPekdHWm93aUVPa2JrVFBkbjRkRE1ScU9yTE1hUE1TUGc1dU83aUhHZ2M0?=
 =?utf-8?B?SW5zbjlUdndWRHNCREk0eVBrTE9Ody9KaDN3Tk1tV2xXYzFXbmxEQUJOWitU?=
 =?utf-8?B?WDMyTHBCcUIrQnNHWFU4WVVyT096Q0FYV0RJeUc5Tmd2endPVnJmdWVyWGEx?=
 =?utf-8?B?MFdGdDBybitJeXN2Wkh0NHA1VWVhc0llOUlEdVRuMmNyRUxwT3dNOWVlRTE1?=
 =?utf-8?B?cElJL3ZEMzM0eXBRYVNzdURENlhyamZMT1Y1Y0QwcXdzTzZCcjlYK24zNkNy?=
 =?utf-8?Q?qCsKiDnhDRfe0ADWjke1CBzw5cz3D82iRMVEq9G?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR12MB6380.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(7416011)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MWdzOUM4QTh0QW9Ya1FUTlBxQko2K3hHUXRJY1dBcnZxZXdTWUNFL0Z5THND?=
 =?utf-8?B?VWlmNEtTbnJqdXRsY0xmODN0WkxFQ1drbVlIRGRPSzNwYmFpRE0wdUdlTi9D?=
 =?utf-8?B?ZVBsTnk2NDlzckZPQlVSTkJybnpFM1Jwc08xcDhLY3FtSXJQaVhYYXFuMm85?=
 =?utf-8?B?WGVpcDRSNmwwM3J5ZlhhZ21NKytla3hJTGhXOGNvUjUzYW5DRDloZ2xpMkZi?=
 =?utf-8?B?M0E3blNYYUhnME04UHYzSm92bXNXTHZLcXFTb0gyMW1lamxMQllYM1ZvSHZ2?=
 =?utf-8?B?WEgyQ2p3blFYQlFRa3pQWFdmSDJBSnlvRWU5NGkzdmNTYllycHpka0JheVVW?=
 =?utf-8?B?TmNMTEFDNGI4WVZNWm1XRU5aZkd2VjFwTndtdkFuM05kWjBvQ0xrcTFRTUxT?=
 =?utf-8?B?ZW1id2pFaGVaM2pSMHlneFQ2NnRrbEVMcGhRcThrWU4yckRZUjVqNTUvcHVk?=
 =?utf-8?B?SDRkb1BtZkptQXJLL0F3N3FPdnV1YnhnT1pxNXdDRVFyTDNtclZORzJZc3FJ?=
 =?utf-8?B?NDNWRklzMmo2TDdkTXB6TXVQa1RoUnUyemFYWk52N3NXT20xK0tibzhGclJp?=
 =?utf-8?B?OEJ1VmVXemVTVGxqMVdwTFBCY2VLcDZqemZEVWdXSkxmM2RCZWdkNnh3eEcr?=
 =?utf-8?B?dERQSmkwM2djaVlqNmJKaTZyT1lvTW4vNk1UU2cxVDd0MXpnMlhKS2U3SkVz?=
 =?utf-8?B?NXdZUGpQd2d4NWJuNlQyNGhJVEdIVzk2UFhRODBrRzZYOVU1SmtTb3lvcEtT?=
 =?utf-8?B?aGxMS2RxQW12dmRlQnQ3SjE1N2RMbVh4ZVlNYnNXaUxvUXFoSHl1c0dOU1Rw?=
 =?utf-8?B?NC9tcFN5OU9ybk9uVFZwNldzVWRsemhzZUNzMktiaWtFWkNTeUFuUitYMitQ?=
 =?utf-8?B?RHhSVGJVMFU3SEVrUDBmelRUQjFwTXFLS3ZsVG1iZk05TVdCU1p2bTNpdkVB?=
 =?utf-8?B?b0RjWFU3VldNRENJanVmOHJKMTJicENIQjV0dStrOGZaYnVZVk9iaXo1dzJI?=
 =?utf-8?B?M25RZ1o3ZDJZQ3ZvempjdWZQZFQxOWpTWVJ4L1dhZnZCSG1sZkF1c1FoN2Q2?=
 =?utf-8?B?YlB5QWtnS2FYa2hnUTNhZTF6MlFxMTdqa283ZXh3MkhEN0V2enNxaTFGNlF6?=
 =?utf-8?B?K0FvQmVGU25HWTMwMTBaNFBOd2hrQW9JZFZKTzhGMUQ3eEEvMUFURU4wSU9F?=
 =?utf-8?B?QVUyWUFZbDVsNlB2R2s1Y0JxWHIzSjNQQWVRL1ROREFleTFZVFlkOVEwRXl0?=
 =?utf-8?B?dlFPRHUyaXBYODVzcE9nZEhleUpPNTRKVVpWSVVQL1hRa2t6VkZadzVIK2Rw?=
 =?utf-8?B?bkNZQXZobW9PWmt4NUdHTy81d283dGNrSVJqQU5JQVhtdUV1aERrMXFudFhK?=
 =?utf-8?B?Qk5vVUZ1RFdqNVJEL252VEVSb2I1a0ljajRhNnpNSDg4Qk1aR1JhRk1pN01k?=
 =?utf-8?B?R0FwSTNvSzBRUzQ3Y3JobmUwN2tXMlo5ald0THduWitLSkw1WTV0UWZpeHE3?=
 =?utf-8?B?RHNXQ2JTUUZKOEtWdFY3Wnlua1Bmbkw2ZXI4ZXc3ZGZvZVgyU1BvSlA0aVl6?=
 =?utf-8?B?MjVLTkFCbU9VTC9pcDZWMXZ4ZExad3NhZFV3WUhhbWZ0bjQ3TXV6NVhobzRB?=
 =?utf-8?B?L2FEMkVOajF3cEIyMDVYV0dZaHhod1JCWlJuaVZkcEpVR05DUzJmeHdLaE9T?=
 =?utf-8?B?MGZ0N0d3OHE4ZGJOK1dCZnZxTGtkeGZjeTNsSldiWDdMVlpPT2x6ekpsM05v?=
 =?utf-8?B?OG5ORzZ1NGJqR0s1VW5heHdjbm1GVCtiQTlLemtyY2lSUWh1WUI5M0FOSWlm?=
 =?utf-8?B?ZXJOUGNYMC9hd1lYTDV6U1UzancxaytxYmJoeDVIbTh5MGJOenBkdHB1eDEr?=
 =?utf-8?B?Rk5PbndvT1Q4Zy9idjRKQVJ4U3RFZ1RUa3Z4MkpiTTBwQjRJMXQxYlFieWVX?=
 =?utf-8?B?VjZuVkZkRmFuR2E0NFFkR1k0eEpQVDZOTUdYZFZrZjBIMCtPWHVubVA1WC9C?=
 =?utf-8?B?YnE0REZaRkQremQ5dkRDV2JiMnFUb0ZvcmZ4VXZkeWV3SWNWakxIYk92cXNw?=
 =?utf-8?B?V08rbHN5WEhBVUxKTVBEM0ZmTzc0a1Vmb1BETEZySHh4T0x3SkJ6enlibFZN?=
 =?utf-8?Q?hDjqHwqfItp8hh7WV5H5eD+2s?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e79cb3e-1e7d-416e-4b12-08dc946d22fd
X-MS-Exchange-CrossTenant-AuthSource: BL3PR12MB6380.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 16:46:04.0990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HyhU0NeK6vlYVoBya++Ggy/iRMxvUAO80zDoMQB4/4n0/B3B7nR0Maz/TLZsbOeJexPIfyU8++9VWaBQ2oG95Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9330

Hi Jonathan,

I added responses inline below.

On 6/20/24 08:15, Jonathan Cameron wrote:
> On Mon, 17 Jun 2024 15:04:11 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
>> CXL RAS errors are reported through AER interrupts using the AER status:
>> correctbale internal errors (CIE) and AER uncorrectable internal errors
> 
> correctable
> 

Thanks.

>> (UIE).[1] But, the AER CIE/UIE are disabled by default preventing
>> notification of CXL RAS errors.[2]
>>
>> Enable CXL PCIe port RAS notification by unmasking the ports' AER CIE
>> and UIE errors.
>>
>> [1] CXL3.1 - 12.2.2 CXL Root Ports, Downstream Switch Ports, and Upstream
>>              Switch Ports
>> [2] PCI6.0 - 7.8.4.3 Uncorrectable Error Mask Register (Offset 08h),
>>              7.8.4.6 Correctable Error Mask Register (Offset 14h)
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
> I'm not sure doing this from a driver other than the one handling the
> errors makes sense.  It is doing a couple of RMW without any locking
> or guarantees that the driver bound to the PCI port might care about
> this changing.
> 

I think this could fit into the helper function mentioned in our earlier 
discussion. When the portdrv's notifier enabler is called it could also
enable the UIE/CIE.

> I'd like more info on why we don't just turn this on in general
> and hence avoid the need to control it from the 'wrong' place.
> 
> Jonathan
> 

I was trying to enable only where needed given the one case is not a 
pattern, yet. At this point it is only for CXL RCH downstream port 
and CXL VH ports (portdrv).

Would you like for the UIE/CIE unmask added to the AER driver init ?

> 
> 
>> ---
>>  drivers/cxl/core/pci.c | 12 ++++++++++++
>>  1 file changed, 12 insertions(+)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index e630eccb733d..73637d39df0a 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -861,6 +861,12 @@ void cxl_setup_parent_uport(struct device *host, struct cxl_port *port)
>>  	struct device *uport_dev = port->uport_dev;
>>  
>>  	cxl_port_map_regs(uport_dev, map, regs);
>> +
>> +	if (dev_is_pci(uport_dev)) {
>> +		struct pci_dev *pdev = to_pci_dev(uport_dev);
>> +
>> +		pci_aer_unmask_internal_errors(pdev);
> 
> I'd skip the local variable for conciseness.
> 
>> +	}
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_setup_parent_uport, CXL);
>>  
>> @@ -878,6 +884,12 @@ void cxl_setup_parent_dport(struct device *host, struct cxl_dport *dport)
>>  
>>  	if (dport->rch)
>>  		cxl_disable_rch_root_ints(dport);
>> +
>> +	if (dev_is_pci(dport_dev)) {
>> +		struct pci_dev *pdev = to_pci_dev(dport_dev);
>> +
>> +		pci_aer_unmask_internal_errors(pdev);
> 
> likewise.
> 

Got it.

Regards,
Terry

>> +	}
>>  }
>>  EXPORT_SYMBOL_NS_GPL(cxl_setup_parent_dport, CXL);
>>  
> 
