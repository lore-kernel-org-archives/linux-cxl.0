Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6010BC76196
	for <linux-cxl@archiver.kernel.org>; Fri, 31 Mar 2023 19:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjCaTSt (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 31 Mar 2023 15:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230191AbjCaTSs (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 31 Mar 2023 15:18:48 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 279F11115F
        for <linux-cxl@vger.kernel.org>; Fri, 31 Mar 2023 12:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680290327; x=1711826327;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=U7z+h/evRJ+RPtsnYf+AlEyTm3OHEbK3nBWWmu989Zo=;
  b=n8iJCpFXLoRL1QstljfZQAd5CWTK4qMI4iwdnAt1qD2DBNjFDODYdGjR
   9Ne5pTyKH2W0ieFYKq5DI/swhFRami6g6QRcD5mJi5k5phmJLcKOsbwbu
   q+XkXWqfMUSjFP/QfTgZ6eYwDDVB08yAT5+sDdzaX5FGgEhSxXh29und6
   gsPL+lIC/LxDsGz6S7Nik1lNAF3ih2XfcEkbb7+Ma4zlYL+95XHcs2+G/
   7BnGtlU6Aynfxnt4aUB07VjGZBvJMJOfsUNLJtmBL9epgslaZWYkmogIA
   cRw1l1XA2dXqxNjBeWz+bz4Edd6AOuvbyrMfUpLXnvN+uRpC7ZA9uHjd1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="404271849"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="404271849"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 12:18:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="859457603"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="859457603"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.71.212]) ([10.212.71.212])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 12:18:46 -0700
Message-ID: <9ead63d7-6330-7950-50b8-2a6ada404f69@intel.com>
Date:   Fri, 31 Mar 2023 12:18:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v5 11/12] tools/testing/cxl: Add a sysfs attr to test
 poison inject limits
Content-Language: en-US
To:     alison.schofield@intel.com,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>
Cc:     linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <cover.1679892337.git.alison.schofield@intel.com>
 <8c6a37f71095be970eb04cc1e2ab2cdb08062020.1679892337.git.alison.schofield@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <8c6a37f71095be970eb04cc1e2ab2cdb08062020.1679892337.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 3/26/23 10:03 PM, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> CXL devices may report a maximum number of addresses that a device
> allows to be poisoned using poison injection. When cxl_test creates
> mock CXL memory devices, it defaults to MOCK_INJECT_DEV_MAX==88 for
> all mocked memdevs.
> 
> Add a sysfs attribute, poison_inject_max to module cxl_mock_mem so
> that users can set a custom device injection limit. Fail, and return
> -EBUSY, if the mock poison list is not empty.
> 
> /sys/bus/platform/drivers/cxl_mock_mem/poison_inject_max
> 
> A simple usage model is to set the attribute before running a test in
> order to emulate a device's poison handling.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   tools/testing/cxl/test/mem.c | 52 +++++++++++++++++++++++++++++++++---
>   1 file changed, 48 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 9658d95236b7..5c3b3e5a3b4b 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -19,6 +19,8 @@
>   #define MOCK_INJECT_DEV_MAX 8
>   #define MOCK_INJECT_TEST_MAX 128
>   
> +static unsigned int poison_inject_dev_max = MOCK_INJECT_DEV_MAX;
> +
>   static struct cxl_cel_entry mock_cel[] = {
>   	{
>   		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_SUPPORTED_LOGS),
> @@ -485,7 +487,7 @@ static int mock_id(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
>   			cpu_to_le64(SZ_256M / CXL_CAPACITY_MULTIPLIER),
>   		.total_capacity =
>   			cpu_to_le64(DEV_SIZE / CXL_CAPACITY_MULTIPLIER),
> -		.inject_poison_limit = cpu_to_le16(MOCK_INJECT_DEV_MAX),
> +		.inject_poison_limit = cpu_to_le16(MOCK_INJECT_TEST_MAX),
>   	};
>   
>   	put_unaligned_le24(CXL_POISON_LIST_MAX, id.poison_list_max_mer);
> @@ -919,7 +921,7 @@ static struct cxl_mbox_poison_payload_out
>   	int nr_records = 0;
>   	u64 dpa;
>   
> -	po = kzalloc(struct_size(po, record, MOCK_INJECT_DEV_MAX), GFP_KERNEL);
> +	po = kzalloc(struct_size(po, record, poison_inject_dev_max), GFP_KERNEL);
>   	if (!po)
>   		return NULL;
>   
> @@ -934,7 +936,7 @@ static struct cxl_mbox_poison_payload_out
>   		po->record[nr_records].address = cpu_to_le64(dpa);
>   		po->record[nr_records].length = cpu_to_le32(1);
>   		nr_records++;
> -		if (nr_records == MOCK_INJECT_DEV_MAX)
> +		if (nr_records == poison_inject_dev_max)
>   			break;
>   	}
>   
> @@ -969,7 +971,7 @@ static bool mock_poison_dev_max_injected(struct cxl_dev_state *cxlds)
>   		if (mock_poison_list[i].cxlds == cxlds)
>   			count++;
>   	}
> -	return (count >= MOCK_INJECT_DEV_MAX);
> +	return (count >= poison_inject_dev_max);
>   }
>   
>   static bool mock_poison_add(struct cxl_dev_state *cxlds, u64 dpa)
> @@ -1051,6 +1053,47 @@ static int mock_clear_poison(struct cxl_dev_state *cxlds,
>   	return 0;
>   }
>   
> +static bool mock_poison_list_empty(void)
> +{
> +	for (int i = 0; i < MOCK_INJECT_TEST_MAX; i++) {
> +		if (mock_poison_list[i].cxlds)
> +			return false;
> +	}
> +	return true;
> +}
> +
> +static ssize_t poison_inject_max_show(struct device_driver *drv, char *buf)
> +{
> +	return sysfs_emit(buf, "%u\n", poison_inject_dev_max);
> +}
> +
> +static ssize_t poison_inject_max_store(struct device_driver *drv,
> +				       const char *buf, size_t len)
> +{
> +	int val;
> +
> +	if (kstrtoint(buf, 0, &val) < 0)
> +		return -EINVAL;
> +
> +	if (!mock_poison_list_empty())
> +		return -EBUSY;
> +
> +	if (val <= MOCK_INJECT_TEST_MAX)
> +		poison_inject_dev_max = val;
> +	else
> +		return -EINVAL;
> +
> +	return len;
> +}
> +
> +static DRIVER_ATTR_RW(poison_inject_max);
> +
> +static struct attribute *cxl_mock_mem_core_attrs[] = {
> +	&driver_attr_poison_inject_max.attr,
> +	NULL
> +};
> +ATTRIBUTE_GROUPS(cxl_mock_mem_core);
> +
>   static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
>   {
>   	struct device *dev = cxlds->dev;
> @@ -1259,6 +1302,7 @@ static struct platform_driver cxl_mock_mem_driver = {
>   	.driver = {
>   		.name = KBUILD_MODNAME,
>   		.dev_groups = cxl_mock_mem_groups,
> +		.groups = cxl_mock_mem_core_groups,
>   	},
>   };
>   
