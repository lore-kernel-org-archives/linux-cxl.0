Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF2BC64ED6
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Feb 2023 18:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjB1Sgx (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 28 Feb 2023 13:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjB1Sgw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 28 Feb 2023 13:36:52 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79DF21282
        for <linux-cxl@vger.kernel.org>; Tue, 28 Feb 2023 10:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677609411; x=1709145411;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JpCwfXhQxsiTFquyDUWurFSJtCgQGmVMUkESgLh36Mc=;
  b=jU8joxXWUkAGmbfRAMVDAqlDB5IjKhTu+dOTPIyu+n64GKQ7J73cVT26
   XQ+Sh0ow31KtNo7m5hv8Cp+uRDtjddA47g2OW08Jx3HFgE4LONjSVYZ1c
   Monpb1JJyYfBhMus6Zx+sV/gF1XtKFxZ6lHKR4hhb3gflQ1wVHv449Pc9
   clEznSlc6SQymoseiBRjqs9qtZ/ykgh/2jQv+pcymBAmXlyKfC+FN1/vB
   umUsuxaEyLE0jcqioj6TpUYpWwQumdAVaSYObIFbU0tK17jsQph7oYBgd
   Oxy1KHCitXDuKM85G7kaO22Wx5XcB5GH9h0xR3F6s+2CNRb6ilwkavNpp
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="398999079"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="398999079"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 10:36:51 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10635"; a="676400027"
X-IronPort-AV: E=Sophos;i="5.98,222,1673942400"; 
   d="scan'208";a="676400027"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.1.236]) ([10.212.1.236])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2023 10:36:50 -0800
Message-ID: <df1b155c-0465-1906-b1c9-3427f8291b9b@intel.com>
Date:   Tue, 28 Feb 2023 11:36:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH 7/7] cxl/test: Add "Secure Erase" opcode support
Content-Language: en-US
To:     Davidlohr Bueso <dave@stgolabs.net>, dan.j.williams@intel.com
Cc:     jonathan.cameron@huawei.com, ira.weiny@intel.com,
        fan.ni@samsung.com, a.manzanares@samsung.com,
        linux-cxl@vger.kernel.org
References: <20230224194652.1990604-1-dave@stgolabs.net>
 <20230224194652.1990604-8-dave@stgolabs.net>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230224194652.1990604-8-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 2/24/23 12:46 PM, Davidlohr Bueso wrote:
> Add support to emulate a CXL mem device support the "Secure Erase"
> operation.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   tools/testing/cxl/test/mem.c | 27 +++++++++++++++++++++++++++
>   1 file changed, 27 insertions(+)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index d4466cb27947..8a22a4e592c6 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -519,6 +519,30 @@ static int mock_sanitize(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
>   	return 0; /* assume less than 2 secs, no bg */
>   }
>   
> +static int mock_secure_erase(struct cxl_dev_state *cxlds,
> +			     struct cxl_mbox_cmd *cmd)
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
> +
> +	if (mdata->security_state & CXL_PMEM_SEC_STATE_LOCKED) {
> +		cmd->return_code = CXL_MBOX_CMD_RC_SECURITY;
> +		return -ENXIO;
> +	}
> +
> +	return 0;
> +}
> +
>   static int mock_get_security_state(struct cxl_dev_state *cxlds,
>   				   struct cxl_mbox_cmd *cmd)
>   {
> @@ -949,6 +973,9 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
>   	case CXL_MBOX_OP_SANITIZE:
>   		rc = mock_sanitize(cxlds, cmd);
>   		break;
> +	case CXL_MBOX_OP_SECURE_ERASE:
> +		rc = mock_secure_erase(cxlds, cmd);
> +		break;
>   	case CXL_MBOX_OP_GET_SECURITY_STATE:
>   		rc = mock_get_security_state(cxlds, cmd);
>   		break;
