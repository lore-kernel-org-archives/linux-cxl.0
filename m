Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EB0C64ED6
	for <linux-cxl@archiver.kernel.org>; Mon, 27 Feb 2023 09:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjB0JlB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 27 Feb 2023 04:41:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjB0JlA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 27 Feb 2023 04:41:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD09D529
        for <linux-cxl@vger.kernel.org>; Mon, 27 Feb 2023 01:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677490812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CUMRnTDeR7CwtfWw5lJqv4Nxr13L7OiZY8PPWakXYE8=;
        b=X8uYGfTw3Qyhm++jlYSDhM87Y/JbOa4EN1b3AWCOnjkbmqeEEroNuW+W52A2GxqBRB2a01
        FWnv7FslpQi93c9hd2zTyENOxCQGQsHs8IOARB+P+Df84qjzOSwBYGzZgXE/uhYKEi7HSu
        9eYhZJyzLvi6fxSbrhxA4UDlM+Oh21s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-264-FN9PLIq2OZuyMoqypPs7Tw-1; Mon, 27 Feb 2023 04:40:09 -0500
X-MC-Unique: FN9PLIq2OZuyMoqypPs7Tw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BADAC101157B;
        Mon, 27 Feb 2023 09:40:08 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.88])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1562D404BEC5;
        Mon, 27 Feb 2023 09:40:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
        id 2357221E6A1F; Mon, 27 Feb 2023 10:40:07 +0100 (CET)
From:   Markus Armbruster <armbru@redhat.com>
To:     Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
        Michael Tsirkin <mst@redhat.com>,
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
        <875ybsg7cl.fsf@pond.sub.org> <20230223142748.0000662f@huawei.com>
        <45b86050-0f0b-d222-c32f-9d6f23246574@linaro.org>
Date:   Mon, 27 Feb 2023 10:40:07 +0100
In-Reply-To: <45b86050-0f0b-d222-c32f-9d6f23246574@linaro.org> ("Philippe
        =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 24 Feb 2023 20:02:59
 +0100")
Message-ID: <87sfertpjc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> On 23/2/23 15:27, Jonathan Cameron wrote:
>> On Thu, 23 Feb 2023 08:37:46 +0100
>> Markus Armbruster <armbru@redhat.com> wrote:
>>> Whenever you use a poisoned macro in a conditional, all the code
>>> generated for this .json file (we call it a "QAPI schema module")
>>> becomes target-dependent.  The QAPI code generator itself is blissfully
>>> unaware of this.
>>>
>>> Since target-dependent code needs to be compiled differently, the build
>>> process needs to be know which modules are target-dependent.  We do this
>>> in one of the stupidest ways that could possibly work: a module is
>>> target-dependent if its name ends with "-target".  There are just two
>>> right now: qapi/machine-target.json and qapi/misc-target.json.
>>>
>>> The logic resides in qapi/meson.build.  Look for
>>>
>>>      if module.endswith('-target')
>>
>> Thanks for all the pointers.
>>
>>> Questions?
>>>
>> Is it sensible to make the cxl stuff all target dependent and do the fol=
lowing?
>> I like that we can get rid of the stubs if we do this but I'm sure there=
 are
>> disadvantages. Only alternative I can currently see is continue to have
>> stubs and not make the qmp commands conditional on them doing anything u=
seful.
>
> I still don't understand what is the target-dependent part of CXL.
>
> IIUC CXL depends on PCIe which isn't target dependent.

As far as I can tell, the target-dependent part of CXL is the macro
CONFIG_CXL :)

Consider a device model implemented in perfectly target-independent
code, to be linked only into some qemu-system-TARGET.  How do we do
that?

We put a 'config FOO' section in the appropriate Kconfig, and select it
from the target's Kconfig for the targets that want it.  We add device
model sources to Meson source set softmmu_ss when CONFIG_FOO.

This puts CONFIG_FOO=3Dy into the TARGET-softmmu-config-devices.mak, and
#define CONFIG_FOO 1 into TARGET-softmmu-config-devices.h.  It also puts
#pragma GCC poison CONFIG_FOO into config-poison.h.

Note the two CONFIG_FOO have subtly different meaning:

* The make variable means "there is an enabled target that has FOO
  enabled".  It gets propagated to Meson.

* The C macro means "the current target has FOO enabled".  It therefore
  must not be used in target-independent code.  That's why we poison it
  in config-poison.h.

Note that the device model code has no use for C macro CONFIG_FOO.  It
remains target-independent as it should.

Now consider how to have the QAPI schema provide something for FOO.

If we make it a QAPI schema module of its own, we can arrange for it to
be linked only into the qemu-system-TARGET that have the device model,
just like the device model code.  We haven't tried this for individual
devices, only for whole subsystems like PCI.

If we don't make it a module of its own, we have two choices:

* We use 'if': 'CONFIG_FOO'.  This is actually the C macro.  The module
  becomes target-dependent.  We compile the code generated for the
  module separately for each target.

* We make it unconditional.  The module can remain target-independent.
  The code generated for FOO's QAPI schema is linked unconditionally,
  even when the target doesn't need it.  Any references to handwritten
  FOO code need to be satisfied with stubs.

I dislike both.  Existing usage seems to prefer "unconditional schema".
Sticking to that is okay.

