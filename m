Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9EBC05027
	for <linux-cxl@archiver.kernel.org>; Wed,  1 Feb 2023 16:11:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232973AbjBAQLH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Feb 2023 11:11:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232418AbjBAQLG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 1 Feb 2023 11:11:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2E414497
        for <linux-cxl@vger.kernel.org>; Wed,  1 Feb 2023 08:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675267815;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=wOTNJx5WI6Wit4VB+7pbs9T4NqXqlhP40cuIIK7nTCg=;
        b=R7RQ6wxn2oprRRVmETYrC45hhNhpvDK5FOwlL19bfrsMD5HeshH7tO6N9wFJgZd75ifs6i
        9tdBuWdMK4/OcEGbxPQc+/SkzsUnzlfPwD8e4Uh60PvBxsU/qxf7MGHy9REnTFcWDJZwPb
        1DtPsa3jNVjS7vkcJqbevhYMCAVxDck=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-220-1_kXdODYNuSpTt-QR02mTw-1; Wed, 01 Feb 2023 11:10:12 -0500
X-MC-Unique: 1_kXdODYNuSpTt-QR02mTw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C67F818E0046;
        Wed,  1 Feb 2023 16:10:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.70])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A1CFAC16020;
        Wed,  1 Feb 2023 16:10:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
        id 850FC21E6A1F; Wed,  1 Feb 2023 17:10:09 +0100 (CET)
From:   Markus Armbruster <armbru@redhat.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Jonathan Cameron via <qemu-devel@nongnu.org>,
        Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: Re: [RFC PATCH v2 1/3] hw/cxl: QMP based poison injection support
References: <20230201100350.23263-1-Jonathan.Cameron@huawei.com>
        <20230201100350.23263-2-Jonathan.Cameron@huawei.com>
        <87k011y44x.fsf@pond.sub.org> <20230201144512.00007b64@Huawei.com>
Date:   Wed, 01 Feb 2023 17:10:09 +0100
In-Reply-To: <20230201144512.00007b64@Huawei.com> (Jonathan Cameron's message
        of "Wed, 1 Feb 2023 14:45:12 +0000")
Message-ID: <87zg9xs6xq.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:

> On Wed, 01 Feb 2023 13:14:06 +0100
> Markus Armbruster <armbru@redhat.com> wrote:

[...]

>> Both commit message and doc comment are rather terse.
>> 
>> The commit message should make the case for the feature: why do we want
>> it?  This typically involves explaining the problem(s) it solves.
>> 
>> The doc comment ideally explains intended use.
>
> OK. I'll expand on this. It'll be a bit of fuzzy text that
> boils down to we emulate so we can test the OS does the right thing
> when it gets poison related events. I can add some generic fluff on
> why a real device might implement this in the first place though
> I'm not sure that will even matter to anyone reading these docs.

Use your judgement :)

