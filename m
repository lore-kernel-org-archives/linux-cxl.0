Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7F2DFA3741
	for <linux-cxl@archiver.kernel.org>; Mon, 31 Oct 2022 18:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiJaSuO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 31 Oct 2022 14:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiJaSuL (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 31 Oct 2022 14:50:11 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062F3D2C8
        for <linux-cxl@vger.kernel.org>; Mon, 31 Oct 2022 11:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667242209; x=1698778209;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=779mBtFJmCjjLuWfzBvJTBT9YcqQfClfBfK8EqOo84w=;
  b=LZ9CxCI3tBSB9UhN5s/kE81CB9sx2WqQ7oUinDCMvtfyr2N0adFbHJwk
   Hxe6ERQ5LtKu+ThzGT7l1ABRsWV6f3E/bhhLs7D/CBWZa7Wg8AN6R2kmP
   j1Ajobqph/7qrPWwOyB8Cjl7H2SBs4LyEGH5NBdtS1kC5XyQit7qkaVL3
   /aN1hpPmNeFncZV9Xv/VLQXgkN9YcoRqTLRmMo/iZg6HyVCNxCFer6eGF
   GU+ELnzPYBtbeACtrAHBxxMatrYmuRwp+jzd6XO+l8PRfGJD/+WiLBhc9
   s/HvtrFKAQyhhU+rkH6kfsgqCa2rjBDyPlqmGnZLJWvrZ5JUp2hHMOm1x
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="373186813"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="373186813"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 11:50:09 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="584757681"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="584757681"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.58.216])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 11:50:09 -0700
Date:   Mon, 31 Oct 2022 11:50:07 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Jonathan Zhang <jonzhang@meta.com>
Cc:     linux-cxl@vger.kernel.org, vishal.l.verma@intel.com,
        wzhang@meta.com, Jonathan Zhang <jonzhang@fb.com>
Subject: Re: [ndctl PATCH V2 2/2] cxl: display alert configuration fields
Message-ID: <Y2AY3372iFJvY2lX@aschofie-mobl2>
References: <20221025204320.290354-1-jonzhang@meta.com>
 <20221025204320.290354-3-jonzhang@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025204320.290354-3-jonzhang@meta.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Oct 25, 2022 at 01:43:20PM -0700, Jonathan Zhang wrote:
> From: Jonathan Zhang <jonzhang@fb.com>
> 
> CXL device's critical alert and programmable warning configurations
> are displayed when:
> * list command is issued.
> * "--alert-config" is issued.
> 

Hi Jonathan,

The change from 'alert' to 'alert-config' in the cmdline needs to carry
through to the JSON output and the man page example too.

Alison


> Signed-off-by: Jonathan Zhang <jonzhang@meta.com>
> ---
>  Documentation/cxl/cxl-list.txt |  33 ++++++
>  cxl/filter.c                   |   2 +
>  cxl/filter.h                   |   1 +
>  cxl/json.c                     | 185 +++++++++++++++++++++++++++++++++
>  cxl/list.c                     |   6 +-
>  util/json.h                    |   1 +
>  6 files changed, 226 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/cxl/cxl-list.txt b/Documentation/cxl/cxl-list.txt
> index 14a2b4b..c762368 100644
> --- a/Documentation/cxl/cxl-list.txt
> +++ b/Documentation/cxl/cxl-list.txt
> @@ -219,6 +219,39 @@ OPTIONS
>    }
>  ]
>  ----
> +-A::
> +--alert::
> +	Include alert configuration in the memdev listing. Example listing:
> +----
> +# cxl list -m mem0 -A
> +[
> +  {
> +    "memdev":"mem0",
> +    "pmem_size":0,
> +    "ram_size":273535729664,
> +    "alert":{
> +      "life_used_prog_warn_threshold_valid":false,
> +      "dev_over_temperature_prog_warn_threshold_valid":false,
> +      "dev_under_temperature_prog_warn_threshold_valid":false,
> +      "corrected_volatile_mem_err_prog_warn_threshold_valid":true,
> +      "corrected_pmem_err_prog_warn_threshold_valid":false,
> +      "life_used_prog_warn_threshold_writable":false,
> +      "dev_over_temperature_prog_warn_threshold_writable":false,
> +      "dev_under_temperature_prog_warn_threshold_writable":false,
> +      "corrected_volatile_mem_err_prog_warn_threshold_writable":true,
> +      "corrected_pmem_err_prog_warn_threshold_writable":false,
> +      "life_used_crit_alert_threshold":0,
> +      "life_used_prog_warn_threshold":0,
> +      "dev_over_temperature_crit_alert_threshold":0,
> +      "dev_under_temperature_crit_alert_threshold":0,
> +      "dev_over_temperature_prog_warn_threshold":0,
> +      "dev_under_temperature_prog_warn_threshold":0,
> +      "corrected_volatile_mem_err_prog_warn_threshold":0,
> +      "corrected_pmem_err_prog_warn_threshold":0
> +    },
> +  }
> +]
> +----
>  
>  -B::
>  --buses::
> diff --git a/cxl/filter.c b/cxl/filter.c
> index 56c6599..beb64de 100644
> --- a/cxl/filter.c
> +++ b/cxl/filter.c
> @@ -686,6 +686,8 @@ static unsigned long params_to_flags(struct cxl_filter_params *param)
>  		flags |= UTIL_JSON_TARGETS;
>  	if (param->partition)
>  		flags |= UTIL_JSON_PARTITION;
> +	if (param->alert_config)
> +		flags |= UTIL_JSON_ALERT_CONFIG;
>  	return flags;
>  }
>  
> diff --git a/cxl/filter.h b/cxl/filter.h
> index 256df49..cd514c9 100644
> --- a/cxl/filter.h
> +++ b/cxl/filter.h
> @@ -26,6 +26,7 @@ struct cxl_filter_params {
>  	bool human;
>  	bool health;
>  	bool partition;
> +	bool alert_config;
>  	int verbose;
>  	struct log_ctx ctx;
>  };
> diff --git a/cxl/json.c b/cxl/json.c
> index 63c1751..2f74452 100644
> --- a/cxl/json.c
> +++ b/cxl/json.c
> @@ -185,6 +185,185 @@ err_jobj:
>  	return NULL;
>  }
>  
> +static struct json_object *
> +util_cxl_memdev_alert_config_to_json(struct cxl_memdev *memdev,
> +				     unsigned long flags)
> +{
> +	struct json_object *jalert_config;
> +	struct json_object *jobj;
> +	struct cxl_cmd *cmd;
> +	int rc;
> +
> +	jalert_config = json_object_new_object();
> +	if (!jalert_config)
> +		return NULL;
> +	if (!memdev)
> +		goto err_jobj;
> +
> +	cmd = cxl_cmd_new_get_alert_config(memdev);
> +	if (!cmd)
> +		goto err_jobj;
> +
> +	rc = cxl_cmd_submit(cmd);
> +	if (rc < 0)
> +		goto err_cmd;
> +	rc = cxl_cmd_get_mbox_status(cmd);
> +	if (rc != 0)
> +		goto err_cmd;
> +
> +	rc = cxl_cmd_alert_config_life_used_prog_warn_threshold_valid(cmd);
> +	jobj = json_object_new_boolean(rc);
> +	if (jobj)
> +		json_object_object_add(jalert_config,
> +				       "life_used_prog_warn_threshold_valid",
> +				       jobj);
> +
> +	rc = cxl_cmd_alert_config_dev_over_temperature_prog_warn_threshold_valid(
> +		cmd);
> +	jobj = json_object_new_boolean(rc);
> +	if (jobj)
> +		json_object_object_add(
> +			jalert_config,
> +			"dev_over_temperature_prog_warn_threshold_valid", jobj);
> +
> +	rc = cxl_cmd_alert_config_dev_under_temperature_prog_warn_threshold_valid(
> +		cmd);
> +	jobj = json_object_new_boolean(rc);
> +	if (jobj)
> +		json_object_object_add(
> +			jalert_config,
> +			"dev_under_temperature_prog_warn_threshold_valid",
> +			jobj);
> +
> +	rc = cxl_cmd_alert_config_corrected_volatile_mem_err_prog_warn_threshold_valid(
> +		cmd);
> +	jobj = json_object_new_boolean(rc);
> +	if (jobj)
> +		json_object_object_add(
> +			jalert_config,
> +			"corr_volatile_mem_err_prog_warn_threshold_valid",
> +			jobj);
> +
> +	rc = cxl_cmd_alert_config_corrected_pmem_err_prog_warn_threshold_valid(
> +		cmd);
> +	jobj = json_object_new_boolean(rc);
> +	if (jobj)
> +		json_object_object_add(
> +			jalert_config,
> +			"corr_pmem_err_prog_warn_threshold_valid", jobj);
> +
> +	rc = cxl_cmd_alert_config_life_used_prog_warn_threshold_writable(cmd);
> +	jobj = json_object_new_boolean(rc);
> +	if (jobj)
> +		json_object_object_add(jalert_config,
> +				       "life_used_prog_warn_threshold_writable",
> +				       jobj);
> +
> +	rc = cxl_cmd_alert_config_dev_over_temperature_prog_warn_threshold_writable(
> +		cmd);
> +	jobj = json_object_new_boolean(rc);
> +	if (jobj)
> +		json_object_object_add(
> +			jalert_config,
> +			"dev_over_temperature_prog_warn_threshold_writable",
> +			jobj);
> +
> +	rc = cxl_cmd_alert_config_dev_under_temperature_prog_warn_threshold_writable(
> +		cmd);
> +	jobj = json_object_new_boolean(rc);
> +	if (jobj)
> +		json_object_object_add(
> +			jalert_config,
> +			"dev_under_temperature_prog_warn_threshold_writable",
> +			jobj);
> +
> +	rc = cxl_cmd_alert_config_corrected_volatile_mem_err_prog_warn_threshold_writable(
> +		cmd);
> +	jobj = json_object_new_boolean(rc);
> +	if (jobj)
> +		json_object_object_add(
> +			jalert_config,
> +			"corr_volatile_mem_err_prog_warn_threshold_writable",
> +			jobj);
> +
> +	rc = cxl_cmd_alert_config_corrected_pmem_err_prog_warn_threshold_writable(
> +		cmd);
> +	jobj = json_object_new_boolean(rc);
> +	if (jobj)
> +		json_object_object_add(
> +			jalert_config,
> +			"corr_pmem_err_prog_warn_threshold_writable", jobj);
> +
> +	rc = cxl_cmd_alert_config_get_life_used_crit_alert_threshold(cmd);
> +	jobj = json_object_new_int(rc);
> +	if (jobj)
> +		json_object_object_add(jalert_config,
> +				       "life_used_crit_alert_threshold", jobj);
> +
> +	rc = cxl_cmd_alert_config_get_life_used_prog_warn_threshold(cmd);
> +	jobj = json_object_new_int(rc);
> +	if (jobj)
> +		json_object_object_add(jalert_config,
> +				       "life_used_prog_warn_threshold", jobj);
> +
> +	rc = cxl_cmd_alert_config_get_dev_over_temperature_crit_alert_threshold(
> +		cmd);
> +	jobj = json_object_new_int(rc);
> +	if (jobj)
> +		json_object_object_add(
> +			jalert_config,
> +			"dev_over_temperature_crit_alert_threshold", jobj);
> +
> +	rc = cxl_cmd_alert_config_get_dev_under_temperature_crit_alert_threshold(
> +		cmd);
> +	jobj = json_object_new_int(rc);
> +	if (jobj)
> +		json_object_object_add(
> +			jalert_config,
> +			"dev_under_temperature_crit_alert_threshold", jobj);
> +
> +	rc = cxl_cmd_alert_config_get_dev_over_temperature_prog_warn_threshold(
> +		cmd);
> +	jobj = json_object_new_int(rc);
> +	if (jobj)
> +		json_object_object_add(
> +			jalert_config,
> +			"dev_over_temperature_prog_warn_threshold", jobj);
> +
> +	rc = cxl_cmd_alert_config_get_dev_under_temperature_prog_warn_threshold(
> +		cmd);
> +	jobj = json_object_new_int(rc);
> +	if (jobj)
> +		json_object_object_add(
> +			jalert_config,
> +			"dev_under_temperature_prog_warn_threshold", jobj);
> +
> +	rc = cxl_cmd_alert_config_get_corrected_volatile_mem_err_prog_warn_threshold(
> +		cmd);
> +	jobj = json_object_new_int(rc);
> +	if (jobj)
> +		json_object_object_add(
> +			jalert_config,
> +			"corr_volatile_mem_err_prog_warn_threshold", jobj);
> +
> +	rc = cxl_cmd_alert_config_get_corrected_pmem_err_prog_warn_threshold(
> +		cmd);
> +	jobj = json_object_new_int(rc);
> +	if (jobj)
> +		json_object_object_add(jalert_config,
> +				       "corr_pmem_err_prog_warn_threshold",
> +				       jobj);
> +
> +	cxl_cmd_unref(cmd);
> +	return jalert_config;
> +
> +err_cmd:
> +	cxl_cmd_unref(cmd);
> +err_jobj:
> +	json_object_put(jalert_config);
> +	return NULL;
> +}
> +
>  /*
>   * Present complete view of memdev partition by presenting fields from
>   * both GET_PARTITION_INFO and IDENTIFY mailbox commands.
> @@ -330,6 +509,12 @@ struct json_object *util_cxl_memdev_to_json(struct cxl_memdev *memdev,
>  			json_object_object_add(jdev, "health", jobj);
>  	}
>  
> +	if (flags & UTIL_JSON_ALERT_CONFIG) {
> +		jobj = util_cxl_memdev_alert_config_to_json(memdev, flags);
> +		if (jobj)
> +			json_object_object_add(jdev, "alert_config", jobj);
> +	}
> +
>  	serial = cxl_memdev_get_serial(memdev);
>  	if (serial < ULLONG_MAX) {
>  		jobj = util_json_object_hex(serial, flags);
> diff --git a/cxl/list.c b/cxl/list.c
> index 8c48fbb..5dd76b9 100644
> --- a/cxl/list.c
> +++ b/cxl/list.c
> @@ -52,8 +52,9 @@ static const struct option options[] = {
>  		    "include memory device health information"),
>  	OPT_BOOLEAN('I', "partition", &param.partition,
>  		    "include memory device partition information"),
> -	OPT_INCR('v', "verbose", &param.verbose,
> -		 "increase output detail"),
> +	OPT_BOOLEAN('A', "alert-config", &param.alert_config,
> +		    "include alert configuration information"),
> +	OPT_INCR('v', "verbose", &param.verbose, "increase output detail"),
>  #ifdef ENABLE_DEBUG
>  	OPT_BOOLEAN(0, "debug", &debug, "debug list walk"),
>  #endif
> @@ -113,6 +114,7 @@ int cmd_list(int argc, const char **argv, struct cxl_ctx *ctx)
>  	case 3:
>  		param.health = true;
>  		param.partition = true;
> +		param.alert_config = true;
>  		/* fallthrough */
>  	case 2:
>  		param.idle = true;
> diff --git a/util/json.h b/util/json.h
> index 73bb9f0..ea370df 100644
> --- a/util/json.h
> +++ b/util/json.h
> @@ -20,6 +20,7 @@ enum util_json_flags {
>  	UTIL_JSON_HEALTH	= (1 << 10),
>  	UTIL_JSON_TARGETS	= (1 << 11),
>  	UTIL_JSON_PARTITION	= (1 << 12),
> +	UTIL_JSON_ALERT_CONFIG	= (1 << 13),
>  };
>  
>  void util_display_json_array(FILE *f_out, struct json_object *jarray,
> -- 
> 2.30.2
> 
