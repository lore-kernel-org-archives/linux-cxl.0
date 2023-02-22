Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C27EC61DA4
	for <linux-cxl@archiver.kernel.org>; Wed, 22 Feb 2023 18:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232401AbjBVS3y (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 22 Feb 2023 13:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbjBVS3y (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 22 Feb 2023 13:29:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E93834C3A
        for <linux-cxl@vger.kernel.org>; Wed, 22 Feb 2023 10:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677090538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=b0zMOWQrn1EHqDPtEHLXu4pS81jBjb8D5Oqw5wMkmEI=;
        b=AH/vZB2PVGXS6u5wj5ogDX2cr13S8mcwSVXaxIUcLIG+43TWTrikgvogtcYdwr0lpHiUvh
        Ag2AMwlcBXX5kCKdRDgf5yLpa9Ymbgc/enAAaPYUn4MD+pia2FUfunVRdKZqQ1H/7zI0nV
        AmezVGfmrpBB9cTwisgtIBz6G4B6Cco=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-137-mFmNc895P_qSF7vYvo_8lA-1; Wed, 22 Feb 2023 13:28:56 -0500
X-MC-Unique: mFmNc895P_qSF7vYvo_8lA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1D54B280AA28;
        Wed, 22 Feb 2023 18:28:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D089E492B00;
        Wed, 22 Feb 2023 18:28:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
        id B171D21E6A1F; Wed, 22 Feb 2023 19:28:54 +0100 (CET)
From:   Markus Armbruster <armbru@redhat.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v5 8/8] hw/mem/cxl_type3: Add CXL RAS Error Injection
 Support.
References: <20230221152145.9736-1-Jonathan.Cameron@huawei.com>
        <20230221152145.9736-9-Jonathan.Cameron@huawei.com>
        <e432cebc-8faa-7b41-71c8-ea88c7bcbb04@linaro.org>
        <20230222145330.000021ef@huawei.com>
Date:   Wed, 22 Feb 2023 19:28:54 +0100
In-Reply-To: <20230222145330.000021ef@huawei.com> (Jonathan Cameron's message
        of "Wed, 22 Feb 2023 14:53:30 +0000")
Message-ID: <877cw9k109.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> On Tue, 21 Feb 2023 23:15:49 +0100
> Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> wrote:
>
>> Hi Jonathan,
>>=20
>> On 21/2/23 16:21, Jonathan Cameron wrote:
>> > CXL uses PCI AER Internal errors to signal to the host that an error h=
as
>> > occurred. The host can then read more detailed status from the CXL RAS
>> > capability.
>> >=20
>> > For uncorrectable errors: support multiple injection in one operation
>> > as this is needed to reliably test multiple header logging support in =
an
>> > OS. The equivalent feature doesn't exist for correctable errors, so on=
ly
>> > one error need be injected at a time.
>> >=20
>> > Note:
>> >   - Header content needs to be manually specified in a fashion that
>> >     matches the specification for what can be in the header for each
>> >     error type.
>> >=20
>> > Injection via QMP:
>> > { "execute": "qmp_capabilities" }
>> > ...
>> > { "execute": "cxl-inject-uncorrectable-errors",
>> >    "arguments": {
>> >      "path": "/machine/peripheral/cxl-pmem0",
>> >      "errors": [
>> >          {
>> >              "type": "cache-address-parity",
>> >              "header": [ 3, 4]
>> >          },
>> >          {
>> >              "type": "cache-data-parity",
>> >              "header": [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18=
,19,20,21,22,23,24,25,26,27,28,29,30,31]
>> >          },
>> >          {
>> >              "type": "internal",
>> >              "header": [ 1, 2, 4]
>> >          }
>> >          ]
>> >    }}
>> > ...
>> > { "execute": "cxl-inject-correctable-error",
>> >      "arguments": {
>> >          "path": "/machine/peripheral/cxl-pmem0",
>> >          "type": "physical"
>> >      } }
>> >=20
>> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>
> Hi Philippe,
>
> Thanks for your review.  One question inline.
>
>> > +#
>> > +# Type of uncorrectable CXL error to inject. These errors are reporte=
d via
>> > +# an AER uncorrectable internal error with additional information log=
ged at
>> > +# the CXL device.
>> > +#
>> > +# @cache-data-parity: Data error such as data parity or data ECC erro=
r CXL.cache
>> > +# @cache-address-parity: Address parity or other errors associated wi=
th the
>> > +#                        address field on CXL.cache
>> > +# @cache-be-parity: Byte enable parity or other byte enable errors on=
 CXL.cache
>> > +# @cache-data-ecc: ECC error on CXL.cache
>> > +# @mem-data-parity: Data error such as data parity or data ECC error =
on CXL.mem
>> > +# @mem-address-parity: Address parity or other errors associated with=
 the
>> > +#                      address field on CXL.mem
>> > +# @mem-be-parity: Byte enable parity or other byte enable errors on C=
XL.mem.
>> > +# @mem-data-ecc: Data ECC error on CXL.mem.
>> > +# @reinit-threshold: REINIT threshold hit.
>> > +# @rsvd-encoding: Received unrecognized encoding.
>> > +# @poison-received: Received poison from the peer.
>> > +# @receiver-overflow: Buffer overflows (first 3 bits of header log in=
dicate which)
>> > +# @internal: Component specific error
>> > +# @cxl-ide-tx: Integrity and data encryption tx error.
>> > +# @cxl-ide-rx: Integrity and data encryption rx error.
>> > +##
>> > +
>> > +{ 'enum': 'CxlUncorErrorType',=20=20
>>=20
>> Doesn't these need
>>=20
>>       'if': 'CONFIG_CXL_MEM_DEVICE',
>>=20
>> ?
>
> If I make this change I get a bunch of
>
> ./qapi/qapi-types-cxl.h:18:13: error: attempt to use poisoned "CONFIG_CXL=
_MEM_DEVICE"
>    18 | #if defined(CONFIG_CXL_MEM_DEVICE)

This means you're trying to use target-dependent stuff in
target-independent code.

Have a look at the thread

    Subject: Can we unpoison CONFIG_FOO macros?
    Message-ID: <87lel9o56z.fsf@pond.sub.org>
    https://lists.gnu.org/archive/html/qemu-devel/2023-02/msg01885.html

and if questions remain, ask them right here.

> It's a target specific define (I think) as built alongside PCI_EXPRESS
> Only CXL_ACPI is specifically included by x86 and arm64 (out of tree)
>
> To be honest though I don't fully understand the QEMU build system so the=
 reason
> for the error might be wrong.

[...]

