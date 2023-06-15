Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4431FEB64DB
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jun 2023 21:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjFOVls (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Jun 2023 17:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjFOVlq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Jun 2023 17:41:46 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2076.outbound.protection.outlook.com [40.92.52.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5272971
        for <linux-cxl@vger.kernel.org>; Thu, 15 Jun 2023 14:41:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dp5FgIBjkfO+LwPPKubzU47KtyEm6/A0vwq64B+2qMRAdIHHiK8Q4M8myHrST/r7yXvIFv7ZZWO9rzf+Hb4bfPA1sQBCtcXlaPE38IGhKTQ1/zk+KUzLKLJkUEf5DQqJSKHRO97FsTNRHNK7cD4gQx+TXMg3xnTbtK+0joo+Lnh4OlDghx8LB9cmY1uqBpjyYOxB6+0RFpBwIatkFJZUDRfGSEqGouOPcMnuJUb92mYm36442PIKbWLpsaEc4ob6ibaP/lLIuQTfB0dKSfG+0ke5HD6eMFWaV+PQIeepEa8dweUNPn/OvrR3MWtCTLhq9oKRyhtZ6HYRga1DgQuNhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g77Aq0HLtjte5/yPK62VKNNwsXLqS0zmAm4X7bmTyZI=;
 b=YhsrqFfWyb+b3UYZKb53BIHruaNUS6wsU/k1VfCqy4A+g2/8+hIAHY+aKAmS9Aw9yIgKE2myH1IsS7Ak9oswgr7/PFlpml01+RdVYOYWQ1ukbeMdhqDBgi6X+0GLq2xqaL+uuKzNw9hNzO+5ZF4TvnX7VNFB0WF9Q/PyCyDm3xLrX4Vn9ca8HiWBo+5mOYxdb9Yuw8YnMd8P0LSAr6LiKHoIs15QJkZeJCRBxakPTwyc6dzx5QYapDhtDHhUjjqYZDyfqzsy5Nf6Y4vXe9AJj8ax3Vpx9pou0+ovCMxAV7WsHjl8bIPWahr5LkGIjc/Qm0bi3esQX6xbbrRlAMv6pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g77Aq0HLtjte5/yPK62VKNNwsXLqS0zmAm4X7bmTyZI=;
 b=k1FNNE601AAbOd1XsfSFrCkFdLKX4QzQbJAIH34w7UqPKtdw5HNxeQ3XZhGMUKDELeVHk8w0gbR2wgcTVt9BadZebEj7G5DArGs6OAVwEPeXBtKlqNrwulZrDkgNH/xcIQ2s33ZDCPVkIpty5cCQU7t3n1GrzekAeD6AzbDpWB1RtS4bYtc/RoiDQfvpKxGWStCVCWY/ITAtADmweiQugRVxonpcqgZAufHnG8/rsM9drCBDQaI4fiHobFy6cOrcV0KOwSL1cqPUrmf4mIYSVR9/W5Gx/RqetCCYMgl3ki8YI0a9/O1ZC5vQ7L8G16kYFjSDx+FFLYszhfGvwk9AOg==
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com (2603:1096:4:7a::17) by
 TYZPR06MB4030.apcprd06.prod.outlook.com (2603:1096:400:24::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.29; Thu, 15 Jun 2023 21:41:37 +0000
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::33a7:c9e1:75ae:3227]) by SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::33a7:c9e1:75ae:3227%4]) with mapi id 15.20.6477.028; Thu, 15 Jun 2023
 21:41:36 +0000
Date:   Thu, 15 Jun 2023 14:41:28 -0700
From:   Fan Ni <nifan@outlook.com>
To:     ira.weiny@intel.com
Cc:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/5] cxl/mem : Read Dynamic capacity configuration from
 the device
Message-ID: <SG2PR06MB339714FAF99C022569BB193CB25BA@SG2PR06MB3397.apcprd06.prod.outlook.com>
References: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
 <20230604-dcd-type2-upstream-v1-1-71b6341bae54@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230604-dcd-type2-upstream-v1-1-71b6341bae54@intel.com>
X-TMN:  [lowUr81M6Hzl2YtWtb7DSpDdldpm1oV1]
X-ClientProxiedBy: BYAPR01CA0048.prod.exchangelabs.com (2603:10b6:a03:94::25)
 To SG2PR06MB3397.apcprd06.prod.outlook.com (2603:1096:4:7a::17)
X-Microsoft-Original-Message-ID: <ZIuFiGAyiCMMv7i3@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3397:EE_|TYZPR06MB4030:EE_
X-MS-Office365-Filtering-Correlation-Id: bd825cb2-93c3-4d39-9b1a-08db6de94b0d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5qxHDoqfTrSNnVcnNX6DVujACsMBdmekEw+yl3C2YYjdQj0n5HVPhz/NYRwrtiVo2LoWLbsGbrQgIto5kKRNqi2ltZBA9iy/zw1NwgVW/dXXSehMbqKRuDWlObO2A+vWjR2s+aiMdqO9yQQqqUPwwiTM1lLYaZ2wFDLZOOjzkaDPrSmvQx5USVoskamzkXoxCr4uuDWiiJZZRTE2s0XYxzaEOgBF/F3REINWbNLGB4v8Z2FWu+c2qUwQqo9f/OVnyaCnThGSol5FdSaYj0MimmAEHMhiciOO8haaIFfBEqVFre0sfVmJeRDVCyvtp5DN+YspMSLsgFlYk3HsbTZGFH8w3lCdkZn3lzFwlWM+YAaOqDBzZMYE/hwXI0ikH/7FZeRLMNH4ezNiO6du2YSdjJoB/05HCLfgVBrOdkL8hG93ZcHA+DHvmilnQLk6TVwn4J7KD4eAjp7gP0Bi4kU4O64z7CIsTgLXDUhF0mU+tPvI/s7qMPsc4VnWIxL+/lTlKLF2QPjQPEvl1DNYSgTiK7a3iTDkLdDylzel8BECiHNHkkgadCpr6Jk0ezXSqfAOETRR16qhrur8rqyvpY4CXqgzrsE1JHTlrzflhnj6bxdib7uKe6J8Zup8fxFEkSPK
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2NwUlNSK3o5Z3VmSHlkcVBrcXJldEtFYWtaa2JydFZMa2EvdWhxa0tRTUYy?=
 =?utf-8?B?OUczMmMvZDg4NG5GdEdIQldwVnlrNnlFd3FoNmFKeHk3eXdEOU80dlAvS3V1?=
 =?utf-8?B?V0E2VllHbHFQYUwyMm04N3lZME12NldJVEg2YzNwUVArMkMyaEl4MEthcmhh?=
 =?utf-8?B?dEY3RDRDc2UzSTBncnk0R2wxZXpVc1FWU2dFa3pnOTZLWi9mMUdGNXcrcXlB?=
 =?utf-8?B?eU02OXFQaEJJajVKT2NEbjVVZzMvOCtUbTVMalBoWi9SdElDc2t3ZEovd2pE?=
 =?utf-8?B?TDk2bGd1eHNHWDA4V2pMb0t0RlBmamNhRTBGaitqRmJpbGx1QlY5bEJEcFlW?=
 =?utf-8?B?bWVqWTNETHIyb3JoaHhTcjFRWnI5eDlqMFNmbmRYZ3Y2TWVERWhnQ1V1VDNT?=
 =?utf-8?B?NlZqMkNOeVNtbmgvTXhVUmVDVEM3aWJIRkRTV1MxcUgrbjhacjhpSEdCbllq?=
 =?utf-8?B?Q1JteTJxOTAybFlxTTRDS3NaREJ1WXRyd2lmQzIvYitXRW94QkRib3owTE5w?=
 =?utf-8?B?WGVGSzduUC9oRStNa1NJbWdDM1lhTFplczhFZzM5dVNpeXAyMGhybFdoYTRr?=
 =?utf-8?B?elk1b3NCRjVKZ2llSjV4KzhaY3Z0ZmNyNGpRTjd3THZKNDA2NERuK01yWGNz?=
 =?utf-8?B?d3ZWeVd0YjFlUU9rL29ueGJvdlBwb0Z2REFKcldSNTRwMW5ZcG1SWUhqWlJO?=
 =?utf-8?B?N3FLYU8yV1Y0U0JvMXg1YnpqZ3VONEZzQ3NacnZPb0t6UHN3NklDM2JFYlN5?=
 =?utf-8?B?cDdFcXViaURvcGdyeisvM1luUzNFYkVOdU1sUXl2am1HTk5QY2FIVVJ4NFVJ?=
 =?utf-8?B?VnYwRnU1Z2VlZXcwY2NlcGI4dnJVNFc1TVdIOTNVNkVIdUV6L0dOaVdIOHBO?=
 =?utf-8?B?MlU1cnlicUhqSGp5UnB5Sm1HbHp2TWU4VVdrOFV2VHp2RElCZUg5TnNqNm5S?=
 =?utf-8?B?MGkzcVBJU0VCWVpaVUY5WisrY1NlVER6ZGMvUDh6SHBKY0JPQnUwYXlHYUJX?=
 =?utf-8?B?dStPYVBhWm1UNG1vWGx2eG0ya1NiRVczU1FncU9pZXB0OXRhOVM3SHR2RlVD?=
 =?utf-8?B?MlZkNkp4cHc2NXgzekhOMVRkVzJpR3d2YkNzUFJrb3NKTU11R1k2aGwwbFpy?=
 =?utf-8?B?Um5EVEFiTVk2Q1lPNGpLVVJwaXdXMW5KKzY3ek9LczN3WnNNK0FlbU51QnRL?=
 =?utf-8?B?SS92N3R0ZWhObmlDR0hYUkdvVk5BZTZ0SzdocHBIQnhTbWNoQnQ3eTduQkRs?=
 =?utf-8?B?MU9UeHozRTVHVnRVeXNkUW45M3ZtcDZHOVdrd0ZYT0lrOWJFTTNWM1ZWbzBT?=
 =?utf-8?B?NDZNY09la0hEZm1aQlNaQjhtUHQrM0l1dTdBdnRWRnBaSU5HenRINVlzNTFI?=
 =?utf-8?B?RmQ4QUxaK3JvMlQzTllSQjV4L09EOG55OStIaEk3Nk1JNnVqZEozNkR4QU5B?=
 =?utf-8?B?UVhlWXV4a3VBNVJWTHh4TWt1bXNyT3IwczIwaDZqKzhvZlVEMUtBd1hEdFJQ?=
 =?utf-8?B?QkI0THdibmcyUXRBa2RuTjdOUzVOK1pUSk1YcEloTmRxTGRuaXByRXBVSlpW?=
 =?utf-8?B?NGd6d0EwcGYzUCtSMzc4WnVlYmR4ZVpzSGRudktmWTBmUnJ0ZzFHL21VZEtP?=
 =?utf-8?B?MHNLdUYwVkx2bFExWDZ3VENkdERaZ1E9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd825cb2-93c3-4d39-9b1a-08db6de94b0d
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3397.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2023 21:41:36.4010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4030
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

should it be i < mds->nr_dc_region???

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

Remove blank line ?

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

Remove blank line?

Fan
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
