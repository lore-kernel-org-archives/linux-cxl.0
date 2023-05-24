Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390B0C7EE2C
	for <linux-cxl@archiver.kernel.org>; Wed, 24 May 2023 09:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240441AbjEXJUo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 24 May 2023 05:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240628AbjEXJUn (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 24 May 2023 05:20:43 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A04195
        for <linux-cxl@vger.kernel.org>; Wed, 24 May 2023 02:20:36 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QR5Gm73tGz67M49;
        Wed, 24 May 2023 17:19:12 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 24 May
 2023 10:20:34 +0100
Date:   Wed, 24 May 2023 10:20:33 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Markus Armbruster <armbru@redhat.com>
CC:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>, <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau 
        <marcandre.lureau@redhat.com>, "Thomas Huth" <thuth@redhat.com>
Subject: Re: [PATCH v5 5/7] hw/cxl/events: Add injection of General Media
 Events
Message-ID: <20230524102033.00002d41@huawei.com>
In-Reply-To: <20230524101158.0000579d@huawei.com>
References: <20230423165140.16833-1-Jonathan.Cameron@huawei.com>
        <20230423165140.16833-6-Jonathan.Cameron@huawei.com>
        <87lehgq1cy.fsf@pond.sub.org>
        <20230522135737.000079c4@Huawei.com>
        <87fs7na2o8.fsf@pond.sub.org>
        <20230523113543.00006a1f@Huawei.com>
        <87ttw35i6q.fsf@pond.sub.org>
        <20230524101158.0000579d@huawei.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 24 May 2023 10:11:58 +0100
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Tue, 23 May 2023 14:46:37 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
> 
> > Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:
> > 
> > >> >    
> > >> >> > +#
> > >> >> > +# Inject an event record for a General Media Event (CXL r3.0 8.2.9.2.1.1)      
> > >> >> 
> > >> >> What's "CXL r3.0", and where could a reader find it?    
> > >> >
> > >> > We have docs in docs/system/devices/cxl.rst that include the consortium
> > >> > website which has download links on the front page.    
> > >> 
> > >> cxl.rst has
> > >> 
> > >>     References
> > >>     ----------
> > >> 
> > >>      - Consortium website for specifications etc:
> > >>        http://www.computeexpresslink.org
> > >>      - Compute Express link Revision 2 specification, October 2020
> > >>      - CEDT CFMWS & QTG _DSM ECN May 2021
> > >> 
> > >> Should the second reference be updated to 3.0?  Exact title seems to be
> > >> "The Compute Express Link™ (CXL™) 3.0 specification".  Not sure we need
> > >> to bother with the "™" in a reference.  
> > >
> > > Yes. On the todo list is to update all the references to latest released
> > > specification because old ones are unobtainable to non consortium members
> > > unless they grabbed a copy in the past.
> > >
> > > Annoyingly this will be a repeated requirement as new spec versions are released
> > > but the cadence should be fairly low.
> > >  
> > >>   
> > >> >                                                      I'm not sure we want to
> > >> > have lots of references to the URL spread throughout QEMU.  I can add one
> > >> > somewhere in cxl.json if you think it is important to have one here as well.    
> > >> 
> > >> You could add an introduction right under the "# = CXL devices" heading,
> > >> and include a full reference to the specification there.  Suitably
> > >> abbreviated references like the ones you use in this patch should then
> > >> be fine.  
> > >
> > > I tried doing that - it resulted in the index including an entry with all the text.
> > > So on the webpage, the contents list to the left includes whatever text you put
> > > in that block.
> > >  
> > > I'm not sure why, or how to fix that.  
> > 
> > Show me what you tried (as a patch or something I can git-pull), and
> > I'll have a look.
> > 
> > [...]
> > 
> Very simple to replicate the issue - see below.
> 
> Result of this is an extra
> "Test text" entry in the index to the left of the html docs.
> 
> In qemu-qmp-ref.html we have
> 
> <li class="toctree-l3"><a class="reference internal" href="#qapidoc-3297">CXL devices</a><ul>
> <li class="toctree-l4"><a class="reference internal" href="#qapidoc-3298">Test text</a></li>
> <li class="toctree-l4"><a class="reference internal" href="#qapidoc-3301"><code class="docutils literal notranslate"><span class="pre">CxlEventLog</span></code> (Enum)</a></li>

Experimented and dived in the code a bit more and got reminded of how bad my python is
(which is why I was avoiding looking at this :)
One option would be to give the extra text a meaningful title so that ends up in the contents list.

> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -3,6 +3,8 @@
> 
>  ##
>  # = CXL devices
> +#
> +# CXL Background
> +#
> +# Actually useful text.
>  ##
> 
>  ##

Can't do
== CXL Background

though to get it nicely formatted as then we loose all the actual entries from the
contents list.  I guess they dropped down one too many levels.

> 
> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 05c560cfe5..9f7f0485ae 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json
> @@ -3,6 +3,8 @@
> 
>  ##
>  # = CXL devices
> +#
> +# Test text
>  ##
> 
>  ##

