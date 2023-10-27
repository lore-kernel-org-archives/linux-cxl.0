Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB285229
	for <linux-cxl@vger.kernel.org>; Fri, 27 Oct 2023 04:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G5D0UumM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57721A5
	for <linux-cxl@vger.kernel.org>; Thu, 26 Oct 2023 21:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698382486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JXU12W74l0p2mPMfL7ENCLXIUzlfAykoAwVejTIauLA=;
	b=G5D0UumMQJajNrzD9CF3U21iFQ1dQq4eVb/Lv4mYgErc03K5g7TJBs6HxzEVYR1TZym3zC
	g5xMq3cIvKU++Htx7jD9lMbpUajSwzUYN7h3YTE3/Vi0THqh7xGzoWZ90A+et8/t5iqPp5
	ou5GefveXU6qRZXOpC4q6sdOdiDBbdk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-a90SgPT1NJeNuDFsTI5z4Q-1; Fri, 27 Oct 2023 00:54:41 -0400
X-MC-Unique: a90SgPT1NJeNuDFsTI5z4Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD9FF811760;
	Fri, 27 Oct 2023 04:54:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 386711121314;
	Fri, 27 Oct 2023 04:54:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id 2B61121E6A1F; Fri, 27 Oct 2023 06:54:39 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: <qemu-devel@nongnu.org>,  Michael Tsirkin <mst@redhat.com>,  Ben
 Widawsky <bwidawsk@kernel.org>,  <linux-cxl@vger.kernel.org>,
  <linuxarm@huawei.com>,  Ira Weiny <ira.weiny@intel.com>,  Gregory Price
 <gourry.memverge@gmail.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
  Mike Maslenkin <mike.maslenkin@gmail.com>,  Dave Jiang
 <dave.jiang@intel.com>
Subject: Re: [PATCH v5 8/8] hw/mem/cxl_type3: Add CXL RAS Error Injection
 Support.
References: <20230221152145.9736-1-Jonathan.Cameron@huawei.com>
	<20230221152145.9736-9-Jonathan.Cameron@huawei.com>
Date: Fri, 27 Oct 2023 06:54:39 +0200
In-Reply-To: <20230221152145.9736-9-Jonathan.Cameron@huawei.com> (Jonathan
	Cameron's message of "Tue, 21 Feb 2023 15:21:45 +0000")
Message-ID: <87cyx04qcw.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

I'm trying to fill in QMP documentation holes, and found one in commit
415442a1b4a (this patch).  Details inline.

Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> CXL uses PCI AER Internal errors to signal to the host that an error has
> occurred. The host can then read more detailed status from the CXL RAS
> capability.
>
> For uncorrectable errors: support multiple injection in one operation
> as this is needed to reliably test multiple header logging support in an
> OS. The equivalent feature doesn't exist for correctable errors, so only
> one error need be injected at a time.
>
> Note:
>  - Header content needs to be manually specified in a fashion that
>    matches the specification for what can be in the header for each
>    error type.
>
> Injection via QMP:
> { "execute": "qmp_capabilities" }
> ...
> { "execute": "cxl-inject-uncorrectable-errors",
>   "arguments": {
>     "path": "/machine/peripheral/cxl-pmem0",
>     "errors": [
>         {
>             "type": "cache-address-parity",
>             "header": [ 3, 4]
>         },
>         {
>             "type": "cache-data-parity",
>             "header": [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]
>         },
>         {
>             "type": "internal",
>             "header": [ 1, 2, 4]
>         }
>         ]
>   }}
> ...
> { "execute": "cxl-inject-correctable-error",
>     "arguments": {
>         "path": "/machine/peripheral/cxl-pmem0",
>         "type": "physical"
>     } }
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

[...]

> diff --git a/qapi/cxl.json b/qapi/cxl.json
> new file mode 100644
> index 0000000000..ac7e167fa2
> --- /dev/null
> +++ b/qapi/cxl.json
> @@ -0,0 +1,118 @@
> +# -*- Mode: Python -*-
> +# vim: filetype=python
> +
> +##
> +# = CXL devices
> +##
> +
> +##
> +# @CxlUncorErrorType:
> +#
> +# Type of uncorrectable CXL error to inject. These errors are reported via
> +# an AER uncorrectable internal error with additional information logged at
> +# the CXL device.
> +#
> +# @cache-data-parity: Data error such as data parity or data ECC error CXL.cache
> +# @cache-address-parity: Address parity or other errors associated with the
> +#                        address field on CXL.cache
> +# @cache-be-parity: Byte enable parity or other byte enable errors on CXL.cache
> +# @cache-data-ecc: ECC error on CXL.cache
> +# @mem-data-parity: Data error such as data parity or data ECC error on CXL.mem
> +# @mem-address-parity: Address parity or other errors associated with the
> +#                      address field on CXL.mem
> +# @mem-be-parity: Byte enable parity or other byte enable errors on CXL.mem.
> +# @mem-data-ecc: Data ECC error on CXL.mem.
> +# @reinit-threshold: REINIT threshold hit.
> +# @rsvd-encoding: Received unrecognized encoding.
> +# @poison-received: Received poison from the peer.
> +# @receiver-overflow: Buffer overflows (first 3 bits of header log indicate which)
> +# @internal: Component specific error
> +# @cxl-ide-tx: Integrity and data encryption tx error.
> +# @cxl-ide-rx: Integrity and data encryption rx error.
> +##
> +
> +{ 'enum': 'CxlUncorErrorType',
> +  'data': ['cache-data-parity',
> +           'cache-address-parity',
> +           'cache-be-parity',
> +           'cache-data-ecc',
> +           'mem-data-parity',
> +           'mem-address-parity',
> +           'mem-be-parity',
> +           'mem-data-ecc',
> +           'reinit-threshold',
> +           'rsvd-encoding',
> +           'poison-received',
> +           'receiver-overflow',
> +           'internal',
> +           'cxl-ide-tx',
> +           'cxl-ide-rx'
> +           ]
> + }
> +
> +##
> +# @CXLUncorErrorRecord:
> +#
> +# Record of a single error including header log.
> +#
> +# @type: Type of error
> +# @header: 16 DWORD of header.
> +##
> +{ 'struct': 'CXLUncorErrorRecord',
> +  'data': {
> +      'type': 'CxlUncorErrorType',
> +      'header': [ 'uint32' ]
> +  }
> +}
> +
> +##
> +# @cxl-inject-uncorrectable-errors:
> +#
> +# Command to allow injection of multiple errors in one go. This allows testing
> +# of multiple header log handling in the OS.
> +#
> +# @path: CXL Type 3 device canonical QOM path
> +# @errors: Errors to inject
> +##
> +{ 'command': 'cxl-inject-uncorrectable-errors',
> +  'data': { 'path': 'str',
> +             'errors': [ 'CXLUncorErrorRecord' ] }}
> +
> +##
> +# @CxlCorErrorType:
> +#
> +# Type of CXL correctable error to inject
> +#
> +# @cache-data-ecc: Data ECC error on CXL.cache
> +# @mem-data-ecc: Data ECC error on CXL.mem

Missing:

   # @retry-threshold: ...

I need suitable description text.  Can you help me?

> +# @crc-threshold: Component specific and applicable to 68 byte Flit mode only.
> +# @cache-poison-received: Received poison from a peer on CXL.cache.
> +# @mem-poison-received: Received poison from a peer on CXL.mem
> +# @physical: Received error indication from the physical layer.
> +##
> +{ 'enum': 'CxlCorErrorType',
> +  'data': ['cache-data-ecc',
> +           'mem-data-ecc',
> +           'crc-threshold',
> +           'retry-threshold',
> +           'cache-poison-received',
> +           'mem-poison-received',
> +           'physical']
> +}
> +
> +##
> +# @cxl-inject-correctable-error:
> +#
> +# Command to inject a single correctable error.  Multiple error injection
> +# of this error type is not interesting as there is no associated header log.
> +# These errors are reported via AER as a correctable internal error, with
> +# additional detail available from the CXL device.
> +#
> +# @path: CXL Type 3 device canonical QOM path
> +# @type: Type of error.
> +##
> +{ 'command': 'cxl-inject-correctable-error',
> +  'data': { 'path': 'str',
> +            'type': 'CxlCorErrorType'
> +  }
> +}

[...]

