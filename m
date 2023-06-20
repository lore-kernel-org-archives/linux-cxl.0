Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A08B1EB64D7
	for <linux-cxl@archiver.kernel.org>; Tue, 20 Jun 2023 17:55:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjFTRzk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 20 Jun 2023 13:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbjFTRzj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 20 Jun 2023 13:55:39 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn20802.outbound.protection.outlook.com [IPv6:2a01:111:f403:704b::802])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D77581729
        for <linux-cxl@vger.kernel.org>; Tue, 20 Jun 2023 10:55:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWjvi+msJRy8TfyopMSDzdzJEPkWDgOLjidzebTIYH4hOFOYhGgG0HNh7QwPgUhey9DL+tkHePwxz200iRMFk8tgWE4pnn2nwnIKs9tMG6GEKNNOdXZ3lyEf0dd/7AfA66I1cduFZ7A44uZZUUoPOpVdKQo9G9GrOD64Y2n9KSznA0CRHWaRk1btHA07JoOio4nJ4NOdg26wztVmyDFKjnEc2yUI7pIsAeM+hFQ2iU1LqjlJCyW0Q/2q/VYDcGIEwD4FdbjI/gCQvYKoEJdZgdFhyUbyILIzL39uA0yyrqNwsWMzLjbyrkhAwOmfkKOpUtTtObKW1cWcS/sB85umZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SsOQdo+CvBdd//lBj5LAoPbidAICA6EPXokT7Rt33/k=;
 b=J6OAZBOwlkw22NXhpS8irjjSxs6jjfw7f7q2Osn1Mm+RU7BKHX0f7rQGx7V1RSwVWNsDPA7tAUOxzZcN+JxH8UsRWtfFOaZsSLZKxb9gScYpmsLVNeA1tMdv0Bzkqjw1jYQcW9qHUuTJg2oGzWvlh1Lu6me7h9nmJV01fEYxzh7sam6C983M78a0+VEyjBmYbeTgmfSpWYcNyAn7/9AgHvWp5E5veISqF7moZqUk5by6G/foi6d104xjK11Bi+v+iJAHtdcfnIfm3srTLr96K+PqsZF72WrC5EegXX8ISRRrvHU8gq0XRSuQRF9g3unslbiauhXImtXKfkRiHKo00g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsOQdo+CvBdd//lBj5LAoPbidAICA6EPXokT7Rt33/k=;
 b=MwSUFZ593JijCL5HJMFgUsKoSCKwuNADDHzQ9V0Jy8yZ9BX25XCAeestJmZQULDvu4JWUOyt4GncywX67ia+jK9X3KGm8u9QwvK8mKG8QfgbOyNHhheKCe/5+f2QZTPhMum4nZetM95pbRM3hRvE9aLfwY6evudG1pdSTewFUi+JbiLCAGFYZ5MalsGTyHYdKRCEbEVBwdnA4llo4gDYR1Vw21Oz8tv1PCRHAvtTaaJVmLTw74lLlX7d0H9L7mMWBNUrlua6Gqh9MGam/cLHmv5n5KtoczmuzkgTJPaTNPIIWaH818UFEUnSrCy5V4g1+EYxTlOl4HAnodpg1tZD0g==
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com (2603:1096:4:7a::17) by
 TYUPR06MB6049.apcprd06.prod.outlook.com (2603:1096:400:358::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6500.37; Tue, 20 Jun 2023 17:55:31 +0000
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::33a7:c9e1:75ae:3227]) by SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::33a7:c9e1:75ae:3227%4]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 17:55:31 +0000
Date:   Tue, 20 Jun 2023 10:55:15 -0700
From:   Fan Ni <nifan@outlook.com>
To:     ira.weiny@intel.com
Cc:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org, a.manzanares@samsung.com,
        dave@stgolabs.net, nmtadam.samsung@gmail.com, nifan@outlook.com
Subject: Re: [PATCH 2/5] cxl/region: Add dynamic capacity cxl region support.
Message-ID: <SG2PR06MB3397DD960E58B1F026CBC0E8B25CA@SG2PR06MB3397.apcprd06.prod.outlook.com>
References: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
 <20230604-dcd-type2-upstream-v1-2-71b6341bae54@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230604-dcd-type2-upstream-v1-2-71b6341bae54@intel.com>
X-TMN:  [wEhLDfi3u9AF4+sogQiLV1xVlbjoTTkgjlsEN60g9srryjCWpFsEs4Bn9ZE+nAzx/yvf6tk8AGE=]
X-ClientProxiedBy: MW3PR05CA0007.namprd05.prod.outlook.com
 (2603:10b6:303:2b::12) To SG2PR06MB3397.apcprd06.prod.outlook.com
 (2603:1096:4:7a::17)
X-Microsoft-Original-Message-ID: <ZJHoA5N9vDl+MpH9@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3397:EE_|TYUPR06MB6049:EE_
X-MS-Office365-Filtering-Correlation-Id: be541040-483d-45f1-9c8e-08db71b7899f
X-MS-Exchange-SLBlob-MailProps: Cq7lScuPrnp1Zl+T4aq3XOCSrXM4sba9RiVZl9cyYe83t2dbAH6mW8szhZlO4MQuLgx6Lrui+ZO9smPBR1bujTodQUTx9u+kCbswu5cQOqIfgfjxY2Ms0FxWvYyENs0lOf5feVMEprlewFB0KXkp97GDAlNgLdWabCZ0aQb4wMPk4MnAYCInAS/iM9qZSMDMd/xpUNTPgkTzlkkyzrYuhpFF8xqYFF7GYVRk4IlD/KJCJr5BXdK8UCo7+ugZ0P4M2+R8h1qgkSvH1lLBPadM+TxParvmMVPJnrLvooLLBzvuISG+55/xs2WfWuLtNQBlJkrq+5Xu9Oa6rfrc1xxYbpYKRYJLn6HuKu8VAB4/UuiB456EjUYsMPrryWNTsWn3mwY79GH/Lw618F4GYTlbaWVzCXjpKdyWEm6tSq1IXaO3XLcKE12UVx7hcE6/V0qS32k0FlaBnAnN1KsdVAJ/p9uz+wsAgJ7W+LYax5rOnBzngaiArqL3RQ+Dbm6CDR8h8lf/3A7XxxdO1xaRYhnRyAk7wWduyQy4NQYZRNR2ma7mOduKAfFYdku+a2a3c2QkEkCOnBSOeX2Ahir6GIFXoqcx47UWFQuQKGPguS9hOAVh8tYpbMwk7kqumpzsC13X9w8k8tLWOYwYK2z3xVCpGf8wBVZXtYeBc7mxC8ofdeBTwwuE4CBcqCS4d1z12zfV+PADjhOIJzBW6GrCFytEsxkVGC2E2vPHhM1sjYMd4aL9GLbebtmLmjzey17kKJ2RTeT5teJi4bA=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7bhrGrU6VxUimAeU+n7JxEXeg7e+z3bdQAE6MXVpXMqcaOKnk96GWnWP7JhX6f+GPvcRVye2yZ+Ds9Bb1EEiZZMLRNtJEk0MClMm6yo54NQDKLR9mmVAi5+DiLYP0QZpLyWf8FWdrxQkyKCSLjq/Ome9bs90RSdN/VSVxtDncPbnrjDXqqjDRmhFmiYkfJuXaHhhYPAKjitk42Po4I9tzCvIaTTLRzjFOqM8QIOvbGNjktFilJ4WAk/YnLqXTJnwkr8LSNffv6Qej9Md1DMdDVWcx8sxUDlePYTlP5w2Egsx7eQj/3SaZhDXNShPQZCEpuvilvpG5F6Ix9R6XogWv9CJKvnmSCSOtARcCeO7Qz7+6fhwI6g0XneOx/xvE/55THv61JW5g7dvVmwVfhA6KlGRrDVaWRFUjbKpPX9TLW6noOJL0AgzjmyHHPIio2w07BvNjzH3zillL0Wqu4dMwOlzO6Z2IUqEBD1oJqRUE1TCskLlp+gLcpfVrKaD650Vq6VQy0OlLZk7+7FN5E6ve4u8IQidaTiuTuLT7s5ixZGZZOVtGf+RCJbpoCAFigxjdkMwV9JBPXxxv9K6AU0D7fGf+LTj4Misfgk1qVF2kbyKw42arQuJODed+QXLx+4/P4gl5oowfrSaovRRU+0Mww==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aktPekRtRHArN2FMeVJ3czdleTJONHhxbjFZaStUZWdGdkVXa00zaEZtOS9o?=
 =?utf-8?B?bXhHZXU3eXlCd21JaHJQdCtZNEFUNkJaYXRoVE9BSUlIS1hzNE5kT0JaWEwz?=
 =?utf-8?B?VklvZ1ZkanltOXQvcnlYZkZVMDhHZFJGbDFMN1FmVmdZTCtETlRUOHRzL0lC?=
 =?utf-8?B?MGtpQnVOMFpXR2QyUFc1QXgyQ1RzMUZYQUdtcTlmeTdxQmFkeHhXTmNodTk4?=
 =?utf-8?B?c2hEZytTZUkwTDUwYlFXcWlGNzlNb3hTbU4rcFA3Skc0Wk9iV0cza1V3bjBM?=
 =?utf-8?B?V1Y1QzhGejVIcnhaSG9ERzl2eWtGbFVoVENwcHZxZ1ppdUxQK2EyckNtVWFk?=
 =?utf-8?B?V2hqRis5d1ZsckdpcmJTZjJIcnBaQmJsRm5DUG1qajhDYkFIVzI3dkpobFN4?=
 =?utf-8?B?YmJ6aVYzSzRoYlRUVnV6ejFsamRUa0IyUGtQcGl2QlVXS2puUExJWjhaZmwv?=
 =?utf-8?B?SEk1NzlwdVVXNHNiU3ZUL2xUTkZJSlFCUGdPSW1zMVVjMzFsdmNIWXBKM3oy?=
 =?utf-8?B?NC9JMG4xNVdJQm5heDBtTFFEaThUeEVjK3RjNmZRLy95VkNiWXlvcGJzZmhr?=
 =?utf-8?B?clFJSDF0bGxQbXN4eUhuam94dWw0UDBYSm1USTlVb1g1TlExTjc2aklBSVh5?=
 =?utf-8?B?K0p4bDVjL2RtY1JOcitza1V4TnhVZkppSnFVb3NWT29XZGpSMHJrODNFSFdq?=
 =?utf-8?B?K0pBSy8xVGhBS21LSXJUTGM3OWd6Q1hkZlJOeVRldWhUd3VvTzZwYTF3UWNG?=
 =?utf-8?B?Q3h5TzY1T3QwZkNRYjJRd3VqbXpBWkR1cFRqaWl4WGFJbXFKU1VaT3JaZ01J?=
 =?utf-8?B?TjNsdFBWRmZ1cTI2OWxqaGNHbzRSTVRiREg2alR3eGJDS282SysrK0hoQi9k?=
 =?utf-8?B?a3lCbkd5bnp2UjVBaFM5eWkwNThjOVNTWUdOaVJONnZnV3hubks1Vm5yYkIx?=
 =?utf-8?B?VTNjakQ3c3ZUT2hmVmpKOFRsU2crRHU5TkVxRkdkSTdlMjFEeGcrUVZpcmVT?=
 =?utf-8?B?M0ZlNEhib2RCcmI1SlBNZStLZkE3Uis4Mkp0K0VHczlEVlBzbjdsd2NtSkhC?=
 =?utf-8?B?bVZlNHJXeGF3Tm1JaDBWR1oxemNONkhaTkFreUVlUzlVNk91cmduRzg3Q3FD?=
 =?utf-8?B?WWw2Sm9EcmNPQzQ5dHJHdElCdWp4bklwQkZiakp6QVZGMTRzOEZYUW5jZlJ1?=
 =?utf-8?B?TCtBcXdod0ExMkhEZHVDTGxEd0c4enRjQzgzaFhZZVVzUTZlVHV0VmpXdjli?=
 =?utf-8?B?MnYzS0hBNzNXbmJjejEwTmZWV3VLdzNJeDBkd1pZVFR5RmJ6ZGRaMDRRWGtZ?=
 =?utf-8?B?QWF1Sy8xZ0dYL1VqN3oxVm96bGVaS2dHK3JOQmNoc2hqNWh2UzNXc0hEb3BX?=
 =?utf-8?B?VVNFcWkzN3hVeGN2K2ltOUZMVVFpY2FyQ1FIN1JJT2h0WkdjYUZDVW9UckFt?=
 =?utf-8?B?U05CRE9KRzFzVkFSSVAxTkphZWlubjQraVdOeW1PYUMzSmdnT1Nwd1dnL2ww?=
 =?utf-8?B?NVpmbStIWThhWng3aW9xdG0raTJKbkc5L0l4S202ZXlFd09kNG4xYW96RUhP?=
 =?utf-8?B?NzVHL0hXQmp6eDU5YVE5NFZyUnFXdFlIZTcwaHdEUVhNS1RTaGJybHR4czhB?=
 =?utf-8?B?ZVQ1WCsrUzN3WFJsd1hZL2lIUlM4WTV1TmpVclhiUkJhMWZFTGdQL3VQYWgy?=
 =?utf-8?B?RlBFNXVHZ0cwcTR4NUJYK1hvc0hnS1Nad2Z5aWlkaXFIdW9sdFNpR1VBPT0=?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be541040-483d-45f1-9c8e-08db71b7899f
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3397.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2023 17:55:31.4235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR06MB6049
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
Should it be cxlds->pmem_res here?

Fan
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
