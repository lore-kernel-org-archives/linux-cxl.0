Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D10CBC433ED
	for <linux-cxl@archiver.kernel.org>; Thu, 20 May 2021 19:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2CB961353
	for <linux-cxl@archiver.kernel.org>; Thu, 20 May 2021 19:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236421AbhETTkx (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 20 May 2021 15:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232281AbhETTkx (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 20 May 2021 15:40:53 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC15DC061574
        for <linux-cxl@vger.kernel.org>; Thu, 20 May 2021 12:39:31 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id v14so9857394pgi.6
        for <linux-cxl@vger.kernel.org>; Thu, 20 May 2021 12:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3lcbI9ewKsu9xQ/eYi9Hj0b3hmCJFLuWtfNIh/5wdg0=;
        b=1TTAYN4u8XD5t1gbELYHge3w7lYnuyjO7zST4g9xiNczWGMnkAqqi09sNacEI6c+cT
         I0DdbFLrMwCgc0Ts0O2qPoupr53is2dROdTrGEdP4Reyl3uU2FFtlnhEmtpa7JZhQhFd
         LUJWt8k8WmtbgRdcROqgS3PHNHO3QmO3I65Pu7K5Br0BOZVjWMo71M04duWhL4l2mEeO
         fEFYT02THmxmj6/tSbejADd2zyB3Mtq20/wkSqbq8SXcOYrpjG5Ee9Rx8cJh41M/w98y
         8GQgVbgJNXNBMpU+FQMmsnb70eXjdlfcGngATPjoW7EqrZPSHWCS+bTpa29yBNFbDfM6
         l8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3lcbI9ewKsu9xQ/eYi9Hj0b3hmCJFLuWtfNIh/5wdg0=;
        b=RbhBR+Lf+pGV+eBCaMKsJcT/RCdMW8QzZtKkKkpHRRcKs3xSHITyDefSK6T8pIK0T0
         ysmEQWcg2YZSMe/aQn7qwF9eds+HTzfYqYK2P62knE0/kwSdn0LXLSeMs7yO4gO7n88g
         n4RBHlpZTjUxsTMsRHZkKzAmqFKyrZY8l14rJNy/J8g7CxBkCmXxTsuos4rmMTIg3g3W
         7wEOVm4VC7fkXWjzdej+2PyihT5f7y6PGNqQuLonhp8ASK3ECSC/eRd/SaMTw4IRlrc0
         ugEgRcm996C33nt0+HwoUlzoIHI5u+9fp8yNopcATCvCk35dMGgqU8dl5VWIWeTIGvPL
         2WhQ==
X-Gm-Message-State: AOAM531WRn3xXCd7Wk6Ti+/oZtQGhHtwaO++BYkyBoYZmveD7tvuXFFr
        10Z2qaZhoPdh/dljZ1XQTX6On1ox58D2anFMNUmgKA==
X-Google-Smtp-Source: ABdhPJyJ7017dbCWomQArvSNk2XElXpogeIKBPlPK1eyRlbEVlXV6FmNS2qWwGFFfp5H9GzHGye++y1U+vX79pULeB8=
X-Received: by 2002:a63:4b43:: with SMTP id k3mr6130929pgl.450.1621539571376;
 Thu, 20 May 2021 12:39:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210510182952.00006e49@Huawei.com> <20210520184138.996337-1-ben.widawsky@intel.com>
In-Reply-To: <20210520184138.996337-1-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 20 May 2021 12:39:21 -0700
Message-ID: <CAPcyv4iUE7OyGmWJUnO-ONdNHB+i36m4OnkL0KQCO_Q2Ssz29g@mail.gmail.com>
Subject: Re: [PATCH v2] cxl: Rename mem to pci
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, May 20, 2021 at 11:41 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> As the driver has undergone development, it's become clear that the
> majority [entirety?] of the current functionality in mem.c is actually a
> layer encapsulating functionality exposed through PCI based
> interactions. This layer can be used either in isolation or to provide
> functionality for higher level functionality.
>
> CXL capabilities exist in a parallel domain to PCIe. CXL devices are
> enumerable and controllable via "legacy" PCIe mechanisms; however, their
> CXL capabilities are a superset of PCIe. For example, a CXL device may
> be connected to a non-CXL capable PCIe root port, and therefore will not
> be able to participate in CXL.mem or CXL.cache operations, but can still
> be accessed through PCIe mechanisms for CXL.io operations.
>
> To properly represent the PCI nature of this driver, and in preparation for
> introducing a new driver for the CXL.mem / HDM decoder (Host-managed Device
> Memory) capabilities of a CXL memory expander, rename mem.c to pci.c so that
> mem.c is available for this new driver.
>
> The result of the change is that there is a clear layering distinction
> in the driver, and a systems administrator may load only the cxl_pci
> module and gain access to such operations as, firmware update, offline
> provisioning of devices, and error collection. In addition to freeing up
> the file name for another purpose, there are two primary reasons this is
> useful,
>     1. Acting upon devices which don't have full CXL capabilities. This
>        may happen for instance if the CXL device is connected in a CXL
>        unaware part of the platform topology.
>     2. Userspace-first provisioning for devices without kernel driver
>        interference. This may be useful when provisioning a new device
>        in a specific manner that might otherwise be blocked or prevented
>        by the real CXL mem driver.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
> v2: Makes it clear that the main motivation for this patch is for proper
> layering and that administrative PCI-only activities is a secondary benefit.
>
> I'm proposing we take the hit now and merge this as our next patch for cxl/next.

Looks good to me, and I think low risk to expedite into cxl/next to
remove the burden on git to cope with other development touching these
files.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
