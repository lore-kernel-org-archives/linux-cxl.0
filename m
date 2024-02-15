Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8F213342F
	for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 16:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708013518; cv=none; b=O+KohbAX9gDam6cfgF7RZW638FuncrcMumjlhvyfNzwE5LLC7t7RCD04aHFNeGEFnpyn0WqDbQQPV6R9dlniTwRHWk4zKa6o6kE7HVkXD4yRu51oeDXSCApOAtRh5Hzo1qqOWnt0nEzwHErg5dNFdxMQ/0I/ogRYVn0k/2SWpLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708013518; c=relaxed/simple;
	bh=G7TpBdtevRtmKLbf3Xk0IYn7xGtLG1dtOeZqODFRGPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Ap7irGddEmUREKWRnzs1nCj84fVFooZgtPtcVVe/7UDDcIFYkwaIIfe8N0w8YvJsU+fRwFo0uGhqOCdIq6L1GwSQk5jDDCpCSMGwxobycXMjFIgOPED/8PLCyqjyuQAaq87QlR14FlMD9IBESuWGeIKr3lgLRzSlZg8DVBvru6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NgKe46Xp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NgKe46Xp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708013515;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lzY7IDUdcAxUniLLkkMGJRvisr0M+0m9/4Bx06+xM1k=;
	b=NgKe46Xp6V3P93K/wqUvRYgWyDbHnJFkrvWeW+78ekloM3nJxrUPJizP3gD2ovknSXiXKd
	i323OnP6aVBhQZmUyc1RTfnOdh2NpAv24VNDsZMrzzwveKQaMf49opUcbAUiechSvtS5fY
	ff5L4D39lZ2GoTwtaDXFaYjiwdxreXQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-yjr5VZVWPxKxNqpQ2-dClQ-1; Thu, 15 Feb 2024 11:11:54 -0500
X-MC-Unique: yjr5VZVWPxKxNqpQ2-dClQ-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-563c5642290so229550a12.0
        for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 08:11:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708013512; x=1708618312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lzY7IDUdcAxUniLLkkMGJRvisr0M+0m9/4Bx06+xM1k=;
        b=HDkPtMLlJQyixTPh+0ETRmrxpzDpCoZcv/x1Y8ujbhVoE1iiZ9xJaCQLZSEbLPa+K9
         IW1xzznV2XHM7qQD90PfwhYgVRF5djvJ+rBx7vAIkoFdyvZs/CZSxDSJBDDDvpWImrcl
         Ou0e535V5Ja/BndWq5aLMkDY0qSX5sayLG8+bv2ogu/OfI/Hu8TNm/diXg7K/3c/KYeR
         OyqMu7dBqDiL2MH+A5aPiShoUSvSUT+cvszVwd/h/Rr1p2h7UzyRDVLB6GM4qp00Z/2Z
         X7IHdA3F+YlxFu3w2E6686olF2xoZbm5mn1pZlg+1jh4X9qEDgGBjvpwXIo1tn1n8Hvy
         OUmA==
X-Forwarded-Encrypted: i=1; AJvYcCUNFyg2OP0MJM113xkH+Kn54EW/T6dgZGntNwoAipf51XTv8gg/rEz9g0mLYoKSCSuGAWwbPpdjAAKl2qTICpf9NsUaYrutK8ZX
X-Gm-Message-State: AOJu0YyD8Ie9VZkhEsM46mdwCS/w3cPpybxzDdUG7ZSJ4VeZrPhEYMU0
	7QBSMZPR0phh8nD+0uwe9lvQTKxgx7W+EwcyElzsUCVgRGq4MN+RgQ34TeE18HPzG9NWUuJFd+0
	QmD+mEb3A1WzxY0QLTlfA+m5XMGXDKTik2r5QzfhUflUcexoDNgDmJR1VqhgNhjcnWg==
X-Received: by 2002:aa7:c655:0:b0:561:8918:9f5d with SMTP id z21-20020aa7c655000000b0056189189f5dmr1977390edr.20.1708013511994;
        Thu, 15 Feb 2024 08:11:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHvjBbm9OaqwxpikSO5sj9WOmhPay0asdnhbSR49JEmAaBkiD3BApC42ulKBswKxKdBrPp0VQ==
X-Received: by 2002:aa7:c655:0:b0:561:8918:9f5d with SMTP id z21-20020aa7c655000000b0056189189f5dmr1977377edr.20.1708013511706;
        Thu, 15 Feb 2024 08:11:51 -0800 (PST)
Received: from redhat.com ([2.52.14.124])
        by smtp.gmail.com with ESMTPSA id g20-20020a056402091400b00563a86979dcsm690941edz.42.2024.02.15.08.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 08:11:51 -0800 (PST)
Date: Thu, 15 Feb 2024 11:11:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Fan Ni <nifan.cxl@gmail.com>,
	linuxarm@huawei.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH qemu] hw/pci-bridge/pxb-cxl: Drop RAS capability from
 host bridge.
Message-ID: <20240215111117-mutt-send-email-mst@kernel.org>
References: <20240215155206.2736-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240215155206.2736-1-Jonathan.Cameron@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 15, 2024 at 03:52:06PM +0000, Jonathan Cameron wrote:
> This CXL component isn't allowed to have a RAS capability.
> Whilst this should be harmless as software is not expected to look
> here, good to clean it up.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Isn't this device migrateable? If yes you need compat
handling.


> ---
>  I've been carrying this on my tree for quite a while.
>  This wasn't in previous fixes set because it's low priority and
>  rebasing it across cleanup series that followed those fixes was
>  too fiddly to bother.
>  
>  include/hw/cxl/cxl_component.h      |  1 +
>  hw/cxl/cxl-component-utils.c        | 21 +++++++++++++++++----
>  hw/pci-bridge/pci_expander_bridge.c |  2 +-
>  3 files changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
> index 0e5d35c263..5012fab6f7 100644
> --- a/include/hw/cxl/cxl_component.h
> +++ b/include/hw/cxl/cxl_component.h
> @@ -25,6 +25,7 @@ enum reg_type {
>      CXL2_TYPE3_DEVICE,
>      CXL2_LOGICAL_DEVICE,
>      CXL2_ROOT_PORT,
> +    CXL2_RC,
>      CXL2_UPSTREAM_PORT,
>      CXL2_DOWNSTREAM_PORT,
>      CXL3_SWITCH_MAILBOX_CCI,
> diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> index 84ab503325..cd116c0401 100644
> --- a/hw/cxl/cxl-component-utils.c
> +++ b/hw/cxl/cxl-component-utils.c
> @@ -297,6 +297,7 @@ void cxl_component_register_init_common(uint32_t *reg_state,
>          caps = 3;
>          break;
>      case CXL2_ROOT_PORT:
> +    case CXL2_RC:
>          /* + Extended Security, + Snoop */
>          caps = 5;
>          break;
> @@ -326,8 +327,19 @@ void cxl_component_register_init_common(uint32_t *reg_state,
>                         CXL_##reg##_REGISTERS_OFFSET);                         \
>      } while (0)
>  
> +    switch (type) {
> +    case CXL2_DEVICE:
> +    case CXL2_TYPE3_DEVICE:
> +    case CXL2_LOGICAL_DEVICE:
> +    case CXL2_ROOT_PORT:
> +    case CXL2_UPSTREAM_PORT:
> +    case CXL2_DOWNSTREAM_PORT:
>      init_cap_reg(RAS, 2, CXL_RAS_CAPABILITY_VERSION);
> -    ras_init_common(reg_state, write_msk);
> +        ras_init_common(reg_state, write_msk);
> +        break;
> +    default:
> +        break;
> +    }
>  
>      init_cap_reg(LINK, 4, CXL_LINK_CAPABILITY_VERSION);
>  
> @@ -335,9 +347,10 @@ void cxl_component_register_init_common(uint32_t *reg_state,
>          return;
>      }
>  
> -    init_cap_reg(HDM, 5, CXL_HDM_CAPABILITY_VERSION);
> -    hdm_init_common(reg_state, write_msk, type);
> -
> +    if (type != CXL2_ROOT_PORT) {
> +        init_cap_reg(HDM, 5, CXL_HDM_CAPABILITY_VERSION);
> +        hdm_init_common(reg_state, write_msk, type);
> +    }
>      if (caps < 5) {
>          return;
>      }
> diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> index 535889f7c2..0411ad31ea 100644
> --- a/hw/pci-bridge/pci_expander_bridge.c
> +++ b/hw/pci-bridge/pci_expander_bridge.c
> @@ -290,7 +290,7 @@ static void pxb_cxl_dev_reset(DeviceState *dev)
>      uint32_t *write_msk = cxl_cstate->crb.cache_mem_regs_write_mask;
>      int dsp_count = 0;
>  
> -    cxl_component_register_init_common(reg_state, write_msk, CXL2_ROOT_PORT);
> +    cxl_component_register_init_common(reg_state, write_msk, CXL2_RC);
>      /*
>       * The CXL specification allows for host bridges with no HDM decoders
>       * if they only have a single root port.
> -- 
> 2.39.2

