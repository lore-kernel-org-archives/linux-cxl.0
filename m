Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FCFEC7EE22
	for <linux-cxl@archiver.kernel.org>; Thu, 11 May 2023 21:53:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238825AbjEKVxe (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 May 2023 17:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238053AbjEKVxd (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 May 2023 17:53:33 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2083.outbound.protection.outlook.com [40.107.100.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4C53A93
        for <linux-cxl@vger.kernel.org>; Thu, 11 May 2023 14:53:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g+WVc4+5FJDtaM9AponYIflI/WwzP1LFlKJx7U9HKsDBS2VOblgQBl898rV2wDtPA7Q5OonTTzoImqamGm7vLvcE26ASDwzzAJF+EaAsvTzLiw9XESboWDlBB49dVDfWHHvCfP2dvA6oL0CTxx2HH4EzcICrjhF5adMPRQKFAhOD027KTVxnMLesDOquurz3wkmettbcGuUNmBkywFnYw2ShXY7/scQP49kbppoqkLrNkwbtaFaotdxoms0ts1ijNqO/wIMX0NPphiZHfLAT+okePMpWUPlSWc7D0Mb+lr9i/dd9CRjVXEYPf2UluUIII1JyIsr5QM5e4FEKemSO9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwwKKgPzdVKNUgmcrXxZOvh1R3IP2B74sKEYqUnuFR4=;
 b=AvvS7jVGpMFqUcyqv+jjKfJ4JsfuBlNYfiwWAkTiBSWJlZB8+ukyOKdQ0jmaLSkrHeO0NrOcZM4/45Hd2Vo9a8FD8Lr3dTZ8Qv5a9iRqXZSAM4/0ECOWMz0Co7NRYjVJeYqCspEKh0mVGOmc2GLIANt/5H5FXSdqD9jXf/xWTG4Ff6IIpwBP3V88C7laog2CtBUgqkN6G2F05okqfDJMhGbVmEGlSQbGPqXj3cHbexHmdSYWA4ifO7Ts9gH8gNmUxxb0IAbnw/kTszXl+bo1Rfk8ajVnRAPf6RyPiX1YPEpAUDCDYbBUqF3p/spxk/V1bUYudwNm86HIndmGO/tIEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwwKKgPzdVKNUgmcrXxZOvh1R3IP2B74sKEYqUnuFR4=;
 b=s4h4n3GiVAbqSL8aCcMVxsA/xZPaCpw1RYlIQLOysf+ojgyugryyKPXIzIDbwEpGdc1oTq6F15mlWB2gQZqmdvj1jfea9wvASZrZ9ItlyytHIQGeYX2JxI4Yq1XiL7ffQFuXg40l1xq3cjyy2+iMqCGVmhKe4rZI3D19D4sGIt0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6222.namprd12.prod.outlook.com (2603:10b6:208:3c2::19)
 by IA0PR12MB8301.namprd12.prod.outlook.com (2603:10b6:208:40b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Thu, 11 May
 2023 21:53:27 +0000
Received: from MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::bd4d:3c36:29bb:87de]) by MN0PR12MB6222.namprd12.prod.outlook.com
 ([fe80::bd4d:3c36:29bb:87de%7]) with mapi id 15.20.6387.022; Thu, 11 May 2023
 21:53:27 +0000
Message-ID: <5cf2a93d-1a20-c87b-5276-69feb5056e72@amd.com>
Date:   Thu, 11 May 2023 16:53:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RFC 2/7] hw/cxl/cxl-mailbox-utils: Add dynamic capacity region
 representative and mailbox command support
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
 <CGME20230511175641uscas1p165a19a1416facf6603bf1a417121f0dc@uscas1p1.samsung.com>
 <20230511175609.2091136-3-fan.ni@samsung.com>
From:   Nathan Fontenot <nafonten@amd.com>
In-Reply-To: <20230511175609.2091136-3-fan.ni@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0098.namprd03.prod.outlook.com
 (2603:10b6:408:fd::13) To MN0PR12MB6222.namprd12.prod.outlook.com
 (2603:10b6:208:3c2::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6222:EE_|IA0PR12MB8301:EE_
X-MS-Office365-Filtering-Correlation-Id: bf8f8b1e-3dd4-4732-2be1-08db526a2674
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /KNVcUYWRMyRyRcqNzb2E2bAMuCsxSbZyWWbebBmTekC17srC9Y+gOXl/pbIJU6cZWpziWS48V8pLHhNVwKXwwCmfVSAz4M6GrVu2utAGw6RnYCn6x1bbb2khuEcCSpCHHfwPfSd08TyaQoazU9cJCzycPrc3g4lB4EvpAJrCpurqCdCOIBeYhpGMwZqTODbI3CxHzOWtZvd+Sd6leaGi7czojICfHwO6J09BpkfwqcVywwveNQZuT7KBU/oL+VASVRS8XtGtrEOohpgd0Hlaps7s4HS76yhiSs4f8zdTZQo9+LP4pM5CGlq+CPDAthcjv40YkHitvC/oMj9jhxRm5YjVYG2Ozu2HnBJOATozEoQmlmnewZaQWdQUZI0dCetSWTTwyOoJMOew9rSzlZ+EdVkRWtda8zpCq88rh/D9ou8q3KT+vXM4W9V/HZ0Nv+NwBre4nD7dCf8xHyU+cwGDBd5i33pY6uESn7I8P5xOMK7ELM8JIKK0Rot0nFuswzAN+Pl6ZF2qvd0Xfm/oERo67xpQIj0s3bFrxOjr1Z+/XZfTrL0GtZtg9OFdTrRXU/dF8tKKx/atsOiqyed39RbS3zXARy3jJIBepQYTLCs+a3RAKsyvBknnVWS8Fq7F3E9ezM5AUI9a/tlbbLJo12egw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6222.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(366004)(346002)(451199021)(54906003)(110136005)(31686004)(45080400002)(478600001)(4326008)(6666004)(6486002)(66556008)(66946007)(66476007)(316002)(83380400001)(36756003)(2616005)(8676002)(41300700001)(38100700002)(7416002)(8936002)(31696002)(6506007)(186003)(2906002)(26005)(6512007)(5660300002)(15650500001)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SHREaTZaSWFnbHRIS0d6L1pGYTZzT2JNSTJQaFdzN0d0SHl3SC9EUVUwRWxN?=
 =?utf-8?B?ZCtHZGRKSTRNZ242YlVVek1TdWNRUytRYmtMaVVOaXVxS2IrWFRZNjBUclF6?=
 =?utf-8?B?aEtWUG1oOEdQVmpBL0VBZGVjdUNEUEMwUlAvMTZsZmFiOGxrSTd0ZkpqbzhQ?=
 =?utf-8?B?S3RuRW9La3AvdDhHM2crY2xkb2RZTUtKVHZ6QWUzQ011L0VhK0h2eVhiMUFF?=
 =?utf-8?B?WWkzczRGNUl0SXJzRjNUT3h6UU95akRjNDFBSEFLL2ZzejF3aE1tajhVTWI5?=
 =?utf-8?B?RjFuMkF6cXp5d3hMTTZmcytROUtRNEUyM1B6cWtSaHAwZ055amVwUGVOMUNi?=
 =?utf-8?B?WGloYWI3S05PbUhKUFdMY2pmQkhwVWg3d25JRzB0VnBMZzhGM2VzUU5oc2Ri?=
 =?utf-8?B?Y3o5QjUxME8wMEhJVVRtOUhvUTRJTEVnQk9pTEFvTHlYbDFVbWpLaUVqNER0?=
 =?utf-8?B?aHNTeWQrek9ibjVObHNKK2ZycER0MXIzQkpkQXUxT0pZTXZpYjJacllTQkNS?=
 =?utf-8?B?b09YT0ZrRldhdm1UekJPNDYvKzNMS3FNV1J4SEFJYnRpaFloUUplR0I0UTFu?=
 =?utf-8?B?SHVvVTUyUEMweWN4WTNMNkY0Y2NDOUNDdlRvV2pjMVkwblc3QUM3V1grR0pn?=
 =?utf-8?B?YlJRRTYwSUI2TzdKeS9BWm84cDRQTXRxcGFsc3ExVXpNM2J5RUhwaU43cHRD?=
 =?utf-8?B?NUVjaWtyZUY0VGZCS3lUOUx5eW4zZVZQZ3BiS0ZVdis3Vko1UzNYS0t2YWht?=
 =?utf-8?B?S0Y4bUJqVXJDTWIzSjFKY1czZGNIRDhLS2dmTjd3ajNSUThvTEFGdjdxcS9v?=
 =?utf-8?B?QmVBbnhhWjh4bnlzb1ZCR3IwemNCTEk2eWxRVUo3ekpaeUdyTjRDTWZyaUFr?=
 =?utf-8?B?V0syZGFRS0g4UHF3QUsyVWNzTmU1UFVqT0hvdDBmeTIxL3V2Q2N0Zi8wSEYy?=
 =?utf-8?B?eDU0OHlvOUpuVnZad2NaK2VEazczL0hYeG03MFhwM2pDK3JPeW9lSE0xNGd0?=
 =?utf-8?B?bDBaRmkyVjFnMFMrWUs3cEN6dEdXcDNyNmZEWExYZ2VEcjJpbkxIdG5mTFpH?=
 =?utf-8?B?RHk5RlNhOXhvZmJrWnRhM1JQWXk1UHg2OFl5V3FhYmJ2MndaRkl4NWdlWjZG?=
 =?utf-8?B?ODBtRFJDRWJGQmQxdmdEZnREMk93clF6N2ZEZ0RISld0cjNVNDUrMG4vUTVI?=
 =?utf-8?B?NGRqSC8vZDY3QnRsQ1ZpZUhxWUFKL05OS2tQaExpaWVkN29oa3U0YzRRUTBw?=
 =?utf-8?B?bUtGQ2ZiUWQ5STFickFMYjdEQ1lPZHFaQk9GWUF3SWdETnRRQzhPYzFVZkRj?=
 =?utf-8?B?OENLSlNRMlNVaStPT25yejQwekNwOGpDRjVnZkFFaFVKd2ZDemoydy9EcUZN?=
 =?utf-8?B?SUJWZXZLUGZVVmYvTHlacnovcVdodVErUXhzM2xFanl3YjMvWURhSUtha0sv?=
 =?utf-8?B?akZxbjVTVE5SK0lOL01IS08rcTRNNy8xZVRhMlE3OUlza3hhY2tCbmtWSnJh?=
 =?utf-8?B?RVgrWmZveWVYaVNXamlSN1hzM1psaFJQOU93UndJNWlVdklMKzlsWlg1WkI3?=
 =?utf-8?B?VUNqK0U1c2RNNURKSk1xc0tRNDJlNDE0aTlRc1Rjd2w3NGppeU5ORHlCKytG?=
 =?utf-8?B?R0pJbW1TVlNMSkhucVNjVjhxY1FqZ1REeWRMRkhWQVlvU1FTQTBMWmYycnpM?=
 =?utf-8?B?V3RwYUFMV1ZPWU5yOXRqVjY3QllMUDhicjA3ZGFIV2t6Nml6MEdCQlJDRkFI?=
 =?utf-8?B?bkpjSUc0VC9uMjJSeDVyV3lIeXR0ejlsTGV1SGsxQSs2clRleE9CWGtuQ0Zz?=
 =?utf-8?B?MVYxSDg5bU5EZk4wdk1VWHR4dmdNRW9uNXJwcllva2lGNnR6Ym5lQWkxSmo1?=
 =?utf-8?B?cG1TOHNMU1FNNXFZak1vT0N3RVY0V0FtVWdlWUdMdkErWWxnd01HYUpBOEhk?=
 =?utf-8?B?cWp4SStHaDVxYWY5bUZxVlQrQU1pRTlJQ3lrY2JqREtLSDVFVTUwZ1JFemNK?=
 =?utf-8?B?enpHNGVUTjdSMGpJbWY0KzhCbVRjZzF5VHoyajh5alB2dEVPbEJML3dEZjhZ?=
 =?utf-8?B?eEdTYTMxMG5XZFl6Y0ljTFhQVHdHNTFjTU0vU0hDaXRLTFNhVVBUWTU1U1ZD?=
 =?utf-8?Q?kalOOGh8corEyszO+SRRnxz3d?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf8f8b1e-3dd4-4732-2be1-08db526a2674
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6222.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2023 21:53:26.9954
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4CiEX8Ufnjbf5Rt/2xkNp3lS6EjVhUGSXn7JRr/1TdaYy3nqJIUzmSmbiz7uYzg9CsqlzmXddqQmn3FU4v8QMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8301
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 5/11/23 12:56, Fan Ni wrote:
> From: Fan Ni <nifan@outlook.com>
> 
> Per cxl spec 3.0, add dynamic capacity region representative based on
> Table 8-126 and extend the cxl type3 device definition to include dc region
> information. Also, based on info in 8.2.9.8.9.1, add 'Get Dynamic Capacity
> Configuration' mailbox support.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c  | 68 +++++++++++++++++++++++++++++++++++++
>  include/hw/cxl/cxl_device.h | 16 +++++++++
>  2 files changed, 84 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 7ff4fbdf22..61c77e52d8 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -81,6 +81,8 @@ enum {
>          #define GET_POISON_LIST        0x0
>          #define INJECT_POISON          0x1
>          #define CLEAR_POISON           0x2
> +	DCD_CONFIG = 0x48, /*8.2.9.8.9*/
> +		#define GET_DC_REGION_CONFIG   0x0
>      PHYSICAL_SWITCH = 0x51
>          #define IDENTIFY_SWITCH_DEVICE      0x0
>  };
> @@ -935,6 +937,70 @@ static CXLRetCode cmd_media_clear_poison(struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +/*
> + * cxl spec 3.0: 8.2.9.8.9.2
> + * Get Dynamic Capacity Configuration
> + **/
> +static CXLRetCode cmd_dcd_get_dyn_cap_config(struct cxl_cmd *cmd,
> +		CXLDeviceState *cxl_dstate,
> +		uint16_t *len)
> +{
> +	struct get_dyn_cap_config_in_pl {
> +		uint8_t region_cnt;
> +		uint8_t start_region_id;
> +	} QEMU_PACKED;
> +
> +    struct get_dyn_cap_config_out_pl {
> +		uint8_t num_regions;
> +		uint8_t rsvd1[7];
> +		struct {
> +			uint64_t base;
> +			uint64_t decode_len;
> +			uint64_t region_len;
> +			uint64_t block_size;
> +			uint32_t dsmadhandle;
> +			uint8_t flags;
> +			uint8_t rsvd2[3];
> +		} QEMU_PACKED records[];

Could you declare CXLDCD_Region as QEMU_PACKED and use it here instead of
re-defining the region structure?

> +	} QEMU_PACKED;
> +
> +	struct get_dyn_cap_config_in_pl *in = (void *)cmd->payload;
> +	struct get_dyn_cap_config_out_pl *out = (void *)cmd->payload;
> +	struct CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
> +	uint16_t record_count = 0, i = 0;
> +	uint16_t out_pl_len;
> +
> +	if (in->start_region_id >= ct3d->dc.num_regions)
> +		record_count = 0;
> +	else if (ct3d->dc.num_regions - in->start_region_id < in->region_cnt)
> +		record_count = ct3d->dc.num_regions - in->start_region_id;
> +	else
> +		record_count = in->region_cnt;
> +
> +	out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
> +	assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
> +
> +	memset(out, 0, out_pl_len);
> +	out->num_regions = record_count;
> +	for (; i < record_count; i++) {
> +		stq_le_p(&out->records[i].base,
> +			ct3d->dc.regions[in->start_region_id+i].base);
> +		stq_le_p(&out->records[i].decode_len,
> +			ct3d->dc.regions[in->start_region_id+i].decode_len);
> +		stq_le_p(&out->records[i].region_len,
> +			ct3d->dc.regions[in->start_region_id+i].len);
> +		stq_le_p(&out->records[i].block_size,
> +			ct3d->dc.regions[in->start_region_id+i].block_size);
> +		stl_le_p(&out->records[i].dsmadhandle,
> +			ct3d->dc.regions[in->start_region_id+i].dsmadhandle);
> +		out->records[i].flags
> +			= ct3d->dc.regions[in->start_region_id+i].flags;

In this loop your reading from 'in' and writing to 'out' where in and out both
point to the same payload buffer. It works because of the structure layouts but
feels like a bug waiting to happen. Perhaps saving start_region to a local variable
and using that for the loop?

-Nathan

> +	}
> +
> +	*len = out_pl_len;
> +	return CXL_MBOX_SUCCESS;
> +}
> +
>  #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
>  #define IMMEDIATE_DATA_CHANGE (1 << 2)
>  #define IMMEDIATE_POLICY_CHANGE (1 << 3)
> @@ -973,6 +1039,8 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
>          cmd_media_inject_poison, 8, 0 },
>      [MEDIA_AND_POISON][CLEAR_POISON] = { "MEDIA_AND_POISON_CLEAR_POISON",
>          cmd_media_clear_poison, 72, 0 },
> +	[DCD_CONFIG][GET_DC_REGION_CONFIG] = { "DCD_GET_DC_REGION_CONFIG",
> +		cmd_dcd_get_dyn_cap_config, 2, 0 },
>  };
>  
>  static struct cxl_cmd cxl_cmd_set_sw[256][256] = {
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index e285369693..8a04e53e90 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -383,6 +383,17 @@ typedef struct CXLPoison {
>  typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
>  #define CXL_POISON_LIST_LIMIT 256
>  
> +#define DCD_MAX_REGION_NUM 8
> +
> +typedef struct CXLDCD_Region {
> +	uint64_t base;
> +	uint64_t decode_len; /* in multiples of 256MB */
> +	uint64_t len;
> +	uint64_t block_size;
> +	uint32_t dsmadhandle;
> +	uint8_t flags;
> +} CXLDCD_Region;
> +
>  struct CXLType3Dev {
>      /* Private */
>      PCIDevice parent_obj;
> @@ -414,6 +425,11 @@ struct CXLType3Dev {
>      unsigned int poison_list_cnt;
>      bool poison_list_overflowed;
>      uint64_t poison_list_overflow_ts;
> +
> +	struct dynamic_capacity {
> +		uint8_t num_regions; // 1-8
> +		struct CXLDCD_Region regions[DCD_MAX_REGION_NUM];
> +	} dc;
>  };
>  
>  #define TYPE_CXL_TYPE3 "cxl-type3"
