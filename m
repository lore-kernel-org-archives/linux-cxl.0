Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3262C77B7C
	for <linux-cxl@archiver.kernel.org>; Fri, 26 May 2023 20:33:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjEZUdw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 26 May 2023 16:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbjEZUdv (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 26 May 2023 16:33:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37488F3
        for <linux-cxl@vger.kernel.org>; Fri, 26 May 2023 13:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685133174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=w88dKxOFNphCNTDyDzXNErgI1kj2Vs8SaWD8y1A2bPs=;
        b=cLo2TJCxapI+Gdhn9MzDcWHUycScyeJx5KoRvgfu4tR0tFJi5A5adOrK8ZGZ3dFiiXV7dq
        jYDf9W1koNghoK8CWAPAG3tAgOKzFpLi7hqhwvzxcX4AjQjjb0xKo9CE2IS+GPP8VoRia5
        aFdzMdM/OXyOxejRDJWK453sXG/0LJ8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-15-xl_oM-rdMRuwrqcHNI6L4A-1; Fri, 26 May 2023 16:32:49 -0400
X-MC-Unique: xl_oM-rdMRuwrqcHNI6L4A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 393571C01510;
        Fri, 26 May 2023 20:32:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7DFD9C154D1;
        Fri, 26 May 2023 20:32:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
        id 8538A21E692E; Fri, 26 May 2023 22:32:47 +0200 (CEST)
From:   Markus Armbruster <armbru@redhat.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Markus Armbruster <armbru@redhat.com>, <qemu-devel@nongnu.org>,
        Michael Tsirkin <mst@redhat.com>, Fan Ni <fan.ni@samsung.com>,
        <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>,
        =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
        Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v7 7/7] hw/cxl/events: Add injection of Memory Module
 Events
References: <20230522150947.11546-1-Jonathan.Cameron@huawei.com>
        <20230522150947.11546-8-Jonathan.Cameron@huawei.com>
        <87h6rz8bnj.fsf@pond.sub.org> <20230526181004.0000512d@Huawei.com>
Date:   Fri, 26 May 2023 22:32:47 +0200
In-Reply-To: <20230526181004.0000512d@Huawei.com> (Jonathan Cameron's message
        of "Fri, 26 May 2023 18:10:04 +0100")
Message-ID: <87jzwu6dg0.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:

>> > +# @temperature: Device temperature in degrees Celsius.
>> > +#
>> > +# @dirty-shutdown-count: Number of time the device has been unable to  
>> 
>> Number of times
>> 
>> > +#                        determine whether data loss may have occurred.
>> > +#
>> > +# @corrected-volatile-error-count: Total number of correctable errors in
>> > +#                                  volatile memory.
>> > +#
>> > +# @corrected-persistent-error-count: Total number correctable errors in
>> > +#                                    persistent memory  
>> 
>> Please format like
>> 
>>    # @flags: Event Record Flags.  See CXL r3.0 Table 8-42 Common Event
>>    #     Record Format, Event Record Flags for subfield definitions.
>>    #
>>    # @type: Device Event Type.  See CXL r3.0 Table 8-45 Memory Module
>>    #     Event Record for bit definitions for bit definiions.
>>    #
>>    # @health-status: Overall health summary bitmap.  See CXL r3.0 Table
>>    #     8-100 Get Health Info Output Payload, Health Status for bit
>>    #     definitions.
>>    #
>>    # @media-status: Overall media health summary.  See CXL r3.0 Table
>>    #     8-100 Get Health Info Output Payload, Media Status for bit
>>    #     definitions.
>>    #
>>    # @additional-status: See CXL r3.0 Table 8-100 Get Health Info Output
>>    #     Payload, Additional Status for subfield definitions.
>>    #
>>    # @life-used: Percentage (0-100) of factory expected life span.
>>    #
>>    # @temperature: Device temperature in degrees Celsius.
>>    #
>>    # @dirty-shutdown-count: Number of time the device has been unable to
>>    #     determine whether data loss may have occurred.
>
> With "Number of times" this runs to 71 chars. reflowed appropriately for v8

Appreciated!

>>    #
>>    # @corrected-volatile-error-count: Total number of correctable errors
>>    #     in volatile memory.
>>    #
>>    # @corrected-persistent-error-count: Total number correctable errors
>>    #     in persistent memory
>> 
>> to blend in with recent commit a937b6aa739 (qapi: Reformat doc comments
>> to conform to current conventions).
>> 
>> 
>> > +#

