Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEB0C64ED6
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Feb 2023 14:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbjB1OIS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 28 Feb 2023 09:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbjB1OIR (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 28 Feb 2023 09:08:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28202B62F
        for <linux-cxl@vger.kernel.org>; Tue, 28 Feb 2023 06:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677593255;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zrSnzj74ag5YU6Mp0Ke3cUH/yv6D2ccbvO/ENkpWNco=;
        b=L7aoA9T2XlNA8iQgkq/6J24BhcFU2QgdMjIxAWZSsqFmyvXIq0lRgg3TLCltTwF2yxfI+c
        NmhBoY2GpJ4DEV2EgLxuYKYm9BaT9ZZPgJMaGLR2BvjTEvQK2WQXPTz8HDSqIAqC8hdHGf
        cYXsWvSVL8e4r5+aW/aNLkKEqiN34ME=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-144-SfokZVGQNsmXWZz8vYdz7Q-1; Tue, 28 Feb 2023 09:07:33 -0500
X-MC-Unique: SfokZVGQNsmXWZz8vYdz7Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 75E08863194;
        Tue, 28 Feb 2023 14:07:25 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.92])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F9E9492B12;
        Tue, 28 Feb 2023 14:07:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
        id 4D1A921E6A1F; Tue, 28 Feb 2023 15:07:24 +0100 (CET)
From:   Markus Armbruster <armbru@redhat.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: Re: [PATCH] MAINTAINERS: Add Fan Ni as Compute eXpress Link QEMU
 reviewer
References: <20230228113926.11485-1-Jonathan.Cameron@huawei.com>
Date:   Tue, 28 Feb 2023 15:07:24 +0100
In-Reply-To: <20230228113926.11485-1-Jonathan.Cameron@huawei.com> (Jonathan
        Cameron's message of "Tue, 28 Feb 2023 11:39:26 +0000")
Message-ID: <87r0u9g9yb.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> Fan Ni has offered to help out with QEMU CXL emulation reviewing.
> Add him as a designated reviewer.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> --
> Thanks to Fan for stepping up after I requested help following Ben
> stepping down as co-maintainer. Fan base been active in testing
> and review recently so great to have Fan on board.
>
> Based on patch [PATCH] MAINTAINERS: Remove CXL maintainer Ben Widawsky
>
> Based-of: Message-id: 20230220212437.1462314-1-armbru@redhat.com

Glad you found a co-maintainer!

Acked-by: Markus Armbruster <armbru@redhat.com>

