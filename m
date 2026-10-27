Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793143746;
	b=o64bwbzQhoFawLFFPJpb0pJRUSjBqZgOLLOfZCURnqomF9f0lHvSoWek6pDhRHb1uuI6
	 Ok7AXB2Ly69VbEohAxvNUXdsaga6Xrooe5wQ4ylDdncLZswqD4+hnJvqIBDAEKgnrpIOT
	 DoB/E54eYCfOE1bHAaK7KJDxRdPBmkuZnfuRxrnRhTqLaJrUgCGbPZ4jrC2ds3bn74j2S
	 1EFTwewDK0LwEWhC6lbIZTHvYl7fPSEcoQJ6OJCubhEUee1uT36z7AizYr1XqYF2gCPN+
	 qN2ayZ7wARNeZqPQjr/vjq9qmBKluI6O1GHq698q+ZpAj+92JegC1xHVylK4euMhUzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793143746;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Ln10d+mgN0LQwoxe6WFCwLj+G0pXkKeGxjA0i13u1Mg=;
	b=NzX9j17cwEaJ3urPRCYfiREirtj1awXsEy52ZGfct7YVaylb8zHVrZPDM3k2e/4Q8EtX
	 jikdMd0kEi7MV82XO7BbajiH0vOtb/hpwmDK0njgb2bv37ALICfgvZ5ilw2PUvzdBv6xT
	 vM46ovusGL+AUcwl6D925io0s3mAPifzn2fJKzUzP89dPBaWM6cphuIRJe8h/+5npDbNS
	 KXUJjiur7EgC/JBlf2Re1PmD/1NdxEmDKWAqdWXbUCYW0MTp5Mj/k3FdbeaRpAFrTEpn9
	 lSxyY0kFkKNURUFRgo9J17gt8DK+BJbfCx0S00KexLMT32oGt1stfeSUa6pfi7lihgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WQHrj7OM;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB0F606A31A
	for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 23:29:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFB0F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WQHrj7OM
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-89ff475a152so188818b3a.3
        for <linux-cxl@vger.kernel.org>; Tue, 27 Oct 2026 16:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793143745; x=1793748545; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ln10d+mgN0LQwoxe6WFCwLj+G0pXkKeGxjA0i13u1Mg=;
        b=WQHrj7OM5yRaRkGeTrggC5Jhxy5tOOVJj7jEXN/Hvplk0kPwW7Pev0atIgOFxcxpS+
         EEsVKGR+r4K0aroU1MCxSBLtcahvIz7kTdikMOPuw/WWzB23HjNmHikWboIRlF40k0AD
         RmZZ6Vo1Q1d749KBGgZD7xiebCrh8eIgQI49JmCdZTxfo9uWHY78v7WhIHde2BbUYRTI
         tmSIyIbuZQSnJMCN4HZ/sBhttosWAzM5TjCZUocPV+UezLbJG+o/hKetAcKaE0C8C0uV
         7rkGfk/ns/7fn1ybFddTOZq4umBqUEZ8qSvGplYmcPtVroi0SIXnoxH2GPPnjnm6S7xP
         dvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793143745; x=1793748545;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ln10d+mgN0LQwoxe6WFCwLj+G0pXkKeGxjA0i13u1Mg=;
        b=r569Sr7owjL5VBCt+i6pJoQ6JG7eQGS5V3i/UlQkcSqOKLFCci0sRQMLCZ222TOOuS
         L/pYyKBzskKx0x8v7ekR/KhNe9hCW7bop+isBXLWpIAXxMJ/NY/SBMDKfyu8XLBcDfVj
         l+mG7+ZwrdtCeeJzLvpeXEVL1AboqOfI3Eqyj4hzmdiCc9vL0TwLQk98dfGz/olpt6Xe
         ifgRZZT7Yyv/nd+qVCwgzWTr4GwsjLLBRaDfwRGwNPH4C5D1bsFAKWeGx2hfuIdX+yUN
         2Q6uTL3dhnLurcjFE6k+4wveVuUFRsDAGtr7xmNsKo7lCtQxZzQznua4xiZlg+U9YLoN
         To3A==
X-Forwarded-Encrypted: i=1; AKwUvBx56uy7m0NdWpZFYEm0LrVWmAttqa3Qkldvl0mMg3WMxGcMCp9rB5pbc38DjaL6Hx2hTDGcd5xqMq4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJRbrd3S139Q5T78vLqwQuF0UO7nSNQiAHIk2kyVqsYGUoCntbJ
	wF/XTsk0sOtKLq0NtO2cwza0sH2fdcWlmPhRxu/dv8s4tIntfFpYSU9R
X-Gm-Gg: AYBFou2kf6mzkf0JHu5sg956w2xvXhWpOBoKoiyNLCpVoIdc10TTbGxpNST2uamKSLc
	izFiuYbxPeC/2A03+Cv4pYK7gehaEMt1TNsollzD1SzTY8lA1Tgi6+ybq8vrxXqZPSCKyq63owZ
	KYEfAC/m04PB2VrQxsRBeQte6YKO4gu55vuDHCz6AIIfJ8Q91JqcS4ps8pQc3rrqrQzSZWQsgnM
	Op74/PITr/b59iK4S7gCMy/JqqTF24hhQHgnwtIlXYIanzmsKSU6R1f1GAyElNyvbkxNaVKWKSp
	3e1T2gMdexy0uLHSHfRh3UDb9ATJYFQGUYAk87ym00ITdK4VV1WrgS6BI543vI6/3Ol4ydrgrsS
	SH0gjS+uT/TULv2tDg1gcWO8qOnRzsl6ysAJgUQPag3ItDceeW/IsnTWBEbrOFRHOBn+KwI4GSW
	WTuG4On4TlaQrsQw/5rJ7NAuvyXrPhjsfBUARnpP6O/AfN62onhKH3SOCoUm/uK9VT46vYWcNuh
	Q/FgeJhL8SFusSY4ZLgrL0moJtYS//s1/M6OjayPG1MmUgUOvc=
X-Received: by 2002:a05:6a20:4327:b0:3e2:89c3:2fb0 with SMTP id adf61e73a8af0-3e902107ceamr548447637.7.1793143745236;
        Tue, 27 Oct 2026 16:29:05 -0700 (PDT)
Received: from cxlqual ([220.120.90.131])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6c2485703sm352437b3a.49.2026.10.27.16.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 16:29:04 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Wed, 28 Oct 2026 08:30:32 +0900
To: Richard Cheng <icheng@nvidia.com>
Cc: jic23@kernel.org, junjie.cao@intel.com, linux-cxl@vger.kernel.org,
	qemu-devel@nongnu.org
Subject: Re: [RFC PATCH] hw/cxl: Align mailbox payload backing storage
Message-ID: <auE0GKAvRSufpJuZ@cxlqual>
References: <20261027102227.4976-1-icheng@nvidia.com>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261027102227.4976-1-icheng@nvidia.com>

On Tue, Oct 27, 2026 at 06:22:27PM +0800, Richard Cheng wrote:
> The Get Supported Features handler treats payload_out as a 16-byte
> aligned structure. However, the mailbox register is aligned to 8 bytes.
> Since the payload starts at A_CXL_DEV_CMD_PAYLOAD, a misaligned union
> will produce a misaligned payload pointer.
> 
> The bug can be triggered when QEMU built with UBSAN:
> 
>   hw/cxl/cxl-mailbox-utils.c:1571:39: runtime error:
>   member access within misaligned address 0xff7772f3d628 for type
>   'struct <unknown>', which requires 16 byte alignment
> 
> QEMU aborts while handling GET_SUPPORTED_FEATURES
> 
> Didn't see a strong evidence why QEMU would treat it as 16-byte aligned,
> so I want to raise the RFC and see what's the actual corrected fix,
> rather than dropping the aligned tag directly.
> 
> Align the mailbox backing union to 16 bytes. Since the payload offset is
> 0x20, payload_out now satisfies the handlers' existing alignment
> requirement.
> 
Hello Richard,

It looks like Jonathan already has this commit in his tree:

https://github.com/qualcomm/qemu/commit/271340b769bdf4b2614fcff76455a813f154d77b

I'm not really sure why the features handlers require QEMU_ALIGNED(16). I don't
see anything in the spec that requires the 16B alignment. And the Get Supported
Features input payload is padded from 8B to 16B because of QEMU_ALIGNED(16),
which seems not right?

The commit message from 271340b7 says:

"hw/cxl: Ensure the register space for the mailbox registers is 16 byte aligned.

Given there are some carefully aligned UUIDs in the registers,
enforce the alignment to solve ubscan issue..."

but if that refers to the UUID of output->feature_entries[x]:
the output payload has an 8B header, so the UUID of any feature entries
won't start at a 16B-aligned address anyway?

/*
 * Get Supported Features Supported Feature Entry
 * CXL r3.1 section 8.2.9.6.1 Table 8-97
 */
typedef struct CXLSupportedFeatureEntry {
    QemuUUID uuid;
    uint16_t feat_index;
    uint16_t get_feat_size;
    uint16_t set_feat_size;
    uint32_t attr_flags;
    uint8_t get_feat_version;
    uint8_t set_feat_version;
    uint16_t set_feat_effects;
    uint8_t rsvd[18];
} QEMU_PACKED CXLSupportedFeatureEntry;

struct {
        CXLSupportedFeatureHeader hdr; <--- 8B
        CXLSupportedFeatureEntry feat_entries[];
    }


If QEMU_ALIGNED(16) is not needed for Get Supported Features, then I think it should also
be dropped from the other Features handlers, and Get Log (Opcode 0401h).
I don't see anything in specification that requires 16B alignment for those
commands.

Thanks,
Anisa

> Fixes: d80378943a6b ("hw/cxl/cxl-mailbox-utils: Add support for feature commands (8.2.9.6)")
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> ---
> Reproduce with:
> 
>     1. Configure QEMU with --enable-ubsan.
>     2. Start QEMU with UBSAN_OPTIONS=halt_on_error=1 and a cxl-type3
>        device.
>     3. Boot a guest with CONFIG_CXL_FEATURES=y, or reprobe the endpoint:
> 
>        # echo <type3-bdf> > /sys/bus/pci/drivers/cxl_pci/unbind
>        # echo <type3-bdf> > /sys/bus/pci/drivers/cxl_pci/bind
> 
> Best regards,
> Richard Cheng.
> ---
>  include/hw/cxl/cxl_device.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index ba551fa..2191b7c 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -248,7 +248,7 @@ typedef struct cxl_device_state {
>              uint16_t mbox_reg_state16[CXL_MAILBOX_REGISTERS_LENGTH / 2];
>              uint32_t mbox_reg_state32[CXL_MAILBOX_REGISTERS_LENGTH / 4];
>              uint64_t mbox_reg_state64[CXL_MAILBOX_REGISTERS_LENGTH / 8];
> -        };
> +        } QEMU_ALIGNED(16);
>      };
>  
>      /* Stash the memory device status value */
> -- 
> 2.43.0
> 
