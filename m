Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7316C352A1
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Dec 2022 16:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231249AbiLFQyZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 6 Dec 2022 11:54:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231990AbiLFQyY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 6 Dec 2022 11:54:24 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375641FCC5
        for <linux-cxl@vger.kernel.org>; Tue,  6 Dec 2022 08:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670345663; x=1701881663;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Hbok9rKc1evgGRwzVdts1gCQA0xgdDNIKv0NWyCZ+Y8=;
  b=RecLhYC0dGNsLz3+Tn7dUD1QLHAdxJFrRNXGW8OpFds0Ff7VcdaRf0Ga
   kVxflZ1dF5m2mP2S+Wu/XAuONUcmc9uFCAoNgmY1bOw3tsJCAmCGGubmn
   PhLSeobiqXXmdUJfbqUp9PU5ZbhcNwv+Sx897UOfFt6/VHW52pmnTkRmR
   53SvDcx3OdTBBdC2YJPWPZuz87RwV2fHujKD/FHwWdI53jVKPC34D6aOu
   63fmvHlrd3nvoADIeILicDzMEVwu+JJsC8bYhyBEsoEfzW8QXP9k0oZ7i
   JDRA//iq7xhFePUcKhl9YMreMQrTLX9cgGHpZBX58taoocWn7I36j8Qi7
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="314317126"
X-IronPort-AV: E=Sophos;i="5.96,222,1665471600"; 
   d="scan'208";a="314317126"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 08:53:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10553"; a="678813164"
X-IronPort-AV: E=Sophos;i="5.96,222,1665471600"; 
   d="scan'208";a="678813164"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.108.100]) ([10.212.108.100])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2022 08:53:57 -0800
Message-ID: <31437358-7811-3004-a864-8415659b80fb@intel.com>
Date:   Tue, 6 Dec 2022 09:53:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: [PATCH 3/4] cxl/mbox: Add variable output size validation for
 internal commands
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc:     ira.weiny@intel.com
References: <167030054261.4044561.2164047490200738083.stgit@dwillia2-xfh.jf.intel.com>
 <167030055918.4044561.10339573829837910505.stgit@dwillia2-xfh.jf.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <167030055918.4044561.10339573829837910505.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 12/5/2022 9:22 PM, Dan Williams wrote:
> cxl_internal_send_cmd() skips output size validation for variable output
> commands which is not ideal. Most of the time internal usages want to
> fail if the output size does not match what was requested. For other
> commands where the caller cannot predict the size there is usually a
> a header that conveys how much vaild data is in the payload. For those
> cases add @min_out as a parameter to specify what the minimum response
> payload needs to be for the caller to parse the rest of the payload.
> 
> In this patch only Get Supported Logs has that behavior, but going
> forward records retrieval commands like Get Poison List and Get Event
> Records can use @min_out to retrieve a variable amount of records.
> 
> Critically, this validation scheme skips the needs to interrogate the
> cxl_mem_commands array which in turn frees up the implementation to
> support internal command enabling without also enabling external / user
> commands.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/core/mbox.c |   23 ++++++++++++++---------
>   drivers/cxl/cxlmem.h    |    2 ++
>   2 files changed, 16 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index ed451ca60ce5..c36a3589377a 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -166,9 +166,7 @@ static const char *cxl_mem_opcode_to_name(u16 opcode)
>   int cxl_internal_send_cmd(struct cxl_dev_state *cxlds,
>   			  struct cxl_mbox_cmd *mbox_cmd)
>   {
> -	const struct cxl_mem_command *cmd =
> -		cxl_mem_find_command(mbox_cmd->opcode);
> -	size_t out_size;
> +	size_t out_size, min_out;
>   	int rc;
>   
>   	if (mbox_cmd->size_in > cxlds->payload_size ||
> @@ -176,6 +174,7 @@ int cxl_internal_send_cmd(struct cxl_dev_state *cxlds,
>   		return -E2BIG;
>   
>   	out_size = mbox_cmd->size_out;
> +	min_out = mbox_cmd->min_out;
>   	rc = cxlds->mbox_send(cxlds, mbox_cmd);
>   	if (rc)
>   		return rc;
> @@ -183,14 +182,18 @@ int cxl_internal_send_cmd(struct cxl_dev_state *cxlds,
>   	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS)
>   		return cxl_mbox_cmd_rc2errno(mbox_cmd);
>   
> +	if (!out_size)
> +		return 0;
> +
>   	/*
> -	 * Variable sized commands can't be validated and so it's up to the
> -	 * caller to do that if they wish.
> +	 * Variable sized output needs to at least satisfy the caller's
> +	 * minimum if not the fully requested size.
>   	 */
> -	if (cmd->info.size_out != CXL_VARIABLE_PAYLOAD) {
> -		if (mbox_cmd->size_out != out_size)
> -			return -EIO;
> -	}
> +	if (min_out == 0)
> +		min_out = out_size;
> +
> +	if (mbox_cmd->size_out < min_out)
> +		return -EIO;
>   	return 0;
>   }
>   EXPORT_SYMBOL_NS_GPL(cxl_internal_send_cmd, CXL);
> @@ -635,6 +638,8 @@ static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_dev_state *cxl
>   		.opcode = CXL_MBOX_OP_GET_SUPPORTED_LOGS,
>   		.size_out = cxlds->payload_size,
>   		.payload_out = ret,
> +		/* At least the record number field must be valid */
> +		.min_out = 2,
>   	};
>   	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
>   	if (rc < 0) {
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index c447577f5ad5..ab138004f644 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -101,6 +101,7 @@ static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
>    *            outputs commands this is always expected to be deterministic. For
>    *            variable sized output commands, it tells the exact number of bytes
>    *            written.
> + * @min_out: (input) internal command output payload size validation
>    * @return_code: (output) Error code returned from hardware.
>    *
>    * This is the primary mechanism used to send commands to the hardware.
> @@ -115,6 +116,7 @@ struct cxl_mbox_cmd {
>   	void *payload_out;
>   	size_t size_in;
>   	size_t size_out;
> +	size_t min_out;
>   	u16 return_code;
>   };
>   
> 
