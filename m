Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC30C433E0
	for <linux-cxl@archiver.kernel.org>; Mon, 22 Feb 2021 22:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3998464E02
	for <linux-cxl@archiver.kernel.org>; Mon, 22 Feb 2021 22:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbhBVWDP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 22 Feb 2021 17:03:15 -0500
Received: from mga02.intel.com ([134.134.136.20]:47781 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229967AbhBVWDJ (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 22 Feb 2021 17:03:09 -0500
IronPort-SDR: IioxDCFJKv6GI/gOY7U5TFrluk5f+JGn+QPprcAOLfHrfQFkrywknQsiSxe/QpKrjtzf2dq+Ve
 BgdD+GhnmD5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9903"; a="171749215"
X-IronPort-AV: E=Sophos;i="5.81,198,1610438400"; 
   d="scan'208";a="171749215"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2021 14:02:11 -0800
IronPort-SDR: YftrhDX6sHpW32kENyEx1dADdvh2k5RGYYAUjMK9ZgGkvArts+EU34qZVd/mqgg0V5+154ysyc
 YFuz1bWDHWBQ==
X-IronPort-AV: E=Sophos;i="5.81,198,1610438400"; 
   d="scan'208";a="402811919"
Received: from hlgebhar-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.134.144])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2021 14:02:10 -0800
Date:   Mon, 22 Feb 2021 14:02:09 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-nvdimm@lists.01.org,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [ndctl PATCH v2 04/13] libcxl: add support for the 'Identify
 Device' command
Message-ID: <20210222220209.62pvejo6mxhcqqth@intel.com>
References: <20210219020331.725687-1-vishal.l.verma@intel.com>
 <20210219020331.725687-5-vishal.l.verma@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210219020331.725687-5-vishal.l.verma@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-02-18 19:03:22, Vishal Verma wrote:
> Add APIs to allocate and send an 'Identify Device' command, and
> accessors to retrieve some of the fields from the resulting data.
> 
> Only add a handful accessor functions; more can be added as the need
> arises. The fields added are fw_revision, partition_align, and
> lsa_size.
> 

How do we feel about for each command the ability to return n bytes as an opaque
object? That way, if some client application wants more of the identify data
they can get it without needing library API to do it.

/**
 * cxl_cmd_identify_get_payload() - Return output payload
 * @cmd: Identify command.
 * @n: Max number of bytes to return.
 * @out: Buffer to copy to.
 *
 * Returns actual number of bytes copied out.
 *
 * Returns up to n bytes in (CXL native format) of data from the output payload
 * of the identify command.
 */
CXL_EXPORT unsigned int
cxl_cmd_identify_get_payload(struct cxl_cmd *cmd, unsigned int n, void *out)
{
}

I recall discussing this briefly, but I don't recall what we had decided.

> Cc: Ben Widawsky <ben.widawsky@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> ---
>  cxl/lib/private.h  | 19 ++++++++++++++++++
>  cxl/lib/libcxl.c   | 49 ++++++++++++++++++++++++++++++++++++++++++++++
>  cxl/libcxl.h       |  4 ++++
>  cxl/lib/libcxl.sym |  4 ++++
>  4 files changed, 76 insertions(+)
> 
> diff --git a/cxl/lib/private.h b/cxl/lib/private.h
> index 87ca17e..3273f21 100644
> --- a/cxl/lib/private.h
> +++ b/cxl/lib/private.h
> @@ -54,6 +54,25 @@ struct cxl_cmd {
>  	int status;
>  };
>  
> +#define CXL_CMD_IDENTIFY_FW_REV_LENGTH 0x10
> +
> +struct cxl_cmd_identify {
> +	char fw_revision[CXL_CMD_IDENTIFY_FW_REV_LENGTH];
> +	le64 total_capacity;
> +	le64 volatile_capacity;
> +	le64 persistent_capacity;
> +	le64 partition_align;
> +	le16 info_event_log_size;
> +	le16 warning_event_log_size;
> +	le16 failure_event_log_size;
> +	le16 fatal_event_log_size;
> +	le32 lsa_size;
> +	u8 poison_list_max_mer[3];
> +	le16 inject_poison_limit;
> +	u8 poison_caps;
> +	u8 qos_telemetry_caps;
> +} __attribute__((packed));
> +
>  static inline int check_kmod(struct kmod_ctx *kmod_ctx)
>  {
>  	return kmod_ctx ? 0 : -ENXIO;
> diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
> index f1155a1..4751cba 100644
> --- a/cxl/lib/libcxl.c
> +++ b/cxl/lib/libcxl.c
> @@ -13,7 +13,10 @@
>  #include <sys/sysmacros.h>
>  #include <uuid/uuid.h>
>  #include <ccan/list/list.h>
> +#include <ccan/endian/endian.h>
> +#include <ccan/minmax/minmax.h>
>  #include <ccan/array_size/array_size.h>
> +#include <ccan/short_types/short_types.h>
>  
>  #include <util/log.h>
>  #include <util/sysfs.h>
> @@ -675,6 +678,52 @@ CXL_EXPORT const char *cxl_cmd_get_devname(struct cxl_cmd *cmd)
>  	return cxl_memdev_get_devname(cmd->memdev);
>  }
>  
> +CXL_EXPORT struct cxl_cmd *cxl_cmd_new_identify(struct cxl_memdev *memdev)
> +{
> +	return cxl_cmd_new_generic(memdev, CXL_MEM_COMMAND_ID_IDENTIFY);
> +}
> +
> +CXL_EXPORT int cxl_cmd_identify_get_fw_rev(struct cxl_cmd *cmd, char *fw_rev,
> +		int fw_len)
> +{
> +	struct cxl_cmd_identify *id = (void *)cmd->send_cmd->out.payload;
> +
> +	if (cmd->send_cmd->id != CXL_MEM_COMMAND_ID_IDENTIFY)
> +		return -EINVAL;
> +	if (cmd->status < 0)
> +		return cmd->status;
> +
> +	if (fw_len > 0)
> +		memcpy(fw_rev, id->fw_revision,
> +			min(fw_len, CXL_CMD_IDENTIFY_FW_REV_LENGTH));
> +	return 0;
> +}
> +
> +CXL_EXPORT unsigned long long cxl_cmd_identify_get_partition_align(
> +		struct cxl_cmd *cmd)
> +{
> +	struct cxl_cmd_identify *id = (void *)cmd->send_cmd->out.payload;
> +
> +	if (cmd->send_cmd->id != CXL_MEM_COMMAND_ID_IDENTIFY)
> +		return -EINVAL;
> +	if (cmd->status < 0)
> +		return cmd->status;
> +
> +	return le64_to_cpu(id->partition_align);
> +}
> +
> +CXL_EXPORT unsigned int cxl_cmd_identify_get_lsa_size(struct cxl_cmd *cmd)
> +{
> +	struct cxl_cmd_identify *id = (void *)cmd->send_cmd->out.payload;
> +
> +	if (cmd->send_cmd->id != CXL_MEM_COMMAND_ID_IDENTIFY)
> +		return -EINVAL;
> +	if (cmd->status < 0)
> +		return cmd->status;
> +
> +	return le32_to_cpu(id->lsa_size);
> +}
> +
>  CXL_EXPORT struct cxl_cmd *cxl_cmd_new_raw(struct cxl_memdev *memdev,
>  		int opcode)
>  {
> diff --git a/cxl/libcxl.h b/cxl/libcxl.h
> index 6e87b80..9ed8c83 100644
> --- a/cxl/libcxl.h
> +++ b/cxl/libcxl.h
> @@ -58,6 +58,10 @@ void cxl_cmd_unref(struct cxl_cmd *cmd);
>  int cxl_cmd_submit(struct cxl_cmd *cmd);
>  int cxl_cmd_get_mbox_status(struct cxl_cmd *cmd);
>  int cxl_cmd_get_out_size(struct cxl_cmd *cmd);
> +struct cxl_cmd *cxl_cmd_new_identify(struct cxl_memdev *memdev);
> +int cxl_cmd_identify_get_fw_rev(struct cxl_cmd *cmd, char *fw_rev, int fw_len);
> +unsigned long long cxl_cmd_identify_get_partition_align(struct cxl_cmd *cmd);
> +unsigned int cxl_cmd_identify_get_lsa_size(struct cxl_cmd *cmd);
>  
>  #ifdef __cplusplus
>  } /* extern "C" */
> diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
> index 493429c..d6aa0b2 100644
> --- a/cxl/lib/libcxl.sym
> +++ b/cxl/lib/libcxl.sym
> @@ -39,4 +39,8 @@ global:
>  	cxl_cmd_submit;
>  	cxl_cmd_get_mbox_status;
>  	cxl_cmd_get_out_size;
> +	cxl_cmd_new_identify;
> +	cxl_cmd_identify_get_fw_rev;
> +	cxl_cmd_identify_get_partition_align;
> +	cxl_cmd_identify_get_lsa_size;
>  } LIBCXL_2;
> -- 
> 2.29.2
> 
