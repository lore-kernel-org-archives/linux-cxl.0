Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6C7C77B7E
	for <linux-cxl@archiver.kernel.org>; Fri, 28 Apr 2023 16:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346201AbjD1QKH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 28 Apr 2023 12:10:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346264AbjD1QKC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 28 Apr 2023 12:10:02 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E652137
        for <linux-cxl@vger.kernel.org>; Fri, 28 Apr 2023 09:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682698201; x=1714234201;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eTQ6C4z+W5rnLmujSW/vWolS7shBo3RFQMUl3YfqMNg=;
  b=kz8nsBL69BD3NfD7EiY+er733G8dGu9SFpdIisi8pv5XWKAUJfEvZokX
   AunaEAO6y9dCauxOqUdI3TX7i5gmFINm6dsSAi/u+5HMvOd8pxM41jcH6
   C/YGFeu8KRVtQoxINtjThEiBnyD2L77rQy9PwG2y819G8z09w/U0LM+ZK
   D+DXFIpiWzj7BBsY4emSvaFyapwqXdZzT6JEcWdmPKf8wal9v5MOj6db1
   PSDLfq9egNJKcxKuE2/wSWkiIub0wugyC1+4rdCIR2aD28fW9xtrJSl6U
   CVQAL5nKvyLshpKB5lQNRuGeMRBAM1HQHoKNXzHBfaK2GHwwb8nbzQjjv
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="349813704"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="349813704"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 09:09:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10694"; a="645197539"
X-IronPort-AV: E=Sophos;i="5.99,235,1677571200"; 
   d="scan'208";a="645197539"
Received: from egliskay-mobl.amr.corp.intel.com (HELO [10.212.108.170]) ([10.212.108.170])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2023 09:09:56 -0700
Message-ID: <621ee782-d86f-785c-43ad-a4396d159ba9@intel.com>
Date:   Fri, 28 Apr 2023 09:09:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH 1/7] cxl/pci: Allocate irq vectors earlier in pci probe
Content-Language: en-US
To:     Davidlohr Bueso <dave@stgolabs.net>, dan.j.williams@intel.com
Cc:     Jonathan.Cameron@huawei.com, alison.schofield@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org
References: <20230421092321.12741-1-dave@stgolabs.net>
 <20230421092321.12741-2-dave@stgolabs.net>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230421092321.12741-2-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 4/21/23 2:23 AM, Davidlohr Bueso wrote:
> Move the cxl_alloc_irq_vectors() call further up in the probing
> in order to allow for mailbox interrupt usage. No change in
> semantics.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/pci.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 60b23624d167..39b829a29f6c 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -757,6 +757,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	if (rc)
>   		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
>   
> +	rc = cxl_alloc_irq_vectors(pdev);
> +	if (rc)
> +		return rc;
> +
>   	rc = cxl_pci_setup_mailbox(cxlds);
>   	if (rc)
>   		return rc;
> @@ -777,10 +781,6 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	if (rc)
>   		return rc;
>   
> -	rc = cxl_alloc_irq_vectors(pdev);
> -	if (rc)
> -		return rc;
> -
>   	cxlmd = devm_cxl_add_memdev(cxlds);
>   	if (IS_ERR(cxlmd))
>   		return PTR_ERR(cxlmd);
