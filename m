Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01D4FA3741
	for <linux-cxl@archiver.kernel.org>; Tue,  1 Nov 2022 00:58:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiKAA6D (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 31 Oct 2022 20:58:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiKAA6C (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 31 Oct 2022 20:58:02 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92C6E007
        for <linux-cxl@vger.kernel.org>; Mon, 31 Oct 2022 17:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667264280; x=1698800280;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1j10NltvCkNqguK62FZ0aKYP48lUd7/Y6nSKZc6eXx4=;
  b=hMsMRn2z0WB2OYuCVJS5BTsF0bLT1wrkc06MZ973wxqk32FLfPdVo65/
   /I2P9ElyQuRZRZhyZqb2K2/A+xkOv2sCtcZXnYCzBWXYX6SFNNQyv9SUU
   EiiKOQg02tcrP57ZImOOuzMgsK0SDoZWZOmseVOgMYhUDpl3TAKmjbliU
   A7AG/M3hjd2y1pcZuxEcBrPFcig9W31AAdhJ37xCo1GjIgVumTtcfq+xC
   i1/oRbBhD8c1anQgAmhV4xjKWF88GQ8IY9zr0nCV8syH4WL3LtNi4yHmR
   bDouo5ljdG4cYxhWAvL8BX8SAg/YNLMDb+4qCln0/XKliVB2DbVhx47ml
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="395349442"
X-IronPort-AV: E=Sophos;i="5.95,229,1661842800"; 
   d="scan'208";a="395349442"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 17:58:00 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10517"; a="808746693"
X-IronPort-AV: E=Sophos;i="5.95,229,1661842800"; 
   d="scan'208";a="808746693"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.58.216])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 17:58:00 -0700
Date:   Mon, 31 Oct 2022 17:57:58 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     "Jonathan Zhang (Infra)" <jonzhang@meta.com>
Cc:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        Wei Zhang <wzhang@meta.com>
Subject: Re: [ndctl PATCH V2 1/2] libcxl: add accessors for Get Alert
 Configuration CCI output
Message-ID: <Y2BvFsTiSlOOgGE4@aschofie-mobl2>
References: <20221025204320.290354-1-jonzhang@meta.com>
 <20221025204320.290354-2-jonzhang@meta.com>
 <Y2Aaq6dFXlr92W/6@aschofie-mobl2>
 <07E73718-226C-4569-A168-DA90D77F43FD@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <07E73718-226C-4569-A168-DA90D77F43FD@fb.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Oct 31, 2022 at 11:46:56PM +0000, Jonathan Zhang (Infra) wrote:
> 
> 
> > On Oct 31, 2022, at 11:57 AM, Alison Schofield <alison.schofield@intel.com> wrote:
> > 
> > > 
> > On Tue, Oct 25, 2022 at 01:43:19PM -0700, Jonathan Zhang wrote:
> >> From: Jonathan Zhang <jonzhang@fb.com>
> >> 
> >> CXL 3.0 spec section 8.2.9.8.3.2 "Get Alert Configuration
> >> (Opcode 4201h) defines the get-alert-config command to
> >> retrieve the devices's critical alert and programmable
> >> warning configurations.
> >> 
> >> Add the methods to issue the command and get the fields
> >> defined.
> >> 
> >> Signed-off-by: Jonathan Zhang <jonzhang@meta.com>
> > 
> > Consistency in typos are trickier to detect ;)
> > 
> >> +CXL_EXPORT int
> >> +cxl_cmd_alert_config_life_used_prog_warn_threshold_writable(struct cxl_cmd *cmd)
> >> +{
> >> +	cmd_alert_get_prog_alerts_field(
> >> +		cmd,
> >> +		CXL_CMD_ALERT_CONFIG_PROG_ALERTS_LIEF_USED_PROG_WARN_THRESHOLD_MASK);
                                                 ^^ LIFE ?

> >> +}
> >> +
> > 
> > --snip--
> > 
> >> +#define CXL_CMD_ALERT_CONFIG_PROG_ALERTS_LIEF_USED_PROG_WARN_THRESHOLD_MASK    \
> >> +	BIT(0)

                                               ^^ LIFE ?

> > 
> > --snip--
> >> 
> Thanks for the review. For the above snippets, I do not see any consistency issue though.

I'm sorry for being cryptic in my review comment.
Alison

> To save space, I have been using following abbreviations: 
> * prog, short for programmable
> * err, short for error
> * warn, short for warning
> * crit, short for critical
> * dev, short for device
> * config, short for configuration
