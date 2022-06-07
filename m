Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C6BC433EF
	for <linux-cxl@archiver.kernel.org>; Tue,  7 Jun 2022 10:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240469AbiFGKCw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 7 Jun 2022 06:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240581AbiFGKCj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 7 Jun 2022 06:02:39 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12F419C39
        for <linux-cxl@vger.kernel.org>; Tue,  7 Jun 2022 03:02:37 -0700 (PDT)
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LHQlP5Z5Lz687LX;
        Tue,  7 Jun 2022 17:57:53 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 7 Jun 2022 12:02:35 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 7 Jun
 2022 11:02:34 +0100
Date:   Tue, 7 Jun 2022 11:02:33 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <bwidawsk@kernel.org>
CC:     Paolo Bonzini <pbonzini@redhat.com>, <qemu-devel@nongnu.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        <alex.bennee@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        "Adam Manzanares" <a.manzanares@samsung.com>,
        Tong Zhang <ztong0001@gmail.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH 1/8] hw/cxl: Make the CXL fixed memory window setup a
 machine parameter.
Message-ID: <20220607110233.00007d21@Huawei.com>
In-Reply-To: <20220606172338.3g6rb6qft4o5cu2o@bwidawsk-mobl5>
References: <20220530134514.31664-1-Jonathan.Cameron@huawei.com>
        <20220530134514.31664-2-Jonathan.Cameron@huawei.com>
        <cdb07cb9-4705-5b63-4f40-a44a6f735f38@redhat.com>
        <20220606172338.3g6rb6qft4o5cu2o@bwidawsk-mobl5>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml732-chm.china.huawei.com (10.201.108.83) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 6 Jun 2022 10:24:43 -0700
Ben Widawsky <bwidawsk@kernel.org> wrote:

> On 22-05-31 09:26:27, Paolo Bonzini wrote:
> > On 5/30/22 15:45, Jonathan Cameron via wrote:  
> > > +    object_property_add(obj, "cxl-fmw", "CXLFixedMemoryWindow",
> > > +                        machine_get_cfmw, machine_set_cfmw,
> > > +                        NULL, state);
> > > +    object_property_set_description(obj, "cxl-fmw",
> > > +                                    "CXL Fixed Memory Window");  
> > 
> > Perhaps "CML fixed memory windows (array)" or something like that?
> > 
> > Paolo  
> 
> I had a mail which I apparently never sent. I'd like to see 'fmw' renamed, since
> that has no decoder ring in any spec that I'm aware of.
> 
> Why not keep cfmws nomenclature? It's well defined.

IIRC s is for structure and this isn't a structure, so I dropped the s.

Expanding cxl makes this a lot more meaningful outside of CXL related
specifications.  I preferred the full wording as is currently upstream
but the command lines are insanely long given the new form.

Jonathan


> 
> Ben

