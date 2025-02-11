Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9D026BDA2
	for <linux-cxl@vger.kernel.org>; Tue, 11 Feb 2025 02:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739240189; cv=none; b=dAsZL1TA+aPSyUJXShdGzyYwmmbpjG12EQlAPds5K/XMHvaUZ/QGhwWHDyzo7azjQTs/SnfeP6OFbRiGFX3c844W9zrbCLzdtqTPch2pmYpSHqP0Q5QTBfQqkp3xCW7Q3Cz+Q/f/6npzEgntkqppVHA0i2Xlw+XJJN2B4qDCmtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739240189; c=relaxed/simple;
	bh=cyTSYXIesxwtUiqopJ7FLxXg2PITXQOYhsiNUdeMQrY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ABXT0IEWVNYMidELiXiKI8ybAbZ/W8HERCLpX2ql1Lt7czE/ZKZp1Tw5g486JRZhy1w8YgcNs74ChHPcjYGG4CDNptV3Ehm5KRBnN1oh7q7zcOn5oKzTWXpYszt7NV+3CjEhgXe+JZWkk84zvK8Uw7xJIkT08hjgZgzjlV10ELs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MEJvcAdq; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MEJvcAdq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739240187; x=1770776187;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cyTSYXIesxwtUiqopJ7FLxXg2PITXQOYhsiNUdeMQrY=;
  b=MEJvcAdq5BB7aggW5PGKYnOmC25SK740WZEZ0advYNgnAGGAp/Fggd2n
   Dyfep8tXCYmoo84kb7SBLM9zFeyHggRMBrxqkU1SFLi9fPVapw2lhopGv
   c4Rj4s8lrx4cn/R9QN/oPRbD0EDKj2AM92pL5o7jm4AyKV7RAwLpvc/tL
   abl2NQmi9F8h5xHPXKg6GruGLGZYJ4enmWTpjPetauHLDpT8fx/wmLnUh
   ZKnudO9x6vxCQhJFVqrXvmLmqhdE5OSFkoS3MO02Cv61zwSzx5ftEqqDQ
   LYOSsMju3yAYBaGrofqE/dFfI4CNt1o5gp8t3eLYxc5vknN1Y4ZdPNYnF
   g==;
X-CSE-ConnectionGUID: i0KvU9YQSzmlJMGuoz7i2w==
X-CSE-MsgGUID: wneN1N2FTa2Ka3GLFJtsdw==
X-IronPort-AV: E=McAfee;i="6700,10204,11341"; a="39086162"
X-IronPort-AV: E=Sophos;i="6.13,276,1732608000"; 
   d="scan'208";a="39086162"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 18:16:26 -0800
X-CSE-ConnectionGUID: WsFWe5fsRfmQP6hMPAoo3w==
X-CSE-MsgGUID: dHrUSCM5Rp6RmFnBE2hC9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,276,1732608000"; 
   d="scan'208";a="143223831"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO [10.125.111.192]) ([10.125.111.192])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 18:16:25 -0800
Message-ID: <a689a2c9-1fff-4c26-842c-74293d2e4455@intel.com>
Date: Mon, 10 Feb 2025 19:16:24 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] tools/testing/cxl: Set Shutdown State support
To: Davidlohr Bueso <dave@stgolabs.net>, dan.j.williams@intel.com
Cc: jonathan.cameron@huawei.com, alison.schofield@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, seven.yi.lee@gmail.com,
 a.manzanares@samsung.com, fan.ni@samsung.com, anisa.su@samsung.com,
 linux-cxl@vger.kernel.org
References: <20250205040842.1253616-1-dave@stgolabs.net>
 <20250205040842.1253616-3-dave@stgolabs.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250205040842.1253616-3-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/4/25 9:08 PM, Davidlohr Bueso wrote:
> Add support to emulate the CXL Set Shutdown State operation.

Should the CXL_MBOX_OP_GET_SHUTDOWN_STATE support be added as well so the cxl_test can excercise the sysfs attrib and other parts of patch 1?

> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

otherwise
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

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

