Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF30CC77B60
	for <linux-cxl@archiver.kernel.org>; Fri, 31 Mar 2023 19:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbjCaTO7 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 31 Mar 2023 15:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232051AbjCaTOz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 31 Mar 2023 15:14:55 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B21D23B75
        for <linux-cxl@vger.kernel.org>; Fri, 31 Mar 2023 12:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680290088; x=1711826088;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JlegcK+T++X7NkdGcFL3H3wd+eKtkkvcd+CfxdkGyVw=;
  b=XQJsJY8ILnFw6V+eRgs837FMDm0lLCoLBBsfILz5WKeqD3Yt2P5wP1FB
   XAGvgR2nQxYBA36olZVCImOHs5V9/RRpZm1krB/SNH5lQPHgFdGW+HXmI
   k6n2Al9XNIQukVudd596JcP/2GAYbsF3mftVNSEydOHW2wu9L9qkZ8BlX
   MkZ0jdEUXgZrD07M/mnkyCNd/Fqs2FBCU6NaZ293qjL5ATDmzXqzhAHv6
   H/2qUneDlfXIg/YSvy6pHVXnGoWPMvnq3Yy5eMFy6zLCrjZnhuKNftOsV
   y+9XxkZOt7omB/1tQN0DmPHXgWCtLPNM1yBKtMo8AhsYXJkC59A5PC7er
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="340267943"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="340267943"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 12:13:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="1014942958"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="1014942958"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.71.212]) ([10.212.71.212])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 12:13:59 -0700
Message-ID: <705756c5-c0e3-6758-e54b-5d8716de7132@intel.com>
Date:   Fri, 31 Mar 2023 12:13:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v5 08/12] tools/testing/cxl: Mock the Inject Poison
 mailbox command
Content-Language: en-US
To:     alison.schofield@intel.com,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>
Cc:     linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <cover.1679892337.git.alison.schofield@intel.com>
 <fc4ee78a1574ba5a0a7a7c2918af2c0d57012fd5.1679892337.git.alison.schofield@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <fc4ee78a1574ba5a0a7a7c2918af2c0d57012fd5.1679892337.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 3/26/23 10:03 PM, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Mock the injection of poison by storing the device:address entries in
> mock_poison_list[]. Enforce a limit of 8 poison injections per memdev
> device and 128 total entries for the cxl_test mock driver.
> 
> Introducing the mock_poison[] list here, makes it available for use in
> the mock of Clear Poison, and the mock of Get Poison List.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   tools/testing/cxl/test/mem.c | 77 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 77 insertions(+)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 2fa9c18d4c2c..4fca886e2a7c 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -16,6 +16,9 @@
>   #define DEV_SIZE SZ_2G
>   #define EFFECT(x) (1U << x)
>   
> +#define MOCK_INJECT_DEV_MAX 8
> +#define MOCK_INJECT_TEST_MAX 128
> +
>   static struct cxl_cel_entry mock_cel[] = {
>   	{
>   		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_SUPPORTED_LOGS),
> @@ -45,6 +48,10 @@ static struct cxl_cel_entry mock_cel[] = {
>   		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_POISON),
>   		.effect = cpu_to_le16(0),
>   	},
> +	{
> +		.opcode = cpu_to_le16(CXL_MBOX_OP_INJECT_POISON),
> +		.effect = cpu_to_le16(0),
> +	},
>   };
>   
>   /* See CXL 2.0 Table 181 Get Health Info Output Payload */
> @@ -474,6 +481,7 @@ static int mock_id(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
>   			cpu_to_le64(SZ_256M / CXL_CAPACITY_MULTIPLIER),
>   		.total_capacity =
>   			cpu_to_le64(DEV_SIZE / CXL_CAPACITY_MULTIPLIER),
> +		.inject_poison_limit = cpu_to_le16(MOCK_INJECT_DEV_MAX),
>   	};
>   
>   	put_unaligned_le24(CXL_POISON_LIST_MAX, id.poison_list_max_mer);
> @@ -895,6 +903,11 @@ static int mock_health_info(struct cxl_dev_state *cxlds,
>   	return 0;
>   }
>   
> +static struct mock_poison {
> +	struct cxl_dev_state *cxlds;
> +	u64 dpa;
> +} mock_poison_list[MOCK_INJECT_TEST_MAX];
> +
>   static int mock_get_poison(struct cxl_dev_state *cxlds,
>   			   struct cxl_mbox_cmd *cmd)
>   {
> @@ -923,6 +936,67 @@ static int mock_get_poison(struct cxl_dev_state *cxlds,
>   	return 0;
>   }
>   
> +static bool mock_poison_dev_max_injected(struct cxl_dev_state *cxlds)
> +{
> +	int count = 0;
> +
> +	for (int i = 0; i < MOCK_INJECT_TEST_MAX; i++) {
> +		if (mock_poison_list[i].cxlds == cxlds)
> +			count++;
> +	}
> +	return (count >= MOCK_INJECT_DEV_MAX);
> +}
> +
> +static bool mock_poison_add(struct cxl_dev_state *cxlds, u64 dpa)
> +{
> +	if (mock_poison_dev_max_injected(cxlds)) {
> +		dev_dbg(cxlds->dev,
> +			"Device poison injection limit has been reached: %d\n",
> +			MOCK_INJECT_DEV_MAX);
> +		return false;
> +	}
> +
> +	for (int i = 0; i < MOCK_INJECT_TEST_MAX; i++) {
> +		if (!mock_poison_list[i].cxlds) {
> +			mock_poison_list[i].cxlds = cxlds;
> +			mock_poison_list[i].dpa = dpa;
> +			return true;
> +		}
> +	}
> +	dev_dbg(cxlds->dev,
> +		"Mock test poison injection limit has been reached: %d\n",
> +		MOCK_INJECT_TEST_MAX);
> +
> +	return false;
> +}
> +
> +static bool mock_poison_found(struct cxl_dev_state *cxlds, u64 dpa)
> +{
> +	for (int i = 0; i < MOCK_INJECT_TEST_MAX; i++) {
> +		if (mock_poison_list[i].cxlds == cxlds &&
> +		    mock_poison_list[i].dpa == dpa)
> +			return true;
> +	}
> +	return false;
> +}
> +
> +static int mock_inject_poison(struct cxl_dev_state *cxlds,
> +			      struct cxl_mbox_cmd *cmd)
> +{
> +	struct cxl_mbox_inject_poison *pi = cmd->payload_in;
> +	u64 dpa = le64_to_cpu(pi->address);
> +
> +	if (mock_poison_found(cxlds, dpa)) {
> +		/* Not an error to inject poison if already poisoned */
> +		dev_dbg(cxlds->dev, "DPA: 0x%llx already poisoned\n", dpa);
> +		return 0;
> +	}
> +	if (!mock_poison_add(cxlds, dpa))
> +		return -ENXIO;
> +
> +	return 0;
> +}
> +
>   static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
>   {
>   	struct device *dev = cxlds->dev;
> @@ -980,6 +1054,9 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
>   	case CXL_MBOX_OP_GET_POISON:
>   		rc = mock_get_poison(cxlds, cmd);
>   		break;
> +	case CXL_MBOX_OP_INJECT_POISON:
> +		rc = mock_inject_poison(cxlds, cmd);
> +		break;
>   	default:
>   		break;
>   	}
