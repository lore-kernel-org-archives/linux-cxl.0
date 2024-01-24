Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB8912AAC0
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jan 2024 18:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706122625; cv=none; b=W7J0+utI3Up10YdpnhwHBANRz+2HOh7oult5iZAxh9IY2Ahh1rUZdOq0kkA/z+//s2yVAO93sQz4BgGVW7Xnn40Rh0Cd9RXkJiAyOhYyLE0qyFK7+UiEGqt+eFkTpNc5iBCXlI+pNeZ7+5FVucOlqgOfQXJRAtEQB9qa1k6plcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706122625; c=relaxed/simple;
	bh=VShdrTvSXYAjB+5jvkC2icWvtvk4BQVDPgR9bndQwm8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GyapByWBv9Kt074V110EpaBaMu5X4doWX22oW5EIA977VKpqFU54evb/3DHWyym2gpzUM0y4N/5QuoxVRALmNUt+aY5/V9zM594UbYGdCeGs2md3Eu2pVhDpU3Nd/SP2wFDhvC0BnJismTsJb8jt8VzZ9TkQWncSpkDReXJw1DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nQ/Z/UBG; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nQ/Z/UBG"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d51ba18e1bso53187495ad.0
        for <linux-cxl@vger.kernel.org>; Wed, 24 Jan 2024 10:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706122623; x=1706727423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nqMBNzZx3ZE2LKLPN5406gk/QS3v52I3gK5sU8RKhzc=;
        b=nQ/Z/UBG95tPNb3uCf9WfdDqrZU914OdivFq7UtyPQoFnAWehgkW6skQ/0ImxaIRrU
         KraFodBK+nKySLoeKtIDKNopE2FRGlutYuSdbmI2oGTefjRdf/yatfLELzYTINkgFc9O
         A5W3CQmq5s4WnWPW9Fo9CFSVA6qT8c0ruYKV0QoO6iOj6mgDHtc8EduJgTtJYji3ZIJ7
         sg/vJDBnQaN4q4BB2RYbaYcDXTZ7l81n07vGsT1TeDUSSnYsSWC9CDF7ZNvXd4zyMmz8
         BZ0ydCvJHZIs0gmt8cThKh7SrisacPJqecFpht/4Zl3r3+l5ykli+rKFN0e0qcSH8010
         BnZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706122623; x=1706727423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nqMBNzZx3ZE2LKLPN5406gk/QS3v52I3gK5sU8RKhzc=;
        b=kkM+aif+YtX9C4MooaKoBN5URqtGO0a30oelUu8hDcFTgtVUOG/MqEYdoic/DPxGrB
         Lp97DoGisElZY+V/plWRo3UFzzOyVFUBUc5AijRIeGIby3oiu+5BvznlFlYpBZHBSier
         EYX9l7tyaujS0cgvBmriiQpX50vO25TDlCCLdAd7BFET/Cbg0jVIWRQDUwY+gMExkjDa
         ABq1CdETld9+wewvWrWiMoecTZZd4hQiGjR619XdlmDayn0ujj2tJAWM5/KpSi8nm9eN
         G6yJjEjmIKgJczOpTkO6++r/aIlPmqrr08ALyb3Os7Rw0dUFtRXPdyWh8YHklvep0P2V
         7Q1A==
X-Gm-Message-State: AOJu0Yw09upJN1fE6fXM8/yPH/UWZNdJDE5G7QBQ8TELs5aSGxzKEfZx
	ZldduqZ3pNvV0EAV7LAYhvM6r246Avv8UHeWRGGI8//mPs/TaNSc
X-Google-Smtp-Source: AGHT+IEw27iDW+MU/bmpce30MixoYf5Z3Eiyqlw10Vy89mzcTVB33gVN0fPadnIxiEeMDp1QWuWKxg==
X-Received: by 2002:a17:90b:88f:b0:290:8cb7:fa10 with SMTP id bj15-20020a17090b088f00b002908cb7fa10mr3909572pjb.15.1706122623196;
        Wed, 24 Jan 2024 10:57:03 -0800 (PST)
Received: from debian (c-71-202-32-218.hsd1.ca.comcast.net. [71.202.32.218])
        by smtp.gmail.com with ESMTPSA id r5-20020a17090ad40500b0029004b9df9fsm14257004pju.36.2024.01.24.10.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 10:57:02 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Wed, 24 Jan 2024 10:57:00 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	Fan Ni <fan.ni@samsung.com>, Michael Tsirkin <mst@redhat.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linuxarm@huawei.com,
	Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH 4/5] hw/cxl: Update mailbox status registers.
Message-ID: <ZbFdfOiWTkTggRSp@debian>
References: <20240124134814.8717-1-Jonathan.Cameron@huawei.com>
 <20240124134814.8717-5-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124134814.8717-5-Jonathan.Cameron@huawei.com>

On Wed, Jan 24, 2024 at 01:48:13PM +0000, Jonathan Cameron wrote:
> Whilst the reported version was 1 so there should be no changes,
> a couple of fields (where the value 0 was valid) were not
> defined. Make those explicit and update references to be based
> on CXL r3.1.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
>  include/hw/cxl/cxl_device.h | 17 ++++++++++-------
>  hw/cxl/cxl-device-utils.c   |  6 +++++-
>  2 files changed, 15 insertions(+), 8 deletions(-)
> 
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 31d2afcd3d..9f51c586d7 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -189,7 +189,7 @@ typedef struct cxl_device_state {
>          };
>      };
>  
> -    /* mmio for the mailbox registers 8.2.8.4 */
> +    /* CXL r3.1 Section 8.2.8.4: Mailbox Registers */
>      struct {
>          MemoryRegion mailbox;
>          uint16_t payload_size;
> @@ -310,39 +310,42 @@ void cxl_initialize_t3_ld_cci(CXLCCI *cci, DeviceState *d,
>  REG64(CXL_DEV_EVENT_STATUS, 0)
>      FIELD(CXL_DEV_EVENT_STATUS, EVENT_STATUS, 0, 32)
>  
> -/* CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register */
> +#define CXL_DEV_MAILBOX_VERSION 1
> +/* CXL r3.1 Section 8.2.8.4.3: Mailbox Capabilities Register */
>  REG32(CXL_DEV_MAILBOX_CAP, 0)
>      FIELD(CXL_DEV_MAILBOX_CAP, PAYLOAD_SIZE, 0, 5)
>      FIELD(CXL_DEV_MAILBOX_CAP, INT_CAP, 5, 1)
>      FIELD(CXL_DEV_MAILBOX_CAP, BG_INT_CAP, 6, 1)
>      FIELD(CXL_DEV_MAILBOX_CAP, MSI_N, 7, 4)
> +    FIELD(CXL_DEV_MAILBOX_CAP, MBOX_READY_TIME, 11, 8)
> +    FIELD(CXL_DEV_MAILBOX_CAP, TYPE, 19, 4)
>  
> -/* CXL 2.0 8.2.8.4.4 Mailbox Control Register */
> +/* CXL r3.1 Section 8.2.8.4.4: Mailbox Control Register */
>  REG32(CXL_DEV_MAILBOX_CTRL, 4)
>      FIELD(CXL_DEV_MAILBOX_CTRL, DOORBELL, 0, 1)
>      FIELD(CXL_DEV_MAILBOX_CTRL, INT_EN, 1, 1)
>      FIELD(CXL_DEV_MAILBOX_CTRL, BG_INT_EN, 2, 1)
>  
> -/* CXL 2.0 8.2.8.4.5 Command Register */
> +/* CXL r3.1 Section 8.2.8.4.5: Command Register */
>  REG64(CXL_DEV_MAILBOX_CMD, 8)
>      FIELD(CXL_DEV_MAILBOX_CMD, COMMAND, 0, 8)
>      FIELD(CXL_DEV_MAILBOX_CMD, COMMAND_SET, 8, 8)
>      FIELD(CXL_DEV_MAILBOX_CMD, LENGTH, 16, 20)
>  
> -/* CXL 2.0 8.2.8.4.6 Mailbox Status Register */
> +/* CXL r3.1 Section 8.2.8.4.6: Mailbox Status Register */
>  REG64(CXL_DEV_MAILBOX_STS, 0x10)
>      FIELD(CXL_DEV_MAILBOX_STS, BG_OP, 0, 1)
>      FIELD(CXL_DEV_MAILBOX_STS, ERRNO, 32, 16)
>      FIELD(CXL_DEV_MAILBOX_STS, VENDOR_ERRNO, 48, 16)
>  
> -/* CXL 2.0 8.2.8.4.7 Background Command Status Register */
> +/* CXL r3.1 Section 8.2.8.4.7: Background Command Status Register */
>  REG64(CXL_DEV_BG_CMD_STS, 0x18)
>      FIELD(CXL_DEV_BG_CMD_STS, OP, 0, 16)
>      FIELD(CXL_DEV_BG_CMD_STS, PERCENTAGE_COMP, 16, 7)
>      FIELD(CXL_DEV_BG_CMD_STS, RET_CODE, 32, 16)
>      FIELD(CXL_DEV_BG_CMD_STS, VENDOR_RET_CODE, 48, 16)
>  
> -/* CXL 2.0 8.2.8.4.8 Command Payload Registers */
> +/* CXL r3.1 Section 8.2.8.4.8: Command Payload Registers */
>  REG32(CXL_DEV_CMD_PAYLOAD, 0x20)
>  
>  REG64(CXL_MEM_DEV_STS, 0)
> diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
> index 40b619ffd9..9df8738f86 100644
> --- a/hw/cxl/cxl-device-utils.c
> +++ b/hw/cxl/cxl-device-utils.c
> @@ -366,6 +366,10 @@ static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
>      ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
>                       MSI_N, msi_n);
>      cxl_dstate->mbox_msi_n = msi_n;
> +    ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
> +                     MBOX_READY_TIME, 0); /* Not reported */
> +    ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
> +                     TYPE, 0); /* Inferred from class code */
>  }
>  
>  static void memdev_reg_init_common(CXLDeviceState *cxl_dstate)
> @@ -392,7 +396,7 @@ void cxl_device_register_init_t3(CXLType3Dev *ct3d)
>      cxl_device_cap_init(cxl_dstate, DEVICE_STATUS, 1, 2);
>      device_reg_init_common(cxl_dstate);
>  
> -    cxl_device_cap_init(cxl_dstate, MAILBOX, 2, 1);
> +    cxl_device_cap_init(cxl_dstate, MAILBOX, 2, CXL_DEV_MAILBOX_VERSION);
>      mailbox_reg_init_common(cxl_dstate);
>  
>      cxl_device_cap_init(cxl_dstate, MEMORY_DEVICE, 0x4000, 1);
> -- 
> 2.39.2
> 
