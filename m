Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5798EB64D7
	for <linux-cxl@archiver.kernel.org>; Wed, 21 Jun 2023 17:21:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjFURVN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 21 Jun 2023 13:21:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjFURVM (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 21 Jun 2023 13:21:12 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01olkn2105.outbound.protection.outlook.com [40.92.53.105])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B8019A3
        for <linux-cxl@vger.kernel.org>; Wed, 21 Jun 2023 10:21:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RLc/Ug8Fc3WZ7SVM3PEEX0li+UDUBOUAMdAkkWVuCJlAad/Su44EAAkT7FO7meZmvFEz0aSlYjr3VHm5ja8FzYoQ3ATyWGuycw7TnOCMKv7jURJ73JqtZBWzKAgFIDHAHmdpj1wx3ezZ1f74Rzcstnvk/NqOmM2miwcDIahMRDAC1LIDbSESmqMcCrPWhtHPrHhaECMWAYqoGACUHLXGYXXhtWsG+FvinLCc6N2YAXxhse2vO6truC55mR5D8DU/RgyPrnL0ZbmMOnp64BPmqA4j4V2WL4uvrX7C3BpkXzt5FiCrSiX93F5Ct6T+HXgTn5oADG4KsOLjs1Ec3j4cFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jewEDE+R4u9DZab16BaXzaFAda4PfIRFpQWSmTOcYs=;
 b=LIoyI+wvZJr9aobJo/JMdCib7xXJXHlLot8WacUlKNywf8mmpJDBnVd6+ciaiZwGTwWBaSpRFccuGYJN3SzULmL0zDgupHbtyJoizhhW3Xj+9eVRXRLHCcunlgbCfieB9odUriP4riaL+tXpFDQhQwGQ2Mg1/j0X1bXIDmi8Lg9E5+LMIUl9QKqsTXlyaPEh9U+GDzfQXMP2h8KjaHeVDY4NIiDVqTUgo1kWetLg0ND0JvjzenMA/P+HK7OrjLbyNpoGFxItsgnWD43rv0bbhmCcRwS9IwKbkyrrlzsKEJ5IldmEaph0kp9gaJtZq8Roq2moeKS4Js3X4p6WUHupbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jewEDE+R4u9DZab16BaXzaFAda4PfIRFpQWSmTOcYs=;
 b=lRey3fh1g8iZiZDAYw8j8/10dLeMZoJm8Yd2peHrxV9JQJL0HyHLeaOmNUmz0mNTHCN6oErjPz9YTAReDao5M+AHTCl6rUxjuLdxySs50MrCgvNC8Hqi9N8X5CXgIxo18i7yrZ9ju18esHvKKj9QeUB6dxwkEk1i8m2/8HMTUvoiaM+GNtbl1pCtfYTNNOLAmiVDglJiegoxuF//L787Tg3u0Z9tsOFIearavLv1iOILwb1mzeYCQYyXwP9wXSQk+FGMwPiuHP19SelU93Ixn2hu0aSeFq44Y0k3Uz3O2HDC7VJGqDAuYSlymyQHK5s/E5pOsgx7QueunuoSllp+kg==
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com (2603:1096:4:7a::17) by
 SEZPR06MB5344.apcprd06.prod.outlook.com (2603:1096:101:64::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6521.23; Wed, 21 Jun 2023 17:21:04 +0000
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::33a7:c9e1:75ae:3227]) by SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::33a7:c9e1:75ae:3227%4]) with mapi id 15.20.6521.023; Wed, 21 Jun 2023
 17:21:03 +0000
Date:   Wed, 21 Jun 2023 10:20:44 -0700
From:   Fan Ni <nifan@outlook.com>
To:     ira.weiny@intel.com
Cc:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org, a.manzanares@samsung.com,
        dave@stgolabs.net, nmtadam.samsung@gmail.com, nifan@outlook.com
Subject: Re: [PATCH 2/5] cxl/region: Add dynamic capacity cxl region support.
Message-ID: <SG2PR06MB3397C7844B305A9C1C0C2F0AB25DA@SG2PR06MB3397.apcprd06.prod.outlook.com>
References: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
 <20230604-dcd-type2-upstream-v1-2-71b6341bae54@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230604-dcd-type2-upstream-v1-2-71b6341bae54@intel.com>
X-TMN:  [+83lxyspSZ43ZMqOOLxgv1n0MqzCILDA]
X-ClientProxiedBy: SJ0PR03CA0095.namprd03.prod.outlook.com
 (2603:10b6:a03:333::10) To SG2PR06MB3397.apcprd06.prod.outlook.com
 (2603:1096:4:7a::17)
X-Microsoft-Original-Message-ID: <ZJMxbKdyzLIY3Ibe@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3397:EE_|SEZPR06MB5344:EE_
X-MS-Office365-Filtering-Correlation-Id: 52e97d8e-bed0-4e8e-08a4-08db727be3c1
X-MS-Exchange-SLBlob-MailProps: Cq7lScuPrnqnx/C+6DC/TBAp5lwBo949zkPn87KXjOfjete7cB7HC42QE0xy63Sie/5Cb+2x5cTdc+Mh+mjWU+4brj5GFrOHGVu54SuXDlknEWEMHUbnRpiUNqaGXArLbcTPA/lRAQj6XJybrpYKy3StaKG5363tNCq6+wV7fpZnYsiXBhxmZqKjgy9lX59Q5i8ApoenPR/OHEeTUfUA72ppeLJaHZP4w8oCLHEqUccFLwZuv4GJMvZfYBdaZVdGY5bvga6eigv8Rtbj7/nGLS54Z2u4i70fo+jF9NiLfNC62okpJXoKEJSsGt5L5aOxy321+FB2MrDBmEqw6Op8/zBpr6WrZy6BEuAPcKFJYL9JB3dNazSzvKTKruCtNo3DsFBMDGlvgbycR2AaKuFPHI5PbbpvugQjWOXDKSDUGbLhrd7GF9nPE6AlN4rj2a/Y0OF2ewN9yeRzCP7ylPMokfvExs78kSmRPH6tFwL7DkgdJ7/1cl5lL4cnd1OAzFdn3BqwdINP1TIq9mDacmwCzViwDNRdwhQZUeD7CPicT1AlyOSyWDim/dfTglPGr1FI4XMaVnC4rWjl259ShePuvD/QIiccwZdbkkJPMekoDdSxY4TdTazz/ik4MYJ7bY9xWkB86ibpjipXS2WZY9/45uVF8cxmcSrX2peEStqWvlEUh6SZ3vQIYAwgQNdkYawLLYYhzq43Cb6jzN4krzZEUnbgwD1aoZqz0ZcoQLgU3Wrr7ZQUhBjoc7YlmW4sJeOnG6WPVXyDtls=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LuuYZExX2aMVatVVEIK4fMusk3I6TO7r276KlOwBEcHGFEY6w0+8HWMStl6B58hV0RrVVZKmMUkRdszfLFOaLnmd/Rk7TgpImcmpQ913sQvmHeszx8njXetdSgC85twSAOODS/lHORGfzNeUVth5yGBH+mZo/bq+2eNncDwPnvoVX+daL0dRTrS6+CQT0Jjt3IaLKA25WRcRX2zTfAQMpxU0Euu1KB+y2oyop81izffrhVDPLNo69a6oKoYS+hsysVpTdtCIl1FSQM7d4vw0auQVnlisuNqKdzFTafbrkv+nWcdBVWk/IifmBimjHTCIVk9vLIapUJfZyOypTpYKMpKAEbAyapq7v4AuHPkjXHt8P7NitYOrmnLdCo1qNk9xviMSVhkarq9hoA6B/ylV+SL/QB5H87HNDTUPP0LtH3XaMGfNM/HPmLE3pUnbt3Zhwnp7yl5CQK+tY9B9Lb2KBV8agLV8KD1BYQigv0LnUIdQMllfMzqoxEW9ZrBOZbxiis7b5MWSO0aSaIQeJipKLzWujHiGH5ducGVChUKf00r4OgnbfDofxqonsiv+eB6hjO+0PRK125hh2yP0h3WDDgyWlhRYlAuMNs50n6/IS5pP6BKcCYxsHoiQJME8ResrBpAD2Cx9IsSZpIHQtn8cWw==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QmR5TmNyL3FkOHVDbFkzU1h2eStPTFBHc1AxRUo0b1RodkJib3NqVFFPZDJB?=
 =?utf-8?B?aG1NNmE0N1BGbmpCZ2JXYkh2ODhUbENrUEloN0l6UFhsSHVJRHFvSWRlbWFx?=
 =?utf-8?B?TFFGNEpkMUllczdxQ3V1SVM5Qi9RSHB5eG5Tc2lNRXhrMUs5eWZoR0hzYzl6?=
 =?utf-8?B?d1Z2OXVLbTMrTk9QclBwSGVPMlR3VmJoL0VFYkNWOXpsWkZBb2g2UlVnTUhw?=
 =?utf-8?B?eUh0TkJjbFl4eUJuZFdIVkJPSXB6ZllmQnp6enNnOTBhSHNtU29sVXpYZXNh?=
 =?utf-8?B?dUVUbEtFS084K3pkV3VPc1BTMTdBUWd6T2RGZU90T0pyNE9vSjM3R3EyS2gx?=
 =?utf-8?B?TkN3R2FrYU9UVXNpNFgrbE5DZExHK1ZQblIvdHh6VnBvMkNBVml0Z3lIN0lF?=
 =?utf-8?B?UTZaQ3JJL3VTRWpoWjJPMGg2eE9YdXc1dUsrZEsrbTZ1V3NySkFEbVN3RW1o?=
 =?utf-8?B?UjAxU1grSUpNYjNjQnBEdHU0TG9HV1Q4b0JVNXVyZW5wNXQ5SkhYY25uOXY5?=
 =?utf-8?B?dVlydUxUeUhNcWExSTJaT0RoeWNFbWdocUxCVkp5dXUwTjNtU0R0NU1MTjBZ?=
 =?utf-8?B?MFR5clppQU50enpRajRJUVBGZ3lQd3RCc2NvTkRCMEptTWxJTU1Fc0VQOVdX?=
 =?utf-8?B?YmsrOXpOcjg2akdPM0FlckxGclhFa0VSM0MyYW9yOUM2VDZGd0NQOEtRQ2tD?=
 =?utf-8?B?eENRb0JDVEFxaXZCR2RsS2tWck1UYlY3MkIvcE9rVG02bThJc2NlT0FGa3B0?=
 =?utf-8?B?YTdhUG1LMlpwVWFpTEE2ZXB5MHZrOVVINW56QjBHLzJQRVpaNGtqUHRZRG5F?=
 =?utf-8?B?N2JHRC9YQ0lpRDBkTTlyM0hFNkxKYmN3QkpvTi9nMFBTTjU4S1Q5Z0xPTVBB?=
 =?utf-8?B?RjRkNnRoa3Z0YnhyS25FaHZZV2daRFJNbHN0c0c0cHYrODVMUklsMmJhbm5C?=
 =?utf-8?B?UDZyT1oxbjdFS1FOUkdHQXhTckl3RUZmblJibjBkVGhiVjUvQzJ5TTlUWnNM?=
 =?utf-8?B?M2tOUlhSa3RzSy81L2xEY3VaVk5jV25TdCtRR2ZreXFtTU1LVXk2dGpONGxT?=
 =?utf-8?B?NXFBaDlWaHdMVVhXemdFNU5vTXZtN3lKMmp1NXZkNXVMVURQcGx6UTNjU0Jv?=
 =?utf-8?B?Y2ppbXJoQ1ZvOGRpZHQ5cFNjem1jazh1TGs1eFJFcldLTkdVZnBXYmM2NGVK?=
 =?utf-8?B?ajZDOGVnR1FOTUVCWkNjci9TeDZHZWlwQzVvVUlxVmEwd2w1NDRINUhrZnpk?=
 =?utf-8?B?TkJQbWxHazZrQy8xMHFtN3d3WElDc0RmdGRJT1dHZ2FTVjBKU2tKdGMzRGlw?=
 =?utf-8?B?NTU2bDc3QnE3cTc1dUdhVXpTWVJqTzRLSXM2eFQ2aWZOUGlaeFZqY1ZPMzdZ?=
 =?utf-8?B?eUNXdGVtNnJGWDBNSUlwOExJa2hUUnpjNndoYjZRS0h1Q2RWTjUwK3BUay81?=
 =?utf-8?B?ZXJCL3ZYb2IybGpnbHFUb1RtUUl4WXBHZjB3eXlHRGlhYmhPcXpJMmZsZ29U?=
 =?utf-8?B?cWRZSzNUblFoYWhaQm5VVVE5eWU0K3V6Z3BMSVhmOEovTlVXRnZKRG53bHFR?=
 =?utf-8?B?WDdKc3hTMElhclJ2YnZUenk1V3lPSjNqSUp6YmE2eFZIUndmeUJTT0k1Wk9p?=
 =?utf-8?B?eWdsK081UlZzOUQ5NUc4MVN5K081aGc9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52e97d8e-bed0-4e8e-08a4-08db727be3c1
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3397.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 17:21:03.9681
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5344
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The 06/14/2023 12:16, ira.weiny@intel.com wrote:
> From: Navneet Singh <navneet.singh@intel.com>
> 
> CXL devices optionally support dynamic capacity. CXL Regions must be
> created to access this capacity.
> 
> Add sysfs entries to create dynamic capacity cxl regions. Provide a new
> Dynamic Capacity decoder mode which targets dynamic capacity on devices
> which are added to that region.
> 
> Below are the steps to create and delete dynamic capacity region0
> (example).
> 
>     region=$(cat /sys/bus/cxl/devices/decoder0.0/create_dc_region)
>     echo $region> /sys/bus/cxl/devices/decoder0.0/create_dc_region
>     echo 256 > /sys/bus/cxl/devices/$region/interleave_granularity
>     echo 1 > /sys/bus/cxl/devices/$region/interleave_ways
> 
>     echo "dc0" >/sys/bus/cxl/devices/decoder1.0/mode
>     echo 0x400000000 >/sys/bus/cxl/devices/decoder1.0/dpa_size
> 
>     echo 0x400000000 > /sys/bus/cxl/devices/$region/size
>     echo  "decoder1.0" > /sys/bus/cxl/devices/$region/target0
>     echo 1 > /sys/bus/cxl/devices/$region/commit
>     echo $region > /sys/bus/cxl/drivers/cxl_region/bind
> 
>     echo $region> /sys/bus/cxl/devices/decoder0.0/delete_region
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> 
> ---
> [iweiny: fixups]
> [iweiny: remove unused CXL_DC_REGION_MODE macro]
> [iweiny: Make dc_mode_to_region_index static]
> [iweiny: simplify <sysfs>/create_dc_region]
> [iweiny: introduce decoder_mode_is_dc]
> [djbw: fixups, no sign-off: preview only]
> ---
>  drivers/cxl/Kconfig       |  11 +++
>  drivers/cxl/core/core.h   |   7 ++
>  drivers/cxl/core/hdm.c    | 234 ++++++++++++++++++++++++++++++++++++++++++----
>  drivers/cxl/core/port.c   |  18 ++++
>  drivers/cxl/core/region.c | 135 ++++++++++++++++++++++++--
>  drivers/cxl/cxl.h         |  28 ++++++
>  drivers/dax/cxl.c         |   4 +
>  7 files changed, 409 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index ff4e78117b31..df034889d053 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -121,6 +121,17 @@ config CXL_REGION
>  
>  	  If unsure say 'y'
>  
> +config CXL_DCD
> +	bool "CXL: DCD Support"
> +	default CXL_BUS
> +	depends on CXL_REGION
> +	help
> +	  Enable the CXL core to provision CXL DCD regions.
> +	  CXL devices optionally support dynamic capacity and DCD region
> +	  maps the dynamic capacity regions DPA's into Host HPA ranges.
> +
> +	  If unsure say 'y'
> +
>  config CXL_REGION_INVALIDATION_TEST
>  	bool "CXL: Region Cache Management Bypass (TEST)"
>  	depends on CXL_REGION
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 27f0968449de..725700ab5973 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -9,6 +9,13 @@ extern const struct device_type cxl_nvdimm_type;
>  
>  extern struct attribute_group cxl_base_attribute_group;
>  
> +#ifdef CONFIG_CXL_DCD
> +extern struct device_attribute dev_attr_create_dc_region;
> +#define SET_CXL_DC_REGION_ATTR(x) (&dev_attr_##x.attr),
> +#else
> +#define SET_CXL_DC_REGION_ATTR(x)
> +#endif
> +
>  #ifdef CONFIG_CXL_REGION
>  extern struct device_attribute dev_attr_create_pmem_region;
>  extern struct device_attribute dev_attr_create_ram_region;
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 514d30131d92..29649b47d177 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -233,14 +233,23 @@ static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct resource *res = cxled->dpa_res;
>  	resource_size_t skip_start;
> +	resource_size_t skipped = cxled->skip;
>  
>  	lockdep_assert_held_write(&cxl_dpa_rwsem);
>  
>  	/* save @skip_start, before @res is released */
> -	skip_start = res->start - cxled->skip;
> +	skip_start = res->start - skipped;
>  	__release_region(&cxlds->dpa_res, res->start, resource_size(res));
> -	if (cxled->skip)
> -		__release_region(&cxlds->dpa_res, skip_start, cxled->skip);
> +	if (cxled->skip != 0) {
> +		while (skipped != 0) {
> +			res = xa_load(&cxled->skip_res, skip_start);
> +			__release_region(&cxlds->dpa_res, skip_start,
> +							resource_size(res));
> +			xa_erase(&cxled->skip_res, skip_start);
> +			skip_start += resource_size(res);
> +			skipped -= resource_size(res);
> +			}
> +	}
>  	cxled->skip = 0;
>  	cxled->dpa_res = NULL;
>  	put_device(&cxled->cxld.dev);
> @@ -267,6 +276,19 @@ static void devm_cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
>  	__cxl_dpa_release(cxled);
>  }
>  
> +static int dc_mode_to_region_index(enum cxl_decoder_mode mode)
> +{
> +	int index = 0;
> +
> +	for (int i = CXL_DECODER_DC0; i <= CXL_DECODER_DC7; i++) {
> +		if (mode == i)
> +			return index;
> +		index++;
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  			     resource_size_t base, resource_size_t len,
>  			     resource_size_t skipped)
> @@ -275,7 +297,11 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  	struct cxl_port *port = cxled_to_port(cxled);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct device *dev = &port->dev;
> +	struct device *ed_dev = &cxled->cxld.dev;
> +	struct resource *dpa_res = &cxlds->dpa_res;
> +	resource_size_t skip_len = 0;
>  	struct resource *res;
> +	int rc, index;
>  
>  	lockdep_assert_held_write(&cxl_dpa_rwsem);
>  
> @@ -304,28 +330,119 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  	}
>  
>  	if (skipped) {
> -		res = __request_region(&cxlds->dpa_res, base - skipped, skipped,
> -				       dev_name(&cxled->cxld.dev), 0);
> -		if (!res) {
> -			dev_dbg(dev,
> -				"decoder%d.%d: failed to reserve skipped space\n",
> -				port->id, cxled->cxld.id);
> -			return -EBUSY;
> +		resource_size_t skip_base = base - skipped;
> +
> +		if (decoder_mode_is_dc(cxled->mode)) {
> +			if (resource_size(&cxlds->ram_res) &&
> +					skip_base <= cxlds->ram_res.end) {
> +				skip_len = cxlds->ram_res.end - skip_base + 1;
> +				res = __request_region(dpa_res, skip_base,
> +						skip_len, dev_name(ed_dev), 0);
> +				if (!res)
> +					goto error;
> +
> +				rc = xa_insert(&cxled->skip_res, skip_base, res,
> +								GFP_KERNEL);
> +				skip_base += skip_len;
> +			}
> +
> +			if (resource_size(&cxlds->ram_res) &&
> +					skip_base <= cxlds->pmem_res.end) {
> +				skip_len = cxlds->pmem_res.end - skip_base + 1;
> +				res = __request_region(dpa_res, skip_base,
> +						skip_len, dev_name(ed_dev), 0);
> +				if (!res)
> +					goto error;
> +
> +				rc = xa_insert(&cxled->skip_res, skip_base, res,
> +								GFP_KERNEL);
> +				skip_base += skip_len;
> +			}
> +
> +			index = dc_mode_to_region_index(cxled->mode);
> +			for (int i = 0; i <= index; i++) {
> +				struct resource *dcr = &cxlds->dc_res[i];
> +
> +				if (skip_base < dcr->start) {
> +					skip_len = dcr->start - skip_base;
> +					res = __request_region(dpa_res,
> +							skip_base, skip_len,
> +							dev_name(ed_dev), 0);
> +					if (!res)
> +						goto error;
> +
> +					rc = xa_insert(&cxled->skip_res, skip_base,
> +							res, GFP_KERNEL);
> +					skip_base += skip_len;
> +				}
> +
> +				if (skip_base == base) {
> +					dev_dbg(dev, "skip done!\n");
> +					break;
> +				}
> +
> +				if (resource_size(dcr) &&
> +						skip_base <= dcr->end) {
> +					if (skip_base > base)
> +						dev_err(dev, "Skip error\n");
> +
> +					skip_len = dcr->end - skip_base + 1;
> +					res = __request_region(dpa_res, skip_base,
> +							skip_len,
> +							dev_name(ed_dev), 0);
> +					if (!res)
> +						goto error;
> +
> +					rc = xa_insert(&cxled->skip_res, skip_base,
> +							res, GFP_KERNEL);
> +					skip_base += skip_len;
> +				}
> +			}
> +		} else	{
> +			res = __request_region(dpa_res, base - skipped, skipped,
> +							dev_name(ed_dev), 0);
> +			if (!res)
> +				goto error;
> +
> +			rc = xa_insert(&cxled->skip_res, skip_base, res,
> +								GFP_KERNEL);
>  		}
>  	}
> -	res = __request_region(&cxlds->dpa_res, base, len,
> -			       dev_name(&cxled->cxld.dev), 0);
> +
> +	res = __request_region(dpa_res, base, len, dev_name(ed_dev), 0);
>  	if (!res) {
>  		dev_dbg(dev, "decoder%d.%d: failed to reserve allocation\n",
> -			port->id, cxled->cxld.id);
> -		if (skipped)
> -			__release_region(&cxlds->dpa_res, base - skipped,
> -					 skipped);
> +				port->id, cxled->cxld.id);
> +		if (skipped) {
> +			resource_size_t skip_base = base - skipped;
> +
> +			while (skipped != 0) {
> +				if (skip_base > base)
> +					dev_err(dev, "Skip error\n");
> +
> +				res = xa_load(&cxled->skip_res, skip_base);
> +				__release_region(dpa_res, skip_base,
> +							resource_size(res));
> +				xa_erase(&cxled->skip_res, skip_base);
> +				skip_base += resource_size(res);
> +				skipped -= resource_size(res);
> +			}
> +		}
>  		return -EBUSY;
>  	}
>  	cxled->dpa_res = res;
>  	cxled->skip = skipped;
>  
> +	for (int mode = CXL_DECODER_DC0; mode <= CXL_DECODER_DC7; mode++) {
> +		int index = dc_mode_to_region_index(mode);
> +
> +		if (resource_contains(&cxlds->dc_res[index], res)) {
> +			cxled->mode = mode;
> +			dev_dbg(dev, "decoder%d.%d: %pr mode: %d\n", port->id,
> +				cxled->cxld.id, cxled->dpa_res, cxled->mode);
> +			goto success;
> +		}
> +	}
>  	if (resource_contains(&cxlds->pmem_res, res))
>  		cxled->mode = CXL_DECODER_PMEM;
>  	else if (resource_contains(&cxlds->ram_res, res))
> @@ -336,9 +453,16 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  		cxled->mode = CXL_DECODER_MIXED;
>  	}
>  
> +success:
>  	port->hdm_end++;
>  	get_device(&cxled->cxld.dev);
>  	return 0;
> +
> +error:
> +	dev_dbg(dev, "decoder%d.%d: failed to reserve skipped space\n",
> +			port->id, cxled->cxld.id);
> +	return -EBUSY;
> +
>  }
>  
>  int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
> @@ -429,6 +553,14 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
>  	switch (mode) {
>  	case CXL_DECODER_RAM:
>  	case CXL_DECODER_PMEM:
> +	case CXL_DECODER_DC0:
> +	case CXL_DECODER_DC1:
> +	case CXL_DECODER_DC2:
> +	case CXL_DECODER_DC3:
> +	case CXL_DECODER_DC4:
> +	case CXL_DECODER_DC5:
> +	case CXL_DECODER_DC6:
> +	case CXL_DECODER_DC7:
>  		break;
>  	default:
>  		dev_dbg(dev, "unsupported mode: %d\n", mode);
> @@ -456,6 +588,16 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
>  		goto out;
>  	}
>  
> +	for (int i = CXL_DECODER_DC0; i <= CXL_DECODER_DC7; i++) {
> +		int index = dc_mode_to_region_index(i);
> +
> +		if (mode == i && !resource_size(&cxlds->dc_res[index])) {
> +			dev_dbg(dev, "no available dynamic capacity\n");
> +			rc = -ENXIO;
> +			goto out;
> +		}
> +	}
> +
>  	cxled->mode = mode;
>  	rc = 0;
>  out:
> @@ -469,10 +611,12 @@ static resource_size_t cxl_dpa_freespace(struct cxl_endpoint_decoder *cxled,
>  					 resource_size_t *skip_out)
>  {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	resource_size_t free_ram_start, free_pmem_start;
> +	resource_size_t free_ram_start, free_pmem_start, free_dc_start;
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct device *dev = &cxled->cxld.dev;
>  	resource_size_t start, avail, skip;
>  	struct resource *p, *last;
> +	int index;
>  
>  	lockdep_assert_held(&cxl_dpa_rwsem);
>  
> @@ -490,6 +634,20 @@ static resource_size_t cxl_dpa_freespace(struct cxl_endpoint_decoder *cxled,
>  	else
>  		free_pmem_start = cxlds->pmem_res.start;
>  
> +	/*
> +	 * One HDM Decoder per DC region to map memory with different
> +	 * DSMAS entry.
> +	 */
> +	index = dc_mode_to_region_index(cxled->mode);
> +	if (index >= 0) {
> +		if (cxlds->dc_res[index].child) {
> +			dev_err(dev, "Cannot allocated DPA from DC Region: %d\n",
> +					index);
> +			return -EINVAL;
> +		}
> +		free_dc_start = cxlds->dc_res[index].start;
> +	}
> +
>  	if (cxled->mode == CXL_DECODER_RAM) {
>  		start = free_ram_start;
>  		avail = cxlds->ram_res.end - start + 1;
> @@ -511,6 +669,29 @@ static resource_size_t cxl_dpa_freespace(struct cxl_endpoint_decoder *cxled,
>  		else
>  			skip_end = start - 1;
>  		skip = skip_end - skip_start + 1;
> +	} else if (decoder_mode_is_dc(cxled->mode)) {
> +		resource_size_t skip_start, skip_end;
> +
> +		start = free_dc_start;
> +		avail = cxlds->dc_res[index].end - start + 1;
> +		if ((resource_size(&cxlds->pmem_res) == 0) || !cxlds->pmem_res.child)
> +			skip_start = free_ram_start;
> +		else
> +			skip_start = free_pmem_start;
> +		/*
> +		 * If some dc region is already mapped, then that allocation
> +		 * already handled the RAM and PMEM skip.Check for DC region
> +		 * skip.
> +		 */
> +		for (int i = index - 1; i >= 0 ; i--) {
> +			if (cxlds->dc_res[i].child) {
> +				skip_start = cxlds->dc_res[i].child->end + 1;
> +				break;
> +			}
> +		}
> +
> +		skip_end = start - 1;
> +		skip = skip_end - skip_start + 1;
>  	} else {
>  		dev_dbg(cxled_dev(cxled), "mode not set\n");
>  		avail = 0;
> @@ -548,10 +729,25 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>  
>  	avail = cxl_dpa_freespace(cxled, &start, &skip);
>  
> +	dev_dbg(dev, "DPA Allocation start: %llx len: %llx Skip: %llx\n",
> +						start, size, skip);
>  	if (size > avail) {
> +		static const char * const names[] = {
> +			[CXL_DECODER_NONE] = "none",
> +			[CXL_DECODER_RAM] = "ram",
> +			[CXL_DECODER_PMEM] = "pmem",
> +			[CXL_DECODER_MIXED] = "mixed",
> +			[CXL_DECODER_DC0] = "dc0",
> +			[CXL_DECODER_DC1] = "dc1",
> +			[CXL_DECODER_DC2] = "dc2",
> +			[CXL_DECODER_DC3] = "dc3",
> +			[CXL_DECODER_DC4] = "dc4",
> +			[CXL_DECODER_DC5] = "dc5",
> +			[CXL_DECODER_DC6] = "dc6",
> +			[CXL_DECODER_DC7] = "dc7",
> +		};
>  		dev_dbg(dev, "%pa exceeds available %s capacity: %pa\n", &size,
> -			cxled->mode == CXL_DECODER_RAM ? "ram" : "pmem",
> -			&avail);
> +			names[cxled->mode], &avail);
>  		rc = -ENOSPC;
>  		goto out;
>  	}
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 5e21b53362e6..a1a98aba24ed 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -195,6 +195,22 @@ static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
>  		mode = CXL_DECODER_PMEM;
>  	else if (sysfs_streq(buf, "ram"))
>  		mode = CXL_DECODER_RAM;
> +	else if (sysfs_streq(buf, "dc0"))
> +		mode = CXL_DECODER_DC0;
> +	else if (sysfs_streq(buf, "dc1"))
> +		mode = CXL_DECODER_DC1;
> +	else if (sysfs_streq(buf, "dc2"))
> +		mode = CXL_DECODER_DC2;
> +	else if (sysfs_streq(buf, "dc3"))
> +		mode = CXL_DECODER_DC3;
> +	else if (sysfs_streq(buf, "dc4"))
> +		mode = CXL_DECODER_DC4;
> +	else if (sysfs_streq(buf, "dc5"))
> +		mode = CXL_DECODER_DC5;
> +	else if (sysfs_streq(buf, "dc6"))
> +		mode = CXL_DECODER_DC6;
> +	else if (sysfs_streq(buf, "dc7"))
> +		mode = CXL_DECODER_DC7;
>  	else
>  		return -EINVAL;
>  
> @@ -296,6 +312,7 @@ static struct attribute *cxl_decoder_root_attrs[] = {
>  	&dev_attr_target_list.attr,
>  	SET_CXL_REGION_ATTR(create_pmem_region)
>  	SET_CXL_REGION_ATTR(create_ram_region)
> +	SET_CXL_DC_REGION_ATTR(create_dc_region)
>  	SET_CXL_REGION_ATTR(delete_region)
>  	NULL,
>  };
> @@ -1691,6 +1708,7 @@ struct cxl_endpoint_decoder *cxl_endpoint_decoder_alloc(struct cxl_port *port)
>  		return ERR_PTR(-ENOMEM);
>  
>  	cxled->pos = -1;
> +	xa_init(&cxled->skip_res);
>  	cxld = &cxled->cxld;
>  	rc = cxl_decoder_init(port, cxld);
>  	if (rc)	 {
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 543c4499379e..144232c8305e 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1733,7 +1733,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  	lockdep_assert_held_write(&cxl_region_rwsem);
>  	lockdep_assert_held_read(&cxl_dpa_rwsem);
>  
> -	if (cxled->mode != cxlr->mode) {
> +	if (decoder_mode_is_dc(cxlr->mode) && !decoder_mode_is_dc(cxled->mode)) {
For mode other than dc, no check will be performed, is that what we
want?


>  		dev_dbg(&cxlr->dev, "%s region mode: %d mismatch: %d\n",
>  			dev_name(&cxled->cxld.dev), cxlr->mode, cxled->mode);
>  		return -EINVAL;
> @@ -2211,6 +2211,14 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>  	switch (mode) {
>  	case CXL_DECODER_RAM:
>  	case CXL_DECODER_PMEM:
> +	case CXL_DECODER_DC0:
> +	case CXL_DECODER_DC1:
> +	case CXL_DECODER_DC2:
> +	case CXL_DECODER_DC3:
> +	case CXL_DECODER_DC4:
> +	case CXL_DECODER_DC5:
> +	case CXL_DECODER_DC6:
> +	case CXL_DECODER_DC7:
>  		break;
>  	default:
>  		dev_err(&cxlrd->cxlsd.cxld.dev, "unsupported mode %d\n", mode);
> @@ -2321,6 +2329,43 @@ static ssize_t create_ram_region_store(struct device *dev,
>  }
>  DEVICE_ATTR_RW(create_ram_region);
>  
> +static ssize_t store_dcN_region(struct cxl_root_decoder *cxlrd,
> +				const char *buf, enum cxl_decoder_mode mode,
> +				size_t len)
> +{
> +	struct cxl_region *cxlr;
> +	int rc, id;
> +
> +	rc = sscanf(buf, "region%d\n", &id);
> +	if (rc != 1)
> +		return -EINVAL;
> +
> +	cxlr = __create_region(cxlrd, id, mode, CXL_DECODER_HOSTMEM);
> +	if (IS_ERR(cxlr))
> +		return PTR_ERR(cxlr);
> +
> +	return len;
> +}
> +
> +static ssize_t create_dc_region_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	return __create_region_show(to_cxl_root_decoder(dev), buf);
> +}
> +
> +static ssize_t create_dc_region_store(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t len)
> +{
> +	/*
> +	 * All DC regions use decoder mode DC0 as the region does not need the
> +	 * index information
> +	 */
> +	return store_dcN_region(to_cxl_root_decoder(dev), buf,
> +				CXL_DECODER_DC0, len);
If all DC regions use DC0, what will CXL_DECODER_DC1~7 be used for?

Fan
> +}
> +DEVICE_ATTR_RW(create_dc_region);
> +
>  static ssize_t region_show(struct device *dev, struct device_attribute *attr,
>  			   char *buf)
>  {
> @@ -2799,6 +2844,61 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
>  	return rc;
>  }
>  
> +static void cxl_dc_region_release(void *data)
> +{
> +	struct cxl_region *cxlr = data;
> +	struct cxl_dc_region *cxlr_dc = cxlr->cxlr_dc;
> +
> +	xa_destroy(&cxlr_dc->dax_dev_list);
> +	kfree(cxlr_dc);
> +}
> +
> +static int devm_cxl_add_dc_region(struct cxl_region *cxlr)
> +{
> +	struct cxl_dc_region *cxlr_dc;
> +	struct cxl_dax_region *cxlr_dax;
> +	struct device *dev;
> +	int rc = 0;
> +
> +	cxlr_dax = cxl_dax_region_alloc(cxlr);
> +	if (IS_ERR(cxlr_dax))
> +		return PTR_ERR(cxlr_dax);
> +
> +	cxlr_dc = kzalloc(sizeof(*cxlr_dc), GFP_KERNEL);
> +	if (!cxlr_dc) {
> +		rc = -ENOMEM;
> +		goto err;
> +	}
> +
> +	dev = &cxlr_dax->dev;
> +	rc = dev_set_name(dev, "dax_region%d", cxlr->id);
> +	if (rc)
> +		goto err;
> +
> +	rc = device_add(dev);
> +	if (rc)
> +		goto err;
> +
> +	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
> +		dev_name(dev));
> +
> +	rc = devm_add_action_or_reset(&cxlr->dev, cxlr_dax_unregister,
> +					cxlr_dax);
> +	if (rc)
> +		goto err;
> +
> +	cxlr_dc->cxlr_dax = cxlr_dax;
> +	xa_init(&cxlr_dc->dax_dev_list);
> +	cxlr->cxlr_dc = cxlr_dc;
> +	rc = devm_add_action_or_reset(&cxlr->dev, cxl_dc_region_release, cxlr);
> +	if (!rc)
> +		return 0;
> +err:
> +	put_device(dev);
> +	kfree(cxlr_dc);
> +	return rc;
> +}
> +
>  static int match_decoder_by_range(struct device *dev, void *data)
>  {
>  	struct range *r1, *r2 = data;
> @@ -3140,6 +3240,19 @@ static int is_system_ram(struct resource *res, void *arg)
>  	return 1;
>  }
>  
> +/*
> + * The region can not be manged by CXL if any portion of
> + * it is already online as 'System RAM'
> + */
> +static bool region_is_system_ram(struct cxl_region *cxlr,
> +				 struct cxl_region_params *p)
> +{
> +	return (walk_iomem_res_desc(IORES_DESC_NONE,
> +				    IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
> +				    p->res->start, p->res->end, cxlr,
> +				    is_system_ram) > 0);
> +}
> +
>  static int cxl_region_probe(struct device *dev)
>  {
>  	struct cxl_region *cxlr = to_cxl_region(dev);
> @@ -3174,14 +3287,7 @@ static int cxl_region_probe(struct device *dev)
>  	case CXL_DECODER_PMEM:
>  		return devm_cxl_add_pmem_region(cxlr);
>  	case CXL_DECODER_RAM:
> -		/*
> -		 * The region can not be manged by CXL if any portion of
> -		 * it is already online as 'System RAM'
> -		 */
> -		if (walk_iomem_res_desc(IORES_DESC_NONE,
> -					IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
> -					p->res->start, p->res->end, cxlr,
> -					is_system_ram) > 0)
> +		if (region_is_system_ram(cxlr, p))
>  			return 0;
>  
>  		/*
> @@ -3193,6 +3299,17 @@ static int cxl_region_probe(struct device *dev)
>  
>  		/* HDM-H routes to device-dax */
>  		return devm_cxl_add_dax_region(cxlr);
> +	case CXL_DECODER_DC0:
> +	case CXL_DECODER_DC1:
> +	case CXL_DECODER_DC2:
> +	case CXL_DECODER_DC3:
> +	case CXL_DECODER_DC4:
> +	case CXL_DECODER_DC5:
> +	case CXL_DECODER_DC6:
> +	case CXL_DECODER_DC7:
> +		if (region_is_system_ram(cxlr, p))
> +			return 0;
> +		return devm_cxl_add_dc_region(cxlr);
>  	default:
>  		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",
>  			cxlr->mode);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 8400af85d99f..7ac1237938b7 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -335,6 +335,14 @@ enum cxl_decoder_mode {
>  	CXL_DECODER_NONE,
>  	CXL_DECODER_RAM,
>  	CXL_DECODER_PMEM,
> +	CXL_DECODER_DC0,
> +	CXL_DECODER_DC1,
> +	CXL_DECODER_DC2,
> +	CXL_DECODER_DC3,
> +	CXL_DECODER_DC4,
> +	CXL_DECODER_DC5,
> +	CXL_DECODER_DC6,
> +	CXL_DECODER_DC7,
>  	CXL_DECODER_MIXED,
>  	CXL_DECODER_DEAD,
>  };
> @@ -345,6 +353,14 @@ static inline const char *cxl_decoder_mode_name(enum cxl_decoder_mode mode)
>  		[CXL_DECODER_NONE] = "none",
>  		[CXL_DECODER_RAM] = "ram",
>  		[CXL_DECODER_PMEM] = "pmem",
> +		[CXL_DECODER_DC0] = "dc0",
> +		[CXL_DECODER_DC1] = "dc1",
> +		[CXL_DECODER_DC2] = "dc2",
> +		[CXL_DECODER_DC3] = "dc3",
> +		[CXL_DECODER_DC4] = "dc4",
> +		[CXL_DECODER_DC5] = "dc5",
> +		[CXL_DECODER_DC6] = "dc6",
> +		[CXL_DECODER_DC7] = "dc7",
>  		[CXL_DECODER_MIXED] = "mixed",
>  	};
>  
> @@ -353,6 +369,11 @@ static inline const char *cxl_decoder_mode_name(enum cxl_decoder_mode mode)
>  	return "mixed";
>  }
>  
> +static inline bool decoder_mode_is_dc(enum cxl_decoder_mode mode)
> +{
> +	return (mode >= CXL_DECODER_DC0 && mode <= CXL_DECODER_DC7);
> +}
> +
>  /*
>   * Track whether this decoder is reserved for region autodiscovery, or
>   * free for userspace provisioning.
> @@ -375,6 +396,7 @@ struct cxl_endpoint_decoder {
>  	struct cxl_decoder cxld;
>  	struct resource *dpa_res;
>  	resource_size_t skip;
> +	struct xarray skip_res;
>  	enum cxl_decoder_mode mode;
>  	enum cxl_decoder_state state;
>  	int pos;
> @@ -475,6 +497,11 @@ struct cxl_region_params {
>   */
>  #define CXL_REGION_F_AUTO 1
>  
> +struct cxl_dc_region {
> +	struct xarray dax_dev_list;
> +	struct cxl_dax_region *cxlr_dax;
> +};
> +
>  /**
>   * struct cxl_region - CXL region
>   * @dev: This region's device
> @@ -493,6 +520,7 @@ struct cxl_region {
>  	enum cxl_decoder_type type;
>  	struct cxl_nvdimm_bridge *cxl_nvb;
>  	struct cxl_pmem_region *cxlr_pmem;
> +	struct cxl_dc_region *cxlr_dc;
>  	unsigned long flags;
>  	struct cxl_region_params params;
>  };
> diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
> index ccdf8de85bd5..eb5eb81bfbd7 100644
> --- a/drivers/dax/cxl.c
> +++ b/drivers/dax/cxl.c
> @@ -23,11 +23,15 @@ static int cxl_dax_region_probe(struct device *dev)
>  	if (!dax_region)
>  		return -ENOMEM;
>  
> +	if (decoder_mode_is_dc(cxlr->mode))
> +		return 0;
> +
>  	data = (struct dev_dax_data) {
>  		.dax_region = dax_region,
>  		.id = -1,
>  		.size = range_len(&cxlr_dax->hpa_range),
>  	};
> +
>  	dev_dax = devm_create_dev_dax(&data);
>  	if (IS_ERR(dev_dax))
>  		return PTR_ERR(dev_dax);
> 
> -- 
> 2.40.0
> 

-- 
Fan Ni <nifan@outlook.com>
