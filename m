Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF068C77B7C
	for <linux-cxl@archiver.kernel.org>; Fri, 12 May 2023 18:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjELSJ5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 12 May 2023 14:09:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237634AbjELSJp (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 12 May 2023 14:09:45 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78271702
        for <linux-cxl@vger.kernel.org>; Fri, 12 May 2023 11:09:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccUCRr0xdRJxa1t6h4veRyjYgQ3OKsh7njng1fjJw7UofDOB0mVHbRbwYQUWA/nK7tSEAFeD6n3Zh5V6eYsNXEqCiq5U722TucH2Xjgvrq3IGUxVEfTB7TbWP7Lrr84cmx4tFTa+tR4Kjq4ZJEttJXx9/fPecXfSNqO7fTjYktf0tRmVQlaYW2GWHefHRbs6S8ldrfNzY5KNqskwKvnYvyfzVf80w+XQXKOseuFll8SDdnPQZVVOw82V4JyR2plBEiPAdLz7MzHOX1c7hEYh4NiyONQDUtktf2dl2R9aP8o7hn4xFvR5CKwulrHVocPtx4oMirfeLhxqhfxUVtiTNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OlH7/v0ZfPETm2uipHihWwD6BGXhKAzH/q2TnKMCVCs=;
 b=IDg6crBYPOxTcwdehzcpA8hkFtYChpTw/aHco4r44EZeW8aI/5IZjeLIqupRJ2VJxBN/MNsGkrMECPj79a54fBE9IVrUZFnnQI1L91AXWXscNtFhkNpURgiF6NGPaKwcc82AjFyny2ARc8LD5SdCYSzvLEkwYl0hhq+T4oDXEgoqjg8HX9y67wAXrsNiqIXgN2Yj0zW8R+bmFrvtECQVW8wEW+HWlgeaAJwO01dKfMmBqjJXAHC124Wbtty/6CbO/GnRs9QaAoUbIowrumDvM+/D3yCb+Ld5elXIya27PyHP/ngcdv+wPWjw9FsbEup56WY5/nigBkI2a+p/FHCwCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OlH7/v0ZfPETm2uipHihWwD6BGXhKAzH/q2TnKMCVCs=;
 b=OQoIhGGB+5y8DKN484q0M60icttj2mRgAO+vvYNl9bVIdzABwbuQu+PPF/PKmAS264V/yniZLbiBhe9bj2r5ps1lxbVUur1P3hlBB/jjaRPq+UqdwNj7unBJ30rx6tQVGkDd2rvX7vF1SJGHsS4ble+MHapYNffwswfuBi1FZSs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19)
 by MN2PR12MB4455.namprd12.prod.outlook.com (2603:10b6:208:265::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6363.33; Fri, 12 May
 2023 18:09:42 +0000
Received: from MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::bd4d:3c36:29bb:87de]) by MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::bd4d:3c36:29bb:87de%7]) with mapi id 15.20.6387.022; Fri, 12 May 2023
 18:09:41 +0000
Message-ID: <a3e1e3b4-a682-973a-9ab6-b35812717250@amd.com>
Date:   Fri, 12 May 2023 13:09:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC 4/7] hw/mem/cxl_type3: Add DC extent representative to cxl
 type3 device
Content-Language: en-US
To:     Fan Ni <fan.ni@samsung.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc:     "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "gregory.price@memverge.com" <gregory.price@memverge.com>,
        "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
        "cbrowy@avery-design.com" <cbrowy@avery-design.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
        "nifan@outlook.com" <nifan@outlook.com>
References: <20230511175609.2091136-1-fan.ni@samsung.com>
 <CGME20230511175641uscas1p2b70d27b1f20dc2dd54a0530170117530@uscas1p2.samsung.com>
 <20230511175609.2091136-5-fan.ni@samsung.com>
From:   Nathan Fontenot <nafonten@amd.com>
In-Reply-To: <20230511175609.2091136-5-fan.ni@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0043.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::17) To MN0PR12MB6222.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6222:EE_|MN2PR12MB4455:EE_
X-MS-Office365-Filtering-Correlation-Id: 200549e6-0fc1-47ef-73ab-08db53140eb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gjW/ljgxxua6fU847GWJTPxkv77Hj88E+REeJUQbtEdcytUCfxQhk6rysXjnrEUU9JmAlqWG0WnfyUTD6wvuMW76ALZAD58GYA6UMY+9LDD7R0xMuoG62lekpp4mPx7B5DsvBLkUpX75UheuP1SGnJxq2haWYwS83msHtYJRoBAgj0phvWsn2g5vhFbhSl+z7i//37UlUlhmBBKY47pQTaI9zSTvxHzC8MRrFcTPNDKBKu6PCy9DFSv66CDhUQ0+AvWvtuWKfJVr+fEFipcfKwDBlx3r6niV8QjMVIaV8O4IH6ONELd/mxVitQw/SQUPYNdR7VR/z4u7kTzzpRSVL5BpBwRa26oUFWXsq7pq1GZAtxZLKBOH3Z3b4BakwS8AtykwUWYKtKMs///Q3vOlwIt3axdKkDf1aZFkBrmzs5YLXWZrEsu+Xj+dQpnt8LCKonjRnfjwTPXPQFsjQDu4/oBy41k1Cau8OV7WD8FNia560/axjohKhv6yZPc7gW6+jCS2OuoVgA/q33OiVyb/XUng41gnwibqEo1aMRrFB/89xb0HocYUIOhWZQJPHaegRFHWK66xSrbDVCNPJPCH0nPrJ4C02NYTnRnQYYcS+Bfe3iS0LBgzIrDm1OjxBithnutyHflYcNfSzPYcnAOj8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6222.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(366004)(346002)(136003)(396003)(376002)(451199021)(38100700002)(53546011)(186003)(31686004)(110136005)(54906003)(316002)(6506007)(83380400001)(6512007)(26005)(41300700001)(8676002)(5660300002)(31696002)(8936002)(66556008)(66476007)(66946007)(4326008)(478600001)(45080400002)(7416002)(36756003)(2616005)(2906002)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VmZvWkh2UTZzb29GYlVBanFvS1l3ZmdtUWRab2ZuUHIvaFVLbEtQbXR2N2M3?=
 =?utf-8?B?cXdYNXpzanEvYXdvQSswenZRaGxTUS8zaWp5eVBuUWxWOUdYdkR2bWVlY1NO?=
 =?utf-8?B?UWcxNWtveUhnTSt5NGpjNFpRRHh2a3VLR3VYZjVMdmduQURDNVFscXYrSGpu?=
 =?utf-8?B?eXZJZUhLUG9RVWlMRXpsSzQ0eXJ2QXkvcnNsdVNXNGZsSnVtMlY5aC9PZ2Zz?=
 =?utf-8?B?S3pJall0YStXR1ZIL1c0bWRXck95ckhGQkphOEVZejJ0Z2Z2V0dlNHFLOURY?=
 =?utf-8?B?QlBlOEJNaFIvMTN2Znp3dXVVTEh3dXZWcFlmdUZkVXVWbVZ4STkrNXAyVTBB?=
 =?utf-8?B?OTFiYll2T0tQUDJJb29KS04rOG1ucDhxUExlbkkyR3hoSlc0V1pLdkFmTWll?=
 =?utf-8?B?RVIwc1VzME1mMWdsR0FTYUtNdHE2N3hseHNzUGZMUkpCb05FZXIwOWVIam90?=
 =?utf-8?B?N2pMcloxMmF3VXFZelI2WnZ4QWdwUWRmOEpsZytQTGtxOE1KMUJHaHhXSkpm?=
 =?utf-8?B?MFVBN1VZUU9lTUNjY3VwYzZhVlM0SDNtOCtvaVhqcTZpOUszZkpqYzJMK25U?=
 =?utf-8?B?eE1oOEZ6K3YrZFRvMkxZODg3MlFqTjM3NjlQYlhQS0xtSVFxVjNLR1RZRjZx?=
 =?utf-8?B?dXZvVWVaYjVHMmxmQ0lpMjVkMkVWZlZSaVB1aGRwclJWQXArMGF5WDlmdERl?=
 =?utf-8?B?Z3BPU2FScm1HWWhqRXFiS25YU090U2YvSDdYRnJaVGhKZ1Jmc2FVOUNJZWdW?=
 =?utf-8?B?ODNINldMODBJYWoyY3FOc1R4em9CRGY0QzQ2NmRtMUF6YkFXVmtSbGk2bVVE?=
 =?utf-8?B?VnpxRWxhZ2NsNTRuaHNWb0d3OGdpeVRLM2MxQUt2YmRSaTJqYXhrbEZnYnFI?=
 =?utf-8?B?SDRicDAwM0ZySW1GaE0rd2N1OUI2Q0d2SWJhcWIzVzF2UVZVVmpnd0IwTURF?=
 =?utf-8?B?NENJRGkwREJpL2V6aGJsWTA1LytLcWV3em5BOXBXYkY0c0hPNzI1aWxSZ1J5?=
 =?utf-8?B?UHljNkd5QXNObFFJVDBDd1F1MCtCc0F3ZHBtQkxsWGlzR3BGdmZOODYvcGdU?=
 =?utf-8?B?aEJzRTc3NUZ3ZjN3MGR4RzZORUx5ZzA4a0RVcUdob0ZjSk1xZ2t1YWNsWGFk?=
 =?utf-8?B?djcxYzhVTlBjYmh1UUNveDQyZGpqSVF6WG9ZTWYyUGFSbGlLN3B5a3Fsa0NS?=
 =?utf-8?B?RS9KTkNKQlZvU1M4RWpuem04c0ZiV2cxTlJUZ1VLZEJtOGtTR2RjN2xIVkFp?=
 =?utf-8?B?VWNCWjlpY1VRY1RzeTEvTGgrc3ZSK3Vja3VLR2ZFUzYxNVljYWRReVBITUs3?=
 =?utf-8?B?QzgxQmM3NU5ISmoyUnZMdHNQNXpVdS85Q2VubnpOSGVmTXJLaUs0ekpHa1c5?=
 =?utf-8?B?bndab2VmNjFaU3luMERzTFZGbGcwbXVYaitZSE56NlRBVFQ5S0VoMi9sN1U4?=
 =?utf-8?B?RUlvUXNFUk1nQTQ5OGZQN1owQnBqOGxsWCt0RkVRRzdQNmppeGRlUS9SbURX?=
 =?utf-8?B?MkFNZUhjRWZ0RXFNQXQvcHIzS0x5N0tzTThqQUk4WGJNK3FCc1Z2RWtDdFdR?=
 =?utf-8?B?czdmSGxvbVg3a0xKZERBNFZ5cXRESzFQMGNvN2xIelpVMy93NmRBbDIycmda?=
 =?utf-8?B?VDVTcDVyeWo1QkpXV0VxSXBscXVYQjBoMGJBeDhIZm5YZWZVeXVVdUJkSXpO?=
 =?utf-8?B?T1l5QUJOVEtBc2VGM2U2aDcwbmpsd1k2RmJjYW0xRGJyQ1JDTjN3SFh2MStw?=
 =?utf-8?B?UGRxQzBHYkZ2MnBrdDgvckdRREtia1g4L1hDZEZzU2xySEtNSEIvU0VjejAw?=
 =?utf-8?B?VnpGcys4U1lIL1VHRE9mS21OSkpzMVg4RXNCT0hlTXJ2SEJxM01Xa2VmMnpi?=
 =?utf-8?B?M245T1A1eEdBMStnYXZZWHhIaEhZbERIUlBRandhdmcrenpselpuZE1iS095?=
 =?utf-8?B?UW41eE1oVkZuVkFaM1QraWpmR1cxaGhESWFuaWdDbG15WExnRUpWbFpJbC9P?=
 =?utf-8?B?WndCUTdwZUJsYUxJR3FqUUdPdk9GdEFxTFl3ZHdzZXl3VmQ0dUx6dHVoUWdh?=
 =?utf-8?B?NVoweW9iVFk4YnpOZU0xMkduTHJ4TUZhOFlLNWxCRUlYNk4xa3FPQnJtY3ps?=
 =?utf-8?Q?X+WprsOZ+fFzT2YHDMT5iTIha?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 200549e6-0fc1-47ef-73ab-08db53140eb7
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6222.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2023 18:09:41.6673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A0vbQyI7pStnwCGiN5ZzZbLTmZQQsbf98BcKy09Ov72mYp4tDxuEAp1tV08kyuQhb6MnKKVMXYdqFFWZZBvPlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4455
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 5/11/23 12:56, Fan Ni wrote:
> From: Fan Ni <nifan@outlook.com>
> 
> Add dynamic capacity extent information to the definition of
> CXLType3Dev and add get DC extent list mailbox command based on
> CXL.spec.3.0:.8.2.9.8.9.2.
> 
> With this command, we can create dc regions as below:
> 
> region=$(cat /sys/bus/cxl/devices/decoder0.0/create_dc_region)
> echo $region> /sys/bus/cxl/devices/decoder0.0/create_dc_region
> echo 256 > /sys/bus/cxl/devices/$region/interleave_granularity
> echo 1 > /sys/bus/cxl/devices/$region/interleave_ways
> 
> echo "dc" >/sys/bus/cxl/devices/decoder2.0/mode
> echo 0x30000000 >/sys/bus/cxl/devices/decoder2.0/dpa_size
> 
> echo 0x30000000 > /sys/bus/cxl/devices/$region/size
> echo  "decoder2.0" > /sys/bus/cxl/devices/$region/target0
> echo 1 > /sys/bus/cxl/devices/$region/commit
> echo $region > /sys/bus/cxl/drivers/cxl_region/bind
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c  | 73 ++++++++++++++++++++++++++++++++++++-
>  hw/mem/cxl_type3.c          |  1 +
>  include/hw/cxl/cxl_device.h | 23 ++++++++++++
>  3 files changed, 96 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 61c77e52d8..ed2ac154cb 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -83,6 +83,7 @@ enum {
>          #define CLEAR_POISON           0x2
>  	DCD_CONFIG = 0x48, /*8.2.9.8.9*/
>  		#define GET_DC_REGION_CONFIG   0x0
> +		#define GET_DYN_CAP_EXT_LIST   0x1
>      PHYSICAL_SWITCH = 0x51
>          #define IDENTIFY_SWITCH_DEVICE      0x0
>  };
> @@ -938,7 +939,7 @@ static CXLRetCode cmd_media_clear_poison(struct cxl_cmd *cmd,
>  }
>  
>  /*
> - * cxl spec 3.0: 8.2.9.8.9.2
> + * cxl spec 3.0: 8.2.9.8.9.1
>   * Get Dynamic Capacity Configuration
>   **/
>  static CXLRetCode cmd_dcd_get_dyn_cap_config(struct cxl_cmd *cmd,
> @@ -1001,6 +1002,73 @@ static CXLRetCode cmd_dcd_get_dyn_cap_config(struct cxl_cmd *cmd,
>  	return CXL_MBOX_SUCCESS;
>  }
>  
> +/*
> + * cxl spec 3.0: 8.2.9.8.9.2
> + * Get Dynamic Capacity Extent List (Opcode 4810h)
> + **/
> +static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(struct cxl_cmd *cmd,
> +		CXLDeviceState *cxl_dstate,
> +		uint16_t *len)
> +{
> +	struct get_dyn_cap_ext_list_in_pl {
> +		uint32_t extent_cnt;
> +		uint32_t start_extent_id;
> +	} QEMU_PACKED;
> +
> +	struct get_dyn_cap_ext_list_out_pl {
> +		uint32_t count;
> +		uint32_t total_extents;
> +		uint32_t generation_num;
> +		uint8_t rsvd[4];
> +		struct {
> +			uint64_t start_dpa;
> +			uint64_t len;
> +			uint8_t tag[0x10];
> +			uint16_t shared_seq;
> +			uint8_t rsvd[6];
> +		} QEMU_PACKED records[];

Similar to a previous note, could this be CXLDCExtent_raw instead of re-defining
the structure?


> +	} QEMU_PACKED;
> +
> +	struct get_dyn_cap_ext_list_in_pl *in = (void *)cmd->payload;
> +	struct get_dyn_cap_ext_list_out_pl *out = (void *)cmd->payload;
> +	struct CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
> +	uint16_t record_count = 0, i = 0, record_done = 0;
> +	CXLDCDExtentList *extent_list = &ct3d->dc.extents;
> +	CXLDCD_Extent *ent;
> +	uint16_t out_pl_len;
> +
> +	if (in->start_extent_id > ct3d->dc.total_extent_count)
> +		return CXL_MBOX_INVALID_INPUT;
> +
> +	if (ct3d->dc.total_extent_count - in->start_extent_id < in->extent_cnt)
> +		record_count = ct3d->dc.total_extent_count - in->start_extent_id;
> +	else
> +		record_count = in->extent_cnt;
> +
> +	out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
> +	assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);

Perhaps it would be nicer to return a failure here instaead of assert().

-Nathan

> +
> +	memset(out, 0, out_pl_len);
> +	stl_le_p(&out->count, record_count);
> +	stl_le_p(&out->total_extents, ct3d->dc.total_extent_count);
> +	stl_le_p(&out->generation_num, ct3d->dc.ext_list_gen_seq);
> +
> +	QTAILQ_FOREACH(ent, extent_list, node) {
> +		if (i++ < in->start_extent_id)
> +			continue;
> +		stq_le_p(&out->records[i].start_dpa, ent->start_dpa);
> +		stq_le_p(&out->records[i].len, ent->len);
> +		memcpy(&out->records[i].tag, ent->tag, 0x10);
> +		stw_le_p(&out->records[i].shared_seq, ent->shared_seq);
> +		record_done++;
> +		if (record_done == record_count)
> +			break;
> +	}
> +
> +	*len = out_pl_len;
> +	return CXL_MBOX_SUCCESS;
> +}
> +
>  #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
>  #define IMMEDIATE_DATA_CHANGE (1 << 2)
>  #define IMMEDIATE_POLICY_CHANGE (1 << 3)
> @@ -1041,6 +1109,9 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
>          cmd_media_clear_poison, 72, 0 },
>  	[DCD_CONFIG][GET_DC_REGION_CONFIG] = { "DCD_GET_DC_REGION_CONFIG",
>  		cmd_dcd_get_dyn_cap_config, 2, 0 },
> +	[DCD_CONFIG][GET_DYN_CAP_EXT_LIST] = {
> +		"DCD_GET_DYNAMIC_CAPACITY_EXTENT_LIST", cmd_dcd_get_dyn_cap_ext_list,
> +		8, 0 },
>  };
>  
>  static struct cxl_cmd cxl_cmd_set_sw[256][256] = {
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index b9c375d9b4..23954711b5 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -708,6 +708,7 @@ static int cxl_create_toy_regions(CXLType3Dev *ct3d)
>  
>  		region_base += region->len;
>  	}
> +	QTAILQ_INIT(&ct3d->dc.extents);
>  
>  	return 0;
>  }
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 8a04e53e90..20ad5e7411 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -385,6 +385,25 @@ typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
>  
>  #define DCD_MAX_REGION_NUM 8
>  
> +typedef struct CXLDCD_Extent_raw {
> +	uint64_t start_dpa;
> +	uint64_t len;
> +	uint8_t tag[0x10];
> +	uint16_t shared_seq;
> +	uint8_t rsvd[0x6];
> +} QEMU_PACKED CXLDCExtent_raw;
> +
> +typedef struct CXLDCD_Extent {
> +	uint64_t start_dpa;
> +	uint64_t len;
> +	uint8_t tag[0x10];
> +	uint16_t shared_seq;
> +	uint8_t rsvd[0x6];
> +
> +	QTAILQ_ENTRY(CXLDCD_Extent) node;
> +} CXLDCD_Extent;> +typedef QTAILQ_HEAD(, CXLDCD_Extent) CXLDCDExtentList;
> +
>  typedef struct CXLDCD_Region {
>  	uint64_t base;
>  	uint64_t decode_len; /* in multiples of 256MB */
> @@ -429,6 +448,10 @@ struct CXLType3Dev {
>  	struct dynamic_capacity {
>  		uint8_t num_regions; // 1-8
>  		struct CXLDCD_Region regions[DCD_MAX_REGION_NUM];
> +		CXLDCDExtentList extents;
> +
> +		uint32_t total_extent_count;
> +		uint32_t ext_list_gen_seq;
>  	} dc;
>  };
>  
