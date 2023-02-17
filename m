Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51B2CC636D6
	for <linux-cxl@archiver.kernel.org>; Fri, 17 Feb 2023 21:30:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjBQV37 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 17 Feb 2023 16:29:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjBQV36 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 17 Feb 2023 16:29:58 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305A11114D
        for <linux-cxl@vger.kernel.org>; Fri, 17 Feb 2023 13:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676669397; x=1708205397;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xHswHqKsHvpDssmXoYZ/qU2+aUXdOwTD3nhWJSFdRt0=;
  b=SoFn5AeCb88SZswnAb59UmkEHESluGdkJc3ViADYj081lmMijMwQOZa9
   iCRsygSwwKy7EZMBP+NbLAzbBg8TkkZhYU4PaZPQCkTZL2EJ4hXH7M/Rt
   WV855w1/O9lz68U5rU+FolGXTCCPSbH1yEMRjGPUk0qtqKqlHcS/k6v6d
   1LZ9yKMM+MAgZdfhBqG+aiYc/1qFoBrp48XWD40S+sFlAxhAj2BV48jk+
   VP210js+h85Qxdr0TkRQ/cmJJx472kqpWLJVqo1cc/PSndBoOFO0VdwXW
   zj+UrsLIhPArPIqYaxsO6AKsfTb6cs5AQSkeRCZ8c0S0XrsXEQk4loYG8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="396774030"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="396774030"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 13:29:50 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10624"; a="739387068"
X-IronPort-AV: E=Sophos;i="5.97,306,1669104000"; 
   d="scan'208";a="739387068"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.213.187.252]) ([10.213.187.252])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2023 13:29:49 -0800
Message-ID: <d71d5cab-1b12-c047-fc6e-ecf928863557@intel.com>
Date:   Fri, 17 Feb 2023 14:29:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH v4 3/8] hw/pci-bridge/cxl_root_port: Wire up AER
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
 <20230217172924.25239-4-Jonathan.Cameron@huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230217172924.25239-4-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 2/17/23 10:29 AM, Jonathan Cameron wrote:
> We are missing necessary config write handling for AER emulation in
> the CXL root port. Add it based on pcie_root_port.c
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   hw/pci-bridge/cxl_root_port.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
> index 6664783974..00195257f7 100644
> --- a/hw/pci-bridge/cxl_root_port.c
> +++ b/hw/pci-bridge/cxl_root_port.c
> @@ -187,12 +187,15 @@ static void cxl_rp_write_config(PCIDevice *d, uint32_t address, uint32_t val,
>                                   int len)
>   {
>       uint16_t slt_ctl, slt_sta;
> +    uint32_t root_cmd =
> +        pci_get_long(d->config + d->exp.aer_cap + PCI_ERR_ROOT_COMMAND);
>   
>       pcie_cap_slot_get(d, &slt_ctl, &slt_sta);
>       pci_bridge_write_config(d, address, val, len);
>       pcie_cap_flr_write_config(d, address, val, len);
>       pcie_cap_slot_write_config(d, slt_ctl, slt_sta, address, val, len);
>       pcie_aer_write_config(d, address, val, len);
> +    pcie_aer_root_write_config(d, address, val, len, root_cmd);
>   
>       cxl_rp_dvsec_write_config(d, address, val, len);
>   }
