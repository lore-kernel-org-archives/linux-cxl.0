Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B56C433F5
	for <linux-cxl@archiver.kernel.org>; Wed,  9 Feb 2022 17:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238440AbiBIRtk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 9 Feb 2022 12:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238308AbiBIRtj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 9 Feb 2022 12:49:39 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA91C05CB82
        for <linux-cxl@vger.kernel.org>; Wed,  9 Feb 2022 09:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644428982; x=1675964982;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Axkasq/Vcc/vlh05p9NYmeF717ERT73towQJZdQXfvo=;
  b=OwJ7ZyA0HuffmRd3Ig1+yMMJRuiUKSui/HrcGhSUfzuB3Z3bzkRQfY4x
   ke0j3vsc7jTAdqqwAXIIhMhzDJw4IG0RldH0Q+7iOAvUGPFvp/QQBvgF1
   tXUJPsmefixI37+pz/f6vOkOZxhhJ9taDB7yyKLrA+ih/1+3fLMW+ypdu
   JVpxLe1zQkjMkAYe0HcctJem8RNtrg3hbxGtgs/d2RWT3uIaAqZQPMpd0
   JKg7RQK47IYnVyREgczwgiVD0lojhvejgt1Wg455KJbxHxuNLUdex8XQm
   jQVpn84YJ1UIo1YErrA004AnSdEoqk8bqxzIb1MOzg0UYHokYzW4PlLI+
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="248110184"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="248110184"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 09:49:42 -0800
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="537016717"
Received: from dgarg1-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.131.253])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 09:49:42 -0800
Date:   Wed, 9 Feb 2022 09:49:41 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/core/port: Fix unregister_port() lock assertion
Message-ID: <20220209174941.uyjm3t4qdvggeepk@intel.com>
References: <164439224893.2941117.18331456248117887720.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164439224893.2941117.18331456248117887720.stgit@dwillia2-desk3.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 22-02-08 23:37:28, Dan Williams wrote:
> The device_lock_assert() in unregister_port() fails to pick the right
> device leading to splats like the following from:
> 
> echo "ACPI0017:00" > /sys/bus/platform/drivers/cxl_acpi/unbind
> 
>  WARNING: CPU: 32 PID: 1147 at include/linux/device.h:787 unregister_port+0x49/0x50 [cxl_c
>  [..]
>  RIP: 0010:unregister_port+0x49/0x50 [cxl_core]
>  [..]
>  Call Trace:
>   <TASK>
>   release_nodes+0x63/0x80
>   devres_release_all+0x8b/0xc0
>   __device_release_driver+0x190/0x240
>   device_driver_detach+0x3e/0xa0
>   unbind_store+0x113/0x130
> 
> Fix it up to assert on the device_lock() for ACPI0017 for root and 1st
> level ports, and parent ports for all the rest.
> 
> Fixes: 54cdbf845cf7 ("cxl/port: Add a driver for 'struct cxl_port' objects")
> Reported-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Comment/question below...
Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>

> ---
>  drivers/cxl/core/port.c |   24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index c3e83c624700..9b4bbd51fbaa 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -348,12 +348,28 @@ EXPORT_SYMBOL_NS_GPL(to_cxl_port, CXL);
>  static void unregister_port(void *_port)
>  {
>  	struct cxl_port *port = _port;
> +	struct cxl_port *parent;
> +	struct device *lock_dev;
>  
> -	if (!is_cxl_root(port)) {
> -		device_lock_assert(port->dev.parent);
> -		port->uport = NULL;
> -	}
> +	if (is_cxl_root(port))
> +		parent = NULL;
> +	else
> +		parent = to_cxl_port(port->dev.parent);
> +
> +	/*
> +	 * CXL root port's and the first level of ports are unregistered
> +	 * under the platform firmware device lock, all other ports are
> +	 * unregistered while holding their parent port lock.
> +	 */
> +	if (!parent)
> +		lock_dev = port->uport;
> +	else if (is_cxl_root(parent))
> +		lock_dev = parent->uport;
> +	else
> +		lock_dev = &parent->dev;

I wonder if it would be a little cleaner if the root port and host bridge ports
had a separate unregistration callback from switches and endpoints.

>  
> +	device_lock_assert(lock_dev);
> +	port->uport = NULL;
>  	device_unregister(&port->dev);
>  }
>  
> 
