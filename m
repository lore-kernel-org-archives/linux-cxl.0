Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E776BC77B75
	for <linux-cxl@archiver.kernel.org>; Mon, 22 May 2023 12:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjEVMJS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 22 May 2023 08:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjEVMJR (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 22 May 2023 08:09:17 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547CBA1
        for <linux-cxl@vger.kernel.org>; Mon, 22 May 2023 05:09:16 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QPx2h4R23z6J6dY;
        Mon, 22 May 2023 20:04:44 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 22 May
 2023 13:09:13 +0100
Date:   Mon, 22 May 2023 13:09:12 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
CC:     Richard Henderson <richard.henderson@linaro.org>,
        BALATON Zoltan <balaton@eik.bme.hu>,
        Peter Maydell <peter.maydell@linaro.org>,
        <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, "Ira Weiny" <ira.weiny@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        "Daniel P . =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau 
        <marcandre.lureau@redhat.com>, "Thomas Huth" <thuth@redhat.com>
Subject: Re: [PATCH v6 1/4] bswap: Add the ability to store to an unaligned
 24 bit field
Message-ID: <20230522130912.0000555f@Huawei.com>
In-Reply-To: <06481704-adc6-bc63-e79d-34ac87484810@linaro.org>
References: <20230519141803.29713-1-Jonathan.Cameron@huawei.com>
        <20230519141803.29713-2-Jonathan.Cameron@huawei.com>
        <CAFEAcA_kjm+k7SEEnz6uw+cOJyXSoUqg2wCQ5h+W-eTfwxD=FA@mail.gmail.com>
        <04b53845-b54f-458f-bc6f-f5aed86cdd06@eik.bme.hu>
        <4dd8a802-9a8c-77ab-6355-38910eefe19e@linaro.org>
        <06481704-adc6-bc63-e79d-34ac87484810@linaro.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sat, 20 May 2023 19:08:22 +0200
Philippe Mathieu-Daudé <philmd@linaro.org> wrote:

> On 20/5/23 17:15, Richard Henderson wrote:
> > On 5/20/23 06:15, BALATON Zoltan wrote:  
> >> On Sat, 20 May 2023, Peter Maydell wrote:  
> >>> On Fri, 19 May 2023 at 15:19, Jonathan Cameron via
> >>> <qemu-devel@nongnu.org> wrote:  
> >>>>
> >>>> From: Ira Weiny <ira.weiny@intel.com>
> >>>>
> >>>> CXL has 24 bit unaligned fields which need to be stored to.  CXL is
> >>>> specified as little endian.
> >>>>
> >>>> Define st24_le_p() and the supporting functions to store such a field
> >>>> from a 32 bit host native value.
> >>>>
> >>>> The use of b, w, l, q as the size specifier is limiting.  So "24" was
> >>>> used for the size part of the function name.  
> >>
> >> Maybe it's clearer to use 24 but if we want to keep these somewhat 
> >> consistent how about using t for Triplet, Three-bytes or Twenty-four?  
> > 
> > I think it's clearer to use '3'.
> > When I added 128-bit support I used cpu_ld16_mmu.  

As an aside on that - you didn't update the docs when you added that
(I was looking for it to copy your regex ;)

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
> 
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

