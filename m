Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A121A705
	for <linux-cxl@vger.kernel.org>; Wed, 18 Oct 2023 14:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T6l2Rf1l"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEC13AB
	for <linux-cxl@vger.kernel.org>; Wed, 18 Oct 2023 07:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697640054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YRbO2H2P6MzOvYnJzmkxWGeWa2egnbgB6QkJouL37vA=;
	b=T6l2Rf1lLQbG+a8+ZAwc02EWtpTbXOkEPV0prsHMuNhfaOWtKxO7HBEKqUQdnb21LcLzUd
	DVf+4Bj2wZ37LlAbhf/3prqlrrVqwS/GpRPqbZwHfrQypno6t948DfR53eCt5It5xSGxEy
	zbgGDs7Zc9awxERFH8KxO06EfFcDUS0=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-M0FtwFRvNYe4WDLd86ZxPA-1; Wed, 18 Oct 2023 10:40:53 -0400
X-MC-Unique: M0FtwFRvNYe4WDLd86ZxPA-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5079c865541so5092605e87.3
        for <linux-cxl@vger.kernel.org>; Wed, 18 Oct 2023 07:40:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697640052; x=1698244852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YRbO2H2P6MzOvYnJzmkxWGeWa2egnbgB6QkJouL37vA=;
        b=VQzcLTxLxJ5xpy4bsEUyVceqxXyMn6HDCeiEweOWmSzxagshqibu2WmGyQy3yVGBc4
         S547gRWxRUkRAbPtTj04rE9Oq9RVxyXT2PZEwSeMxrSzz5mJ0fmOMJLwAduWj6soO/zB
         s5QKhuK+oG+9zAZp4KTTdcgZ4s5pKjkS8Lg/q7FVLzZaRVHkX+SiQvkX7ScpPu1RkeBJ
         0Mq5sGNOWr8E79xMFQg2l7Zqtak8HCymsXRu8SDe3iebY5r1LHZ4mPh+s06p6jVo6NbI
         P6qxi674x3X6OXOgO38l8eI9zz7KiLpFb2/ee+7VAasJM55rtqNiOkcxwRYu0UfjzK/6
         f7UA==
X-Gm-Message-State: AOJu0YzPYBFORmgpJnXyuarI/JwwpJ7++cTysdz5v2rats1wI6c94Evh
	hbJIRuc18XVuQSpn+WxW+TwQx1RD6LqDoW6XTC75x7Zg+H/vrSQloN34bUGMeC+iJnhaGWDKs1U
	TEAat5m944sYSjKdqcmLS
X-Received: by 2002:ac2:44cd:0:b0:4f9:586b:dba1 with SMTP id d13-20020ac244cd000000b004f9586bdba1mr3681276lfm.4.1697640052037;
        Wed, 18 Oct 2023 07:40:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEynFvChxtdJK5uQ2f8W5ySl3eOek4Ntg0aHf2q3hJpO74qDEaHSF5T8mEnEKrXyaY9zaiPOw==
X-Received: by 2002:ac2:44cd:0:b0:4f9:586b:dba1 with SMTP id d13-20020ac244cd000000b004f9586bdba1mr3681263lfm.4.1697640051574;
        Wed, 18 Oct 2023 07:40:51 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
        by smtp.gmail.com with ESMTPSA id f5-20020a5d50c5000000b003140f47224csm2284447wrt.15.2023.10.18.07.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 07:40:50 -0700 (PDT)
Date: Wed, 18 Oct 2023 10:40:45 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	Michael Tokarev <mjt@tls.msk.ru>, linuxarm@huawei.com,
	Fan Ni <fan.ni@samsung.com>,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 2/4] hw/cxl: Use switch statements for read and write
 of cachemem registers
Message-ID: <20231018103907-mutt-send-email-mst@kernel.org>
References: <20231012140514.3697-1-Jonathan.Cameron@huawei.com>
 <20231012140514.3697-3-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20231012140514.3697-3-Jonathan.Cameron@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 12, 2023 at 03:05:12PM +0100, Jonathan Cameron wrote:
> Establishing that only register accesses of size 4 and 8 can occur
> using these functions requires looking at their callers. Make it
> easier to see that by using switch statements.
> Assertions are used to enforce that the register storage is of the
> matching size, allowing fixed values to be used for divisors of
> the array indices.
> 
> Suggested-by: Michael Tokarev <mjt@tls.msk.ru>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>

Fails with clang:

../hw/cxl/cxl-component-utils.c:130:9: error: expected expression
        QEMU_BUILD_BUG_ON(sizeof(*cregs->cache_mem_regs_write_mask) != 4);
        ^
../include/qemu/compiler.h:76:30: note: expanded from macro 'QEMU_BUILD_BUG_ON'
#define QEMU_BUILD_BUG_ON(x) QEMU_BUILD_BUG_MSG(x, "not expecting: " #x)
                             ^
../include/qemu/compiler.h:74:36: note: expanded from macro 'QEMU_BUILD_BUG_MSG'
#define QEMU_BUILD_BUG_MSG(x, msg) _Static_assert(!(x), msg)
                                   ^
1 error generated.

See e.g.

https://gitlab.com/mstredhat/qemu/-/jobs/5320879531



> ---
> v4: Use QEMU_BUILD_BUG_ON() instead of static_assert with missing
>     error message.
> 
>  hw/cxl/cxl-component-utils.c | 65 +++++++++++++++++++++++-------------
>  1 file changed, 42 insertions(+), 23 deletions(-)
> 
> diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> index f3bbf0fd13..d1997a52e6 100644
> --- a/hw/cxl/cxl-component-utils.c
> +++ b/hw/cxl/cxl-component-utils.c
> @@ -67,16 +67,24 @@ static uint64_t cxl_cache_mem_read_reg(void *opaque, hwaddr offset,
>      CXLComponentState *cxl_cstate = opaque;
>      ComponentRegisters *cregs = &cxl_cstate->crb;
>  
> -    if (size == 8) {
> +    switch (size) {
> +    case 4:
> +        if (cregs->special_ops && cregs->special_ops->read) {
> +            return cregs->special_ops->read(cxl_cstate, offset, 4);
> +        } else {
> +            QEMU_BUILD_BUG_ON(sizeof(*cregs->cache_mem_registers) != 4);
> +            return cregs->cache_mem_registers[offset / 4];
> +        }
> +    case 8:
>          qemu_log_mask(LOG_UNIMP,
>                        "CXL 8 byte cache mem registers not implemented\n");
>          return 0;
> -    }
> -
> -    if (cregs->special_ops && cregs->special_ops->read) {
> -        return cregs->special_ops->read(cxl_cstate, offset, size);
> -    } else {
> -        return cregs->cache_mem_registers[offset / sizeof(*cregs->cache_mem_registers)];
> +    default:
> +        /*
> +         * In line with specifiction limitaions on access sizes, this
> +         * routine is not called with other sizes.
> +         */
> +        g_assert_not_reached();
>      }
>  }
>  
> @@ -117,25 +125,36 @@ static void cxl_cache_mem_write_reg(void *opaque, hwaddr offset, uint64_t value,
>      ComponentRegisters *cregs = &cxl_cstate->crb;
>      uint32_t mask;
>  
> -    if (size == 8) {
> +    switch (size) {
> +    case 4:
> +        QEMU_BUILD_BUG_ON(sizeof(*cregs->cache_mem_regs_write_mask) != 4);
> +        QEMU_BUILD_BUG_ON(sizeof(*cregs->cache_mem_registers) != 4);
> +        mask = cregs->cache_mem_regs_write_mask[offset / 4];
> +        value &= mask;
> +        /* RO bits should remain constant. Done by reading existing value */
> +        value |= ~mask & cregs->cache_mem_registers[offset / 4];
> +        if (cregs->special_ops && cregs->special_ops->write) {
> +            cregs->special_ops->write(cxl_cstate, offset, value, size);
> +            return;
> +        }
> +
> +        if (offset >= A_CXL_HDM_DECODER_CAPABILITY &&
> +            offset <= A_CXL_HDM_DECODER3_TARGET_LIST_HI) {
> +            dumb_hdm_handler(cxl_cstate, offset, value);
> +        } else {
> +            cregs->cache_mem_registers[offset / 4] = value;
> +        }
> +        return;
> +    case 8:
>          qemu_log_mask(LOG_UNIMP,
>                        "CXL 8 byte cache mem registers not implemented\n");
>          return;
> -    }
> -    mask = cregs->cache_mem_regs_write_mask[offset / sizeof(*cregs->cache_mem_regs_write_mask)];
> -    value &= mask;
> -    /* RO bits should remain constant. Done by reading existing value */
> -    value |= ~mask & cregs->cache_mem_registers[offset / sizeof(*cregs->cache_mem_registers)];
> -    if (cregs->special_ops && cregs->special_ops->write) {
> -        cregs->special_ops->write(cxl_cstate, offset, value, size);
> -        return;
> -    }
> -
> -    if (offset >= A_CXL_HDM_DECODER_CAPABILITY &&
> -        offset <= A_CXL_HDM_DECODER3_TARGET_LIST_HI) {
> -        dumb_hdm_handler(cxl_cstate, offset, value);
> -    } else {
> -        cregs->cache_mem_registers[offset / sizeof(*cregs->cache_mem_registers)] = value;
> +    default:
> +        /*
> +         * In line with specifiction limitaions on access sizes, this
> +         * routine is not called with other sizes.
> +         */
> +        g_assert_not_reached();
>      }
>  }
>  
> -- 
> 2.39.2

