Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7414C76196
	for <linux-cxl@archiver.kernel.org>; Fri, 31 Mar 2023 19:16:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbjCaTQR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 31 Mar 2023 15:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjCaTQQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 31 Mar 2023 15:16:16 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15DDD53A
        for <linux-cxl@vger.kernel.org>; Fri, 31 Mar 2023 12:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680290175; x=1711826175;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=F3+SZ+j+TOITkOoWyVPApuj2HyvuP4tRnHwewLAaGW4=;
  b=gOQSiTcrDLkNLaBjNf1l/8dEVVkMGICJnESq3VK2NDak/WWqB4JxR9Aw
   Q8BG3OXgLI1FQ917qPYwtiDAj66rhKhF0+ATfX2Z5okFIKWvm2OqTQZZk
   6Oi56GRf8uwWbG+HpyFR/5MWy+cotb1wAJMYWlpXbcv60L+HhDqWsVEjK
   wBqLD55yrsfZvjNIo00JhxUN50OLn/z9V9CcM8L2RKI08elK9EnYtLLY7
   sXLyyRZZIwpCSzAoF5f/2lAxznPtl+h4Ukr4+Qz0NeKUpFeyMR8fFWD8b
   3wCNaknvMxM+HoX/57pWnYo7MNy8fIyuHGyZd2IH2CG4Qfz4uIO+ynmv3
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="427819823"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="427819823"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 12:16:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10666"; a="809138184"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="809138184"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.71.212]) ([10.212.71.212])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 12:16:14 -0700
Message-ID: <12774750-1b79-a488-c03c-ea63b9b0ea86@intel.com>
Date:   Fri, 31 Mar 2023 12:16:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v5 10/12] tools/testing/cxl: Use injected poison for get
 poison list
Content-Language: en-US
To:     alison.schofield@intel.com,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>
Cc:     linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <cover.1679892337.git.alison.schofield@intel.com>
 <ff7b560914fbb6e1a28705ad249cd40145832e3b.1679892337.git.alison.schofield@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <ff7b560914fbb6e1a28705ad249cd40145832e3b.1679892337.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 3/26/23 10:03 PM, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Prior to poison inject support, the mock of 'Get Poison List'
> returned a poison list containing a single mocked error record.
> 
> Following the addition of poison inject and clear support to the
> mock driver, use the mock_poison_list[], rather than faking an
> error record. Mock_poison_list[] list tracks the actual poison
> inject and clear requests issued by userspace.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   tools/testing/cxl/test/mem.c | 59 ++++++++++++++++++++++++------------
>   1 file changed, 40 insertions(+), 19 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 720147c7cb2b..9658d95236b7 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -912,31 +912,52 @@ static struct mock_poison {
>   	u64 dpa;
>   } mock_poison_list[MOCK_INJECT_TEST_MAX];
>   
> +static struct cxl_mbox_poison_payload_out
> +*cxl_get_injected_po(struct cxl_dev_state *cxlds, u64 offset, u64 length)
> +{
> +	struct cxl_mbox_poison_payload_out *po;
> +	int nr_records = 0;
> +	u64 dpa;
> +
> +	po = kzalloc(struct_size(po, record, MOCK_INJECT_DEV_MAX), GFP_KERNEL);
> +	if (!po)
> +		return NULL;
> +
> +	for (int i = 0; i < MOCK_INJECT_TEST_MAX; i++) {
> +		if (mock_poison_list[i].cxlds != cxlds)
> +			continue;
> +		if (mock_poison_list[i].dpa < offset ||
> +		    mock_poison_list[i].dpa > offset + length - 1)
> +			continue;
> +
> +		dpa = mock_poison_list[i].dpa + CXL_POISON_SOURCE_INJECTED;
> +		po->record[nr_records].address = cpu_to_le64(dpa);
> +		po->record[nr_records].length = cpu_to_le32(1);
> +		nr_records++;
> +		if (nr_records == MOCK_INJECT_DEV_MAX)
> +			break;
> +	}
> +
> +	/* Always return count, even when zero */
> +	po->count = cpu_to_le16(nr_records);
> +
> +	return po;
> +}
> +
>   static int mock_get_poison(struct cxl_dev_state *cxlds,
>   			   struct cxl_mbox_cmd *cmd)
>   {
>   	struct cxl_mbox_poison_payload_in *pi = cmd->payload_in;
> +	struct cxl_mbox_poison_payload_out *po;
> +	u64 offset = le64_to_cpu(pi->offset);
> +	u64 length = le64_to_cpu(pi->length);
> +	int nr_records;
>   
> -	/* Mock one poison record at pi.offset for 64 bytes */
> -	struct {
> -		struct cxl_mbox_poison_payload_out po;
> -		struct cxl_poison_record record;
> -	} __packed mock_plist = {
> -		.po = {
> -			.count = cpu_to_le16(1),
> -		},
> -		.record = {
> -			.length = cpu_to_le32(1),
> -			.address = cpu_to_le64(le64_to_cpu(pi->offset) +
> -					       CXL_POISON_SOURCE_INJECTED),
> -		},
> -	};
> +	po = cxl_get_injected_po(cxlds, offset, length);
> +	nr_records = le16_to_cpu(po->count);
> +	memcpy(cmd->payload_out, po, struct_size(po, record, nr_records));
> +	cmd->size_out = struct_size(po, record, nr_records);
>   
> -	if (cmd->size_out < sizeof(mock_plist))
> -		return -EINVAL;
> -
> -	memcpy(cmd->payload_out, &mock_plist, sizeof(mock_plist));
> -	cmd->size_out = sizeof(mock_plist);
>   	return 0;
>   }
>   
