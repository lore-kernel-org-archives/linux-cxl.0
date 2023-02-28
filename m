Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D0FFC64ED6
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Feb 2023 18:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjB1SEV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 28 Feb 2023 13:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjB1SEV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 28 Feb 2023 13:04:21 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C32131E39
        for <linux-cxl@vger.kernel.org>; Tue, 28 Feb 2023 10:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677607459; x=1709143459;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GsJ0FeCcj9dPRiR46062O0r4XBNBDbjBAM3DtAWMXJM=;
  b=ALpJmp46jcuMZPNrhgp/f5r3uJ/3iXM06OcxFZYvh703182dOclt0+wL
   dAv4rR/JOg9IDYSOP/BxSnIWedRckcQuGGcglywK2zJdQA7VvIshaFbp2
   UvDuIDW/7qW1PmVjbWz6lNO5Q4posOD0+/KbxXdLGzkQAUPF+ZhRlPa/j
   NDjtunItEXPCRhuVg8qztpMYCX17TyqWIGMZ6dCu616pnG4BJkpzuZNz9
   ykOD++0E9xUIRQP01VyHzLffphOziQw1j+4jI3oL3LlIZ+BFlIHB8GHvS
   XRy4RxHKdUktbCR3CeewsroeCPAUNiqk21dasAWCyYs5MBizI2ml5Tx8y
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="318005239"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="318005239"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 10:03:42 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="674245185"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="674245185"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.1.236]) ([10.212.1.236])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 10:03:41 -0800
Message-ID: <3f35b83b-8ee9-7367-af05-d59e9f0940ab@intel.com>
Date:   Tue, 28 Feb 2023 11:03:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH 5/7] cxl/test: Add "Sanitize" opcode support
Content-Language: en-US
To:     Davidlohr Bueso <dave@stgolabs.net>, dan.j.williams@intel.com
Cc:     jonathan.cameron@huawei.com, ira.weiny@intel.com,
        fan.ni@samsung.com, a.manzanares@samsung.com,
        linux-cxl@vger.kernel.org
References: <20230224194652.1990604-1-dave@stgolabs.net>
 <20230224194652.1990604-6-dave@stgolabs.net>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230224194652.1990604-6-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 2/24/23 12:46 PM, Davidlohr Bueso wrote:
> Add support to emulate a CXL mem device support the "Sanitize"
> operation, without incurring in the background.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   tools/testing/cxl/test/mem.c | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 9263b04d35f7..d4466cb27947 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -497,6 +497,28 @@ static int mock_partition_info(struct cxl_dev_state *cxlds,
>   	return 0;
>   }
>   
> +static int mock_sanitize(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
> +{
> +	struct cxl_mockmem_data *mdata = dev_get_drvdata(cxlds->dev);
> +
> +	if (cmd->size_in != 0)
> +		return -EINVAL;
> +
> +	if (cmd->size_out != 0)
> +		return -EINVAL;
> +
> +	if (mdata->security_state & CXL_PMEM_SEC_STATE_USER_PASS_SET) {
> +		cmd->return_code = CXL_MBOX_CMD_RC_SECURITY;
> +		return -ENXIO;
> +	}
> +	if (mdata->security_state & CXL_PMEM_SEC_STATE_LOCKED) {
> +		cmd->return_code = CXL_MBOX_CMD_RC_SECURITY;
> +		return -ENXIO;
> +	}
> +
> +	return 0; /* assume less than 2 secs, no bg */
> +}
> +
>   static int mock_get_security_state(struct cxl_dev_state *cxlds,
>   				   struct cxl_mbox_cmd *cmd)
>   {
> @@ -924,6 +946,9 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
>   	case CXL_MBOX_OP_GET_HEALTH_INFO:
>   		rc = mock_health_info(cxlds, cmd);
>   		break;
> +	case CXL_MBOX_OP_SANITIZE:
> +		rc = mock_sanitize(cxlds, cmd);
> +		break;
>   	case CXL_MBOX_OP_GET_SECURITY_STATE:
>   		rc = mock_get_security_state(cxlds, cmd);
>   		break;
