Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21806C77B7A
	for <linux-cxl@archiver.kernel.org>; Thu,  1 Jun 2023 17:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjFARYY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 1 Jun 2023 13:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbjFARYX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 1 Jun 2023 13:24:23 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2044.outbound.protection.outlook.com [40.92.107.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A265C0
        for <linux-cxl@vger.kernel.org>; Thu,  1 Jun 2023 10:24:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UFkf5Szc09wu4389l6kkb6IyaYFXEp7dDfhUtXSP5Sh8VcaPy3R6cCWd/L0mDxyenu8hnZk9qYRMCeuJvJpGogq06jGfm/2FynvhL2t/YItwZWHsPmwGG5qsrPF69bW+kObM0D1QRkTC6+Suawc3jlMjsBXNgxxC40/FIeMxk+NOuVxbU54vGGgkroAGoy7vTxFY4CWJgg03IlmWPgn1jRFnG+ucoVOgBlIY9W2Ecg09SXDJ2FudR0z3OwzWLrmy3niL3MD2EE3SI7MCNR1ObT0TNAkUZ5l0ukLyiAqOiCssP10Ey5kgU+E0DCJ4OXi3HWjU596o7pYhz2Ptmpl/2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xG+9Hu2aChXot4oqRhZbGkEOwxT4Q2LRVccPPLE1ngQ=;
 b=LaOYkG+gYrPsAi7wLZS58o5oFRZva0U1DQA8nEj5RZLVY3EJSiiagyH840UI4mroeCbjcgb/lX8Gh825EvXY3gmX1ZhkbuBvtFXg9rOSJIMk1pwO0+qnYLWAIunYP+PIhSUwHk0wdPayEp+gk3OB+onbHludQu5EkiN3qbaoAt7moWugMfvGvnKkD2/Pe8I5lMo+nL4YKolT7Pde7xkvLiNAOcnSq9Wz3QQdELRsD8gHh63b2lAwx88hd6ujREvwHMCI1A2ovOxI2NFT+4Y2W4D9PCpZIGm5GNCyca1GkXMinP6ZAlD5HGSmz14AOm2U0cdVeTQ2zmCee4D7f3kW8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xG+9Hu2aChXot4oqRhZbGkEOwxT4Q2LRVccPPLE1ngQ=;
 b=jNdblPReKR5b0wV4/BzHF7j/YEQdFxd2n/S7pB7V5VJ56oskOeHt8dxgAzGFBnvpgWi1XE/iQfkMIVM6V8hKVrdzYj6WyJT2Ob7JK6Mqp7IA0NaXevRjGY8P3Dc3VmZfm829Md6zAm6lN/BkH8Kwt6LcJw/JFuPbqygtjKwxunqlNMTlFpxdsrIU0VPT09sRT2BlSmpGfcqOXJ6+Tkji99HQqfNPKZ8lnZjMLplBlSaJyXVjkzt3Lclx5s6omLCTXYuAekqEUjYYr7cB1xSc+hdFi2RtQUOQ3FYainGSjeGo7zi8Rhbh/jiu1jKVv0KcoYTOZITi8Y8d95nkiQCklg==
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com (2603:1096:4:7a::17) by
 SEYPR06MB6033.apcprd06.prod.outlook.com (2603:1096:101:d7::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6433.24; Thu, 1 Jun 2023 17:24:16 +0000
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::248c:58fd:97db:5425]) by SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::248c:58fd:97db:5425%7]) with mapi id 15.20.6433.018; Thu, 1 Jun 2023
 17:24:16 +0000
Date:   Thu, 1 Jun 2023 10:24:04 -0700
From:   Fan Ni <nifan@outlook.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     dan.j.williams@intel.com, dave.jiang@intel.com,
        vishal.l.verma@intel.com, Jonathan.Cameron@huawei.com,
        fan.ni@samsung.com, a.manzanares@samsung.com,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH 5/6] cxl/mem: Support Secure Erase
Message-ID: <SG2PR06MB3397E0C3971B2BD8603F18D0B2499@SG2PR06MB3397.apcprd06.prod.outlook.com>
References: <20230526033344.17167-1-dave@stgolabs.net>
 <20230526033344.17167-6-dave@stgolabs.net>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230526033344.17167-6-dave@stgolabs.net>
X-TMN:  [PC2ziNCo+0vdcR8v12QvVM/KqU1e1buAZkPvNPvruOQ=]
X-ClientProxiedBy: BY3PR05CA0041.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::16) To SG2PR06MB3397.apcprd06.prod.outlook.com
 (2603:1096:4:7a::17)
X-Microsoft-Original-Message-ID: <ZHjUNKYv7EyvoANs@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3397:EE_|SEYPR06MB6033:EE_
X-MS-Office365-Filtering-Correlation-Id: a73828e6-c01e-49a4-c9ec-08db62c50696
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CUADh2S36UdB7qcYept8rioEHMDdO7paC0tlsgCvbE6VNRSp78y4R5tLXdsCc8Cc7mnlmJIjTc9spe1kgdhk549UKSyV3uKLHfeOdv4akGC3KOI5Y+jDy3i+UspPvh7tpRHz3lE7u14lVWeinLNfG0hZfRMm5QXLTvdSbqYvtN1UzDMnhZHB69Gx7wwVQwdQ17lIIyG2S+5Ec1A6Aijs3CtvK2sBbn5dNpT8T3ouuyDqsq53FYcRjNu2tbJ8g9oKlGiCirLCUl6WAWw7niN00CSZWI4uo6/3dsO0PHpJ1SuAZ8pNc+UGKzLzA7Fd5aS0CC1D8ADi0vop3dDsi6y7SaVYfW9Rw7DIbsoGpNcA0QTRRd9mqVhmKBpEGxe8A7FFLpgm4xwUOGys6Rapmo8y8pjr1Vk2iHuxxK+P0vjN5I9pGyjuORNM0XVXgyO+YuYJqKuuvaw0AhoJRKI/SpF2E/jXNLXRWMCJnoUbtR3bkiofUuGMujb3iaoojdBPWLaLlWB2hGI952Jrg5lQ52dZvKtQvAeBr9/EbM69xoQJ3GTNsnT04pVc+yCw9AL3LP7JNjpMuRz+6ols1hZu7GBuqFb5/DYP7RbqtWEyQfba7eSrFaYn7dRyr8dQr3WxKJY3
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VG5HNFk1YTIwWldTek0wZTdsSWZxM0ZRYjdoTEV3WUN2Y1VKa1duY1g3VFZw?=
 =?utf-8?B?SVVLcHlmd0pKenRXOXF1dWZZUjMreTc4SWlPMHZaV0NPQzZoS3BiaUxIbDNP?=
 =?utf-8?B?RzRHVW1vdkEzODZ1VWpHT243eUVjMnNYT3FJYkkrdG9TZnp6NHBWejdZMVlO?=
 =?utf-8?B?ZzFPek82VmU3QVUwakhmVDBXQWhKZ0xSQm5EYk93bWtBT20xZVlpc3h4OHNh?=
 =?utf-8?B?Rk9FNE1ZZUdzNnBZM3ZCc1ZreVIyU0JWVno3VkpoWGZVcm9rUHhaOW9TbFda?=
 =?utf-8?B?a0xmYklVdEc2WHhjUE1UckNrSkJiRWordTVPRG4zMmttVXR2ay82Y2FnWXdy?=
 =?utf-8?B?aG1ReURvbE93alBXVEVsdGFQRS8wYUdoSSt5SC9HZUVMVW45Y1RPbXZMby9Q?=
 =?utf-8?B?OUx6S2RkcGY4MlFmTit1cnZZSnVYaG14QVJ5YTR3TWNRQWNtSWl1ckliTUh4?=
 =?utf-8?B?VTEzMCtqeTBwWTJLd2wxWjRoNFkvcis4M0JkS1NWcnBTSjB3bmd6cHBLbFFl?=
 =?utf-8?B?YTNzenJVL1o1YUpicnVneTNDQnp1MUlhMkNiTjE0Tmo5cWtmM2lpVmJOWmpT?=
 =?utf-8?B?U0FxMU1DUGl3TzJCNjZabjRmOEEyMjVOa1dCV1h2YWRjbmdxNGhzQkw5bDNL?=
 =?utf-8?B?YnFUbXpNdDhlNDZVeWJPNDhjREtPSE5yNVk2cjlVVDh2cDUzcE9ZZ0FIZmNk?=
 =?utf-8?B?dTQ5K3BjMERaNEpGWHRZMllKaG1kV1JjNlFvUWZ5MCtuQWplc0Y1SHpLU1VW?=
 =?utf-8?B?eDZGeFVJQW83bWYyZUNUUDdXeW5jSGhDY29kZGJtWUhMM1JpdWV6UEJQWmZs?=
 =?utf-8?B?dU5mMmRpanpkT1ZudFdITFA0ZEl1NGtNQ0l5LzRqSGxKQ0xZS3RRaHBDdkNU?=
 =?utf-8?B?WEJ3OStuQ2FBMm5wOTFHbHdLS1NGTWNJU3VRMkhsbFRSeWpIbGhkbWFUdDl6?=
 =?utf-8?B?OGFJQllVb2tGemtPYVY5T05LVHFpQ1dncUFRL0FVTFlueTl2T1MxcEpaY0x6?=
 =?utf-8?B?T2IydUQ2WW5qWG1qVHZhRmhrRzB0N2laajJzL0JXUFJ2QzBadG1PYVFjOVFG?=
 =?utf-8?B?VnFzb1p4aEl3eFlsSGpjcW1DUms3NzNGaXJ5SnJNMHBUV2VPRVBENlA4S3ZX?=
 =?utf-8?B?SEpaVnNkVWtvVmFtdEZyL2NqMmRJNXQwSmtOTTUrUVRFeXlaT0k2Y1JxazY3?=
 =?utf-8?B?Q0RwQ2ljc3ZraHErcHgxak9pQkNxWnJuSWt6V2lTUm5FWnh5d2xoNGQzb3dF?=
 =?utf-8?B?VkI5VWFXcnNIcFA0REIxcFI2NGY2eStKRjJEaDlzMGkxZGZIdUJLdVBiMlN5?=
 =?utf-8?B?c1RFQm85dVZ2VGZqaHVCV3ZnVzNYeCtqS08xaE00WGpDSGZPU01QVmhETE44?=
 =?utf-8?B?Y1JaZDFnQzNyNDkvYlRzSjBSWFBCd3RyR3JTdzI2K25VeG55YlhIMnVtYklZ?=
 =?utf-8?B?aEorUFBESktoT28wVjVNb2p0UTI2eVhZckczOE92MndNeWF6cDZmWThBZEsx?=
 =?utf-8?B?RHFqaDcxNDhoSHRJTlpNYjZnaFBGd2RnVDBJMFVUaWltYVpMNWk4bDlucTJ0?=
 =?utf-8?B?QS9qZnYwUHFCMEgwaEY0U2x0bkUrN0c0K1JxRkJ4UzRzVmdxdlZiSGlkUTFR?=
 =?utf-8?Q?1k857US3buCbAaRhpp1XN4ov7/NlePkTROmMEMQYgQJM=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a73828e6-c01e-49a4-c9ec-08db62c50696
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3397.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 17:24:16.7821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB6033
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The 05/25/2023 20:33, Davidlohr Bueso wrote:
> Implement support for the non-pmem exclusive secure erase, per
> CXL specs. Create a write-only 'security/erase' sysfs file to
> perform the requested operation.
> 
> As with the sanitation this requires the device being offline
> and thus no active HPA-DPA decoding.
> 
> The expectation is that userspace can use it such as:
> 
> 	cxl disable-memdev memX
> 	echo 1 > /sys/bus/cxl/devices/memX/security/erase
> 	cxl enable-memdev memX
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  Documentation/ABI/testing/sysfs-bus-cxl | 10 +++++++++
>  drivers/cxl/core/mbox.c                 |  6 +++++-
>  drivers/cxl/core/memdev.c               | 28 +++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h                    |  1 +
>  4 files changed, 44 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 5753cba98692..f224c1215f22 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -85,6 +85,16 @@ Description:
>  		the device to be not be actively decoding any HPA ranges.
>  
>  
> +What            /sys/bus/cxl/devices/memX/security/erase
> +Date:           June, 2023
> +KernelVersion:  v6.5
> +Contact:        linux-cxl@vger.kernel.org
> +Description:
> +		(WO) Write a boolean 'true' string value to this attribute to
> +		secure erase user data by changing the media encryption keys for
> +		all user data areas of the device.
> +
> +
>  What:		/sys/bus/cxl/devices/*/devtype
>  Date:		June, 2021
>  KernelVersion:	v5.14
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 51c64829f20a..6622eac66bf1 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1102,7 +1102,7 @@ int cxl_mem_sanitize(struct cxl_dev_state *cxlds, u16 cmd)
>  	};
>  	struct cxl_mbox_cmd mbox_cmd = { .opcode = cmd };
>  
> -	if (cmd != CXL_MBOX_OP_SANITIZE)
> +	if (cmd != CXL_MBOX_OP_SANITIZE && cmd != CXL_MBOX_OP_SECURE_ERASE)
>  		return -EINVAL;
>  
>  	rc = cxl_internal_send_cmd(cxlds, &sec_cmd);
> @@ -1120,6 +1120,10 @@ int cxl_mem_sanitize(struct cxl_dev_state *cxlds, u16 cmd)
>  	if (sec_out & CXL_PMEM_SEC_STATE_USER_PASS_SET)
>  		return -EINVAL;
>  
> +	if (cmd == CXL_MBOX_OP_SECURE_ERASE &&
> +	    sec_out & CXL_PMEM_SEC_STATE_LOCKED)
> +		return -EINVAL;
> +
>  	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
>  	if (rc < 0) {
>  		dev_err(cxlds->dev, "Failed to sanitize device : %d", rc);
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 90f23e53d483..d06c8539e82c 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -163,6 +163,33 @@ static ssize_t security_sanitize_store(struct device *dev,
>  static struct device_attribute dev_attr_security_sanitize =
>  	__ATTR(sanitize, 0200, NULL, security_sanitize_store);
>  
> +static ssize_t security_erase_store(struct device *dev,
> +				    struct device_attribute *attr,
> +				    const char *buf, size_t len)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_port *port = dev_get_drvdata(&cxlmd->dev);
> +	ssize_t rc;
> +	bool erase;
> +
> +	if (kstrtobool(buf, &erase) || !erase)
> +		return -EINVAL;
> +
> +	if (!port || !is_cxl_endpoint(port))
> +		return -EINVAL;
> +
> +	/* ensure no regions are mapped to this memdev */
> +	if (port->commit_end != -1)
> +		return -EBUSY;
> +
> +	rc = cxl_mem_sanitize(cxlds, CXL_MBOX_OP_SECURE_ERASE);
> +
> +	return rc ? rc : len;
> +}
> +static struct device_attribute dev_attr_security_erase =
> +	__ATTR(erase, 0200, NULL, security_erase_store);
> +
>  static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
>  {
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> @@ -411,6 +438,7 @@ static struct attribute *cxl_memdev_ram_attributes[] = {
>  static struct attribute *cxl_memdev_security_attributes[] = {
>  	&dev_attr_security_state.attr,
>  	&dev_attr_security_sanitize.attr,
> +	&dev_attr_security_erase.attr,
>  	NULL,
>  };
>  
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 408ec33c8480..758fea7b9dbf 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -392,6 +392,7 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_SCAN_MEDIA		= 0x4304,
>  	CXL_MBOX_OP_GET_SCAN_MEDIA	= 0x4305,
>  	CXL_MBOX_OP_SANITIZE		= 0x4400,
> +	CXL_MBOX_OP_SECURE_ERASE	= 0x4401,
>  	CXL_MBOX_OP_GET_SECURITY_STATE	= 0x4500,
>  	CXL_MBOX_OP_SET_PASSPHRASE	= 0x4501,
>  	CXL_MBOX_OP_DISABLE_PASSPHRASE	= 0x4502,
> -- 
> 2.40.1
> 

-- 
Fan Ni <nifan@outlook.com>
