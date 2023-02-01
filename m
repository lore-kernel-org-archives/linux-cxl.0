Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90F4C636CD
	for <linux-cxl@archiver.kernel.org>; Wed,  1 Feb 2023 12:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjBAMPD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Feb 2023 07:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjBAMPC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 1 Feb 2023 07:15:02 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227D149541
        for <linux-cxl@vger.kernel.org>; Wed,  1 Feb 2023 04:14:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675253654;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XVvsadOMWhMj2Js7NAQfUTfvwSK/kOyE6K7oR4EOgm8=;
        b=Z1TpNgz74jILFon7tJK96A21OMX+ClCILFnE4Pdt85U2GirCsASToPNQexgfEyKN9V95tR
        AkFRTF/wCKhK+0ZtJbAs+0Q+OYhI6n6mFyKnbl//Tr0BI5WGG16d36uNmD6Va9LmgzxJ47
        N6BXqSew5PIwVBzh4ZHeYv7MPJXXC9M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-450-e7hEy-yLOJSagC51u0YnEg-1; Wed, 01 Feb 2023 07:14:08 -0500
X-MC-Unique: e7hEy-yLOJSagC51u0YnEg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 52B10811E6E;
        Wed,  1 Feb 2023 12:14:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.70])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2C46F112132C;
        Wed,  1 Feb 2023 12:14:07 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
        id C5AC621E6A1F; Wed,  1 Feb 2023 13:14:06 +0100 (CET)
From:   Markus Armbruster <armbru@redhat.com>
To:     Jonathan Cameron via <qemu-devel@nongnu.org>
Cc:     Michael Tsirkin <mst@redhat.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: Re: [RFC PATCH v2 1/3] hw/cxl: QMP based poison injection support
References: <20230201100350.23263-1-Jonathan.Cameron@huawei.com>
        <20230201100350.23263-2-Jonathan.Cameron@huawei.com>
Date:   Wed, 01 Feb 2023 13:14:06 +0100
In-Reply-To: <20230201100350.23263-2-Jonathan.Cameron@huawei.com> (Jonathan
        Cameron via's message of "Wed, 1 Feb 2023 10:03:48 +0000")
Message-ID: <87k011y44x.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron via <qemu-devel@nongnu.org> writes:

> Inject poison using qmp command cxl-inject-poison to add an entry to the
> poison list.
>
> For now, the poison is not returned CXL.mem reads, but only via the
> mailbox command Get Poison List.
>
> See CXL rev 3.0, sec 8.2.9.8.4.1 Get Poison list (Opcode 4300h)
>
> Kernel patches to use this interface here:
> https://lore.kernel.org/linux-cxl/cover.1665606782.git.alison.schofield@intel.com/
>
> To inject poison using qmp (telnet to the qmp port)
> { "execute": "qmp_capabilities" }
>
> { "execute": "cxl-inject-poison",
>     "arguments": {
>          "path": "/machine/peripheral/cxl-pmem0",
>          "start": 2048,
>          "length": 256
>     }
> }
>
> Adjusted to select a device on your machine.
>
> Note that the poison list supported is kept short enough to avoid the
> complexity of state machine that is needed to handle the MORE flag.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

[...]

> diff --git a/qapi/cxl.json b/qapi/cxl.json
> index 3c18556ee8..5b995db255 100644
> --- a/qapi/cxl.json
> +++ b/qapi/cxl.json

There is no qapi/cxl.json in current master.  So this must be based on
some other patch(es).  Please point to it in the cover letter.  I like
to point both in human-readable and machine-readable form, e.g. like
this:

    Based on my "[PATCH 00/22] qapi: Remove simple unions from the schema
    language".

    Based-on: Message-Id: <20210913123932.3306639-1-armbru@redhat.com>

> @@ -5,6 +5,17 @@
>  # = CXL devices
>  ##
>  
> +##
> +# @cxl-inject-poison:
> +#
> +# @path: CXL type 3 device canonical QOM path
> +#
> +# @start: Start address
> +# @length: Length of poison to inject

Either separate all the arguments with blank lines, or none.

> +##
> +{ 'command': 'cxl-inject-poison',
> +  'data': { 'path': 'str', 'start': 'uint64', 'length': 'uint64' }}
> +
>  ##
>  # @CxlUncorErrorType:
>  #

Both commit message and doc comment are rather terse.

The commit message should make the case for the feature: why do we want
it?  This typically involves explaining the problem(s) it solves.

The doc comment ideally explains intended use.

