Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B60AC77B75
	for <linux-cxl@archiver.kernel.org>; Fri, 19 May 2023 07:06:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbjESHGk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 19 May 2023 03:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjESHGj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 19 May 2023 03:06:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C1810C6
        for <linux-cxl@vger.kernel.org>; Fri, 19 May 2023 00:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684479951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M0qGAB7USPM54ODgaWUWL5AVe/iVbhTHkCRpc8l4VTA=;
        b=YfQyPh5BQLyDRtfIq7kGk0SXBpQgYGwIMSfs5t+cEoRBJoBsKJhi135de5IiXmsdr3R3wN
        nTkSwoRLBn/0b3SclNEBA23Tte1uyE2vd+01P+zC7CQ2FwzSoxb/h1jb+pvWKY+M3skdcE
        dWBGIYqUx3NIp6c0HUKoFlLrAQrVyqY=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-0W0k1N0MP-6TAA91giyf8g-1; Fri, 19 May 2023 03:05:50 -0400
X-MC-Unique: 0W0k1N0MP-6TAA91giyf8g-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-4f19bffbc23so1982840e87.1
        for <linux-cxl@vger.kernel.org>; Fri, 19 May 2023 00:05:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684479948; x=1687071948;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M0qGAB7USPM54ODgaWUWL5AVe/iVbhTHkCRpc8l4VTA=;
        b=R5z7Ml6MoXY5C1I//afIxzjImTD3nRVjiyg3DBHYa5EQHI/x2yy4G4QJ3367A5PLz5
         yBr+WY2bNWkKKKtWqhtkqEUtnHfh1CznmTxA+cci0QjK7tqtrmhRczvsCe82Lhnzk/Z1
         Cp9usfn12zAuikYCcxo31ZE1ESg5nlb2bUlNWKRTy/ebzfOKjtnk3YYhFHAFDASgHj2U
         vunYjWupzcEyvoC5uWzanmzUS4LrGPn42oMRhQsn/8nojAt+ImdZ/6kiSQlkFQhKfZU9
         rh32yc95CKLSLJ/uyq9Pu8ZmRIrqUS+AXVqTwIMh6zXZ+a+A29TZZ7SP/CFw9KkhJWkM
         dv+A==
X-Gm-Message-State: AC+VfDwuBXUfTrU0YV5B/Nz8V0cCsNipVVEJpxkKSK9B7E/cZ26lA1iE
        4AIgW79YFzfCXxS2Dwwu1J8bYnfiBUGOs9/XJJhExD+RJLQqd9akQikzMllvpr7/gPLPFcw9aia
        yJGOiCGo1H7WA5Q/kvPjjFdB14k1D
X-Received: by 2002:ac2:5a4d:0:b0:4ed:cb37:7d8c with SMTP id r13-20020ac25a4d000000b004edcb377d8cmr416271lfn.67.1684479948172;
        Fri, 19 May 2023 00:05:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6cU4cnan/0cKk4e5auz9IV17m/lTaoN5Aq+j334HaBu/UQzc/6Gt22HWPqxbuP7LFdr0P5Rg==
X-Received: by 2002:ac2:5a4d:0:b0:4ed:cb37:7d8c with SMTP id r13-20020ac25a4d000000b004edcb377d8cmr416249lfn.67.1684479947771;
        Fri, 19 May 2023 00:05:47 -0700 (PDT)
Received: from redhat.com ([2a02:14f:175:3e4d:6703:27b9:6f74:5282])
        by smtp.gmail.com with ESMTPSA id 24-20020ac24858000000b004cb43eb09dfsm496899lfy.123.2023.05.19.00.05.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 00:05:47 -0700 (PDT)
Date:   Fri, 19 May 2023 03:05:40 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, Fan Ni <fan.ni@samsung.com>,
        linux-cxl@vger.kernel.org, linuxarm@huawei.com,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?iso-8859-1?Q?Marc-Andr=E9?= Lureau 
        <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v5 6/6] hw/cxl: Add clear poison mailbox command support.
Message-ID: <20230519030515-mutt-send-email-mst@kernel.org>
References: <20230423162013.4535-1-Jonathan.Cameron@huawei.com>
 <20230423162013.4535-7-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
In-Reply-To: <20230423162013.4535-7-Jonathan.Cameron@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sun, Apr 23, 2023 at 05:20:13PM +0100, Jonathan Cameron wrote:
> Current implementation is very simple so many of the corner
> cases do not exist (e.g. fragmenting larger poison list entries)
> 
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v5:
> - Much simpler identification of the entry to modify (Ira)
> - Use CXL_CACHE_LINE_SIZE instead of 64. (Philippe)
> - Use memory_region_size() instead of accessing directly. (Michael)
> - Rename unused len parameter len_unused to make it clear that (Fan)
>   for a fixed length input payload, this parameter has already been
>   checked so the function need not do anything with it.
> ---
>  hw/cxl/cxl-mailbox-utils.c  | 82 +++++++++++++++++++++++++++++++++++++
>  hw/mem/cxl_type3.c          | 37 +++++++++++++++++
>  include/hw/cxl/cxl_device.h |  1 +
>  3 files changed, 120 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 6c476ad7f4..e3401b6be8 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -65,6 +65,7 @@ enum {
>      MEDIA_AND_POISON = 0x43,
>          #define GET_POISON_LIST        0x0
>          #define INJECT_POISON          0x1
> +        #define CLEAR_POISON           0x2
>  };
>  
>  /* 8.2.8.4.5.1 Command Return Codes */
> @@ -512,6 +513,85 @@ static CXLRetCode cmd_media_inject_poison(struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +static CXLRetCode cmd_media_clear_poison(struct cxl_cmd *cmd,
> +                                         CXLDeviceState *cxl_dstate,
> +                                         uint16_t *len_unused)
> +{
> +    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
> +    CXLPoisonList *poison_list = &ct3d->poison_list;
> +    CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
> +    struct clear_poison_pl {
> +        uint64_t dpa;
> +        uint8_t data[64];
> +    };
> +    CXLPoison *ent;
> +    uint64_t dpa;
> +
> +    struct clear_poison_pl *in = (void *)cmd->payload;
> +
> +    dpa = ldq_le_p(&in->dpa);
> +    if (dpa + CXL_CACHE_LINE_SIZE > cxl_dstate->mem_size) {
> +        return CXL_MBOX_INVALID_PA;
> +    }
> +
> +    /* Clearing a region with no poison is not an error so always do so */
> +    if (cvc->set_cacheline) {
> +        if (!cvc->set_cacheline(ct3d, dpa, in->data)) {
> +            return CXL_MBOX_INTERNAL_ERROR;
> +        }
> +    }
> +
> +    QLIST_FOREACH(ent, poison_list, node) {
> +        /*
> +         * Test for contained in entry. Simpler than general case
> +         * as clearing 64 bytes and entries 64 byte aligned
> +         */
> +        if ((dpa >= ent->start) && (dpa < ent->start + ent->length)) {
> +            break;
> +        }
> +    }
> +    if (!ent) {
> +        return CXL_MBOX_SUCCESS;
> +    }
> +
> +    QLIST_REMOVE(ent, node);
> +    ct3d->poison_list_cnt--;
> +
> +    if (dpa > ent->start) {
> +        CXLPoison *frag;
> +        /* Cannot overflow as replacing existing entry */
> +
> +        frag = g_new0(CXLPoison, 1);
> +
> +        frag->start = ent->start;
> +        frag->length = dpa - ent->start;
> +        frag->type = ent->type;
> +
> +        QLIST_INSERT_HEAD(poison_list, frag, node);
> +        ct3d->poison_list_cnt++;
> +    }
> +
> +    if (dpa + CXL_CACHE_LINE_SIZE < ent->start + ent->length) {
> +        CXLPoison *frag;
> +
> +        if (ct3d->poison_list_cnt == CXL_POISON_LIST_LIMIT) {
> +            cxl_set_poison_list_overflowed(ct3d);
> +        } else {
> +            frag = g_new0(CXLPoison, 1);
> +
> +            frag->start = dpa + CXL_CACHE_LINE_SIZE;
> +            frag->length = ent->start + ent->length - frag->start;
> +            frag->type = ent->type;
> +            QLIST_INSERT_HEAD(poison_list, frag, node);
> +            ct3d->poison_list_cnt++;
> +        }
> +    }
> +    /* Any fragments have been added, free original entry */
> +    g_free(ent);
> +
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
>  #define IMMEDIATE_DATA_CHANGE (1 << 2)
>  #define IMMEDIATE_POLICY_CHANGE (1 << 3)
> @@ -543,6 +623,8 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
>          cmd_media_get_poison_list, 16, 0 },
>      [MEDIA_AND_POISON][INJECT_POISON] = { "MEDIA_AND_POISON_INJECT_POISON",
>          cmd_media_inject_poison, 8, 0 },
> +    [MEDIA_AND_POISON][CLEAR_POISON] = { "MEDIA_AND_POISON_CLEAR_POISON",
> +        cmd_media_clear_poison, 72, 0 },
>  };
>  
>  void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index ab600735eb..a247f506b7 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -947,6 +947,42 @@ static void set_lsa(CXLType3Dev *ct3d, const void *buf, uint64_t size,
>       */
>  }
>  
> +static bool set_cacheline(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data)
> +{
> +    MemoryRegion *vmr = NULL, *pmr = NULL;
> +    AddressSpace *as;
> +
> +    if (ct3d->hostvmem) {
> +        vmr = host_memory_backend_get_memory(ct3d->hostvmem);
> +    }
> +    if (ct3d->hostpmem) {
> +        pmr = host_memory_backend_get_memory(ct3d->hostpmem);
> +    }
> +
> +    if (!vmr && !pmr) {
> +        return false;
> +    }
> +
> +    if (dpa_offset + 64 > int128_get64(ct3d->cxl_dstate.mem_size)) {
> +        return false;
> +    }

Fails build:

https://gitlab.com/mstredhat/qemu/-/jobs/4313193004


> +
> +    if (vmr) {
> +        if (dpa_offset < memory_region_size(vmr)) {
> +            as = &ct3d->hostvmem_as;
> +        } else {
> +            as = &ct3d->hostpmem_as;
> +            dpa_offset -= memory_region_size(vmr);
> +        }
> +    } else {
> +        as = &ct3d->hostpmem_as;
> +    }
> +
> +    address_space_write(as, dpa_offset, MEMTXATTRS_UNSPECIFIED, &data,
> +                        CXL_CACHE_LINE_SIZE);
> +    return true;
> +}
> +
>  void cxl_set_poison_list_overflowed(CXLType3Dev *ct3d)
>  {
>          ct3d->poison_list_overflowed = true;
> @@ -1168,6 +1204,7 @@ static void ct3_class_init(ObjectClass *oc, void *data)
>      cvc->get_lsa_size = get_lsa_size;
>      cvc->get_lsa = get_lsa;
>      cvc->set_lsa = set_lsa;
> +    cvc->set_cacheline = set_cacheline;
>  }
>  
>  static const TypeInfo ct3d_info = {
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 32c234ea91..73328a52cf 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -298,6 +298,7 @@ struct CXLType3Class {
>                          uint64_t offset);
>      void (*set_lsa)(CXLType3Dev *ct3d, const void *buf, uint64_t size,
>                      uint64_t offset);
> +    bool (*set_cacheline)(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data);
>  };
>  
>  MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
> -- 
> 2.37.2

