Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2104330DEA6
	for <linux-cxl@vger.kernel.org>; Wed, 10 Jun 2026 17:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781114062; cv=none; b=NpGCiqKD6j7YjjibyDXzbuUTyFVQbUVnkwhjMsf0RNwffWklwhpkSsstFLsReVuEifp7bzorAzcZqFYTWjZ6cRE8/7gODKr8YFhNyr0kfNlpXBkQ5tTR4exgcMBNZfMgio1fhTgGIS/VCxMs0h+wl5gaYEy9QtN4BmOe8D4MyCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781114062; c=relaxed/simple;
	bh=HhHZQrqQSNaTtHfrtOV6Zk2aRMlXa/M0bBizyWmDCdU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=A5k8oYgC2zvGtL2/znszOaSG5SkYqHDxZ4BTKu75m4uy2ISuppQnz/1Uhm2XRAKbnDJ6KQuiw1YAbpWsoJmnQ21f23M1X4fwIIR8UT6L0By384ngBN5QVzsmvI/CPuUNiolDyq6KkT8i+yJ74di4OIE+s8HPq1fzN6+6DGKJmZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GmC9J5UA; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GmC9J5UA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781114060; x=1812650060;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=HhHZQrqQSNaTtHfrtOV6Zk2aRMlXa/M0bBizyWmDCdU=;
  b=GmC9J5UA/TA5kNz/y1VOd5ai4t7aQRz5IQarX0NkrMbhLDIUJy803d1I
   ZvD5nRj1b0gY9p6XanRqjJpsZGgm6qUjeTEjo9/rrw4xRiU5j3OyyzOTh
   SW0wNe8Dc0kNOym0ND8VLGFtWYnQCZe0NQT6A5aSPxfE1XnuN8fnwBGnR
   Plg5uMtxFPCs/bh8HPHS6tUgbxnEGsxTpfMRvkMvwMVdzf9xTiUapRxI6
   GgDxEYWnTnm2pGJP23v1n8sv1fIAOamU18pQIlpx37om7sgx1vBSe+B56
   rGcicybF0yhmKdayt1T/qsSpprrbBc3kDG3SugX2AKv+6+a9DfOHVh9D1
   w==;
X-CSE-ConnectionGUID: Vjiq7cMOSZahw1I4O7/ubQ==
X-CSE-MsgGUID: bCBPD4XZTgqBRm1eRYFNHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="81048957"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="81048957"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 10:54:19 -0700
X-CSE-ConnectionGUID: q4+sGxEVRwaVvc8hnoGAGA==
X-CSE-MsgGUID: ogvrmTnwR+meQ9soeVDD5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="269920293"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.125.110.25]) ([10.125.110.25])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 10:54:18 -0700
Message-ID: <beb69225-8531-413a-a9cc-23febb1a6707@intel.com>
Date: Wed, 10 Jun 2026 10:54:17 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/test: Verify cmd->size_in before accessing payload
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dave@stgolabs.net, jic23@kernel.org, alison.schofield@intel.com,
 djbw@kernel.org, sam.moelius@trailofbits.com
References: <20260605181508.3981107-1-dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260605181508.3981107-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/5/26 11:15 AM, Dave Jiang wrote:
> Pre-existing issue discovered by sashiko-bot.
> 
> Add a check for cmd->size_in before accessing the payload. This prevents
> potential dereferencing of a null pointer if size_in is zero.
> 
> Fixes: 7d3eb23c4ccf ("tools/testing/cxl: Introduce a mock memory device + driver")
> Fixes: d1dca858f058 ("cxl/test: Add generic mock events")
> Fixes: f6448cb5f2f3 ("tools/testing/cxl: add firmware update emulation to CXL memdevs")
> Fixes: e77e9c107978 ("cxl/test: Add Get Feature support to cxl_test")
> Link: https://lore.kernel.org/linux-cxl/20260605143748.235271F00893@smtp.kernel.org/
> Suggested-by: sashiko-bot
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Applied to cxl/next with commit log update from Alison
71a1def165267bc0947d4236f7336f490739c379


> ---
> v2:
> Change compare to 0 to payload size. (sashiko)
> ---
>  tools/testing/cxl/test/mem.c | 39 +++++++++++++++++++++++++++---------
>  1 file changed, 30 insertions(+), 9 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 271c7ad8cc32..2e9a5f151e98 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -312,12 +312,17 @@ static int mock_get_event(struct device *dev, struct cxl_mbox_cmd *cmd)
>  
>  static int mock_clear_event(struct device *dev, struct cxl_mbox_cmd *cmd)
>  {
> -	struct cxl_mbox_clear_event_payload *pl = cmd->payload_in;
> +	struct cxl_mbox_clear_event_payload *pl;
>  	struct mock_event_log *log;
> -	u8 log_type = pl->event_log;
> +	u8 log_type;
>  	u16 handle;
>  	int nr;
>  
> +	if (cmd->size_in < sizeof(*pl))
> +		return -EINVAL;
> +
> +	pl = cmd->payload_in;
> +	log_type = pl->event_log;
>  	if (log_type >= CXL_EVENT_TYPE_MAX)
>  		return -EINVAL;
>  
> @@ -574,14 +579,19 @@ static int mock_gsl(struct cxl_mbox_cmd *cmd)
>  static int mock_get_log(struct cxl_memdev_state *mds, struct cxl_mbox_cmd *cmd)
>  {
>  	struct cxl_mailbox *cxl_mbox = &mds->cxlds.cxl_mbox;
> -	struct cxl_mbox_get_log *gl = cmd->payload_in;
> -	u32 offset = le32_to_cpu(gl->offset);
> -	u32 length = le32_to_cpu(gl->length);
>  	uuid_t uuid = DEFINE_CXL_CEL_UUID;
> +	struct cxl_mbox_get_log *gl;
>  	void *data = &mock_cel;
> +	u32 offset;
> +	u32 length;
>  
>  	if (cmd->size_in < sizeof(*gl))
>  		return -EINVAL;
> +
> +	gl = cmd->payload_in;
> +	offset = le32_to_cpu(gl->offset);
> +	length = le32_to_cpu(gl->length);
> +
>  	if (length > cxl_mbox->payload_size)
>  		return -EINVAL;
>  	if (offset + length > sizeof(mock_cel))
> @@ -1336,10 +1346,14 @@ static int mock_fw_info(struct cxl_mockmem_data *mdata,
>  static int mock_transfer_fw(struct cxl_mockmem_data *mdata,
>  			    struct cxl_mbox_cmd *cmd)
>  {
> -	struct cxl_mbox_transfer_fw *transfer = cmd->payload_in;
> +	struct cxl_mbox_transfer_fw *transfer;
>  	void *fw = mdata->fw;
>  	size_t offset, length;
>  
> +	if (cmd->size_in < sizeof(*transfer))
> +		return -EINVAL;
> +
> +	transfer = cmd->payload_in;
>  	offset = le32_to_cpu(transfer->offset) * CXL_FW_TRANSFER_ALIGNMENT;
>  	length = cmd->size_in - sizeof(*transfer);
>  	if (offset + length > FW_SIZE)
> @@ -1415,11 +1429,18 @@ static int mock_get_test_feature(struct cxl_mockmem_data *mdata,
>  				 struct cxl_mbox_cmd *cmd)
>  {
>  	struct vendor_test_feat *output = cmd->payload_out;
> -	struct cxl_mbox_get_feat_in *input = cmd->payload_in;
> -	u16 offset = le16_to_cpu(input->offset);
> -	u16 count = le16_to_cpu(input->count);
> +	struct cxl_mbox_get_feat_in *input;
> +	u16 offset;
> +	u16 count;
>  	u8 *ptr;
>  
> +	if (cmd->size_in < sizeof(*input))
> +		return -EINVAL;
> +
> +	input = cmd->payload_in;
> +	offset = le16_to_cpu(input->offset);
> +	count = le16_to_cpu(input->count);
> +
>  	if (offset > sizeof(*output)) {
>  		cmd->return_code = CXL_MBOX_CMD_RC_INPUT;
>  		return -EINVAL;
> 
> base-commit: e43ffb69e0438cddd72aaa30898b4dc446f664f8

