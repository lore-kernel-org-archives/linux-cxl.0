Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1FEC433EF
	for <linux-cxl@archiver.kernel.org>; Tue,  5 Apr 2022 22:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbiDEWNJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 5 Apr 2022 18:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391421AbiDEPeZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 5 Apr 2022 11:34:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D976B69294
        for <linux-cxl@vger.kernel.org>; Tue,  5 Apr 2022 06:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649166117;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9SMf3YY1I3dUwlFz96C1rsqKlIAyO743R5VQnaSrKUs=;
        b=Nq8OwFL9wFzxsPTHjFAVUi8aD7XHl1X0rtIeXOhULJlxTJpijHhalMi+2hY7CA6orHsbiF
        KhQFjCkQGKUeAf5MF4NSN3yYhL/Nh6E36DO9VFS4FoxunMnMx0ygxFLDPZoT1CJirL6Ehi
        mITQAo/xTZWKJscgJ5+mkDQstKJIDGo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-449-L-PbSyqDMum_KoabL6A9lg-1; Tue, 05 Apr 2022 09:41:54 -0400
X-MC-Unique: L-PbSyqDMum_KoabL6A9lg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4224985A5A8;
        Tue,  5 Apr 2022 13:41:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C70F540CFD05;
        Tue,  5 Apr 2022 13:41:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
        id A34A721E6906; Tue,  5 Apr 2022 15:41:51 +0200 (CEST)
From:   Markus Armbruster <armbru@redhat.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     <linuxarm@huawei.com>, <qemu-devel@nongnu.org>,
        Alex =?utf-8?Q?Benn?= =?utf-8?Q?=C3=A9e?= 
        <alex.bennee@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>,
        Adam Manzanares <a.manzanares@samsung.com>,
        <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        "Peter Maydell" <peter.maydell@linaro.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        "Samarth Saxena" <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "k . jensen @ samsung . com" <k.jensen@samsung.com>,
        Tong Zhang <t.zhang2@samsung.com>, <dave@stgolabs.net>,
        Alison Schofield <alison.schofield@intel.com>
Subject: Re: [PATCH v9 27/45] hw/cxl/host: Add support for CXL Fixed Memory
 Windows.
References: <20220404151445.10955-1-Jonathan.Cameron@huawei.com>
        <20220404151445.10955-28-Jonathan.Cameron@huawei.com>
Date:   Tue, 05 Apr 2022 15:41:51 +0200
In-Reply-To: <20220404151445.10955-28-Jonathan.Cameron@huawei.com> (Jonathan
        Cameron's message of "Mon, 4 Apr 2022 16:14:27 +0100")
Message-ID: <87v8vn4pgg.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> From: Jonathan Cameron <jonathan.cameron@huawei.com>
>
> The concept of these is introduced in [1] in terms of the
> description the CEDT ACPI table. The principal is more general.
> Unlike once traffic hits the CXL root bridges, the host system
> memory address routing is implementation defined and effectively
> static once observable by standard / generic system software.
> Each CXL Fixed Memory Windows (CFMW) is a region of PA space
> which has fixed system dependent routing configured so that
> accesses can be routed to the CXL devices below a set of target
> root bridges. The accesses may be interleaved across multiple
> root bridges.
>
> For QEMU we could have fully specified these regions in terms
> of a base PA + size, but as the absolute address does not matter
> it is simpler to let individual platforms place the memory regions.
>
> ExampleS:
> -cxl-fixed-memory-window targets.0=cxl.0,size=128G
> -cxl-fixed-memory-window targets.0=cxl.1,size=128G
> -cxl-fixed-memory-window targets.0=cxl0,targets.1=cxl.1,size=256G,interleave-granularity=2k
>
> Specifies
> * 2x 128G regions not interleaved across root bridges, one for each of
>   the root bridges with ids cxl.0 and cxl.1
> * 256G region interleaved across root bridges with ids cxl.0 and cxl.1
> with a 2k interleave granularity.
>
> When system software enumerates the devices below a given root bridge
> it can then decide which CFMW to use. If non interleave is desired
> (or possible) it can use the appropriate CFMW for the root bridge in
> question.  If there are suitable devices to interleave across the
> two root bridges then it may use the 3rd CFMS.
>
> A number of other designs were considered but the following constraints
> made it hard to adapt existing QEMU approaches to this particular problem.
> 1) The size must be known before a specific architecture / board brings
>    up it's PA memory map.  We need to set up an appropriate region.
> 2) Using links to the host bridges provides a clean command line interface
>    but these links cannot be established until command line devices have
>    been added.
>
> Hence the two step process used here of first establishing the size,
> interleave-ways and granularity + caching the ids of the host bridges
> and then, once available finding the actual host bridges so they can
> be used later to support interleave decoding.
>
> [1] CXL 2.0 ECN: CEDT CFMWS & QTG DSM (computeexpresslink.org / specifications)
>
> Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>

QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>

