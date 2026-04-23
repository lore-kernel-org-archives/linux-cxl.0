Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013021.outbound.protection.outlook.com [40.93.196.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44AA440DFD5
	for <linux-cxl@vger.kernel.org>; Thu, 23 Apr 2026 07:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776928582; cv=fail; b=bFf/DTowNqXlS70eOeNb/wAoGnWClZyYsAHfc/FJW5Q2KIE911aiq/sOP2st6V7KYmQwi2yp8THzFqceqcFOxV9mDrQFRg25KgUgjgNPg6tft/yqDekIaKpXcg2PfcXipZ/aOWdB23t2PDVR0YN7HhZKa78FHXQ4YbAv/oUsBAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776928582; c=relaxed/simple;
	bh=MuHWXmXQlJUZXHW8NnP8bgj1Jisl97mmbKdLjWiLR7Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UsxTjeOBFjANsysznzzbQcmtDTHbEZoqLqOD2p4DNdtzxurNFFwf05b/6AvNRreL0IOEx3CFnYsBJASoT3+s4dz4xxilzc+1u31B1lOH6lBrII+Q7jS2mJmDbKO/Y5dJYjl/pD6WjA3/GT0U/cA82LAcNyHfOb2ADZXHfBPPkFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JaaY3boh; arc=fail smtp.client-ip=40.93.196.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JaaY3boh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cpT8A6E2vdlyStdnkecDO0yJGb151eE9zRxegH4hMpfrDcp8uHo86KCVkt5NjoZ9tXkW4C6vWw9qLKd8twCT6DxqAOZ8fOw2lMBiBv60k9gK9ZlVwTdDUM2w197h4ut5IbsOaq9dRuZlDaHpGq3OkDXU+ltHnl+XcsSDC8XxYprqzx+O7BtHzIQdEYVev6jktHZid3lhXJq7IyoQQ85vXs2rZjp0N7vcfpiD33Iji/zCUu6EGwJhANzj539bpRRXHfgZqs4h0qYFdXARyCzw6IMRizsye5Ts1zvgz9MMTDpQpjBNkwYyndundrbz7SOgB85WVTzzr+obWGQdxJc10A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ueVMdjnhDjKGDtEmQX7NPryzcxJja+VgLWHCuru81AM=;
 b=jaNDXTfWaGPLWL0RfDgZr3Kf1gzK/9CymFWWJ60/K6QncwCqX9zpifsg24WH9Ro6nCFI5pCYju79gfahB5gz8DNw87eU3TPmiSUSzYL2HDZR9t0faGHE6rB5cole7aE98/sc2rYeM4AIPYhc3pgw4jRwOjbHt8Az2oL0+/7hO6TGzI4w5Ok4gwx0SAviDVDJKyRC9uM8VZzFpdFi8q2ID1f42DopJUucS3mh/4sDKNNgiwcUpR8iBymTC7xhOJICqDB7EygDrv5lmy5NPTOsQcHcuA5jlj3+uILDY3KID63nPpS6Vm8ApleP9GqFfwbovT13XI3e0i4rXcB8kRvHTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ueVMdjnhDjKGDtEmQX7NPryzcxJja+VgLWHCuru81AM=;
 b=JaaY3bohBfrWDgQuquc0prrgZOqhu7h8FU4FBZ3w12lLMRwYg1sbx0x4eWyWjwbbLBm4HCD8rgWORB5GR4sK4J6bSCHU4sFiIgvXEUMTzx4iejmmtuLU1c5lTQPzvs2IK7OlFd0jddbCTGy1gZNFSucdtf19pknTj4j/ITpjHZU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22)
 by CY8PR12MB7415.namprd12.prod.outlook.com (2603:10b6:930:5d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Thu, 23 Apr
 2026 07:16:18 +0000
Received: from DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d]) by DM6PR12MB4202.namprd12.prod.outlook.com
 ([fe80::9e55:f616:6a93:7a3d%6]) with mapi id 15.20.9846.021; Thu, 23 Apr 2026
 07:16:18 +0000
Message-ID: <c65851c1-4fca-46ba-8dde-fa10b7cb9cd3@amd.com>
Date: Thu, 23 Apr 2026 08:16:14 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] cxl: Add CXL type2 accelerator support for cxl_test
Content-Language: en-US
To: Dave Jiang <dave.jiang@intel.com>, linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jic23@kernel.org, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, djbw@kernel.org
References: <20260422230237.2599333-1-dave.jiang@intel.com>
From: Alejandro Lucero Palau <alucerop@amd.com>
In-Reply-To: <20260422230237.2599333-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0236.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::15) To DM6PR12MB4202.namprd12.prod.outlook.com
 (2603:10b6:5:219::22)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4202:EE_|CY8PR12MB7415:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a9417d8-0a88-4296-9a06-08dea108369e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	4onufUf7WlFELniwkC5yxijUnUR5McSIpf/SWq7ks7xuh0SISv5wty07o7kGM7HTMVb9sS+LSz++MvuwiTt2p5SDKaDHGMQ+YzKVlqFCTrEo26FuGzKYNNtxRlA/pa4+fobhPViJrCD4a0bDBr2/fQPxOtc6V7HQxBJxlSrrntSWNf/MJjI1gh0liam1IcpcKlmZSI8cKt+lWuTiJckfGEL3GK0ACsbu1sXzO6wKVCc5dc3dzQF4Fb6Djzw4doboRA02LclExXRqNe+6nw+yBXsoG6adlvQIMK9klSEX/cRmWKgJqBFwHsvBoaTeFAX/BAzL1qCo+S+5RRsfgHOj+GXGV2tI9Ay22PFkUcXqT1i93ZGqdVeuGCeqW4SgmLRawkfY6JB2Gl6uuPVOZmVcWhRAbQQDE6g395zRbcvKvjDbEfxArm8rXUuWayU/0fmKlpDAZfyLIanoTm5a3K0kaUuooRPoIN4vulQm9HiQKh+iW2IG0XUbz5kkthhq7wrAn9i0hTJfQ4TpC2faQbwfvmVXZqx9yd/+g8+sloPxHltlcDH8zboCfRTViu4AoNnAQvUI43v2rrrElWLyjdxhsAyOl9x2oZ8H4elW2WY6vjlqc0aCnspr+UKBx+t9AtlWo4iScGZOGqyFphv6uHOPRQQ7saR16mgAgU+Dpv+/uacXjBTcMcFLxLfh4Eh2+rhUtKACzcYgydBe+BIKcpDnmnep9vMIvPLRB4gMUXejCi7IDvFKjbH6mxc7h3PkQYxt
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4202.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWQ5WFpTaTY3TU41U2k3Y0VybXVoNHBGTFo4d081Qzd4bzZqRENJQ01QK0hN?=
 =?utf-8?B?UENYazFxcWwyWnJtNGhheTNJYWtsMDFET0dKV3lneHlOZzdCWXd2V3hpVEJC?=
 =?utf-8?B?V0l0VGNiMnFxdDFTQnRLbWtWZENQeENQVzR1S1Y0YTdSNG5SSlFmWjJoMHor?=
 =?utf-8?B?RHJPa29JV0tsMjJFbWZJaVFLK0xMeVBGTzk4ZmF3VWNRc1Fod0lZbyszRVFz?=
 =?utf-8?B?eTBNRzZNc1ZuaWYrQmhLbmttT1pVTlpqU3lzczUzUm95NHJpcHJZM2ZZVkRp?=
 =?utf-8?B?KzRCQU1FbjZUOERISmQ4ejRTRVo5MHkzZjhuSklCbDFUeWFyRll0ZEFIU1FN?=
 =?utf-8?B?eWI3elN4RzB0SGRQYXJQSUh6SWxMclJYNVhDY1B0ZFk5ekVsY29jamdBR3E5?=
 =?utf-8?B?KzNKa3RiSGlpNVBwbGJ3Q0JtNVdsajF0dzdXVkZ2YmJXcmhNSWh0TldjcWRY?=
 =?utf-8?B?dHJUbnk0aWtPQWRiRjFzSFM5aGtaejVCVlh5RGJyanZXbTJNN0d5OGw3akk1?=
 =?utf-8?B?WE5UK2p0cTZhMDJjNlcwQ1pEV09NeGxjWmpVT0xvV1R2OG9DaXBpY1ZwU3E5?=
 =?utf-8?B?NmVYUTM1aWJOK0sxbnR4MzViUHFvUkRubHh4d3Nycm1samNVdUNCaFM2V1dO?=
 =?utf-8?B?N0Q0bUVRQmtmUEVXWGZuUitJQjQ2ZlRFYm9OK25BOUVxNEd1czYyZ0hqWkg4?=
 =?utf-8?B?c2p3YzJ6cUE0N0dCQWpGTm44NTFiSStaeGVVRnE0OE9ETzU3L3dkdTJXV2t2?=
 =?utf-8?B?VUcydFd0QVJqZVpqOHBKalduRGR6RFVUYk1tS0U4RjhJUmNwYkxzZW01Y0JS?=
 =?utf-8?B?cXVocHVvSnI0dkJ6a3pmNzNNQUg0MzhXMXpHYVI1OW5mbURvU1hnbWlMNGov?=
 =?utf-8?B?NVZEWS9rZjNnQmRscW1TQzZWMG5NR29OTGQrdGVVaHRNSWl4R0oyMW5wZDZX?=
 =?utf-8?B?QXJYSjhIaC9LT0pLdnBWUUcvRUhDSTRrRGpyVXJMZ0FQTzJ6MDZFQWR3bU96?=
 =?utf-8?B?Y3BLVStCSHdlYjNJV2xRM3FKT295Z0VBc3lUUWdXa3VrWEE3ZHhqVWNuVzZt?=
 =?utf-8?B?NlhZNmpqdUlIeXNBRTJFVytLYXhKNHhPemJ3ZGFPZU5LakM3T1JQMWhaMktQ?=
 =?utf-8?B?eURWTkpEZUI4NHU3YUtTK0djd1dyNEk2VDd4RHVHR2pWSkF2RzhyN0tuOUd6?=
 =?utf-8?B?emxTd3E2Z05EZWsvWlRvWlVOUlYrR0lSSFJETXp1U3MxbDdRSG4vU3lYMDVX?=
 =?utf-8?B?NnRYeDc1dEJCbE4xK0hYMjlEeGV0V29ia3BjcmowMXUxcnRLUjVLbUl2SXE3?=
 =?utf-8?B?ek5BNkd4MDk5YmhCT0tmS3RGelY0b3E2Rkdmdkp1SDJ1WTZIdkRDaktRMS9h?=
 =?utf-8?B?T3ZnNi91cjE2c0ZGdGRkcjMrMzNac0hFT20wbUpvQ1d6Vzh2VUNKMzJqN2pF?=
 =?utf-8?B?Q1l3dzM0dzZsMElFYmFTSTEzTTROZVY5VzV1NVlQbFczc0dvRFYyeWZJOEJ2?=
 =?utf-8?B?OGQvS041Y2FGYkJPb3NBVVlyOVNneDV5OERZcmxac09pdDZIK1o2RjJPSU9j?=
 =?utf-8?B?UGllU2p4b2RWUGljZTE4MUc0VHhWKzdXeXRZeWgxTzVTU0JNbUwzQ2hxTzhv?=
 =?utf-8?B?SkNId3ZGenQyc2FCSER1R3dzODMxc3FNMU5ZeGRJdWdNMHVaVVJZZ1pRSXo2?=
 =?utf-8?B?eTRZcTdmdWM2WjBmUFVIcHNtNDdZVG5JN1FBaCtwT1JEQ2t2djZYb2RWYVBK?=
 =?utf-8?B?TkZuUDNkOEZBa0pKaHMyUGVKdUNwRzNFRUUyMDdSaElIaHhOYkEzQmJvMThW?=
 =?utf-8?B?Y1VGY2hsRzV2SitoeFFzTEc3UENkQnZmcXJvcFZVSytpWnR6Ry9jdnE3MkhN?=
 =?utf-8?B?bWR0Zk83OUxiaXYwQmJWQTNLd0MzY3FTKzVWYnZ0VmtwS3lnWDRpWUV1Z20y?=
 =?utf-8?B?TDNveHV3WjFnYmRhRitYYzJTbC9US0c3TkV4SzdCTnROUVJsOERsN254dVQr?=
 =?utf-8?B?a01hVzZxNElYUmhPNi9GcmhCc2NlQ2lUak5uSDh1aXU1S096bjI4VFQvZGpX?=
 =?utf-8?B?K3Q0VnRSQUlCaFA2Z3RabVo0ZG04VjNPL00zTGFQeXRkOTQzTjdDbmplR1h0?=
 =?utf-8?B?STBVdm83R3hLYnp0bkh3SXhhKytTbk9JNmJOclVQUloxa2pvbzE3cXVyZVFL?=
 =?utf-8?B?VG5vdDY1S3plMVZlODVwRmRicjlQYjJYUXVmSXcrK2JTWDVFbUp6VjZOaWNS?=
 =?utf-8?B?LzlJT2RsaE9ITUd4TjVKUTg3cStLZ0JaMFAzcEN1U2drVEJYekdsK0VEUEtn?=
 =?utf-8?B?bGthMDFvOUNvZDRydkZMZTBFTGNycmFVRVYxOWpONTlLTkRuRmpoUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a9417d8-0a88-4296-9a06-08dea108369e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4202.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 07:16:18.3463
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PoVxNzHRYa9RHKVs1p8XHiWk5duyMFasD3X/nS76QyWJxPHdfQldR3t+ff8kB32pCJd4DW2PnMGlI/guyFRszQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7415


On 4/23/26 00:02, Dave Jiang wrote:
> The series is based on v7.0-rc7 with Alejandro's type2 series [1] and
> with Dan's follow on series [2].


FWIW, in v26 I am extending Dan's approach as it is not enough for 
safely allowing an accelerator driver to work with the autodiscovered 
region for the cases behind, cxl_acpi removal or cxl_mem ubinding 
accelerator memdev.


Thank you,

Alejandro.


> Series adds a 'type2_test' module parameter where it setup a mock type2
> hierarchy with a mock type2 accelerator device directly under a root
> port that has an auto region setup.
>
> It also includes a CXL fix that was encountered when running tests with
> the new code.
>
> [
>    {
>      "memdevs":[
>        {
>          "memdev":"mem0",
>          "ram_size":536870912,
>          "ram_qos_class":42,
>          "host":"cxl_type2_accel.0",
>          "poison_injectable":false
>        }
>      ]
>    },
>    {
>      "regions":[
>        {
>          "region":"region0",
>          "resource":70300293136384,
>          "size":536870912,
>          "type":"ram",
>          "interleave_ways":1,
>          "interleave_granularity":4096,
>          "decode_state":"commit"
>        }
>      ]
>    }
> ]
>
>      "root decoders":[
>        {
>          "decoder":"decoder0.0",
>          "resource":70300293136384,
>          "size":1073741824,
>          "interleave_ways":1,
>          "accelmem_capable":true,
>          "qos_class":42,
>          "nr_targets":1
>        },
>
> [1]: https://lore.kernel.org/linux-cxl/20260330143827.1278677-1-alejandro.lucero-palau@amd.com/T/#t
> [2]: https://lore.kernel.org/linux-cxl/20260403210050.1058650-1-dan.j.williams@intel.com/T/#t
>
>
> Dave Jiang (7):
>    cxl/test: Refactor mock_init_hdm_decoder() to prep for type2 decoder
>    cxl/test: Add type2 support for mock CFMWS0
>    cxl/test: Refactor platform device enumerations
>    cxl/test: Add hierarchy enumeration support for type2 device
>    cxl/test: Fixup hdm init for auto region to support type2
>    cxl/test: Add cxl_test accelerator driver
>    cxl: Fix double unregistration of CXL regions for type2 devices
>
>   drivers/cxl/core/region.c      |   3 +-
>   tools/testing/cxl/test/Kbuild  |   2 +
>   tools/testing/cxl/test/accel.c |  71 ++++
>   tools/testing/cxl/test/cxl.c   | 717 ++++++++++++++++++++++++---------
>   4 files changed, 605 insertions(+), 188 deletions(-)
>   create mode 100644 tools/testing/cxl/test/accel.c
>
>
> base-commit: 6fa897f2d9a917c4bd7b911b230fcfad05a952c2
