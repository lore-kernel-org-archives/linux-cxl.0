Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3994A20B17
	for <linux-cxl@vger.kernel.org>; Tue, 31 Oct 2023 17:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B99B4
	for <linux-cxl@vger.kernel.org>; Tue, 31 Oct 2023 10:55:28 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SKd5174Wsz67byx;
	Wed,  1 Nov 2023 01:52:21 +0800 (CST)
Received: from localhost (10.195.246.117) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 31 Oct
 2023 17:55:25 +0000
Date: Tue, 31 Oct 2023 17:55:22 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Markus Armbruster <armbru@redhat.com>
CC: <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>, Ben Widawsky
	<bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
	Ira Weiny <ira.weiny@intel.com>, Gregory Price <gourry.memverge@gmail.com>,
	Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, "Mike
 Maslenkin" <mike.maslenkin@gmail.com>, Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v5 8/8] hw/mem/cxl_type3: Add CXL RAS Error Injection
 Support.
Message-ID: <20231031175522.00006073@Huawei.com>
In-Reply-To: <87cyx04qcw.fsf@pond.sub.org>
References: <20230221152145.9736-1-Jonathan.Cameron@huawei.com>
	<20230221152145.9736-9-Jonathan.Cameron@huawei.com>
	<87cyx04qcw.fsf@pond.sub.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.246.117]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected

On Fri, 27 Oct 2023 06:54:39 +0200
Markus Armbruster <armbru@redhat.com> wrote:

> I'm trying to fill in QMP documentation holes, and found one in commit
> 415442a1b4a (this patch).  Details inline.
> 
> Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:
> 
> > CXL uses PCI AER Internal errors to signal to the host that an error has
> > occurred. The host can then read more detailed status from the CXL RAS
> > capability.
> >
> > For uncorrectable errors: support multiple injection in one operation
> > as this is needed to reliably test multiple header logging support in an
> > OS. The equivalent feature doesn't exist for correctable errors, so only
> > one error need be injected at a time.
> >
> > Note:
> >  - Header content needs to be manually specified in a fashion that
> >    matches the specification for what can be in the header for each
> >    error type.
> >
> > Injection via QMP:
> > { "execute": "qmp_capabilities" }
> > ...
> > { "execute": "cxl-inject-uncorrectable-errors",
> >   "arguments": {
> >     "path": "/machine/peripheral/cxl-pmem0",
> >     "errors": [
> >         {
> >             "type": "cache-address-parity",
> >             "header": [ 3, 4]
> >         },
> >         {
> >             "type": "cache-data-parity",
> >             "header": [0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31]
> >         },
> >         {
> >             "type": "internal",
> >             "header": [ 1, 2, 4]
> >         }
> >         ]
> >   }}
> > ...
> > { "execute": "cxl-inject-correctable-error",
> >     "arguments": {
> >         "path": "/machine/peripheral/cxl-pmem0",
> >         "type": "physical"
> >     } }
> >
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> 
> [...]
> 
> > diff --git a/qapi/cxl.json b/qapi/cxl.json
> > new file mode 100644
> > index 0000000000..ac7e167fa2
> > --- /dev/null
> > +++ b/qapi/cxl.json
> > @@ -0,0 +1,118 @@
> > +# -*- Mode: Python -*-
> > +# vim: filetype=python
> > +
> > +##
> > +# = CXL devices
> > +##
> > +
> > +##
> > +# @CxlUncorErrorType:
> > +#
> > +# Type of uncorrectable CXL error to inject. These errors are reported via
> > +# an AER uncorrectable internal error with additional information logged at
> > +# the CXL device.
> > +#
> > +# @cache-data-parity: Data error such as data parity or data ECC error CXL.cache
> > +# @cache-address-parity: Address parity or other errors associated with the
> > +#                        address field on CXL.cache
> > +# @cache-be-parity: Byte enable parity or other byte enable errors on CXL.cache
> > +# @cache-data-ecc: ECC error on CXL.cache
> > +# @mem-data-parity: Data error such as data parity or data ECC error on CXL.mem
> > +# @mem-address-parity: Address parity or other errors associated with the
> > +#                      address field on CXL.mem
> > +# @mem-be-parity: Byte enable parity or other byte enable errors on CXL.mem.
> > +# @mem-data-ecc: Data ECC error on CXL.mem.
> > +# @reinit-threshold: REINIT threshold hit.
> > +# @rsvd-encoding: Received unrecognized encoding.
> > +# @poison-received: Received poison from the peer.
> > +# @receiver-overflow: Buffer overflows (first 3 bits of header log indicate which)
> > +# @internal: Component specific error
> > +# @cxl-ide-tx: Integrity and data encryption tx error.
> > +# @cxl-ide-rx: Integrity and data encryption rx error.
> > +##
> > +
> > +{ 'enum': 'CxlUncorErrorType',
> > +  'data': ['cache-data-parity',
> > +           'cache-address-parity',
> > +           'cache-be-parity',
> > +           'cache-data-ecc',
> > +           'mem-data-parity',
> > +           'mem-address-parity',
> > +           'mem-be-parity',
> > +           'mem-data-ecc',
> > +           'reinit-threshold',
> > +           'rsvd-encoding',
> > +           'poison-received',
> > +           'receiver-overflow',
> > +           'internal',
> > +           'cxl-ide-tx',
> > +           'cxl-ide-rx'
> > +           ]
> > + }
> > +
> > +##
> > +# @CXLUncorErrorRecord:
> > +#
> > +# Record of a single error including header log.
> > +#
> > +# @type: Type of error
> > +# @header: 16 DWORD of header.
> > +##
> > +{ 'struct': 'CXLUncorErrorRecord',
> > +  'data': {
> > +      'type': 'CxlUncorErrorType',
> > +      'header': [ 'uint32' ]
> > +  }
> > +}
> > +
> > +##
> > +# @cxl-inject-uncorrectable-errors:
> > +#
> > +# Command to allow injection of multiple errors in one go. This allows testing
> > +# of multiple header log handling in the OS.
> > +#
> > +# @path: CXL Type 3 device canonical QOM path
> > +# @errors: Errors to inject
> > +##
> > +{ 'command': 'cxl-inject-uncorrectable-errors',
> > +  'data': { 'path': 'str',
> > +             'errors': [ 'CXLUncorErrorRecord' ] }}
> > +
> > +##
> > +# @CxlCorErrorType:
> > +#
> > +# Type of CXL correctable error to inject
> > +#
> > +# @cache-data-ecc: Data ECC error on CXL.cache
> > +# @mem-data-ecc: Data ECC error on CXL.mem  
> 
> Missing:
> 
>    # @retry-threshold: ...
> 
> I need suitable description text.  Can you help me?

Spec says:
"Retry Threshold Hit. (NUM_RETRY>=MAX_NUM_RETRY).
See Section 4.2.8.5.1 for the definitions of NUM_RETRY and MAX_NUM_RETRY."

Following the reference:
"NUM_RETRY: This counter is used to count the number of RETRY.Req requests
sent to retry the same flit. The counter remains enabled during the whole retry
sequence (state is not RETRY_LOCAL_NORMAL). It is reset to 0 at initialization. It is
also reset to 0 when a RETRY.Ack sequence is received with the Empty bit set or
whenever the LRSM state is RETRY_LOCAL_NORMAL and an error-free retryable flit
is received. The counter is incremented whenever the LRSM state changes from
RETRY_LLRREQ to RETRY_LOCAL_IDLE. If the counter reaches a threshold (called
MAX_NUM_RETRY), then the local retry state machine transitions to the
RETRY_PHY_REINIT. The NUM_RETRY counter is also reset when the Physical layer
exits from LTSSM recovery state (the LRSM transition through RETRY_PHY_REINIT
to RETRY_LLRREQ)."

So based on my failure to understand much of that beyond it has something
to do with low level retries, maybe just

"Number of times the retry threshold was hit."

Thanks for tidying this up!
?


> 
> > +# @crc-threshold: Component specific and applicable to 68 byte Flit mode only.
> > +# @cache-poison-received: Received poison from a peer on CXL.cache.
> > +# @mem-poison-received: Received poison from a peer on CXL.mem
> > +# @physical: Received error indication from the physical layer.
> > +##
> > +{ 'enum': 'CxlCorErrorType',
> > +  'data': ['cache-data-ecc',
> > +           'mem-data-ecc',
> > +           'crc-threshold',
> > +           'retry-threshold',
> > +           'cache-poison-received',
> > +           'mem-poison-received',
> > +           'physical']
> > +}
> > +
> > +##
> > +# @cxl-inject-correctable-error:
> > +#
> > +# Command to inject a single correctable error.  Multiple error injection
> > +# of this error type is not interesting as there is no associated header log.
> > +# These errors are reported via AER as a correctable internal error, with
> > +# additional detail available from the CXL device.
> > +#
> > +# @path: CXL Type 3 device canonical QOM path
> > +# @type: Type of error.
> > +##
> > +{ 'command': 'cxl-inject-correctable-error',
> > +  'data': { 'path': 'str',
> > +            'type': 'CxlCorErrorType'
> > +  }
> > +}  
> 
> [...]
> 
> 

