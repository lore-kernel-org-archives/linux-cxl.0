Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A272C433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 15 Oct 2021 16:09:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2E2F61090
	for <linux-cxl@archiver.kernel.org>; Fri, 15 Oct 2021 16:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237004AbhJOQLp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 15 Oct 2021 12:11:45 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3983 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236932AbhJOQLp (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 15 Oct 2021 12:11:45 -0400
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HWB3M2H1fz67Lnh;
        Sat, 16 Oct 2021 00:06:39 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 15 Oct 2021 18:09:36 +0200
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 15 Oct
 2021 17:09:36 +0100
Date:   Fri, 15 Oct 2021 17:09:33 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Vishal Verma <vishal.l.verma@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH v2] tools/testing/cxl: add mock output for the
 GET_HEALTH_INFO command
Message-ID: <20211015170933.00005eb5@Huawei.com>
In-Reply-To: <20211011222826.184775-1-vishal.l.verma@intel.com>
References: <20211011222826.184775-1-vishal.l.verma@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml727-chm.china.huawei.com (10.201.108.78) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 11 Oct 2021 16:28:26 -0600
Vishal Verma <vishal.l.verma@intel.com> wrote:

> Add mocked health information for cxl_test memdevs. This allows
> cxl-cli's 'list' command to display the canned health_info fields.
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

Hi Vishal,

Small issue with cpu_to_le16() for 32 bit le fields.
With that fixed.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  tools/testing/cxl/test/mem.c | 48 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> v2:
> - Move the health_info struct definition into tools/testing since the
>   mock driver is currently the only user (Dan)
> - Add comments for the various status fields describing the flags being
>   set (Dan)
> - Add a size check before copying the cmd buffer (Dan)
> 
> diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
> index 12a8437a9ca0..60264a18d3ca 100644
> --- a/tools/testing/cxl/test/mem.c
> +++ b/tools/testing/cxl/test/mem.c
> @@ -28,8 +28,24 @@ static struct cxl_cel_entry mock_cel[] = {
>  		.opcode = cpu_to_le16(CXL_MBOX_OP_SET_LSA),
>  		.effect = cpu_to_le16(EFFECT(1) | EFFECT(2)),
>  	},
> +	{
> +		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_HEALTH_INFO),
> +		.effect = cpu_to_le16(0),
> +	},
>  };
>  
> +/* See CXL 2.0 Table 181 Get Health Info Output Payload */
> +struct cxl_mbox_health_info {
> +	u8 health_status;
> +	u8 media_status;
> +	u8 ext_status;
> +	u8 life_used;
> +	__le16 temperature;
> +	__le32 dirty_shutdowns;
> +	__le32 volatile_errors;
> +	__le32 pmem_errors;
> +} __packed;
> +
>  static struct {
>  	struct cxl_mbox_get_supported_logs gsl;
>  	struct cxl_gsl_entry entry;
> @@ -156,6 +172,35 @@ static int mock_set_lsa(struct cxl_mem *cxlm, struct cxl_mbox_cmd *cmd)
>  	return 0;
>  }
>  
> +static int mock_health_info(struct cxl_mem *cxlm, struct cxl_mbox_cmd *cmd)
> +{
> +	struct cxl_mbox_health_info health_info = {
> +		/* set flags for maint needed, perf degraded, hw replacement */
> +		.health_status = 0x7,
> +		/* set media status to "All Data Lost" */
> +		.media_status = 0x3,
> +		/*
> +		 * set ext_status flags for:
> +		 *  ext_life_used: normal,
> +		 *  ext_temperature: critical,
> +		 *  ext_corrected_volatile: warning,
> +		 *  ext_corrected_persistent: normal,
> +		 */
> +		.ext_status = 0x18,
> +		.life_used = 15,
> +		.temperature = cpu_to_le16(25),
> +		.dirty_shutdowns = cpu_to_le16(10),

32 bit field as are the next two so I would assume
cpu_to_le32() is the more appropriate call.

> +		.volatile_errors = cpu_to_le16(20),
> +		.pmem_errors = cpu_to_le16(30),
> +	};
> +
> +	if (cmd->size_out < sizeof(health_info))
> +		return -EINVAL;
> +
> +	memcpy(cmd->payload_out, &health_info, sizeof(health_info));
> +	return 0;
> +}
> +
>  static int cxl_mock_mbox_send(struct cxl_mem *cxlm, struct cxl_mbox_cmd *cmd)
>  {
>  	struct device *dev = cxlm->dev;
> @@ -177,6 +222,9 @@ static int cxl_mock_mbox_send(struct cxl_mem *cxlm, struct cxl_mbox_cmd *cmd)
>  	case CXL_MBOX_OP_SET_LSA:
>  		rc = mock_set_lsa(cxlm, cmd);
>  		break;
> +	case CXL_MBOX_OP_GET_HEALTH_INFO:
> +		rc = mock_health_info(cxlm, cmd);
> +		break;
>  	default:
>  		break;
>  	}
> 
> base-commit: ed97afb53365cd03dde266c9644334a558fe5a16

