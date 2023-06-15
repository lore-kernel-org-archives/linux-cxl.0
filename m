Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F13A1EB64D9
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jun 2023 18:32:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237994AbjFOScP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Jun 2023 14:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjFOSb4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Jun 2023 14:31:56 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2073.outbound.protection.outlook.com [40.92.53.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C542D5E
        for <linux-cxl@vger.kernel.org>; Thu, 15 Jun 2023 11:31:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T/4fJYsqyuhHX3wZGj9x60S2IuQV6wUufmNxAiYQ23pqyZSF7n4iePk7U4T3oHeVsvU1hs+tVI1u3emGvnhfo3bP80IH7uUcAvt4VlA+NS1vbG8M2seh1NjBxH0YAA4x/Ba1JWWDhRnmnFLE/XZfnUwcfALLiShMq2ofABX3DscEXIe0vPYX/A11i2SfKeeo6KSc/QUMlSHVweBRwKQ/cpWkcAYvHtOeY7dzfGOx1pYIHhAIh+VSAP/ko1V/f5ItceIk1qNgr9Hqe35nAdAqS7yOnc8kO6sYdkCyonRqKrKkkDMjV2gUjjKeTykkULAuRJ5cYdA4BCGA0G0hUKWW1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUBqz8dBTmrr3bkIvlfFJB7cPsCfxAcd6XsdxxGJkyw=;
 b=V22ODXeT7e6AUD88R7yLSARb0zJAsWhjs1G4ZHTGGKfUAUYxw6MJNVjL45eZfA+n4/SB1ZSFKb03CXkR6KdGY9EupyHuu/DZCpmkNHV3VdXxYRAXHuOdDILrYI+xvQcmPbcDUHrBdI1GrM5ubbHFaATQa8mYrXxlmYd6bwRemQbXo0TMAq6eyB27wlGpd8V1lWmQhjkQLu87IvadJHOqJqTjjd6q0/WwNQWHOXquWGVfQ9JAfQYyIqt5rbfCpzqn+/VG8USF3N019wn4VpNm3oPYiEUbpNBO0IVaM+FERc6TaKe0HT8M1JQ0kl9ExiU3veNnD/pEakZ/t1MFJ4BHBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SUBqz8dBTmrr3bkIvlfFJB7cPsCfxAcd6XsdxxGJkyw=;
 b=DAoxwBbETybmf6F7+Fj0gBas3naJRo/tR8n87xF8EIK0yMz8oM7T7+6oWj1+icPn+b2HMQ3VGgQmf+h5EAvlA70X135iMmqY98ZcXfK1krAae6hpNqAkRXwhI5/tZH790LZd2Jugb3tVhIF6MwrvsKSiszl4MnVXBXuccYbekPRJsrOeHtkTq0nX45pXNLfrfJnLx5bseWAbJW42SsqgQJr9Cf8wRtw8YEkB0qe7FZZHmjKvG0xf72SbU1mNvHaXZ/N6mQHgiVQ0fl3GsEGuFhFr8aybWAzVc/d6QUjBl5tWXdH1gKkyoLWzm7D6h0KGqmmdq7KEZX8KOeAgP7PZGg==
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com (2603:1096:4:7a::17) by
 SEZPR06MB6457.apcprd06.prod.outlook.com (2603:1096:101:17e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Thu, 15 Jun
 2023 18:30:21 +0000
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::33a7:c9e1:75ae:3227]) by SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::33a7:c9e1:75ae:3227%4]) with mapi id 15.20.6477.028; Thu, 15 Jun 2023
 18:30:21 +0000
Date:   Thu, 15 Jun 2023 11:30:08 -0700
From:   Fan Ni <nifan@outlook.com>
To:     ira.weiny@intel.com
Cc:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org, a.manzanares@samsung.com,
        dave@stgolabs.net, nmtadam.samsung@gmail.com
Subject: Re: [PATCH 1/5] cxl/mem : Read Dynamic capacity configuration from
 the device
Message-ID: <SG2PR06MB3397D40835FA3156180F0249B25BA@SG2PR06MB3397.apcprd06.prod.outlook.com>
References: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
 <20230604-dcd-type2-upstream-v1-1-71b6341bae54@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230604-dcd-type2-upstream-v1-1-71b6341bae54@intel.com>
X-TMN:  [2vUoMVs+KfOVNrK81Ogd8um+jsQrkdSt]
X-ClientProxiedBy: SJ0PR13CA0068.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::13) To SG2PR06MB3397.apcprd06.prod.outlook.com
 (2603:1096:4:7a::17)
X-Microsoft-Original-Message-ID: <ZItYsAaEl+/FDwmg@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3397:EE_|SEZPR06MB6457:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c99fd82-b819-49c9-0129-08db6dce92d6
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: P8qFrx5/gbrnGr+aTIJj0TTQvlDMHWNNN2jdj97ctdoPdcDghnZFpp+dFtESGZS3KM8eaXrLkeBD0Hvd+cwYHCSF07KLleO9zBu3/ADd5qxLRnNSVJtCvUbd9wh0Cs6Q6HNe+ahYuavfeUBFBY4L4Y9VgArb0aQGNsJ/Qh/gr7lOb9qw6fuioW4GEI13xRrN3Z+z8Q4q2hFD/iY0nLq+JCQxlBQTBVzAXO4O3aEPv0+pwm0vdTgjS0Fg/keINBkOqIpmRIUl1mFMDxcyDuY82ZFisl/cv+wGZAK5ZgZ+rNZlVSRro+kZOhSCVBvM7hBWBwbTGPf0MWRGiOVMpBpCf30q07a2FCf3k3YeNWIFrakt8DPSPEtFKHSvojgqx2tGLB16L/ZYDKU4O87VdXEcxY/MI3BqKv3fl52BwnR1fLKEeUve3RIsbYHpy/aBVMlXKH2b3L69tZayNFHqZ6PZjAIz8/DXXnMcsbiHIAPZ1pkscQCt0CGGatP6lqJztGWA37LCz0VA9z+t9B+f43KmGL13sbqiEgSNJfqpGpPhn2xMli+um34Ik7XedfeihPb5YhA+YexlrPriFrADObV2lVoOHGG074kJIWSoCEProx/maXgAkvIcmnjMgqiqLcDT
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkhrK21NRUdUMmpTYWI5ZXYySVdhVnpSOWhJVm0xYUVSOFd3M0tuS0FFV0Vo?=
 =?utf-8?B?MEpyTHNVQXZ0ZkxTNU5Qc1Z5SFR3dDVveURHelRGMThIMS9TL1BQY2N0YXh2?=
 =?utf-8?B?MkcrVjRqZWRieUN4cEx4TUtRVm9Jand5RUY5NzF5d096dGJiN2paM0lmQVIy?=
 =?utf-8?B?cUFzVDV4ZmRwdXRDbkM0SjNKVTIzaTl2V25xZlVIcCtMK2kwNzNoREJZaVZD?=
 =?utf-8?B?TmpoYkh6UzRxT2RVVUtpVHk5MXREME5OY1lJZzRlNkdod0ZmeGxPQWNTdmlI?=
 =?utf-8?B?aFlGdk9idTBJS3UxaytSM0FrSTUyVmRJKzhWSkFTaUhyRTRCMHVqa284TWhw?=
 =?utf-8?B?djRGVlY2Qkl2TVV3WlFHUlErSWJ0U0t2cURkV201d05rM1JJYnpzeGhmSzI0?=
 =?utf-8?B?ZHI5K29kWkY0QnVmQVF0Qlo4VGg3YkZhb0VRRnVmSGs1bjBHQlNuYXQzdWFO?=
 =?utf-8?B?SnZCNTRwTmdhamVmaHJUYkIrZFFYVFZ1WFh6amNNTzIwbHlzeHQ1TklaVlc2?=
 =?utf-8?B?c2UrdlZRQUU3VUJjaEtzOElBL2JTalhyNE1uRlVRN1NJY3NtRHlHVG02N0M4?=
 =?utf-8?B?S21BTDlZamZFMVpVUVNjaFdXVCs5eUE1K0pVaW13UmMxWG15eEVUQWpCNnZC?=
 =?utf-8?B?ZXFuZmJTdEVYR2w5YUhYdkphZmo5L3N1anc0NHhIR094QUlJV0sxdFlvT2Va?=
 =?utf-8?B?ZTRMZ1Y0VWpyR0pab2EyMVpSR0R1ZVBjWE9OMTF6RzZDTXlINEFTekpNVElT?=
 =?utf-8?B?eUwweTdvY3VYdk5HU3NKUWVUWHFjdFpJQVdjNVlNVHdMR3hPdnFXNmZSakha?=
 =?utf-8?B?TklUa0lhL2lLNVhTaUNPQklXWkNhd1dwU1VOdDRzT0k2bGRDWEt2b2xwOGhU?=
 =?utf-8?B?Zk1XOFBxTmpjSHhzd0gxSTdDcEQxbHFnY252MkxDYlNRS3JYUGVDSWVWOVlC?=
 =?utf-8?B?eGZueFJQT2FEWXBvallHMk4wUEtVR20vaHdWNkZtQW56c2pNTng0aEhDQkE1?=
 =?utf-8?B?V1FUa2llK0hFRFFuSFJkbHlLZ0k5ZGd5M3kyU1FMZmJiRU5iaWVWOW8vYkdF?=
 =?utf-8?B?UTA5a3hQS1ExczZNOW92aXpGYVRlZDg0UVE4Rk5ZSFZFOGJPM3Y3VmxZSXZ0?=
 =?utf-8?B?Q0tPTmk3MlJkb2dWYjBONUlaSVB4RThxZDBmaDdkekJhQXJxalpjMGsxR3Ni?=
 =?utf-8?B?djFOemZOV0V1ZEk5ak5mN3ZyTWdKZzJkWFZHV09nNWdCMVNGSXdPeW0xaGhx?=
 =?utf-8?B?NjV4ZUVkUHp0Y29ROCtTVEtWQ0ZjdDlaR1FmbGUrenlSczlLaUx2VDRNZk1n?=
 =?utf-8?B?UW5aMDZodDdsSGhPOGFPNGRVNGxCZWdTTlBRTGdxc1NGdGJsYWJJOTc4ZEZj?=
 =?utf-8?B?U3poc0l5dmtIeE52ZkRiUkxIZ2tUTVpJN3MwY2luR0xuRU94clZ6ODJ0NEh0?=
 =?utf-8?B?cWcrUHZQazBBMFB0YU1EVktabEMyMFdxOExubSsvWnE2Y2ZTcGdnMk4rWVA5?=
 =?utf-8?B?NzM5dlBhUmRRZlNmdEpsSDc1L0JCcm43UzY0OEE4OStDRC9XQm85eWt3WHdq?=
 =?utf-8?B?dVZWOGk4UTkrYVgzVkwwNFZrcjhNNVNzejBzaEZoNnQyYmpzT3V6aHRSSkIv?=
 =?utf-8?B?QkIxblgvbG5nNzBDalYxSEt1SUhxL1E9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c99fd82-b819-49c9-0129-08db6dce92d6
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3397.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 18:30:20.8208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6457
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The 06/14/2023 12:16, ira.weiny@intel.com wrote:
> From: Navneet Singh <navneet.singh@intel.com>
> 
> Read the Dynamic capacity configuration and store dynamic capacity region
> information in the device state which driver will use to map into the HDM
> ranges.
> 
> Implement Get Dynamic Capacity Configuration (opcode 4800h) mailbox
> command as specified in CXL 3.0 spec section 8.2.9.8.9.1.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> 

See the comments below how total_dynamic_capacity is collected.


> ---
> [iweiny: ensure all mds->dc_region's are named]
> ---
>  drivers/cxl/core/mbox.c | 190 ++++++++++++++++++++++++++++++++++++++++++++++--
>  drivers/cxl/cxlmem.h    |  70 +++++++++++++++++-
>  drivers/cxl/pci.c       |   4 +
>  3 files changed, 256 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 3ca0bf12c55f..c5b696737c87 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -111,6 +111,37 @@ static u8 security_command_sets[] = {
>  	0x46, /* Security Passthrough */
>  };
>  
> +static bool cxl_is_dcd_command(u16 opcode)
> +{
> +#define CXL_MBOX_OP_DCD_CMDS 0x48
> +
> +	if ((opcode >> 8) == CXL_MBOX_OP_DCD_CMDS)
> +		return true;
> +
> +	return false;
> +}
> +
> +static void cxl_set_dcd_cmd_enabled(struct cxl_memdev_state *mds,
> +					u16 opcode)
> +{
> +	switch (opcode) {
> +	case CXL_MBOX_OP_GET_DC_CONFIG:
> +		set_bit(CXL_DCD_ENABLED_GET_CONFIG, mds->dcd_cmds);
> +		break;
> +	case CXL_MBOX_OP_GET_DC_EXTENT_LIST:
> +		set_bit(CXL_DCD_ENABLED_GET_EXTENT_LIST, mds->dcd_cmds);
> +		break;
> +	case CXL_MBOX_OP_ADD_DC_RESPONSE:
> +		set_bit(CXL_DCD_ENABLED_ADD_RESPONSE, mds->dcd_cmds);
> +		break;
> +	case CXL_MBOX_OP_RELEASE_DC:
> +		set_bit(CXL_DCD_ENABLED_RELEASE, mds->dcd_cmds);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
>  static bool cxl_is_security_command(u16 opcode)
>  {
>  	int i;
> @@ -666,6 +697,7 @@ static int cxl_xfer_log(struct cxl_memdev_state *mds, uuid_t *uuid,
>  static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
>  {
>  	struct cxl_cel_entry *cel_entry;
> +	struct cxl_mem_command *cmd;
>  	const int cel_entries = size / sizeof(*cel_entry);
>  	struct device *dev = mds->cxlds.dev;
>  	int i;
> @@ -674,11 +706,12 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
>  
>  	for (i = 0; i < cel_entries; i++) {
>  		u16 opcode = le16_to_cpu(cel_entry[i].opcode);
> -		struct cxl_mem_command *cmd = cxl_mem_find_command(opcode);
> +		cmd = cxl_mem_find_command(opcode);
>  
> -		if (!cmd && !cxl_is_poison_command(opcode)) {
> -			dev_dbg(dev,
> -				"Opcode 0x%04x unsupported by driver\n", opcode);
> +		if (!cmd && !cxl_is_poison_command(opcode) &&
> +		    !cxl_is_dcd_command(opcode)) {
> +			dev_dbg(dev, "Opcode 0x%04x unsupported by driver\n",
> +				opcode);
>  			continue;
>  		}
>  
> @@ -688,6 +721,9 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
>  		if (cxl_is_poison_command(opcode))
>  			cxl_set_poison_cmd_enabled(&mds->poison, opcode);
>  
> +		if (cxl_is_dcd_command(opcode))
> +			cxl_set_dcd_cmd_enabled(mds, opcode);
> +
>  		dev_dbg(dev, "Opcode 0x%04x enabled\n", opcode);
>  	}
>  }
> @@ -1059,7 +1095,7 @@ int cxl_dev_state_identify(struct cxl_memdev_state *mds)
>  	if (rc < 0)
>  		return rc;
>  
> -	mds->total_bytes =
> +	mds->total_static_capacity =
>  		le64_to_cpu(id.total_capacity) * CXL_CAPACITY_MULTIPLIER;
>  	mds->volatile_only_bytes =
>  		le64_to_cpu(id.volatile_capacity) * CXL_CAPACITY_MULTIPLIER;
> @@ -1077,10 +1113,137 @@ int cxl_dev_state_identify(struct cxl_memdev_state *mds)
>  		mds->poison.max_errors = min_t(u32, val, CXL_POISON_LIST_MAX);
>  	}
>  
> +	mds->dc_event_log_size = le16_to_cpu(id.dc_event_log_size);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_dev_state_identify, CXL);
>  
> +/**
> + * cxl_dev_dynamic_capacity_identify() - Reads the dynamic capacity
> + * information from the device.
> + * @mds: The memory device state
> + * Return: 0 if identify was executed successfully.
> + *
> + * This will dispatch the get_dynamic_capacity command to the device
> + * and on success populate structures to be exported to sysfs.
> + */
> +int cxl_dev_dynamic_capacity_identify(struct cxl_memdev_state *mds)
> +{
> +	struct cxl_dev_state *cxlds = &mds->cxlds;
> +	struct device *dev = cxlds->dev;
> +	struct cxl_mbox_dynamic_capacity *dc;
> +	struct cxl_mbox_get_dc_config get_dc;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	u64 next_dc_region_start;
> +	int rc, i;
> +
> +	for (i = 0; i < CXL_MAX_DC_REGION; i++)
> +		sprintf(mds->dc_region[i].name, "dc%d", i);
> +
> +	/* Check GET_DC_CONFIG is supported by device */
> +	if (!test_bit(CXL_DCD_ENABLED_GET_CONFIG, mds->dcd_cmds)) {
> +		dev_dbg(dev, "unsupported cmd: get_dynamic_capacity_config\n");
> +		return 0;
> +	}
> +
> +	dc = kvmalloc(mds->payload_size, GFP_KERNEL);
> +	if (!dc)
> +		return -ENOMEM;
> +
> +	get_dc = (struct cxl_mbox_get_dc_config) {
> +		.region_count = CXL_MAX_DC_REGION,
> +		.start_region_index = 0,
> +	};
> +
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_GET_DC_CONFIG,
> +		.payload_in = &get_dc,
> +		.size_in = sizeof(get_dc),
> +		.size_out = mds->payload_size,
> +		.payload_out = dc,
> +		.min_out = 1,
> +	};
> +	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	if (rc < 0)
> +		goto dc_error;
> +
> +	mds->nr_dc_region = dc->avail_region_count;
> +
> +	if (mds->nr_dc_region < 1 || mds->nr_dc_region > CXL_MAX_DC_REGION) {
> +		dev_err(dev, "Invalid num of dynamic capacity regions %d\n",
> +			mds->nr_dc_region);
> +		rc = -EINVAL;
> +		goto dc_error;
> +	}
> +
> +	for (i = 0; i < mds->nr_dc_region; i++) {
> +		struct cxl_dc_region_info *dcr = &mds->dc_region[i];
> +
> +		dcr->base = le64_to_cpu(dc->region[i].region_base);
> +		dcr->decode_len =
> +			le64_to_cpu(dc->region[i].region_decode_length);
> +		dcr->decode_len *= CXL_CAPACITY_MULTIPLIER;
> +		dcr->len = le64_to_cpu(dc->region[i].region_length);
> +		dcr->blk_size = le64_to_cpu(dc->region[i].region_block_size);
> +
> +		/* Check regions are in increasing DPA order */
> +		if ((i + 1) < mds->nr_dc_region) {
> +			next_dc_region_start =
> +				le64_to_cpu(dc->region[i + 1].region_base);
> +			if ((dcr->base > next_dc_region_start) ||
> +			    ((dcr->base + dcr->decode_len) > next_dc_region_start)) {
> +				dev_err(dev,
> +					"DPA ordering violation for DC region %d and %d\n",
> +					i, i + 1);
> +				rc = -EINVAL;
> +				goto dc_error;
> +			}
> +		}
> +
> +		/* Check the region is 256 MB aligned */
> +		if (!IS_ALIGNED(dcr->base, SZ_256M)) {
> +			dev_err(dev, "DC region %d not aligned to 256MB\n", i);
> +			rc = -EINVAL;
> +			goto dc_error;
> +		}
> +
> +		/* Check Region base and length are aligned to block size */
> +		if (!IS_ALIGNED(dcr->base, dcr->blk_size) ||
> +		    !IS_ALIGNED(dcr->len, dcr->blk_size)) {
> +			dev_err(dev, "DC region %d not aligned to %#llx\n", i,
> +				dcr->blk_size);
> +			rc = -EINVAL;
> +			goto dc_error;
> +		}
> +
> +		dcr->dsmad_handle =
> +			le32_to_cpu(dc->region[i].region_dsmad_handle);
> +		dcr->flags = dc->region[i].flags;
> +		sprintf(dcr->name, "dc%d", i);
> +
> +		dev_dbg(dev,
> +			"DC region %s DPA: %#llx LEN: %#llx BLKSZ: %#llx\n",
> +			dcr->name, dcr->base, dcr->decode_len, dcr->blk_size);
> +	}
> +
> +	/*
> +	 * Calculate entire DPA range of all configured regions which will be mapped by
> +	 * one or more HDM decoders
> +	 */
> +	mds->total_dynamic_capacity =
> +		mds->dc_region[mds->nr_dc_region - 1].base +
> +		mds->dc_region[mds->nr_dc_region - 1].decode_len -
> +		mds->dc_region[0].base;

The above code assumes there is no DPA address gap between two adjacent dc
regions. Not sure whether it will always be true or not, I cannot find any
specific statement in the spec. 

Fan

> +	dev_dbg(dev, "Total dynamic capacity: %#llx\n",
> +		mds->total_dynamic_capacity);
> +
> +dc_error:
> +	kvfree(dc);
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_dev_dynamic_capacity_identify, CXL);
> +
>  static int add_dpa_res(struct device *dev, struct resource *parent,
>  		       struct resource *res, resource_size_t start,
>  		       resource_size_t size, const char *type)
> @@ -1112,6 +1275,11 @@ int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
>  	struct cxl_dev_state *cxlds = &mds->cxlds;
>  	struct device *dev = cxlds->dev;
>  	int rc;
> +	size_t untenanted_mem =
> +		mds->dc_region[0].base - mds->total_static_capacity;
> +
> +	mds->total_capacity = mds->total_static_capacity +
> +			untenanted_mem + mds->total_dynamic_capacity;
>  
>  	if (!cxlds->media_ready) {
>  		cxlds->dpa_res = DEFINE_RES_MEM(0, 0);
> @@ -1121,13 +1289,23 @@ int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
>  	}
>  
>  	cxlds->dpa_res =
> -		(struct resource)DEFINE_RES_MEM(0, mds->total_bytes);
> +		(struct resource)DEFINE_RES_MEM(0, mds->total_capacity);
> +
> +	for (int i = 0; i < CXL_MAX_DC_REGION; i++) {
> +		struct cxl_dc_region_info *dcr = &mds->dc_region[i];
> +
> +		rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->dc_res[i],
> +				 dcr->base, dcr->decode_len, dcr->name);
> +		if (rc)
> +			return rc;
> +	}
>  
>  	if (mds->partition_align_bytes == 0) {
>  		rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->ram_res, 0,
>  				 mds->volatile_only_bytes, "ram");
>  		if (rc)
>  			return rc;
> +
>  		return add_dpa_res(dev, &cxlds->dpa_res, &cxlds->pmem_res,
>  				   mds->volatile_only_bytes,
>  				   mds->persistent_only_bytes, "pmem");
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 89e560ea14c0..9c0b2fa72bdd 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -239,6 +239,15 @@ struct cxl_event_state {
>  	struct mutex log_lock;
>  };
>  
> +/* Device enabled DCD commands */
> +enum dcd_cmd_enabled_bits {
> +	CXL_DCD_ENABLED_GET_CONFIG,
> +	CXL_DCD_ENABLED_GET_EXTENT_LIST,
> +	CXL_DCD_ENABLED_ADD_RESPONSE,
> +	CXL_DCD_ENABLED_RELEASE,
> +	CXL_DCD_ENABLED_MAX
> +};
> +
>  /* Device enabled poison commands */
>  enum poison_cmd_enabled_bits {
>  	CXL_POISON_ENABLED_LIST,
> @@ -284,6 +293,9 @@ enum cxl_devtype {
>  	CXL_DEVTYPE_CLASSMEM,
>  };
>  
> +#define CXL_MAX_DC_REGION 8
> +#define CXL_DC_REGION_SRTLEN 8
> +
>  /**
>   * struct cxl_dev_state - The driver device state
>   *
> @@ -300,6 +312,8 @@ enum cxl_devtype {
>   * @dpa_res: Overall DPA resource tree for the device
>   * @pmem_res: Active Persistent memory capacity configuration
>   * @ram_res: Active Volatile memory capacity configuration
> + * @dc_res: Active Dynamic Capacity memory configuration for each possible
> + *          region
>   * @component_reg_phys: register base of component registers
>   * @info: Cached DVSEC information about the device.
>   * @serial: PCIe Device Serial Number
> @@ -315,6 +329,7 @@ struct cxl_dev_state {
>  	struct resource dpa_res;
>  	struct resource pmem_res;
>  	struct resource ram_res;
> +	struct resource dc_res[CXL_MAX_DC_REGION];
>  	resource_size_t component_reg_phys;
>  	u64 serial;
>  	enum cxl_devtype type;
> @@ -334,9 +349,12 @@ struct cxl_dev_state {
>   *                (CXL 2.0 8.2.9.5.1.1 Identify Memory Device)
>   * @mbox_mutex: Mutex to synchronize mailbox access.
>   * @firmware_version: Firmware version for the memory device.
> + * @dcd_cmds: List of DCD commands implemented by memory device
>   * @enabled_cmds: Hardware commands found enabled in CEL.
>   * @exclusive_cmds: Commands that are kernel-internal only
> - * @total_bytes: sum of all possible capacities
> + * @total_capacity: Sum of static and dynamic capacities
> + * @total_static_capacity: Sum of RAM and PMEM capacities
> + * @total_dynamic_capacity: Complete DPA range occupied by DC regions
>   * @volatile_only_bytes: hard volatile capacity
>   * @persistent_only_bytes: hard persistent capacity
>   * @partition_align_bytes: alignment size for partition-able capacity
> @@ -344,6 +362,10 @@ struct cxl_dev_state {
>   * @active_persistent_bytes: sum of hard + soft persistent
>   * @next_volatile_bytes: volatile capacity change pending device reset
>   * @next_persistent_bytes: persistent capacity change pending device reset
> + * @nr_dc_region: number of DC regions implemented in the memory device
> + * @dc_region: array containing info about the DC regions
> + * @dc_event_log_size: The number of events the device can store in the
> + * Dynamic Capacity Event Log before it overflows
>   * @event: event log driver state
>   * @poison: poison driver state info
>   * @mbox_send: @dev specific transport for transmitting mailbox commands
> @@ -357,9 +379,13 @@ struct cxl_memdev_state {
>  	size_t lsa_size;
>  	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
>  	char firmware_version[0x10];
> +	DECLARE_BITMAP(dcd_cmds, CXL_DCD_ENABLED_MAX);
>  	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
>  	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
> -	u64 total_bytes;
> +
> +	u64 total_capacity;
> +	u64 total_static_capacity;
> +	u64 total_dynamic_capacity;
>  	u64 volatile_only_bytes;
>  	u64 persistent_only_bytes;
>  	u64 partition_align_bytes;
> @@ -367,6 +393,20 @@ struct cxl_memdev_state {
>  	u64 active_persistent_bytes;
>  	u64 next_volatile_bytes;
>  	u64 next_persistent_bytes;
> +
> +	u8 nr_dc_region;
> +
> +	struct cxl_dc_region_info {
> +		u8 name[CXL_DC_REGION_SRTLEN];
> +		u64 base;
> +		u64 decode_len;
> +		u64 len;
> +		u64 blk_size;
> +		u32 dsmad_handle;
> +		u8 flags;
> +	} dc_region[CXL_MAX_DC_REGION];
> +
> +	size_t dc_event_log_size;
>  	struct cxl_event_state event;
>  	struct cxl_poison_state poison;
>  	int (*mbox_send)(struct cxl_memdev_state *mds,
> @@ -415,6 +455,10 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_UNLOCK		= 0x4503,
>  	CXL_MBOX_OP_FREEZE_SECURITY	= 0x4504,
>  	CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE	= 0x4505,
> +	CXL_MBOX_OP_GET_DC_CONFIG	= 0x4800,
> +	CXL_MBOX_OP_GET_DC_EXTENT_LIST	= 0x4801,
> +	CXL_MBOX_OP_ADD_DC_RESPONSE	= 0x4802,
> +	CXL_MBOX_OP_RELEASE_DC		= 0x4803,
>  	CXL_MBOX_OP_MAX			= 0x10000
>  };
>  
> @@ -462,6 +506,7 @@ struct cxl_mbox_identify {
>  	__le16 inject_poison_limit;
>  	u8 poison_caps;
>  	u8 qos_telemetry_caps;
> +	__le16 dc_event_log_size;
>  } __packed;
>  
>  /*
> @@ -617,7 +662,27 @@ struct cxl_mbox_set_partition_info {
>  	u8 flags;
>  } __packed;
>  
> +struct cxl_mbox_get_dc_config {
> +	u8 region_count;
> +	u8 start_region_index;
> +} __packed;
> +
> +/* See CXL 3.0 Table 125 get dynamic capacity config Output Payload */
> +struct cxl_mbox_dynamic_capacity {
> +	u8 avail_region_count;
> +	u8 rsvd[7];
> +	struct cxl_dc_region_config {
> +		__le64 region_base;
> +		__le64 region_decode_length;
> +		__le64 region_length;
> +		__le64 region_block_size;
> +		__le32 region_dsmad_handle;
> +		u8 flags;
> +		u8 rsvd[3];
> +	} __packed region[];
> +} __packed;
>  #define  CXL_SET_PARTITION_IMMEDIATE_FLAG	BIT(0)
> +#define CXL_DYNAMIC_CAPACITY_SANITIZE_ON_RELEASE_FLAG BIT(0)
>  
>  /* Set Timestamp CXL 3.0 Spec 8.2.9.4.2 */
>  struct cxl_mbox_set_timestamp_in {
> @@ -742,6 +807,7 @@ enum {
>  int cxl_internal_send_cmd(struct cxl_memdev_state *mds,
>  			  struct cxl_mbox_cmd *cmd);
>  int cxl_dev_state_identify(struct cxl_memdev_state *mds);
> +int cxl_dev_dynamic_capacity_identify(struct cxl_memdev_state *mds);
>  int cxl_await_media_ready(struct cxl_dev_state *cxlds);
>  int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
>  int cxl_mem_create_range_info(struct cxl_memdev_state *mds);
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 4e2845b7331a..ac1a41bc083d 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -742,6 +742,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> +	rc = cxl_dev_dynamic_capacity_identify(mds);
> +	if (rc)
> +		return rc;
> +
>  	rc = cxl_mem_create_range_info(mds);
>  	if (rc)
>  		return rc;
> 
> -- 
> 2.40.0
> 

-- 
Fan Ni <nifan@outlook.com>
