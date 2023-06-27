Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39FDAEB64D9
	for <linux-cxl@archiver.kernel.org>; Tue, 27 Jun 2023 18:18:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjF0SSL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 27 Jun 2023 14:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjF0SSJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 27 Jun 2023 14:18:09 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2043.outbound.protection.outlook.com [40.92.107.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14D210E7
        for <linux-cxl@vger.kernel.org>; Tue, 27 Jun 2023 11:18:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hW9yDy3K+Vsv0ehFLGaJ9kls+0d9xkUPZojv/r0BK/47MZfEeSuIKNZEwHpzTiYu09W9VuJ45B8qtHcFA4ufULVmwgKINGA+9imnbYdwlVV4kVSi2zSu1Km5icEu63IHDfTUeePCE8Sm9RIPwAjWCl/IZRESGSbfnNE+7cYwOASeyw8GZVpbUYvwPj0z/dJjgxQ6z9SL6310Fr7ed9EZ+pbKdIEr8BkIK+nvqH+xlxe+EgApgPQ13akPkoEUtqgbKh/2mAh/7wwegc0C1Az3gTNnLhP8TSRNK5SMjQY82JjUKb1rXq9pd0kv6q6zi/Xpfu0JaOX5z9r/H2giEcruCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyIYf3V2vJ2e++9RLsOKs6FL/TA09/UtSzn5BIc+VvA=;
 b=nSJxl+XSy6OQ16r95OyC7eEU3jmQd3m0kxd6wmfefe8qTlJ1YJgm4AuXnH105YnIMzCjDUXEQINbk5rdUI7CUraSBzStL9IvIg9A4NMqNscO6ZxwwTqX0eyu+uyJbSDeOyFwcmlpcrzmxWdwGPMtDt0pja4M8w+VUjh0FtBMPC8ceKeI3SAjdfsfJV8NEj254cimKOu9lHfuW8JzJGUKHxwmF1ccCrfx85Oo4CmdI6DPYYmmjXfdHSKlz/+QOX1kvB1DzUdO1GVdZuh8XelrstBaX7WoRBJVWNs+OqIxIDVybksKqX+v/gd5NrIP7voj3JQXc73p+6vkny2gllcceA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyIYf3V2vJ2e++9RLsOKs6FL/TA09/UtSzn5BIc+VvA=;
 b=AdsYzZ0jP+pCi/X47Mkj+qAdLcDSYspRE8tcDZAnEc/21bha02X5PpXf25hr7ud4VGL7CVKQCGb8syevUMxFLENjIjOKLrlmZhc4Yyzx/OnEuA3f6M6PBEm9l7bI0v1oukzdU/MwaDcclchMCEuTXVsd8XRtEaUlEr6rpaVW1qoTal03vsDQObT7P1WU98nbeu9+tH8tzFU1bzX/oeIZ+0gtmFHChIpQbQD0y1r3U0Q6aEqms+LmQnzR4x9AnIGsliLnrUMR0u9Px2EMUF+qQ/RpB5AN5WnSc/Q2jk/n4AXoYVSL7ahNx7z/esfPKV818LuvnFmUFtW9RrarrWQf0A==
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com (2603:1096:4:7a::17) by
 KL1PR06MB6110.apcprd06.prod.outlook.com (2603:1096:820:d8::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.24; Tue, 27 Jun 2023 18:17:59 +0000
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::33a7:c9e1:75ae:3227]) by SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::33a7:c9e1:75ae:3227%4]) with mapi id 15.20.6521.026; Tue, 27 Jun 2023
 18:17:59 +0000
Date:   Tue, 27 Jun 2023 11:17:36 -0700
From:   Fan Ni <nifan@outlook.com>
To:     ira.weiny@intel.com
Cc:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org, a.manzanares@samsung.com,
        dave@stgolabs.net, nmtadam.samsung@gmail.com, nifan@outlook.com
Subject: Re: [PATCH 4/5] cxl/mem: Add support to handle DCD add and release
 capacity events.
Message-ID: <SG2PR06MB33975A0AD7B96EFE689AAF0DB227A@SG2PR06MB3397.apcprd06.prod.outlook.com>
References: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
 <20230604-dcd-type2-upstream-v1-4-71b6341bae54@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230604-dcd-type2-upstream-v1-4-71b6341bae54@intel.com>
X-TMN:  [ekki24xkM4+CATzhukGSO4EPdZ7iyhDefzYHuH3RSxwCuTIpi1Qyfwqwx+YdtBa+CG/ERol4DBA=]
X-ClientProxiedBy: MW4PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:303:8f::8) To SG2PR06MB3397.apcprd06.prod.outlook.com
 (2603:1096:4:7a::17)
X-Microsoft-Original-Message-ID: <ZJsnwOllmt36Zp5E@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3397:EE_|KL1PR06MB6110:EE_
X-MS-Office365-Filtering-Correlation-Id: 26b277d7-3e91-43a6-94e0-08db773ad5bd
X-MS-Exchange-SLBlob-MailProps: Cq7lScuPrnpGrp2Kpt1LRB/0F8qA1SPF5Oc1pvchRGVlsgHEGKDH+7rBRBCYRLhD4+4poP1v0wbyVzvzqntaO52tgYaloExLqKLO0uhV3NhjpaCgPvBGgIWA86+B6lf1lN97AclzQ7lJ6z1cqz2FIElztKh5BCWfuUzIg3iaRfHQnL8GGeccwVKWTas4bUTBw0F+zzbFtvgmnzOFwwFOUdSG9aAD9V6HdN7fHJgzdaPJvjWiegbOh/iXZW2FavLKQQl0vJs1M+4kWvLw6aOOGXOXhdJdtx8ysnGmY4LQragMkaEuVYdnSy1tv1fYluqDcBxoQtVyVBAd39T6+qM56xwrX4a7xweB2db8583VzshGT4AhAmfW4pul9/vQpnLe2pkMhUd8Bhm69VK1DEnjxlwyNdXfwkxcTMoJ1BogEhmtKPhSpSvb1PjCkcegB5FguwYrazXxzRDIeQJmjx3EvOZk/6kX35241qUZjRE+d9PTX5LZkinKQlDXsNH9es2ED8Ss2VjPP8vPg4eeV0gB2w36gKQsF9YkUeBmpRHLCTleKDZISYP+x8U5I31Lh2GIEegiq4j3zSSSmI0mgTFA49BLzVhvJrCZN0ngIeq4RQK34GqM4mKDQYH0WaMSv3M0ImJQBkQGgkGjYKKoz8GxzwXf2kmWSaxNlB4eXuB9RiLxZA+qaEkEBtRwhYZB2jnSbcxJ+L2SCwTvRrcmH1SIr1VzUjsWokZtC0bTdJqM/MCrfrkl9crGAwtVFVAwH1FcE0u/OBEZq9s=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lZzHOApZlMgUfRoCjVkcWQXWnRAaOjWbzdPJymI0g72LUDb/MhTUkLq9h6WvCRXYs1BXBH8BwonQT0v8SKVsJC+bv3NLGSExT+ZukR48LaBblionvrwh5DmSUQvZ2B5KmC0iw9oz0rCi3KeyAON7+RQ6f8d1e+AAIBM7NYrPCsCr0JpnD+tnT97dH4PI6OEnbZwZbgsFy7ONrHPDwTULIQ8ZX2vOGgyhjD5gOMURr97/w35bGrcCU/SpONG9Dnd7u8HR08boqqigkzg0th4cBMnCJ+0njfDZYOw15TTb9miCzkXhL8tOAsoEpaHC9s/ra9G7Vf4ghmdYzvqEC8jDQLesw2BkTF6HOtgXm2t/CZ5jsuhJ8mbRmXP+zaWb2Cvm084jK93ppfzdrU9RiGvob4sJ8fbX26jsVwKL4MZsilx0F5PPqmVOWwdXBoYAzdBtyBYGsQBUWlDc3Iih35yLf58QBqUxUxIGeBAXwdHT9PH0mgfWo9JzjAjMsDLlHKJIte5V7FbCeG7n0DL47a6Z12ObKjkhpahCbuTh9IhlowYukJC1FMGNbyJiDUFZ0YJTkGD4cuWn3WxlQwFhaX+EEfbXJgDHyknpCV46eWhgnFd7JnjeZpOf68w/+NR9AQ69
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjBGSFM4d3pRY29PdmFCMjhQTXRCN0RVeFkvZ1V4K0Z3cUtSeFFudWxQbXY3?=
 =?utf-8?B?Y2FVbXhiRzBDdUFqdmxXMGs3UkFpN21CVTZMQloyUUdnWlRUVkNVYnRWM0la?=
 =?utf-8?B?T2JtRGZhYk1ReTJHcXBjS3NXNjNtS0UvTVg2VEVidkVPTGZVUHl1WWpUYitq?=
 =?utf-8?B?TlJKcVRtY3d3LzVlN1Q5SS95NUdVYUNqVmNOTnZpT2VIVkMwcTlheTlhcFlh?=
 =?utf-8?B?T0k5UGk2WG1FaENBaU1udGFWQi9oN0F4a0p0SVBiYlk1Rnl6QVNFQldsY3BZ?=
 =?utf-8?B?UGd3eTBXTmhZNVU4WTVLcGd5S1ZKWWZUMnZIUHRtNjc3b0ZvMk8yUHU0STd5?=
 =?utf-8?B?ays4MFV1d2Y0TGFUODZ3WkJ4aXRGM1d3UGwwTnBjd2d3QlJMN3JxajRwWEE3?=
 =?utf-8?B?ZTgzRjU1OFNXaWFJU2pHd0JkTFlYQ05OWnpxd0NPaFNWbU5tY1k5ZFlFT2dt?=
 =?utf-8?B?MGFDSFhsV2g5QW9VU0E2Smc1bWpWNWhiOVNKRE5ta3NBWFloQXZhclI2VFpD?=
 =?utf-8?B?MHB0dEJYS2ZFMGJvN2FMd2VKSGw2UkNLTlBtemp5NWthU0NmWDhraUp3TUtB?=
 =?utf-8?B?TWNkOC8zMSszWGNwN1FRaDJ5ZmE4K3NOTnk2YmdVOWtmTk9VbnRtaWRvVDd2?=
 =?utf-8?B?ZW5YMW83ZG54M0xJckRMMkU1ZzNlQnJIdmxmWWo0VFA5eUlHaXFHaWc5SGQ4?=
 =?utf-8?B?UUQveUw3dVNvcUhLZWNEbld4UkVtdDNBMXZ1N0U3REFuUWhjZE1FOFZhV2Zr?=
 =?utf-8?B?K3ptczhWeDdxOXlxUDRQQy9NdnFpVmZ0RzJWSks5Z0Z0TlZLcWZCeDI1TDZk?=
 =?utf-8?B?ajA5WHRPWnlUS2lYUXBSMHpDdURhL1VtT0dCbG8ycUJrVGpqVGlzY3NhMU9n?=
 =?utf-8?B?VytkUVVKUlpVVHpEdmNoMkNyVldtdDZTdHZob09wL3BacFFXM3Z4a21kUnhK?=
 =?utf-8?B?YVA4WitIQkJ3ejdxT0ROVXpkSWF0bkVJZEpESHVUS1YwRFZoV2Y0RkhaYUow?=
 =?utf-8?B?dUFCenc1bGxvNDhHTWJBUjBBZlhXRGY5RkduT3NSRE40d0RTbk9UeEJRT212?=
 =?utf-8?B?QmJqTTVhUG5hU3JJc3E1TU1HZEJSOHRLYnpFYkkyMVRGU010N3VUTDF0R0po?=
 =?utf-8?B?V0ZvWU5rckhiTXZjZmZJOW9LVzU0cnF1eUZEd3V4bXZrbGZWODZ6Sk1KRnMr?=
 =?utf-8?B?S2FiWU1tUHNqeXUwR0FUNTltMTdrdHZkV0FzcGN2M3ZiTlA0TmNyYndqWDEz?=
 =?utf-8?B?Ui9aNlhGNUxFdXlYQlM4eDVGUzlzTjhVQW1idW00a0dKM0NLR1lGR255WTda?=
 =?utf-8?B?ejg0R2ZzbDdWNHIwVmJBODVmS0Z5V1ZSS3Q5RkJaZ0dWbmdiVmI1RnNaVkMw?=
 =?utf-8?B?NXlEOGJ4Q2toSmFCeDBzc1hlVXYxYlladVgxQzJOTENuMkhGTUhZbG5wSFdH?=
 =?utf-8?B?Ly9aY2tFVEYzZnVMdDRGZnhzRWR3M2VDSTB6dGN4bElSL293bUFFbVZ0OWgx?=
 =?utf-8?B?QzUvUGkyc2VhZGF1S1NRUDF0NTUzYlVYeFAwSDhGTmx6cmZqdXJoeG02RGtD?=
 =?utf-8?B?aWlhUzNCMVp6Wnl3RzJLa2N4WEY2VW15RGFzV1A1L05vZzd0c250ek9KdEFo?=
 =?utf-8?B?Y2FZdGQ4MzYyRmNZRDdEa3RMRTJudjUxeXNRK3JrbmNkZG1JVjB1ck5iakhi?=
 =?utf-8?B?cTg5RmdjNjhGdEozbnlDOGRsMTFhN3RYOEF3dUhWcTJBc0VuMkViM2VRPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b277d7-3e91-43a6-94e0-08db773ad5bd
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3397.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2023 18:17:59.8090
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB6110
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The 06/14/2023 12:16, ira.weiny@intel.com wrote:
> From: Navneet Singh <navneet.singh@intel.com>
> 
> A dynamic capacity device utilizes events to signal the host about the
> changes to the allocation of DC blocks. The device communicates the
> state of these blocks of dynamic capacity through an extent list that
> describes the starting DPA and length of all blocks the host can access.
> 
> Based on the dynamic capacity add or release event type,
> dynamic memory represented by the extents are either added
> or removed as devdax device.
> 
> Process the dynamic capacity add and release events.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> 
> ---
> [iweiny: Remove invalid comment]
> ---
>  drivers/cxl/core/mbox.c   | 345 +++++++++++++++++++++++++++++++++++++++++++++-
>  drivers/cxl/core/region.c | 214 +++++++++++++++++++++++++++-
>  drivers/cxl/core/trace.h  |   3 +-
>  drivers/cxl/cxl.h         |   4 +-
>  drivers/cxl/cxlmem.h      |  76 ++++++++++
>  drivers/cxl/pci.c         |  10 +-
>  drivers/dax/bus.c         |  11 +-
>  drivers/dax/bus.h         |   5 +-
>  8 files changed, 652 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index c5b696737c87..db9295216de5 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -767,6 +767,14 @@ static const uuid_t log_uuid[] = {
>  	[VENDOR_DEBUG_UUID] = DEFINE_CXL_VENDOR_DEBUG_UUID,
>  };
>  
> +/* See CXL 3.0 8.2.9.2.1.5 */
> +enum dc_event {
> +	ADD_CAPACITY,
> +	RELEASE_CAPACITY,
> +	FORCED_CAPACITY_RELEASE,
> +	REGION_CONFIGURATION_UPDATED,
> +};
> +
>  /**
>   * cxl_enumerate_cmds() - Enumerate commands for a device.
>   * @mds: The driver data for the operation
> @@ -852,6 +860,14 @@ static const uuid_t mem_mod_event_uuid =
>  	UUID_INIT(0xfe927475, 0xdd59, 0x4339,
>  		  0xa5, 0x86, 0x79, 0xba, 0xb1, 0x13, 0xb7, 0x74);
>  
> +/*
> + * Dynamic Capacity Event Record
> + * CXL rev 3.0 section 8.2.9.2.1.3; Table 8-45
> + */
> +static const uuid_t dc_event_uuid =
> +	UUID_INIT(0xca95afa7, 0xf183, 0x4018, 0x8c,
> +		0x2f, 0x95, 0x26, 0x8e, 0x10, 0x1a, 0x2a);
> +
>  static void cxl_event_trace_record(const struct cxl_memdev *cxlmd,
>  				   enum cxl_event_log_type type,
>  				   struct cxl_event_record_raw *record)
> @@ -945,6 +961,188 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
>  	return rc;
>  }
>  
> +static int cxl_send_dc_cap_response(struct cxl_memdev_state *mds,
> +				struct cxl_mbox_dc_response *res,
> +				int extent_cnt, int opcode)
> +{
> +	struct cxl_mbox_cmd mbox_cmd;
> +	int rc, size;
> +
> +	size = struct_size(res, extent_list, extent_cnt);
> +	res->extent_list_size = cpu_to_le32(extent_cnt);
> +
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = opcode,
> +		.size_in = size,
> +		.payload_in = res,
> +	};
> +
> +	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +
> +	return rc;
> +
unwanted blank line.
> +}
> +
> +static int cxl_prepare_ext_list(struct cxl_mbox_dc_response **res,
> +					int *n, struct range *extent)
> +{
> +	struct cxl_mbox_dc_response *dc_res;
> +	unsigned int size;
> +
> +	if (!extent)
> +		size = struct_size(dc_res, extent_list, 0);
> +	else
> +		size = struct_size(dc_res, extent_list, *n + 1);
> +
> +	dc_res = krealloc(*res, size, GFP_KERNEL);
> +	if (!dc_res)
> +		return -ENOMEM;
> +
> +	if (extent) {
> +		dc_res->extent_list[*n].dpa_start = cpu_to_le64(extent->start);
> +		memset(dc_res->extent_list[*n].reserved, 0, 8);
> +		dc_res->extent_list[*n].length =
> +				cpu_to_le64(range_len(extent));
> +		(*n)++;
> +	}
> +
> +	*res = dc_res;
> +	return 0;
> +}
As mentioned by existing comments, need a blank line here.
> +/**
> + * cxl_handle_dcd_event_records() - Read DCD event records.
> + * @mds: The memory device state
> + *
> + * Returns 0 if enumerate completed successfully.
> + *
> + * CXL devices can generate DCD events to add or remove extents in the list.
> + */
> +static int cxl_handle_dcd_event_records(struct cxl_memdev_state *mds,
> +					struct cxl_event_record_raw *rec)
> +{
> +	struct cxl_mbox_dc_response *dc_res = NULL;
> +	struct device *dev = mds->cxlds.dev;
> +	uuid_t *id = &rec->hdr.id;
> +	struct dcd_event_dyn_cap *record =
> +			(struct dcd_event_dyn_cap *)rec;
> +	int extent_cnt = 0, rc = 0;
> +	struct cxl_dc_extent_data *extent;
> +	struct range alloc_range, rel_range;
> +	resource_size_t dpa, size;
> +
> +	if (!uuid_equal(id, &dc_event_uuid))
> +		return -EINVAL;
> +
> +	switch (record->data.event_type) {
> +	case ADD_CAPACITY:
> +		extent = devm_kzalloc(dev, sizeof(*extent), GFP_ATOMIC);
> +		if (!extent)
> +			return -ENOMEM;
> +
> +		extent->dpa_start = le64_to_cpu(record->data.extent.start_dpa);
> +		extent->length = le64_to_cpu(record->data.extent.length);
> +		memcpy(extent->tag, record->data.extent.tag,
> +				sizeof(record->data.extent.tag));
> +		extent->shared_extent_seq =
> +			le16_to_cpu(record->data.extent.shared_extn_seq);
> +		dev_dbg(dev, "Add DC extent DPA:0x%llx LEN:%llx\n",
> +					extent->dpa_start, extent->length);
> +		alloc_range = (struct range) {
> +			.start = extent->dpa_start,
> +			.end = extent->dpa_start + extent->length - 1,
> +		};
> +
> +		rc = cxl_add_dc_extent(mds, &alloc_range);
> +		if (rc < 0) {
> +			dev_dbg(dev, "unconsumed DC extent DPA:0x%llx LEN:%llx\n",
> +					extent->dpa_start, extent->length);
> +			rc = cxl_prepare_ext_list(&dc_res, &extent_cnt, NULL);
> +			if (rc < 0) {
> +				dev_err(dev, "Couldn't create extent list %d\n",
> +									rc);
> +				devm_kfree(dev, extent);
> +				return rc;
> +			}
> +
> +			rc = cxl_send_dc_cap_response(mds, dc_res,
> +					extent_cnt, CXL_MBOX_OP_ADD_DC_RESPONSE);
> +			if (rc < 0) {
> +				devm_kfree(dev, extent);
> +				goto out;
> +			}
> +
> +			kfree(dc_res);
> +			devm_kfree(dev, extent);
> +
> +			return 0;
> +		}
> +
> +		rc = xa_insert(&mds->dc_extent_list, extent->dpa_start, extent,
> +				GFP_KERNEL);
> +		if (rc < 0)
> +			goto out;
> +
> +		mds->num_dc_extents++;
> +		rc = cxl_prepare_ext_list(&dc_res, &extent_cnt, &alloc_range);
> +		if (rc < 0) {
> +			dev_err(dev, "Couldn't create extent list %d\n", rc);
> +			return rc;
> +		}
> +
> +		rc = cxl_send_dc_cap_response(mds, dc_res, extent_cnt,
> +					      CXL_MBOX_OP_ADD_DC_RESPONSE);
> +		if (rc < 0)
> +			goto out;
> +
> +		break;

As mentioned by Iry already in one of his reply, I also think it is better to
have a helper function for add/release capacity cases, like
cxl_handle_add_dc_capacity and cxl_handle_release_dc_capacity.

> +
> +	case RELEASE_CAPACITY:
> +		dpa = le64_to_cpu(record->data.extent.start_dpa);
> +		size = le64_to_cpu(record->data.extent.length);
> +		dev_dbg(dev, "Release DC extents DPA:0x%llx LEN:%llx\n",
> +				dpa, size);
> +		extent = xa_load(&mds->dc_extent_list, dpa);
> +		if (!extent) {
> +			dev_err(dev, "No extent found with DPA:0x%llx\n", dpa);
> +			return -EINVAL;
> +		}
> +
> +		rel_range = (struct range) {
> +			.start = dpa,
> +			.end = dpa + size - 1,
> +		};
> +
> +		rc = cxl_release_dc_extent(mds, &rel_range);
> +		if (rc < 0) {
> +			dev_dbg(dev, "withhold DC extent DPA:0x%llx LEN:%llx\n",
> +									dpa, size);
> +			return 0;
> +		}
> +
> +		xa_erase(&mds->dc_extent_list, dpa);
> +		devm_kfree(dev, extent);
> +		mds->num_dc_extents--;
> +		rc = cxl_prepare_ext_list(&dc_res, &extent_cnt, &rel_range);
> +		if (rc < 0) {
> +			dev_err(dev, "Couldn't create extent list %d\n", rc);
> +			return rc;
> +		}
> +
> +		rc = cxl_send_dc_cap_response(mds, dc_res, extent_cnt,
> +					      CXL_MBOX_OP_RELEASE_DC);
> +		if (rc < 0)
> +			goto out;
> +
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +out:
> +	kfree(dc_res);
> +	return rc;
> +}
> +
>  static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>  				    enum cxl_event_log_type type)
>  {
> @@ -982,9 +1180,17 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>  		if (!nr_rec)
>  			break;
>  
> -		for (i = 0; i < nr_rec; i++)
> +		for (i = 0; i < nr_rec; i++) {
>  			cxl_event_trace_record(cxlmd, type,
>  					       &payload->records[i]);
format issue, we have some spaces here after tab.
> +			if (type == CXL_EVENT_TYPE_DCD) {
> +				rc = cxl_handle_dcd_event_records(mds,
> +						&payload->records[i]);
> +				if (rc)
> +					dev_err_ratelimited(dev,
> +						"dcd event failed: %d\n", rc);
> +			}
> +		}
>  
>  		if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
>  			trace_cxl_overflow(cxlmd, type, payload);
> @@ -1024,6 +1230,8 @@ void cxl_mem_get_event_records(struct cxl_memdev_state *mds, u32 status)
>  		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_WARN);
>  	if (status & CXLDEV_EVENT_STATUS_INFO)
>  		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_INFO);
> +	if (status & CXLDEV_EVENT_STATUS_DCD)
> +		cxl_mem_get_records_log(mds, CXL_EVENT_TYPE_DCD);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mem_get_event_records, CXL);
>  
> @@ -1244,6 +1452,140 @@ int cxl_dev_dynamic_capacity_identify(struct cxl_memdev_state *mds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_dev_dynamic_capacity_identify, CXL);
>  
> +int cxl_dev_get_dc_extent_cnt(struct cxl_memdev_state *mds,
> +			      unsigned int *extent_gen_num)
> +{
> +	struct device *dev = mds->cxlds.dev;
> +	struct cxl_mbox_dc_extents *dc_extents;
> +	struct cxl_mbox_get_dc_extent get_dc_extent;
> +	unsigned int total_extent_cnt;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	int rc;
> +
> +	/* Check GET_DC_EXTENT_LIST is supported by device */
> +	if (!test_bit(CXL_DCD_ENABLED_GET_EXTENT_LIST, mds->dcd_cmds)) {
> +		dev_dbg(dev, "unsupported cmd : get dyn cap extent list\n");
> +		return 0;
> +	}
> +
> +	dc_extents = kvmalloc(mds->payload_size, GFP_KERNEL);
> +	if (!dc_extents)
> +		return -ENOMEM;
> +
> +	get_dc_extent = (struct cxl_mbox_get_dc_extent) {
> +		.extent_cnt = 0,
> +		.start_extent_index = 0,
> +	};
> +
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_GET_DC_EXTENT_LIST,
> +		.payload_in = &get_dc_extent,
> +		.size_in = sizeof(get_dc_extent),
> +		.size_out = mds->payload_size,
> +		.payload_out = dc_extents,
> +		.min_out = 1,
> +	};
> +	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	if (rc < 0)
> +		goto out;
> +
> +	total_extent_cnt = le32_to_cpu(dc_extents->total_extent_cnt);
> +	*extent_gen_num = le32_to_cpu(dc_extents->extent_list_num);
> +	dev_dbg(dev, "Total extent count :%d Extent list Generation Num: %d\n",
> +			total_extent_cnt, *extent_gen_num);
> +out:
> +
> +	kvfree(dc_extents);
> +	if (rc < 0)
> +		return rc;
> +
> +	return total_extent_cnt;
> +
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_dev_get_dc_extent_cnt, CXL);
> +
> +int cxl_dev_get_dc_extents(struct cxl_memdev_state *mds,
> +			   unsigned int index, unsigned int cnt)
> +{
> +	/* See CXL 3.0 Table 125 dynamic capacity config  Output Payload */
> +	struct device *dev = mds->cxlds.dev;
> +	struct cxl_mbox_dc_extents *dc_extents;
> +	struct cxl_mbox_get_dc_extent get_dc_extent;
> +	unsigned int extent_gen_num, available_extents, total_extent_cnt;
> +	int rc;
> +	struct cxl_dc_extent_data *extent;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	struct range alloc_range;
> +
> +	/* Check GET_DC_EXTENT_LIST is supported by device */
> +	if (!test_bit(CXL_DCD_ENABLED_GET_EXTENT_LIST, mds->dcd_cmds)) {
> +		dev_dbg(dev, "unsupported cmd : get dyn cap extent list\n");
> +		return 0;
> +	}
> +
> +	dc_extents = kvmalloc(mds->payload_size, GFP_KERNEL);
> +	if (!dc_extents)
> +		return -ENOMEM;
> +	get_dc_extent = (struct cxl_mbox_get_dc_extent) {
> +		.extent_cnt = cnt,
> +		.start_extent_index = index,
> +	};
> +
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_GET_DC_EXTENT_LIST,
> +		.payload_in = &get_dc_extent,
> +		.size_in = sizeof(get_dc_extent),
> +		.size_out = mds->payload_size,
> +		.payload_out = dc_extents,
> +		.min_out = 1,
> +	};
> +	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
> +	if (rc < 0)
> +		goto out;
> +
> +	available_extents = le32_to_cpu(dc_extents->ret_extent_cnt);
> +	total_extent_cnt = le32_to_cpu(dc_extents->total_extent_cnt);
> +	extent_gen_num = le32_to_cpu(dc_extents->extent_list_num);
> +	dev_dbg(dev, "No Total extent count :%d Extent list Generation Num:%d\n",
> +			total_extent_cnt, extent_gen_num);
> +
> +
> +	for (int i = 0; i < available_extents ; i++) {
> +		extent = devm_kzalloc(dev, sizeof(*extent), GFP_KERNEL);
> +		if (!extent) {
> +			rc = -ENOMEM;
> +			goto out;
> +		}
> +		extent->dpa_start = le64_to_cpu(dc_extents->extent[i].start_dpa);
> +		extent->length = le64_to_cpu(dc_extents->extent[i].length);
> +		memcpy(extent->tag, dc_extents->extent[i].tag,
> +					sizeof(dc_extents->extent[i].tag));
> +		extent->shared_extent_seq =
> +				le16_to_cpu(dc_extents->extent[i].shared_extn_seq);
> +		dev_dbg(dev, "dynamic capacity extent[%d] DPA:0x%llx LEN:%llx\n",
> +				i, extent->dpa_start, extent->length);
> +
> +		alloc_range = (struct range){
> +			.start = extent->dpa_start,
> +			.end = extent->dpa_start + extent->length - 1,
> +		};
> +
> +		rc = cxl_add_dc_extent(mds, &alloc_range);
> +		if (rc < 0)
> +			goto out;
> +		rc = xa_insert(&mds->dc_extent_list, extent->dpa_start, extent,
> +				GFP_KERNEL);
> +	}
> +
> +out:
> +	kvfree(dc_extents);
> +	if (rc < 0)
> +		return rc;
> +
> +	return available_extents;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_dev_get_dc_extents, CXL);
> +
>  static int add_dpa_res(struct device *dev, struct resource *parent,
>  		       struct resource *res, resource_size_t start,
>  		       resource_size_t size, const char *type)
> @@ -1452,6 +1794,7 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
>  	mutex_init(&mds->event.log_lock);
>  	mds->cxlds.dev = dev;
>  	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
> +	xa_init(&mds->dc_extent_list);
>  
>  	return mds;
>  }
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 144232c8305e..ba45c1c3b0a9 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2022 Intel Corporation. All rights reserved. */
>  #include <linux/memregion.h>
> +#include <linux/interrupt.h>
>  #include <linux/genalloc.h>
>  #include <linux/device.h>
>  #include <linux/module.h>
> @@ -11,6 +12,8 @@
>  #include <cxlmem.h>
>  #include <cxl.h>
>  #include "core.h"
> +#include "../../dax/bus.h"
> +#include "../../dax/dax-private.h"
>  
>  /**
>   * DOC: cxl core region
> @@ -166,6 +169,38 @@ static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
>  	return 0;
>  }
>  
> +static int cxl_region_manage_dc(struct cxl_region *cxlr)
> +{
> +	struct cxl_region_params *p = &cxlr->params;
> +	unsigned int extent_gen_num;
> +	int i, rc;
> +
> +	/* Designed for Non Interleaving flow with the assumption one
> +	 * cxl_region will map the complete device DC region's DPA range
> +	 */
> +	for (i = 0; i < p->nr_targets; i++) {
> +		struct cxl_endpoint_decoder *cxled = p->targets[i];
> +		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +		struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +
> +		rc = cxl_dev_get_dc_extent_cnt(mds, &extent_gen_num);
> +		if (rc < 0)
> +			goto err;
> +		else if (rc > 1) {
> +			rc = cxl_dev_get_dc_extents(mds, rc, 0);
> +			if (rc < 0)
> +				goto err;
> +			mds->num_dc_extents = rc;
> +			mds->dc_extents_index = rc - 1;
> +		}
> +		mds->dc_list_gen_num = extent_gen_num;
> +		dev_dbg(mds->cxlds.dev, "No of preallocated extents :%d\n", rc);
> +	}
> +	return 0;
> +err:
> +	return rc;
> +}
> +
>  static int commit_decoder(struct cxl_decoder *cxld)
>  {
>  	struct cxl_switch_decoder *cxlsd = NULL;
> @@ -2865,11 +2900,14 @@ static int devm_cxl_add_dc_region(struct cxl_region *cxlr)
>  		return PTR_ERR(cxlr_dax);
>  
>  	cxlr_dc = kzalloc(sizeof(*cxlr_dc), GFP_KERNEL);
> -	if (!cxlr_dc) {
> -		rc = -ENOMEM;
> -		goto err;
> -	}
> +	if (!cxlr_dc)
> +		return -ENOMEM;
>  
> +	rc = request_module("dax_cxl");
> +	if (rc) {
> +		dev_err(dev, "failed to load dax-ctl module\n");
> +		goto load_err;
> +	}
>  	dev = &cxlr_dax->dev;
>  	rc = dev_set_name(dev, "dax_region%d", cxlr->id);
>  	if (rc)
> @@ -2891,10 +2929,24 @@ static int devm_cxl_add_dc_region(struct cxl_region *cxlr)
>  	xa_init(&cxlr_dc->dax_dev_list);
>  	cxlr->cxlr_dc = cxlr_dc;
>  	rc = devm_add_action_or_reset(&cxlr->dev, cxl_dc_region_release, cxlr);
> -	if (!rc)
> -		return 0;
> +	if (rc)
> +		goto err;
> +
> +	if (!dev->driver) {
> +		dev_err(dev, "%s Driver not attached\n", dev_name(dev));
> +		rc = -ENXIO;
> +		goto err;
> +	}
> +
> +	rc = cxl_region_manage_dc(cxlr);
> +	if (rc)
> +		goto err;
> +
> +	return 0;
> +
>  err:
>  	put_device(dev);
> +load_err:
>  	kfree(cxlr_dc);
>  	return rc;
>  }
> @@ -3076,6 +3128,156 @@ struct cxl_region *cxl_create_region(struct cxl_root_decoder *cxlrd,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_create_region, CXL);
>  
> +static int match_ep_decoder_by_range(struct device *dev, void *data)
> +{
> +	struct cxl_endpoint_decoder *cxled;
> +	struct range *dpa_range = data;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	if (!cxled->cxld.region)
> +		return 0;
> +
> +	if (cxled->dpa_res->start <= dpa_range->start &&
> +				cxled->dpa_res->end >= dpa_range->end)
> +		return 1;
> +
> +	return 0;
> +}
> +
> +int cxl_release_dc_extent(struct cxl_memdev_state *mds,
> +			  struct range *rel_range)
> +{
> +	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_dc_region *cxlr_dc;
> +	struct dax_region *dax_region;
> +	resource_size_t dpa_offset;
> +	struct cxl_region *cxlr;
> +	struct range hpa_range;
> +	struct dev_dax *dev_dax;
> +	resource_size_t hpa;
> +	struct device *dev;
> +	int ranges, rc = 0;
> +
> +	/*
> +	 * Find the cxl endpoind decoder with which has the extent dpa range and

s/endpoind/endpoint/

> +	 * get the cxl_region, dax_region refrences.
> +	 */
> +	dev = device_find_child(&cxlmd->endpoint->dev, rel_range,
> +				match_ep_decoder_by_range);
> +	if (!dev) {
> +		dev_err(mds->cxlds.dev, "%pr not mapped\n", rel_range);
> +		return PTR_ERR(dev);
> +	}
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	hpa_range = cxled->cxld.hpa_range;
> +	cxlr = cxled->cxld.region;
> +	cxlr_dc = cxlr->cxlr_dc;
> +
> +	/* DPA to HPA translation */
> +	if (cxled->cxld.interleave_ways == 1) {
> +		dpa_offset = rel_range->start - cxled->dpa_res->start;
> +		hpa = hpa_range.start + dpa_offset;
> +	} else {
> +		dev_err(mds->cxlds.dev, "Interleaving DC not supported\n");
> +		return -EINVAL;
> +	}
> +
> +	dev_dax = xa_load(&cxlr_dc->dax_dev_list, hpa);
> +	if (!dev_dax)
> +		return -EINVAL;
> +
> +	dax_region = dev_dax->region;
> +	ranges = dev_dax->nr_range;
> +
> +	while (ranges) {
> +		int i = ranges - 1;
> +		struct dax_mapping *mapping = dev_dax->ranges[i].mapping;
> +
> +		devm_release_action(dax_region->dev, unregister_dax_mapping,
> +								&mapping->dev);
> +		ranges--;
> +	}
> +
> +	dev_dbg(mds->cxlds.dev, "removing devdax device:%s\n",
> +						dev_name(&dev_dax->dev));
> +	devm_release_action(dax_region->dev, unregister_dev_dax,
> +							&dev_dax->dev);
> +	xa_erase(&cxlr_dc->dax_dev_list, hpa);
> +
> +	return rc;
> +}
> +
> +int cxl_add_dc_extent(struct cxl_memdev_state *mds, struct range *alloc_range)
> +{
> +	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_dax_region *cxlr_dax;
> +	struct cxl_dc_region *cxlr_dc;
> +	struct dax_region *dax_region;
> +	resource_size_t dpa_offset;
> +	struct dev_dax_data data;
> +	struct dev_dax *dev_dax;
> +	struct cxl_region *cxlr;
> +	struct range hpa_range;
> +	resource_size_t hpa;
> +	struct device *dev;
> +	int rc;
> +
> +	/*
> +	 * Find the cxl endpoind decoder with which has the extent dpa range and
> +	 * get the cxl_region, dax_region refrences.
> +	 */
> +	dev = device_find_child(&cxlmd->endpoint->dev, alloc_range,
> +				match_ep_decoder_by_range);
> +	if (!dev) {
> +		dev_err(mds->cxlds.dev, "%pr not mapped\n",	alloc_range);
> +		return PTR_ERR(dev);
> +	}
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	hpa_range = cxled->cxld.hpa_range;
> +	cxlr = cxled->cxld.region;
> +	cxlr_dc = cxlr->cxlr_dc;
> +	cxlr_dax = cxlr_dc->cxlr_dax;
> +	dax_region = dev_get_drvdata(&cxlr_dax->dev);
> +
> +	/* DPA to HPA translation */
> +	if (cxled->cxld.interleave_ways == 1) {
> +		dpa_offset = alloc_range->start - cxled->dpa_res->start;
> +		hpa = hpa_range.start + dpa_offset;
> +	} else {
> +		dev_err(mds->cxlds.dev, "Interleaving DC not supported\n");
> +		return -EINVAL;
> +	}
> +
> +	data = (struct dev_dax_data) {
> +		.dax_region = dax_region,
> +		.id = -1,
> +		.size = 0,
> +	};
> +
> +	dev_dax = devm_create_dev_dax(&data);
> +	if (IS_ERR(dev_dax))
> +		return PTR_ERR(dev_dax);
> +
> +	if (IS_ALIGNED(range_len(alloc_range), max_t(unsigned long,
> +				dev_dax->align, memremap_compat_align()))) {
> +		rc = alloc_dev_dax_range(dev_dax, hpa,
> +					range_len(alloc_range));
> +		if (rc)
> +			return rc;
> +	}
> +
> +	rc = xa_insert(&cxlr_dc->dax_dev_list, hpa, dev_dax, GFP_KERNEL);
> +
> +	return rc;
> +}
> +
>  /* Establish an empty region covering the given HPA range */
>  static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  					   struct cxl_endpoint_decoder *cxled)
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index a0b5819bc70b..e11651255780 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -122,7 +122,8 @@ TRACE_EVENT(cxl_aer_correctable_error,
>  		{ CXL_EVENT_TYPE_INFO, "Informational" },	\
>  		{ CXL_EVENT_TYPE_WARN, "Warning" },		\
>  		{ CXL_EVENT_TYPE_FAIL, "Failure" },		\
> -		{ CXL_EVENT_TYPE_FATAL, "Fatal" })
> +		{ CXL_EVENT_TYPE_FATAL, "Fatal" },		\
> +		{ CXL_EVENT_TYPE_DCD, "DCD" })
>  
>  TRACE_EVENT(cxl_overflow,
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 7ac1237938b7..60c436b7ebb1 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -163,11 +163,13 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>  #define CXLDEV_EVENT_STATUS_WARN		BIT(1)
>  #define CXLDEV_EVENT_STATUS_FAIL		BIT(2)
>  #define CXLDEV_EVENT_STATUS_FATAL		BIT(3)
> +#define CXLDEV_EVENT_STATUS_DCD			BIT(4)
>  
>  #define CXLDEV_EVENT_STATUS_ALL (CXLDEV_EVENT_STATUS_INFO |	\
>  				 CXLDEV_EVENT_STATUS_WARN |	\
>  				 CXLDEV_EVENT_STATUS_FAIL |	\
> -				 CXLDEV_EVENT_STATUS_FATAL)
> +				 CXLDEV_EVENT_STATUS_FATAL|	\
> +				 CXLDEV_EVENT_STATUS_DCD)
>  
>  /* CXL rev 3.0 section 8.2.9.2.4; Table 8-52 */
>  #define CXLDEV_EVENT_INT_MODE_MASK	GENMASK(1, 0)
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 9c0b2fa72bdd..0440b5c04ef6 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -5,6 +5,7 @@
>  #include <uapi/linux/cxl_mem.h>
>  #include <linux/cdev.h>
>  #include <linux/uuid.h>
> +#include <linux/xarray.h>
>  #include "cxl.h"
>  
>  /* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
> @@ -226,6 +227,7 @@ struct cxl_event_interrupt_policy {
>  	u8 warn_settings;
>  	u8 failure_settings;
>  	u8 fatal_settings;
> +	u8 dyncap_settings;
>  } __packed;
>  
>  /**
> @@ -296,6 +298,13 @@ enum cxl_devtype {
>  #define CXL_MAX_DC_REGION 8
>  #define CXL_DC_REGION_SRTLEN 8
>  
> +struct cxl_dc_extent_data {
> +	u64 dpa_start;
> +	u64 length;
> +	u8 tag[16];
> +	u16 shared_extent_seq;
> +};
> +
>  /**
>   * struct cxl_dev_state - The driver device state
>   *
> @@ -406,6 +415,11 @@ struct cxl_memdev_state {
>  		u8 flags;
>  	} dc_region[CXL_MAX_DC_REGION];
>  
> +	u32 dc_list_gen_num;
> +	u32 dc_extents_index;
> +	struct xarray dc_extent_list;
> +	u32 num_dc_extents;
> +
>  	size_t dc_event_log_size;
>  	struct cxl_event_state event;
>  	struct cxl_poison_state poison;
> @@ -470,6 +484,17 @@ enum cxl_opcode {
>  	UUID_INIT(0xe1819d9, 0x11a9, 0x400c, 0x81, 0x1f, 0xd6, 0x07, 0x19,     \
>  		  0x40, 0x3d, 0x86)
>  
> +
> +struct cxl_mbox_dc_response {
> +	__le32 extent_list_size;
> +	u8 reserved[4];
> +	struct updated_extent_list {
> +		__le64 dpa_start;
> +		__le64 length;
> +		u8 reserved[8];
> +	} __packed extent_list[];
> +} __packed;
> +
>  struct cxl_mbox_get_supported_logs {
>  	__le16 entries;
>  	u8 rsvd[6];
> @@ -555,6 +580,7 @@ enum cxl_event_log_type {
>  	CXL_EVENT_TYPE_WARN,
>  	CXL_EVENT_TYPE_FAIL,
>  	CXL_EVENT_TYPE_FATAL,
> +	CXL_EVENT_TYPE_DCD,
>  	CXL_EVENT_TYPE_MAX
>  };
>  
> @@ -639,6 +665,35 @@ struct cxl_event_mem_module {
>  	u8 reserved[0x3d];
>  } __packed;
>  
> +/*
> + * Dynamic Capacity Event Record
> + * CXL rev 3.0 section 8.2.9.2.1.5; Table 8-47
> + */
> +
> +#define CXL_EVENT_DC_TAG_SIZE	0x10
> +struct cxl_dc_extent {
> +	__le64 start_dpa;
> +	__le64 length;
> +	u8 tag[CXL_EVENT_DC_TAG_SIZE];
> +	__le16 shared_extn_seq;
> +	u8 reserved[6];
> +} __packed;
> +
> +struct dcd_record_data {
> +	u8 event_type;
> +	u8 reserved;
> +	__le16 host_id;
> +	u8 region_index;
> +	u8 reserved1[3];
> +	struct cxl_dc_extent extent;
> +	u8 reserved2[32];
> +} __packed;
> +
> +struct dcd_event_dyn_cap {
> +	struct cxl_event_record_hdr hdr;
> +	struct dcd_record_data data;
> +} __packed;
> +
>  struct cxl_mbox_get_partition_info {
>  	__le64 active_volatile_cap;
>  	__le64 active_persistent_cap;
> @@ -684,6 +739,19 @@ struct cxl_mbox_dynamic_capacity {
>  #define  CXL_SET_PARTITION_IMMEDIATE_FLAG	BIT(0)
>  #define CXL_DYNAMIC_CAPACITY_SANITIZE_ON_RELEASE_FLAG BIT(0)
>  
> +struct cxl_mbox_get_dc_extent {
> +	__le32 extent_cnt;
> +	__le32 start_extent_index;
> +} __packed;
> +
> +struct cxl_mbox_dc_extents {
> +	__le32 ret_extent_cnt;
> +	__le32 total_extent_cnt;
> +	__le32 extent_list_num;
> +	u8 rsvd[4];
> +	struct cxl_dc_extent extent[];
> +}  __packed;
> +
>  /* Set Timestamp CXL 3.0 Spec 8.2.9.4.2 */
>  struct cxl_mbox_set_timestamp_in {
>  	__le64 timestamp;
> @@ -826,6 +894,14 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
>  int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
>  int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
>  
> +/* FIXME why not have these be static in mbox.c? */
> +int cxl_add_dc_extent(struct cxl_memdev_state *mds, struct range *alloc_range);
> +int cxl_release_dc_extent(struct cxl_memdev_state *mds, struct range *rel_range);
> +int cxl_dev_get_dc_extent_cnt(struct cxl_memdev_state *mds,
> +			      unsigned int *extent_gen_num);
> +int cxl_dev_get_dc_extents(struct cxl_memdev_state *mds, unsigned int cnt,
> +			   unsigned int index);
> +
>  #ifdef CONFIG_CXL_SUSPEND
>  void cxl_mem_active_inc(void);
>  void cxl_mem_active_dec(void);
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index ac1a41bc083d..558ffbcb9b34 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -522,8 +522,8 @@ static int cxl_event_req_irq(struct cxl_dev_state *cxlds, u8 setting)
>  		return irq;
>  
>  	return devm_request_threaded_irq(dev, irq, NULL, cxl_event_thread,
> -					 IRQF_SHARED | IRQF_ONESHOT, NULL,
> -					 dev_id);
> +					IRQF_SHARED | IRQF_ONESHOT, NULL,
> +					dev_id);
>  }
>  
>  static int cxl_event_get_int_policy(struct cxl_memdev_state *mds,
> @@ -555,6 +555,7 @@ static int cxl_event_config_msgnums(struct cxl_memdev_state *mds,
>  		.warn_settings = CXL_INT_MSI_MSIX,
>  		.failure_settings = CXL_INT_MSI_MSIX,
>  		.fatal_settings = CXL_INT_MSI_MSIX,
> +		.dyncap_settings = CXL_INT_MSI_MSIX,
>  	};
>  
>  	mbox_cmd = (struct cxl_mbox_cmd) {
> @@ -608,6 +609,11 @@ static int cxl_event_irqsetup(struct cxl_memdev_state *mds)
>  		return rc;
>  	}
>  
> +	rc = cxl_event_req_irq(cxlds, policy.dyncap_settings);
> +	if (rc) {
> +		dev_err(cxlds->dev, "Failed to get interrupt for event dc log\n");
> +		return rc;
> +	}
>  	return 0;
>  }
>  
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index 227800053309..b2b27033f589 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -434,7 +434,7 @@ static void free_dev_dax_ranges(struct dev_dax *dev_dax)
>  		trim_dev_dax_range(dev_dax);
>  }
>  
> -static void unregister_dev_dax(void *dev)
> +void unregister_dev_dax(void *dev)
>  {
>  	struct dev_dax *dev_dax = to_dev_dax(dev);
>  
> @@ -445,6 +445,7 @@ static void unregister_dev_dax(void *dev)
>  	free_dev_dax_ranges(dev_dax);
>  	put_device(dev);
>  }
> +EXPORT_SYMBOL_GPL(unregister_dev_dax);
>  
>  /* a return value >= 0 indicates this invocation invalidated the id */
>  static int __free_dev_dax_id(struct dev_dax *dev_dax)
> @@ -641,7 +642,7 @@ static void dax_mapping_release(struct device *dev)
>  	kfree(mapping);
>  }
>  
> -static void unregister_dax_mapping(void *data)
> +void unregister_dax_mapping(void *data)
>  {
>  	struct device *dev = data;
>  	struct dax_mapping *mapping = to_dax_mapping(dev);
> @@ -658,7 +659,7 @@ static void unregister_dax_mapping(void *data)
>  	device_del(dev);
>  	put_device(dev);
>  }
> -
> +EXPORT_SYMBOL_GPL(unregister_dax_mapping);
>  static struct dev_dax_range *get_dax_range(struct device *dev)
>  {
>  	struct dax_mapping *mapping = to_dax_mapping(dev);
> @@ -793,7 +794,7 @@ static int devm_register_dax_mapping(struct dev_dax *dev_dax, int range_id)
>  	return 0;
>  }
>  
> -static int alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
> +int alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
>  		resource_size_t size)
>  {
>  	struct dax_region *dax_region = dev_dax->region;
> @@ -853,6 +854,8 @@ static int alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
>  
>  	return rc;
>  }
> +EXPORT_SYMBOL_GPL(alloc_dev_dax_range);
> +
>  
>  static int adjust_dev_dax_range(struct dev_dax *dev_dax, struct resource *res, resource_size_t size)
>  {
> diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
> index 8cd79ab34292..aa8418c7aead 100644
> --- a/drivers/dax/bus.h
> +++ b/drivers/dax/bus.h
> @@ -47,8 +47,11 @@ int __dax_driver_register(struct dax_device_driver *dax_drv,
>  	__dax_driver_register(driver, THIS_MODULE, KBUILD_MODNAME)
>  void dax_driver_unregister(struct dax_device_driver *dax_drv);
>  void kill_dev_dax(struct dev_dax *dev_dax);
> +void unregister_dev_dax(void *dev);
> +void unregister_dax_mapping(void *data);
>  bool static_dev_dax(struct dev_dax *dev_dax);
> -
> +int alloc_dev_dax_range(struct dev_dax *dev_dax, u64 start,
> +					resource_size_t size);
>  /*
>   * While run_dax() is potentially a generic operation that could be
>   * defined in include/linux/dax.h we don't want to grow any users
> 
> -- 
> 2.40.0
> 

-- 
Fan Ni <nifan@outlook.com>
