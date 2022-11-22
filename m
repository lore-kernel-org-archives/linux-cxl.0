Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11DCAC4332F
	for <linux-cxl@archiver.kernel.org>; Tue, 22 Nov 2022 22:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbiKVWgV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 22 Nov 2022 17:36:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbiKVWgU (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 22 Nov 2022 17:36:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE571C67E1;
        Tue, 22 Nov 2022 14:36:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 74290B81DC6;
        Tue, 22 Nov 2022 22:36:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20A89C433D6;
        Tue, 22 Nov 2022 22:36:16 +0000 (UTC)
Date:   Tue, 22 Nov 2022 17:36:14 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 07/11] cxl/mem: Trace Memory Module Event Record
Message-ID: <20221122173614.3f5c10e7@gandalf.local.home>
In-Reply-To: <20221110185758.879472-8-ira.weiny@intel.com>
References: <20221110185758.879472-1-ira.weiny@intel.com>
        <20221110185758.879472-8-ira.weiny@intel.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 10 Nov 2022 10:57:54 -0800
ira.weiny@intel.com wrote:

>  static bool cxl_event_tracing_enabled(void)
>  {
>  	return trace_cxl_generic_event_enabled() ||
>  	       trace_cxl_general_media_enabled() ||
> -	       trace_cxl_dram_enabled();
> +	       trace_cxl_dram_enabled() ||
> +	       trace_cxl_memory_module_enabled();
>  }
>  

My only concern with this patch set is that gcc may decide to not inline
this function and you will lose the performance of the static branches
provided by the trace_cxl_*enabled() functions.

Other than that, for patches 5-7 from a tracing perspective:

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
