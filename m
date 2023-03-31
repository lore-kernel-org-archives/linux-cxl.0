Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 790AAC761A6
	for <linux-cxl@archiver.kernel.org>; Fri, 31 Mar 2023 18:11:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjCaSLO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 31 Mar 2023 14:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbjCaSLO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 31 Mar 2023 14:11:14 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F18683E6
        for <linux-cxl@vger.kernel.org>; Fri, 31 Mar 2023 11:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680286273; x=1711822273;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=c6RpuVfvFir7eX+hr2W9VCJopiMnGKMkApp/FBNZFds=;
  b=Qjlc+MASqz0x4NuyDG14qvc4D/5yV1EwNjIgbj3vh8/Bol3nPdw4ACsA
   HB+VjogNoaNzB8tClMRrKS9kl0wX1zBqHvM0BMipLOXuH6GHrXhqCMWj8
   MJc4tRzwrqQ2go0KD1CWf1xhQs38pgmoykNUjib18gaGxgwwcYQqTA0kZ
   P7BSvSH97DrWvedYZkcO8r6GtVLSIcdA2316ti55QbFZjRtC8SKrtFUZ6
   LmHQ6TUTWlHX/nJULNK3mLLANIhbSapk2tMuxM06PiSWCCmlYTVov8j2U
   osvGbAtbVa9O6812vtAJPSw9P4fdbnfWDshG1ln3ld94Pg3KmpQ4cEHBA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="330071900"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="330071900"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 11:11:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="859435889"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="859435889"
Received: from bpedapat-mobl2.amr.corp.intel.com (HELO [10.212.71.212]) ([10.212.71.212])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 11:11:12 -0700
Message-ID: <0986cce6-fcc7-8c47-32df-29a2b308b758@intel.com>
Date:   Fri, 31 Mar 2023 11:11:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v5 01/12] cxl/memdev: Add support for the Inject Poison
 mailbox command
Content-Language: en-US
To:     alison.schofield@intel.com,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>
Cc:     linux-cxl@vger.kernel.org
References: <cover.1679892337.git.alison.schofield@intel.com>
 <976c3fcb43f31c0b303709a14a044652bc267978.1679892337.git.alison.schofield@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <976c3fcb43f31c0b303709a14a044652bc267978.1679892337.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 3/26/23 10:03 PM, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> CXL devices optionally support the INJECT POISON mailbox command. Add
> memdev driver support for the mailbox command.
> 
> Per the CXL Specification (3.0 8.2.9.8.4.2), after receiving a valid
> inject poison request, the device will return poison when the address
> is accessed through the CXL.mem bus. Injecting poison adds the address

s/bus/protocol/?

> to the device's Poison List and the error source is set to Injected.
> In addition, the device adds a poison creation event to its internal
> Informational Event log, updates the Event Status register, and if
> configured, interrupts the host.
> 
> Also, per the CXL Specification, it is not an error to inject poison
> into an address that already has poison present and no error is
> returned from the device.
> 
> If the address is not contained in the device's dpa resource, or is
> not 64 byte aligned, return -EINVAL without issuing the mbox command.
> 
> Poison injection is intended for debug only and will be exposed to
> userspace through debugfs. Restrict compilation to CONFIG_DEBUG_FS.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Just a NIT below. Otherwise,
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/core/memdev.c | 55 +++++++++++++++++++++++++++++++++++++++
>   drivers/cxl/cxlmem.h      |  6 +++++
>   2 files changed, 61 insertions(+)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index f26b5b6cda10..3b3ac2868848 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -213,6 +213,61 @@ ssize_t cxl_trigger_poison_list(struct device *dev,
>   }
>   EXPORT_SYMBOL_NS_GPL(cxl_trigger_poison_list, CXL);
>   
> +static int cxl_validate_poison_dpa(struct cxl_memdev *cxlmd, u64 dpa)
> +{
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +
> +	if (!IS_ENABLED(CONFIG_DEBUG_FS))
> +		return 0;
> +
> +	if (!resource_size(&cxlds->dpa_res)) {
> +		dev_dbg(cxlds->dev, "device has no dpa resource\n");
> +		return -EINVAL;
> +	}
> +	if (dpa < cxlds->dpa_res.start || dpa > cxlds->dpa_res.end) {
> +		dev_dbg(cxlds->dev, "dpa:0x%llx not in resource:%pR\n",
> +			dpa, &cxlds->dpa_res);
> +		return -EINVAL;
> +	}
> +	if (!IS_ALIGNED(dpa, 64)) {
> +		dev_dbg(cxlds->dev, "dpa:0x%llx is not 64-byte aligned\n", dpa);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +int cxl_inject_poison(struct device *dev, u64 dpa)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_mbox_inject_poison inject;
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
> +	inject = (struct cxl_mbox_inject_poison) {
> +		.address = cpu_to_le64(dpa)
> +	};

Why not inject.address = cpu_to_le64(dpa);? Uneless there are more 
assignments coming in later patches?

DJ

> +	mbox_cmd = (struct cxl_mbox_cmd) {
> +		.opcode = CXL_MBOX_OP_INJECT_POISON,
> +		.size_in = sizeof(inject),
> +		.payload_in = &inject,
> +	};
> +	rc = cxl_internal_send_cmd(cxlmd->cxlds, &mbox_cmd);
> +out:
> +	up_read(&cxl_dpa_rwsem);
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_inject_poison, CXL);
> +
>   static struct attribute *cxl_memdev_attributes[] = {
>   	&dev_attr_serial.attr,
>   	&dev_attr_firmware_version.attr,
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 5febaa3f9b04..527efef2d700 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -602,6 +602,11 @@ struct cxl_mbox_poison_payload_out {
>   #define CXL_POISON_SOURCE_INJECTED	3
>   #define CXL_POISON_SOURCE_VENDOR	7
>   
> +/* Inject & Clear Poison  CXL 3.0 Spec 8.2.9.8.4.2/3 */
> +struct cxl_mbox_inject_poison {
> +	__le64 address;
> +};
> +
>   /**
>    * struct cxl_mem_command - Driver representation of a memory device command
>    * @info: Command information as it exists for the UAPI
> @@ -678,6 +683,7 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
>   ssize_t cxl_trigger_poison_list(struct device *dev,
>   				struct device_attribute *attr, const char *buf,
>   				size_t len);
> +int cxl_inject_poison(struct device *dev, u64 dpa);
>   
>   #ifdef CONFIG_CXL_SUSPEND
>   void cxl_mem_active_inc(void);
