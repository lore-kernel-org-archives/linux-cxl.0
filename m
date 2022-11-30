Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DF2C4332F
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Nov 2022 15:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiK3PBj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 30 Nov 2022 10:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiK3PBi (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 30 Nov 2022 10:01:38 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05D64199F
        for <linux-cxl@vger.kernel.org>; Wed, 30 Nov 2022 07:01:36 -0800 (PST)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NMj531JZdz6HJXP;
        Wed, 30 Nov 2022 22:58:31 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 30 Nov 2022 16:01:34 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 30 Nov
 2022 15:01:34 +0000
Date:   Wed, 30 Nov 2022 15:01:33 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 4/5] tools/testing/cxl: Mock the Clear Poison mailbox
 command
Message-ID: <20221130150133.0000310c@Huawei.com>
In-Reply-To: <be25fbaea1dd583b22bb71748331a2b76d0dd62e.1669781852.git.alison.schofield@intel.com>
References: <cover.1669781852.git.alison.schofield@intel.com>
        <be25fbaea1dd583b22bb71748331a2b76d0dd62e.1669781852.git.alison.schofield@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 29 Nov 2022 20:34:36 -0800
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> Mock the clear of poison by deleting the device:address entry from
> the cxl_test array: mock_poison[]. Behave like a real CXL device and do
> not fail if the address is not in the poison list, but offer a dev_dbg()
> message.
> 
> Unlike a real CXL device, no data is written to the address being cleared.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Trivial comment inline. Subject to comment on previous patch about
doing per device injected poison lists...

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  tools/testing/cxl/test/mem.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 98acb9a644df..9d794fbe5ee1 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -48,6 +48,10 @@ static struct cxl_cel_entry mock_cel[] = {
>  		.opcode = cpu_to_le16(CXL_MBOX_OP_INJECT_POISON),
>  		.effect = cpu_to_le16(0),
>  	},
> +	{
> +		.opcode = cpu_to_le16(CXL_MBOX_OP_CLEAR_POISON),
> +		.effect = cpu_to_le16(0),
> +	},
>  };
>  
>  /* See CXL 2.0 Table 181 Get Health Info Output Payload */
> @@ -244,6 +248,35 @@ static bool mock_poison_found(struct cxl_dev_state *cxlds, u64 dpa)
>  	return false;
>  }
>  
> +static bool mock_poison_del(struct cxl_dev_state *cxlds, u64 dpa)
> +{
> +	for (int i = 0; i < MOCK_INJECT_POISON_MAX; i++) {
> +		if (mock_poison[i].cxlds == cxlds &&
> +		    mock_poison[i].dpa == dpa) {
> +			mock_poison[i].cxlds = NULL;
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
> +

Odd blank line. I'd put it after the next line instead.

> +	u64 dpa = le64_to_cpu(pi->address);
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
>  static int mock_inject_poison(struct cxl_dev_state *cxlds,
>  			      struct cxl_mbox_cmd *cmd)
>  {
> @@ -321,6 +354,9 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
>  	case CXL_MBOX_OP_INJECT_POISON:
>  		rc = mock_inject_poison(cxlds, cmd);
>  		break;
> +	case CXL_MBOX_OP_CLEAR_POISON:
> +		rc = mock_clear_poison(cxlds, cmd);
> +		break;
>  	default:
>  		break;
>  	}

