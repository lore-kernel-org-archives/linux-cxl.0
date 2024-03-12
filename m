Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD953F4FA
	for <linux-cxl@vger.kernel.org>; Tue, 12 Mar 2024 15:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710257420; cv=none; b=cFrxCF5/yfUUevFrceHchSH2dTCD8s+e8/I7ow+3i9p4ddZxMW3fTEeno6333dQ1J+0NVUHEwNOIj5GIny/eVJDZp5yLbqLGFBpXa4WiOP9KQGhVQ0Fbbb4YJ63NikdSoFgGcF0IfXauoijuGcTRkrkklwfN2WLKAvhlbr+PU6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710257420; c=relaxed/simple;
	bh=V9FamKq6kfhe4OBJtHV1H+ZaS5YqGCtioyHtSCnbVo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=nSsuXLOUdYtPafxRew7Bxlt/IRt/sst5fKfBf1QKn/LBr9MHXmP2opEBlVErDMDRYUHLi5XJTpToYcMrdeQ6T0uJqZDjEdW0I6A769c2Wq4XwF0VtofcvUi6qYe6xFIAIiVvFjkKuRgK3dpWtdKf10aPKzSHia9g7dM/hf7GUtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jy7P9/XS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jy7P9/XS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710257416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=W8VyTvR5PrFnJnJ7a46rsJN039Y09OF2/36ICSHpR0c=;
	b=Jy7P9/XSJBTg0tfCSpf+q88GH25Pn2yuwPUXTF3aU5dTXHhQgGcHYA0IDqNDYS5cZk1EVQ
	ura2jB+PX7YMCoLfxro/vV8rMEuJqzhqWs0vLBta81Tklo38BtE6gxwxLdB/aw/KYU/s/y
	/zksKTOzsYvMcWOkdSSVNvLFPCFtFqg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-6e6WpfXAPbSwNYgybNPEkQ-1; Tue, 12 Mar 2024 11:30:12 -0400
X-MC-Unique: 6e6WpfXAPbSwNYgybNPEkQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-40e435a606aso33801465e9.3
        for <linux-cxl@vger.kernel.org>; Tue, 12 Mar 2024 08:30:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710257411; x=1710862211;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8VyTvR5PrFnJnJ7a46rsJN039Y09OF2/36ICSHpR0c=;
        b=ONJMQJ3LCjRrIXuWMul5Flt2LrhJYhmm2nFI1TB51+U/MJJGS03GD85Kp/xxo50aTT
         0erlD/ZRn6JhB/VZIMqS9KxIvkJFw7Ihv3yRHvUw9T5jAM6Uz1OVd8Yz+pMCl9lWl9Bk
         cTxKBT37j000XeCh6Q0hDE4HRO4VAh2knPs/BbyYREPXDK2CR/HT5jJZcZRzSvKHO0F+
         JIjcovpxx2xOFf0MPRGpIXd8CzOkZntlZ2KHTRIcH9rOEpTKoABm+O8QZZEm5XEhd7uy
         r+VwrX7UWeEv3FxcPALWO6eTSB7xilEXMYazhTU0R0oFhJWvsZFuAJ0aFlZuaAuyleAg
         SvaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQXPNRu/wUVpi9/ADrO6L5AwzKDMZq9k2puXyS1oGJEqY+FR3dLhrfigxHmxgYoQUpPTFowWs9pXoSFTAyCt0g+9y++Z60bR3a
X-Gm-Message-State: AOJu0YysTgPJXTGBxEB8LYI9WTE2Bzq5Z36CAh/AHXRw90OUNH4tqT/Y
	Gn4dyuDk1WwX6Y28+pWyizPsfOuWSjakhmAC0iOe5Q2dwfVN2hwM7dRUk6LXELVKedi+5XgByu7
	lggf1xvBc1Gu6L0sRen/FXqUM8pD2z9r9ejInosTJ4vap70wJJdGiLWjQDA==
X-Received: by 2002:a05:6000:4c5:b0:33e:4238:8615 with SMTP id h5-20020a05600004c500b0033e42388615mr1551839wri.40.1710257411245;
        Tue, 12 Mar 2024 08:30:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHK5WS+eGqgp3kYusTzwQf+XUw1rUYo2gh6xiOZyJOnU1q4ssFtxrQ6mKai2iGpgF2zpb7ogQ==
X-Received: by 2002:a05:6000:4c5:b0:33e:4238:8615 with SMTP id h5-20020a05600004c500b0033e42388615mr1551828wri.40.1710257410716;
        Tue, 12 Mar 2024 08:30:10 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:532c:5ae4:fce6:76e1:fa1a])
        by smtp.gmail.com with ESMTPSA id i17-20020adfefd1000000b0033e7503ce7esm9265547wrp.46.2024.03.12.08.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Mar 2024 08:30:10 -0700 (PDT)
Date: Tue, 12 Mar 2024 11:30:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Fan Ni <nifan.cxl@gmail.com>,
	linuxarm@huawei.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH qemu] hw/pci-bridge/pxb-cxl: Drop RAS capability from
 host bridge.
Message-ID: <20240312112942-mutt-send-email-mst@kernel.org>
References: <20240215155206.2736-1-Jonathan.Cameron@huawei.com>
 <20240215111117-mutt-send-email-mst@kernel.org>
 <20240215174212.000057c9@Huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240215174212.000057c9@Huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 15, 2024 at 05:42:12PM +0000, Jonathan Cameron wrote:
> On Thu, 15 Feb 2024 11:11:47 -0500
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Thu, Feb 15, 2024 at 03:52:06PM +0000, Jonathan Cameron wrote:
> > > This CXL component isn't allowed to have a RAS capability.
> > > Whilst this should be harmless as software is not expected to look
> > > here, good to clean it up.
> > > 
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> > 
> > Isn't this device migrateable? If yes you need compat
> > handling.
> 
> Not yet. Migrating these is broken in lots of ways :(
> 
> Given they are functional emulation only I've never cared that much.
> We'll need to fix this as part of adding support for virtualization
> use cases which start to make sense when dynamic capacity
> support lands in kernel + QEMU (probably later this year)
> 
> Jonathan


should probably block migration then?

> > 
> > 
> > > ---
> > >  I've been carrying this on my tree for quite a while.
> > >  This wasn't in previous fixes set because it's low priority and
> > >  rebasing it across cleanup series that followed those fixes was
> > >  too fiddly to bother.
> > >  
> > >  include/hw/cxl/cxl_component.h      |  1 +
> > >  hw/cxl/cxl-component-utils.c        | 21 +++++++++++++++++----
> > >  hw/pci-bridge/pci_expander_bridge.c |  2 +-
> > >  3 files changed, 19 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
> > > index 0e5d35c263..5012fab6f7 100644
> > > --- a/include/hw/cxl/cxl_component.h
> > > +++ b/include/hw/cxl/cxl_component.h
> > > @@ -25,6 +25,7 @@ enum reg_type {
> > >      CXL2_TYPE3_DEVICE,
> > >      CXL2_LOGICAL_DEVICE,
> > >      CXL2_ROOT_PORT,
> > > +    CXL2_RC,
> > >      CXL2_UPSTREAM_PORT,
> > >      CXL2_DOWNSTREAM_PORT,
> > >      CXL3_SWITCH_MAILBOX_CCI,
> > > diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> > > index 84ab503325..cd116c0401 100644
> > > --- a/hw/cxl/cxl-component-utils.c
> > > +++ b/hw/cxl/cxl-component-utils.c
> > > @@ -297,6 +297,7 @@ void cxl_component_register_init_common(uint32_t *reg_state,
> > >          caps = 3;
> > >          break;
> > >      case CXL2_ROOT_PORT:
> > > +    case CXL2_RC:
> > >          /* + Extended Security, + Snoop */
> > >          caps = 5;
> > >          break;
> > > @@ -326,8 +327,19 @@ void cxl_component_register_init_common(uint32_t *reg_state,
> > >                         CXL_##reg##_REGISTERS_OFFSET);                         \
> > >      } while (0)
> > >  
> > > +    switch (type) {
> > > +    case CXL2_DEVICE:
> > > +    case CXL2_TYPE3_DEVICE:
> > > +    case CXL2_LOGICAL_DEVICE:
> > > +    case CXL2_ROOT_PORT:
> > > +    case CXL2_UPSTREAM_PORT:
> > > +    case CXL2_DOWNSTREAM_PORT:
> > >      init_cap_reg(RAS, 2, CXL_RAS_CAPABILITY_VERSION);
> > > -    ras_init_common(reg_state, write_msk);
> > > +        ras_init_common(reg_state, write_msk);
> > > +        break;
> > > +    default:
> > > +        break;
> > > +    }
> > >  
> > >      init_cap_reg(LINK, 4, CXL_LINK_CAPABILITY_VERSION);
> > >  
> > > @@ -335,9 +347,10 @@ void cxl_component_register_init_common(uint32_t *reg_state,
> > >          return;
> > >      }
> > >  
> > > -    init_cap_reg(HDM, 5, CXL_HDM_CAPABILITY_VERSION);
> > > -    hdm_init_common(reg_state, write_msk, type);
> > > -
> > > +    if (type != CXL2_ROOT_PORT) {
> > > +        init_cap_reg(HDM, 5, CXL_HDM_CAPABILITY_VERSION);
> > > +        hdm_init_common(reg_state, write_msk, type);
> > > +    }
> > >      if (caps < 5) {
> > >          return;
> > >      }
> > > diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> > > index 535889f7c2..0411ad31ea 100644
> > > --- a/hw/pci-bridge/pci_expander_bridge.c
> > > +++ b/hw/pci-bridge/pci_expander_bridge.c
> > > @@ -290,7 +290,7 @@ static void pxb_cxl_dev_reset(DeviceState *dev)
> > >      uint32_t *write_msk = cxl_cstate->crb.cache_mem_regs_write_mask;
> > >      int dsp_count = 0;
> > >  
> > > -    cxl_component_register_init_common(reg_state, write_msk, CXL2_ROOT_PORT);
> > > +    cxl_component_register_init_common(reg_state, write_msk, CXL2_RC);
> > >      /*
> > >       * The CXL specification allows for host bridges with no HDM decoders
> > >       * if they only have a single root port.
> > > -- 
> > > 2.39.2  
> > 

