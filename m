Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3270C46467
	for <linux-cxl@archiver.kernel.org>; Tue,  3 Jan 2023 10:49:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjACKtm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 3 Jan 2023 05:49:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbjACKtl (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 3 Jan 2023 05:49:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593BDF4C
        for <linux-cxl@vger.kernel.org>; Tue,  3 Jan 2023 02:49:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E67136120E
        for <linux-cxl@vger.kernel.org>; Tue,  3 Jan 2023 10:49:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77F5AC433D2;
        Tue,  3 Jan 2023 10:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672742980;
        bh=qJDYNr8io1dAC2CGNsYKXyfHre1XbJuF7PtyzroVJhU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IiV/VRM05DWiGmx+lHA+H1GzDx0qOtmlhOCZx+v6PiEWns2tL8Sifaqrqf/e+3hEY
         m0du9LLWrQTZC5iJ4Q8bKJo/bpAo3oAZnIO9NyFKwXyb0goDeS+n5aRNf/7sPk4noz
         ilePA2ni/G+JUJ2YexkQeskBYiEtBNzb2pi92o83ogLl4Ktf4zMQboZy8ZcYx+EI0D
         fLzr87NKT+vd42jafih6+GH7ID0+mnoAxeLp3uIg3yuFYO6eXrylBTsQUuZsp97xgH
         fyUobbx1dhkTXNVrzJUaoTQdSGtAnL/iEP8wyR+kSoYRoHW1Q3P7wP+ufZQiulh/av
         STWqEVW1TLjrQ==
Date:   Tue, 3 Jan 2023 11:49:35 +0100
From:   Robert Richter <rric@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/3] cxl/mem: Quiet port walking warning
Message-ID: <Y7QIP33kUAEPp6sb@rric.localdomain>
References: <167124080717.1626103.10654476222026614847.stgit@dwillia2-xfh.jf.intel.com>
 <167124081278.1626103.4792472728150764118.stgit@dwillia2-xfh.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167124081278.1626103.4792472728150764118.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 16.12.22 17:33:32, Dan Williams wrote:
> The cxl_mem driver attempts to establish, or revalidate, the cxl_port
> hierarcy to attach a cxl_memdev to a CXL platform topology. There is a
> natural race (on ACPI platforms) between when the cxl_mem driver
> attempts to attach and when the cxl_acpi driver establishes the root of
> the topology.
> 
> If cxl_mem_probe() runs first it will iterate to the top of the device
> topology without finding the CXL platform root. That situation is benign
> / expected, so stop warning about it. The cxl_acpi driver will poke
> cxl_mem_probe() to try again once the CXL platform root is established.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/port.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 810e60cc331c..6296d2bc909a 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1400,8 +1400,8 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  
>  		uport_dev = dport_dev->parent;
>  		if (!uport_dev) {
> -			dev_warn(dev, "at %s no parent for dport: %s\n",
> -				 dev_name(iter), dev_name(dport_dev));
> +			dev_dbg(dev, "at %s no parent for dport: %s\n",
> +				dev_name(iter), dev_name(dport_dev));
>  			return -ENXIO;

Maybe we should also change the return code to the common -EAGAIN for
this case here too? It looks like it is just passed to
cxl_mem_probe(), so there are probably no side effects of this change.
The probe is triggered then again by the base driver.

-Robert
