Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0352ECAAA1
	for <linux-cxl@archiver.kernel.org>; Mon, 31 Oct 2022 18:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiJaS5z (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 31 Oct 2022 14:57:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiJaS5x (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 31 Oct 2022 14:57:53 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DE6F58B
        for <linux-cxl@vger.kernel.org>; Mon, 31 Oct 2022 11:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667242670; x=1698778670;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Wf/mk3mZnpwHj9eKy3NTP/jIr0p+w/5eWUbIelQ8k9s=;
  b=ao3G61o0In+buNc7lV2UN8Rhf6ETP7j4lMFs37IaBHdTTy9FTlzEdb4z
   DHthCadUjSrw5qrTleUG9YEfHZGKzp886+IRTAS3WGxQEDgDfJx6FOtJP
   MS6YewEbw8cIWG1buU9ZY8UUANEkMjrxHmcnZHWTE+LWFPlGOGewRTi30
   b14Fvxphj8cqY95UWd9yTrlBMrrbF0D8dzXfJ9hDu3tXJNjyzzlEsRX5P
   gBIDs4aZUcKLWJ2LQteIHHT6qQWN24OEuzELgtPjnMltIc8+XVrd8gorz
   ijyyLMB8nwkwQmMq8FkGxr2OGwsCGVKLSL11sQaGHreFAK+ofxavWXWYZ
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="310678647"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="310678647"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 11:57:49 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="633630619"
X-IronPort-AV: E=Sophos;i="5.95,228,1661842800"; 
   d="scan'208";a="633630619"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.58.216])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 11:57:49 -0700
Date:   Mon, 31 Oct 2022 11:57:47 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Jonathan Zhang <jonzhang@meta.com>
Cc:     linux-cxl@vger.kernel.org, vishal.l.verma@intel.com,
        wzhang@meta.com, Jonathan Zhang <jonzhang@fb.com>
Subject: Re: [ndctl PATCH V2 1/2] libcxl: add accessors for Get Alert
 Configuration CCI output
Message-ID: <Y2Aaq6dFXlr92W/6@aschofie-mobl2>
References: <20221025204320.290354-1-jonzhang@meta.com>
 <20221025204320.290354-2-jonzhang@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221025204320.290354-2-jonzhang@meta.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Oct 25, 2022 at 01:43:19PM -0700, Jonathan Zhang wrote:
> From: Jonathan Zhang <jonzhang@fb.com>
> 
> CXL 3.0 spec section 8.2.9.8.3.2 "Get Alert Configuration
> (Opcode 4201h) defines the get-alert-config command to
> retrieve the devices's critical alert and programmable
> warning configurations.
> 
> Add the methods to issue the command and get the fields
> defined.
> 
> Signed-off-by: Jonathan Zhang <jonzhang@meta.com>

Consistency in typos are trickier to detect ;)

> +CXL_EXPORT int
> +cxl_cmd_alert_config_life_used_prog_warn_threshold_writable(struct cxl_cmd *cmd)
> +{
> +	cmd_alert_get_prog_alerts_field(
> +		cmd,
> +		CXL_CMD_ALERT_CONFIG_PROG_ALERTS_LIEF_USED_PROG_WARN_THRESHOLD_MASK);
> +}
> +

--snip--

> +#define CXL_CMD_ALERT_CONFIG_PROG_ALERTS_LIEF_USED_PROG_WARN_THRESHOLD_MASK    \
> +	BIT(0)

--snip--
> 
