Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EED92C7EE26
	for <linux-cxl@archiver.kernel.org>; Mon, 22 May 2023 12:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233670AbjEVMA2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 22 May 2023 08:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233641AbjEVMAX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 22 May 2023 08:00:23 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061A9CD
        for <linux-cxl@vger.kernel.org>; Mon, 22 May 2023 04:59:57 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QPwtT37fhz67Zjl;
        Mon, 22 May 2023 19:57:37 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 22 May
 2023 12:59:32 +0100
Date:   Mon, 22 May 2023 12:59:31 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Peter Maydell <peter.maydell@linaro.org>
CC:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, "Ira Weiny" <ira.weiny@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        "Daniel P . =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau 
        <marcandre.lureau@redhat.com>, "Thomas Huth" <thuth@redhat.com>
Subject: Re: [PATCH v6 1/4] bswap: Add the ability to store to an unaligned
 24 bit field
Message-ID: <20230522125931.0000309a@Huawei.com>
In-Reply-To: <CAFEAcA_kjm+k7SEEnz6uw+cOJyXSoUqg2wCQ5h+W-eTfwxD=FA@mail.gmail.com>
References: <20230519141803.29713-1-Jonathan.Cameron@huawei.com>
        <20230519141803.29713-2-Jonathan.Cameron@huawei.com>
        <CAFEAcA_kjm+k7SEEnz6uw+cOJyXSoUqg2wCQ5h+W-eTfwxD=FA@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sat, 20 May 2023 13:37:42 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On Fri, 19 May 2023 at 15:19, Jonathan Cameron via
> <qemu-devel@nongnu.org> wrote:
> >
> > From: Ira Weiny <ira.weiny@intel.com>
> >
> > CXL has 24 bit unaligned fields which need to be stored to.  CXL is
> > specified as little endian.
> >
> > Define st24_le_p() and the supporting functions to store such a field
> > from a 32 bit host native value.
> >
> > The use of b, w, l, q as the size specifier is limiting.  So "24" was
> > used for the size part of the function name.
> >
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >  docs/devel/loads-stores.rst |  1 +
> >  include/qemu/bswap.h        | 27 +++++++++++++++++++++++++++
> >  2 files changed, 28 insertions(+)
> >
> > diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
> > index d2cefc77a2..82a79e91d9 100644
> > --- a/docs/devel/loads-stores.rst
> > +++ b/docs/devel/loads-stores.rst
> > @@ -36,6 +36,7 @@ store: ``st{size}_{endian}_p(ptr, val)``
> >  ``size``
> >   - ``b`` : 8 bits
> >   - ``w`` : 16 bits
> > + - ``24`` : 24 bits
> >   - ``l`` : 32 bits
> >   - ``q`` : 64 bits  
> 
> Can you also update the "Regexes for git grep" section
> below to account for the new size value, please?

Ok. My regex isn't great, but I think this would require either some
separate entries or a switch to git grep -E to allow for the multiple
character matching.

So I've added
 - ``\st24\(_[hbl]e\)\?_p\>``




> 
> thanks
> -- PMM

