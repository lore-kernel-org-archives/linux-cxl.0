Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64851C77B60
	for <linux-cxl@archiver.kernel.org>; Fri, 31 Mar 2023 16:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbjCaQiY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 31 Mar 2023 12:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbjCaQh5 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 31 Mar 2023 12:37:57 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01olkn2084.outbound.protection.outlook.com [40.92.52.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D762C9E1
        for <linux-cxl@vger.kernel.org>; Fri, 31 Mar 2023 09:34:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNM3Y/7wMgRJc6a25GUlX1KaDI2BY2PJOYzicWHPi/WUNg19wmuFn3vAdYhayluIQ/cYGm0RWkLgXLmNTXLBQpFzqsJxPCDN+ZNiQMFTpCcNiqiTwpMMUAjd8kwojaw2wHCiM1R1EfS53M3gaXnGfWdP1KHNxPqclybQYvdFfLfUayXX6abGIwJI2r0FA68uE7wlDDo/TKYARoRypPttL9Sfm5PMTTUMCWlCIOJtTAKbWOKHOJWFizB5EpjYJ74yqM6InBH8XDNB8UcJ+QUCqUnDpOzGSOSp36zaPj6K0gBpctzXAwSoOESCClZkY4AhW/Pqb+RMUSva3yaYtzGv6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HVARaIleoZ+76kHSFMYqsi+s0PLfpTdmPkYT6+ESEM=;
 b=NLg2bp/iNF1a6Yp4LfqtbfydFnASFjik5SBAMqVUvWTQ76Kv9zN8lUGHEe5U95LSzppo9APtNWG76P/9lQQbqUfgoctiCPpYhTYFMbTPBIj6JlwQDEH0TC+Cb1vqn6Vw+vKMLDyPGvKyyGwG/UEnQHayg5/5X2+Xb0/fwRfDNnUILSBl9c31i/MiR72Pbuv6OtyEgZqpPPe0tFpmLVF+XyjEQxag8xLvhR1rjlmk210njeZgko4p6DGIuqnxD+3BZltxqeBNhTM5Y9FjFN+mGsZmBEE2WJWKD7Npg6iazwfN5VvkSiEMD7awfbCqJvJD88sMe9QnhNvo6x1qv28tRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HVARaIleoZ+76kHSFMYqsi+s0PLfpTdmPkYT6+ESEM=;
 b=A/gwNp9odgQtpvpp4nVqEGOLGraXhisNYzaXq9lIqizrFbrivT1/ZjEfeYUcnq08p6Zq7nmSz7Y+G5S/0d8KS7lKKdAgXMQn0x+nH5VjfLwSrtrtn7oIehsUPVyTv09a+LZ0db9yPjJY99ytcfFaOR1V+DVFedB1IeH3hLEo+gj1OrflZ3NJ834w5GaZEyrBgyyeljpCUjZRH+OffUaOWuqVD2+jcauLPJ5c8GPzQ7Zv6STHGXMPcAmwGcgQtfXk1yVemDjSymMh7jKnG82gbULBSMS50iNr8lIkEHD2NZ5IQxkwhDJorMwaiRwQo0D90GIbglr34VgD3jjAerjuTQ==
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com (2603:1096:4:7a::17) by
 SI2PR06MB5266.apcprd06.prod.outlook.com (2603:1096:4:1e5::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6254.20; Fri, 31 Mar 2023 16:33:58 +0000
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::822f:761f:a577:c76e]) by SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::822f:761f:a577:c76e%4]) with mapi id 15.20.6222.035; Fri, 31 Mar 2023
 16:33:58 +0000
Date:   Fri, 31 Mar 2023 09:33:44 -0700
From:   Fan Ni <nifan@outlook.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        dave.jiang@intel.com, a.manzanares@samsung.com, dave@stgolabs.net
Subject: Re: [PATCH 2/2] cxl/hdm: Skip emulation when driver manages
 mem_enable
Message-ID: <SG2PR06MB3397EF72E78E4635945086DBB28F9@SG2PR06MB3397.apcprd06.prod.outlook.com>
References: <167703067373.185722.16579529992799939220.stgit@dwillia2-xfh.jf.intel.com>
 <167703068474.185722.664126485486344246.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <167703068474.185722.664126485486344246.stgit@dwillia2-xfh.jf.intel.com>
X-TMN:  [cODazI7O/K8hjtnE/RfxQb3ZiElLcWhe]
X-ClientProxiedBy: BYAPR02CA0006.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::19) To SG2PR06MB3397.apcprd06.prod.outlook.com
 (2603:1096:4:7a::17)
X-Microsoft-Original-Message-ID: <ZCcLaH2oeAZ5NZ3t@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3397:EE_|SI2PR06MB5266:EE_
X-MS-Office365-Filtering-Correlation-Id: 45cd9ad7-9fc0-40ec-2fb2-08db3205b9cf
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6ccM2+OISen0pSZobtm+MZjVRa7dQTPX/6LOC+ahp2l5B79aF6hSWrdDoFjJnR69Xv4DvQRrA3FSUl+vD2oU8c0pLhXenG3hbM0KjuO/1zB12IUoxuZjxs+B/Z6VRcYEAGiUNvcdGpUnZzEL6IKO3gz3DA9eLWYVU7jP6YPhBpb2ari7kpgFWqAWjUB/u6WTCgTHz0H3RzqUkiAnT7QbK4mN/1J2kbaDZRgLs9bZmcDgew6swQREQ9Oq1IfHYzqNnwJkCi5rLPtxoM4PAYqVPedt4N8LNXpiVaOGIUt02temx/92wuPeG6oDF8nk0HdSSE9gAi+b5hwfTXHMSrcFiffcoovXw0SUAhGBKUbqA+sNeIz3+3qomCe1nSjTPKzw/IOBbqgUuLO+vUaVLGUS8gvfdvOt9xaz/wQD1fZYZw5KSrH5rp7UaCdl34Z5ON3qEliP7H3ge5His3BWv5lgIfz7QoFkxGJIzjiDcvE9P4ZfLtvppw7mH7La7MWFDl3apTO464nQpR7Q26P6H03v0CXo54Ykaq4AdwG4h+X6bq9Eo8uussobFfH0XSG8YdsqFYHIULg9f8kcEdl1cbwqKOSDif0FAj3ZFNO97n6o47M=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3p5VG5DZUx6OUFvUjAvTndpbTJkNzJTTlNGRHA5TzBIYWdIeFk4YkdxWkdJ?=
 =?utf-8?B?c3k3TS9ORmFhUW9qN0NxNWpQOVQ4ZUh3bW4rV2VyM0NyT2UzUFNlS2VDQWZx?=
 =?utf-8?B?VWQ1dDRhb1RWb0V6TDQ0bUxWM0pCeHZRekF2UmJpbXlsRCsvblc2cHFva0tJ?=
 =?utf-8?B?elVCZldFSGQrKzZLOXNKM1oydzVwY0cwT1laVDNNL3JHU2tISitobUtFV0d2?=
 =?utf-8?B?N3ovMWtCdHJnWEpabXZkRUNMK3lMa2k3bVNIdnhQL09xb1VyR2lsUGVvR043?=
 =?utf-8?B?ZTJKUHNrUUEvRWdEQ0JFa2VqSVZaTVE4TFVscE9zdGd1NlJycmxxTURJM2xM?=
 =?utf-8?B?S2dUMlg4NHlWQjgyQzV4V1QxVHlTcUxmQ2wyL2hYM2dYbS8reFp5c0pZdlVX?=
 =?utf-8?B?K2tHRzNkazRSRk0vMXhjMnBOZUJNSSs0eXVMeWxTNU5vL1dMWFZVQ3MzQjdJ?=
 =?utf-8?B?ekRFRXNROE13cGFGWEFoTmZJZ2srRG12NTMzSjFKWWhIVUpneFZYQ1RPYllQ?=
 =?utf-8?B?WkVCN1FRNEFIcFRnQVlDTW12eUliVXdBeG8wa1lLLzdVcVRSbVQyS21rZitW?=
 =?utf-8?B?cFdSZi9xVUk1V3dxZDltY1B6WFdjMG1seGpQaTdObXFwdlBDdU0rdkVEcnhr?=
 =?utf-8?B?WFNyRG56cEh3TGVYb0J4SER0S2V1L1k5a1Brb1NxVzh5U0NLWjBqQ0RxSlJG?=
 =?utf-8?B?YVVBUE5rYkhCckNFK0VLMHYyZkxqcHNndUxIdURmbHh1MWVXSVVWcmYxRS9y?=
 =?utf-8?B?ZW9ZQlE0UjNVQ2ZRUzdiZ0phRzdlTFJSQ2JoMEhrTkZKR2pKRXRrVlpDb2lr?=
 =?utf-8?B?NlF2ZUdjeW5QdUpvUEdDUzVNVXNlOVVsd2dUVWxzNTVKUXlMVXFKQzcyMy9o?=
 =?utf-8?B?RHpPdjBtOU0vVndRcnhSbkhRSFFXdU5mNDFMQ00xd1ZWaVpWY0FYd3VnTGRY?=
 =?utf-8?B?RkNINXdjN3FmTzNvS2pKbnFUcmgyOHh3ZzRIR0JvRDdJdUU0NWMwRzU5dlpN?=
 =?utf-8?B?enU0aC9oQlc5TWJ4eWQzT2RqL255N3lyd3hKbTBQQmJPWCt2TDdwY3JpZDFH?=
 =?utf-8?B?bTFIZEdFQ21BSzFXQjdmUGJEWmFqSzBoVHh4UldPR2h1VVh0bGVPQy94WXNP?=
 =?utf-8?B?S0tTcDRIQnRXcVV3WUZaVDVraFRJQjlzSlh4ZFhzWjBpOTJSSDk4djM4a2tK?=
 =?utf-8?B?d3U0WFQxSS85QTRsNjVLR1d5cGkwNDZ2NU9EWnpFQjc2eEdFRzAxY0E0SjA0?=
 =?utf-8?B?ekNHTS9VcGNRVXMyUys1WjE0WHBQU3g1SWk3WUVFcmtWU3NRRFJCZXdFQjVV?=
 =?utf-8?B?ejkzdkFjenU0TnRSd3FsY1NKd2JLR0hBQnhJZlJIb1ZlYTNCR0tsZ3ZSTkFD?=
 =?utf-8?B?YzNHV1Y3YmRldnJnZ1BDVkJHZ09Kd1FuNkJPTlNFOFQwRjdEOUtGaVJuYXNI?=
 =?utf-8?B?RVY0SUpqUVAyT2ZnVk1tYzFpaERydlRiNUVTeVFMRHBnYnhFK3JFa2NPMXhD?=
 =?utf-8?B?THM3L2tsNVZOa1FyMmhTWlZKbWN0dVREUW1uaWFtK3Z1Q3NObGozU3I3QXFl?=
 =?utf-8?B?cXBRLzVaaVRqNjhaVGg5S3Aydkp5aWFQOFdtYlRLcHQybk1oeGladWk4dUpW?=
 =?utf-8?B?dkZLU0FTWldLKzJ6bktEUXZ6T00wQWc9PQ==?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45cd9ad7-9fc0-40ec-2fb2-08db3205b9cf
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3397.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2023 16:33:58.7977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5266
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The 02/21/2023 17:51, Dan Williams wrote:
> If the driver is allowed to enable memory operation itself then it can
> also turn on HDM decoder support at will.
> 
> With this the second call to cxl_setup_hdm_decoder_from_dvsec(), when
> an HDM decoder is not committed, is not needed.
> 
> Fixes: b777e9bec960 ("cxl/hdm: Emulate HDM decoder from DVSEC range registers")
> Link: http://lore.kernel.org/r/20230220113657.000042e1@huawei.com
> Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Fan Ni <fan.ni@samsung.com>

Confirming this patch fixed the issue we hit when creating a region with
cxl create-region command and failed to find a free decoder as the
hpa_range is not correctly initialized as should_emulate_decoders
returns true instead of false when loading modules and init_hdm_decoder
is called.

> ---
>  drivers/cxl/core/hdm.c |   31 ++++++++++++++++++-------------
>  drivers/cxl/cxl.h      |    4 +++-
>  drivers/cxl/port.c     |    2 +-
>  3 files changed, 22 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 520814130928..5293fe13fce3 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -717,19 +717,29 @@ static int cxl_setup_hdm_decoder_from_dvsec(struct cxl_port *port,
>  	return 0;
>  }
>  
> -static bool should_emulate_decoders(struct cxl_port *port)
> +static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
>  {
> -	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
> -	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
> +	struct cxl_hdm *cxlhdm;
> +	void __iomem *hdm;
>  	u32 ctrl;
>  	int i;
>  
> -	if (!is_cxl_endpoint(cxlhdm->port))
> +	if (!info)
>  		return false;
>  
> +	cxlhdm = dev_get_drvdata(&info->port->dev);
> +	hdm = cxlhdm->regs.hdm_decoder;
> +
>  	if (!hdm)
>  		return true;
>  
> +	/*
> +	 * If HDM decoders are present and the driver is in control of
> +	 * Mem_Enable skip DVSEC based emulation
> +	 */
> +	if (!info->mem_enabled)
> +		return false;
> +
>  	/*
>  	 * If any decoders are committed already, there should not be any
>  	 * emulated DVSEC decoders.
> @@ -747,7 +757,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  			    int *target_map, void __iomem *hdm, int which,
>  			    u64 *dpa_base, struct cxl_endpoint_dvsec_info *info)
>  {
> -	struct cxl_endpoint_decoder *cxled = NULL;
> +	struct cxl_endpoint_decoder *cxled;
>  	u64 size, base, skip, dpa_size;
>  	bool committed;
>  	u32 remainder;
> @@ -758,12 +768,9 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  		unsigned char target_id[8];
>  	} target_list;
>  
> -	if (should_emulate_decoders(port))
> +	if (should_emulate_decoders(info))
>  		return cxl_setup_hdm_decoder_from_dvsec(port, cxld, which, info);
>  
> -	if (is_endpoint_decoder(&cxld->dev))
> -		cxled = to_cxl_endpoint_decoder(&cxld->dev);
> -
>  	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
>  	base = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(which));
>  	size = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(which));
> @@ -784,9 +791,6 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  		.end = base + size - 1,
>  	};
>  
> -	if (cxled && !committed && range_len(&info->dvsec_range[which]))
> -		return cxl_setup_hdm_decoder_from_dvsec(port, cxld, which, info);
> -
>  	/* decoders are enabled if committed */
>  	if (committed) {
>  		cxld->flags |= CXL_DECODER_F_ENABLE;
> @@ -824,7 +828,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  	if (rc)
>  		return rc;
>  
> -	if (!cxled) {
> +	if (!info) {
>  		target_list.value =
>  			ioread64_hi_lo(hdm + CXL_HDM_DECODER0_TL_LOW(which));
>  		for (i = 0; i < cxld->interleave_ways; i++)
> @@ -844,6 +848,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  		return -ENXIO;
>  	}
>  	skip = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_SKIP_LOW(which));
> +	cxled = to_cxl_endpoint_decoder(&cxld->dev);
>  	rc = devm_cxl_dpa_reserve(cxled, *dpa_base + skip, dpa_size, skip);
>  	if (rc) {
>  		dev_err(&port->dev,
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index d853a0238ad7..dd4b7a729419 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -695,13 +695,15 @@ int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
>  
>  /**
>   * struct cxl_endpoint_dvsec_info - Cached DVSEC info
> - * @mem_enabled: cached value of mem_enabled in the DVSEC, PCIE_DEVICE
> + * @mem_enabled: cached value of mem_enabled in the DVSEC at init time
>   * @ranges: Number of active HDM ranges this device uses.
> + * @port: endpoint port associated with this info instance
>   * @dvsec_range: cached attributes of the ranges in the DVSEC, PCIE_DEVICE
>   */
>  struct cxl_endpoint_dvsec_info {
>  	bool mem_enabled;
>  	int ranges;
> +	struct cxl_port *port;
>  	struct range dvsec_range[2];
>  };
>  
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 1049bb5ea496..9c8f46ed336b 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -78,8 +78,8 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>  
>  static int cxl_endpoint_port_probe(struct cxl_port *port)
>  {
> +	struct cxl_endpoint_dvsec_info info = { .port = port };
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport);
> -	struct cxl_endpoint_dvsec_info info = { 0 };
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct cxl_hdm *cxlhdm;
>  	struct cxl_port *root;
> 

-- 
John Smith
My name is not generic at all.
