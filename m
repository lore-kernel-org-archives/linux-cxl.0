Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A52DC05027
	for <linux-cxl@archiver.kernel.org>; Fri, 17 Feb 2023 21:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjBQVQF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 17 Feb 2023 16:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBQVQE (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 17 Feb 2023 16:16:04 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FC35DE25
        for <linux-cxl@vger.kernel.org>; Fri, 17 Feb 2023 13:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676668563; x=1708204563;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=n57sCYK4PeaLUElSFWfLDuvU6jKLhr9A0sJ1rA2TP4Y=;
  b=fzblW2GHXNM5qEpZVOJyWaK/Lq1Q46EUtIfZi5v5bhg446kx2UQYFd/h
   qzufExuCjj5Zh972spx7atFMUdIdt8tf3rqYkC4zPbjxTiODyB8NzXtek
   8mwuuz37OWaQ4Jt9RekFfksBMQpiBbd85e1+Hu0IQXvdtgiEQbVMpxfPO
   iDRfoAiV3Gf0EM8WKknQrrd7Em7R+eBCryOQGHXKfE9mh7N7d+2T86o0B
   n2OqrQNYqiSYEtEPCJsX80l/Pb4MfVLfPR6s20x8f7F0Y7rgi86wDsMVp
   OowtO8v4+2nLjzhzC90/JIcVs/QEYrujHVBvS5paV0KQvOigB7pQwG3Ie
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="312457996"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="312457996"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 13:16:03 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="779914774"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="779914774"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.213.187.252]) ([10.213.187.252])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 13:16:03 -0800
Message-ID: <d3e07dbe-500f-303c-b348-4ca18934ed5c@intel.com>
Date:   Fri, 17 Feb 2023 14:16:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH v4 2/8] hw/pci/aer: Add missing routing for AER errors
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
 <20230217172924.25239-3-Jonathan.Cameron@huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230217172924.25239-3-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 2/17/23 10:29 AM, Jonathan Cameron wrote:
> PCIe r6.0 Figure 6-3 "Pseudo Logic Diagram for Selected Error Message Control
> and Status Bits" includes a right hand branch under "All PCI Express devices"
> that allows for messages to be generated or sent onwards without SERR#
> being set as long as the appropriate per error class bit in the PCIe
> Device Control Register is set.
> 
> Implement that branch thus enabling routing of ERR_COR, ERR_NONFATAL
> and ERR_FATAL under OSes that set these bits appropriately (e.g. Linux)
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   hw/pci/pcie_aer.c | 10 +++++++++-
>   1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/pci/pcie_aer.c b/hw/pci/pcie_aer.c
> index 909e027d99..103667c368 100644
> --- a/hw/pci/pcie_aer.c
> +++ b/hw/pci/pcie_aer.c
> @@ -192,8 +192,16 @@ static void pcie_aer_update_uncor_status(PCIDevice *dev)
>   static bool
>   pcie_aer_msg_alldev(PCIDevice *dev, const PCIEAERMsg *msg)
>   {
> +    uint16_t devctl = pci_get_word(dev->config + dev->exp.exp_cap +
> +                                   PCI_EXP_DEVCTL);
>       if (!(pcie_aer_msg_is_uncor(msg) &&
> -          (pci_get_word(dev->config + PCI_COMMAND) & PCI_COMMAND_SERR))) {
> +          (pci_get_word(dev->config + PCI_COMMAND) & PCI_COMMAND_SERR)) &&
> +        !((msg->severity == PCI_ERR_ROOT_CMD_NONFATAL_EN) &&
> +          (devctl & PCI_EXP_DEVCTL_NFERE)) &&
> +        !((msg->severity == PCI_ERR_ROOT_CMD_COR_EN) &&
> +          (devctl & PCI_EXP_DEVCTL_CERE)) &&
> +        !((msg->severity == PCI_ERR_ROOT_CMD_FATAL_EN) &&
> +          (devctl & PCI_EXP_DEVCTL_FERE))) {
>           return false;
>       }
>   
