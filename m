Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15763C05027
	for <linux-cxl@archiver.kernel.org>; Fri, 17 Feb 2023 22:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjBQWAV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 17 Feb 2023 17:00:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjBQWAU (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 17 Feb 2023 17:00:20 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D3564B22
        for <linux-cxl@vger.kernel.org>; Fri, 17 Feb 2023 14:00:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676671219; x=1708207219;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tIYZ6a+3sbvHSRoqLIcYH/edSnZLE6ChkR5avYfvaGo=;
  b=ExUzZsj+RsYiyoh5G8wDkAHE42d00qsaE2/bHmbammbA7GkWiUS6ZcB7
   bOFdKriN+oaENZ90moRGqO5lcvXnreymH0zakqU5+UptfyIwwFKzdVcPb
   s4cLPBtxoZMWtEasSFGXq6ZYl0PcKmV2wPgVk/qN8lDTlPfzTGR+O6k/T
   LN8KLLobkV9F273VrQzf8ogp6wAqHLvUwaP4eIUY7sa6XzoFVoLxEa95w
   PsBmak12e/aZsAtr+HS9RxseP7PZZWRiaFjSjohYsC9sMrEF8bsUTVmXz
   V6O3iBorp4mksjar3dt6zMbsd3PUyqxe9/Ek4ZgdF1FY2iun5gPaWH0ec
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="311727435"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="311727435"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 14:00:19 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="648208855"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="648208855"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.213.187.252]) ([10.213.187.252])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 14:00:18 -0800
Message-ID: <ff7b2293-5a86-297e-6483-53e1970b6029@intel.com>
Date:   Fri, 17 Feb 2023 15:00:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH v4 7/8] hw/pci/aer: Make PCIE AER error injection facility
 available for other emulation to use.
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>
Cc:     Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        Markus Armbruster <armbru@redhat.com>
References: <20230217172924.25239-1-Jonathan.Cameron@huawei.com>
 <20230217172924.25239-8-Jonathan.Cameron@huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230217172924.25239-8-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 2/17/23 10:29 AM, Jonathan Cameron wrote:
> This infrastructure will be reused for CXL RAS error injection
> in patches that follow.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   hw/pci/pci-internal.h     | 1 -
>   include/hw/pci/pcie_aer.h | 1 +
>   2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/pci/pci-internal.h b/hw/pci/pci-internal.h
> index 2ea356bdf5..a7d6d8a732 100644
> --- a/hw/pci/pci-internal.h
> +++ b/hw/pci/pci-internal.h
> @@ -20,6 +20,5 @@ void pcibus_dev_print(Monitor *mon, DeviceState *dev, int indent);
>   
>   int pcie_aer_parse_error_string(const char *error_name,
>                                   uint32_t *status, bool *correctable);
> -int pcie_aer_inject_error(PCIDevice *dev, const PCIEAERErr *err);
>   
>   #endif
> diff --git a/include/hw/pci/pcie_aer.h b/include/hw/pci/pcie_aer.h
> index 65e71d98fe..1234fdc4e2 100644
> --- a/include/hw/pci/pcie_aer.h
> +++ b/include/hw/pci/pcie_aer.h
> @@ -100,4 +100,5 @@ void pcie_aer_root_write_config(PCIDevice *dev,
>                                   uint32_t addr, uint32_t val, int len,
>                                   uint32_t root_cmd_prev);
>   
> +int pcie_aer_inject_error(PCIDevice *dev, const PCIEAERErr *err);
>   #endif /* QEMU_PCIE_AER_H */
