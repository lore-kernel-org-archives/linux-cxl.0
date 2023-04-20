Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1684CC77B73
	for <linux-cxl@archiver.kernel.org>; Thu, 20 Apr 2023 16:10:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjDTQKt (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 20 Apr 2023 12:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbjDTQKs (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 20 Apr 2023 12:10:48 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D418139
        for <linux-cxl@vger.kernel.org>; Thu, 20 Apr 2023 09:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682007047; x=1713543047;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vudFG8vTT63cpzvookdTLaapKaXf8t8nFKf1nP3Rn5w=;
  b=byfUf9M6uHf56y2R/lZ2Si1HyA+B1B/eYFGvdU/Z+sMBkmhbpBFnq8qv
   tEYb5HWJaFyAF8p06nREBfwDenWM8pMC6suhpjU7b9GSAXu3J/BU9FTCv
   dNOBROzrOKfVIN7X1ltyZ3FYMYVAFpLtIlBPLMwveNLH61tdlw/BBLsbM
   rJlKBbMhRhMVBrlnRgdJnAGeKIVAa/MfCOLQ/DwJMNPT7KTwBbIw7iM90
   grJxVn+ibP3i42ORMIyQFanq/Y9CHQv/X1elLw6ywaFOmMq6aLZFcvj2b
   nNi7+kDB8KiAuvnHgrCRM/2CiIT8iA6J7/MPonfLUG3FpOr5xlMUkaiNs
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="347649171"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="347649171"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 09:05:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10686"; a="724469422"
X-IronPort-AV: E=Sophos;i="5.99,213,1677571200"; 
   d="scan'208";a="724469422"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.255.228.224])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2023 09:05:53 -0700
Date:   Thu, 20 Apr 2023 09:05:51 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     vishal.l.verma@intel.com, linux-cxl@vger.kernel.org
Subject: Re: [NDCTL PATCH 1/3] ndctl: Add QTG ID support for the root decoder
Message-ID: <ZEFi38e2OTg1flyj@aschofie-mobl2>
References: <168149412855.4013891.16386221304030694671.stgit@djiang5-mobl3>
 <168149418140.4013891.18368466862769013304.stgit@djiang5-mobl3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168149418140.4013891.18368466862769013304.stgit@djiang5-mobl3>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Apr 14, 2023 at 10:43:01AM -0700, Dave Jiang wrote:
> Add libcxl API to retrieve the QoS Throttling Group (QTG) ID for the root
> decoder. Also add support to display the QTG ID for the root decoder
> through the 'cxl list' command.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  cxl/json.c         |   10 ++++++++++
>  cxl/lib/libcxl.c   |   11 +++++++++++
>  cxl/lib/libcxl.sym |    1 +
>  cxl/lib/private.h  |    1 +
>  cxl/libcxl.h       |    3 +++
>  5 files changed, 26 insertions(+)
> 
> diff --git a/cxl/json.c b/cxl/json.c
> index e87bdd49a776..8dd65f942c6a 100644
> --- a/cxl/json.c
> +++ b/cxl/json.c
> @@ -760,6 +760,16 @@ struct json_object *util_cxl_decoder_to_json(struct cxl_decoder *decoder,
>  					       jobj);
>  	}
>  
> +	if (cxl_port_is_root(port)) {
> +		int qtg_id = cxl_decoder_get_qtg_id(decoder);
> +
> +		if (qtg_id != CXL_QTG_ID_NONE) {
> +			jobj = json_object_new_int(qtg_id);
> +			if (jobj)
> +				json_object_object_add(jdecoder, "qtg_id", jobj);
> +		}
> +	}

IIUC,
- root decoders don't always have a valid qtg_id, and the field is
omitted from the listing in that case.
- memdev's (next patch) always have a valid (not -1) qtg_id.

I guess it's customary, in cxl list, to not display empty fields.
Well, that was my question and I think I answered it ;)

Alison

> +
>  	json_object_set_userdata(jdecoder, decoder, NULL);
>  	return jdecoder;
>  }
> diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
> index 59e5bdbcc750..26985c9344b4 100644
> --- a/cxl/lib/libcxl.c
> +++ b/cxl/lib/libcxl.c
> @@ -1879,6 +1879,12 @@ static void *add_cxl_decoder(void *parent, int id, const char *cxldecoder_base)
>  	else
>  		decoder->interleave_ways = strtoul(buf, NULL, 0);
>  
> +	sprintf(path, "%s/qtg_id", cxldecoder_base);
> +	if (sysfs_read_attr(ctx, path, buf) < 0)
> +		decoder->qtg_id = CXL_QTG_ID_NONE;
> +	else
> +		decoder->qtg_id = atoi(buf);
> +
>  	switch (port->type) {
>  	case CXL_PORT_ENDPOINT:
>  		sprintf(path, "%s/dpa_resource", cxldecoder_base);
> @@ -2073,6 +2079,11 @@ CXL_EXPORT unsigned long long cxl_decoder_get_size(struct cxl_decoder *decoder)
>  	return decoder->size;
>  }
>  
> +CXL_EXPORT int cxl_decoder_get_qtg_id(struct cxl_decoder *decoder)
> +{
> +	return decoder->qtg_id;
> +}
> +
>  CXL_EXPORT unsigned long long
>  cxl_decoder_get_dpa_resource(struct cxl_decoder *decoder)
>  {
> diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
> index 1c6177c7dcae..d1c61f9252fe 100644
> --- a/cxl/lib/libcxl.sym
> +++ b/cxl/lib/libcxl.sym
> @@ -248,4 +248,5 @@ global:
>  	cxl_region_get_mode;
>  	cxl_decoder_create_ram_region;
>  	cxl_region_get_daxctl_region;
> +	cxl_decoder_get_qtg_id;
>  } LIBCXL_4;
> diff --git a/cxl/lib/private.h b/cxl/lib/private.h
> index d648992b808d..ac6f111b5956 100644
> --- a/cxl/lib/private.h
> +++ b/cxl/lib/private.h
> @@ -126,6 +126,7 @@ struct cxl_decoder {
>  	struct list_head targets;
>  	struct list_head regions;
>  	struct list_head stale_regions;
> +	int qtg_id;
>  };
>  
>  enum cxl_decode_state {
> diff --git a/cxl/libcxl.h b/cxl/libcxl.h
> index 54d9f10537dd..66ce4a021c62 100644
> --- a/cxl/libcxl.h
> +++ b/cxl/libcxl.h
> @@ -135,6 +135,8 @@ struct cxl_dport *cxl_port_get_dport_by_memdev(struct cxl_port *port,
>  	for (dport = cxl_dport_get_first(port); dport != NULL;                 \
>  	     dport = cxl_dport_get_next(dport))
>  
> +#define CXL_QTG_ID_NONE		-1
> +
>  struct cxl_decoder;
>  struct cxl_decoder *cxl_decoder_get_first(struct cxl_port *port);
>  struct cxl_decoder *cxl_decoder_get_next(struct cxl_decoder *decoder);
> @@ -146,6 +148,7 @@ unsigned long long cxl_decoder_get_dpa_resource(struct cxl_decoder *decoder);
>  unsigned long long cxl_decoder_get_dpa_size(struct cxl_decoder *decoder);
>  unsigned long long
>  cxl_decoder_get_max_available_extent(struct cxl_decoder *decoder);
> +int cxl_decoder_get_qtg_id(struct cxl_decoder *decoder);
>  
>  enum cxl_decoder_mode {
>  	CXL_DECODER_MODE_NONE,
> 
> 
