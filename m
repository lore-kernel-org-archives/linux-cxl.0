Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3055C761A6
	for <linux-cxl@archiver.kernel.org>; Fri, 31 Mar 2023 19:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjCaTP0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 31 Mar 2023 15:15:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231539AbjCaTPZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 31 Mar 2023 15:15:25 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F571EFCA
        for <linux-cxl@vger.kernel.org>; Fri, 31 Mar 2023 12:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680290124; x=1711826124;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gskc3B0UJpAjvV0aGEmNeqLH61I6l3k6RcpFPHsBi6A=;
  b=S9VMwqGuCcI7SMmxw7UvXm2mR883SsdFb+8uaDoKFMkib3CA5VlFxO7j
   1KCfHMS7RgT52Ceh6i0ekzsEGAuh6UCsUqibnRznAcyah5SugR42/hFAK
   OHwOcHdWnZmPA+CgNUq7KzPZ6KLmWq3t3dqyuXJKnoimETnM8h1u+I4yI
   t+5ciXlA18cwSqfLoXSVK5PBBAhof6zRaU7UNXtnaRzOtYGnsP2tlMMTL
   c2zlM4M1mYjtOdqnOLYe3Nk7abYFRWyCVc3VGCm/siaJmLxXFE8B0MRFu
   NtMZYICcp6D4BwYoCwxsYJ2QPLYmj6ObFhsqKhHOfo6G/ob48xRlLjJ7H
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="340268112"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="340268112"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 12:15:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="1014943481"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="1014943481"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.71.212]) ([10.212.71.212])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 12:15:03 -0700
Message-ID: <3306f9b8-49ba-eaae-1c3c-d2fec52aceed@intel.com>
Date:   Fri, 31 Mar 2023 12:15:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v5 09/12] tools/testing/cxl: Mock the Clear Poison mailbox
 command
Content-Language: en-US
To:     alison.schofield@intel.com,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>
Cc:     linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <cover.1679892337.git.alison.schofield@intel.com>
 <e2145b982de1d862188c725e7320f3a27d807db7.1679892337.git.alison.schofield@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <e2145b982de1d862188c725e7320f3a27d807db7.1679892337.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 3/26/23 10:03 PM, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Mock the clear of poison by deleting the device:address entry from
> the mock_poison_list[]. Behave like a real CXL device and do not fail
> if the address is not in the poison list, but offer a dev_dbg()
> message.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   tools/testing/cxl/test/mem.c | 36 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 36 insertions(+)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 4fca886e2a7c..720147c7cb2b 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -52,6 +52,10 @@ static struct cxl_cel_entry mock_cel[] = {
>   		.opcode = cpu_to_le16(CXL_MBOX_OP_INJECT_POISON),
>   		.effect = cpu_to_le16(0),
>   	},
> +	{
> +		.opcode = cpu_to_le16(CXL_MBOX_OP_CLEAR_POISON),
> +		.effect = cpu_to_le16(0),
> +	},
>   };
>   
>   /* See CXL 2.0 Table 181 Get Health Info Output Payload */
> @@ -997,6 +1001,35 @@ static int mock_inject_poison(struct cxl_dev_state *cxlds,
>   	return 0;
>   }
>   
> +static bool mock_poison_del(struct cxl_dev_state *cxlds, u64 dpa)
> +{
> +	for (int i = 0; i < MOCK_INJECT_TEST_MAX; i++) {
> +		if (mock_poison_list[i].cxlds == cxlds &&
> +		    mock_poison_list[i].dpa == dpa) {
> +			mock_poison_list[i].cxlds = NULL;
> +			return true;
> +		}
> +	}
> +	return false;
> +}
> +
> +static int mock_clear_poison(struct cxl_dev_state *cxlds,
> +			     struct cxl_mbox_cmd *cmd)
> +{
> +	struct cxl_mbox_clear_poison *pi = cmd->payload_in;
> +	u64 dpa = le64_to_cpu(pi->address);
> +
> +	/*
> +	 * A real CXL device will write pi->write_data to the address
> +	 * being cleared. In this mock, just delete this address from
> +	 * the mock poison list.
> +	 */
> +	if (!mock_poison_del(cxlds, dpa))
> +		dev_dbg(cxlds->dev, "DPA: 0x%llx not in poison list\n", dpa);
> +
> +	return 0;
> +}
> +
>   static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
>   {
>   	struct device *dev = cxlds->dev;
> @@ -1057,6 +1090,9 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
>   	case CXL_MBOX_OP_INJECT_POISON:
>   		rc = mock_inject_poison(cxlds, cmd);
>   		break;
> +	case CXL_MBOX_OP_CLEAR_POISON:
> +		rc = mock_clear_poison(cxlds, cmd);
> +		break;
>   	default:
>   		break;
>   	}
