Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90806C433EF
	for <linux-cxl@archiver.kernel.org>; Thu,  6 Jan 2022 20:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243857AbiAFUgl (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 6 Jan 2022 15:36:41 -0500
Received: from mga05.intel.com ([192.55.52.43]:11888 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235328AbiAFUgk (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 6 Jan 2022 15:36:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641501400; x=1673037400;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yVelUATF6Igdi+X67TBtuiss83chykoEFoW1Q4aIE54=;
  b=bB6JZRO4uv2xD2f6xbyZta6nxepzzS5ZtJ9m9tiGJHCXcn8y/WPJEUyI
   +58PoY2o1JM7B30DpR0Ozfy4LLP29Ta6KbX9SLO/au9qHcSMDV4jKFh9M
   f6l766LGLkNnmDWMOG6Z96Om25VUKhrc1dVw/ZQfyA6GXmUqs13z0fIIX
   al8J2+s7s/KEs/6XRbWEsX1Wue0RHrTLQs0mvnsaLg7PqVg/IM3ItBUZ1
   Yyq4Qi2mEHAbkXMLMDKk/iNRpQTFd9CVg/dWAaJ7bwwAJGNq13NfbBm7V
   1CoN6zmyaF8lrVV0jb09NPRwFAIds1Q4CsBnllE6nEllI2v0R3COBgOQN
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="329077136"
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="329077136"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 12:36:39 -0800
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="527117377"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 12:36:39 -0800
Date:   Thu, 6 Jan 2022 12:36:39 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     alison.schofield@intel.com
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Subject: Re: [ndctl PATCH 2/7] libcxl: add accessors for capacity fields of
 the IDENTIFY command
Message-ID: <20220106203639.GC178135@iweiny-DESK2.sc.intel.com>
Mail-Followup-To: alison.schofield@intel.com,
        Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>, nvdimm@lists.linux.dev,
        linux-cxl@vger.kernel.org
References: <cover.1641233076.git.alison.schofield@intel.com>
 <577012d59f5b6b9754d2ce1147585ce5f91a3108.1641233076.git.alison.schofield@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <577012d59f5b6b9754d2ce1147585ce5f91a3108.1641233076.git.alison.schofield@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Jan 03, 2022 at 12:16:13PM -0800, Schofield, Alison wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> Add accessors to retrieve total capacity, volatile only capacity,
> and persistent only capacity from the IDENTIFY mailbox command.
> These values are useful when partitioning the device.

Reword:

The total capacity, volatile only capacity, and persistent only capacity are
required to properly formulate a set partition info command.

Provide functions to retrieve these values from the IDENTIFY command.  Like the
partition information commands these return the values in bytes.

> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  cxl/libcxl.h       |  3 +++
>  cxl/lib/libcxl.c   | 29 +++++++++++++++++++++++++++++
>  cxl/lib/libcxl.sym |  3 +++
>  3 files changed, 35 insertions(+)
> 
> diff --git a/cxl/libcxl.h b/cxl/libcxl.h
> index 7cf9061..d333b6d 100644
> --- a/cxl/libcxl.h
> +++ b/cxl/libcxl.h
> @@ -68,6 +68,9 @@ int cxl_cmd_get_mbox_status(struct cxl_cmd *cmd);
>  int cxl_cmd_get_out_size(struct cxl_cmd *cmd);
>  struct cxl_cmd *cxl_cmd_new_identify(struct cxl_memdev *memdev);
>  int cxl_cmd_identify_get_fw_rev(struct cxl_cmd *cmd, char *fw_rev, int fw_len);
> +unsigned long long cxl_cmd_identify_get_total_capacity(struct cxl_cmd *cmd);
> +unsigned long long cxl_cmd_identify_get_volatile_only_capacity(struct cxl_cmd *cmd);
> +unsigned long long cxl_cmd_identify_get_persistent_only_capacity(struct cxl_cmd *cmd);
>  unsigned long long cxl_cmd_identify_get_partition_align(struct cxl_cmd *cmd);
>  unsigned int cxl_cmd_identify_get_label_size(struct cxl_cmd *cmd);
>  struct cxl_cmd *cxl_cmd_new_get_health_info(struct cxl_memdev *memdev);
> diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
> index f3d4022..715d8e4 100644
> --- a/cxl/lib/libcxl.c
> +++ b/cxl/lib/libcxl.c
> @@ -1102,6 +1102,35 @@ CXL_EXPORT unsigned int cxl_cmd_identify_get_label_size(struct cxl_cmd *cmd)
>  	return le32_to_cpu(id->lsa_size);
>  }
>  
> +#define cmd_identify_get_capacity_field(cmd, field)			\
> +do {										\
> +	struct cxl_cmd_identify *c =					\
> +		(struct cxl_cmd_identify *)cmd->send_cmd->out.payload;\
> +	int rc = cxl_cmd_validate_status(cmd,					\
> +			CXL_MEM_COMMAND_ID_IDENTIFY);			\
> +	if (rc)									\
> +		return ULLONG_MAX;							\
> +	return le64_to_cpu(c->field) * CXL_CAPACITY_MULTIPLIER;			\
> +} while (0)
> +
> +CXL_EXPORT unsigned long long
> +cxl_cmd_identify_get_total_capacity(struct cxl_cmd *cmd)

Is there someplace that all the libcxl functions are documented?  Like the
other functions I would like to ensure the user knows these are returning
values in bytes.

Ira

> +{
> +	cmd_identify_get_capacity_field(cmd, total_capacity);
> +}
> +
> +CXL_EXPORT unsigned long long
> +cxl_cmd_identify_get_volatile_only_capacity(struct cxl_cmd *cmd)
> +{
> +	cmd_identify_get_capacity_field(cmd, volatile_capacity);
> +}
> +
> +CXL_EXPORT unsigned long long
> +cxl_cmd_identify_get_persistent_only_capacity(struct cxl_cmd *cmd)
> +{
> +	cmd_identify_get_capacity_field(cmd, persistent_capacity);
> +}
> +
>  CXL_EXPORT struct cxl_cmd *cxl_cmd_new_raw(struct cxl_memdev *memdev,
>  		int opcode)
>  {
> diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
> index 09d6d94..bed6427 100644
> --- a/cxl/lib/libcxl.sym
> +++ b/cxl/lib/libcxl.sym
> @@ -31,6 +31,9 @@ global:
>  	cxl_cmd_get_out_size;
>  	cxl_cmd_new_identify;
>  	cxl_cmd_identify_get_fw_rev;
> +	cxl_cmd_identify_get_total_capacity;
> +	cxl_cmd_identify_get_volatile_only_capacity;
> +	cxl_cmd_identify_get_persistent_only_capacity;
>  	cxl_cmd_identify_get_partition_align;
>  	cxl_cmd_identify_get_label_size;
>  	cxl_cmd_new_get_health_info;
> -- 
> 2.31.1
> 
