Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8DD61EB195
	for <linux-cxl@vger.kernel.org>; Wed, 19 Feb 2025 16:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739983746; cv=none; b=IDokkxvyAN37DnlBAYhgnDFZNebx8qs58KQ8CEczLrOXrl/XYAOkWM9zwaCu8orejrywNKaMXxXafWdpm5hdhr0u+WD5Ju7yrHHiQlyaR+Y+no/8gAtMbptEoK4siRDv0yRdkUynrAtZo/3X+dA1L8GZ6xRcLJpEvx+HXNwvC1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739983746; c=relaxed/simple;
	bh=nYTJMxf3z1aMXQYdGragY+UjfJi4eqVmTFsluFfk9vY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mfhy0itkJO1CxvKcADpMR6mugIbgXbTu9YnPOp+GnVKUWADQxyrlYZeRADhbyHfjd6FXCclAMPbVn7hfR6z1bzWIDDoDWCRUvghVV1IL6OSe6m9GpbvnYCDtltVkqiOsmd2lvRiZjWODvUfg7Yg5ahRZGcfQxvxJ+UJyKmWzwFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fs6R7ptL; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fs6R7ptL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739983745; x=1771519745;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nYTJMxf3z1aMXQYdGragY+UjfJi4eqVmTFsluFfk9vY=;
  b=Fs6R7ptLAUGLcZm/pvNchGrQgI6dnwtwbsOwOAbk8QT/9cKJ2JHmBxcG
   qIExIq59uXXZE3H78p6fuJSI+KzaLbRkYWJdg+W8fKWkR/zUQ3cm9zjOO
   d03BdJgzyPINg7EAuIc2BBF9G6Wq/n7B9U9KjzkPaH0MlaJveH4M7DMqc
   AaN7gpZB68E+3IEh/KzLhY77uo7I2e1RzxFF5McVDaOIEY36aTE+fKQkw
   04xESyFfXLaf50MWcgjkqTvdxWB9P8G219S/xMe8ZGEr/Q5Gp0+w7IhdW
   oOnOQT+RTxhK1jjY4rsST9Xbi1cueqzUAm6pJbvVJNMiXKDYF9beP+s3u
   Q==;
X-CSE-ConnectionGUID: keKywx5RTge2DTsKQYg8Ug==
X-CSE-MsgGUID: jY0HwRb4S9CLbcTfzzyRig==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="44649001"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="44649001"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 08:49:04 -0800
X-CSE-ConnectionGUID: zHS3AmLXRC6ajOH5Ngxh8g==
X-CSE-MsgGUID: qlM5QYGPRJiRtMSGpK3Kqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="115293810"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.110.11]) ([10.125.110.11])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 08:49:03 -0800
Message-ID: <f79dfd9f-07c5-4193-a4a3-9fbef8ca3445@intel.com>
Date: Wed, 19 Feb 2025 09:48:59 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] tools/testing/cxl: Set Shutdown State support
To: Davidlohr Bueso <dave@stgolabs.net>, dan.j.williams@intel.com
Cc: jonathan.cameron@huawei.com, alison.schofield@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, seven.yi.lee@gmail.com,
 a.manzanares@samsung.com, fan.ni@samsung.com, anisa.su@samsung.com,
 linux-cxl@vger.kernel.org
References: <20250219062832.237881-1-dave@stgolabs.net>
 <20250219062832.237881-5-dave@stgolabs.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250219062832.237881-5-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/18/25 11:28 PM, Davidlohr Bueso wrote:
> Add support to emulate the CXL Set Shutdown State operation.
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  tools/testing/cxl/test/mem.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 495199238335..832680a87c73 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -65,6 +65,10 @@ static struct cxl_cel_entry mock_cel[] = {
>  		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_HEALTH_INFO),
>  		.effect = CXL_CMD_EFFECT_NONE,
>  	},
> +	{
> +		.opcode = cpu_to_le16(CXL_MBOX_OP_SET_SHUTDOWN_STATE),
> +		.effect = POLICY_CHANGE_IMMEDIATE,
> +	},
>  	{
>  		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_POISON),
>  		.effect = CXL_CMD_EFFECT_NONE,
> @@ -161,6 +165,7 @@ struct cxl_mockmem_data {
>  	u8 event_buf[SZ_4K];
>  	u64 timestamp;
>  	unsigned long sanitize_timeout;
> +	int shutdown_state;

Should be u8?

DJ

>  };
>  
>  static struct mock_event_log *event_find_log(struct device *dev, int log_type)
> @@ -1088,6 +1093,21 @@ static int mock_health_info(struct cxl_mbox_cmd *cmd)
>  	return 0;
>  }
>  
> +static int mock_set_shutdown_state(struct cxl_mockmem_data *mdata,
> +				   struct cxl_mbox_cmd *cmd)
> +{
> +	struct cxl_mbox_set_shutdown_state_in *ss = cmd->payload_in;
> +
> +	if (cmd->size_in != sizeof(*ss))
> +		return -EINVAL;
> +
> +	if (cmd->size_out != 0)
> +		return -EINVAL;
> +
> +	mdata->shutdown_state = ss->state;
> +	return 0;
> +}
> +
>  static struct mock_poison {
>  	struct cxl_dev_state *cxlds;
>  	u64 dpa;
> @@ -1421,6 +1441,9 @@ static int cxl_mock_mbox_send(struct cxl_mailbox *cxl_mbox,
>  	case CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE:
>  		rc = mock_passphrase_secure_erase(mdata, cmd);
>  		break;
> +	case CXL_MBOX_OP_SET_SHUTDOWN_STATE:
> +		rc = mock_set_shutdown_state(mdata, cmd);
> +		break;
>  	case CXL_MBOX_OP_GET_POISON:
>  		rc = mock_get_poison(cxlds, cmd);
>  		break;

