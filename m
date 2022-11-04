Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EEDC4332F
	for <linux-cxl@archiver.kernel.org>; Fri,  4 Nov 2022 13:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiKDN4l (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 4 Nov 2022 09:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiKDN4k (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 4 Nov 2022 09:56:40 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9858F2F03E
        for <linux-cxl@vger.kernel.org>; Fri,  4 Nov 2022 06:56:37 -0700 (PDT)
Received: from frapeml500006.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4N3hrx12MPz67xjc;
        Fri,  4 Nov 2022 21:52:33 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 frapeml500006.china.huawei.com (7.182.85.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 4 Nov 2022 14:56:35 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 4 Nov
 2022 13:56:34 +0000
Date:   Fri, 4 Nov 2022 13:56:33 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <dan.j.williams@intel.com>, <bwidawsk@kernel.org>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <dave@stgolabs.net>
Subject: Re: [PATCH v2 05/19] tools/testing/cxl: Add "Set Passphrase" opcode
 support
Message-ID: <20221104135633.000069e9@Huawei.com>
In-Reply-To: <166377431828.430546.12996556155261310755.stgit@djiang5-desk3.ch.intel.com>
References: <166377414787.430546.3863229455285366312.stgit@djiang5-desk3.ch.intel.com>
        <166377431828.430546.12996556155261310755.stgit@djiang5-desk3.ch.intel.com>
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

On Wed, 21 Sep 2022 08:31:58 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add support to emulate a CXL mem device supporting the "Set Passphrase"
> operation. The operation supports setting of either a user or a master
> passphrase.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Hi Dave

A few trivial things inline. With them tidied up.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  tools/testing/cxl/test/mem.c       |   66 ++++++++++++++++++++++++++++++++++++
>  tools/testing/cxl/test/mem_pdata.h |    6 +++
>  2 files changed, 72 insertions(+)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 9002a3ae3ea5..86be5e183b5c 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -154,6 +154,69 @@ static int mock_get_security_state(struct cxl_dev_state *cxlds,
>  	return 0;
>  }
>  
> +static int mock_set_passphrase(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
> +{
> +	struct cxl_mock_mem_pdata *mdata = dev_get_platdata(cxlds->dev);
> +	struct cxl_set_pass *set_pass;
> +
> +	if (cmd->size_in != sizeof(*set_pass))
> +		return -EINVAL;
> +
> +	if (cmd->size_out != 0)
> +		return -EINVAL;
> +
> +	if (mdata->security_state & CXL_PMEM_SEC_STATE_FROZEN) {
> +		cmd->return_code = CXL_MBOX_CMD_RC_SECURITY;
> +		return -ENXIO;
> +	}
> +
> +	set_pass = cmd->payload_in;
> +	switch (set_pass->type) {
> +	case CXL_PMEM_SEC_PASS_MASTER:
> +		if (mdata->security_state & CXL_PMEM_SEC_STATE_MASTER_PLIMIT) {
> +			cmd->return_code = CXL_MBOX_CMD_RC_SECURITY;
> +			return -ENXIO;
> +		}
> +		/*
> +		 * CXL spec v2.0 8.2.9.5.6.2, The master pasphrase shall only be set in

Update to 3.0 references.

> +		 * the security disabled state when the user passphrase is not set.
> +		 */
> +		if (mdata->security_state & CXL_PMEM_SEC_STATE_USER_PASS_SET) {
> +			cmd->return_code = CXL_MBOX_CMD_RC_SECURITY;
> +			return -ENXIO;
> +		}
> +		if (memcmp(mdata->master_pass, set_pass->old_pass, NVDIMM_PASSPHRASE_LEN)) {
> +			if (++mdata->master_limit == PASS_TRY_LIMIT)
> +				mdata->security_state |= CXL_PMEM_SEC_STATE_MASTER_PLIMIT;
> +			cmd->return_code = CXL_MBOX_CMD_RC_PASSPHRASE;
> +			return -ENXIO;
> +		}
> +		memcpy(mdata->master_pass, set_pass->new_pass, NVDIMM_PASSPHRASE_LEN);
> +		mdata->security_state |= CXL_PMEM_SEC_STATE_MASTER_PASS_SET;
> +		return 0;
> +
> +	case CXL_PMEM_SEC_PASS_USER:
> +		if (mdata->security_state & CXL_PMEM_SEC_STATE_USER_PLIMIT) {
> +			cmd->return_code = CXL_MBOX_CMD_RC_SECURITY;
> +			return -ENXIO;
> +		}
> +		if (memcmp(mdata->user_pass, set_pass->old_pass, NVDIMM_PASSPHRASE_LEN)) {
> +			if (++mdata->user_limit == PASS_TRY_LIMIT)
> +				mdata->security_state |= CXL_PMEM_SEC_STATE_USER_PLIMIT;
> +			cmd->return_code = CXL_MBOX_CMD_RC_PASSPHRASE;
> +			return -ENXIO;
> +		}
> +		memcpy(mdata->user_pass, set_pass->new_pass, NVDIMM_PASSPHRASE_LEN);
> +		mdata->security_state |= CXL_PMEM_SEC_STATE_USER_PASS_SET;
> +		return 0;
> +
> +	default:
> +		cmd->return_code = CXL_MBOX_CMD_RC_INPUT;
> +		return -EINVAL;
> +	}
> +	return 0;

Unreachable code.

> +}
> +
>  static int mock_get_lsa(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
>  {
>  	struct cxl_mbox_get_lsa *get_lsa = cmd->payload_in;
> @@ -250,6 +313,9 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
>  	case CXL_MBOX_OP_GET_SECURITY_STATE:
>  		rc = mock_get_security_state(cxlds, cmd);
>  		break;
> +	case CXL_MBOX_OP_SET_PASSPHRASE:
> +		rc = mock_set_passphrase(cxlds, cmd);
> +		break;
>  	default:
>  		break;
>  	}
> diff --git a/tools/testing/cxl/test/mem_pdata.h b/tools/testing/cxl/test/mem_pdata.h
> index 6a7b111147eb..8eb2dffc9156 100644
> --- a/tools/testing/cxl/test/mem_pdata.h
> +++ b/tools/testing/cxl/test/mem_pdata.h
> @@ -5,6 +5,12 @@
>  
>  struct cxl_mock_mem_pdata {
>  	u32 security_state;
> +	u8 user_pass[NVDIMM_PASSPHRASE_LEN];
> +	u8 master_pass[NVDIMM_PASSPHRASE_LEN];
> +	int user_limit;
> +	int master_limit;
>  };
>  
> +#define PASS_TRY_LIMIT 3
> +
>  #endif
> 
> 

