Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D14C636D6
	for <linux-cxl@archiver.kernel.org>; Fri, 17 Feb 2023 21:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjBQVK1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 17 Feb 2023 16:10:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBQVK1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 17 Feb 2023 16:10:27 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4427A5DE38
        for <linux-cxl@vger.kernel.org>; Fri, 17 Feb 2023 13:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676668226; x=1708204226;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bsglX7iidTKm/vXA8BsTgb35ImhNfc2kF1gMW9B7eSw=;
  b=ThNPGmSIogTpdQHlHBizYXfjS7HwzrUs7Hs0/oj1CDcSpF70wOR4Hrh+
   +6UFGVJmmGBTqHfQkyTn+fkn3VUmAoRgH4B+VYcAl3pfm7WMvRbXJOg/S
   1pkpTZ+4yNwTF963JLkCbS/j4z9ovxE2iXb5FCPkaNOvbwsKqLP1z8Iak
   bjkiGgT/p9503436pvs8p4dPacyfsI2wF9Jao+djNaiG0b5YqX3WRW8vm
   PRSGxY34LtEkqTYNg0Foy3bm7/OBSDyOQTn5T1o9TtFfYXUdO2zVMRQ64
   sKXWuyoN++MuvasyuFiyyPE8sFvzLUCh2HydnCpz6iE6awpYoGfdNSLWa
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="332097843"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="332097843"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 13:10:08 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="759519627"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="759519627"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.213.187.252]) ([10.213.187.252])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 13:10:07 -0800
Message-ID: <bcc07785-3787-6485-92d1-6a347609d4bb@intel.com>
Date:   Fri, 17 Feb 2023 14:10:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH v4 1/8] hw/pci/aer: Implement PCI_ERR_UNCOR_MASK register
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
 <20230217172924.25239-2-Jonathan.Cameron@huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230217172924.25239-2-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 2/17/23 10:29 AM, Jonathan Cameron wrote:
> This register in AER should be both writeable and should
> have a default value with a couple of the errors masked
> including the Uncorrectable Internal Error used by CXL for
> it's error reporting.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   hw/pci/pcie_aer.c          | 4 ++++
>   include/hw/pci/pcie_regs.h | 3 +++
>   2 files changed, 7 insertions(+)
> 
> diff --git a/hw/pci/pcie_aer.c b/hw/pci/pcie_aer.c
> index 9a19be44ae..909e027d99 100644
> --- a/hw/pci/pcie_aer.c
> +++ b/hw/pci/pcie_aer.c
> @@ -112,6 +112,10 @@ int pcie_aer_init(PCIDevice *dev, uint8_t cap_ver, uint16_t offset,
>   
>       pci_set_long(dev->w1cmask + offset + PCI_ERR_UNCOR_STATUS,
>                    PCI_ERR_UNC_SUPPORTED);
> +    pci_set_long(dev->config + offset + PCI_ERR_UNCOR_MASK,
> +                 PCI_ERR_UNC_MASK_DEFAULT);
> +    pci_set_long(dev->wmask + offset + PCI_ERR_UNCOR_MASK,
> +                 PCI_ERR_UNC_SUPPORTED);
>   
>       pci_set_long(dev->config + offset + PCI_ERR_UNCOR_SEVER,
>                    PCI_ERR_UNC_SEVERITY_DEFAULT);
> diff --git a/include/hw/pci/pcie_regs.h b/include/hw/pci/pcie_regs.h
> index 963dc2e170..6ec4785448 100644
> --- a/include/hw/pci/pcie_regs.h
> +++ b/include/hw/pci/pcie_regs.h
> @@ -155,6 +155,9 @@ typedef enum PCIExpLinkWidth {
>                                            PCI_ERR_UNC_ATOP_EBLOCKED |    \
>                                            PCI_ERR_UNC_TLP_PRF_BLOCKED)
>   
> +#define PCI_ERR_UNC_MASK_DEFAULT        (PCI_ERR_UNC_INTN | \
> +                                         PCI_ERR_UNC_TLP_PRF_BLOCKED)
> +
>   #define PCI_ERR_UNC_SEVERITY_DEFAULT    (PCI_ERR_UNC_DLP |              \
>                                            PCI_ERR_UNC_SDN |              \
>                                            PCI_ERR_UNC_FCP |              \
