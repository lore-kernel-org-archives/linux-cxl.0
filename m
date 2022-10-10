Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199BFC433F5
	for <linux-cxl@archiver.kernel.org>; Mon, 10 Oct 2022 20:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbiJJUHd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 10 Oct 2022 16:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbiJJUHc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 10 Oct 2022 16:07:32 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BF561D59
        for <linux-cxl@vger.kernel.org>; Mon, 10 Oct 2022 13:07:28 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id DB21D100E2E;
        Mon, 10 Oct 2022 19:57:45 +0000 (UTC)
Received: from pdx1-sub0-mail-a308 (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 299F1100A94;
        Mon, 10 Oct 2022 19:57:39 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1665431859; a=rsa-sha256;
        cv=none;
        b=cbN3PJIx5fRTO/GopAjfi1ATxgUAyYx6x0yqg5tEcXQR8xp+zCZQORUzVRRSnwKI81gsex
        rJ20WPdsnL3bUHfqf7FoRyJrxh77RtbI1BKj7LZD2+++/C6F3oaM52LYEAYx8KSBx4lUEc
        XG8kz2/65XFyGDj0WMhkZD4MgTo9195bQVC5f6NVt9YEq7MjRuprU69OTbF+7n8vaG9K0l
        m10ERoazRDo53uKzcYwwiprZO17gQju3UNw8awJp6QECVtujuncvNUqMc3AvVnFlv5Xk6Z
        E+KZ6RC3mYV7iSeQu/Ykcofw18rvGFSRQyMUng2apAm7I8J3MpgG0ujfBP+Ytw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1665431859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=cAFzobHNf3aCdzwAKwA1e5eHYrBiFL/qJog0vxhzE1A=;
        b=s/bu/pX5J86O6RTVemwVV/ciRrDuCr31WfxXJ1w4rBnWmdelcb8tyqltVXwVn9zMv92mOs
        kiF9CyLOFjpRgd01BCNiGCL9ncHIaUzqbYRSgvG7GSitFpLhVNg6rnkFkQfRjA9Sxu4sGr
        5BcAo5KNOLHTLoKMWgfyvwgBCvonwvbW05N1P2eG9gNa3K1i0oTNxzijGcFJM7ka/dLhWG
        /SN+M4WzPNTfRBpndcvRBb6l5FDt6sPaJrmqqygx4RBFHHqJHeiKT+AwRyMQNEO25QjgHq
        f3kE5RE9ZwwoiXrFrMcDA/FSkm2IYvTMKCu7GE69AdcuL4xg2T4l2K+OoykErQ==
ARC-Authentication-Results: i=1;
        rspamd-5798657bcf-9n8kl;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Abiding-Inform: 32d235f83e075cfd_1665431859500_2303338479
X-MC-Loop-Signature: 1665431859500:1494071168
X-MC-Ingress-Time: 1665431859500
Received: from pdx1-sub0-mail-a308 (pop.dreamhost.com [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.106.246.149 (trex/6.7.1);
        Mon, 10 Oct 2022 19:57:39 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a308 (Postfix) with ESMTPSA id 4MmV7k2D73z3d;
        Mon, 10 Oct 2022 12:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1665431858;
        bh=cAFzobHNf3aCdzwAKwA1e5eHYrBiFL/qJog0vxhzE1A=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=mdB8PxwnGbIE6upJ34TW8XLipHCkF/6HRL2/lPgPFPP4XP0DywnTPZhevcT/qgStt
         zadacf3ewoJURsRRBTFkIzQNbckvsc1Rs12959cMcR3WZ5M9OHUFnxvQ3lwhoTAPGR
         BldKz2SXWJ9rBBfCt9Qll6A/Lx+I90BN4uj6VrBVuTsFpdI9MKPT1/8BA0eF0h4yFD
         +QCoRoelg4wFC12wmLphvGa66qrzVOwYdFF62KJr5xP8AF0+yMJWSdr49zz/To3yzC
         S+bY83LQt0TstPsKEixZTVcRO9HIbHAtMqsGTgziP2J1eS/Fs55dV7lxT+RnFAf2sp
         GET+5+7hcvNtg==
Date:   Mon, 10 Oct 2022 12:36:54 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Gregory Price <gourry.memverge@gmail.com>
Cc:     qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
        linux-cxl@vger.kernel.org, alison.schofield@intel.com,
        a.manzanares@samsung.com, bwidawsk@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH 2/2] hw/cxl: Allow CXL type-3 devices to be persistent or
 volatile
Message-ID: <20221010193654.khne63svaaf3piz4@offworld>
References: <20221006233702.18532-1-gregory.price@memverge.com>
 <20221006233702.18532-2-gregory.price@memverge.com>
 <20221010171229.let7egonsflyjixh@offworld>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20221010171229.let7egonsflyjixh@offworld>
User-Agent: NeoMutt/20220429
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 10 Oct 2022, Davidlohr Bueso wrote:

>This hides requirement details as to the necessary changes that are needed for
>volatile support - for example, build_dvsecs(). Imo using two backends (without
>breaking current configs, of course) should be the initial version, not something
>to leave pending.

Minimally this is along the lines I was thinking of. I rebased some of my original
patches on top of yours. It builds and passes tests/qtest/cxl-test, but certainly
untested otherwise. The original code did show the volatile support as per cxl-list.

As such users can still use memdev which will map to the pmemdev. One thing which I
had not explored was the lsa + vmem thing, so the below prevents this for the time
being, fyi.

Thanks,
Davidlohr

----8<----------------------------------------------------

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index e8341a818467..cd079dbddd9a 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -18,14 +18,21 @@ static void build_dvsecs(CXLType3Dev *ct3d)
  {
      CXLComponentState *cxl_cstate = &ct3d->cxl_cstate;
      uint8_t *dvsec;
+    uint64_t size = 0;
+
+    if (ct3d->hostvmem) {
+        size += ct3d->hostvmem->size;
+    }
+    if (ct3d->hostpmem) {
+        size += ct3d->hostpmem->size;
+    }

      dvsec = (uint8_t *)&(CXLDVSECDevice){
-        .cap = 0x1e,
+        .cap = 0x1e, /* one HDM range */
	 .ctrl = 0x2,
	 .status2 = 0x2,
-        .range1_size_hi = ct3d->hostmem->size >> 32,
-        .range1_size_lo = (2 << 5) | (2 << 2) | 0x3 |
-        (ct3d->hostmem->size & 0xF0000000),
+        .range1_size_hi = size >> 32,
+        .range1_size_lo = (2 << 5) | (2 << 2) | 0x3 | (size & 0xF0000000),
	 .range1_base_hi = 0,
	 .range1_base_lo = 0,
      };
@@ -98,70 +105,60 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
  static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
  {
      DeviceState *ds = DEVICE(ct3d);
-    MemoryRegion *mr;
      char *name;
-    bool is_pmem = false;

-    /*
-     * FIXME: For now we only allow a single host memory region.
-     * Handle the deprecated memdev property usage cases
-     */
-    if (!ct3d->hostmem && !ct3d->host_vmem && !ct3d->host_pmem) {
+    if (!ct3d->hostvmem && !ct3d->hostpmem) {
	 error_setg(errp, "at least one memdev property must be set");
	 return false;
-    } else if (ct3d->hostmem && (ct3d->host_vmem || ct3d->host_pmem)) {
-        error_setg(errp, "deprecated [memdev] cannot be used with new "
-                         "persistent and volatile memdev properties");
-        return false;
-    } else if (ct3d->hostmem) {
-        warn_report("memdev is deprecated and defaults to pmem. "
-                    "Use (persistent|volatile)-memdev instead.");
-        is_pmem = true;
-    } else {
-        if (ct3d->host_vmem && ct3d->host_pmem) {
-            error_setg(errp, "Multiple memory devices not supported yet");
-            return false;
-        }
-        is_pmem = !!ct3d->host_pmem;
-        ct3d->hostmem = ct3d->host_pmem ? ct3d->host_pmem : ct3d->host_vmem;
      }

-    /*
-     * for now, since there is only one memdev, we can set the type
-     * based on whether this was a ram region or file region
-     */
-    mr = host_memory_backend_get_memory(ct3d->hostmem);
-    if (!mr) {
-        error_setg(errp, "memdev property must be set");
+    /* TODO: volatile devices may have LSA */
+    if (ct3d->hostvmem && ct3d->lsa) {
+        error_setg(errp, "lsa property must be set");
	 return false;
      }

-    /*
-     * FIXME: This code should eventually enumerate each memory region and
-     * report vmem and pmem capacity separate, but for now just set to one
-     */
-    memory_region_set_nonvolatile(mr, is_pmem);
-    memory_region_set_enabled(mr, true);
-    host_memory_backend_set_mapped(ct3d->hostmem, true);
-
      if (ds->id) {
	 name = g_strdup_printf("cxl-type3-dpa-space:%s", ds->id);
      } else {
	 name = g_strdup("cxl-type3-dpa-space");
      }
-    address_space_init(&ct3d->hostmem_as, mr, name);
-    g_free(name);

-    /* FIXME: When multiple regions are supported, this needs to aggregate */
-    ct3d->cxl_dstate.mem_size = ct3d->hostmem->size;
-    ct3d->cxl_dstate.vmem_size = is_pmem ? 0 : ct3d->hostmem->size;
-    ct3d->cxl_dstate.pmem_size = is_pmem ? ct3d->hostmem->size : 0;
+    if (ct3d->hostvmem) {
+        MemoryRegion *vmr;

-    if (!ct3d->lsa) {
-        error_setg(errp, "lsa property must be set");
-        return false;
+        vmr = host_memory_backend_get_memory(ct3d->hostvmem);
+        if (!vmr) {
+            error_setg(errp, "volatile-memdev property must be set");
+            return false;
+        }
+
+        memory_region_set_nonvolatile(vmr, false);
+        memory_region_set_enabled(vmr, true);
+        host_memory_backend_set_mapped(ct3d->hostvmem, true);
+        address_space_init(&ct3d->hostvmem_as, vmr, name);
+        ct3d->cxl_dstate.vmem_size = ct3d->hostvmem->size;
+        ct3d->cxl_dstate.mem_size += ct3d->hostvmem->size;
      }

+    if (ct3d->hostpmem) {
+        MemoryRegion *pmr;
+
+        pmr = host_memory_backend_get_memory(ct3d->hostpmem);
+        if (!pmr) {
+            error_setg(errp, "legacy memdev or persistent-memdev property must be set");
+            return false;
+        }
+
+        memory_region_set_nonvolatile(pmr, true);
+        memory_region_set_enabled(pmr, true);
+        host_memory_backend_set_mapped(ct3d->hostpmem, true);
+        address_space_init(&ct3d->hostpmem_as, pmr, name);
+        ct3d->cxl_dstate.pmem_size = ct3d->hostpmem->size;
+        ct3d->cxl_dstate.mem_size += ct3d->hostpmem->size;
+    }
+    g_free(name);
+
      return true;
  }

@@ -210,7 +207,13 @@ static void ct3_exit(PCIDevice *pci_dev)
      ComponentRegisters *regs = &cxl_cstate->crb;

      g_free(regs->special_ops);
-    address_space_destroy(&ct3d->hostmem_as);
+
+    if (ct3d->hostvmem) {
+        address_space_destroy(&ct3d->hostvmem_as);
+    }
+    if (ct3d->hostpmem) {
+        address_space_destroy(&ct3d->hostpmem_as);
+    }
  }

  /* TODO: Support multiple HDM decoders and DPA skip */
@@ -249,47 +252,86 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
			    unsigned size, MemTxAttrs attrs)
  {
      CXLType3Dev *ct3d = CXL_TYPE3(d);
-    uint64_t dpa_offset;
-    MemoryRegion *mr;
+    uint64_t total_size = 0, dpa_offset;
+    MemoryRegion *vmr, *pmr;

-    /* TODO support volatile region */
-    mr = host_memory_backend_get_memory(ct3d->hostmem);
-    if (!mr) {
+    vmr = host_memory_backend_get_memory(ct3d->hostvmem);
+    pmr = host_memory_backend_get_memory(ct3d->hostpmem);
+    if (!vmr && !pmr) {
	 return MEMTX_ERROR;
      }

+    if (vmr) {
+        total_size += vmr->size;
+    }
+    if (pmr) {
+        total_size += pmr->size;
+    }
      if (!cxl_type3_dpa(ct3d, host_addr, &dpa_offset)) {
	 return MEMTX_ERROR;
      }
-
-    if (dpa_offset > int128_get64(mr->size)) {
+    if (dpa_offset > total_size) {
	 return MEMTX_ERROR;
      }

-    return address_space_read(&ct3d->hostmem_as, dpa_offset, attrs, data, size);
+    if (vmr) {
+        /* volatile starts at DPA 0 */
+        if (dpa_offset <= int128_get64(vmr->size)) {
+            return address_space_read(&ct3d->hostvmem_as,
+                                  dpa_offset, attrs, data, size);
+        }
+    }
+    if (pmr) {
+        if (dpa_offset > int128_get64(pmr->size)) {
+            return MEMTX_ERROR;
+        }
+        return address_space_read(&ct3d->hostpmem_as, dpa_offset,
+                                  attrs, data, size);
+    }
+
+    return MEMTX_ERROR;
  }

  MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
			     unsigned size, MemTxAttrs attrs)
  {
      CXLType3Dev *ct3d = CXL_TYPE3(d);
-    uint64_t dpa_offset;
-    MemoryRegion *mr;
+    uint64_t total_size = 0, dpa_offset;
+    MemoryRegion *vmr, *pmr;

-    mr = host_memory_backend_get_memory(ct3d->hostmem);
-    if (!mr) {
+    vmr = host_memory_backend_get_memory(ct3d->hostpmem);
+    pmr = host_memory_backend_get_memory(ct3d->hostpmem);
+    if (!vmr && !pmr) {
	 return MEMTX_OK;
      }
-
+    if (vmr) {
+        total_size += vmr->size;
+    }
+    if (pmr) {
+        total_size += pmr->size;
+    }
      if (!cxl_type3_dpa(ct3d, host_addr, &dpa_offset)) {
	 return MEMTX_OK;
      }
+    if (dpa_offset > total_size) {
+        return MEMTX_ERROR;
+    }

-    if (dpa_offset > int128_get64(mr->size)) {
-        return MEMTX_OK;
+    if (vmr) {
+        if (dpa_offset <= int128_get64(vmr->size)) {
+                return address_space_write(&ct3d->hostvmem_as,
+                                  dpa_offset, attrs, &data, size);
+        }
      }
-    return address_space_write(&ct3d->hostmem_as, dpa_offset, attrs,
+    if (pmr) {
+        if (dpa_offset > int128_get64(pmr->size)) {
+            return MEMTX_OK;
+        }
+        return address_space_write(&ct3d->hostpmem_as, dpa_offset, attrs,
				&data, size);
+    }
+
+    return MEMTX_ERROR;
  }

  static void ct3d_reset(DeviceState *dev)
@@ -303,11 +345,11 @@ static void ct3d_reset(DeviceState *dev)
  }

  static Property ct3_props[] = {
-    DEFINE_PROP_LINK("memdev", CXLType3Dev, hostmem, TYPE_MEMORY_BACKEND,
-                     HostMemoryBackend *),
-    DEFINE_PROP_LINK("persistent-memdev", CXLType3Dev, host_pmem,
+    DEFINE_PROP_LINK("memdev", CXLType3Dev, hostpmem, TYPE_MEMORY_BACKEND,
+                     HostMemoryBackend *), /* for backward-compatibility */
+    DEFINE_PROP_LINK("persistent-memdev", CXLType3Dev, hostpmem,
		      TYPE_MEMORY_BACKEND, HostMemoryBackend *),
-    DEFINE_PROP_LINK("volatile-memdev", CXLType3Dev, host_vmem,
+    DEFINE_PROP_LINK("volatile-memdev", CXLType3Dev, hostvmem,
		      TYPE_MEMORY_BACKEND, HostMemoryBackend *),
      DEFINE_PROP_LINK("lsa", CXLType3Dev, lsa, TYPE_MEMORY_BACKEND,
		      HostMemoryBackend *),
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index fd96a5ea4e47..c81f92ecf093 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -237,14 +237,13 @@ struct CXLType3Dev {
      PCIDevice parent_obj;

      /* Properties */
-    /* TODO: remove hostmem when multi-dev is implemented */
-    HostMemoryBackend *hostmem;
-    HostMemoryBackend *host_vmem;
-    HostMemoryBackend *host_pmem;
+    HostMemoryBackend *hostvmem;
+    HostMemoryBackend *hostpmem;
      HostMemoryBackend *lsa;

      /* State */
-    AddressSpace hostmem_as;
+    AddressSpace hostvmem_as;
+    AddressSpace hostpmem_as;
      CXLComponentState cxl_cstate;
      CXLDeviceState cxl_dstate;
  };
