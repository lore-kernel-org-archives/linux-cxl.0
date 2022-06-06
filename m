Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF80C43334
	for <linux-cxl@archiver.kernel.org>; Mon,  6 Jun 2022 17:24:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiFFRYv (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 6 Jun 2022 13:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiFFRYu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 6 Jun 2022 13:24:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2C7719EC
        for <linux-cxl@vger.kernel.org>; Mon,  6 Jun 2022 10:24:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4BB07B81A93
        for <linux-cxl@vger.kernel.org>; Mon,  6 Jun 2022 17:24:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C288CC385A9;
        Mon,  6 Jun 2022 17:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654536287;
        bh=ZKigrDV9GJ7ivjkl9RUM+ZJF/2JYghwt9WdQwFyKVXc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P36W+fagZYH8k3WHNuyv3UhXegsE6hjqE9rwj30Ce9QO/8S2wzcRIGOH/domgTq7y
         brqLF4T1NULqWdD/TG3g3z2v+Bse81G8SEXUXjbnhgUO1ltuLm4ZEC83PpVuKDw0Rs
         stioBLHOoivA/GR3Yo7xJ7xMDLNKU/VnkXIwcJs18SHsaLjpXzWWH8/i3SNqiGgk3f
         a5JxROb/ZWrPXxUwNqqMapaJwUTTfT3vtM1a5xPfmiALH7qYMJw0VD05Rw4QBrbgoY
         HIgXLyJ3dWih3ioPc/WiYlzKjnF7Ha+YLKWjovhIe5EUdrQDaaA7KtCukJ4TmhzR63
         LpM5emRiZJ5OA==
Date:   Mon, 6 Jun 2022 10:24:43 -0700
From:   Ben Widawsky <bwidawsk@kernel.org>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
        linux-cxl@vger.kernel.org, linuxarm@huawei.com,
        alex.bennee@linaro.org, Marcel Apfelbaum <marcel@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Tong Zhang <ztong0001@gmail.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH 1/8] hw/cxl: Make the CXL fixed memory window setup a
 machine parameter.
Message-ID: <20220606172338.3g6rb6qft4o5cu2o@bwidawsk-mobl5>
References: <20220530134514.31664-1-Jonathan.Cameron@huawei.com>
 <20220530134514.31664-2-Jonathan.Cameron@huawei.com>
 <cdb07cb9-4705-5b63-4f40-a44a6f735f38@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdb07cb9-4705-5b63-4f40-a44a6f735f38@redhat.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 22-05-31 09:26:27, Paolo Bonzini wrote:
> On 5/30/22 15:45, Jonathan Cameron via wrote:
> > +    object_property_add(obj, "cxl-fmw", "CXLFixedMemoryWindow",
> > +                        machine_get_cfmw, machine_set_cfmw,
> > +                        NULL, state);
> > +    object_property_set_description(obj, "cxl-fmw",
> > +                                    "CXL Fixed Memory Window");
> 
> Perhaps "CML fixed memory windows (array)" or something like that?
> 
> Paolo

I had a mail which I apparently never sent. I'd like to see 'fmw' renamed, since
that has no decoder ring in any spec that I'm aware of.

Why not keep cfmws nomenclature? It's well defined.

Ben
