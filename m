Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F405C761A6
	for <linux-cxl@archiver.kernel.org>; Fri, 31 Mar 2023 18:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbjCaSkZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 31 Mar 2023 14:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjCaSkT (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 31 Mar 2023 14:40:19 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA141C1F0
        for <linux-cxl@vger.kernel.org>; Fri, 31 Mar 2023 11:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680288002; x=1711824002;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UXvsHjQEBeIX9rSvsf7QmVk8bK71FzrcfIRbuvpZPl8=;
  b=VqfeZuyTWDUYm62RnPQ8r5IczZ0Vrtk0iCcUY1pVHnDY2eQo9T+H8+LJ
   wj4qxYf8rINZkoj5IA7vHGcJ/yHNSClbveQyQ9WO2iKNmQ1wzaQ7UjQJD
   1P23KkboFsS8rv2Kv8vWDMi4Ji/xYcHeqgcNzhqNXPpAsszjUsw9EHzhG
   ZZPTEB8i2mRDOH49aUp8jn6zCDqEJU1lRV072TcMM2er+yGH/eZaeHZXc
   FwXnyLfNnLpV8+WyM+H2kt4dVLSfP7ugijIM9Jrbg71HwWWvi8eO9zJAL
   QoLLNypIwPKY7weTe5ZfoQvEdGhfR5mUA2NNN3bs8vqSq4e9nHHkRCLRF
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="325513225"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="325513225"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 11:40:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="715549660"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="715549660"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.71.212]) ([10.212.71.212])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 11:40:01 -0700
Message-ID: <d53163a2-6be7-afa5-b7c3-0a364ddfbd79@intel.com>
Date:   Fri, 31 Mar 2023 11:40:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v5 02/12] cxl/memdev: Add support for the Clear Poison
 mailbox command
Content-Language: en-US
To:     alison.schofield@intel.com,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>
Cc:     linux-cxl@vger.kernel.org
References: <cover.1679892337.git.alison.schofield@intel.com>
 <548e2a175a2f20cdc886297430102ee851d30f26.1679892337.git.alison.schofield@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <548e2a175a2f20cdc886297430102ee851d30f26.1679892337.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 3/26/23 10:03 PM, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> CXL devices optionally support the CLEAR POISON mailbox command. Add
> memdev driver support for clearing poison.
> 
> Per the CXL Specification (3.0 8.2.9.8.4.3), after receiving a valid
> clear poison request, the device removes the address from the device's
> Poison List and writes 0 (zero) for 64 bytes starting at address. If
> the device cannot clear poison from the address, it returns a permanent
> media error and -ENXIO is returned to the user.
> 
> Additionally, and per the spec also, it is not an error to clear poison
> of an address that is not poisoned. In this case, the device does not
> overwrite the address and the device does not return an error.
> 
> If the address is not contained in the device's dpa resource, or is
> not 64 byte aligned, return -EINVAL without issuing the mbox command.
> 
> Poison clearing is intended for debug only and will be exposed to
> userspace through debugfs. Restrict compilation to CONFIG_DEBUG_FS.
> 
> Implementation note: Although the CXL specification defines the clear
> command to accept 64 bytes of 'write-data' to be used when clearing
> the poisoned address, this implementation always uses 0 (zeros) for
> the write-data.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>   drivers/cxl/core/memdev.c | 43 +++++++++++++++++++++++++++++++++++++++
>   drivers/cxl/cxlmem.h      |  7 +++++++
>   2 files changed, 50 insertions(+)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 3b3ac2868848..0e39c3c3fb09 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -268,6 +268,49 @@ int cxl_inject_poison(struct device *dev, u64 dpa)
>   }
>   EXPORT_SYMBOL_NS_GPL(cxl_inject_poison, CXL);
>   
> +int cxl_clear_poison(struct device *dev, u64 dpa)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_mbox_clear_poison clear;
> +	struct cxl_mbox_cmd mbox_cmd;
> +	int rc;
> +
> +	if (!IS_ENABLED(CONFIG_DEBUG_FS))
> +		return 0;
> +
> +	down_read(&cxl_dpa_rwsem);
> +	rc = cxl_validate_poison_dpa(cxlmd, dpa);
> +	if (rc)
> +		goto out;
> +
> +	/*
> +	 * In CXL 3.0 Spec 8.2.9.8.4.3, the Clear Poison mailbox command
> +	 * is defined to accept 64 bytes of 'write-data', along with the
> +	 * address to clear. The device writes the data into the address
> +	 * atomically, while clearing poison if the location is marked as
> +	 * being poisoned.
> +	 *
> +	 * Always use '0' for the write-data.
> +	 */
> +	clear = (struct cxl_mbox_clear_poison) {
> +		.address = cpu_to_le64(dpa)
> +	};

The write_data[] should be 0s in order to clear the poison right? Since 
'clear' is allocated on the stack, if it's not initialized then it would 
be random garbage in the data. You could just init all 'clear' members 
when you declare the variable at top if you like.

DJ

> +
> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_CLEAR_POISON,
> +		.size_in = sizeof(clear),
> +		.payload_in = &clear,
> +	};
> +
> +	rc = cxl_internal_send_cmd(cxlmd->cxlds, &mbox_cmd);
> +
> +out:
> +	up_read(&cxl_dpa_rwsem);
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_clear_poison, CXL);
> +
>   static struct attribute *cxl_memdev_attributes[] = {
>   	&dev_attr_serial.attr,
>   	&dev_attr_firmware_version.attr,
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 527efef2d700..1d8677ab2306 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -607,6 +607,12 @@ struct cxl_mbox_inject_poison {
>   	__le64 address;
>   };
>   
> +/* Clear Poison  CXL 3.0 Spec 8.2.9.8.4.3 */
> +struct cxl_mbox_clear_poison {
> +	__le64 address;
> +	u8 write_data[CXL_POISON_LEN_MULT];
> +} __packed;
> +
>   /**
>    * struct cxl_mem_command - Driver representation of a memory device command
>    * @info: Command information as it exists for the UAPI
> @@ -684,6 +690,7 @@ ssize_t cxl_trigger_poison_list(struct device *dev,
>   				struct device_attribute *attr, const char *buf,
>   				size_t len);
>   int cxl_inject_poison(struct device *dev, u64 dpa);
> +int cxl_clear_poison(struct device *dev, u64 dpa);
>   
>   #ifdef CONFIG_CXL_SUSPEND
>   void cxl_mem_active_inc(void);
