Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDC8C636CC
	for <linux-cxl@archiver.kernel.org>; Tue, 31 Jan 2023 15:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbjAaPXk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 31 Jan 2023 10:23:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233077AbjAaPXL (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 31 Jan 2023 10:23:11 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E53B16AFA
        for <linux-cxl@vger.kernel.org>; Tue, 31 Jan 2023 07:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675178532; x=1706714532;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hCNkX4lo9QNyhEceDLtnFTlN1eTQZ7QaJdwnTJrWY5Y=;
  b=HbdJmeRGc2LqYWIDFi48nkATmKSiskv8WgajN7Fk7j9MucAYj57WLHKM
   vlqd9i6sJHRBJA1yCzZal1SHE+zMfSlUNYxQthiAEYTzximbngzUWnObP
   vTvsxbaSF0x6CLWgb+SvT3yHnK4n0js4N3M467W+/UfJeTD+i+kCsfInt
   022oyec1LAAVeajEYywAJvnoMXl7AEE07SmPuIuy5be79Rem13Xakxhnk
   YfW6p1+L7QLgCvcOzJSBfVVprmgOYHocdbLoasDp02292nqbxES2gZi76
   mkeKlyUc8RQtxrWa3lh3W8ZvVIA/4mAkPfmTZjls4o2XmwyLEY/8FdrOR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="308209883"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="308209883"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 07:21:50 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10606"; a="727990728"
X-IronPort-AV: E=Sophos;i="5.97,261,1669104000"; 
   d="scan'208";a="727990728"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.213.177.33]) ([10.213.177.33])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2023 07:21:48 -0800
Message-ID: <6e3ae578-52bd-baeb-1957-ecfaf655973c@intel.com>
Date:   Tue, 31 Jan 2023 08:21:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH] cxl/pci: Fix irq oneshot expectations
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ira Weiny <ira.weiny@intel.com>
References: <167512370284.2509057.12212781340425308386.stgit@dwillia2-xfh.jf.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <167512370284.2509057.12212781340425308386.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 1/30/23 5:08 PM, Dan Williams wrote:
> The IRQ core expects that users of the default hardirq handler specify
> IRQF_ONESHOT to keep interrupts disabled until the threaded handler
> runs. That meets the CXL driver's expectations since it is an edge
> triggered MSI and this flag would have been passed by default using
> pci_request_irq() instead of devm_request_threaded_irq().
> 
> Fixes: a49aa8141b65 ("cxl/mem: Wire up event interrupts")
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Julia Lawall <julia.lawall@lip6.fr>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/pci.c |    3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index ad2ebe7bfaeb..4cf9a2191602 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -509,7 +509,8 @@ static int cxl_event_req_irq(struct cxl_dev_state *cxlds, u8 setting)
>   		return irq;
>   
>   	return devm_request_threaded_irq(dev, irq, NULL, cxl_event_thread,
> -					 IRQF_SHARED, NULL, dev_id);
> +					 IRQF_SHARED | IRQF_ONESHOT, NULL,
> +					 dev_id);
>   }
>   
>   static int cxl_event_get_int_policy(struct cxl_dev_state *cxlds,
> 
