Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7291867
	for <linux-cxl@vger.kernel.org>; Thu,  2 Nov 2023 06:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ElzJC4+0"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC305123
	for <linux-cxl@vger.kernel.org>; Wed,  1 Nov 2023 23:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698907640;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nucy7gxmH41/FHqntnLqAHDiWR5JRODW5yWghjMQdw0=;
	b=ElzJC4+0c61AzuWqHy1O+48WS/tE38jq4WuZb6xJNdYEdMmIWKtUjsPrZp3uVVSFn/4F5/
	jXBIU/9ZqB/drFcbe5jDPozPSFrORl6QAk8a5OUHYdIyTVwVYaUlAjxF/Sb/gm1FVAIDdI
	PhsKqmemOQ05DQz6tFcPFHuajHvQ9kk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-1ZPNLuTLOtWNrQGZml7XVw-1; Thu,
 02 Nov 2023 02:47:17 -0400
X-MC-Unique: 1ZPNLuTLOtWNrQGZml7XVw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C9D203822E8A;
	Thu,  2 Nov 2023 06:47:16 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 105D424C6;
	Thu,  2 Nov 2023 06:47:16 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 03F1121E6A1F; Thu,  2 Nov 2023 07:47:15 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: <qemu-devel@nongnu.org>,  Michael Tsirkin <mst@redhat.com>,  Ben
 Widawsky <bwidawsk@kernel.org>,  <linux-cxl@vger.kernel.org>,
  <linuxarm@huawei.com>,  Ira Weiny <ira.weiny@intel.com>,  Gregory Price
 <gourry.memverge@gmail.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
  "Mike Maslenkin" <mike.maslenkin@gmail.com>,  Dave Jiang
 <dave.jiang@intel.com>
Subject: Re: [PATCH v5 8/8] hw/mem/cxl_type3: Add CXL RAS Error Injection
 Support.
References: <20230221152145.9736-1-Jonathan.Cameron@huawei.com>
	<20230221152145.9736-9-Jonathan.Cameron@huawei.com>
	<87cyx04qcw.fsf@pond.sub.org> <20231031175522.00006073@Huawei.com>
Date: Thu, 02 Nov 2023 07:47:14 +0100
In-Reply-To: <20231031175522.00006073@Huawei.com> (Jonathan Cameron's message
	of "Tue, 31 Oct 2023 17:55:22 +0000")
Message-ID: <87wmv0d53h.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:

> On Fri, 27 Oct 2023 06:54:39 +0200
> Markus Armbruster <armbru@redhat.com> wrote:
>
>> I'm trying to fill in QMP documentation holes, and found one in commit
>> 415442a1b4a (this patch).  Details inline.
>> 
>> Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:
>> 
>> > CXL uses PCI AER Internal errors to signal to the host that an error has
>> > occurred. The host can then read more detailed status from the CXL RAS
>> > capability.
>> >
>> > For uncorrectable errors: support multiple injection in one operation
>> > as this is needed to reliably test multiple header logging support in an
>> > OS. The equivalent feature doesn't exist for correctable errors, so only
>> > one error need be injected at a time.
>> >
>> > Note:
>> >  - Header content needs to be manually specified in a fashion that
>> >    matches the specification for what can be in the header for each
>> >    error type.
>> >
>> > Injection via QMP:
>> > { "execute": "qmp_capabilities" }
>> > ...
>> > { "execute": "cxl-inject-uncorrectable-errors",
>> >   "arguments": {
>> >     "path": "/machine/peripheral/cxl-pmem0",
>> >     "errors": [
>> >         {
>> >             "type": "cache-address-parity",
>> >             "header": [ 3, 4]
>> >         },
>> >         {
>> >             "type": "cache-data-parity",
>> >             "header": [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]
>> >         },
>> >         {
>> >             "type": "internal",
>> >             "header": [ 1, 2, 4]
>> >         }
>> >         ]
>> >   }}
>> > ...
>> > { "execute": "cxl-inject-correctable-error",
>> >     "arguments": {
>> >         "path": "/machine/peripheral/cxl-pmem0",
>> >         "type": "physical"
>> >     } }
>> >
>> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
>> 
>> [...]
>> 
>> > diff --git a/qapi/cxl.json b/qapi/cxl.json
>> > new file mode 100644
>> > index 0000000000..ac7e167fa2
>> > --- /dev/null
>> > +++ b/qapi/cxl.json
>> > @@ -0,0 +1,118 @@
>> > +# -*- Mode: Python -*-
>> > +# vim: filetype=python
>> > +
>> > +##
>> > +# = CXL devices
>> > +##
>> > +
>> > +##
>> > +# @CxlUncorErrorType:
>> > +#
>> > +# Type of uncorrectable CXL error to inject. These errors are reported via
>> > +# an AER uncorrectable internal error with additional information logged at
>> > +# the CXL device.
>> > +#
>> > +# @cache-data-parity: Data error such as data parity or data ECC error CXL.cache
>> > +# @cache-address-parity: Address parity or other errors associated with the
>> > +#                        address field on CXL.cache
>> > +# @cache-be-parity: Byte enable parity or other byte enable errors on CXL.cache
>> > +# @cache-data-ecc: ECC error on CXL.cache
>> > +# @mem-data-parity: Data error such as data parity or data ECC error on CXL.mem
>> > +# @mem-address-parity: Address parity or other errors associated with the
>> > +#                      address field on CXL.mem
>> > +# @mem-be-parity: Byte enable parity or other byte enable errors on CXL.mem.
>> > +# @mem-data-ecc: Data ECC error on CXL.mem.
>> > +# @reinit-threshold: REINIT threshold hit.
>> > +# @rsvd-encoding: Received unrecognized encoding.
>> > +# @poison-received: Received poison from the peer.
>> > +# @receiver-overflow: Buffer overflows (first 3 bits of header log indicate which)
>> > +# @internal: Component specific error
>> > +# @cxl-ide-tx: Integrity and data encryption tx error.
>> > +# @cxl-ide-rx: Integrity and data encryption rx error.
>> > +##
>> > +
>> > +{ 'enum': 'CxlUncorErrorType',
>> > +  'data': ['cache-data-parity',
>> > +           'cache-address-parity',
>> > +           'cache-be-parity',
>> > +           'cache-data-ecc',
>> > +           'mem-data-parity',
>> > +           'mem-address-parity',
>> > +           'mem-be-parity',
>> > +           'mem-data-ecc',
>> > +           'reinit-threshold',
>> > +           'rsvd-encoding',
>> > +           'poison-received',
>> > +           'receiver-overflow',
>> > +           'internal',
>> > +           'cxl-ide-tx',
>> > +           'cxl-ide-rx'
>> > +           ]
>> > + }
>> > +
>> > +##
>> > +# @CXLUncorErrorRecord:
>> > +#
>> > +# Record of a single error including header log.
>> > +#
>> > +# @type: Type of error
>> > +# @header: 16 DWORD of header.
>> > +##
>> > +{ 'struct': 'CXLUncorErrorRecord',
>> > +  'data': {
>> > +      'type': 'CxlUncorErrorType',
>> > +      'header': [ 'uint32' ]
>> > +  }
>> > +}
>> > +
>> > +##
>> > +# @cxl-inject-uncorrectable-errors:
>> > +#
>> > +# Command to allow injection of multiple errors in one go. This allows testing
>> > +# of multiple header log handling in the OS.
>> > +#
>> > +# @path: CXL Type 3 device canonical QOM path
>> > +# @errors: Errors to inject
>> > +##
>> > +{ 'command': 'cxl-inject-uncorrectable-errors',
>> > +  'data': { 'path': 'str',
>> > +             'errors': [ 'CXLUncorErrorRecord' ] }}
>> > +
>> > +##
>> > +# @CxlCorErrorType:
>> > +#
>> > +# Type of CXL correctable error to inject
>> > +#
>> > +# @cache-data-ecc: Data ECC error on CXL.cache
>> > +# @mem-data-ecc: Data ECC error on CXL.mem  
>> 
>> Missing:
>> 
>>    # @retry-threshold: ...
>> 
>> I need suitable description text.  Can you help me?
>
> Spec says:
> "Retry Threshold Hit. (NUM_RETRY>=MAX_NUM_RETRY).
> See Section 4.2.8.5.1 for the definitions of NUM_RETRY and MAX_NUM_RETRY."
>
> Following the reference:
> "NUM_RETRY: This counter is used to count the number of RETRY.Req requests
> sent to retry the same flit. The counter remains enabled during the whole retry
> sequence (state is not RETRY_LOCAL_NORMAL). It is reset to 0 at initialization. It is
> also reset to 0 when a RETRY.Ack sequence is received with the Empty bit set or
> whenever the LRSM state is RETRY_LOCAL_NORMAL and an error-free retryable flit
> is received. The counter is incremented whenever the LRSM state changes from
> RETRY_LLRREQ to RETRY_LOCAL_IDLE. If the counter reaches a threshold (called
> MAX_NUM_RETRY), then the local retry state machine transitions to the
> RETRY_PHY_REINIT. The NUM_RETRY counter is also reset when the Physical layer
> exits from LTSSM recovery state (the LRSM transition through RETRY_PHY_REINIT
> to RETRY_LLRREQ)."
>
> So based on my failure to understand much of that beyond it has something
> to do with low level retries, maybe just
>
> "Number of times the retry threshold was hit."

Sold!  Thanks for your help.

> Thanks for tidying this up!

You're welcome!

I intend post the patch as part of a series filling in documentation
holes all over the place.  Will take some time, I'm afraid.

[...]

