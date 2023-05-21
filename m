Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 228DEC7EE29
	for <linux-cxl@archiver.kernel.org>; Sun, 21 May 2023 09:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjEUJGW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 21 May 2023 05:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjEUJGV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 21 May 2023 05:06:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A39D2
        for <linux-cxl@vger.kernel.org>; Sun, 21 May 2023 02:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684659933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3VSx/Avfb33Ldgih9JSGuUPfbI4fITybLTK9e69Y1TY=;
        b=HvdpvWM3g1D+B4sgdsGFD1+QKIa+wTcGLUywrjVyQ+dqEQNysi41ilahNi4Pa3/AZc5Jq6
        NhdUtGh4W+VToSNu1FzyT4FzIkmyNBodmgZ1wXxju/MQxOB3HByUjD5IQtAO74+5Y4xYbm
        UBW0DFxMFpTcLLEgT69yrbbRR3yrOcQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-0JHU07bUMIuIO5Lub8TOdw-1; Sun, 21 May 2023 05:05:30 -0400
X-MC-Unique: 0JHU07bUMIuIO5Lub8TOdw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-306362a1607so3174282f8f.1
        for <linux-cxl@vger.kernel.org>; Sun, 21 May 2023 02:05:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684659929; x=1687251929;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3VSx/Avfb33Ldgih9JSGuUPfbI4fITybLTK9e69Y1TY=;
        b=X7UyFpIY+QwyZw2dpgQpTXQq/ahaCpsD7ofxg3O5/zFSWh6i6pBw5fJmrX/xnLwirx
         V3IatAkz0CvJ8PjxaYjrBmcqLI55AtkuV3JR2t25mdl0te3/l0D1/HuGITC4k6ZkOc3k
         3eP4aHYczY1bTLJ1O+ZhtJu66QqS/aKqhZuQxYMITMYJ/GV2oEL0hhHOvkIKIaU1XGXE
         Q2OgE17ravZX2ByYLTMMWljjBhCBs9cDeKh26rgRwCluF0GicS2w2saYM1O05QMmsSZR
         MmAwsUPDEG/Jgh4if8nYCjHUjLqlr6NJ5i9EL7BptnZf8Y0PBJmK1SjvlEljCR4NgGFJ
         eW0w==
X-Gm-Message-State: AC+VfDzXgECQkbqfI90x4GkZWM53epMTolo4blatKoI0E1DMRBvZQZ+Y
        tYYdX2BphXLdTOmoukxilSrLvEeIcoxBKij9Nmb4E+6/ifLunYiStSmDQHezPLEAoZLhnEcWsfm
        s23A35w1sQ4IF2kNsJ2Ep
X-Received: by 2002:a5d:4b4e:0:b0:2fb:600e:55bd with SMTP id w14-20020a5d4b4e000000b002fb600e55bdmr4945548wrs.39.1684659928897;
        Sun, 21 May 2023 02:05:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4XOP64xDKuhvScJEE4WNn6L+GxaVOCiNZ2RGkPbPgb+PtDQCMNsQ+Es239o+pZAxvM+7IIWA==
X-Received: by 2002:a5d:4b4e:0:b0:2fb:600e:55bd with SMTP id w14-20020a5d4b4e000000b002fb600e55bdmr4945531wrs.39.1684659928608;
        Sun, 21 May 2023 02:05:28 -0700 (PDT)
Received: from redhat.com ([2.52.11.67])
        by smtp.gmail.com with ESMTPSA id l4-20020a5d5604000000b00300aee6c9cesm4112693wrv.20.2023.05.21.02.05.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 May 2023 02:05:27 -0700 (PDT)
Date:   Sun, 21 May 2023 05:05:23 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc:     Richard Henderson <richard.henderson@linaro.org>,
        BALATON Zoltan <balaton@eik.bme.hu>,
        Peter Maydell <peter.maydell@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu-devel@nongnu.org, Fan Ni <fan.ni@samsung.com>,
        linux-cxl@vger.kernel.org, linuxarm@huawei.com,
        Ira Weiny <ira.weiny@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        Daniel P =?iso-8859-1?Q?=2E_Berrang=E9?= <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?iso-8859-1?Q?Marc-Andr=E9?= Lureau 
        <marcandre.lureau@redhat.com>, Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v6 1/4] bswap: Add the ability to store to an unaligned
 24 bit field
Message-ID: <20230521050417-mutt-send-email-mst@kernel.org>
References: <20230519141803.29713-1-Jonathan.Cameron@huawei.com>
 <20230519141803.29713-2-Jonathan.Cameron@huawei.com>
 <CAFEAcA_kjm+k7SEEnz6uw+cOJyXSoUqg2wCQ5h+W-eTfwxD=FA@mail.gmail.com>
 <04b53845-b54f-458f-bc6f-f5aed86cdd06@eik.bme.hu>
 <4dd8a802-9a8c-77ab-6355-38910eefe19e@linaro.org>
 <06481704-adc6-bc63-e79d-34ac87484810@linaro.org>
MIME-Version: 1.0
In-Reply-To: <06481704-adc6-bc63-e79d-34ac87484810@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sat, May 20, 2023 at 07:08:22PM +0200, Philippe Mathieu-Daudé wrote:
> On 20/5/23 17:15, Richard Henderson wrote:
> > On 5/20/23 06:15, BALATON Zoltan wrote:
> > > On Sat, 20 May 2023, Peter Maydell wrote:
> > > > On Fri, 19 May 2023 at 15:19, Jonathan Cameron via
> > > > <qemu-devel@nongnu.org> wrote:
> > > > > 
> > > > > From: Ira Weiny <ira.weiny@intel.com>
> > > > > 
> > > > > CXL has 24 bit unaligned fields which need to be stored to.  CXL is
> > > > > specified as little endian.
> > > > > 
> > > > > Define st24_le_p() and the supporting functions to store such a field
> > > > > from a 32 bit host native value.
> > > > > 
> > > > > The use of b, w, l, q as the size specifier is limiting.  So "24" was
> > > > > used for the size part of the function name.
> > > 
> > > Maybe it's clearer to use 24 but if we want to keep these somewhat
> > > consistent how about using t for Triplet, Three-bytes or
> > > Twenty-four?
> > 
> > I think it's clearer to use '3'.
> > When I added 128-bit support I used cpu_ld16_mmu.
> 
> There is also ld8u / ld8s / st8.
> 
> > I think it would be clearer to not use letters anywhere, and to use
> > units of bytes instead of units of bits (no one can store just a bit),
> > but changing everything is a big job.
> 
> So:
> 
> ldub ->  ld1u,
> 
> lduw_le -> ld2u_le,
> 
> virtio_stl -> virtio_st4,
> 
> stq_be -> st8_be.
> 
> Right?


No, using bits is so ingrained by now, that people will think
st8 is a single byte.

And yes, you can store a bit - you have to read modify write but
hey.

> Also we have:
> 
> cpu_ld/st_*
> virtio_ld/st_*
> ld/st_*_phys
> ld/st_*_pci_dma
> address_space_ld/st
> 
> While mass-changing, we could use FOO_ld/st_BAR with FOO
> for API and BAR for API variant (endian, mmuidx, ra, ...):
> 
> So:
> 
> ld/st_*_pci_dma -> pci_dma_ld/st_*
> 
> for ld/st_*_phys I'm not sure.

