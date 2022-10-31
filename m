Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27327ECAAA1
	for <linux-cxl@archiver.kernel.org>; Mon, 31 Oct 2022 20:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiJaUBd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 31 Oct 2022 16:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiJaUBb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 31 Oct 2022 16:01:31 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30EB213F87
        for <linux-cxl@vger.kernel.org>; Mon, 31 Oct 2022 13:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667246489; x=1698782489;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MNJ331u+lmsyTsz4gwze2BvoOMaXQaVyac15dNLO7/c=;
  b=eC3sLr2vUhlJ1ttavgP6mNdBVXjlV4EtViM1UvvziC6VZuRGW1CAZAWH
   fMtIZY1c0JjFEDWfl7L5pFd8fkCbvdeNE1QObxCr66ot9Il23TL1+mJBQ
   5eBqs4huugRFx1v/KD+SJFk+1afHqj86TOLq+NXfWX1NmJxirvEiO0Lmg
   0czFVBUhKEzLx26DU8rk1Khj+gVAvioycZc4+vKlCL6dlY7+ukpodMh3Y
   AeR9OQt7feByAkM049ciudG3zoylILAtp0RZCOqeB7AU2mTCVmXociCOV
   BvPGpj90qr3Y6vYPbw/G0A7y0fBA4UZqM8yOnAjqy5CoYPN9uj7U+rhmK
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="310077387"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="310077387"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 13:01:16 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="633645346"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="633645346"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.58.216])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 13:01:16 -0700
Date:   Mon, 31 Oct 2022 13:01:15 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com
Subject: Re: [PATCH 1/7] ndctl: cxl: add helper function to parse trace event
 to json object
Message-ID: <Y2Api2kdhBrRepeq@aschofie-mobl2>
References: <166318836385.3087953.6809315284050736931.stgit@djiang5-desk3.ch.intel.com>
 <166318847529.3087953.18405653106756321818.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166318847529.3087953.18405653106756321818.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Sep 14, 2022 at 01:47:55PM -0700, Dave Jiang wrote:
> Add the helper function that parses a trace event captured by
> libtraceevent in a tep handle. All the parsed fields are added to a json
> object. The json object is added to the provided list in the input parameter.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Hi Dave,

I've been using these parsing patches, and it all works for the purpose 
of parsing the cxl device poison list.

Tested-by: Alison Schofield <alison.schofield@intel.com>

One comment below...

-snip-

> ---
> +
> +	for (i = 0; fields[i]; i++) {
> +		struct tep_format_field *f = fields[i];
> +		int len;
> +		char *tmp;
> +
> +		tmp = strcasestr(f->type, "char[]");
> +		if (tmp) { /* event field is a string */
> +			char *str;
> +
> +			str = tep_get_field_raw(NULL, event, f->name, record, &len, 0);
> +			if (!str)
> +				continue;
> +
> +			jobj = json_object_new_string(str);
> +			if (!jobj) {
> +				rc = -ENOMEM;
> +				goto err;
> +			}
> +
> +			json_object_object_add(jevent, f->name, jobj);
> +		} else if (f->arraylen) { /* data array */
> +			unsigned char *data;
> +			int chunks;
> +
> +			data = tep_get_field_raw(NULL, event, f->name, record, &len, 0);
> +			if (!data)
> +				continue;
> +
> +			/* check to see if we have a UUID */
> +			tmp = strcasestr(f->name, "uuid");
> +			if (tmp && f->arraylen == 16) {
> +				char uuid[SYSFS_ATTR_SIZE];
> +
> +				uuid_unparse(data, uuid);
> +				jobj = json_object_new_string(uuid);
> +				if (!jobj) {
> +					rc = -ENOMEM;
> +					goto err;
> +				}
> +
> +				json_object_object_add(jevent, f->name, jobj);
> +				continue;
> +			}

Insted of comparing the field name, is it possible to check for
f->type of 'uuid_t'?


> +
> +			jarray = json_object_new_array();
> +			if (!jarray) {
> +				rc = -ENOMEM;
> +				goto err;
> +			}
> +
> +			chunks = f->size / f->elementsize;
> +			for (j = 0; j < chunks; j++) {
> +				jobj = num_to_json(data, f->elementsize);
> +				if (!jobj) {
> +					json_object_put(jarray);
> +					return -ENOMEM;
> +				}
> +				json_object_array_add(jarray, jobj);
> +				data += f->elementsize;
> +			}
> +
> +			json_object_object_add(jevent, f->name, jarray);
> +		} else { /* single number */
> +			char *data;
> +
> +			data = tep_get_field_raw(NULL, event, f->name, record, &len, 0);
> +			if (!data)
> +				continue;
> +
> +			jobj = num_to_json(data, f->elementsize);
> +			if (!jobj) {
> +				rc = -ENOMEM;
> +				goto err;
> +			}
> +
> +			json_object_object_add(jevent, f->name, jobj);
> +		}
> +	}
> +
> +	list_add_tail(jlist_head, &jnode->list);
> +	return 0;
> +
> +err:
> +	json_object_put(jevent);
> +err_jevent:
> +	free(jnode);
> +	return rc;
> +}

snip

