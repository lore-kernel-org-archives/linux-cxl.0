Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91D2C77B7C
	for <linux-cxl@archiver.kernel.org>; Thu, 11 May 2023 15:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238499AbjEKPJ0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 May 2023 11:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238498AbjEKPJZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 May 2023 11:09:25 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668097EF5
        for <linux-cxl@vger.kernel.org>; Thu, 11 May 2023 08:09:16 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QHFdm31wJz67PyS;
        Thu, 11 May 2023 23:08:28 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 11 May
 2023 16:09:13 +0100
Date:   Thu, 11 May 2023 16:09:13 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <alison.schofield@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <fan.ni@samsung.com>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 5/7] cxl/test: Add Sanitize opcode support
Message-ID: <20230511160913.00005937@Huawei.com>
In-Reply-To: <20230421092321.12741-6-dave@stgolabs.net>
References: <20230421092321.12741-1-dave@stgolabs.net>
        <20230421092321.12741-6-dave@stgolabs.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 21 Apr 2023 02:23:19 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Add support to emulate the "Sanitize" operation, without
> incurring in the background.
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  tools/testing/cxl/test/mem.c | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 9263b04d35f7..d4466cb27947 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -497,6 +497,28 @@ static int mock_partition_info(struct cxl_dev_state *cxlds,
>  	return 0;
>  }
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

Boring ;)

Otherwise this looks fine to me though note I'm far from an expert on the test modules.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> +}
> +
>  static int mock_get_security_state(struct cxl_dev_state *cxlds,
>  				   struct cxl_mbox_cmd *cmd)
>  {
> @@ -924,6 +946,9 @@ static int cxl_mock_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *
>  	case CXL_MBOX_OP_GET_HEALTH_INFO:
>  		rc = mock_health_info(cxlds, cmd);
>  		break;
> +	case CXL_MBOX_OP_SANITIZE:
> +		rc = mock_sanitize(cxlds, cmd);
> +		break;
>  	case CXL_MBOX_OP_GET_SECURITY_STATE:
>  		rc = mock_get_security_state(cxlds, cmd);
>  		break;

