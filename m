Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EA81C6379F
	for <linux-cxl@archiver.kernel.org>; Thu, 23 Feb 2023 07:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjBWHik (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 23 Feb 2023 02:38:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjBWHik (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 23 Feb 2023 02:38:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018751E5F3
        for <linux-cxl@vger.kernel.org>; Wed, 22 Feb 2023 23:37:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677137872;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uH+1Sqo4hVXnBusAKLLJtA0XYKW3rMDEl8RZR2Cxk1w=;
        b=A7VLl8SjkZyyHJGX2bt988G3AWOAoEPVTzvjUixxxOvzAjBHG4HSmBxOWoXnEY/kp+t8d+
        1I38EopPrcSVO/YtCyncd/6CGFFraWL9nI5WcULXPzLGMbyKkjl+PTIy4dRm2WIgar4vft
        Z0zwHaDO1i1pfwskt/qzssi1uOi0unk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-8Kl7AwByOp2hbB9YKbSgww-1; Thu, 23 Feb 2023 02:37:48 -0500
X-MC-Unique: 8Kl7AwByOp2hbB9YKbSgww-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6358E80351F;
        Thu, 23 Feb 2023 07:37:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3EE812026D38;
        Thu, 23 Feb 2023 07:37:47 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
        id 3804621E6A1F; Thu, 23 Feb 2023 08:37:46 +0100 (CET)
From:   Markus Armbruster <armbru@redhat.com>
To:     Thomas Huth <thuth@redhat.com>
Cc:     Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        qemu-devel@nongnu.org, Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>, linux-cxl@vger.kernel.org,
        linuxarm@huawei.com, Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Subject: Re: [PATCH v5 8/8] hw/mem/cxl_type3: Add CXL RAS Error Injection
 Support.
References: <20230221152145.9736-1-Jonathan.Cameron@huawei.com>
        <20230221152145.9736-9-Jonathan.Cameron@huawei.com>
        <e432cebc-8faa-7b41-71c8-ea88c7bcbb04@linaro.org>
        <20230222145330.000021ef@huawei.com>
        <c2fb77b0-0734-3be5-1b54-7c797b3daa15@linaro.org>
        <20230222164947.0000554f@Huawei.com>
        <b9bd5698-1f73-b912-0344-4b70c30dd02a@linaro.org>
        <586d040f-d712-905e-fd68-bcde3713478b@redhat.com>
Date:   Thu, 23 Feb 2023 08:37:46 +0100
In-Reply-To: <586d040f-d712-905e-fd68-bcde3713478b@redhat.com> (Thomas Huth's
        message of "Thu, 23 Feb 2023 07:58:18 +0100")
Message-ID: <875ybsg7cl.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Thomas Huth <thuth@redhat.com> writes:

> On 22/02/2023 19.16, Philippe Mathieu-Daud=C3=A9 wrote:
>> +Thomas (meson) & Marc-Andr=C3=A9 (conditional QAPI)
>
> + Markus
>
>> On 22/2/23 17:49, Jonathan Cameron wrote:

[...]

>>>>>> Doesn't these need
>>>>>>
>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 'if': 'CONFIG_CXL_MEM_DEV=
ICE',
>>>>>>
>>>>>> ?
>>>>>
>>>>> If I make this change I get a bunch of
>>>>>
>>>>> ./qapi/qapi-types-cxl.h:18:13: error: attempt to use poisoned "CONFIG=
_CXL_MEM_DEVICE"
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 18 | #if defined(CONFIG_CXL_MEM_DEVICE)
>>>>
>>>> Err, I meant the generic CONFIG_CXL, not CONFIG_CXL_MEM_DEVICE.
>>>>
>>>>> It's a target specific define (I think) as built alongside PCI_EXPRESS
>>>>> Only CXL_ACPI is specifically included by x86 and arm64 (out of tree)
>>>>>
>>>>> To be honest though I don't fully understand the QEMU build system so=
 the reason
>>>>> for the error might be wrong.
>>>>
>>>> You need to restrict to system emulation (the 'have_system' check):
>>>
>>> This doesn't help - still have
>>> attempt to used poisoned "CONFIG_CXL"
>
> Not sure how the QAPI generator works, but target specific config switche=
s can only be used in target specific json files there, so that's machine-t=
arget.json and misc-target.json currently, as far as I know. Not sure how t=
he QAPI generator distinguishes between common and target specific code, th=
ough ... just by the "-target" suffix? Maybe Markus or Marc-Andr=C3=A9 can =
comment on that.

Whenever you use a poisoned macro in a conditional, all the code
generated for this .json file (we call it a "QAPI schema module")
becomes target-dependent.  The QAPI code generator itself is blissfully
unaware of this.

Since target-dependent code needs to be compiled differently, the build
process needs to be know which modules are target-dependent.  We do this
in one of the stupidest ways that could possibly work: a module is
target-dependent if its name ends with "-target".  There are just two
right now: qapi/machine-target.json and qapi/misc-target.json.

The logic resides in qapi/meson.build.  Look for

    if module.endswith('-target')

Questions?

[...]

